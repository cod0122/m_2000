$PBExportHeader$dw_sys_base.sru
forward
global type dw_sys_base from dw_sys
end type
end forward

global type dw_sys_base from dw_sys
event type string ue_getmarkcolumnname ( )
event ue_currentrowchanging pbm_dwnrowchanging
event ue_currentrowchanged pbm_dwnrowchange
end type
global dw_sys_base dw_sys_base

type variables


Boolean		ib_useExtendedSelection
Long			il_lastSelectedRow
Long			il_lastRegularRow
KeyCode		ik_Arrow

end variables

forward prototypes
public subroutine of_useextendedselection (boolean ab_enable)
public subroutine of_disselectrows ()
public subroutine of_markrowext (long al_row, boolean ab_mark)
public subroutine of_selectrow (long al_row, boolean ab_mark)
end prototypes

event ue_GetMarkColumnName;
// ---

RETURN "dcf_selected"
end event

event ue_currentrowchanging;

// ---


end event

event ue_currentrowchanged;

// ---

//this.of_MarkSelectedRows(currentrow)
end event

public subroutine of_useextendedselection (boolean ab_enable);

// ---

ib_useExtendedSelection = ab_enable
end subroutine

public subroutine of_disselectrows ();
Long		l_row, l_found
String	s_objects, s_markfield

// ---

// DisMark selected Rows
DO 
	l_row = this.GetSelectedRow(l_row)
	IF l_row > 0 THEN
		this.SelectRow(l_row, FALSE)
		this.of_MarkRowExt(l_row, FALSE)
	END IF
LOOP WHILE l_row > 0


/*
DO
	l_found = this.Find(this.EVENT ue_GetMarkColumnName() + " = 1", l_found +1, this.RowCount())
	IF l_found > 0 THEN
		this.of_MarkRowExt(l_found, FALSE)
	END IF
LOOP WHILE l_found > 0
*/



end subroutine

public subroutine of_markrowext (long al_row, boolean ab_mark);
Long		l_index
String	s_objects, s_markField

// ---

s_objects 	= this.describe("datawindow.objects")
s_markField	= this.EVENT ue_GetMarkColumnName()

this.SelectRow(al_row, ab_mark)
//this.SetRow(al_row)
//this.ScrollToRow(al_row)

IF POS(Lower(s_objects), s_markField) > 0 AND ib_useExtendedSelection THEN
	IF al_row > 0 THEN
		IF ab_mark THEN
			this.SetItem(al_row, s_markField, 1)
		ELSE
			this.SetItem(al_row, s_markField, 0)
		END IF
	ELSE
		FOR l_index = 1 TO this.RowCount()
			IF ab_mark THEN
				this.SetItem(al_row, s_markField, 1)
			ELSE
				this.SetItem(al_row, s_markField, 0)
		END IF
		NEXT
	END IF
END IF

end subroutine

public subroutine of_selectrow (long al_row, boolean ab_mark);

// ---

this.of_MarkRowExt(al_row, ab_mark)

end subroutine

on dw_sys_base.create
call super::create
end on

on dw_sys_base.destroy
call super::destroy
end on

event clicked;
Long		l_index

// ---

IF KeyDown(KeyControl!) THEN

	IF row > 0 THEN
		IF this.GetSelectedRow(row - 1) = row THEN	
			this.of_SelectRow(row, FALSE)
		ELSE
			this.of_SelectRow(row, TRUE)
		END IF
	END IF	
	
	IF row > 0 THEN
		il_lastSelectedRow = row
	END IF
	
ELSEIF KeyDown(KeyShift!) THEN
	
	IF row > 0 THEN
		IF row > il_lastSelectedRow THEN
			FOR l_index = il_lastSelectedRow TO row
				this.of_SelectRow(l_index, TRUE)
			NEXT
		ELSEIF row < il_lastSelectedRow THEN
			FOR l_index = il_lastSelectedRow TO row STEP -1
				this.of_SelectRow(l_index, TRUE)
			NEXT
		END IF		
	END IF	
	
ELSE
	
	this.of_DisselectRows()
	IF row > 0 THEN
		this.of_SelectRow(row, TRUE)
	END IF
	
	IF row > 0 THEN
		il_lastSelectedRow = row
	END IF
	
END IF

IF row > 0 THEN
	il_lastRegularRow = row
END IF

RETURN super::EVENT clicked(xpos, ypos, row, dwo)



end event

event constructor;call super::constructor;

// ---

this.of_UseExtendedSelection(TRUE)
end event

event ue_key;call super::ue_key;
Long		l_row

// ---

this.SetRedraw(FALSE)

l_row = this.GetRow()

IF l_row > 0 THEN

	IF keyflags = 1 THEN
		
		IF key = KeyUpArrow! THEN
			IF il_lastRegularRow < l_row THEN
				this.of_SelectRow(l_row, FALSE)
			ELSE
				
			END IF
			this.of_SelectRow(l_row - 1, TRUE)
		END IF
		
		IF key = KeyDownArrow! THEN
			IF il_lastRegularRow > l_row THEN
				this.of_SelectRow(l_row, FALSE)
			ELSE
				
			END IF
			this.of_SelectRow(l_row + 1, TRUE)
		END IF
		
		//return 1
		
	ELSEIF keyflags = 2 THEN
		
		IF key = KeyDownArrow! THEN
			return 1
		END IF
		
		IF key = KeyUpArrow! THEN
			return 1
		END IF
	
		
	ELSEIF keyflags = 0 THEN
		
		// Disselect Other Rows
		this.of_DisselectRows()
		
		IF key = KeyUpArrow! THEN
			this.of_SelectRow(l_row, FALSE)
			IF l_row - 1 >= 1 THEN
				il_lastRegularRow = l_row - 1
				this.of_SelectRow(l_row - 1, TRUE)	
				//this.SetRow(l_row - 1)
				this.ScrollToRow(l_row - 1)
			END IF
		END IF
		
		IF key = KeyDownArrow! THEN
			this.of_SelectRow(l_row, FALSE)
			IF l_row + 1 <= this.RowCount() THEN
				il_lastRegularRow = l_row + 1
				this.of_SelectRow(l_row + 1, TRUE)	
				//this.SetRow(l_row + 1)
				this.ScrollToRow(l_row + 1)
			END IF
		END IF
		
		this.SetRedraw(TRUE)
		return 1
		
	END IF
	
END IF


this.SetRedraw(TRUE)

//RETURN 1

end event

