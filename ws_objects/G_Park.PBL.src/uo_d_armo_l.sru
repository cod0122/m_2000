$PBExportHeader$uo_d_armo_l.sru
forward
global type uo_d_armo_l from uo_d_nulla
end type
end forward

global type uo_d_armo_l from uo_d_nulla
string dataobject = "d_armo_l"
end type
global uo_d_armo_l uo_d_armo_l

event clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode" then
	
	this.getchild("barcode", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if this.rowcount() > 0 then

		if kdwc_barcode.retrieve(this.getitemnumber(row,"id_armo")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event
on uo_d_armo_l.create
end on

on uo_d_armo_l.destroy
end on

