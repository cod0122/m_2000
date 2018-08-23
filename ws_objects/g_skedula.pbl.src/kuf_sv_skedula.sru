$PBExportHeader$kuf_sv_skedula.sru
forward
global type kuf_sv_skedula from nonvisualobject
end type
end forward

global type kuf_sv_skedula from nonvisualobject
end type
global kuf_sv_skedula kuf_sv_skedula

type variables
//
//--- VALORI della tab sv_skedula colonna STATO:
//--- 1=pronta, da inserire tra le funzioni da schedulare 
//--- 2=sospeso
//--- 3=obsoleto
//--- 5=schedulato
//
//--- VALORI della tab sv_eventi_sked colonna STATO:
//--- 0=da eseguire
//--- 1=
//--- 2=sospeso
//--- 3=
//--- 5=in esecuzione
//--- 7=eseguito
//--- 9=non eseguito
public constant string kki_sv_eventi_sked_stato_da_eseg = "0"
public constant string kki_sv_eventi_sked_stato_sosp = "2"
public constant string kki_sv_eventi_sked_stato_in_esec = "5"
public constant string kki_sv_eventi_sked_stato_eseg = "7"
public constant string kki_sv_eventi_sked_stato_no_eseg = "9"

//--- campo se Disconnettere il DB quando gira un comando
public constant string kki_sv_eventi_sked_flag_lavora_disconnesso_SI = "1"
public constant string kki_sv_eventi_sked_flag_lavora_disconnesso_NO = "0"  //ma può essere anche a NULL

public st_sv_skedula kist_sv_skedula
public st_sv_eventi_sked kist_sv_eventi_sked []
public st_esito kist_esito 

//--- FLAG indica se DB è stato disconnesso durente le elaborazioni 
public boolean ki_db_disconnesso = false

//--- questo datastore conterra' gli eventi che devono essere lanciati
private uo_datastore_0 kids_eventi_da_lanciare
end variables

forward prototypes
public subroutine tb_delete_sv_eventi_sked ()
public subroutine tb_delete ()
public function st_esito tb_aggiorna_stato_sv_skedula ()
public function boolean ds_eventi_da_lanciare_inizializzazione ()
public subroutine tb_insert_schedula_eventi ()
private function st_esito tb_aggiorna_stato_sv_skedula_1 (string k_stato_orig, string k_stato_agg)
public function st_esito genera_eventi ()
public function st_esito tb_aggiorna_stato_sv_eventi_sked () throws uo_exception
public function st_esito get_time_evento (ref st_sv_eventi_sked kst_sv_eventi_sked)
public function boolean if_evento_da_disconnettere (st_sv_eventi_sked kst_sv_eventi_sked) throws uo_exception
public function boolean ds_eventi_da_lanciare_run () throws uo_exception
public subroutine run_eventi_sched (st_open_w kst_open_w) throws uo_exception
public function long ds_eventi_da_lanciare_retrieve () throws uo_exception
private subroutine run_eventi_sched_dos (long a_ctr) throws uo_exception
private function boolean oldds_eventi_da_lanciare_run_dos () throws uo_exception
end prototypes

public subroutine tb_delete_sv_eventi_sked ();//
//====================================================================
//=== Cancella il rek dalla tabella Eventi Schedulati
//=== 
//=== Input: var.tab.instance kist_sv_skedula_eventi[1].id
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//====================================================================



kist_esito.esito = kkg_esito.ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""
kist_esito.nome_oggetto = this.classname()

	delete from sv_eventi_sked
		where id = :kist_sv_eventi_sked[1].id
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
					+ "Tab.Eventi Schedulati (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito.db_wrn
			else
				kist_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito.ok
	end if



end subroutine

public subroutine tb_delete ();//
//====================================================================
//=== Cancella il rek dalla tabella Operazioni da Schedulare
//=== 
//=== Input: var.instance kist_sv_skedula.id
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//====================================================================



kist_esito.esito = kkg_esito.ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""
kist_esito.nome_oggetto = this.classname()

	delete from sv_skedula
		where id = :kist_sv_skedula.id
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
					+ "Tab.Schedulazioni (sv_skedula):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito.db_wrn
			else
				kist_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito.ok
	end if



end subroutine

public function st_esito tb_aggiorna_stato_sv_skedula ();//
//====================================================================
//=== Aggiorna lo stato nella tabella Operazioni da Schedulare
//=== 
//=== Input: var.instance kist_sv_skedula.id
//===                     kist_sv_skedula.stato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kist_sv_eventi_sked[1].x_datins = kGuf_data_base.prendi_x_datins( )
	kist_sv_eventi_sked[1].x_utente = kGuf_data_base.prendi_x_utente( )

//--- aggiorna lo stato Operazioni da Schedulare								
	update sv_skedula
		set stato = :kist_sv_skedula.stato
			,x_datins = :kist_sv_eventi_sked[1].x_datins
			,x_utente = :kist_sv_eventi_sked[1].x_utente
		where id = :kist_sv_skedula.id
		using sqlca;

    
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Schedulazioni Eventi (sv_skedula):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if

return kst_esito

end function

public function boolean ds_eventi_da_lanciare_inizializzazione ();//
//--- Dopo questa operazione è possibile lanciare la 'retrieve'
//
boolean k_return = false


try
//--- Verifica connessione es eventualmente la ripristina
	if kguo_sqlca_db_magazzino.db_connetti( ) then
		kids_eventi_da_lanciare.DataObject = "d_sv_eventi_sked_da_lanciare"
 
 //--- estrazione EVENTI da lanciare
		if kids_eventi_da_lanciare.SetTrans(kguo_sqlca_db_magazzino) > 0 then
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	
end try

return k_return
end function

public subroutine tb_insert_schedula_eventi ();//
//====================================================================
//=== Inserimento rek nella tabella Schedulazioni Eventi
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================



kist_esito.esito = kkg_esito.ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""
kist_esito.nome_oggetto = this.classname()


	kist_sv_eventi_sked[1].x_datins = kGuf_data_base.prendi_x_datins( )
	kist_sv_eventi_sked[1].x_utente = kGuf_data_base.prendi_x_utente( )
	// id,  
  	INSERT INTO sv_eventi_sked
         ( 
           id_sv_skedula,  
			  run_datetime,
           run_giorno,   
           run_ora,   
           stato,   
           attendi_fine, 
           id_menu_window,   
           cmd_dos,   
           esito,
			  x_datins,
			  x_utente
			  )  
  VALUES ( 
           :kist_sv_eventi_sked[1].id_sv_skedula,   
			  :kist_sv_eventi_sked[1].run_datetime,
           :kist_sv_eventi_sked[1].run_giorno,   
           :kist_sv_eventi_sked[1].run_ora,   
           :kist_sv_eventi_sked[1].stato,   
           :kist_sv_eventi_sked[1].attendi_fine,   
           :kist_sv_eventi_sked[1].id_menu_window,   
           :kist_sv_eventi_sked[1].cmd_dos,   
           :kist_sv_eventi_sked[1].esito,
			  :kist_sv_eventi_sked[1].x_datins,
			  :kist_sv_eventi_sked[1].x_utente
			  )  
		using sqlca;
    
	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = "Tab.Schedulazioni Eventi (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito.db_wrn
			else
				kist_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito.ok
	end if


