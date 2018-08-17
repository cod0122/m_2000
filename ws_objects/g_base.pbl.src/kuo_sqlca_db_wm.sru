$PBExportHeader$kuo_sqlca_db_wm.sru
forward
global type kuo_sqlca_db_wm from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_wm from kuo_sqlca_db_0
end type
global kuo_sqlca_db_wm kuo_sqlca_db_wm

forward prototypes
protected subroutine x_db_profilo () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
end prototypes

protected subroutine x_db_profilo () throws uo_exception;//
//===	Ritorna: TRUE se tutto OK
//===     Solleva una ECCEZIONE x errore
//
string k_file, k_sezione
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
//kuo_sqlca_db_wm kuo1_sqlca_db_wm


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
kuo_sqlca_db_wm kuo1_sqlca_db_wm 
	

kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

kuo1_sqlca_db_wm = this

kuf1_wm_pklist_cfg.get_profilo_db(kuo1_sqlca_db_wm)

//kuo1_sqlca_db_wm = kuf1_wm_pklist_cfg.get_profilo_db()

this.dbms = kuo1_sqlca_db_wm.dbms
this.dbparm = kuo1_sqlca_db_wm.dbparm
this.AutoCommit = kuo1_sqlca_db_wm.AutoCommit
this.servername = kuo1_sqlca_db_wm.servername
this.logid = kuo1_sqlca_db_wm.logid
this.logpass = kuo1_sqlca_db_wm.logpass

if trim(this.dbms) = "nessuno"  then

	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText =  "Non trovata definizione del 'DB WarehouseManagement' in Proprietà WM ~n~r"+ &
				"Impossibile stabilire la connessione con il DB: ~n~r" +  &
				"(" + trim(this.dbms) + " DbParm " + &
				trim(this.dbparm) + ")~n~r" & 
				+ "Definizione cercata nella Tabella: WM_PKLIST_CFG~n~r" &
				+ " ~n~rNon sara' possibile operare sugli archivi del Server del WM (Magazzino) ~n~r" 
				
//	if isvalid(kuo1_sqlca_db_wm) then destroy kuo1_sqlca_db_wm
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg 
				
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

end if

//if isvalid(kuo1_sqlca_db_wm) then destroy kuo1_sqlca_db_wm
destroy kuf1_wm_pklist_cfg 

SetPointer(oldpointer)



end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg


kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
//--- controlla se connessione bloccata
kuf1_wm_pklist_cfg.get_wm_pklist_cfg( kst_tab_wm_pklist_cfg)

if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_tutto then	
	k_return = TRUE
end if	

return k_return

end function

on kuo_sqlca_db_wm.create
call super::create
end on

on kuo_sqlca_db_wm.destroy
call super::destroy
end on

event constructor;//
 ki_db_descrizione = "DB di scambio dati con il WM"
end event

