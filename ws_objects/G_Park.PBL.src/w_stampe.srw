$PBExportHeader$w_stampe.srw
forward
global type w_stampe from w_g_tab
end type
type r_dimensione_win from rectangle within w_stampe
end type
type st_em_zoom from statictext within w_stampe
end type
type st_parametri from statictext within w_stampe
end type
type rb_2 from radiobutton within w_stampe
end type
type rb_1 from radiobutton within w_stampe
end type
type st_6 from statictext within w_stampe
end type
type dw_print from datawindow within w_stampe
end type
type dw_personalizza from datawindow within w_stampe
end type
type r_print from rectangle within w_stampe
end type
type cb_excel from commandbutton within w_stampe
end type
type cb_anteprima from commandbutton within w_stampe
end type
type cb_imposta from commandbutton within w_stampe
end type
type cb_stampa from commandbutton within w_stampe
end type
type em_zoom from editmask within w_stampe
end type
type cbx_landscape from checkbox within w_stampe
end type
type cbx_personalizzazioni from checkbox within w_stampe
end type
type dw_originale from datawindow within w_stampe
end type
type em_nro from editmask within w_stampe
end type
type cbx_personalizzazioni_salva from checkbox within w_stampe
end type
type cb_pdf from commandbutton within w_stampe
end type
type st1_em_zoom from statictext within w_stampe
end type
type gb_pagine from groupbox within w_stampe
end type
end forward

global type w_stampe from w_g_tab
integer width = 1819
integer height = 2172
string title = "Stampa"
long backcolor = 67108864
string icon = "Report5!"
string pointer = "Arrow!"
event u_ripri_size_win ( unsignedlong wparam,  long lparam )
event u_resize ( )
event u_anteprima ( unsignedlong wparam,  long lparam )
event rbuttonup pbm_rbuttonup
r_dimensione_win r_dimensione_win
st_em_zoom st_em_zoom
st_parametri st_parametri
rb_2 rb_2
rb_1 rb_1
st_6 st_6
dw_print dw_print
dw_personalizza dw_personalizza
r_print r_print
cb_excel cb_excel
cb_anteprima cb_anteprima
cb_imposta cb_imposta
cb_stampa cb_stampa
em_zoom em_zoom
cbx_landscape cbx_landscape
cbx_personalizzazioni cbx_personalizzazioni
dw_originale dw_originale
em_nro em_nro
cbx_personalizzazioni_salva cbx_personalizzazioni_salva
cb_pdf cb_pdf
st1_em_zoom st1_em_zoom
gb_pagine gb_pagine
end type
global w_stampe w_stampe

type variables
//w_stampe_1 kiwindow_stampe_1
private st_stampe kist_stampe
private boolean ki_personalizzato_dw = false
private boolean ki_ridimensiona_colonna = false
private long ki_ridimensione_x=0
private long ki_ridimensione_y=0
kuf_stampe kufi_stampe

end variables

forward prototypes
public subroutine zoom_avanti ()
public subroutine zoom_indietro ()
protected subroutine smista_funz (string k_par_in)
protected subroutine mostra_nascondi_colonne ()
protected subroutine attiva_tasti ()
protected subroutine attiva_menu ()
protected subroutine inizializza_0 ()
private subroutine aggiungi_testata ()
private subroutine crea_report ()
public function string get_filename ()
end prototypes

event u_ripri_size_win(unsignedlong wparam, long lparam);//


	this.title = "Esegui Stampa: " + trim(kist_stampe.titolo)


	this.windowState = normal!


//	this.setredraw(false)  ho dovuto comment.xchè altrim rimaneva sporco il video

	this.resize( r_dimensione_win.width, r_dimensione_win.Height )
	r_dimensione_win.visible = false


//=== Posiziona window all'interno della MDI
	if w_main.width > this.width then
		this.x = (w_main.width - this.width) / 2
	else
		this.x = 1
	end if
	if w_main.height > this.height then
		this.y = (w_main.height - this.height) / 4
	else
		this.y = 1
	end if
	w_main.show()

	dw_print.visible = false
	r_print.visible = false


	cb_imposta.visible = true
	cb_anteprima.visible = true
	cb_stampa.visible = true
	cb_excel.visible = true
	cb_ritorna.visible = true
	
	cb_imposta.BringToTop = true
	cb_anteprima.BringToTop = true
	cb_stampa.BringToTop = true
	cb_excel.BringToTop = true
	cb_ritorna.BringToTop = true
	
	this.setredraw(true)

	

end event

event u_anteprima(unsignedlong wparam, long lparam);//
int k_estratti=0
string k_zoom="100"
string k_prova
kuf_utility kuf1_utility



	this.title = "Anteprima di Stampa: " + trim(kist_stampe.titolo)

//--- applica o meno le personalizzazioni alla stampa
	crea_report()

	if em_nro.enabled = false	then
		k_prova=dw_print.modify("DataWindow.Print.Pageinclude.Range=0")
	else
		k_prova=dw_print.modify("DataWindow.Print.Page.Range='"+ &
								trim(em_nro.text)+"'")	
	end if

	k_zoom = trim(em_zoom.text)
	if k_zoom="100" then
		k_zoom="99"
	end if
	dw_print.modify("DataWindow.Print.Preview.Zoom=" + k_zoom)

	//send(handle(w_int_consumi), 274, 61472, 0)
	dw_print.move(1, 1)
	
	r_print.x = dw_print.x
	r_print.y = dw_print.x
	r_print.width = dw_print.width
	r_print.height = dw_print.height
	r_print.show()
//		r_print.bringtotop = true


	dw_print.hscrollbar = true
	dw_print.vscrollbar = true
	dw_print.livescroll = true
	dw_print.visible = true
	dw_print.enabled = true
	dw_print.bringtotop = true