end subroutine

private function st_esito tb_aggiorna_stato_sv_skedula_1 (string k_stato_orig, string k_stato_agg);//
//====================================================================
//=== Aggiorna lo stato nella tabella Operazioni da Schedulare
//=== aggiorna per 'stato' allo 'stato' indicato 
//===
//=== Input: k_stato_orig = stato di origine
//===        k_stato_agg = stato di aggiornamento
//===                    
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kist_sv_eventi_sked[1].x_datins = kGuf_data_base.prendi_x_datins( )
	kist_sv_eventi_sked[1].x_utente = kGuf_data_base.prendi_x_utente( )

//--- aggiorna lo stato Operazioni da Schedulare								
	update sv_skedula
		set stato = :k_stato_agg
			,x_datins = :kist_sv_eventi_sked[1].x_datins
			,x_utente = :kist_sv_eventi_sked[1].x_utente
		where stato = :k_stato_orig
		using sqlca;

    
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Schedulazioni Eventi (sv_skedula):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if

return kst_esito

end function

public function st_esito genera_eventi ();//
//====================================================================
//=== Genera tabella Eventi da Schedulare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:  Vedi Standard
//====================================================================
//string k_dataoggix
datetime k_dataoggi
date k_data
time k_ora_attuale, k_run_ora, k_mezzanotte
int k_giorno, k_num_gg, k_ora
long k_secondi, k_eventi_insert=0
string k_table, k_sql_w, k_sql
time k_orario_fine
pointer kpointer_1 
kuf_base kuf1_base
st_esito kst_esito, kst1_esito

try 
	kist_esito.esito = kkg_esito.ok
	kist_esito.sqlcode = 0
	kist_esito.SQLErrText = ""
	kist_esito.nome_oggetto = this.classname()
	
	DECLARE c_genera_eventi CURSOR FOR  
	  SELECT 	sv_skedula.id,
					sv_skedula.orario,   
					sv_skedula.orario_fine,   
					sv_skedula.rilancia_dopo_mm,   
					sv_skedula.flag_run_giorni,   
					sv_skedula.id_menu_window,  
					sv_skedula.cmd_dos_path,  
					sv_skedula.cmd_dos_run,  
					sv_skedula.attendi_fine  
		 FROM sv_skedula  
		 where stato = '1' or stato = '5' 
		 order by id_menu_window
		 using sqlca;


	kpointer_1 = setpointer(HourGlass!)

//--- prendi data oggi		
	k_dataoggi = kGuf_data_base.prendi_dataora( )
	
//	kuf1_base = create kuf_base
//	k_dataoggix = trim(MidA(kuf1_base.prendi_dato_base("dataoggi"), 2))
//	destroy kuf1_base
//	if isdate(k_dataoggix) then
//		k_dataoggi = date(k_dataoggix)
//	else
//		k_dataoggi = today()
//	end if

	k_ora_attuale = now()
	
//--- costruisco la tabella armo 
	k_table = "sv_eventi_sked "
	k_sql_w = " "
//	"CREATE TABLE " + trim(k_view) &
	k_sql =  &
	+ " id int identity " &
	+ " ,id_sv_skedula  int " &
	+ " ,run_datetime DATETIME" &
	+ " ,run_giorno DATE, run_ora char(6) " &
   + " ,run_giorno_start DATETIME  " &
   + " ,run_giorno_stop DATETIME  " &	
	+ " ,stato char(1) " &
	+ " ,attendi_fine char(1) " &
	+ " ,id_menu_window char(12) " &
	+ " ,cmd_dos char (200) " &
	+ " ,esito VARCHAR(255) " &
   + " ,x_datins DATETIME   " &
	+ " ,x_utente CHAR(12)  "
	kguo_sqlca_db_magazzino.db_crea_table(k_table, k_sql)		

	open c_genera_eventi;
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Errore durante la creazione della tabella.~r~n " &
			 + trim(kist_esito.SQLErrText)
		kst_esito.esito = kkg_esito.blok
		
	else
		
		fetch c_genera_eventi into 
		            :kist_sv_skedula.id
		            ,:kist_sv_skedula.orario 
		            ,:kist_sv_skedula.orario_fine 
					 	,:kist_sv_skedula.rilancia_dopo_mm 
		            ,:kist_sv_skedula.flag_run_giorni   
      			   ,:kist_sv_skedula.id_menu_window
					 	,:kist_sv_skedula.cmd_dos_path 
						,:kist_sv_skedula.cmd_dos_run  
         			,:kist_sv_skedula.attendi_fine  
						  ;
						  
		do while sqlca.sqlcode = 0 and (kist_esito.esito = kkg_esito.ok or kist_esito.esito = kkg_esito.db_wrn)


			if isnull(kist_sv_skedula.cmd_dos_path) then kist_sv_skedula.cmd_dos_path = " "
			if isnull(kist_sv_skedula.cmd_dos_run) then kist_sv_skedula.cmd_dos_run = " "
			if isnull(kist_sv_skedula.id_menu_window) then kist_sv_skedula.id_menu_window = " "
			if isnull(kist_sv_skedula.attendi_fine) then kist_sv_skedula.attendi_fine = "S"
			
			kist_sv_eventi_sked[1].cmd_dos = trim(kist_sv_skedula.cmd_dos_path) + trim(kist_sv_skedula.cmd_dos_run) 
			kist_sv_eventi_sked[1].id_menu_window = kist_sv_skedula.id_menu_window
         	kist_sv_eventi_sked[1].attendi_fine = kist_sv_skedula.attendi_fine
         	kist_sv_eventi_sked[1].stato = "0"
         	kist_sv_eventi_sked[1].esito = "caricato"
			kist_sv_eventi_sked[1].id_sv_skedula = kist_sv_skedula.id

			if istime(kist_sv_skedula.orario_fine) then
				k_orario_fine = time(kist_sv_skedula.orario_fine)
			else
				setnull(k_orario_fine)
			end if


