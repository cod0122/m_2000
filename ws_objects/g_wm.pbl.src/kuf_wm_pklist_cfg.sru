$PBExportHeader$kuf_wm_pklist_cfg.sru
forward
global type kuf_wm_pklist_cfg from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_cfg from kuf_wm_pklist
end type
global kuf_wm_pklist_cfg kuf_wm_pklist_cfg

type variables
//---
public string ki_blocca_importa_si ="1"
public string ki_blocca_importa_no ="0"
public string ki_blocca_importa_TUTTO ="2"
public constant string ki_blocca_importa_DAM2000 ="M"

//--- valori della colonna cfg_dbms_scelta 
public constant string ki_cfg_dbms_scelta_princ = "1"
public constant string ki_cfg_dbms_scelta_muletto = "2"

end variables

forward prototypes
public function boolean get_wm_pklist_cfg (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception
public function st_esito set_ultimo_nome_file_importato (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg)
public subroutine if_isnull (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg)
public function boolean set_blocco_importazione_no () throws uo_exception
public function boolean set_blocco_importazione_si () throws uo_exception
private function boolean set_blocca_importa (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception
public function boolean get_profilo_db (ref kuo_sqlca_db_wm kuo_sqlca) throws uo_exception
public function boolean if_importadam2000 (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception
public function boolean if_importadam2000 () throws uo_exception
public function boolean if_importa_in_esecuzione () throws uo_exception
private function boolean set_importazione_ts_ini (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception
public function boolean set_importazione_ts_ini_off () throws uo_exception
public function boolean set_importazione_ts_ini_on () throws uo_exception
end prototypes

public function boolean get_wm_pklist_cfg (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception;//--
//---  Legge la tabella di configurazione del Packing List 
//---
//---  input: kst_tab_wm_pklist_cfg.codice  (il default è 1)
//---  otput: kst_tab_wm_pklist_cfg 
//---  se ERRORE lancia un Exception
//---
boolean k_return=false
st_esito kst_esito 



kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_cfg.codice = 0 or isnull(kst_tab_wm_pklist_cfg.codice) then kst_tab_wm_pklist_cfg.codice = 1
 
  SELECT wm_pklist_cfg.codice,   
         wm_pklist_cfg.blocca_importa,   
         wm_pklist_cfg.cartella_pkl_da_web,   
         wm_pklist_cfg.cartella_pkl_da_txt,   
         wm_pklist_cfg.file_esiti,   
         wm_pklist_cfg.ultimo_idimportazione,   
         wm_pklist_cfg.cfg_dbms_scelta,   
         wm_pklist_cfg.cfg_dbms,   
         wm_pklist_cfg.cfg_autocommit,   
         wm_pklist_cfg.cfg_dbparm,   
         wm_pklist_cfg.cfg_dbms_alt,   
         wm_pklist_cfg.cfg_autocommit_alt,   
         wm_pklist_cfg.cfg_dbparm_alt,  
		wm_pklist_cfg.cfg_servername,
		wm_pklist_cfg.cfg_utente,
		wm_pklist_cfg.cfg_pwd,
		wm_pklist_cfg.cfg_servername_alt,
		wm_pklist_cfg.cfg_utente_alt,
		wm_pklist_cfg.cfg_pwd_alt,
		wm_pklist_cfg.importazione_ts_ini
    INTO :kst_tab_wm_pklist_cfg.codice,   
         :kst_tab_wm_pklist_cfg.blocca_importa,   
         :kst_tab_wm_pklist_cfg.cartella_pkl_da_web,   
         :kst_tab_wm_pklist_cfg.cartella_pkl_da_txt,   
         :kst_tab_wm_pklist_cfg.file_esiti,   
         :kst_tab_wm_pklist_cfg.ultimo_idimportazione,   
         :kst_tab_wm_pklist_cfg.cfg_dbms_scelta,   
         :kst_tab_wm_pklist_cfg.cfg_dbms,   
         :kst_tab_wm_pklist_cfg.cfg_autocommit,   
         :kst_tab_wm_pklist_cfg.cfg_dbparm,   
         :kst_tab_wm_pklist_cfg.cfg_dbms_alt,   
         :kst_tab_wm_pklist_cfg.cfg_autocommit_alt,   
         :kst_tab_wm_pklist_cfg.cfg_dbparm_alt,  
		:kst_tab_wm_pklist_cfg.cfg_servername,
		:kst_tab_wm_pklist_cfg.cfg_utente,
		:kst_tab_wm_pklist_cfg.cfg_pwd,
		:kst_tab_wm_pklist_cfg.cfg_servername_alt,
		:kst_tab_wm_pklist_cfg.cfg_utente_alt,
		:kst_tab_wm_pklist_cfg.cfg_pwd_alt,
		:kst_tab_wm_pklist_cfg.importazione_ts_ini
    FROM wm_pklist_cfg  
   WHERE wm_pklist_cfg.codice = :kst_tab_wm_pklist_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		k_return=true
		
		kst_tab_wm_pklist_cfg.file_esiti = trim(kst_tab_wm_pklist_cfg.file_esiti)
		kst_tab_wm_pklist_cfg.cartella_pkl_da_web = trim(kst_tab_wm_pklist_cfg.cartella_pkl_da_web)
		if kst_tab_wm_pklist_cfg.cartella_pkl_da_web = "" then kst_tab_wm_pklist_cfg.cartella_pkl_da_web = "."
		kst_tab_wm_pklist_cfg.cartella_pkl_da_txt = trim(kst_tab_wm_pklist_cfg.cartella_pkl_da_txt)
		if kst_tab_wm_pklist_cfg.cartella_pkl_da_txt = "" then kst_tab_wm_pklist_cfg.cartella_pkl_da_txt = "."

	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Proprieta' Packing List (wm_pklist) " + string(kst_tab_wm_pklist_cfg.codice) + "~n~r  " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if




return k_return

end function

public function st_esito set_ultimo_nome_file_importato (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg);//
//====================================================================
//=== Aggiorna il campo di Ultimo ID Importato del Packing List Grezzo
//=== 
//=== Input: st_tab_wm_pklist_cfg.ultimo_idimportazione 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Modifica Proprieta' Packing-List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist_cfg.codice > 0 then
	else
		kst_tab_wm_pklist_cfg.codice = 1
	end if

	kst_tab_wm_pklist_cfg.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist_cfg.x_utente = kGuf_data_base.prendi_x_utente()
	
	update wm_pklist_cfg 
			set ultimo_idimportazione = :kst_tab_wm_pklist_cfg.ultimo_idimportazione
				,x_datins = :kst_tab_wm_pklist_cfg.x_datins
				,x_utente = :kst_tab_wm_pklist_cfg.x_utente
			WHERE codice = :kst_tab_wm_pklist_cfg.codice
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore durante la notifica 'Ultimo ID Importato' in Proprieta' Packing-List Mandante ~n~r" &
				+ " codice=" + string(kst_tab_wm_pklist_cfg.codice, "####0") + " - Nome file: " + trim(kst_tab_wm_pklist_cfg.ultimo_idimportazione) &
				+ " ~n~rErrore-tab.'wm_pklist_cfg':"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if


return kst_esito

end function

public subroutine if_isnull (ref st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_wm_pklist_cfg.codice ) then kst_tab_wm_pklist_cfg.codice  = 1
if isnull(kst_tab_wm_pklist_cfg.blocca_importa  ) then kst_tab_wm_pklist_cfg.blocca_importa = ki_blocca_importa_no
if isnull(kst_tab_wm_pklist_cfg.file_esiti ) then kst_tab_wm_pklist_cfg.file_esiti  = ""
if isnull(kst_tab_wm_pklist_cfg.cartella_pkl_da_web ) then kst_tab_wm_pklist_cfg.cartella_pkl_da_web = ""
if isnull(kst_tab_wm_pklist_cfg.ultimo_idimportazione ) then kst_tab_wm_pklist_cfg.ultimo_idimportazione = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_autocommit ) then kst_tab_wm_pklist_cfg.cfg_autocommit = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_dbms ) then kst_tab_wm_pklist_cfg.cfg_dbms = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_dbms_scelta ) then kst_tab_wm_pklist_cfg.cfg_dbms_scelta = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_dbparm ) then kst_tab_wm_pklist_cfg.cfg_dbparm = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_pwd ) then kst_tab_wm_pklist_cfg.cfg_pwd = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_servername ) then kst_tab_wm_pklist_cfg.cfg_servername = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_autocommit ) then kst_tab_wm_pklist_cfg.cfg_autocommit = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_dbms_alt ) then kst_tab_wm_pklist_cfg.cfg_dbms_alt = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_dbms_scelta ) then kst_tab_wm_pklist_cfg.cfg_dbms_scelta = "1"
if isnull(kst_tab_wm_pklist_cfg.cfg_dbparm_alt ) then kst_tab_wm_pklist_cfg.cfg_dbparm_alt = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_pwd_alt ) then kst_tab_wm_pklist_cfg.cfg_pwd_alt = ""
if isnull(kst_tab_wm_pklist_cfg.cfg_servername_alt ) then kst_tab_wm_pklist_cfg.cfg_servername_alt = ""

