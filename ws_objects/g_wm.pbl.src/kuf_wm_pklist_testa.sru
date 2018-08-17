$PBExportHeader$kuf_wm_pklist_testa.sru
forward
global type kuf_wm_pklist_testa from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_testa from kuf_wm_pklist
end type
global kuf_wm_pklist_testa kuf_wm_pklist_testa

type variables

end variables

forward prototypes
public subroutine if_isnull (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean if_esiste (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function st_esito tb_update_idpkl (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito tb_delete (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito get_ultimo_doc_ins (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean tb_select (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function st_esito set_stato_importato (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito set_add_note (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function boolean tb_add (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function st_esito get_stato (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito get_note_lotto (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito set_stato_nuovo (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito get_tipo (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito set_tipo_interna (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function st_esito set_note (ref st_tab_wm_pklist kst_tab_wm_pklist)
public function string get_idpkl (st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function string u_get_idpkl_duplicato (ref st_tab_wm_pklist ast_tab_wm_pklist) throws uo_exception
public function long tb_duplica (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function long get_id_wm_pklist_altro (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function long get_id_wm_pklist (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function string get_customerlot (st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function long get_id_wm_pklist_max ()
end prototypes

public subroutine if_isnull (ref st_tab_wm_pklist kst_tab_wm_pklist);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_wm_pklist.id_wm_pklist  ) then kst_tab_wm_pklist.id_wm_pklist  = 0
if isnull(kst_tab_wm_pklist.idpkl  ) then kst_tab_wm_pklist.idpkl  = ""
if isnull(kst_tab_wm_pklist.stato  ) then kst_tab_wm_pklist.stato  = ""
if isnull(kst_tab_wm_pklist.tpimportazione) then kst_tab_wm_pklist.tpimportazione = ""
if isnull(kst_tab_wm_pklist.dtimportazione) then kst_tab_wm_pklist.dtimportazione = datetime(date(0))
if isnull(kst_tab_wm_pklist.idImportazione) then kst_tab_wm_pklist.idImportazione = ""

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

if isnull(kst_tab_wm_pklist.note  ) then kst_tab_wm_pklist.note = ""
if isnull(kst_tab_wm_pklist.note_lotto  ) then kst_tab_wm_pklist.note_lotto = ""
if isnull(kst_tab_wm_pklist.eliminato  ) then kst_tab_wm_pklist.eliminato = ""

if isnull(kst_tab_wm_pklist.id_wm_pklist_padre) then kst_tab_wm_pklist.id_wm_pklist_padre = 0
if isnull(kst_tab_wm_pklist.packinglistcode) then kst_tab_wm_pklist.packinglistcode = ""
if isnull(kst_tab_wm_pklist.customerlot) then kst_tab_wm_pklist.customerlot = ""

if isnull(kst_tab_wm_pklist.x_datins_elim ) then kst_tab_wm_pklist.x_datins_elim = datetime(date(0))
if isnull(kst_tab_wm_pklist.x_utente_elim ) then kst_tab_wm_pklist.x_utente_elim = " "
if isnull(kst_tab_wm_pklist.x_datins) then kst_tab_wm_pklist.x_datins = datetime(date(0))
if isnull(kst_tab_wm_pklist.x_utente) then kst_tab_wm_pklist.x_utente = " "

end subroutine

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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_appo = 0

if len(trim(kst_tab_wm_pklist.idpkl )) > 0 then 
   select distinct 1
	   into :k_appo
	   from  wm_pklist
       where idpkl = :kst_tab_wm_pklist.idpkl  
		     and id_wm_pklist <> :kst_tab_wm_pklist.id_wm_pklist 
			 and (eliminato is null or eliminato <> :kki_ELIMINATO_SI)
       using kguo_sqlca_db_magazzino;
	
	if k_appo > 0 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Lettura Esistenza Packing List (wm_pklist) " + trim(kst_tab_wm_pklist.idpkl ) + "~n~r  " &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca codice Packing List per leggere il Documento (wm_pklist) " 
	kst_esito.esito = kkg_esito.err_logico
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



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Codice Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
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
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
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
boolean k_autorizza
st_esito kst_esito, kst_esito_1
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_meca kst_tab_meca
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
kuf_wm_pklist_righe kuf1_wm_pklist_righe
kuf_armo kuf1_armo

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Packing List' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins_elim = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente_elim = kGuf_data_base.prendi_x_utente()

		update  wm_pklist set
			x_datins_elim = :kst_tab_wm_pklist.x_datins_elim
			,x_utente_elim = :kst_tab_wm_pklist.x_utente_elim
			,eliminato = 'S'
			,x_datins = :kst_tab_wm_pklist.x_datins_elim
			,x_utente = :kst_tab_wm_pklist.x_utente_elim
			where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
			using kguo_sqlca_db_magazzino ;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Packing List' (wm_pklist):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			else
				if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
			
//--- resetto anche la ReceiptGammarad così posso fare la reimportazione	se non è stata ancora READED ovvero accopppiata con le etichette
//			try
			kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
			kst_tab_wm_receiptgammarad.idwmpklist = kst_tab_wm_pklist.id_wm_pklist
//				kuf1_wm_receiptgammarad.tb_delete_x_idwmpklist(kst_tab_wm_receiptgammarad)
			kst_esito = kuf1_wm_receiptgammarad.get_idwmpkl_readed(kst_tab_wm_receiptgammarad)
			if kst_esito.esito <> kkg_esito.db_ko then
				if trim(kst_tab_wm_receiptgammarad.readed) <> "True" then
					select distinct idpkl
						into :kst_tab_wm_receiptgammarad.packinglistcode
						from wm_pklist
						where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
						using kguo_sqlca_db_magazzino;
					if sqlca.sqlcode = 0 then
						kst_tab_wm_receiptgammarad.idwmpklist = 0
						kuf1_wm_receiptgammarad.set_idwmpklist(kst_tab_wm_receiptgammarad)
					end if			
				end if			
			end if			
			if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
			
			kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
			kst_tab_wm_pklist_righe.id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
			kst_esito_1 = kuf1_wm_pklist_righe.get_id_meca_da_id_wm_pklist(kst_tab_wm_pklist_righe)
			destroy kuf1_wm_pklist_righe
			
			if kst_esito_1.esito = kkg_esito.ok and kst_tab_wm_pklist_righe.id_meca > 0 then
				kuf1_armo = create kuf_armo
				kst_tab_meca.id = kst_tab_wm_pklist_righe.id_meca
				kst_tab_meca.id_wm_pklist=0
				kuf1_armo.set_id_wm_pklist(kst_tab_meca)
				destroy kuf1_armo
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
		 group by  month(dtimportazione), year(dtimportazione)
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
		if kst_esito.esito = kkg_esito.ok then
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
					kst_treeview_data_any.st_tab_wm_pklist.dtimportazione = datetime(date(0))
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
datetime k_data_da, k_data_a, k_data_0, k_data_meno5mesi, k_data_meno1mesi
string k_data_da_x, k_data_a_x, k_data_meno5mesi_x, k_data_meno1mesi_x
boolean k_x_mese=true
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
	
//--- Periodo di estrazione, se la data e' a zero allora.....
	kst_treeview_data_any = kst_treeview_data.struttura
	if isdate(string(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione))) and date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione) > date(0) then

//--- calcolo periodo MESE dal primo all'ultimo giorno
		k_x_mese = true
		k_mese = month(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione)) 
		k_anno = year(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione))
		k_data_da = datetime(date (k_anno, k_mese, 01)) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = datetime(date(k_anno, k_mese, 01) )  //datetime(RelativeDate((date(k_anno, k_mese, 01)), -1) )
		
	else
//--- calcolo periodo ULTIMA SETTIMANA		
		k_x_mese = false
		kst_tab_wm_pklist.dtimportazione = datetime(date(0))
		kst_esito = get_ultimo_doc_ins(kst_tab_wm_pklist)
		if kst_esito.esito = kkg_esito.ok then
			k_data_a = datetime(RelativeDate(date(kst_tab_wm_pklist.dtimportazione), +1))
			k_data_da = datetime(relativedate(date(k_data_a) , -7))
		else
		
//--- Ricavo la data da dataoggi
//			kst_treeview_data_any.st_tab_wm_pklist.dtimportazione =  datetime(kG_dataoggi)
			k_data_a = datetime(RelativeDate(kG_dataoggi, +1))
			k_data_da = datetime(RelativeDate(kG_dataoggi, - 7) )
		end if
	end if
	
	k_data_da_x = string(k_data_da)
	k_data_a_x = string(k_data_a)
	
//	if k_data_da = datetime(date(0)) then
//		k_data_da = datetime(RelativeDate( date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione), - 7) )
//		k_data_a = datetime(RelativeDate(date(kst_tab_wm_pklist.dtimportazione), + 1))
//		k_mese = month(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione)) 
//		k_anno = year(date(kst_treeview_data_any.st_tab_wm_pklist.dtimportazione))
//		k_data_da = datetime(date (k_anno, k_mese, 01)) 
//		if k_mese = 12 then
//			k_mese = 1
//			k_anno ++
//		else
//			k_mese = k_mese + 1
//		end if
//		k_data_a = datetime(RelativeDate((date(k_anno, k_mese, 01)), -1) )
//	end if
		 
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
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
		end if
	
//--- data oggi meno diversi mesi
		k_data_meno5mesi = datetime(relativedate(kg_dataoggi, -150))
		k_data_meno5mesi_x = string(k_data_meno5mesi)
		k_data_meno1mesi = datetime(relativedate(kg_dataoggi, -30))
		k_data_meno1mesi_x = string(k_data_meno1mesi)

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
//		if DaysAfter ( date(k_data_da), date(k_data_a) ) > 61 then
//			kst_tab_wm_pklist.dtimportazione = k_data_da
//			kst_esito = get_ultimo_doc_ins(kst_tab_wm_pklist)
//			if kst_esito.esito = kkg_esito.ok then
//				k_data_a = kst_tab_wm_pklist.dtimportazione
//				k_data_da = datetime(relativedate(date(k_data_a) , -7))
//			else
//				//--- se errore non vedo NULLA!
//				k_data_da = k_data_a
//			end if
//		end if


		ktvi_treeviewitem.selected = false

		k_query_select = &
		"  	SELECT distinct " &
		+ "	wm_pklist.id_wm_pklist, " &  
		+ "	wm_pklist.idpkl, " &  
		+ "	wm_pklist.dtimportazione, " &  
		+ "	wm_pklist.stato, " &  
		+ "	wm_pklist.collipkl,   " & 
		+ "	wm_pklist.clie_1,  " & 
		+ "	wm_pklist.clie_2, " &  
		+ "	wm_pklist.clie_3,  " & 
		+ "	wm_pklist.nrddt, 	 " & 				
		+ "	wm_pklist.dtddt,  	 " & 
		+ "	meca.id,  " & 
		+ "	meca.num_bolla_in,  " & 
		+ "	meca.data_bolla_in,  " & 
		+ "	meca.num_int,  " & 
		+ "	meca.data_int,  " & 
		+ "	c1.rag_soc_10	 " &   
		+ "	FROM wm_pklist "       &    
		+ "	  LEFT OUTER JOIN wm_pklist_righe pklr ON  " &   
		+ "	wm_pklist.id_wm_pklist = pklr.id_wm_pklist " &
		+ "	  LEFT OUTER JOIN meca ON  " &   
		+ "	pklr.id_meca = meca.id " &
		+ "	  LEFT OUTER JOIN clienti c1 ON  " &   
		+ "	wm_pklist.clie_1 = c1.codice " 
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett
				k_query_where = " where " &
					+ " (wm_pklist.dtimportazione between  ? and ?) " &
					+ " and (wm_pklist.eliminato is null or wm_pklist.eliminato <> '"+ trim(kki_ELIMINATO_SI) + "' ) " 
					
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
				k_query_where = " where " &
					+ " wm_pklist.dtimportazione > ? " &
					+ " and wm_pklist.stato = '" + trim(kki_STATO_nuovo)  + "'  " &
					+ " and (wm_pklist.eliminato is null or wm_pklist.eliminato <> '"+ trim(kki_ELIMINATO_SI) + "' ) " 
//X PROVA					+ " AND meca.id > 162900 " &
	
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
			prepare SQLSA from :k_query_select using kguo_sqlca_db_magazzino;
		end if		

	
//--- Prima controllo se c'e' qls da trasferire altrimenti evito tutte le letture
		k_ctr = 0
		choose case k_tipo_oggetto
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett 
				kst_tab_wm_pklist.eliminato = trim(kki_ELIMINATO_SI)
				select count(*) 
					into :k_ctr
					from 	wm_pklist
					where wm_pklist.dtimportazione between :k_data_da_x and :k_data_a_x
					         and (wm_pklist.eliminato is null or wm_pklist.eliminato <> :kst_tab_wm_pklist.eliminato)
					using kguo_sqlca_db_magazzino;
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
				kst_tab_wm_pklist.stato = trim(kki_STATO_nuovo)
				kst_tab_wm_pklist.eliminato = trim(kki_ELIMINATO_SI)
				select count(*) 
					into :k_ctr
					from 	wm_pklist
					where wm_pklist.dtimportazione > :k_data_meno5mesi_x
						  and wm_pklist.stato = :kst_tab_wm_pklist.stato
						  and (wm_pklist.eliminato is null or wm_pklist.eliminato <> :kst_tab_wm_pklist.eliminato)
					using kguo_sqlca_db_magazzino;
			case else
				k_ctr = 1
				kguo_sqlca_db_magazzino.sqlcode = 0
		end choose
		 
//--- se c'e' qls allora leggo effettivamente le tabelle
		if k_ctr > 0 then
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_dett 
					open dynamic kc_treeview using :k_data_da_x, :k_data_a_x;
						
		
				case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
					open dynamic kc_treeview using :k_data_meno5mesi_x;
	
				case else
					kguo_sqlca_db_magazzino.sqlcode = 100
	
			end choose
		else
			kguo_sqlca_db_magazzino.sqlcode = 100
		end if		

//--- Inizio ELABORAZIONE --------------------------------------------------------------------------------------		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
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
					:kst_tab_wm_pklist.nrddt,					
					:kst_tab_wm_pklist.dtddt,					
				     :kst_treeview_data_any.st_tab_meca.id,
				     :kst_treeview_data_any.st_tab_meca.num_bolla_in,
				     :kst_treeview_data_any.st_tab_meca.data_bolla_in,
				     :kst_treeview_data_any.st_tab_meca.num_int ,
				     :kst_treeview_data_any.st_tab_meca.data_int,
				     :kst_tab_clienti.rag_soc_10
				  ;
	
			
			do while kguo_sqlca_db_magazzino.sqlcode = 0

				kst_treeview_data.flag = k_x_mese
				
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
					:kst_tab_wm_pklist.nrddt,					
					:kst_tab_wm_pklist.dtddt,					
				     :kst_treeview_data_any.st_tab_meca.id,
				     :kst_treeview_data_any.st_tab_meca.num_bolla_in,
				     :kst_treeview_data_any.st_tab_meca.data_bolla_in,
				     :kst_treeview_data_any.st_tab_meca.num_int ,
				     :kst_treeview_data_any.st_tab_meca.data_int,
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
		choose case k_tipo_oggetto
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett
				if kst_treeview_data.flag then
					k_campo[k_ind] = "Pk-List del mese"
				else
					k_campo[k_ind] = "Pk-List recenti"
				end if
			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
				k_campo[k_ind] = "Pk-List da trasferire"
		end choose
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Caricato il "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "d.d.t.  "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante nominativo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente nominativo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "nr. Lotto (Riferimento)"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "data Lotto (Riferimento)"
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
	
				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
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
					k_stato = "da Trasferire"
				case this.kki_stato_importato
					k_stato = "Trasferito nel Lotto di magazzino"
				case this.kki_stato_chiuso
					k_stato = "Chiuso"
				case this.kki_STATO_NON_importare
					k_stato = "da NON Trasferire"
				case else
					k_stato = "?????????"
			end choose

			kst_tab_clienti_fatt.codice = kst_tab_wm_pklist.clie_3
			kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti_fatt.rag_soc_10 = "???non Trovato???"
			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist.idpkl))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.dtimportazione))
			k_ind++
			if len(trim(kst_treeview_data_any.st_tab_meca.num_bolla_in))  > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) + "   -   "  + string(kst_treeview_data_any.st_tab_meca.data_bolla_in))
			else
				if len(trim(kst_tab_wm_pklist.nrddt))  > 0 then
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist.nrddt) + "  -  "  + string(kst_tab_wm_pklist.dtddt))
				else
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, " - "  )
				end if
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.collipkl ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_1))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti_fatt.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_3))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist.clie_2))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, k_stato + " (stato=" + trim(kst_tab_wm_pklist.stato) + ") " )
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_treeview_data_any.st_tab_meca.num_int))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_treeview_data_any.st_tab_meca.data_int))
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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if isnull(kst_tab_wm_pklist.dtimportazione ) or kst_tab_wm_pklist.dtimportazione = datetime(date(0)) then 
	k_anno = year(KG_DATAOGGI)
