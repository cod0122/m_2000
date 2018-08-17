$PBExportHeader$wr_n_copie.srw
forward
global type wr_n_copie from window
end type
type cb_1 from commandbutton within wr_n_copie
end type
type em_n_copie from editmask within wr_n_copie
end type
end forward

global type wr_n_copie from window
integer x = 832
integer y = 360
integer width = 686
integer height = 320
boolean titlebar = true
string title = "Numero Copie"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
cb_1 cb_1
em_n_copie em_n_copie
end type
global wr_n_copie wr_n_copie

on wr_n_copie.create
this.cb_1=create cb_1
this.em_n_copie=create em_n_copie
this.Control[]={this.cb_1,&
this.em_n_copie}
end on

on wr_n_copie.destroy
destroy(this.cb_1)
destroy(this.em_n_copie)
end on

event close;//
message.stringparm = trim(em_n_copie.text)
end event

type cb_1 from commandbutton within wr_n_copie
integer x = 416
integer y = 68
integer width = 183
integer height = 92
integer taborder = 2
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "&Ok"
boolean default = true
end type

event clicked;//
close (parent)
end event

type em_n_copie from editmask within wr_n_copie
integer x = 91
integer y = 64
integer width = 242
integer height = 100
integer taborder = 1
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 16777215
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
string displaydata = "~r"
double increment = 1
string minmax = "1~~999"
end type

