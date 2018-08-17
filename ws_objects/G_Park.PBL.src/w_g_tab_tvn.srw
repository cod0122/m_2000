$PBExportHeader$w_g_tab_tvn.srw
forward
global type w_g_tab_tvn from w_g_tab
end type
type st_visualizza from statictext within w_g_tab_tvn
end type
type st_modifica from statictext within w_g_tab_tvn
end type
type st_conferma from statictext within w_g_tab_tvn
end type
type st_cancella from statictext within w_g_tab_tvn
end type
type st_1 from statictext within w_g_tab_tvn
end type
type st_inserisci from statictext within w_g_tab_tvn
end type
type tv_root from treeview within w_g_tab_tvn
end type
type cb_cerca_1 from commandbutton within w_g_tab_tvn
end type
type sle_cerca from singlelineedit within w_g_tab_tvn
end type
type lv_1 from listview within w_g_tab_tvn
end type
type st_vertical from statictext within w_g_tab_tvn
end type
type st_orizzontal from statictext within w_g_tab_tvn
end type
type dw_anteprima from uo_d_std_1 within w_g_tab_tvn
end type
type dw_stampa from datawindow within w_g_tab_tvn
end type
end forward

global type w_g_tab_tvn from w_g_tab
integer width = 2533
integer height = 1540
string title = "Navigatore"
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = false
event u_wtitolo_path ( )
event rbuttonup pbm_rbuttondown
st_visualizza st_visualizza
st_modifica st_modifica
st_conferma st_conferma
st_cancella st_cancella
st_1 st_1
st_inserisci st_inserisci
tv_root tv_root
cb_cerca_1 cb_cerca_1
sle_cerca sle_cerca
lv_1 lv_1
st_vertical st_vertical
st_orizzontal st_orizzontal
dw_anteprima dw_anteprima
dw_stampa dw_stampa
end type
global w_g_tab_tvn w_g_tab_tvn

type variables
//
private kuf_treeview kufi_treeview
private st_treeview_oggetto kist_treeview_oggetto 
private string ki_titolo_window_orig 
private string ki_path_risorse

private boolean ki_flag_tree_appena_espanso = true
private boolean ki_flag_list_appena_espanso = false
//private char ki_flag_nascondi_struttura_anteprima = "0"

//char ki_flag_aggiorna_liste="N"


end variables

forward prototypes
private function integer forma_tree (long k_handle_item_padre)
protected subroutine attiva_tasti ()
protected subroutine inizializza_lista ()
private subroutine cliccato_list (long k_index)
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private subroutine aggiorna_liste ()
private subroutine cerca_in_lista ()
private subroutine open_dettaglio (string k_operazione)
protected function string inizializza ()
protected subroutine stampa ()
protected subroutine crea_dw_stampa_da_listview ()
private subroutine treeview_collassa_tutti_i_rami ()
private subroutine leggi_ramo_treeviewitem ()
private subroutine cliccato_tree ()
protected function st_esito aggiorna_window ()
protected function integer u_dammi_item_padre_da_list ()
end prototypes

event u_wtitolo_path();//
string k_path = " "
int k_rc
long k_handle
listviewitem klvi_listviewitem
treeviewitem ktvi_treeviewitem
st_treeview_data kst_treeview_data

//k_handle = tv_root.finditem (currenttreeitem!,0 )

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
kufi_treeview.kitv_tv1 = tv_root
kufi_treeview.kilv_lv1 = lv_1
kst_treeview_data = kufi_treeview.u_ricava_tipo_oggetto ()

	
//	k_handle_item = tv_root.finditem(CurrentTreeItem!, 0)
if kst_treeview_data.handle > 0 then
	k_handle = kst_treeview_data.handle
	
	k_rc = tv_root.getitem(k_handle, ktvi_treeviewitem) 
	k_path = trim(ktvi_treeviewitem.label) 
	
	do 
		k_handle = tv_root.finditem (Parenttreeitem!,k_handle )
		if k_handle > 0 then
			k_rc = tv_root.getitem(k_handle, ktvi_treeviewitem) 
			k_path = trim(ktvi_treeviewitem.label) + "\" + k_path
		end if
	loop until k_handle <=0
	
	this.title = ki_titolo_window_orig + ": \" + k_path

end if


end event

event rbuttonup;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
GraphicObject k_control
m_popup m_menu


//=== Salvo il Tag attuale per reimpostarlo a fine routine
	k_tag_old = this.tag
	this.tag = " "

//=== Creo menu Popup 
	m_menu = create m_popup

	m_menu.m_agglista.visible = true
	m_menu.m_t_agglista.visible = true
	m_menu.m_stampa.visible = st_stampa.enabled
	m_menu.m_t_stampa.visible = st_stampa.enabled
	m_menu.m_conferma.visible = st_conferma.enabled
	m_menu.m_ritorna.visible = true
	m_menu.m_inserisci.visible = st_inserisci.enabled
	m_menu.m_modifica.visible = st_modifica.enabled
	m_menu.m_t_modifica.visible = st_modifica.enabled
	m_menu.m_cancella.visible = st_cancella.enabled
	m_menu.m_t_cancella.visible = st_cancella.enabled
	m_menu.m_visualizza.visible = st_visualizza.enabled


	m_menu.m_lib_1.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text 
	m_menu.m_lib_1.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.visible
	m_menu.m_lib_1.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.enabled
	m_menu.m_t_lib_1.visible = m_menu.m_lib_1.visible
	m_menu.m_lib_2.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.text 
	m_menu.m_lib_2.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	m_menu.m_lib_2.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	m_menu.m_t_lib_2.visible = m_menu.m_lib_2.visible

	m_menu.m_lib_3.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.text 
	m_menu.m_lib_3.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.visible
	m_menu.m_lib_3.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.enabled
	m_menu.m_t_lib_3.visible = m_menu.m_lib_3.visible
	m_menu.m_lib_4.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.text 
	m_menu.m_lib_4.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.visible
	m_menu.m_lib_4.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.enabled
	m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato
	k_control = GetFocus()
	k_stringa = classname(k_control)
	choose case classname(k_control)
		case classname(tv_root)
			k_stringa = " "
		case classname(lv_1) 
			k_stringa = "ok" 
	end choose

	if trim(k_stringa) <> "" then

	//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false
	
		destroy m_menu
	
		k_tag = this.tag 
	
		this.triggerevent("ue_menu") 

		this.tag = k_tag_old 
	
		
	end if

//
end event

private function integer forma_tree (long k_handle_item_padre);//---
//--- valorizza la tree con i dati ricercati a seconda del tipo oggetto
//---
int k_return
kuf_treeview kuf1_treeview

//	tv_root.triggerevent ("u_riempi_treeview")
	tv_root.triggerevent (itemexpanding!)

return k_return

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


if lv_1.totalitems( ) > 0 then
	st_inserisci.enabled = true
	st_conferma.enabled = true
	st_modifica.enabled = true
	st_cancella.enabled = true
	st_visualizza.enabled = true
else
	st_inserisci.enabled = false
	st_conferma.enabled = false
	st_modifica.enabled = false
	st_cancella.enabled = false
	st_visualizza.enabled = false
end if
            
attiva_menu()

end subroutine

