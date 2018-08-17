$PBExportHeader$kuf_ddw_grid.sru
forward
global type kuf_ddw_grid from nonvisualobject
end type
end forward

global type kuf_ddw_grid from nonvisualobject
end type
global kuf_ddw_grid kuf_ddw_grid

type variables
//----------------------------------------------------------------------------------------------------------------------------
//--- Type ahead style dropdown datawindow columns
//--- Ovvero permette all'utente di vedere in anteprima il valore intero mentre digita i carateri in un campo di ddw
//---
//----------------------------------------------------------------------------------------------------------------------------
// dddw search as you type functionality
datawindow idw
datawindowchild idwc[]
string is_datawindow[] // names of datawindow/column combinations registered for typeahead functionality
integer     ii_currentindex
boolean		ib_performsearch=False
string		is_textprev

end variables

forward prototypes
public function integer u_register_dddw_columns (datawindow adw, string a_colname)
public subroutine u_set_current_dw (ref datawindow adw)
public subroutine u_editchanged (long al_row, dwobject adwo, string as_data)
public subroutine u_itemfocuschanged (long al_row, dwobject adwo)
public function integer u_find_registered_dddw_columns (string a_dwcolname)
end prototypes

public function integer u_register_dddw_columns (datawindow adw, string a_colname);//
//--- set up il registro del datawindowchild array
//--- se non passo nulla nel a_colname allora popola il registro in automatico con tutte le dddw presenti
//
datawindowchild ldwc
integer li_rc
long	ll_ac=0, k_ufo
string ls_desc, ls_val, k_dw_syntax
long k_len_max=0,  k_ctr, k_ctr1, k_ctr2, k_ctr3, k_ctr4, k_items=0


k_items = upperbound(is_datawindow)

//--- se ho indicato una particolare colonna aggiungo solo quella al registro
if trim(a_colname) > "" then
	ll_ac = k_items + 1
	is_datawindow[ll_ac] = adw.classname() + '|' + a_colname
	ls_desc = a_colname + '.dddw.allowedit'
	ls_val = adw.describe(ls_desc)
	IF ls_val = 'yes' THEN
		li_rc = adw.GetChild(a_colname, ldwc)
		IF li_rc<>1 THEN RETURN -1
		idwc[ll_ac] = ldwc
	END IF
	
else
	
//--- lo faccio solo se ARRAY vuota (evito di ripetere + volte)	commentato xchè altrimenti no funziona
//	if k_items > 0 then  RETURN k_items   
	
//--- Scova i nomi delle colonne con "DDDW" con il presupposto che la proprietà "dddw.name=" segue sempre il "name=" poi registra il mome della colonna 
	k_dw_syntax = adw.describe("DataWindow.Syntax")
	k_len_max = len(k_dw_syntax)
//--- estrazione dei nomi dei dddw
	ll_ac = 0
	k_ctr = 1
	k_ctr4 = 1
	k_ctr1 = pos(k_dw_syntax, " dddw.name=", k_ctr)    //cerca stringa 'dddw.name' ovvero tutti i datawindowchild 
	DO WHILE k_ctr1 > 0 and k_ctr1 < k_len_max and ll_ac < 100
		k_ctr4 = pos(k_dw_syntax, "column(name=", k_ctr4) // cerca 'name=' indietro ovvero fino al ddw_name
		do while  k_ctr4 <> 0 and k_ctr4 < k_ctr1
			k_ctr2 = k_ctr4
			k_ctr4 += 12
			k_ctr4 = pos(k_dw_syntax, "column(name=", k_ctr4) // cerca 'name=' indietro ovvero fino al ddw_name
		loop
		
		if k_ctr2 > 0 and k_ctr2 < k_ctr1 then // 'name' probabilmente trovato
			k_ctr2 += 12
			k_ctr3 = pos(k_dw_syntax, " ", k_ctr2)

//--- solo se EDIT sul campo è permesso lo agguingo al registro			
			a_colname = mid(k_dw_syntax, k_ctr2, k_ctr3 - k_ctr2)
			ls_desc = a_colname + '.dddw.allowedit'
			ls_val = adw.describe(ls_desc)
			IF ls_val = 'yes' THEN
				li_rc = adw.GetChild(a_colname, ldwc)
				IF li_rc=1 THEN 
					ll_ac ++
					is_datawindow[ll_ac] =  adw.classname() + '|' + a_colname
					idwc[ll_ac] = ldwc
					k_ufo = ldwc.rowcount( )
				END IF
			END IF
		end if
		k_ctr = k_ctr1 + 11
		k_ctr1 = pos(k_dw_syntax, " dddw.name=", k_ctr)    //cerca stringa 'dddw.name' ovvero tutti i datawindowchild
	LOOP	

	k_items = ll_ac
end if

//k_items = ll_ac
//FOR ll_ac = 1 to k_items
//	IF is_datawindow[ll_ac] = adw.classname() + '|' + a_colname THEN
//			RETURN 1 // already registered
//	else
//ll_ac = upperbound(is_datawindow) + 1
//is_datawindow[ll_ac] = adw.classname() + '|' + a_colname

