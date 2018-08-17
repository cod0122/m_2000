$PBExportHeader$uo_dw_periodo.sru
forward
global type uo_dw_periodo from datawindow
end type
type str_trackmouseevent from structure within uo_dw_periodo
end type
end forward

type str_trackmouseevent from structure
	unsignedlong		cbsize
	unsignedlong		dwflag
	unsignedlong		hwndtrack
	unsignedlong		dwhovertime
end type

global type uo_dw_periodo from datawindow
boolean visible = false
integer width = 1015
integer height = 508
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean border = false
borderstyle borderstyle = stylelowered!
event ue_clicked ( )
event mousemove pbm_dwnmousemove
event mouseleave ( )
event ue_visible ( )
event ue_clicked_0 ( integer row,  string k_dwo_name )
event u_pigiato_enter pbm_dwnprocessenter
end type
global uo_dw_periodo uo_dw_periodo

type prototypes
Function Boolean TrackMouseEvent(Ref str_TRACKMOUSEEVENT lpTrackMouseEvent) Library 'user32.dll' alias for "TrackMouseEvent;Ansi" 
Function Long GetLastError() Library 'Kernel32.dll' 
end prototypes

type variables
//
date ki_data_ini, ki_data_fin
window kiw_parent
end variables

forward prototypes
public subroutine set_data_ini (date a_data)
public function date get_data_ini ()
public function date get_data_fin ()
public subroutine set_data_fin (date a_data)
public subroutine inizializza (window a_window_parent)
end prototypes

event ue_clicked();//
//--- inserire qui le personalizzazioni su cosa fare quando click sulla voce di dettaglio 
//

end event

event ue_visible();//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_parent.width  - this.width) / 4
	this.y = (kiw_parent.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)

	this.visible = true
	this.setfocus()
end event

event ue_clicked_0(integer row, string k_dwo_name);//
//--- Richiamato dal CLICKED
//


IF row > 0 THEN

	try
		SetPointer(kkg.pointer_attesa)
	
	
		if k_dwo_name = "b_ok" then
			
			this.visible = false
			
			this.accepttext( )
			
			set_data_ini(this.getitemdate( 1, "data_dal"))
			set_data_fin(this.getitemdate( 1, "data_al"))
			event ue_clicked( )
		
		else
			if k_dwo_name = "b_annulla" then
		
				this.visible = false
			
			end if
		end if
		
	
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	
	finally
		SetPointer(kkg.pointer_default)
	
		
	end try

end if

end event

event u_pigiato_enter;//
//--- Premuto ENTER: simulo come il clicked su ITEM_PICTURE
//

	THIS.Trigger Event ue_clicked_0(1, "b_ok") 


return 1 


end event

public subroutine set_data_ini (date a_data);//
	ki_data_ini = a_data
	


end subroutine

public function date get_data_ini ();//
	return ki_data_ini 
	


end function

public function date get_data_fin ();//
	return ki_data_fin 
	


end function

public subroutine set_data_fin (date a_data);//
	ki_data_fin = a_data
	


end subroutine

public subroutine inizializza (window a_window_parent);//
	kiw_parent = a_window_parent
	ki_data_fin = kguo_g.get_dataoggi( )
	ki_data_ini = relativedate(ki_data_fin, -31)

end subroutine

on uo_dw_periodo.create
end on

on uo_dw_periodo.destroy
end on

event buttonclicked;//

THIS.Trigger Event ue_clicked_0(row, dwo.name) 


end event

