$PBExportHeader$w_g_tab_tv.srw
forward
global type w_g_tab_tv from w_g_tab
end type
type tv_root from treeview within w_g_tab_tv
end type
type lv_1 from listview within w_g_tab_tv
end type
type dw_anteprima from uo_d_std_1 within w_g_tab_tv
end type
type dw_stampa from datawindow within w_g_tab_tv
end type
type st_cancella from statictext within w_g_tab_tv
end type
type st_conferma from statictext within w_g_tab_tv
end type
type st_inserisci from statictext within w_g_tab_tv
end type
type st_modifica from statictext within w_g_tab_tv
end type
type st_visualizza from statictext within w_g_tab_tv
end type
type st_orizzontal from statictext within w_g_tab_tv
end type
type st_vertical from statictext within w_g_tab_tv
end type
type dw_data1 from uo_d_std_1 within w_g_tab_tv
end type
end forward

global type w_g_tab_tv from w_g_tab
integer width = 681
integer height = 440
string title = "Navigatore"
long backcolor = 553648127
windowanimationstyle closeanimation = rightroll!
boolean ki_salva_controlli = true
boolean ki_windowpredef = true
boolean ki_personalizza_pos_controlli = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_filtra_attivo = false
boolean ki_aggiorna_richiesta_conferma = false
tv_root tv_root
lv_1 lv_1
dw_anteprima dw_anteprima
dw_stampa dw_stampa
st_cancella st_cancella
st_conferma st_conferma
st_inserisci st_inserisci
st_modifica st_modifica
st_visualizza st_visualizza
st_orizzontal st_orizzontal
st_vertical st_vertical
dw_data1 dw_data1
end type
global w_g_tab_tv w_g_tab_tv

type variables
//
private kuf_treeview kiuf_treeview
private st_treeview_oggetto kist_treeview_oggetto 

private string ki_titolo_window_orig 

private boolean ki_flag_tree_appena_espanso = true
private boolean ki_flag_list_appena_espanso = false


//private time ki_time_lbuttondown
private long ki_index = 0
//private long ki_time_lbuttondown_riga=0
//private time ki_time_rileggi_auto

private boolean ki_time_attivo = false

//--- x fare il drag&drop da windows
private kuf_file_dragdrop kiuf_file_dragdrop

private kuf_menu_popup kiuf_menu_popup

private string ki_zoom

private boolean ki_st_vertical=true, ki_st_orizzontal=true

private long ki_listview_index

private boolean ki_focus_on_st_oizzontal, ki_focus_on_st_vertical

private date ki_data_ini, ki_data_fin

//private boolean ki_primo_giro_tv = true
end variables

forward prototypes
protected function integer u_dammi_item_padre_da_list ()
private subroutine leggi_ramo_treeviewitem ()
private subroutine aggiorna_liste ()
protected function st_esito aggiorna_window ()
protected subroutine attiva_menu ()
private subroutine cliccato_list (long k_index)
private subroutine cliccato_tree ()
protected subroutine crea_dw_stampa_da_listview ()
private function integer forma_tree (long k_handle_item_padre)
protected function string inizializza () throws uo_exception
protected subroutine inizializza_lista ()
private subroutine open_dettaglio (string k_operazione)
public subroutine resetta ()
protected subroutine open_start_window ()
private subroutine treeview_collassa_tutti_i_rami ()
public subroutine smista_funz (string k_par_in)
protected subroutine stampa_esegui (st_stampe ast_stampe)
private subroutine u_add_memo_link (string a_file[], integer a_file_nr)
public subroutine u_anteprima ()
public function long u_drop_file (integer a_k_tipo_drag, long a_handle)
protected subroutine u_key (keycode key, unsignedlong keyflags)
public subroutine u_zoom_meno (uo_d_std_1 adw_1)
public subroutine u_zoom_off (uo_d_std_1 adw_1)
public subroutine u_zoom_piu (uo_d_std_1 adw_1)
public subroutine u_set_window_size ()
public function integer u_open_email () throws uo_exception
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public function boolean u_resize_predefinita ()
protected subroutine set_titolo_window_personalizza ()
public subroutine u_wtitolo_path (st_treeview_data ast_treeview_data)
public subroutine u_resize_1 ()
private subroutine u_set_data_certif_da_st ()
protected subroutine stampa_anteprima ()
public subroutine u_resize ()
public subroutine u_resize_default ()
end prototypes

protected function integer u_dammi_item_padre_da_list ();//
//--- Torna il padre dell'item di listview
//
integer k_item = 0, k_rc
listviewitem klvi_listviewitem
st_treeview_data kst_treeview_data
//treeviewitem ktvi_treeviewitem


	k_item = lv_1.finditem(0,"..", true, true)
	if k_item > 0 then
		k_rc = lv_1.getitem(k_item, 1, klvi_listviewitem) 
		if k_rc > 0 then 
			kst_treeview_data = klvi_listviewitem.data  
			k_item = kst_treeview_data.handle_padre 
			
//			kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list
		end if

	end if
	

return k_item

end function

private subroutine leggi_ramo_treeviewitem ();//
pointer oldpointer  // Declares a pointer variable


ki_flag_tree_appena_espanso = true

	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	tv_root.setredraw(false)
	lv_1.setredraw(false)

	
	kiuf_treeview.u_smista_treeview_listview( )


//--- per espandere l'item

	tv_root.setredraw(true)
	lv_1.setredraw(true)
	
	attiva_tasti()
	
//=== Ripristina il Puntatore originale
	oldpointer = SetPointer(oldpointer) 


end subroutine

private subroutine aggiorna_liste ();//
//
long k_handle_item=0, k_handle_item_padre
//kuf_treeview kuf1_treeview
treeviewitem ktvi_1


//	k_handle_item = tv_root.finditem(CurrentTreeItem!, 0)
	k_handle_item = u_dammi_item_padre_da_list()
	if k_handle_item > 0 then

		if tv_root.SelectItem(k_handle_item) > 0 then //, ktvi_1) > 0 then

			kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree
			kiuf_treeview.ki_forza_refresh=kiuf_treeview.ki_forza_refresh_si
			kiuf_treeview.ki_flag_gia_dentro = kiuf_treeview.ki_flag_gia_dentro_NO 
			leggi_ramo_treeviewitem()
			kiuf_treeview.ki_forza_refresh=kiuf_treeview.ki_forza_refresh_NO

		end if
		
	end if
 
end subroutine

protected function st_esito aggiorna_window ();//
st_esito kst_esito 

	aggiorna_liste()
	
	kst_esito.esito = kkg_esito.ok
	
return kst_esito
end function

protected subroutine attiva_menu ();//
boolean k_flg_lotto=false


//
//--- Attiva/Dis. Voci di menu 
// 
//	ki_menu.m_finestra.m_gestione.enable()
//	ki_menu.m_finestra.m_gestione.show()

	if ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled <> st_conferma.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled = st_conferma.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled <> st_inserisci.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = st_inserisci.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled <> st_modifica.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = st_modifica.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled <> st_cancella.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled = st_cancella.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled <> st_visualizza.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = st_visualizza.enabled
	end if
	if ki_menu.m_finestra.m_fin_stampa.enabled <> st_stampa.enabled then
		ki_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled
		ki_menu.m_finestra.m_fin_stampa.text = "Stampa documento"
		ki_menu.m_finestra.m_fin_stampa.microhelp = "Stampa"
		ki_menu.m_finestra.m_fin_stampa.toolbaritemVisible = ki_menu.m_finestra.m_fin_stampa.enabled
		ki_menu.m_finestra.m_fin_stampa.toolbaritemText = "Stampa,"+ki_menu.m_finestra.m_fin_stampa.text
	end if

//	if not ki_menu.m_trova.toolbaritemvisible  then
//		ki_menu.m_trova.toolbaritemvisible = st_ordina_lista.enabled = true
//	end if
//	if not ki_menu.m_trova.visible or not ki_menu.m_trova.enabled then
//		ki_menu.m_trova.visible = true 
//		ki_menu.m_trova.enabled = true 
//		ki_menu.m_trova.m_fin_cerca.enabled = true 
//		ki_menu.m_trova.m_fin_cerca.visible = true 
//		ki_menu.m_trova.m_fin_cerca.toolbaritemvisible = true
//		ki_menu.m_trova.m_fin_cercaancora.enabled = true 
//		ki_menu.m_trova.m_fin_cercaancora.visible = true 
//		ki_menu.m_trova.m_fin_cercaancora.toolbaritemvisible = true
//	end if

	st_aggiorna_lista.enabled = true
	st_ordina_lista.enabled = true
//	ki_menu.m_finestra.m_aggiornalista.enabled = true
//	ki_menu.m_finestra.m_riordinalista.enabled = true
//	ki_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
	

