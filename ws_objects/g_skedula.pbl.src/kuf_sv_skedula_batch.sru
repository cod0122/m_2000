$PBExportHeader$kuf_sv_skedula_batch.sru
forward
global type kuf_sv_skedula_batch from kuf_parent
end type
end forward

global type kuf_sv_skedula_batch from kuf_parent
string ki_msgerroggetto = "valore"
end type
global kuf_sv_skedula_batch kuf_sv_skedula_batch

type variables
//
private st_esito kist_esito 
private st_sv_skedula kist_sv_skedula
private st_sv_eventi_sked kist_sv_eventi_sked []

end variables

forward prototypes
public function st_esito genera_eventi ()
public function st_esito u_batch_run () throws uo_exception
public subroutine tb_insert_schedula_eventi ()
private function st_esito tb_aggiorna_stato_sv_skedula_1 (string k_stato_orig, string k_stato_agg)
public function st_esito tb_aggiorna_stato_sv_skedula ()
end prototypes

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
kuf_utility kuf1_utility
st_esito kst_esito

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


	setpointer(kkg.pointer_attesa )

	kuf1_utility = create kuf_utility

//--- prendi data oggi		
	k_dataoggi = kGuf_data_base.prendi_dataora( )
	
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
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Errore durante la creazione della tabella.~r~n " &
			 + trim(kist_esito.SQLErrText)
		kist_esito.esito = kkg_esito.blok
		
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
		choose case kist_sv_skedula.flag_run_giorni 
				
			case "8"   // estemporanea
		
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
				
			case "M"   // primo del mese
			case "N"   // Ultimo giorno del mese
				k_giorno = integer((kist_sv_skedula.rilancia_dopo_mm / 60) / 24)	
				k_data = date(k_dataoggi )
				if kist_sv_skedula.flag_run_giorni = "M" then
					k_data = date(year(k_data), month(k_data), 01)
				else
					k_data = kuf1_utility.u_data_get_lastmonthday(k_data)
				end if
				k_secondi = (kist_sv_skedula.rilancia_dopo_mm - k_giorno * 24 * 60 ) * 60
				k_run_ora = time(kist_sv_skedula.orario)
				k_run_ora = relativetime ( k_run_ora, k_secondi )
				
				kist_sv_eventi_sked[1].run_giorno = k_data
				kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 
				kist_sv_eventi_sked[1].run_datetime = datetime(kist_sv_eventi_sked[1].run_giorno, time(kist_sv_eventi_sked[1].run_ora + ":00"))
//--- inserisco nuovo evento						
				tb_insert_schedula_eventi()
				if kist_esito.esito = kkg_esito.ok then
					k_eventi_insert++
				end if

				
			case else   // lunedì - domenica

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
									kst_esito = tb_aggiorna_stato_sv_skedula()
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
//										kst_esito = tb_aggiorna_stato_sv_skedula()
	
										end if
									end if
								end if
								
//--- calcola l'orario successivo da skedulare								
								k_run_ora = relativetime ( k_run_ora, k_secondi )
								
							loop
							
						end if
						
					end if	
					
				next	

			end choose

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
			kst_esito = tb_aggiorna_stato_sv_skedula_1('1', '5')
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	
	end if


	if k_eventi_insert > 0 then
		kist_esito.sqlcode = k_eventi_insert
		kist_esito.SQLErrText =  &
			 "Inseriti " + string (k_eventi_insert) &
			+ " eventi in schedulazione. Operazione terminata."
		kist_esito.esito = kkg_esito.ok
	else
		kist_esito.sqlcode = 999
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Nessun evento schedulato. "
		kist_esito.esito = kkg_esito.blok
	end if


catch (uo_exception kuo_exception)
	kist_esito = kuo_exception.get_st_esito()
		
finally 
	if isvalid(kuf1_utility) then destroy kuf1_utility
				
	if kist_esito.esito <> kkg_esito.ok and kist_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kist_esito.scrivi_log = true
		kguo_exception.set_esito(kist_esito)
	end if

	setpointer(kkg.pointer_default)

		
end try


return kist_esito


end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Rigenera TUTTI gli Eventi 
	kst_esito = this.genera_eventi()
	if kst_esito.esito = kkg_esito.ok then
		kst_esito.SQLErrText = "Generati eventi di schedulazione. " + trim(kst_esito.sqlerrtext)
	else
		kst_esito.SQLErrText = "Errore in generazione eventi di schedulazione. " + trim(kst_esito.sqlerrtext) &
					+ "; codice errore: " + string(kst_esito.sqlcode) + "."
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
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
		using kguo_sqlca_db_magazzino;
    
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kist_esito.SQLErrText = "Tab.Schedulazioni Eventi (sv_eventi_sked):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kist_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
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
		using kguo_sqlca_db_magazzino;

    
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Schedulazioni Eventi (sv_skedula):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
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
		using kguo_sqlca_db_magazzino;

    
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Schedulazioni Eventi (sv_skedula):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
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

on kuf_sv_skedula_batch.create
call super::create
end on

on kuf_sv_skedula_batch.destroy
call super::destroy
end on

