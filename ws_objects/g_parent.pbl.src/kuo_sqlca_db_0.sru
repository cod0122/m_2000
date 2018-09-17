$PBExportHeader$kuo_sqlca_db_0.sru
forward
global type kuo_sqlca_db_0 from transaction
end type
end forward

global type kuo_sqlca_db_0 from transaction
end type
global kuo_sqlca_db_0 kuo_sqlca_db_0

type variables
//
//--- mettere la descrizione del tipo di DB, serve x personalizzare eventuale messaggio all'utente
protected string ki_db_descrizione = "" 

//--- valori della colonna blocca_richieste
public constant string ki_blocca_connessione_no = "0" 
public constant string ki_blocca_connessione_si = "1"

//--- valori della colonna cfg_dbms_scelta 
private constant string ki_cfg_dbms_scelta_princ = "1"
private constant string ki_cfg_dbms_scelta_muletto = "2"

private st_errori_gestione kist_errori_gestione

end variables
forward prototypes
public function st_esito db_commit ()
public function boolean db_connetti () throws uo_exception
public function st_esito db_rollback ()
protected function boolean x_db_connetti () throws uo_exception
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connesso () throws uo_exception
public function boolean if_connesso_x () throws uo_exception
public function boolean db_set_isolation_level () throws uo_exception
public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception
public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception
public function st_esito db_crea_view (integer k_id, string k_view, string k_sql)
public function boolean test_connessione () throws uo_exception
public subroutine u_crea_schema () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
public function boolean db_connetti (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
private function boolean x_db_profilo (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
public function st_esito db_truncate (string k_table) throws uo_exception
public function boolean db_disconnetti ()
public subroutine set_profilo_db () throws uo_exception
public function boolean db_riconnetti () throws uo_exception
end prototypes

public function st_esito db_commit ();//
//===	Ritorna St_esito - come da standard
//

st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	commit using this;

	if this.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.SQLErrText = trim(this.SQLErrText)
	end if

return kst_esito

 
end function

public function boolean db_connetti () throws uo_exception;//---
//---   Effettua la connessione al DB 
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return=false
st_esito kst_esito
pointer oldpointer

	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	if if_connessione_bloccata( ) then
	
		db_disconnetti( ) // devo disconnettermi poichè la connessione è bloccata
	
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.setmessage( "La connessione dati a " + ki_db_descrizione + " è BLOCCATA, puoi abilitarla da 'Proprietà del DB' - Nessuna operazione verso questo DB può proseguire. ")
		kGuo_exception.messaggio_utente( ) 
		throw kguo_exception
	
	end if


	if if_connesso( ) then
		k_return=true
	else
//--- piglia i dati di connessione dal DB	
		x_db_profilo() 
	
//--- Definizione del DB (profilo dal confdb.ini)
		k_return = x_db_connetti()
	end if
	
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	

end try

return k_return
end function

public function st_esito db_rollback ();//
//===	Ritorna St_esito - come da standard
//

st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	rollback using this;

	if this.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.SQLErrText = trim(this.SQLErrText)
	end if

return kst_esito


end function

protected function boolean x_db_connetti () throws uo_exception;//---
//---	Connessione effettiva al DB
//---   Out: TRUE = connesso
//---
//---  funzione da personalizzare
//---
boolean k_return = false
st_esito kst_esito

	
SetPointer(kkg.pointer_attesa)

	
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

connect using this;
 
if this.sqlcode < 0 then
	
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.SQLErrText = "Fallito tentativo di Connessione al " + ki_db_descrizione + ". ~n~r" &
						+ "Parm: " + this.DBParm + "; ~n~rServer: " + this.servername & 		
						+ "; returnData= " + trim(this.sqlreturndata)&
						+ "; ~n~rsqldbcode= "+ string(this.sqldbcode)+"; text= " +trim(this.sqlerrtext) + " " 
		kguo_exception.inizializza()
		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_db_ko)
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception			
			
end if
	
try	
//--- Imposta l'ISOLATION LEVEL ovvero cosa fare se becco un LOCK su un record
	db_set_isolation_level( )
catch (uo_exception kuo_exception)
end try
	
k_return = true

SetPointer(kkg.pointer_default)

return k_return

end function

protected subroutine x_db_profilo () throws uo_exception;//---
//---	Popola questo oggetto con i dati di Connessiore
//---      
//---   Lancia Exception
//---   funzione da personalizzare



end subroutine

public function boolean if_connesso () throws uo_exception;//
boolean k_return = false


	if this.DBHandle ( ) > 0  then
		
		if if_connesso_x( ) then 
			k_return = true    // OK DB GIA' CONNESSO!
		else
			db_disconnetti()
		end if
	end if


return k_return
end function

public function boolean if_connesso_x () throws uo_exception;//
//--- controllo personalizzato x Verifica Connessione sullo specifico DB 


// DA PERSONALIZZARE !!!!


return true


end function

public function boolean db_set_isolation_level () throws uo_exception;//---------------------------------------------------------------------
//--- 
//--- SETTA ISOLATION LEVEL DEL DB
//---
//--- lancia exception
//---
//---------------------------------------------------------------------
//--- DA PERSONALIZZARE A SECONDA DEL DB 

boolean k_return=false

return k_return
end function

public function st_esito db_crea_table (string k_table, string k_sql) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TABELLA 
//---
//--- Par. input	: k_table = nome della tabella
//--- 		         : k_sql = ddl della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//-----------------------------------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto =  this.classname()


//--- Cancello e ricreo view/tab
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode = 0 then 
		commit using this;
	end if
	
	k_sql = " CREATE TABLE  " + trim(k_table) + "  (	" + k_sql + " ) "
	EXECUTE IMMEDIATE :k_sql using this;
	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione Table '" &
			                       + trim(k_table) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Table '" &
			                       + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
		end if
		rollback using this;

		if kst_esito.sqlcode < 0 then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
//--- scrive l'errore su LOG
//		kst_errori_gestione.nome_oggetto = this.classname()
//		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
//		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
//		kst_errori_gestione.sqldbcode = this.sqlcode
//		kst_errori_gestione.sqlca = this
//		kuf_data_base.errori_gestione(kst_errori_gestione)

	else
		commit using this;
	end if


return kst_esito
end function

public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception;//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TEMP TABLE 
//---
//--- Par. input	: k_table = nome della tabella (in SQL SERVER deve iniziare per '#')
//---           		: k_campi = i campi della tabella
//---           		: k_select = la query di carico della tabella
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



//--- Cancello e ricreo la view
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") "
//	k_sql_d = " CREATE TEMP  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") with no log "
//	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") " // DEBUG
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode < 0 then
//		rollback using this;
//		if this.sqlcode > 0 then
//			kst_esito.esito = kkg_esito.db_wrn
//			kst_esito.sqlcode = this.sqlcode
//			kst_esito.sqlerrtext = "Anomalie durante generazione Temp-Table '" &
//										  + trim(k_table) + "' err.:" + trim(this.SQLErrText)
//		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Temp-Table '" &
										  + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
//		end if
	else
		commit using this;
		
		if trim(k_select) = "" then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Manca la query da cui prendere i dati - tabella temporanea '" + trim(k_table) + "' non popolata! "
		else
			k_sql_d = " insert into "  + trim(k_table) + "  " + trim(k_select) 
			EXECUTE IMMEDIATE :k_sql_d using this;
		
			kst_esito.sqlerrtext = "Generazione terminata correttamente "
			if this.sqlcode = 0 then
				commit using this;
			else
				if this.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
					kst_esito.sqlcode = this.sqlcode
					kst_esito.sqlerrtext = "Anomalie durante inserimento dati nella Temp-Table '" &
												  + trim(k_table) + "' err.:" + trim(this.SQLErrText)
				else
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = this.sqlcode
					kst_esito.sqlerrtext = "Inserimanto dati nella Temp-Table '" &
												  + trim(k_table) + "' non riuscita:" + trim(this.SQLErrText)
				end if
				rollback using this;
				
			end if
			
		end if

	end if
	
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.no_esecuzione and kst_esito.esito <> kkg_esito.db_wrn then
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
//	if kst_esito.esito <> kkg_esito.ok then
////--- scrive l'errore su LOG
//		kst_errori_gestione.nome_oggetto = this.classname()
//		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
//		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
//		kst_errori_gestione.sqldbcode = this.sqlcode
//		kst_errori_gestione.sqlca = this
//		kuf_data_base.errori_gestione(kst_errori_gestione)
//	end if


return kst_esito
end function

public function st_esito db_crea_view (integer k_id, string k_view, string k_sql);//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA VIEW 
//---
//--- Par. input	: k_id = tipo operazione
//---				: k_view = nome della view
//---    	       	: k_sql = query della view
//---
//--- Ritorna st_esito : Vedi Standard
//---   
//---------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//--- Cancello e ricreo la view
	k_sql_d = "drop table " + trim(k_view) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop view " + trim(k_view) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	
	EXECUTE IMMEDIATE :k_sql using this;

	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante generazione View '" &
			                       + trim(k_view) + "' err.: " + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione View '" &
			                       + trim(k_view) + "' non riuscita: " + trim(this.SQLErrText)
		end if
		rollback using this;

//--- scrive l'errore su LOG
		kst_errori_gestione.nome_oggetto = this.classname()
		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
		kst_errori_gestione.sqldbcode = this.sqlcode
		kst_errori_gestione.sqlca = this
		kGuf_data_base.errori_gestione(kst_errori_gestione)
				
	else
		commit using this;
	end if


return kst_esito
end function

public function boolean test_connessione () throws uo_exception;//
boolean k_return = false


	try
		
		try
			db_disconnetti( ) 
		catch (uo_exception kuo_exceptionOK)
		end try

		if db_connetti( ) then
			k_return = true
		end if
		
	catch (uo_exception kuo_exception)
		
	end try
	
return k_return
end function

public subroutine u_crea_schema () throws uo_exception;//
//--- QUI METTERE LE ISTRUZIONI DI CREAZIONE DEL DB
//
end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
//st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
//kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
//
//
//kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
////--- controlla se connessione bloccata
//kuf1_wm_pklist_cfg.get_wm_pklist_cfg( kst_tab_wm_pklist_cfg)
//
//if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_tutto then	
//	k_return = TRUE
//end if	


return k_return

end function

public function boolean db_connetti (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//---
//---	Effettua la connessione al DB X IL CRM
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return = false
string k_errore = "0"
string k_chiudi = "N"
st_esito kst_esito

pointer oldpointer  // Declares a pointer variable
string k_nome, k_valore
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


	if this.DBHandle ( ) <= 0  or isnull(this.DBHandle ( )) then

		
//=== Definizione del DB (profilo dal confdb.ini)
		if x_db_profilo(kst_tab_db_cfg) then
	
			k_return = x_db_connetti()

		end if
	end if
	

return k_return

end function

private function boolean x_db_profilo (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
boolean k_return = true
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception
//kuf_pilota_cmd kuf1_pilota_cmd
//kuo_sqlca_db_xweb kuo1_sqlca_db_xweb
//

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- setta il profile del DB
//set_profilo_db(kst_tab_db_cfg)
if kst_tab_db_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	this.DBMS = kst_tab_db_cfg.cfg_dbms
	this.DBParm = kst_tab_db_cfg.cfg_dbparm
else
	this.DBMS = kst_tab_db_cfg.cfg_dbms_alt
	this.DBParm = kst_tab_db_cfg.cfg_dbparm_alt
end if

if kst_tab_db_cfg.cfg_autocommit = "true" then
	this.AutoCommit = true
else
	this.AutoCommit = false
end if

if trim(this.dbms) = "nessuno"  then
	k_return = false
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del " + ki_db_descrizione + " in 'Proprietà Accesso del DB' ~n~r"+ &
				"Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")~n~r" & 
				+ "Definizione cercata nella Tabella: DB_CFG~n~r" &
				+ " ~n~rNon sara' possibile operare sugli archivi del Database ~n~r" 
				
	kuo_exception = create uo_exception								
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if


SetPointer(oldpointer)


return k_return


end function

public function st_esito db_truncate (string k_table) throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- TRUNCATE TABELLA  (pulizia di tutte le righe!!!) 
//---
//--- Par. input	: k_table = nome della tabella
//--- 		        
//--- Ritorna st_esito : Vedi Standard
//---   
//-----------------------------------------------------------------------------------------------------------------------------------
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto =  this.classname()


//--- Cancello e ricreo view/tab
	k_sql_d = "TRUNCATE TABLE " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Anomalie durante op. di TRUNCATE Table '" &
			                       + trim(k_table) + "' err.:" + trim(this.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Operazione di TRUNCATE Table '" &
			                       + trim(k_table) + "' non riuscita:" + trim(this.SQLErrText)
		end if
		rollback using this;

		if kst_esito.sqlcode < 0 then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
//--- scrive l'errore su LOG
//		kst_errori_gestione.nome_oggetto = this.classname()
//		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
//		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
//		kst_errori_gestione.sqldbcode = this.sqlcode
//		kst_errori_gestione.sqlca = this
//		kuf_data_base.errori_gestione(kst_errori_gestione)

	else
		commit using this;
	end if


return kst_esito
end function

public function boolean db_disconnetti ();//
//---   Ritorna: TRUE x OK
//
boolean k_return = true
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



//--- Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- Se DB connesso 
	if this.DBHandle ( ) > 0 then

		disconnect using this;

//		if this.sqlcode < 0 then
//			k_return = false
//			kst_esito.esito = kkg_esito.DB_KO
//			kst_esito.sqlcode = this.sqlcode
//			kst_esito.SQLErrText = trim(this.sqlerrtext) + "~n~r" + &
//						"Codice : " + string(this.sqldbcode, "#####") + "~n~r" +&
//					this.sqlreturndata
//			kuo_exception = create uo_exception								
//			kuo_exception.set_esito(kst_esito)
//			throw kuo_exception
//		else
//			if this.sqlcode <> 0 then
//				k_return = false
//				kst_esito.esito = kkg_esito.db_wrn
//				kst_esito.sqlcode = this.sqlcode
//				kst_esito.SQLErrText = trim(this.sqlerrtext) 
//				kuo_exception = create uo_exception								
//				kuo_exception.set_esito(kst_esito)
//				throw kuo_exception
//			end if	
//		end if
	end if


SetPointer(oldpointer)

return k_return


end function

public subroutine set_profilo_db () throws uo_exception;//---
//--- Imposta il profilo DB su questo oggetto x la Connessione
//---

x_db_profilo( )

//




end subroutine

public function boolean db_riconnetti () throws uo_exception;//---
//---   Effettua tentativi di Ri-connessione al DB (massimo 10 tentativi)
//---	Output: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return=false, k_ritenta=true
st_esito kst_esito
int k_riconnessione_ctr=0
	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	do while k_ritenta and k_riconnessione_ctr < 10
		
		try 
			k_riconnessione_ctr ++
			db_connetti( )
			k_ritenta = false
			
			k_return = true // RI-CONNESSO!!
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito then
				k_ritenta = false
			end if
		end try
		
	loop
	
	
catch (uo_exception kuo1_exception)	
	throw kuo1_exception
	
finally
	

end try

return k_return
end function

on kuo_sqlca_db_0.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuo_sqlca_db_0.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;//
st_errori_gestione kst_errori_gestione_nulla

	kist_errori_gestione = kst_errori_gestione_nulla

	kist_errori_gestione.nome_oggetto =  kGuf_data_base.u_getfocus_nome( )  //this.classname()
	if isnull(kist_errori_gestione.nome_oggetto) then kist_errori_gestione.nome_oggetto = ""
	kist_errori_gestione.sqlsyntax = trim(sqlsyntax)
	if isnull(kist_errori_gestione.sqlsyntax) then kist_errori_gestione.sqlsyntax = ""

	kist_errori_gestione.sqlerrtext = trim(sqlerrtext)
	if len(trim(kist_errori_gestione.sqlerrtext)) > 0 then
	else
		kist_errori_gestione.sqlerrtext = trim(sqlerrortext)
	end if
	if isnull(kist_errori_gestione.sqlerrtext) then kist_errori_gestione.sqlerrtext = ""
	if this.sqlcode < 0 then
		kist_errori_gestione.esito = kkg_esito.db_ko
	else
		kist_errori_gestione.esito = kkg_esito.db_wrn
	end if
	kist_errori_gestione.sqldbcode = code
	kist_errori_gestione.sqlca = this 

//--- evito di esporre gli errori di 'DROP TBABLE/VIEW' (in ORACLE code = 942 e in MSSQL sono 3701 e 3705  è tabella o view non esiste!)
	if code <> 942 and code <> -523 and code <> -206 and code <> -394 and code <> 3705 and code <> 3701 then
		if code = -1 and sqldbcode = 0 then  
			// -1 è di solito un errore di 'TRANSAZIONE NON CONNESSA' che si verifica spesso, quindi non faccio nulla
		else
			kGuf_data_base.errori_gestione(kist_errori_gestione)
		end if
	end if


RETURN 1 // Do not display system error message

end event

event constructor;//
ki_db_descrizione = "DB della Procedura"   // il default

end event