//--- elaborazione estemporanea, cioe' all'ora stabilita + un tot di minuti
			if kist_sv_skedula.flag_run_giorni = "8" then
				
				k_giorno = integer((kist_sv_skedula.rilancia_dopo_mm / 60) / 24)	
				if k_giorno > 0 then
					k_data = relativedate ( date(k_dataoggi), k_giorno )
				else
					k_data = date( k_dataoggi )
				end if
				k_secondi = (kist_sv_skedula.rilancia_dopo_mm - k_giorno * 24 * 60 ) * 60
				k_run_ora = time(kist_sv_skedula.orario)
				k_run_ora = relativetime ( k_run_ora, k_secondi )
				kist_sv_eventi_sked[1].run_giorno = k_data
				kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 
	
				kist_sv_eventi_sked[1].run_datetime = datetime(kist_sv_eventi_sked[1].run_giorno, time(kist_sv_eventi_sked[1].run_ora + ":00"))
				
//--- se non supera l'ora richiesta	
				if k_orario_fine >= k_run_ora or isnull(k_orario_fine) then 
					
//--- nuovo evento solo se maggiore di adesso
					if kist_sv_eventi_sked[1].run_datetime > k_dataoggi then
					
//--- inserisco nuovo evento						
						tb_insert_schedula_eventi()
						if kist_esito.esito = kkg_esito.ok then
						
							k_eventi_insert++
	
						end if
					end if
					
				end if	
				
				
			else

//--- popola tabella eventi da oggi x 31 giorni avanti
				for k_giorno = 0 to 32 
	
					k_data = relativedate ( date(k_dataoggi), k_giorno )
					k_num_gg = DayNumber ( k_data ) - 1
					
//--- kist_sv_skedula.flag_run_giorni = 0 ossia tutti i giorni 
					if kist_sv_skedula.flag_run_giorni = "0" &
						or k_num_gg = integer(kist_sv_skedula.flag_run_giorni) then
				
						kist_sv_eventi_sked[1].run_giorno = k_data
						
						k_run_ora = time(kist_sv_skedula.orario)

						kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 

//--- se non supera l'ora richiesta	
						if k_orario_fine >= k_run_ora or isnull(k_orario_fine) then 

							kist_sv_eventi_sked[1].run_datetime = datetime(kist_sv_eventi_sked[1].run_giorno, time(kist_sv_eventi_sked[1].run_ora + ":00"))

//--- nuovo evento solo se maggiore di adesso
							if kist_sv_eventi_sked[1].run_datetime > k_dataoggi then

//--- inserisco nuovo evento						
								tb_insert_schedula_eventi()
								if kist_esito.esito = kkg_esito.ok then
									k_eventi_insert++
//--- aggiorna lo stato della tab schedulati
									kist_sv_skedula.stato = '5'
									kst1_esito = tb_aggiorna_stato_sv_skedula()
								end if
							end if
						end if
						
						if kist_sv_skedula.rilancia_dopo_mm > 0 then
							
							k_secondi = kist_sv_skedula.rilancia_dopo_mm * 60
							k_run_ora = relativetime ( k_run_ora, k_secondi )
							k_mezzanotte = time('23:59:59')
							
	//--- inserisce gli eventi dell'applicazione 						
							do while k_run_ora <> k_mezzanotte and (kist_esito.esito = kkg_esito.ok or kist_esito.esito = kkg_esito.db_wrn)
							
								kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 

//--- se non supera l'ora richiesta	
								if k_orario_fine >= k_run_ora or isnull(k_orario_fine) then 

									kist_sv_eventi_sked[1].run_datetime = datetime(kist_sv_eventi_sked[1].run_giorno, time(kist_sv_eventi_sked[1].run_ora + ":00"))
//--- nuovo evento solo se maggiore di adesso
									if kist_sv_eventi_sked[1].run_datetime > k_dataoggi then

//--- inserisco nuovo evento						
										tb_insert_schedula_eventi()
										if kist_esito.esito = kkg_esito.ok then
											k_eventi_insert++
									
//--- aggiorna lo stato della tab schedulati
//										kist_sv_skedula.stato = '5'
//										kst1_esito = tb_aggiorna_stato_sv_skedula()
	
										end if
									end if
								end if
								
//--- calcola l'orario successivo da skedulare								
								k_run_ora = relativetime ( k_run_ora, k_secondi )
								
							loop
							
						end if
						
					end if	
					
				next	
			end if

			fetch c_genera_eventi into 
							:kist_sv_skedula.id
							,:kist_sv_skedula.orario 
				         ,:kist_sv_skedula.orario_fine 
							,:kist_sv_skedula.rilancia_dopo_mm 
							,:kist_sv_skedula.flag_run_giorni   
							,:kist_sv_skedula.id_menu_window
							,:kist_sv_skedula.cmd_dos_path 
							,:kist_sv_skedula.cmd_dos_run  
         				,:kist_sv_skedula.attendi_fine  
						  ;
		loop


		close c_genera_eventi;

//--- aggiorna lo stato della tab schedulati
		if kist_esito.esito = kkg_esito.ok or kist_esito.esito = kkg_esito.db_wrn then
			kst1_esito = tb_aggiorna_stato_sv_skedula_1('1', '5')
			kguo_sqlca_db_magazzino.db_commit( )
		end if

				

	
	end if


	if k_eventi_insert > 0 then
		kst_esito.sqlcode = k_eventi_insert
		kst_esito.SQLErrText =  &
			 "Inseriti " + string (k_eventi_insert) &
			+ " eventi in schedulazione. Operazione terminata."
		kst_esito.esito = kkg_esito.ok
	else
		kst_esito.sqlcode = 999
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Nessun evento schedulato. "
		kst_esito.esito = kkg_esito.blok
	end if


catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
		
		
end try


return kst_esito


end function

public function st_esito tb_aggiorna_stato_sv_eventi_sked () throws uo_exception;//
//====================================================================
//=== Aggiorna lo stato nella tabella Schedulazioni Eventi
//=== 
//=== Input: var.tab.instance kist_sv_skedula_eventi[1].id
//===                         kist_sv_skedula_eventi[1].stato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
string k_stato
long k_nr_update
st_esito kst_esito
st_sv_eventi_sked kst_sv_eventi_sked


try
	
//---
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Verifica connessione es eventualmente la ripristina
	if NOT kguo_sqlca_db_magazzino.db_connetti( ) then
		kst_esito.SQLErrText = "Tentativo di Connessione non riuscito. Operazione di aggiornamento tabelle di Schedulazione non eseguito"
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception				
	end if

	kist_sv_eventi_sked[1].x_datins = kGuf_data_base.prendi_x_datins( )
	kist_sv_eventi_sked[1].x_utente = kGuf_data_base.prendi_x_utente( )

	if LenA(trim(kist_sv_eventi_sked[1].stato)) > 0 then  