//
//--- Attiva/Dis. Voci di menu personalizzate
//

	choose case kiuf_treeview.kist_treeview_oggetto.oggetto
			case kiuf_treeview.kist_treeview_oggetto.certif_da_st_dett &
				  ,kiuf_treeview.kist_treeview_oggetto.certif_da_st_sd_dett &
				  ,kiuf_treeview.kist_treeview_oggetto.certif_da_st_farma_dett &
				  ,kiuf_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett 

				if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
					ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia data estrazione Attestati "
					ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Cambia data estrazione Attestati "
					ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
					ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
					ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
					ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "data,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
					ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
			//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
				end if	
			case else
				ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
				ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	end choose

//--- Menu LIBERI in aggiunta alle normali funzionalità
	if not ki_menu.m_strumenti.m_fin_gest_libero1.enabled then
		
		
		
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Chiude tutti i 'rami'"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Nasconde tutti i rami escluso quelli iniziali"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true //ki_menu.m_strumenti.m_fin_gest_libero1.visible
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "comp.,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "close!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
//	//	if tv_root.visible = true then
//			ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi pannelli"
//			ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra/Nasconde pannello di 'Elenco' e di 'Anteprima' "
//	//	else
//	//		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Visualizza Struttura"
//	//		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza a sinistra della Finestra la struttura ad albero"
//	//	end if
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = false
//		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true //ki_menu.m_strumenti.m_fin_gest_libero2.visible
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "mostra,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Layer!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
	
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Stampa Elenco"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Stampa Elenco o Dettaglio"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = false //ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true //ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true //ki_menu.m_strumenti.m_fin_gest_libero3.enabled
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "stampa,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom074!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	
	

		ki_menu.m_strumenti.m_fin_gest_libero7.text = kkg_flag_modalita.DES_VISUALIZZAZIONE // "Visualizzazione"
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemText = "tipo,tipo visualizzazione"
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Icone grandi"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Visualizza icone grandi"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "grandi,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "Custom097!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Icone piccole"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Visualizza icone piccole"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "piccole,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "Custom098!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text = "Lista voci"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.microhelp = "Visualizza come elenco"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "elenco,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = "Custom099!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritembarindex=2
		
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text = "Dettaglio"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.microhelp = "Visualizza dettaglio"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.visible = ki_menu.m_strumenti.m_fin_gest_libero2.visible
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemText = "dettagli,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName = "Custom100!"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritembarindex=2
	
	end if

		
	ki_menu.m_strumenti.m_fin_gest_libero4.text = "Invio email"
	ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Predispone invio email"
	ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	if kiuf_treeview.kist_treeview_oggetto.oggetto = kiuf_treeview.kist_treeview_oggetto.file_dett then
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
	else
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = false
	end if
	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = ki_menu.m_strumenti.m_fin_gest_libero4.enabled
	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "email,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom025!"
	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	choose case kiuf_treeview.kist_treeview_oggetto.oggetto
		case kiuf_treeview.kist_treeview_oggetto.meca_dett &
				, kiuf_treeview.kist_treeview_oggetto.meca_dett_id_meca &
				, kiuf_treeview.kist_treeview_oggetto.meca_car_meca_dett &
				, kiuf_treeview.kist_treeview_oggetto.meca_blk_dett &
			    , kiuf_treeview.kist_treeview_oggetto.meca_err_mese_all_dett &
			    , kiuf_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett &
			    , kiuf_treeview.kist_treeview_oggetto.meca_dett_nodose &
				, kiuf_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett &
				, kiuf_treeview.kist_treeview_oggetto.meca_qtna_dett &
				, kiuf_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett &
				, kiuf_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett &
				, kiuf_treeview.kist_treeview_oggetto.certif_da_st_farma_dett &
				, kiuf_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett &
				, kiuf_treeview.kist_treeview_oggetto.certif_da_st_sd_dett &
				, kiuf_treeview.kist_treeview_oggetto.certif_err_dett

			k_flg_lotto = true

		case else
			k_flg_lotto = false
	end choose
	if ki_menu.m_strumenti.m_fin_gest_libero8.enabled <> k_flg_lotto or not ki_menu.m_strumenti.m_fin_gest_libero8.visible then
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Autorizza Lotto"
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Autorizzazioni Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = k_flg_lotto
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true // ki_menu.m_strumenti.m_fin_gest_libero8.enabled
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Autorizza,"+ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Error!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
	end if	
	
	if kiuf_treeview.kist_treeview_oggetto.oggetto =kiuf_treeview.kist_treeview_oggetto.pklist_dett_da_imp then
		ki_menu.m_finestra.m_gestione.m_fin_modifica.text = "Modifica/Importa"
		ki_menu.m_finestra.m_gestione.m_fin_modifica.microhelp = "Modifica e Importa pkl"
		ki_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemVisible = ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled
		ki_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemText = "Modifica,"+ki_menu.m_finestra.m_gestione.m_fin_modifica.text
	end if
	
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
	
		
end subroutine

private subroutine cliccato_list (long k_index);//
long k_handle, k_rc
st_treeview_data kst_treeview_data, kst_treeview_data_padre
listviewitem klvi_listviewitem 

	
	if k_index > 0 and not ki_flag_list_appena_espanso then
		
		setpointer(kkg.pointer_attesa)
		ki_flag_list_appena_espanso = true
		tv_root.setredraw(false)
		lv_1.setredraw(false)

//--- imposta il path in alto
		if k_index > 1 then
			kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list
			k_rc = lv_1.getitem(k_index, 1, klvi_listviewitem) 
			if k_rc > 0 then 
				kst_treeview_data = klvi_listviewitem.data  
			else
				kst_treeview_data.handle = 0
			end if
		else
			kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree
			kst_treeview_data.label = ""
			kst_treeview_data.handle = 0
		end if
		k_rc = lv_1.getitem(1, 1, klvi_listviewitem) 
		kst_treeview_data_padre = klvi_listviewitem.data
		kst_treeview_data.handle_padre = kst_treeview_data_padre.handle_padre
		u_wtitolo_path(kst_treeview_data)
		kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list

//--- salva le dimensioni delle colonne così come sistemate da utente
		kiuf_treeview.u_listview_salva_dim_colonne()
		
//--- salva il numero di riga per poi potersi automaticamente posizionare se torna qui sopra		
		if kiuf_treeview.kilv_lv1.selectedindex( ) > 1 then
			kiuf_treeview.u_treeview_item_salva( )
			kiuf_treeview.u_treeview_data_item_salva( )
		end if
		
		leggi_ramo_treeviewitem()

		tv_root.setredraw(true)
		lv_1.setredraw(true)


//--- imposto il percorso sulla barra del titolo
//		event u_wtitolo_path()

		ki_flag_list_appena_espanso = false
		
		setpointer(kkg.pointer_default)
	
	end if


//	attiva_tasti()


end subroutine

private subroutine cliccato_tree ();//
long k_handle_item
st_treeview_data kst_treeview_data


	SetPointer(kkg.pointer_attesa)

//--- solo x il primo giro forza la lettura e l'espansione del ramo
   if ki_st_open_w.flag_primo_giro = "S" then 

		leggi_ramo_treeviewitem()
		k_handle_item=tv_root.finditem(RootTreeItem!, 0)
		if k_handle_item > 0 then
			tv_root.ExpandItem(k_handle_item)
		end if
	else
		
//--- non faccio la rilettura se clicco su root		
		kst_treeview_data = kiuf_treeview.u_get_st_treeview_data( ) 
		k_handle_item = kst_treeview_data.handle
		if k_handle_item > 0 then
			leggi_ramo_treeviewitem()
		end if
		
	end if

	//kiw_this_window.postevent ("u_wtitolo_path")
//	kiw_this_window.triggerevent("u_wtitolo_path")
	u_wtitolo_path(kst_treeview_data)

	SetPointer(kkg.pointer_default)

end subroutine

protected subroutine crea_dw_stampa_da_listview ();//---
//---  genera un dw da una listview
//---
int k_colcount=0, k_riga, k_colonna, k_larg_campo, k_pos_x
string k_rc, k_visible, k_valore, k_table, k_resto, k_syntax
string k_titolo_col, k_tipo_oggetto, k_ls_err, k_alignement 
long k_handle_item, k_rcn, k_list_eof
alignment k_align
listviewitem klvi_listviewitem
pointer oldpointer



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

				

//--- estrazione dell'intero contenuto del dw
//	k_dw = dw_stampa.describe("DataWindow.Syntax")

	if lv_1.TotalItems ( ) > 0 then 

//--- resetto eventuale impostazioni precedenti
		dw_stampa.dataobject = "d_x_stampa_listview"

//--- genera la sezione TABLE colonne nella DW
		k_table = ""
		k_colonna = 1
		k_list_eof = lv_1.getColumn(k_colonna, k_titolo_col , k_align, k_larg_campo)
		do while  k_list_eof > 0
			k_table = k_table + " column=(type=char("+string(Len(trim(k_titolo_col)))+ ") updatewhereclause=yes name=colonna_"+string(k_colonna)+ " dbname=~"colonna_"+string(k_colonna)+ "~" )" 
			k_colonna++
			k_list_eof = lv_1.getColumn(k_colonna, k_titolo_col , k_align , k_larg_campo)
		loop