//	dw_print.resizable = true
//	this.resizable = true

	dw_print.Modify("DataWindow.Print.Preview=No")
	dw_print.Modify("DataWindow.Print.Preview=Yes")
//	if k_zoom = "100" then
//		dw_print.Modify("DataWindow.Print.Preview=No")
//	else
//		if dw_print.describe("DataWindow.Print.Preview") = "No" then
//			dw_print.Modify("DataWindow.Print.Preview=Yes")
//		end if
//	end if

//=== Posiziona window all'interno della MDI
	this.resize( w_main.width * 0.85, w_main.Height * 0.70)
	if w_main.width > this.width then
		this.x = (w_main.width - this.width) / 2
	else
		this.x = 1
	end if
	if w_main.height > this.height then
		this.y = (w_main.height - this.height) / 4
	else
		this.y = 1
	end if


	dw_print.setfocus()
	


	
end event

event rbuttonup;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu


	attiva_tasti()


//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_agglista.visible = false
		m_menu.m_t_agglista.visible = false
		m_menu.m_inserisci.visible = false
		m_menu.m_inserisci.enabled = false
		m_menu.m_modifica.visible = false
		m_menu.m_t_modifica.visible = false
		m_menu.m_cancella.visible = false
		m_menu.m_cancella.enabled = false
		m_menu.m_t_cancella.visible = false
		m_menu.m_conferma.visible = false
		m_menu.m_conferma.enabled = false
		m_menu.m_zoom_a.visible = false
		m_menu.m_t_zoom.visible = false
		m_menu.m_zoom_i.visible = false
		m_menu.m_visualizza.visible = false
		m_menu.m_visualizza.enabled = false
		m_menu.m_zoom_a.visible = true
		m_menu.m_t_zoom.visible = true
		m_menu.m_zoom_i.visible = true
		m_menu.m_stampa.visible = st_stampa.enabled
		m_menu.m_t_stampa.visible = st_stampa.enabled
		m_menu.m_ritorna.visible = st_ritorna.enabled
		
		m_menu.m_t_lib_3.visible = kG_menu.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.visible = kG_menu.m_strumenti.m_fin_gest_libero1.visible
		m_menu.m_lib_1.enabled = kG_menu.m_strumenti.m_fin_gest_libero1.enabled
		m_menu.m_lib_1.text = kG_menu.m_strumenti.m_fin_gest_libero1.text
		m_menu.m_lib_2.visible = kG_menu.m_strumenti.m_fin_gest_libero2.visible
		m_menu.m_lib_2.enabled = kG_menu.m_strumenti.m_fin_gest_libero2.enabled
		m_menu.m_lib_2.text = kG_menu.m_strumenti.m_fin_gest_libero2.text
		m_menu.m_lib_3.visible = kG_menu.m_strumenti.m_fin_gest_libero3.visible
		m_menu.m_lib_3.enabled = kG_menu.m_strumenti.m_fin_gest_libero3.enabled
		m_menu.m_lib_3.text = kG_menu.m_strumenti.m_fin_gest_libero3.text
		

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		smista_funz(k_tag)


end event

public subroutine zoom_avanti ();//
int k_zoom


if dw_print.visible then 

	// controlla ol fattore Zoom se e' gia al max 
	k_zoom = integer(dw_print.describe("DataWindow.Print.Preview.Zoom"))
	IF k_zoom > 400 THEN
	
		Beep (1)
	
	ELSE
	
	//	if k_zoom = 100 then
	//		dw_print.Modify("DataWindow.Print.Preview=yes")
	//	end if
	
		k_zoom = k_zoom + 20
	
		dw_print.modify("DataWindow.Print.Preview.Zoom=" +&
							String (k_zoom))
	
	//	dw_print.show()
	
	END IF
	
	if k_zoom = 100 then
		dw_print.Modify("DataWindow.Print.Preview=no")
	else
		if dw_print.describe("DataWindow.Print.Preview") = "no" then
			dw_print.Modify("DataWindow.Print.Preview=yes")
		end if
	end if

end if

end subroutine

public subroutine zoom_indietro ();//
int k_zoom


if dw_print.visible then 

	// controlla ol fattore Zoom se e' gia al max 
	k_zoom = integer(dw_print.describe("DataWindow.Print.Preview.Zoom"))
	IF k_zoom < 24 THEN
	
		Beep (1)
	
	ELSE
	
		k_zoom = k_zoom - 20
	
		dw_print.modify("DataWindow.Print.Preview.Zoom=" +&
							String (k_zoom))	
	
	
	END IF
	
	
	if k_zoom = 100 then
		dw_print.Modify("DataWindow.Print.Preview=no")
	else
		if dw_print.describe("DataWindow.Print.Preview") = "no" then
			dw_print.Modify("DataWindow.Print.Preview=yes")
		end if
	end if

end if

end subroutine

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
window kwindow



choose case left(k_par_in, 2) 

//	case "ag"		//richiesta aggiorna la stampa (retrieve)
//		estrae_dati()
//		leggi_liste()	

	case kkg_flag_modalita_stampa		//fuoco sui parametri di stampa
//--- chiudo solo se nascosta
		kwindow = kuf1_data_base.prendi_win_uguale("w_stampe")
		if dw_print.visible then
			kwindow.triggerevent ("u_ripri_size_win")
		else
			cb_stampa.triggerevent("clicked")
		end if
		
	case kkg_flag_richiesta_esci		//richiesta chiusura finestra
		cb_ritorna.triggerevent("clicked")
////=== Mostra Finestra maximizzata
//		send(handle(this), 274, 61728, 0)
//
//		inizializza()

