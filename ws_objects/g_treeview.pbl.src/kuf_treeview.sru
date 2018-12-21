$PBExportHeader$kuf_treeview.sru
forward
global type kuf_treeview from kuf_parent
end type
end forward

global type kuf_treeview from kuf_parent
end type
global kuf_treeview kuf_treeview

type variables
public kuf_treeview ki_this
public treeview kitv_tv1
public listview kilv_lv1
private datawindow kidw_1
//--- flag da settare x indicare dov'e' il fuoco se su tree o list 
public integer ki_fuoco_tree_list=0 //--- la variabile da settare
public constant integer ki_fuoco_su_nulla=0
public constant integer ki_fuoco_su_tree=1
public constant integer ki_fuoco_su_list=2

public integer ki_forza_refresh=1
public constant integer ki_forza_refresh_si=0
public constant integer ki_forza_refresh_no=1

public st_treeview_oggetto kist_treeview_oggetto 
private st_tab_treeview kist_tab_treeview[220]
private constant int kki_tab_treeview_item_max = 220
public string ki_flag_gia_dentro = "N"
public constant string ki_flag_gia_dentro_SI = "S"
public constant string ki_flag_gia_dentro_NO = "N"

private long ki_item_selezionato=0
private long ki_tab_item_selezionato[221,2] // il primo elemento e' il handle dell'item il secondo il numero di riga

private st_treeview_data kist_treeview_data_precedente // evita la rilettura in caso che richieda lo stesso item

private kuf_wm_pklist_testa kiuf_wm_pklist_testa
private kuf_wm_receiptgammarad kiuf_wm_receiptgammarad
private kuf_wm_pklist_web kiuf_wm_pklist_web
private kuf_sped kiuf_sped
private kuf_armo kiuf_armo
private kuf_certif_file kiuf_certif_file
private kuf_certif kiuf_certif
private kuf_clienti kiuf_clienti

public date ki_data_certif_da_st_da, ki_data_certif_da_st_a

end variables
forward prototypes
public function boolean u_sicurezza (st_tab_treeview kst_tab_treeview)
public function st_esito u_imposta_treeview_icone (ref treeview ktv_1, ref listview klv_1)
public function integer u_chiudi_treeview (long k_handle_item_padre)
public function integer u_select_treeview (long k_handle_item_padre)
public function integer u_delete_item_child (long k_handle_item_padre)
public function integer u_treeview_dragwithin (ref dragobject kobj_oggetto_drag, ref long k_handle_item)
public function integer u_treeview_dragdrop (ref dragobject kobj_oggetto_drag, ref long k_handle_item)
private function integer u_stampa_barcode ()
public function st_treeview_data u_get_st_treeview_data ()
private subroutine u_riempi_listview_adatta_column (string k_oggetto)
public subroutine u_listview_salva_dim_colonne ()
private function integer u_riempi_listview_anag (string k_tipo_oggetto)
private function integer u_riempi_treeview_anag_alfa (string k_tipo_oggetto)
private function integer u_riempi_treeview_anag (string k_tipo_oggetto)
private function integer u_riempi_listview_armo (string k_tipo_oggetto)
public function integer u_stampa_barcode_dettaglio ()
public function st_esito u_select_tab_treeview_all ()
private function integer u_riempi_treeview_root (string k_tipo_oggetto)
private function integer u_riempi_treeview_pl_barcode_mese (string k_tipo_oggetto)
private function integer u_riempi_treeview_sped (string k_tipo_oggetto)
private function integer u_riempi_listview_barcode (string k_tipo_oggetto)
private function integer u_riempi_treeview_armo (string k_tipo_oggetto)
private function integer u_riempi_treeview_certif_dett (string k_tipo_oggetto)
private function integer u_open_pl_barcode_testa (string k_modalita)
private function integer u_open_anag (string k_modalita)
private function integer u_open_riferimenti (string k_modalita)
private function integer u_open_barcode (string k_modalita)
private function integer u_riempi_listview_certif_dett (string k_tipo_oggetto)
public subroutine u_aggiorna_treeview ()
private function integer u_riempi_treeview_certif_mese (string k_tipo_oggetto)
private function integer u_riempi_treeview_pl_barcode_dett (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_lav_mese_att (string k_tipo_oggetto)
private function integer u_riempi_listview_artr_dett (string k_tipo_oggetto)
public function st_treeview_data u_ricava_list_selected ()
private function integer u_open_certif (string k_modalita)
private function integer u_riempi_treeview_artr_dett (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_mese (string k_tipo_oggetto)
private function integer u_riempi_listview_barcode_gener (string k_tipo_oggetto)
private function integer u_riempi_treeview_barcode_data (string k_tipo_oggetto)
private function integer u_riempi_listview_root (string k_tipo_oggetto)
private function integer u_riempi_listview_meca_dett (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_barcode (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_err_giri_dett (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_dett (string k_tipo_oggetto)
private function integer u_riempi_treeview_fatt_testa (string k_tipo_oggetto)
private function integer u_riempi_listview_fatt_testa (string k_tipo_oggetto)
private function integer u_riempi_treeview_fatt_mese (string k_tipo_oggetto)
private function integer u_riempi_treeview_fatt_dett (string k_tipo_oggetto)
private function integer u_riempi_listview_fatt_dett (string k_tipo_oggetto)
public function st_esito u_open (string k_modalita)
private function integer u_open_dosim_lav_ok (string k_modalita)
private function integer u_riempi_treeview_meca_dosim_dett (string k_tipo_oggetto)
private function integer u_riempi_listview_meca_dosim_dett (string k_tipo_oggetto)
public function st_treeview_data u_get_st_treeview_data_padre ()
public function integer u_dammi_item_padre_da_list ()
public function long u_treeview_conta_item ()
private function integer u_open_arfa (string k_modalita)
private function integer u_riempi_treeview_meca_barcode_da_stamp (string k_tipo_oggetto)
private function integer u_riempi_listview_sped (string k_tipo_oggetto)
private function integer u_riempi_listview_sped_righe (string k_tipo_oggetto)
public subroutine u_imposta_propieta (ref treeviewitem ktvi_corrente, string k_tipo_oggetto, st_treeview_oggetto kst_treeview_oggetto)
public function integer u_dammi_pic_tree_list (string k_tipo_oggetto)
public function integer u_dammi_pic_tree_close (string k_tipo_oggetto)
public function integer u_dammi_pic_tree_open (string k_tipo_oggetto)
public subroutine u_sql_scrivi_log (ref transaction ksqlca)
private function integer u_riempi_treeview_meca_err_mese_giri (string k_tipo_oggetto)
private function integer u_riempi_treeview_meca_note_lav_ok (string k_tipo_oggetto)
private function integer u_riempi_treeview_pl_barcode_gener (string k_tipo_oggetto)
public subroutine u_smista_treeview_listview ()
private function integer u_open_sped (string k_modalita)
private subroutine u_select_tab_treeview_id_padre (string k_id_padre, ref st_tab_treeview kst_tab_treeview[100]) throws uo_exception
private function integer u_riempi_treeview_pkl (string k_tipo_oggetto)
private function integer u_riempi_listview_pkl (string k_tipo_oggetto)
private function boolean if_item_x_listview ()
private function integer u_riempi_listview_pkl_righe (string k_tipo_oggetto)
private function integer u_open_wm_pklist (string k_modalita)
private function integer u_open_wm_receiptgammarad (string k_modalita)
private function integer u_open_wm_pklist_web (string k_modalita)
public subroutine u_refresh ()
public subroutine set_kitv_tv1 (ref treeview ktv_tv1)
public subroutine set_kilv_lv1 (ref listview klv_lv1)
public subroutine set_dw_anteprima (ref datawindow kdw_1)
public subroutine u_treeview_data_item_salva ()
public function long u_treeview_data_item_ripristina ()
public subroutine u_treeview_item_salva ()
public function st_esito u_crea_treeview_prod ()
public function integer u_open_riferimenti_autorizza ()
public function string u_get_open_programma ()
public function st_esito u_select_tab_treeview (ref st_tab_treeview kst_tab_treeview)
private function st_esito u_select_tab_treeview (ref st_tab_treeview kst_tab_treeview, string k_modalita)
private function integer u_open_certif_file (string k_modalita)
public function integer u_open_email () throws uo_exception
private function integer u_riempi_treeview_file (string k_tipo_oggetto)
private function integer u_riempi_listview_file (string k_tipo_oggetto)
public function st_treeview_data u_get_st_treeview_data (st_treeview_data ast_treeview_data)
end prototypes

public function boolean u_sicurezza (st_tab_treeview kst_tab_treeview);//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return=true
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

	kst_open_w.id_programma = kst_tab_treeview.id_programma
	kst_open_w.flag_modalita = kkg_flag_modalita.navigatore
	
	if len(trim(kst_open_w.id_programma)) > 0 then
		kuf1_sicurezza = create kuf_sicurezza
		k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		destroy kuf1_sicurezza
	end if
	

return k_return

end function

public function st_esito u_imposta_treeview_icone (ref treeview ktv_1, ref listview klv_1);//
//--- Legge da tab treeview_icone icone e le imposta nella tree e list 
//
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
int k_rc
st_tab_treeview_icone kst_tab_treeview_icone
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	
	declare kc_treeview_icone cursor for
		SELECT treeview_icone.tipo,   
				 treeview_icone.progressivo,   
				 treeview_icone.tipo_nome,   
				 treeview_icone.nome
		from treeview_icone
		order by treeview_icone.progressivo asc
		using sqlca ;
		

//--- imposta proprieta picture 
	ktv_1.deletepictures()
	ktv_1.pictureheight = 16
	ktv_1.picturewidth = 16
	klv_1.deletesmallpictures()
	klv_1.smallpictureheight = 16
	klv_1.smallpicturewidth = 16
	klv_1.deletelargepictures()
	klv_1.largepictureheight = 32
	klv_1.largepicturewidth = 32
	//klv_1.PictureMaskColor = -1
	

//	SELECT max(progressivo)
//	   into k_contati
//		from treeview_icone
//		using sqlca ;
//
////--- creo prima la tab delle picture vuota 
//	for k_ctr = 1 to k_contati
//		ktv_1.addpicture ("vuoto")    
//		klv_1.addsmallpicture ("vuoto")   
//		klv_1.addlargepicture ("vuoto")   
//	end for

	open kc_treeview_icone;
	if sqlca.sqlcode = 0 then

//--- ora riempo la tab delle picture 
		fetch kc_treeview_icone INTO 
			 :kst_tab_treeview_icone.tipo
			,:kst_tab_treeview_icone.progressivo
			,:kst_tab_treeview_icone.tipo_nome
			,:kst_tab_treeview_icone.nome;
	
	
		do while sqlca.sqlcode = 0

//--- se il nome riporta il nome file ICO allora aggiungo il path di default			
			if lower(kst_tab_treeview_icone.tipo_nome) = "f" then
				
				kst_tab_treeview_icone.nome = kGuo_path.get_risorse() + kkg.path_sep + trim(kst_tab_treeview_icone.nome)                     
				//kst_tab_treeview_icone.nome = trim(kst_tab_treeview_icone.nome)                     
				
			end if
				
			k_rc = ktv_1.addpicture (trim(kst_tab_treeview_icone.nome))    
			if k_rc < 1 then 
				ktv_1.addpicture ("Warning!")    
				kst_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int 
				kst_esito.sqlerrtext = "Errore in Impostazione della Picture: " + trim(kst_tab_treeview_icone.nome) + " - Progressivo: " + string(kst_tab_treeview_icone.progressivo)
				Kguo_exception.set_esito( kst_esito )
			end if	
				
			k_rc = klv_1.addsmallpicture (trim(kst_tab_treeview_icone.nome))   
			k_rc = klv_1.addlargepicture (trim(kst_tab_treeview_icone.nome))   
			
			fetch kc_treeview_icone INTO 
				 :kst_tab_treeview_icone.tipo
				,:kst_tab_treeview_icone.progressivo
				,:kst_tab_treeview_icone.tipo_nome
				,:kst_tab_treeview_icone.nome;
			
		loop
		
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Icone del Navigatore (treeview_icone): " + trim(sqlca.SQLErrText)
		end if
		
		close kc_treeview_icone;
		
	else
		kst_esito.esito = "1"
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Icone del Navigatore (treeview_icone): " + trim(sqlca.SQLErrText)
	end if	
	
	
return kst_esito

end function

public function integer u_chiudi_treeview (long k_handle_item_padre);//
long k_handle_item=0
int k_item_del=0, k_rc



//--- Chiudo tutti gli item figli
	k_handle_item = kitv_tv1.FindItem(ChildTreeItem!, k_handle_item_padre) 
	
	DO while k_handle_item > 0

    	k_rc = kitv_tv1.collapseitem(k_handle_item)

	   k_handle_item = kitv_tv1.FindItem(NextTreeItem!, k_handle_item) 
		
	loop



return k_item_del
end function

public function integer u_select_treeview (long k_handle_item_padre);//
long k_handle_item=0
int k_item_del=0, k_rc



//--- Seleziona tutti gli item figli
	k_handle_item = kitv_tv1.FindItem(ChildTreeItem!, k_handle_item_padre) 
	
	DO while k_handle_item > 0

	  	k_rc = kitv_tv1.selectitem(k_handle_item)

	   k_handle_item = kitv_tv1.FindItem(NextTreeItem!, k_handle_item) 
		
	loop



return k_item_del
end function

public function integer u_delete_item_child (long k_handle_item_padre);long k_handle_item=0
int k_item_del=0


//--- cancello tutti gli item prima di ripopolare
	k_handle_item = kitv_tv1.FindItem(ChildTreeItem!, k_handle_item_padre) 
	
	DO while k_handle_item > 0

    	kitv_tv1.DeleteItem(k_handle_item)

	   k_handle_item = kitv_tv1.FindItem(ChildTreeItem!, k_handle_item_padre) 
		
	loop


return k_item_del
end function

public function integer u_treeview_dragwithin (ref dragobject kobj_oggetto_drag, ref long k_handle_item);//
//--- Drag all'interno della tree
//
integer k_return = 0, k_rc
long k_handle_item_drag = 0
string k_tipo_oggetto=" ", k_tipo_oggetto_drag = " "
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 
listviewitem klvi_listviewitem 

	
//--- se l'oggetto di DRAG sia il LISTVIEW
	if kobj_oggetto_drag.typeof() = listview! then

		kilv_lv1 = kobj_oggetto_drag
		
		k_handle_item_drag = 0
		k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
	
		if k_rc > 0 then 
		
			kst_treeview_data = klvi_listviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto_drag = trim(kst_treeview_data.oggetto)
			
			k_handle_item_drag = kst_treeview_data.handle
	
		end if
	end if
		
//--- se l'oggetto di DRAG sia il TREEVIEW
	if kobj_oggetto_drag.typeof() = treeview! then
	
		kitv_tv1 = kobj_oggetto_drag
		k_handle_item_drag = kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_rc = kitv_tv1.getitem(k_handle_item_drag, ktvi_treeviewitem)
	
		if k_rc > 0 then 
	
			kst_treeview_data = ktvi_treeviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto_drag = trim(kst_treeview_data.oggetto)
		
		end if
	end if

		
	if k_handle_item_drag > 0 and not isnull(k_handle_item_drag) then	

		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		if k_rc > 0 then 
	
			kst_treeview_data = ktvi_treeviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto = trim(kst_treeview_data.oggetto)
		
		end if
	
		choose case lower(k_tipo_oggetto_drag)
				
			case kist_treeview_oggetto.barcode, &
				  kist_treeview_oggetto.barcode_dett
				  
				choose case lower(k_tipo_oggetto)
					case kist_treeview_oggetto.barcode_no_st, &
						  kist_treeview_oggetto.barcode_gia_st, &
						  kist_treeview_oggetto.barcode_dett
							 
				   	kobj_oggetto_drag.dragicon = " "
						
					case else
//						kGuo_path.get_risorse() = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
//					   	kobj_oggetto_drag.dragicon = kGuo_path.get_risorse() + "\Nodrop.ico"
			   			kobj_oggetto_drag.dragicon = "Nodrop.ico"
						
				end choose

			case else
//				kGuo_path.get_risorse() = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
//				kobj_oggetto_drag.dragicon = kGuo_path.get_risorse() + "\Nodrop.ico"
	   			kobj_oggetto_drag.dragicon = "Nodrop.ico"

				

		end choose
	end if

	
	

return k_return
end function

public function integer u_treeview_dragdrop (ref dragobject kobj_oggetto_drag, ref long k_handle_item);//
//--- Drag all'interno della tree
//
integer k_return = 0, k_rc
long k_handle_item_drag = 0
string k_tipo_oggetto=" ", k_tipo_oggetto_drag = " "
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 
listviewitem klvi_listviewitem 

	
//--- se l'oggetto di DRAG sia il LISTVIEW
	if kobj_oggetto_drag.typeof() = listview! then

		kilv_lv1 = kobj_oggetto_drag
		
		k_handle_item_drag = 0
		k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
	
		if k_rc > 0 then 
		
			kst_treeview_data = klvi_listviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto_drag = trim(kst_treeview_data.oggetto)
			
			k_handle_item_drag = kst_treeview_data.handle
	
		end if
	end if
		
//--- se l'oggetto di DRAG sia il TREEVIEW
	if kobj_oggetto_drag.typeof() = treeview! then
	
		kitv_tv1 = kobj_oggetto_drag
		k_handle_item_drag = kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_rc = kitv_tv1.getitem(k_handle_item_drag, ktvi_treeviewitem)
	
		if k_rc > 0 then 
	
			kst_treeview_data = ktvi_treeviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto_drag = trim(kst_treeview_data.oggetto)
		
		end if
	end if

		
	if k_handle_item_drag > 0 and not isnull(k_handle_item_drag) then	

		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		if k_rc > 0 then 
	
			kst_treeview_data = ktvi_treeviewitem.data  
	
			ktvi_treeviewitem.data = kst_treeview_data 
	
			k_tipo_oggetto = trim(kst_treeview_data.oggetto)
		
		end if
	
		choose case lower(k_tipo_oggetto_drag)
				
//--- drag su se' stesso
			case k_tipo_oggetto
				
			case kist_treeview_oggetto.barcode, &
				  kist_treeview_oggetto.barcode_dett
				  
				choose case lower(k_tipo_oggetto)
					case kist_treeview_oggetto.barcode_no_st
		   			ktvi_treeviewitem.DropHighLighted = true	
						k_rc = kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
						
						
					case kist_treeview_oggetto.barcode_gia_st 
		   			ktvi_treeviewitem.DropHighLighted = true	
		   			ktvi_treeviewitem.selected = true	
						k_rc = kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				
						u_stampa_barcode_dettaglio()
						
		   			kitv_tv1.selectitem (k_handle_item)	
							 
						
					case else
						
				end choose

//--- altrimenti se tipo oggetto di origine e' altro
			case else

				

		end choose
	end if

	
return k_return


end function

private function integer u_stampa_barcode ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_lindex = 0, k_n_selezionati=0, k_rc
long k_handle_item = 0
integer k_ctr, k_nr_barcode_stampati=0, k_barcode_da_stampare=0
boolean k_stampa_da_listview=true
boolean k_ristampa_gia_risposto=false, k_stampa_gia_risposto=false
st_esito kst_esito

st_tab_barcode kst_tab_barcode, kst_tab_barcode_old, kst_tab_barcode_x_wm[]
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe

st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem

kuf_barcode_stampa kuf1_barcode_stampa
kuf_armo kuf1_armo
kuf_armo_inout kuf1_armo_inout
kuf_wm_pklist_inout kuf1_wm_pklist_inout


//--- 
//--- scopro se stampare il barcode in LIST o TREEVIEW				
//--- lettura primo giro
k_n_selezionati = kilv_lv1.TotalSelected()
if k_n_selezionati > 0 then
	k_stampa_da_listview = true
	k_lindex = 1
	k_rc = kilv_lv1.getitem(k_lindex, 1, klvi_listviewitem) 
	do while k_rc > 0 and not klvi_listviewitem.selected and k_lindex <= kilv_lv1.totalitems()
		k_lindex++
		k_rc = kilv_lv1.getitem(k_lindex, 1, klvi_listviewitem) 
	loop		

	if klvi_listviewitem.selected then
		kst_treeview_data = klvi_listviewitem.data  
	end if

else
	
	k_stampa_da_listview = false
	k_n_selezionati = 1
	k_lindex = kitv_tv1.finditem(CurrentTreeItem!, 0)
	if k_lindex > 0  then
		kitv_tv1.getitem(k_lindex, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data  
	else
		k_lindex = 0
	end if
end if


//--- se ho trovato da dove stampare ricavo il barcode/riferimento selezionato...
if k_lindex > 0 then 

	kuf1_barcode_stampa = create kuf_barcode_stampa
	kuf1_armo = create kuf_armo
	kuf1_armo_inout = create kuf_armo_inout
	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
		
	ktvi_treeviewitem.data = kst_treeview_data 
	kst_treeview_data_any = kst_treeview_data.struttura
	kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 

	kuf1_barcode_stampa.ki_stampa_etichetta_autorizza = true

	if kst_tab_barcode.num_int > 0 &
		and not isnull(kst_tab_barcode.num_int) & 
		then

		kst_tab_barcode_old.barcode = " "
		kst_tab_barcode_old.num_int = 0
		
//--- Open della coda di stampa
		kuf1_barcode_stampa.stampa_etichetta_riferimento_open(kst_tab_barcode)
		if kuf1_barcode_stampa.ki_id_print_etichette > 0 then


//--- Ciclo di stampa ETICHETTE
			do while k_n_selezionati > 0

//--- Verifica se sono in stampa o ristampa?
				k_barcode_da_stampare = kuf1_barcode_stampa.stampa_etichetta_riferimento_ristampa &
												(kst_tab_barcode.barcode, &
												 kst_tab_barcode.id_meca)
												// kst_tab_barcode.data_int)

				if k_barcode_da_stampare < 0 then
					k_n_selezionati = 0
					messagebox("Operazione Interrotta", &
									"Lettura Barcode nel Database in errore:~n~r" &
									+ string(k_barcode_da_stampare) ) //+ " - " + trim(kst_esito.sqlerrtext))
				else
					
					k_rc = 1
					if k_barcode_da_stampare > 0 then
						if not k_stampa_gia_risposto then
							k_stampa_gia_risposto=true
							if len(kst_tab_barcode.barcode) > 0 then
								k_rc = messagebox("Stampa Singolo Barcode", &
												"Riferimento " + string(kst_tab_barcode.num_int) + " del " &
												+ string(kst_tab_barcode.data_int) + "~n~r~n~r"  &
												+ "Barcode: " + string(kst_tab_barcode.barcode) +"~n~r" &
												+ "Eseguire la stampa dei Barcode selezionati ?~n~r", &
												question!, yesno!, 1) 
							else
								k_rc = messagebox("Stampa Intero Riferimento", &
												"Riferimento " + string(kst_tab_barcode.num_int) + " del " &
												+ string(kst_tab_barcode.data_int) + "~n~r~n~r"  &
												+ "Eseguire la stampa di tutti i Barcode?~n~r", &
												question!, yesno!, 1) 
							end if
						end if
					else
						if not k_ristampa_gia_risposto then
							k_ristampa_gia_risposto=true
							if len(kst_tab_barcode.barcode) > 0 then
								k_rc = messagebox("Ristampa del Barcode", &
												"Riferimento " + string(kst_tab_barcode.num_int) + " del " &
												+ string(kst_tab_barcode.data_int) + "~n~r~n~r"  &
												+ "Barcode: " + string(kst_tab_barcode.barcode) +"~n~r" &
												+ "Stampa Barcode gia' emessa.~n~rRieseguire la Stampa dei Barcode selezionati?", &
												question!, yesno!, 2) 
							else
								k_rc = messagebox("Ristampa Intero Riferimento", &
												"Riferimento " + string(kst_tab_barcode.num_int) + " del " &
												+ string(kst_tab_barcode.data_int) + "~n~r~n~r"  &
												+ "Stampa Barcode gia' emessa.~n~rRieseguire la Stampa di tutti i Barcode?", &
												question!, yesno!, 2) 
							end if
						end if
					end if
					if k_rc = 1  then
					
						k_ctr = kuf1_barcode_stampa.stampa_etichetta_riferimento &
														(kst_tab_barcode.barcode, &
														 kst_tab_barcode.id_meca)
														// kst_tab_barcode.data_int)
				
						if k_ctr > 0 then
							k_nr_barcode_stampati += k_ctr
	
//--- Stampa avvertenze
							kst_tab_armo.num_int = kst_tab_barcode.num_int
							kst_tab_armo.data_int = kst_tab_barcode.data_int
							kuf1_armo.get_id_meca(kst_tab_armo)
							kst_tab_meca.id = kst_tab_armo.id_meca
							if kuf1_armo.if_stampa_etichetta_avvertenze(kst_tab_meca) then
								
								kuf1_barcode_stampa.stampa_etichetta_riferimento_avvertenze (kst_tab_barcode.barcode, &
																										 kst_tab_barcode.num_int, &
																										 kst_tab_barcode.data_int)
							end if
							
//--- cancello item stampato dalla lista			
							if k_stampa_da_listview then
								k_rc = kilv_lv1.deleteitem(k_lindex) 
							else
								k_rc = kitv_tv1.deleteitem(k_lindex)
							end if					
						end if


//--- fa altre operazioni  ---------------------------------------------------------------------------------------------------------------------
						try 
							
//--- ricava ID_MECA							
							if kst_tab_barcode.id_meca > 0 then
								kst_tab_armo.id_meca = kst_tab_barcode.id_meca
							else
								kst_tab_armo.num_int = kst_tab_barcode.num_int
								kst_tab_armo.data_int = kst_tab_barcode.data_int
								kst_esito = kuf1_armo.get_id_meca(kst_tab_armo)
								kst_tab_barcode.id_meca = kst_tab_armo.id_meca
							end if 
							if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then 

//--- Imposta i Barcode nella PKLIST grezza di WM
								kst_tab_wm_pklist_righe.id_meca = kst_tab_barcode.id_meca
								kuf1_wm_pklist_inout.set_barcode_in_wm_receiptgammarad(kst_tab_wm_pklist_righe)
								
							else
								kguo_exception.set_esito( kst_esito )
							end if
							
						catch (uo_exception kuo_exception)
							kuo_exception.messaggio_utente()
							
						end try					


						try 

//--- Carica i PREZZI di Listino per le righe del Lotto (riferimento)
							kuf1_armo_inout.carica_prezzi_lotto(kst_tab_armo)
							
						catch (uo_exception kuo1_exception)
							kuo1_exception.messaggio_utente()
							
					
						end try					
							

//--- FINE: altre operazioni ----------------------------------------------------------------------------------------------------------------


//--- Se stampa da LIST potrei avere selezionato piu' barcode/riferimenti				
						if k_stampa_da_listview then
							
							do 
		
								k_lindex = 1
								k_rc = kilv_lv1.getitem(k_lindex, 1, klvi_listviewitem) 
								do while k_rc > 0 and not klvi_listviewitem.selected and k_lindex <= kilv_lv1.totalitems()
									k_lindex++
									k_rc = kilv_lv1.getitem(k_lindex, 1, klvi_listviewitem) 
								loop		
								if klvi_listviewitem.selected then
									kst_treeview_data = klvi_listviewitem.data  
									ktvi_treeviewitem.data = kst_treeview_data 
									kst_treeview_data_any = kst_treeview_data.struttura
									kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
								else
									k_lindex = kilv_lv1.totalitems() + 1 // forzo uscita dal ciclo
								end if
								
							loop while kst_tab_barcode_old.barcode = kst_tab_barcode.barcode &
								and kst_tab_barcode_old.num_int = kst_tab_barcode.num_int &
								and kst_tab_barcode_old.data_int =  kst_tab_barcode.data_int &
								and k_lindex <= kilv_lv1.totalitems()
							
						end if
		
						kst_tab_barcode_old = kst_tab_barcode   // x evitare la ristampa delle stesse etichette
					else
						k_n_selezionati = 0 // forzo uscita dal ciclo
					end if

				end if

				k_n_selezionati --
				
			loop
			
//--- chiudo coda di stampa
			kuf1_barcode_stampa.stampa_etichetta_riferimento_close()
		
		end if
	else
		
//		messagebox("Stampa Codice a Barre", "Valore non disponibile. ")
		
		
	end if

	destroy kuf1_barcode_stampa
	destroy kuf1_armo
	destroy kuf1_wm_pklist_inout

	if k_nr_barcode_stampati > 0 then

		messagebox("Operazione di Stampa in esecuzione","Stampa di " &
		         + string (k_nr_barcode_stampati) + " Barcode, inviata alla stampante ")


//--- cancello item stampato dalla lista			
//			choose case kGuf_data_base.u_getfocus_typeof()
//				case listview!
//					k_rc = kilv_lv1.deleteitem(kilv_lv1.SelectedIndex ( )) 
//		
//				case treeview!
//					k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//					if k_rc > 0 then
//						kitv_tv1.deleteitem(k_rc)
//					end if
//		
//			end choose
	end if
					


end if

 
return k_return

end function

public function st_treeview_data u_get_st_treeview_data ();//
//--- ricavo la struttura con il relativo tipo oggetto della treeview o listview 
//--- il Tipo Oggetto è poi il valore impostato nel campo FUNZIONE in tabella menu_window  
//
integer k_rc
long k_handle_item = 0
string k_tipo_oggetto="none"
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 
listviewitem klvi_listviewitem 


	k_handle_item = 0


	if ki_fuoco_tree_list <> ki_fuoco_su_nulla then

//		CHOOSE CASE TypeOf(kcontrol_focus)

		CHOOSE CASE	ki_fuoco_tree_list
			CASE ki_fuoco_su_tree
//			CASE treeview!
		
				k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
//				k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
				if k_handle_item > 0 then
					kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
//--- ricavo il tipo oggetto			
					kst_treeview_data = ktvi_treeviewitem.data
					k_tipo_oggetto = trim(kst_treeview_data.oggetto)
				else
//--- se non esiste seleziono il ROOT
					k_handle_item = kitv_tv1.finditem(RootTreeItem!, 0)
					if k_handle_item > 0 then
						kitv_tv1.selectitem(k_handle_item)
					end if
				end if

	
		END CHOOSE

	end if
		
	if k_tipo_oggetto = "none" then 
		
		k_rc = kilv_lv1.SelectedIndex()
		if k_rc > 0 then
			k_rc = kilv_lv1.getitem(k_rc, 1, klvi_listviewitem) 
			if k_rc > 0 then 
			
				kst_treeview_data = klvi_listviewitem.data  
	
	//--- ricavo il tipo oggetto dalla Tree se non c'e' nel il list			
				if (len(trim(kst_treeview_data.oggetto)) = 0 or isnull(kst_treeview_data.oggetto) ) and kst_treeview_data.handle > 0 then
					k_rc = kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem)
					if k_rc >0 then 
						kst_treeview_data = ktvi_treeviewitem.data
					end if
				end if
			end if
		end if

			
//--- se il controllo su la list non va a buon fine.....
		if k_rc > 0 and trim(kst_treeview_data.oggetto) > " " then
		else
			
//--- ricavo il tipo oggetto dalla treeview se non c'e' il list			
			k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
			if k_handle_item > 0 then
				if kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) > 0 then  //se ok
	
//--- ricavo il tipo oggetto			
					kst_treeview_data = ktvi_treeviewitem.data

				else
					k_handle_item = 0
				end if
			end if	
			
//--- se ITEM non trovato seleziono il ROOT
			if k_handle_item <= 0 then
				k_handle_item = kitv_tv1.finditem(RootTreeItem!, 0)
				if k_handle_item > 0 then
					k_rc = kitv_tv1.selectitem(k_handle_item)
					if k_rc > 0 then
						k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
						if k_rc > 0 then
							kst_treeview_data = ktvi_treeviewitem.data
						end if
					end if
				else
					kst_treeview_data.oggetto = "root"
				end if
			end if

		end if
	end if

//--- se oggetto non reperito lo inizializzo
//	if  len(trim(kst_treeview_data.oggetto)) = 0 or isnull(kst_treeview_data.oggetto) then kst_treeview_data.oggetto = "start"
	if isnull(kst_treeview_data.oggetto) then kst_treeview_data.oggetto = "root"
		

return kst_treeview_data

end function

private subroutine u_riempi_listview_adatta_column (string k_oggetto);//
string k_campo 
integer k_larg_campo, k_ctr, k_rc
alignment k_align
st_profilestring_ini kst_profilestring_ini



//--- Ricavo le dimensioni delle colonne
   k_ctr = 1
	k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align, k_larg_campo)
	do while  k_rc > 0

		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.file = "treeview"
		kst_profilestring_ini.titolo = "treeview"
		kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_oggetto) + "_" + k_campo
		kst_profilestring_ini.valore = "0"
		k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito = "0" then
			k_larg_campo = integer(kst_profilestring_ini.valore)
		end if
		if k_larg_campo = 0 then
			k_larg_campo = (kilv_lv1.width) / 4 //50 * len(trim(k_campo)) 
		end if
		k_ctr++
		k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align , k_larg_campo)
	loop

end subroutine

public subroutine u_listview_salva_dim_colonne ();//
int k_return
string k_campo, k_tipo_oggetto 
long k_handle_item
integer k_larg_campo, k_ctr, k_rc
st_treeview_data kst_treeview_data
st_profilestring_ini kst_profilestring_ini
alignment k_align
listviewitem klvi_listviewitem
//treeviewitem ktvi_treeviewitem


if isvalid(kilv_lv1) then
		
	k_rc = kilv_lv1.getitem(1, 1, klvi_listviewitem) 
	if k_rc > 0 then 
		
		kst_treeview_data = klvi_listviewitem.data  

//--- spero di ricavare l'oggetto dal piu' nuovo tipo oggetto_list altrimenti provo
//--- il tradizionale 'oggetto'
		if len(trim(kst_treeview_data.oggetto_listview)) > 0 then
			k_tipo_oggetto = trim(kst_treeview_data.oggetto_listview)
		else
			k_tipo_oggetto = trim(kst_treeview_data.oggetto)
		end if
		
		if len(trim(k_tipo_oggetto)) > 0 then

//--- Salvo dimensioni delle colonne
			k_ctr = 1
			k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align, k_larg_campo)
			do while  k_rc > 0
		
				kst_profilestring_ini.operazione = "2"
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + trim(k_campo)
				kst_profilestring_ini.valore = string(k_larg_campo)
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
						
				k_ctr++
				k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align , k_larg_campo)
				
			loop
			
		end if
		
	end if

end if
//---

end subroutine

private function integer u_riempi_listview_anag (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0

if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti

k_return = kiuf_clienti.u_tree_riempi_listview( ki_this, k_tipo_oggetto )


return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
////long k_handle_item_corrente = 0, k_handle_item_padre = 0, k_handle_item_nonno, k_handle_item_rit=0
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
//integer k_ctr, k_pictureindex
//date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
//long k_clie_2=0
//string k_rag_soc_10 , k_label, k_stato_barcode="", k_tipo_oggetto_figlio, k_oggetto_padre
//int k_ind, k_mese, k_anno
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_clienti kst_tab_clienti
//st_tab_iva kst_tab_iva
//st_tab_pagam kst_tab_pagam
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- ricavo il tipo oggetto 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//	
//	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
////--- item di ritorno di default
//		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//	
////--- prendo il item padre per settare il ritorno di default
//	k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//	if k_handle_item_padre > 0 then
//		k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	else
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//	end if
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_oggetto_padre = trim(kst_treeview_data.oggetto)
//
//	
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//		 
//	klvi_listviewitem.data = kst_treeview_data
//	klvi_listviewitem.label = ".."
//	klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//	k_handle_item_rit = kilv_lv1.additem(klvi_listviewitem)
//		
//	if k_handle_item_corrente > 0 then
//
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//
////--- leggo il primo item dalla treeview per esporlo nella list
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//
//		kilv_lv1.DeleteColumns ( )
//		
////--- 
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//		if k_label <> "Anagrafe" then 
//  		
////=== Costruisce e Dimensiona le colonne all'interno della listview
//			kilv_lv1.DeleteColumns ( )
//			k_ind=1
//			k_campo[k_ind] = "Anagrafe"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "codice"
//			k_align[k_ind] = right!
//			k_ind++
//			k_campo[k_ind] = "Telefono/fax"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Indirizzo"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Pagamento"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "P.IVA"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "IVA"
//			k_align[k_ind] = right!
//			k_ind++
//			k_campo[k_ind] = "Ulteriori Informazioni"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "FINE"
//			k_align[k_ind] = left!
//			
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
// 
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//				
//			loop
//
//		end if
//
//
////--- imposto il pic corretto
////		k_handle_item_corrente1 = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
////		k_rc = kitv_tv1.getitem(k_handle_item_corrente1, ktvi_treeviewitem) 
////		kst_treeview_data = ktvi_treeviewitem.data  
////		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_tipo_oggetto)			
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//			kst_tab_iva = kst_treeview_data_any.st_tab_iva
//			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam
//
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.pictureindex = k_pictureindex
//			
//			klvi_listviewitem.selected = false
//			
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			k_ind=1
//			kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10) &
//								+ " " + trim(kst_tab_clienti.rag_soc_20))
//
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.codice , "#####0") )
//	
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_clienti.fono)) &
//			                + "  /  " + trim(string(kst_tab_clienti.fax)) &
//								 )
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, &
//									   trim(string(kst_tab_clienti.loc_1)) + "  (" &
//									 + trim(string(kst_tab_clienti.prov_1)) + ")  " &
//									 + trim(string(kst_tab_clienti.cap_1)) + "  " &
//			                   + trim(string(kst_tab_clienti.indi_1)) + "  " &
//									 )
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.cod_pag, "#####") &
//									 + "  " + string(kst_tab_pagam.des) + "  " &
//									)
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, &
//									   trim(string(kst_tab_clienti.p_iva)) + "  " &
//									)
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.iva, "####") &
//									 + "  " + string(kst_tab_iva.des) + "  " &
//									)
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, &
//									   trim(string(kst_tab_clienti.banca)) + "  " &
//									 + trim(string(kst_tab_clienti.abi)) + "-" &
//									 + trim(string(kst_tab_clienti.cab)) + "  " &
//									 )
//			
////--- Leggo rec next dalla tree				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//
//		loop
//		
//	end if
// 
// 	if k_handle_item_rit > 0 then
//		kst_treeview_data.handle_padre = k_handle_item_corrente
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto = k_oggetto_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//	end if
//
//	 
//	if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kilv_lv1.extendedselect = true 
//			
//	end if
//
//
// 
//return k_return
//
end function

private function integer u_riempi_treeview_anag_alfa (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0

if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti

k_return = kiuf_clienti.u_tree_riempi_treeview_alfa( ki_this, k_tipo_oggetto )


return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_corrente = 0, k_handle_item_figlio = 0, k_handle_primo=0
//long k_contati, k_totale
//integer k_ctr, k_pic_close, k_pic_open
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
//date k_save_data_int
//string k_alfa
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_clienti kst_tab_clienti
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (*), 
//         substr(clienti.rag_soc_10, 1, 1) as alfa
//     FROM clienti
//		 group by  2
//		 order by  2 asc;
//
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//		 
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//
//	if k_handle_item_corrente > 0 then
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_corrente = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta(ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//		end if
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_corrente)
//
////--- Riga solo x accedere a tutti i clienti	
//		kst_tab_treeview.descrizione_tipo = "Anagrafiche " 
//		kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//		kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//		kst_treeview_data.struttura = kst_treeview_data_any
//		kst_treeview_data.handle = k_handle_item_corrente
//		ktvi_treeviewitem.label = kst_treeview_data.label
//		ktvi_treeviewitem.data = kst_treeview_data
////--- Nuovo Item
//		ktvi_treeviewitem.selected = false
//		k_handle_primo = kitv_tv1.insertitemlast(k_handle_item_corrente, ktvi_treeviewitem)
////--- salvo handle del item appena inserito nella stessa struttura
//		kst_treeview_data.handle = k_handle_primo
////--- inserisco il handle di questa riga tra i dati del item
//		ktvi_treeviewitem.data = kst_treeview_data
//		kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :k_contati
//					 ,:k_alfa
//					  ;
//	
//		
////--- estrazione carichi vera e propria			
//			do while sqlca.sqlcode = 0
//	
//				k_totale = k_totale + k_contati
//	
//				if isnull(k_alfa) then
//					k_alfa = "*senza nome*"
//					kst_tab_treeview.id = " "
//				else	
//					kst_tab_treeview.id = k_alfa
//					k_alfa = k_alfa + "..."
//				end if
//				kst_treeview_data.label = k_alfa  
//				kst_tab_treeview.voce = kst_treeview_data.label
//				
//				if k_contati = 1 then
//					kst_tab_treeview.descrizione = string(k_contati, "###,##0") + "  anagrafica presente"
//				else
//					kst_tab_treeview.descrizione = string(k_contati, "###,##0") + "  anagrafiche presenti"
//				end if
//
//				kst_tab_treeview.descrizione_tipo = "Anagrafiche " 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kst_treeview_data.handle = k_handle_item_corrente
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_corrente, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
//				fetch kc_treeview 
//					into
//					  :k_contati
//					 ,:k_alfa
//					  ;
//	
//			loop
//			
//			close kc_treeview;
//			
//		end if
//			
////--- Aggiorno il primo Item con i totali
//		kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data 
//		kst_tab_treeview = kst_treeview_data_any.st_tab_treeview 
//		kst_treeview_data.struttura = kst_treeview_data_any
//		kst_tab_treeview.id = "%"
//		kst_treeview_data.label = "Tutte" 
//		kst_tab_treeview.voce = kst_treeview_data.label
//		kst_tab_treeview.descrizione = &
//			 string(k_totale, "###,###,##0") + "  tutte le anagrafiche"
//		kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//		kst_treeview_data.struttura = kst_treeview_data_any
//		ktvi_treeviewitem.label = kst_treeview_data.label
//		ktvi_treeviewitem.data = kst_treeview_data
//		kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_anag (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0


if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti

k_return = kiuf_clienti.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_pic_open, k_pic_close
//string k_tipo_oggetto_padre
//string k_oggetto_corrente, k_tipo_oggetto_figlio
//string k_alfa
//integer k_ctr
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_clienti kst_tab_clienti
//st_tab_pagam kst_tab_pagam
//st_tab_iva kst_tab_iva
//st_tab_treeview kst_tab_treeview
//treeviewitem ktvi_treeviewitem
//
//
//declare kc_treeview cursor for
//  SELECT   clienti.codice ,
//           clienti.rag_soc_10,
//           clienti.rag_soc_11,
//           clienti.indi_1,
//           clienti.cap_1 ,
//           clienti.loc_1,
//           clienti.prov_1 ,
//           clienti.zona ,
//           clienti.p_iva ,
//           clienti.fono,
//           clienti.fax, 
//           clienti.cod_pag, 
//           clienti.banca, 
//           clienti.abi, 
//           clienti.cab, 
//           clienti.tipo_banca, 
//           clienti.iva, 
//			  pagam.des,
//			  iva.des
//        FROM clienti left outer join pagam on
//              clienti.cod_pag = pagam.codice
//				         left outer join iva on
//				  clienti.iva     = iva.codice
//        WHERE upper(clienti.rag_soc_10) like :k_alfa   
//		        or ( (clienti.rag_soc_10 is null or clienti.rag_soc_10 = " ") and  :k_alfa = '-' ) 
//		  order by clienti.rag_soc_10
//		  using sqlca;
//
//
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto
//	end if
//
//
////--- Lettera di Estrazione		
//   kst_treeview_data_any = kst_treeview_data.struttura 
//   kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//	k_alfa = upper(trim(kst_tab_treeview.id))
//	if len(k_alfa) = 0 or isnull(k_alfa) then
//	   k_alfa = "-"
//	else
//		if k_alfa <> "%" then
//			k_alfa = k_alfa + "%"
//		end if
//	end if
//	
//
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
//	
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					:kst_tab_clienti.codice,
//					:kst_tab_clienti.rag_soc_10,
//					:kst_tab_clienti.rag_soc_11,
//					:kst_tab_clienti.indi_1,
//					:kst_tab_clienti.cap_1,
//					:kst_tab_clienti.loc_1,   
//					:kst_tab_clienti.prov_1,   
//					:kst_tab_clienti.zona,
//					:kst_tab_clienti.p_iva,
//					:kst_tab_clienti.fono,
//					:kst_tab_clienti.fax,
//					:kst_tab_clienti.cod_pag, 
//					:kst_tab_clienti.banca,
//					:kst_tab_clienti.abi,
//					:kst_tab_clienti.cab,
//					:kst_tab_clienti.tipo_banca,
//					:kst_tab_clienti.iva,
//					:kst_tab_pagam.des,
//					:kst_tab_iva.des
//					  ;
//	
//	
//			do while sqlca.sqlcode = 0
//				
//				
//				kst_treeview_data.handle = 0
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data.struttura = kst_treeview_data_any
//
////			   klvi_listviewitem.data = kst_treeview_data
//
//				if isnull(kst_tab_clienti.rag_soc_10) then
//					kst_tab_clienti.rag_soc_10 = " "
//				end if
//				if isnull(kst_tab_clienti.rag_soc_11) then
//					kst_tab_clienti.rag_soc_11 = " "
//				end if
//				if isnull(kst_tab_clienti.indi_1) then
//					kst_tab_clienti.indi_1 = " "
//				end if
//				if isnull(kst_tab_clienti.cap_1) then
//					kst_tab_clienti.cap_1 = " "
//				end if
//				if isnull(kst_tab_clienti.loc_1) then
//					kst_tab_clienti.loc_1 = " "
//				end if
//				if isnull(kst_tab_clienti.prov_1) then
//					kst_tab_clienti.prov_1 = " "
//				end if
//				if isnull(kst_tab_clienti.fono) then
//					kst_tab_clienti.fono = " "
//				end if
//				if isnull(kst_tab_clienti.fax) then
//					kst_tab_clienti.fax = " "
//				end if
//				if isnull(kst_tab_clienti.p_iva) then
//					kst_tab_clienti.p_iva = " "
//				end if
//				if isnull(kst_tab_clienti.cod_pag) then
//					kst_tab_clienti.cod_pag = 0
//				end if
//				if isnull(kst_tab_clienti.zona) then
//					kst_tab_clienti.zona = "0"
//				end if
//				if isnull(kst_tab_clienti.iva) then
//					kst_tab_clienti.iva = 0
//				end if
//				if isnull(kst_tab_clienti.tipo_banca) then
//					kst_tab_clienti.tipo_banca = " "
//				end if
//				if isnull(kst_tab_clienti.banca) then
//					kst_tab_clienti.banca = " "
//				end if
//				if isnull(kst_tab_clienti.abi) then
//					kst_tab_clienti.abi = 0
//				end if
//				if isnull(kst_tab_clienti.cab) then
//					kst_tab_clienti.cab = 0
//				end if
//				if isnull(kst_tab_pagam.des) then
//					kst_tab_pagam.des = " "
//				end if
//				if isnull(kst_tab_iva.des) then
//					kst_tab_iva.des = " "
//				end if
//		
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
//				kst_treeview_data_any.st_tab_iva = kst_tab_iva
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				kst_treeview_data.label = & 
//				                     trim(kst_tab_clienti.rag_soc_10)  & 
//					                 + "  (" + string(kst_tab_clienti.codice) + ") "
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
//				fetch kc_treeview 
//					into
//					:kst_tab_clienti.codice,
//					:kst_tab_clienti.rag_soc_10,
//					:kst_tab_clienti.rag_soc_11,
//					:kst_tab_clienti.indi_1,
//					:kst_tab_clienti.cap_1,
//					:kst_tab_clienti.loc_1,   
//					:kst_tab_clienti.prov_1,   
//					:kst_tab_clienti.zona,
//					:kst_tab_clienti.p_iva,
//					:kst_tab_clienti.fono,
//					:kst_tab_clienti.fax,
//					:kst_tab_clienti.cod_pag, 
//					:kst_tab_clienti.banca,
//					:kst_tab_clienti.abi,
//					:kst_tab_clienti.cab,
//					:kst_tab_clienti.tipo_banca,
//					:kst_tab_clienti.iva,
//					:kst_tab_pagam.des,
//					:kst_tab_iva.des
//					  ;
//	
//	
//			loop
//			
//			close kc_treeview;
//		end if
//	end if	
// 
//
// 
//return k_return
//
end function

private function integer u_riempi_listview_armo (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_listview_righe_rifer( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente
//integer k_ctr, k_pictureindex
//date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
//long k_clie_2=0
//string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre
//int k_ind, k_mese, k_anno
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_armo kst_tab_armo
//st_tab_prodotti kst_tab_prodotti
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_sl_pt kst_tab_sl_pt
//st_tab_treeview kst_tab_treeview
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
////	kst_tab_treeview.id = k_tipo_oggetto
////	u_select_tab_treeview(kst_tab_treeview)
////	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item = kst_treeview_data.handle
//	
//	if k_handle_item > 0 then
//
////--- prendo il item padre per settare il ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//
//	end if
//		
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item = 0 or isnull(k_handle_item) then	
//	
////--- item di ritorno di default
//		k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		
//	end if
//
////--- item di ritorno di default
//	k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_tipo_oggetto_padre = kst_treeview_data.oggetto	
//
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//	if k_handle_item_padre > 0 then
////		kst_treeview_data.handle_padre = k_handle_item
////		kst_treeview_data.handle = k_handle_item_padre
////		kst_treeview_data.oggetto = k_tipo_oggetto
////		ktvi_treeviewitem.data = kst_treeview_data
////		klvi_listviewitem.label = ".."
////		klvi_listviewitem.data = kst_treeview_data
////		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
////		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//		kst_treeview_data.handle_padre = k_handle_item
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		kst_treeview_data.oggetto = k_tipo_oggetto_padre
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//	end if
//		
//	if k_handle_item > 0 then
//
//		kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//
//		kst_treeview_data = ktvi_treeviewitem.data
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//				 
//
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//					
//		if k_label <> "Articolo" then 
//  		
////=== Costruisce e Dimensiona le colonne all'interno della listview
//			kilv_lv1.DeleteColumns ( )
//			k_ind=1
//			k_campo[k_ind] = "Articolo"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Riferimento"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Magazzino"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Colli entrati/fatturati"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Pedane"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Dose"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Campione"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Peso"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Misure"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "SL-PT"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Ulteriori Informazioni"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "FINE"
//			k_align[k_ind] = left!
//			
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
// 
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//			loop
//
//		end if
//
//
////--- imposto il pic corretto
//		k_handle_item_corrente = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_armo = kst_treeview_data_any.st_tab_armo
//			kst_tab_meca = kst_treeview_data_any.st_tab_meca
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt
//			kst_tab_prodotti = kst_treeview_data_any.st_tab_prodotti
//
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.pictureindex = k_pictureindex
//			
//			klvi_listviewitem.selected = false
//			
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_armo.art) &
//								+ " " + trim(kst_tab_prodotti.des))
//
//			kilv_lv1.setitem(k_ctr, 2, string(kst_tab_armo.data_int , "dd/mm/yy") + string(kst_tab_armo.num_int , "  ####0"))
//	
//			kilv_lv1.setitem(k_ctr, 3, string(kst_tab_armo.magazzino))
//			if kst_tab_armo.colli_fatt > 0 then 
//				kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.colli_2, "####0") + "/" &
//									 + string(kst_tab_armo.colli_fatt, "####0"))
//			else
//				kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.colli_2, "####0"))
//			end if
//			kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.pedane, "####0"))
//			kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.dose, "#,##0.00"))
//			kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_armo.campione))
//			kilv_lv1.setitem(k_ctr, 8, string(kst_tab_armo.peso_kg, "##,##0.00"))
//
//			kilv_lv1.setitem(k_ctr, 9, string(kst_tab_armo.alt_2, "###0") &
//									+ "x" + string(kst_tab_armo.lung_2, "###0")  &
//									+ "x" + string(kst_tab_armo.larg_2, "###0"))
//			
//			
//			if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
//				kilv_lv1.setitem(k_ctr, 10, trim(kst_tab_sl_pt.cod_sl_pt) &
//									 + " " + trim(kst_tab_sl_pt.descr) &
//									 + "   dose min-max: " + string(kst_tab_sl_pt.dose_min) &
//									 + " - " + string(kst_tab_sl_pt.dose_max) &
//									 + "   densita': " + trim(kst_tab_sl_pt.densita) &
//									 )
//			else
//				kilv_lv1.setitem(k_ctr, 10, "---")
//			end if
//
//			
//			if kst_tab_meca.clie_3 <> kst_tab_meca.clie_2 then
//				kilv_lv1.setitem(k_ctr, 11, &
//									 + "cliente: " + string(kst_tab_meca.clie_3, "#####") &
//									 + " " + trim(kst_tab_clienti.rag_soc_20) &
//									 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
//									 + " " + trim(kst_tab_clienti.rag_soc_10) &
//									 + "  bolla cliente: "  + trim(kst_tab_meca.num_bolla_in) &
//									 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") )
//			else
//				kilv_lv1.setitem(k_ctr, 11, &
//									 + "cliente: " + string(kst_tab_meca.clie_3, "#####") &
//									 + " " + trim(kst_tab_clienti.rag_soc_20) &
//									 + "  bolla cliente: "  + trim(kst_tab_meca.num_bolla_in) &
//									 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") )
//			end if
//			
////--- Leggo rec next dalla tree				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//
//		loop
//		
//	end if
// 
//	 
//	if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kilv_lv1.extendedselect = true 
//			
//	end if
//
//
// 
//return k_return
//
end function

public function integer u_stampa_barcode_dettaglio ();//
//--- Stampa dettaglio
//
integer k_return = 0, k_rc
string k_tipo_oggetto=" "
st_treeview_data kst_treeview_data
kuf_barcode_stampa kuf1_barcode_stampa

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()

	k_tipo_oggetto = trim(kst_treeview_data.oggetto)

//--- chiama le funzioni necessarie
		choose case lower(k_tipo_oggetto)
						  
			case kist_treeview_oggetto.barcode &
				 ,kist_treeview_oggetto.barcode_dett

				kuf1_barcode_stampa = create kuf_barcode_stampa
				
				kuf1_barcode_stampa.stampa_etichetta_riferimento_autorizza()
				
				if kuf1_barcode_stampa.ki_stampa_etichetta_autorizza then
					u_stampa_barcode ()
				end if
				destroy kuf1_barcode_stampa

			case else
				messagebox("Operazione non Eseguita", "Funzione richiesta non Abilitata")
							

		end choose


//	end if



return k_return
end function

public function st_esito u_select_tab_treeview_all ();//------------------------------------------------------------------------
//--- Legge tutta la tab treeview e la salva in un array 
//
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
int k_ctr=0, k_ctr1
string k_presenza_figli = "0"
st_esito kst_esito
st_tab_treeview kst_tab_treeview_nulla, kst_tab_treeview


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


   DECLARE kcursor_all CURSOR FOR  
	  SELECT treeview_prod.tipo_menu,   
				treeview_prod.id,   
				treeview_prod.presenza_figli,
				treeview_prod.descrizione_tipo,   
				treeview_prod.descrizione,   
				treeview_prod.livello,   
				treeview_prod.sequenza,   
				treeview_prod.tipo_voce,   
				treeview_prod.voce,   
				treeview_prod.id_padre as id_padre,   
				treeview_prod.funzione,   
				treeview_prod.pic_open,   
				treeview_prod.pic_close,   
				treeview_prod.pic_list,   
				treeview_prod.id_programma,  
				treeview_prod.open_programma,
				treeview_prod.nome_oggetto
		 FROM treeview_prod   
		 		using kguo_sqlca_db_magazzino;
	
//--- è già ordinata bene questo sort è inutile	
//		 where treeview_prod.tipo_menu = 'A'
//	ORDER BY treeview_prod.id_padre ASC   
//	              ,treeview_prod.livello ASC
//				,treeview_prod.sequenza ASC
//				,treeview_prod.voce ASC
//				using sqlca;

	open kcursor_all;
	if sqlca.sqlcode = 0 then
			
		fetch kcursor_all INTO 
				:kst_tab_treeview.tipo_menu,
				:kst_tab_treeview.id,   
				:k_presenza_figli,   
				:kst_tab_treeview.descrizione_tipo,   
				:kst_tab_treeview.descrizione,   
				:kst_tab_treeview.livello,   
				:kst_tab_treeview.sequenza,   
				:kst_tab_treeview.tipo_voce,   
				:kst_tab_treeview.voce,   
				:kst_tab_treeview.id_padre,   
				:kst_tab_treeview.funzione,   
				:kst_tab_treeview.pic_open,   
				:kst_tab_treeview.pic_close,   
				:kst_tab_treeview.pic_list,   
				:kst_tab_treeview.id_programma,
				:kst_tab_treeview.open_programma,
				:kst_tab_treeview.nome_oggetto ;

		
		do while sqlca.sqlcode = 0 and k_ctr < kki_tab_treeview_item_max 
		
			k_ctr++
			kist_tab_treeview[k_ctr] = kst_tab_treeview
			if isnull(kst_tab_treeview.id) then kist_tab_treeview[k_ctr].id = " " else kist_tab_treeview[k_ctr].id = lower(trim(kst_tab_treeview.id))
			if isnull(kst_tab_treeview.id_padre) then kist_tab_treeview[k_ctr].id_padre = " " else kist_tab_treeview[k_ctr].id_padre =  lower(trim(kst_tab_treeview.id_padre))
			if isnull(kst_tab_treeview.id_programma) then kist_tab_treeview[k_ctr].id_programma = " " else kist_tab_treeview[k_ctr].id_programma = lower(trim(kst_tab_treeview.id_programma))
			if isnull(kst_tab_treeview.open_programma) then kist_tab_treeview[k_ctr].open_programma = " " else kist_tab_treeview[k_ctr].open_programma = trim(kst_tab_treeview.open_programma)
			if isnull(kst_tab_treeview.funzione) then kist_tab_treeview[k_ctr].funzione = " " else kist_tab_treeview[k_ctr].funzione = lower(trim(kst_tab_treeview.funzione))
			if isnull(kst_tab_treeview.descrizione_tipo) then kist_tab_treeview[k_ctr].descrizione_tipo = " " else kist_tab_treeview[k_ctr].descrizione_tipo = lower(trim(kst_tab_treeview.descrizione_tipo))
			if isnull(kst_tab_treeview.descrizione) then kist_tab_treeview[k_ctr].descrizione = " " else kist_tab_treeview[k_ctr].descrizione = lower(trim(kst_tab_treeview.descrizione))
			if isnull(kst_tab_treeview.livello) then kist_tab_treeview[k_ctr].livello = " " else kist_tab_treeview[k_ctr].livello = lower(trim(kst_tab_treeview.livello))
			if isnull(kst_tab_treeview.sequenza) then kist_tab_treeview[k_ctr].sequenza = " " else kist_tab_treeview[k_ctr].sequenza = lower(trim(kst_tab_treeview.sequenza))
			if isnull(kst_tab_treeview.tipo_voce) then kist_tab_treeview[k_ctr].tipo_voce = " " else kist_tab_treeview[k_ctr].tipo_voce = lower(trim(kst_tab_treeview.tipo_voce))
			if isnull(kst_tab_treeview.voce) then kist_tab_treeview[k_ctr].voce = " " else kist_tab_treeview[k_ctr].voce = lower(trim(kst_tab_treeview.voce))
			if isnull(kst_tab_treeview.pic_open) then kist_tab_treeview[k_ctr].pic_open = 0 else kist_tab_treeview[k_ctr].pic_open = kst_tab_treeview.pic_open
			if isnull(kst_tab_treeview.pic_close) then kist_tab_treeview[k_ctr].pic_close = 0 else kist_tab_treeview[k_ctr].pic_close = kst_tab_treeview.pic_close
			if isnull(kst_tab_treeview.pic_list) then kist_tab_treeview[k_ctr].pic_list = 0 else kist_tab_treeview[k_ctr].pic_list = kst_tab_treeview.pic_list
			if isnull(kst_tab_treeview.nome_oggetto) then kist_tab_treeview[k_ctr].nome_oggetto = "" else kist_tab_treeview[k_ctr].nome_oggetto = lower(trim(kst_tab_treeview.nome_oggetto))
			
//--- verifico la presenza figli 
			k_ctr1=0
//			select distinct 1 into :k_ctr1 from treeview 
//				where id_padre = upper(trim(:kst_tab_treeview.id));
//			if k_ctr1=1 then
			if k_presenza_figli = "1" then
				kist_tab_treeview[k_ctr].presenza_figli = true
			else
				kist_tab_treeview[k_ctr].presenza_figli = false
			end if
			
			fetch kcursor_all INTO 
				:kst_tab_treeview.tipo_menu,
				:kst_tab_treeview.id,   
				:k_presenza_figli,   
				:kst_tab_treeview.descrizione_tipo,   
				:kst_tab_treeview.descrizione,   
				:kst_tab_treeview.livello,   
				:kst_tab_treeview.sequenza,   
				:kst_tab_treeview.tipo_voce,   
				:kst_tab_treeview.voce,   
				:kst_tab_treeview.id_padre,   
				:kst_tab_treeview.funzione,   
				:kst_tab_treeview.pic_open,   
				:kst_tab_treeview.pic_close,   
				:kst_tab_treeview.pic_list,   
				:kst_tab_treeview.id_programma,
				:kst_tab_treeview.open_programma,
				:kst_tab_treeview.nome_oggetto ;
				

		loop


	end if


	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Navigatore (Treeview): " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		if k_ctr = 0 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Navigatore (Treeview): nessuna voce presente in tabella! (u_select_tab_treeview_all)" 
		else
			if k_ctr >= kki_tab_treeview_item_max then
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Navigatore (Treeview): troppe voci presenti in tabella! (u_select_tab_treeview_all)" 
			end if
		end if
	end if
	
	close kcursor_all;
	

		
return kst_esito

end function

private function integer u_riempi_treeview_root (string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rec_letto=0;
string k_tipo_menu
string k_id_padre, k_tipo_oggetto_figlio
long k_handle_item = 0, k_handle_item_padre = 0
integer k_ctr, k_livello_prec, k_livello
boolean k_funzione_autorizzata=true
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview[100], kst_tab_treeview1
st_treeview_data_any kst_treeview_data_any, kst1_treeview_data_any


		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview1.id = k_tipo_oggetto
	u_select_tab_treeview(kst_tab_treeview1, "")
	k_tipo_oggetto_figlio = kst_tab_treeview1.funzione
	

//--- Acchiappo handle dell'item
	kst_treeview_data = u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle

//--- valorizzo la struttura tree 				
	if k_handle_item <= 0 then
		k_handle_item_padre = 0
		k_id_padre = " "
	else

//--- Ricavo i dati provenienti dal Padre e li passo al figlio
		k_handle_item_padre = k_handle_item
		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data
		kst1_treeview_data_any = kst_treeview_data.struttura

//		k_id_padre = upper(trim(kst_treeview_data.oggetto))
		k_id_padre = upper(k_tipo_oggetto)
		
	end if


//--- Se root espansa riaggiorno il tutto
	if not ktvi_treeviewitem.expanded or k_handle_item >= 0 then
	
//--- Imposta propieta' di default		 
		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_figlio, kist_treeview_oggetto)

//--- Cancello gli Item dalla tree prima di ripopolare, ma cancello anche il root
		u_delete_item_child(k_handle_item)

		k_rec_letto=0;
		
		try

//--- popola tabella da tabella Treeview
			u_select_tab_treeview_id_padre(k_id_padre, kst_tab_treeview[])
			
			k_rec_letto++
			k_livello_prec = integer(kst_tab_treeview[k_rec_letto].livello)
			do while kst_tab_treeview[k_rec_letto].id_padre <> "*FINE*" 

//--- utente autorizzato a questo ramo treeview?			
				if len(trim(kst_tab_treeview[k_rec_letto].id_programma)) > 0 then
					k_funzione_autorizzata = u_sicurezza(kst_tab_treeview[k_rec_letto])		
				else
					k_funzione_autorizzata = true
				end if

				if k_funzione_autorizzata then

					kst_treeview_data.label = trim(kst_tab_treeview[k_rec_letto].voce)
					kst_treeview_data.oggetto = trim(kst_tab_treeview[k_rec_letto].funzione)
					kst_treeview_data.oggetto_padre = trim(kst_tab_treeview[k_rec_letto].id)
					
					kst_treeview_data_any = kst1_treeview_data_any
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview[k_rec_letto]
					kst_treeview_data.struttura = kst_treeview_data_any
					
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	
//--- Preleva dall'archivio dati di conf della tree 
					kst_tab_treeview[k_rec_letto].id = trim(kst_tab_treeview[k_rec_letto].id)
					kst_esito = u_select_tab_treeview(kst_tab_treeview[k_rec_letto], "")
					if kst_esito.esito = kkg_esito.ok then
						ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview[k_rec_letto].pic_open
						ktvi_treeviewitem.pictureindex = kst_tab_treeview[k_rec_letto].pic_close
						kst_treeview_data.pic_list = kst_tab_treeview[k_rec_letto].pic_list
					end if
		
//--- per evitare di selezionare tutti gli item
					ktvi_treeviewitem.selected = false

//--- Inserimento Nuova riga 	
					if k_livello_prec <> integer(kst_tab_treeview[k_rec_letto].livello) then
						k_livello_prec = integer(kst_tab_treeview[k_rec_letto].livello)
						k_handle_item_padre = k_handle_item
					end if
//					ktvi_treeviewitem.children = true
					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)

//--- inserisco il handle di questa riga tra i dati del item
					kst_treeview_data.handle = k_handle_item
					ktvi_treeviewitem.data = kst_treeview_data
	
	
					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
					
				end if
					
				k_rec_letto++	
					
			loop
			
		catch (uo_exception kuo_exception)
			if kuo_exception.get_tipo( ) <> trim(kuo_exception.kk_st_uo_exception_tipo_not_fnd) then
				kuo_exception.messaggio_utente()
			end if
			
		end try


	end if



return k_return

end function

private function integer u_riempi_treeview_pl_barcode_mese (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_pl_barcode_tree kuf1_pl_barcode_tree

kuf1_pl_barcode_tree = create kuf_pl_barcode_tree

k_return = kuf1_pl_barcode_tree.u_tree_riempi_treeview_x_mese ( ki_this, k_tipo_oggetto )

destroy kuf1_pl_barcode_tree

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_pic_close, k_pic_open
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio, k_dataoggi_x
//date k_save_data_int, k_data_anno_precedente
//int k_mese, k_anno
//string k_mese_desc [13]
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//kuf_base kuf1_base
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (*), 
//         month(pl_barcode.data) as mese,   
//         year(pl_barcode.data) as anno   
//     FROM pl_barcode
//	  where pl_barcode.data > :k_data_anno_precedente
//		 group by  3, 2
//		 order by  3 desc, 2 desc;
//
////--- ricava la data da cui partire
//	kuf1_base = create kuf_base
//	k_dataoggi_x = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//	destroy kuf1_base
//	if isdate(k_dataoggi_x) then
//		k_data_anno_precedente = relativedate (date(k_dataoggi_x), -365)
//	else
//		k_data_anno_precedente = date(0)
//	end if
//
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
//
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.pictureindex = k_pic_close 
//			ktvi_treeviewitem.selectedpictureindex = k_pic_open 
//		end if
//
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
////		ktvi_treeviewitem.pictureindex = integer(kist_treeview_oggetto.barcode_pl_pic_close)
////		ktvi_treeviewitem.selectedpictureindex = integer(kist_treeview_oggetto.barcode_pl_pic_open)
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child( k_handle_item_padre)
//		
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			k_mese_desc[1] = "Gennaio"
//			k_mese_desc[2] = "Febbraio"
//			k_mese_desc[3] = "Marzo"
//			k_mese_desc[4] = "Aprile"
//			k_mese_desc[5] = "Maggio"
//			k_mese_desc[6] = "Giugno"
//			k_mese_desc[7] = "Luglio"
//			k_mese_desc[8] = "Agosto"
//			k_mese_desc[9] = "Settembre"
//			k_mese_desc[10] = "Ottobre"
//			k_mese_desc[11] = "Novembre"
//			k_mese_desc[12] = "Dicembre"
//			k_mese_desc[13] = "NON RILEVATO"
//			
//			
//			do while sqlca.sqlcode = 0
//	
//				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
//					k_mese = 13
//					kst_tab_pl_barcode.data = date(0)
//				else			
//					kst_tab_pl_barcode.data = date(k_anno,k_mese,01)
//				end if
//				
//				
//				
//				kst_treeview_data.label = &
//										  k_mese_desc[k_mese]  &
//										  + "  " &
//										  + string(k_anno) 
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
//				if kst_treeview_data_any.contati = 1 then
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  P.L. presente"
//				else
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  P.L. presenti"
//				end if
//				kst_tab_treeview.descrizione_tipo = "Piano di Lavorazione" 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				
//				kst_tab_pl_barcode.codice = 0
//				kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
////				kst_treeview_data.struttura = kst_tab_treeview
////				kst_treeview_data.struttura = kst_tab_pl_barcode
//
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			loop
//			
//			close kc_treeview;
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_sped (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_sped kuf1_sped

kuf1_sped = create kuf_sped


	choose case k_tipo_oggetto

			case kist_treeview_oggetto.sped_da_st_dett &
				,kist_treeview_oggetto.sped_da_ft_dett &
				,kist_treeview_oggetto.sped_clie_3_da_ft_dett &
				,kist_treeview_oggetto.sped_pagam_da_ft_dett &
				,kist_treeview_oggetto.sped_dett 

				k_return = kuf1_sped.u_tree_riempi_treeview(ki_this, k_tipo_oggetto )
				
			case kist_treeview_oggetto.sped_clie_3_da_ft 
				
				kuf1_sped.u_tree_riempi_treeview_x_clie_3(ki_this, k_tipo_oggetto )
				
			case kist_treeview_oggetto.sped_pagam_da_ft
				
				kuf1_sped.u_tree_riempi_treeview_x_pagam(ki_this, k_tipo_oggetto )
				
			case kist_treeview_oggetto.sped_anno_mese &
				,kist_treeview_oggetto.sped_stor_mese
				
				kuf1_sped.u_tree_riempi_treeview_x_mese(ki_this, k_tipo_oggetto )

	end choose


destroy kuf1_sped

return k_return

end function

private function integer u_riempi_listview_barcode (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_barcode_tree kuf1_barcode

kuf1_barcode = create kuf_barcode_tree

k_return = kuf1_barcode.u_tree_riempi_listview( ki_this, k_tipo_oggetto )

destroy kuf1_barcode

return k_return
end function

private function integer u_riempi_treeview_armo (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_treeview_righe_rifer( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return

end function

private function integer u_riempi_treeview_certif_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
//kuf_certif kuf1_certif

//kuf1_certif = create kuf_certif

k_return = kiuf_certif.u_tree_riempi_treeview ( ki_this, k_tipo_oggetto )

//destroy kuf1_certif

return k_return

end function

private function integer u_open_pl_barcode_testa (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0, k_handle_item_padre = 0
integer k_ctr
date k_save_data_int, k_data_bolla_in
long k_clie_1=0
string k_rag_soc_10 , k_label 
alignment k_align

treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_tab_pl_barcode kst_tab_pl_barcode
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_esito kst_esito
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window
kuf_pl_barcode kuf1_pl_barcode


//--- 
//--- ricavo il barcode e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
//			
//		case listview!
		if kilv_lv1.visible then
			k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
			end if
		end if
//		case treeview!
//			k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//			if k_rc > 0 then
//				kitv_tv1.getitem(k_rc, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data  
//			end if
//
//		case else
//			k_rc = 0
//			
//	end choose
//

//--- ricavo il barcode e richiamo la windows				
//	k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
	

		if k_rc > 0 then 
			ktvi_treeviewitem.data = kst_treeview_data 
		
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
			kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode
		else
			kst_tab_pl_barcode.codice = 0
		end if
		
		if kst_tab_pl_barcode.codice > 0 or k_modalita = kkg_flag_modalita.inserimento then

			choose case k_modalita
					
				case kkg_flag_modalita.anteprima
				
					if k_rc > 0 then 
	
						kuf1_pl_barcode = create kuf_pl_barcode
					
						kst_esito = kuf1_pl_barcode.anteprima ( kidw_1, kst_tab_pl_barcode )
					
						destroy kuf1_pl_barcode
						
					else
						k_return = 1
					end if	


				case kkg_flag_modalita.inserimento
				
	//=== Parametri : 
	//=== struttura st_open_w
					kst_open_w.id_programma = kkg_id_programma.pl_barcode
					kst_open_w.flag_primo_giro = "S"
					kst_open_w.flag_modalita= trim(k_modalita)
					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
					kst_open_w.flag_leggi_dw = " "
					kst_open_w.flag_cerca_in_lista = " "
					kst_open_w.key1 = trim(string(kst_tab_pl_barcode.codice))
					kst_open_w.key2 = " "
					kst_open_w.flag_where = " "
					
					//kuf1_menu_window = create kuf_menu_window 
					kGuf_menu_window.open_w_tabelle(kst_open_w)
					//destroy kuf1_menu_window
					
					
				case else
					k_return = 1
	
	
			end choose
		
		else
			k_return = 1
			if k_modalita <> kkg_flag_modalita.anteprima then
				messagebox("Piano di Lavoro", "Valore non disponibile. ")
			end if
			
		end if

//	else
//		k_return = 1
//	end if
 
 
return k_return

end function

private function integer u_open_anag (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0
integer k_ctr

st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_clienti kst_tab_clienti
st_esito kst_esito
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window


//--- 
//--- ricavo il barcode e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
//
//		case listview!
//--- piglio la riga selezionata	
		if kilv_lv1.visible then
			k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				ktvi_treeviewitem.data = kst_treeview_data 
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
			end if
		end if

//		case treeview!
//			k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//			if k_rc > 0 then
//				kitv_tv1.getitem(k_rc, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data  
//				kst_treeview_data_any = kst_treeview_data.struttura
////				kst_tab_meca = kst_treeview_data_any.st_tab_meca 
//				kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//				kst_tab_meca.num_int = kst_tab_clienti.num_inte
//				kst_tab_meca.data_int = kst_tab_clienti.data_int
//			end if
//
//		case else
//			k_rc = 0
//			
//	end choose

	if k_rc > 0 then		

		if kst_tab_clienti.codice > 0 or k_modalita = kkg_flag_modalita.inserimento then
//--- chiamare la window di elenco
//
			choose case k_modalita
					
				case kkg_flag_modalita.anteprima
				
					if not isvalid(kiuf_clienti) then kiuf_clienti = create kuf_clienti
				
					kidw_1.dataobject = ""
 					kst_esito = kiuf_clienti.anteprima ( kidw_1, kst_tab_clienti )
//					if kst_esito.esito <> "0" then
//						messagebox("Stampa Attestato", &
//									"Operazione non eseguita.~n~r" &
//									+ trim(kst_esito.sqlerrtext))
//									
//					end if
				
				
				case else
//=== Parametri : 
//=== struttura st_open_w
					kst_open_w.id_programma = kkg_id_programma.anag
					kst_open_w.flag_primo_giro = "S"
					kst_open_w.flag_modalita= k_modalita
					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
					kst_open_w.flag_leggi_dw = " "
					kst_open_w.flag_cerca_in_lista = " "
					kst_open_w.key1 = string(kst_tab_clienti.codice)
					kst_open_w.key2 = " "
					kst_open_w.flag_where = " "
					
					//kuf1_menu_window = create kuf_menu_window 
					kGuf_menu_window.open_w_tabelle(kst_open_w)
					//destroy kuf1_menu_window

			end choose

			
		else
			
			k_return = 1
//			messagebox("Accesso Anagrafica", "Valore non disponibile. ")
			
			
		end if

	else
		k_return = 1
	
	end if
 
 
return k_return

end function

private function integer u_open_riferimenti (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0
integer k_ctr
kuf_armo kuf1_armo
st_esito kst_esito

st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem

st_open_w kst_open_w


//--- 
//--- ricavo il barcode e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
			
//		case listview!

		if kilv_lv1.visible then
			k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				ktvi_treeviewitem.data = kst_treeview_data 
				kst_treeview_data_any = kst_treeview_data.struttura
			end if
		else
			k_rc = 0
		end if
		
//		case treeview!
//			k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//			if k_rc > 0 then
//				kitv_tv1.getitem(k_rc, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data  
//				kst_treeview_data_any = kst_treeview_data.struttura
////				kst_tab_meca = kst_treeview_data_any.st_tab_meca 
//				kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//				kst_tab_meca.num_int = kst_tab_clienti.num_inte
//				kst_tab_meca.data_int = kst_tab_clienti.data_int
//			end if

//		case else
//			k_rc = 0
//			
//	end choose


	if k_rc > 0 then		

		if kst_treeview_data_any.st_tab_meca.id > 0 or k_modalita = kkg_flag_modalita.inserimento then

			choose case k_modalita  

				case kkg_flag_modalita.anteprima
					kuf1_armo = create kuf_armo
					kst_esito = kuf1_armo.anteprima_testa ( kidw_1, kst_treeview_data_any.st_tab_meca )
					
				case kkg_flag_modalita.visualizzazione 
					kuf1_armo = create kuf_armo
					kst_open_w.flag_modalita = k_modalita
					kst_open_w.id_programma = kuf1_armo.get_id_programma( kst_open_w.flag_modalita ) 
					kst_open_w.key1 = string(kst_treeview_data_any.st_tab_meca.id)
					kuf1_armo.u_open(kst_open_w)					
					
				case kkg_flag_modalita.inserimento &
					    ,kkg_flag_modalita.modifica &
					    ,kkg_flag_modalita.cancellazione 
					kuf1_armo = create kuf_armo
					kst_open_w.flag_modalita = k_modalita
					kst_open_w.id_programma = kuf1_armo.get_id_programma( kst_open_w.flag_modalita ) 
					kst_open_w.key1 = string(kst_treeview_data_any.st_tab_meca.id)
					kuf1_armo.u_open(kst_open_w)					
					
				case kkg_flag_modalita.stampa   // stampa dei BARCODE del lotto
					k_return = u_open_barcode(k_modalita)
					
					
				case else
					
					
//--- chiamare la window 
//=== Parametri : 
//=== struttura st_open_w
//					kst_open_w.id_programma = kkg_id_programma.riferimenti
//					kst_open_w.flag_primo_giro = "S"
//					kst_open_w.flag_modalita = k_modalita
//					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
//					kst_open_w.flag_leggi_dw = "N"
//					kst_open_w.flag_cerca_in_lista = " "
//					kst_open_w.key1 = string(kst_treeview_data_any.st_tab_armo.num_armo, "0000000000")
//					kst_open_w.key2 = " "
//					kst_open_w.key3 = " "
//					kst_open_w.key4 = " "
//					kst_open_w.flag_where = " "
//					
//					kuf1_menu_window = create kuf_menu_window 
//					kGuf_menu_window.open_w_tabelle(kst_open_w)
//					//kuf1_menu_window = create kuf_menu_window
					
			end choose		
			
		else
			k_return = 1
//			messagebox("Accesso al Riferimento", "Valore non disponibile. ")
			
			
		end if
	else
		k_return = 1
	
	end if
 
 
return k_return

end function

private function integer u_open_barcode (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0, k_handle_item_padre = 0
integer k_ctr
date k_save_data_int, k_data_bolla_in
long k_clie_1=0
string k_rag_soc_10 , k_label 
alignment k_align

st_tab_barcode kst_tab_barcode
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_meca kst_tab_meca 
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
st_esito kst_esito
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem

st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window
kuf_barcode_tree kuf1_barcode
kuf_armo kuf1_armo



//--- 
//--- ricavo il barcode e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
			
//		case listview!
			if kilv_lv1.visible then
				k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
				if k_rc > 0 then 
					kst_treeview_data = klvi_listviewitem.data  
				end if
			else
				k_rc = 0
			end if

//		case treeview!
//			k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//			if k_rc > 0 then
//				kitv_tv1.getitem(k_rc, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data  
//			end if

//		case else
//			k_rc = 0
			
//	end choose

	if k_rc > 0 then		
		
		ktvi_treeviewitem.data = kst_treeview_data 
	
		kst_treeview_data_any = kst_treeview_data.struttura
	
		kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
		kst_tab_meca = kst_treeview_data_any.st_tab_meca 
		kst_tab_clienti = kst_treeview_data_any.st_tab_clienti 
		kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt 
		kst_tab_armo = kst_treeview_data_any.st_tab_armo 

		if len(trim(kst_tab_barcode.barcode)) > 0 or k_modalita = kkg_flag_modalita.inserimento &
		   or kst_tab_meca.id > 0 then

			choose case k_modalita  

				case kkg_flag_modalita.anteprima
					
				   if len(trim(kst_tab_barcode.barcode)) > 0 then
						kuf1_barcode = create kuf_barcode_tree
						kst_esito = kuf1_barcode.anteprima ( kidw_1, kst_tab_barcode )
						destroy kuf1_barcode
					else
				   	if kst_tab_meca.id > 0 then
							kuf1_armo = create kuf_armo
							kst_esito = kuf1_armo.anteprima_testa ( kidw_1, kst_tab_meca )
							destroy kuf1_armo
						end if
					end if

				case kkg_flag_modalita.stampa

					u_stampa_barcode_dettaglio()

				case else 

//--- chiamare la window 
//=== Parametri : 
//=== struttura st_open_w
					kst_open_w.id_programma = kkg_id_programma.barcode
					kst_open_w.flag_primo_giro = "S"
					kst_open_w.flag_modalita= k_modalita
					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
					kst_open_w.flag_leggi_dw = " "
					kst_open_w.flag_cerca_in_lista = " "
					kst_open_w.key1 = trim(kst_tab_barcode.barcode)
					kst_open_w.key2 = " "
					kst_open_w.flag_where = " "
					
					//kuf1_menu_window = create kuf_menu_window 
					kGuf_menu_window.open_w_tabelle(kst_open_w)
					//destroy kuf1_menu_window
					
			end choose
		
		else
			k_return = 1
			
//			messagebox("Dettaglio Codice a Barre", "Valore non disponibile. ")
			
			
		end if

	else
		k_return = 1
	
	end if
 
 
return k_return

end function

private function integer u_riempi_listview_certif_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
//kuf_certif kuf1_certif

//kuf1_certif = create kuf_certif

k_return = kiuf_certif.u_tree_riempi_listview( ki_this, k_tipo_oggetto )

//destroy kuf1_certif

return k_return
end function

public subroutine u_aggiorna_treeview ();//
long k_handle_item, k_handle_item_padre, k_handle_item_orig
string k_tipo_oggetto
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_treeview_data kst_treeview_data

 

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data_padre ()

	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 1 then
		
		k_handle_item_orig = k_handle_item
		
		kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

//--- cancello dalla Treeview tutto
		if k_handle_item > 1 then
			u_delete_item_child(k_handle_item)
		end if
		ktvi_treeviewitem.expanded = false
		
//--- cancello dalla listview tutto
		kilv_lv1.DeleteItems()
		

	end if
		
		
 		
end subroutine

private function integer u_riempi_treeview_certif_mese (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
//kuf_certif kuf1_certif

//kuf1_certif = create kuf_certif

choose case k_tipo_oggetto

	case kist_treeview_oggetto.certif_st_mese
		k_return = kiuf_certif.u_tree_riempi_treeview_x_mese ( ki_this, k_tipo_oggetto )

	case kist_treeview_oggetto.certif_st_giorno
		k_return = kiuf_certif.u_tree_riempi_treeview_x_giorno ( ki_this, k_tipo_oggetto )
		
	case else
		
end choose

//if isvalid(kuf1_certif) then destroy kuf1_certif

return k_return

end function

private function integer u_riempi_treeview_pl_barcode_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_pl_barcode_tree kuf1_pl_barcode_tree

kuf1_pl_barcode_tree = create kuf_pl_barcode_tree

k_return = kuf1_pl_barcode_tree.u_tree_riempi_treeview ( ki_this, k_tipo_oggetto )

destroy kuf1_pl_barcode_tree

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_anno, k_mese, k_pic_open, k_pic_close, k_pic_list
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
//string k_query_select, k_query_where, k_query_order
//date k_save_data_int, k_data_da, k_data_a 
//date k_data_0 = date(0)
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_barcode kst_tab_barcode
//st_tab_treeview kst_tab_treeview
//kuf_pl_barcode kuf1_pl_barcode
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- Ricavo il handle del Padre e il tipo Oggetto
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
////--- ricavo ANNO e MESE con cui fare la where
//		kst_treeview_data_any =	kst_treeview_data.struttura 
//		kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode
//		if kst_tab_pl_barcode.data > date(0) then
//			k_anno = year(kst_tab_pl_barcode.data)
//			k_mese = month(kst_tab_pl_barcode.data)
//			k_data_da = date(k_anno, k_mese, 01)
//			k_data_a = date(string(relativedate(k_data_da, 32), "yyyy/mm/") + "01")
//		else
//			k_anno = 0
//			k_mese = 0
//			k_data_da = date(0)
//		end if
//		
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_list
//		end if
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//
//		k_query_select = &
//			"SELECT " &
//         + "count (*), " &
//			+ "barcode.pl_barcode, " &
//			+ "pl_barcode.codice, " &
//			+ "pl_barcode.data, " &
//			+ "pl_barcode.stato, " &
//			+ "pl_barcode.priorita, " &
//			+ "pl_barcode.prima_del_barcode, " &
//			+ "pl_barcode.note_1, " &
//			+ "pl_barcode.note_2, " &
//			+ "pl_barcode.data_sosp, " &
//			+ "pl_barcode.data_chiuso, " &
//			+ "pl_barcode.path_file_pilota " &
//	      + "FROM pl_barcode LEFT OUTER JOIN barcode ON  " &
//	      + "pl_barcode.codice = barcode.pl_barcode " 
//
//		k_query_where = " "
//		if k_data_da > date(0) then
//			k_query_where = &
//					+ " where (pl_barcode.data >=  '"+ string(k_data_da) +"' and pl_barcode.data <  '"+ string(k_data_a) +"' ) and "
//		end if
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.pl_barcode_aperto_dett
//				k_query_where = k_query_where &
//				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.k_stato_aperto) + "' " &
//				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null) "
////					+ " (pl_barcode.data_chiuso <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_chiuso is null) " &
//
//					
//			case kist_treeview_oggetto.pl_barcode_chiuso_dett
//				k_query_where = k_query_where &
//				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.k_stato_chiuso) + "' " &
//				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null) " &
////		      	+ " pl_barcode.data_chiuso > '" + string(KKG.DATA_ZERO) + "'  " &
////				   + " and (pl_barcode.upd_data_fpilota <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.upd_data_fpilota is null)  " 
//					
//			case kist_treeview_oggetto.pl_barcode_gia_pilota_dett
//				k_query_where = k_query_where &
//				+ " pl_barcode.stato in ('" + trim(kuf1_pl_barcode.k_stato_inviato) + "' " &
//				+ ",  '" + trim(kuf1_pl_barcode.k_stato_consegnato) + "') " &
//				   + " and (pl_barcode.data_sosp <= '" + string(KKG.DATA_ZERO) + "' or  pl_barcode.data_sosp is null)  " 
////		         + " pl_barcode.upd_data_fpilota > '" + string(KKG.DATA_ZERO) + "'  "  &
//
//			case kist_treeview_oggetto.pl_barcode_respinto_dett
//				k_query_where = k_query_where &
//				+ " pl_barcode.stato = '" + trim(kuf1_pl_barcode.k_stato_respinto) + "' " 
//					
//			case kist_treeview_oggetto.pl_barcode_sospeso_dett
//				k_query_where = k_query_where &
//					+ "  pl_barcode.data_sosp > '" + string(KKG.DATA_ZERO) + "'  "
//					
//			case else
//					k_query_where = " "
//	
//		end choose
//
//		k_query_order = &
// 			   " group by " &
//				+ " barcode.pl_barcode, " &
//				+ " pl_barcode.codice, " &
//				+ " pl_barcode.data, " &
//				+ " pl_barcode.stato, " &
//				+ " pl_barcode.priorita, " &
//				+ " pl_barcode.prima_del_barcode, " &
//				+ " pl_barcode.note_1, " &
//				+ " pl_barcode.note_2, " &
//				+ " pl_barcode.data_sosp, " &
//				+ " pl_barcode.data_chiuso, " &
//				+ " pl_barcode.path_file_pilota " &
//				+ " order by " &
//				+ " pl_barcode.data desc, pl_barcode.codice "
//
//		 
////--- Composizione della Query	
//		if len(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if		
//			 
//
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.pl_barcode_aperto_dett &
//					,kist_treeview_oggetto.pl_barcode_chiuso_dett &
//			 		, kist_treeview_oggetto.pl_barcode_gia_pilota_dett &
//					,kist_treeview_oggetto.pl_barcode_respinto_dett &
//					,kist_treeview_oggetto.pl_barcode_sospeso_dett
//				open dynamic kc_treeview;
//					
//			case else
//				open dynamic kc_treeview;
//	
//		end choose
//		
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:kst_tab_barcode.pl_barcode
//					 ,:kst_tab_pl_barcode.codice
//					 ,:kst_tab_pl_barcode.data
//					 ,:kst_tab_pl_barcode.stato
//					 ,:kst_tab_pl_barcode.priorita
//					 ,:kst_tab_pl_barcode.prima_del_barcode
//					 ,:kst_tab_pl_barcode.note_1
//					 ,:kst_tab_pl_barcode.note_2
//					 ,:kst_tab_pl_barcode.data_sosp
//					 ,:kst_tab_pl_barcode.data_chiuso
//					 ,:kst_tab_pl_barcode.path_file_pilota
//					  ;
//
//			if isnull(kst_tab_barcode.pl_barcode) then
//				kst_treeview_data_any.contati = 0
//			end if
//			
//			do while sqlca.sqlcode = 0
//	
//				
//				kst_treeview_data.label = string(kst_tab_pl_barcode.data, "dd.mm.yyyy") &
//										  + "  cod. "  &
//										  + string(kst_tab_pl_barcode.codice, "#####") 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//				
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = trim(string(kst_tab_pl_barcode.codice, "####0"))
//			   if kst_treeview_data_any.contati = 0 then
//				   kst_tab_treeview.descrizione = "Nessun Barcode inserito"
//				else
//				   if kst_treeview_data_any.contati = 1 then
//				   	kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presente"
//					else
//					   kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presenti"
//					end if
//				end if
//				if isnull(kst_tab_pl_barcode.note_1) then
//					kst_tab_pl_barcode.note_1 = " " 
//				end if
//				if isnull(kst_tab_pl_barcode.note_2) then
//					kst_tab_pl_barcode.note_2 = " " 
//				end if
//				if isnull(kst_tab_pl_barcode.path_file_pilota) then
//					kst_tab_pl_barcode.path_file_pilota = " " 
//				else
//					kst_tab_pl_barcode.path_file_pilota = "File: " + trim(kst_tab_pl_barcode.path_file_pilota)
//				end if
//			   kst_tab_treeview.descrizione_ulteriore = trim(kst_tab_pl_barcode.note_1) + "  " &
//				                                       + trim(kst_tab_pl_barcode.note_2) + ". " &
//																	+ trim(kst_tab_pl_barcode.path_file_pilota) 
//
//				if kst_tab_pl_barcode.data_sosp > date(0) then
//					kst_tab_treeview.descrizione_tipo = "Sospeso, P.L. bloccato dall'operatore " 
//				else
//					choose case kst_tab_pl_barcode.stato
//						case kuf1_pl_barcode.k_stato_aperto
//							kst_tab_treeview.descrizione_tipo = "Aperto  "
//						case kuf1_pl_barcode.k_stato_chiuso
//							kst_tab_treeview.descrizione_tipo = "Chiuso  "
//						case kuf1_pl_barcode.k_stato_inviato
//							kst_tab_treeview.descrizione_tipo = "Inviato  "
//						case kuf1_pl_barcode.k_stato_consegnato
//							kst_tab_treeview.descrizione_tipo = "Consegnato  "
//						case kuf1_pl_barcode.k_stato_respinto
//							kst_tab_treeview.descrizione_tipo = "Respinto  "
//						case else
//							kst_tab_treeview.descrizione_tipo = "?????  "
//					end choose
//					choose case kst_tab_pl_barcode.priorita
//						case kuf1_pl_barcode.k_priorita_urgente
//							kst_tab_treeview.descrizione_tipo += " URGENTE (prima del barcode:" &
//										+ trim( kst_tab_pl_barcode.prima_del_barcode) + ") "
//						case kuf1_pl_barcode.k_priorita_prima_del_barcode
//							kst_tab_treeview.descrizione_tipo += " Prima del barcode:"&
//										+ trim( kst_tab_pl_barcode.prima_del_barcode) + " "
//						case kuf1_pl_barcode.k_priorita_alta
//							kst_tab_treeview.descrizione_tipo += " priorita' Alta "
//						case kuf1_pl_barcode.k_priorita_bassa
//							kst_tab_treeview.descrizione_tipo += " priorita' Bassa "
//					end choose
//					
//				end if
//				
//				kst_treeview_data.pic_list = k_pic_list
//					
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:kst_tab_barcode.pl_barcode
//					 ,:kst_tab_pl_barcode.codice
//					 ,:kst_tab_pl_barcode.data
//					 ,:kst_tab_pl_barcode.stato
//					 ,:kst_tab_pl_barcode.priorita
//					 ,:kst_tab_pl_barcode.prima_del_barcode
//					 ,:kst_tab_pl_barcode.note_1
//					 ,:kst_tab_pl_barcode.note_2
//					 ,:kst_tab_pl_barcode.data_sosp
//					 ,:kst_tab_pl_barcode.data_chiuso
//					 ,:kst_tab_pl_barcode.path_file_pilota
//					  ;
//	
//			loop
//			
//			close kc_treeview;
//		end if
//
//	end if 
// 
//return k_return
//
end function

private function integer u_riempi_treeview_meca_lav_mese_att (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo_tree

kuf1_armo_tree = create kuf_armo_tree

k_return = kuf1_armo_tree.u_tree_riempi_treeview_da_conv_x_mese ( ki_this, k_tipo_oggetto )

destroy kuf1_armo_tree

return k_return
////
////--- Visualizza Treeview 
////--- merce in attesa di Convalida Dosimetrica
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
//long k_totale
//integer k_ctr, k_pic_list
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
//date k_save_data_int
//int k_mese, k_anno, k_anno_old
//string k_mese_desc [0 to 13]
//boolean k_prima_volta
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_meca kst_tab_meca
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (distinct meca.id), 
//         month(meca.data_int) as mese,   
//         year(meca.data_int) as anno   
//     FROM meca inner join armo on meca.id = armo.id_meca 
//	            inner join artr on armo.id_armo = artr.id_armo 
//    WHERE meca.data_int >= '03.03.2004' 
//			 and (err_lav_ok = '0' or err_lav_ok is null)
//		 group by  3, 2
//		 order by  3 desc, 2 desc;
////			 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null)
//
//		 
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//			k_pic_list = kst_tab_treeview.pic_list 
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			k_mese_desc[0] = "[Completa]"
//			k_mese_desc[1] = "Gennaio"
//			k_mese_desc[2] = "Febbraio"
//			k_mese_desc[3] = "Marzo"
//			k_mese_desc[4] = "Aprile"
//			k_mese_desc[5] = "Maggio"
//			k_mese_desc[6] = "Giugno"
//			k_mese_desc[7] = "Luglio"
//			k_mese_desc[8] = "Agosto"
//			k_mese_desc[9] = "Settembre"
//			k_mese_desc[10] = "Ottobre"
//			k_mese_desc[11] = "Novembre"
//			k_mese_desc[12] = "Dicembre"
//			k_mese_desc[13] = "NON RILEVATO"
//
//			k_totale = 0
//			k_anno_old = 0
//			k_prima_volta = true
//			
////--- estrazione carichi vera e propria			
//			do while sqlca.sqlcode = 0
//	
//	
////--- a rottura di anno presenta la riga totale a inizio
//				if k_anno <> k_anno_old and not k_prima_volta then
//			
//					if k_totale > 0 then
//				
////--- Estrazione del primo Item, quello dei totali
//						ktvi_treeviewitem.selected = false
//						k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//						kst_treeview_data = ktvi_treeviewitem.data
//						kst_treeview_data_any = kst_treeview_data.struttura
//						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//						k_totale = 0
//						kst_treeview_data_any.st_tab_meca.num_int = k_anno_old
//						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//						kst_treeview_data.struttura = kst_treeview_data_any
//						ktvi_treeviewitem.data = kst_treeview_data
//						k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//					end if
//					k_prima_volta = false
//					
//					k_anno_old = k_anno // memorizzo l'anno x la rottura
//					
//					kst_treeview_data.label = k_mese_desc[0] &
//													  + "  " &
//													  + string(k_anno) 
//					kst_tab_treeview.voce = kst_treeview_data.label
//					kst_tab_treeview.id = "0"
//					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
//					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//					kst_treeview_data_any.st_tab_meca = kst_tab_meca
//					kst_treeview_data_any.st_tab_meca.data_int = date(0)
//					kst_treeview_data_any.st_tab_meca.num_int = k_anno
//					kst_treeview_data.struttura = kst_treeview_data_any
//					kst_treeview_data.handle = k_handle_item_padre
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//					k_handle_primo = k_handle_item
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//				end if
//	
//				k_totale = k_totale + kst_treeview_data_any.contati
//	
//				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
//					k_mese = 13
//					kst_tab_meca.data_int = date(k_anno,01,01)
//				else			
//					kst_tab_meca.data_int = date(k_anno,k_mese,01)
//				end if
//				
//				kst_treeview_data.label = &
//										  k_mese_desc[k_mese]  &
//										  + "  " &
//										  + string(k_anno) 
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
//				if kst_treeview_data_any.contati = 1 then
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carico presente"
//				else
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carichi presenti"
//				end if
//				kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//						                               + " in attesa di convalida dosimetrica "
//
//				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kst_treeview_data.handle = k_handle_item_padre
//				kst_treeview_data.pic_list = k_pic_list
//		
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//					into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			loop
//
////--- giro finale per totale anno
//			if k_totale > 0 then
//		
////--- Estrazione del primo Item, quello dei totali
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data
//				kst_treeview_data_any = kst_treeview_data.struttura
//				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//				k_totale = 0
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
//				ktvi_treeviewitem.data = kst_treeview_data
//				k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//			end if
//			
//			
//			close kc_treeview;
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_listview_artr_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_artr kuf1_artr

kuf1_artr = create kuf_artr

k_return = kuf1_artr.u_tree_riempi_listview( ki_this, k_tipo_oggetto )

destroy kuf1_artr

return k_return
////
////--- Visualizza Listview
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
//integer k_ctr, k_pictureindex
//string k_label, k_oggetto_corrente, k_oggetto_padre
//int k_ind
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_tab_treeview kst_tab_treeview
//st_treeview_data_any kst_treeview_data_any
//st_profilestring_ini kst_profilestring_ini
//kuf_armo kuf1_armo
//
//
//	
////--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//	
//	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
////--- item di ritorno di default
//		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//		
////--- prendo il item padre per settare il ritorno di default
//	k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//	if k_handle_item_padre > 0 then
//		k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	else
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//	end if
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_oggetto_padre = trim(kst_treeview_data.oggetto)
//
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//	klvi_listviewitem.data = kst_treeview_data
//	klvi_listviewitem.label = ".."
//	klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//	k_handle_item_rit = kilv_lv1.additem(klvi_listviewitem)
//		
//	if k_handle_item_corrente > 0 then
//
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//
////--- leggo il primo item dalla treeview per esporlo nella list
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//
//		kilv_lv1.DeleteColumns ( )
//		
////--- 
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//		if k_label <> "Attestato" then 
//
////=== Costruisce e Dimensiona le colonne all'interno della listview
//			kilv_lv1.DeleteColumns ( )
//			k_ind=1
//			k_campo[k_ind] = "Attestato"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Riferimento"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "bolla mandante"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Colli entrati/trattati (di cui in groupage) - lav.inizio-fine"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Ricevente"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Cliente"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Lavorazione"
//			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Dosimetria"
//			k_align[k_ind] = left!
////			k_ind++
////			k_campo[k_ind] = "Ulteriori Informazioni"
////			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "FINE"
//			k_align[k_ind] = left!
//			
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
// 
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//			loop
//
//		end if
////---
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//			kst_treeview_data_any = kst_treeview_data.struttura
//			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//
////--- imposto il pic corretto
//			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
//	
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.selected = false
//
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			
//			kst_tab_treeview.voce =  &
//									  string(kst_treeview_data_any.st_tab_artr.num_certif, "##,##0") + " " 
//			if kst_treeview_data_any.st_tab_artr.data_st > date(0) then
//				kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_treeview.voce) + "  " &
//									  + string(kst_treeview_data_any.st_tab_artr.data_st, "dd.mm.yy") + "  "
//			end if
//			kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//										  string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
//										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mm.yy") 
//			kilv_lv1.setitem(k_ctr, 2, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//										  string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd.mm.yy") &
//										  + " - " + trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) 
//			kilv_lv1.setitem(k_ctr, 3, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//										  string(kst_treeview_data_any.st_tab_armo.colli_2, "####0") &
//										  + " / " + string(kst_treeview_data_any.st_tab_artr.colli_trattati, "####0") &
//										  + " (" + string(kst_treeview_data_any.st_tab_artr.colli_groupage, "####0") + ")" 
//			if kst_treeview_data_any.st_tab_artr.data_in > date(0) then							  	
//				kst_tab_treeview.voce =  kst_tab_treeview.voce &
//										  + "   " + string(kst_treeview_data_any.st_tab_artr.data_in, "dd/mmm") 
//			end if
//			if kst_treeview_data_any.st_tab_artr.data_fin > date(0) then							  	
//				kst_tab_treeview.voce =  kst_tab_treeview.voce &
//										  + " - " + string(kst_treeview_data_any.st_tab_artr.data_fin, "dd/mmm")  
//			end if
//			kilv_lv1.setitem(k_ctr, 4, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//											  + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_11) &
//											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_2, "####0") &
//											  + ")  " 
//			kilv_lv1.setitem(k_ctr, 5, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =   trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) &
//											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
//											  + ") " 
////											  + " / " + string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") &
////											  + " " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) &
//			kilv_lv1.setitem(k_ctr, 6, trim(kst_tab_treeview.voce) )
//
//
//			kst_tab_treeview.voce = ""
//			if kst_treeview_data_any.st_tab_meca.data_lav_fin > date(0) then
//				if kst_treeview_data_any.st_tab_meca.err_lav_fin = kuf1_armo.ki_err_lav_fin_ko then
//					if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
//						kst_tab_treeview.voce = "stampa forzata! " 
//					else
//						kst_tab_treeview.voce = "con Anomalia! " 
//					end if
//				else
//					kst_tab_treeview.voce = "corretta "
//				end if
//			else
//				kst_tab_treeview.voce = "da Trattare " 
//			end if
//			kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_treeview.voce) )
//
//
//			kst_tab_treeview.voce = ""
//			if kst_treeview_data_any.st_tab_meca.dosim_data > date(0) then 
//				if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_ko_sbloc then
//					if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
//						kst_tab_treeview.voce = "stampa forzata! " 
//					else
//						kst_tab_treeview.voce = "con Anomalia! " 
//					end if
//				else
//					if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_ko_bloc then
//						if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
//							kst_tab_treeview.voce = "stampa forzata! "
//						else
//							kst_tab_treeview.voce = "da Sbloccare (anomalie)!  "
//						end if
//					else
//						if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_da_aut then
//							kst_tab_treeview.voce = kst_tab_treeview.voce + "fare Seconda Lettura "
//						else
//							if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_ko_da_aut then
//								kst_tab_treeview.voce = kst_tab_treeview.voce + "Prima Lettura con Anomalie"
//							else
//								if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_aut_ok then
//									kst_tab_treeview.voce = kst_tab_treeview.voce + "corretta "
//								else
//									kst_tab_treeview.voce = kst_tab_treeview.voce + "da Convalidare "
//								end if
//							end if
//						end if
//					end if
//				end if
//			else
//				kst_tab_treeview.voce = "da Convalidare  " 
//			end if
//			kilv_lv1.setitem(k_ctr, 8, trim(kst_tab_treeview.voce) )
//
//				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//			
//		loop
//		
//	end if
//
//	if k_handle_item_rit > 0 then
////		k_handle_item = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_rit)
////		if k_handle_item <= 0 then
////			k_handle_item = 1
////		end if
//		kst_treeview_data.handle_padre = k_handle_item_corrente
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto = k_oggetto_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//	end if
//
//return k_return
//
end function

public function st_treeview_data u_ricava_list_selected ();//
//--- ricavo l'item successivo all'ultimo indicato nella listview 
//
long k_rc=0
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 
listviewitem klvi_listviewitem 


		
//--- ricava prima riga selected
	k_rc = kilv_lv1.SelectedIndex()
	
	if k_rc > 0 then
		
		k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex(), 1, klvi_listviewitem) 
		
		if k_rc > 0 then 
		
			kst_treeview_data = klvi_listviewitem.data  
			
		end if
		
	end if
	
		

return kst_treeview_data

end function

private function integer u_open_certif (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0, k_riga=0
integer k_ctr
boolean k_certif_selected_eof 
//kuf_certif kuf1_certif
kuf_artr kuf1_artr
st_tab_certif kst_tab_certif[]
st_esito kst_esito
uo_d_certif_stampa kuo1_d_certif_stampa
uo_exception kuo_exception


kguo_exception.set_esito_reset()

st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem

st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window



//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- ricava la riga
	if kilv_lv1.visible then
		k_riga = kilv_lv1.SelectedIndex ( )
		if k_riga > 0 then 
			if kilv_lv1.getitem(k_riga, 1, klvi_listviewitem) > 0 then
				kst_treeview_data = klvi_listviewitem.data  
				ktvi_treeviewitem.data = kst_treeview_data 
				kst_treeview_data_any = kst_treeview_data.struttura
			end if
		end if
	else
		kst_treeview_data_any.st_tab_certif.num_certif = 0
		k_riga = 0
	end if
	
//--- 
//--- ricavo il barcode e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
//			
//		case listview!
//			k_riga = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
//			if k_riga > 0 then 
//				kst_treeview_data = klvi_listviewitem.data  
//				ktvi_treeviewitem.data = kst_treeview_data 
//////				kst_treeview_data_any = kst_treeview_data.struttura
//			end if
//
//
//		case else
//			k_riga = 0
//			
//	end choose
//
//
//	if k_riga > 0 then		

		if kst_treeview_data_any.st_tab_certif.num_certif > 0 or k_modalita = kkg_flag_modalita.inserimento then

			choose case k_modalita  

				case kkg_flag_modalita.anteprima

					if trim(kst_treeview_data_parent.oggetto) = kist_treeview_oggetto.certif_st_dett then
						//kuf_certif = create kuf_certif
						kst_esito = kiuf_certif.anteprima ( kidw_1, kst_treeview_data_any.st_tab_certif )
						//destroy kuf1_certif
					else
						kuf1_artr = create kuf_artr
						kst_esito = kuf1_artr.anteprima ( kidw_1, kst_treeview_data_any.st_tab_artr )
						destroy kuf1_artr
					end if
					

				case kkg_flag_modalita.stampa
						
					try
						
						//kuf1_certif = create kuf_certif
						kuo1_d_certif_stampa = create uo_d_certif_stampa 

						k_certif_selected_eof = false
						do while NOT k_certif_selected_eof
						
							k_certif_selected_eof = true
						
//							//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...) o RISTAMPA
//							if not kuo1_d_certif_stampa.set_attestato(kst_treeview_data_any.st_tab_certif) then
//								k_certif_selected_eof = true // forzo uscita ciclo
//								k_return = 1
//								kGuo_exception.set_esito_reset( )
//								kGuo_exception.messaggio_utente("Stampa non eseguita", "Fallita associazione form di stampa per l'Attestato: "+ string( kst_treeview_data_any.st_tab_certif))
//							else
			
//--- posso fare il certificato solo se sono sulla cartella giusta altrimenti solo ristampa
								if trim(kst_treeview_data_parent.oggetto) = kist_treeview_oggetto.certif_da_st_dett &
										or trim(kst_treeview_data_parent.oggetto) = kist_treeview_oggetto.certif_st_dett &
										or kuo1_d_certif_stampa.ki_flag_ristampa then
		
									kiuf_certif.ki_flag_stampa_di_test = false  // stampa VERA!
									
									kst_tab_certif[1] = kst_treeview_data_any.st_tab_certif
									
									if NOT kiuf_certif.stampa (kst_tab_certif[]) then  // STAMPA!!!
										
										k_return = 1
										kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
										kguo_exception.messaggio_utente("Stampa Attestato non eseguita", "Si è verificato un errore durante la Stampa dell'Attestato " + string( kst_treeview_data_any.st_tab_certif.num_certif ))
										
									else
					
//--- se NON sono in ristampa cancello la riga dall'elenco
										if not kuo1_d_certif_stampa.ki_flag_ristampa then

											kilv_lv1.deleteitem(k_riga)
													
											k_riga --
										else
											klvi_listviewitem.selected = false
											kilv_lv1.Setitem( k_riga, klvi_listviewitem)
										end if
										
										k_certif_selected_eof = false

									end if
								else
									k_certif_selected_eof = true // forzo uscita ciclo
									k_return = 1
									kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_non_eseguito)
									kguo_exception.messaggio_utente("Stampa Attestato non eseguita", "Da questo elenco non e' possibile stampare l'Attestato " + string( kst_treeview_data_any.st_tab_certif) +	"~n~r" + trim(kst_esito.sqlerrtext))
								
								end if
//							end if
						
//---Devo ancora cercare altre righe selezionate?
							if not k_certif_selected_eof then 
								k_certif_selected_eof = true
								k_riga = kilv_lv1.SelectedIndex ( )
								if k_riga > 0 then
									if kilv_lv1.getitem(k_riga, klvi_listviewitem)  > 0 then
										kst_treeview_data = klvi_listviewitem.data  
										ktvi_treeviewitem.data = kst_treeview_data 
										kst_treeview_data_any = kst_treeview_data.struttura
										k_certif_selected_eof = false
									end if
								end if
							end if
											
						
						loop
						
					catch(uo_exception kuo1_exception)
						k_return = 1
						kst_esito = kuo1_exception.get_st_esito()
						kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_non_eseguito)
						kguo_exception.setmessage( "Preparazione per Stampa Attestato Fallita. " +	"~n~r" + trim(kst_esito.sqlerrtext))
						kguo_exception.messaggio_utente( )

					finally
						//destroy kuf1_certif
						destroy kuo1_d_certif_stampa
						
					end try

					
					
				case kkg_flag_modalita.cancellazione
					
					if trim(kst_treeview_data_parent.oggetto) = kist_treeview_oggetto.certif_st_dett then

						try 
							//kuf1_certif = create kuf_certif
	
							k_certif_selected_eof = false
							do while NOT k_certif_selected_eof
							
								k_certif_selected_eof = false
	
								
								k_rc = 2 // il default iniziale
								kst_tab_certif[1].num_certif = kst_treeview_data_any.st_tab_certif.num_certif
								kst_tab_certif[1].data = kst_treeview_data_any.st_tab_certif.data
								kst_tab_certif[1].id = kst_treeview_data_any.st_tab_certif.id
								k_rc = messagebox("Cancella ATTESTATO", "Sei sicuro di voler ELIMINANE l'attestato n.  ~n~r" &
												+ string(kst_tab_certif[1].num_certif) + "  del  " + string(kst_tab_certif[1].data) +  "   id = " + string(kst_tab_certif[1].id) &
												+ "~n~rA operazione conclusa l'attestato sarà tra quelli da 'RISTAMPARE' ", Question!, yesnocancel!, k_rc)
												
								if k_rc = 1 then
									kst_esito = kiuf_certif.tb_delete(kst_tab_certif[1] ) 
						
									klvi_listviewitem.selected = false
									kilv_lv1.Setitem( k_riga, klvi_listviewitem)
										
									if kst_esito.esito = kkg_esito.ok then
	
										kilv_lv1.deleteitem(k_riga)
												
	//									k_riga --
									end if
	
								else
									if k_rc = 3 then
										k_certif_selected_eof = true // forzo uscita ciclo
									end if
								end if
	
	
	//---Devo ancora cercare altre righe selezionate?
								if not k_certif_selected_eof then 
									k_certif_selected_eof = true
									k_riga = kilv_lv1.SelectedIndex ( )
									if k_riga > 0 then
										if kilv_lv1.getitem(k_riga, klvi_listviewitem)  > 0 then
											kst_treeview_data = klvi_listviewitem.data  
											ktvi_treeviewitem.data = kst_treeview_data 
											kst_treeview_data_any = kst_treeview_data.struttura
											k_certif_selected_eof = false
										end if
									end if
								end if
												
							
							loop
						
						catch (uo_exception kuo2_exception)
							kuo2_exception.messaggio_utente()
							
						end try
						
					else
						
						k_return = 1
						messagebox("Operazione non eseguita", &
										"Da questo elenco non e' possibile cancellare gli Attestati.~n~r" &
										+ trim(kst_esito.sqlerrtext))
						
					end if
					
					
				case else
					
//--- chiamare la window 
//=== Parametri : 
//=== struttura st_open_w
					kst_open_w.id_programma = kkg_id_programma.attestati
					kst_open_w.flag_primo_giro = "S"
					kst_open_w.flag_modalita = k_modalita
					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
					kst_open_w.flag_leggi_dw = "N"
					kst_open_w.flag_cerca_in_lista = " "
					kst_open_w.key1 = string(kst_treeview_data_any.st_tab_certif.num_certif, "0000000000")
					kst_open_w.key2 = " "
					kst_open_w.key3 = " "
					kst_open_w.key4 = " "
					kst_open_w.flag_where = " "
					
					//kuf1_menu_window = create kuf_menu_window 
					kGuf_menu_window.open_w_tabelle(kst_open_w)
					//destroy kuf1_menu_window
					
			end choose		
			
		else
			k_return = 1
			
			if k_modalita <> kkg_flag_modalita.anteprima then
				messagebox("Accesso Attestato", "Valore non disponibile. ")
			end if
			
		end if

	
//	end if
 
 
return k_return

end function

private function integer u_riempi_treeview_artr_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_artr kuf1_artr

kuf1_artr = create kuf_artr

kuf1_artr.ki_data_certif_da_st_da = ki_data_certif_da_st_da
kuf1_artr.ki_data_certif_da_st_a = ki_data_certif_da_st_a

k_return = kuf1_artr.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )

destroy kuf1_artr

return k_return

end function

private function integer u_riempi_treeview_meca_mese (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo_tree

kuf1_armo_tree = create kuf_armo_tree

k_return = kuf1_armo_tree.u_tree_riempi_treeview_x_mese ( ki_this, k_tipo_oggetto )

destroy kuf1_armo_tree

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
//long k_totale
//integer k_ctr, k_pic_close, k_pic_open
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
//string k_dosim_stato=" "
//date k_save_data_int, k_data_da, k_data_a, k_dataoggi, k_data_meno365
//string k_dataoggix
//int k_mese, k_anno, k_anno_old
//string k_mese_desc [0 to 13]
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_meca kst_tab_meca
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//kuf_base kuf1_base
//kuf_armo kuf1_armo
//
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (meca.id), 
//         month(meca.data_int) as mese,   
//         year(meca.data_int) as anno   
//     FROM meca
//    WHERE 
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_anno_mese
//		  and meca.data_int between :k_data_da and :k_data_a)
//		 or
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_stor_mese
//		  and meca.data_int < :k_data_da )
//		or
//		 (meca.data_int > '01.01.2003'
//		 			 
//		  and (
//			 	 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_lav_mese_ko
//			     and  meca.err_lav_ok = :k_dosim_stato)
//			    or
//			    (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_lav_mese_ok
//			     and  meca.err_lav_ok = :k_dosim_stato)
//				)
//		 )
//		or
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.anag_dett_stor_mese
//		  and (meca.clie_1 = :kst_treeview_data_any.st_tab_clienti.codice
//		         or meca.clie_2 = :kst_treeview_data_any.st_tab_clienti.codice
//		         or meca.clie_3 = :kst_treeview_data_any.st_tab_clienti.codice)
//		  and meca.data_int < :k_data_meno365 )
//		or
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.anag_dett_anno_mese
//		  and (meca.clie_1 = :kst_treeview_data_any.st_tab_clienti.codice
//		         or meca.clie_2 = :kst_treeview_data_any.st_tab_clienti.codice
//		         or meca.clie_3 = :kst_treeview_data_any.st_tab_clienti.codice)
//		  and meca.data_int >= :k_data_meno365 )
//		 group by  3, 2
//		 order by  3 desc, 2 desc; 
//
////			     and dosim_assorb > 0 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null))
////		:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_mese
////		 or
//		 
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//	kst_treeview_data_any = kst_treeview_data.struttura
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
////			k_pic_open = kst_tab_treeview.pic_open
////			k_pic_close = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//		end if
////		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
////		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )
////		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
////		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		
//
////--- ricavo data oggi
//		kuf1_base = create kuf_base
//		k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//		destroy kuf1_base
//		if isdate(k_dataoggix) then
//			k_dataoggi = date(k_dataoggix)
//		else
//			k_dataoggi = today()
//		end if
////--- calcolo periodo
//		k_anno = year(k_dataoggi) - 1
//		k_mese = month(k_dataoggi)
//		k_data_da = date (k_anno, k_mese, 01) 
//		k_data_a = k_dataoggi 
////--- imposto lo stato della dosimetria da cercare
//		if k_tipo_oggetto_padre = kist_treeview_oggetto.meca_lav_mese_ko then
//			k_dosim_stato = kuf1_armo.ki_err_lav_ok_conv_ko_sbloc
//		else
//			if k_tipo_oggetto_padre = kist_treeview_oggetto.meca_lav_mese_ok then 
//			   k_dosim_stato = kuf1_armo.ki_err_lav_ok_conv_aut_ok
//			end if
//		end if
//
//		k_data_meno365 = relativedate(k_dataoggi, -365)
//
//		
////
//			 
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			k_mese_desc[0] = "[Completa]"
//			k_mese_desc[1] = "Gennaio"
//			k_mese_desc[2] = "Febbraio"
//			k_mese_desc[3] = "Marzo"
//			k_mese_desc[4] = "Aprile"
//			k_mese_desc[5] = "Maggio"
//			k_mese_desc[6] = "Giugno"
//			k_mese_desc[7] = "Luglio"
//			k_mese_desc[8] = "Agosto"
//			k_mese_desc[9] = "Settembre"
//			k_mese_desc[10] = "Ottobre"
//			k_mese_desc[11] = "Novembre"
//			k_mese_desc[12] = "Dicembre"
//			k_mese_desc[13] = "NON RILEVATO"
//
//			k_totale = 0
//			k_anno_old = 0
//			
////--- estrazione carichi vera e propria			
//			do while sqlca.sqlcode = 0
//	
//	
////--- a rottura di anno presenta la riga totale a inizio
//				if k_anno <> k_anno_old then
//			
//					if k_totale > 0 then
//				
////--- Estrazione del primo Item, quello dei totali
//						ktvi_treeviewitem.selected = false
//						k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//						kst_treeview_data = ktvi_treeviewitem.data
//						kst_treeview_data_any = kst_treeview_data.struttura
//						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//						k_totale = 0
//						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//						kst_treeview_data.struttura = kst_treeview_data_any
//						ktvi_treeviewitem.data = kst_treeview_data
//						k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//					end if
//					
//					k_anno_old = k_anno // memorizzo l'anno x la rottura
//					
//					kst_treeview_data.label = k_mese_desc[0] &
//													  + "  " &
//													  + string(k_anno) 
//					kst_tab_treeview.voce = kst_treeview_data.label
//					kst_tab_treeview.id = "0"
//					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
//					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//					kst_treeview_data_any.st_tab_meca = kst_tab_meca
//					kst_treeview_data_any.st_tab_meca.data_int = date(0)
//					kst_treeview_data_any.st_tab_meca.num_int = k_anno
//					kst_treeview_data.struttura = kst_treeview_data_any
//					kst_treeview_data.handle = k_handle_item_padre
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//					k_handle_primo = k_handle_item
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//				end if
//	
//				k_totale = k_totale + kst_treeview_data_any.contati
//	
//				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
//					k_mese = 13
//					kst_tab_meca.data_int = date(k_anno,01,01)
//				else			
//					kst_tab_meca.data_int = date(k_anno,k_mese,01)
//				end if
//				
//				kst_treeview_data.label = &
//										  k_mese_desc[k_mese]  &
//										  + "  " &
//										  + string(k_anno) 
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
//				if kst_treeview_data_any.contati = 1 then
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carico presente"
//				else
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carichi presenti"
//				end if
//				choose case k_tipo_oggetto_padre
////					case kist_treeview_oggetto.meca_mese
////						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) 
//					case kist_treeview_oggetto.meca_lav_mese_ok
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//						                               + " con convalida dosimetrica esitata "
//					case kist_treeview_oggetto.meca_lav_mese_ko
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//						                               + " con convalida dosimetrica fallita! "
//				end choose
//
//				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//					into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			loop
//
////--- giro finale per totale anno
//			if k_totale > 0 then
//		
////--- Estrazione del primo Item, quello dei totali
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data
//				kst_treeview_data_any = kst_treeview_data.struttura
//				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//				k_totale = 0
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
//				ktvi_treeviewitem.data = kst_treeview_data
//				k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//			end if
//			
//			close kc_treeview;
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_listview_barcode_gener (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_barcode_tree kuf1_barcode

kuf1_barcode = create kuf_barcode_tree

k_return = kuf1_barcode.u_tree_riempi_listview_x_rifer( ki_this, k_tipo_oggetto )

destroy kuf1_barcode

return k_return
////
////--- Visualizza Listview
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_nonno
//long k_handle_item_rit
//integer k_pictureindex, k_pic_list, k_ctr
//string k_label, k_stringa, k_tipo_oggetto_figlio, k_tipo_oggetto_padre, k_tipo_oggetto_nonno
//integer k_ind
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_treeview_data kst_treeview_data
//st_tab_barcode kst_tab_barcode
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_sl_pt kst_tab_sl_pt
//st_tab_armo kst_tab_armo
//st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_contratti kst_tab_contratti
//st_tab_treeview kst_tab_treeview
//st_treeview_data_any kst_treeview_data_any
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- ricavo il tipo oggetto 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//	
//	if k_handle_item_corrente > 0 then
//
////--- prendo il item padre per settare il ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//
//	end if
//		
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then	
//	
////--- item di ritorno di default
//		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		
//	end if
////--- ricavo il nonno	
//	if k_handle_item_padre > 0 then
//		k_handle_item_nonno = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//		k_rc = kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_tipo_oggetto_nonno = kst_treeview_data.oggetto
//	else
//		k_handle_item_nonno = 0
//		k_tipo_oggetto_nonno = "ROOT"
//	end if
//	
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//
//	if k_handle_item_padre > 0 then
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.handle_padre = k_handle_item_nonno
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		kst_treeview_data.oggetto = k_tipo_oggetto_nonno
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//		k_handle_item_rit = k_ctr
//	end if
//		
//	if k_handle_item_corrente > 0 then
//
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//
//		kst_treeview_data = ktvi_treeviewitem.data
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//
//
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//  		
////=== Costruisce e Dimensiona le colonne all'interno della listview
//		kilv_lv1.DeleteColumns ( )
//		k_ind=1
//		k_campo[k_ind] = "Riferimento"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Colli"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Stato barcode"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Dimensioni"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Dose"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Peso"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "F.1"
//		k_align[k_ind] = center!
//		k_ind++
//		k_campo[k_ind] = "F.2"
//		k_align[k_ind] = center!
//		k_ind++
//		k_campo[k_ind] = "Piano di Trattamento"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Ulteriori Informazion"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "FINE"
//		k_align[k_ind] = left!
//		
//		k_ind=1
//		do while trim(k_campo[k_ind]) <> "FINE"
//
//			kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//			kst_profilestring_ini.file = "treeview"
//			kst_profilestring_ini.titolo = "treeview"
//			kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//			kst_profilestring_ini.valore = "0"
//			k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//
//			if kst_profilestring_ini.esito = "0" then
//				k_ctr = integer(kst_profilestring_ini.valore)
//			end if
//			if k_ctr = 0 then
//				k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//			end if
//			kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//			k_ind++
//		loop
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			k_pic_list = kst_treeview_data.pic_list
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
//			kst_tab_meca = kst_treeview_data_any.st_tab_meca 
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti 
//			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt 
//			kst_tab_armo = kst_treeview_data_any.st_tab_armo 
//			kst_tab_contratti = kst_treeview_data_any.st_tab_contratti
//			kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode
//
//			klvi_listviewitem.pictureindex = k_pic_list
//
//			klvi_listviewitem.selected = false
//
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			if isnull(kst_tab_barcode.pl_barcode) then
//				kst_tab_barcode.pl_barcode = 0
//			end if
//			if isnull(kst_tab_pl_barcode.data) then
//				kst_tab_pl_barcode.data = date(0)
//			end if
//			if isnull(kst_tab_pl_barcode.note_1) then
//				kst_tab_pl_barcode.note_1 = " "
//			end if
//			if isnull(kst_tab_pl_barcode.note_2) then
//				kst_tab_pl_barcode.note_2 = " "
//			end if
//			if isnull(kst_tab_contratti.sc_cf) then
//				kst_tab_contratti.sc_cf = "NO   "
//			end if
//			if isnull(kst_tab_contratti.mc_co) then
//				kst_tab_contratti.mc_co = "NO   "
//			end if
//			if isnull(kst_tab_contratti.sc_cf) then
//				kst_tab_contratti.sc_cf = "NO   "
//			end if
//			if isnull(kst_tab_meca.clie_3) then
//				kst_tab_meca.clie_3 = 0
//			end if
//			if isnull(kst_tab_meca.clie_2) then
//				kst_tab_meca.clie_2 = 0
//			end if
//			if isnull(kst_tab_meca.clie_1) then
//				kst_tab_meca.clie_1 = 0
//			end if
//			if isnull(kst_tab_clienti.rag_soc_20) then
//				kst_tab_clienti.rag_soc_20 = " "
//			end if
//			if isnull(kst_tab_clienti.rag_soc_11) then
//				kst_tab_clienti.rag_soc_11 = " "
//			end if
//			if isnull(kst_tab_clienti.rag_soc_10) then
//				kst_tab_clienti.rag_soc_10 = " "
//			end if
//			if isnull(kst_tab_meca.num_bolla_in) then
//				kst_tab_meca.num_bolla_in = " "
//			end if
//			if isnull(kst_tab_meca.data_bolla_in) then
//				kst_tab_meca.data_bolla_in = date(0)
//			end if
//			if isnull(kst_tab_contratti.descr) then
//				kst_tab_contratti.descr = " "
//			end if
//			if isnull(kst_tab_sl_pt.fila_1) then
//				kst_tab_sl_pt.fila_1 = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_1p) then
//				kst_tab_sl_pt.fila_1p = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_2) then
//				kst_tab_sl_pt.fila_2 = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_2p) then
//				kst_tab_sl_pt.fila_2p = 0
//			end if
//
//			
//			kilv_lv1.setitem(k_ctr, 1, string(kst_tab_barcode.num_int, "####0") &
//								  + " - " + string(kst_tab_barcode.data_int, "dd.mm.yy"))
//								  
//			kilv_lv1.setitem(k_ctr, 2, string(kst_treeview_data_any.contati))
//				
//			if kst_tab_barcode.data_stampa > date(0) then
//				if kst_tab_barcode.pl_barcode > 0 then
//					kilv_lv1.setitem(k_ctr, 3, "p.l.:"  &
//										 + " " + string(kst_tab_barcode.pl_barcode, "####0") &
//										 + " del " + string(kst_tab_pl_barcode.data, "dd.mm.yy") &
//										 + " " + trim(kst_tab_pl_barcode.note_1) &
//										 + " " + trim(kst_tab_pl_barcode.note_2)) 
//				else
//					kilv_lv1.setitem(k_ctr, 3, "stampati")
//				end if
//			else
//				kilv_lv1.setitem(k_ctr, 3, "da stampare")
//			end if
//
//			kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.alt_2, "###0") &
//									+ "x" + string(kst_tab_armo.lung_2, "###0")  &
//									+ "x" + string(kst_tab_armo.larg_2, "###0"))
//			
//			kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.dose, "#,##0.00"))
//			kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.peso_kg, "##,##0.00"))
//			kilv_lv1.setitem(k_ctr, 7, string(kst_tab_sl_pt.fila_1, "##0") + " - " &
//			                          + string(kst_tab_sl_pt.fila_1p, "##0"))
//			kilv_lv1.setitem(k_ctr, 8, string(kst_tab_sl_pt.fila_2, "##0") + " - " &
//			                          + string(kst_tab_sl_pt.fila_2p, "##0"))
//			
//			if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
//				kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_sl_pt.cod_sl_pt) &
//									 + "  " + trim(kst_tab_sl_pt.descr))
//			else
//				kilv_lv1.setitem(k_ctr, 9, "---")
//			end if
//			
//			k_stringa =	"cap.: " + trim(kst_tab_contratti.sc_cf) &
//							+ "  comm.: " + trim(kst_tab_contratti.mc_co) &
//						   + "  cliente: " + string(kst_tab_meca.clie_3, "#####") &
// 						   + " " + trim(kst_tab_clienti.rag_soc_20) 
//	
//			if kst_tab_meca.clie_3 <> kst_tab_meca.clie_2 then
//				k_stringa =	k_stringa &
//							 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_11) 
//			end if							
//			if kst_tab_meca.clie_2 <> kst_tab_meca.clie_1 then
//				k_stringa =	k_stringa &
//							 + "  mand.: " + string(kst_tab_meca.clie_1, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_10) 
//			end if
//			k_stringa =	k_stringa &
//							 + "  bolla: "  + trim(kst_tab_meca.num_bolla_in) &
//							 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") &
//							 + "  contratto: " + string(kst_tab_contratti.codice, "#####") & 
//							 + "  " + trim(kst_tab_contratti.descr) 
//
//				
//			kilv_lv1.setitem(k_ctr, 10, trim(k_stringa))
//			
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//	
//		loop
//
//		 
//		if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//			kilv_lv1.DragAuto = True 
//					
////--- Attivo multi-selezione delle righe 
//			kilv_lv1.extendedselect = true 
//			
//		end if
//		
//	end if
//
//	if k_handle_item_rit > 0 then
//		kst_treeview_data.handle_padre = k_handle_item_corrente
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto = k_tipo_oggetto_nonno // k_oggetto_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//	end if
//
//
//
//return k_return
//
end function

private function integer u_riempi_treeview_barcode_data (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_barcode_tree kuf1_barcode

kuf1_barcode = create kuf_barcode_tree

k_return = kuf1_barcode.u_tree_riempi_treeview_x_data( ki_this, k_tipo_oggetto )


return k_return

end function

private function integer u_riempi_listview_root (string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit=0
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini


	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente <= 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kilv_lv1.DeleteItems()
		 
	if k_handle_item_padre > 0 then		 
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item_corrente > 0 then

		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		
		if k_handle_item > 0 then
			k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
			kst_treeview_data = ktvi_treeviewitem.data  
	
			kilv_lv1.DeleteColumns ( )
			
	//--- 
			kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
			if k_label <> "Nome" then 
			
	//=== Costruisce e Dimensiona le colonne all'interno della listview
				kilv_lv1.DeleteColumns ( )
				k_ind=1
				k_campo[k_ind] = "Nome"
				k_align[k_ind] = left!
				k_ind++
				k_campo[k_ind] = "Tipo"
				k_align[k_ind] = left!
				k_ind++
				k_campo[k_ind] = "Dati_Principali"
				k_align[k_ind] = left!
				k_ind++
				k_campo[k_ind] = "Ulteriori_Informazioni"
				k_align[k_ind] = left!
				k_ind++
				k_campo[k_ind] = "FINE"
				k_align[k_ind] = left!
				
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
						k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
					end if
					kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
					k_ind++
				loop
	
			end if
	//---
	
			do while k_handle_item > 0
					
				kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
		
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
	
				kst_treeview_data.oggetto_listview = k_tipo_oggetto
	
	//--- imposto il pic corretto
				klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
		
				klvi_listviewitem.label = kst_treeview_data.label
				klvi_listviewitem.data = kst_treeview_data
	
				klvi_listviewitem.selected = false
	
				k_ctr = kilv_lv1.additem(klvi_listviewitem)
				
				kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_treeview.voce) )
				kilv_lv1.setitem(k_ctr, 2, trim(kst_tab_treeview.descrizione_tipo) )
				kilv_lv1.setitem(k_ctr, 3, trim(kst_tab_treeview.descrizione) )
				kilv_lv1.setitem(k_ctr, 4, trim(kst_tab_treeview.descrizione_ulteriore) ) 
				
				k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
				
			loop
			
		end if
	
		if k_handle_item_rit > 0 then
			kst_treeview_data.handle_padre = k_handle_item_corrente
			kst_treeview_data.handle = k_handle_item_padre
			kst_treeview_data.oggetto = k_oggetto_padre
			kst_treeview_data.oggetto_listview = k_tipo_oggetto
			ktvi_treeviewitem.data = kst_treeview_data
			klvi_listviewitem.label = ".."
			klvi_listviewitem.data = kst_treeview_data
			klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
			kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
		end if
	end if
	
return k_return

end function

private function integer u_riempi_listview_meca_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_listview_smista ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return

end function

private function integer u_riempi_treeview_meca_barcode (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_barcode_tree kuf1_barcode

kuf1_barcode = create kuf_barcode_tree

k_return = kuf1_barcode.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )

destroy kuf1_barcode

return k_return

end function

private function integer u_riempi_treeview_meca_err_giri_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_treeview_err_giri ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_pic_list, k_mese, k_anno
//string k_tipo_oggetto_padre, k_dataoggix, k_tipo_oggetto_figlio
//string k_query_select, k_query_where, k_query_order
//date k_save_data_int, k_data_da, k_data_a, k_data_0
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
////st_tab_sl_pt kst_tab_sl_pt
//st_tab_armo kst_tab_armo
////st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_contratti kst_tab_contratti
//st_tab_certif kst_tab_certif
//st_tab_barcode kst_tab_barcode
//kuf_barcode kuf1_barcode
//kuf_armo kuf1_armo
//kuf_base kuf1_base
//
//
//
//
//	k_data_0 = date(0)		 
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//
//	k_data_a = date(0)
//	k_data_da = date(0)
//	
////--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
//	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
//		 then
//
////--- potrei avere salvato l'anno in num_int
//		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
//			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
//			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
//		else
//			
////--- Ricavo la data da dataoggi
//			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
//			if isnull(k_mese) or k_mese = 0 then
//				kuf1_base = create kuf_base
//				k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//				destroy kuf1_base
//				if isdate(k_dataoggix) then
//					kst_treeview_data_any.st_tab_meca.data_int = date(k_dataoggix)
//				else
//					kst_treeview_data_any.st_tab_meca.data_int = today()
//				end if
//			end if
//		end if
//	end if
//	
//	if k_data_da = date(0) then
//		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
//		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
//		k_data_da = date (k_anno, k_mese, 01) 
//		if k_mese = 12 then
//			k_mese = 1
//			k_anno ++
//		else
//			k_mese = k_mese + 1
//		end if
//		k_data_a = date (k_anno, k_mese, 01) 
//	
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//			k_pic_list = kst_tab_treeview.pic_list
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//
//	
//		k_query_select = &
//		"  	SELECT distinct " &
//		+ "	      meca.id, " &
//		+ "			meca.num_int, " &
//		+ "			meca.data_int, " &
//		+ "			meca.area_mag, " &
//		+ "         meca.clie_1,  " &
//		+ "         meca.clie_2,  " &
//		+ "         meca.clie_3,  " &
//		+ "			meca.num_bolla_in, " &
//		+ "			meca.data_bolla_in, " &
//		+ "         meca_dosim.dosim_data,   " & 
//		+ "         meca_dosim.dosim_dose,   " & 
//		+ "         meca.err_lav_ok,   " & 
//		+ "         meca.note_lav_ok,  " & 
//		+ "         meca_dosim.dosim_assorb,   " &
//		+ "         meca_dosim.dosim_spessore,   " &
//		+ "         meca_dosim.dosim_rapp_a_s,   " &
//		+ "         meca_dosim.dosim_lotto_dosim,   " &
//		+ "         meca.cert_forza_stampa,   " &
//		+ "			armo.magazzino, " &
//		+ "			meca.contratto, " &
//		+ "			contratti.mc_co, " &
//		+ "			contratti.sc_cf, " &
//		+ "			contratti.descr, " &
//		+ "			artr.num_certif, " &
//		+ "		   artr.data_st, " &
//		+ "         c1.rag_soc_10, " &
//		+ "         c2.rag_soc_10, " &
//		+ "         c3.rag_soc_10, " &
//		+ "         barcode.fila_1,   " &
//		+ "         barcode.fila_1p,   " &
//		+ "         barcode.fila_2,   " &
//		+ "         barcode.fila_2p,   " &
//		+ "         barcode.lav_fila_1,   " &
//		+ "         barcode.lav_fila_1p,   " &
//		+ "         barcode.lav_fila_2,   " &
//		+ "         barcode.lav_fila_2p,   " &
//		+ "			barcode.note_lav_fin, " &
//		+ "			barcode.err_lav_fin, " &
//		+ "			barcode.data_lav_fin " &
//		+ "    FROM  (((((((meca LEFT OUTER JOIN armo ON  " &
//		+ "	       meca.num_int = armo.num_int and meca.data_int = armo.data_int) " &
//		+ "                     inner join barcode on " &
//		+ "	       meca.id = barcode.id_meca) " &
//		+ "			 LEFT OUTER JOIN clienti c1 ON  " &
//		+ "			 meca.clie_1 = c1.codice) " &
//		+ "			 LEFT OUTER JOIN clienti c2 ON  " &
//		+ "			 meca.clie_2 = c2.codice) " &
//		+ "			 LEFT OUTER JOIN clienti c3 ON  " &
//		+ "			 meca.clie_3 = c3.codice) " &
//		+ "			 LEFT OUTER JOIN contratti ON  " &
//		+ "			 meca.contratto = contratti.codice) " &
//		+ "			 LEFT OUTER JOIN artr ON  " &
//		+ "			 armo.id_armo = artr.id_armo) " 
//		
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.meca_err_mese_giri_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '31.12.2003' "
//				if k_data_a  <> k_data_0 then
//					k_query_where = k_query_where &
//					+ " and (meca.data_int >= ? and meca.data_int < ?) "
//				end if
//				k_query_where = k_query_where &
//					+ " and barcode.err_lav_fin = '1' "
//					
//			case kist_treeview_oggetto.meca_err_mese_all_dett
//				k_query_where = " where " 
//				if k_data_a  <> k_data_0 then
//					k_query_where = k_query_where &
//					+ "  (meca.data_int >= ? and meca.data_int < ?) and "
//				end if
//				k_query_where = k_query_where &
//					+ "  (meca.err_lav_ok = '1' or " &
//					+ " ( meca.data_int > '31.12.2003' and meca.err_lav_fin = '1') )"
//					
//			case else
//					k_query_where = " "
//	
//		end choose
//	
//			
//		k_query_order = &
//		+ "	 order by " &
//		+ "		 meca.data_int, meca.num_int "
//	
////--- Composizione della Query	
//		if len(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if		
//		
//
//			 
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.meca_err_mese_giri_dett
//				if k_data_a  <> k_data_0 then
//					open dynamic kc_treeview using :k_data_da, :k_data_a;
//				else
//					open dynamic kc_treeview;
//				end if
//					
//			case kist_treeview_oggetto.meca_err_mese_all_dett
//				if k_data_a  <> k_data_0 then
//					open dynamic kc_treeview using :k_data_da, :k_data_a;
//				else
//					open dynamic kc_treeview;
//				end if
//	
//			case else
//				sqlca.sqlcode = 100
//	
//		end choose
//		
//		if sqlca.sqlcode = 0 then
//
//			kuf1_armo = create kuf_armo
//			kuf1_barcode = create kuf_barcode
//			
//			fetch kc_treeview 
//				into
//					 :kst_tab_meca.id   
//					 ,:kst_tab_meca.num_int   
//					 ,:kst_tab_meca.data_int   
//					 ,:kst_tab_meca.area_mag   
//					 ,:kst_tab_meca.clie_1  
//					 ,:kst_tab_meca.clie_2  
//					 ,:kst_tab_meca.clie_3  
//					 ,:kst_tab_meca.num_bolla_in 
//					 ,:kst_tab_meca.data_bolla_in 
//         		 ,:kst_tab_meca.dosim_data   
//					 ,:kst_tab_meca.dosim_dose
//         		 ,:kst_tab_meca.err_lav_ok   
//         		 ,:kst_tab_meca.note_lav_ok  
//         		 ,:kst_tab_meca.dosim_assorb  
//         		 ,:kst_tab_meca.dosim_spessore  
//         		 ,:kst_tab_meca.dosim_rapp_a_s  
//         		 ,:kst_tab_meca.dosim_lotto_dosim  
//         		 ,:kst_tab_meca.cert_forza_stampa  
//         		 ,:kst_tab_armo.magazzino  
//					 ,:kst_tab_contratti.codice
//					 ,:kst_tab_contratti.mc_co
//					 ,:kst_tab_contratti.sc_cf
//					 ,:kst_tab_contratti.descr
//					 ,:kst_tab_certif.num_certif
//					 ,:kst_tab_certif.data
//					 ,:kst_tab_clienti.rag_soc_10 
//					 ,:kst_tab_clienti.rag_soc_11 
//					 ,:kst_tab_clienti.rag_soc_20 
//        			 ,:kst_tab_barcode.fila_1  
//         		 ,:kst_tab_barcode.fila_1p   
//         		 ,:kst_tab_barcode.fila_2  
//         		 ,:kst_tab_barcode.fila_2p  
//         		 ,:kst_tab_barcode.lav_fila_1  
//         		 ,:kst_tab_barcode.lav_fila_1p  
//         		 ,:kst_tab_barcode.lav_fila_2  
//         		 ,:kst_tab_barcode.lav_fila_2p  
//					 ,:kst_tab_barcode.note_lav_fin
//					 ,:kst_tab_barcode.err_lav_fin
//					 ,:kst_tab_barcode.data_lav_fin
//					  ;
//	
////					 ,:kst_tab_barcode.data
//			
//			do while sqlca.sqlcode = 0
//	
//		  		if isnull(kst_tab_contratti.codice) then
//					kst_tab_contratti.codice = 0
//				end if
//			   if isnull(kst_tab_contratti.sc_cf) then
//					kst_tab_contratti.sc_cf = " "
//				end if
//	 		   if isnull(kst_tab_contratti.mc_co) then
//					kst_tab_contratti.mc_co = " "
//				end if
//		      if isnull(kst_tab_contratti.descr) then
//					kst_tab_contratti.descr = " "
//				end if
//				kuf1_armo.if_isnull_meca(kst_tab_meca)
//				kuf1_barcode.if_isnull(kst_tab_barcode)
//				
//				kst_tab_armo.num_int = kst_tab_meca.num_int
//				kst_tab_armo.data_int = kst_tab_meca.data_int
//				
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data_any.st_tab_armo = kst_tab_armo
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
//				kst_treeview_data_any.st_tab_certif = kst_tab_certif
//				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
//
//				kst_tab_treeview.voce =  &
//				                    string(kst_tab_meca.num_int, "####0") &
//				                    + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
//										  + " --> " + string(trim(kst_tab_meca.area_mag), "@@ @@@@@@@@@@")
//				kst_tab_treeview.descrizione_tipo = &
//					                 " Mag. " &
//				         		     + string(kst_tab_armo.magazzino)  
//
//				                               
//				if kst_tab_certif.num_certif > 0 then
//					kst_tab_treeview.descrizione_tipo = &
//					                 kst_tab_treeview.descrizione_tipo &
//					                 + " Cert. " &
//				                    + string(kst_tab_certif.num_certif, "####0") + " " &
//				                    + string(kst_tab_certif.data, "dd.mm.yy") + "  "
//				end if
//				kst_tab_treeview.descrizione_tipo = &
//                 					  kst_tab_treeview.descrizione_tipo & 
//										  + " Contr. " + string(kst_tab_contratti.codice, "####0") &
//										  + " SC-CF " + kst_tab_contratti.sc_cf &
//				                    + " MC-CO " + kst_tab_contratti.mc_co &
//										  + " " + trim(kst_tab_contratti.descr)
//
//				kst_tab_treeview.descrizione = "Da Trattare" 
//				if kst_tab_barcode.data_lav_fin > KKG.DATA_ZERO then
//					if kst_tab_barcode.err_lav_fin = "1" and kst_tab_meca.err_lav_ok = "1" then
//						kst_tab_treeview.descrizione = "Lavorazione e Dosimetria KO! " 
//					else
//						if kst_tab_barcode.err_lav_fin = "1" then
//							kst_tab_treeview.descrizione = "Lavorazione KO!  " 
//						else
//							kst_tab_treeview.descrizione = "Lavorazione OK  " 
//						end if
//					end if
//				else
//					kst_tab_treeview.descrizione = "Da Trattare  " 
//				end if
//					
//				if kst_tab_meca.dosim_data > KKG.DATA_ZERO then
//					if kst_tab_barcode.err_lav_fin = "1" and kst_tab_meca.err_lav_ok = "1" then
//					else
//						if kst_tab_meca.err_lav_fin = "1" then
//							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Dosimetria KO! " 
//						else
//							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Dosimetria OK " 
//						end if
//					end if
//				else
//					kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Da Convalidare " 
//				end if
//				
//				if kst_tab_barcode.data_lav_fin > date (0) then
//					if len(trim(kst_tab_barcode.note_lav_fin)) = 0 then
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  + " giri " 
//						if kst_tab_barcode.lav_fila_1 > 0 or kst_tab_barcode.lav_fila_1p > 0 then
//							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  + string(kst_tab_barcode.lav_fila_1, "##0") &
//												  + "+" + string(kst_tab_barcode.lav_fila_1p, "##0") 
//						end if
//						if kst_tab_barcode.lav_fila_2 > 0 or kst_tab_barcode.lav_fila_2p > 0 then
//							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  + string(kst_tab_barcode.lav_fila_2, "##0") &
//												  + "+" + string(kst_tab_barcode.lav_fila_2p, "##0") 
//						end if
//					else
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//											  + "  Note: " + trim(kst_tab_barcode.note_lav_fin) 
//					end if
//				end if
//				
//				if kst_tab_meca.dosim_data > date (0) then
//					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) + "   Dati dosim. " & 
//											  + " ass." + string(kst_tab_meca.dosim_assorb, "##,###") &
//											  + " / sp." + string(kst_tab_meca.dosim_spessore, "##,###") &
//											  + " = " + string(kst_tab_meca.dosim_rapp_a_s, "##,##0.00") &
//											  + " del " + string(kst_tab_meca.dosim_data, "dd.mm.yy") &
//											  + " lotto " + trim(kst_tab_meca.dosim_lotto_dosim) 
//					if kst_tab_meca.dosim_dose > 0 then
//						kst_tab_treeview.descrizione = kst_tab_treeview.descrizione &
//										+ "  Dose Irragg. " + string(kst_tab_meca.dosim_dose, "#0.00") + " "
//					end if
//					kst_tab_treeview.descrizione = kst_tab_treeview.descrizione &
//										+ "   Note: " + trim(kst_tab_meca.note_lav_ok) 
//				else
//					kst_tab_treeview.descrizione = "Da convalidare " 
//				end if
//				kst_tab_treeview.descrizione_ulteriore =  &
//				                    "Bolla cliente " + trim(kst_tab_meca.num_bolla_in) &
//				                    + " - " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") 
//										  
//				kst_tab_treeview.descrizione_ulteriore = &
//											  trim(kst_tab_treeview.descrizione_ulteriore) &
//				                       + "  Mand. " + string(kst_tab_meca.clie_1, "####0") &
//											  + " " + trim(kst_tab_clienti.rag_soc_10) &
//											  + " Ricev. " + string(kst_tab_meca.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_11) &
//											  + " Fatt. " + string(kst_tab_meca.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20)
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				kst_treeview_data.label = &
//				                      string(kst_tab_meca.num_int, "####0") &
//				                    + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
//										  + " "  &
//										  +  &
//										  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
//										  + string(kst_tab_meca.clie_3, "#####") + ")"
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//				kst_treeview_data.pic_list = k_pic_list
//		
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//				into
//					 :kst_tab_meca.id   
//					 ,:kst_tab_meca.num_int   
//					 ,:kst_tab_meca.data_int   
//					 ,:kst_tab_meca.area_mag   
//					 ,:kst_tab_meca.clie_1  
//					 ,:kst_tab_meca.clie_2  
//					 ,:kst_tab_meca.clie_3  
//					 ,:kst_tab_meca.num_bolla_in 
//					 ,:kst_tab_meca.data_bolla_in 
//         		 ,:kst_tab_meca.dosim_data   
//					 ,:kst_tab_meca.dosim_dose
//         		 ,:kst_tab_meca.err_lav_ok   
//         		 ,:kst_tab_meca.note_lav_ok  
//         		 ,:kst_tab_meca.dosim_assorb  
//         		 ,:kst_tab_meca.dosim_spessore  
//         		 ,:kst_tab_meca.dosim_rapp_a_s  
//         		 ,:kst_tab_meca.dosim_lotto_dosim  
//         		 ,:kst_tab_meca.cert_forza_stampa  
//         		 ,:kst_tab_armo.magazzino  
//					 ,:kst_tab_contratti.codice
//					 ,:kst_tab_contratti.mc_co
//					 ,:kst_tab_contratti.sc_cf
//					 ,:kst_tab_contratti.descr
//					 ,:kst_tab_certif.num_certif
//					 ,:kst_tab_certif.data
//					 ,:kst_tab_clienti.rag_soc_10 
//					 ,:kst_tab_clienti.rag_soc_11 
//					 ,:kst_tab_clienti.rag_soc_20 
//        			 ,:kst_tab_barcode.fila_1  
//         		 ,:kst_tab_barcode.fila_1p   
//         		 ,:kst_tab_barcode.fila_2  
//         		 ,:kst_tab_barcode.fila_2p  
//         		 ,:kst_tab_barcode.lav_fila_1  
//         		 ,:kst_tab_barcode.lav_fila_1p  
//         		 ,:kst_tab_barcode.lav_fila_2  
//         		 ,:kst_tab_barcode.lav_fila_2p  
//					 ,:kst_tab_barcode.note_lav_fin
//					 ,:kst_tab_barcode.err_lav_fin
//					 ,:kst_tab_barcode.data_lav_fin
//					 ;
//	
//			loop
//			
//			close kc_treeview;
//
//			destroy kuf1_armo
//			destroy kuf1_barcode
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_meca_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_treeview_smista ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return

end function

private function integer u_riempi_treeview_fatt_testa (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

k_return = kuf1_fatt.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )

destroy kuf1_fatt

return k_return
////
////--- Visualizza Treeview: Testata Fatture
////
//integer k_return = 0, k_rc
//long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
//integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
//string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
//string k_tipo_doc
//string k_query_select, k_query_where, k_query_order
//date k_data_da, k_data_a, k_data_0, k_dataoggi, k_data_meno3mesi
//int k_ind, k_ctr
//string k_campo[15], k_label
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_arfa kst_tab_arfa
//st_tab_clienti kst_tab_clienti
//st_tab_pagam kst_tab_pagam
//kuf_base kuf1_base
//kuf_fatt kuf1_fatt
//st_profilestring_ini kst_profilestring_ini
//
//
//
//
//	k_data_0 = date(0)		 
//
////--- data oggi
//	kuf1_base = create kuf_base
//	k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//	destroy kuf1_base
//	if isdate(k_dataoggix) then
//		k_dataoggi = date(k_dataoggix)
//	else
//		k_dataoggi = today()
//	end if
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//		 
////--- Ricavo il handle del Padre e il tipo Oggetto
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
////--- item di ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//
//	k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//
//
//	k_data_da = date(0)
//	k_data_a = date(0)
//	
////--- Periodo di estrazione, se la data e' a zero allora anno in DATAOGGI
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if kst_treeview_data_any.st_tab_arfa.data_fatt = date (0) then
//
////--- Ricavo la data da dataoggi
//		kst_treeview_data_any.st_tab_arfa.data_fatt = k_dataoggi
//		
//	end if
//	
//	if k_data_da = date(0) then
//		k_mese = month(kst_treeview_data_any.st_tab_arfa.data_fatt) 
//		k_anno = year(kst_treeview_data_any.st_tab_arfa.data_fatt)
//		k_data_da = date (k_anno, k_mese, 01) 
//		if k_mese = 12 then
//			k_mese = 1
//			k_anno ++
//		else
//			k_mese = k_mese + 1
//		end if
//		k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
//	end if
//		 
//	k_handle_item_nonno = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//
//	k_rc = kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
//		end if
//	
////--- data oggi -3 mesi
//		k_data_meno3mesi = relativedate(kg_dataoggi, -1190)
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//
//		ktvi_treeviewitem.selected = false
//
//		k_query_select = &
//		"  	SELECT " &
//		+ "	arfa.stampa, " &  
//		+ "	arfa.tipo_doc,  " & 
//		+ "	arfa.num_fatt, " &  
//		+ "	arfa.data_fatt, " &  
//		+ "	arfa.clie_3,  " & 
//		+ "	sum(arfa.colli),   " & 
//		+ "	sum(arfa.colli_out),   " & 
//		+ "	sum(arfa.prezzo_t),   " &    
//		+ "	arfa.cod_pag,   " &    
//		+ "	pagam.des,   " &    
//		+ "	c3.rag_soc_10	 " &   
//		+ "	FROM arfa "       &    
//		+ "		LEFT OUTER JOIN pagam ON  " &   
//		+ "	arfa.cod_pag = pagam.codice  " &   
//		+ "	  LEFT OUTER JOIN clienti c3 ON  " &   
//		+ "	arfa.clie_3 = c3.codice " 
//		
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.fattura_testa
//				k_query_where = " where " &
//					+ "  (arfa.data_fatt between  ? and ?) "
//					
//
//			case kist_treeview_oggetto.fattura_dett_da_st
//				k_query_where = " where " &
//					+ "  (arfa.data_fatt > ? " &
//					+ " and (arfa.stampa is null or arfa.stampa <> 'S')) "
//	
//			case else
//					k_query_where = " "
//	
//		end choose
//	
//		k_query_order = &
//		+ " group by " &
//		+ "	arfa.stampa, " &  
//		+ "	arfa.tipo_doc,  " & 
//		+ "	arfa.data_fatt, " &  
//		+ "	arfa.num_fatt, " &  
//		+ "	arfa.clie_3,  " & 
//		+ "	arfa.cod_pag,   " &    
//		+ "	pagam.des,   " &    
//		+ "	c3.rag_soc_10	 " &   
//		+ " order by " &
//		+ "	arfa.data_fatt, arfa.num_fatt "
//	
//	//--- Composizione della Query	
//		if len(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if		
//
//		 
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.fattura_testa
//				open dynamic kc_treeview using :k_data_da, :k_data_a;
//					
//	
//			case kist_treeview_oggetto.fattura_dett_da_st
//				open dynamic kc_treeview using :k_data_meno3mesi;
//
//			case else
//				sqlca.sqlcode = 100
//
//		end choose
//		
//		if sqlca.sqlcode = 0 then
//			
//			kuf1_fatt = create kuf_fatt
//			
//			fetch kc_treeview 
//				into
//					:kst_tab_arfa.stampa,   
//					:kst_tab_arfa.tipo_doc,   
//					:kst_tab_arfa.num_fatt,   
//					:kst_tab_arfa.data_fatt,   
//					:kst_tab_arfa.clie_3,   
//					:kst_tab_arfa.colli,   
//					:kst_tab_arfa.colli_out,   
//					:kst_tab_arfa.prezzo_t,   
//					:kst_tab_arfa.cod_pag,   
//					:kst_tab_pagam.des,   
//				   :kst_tab_clienti.rag_soc_10
//				  ;
//	
//			
//			do while sqlca.sqlcode = 0
//
//				
//				kst_treeview_data.handle = 0
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kuf1_fatt.if_isnull_testa(kst_tab_arfa)
//				choose case kst_tab_arfa.tipo_doc
//					case "FT"
//						k_tipo_doc = "Fattura"
//					case "NC"
//						k_tipo_doc = "Nota di Credito"
//					case else
//						k_tipo_doc = "?????????"
//				end choose
//				choose case kst_tab_arfa.stampa
//					case "S"
//						k_stato = "Stampata"
//					case " ", "N"
//						k_stato = "Da stampare"
//					case else
//						k_stato = "?????????"
//				end choose
//
//				if isnull(kst_tab_arfa.num_fatt) then		
//					kst_tab_arfa.num_fatt = 0
//				end if
//				if isnull(kst_tab_arfa.data_fatt) then		
//					kst_tab_arfa.data_fatt = date(0)
//				end if
//				if isnull(kst_tab_clienti.rag_soc_10) then		
//					kst_tab_clienti.rag_soc_10 = " "
//				end if
//				if isnull(kst_tab_clienti.rag_soc_20) then		
//					kst_tab_clienti.rag_soc_20 = " "
//				end if
//				
//				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
//				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				kst_treeview_data.label = &
//				                    string(kst_tab_arfa.num_fatt, "####0") &
//				                    + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy") &
//										  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
//										  + "  ("  &
//										  +  string(kst_tab_arfa.clie_3, "#####") + ") "
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//				kst_treeview_data.pic_list = kst_tab_treeview.pic_list
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//	
//				fetch kc_treeview 
//				into
//					:kst_tab_arfa.stampa,   
//					:kst_tab_arfa.tipo_doc,   
//					:kst_tab_arfa.num_fatt,   
//					:kst_tab_arfa.data_fatt,   
//					:kst_tab_arfa.clie_3,   
//					:kst_tab_arfa.colli,   
//					:kst_tab_arfa.colli_out,   
//					:kst_tab_arfa.prezzo_t,   
//					:kst_tab_arfa.cod_pag,   
//					:kst_tab_pagam.des,   
//				   :kst_tab_clienti.rag_soc_10
//					 ;
//	
//			loop
//			
//			close kc_treeview;
//			
//			destroy kuf1_fatt
//	
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_listview_fatt_testa (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

k_return = kuf1_fatt.u_tree_riempi_listview ( ki_this, k_tipo_oggetto )

destroy kuf1_fatt

return k_return
//// 
////
////--- Visualizza Listview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente
//integer k_ctr
//date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
//long k_clie_2=0
//string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre, k_tipo_doc, k_stato
//int k_ind, k_mese, k_anno
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_arfa kst_tab_arfa
//st_tab_armo kst_tab_armo
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_prodotti kst_tab_prodotti
//st_tab_pagam kst_tab_pagam
//st_tab_treeview kst_tab_treeview
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
////	kst_tab_treeview.id = k_tipo_oggetto
////	u_select_tab_treeview(kst_tab_treeview)
////	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item = kst_treeview_data.handle
//	
//	if k_handle_item > 0 then
//
////--- prendo il item padre per settare il ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//
//	end if
//		
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item = 0 or isnull(k_handle_item) then	
//	
////--- item di ritorno di default
//		k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		
//	end if
//
////--- item di ritorno di default
//	k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_tipo_oggetto_padre = kst_treeview_data.oggetto	
//
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//	if k_handle_item_padre > 0 then
//
//		kst_treeview_data.handle_padre = k_handle_item
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		kst_treeview_data.oggetto = k_tipo_oggetto_padre
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//	end if
//		
//	if k_handle_item > 0 then
//
//		kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//
//		kst_treeview_data = ktvi_treeviewitem.data
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//				 
//
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//					
//
////=== Costruisce e Dimensiona le colonne all'interno della listview
//		k_ind=1
//		k_campo[k_ind] = "Documento (Fatt/Nota-Cr.)"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Stato"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Colli fatt./usciti "
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Totale"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "codice"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Cliente"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Pagamento"
//		k_align[k_ind] = left!
//	//	k_ind++
//	//	k_campo[k_ind] = "Ulteriori Informazion"
//	//	k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "FINE"
//		k_align[k_ind] = left!
//			
//	
//		k_ind=3
//		kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
//		if trim(k_label) <> trim(k_campo[k_ind]) then 
//			kilv_lv1.DeleteColumns ( )
//	
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//	
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//			loop
//	
//		end if
//	
//	
////--- imposto il pic corretto
//		k_handle_item_corrente = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
////		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam
//
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
//			
//			klvi_listviewitem.selected = false
//			
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			choose case kst_tab_arfa.tipo_doc
//				case "FT"
//					k_tipo_doc = " "
//				case "NC"
//					k_tipo_doc = "Nota di Credito"
//				case else
//					k_tipo_doc = "?????????"
//			end choose
//			choose case kst_tab_arfa.stampa
//				case "S"
//					k_stato = "Stampata"
//				case " ", "N"
//					k_stato = "Da stampare"
//				case else
//					k_stato = "?????????"
//			end choose
//
//			k_ind=1
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_fatt, "####0") &
//									  + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy"))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(k_tipo_doc) &
//													+ "  " + trim(k_stato))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.colli, "##,##0") &
//										  + " / " + string(kst_tab_arfa.colli_out, "##,##0") &
//                                ) 
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.prezzo_t, "###,###,##0.00") )
//			
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_arfa.clie_3, "####0")))
//                                      
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
//			
//			
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.cod_pag , "  ####0")  &
//											  + "  " + trim(kst_tab_pagam.des))
//			
//			
////--- Leggo rec next dalla tree				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//
//		loop
//		
//	end if
// 
//	 
//	if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kilv_lv1.extendedselect = true 
//			
//	end if
//
//
// 
//return k_return
//
// 
// 
// 
//
//
end function

private function integer u_riempi_treeview_fatt_mese (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

k_return = kuf1_fatt.u_tree_riempi_treeview_x_mese( ki_this, k_tipo_oggetto )

destroy kuf1_fatt

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
//long k_totale
//integer k_ctr, k_pic_close, k_pic_open, k_pic_list
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio, k_dataoggix
//date k_data_da, k_data_a, k_dataoggi
//int k_mese, k_anno, k_anno_old
//string k_mese_desc [0 to 13]
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_arfa kst_tab_arfa
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//kuf_base kuf1_base
//
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (*), 
//         month(arfa.data_fatt) as mese,   
//         year(arfa.data_fatt) as anno   
//     FROM arfa
//    WHERE 
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.fattura_anno_mese
//		  and arfa.data_fatt between :k_data_da and :k_data_a)
//		 or
//		 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.fattura_stor_mese
//		  and arfa.data_fatt < :k_data_da )
//		 group by  3, 2
//		 order by  3 desc, 2 desc;
////		:k_tipo_oggetto_padre = :kist_treeview_oggetto.fattura_mese
////		 or
//
////			 and (
////			 	 (:k_tipo_oggetto_padre = :kist_treeview_oggetto.arfa_st_mese
////				  and arfa.data_fatt > '01.01.2003'
////			    )
////			 )
//
////			    or
////			    (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_lav_mese_ok
////			     and dosim_assorb > 0 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null)
////				)
//		 
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//			k_pic_list = kst_tab_treeview.pic_list
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		
//
////--- ricavo data oggi
//		kuf1_base = create kuf_base
//		k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//		destroy kuf1_base
//		if isdate(k_dataoggix) then
//			k_dataoggi = date(k_dataoggix)
//		else
//			k_dataoggi = today()
//		end if
////--- calcolo periodo
//		k_anno = year(k_dataoggi) - 1
//		k_mese = month(k_dataoggi)
//		k_data_da = date (k_anno, k_mese, 01) 
//		k_data_a = k_dataoggi 
////
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			k_mese_desc[0] = "[Completa]"
//			k_mese_desc[1] = "Gennaio"
//			k_mese_desc[2] = "Febbraio"
//			k_mese_desc[3] = "Marzo"
//			k_mese_desc[4] = "Aprile"
//			k_mese_desc[5] = "Maggio"
//			k_mese_desc[6] = "Giugno"
//			k_mese_desc[7] = "Luglio"
//			k_mese_desc[8] = "Agosto"
//			k_mese_desc[9] = "Settembre"
//			k_mese_desc[10] = "Ottobre"
//			k_mese_desc[11] = "Novembre"
//			k_mese_desc[12] = "Dicembre"
//			k_mese_desc[13] = "NON RILEVATO"
//
//			k_totale = 0
//			k_anno_old = 0
//			
////--- estrazione carichi vera e propria			
//			do while sqlca.sqlcode = 0
//	
//	
////--- a rottura di anno presenta la riga totale a inizio
//				if k_anno <> k_anno_old then
//			
//					if k_totale > 0 then
//				
////--- Estrazione del primo Item, quello dei totali
//						ktvi_treeviewitem.selected = false
//						k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//						kst_treeview_data = ktvi_treeviewitem.data
//						kst_treeview_data_any = kst_treeview_data.struttura
//						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//
////--- Aggiorno il primo Item con i totali
//						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
//						k_totale = 0
//			
////						kst_tab_arfa.data = date(k_anno_old,01,01)
//						kst_tab_arfa.data_fatt = date(k_anno_old,01,01)
//						
//						kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
//						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//						kst_treeview_data.struttura = kst_treeview_data_any
//						ktvi_treeviewitem.data = kst_treeview_data
//						
//						k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//					end if
//					
//					k_anno_old = k_anno // memorizzo l'anno x la rottura
//					
//					kst_treeview_data.label = k_mese_desc[0] &
//													  + "  " &
//													  + string(k_anno) 
//					kst_tab_treeview.voce = kst_treeview_data.label
//					kst_tab_treeview.id = "0"
//					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
//					kst_tab_treeview.descrizione_tipo = "Attestati " 
//					kst_treeview_data.pic_list = k_pic_list
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//					kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
//					kst_treeview_data.struttura = kst_treeview_data_any
//					kst_treeview_data.handle = k_handle_item_padre
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//					k_handle_primo = k_handle_item
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//				end if
//	
//				k_totale = k_totale + kst_treeview_data_any.contati
//	
//				
//				kst_treeview_data.label = &
//										  k_mese_desc[k_mese]  &
//										  + "  " &
//										  + string(k_anno) 
//	
////				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
////					k_mese = 13
////					kst_tab_arfa.data_fatt = date(k_anno,01,01)
////				else			
////					kst_tab_arfa.data = date(k_anno,k_mese,01)
////					k_mese++
////					if k_mese > 12 then
////						k_mese = 1
////						k_anno++
////					end if
//					kst_tab_arfa.data_fatt = date(k_anno, k_mese, 01)
////				end if
//
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
//				if kst_treeview_data_any.contati = 1 then
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Riga fattura presente"
//				else
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Righe fatture presenti"
//				end if
//
//				kst_tab_treeview.descrizione_tipo = "Attestati " 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//					into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			loop
//
////--- giro finale per totale anno
//			if k_totale > 0 then
//		
////--- Estrazione del primo Item, quello dei totali
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data
//				kst_treeview_data_any = kst_treeview_data.struttura
//				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
//				k_totale = 0
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
//				ktvi_treeviewitem.data = kst_treeview_data
//				k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//			end if
//			
//			close kc_treeview;
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_fatt_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

k_return = kuf1_fatt.u_tree_riempi_treeview_righe_fatt( ki_this, k_tipo_oggetto )

destroy kuf1_fatt

return k_return
////
////--- Visualizza Listview
////
//integer k_return = 0, k_rc
//long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
//integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
//string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
//string k_tipo_doc
//string k_query_select, k_query_where, k_query_order
//date k_data_da, k_data_a, k_data_0 
//int k_ind, k_ctr
//string k_campo[15], k_label
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_arfa kst_tab_arfa
//st_tab_armo kst_tab_armo
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_prodotti kst_tab_prodotti
//st_tab_pagam kst_tab_pagam
//kuf_base kuf1_base
//kuf_fatt kuf1_fatt
//st_profilestring_ini kst_profilestring_ini
//
//
//
//
//	k_data_0 = date(0)		 
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//		 
////--- Ricavo il handle del Padre e il tipo Oggetto
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
////--- item di ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//
////--- ricavo i dati dall'item PADRE su cui ho fatto click
//	k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	kst_treeview_data_any = kst_treeview_data.struttura
//	kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
//
////--- ricavo i dati dall'item NONNO ovvero il 'padre' su cui ho fatto click
//	k_handle_item_nonno = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//	k_rc = kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if kst_treeview_data_any.st_tab_arfa.id_armo > 0 then
//		kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
//	else
//		kst_tab_arfa.id_armo = kst_treeview_data_any.st_tab_armo.id_armo
//	end if
//	kst_tab_meca = kst_treeview_data_any.st_tab_meca
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
//		end if
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//
//		ktvi_treeviewitem.selected = false
//
//		k_query_select = &
//		"  	SELECT " &
//		+ "	arfa.stampa, " &  
//		+ "	arfa.tipo_doc,  " & 
//		+ "	arfa.num_fatt, " &  
//		+ "	arfa.data_fatt, " &  
//		+ "	arfa.clie_3,  " & 
//		+ "	arfa.num_bolla_out,  " & 
//		+ "	arfa.data_bolla_out,  " & 
//		+ "	arfa.tipo_riga,  " & 
//		+ "	arfa.id_armo,    " &
//		+ "	armo.art, " &
//		+ "	prodotti.des, " &
//		+ "	armo.id_meca, " &
//		+ "	armo.num_int, " &
//		+ "	armo.data_int, " &
//		+ "	arfa.colli,   " & 
//		+ "	arfa.colli_out,   " & 
//		+ "	arfa.peso_kg_out,   " & 
//		+ "	arfa.prezzo_u,  " &  
//		+ "	arfa.prezzo_t,   " &    
//		+ "	arfa.iva,   " &    
//		+ "	arfa.cod_pag,   " &    
//		+ "	pagam.des,   " &    
//		+ "	arfa.tipo_l,   " &   
//		+ "	c3.rag_soc_10	 " &   
//		+ "	FROM arfa INNER JOIN armo ON  " &   
//		+ "	arfa.id_armo = armo.id_armo  " &        
//		+ "		LEFT OUTER JOIN pagam ON  " &   
//		+ "	arfa.cod_pag = pagam.codice  " &   
//		+ "	  LEFT OUTER JOIN clienti c3 ON  " &   
//		+ "	arfa.clie_3 = c3.codice " &   
//		+ "	  LEFT OUTER JOIN prodotti ON  " &   
//		+ "	armo.art = prodotti.codice " 
//		
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.armo_tipo_ft_dett
//				k_query_where = " where " &
//					+ "  (arfa.id_armo = ? ) "
//					
//			case kist_treeview_oggetto.meca_car_ft_dett
//				k_query_where = " where " &
//					+ "  (armo.id_meca = ? ) "
//	
//			case kist_treeview_oggetto.fattura_dett
//				k_query_where = " where " &
//					+ "  (arfa.num_fatt = ? and arfa.data_fatt = ?) "
//	
//			case else
//					k_query_where = " "
//	
//		end choose
//	
//		k_query_order = &
//		+ "	order by " &
//		+ "	arfa.data_fatt, arfa.num_fatt, armo.art "
//	
//	
//	//--- Composizione della Query	
//		if len(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if		
//		 
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.armo_tipo_ft_dett
//				open dynamic kc_treeview using :kst_tab_arfa.id_armo;
//					
//			case kist_treeview_oggetto.meca_car_ft_dett
//				open dynamic kc_treeview using :kst_tab_meca.id;
//
//			case kist_treeview_oggetto.fattura_dett
//				open dynamic kc_treeview using :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
//				
//			case else
//				sqlca.sqlcode = 100
//
//		end choose
//		
//		if sqlca.sqlcode = 0 then
//			
//			kuf1_fatt = create kuf_fatt
//			
//			fetch kc_treeview 
//				into
//					:kst_tab_arfa.stampa,   
//					:kst_tab_arfa.tipo_doc,   
//					:kst_tab_arfa.num_fatt,   
//					:kst_tab_arfa.data_fatt,   
//					:kst_tab_arfa.clie_3,   
//					:kst_tab_arfa.num_bolla_out,   
//					:kst_tab_arfa.data_bolla_out,   
//					:kst_tab_arfa.tipo_riga,   
//					:kst_tab_arfa.id_armo,   
//					:kst_tab_armo.art,   
//					:kst_tab_prodotti.des,
//					:kst_tab_armo.id_meca,   
//					:kst_tab_armo.num_int,   
//					:kst_tab_armo.data_int,   
//					:kst_tab_arfa.colli,   
//					:kst_tab_arfa.colli_out,   
//					:kst_tab_arfa.peso_kg_out,   
//					:kst_tab_arfa.prezzo_u,   
//					:kst_tab_arfa.prezzo_t,   
//					:kst_tab_arfa.iva,   
//					:kst_tab_arfa.cod_pag,   
//					:kst_tab_pagam.des,   
//					:kst_tab_arfa.tipo_l,  
//				   :kst_tab_clienti.rag_soc_10
//				  ;
//	
//			
//			do while sqlca.sqlcode = 0
//
//				
//				kst_treeview_data.handle = 0
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kuf1_fatt.if_isnull_testa(kst_tab_arfa)
//				choose case kst_tab_arfa.tipo_doc
//					case "FT"
//						k_tipo_doc = "Fattura"
//					case "NC"
//						k_tipo_doc = "Nota di Credito"
//					case else
//						k_tipo_doc = "?????????"
//				end choose
//				choose case kst_tab_arfa.stampa
//					case "S"
//						k_stato = "Stampata"
//					case " ", "N"
//						k_stato = "Da stampare"
//					case else
//						k_stato = "?????????"
//				end choose
//
//				if isnull(kst_tab_armo.art) then		
//					kst_tab_armo.art = " "
//				end if
//				if isnull(kst_tab_prodotti.des) then
//					kst_tab_prodotti.des = " "
//				end if
//				if isnull(kst_tab_armo.id_meca) then		
//					kst_tab_armo.id_meca = 0
//				end if
//				if isnull(kst_tab_armo.num_int) then		
//					kst_tab_armo.num_int = 0
//				end if
//				if isnull(kst_tab_armo.data_int) then		
//					kst_tab_armo.data_int = date(0)
//				end if
//				if isnull(kst_tab_clienti.rag_soc_10) then		
//					kst_tab_clienti.rag_soc_10 = " "
//				end if
//				if isnull(kst_tab_clienti.rag_soc_20) then		
//					kst_tab_clienti.rag_soc_20 = " "
//				end if
//				
//				kst_tab_meca.id = kst_tab_armo.id_meca			
//				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
//				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
//				kst_treeview_data_any.st_tab_armo = kst_tab_armo
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				if  k_tipo_oggetto = kist_treeview_oggetto.fattura_dett then
//					kst_treeview_data.label = &
//				                    trim(kst_tab_armo.art) &
//				                    + " - " + trim(string(kst_tab_prodotti.des, "@@@@@@@@@@")) &
//										  + "   rif.:" + string(kst_tab_armo.num_int)
//				else
//					kst_treeview_data.label = &
//				                    string(kst_tab_arfa.num_fatt, "####0") &
//				                    + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy") &
//										  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
//										  + "  ("  &
//										  +  string(kst_tab_arfa.clie_3, "#####") + ") "
//				end if
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//				kst_treeview_data.pic_list = kst_tab_treeview.pic_list
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//	
//				fetch kc_treeview 
//				into
//					:kst_tab_arfa.stampa,   
//					:kst_tab_arfa.tipo_doc,   
//					:kst_tab_arfa.num_fatt,   
//					:kst_tab_arfa.data_fatt,   
//					:kst_tab_arfa.clie_3,   
//					:kst_tab_arfa.num_bolla_out,   
//					:kst_tab_arfa.data_bolla_out,   
//					:kst_tab_arfa.tipo_riga,   
//					:kst_tab_arfa.id_armo,   
//					:kst_tab_armo.art,   
//					:kst_tab_prodotti.des,
//					:kst_tab_armo.id_meca,   
//					:kst_tab_armo.num_int,   
//					:kst_tab_armo.data_int,   
//					:kst_tab_arfa.colli,   
//					:kst_tab_arfa.colli_out,   
//					:kst_tab_arfa.peso_kg_out,   
//					:kst_tab_arfa.prezzo_u,   
//					:kst_tab_arfa.prezzo_t,   
//					:kst_tab_arfa.iva,   
//					:kst_tab_arfa.cod_pag,   
//					:kst_tab_pagam.des,   
//					:kst_tab_arfa.tipo_l,  
//				   :kst_tab_clienti.rag_soc_10 
//					 ;
//	
//			loop
//			
//			close kc_treeview;
//			
//			destroy kuf1_fatt
//	
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_listview_fatt_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

k_return = kuf1_fatt.u_tree_riempi_listview_righe_fatt( ki_this, k_tipo_oggetto )

destroy kuf1_fatt

return k_return
////
////--- Visualizza Listview
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_nonno
//long k_handle_item_rit
//integer k_pictureindex, k_pic_list, k_ctr
//string k_label, k_stringa, k_tipo_oggetto_figlio, k_tipo_oggetto_padre, k_tipo_oggetto_nonno
//integer k_ind
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_treeview_data kst_treeview_data
//st_tab_barcode kst_tab_barcode
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_sl_pt kst_tab_sl_pt
//st_tab_armo kst_tab_armo
//st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_contratti kst_tab_contratti
//st_tab_treeview kst_tab_treeview
//st_treeview_data_any kst_treeview_data_any
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
////--- ricavo il tipo oggetto 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//	
//	if k_handle_item_corrente > 0 then
//
////--- prendo il item padre per settare il ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//
//	end if
//		
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then	
//	
////--- item di ritorno di default
//		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		
//	end if
////--- ricavo il nonno	
//	if k_handle_item_padre > 0 then
//		k_handle_item_nonno = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//		k_rc = kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_tipo_oggetto_nonno = kst_treeview_data.oggetto
//	else
//		k_handle_item_nonno = 0
//		k_tipo_oggetto_nonno = "ROOT"
//	end if
//	
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//
//	if k_handle_item_padre > 0 then
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.handle_padre = k_handle_item_nonno
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		kst_treeview_data.oggetto = k_tipo_oggetto_nonno
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//		k_handle_item_rit = k_ctr
//	end if
//		
//	if k_handle_item_corrente > 0 then
//
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//
//		kst_treeview_data = ktvi_treeviewitem.data
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//
//
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//  		
////=== Costruisce e Dimensiona le colonne all'interno della listview
//		kilv_lv1.DeleteColumns ( )
//		k_ind=1
//		k_campo[k_ind] = "Riferimento"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Colli"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Stato barcode"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Dimensioni"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Dose"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "Peso"
//		k_align[k_ind] = right!
//		k_ind++
//		k_campo[k_ind] = "F.1"
//		k_align[k_ind] = center!
//		k_ind++
//		k_campo[k_ind] = "F.2"
//		k_align[k_ind] = center!
//		k_ind++
//		k_campo[k_ind] = "Piano di Trattamento"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Ulteriori Informazion"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "FINE"
//		k_align[k_ind] = left!
//		
//		k_ind=1
//		do while trim(k_campo[k_ind]) <> "FINE"
//
//			kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//			kst_profilestring_ini.file = "treeview"
//			kst_profilestring_ini.titolo = "treeview"
//			kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//			kst_profilestring_ini.valore = "0"
//			k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//
//			if kst_profilestring_ini.esito = "0" then
//				k_ctr = integer(kst_profilestring_ini.valore)
//			end if
//			if k_ctr = 0 then
//				k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//			end if
//			kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//			k_ind++
//		loop
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			k_pic_list = kst_treeview_data.pic_list
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
//			kst_tab_meca = kst_treeview_data_any.st_tab_meca 
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti 
//			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt 
//			kst_tab_armo = kst_treeview_data_any.st_tab_armo 
//			kst_tab_contratti = kst_treeview_data_any.st_tab_contratti
//			kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode
//
//			klvi_listviewitem.pictureindex = k_pic_list
//
//			klvi_listviewitem.selected = false
//
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			if isnull(kst_tab_barcode.pl_barcode) then
//				kst_tab_barcode.pl_barcode = 0
//			end if
//			if isnull(kst_tab_pl_barcode.data) then
//				kst_tab_pl_barcode.data = date(0)
//			end if
//			if isnull(kst_tab_pl_barcode.note_1) then
//				kst_tab_pl_barcode.note_1 = " "
//			end if
//			if isnull(kst_tab_pl_barcode.note_2) then
//				kst_tab_pl_barcode.note_2 = " "
//			end if
//			if isnull(kst_tab_contratti.sc_cf) then
//				kst_tab_contratti.sc_cf = "NO   "
//			end if
//			if isnull(kst_tab_contratti.mc_co) then
//				kst_tab_contratti.mc_co = "NO   "
//			end if
//			if isnull(kst_tab_contratti.sc_cf) then
//				kst_tab_contratti.sc_cf = "NO   "
//			end if
//			if isnull(kst_tab_meca.clie_3) then
//				kst_tab_meca.clie_3 = 0
//			end if
//			if isnull(kst_tab_meca.clie_2) then
//				kst_tab_meca.clie_2 = 0
//			end if
//			if isnull(kst_tab_meca.clie_1) then
//				kst_tab_meca.clie_1 = 0
//			end if
//			if isnull(kst_tab_clienti.rag_soc_20) then
//				kst_tab_clienti.rag_soc_20 = " "
//			end if
//			if isnull(kst_tab_clienti.rag_soc_11) then
//				kst_tab_clienti.rag_soc_11 = " "
//			end if
//			if isnull(kst_tab_clienti.rag_soc_10) then
//				kst_tab_clienti.rag_soc_10 = " "
//			end if
//			if isnull(kst_tab_meca.num_bolla_in) then
//				kst_tab_meca.num_bolla_in = " "
//			end if
//			if isnull(kst_tab_meca.data_bolla_in) then
//				kst_tab_meca.data_bolla_in = date(0)
//			end if
//			if isnull(kst_tab_contratti.descr) then
//				kst_tab_contratti.descr = " "
//			end if
//			if isnull(kst_tab_sl_pt.fila_1) then
//				kst_tab_sl_pt.fila_1 = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_1p) then
//				kst_tab_sl_pt.fila_1p = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_2) then
//				kst_tab_sl_pt.fila_2 = 0
//			end if
//			if isnull(kst_tab_sl_pt.fila_2p) then
//				kst_tab_sl_pt.fila_2p = 0
//			end if
//
//			
//			kilv_lv1.setitem(k_ctr, 1, string(kst_tab_barcode.num_int, "####0") &
//								  + " - " + string(kst_tab_barcode.data_int, "dd.mm.yy"))
//								  
//			kilv_lv1.setitem(k_ctr, 2, string(kst_treeview_data_any.contati))
//				
//			if kst_tab_barcode.data_stampa > date(0) then
//				if kst_tab_barcode.pl_barcode > 0 then
//					kilv_lv1.setitem(k_ctr, 3, "p.l.:"  &
//										 + " " + string(kst_tab_barcode.pl_barcode, "####0") &
//										 + " del " + string(kst_tab_pl_barcode.data, "dd.mm.yy") &
//										 + " " + trim(kst_tab_pl_barcode.note_1) &
//										 + " " + trim(kst_tab_pl_barcode.note_2)) 
//				else
//					kilv_lv1.setitem(k_ctr, 3, "stampati")
//				end if
//			else
//				kilv_lv1.setitem(k_ctr, 3, "da stampare")
//			end if
//
//			kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.alt_2, "###0") &
//									+ "x" + string(kst_tab_armo.lung_2, "###0")  &
//									+ "x" + string(kst_tab_armo.larg_2, "###0"))
//			
//			kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.dose, "#,##0.00"))
//			kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.peso_kg, "##,##0.00"))
//			kilv_lv1.setitem(k_ctr, 7, string(kst_tab_sl_pt.fila_1, "##0") + " - " &
//			                          + string(kst_tab_sl_pt.fila_1p, "##0"))
//			kilv_lv1.setitem(k_ctr, 8, string(kst_tab_sl_pt.fila_2, "##0") + " - " &
//			                          + string(kst_tab_sl_pt.fila_2p, "##0"))
//			
//			if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
//				kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_sl_pt.cod_sl_pt) &
//									 + "  " + trim(kst_tab_sl_pt.descr))
//			else
//				kilv_lv1.setitem(k_ctr, 9, "---")
//			end if
//			
//			k_stringa =	"cap.: " + trim(kst_tab_contratti.sc_cf) &
//							+ "  comm.: " + trim(kst_tab_contratti.mc_co) &
//						   + "  cliente: " + string(kst_tab_meca.clie_3, "#####") &
// 						   + " " + trim(kst_tab_clienti.rag_soc_20) 
//	
//			if kst_tab_meca.clie_3 <> kst_tab_meca.clie_2 then
//				k_stringa =	k_stringa &
//							 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_11) 
//			end if							
//			if kst_tab_meca.clie_2 <> kst_tab_meca.clie_1 then
//				k_stringa =	k_stringa &
//							 + "  mand.: " + string(kst_tab_meca.clie_1, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_10) 
//			end if
//			k_stringa =	k_stringa &
//							 + "  bolla: "  + trim(kst_tab_meca.num_bolla_in) &
//							 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") &
//							 + "  contratto: " + string(kst_tab_contratti.codice, "#####") & 
//							 + "  " + trim(kst_tab_contratti.descr) 
//
//				
//			kilv_lv1.setitem(k_ctr, 10, trim(k_stringa))
//			
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//	
//		loop
//
//		 
//		if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//			kilv_lv1.DragAuto = True 
//					
////--- Attivo multi-selezione delle righe 
//			kilv_lv1.extendedselect = true 
//			
//		end if
//		
//	end if
//
//	if k_handle_item_rit > 0 then
//		kst_treeview_data.handle_padre = k_handle_item_corrente
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto = k_tipo_oggetto_nonno // k_oggetto_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//	end if
//
//
//
//return k_return
////// 
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente
//integer k_ctr
//date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
//long k_clie_2=0
//string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre, k_tipo_doc, k_stato
//int k_ind, k_mese, k_anno
//string k_campo[15]
//alignment k_align[15]
//alignment k_align_1
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_arfa kst_tab_arfa
//st_tab_armo kst_tab_armo
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
//st_tab_prodotti kst_tab_prodotti
//st_tab_pagam kst_tab_pagam
//st_tab_treeview kst_tab_treeview
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_profilestring_ini kst_profilestring_ini
//
//
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
////	kst_tab_treeview.id = k_tipo_oggetto
////	u_select_tab_treeview(kst_tab_treeview)
////	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item = kst_treeview_data.handle
//	
//	if k_handle_item > 0 then
//
////--- prendo il item padre per settare il ritorno di default
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//
//	end if
//		
////--- .... altrimenti lo ricavo dalla tree
//	if k_handle_item = 0 or isnull(k_handle_item) then	
//	
////--- item di ritorno di default
//		k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
//		k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		
//	end if
//
////--- item di ritorno di default
//	k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_tipo_oggetto_padre = kst_treeview_data.oggetto	
//
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//	if k_handle_item_padre > 0 then
//
//		kst_treeview_data.handle_padre = k_handle_item
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		kst_treeview_data.oggetto = k_tipo_oggetto_padre
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_ctr = kilv_lv1.additem(klvi_listviewitem)
//	end if
//		
//	if k_handle_item > 0 then
//
//		kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//
//		kst_treeview_data = ktvi_treeviewitem.data
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//				 
//
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//					
//
////=== Costruisce e Dimensiona le colonne all'interno della listview
//		k_ind=1
//		k_campo[k_ind] = "Articolo fatturato"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Stato"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Documento (Fatt/Nota-Cr.)"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "D.d.t."
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Colli fatt./usciti Peso kg"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "prezzo/importo riga  cod.IVA"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Pagamento"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Cliente"
//		k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "Riferimento"
//		k_align[k_ind] = left!
//	//	k_ind++
//	//	k_campo[k_ind] = "Ulteriori Informazion"
//	//	k_align[k_ind] = left!
//		k_ind++
//		k_campo[k_ind] = "FINE"
//		k_align[k_ind] = left!
//			
//	
//		k_ind=3
//		kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
//		if trim(k_label) <> trim(k_campo[k_ind]) then 
//			kilv_lv1.DeleteColumns ( )
//	
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//	
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//			loop
//	
//		end if
//	
//	
////--- imposto il pic corretto
//		k_handle_item_corrente = kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
////		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			
//
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//
//			klvi_listviewitem.label = kst_treeview_data.label
//			
//			klvi_listviewitem.data = kst_treeview_data
//
//			kst_treeview_data_any = kst_treeview_data.struttura
//
//			kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
//			kst_tab_meca = kst_treeview_data_any.st_tab_meca
//			kst_tab_armo = kst_treeview_data_any.st_tab_armo
//			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//			kst_tab_prodotti = kst_treeview_data_any.st_tab_prodotti
//			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam
//
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
//			
//			klvi_listviewitem.selected = false
//			
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			choose case kst_tab_arfa.tipo_doc
//				case "FT"
//					k_tipo_doc = "Fattura"
//				case "NC"
//					k_tipo_doc = "Nota di Credito"
//				case else
//					k_tipo_doc = "?????????"
//			end choose
//			choose case kst_tab_arfa.stampa
//				case "S"
//					k_stato = "Stampata"
//				case " ", "N"
//					k_stato = "Da stampare"
//				case else
//					k_stato = "?????????"
//			end choose
//
//			k_ind=1
//			kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_armo.art) + " - " &
//								 + trim(kst_tab_prodotti.des))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(k_tipo_doc) &
//													+ "  " + trim(k_stato))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_fatt, "####0") &
//									  + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy"))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_bolla_out, "####0") &
//									  + " - " + string(kst_tab_arfa.data_bolla_out, "dd.mm.yy"))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.colli, "##,##0") &
//										  + " / " + string(kst_tab_arfa.colli_out, "##,##0") &
//										  + "  " + string(kst_tab_arfa.peso_kg_out, "##,##0.00")) 
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.prezzo_u, "###,###,##0.00") &
//												  + " / " + string(kst_tab_arfa.prezzo_t, "###,###,##0.00") &
//												  + "   " + string(kst_tab_arfa.iva, "###"))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.cod_pag , "  ####0")  &
//											  + "  " + trim(kst_tab_pagam.des))
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10) + "  (" + string(kst_tab_arfa.clie_3, "####0") + ") ")
//			k_ind++
//			kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_armo.num_int, "####0") &
//									  + " - " + string(kst_tab_armo.data_int, "dd.mm.yy"))
//			
//			
////--- Leggo rec next dalla tree				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//
//		loop
//		
//	end if
// 
//	 
//	if kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kilv_lv1.extendedselect = true 
//			
//	end if
//
//
// 
//return k_return
//
// 
// 
// 
//
//
end function

public function st_esito u_open (string k_modalita);//
//--- Visualizza Dettaglio
//
integer k_return = 0, k_rc
string k_tipo_oggetto=" ", k_str //, k_id_programma = ""
integer k_esito=1
long k_handle_item=0, k_riga_selezionata=0
st_treeview_data kst_treeview_data	
st_tab_treeview kst_tab_treeview
st_esito kst_esito, kst_esito_return
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem


//=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)

	kst_esito_return.esito = kkg_esito.ok
	kst_esito_return.sqlcode = 0
	kst_esito_return.SQLErrText = ""
	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	if kst_treeview_data.handle > 0 then
		kst_treeview_data.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
		if kst_treeview_data.handle > 1 then
			if kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem) > 0 then
				kst_treeview_data = ktvi_treeviewitem.data
			end if
		end if
	end if

	k_str = kguo_g.get_descrizione(k_modalita)
//	choose case k_modalita
//		case kkg_flag_modalita.inserimento
//			k_str = "Inserimento"
//		case kkg_flag_modalita.modifica
//			k_str = "Modifica"
//		case kkg_flag_modalita.cancellazione
//			k_str = "Cancellazione"
//		case kkg_flag_modalita.visualizzazione
//			k_str = "Visualizzazione"
//		case kkg_flag_modalita.stampa
//			k_str = "Stampa"
//		case else
//			k_str = k_modalita
//	end choose

//	k_tipo_oggetto = trim(kst_treeview_data.oggetto)

//--- legge i dati della tabella TREEVIEW
	kst_tab_treeview.id = trim(kst_treeview_data.oggetto)
	kst_esito_return = u_select_tab_treeview(kst_tab_treeview, k_modalita)

	if kst_esito_return.esito <> kkg_esito.ok then

		kst_esito_return.esito = kst_esito.esito
		kst_esito_return.sqlcode = kst_esito.sqlcode
		kst_esito_return.SQLErrText = "Funzione richiesta non Abilitata~n~r("+ kst_esito.sqlerrtext+")~n~r"
	else				
	
		if len(trim(kst_tab_treeview.open_programma)) > 0 then // vecchia modalità
			
//			kidw_1.dataobject = ""  // pulisco il valore in dw x evitare che romanga il vecchio in anteprima ad es. clienti

//--- Get del ID PROGRAMMA da chiamare 			
			choose case lower(kst_tab_treeview.open_programma)
		
//--- dove non ho la gestione nuova di reperimento del programma attraverso la menu_window_oggetti faccio un semplice assegnazione....					  
				case kkg_id_programma.barcode &
							,kkg_id_programma.pl_barcode &
							, kkg_id_programma.dosimetria &
							,kkg_id_programma.dosimetria_da_autorizzare &
							,kkg_id_programma.dosimetria_da_sbloccare &
							, kkg_id_programma.anag &
							, kkg_id_programma.attestati & 
							, kkg_id_programma.fatture 
//							, kkg_id_programma.riferimenti & 
//							, kkg_id_programma.spedizioni
					kst_tab_treeview.id_programma = trim(lower(kst_tab_treeview.open_programma))
				case else
					if k_modalita <> kkg_flag_modalita.anteprima then
						kst_esito_return.esito = kkg_esito.no_esecuzione
						kst_esito_return.sqlcode = 0
						kst_esito_return.SQLErrText = "Funzione di '" + k_str + "' richiesta non prevista~n~r("+ trim(lower(kst_tab_treeview.id_programma))+ ")~n~r"
					end if					
			end choose

		end if

		if len(trim(kst_tab_treeview.id_programma)) > 0 then
//--- Lancio effettivo PROGRAMMA trovato
			choose case lower(kst_tab_treeview.id_programma)
				
				case kkg_id_programma.barcode
					k_esito = u_open_barcode(k_modalita)
		
				case kkg_id_programma.pl_barcode
					k_esito = u_open_pl_barcode_testa(k_modalita)
							  
				case kkg_id_programma.dosimetria &
					  ,kkg_id_programma.dosimetria_da_autorizzare &
					  ,kkg_id_programma.dosimetria_da_sbloccare
					k_esito = u_open_dosim_lav_ok(k_modalita )
							  
				case kkg_id_programma.anag
					k_esito = u_open_anag(k_modalita )
							  
				case kkg_id_programma.attestati 
					k_esito = u_open_certif(k_modalita ) 

				case kkg_id_programma.fatture
					k_esito = u_open_arfa(k_modalita )
						
//--- nella nuova modalità vado sulla tabella menu_window_oggetti
//---     e lancio effettivo PROGRAMMA trovato
				case else	
					if not isvalid(kiuf_wm_pklist_testa) then kiuf_wm_pklist_testa = create kuf_wm_pklist_testa
					if kst_tab_treeview.id_programma = kiuf_wm_pklist_testa.get_id_programma(k_modalita) then
						k_esito = u_open_wm_pklist(k_modalita )
					else
						
						if not isvalid(kiuf_armo) then kiuf_armo = create kuf_armo
						if kst_tab_treeview.id_programma = kiuf_armo.get_id_programma(k_modalita) then
							k_esito = u_open_riferimenti(k_modalita )
						else
							
							if not isvalid(kiuf_wm_pklist_web) then kiuf_wm_pklist_web = create kuf_wm_pklist_web
							if kst_tab_treeview.id_programma =  kiuf_wm_pklist_web.get_id_programma(k_modalita) then
								k_esito = u_open_wm_pklist_web(k_modalita )
							else
							
								if not isvalid(kiuf_wm_receiptgammarad) then kiuf_wm_receiptgammarad = create kuf_wm_receiptgammarad
								if kst_tab_treeview.id_programma = kiuf_wm_receiptgammarad.get_id_programma(k_modalita) then
									k_esito = u_open_wm_receiptgammarad(k_modalita )
								else
									
									if not isvalid(kiuf_sped) then kiuf_sped = create kuf_sped
									if kst_tab_treeview.id_programma = kiuf_sped.get_id_programma(k_modalita) then
										k_esito = u_open_sped(k_modalita )
									else
										
										if not isvalid(kiuf_certif_file) then kiuf_certif_file = create kuf_certif_file
										if kst_tab_treeview.id_programma = kiuf_certif_file.get_id_programma(k_modalita) then
											k_esito = u_open_certif_file(k_modalita )
										else
											if k_modalita <> kkg_flag_modalita.anteprima then
												kst_esito_return.esito = kkg_esito.no_esecuzione
												kst_esito_return.sqlcode = 0
												kst_esito_return.SQLErrText = "Funzione di '" + k_str + "' richiesta non prevista~n~r(id programma: "+ trim(lower(kst_tab_treeview.id_programma))+ ")~n~r"
											end if						
										end if
									end if
								end if
							end if
						end if
					end if
		
			end choose
		
		end if
			
		
//--- se CANCELLAZIONE tolgo item stampato dalla lista			
		if k_esito = 0 then
			kst_esito_return.esito = kkg_esito.ok
			if k_modalita = kkg_flag_modalita.cancellazione then
//				ki_forza_refresh = ki_forza_refresh_SI
//				u_refresh()
			end if
		else
			kst_esito_return.esito = kkg_esito.no_esecuzione
			kst_esito_return.SQLErrText = "Funzione richiesta non Eseguita: (id programma: " &
			               + trim(lower(kst_tab_treeview.id_programma))+ ", modalita: " + trim(k_modalita) + ")~n~r"
		end if	

	end if

//	kidw_1.Object.DataWindow.ReadOnly='Yes'

//=== Puntatore di default
//SetPointer(k)



return kst_esito_return
end function

private function integer u_open_dosim_lav_ok (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0, k_handle_item_padre = 0
integer k_ctr
date k_save_data_int, k_data_bolla_in
long k_clie_1=0
string k_rag_soc_10 , k_label 
alignment k_align
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_armo kst_tab_armo
st_esito kst_esito
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window
kuf_meca_dosim kuf1_meca_dosim
kuf_armo kuf_armo1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem

//--- 
//--- ricavo il codice e richiamo la windows				
//	choose case kGuf_data_base.u_getfocus_typeof()
//			
//		case listview!
		if kilv_lv1.visible then
			k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				ktvi_treeviewitem.data = kst_treeview_data 
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_armo = kst_treeview_data_any.st_tab_armo
				kst_tab_meca.num_int = kst_tab_armo.num_int
				kst_tab_meca.data_int = kst_tab_armo.data_int
			end if
		end if
//		case treeview!
//			k_rc = kitv_tv1.finditem(CurrentTreeItem!, 0)
//			if k_rc > 0 then
//				kitv_tv1.getitem(k_rc, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data  
//				kst_treeview_data_any = kst_treeview_data.struttura
////				kst_tab_meca = kst_treeview_data_any.st_tab_meca 
//				kst_tab_armo = kst_treeview_data_any.st_tab_armo
//				kst_tab_meca.num_int = kst_tab_armo.num_int
//				kst_tab_meca.data_int = kst_tab_armo.data_int
//			end if
//
//		case else
//			k_rc = 0
//			
//	end choose
 
	if k_rc > 0 then		

		if kst_tab_meca.num_int > 0 or k_modalita = kkg_flag_modalita.inserimento then

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//			kst_treeview_data = u_get_st_treeview_data ()
			kst_treeview_data.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
			if kst_treeview_data.handle > 1 then
				if kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem) > 0 then
					kst_treeview_data = ktvi_treeviewitem.data
				end if
			end if
			choose case trim(kst_treeview_data.oggetto) 
				case kist_treeview_oggetto.meca_lav_att_prima_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_da_conv
				case kist_treeview_oggetto.meca_lav_att_aut_ok_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_da_aut
				case kist_treeview_oggetto.meca_lav_att_aut_ko_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_ko_da_aut
				case kist_treeview_oggetto.meca_lav_ko_da_sblk_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_ko_bloc
				case kist_treeview_oggetto.meca_lav_mese_ko_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_ko_sbloc
				case kist_treeview_oggetto.meca_lav_mese_ko_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_ko_sbloc
				case kist_treeview_oggetto.meca_lav_mese_ok_dett
					kst_tab_meca.err_lav_ok = kuf_meca_dosim.ki_err_lav_ok_conv_aut_ok
			end choose
			
			choose case k_modalita
					
				case kkg_flag_modalita.anteprima
				
					kuf1_meca_dosim = create kuf_meca_dosim
				
					kst_tab_meca_dosim.id_meca = kst_tab_meca.id
					kst_esito = kuf1_meca_dosim.anteprima_dosim_l ( kidw_1, kst_tab_meca_dosim )
				
					destroy kuf1_meca_dosim
	
				
				case else

//--- leggo tabella x ricavare il id del programma
					kst_tab_treeview.id = upper( trim(kst_treeview_data.oggetto) )
					u_select_tab_treeview(kst_tab_treeview, kkg_flag_modalita.modifica )

//=== Parametri : 
//=== struttura st_open_w
//					kst_open_w.id_programma = kkg_id_programma.dosimetria
					kst_open_w.id_programma = kst_tab_treeview.id_programma
					kst_open_w.flag_primo_giro = "S"
					kst_open_w.flag_modalita= k_modalita
					kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
					kst_open_w.flag_leggi_dw = " "
					kst_open_w.flag_cerca_in_lista = " "
					kst_open_w.key1 = string(kst_tab_meca.num_int)
					kst_open_w.key2 = string(kst_tab_meca.data_int)
					kst_open_w.key3 = (kst_tab_meca.err_lav_ok)
					kst_open_w.flag_where = " "
					
					//kuf1_menu_window = create kuf_menu_window 
					kGuf_menu_window.open_w_tabelle(kst_open_w)
					//destroy kuf1_menu_window
					
			end choose
				
		else
			k_return = 1
//			messagebox("Accesso funzione Convalida Dosimetrica", "Valore non disponibile. ")
			
			
		end if

	else
		k_return = 1
	end if
 
 
return k_return

end function

private function integer u_riempi_treeview_meca_dosim_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_treeview_testa_dosim ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
//string k_tipo_oggetto_padre, k_dataoggix, k_tipo_oggetto_figlio
//string k_query_select, k_query_where, k_query_order
//date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi, k_datameno2anni, k_datameno1anni
//boolean k_nuovo_item=true
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_meca kst_tab_meca
//st_tab_clienti kst_tab_clienti
////st_tab_sl_pt kst_tab_sl_pt
//st_tab_armo kst_tab_armo
////st_tab_pl_barcode kst_tab_pl_barcode
//st_tab_contratti kst_tab_contratti
//st_tab_certif kst_tab_certif
//st_tab_artr kst_tab_artr
//kuf_armo kuf1_armo
//kuf_base kuf1_base
//kuf_artr kuf1_artr
//
//
//
//
//	k_data_0 = date(0)		 
////--- data oggi
//	kuf1_base = create kuf_base
//	k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//	destroy kuf1_base
//	if isdate(k_dataoggix) then
//		k_dataoggi = date(k_dataoggix)
//	else
//		k_dataoggi = today()
//	end if
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//
//	k_data_da = date(0)
//	k_data_a = date(0)
//	
////--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
//	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
//		 then
//
////--- potrei avere salvato l'anno in num_int
//		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
//			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
//			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
//		else
//			
////--- Ricavo la data da dataoggi
//			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
//			if isnull(k_mese) or k_mese = 0 then
//				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
//			end if
//		end if
//	end if
//	
//	if k_data_da = date(0) then
//		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
//		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
//		k_data_da = date (k_anno, k_mese, 01) 
//		if k_mese = 12 then
//			k_mese = 1
//			k_anno ++
//		else
//			k_mese = k_mese + 1
//		end if
//		k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
//	end if
//
//	k_datameno2anni = RelativeDate(k_dataoggi, -730) 		 
//	k_datameno1anni = RelativeDate(k_dataoggi, -365) 		 
//	
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//			k_pic_list = kst_tab_treeview.pic_list
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//	
//		k_query_select = &
//			"SELECT  " &
//					+ "meca.id, " &
//					+ "meca.num_int, " &
//					+ "meca.data_int, " &
//					+ "meca.clie_3,  " &
//					+ "meca.data_lav_fin,    " &
//					+ "meca.err_lav_fin,    " &
//					+ "meca_dosim.dosim_data,    " &
//					+ "meca_dosim.dosim_dose,    " &
//					+ "meca.err_lav_ok,    " &
//					+ "meca.note_lav_ok,   " &
//					+ "meca_dosim.x_data_dosim_verifica,  " & 
//					+ "meca_dosim.x_data_dosim_sblocco_ko,  " & 
//					+ "meca_dosim.dosim_assorb,   " &
//					+ "meca_dosim.dosim_spessore,   " &
//					+ "meca_dosim.dosim_rapp_a_s,   " &
//					+ "meca_dosim.dosim_lotto_dosim,  " & 
//					+ "c3.rag_soc_20 " &
//					+ "FROM  meca  " & 
//					 + "LEFT OUTER JOIN meca_dosim ON  " &
//					 + "meca.id = meca_dosim.id_meca " &
//					 + "LEFT OUTER JOIN clienti c3 ON  " &
//					 + "meca.clie_3 = c3.codice " &
//					 
////					+ "armo.magazzino, " &
////					 + "meca INNER JOIN armo ON  " &
////					 + "meca.id = armo.id_meca " &
////					+ "meca.contratto, " &
////					+ "contratti.mc_co, "  &
////					+ "contratti.sc_cf, " &
////					+ "contratti.descr, " &
////					+ "sum(colli_trattati)  " &
////					 + "LEFT OUTER JOIN contratti ON  " &
////					 + "meca.contratto = contratti.codice " &
////					 + "INNER JOIN ARTR ON armo.id_armo = artr.id_armo "
////
//		choose case k_tipo_oggetto
//				
//			case kist_treeview_oggetto.meca_lav_dett
//				k_query_where = " where " &
//					+ "  meca.id = " + string(kst_treeview_data_any.st_tab_meca.id) +" "
//
//			case kist_treeview_oggetto.meca_lav_mese_ok_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '" + string(k_datameno2anni) +"' "
//				if k_data_a  <> k_data_0 then
//					k_query_where = k_query_where &
//					+ " and (meca.data_int between '"+string(k_data_da)+"' and '"+string(k_data_a)+"') "
//				end if
//				k_query_where += " and (meca.err_lav_ok = '"+kuf1_armo.ki_err_lav_ok_conv_aut_ok+"') " 
//					
//			case kist_treeview_oggetto.meca_lav_mese_ko_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '" + string(k_datameno2anni)+"' "
//				if k_data_a  <> k_data_0 then
//					k_query_where = k_query_where &
//					+ " and (meca.data_int between ? and ?) "
//				end if
//				k_query_where = k_query_where &
//					+ " and (meca.err_lav_ok = '"+kuf1_armo.ki_err_lav_ok_conv_ko_sbloc+"') " & 
//					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 
//
//			case kist_treeview_oggetto.meca_lav_att_prima_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '"+string(RelativeDate(k_dataoggi, -180))+"' " &
//					+ " and (meca_dosim.dosim_data is null or meca_dosim.dosim_data <= '"+string(k_data_0)+"' ) " 
////					+ " and artr.data_fin > '" + string(k_data_0) + "' "  & 
//					
//			case kist_treeview_oggetto.meca_lav_att_aut_ok_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '"+string(k_datameno1anni)+"' " &
//					+ " and (meca.err_lav_ok = '"+kuf1_armo.ki_err_lav_ok_conv_da_aut+"') " & 
//					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 
//					
//			case kist_treeview_oggetto.meca_lav_att_aut_ko_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '"+string(k_datameno1anni)+"' " &
//					+ " and (meca.err_lav_ok = '"+kuf1_armo.ki_err_lav_ok_conv_ko_da_aut+"') " & 
//					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 
//
//			case kist_treeview_oggetto.meca_lav_ko_da_sblk_dett
//				k_query_where = " where " &
//					+ "  meca.data_int > '"+string(k_datameno2anni)+"' " &
//					+ " and (meca.err_lav_ok = '"+kuf1_armo.ki_err_lav_ok_conv_ko_bloc+"') " & 
//					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 
//
//					
////			case kist_treeview_oggetto.meca_err_mese_all_dett
////				k_query_where = " where " 
////				if k_data_a  <> k_data_0 then
////					k_query_where = k_query_where &
////					+ "  (meca.data_int between ? and ?) and "
////				end if
////				k_query_where = k_query_where &
////					+ "  (meca.err_lav_ok = '1' or meca.err_lav_fin = '1') "
////					
//					
//			case else
//					k_query_where = " "
//	
//		end choose
//	
////		k_query_order = &
////         + " group by " &
////			+ "meca.id, " &
////			+ "meca.num_int, " &
////			+ "meca.data_int, " &
////         + "meca.clie_3,  " &
////         + "meca.data_lav_fin,    " &
////         + "meca.err_lav_fin,    " &
////         + "meca_dosim.dosim_data,    " &
////         + "meca_dosim.dosim_dose,    " &
////         + "meca.err_lav_ok,    " &
////         + "meca.note_lav_ok,   " &
////         + "meca_dosim.x_data_dosim_verifica,  " & 
////         + "meca_dosim.x_data_dosim_sblocco_ko,  " & 
////         + "meca_dosim.dosim_assorb,   " &
////         + "meca_dosim.dosim_spessore,   " &
////         + "meca_dosim.dosim_rapp_a_s,   " &
////         + "meca_dosim.dosim_lotto_dosim,  " & 
////			+ "armo.magazzino, " &
////			+ "meca.contratto, " &
////			+ "contratti.mc_co, "  &
////			+ "contratti.sc_cf, " &
////			+ "contratti.descr, " &
////         + "c3.rag_soc_20 " 
//			
//		k_query_order += &
//			+ " order by  " &
//			+ " meca.data_int desc, meca.num_int desc " 
//		 
////--- Composizione della Query	
//		if len(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if		
//			 
//
//		choose case k_tipo_oggetto
//				
//					
//			case kist_treeview_oggetto.meca_lav_mese_ko_dett
//				if k_data_a  <> k_data_0 then
//					open dynamic kc_treeview using :k_data_da, :k_data_a;
//				else
//					open dynamic kc_treeview;
//				end if
//				
//			case kist_treeview_oggetto.anag_dett_anno_mese_dett &
//				 ,kist_treeview_oggetto.anag_dett_stor_mese_dett &
//			 	 ,kist_treeview_oggetto.meca_lav_att_prima_dett &
//			 	 ,kist_treeview_oggetto.meca_lav_att_aut_ok_dett &
//			 	 ,kist_treeview_oggetto.meca_lav_att_aut_ko_dett &
//			 	 ,kist_treeview_oggetto.meca_lav_ko_da_sblk_dett &
//			 	 ,kist_treeview_oggetto.meca_lav_dett &
//				 ,kist_treeview_oggetto.meca_lav_mese_ok_dett
//				open dynamic kc_treeview;
//
//	
//			case else
//				sqlca.sqlcode = 100
//	
//		end choose
//		
//		if sqlca.sqlcode <> 0 then
//			sqlca.sqlerrtext = trim(sqlca.sqlerrtext) + k_query_select
//			u_sql_scrivi_log(sqlca)
//		else
//
//			kuf1_armo = create kuf_armo
//			kuf1_artr = create kuf_artr
//			
//			fetch kc_treeview 
//				into
//					 :kst_tab_meca.id   
//					 ,:kst_tab_meca.num_int   
//					 ,:kst_tab_meca.data_int   
//					 ,:kst_tab_meca.clie_3  
//					 ,:kst_tab_meca.data_lav_fin   
//					 ,:kst_tab_meca.err_lav_fin   
//					 ,:kst_tab_meca.dosim_data   
//					 ,:kst_tab_meca.dosim_dose
//					 ,:kst_tab_meca.err_lav_ok   
//					 ,:kst_tab_meca.note_lav_ok  
//					 ,:kst_tab_meca.x_data_dosim_verifica
//					 ,:kst_tab_meca.x_data_dosim_sblocco_ko
//					 ,:kst_tab_meca.dosim_assorb  
//					 ,:kst_tab_meca.dosim_spessore  
//					 ,:kst_tab_meca.dosim_rapp_a_s  
//					 ,:kst_tab_meca.dosim_lotto_dosim  
//					 ,:kst_tab_clienti.rag_soc_20 
//					  ;
//	
////					  :kst_treeview_data_any.contati
////					 ,:kst_tab_barcode.data
//			
//			do while sqlca.sqlcode = 0
//	
//				if isnull(kst_tab_contratti.codice) then
//					kst_tab_contratti.codice = 0
//				end if
//				if isnull(kst_tab_contratti.sc_cf) then
//					kst_tab_contratti.sc_cf = " "
//				end if
//				if isnull(kst_tab_contratti.mc_co) then
//					kst_tab_contratti.mc_co = " "
//				end if
//				if isnull(kst_tab_contratti.descr) then
//					kst_tab_contratti.descr = " "
//				end if
//				kuf1_armo.if_isnull_meca(kst_tab_meca)				
//
////---- Controllo se almeno un pl ha finito il trattamento 
////				if k_tipo_oggetto = kist_treeview_oggetto.meca_lav_att_prima_dett then
////					kst_tab_artr.id_armo = kst_tab_meca.id
////					kst_esito = kuf1_artr.leggi( 3, kst_tab_artr )
////				end if
//
////				if kst_tab_artr.data_fin > k_data_0 or k_tipo_oggetto <> kist_treeview_oggetto.meca_lav_att_prima_dett then
//				if kst_tab_meca.data_lav_fin > k_data_0 or k_tipo_oggetto <> kist_treeview_oggetto.meca_lav_att_prima_dett then
//	
//					kst_tab_armo.id_meca = kst_tab_meca.id
//					kst_tab_armo.num_int = kst_tab_meca.num_int
//					kst_tab_armo.data_int = kst_tab_meca.data_int
//					
//					kst_treeview_data_any.st_tab_meca = kst_tab_meca
//					kst_treeview_data_any.st_tab_armo = kst_tab_armo
//					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
//					kst_treeview_data_any.st_tab_certif = kst_tab_certif
//					kst_treeview_data_any.st_tab_artr = kst_tab_artr
//	
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//					
//					kst_treeview_data.struttura = kst_treeview_data_any
//					
//					kst_treeview_data.label = &
//												 string(kst_tab_meca.num_int, "####0") &
//											  + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
//											  + " "  &
//											  +  &
//											  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
//											  + string(kst_tab_meca.clie_3, "#####") + ")"
//	
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data.handle = k_handle_item_padre
//		
//					kst_treeview_data.pic_list = k_pic_list
//		
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//	
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//					
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//	
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//	
//					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
//				end if
//	
//				fetch kc_treeview 
//				into
//					 :kst_tab_meca.id   
//					 ,:kst_tab_meca.num_int   
//					 ,:kst_tab_meca.data_int   
//					 ,:kst_tab_meca.clie_3  
//					 ,:kst_tab_meca.data_lav_fin   
//					 ,:kst_tab_meca.err_lav_fin   
//					 ,:kst_tab_meca.dosim_data   
//					 ,:kst_tab_meca.dosim_dose
//					 ,:kst_tab_meca.err_lav_ok   
//					 ,:kst_tab_meca.note_lav_ok  
//					 ,:kst_tab_meca.x_data_dosim_verifica
//					 ,:kst_tab_meca.x_data_dosim_sblocco_ko
//					 ,:kst_tab_meca.dosim_assorb  
//					 ,:kst_tab_meca.dosim_spessore  
//					 ,:kst_tab_meca.dosim_rapp_a_s  
//					 ,:kst_tab_meca.dosim_lotto_dosim  
//					 ,:kst_tab_clienti.rag_soc_20 
//					  ;
//	
//			loop
//			
//			close kc_treeview;
//			
//			destroy kuf1_armo
//			destroy kuf1_artr
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_listview_meca_dosim_dett (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_listview_testa_dosim ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return
////
////--- Visualizza Listview
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
//integer k_ctr, k_pictureindex
//string k_label, k_oggetto_corrente, k_oggetto_padre
//int k_ind
//string k_campo[15]
//boolean k_campo_valorizzato[15] 
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_tab_treeview kst_tab_treeview
//st_treeview_data_any kst_treeview_data_any
//st_profilestring_ini kst_profilestring_ini
//
//kuf_armo kuf1_armo
//
//	
////--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_corrente = kst_treeview_data.handle
//	
//	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
////--- item di ritorno di default
//		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
//	end if
//		
////--- prendo il item padre per settare il ritorno di default
//	k_handle_item_padre = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//	if k_handle_item_padre > 0 then
//		k_rc = kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
//	else
//		k_rc = kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//	end if
//	kst_treeview_data = ktvi_treeviewitem.data  
//	k_oggetto_padre = trim(kst_treeview_data.oggetto)
//
////--- cancello dalla listview tutto
//	kilv_lv1.DeleteItems()
//		 
//	klvi_listviewitem.data = kst_treeview_data
//	klvi_listviewitem.label = ".."
//	klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//	k_handle_item_rit = kilv_lv1.additem(klvi_listviewitem)
//		
//	if k_handle_item_corrente > 0 then
//
//		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
//
////--- leggo il primo item dalla treeview per esporlo nella list
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//		k_rc = kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//
//		kilv_lv1.DeleteColumns ( )
//		
////--- 
//		kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//		if k_label <> "Attestato" then 
//
////=== Costruisce e Dimensiona le colonne all'interno della listview
//			kilv_lv1.DeleteColumns ( )
//			k_ind=1
//			k_campo[k_ind] = "Riferimento"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Stato Dosimetria"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Convalidato"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Autorizzato"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Sbloccato"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Lettura Dosimetrica"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Note"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Cliente"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
////			k_ind++
////			k_campo[k_ind] = "Contratto"
////			k_align[k_ind] = left!
////			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Lavorazione"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "FINE"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
//			
//			k_ind=1
//			do while trim(k_campo[k_ind]) <> "FINE"
//
//				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//				kst_profilestring_ini.file = "treeview"
//				kst_profilestring_ini.titolo = "treeview"
//				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//				kst_profilestring_ini.valore = "0"
//				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
// 
//				if kst_profilestring_ini.esito = "0" then
//					k_ctr = integer(kst_profilestring_ini.valore)
//				end if
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 6 //50 * len(trim(k_campo[k_ind])) 
//				end if
//				kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//				k_ind++
//			loop
//
//		end if
////---
//
//		kuf1_armo = create kuf_armo
//
//		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
//
//		do while k_handle_item > 0
//				
//			kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
//	
//			kst_treeview_data = ktvi_treeviewitem.data
//			kst_treeview_data_any = kst_treeview_data.struttura
//			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//
////--- imposto il pic corretto
//			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
//	
//			klvi_listviewitem.label = kst_treeview_data.label
//			klvi_listviewitem.data = kst_treeview_data
//
//			klvi_listviewitem.selected = false
//
//			k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//			
//			kst_tab_treeview.voce =  &
//										  string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
//										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mm.yy") &
//										  + "  (id=" + string(kst_treeview_data_any.st_tab_meca.id) + ") " 
//			k_campo_valorizzato[1] = true
//			kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_treeview.voce) )
//
//
//			if kst_treeview_data_any.st_tab_meca.dosim_data > date(0) then
//				kst_tab_treeview.voce = kuf1_armo.err_lav_ok_dammi_descr(kst_treeview_data_any.st_tab_meca)
//			else
//				kst_tab_treeview.voce =  "da convalidare" 
//			end if
//			k_campo_valorizzato[2] = true
//			kilv_lv1.setitem(k_ctr, 2, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_meca.dosim_data > date(0) then
//				k_campo_valorizzato[3] = true
//				kst_tab_treeview.voce =  &
//										string(kst_treeview_data_any.st_tab_meca.dosim_data, "dd.mm.yy") + " "
//			else
//				kst_tab_treeview.voce = " "
//			end if				
//			kilv_lv1.setitem(k_ctr, 3, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_meca.x_data_dosim_verifica > datetime(date(0)) then
//				k_campo_valorizzato[4] = true
//				kst_tab_treeview.voce =  &
//										string(kst_treeview_data_any.st_tab_meca.x_data_dosim_verifica, "dd.mm.yy") + " "
//			else
//				kst_tab_treeview.voce = " "
//			end if				
//			kilv_lv1.setitem(k_ctr, 4, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_meca.x_data_dosim_sblocco_ko > datetime(date(0)) then
//				k_campo_valorizzato[5] = true
//				kst_tab_treeview.voce =  &
//										string(kst_treeview_data_any.st_tab_meca.x_data_dosim_sblocco_ko, "dd.mm.yy") + " "
//			else
//				kst_tab_treeview.voce = " "
//			end if				
//			kilv_lv1.setitem(k_ctr, 5, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_meca.dosim_assorb > 0 then
//				k_campo_valorizzato[6] = true
//				kst_tab_treeview.voce =  &
//										string(kst_treeview_data_any.st_tab_meca.dosim_dose, "###0.00") + " " &
//										+ "  Ass/Spess.: " &
//										+ string(kst_treeview_data_any.st_tab_meca.dosim_assorb, "####0") + " / " &
//										+ string(kst_treeview_data_any.st_tab_meca.dosim_spessore, "####0") + " " &
//										+ " = " &
//										+ string(kst_treeview_data_any.st_tab_meca.dosim_rapp_a_s, "####0.###") + " " &
//										+ ";  Lotto: " &
//										+ trim(kst_treeview_data_any.st_tab_meca.dosim_lotto_dosim) + " " 
//			else
//				kst_tab_treeview.voce =  " "
//			end if
//			kilv_lv1.setitem(k_ctr, 6, trim(kst_tab_treeview.voce) )
//
//			if len(trim(kst_treeview_data_any.st_tab_meca.note_lav_ok)) > 0 then
//				k_campo_valorizzato[7] = true
//				kst_tab_treeview.voce =  &
//										trim(kst_treeview_data_any.st_tab_meca.note_lav_ok) + " " 
//			else
//				kst_tab_treeview.voce =  " "
//			end if
//			kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//											  string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
//											  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) 
//			k_campo_valorizzato[8] = true
//			kilv_lv1.setitem(k_ctr, 8, trim(kst_tab_treeview.voce) )
////
////			kst_tab_treeview.voce =  &
////										  string(kst_treeview_data_any.st_tab_contratti.codice, "####0") &
////										  + " SC-CF " + kst_treeview_data_any.st_tab_contratti.sc_cf &
////				                    + " MC-CO " + kst_treeview_data_any.st_tab_contratti.mc_co &
////										  + " " + trim(kst_treeview_data_any.st_tab_contratti.descr)
////			k_campo_valorizzato[9] = true
////			kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_treeview.voce) )
//
//			if kst_treeview_data_any.st_tab_meca.data_lav_fin > date(0) then
//				kst_tab_treeview.voce = "Trattato il " + string (kst_treeview_data_any.st_tab_meca.data_lav_fin)
//			else
////				if kst_treeview_data_any.st_tab_artr.colli_trattati > 0 then
////					kst_tab_treeview.voce =  "in lav.: " + string (kst_treeview_data_any.st_tab_artr.colli_trattati) + " colli trattati "
////				else
//					kst_tab_treeview.voce =  "da trattare" 
////				end if
//			end if
//			k_campo_valorizzato[9] = true
//			kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_treeview.voce) )
//
//				
//			k_handle_item = kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//			
//		loop
//		
//		destroy kuf1_armo
//		
//	end if
//
////--- nascondo eventuali colonne mai valorizzate
//	if kilv_lv1.totalitems() > 1 then 
//		k_ind=1
//		do while trim(k_campo[k_ind]) <> "FINE"
//	
//			kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
//			if k_campo_valorizzato[k_ind] then
//				if k_ctr = 0 then
//					k_ctr = (kilv_lv1.width) / 8
//					kilv_lv1.setColumn(k_ind, k_label, k_align_1, k_ctr)
//				end if
//			else
//				kilv_lv1.setColumn(k_ind, k_label, k_align_1, 0)
//			end if
//			
//			k_ind++
//		loop
//	end if
//
//	if k_handle_item_rit > 0 then
//		kst_treeview_data.handle_padre = k_handle_item_corrente
//		kst_treeview_data.handle = k_handle_item_padre
//		kst_treeview_data.oggetto = k_oggetto_padre
//		kst_treeview_data.oggetto_listview = k_tipo_oggetto
//		ktvi_treeviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//	end if
//
//
//
//
//return k_return
//
end function

public function st_treeview_data u_get_st_treeview_data_padre ();//
//--- ricavo la struttura con il relativo tipo oggetto della treeview o listview 
//
integer k_rc
long k_handle_item = 0
string k_tipo_oggetto=" "
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 
listviewitem klvi_listviewitem 



//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	k_handle_item = 0


	if ki_fuoco_tree_list <> ki_fuoco_su_nulla then

		CHOOSE CASE	ki_fuoco_tree_list
			CASE ki_fuoco_su_tree
		
				k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
				if k_handle_item > 0 then
					kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
//--- ricavo il tipo oggetto			
					kst_treeview_data = ktvi_treeviewitem.data
					if k_tipo_oggetto = " " then
						k_tipo_oggetto = trim(kst_treeview_data.oggetto)
					end if
				else
//--- se non esiste seleziono il ROOT
					k_handle_item = kitv_tv1.finditem(RootTreeItem!, 0)
					if k_handle_item > 0 then
						kitv_tv1.selectitem(k_handle_item)
					end if
				end if

	
		END CHOOSE

	end if
		
	if k_tipo_oggetto = " " then 
		
		k_rc = kilv_lv1.SelectedIndex()
		
		if k_rc > 0 then 
			k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex(), 1, klvi_listviewitem) 
			if k_rc > 0 then 
		
				kst_treeview_data = klvi_listviewitem.data  

//--- ricavo il tipo oggetto dalla Tree se non c'e' nel il list			
				if len(trim(kst_treeview_data.oggetto)) = 0 and kst_treeview_data.handle > 0 then

					k_handle_item = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle) 
					if k_handle_item > 0 then
						kst_treeview_data.handle = k_handle_item
					end if
					kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem)
					kst_treeview_data = ktvi_treeviewitem.data
					
				end if
			end if
		end if

		if k_rc <= 0 then
	
//--- ricavo il tipo oggetto dalla treeview se non c'e' il list			
			k_handle_item = kitv_tv1.finditem(CurrentTreeItem!, 0)
			if k_handle_item > 0 then
				kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
//--- ricavo il tipo oggetto			
				kst_treeview_data = ktvi_treeviewitem.data
//				if k_tipo_oggetto = " " then
//					k_tipo_oggetto = trim(kst_treeview_data.oggetto)
//				end if
			else
//--- se non esiste seleziono il ROOT
				k_handle_item = kitv_tv1.finditem(RootTreeItem!, 0)
				if k_handle_item > 0 then
					kitv_tv1.selectitem(k_handle_item)
				end if
			end if

		end if
	end if
		

return kst_treeview_data

end function

public function integer u_dammi_item_padre_da_list ();//
//--- Torna il padre dell'item di listview
//
integer k_item = 0, k_rc
listviewitem klvi_listviewitem
st_treeview_data kst_treeview_data
//treeviewitem ktvi_treeviewitem


	k_item = kilv_lv1.finditem(0,"..", true, true)
//	k_item = kilv_lv1.finditem(1,"..", true, false)
	if k_item > 0 then
		k_rc = kilv_lv1.getitem(k_item, 1, klvi_listviewitem) 
		if k_rc > 0 then 
			kst_treeview_data = klvi_listviewitem.data  
			k_item = kst_treeview_data.handle_padre 

		end if

	end if



return k_item

end function

public function long u_treeview_conta_item ();//---
//---   Conta gli ITEM della TreeView
//---
CONSTANT integer TV_FIRST = 4352
CONSTANT integer TVM_GETCOUNT = TV_FIRST + 5

long k_return

k_return = Send ( handle(kitv_tv1), TVM_GETCOUNT, 0, 0 )


return k_return

end function

private function integer u_open_arfa (string k_modalita);//
//--- Chiama la funzione richiesta
//
integer k_return = 0, k_rc = 0
integer k_ctr, k_index, k_ind
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa[]
st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem




//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = this.u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = this.kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if this.kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- 
	kst_treeview_data_any = kst_treeview_data.struttura

//--- Carica tabella Fatture...					
	k_index = this.kilv_lv1.SelectedIndex()
			
//--- Cicla fino a che ci sono righe selezionate
	k_ind=1
	do while k_index > 0 //NOT k_fatt_selected_eof
				
		kst_tab_arfa[k_ind] = kst_treeview_data_any.st_tab_arfa
		k_ind ++
		
//--- cerco se altre righe selezionate		
		klvi_listviewitem.Selected = false
		do while not klvi_listviewitem.Selected and k_index > 0  	
			k_index++
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			else
				k_index = 0
			end if
		loop
	loop

	kuf1_fatt = create kuf_fatt

	k_return = kuf1_fatt.u_tree_open( k_modalita, kst_tab_arfa[], kidw_1)

	destroy kuf1_fatt


return k_return 


end function

private function integer u_riempi_treeview_meca_barcode_da_stamp (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_barcode_tree kuf1_barcode

kuf1_barcode = create kuf_barcode_tree

ki_forza_refresh = ki_forza_refresh_si  //18042016 forza la rilettura del treeview sempre
k_return = kuf1_barcode.u_tree_riempi_treeview_da_stamp( ki_this, k_tipo_oggetto )

//destroy kuf1_barcode

return k_return

end function

private function integer u_riempi_listview_sped (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_sped kuf1_sped

kuf1_sped = create kuf_sped

k_return = kuf1_sped.u_tree_riempi_listview( ki_this, k_tipo_oggetto )

destroy kuf1_sped

return k_return


end function

private function integer u_riempi_listview_sped_righe (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_sped kuf1_sped

kuf1_sped = create kuf_sped

k_return = kuf1_sped.u_tree_riempi_listview_righe_sped( ki_this, k_tipo_oggetto )

destroy kuf1_sped

return k_return


////
////--- Visualizza Listview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_item_rit
//integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
//string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_padre
//date k_data_da, k_data_a, k_data_0
//int k_ind, k_ctr
//string k_campo[15], k_label
//alignment k_align[15]
//alignment k_align_1
//treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_sped kst_tab_sped
//st_tab_arsp kst_tab_arsp
//st_tab_armo kst_tab_armo
//st_tab_clienti kst_tab_clienti
//st_tab_prodotti kst_tab_prodotti
//kuf_base kuf1_base
//st_profilestring_ini kst_profilestring_ini
//
//
//
//declare kc_treeview cursor for
//  SELECT 
//         arsp.id_armo,
//			armo.art,
//			prodotti.des,
//			armo.num_int,
//			armo.data_int,
//  			arsp.num_bolla_out,   
//         arsp.data_bolla_out,   
//         arsp.stampa,   
//         arsp.colli,   
//         arsp.colli_out,   
//         arsp.peso_kg_out,   
//         arsp.note_1,   
//         arsp.note_2,   
//         arsp.note_3,   
//			sped.clie_2,
//			sped.clie_3,
//			c2.rag_soc_10, 
//			c3.rag_soc_10 
//    FROM arsp LEFT OUTER JOIN armo ON 
//            arsp.id_armo = armo.id_armo      
//              LEFT OUTER JOIN sped ON 
//            arsp.num_bolla_out = sped.num_bolla_out      
//            and arsp.data_bolla_out = sped.data_bolla_out      
//               LEFT OUTER JOIN clienti c2 ON 
//			   sped.clie_2 = c2.codice
//              LEFT OUTER JOIN clienti c3 ON 
//			   sped.clie_3 = c3.codice
//              LEFT OUTER JOIN prodotti ON 
//			   armo.art = prodotti.codice
//    WHERE 
//			 (:k_tipo_oggetto = :kist_treeview_oggetto.sped_righe_dett
//			  and 
//		        (arsp.num_bolla_out = :kst_tab_arsp.num_bolla_out 
//		        and arsp.data_bolla_out = :kst_tab_arsp.data_bolla_out )
//			 )	   
//	 order by 
//		 arsp.data_bolla_out, arsp.num_bolla_out, arsp.id_armo
//	 using sqlca;
//
//
//	k_data_0 = date(0)		 
//
////=== Costruisce e Dimensiona le colonne all'interno della listview
//	k_ind=1
//	k_campo[k_ind] = "Articolo spedito"
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "Stato"
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "D.d.t."
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "Colli scar./sped."
//	k_align[k_ind] = right!
//	k_ind++
//	k_campo[k_ind] = "Peso"
//	k_align[k_ind] = right!
//	k_ind++
//	k_campo[k_ind] = "Riferimento"
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "Note"
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "Ricevente"
//	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "Cliente"
//	k_align[k_ind] = left!
////	k_ind++
////	k_campo[k_ind] = "Ulteriori Informazion"
////	k_align[k_ind] = left!
//	k_ind++
//	k_campo[k_ind] = "FINE"
//	k_align[k_ind] = left!
//		
//
//	k_ind=3
//	kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
//	if trim(k_label) <> trim(k_campo[k_ind]) then 
//		kilv_lv1.DeleteColumns ( )
//
//		k_ind=1
//		do while trim(k_campo[k_ind]) <> "FINE"
//
//			kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
//			kst_profilestring_ini.file = "treeview"
//			kst_profilestring_ini.titolo = "treeview"
//			kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
//			kst_profilestring_ini.valore = "0"
//			k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
// 
//			if kst_profilestring_ini.esito = "0" then
//				k_ctr = integer(kst_profilestring_ini.valore)
//			end if
//			if k_ctr = 0 then
//				k_ctr = (kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
//			end if
//			kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
//			k_ind++
//		loop
//
//	end if
//
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//		 
////--- Ricavo il handle del Padre e il tipo Oggetto
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//
////--- Periodo di estrazione, se la data e' a zero allora anno nel num_bolla_out
//	kst_treeview_data_any = kst_treeview_data.struttura
//	if kst_treeview_data_any.st_tab_arsp.data_bolla_out > date (0) then
//		k_mese = month(kst_treeview_data_any.st_tab_arsp.data_bolla_out) 
//		if isnull(k_mese) or k_mese = 0 then
//			kuf1_base = create kuf_base
//			k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
//			destroy kuf1_base
//			if isdate(k_dataoggix) then
//
//				kst_treeview_data_any.st_tab_arsp.data_bolla_out = date(k_dataoggix)
//			else
//				kst_treeview_data_any.st_tab_arsp.data_bolla_out = today()
//			end if
//			k_mese = month(kst_treeview_data_any.st_tab_arsp.data_bolla_out) 
//		end if
//		k_anno = year(kst_treeview_data_any.st_tab_arsp.data_bolla_out)
//		k_data_da = date (k_anno, k_mese, 01) 
//		if k_mese = 12 then
//			k_mese = 1
//			k_anno ++
//		else
//			k_mese = k_mese + 1
//		end if
//		k_data_a = date (k_anno, k_mese, 01) 
//	else
//		k_data_da = date(kst_treeview_data_any.st_tab_arsp.num_bolla_out, 01, 01)
//		k_data_a = date(kst_treeview_data_any.st_tab_arsp.num_bolla_out, 12, 31)
//	end if
//
//	if kst_treeview_data_any.st_tab_arsp.num_bolla_out > 0 then
//		kst_tab_arsp = kst_treeview_data_any.st_tab_arsp
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kist_treeview_oggetto)
//
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto)
////		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		k_pic_list = u_dammi_pic_tree_list(k_tipo_oggetto)			
////		if kst_esito.esito = "0" then
////			k_pic_open = kst_tab_treeview.pic_open
////			k_pic_close = kst_tab_treeview.pic_close
////			k_pic_list = kst_tab_treeview.pic_list
////		end if
////		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_gia_st_pic_close)
////		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_gia_st_pic_open)
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
////--- cancello dalla listview tutto
//		kilv_lv1.DeleteItems()
//
//		ktvi_treeviewitem.selected = false
//
////--- Insert del primo item in lista quello di default del 'ritorno'
//		kst_treeview_data.oggetto = k_tipo_oggetto
//		klvi_listviewitem.data = kst_treeview_data
//		klvi_listviewitem.label = ".."
//		klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//		k_handle_item_rit = kilv_lv1.additem(klvi_listviewitem)
//
//
//
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					:kst_tab_arsp.id_armo,
//					:kst_tab_armo.art,   
//					:kst_tab_prodotti.des,
//					:kst_tab_armo.num_int,   
//					:kst_tab_armo.data_int,   
//					:kst_tab_arsp.num_bolla_out,   
//					:kst_tab_arsp.data_bolla_out,   
//					:kst_tab_arsp.stampa,   
//					:kst_tab_arsp.colli,   
//					:kst_tab_arsp.colli_out,   
//					:kst_tab_arsp.peso_kg_out,   
//					:kst_tab_arsp.note_1,   
//					:kst_tab_arsp.note_2,   
//					:kst_tab_arsp.note_3,   
//					:kst_tab_sped.clie_2,
//					:kst_tab_sped.clie_3,
//				   :kst_tab_clienti.rag_soc_10, 
//				   :kst_tab_clienti.rag_soc_20 
//				  ;
//	
//			
//			do while sqlca.sqlcode = 0
//
//				
//				kst_treeview_data.handle = 0
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data.struttura = kst_treeview_data_any
//			   kst_treeview_data.oggetto_listview = k_tipo_oggetto
//				
//			   klvi_listviewitem.data = kst_treeview_data
//
//				klvi_listviewitem.pictureindex = k_pic_list
//			   
//				klvi_listviewitem.selected = false
//				
//				k_ctr = kilv_lv1.additem(klvi_listviewitem)
//
//
//				choose case kst_tab_arsp.stampa
//					case "S"
//						k_stato = "Stampato"
//					case "F"
//						k_stato = "Fatturato"
//					case else
//						k_stato = "Da stampare"
//				end choose
//
//				if isnull(kst_tab_prodotti.des) then
//					kst_tab_prodotti.des = " "
//				end if
// 				if isnull(kst_tab_arsp.colli) then		
//					kst_tab_arsp.colli = 0
//				end if
//				if isnull(kst_tab_arsp.colli_out) then		
//					kst_tab_arsp.colli_out = 0
//				end if
//				if isnull(kst_tab_arsp.note_1) then		
//					kst_tab_arsp.note_1 = " "
//				end if
//				if isnull(kst_tab_arsp.note_2) then		
//					kst_tab_arsp.note_2 = " "
//				end if
//				if isnull(kst_tab_arsp.note_3) then		
//					kst_tab_arsp.note_3 = " "
//				end if
//				if isnull(kst_tab_clienti.rag_soc_10) then		
//					kst_tab_clienti.rag_soc_10 = " "
//				end if
//				if isnull(kst_tab_clienti.rag_soc_20) then		
//					kst_tab_clienti.rag_soc_20 = " "
//				end if
//				
//				kst_tab_sped.num_bolla_out = kst_tab_arsp.num_bolla_out
//				kst_tab_sped.data_bolla_out = kst_tab_arsp.data_bolla_out
//	
//				kst_treeview_data_any.st_tab_arsp = kst_tab_arsp
//				kst_treeview_data_any.st_tab_sped = kst_tab_sped
//				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//
//				kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_armo.art) + " - " &
//				                + trim(kst_tab_prodotti.des))
//				kilv_lv1.setitem(k_ctr, 2, trim(k_stato))
//				kilv_lv1.setitem(k_ctr, 3, string(kst_tab_arsp.num_bolla_out, "####0") &
//				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy"))
//				kilv_lv1.setitem(k_ctr, 4, string(kst_tab_arsp.colli, "##,##0") &
//											  + " / " + string(kst_tab_arsp.colli_out, "##,##0")) 
//				kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.peso_kg, "##,##0.00"))
//				kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.num_int , "  ####0")  &
//				                          + "  " + string(kst_tab_armo.data_int , "dd/mm/yy"))
//				kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_arsp.note_1) &
//											  + " " + trim(kst_tab_arsp.note_2) &
//											  + " " + trim(kst_tab_arsp.note_3))
//				kilv_lv1.setitem(k_ctr, 8, string(kst_tab_sped.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_10))
//				kilv_lv1.setitem(k_ctr, 9, string(kst_tab_sped.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20))
//				
//
////				kst_tab_treeview.voce = trim(kst_tab_armo.art) &
////				                    + "  (" + string(kst_tab_arsp.num_bolla_out, "####0") &
////				                    + "/" + string(kst_tab_arsp.data_bolla_out, "yyyy") + ") " 
////
////				kst_tab_treeview.descrizione_tipo =  k_stato & 
////				                    + "  ddt: " + string(kst_tab_arsp.num_bolla_out, "####0") &
////				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy") 
////				if kst_tab_arsp.colli <> kst_tab_arsp.colli_out then
////					kst_tab_treeview.descrizione_tipo = kst_tab_treeview.descrizione_tipo & 
////											  + "  Colli scar./sped.: " + string(kst_tab_arsp.colli, "##,##0") &
////											  + "/" + string(kst_tab_arsp.colli_out, "##,##0") 
////				else
////					kst_tab_treeview.descrizione_tipo = kst_tab_treeview.descrizione_tipo & 
////											  + "  Colli: " + string(kst_tab_arsp.colli, "##,##0") 
////				end if											  
////				kst_tab_treeview.descrizione_tipo =  kst_tab_treeview.descrizione_tipo & 
////											  + "  Peso kg: " + string(kst_tab_arsp.peso_kg_out, "##,##0.00") &
////				
////				kst_tab_treeview.descrizione = &
////											  + "Note: " + trim(kst_tab_arsp.note_1) &
////											  + " " + trim(kst_tab_arsp.note_2) &
////											  + " " + trim(kst_tab_arsp.note_3) 
////											  
////				kst_tab_treeview.descrizione_ulteriore =  &
////											  + " Ricev.:" + string(kst_tab_sped.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_10) &
////											  + " Fatt.:" + string(kst_tab_sped.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20)
////											  
////				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
////				
////				kst_treeview_data.struttura = kst_treeview_data_any
////				
////				kst_treeview_data.label = &
////				                    string(kst_tab_arsp.num_bolla_out, "####0") &
////				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy") &
////										  + " "  &
////										  +  &
////										  + " (" + string(kst_tab_sped.clie_2, "#####") + " -> " &
////										  + string(kst_tab_sped.clie_3, "#####") + ")"
////
////				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
////				kst_treeview_data.handle = k_handle_item_padre
////	
////				ktvi_treeviewitem.label = kst_treeview_data.label
////				ktvi_treeviewitem.data = kst_treeview_data
////										  
//////--- Nuovo Item
////				ktvi_treeviewitem.selected = false
////				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
////				
//////--- salvo handle del item appena inserito nella stessa struttura
////				kst_treeview_data.handle = k_handle_item
////
//////--- inserisco il handle di questa riga tra i dati del item
////				ktvi_treeviewitem.data = kst_treeview_data
////
////				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//	
//				fetch kc_treeview 
//				into
//					:kst_tab_arsp.id_armo,
//					:kst_tab_armo.art,   
//					:kst_tab_prodotti.des,
//					:kst_tab_armo.num_int,   
//					:kst_tab_armo.data_int,   
//					:kst_tab_arsp.num_bolla_out,   
//					:kst_tab_arsp.data_bolla_out,   
//					:kst_tab_arsp.stampa,   
//					:kst_tab_arsp.colli,   
//					:kst_tab_arsp.colli_out,   
//					:kst_tab_arsp.peso_kg_out,   
//					:kst_tab_arsp.note_1,   
//					:kst_tab_arsp.note_2,   
//					:kst_tab_arsp.note_3,   
//					:kst_tab_sped.clie_2,
//					:kst_tab_sped.clie_3,
//				   :kst_tab_clienti.rag_soc_10, 
//				   :kst_tab_clienti.rag_soc_20 
//					 ;
//	
//			loop
//			
//			close kc_treeview;
//			
////--- Aggiorna il primo item in lista quello di default del 'ritorno'
//			kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//			kst_treeview_data = ktvi_treeviewitem.data
//			if k_handle_item_padre > 0 then
////--- prendo il item padre per settare il ritorno di default
//				k_handle_item = kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//				if k_handle_item <= 0 then
//					k_handle_item = 1
//				end if
//			else
//				k_handle_item = 1
//			end if
//			kst_treeview_data.handle_padre = k_handle_item_padre
//			kst_treeview_data.handle = k_handle_item
//			kst_treeview_data.oggetto_listview = k_tipo_oggetto
//			kst_treeview_data.oggetto = ""
//			klvi_listviewitem.label = ".."
//			klvi_listviewitem.data = kst_treeview_data
//			klvi_listviewitem.pictureindex = kist_treeview_oggetto.pic_ritorna_item_padre
//			kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//
////			kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
////			ktvi_treeviewitem.selected = true
////			ktvi_treeviewitem.Expanded	= true
////			kitv_tv1.setitem(k_handle_item_padre, ktvi_treeviewitem)
//	
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

public subroutine u_imposta_propieta (ref treeviewitem ktvi_corrente, string k_tipo_oggetto, st_treeview_oggetto kst_treeview_oggetto);//
//kitv_tv1.HideSelection = FALSE

//--- Imposta Propieta' di Default
ktvi_corrente.pictureindex = 2
ktvi_corrente.selectedpictureindex = 3
ktvi_corrente.statepictureindex = 0
ktvi_corrente.children = true
ktvi_corrente.drophighlighted = false
//ktvi_corrente.OverlayPictureIndex = 0
ktvi_corrente.bold = false



end subroutine

public function integer u_dammi_pic_tree_list (string k_tipo_oggetto);//
//--- Valorizza la PIC della ListView
//
integer k_return = 0, k_rc
string k_id
st_tab_treeview kst_tab_treeview


	if len(trim(k_tipo_oggetto)) > 0 then
		
		k_id = upper(trim(k_tipo_oggetto))
		
		kst_tab_treeview.id = k_id
		u_select_tab_treeview(kst_tab_treeview, "")
		k_return=kst_tab_treeview.pic_list
//		select pic_list
//			into :k_return
//			from treeview
//			where id = :k_id;
			
		if k_return = 0 or isnull(k_return) then k_return = 2 //default
			
	else
		k_return = 0
	end if
	
	
		
//	
//		choose case lower(k_tipo_oggetto)
//						  
//			case kist_treeview_oggetto.root, &
//			     kist_treeview_oggetto.nullo
//				k_return = integer(kist_treeview_oggetto.root_pic_list)
//								  
//				
////--- Gestione "ramo" BARCODE
//			case kist_treeview_oggetto.barcode_no_st
//				k_return = integer(kist_treeview_oggetto.barcode_no_st_pic_list )
//		
//			case kist_treeview_oggetto.barcode_gia_st
//				k_return = integer(kist_treeview_oggetto.barcode_gia_st_pic_list )
//		
//			case kist_treeview_oggetto.barcode_dett
//				k_return = integer(kist_treeview_oggetto.barcode_dett_pic_list )
//				 
//			case kist_treeview_oggetto.barcode
//				k_return = integer(kist_treeview_oggetto.barcode_pic_list )
//
//
////--- Gestione "ramo" P.L.				
//			case  &
//				  kist_treeview_oggetto.pl_barcode, &
//				  kist_treeview_oggetto.pl_barcode_mese, &
//				  kist_treeview_oggetto.pl_barcode_gener, &
//				  kist_treeview_oggetto.pl_barcode_da_trattare, &
//				  kist_treeview_oggetto.pl_barcode_sospeso, &
//				  kist_treeview_oggetto.pl_barcode_chiuso 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_pic_list )
//				
//			case kist_treeview_oggetto.pl_barcode_da_trattare_dett, &
//				  kist_treeview_oggetto.pl_barcode_chiuso_dett, &
//			     kist_treeview_oggetto.pl_barcode_sospeso_dett 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_da_trattare_dett_pic_list )
//
//			case kist_treeview_oggetto.pl_barcode_dett
//				k_return = integer(kist_treeview_oggetto.pl_barcode_dett_pic_list )
//			
//
//		end choose
//
//
return k_return
end function

public function integer u_dammi_pic_tree_close (string k_tipo_oggetto);//
//--- Valorizza la PIC della TreeView
//
integer k_return = 0, k_rc
string k_id
st_tab_treeview kst_tab_treeview


	if len(trim(k_tipo_oggetto)) > 0 then
		
		k_id = upper(trim(k_tipo_oggetto))
		
		kst_tab_treeview.id = k_id
		u_select_tab_treeview(kst_tab_treeview, "")
		k_return=kst_tab_treeview.pic_close
//		select pic_close
//			into :k_return
//			from treeview
//			where id = :k_id;

		if k_return = 0 or isnull(k_return) then k_return = 2 //default
		
	else
		k_return = 0
	end if
	


//	
//		choose case lower(k_tipo_oggetto)
//						  
//			case kist_treeview_oggetto.root, &
//			     kist_treeview_oggetto.nullo
//				k_return = integer(kist_treeview_oggetto.root_pic_close)
//								  
////--- Gestione "ramo" BARCODE
//			case kist_treeview_oggetto.barcode_no_st
//				k_return = integer(kist_treeview_oggetto.barcode_no_st_pic_close )
//		
//			case kist_treeview_oggetto.barcode_gia_st
//				k_return = integer(kist_treeview_oggetto.barcode_gia_st_pic_close )
//		
//			case kist_treeview_oggetto.barcode_dett
//				k_return = integer(kist_treeview_oggetto.barcode_dett_pic_close)
//				 
//			case kist_treeview_oggetto.barcode
//				k_return = integer(kist_treeview_oggetto.barcode_pic_close )
//
//
////--- Gestione "ramo" P.L.				
//			case  &
//				  kist_treeview_oggetto.pl_barcode, &
//				  kist_treeview_oggetto.pl_barcode_mese, &
//				  kist_treeview_oggetto.pl_barcode_gener, &
//				  kist_treeview_oggetto.pl_barcode_da_trattare, &
//				  kist_treeview_oggetto.pl_barcode_sospeso, &
//				  kist_treeview_oggetto.pl_barcode_chiuso 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_pic_close )
//				
//			case kist_treeview_oggetto.pl_barcode_da_trattare_dett, &
//				  kist_treeview_oggetto.pl_barcode_chiuso_dett, &
//			     kist_treeview_oggetto.pl_barcode_sospeso_dett 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_da_trattare_dett_pic_close )
//
//			case kist_treeview_oggetto.pl_barcode_dett
//				k_return = integer(kist_treeview_oggetto.pl_barcode_dett_pic_close )
//			
//
//		end choose
//

return k_return
end function

public function integer u_dammi_pic_tree_open (string k_tipo_oggetto);//
//--- Valorizza la PIC della TreeView
//
integer k_return = 0, k_rc
string k_id
st_tab_treeview kst_tab_treeview


	if len(trim(k_tipo_oggetto)) > 0 then
		
		k_id = upper(trim(k_tipo_oggetto))
		
		kst_tab_treeview.id = k_id
		u_select_tab_treeview(kst_tab_treeview, "")
		k_return=kst_tab_treeview.pic_open
//		select pic_open
//			into :k_return
//			from treeview
//			where id = :k_id;

		if k_return = 0 or isnull(k_return) then k_return = 3 //default
			
	else
		k_return = 0
	end if
	

//
//	
//		choose case lower(k_tipo_oggetto)
//						  
//			case kist_treeview_oggetto.root, &
//			     kist_treeview_oggetto.nullo
//				k_return = integer(kist_treeview_oggetto.root_pic_open)
//								  
////--- Gestione "ramo" BARCODE
//			case kist_treeview_oggetto.barcode_no_st
//				k_return = integer(kist_treeview_oggetto.barcode_no_st_pic_open )
//		
//			case kist_treeview_oggetto.barcode_gia_st
//				k_return = integer(kist_treeview_oggetto.barcode_gia_st_pic_open )
//		
//			case kist_treeview_oggetto.barcode_dett
//				k_return = integer(kist_treeview_oggetto.barcode_dett_pic_open )
//				 
//			case kist_treeview_oggetto.barcode
//				k_return = integer(kist_treeview_oggetto.barcode_pic_open )
//
//
////--- Gestione "ramo" P.L.				
//			case  &
//				  kist_treeview_oggetto.pl_barcode, &
//				  kist_treeview_oggetto.pl_barcode_mese, &
//				  kist_treeview_oggetto.pl_barcode_gener, &
//				  kist_treeview_oggetto.pl_barcode_da_trattare, &
//				  kist_treeview_oggetto.pl_barcode_sospeso, &
//				  kist_treeview_oggetto.pl_barcode_chiuso 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_pic_open )
//				
//			case kist_treeview_oggetto.pl_barcode_da_trattare_dett, &
//				  kist_treeview_oggetto.pl_barcode_chiuso_dett, &
//			     kist_treeview_oggetto.pl_barcode_sospeso_dett 
//				k_return = integer(kist_treeview_oggetto.pl_barcode_da_trattare_dett_pic_open )
//
//			case kist_treeview_oggetto.pl_barcode_dett
//				k_return = integer(kist_treeview_oggetto.pl_barcode_dett_pic_open )
//			
//
//		end choose
//

return k_return
end function

public subroutine u_sql_scrivi_log (ref transaction ksqlca);//
st_errori_gestione kst_errori_gestione


//--- scrive l'errore su LOG
	kst_errori_gestione.nome_oggetto = this.classname()
	kst_errori_gestione.sqlsyntax = trim(kSQLCA.sqlerrtext)
	kst_errori_gestione.sqlerrtext = trim(kSQLCA.SQLErrText)
	kst_errori_gestione.sqldbcode = ksqlca.sqlcode
	kst_errori_gestione.sqlca = ksqlca
	kGuf_data_base.errori_gestione(kst_errori_gestione)


end subroutine

private function integer u_riempi_treeview_meca_err_mese_giri (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo

kuf1_armo = create kuf_armo_tree

k_return = kuf1_armo.u_tree_riempi_treeview_err_giri_x_mese ( ki_this, k_tipo_oggetto )

destroy kuf1_armo

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
//long k_totale
//integer k_ctr, k_pic_close, k_pic_open
//string k_tipo_oggetto_padre, k_tipo_oggetto_figlio, k_err_lav_ok, k_err_lav_fin
//date k_save_data_int
//int k_mese, k_anno, k_anno_old
//string k_mese_desc [0 to 13]
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_meca kst_tab_meca
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//kuf_armo kuf1_armo
//
//
//declare kc_treeview cursor for
//	SELECT 
//         count (*), 
//         month(meca.data_int) as mese,   
//         year(meca.data_int) as anno   
//     FROM meca
//    WHERE 
//     		meca.data_int > '31.12.2003'
//			and
//			(
//			  (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_err_mese_giri
//				and meca.err_lav_fin = '1'
//		     )
//			  or
//			  (:k_tipo_oggetto_padre = :kist_treeview_oggetto.meca_err_mese_all
// 				and 
//					  (meca.err_lav_ok =  :k_err_lav_ok
//					  or meca.err_lav_ok = :k_err_lav_ok   
//					  or meca.err_lav_ok = :k_err_lav_ok  
//					  or meca.err_lav_fin =:k_err_lav_fin  ) 
//			  )
//			)
//		 group by  3, 2
//		 order by  3 desc, 2 desc;
//
//
//	k_err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_ko_da_aut 
//	k_err_lav_fin =	 kuf1_armo.ki_err_lav_fin_ko
//		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//	
//
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.pictureindex = k_pic_close 
//			ktvi_treeviewitem.selectedpictureindex = k_pic_open 
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			k_mese_desc[0] = "[Completa]"
//			k_mese_desc[1] = "Gennaio"
//			k_mese_desc[2] = "Febbraio"
//			k_mese_desc[3] = "Marzo"
//			k_mese_desc[4] = "Aprile"
//			k_mese_desc[5] = "Maggio"
//			k_mese_desc[6] = "Giugno"
//			k_mese_desc[7] = "Luglio"
//			k_mese_desc[8] = "Agosto"
//			k_mese_desc[9] = "Settembre"
//			k_mese_desc[10] = "Ottobre"
//			k_mese_desc[11] = "Novembre"
//			k_mese_desc[12] = "Dicembre"
//			k_mese_desc[13] = "NON RILEVATO"
//
//			k_totale = 0
//			k_anno_old = 0
//			
////--- estrazione carichi vera e propria			
//			do while sqlca.sqlcode = 0
//	
//	
////--- a rottura di anno presenta la riga totale a inizio
//				if k_anno <> k_anno_old then
//			
//					if k_totale > 0 then
//				
////--- Estrazione del primo Item, quello dei totali
//						ktvi_treeviewitem.selected = false
//						k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//						kst_treeview_data = ktvi_treeviewitem.data
//						kst_treeview_data_any = kst_treeview_data.struttura
//						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//						k_totale = 0
//						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//						kst_treeview_data.struttura = kst_treeview_data_any
//						ktvi_treeviewitem.data = kst_treeview_data
//						k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//					end if
//					
//					k_anno_old = k_anno // memorizzo l'anno x la rottura
//					
//					kst_treeview_data.label = k_mese_desc[0] &
//													  + "  " &
//													  + string(k_anno) 
//					kst_tab_treeview.voce = kst_treeview_data.label
//					kst_tab_treeview.id = "0"
//					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
//					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//					kst_treeview_data_any.st_tab_meca = kst_tab_meca
//					kst_treeview_data_any.st_tab_meca.data_int = date(0)
//					kst_treeview_data_any.st_tab_meca.num_int = k_anno
//					kst_treeview_data.struttura = kst_treeview_data_any
//					kst_treeview_data.handle = k_handle_item_padre
//					ktvi_treeviewitem.label = kst_treeview_data.label
//					ktvi_treeviewitem.data = kst_treeview_data
//	//--- Nuovo Item
//					ktvi_treeviewitem.selected = false
//					k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//	//--- salvo handle del item appena inserito nella stessa struttura
//					kst_treeview_data.handle = k_handle_item
//					k_handle_primo = k_handle_item
//	//--- inserisco il handle di questa riga tra i dati del item
//					ktvi_treeviewitem.data = kst_treeview_data
//					kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//				end if
//	
//				k_totale = k_totale + kst_treeview_data_any.contati
//	
//				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
//					k_mese = 13
//					kst_tab_meca.data_int = date(k_anno,01,01)
//				else			
//					kst_tab_meca.data_int = date(k_anno,k_mese,01)
//				end if
//				
//				kst_treeview_data.label = &
//										  k_mese_desc[k_mese]  &
//										  + "  " &
//										  + string(k_anno) 
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
//				if kst_treeview_data_any.contati = 1 then
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carico presente"
//				else
//					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carichi presenti"
//				end if
//			  	if k_tipo_oggetto_padre = kist_treeview_oggetto.meca_err_mese_giri then
//					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//						                               + " con numero cicli non previsti!  "
//				else
//					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//						                               + " con Anomalia  "
//				end if
//				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data.struttura = kst_treeview_data_any
//
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
////	
////k_rc = kitv_tv1.CollapseItem ( k_handle_item )			
//
//				fetch kc_treeview 
//					into
//					  :kst_treeview_data_any.contati
//					 ,:k_mese
//					 ,:k_anno
//					  ;
//	
//			loop
//
////--- giro finale per totale anno
//			if k_totale > 0 then
//		
////--- Estrazione del primo Item, quello dei totali
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data
//				kst_treeview_data_any = kst_treeview_data.struttura
//				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
////--- Aggiorno il primo Item con i totali
//				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
//				k_totale = 0
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
//				ktvi_treeviewitem.data = kst_treeview_data
//				k_handle_item = kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
//			end if
//			
//			
//			close kc_treeview;
//			
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_meca_note_lav_ok (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_armo_tree kuf1_armo_tree

kuf1_armo_tree = create kuf_armo_tree

k_return = kuf1_armo_tree.u_tree_riempi_treeview_lav_ok ( ki_this, k_tipo_oggetto )

destroy kuf1_armo_tree

return k_return
////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
//string k_tipo_oggetto_padre, k_dataoggix
//string k_tipo_record
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//st_tab_treeview kst_tab_treeview
//st_tab_meca kst_tab_meca
//st_tab_barcode kst_tab_barcode, kst_tab_barcode_nullo
//kuf_base kuf1_base
//
//
//
//declare kc_treeview cursor for
//	SELECT distinct
//	      'dosimetria',
//			num_int,
//			data_int,
//         dosim_data,   
//         dosim_dose,   
//         err_lav_ok,   
//         note_lav_ok,
//         meca_dosim.dosim_assorb,  
//         meca_dosim.dosim_spessore,  
//         meca_dosim.dosim_rapp_a_s,  
//         meca_dosim.dosim_lotto_dosim,  
//			date(0),
//			'0',
//			' ',
//			0,
//			0,
//			0,
//			0
//    FROM meca left outer join meca_dosim on
//	      meca.id = meca_dosim.id_meca
//    WHERE 
//		  	meca.id = :kst_treeview_data_any.st_tab_meca.id
//	union all
//	SELECT distinct 
//	      'lavorazione',
//			barcode.num_int,
//			barcode.data_int,
//			date(0),
//			0,
//			'0',
//			' ',
//			0,
//			0,
//			0,
//			' ',
//			barcode.data_lav_fin,
//			barcode.err_lav_fin,
//			barcode.note_lav_fin,
//         barcode.lav_fila_1,  
//         barcode.lav_fila_1p,  
//         barcode.lav_fila_2,  
//         barcode.lav_fila_2p  
//    FROM barcode
//    WHERE 
//		  	barcode.id_meca = :kst_treeview_data_any.st_tab_meca.id
//	 using sqlca;
//
//		 
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//
//	
////--- valorizzo campi tabella
//	kst_treeview_data_any = kst_treeview_data.struttura
//	
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if (k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si) &
//		and kst_treeview_data_any.st_tab_meca.id > 0 then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
//			k_pic_list = kst_tab_treeview.pic_list
//		end if
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//			 
//		open kc_treeview;
//		
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					 :k_tipo_record
//					,:kst_tab_meca.num_int   
//					,:kst_tab_meca.data_int   
//         		,:kst_tab_meca.dosim_data   
//					,:kst_tab_meca.dosim_dose
//         		,:kst_tab_meca.err_lav_ok   
//         		,:kst_tab_meca.note_lav_ok  
//					,:kst_tab_meca.dosim_assorb  
//					,:kst_tab_meca.dosim_spessore  
//					,:kst_tab_meca.dosim_rapp_a_s  
//					,:kst_tab_meca.dosim_lotto_dosim  
//         		,:kst_tab_barcode.data_lav_fin   
//         		,:kst_tab_barcode.err_lav_fin   
//         		,:kst_tab_barcode.note_lav_fin  
//					,:kst_tab_barcode.lav_fila_1  
//					,:kst_tab_barcode.lav_fila_1p  
//					,:kst_tab_barcode.lav_fila_2  
//					,:kst_tab_barcode.lav_fila_2p  
//					  ;
//	
//			
//			do while sqlca.sqlcode = 0
//
////--- tratto i dati barcode
//				if k_tipo_record = "lavorazione" then			
//					kst_tab_barcode.num_int = kst_tab_meca.num_int   
//					kst_tab_barcode.data_int = kst_tab_meca.data_int   
//				else
//					kst_tab_barcode = kst_tab_barcode_nullo
//				end if
//
//		  		if isnull(kst_tab_meca.num_int) then
//					kst_tab_meca.num_int = 0
//				end if
//		      if isnull(kst_tab_meca.note_lav_ok) then
//					kst_tab_meca.note_lav_ok = " "
//				end if
//		      if isnull(kst_tab_meca.err_lav_ok) then
//					kst_tab_meca.err_lav_ok = "0"
//				end if
//		      if isnull(kst_tab_meca.dosim_dose) then
//					kst_tab_meca.dosim_dose = 0
//				end if
//		      if isnull(kst_tab_meca.dosim_data) then
//					kst_tab_meca.dosim_data = date(0)
//				end if
//				
//				kst_treeview_data_any.st_tab_meca = kst_tab_meca
//				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
//
//				kst_tab_treeview.voce =  &
//				                    string(kst_tab_meca.num_int, "####0") &
//				                    + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") 
//				
//				if k_tipo_record = "dosimetria" then			
//					kst_tab_treeview.descrizione_tipo = "Dati Dosimetria" 
//				else
//					kst_tab_treeview.descrizione_tipo = "Dati Giri di lavorazione" 
//				end if
//
////---
//				if k_tipo_record = "lavorazione" then			
//					if kst_tab_barcode.data_lav_fin > date (0) then
//						if kst_tab_barcode.err_lav_fin = "1" then
//							if kst_tab_meca.cert_forza_stampa = "1" then
//								kst_tab_treeview.descrizione = "Lavorazione KO->OK " 
//							else
//								kst_tab_treeview.descrizione = "Lavorazione KO! " 
//							end if
//						else
//							kst_tab_treeview.descrizione = "Lavorazione esitata il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yy") 
//						end if
//					else
//						kst_tab_treeview.descrizione = "Da trattare " 
//					end if
//				else
//					if kst_tab_meca.dosim_data > date (0) then
//						if kst_tab_meca.err_lav_ok = "1" then
//							if kst_tab_meca.cert_forza_stampa = "1" then
//								kst_tab_treeview.descrizione = "Dosimetria KO->OK " 
//							else
//								kst_tab_treeview.descrizione = "Dosimetria KO! " 
//							end if
//						else
//							kst_tab_treeview.descrizione = "Dosimetria convalidata il " + string(kst_tab_meca.dosim_data, "dd/mm/yy") 
//						end if
//					else
//						kst_tab_treeview.descrizione = "Dosimetria da convalidare " 
//					end if
//				end if
//				
//				if k_tipo_record = "lavorazione" then			
//					if kst_tab_barcode.data_lav_fin > date (0) then
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  + "  giri " 
//						if kst_tab_barcode.lav_fila_1 > 0 or kst_tab_barcode.lav_fila_1p > 0 then
//							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  + " " + string(kst_tab_barcode.lav_fila_1, "##0") &
//												  + "+" + string(kst_tab_barcode.lav_fila_1p, "##0") 
//						end if
//						if kst_tab_barcode.lav_fila_2 > 0 or kst_tab_barcode.lav_fila_2p > 0 then
//							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
//												  +  " " + string(kst_tab_barcode.lav_fila_2, "##0") &
//												  + "+" + string(kst_tab_barcode.lav_fila_2p, "##0") 
//						end if
//					end if
//					kst_tab_treeview.descrizione_ulteriore =  &
//											  + "Note: " + trim(kst_tab_barcode.note_lav_fin) 
//
//				else
//				
//					if kst_tab_meca.dosim_data > date (0) then
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) + "   Dati dosim. " & 
//												  + " ass." + string(kst_tab_meca.dosim_assorb, "##,###") &
//												  + " / sp." + string(kst_tab_meca.dosim_spessore, "##,###") &
//												  + " = " + string(kst_tab_meca.dosim_rapp_a_s, "##,##0.00") &
//												  + " del " + string(kst_tab_meca.dosim_data, "dd.mm.yy") &
//												  + " lotto " + trim(kst_tab_meca.dosim_lotto_dosim) 
//						if kst_tab_meca.dosim_dose > 0 then
//							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione &
//											+ "  Dose Irragg. " + string(kst_tab_meca.dosim_dose, "#0.00") + " "
//						end if
//						kst_tab_treeview.descrizione_ulteriore =  &
//											+ "   Note: " + trim(kst_tab_meca.note_lav_ok) 
//					end if
//				end if
//				
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				if k_tipo_record = "lavorazione" then			
//					if kst_tab_barcode.data_lav_fin > date (0) then
//						if kst_tab_barcode.err_lav_fin = "1" then
//							if kst_tab_meca.cert_forza_stampa = "1" then
//				
//								kst_treeview_data.label = "Lavorazione KO->OK " 
//							else
//								kst_treeview_data.label = "Lavorazione KO! " 
//							end if
//						else
//							kst_treeview_data.label = "Lavorazione ok "
//						end if
//					else
//						kst_treeview_data.label = "Da trattare " 
//					end if
//				else
//					if kst_tab_meca.dosim_data > date (0) then
//						if kst_tab_meca.err_lav_ok = "1" then
//							if kst_tab_meca.cert_forza_stampa = "1" then
//								kst_treeview_data.label = "Dosimetria KO->OK " 
//							else
//								kst_treeview_data.label = "Dosimetria KO! " 
//							end if
//						else
//							kst_treeview_data.label = "Dosimetria ok " 
//						end if
//					else
//						kst_treeview_data.label = "Dosimetria da convalidare " 
//					end if
//				end if
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//
//				kst_treeview_data.pic_list = k_pic_list
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//	
//				fetch kc_treeview 
//				into
//					 :k_tipo_record
//					,:kst_tab_meca.num_int   
//					,:kst_tab_meca.data_int   
//         		,:kst_tab_meca.dosim_data   
//					,:kst_tab_meca.dosim_dose
//         		,:kst_tab_meca.err_lav_ok   
//         		,:kst_tab_meca.note_lav_ok  
//					,:kst_tab_meca.dosim_assorb  
//					,:kst_tab_meca.dosim_spessore  
//					,:kst_tab_meca.dosim_rapp_a_s  
//					,:kst_tab_meca.dosim_lotto_dosim  
//         		,:kst_tab_barcode.data_lav_fin   
//         		,:kst_tab_barcode.err_lav_fin   
//         		,:kst_tab_barcode.note_lav_fin  
//					,:kst_tab_barcode.lav_fila_1  
//					,:kst_tab_barcode.lav_fila_1p  
//					,:kst_tab_barcode.lav_fila_2  
//					,:kst_tab_barcode.lav_fila_2p  
//					  ;
//	
//	
//			loop
//			
//			close kc_treeview;
//		end if
//
//	end if 
// 
//return k_return
//
//
end function

private function integer u_riempi_treeview_pl_barcode_gener (string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0
kuf_pl_barcode_tree kuf1_pl_barcode_tree

kuf1_pl_barcode_tree = create kuf_pl_barcode_tree

k_return = kuf1_pl_barcode_tree.u_tree_riempi_treeview_gener ( ki_this, k_tipo_oggetto )

destroy kuf1_pl_barcode_tree

return k_return
/////
////--- Visualizza Treeview
////
//integer k_return = 0, k_rc
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//integer k_ctr, k_ctr_label_desc, k_pic_close, k_pic_open
//string k_tipo_oggetto_padre
//date k_save_data_int
//string k_label_desc [10,3], k_anno_mese
//treeviewitem ktvi_treeviewitem
//st_esito kst_esito
//st_tab_treeview kst_tab_treeview
//st_treeview_data kst_treeview_data
//st_treeview_data_any kst_treeview_data_any
//
//
//
//
//		 
////--- Ricavo il handle del Padre e il tipo Oggetto
////	k_handle_item_padre = kitv_tv1.finditem(CurrentTreeItem!, 0)
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//		kst_treeview_data_any =	kst_treeview_data.struttura 
//		kst_tab_treeview = kst_treeview_data_any.st_tab_treeview 
//		k_anno_mese = kst_tab_treeview.id
//	else
//		k_handle_item_padre = kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 or ki_forza_refresh = ki_forza_refresh_si then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//		end if
////		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
////		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
////		ktvi_treeviewitem.pictureindex = integer(kist_treeview_oggetto.barcode_pl_mese_pic_close)
////		ktvi_treeviewitem.selectedpictureindex = integer(kist_treeview_oggetto.barcode_pl_mese_pic_open)
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		
//	
//		k_label_desc[1,1] = "In allestimento"
//		k_label_desc[1,2] = "Piano di Lavoro in costruzione "
//		k_label_desc[1,3] = kist_treeview_oggetto.pl_barcode_aperto
//		k_label_desc[2,1] = "Chiuso "
//		k_label_desc[2,2] = "In attesa di trasferimento al Server Pilota "
//		k_label_desc[2,3] = kist_treeview_oggetto.pl_barcode_chiuso
//		k_label_desc[3,1] = "Trasferito"
//		k_label_desc[3,2] = "Generato il file del trattamento per il Server Pilota"
//		k_label_desc[3,3] = kist_treeview_oggetto.pl_barcode_gia_pilota
//		k_label_desc[4,1] = "Sospesi"
//		k_label_desc[4,2] = "Sospesi, non trasferibili al Server Pilota per il trattamento"
//		k_label_desc[4,3] = kist_treeview_oggetto.pl_barcode_sospeso
//		k_label_desc[5,1] = "FINE"
//		k_label_desc[5,2] = "EOF"
//		k_label_desc[5,3] = " "
//			
//		k_ctr_label_desc=1
//		
//			do while k_label_desc[k_ctr_label_desc,1] <> "FINE"
//	
//				
//				kst_treeview_data.label = k_label_desc[k_ctr_label_desc,1]
//				kst_treeview_data.oggetto = k_label_desc[k_ctr_label_desc,3]
//				kst_treeview_data.handle = k_handle_item_padre
//				
//				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = k_anno_mese //--- contiene anno (4) e mese (2) del periodo da cercare
//			   kst_tab_treeview.descrizione = k_label_desc[k_ctr_label_desc,2]
//				kst_tab_treeview.descrizione_tipo = "Piani di Lavorazione" 
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
//				kst_treeview_data.struttura = kst_treeview_data_any
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
//
//				k_ctr_label_desc++
//	
//			loop
//			
//
//	end if 
// 
//return k_return
//
//
end function

public subroutine u_smista_treeview_listview ();//
//--- Visualizza Treeview
//
int k_rc
long k_riga=0
boolean k_listview = true
pointer kp_oldpointer
treeviewitem ktvi_corrente //, ktvi_figlio, ktvi_root
listviewitem klv_listviewitem
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
 

//=== Puntatore Cursore da attesa..... 
kp_oldpointer = SetPointer(HourGlass!)

//--- salva colonne listview
u_listview_salva_dim_colonne()
	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
kst_treeview_data = u_get_st_treeview_data ()
if len(trim(kst_treeview_data.oggetto)) > 0 then
else
	kst_treeview_data.oggetto = " "
end if

if kst_treeview_data.handle > 0 then
else
	 kst_treeview_data.handle = kitv_tv1.finditem(RootTreeItem!, 0)
//--- se non esiste nulla allora inizializzo ROOT
	if  kst_treeview_data.handle > 0 then
	else
		kst_treeview_data.oggetto = "root"
	end if
end if

if kist_treeview_data_precedente <> kst_treeview_data or ki_forza_refresh = ki_forza_refresh_SI then

	kist_treeview_data_precedente = kst_treeview_data
	
	kist_treeview_oggetto.oggetto = trim(lower(kst_treeview_data.oggetto))

//--- entra nella funzione desiderata x ramo TREEVIEW
		choose case kist_treeview_oggetto.oggetto
						  
			case kist_treeview_oggetto.nullo
				//--- nulla in questo caso					  

//--- Gestione Barcode
			case kist_treeview_oggetto.barcode 
				//--- nulla in questo caso					  

			case kist_treeview_oggetto.barcode_no_st_dett &
				, kist_treeview_oggetto.barcode_no_st_root_dett
				u_riempi_treeview_meca_barcode_da_stamp (kist_treeview_oggetto.oggetto)							 
				
			case  &
			 	  kist_treeview_oggetto.barcode_gia_st_dett, &
			     kist_treeview_oggetto.barcode_gia_pl_dett, &
			     kist_treeview_oggetto.barcode_pl_chiuso_dett, &
			     kist_treeview_oggetto.barcode_trattati_dett, &
			     kist_treeview_oggetto.barcode_ok_dett, &
			     kist_treeview_oggetto.barcode_ko_dett, &
			     kist_treeview_oggetto.barcode_sosp_dett, & 
			     kist_treeview_oggetto.barcode_tutti_dett 
				u_riempi_treeview_meca_barcode &
								 (kist_treeview_oggetto.oggetto)
				
			case kist_treeview_oggetto.barcode_anno_mese &
			    ,kist_treeview_oggetto.barcode_stor_mese 
				u_riempi_treeview_barcode_data &
								 (kist_treeview_oggetto.oggetto)
								 
//			case kist_treeview_oggetto.barcode_mese &
//			    ,kist_treeview_oggetto.barcode_mese_dett
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)


//--- Gestione Piani di Lavorazione				 
			case kist_treeview_oggetto.pl_barcode_mese
				u_riempi_treeview_pl_barcode_mese &
								 (kist_treeview_oggetto.oggetto)
//			case kist_treeview_oggetto.pl_barcode_mese_dett
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.pl_barcode_aperto_dett &
					,kist_treeview_oggetto.pl_barcode_sospeso_dett &
					,kist_treeview_oggetto.pl_barcode_gia_pilota_dett &
					,kist_treeview_oggetto.pl_barcode_chiuso_dett &
					,kist_treeview_oggetto.pl_barcode_respinto_dett
				u_riempi_treeview_pl_barcode_dett &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.pl_barcode_meca
				u_riempi_treeview_meca_barcode &
								 (kist_treeview_oggetto.oggetto)


//--- Gestione Riferimenti
//			case kist_treeview_oggetto.meca &
//				  ,kist_treeview_oggetto.meca_car_dett &
//				  ,kist_treeview_oggetto.meca_car_lav_ok 
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)
//			case kist_treeview_oggetto.armo_tipo
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_anno_mese &
			    ,kist_treeview_oggetto.meca_stor_mese
				u_riempi_treeview_meca_mese &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_dett &
					,kist_treeview_oggetto.meca_dett_id_meca &
					,kist_treeview_oggetto.meca_car_meca_dett &
					,kist_treeview_oggetto.meca_blk_dett &
					,kist_treeview_oggetto.meca_err_mese_all_dett &
					,kist_treeview_oggetto.meca_da_associare_wm_dett &
					,kist_treeview_oggetto.meca_dett_nodose &
					,kist_treeview_oggetto.meca_trasferiti_dapkl &
					,kist_treeview_oggetto.meca_qtna_dett &
					,kist_treeview_oggetto.meca_no_e1asn_dett &
 					,kist_treeview_oggetto.meca_no_e1bcode_dett &
 					,kist_treeview_oggetto.meca_no_e1bcodeass_dett &
 					,kist_treeview_oggetto.meca_no_e1accettato_dett 
 				u_riempi_treeview_meca_dett &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.armo
				u_riempi_treeview_armo &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_car_ft_dett &
					,kist_treeview_oggetto.armo_tipo_ft_dett
				u_riempi_treeview_fatt_dett &
						 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_car_sp_dett
				u_riempi_treeview_sped &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_car_nt_dett
				u_riempi_treeview_meca_note_lav_ok & 
								 (kist_treeview_oggetto.barcode_dett)

//--- Gestione Dosimetrie
//			case kist_treeview_oggetto.meca_lav &
//			     ,kist_treeview_oggetto.meca_err &
//				  ,kist_treeview_oggetto.meca_lav_att &
//				  ,kist_treeview_oggetto.meca_lav_ko
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_lav_mese_ko &
				  ,kist_treeview_oggetto.meca_lav_mese_ok 
				u_riempi_treeview_meca_mese &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_err_mese_giri &
				 ,kist_treeview_oggetto.meca_err_mese_all 
				u_riempi_treeview_meca_err_mese_giri &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_err_mese_giri_dett 
				u_riempi_treeview_meca_dett &
								 (kist_treeview_oggetto.oggetto)
			case  &
			     kist_treeview_oggetto.meca_lav_mese_ko_dett &
				  ,kist_treeview_oggetto.meca_lav_ko_da_sblk_dett &
				  ,kist_treeview_oggetto.meca_lav_mese_ok_dett &
				  ,kist_treeview_oggetto.meca_lav_mese_att_dett &
				  ,kist_treeview_oggetto.meca_lav_att_prima_dett &
				  ,kist_treeview_oggetto.meca_lav_att_aut_ko_dett & 
				  ,kist_treeview_oggetto.meca_lav_dett 
				u_riempi_treeview_meca_dosim_dett &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.meca_car_cert_dett
				u_riempi_treeview_certif_dett &
								 (kist_treeview_oggetto.oggetto)
								  


//--- Gestione Attestati
//			case kist_treeview_oggetto.certif
//				u_riempi_treeview_root &
//								 (kist_treeview_oggetto.oggetto)

			case kist_treeview_oggetto.certif_in_lav_dett &
			   ,kist_treeview_oggetto.certif_da_conv_dett &
				,kist_treeview_oggetto.certif_da_st_dett &
				,kist_treeview_oggetto.certif_da_st_farma_dett &
				,kist_treeview_oggetto.certif_da_st_alimen_dett &
				,kist_treeview_oggetto.certif_da_st_sd_dett &
			   ,kist_treeview_oggetto.certif_err_dett
				u_riempi_treeview_artr_dett &
								 (kist_treeview_oggetto.oggetto)

			case kist_treeview_oggetto.certif_st_mese &
					,kist_treeview_oggetto.certif_st_giorno
				u_riempi_treeview_certif_mese &
								 (kist_treeview_oggetto.oggetto)

			case kist_treeview_oggetto.certif_st_dett
				u_riempi_treeview_certif_dett &
								 (kist_treeview_oggetto.oggetto)


//--- Gestione Spedizioni
			case kist_treeview_oggetto.sped_da_st_dett &
				,kist_treeview_oggetto.sped_dett &
				,kist_treeview_oggetto.sped_da_ft_dett &
				,kist_treeview_oggetto.sped_clie_3_da_ft_dett &
				,kist_treeview_oggetto.sped_pagam_da_ft_dett &
				,kist_treeview_oggetto.sped_clie_3_da_ft &
				,kist_treeview_oggetto.sped_pagam_da_ft &
				,kist_treeview_oggetto.sped_anno_mese &
				,kist_treeview_oggetto.sped_stor_mese
				u_riempi_treeview_sped  (kist_treeview_oggetto.oggetto)


//--- Gestione Fatture
			case kist_treeview_oggetto.fattura_anno_mese &
			    ,kist_treeview_oggetto.fattura_stor_mese
				u_riempi_treeview_fatt_mese &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.fattura_testa &
			    ,kist_treeview_oggetto.fattura_dett_da_st
				u_riempi_treeview_fatt_testa &
								 (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.fattura_dett 
				u_riempi_treeview_fatt_dett &
								 (kist_treeview_oggetto.oggetto)


//--- Gestione Anagrafiche
			case kist_treeview_oggetto.anag_alfa 
				u_riempi_treeview_anag_alfa (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.anag 
				u_riempi_treeview_anag (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.anag_dett_anno_mese & 
					,kist_treeview_oggetto.anag_dett_stor_mese 
				u_riempi_treeview_meca_mese (kist_treeview_oggetto.oggetto)
			case kist_treeview_oggetto.anag_dett_anno_mese_dett &
				,kist_treeview_oggetto.anag_dett_stor_mese_dett 
				u_riempi_treeview_meca_dett (kist_treeview_oggetto.oggetto)

//--- Gestione Packing List Mandante				 
			case kist_treeview_oggetto.pklist_anno_mese &
				, kist_treeview_oggetto.pklist_da_imp &
				, kist_treeview_oggetto.pklist_dett_da_imp &
				, kist_treeview_oggetto.pklist_dett
				u_riempi_treeview_pkl (kist_treeview_oggetto.oggetto)

//--- Gestione Packing List Grezzo (su WM) del Mandante				 
			case  &
				  kist_treeview_oggetto.pklist_wm_da_imp 
				u_riempi_treeview_pkl (kist_treeview_oggetto.oggetto)

//--- Gestione Packing List Mandante fatto da WEB 
			case  &
				  kist_treeview_oggetto.pklist_wm_da_web_dett 
				u_riempi_treeview_pkl (kist_treeview_oggetto.oggetto)

//--- Gestione File Documenti 
			case  kist_treeview_oggetto.file_root &
					,kist_treeview_oggetto.file_dett
				if u_riempi_treeview_file (kist_treeview_oggetto.oggetto) = 0 then
					k_listview = false
				end if

			case else
//--- nel caso di auto-generazione del tree allora piglio il valore dell'oggetto ID ovvero il 'PADRE'				
//--- solo pero' se ha figli altrimenti NISBA! 
				kst_tab_treeview.id = kist_treeview_oggetto.oggetto
				u_select_tab_treeview(kst_tab_treeview, "")
				if kst_tab_treeview.presenza_figli then
					
//					if len(trim(kst_treeview_data.oggetto_padre)) > 0 then
//						kst_tab_treeview.id = lower( trim(kst_treeview_data.oggetto_padre))
//					else
//					end if
					
//					if len(trim(kst_treeview_data.oggetto_padre)) > 0 then
//						u_riempi_treeview_root (lower( trim(kst_treeview_data.oggetto_padre)))
//					else
						u_riempi_treeview_root (kist_treeview_oggetto.oggetto)
//					end if
				end if
				
		end choose
		
		

//--- LISTVIEW ------------------------------------------------------------------------------------------------	
		if k_listview then
			choose case kist_treeview_oggetto.oggetto
							  
				case kist_treeview_oggetto.nullo
					//--- nulla in questo caso					  
	
									  
	//--- Gestione "ramo" BARCODE
				case kist_treeview_oggetto.barcode_no_st_dett, &
					  kist_treeview_oggetto.barcode_gia_st_dett, &
					  kist_treeview_oggetto.barcode_gia_pl_dett, &
					  kist_treeview_oggetto.barcode_pl_chiuso_dett, &
					  kist_treeview_oggetto.barcode_trattati_dett, &
					  kist_treeview_oggetto.barcode_ok_dett, &
					  kist_treeview_oggetto.barcode_ko_dett, &
					  kist_treeview_oggetto.barcode_sosp_dett, &
					  kist_treeview_oggetto.barcode_tutti_dett, &
					  kist_treeview_oggetto.barcode_no_st_root_dett
					u_riempi_listview_barcode_gener &
							 (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.barcode_dett, &
					  kist_treeview_oggetto.barcode_armo &
					 ,kist_treeview_oggetto.dosim_dett 
					u_riempi_listview_barcode &
							 (kist_treeview_oggetto.oggetto)
					 
							  
	
	//--- Gestione "ramo" P.L.				
				case kist_treeview_oggetto.pl_barcode_meca
					u_riempi_listview_barcode_gener &
							 (kist_treeview_oggetto.oggetto)
							  
	
	//--- Gestione "ramo" Dosimetrie				
				case  &								  
					  kist_treeview_oggetto.meca_err_mese_giri_dett &
					  ,kist_treeview_oggetto.meca_err_mese_all_dett 
					u_riempi_listview_meca_dett (kist_treeview_oggetto.oggetto)
				case  &								  
					  kist_treeview_oggetto.meca_lav_att_prima_dett &
					  ,kist_treeview_oggetto.meca_lav_att_aut_ko_dett &
					  ,kist_treeview_oggetto.meca_lav_ko_da_sblk_dett & 
					  ,kist_treeview_oggetto.meca_lav_mese_ko_dett &
					  ,kist_treeview_oggetto.meca_lav_mese_ok_dett &
					  ,kist_treeview_oggetto.meca_lav_mese_att_dett & 
					  ,kist_treeview_oggetto.meca_lav_dett 
					u_riempi_listview_meca_dosim_dett (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.meca_car_ft_dett
					u_riempi_listview_fatt_dett (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.meca_car_cert_dett
					u_riempi_listview_certif_dett (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.meca_car_bc_dett
					u_riempi_listview_barcode (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione "ramo" MECA				
				case &
						kist_treeview_oggetto.meca_dett  &								  
						,kist_treeview_oggetto.meca_dett_id_meca & 
						,kist_treeview_oggetto.meca_car_meca_dett &
						,kist_treeview_oggetto.meca_blk_dett &
						,kist_treeview_oggetto.meca_da_associare_wm_dett &
						,kist_treeview_oggetto.meca_dett_nodose &
						,kist_treeview_oggetto.meca_trasferiti_dapkl &
						,kist_treeview_oggetto.meca_qtna_dett &
						,kist_treeview_oggetto.meca_no_e1asn_dett &
						,kist_treeview_oggetto.meca_no_e1bcode_dett &
						,kist_treeview_oggetto.meca_no_e1bcodeass_dett &
						,kist_treeview_oggetto.meca_no_e1accettato_dett 
					u_riempi_listview_meca_dett &
							 (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.armo_tipo_sp
					u_riempi_listview_sped &
							 (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.armo_tipo_ft_dett
					u_riempi_listview_fatt_dett &
							 (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione "ramo" ARMO				
				case  &
					  kist_treeview_oggetto.armo &
					 ,kist_treeview_oggetto.dosim_dett 
					u_riempi_listview_armo &
							 (kist_treeview_oggetto.oggetto)
				case  &
					  kist_treeview_oggetto.dosim  
					u_riempi_listview_armo &
							 (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione Attestati
				case kist_treeview_oggetto.certif_in_lav_dett &
					,kist_treeview_oggetto.certif_da_conv_dett &
					,kist_treeview_oggetto.certif_da_st_dett &
					,kist_treeview_oggetto.certif_da_st_farma_dett &
					,kist_treeview_oggetto.certif_da_st_alimen_dett &
					,kist_treeview_oggetto.certif_da_st_sd_dett &
					,kist_treeview_oggetto.certif_err_dett
					u_riempi_listview_artr_dett &
							 (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.certif_st_dett
					u_riempi_listview_certif_dett &
									 (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione "ramo" SPEDIZIONI				
				case kist_treeview_oggetto.sped_da_st_dett	&						  
						,kist_treeview_oggetto.sped_dett &
						,kist_treeview_oggetto.sped_da_ft_dett &			  
						,kist_treeview_oggetto.armo_tipo_sp &
						,kist_treeview_oggetto.meca_car_sp_dett &
						  ,kist_treeview_oggetto.sped_clie_3_da_ft_dett &
						  ,kist_treeview_oggetto.sped_pagam_da_ft_dett
					u_riempi_listview_sped (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.sped_righe_dett	 			  
					u_riempi_listview_sped_righe (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione "ramo" FATTURE				
				case kist_treeview_oggetto.fattura_testa &								  
						,kist_treeview_oggetto.fattura_dett_da_st 
					u_riempi_listview_fatt_testa &
							 (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.fattura_dett	
					u_riempi_listview_fatt_dett &
							 (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione Anagrafiche
				case kist_treeview_oggetto.anag 
					u_riempi_listview_anag (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.anag_dett_anno_mese_dett &
					,kist_treeview_oggetto.anag_dett_stor_mese_dett 
					u_riempi_listview_meca_dett (kist_treeview_oggetto.oggetto)
	
	
	//--- Gestione Packing List Mandante				 
				case kist_treeview_oggetto.pklist_da_imp &
					, kist_treeview_oggetto.pklist_dett &
					, kist_treeview_oggetto.pklist_dett_da_imp &
					, kist_treeview_oggetto.pklist_wm_da_imp
					u_riempi_listview_pkl (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.pklist_righe
					u_riempi_listview_pkl_righe (kist_treeview_oggetto.oggetto)
				case kist_treeview_oggetto.pklist_wm_da_web_dett 
					u_riempi_listview_pkl (kist_treeview_oggetto.oggetto)
	
	//--- Gestione File Documenti 
				case  kist_treeview_oggetto.file_root &
						,kist_treeview_oggetto.file_dett
					u_riempi_listview_file (kist_treeview_oggetto.oggetto)
	
	//--- In tutti gli altri casi, dove non c'e' bisogno di elenco personalizzato		
				case else
					if if_item_x_listview() then
						u_riempi_listview_root (kist_treeview_oggetto.oggetto)
					end if
				
	
			end choose
		end if
		
//--- Riposizionamento sulla riga dalla quale era partita la navigazione al ramo inferiore 		
		if ki_item_selezionato = 0 then
			k_riga = u_treeview_data_item_ripristina( )
		else
			u_treeview_data_item_salva()		
			ki_item_selezionato = 0
		end if
		if k_riga = 0 then k_riga = 1
		if isvalid(kilv_lv1) then
			kilv_lv1.GetItem (k_riga, klv_listviewitem )
			kilv_lv1.ExtendedSelect = false
			klv_listviewitem.HasFocus = TRUE
			klv_listviewitem.Selected = TRUE
			kilv_lv1.SetItem(k_riga, klv_listviewitem)
			kGuf_data_base.u_listview_scroll(kilv_lv1, (k_riga + 5))		
			kilv_lv1.setfocus( )
			kilv_lv1.ExtendedSelect = true
		end if
		
//	end if

end if


//ki_flag_gia_dentro = ki_flag_gia_dentro_NO 

//=== Puntatore di default
SetPointer(Arrow!)


end subroutine

private function integer u_open_sped (string k_modalita);//
//--- Chiama la funzione richiesta
//
integer k_return = 0, k_rc = 0
integer k_ctr, k_index, k_ind
kuf_sped kuf1_sped
st_tab_sped kst_tab_sped[]
st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem




//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = this.u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = this.kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if this.kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- 
	kst_treeview_data_any = kst_treeview_data.struttura

//--- Carica tabella Fatture...					
	k_index = this.kilv_lv1.SelectedIndex()
			
//--- Cicla fino a che ci sono righe selezionate
	k_ind=1
	do while k_index > 0 //NOT k_fatt_selected_eof
				
		kst_tab_sped[k_ind] = kst_treeview_data_any.st_tab_sped
		k_ind ++
		
//--- cerco se altre righe selezionate		
		klvi_listviewitem.Selected = false
		do while not klvi_listviewitem.Selected and k_index > 0  	
			k_index++
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			else
				k_index = 0
			end if
		loop
	loop

	kuf1_sped = create kuf_sped

	k_return = kuf1_sped.u_tree_open( k_modalita, kst_tab_sped[], kidw_1)

	destroy kuf1_sped


return k_return 


end function

private subroutine u_select_tab_treeview_id_padre (string k_id_padre, ref st_tab_treeview kst_tab_treeview[100]) throws uo_exception;//
//====================================================================
//--- Legge da tab treeview con l' ID PADRE e torna un ARRAY con tutte le righe figlie
//---
//--- Inp: id_padre e array da restituire
//--- out: boolean  TRUE = trovato qlc,  FALSE= nessu figlio
//--- lancia EXCEPTION con errore come  'not_fnd'  se non esiste alcun figlio
//---
//====================================================================
 
int k_ctr=0, k_ctr1=0;
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	if not isnull(k_id_padre)  then
		
		if len(trim(k_id_padre)) = 0 then
			k_id_padre = "start"		
		else
			k_id_padre = lower(trim(k_id_padre))
		end if
		
//--- posizionamento sul ID PADRE		
		k_ctr=1
		do while k_id_padre <> kist_tab_treeview[k_ctr].id_padre &
			      and k_ctr < kki_tab_treeview_item_max
			k_ctr++
		loop

//--- se ID_PADRE trovato
		if k_id_padre = kist_tab_treeview[k_ctr].id_padre then

//--- carico nell'array di ritorno le righe del ID PADRE richiesto
			k_ctr1=1
			do while k_id_padre = kist_tab_treeview[k_ctr].id_padre &
						and k_ctr1 < 100 and k_ctr1 < kki_tab_treeview_item_max
						
				kst_tab_treeview[k_ctr1] = kist_tab_treeview[k_ctr]
				k_ctr1++
				k_ctr++ 
				
			loop
	
			if k_ctr1 > 96 then
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Tab.Navigatore (Treeview): Tabella Interna Troppo Piccola per ID_PADRE: " + lower(trim(k_id_padre))  
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if

//--- se tutto OK, chiude le righe dell'array 
			kst_tab_treeview[k_ctr1].id_padre = "*FINE*"  
			
		else
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Tab.Navigatore (Treeview): Non trovato alcun Figlio in tabella per ID_PADRE: " + lower(trim(k_id_padre)) 
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if		

	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.SQLErrText = "Tab.Navigatore (Treeview): chiave del record non valorizzata (ID_PADRE)" 
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if
	
	
		


end subroutine

private function integer u_riempi_treeview_pkl (string k_tipo_oggetto);// 
//
//--- Treeview Personalizzata
//
integer k_return = 0
kuf_wm_pklist_testa kuf1_wm_pklist_testa
//kuf_wm_pklist_web kuf1_wm_pklist_web
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
kuf_wm_pklist_file kuf1_wm_pklist_file


choose case k_tipo_oggetto
	case kist_treeview_oggetto.pklist_anno_mese
		kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
		k_return = kuf1_wm_pklist_testa.u_tree_riempi_treeview_x_mese( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_pklist_testa
		
	case kist_treeview_oggetto.pklist_wm_da_imp
		kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
		k_return = kuf1_wm_receiptgammarad.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_receiptgammarad
		
	case kist_treeview_oggetto.pklist_wm_da_web_dett
//		kuf1_wm_pklist_web = create kuf_wm_pklist_web
//		k_return = kuf1_wm_pklist_web.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )
//		destroy kuf1_wm_pklist_web
		kuf1_wm_pklist_file = create kuf_wm_pklist_file
		k_return = kuf1_wm_pklist_file.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_pklist_file
		
	case else
		kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
		k_return = kuf1_wm_pklist_testa.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_pklist_testa
		
end choose



return k_return

end function

private function integer u_riempi_listview_pkl (string k_tipo_oggetto);// 
//
//--- Treeview Personalizzata
//
integer k_return = 0
kuf_wm_pklist_testa kuf1_wm_pklist_testa
//kuf_wm_pklist_web kuf1_wm_pklist_web
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
kuf_wm_pklist_file kuf1_wm_pklist_file


choose case k_tipo_oggetto
	case kist_treeview_oggetto.pklist_wm_da_imp
		kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
		k_return = kuf1_wm_receiptgammarad.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_receiptgammarad
		
	case kist_treeview_oggetto.pklist_wm_da_web_dett
//		kuf1_wm_pklist_web = create kuf_wm_pklist_web
//		k_return = kuf1_wm_pklist_web.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
//		destroy kuf1_wm_pklist_web
		kuf1_wm_pklist_file = create kuf_wm_pklist_file
		k_return = kuf1_wm_pklist_file.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_pklist_file

	case else
		kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
		k_return = kuf1_wm_pklist_testa.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
		destroy kuf1_wm_pklist_testa
		
end choose



return k_return

end function

private function boolean if_item_x_listview ();//
//--- Verfica se ci sono item da visualizzare nella Listview
//--- Torna TRUE=ok ci sono; FALSE=non c'e' nulla
//
//
boolean k_return=false
long k_handle_item = 0, k_handle_item_corrente
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_treeview_data kst_treeview_data


	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente <= 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
	if k_handle_item_corrente > 0 then

		kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		if k_handle_item > 0 then
			k_return=TRUE	
		end if
	end if
	
	return k_return
	
	
end function

private function integer u_riempi_listview_pkl_righe (string k_tipo_oggetto);// 
//
//--- Treeview Personalizzata
//
integer k_return = 0
kuf_wm_pklist_righe kuf1_wm_pklist_righe

kuf1_wm_pklist_righe = create kuf_wm_pklist_righe

//choose case k_tipo_oggetto
//	case kist_treeview_oggetto.pklist_anno_mese
//		k_return = kuf1_wm_pklist_righe.u_tree_riempi_treview_x_mese( ki_this, k_tipo_oggetto )
		
//	case else
		k_return = kuf1_wm_pklist_righe.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
		
//end choose


destroy kuf1_wm_pklist_righe

return k_return

end function

private function integer u_open_wm_pklist (string k_modalita);//
//--- Chiama la funzione richiesta
//
integer k_return = 0, k_rc = 0
integer k_ctr, k_index, k_ind
kuf_wm_pklist kuf1_wm_pklist
st_wm_pklist kst_wm_pklist[]
st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem




//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = this.u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = this.kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if this.kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- 
	kst_treeview_data_any = kst_treeview_data.struttura

//--- 				
	k_index = this.kilv_lv1.SelectedIndex()
			
//--- Cicla fino a che ci sono righe selezionate
	k_ind=1
	kst_wm_pklist[k_ind].st_tab_wm_pklist.id_wm_pklist=0   // parto con il primo inizializzato
	do while k_index > 0 //NOT k_fatt_selected_eof
				
		kst_wm_pklist[k_ind].st_tab_wm_pklist = kst_treeview_data_any.st_tab_wm_pklist
		k_ind ++
		 
//--- cerco se altre righe selezionate		
		klvi_listviewitem.Selected = false
		do while not klvi_listviewitem.Selected and k_index > 0  	
			k_index++
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			else
				k_index = 0
			end if
		loop
	loop

	kuf1_wm_pklist = create kuf_wm_pklist

	k_return = kuf1_wm_pklist.u_tree_open( k_modalita, kst_wm_pklist[], kidw_1)

	destroy kuf1_wm_pklist


return k_return 


end function

private function integer u_open_wm_receiptgammarad (string k_modalita);//
//--- Chiama la funzione richiesta
//
integer k_return = 0, k_rc = 0
integer k_ctr, k_index, k_ind
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem




//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = this.u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = this.kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if this.kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- 
	kst_treeview_data_any = kst_treeview_data.struttura

//--- 				
	k_index = this.kilv_lv1.SelectedIndex()
			
//--- Cicla fino a che ci sono righe selezionate
	k_ind=1
	kst_tab_wm_receiptgammarad[k_ind].packinglistcode=""   // parto con il primo inizializzato
	do while k_index > 0 //NOT k_fatt_selected_eof
				
		kst_tab_wm_receiptgammarad[k_ind] = kst_treeview_data_any.st_tab_wm_receiptgammarad
		k_ind ++
		
//--- cerco se altre righe selezionate		
		klvi_listviewitem.Selected = false
		do while not klvi_listviewitem.Selected and k_index > 0  	
			k_index++
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			else
				k_index = 0
			end if
		loop
	loop
	k_ind --

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	
	if k_modalita = kkg_flag_modalita.cancellazione then
		if messagebox("Elimina da Wherehouse Management",  "Sei sicuro di voler eliminare  " &
		                            + string(k_ind) + "  Packing List Mandante ", question!, yesno!, 2) = 1 then
		
			k_return = kuf1_wm_receiptgammarad.u_tree_open( k_modalita, kst_tab_wm_receiptgammarad[], kidw_1)

//--- tento il refresh
			this.ki_forza_refresh = this.ki_forza_refresh_si
			post u_smista_treeview_listview()
			
		else
			messagebox("Elimina da Warehouse Management",  "Operazione Annullata !!")
		end if
	else
//---- altre funzioni		
		k_return = kuf1_wm_receiptgammarad.u_tree_open( k_modalita, kst_tab_wm_receiptgammarad[], kidw_1)
		
	end if
	destroy kuf1_wm_receiptgammarad


return k_return 


end function

private function integer u_open_wm_pklist_web (string k_modalita);//
//--- Chiama la funzione richiesta
//
integer k_return = 0, k_rc = 0
integer k_ctr, k_index, k_ind
kuf_wm_pklist_web kuf1_wm_pklist_web
st_wm_pklist kst_wm_pklist[]
st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem




//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = this.u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = this.kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if this.kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- 
	kst_treeview_data_any = kst_treeview_data.struttura

//--- 				
	k_index = this.kilv_lv1.SelectedIndex()
			
//--- Cicla fino a che ci sono righe selezionate
	k_ind=1
	kst_wm_pklist[k_ind].st_wm_pkl_web.idpkl=0   // parto con il primo inizializzato
	do while k_index > 0 //NOT k_fatt_selected_eof
				
		kst_wm_pklist[k_ind].st_wm_pkl_web = kst_treeview_data_any.st_wm_pkl_web
		k_ind ++
		 
//--- cerco se altre righe selezionate		
		klvi_listviewitem.Selected = false
		do while not klvi_listviewitem.Selected and k_index > 0  	
			k_index++
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			else
				k_index = 0
			end if
		loop
	loop

	kuf1_wm_pklist_web = create kuf_wm_pklist_web

	k_return = kuf1_wm_pklist_web.u_tree_open( k_modalita, kst_wm_pklist[], kidw_1)

	destroy kuf1_wm_pklist_web


return k_return 


end function

public subroutine u_refresh ();//
//
//
long k_handle_item=0, k_handle_item_padre


	k_handle_item = u_dammi_item_padre_da_list()
	if k_handle_item > 0 then

		if kitv_tv1.SelectItem(k_handle_item) > 0 then //, ktvi_1) > 0 then

			ki_fuoco_tree_list = ki_fuoco_su_tree
			ki_forza_refresh = ki_forza_refresh_si
			ki_flag_gia_dentro = ki_flag_gia_dentro_NO 
			u_smista_treeview_listview( )
			ki_forza_refresh = ki_forza_refresh_NO

		end if
		
	end if

end subroutine

public subroutine set_kitv_tv1 (ref treeview ktv_tv1);//
kitv_tv1 = ktv_tv1

end subroutine

public subroutine set_kilv_lv1 (ref listview klv_lv1);//
kilv_lv1  = klv_lv1 

end subroutine

public subroutine set_dw_anteprima (ref datawindow kdw_1);//
kidw_1  = kdw_1 

end subroutine

public subroutine u_treeview_data_item_salva ();//
long k_item, k_handle, k_i
st_treeview_data kst_treeview_data
treeviewitem ktv_treeviewitem
listviewitem klv_listviewitem

if isvalid(kitv_tv1) then
		
	kilv_lv1.getitem(1, klv_listviewitem) 
//	if k_handle > 0 then 

		k_item = ki_item_selezionato

//--- 
		kst_treeview_data = klv_listviewitem.data 
		k_handle = kst_treeview_data.handle	
		if k_handle > 0 then 

//			kitv_tv1.getitem(k_handle, ktv_treeviewitem) 
//			kst_treeview_data = ktv_treeviewitem.data 
		
			if k_item = 1 then
				kst_treeview_data.item = 0
			else
				kst_treeview_data.item = k_item
			end if
		
//--- carica in array la riga per il posizionamento	
			k_i = 1
			do until ki_tab_item_selezionato[k_i,1] = k_handle &
						or ki_tab_item_selezionato[k_i,1] = 0 &
						or k_i = 200		
				k_i ++  
			loop
			if k_i = 200 then k_i = 1
			ki_tab_item_selezionato[k_i, 1] = k_handle  // carica la chiave (il puntatore alla riga)
			ki_tab_item_selezionato[k_i, 2] = k_item //carica la riga su cui posizionarsi 
			
//			ktv_treeviewitem.data = kst_treeview_data
//			kitv_tv1.setitem( k_handle, ktv_treeviewitem)
		
		end if
//	end if

end if


end subroutine

public function long u_treeview_data_item_ripristina ();//
long k_item=0, k_i, k_handle=0
st_treeview_data kst_treeview_data
listviewitem klv_listviewitem
treeviewitem ktv_treeviewitem


if isvalid(kilv_lv1) then
		
	kilv_lv1.getitem(1, klv_listviewitem) 
		
	if isvalid(klv_listviewitem.data) then	
		kst_treeview_data = klv_listviewitem.data 
		
////////--- piglia il nr riga (item) del PADRE 		
		k_handle = kst_treeview_data.handle
		if k_handle > 0 then
//--- Ripristina dall'array la riga per il posizionamento	
			k_i = 1
			do until ki_tab_item_selezionato[k_i,1] = k_handle &
						or k_i = 200		
				k_i ++  
			loop
			if k_i < 200 then 
				k_item = ki_tab_item_selezionato[k_i, 2] 
				ki_tab_item_selezionato[k_i, 2] = 0
			end if
		end if	
		
//		kitv_tv1.getitem(k_item, ktv_treeviewitem) 
//		kst_treeview_data = ktv_treeviewitem.data 
//		k_item = kst_treeview_data.item 
		
	end if

end if

return k_item

end function

public subroutine u_treeview_item_salva ();//
if isvalid(kilv_lv1) then
		
		ki_item_selezionato = kilv_lv1.selectedindex( )

end if


end subroutine

public function st_esito u_crea_treeview_prod ();//-----------------------------------------------------------------------------------------------------------------------------
//--- Crea la tab treeview_prod che è poi quella utilizzata in produzione dagli Utenti per Lavorare
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//---                              100=not found
//---                                 1=errore grave
//---                                 2=errore > 0
//--- 
//------------------------------------------------------------------------------------------------------------------------------
int k_ctr=0, k_ctr1
string k_ddl = "", k_presenza_figli="0"
st_esito kst_esito
st_tab_treeview kst_tab_treeview_nulla, kst_tab_treeview
st_tab_treeview kst_tab_treeview_array[]


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname( )

   DECLARE kcursor_all CURSOR FOR  
	  SELECT treeview.tipo_menu,   
				treeview.id,   
				treeview.descrizione_tipo,   
				treeview.descrizione,   
				treeview.livello,   
				treeview.sequenza,   
				treeview.tipo_voce,   
				treeview.voce,   
				treeview.id_padre as id_padre,   
				treeview.funzione,   
				treeview.pic_open,   
				treeview.pic_close,   
				treeview.pic_list,   
				treeview.id_programma,  
				treeview.open_programma,
				treeview.nome_oggetto
		 FROM treeview  
		 where tipo_menu = 'A'
	ORDER BY id_padre ASC   
            ,treeview.livello ASC
				,treeview.sequenza ASC
				,treeview.voce ASC
				using sqlca;

	open kcursor_all;
	if sqlca.sqlcode = 0 then
			
		fetch kcursor_all INTO 
				:kst_tab_treeview.tipo_menu,
				:kst_tab_treeview.id,   
				:kst_tab_treeview.descrizione_tipo,   
				:kst_tab_treeview.descrizione,   
				:kst_tab_treeview.livello,   
				:kst_tab_treeview.sequenza,   
				:kst_tab_treeview.tipo_voce,   
				:kst_tab_treeview.voce,   
				:kst_tab_treeview.id_padre,   
				:kst_tab_treeview.funzione,   
				:kst_tab_treeview.pic_open,   
				:kst_tab_treeview.pic_close,   
				:kst_tab_treeview.pic_list,   
				:kst_tab_treeview.id_programma,
				:kst_tab_treeview.open_programma,
				:kst_tab_treeview.nome_oggetto;

		
		do while sqlca.sqlcode = 0 and k_ctr < kki_tab_treeview_item_max 
		
			k_ctr++
			kst_tab_treeview_array[k_ctr] = kst_tab_treeview
			if isnull(kst_tab_treeview.id) then kst_tab_treeview_array[k_ctr].id = " " else kst_tab_treeview_array[k_ctr].id = lower(trim(kst_tab_treeview.id))
			if isnull(kst_tab_treeview.id_padre) then kst_tab_treeview_array[k_ctr].id_padre = " " else kst_tab_treeview_array[k_ctr].id_padre =  lower(trim(kst_tab_treeview.id_padre))
			if isnull(kst_tab_treeview.id_programma) then kst_tab_treeview_array[k_ctr].id_programma = " " else kst_tab_treeview_array[k_ctr].id_programma = lower(trim(kst_tab_treeview.id_programma))
			if isnull(kst_tab_treeview.open_programma) then kst_tab_treeview_array[k_ctr].open_programma = " " else kst_tab_treeview_array[k_ctr].open_programma = trim(kst_tab_treeview.open_programma)
			if isnull(kst_tab_treeview.funzione) then kst_tab_treeview_array[k_ctr].funzione = " " else kst_tab_treeview_array[k_ctr].funzione = lower(trim(kst_tab_treeview.funzione))
			if isnull(kst_tab_treeview.descrizione_tipo) then kst_tab_treeview_array[k_ctr].descrizione_tipo = " " else kst_tab_treeview_array[k_ctr].descrizione_tipo = lower(trim(kst_tab_treeview.descrizione_tipo))
			if isnull(kst_tab_treeview.descrizione) then kst_tab_treeview_array[k_ctr].descrizione = " " else kst_tab_treeview_array[k_ctr].descrizione = lower(trim(kst_tab_treeview.descrizione))
			if isnull(kst_tab_treeview.livello) then kst_tab_treeview_array[k_ctr].livello = " " else kst_tab_treeview_array[k_ctr].livello = lower(trim(kst_tab_treeview.livello))
			if isnull(kst_tab_treeview.sequenza) then kst_tab_treeview_array[k_ctr].sequenza = " " else kst_tab_treeview_array[k_ctr].sequenza = lower(trim(kst_tab_treeview.sequenza))
			if isnull(kst_tab_treeview.tipo_voce) then kst_tab_treeview_array[k_ctr].tipo_voce = " " else kst_tab_treeview_array[k_ctr].tipo_voce = lower(trim(kst_tab_treeview.tipo_voce))
			if isnull(kst_tab_treeview.voce) then kst_tab_treeview_array[k_ctr].voce = " " else kst_tab_treeview_array[k_ctr].voce = lower(trim(kst_tab_treeview.voce))
			if isnull(kst_tab_treeview.pic_open) then kst_tab_treeview_array[k_ctr].pic_open = 0 else kst_tab_treeview_array[k_ctr].pic_open = kst_tab_treeview.pic_open
			if isnull(kst_tab_treeview.pic_close) then kst_tab_treeview_array[k_ctr].pic_close = 0 else kst_tab_treeview_array[k_ctr].pic_close = kst_tab_treeview.pic_close
			if isnull(kst_tab_treeview.pic_list) then kst_tab_treeview_array[k_ctr].pic_list = 0 else kst_tab_treeview_array[k_ctr].pic_list = kst_tab_treeview.pic_list
			if isnull(kst_tab_treeview.nome_oggetto) then kst_tab_treeview_array[k_ctr].nome_oggetto = "" else kst_tab_treeview_array[k_ctr].nome_oggetto = lower(trim(kst_tab_treeview.nome_oggetto))
			
//--- verifico la presenza figli 
			k_ctr1=0
			select distinct 1 into :k_ctr1 from treeview 
				where id_padre = upper(trim(:kst_tab_treeview.id));
			if k_ctr1=1 then
				kst_tab_treeview_array[k_ctr].presenza_figli = true
			else
				kst_tab_treeview_array[k_ctr].presenza_figli = false
			end if
			
			fetch kcursor_all INTO 
				:kst_tab_treeview.tipo_menu,
				:kst_tab_treeview.id,   
				:kst_tab_treeview.descrizione_tipo,   
				:kst_tab_treeview.descrizione,   
				:kst_tab_treeview.livello,   
				:kst_tab_treeview.sequenza,   
				:kst_tab_treeview.tipo_voce,   
				:kst_tab_treeview.voce,   
				:kst_tab_treeview.id_padre,   
				:kst_tab_treeview.funzione,   
				:kst_tab_treeview.pic_open,   
				:kst_tab_treeview.pic_close,   
				:kst_tab_treeview.pic_list,   
				:kst_tab_treeview.id_programma,
				:kst_tab_treeview.open_programma,
				:kst_tab_treeview.nome_oggetto  ;
				

		loop


	end if


	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Navigatore (Treeview): " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		if k_ctr = 0 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Navigatore (Treeview): nessuna voce presente in tabella! (u_select_tab_treeview_all)" 
		else
			if k_ctr >= kki_tab_treeview_item_max then
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Navigatore (Treeview): troppe voci presenti in tabella! (u_select_tab_treeview_all)" 
			end if
		end if
	end if
	
	close kcursor_all;

//---- Crea la Tabella effettivamente usata da M2000 x il NAVIGATORE	
	//k_ddl = "CREATE TABLE treeview_prod (
	k_ddl = "tipo_menu CHAR(1), id CHAR(24) NOT NULL, presenza_figli CHAR(1) NOT NULL, descrizione_tipo CHAR(20), " &
	    + "descrizione CHAR(80), livello CHAR(3), sequenza CHAR(3), tipo_voce CHAR(1), voce CHAR(40), id_padre CHAR(24), funzione CHAR(24), " &
		 + "pic_open FLOAT, pic_close FLOAT, pic_list FLOAT, id_programma CHAR(24), open_programma CHAR(24) , nome_oggetto CHAR(24)  "
	kst_esito = kguo_sqlca_db_magazzino.db_crea_table( "treeview_prod", k_ddl)
	
//---- Riempie la Tabella effettivamente usata da M2000 x il NAVIGATORE	
	for k_ctr1 = 1 to k_ctr
		
		k_presenza_figli = "0"
		if kst_tab_treeview_array[k_ctr1].presenza_figli = true then k_presenza_figli = "1"
		
		insert into treeview_prod
		 	(	tipo_menu,
				id,   
				presenza_figli,   
				descrizione_tipo,   
				descrizione,   
				livello,   
				sequenza,   
				tipo_voce,   
				voce,   
				id_padre,   
				funzione,   
				pic_open,   
				pic_close,   
				pic_list,   
				id_programma,
				open_programma,
				nome_oggetto)
			values
		 	(	:kst_tab_treeview_array[k_ctr1].tipo_menu,
				:kst_tab_treeview_array[k_ctr1].id,   
				:k_presenza_figli,   
				:kst_tab_treeview_array[k_ctr1].descrizione_tipo,   
				:kst_tab_treeview_array[k_ctr1].descrizione,   
				:kst_tab_treeview_array[k_ctr1].livello,   
				:kst_tab_treeview_array[k_ctr1].sequenza,   
				:kst_tab_treeview_array[k_ctr1].tipo_voce,   
				:kst_tab_treeview_array[k_ctr1].voce,   
				:kst_tab_treeview_array[k_ctr1].id_padre,   
				:kst_tab_treeview_array[k_ctr1].funzione,   
				:kst_tab_treeview_array[k_ctr1].pic_open,   
				:kst_tab_treeview_array[k_ctr1].pic_close,   
				:kst_tab_treeview_array[k_ctr1].pic_list,   
				:kst_tab_treeview_array[k_ctr1].id_programma,
				:kst_tab_treeview_array[k_ctr1].open_programma,
				:kst_tab_treeview_array[k_ctr1].nome_oggetto)
				;

		
	next 

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
		
finally	
	kguo_sqlca_db_magazzino.db_commit( )
		
end try

return kst_esito

end function

public function integer u_open_riferimenti_autorizza ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_handle_item = 0
integer k_ctr
kuf_meca_autorizza kuf1_meca_autorizza
st_esito kst_esito

st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_tab_g_0 kst_tab_g_0
//st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window


try
	
//--- ricavo il record e richiamo la windows				
	if kilv_lv1.visible then
		k_rc = kilv_lv1.getitem(kilv_lv1.SelectedIndex ( ), 1, klvi_listviewitem) 
		if k_rc > 0 then 
			kst_treeview_data = klvi_listviewitem.data  
			ktvi_treeviewitem.data = kst_treeview_data 
			kst_treeview_data_any = kst_treeview_data.struttura
		end if
	else
		k_rc = 0
	end if
	
	if k_rc > 0 then		

		if kst_treeview_data_any.st_tab_meca.id > 0 then

			kuf1_meca_autorizza = create kuf_meca_autorizza

//--- chiama la window 
			kst_tab_g_0.id = kst_treeview_data_any.st_tab_meca.id

			if kuf1_meca_autorizza.if_sicurezza(kkg_flag_modalita.modifica) then
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
			else
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
			end if

		else
			k_return = 1
//			messagebox("Accesso al Riferimento", "Valore non disponibile. ")
			
			
		end if
	else
		k_return = 1
	
	end if
 
 
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
end try


return k_return

end function

public function string u_get_open_programma ();//
//--- Torna id_programma indicato nella tabella di menu_window_anteprima x l'oggetto che ha il fuoco 
//--- utile ad esempio per fare l'anteprima
//
string k_return = ""
string k_tipo_oggetto=" ", k_str, k_id_programma = ""
integer k_esito=1
long k_handle_item=0, k_riga_selezionata=0
st_treeview_data kst_treeview_data	
st_tab_treeview kst_tab_treeview
st_esito kst_esito
kuf_parent kuf1_parent
treeviewitem ktvi_treeviewitem


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	if kst_treeview_data.handle > 0 then
		kst_treeview_data.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
		if kst_treeview_data.handle > 1 then
			if kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem) > 0 then
				kst_treeview_data = ktvi_treeviewitem.data
			end if
		end if
	end if

//--- legge i dati della tabella TREEVIEW
	kst_tab_treeview.id = trim(kst_treeview_data.oggetto)
	kst_esito = u_select_tab_treeview(kst_tab_treeview, kkg_flag_modalita.anteprima )

	if kst_esito.esito = kkg_esito.ok then

		k_return = trim(kst_tab_treeview.open_programma)

	end if

//=== Puntatore di default
SetPointer(kkg.pointer_default)


return k_return

end function

public function st_esito u_select_tab_treeview (ref st_tab_treeview kst_tab_treeview);//
//--- Legge da tab treeview con l' ID ovvero con dato TIPO_OGGETTO
//
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	kst_esito = u_select_tab_treeview(kst_tab_treeview, "")	
	
		
return kst_esito

end function

private function st_esito u_select_tab_treeview (ref st_tab_treeview kst_tab_treeview, string k_modalita);//---------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Legge da tab treeview con l' ID ovvero con dato TIPO_OGGETTO e MODALITA'
//--- Se richiama con anche la modalità torna l'esatto ID_PROGRAMMA 
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//---                               100=not found
//---                                 1=errore grave
//---                                 2=errore > 0
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------
int k_ctr=0
st_esito kst_esito
kuf_parent kuf1_parent



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	if len(trim(kst_tab_treeview.id)) > 0 then
		
		k_ctr++
		do while lower(trim(kst_tab_treeview.id)) <> trim(kist_tab_treeview[k_ctr].id) &
			      and len(trim(kist_tab_treeview[k_ctr].id)) > 0
			k_ctr++
		loop

		if lower(trim(kst_tab_treeview.id)) = trim(kist_tab_treeview[k_ctr].id) then
			kst_tab_treeview = kist_tab_treeview[k_ctr]
			
//--- il nome oggetto KUF_... spazza via il vecchio metodo con i campi open_programma e id_programma valorizzati	
			if len(trim(kst_tab_treeview.nome_oggetto)) > 0 then
				kuf1_parent = create using kst_tab_treeview.nome_oggetto
//--- Get del ID PROGRAMMA da ricoprire eventualmente quello su tabella xchè obsoleto 			
				kst_tab_treeview.id_programma = kuf1_parent.get_id_programma(k_modalita)
				kst_tab_treeview.open_programma = ""  // ricopre quello in tab xchè obsoleto
			end if		
			
		else
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Tab.Navigatore (Treeview): " + trim(sqlca.SQLErrText)
		end if

	else
		kst_esito.esito = kkg_esito.not_fnd
		kst_esito.SQLErrText = "Tab.Navigatore (Treeview): chiave del record non valorizzata " 
	end if
	
	
		
return kst_esito

end function

private function integer u_open_certif_file (string k_modalita);//
//--- Chiama finestra di dettaglio
//
integer k_return = 0, k_rc = 0
long k_riga=0
boolean k_certif_selected_eof 
string k_file, k_printer
st_esito kst_esito
kuf_file_explorer kuf1_file_explorer
kuf_utility kuf1_utility
//kuf_certif kuf1_certif


st_treeview_data kst_treeview_data, kst_treeview_data_parent
st_treeview_data_any kst_treeview_data_any
treeviewitem ktvi_treeviewitem, ktvi_treeviewitem_parent
listviewitem klvi_listviewitem

st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window



//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	kst_treeview_data_parent.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
	if kst_treeview_data_parent.handle > 0 then
		if kitv_tv1.getitem(kst_treeview_data_parent.handle, ktvi_treeviewitem_parent) > 0 then
			kst_treeview_data_parent = ktvi_treeviewitem_parent.data
		end if
	end if

//--- ricava la riga
	if kilv_lv1.visible then
		k_riga = kilv_lv1.SelectedIndex ( )
		if k_riga > 0 then 
			if kilv_lv1.getitem(k_riga, 1, klvi_listviewitem) > 0 then
				kst_treeview_data = klvi_listviewitem.data  
				ktvi_treeviewitem.data = kst_treeview_data 
				kst_treeview_data_any = kst_treeview_data.struttura
			end if
		end if
	else
		kst_treeview_data_any.st_treeview_file.nome = ""
		k_riga = 0
	end if
	

		if kst_treeview_data_any.st_treeview_file.nome > " " then

			choose case k_modalita  

				case kkg_flag_modalita.anteprima

					//kuf1_certif = create kuf_certif
					kst_esito = kiuf_certif.anteprima ( kidw_1, kst_treeview_data_any.st_tab_certif )
					//destroy kuf1_certif
					

				case kkg_flag_modalita.stampa
						
					try
						
						kuf1_utility = create kuf_utility
						k_printer = kuf1_utility.u_get_printer() // get della stampante
						
						kuf1_file_explorer = create kuf_file_explorer

						k_certif_selected_eof = false
						do while NOT k_certif_selected_eof
						
							k_file = trim(kst_treeview_data_any.st_treeview_file.path + kkg.path_sep + kst_treeview_data_any.st_treeview_file.nome)
							if not kuf1_file_explorer.of_print(k_file, k_printer) then // STAMPA!!!
								k_certif_selected_eof = true
								k_return = 1
								kguo_exception.inizializza( )
								kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
								kguo_exception.messaggio_utente("Stampa documento non eseguita", "Si è verificato un errore durante la Stampa del documento " + (k_file))
										
							else
					
//--- se NON sono in ristampa cancello la riga dall'elenco
								kilv_lv1.deleteitem(k_riga)
													
								k_riga --
								
								k_certif_selected_eof = false

							end if
						
//---Devo ancora cercare altre righe selezionate?
							if not k_certif_selected_eof then 
								k_certif_selected_eof = true
								k_riga = kilv_lv1.SelectedIndex ( )
								if k_riga > 0 then
									if kilv_lv1.getitem(k_riga, klvi_listviewitem)  > 0 then
										kst_treeview_data = klvi_listviewitem.data  
										ktvi_treeviewitem.data = kst_treeview_data 
										kst_treeview_data_any = kst_treeview_data.struttura
										k_certif_selected_eof = false
									end if
								end if
							end if
											
						
						loop
						
					catch(uo_exception kuo1_exception)
						k_return = 1
						kst_esito = kuo1_exception.get_st_esito()
						kguo_exception.inizializza()
						kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_non_eseguito)
						kguo_exception.setmessage( "Preparazione per Stampa documento Fallita. " +	"~n~r" + trim(kst_esito.sqlerrtext))
						kguo_exception.messaggio_utente( )

					finally
						if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
						if isvalid(kuf1_utility) then destroy kuf1_utility
						
					end try

					
					
				case kkg_flag_modalita.cancellazione
					
//					if trim(kst_treeview_data_parent.oggetto) = kist_treeview_oggetto.certif_st_dett then
//
//						try 
//							kuf1_certif = create kuf_certif
//	
//							k_certif_selected_eof = false
//							do while NOT k_certif_selected_eof
//							
//								k_certif_selected_eof = false
//	
//								
//								k_rc = 2 // il default iniziale
//								kst_tab_certif[1].num_certif = kst_treeview_data_any.st_tab_certif.num_certif
//								kst_tab_certif[1].data = kst_treeview_data_any.st_tab_certif.data
//								kst_tab_certif[1].id = kst_treeview_data_any.st_tab_certif.id
//								k_rc = messagebox("Cancella ATTESTATO", "Sei sicuro di voler ELIMINANE l'attestato n.  ~n~r" &
//												+ string(kst_tab_certif[1].num_certif) + "  del  " + string(kst_tab_certif[1].data) +  "   id = " + string(kst_tab_certif[1].id) &
//												+ "~n~rA operazione conclusa l'attestato sarà tra quelli da 'RISTAMPARE' ", Question!, yesnocancel!, k_rc)
//												
//								if k_rc = 1 then
//									kst_esito = kuf1_certif.tb_delete(kst_tab_certif[1] ) 
//						
//									klvi_listviewitem.selected = false
//									kilv_lv1.Setitem( k_riga, klvi_listviewitem)
//										
//									if kst_esito.esito = kkg_esito.ok then
//	
//										kilv_lv1.deleteitem(k_riga)
//												
//	//									k_riga --
//									end if
//	
//								else
//									if k_rc = 3 then
//										k_certif_selected_eof = true // forzo uscita ciclo
//									end if
//								end if
//	
//	
//	//---Devo ancora cercare altre righe selezionate?
//								if not k_certif_selected_eof then 
//									k_certif_selected_eof = true
//									k_riga = kilv_lv1.SelectedIndex ( )
//									if k_riga > 0 then
//										if kilv_lv1.getitem(k_riga, klvi_listviewitem)  > 0 then
//											kst_treeview_data = klvi_listviewitem.data  
//											ktvi_treeviewitem.data = kst_treeview_data 
//											kst_treeview_data_any = kst_treeview_data.struttura
//											k_certif_selected_eof = false
//										end if
//									end if
//								end if
//												
//							
//							loop
//						
//						catch (uo_exception kuo2_exception)
//							kuo2_exception.messaggio_utente()
//							
//						end try
//						
//					else
//						
//						k_return = 1
//						messagebox("Operazione non eseguita", &
//										"Da questo elenco non e' possibile cancellare gli Attestati.~n~r" &
//										+ trim(kst_esito.sqlerrtext))
//						
//					end if
//					
					
				case else
					try
						kuf1_utility = create kuf_utility
						k_file = trim(kst_treeview_data_any.st_treeview_file.path + kkg.path_sep + kst_treeview_data_any.st_treeview_file.nome)
						kuf1_utility.u_open_app_file(k_file)
						
					catch(uo_exception kuo2_exception)
						k_return = 1
						kst_esito = kuo2_exception.get_st_esito()
						kguo_exception.inizializza()
						kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_non_eseguito)
						kguo_exception.setmessage( "Apertura documento Fallita. " +	"~n~r" + trim(kst_esito.sqlerrtext))
						kguo_exception.messaggio_utente( )

					finally
						if isvalid(kuf1_utility) then destroy kuf1_utility
						
					end try
					
				
			end choose		
			
		else
			k_return = 1
			
			if k_modalita <> kkg_flag_modalita.anteprima then
				messagebox("Accesso Attestato", "Valore non disponibile. ")
			end if
			
		end if

	
//	end if
 
 
return k_return

end function

public function integer u_open_email () throws uo_exception;//
//--- Apre il client per fare un EMAIL 
//
integer k_return = 0, k_rc, k_index
string k_tipo_oggetto=" ", k_str //, k_id_programma = ""
integer k_esito=1
long k_handle_item=0, k_riga_selezionata=0
st_treeview_data kst_treeview_data	
st_tab_treeview kst_tab_treeview
st_esito kst_esito
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_treeview_data_any kst_treeview_data_any
kuf_parent kuf1_parent


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = u_get_st_treeview_data ()
	if kst_treeview_data.handle > 0 then
		kst_treeview_data.handle = kitv_tv1.finditem(ParentTreeItem!, kst_treeview_data.handle)
		if kst_treeview_data.handle > 1 then
			if kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem) > 0 then
				kst_treeview_data = ktvi_treeviewitem.data
			end if
		end if
	end if

//--- legge i dati della tabella TREEVIEW
	kst_tab_treeview.id = trim(kst_treeview_data.oggetto)
	kst_esito = u_select_tab_treeview(kst_tab_treeview, kkg_flag_modalita.visualizzazione )

	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.SQLErrText = "Funzione richiesta non Abilitata~n~r("+ trim(kst_esito.sqlerrtext) +")~n~r"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if				
	
	if trim(kst_tab_treeview.nome_oggetto) > " " then 
		
		if isvalid(kuf1_parent) then destroy kuf1_parent
		
//--- call dinamica al metodo 				
		kuf1_parent = create using trim(kst_tab_treeview.nome_oggetto)
		

//--- Carica tabella Fatture...					
		k_index = this.kilv_lv1.SelectedIndex()
		if k_index > 0 then
			k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
				kst_treeview_data_any = kst_treeview_data.struttura
			end if
		end if
		
//--- Cicla fino a che ci sono righe selezionate
		do while k_index > 0 //NOT k_fatt_selected_eof
					
			kuf1_parent.function dynamic u_tree_open_email(kst_treeview_data_any)  //invio email con il pgm predefinito
			k_return ++
	
//--- cerco se altre righe selezionate		
			klvi_listviewitem.Selected = false
			do while not klvi_listviewitem.Selected and k_index > 0  	
				k_index++
				k_rc = this.kilv_lv1.getitem(k_index, 1, klvi_listviewitem) 
				if k_rc > 0 then 
					kst_treeview_data = klvi_listviewitem.data  
					kst_treeview_data_any = kst_treeview_data.struttura
				else
					k_index = 0
				end if
			loop
		loop
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Funzione di preparazione invio email non trovata, errore: '" + k_str + "'. Operazione interrotta~n~r(" &
				+ trim(lower(kst_tab_treeview.nome_oggetto))+ ")~n~r" & 
				+ trim(kst_esito.SQLErrText)
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

finally
	if isvalid(kuf1_parent) then destroy kuf1_parent	
	
end try

return k_return
end function

private function integer u_riempi_treeview_file (string k_tipo_oggetto);// 
//
//--- Treeview Personalizzata
//
integer k_return = 0
//kuf_certif_file kuf1_certif_file

if not isvalid(kiuf_certif_file) then kiuf_certif_file = create kuf_certif_file

choose case k_tipo_oggetto

	case kist_treeview_oggetto.file_root
		k_return = kiuf_certif_file.u_tree_riempi_treeview_root( ki_this, k_tipo_oggetto )

	case kist_treeview_oggetto.file_dett
		k_return = kiuf_certif_file.u_tree_riempi_treeview( ki_this, k_tipo_oggetto )
		
	case else
		
end choose


//if isvalid(kuf1_certif_file) then destroy kuf1_certif_file


return k_return

end function

private function integer u_riempi_listview_file (string k_tipo_oggetto);// 
//
//--- Treeview Personalizzata
//
integer k_return = 0
//kuf_certif_file kuf1_certif_file


choose case k_tipo_oggetto
	case kist_treeview_oggetto.file_root &
			,kist_treeview_oggetto.file_dett
		//kuf1_certif_file = create kuf_certif_file
		k_return = kiuf_certif_file.u_tree_riempi_listview( ki_this, k_tipo_oggetto )
		//destroy kuf1_certif_file
		
	case else
		
end choose


return k_return

end function

public function st_treeview_data u_get_st_treeview_data (st_treeview_data ast_treeview_data);//
//--- ricavo la struttura della treeview dal HANDLE
//--- inp: ast_treeview_data.handle
//--- out: struttura st_treeview_data completa
st_treeview_data kst_treeview_data
treeviewitem ktvi_treeviewitem 



kst_treeview_data.handle = 0

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	if ast_treeview_data.handle > 0 then

		kitv_tv1.getitem(ast_treeview_data.handle, ktvi_treeviewitem)
		if classname(ktvi_treeviewitem.data) = "st_treeview_data" then 
			kst_treeview_data = ktvi_treeviewitem.data
		end if
	else
//--- se non esiste seleziono il ROOT
		kst_treeview_data.handle = kitv_tv1.finditem(RootTreeItem!, 0)
		kst_treeview_data.handle_padre = 0
		if kst_treeview_data.handle > 0 then
			kitv_tv1.getitem(kst_treeview_data.handle, ktvi_treeviewitem)
//			kitv_tv1.selectitem(k_handle_item)
		end if
	end if
		

return kst_treeview_data

end function

on kuf_treeview.create
call super::create
end on

on kuf_treeview.destroy
call super::destroy
end on

event constructor;//
//--- ATTENZIONE LE PROPRIETA' VANNO SCRITTE IN minuscolo !!!!
//--- devono corripondere al nome funzione presente nella tabella treeview
//
int k_i = 0
 
//--- Imposto l'oggetto me stesso
	ki_this = this


//--- imposta le propieta' della tabella della treeview
	kist_treeview_oggetto.nullo = ""
	kist_treeview_oggetto.pic_ritorna_item_padre = 7
	kist_treeview_oggetto.pic_cartella = 2
	kist_treeview_oggetto.start = "start"
	kist_treeview_oggetto.root = "root"
	kist_treeview_oggetto.id_padre = "id_padre"  //  serve gli item che fanno in automatico la generazione della tree
	
	
//--- Sezione Barcode	
	kist_treeview_oggetto.barcode = "barcode"
	kist_treeview_oggetto.barcode_armo = "brcd_armo"
	kist_treeview_oggetto.barcode_mese = "brcd_mese"
	kist_treeview_oggetto.barcode_mese_dett = "brcd_mese_dett"
	kist_treeview_oggetto.barcode_anno = "brcd_anno"
	kist_treeview_oggetto.barcode_stor = "brcd_anno_stor"
	kist_treeview_oggetto.barcode_anno_mese = "brcd_anno_mese"
	kist_treeview_oggetto.barcode_stor_mese = "brcd_stor_mese"
	kist_treeview_oggetto.barcode_root = "brcd_root"
	kist_treeview_oggetto.barcode_dett = "brcd_dett"
	kist_treeview_oggetto.barcode_tutti = "brcd_tutti"
	kist_treeview_oggetto.barcode_tutti_dett = "brcd_tutti_dett"
	kist_treeview_oggetto.barcode_no_st = "brcd_no_st"
	kist_treeview_oggetto.barcode_no_st_dett = "brcd_no_st_dett"
	kist_treeview_oggetto.barcode_no_st_root_dett = "brcd_no_st_root_dett"
	kist_treeview_oggetto.barcode_gia_st = "brcd_gia_st"
	kist_treeview_oggetto.barcode_gia_st_dett = "brcd_gia_st_dett"
	kist_treeview_oggetto.barcode_gia_pl = "brcd_gia_pl"
	kist_treeview_oggetto.barcode_gia_pl_dett = "brcd_gia_pl_dett"
	kist_treeview_oggetto.barcode_pl_chiuso = "brcd_pl_chiu"
	kist_treeview_oggetto.barcode_pl_chiuso_dett = "brcd_pl_chiu_dett"
	kist_treeview_oggetto.barcode_trattati = "brcd_tratt"
	kist_treeview_oggetto.barcode_trattati_dett = "brcd_tratt_dett"
	kist_treeview_oggetto.barcode_ok = "brcd_ok"
	kist_treeview_oggetto.barcode_ok_dett = "brcd_ok_dett"
	kist_treeview_oggetto.barcode_ko = "brcd_ko"
	kist_treeview_oggetto.barcode_ko_dett = "brcd_ko_dett"
	kist_treeview_oggetto.barcode_sosp = "brcd_sosp"
	kist_treeview_oggetto.barcode_sosp_dett = "brcd_sosp_dett"


//--- Sezione PL dei Barcode	
	kist_treeview_oggetto.pl_barcode = "pl_brcd"
	kist_treeview_oggetto.pl_barcode_meca = "pl_brcd_meca"
	kist_treeview_oggetto.pl_barcode_mese = "pl_brcd_mese"
	kist_treeview_oggetto.pl_barcode_mese_dett = "pl_brcd_mese_dett"
    kist_treeview_oggetto.pl_barcode_aperto = "pl_brcd_aperto"
    kist_treeview_oggetto.pl_barcode_aperto_dett = "pl_brcd_aperto_dett"
	kist_treeview_oggetto.pl_barcode_chiuso = "pl_brcd_chiu"
	kist_treeview_oggetto.pl_barcode_chiuso_dett = "pl_brcd_chiu_dett"
	kist_treeview_oggetto.pl_barcode_gia_pilota = "pl_brcd_gia_pilota"
	kist_treeview_oggetto.pl_barcode_gia_pilota_dett = "pl_brcd_gia_pilota_dett"
	kist_treeview_oggetto.pl_barcode_sospeso = "pl_brcd_sosp"
	kist_treeview_oggetto.pl_barcode_sospeso_dett = "pl_brcd_sosp_dett"
	kist_treeview_oggetto.pl_barcode_respinto = "pl_brcd_respinto"
	kist_treeview_oggetto.pl_barcode_respinto_dett = "pl_brcd_respinto_dett"
	
	
//--- Sezione DOSIMETRIE e ANOMALIE GIRI
	kist_treeview_oggetto.meca_lav = "meca_lav"
	kist_treeview_oggetto.meca_lav_dett = "meca_lav_dett"
	kist_treeview_oggetto.meca_lav_ok = "meca_lav_ok"
	kist_treeview_oggetto.meca_lav_mese_ok = "meca_lav_mese_ok"
	kist_treeview_oggetto.meca_lav_mese_ok_dett = "meca_lav_mese_ok_dett"
	kist_treeview_oggetto.meca_lav_ko = "meca_lav_ko"
	kist_treeview_oggetto.meca_lav_ko_da_sblk = "meca_lav_ko_da_sblk"
	kist_treeview_oggetto.meca_lav_ko_da_sblk_dett = "meca_lav_ko_da_sblk_dett"
	kist_treeview_oggetto.meca_lav_ko_sblk = "meca_lav_ko_sblk"
	kist_treeview_oggetto.meca_lav_mese_ko = "meca_lav_mese_ko"
	kist_treeview_oggetto.meca_lav_mese_ko_dett = "meca_lav_mese_ko_dett"
	kist_treeview_oggetto.meca_lav_att = "meca_lav_att"
	kist_treeview_oggetto.meca_lav_att_prima = "meca_lav_att_prima"
	kist_treeview_oggetto.meca_lav_att_prima_dett = "meca_lav_att_prima_dett"
	kist_treeview_oggetto.meca_lav_att_aut_ok = "meca_lav_att_aut_ok"
	kist_treeview_oggetto.meca_lav_att_aut_ok_dett = "meca_lav_att_aut_ok_dett"
	kist_treeview_oggetto.meca_lav_att_aut_ko = "meca_lav_att_aut_ko"
	kist_treeview_oggetto.meca_lav_att_aut_ko_dett = "meca_lav_att_aut_ko_dett"
	kist_treeview_oggetto.meca_lav_mese_att = "meca_lav_mese_att"
	kist_treeview_oggetto.meca_lav_mese_att_dett = "meca_lav_mese_att_dett"
	kist_treeview_oggetto.meca_err = "meca_err"
	kist_treeview_oggetto.meca_err_giri = "meca_err_giri"
	kist_treeview_oggetto.meca_err_mese_giri = "meca_err_mese_giri"
	kist_treeview_oggetto.meca_err_mese_giri_dett = "meca_err_mese_giri_dett"
	kist_treeview_oggetto.meca_err_all = "meca_err_all"
	kist_treeview_oggetto.meca_err_mese_all = "meca_err_mese_all"
	kist_treeview_oggetto.meca_err_mese_all_dett = "meca_err_mese_all_dett"
	
//--- Sezione MECA
	kist_treeview_oggetto.meca = "meca"
	kist_treeview_oggetto.meca_anno = "meca_anno"
	kist_treeview_oggetto.meca_stor = "meca_stor"
	kist_treeview_oggetto.meca_anno_mese = "meca_anno_mese"
	kist_treeview_oggetto.meca_stor_mese = "meca_stor_mese"
//	kist_treeview_oggetto.meca_mese = "meca_mese"
	kist_treeview_oggetto.meca_dett = "meca_dett"
	kist_treeview_oggetto.meca_dett_nodose = "meca_dett_nodose"
	kist_treeview_oggetto.meca_dett_id_meca = "meca_dett_id_meca"
	kist_treeview_oggetto.meca_note_lav_ok = "meca_note_lav_ok"
	kist_treeview_oggetto.meca_car_dett = "meca_car_dett"
	kist_treeview_oggetto.meca_car_meca = "meca_car_meca"
	kist_treeview_oggetto.meca_car_meca_dett = "meca_car_meca_dett"
	kist_treeview_oggetto.meca_car_nt = "meca_car_nt"
	kist_treeview_oggetto.meca_car_nt_dett = "meca_car_nt_dett"
	kist_treeview_oggetto.meca_car_sp = "meca_car_sp"
	kist_treeview_oggetto.meca_car_sp_dett = "meca_car_sp_dett"
	kist_treeview_oggetto.meca_car_bc = "meca_car_bc"
	kist_treeview_oggetto.meca_car_bc_dett = "meca_car_bc_dett"
	kist_treeview_oggetto.meca_car_ft = "meca_car_ft"
	kist_treeview_oggetto.meca_car_ft_dett = "meca_car_ft_dett"
	kist_treeview_oggetto.meca_car_cert = "meca_car_cert"
	kist_treeview_oggetto.meca_car_cert_dett = "meca_car_cert_dett"
	kist_treeview_oggetto.meca_car_lav_ok = "meca_car_lav"
	kist_treeview_oggetto.meca_blk = "meca_blk"
	kist_treeview_oggetto.meca_blk_dett = "meca_blk_dett" 
	kist_treeview_oggetto.meca_da_associare_wm_dett = "meca_da_assoc_wm_dett"
	kist_treeview_oggetto.meca_qtna = "meca_qtna"
	kist_treeview_oggetto.meca_qtna_dett = "meca_qtna_dett"
	kist_treeview_oggetto.meca_trasferiti_dapkl = "meca_trasferiti_dapkl"
//	kist_treeview_oggetto.meca_no_e1asn = "meca_no_e1asn"
	kist_treeview_oggetto.meca_no_e1asn_dett = "meca_no_e1asn_dett"
	kist_treeview_oggetto.meca_no_e1bcode_dett = "meca_no_e1bcode_dett"
	kist_treeview_oggetto.meca_no_e1bcodeass_dett = "meca_no_e1bcodeass_dett"
	kist_treeview_oggetto.meca_no_e1accettato_dett = "meca_no_e1accetato_dett"

//--- Sezione ARMO
	kist_treeview_oggetto.armo = "armo"
	kist_treeview_oggetto.armo_tipo = "armo_tipo"
	kist_treeview_oggetto.armo_tipo_sp = "armo_tipo_sp"
	kist_treeview_oggetto.armo_tipo_ft = "armo_tipo_ft"
	kist_treeview_oggetto.armo_tipo_ft_dett = "armo_tipo_ft_dett"

//--- Sezione Spedizioni
	kist_treeview_oggetto.sped = "sped"  
	kist_treeview_oggetto.sped_dett = "sped_dett"   
	kist_treeview_oggetto.sped_da_st = "sped_da_st"   
	kist_treeview_oggetto.sped_da_st_dett = "sped_da_st_dett"
	kist_treeview_oggetto.sped_da_ft = "sped_da_ft"
	kist_treeview_oggetto.sped_da_ft_dett = "sped_da_ft_dett"
	kist_treeview_oggetto.sped_righe = "sped_righe"
	kist_treeview_oggetto.sped_righe_dett = "sped_righe_dett"
	kist_treeview_oggetto.sped_clie_3_da_ft = "sped_clie_3_da_ft"
	kist_treeview_oggetto.sped_clie_3_da_ft_dett = "sped_clie_3_da_ft_dett"
	kist_treeview_oggetto.sped_pagam_da_ft = "sped_pagam_da_ft"
	kist_treeview_oggetto.sped_pagam_da_ft_dett = "sped_pagam_da_ft_dett"
	kist_treeview_oggetto.sped_anno_mese = "sped_anno_mese"
	kist_treeview_oggetto.sped_stor_mese = "sped_stor_mese"

//--- Sezione Fatture
	kist_treeview_oggetto.fattura = "fattura"
	kist_treeview_oggetto.fattura_testa = "fattura_testa"
	kist_treeview_oggetto.fattura_dett = "fattura_dett"
	kist_treeview_oggetto.fattura_da_st = "fattura_da_st"
	kist_treeview_oggetto.fattura_dett_da_st = "fattura_dett_da_st"
	kist_treeview_oggetto.fattura_anno = "fattura_anno"
	kist_treeview_oggetto.fattura_stor = "fattura_stor"
	kist_treeview_oggetto.fattura_anno_mese = "fattura_anno_mese"
	kist_treeview_oggetto.fattura_stor_mese = "fattura_stor_mese"

//--- Sezione Attestati
	kist_treeview_oggetto.certif = "certif"
	kist_treeview_oggetto.certif_dett = "certif_dett"
	kist_treeview_oggetto.certif_in_lav_dett = "certif_in_lav_dett"
	kist_treeview_oggetto.certif_da_st_sd_dett = "certif_da_st_sd_dett"
	kist_treeview_oggetto.certif_da_st_dett = "certif_da_st_dett"
	kist_treeview_oggetto.certif_err_dett = "certif_err_dett"
	kist_treeview_oggetto.certif_st_mese = "certif_st_mese"
	kist_treeview_oggetto.certif_st_giorno = "certif_st_giorno"
	kist_treeview_oggetto.certif_st_dett = "certif_st_dett"
	kist_treeview_oggetto.certif_da_conv_dett = "certif_da_conv_dett"
	kist_treeview_oggetto.certif_da_st_farma_dett = "certif_da_st_farma_dett"
	kist_treeview_oggetto.certif_da_st_alimen_dett = "certif_da_st_alimen_dett"

//--- Sezione CLIENTI
	kist_treeview_oggetto.anagrafiche = "anagrafiche"
	kist_treeview_oggetto.anag_alfa = "anag_alfa"
	kist_treeview_oggetto.anag = "anag"
	kist_treeview_oggetto.anag_doc = "anag_doc"
	kist_treeview_oggetto.anag_dett = "anag_dett"
	kist_treeview_oggetto.anag_dett_anno = "anag_dett_anno"
	kist_treeview_oggetto.anag_dett_anno_mese = "anag_dett_anno_mese"
	kist_treeview_oggetto.anag_dett_anno_mese_dett = "anag_dett_anno_mese_dett"
	kist_treeview_oggetto.anag_dett_stor = "anag_dett_stor"
	kist_treeview_oggetto.anag_dett_stor_mese = "anag_dett_stor_mese"
	kist_treeview_oggetto.anag_dett_stor_mese_dett = "anag_dett_stor_mese_dett"
	kist_treeview_oggetto.clie_1 = "clie_1"
	kist_treeview_oggetto.clie_2 = "clie_2"
	kist_treeview_oggetto.clie_3 = "clie_3"

//--- Sezione PACKING LIST MANDANTI
	kist_treeview_oggetto.pklist_wm = "pklist_wm"
	kist_treeview_oggetto.pklist_wm_da_imp = "pklist_wm_da_imp"
	kist_treeview_oggetto.pklist_wm_da_web_dett = "pklist_wm_da_web_dett"
	kist_treeview_oggetto.pklist = "pklist"
	kist_treeview_oggetto.pklist_da_imp = "pklist_da_imp"
	kist_treeview_oggetto.pklist_tutti = "pklist_da_imp"
	kist_treeview_oggetto.pklist_dett_da_imp = "pklist_dett_da_imp"
	kist_treeview_oggetto.pklist_anno_mese = "pklist_anno_mese"
	kist_treeview_oggetto.pklist_dett = "pklist_dett"
	kist_treeview_oggetto.pklist_righe = "pklist_righe"

//--- Sezione DOCUMENTI (FILE)
	kist_treeview_oggetto.file_root = "file_root"
	kist_treeview_oggetto.file_dett = "file_dett"

//--- inizializza ARRY di posizionamento nella listview nel ritorno
	for k_i = 1 to 200		
		ki_tab_item_selezionato[k_i,1] = 0
		ki_tab_item_selezionato[k_i,2] = 0
	next

//--- crea oggetti dell'istanza
	kiuf_certif = create kuf_certif

end event

event destructor;
//--- salva colonne listview
	u_listview_salva_dim_colonne ()

	if isvalid(kiuf_wm_pklist_testa) then destroy kiuf_wm_pklist_testa
	if isvalid(kiuf_wm_pklist_web) then destroy kiuf_wm_pklist_web
	if isvalid(kiuf_wm_receiptgammarad) then destroy kiuf_wm_receiptgammarad
	if isvalid(kiuf_sped) then destroy kiuf_sped
	if isvalid(kiuf_armo) then destroy kiuf_armo
	if isvalid(kiuf_certif_file) then destroy kiuf_certif_file
	if isvalid(kiuf_certif) then destroy kiuf_certif
	if isvalid(kiuf_clienti) then destroy kiuf_clienti
	
end event