protected subroutine inizializza_lista ();//
st_esito kst_esito


//--- operazioni necessarie di inizio programma (come check sicurezza)
	super::inizializza_lista()

	kst_esito = kufi_treeview.u_select_tab_treeview_all()
	if kst_esito.esito <> "0" then

		messagebox("Accesso al Navigatore", &
		           "Anomalia durante la composizione~n~r" &
					  + kst_esito.sqlerrtext + " Errore:" &
					  + string(kst_esito.sqlcode), & 
					  stopsign!, OK! )
					  
//--- se errore forza FINE!
		smista_funz(kkg_flag_richiesta_esci)

	else
		inizializza()
	end if
end subroutine

private subroutine cliccato_list (long k_index);////
//int k_return
//string k_campo 
//integer k_larg_campo, k_ctr, k_rc
//alignment k_align
//listview kilv_lv1
//listviewitem klvi_l1


	if k_index > 0 then
		
		tv_root.setredraw(false)
		lv_1.setredraw(false)

//--- imposto il percorso sulla barra del titolo
		kiw_this_window.triggerevent ("u_wtitolo_path")

//--- Salvo dimensioni delle colonne
//		kilv_lv1 = lv_1
//		k_ctr = 1
//		kufi_treeview.kitv_tv1 = tv_root
//		kufi_treeview.kilv_lv1 = lv_1
		kufi_treeview.u_listview_salva_dim_colonne()
		
		leggi_ramo_treeviewitem()

		tv_root.setredraw(true)
		lv_1.setredraw(true)
	
	end if


	attiva_tasti()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : tag della window
//===
long k_handle_item = 0, k_handle_item_padre = 0
string k_operazione
kuf_treeview kuf1_treeview
//treeviewitem ktvi_1
listviewitem klvi_1

k_operazione = trim(k_par_in)

choose case  k_operazione 

	case kkg_flag_richiesta_refresh				//Aggiorna Liste
		aggiorna_liste()
		
	case kkg_flag_richiesta_inserimento			//richiesta inserimento
		open_dettaglio(k_operazione)
		
	case kkg_flag_richiesta_cancellazione		//richiesta cancellazione
		open_dettaglio(k_operazione)

	case kkg_flag_richiesta_visualizzazione	//richiesta visualizzazione
		open_dettaglio(k_operazione)
		
	case kkg_flag_richiesta_modifica				//richiesta modifica
		open_dettaglio(k_operazione)

	case kkg_flag_richiesta_stampa				//richiesta stampa
		open_dettaglio(k_operazione)

	case kkg_flag_richiesta_trova					//Cerca.....
		cerca_in_lista()	

	case kkg_flag_richiesta_trova_ancora     //Cerca ancora.....
		cb_cerca_1.triggerevent(clicked!)	


	case kkg_flag_richiesta_libero1		//collassa rami tree
		treeview_collassa_tutti_i_rami()

	case kkg_flag_richiesta_libero2		//Nascondi/visulaizza TREE/anteprima
		choose case true
			case tv_root.visible and dw_anteprima.visible
				dw_anteprima.visible = false
			case tv_root.visible and not dw_anteprima.visible
				tv_root.visible = false
			case not tv_root.visible and not dw_anteprima.visible
				dw_anteprima.visible = true
			case not tv_root.visible and dw_anteprima.visible
				tv_root.visible = true
		end choose

//	   if tv_root.visible = true then
//			tv_root.visible = false
//			kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text = "Visualizza Struttura"
//			kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.microhelp = "Visualizza a sinistra della Finestra la struttura ad albero"
//		else
//			tv_root.visible = true
//			kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text = "Nascondi Struttura"
//			kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.microhelp = "Nasconde la porzione sinistra della Finestra "
//		end if
		st_vertical.visible = tv_root.visible
		st_orizzontal.visible = dw_anteprima.visible
		this.triggerevent ( resize! ) 

//	case "l2"		//ritorna liv. superiore 
//		lv_1.setfocus()
//		lv_1.getitem(1, klvi_1)
//		lv_1.setitem(1, klvi_1)
//		cliccato_list(1)

	case kkg_flag_richiesta_libero3		//visualizzazione list 
		lv_1.view = listviewlargeicon!

	case kkg_flag_richiesta_libero4		//visualizzazione list 
		lv_1.view = listviewsmallicon!

	case kkg_flag_richiesta_libero5		//visualizzazione list 
		lv_1.view = listviewlist!

	case kkg_flag_richiesta_libero6		//visualizzazione list 
		lv_1.view = listviewreport!

	case kkg_flag_richiesta_libero7		//Stampa datawindow con il fuoco
		stampa()

	case else
		super::smista_funz(k_operazione)
//		messagebox("Operazione non Eseguita", &
//					"Funzione richiesta non Abilitata")


end choose


//attiva_tasti()



//return k_return




end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//
//--- Attiva/Dis. Voci di menu
//
	kG_menu.m_finestra.m_gestione.enable()
	kG_menu.m_finestra.m_gestione.show()
	kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = st_conferma.enabled
	kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = st_inserisci.enabled
	kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = st_modifica.enabled
	kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = st_cancella.enabled
	kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = st_visualizza.enabled
	kG_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled


	kG_menu.m_finestra.m_fin_cerca.enabled = true
	kG_menu.m_finestra.m_fin_cercaancora.enabled = true
//	kG_menu.m_finestra.m_fin_filtra.enabled = true
	kG_menu.m_finestra.m_aggiornalista.enabled = true
	kG_menu.m_finestra.m_riordinalista.enabled = true
	

//
//--- Attiva/Dis. Voci di menu personalizzate
//

//--- Menu LIBERI in aggiunta alle normali funzionalità

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text = "Chiude tutti i 'rami'"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.microhelp = "Nasconde tutti i rami escluso quelli iniziali"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.visible = true
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.enabled = true
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.toolbaritemName = "close!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.toolbaritembarindex=2

//	if tv_root.visible = true then
		kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.text = "Nascondi/Visualizza Strutture"
		kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.microhelp = "Nasconde o Visualizza il navigatore a sinistra o la finestra di anteprima"
//	else
//		kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.text = "Visualizza Struttura"
//		kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.microhelp = "Visualizza a sinistra della Finestra la struttura ad albero"
//	end if
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible = true
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled = true
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.toolbaritemName = "Layer!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.toolbaritembarindex=2

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.text = "Visualizza icone grandi"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.microhelp = "Tipo di viualizzazione icone grandi"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.toolbaritemName = "Custom097!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.text = "Visualizza icone piccole"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.microhelp = "Tipo di viualizzazione icone piccole"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.toolbaritemName = "Custom098!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero4.toolbaritembarindex=2

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.text = "Visualizza elenco"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.microhelp = "Tipo di viualizzazione elenco"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.toolbaritemName = "Custom099!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero5.toolbaritembarindex=2

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.text = "Visualizza dettagli"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.microhelp = "Tipo di viualizzazione elenco con dettaglio"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.toolbaritemName = "Custom100!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero6.toolbaritembarindex=2

	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.text = "Stampa elenco"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.microhelp = "In stampa l'elenco"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.toolbaritemVisible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.toolbaritemText = kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.text
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.toolbaritemName = "Custom074!"
	kG_menu.m_finestra.m_gestione.m_fin_gest_libero7.toolbaritembarindex=2

	kG_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
		
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

			kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree
			kufi_treeview.ki_forza_refresh=kufi_treeview.ki_forza_refresh_si
			kufi_treeview.ki_flag_gia_dentro = kufi_treeview.ki_flag_gia_dentro_NO 
			leggi_ramo_treeviewitem()
			kufi_treeview.ki_forza_refresh=kufi_treeview.ki_forza_refresh_NO

		end if
		
	end if
 
