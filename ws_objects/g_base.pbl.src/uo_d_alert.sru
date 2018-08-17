$PBExportHeader$uo_d_alert.sru
forward
global type uo_d_alert from datawindow
end type
end forward

global type uo_d_alert from datawindow
integer width = 1925
integer height = 396
string title = "ALLERT"
string dataobject = "d_memo_allarme"
boolean vscrollbar = true
boolean border = false
string icon = "Asterisk!"
boolean livescroll = true
event u_keyenter pbm_dwnprocessenter
end type
global uo_d_alert uo_d_alert

type variables
private kuf_alert kiuf_alert 
private boolean ki_notifica_a_video = true

end variables

forward prototypes
public subroutine u_deleterow (long a_riga)
public subroutine u_clicked (long a_riga)
public function boolean if_notifica ()
end prototypes

event u_keyenter;//	
if this.getrow( ) > 0 then
	u_clicked(this.getrow( ))
end if

end event

public subroutine u_deleterow (long a_riga);//
//--- ESEGUE 
//

	this.deleterow(a_riga)
	


end subroutine

public subroutine u_clicked (long a_riga);
end subroutine

public function boolean if_notifica ();//
return ki_notifica_a_video



end function

on uo_d_alert.create
end on

on uo_d_alert.destroy
end on

event constructor;//
//kiuf_memo_allarme = create kuf_memo_allarme
//string k_str 
//k_str = kguo_path.get_risorse( ) + kkg.PATH_SEP + "cancel16.png"
//this.object.p_img_del.filename = kguo_path.get_risorse( ) + kkg.PATH_SEP + "cancel16.png"

end event