//--- aggiorna lo stato tabella eventi schedulati
		if len(kist_sv_eventi_sked[1].esito) > 255 then
			kst_sv_eventi_sked.esito = left(kist_sv_eventi_sked[1].esito, 250) + "..."
		else
			kst_sv_eventi_sked.esito = kist_sv_eventi_sked[1].esito
		end if
		update sv_eventi_sked
			set stato = :kist_sv_eventi_sked[1].stato
					,esito = :kst_sv_eventi_sked.esito 
					,run_giorno_start = :kist_sv_eventi_sked[1].run_giorno_start 
					,run_giorno_stop = :kist_sv_eventi_sked[1].run_giorno_stop 
					,x_datins = :kist_sv_eventi_sked[1].x_datins
					,x_utente = :kist_sv_eventi_sked[1].x_utente
			where id = :kist_sv_eventi_sked[1].id
			using kguo_sqlca_db_magazzino ;

		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			
			kguo_sqlca_db_magazzino.db_commit()

//--- se ho appena dato l'eseguito su un evento...
			if kki_sv_eventi_sked_stato_in_esec = kist_sv_eventi_sked[1].stato then

//--- inibisco eventuali eventi precedenti oramai obsoleti			
				select id_menu_window
				       ,run_datetime
					into :kst_sv_eventi_sked.id_menu_window
						,:kst_sv_eventi_sked.run_datetime
					from sv_eventi_sked
					where id = :kist_sv_eventi_sked[1].id
					using kguo_sqlca_db_magazzino;
					
				if kguo_sqlca_db_magazzino.sqlcode >= 0 then
					kst_sv_eventi_sked.stato = kki_sv_eventi_sked_stato_no_eseg
					k_stato = kki_sv_eventi_sked_stato_da_eseg 
					kst_sv_eventi_sked.esito =  "esecuzione non necessaria (" + string(kist_sv_eventi_sked[1].x_datins) + ")"
				
					update sv_eventi_sked
							set esito = :kst_sv_eventi_sked.esito
								,stato = :kst_sv_eventi_sked.stato 
								,x_datins = :kist_sv_eventi_sked[1].x_datins
								,x_utente = :kist_sv_eventi_sked[1].x_utente
							where run_datetime < :kst_sv_eventi_sked.run_datetime
									and id_menu_window = :kst_sv_eventi_sked.id_menu_window
									and stato = :k_stato
							using kguo_sqlca_db_magazzino;

					if kguo_sqlca_db_magazzino.sqlcode = 0 then
						k_nr_update ++
					end if
				end if
			end if
		end if
	else

//--- aggiorna lo stato tabella eventi schedulati
		update sv_eventi_sked
			set esito = :kist_sv_eventi_sked[1].esito 
					,x_datins = :kist_sv_eventi_sked[1].x_datins
					,x_utente = :kist_sv_eventi_sked[1].x_utente
			where id = :kist_sv_eventi_sked[1].id
			using kguo_sqlca_db_magazzino;
		
	end if

    
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Eventi Schedulati (sv_eventi_sked) id evento: " + string(kist_sv_eventi_sked[1].id) + " errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				
				kguo_exception.inizializza( )
				kguo_exception.SetMessage ( "Errore in aggiornamento operazione Schedulata, id evento: " + string(kist_sv_eventi_sked[1].id) &
							+ "~r~n"+ trim(This.ClassName()) + "~r~n" &
							+ "Tabella sv_eventi_sked: (" + string(kguo_sqlca_db_magazzino.sqlcode) + ") " + trim(kguo_sqlca_db_magazzino.SQLErrText)) 
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				kguo_exception.set_esito(kst_esito)
		//				kuo_exception1.messaggio_utente()
				throw kguo_exception				
				
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok

	end if

	if k_nr_update > 0 then
		kguo_sqlca_db_magazzino.db_commit()
	end if
	

catch (uo_exception kuo_exception)
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_sqlca_db_magazzino.db_rollback()
	end if
	throw kuo_exception
	
end try

return kst_esito

end function

public function st_esito get_time_evento (ref st_sv_eventi_sked kst_sv_eventi_sked);//
//====================================================================
//=== Cerca l'evento ancora da lanciare in tabella Eventi Schedulati
//=== 
//=== Input:  kst_sv_skedula_eventi.id_menu_window   restituisce il record completo NON ancora schedulato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_sv_eventi_sked.stato = kki_sv_eventi_sked_stato_da_eseg

declare c_get_time_evento cursor for
     select 
           id,   
           id_sv_skedula,   
			  run_datetime,
           run_giorno,   
           run_ora,   
           stato,   
           attendi_fine, 
           cmd_dos,   
           esito 
		from  sv_eventi_sked  
		where id_menu_window = :kst_sv_eventi_sked.id_menu_window
					and stato = :kst_sv_eventi_sked.stato
		order by 
           run_datetime   
		using sqlca;


	open c_get_time_evento;

	if sqlca.sqlcode = 0 then

		fetch c_get_time_evento
			INTO :kst_sv_eventi_sked.id,   
					  :kst_sv_eventi_sked.id_sv_skedula,   
					  :kst_sv_eventi_sked.run_datetime,   
					  :kst_sv_eventi_sked.run_giorno,   
					  :kst_sv_eventi_sked.run_ora,   
					  :kst_sv_eventi_sked.stato,   
					  :kst_sv_eventi_sked.attendi_fine,   
					  :kst_sv_eventi_sked.cmd_dos,   
					  :kst_sv_eventi_sked.esito ;
	
	end if

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText =  &
					 "Ricerca Evento Schedulato " + trim(kst_sv_eventi_sked.id_menu_window) + " fallita:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if

	close c_get_time_evento;


return kst_esito
end function

public function boolean if_evento_da_disconnettere (st_sv_eventi_sked kst_sv_eventi_sked) throws uo_exception;//
//====================================================================
//=== Valuta se l'evento è da disconnettere
//=== 
//=== Input: st_sv_eventi_sked.id
//=== Out:
//=== 
//=== Ritorna tab. TRUE = db da disconnettere
//=== Lancia Eccezione 
//===                                 
//====================================================================
boolean k_return = false
st_sv_skedula kst_sv_skedula
st_esito kst_esito
uo_exception kuo_exception1


