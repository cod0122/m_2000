$PBExportHeader$uo_tab_1.sru
forward
global type uo_tab_1 from userobject
end type
type tab_1 from tab within uo_tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_d_std_1 within tabpage_1
end type
type st_1_retrieve from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
st_1_retrieve st_1_retrieve
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_d_std_1 within tabpage_2
end type
type st_2_retrieve from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
st_2_retrieve st_2_retrieve
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from uo_d_std_1 within tabpage_3
end type
type st_3_retrieve from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
st_3_retrieve st_3_retrieve
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from uo_d_std_1 within tabpage_4
end type
type st_4_retrieve from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
st_4_retrieve st_4_retrieve
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from uo_d_std_1 within tabpage_5
end type
type st_5_retrieve from statictext within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
st_5_retrieve st_5_retrieve
end type
type tabpage_6 from userobject within tab_1
end type
type st_6_retrieve from statictext within tabpage_6
end type
type dw_6 from uo_d_std_1 within tabpage_6
end type
type tabpage_6 from userobject within tab_1
st_6_retrieve st_6_retrieve
dw_6 dw_6
end type
type tabpage_7 from userobject within tab_1
end type
type st_7_retrieve from statictext within tabpage_7
end type
type dw_7 from uo_d_std_1 within tabpage_7
end type
type tabpage_7 from userobject within tab_1
st_7_retrieve st_7_retrieve
dw_7 dw_7
end type
type tabpage_8 from userobject within tab_1
end type
type st_8_retrieve from statictext within tabpage_8
end type
type dw_8 from uo_d_std_1 within tabpage_8
end type
type tabpage_8 from userobject within tab_1
st_8_retrieve st_8_retrieve
dw_8 dw_8
end type
type tabpage_9 from userobject within tab_1
end type
type st_9_retrieve from statictext within tabpage_9
end type
type dw_9 from uo_d_std_1 within tabpage_9
end type
type tabpage_9 from userobject within tab_1
st_9_retrieve st_9_retrieve
dw_9 dw_9
end type
type tab_1 from tab within uo_tab_1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
end forward

global type uo_tab_1 from userobject
integer width = 2734
integer height = 864
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_1 tab_1
end type
global uo_tab_1 uo_tab_1

on uo_tab_1.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on uo_tab_1.destroy
destroy(this.tab_1)
end on

type tab_1 from tab within uo_tab_1
integer x = 46
integer y = 44
integer width = 2304
integer height = 1056
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2267
integer height = 932
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
st_1_retrieve st_1_retrieve
end type

event rbuttonup;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

event rbuttondown;//
//parent.triggerevent("ue_rbuttondown")
end event

on tabpage_1.create
this.dw_1=create dw_1
this.st_1_retrieve=create st_1_retrieve
this.Control[]={this.dw_1,&
this.st_1_retrieve}
end on

on tabpage_1.destroy
destroy(this.dw_1)
destroy(this.st_1_retrieve)
end on

type dw_1 from uo_d_std_1 within tabpage_1
integer x = 37
integer y = 40
integer width = 1010
integer height = 880
integer taborder = 20
boolean enabled = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemfocuschanged;call super::itemfocuschanged;//
//post attiva_tasti()
end event

event rowfocuschanged;call super::rowfocuschanged;//
//211207attiva_tasti()
end event

event itemchanged;call super::itemchanged;
// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//post attiva_tasti()

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	//ki_syntaxquery = sqlsyntax

end event

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)

end event

type st_1_retrieve from statictext within tabpage_1
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
event rbuttonup ( )
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_2 dw_2
st_2_retrieve st_2_retrieve
end type

event rbuttonup();//
//parent.triggerevent("ue_rbuttonup")
end event

event rbuttondown;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

on tabpage_2.create
this.dw_2=create dw_2
this.st_2_retrieve=create st_2_retrieve
this.Control[]={this.dw_2,&
this.st_2_retrieve}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.st_2_retrieve)
end on

type dw_2 from uo_d_std_1 within tabpage_2
integer x = 23
integer y = 52
integer width = 1038
integer height = 916
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemfocuschanged;call super::itemfocuschanged;//
////post attiva_tasti()
end event

event itemchanged;call super::itemchanged;// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//post	attiva_tasti()

end event

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_2_retrieve from statictext within tabpage_2
boolean visible = false
integer x = 1189
integer y = 100
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_3 dw_3
st_3_retrieve st_3_retrieve
end type

event rbuttonup;//
//parent.triggerevent("ue_rbuttonup")

end event

