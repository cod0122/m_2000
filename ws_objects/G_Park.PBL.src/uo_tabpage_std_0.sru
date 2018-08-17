$PBExportHeader$uo_tabpage_std_0.sru
forward
global type uo_tabpage_std_0 from userobject
end type
type dw_1 from uo_d_std_1 within uo_tabpage_std_0
end type
end forward

global type uo_tabpage_std_0 from userobject
integer width = 2203
integer height = 1440
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_tabpage_std_0 uo_tabpage_std_0

event constructor;//
//this.backcolor = parent.backcolor

end event

on uo_tabpage_std_0.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_tabpage_std_0.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_d_std_1 within uo_tabpage_std_0
boolean visible = true
integer x = 379
integer y = 120
integer taborder = 10
end type