//	case "vi"		//richiesta anteprima
//		if w_stampe_1.dw_print.tag = "anteprima" then
//			cb_ritorna.triggerevent("clicked")
//		else
//			cb_video.triggerevent("clicked")
//		end if

	case "za"		//
		zoom_avanti()

	case "zi"		//
		zoom_indietro()

	case kkg_flag_richiesta_libero1		//fuoco sui parametri di stampa
		kwindow = kuf1_data_base.prendi_win_uguale("w_stampe")
		if dw_print.visible then
			kwindow.triggerevent ("u_ripri_size_win")
		else
			cb_anteprima.triggerevent("clicked")
		end if

	case kkg_flag_richiesta_libero2		//mostra / nascondi colonna
		mostra_nascondi_colonne()

	case kkg_flag_richiesta_libero3		
		
	case else
		super::smista_funz(k_par_in)
		
end choose





end subroutine

protected subroutine mostra_nascondi_colonne ();//
long k_id_stampa
string k_path="",k_nome_file
pointer koldpointer  // Declares a pointer variable
//kuf_stampe kuf1_stampe


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)

	dw_personalizza.reset()

//	kuf1_stampe = create kuf_stampe
	
	kufi_stampe.personalizza_dw_print (dw_print, dw_personalizza)
	
//	destroy kuf1_stampe

	dw_personalizza.enabled = true
	dw_personalizza.visible = true
	dw_personalizza.BringToTop = TRUE
	dw_personalizza.setfocus()
	
	dw_personalizza.Resize(dw_print.width*0.35, dw_print.Height*0.70)
	dw_personalizza.x = ((dw_print.width - dw_personalizza.width)*0.50)
	dw_personalizza.y = ((dw_print.Height - dw_personalizza.Height)*0.50)
	
	SetPointer(koldpointer)




end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//cb_ritorna.visible = false
cb_ritorna.enabled = true


if dw_print.visible then
	cb_imposta.visible = false
	cb_anteprima.visible = false
	cb_stampa.visible = false
	cb_excel.visible = false
	cb_ritorna.visible = false
else
	
	cb_imposta.visible = true
	//cb_personalizza.visible = true
	cb_stampa.visible = true
	cb_anteprima.visible = true
	cb_excel.visible = true
	cb_ritorna.visible = true

	
	//=== Nr righe ne DW lista
	if dw_print.rowcount ( ) > 0 then
		cb_imposta.enabled = true
	//	cb_personalizza.enabled = true
		cb_stampa.enabled = true
		cb_anteprima.enabled = true
		cb_excel.enabled = true
	else
		cb_imposta.enabled = false
	//	cb_personalizza.enabled = false
		cb_stampa.enabled = false
		cb_anteprima.enabled = false
		cb_excel.enabled = false
	end if

end if

attiva_menu()

//super::g_setta_win_titolo()


end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//
//--- per evitare un errore strano di null object al ritorno dal dettaglio
	kG_menu.m_finestra.m_gestione.enable()
	kG_menu.m_finestra.m_gestione.show()
	kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = false
	kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = false
	kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = false
	kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = false
	kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = false
	kG_menu.m_finestra.m_fin_stampa.enabled = cb_stampa.enabled

	kG_menu.m_finestra.m_trova.enabled = false
	kG_menu.m_finestra.m_trova.m_fin_cerca.enabled = false
	kG_menu.m_finestra.m_trova.m_fin_cercaancora.enabled = false
	kG_menu.m_finestra.m_trova.m_fin_filtra.enabled = false
	kG_menu.m_finestra.m_aggiornalista.enabled = false
	kG_menu.m_finestra.m_riordinalista.enabled = false
	
//
	if dw_print.visible then
		kG_menu.m_strumenti.m_fin_gest_libero1.text = "Ritorna a 'esegui stampa'"
		kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
										  "Torna al pannello di esecuzione della stampa"
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Chiudi,"+&
	                               kG_menu.m_strumenti.m_fin_gest_libero1.text
	else
		kG_menu.m_strumenti.m_fin_gest_libero1.text = "Anteprima di stampa"
		kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
         							  "Mostra la stampa a Video"
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Anteprima,"+&
	                               kG_menu.m_strumenti.m_fin_gest_libero1.text
	end if
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

//
	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi colonne della stampa"
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
   "Mostra o nascondi una colonna dal lay-out della stampa"
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = dw_print.visible
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Nascondi,"+&
	                               kG_menu.m_strumenti.m_fin_gest_libero2.text
//	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

//
	
	if ki_st_open_w.flag_primo_giro = 'S' then 
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "Report5!"
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "CreateTable5!" //ki_path_risorse + "\barcodeF.bmp"
	end if
	
	kG_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
		

end subroutine

protected subroutine inizializza_0 ();//
string k_rcx, k_titolo
st_profilestring_ini kst_profilestring_ini
pointer k_oldpointer
//kuf_stampe kuf1_stampe


//=== Puntatore Cursore da attesa.....
	k_oldpointer = SetPointer(HourGlass!)

//	kuf1_stampe = create kuf_stampe
	
//--- copio la dw di stampa
	kufi_stampe.kist_stampe = kist_stampe 
	k_rcx = kufi_stampe.smista_stampe(dw_print)

//--- setto la stampante di default
	if len(trim(kist_stampe.stampante_predefinita)) > 0 then
		PrintSetPrinter (kist_stampe.stampante_predefinita)
	end if


	if left(k_rcx, 1) <> "0" then

		SetPointer(k_oldpointer)
		
		messagebox("Stampa ", &
				  "Operazione non eseguita :~n~r" + &
				  mid( k_rcx, 2 ), &
					exclamation!, ok!)
					
		post close(this)
 
	else

