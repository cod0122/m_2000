$PBExportHeader$kuf_pl_barcode_tree.sru
forward
global type kuf_pl_barcode_tree from nonvisualobject
end type
end forward

global type kuf_pl_barcode_tree from nonvisualobject
end type
global kuf_pl_barcode_tree kuf_pl_barcode_tree

type variables
//--- 
//--- flag meca.causale
//---

////--- flag campo Stato della Dosimetrica
//public constant string ki_err_lav_ok_da_conv = " "
//public constant string ki_err_lav_ok_conv_ko_da_aut = "K"
//public constant string ki_err_lav_ok_conv_da_aut = "A"
//public constant string ki_err_lav_ok_conv_aut_ok = "2"
//public constant string ki_err_lav_ok_conv_ko_bloc = "B"
//public constant string ki_err_lav_ok_conv_ko_sbloc = "1"
//
////--- flag campo Stato della Lavorazione
//public constant string ki_err_lav_fin_da_lav = " "
//public constant string ki_err_lav_fin_ko = "1"
//public constant string ki_err_lav_fin_ok = " "
//
////--- flag campo Stato del Carico 
//public constant int ki_meca_stato_ok = 0
//public constant int ki_meca_stato_blk = 1
//public constant int ki_meca_stato_sblk = 2

end variables

forward prototypes
public subroutine meca_if_isnull (st_tab_meca kst_tab_meca)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_gener (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
end prototypes

public subroutine meca_if_isnull (st_tab_meca kst_tab_meca);
end subroutine

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_anno, k_mese, k_pic_open, k_pic_close, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a 
date k_data_0 = date(0)
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst_tab_barcode
st_tab_sr_utenti kst_tab_sr_utenti
st_tab_treeview kst_tab_treeview
kuf_pl_barcode kuf1_pl_barcode

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- Ricavo il handle del Padre e il tipo Oggetto
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//--- ricavo ANNO e MESE con cui fare la where
		kst_treeview_data_any =	kst_treeview_data.struttura 
		kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode
		if kst_tab_pl_barcode.data > date(0) then
			k_anno = year(kst_tab_pl_barcode.data)
			k_mese = month(kst_tab_pl_barcode.data)
			k_data_da = date(k_anno, k_mese, 01)
			k_data_a = date(string(relativedate(k_data_da, 32), "yyyy/mm/") + "01")
		else
			k_anno = 0
			k_mese = 0
			k_data_da = date(0)
		end if
		
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_list
		end if
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		k_query_select = &
			"SELECT " &
         	+ "count (*), " &
			+ "barcode.pl_barcode, " &
			+ "pl_barcode.codice, " &
			+ "pl_barcode.data, " &
			+ "pl_barcode.stato, " &
			+ "pl_barcode.priorita, " &
			+ "pl_barcode.prima_del_barcode, " &
			+ "pl_barcode.note_1, " &
			+ "pl_barcode.note_2, " &
			+ "pl_barcode.data_sosp, " &
			+ "pl_barcode.data_chiuso, " &
			+ "pl_barcode.path_file_pilota, " &
			+ "sr_utenti.nome " &
	      + "FROM (pl_barcode LEFT OUTER JOIN barcode ON  " &
	      + "pl_barcode.codice = barcode.pl_barcode) " &
		 +  " left outer join sr_utenti on " &
           + " pl_barcode.upd_utente_chiuso = sr_utenti.id "
			

		k_query_where = " "
		if k_data_da > date(0) then
			k_query_where = &
					+ " where (pl_barcode.data >=  '"+ string(k_data_da) +"' and pl_barcode.data <  '"+ string(k_data_a) +"' ) and "
		end if
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_aperto_dett
				k_query_where = k_query_where &
				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.ki_stato_aperto) + "' " &
				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null) "
//					+ " (pl_barcode.data_chiuso <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_chiuso is null) " &

					
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_chiuso_dett
				k_query_where = k_query_where &
				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.ki_stato_chiuso) + "' " &
				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null) " &
