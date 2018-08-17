$PBExportHeader$kuo_sqlca_db_magazzino.sru
forward
global type kuo_sqlca_db_magazzino from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_magazzino from kuo_sqlca_db_0
end type
global kuo_sqlca_db_magazzino kuo_sqlca_db_magazzino

type variables
//
public string ki_user
public string ki_password

end variables
forward prototypes
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connesso_x ()
public function boolean db_set_isolation_level () throws uo_exception
public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
string k_file_ini 
boolean k_fileExist 
st_esito kst_esito 
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- ripristina la path di lavoro
	kGuf_data_base.setta_path_default()

	try 
		kGuf_data_base.u_if_profile_base_exists()
		
	
		k_file_ini = kGuf_data_base.get_nome_profile_base()  //trim(KG_PATH_PROCEDURA + KKg_NOME_PROFILE.BASE)
		if k_file_ini > " " then
		else 
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Attenzione, manca il nome del file dati di accesso al DB. Operazione interrotta~n~r "&
					+ "Il problema dovrebbe risolversi riavviando il programma altrimenti avvertire il tecnico." 
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
			kuo_exception.set_esito( kst_esito )
			destroy kuo_exception			
		end if
	
	catch (uo_exception kuo1_exception)
		kuo1_exception.messaggio_utente()
		
	end try
	
//	u_if_profile_base_exists()
//	k_fileExist = fileexists(k_file_ini)
//	if not k_fileExist then
//		kst_esito.esito = kkg_esito.not_fnd
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Attenzione, non trovo il file dati di accesso al DB '" + trim(KG_PATH_PROCEDURA + KKg_NOME_PROFILE.BASE) + "'.~n~r "&
//				+ "Operazione interrotta. Riprovare a riavviare il programma o avvertire il tecnico." 
//		kuo_exception = create uo_exception
//		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_anomali )
//		kuo_exception.set_esito( kst_esito )
//		destroy kuo_exception			
//	end if


//--- Recupera le info dal CONFDB.INI
	this.DBMS = profilestring (k_file_ini, "Database", "DBMS", "SNC SQL Native Client(OLE DB)")
	this.DBParm = profilestring (k_file_ini, "Database", "DbParm", "Provider='SQLNCLI11',Database='sterigenics270',TrustedConnection=1")
	this.Database = profilestring (k_file_ini, "Database", "Database", "")
	this.UserId = profilestring (k_file_ini, "Database", "UserId", "")
	this.DBPass = profilestring (k_file_ini, "Database", "DBPass", "") // "infoxgamma")
	if this.ki_user > " " then
		this.LogId = this.ki_user
	else
		this.LogId = profilestring (k_file_ini, "Database", "LogId", "M2000")
	end if
	if this.ki_password > " " then
		this.LogPass = this.ki_password
	else
		this.LogPass = profilestring (k_file_ini, "Database", "LogPass", "start") 
	end if
	this.ServerName = profilestring (k_file_ini, "Database", "ServerName", "")
	
	if (profilestring (k_file_ini, "Database", "AutoCommit", "false")) = "true" then
		this.AutoCommit = true
	else
		this.AutoCommit = false
	end if

// Profile db_STERIGENICS270_TEST
//this.DBMS = "SNC SQL Native Client(OLE DB)"
//this.LogPass = "cinacina"
//this.ServerName = "ALBERTOT"
//this.LogId = "alberto"
//this.Lock = "SS"
//this.AutoCommit = False
//this.DBParm = "Provider='SQLNCLI11',Database='sterigenics270',TrustedConnection=1"
	

	if trim(this.dbms) = "nessuno"  then

		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore, non trovato 'profilo' del DB nel '" + trim(k_file_ini) + "'. ~n~r "&
				+ "Impossibile stabilire la connessione con il DB: ~n~r" +  "(" + trim(this.Database) + " DbParm " &
				+ trim(this.dbparm) + ")~n~r" + "Definizione cercata nella cartella:~n~r" &
				+ k_file_ini + "~n~r"

		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
		kuo_exception.set_esito( kst_esito )
		destroy kuo_exception			

	end if





	
end subroutine

public function boolean if_connesso_x ();//
boolean k_return = false
int k_connesso=0


	select 1 into :k_connesso from base 
		using this;
	
	if k_connesso = 1 then
		
		k_return = true   

	end if


return k_return
end function

public function boolean db_set_isolation_level () throws uo_exception;//---------------------------------------------------------------------
//--- 
//--- SETTA ISOLATION LEVEL DEL DB
//---
//--- lancia exception
//---
//---------------------------------------------------------------------
//---

boolean k_return=false
string k_sql_d
st_esito kst_esito
st_errori_gestione kst_errori_gestione


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	//informix k_sql_d = " set isolation to committed read last committed " 
//	
k_sql_d = "SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED"
EXECUTE IMMEDIATE :k_sql_d using this ;
//if this.sqlcode = 0 then
//	
//		k_sql_d = " SET TRANSACTION ISOLATION LEVEL SNAPSHOT "
////"READ UNCOMMITTED "
//		EXECUTE IMMEDIATE :k_sql_d using this ;
//	
//	end if
//	

	if this.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = this.sqlcode
		kst_esito.sqlerrtext = "Fallito SET ISOLATION LEVEL: '" + trim(k_sql_d) + "'. Errore: " + trim(this.SQLErrText)

		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_return = true
	end if


return k_return
end function

public function st_esito db_crea_temp_table (string k_table, string k_campi, string k_select) throws uo_exception;//---------------------------------------------------------------------------------------------------------
//--- 
//--- CREA TEMP TABLE 
//---
//--- Par. input	: k_table = nome della tabella
//---           			: k_campi = i campi della tabella
//---           			: k_select = la query di carico della tabella
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

//--- il nome tabella in SQL SERVER inizia per # (visibilità locale) o ## (vsibilità globale)
	if left(trim(k_table),1)  <> '#' then
		k_table = "#" + trim(k_table) 
	end if

//--- Cancello e ricreo la temp o view
	k_sql_d = "drop view " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = "drop table " + trim(k_table) + "  " 
	EXECUTE IMMEDIATE :k_sql_d using this;
	commit using this;
	k_sql_d = " CREATE  TABLE "  + trim(k_table) + "  (" + trim(k_campi) + ") "
	EXECUTE IMMEDIATE :k_sql_d using this;
	if this.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Temp-Table '" &
										  + trim(k_table) + "' non riuscita: " + trim(this.SQLErrText)
	else
		commit using this;
		
		if trim(k_select) = "" then
			kst_esito.esito = kkg_esito.db_wrn
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Manca la query da cui prendere i dati - tabella temporanea '" + trim(k_table) + "' non popolata subito. "
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


return kst_esito
end function

on kuo_sqlca_db_magazzino.create
call super::create
end on

on kuo_sqlca_db_magazzino.destroy
call super::destroy
end on

event constructor;call super::constructor;//
 ki_db_descrizione = "DB di Magazzino"

end event