end subroutine

private subroutine cerca_in_lista ();//
string k_nome_col 
integer k_larg_campo, k_rc
alignment k_align 


//=== Posiziona control edit

	if lv_1.TotalItems ( ) > 1 then

//		cb_cerca_1.tag = trim(string(k_campo))
		
		sle_cerca.RightToLeft = FALSE
		
//--- Ricavo la descrizione della colonna
		k_nome_col = " "
		k_rc = lv_1.getColumn(1, k_nome_col , k_align, k_larg_campo)
		if k_rc >= 0 then
			if upper(trim(sle_cerca.text)) = "NONE" or LenA(trim(sle_cerca.text)) = 0 then
				if LenA(trim(k_nome_col)) > 0 then
					sle_cerca.text = LeftA(k_nome_col,20)
				else
					sle_cerca.text = "scrivi qui quello che vuoi cercare" 
				end if
			end if
		end if

		sle_cerca.x = lv_1.x + (lv_1.width - sle_cerca.width) / 2
		sle_cerca.y = lv_1.y + (lv_1.height - sle_cerca.height) / 4
	
		sle_cerca.visible = true
		sle_cerca.setfocus()
	
		cb_cerca_1.visible = true
		cb_cerca_1.x = sle_cerca.x + sle_cerca.width + 5
		cb_cerca_1.y = sle_cerca.y 	
		cb_cerca_1.default = true
	
		cb_cerca_1.bringtotop = true
		sle_cerca.bringtotop = true
	
////=== Disattivo flag di 'prima volta'
//		if ki_st_open_w.flag_primo_giro = 'S' then
//			ki_st_open_w.flag_primo_giro = ''
//		end if
	end if

end subroutine

private subroutine open_dettaglio (string k_operazione);//
long k_handle_item
//kuf_treeview kuf1_treeview
treeviewitem ktvi_1
st_esito kst_esito



kst_esito.esito = kkg_esito_ok

choose case  k_operazione 

	case kkg_flag_richiesta_inserimento		//richiesta inserimento
		if st_inserisci.enabled then
//			ki_flag_aggiorna_liste="S"	
//			kuf1_treeview = create kuf_treeview
			kufi_treeview.kitv_tv1 = tv_root
			kufi_treeview.kilv_lv1 = lv_1
			kst_esito = kufi_treeview.u_open ( k_operazione)
//			kuf1_treeview.u_aggiorna_treeview(tv_root,  lv_1)
//			destroy kuf1_treeview
//			smista_funz(kkg_flag_richiesta_refresh)
		end if
		
	case kkg_flag_richiesta_cancellazione		//richiesta cancellazione
		if st_cancella.enabled then
//			ki_flag_aggiorna_liste="S"		
//			kuf1_treeview = create kuf_treeview
			kufi_treeview.kitv_tv1 = tv_root
			kufi_treeview.kilv_lv1 = lv_1
			kst_esito = kufi_treeview.u_open ( k_operazione)
//			destroy kuf1_treeview
//			smista_funz(kkg_flag_richiesta_refresh)
		end if

	case kkg_flag_richiesta_visualizzazione		//richiesta visualizzazione
		if st_visualizza.enabled then
//			kuf1_treeview = create kuf_treeview
			kufi_treeview.kitv_tv1 = tv_root
			kufi_treeview.kilv_lv1 = lv_1
			kst_esito = kufi_treeview.u_open ( k_operazione)
//			destroy kuf1_treeview
//			smista_funz(kkg_flag_richiesta_refresh)
		end if
		
	case kkg_flag_richiesta_modifica		//richiesta modifica
		if st_modifica.enabled then
//			ki_flag_aggiorna_liste="S"		
//			kuf1_treeview = create kuf_treeview
			kufi_treeview.kitv_tv1 = tv_root
			kufi_treeview.kilv_lv1 = lv_1
			kst_esito = kufi_treeview.u_open ( k_operazione)
//			destroy kuf1_treeview
//			smista_funz(kkg_flag_richiesta_refresh)
		end if

	case kkg_flag_richiesta_stampa		//richiesta stampa
		if st_stampa.enabled then
			k_handle_item = tv_root.finditem(CurrentTreeItem!, 0)
			if k_handle_item > 0 then

//				ki_flag_aggiorna_liste="S"		
//				kuf1_treeview = create kuf_treeview
				kufi_treeview.kitv_tv1 = tv_root
				kufi_treeview.kilv_lv1 = lv_1
				kst_esito = kufi_treeview.u_open ( k_operazione)
//				destroy kuf1_treeview
				
//				smista_funz(kkg_flag_richiesta_refresh)
			end if
		end if

end choose


if kst_esito.esito <> kkg_esito_ok then

	if k_operazione = kkg_flag_richiesta_stampa then
		if messagebox("Operazione non Eseguita", &
				"Funzione si 'Stampa' della voce selezionata non e' consentita.~n~r"  &
				  + "Per stampare l'Elenco del Navigatore premere l'apposito pulsante.~n~r" &
				  + "Procerede con la stampa dell'Elenco?", Question!, yesno!, 1) = 1 then
			stampa()
		end if
	else
		messagebox("Operazione non Eseguita", &
				  kst_esito.sqlerrtext)
	end if

end if

end subroutine

protected function string inizializza ();//
//=== Routine STANDARD CHIAMATA SUBITO DOPO LA OPEN
//=== Ritorna 0=ok 1=errore
//
string k_return="0"
long k_handle_item


	ki_flag_tree_appena_espanso = false

//--- questo click x far vedere la root	
   if ki_st_open_w.flag_primo_giro = "S" then 
//--- seleziono item root solo l' prima volta 	
		k_handle_item = tv_root.finditem(RootTreeItem!, 0)
		tv_root.selectitem( k_handle_item )
		cliccato_tree()
//--- questo click x far vedere i figli della root	
		cliccato_tree()
	end if


//--- Flag Primo Giro a off
  ki_st_open_w.flag_primo_giro = "N" 
  

return k_return 
end function

protected subroutine stampa ();//
st_stampe kst_stampe


choose case kuf1_data_base.u_getfocus_nome()

	case "lv_1", "tv_1"
		crea_dw_stampa_da_listview()

		kst_stampe.dw_print = dw_stampa
		if LenA(trim(this.title)) > 60 then
			kst_stampe.titolo = RightA(trim(this.title), 60) 
		else
			kst_stampe.titolo = this.title 
		end if
		
	case "dw_anteprima"
		dw_stampa.dataobject = dw_anteprima.dataobject
		dw_anteprima.rowscopy( 1, dw_anteprima.rowcount(), primary!, dw_stampa, 1, primary!)
		kst_stampe.dw_print = dw_stampa
		lv_1.getitem( lv_1.selectedindex( ) ,1, kst_stampe.titolo) 
		kst_stampe.titolo = RightA(trim(trim(this.title)+kst_stampe.titolo), 60)
	
