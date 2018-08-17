$PBExportHeader$w_stampe_11.srw
forward
global type w_stampe_11 from w_g_tab
end type
type dw_print from datawindow within w_stampe_11
end type
type dw_personalizza from datawindow within w_stampe_11
end type
end forward

global type w_stampe_11 from w_g_tab
string title = ""
dw_print dw_print
dw_personalizza dw_personalizza
end type
global w_stampe_11 w_stampe_11

type variables
w_stampe kiwindow_stampe
end variables

forward prototypes
protected subroutine inizializza ()
end prototypes

protected subroutine inizializza ();//

	this.resize(kiwindow_stampe.width, kiwindow_stampe.height)
	this.x= kiwindow_stampe.x
	this.y= kiwindow_stampe.y

	this.visible = false

end subroutine

on w_stampe_11.create
int iCurrent
call super::create
this.dw_print=create dw_print
this.dw_personalizza=create dw_personalizza
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_print
this.Control[iCurrent+2]=this.dw_personalizza
end on

on w_stampe_11.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_print)
destroy(this.dw_personalizza)
end on

event open;call super::open;//

	dw_print.settransobject ( sqlca )
	dw_personalizza.settransobject ( sqlca )

	
	kiwindow_stampe=kuf1_data_base.prendi_win_uguale("w_stampe")

	this.visible = false
	
	
	post inizializza()
end event

event ue_menu;//
kiwindow_stampe.tag = this.tag
kiwindow_stampe.triggerevent("ue_menu")

end event

event resize;call super::resize;//
	if this.visible then
		this.dw_print.resize(this.width - 50, this.height - 150)
	end if
	
	
	

end event

event close;call super::close;//
close(kiwindow_stampe)

end event

event rbuttondown;call super::rbuttondown;//
	kiwindow_stampe.tag = this.tag
	kiwindow_stampe.triggerevent(rbuttondown!)

end event

event closequery;call super::closequery;//
//--- chiudo solo se nascosta
if this.visible then
	this.visible = false
	return 1
end if
end event

event activate;//
end event

event deactivate;//

end event

type st_stampa from w_g_tab`st_stampa within w_stampe_11
integer x = 1138
integer y = 1192
end type

type st_ritorna from w_g_tab`st_ritorna within w_stampe_11
integer x = 709
integer y = 1136
end type

type dw_print from datawindow within w_stampe_11
event ue_keydwn pbm_dwnkey
boolean visible = false
integer x = 14
integer y = 8
integer width = 832
integer height = 860
integer taborder = 10
string dataobject = "d_nulla"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
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

event rbuttondown;//
	parent.triggerevent(rbuttondown!)

end event

event retrievestart;//
//=== Per evitare che ad ogni nuova Retrieve cancelli la vecchia 
return 2


end event

event dberror;//
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

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

type dw_personalizza from datawindow within w_stampe_11
boolean visible = false
integer x = 210
integer y = 132
integer width = 1509
integer height = 924
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Personalizza colonne in stampa"
string dataobject = "d_pers_st_campi"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Exclamation!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;//
	parent.triggerevent(rbuttondown!)

end event

event buttonclicked;//
kuf_stampe kuf1_stampe


kuf1_stampe = create kuf_stampe
kuf1_stampe.personalizza_dw_print_save( dw_personalizza, dw_print )
destroy kuf1_stampe
this.visible = false



end event

