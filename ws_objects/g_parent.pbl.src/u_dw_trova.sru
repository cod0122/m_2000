$PBExportHeader$u_dw_trova.sru
forward
global type u_dw_trova from datawindow
end type
type str_trackmouseevent from structure within u_dw_trova
end type
end forward

type str_trackmouseevent from structure
	unsignedlong		cbsize
	unsignedlong		dwflag
	unsignedlong		hwndtrack
	unsignedlong		dwhovertime
end type

global type u_dw_trova from datawindow
integer width = 686
integer height = 400
string title = "none"
string dataobject = "d_xplistbar_trova"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_clicked ( integer kriga )
event mousemove pbm_dwnmousemove
event mouseleave ( )
event ue_clicked_0 ( integer row,  string k_dwo_name )
event u_pigiato_enter pbm_dwnprocessenter
end type
global u_dw_trova u_dw_trova

type prototypes
Function Boolean TrackMouseEvent(Ref str_TRACKMOUSEEVENT lpTrackMouseEvent) Library 'user32.dll' alias for "TrackMouseEvent;Ansi" 
Function Long GetLastError() Library 'Kernel32.dll' 
end prototypes

type variables
Long il_prev, il_rowcount
String is_prevobject

Boolean ib_mousemove

Constant ULong  WM_MOUSELEAVE = 675
Constant ULong  TME_LEAVE = 2
Constant ULong  HOVER_DEFAULT = 4294967295 

private datawindowchild  kidwc_1

end variables

forward prototypes
public function integer of_additem (string as_type, string as_text, integer ai_parent, string as_picture)
public function integer of_resize (integer ai_width)
public function string of_getitem (long k_riga)
public subroutine of_setitem (long k_riga, string k_testo, string k_picture)
private subroutine of_mostra_nasconde ()
end prototypes

event ue_clicked(integer kriga);//
//--- inserire qui le personalizzazioni su cosa fare quando click sulla voce di dettaglio 
//

end event

event mousemove;boolean ll_return
Long ll_error

IF NOT ib_mousemove THEN
	ib_mousemove = TRUE

	str_TRACKMOUSEEVENT lpTrackMouseEvent

	lpTrackMouseEvent.cbSize = 16 //Structure is 4 ulongs which is 16 bytes
	lpTrackMouseEvent.dwFlag = TME_LEAVE
	lpTrackMouseEvent.hwndTrack = Handle (this)
	lpTrackMouseEvent.dwHoverTime = HOVER_DEFAULT // Hover time-out in milliseconds
	
	ll_return = TrackMouseEvent(lpTrackMouseEvent) 
END IF

IF il_prev <> row OR is_prevobject <> dwo.Name THEN	
		
	THIS.SetRedraw(FALSE)
	
	THIS.SetItem(il_prev, 'highlighted','N')	
	
	IF dwo.Name <> 't_filler' AND &
		dwo.Name <> 't_child_bkgrnd' AND &
		dwo.Name <> 't_space' AND &
		dwo.Name <> 't_header_filler' AND &
		dwo.Name <> 'item_input' AND &
		dwo.Name <> 'datawindow' THEN

		THIS.SetItem(row, 'highlighted','Y')

END IF
	
	il_prev = Row
	is_prevobject = dwo.Name
	
	THIS.SetRedraw(TRUE)
END IF
end event

event mouseleave();ib_mousemove = FALSE

THIS.SetItem(il_prev, 'highlighted','N')	
il_prev=0
end event

event ue_clicked_0(integer row, string k_dwo_name);//
//--- Richiamato dal CLICKED
//
long k_ctr=0


IF row > 0 THEN

//	CHOOSE CASE String(THIS.Object.item_type[row])
//		CASE 'HE'
//			THIS.Object.item_type[row] = 'HC'
//			of_AddParentToFilter(Integer(THIS.Object.item_number[row]))
//		CASE 'HC'
//			THIS.Object.item_type[row] = 'HE'
//			of_RemoveParentFromFilter(Integer(THIS.Object.item_number[row]))
//		CASE 'C'
			IF k_dwo_name = 'item_picture' THEN 
				this.accepttext( )