end choose

	if dw_stampa.rowcount() > 0 then

		kst_stampe.dw_syntax = dw_stampa.describe("DataWindow.Syntax")
		
		kuf1_data_base.stampa_dw(kst_stampe)

	end if
	

	
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
			k_table = k_table + " column=(type=char("+string(LenA(trim(k_titolo_col)))+ ") updatewhereclause=yes name=colonna_"+string(k_colonna)+ " dbname=~"colonna_"+string(k_colonna)+ "~" )" 
			k_colonna++
			k_list_eof = lv_1.getColumn(k_colonna, k_titolo_col , k_align , k_larg_campo)
		loop

//--- copia dal tamplate		
		k_syntax = dw_stampa.describe("DataWindow.Syntax")

//--- genera una nuova dw con la nuova sez. TABLE
		k_rcn = PosA(k_syntax,"table(",1)		
		if k_rcn > 0 then
			k_resto = MidA(k_syntax, k_rcn + 6, LenA(trim(k_syntax)) - k_rcn)
			k_syntax = LeftA(k_syntax, k_rcn -1) + "table(" + trim(k_table) + k_resto
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
		" color='" +string(kk_colore_nero)+"' height='76' " +  & 
		" width='"+string(k_larg_campo)+"' name=colonna_"+string(k_colonna)+ " visible='"+k_visible+"' tag=' '" + &
		" background.mode='1' background.color='"+string(kk_colore_bianco)+"' font.face='Arial' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' font.italic='1' font.strikethrough='0' font.underline='0' "+&
		"   ) " )
			k_rc = dw_stampa.Modify( &
		"create text(band=header alignment='"+k_alignement+"' text='"+trim(k_titolo_col)+"' name=colonna_"+string(k_colonna)+ "_t visible='"+k_visible+"' border='0' color='" +string(KK_COLORE_BLU_SCURO)+"' " + & 
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

private subroutine treeview_collassa_tutti_i_rami ();//
long k_collassa_item
treeviewitem ktvi_1

	
	k_collassa_item = tv_root.FindItem(roottreeitem!, 0)
	
	tv_root.CollapseItem(k_collassa_item)

//	tv_root.SelectItem(k_collassa_item)

//--- cancello dalla listview tutto
	lv_1.DeleteItems()

//--- per x far vedere la root	
   ki_st_open_w.flag_primo_giro = "S" 
	inizializza()

end subroutine

private subroutine leggi_ramo_treeviewitem ();////
//long k_handle_item, k_handle_item_padre, k_handle_root=0
//st_treeview_data kst_treeview_data	
//TreeViewItem ktvi_1
pointer oldpointer  // Declares a pointer variable


ki_flag_tree_appena_espanso = true

	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	tv_root.setredraw(false)
	lv_1.setredraw(false)

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
//	kufi_treeview.kitv_tv1 = tv_root
//	kufi_treeview.kilv_lv1 = lv_1
//	kst_treeview_data = kufi_treeview.u_ricava_tipo_oggetto ()
//	k_handle_item = kst_treeview_data.handle
//	if k_handle_item > 0 then

	kufi_treeview.u_smista_treeview_listview( )

//	k_handle_item_padre = tv_root.finditem(ParentTreeItem!, k_handle_item)

//	tv_root.GetItem(k_handle_item, ktvi_1)
//	if not ktvi_1.Expanded then
//		tv_root.ExpandItem(k_handle_item)
//	end if

//--- per espandere l'item

	tv_root.setredraw(true)
	lv_1.setredraw(true)
	
	attiva_tasti()
	
//=== Ripristina il Puntatore originale
	oldpointer = SetPointer(oldpointer)


end subroutine

private subroutine cliccato_tree ();//
long k_handle_item
treeviewitem ktvi_treeviewitem
st_treeview_data kst_treeview_data
kuf_treeview kuf1_treeview


//--- solo x il primo giro forza la lettura e l'espansione del ramo
   if ki_st_open_w.flag_primo_giro = "S" then 
		leggi_ramo_treeviewitem()
		k_handle_item=tv_root.finditem(RootTreeItem!, 0)
		tv_root.ExpandItem(k_handle_item)
//		ki_flag_tree_appena_espanso = true
	else
//--- non faccio la rilettura se clicco su root		
		kst_treeview_data = kufi_treeview.u_ricava_tipo_oggetto ()
		k_handle_item = kst_treeview_data.handle
		if k_handle_item > 0 then
			leggi_ramo_treeviewitem()
		end if
	end if

	
	kiw_this_window.triggerevent ("u_wtitolo_path")


end subroutine

protected function st_esito aggiorna_window ();//
st_esito kst_esito
	kst_esito.esito = "0"
	aggiorna_liste()
//	aggiorna_liste()
return kst_esito

end function

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
			
//			kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_list
		end if

	end if
	

return k_item

end function

event open;call super::open;//Use the following code to quickly count items in the TreeView control:
//     li_count = Send(handle(treeview_control), 4357, 0, 0)
//
//To find out how many items can be fully visible in the TreeView control visible area use the following script:
//     li_count = Send(handle(treeview_control), 4368, 0, 0)
//
//
//
string k_visible, k_view
string k_pos, k_rcx
pointer kpointer_orig
st_profilestring_ini kst_profilestring_ini

ki_titolo_window_orig = this.title

kpointer_orig = setpointer(hourglass!)

if ki_utente_abilitato then

//--- fissa le dimensione delle barette verticale e orizzontale
	st_vertical.backcolor = this.backcolor
	st_vertical.width = 11
	st_vertical.y = 30
	st_orizzontal.backcolor = this.backcolor
	st_orizzontal.height = 11
	st_orizzontal.x = 30
	
//--- Imposto i campi x prelevare dal INI i valori
	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "treeview"
	kst_profilestring_ini.titolo = "treeview"
//--- Eventualmente nasconde la tree
	kst_profilestring_ini.nome = "treeview_nascondi_tree"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	k_visible = "1"
	if kst_profilestring_ini.esito <> "1" then
		k_visible = trim(kst_profilestring_ini.valore)
	end if
	if k_visible = "0" then
		tv_root.visible = false
		st_vertical.visible = tv_root.visible
	end if
//--- Eventualmente nasconde la Anteprima
	kst_profilestring_ini.nome = "treeview_nascondi_anteprima"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	k_visible = "1"
	if kst_profilestring_ini.esito <> "1" then
		k_visible = trim(kst_profilestring_ini.valore)
	end if
	if k_visible = "0" then
		dw_anteprima.visible = false
		st_orizzontal.visible = dw_anteprima.visible
	end if
//--- Posizione delle ST_ x confine tra tree e list e anteprima
	kst_profilestring_ini.nome = "treeview_pos_vertical"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	k_pos = "0"
	if kst_profilestring_ini.esito <> "1" then
		k_pos = trim(kst_profilestring_ini.valore)
	end if
	if not isnull(k_pos) and isnumber(k_pos) then
		if long(k_pos) = 0 then
			st_vertical.x = this.width / 3.5 - 60		
		else
			st_vertical.x = long(k_pos)
		end if
	else
		st_vertical.x = this.width / 3.5 - 60		
	end if
	kst_profilestring_ini.nome = "treeview_pos_orizzontal"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	k_pos = "0"
	if kst_profilestring_ini.esito <> "1" then
		k_pos = trim(kst_profilestring_ini.valore)
	end if
	if not isnull(k_pos) and isnumber(k_pos) then
		if long(k_pos) = 0 then
			st_orizzontal.y = this.height * 0.80
		else
			st_orizzontal.y = long(k_pos)
		end if
	else
		st_orizzontal.y = this.height * 0.80
	end if
//--- Tipo visualizzazione della list
	kst_profilestring_ini.nome = "listview_view"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
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

//--- listView x selezionare + righe
	lv_1.ExtendedSelect = TRUE
	
//--- Crea istanza oggetto con le funzioni per gestire il tutto
	kufi_treeview = create kuf_treeview

//--- imposta le icone nella tree e list
	kufi_treeview.u_imposta_treeview_icone(tv_root,  lv_1)

//--- piglia il path di default delle icone
	ki_path_risorse = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
	

//--- variabili di istanza
	kufi_treeview.kitv_tv1 = tv_root
	kufi_treeview.kilv_lv1 = lv_1
	kufi_treeview.kidw_1 = dw_anteprima

	
//	tv_root.tag = " "
//	lv_1.tag = " "
//	
//	////=== mette le colonne nella listview
//	//lv_1.AddColumn("Nome" , left! , lv_1.width*0.25)
//	//lv_1.AddColumn("Tipo" , left! , lv_1.width*0.15)
//	//lv_1.AddColumn("Dati Principali" , left! , lv_1.width*0.40)
//	//lv_1.AddColumn("Ulteriori Informazioni" , left! , lv_1.width*0.20)
//	
//	//--- imposta le picture 
//	tv_root.deletepictures()
//	tv_root.pictureheight = 16
//	tv_root.picturewidth = 16
//	
//	
//	//tv_root.picturemaskcolor = rgb(255,255,255)
//	//tv_root.addpicture("Custom039!")								// 2
//	//	tv_root.addpicture("ExecuteSQL5!")	        // 8
//	string k_str="Database!"
//	
//	tv_root.addpicture(k_str)                 			// 1
//	tv_root.addpicture(k_path_risorse + "\cartella.ico")		// 2
//	tv_root.addpicture("Custom050!")									// 3
//	tv_root.addpicture("UserObject1!")								// 4
//	tv_root.addpicture("WinLogo!")								   // 5 
//	tv_root.addpicture(k_path_risorse + "\barcode.ico")		// 6
//	tv_root.addpicture(k_path_risorse + "\Point14.ico")		// 7
//	tv_root.addpicture("Window!")									   // 8 
//	tv_root.addpicture("Deploy!")										// 9
//	tv_root.addpicture(k_path_risorse + "\meca.ico")      	// 10
//	tv_root.addpicture(k_path_risorse + "\meca_open.ico")    // 11
//	tv_root.addpicture(k_path_risorse + "\meca_dett.ico")    // 12
//	tv_root.addpicture(k_path_risorse + "\nav_fatt.ico")      	 // 13
//	tv_root.addpicture(k_path_risorse + "\nav_fatt_open.ico")    // 14
//	tv_root.addpicture(k_path_risorse + "\nav_fatt_dett.ico")    // 15
//	tv_root.addpicture(k_path_risorse + "\nav_sped.ico")      	 // 16
//	tv_root.addpicture(k_path_risorse + "\nav_sped_open.ico")    // 17
//	tv_root.addpicture(k_path_risorse + "\nav_sped_dett.ico")    // 18
//	tv_root.addpicture("Picture!")										 // 19
//	
//	lv_1.deletesmallpictures()
//	lv_1.smallpictureheight = 16
//	lv_1.smallpicturewidth = 16
//	//lv_1.smallpicturemaskcolor = rgb(255,255,255)
//	lv_1.addsmallpicture( "Database!")                			// 1
//	lv_1.addsmallpicture(k_path_risorse + "\cartella.ico")	// 2
//	lv_1.addsmallpicture( "Custom050!")                		// 3
//	lv_1.addsmallpicture( "UserObject1!")                		// 4
//	lv_1.addsmallpicture( "WinLogo!")  						      // 5
//	lv_1.addsmallpicture( k_path_risorse + "\barcode.ico") 	// 6
//	lv_1.addsmallpicture( k_path_risorse + "\Point14.ico")   // 7
//	lv_1.addsmallpicture( "Window!")							      // 8
//	lv_1.addsmallpicture( "Deploy!")	             				// 9
//	lv_1.addsmallpicture(k_path_risorse + "\meca.ico")       // 10
//	lv_1.addsmallpicture(k_path_risorse + "\meca_open.ico")  // 11
//	lv_1.addsmallpicture(k_path_risorse + "\meca_dett.ico")  // 12
//	lv_1.addsmallpicture(k_path_risorse + "\nav_fatt.ico")      	// 13
//	lv_1.addsmallpicture(k_path_risorse + "\nav_fatt_open.ico")    // 14
//	lv_1.addsmallpicture(k_path_risorse + "\nav_fatt_dett.ico")    // 15
//	lv_1.addsmallpicture(k_path_risorse + "\nav_sped.ico")      	// 16
//	lv_1.addsmallpicture(k_path_risorse + "\nav_sped_open.ico")    // 17
//	lv_1.addsmallpicture(k_path_risorse + "\nav_sped_dett.ico")    // 18
//	lv_1.addsmallpicture("Picture!")    		// 19
//	
//	lv_1.deletelargepictures()
//	lv_1.largepictureheight = 32
//	lv_1.largepicturewidth = 32
//	lv_1.largepicturemaskcolor = rgb(255,255,255)
//	lv_1.addlargepicture( "Database!")                			// 1
//	lv_1.addlargepicture(k_path_risorse + "\cartella.ico")	// 2
//	lv_1.addlargepicture( "Custom050!")                		// 3
//	lv_1.addlargepicture( "UserObject1!")                		// 4
//	lv_1.addlargepicture(" WinLogo!")      		    			// 5
//	lv_1.addlargepicture( k_path_risorse + "\barcode.ico") 	// 6
//	lv_1.addlargepicture( k_path_risorse + "\Point14.ico")   // 7
//	lv_1.addlargepicture( "WinLogo!")							   // 8
//	lv_1.addlargepicture( "Deploy!") 			       	   	// 9
//	lv_1.addlargepicture(k_path_risorse + "\meca.ico")       // 10
//	lv_1.addlargepicture(k_path_risorse + "\meca_open.ico")  // 11
//	lv_1.addlargepicture(k_path_risorse + "\meca_dett.ico")  // 12
//	lv_1.addlargepicture(k_path_risorse + "\nav_fatt.ico")      	// 13
//	lv_1.addlargepicture(k_path_risorse + "\nav_fatt_open.ico")    // 14
//	lv_1.addlargepicture(k_path_risorse + "\nav_fatt_dett.ico")    // 15
//	lv_1.addlargepicture(k_path_risorse + "\nav_sped.ico")      	// 16
//	lv_1.addlargepicture(k_path_risorse + "\nav_sped_open.ico")    // 17
//	lv_1.addlargepicture(k_path_risorse + "\nav_sped_dett.ico")    // 18
//	lv_1.addlargepicture("Picture!")    							// 19
//	
	post inizializza_lista()

	setpointer(kpointer_orig)

	
end if

end event

on w_g_tab_tvn.create
int iCurrent
call super::create
this.st_visualizza=create st_visualizza
this.st_modifica=create st_modifica
this.st_conferma=create st_conferma
this.st_cancella=create st_cancella
this.st_1=create st_1
this.st_inserisci=create st_inserisci
this.tv_root=create tv_root
this.cb_cerca_1=create cb_cerca_1
this.sle_cerca=create sle_cerca
this.lv_1=create lv_1
this.st_vertical=create st_vertical
this.st_orizzontal=create st_orizzontal
this.dw_anteprima=create dw_anteprima
this.dw_stampa=create dw_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_visualizza
this.Control[iCurrent+2]=this.st_modifica
this.Control[iCurrent+3]=this.st_conferma
this.Control[iCurrent+4]=this.st_cancella
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_inserisci
this.Control[iCurrent+7]=this.tv_root
this.Control[iCurrent+8]=this.cb_cerca_1
this.Control[iCurrent+9]=this.sle_cerca
this.Control[iCurrent+10]=this.lv_1
this.Control[iCurrent+11]=this.st_vertical
this.Control[iCurrent+12]=this.st_orizzontal
this.Control[iCurrent+13]=this.dw_anteprima
this.Control[iCurrent+14]=this.dw_stampa
end on

on w_g_tab_tvn.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_visualizza)
destroy(this.st_modifica)
destroy(this.st_conferma)
destroy(this.st_cancella)
destroy(this.st_1)
destroy(this.st_inserisci)
destroy(this.tv_root)
destroy(this.cb_cerca_1)
destroy(this.sle_cerca)
destroy(this.lv_1)
destroy(this.st_vertical)
destroy(this.st_orizzontal)
destroy(this.dw_anteprima)
destroy(this.dw_stampa)
end on

