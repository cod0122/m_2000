$PBExportHeader$w_g_tab_tv.srw
forward
global type w_g_tab_tv from w_g_tab
end type
type st_visualizza from statictext within w_g_tab_tv
end type
type st_modifica from statictext within w_g_tab_tv
end type
type st_conferma from statictext within w_g_tab_tv
end type
type st_cancella from statictext within w_g_tab_tv
end type
type st_1 from statictext within w_g_tab_tv
end type
type st_inserisci from statictext within w_g_tab_tv
end type
type tv_root from treeview within w_g_tab_tv
end type
type lv_1 from listview within w_g_tab_tv
end type
type st_vertical from statictext within w_g_tab_tv
end type
type st_orizzontal from statictext within w_g_tab_tv
end type
type dw_anteprima from uo_d_std_1 within w_g_tab_tv
end type
type dw_stampa from datawindow within w_g_tab_tv
end type
end forward

global type w_g_tab_tv from w_g_tab
integer width = 3049
integer height = 2208
string title = "Navigatore"
long backcolor = 16777215
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
event u_wtitolo_path ( )
st_visualizza st_visualizza
st_modifica st_modifica
st_conferma st_conferma
st_cancella st_cancella
st_1 st_1
st_inserisci st_inserisci
tv_root tv_root
lv_1 lv_1
st_vertical st_vertical
st_orizzontal st_orizzontal
dw_anteprima dw_anteprima
dw_stampa dw_stampa
end type
global w_g_tab_tv w_g_tab_tv

type variables
//
private kuf_treeview kufi_treeview
private st_treeview_oggetto kist_treeview_oggetto 

private string ki_titolo_window_orig 

private boolean ki_flag_tree_appena_espanso = true
private boolean ki_flag_list_appena_espanso = false


private time ki_time_lbuttondown
private long ki_time_lbuttondown_riga=0
private time ki_time_rileggi_auto


end variables

forward prototypes
private function integer forma_tree (long k_handle_item_padre)
protected subroutine attiva_tasti ()
protected subroutine inizializza_lista ()
private subroutine cliccato_list (long k_index)
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private subroutine aggiorna_liste ()
private subroutine open_dettaglio (string k_operazione)
protected function string inizializza ()
protected subroutine stampa ()
protected subroutine crea_dw_stampa_da_listview ()
private subroutine treeview_collassa_tutti_i_rami ()
private subroutine leggi_ramo_treeviewitem ()
private subroutine cliccato_tree ()
protected function st_esito aggiorna_window ()
protected function integer u_dammi_item_padre_da_list ()
protected subroutine put_obj_trova ()
protected subroutine open_start_window ()
protected subroutine set_window_size ()
public subroutine resetta ()
end prototypes

event u_wtitolo_path();//
string k_path = " "
int k_rc
long k_handle
//listviewitem klvi_listviewitem
treeviewitem ktv_treeviewitem
st_treeview_data kst_treeview_data


//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
////kufi_treeview.kitv_tv1 = tv_root
////kufi_treeview.kilv_lv1 = lv_1
kst_treeview_data = kufi_treeview.u_get_st_treeview_data( )

if kst_treeview_data.handle > 0 then
	k_handle = kst_treeview_data.handle
	
	k_rc = tv_root.getitem(k_handle, ktv_treeviewitem) 
	k_path = trim(ktv_treeviewitem.label) 
	
	do 
		k_handle = tv_root.finditem (Parenttreeitem!,k_handle )
		if k_handle > 0 then
			k_rc = tv_root.getitem(k_handle, ktv_treeviewitem) 
			k_path = trim(ktv_treeviewitem.label) + "\" + k_path
		end if
	loop until k_handle <=0
	
	this.title = ki_titolo_window_orig + ": \" + k_path

end if


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
	st_conferma.enabled = false
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
//	super::inizializza_lista()

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