//--- salvo la dw per un eventuale ripristino	
		kufi_stampe.kist_stampe = kist_stampe 
		k_rcx = kufi_stampe.smista_stampe(dw_originale)

		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "1"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "stampe" 
		kst_profilestring_ini.nome = "stampe_" + trim(dw_print.dataobject) + "_orientation"
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "0"
		end if
//--- Orientamento della stampa
//		if dw_print.Object.DataWindow.Print.orientation = "1" then
		if kst_profilestring_ini.valore = "1" then
			cbx_landscape.checked = true
		else
			cbx_landscape.checked = false
		end if
		cbx_landscape.triggerevent (clicked!)

//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "N"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "personalizzate" 
		kst_profilestring_ini.nome = trim(dw_print.dataobject) 
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "N"
		end if
		if kst_profilestring_ini.valore = "S" then
			cbx_personalizzazioni.checked = true
//--- lancia l'evento per applicare le personalizzazioni 
			cbx_personalizzazioni.triggerevent (clicked!)
		else
			cbx_personalizzazioni.checked = false
		end if

//--- recupero i valori se personalizzati della window
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "S"
		kst_profilestring_ini.file = "stampe" 
		kst_profilestring_ini.titolo = "personalizzate_salva" 
		kst_profilestring_ini.nome = trim(dw_print.dataobject) 
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
		if kst_profilestring_ini.esito <> "0" then
			kst_profilestring_ini.valore = "N"
		end if
		if kst_profilestring_ini.valore = "S" then
			cbx_personalizzazioni_salva.checked = true
		else
			cbx_personalizzazioni_salva.checked = false
		end if
		
//--- possibilita di range di pagine
		if kist_stampe.scegli_pagina = "S" then
			em_nro.enabled = true	
			gb_pagine.visible = true
			em_nro.visible = true
			rb_1.visible = true
			rb_2.visible = true
			st_6.visible = true
			cbx_personalizzazioni.visible = true
			cbx_personalizzazioni_salva.visible = true
			cbx_landscape.visible = true
			st_em_zoom.visible = true
			st1_em_zoom.visible = true
			em_zoom.visible = true
		end if
		
		attiva_tasti()
//		cb_video.setfocus()

		
	end if	

//	destroy kuf1_stampe

	SetPointer(k_oldpointer)


end subroutine

private subroutine aggiungi_testata ();//
//kuf_stampe kuf1_stampe
pointer koldpointer


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)
	
//	kuf1_stampe = create kuf_stampe
	
//--- aggiunge testata standard solo al tabulato di tipo GRID
	if dw_print.Object.DataWindow.Processing = "1" or dw_print.Object.DataWindow.Processing = "8" or dw_print.Object.DataWindow.Processing = "9" then
		kufi_stampe.kist_stampe_add_testata = kist_stampe	
		kufi_stampe.kist_stampe_add_testata.dw_print = dw_print	
		kufi_stampe.dw_print_add_testata()
		dw_print = kufi_stampe.kist_stampe_add_testata.dw_print 	
	end if

//	destroy kuf1_stampe
	
	SetPointer(koldpointer)	

end subroutine

private subroutine crea_report ();//
string k_rcx
//kuf_stampe kuf1_stampe
pointer koldpointer


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)
	
//	kuf1_stampe = create kuf_stampe
	
////--- Applico le impostazioni personalizzate nella dw di stampa da .ini	
//	if cbx_personalizzazioni.checked then 
//		kuf1_stampe.kist_stampe_orig.dw_print = dw_originale
//		kuf1_stampe.kist_stampe_restore.dw_print = dw_print
//		kuf1_stampe.u_dw_personalizza_restore ()
//	else
////--- ripristino la dw originale di stampa
//		kuf1_stampe.kist_stampe.dw_print = dw_originale 
//		k_rcx = kuf1_stampe.smista_stampe(dw_print)
//	end if

//
	if cbx_landscape.checked then
	   dw_print.Object.DataWindow.Print.orientation = '1' 
	else
	   dw_print.Object.DataWindow.Print.orientation = '2' 
	end if

//--- Griglia: 1=assente, 0=visibile	
	dw_print.Object.DataWindow.Grid.Lines = '0'

//--- Resize delle righe
	dw_print.Object.DataWindow.Row.Resize='1'


	aggiungi_testata()


//	destroy kuf1_stampe
	
	SetPointer(koldpointer)	

end subroutine

public function string get_filename ();//
//---- torna nome file della stampa
//
string k_return=" "



if isnull(k_return) then k_return = trim(kuf1_data_base.prendi_x_utente()) + "_" + string(kuf1_data_base.prendi_x_datins())

return k_return
end function

event open;call super::open;//
pointer k_oldpointer  // Declares a pointer variable


	kufi_stampe = create kuf_stampe

	kist_stampe = ki_st_open_w.key12_any

//=== Puntatore Cursore da attesa.....
	k_oldpointer = SetPointer(HourGlass!)

//=== Posiziona window all'interno della MDI
	this.triggerevent ("u_ripri_size_win")
	
	if ki_utente_abilitato then
		
		inizializza_0()
		
		post inizializza()
		
	end if

	SetPointer(k_oldpointer)



end event

