$PBExportHeader$kuf_wm_pklist_righe.sru
forward
global type kuf_wm_pklist_righe from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_righe from kuf_wm_pklist
end type
global kuf_wm_pklist_righe kuf_wm_pklist_righe

type variables

end variables

forward prototypes
public subroutine if_isnull (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function st_esito tb_delete (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito set_stato_importato (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function st_esito set_dati_lotto (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function boolean tb_add (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function st_esito get_id_wm_pklist_da_id_meca (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function integer get_nr_pallet (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function long tb_select_x_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe[]) throws uo_exception
public function st_esito set_sped_si (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function boolean get_insped (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function integer get_da_spedire_x_id_armo (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function st_esito set_sped_no (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function st_esito set_sped_no_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function st_esito set_sped_si_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function st_esito if_esiste_in_sped_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function boolean set_stato_importato_x_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function boolean set_dati_lotto_x_id_wm_pklist (long a_nr_righe, ref st_tab_wm_pklist_righe ast_tab_wm_pklist_righe[]) throws uo_exception
public function integer get_nr_pallet_wm_associati (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function st_esito get_id_meca_da_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function long get_id_armo_da_wm_barcode (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception
public function long get_id_wm_pklist_riga_max () throws uo_exception
private subroutine u_set_col_len_max (string k_ope, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function string get_idlotto_clie (st_tab_wm_pklist_righe ast_tab_wm_pklist_righe) throws uo_exception
end prototypes

public subroutine if_isnull (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_wm_pklist_righe.id_wm_pklist_riga   ) then kst_tab_wm_pklist_righe.id_wm_pklist_riga   = 0
if isnull(kst_tab_wm_pklist_righe.id_wm_pklist   ) then kst_tab_wm_pklist_righe.id_wm_pklist   = 0
if isnull(kst_tab_wm_pklist_righe.stato  ) then kst_tab_wm_pklist_righe.stato  = ""
if isnull(kst_tab_wm_pklist_righe.idart_clie   ) then kst_tab_wm_pklist_righe.idart_clie   = ""
if isnull(kst_tab_wm_pklist_righe.idlotto_clie    ) then kst_tab_wm_pklist_righe.idlotto_clie    = ""


if isnull(kst_tab_wm_pklist_righe.wm_barcode  ) then kst_tab_wm_pklist_righe.wm_barcode  = ""
if isnull(kst_tab_wm_pklist_righe.barcode  ) then kst_tab_wm_pklist_righe.barcode  = ""

if isnull(kst_tab_wm_pklist_righe.colli  ) then kst_tab_wm_pklist_righe.colli  = 0
if isnull(kst_tab_wm_pklist_righe.qtapezzi_pallet  ) then kst_tab_wm_pklist_righe.qtapezzi_pallet  = 0
if isnull(kst_tab_wm_pklist_righe.idpezzo_clie  ) then kst_tab_wm_pklist_righe.idpezzo_clie  = ""
if isnull(kst_tab_wm_pklist_righe.areamag  ) then kst_tab_wm_pklist_righe.areamag  = ""

if isnull(kst_tab_wm_pklist_righe.id_armo   ) then kst_tab_wm_pklist_righe.id_armo   = 0
if isnull(kst_tab_wm_pklist_righe.id_meca  ) then kst_tab_wm_pklist_righe.id_meca  = 0
if isnull(kst_tab_wm_pklist_righe.gruppo  ) then kst_tab_wm_pklist_righe.gruppo  = 0

if isnull(kst_tab_wm_pklist_righe.eliminato  ) then kst_tab_wm_pklist_righe.eliminato = ""

if isnull(kst_tab_wm_pklist_righe.x_datins_elim ) then kst_tab_wm_pklist_righe.x_datins_elim  = datetime(date(0))
if isnull(kst_tab_wm_pklist_righe.x_utente_elim ) then kst_tab_wm_pklist_righe.x_utente_elim  = " "
if isnull(kst_tab_wm_pklist_righe.x_datins) then kst_tab_wm_pklist_righe.x_datins = datetime(date(0))
if isnull(kst_tab_wm_pklist_righe.x_utente) then kst_tab_wm_pklist_righe.x_utente = ""

end subroutine

public function st_esito tb_delete (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
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
	kst_esito.SQLErrText = "Cancellazione Riga 'Packing List' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga  > 0 then

		kst_tab_wm_pklist_righe.x_datins_elim = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente_elim = kGuf_data_base.prendi_x_utente()

		update  wm_pklist set
			x_datins_elim = :kst_tab_wm_pklist_righe.x_datins_elim
			,x_utente_elim = :kst_tab_wm_pklist_righe.x_utente_elim
			,eliminato = 'S'
			,x_datins = :kst_tab_wm_pklist_righe.x_datins_elim
			,x_utente = :kst_tab_wm_pklist_righe.x_utente_elim
			where id_wm_pklist_riga  = :kst_tab_wm_pklist_righe.id_wm_pklist_riga 
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione Riga 'Packing List' (wm_pklist):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);////
////--- Visualizza Treeview: Testata Fatture
////
integer k_return = 0, k_rc
//long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
//integer k_pic_open, k_pic_close, k_mese, k_anno
//string k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
//string k_query_select, k_query_where, k_query_order
//int k_ind, k_ctr
//string k_campo[15], k_label
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_wm_pklist kst_tab_wm_pklist
//st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
//st_tab_meca kst_tab_meca
//st_tab_gru kst_tab_gru
//
//
//
//
//
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//		 
////--- Ricavo il handle del Padre e il tipo Oggetto
//	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
////--- item di ritorno di default
//		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//
//	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//
//	
////--- ID di estrazione, se a a zero allora Nulla
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist > 0 then
//
//		 
//		k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//	
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_tipo_oggetto_nonno = kst_treeview_data.oggetto
//			 
//		k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//	
//	//--- Procedo alla lettura della tab solo se non ho figli 
//		if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
//			
//	//--- Imposta le propietà di default della tree 
//			kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)
//	
//	//--- Preleva dall'archivio dati di conf della tree 
//			kst_tab_treeview.id = trim(k_tipo_oggetto)
//			kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
//			if kst_esito.esito = kkg_esito.ok then
//				ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
//				ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			end if
//		
//	//--- Cancello gli Item dalla tree prima di ripopolare
//			kuf1_treeview.u_delete_item_child(k_handle_item_padre)
//	
//			ktvi_treeviewitem.selected = false
//	
//			k_query_select = &
//			"  	SELECT " &
//			+ "	wm_pklist_righe.id_wm_pklist_riga, " &  
//			+ "	wm_pklist.idpkl, " &  
//			+ "	wm_pklist_righe.areamag, " &  
//			+ "	wm_pklist_righe.stato, " &  
//			+ "	wm_pklist_righe.colli,   " & 
//			+ "	wm_pklist_righe.idart_clie,  " & 
//			+ "	wm_pklist_righe.id_armo, " &  
//			+ "	wm_pklist_righe.id_meca, " &  
//			+ "	wm_pklist_righe.gruppo,  " & 
//			+ "	gru.des	 " &   
//			+ "	,meca.num_int	 " &   
//			+ "	,meca.data_int	 " &   
//			+ "	FROM wm_pklist_righe "       &    
//			+ "	  inner JOIN wm_pklist ON  " &   
//			+ "	wm_pklist_righe.id_wm_pklist = wm_pklist.id_wm_pklist " &
//			+ "	  left outer JOIN gru ON  " &   
//			+ "	wm_pklist_righe.gruppo = gru.codice " &
//			+ "	  left outer JOIN meca ON  " &   
//			+ "	wm_pklist_righe.id_meca = meca.id " 
//			
//			k_query_where = " where " &
//				+ "  wm_pklist_righe.id_wm_pklist = "+ string(kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist) + " " 
//		
//			k_query_order = &
//			 " order by " &
//				+ "	wm_pklist_righe.areamag, wm_pklist_righe.id_wm_pklist_riga "
//		
//		//--- Composizione della Query	
//			if len(trim(k_query_where)) > 0 then
//				declare kc_treeview dynamic cursor for SQLSA ;
//				k_query_select = k_query_select + k_query_where + k_query_order
//				prepare SQLSA from :k_query_select using sqlca;
//			end if		
//			 
//			open dynamic kc_treeview ;
//						
//			if sqlca.sqlcode = 0 then
//				
//				fetch kc_treeview 
//					into
//						:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
//						:kst_tab_wm_pklist.idpkl,   
//						:kst_tab_wm_pklist_righe.areamag,   
//						:kst_tab_wm_pklist_righe.stato,   
//						:kst_tab_wm_pklist_righe.colli,   
//						:kst_tab_wm_pklist_righe.idart_clie,   
//						:kst_tab_wm_pklist_righe.id_armo,   
//						:kst_tab_wm_pklist_righe.id_meca,   
//						:kst_tab_wm_pklist_righe.gruppo,   
//						:kst_tab_gru.des
//						,:kst_tab_meca.num_int	    
//						,:kst_tab_meca.data_int	    
//					  ;
//		
//				
//				do while sqlca.sqlcode = 0
//	
//					
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//					kst_treeview_data.oggetto_padre = k_tipo_oggetto
//					kst_treeview_data.struttura = kst_treeview_data_any
//	
//					if_isnull(kst_tab_wm_pklist_righe)
//					if isnull(kst_tab_gru.des) then	kst_tab_gru.des = " "
//					
//					kst_treeview_data_any.st_tab_wm_pklist_righe = kst_tab_wm_pklist_righe
//					kst_treeview_data_any.st_tab_wm_pklist = kst_tab_wm_pklist
//					kst_treeview_data_any.st_tab_gru = kst_tab_gru
//					kst_treeview_data_any.st_tab_meca = kst_tab_meca
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//					
//					kst_treeview_data.struttura = kst_treeview_data_any
//					
//					kst_treeview_data.label = " " 
//	
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data.handle = k_handle_item_padre
//					kst_treeview_data.pic_list = kst_tab_treeview.pic_list
//		
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//											  
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//					
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//	
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//	
//					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//		
//					fetch kc_treeview 
//					into
//						:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
//						:kst_tab_wm_pklist.idpkl,   
//						:kst_tab_wm_pklist_righe.areamag,   
//						:kst_tab_wm_pklist_righe.stato,   
//						:kst_tab_wm_pklist_righe.colli,   
//						:kst_tab_wm_pklist_righe.idart_clie,   
//						:kst_tab_wm_pklist_righe.id_armo,   
//						:kst_tab_wm_pklist_righe.id_meca,   
//						:kst_tab_wm_pklist_righe.gruppo,   
//						:kst_tab_gru.des
//						,:kst_tab_meca.num_int	    
//						,:kst_tab_meca.data_int	    
//					  ;
//		
//				loop
//				
//				close kc_treeview;
//				
//		
//			end if
//		end if
//
//	end if 
// 
return k_return
//
//
end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc, k_pic_list
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
long k_handle_item_figlio = 0
string k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
integer k_ctr
string k_stato_barcode="", k_tipo_oggetto_padre, k_label, k_stato
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_gru kst_tab_gru
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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
	if k_handle_item_figlio <= 0 then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		k_pic_list = kuf1_treeview.u_dammi_pic_tree_list(k_tipo_oggetto)			

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
//--- cancello dalla listview tutto
		kuf1_treeview.kilv_lv1.DeleteItems()

		ktvi_treeviewitem.selected = false

//--- Insert del primo item in lista quello di default del 'ritorno'
		kst_treeview_data.oggetto = k_tipo_oggetto
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)


				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Codice Pk-List - righe "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "area magazzino "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Articolo del Mandante "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Lotto del Mandante "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Gruppo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Lotto "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "id riga "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
//--- controllo in modo un po' emirico di non essere già dentro 	all'elenco confrontando un campo	
		k_ind=2
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
	

		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

	
//--- ID di estrazione, se a a zero allora Nulla
		kst_treeview_data_any = kst_treeview_data.struttura
		if kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist > 0 then


			k_query_select = &
			"  	SELECT " &
			+ "	wm_pklist_righe.id_wm_pklist_riga, " &  
			+ "	wm_pklist.idpkl, " &  
			+ "	wm_pklist_righe.areamag, " &  
			+ "	wm_pklist_righe.stato, " &  
			+ "	wm_pklist_righe.colli,   " & 
			+ "	wm_pklist_righe.idart_clie,  " & 
			+ "	wm_pklist_righe.idlotto_clie, " &   
			+ "	wm_pklist_righe.id_armo, " &  
			+ "	wm_pklist_righe.id_meca, " &  
			+ "	wm_pklist_righe.gruppo,  " & 
			+ "	gru.des	 " &   
			+ "	,meca.num_int	 " &   
			+ "	,meca.data_int	 " &   
			+ "	FROM wm_pklist_righe "       &    
			+ "	  inner JOIN wm_pklist ON  " &   
			+ "	wm_pklist_righe.id_wm_pklist = wm_pklist.id_wm_pklist " &
			+ "	  left outer JOIN gru ON  " &   
			+ "	wm_pklist_righe.gruppo = gru.codice " &
			+ "	  left outer JOIN meca ON  " &   
			+ "	wm_pklist_righe.id_meca = meca.id " 
			
			k_query_where = " where " &
				+ "  wm_pklist_righe.id_wm_pklist = "+ string(kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist) + " " 
		
			k_query_order = &
			 " order by " &
				+ "	wm_pklist_righe.areamag, wm_pklist_righe.id_wm_pklist_riga "
		
		//--- Composizione della Query	
			if len(trim(k_query_where)) > 0 then
				declare kc_treeview dynamic cursor for SQLSA ;
				k_query_select = k_query_select + k_query_where + k_query_order
				prepare SQLSA from :k_query_select using sqlca;
			end if		
			 
			open dynamic kc_treeview ;
						
						
			if sqlca.sqlcode = 0 then
				
				fetch kc_treeview 
					into
						:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
						:kst_tab_wm_pklist.idpkl,   
						:kst_tab_wm_pklist_righe.areamag,   
						:kst_tab_wm_pklist_righe.stato,   
						:kst_tab_wm_pklist_righe.colli,   
						:kst_tab_wm_pklist_righe.idart_clie,   
						:kst_tab_wm_pklist_righe.idlotto_clie,   
						:kst_tab_wm_pklist_righe.id_armo,   
						:kst_tab_wm_pklist_righe.id_meca,   
						:kst_tab_wm_pklist_righe.gruppo,   
						:kst_tab_gru.des
						,:kst_tab_meca.num_int	    
						,:kst_tab_meca.data_int	    
					  ;
		
				
				do while sqlca.sqlcode = 0
	
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data.struttura = kst_treeview_data_any
				kst_treeview_data.oggetto_listview = k_tipo_oggetto
				
				klvi_listviewitem.data = kst_treeview_data

				klvi_listviewitem.pictureindex = k_pic_list
			   
				klvi_listviewitem.selected = false
				
				k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

		
					choose case kst_tab_wm_pklist_righe.stato
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
		
					k_ind=1
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist.idpkl))
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist_righe.areamag))
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, k_stato + " (stato=" + trim(kst_tab_wm_pklist_righe.stato) + ") " )
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist_righe.idart_clie))
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist_righe.idlotto_clie))
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.gruppo) + " - " +  trim(kst_tab_gru.des))
					k_ind++
					if kst_treeview_data_any.st_tab_meca.num_int > 0 then
						kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_treeview_data_any.st_tab_meca.num_int) + " del " +  string(kst_treeview_data_any.st_tab_meca.data_int))
					else
						kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, " ")
					end if
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.colli))
					k_ind++
					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.id_wm_pklist_riga)) 
					
					
		//--- Leggo rec next dalla tree				
					k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

					fetch kc_treeview 
						into
							:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
							:kst_tab_wm_pklist.idpkl,   
							:kst_tab_wm_pklist_righe.areamag,   
							:kst_tab_wm_pklist_righe.stato,   
							:kst_tab_wm_pklist_righe.colli,   
							:kst_tab_wm_pklist_righe.idart_clie,   
							:kst_tab_wm_pklist_righe.idlotto_clie,   
							:kst_tab_wm_pklist_righe.id_armo,   
							:kst_tab_wm_pklist_righe.id_meca,   
							:kst_tab_wm_pklist_righe.gruppo,   
							:kst_tab_gru.des
							,:kst_tab_meca.num_int	    
							,:kst_tab_meca.data_int	    
						  ;
		
		
				loop
				close kc_treeview;
				
