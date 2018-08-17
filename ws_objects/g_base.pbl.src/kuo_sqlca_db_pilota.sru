$PBExportHeader$kuo_sqlca_db_pilota.sru
forward
global type kuo_sqlca_db_pilota from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_pilota from kuo_sqlca_db_0
end type
global kuo_sqlca_db_pilota kuo_sqlca_db_pilota

forward prototypes
private subroutine x_db_profilo () throws uo_exception
end prototypes

private subroutine x_db_profilo () throws uo_exception;//
//--- Imposta i parametri di connessione su questo oggetto
//--- Solleva una ECCEZIONE x errore
//
boolean k_return = true
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_pilota_cmd kuf1_pilota_cmd
kuo_sqlca_db_pilota kuo1_sqlca_db_pilota



	
//--- ripristina la path di lavoro
//kGuf_data_base.setta_path_default()
//
//k_file = KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE
//k_sezione="dbpilota"

//if not FileExists ( k_file ) then
//	kst_esito.esito = kkg_esito.not_fnd
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText =  "Non trovato File x la definizione del 'DB Pilota': " + "~n~r"+ &
//				+ trim(k_file) + " ~n~r" &
//				+ "Impossibile stabilire la connessione con il DB ~n~r" +  &
//				+ " ~n~rNon sara' possibile operare sugli archivi del Server dell'Impianto (il Pilota) ~n~r" 
//	kuo_exception = create uo_exception								
//	kuo_exception.set_esito(kst_esito)
//	throw kuo_exception
//
//end if

try

//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
		
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
	
		kuf1_pilota_cmd = create kuf_pilota_cmd
		
		kuo1_sqlca_db_pilota = kuf1_pilota_cmd.get_profilo_db()
		
		this.dbms = kuo1_sqlca_db_pilota.dbms
		this.dbparm = kuo1_sqlca_db_pilota.dbparm
		this.AutoCommit = kuo1_sqlca_db_pilota.AutoCommit
		
		
		if trim(this.dbms) = "nessuno"  then
			k_return = false
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText =  "Non trovata definizione del 'DB Pilota' in 'Proprietà Pilota' ~n~r"+ &
						"Impossibile stabilire la connessione con il DB: ~n~r" +  &
						"(" + trim(this.dbms) + " DbParm " + &
						trim(this.dbparm) + ")~n~r" & 
						+ "Definizione cercata nella Tabella: PILOTA_CFG~n~r" &
						+ " ~n~rNon sara' possibile operare sugli archivi del Server dell'Impianto (il Pilota) ~n~r" 
						
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		
		end if

	catch (uo_exception k1uo_exception)
		throw k1uo_exception
	
	finally
		if isvalid(kuo1_sqlca_db_pilota) then destroy kuo1_sqlca_db_pilota
		if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd 

		SetPointer(oldpointer)

end try




end subroutine

on kuo_sqlca_db_pilota.create
call super::create
end on

on kuo_sqlca_db_pilota.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	ki_db_descrizione = "DB del PILOTA IMPIANTO"

end event

