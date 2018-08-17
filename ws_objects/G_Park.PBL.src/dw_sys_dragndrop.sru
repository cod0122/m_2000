$PBExportHeader$dw_sys_dragndrop.sru
forward
global type dw_sys_dragndrop from dw_sys_base
end type
end forward

global type dw_sys_dragndrop from dw_sys_base
string dragicon = "C:\Projekte\PB-Prgs\baseapp\icons\drag.ico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
event ue_lmousebuttondown pbm_lbuttondown
event ue_lmousebuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event type long ue_beforedrop ( long al_droprow,  dw_sys_base adw_source )
event type long ue_dropfromthis ( long al_droprow,  dw_sys_base adw_source )
event type long ue_dropfromforeign ( long al_droprow,  dw_sys_base adw_source )
event type long ue_dropfromsame ( long al_droprow,  dw_sys_base adw_source )
event ue_afterdrop ( long al_droprow )
event ue_dwmousemove pbm_dwnmousemove
event ue_timer pbm_timer
event type string ue_getdropmarkcolumnname ( )
event description ( )
event type long ue_afterdroprow ( long al_droppedtorow )
end type
global dw_sys_dragndrop dw_sys_dragndrop

type prototypes
subroutine Sleep (long msec) LIBRARY "kernel32.dll" 
end prototypes

type variables



Boolean		ib_enableDrag
Boolean		ib_enableDrop

Boolean		ib_showWhereDropGoes

Boolean		ib_leftMouseButtonDown
Boolean 		ib_dragScrollDown
Boolean		ib_dragScrollUp
Boolean		ib_breakScroll

Long			il_currentMouseMoveRow
Long			il_scrollWaitTime
end variables

forward prototypes
public subroutine of_enabledrag (boolean ab_enable)
public subroutine of_enabledrop (boolean ab_enable)
public subroutine of_showwheredraggoes (boolean ab_enable)
public subroutine of_setscrollwaittime (long al_waittime)
public subroutine of_breakscroll ()
public subroutine of_markdropposition (long al_row, boolean ab_setmark)
public subroutine of_markdropposition (long al_row)
end prototypes

event ue_lmousebuttondown;
// ---

ib_leftMouseButtonDown = TRUE

// Start Dragging herer and not in mousemove because of Focus Problems...
IF ib_enableDrag AND ib_leftMouseButtonDown THEN
	this.Drag(begin!)
END IF

end event

event ue_lmousebuttonup;
// End Dragging 

// ---

ib_leftMouseButtonDown = FALSE
this.Drag(End!)

end event

event ue_mousemove;

// ---

// Drag Start moved to ue_lmousebuttondown because of Focus Problems
//IF ib_enableDrag AND ib_leftMouseButtonDown THEN
	//this.Drag(begin!)
//END IF
end event

event type long ue_beforedrop(long al_droprow, dw_sys_base adw_source);
// All Rows To Drop are selected

// ---


RETURN 1


end event

event type long ue_dropfromthis(long al_droprow, dw_sys_base adw_source);
// We Dragged From this... we Drop to this...

Long		l_row, l_selectedRows, l_rowSave[], l_index, l_rowCount
Long		l_subRows

// ---

//Go Through all selected Rows And Move Them to the destination Datawindow (this)



IF (adw_source.GetRow() <> al_droprow OR al_droprow = this.RowCount() OR al_droprow = 1) AND il_lastRegularRow <> al_droprow  THEN
	
	l_rowCount = this.RowCount()
	
	// Move all Selected Rows To the Back
	DO
		l_row = adw_source.GetSelectedRow(l_row)
		IF l_row > 0 THEN
			l_selectedRows ++
			l_rowSave[l_selectedRows] = l_row			
		END IF
	LOOP WHILE l_row > 0
	
	FOR l_index = UpperBound(l_rowSave[]) TO 1 STEP - 1
		adw_source.RowsMove(l_rowSave[l_index], l_rowSave[l_index], primary!, this, l_rowCount + 1, primary!)
	NEXT
	
	FOR l_index = 1 TO UpperBound(l_rowSave[])
	// Change Move To Row.. All Rows wich was selected bevore have to be substracted
		IF al_droprow > l_rowSave[l_index] THEN
			l_subRows ++
		END IF
	NEXT
	
	al_dropRow -= l_subRows
	
	
	FOR l_index = 0 TO l_selectedRows - 1
		adw_source.RowsMove(l_rowCount, l_rowCount, primary!, this, al_dropRow + l_index, primary!)
		// Fire Drop Row Event
		this.EVENT ue_AfterDropRow(al_droprow + l_index)
	NEXT
	
	// CurrentRow Should Be Dragged Row now
	il_lastRegularRow 	= al_dropRow
	il_lastSelectedRow 	= al_dropRow
	