event rbuttondown;call super::rbuttondown;////
//string k_stringa=""
//long k_riga=0
//string k_tag_old=""
//string k_tag=""
//m_popup m_menu
//
//
//	attiva_tasti()
//
//
////=== Salvo il Tag attuale per reimpostarlo a fine routine
//		k_tag_old = this.tag
//
////=== Creo menu Popup 
//		m_menu = create m_popup
//
//		m_menu.m_agglista.visible = false
//		m_menu.m_t_agglista.visible = false
//		m_menu.m_inserisci.visible = false
//		m_menu.m_inserisci.enabled = false
//		m_menu.m_modifica.visible = false
//		m_menu.m_t_modifica.visible = false
//		m_menu.m_cancella.visible = false
//		m_menu.m_cancella.enabled = false
//		m_menu.m_t_cancella.visible = false
//		m_menu.m_conferma.visible = false
//		m_menu.m_conferma.enabled = false
//		m_menu.m_zoom_a.visible = false
//		m_menu.m_t_zoom.visible = false
//		m_menu.m_zoom_i.visible = false
//		m_menu.m_visualizza.visible = false
//		m_menu.m_visualizza.enabled = false
//		m_menu.m_zoom_a.visible = true
//		m_menu.m_t_zoom.visible = true
//		m_menu.m_zoom_i.visible = true
//		m_menu.m_stampa.visible = st_stampa.enabled
//		m_menu.m_t_stampa.visible = st_stampa.enabled
//		m_menu.m_ritorna.visible = st_ritorna.enabled
//		
//		m_menu.m_t_lib_3.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.visible
//		m_menu.m_lib_1.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.visible
//		m_menu.m_lib_1.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.enabled
//		m_menu.m_lib_1.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero1.text
//		m_menu.m_lib_2.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
//		m_menu.m_lib_2.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
//		m_menu.m_lib_2.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero2.text
//		m_menu.m_lib_3.visible = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.visible
//		m_menu.m_lib_3.enabled = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.enabled
//		m_menu.m_lib_3.text = kG_menu.m_finestra.m_gestione.m_fin_gest_libero3.text
//		
//
////=== Attivo il menu Popup
//		m_menu.visible = true
//		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
//		m_menu.visible = false
//
//		destroy m_menu
//
//		k_tag = this.tag 
//
//		this.tag = k_tag_old 
//
//		smista_funz(k_tag)
//
//
end event

on w_stampe.create
int iCurrent
call super::create
this.r_dimensione_win=create r_dimensione_win
this.st_em_zoom=create st_em_zoom
this.st_parametri=create st_parametri
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_6=create st_6
this.dw_print=create dw_print
this.dw_personalizza=create dw_personalizza
this.r_print=create r_print
this.cb_excel=create cb_excel
this.cb_anteprima=create cb_anteprima
this.cb_imposta=create cb_imposta
this.cb_stampa=create cb_stampa
this.em_zoom=create em_zoom
this.cbx_landscape=create cbx_landscape
this.cbx_personalizzazioni=create cbx_personalizzazioni
this.dw_originale=create dw_originale
this.em_nro=create em_nro
this.cbx_personalizzazioni_salva=create cbx_personalizzazioni_salva
this.cb_pdf=create cb_pdf
this.st1_em_zoom=create st1_em_zoom
this.gb_pagine=create gb_pagine
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_dimensione_win
this.Control[iCurrent+2]=this.st_em_zoom
this.Control[iCurrent+3]=this.st_parametri
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.dw_personalizza
this.Control[iCurrent+9]=this.r_print
this.Control[iCurrent+10]=this.cb_excel
this.Control[iCurrent+11]=this.cb_anteprima
this.Control[iCurrent+12]=this.cb_imposta
this.Control[iCurrent+13]=this.cb_stampa
this.Control[iCurrent+14]=this.em_zoom
this.Control[iCurrent+15]=this.cbx_landscape
this.Control[iCurrent+16]=this.cbx_personalizzazioni
this.Control[iCurrent+17]=this.dw_originale
this.Control[iCurrent+18]=this.em_nro
this.Control[iCurrent+19]=this.cbx_personalizzazioni_salva
this.Control[iCurrent+20]=this.cb_pdf
this.Control[iCurrent+21]=this.st1_em_zoom
this.Control[iCurrent+22]=this.gb_pagine
end on

on w_stampe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.r_dimensione_win)
destroy(this.st_em_zoom)
destroy(this.st_parametri)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_6)
destroy(this.dw_print)
destroy(this.dw_personalizza)
destroy(this.r_print)
destroy(this.cb_excel)
destroy(this.cb_anteprima)
destroy(this.cb_imposta)
destroy(this.cb_stampa)
destroy(this.em_zoom)
destroy(this.cbx_landscape)
destroy(this.cbx_personalizzazioni)
destroy(this.dw_originale)
destroy(this.em_nro)
destroy(this.cbx_personalizzazioni_salva)
destroy(this.cb_pdf)
destroy(this.st1_em_zoom)
destroy(this.gb_pagine)
end on

event resize;call super::resize;//
	if dw_print.visible then
		this.r_print.resize(this.width - 50, this.height - 150)
		this.dw_print.resize(this.width - 50, this.height - 120)
	end if
	
	

end event

event closequery;call super::closequery;//
st_profilestring_ini kst_profilestring_ini
//kuf_stampe kufi_stampe
pointer koldpointer


//--- chiudo solo se no in anteprima
if dw_print.visible then
	this.triggerevent ("u_ripri_size_win")
	return 1
else


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)
	
//--- salvo campo personalizzazione 
	kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "personalizzate" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if cbx_personalizzazioni.checked then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kuf1_data_base.profilestring_ini(kst_profilestring_ini)


//--- salva Proprieta' PRINT ORIENTATIONE della dw
	kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "stampe"
	kst_profilestring_ini.nome = "stampe_" + trim(dw_print.dataobject) + "_orientation"
	if cbx_landscape.checked then
		kst_profilestring_ini.valore = "1"
	else
		kst_profilestring_ini.valore = "0"
	end if
	kuf1_data_base.profilestring_ini(kst_profilestring_ini)
	
//--- salvo campo "salva personalizzazioni"
	kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "personalizzate_salva" 
	kst_profilestring_ini.nome = trim(dw_print.dataobject) 
	if cbx_personalizzazioni_salva.checked then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kuf1_data_base.profilestring_ini(kst_profilestring_ini)
	