event resize;//---
int k_pos_orizzontal
	
	if not ki_win_minimizzata and ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN then

		this.setredraw(false)

		tv_root.x = 15
		tv_root.y = 15
      
		if lv_1.visible = true then

	      if tv_root.visible = true then
				
	         if st_vertical.X < this.width / 10 then
					st_vertical.X =this.width / 10
			end if
	         if st_vertical.y < this.height / 10 then
					st_vertical.y = this.height / 10
			end if
	         tv_root.width =  st_vertical.X - 15 // / 3.5 - 60
				lv_1.width =  this.width - st_vertical.X - st_vertical.width - 60 // this.width - tv_root.width - 70 
			else
	         tv_root.width = 0
				lv_1.width = this.width - 60 
			end if

				
			if dw_anteprima.visible = true then
				if st_orizzontal.y < lv_1.y * 8 then
					st_orizzontal.y = lv_1.y * 8 
				end if
				if st_orizzontal.y > this.height - 200 then
					st_orizzontal.y = this.height - 200
				end if
				dw_anteprima.height =  this.height - st_orizzontal.y - st_orizzontal.height - 140 // this.width - tv_root.width - 70 
				dw_anteprima.width = lv_1.width + tv_root.width + st_vertical.width
				k_pos_orizzontal = st_orizzontal.y
			else
				k_pos_orizzontal = this.height - 120
			end if

			lv_1.height = k_pos_orizzontal - 30
			tv_root.height = lv_1.height //this.height - 120