//		      	+ " pl_barcode.data_chiuso > '" + string(KKG.DATA_ZERO) + "'  " &
//				   + " and (pl_barcode.upd_data_fpilota <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.upd_data_fpilota is null)  " 
					
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_gia_pilota_dett
				k_query_where = k_query_where &
				+ " pl_barcode.stato in ('" + trim(kuf1_pl_barcode.ki_stato_inviato) + "' " &
				+ ",  '" + trim(kuf1_pl_barcode.ki_stato_consegnato) + "') " &
				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null)  " 
//		         + " pl_barcode.upd_data_fpilota > '" + string(KKG.DATA_ZERO) + "'  "  &

			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_respinto_dett
				k_query_where = k_query_where &
				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.ki_stato_respinto) + "' " 
					
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_sospeso_dett
				k_query_where = k_query_where &
					+ "  pl_barcode.data_sosp > '" + string(KKG.DATA_ZERO) + "'  "
					
			case else
					k_query_where = " "
	
		end choose

		k_query_order = &
 			   " group by " &
				+ " barcode.pl_barcode, " &
				+ " pl_barcode.codice, " &
				+ " pl_barcode.data, " &
				+ " pl_barcode.stato, " &
				+ " pl_barcode.priorita, " &
				+ " pl_barcode.prima_del_barcode, " &
				+ " pl_barcode.note_1, " &
				+ " pl_barcode.note_2, " &
				+ " pl_barcode.data_sosp, " &
				+ " pl_barcode.data_chiuso, " &
				+ " pl_barcode.path_file_pilota, " &
				+ " sr_utenti.nome " &
				+ " order by " &
				+ " pl_barcode.data desc, pl_barcode.codice "

		 
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
			 

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_aperto_dett &
					,kuf1_treeview.kist_treeview_oggetto.pl_barcode_chiuso_dett &
			 		, kuf1_treeview.kist_treeview_oggetto.pl_barcode_gia_pilota_dett &
					,kuf1_treeview.kist_treeview_oggetto.pl_barcode_respinto_dett &
					,kuf1_treeview.kist_treeview_oggetto.pl_barcode_sospeso_dett
				open dynamic kc_treeview;
					
			case else
				open dynamic kc_treeview;
	
		end choose
		
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:kst_tab_barcode.pl_barcode
					 ,:kst_tab_pl_barcode.codice
					 ,:kst_tab_pl_barcode.data
					 ,:kst_tab_pl_barcode.stato
					 ,:kst_tab_pl_barcode.priorita
					 ,:kst_tab_pl_barcode.prima_del_barcode
					 ,:kst_tab_pl_barcode.note_1
					 ,:kst_tab_pl_barcode.note_2
					 ,:kst_tab_pl_barcode.data_sosp
					 ,:kst_tab_pl_barcode.data_chiuso
					 ,:kst_tab_pl_barcode.path_file_pilota
					 ,:kst_tab_sr_utenti.nome
					  ;

			if isnull(kst_tab_barcode.pl_barcode) then
				kst_treeview_data_any.contati = 0
			end if
			
			do while sqlca.sqlcode = 0
	
				if isnull(kst_tab_pl_barcode.codice) then
					kst_tab_pl_barcode.codice = 0
				end if
				if isnull(kst_tab_pl_barcode.data) then
					kst_treeview_data.label = " "
				else
					kst_treeview_data.label = string(kst_tab_pl_barcode.data, "dd.mm.yyyy") 
				end if
				kst_treeview_data.label += "  cod. " + string(kst_tab_pl_barcode.codice, "#####") 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
				
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = trim(string(kst_tab_pl_barcode.codice, "####0"))
			   if kst_treeview_data_any.contati = 0 then
				   kst_tab_treeview.descrizione = "Nessun Barcode inserito"
				else
				   if kst_treeview_data_any.contati = 1 then
				   	kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presente"
					else
					   kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presenti"
					end if
				end if
				
				if isnull(kst_tab_sr_utenti.nome) then
					kst_tab_sr_utenti.nome = " " 
				else
					kst_tab_sr_utenti.nome = "Chiuso da: " + trim(kst_tab_sr_utenti.nome) + ".    "
				end if
				if isnull(kst_tab_pl_barcode.note_1) then
					kst_tab_pl_barcode.note_1 = " " 
				else
					kst_tab_pl_barcode.note_1 = trim(kst_tab_pl_barcode.note_1) + "  "
				end if
				if isnull(kst_tab_pl_barcode.note_2) then
					kst_tab_pl_barcode.note_2 = " " 
				else
					kst_tab_pl_barcode.note_2 = trim(kst_tab_pl_barcode.note_2) + ". "
				end if
				if isnull(kst_tab_pl_barcode.path_file_pilota) then
					kst_tab_pl_barcode.path_file_pilota = " " 
				else
					kst_tab_pl_barcode.path_file_pilota = "File: " + trim(kst_tab_pl_barcode.path_file_pilota)
				end if
				
			   	kst_tab_treeview.descrizione_ulteriore = kst_tab_sr_utenti.nome + kst_tab_pl_barcode.note_1  &
				                                       	+ kst_tab_pl_barcode.note_2 &
													+ trim(kst_tab_pl_barcode.path_file_pilota) 

				if kst_tab_pl_barcode.data_sosp > date(0) then
					kst_tab_treeview.descrizione_tipo = "Sospeso, P.L. bloccato dall'operatore " 
				else
					choose case kst_tab_pl_barcode.stato
						case kuf1_pl_barcode.ki_stato_aperto
							kst_tab_treeview.descrizione_tipo = "Aperto  "
						case kuf1_pl_barcode.ki_stato_chiuso
							kst_tab_treeview.descrizione_tipo = "Chiuso  "
						case kuf1_pl_barcode.ki_stato_inviato
							kst_tab_treeview.descrizione_tipo = "Inviato  "
						case kuf1_pl_barcode.ki_stato_consegnato
							kst_tab_treeview.descrizione_tipo = "Consegnato  "
						case kuf1_pl_barcode.ki_stato_respinto
							kst_tab_treeview.descrizione_tipo = "Respinto  "
						case else
							kst_tab_treeview.descrizione_tipo = "?????  "
					end choose
					choose case kst_tab_pl_barcode.priorita
						case kuf1_pl_barcode.k_priorita_urgente
							kst_tab_treeview.descrizione_tipo += " URGENTE (prima del barcode:" &
										+ trim( kst_tab_pl_barcode.prima_del_barcode) + ") "
						case kuf1_pl_barcode.k_priorita_prima_del_barcode
							kst_tab_treeview.descrizione_tipo += " Prima del barcode:"&
										+ trim( kst_tab_pl_barcode.prima_del_barcode) + " "
						case kuf1_pl_barcode.k_priorita_alta
							kst_tab_treeview.descrizione_tipo += " priorita' Alta "
						case kuf1_pl_barcode.k_priorita_bassa
							kst_tab_treeview.descrizione_tipo += " priorita' Bassa "
					end choose
					
				end if
				
				kst_treeview_data.pic_list = k_pic_list
					
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
				kst_treeview_data_any.st_tab_sr_utenti = kst_tab_sr_utenti
				kst_treeview_data.struttura = kst_treeview_data_any

										  
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
					 ,:kst_tab_barcode.pl_barcode
					 ,:kst_tab_pl_barcode.codice
					 ,:kst_tab_pl_barcode.data
					 ,:kst_tab_pl_barcode.stato
					 ,:kst_tab_pl_barcode.priorita
					 ,:kst_tab_pl_barcode.prima_del_barcode
					 ,:kst_tab_pl_barcode.note_1
					 ,:kst_tab_pl_barcode.note_2
					 ,:kst_tab_pl_barcode.data_sosp
					 ,:kst_tab_pl_barcode.data_chiuso
					 ,:kst_tab_pl_barcode.path_file_pilota
					 ,:kst_tab_sr_utenti.nome
					  ;
	
			loop
			
			close kc_treeview;
		end if

	end if 
 