private subroutine cliccato_list (long k_index);//
pointer kpointer 


	if k_index > 0 and not ki_flag_list_appena_espanso then
		
		kpointer = setpointer(hourglass!)
		ki_flag_list_appena_espanso = true
		tv_root.setredraw(false)
		lv_1.setredraw(false)

//--- imposto il percorso sulla barra del titolo
		kiw_this_window.triggerevent ("u_wtitolo_path")

//--- salva le dimensioni delle colonne così come sistemate da utente
		kufi_treeview.u_listview_salva_dim_colonne()
		
//--- salva il numero di riga per poi potersi automaticamente posizionare se torna qui sopra		
		if  kufi_treeview.kilv_lv1.selectedindex( ) > 1 then
			kufi_treeview.u_treeview_item_salva( )
			kufi_treeview.u_treeview_data_item_salva( )
		end if
		
		leggi_ramo_treeviewitem()

		tv_root.setredraw(true)
		lv_1.setredraw(true)

		ki_flag_list_appena_espanso = false
		setpointer(kpointer)
	
	end if


//	attiva_tasti()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : tag della window
//===
long k_handle_item = 0, k_handle_item_padre = 0
kuf_treeview kuf1_treeview
//treeviewitem ktvi_1
listviewitem klvi_1


//--- se schiacciato CERCA metto il fuoco prioritariamente sulla lista
if k_par_in =  kkg_flag_richiesta_trova or k_par_in = kkg_flag_richiesta_trova_ancora  then
	if lv_1.visible then 
		lv_1.setfocus()
	else
		tv_root.setfocus( )
	end if
	
end if

choose case  k_par_in 

	case kkg_flag_richiesta_refresh				//Aggiorna Liste
		aggiorna_liste()

//richiesta inserimento //richiesta cancellazione //richiesta visualizzazione //richiesta modifica	//richiesta stampa
	case kkg_flag_richiesta_inserimento		&	
			, kkg_flag_richiesta_cancellazione  &		
			, kkg_flag_richiesta_visualizzazione &	
			, kkg_flag_richiesta_modifica		&		
			, kkg_flag_richiesta_stampa				
		post open_dettaglio(k_par_in)


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
		st_vertical.visible = tv_root.visible
		st_orizzontal.visible = dw_anteprima.visible
		this.triggerevent ( resize! ) 

	case kkg_flag_richiesta_libero3	//Stampa datawindow con il fuoco
		stampa()

	case kkg_flag_richiesta_libero71	//visualizzazione list 
		lv_1.view = listviewlargeicon!

	case kkg_flag_richiesta_libero72	//visualizzazione list 
		lv_1.view = listviewsmallicon!

	case kkg_flag_richiesta_libero73	//visualizzazione list 
		lv_1.view = listviewlist!

	case kkg_flag_richiesta_libero74	//visualizzazione list 
		lv_1.view = listviewreport!

	case else
		super::smista_funz(k_par_in)
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
//	kG_menu.m_finestra.m_gestione.enable()
//	kG_menu.m_finestra.m_gestione.show()

	if kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled <> st_conferma.enabled then
		kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = st_conferma.enabled
	end if
	if kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled <> st_inserisci.enabled then
		kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = st_inserisci.enabled
	end if
	if kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled <> st_modifica.enabled then
		kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = st_modifica.enabled
	end if
	if kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled <> st_cancella.enabled then
		kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = st_cancella.enabled
	end if
	if kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled <> st_visualizza.enabled then
		kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = st_visualizza.enabled
	end if
	if kG_menu.m_finestra.m_fin_stampa.enabled <> st_stampa.enabled then
		kG_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled
	end if

	if not kG_menu.m_finestra.m_trova.toolbaritemvisible  then
		kG_menu.m_finestra.m_trova.toolbaritemvisible = true 
	end if
	if not kG_menu.m_finestra.m_trova.visible or not kG_menu.m_finestra.m_trova.enabled then
		kG_menu.m_finestra.m_trova.visible = true 
		kG_menu.m_finestra.m_trova.enabled = true 
		kG_menu.m_finestra.m_trova.m_fin_cerca.enabled = true 
		kG_menu.m_finestra.m_trova.m_fin_cerca.visible = true 
		kG_menu.m_finestra.m_trova.m_fin_cerca.toolbaritemvisible = true
		kG_menu.m_finestra.m_trova.m_fin_cercaancora.enabled = true 
		kG_menu.m_finestra.m_trova.m_fin_cercaancora.visible = true 
		kG_menu.m_finestra.m_trova.m_fin_cercaancora.toolbaritemvisible = true
	end if
