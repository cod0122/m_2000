$PBExportHeader$kuo_sqlca_db_e1.sru
forward
global type kuo_sqlca_db_e1 from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_e1 from kuo_sqlca_db_0
end type
global kuo_sqlca_db_e1 kuo_sqlca_db_e1

forward prototypes
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
public function boolean u_db_connetti (ref datawindow adw_1) throws uo_exception
public function boolean if_connesso_x () throws uo_exception
public function integer u_get_col_len (string a_table, string a_col)
public function integer x_db_connetti_post_ok () throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_e1_conn_cfg kuf1_e1_conn_cfg
//kuo_sqlca_db_e1 kuo_sqlca_db_e1


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
kuo_sqlca_db_e1 kuo1_sqlca_db_e1 
	

kuf1_e1_conn_cfg = create kuf_e1_conn_cfg

kuo1_sqlca_db_e1 = this

kuf1_e1_conn_cfg.get_profilo_db(kuo1_sqlca_db_e1)

//kuo1_sqlca_db_e1 = kuf1_e1_conn_cfg.get_profilo_db()

this.dbms = kuo1_sqlca_db_e1.dbms
this.dbparm = kuo1_sqlca_db_e1.dbparm
this.AutoCommit = kuo1_sqlca_db_e1.AutoCommit
this.servername = kuo1_sqlca_db_e1.servername
this.logid = kuo1_sqlca_db_e1.logid
this.logpass = kuo1_sqlca_db_e1.logpass

if trim(this.dbms) = "nessuno"  then

	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del 'DB di E-ONE' in Proprietà Connessione E-ONE ~n~r"+ &
				"Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")~n~r" & 
				+ "Definizione cercata nella Tabella: E1_CONN_CFG~n~r" &
				+ " ~n~rNon sara' possibile operare sugli archivi del Server di E-ONE (db remoto di Sterigenics) ~n~r" 
				
//	if isvalid(kuo1_sqlca_db_e1) then destroy kuo1_sqlca_db_e1
	if isvalid(kuf1_e1_conn_cfg) then destroy kuf1_e1_conn_cfg 
				
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

end if

//if isvalid(kuo1_sqlca_db_e1) then destroy kuo1_sqlca_db_e1
destroy kuf1_e1_conn_cfg 

SetPointer(oldpointer)



end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_e1_conn_cfg kst_tab_e1_conn_cfg
kuf_e1_conn_cfg kuf1_e1_conn_cfg


kuf1_e1_conn_cfg = create kuf_e1_conn_cfg
//--- controlla se connessione bloccata
kuf1_e1_conn_cfg.get_e1_conn_cfg( kst_tab_e1_conn_cfg)

if kst_tab_e1_conn_cfg.blocca_conn = kuf1_e1_conn_cfg.ki_blocca_conn_si then	
	k_return = TRUE
end if	

return k_return

end function

public function boolean u_db_connetti (ref datawindow adw_1) throws uo_exception;//---
//---  Effettua la connessione al DB e aggiorna e setta la transazione e lo schema del DW  
//---	Inp: datawindow su cui lavorare
//---	Out: TRUE=connessione OK; FALSE=nessuna connessione
//---
//---   Lancia una ECCEZIONE x errore grave
//---
boolean k_return = false

	
try
	SetPointer(kkg.pointer_attesa )

	db_connetti( )
	
	adw_1.settransobject(this)
	
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	

end try



return k_return

end function

public function boolean if_connesso_x () throws uo_exception;//
boolean k_return = false
int k_conta


	SELECT count(*)
	  into :k_conta 
	  FROM global_name 
	  using this; 
	  
	if sqlcode = 0 then
		k_return = true
	end if

return k_return

end function

public function integer u_get_col_len (string a_table, string a_col);//
int k_return 
datastore kds_1

SELECT min(CHAR_LENGTH)
          into :k_return
            FROM ALL_TAB_COLUMNS 
	WHERE TABLE_NAME = :a_table AND COLUMN_NAME = :a_col
	using this;

if isnull(k_return) then
	k_return = 0
end if
		
return k_return


end function

public function integer x_db_connetti_post_ok () throws uo_exception;//---
//---  Setta lo schema del DB
//---  rit: 0 
//---
//---   Lancia una ECCEZIONE x errore grave
//---
kuf_e1_conn_cfg kuf1_e1_conn_cfg

	
try
	
	kuf1_e1_conn_cfg = create kuf_e1_conn_cfg
	kuf1_e1_conn_cfg.u_sql_set_schema_nome()
	
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	if isvalid(kuf1_e1_conn_cfg) then destroy kuf1_e1_conn_cfg
	

end try



return 0

end function

on kuo_sqlca_db_e1.create
call super::create
end on

on kuo_sqlca_db_e1.destroy
call super::destroy
end on

event constructor;//
 ki_db_descrizione = "DB di scambio dati con il E-ONE"
end event