//--- richiesto x salva personalizzazioni?	
	if cbx_personalizzazioni_salva.checked then
		if ki_personalizzato_dw then
			
			kufi_stampe = create kuf_stampe
			kufi_stampe.personalizza_dw_print_save( dw_personalizza, dw_print, dw_originale )
			destroy kufi_stampe
			
		end if
	end if

	SetPointer(koldpointer)	
	
end if

if isvalid(kufi_stampe) then destroy kufi_stampe


end event

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_stampe
integer x = 1381
integer y = 868
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_stampe
integer x = 654
integer y = 1044
integer width = 366
integer height = 84
string pointer = "HyperLink!"
end type

type st_stampa from w_g_tab`st_stampa within w_stampe
integer x = 1385
integer y = 124
end type

type st_ritorna from w_g_tab`st_ritorna within w_stampe
integer x = 1358
integer y = 212
end type

type r_dimensione_win from rectangle within w_stampe
boolean visible = false
long linecolor = 16777215
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 16777215
integer width = 1554
integer height = 1308
end type

type st_em_zoom from statictext within w_stampe
integer x = 78
integer y = 608
integer width = 622
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Dimensione di stampa:"
boolean focusrectangle = false
end type

type st_parametri from statictext within w_stampe
boolean visible = false
integer x = 1394
integer y = 668
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_stampe
boolean visible = false
integer x = 78
integer y = 96
integer width = 242
integer height = 52
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Tutte"
boolean checked = true
end type

on clicked;em_nro.enabled = false

end on

type rb_1 from radiobutton within w_stampe
boolean visible = false
integer x = 78
integer y = 168
integer width = 320
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 67108864
string text = "Pagine:"
end type

on clicked;//
em_nro.enabled = true 
	
end on

type st_6 from statictext within w_stampe
boolean visible = false
integer x = 768
integer y = 192
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421376
long backcolor = 67108864
boolean enabled = false
string text = "es.: 1,7,10 5-10"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_stampe
event ue_keydwn pbm_dwnkey
event rbuttonup pbm_rbuttonup
event u_lbuttondown pbm_lbuttondown
event u_lbuttonup pbm_lbuttonup
event u_setcursor pbm_setcursor
boolean visible = false
integer x = 18
integer y = 1348
integer width = 393
integer height = 284
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_nulla"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydwn;//
//=== Controllo quale tasto da tastiera ha premuto


if keydown(keyenter!) then

	w_stampe.zoom_avanti()

else
	if keydown(keyescape!) then
		dw_print.visible = false
		w_stampe.cb_stampa.setfocus()

	else
		if keydown(keyPageDown!) and	dw_print.visible = true then
			
			dw_print.scrollnextpage ( )

		else
			if keydown(keyPageUp!) and	dw_print.visible = true then
			
				dw_print.scrollpriorpage ( )
//				dw_print.scrolltorow(dw_print.getrow()-1)
			end if
		end if
	end if

end if


end event

event rbuttonup;//
	parent.triggerevent("rbuttonup")

end event

event u_lbuttondown;//
ki_ridimensiona_colonna = true
ki_ridimensione_x=xpos
ki_ridimensione_y=ypos

end event

event u_lbuttonup;//

if ki_ridimensiona_colonna then

	ki_ridimensiona_colonna = false
	if ki_ridimensione_x <> xpos or ki_ridimensione_y <> ypos then
		ki_personalizzato_dw = true
	end if

end if
end event

event u_setcursor();//
	ki_ridimensiona_colonna = false

end event

event dberror;//
st_esito kst_esito

CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE


kst_esito.esito = "1"
kst_esito.sqlcode = sqlca.sqlcode
kst_esito.sqlerrtext = "Err-text=" + SQLErrText &
								+ ", Query=" + SQLsyntax &
								+ ", Utente=" + kg_utente_codice
kuf1_data_base.errori_scrivi_esito("W", kst_esito) 


RETURN 1 // Do not display system error message

end event

event retrievestart;//
//=== Per evitare che ad ogni nuova Retrieve cancelli la vecchia 
return 2


end event

type dw_personalizza from datawindow within w_stampe
event rbuttonup pbm_dwnrbuttonup
boolean visible = false
integer x = 224
integer y = 1416
integer width = 1586
integer height = 516
integer taborder = 90
boolean bringtotop = true
boolean titlebar = true
string title = "Mostra o Nascondi colonne in stampa"
string dataobject = "d_pers_st_campi"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Exclamation!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttonup;//
	parent.triggerevent("rbuttonup")
//	return 1

end event

event buttonclicked;//
pointer koldpointer
//kuf_stampe kuf1_stampe


//=== Puntatore Cursore da attesa.....
	koldpointer = SetPointer(HourGlass!)

//--- applico personalizzazioni
	ki_personalizzato_dw = true

//	kuf1_stampe = create kuf_stampe

	if String(dwo.name)= "cb_applica" then
		kufi_stampe.personalizza_dw_print_save( dw_personalizza, dw_print, dw_originale )
		kufi_stampe.kist_stampe_orig.dw_print = dw_originale
		kufi_stampe.kist_stampe_restore.dw_print = dw_print
		kufi_stampe.u_dw_personalizza_restore ( )
	else
		kufi_stampe.kist_stampe_orig.dw_print = dw_originale
		kufi_stampe.personalizza_dw_print_ripri( )
		kufi_stampe.kist_stampe_orig.dw_print = dw_originale
		kufi_stampe.kist_stampe_restore.dw_print = dw_print
		kufi_stampe.u_dw_personalizza_restore ( )
	end if