//	kG_menu.m_finestra.m_fin_filtra.enabled = true
	kG_menu.m_finestra.m_aggiornalista.enabled = true
	kG_menu.m_finestra.m_riordinalista.enabled = true
	kG_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
	

//
//--- Attiva/Dis. Voci di menu personalizzate
//

//--- Menu LIBERI in aggiunta alle normali funzionalità
	if not kG_menu.m_strumenti.m_fin_gest_libero1.visible then
		kG_menu.m_strumenti.m_fin_gest_libero1.text = "Chiude tutti i 'rami'"
		kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Nasconde tutti i rami escluso quelli iniziali"
		kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero1.visible
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "comp.,"+kG_menu.m_strumenti.m_fin_gest_libero1.text
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "close!"
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	
	//	if tv_root.visible = true then
			kG_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi Strutture"
			kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra / Nascondi 'elenco' e pannello di 'anteprima' "
	//	else
	//		kG_menu.m_strumenti.m_fin_gest_libero2.text = "Visualizza Struttura"
	//		kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Visualizza a sinistra della Finestra la struttura ad albero"
	//	end if
		kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "nascondi,"+kG_menu.m_strumenti.m_fin_gest_libero2.text
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Layer!"
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
	
		kG_menu.m_strumenti.m_fin_gest_libero3.text = "Stampa Elenco"
		kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Stampa Elenco"
		kG_menu.m_strumenti.m_fin_gest_libero3.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero3.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "stampa,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom074!"
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	

		kG_menu.m_strumenti.m_fin_gest_libero7.text = "Visualizzazione"
		kG_menu.m_strumenti.m_fin_gest_libero7.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero7.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.toolbaritemText = "tipo,tipo visualizzazione"
		kG_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
	
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Visualizza icone grandi"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Tipo di visualizzazione icone grandi"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "grandi,"+kG_menu.m_strumenti.m_fin_gest_libero1.text
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "Custom097!"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
	
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Visualizza icone piccole"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Tipo di visualizzazione icone piccole"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "piccole,"+kG_menu.m_strumenti.m_fin_gest_libero2.text
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "Custom098!"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
	
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.text = "Visualizza elenco"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.microhelp = "Tipo di visualizzazione come elenco"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "elenco,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = "Custom099!"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritembarindex=2
		
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.text = "Visualizza dettagli"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.microhelp = "Tipo di visualizzazione elenco con dettaglio"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemText = "dettagli,"+kG_menu.m_strumenti.m_fin_gest_libero4.text
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName = "Custom100!"
		kG_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritembarindex=2
	end if
	
	
		
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

private subroutine open_dettaglio (string k_operazione);//
boolean k_attiva_funzione=false
//treeviewitem ktvi_1
st_esito kst_esito



kst_esito.esito = kkg_esito_ok

choose case  k_operazione 

	case kkg_flag_richiesta_inserimento		//richiesta inserimento
		if st_inserisci.enabled then
			k_attiva_funzione = true
		end if
		
	case kkg_flag_richiesta_cancellazione		//richiesta cancellazione
		if st_cancella.enabled then
			k_attiva_funzione = true
		end if

	case kkg_flag_richiesta_visualizzazione		//richiesta visualizzazione
		if st_visualizza.enabled then
			k_attiva_funzione = true
		end if
		
	case kkg_flag_richiesta_modifica		//richiesta modifica
		if st_modifica.enabled then
			k_attiva_funzione = true
		end if

	case kkg_flag_richiesta_stampa		//richiesta stampa
		if st_stampa.enabled then
			if tv_root.finditem(CurrentTreeItem!, 0) > 0 then 
				k_attiva_funzione = true
			end if
		end if

