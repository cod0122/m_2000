$PBExportHeader$kuf_db_cfg.sru
forward
global type kuf_db_cfg from kuf_parent
end type
end forward

global type kuf_db_cfg from kuf_parent
end type
global kuf_db_cfg kuf_db_cfg

type variables
//
//--- DB da connettere
public constant string kki_codice_xWEB = "DATIXWEB"
public constant string kki_codice_xCRM = "DATIXCRM"
public constant string kki_codice_xPREVISIONI = "DATIXPRE"

private kuo_sqlca_db_xweb kiuo_sqlca_db_xweb
private kuo_sqlca_db_crm kiuo_sqlca_db_crm
private kuo_sqlca_db_previsioni kiuo_sqlca_db_previsioni

private string ki_codice_CONNESSIONE

private  kuo_sqlca_db_0 kiuo_sqlca_db_0

private string ki_blocca_connessione_si = '1'
end variables

forward prototypes
public subroutine get_profilo_db (ref st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
public function boolean if_connessione_bloccata (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception
public function boolean test_connessione () throws uo_exception
public subroutine set_sqlca_db (string a_codice_x)
public function string get_sqlca_db ()
public function boolean db_crea_schema () throws uo_exception
end prototypes

public subroutine get_profilo_db (ref st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//---
//--- Torna il profilo DB x la Connessione
//---
//--- Inpu: kst_tab_db_cfg.codice
//--- Out: kst_tab_db_cfg riempita
//---
//--- Rit: 
//---
//--- lancia Exception
//---
datastore kds_tab_db_cfg
st_esito kst_esito



	kds_tab_db_cfg = create datastore 
	kds_tab_db_cfg.dataobject = "ds_tab_db_cfg"
	kds_tab_db_cfg.settransobject( sqlca )
	
	if kds_tab_db_cfg.retrieve (kst_tab_db_cfg.codice ) > 0 then
		kst_tab_db_cfg.blocca_connessione =  kds_tab_db_cfg.object.blocca_connessione[1]
		kst_tab_db_cfg.cfg_autocommit =  kds_tab_db_cfg.object.cfg_autocommit[1]
		kst_tab_db_cfg.cfg_autocommit_alt =  kds_tab_db_cfg.object.cfg_autocommit_alt[1]
		kst_tab_db_cfg.cfg_dbms =  kds_tab_db_cfg.object.cfg_dbms[1]
		kst_tab_db_cfg.cfg_dbms_alt =  kds_tab_db_cfg.object.cfg_dbms_alt[1]
		kst_tab_db_cfg.cfg_dbms_scelta =  kds_tab_db_cfg.object.cfg_dbms_scelta[1]
		kst_tab_db_cfg.cfg_dbparm =  kds_tab_db_cfg.object.cfg_dbparm[1]
		kst_tab_db_cfg.cfg_dbparm_alt =  kds_tab_db_cfg.object.cfg_dbparm_alt[1]
		kst_tab_db_cfg.codice =  kds_tab_db_cfg.object.codice[1]
		destroy kds_tab_db_cfg
	else
		destroy kds_tab_db_cfg
		
		kst_esito.SQLErrText = "Manca codice parametro indicato in archivio ('db_cfg') per la Connessione al DB ! "
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
		
	end if


end subroutine

public function boolean if_connessione_bloccata (st_tab_db_cfg kst_tab_db_cfg) throws uo_exception;//---
//--- Controlla se il flag di Blocco Connessioni impostato 
//---
//--- Inpu: kst_tab_db_cfg.codice
//--- Out: 
//--- Ritorna: TRUE = connessione BLOCCATA
//---
//--- lancia Exception
//---
boolean k_return = FALSE
st_esito kst_esito
uo_exception kuo_exception
pointer koldpointer




kst_esito.esito =kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
koldpointer = SetPointer(HourGlass!)


select blocca_connessione
	into :kst_tab_db_cfg.blocca_connessione
	from db_cfg
	where codice = :kst_tab_db_cfg.codice
	using sqlca;
	
	
if sqlca.sqlcode <> 0 then
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore in Lettura della tabella di Configurazione DB  Esterno  (DB_CFG)  ~n~r"  + trim(sqlca.SQLErrText)
								 
	if sqlca.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd
	else
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		end if
	end if

	kst_esito.esito = kkg_esito.db_ko
	kuo_exception.set_esito (kst_esito)
	throw kuo_exception

else

	if isnull(kst_tab_db_cfg.blocca_connessione ) then k_return = FALSE

//--- Connessione bloccata?
	if kst_tab_db_cfg.blocca_connessione = ki_blocca_connessione_si then
		k_return = TRUE
	end if
		


end if

SetPointer(koldpointer)
	

return k_return


end function

public function boolean test_connessione () throws uo_exception;//
boolean k_return = false


	try
		
		choose case ki_codice_CONNESSIONE
				
			case kki_codice_xWEB
				if NOT isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
				k_return = kiuo_sqlca_db_xweb.test_connessione( ) 

			case kki_codice_XCRM
				if NOT isvalid(kiuo_sqlca_db_crm) then kiuo_sqlca_db_crm = create kuo_sqlca_db_crm
				k_return = kiuo_sqlca_db_crm.test_connessione( ) 

			case kki_codice_Xprevisioni
				if NOT isvalid(kiuo_sqlca_db_previsioni) then kiuo_sqlca_db_previsioni = create kuo_sqlca_db_previsioni
				k_return = kiuo_sqlca_db_previsioni.test_connessione( ) 


	end choose

		
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try
	

return k_return 

end function

public subroutine set_sqlca_db (string a_codice_x);//---
//--- Tipo di DB (connessione) su cui elaborare
//---

ki_codice_CONNESSIONE = a_codice_x

//kiuo_sqlca_db_0 = auo_sqlca_db_0
end subroutine

public function string get_sqlca_db ();//
return ki_codice_CONNESSIONE


//return kiuo_sqlca_db_0

end function

public function boolean db_crea_schema () throws uo_exception;//
boolean k_return = true


	try
		
		choose case ki_codice_CONNESSIONE
				
			case kki_codice_xWEB
				if NOT isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
				kiuo_sqlca_db_xweb.u_crea_schema( ) 

			case kki_codice_XCRM
				if NOT isvalid(kiuo_sqlca_db_crm) then kiuo_sqlca_db_crm = create kuo_sqlca_db_crm
				kiuo_sqlca_db_crm.u_crea_schema( ) 

			case kki_codice_Xprevisioni
				if NOT isvalid(kiuo_sqlca_db_previsioni) then kiuo_sqlca_db_previsioni = create kuo_sqlca_db_previsioni
				kiuo_sqlca_db_previsioni.u_crea_schema( ) 
				
	end choose

		
	catch (uo_exception kuo_exception)
		k_return = false
		
	end try
	

return k_return 

end function

on kuf_db_cfg.create
call super::create
end on

on kuf_db_cfg.destroy
call super::destroy
end on

