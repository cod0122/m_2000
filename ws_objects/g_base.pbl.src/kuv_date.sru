$PBExportHeader$kuv_date.sru
forward
global type kuv_date from editmask
end type
end forward

global type kuv_date from editmask
int Width=329
int Height=84
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global kuv_date kuv_date

event losefocus;//
this.visible = false

end event

