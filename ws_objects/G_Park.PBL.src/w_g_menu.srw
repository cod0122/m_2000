$PBExportHeader$w_g_menu.srw
forward
global type w_g_menu from window
end type
type p_1 from picture within w_g_menu
end type
end forward

global type w_g_menu from window
integer width = 4718
integer height = 228
boolean border = false
windowtype windowtype = child!
long backcolor = 16777215
boolean toolbarvisible = false
p_1 p_1
end type
global w_g_menu w_g_menu

forward prototypes
public function integer u_inizializza ()
end prototypes

public function integer u_inizializza ();//
//---
//

p_1.picturename = kg_menu.m_magazzino.m_mag_navigatore.toolbaritemname
p_1.powertiptext =  kg_menu.m_magazzino.m_mag_navigatore.toolbaritemtext

kg_menu.u_item()

return 0

end function

event open;move(0,0)
this.height = 230

post u_inizializza( )

end event

on w_g_menu.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_g_menu.destroy
destroy(this.p_1)
end on

type p_1 from picture within w_g_menu
integer x = 18
integer y = 12
integer width = 155
integer height = 100
boolean focusrectangle = false
end type