//---
//---
//---
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_sv_eventi_sked.id > 0 then  

	select distinct flag_lavora_disconnesso
		    into :kst_sv_skedula.flag_lavora_disconnesso
			from sv_eventi_sked inner join sv_skedula on sv_eventi_sked.id_sv_skedula = sv_skedula.id
			 where sv_eventi_sked.id = :kst_sv_eventi_sked.id
			using sqlca;


    
	if sqlca.sqlcode = 0 then
		
		if kst_sv_skedula.flag_lavora_disconnesso = kki_sv_eventi_sked_flag_lavora_disconnesso_SI then
			k_return = true
		end if
		
	else

		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText =  &
		          "Tab.Eventi Schedulati (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				
				kuo_exception1 = create uo_exception
				kuo_exception1.SetMessage ( "Problemi durante le operazioni in Tabella, cod.: " + string(sqlca.sqlcode)&
							+ "~r~n"+ trim(This.ClassName()) + "~r~n" + &
							 "Tab.Eventi Schedulati (sv_eventi_sked):" + trim(sqlca.SQLErrText)) 
				kuo_exception1.set_tipo(kuo_exception1.KK_st_uo_exception_tipo_dati_anomali)
				kuo_exception1.set_esito(kst_esito)
		//				kuo_exception1.messaggio_utente()
				throw kuo_exception1				
				
			end if
		end if
	end if
end if


return k_return

end function

public function boolean ds_eventi_da_lanciare_run () throws uo_exception;//
//--- Lancio applicazione M2000
//
//
boolean k_return = true
long k_righe, k_ctr, k_rc
//kuf_sv_skedula_run kuf1_sv_skedula_run
uo_exception kuo_exception2
st_esito kst_esito


ki_db_disconnesso = false

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice IVA;key2=cod.pagamento;key3=cod gruppi;key4=cod causali;
st_open_w k_st_open_w

try
		k_righe = ds_eventi_da_lanciare_retrieve()   // get elenco eventi da lanciare

		if k_righe <= 0 then
			k_return = false
		else	
	
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_modalita = kkg_flag_modalita.BATCH
			K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
			K_st_open_w.flag_leggi_dw = "N"
			K_st_open_w.key1 = " "
			K_st_open_w.key2 = " "
			K_st_open_w.key3 = " "
			K_st_open_w.flag_where = " "
	
			for k_ctr = 1 to k_righe 
				
				K_st_open_w.id_programma = kids_eventi_da_lanciare.object.id_menu_window[k_ctr] 
					  
				kist_sv_eventi_sked[1].id_menu_window = kids_eventi_da_lanciare.object.id_menu_window[k_ctr]
				kist_sv_eventi_sked[1].id = kids_eventi_da_lanciare.object.id[k_ctr] 
				kist_sv_eventi_sked[1].run_datetime = kids_eventi_da_lanciare.object.run_datetime[k_ctr] 
//				kist_sv_eventi_sked[1].run_giorno = kids_eventi_da_lanciare.object.run_giorno[k_ctr] 
				kist_sv_eventi_sked[1].run_giorno_start = kGuf_data_base.prendi_dataora() 
//				kist_sv_eventi_sked[1].run_ora = kids_eventi_da_lanciare.object.run_ora[k_ctr] 
				kist_sv_eventi_sked[1].esito = "operazione lanciata"
				kist_sv_eventi_sked[1].stato = kki_sv_eventi_sked_stato_in_esec
				
				kist_sv_eventi_sked[1].cmd_dos = trim(kids_eventi_da_lanciare.object.cmd_dos[k_ctr])
				kist_sv_eventi_sked[1].id_menu_window = kids_eventi_da_lanciare.object.id_menu_window[k_ctr]

//--- aggiornare lo stato 	
				tb_aggiorna_stato_sv_eventi_sked()	

//--- Se Comando DOS...
				if Len(trim(kids_eventi_da_lanciare.object.cmd_dos[k_ctr])) > 0 then
					
//--- Se Funzione DOS...
					run_eventi_sched_dos(K_ctr)
							
//---- Se disconesso riconnette il DB
					try
						KGuo_sqlca_db_magazzino.db_connetti()
										
	//					kids_eventi_da_lanciare.settransobject(KGuo_sqlca_db_magazzino)
						
					catch (uo_exception kuo_exception11)
						kst_esito = kuo_exception11.get_st_esito()
						kguo_exception.set_esito(kst_esito)
						destroy kuo_exception11
						//			messagebox("Problemi durante disconnessione DB~n~r", trim(kst_esito.sqlerrtext ))
							
					finally
				
					end try
							
					
				else
	
//--- Se Funzione M2000...
					K_st_open_w.key12_any = kist_sv_eventi_sked[1]
		
//--- lancio la funzione
					run_eventi_sched(k_st_open_w)
		
				end if			
				
//--- aggiornare lo stato in eseguito	
				tb_aggiorna_stato_sv_eventi_sked()             
				
//--- cancello l'evento appena lanciato			
//				kids_eventi_da_lanciare.deleterow(k_ctr)			
//				k_ctr --
//			loop while k_ctr > 0
			next

//--- Rimuovo gli eventi lanciati			
//			kids_eventi_da_lanciare.reset( )
		end if
			
	catch (uo_exception kuo_exception1)
		throw kuo_exception1		
		
	catch (RuntimeError kRuntimeError2)
		kuo_exception2 = create uo_exception
		throw kuo_exception2		
		
	finally
//		if isvalid(kuf1_sv_skedula_run) then	destroy kuf1_sv_skedula_run
//		if isvalid(kuf1_menu_window) then	destroy kuf1_menu_window
		
end try
	
	
return k_return
end function

public subroutine run_eventi_sched (st_open_w kst_open_w) throws uo_exception;//---
//--- Lancio operazioni Batch
//---
//string k_id_programma = ""
string k_string
long k_ctr, k_long=0, k_long1
st_tab_wm_pklist kst_tab_wm_pklist
kuf_pl_barcode kuf1_pl_barcode
kuf_pilota_cmd kuf1_pilota_cmd
kuf_wm_pklist_inout kuf1_wm_pklist_inout
//kuf_wm_pklist_web kuf1_wm_pklist_web
kuf_wm_pklist_file kuf1_wm_pklist_file
kuf_prof_exp kuf1_prof_exp
//kuf_prof_exp_fidi kuf1_prof_exp_fidi
//kuf_prof_imp_fidi kuf1_prof_imp_fidi
kuf_stat_batch kuf1_stat_batch
kuf_e1_inout kuf1_e1_inout
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
kuf_e1_wo_f5548014_allinea kuf1_e1_wo_f5548014_allinea
kuf_barcode_ini kuf1_barcode_ini
kuf_update_stat_batch kuf1_update_stat_batch
kuf_meca_set_data_ent kuf1_meca_set_data_ent
kuf_meca_set_e1srst kuf1_meca_set_e1srst
kuf_meca_ptmerce kuf1_meca_ptmerce
kuf_meca_chiudi kuf1_meca_chiudi
kuf_meca_reportpilota kuf1_meca_reportpilota


		try 

			kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
//			kuf1_wm_pklist_web = create kuf_wm_pklist_web
			kuf1_wm_pklist_file = create kuf_wm_pklist_file
			kuf1_prof_exp = create kuf_prof_exp
