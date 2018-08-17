$PBExportHeader$w_gnu_gpl.srw
forward
global type w_gnu_gpl from w_super
end type
type dw_gnu_gpl from datawindow within w_gnu_gpl
end type
end forward

global type w_gnu_gpl from w_super
boolean visible = true
integer width = 4402
integer height = 1868
string title = "Licenza GNU-GPL"
boolean maxbox = false
windowtype windowtype = popup!
event u_open ( )
dw_gnu_gpl dw_gnu_gpl
end type
global w_gnu_gpl w_gnu_gpl

event u_open();//
this.height = dw_gnu_gpl.height  + 120
this.width = dw_gnu_gpl.width  + 50

//dw_gnu_gpl.width =	this.WorkSpaceWidth() - 45
//dw_gnu_gpl.height = this.WorkSpaceHeight() - 25
//
//return 0

end event

on w_gnu_gpl.create
int iCurrent
call super::create
this.dw_gnu_gpl=create dw_gnu_gpl
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_gnu_gpl
end on

on w_gnu_gpl.destroy
call super::destroy
destroy(this.dw_gnu_gpl)
end on

event open;//
//
//try
//	st_open_w kst_open_w 
//	u_riopen(kst_open_w)
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente("Visualizza Licenza GLP", "Operazione Interrotta !")
//end try

ki_nome_save = trim(this.ClassName())

post event u_open( )
end event

event resize;//

end event

type dw_gnu_gpl from datawindow within w_gnu_gpl
integer width = 3968
integer height = 1636
integer taborder = 10
string title = "none"
string dataobject = "d_gnu_gpl"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