//--- salva in elenco il valore cercato
				if len(trim(this.getitemstring( row, "item_input"))) > 0 then
					if kidwc_1.find(  "valore = '" + trim(this.getitemstring( row, "item_input")) + "'", 1, kidwc_1.rowcount( )) = 0 then
						k_ctr=kidwc_1.insertrow(1)
						kidwc_1.setitem(k_ctr, "valore", trim(this.getitemstring( row, "item_input")))
						if kidwc_1.rowcount( ) > 30 then 
							for k_ctr =  kidwc_1.rowcount( ) to 30 step -1
								kidwc_1.deleterow(k_ctr) 
							end for
						end if
					end if
				end if
				THIS.Trigger Event ue_clicked(row)  //String(THIS.Object.item_text[row]))
			END IF
//	END CHOOSE
//	
//	IF String(THIS.Object.item_type[row]) = 'HE' OR &
//	   String(THIS.Object.item_type[row]) = 'HC' THEN
//		THIS.SetFilter(of_GetParentFilter())
//		THIS.Filter()
//		THIS.SetSort('item_number')
//		THIS.Sort()
//	END IF
else

	IF k_dwo_name <> 't_header_filler' then

		of_mostra_nasconde()
		
	end if
	
END IF
end event

event u_pigiato_enter;//
//--- Premuto ENTER: simulo come il clicked su ITEM_PICTURE
//

	THIS.Trigger Event ue_clicked_0(1, "item_picture") 


return 1 


end event

public function integer of_additem (string as_type, string as_text, integer ai_parent, string as_picture);//
//--- Esempio da mettere nell'evento "construct":
//ll_parent = THIS.of_AddItem('header','Anagrafiche',0, '')
//THIS.of_AddItem('child','Potenziali',ll_parent, 'addhardware.bmp')
//
//
Long ll_row

////Add some space above the header
//IF Lower(as_type) = 'header' THEN
//	THIS.of_AddItem('space','',0, '')
//END IF

//Insert new item
ll_row = THIS.InsertRow(0)

//Set the item type
CHOOSE CASE Lower(as_type)
	CASE 'header'
		THIS.Object.item_type[ll_row] = 'HE'
	CASE 'child'
		THIS.Object.item_type[ll_row] = 'C'
	CASE 'space'
		THIS.Object.item_type[ll_row] = 'S'
	CASE 'filler'
		THIS.Object.item_type[ll_row] = 'F'
END CHOOSE

//Populate item information
//THIS.Object.item_text[ll_row] = as_text
THIS.Object.t_text.text = as_text
THIS.Object.item_number[ll_row] = ll_row
THIS.Object.parent_handle[ll_row] = ai_parent
THIS.Object.item_picture[ll_row] = kGuo_path.get_risorse() + "\" + as_picture
THIS.Object.highlighted[ll_row] = 'N'

il_rowcount = THIS.RowCount()

RETURN ll_row
end function

public function integer of_resize (integer ai_width);String ls_return

//Resize the controls to the size datawindow control on the window
THIS.SetRedraw(FALSE)
ai_width = ai_width - 27

ls_return = THIS.Modify("t_child_bkgrnd.Width=" + String(ai_width - (Long(THIS.Describe("t_child_bkgrnd.X")) * 2)) )
ls_return = THIS.Modify("t_header_bkgrnd.Width=" + String(ai_width - (Long(THIS.Describe("t_header_bkgrnd.X")) * 2)) )
ls_return = THIS.Modify("t_filler.Width=" + String(ai_width - (Long(THIS.Describe("t_filler.X")) * 2)) )
ls_return = THIS.Modify("t_header_filler.Width=" + String(ai_width - (Long(THIS.Describe("t_header_filler.X")) * 2)) )
ls_return = THIS.Modify("t_space.Width=" + String(ai_width - (Long(THIS.Describe("t_space.X")) * 2)) )
//ls_return = THIS.Modify("item_text.Width=" + String(ai_width - 300 ) )

ls_return = THIS.Modify("p_expanded.x=" + String( Long(THIS.Describe("t_child_bkgrnd.x")) + Long(THIS.Describe("t_child_bkgrnd.width")) - Long(THIS.Describe("p_expanded.Width")) ))
ls_return = THIS.Modify("p_expandedhover.x=" + String( Long(THIS.Describe("t_child_bkgrnd.x")) + Long(THIS.Describe("t_child_bkgrnd.width")) - Long(THIS.Describe("p_expandedhover.Width")) ))

ls_return = THIS.Modify("p_collapsed.x=" + String( Long(THIS.Describe("t_child_bkgrnd.x")) + Long(THIS.Describe("t_child_bkgrnd.width")) - Long(THIS.Describe("p_collapsed.Width")) ))
ls_return = THIS.Modify("p_collapsedhover.x=" + String( Long(THIS.Describe("t_child_bkgrnd.x")) + Long(THIS.Describe("t_child_bkgrnd.width")) - Long(THIS.Describe("p_collapsedhover.Width")) ))