//--- copia dal tamplate		
		k_syntax = dw_stampa.describe("DataWindow.Syntax")

//--- genera una nuova dw con la nuova sez. TABLE
		k_rcn = pos(k_syntax,"table(",1)		
		if k_rcn > 0 then
			k_resto = mid(k_syntax, k_rcn + 6, len(trim(k_syntax)) - k_rcn)
			k_syntax = left(k_syntax, k_rcn -1) + "table(" + trim(k_table) + k_resto
		end if
		dw_stampa.Create ( k_syntax, k_ls_err )

//--- Insert delle nuove righe della DW
		for k_riga = 1 to lv_1.TotalItems ( )
			k_rcn=dw_stampa.insertrow (0)
		end for
		
//--- genera le colonne nella DW
		k_pos_x = 9
		k_colonna = 1
		k_list_eof = lv_1.getColumn(k_colonna, k_titolo_col , k_align, k_larg_campo)
		do while  k_list_eof > 0


//--- allineamento colonna
			choose case k_align
				case right!
					k_alignement = "1"
				case center!
					k_alignement = "2"
				case else
					k_alignement = "0"
			end choose

//--- colonna nascosta se troppo piccina
			if k_larg_campo < 50 then
				k_visible = "0"
			else
				k_visible = "1"
			end if
			
			k_rc = dw_stampa.Modify( &
		"create column( id="+string(k_colonna)+" tabsequence=0  moveable=0 resizeable=1  band=Detail "  +  &
		" x='" +string(k_pos_x)+ "' y='8' format=' [general]' alignment='"+k_alignement+"' height.autosize=No border='0' " + &
		" color='" +string(kkg_colore.nero)+"' height='76' " +  & 
		" width='"+string(k_larg_campo)+"' name=colonna_"+string(k_colonna)+ " visible='"+k_visible+"' tag=' '" + &
		" background.mode='1' background.color='"+string(kkg_colore.bianco)+"' font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' font.italic='1' font.strikethrough='0' font.underline='0' "+&
		"   ) " )
			k_rc = dw_stampa.Modify( &
		"create text(band=header alignment='"+k_alignement+"' text='"+trim(k_titolo_col)+"' name=colonna_"+string(k_colonna)+ "_t visible='"+k_visible+"' border='0' color='" +string(kkg_colore.BLU_SCURO)+"' " + & 
		"x='" +string(k_pos_x+10 )+ "' y='8' height='64' width='"+string(k_larg_campo - 10)+"' html.valueishtml='0'  font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='536870912' ) " &
										)
//		"  edit.validatecode=No edit.focusrectangle=No edit.format=' [general]' edit.hscrollbar=No edit.limit=0  edit.displayonly=Yes edit.autovscroll=Yes edit.case=Any edit.autohscroll=Yes edit.autoselect=No edit.vscrollbar=Yes ) "	&		

			
//--- popola le righe della DW
			for k_riga = 1 to lv_1.TotalItems ( )
				
				lv_1.getitem ( k_riga, k_colonna, k_valore)
				k_rcn = dw_stampa.setitem (k_riga, k_colonna, k_valore)				
				
			end for

			k_pos_x = k_larg_campo+k_pos_x + 1	
			k_colonna++
			k_list_eof = lv_1.getColumn(k_colonna, k_titolo_col , k_align , k_larg_campo)

		loop
			
		
	end if

//	k_rc = dw_stampa.describe("DataWindow.Syntax")

	
	SetPointer(oldpointer)



end subroutine

private function integer forma_tree (long k_handle_item_padre);//---
//--- valorizza la tree con i dati ricercati a seconda del tipo oggetto
//---
int k_return
kuf_treeview kuf1_treeview

//	tv_root.triggerevent ("u_riempi_treeview")
	tv_root.triggerevent (itemexpanding!)

return k_return

end function

protected function string inizializza () throws uo_exception;//
//=== Routine STANDARD CHIAMATA SUBITO DOPO LA OPEN
//=== Ritorna 0=ok 1=errore
//
string k_return="0"
long k_handle_item


	ki_flag_tree_appena_espanso = false

//--- questo click x far vedere la root	
	if ki_st_open_w.flag_primo_giro = "S" then 

//		tv_root.setredraw( false)
//		lv_1.setredraw( false )
		
//--- seleziono item root solo la prima volta 	
		k_handle_item = tv_root.finditem(RootTreeItem!, 0)
		if k_handle_item > 0 then
			tv_root.selectitem( k_handle_item )
		end if
		cliccato_tree()
//--- questo click x far vedere i figli della root	
		cliccato_tree()

//		tv_root.setredraw(true)
//		lv_1.setredraw( true)
	end if


//--- Flag Primo Giro a off
	fine_primo_giro()
  
  	

return k_return 
end function

protected subroutine inizializza_lista ();//
st_esito kst_esito
pointer 	kpointer_orig 


	

try

	kpointer_orig = setpointer(hourglass!)
	
//--- operazioni necessarie di inizio programma (come check sicurezza)
//	super::inizializza_lista()

	kst_esito = kiuf_treeview.u_select_tab_treeview_all()
	if kst_esito.esito <> kkg_esito.ok then

		messagebox("Accesso al Navigatore", &
		           "Anomalia durante la composizione della struttura~n~r" &
					  + kst_esito.sqlerrtext + " Errore:" &
					  + string(kst_esito.sqlcode), & 
					  stopsign!, OK! )
					  
//--- se errore forza FINE!
		smista_funz(kkg_flag_richiesta_esci)

	else
		inizializza()
		attiva_tasti()
		event u_activate( )
	end if
	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
finally
	setpointer(kpointer_orig)	


end try
	
	
end subroutine

private subroutine open_dettaglio (string k_operazione);//
boolean k_attiva_funzione=false
//treeviewitem ktvi_1
st_esito kst_esito



kst_esito.esito = kkg_esito.ok

choose case  k_operazione 

	case kkg_flag_richiesta.inserimento		//richiesta inserimento
		if st_inserisci.enabled then
			k_attiva_funzione = true
		end if
		
	case kkg_flag_richiesta.cancellazione		//richiesta cancellazione
		if st_cancella.enabled then
			k_attiva_funzione = true
		end if

	case kkg_flag_richiesta.visualizzazione		//richiesta visualizzazione
		if st_visualizza.enabled then
			k_attiva_funzione = true
		end if
		
	case kkg_flag_richiesta.modifica		//richiesta modifica
		if st_modifica.enabled then
			k_attiva_funzione = true
		end if

	case kkg_flag_richiesta.stampa		//richiesta stampa
		if st_stampa.enabled then
			if tv_root.finditem(CurrentTreeItem!, 0) > 0 then 
				k_attiva_funzione = true
			end if
		end if


end choose

//--- se ho trovato una funzione da Aprire, eseguo!
if k_attiva_funzione then

//	kiuf_treeview.kitv_tv1 = tv_root
//	kiuf_treeview.kilv_lv1 = lv_1
	kst_esito = kiuf_treeview.u_open ( k_operazione)
	
	if kst_esito.esito <> kkg_esito.ok then
	
		if k_operazione = kkg_flag_richiesta.stampa then
			
			stampa_anteprima()
			
//			if messagebox("Operazione non Eseguita", &
//					"Stampa per la riga selezionata non operativa.~n~r"  &
//					  + "E' possibile stampare l'elenco delle righe del Navigatore con un altro pulsante.~n~r" &
//					  + "Procedere con la stampa delle righe in elenco così come è visualizzata?", Question!, yesno!, 1) = 1 then
//				stampa()
//			end if
		else
			messagebox("Operazione non Eseguita", &
					  kst_esito.sqlerrtext)
		end if
	end if	

//	kGuf_data_base.mostra_windows_attiva()

end if


end subroutine

public subroutine resetta ();
//--- Crea istanza oggetto con le funzioni per gestire il tutto
if isvalid(kiuf_treeview) then destroy kiuf_treeview

GarbageCollect ( )  //forza pulizia del garbage collection

sleep(0.5)

kiuf_treeview = create kuf_treeview
//--- Imposta gli oggetti nel Kuf_treeview
kiuf_treeview.set_kitv_tv1 (tv_root)
kiuf_treeview.set_kilv_lv1 (lv_1)
kiuf_treeview.set_dw_anteprima(dw_anteprima)

//--- listView x selezionare + righe
lv_1.ExtendedSelect = TRUE

end subroutine

protected subroutine open_start_window ();//
kuf_base kuf1_base

	
resetta()  // crea l'oggetto KIUF_TREEVIEW

//--- imposta le icone nella tree e list
kiuf_treeview.u_imposta_treeview_icone(tv_root,  lv_1)

ki_titolo_window_orig = this.title

ki_toolbar_window_presente=true
dw_anteprima.Object.DataWindow.ReadOnly='Yes'

//lv_1.visible = true

u_set_window_size()

inizializza_lista()

kiuf_menu_popup = create kuf_menu_popup