//	destroy kuf1_stampe
	
	this.visible = false

	aggiungi_testata()
//	cbx_personalizzazioni.checked = true
//	cbx_personalizzazioni.triggerevent (clicked!)
//

	SetPointer(koldpointer)	

end event

type r_print from rectangle within w_stampe
boolean visible = false
integer linethickness = 4
long fillcolor = 67108864
integer x = 1417
integer y = 316
integer width = 165
integer height = 144
end type

type cb_excel from commandbutton within w_stampe
integer x = 654
integer y = 796
integer width = 366
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string pointer = "HyperLink!"
string text = "&Esporta..."
end type

event clicked;//
long k_id_stampa
string k_path="",k_nome_file
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//=== Disabilito il tasto x evitare ridondanze
	this.enabled = false

//--- applica o meno le personalizzazioni alla stampa
	crea_report()

//=== Esporto dati DW
//   k_path = trim(profilestring ( "confdb.ini", "ambiente", "arch_export", "stampa"))
//   k_nome_file = trim(mid(parent.title,9,8)) + string(today(), "ddmmyy")
//	trim(kist_stampe.dataobject)

	k_id_stampa = dw_print.saveas("",Excel5!, true)


	if k_id_stampa < 1 then
		SetPointer(oldpointer)
		messagebox("Operazione non eseguita", &
					"Dati non esportati")
	else
		SetPointer(oldpointer)
		messagebox("Operazione terminata", &
					"Dati esportati correttamente")
	end if


//--- Ripristina path di lavoro
	kuf1_data_base.setta_path_default()


	this.enabled = true


end event

type cb_anteprima from commandbutton within w_stampe
integer x = 110
integer y = 1044
integer width = 366
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Anteprima"
end type

event clicked;//
//--- 
//
	this.enabled = false

//--- esegue l'anteprima		
	parent.triggerevent("u_anteprima")
	attiva_tasti()
	
	this.enabled = true
	
end event

type cb_imposta from commandbutton within w_stampe
integer x = 110
integer y = 796
integer width = 366
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "S&tampante..."
end type

event clicked;//
pointer kpointer_1

kpointer_1 = setPointer(HourGlass!)

printsetup()

SetPointer(kpointer_1)

end event

type cb_stampa from commandbutton within w_stampe
integer x = 110
integer y = 920
integer width = 366
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "&Stampa"
end type

event clicked;//
string k_ret, k_zoom_old, k_scelta
long k_id_stampa
int k_rc_print
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//=== Disabilito il tasto x evitare ridondanze
	this.enabled = false

//--- applica o meno le personalizzazioni alla stampa
	crea_report()

	k_ret=dw_print.modify("DataWindow.DocumentName='" + trim(dw_print.title)+"'")	

	if em_nro.enabled = false	then
		k_ret=dw_print.modify("DataWindow.Print.Pageinclude.Range=0")
	else
		k_ret=dw_print.modify("DataWindow.Print.Page.Range='"+ trim(em_nro.text)+"'")	
	end if

//=== Apro buffer di stampa
//	k_id_stampa = printopen(parent.title)

//	if k_id_stampa < 1 then
//		SetPointer(oldpointer)
//		messagebox("Stampa non eseguita", &
//					"Stampa non possibile")
//	else

		k_zoom_old=dw_print.describe("DataWindow.Zoom")			
		dw_print.modify("DataWindow.Zoom=" + trim(em_zoom.text))			


//=== Puntatore Cursore da attesa.....
		SetPointer(HourGlass!)
		
//--- Orientamento dalla stampante (default)	
/////		k_ret=dw_print.modify("DataWindow.Print.Orientation=0")

//		printdatawindow(k_id_stampa, dw_print)
		k_rc_print = dw_print.print()

		dw_print.modify("DataWindow.Zoom="+k_zoom_old)			

		if k_rc_print > 0 then
//      if k_id_stampa > 0 then
//			printclose(k_id_stampa)
//--- chiude la window se tutto ok	
			cb_ritorna.postevent(clicked!)

		end if
		
	
//	end if

	attiva_tasti()

	this.enabled = true


end event

type em_zoom from editmask within w_stampe
integer x = 713
integer y = 608
integer width = 306
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 128
string text = "100"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 2
string minmax = "1~~999"
end type

event modified;//
string k_zoom

	
	k_zoom = trim(em_zoom.text)
	if k_zoom="100" then
		k_zoom="99"
	end if
	dw_print.modify("DataWindow.Print.Preview.Zoom=" + k_zoom)
	
   dw_print.Modify("DataWindow.Print.Preview=yes")

end event

type cbx_landscape from checkbox within w_stampe
boolean visible = false
integer x = 78
integer y = 288
integer width = 997
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 67108864
string text = "Stampa in Orizzontale (landscape)"
boolean checked = true
end type

event clicked;//
	if cbx_landscape.checked then
	   dw_print.Object.DataWindow.Print.orientation = '1' 
	else
	   dw_print.Object.DataWindow.Print.orientation = '2' 
	end if

end event

type cbx_personalizzazioni from checkbox within w_stampe
boolean visible = false
integer x = 78
integer y = 404
integer width = 1051
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 67108864
string text = "Applica le mie personalizzazioni"
boolean checked = true
end type

event clicked;//
string k_rcx, k_rc
kuf_utility kuf1_utility
//kuf_stampe kuf1_stampe


	cbx_personalizzazioni.enabled = false

//	kuf1_stampe = create kuf_stampe

//--- imposta le personalizzazioni
	if cbx_personalizzazioni.checked then

		kufi_stampe.kist_stampe_orig.dw_print = dw_originale
		kufi_stampe.kist_stampe_restore.dw_print = dw_print
		kufi_stampe.u_dw_personalizza_restore ()