END IF


RETURN 1
end event

event type long ue_dropfromforeign(long al_droprow, dw_sys_base adw_source);
// This Event has to be overided to enable Drag from another datawindow
// which has not the same datastores

// ---

RETURN 1
end event

event type long ue_dropfromsame(long al_droprow, dw_sys_base adw_source);
// We Dragged From an DW which has the same Dataobject as our

Long		l_row

// ---

// Go Through all selected Rows And Copy Them to the destination Datawindow
DO
	l_row = adw_source.GetSelectedRow(l_row)
	IF l_row > 0 THEN
		adw_source.RowsCopy(l_row, l_row, primary!, this, al_droprow, primary!)
		// Fire Drop Row Event
		this.EVENT ue_AfterDropRow(al_droprow)
		al_droprow ++
	END IF
LOOP WHILE l_row > 0


RETURN 1
end event

event ue_afterdrop(long al_droprow);
// Fired After all Rows are Dropped
// Only extend it if you want the Ability of Row Mark

// ---

// Dismark Drop In Mark
this.of_MarkDropPosition(0, FALSE)
end event

event ue_timer;

// ---


Yield()
end event

event type string ue_getdropmarkcolumnname();
// Get Name for the helper Column which marks the DropIn Marker

// ---

RETURN "dcf_dropmarker"
end event

event description();
/*

*** Drag N Drop Datawindow *** ... Version 1.01


(c) 2007 by Christian Dürnberger 


This Datawindow is a Drag N Drop Datawindow with some
features like a Drop-In Marker

ToDo:
	*) Activate PageUp and PageDown Buttons
	*) Activate Pos1 and End Button
	*) Activate Enter Button
	*) Variable ScrollUp and ScrollDown Speed by the length of time the
		mouse position is on the Scroll Row

Known Bugs:
	*) Drop From Foreign doesnt clear dropIn Marker (unknown Reason)
	*) ScrollBreak doesn't work sometimes?!?!?!
	*) Drop On LastRow (more than 1 row) is buggy
	

Changes to Version 1.00:
	*) Focus Bugfix by DragEnd


*/
end event

event type long ue_afterdroprow(long al_droppedtorow);
// Always fired after ONE Row is dropped

// ---

RETURN 1


end event

public subroutine of_enabledrag (boolean ab_enable);

// ---

ib_enableDrag = ab_enable
end subroutine

public subroutine of_enabledrop (boolean ab_enable);

// ---

ib_enableDrop = ab_enable
end subroutine

public subroutine of_showwheredraggoes (boolean ab_enable);

// ---

ib_showWhereDropGoes = ab_enable
end subroutine

public subroutine of_setscrollwaittime (long al_waittime);

// ---

il_scrollWaitTime = al_waitTime
end subroutine

public subroutine of_breakscroll ();
// ---

ib_breakScroll = TRUE
end subroutine

public subroutine of_markdropposition (long al_row, boolean ab_setmark);

// Funktion marks the Row in Wich the Drop will be inserted

Long		l_found, l_rows
String	s_objects, s_markDropField

// ---

this.SetRedraw(FALSE)

// Leave if we do not want the Mark
IF NOT ib_showWhereDropGoes THEN RETURN

s_objects 			= this.describe("datawindow.objects")
s_markDropField	= this.EVENT ue_GetDropMarkColumnName()

IF s_markDropField <> "" AND (NOT IsNull(s_markDropField)) THEN

	IF POS(Lower(s_objects), s_markDropField) > 0 THEN
	
		l_rows =  this.RowCount()
	
		// Delete All other markers
		DO 
			l_found = this.Find(s_markDropField + " = 1", l_found + 1, l_rows +1)
			IF l_found > 0 THEN
				// Disable Row Marker
				this.SetItem(l_found, "dcf_dropmarker", 0)
				DO 
				LOOP WHILE Yield()
			END IF
		LOOP WHILE l_found > 0	
		
		// Set Row Marker
		IF ab_setmark THEN
			this.SetItem(al_row, "dcf_dropmarker", 1)
			DO 
			LOOP WHILE Yield()
		END IF
		
	END IF