on tabpage_3.create
this.dw_3=create dw_3
this.st_3_retrieve=create st_3_retrieve
this.Control[]={this.dw_3,&
this.st_3_retrieve}
end on

on tabpage_3.destroy
destroy(this.dw_3)
destroy(this.st_3_retrieve)
end on

event rbuttondown;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

type dw_3 from uo_d_std_1 within tabpage_3
integer x = 14
integer y = 40
integer width = 1074
integer height = 884
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
//post	attiva_tasti()

end event

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_3_retrieve from statictext within tabpage_3
boolean visible = false
integer x = 1225
integer y = 116
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_4 dw_4
st_4_retrieve st_4_retrieve
end type

event rbuttonup;//
//parent.triggerevent("ue_rbuttonup")

end event

on tabpage_4.create
this.dw_4=create dw_4
this.st_4_retrieve=create st_4_retrieve
this.Control[]={this.dw_4,&
this.st_4_retrieve}
end on

on tabpage_4.destroy
destroy(this.dw_4)
destroy(this.st_4_retrieve)
end on

event rbuttondown;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

type dw_4 from uo_d_std_1 within tabpage_4
integer x = 5
integer y = 32
integer width = 992
integer height = 868
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_4_retrieve from statictext within tabpage_4
boolean visible = false
integer x = 1179
integer y = 148
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_5 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_5 dw_5
st_5_retrieve st_5_retrieve
end type

event rbuttonup;//
//parent.triggerevent("ue_rbuttonup")
end event

on tabpage_5.create
this.dw_5=create dw_5
this.st_5_retrieve=create st_5_retrieve
this.Control[]={this.dw_5,&
this.st_5_retrieve}
end on

on tabpage_5.destroy
destroy(this.dw_5)
destroy(this.st_5_retrieve)
end on

event rbuttondown;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

type dw_5 from uo_d_std_1 within tabpage_5
integer x = 91
integer y = 52
integer width = 814
integer height = 508
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_5_retrieve from statictext within tabpage_5
boolean visible = false
integer x = 1097
integer y = 140
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_6 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_6_retrieve st_6_retrieve
dw_6 dw_6
end type

event rbuttonup;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

on tabpage_6.create
this.st_6_retrieve=create st_6_retrieve
this.dw_6=create dw_6
this.Control[]={this.st_6_retrieve,&
this.dw_6}
end on

on tabpage_6.destroy
destroy(this.st_6_retrieve)
destroy(this.dw_6)
end on

type st_6_retrieve from statictext within tabpage_6
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_6 from uo_d_std_1 within tabpage_6
integer x = 78
integer y = 36
integer width = 731
integer height = 528
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_7 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_7_retrieve st_7_retrieve
dw_7 dw_7
end type

event rbuttonup;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

on tabpage_7.create
this.st_7_retrieve=create st_7_retrieve
this.dw_7=create dw_7
this.Control[]={this.st_7_retrieve,&
this.dw_7}
end on

on tabpage_7.destroy
destroy(this.st_7_retrieve)
destroy(this.dw_7)
end on

type st_7_retrieve from statictext within tabpage_7
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_7 from uo_d_std_1 within tabpage_7
integer y = 28
integer width = 1042
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_8 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_8_retrieve st_8_retrieve
dw_8 dw_8
end type

event rbuttonup;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

on tabpage_8.create
this.st_8_retrieve=create st_8_retrieve
this.dw_8=create dw_8
this.Control[]={this.st_8_retrieve,&
this.dw_8}
end on

on tabpage_8.destroy
destroy(this.st_8_retrieve)
destroy(this.dw_8)
end on

type st_8_retrieve from statictext within tabpage_8
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_8 from uo_d_std_1 within tabpage_8
integer y = 28
integer width = 1042
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_9 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_9_retrieve st_9_retrieve
dw_9 dw_9
end type

event rbuttonup;//
//parent.event ue_rbuttonup(flags, xpos, ypos)


end event

on tabpage_9.create
this.st_9_retrieve=create st_9_retrieve
this.dw_9=create dw_9
this.Control[]={this.st_9_retrieve,&
this.dw_9}
end on

on tabpage_9.destroy
destroy(this.st_9_retrieve)
destroy(this.dw_9)
end on

type st_9_retrieve from statictext within tabpage_9
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_9 from uo_d_std_1 within tabpage_9
integer x = 64
integer y = 16
integer width = 1042
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;
//
//kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
//kigrf_x_trova = this

end event

event itemchanged;call super::itemchanged;//
//post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