//			lv_1.height = tv_root.height


		else

//=== Dimensione tv nella window 
			tv_root.width = this.width - 70 
//			st_vertical.width = 0
//			st_vertical.X = 0
			
		end if

		
		if lv_1.visible = true and lv_1.width > 0 then
//=== Posiziona tv nella window 
//=== Posiziona list nella window 
//			tv_root.y = (this.height - tv_root.height) / 30
	      if tv_root.visible = true then
				st_vertical.height = tv_root.height
				st_vertical.y = tv_root.y
				lv_1.x = st_vertical.x + st_vertical.width //tv_root.width + tv_root.x 
			else
				lv_1.x = tv_root.x
			end if
			lv_1.y = tv_root.y
			
			st_vertical.visible = tv_root.visible
			
			if dw_anteprima.visible then
				dw_anteprima.x = tv_root.x
				dw_anteprima.y = st_orizzontal.y + st_orizzontal.height
				st_orizzontal.width = dw_anteprima.width
				st_orizzontal.x = dw_anteprima.x
			end if

			st_orizzontal.visible = dw_anteprima.visible
			
		else
			lv_1.y = (this.height - lv_1.height) / 30
			lv_1.x = 15
		end if

	
//=== Dimensiona le comlonne all'interno della listview
//		lv_1.setColumn(1, "Nome" , left! , lv_1.width*0.25)
//		lv_1.setColumn(2, "Tipo" , left! , lv_1.width*0.15)
//		lv_1.setColumn(3, "Dati Principali" , left! , lv_1.width*0.40)
//		lv_1.setColumn(4, "Ulteriori Informazioni" , left! , lv_1.width*0.20)
	
	
		this.setredraw(true)
		
	end if



end event

event close;call super::close;//
string k_visible = "1", k_view
string k_pos, k_rcx
st_profilestring_ini kst_profilestring_ini


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
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))

	if	dw_anteprima.visible = false then
		k_visible = "0"
	end if
	kst_profilestring_ini.nome = "treeview_nascondi_anteprima"
	kst_profilestring_ini.valore = k_visible
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))

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
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))

//--- Salva Posizioni delle ST_ x confine tra tree e list e anteprima
	k_pos = string(st_vertical.x)
	kst_profilestring_ini.nome = "treeview_pos_vertical"
	kst_profilestring_ini.valore = k_pos
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))

	k_pos = string(st_orizzontal.y)
	kst_profilestring_ini.nome = "treeview_pos_orizzontal"
	kst_profilestring_ini.valore = k_pos
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))


	if isvalid(kufi_treeview) then destroy kufi_treeview

end event

event activate;//
this.setredraw(false)
//
////Check dimensioni delle datawindow
//	if st_vertical.Y < this.height / 10 then
//		tv_root.y = this.height / 10
////		st_vertical.y = this.height / 10
//	end if
//	if st_orizzontal.X < this.width / 10 then
//		st_orizzontal.x = this.width / 10
//	end if
//
	this.triggerevent( resize!)

this.setredraw(true)

end event

event deactivate;//

end event

event key;call super::key;//
end event

event u_ricevi_da_elenco;//
end event

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_tvn
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_tvn
integer x = 1829
integer y = 1248
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_tvn
integer x = 0
integer y = 1260
integer width = 187
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_tvn
integer x = 288
integer y = 1216
integer width = 238
end type

event st_ritorna::clicked;call super::clicked;//
close(parent)
end event

type st_visualizza from statictext within w_g_tab_tvn
boolean visible = false
integer x = 297
integer y = 1136
integer width = 270
integer height = 64
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

type st_modifica from statictext within w_g_tab_tvn
boolean visible = false
integer x = 293
integer y = 1064
integer width = 256
integer height = 64
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