if isnull(kst_tab_wm_pklist_cfg.x_datins) then kst_tab_wm_pklist_cfg.x_datins = datetime(date(0))
if isnull(kst_tab_wm_pklist_cfg.x_utente) then kst_tab_wm_pklist_cfg.x_utente = " "

end subroutine

public function boolean set_blocco_importazione_no () throws uo_exception;//---
//--- Sblocca Importazione
//---
//---
boolean k_return
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


	kst_tab_wm_pklist_cfg.blocca_importa = ki_blocca_importa_no

	k_return = set_blocca_importa(kst_tab_wm_pklist_cfg)
	
	
return k_return
	
end function

public function boolean set_blocco_importazione_si () throws uo_exception;//---
//--- Blocca Importazione
//---
//---
boolean k_return
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


	kst_tab_wm_pklist_cfg.blocca_importa = ki_blocca_importa_SI

	k_return = set_blocca_importa(kst_tab_wm_pklist_cfg)
	
	
return k_return
	
end function

private function boolean set_blocca_importa (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception;//
//====================================================================
//===    SEMAFORO!!
//=== Imposta sul CFG il Blocco/Sblocco x Importazione nuovi PKLIST
//=== 
//=== Input: st_tab_wm_pklist_cfg.codice (se ZERO imposta 1),  blocca_importa (impostato a SI/NO) 
//=== Ritorna: TRUE = operazione ok      
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Modifica Proprieta' Packing-List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist_cfg.codice > 0 then
	else
		kst_tab_wm_pklist_cfg.codice = 1
	end if

	kst_tab_wm_pklist_cfg.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist_cfg.x_utente = kGuf_data_base.prendi_x_utente()
	
	
	update wm_pklist_cfg
			set  blocca_importa = :kst_tab_wm_pklist_cfg.blocca_importa
				,x_datins = :kst_tab_wm_pklist_cfg.x_datins
				,x_utente = :kst_tab_wm_pklist_cfg.x_utente
			WHERE codice = :kst_tab_wm_pklist_cfg.codice
			using sqlca;
		
	if sqlca.sqlcode < 0 then
			
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante Impostazione Blocco Importazione in Proprieta' Packing-List Mandante ~n~r" &
				+ " codice=" + string(kst_tab_wm_pklist_cfg.codice, "####0") &
				+ " ~n~rErrore-tab.'wm_pklist_cfg':"	+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
//			if sqlca.sqlcode > 0 then
//				kst_esito.esito = kkg_esito.db_wrn
//			else
				kst_esito.esito = kkg_esito.db_ko
//			end if
		end if
		
		if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
		
	end if
	
//---- COMMIT....	
	if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
		kGuf_data_base.db_commit_1( )
	end if
	
	k_return=true

//end if


return k_return

end function

public function boolean get_profilo_db (ref kuo_sqlca_db_wm kuo_sqlca) throws uo_exception;//---
//--- Torna il profilo DB x la Connessione
//---
boolean k_return = false
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


kuo_sqlca = create  kuo_sqlca_db_wm

get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- Recupera le info x la connessione
if kst_tab_wm_pklist_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	kuo_sqlca.DBMS = kst_tab_wm_pklist_cfg.cfg_dbms
	kuo_sqlca.DBParm = kst_tab_wm_pklist_cfg.cfg_dbparm
	kuo_sqlca.servername = kst_tab_wm_pklist_cfg.cfg_servername
	kuo_sqlca.logid = kst_tab_wm_pklist_cfg.cfg_utente
	kuo_sqlca.logpass = kst_tab_wm_pklist_cfg.cfg_pwd
else
	kuo_sqlca.DBMS = kst_tab_wm_pklist_cfg.cfg_dbms_alt
	kuo_sqlca.DBParm = kst_tab_wm_pklist_cfg.cfg_dbparm_alt
	kuo_sqlca.servername = kst_tab_wm_pklist_cfg.cfg_servername_alt
	kuo_sqlca.logid = kst_tab_wm_pklist_cfg.cfg_utente_alt
	kuo_sqlca.logpass = kst_tab_wm_pklist_cfg.cfg_pwd_alt
end if

//this.DBMS = profilestring ( k_file, k_sezione , "DBMS", "nessuno")
//this.DBParm = profilestring (k_file, k_sezione, "DbParm", "")
//this.Database = profilestring (k_file, k_sezione, "Database", "")
//this.UserId = profilestring (k_file, k_sezione, "UserId", "informix")
//this.DBPass = profilestring (k_file, k_sezione, "DBPass", "infoxgamma")
//this.LogPass = profilestring (k_file, k_sezione, "LogPass", "infoxgamma")
//this.LogId = profilestring (k_file, k_sezione, "LogId", "informix")
//this.ServerName = profilestring (k_file, k_sezione, "ServerName", "")
//if lower(profilestring (k_file, k_sezione, "AutoCommit", "false")) = "true" then

if kst_tab_wm_pklist_cfg.cfg_autocommit = "true" then
	kuo_sqlca.AutoCommit = true
else
	kuo_sqlca.AutoCommit = false
end if

k_return = true

return k_return 


end function

public function boolean if_importadam2000 (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception;//--
//---  Torna TRUE = importazione dei PKL da M2000 non da WMF 
//---
//---  input: st_tab_wm_pklist_cfg.codice  (il default è 1)
//---  otput: TRUE = importa PKL da M2000
//---  se ERRORE lancia un Exception
//---
boolean k_return=false
st_esito kst_esito 



kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if kst_tab_wm_pklist_cfg.codice = 0 or isnull(kst_tab_wm_pklist_cfg.codice) then kst_tab_wm_pklist_cfg.codice = 1

	kst_tab_wm_pklist_cfg.blocca_importa = ""
  	SELECT   
         wm_pklist_cfg.blocca_importa
    INTO 
         :kst_tab_wm_pklist_cfg.blocca_importa
    FROM wm_pklist_cfg  
   WHERE wm_pklist_cfg.codice = :kst_tab_wm_pklist_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then

		if kst_tab_wm_pklist_cfg.blocca_importa = ki_blocca_importa_DAM2000 then
			k_return=true
		end if
		
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura tipo IMPORTAZIONE Packing List (wm_pklist_cfg), codice: " + string(kst_tab_wm_pklist_cfg.codice) + "~n~r  " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function boolean if_importadam2000 () throws uo_exception;//--
//---  Torna TRUE = importazione dei PKL da M2000 non da WMF 
//---
//---  input: NULLA e per default st_tab_wm_pklist_cfg.codice  è 1
//---  otput: TRUE = importa PKL da M2000
//---  se ERRORE lancia un Exception
//---
boolean k_return=false
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


try
	
	k_return = if_importadam2000(kst_tab_wm_pklist_cfg)

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function boolean if_importa_in_esecuzione () throws uo_exception;//--
//---  Torna SEMAFORO dell'importazione
//---
//---  input: NULLA e per default st_tab_wm_pklist_cfg.codice  è 1
//---  otput: TRUE = TRUE = SEMAFORO ROSSO, importazione già in esecuzione
//---  se ERRORE lancia un Exception
//---
boolean k_return=false
datetime k_dateTime
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


try
	if get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then

//--- se c'è una data valuta se SAMOFORO VERDE
		if kst_tab_wm_pklist_cfg.importazione_ts_ini > datetime(date(0)) then
		
			k_dateTime = kguo_g.get_datetime_current( )
			if date(kst_tab_wm_pklist_cfg.importazione_ts_ini) = date(k_dateTime) then 
		
//--- se è in esecuzione da meno di 15' allora  SAMOFORO ROSSO!!
				if relativetime(time(kst_tab_wm_pklist_cfg.importazione_ts_ini), 900) > time(k_dateTime) then 
					k_return = true
				end if
				
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

private function boolean set_importazione_ts_ini (st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg) throws uo_exception;//
//====================================================================
//===    SEMAFORO!!
//=== Imposta il TS importazione_ts_ini di esecuzione operazione
//=== 
//=== Input: st_tab_wm_pklist_cfg.codice (se ZERO imposta 1),  importazione_ts_ini 
//=== Ritorna: TRUE = operazione ok      
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if kst_tab_wm_pklist_cfg.codice > 0 then
	else
		kst_tab_wm_pklist_cfg.codice = 1
	end if

	kst_tab_wm_pklist_cfg.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist_cfg.x_utente = kGuf_data_base.prendi_x_utente()
	
	if isnull(kst_tab_wm_pklist_cfg.importazione_ts_ini) then
		kst_tab_wm_pklist_cfg.importazione_ts_ini = datetime(date(0))
	end if
	
	update wm_pklist_cfg
			set  importazione_ts_ini = :kst_tab_wm_pklist_cfg.importazione_ts_ini
				,x_datins = :kst_tab_wm_pklist_cfg.x_datins
				,x_utente = :kst_tab_wm_pklist_cfg.x_utente
			WHERE codice = :kst_tab_wm_pklist_cfg.codice
			using kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore in Impostazione di Inizio Importazioni Packing-List Mandante ~n~r" &
				+ " codice=" + string(kst_tab_wm_pklist_cfg.codice, "####0") &
				+ " ~n~rErrore-tab.'wm_pklist_cfg':"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
//			if sqlca.sqlcode > 0 then
//				kst_esito.esito = kkg_esito.db_wrn
//			else
				kst_esito.esito = kkg_esito.db_ko
//			end if
		end if
		
		if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
		
	end if
	
//---- COMMIT....	
	if kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_cfg.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	k_return=true

//end if


return k_return

end function

public function boolean set_importazione_ts_ini_off () throws uo_exception;//---
//--- Imposta SEMAOFORO VERDE, fine importazioni pkl
//---
//---
boolean k_return
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


	kst_tab_wm_pklist_cfg.importazione_ts_ini = datetime(date(0))

	k_return = set_importazione_ts_ini(kst_tab_wm_pklist_cfg)
	
	
return k_return
	
end function

public function boolean set_importazione_ts_ini_on () throws uo_exception;//---
//--- Imposta SEMAOFORO ROSSO, inizio importazioni pkl
//---
//---
boolean k_return
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg


	kst_tab_wm_pklist_cfg.importazione_ts_ini = kguo_g.get_datetime_current( )

	k_return = set_importazione_ts_ini(kst_tab_wm_pklist_cfg)
	
	
return k_return
	
end function

event constructor;call super::constructor;//
//--- operazioni iniziali
//
ki_nomeOggetto = trim(this.classname( ))

end event

on kuf_wm_pklist_cfg.create
call super::create
end on

on kuf_wm_pklist_cfg.destroy
call super::destroy
end on

