$PBExportHeader$kuf_db.sru
forward
global type kuf_db from kuf_parent
end type
end forward

global type kuf_db from kuf_parent
end type
global kuf_db kuf_db

forward prototypes
public function st_esito db_profile ()
public subroutine db_disconnect (ref transaction kuo1_sqlca_db_magazzino) throws uo_exception
public subroutine db_disconnect () throws uo_exception
public subroutine db_connect () throws uo_exception
public subroutine db_connect (ref transaction kuo1_sqlca_db_magazzino) throws uo_exception
end prototypes

public function st_esito db_profile ();//
st_esito kst_esito 
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Se DB connesso 
	if not isvalid(sqlca) then
		sqlca = create transaction
	end if
		
//--- ripristina la path di lavoro
	kuf1_data_base.setta_path_default()
	
//--- Recupera le info dal CONFDB.INI
	SQLCA.DBMS = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "DBMS", "nessuno")
	SQLCA.DBParm = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "DbParm", "")
//	SQLCA.DBParm = "CLIENT_LOCALE='en_us.CP1252',DB_LOCALE='en_us.CP1252'"
	SQLCA.Database = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "Database", "")
	SQLCA.UserId = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "UserId", "informix")
	SQLCA.DBPass = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "DBPass", "infoxgamma")
	SQLCA.LogPass = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "LogPass", "infoxgamma")
	SQLCA.LogId = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "LogId", "informix")
	SQLCA.ServerName = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "ServerName", "")
	
	if (profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "AutoCommit", "false")) = "true" then
		SQLCA.AutoCommit = true
	else
		SQLCA.AutoCommit = false
	end if
	

	if trim(sqlca.dbms) = "nessuno"  then

		kst_esito.esito = kkg_esito_not_fnd
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore, non trovato 'profilo' del DB nel CONFDB.INI. ~n~r "&
				+ "Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(sqlca.Database) + " DbParm " + &
				trim(sqlca.dbparm) + ")~n~r" &
				+ "Definizione cercata nella cartella:~n~r" &
				+ trim(kg_path_procedura) &
				+ KK_NOME_PROFILE_BASE + "~n~r"

		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
		kuo_exception.set_esito( kst_esito )
		destroy kuo_exception			
					

	else


	end if


return kst_esito


	
end function

public subroutine db_disconnect (ref transaction kuo1_sqlca_db_magazzino) throws uo_exception;//
//===	Ritorna ST_ESITO
//===     
st_esito kst_esito 
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)



//=== Se DB connesso 
	if isvalid(kuo1_sqlca_db_magazzino) then
	
		if kuo1_sqlca_db_magazzino.DBHandle ( ) > 0 then
	
			disconnect using kuo1_sqlca_db_magazzino;
	
			if kuo1_sqlca_db_magazzino.sqlcode < 0 then
				
	
				kst_esito.esito = kkg_esito_db_ko
				kst_esito.sqlcode = kuo1_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in Disconnessione al DB.: " + trim(kuo1_sqlca_db_magazzino.sqlerrtext)
		
				kuo_exception = create uo_exception
				kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception		
				
			end if
	
		end if
	
	end if






end subroutine

public subroutine db_disconnect () throws uo_exception;//
//--- se chiamato senza nulla connetto oggetto SQLCA standard
//
try 
	db_disconnect(sqlca) //kuo_sqlca_db_magazzino)
	
catch (uo_exception kuo_exception)
	throw (kuo_exception)
	
end try

end subroutine

public subroutine db_connect () throws uo_exception;//
//--- se chiamato senza nulla connetto oggetto SQLCA standard
//
try 
	db_connect(sqlca) // kuo_sqlca_db_magazzino)
	
catch (uo_exception kuo_exception)
	throw (kuo_exception)
	
end try

end subroutine

public subroutine db_connect (ref transaction kuo1_sqlca_db_magazzino) throws uo_exception;//
//---     
//---	Ritorna ST_ESITO 
//---     
//
st_esito kst_esito 
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Definizione del DB (profilo dal confdb.ini)
	kst_esito = db_profile()
	
	if kst_esito.esito <> kkg_esito_ok then
	
		kst_esito.esito = kkg_esito_db_ko
		kst_esito.sqlcode = kuo1_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Caratteristiche del DB non trovate. ~n~r" + trim(kst_esito.sqlerrtext)+"; ~n~r " 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_insufficienti)
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception			
	
	else
		
		connect using kuo1_sqlca_db_magazzino;
		
		if kuo1_sqlca_db_magazzino.sqlcode < 0 then
	
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = kuo1_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Connessione al DB do Magazzino. ~n~r" &
							+ "Parm: " + kuo1_sqlca_db_magazzino.DBParm + "; ~n~rServer: " + kuo1_sqlca_db_magazzino.servername & 		
							+ "returnData=" + trim(kuo1_sqlca_db_magazzino.sqlreturndata)+"; ~n~rsqldbcode="+ string(kuo1_sqlca_db_magazzino.sqldbcode)+"; " +trim(kuo1_sqlca_db_magazzino.sqlerrtext)+" " 
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception			
						
		end if
	end if
	
	SetPointer(oldpointer)
	



end subroutine

on kuf_db.create
call super::create
end on

on kuf_db.destroy
call super::destroy
end on