end choose

//--- se ho trovato una funzione da Aprire, eseguo!
if k_attiva_funzione then

//	kufi_treeview.kitv_tv1 = tv_root
//	kufi_treeview.kilv_lv1 = lv_1
	kst_esito = kufi_treeview.u_open ( k_operazione)
	
	if kst_esito.esito <> kkg_esito_ok then
	
		if k_operazione = kkg_flag_richiesta_stampa then
			if messagebox("Operazione non Eseguita", &
					"Funzione di 'Stampa' della Riga selezionata non e' consentita.~n~r"  &
					  + "Per stampare l'Elenco del Navigatore premere l'apposito pulsante.~n~r" &
					  + "Procedere con la stampa dell'Elenco?", Question!, yesno!, 1) = 1 then
				stampa()
			end if
		else
			messagebox("Operazione non Eseguita", &
					  kst_esito.sqlerrtext)
		end if
	end if	

//	kuf1_data_base.mostra_windows_attiva()

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

//		tv_root.setredraw( false)
//		lv_1.setredraw( false )
		
//--- seleziono item root solo l' prima volta 	
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

protected subroutine stampa ();//
st_stampe kst_stampe


choose case kuf1_data_base.u_getfocus_nome()

	case "lv_1", "tv_root"
		crea_dw_stampa_da_listview()

		kst_stampe.dw_print = dw_stampa
		if len(trim(this.title)) > 60 then
			kst_stampe.titolo = Right(trim(this.title), 60) 
		else
			kst_stampe.titolo = this.title 
		end if
		if kst_stampe.dw_print.rowcount() > 0 then
		
			kst_stampe.dw_syntax = trim(dw_stampa.describe("DataWindow.Syntax"))
			
			kuf1_data_base.stampa_dw(kst_stampe)
		
		end if
		
	case "dw_anteprima"
		dw_stampa.dataobject = dw_anteprima.dataobject
		dw_anteprima.rowscopy( 1, dw_anteprima.rowcount(), primary!, dw_stampa, 1, primary!)
		kst_stampe.dw_print = dw_stampa
		lv_1.getitem( lv_1.selectedindex( ) ,1, kst_stampe.titolo) 
		kst_stampe.titolo = Right(trim(trim(this.title)+kst_stampe.titolo), 60)
	
		if kst_stampe.dw_print.rowcount() > 0 then
		
			kst_stampe.dw_syntax = trim(dw_stampa.describe("DataWindow.Syntax"))
			
			kuf1_data_base.stampa_dw(kst_stampe)
		
		end if
end choose



	
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
long k_collassa_item, k_hdl = 0, k_hdl1=0
treeviewitem ktvi_1

	
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


//	resetta()  // crea l'oggetto KUF_TREEVIEW
	
//--- per x far vedere la root	
   	ki_st_open_w.flag_primo_giro = "S" 
	inizializza()

end subroutine

private subroutine leggi_ramo_treeviewitem ();//
pointer oldpointer  // Declares a pointer variable


ki_flag_tree_appena_espanso = true

	
//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	tv_root.setredraw(false)
	lv_1.setredraw(false)

	
	kufi_treeview.u_smista_treeview_listview( )


//--- per espandere l'item

	tv_root.setredraw(true)
	lv_1.setredraw(true)
	
	attiva_tasti()
	
//=== Ripristina il Puntatore originale
	oldpointer = SetPointer(oldpointer) 


end subroutine

private subroutine cliccato_tree ();//
long k_handle_item
st_treeview_data kst_treeview_data