END IF
	

this.SetRedraw(TRUE)

Yield()



end subroutine

public subroutine of_markdropposition (long al_row);
// ---

this.of_MarkDropPosition(al_row, TRUE)
end subroutine

on dw_sys_dragndrop.create
call super::create
end on

on dw_sys_dragndrop.destroy
call super::destroy
end on

event constructor;

// ---

super::EVENT constructor()

// Enable Drag n Drop
this.of_EnableDrag(TRUE)
this.of_EnableDrop(TRUE)

// Set ScrollWaitTime 
this.of_SetScrollWaitTime(50)

// We will use the Feature to Show where de drag will
// be landed
this.of_ShowWhereDragGoes(TRUE)
end event

event dragdrop;call super::dragdrop;
Long				l_row, l_ret
DragObject		do_control
dw_sys_base		dw_source

// ---

this.SetRedraw(FALSE)

l_row = row


//Get the dragged object
do_control = DraggedObject()

IF IsValid(do_control) AND ib_enableDrop THEN
	
	dw_source = do_control
	
	l_ret = this.EVENT ue_BeforeDrop(l_row, dw_source)
	
	IF l_ret <> -1 THEN
	
		IF dw_source <> this THEN
			// Drop something which is not from our Datawindow
			IF Lower(dw_source.dataobject) = Lower(this.dataobject) THEN
				// DataObjects are the same
				l_ret = this.EVENT ue_DropFromSame(l_row, dw_source)
			ELSE
				// We Copy From another DW.. User has to do Copy stuff
				l_ret = this.EVENT ue_DropFromForeign(l_row, dw_source)
			END IF
		ELSE
			// We Drop from the Datawindow (inline drop)
			l_ret = this.EVENT ue_DropFromThis(l_row, dw_source)	
		END IF
		
	ELSE
		// Mark Row as Error for AfterDrop
		l_row = 0
	END IF

	// AfterDrop is always Fired
	this.EVENT ue_AfterDrop(l_row)
	
END IF



this.SetRedraw(TRUE)
end event

event dragwithin;call super::dragwithin;
// The DragWithin Event will be used to scroll up and down
// when reaching datawindow limits..

Long			l_row, l_firstRowOnPage, l_lastRowOnPage, l_found, l_rows
Long			l_index
String		s_band, s_pos, s_objects, s_markDropField

// ---

l_row = row

// Eventually mark Drop-In Point
this.of_MarkDropPosition(l_row)

s_band  = this.GetBandAtPointer()

// Get Band.
s_band = Mid(s_band,1,Pos(s_band,'~t') - 1)

IF s_band <> "detail" OR l_row = 0 THEN RETURN

// Get LastRow on Page.
s_pos = this.Object. DataWindow.LastRowOnPage
l_lastRowOnPage = Long(s_pos)

// Get First Row on Page.
s_pos = this.Object.DataWindow.FirstRowOnPage
l_firstRowOnPage = Long(s_pos)

il_currentMouseMoveRow = l_row


IF l_row = l_lastRowOnPage THEN
	
		DO
			Sleep(il_scrollWaitTime)
			DO
			LOOP WHILE Yield()
			IF ib_breakScroll THEN 
				ib_breakScroll = FALSE
				EXIT
			END IF
			this.scrolltorow(il_currentMouseMoveRow + 1)
			il_currentMouseMoveRow ++
			ib_dragScrollDown = TRUE
		LOOP WHILE KeyDown(KeyLeftButton!)

ELSEIF l_row = l_firstRowOnPage THEN

		DO
			Sleep(il_scrollWaitTime)
			DO
			LOOP WHILE Yield()
			IF ib_breakScroll THEN 
				ib_breakScroll = FALSE
				EXIT
			END IF
			this.scrolltorow(il_currentMouseMoveRow - 1)
			il_currentMouseMoveRow --
			ib_dragScrollUp = TRUE
		LOOP WHILE KeyDown(KeyLeftButton!)
		
ELSE
	
	ib_dragScrollUp 	= FALSE
	ib_dragScrollDown = FALSE
	this.POST of_BreakScroll()		
	// @@@ Break sometimes doesn't work?!?!?!
END IF


end event

event clicked;call super::clicked;

// ---

end event