else
	k_anno = year(date(kst_tab_wm_pklist.dtimportazione))
end if

select distinct id_wm_pklist, idpkl, dtimportazione
	   into :kst_tab_wm_pklist.id_wm_pklist
			,:kst_tab_wm_pklist.idpkl
			,:kst_tab_wm_pklist.dtimportazione
	   from  wm_pklist
       where id_wm_pklist = 
		 (select max(id_wm_pklist) from wm_pklist 
		           where dtimportazione = 
		 (select distinct max(dtimportazione)  from wm_pklist))
       using sqlca;

//select distinct id_wm_pklist, idpkl, dtimportazione
//	   into :kst_tab_wm_pklist.id_wm_pklist
//			,:kst_tab_wm_pklist.idpkl
//			,:kst_tab_wm_pklist.dtimportazione
//	   from  wm_pklist
//       where exists (select distinct max(dtimportazione) 
//		   from wm_pklist b
//			where wm_pklist.id_wm_pklist = b.id_wm_pklist )
//       using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Esistenza Packing List (wm_pklist) " + trim(kst_tab_wm_pklist.idpkl ) + "~n~r  " &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kGuf_data_base.errori_scrivi_esito( "W", kst_esito) // scrivi LOG
	end if




return kst_esito

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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 
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
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		
		SELECT wm_pklist.idpkl,   
					wm_pklist.stato,   
					wm_pklist.tpimportazione,   
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
					wm_pklist.note,   
				  wm_pklist.note_lotto,  
			     wm_pklist.packinglistcode,
				  wm_pklist.id_wm_pklist_padre,
				  wm_pklist.eliminato,  
				  wm_pklist.customerlot,
					wm_pklist.x_datins_elim,   
					wm_pklist.x_utente_elim,   
					wm_pklist.x_datins,   
					wm_pklist.x_utente  
				into
					:kst_tab_wm_pklist.idpkl,   
					:kst_tab_wm_pklist.stato,   
					:kst_tab_wm_pklist.tpimportazione,   
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
					:kst_tab_wm_pklist.note,   
				  :kst_tab_wm_pklist.note_lotto,  
			     :kst_tab_wm_pklist.packinglistcode,
				  :kst_tab_wm_pklist.id_wm_pklist_padre,
				  :kst_tab_wm_pklist.eliminato,  
				  :kst_tab_wm_pklist.customerlot,
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
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
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

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
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
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function st_esito set_add_note (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Aggiunge NOTE a quelle già presenti nella Packing List 
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist  e  .note
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return
st_tab_wm_pklist kst_tab_wm_pklist_appo
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

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Note Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		select note into :kst_tab_wm_pklist_appo.note
		       from wm_pklist
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
		
		if isnull(kst_tab_wm_pklist.note) then kst_tab_wm_pklist.note = ""

		if isnull(kst_tab_wm_pklist_appo.note) or len(trim(kst_tab_wm_pklist_appo.note)) = 0 then 
			kst_tab_wm_pklist_appo.note = trim(kst_tab_wm_pklist.note)
		else
			kst_tab_wm_pklist_appo.note += "; " + trim(kst_tab_wm_pklist.note)
		end if
		
		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist
				set note = :kst_tab_wm_pklist_appo.note
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Note della Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function boolean tb_add (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Aggiorna Packing List  (testata) se ID_WM_PKLIST=0 fa INSERT altrimenti UPDATE
//=== 
//=== Input: st_tab_wm_pklist
//=== Ritorna:       TRUE=agg. eseguito, FALSE=nessun aggiornamento 
//=== se ERRORE Lancia EXCEPTION
//=== 
//====================================================================
//
int k_resp
boolean k_return=false
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist.id_wm_pklist > 0 then
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 
else
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.inserimento) 
end if

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Aggiornamento Packing-List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if_isnull(kst_tab_wm_pklist)
	kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		UPDATE wm_pklist  
			  SET idpkl = :kst_tab_wm_pklist.idpkl,   
					stato = :kst_tab_wm_pklist.stato,   
					tpimportazione = :kst_tab_wm_pklist.tpimportazione, 
					dtimportazione = :kst_tab_wm_pklist.dtimportazione,   
					idImportazione = :kst_tab_wm_pklist.idImportazione,   
					nrord = :kst_tab_wm_pklist.nrord,   
					dtord = :kst_tab_wm_pklist.dtord,   
					nrddt = :kst_tab_wm_pklist.nrddt,   
					dtddt = :kst_tab_wm_pklist.dtddt,   
					colliddt = :kst_tab_wm_pklist.colliddt,   
					collipkl = :kst_tab_wm_pklist.collipkl,   
					clie_1 = :kst_tab_wm_pklist.clie_1,   
					clie_2 = :kst_tab_wm_pklist.clie_2,   
					clie_3 = :kst_tab_wm_pklist.clie_3,   
					mc_co = :kst_tab_wm_pklist.mc_co,   
					sc_cf = :kst_tab_wm_pklist.sc_cf,   
					note = :kst_tab_wm_pklist.note,   
					note_lotto = :kst_tab_wm_pklist.note_lotto,   
					eliminato = :kst_tab_wm_pklist.eliminato,   
					customerlot = :kst_tab_wm_pklist.customerlot,
					x_datins_elim = :kst_tab_wm_pklist.x_datins_elim,   
					x_utente_elim = :kst_tab_wm_pklist.x_utente_elim,   
					x_datins = :kst_tab_wm_pklist.x_datins,   
					x_utente = :kst_tab_wm_pklist.x_utente   
			WHERE wm_pklist.id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist   
				using kguo_sqlca_db_magazzino;
	
	else
		//id_wm_pklist,   
	  	INSERT INTO wm_pklist  
				( 
				  idpkl,   
				  stato,   
				  tpimportazione,
				  dtimportazione,   
				  idImportazione,
				  nrord,   
				  dtord,   
				  nrddt,   
				  dtddt,   
				  colliddt,   
				  collipkl,   
				  clie_1,   
				  clie_2,   
				  clie_3,   
				  mc_co,   
				  sc_cf,   
				  note,   
				  note_lotto,  
			     packinglistcode,
				  id_wm_pklist_padre,
				  eliminato,  
				  customerlot,
				  x_datins,   
				  x_utente   
				  )  
	  VALUES ( 
				  :kst_tab_wm_pklist.idpkl,   
				  :kst_tab_wm_pklist.stato,   
				  :kst_tab_wm_pklist.tpimportazione,
				  :kst_tab_wm_pklist.dtimportazione,
				  :kst_tab_wm_pklist.idImportazione,
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
				  :kst_tab_wm_pklist.note,   
				  :kst_tab_wm_pklist.note_lotto,   
				  :kst_tab_wm_pklist.packinglistcode,
				  :kst_tab_wm_pklist.id_wm_pklist_padre,
				  :kst_tab_wm_pklist.eliminato,   
				  :kst_tab_wm_pklist.customerlot,
				  :kst_tab_wm_pklist.x_datins,   
				  :kst_tab_wm_pklist.x_utente   
				  )  
				using kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
			kst_tab_wm_pklist.id_wm_pklist = get_id_wm_pklist_max()
			//kst_tab_wm_pklist.id_wm_pklist = long(kguo_sqlca_db_magazzino.SQLReturnData)
		
		end if
	
	end if
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore durante Aggiornamento Testata Packing-List Mandante ~n~r" &
				+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " codice: " &
				+ trim(kst_tab_wm_pklist.idpkl) &	
				+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	
	
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_esito.esito = kkg_esito.ok then
	
				if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
					k_return=true
				end if
			end if
		end if
	
	
	end if
		
end if


return k_return


end function

public function st_esito get_stato (ref st_tab_wm_pklist kst_tab_wm_pklist);//
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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 
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
//	kst_esito.esito = kkg_esito.no_aut
//
//else
//
//	if kst_tab_wm_pklist.id_wm_pklist > 0 then


	select stato
		into :kst_tab_wm_pklist.stato
		from wm_pklist 
		where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Stato del 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if


return kst_esito

end function

public function st_esito get_note_lotto (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Rstituisce le Note_lotto
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 
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
//	kst_esito.esito = kkg_esito.no_aut
//
//else
//
//	if kst_tab_wm_pklist.id_wm_pklist > 0 then


	select note_lotto
		into :kst_tab_wm_pklist.note_lotto
		from wm_pklist 
		where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Note del Lotto del 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if


return kst_esito

end function

public function st_esito set_stato_nuovo (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Cambia lo STATO a NUOVO (come se il Riferimenti fosse fa importare di nuovo) della Packing List 
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

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist
				set stato = :kki_STATO_nuovo
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Nuovo' della Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function st_esito get_tipo (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Rstituisce il campo TIPO 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 
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
//	kst_esito.esito = kkg_esito.no_aut
//
//else
//
//	if kst_tab_wm_pklist.id_wm_pklist > 0 then


	select tipo
		into :kst_tab_wm_pklist.tipo
		from wm_pklist 
		where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura dato 'Tipo' del 'Packing List' (wm_pklist) id=" + string (kst_tab_wm_pklist.id_wm_pklist) + "; " + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if


return kst_esito

end function

public function st_esito set_tipo_interna (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Imposta il TIPO a Packing List Fittizia ovvero a solo uso interno
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

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist
				set tipo = :kki_TIPO_interna
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante impostazione del Tipo Packing-List, generata per uso 'Interno'  ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function st_esito set_note (ref st_tab_wm_pklist kst_tab_wm_pklist);//
//====================================================================
//=== Imposta il campo NOTE del Packing List solo x uso descrittivo
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist / NOTE
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

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist.id_wm_pklist > 0 then

		kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist
				set note = :kst_tab_wm_pklist.note
					,x_datins = :kst_tab_wm_pklist.x_datins
					,x_utente = :kst_tab_wm_pklist.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante impostazione del Tipo Packing-List, generata per uso 'Interno'  ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
					
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
		
	//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function string get_idpkl (st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//------------------------------------------------------------------
//--- Rstituisce codice packing list (idpkl)
//--- inp: st_tab_wm_pklist.id_wm_pklist
//--- rit: idpkl (string)
//--- uo_exception: ST_ESITO
//---           	
//------------------------------------------------------------------
//
string k_return = ""
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select idpkl
		into :kst_tab_wm_pklist.idpkl
		from wm_pklist 
		where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Codice Packling List dalla tabella, id cercato: " + string(kst_tab_wm_pklist.id_wm_pklist) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(kst_tab_wm_pklist.idpkl) > " " then
		k_return = trim(kst_tab_wm_pklist.idpkl)
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try

return k_return

end function

public function string u_get_idpkl_duplicato (ref st_tab_wm_pklist ast_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Restituisce un nuovo IDPKL per fare la DUPLICA
//=== 
//=== Input: st_tab_wm_pklist.idpkl 
//=== Ritorna: il nuovo idpkl
//=== 
//====================================================================
//
string k_return
int k_prg = 1, k_len_pref, k_pos
string k_pref = "STGN"
st_tab_wm_pklist kst_tab_wm_pklist
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if trim(ast_tab_wm_pklist.idpkl) > " " then

//--- controllo se sto duplicando un duplicato, se è così non aggiunge il K_PREF !!!
		k_len_pref = len(trim(k_pref))
		if left(trim(ast_tab_wm_pklist.idpkl), k_len_pref) = k_pref then
			k_pos = pos(trim(ast_tab_wm_pklist.idpkl), "_")
			ast_tab_wm_pklist.idpkl = mid(trim(ast_tab_wm_pklist.idpkl), k_pos + 1)
		end if
		kst_tab_wm_pklist.idpkl = k_pref + trim(string(k_prg)) + "_" + trim(ast_tab_wm_pklist.idpkl)

		//--- verifica se il codice esiste già in archivio esce solo quando è nuovo
		do while if_esiste(kst_tab_wm_pklist) and k_prg < 99
			k_prg ++
			kst_tab_wm_pklist.idpkl = k_pref + trim(string(k_prg)) + "_" + trim(ast_tab_wm_pklist.idpkl)
		loop
		if k_prg > 99 then
			kst_esito.sqlcode = 0
			kst_esito.esito = kkg_esito.ko
			kst_esito.SQLErrText = &
		"Errore generazione nuovo codice Packing-List per duplica, troppi codici duplicati (" + string(k_prg) + ")" //~n~r" &
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else				
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = &
	"Errore generazione nuovo codice Packing-List per duplica, manca il codice" //~n~r" &
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_return = kst_tab_wm_pklist.idpkl
	
return k_return

end function

public function long tb_duplica (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Duplica Packing List (testata) 
//=== 
//=== Input: st_tab_wm_pklist.id_wm_pklist da duplicare, idpkl nuovo 
//=== Ritorna: nuovo id_wm_pklist
//=== se ERRORE Lancia EXCEPTION
//=== 
//====================================================================
//
int k_resp
long k_return
boolean k_sicurezza
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_sicurezza = if_sicurezza(kkg_flag_modalita.inserimento)
if not k_sicurezza then

	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Aggiornamento Packing-List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	kst_tab_wm_pklist.id_wm_pklist_padre = kst_tab_wm_pklist.id_wm_pklist // l'id da duplicare che diventa il PADRE
	kst_tab_wm_pklist.idpkl = kst_tab_wm_pklist.idpkl // il nuovo codice
	kst_tab_wm_pklist.dtimportazione = kGuf_data_base.prendi_dataora()
	kst_tab_wm_pklist.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_wm_pklist.x_datins_elim = datetime(date(0))
	kst_tab_wm_pklist.x_utente_elim = ""
	kst_tab_wm_pklist.note = "Duplicato dal pkl id " + string(kst_tab_wm_pklist.id_wm_pklist) + " il " + string(kst_tab_wm_pklist.x_datins, "dd mmm yy hh:mm") + " da utente cod. " + kst_tab_wm_pklist.x_utente

	if kst_tab_wm_pklist.id_wm_pklist > 0 then
     //id_wm_pklist,   
   	INSERT INTO wm_pklist  
         ( 
           idpkl,   
           stato,   
           tipo,   
           tpimportazione,   
           dtimportazione,   
           idimportazione,   
           nrord,   
           dtord,   
           nrddt,   
           dtddt,   
           colliddt,   
           collipkl,   
           clie_1,   
           clie_2,   
           clie_3,   
           mc_co,   
           sc_cf,   
           note,   
           note_lotto,   
           eliminato,   
           id_wm_pklist_padre,   
           packinglistcode,   
			  customerlot,
           x_datins_elim,   
           x_utente_elim,   
           x_datins,   
           x_utente   
            )  
      SELECT 
            wm_pklist.idpkl,   
            wm_pklist.stato,   
            wm_pklist.tipo,   
            wm_pklist.tpimportazione,   
            wm_pklist.dtimportazione,   
            wm_pklist.idimportazione,   
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
				  :kst_tab_wm_pklist.note,   
            wm_pklist.note_lotto,   
				  '',   
            wm_pklist.x_datins_elim,   
            wm_pklist.x_utente_elim,   
            wm_pklist.id_wm_pklist_padre,   
            wm_pklist.packinglistcode,   
				wm_pklist.customerlot,
				  :kst_tab_wm_pklist.x_datins,   
				  :kst_tab_wm_pklist.x_utente   
       FROM wm_pklist  
		WHERE wm_pklist.id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist   
		using kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
			kst_tab_wm_pklist.id_wm_pklist = get_id_wm_pklist_max( )
			//kst_tab_wm_pklist.id_wm_pklist = long(kguo_sqlca_db_magazzino.SQLReturnData)
			if kst_tab_wm_pklist.id_wm_pklist > 0 then
				k_return = kst_tab_wm_pklist.id_wm_pklist
			end if
		
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore in Duplica Testata del Packing-List, manca id da duplicare!" 
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore in Duplica Testata del Packing-List id " + string(kst_tab_wm_pklist.id_wm_pklist, "####0")  &
				+ " con il nuovo codice " + trim(kst_tab_wm_pklist.idpkl) &	
				+ "~n~rErrore-tab.'wm_pklist': "	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_wm_pklist.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist.st_tab_g_0.esegui_commit) then
	//---- COMMIT....	
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else	
		if kst_esito.esito = kkg_esito.db_ko then
	//---- ROLLBACK....	
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if
		
end if


return k_return


end function

public function long get_id_wm_pklist_altro (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//--
//---  Torna id max del PK-LIST con lo stesso CODICE 
//---
//---  input: kst_tab_wm_pklist.idpkl e id_wm_pklist 
//---  otput: boolean = TRUE pkl gia' in archivio 
//---  se ERRORE lancia un Exception
//---
long k_return
long k_appo
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_appo = 0

if len(trim(kst_tab_wm_pklist.idpkl )) > 0 then 
   select max(id_wm_pklist)
	   into :k_appo
	   from  wm_pklist
       where idpkl = :kst_tab_wm_pklist.idpkl  
		     and id_wm_pklist <> :kst_tab_wm_pklist.id_wm_pklist 
       using kguo_sqlca_db_magazzino;

//			 and (eliminato is null or eliminato <> :kki_ELIMINATO_SI)
	
	if k_appo > 0 then
		k_return = k_appo
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura id Packing List " + trim(kst_tab_wm_pklist.idpkl ) + " diverso da ID " &
			                     + string(kst_tab_wm_pklist.id_wm_pklist) + " in tab wm_pklist~n~r  " &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca codice Packing List per leggere il documento (wm_pklist) per la funzione: get_id_wm_pklist_altro" 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if

return k_return

end function

public function long get_id_wm_pklist (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//--
//---  Torna id_wm_pklist da idpkl 
//---
//---  input: kst_tab_wm_pklist.idpkl e
//---  otput: id_wm_pklist
//---  se ERRORE lancia un Exception
//---
long k_return, k_righe
datastore kds_wm_pklist_testa_x_idpkl
st_esito kst_esito 


try
	
	kds_wm_pklist_testa_x_idpkl = create datastore
	kds_wm_pklist_testa_x_idpkl.dataobject = "ds_wm_pklist_testa_x_idpkl"
	kds_wm_pklist_testa_x_idpkl.settransobject(kguo_sqlca_db_magazzino)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if len(trim(kst_tab_wm_pklist.idpkl )) > 0 then 
		
		k_righe = kds_wm_pklist_testa_x_idpkl.retrieve(kst_tab_wm_pklist.idpkl)
		
//		select id_wm_pklist
//			into :kst_tab_wm_pklist.id_wm_pklist
//			from  wm_pklist
//			 where idpkl = :kst_tab_wm_pklist.idpkl  
//			 using kguo_sqlca_db_magazzino;
		if k_righe < 0 then
		//if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura ID del Packing List " + trim(kst_tab_wm_pklist.idpkl ) + " in tab wm_pklist~n~r  " &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
		if k_righe > 1 then
			kst_esito.SQLErrText = "Errore in lettura Packing List " + trim(kst_tab_wm_pklist.idpkl ) + "~n~r  " &
										 + "Sono stati trovati più ID per lo stesso Packing List:~n~r  " &
										 + "vedi PKL id: " + string(kds_wm_pklist_testa_x_idpkl.getitemnumber(1, "id_wm_pklist")) &
										 + " importato il: " + string(kds_wm_pklist_testa_x_idpkl.getitemdatetime(1, "dtimportazione"))  + "~n~r  " &
										 + "vedi PKL id: " + string(kds_wm_pklist_testa_x_idpkl.getitemnumber(2, "id_wm_pklist")) &
										 + " importato il: " + string(kds_wm_pklist_testa_x_idpkl.getitemdatetime(2, "dtimportazione"))  + "~n~r  " &
										 + "Per utilizzarlo e fare un nuovo ASN occorre duplicarlo. " 
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
		
		if k_righe > 0 then
			kst_tab_wm_pklist.id_wm_pklist = kds_wm_pklist_testa_x_idpkl.getitemnumber(1, "id_wm_pklist")
		else
			kst_tab_wm_pklist.id_wm_pklist = 0
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca codice Packing List per leggere il documento (wm_pklist) per la funzione: get_id_wm_pklist" 
		kst_esito.esito = kkg_esito.err_logico
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if
	
	if kst_tab_wm_pklist.id_wm_pklist > 0 then
	else
		kst_tab_wm_pklist.id_wm_pklist = 0
	end if
	
	k_return = kst_tab_wm_pklist.id_wm_pklist

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kds_wm_pklist_testa_x_idpkl) then destroy kds_wm_pklist_testa_x_idpkl
	
end try

	
return k_return

end function

public function string get_customerlot (st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//------------------------------------------------------------------
//--- Rstituisce codice Lotto caicato dal cliente in packing list (customerlot)
//--- inp: st_tab_wm_pklist.id_wm_pklist
//--- rit: customerlot (string)
//--- uo_exception: ST_ESITO
//---           	
//------------------------------------------------------------------
//
string k_return = ""
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select customerlot
		into :kst_tab_wm_pklist.customerlot
		from wm_pklist 
		where id_wm_pklist = :kst_tab_wm_pklist.id_wm_pklist
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Codice Lotto caricato in Packling List dal cliente, id pkl: " + string(kst_tab_wm_pklist.id_wm_pklist) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(kst_tab_wm_pklist.customerlot) > " " then
		k_return = trim(kst_tab_wm_pklist.customerlot)
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try

return k_return

end function

public function long get_id_wm_pklist_max ();//
//====================================================================
//=== Rstituisce l'ultimo id caricato 
//=== 
//=== Ritorna long
//===           	
//====================================================================
//
long k_return
st_esito kst_esito
st_tab_wm_pklist kst_tab_wm_pklist
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
//boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kst_tab_wm_pklist.id_wm_pklist = 0
	select max(id_wm_pklist)
		into :kst_tab_wm_pklist.id_wm_pklist
		from wm_pklist 
		using kguo_sqlca_db_magazzino ;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultimo 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if

	if kst_tab_wm_pklist.id_wm_pklist > 0 then
		k_return = kst_tab_wm_pklist.id_wm_pklist
	end if
	
return k_return

end function

on kuf_wm_pklist_testa.create
call super::create
end on

on kuf_wm_pklist_testa.destroy
call super::destroy
end on

