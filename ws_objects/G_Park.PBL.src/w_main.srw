$PBExportHeader$w_main.srw
$PBExportComments$windows principale di apertura
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
type st_11 from statictext within w_main
end type
type st_10 from statictext within w_main
end type
type st_9 from statictext within w_main
end type
type st_8 from statictext within w_main
end type
type st_7 from statictext within w_main
end type
type st_6 from statictext within w_main
end type
type st_5 from statictext within w_main
end type
type st_4 from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type ln_1 from line within w_main
end type
type ln_2 from line within w_main
end type
type ln_3 from line within w_main
end type
type ln_4 from line within w_main
end type
type ln_5 from line within w_main
end type
type ln_6 from line within w_main
end type
type ln_7 from line within w_main
end type
type ln_8 from line within w_main
end type
type ln_9 from line within w_main
end type
end forward

global type w_main from window
integer width = 3365
integer height = 2308
string menuname = "m_main"
boolean border = false
windowtype windowtype = mdi!
long backcolor = 134217729
string icon = "C:\GAMMARAD\PB_GMMRD\ICONE\MAIN.ICO"
boolean clientedge = true
mdi_1 mdi_1
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
ln_8 ln_8
ln_9 ln_9
end type
global w_main w_main

type variables
//--- Flag primo GIRO
int ki_flag_primo_giro = 0


end variables

forward prototypes
private subroutine smista_funz (string k_par_in)
private subroutine open_win_iniziale ()
private subroutine apri_win_iniziale ()
end prototypes

private subroutine smista_funz (string k_par_in);////===
////=== Smista le chiamate esterne alla window a seconda delle funzionalita'
////=== richieste
////=== Usata per esempio dal menu popup
////=== Par. input : k_par_in stringa
////=== Ritorna ...: 0=tutto OK; 1=Errore
////===
//
//choose case left(k_par_in, 2) 
//
//
//	case "l1"		//richiesta Propieta' procedura
//		w_main.open_w_skede("az0"+space(10))
//
//
//	case "l3"		//richiesta uscita
//		close(this)
//
//
//end choose
//
//
end subroutine

private subroutine open_win_iniziale ();
end subroutine

private subroutine apri_win_iniziale ();//
string k_window = ""
st_open_w k_st_open_w
kuf_base kuf1_base
kuf_menu_window kuf1_menu_window


	kuf1_base = create kuf_base
	
	k_window = trim(kuf1_base.prendi_dato_base("finestra_inizio"))
	if left(k_window, 1) <> "1" and mid(k_window, 2) <> "nullo" then

		k_window = mid(k_window, 2)
		
		destroy kuf1_base
		
		if len((k_window)) > 0 then 
	
	//
	//=== Parametri : 
	//=== struttura st_open_w
	//=== dati particolare programma
	//
	//=== Si potrebbero passare:
	//=== key1=codice cli; key2=cod sl-pt
	
			K_st_open_w.id_programma = trim(k_window)
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_modalita = "  "
			K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
			K_st_open_w.flag_leggi_dw = "N"
			K_st_open_w.flag_cerca_in_lista = "1"
			K_st_open_w.key1 = " "
			K_st_open_w.key2 = " "
			K_st_open_w.key3 = " "
			K_st_open_w.key4 = " "
			K_st_open_w.flag_where = " "
			
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(k_st_open_w)
			destroy kuf1_menu_window
									
		end if
		
	end if

end subroutine

event closequery;//
string k_titolo
kuf_base kuf1_base
kuf_utility kuf1_utility


//window wSheet
//string k_wName = ""
//
//
////=== Prelevo l'ultima finestra aperta
//wSheet = this.GetFirstSheet( )
//if isvalid(wsheet) then
//	k_wName = wsheet.ClassName( )
////	k_wName = wsheet.tag
//end if
//do while isvalid(wsheet) 
//	wSheet = this.GetnextSheet(wsheet)
//	if isvalid(wsheet) then
//		k_wName = wsheet.ClassName( )
////		k_wName = wsheet.tag
//	end if
//loop
kuf1_base = create kuf_base
//
//if isnull(k_wname) = false then
//	kuf1_base.metti_dato_base(0, "finestra_inizio", k_wname) //imposto la finestra da richiamare
//end if
//
k_titolo = mid(kuf1_base.prendi_dato_base("titolo"), 2) //prendo il titolo della procedura
//
destroy kuf1_base
//
//=== Vedo se ci sono finestre aperte
if isvalid(this.GetFirstSheet( )) then
	if messagebox(trim(k_titolo), "Sei sicuro di voler uscire dalla procedura ?",&
					question!, yesno!, 1) = 2 then
		return 1
	else
		
	end if
end if


//--- ripristino le caratteristiche delle toolbar
kuf1_utility = create kuf_utility
kuf1_utility.u_windows_size_save(this)
kuf1_utility.u_toolbar_Save(this)
destroy kuf1_utility



end event

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_8=create ln_8
this.ln_9=create ln_9
this.Control[]={this.mdi_1,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_7,&
this.ln_8,&
this.ln_9}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_8)
destroy(this.ln_9)
end on

event open;//
string k_titolo, k_update_last_vers, k_last_version_x
double k_last_version
int k_ctr
st_profilestring_ini kst_profilestring_ini
kuf_base kuf1_base
kuf_utility kuf1_utility
kuf_menu_window kuf1_menu_window
pointer oldpointer  // Declares a pointer variable



//--- disattivo la toolbar
//this.SetToolbar(1, false)