//--- solo x il primo giro forza la lettura e l'espansione del ramo
   if ki_st_open_w.flag_primo_giro = "S" then 

		leggi_ramo_treeviewitem()
		k_handle_item=tv_root.finditem(RootTreeItem!, 0)
		if k_handle_item > 0 then
			tv_root.ExpandItem(k_handle_item)
		end if
	else
		
//--- non faccio la rilettura se clicco su root		
		kst_treeview_data = kufi_treeview.u_get_st_treeview_data( ) 
		k_handle_item = kst_treeview_data.handle
		if k_handle_item > 0 then
			leggi_ramo_treeviewitem()
		end if
		
	end if

	kiw_this_window.postevent ("u_wtitolo_path")


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

protected subroutine put_obj_trova ();//---
//--- Torna l'oggetto su cui fare il TROVA
//---


	if lv_1.visible then
		kiany_trova = lv_1
	end if





end subroutine

protected subroutine open_start_window ();//
//Use the following code to quickly count items in the TreeView control:
//     li_count = Send(handle(treeview_control), 4357, 0, 0)
//
//To find out how many items can be fully visible in the TreeView control visible area use the following script:
//     li_count = Send(handle(treeview_control), 4368, 0, 0)
//
//
//

ki_toolbar_window_presente=true

resetta()  // crea l'oggetto KUF_TREEVIEW

dw_anteprima.Object.DataWindow.ReadOnly='Yes'



end subroutine

protected subroutine set_window_size ();//
string k_visible, k_view
string k_pos, k_rcx
st_profilestring_ini kst_profilestring_ini
//

	
	super::set_window_size()


//--- posiziona e dimensiona le toolbar
//	kuf_utility kuf1_utility
//	kuf1_utility = create kuf_utility
//	kuf1_utility.u_toolbar_Restore(kiw_this_window, 0)
//	destroy kuf1_utility

	this.setredraw( false)
//--- fissa le dimensione delle barette verticale e orizzontale
//	st_vertical.backcolor = this.backcolor
	st_vertical.width = 20
	st_vertical.y = 30
//	st_orizzontal.backcolor = this.backcolor
	st_orizzontal.height =15
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
		st_vertical.visible = false
	else
		st_vertical.visible = true
	end if
	tv_root.visible = st_vertical.visible

//--- Eventualmente nasconde la Anteprima
	kst_profilestring_ini.nome = "treeview_nascondi_anteprima"
	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	k_visible = "1"
	if kst_profilestring_ini.esito <> "1" then
		k_visible = trim(kst_profilestring_ini.valore)
	end if
	if k_visible = "0" then
		st_orizzontal.visible = false
	else
		st_orizzontal.visible = true
	end if
	dw_anteprima.visible = st_orizzontal.visible
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

end subroutine

public subroutine resetta ();
//--- Crea istanza oggetto con le funzioni per gestire il tutto
if isvalid(kufi_treeview) then destroy kufi_treeview
kufi_treeview = create kuf_treeview
//--- Imposta gli oggetti nel Kuf_treeview
kufi_treeview.set_kitv_tv1 (tv_root)
kufi_treeview.set_kilv_lv1 (lv_1)
kufi_treeview.set_dw_anteprima(dw_anteprima)

end subroutine

on w_g_tab_tv.create
int iCurrent
call super::create
this.st_visualizza=create st_visualizza
this.st_modifica=create st_modifica
this.st_conferma=create st_conferma
this.st_cancella=create st_cancella
this.st_1=create st_1
this.st_inserisci=create st_inserisci
this.tv_root=create tv_root
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
this.Control[iCurrent+8]=this.lv_1
this.Control[iCurrent+9]=this.st_vertical
this.Control[iCurrent+10]=this.st_orizzontal
this.Control[iCurrent+11]=this.dw_anteprima
this.Control[iCurrent+12]=this.dw_stampa
end on

on w_g_tab_tv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_visualizza)
destroy(this.st_modifica)
destroy(this.st_conferma)
destroy(this.st_cancella)
destroy(this.st_1)
destroy(this.st_inserisci)
destroy(this.tv_root)
destroy(this.lv_1)
destroy(this.st_vertical)
destroy(this.st_orizzontal)
destroy(this.dw_anteprima)
destroy(this.dw_stampa)
end on