kuf1_base = create kuf_base
ki_zoom = mid(kuf1_base.prendi_dato_base("tv_zoom"), 2)
if ki_zoom > " " or isnumber(ki_zoom) then
	ki_zoom = trim(ki_zoom)
else
	ki_zoom = "120"
end if
destroy kuf1_base





end subroutine

private subroutine treeview_collassa_tutti_i_rami ();//
long k_collassa_item, k_hdl = 0, k_hdl1=0
treeviewitem ktvi_1


try
	k_collassa_item = tv_root.FindItem(roottreeitem!, 0)
	if k_collassa_item > 0 then
		
		tv_root.CollapseItem(k_collassa_item)

//--- cancella tutti i figli tranne quelli di root
		k_hdl = tv_root.finditem(ChildTreeItem!, k_collassa_item)
		DO UNTIL k_hdl = -1
		
			k_hdl1 = tv_root.finditem(ChildTreeItem!, k_hdl)
			DO UNTIL k_hdl1 = -1
			
				 tv_root.DeleteItem(k_hdl1)
			
				k_hdl1 = tv_root.finditem(ChildTreeItem!, k_hdl)
			LOOP	
			
			k_hdl = tv_root.finditem(NextTreeItem!, k_hdl)
		LOOP	
	end if
		
//--- cancello dalla listview tutto
	lv_1.DeleteItems()

	ki_st_open_w.flag_primo_giro = "S"
	resetta()  // crea l'oggetto KUF_TREEVIEW
	inizializza_lista()	

//--- per x far vedere la root	
//   	ki_st_open_w.flag_primo_giro = "S" 
//	inizializza()

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end subroutine

public subroutine smista_funz (string k_par_in);//
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : tag della window
//===
long k_handle_item = 0, k_handle_item_padre = 0
kuf_treeview kuf1_treeview
//treeviewitem ktvi_1
listviewitem klvi_1


try

	//--- se schiacciato CERCA metto il fuoco prioritariamente sulla lista
	if k_par_in =  KKG_FLAG_RICHIESTA.trova or k_par_in = KKG_FLAG_RICHIESTA.trova_ancora  then
		if lv_1.visible then 
			lv_1.setfocus()
		else
			tv_root.setfocus( )
		end if
		
	end if
	
	choose case  k_par_in 
	
		case KKG_FLAG_RICHIESTA.refresh				//Aggiorna Liste
			aggiorna_liste()
	
	//richiesta inserimento //richiesta cancellazione //richiesta visualizzazione //richiesta modifica	//richiesta stampa
		case KKG_FLAG_RICHIESTA.inserimento		&	
				, KKG_FLAG_RICHIESTA.cancellazione  &		
				, KKG_FLAG_RICHIESTA.visualizzazione &	
				, KKG_FLAG_RICHIESTA.modifica		&		
				, KKG_FLAG_RICHIESTA.stampa	  	
			open_dettaglio(k_par_in)
	
	
		case KKG_FLAG_RICHIESTA.libero1		//cambia data
			u_set_data_certif_da_st( )
	
		case KKG_FLAG_RICHIESTA.libero2		//collassa rami tree
			treeview_collassa_tutti_i_rami()
	
		case KKG_FLAG_RICHIESTA.libero3	//Stampa datawindow attiva
			stampa()
	
		case KKG_FLAG_RICHIESTA.libero4	//Invia email (anzi open di outlook)
			u_open_email( )
	
		case KKG_FLAG_RICHIESTA.libero71	//visualizzazione list 
			lv_1.view = listviewlargeicon!
	
		case KKG_FLAG_RICHIESTA.libero72	//visualizzazione list 
			lv_1.view = listviewsmallicon!
	
		case KKG_FLAG_RICHIESTA.libero73	//visualizzazione list 
			lv_1.view = listviewlist!
	
		case KKG_FLAG_RICHIESTA.libero74	//visualizzazione list 
			lv_1.view = listviewreport!
	
		case KKG_FLAG_RICHIESTA.libero8 //Chiama Lotto x le Autorizzazioni
			kiuf_treeview.u_open_riferimenti_autorizza( )
	
		case KKG_FLAG_RICHIESTA.VISUALIZZ_PREDEFINITA
			ki_st_vertical = true
			ki_st_orizzontal = true
			u_resize_predefinita( )
			u_resize_default( )
	
		case else
			super::smista_funz(k_par_in)
	//		messagebox("Operazione non Eseguita", &
	//					"Funzione richiesta non Abilitata")
	
	
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try	


end subroutine

protected subroutine stampa_esegui (st_stampe ast_stampe);//


choose case kigrf_x_trova.classname( )

	case "lv_1", "tv_root"
		crea_dw_stampa_da_listview()

		ast_stampe.dw_print = dw_stampa
		if len(trim(this.title)) > 60 then
			ast_stampe.titolo = Right(trim(this.title), 60) 
		else
			ast_stampe.titolo = this.title 
		end if
		if ast_stampe.dw_print.rowcount() > 0 then
		
			ast_stampe.dw_syntax = trim(dw_stampa.describe("DataWindow.Syntax"))
			
			kGuf_data_base.stampa_dw(ast_stampe)
		
		end if
		
	case else
		
		stampa_anteprima()

end choose



	
end subroutine

private subroutine u_add_memo_link (string a_file[], integer a_file_nr);//
boolean k_rc=false
long k_riga=0
//int k_risposta_load_memo_link = 1
st_open_w kst_open_w
st_tab_memo_link kst_tab_memo_link[] 
st_memo kst_memo
//st_treeview_data kst_treeview_data
kuf_memo_inout kuf1_memo_inout
kuf_memo_link kuf1_memo_link
kuf_utility kuf1_utility
kuf_sr_sicurezza kuf1_sr_sicurezza


try   
	if NOT isvalid(kuf1_utility) then kuf1_utility = create kuf_utility 
	if NOT isvalid(kuf1_memo_inout) then kuf1_memo_inout = create kuf_memo_inout 
	if NOT isvalid(kuf1_sr_sicurezza) then kuf1_sr_sicurezza = create kuf_sr_sicurezza 
			

	for k_riga = 1 to a_file_nr
		kst_tab_memo_link[k_riga].link =a_file[k_riga]
		kst_tab_memo_link[k_riga].memo_link_load = kuf1_memo_link.kki_memo_link_load_si
	next
	if a_file_nr > 0 then
		kst_open_w.key11_ds = create datastore
		kst_open_w.key11_ds.dataobject = dw_anteprima.dataobject
		dw_anteprima.rowscopy(1, 1, primary!, kst_open_w.key11_ds , 1, primary!) 
		kst_open_w.id_programma = kiuf_treeview.u_get_open_programma( )
		kst_memo.st_tab_meca_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ki_st_open_w.id_programma)
		kst_memo.st_tab_memo_link = kst_tab_memo_link[]
		k_rc = kuf1_memo_inout.crea_memo(kst_memo, kst_open_w)
	end if
	
	if k_rc then
		u_anteprima() // refresh del dw_anteprima
	else
		messagebox("Operazione annullata", "Non è possibile creare alcun MEMO da qui", information!)
	end if

		
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public subroutine u_anteprima ();//	
//--- attivo modalita' anteprima nella apposita dw_anteprima		
	if isvalid(dw_anteprima) then
		if dw_anteprima.visible and dw_anteprima.enabled  then
			dw_anteprima.enabled = false
			
			yield()   // non impegno la window
			
			kiuf_treeview.u_open ( kkg_flag_modalita.anteprima )
			dw_anteprima.enabled = true
					
			if len(trim(dw_anteprima.dataobject)) > 0 then
				if dw_anteprima.rowcount( ) > 0 then
					
			
					dw_anteprima.Object.DataWindow.Print.Preview.Zoom = ki_zoom
					dw_anteprima.SetRedraw(TRUE)

					setpointer(kkg.pointer_default)
					
//--- attiva eventuale Drag&Drop di files da Windows	Explorer
//					if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
//					kiuf_file_dragdrop.u_attiva(handle(lv_1))

				end if
			end if
		end if
	end if

	attiva_tasti()
end subroutine

public function long u_drop_file (integer a_k_tipo_drag, long a_handle);//
int k_sn
long k_file_nr
string k_file_drop[]


if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 

k_file_nr = kiuf_file_dragdrop.u_get_file(a_k_tipo_drag, a_handle, k_file_drop[])

if k_file_nr > 0 then	
	kGuf_data_base.set_focus(a_handle) // dovrebbe prendere il fuoco

	if k_file_nr = 1 then
		k_sn = messagebox("Creazione MEMO", "Vuoi caricare il nuovo MEMO con il documento " + trim(k_file_drop[1]) +" ? ", question!, yesno!, 2) 
	else
		k_sn = messagebox("Creazione MEMO", "Vuoi caricare il nuovo MEMO con i " + string(k_file_nr) + " documenti trascinati qui? ", question!, yesno!, 2) 
	end if
	if k_sn = 1 then
		
		u_add_memo_link(k_file_drop[], k_file_nr)  // Aggiunge MEMO e Allagati

