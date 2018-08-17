$PBExportHeader$kuf_wm_pklist.sru
forward
global type kuf_wm_pklist from kuf_parent
end type
end forward

global type kuf_wm_pklist from kuf_parent
end type
global kuf_wm_pklist kuf_wm_pklist

type variables
//
//--- Molti campi erano Constant  ma è poi impossibili usarli nelle Query per cui nisba!
//
//---- campo STATO del PK-LIST Mandante
string kki_STATO_nuovo = '1' // nuovo PKL
string kki_STATO_importato = '4' // importato nel Riferimento
string kki_STATO_chiuso = '9' // PKL chiusa

//--- campo ELIMINATO 
string kki_ELIMINATO_SI = 'S'  // riga Cancellata



end variables

forward prototypes
public subroutine if_isnull (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean link_call (ref uo_d_std_1 kdw_1, string k_campo_link) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean if_esiste (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function st_esito tb_update_idpkl (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito get_ultimo_id (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito tb_delete (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito get_ultimo_doc_ins (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function integer u_tree_open (string k_modalita, st_tab_wm_pklist kst_tab_wm_pklist[], ref datawindow kdw_anteprima)
public function boolean u_open (st_tab_wm_pklist kst_tab_wm_pklist[], st_open_w kst_open_w)
public function boolean u_open_applicazione (ref st_tab_wm_pklist kst_tab_wm_pklist, string k_flag_modalita)
public function boolean tb_select (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function st_esito set_stato_importato (ref st_tab_wm_pklist kst_tab_wm_pklist)
end prototypes

public subroutine if_isnull (ref st_tab_wm_pklist kst_tab_wm_pklist);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_wm_pklist.id_wm_pklist  ) then kst_tab_wm_pklist.id_wm_pklist  = 0
if isnull(kst_tab_wm_pklist.idpkl  ) then kst_tab_wm_pklist.idpkl  = ""
if isnull(kst_tab_wm_pklist.stato  ) then kst_tab_wm_pklist.stato  = ""
if isnull(kst_tab_wm_pklist.dtimportazione) then kst_tab_wm_pklist.dtimportazione = datetime(0)

if isnull(kst_tab_wm_pklist.nrord  ) then kst_tab_wm_pklist.nrord  = ""
if isnull(kst_tab_wm_pklist.dtord  ) then kst_tab_wm_pklist.dtord  = date(0)
if isnull(kst_tab_wm_pklist.nrddt   ) then kst_tab_wm_pklist.nrddt   = ""
if isnull(kst_tab_wm_pklist.dtddt   ) then kst_tab_wm_pklist.dtddt   = date(0)

if isnull(kst_tab_wm_pklist.colliddt  ) then kst_tab_wm_pklist.colliddt  = 0
if isnull(kst_tab_wm_pklist.collipkl  ) then kst_tab_wm_pklist.collipkl  = 0

if isnull(kst_tab_wm_pklist.clie_1  ) then kst_tab_wm_pklist.clie_1  = 0
if isnull(kst_tab_wm_pklist.clie_2  ) then kst_tab_wm_pklist.clie_2  = 0
if isnull(kst_tab_wm_pklist.clie_3  ) then kst_tab_wm_pklist.clie_3  = 0
if isnull(kst_tab_wm_pklist.mc_co  ) then kst_tab_wm_pklist.mc_co  = ""
if isnull(kst_tab_wm_pklist.sc_cf  ) then kst_tab_wm_pklist.sc_cf  = ""

if isnull(kst_tab_wm_pklist.eliminato  ) then kst_tab_wm_pklist.eliminato = ""

if isnull(kst_tab_wm_pklist.x_datins_elim ) then kst_tab_wm_pklist.x_datins_elim  = datetime(0)
if isnull(kst_tab_wm_pklist.x_utente_elim ) then kst_tab_wm_pklist.x_utente_elim  = " "
if isnull(kst_tab_wm_pklist.x_datins) then kst_tab_wm_pklist.x_datins = datetime(0)
if isnull(kst_tab_wm_pklist.x_utente) then kst_tab_wm_pklist.x_utente = " "

end subroutine

public function boolean link_call (ref uo_d_std_1 kdw_1, string k_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
st_tab_wm_pklist  kst_tab_wm_pklist
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case k_campo_link

	case "id_wm_pklist", "idpkl"
		kst_tab_wm_pklist.id_wm_pklist  = kdw_1.getitemnumber(kdw_1.getrow(), "id_wm_pklist")
		if kst_tab_wm_pklist.id_wm_pklist  > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_pklist )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Packing List Mandante  (id.=" + trim(string(kst_tab_wm_pklist.id_wm_pklist )) + ") " 
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = get_id_programma( kkg_flag_modalita_elenco ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_pklist kst_tab_wm_pklist);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_wm_pklist_1"  then
			if kdw_anteprima.object.id_wm_pklist [1] = kst_tab_wm_pklist.id_wm_pklist   then
				kst_tab_wm_pklist.id_wm_pklist  = 0 
			end if
		end if
	end if

	if kst_tab_wm_pklist.id_wm_pklist  > 0 then
	
			kdw_anteprima.dataobject = "d_wm_pklist_1"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_wm_pklist.id_wm_pklist )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Packing-List da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito_blok
			
		end if
end if


return kst_esito

end function

public function boolean if_esiste (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//--
//---  Controlla esistenza di PK-LIST con lo stesso CODICE
//---
//---  input: kst_tab_wm_pklist.idpkl e id_wm_pklist x escluderlo (ad esempio  se devo verificare l'esitenza in 'modifica')
//---  otput: boolean = TRUE pkl gia' in archivio 
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_appo
st_esito kst_esito 


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_appo = 0

if len(trim(kst_tab_wm_pklist.idpkl )) > 0 then 
   select distinct 1
	   into :k_appo
	   from  wm_pklist
       where idpkl   =  :kst_tab_wm_pklist.idpkl  and id_wm_pklist <> :kst_tab_wm_pklist.id_wm_pklist 
       using sqlca;
	
	if k_appo > 0 then
		k_return = true
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Esistenza Packing List (wm_pklist) " + trim(kst_tab_wm_pklist.idpkl ) + "~n~r  " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca codice Packing List per leggere il Documento (wm_pklist) " 
	kst_esito.esito = kkg_esito_err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function st_esito tb_update_idpkl (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Cambia il codice della Packing List 
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist il ID da modificare + il nuovo codice in st_tab_wm_pklist.idpkl
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Codice Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kuf1_data_base.prendi_x_utente()
		
		update wm_pklist
				set idpkl = :kst_tab_wm_pklist.idpkl
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica codice Packing List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " codice nuovo " &
					+ trim(kst_tab_wm_pklist.idpkl) &	
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito_db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function st_esito get_ultimo_id (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Rstituisce l'ultimo id caricato 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
//kst_open_w.id_programma = this.get_id_programma(KKG_FLAG_MODALITA_CANCELLAZIONE) 
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_autorizza then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Cancellazione 'Packing List' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = KKG_ESITO_no_aut
//
//else
//
//	if kst_tab_wm_pklist.id_wm_pklist > 0 then


	select max(id_wm_pklist)
		into :kst_tab_wm_pklist.id_wm_pklist
		from wm_pklist 
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultimo 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		end if
	end if


return kst_esito

end function

public function st_esito tb_delete (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Cancella il rek dalla tabella wm_pklist 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = this.get_id_programma(KKG_FLAG_MODALITA_CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Packing List' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins_elim = kuf1_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente_elim = kuf1_data_base.prendi_x_utente()

		update  wm_pklist set
			x_datins_elim = :kst_tab_wm_pklist.x_datins_elim
			,x_utente_elim = :kst_tab_wm_pklist.x_utente_elim
			,eliminato = 'S'
			,x_datins = :kst_tab_wm_pklist.x_datins_elim
			,x_utente = :kst_tab_wm_pklist.x_utente_elim
			where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = KKG_ESITO_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = KKG_ESITO_db_wrn
				else
					kst_esito.esito = KKG_ESITO_db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
					kuf1_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
					kuf1_data_base.db_commit_1( )
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any




declare kc_treeview cursor for
	SELECT 
         count (*), 
         month(dtimportazione) as mese,   
         year(dtimportazione) as anno   
     FROM wm_pklist
		 group by  3, 2
		 order by  3 desc, 2 desc;

		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito_ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[ult-settimana]"
			k_mese_desc[1] = "Gennaio"
			k_mese_desc[2] = "Febbraio"
			k_mese_desc[3] = "Marzo"
			k_mese_desc[4] = "Aprile"
			k_mese_desc[5] = "Maggio"
			k_mese_desc[6] = "Giugno"
			k_mese_desc[7] = "Luglio"
			k_mese_desc[8] = "Agosto"
			k_mese_desc[9] = "Settembre"
			k_mese_desc[10] = "Ottobre"
			k_mese_desc[11] = "Novembre"
			k_mese_desc[12] = "Dicembre"
			k_mese_desc[13] = "NON RILEVATO"

			k_totale = 0
			k_anno_old = 0
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			
					if k_totale > 0 then
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  documenti entrati nell'anno"
						k_totale = 0
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_wm_pklist = kst_tab_wm_pklist
					kst_treeview_data_any.st_tab_wm_pklist.dtimportazione = datetime(0)
//					kst_treeview_data_any.st_tab_wm_pklist.num_int = k_anno
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_wm_pklist.dtimportazione = datetime(date(k_anno,01,01))
				else			
					kst_tab_wm_pklist.dtimportazione = datetime(date(k_anno,k_mese,01))
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  documento presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  documenti presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Packing List Mandante " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_wm_pklist = kst_tab_wm_pklist
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

//	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
					into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			loop

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: Testata Fatture
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_query_select, k_query_where, k_query_order
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi
int k_ind, k_ctr
string k_label
//alignment k_align[15]
//alignment k_align_1
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_clienti kst_tab_clienti




	k_data_0 = datetime(date(0)	)

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
//--- item di ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  

	k_data_da = datetime(date(0))
	k_data_a = datetime(date(0))
	
//--- Periodo di estrazione, se la data e' a zero allora anno in DATAOGGI
	kst_treeview_data_any = kst_treeview_data.struttura
	if date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione) = date (0) then

//--- Ricavo la data da dataoggi
		kst_treeview_data_any.st_tab_wm_pklist.dtimportazione = datetime(kG_dataoggi)
		
	end if
	
	if k_data_da = datetime(date(0)) then
		k_mese = month(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione)) 
		k_anno = year(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione))
		k_data_da = datetime(date (k_anno, k_mese, 01)) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = datetime(RelativeDate((date(k_anno, k_mese, 01)), -1) )
	end if
		 
	k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito_ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
		end if
	
//--- data oggi -3 mesi
		k_data_meno3mesi = datetime(relativedate(kg_dataoggi, -1190))

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
		if DaysAfter ( date(k_data_da), date(k_data_a) ) > 61 then
			kst_tab_wm_pklist.dtimportazione = k_data_da
			kst_esito = get_ultimo_doc_ins(kst_tab_wm_pklist)
			if kst_esito.esito = kkg_esito_ok then
				k_data_a = kst_tab_wm_pklist.dtimportazione
				k_data_da = datetime(relativedate(date(k_data_a) , -7))
			else
				//--- se errore non vedo NULLA!
				k_data_da = k_data_a
			end if
		end if


		ktvi_treeviewitem.selected = false

		k_query_select = &
		"  	SELECT " &
		+ "	wm_pklist.id_wm_pklist, " &  
		+ "	wm_pklist.idpkl, " &  
		+ "	wm_pklist.dtimportazione, " &  
		+ "	wm_pklist.stato, " &  
		+ "	wm_pklist.collipkl,   " & 
		+ "	wm_pklist.clie_1,  " & 
		+ "	wm_pklist.clie_2, " &  
		+ "	wm_pklist.clie_3,  " & 
		+ "	c1.rag_soc_10	 " &   
		+ "	FROM wm_pklist "       &    
		+ "	  INNER JOIN clienti c1 ON  " &   
		+ "	wm_pklist.clie_1 = c1.codice " 
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett
				k_query_where = " where " &
					+ "  (wm_pklist.eliminato is null or wm_pklist.eliminato <> '"+ trim(kki_ELIMINATO_SI) + "' ) " &
					+ "  and (wm_pklist.dtimportazione between  ? and ?) "
					
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
				k_query_where = " where " &
					+ "  (wm_pklist.eliminato is null or wm_pklist.eliminato <> '"+ trim(kki_ELIMINATO_SI) + "' ) " &
					+ " and wm_pklist.dtimportazione > ? " &
					+ " and wm_pklist.stato = '" + trim(kki_STATO_nuovo)  + "'  "
	
			case else
					k_query_where = " "
	
		end choose
	
		k_query_order = &
		 " order by " &
		+ "	wm_pklist.dtimportazione, wm_pklist.id_wm_pklist "
	
	//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		

		 
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett 
				open dynamic kc_treeview using :k_data_da, :k_data_a;
					
	
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
				open dynamic kc_treeview using :k_data_meno3mesi;

			case else
				sqlca.sqlcode = 100

		end choose
		
		if sqlca.sqlcode = 0 then
			
			
			fetch kc_treeview 
				into
					:kst_tab_wm_pklist.id_wm_pklist,   
					:kst_tab_wm_pklist.idpkl,   
					:kst_tab_wm_pklist.dtimportazione,   
					:kst_tab_wm_pklist.stato,   
					:kst_tab_wm_pklist.collipkl,   
					:kst_tab_wm_pklist.clie_1,   
					:kst_tab_wm_pklist.clie_2,   
					:kst_tab_wm_pklist.clie_3,   
				   :kst_tab_clienti.rag_soc_10
				  ;
	
			
			do while sqlca.sqlcode = 0

				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data.struttura = kst_treeview_data_any

				if_isnull(kst_tab_wm_pklist)
				if isnull(kst_tab_clienti.rag_soc_10) then	kst_tab_clienti.rag_soc_10 = " "
				
				kst_treeview_data_any.st_tab_wm_pklist = kst_tab_wm_pklist
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = &
											  trim(kst_tab_wm_pklist.idpkl) &
											  + " - " + string(kst_tab_wm_pklist.dtimportazione, "dd.mmm") &
											  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
											  + "  ("  &
											  +  string(kst_tab_wm_pklist.clie_1, "#####") + ") "

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				kst_treeview_data.pic_list = kst_tab_treeview.pic_list
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
	
				fetch kc_treeview 
				into
					:kst_tab_wm_pklist.id_wm_pklist,   
					:kst_tab_wm_pklist.idpkl,   
					:kst_tab_wm_pklist.dtimportazione,   
					:kst_tab_wm_pklist.stato,   
					:kst_tab_wm_pklist.collipkl,   
					:kst_tab_wm_pklist.clie_1,   
					:kst_tab_wm_pklist.clie_2,   
					:kst_tab_wm_pklist.clie_3,   
				   :kst_tab_clienti.rag_soc_10
				  ;
	
			loop
			
			close kc_treeview;
			
	
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre, k_tipo_doc, k_stato
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_clienti kst_tab_clienti, kst_tab_clienti_fatt
st_tab_treeview kst_tab_treeview
kuf_clienti kuf1_clienti
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)

	end if
	
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item = 0 or isnull(k_handle_item) then	
	
//--- item di ritorno di default
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
	k_handle_item_corrente = k_handle_item

//--- item di ritorno di default
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_padre = kst_treeview_data.oggetto	

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
//--- item di ritorno (vedi anche alla fine)
	if k_handle_item_padre > 0 then
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Codice Pk-List"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Caricato il "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante nominativo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente nominativo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "id "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=1
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"
	
				kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop
	
		end if
	
	
//--- imposto il pic corretto
//		k_handle = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			

	
		kuf1_clienti = create kuf_clienti

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_wm_pklist = kst_treeview_data_any.st_tab_wm_pklist
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			choose case kst_tab_wm_pklist.stato
				case this.kki_stato_nuovo
					k_stato = "da Importare"
				case this.kki_stato_importato
					k_stato = "Importato nel Lotto di magazzino"
				case this.kki_stato_chiuso
					k_stato = "Chiuso"
				case else
					k_stato = "?????????"
			end choose

			kst_tab_clienti_fatt.codice = kst_tab_wm_pklist.clie_3
			kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
			if kst_esito.esito <> kkg_esito_ok then
				kst_tab_clienti_fatt.rag_soc_10 = "???non Trovato???"
			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist.idpkl))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.dtimportazione))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, k_stato + " (" + trim(kst_tab_wm_pklist.stato) + ") " )
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_1))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_2))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_3))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti_fatt.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.collipkl ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.id_wm_pklist)) 
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		destroy kuf1_clienti
		
	end if
 
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if
		 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

 
 
 