//--- Aggiorna il primo item in lista quello di default del 'ritorno'
				kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				if k_handle_item_padre > 0 then
//--- prendo il item padre per settare il ritorno di default
					k_handle_item = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
					if k_handle_item <= 0 then
						k_handle_item = 1
					end if
				else
					k_handle_item = 1
				end if
				kst_treeview_data.handle_padre = k_handle_item_padre
				kst_treeview_data.handle = k_handle_item
				kst_treeview_data.oggetto_listview = k_tipo_oggetto
				kst_treeview_data.oggetto = ""
				klvi_listviewitem.label = ".."
				klvi_listviewitem.data = kst_treeview_data
				klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
				kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
				
			end if				
		end if
	end if
 
//		 
//	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kuf1_treeview.kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kuf1_treeview.kilv_lv1.extendedselect = true 
//			
//	end if


 
return k_return

 
 
 


end function

public function st_esito set_stato_importato (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Cambia lo STATO a IMPORTATO delle righe della Packing List 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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
	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then

		kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist_righe
				set stato = :kki_STATO_importato
					,x_datins = :kst_tab_wm_pklist_righe.x_datins
					,x_utente = :kst_tab_wm_pklist_righe.x_utente
				WHERE id_wm_pklist_riga = :kst_tab_wm_pklist_righe.id_wm_pklist_riga
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Importato' della Riga di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist_riga, "####0") + " " &
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
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function st_esito set_dati_lotto (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Aggiorna i dati provenienti dal LOTTO di Magazzino  
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga e id_meca, id_armoi,  
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
	kst_esito.SQLErrText = "Modifica dati Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then

		kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist_righe
				set id_meca = :kst_tab_wm_pklist_righe.id_meca
					, id_armo = :kst_tab_wm_pklist_righe.id_armo
					, gruppo = :kst_tab_wm_pklist_righe.gruppo
					,x_datins = :kst_tab_wm_pklist_righe.x_datins
					,x_utente = :kst_tab_wm_pklist_righe.x_utente
				WHERE id_wm_pklist_riga = :kst_tab_wm_pklist_righe.id_wm_pklist_riga
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica 'dati Lotto' della Riga di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist_riga, "####0") + " " &
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
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
end if


return kst_esito

end function

public function boolean tb_add (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Aggiorna (carica/modifica) Riga Packing List  se ID_WM_PKLIST_RIGA=0 fa INSERT altrimenti UPDATE
//=== 
//=== Input: st_tab_wm_pklist_righe
//=== Ritorna:       TRUE=agg. eseguito, FALSE=nessun aggiornamento 
//=== se ERRORE Lancia EXCEPTION
//=== 
//====================================================================
//
int k_resp
boolean k_return=false
string k_ope
st_esito kst_esito
st_open_w kst_open_w
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe_righe
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then
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
	
	if_isnull(kst_tab_wm_pklist_righe)
	kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then
		k_ope = "AGGIORNAMENTO" 
		u_set_col_len_max(k_ope, kst_tab_wm_pklist_righe)
		
		UPDATE wm_pklist_righe  
		  SET id_wm_pklist = :kst_tab_wm_pklist_righe.id_wm_pklist,   
				stato = :kst_tab_wm_pklist_righe.stato,   
				idart_clie = :kst_tab_wm_pklist_righe.idart_clie,   
				idlotto_clie = :kst_tab_wm_pklist_righe.idlotto_clie,   
				qtapezzi_pallet = :kst_tab_wm_pklist_righe.qtapezzi_pallet,   
				idpezzo_clie = :kst_tab_wm_pklist_righe.idpezzo_clie,   
				wm_barcode = :kst_tab_wm_pklist_righe.wm_barcode,   
				barcode = :kst_tab_wm_pklist_righe.barcode,   
				areamag = :kst_tab_wm_pklist_righe.areamag,   
				id_armo = :kst_tab_wm_pklist_righe.id_armo,   
				id_meca = :kst_tab_wm_pklist_righe.id_meca,   
				gruppo = :kst_tab_wm_pklist_righe.gruppo,   
				colli = :kst_tab_wm_pklist_righe.colli,   
				eliminato = :kst_tab_wm_pklist_righe.eliminato,   
				x_datins_elim = :kst_tab_wm_pklist_righe.x_datins_elim,   
				x_utente_elim = :kst_tab_wm_pklist_righe.x_utente_elim,   
				x_datins = :kst_tab_wm_pklist_righe.x_datins,   
				x_utente = :kst_tab_wm_pklist_righe.x_utente  
			WHERE wm_pklist_righe.id_wm_pklist_riga = :kst_tab_wm_pklist_righe.id_wm_pklist_riga   
				using kguo_sqlca_db_magazzino;

		
	else
		k_ope = "INSERIMENTO" 
		u_set_col_len_max(k_ope, kst_tab_wm_pklist_righe)

		//id_wm_pklist_riga,   
		INSERT INTO wm_pklist_righe  
					( 
					  id_wm_pklist,   
					  stato,   
					  idart_clie,   
					  idlotto_clie,   
					  qtapezzi_pallet,   
					  idpezzo_clie,   
					  wm_barcode,   
					  barcode,   
					  areamag,   
					  id_armo,   
					  id_meca,   
					  gruppo,   
					  colli,   
					  eliminato,   
					  x_datins,   
					  x_utente )  
		  VALUES ( 
					  :kst_tab_wm_pklist_righe.id_wm_pklist,   
					  :kst_tab_wm_pklist_righe.stato,   
					  :kst_tab_wm_pklist_righe.idart_clie,   
					  :kst_tab_wm_pklist_righe.idlotto_clie,   
					  :kst_tab_wm_pklist_righe.qtapezzi_pallet,   
					  :kst_tab_wm_pklist_righe.idpezzo_clie,   
					  :kst_tab_wm_pklist_righe.wm_barcode,   
					  :kst_tab_wm_pklist_righe.barcode,   
					  :kst_tab_wm_pklist_righe.areamag,   
					  :kst_tab_wm_pklist_righe.id_armo,   
					  :kst_tab_wm_pklist_righe.id_meca,   
					  :kst_tab_wm_pklist_righe.gruppo,   
					  :kst_tab_wm_pklist_righe.colli,   
					  :kst_tab_wm_pklist_righe.eliminato,   
					  :kst_tab_wm_pklist_righe.x_datins,   
					  :kst_tab_wm_pklist_righe.x_utente )  
				using kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
			kst_tab_wm_pklist_righe.id_wm_pklist_riga = get_id_wm_pklist_riga_max()
			//kst_tab_wm_pklist_righe.id_wm_pklist_riga = long(kguo_sqlca_db_magazzino.SQLReturnData)
		
		end if
	
	end if
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
"Errore in " + k_ope + " dettaglio riga Packing-List cliente~n~r" &
				+ " id Packing: " + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0") + " -  id riga: " &
				+ string(kst_tab_wm_pklist_righe.id_wm_pklist_riga) &	
				+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
	
		if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
	else
	//---- COMMIT....	
		if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
			k_return=true
		end if
		
	end if
		
end if


return k_return


end function

public function st_esito get_id_wm_pklist_da_id_meca (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Rstituisce ID_WM_PKLIST da ID_MECA 
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



	select max(id_wm_pklist)
		into :kst_tab_wm_pklist_righe.id_wm_pklist
		from wm_pklist_righe 
		where id_meca = :kst_tab_wm_pklist_righe.id_meca
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Id Packing List dalla tab. righe (wm_pklist_righe):" + "~n~Id Lotto cercato= " + string(kst_tab_wm_pklist_righe.id_meca) &
										+ "~n~r" +trim(sqlca.SQLErrText)
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

	if isnull(kst_tab_wm_pklist_righe.id_wm_pklist) then kst_tab_wm_pklist_righe.id_wm_pklist = 0

return kst_esito

end function

public function integer get_nr_pallet (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Torna il nr pallet del Packing List  
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist 
//=== Ritorna:  integer con il NR dei PALLET
//=== Lancia UO_EXCEPTION
//====================================================================
//
integer k_return=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_righe.id_wm_pklist > 0 then

	SELECT count(*)
		into :k_return
			 FROM wm_pklist_righe  
			WHERE id_wm_pklist = :kst_tab_wm_pklist_righe.id_wm_pklist   
				         and eliminato <> :kki_ELIMINATO_SI
				using sqlca;
		
			
	if sqlca.sqlcode <> 0 then
		
		k_return = 0
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
		"Errore durante Lettura Righe Packing-List Mandante (nr-pallet) ~n~r" &
				+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0")  &
				+ " ~n~rErrore-tab.'wm_pklist_righe':"	+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception 
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
				
			end if
		end if
			
	end if
		
end if

if isnull(k_return) then k_return = 0


return k_return

end function

public function long tb_select_x_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe[]) throws uo_exception;//
//====================================================================
//=== Select di tutte le righe di un determinato Packing List  
//=== 
//=== Input: st_tab_wm_pklist_righe[1].id_wm_pklist torna st_tab_wm_pklist_righe[*]
//=== Ritorna:  Nr di righe trovate
//=== Lanca UO_EXCEPTION
//====================================================================
//
long k_return=0
long k_ctr=0
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

if upperbound(kst_tab_wm_pklist_righe) > 0 then
	if kst_tab_wm_pklist_righe[1].id_wm_pklist > 0 then

		declare  c_tb_select_x_id_wm_pklist	cursor for 	
		  SELECT wm_pklist_righe.id_wm_pklist_riga,   
					wm_pklist_righe.stato,   
					wm_pklist_righe.idart_clie,   
					wm_pklist_righe.idlotto_clie,   
					wm_pklist_righe.qtapezzi_pallet,   
					wm_pklist_righe.idpezzo_clie,   
					wm_pklist_righe.wm_barcode,   
					wm_pklist_righe.barcode,   
					wm_pklist_righe.areamag,   
					wm_pklist_righe.id_armo,   
					wm_pklist_righe.id_meca,   
					wm_pklist_righe.gruppo,   
					wm_pklist_righe.colli,   
					wm_pklist_righe.eliminato,   
					wm_pklist_righe.x_datins_elim,   
					wm_pklist_righe.x_utente_elim,   
					wm_pklist_righe.x_datins,   
					wm_pklist_righe.x_utente  
			 FROM wm_pklist_righe  
			WHERE id_wm_pklist = :kst_tab_wm_pklist_righe[1].id_wm_pklist   
				         and eliminato <> :kki_ELIMINATO_SI
			order by 
					wm_pklist_righe.gruppo,  
					wm_pklist_righe.id_wm_pklist_riga
				using sqlca;
		
		open c_tb_select_x_id_wm_pklist;
		if sqlca.sqlcode = 0 then
			
			k_ctr=1
			
			fetch c_tb_select_x_id_wm_pklist into
					:kst_tab_wm_pklist_righe[k_ctr].id_wm_pklist_riga,   
					:kst_tab_wm_pklist_righe[k_ctr].stato,   
					:kst_tab_wm_pklist_righe[k_ctr].idart_clie,   
					:kst_tab_wm_pklist_righe[k_ctr].idlotto_clie,   
					:kst_tab_wm_pklist_righe[k_ctr].qtapezzi_pallet,   
					:kst_tab_wm_pklist_righe[k_ctr].idpezzo_clie,   
					:kst_tab_wm_pklist_righe[k_ctr].wm_barcode,   
					:kst_tab_wm_pklist_righe[k_ctr].barcode,   
					:kst_tab_wm_pklist_righe[k_ctr].areamag,   
					:kst_tab_wm_pklist_righe[k_ctr].id_armo,   
					:kst_tab_wm_pklist_righe[k_ctr].id_meca,   
					:kst_tab_wm_pklist_righe[k_ctr].gruppo,   
					:kst_tab_wm_pklist_righe[k_ctr].colli,   
					:kst_tab_wm_pklist_righe[k_ctr].eliminato,   
					:kst_tab_wm_pklist_righe[k_ctr].x_datins_elim,   
					:kst_tab_wm_pklist_righe[k_ctr].x_utente_elim,   
					:kst_tab_wm_pklist_righe[k_ctr].x_datins,   
					:kst_tab_wm_pklist_righe[k_ctr].x_utente  			
					;
					
			if sqlca.sqlcode = 0 then
			
				do while sqlca.sqlcode = 0 
				
					k_ctr ++
					
					fetch c_tb_select_x_id_wm_pklist into
							 :kst_tab_wm_pklist_righe[k_ctr].id_wm_pklist_riga,   
							:kst_tab_wm_pklist_righe[k_ctr].stato,   
							:kst_tab_wm_pklist_righe[k_ctr].idart_clie,   
							:kst_tab_wm_pklist_righe[k_ctr].idlotto_clie,   
							:kst_tab_wm_pklist_righe[k_ctr].qtapezzi_pallet,   
							:kst_tab_wm_pklist_righe[k_ctr].idpezzo_clie,   
							:kst_tab_wm_pklist_righe[k_ctr].wm_barcode,   
							:kst_tab_wm_pklist_righe[k_ctr].barcode,   
							:kst_tab_wm_pklist_righe[k_ctr].areamag,   
							:kst_tab_wm_pklist_righe[k_ctr].id_armo,   
							:kst_tab_wm_pklist_righe[k_ctr].id_meca,   
							:kst_tab_wm_pklist_righe[k_ctr].gruppo,   
							:kst_tab_wm_pklist_righe[k_ctr].colli,   
							:kst_tab_wm_pklist_righe[k_ctr].eliminato,   
							:kst_tab_wm_pklist_righe[k_ctr].x_datins_elim,   
							:kst_tab_wm_pklist_righe[k_ctr].x_utente_elim,   
							:kst_tab_wm_pklist_righe[k_ctr].x_datins,   
							:kst_tab_wm_pklist_righe[k_ctr].x_utente  			
							;
						
				loop
				
				if sqlca.sqlcode = 100 then sqlca.sqlcode = 0  // x evitare che lanci la exception
			
			end if

			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
				"Errore durante Lettura Righe Packing-List Mandante (1) ~n~r" &
						+ " id=" + string(kst_tab_wm_pklist_righe[1].id_wm_pklist, "####0")  &
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
					
				close c_tb_select_x_id_wm_pklist;
				
				kuo_exception = create uo_exception 
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
				
			end if
		
			close c_tb_select_x_id_wm_pklist;

//--- torna il nr di righe!!!
			k_return = k_ctr

		end if

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante Lettura Righe Packing-List Mandante (2) ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe[1].id_wm_pklist, "####0")  &
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
		
end if


return k_return

end function

public function st_esito set_sped_si (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Cambia il flag di Spedito delle righe della Packing List 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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
//	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then

		kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist_righe
				set sped = :kki_SPED_si
					,x_datins = :kst_tab_wm_pklist_righe.x_datins
					,x_utente = :kst_tab_wm_pklist_righe.x_utente
				WHERE id_wm_pklist_riga = :kst_tab_wm_pklist_righe.id_wm_pklist_riga
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Spedito' della Riga di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist_riga, "####0") + " " &
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
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
//end if


return kst_esito

end function

public function boolean get_insped (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Controlla campo INSPED x barcode entrato con PackingList
//=== 
//=== Input: st_tab_wm_pklist_righe.barcode 
//=== Ritorna:  TRUE=da WM spedibile oppure barcode non in pk (not found);
//===               FALSE=non ancora messo sul camion (o meglio WM non lo ha comunicato)
//=== Lanca UO_EXCEPTION
//====================================================================
//
boolean k_return=false
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_righe.id_wm_pklist > 0 then

	SELECT insped
		into :kst_tab_wm_pklist_righe.insped
			 FROM wm_pklist_righe  
			WHERE barcode = :kst_tab_wm_pklist_righe.barcode
				         and eliminato <> :kki_ELIMINATO_SI
				using sqlca;
		
			
	if sqlca.sqlcode = 0 then
		
		if kst_tab_wm_pklist_righe.insped = "S" then  //il WM setta 'S' quando carica sul camion
			k_return = true
		end if
		
	else
		if sqlca.sqlcode = 100 then
			
			k_return = true

		else
			k_return = false
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
			"Errore durante Lettura Righe Packing-List Mandante (1) ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0")  &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
					kuo_exception = create uo_exception 
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
					
				end if
			end if
		end if
			
	end if
		
end if


return k_return

end function

public function integer get_da_spedire_x_id_armo (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Controlla se Entrata (ARMO) è spedibile: è sufficiente che il nr colli dell'articolo siano caricati sul camion 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_armo + 
//=== integer:  > 0 numero colli=da WM spedibili;
//===                -1=colli non in pk (not found)
//===                 0=non ancora messi tutti i colli sul camion (o meglio WM non lo ha comunicato)
//=== Lanca UO_EXCEPTION
//====================================================================
//
integer k_return=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_righe.id_armo > 0 then

//--- Esiste la riga?
	SELECT 0
		into :k_return
			 FROM wm_pklist_righe  
			WHERE id_armo = :kst_tab_wm_pklist_righe.id_armo
				         and eliminato <> :kki_ELIMINATO_SI
				using sqlca;

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode = 100 then
			k_return = -1
		end if			
	else
		
//--- è stata caricata sul camion?

		SELECT count(*)
			into :k_return
				 FROM wm_pklist_righe  
				WHERE id_armo = :kst_tab_wm_pklist_righe.id_armo
							and insped = :kki_INSPED  
							and eliminato <> :kki_ELIMINATO_SI
					using sqlca;

	end if		
	
	if sqlca.sqlcode < 0 then
			
		k_return = 0
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
		"Errore durante Lettura Righe Packing-List Mandante (1) ~n~r" &
				+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0")  &
				+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception 
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
				
			end if
		end if
			
	end if
		
end if


return k_return

end function

public function st_esito set_sped_no (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Cambia il flag di Spedito delle righe della Packing List 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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
//	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then

		kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist_righe
				set sped = :kki_SPED_no
					,x_datins = :kst_tab_wm_pklist_righe.x_datins
					,x_utente = :kst_tab_wm_pklist_righe.x_utente
				WHERE id_wm_pklist_riga = :kst_tab_wm_pklist_righe.id_wm_pklist_riga
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Non Spedito' della Riga di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist_riga, "####0") + " " &
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
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
		
//end if


return kst_esito

end function

public function st_esito set_sped_no_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Cambia il flag in Spedito SI x tutte le righe del Lotto Entrata che sono state Caricate 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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
//	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist_righe.id_armo > 0 then

         kst_tab_wm_pklist_righe.insped = this.kki_insped
         kst_tab_wm_pklist_righe.sped = this.kki_SPED_si
		 kst_tab_wm_pklist_righe.eliminato =  this.kki_ELIMINATO_SI
		
		declare c_set_sped_no_x_id_armo cursor for  
			select  id_wm_pklist_riga 
				from wm_pklist_righe
					WHERE id_armo = :kst_tab_wm_pklist_righe.id_armo
                              and insped = :kst_tab_wm_pklist_righe.insped
                              and sped = :kst_tab_wm_pklist_righe.sped
                              and ELIMINATO <> :kst_tab_wm_pklist_righe.eliminato
					for update
					using sqlca;

		open c_set_sped_no_x_id_armo ;
		if sqlca.sqlcode = 0 then
			fetch c_set_sped_no_x_id_armo into :kst_tab_wm_pklist_righe.id_wm_pklist_riga;
			
			do while sqlca.sqlcode = 0 and (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn)
			
				kst_esito = set_sped_si(kst_tab_wm_pklist_righe) //Aggiorna righe del PK con SPEDITO!
			
				fetch c_set_sped_no_x_id_armo into :kst_tab_wm_pklist_righe.id_wm_pklist_riga;
				
			loop
				
			if sqlca.sqlcode < 0 then	
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Non Spedito' delle Righe di Packing-List Mandante ~n~r" &
					+ " id riga lotto=" + string(kst_tab_wm_pklist_righe.id_armo, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		
			close c_set_sped_no_x_id_armo;
		
	//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
			
		else
			if sqlca.sqlcode < 0 then	
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante inizio procedura x mettere a 'Non Spedito' le Righe di Packing-List Mandante ~n~r" &
					+ " id riga lotto=" + string(kst_tab_wm_pklist_righe.id_armo, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
		
//end if


return kst_esito

end function

public function st_esito set_sped_si_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Cambia il flag in Spedito SI x tutte le righe del Lotto Entrata che sono state Caricate 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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
//	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_wm_pklist_righe.id_armo > 0 then
		
		declare c_set_sped_si_x_id_armo cursor for  
			select  id_wm_pklist_riga 
				from wm_pklist_righe
					WHERE id_armo = :kst_tab_wm_pklist_righe.id_armo
					        and insped = :kki_insped
							and ELIMINATO <> :kki_ELIMINATO_SI
					using sqlca;

		open 	c_set_sped_si_x_id_armo;
		if sqlca.sqlcode = 0 then
			fetch c_set_sped_si_x_id_armo into :kst_tab_wm_pklist_righe.id_wm_pklist_riga;
			
			do while sqlca.sqlcode = 0 and (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn)
			
				kst_esito = set_sped_si(kst_tab_wm_pklist_righe) //Aggiorna righe del PK con SPEDITO!
			
				fetch c_set_sped_si_x_id_armo into :kst_tab_wm_pklist_righe.id_wm_pklist_riga;
				
			loop
				
			if sqlca.sqlcode < 0 then	
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Spedito' delle Righe di Packing-List Mandante ~n~r" &
					+ " id riga lotto=" + string(kst_tab_wm_pklist_righe.id_armo, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		
			close c_set_sped_si_x_id_armo;
		
	//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
			
		else
			if sqlca.sqlcode < 0 then	
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante inizio procedura x mettere a 'Spedito' le Righe di Packing-List Mandante ~n~r" &
					+ " id riga lotto=" + string(kst_tab_wm_pklist_righe.id_armo, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
		
//end if


return kst_esito

end function

public function st_esito if_esiste_in_sped_x_id_armo (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Controlla esistenza di righe x ID_ARMO
//=== 
//=== Input: st_tab_wm_pklist_righe.id_armo
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
int k_ind=0
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_righe.id_armo > 0 then
		
	select distinct 1
		into :k_ind
		from wm_pklist_righe
			WHERE id_armo = :kst_tab_wm_pklist_righe.id_armo
					  and insped = :kki_insped
					and ELIMINATO <> :kki_ELIMINATO_SI
			using sqlca;


	if sqlca.sqlcode = 0 then
		if k_ind <= 0 or isnull(k_ind) then
			
			sqlca.sqlcode = 100
			
		end if
	end if
				
	if sqlca.sqlcode < 0 then	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante la Verifica Esistenza Righe di Packing-List Mandante da Spedire ~n~r" &
			+ "Id riga lotto=" + string(kst_tab_wm_pklist_righe.id_armo, "####0") + " " &
			+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
	else
		
		if sqlca.sqlcode = 100 then	
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Nessuna Riga di Packing-List Mandante da Spedire Trovata. ~n~r" &
				+ "Id riga lotto = " + string(kst_tab_wm_pklist_righe.id_armo, "####0") 
			kst_esito.esito = kkg_esito.not_fnd
		end if
		
	end if
end if
		


return kst_esito

end function

public function boolean set_stato_importato_x_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Cambia lo STATO a IMPORTATO di tutte le righe della Packing List 
//=== 
//=== Input: st_tab_wm_pklist_righe.id_wm_pklist_riga 
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

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_pklist_righe.id_wm_pklist > 0 then

		kst_tab_wm_pklist_righe.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_wm_pklist_righe.x_utente = kGuf_data_base.prendi_x_utente()
		
		update wm_pklist_righe
				set stato = :kki_STATO_importato
					,x_datins = :kst_tab_wm_pklist_righe.x_datins
					,x_utente = :kst_tab_wm_pklist_righe.x_utente
				WHERE id_wm_pklist = :kst_tab_wm_pklist_righe.id_wm_pklist
				using sqlca;
			
		if sqlca.sqlcode <> 0 then
				
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la Modifica Stato  a 'Importato' di tutte le Riga di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			
		end if
		
	//---- COMMIT....	
		if sqlca.sqlcode = 0 then
			if kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito(kst_esito)
				end if
			end if
		end if
	
		 k_return=true
	
	end if
		
end if


return k_return

end function

public function boolean set_dati_lotto_x_id_wm_pklist (long a_nr_righe, ref st_tab_wm_pklist_righe ast_tab_wm_pklist_righe[]) throws uo_exception;//
//====================================================================
//=== Aggiorna i dati provenienti dal LOTTO di Magazzino  
//=== 
//=== Input: numero_righe_da_aggiornare; st_tab_wm_pklist_righe.id_wm_pklist_riga e id_meca, id_armoi,  
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return=false
long k_ctr, k_nr_righe
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe[]


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
	kst_esito.SQLErrText = "Modifica dati Righe Packing List Mandante non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if ast_tab_wm_pklist_righe[1].id_wm_pklist > 0 then

		kst_tab_wm_pklist_righe[1].id_wm_pklist =  ast_tab_wm_pklist_righe[1].id_wm_pklist
		k_nr_righe = tb_select_x_id_wm_pklist(kst_tab_wm_pklist_righe[]) 
		if k_nr_righe > 0 then
			
			if a_nr_righe < k_nr_righe then k_nr_righe = a_nr_righe  // x non sfondare la array 
			
//--- aggiorna tutte le righe indicate tra gli argomenti 			
			for k_ctr = 1 to k_nr_righe 

				kst_tab_wm_pklist_righe[k_ctr].x_datins = kGuf_data_base.prendi_x_datins()
				kst_tab_wm_pklist_righe[k_ctr].x_utente = kGuf_data_base.prendi_x_utente()
				
				
				update wm_pklist_righe
						set id_meca = :ast_tab_wm_pklist_righe[k_ctr].id_meca
							, id_armo = :ast_tab_wm_pklist_righe[k_ctr].id_armo
							, gruppo = :ast_tab_wm_pklist_righe[k_ctr].gruppo
							, barcode = :ast_tab_wm_pklist_righe[k_ctr].barcode
							, x_datins = :kst_tab_wm_pklist_righe[k_ctr].x_datins
							, x_utente = :kst_tab_wm_pklist_righe[k_ctr].x_utente
						WHERE id_wm_pklist_riga = :kst_tab_wm_pklist_righe[k_ctr].id_wm_pklist_riga
						using sqlca;
						
				if sqlca.sqlcode < 0 then  k_ctr = a_nr_righe + 1 // se errore forza uscita ciclo
				
			end for
				
			if sqlca.sqlcode < 0 then
					
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
	"Errore durante la Modifica 'dati Lotto' di tutte le Righe di Packing-List Mandante ~n~r" &
					+ " id=" + string(kst_tab_wm_pklist_righe[k_ctr].id_wm_pklist, "####0") + " " &
					+ " ~n~rErrore-tab.'wm_pklist':"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
	
				if kst_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
				
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
	
			end if
			
		end if
		
	//---- COMMIT....	
		if sqlca.sqlcode = 0 then
			if kst_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito(kst_esito)
				end if
			end if
		end if
	
		 k_return=true
	
	end if
		
end if


return k_return

end function

public function integer get_nr_pallet_wm_associati (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//====================================================================
//=== Torna il nr pallet Associati in WM x Lotto
//=== 
//=== Input: st_tab_wm_pklist_righe.id_meca 
//=== Ritorna:  integer con il NR dei PALLET
//=== Lancia UO_EXCEPTION
//====================================================================
//
integer k_return=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_wm_pklist_righe.id_meca > 0 then

	SELECT count(*)
		into :k_return
			 FROM wm_pklist_righe  
			WHERE id_meca = :kst_tab_wm_pklist_righe.id_meca   
				         and barcode > ' '
				using sqlca;
		
			
	if sqlca.sqlcode = 0 then
		
		if isnull(k_return) then k_return = 1  // se non trovo il Lotto nel PKL forza a 1..... sarà giusto???

	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
		"Errore durante Lettura Righe Packing-List Mandante (Associati-WM) ~n~r" &
				+ " id Lotto=" + string(kst_tab_wm_pklist_righe.id_meca, "####0")  &
				+ " ~n~rErrore-tab.'wm_pklist_righe':"	+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception 
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
				
			end if
		end if
			
	end if
		
end if

if isnull(k_return) then k_return = 0

return k_return

end function

public function st_esito get_id_meca_da_id_wm_pklist (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//====================================================================
//=== Rstituisce ID_WM_PKLIST da ID_MECA 
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



	select max(id_meca)
		into :kst_tab_wm_pklist_righe.id_meca
		from wm_pklist_righe 
		where id_wm_pklist = :kst_tab_wm_pklist_righe.id_wm_pklist
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Id Lotto (Riferimento) da righe di 'Packing List' (wm_pklist_righe):" + "~n~Id packing-list cercato= " + string(kst_tab_wm_pklist_righe.id_wm_pklist) &
										+ "~n~r" +trim(sqlca.SQLErrText)
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

	if isnull(kst_tab_wm_pklist_righe.id_meca) then kst_tab_wm_pklist_righe.id_meca = 0

return kst_esito

end function

public function long get_id_armo_da_wm_barcode (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe) throws uo_exception;//
//------------------------------------------------------------------
//--- Rstituisce ID_ARMO da ID_MECA + WM_BARCODE
//--- 
//--- Ritorna ID_ARMO
//--- lancia EXCEPTION per errore grave (st_esito settata)          	
//------------------------------------------------------------------
//
long k_return = 0
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select max(id_armo)
		into :kst_tab_wm_pklist_righe.id_armo
		from wm_pklist_righe 
		where id_meca = :kst_tab_wm_pklist_righe.id_meca
		    and wm_barcode = :kst_tab_wm_pklist_righe.wm_barcode
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura id riga lotto dalle righe di 'Packing List' (wm_pklist_righe):" + "~n~Id lotto: " + string(kst_tab_wm_pklist_righe.id_meca) + " barcode cliente: "  + trim(kst_tab_wm_pklist_righe.wm_barcode) &
										+ "~n~r" +trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception	
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_wm_pklist_righe.id_armo > 0 then
			k_return = kst_tab_wm_pklist_righe.id_armo
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function long get_id_wm_pklist_riga_max () throws uo_exception;//
//====================================================================
//=== Rstituisce l'ultimo id caricato 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
long k_return
st_esito kst_esito
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe

//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
//boolean k_autorizza


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

	kst_tab_wm_pklist_righe.id_wm_pklist_riga = 0

	select max(id_wm_pklist_riga)
		into :kst_tab_wm_pklist_righe.id_wm_pklist_riga
		from wm_pklist_righe 
		using sqlca;

		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ultima riga di 'Packing List' (wm_pklist_righe):" + trim(sqlca.SQLErrText)
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

	if kst_tab_wm_pklist_righe.id_wm_pklist_riga > 0 then
		k_return = kst_tab_wm_pklist_righe.id_wm_pklist_riga
	end if

return k_return

end function

private subroutine u_set_col_len_max (string k_ope, ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);int k_lencolmax


	kguo_exception.kist_esito.esito = kkg_esito.ok
	kguo_exception.kist_esito.sqlcode = 0
	kguo_exception.kist_esito.SQLErrText = ""
	kguo_exception.kist_esito.nome_oggetto = this.classname()

	//22062018 tronca kst_tab_wm_pklist_righe.idlotto_clie a 80 char
	kst_tab_wm_pklist_righe.idlotto_clie = left(kst_tab_wm_pklist_righe.idlotto_clie,80)
	k_lencolmax = kguo_sqlca_db_magazzino.u_get_col_len( "wm_pklist_righe", "idlotto_clie") //get max size colonna su db
	if k_lencolmax > 0 and len(trim(kst_tab_wm_pklist_righe.idlotto_clie)) > k_lencolmax then

		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.SQLErrText = &
"Anomalia in " + k_ope + " Riga Packing-List cliente~n~r" &
				+ " ~n~rCodice Lotto Cliente TROPPO LUNGO (è stato troncato): "	+ trim(kst_tab_wm_pklist_righe.idlotto_clie ) &	 
				+ " ~n~rid=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0")  &
				+ " barcode: " + string(kst_tab_wm_pklist_righe.wm_barcode) + " rif. Art. cliente: " + trim(kst_tab_wm_pklist_righe.idart_clie) 
		kguo_exception.kist_esito.esito = kkg_esito.db_wrn
		kguo_exception.scrivi_log( )

		kst_tab_wm_pklist_righe.idlotto_clie = left(trim(kst_tab_wm_pklist_righe.idlotto_clie), k_lencolmax)

	end if
	
	k_lencolmax = kguo_sqlca_db_magazzino.u_get_col_len( "wm_pklist_righe", "idart_clie") //get max size colonna su db
	if k_lencolmax > 0 and len(trim(kst_tab_wm_pklist_righe.idart_clie)) > k_lencolmax then

		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.SQLErrText = &
"Anomalia in " + k_ope + " Riga Packing-List cliente~n~r" &
				+ " ~n~rArticolo Cliente TROPPO LUNGO (è stato troncato): "	+ trim(kst_tab_wm_pklist_righe.idart_clie ) &	 
				+ " ~n~rid=" + string(kst_tab_wm_pklist_righe.id_wm_pklist, "####0")  &
				+ " barcode: " + string(kst_tab_wm_pklist_righe.wm_barcode) + " Codice Lotto cliente: " + trim(kst_tab_wm_pklist_righe.idlotto_clie) 
		kguo_exception.kist_esito.esito = kkg_esito.db_wrn
		kguo_exception.scrivi_log( )

		kst_tab_wm_pklist_righe.idart_clie = left(trim(kst_tab_wm_pklist_righe.idart_clie), k_lencolmax)

	end if
	

end subroutine

public function string get_idlotto_clie (st_tab_wm_pklist_righe ast_tab_wm_pklist_righe) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------
//--- Rstituisce codice Barcode Lotto caricato dal cliente in packing list (idlotto_clie)
//--- inp: st_tab_wm_pklist_righe.id_wm_pklist_riga
//--- rit: idlotto_clie (string)
//--- uo_exception: ST_ESITO
//---           	
//----------------------------------------------------------------------------------------------------------------------
//
string k_return = ""
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select idlotto_clie
		into :ast_tab_wm_pklist_righe.idlotto_clie
		from wm_pklist_righe 
		where id_wm_pklist_riga = :ast_tab_wm_pklist_righe.id_wm_pklist_riga
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Codice Lotto caricato in Packling List dal cliente, nel barcode id: " + string(ast_tab_wm_pklist_righe.id_wm_pklist_riga) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(ast_tab_wm_pklist_righe.idlotto_clie) > " " then
		k_return = trim(ast_tab_wm_pklist_righe.idlotto_clie)
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try

return k_return

end function

on kuf_wm_pklist_righe.create
call super::create
end on

on kuf_wm_pklist_righe.destroy
call super::destroy
end on