//--- attivo modalita' anteprima nella apposita dw_anteprima		
		u_anteprima()

	end if
end if

return k_file_nr
end function

protected subroutine u_key (keycode key, unsignedlong keyflags);//---
//--- get key pressed
//---
choose case key
	case KeyEscape!
		u_zoom_off(dw_anteprima )
	case KeyAdd!
	case KeyEqual!
		u_zoom_piu(dw_anteprima)   //Zoomma +
	case KeySubtract!
	case KeyDash!
		u_zoom_meno(dw_anteprima)   //Zoomma -
end choose




end subroutine

public subroutine u_zoom_meno (uo_d_std_1 adw_1);//
//--- diminuisce 
//
int k_zoom


	k_zoom = integer(adw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom < 10 then
		k_zoom = 100
	else
		k_zoom -= 5
	end if
//	if k_zoom = 100 then
//		adw_1.Object.DataWindow.Print.Preview = "No"
//	else
//		adw_1.Object.DataWindow.Print.Preview = "Yes"
//	end if
	ki_zoom = string(k_zoom)
	adw_1.Object.DataWindow.Print.Preview.Zoom = ki_zoom
	adw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_off (uo_d_std_1 adw_1);//
//--- diminuisce 
//
//	adw_1.Object.DataWindow.Print.Preview = "No"
	adw_1.Object.DataWindow.Print.Preview.Zoom = "100"
	ki_zoom = "100"
	adw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_zoom_piu (uo_d_std_1 adw_1);//
//--- ingrandisce 
//
int k_zoom

	k_zoom = integer(adw_1.Object.DataWindow.Print.Preview.Zoom)
	if k_zoom > 1000 then
		k_zoom = 100
	else
		k_zoom += 5
	end if
//	if k_zoom = 100 then
//		adw_1.Object.DataWindow.Print.Preview = "No"
//	else
//		adw_1.Object.DataWindow.Print.Preview = "Yes"
	//	adw_1.Object.DataWindow.Print.Margin.Bottom = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Left = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Right = '0'
	//	adw_1.Object.DataWindow.Print.Margin.Top = '0'
	//	adw_1.Object.DataWindow.Print.paper.source = '0'
//	end if
	ki_zoom = string(k_zoom)
	adw_1.Object.DataWindow.Print.Preview.Zoom = ki_zoom
	adw_1.SetRedraw(TRUE)

end subroutine

public subroutine u_set_window_size ();//
string k_visible, k_view
string k_pos, k_rcx
st_profilestring_ini kst_profilestring_ini
//


//	this.setredraw( false)
////--- fissa le dimensione delle barette verticale e orizzontale
//	st_vertical.width = 20
//	st_vertical.y = 30
//	st_orizzontal.height =15
//	st_orizzontal.x = 30
//	dw_stampa.visible = false
//	
////--- Imposto i campi x prelevare dal INI i valori
//	kst_profilestring_ini.operazione = "1"
//	kst_profilestring_ini.valore = "0"
//	kst_profilestring_ini.file = "treeview"
//	kst_profilestring_ini.titolo = "treeview"
////--- Eventualmente nasconde la tree
//	kst_profilestring_ini.nome = "treeview_nascondi_tree"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	k_visible = "1"
//	if kst_profilestring_ini.esito <> "1" then
//		k_visible = trim(kst_profilestring_ini.valore)
//	end if
//	if k_visible = "0" then
//		ki_st_vertical = false
//	else
//		ki_st_vertical = true
//	end if
//
////--- Eventualmente nasconde la Anteprima
//	kst_profilestring_ini.nome = "treeview_nascondi_anteprima"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	k_visible = "1"
//	if kst_profilestring_ini.esito <> "1" then
//		k_visible = trim(kst_profilestring_ini.valore)
//	end if
//	if k_visible = "0" then
//		ki_st_orizzontal = false
//	else
//		ki_st_orizzontal = true
//	end if
//
////--- Posizione delle ST_ x confine tra tree e list e anteprima
//	kst_profilestring_ini.nome = "treeview_pos_vertical"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	k_pos = "0"
//	if kst_profilestring_ini.esito <> "1" then
//		k_pos = trim(kst_profilestring_ini.valore)
//	end if
//	if not isnull(k_pos) and isnumber(k_pos) then
//		if long(k_pos) = 0 then
//			st_vertical.x = this.width / 3.5 - 60		
//		else
//			st_vertical.x = long(k_pos)
//		end if
//	else
//		st_vertical.x = this.width / 3.5 - 60		
//	end if
//	kst_profilestring_ini.nome = "treeview_pos_orizzontal"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	k_pos = "0"
//	if kst_profilestring_ini.esito <> "1" then
//		k_pos = trim(kst_profilestring_ini.valore)
//	end if
//	if not isnull(k_pos) and isnumber(k_pos) then
//		if long(k_pos) = 0 then
//			st_orizzontal.y = this.height * 0.80
//		else
//			st_orizzontal.y = long(k_pos)
//		end if
//	else
//		st_orizzontal.y = this.height * 0.80
//	end if
//	
//--- Tipo visualizzazione della list
	kst_profilestring_ini.nome = "listview_view"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	k_view = "4"
	if kst_profilestring_ini.esito <> "1" then
		k_view = trim(kst_profilestring_ini.valore)
	end if
	if not isnull(k_view) then
		choose case k_view
			case "1" 
				lv_1.view = ListViewLargeIcon! 
			case "2" 
				lv_1.view = ListViewSmallIcon! 
			case "3" 
				lv_1.view = ListViewList! 
			case "4" 
				lv_1.view = ListViewReport! 
		end choose
	end if

	this.backcolor = rgb(255,255,255)
//	this.setredraw(true)

//	this.visible = true
	
end subroutine

public function integer u_open_email () throws uo_exception;//
int k_return 


try

	SetPointer(kkg.pointer_attesa)

	k_return = kiuf_treeview.u_open_email( )
	if k_return > 0 then
		if k_return > 1 then
			messagebox("E-mail", "Sono state preparate " + string(k_return) + " email", information!) 
		else
			messagebox("E-mail", "E' stata preparate una email da inviare con il programma predefinito", information!) 
		end if
	else
		messagebox("E-mail", "Nessuna email da inviare", information!) 
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	SetPointer(kkg.pointer_default)

end try	

		

return 0
end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


if lv_1.totalitems( ) > 0 then
	st_inserisci.enabled = true
	st_conferma.enabled = false
	st_modifica.enabled = true
	st_cancella.enabled = true
	st_visualizza.enabled = true
	st_ordina_lista.enabled = true
else
	st_inserisci.enabled = false
	st_conferma.enabled = false
	st_modifica.enabled = false
	st_cancella.enabled = false
	st_visualizza.enabled = false
	st_ordina_lista.enabled = false
end if
            



end subroutine

public subroutine u_obj_visible_0 ();//
		lv_1.visible = true
		tv_root.visible = st_vertical.visible
		dw_anteprima.visible = st_orizzontal.visible

end subroutine

public function boolean u_resize_predefinita ();//---

		this.setredraw(false)

		tv_root.x = 1 //15
		tv_root.y = 1 //15
		lv_1.y = 1
		dw_anteprima.x = 1
		st_vertical.y = 1
		st_orizzontal.x = 1
		st_vertical.width = 20
		st_orizzontal.height = 20

		st_vertical.visible = ki_st_vertical
		st_orizzontal.visible = ki_st_orizzontal
      
		if st_vertical.visible then
			st_vertical.X = this.width / 10
			tv_root.width = st_vertical.X - st_vertical.width 
			lv_1.width =  this.width - st_vertical.X - st_vertical.width // -70 
		else
			lv_1.width = this.width //- 75 
		end if

		if st_orizzontal.visible then
			st_orizzontal.y = this.height * 0.7 //- 200
		else
			st_orizzontal.y = this.height
		end if

		st_vertical.height = st_orizzontal.y

//		if st_vertical.visible then
//			lv_1.x = st_vertical.x + st_vertical.width 
//			st_vertical.bringtotop = true
//		end if
//		
//		if st_orizzontal.visible then
//			st_orizzontal.width = this.width
//			st_orizzontal.bringtotop = true
//			dw_anteprima.y = st_orizzontal.y + st_orizzontal.height
//			dw_anteprima.height = this.height - st_orizzontal.y - st_orizzontal.height //- 240 
//			dw_anteprima.width = st_orizzontal.width 
//			 lv_1.height = this.height - st_orizzontal.y 
//		end if
//	
//		lv_1.height = st_vertical.height
//		tv_root.height = st_vertical.height 
//
//		lv_1.visible = true
//		tv_root.visible = st_vertical.visible
//		dw_anteprima.visible = st_orizzontal.visible
	
		this.setredraw(true)

//		this.visible = true

return TRUE

end function

protected subroutine set_titolo_window_personalizza ();//
//--- da non fare
end subroutine

public subroutine u_wtitolo_path (st_treeview_data ast_treeview_data);//
string k_path 
int k_rc
//long k_handle
treeviewitem ktv_treeviewitem
st_treeview_data kst_treeview_data


//kst_treeview_data = kiuf_treeview.u_get_st_treeview_data( )
kst_treeview_data = ast_treeview_data

//if kst_treeview_data.handle > 0 then
//	k_path = trim(kst_treeview_data.label)
//end if
//kst_treeview_data = kiuf_treeview.u_get_st_treeview_data_padre()
//if kst_treeview_data.handle > 0 then
//
//	k_handle = kst_treeview_data.handle
//	
//	k_rc = tv_root.getitem(k_handle, ktv_treeviewitem) 
//	k_path = trim(ktv_treeviewitem.label) 
	
	if kst_treeview_data.handle = 0 then
		kst_treeview_data.handle = kst_treeview_data.handle_padre
		kst_treeview_data = kiuf_treeview.u_get_st_treeview_data(kst_treeview_data)
	end if

	if kst_treeview_data.handle > 0 then
		k_path = trim(kst_treeview_data.label)
		if kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list then
			kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree
			kst_treeview_data.handle = kst_treeview_data.handle_padre
			kst_treeview_data = kiuf_treeview.u_get_st_treeview_data(kst_treeview_data)
		else
			if kst_treeview_data.handle > 1 then
				kst_treeview_data.handle = tv_root.finditem (Parenttreeitem!, kst_treeview_data.handle)
//				kst_treeview_data.handle = kst_treeview_data.handle_padre
				if  kst_treeview_data.handle = 0  then
					k_rc = tv_root.getitem(1, ktv_treeviewitem) 
					if k_path > " " then
						k_path = trim(ktv_treeviewitem.label) + "\" + k_path
					else
						k_path = trim(ktv_treeviewitem.label) 
					end if
				end if
			else
				kst_treeview_data.handle = 0
			end if
		end if
	end if
	
	if  kst_treeview_data.handle > 0  then
		do while  kst_treeview_data.handle > 0 
		//	k_handle = tv_root.finditem (Parenttreeitem!,k_handle )
			if kst_treeview_data.handle > 0 then
				k_rc = tv_root.getitem(kst_treeview_data.handle, ktv_treeviewitem) 
				if k_path > " " then
					k_path = trim(ktv_treeviewitem.label) + "\" + k_path
				else
					k_path = trim(ktv_treeviewitem.label) 
				end if
			end if
			//kst_treeview_data = kiuf_treeview.u_get_st_treeview_data(kst_treeview_data)
			//kst_treeview_data.handle = kst_treeview_data.handle_padre
			kst_treeview_data.handle = tv_root.finditem (Parenttreeitem!, kst_treeview_data.handle)
		loop 
		if  kst_treeview_data.handle = 0  then
			k_rc = tv_root.getitem(1, ktv_treeviewitem) 
			if k_path > " " then
				k_path = trim(ktv_treeviewitem.label) + "\" + k_path
			else
				k_path = trim(ktv_treeviewitem.label) 
			end if
		end if
//	else
//		k_rc = tv_root.getitem(1, ktv_treeviewitem) 
//		if k_path > " " then
//			k_path = trim(ktv_treeviewitem.label) + "\" + k_path
//		else
//			k_path = trim(ktv_treeviewitem.label) 
//		end if
	end if
	
	if k_path > " " then
		this.title = "\" + k_path
	else
		this.title = ki_titolo_window_orig
	end if

//end if


end subroutine

public subroutine u_resize_1 ();//---
long k_width_orig, k_height_orig


	this.setredraw(false)

	tv_root.x = 1 //15
	tv_root.y = 1 //15
	lv_1.y = 1
	dw_anteprima.x = 1
	st_vertical.y = 1
	st_orizzontal.x = 1
	st_vertical.width = 20
	st_orizzontal.height = 20

	st_vertical.visible = ki_st_vertical
	st_orizzontal.visible = ki_st_orizzontal

	if ki_st_orizzontal then
		k_width_orig = st_orizzontal.width
		k_height_orig = st_orizzontal.y + st_orizzontal.height + dw_anteprima.height
	else
		k_height_orig = tv_root.height
		if ki_st_vertical then
			k_width_orig = st_vertical.X + st_vertical.width + lv_1.width
		else
			k_width_orig = tv_root.width
		end if
	end if
		
	if k_width_orig > 0 then
		
		if ki_st_vertical then
			st_vertical.X = this.width * (((100 / k_width_orig) * st_vertical.X) / 100)
		end if
		if ki_st_orizzontal then
			st_orizzontal.Y = this.height * (((100 / k_height_orig) * st_orizzontal.y) / 100)
		end if
		
		if st_vertical.visible then
			tv_root.width = st_vertical.X - st_vertical.width 
			lv_1.width =  this.width - st_vertical.X - st_vertical.width // -70 
		else
			lv_1.width = this.width //- 75 
		end if

		if st_vertical.visible then
			lv_1.x = st_vertical.x + st_vertical.width 
			st_vertical.bringtotop = true
		end if
		st_vertical.height = st_orizzontal.y
		
		if st_orizzontal.visible then
			st_orizzontal.width = this.width
			st_orizzontal.bringtotop = true
			dw_anteprima.y = st_orizzontal.y + st_orizzontal.height
			dw_anteprima.height = this.height - st_orizzontal.y - st_orizzontal.height //- 240 
			dw_anteprima.width = st_orizzontal.width 
			 lv_1.height = this.height - st_orizzontal.y 
		end if
	
		lv_1.height = st_vertical.height
		tv_root.height = st_vertical.height 

		lv_1.visible = true
		tv_root.visible = st_vertical.visible
		dw_anteprima.visible = st_orizzontal.visible
	
	end if
	this.setredraw(true)



end subroutine

private subroutine u_set_data_certif_da_st ();//---
//--- Visualizza il box x il cambio DATA
//---


//dw_data1.triggerevent("ue_visibile")
//
//kiw_parent = kiw_this_window
//super::event ue_visible( )

if kiuf_treeview.ki_data_certif_da_st_da > date(0) then
else
	ki_data_ini = kkg.data_zero 
end if
if kiuf_treeview.ki_data_certif_da_st_a > date(0) then
else
	ki_data_fin = kguo_g.get_dataoggi( )
end if

//
int k_rc

	dw_data1.width = long(dw_data1.object.data_al.x) + long(dw_data1.object.data_al.width) + 100
	dw_data1.height = long(dw_data1.object.b_ok.y) + long(dw_data1.object.b_ok.height) + 160

	dw_data1.x = (kiw_this_window.width  - dw_data1.width) / 4
	dw_data1.y = (kiw_this_window.height - dw_data1.height) / 4

	dw_data1.reset()
	k_rc = dw_data1.insertrow(0)
	k_rc = dw_data1.setitem(1, "data_dal", ki_data_ini)
	k_rc = dw_data1.setitem(1, "data_al", ki_data_fin)

	dw_data1.visible = true
	dw_data1.enabled = true
	dw_data1.setfocus()
end subroutine

protected subroutine stampa_anteprima ();//

 st_stampe kst_stampe


		if dw_anteprima.visible then
			if dw_anteprima.rowcount( ) > 0 then
				dw_stampa.dataobject = dw_anteprima.dataobject
				dw_anteprima.rowscopy( 1, dw_anteprima.rowcount(), primary!, dw_stampa, 1, primary!)
				kst_stampe.dw_print = dw_stampa
				lv_1.getitem( lv_1.selectedindex( ) ,1, kst_stampe.titolo) 
				kst_stampe.titolo = Right(trim(trim(this.title)+kst_stampe.titolo), 60)
			
				if kst_stampe.dw_print.rowcount() > 0 then
				
					kst_stampe.dw_syntax = trim(dw_stampa.describe("DataWindow.Syntax"))
					
					kGuf_data_base.stampa_dw(kst_stampe)
				
				end if
			end if
		end if




	
end subroutine

public subroutine u_resize ();//
super::u_resize( )

u_resize_default()
end subroutine

public subroutine u_resize_default ();//---
long k_width_orig, k_height_orig


	this.setredraw(false)

	if ki_st_orizzontal then
		k_width_orig = st_orizzontal.width
		k_height_orig = st_orizzontal.y + st_orizzontal.height + dw_anteprima.height
	else
		k_height_orig = tv_root.height
		if ki_st_vertical then
			k_width_orig = st_vertical.X + st_vertical.width + lv_1.width
		else
			k_width_orig = tv_root.width
		end if
	end if
		
	if k_width_orig > 0 then
		
		if ki_st_vertical then
			st_vertical.X = this.width * (((100 / k_width_orig) * st_vertical.X) / 100)
		end if
		if ki_st_orizzontal then
			st_orizzontal.Y = this.height * (((100 / k_height_orig) * st_orizzontal.y) / 100)
		end if
		
		if st_vertical.visible then
			tv_root.width = st_vertical.X - st_vertical.width 
			lv_1.width =  this.width - st_vertical.X - st_vertical.width // -70 
		else
			lv_1.width = this.width //- 75 
		end if

		if st_vertical.visible then
			lv_1.x = st_vertical.x + st_vertical.width 
			st_vertical.bringtotop = true
		end if
		st_vertical.height = st_orizzontal.y
		
		if st_orizzontal.visible then
			st_orizzontal.width = this.width
			st_orizzontal.bringtotop = true
			dw_anteprima.y = st_orizzontal.y + st_orizzontal.height
			dw_anteprima.height = this.height - st_orizzontal.y - st_orizzontal.height //- 240 
			dw_anteprima.width = st_orizzontal.width 
			 lv_1.height = this.height - st_orizzontal.y 
		end if
	
		lv_1.height = st_vertical.height
		tv_root.height = st_vertical.height 

		lv_1.visible = true
		tv_root.visible = st_vertical.visible
		dw_anteprima.visible = st_orizzontal.visible
	
	end if
	this.setredraw(true)

		this.visible = true


end subroutine

on w_g_tab_tv.create
int iCurrent
call super::create
this.tv_root=create tv_root
this.lv_1=create lv_1
this.dw_anteprima=create dw_anteprima
this.dw_stampa=create dw_stampa
this.st_cancella=create st_cancella
this.st_conferma=create st_conferma
this.st_inserisci=create st_inserisci
this.st_modifica=create st_modifica
this.st_visualizza=create st_visualizza
this.st_orizzontal=create st_orizzontal
this.st_vertical=create st_vertical
this.dw_data1=create dw_data1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_root
this.Control[iCurrent+2]=this.lv_1
this.Control[iCurrent+3]=this.dw_anteprima
this.Control[iCurrent+4]=this.dw_stampa
this.Control[iCurrent+5]=this.st_cancella
this.Control[iCurrent+6]=this.st_conferma
this.Control[iCurrent+7]=this.st_inserisci
this.Control[iCurrent+8]=this.st_modifica
this.Control[iCurrent+9]=this.st_visualizza
this.Control[iCurrent+10]=this.st_orizzontal
this.Control[iCurrent+11]=this.st_vertical
this.Control[iCurrent+12]=this.dw_data1
end on

on w_g_tab_tv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_root)
destroy(this.lv_1)
destroy(this.dw_anteprima)
destroy(this.dw_stampa)
destroy(this.st_cancella)
destroy(this.st_conferma)
destroy(this.st_inserisci)
destroy(this.st_modifica)
destroy(this.st_visualizza)
destroy(this.st_orizzontal)
destroy(this.st_vertical)
destroy(this.dw_data1)
end on