event resize;call super::resize;//---
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
				lv_1.width =  this.width - st_vertical.X - st_vertical.width -70 // this.width - tv_root.width - 70 
			else
				tv_root.width = 0
				lv_1.width = this.width - 75 
			end if

			if dw_anteprima.visible = true then
				if st_orizzontal.y < lv_1.y * 8 then
					st_orizzontal.y = lv_1.y * 8 
				end if
				if st_orizzontal.y > this.height - 200 then
					st_orizzontal.y = this.height - 200
				end if
				dw_anteprima.height =  this.height - st_orizzontal.y - st_orizzontal.height - 240 // this.width - tv_root.width - 70 
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
			tv_root.width = this.width - 25 
			tv_root.visible = true
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

	if dw_anteprima.visible = false then
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

	//--- forza la chiamata al gestore di memoria
//	GarbageCollect ( )
	

end event

event activate;call super::activate;//
this.setredraw(false)

//---- Scatena il timer (vedi l'evento)
	timer (0.30)

this.setredraw(true)

end event

event timer;call super::timer;//
//--- Richiesta ANTEPRIMA ?
if ki_time_lbuttondown_riga > 0 and not isnull(ki_time_lbuttondown) then
	if relativetime ( ki_time_lbuttondown, 0.4 ) < now() then

//--- resetta il timer x questo evento
		setnull(ki_time_lbuttondown)
		
//--- attivo modalita' anteprima nella apposita dw_anteprima		
		if isvalid(dw_anteprima) then
			if dw_anteprima.visible and dw_anteprima.enabled  then
				dw_anteprima.enabled = false
				
				kufi_treeview.u_open ( kkg_flag_modalita_anteprima )
				dw_anteprima.enabled = true
						
				if len(trim(dw_anteprima.dataobject)) > 0 then
					if dw_anteprima.rowcount( ) > 0 then
						
						dw_anteprima.Object.DataWindow.ReadOnly = "yes"
//--- attiva i LINK standard
						dw_anteprima.post event u_personalizza_dw ()
					end if
				end if
			end if
		end if	
		
	end if 
end if

//--- rilegge automaticamente se per un tot di tempo non si fa nulla sul navigatore
if relativetime ( ki_time_rileggi_auto, 1800 ) < now() then

//---- reinizializza il timer per eventuale auto-lettura
	ki_time_rileggi_auto = now()

//--- rilegge le liste 	
	smista_funz(kkg_flag_richiesta_refresh)

end if


end event

event deactivate;call super::deactivate;//
//---- Spegne il timer (vedi l'evento)
	timer (0)


end event

event u_open;call super::u_open;//
pointer kpointer_orig



ki_titolo_window_orig = this.title

kpointer_orig = setpointer(hourglass!)

if ki_utente_abilitato then

//--- listView x selezionare + righe
	lv_1.ExtendedSelect = TRUE
	
//--- imposta le icone nella tree e list
	kufi_treeview.u_imposta_treeview_icone(tv_root,  lv_1)


	lv_1.visible = true

	this.setredraw( true )
		
	inizializza_lista()

	setpointer(kpointer_orig)
	
end if

end event

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_tv
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_tv
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_tv
integer x = 1829
integer y = 1248
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_tv
integer x = 0
integer y = 1260
integer width = 187
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_tv
integer x = 288
integer y = 1216
integer width = 238
end type

event st_ritorna::clicked;call super::clicked;//
close(parent)
end event