// need allowedit property set for this functionality to work
// this must be done prior to the getchild call
//		ls_desc = a_colname + '.dddw.allowedit'
//		ls_val = adw.describe(ls_desc)
//		IF ls_val <> 'yes' THEN
//			ls_desc += '=yes'
//			ls_val = adw.modify(ls_desc)
//		END IF
		
		// Get a reference to the DropDownDatawindow.
//		li_rc = adw.GetChild(a_colname, ldwc)
//		IF li_rc<>1 THEN RETURN -1
//		idwc[ll_ac] = ldwc
//
//	END IF
//NEXT

RETURN k_items   



end function

public subroutine u_set_current_dw (ref datawindow adw);//called from getfocus event on datawindow	with dddw typeahead capability
idw = adw
u_register_dddw_columns(idw, "") // attiva tutte le colonne con dddw
end subroutine

public subroutine u_editchanged (long al_row, dwobject adwo, string as_data);// mapped to editchanged event on datawindow where dddw typeahead is desired
boolean		lb_matchfound=False
integer		li_searchtextlen
long		ll_findrow, k_ufo
long		ll_dddw_rowcount
string		ls_dddw_displaycol
string		ls_foundtext
string		ls_findexp
string		ls_displaydata_value
string		ls_searchtext

// Check requirements.
If IsNull(adwo) or Not IsValid(adwo) Then Return

// Confirm that the search capabilities are valid for this column.
if ib_performsearch=False or ii_currentindex <= 0 THEN return

// Get information on the column and text.
ls_searchtext = as_data
li_searchtextlen = Len (ls_searchtext)

// If the user performed a delete operation, do not perform the search.
// If the text entered is the same as the last search, do not perform another search.
If (li_searchtextlen < Len(is_textprev)) or &
	(Lower (ls_searchtext) = Lower (is_textprev)) Then
	// Store the previous text information.
	is_textprev = ''
	Return 
End If

// Store the previous text information.
is_textprev = ls_searchtext

// Build the find expression to search the dddw for the text 
// entered in the parent datawindow column.
ls_dddw_displaycol = adwo.dddw.displaycolumn
ls_findexp = "Lower (Left (" + ls_dddw_displaycol + ", " + &
	String (li_searchtextlen) + ")) = '" + Lower (ls_searchtext) + "'"

// Perform the Search on the dddw.
ll_dddw_rowcount = idwc[ii_currentindex].rowcount()
ll_findrow = idwc[ii_currentindex].Find (ls_findexp, 0, ll_dddw_rowcount + 1)

k_ufo = idwc[ii_currentindex].rowcount()

// Determine if a match was found on the dddw.
lb_matchfound = (ll_findrow > 0)

// Set the found text if found on the dddw.
if lb_matchfound then
	// Get the text found.
	ls_foundtext = idwc[ii_currentindex].GetItemString (ll_findrow, ls_dddw_displaycol)
End If								

// For either dddw or ddlb, check if a match was found.
If lb_matchfound Then
	// Set the text.
	idw.SetText (ls_foundtext)

	// Determine what to highlight or where to move the cursor..
	if li_searchtextlen = len(ls_foundtext) THEN
		// Move the cursor to the end
		idw.SelectText (Len (ls_foundtext)+1, 0)
	else
		// Hightlight the portion the user has not actually typed.
		idw.SelectText (li_searchtextlen + 1, Len (ls_foundtext))
	end if
end if


end subroutine

public subroutine u_itemfocuschanged (long al_row, dwobject adwo);// set index if column is in dddw array

int		li_index
string 	ls_dwcolname

ib_performsearch = False
ii_currentindex = 0
is_textprev = ''

If IsNull(adwo) or Not IsValid(adwo) Then Return
If IsNull(al_row) or al_row <= 0 Then Return
If IsNull(idw) or Not IsValid(idw) Then Return
// Get column name. (in 'datawindow name|column name' format)
ls_dwcolname = idw.classname() + '|' + adwo.Name

// Check if column is in the search column array.
li_index = u_find_registered_dddw_columns(ls_dwcolname)
If li_index <= 0 Then Return
// can perform search on the column
ib_performsearch = True

// Store the current index.
ii_currentindex = li_index
// Store the previous text information.
is_textprev = idw.GetText()
end subroutine

public function integer u_find_registered_dddw_columns (string a_dwcolname);// finds array position of given datawindow name/column name array
integer	li_count
integer	li_i

// Get the size of the array.
li_count = upperbound(is_datawindow)

// Check for an empty array.
if li_count <= 0 THEN return 0

// Find column name in array.
for li_i=1 TO li_count
	if is_datawindow[li_i] = a_dwcolname THEN
		return li_i
	end if
next
// Column name not found in array.
RETURN 0

end function

on kuf_ddw_grid.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_ddw_grid.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

