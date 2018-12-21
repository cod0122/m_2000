$PBExportHeader$kuf_e1_conn_cfg.sru
$PBExportComments$accesso al db di E-ONE
forward
global type kuf_e1_conn_cfg from kuf_parent
end type
end forward

global type kuf_e1_conn_cfg from kuf_parent
end type
global kuf_e1_conn_cfg kuf_e1_conn_cfg

type variables
//---
public string ki_blocca_conn_si ="1"
public string ki_blocca_conn_no ="0"

//--- valori della colonna cfg_dbms_scelta 
public constant string ki_cfg_dbms_scelta_princ = "1"
public constant string ki_cfg_dbms_scelta_muletto = "2"

end variables

forward prototypes
public function boolean get_profilo_db (ref kuo_sqlca_db_e1 kuo_sqlca) throws uo_exception
public function boolean get_e1_conn_cfg (ref st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception
public subroutine if_isnull (ref st_tab_e1_conn_cfg kst_tab_e1_conn_cfg)
public function boolean set_blocco_conn_no () throws uo_exception
public function boolean set_blocco_conn_si () throws uo_exception
private function boolean set_blocca_conn (st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception
public function string get_schema_nome (st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception
public function string u_sql_set_schema_nome () throws uo_exception
end prototypes

public function boolean get_profilo_db (ref kuo_sqlca_db_e1 kuo_sqlca) throws uo_exception;//---
//--- Torna il profilo DB x la Connessione
//---
boolean k_return = false
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg


kuo_sqlca = create  kuo_sqlca_db_e1

get_e1_conn_cfg(kst_tab_e1_conn_cfg)

//--- Recupera le info x la connessione
if kst_tab_e1_conn_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	kuo_sqlca.DBMS = kst_tab_e1_conn_cfg.cfg_dbms
	kuo_sqlca.DBParm = kst_tab_e1_conn_cfg.cfg_dbparm
	kuo_sqlca.servername = kst_tab_e1_conn_cfg.cfg_servername
	kuo_sqlca.logid = kst_tab_e1_conn_cfg.cfg_utente
	kuo_sqlca.logpass = kst_tab_e1_conn_cfg.cfg_pwd
else
	kuo_sqlca.DBMS = kst_tab_e1_conn_cfg.cfg_dbms_alt
	kuo_sqlca.DBParm = kst_tab_e1_conn_cfg.cfg_dbparm_alt
	kuo_sqlca.servername = kst_tab_e1_conn_cfg.cfg_servername_alt
	kuo_sqlca.logid = kst_tab_e1_conn_cfg.cfg_utente_alt
	kuo_sqlca.logpass = kst_tab_e1_conn_cfg.cfg_pwd_alt
end if

if trim(kuo_sqlca.DBMS) > " " then
else
	kuo_sqlca.DBMS =  "nessuno"
end if
if trim(kuo_sqlca.DBParm) > " " then
else
	kuo_sqlca.DBParm =  ""
end if
if trim(kuo_sqlca.Database) > " " then
else
	kuo_sqlca.Database =  ""
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

if kst_tab_e1_conn_cfg.cfg_autocommit = "true" then
	kuo_sqlca.AutoCommit = true
else
	kuo_sqlca.AutoCommit = false
end if

k_return = true

return k_return 


end function

public function boolean get_e1_conn_cfg (ref st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception;//--
//---  Legge la tabella di configurazione del Packing List 
//---
//---  input: kst_tab_e1_conn_cfg.codice  (il default è 1)
//---  otput: kst_tab_e1_conn_cfg 
//---  se ERRORE lancia un Exception
//---
boolean k_return=false
st_esito kst_esito 



kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_e1_conn_cfg.codice = 0 or isnull(kst_tab_e1_conn_cfg.codice) then kst_tab_e1_conn_cfg.codice = 1
 
  SELECT e1_conn_cfg.codice,   
         e1_conn_cfg.blocca_conn,   
         e1_conn_cfg.schema_nome,   
         e1_conn_cfg.cfg_dbms_scelta,   
         e1_conn_cfg.cfg_dbms,   
         e1_conn_cfg.cfg_autocommit,   
         e1_conn_cfg.cfg_dbparm,   
         e1_conn_cfg.cfg_dbms_alt,   
         e1_conn_cfg.cfg_autocommit_alt,   
         e1_conn_cfg.cfg_dbparm_alt,  
		e1_conn_cfg.cfg_servername,
		e1_conn_cfg.cfg_utente,
		e1_conn_cfg.cfg_pwd,
		e1_conn_cfg.cfg_servername_alt,
		e1_conn_cfg.cfg_utente_alt,
		e1_conn_cfg.cfg_pwd_alt
    INTO :kst_tab_e1_conn_cfg.codice,   
         :kst_tab_e1_conn_cfg.blocca_conn,   
         :kst_tab_e1_conn_cfg.schema_nome,   
         :kst_tab_e1_conn_cfg.cfg_dbms_scelta,   
         :kst_tab_e1_conn_cfg.cfg_dbms,   
         :kst_tab_e1_conn_cfg.cfg_autocommit,   
         :kst_tab_e1_conn_cfg.cfg_dbparm,   
         :kst_tab_e1_conn_cfg.cfg_dbms_alt,   
         :kst_tab_e1_conn_cfg.cfg_autocommit_alt,   
         :kst_tab_e1_conn_cfg.cfg_dbparm_alt,  
		:kst_tab_e1_conn_cfg.cfg_servername,
		:kst_tab_e1_conn_cfg.cfg_utente,
		:kst_tab_e1_conn_cfg.cfg_pwd,
		:kst_tab_e1_conn_cfg.cfg_servername_alt,
		:kst_tab_e1_conn_cfg.cfg_utente_alt,
		:kst_tab_e1_conn_cfg.cfg_pwd_alt
    FROM e1_conn_cfg  
   WHERE e1_conn_cfg.codice = :kst_tab_e1_conn_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		k_return=true
		
		kst_tab_e1_conn_cfg.blocca_conn = trim(kst_tab_e1_conn_cfg.blocca_conn)
		if kst_tab_e1_conn_cfg.blocca_conn = "" then kst_tab_e1_conn_cfg.blocca_conn = ""

	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Proprieta' Connessione E-ONE " + string(kst_tab_e1_conn_cfg.codice) + "~n~r  " &
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

public subroutine if_isnull (ref st_tab_e1_conn_cfg kst_tab_e1_conn_cfg);//---
//--- Inizializza i campi della tabella 
//---
if kst_tab_e1_conn_cfg.codice > 0 then 
else
	kst_tab_e1_conn_cfg.codice  = 1
end if
if isnull(kst_tab_e1_conn_cfg.blocca_conn  ) then kst_tab_e1_conn_cfg.blocca_conn = ki_blocca_conn_no
if isnull(kst_tab_e1_conn_cfg.schema_nome  ) then kst_tab_e1_conn_cfg.schema_nome = ""
if isnull(kst_tab_e1_conn_cfg.cfg_autocommit ) then kst_tab_e1_conn_cfg.cfg_autocommit = ""
if isnull(kst_tab_e1_conn_cfg.cfg_dbms ) then kst_tab_e1_conn_cfg.cfg_dbms = ""
if isnull(kst_tab_e1_conn_cfg.cfg_dbms_scelta ) then kst_tab_e1_conn_cfg.cfg_dbms_scelta = ""
if isnull(kst_tab_e1_conn_cfg.cfg_dbparm ) then kst_tab_e1_conn_cfg.cfg_dbparm = ""
if isnull(kst_tab_e1_conn_cfg.cfg_pwd ) then kst_tab_e1_conn_cfg.cfg_pwd = ""
if isnull(kst_tab_e1_conn_cfg.cfg_servername ) then kst_tab_e1_conn_cfg.cfg_servername = ""
if isnull(kst_tab_e1_conn_cfg.cfg_autocommit ) then kst_tab_e1_conn_cfg.cfg_autocommit = ""
if isnull(kst_tab_e1_conn_cfg.cfg_dbms_alt ) then kst_tab_e1_conn_cfg.cfg_dbms_alt = ""
if isnull(kst_tab_e1_conn_cfg.cfg_dbms_scelta ) then kst_tab_e1_conn_cfg.cfg_dbms_scelta = "1"
if isnull(kst_tab_e1_conn_cfg.cfg_dbparm_alt ) then kst_tab_e1_conn_cfg.cfg_dbparm_alt = ""
if isnull(kst_tab_e1_conn_cfg.cfg_pwd_alt ) then kst_tab_e1_conn_cfg.cfg_pwd_alt = ""
if isnull(kst_tab_e1_conn_cfg.cfg_servername_alt ) then kst_tab_e1_conn_cfg.cfg_servername_alt = ""

if isnull(kst_tab_e1_conn_cfg.x_datins) then kst_tab_e1_conn_cfg.x_datins = datetime(date(0))
if isnull(kst_tab_e1_conn_cfg.x_utente) then kst_tab_e1_conn_cfg.x_utente = " "

end subroutine

public function boolean set_blocco_conn_no () throws uo_exception;//---
//--- Sblocca Importazione
//---
//---
boolean k_return
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg


	kst_tab_e1_conn_cfg.blocca_conn = ki_blocca_conn_no

	k_return = set_blocca_conn(kst_tab_e1_conn_cfg)
	
	
return k_return
	
end function

public function boolean set_blocco_conn_si () throws uo_exception;//---
//--- Blocca Importazione
//---
//---
boolean k_return
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg


	kst_tab_e1_conn_cfg.blocca_conn = ki_blocca_conn_SI

	k_return = set_blocca_conn(kst_tab_e1_conn_cfg)
	
	 
return k_return
	
end function

private function boolean set_blocca_conn (st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception;//
//====================================================================
//=== Imposta sul CFG il Blocco/Sblocco x Importazione nuovi PKLIST
//=== 
//=== Input: st_tab_e1_conn_cfg.codice (se ZERO imposta 1),  blocca_importa (impostato a SI/NO) 
//=== Ritorna:       ST_ESITO 
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

	if kst_tab_e1_conn_cfg.codice > 0 then
	else
		kst_tab_e1_conn_cfg.codice = 1
	end if

	kst_tab_e1_conn_cfg.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_e1_conn_cfg.x_utente = kGuf_data_base.prendi_x_utente()
	
	
	update e1_conn_cfg
			set  blocca_conn = :kst_tab_e1_conn_cfg.blocca_conn
					,x_datins = :kst_tab_e1_conn_cfg.x_datins
					,x_utente = :kst_tab_e1_conn_cfg.x_utente
			WHERE codice = :kst_tab_e1_conn_cfg.codice
			using sqlca;
		
	if sqlca.sqlcode < 0 then
			
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante Impostazione Blocco Importazione in Proprieta' Packing-List Mandante ~n~r" &
				+ " codice=" + string(kst_tab_e1_conn_cfg.codice, "####0") &
				+ " ~n~rErrore-tab.'e1_conn_cfg':"	+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
//			if sqlca.sqlcode > 0 then
//				kst_esito.esito = kkg_esito.db_wrn
//			else
				kst_esito.esito = kkg_esito.db_ko
//			end if
		end if
		
		if kst_tab_e1_conn_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_conn_cfg.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
		
	end if
	
//---- COMMIT....	
	if kst_tab_e1_conn_cfg.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_conn_cfg.st_tab_g_0.esegui_commit) then
		kGuf_data_base.db_commit_1( )
	end if
	
	k_return=true

//end if


return k_return

end function

public function string get_schema_nome (st_tab_e1_conn_cfg kst_tab_e1_conn_cfg) throws uo_exception;//--
//---  Torna il nome dello schema/utente impostato
//---
//---  input: kst_tab_e1_conn_cfg.codice  (il default è 1)
//---  otput: 
//---  ritorna: nome dello schema
//---  se ERRORE lancia un Exception
//---
string k_return=""
st_esito kst_esito 



kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_e1_conn_cfg.codice = 0 or isnull(kst_tab_e1_conn_cfg.codice) then kst_tab_e1_conn_cfg.codice = 1
 
SELECT 
         e1_conn_cfg.schema_nome
    INTO
         :kst_tab_e1_conn_cfg.schema_nome
    FROM e1_conn_cfg  
   WHERE e1_conn_cfg.codice = :kst_tab_e1_conn_cfg.codice   
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if isnull(kst_tab_e1_conn_cfg.schema_nome) then kst_tab_e1_conn_cfg.schema_nome = ""
			k_return = trim(kst_tab_e1_conn_cfg.schema_nome)
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura nome schema in 'Connessione E-ONE' " + string(kst_tab_e1_conn_cfg.codice) + "~n~r  " &
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

public function string u_sql_set_schema_nome () throws uo_exception;//--
//---  Aggiorna nel SQL il nome dello schema
//---
//---  input: 
//---  otput: 
//---  ritorna: nome schema (table owner)
//---  se ERRORE lancia un Exception
//---
string k_return=""
string k_sql_orig, k_stringn, k_string
int k_ctr, k_lenN, k_lenO
st_esito kst_esito 
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg


try 
	
	kst_esito.esito = kkg_esito.ok 
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_e1_conn_cfg.schema_nome = get_schema_nome(kst_tab_e1_conn_cfg)

	k_sql_orig  = "alter session set current_schema = " + trim(kst_tab_e1_conn_cfg.schema_nome)
	
	EXECUTE IMMEDIATE :k_sql_orig using kguo_sqlca_db_e1;
	if kguo_sqlca_db_e1.sqlcode <> 0 then
		if kguo_sqlca_db_e1.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante impostazione del db Table-Owner (schema) di E1 '" &
			                       + trim(kst_tab_e1_conn_cfg.schema_nome) + "' err.: " + trim(kguo_sqlca_db_e1.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
			kst_esito.sqlerrtext = "Errore in impostazione del db Table-Owner (schema) di E1 '" &
			                       + trim(kst_tab_e1_conn_cfg.schema_nome) + "' non riuscita: " + trim(kguo_sqlca_db_e1.SQLErrText)
		end if

		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	k_return = trim(kst_tab_e1_conn_cfg.schema_nome)
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try


return k_return

end function

event constructor;call super::constructor;//
//--- operazioni iniziali
//
ki_nomeOggetto = trim(this.classname( ))

end event

on kuf_e1_conn_cfg.create
call super::create
end on

on kuf_e1_conn_cfg.destroy
call super::destroy
end on