//		k_rcx = kufi_stampe.smista_stampe(dw_print)
		
	else

//--- copio la dw di stampa
		kufi_stampe.kist_stampe_restore.dw_print = dw_print
		kufi_stampe.u_dw_personalizza_restore ()
		kufi_stampe.u_dw_personalizza_restore_orig()
//		kufi_stampe.kist_stampe.dw_print = dw_originale 
//		k_rcx = kufi_stampe.smista_stampe(dw_originale)
			
	end if



	aggiungi_testata()


//--- se campo "pagine" non checked allora imposto automaticamente il numero di pagine
//	if not(rb_1.checked) then
//	k_rc = "~~t~~'Pag. ~~' + page() + ~~' di ~~' + pageCount() "									
//	k_rc = dw_print.Modify( &
//                      "create text(band=foreground name=xestemporaneox alignment='1' text='" + k_rc + "'~~'Pag. ~~' + page() + ~~' di ~~' + ) " )
//		if dw_print.rowCount() > 0 then
//			em_nro.text = "1-" + trim(dw_print.Describe("xestemporaneox.text") )
//		else
//			if dw_print.rowCount() > 0 then
//				em_nro.text = "1"
//			end if
//		end if
//		dw_print.modify("destroy xestemporaneox")		
//		em_nro.BringToTop = TRUE
//	end if

//	destroy kuf1_stampe

	cbx_personalizzazioni.enabled = true

end event

type dw_originale from datawindow within w_stampe
boolean visible = false
integer x = 448
integer y = 1672
integer width = 439
integer height = 284
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
string title = "DW pasata originalmente senza Personalizzazioni"
string dataobject = "d_nulla"
string icon = "Exclamation!"
end type

type em_nro from editmask within w_stampe
boolean visible = false
integer x = 398
integer y = 160
integer width = 352
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 16777215
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXXXXXXXXXX"
end type

event modified;//--- inserito testo?
if len(trim(This.Text)) > 0 then
	rb_1.checked = true
	rb_2.checked = false
else
	rb_1.checked = false
	rb_2.checked = true
end if


end event

type cbx_personalizzazioni_salva from checkbox within w_stampe
boolean visible = false
integer x = 78
integer y = 480
integer width = 1083
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 67108864
string text = "Ricorda le personalizzazioni all~'uscita"
boolean checked = true
end type

event clicked;////
//string k_rcx, k_rc
//kuf_utility kuf1_utility
//kuf_stampe kuf1_stampe
//
//
//	cbx_personalizzazioni.enabled = false
//
//	kuf1_stampe = create kuf_stampe
//
//	if cbx_personalizzazioni.checked then
//
//		ki_gia_personalizzata = true
//
//		kuf1_stampe.kist_stampe_orig.dw_print = dw_originale
//		kuf1_stampe.kist_stampe_restore.dw_print = dw_print
//		kuf1_stampe.u_dw_personalizza_restore ()
//		
//	else
////		if ki_gia_personalizzata then
//
////--- copio la dw di stampa
//			kuf1_stampe.kist_stampe.dw_print = dw_originale 
//			k_rcx = kuf1_stampe.smista_stampe(dw_print)
//			
////		end if
//	end if
//
//	aggiungi_testata()
//
////--- se campo "pagine" non checked allora imposto automaticamente il numero di pagine
////	if not(rb_1.checked) then
////	k_rc = "~~t~~'Pag. ~~' + page() + ~~' di ~~' + pageCount() "									
////	k_rc = dw_print.Modify( &
////                      "create text(band=foreground name=xestemporaneox alignment='1' text='" + k_rc + "'~~'Pag. ~~' + page() + ~~' di ~~' + ) " )
////		if dw_print.rowCount() > 0 then
////			em_nro.text = "1-" + trim(dw_print.Describe("xestemporaneox.text") )
////		else
////			if dw_print.rowCount() > 0 then
////				em_nro.text = "1"
////			end if
////		end if
////		dw_print.modify("destroy xestemporaneox")		
////		em_nro.BringToTop = TRUE
////	end if
//
//	destroy kuf1_stampe
//
//	cbx_personalizzazioni.enabled = true
//
end event

type cb_pdf from commandbutton within w_stampe
boolean visible = false
integer x = 654
integer y = 920
integer width = 366
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string pointer = "HyperLink!"
string text = "&PDF"
end type

event clicked;//
long k_id_stampa
string k_path="",k_nome_file
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//=== Disabilito il tasto x evitare ridondanze
	this.enabled = false

//--- applica o meno le personalizzazioni alla stampa
	crea_report()

//=== Esporto dati DW
//   k_path = trim(profilestring ( "confdb.ini", "ambiente", "arch_export", "stampa"))
//   k_nome_file = trim(mid(parent.title,9,8)) + string(today(), "ddmmyy")
//	trim(kist_stampe.dataobject)

	dw_print.object.datawindow.printer = "perseoPDF"
	k_id_stampa = dw_print.saveas("",PDF!, false)  //get_filename()


	if k_id_stampa < 1 then
		SetPointer(oldpointer)
		messagebox("Operazione non eseguita", "PDF non generato")
	else
		SetPointer(oldpointer)
		messagebox("Operazione terminata", &
					"Dati esportati correttamente")
	end if


//--- Ripristina path di lavoro
	kuf1_data_base.setta_path_default()


	this.enabled = true


end event

type st1_em_zoom from statictext within w_stampe
integer x = 1042
integer y = 612
integer width = 69
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "%"
boolean focusrectangle = false
end type

type gb_pagine from groupbox within w_stampe
boolean visible = false
integer x = 37
integer width = 1335
integer height = 728
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pagine in Stampa"
borderstyle borderstyle = stylebox!
end type

