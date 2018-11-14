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
public function boolean ds_eventi_da_lanciare_inizializzazione ()
public subroutine tb_insert_schedula_eventi ()
public function st_esito tb_aggiorna_stato_sv_eventi_sked () throws uo_exception
public function st_esito get_time_evento (ref st_sv_eventi_sked kst_sv_eventi_sked)
public function boolean if_evento_da_disconnettere (st_sv_eventi_sked kst_sv_eventi_sked) throws uo_exception
public subroutine run_eventi_sched (st_open_w kst_open_w) throws uo_exception
public function long ds_eventi_da_lanciare_retrieve () throws uo_exception
private subroutine run_eventi_sched_dos (long a_ctr) throws uo_exception
public function string get_id_programma (string k_flag_modalita)
public function datetime get_run_datetime (st_sv_eventi_sked ast_sv_eventi_sked) throws uo_exception
public function integer ds_eventi_da_lanciare_run () throws uo_exception
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

public function st_esito tb_aggiorna_stato_sv_eventi_sked () throws uo_exception;//
//====================================================================
//=== Aggiorna lo stato nella tabella Schedulazioni Eventi
//=== 
//=== legge var.tab.instance kist_sv_skedula_eventi[1].id
//===                         kist_sv_skedula_eventi[1].stato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
string k_stato
long k_nr_update
st_sv_eventi_sked kst_sv_eventi_sked


try
	
//---
	kguo_exception.inizializza( )

//--- Verifica connessione es eventualmente la ripristina
	if NOT kguo_sqlca_db_magazzino.db_connetti( ) then
		kguo_exception.kist_esito.SQLErrText = "Tentativo di Connessione non riuscito. Operazione di aggiornamento tabelle di Schedulazione non eseguito"
		kguo_exception.kist_esito.esito = kkg_esito.ko
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		throw kguo_exception				
	end if

	kist_sv_eventi_sked[1].x_datins = kGuf_data_base.prendi_x_datins( )
	kist_sv_eventi_sked[1].x_utente = kGuf_data_base.prendi_x_utente( )

	if LenA(trim(kist_sv_eventi_sked[1].stato)) > 0 then  

//--- aggiorna lo stato tabella eventi schedulati
		if len(trim(kist_sv_eventi_sked[1].esito)) > 255 then
			kst_sv_eventi_sked.esito = left(trim(kist_sv_eventi_sked[1].esito), 250) + "..."
		else
			kst_sv_eventi_sked.esito = trim(kist_sv_eventi_sked[1].esito)
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

		kguo_exception.inizializza( )
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.kist_esito.SQLErrText = "Errore in aggiornamento operazione Schedulata, id evento: " + string(kist_sv_eventi_sked[1].id) &
							+ "~r~n"+ trim(This.ClassName()) + "~r~n" &
							+ "Tabella sv_eventi_sked: (" + string(kguo_sqlca_db_magazzino.sqlcode) + ") " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kguo_exception.kist_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kguo_exception.kist_esito.esito = kkg_esito.db_wrn
			else
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				throw kguo_exception				
				
			end if
		end if

	end if

	if k_nr_update > 0 then
		kguo_sqlca_db_magazzino.db_commit()
	end if
	

catch (uo_exception kuo_exception)
	kuo_exception.scrivi_log( )
	if kuo_exception.kist_esito.esito = kkg_esito.db_ko then
		kguo_sqlca_db_magazzino.db_rollback()
	end if
	throw kuo_exception
	
end try

return kguo_exception.kist_esito

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

public subroutine run_eventi_sched (st_open_w kst_open_w) throws uo_exception;//---
//--- Lancio operazioni Batch
//---
//string k_id_programma = ""
string k_string
long k_ctr, k_long=0, k_long1
st_tab_wm_pklist kst_tab_wm_pklist
st_esito kst_esito
kuf_parent kuf1_parent
kuf_menu_window kuf1_menu_window

	
	try 
		kuf1_menu_window = create kuf_menu_window

		kist_sv_eventi_sked[1] = kst_open_w.key12_any
		kist_sv_eventi_sked[1].esito = " in esecuzione..."
		tb_aggiorna_stato_sv_eventi_sked()

		kist_sv_eventi_sked[1].esito = "" 
			

//--- Get del ID PROGRAMMA da chiamare 		
		kst_open_w.id_programma = trim(lower(kst_open_w.id_programma))
			
		if kst_open_w.id_programma = "" then 
				
			kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Funzione da eseguire non indicata. ERRORE INTERNO!! "
				
		else				
				
			if trim(kst_open_w.nome_oggetto) = "" then
//--- Get nome oggetto da chiamare 		
				kst_open_w.nome_oggetto = kuf1_menu_window.get_nome_oggetto(kst_open_w.id_programma)
			end if

			if trim(kst_open_w.nome_oggetto) > " " then
				kuf1_parent = create using kst_open_w.nome_oggetto   //"kuf_prodotti"

				kst_esito = kuf1_parent.u_batch_run( )  // LANCIA LA FUNZIONE
				kist_sv_eventi_sked[1].esito = kst_esito.sqlerrtext +  " Funzione: " + kst_open_w.id_programma
//				tb_aggiorna_stato_sv_eventi_sked()
				