//			kuf1_prof_exp_fidi = create kuf_prof_exp_fidi
//			kuf1_prof_imp_fidi = create kuf_prof_imp_fidi
			kuf1_stat_batch = create kuf_stat_batch
			kuf1_e1_inout = create kuf_e1_inout
			kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
			kuf1_e1_wo_f5548014_allinea = create kuf_e1_wo_f5548014_allinea
			kuf1_barcode_ini = create kuf_barcode_ini
			kuf1_update_stat_batch = create kuf_update_stat_batch
			kuf1_meca_set_data_ent = create kuf_meca_set_data_ent
			kuf1_meca_set_e1srst = create kuf_meca_set_e1srst
			kuf1_meca_ptmerce = create kuf_meca_ptmerce
			kuf1_meca_chiudi = create kuf_meca_chiudi
			kuf1_meca_reportpilota = create kuf_meca_reportpilota
			
			kist_sv_eventi_sked[1] = kst_open_w.key12_any
			kist_sv_eventi_sked[1].esito = " in esecuzione..."
			tb_aggiorna_stato_sv_eventi_sked()

			kist_sv_eventi_sked[1].esito = "" 
			

//--- Get del ID PROGRAMMA da chiamare 		
			kst_open_w.id_programma = trim(lower(kst_open_w.id_programma))
			
			if kst_open_w.id_programma = "" then 
				
				kist_sv_eventi_sked[1].esito = 	"Operazione non eseguita. Funzione da eseguire non indicata. ERRORE INTERNO!! "
				
			else				
				
//--- Lancio effettivo PROGRAMMA trovato
				choose case kst_open_w.id_programma

//--- Chiudo la Procedura			
					case kkg_id_programma.EXITM2000
						post close(w_main)
					
//--- Aggiorna dati INIZIO e FINE Trattamento dal PILOTA
					case kkg_id_programma.pilota_importa_esiti
						kuf1_pl_barcode = create kuf_pl_barcode
						
						k_ctr = kuf1_pl_barcode.importa_inizio_lav_pilota("0") 
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito +=  string(k_ctr) + " barcode sono ancora in Trattamento. Operazione terminata. " 
						else
							kist_sv_eventi_sked[1].esito += "nessun barcode ha iniziato il trattamento; operazione conclusa. Funzione: " + kst_open_w.id_programma 
						end if

						k_ctr = kuf1_pl_barcode.importa_trattati_pilota("0") 
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito =  string(k_ctr) + " barcode hanno concluso il Trattamento. " 
						else
							kist_sv_eventi_sked[1].esito = "nessun barcode ha terminato il trattamento e "
						end if
	
//--- Invio Pianificazione al Pilota
					case kkg_id_programma.pilota_esporta_pl
						kuf1_pilota_cmd = create kuf_pilota_cmd
						
						if kuf1_pilota_cmd.job_pianificazione_lavorazioni() then
							kuf1_pilota_cmd.get_pilota_cfg()
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa correttamente." &
									+ "E' stato generato il file con il Piano di Lavoro nella cartella:" &
									+ kuf1_pilota_cmd.kist_tab_pilota_cfg.path_file_pl_barcode &
									+ kuf1_pilota_cmd.kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun Piano Inviato al Pilota. Funzione: " + kst_open_w.id_programma
						end if
						
					
//--- Importa Packing List da tab Receiptgammarad (Grezze dal WM)
					case kuf1_wm_pklist_inout.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_wm_pklist_inout.importa_wm_pklist_ext_tutti( ) 
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa correttamente." + "Sono stati caricati " + string(k_ctr) + " Packing-List da WM.  " 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun Packing-List da importare da WM. Funzione: " + kst_open_w.id_programma
						end if
						
						
//--- Importa Packing List XML/TXT in tab receiptgammard (del ex-WM) 
					case kuf1_wm_pklist_file.get_id_programma(kkg_flag_modalita.BATCH)
						k_long = kuf1_wm_pklist_file.importa_wm_pklist_file( ) 
						k_long1 = kuf1_wm_pklist_inout.importa_wm_pklist_ext_tutti( ) 
						if (k_long + k_long1) > 0 then
							if k_long > 0 and k_long1 > 0 then
								kist_sv_eventi_sked[1].esito = 	"Operazione conclusa correttamente." &
																	+ "Caricati " + string(k_long) + " file di Packing-List da WEB/FTP/TXT in Magazzino " & 
																	+ " e " + string(k_long1) + " Packing-List pronte per fare i Riferimenti." 
							else
								if k_long > 0  then
									kist_sv_eventi_sked[1].esito = 	"Operazione conclusa correttamente." &
																	+ "Caricati " + string(k_long) + " file di Packing-List da WEB/FTP/TXT in Magazzino."  
								else
									kist_sv_eventi_sked[1].esito = 	"Operazione conclusa correttamente." &
																	+ "Caricati " +  string(k_long1) + " Packing-List pronte per fare i Riferimenti." 
								end if
							end if
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun Packing-List WEB/FTP/TXT trovato nelle cartelle definite. Funzione: " + kst_open_w.id_programma
						end if
	

//--- Esporta Archivio x ESOLVER - CONTABILITA' FATTURE
					case kuf1_prof_exp.get_id_programma(kkg_flag_modalita.BATCH)
						k_string = kuf1_prof_exp.esolver_esporta_anag_batch( ) 
						if len(trim(k_string)) > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa. " + k_string
						else
							kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Nessun archivio 'FATTURAZIONE' esportato x la ESOLVER. Funzione: " + kst_open_w.id_programma
						end if

////--- Esporta Archivio x ESOLVER - FIDI'
//					case kuf1_prof_exp_fidi.get_id_programma(kkg_flag_modalita.BATCH)
//						k_string = kuf1_prof_exp.esolver_esporta_fidi_batch( ) 
//						if len(trim(k_string)) > 0 then
//							kist_sv_eventi_sked[1].esito = "Operazione conclusa. " + k_string
//						else
//							kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Nessun archivio FIDI esportato x ESOLVER. Funzione: " + kst_open_w.id_programma
//						end if
//
////--- Importa Archivio da ESOLVER - FIDI'
//					case kuf1_prof_imp_fidi.get_id_programma(kkg_flag_modalita.BATCH)
//						k_string = kuf1_prof_exp.esolver_importa_fuori_fido_batch( ) 
//						if len(trim(k_string)) > 0 then
//							kist_sv_eventi_sked[1].esito = "Operazione conclusa. " + k_string
//						else
//							kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Nessun archivio FIDI importato da file di ESOLVER. Funzione: " + kst_open_w.id_programma
//						end if