return k_return

end function

public function integer u_tree_riempi_treeview_gener (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_ctr_label_desc, k_pic_close, k_pic_open
string k_tipo_oggetto_padre
date k_save_data_int
string k_label_desc [10,3], k_anno_mese
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any




		 
//--- Ricavo il handle del Padre e il tipo Oggetto
//	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
		kst_treeview_data_any =	kst_treeview_data.struttura 
		kst_tab_treeview = kst_treeview_data_any.st_tab_treeview 
		k_anno_mese = kst_tab_treeview.id
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
		end if
//		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
//		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//		ktvi_treeviewitem.pictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_mese_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_mese_pic_open)


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		
	
		k_label_desc[1,1] = "In allestimento"
		k_label_desc[1,2] = "Piano di Lavoro in costruzione "
		k_label_desc[1,3] = kuf1_treeview.kist_treeview_oggetto.pl_barcode_aperto
		k_label_desc[2,1] = "Chiuso "
		k_label_desc[2,2] = "In attesa di trasferimento al Server Pilota "
		k_label_desc[2,3] = kuf1_treeview.kist_treeview_oggetto.pl_barcode_chiuso
		k_label_desc[3,1] = "Trasferito"
		k_label_desc[3,2] = "Generato il file del trattamento per il Server Pilota"
		k_label_desc[3,3] = kuf1_treeview.kist_treeview_oggetto.pl_barcode_gia_pilota
		k_label_desc[4,1] = "Sospesi"
		k_label_desc[4,2] = "Sospesi, non trasferibili al Server Pilota per il trattamento"
		k_label_desc[4,3] = kuf1_treeview.kist_treeview_oggetto.pl_barcode_sospeso
		k_label_desc[5,1] = "FINE"
		k_label_desc[5,2] = "EOF"
		k_label_desc[5,3] = " "
			
		k_ctr_label_desc=1
		
			do while k_label_desc[k_ctr_label_desc,1] <> "FINE"
	
				
				kst_treeview_data.label = k_label_desc[k_ctr_label_desc,1]
				kst_treeview_data.oggetto = k_label_desc[k_ctr_label_desc,3]
				kst_treeview_data.handle = k_handle_item_padre
				
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = k_anno_mese //--- contiene anno (4) e mese (2) del periodo da cercare
			   kst_tab_treeview.descrizione = k_label_desc[k_ctr_label_desc,2]
				kst_tab_treeview.descrizione_tipo = "Piani di Lavorazione" 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
	
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

				k_ctr_label_desc++
	
			loop
			

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_close, k_pic_open
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio, k_dataoggi_x
date k_save_data_int, k_data_anno_precedente
int k_mese, k_anno
string k_mese_desc [13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
kuf_base kuf1_base


declare kc_treeview cursor for
	SELECT 
         count (*), 
         month(pl_barcode.data) as mese,   
         year(pl_barcode.data) as anno   
     FROM pl_barcode
	  where pl_barcode.data > :k_data_anno_precedente
		 group by  month(pl_barcode.data), year(pl_barcode.data)
		 order by  3 desc, 2 desc;

//--- ricava la data da cui partire
	kuf1_base = create kuf_base
	k_dataoggi_x = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
	destroy kuf1_base
	if isdate(k_dataoggi_x) then
		k_data_anno_precedente = relativedate (date(k_dataoggi_x), -365)
	else
		k_data_anno_precedente = date(0)
	end if

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
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			ktvi_treeviewitem.pictureindex = k_pic_close 
			ktvi_treeviewitem.selectedpictureindex = k_pic_open 
		end if

		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//		ktvi_treeviewitem.pictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_pic_open)


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child( k_handle_item_padre)
		
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
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
			
			
			do while sqlca.sqlcode = 0
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_pl_barcode.data = date(0)
				else			
					kst_tab_pl_barcode.data = date(k_anno,k_mese,01)
				end if
				
				
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  P.L. presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  P.L. presenti"
				end if
				kst_tab_treeview.descrizione_tipo = "Piano di Lavorazione" 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				
				kst_tab_pl_barcode.codice = 0
				kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
//				kst_treeview_data.struttura = kst_tab_treeview
//				kst_treeview_data.struttura = kst_tab_pl_barcode

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
			
			close kc_treeview;
		end if

	end if 
 
return k_return


end function

on kuf_pl_barcode_tree.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pl_barcode_tree.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

