$PBExportHeader$dw_sys.sru
forward
global type dw_sys from datawindow
end type
end forward

global type dw_sys from datawindow
integer width = 686
integer height = 400
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_key pbm_dwnkey
end type
global dw_sys dw_sys

event ue_key;
Long		l_selRow, l_rowAry[], l_index

// ---

IF keyflags = 2 THEN
	IF key = keyN! THEN
		this.InsertRow(this.RowCount() + 1)
	END IF
	
	IF key = keyS! THEN	
		this.Update()
		commit using sqlca;
	END IF
	
	IF key = keyX! THEN
		If this.GetRow() > 0 THEN
			this.DeleteRow(this.GetROw())
		END IF
	END IF
	
END IF

// Delete Selected Rows
IF key = keyDelete! THEN
	DO
		l_selRow = this.GetSelectedRow(l_selRow)
		IF l_selRow > 0 THEN
			l_rowAry[UpperBound(l_rowAry[]) + 1] = l_selRow
		END IF
	LOOP WHILE l_selRow > 0 
	
	FOR l_index = UpperBound(l_rowAry[]) TO 1 STEP - 1
		this.DeleteRow(l_rowAry[l_index])
	NEXT	
END IF


end event

on dw_sys.create
end on

on dw_sys.destroy
end on

event constructor;

// ---

this.POST SetTrans(sqlca)
this.POST SetTransObject(sqlca)
end event