//
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
//=== Se volessi riprist. il vecchio puntatore : SetPointer(oldpointer)



	kuf1_base = create kuf_base
	k_titolo = mid(kuf1_base.prendi_dato_base("titolo"), 2) //prendo il titolo della procedura
	k_titolo = k_titolo + " " + mid(kuf1_base.prendi_dato_base("utente"), 2) //prendo UTENTE
	k_update_last_vers = mid(kuf1_base.prendi_dato_base("update_last_vers"), 2) 
	k_last_version_x = trim(mid(kuf1_base.prendi_dato_base("last_version"), 2))
	if isnull(k_last_version) then
		k_last_version = 0.0
	else
		k_last_version	= double(k_last_version_x)
	end if
	destroy kuf1_base
	this.title = trim(k_titolo) + " "

//--- Popola Tabella dei menu	
	kG_menu = this.menuid
	kuf1_menu_window = create kuf_menu_window
	k_ctr=kuf1_menu_window.select_all(kstG_tab_menu_window[])
	kuf1_menu_window.autorizza_menu( kG_menu ) 
	destroy kuf1_menu_window
	
//--- se devo aggiornare i programmi chiamo l'utility x la copia
	if k_update_last_vers = "S" and double(kk_versione) < k_last_version then
	
		if messagebox ("Aggiornamento Automatico della Procedura", &
							"La Procedura deve essere aggiornata alla versione "&
							+ trim(k_last_version_x) + ".~n~r Eseguire ora?", &
							 question!, YesNo!, 1) = 1 then
		
			kuf1_utility = create kuf_utility			 
			kuf1_utility.u_aggiorna_procedura()			
			destroy kuf1_utility
		end if
	else
	
	//--- Apre la prima windows
		post apri_win_iniziale ()
	
	end if


end event

event activate;//
window k_window 
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility
st_window_size kst_window_size


// se primo giro...
if ki_flag_primo_giro = 0 then

	ki_flag_primo_giro = 1
	
	kG_menu = this.menuid
	
	kuf1_menu_window = create kuf_menu_window
	kuf1_menu_window.autorizza_menu( kG_menu ) 
	destroy kuf1_menu_window
	
	
//--- ripristino le caratteristiche delle toolbar
	kuf1_utility = create kuf_utility
	kst_window_size=kuf1_utility.u_windows_size_restore(this)
	kuf1_utility.u_toolbar_Restore(this)
	destroy kuf1_utility

//=== Posiziona window all'interno MDI 
	this.x = kst_window_size.x
	this.y = kst_window_size.y
	if lower(kst_window_size.WindowState) = "normal!" &
		or lower(kst_window_size.WindowState) = "minimized!" then
		this.width = kst_window_size.w
		this.height = kst_window_size.h
	else
		this.WindowState = Maximized!
	end if
	
	this.show()
	
else
	//--- attivo la toolbar se nessuna finestra aperta
	k_window = kuf1_data_base.prendi_win_la_prima()
	if isnull(k_window) then
//		if kG_menu.m_finestra.m_fin_toolbar.checked = true then
			w_main.SetToolbar(1, true)
//		end if
		this.show()
	end if
end if





end event

event deactivate;////
//kuf_utility kuf1_utility
//
////--- ripristino le caratteristiche delle toolbar
//kuf1_utility = create kuf_utility
////kuf1_utility.u_windows_size_save(this)
//kuf1_utility.u_toolbar_Save(this)
//destroy kuf1_utility
//
end event

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

type st_11 from statictext within w_main
integer x = 475
integer y = 928
integer width = 1061
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F2 = Visualizza"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_main
integer x = 475
integer y = 768
integer width = 1061
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "Ctrl+F2 = Modifica"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_9 from statictext within w_main
integer x = 475
integer y = 608
integer width = 1061
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F4 = Nuovo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_main
integer x = 475
integer y = 1088
integer width = 1061
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F6 = Elimina"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_main
integer x = 1499
integer y = 1376
integer width = 658
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F3 = Cerca"
boolean focusrectangle = false
end type

type st_6 from statictext within w_main
integer x = 1024
integer y = 1536
integer width = 1646
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "Ctrl+F3 = Cerca successivo"
boolean focusrectangle = false
end type

type st_5 from statictext within w_main
integer x = 2121
integer y = 1088
integer width = 805
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F9 = Stampa"
boolean focusrectangle = false
end type

type st_4 from statictext within w_main
integer x = 2121
integer y = 608
integer width = 951
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F10 = Conferma"
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 2121
integer y = 928
integer width = 1097
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "F11 = Agg.Elenco"
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 2121
integer y = 768
integer width = 914
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217741
long backcolor = 134217729
string text = "Ctrl+F10 = Esci"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 1243
integer y = 416
integer width = 1225
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 134217741
long backcolor = 134217729
string text = "Ricorda i tasti di scelta rapida"
boolean focusrectangle = false
end type

type ln_1 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 1646
integer beginy = 576
integer endx = 1646
integer endy = 1088
end type

type ln_2 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 1792
integer beginy = 832
integer endx = 1792
integer endy = 1280
end type

type ln_3 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 1975
integer beginy = 1024
integer endx = 1975
integer endy = 1440
end type

type ln_4 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 2158
integer beginy = 1152
integer endx = 2158
integer endy = 1504
end type

type ln_5 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 2377
integer beginy = 1376
integer endx = 2377
integer endy = 1696
end type

type ln_6 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 402
integer beginy = 1856
integer endx = 1499
integer endy = 480
end type

type ln_7 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 549
integer beginy = 1856
integer endx = 2487
integer endy = 416
end type

type ln_8 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 585
integer beginy = 1920
integer endx = 3255
integer endy = 544
end type

type ln_9 from line within w_main
long linecolor = 65535
integer linethickness = 4
integer beginx = 585
integer beginy = 2016
integer endx = 3474
integer endy = 1120
end type