end function

public function st_esito get_ultimo_doc_ins (ref st_tab_wm_pklist kst_tab_wm_pklist);//--
//---  Prende l'ulimo documento caricato
//---
//---  input: 
//---  otput: kst_tab_wm_pklist id_wm_pklist, idpklist, dtimportazione
//---  se ERRORE lancia un Exception
//---
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if isnull(kst_tab_wm_pklist.dtimportazione ) or kst_tab_wm_pklist.dtimportazione = datetime(0) then 
	k_anno = year(KG_DATAOGGI)
else
	k_anno = year(date(kst_tab_wm_pklist.dtimportazione))
end if

select distinct id_wm_pklist, idpkl, dtimportazione
	   into :kst_tab_wm_pklist.id_wm_pklist
			,:kst_tab_wm_pklist.idpkl
			,:kst_tab_wm_pklist.dtimportazione
	   from  wm_pklist
       where exists (select max(dtimportazione) 
		   from wm_pklist b
			where wm_pklist.id_wm_pklist = b.id_wm_pklist )
       using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Esistenza Packing List (wm_pklist) " + trim(kst_tab_wm_pklist.idpkl ) + "~n~r  " &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
	end if




return kst_esito

end function

public function integer u_tree_open (string k_modalita, st_tab_wm_pklist kst_tab_wm_pklist[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0
datastore kds_1
st_esito kst_esito
st_open_w kst_open_w



if upperbound(kst_tab_wm_pklist) > 0 then

	choose case k_modalita  

		case kkg_flag_modalita_anteprima

			if kst_tab_wm_pklist[1].id_wm_pklist > 0 then
				kds_1 = create datastore
				kst_esito = anteprima ( kds_1, kst_tab_wm_pklist[1])
				if kst_esito.esito = kkg_esito_db_ko then
					k_return = 1
					kguo_exception.set_esito( kst_esito )
				// setmessage( "Accesso al Documento di Vendita non disponibile. ")
					kguo_exception.messaggio_utente( )
				else

					kdw_anteprima.dataobject = kds_1.dataobject
					kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
					
				end if
				destroy kds_1
			end if

				
		case else

			kst_open_w.flag_modalita = k_modalita			
			if not this.u_open( kst_tab_wm_pklist[], kst_open_w ) then  //Apre le Varie Funzioni
				k_return = 1
				
				kguo_exception.setmessage( "Operazione di Accesso al Packing List fallita. ")
				kguo_exception.messaggio_utente( )
			end if
				
				
				
	end choose		


end if	
 
 
return k_return

end function

public function boolean u_open (st_tab_wm_pklist kst_tab_wm_pklist[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_.... con ID valorizzato se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
boolean  k_return = true
integer k_ind
st_esito kst_esito


k_ind=1 

		choose case kst_open_w.flag_modalita  
				

			case kkg_flag_modalita_stampa
//				this.u_open_vmcs(kst_tab_sped[])		
				
			case kkg_flag_modalita_cancellazione
				this.u_open_applicazione(kst_tab_wm_pklist[k_ind], kkg_flag_modalita_cancellazione)
				
			case kkg_flag_modalita_modifica
				this.u_open_applicazione(kst_tab_wm_pklist[k_ind], kkg_flag_modalita_modifica)
				
			case kkg_flag_modalita_inserimento
				this.u_open_applicazione(kst_tab_wm_pklist[k_ind], kkg_flag_modalita_inserimento)
				
			case kkg_flag_modalita_visualizzazione
				this.u_open_applicazione(kst_tab_wm_pklist[k_ind], kkg_flag_modalita_visualizzazione)
				
			case else
					
					
			end choose		
			
 
 
return k_return

end function

public function boolean u_open_applicazione (ref st_tab_wm_pklist kst_tab_wm_pklist, string k_flag_modalita);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_tab_wm_pklist.id_wm_pklist
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---


boolean k_return = false
st_esito kst_esito 
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_wm_pklist.id_wm_pklist > 0 or k_flag_modalita = kkg_flag_modalita_inserimento then
	
	if k_flag_modalita = kkg_flag_modalita_inserimento then kst_tab_wm_pklist.id_wm_pklist = 0
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = get_id_programma( k_flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = k_flag_modalita
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_wm_pklist.id_wm_pklist)) // id wm pklist
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window


end if


return k_return



return k_return


end function

public function boolean tb_select (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Select di tutti i campi della tabella 
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist
//=== Ritorna:  TRUE = lettura OK, FALSE = nessuna lettura eseguita    
//=== Lanca UO_EXCEPTION
//====================================================================
//
boolean k_return=false
st_esito kst_esito
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w.flag_modalita = kkg_flag_modalita_modifica
//kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_anteprima) 
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
//	kst_esito.SQLErrText = "Modifica Codice Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito_no_aut
//
//else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		
		SELECT wm_pklist.idpkl,   
					wm_pklist.stato,   
					wm_pklist.dtimportazione,   
					wm_pklist.nrord,   
					wm_pklist.dtord,   
					wm_pklist.nrddt,   
					wm_pklist.dtddt,   
					wm_pklist.colliddt,   
					wm_pklist.collipkl,   
					wm_pklist.clie_1,   
					wm_pklist.clie_2,   
					wm_pklist.clie_3,   
					wm_pklist.mc_co,   
					wm_pklist.sc_cf,   
					wm_pklist.eliminato,   
					wm_pklist.x_datins_elim,   
					wm_pklist.x_utente_elim,   
					wm_pklist.x_datins,   
					wm_pklist.x_utente  
				into
					:kst_tab_wm_pklist.idpkl,   
					:kst_tab_wm_pklist.stato,   
					:kst_tab_wm_pklist.dtimportazione,   
					:kst_tab_wm_pklist.nrord,   
					:kst_tab_wm_pklist.dtord,   
					:kst_tab_wm_pklist.nrddt,   
					:kst_tab_wm_pklist.dtddt,   
					:kst_tab_wm_pklist.colliddt,   
					:kst_tab_wm_pklist.collipkl,   
					:kst_tab_wm_pklist.clie_1,   
					:kst_tab_wm_pklist.clie_2,   
					:kst_tab_wm_pklist.clie_3,   
					:kst_tab_wm_pklist.mc_co,   
					:kst_tab_wm_pklist.sc_cf,   
					:kst_tab_wm_pklist.eliminato,   
					:kst_tab_wm_pklist.x_datins_elim,   
					:kst_tab_wm_pklist.x_utente_elim,   
					:kst_tab_wm_pklist.x_datins,   
					:kst_tab_wm_pklist.x_utente  
			 FROM wm_pklist  
			WHERE wm_pklist.id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist   
			         and eliminato <> :kki_ELIMINATO_SI
				using sqlca;
			
		if sqlca.sqlcode = 0 then
			k_return=true			
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante Lettura Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0")  &
					+ trim(kst_tab_wm_pklist.idpkl) &	
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
			
			kuo_exception = create uo_exception 
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
			
		end if
	end if
		
//end if


return k_return

end function

public function st_esito set_stato_importato (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Cambia lo STATO a IMPORTATO della Packing List 
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kuf1_data_base.prendi_x_utente()
		
		update wm_pklist
				set stato = :kki_STATO_importato
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Importato' della Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito_db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

on kuf_wm_pklist.create
call super::create
end on

on kuf_wm_pklist.destroy
call super::destroy
end on