THIS.SetRedraw(TRUE)
RETURN 1
end function

public function string of_getitem (long k_riga);//
//--- Torna la descrizione della Riga
//
//
string k_testo


k_testo = THIS.Object.item_text[k_riga] 

RETURN k_testo

end function

public subroutine of_setitem (long k_riga, string k_testo, string k_picture);//
//--- Mette la descrizione nella Riga
//
//


THIS.Object.item_text[k_riga]  = trim(k_testo) 
if len(trim(k_picture)) > 0 then
	THIS.Object.item_picture[k_riga] = kGuo_path.get_risorse() + "\" + k_picture
else
	THIS.Object.item_picture[k_riga] = ""
end if



end subroutine

private subroutine of_mostra_nasconde ();//
//--- mostra / nasconde corpo della ricerca
//
this.setredraw( false)
if this.describe( "item_input.visible") = "1" then
	this.modify("item_input.visible='0'")
	this.modify("item_picture.visible='0'")
	this.modify("t_header_filler.visible='0'")
else
	this.modify("t_header_filler.visible='1'")
	this.modify("item_input.visible='1'")
	this.modify("item_picture.visible='1'")
end if
this.setredraw(true)

	
end subroutine

on u_dw_trova.create
end on

on u_dw_trova.destroy
end on

event constructor;//
datastore kds_1


//
this.object.p_collapsedhover.filename = kGuo_path.get_risorse() + "\" + "XPListBarCollapsedHover.bmp"
this.object.p_expandedhover.filename = kGuo_path.get_risorse() + "\" + "XPListBarExpandedHover.bmp"
this.object.p_expanded.filename = kGuo_path.get_risorse() + "\" + "XPListBarExpanded.bmp"
this.object.p_collapsed.filename = kGuo_path.get_risorse() + "\" + "XPListBarCollapsed.bmp"
this.object.p_side.filename = kGuo_path.get_risorse() + "\" + "XPListBarSide.bmp"

THIS.Object.datawindow.color = RGB(122,160,230)

//--- Ripristina l'elenco delle parole cercate (passa da DW)
this.getchild( "item_input", kidwc_1)
kds_1 = create datastore
kds_1.dataobject = this.describe("item_input.DDDW.Name")
kGuf_data_base.dw_ripri_righe("*", kds_1, this.title)
kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kidwc_1,1, primary!) 
kidwc_1.setrow(1)
destroy kds_1


//len fissata
this.width = 891

of_Resize(THIS.Width)



end event

event clicked;//IF row > 0 THEN

	THIS.Trigger Event ue_clicked_0(row, dwo.name) 
	
//END IF
end event

event resize;
//If the scrollbar appears then resize the listbar so that
//it is completely visible.
IF Integer(THIS.Object.DataWindow.FirstRowOnPage) <> 1 OR &
	Integer(THIS.Object.DataWindow.lastRowOnPage) <> THIS.RowCount() THEN
	of_Resize(THIS.Width - 80)
ELSE
	of_Resize(THIS.Width)
END IF
end event

event losefocus;Long ll_index

THIS.SetRedraw(FALSE)
FOR ll_index = 1 TO il_rowcount
	THIS.SetItem(ll_index, 'highlighted','N')
NEXT
		
THIS.SetRedraw(TRUE)

end event

event other;Choose Case Message.Number
	Case WM_MOUSELEAVE
		This.TriggerEvent("MouseLeave")
End Choose 
end event

event destructor;//
int k_rc
datastore kds_1


	if kidwc_1.rowcount( ) > 0 then

		kds_1 = create datastore
		
//--- salva l'elenco delle parole cercate (passa da DW)
		this.getchild( "item_input", kidwc_1)
		kds_1.dataobject = this.describe("item_input.DDDW.Name")
	
		k_rc=kidwc_1.rowscopy( 1, kidwc_1.rowcount( ) ,primary!, kds_1, 1, primary!) 
		k_rc=kds_1.SetFilter("item_input > ' ' " ) // Toglie eventuali righe non valorizzate 
		k_rc=kds_1.Filter()
		k_rc=kGuf_data_base.dw_salva_righe("*", kds_1, this.title)
	
		destroy kds_1
	
	end if
end event

