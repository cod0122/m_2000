$PBExportHeader$uo_msg.sru
forward
global type uo_msg from userobject
end type
type st_msg from statictext within uo_msg
end type
type rr_msg from roundrectangle within uo_msg
end type
end forward

global type uo_msg from userobject
string tag = "uo_msg"
integer width = 727
integer height = 180
string dragicon = "Information!"
long backcolor = 553648127
string pointer = "Arrow!"
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event u_mousemove pbm_mousemove
event u_dragdrop_move ( )
st_msg st_msg
rr_msg rr_msg
end type
global uo_msg uo_msg

type variables
//
public boolean ki_dragdrop = false

private long ki_x_drag = 0, ki_y_drag = 0

end variables

event u_dragdrop_move();//
int k_pos_x, k_pos_y

k_pos_x = this.x
k_pos_y = this.y

if abs(ki_x_drag - pointerx( )) > 125 then
	if ki_x_drag > pointerx( ) then
		k_pos_x = k_pos_x - (ki_x_drag - pointerx( ))
	else
		k_pos_x = k_pos_x + (pointerx( ) - ki_x_drag)
	end if
	ki_x_drag = pointerx( )
end if

if abs(ki_y_drag - pointery( )) > 25 then
	if ki_y_drag > pointery( ) then
		k_pos_y = k_pos_y - (ki_y_drag - pointery( ))
	else
		k_pos_y = k_pos_y + (pointery( ) - ki_y_drag)
	end if
	ki_y_drag = pointery( )
end if

this.move( k_pos_x, k_pos_y)

end event

on uo_msg.create
this.st_msg=create st_msg
this.rr_msg=create rr_msg
this.Control[]={this.st_msg,&
this.rr_msg}
end on

on uo_msg.destroy
destroy(this.st_msg)
destroy(this.rr_msg)
end on

type st_msg from statictext within uo_msg
event u_mousemove pbm_mousemove
integer x = 23
integer y = 16
integer width = 677
integer height = 144
string dragicon = "Information!"
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 65535
string text = "testo messaggio"
boolean focusrectangle = false
end type

type rr_msg from roundrectangle within uo_msg
integer linethickness = 4
long fillcolor = 65535
integer width = 727
integer height = 176
integer cornerheight = 40
integer cornerwidth = 46
end type

