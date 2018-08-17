$PBExportHeader$w_errori.srw
forward
global type w_errori from window
end type
type cb_1 from commandbutton within w_errori
end type
type mle_errori from multilineedit within w_errori
end type
end forward

global type w_errori from window
integer x = 649
integer y = 276
integer width = 1614
integer height = 1164
boolean titlebar = true
string title = "Messaggi Procedura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 255
cb_1 cb_1
mle_errori mle_errori
end type
global w_errori w_errori

on w_errori.create
this.cb_1=create cb_1
this.mle_errori=create mle_errori
this.Control[]={this.cb_1,&
this.mle_errori}
end on

on w_errori.destroy
destroy(this.cb_1)
destroy(this.mle_errori)
end on

event open;//
mle_errori.text = message.stringparm
end event

type cb_1 from commandbutton within w_errori
integer x = 576
integer y = 920
integer width = 315
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ritorna"
end type

event clicked;//
close(parent)
end event

type mle_errori from multilineedit within w_errori
integer x = 5
integer y = 4
integer width = 1577
integer height = 888
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