//--- Funzione SCONOSCIUTA!						
			else
				kist_sv_eventi_sked[1].esito = "Operazione non eseguita. Funzione " + trim(kst_open_w.id_programma) + " NON trovata (controllare funzione in Sicurezza). ERRORE INTERNO!! "
				tb_aggiorna_stato_sv_eventi_sked()
			end if
		end if				

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		if kst_esito.esito <> kkg_esito.not_fnd then
			kist_sv_eventi_sked[1].esito = 	"Operazione conclusa per ERRORE: " + trim(kst_esito.sqlerrtext)
		else
			kist_sv_eventi_sked[1].esito = 	"Operazione conclusa ma:  " + trim(kst_esito.sqlerrtext)
		end if
		tb_aggiorna_stato_sv_eventi_sked()
		
		
	finally

		if isvalid(kuf1_parent) then destroy kuf1_parent
		if isvalid(kuf1_menu_window) then destroy kuf1_menu_window
		
		kist_sv_eventi_sked[1].run_giorno_stop = kGuf_data_base.prendi_dataora() 
		kist_sv_eventi_sked[1].stato = kki_sv_eventi_sked_stato_eseg
			
	end try
		

end subroutine

public function long ds_eventi_da_lanciare_retrieve () throws uo_exception;//---
//--- 
//---
long k_return 
datetime k_dataoggi


	try 
					
		k_dataoggi = kGuf_data_base.prendi_dataora( )
		k_return = kids_eventi_da_lanciare.retrieve(k_dataoggi, kki_sv_eventi_sked_stato_da_eseg) 

	catch (RuntimeError re)
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.nome_oggetto = this.classname( )
		kguo_exception.kist_esito.sqlerrtext = "Errore di 'runtime' " + trim(re.text)
		throw kguo_exception

	finally

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

public function string get_id_programma (string k_flag_modalita);//
string k_return=""
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti


	kst_tab_menu_window_oggetti.funzione = trim(k_flag_modalita)
	kst_tab_menu_window_oggetti.nome_oggetto = trim(this.classname( ))
	if kguf_menu_window.get_id_menu_window(kst_tab_menu_window_oggetti) then

		k_return = trim(kst_tab_menu_window_oggetti.id_menu_window)
	else
		k_return = this.classname( )
	end if

return k_return
end function

public function datetime get_run_datetime (st_sv_eventi_sked ast_sv_eventi_sked) throws uo_exception;//
//====================================================================
//=== get date-time di quando lanciare l'evento
//=== 
//=== Input: st_sv_eventi_sked.id
//=== Out: run_datetime
//====================================================================
datetime k_return
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select run_datetime
		into :ast_sv_eventi_sked.run_datetime
		from sv_eventi_sked
		where id = :kist_sv_eventi_sked[1].id
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_sv_eventi_sked.run_datetime > datetime(date(0), time(0)) then
			k_return = ast_sv_eventi_sked.run_datetime
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
					+ "Errore in lettura data ora di esecuzione evento in Tab.Schedulazioni (sv_skedula): " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

catch (uo_exception kuo_exception) 
	throw kuo_exception
	
end try

return k_return
end function

public function integer ds_eventi_da_lanciare_run () throws uo_exception;//
//--- Lancio applicazione M2000
//
//
int k_return 
long k_righe, k_ctr, k_rc
st_sv_eventi_sked kst_sv_eventi_sked
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
			k_return = 0
		else	
	
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_modalita = kkg_flag_modalita.BATCH
			K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
			K_st_open_w.flag_leggi_dw = "N"
			K_st_open_w.key1 = " "
			K_st_open_w.key2 = " "
			K_st_open_w.key3 = " "
			K_st_open_w.flag_where = " "
	
			k_ctr = 1
//			for k_ctr = 1 to k_righe 
				
				K_st_open_w.id_programma = kids_eventi_da_lanciare.object.id_menu_window[k_ctr] 
					  
				kist_sv_eventi_sked[1].id_menu_window = kids_eventi_da_lanciare.object.id_menu_window[k_ctr]
				kist_sv_eventi_sked[1].id = kids_eventi_da_lanciare.object.id[k_ctr] 
				kist_sv_eventi_sked[1].run_datetime = kids_eventi_da_lanciare.object.run_datetime[k_ctr] 
				kist_sv_eventi_sked[1].run_giorno_start = kGuf_data_base.prendi_dataora() 
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
					catch (uo_exception kuo_exception11)
						kst_esito = kuo_exception11.get_st_esito()
						kguo_exception.set_esito(kst_esito)
						destroy kuo_exception11
					finally
					end try
							
				else
	
//--- Se Funzione M2000...
					K_st_open_w.key12_any = kist_sv_eventi_sked[1]
		
//--- lancio la funzione
					run_eventi_sched(k_st_open_w)
		
				end if			

//--- Verifica se la tabella schedulatore è stata rigenerata, se è così non aggiorna nulla
				kst_sv_eventi_sked.run_datetime = get_run_datetime(kist_sv_eventi_sked[1])
				if kist_sv_eventi_sked[1].run_datetime <> kst_sv_eventi_sked.run_datetime then
					// tabella rigenerata!
				else
//--- aggiornare lo stato in eseguito	
					tb_aggiorna_stato_sv_eventi_sked()             
				end if
				
			k_return = k_righe
//			next

		end if
			
	catch (uo_exception kuo_exception1)
		throw kuo_exception1		
		
	catch (RuntimeError kRuntimeError2)
		kuo_exception2 = create uo_exception
		throw kuo_exception2		
		
	finally
		
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