event close;call super::close;//
string k_visible = "1", k_view
string k_pos, k_rcx
st_tab_base kst_tab_base
st_profilestring_ini kst_profilestring_ini
kuf_base kuf1_base


//--- Imposto i campi x prelevare dal INI i valori
	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = "treeview"
	kst_profilestring_ini.titolo = "treeview"

//--- Aggiorno flag se nascondere la tree
	if	tv_root.visible = false then
		k_visible = "0"
	end if
	kst_profilestring_ini.nome = "treeview_nascondi_tree"
	kst_profilestring_ini.valore = k_visible
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	if dw_anteprima.visible = false then
		k_visible = "0"
	end if
	kst_profilestring_ini.nome = "treeview_nascondi_anteprima"
	kst_profilestring_ini.valore = k_visible
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	choose case lv_1.view
		case ListViewLargeIcon!
			k_view = "1" 
		case ListViewSmallIcon! 
			k_view = "2" 
		case ListViewList! 
			k_view = "3"
		case ListViewReport! 
			k_view = "4" 
		case else
			k_view = "4" 
	end choose
	kst_profilestring_ini.nome = "listview_view"
	kst_profilestring_ini.valore = k_view
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

//--- Salva Posizioni delle ST_ x confine tra tree e list e anteprima
	k_pos = string(st_vertical.x)
	kst_profilestring_ini.nome = "treeview_pos_vertical"
	kst_profilestring_ini.valore = k_pos
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	k_pos = string(st_orizzontal.y)
	kst_profilestring_ini.nome = "treeview_pos_orizzontal"
	kst_profilestring_ini.valore = k_pos
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))


	if isvalid(kiuf_treeview) then destroy kiuf_treeview
	if isvalid(kiuf_menu_popup) then destroy kiuf_menu_popup