type dw_trova from w_g_tab`dw_trova within w_g_tab_tv
integer x = 302
integer y = 964
end type

type st_visualizza from statictext within w_g_tab_tv
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

type st_modifica from statictext within w_g_tab_tv
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

type st_conferma from statictext within w_g_tab_tv
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

type st_cancella from statictext within w_g_tab_tv
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

type st_1 from statictext within w_g_tab_tv
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

type st_inserisci from statictext within w_g_tab_tv
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

type tv_root from treeview within w_g_tab_tv
event u_rbuttonup pbm_rbuttonup
integer x = 9
integer y = 44
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
long backcolor = 16777215
boolean border = false
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

event dragwithin;////
//
//
////
////	kufi_treeview.kitv_tv1 = tv_root
////	kufi_treeview.kilv_lv1 = lv_1
////
////	kufi_treeview.u_treeview_dragwithin( source, handle)  //ATTENZIONE PROBABILE CHE QUESTA ISTR. MANDA IN CRASH TUTTO!!!!!
////
//






end event

event dragdrop;//
//kuf_treeview kuf1_treeview


//kuf1_treeview = create kuf_treeview

//	kufi_treeview.kitv_tv1 = tv_root
//	kufi_treeview.kilv_lv1 = lv_1

	kufi_treeview.u_treeview_dragdrop( source, handle)
//destroy kuf1_treeview



end event

event clicked;//
ki_flag_tree_appena_espanso = false

//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()

end event

event getfocus;//
//kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree

//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()


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

	this.enabled = false

//--- x evitare che il ramo si espanda e comprima subito (capita quando 
//--- clicco sulla list fino a root poi cerco di aprire un ramo nella tree)
//	tv_root.GetItem(newhandle, ktvi_1)
//	ktvi_1.children = true

if not ki_flag_tree_appena_espanso then
	cliccato_tree()
end if	
	
	this.enabled = true

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

event itemexpanding;//
kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_tree

end event

type lv_1 from listview within w_g_tab_tv
event u_lbuttondown pbm_lbuttondown
event u_lbuttonup pbm_lbuttonup
integer x = 951
integer y = 28
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
long backcolor = 16777215
boolean border = false
boolean autoarrange = true
boolean fixedlocations = true
boolean hideselection = false
boolean twoclickactivate = true
boolean fullrowselect = true
boolean underlinehot = true
listviewview view = listviewreport!
string largepicturename[] = {"","","","","","",""}
long largepicturemaskcolor = 16777215
string smallpicturename[] = {"","","","","","",""}
long smallpicturemaskcolor = 16777215
long statepicturemaskcolor = 536870912
end type

event u_lbuttondown;//
//---- inizia il timer per capire quanto tengo premuto il tasto sx del mouse
if ki_time_lbuttondown_riga > 0 then
	ki_time_lbuttondown = now()
end if

end event

event u_lbuttonup;//---
//--- interrompe il timer per il tasto premuto
setnull(ki_time_lbuttondown)


end event

event doubleclicked;//---
//--- Estendo il ramo della list
//---

	if index > 0 then
		kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_list
		cliccato_list(index)
	end if


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


	this.enabled = false

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

	this.enabled = true

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


//---- inizia il timer per eventuale auto-lettura
	ki_time_rileggi_auto = now()

	ki_time_lbuttondown_riga = index
	

end event

event getfocus;//
//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()


end event

event key;//
long k_index


if key = keyenter! then
	kufi_treeview.ki_fuoco_tree_list = kufi_treeview.ki_fuoco_su_list
	k_index = selectedindex( ) 
	if k_index > 0 then
		event doubleclicked( k_index)
	end if

end if

end event

type st_vertical from statictext within w_g_tab_tv
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
boolean visible = false
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
long backcolor = 67108864
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

type st_orizzontal from statictext within w_g_tab_tv
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
boolean visible = false
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
long textcolor = 12639424
long backcolor = 12639424
long bordercolor = 8388608
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

type dw_anteprima from uo_d_std_1 within w_g_tab_tv
boolean visible = true
integer x = 937
integer y = 772
integer width = 983
integer height = 320
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
string title = "anteprima"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event getfocus;call super::getfocus;//
//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()


end event

type dw_stampa from datawindow within w_g_tab_tv
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