type st_conferma from statictext within w_g_tab_tvn
boolean visible = false
integer y = 1192
integer width = 256
integer height = 64
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

type st_cancella from statictext within w_g_tab_tvn
boolean visible = false
integer x = 9
integer y = 1120
integer width = 242
integer height = 64
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

type st_1 from statictext within w_g_tab_tvn
boolean visible = false
integer x = 9
integer y = 1120
integer width = 242
integer height = 64
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

type st_inserisci from statictext within w_g_tab_tvn
boolean visible = false
integer x = 9
integer y = 1052
integer width = 242
integer height = 64
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

type tv_root from treeview within w_g_tab_tvn
event u_rbuttonup pbm_rbuttonup
integer x = 5
integer y = 48
integer width = 814
integer height = 972
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hasbuttons = false
boolean linesatroot = true
string picturename[] = {"","","","","","",""}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event u_rbuttonup;//
//		parent.triggerevent("rbuttonup")

//
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

event dragwithin;//
//kuf_treeview kuf1_treeview


//kuf1_treeview = create kuf_treeview

	kufi_treeview.kitv_tv1 = tv_root
	kufi_treeview.kilv_lv1 = lv_1

	kufi_treeview.u_treeview_dragwithin( source, handle)
//destroy kuf1_treeview





end event

event dragdrop;//
//kuf_treeview kuf1_treeview


//kuf1_treeview = create kuf_treeview

	kufi_treeview.kitv_tv1 = tv_root
	kufi_treeview.kilv_lv1 = lv_1

	kufi_treeview.u_treeview_dragdrop( source, handle)
//destroy kuf1_treeview



end event

event clicked;////
ki_flag_tree_appena_espanso = false
//kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree
//
////---
////--- valorizza la tree 
////---
////
////kuf_treeview kuf1_treeview
//treeviewitem ktvi_1
//pointer oldpointer  // Declares a pointer variable
//
//
//
////=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)
//
//
////--- x evitare che il ramo si espanda e comprima subito (capita quando 
////--- clicco sulla list fino a root poi cerco di aprire un ramo nella tree)
//	tv_root.GetItem(handle, ktvi_1)
//	ktvi_1.children = true
////	if ktvi_1.Expanded then
//////		ktvi_1.Expanded = false
////		ktvi_1.children = true
////		tv_root.setItem(handle, ktvi_1)
////		tv_root.collapseitem(handle)
////	else
//		POST cliccato_tree()
////	end if
//	
//
////=== Ripristina il Puntatore originale
//oldpointer = SetPointer(oldpointer)
//
//
end event

event getfocus;//
kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree


end event

event rightclicked;////
//ki_flag_tree_appena_espanso = false
//kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree

////---
////--- valorizza la tree 
////---
////
////kuf_treeview kuf1_treeview
//treeviewitem ktvi_1
//pointer oldpointer  // Declares a pointer variable
//
//
//
////=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)
//
//
////--- x evitare che il ramo si espanda e comprima subito (capita quando 
////--- clicco sulla list fino a root poi cerco di aprire un ramo nella tree)
//	tv_root.GetItem(handle, ktvi_1)
//	ktvi_1.children = true
//
//	if ktvi_1.Expanded then
////		ktvi_1.Expanded = false
//		ktvi_1.children = true
//		tv_root.setItem(handle, ktvi_1)
//		tv_root.collapseitem(handle)
//	end if
//	
////=== Ripristina il Puntatore originale
//oldpointer = SetPointer(oldpointer)

	
end event

event selectionchanged;//
kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree

//---
//--- valorizza la tree 
//---
treeviewitem ktvi_1
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


//--- x evitare che il ramo si espanda e comprima subito (capita quando 
//--- clicco sulla list fino a root poi cerco di aprire un ramo nella tree)
//	tv_root.GetItem(newhandle, ktvi_1)
//	ktvi_1.children = true

if not ki_flag_tree_appena_espanso then
	cliccato_tree()
end if	
	

//=== Ripristina il Puntatore originale
oldpointer = SetPointer(oldpointer)


end event

event selectionchanging;
Integer				li_Cnt, li_Start
Long					ll_OldParent, ll_NewParent
Boolean				lb_Changed
TreeViewItem		ltvi_Old, ltvi_New

//ib_Retrieve = True

If GetItem(oldhandle, ltvi_Old) = -1 Or GetItem(newhandle, ltvi_New) = -1 Then Return 0

If ltvi_Old.Level = ltvi_New.Level Then
	// Changing selection to another item on the same level.
	// First determine if the DW will need to be re-retrieved.  If the
	// new item has the same parent as the old, it does not.
	If FindItem(ParentTreeItem!, oldhandle) = FindItem(ParentTreeItem!, newhandle) Then
//		ib_Retrieve = False
		Return 0
	end if
end if
end event

type cb_cerca_1 from commandbutton within w_g_tab_tvn
boolean visible = false
integer x = 631
integer y = 1244
integer width = 233
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova..."
end type

event clicked;//
//=== Posiziono sulla anagrafica specificata
integer k_riga, k_inizio_find, k_righe_tot, k_pos, k_larg_campo
string k_campo, k_tipo_campo, k_valore_col, k_nome_col
long k_rc
int k_width
string k_find, k_nome_colonna
boolean k_extendedselect
pointer oldpointer  // Declares a pointer variable
alignment k_align
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
//GraphicObject k_which_control
//

lv_1.SetFocus ( )
lv_1.ExtendedSelect = false
lv_1.getColumn(1, k_campo, k_align, k_width) 


//=== Se ho scritto qualcosa e se e' diverso dal nome della testata della col.
if LenA(trim(sle_cerca.text)) > 0 and upper(trim(sle_cerca.text)) <> upper(trim(k_campo)) then

//--- Salvo la proprieta' di Attivo multi-selezione delle righe 
		k_extendedselect = lv_1.extendedselect  
	
	
//=== Se NON sono in ricerca lancio INIZIALIZZA()
	if this.text = "Trova..." then 

//--- Vedo se ho scritto qualcosa per cercare
		k_nome_col = " "
		k_rc = lv_1.getColumn(1, k_nome_col , k_align, k_larg_campo)
		if k_rc >= 0 then
			if LenA(trim(k_nome_col)) > 0 then
				k_nome_col = upper(trim(LeftA(k_nome_col,20)))
			end if
		end if

		if LenA( trim(sle_cerca.text)) > 0 and trim(sle_cerca.text) <> k_nome_col then
		