//--- salva la dimensione dello ZOOM
	kuf1_base = create kuf_base
	kst_tab_base.key = "tv_zoom"
	if not isnull(dw_anteprima.Object.DataWindow.Print.Preview.Zoom) then
		ki_zoom = dw_anteprima.Object.DataWindow.Print.Preview.Zoom
	end if
	kst_tab_base.key1 = ki_zoom
	kst_tab_base.st_tab_g_0.esegui_commit = "S"
	kuf1_base.metti_dato_base(kst_tab_base)
	destroy kuf1_base

	//--- forza la chiamata al gestore di memoria
//	GarbageCollect ( )
	

end event

event u_open;call super::u_open;//
	dw_data1.visible = false
	u_resize()
	dw_data1.move( 8000, 8000)
	

end event

event u_open_preliminari;call super::u_open_preliminari;//
// DA TOGLIERE APPENA TUTTI HANNO AGGIORNATO ALLA VER 18.0806 E IN TABELLA METTERE PERS.CONTROLLI PER TREEVIEW
ki_st_open_w.st_tab_menu_window.salva_controlli = "S" 
ki_salva_controlli = true
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

end event

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_tv
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_tv
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_tv
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_tv
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_tv
end type

type tv_root from treeview within w_g_tab_tv
event u_rbuttondown pbm_rbuttondown
boolean visible = false
integer x = 18
integer width = 814
integer height = 972
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 553648127
boolean border = false
boolean hasbuttons = false
boolean linesatroot = true
boolean trackselect = true
string picturename[] = {"","","","","","",""}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event u_rbuttondown;//
//---- menu contestuale
//
int k_xpos, k_ypos


//	kuf1_menu_popup = create kuf_menu_popup
	k_xpos = xpos + this.x  
	k_ypos = ypos + this.y 
	kiuf_menu_popup.u_popup(k_xpos, k_ypos)

//	destroy kuf1_menu_popup

end event

event clicked;//
ki_flag_tree_appena_espanso = false

kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree


ki_listview_index = 0 //azzero l'indice x anteprima


attiva_tasti( )

end event

event dragdrop;//

//	kiuf_treeview.u_treeview_dragdrop( source, handle)



end event

event dragwithin;////
//
//
////
////	kiuf_treeview.kitv_tv1 = tv_root
////	kiuf_treeview.kilv_lv1 = lv_1
////
////	kiuf_treeview.u_treeview_dragwithin( source, handle)  //ATTENZIONE PROBABILE CHE QUESTA ISTR. MANDA IN CRASH TUTTO!!!!!
////
//






end event

event getfocus;//
kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree

attiva_tasti()

end event

event itemcollapsed;//
treeviewitem ktvi_1

	if tv_root.finditem(NextVisibleTreeItem!, tv_root.finditem(RootTreeItem!, 0)) < 1 then
		leggi_ramo_treeviewitem()
	end if
	parent.triggerevent ("u_wtitolo_path")

	tv_root.GetItem(handle, ktvi_1)
	ktvi_1.Expanded = false

end event

event selectionchanged;//
//kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree

//---
//--- valorizza la tree 
//---
//treeviewitem ktvi_1


	this.enabled = false

	if not ki_flag_tree_appena_espanso then
		post cliccato_tree()
	end if	
	
	this.enabled = true



end event

event selectionchanging;//
Long					ll_OldParent, ll_NewParent
TreeViewItem		ltvi_Old, ltvi_New


If GetItem(oldhandle, ltvi_Old) = -1 Or GetItem(newhandle, ltvi_New) = -1 Then Return 0

If ltvi_Old.Level = ltvi_New.Level Then
	// Changing selection to another item on the same level.
	// First determine if the DW will need to be re-retrieved.  If the
	// new item has the same parent as the old, it does not.
	If FindItem(ParentTreeItem!, oldhandle) = FindItem(ParentTreeItem!, newhandle) Then
		Return 0
	end if
end if
end event

event itemexpanded;//
treeviewitem ktvi_treeviewitem 
st_treeview_data kst_treeview_data


kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_tree
//this.getitem(handle, ktvi_treeviewitem)
//kst_treeview_data = ktvi_treeviewitem.data
//u_wtitolo_path(kst_treeview_data)

end event

type lv_1 from listview within w_g_tab_tv
event u_dropfiles pbm_dropfiles
event u_rbuttondown pbm_rbuttondown
boolean visible = false
integer x = 946
integer width = 1463
integer height = 640
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean border = false
boolean autoarrange = true
boolean fixedlocations = true
boolean hideselection = false
boolean oneclickactivate = true
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewreport!
string largepicturename[] = {"","","","","","",""}
long largepicturemaskcolor = 553648127
string smallpicturename[] = {"","","","","","",""}
long smallpicturemaskcolor = 16777215
long statepicturemaskcolor = 536870912
end type