//--- Genera archivi STATISTICI
					case kuf1_stat_batch.get_id_programma(kkg_flag_modalita.BATCH)
						k_string = kuf1_stat_batch.run_stat_0_batch( ) 
						if len(trim(k_string)) > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa. " + k_string
						else
							kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Nessun archivio Statistici generato. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Ottimizza DB (update statistics ecc...)
					case kuf1_update_stat_batch.get_id_programma(kkg_flag_modalita.BATCH)
						k_string = kuf1_update_stat_batch.run_update_stat( ) 
						if len(trim(k_string)) > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa. " + k_string
						else
							kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Nessuna Ottimizzazione del DB effettuata. Funzione: " + kst_open_w.id_programma
						end if
		
////--- ????
//					case kuf1_e1_inout.get_id_programma(kkg_flag_modalita.BATCH)
//						k_ctr = kuf1_e1_inout.u u_set_datilav_toe1( )
//						if k_ctr > 0 then
//							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
//									+ "Sono stati inviati " + string(k_ctr) + " record dati di 'trattamento' al Sistema E-ONE" 
//						else
//							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun dato di 'trattamento' disponibile per E-ONE. Funzione: " + kst_open_w.id_programma
//						end if
						
//--- Invio dati trattamento/dosimetria a E1
					case kuf1_e1_wo_f5548014.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_e1_wo_f5548014.u_set_datilav_toe1( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati inviati " + string(k_ctr) + " record dati di 'trattamento' al Sistema E-ONE" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun dato di 'trattamento' disponibile per E-ONE. Funzione: " + kst_open_w.id_programma
						end if
//--- Allinea dati trattamento/dosimetria con E1
					case kuf1_e1_wo_f5548014_allinea.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_e1_wo_f5548014_allinea.u_allinea_datilav_e1( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati ripristinati " + string(k_ctr) + " record dati di 'trattamento' inviati in precedenza al Sistema E-ONE" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun dato di 'trattamento' inviato a E-ONE e ripristinato. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Riceve barcode generati da E1
					case kuf1_barcode_ini.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_barcode_ini.u_e1_importa_barcode_batch( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati ricevuti " + string(k_ctr) + " nuovi barcode. Dati ottenuti dal Sistema E-ONE" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessun nuovo barcode disponibile da E-ONE. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Imposta Data di entrata merce di E1 su MECA
					case kuf1_meca_set_data_ent.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_meca_set_data_ent.u_set_data_ent( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono state registrate " + string(k_ctr) + " date di entrata Lotto a magazzino. Dati ottenuti dal Sistema E-ONE" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessuna data di entrata Lotto a magazzino importata da E-ONE. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Imposta STATO Lotto di E1 su MECA
					case kuf1_meca_set_e1srst.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_meca_set_e1srst.u_set_stato_lotto_da_e1( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati aggiornati " + string(k_ctr) + " STATI Lotto di E1 (wasrst). Dati ottenuti dal Sistema E-ONE" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessuno STATO Lotto di E1 aggiornato. Dati dello STATO ottenuti da E-ONE. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Carica Avvisi Pronto Merce kuf_meca_reportpilotakuf_meca_reportpilotain tab Email da Inviare
					case kuf1_meca_ptmerce.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_meca_ptmerce.u_add_email_invio( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati caricati " + string(k_ctr) + " 'Avvisi di ritiro Pronto Merce' in tabella 'email da inviare'." 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessuno Avviso di Pronto Merce da ritirare caricato in tabella 'email da inviare'. Funzione: " + kst_open_w.id_programma
						end if
						
//--- Chiudi Lotti Spediti
					case kuf1_meca_chiudi.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_meca_chiudi.u_chiude_lotti_spediti( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati Chiusi " + string(k_ctr) + " Lotti già spediti" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Nessuno Lotto già spedito è stato Chiuso. Funzione: " + kst_open_w.id_programma
						end if

//--- Importa Report Prodotti dal PILOTA dalla cartella del Pilota a quella interna
					case kuf1_meca_reportpilota.get_id_programma(kkg_flag_modalita.BATCH)
						k_ctr = kuf1_meca_reportpilota.u_job_importa_report_pilota( )
						if k_ctr > 0 then
							kist_sv_eventi_sked[1].esito = "Operazione conclusa correttamente." &
									+ "Sono stati importati " + string(k_ctr) + " nuovi Report (pdf) prodotti dal Pilota" 
						else
							kist_sv_eventi_sked[1].esito = 	"Operazione conclusa. Non è stato trovato nessun nuovo Report generato dal Pilota. Funzione: " + kst_open_w.id_programma
						end if

//--- Funzione SCONOSCIUTA!						
					case else
						kist_sv_eventi_sked[1].esito = 	"Operazione non eseguita. Funzione " + trim(kst_open_w.id_programma) + " NON trovata (controllare funzione in Sicurezza). ERRORE INTERNO!! "
						
				end choose
			end if				

		catch (uo_exception kuo_exception)
			st_esito kst_esito
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito.not_fnd then
				kist_sv_eventi_sked[1].esito = 	"Operazione conclusa per ERRORE: " + trim(kst_esito.sqlerrtext)
			else
				kist_sv_eventi_sked[1].esito = 	"Operazione conclusa ma:  " + trim(kst_esito.sqlerrtext)
			end if
		
		
		finally

			if isvalid(kuf1_wm_pklist_inout) then destroy kuf1_wm_pklist_inout
//			if isvalid(kuf1_wm_pklist_web) then destroy kuf1_wm_pklist_web
			if isvalid(kuf1_wm_pklist_file) then destroy kuf1_wm_pklist_file
			if isvalid(kuf1_stat_batch) then destroy kuf1_stat_batch
			if isvalid(kuf1_e1_inout) then destroy kuf1_e1_inout
			if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014
			if isvalid(kuf1_e1_wo_f5548014_allinea) then destroy kuf1_e1_wo_f5548014_allinea
			if isvalid(kuf1_barcode_ini) then destroy kuf1_barcode_ini
			if isvalid(kuf1_update_stat_batch) then destroy kuf1_update_stat_batch
			if isvalid(kuf1_meca_set_data_ent) then destroy kuf1_meca_set_data_ent
			if isvalid(kuf1_meca_set_e1srst) then destroy kuf1_meca_set_e1srst
			if isvalid(kuf1_meca_ptmerce) then destroy kuf1_meca_ptmerce
			if isvalid(kuf1_meca_chiudi) then destroy kuf1_meca_chiudi
			if isvalid(kuf1_meca_reportpilota) then destroy kuf1_meca_reportpilota
			
			kist_sv_eventi_sked[1].run_giorno_stop = kGuf_data_base.prendi_dataora() 
			kist_sv_eventi_sked[1].stato = kki_sv_eventi_sked_stato_eseg
			
			
			if isvalid(	kuf1_pl_barcode) then destroy kuf1_pl_barcode
			if isvalid(	kuf1_pilota_cmd) then destroy kuf1_pilota_cmd
			
		
		end try
		

end subroutine

public function long ds_eventi_da_lanciare_retrieve () throws uo_exception;//---
//--- fare la 'inizializzazione' se non e' ancora stata fatta
//---
long k_return 
datetime k_dataoggi
time k_ora
string k_ora_x
//kuf_base kuf1_base


	try 
					
		k_dataoggi = kGuf_data_base.prendi_dataora( )
		k_return = kids_eventi_da_lanciare.retrieve(k_dataoggi, kki_sv_eventi_sked_stato_da_eseg) 

	catch (RuntimeError re)

		throw create uo_exception

	finally
//		destroy kuf1_base

	end try
	 
return k_return
end function

private subroutine run_eventi_sched_dos (long a_ctr) throws uo_exception;//---
//--- Lancio operazioni DOS
//---
//string k_id_programma = ""
int k_rc
kuf_sv_skedula_run kuf1_sv_skedula_run
st_esito kst_esito


		try 
			kuf1_sv_skedula_run = create kuf_sv_skedula_run

//--- Se non Attendere la fine del JOB allora setto i parametri	
			if kist_sv_eventi_sked[1].attendi_fine = "N" then
				kuf1_sv_skedula_run.of_set_options(false, 1)
			end if
	
//---- Richiesta disconnessione?
			if this.if_evento_da_disconnettere(kist_sv_eventi_sked[1]) then
						
//=== Se DB connesso lo CHIUDE
				if isvalid(KGuo_sqlca_db_magazzino) then
					if KGuo_sqlca_db_magazzino.DBHandle ( ) > 0 then
				
						try
							KGuo_sqlca_db_magazzino.db_disconnetti()
							ki_db_disconnesso = true
				
						catch (uo_exception kuo_exception10)
							kst_esito = kuo_exception10.get_st_esito()
							kguo_exception.set_esito(kst_esito)
							//			messagebox("Problemi durante disconnessione DB~n~r", trim(kst_esito.sqlerrtext ))
							
						finally
//									destroy kuf1_db
				
						end try
				
					end if
				end if	
				
			end if
	
			k_rc = kuf1_sv_skedula_run.of_run(trim(kids_eventi_da_lanciare.object.cmd_dos[a_ctr]), Minimized!)
	
// check return code
			CHOOSE CASE k_rc
				CASE kuf1_sv_skedula_run.WAIT_COMPLETE
					kist_sv_eventi_sked[1].esito = "operazione terminata correttamente"
				CASE kuf1_sv_skedula_run.WAIT_TIMEOUT
					kist_sv_eventi_sked[1].esito = "Time Out. Operazione interrotta, era oltre il tempo prestabilito"
				CASE ELSE
					kist_sv_eventi_sked[1].esito = "Operazione terminata con codice errore: " + String(k_rc)
			END CHOOSE


		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito.not_fnd then
				kist_sv_eventi_sked[1].esito = 	"Operazione conclusa per ERRORE: " + trim(kst_esito.sqlerrtext)
			else
				kist_sv_eventi_sked[1].esito = 	"Operazione conclusa ma:  " + trim(kst_esito.sqlerrtext)
			end if
		
		
		finally

			if isvalid(kuf1_sv_skedula_run) then destroy kuf1_sv_skedula_run
			
			kist_sv_eventi_sked[1].run_giorno_stop = kGuf_data_base.prendi_dataora() 
			kist_sv_eventi_sked[1].stato = kki_sv_eventi_sked_stato_eseg
			
		end try
		

end subroutine

private function boolean oldds_eventi_da_lanciare_run_dos () throws uo_exception;//
//--- Lancio applicazione M2000
//
//
boolean k_return = true
long k_righe, k_ctr
kuf_menu_window kuf1_menu_window
uo_exception kuo_exception2

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice IVA;key2=cod.pagamento;key3=cod gruppi;key4=cod causali;
st_open_w k_st_open_w


	try
		
		ds_eventi_da_lanciare_retrieve()
	
		k_righe = kids_eventi_da_lanciare.rowcount()
		
		if k_righe > 0 then
	
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_modalita = kkg_flag_modalita.BATCH
			K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
			K_st_open_w.flag_leggi_dw = "N"
			K_st_open_w.key1 = " "
			K_st_open_w.key2 = " "
			K_st_open_w.key3 = " "
			K_st_open_w.flag_where = " "
	
			kuf1_menu_window = create kuf_menu_window 
	
			k_ctr = k_righe
			
			do 
				
				K_st_open_w.id_programma = kids_eventi_da_lanciare.object.id_menu_window[k_ctr] 
					  
				kist_sv_eventi_sked[1].id_menu_window = kids_eventi_da_lanciare.object.id_menu_window[k_ctr]
				kist_sv_eventi_sked[1].id = kids_eventi_da_lanciare.object.id[k_ctr] 
				kist_sv_eventi_sked[1].run_datetime = kids_eventi_da_lanciare.object.run_datetime[k_ctr] 
//				kist_sv_eventi_sked[1].run_giorno = kids_eventi_da_lanciare.object.run_giorno[k_ctr] 
//				kist_sv_eventi_sked[1].run_ora = kids_eventi_da_lanciare.object.run_ora[k_ctr] 
				kist_sv_eventi_sked[1].esito = "operazione lanciata"
				kist_sv_eventi_sked[1].stato = kki_sv_eventi_sked_stato_in_esec
	//--- aggiornare lo stato in eseguito	
				tb_aggiorna_stato_sv_eventi_sked()	
	
				K_st_open_w.key12_any = kist_sv_eventi_sked[1]
	
				
	//--- lancio la funzione
				kuf1_menu_window.open_w_tabelle(k_st_open_w)
	
				
	//--- cancello l'evento appena lanciato			
				kids_eventi_da_lanciare.deleterow(k_ctr)			
	
				k_ctr --
				
			loop while k_ctr > 0
			
//			destroy kuf1_menu_window
		else	
			k_return = false
		end if
	
	
	catch (uo_exception kuo_exception1)
		throw kuo_exception1		
		
	catch (RuntimeError kRuntimeError2)
		kuo_exception2 = create uo_exception
		throw kuo_exception2		
		
	finally 
		if isvalid(kuf1_menu_window) then destroy kuf1_menu_window
	
	
	end try


return k_return
end function

on kuf_sv_skedula.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sv_skedula.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
	kids_eventi_da_lanciare = create datastore

//	kids_eventi_da_lanciare.settransobject(sqlca)

end event

event destructor;//
if isvalid(kids_eventi_da_lanciare) then destroy kids_eventi_da_lanciare


end event