//=== Puntatore Cursore da attesa.....
			oldpointer = SetPointer(HourGlass!)

			k_inizio_find = lv_1.SelectedIndex ( )
		
			k_find =	trim(sle_cerca.text) 
						 
			if k_inizio_find < 0 then
				k_inizio_find = 1
			end if
			k_riga = k_inizio_find + 1
			k_righe_tot = lv_1.totalitems()
			lv_1.getitem(k_riga, 1, k_valore_col)
			k_pos = PosA (upper(k_valore_col), k_find, 1)
			do while k_pos <= 0 and k_righe_tot >= k_riga
				k_riga++
				lv_1.getitem(k_riga, 1, k_valore_col)
				k_pos = PosA (upper(k_valore_col), k_find, 1)
			loop

			if k_pos <= 0 and k_inizio_find > 1 then //allora ricerco ancora dalla prima riga
				k_riga = 1
				lv_1.getitem(k_riga, 1, k_valore_col)
				k_pos = PosA (upper(k_valore_col), k_find, 1)
				do while k_pos <= 0 and k_righe_tot >= k_riga
					k_riga++
					lv_1.getitem(k_riga, 1, k_valore_col)
					k_pos = PosA (upper(k_valore_col), k_find, 1)
				loop
			end if
	
			if k_pos <= 0 then
				
				SetPointer(oldpointer)
				messagebox("Ricerca fallita", "Dato richiesto non trovato~n~rcercato: "+trim(k_find))
				
			else
				
				lv_1.GetItem (k_riga, klvi_listviewitem )
	
				klvi_listviewitem.HasFocus = TRUE
				klvi_listviewitem.Selected = TRUE
				lv_1.SetItem(k_riga, klvi_listviewitem)
	
	//			k_riga = lv_1.selectedindex ()
	
	//--- scroll della lista sull'indice trovato
				if not (kuf1_data_base.u_listview_scroll(lv_1, k_riga)) then
					SetPointer(oldpointer)
					messagebox("Posizionamento fallito", "Il dato richiesto e' stato trovato alla riga " + string (k_riga) &
								  + "~n~rper posizionarsi sulla riga indicata agire con le frecce o la barra di scorrimento. ")
				end if
				
			end if
	
			SetPointer(oldpointer)
	
		end if

	end if
//--- Ripristino la proprieta' di Attivo multi-selezione delle righe 
	lv_1.extendedselect = k_extendedselect
	
else
	
	sle_cerca.text = ""
	
end if

sle_cerca.visible = false
this.visible = false

////=== Se NON sono in ricerca lancio INIZIALIZZA()
//if this.text <> "Trova..." then 
//	inizializza_lista()
//end if

this.text = "Trova..."

//
end event

type sle_cerca from singlelineedit within w_g_tab_tvn
boolean visible = false
integer x = 878
integer y = 1244
integer width = 805
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15780518
string text = "none"
textcase textcase = upper!
end type

event getfocus;//
	this.selecttext( 1, LenA(this.text))
end event

type lv_1 from listview within w_g_tab_tvn
integer x = 965
integer y = 4
integer width = 1463
integer height = 640
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewreport!
string largepicturename[] = {"point14!","","","","","",""}
long largepicturemaskcolor = 16777215
string smallpicturename[] = {"","","","","","",""}
long smallpicturemaskcolor = 16777215
long statepicturemaskcolor = 536870912
end type

event doubleclicked;//---
//--- Estendo il ramo della list
//---
cliccato_list(index)
//
end event

event columnclick;//---
//--- ordinamento x colonna
//---
string k_label
integer k_width
pointer kp_oldpointer
listviewitem klvi_1
alignment k_align



//=== Puntatore Cursore da attesa.....
	kp_oldpointer = SetPointer(HourGlass!)

	this.SetRedraw(false)

	if this.totalitems( ) > 1 then
	
	   this.GetColumn(column, k_label, k_align, k_width)

//--- se non numerico
		if k_align <> right! then
		
			this.Sort ( UserDefinedSort!, column )
			
		else
			this.Sort ( UserDefinedSort!, column )

		end if
		
//--- imposto il senso del sort così la prossima è l contrario
		if this.tag = string(column) + "D" then
			this.tag = string(column) + "A"
		else
			this.tag = string(column) + "D"
		end if
		

	end if

	this.SetRedraw(true)


//=== Puntatore Cursore da attesa.....
	SetPointer(kp_oldpointer)


end event

event sort;//
//--- sort scatenato quando pigi su testa delle colonne (align=right)

ListViewItem lvi, lvi2

if index1 = 1 then
	RETURN -1
else

if index2 = 1 then
	RETURN 1
else
		
	This.GetItem(index1, lvi)
	
	This.GetItem(index2, lvi2)
	
	IF lvi.PictureIndex < lvi2.PictureIndex THEN
			RETURN 1
	ELSE
		IF lvi.PictureIndex > lvi2.PictureIndex THEN
			RETURN -1
			
		ELSE
			This.GetItem(index1, column, lvi)
	
			This.GetItem(index2, column, lvi2)
	
			if this.tag = string(column) + "D" then
				IF lvi.label > lvi2.label THEN
					RETURN 1
				ELSE
					IF lvi.label < lvi2.label THEN
						RETURN -1
					ELSE
						RETURN 0
					END IF
				END IF
			else
				IF lvi.label < lvi2.label THEN
					RETURN 1
				ELSE
					IF lvi.label > lvi2.label THEN
						RETURN -1
					ELSE
						RETURN 0
					END IF
				END IF
			end if
		end if
	
	END IF
end if
end if


end event

event rightclicked;//
//parent.triggerevent(rbuttondown!)
	parent.triggerevent("rbuttonup")

end event

event clicked;//

	kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_list

	attiva_tasti()

//--- attivo modalita' anteprima nella apposita dw_anteprima		
	if index > 1 and dw_anteprima.visible then
		
//		kufi_treeview.kitv_tv1 = tv_root
//		kufi_treeview.kilv_lv1 = lv_1
		kufi_treeview.u_open ( kkg_flag_modalita_anteprima )

	end if	
end event

event losefocus;//
//string k_campo 
//integer k_larg_campo, k_ctr, k_rc
//alignment k_align
//listview kilv_lv1
//
//kilv_lv1 = this


//kufi_treeview.u_listview_salva_dim_colonne(tv_root, lv_1, " ")

//
////--- Salvo dimensioni delle colonne
//   k_ctr = 1
//	k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align, k_larg_campo)
//	do while  k_rc > 0
//		k_rc = integer(kuf1_data_base.profilestring_leggi_scrivi(2, "tv_larg_campo_" + trim(k_campo), string(k_larg_campo)))
//		k_ctr++
//		k_rc = kilv_lv1.getColumn(k_ctr, k_campo , k_align , k_larg_campo)
//	loop

end event

event insertitem;//
sle_cerca.text = "none"
end event

event getfocus;//
kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_list

end event

type st_vertical from statictext within w_g_tab_tvn
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer x = 873
integer y = 68
integer width = 59
integer height = 756
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeWE!"
long textcolor = 255
long backcolor = 0
long bordercolor = 268435456
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	if Parent.PointerX() > parent.width / 10 then
		This.x = Parent.PointerX()
	end if
End If


end event

event mouseup;//
parent.triggerevent (resize!)

end event

type st_orizzontal from statictext within w_g_tab_tvn
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
integer x = 1024
integer y = 672
integer width = 1353
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 255
long backcolor = 0
long bordercolor = 268435456
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	if Parent.PointerY() > parent.height / 10 then
		This.y = Parent.PointerY()
	end if
End If


end event

event mouseup;//
parent.triggerevent (resize!)

end event

type dw_anteprima from uo_d_std_1 within w_g_tab_tvn
integer x = 937
integer y = 772
integer width = 983
integer height = 320
integer taborder = 50
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_stampa from datawindow within w_g_tab_tvn
boolean visible = false
integer x = 1970
integer y = 768
integer width = 434
integer height = 312
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_x_stampa_listview"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