event u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop,handle)

return k_file_nr



end event

event u_rbuttondown;//
//---- menu contestuale
//
int k_xpos, k_ypos

kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list

//	kuf1_menu_popup = create kuf_menu_popup
	k_xpos = xpos + this.x  
	k_ypos = ypos + this.y 
	kiuf_menu_popup.post u_popup(k_xpos, k_ypos)

//	destroy kuf1_menu_popup

end event

event clicked;//
	kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list


	if index > 1 then
		u_anteprima()
	end if


end event

event columnclick;//---
//--- ordinamento x colonna
//---
string k_label
integer k_width
listviewitem klvi_1
alignment k_align


	this.enabled = false

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

//	this.SetRedraw(false)

	if this.totalitems( ) > 1 then
	
	   this.GetColumn(column, k_label, k_align, k_width)

//--- se non numerico
//		if k_align <> right! then
	
		if this.tag = string(column) + "D" then

			this.Sort ( Descending!, column )
			
		else

			this.Sort ( Ascending!, column )
			
		end if
			
//		else
//			this.Sort ( UserDefinedSort!, column )

//		end if
		
//--- imposto il senso del sort così la prossima è l contrario
		if this.tag = string(column) + "D" then
			this.tag = string(column) + "A"
		else
			this.tag = string(column) + "D"
		end if
		

	end if

//	this.SetRedraw(true)

	this.enabled = true

//=== Puntatore Cursore a default
	SetPointer(kkg.pointer_default)


end event

event doubleclicked;////---
////--- Estendo il ramo della list
////---
//
//	if index > 0 then
////		ki_time_lbuttondown_riga = 0
//		ki_listview_index = 0 //azzero l'indice x anteprima
//
		cliccato_list(index)
//	end if
//
//

end event

event getfocus;//
//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event key;//
long k_index
int k_file_nr=0


if key = keyenter! then
	kiuf_treeview.ki_fuoco_tree_list = kiuf_treeview.ki_fuoco_su_list
	k_index = selectedindex( ) 
	if k_index > 0 then
//		event doubleclicked( k_index)
		event clicked(k_index)
	end if
else
	if key = KeyV! and keyflags = 2 then
//--- Copia+Incolla dei file
		k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_incolla, handle(this))
	end if
end if

end event

event sort;//
//--- sort scatenato quando pigi su testa delle colonne (align=right)

//ListViewItem lvi, lvi2
//
//if index1 = 1 then
//	RETURN -1
//else
//
//	if index2 = 1 then
//		RETURN 1
//	else
//			
//		This.GetItem(index1, lvi)
//		
//		This.GetItem(index2, lvi2)
//		
//		IF lvi.PictureIndex < lvi2.PictureIndex THEN
//				RETURN 1
//		ELSE
//			IF lvi.PictureIndex > lvi2.PictureIndex THEN
//				RETURN -1
//				
//			ELSE
//				This.GetItem(index1, column, lvi)
//		
//				This.GetItem(index2, column, lvi2)
//		
//				if this.tag = string(column) + "D" then
//					IF lvi.label > lvi2.label THEN
//						RETURN 1
//					ELSE
//						IF lvi.label < lvi2.label THEN
//							RETURN -1
//						ELSE
//							RETURN 0
//						END IF
//					END IF
//				else
//					IF lvi.label < lvi2.label THEN
//						RETURN 1
//					ELSE
//						IF lvi.label > lvi2.label THEN
//							RETURN -1
//						ELSE
//							RETURN 0
//						END IF
//					END IF
//				end if
//			end if
//		
//		END IF
//	end if
//end if
//
//
end event

type dw_anteprima from uo_d_std_1 within w_g_tab_tv
integer x = 937
integer y = 772
integer width = 983
integer height = 320
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
string title = "anteprima"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_cerca = false
end type

event getfocus;call super::getfocus;//
attiva_tasti()

end event

event ue_dwnkey;call super::ue_dwnkey;//
	u_key(key, keyflags)


end event

event retrievestart;call super::retrievestart;//
	this.Object.DataWindow.Print.Preview.Zoom = ki_zoom

end event

event clicked;call super::clicked;//
attiva_tasti( )

end event

type dw_stampa from datawindow within w_g_tab_tv
boolean visible = false
integer x = 1970
integer y = 768
integer width = 434
integer height = 312
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_x_stampa_listview"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type st_cancella from statictext within w_g_tab_tv
boolean visible = false
integer x = 9
integer y = 1120
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "cancella"
boolean focusrectangle = false
end type

type st_conferma from statictext within w_g_tab_tv
boolean visible = false
integer y = 1192
integer width = 256
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "conferma"
boolean focusrectangle = false
end type

type st_inserisci from statictext within w_g_tab_tv
boolean visible = false
integer x = 9
integer y = 1052
integer width = 242
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "inserisci"
boolean focusrectangle = false
end type

type st_modifica from statictext within w_g_tab_tv
boolean visible = false
integer x = 293
integer y = 1064
integer width = 256
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "modifica"
boolean focusrectangle = false
end type

type st_visualizza from statictext within w_g_tab_tv
boolean visible = false
integer x = 297
integer y = 1136
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "visualizza"
boolean focusrectangle = false
end type

type st_orizzontal from statictext within w_g_tab_tv
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
boolean visible = false
integer x = 1024
integer y = 672
integer width = 1353
integer height = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 12639424
long backcolor = 12639424
long bordercolor = 8388608
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
if ki_focus_on_st_oizzontal then
	If KeyDown(keyLeftButton!) Then
		if Parent.PointerY() > parent.height / 10 then
			if Parent.PointerY() > parent.height * 0.98 then
				dw_anteprima.visible = false
				this.visible = false
				tv_root.height =  parent.height 
				lv_1.height =  parent.height
				st_vertical.height =  parent.height
			else
				
				This.y = Parent.PointerY()
				tv_root.height = y 
				lv_1.height = y
				st_vertical.height = y
				dw_anteprima.y = y + this.height
				dw_anteprima.height = parent.height - y - this.height
		
			end if
		end if
	End If
end if	

end event

event getfocus;//
ki_focus_on_st_oizzontal = true

end event

event losefocus;//
ki_focus_on_st_oizzontal = false

end event

type st_vertical from statictext within w_g_tab_tv
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
boolean visible = false
integer x = 873
integer y = 68
integer width = 18
integer height = 756
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeWE!"
long textcolor = 12639424
long backcolor = 12639424
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
if ki_focus_on_st_vertical then
	If KeyDown(keyLeftButton!) Then
		if Parent.PointerX() < parent.width * 0.95 then
			if Parent.PointerX() < parent.width * 0.01 then
				tv_root.visible = false
				this.visible = false
				lv_1.x = tv_root.x
				lv_1.width =  parent.width 
			else
				
				This.x = Parent.PointerX()
				tv_root.width = x 
				lv_1.x = x + this.width
				lv_1.width = parent.width - x - this.width
				
			end if
		end if
	End If
end if	

end event

event getfocus;//
ki_focus_on_st_vertical = true

end event

event losefocus;//
ki_focus_on_st_vertical = false

end event

type dw_data1 from uo_d_std_1 within w_g_tab_tv
event ue_clicked_0 ( integer row,  string k_dwo_name )
event ue_clicked ( )
integer x = 1518
integer y = 880
integer width = 923
integer height = 420
integer taborder = 20
boolean bringtotop = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_clicked_0(integer row, string k_dwo_name);//
//--- Richiamato dal CLICKED
//


IF row > 0 THEN

	try
	
		if k_dwo_name = "b_ok" then
			
			this.visible = false
			this.x = 10000
			this.y = 10000
			
			this.accepttext( )
			
			ki_data_ini = this.getitemdate( 1, "data_dal")
			ki_data_fin = this.getitemdate( 1, "data_al")
			event ue_clicked( )
		
		else
			if k_dwo_name = "b_annulla" then
		
				this.visible = false
			
			end if
		end if
		
	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	
	finally
	
		
	end try

end if

end event

event ue_clicked();//
if ki_data_ini > date(0) then
	kiuf_treeview.ki_data_certif_da_st_da = ki_data_ini 
else
end if
if ki_data_fin > date(0) then
	kiuf_treeview.ki_data_certif_da_st_a = ki_data_fin
else
end if

kiuf_treeview.ki_forza_refresh = kiuf_treeview.ki_forza_refresh_si
aggiorna_liste()

end event

event u_pigiato_enter;//
//--- Premuto ENTER: simulo come il clicked su ITEM_PICTURE
//

	THIS.Trigger Event ue_clicked_0(1, "b_ok") 


return 1 


end event

event buttonclicked;call super::buttonclicked;//

THIS.Trigger Event ue_clicked_0(row, dwo.name) 


end event

