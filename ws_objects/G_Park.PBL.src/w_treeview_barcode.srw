$PBExportHeader$w_treeview_barcode.srw
forward
global type w_treeview_barcode from w_g_tab0
end type
type tv_root from treeview within w_treeview_barcode
end type
end forward

global type w_treeview_barcode from w_g_tab0
integer height = 1532
tv_root tv_root
end type
global w_treeview_barcode w_treeview_barcode

event open;call super::open;kuf_utility kuf1_utility

kuf1_utility = create kuf_utility
kuf1_utility.u_treeview(tv_root)
destroy kuf1_utility
end event
on w_treeview_barcode.create
int iCurrent
call super::create
this.tv_root=create tv_root
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_root
end on

on w_treeview_barcode.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_root)
end on

type cb_visualizza from w_g_tab0`cb_visualizza within w_treeview_barcode
end type

type cb_modifica from w_g_tab0`cb_modifica within w_treeview_barcode
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_treeview_barcode
boolean visible = false
integer x = 1915
integer y = 608
integer width = 581
integer height = 292
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_treeview_barcode
end type

type cb_cancella from w_g_tab0`cb_cancella within w_treeview_barcode
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_treeview_barcode
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_treeview_barcode
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_treeview_barcode
boolean visible = false
integer x = 1829
integer y = 904
integer width = 663
integer height = 288
end type

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_treeview_barcode
integer x = 105
integer y = 584
end type

type sle_cerca from w_g_tab0`sle_cerca within w_treeview_barcode
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_treeview_barcode
end type

type tv_root from treeview within w_treeview_barcode
integer x = 64
integer y = 52
integer width = 1358
integer height = 1192
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string picturename[] = {"Database!","Custom039!","Custom050!","UserObject1!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

