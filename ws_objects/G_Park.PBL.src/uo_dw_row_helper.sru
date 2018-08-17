$PBExportHeader$uo_dw_row_helper.sru
forward
global type uo_dw_row_helper from nonvisualobject
end type
end forward

global type uo_dw_row_helper from nonvisualobject
end type
global uo_dw_row_helper uo_dw_row_helper

type variables
//
private uo_d_std_1  kiuo_d_std_1	//oggetto del servizio
private string ki_selectiona_tipo // tipi da attivare
private constant string ki_seleziona_tipo_listbox = "l"		// seleziona solo una riga alla volta
private constant string ki_seleziona_tipo_normale = "n"		// nessuna selezione
private constant string ki_seleziona_tipo_scambia = "t"		// scambia la selezione della riga corrente (on/off)
private constant string ki_seleziona_tipo_esteso = "e"		// seleziona + righe con shft/ctrl
private long ki_riga_ancorata = 0									// usata con modo_esteso

end variables
forward prototypes
public subroutine u_register (uo_d_std_1 a_uo_d_std_1)
public function string u_seleziona_tipo (string a_seleziona_tipo)
public subroutine u_clicked (long a_row, string a_key)
public subroutine u_select_esteso (long a_row, string a_key)
public subroutine u_select_listbox (long a_row)
public subroutine u_select_scambia (long a_row)
end prototypes

public subroutine u_register (uo_d_std_1 a_uo_d_std_1);//---------------------------------------------------------------------------------------------------------------------------
//---
//--- u_register
//--- Registra l'argomento a_uo_d_std_1 così che questo oggetto si aggiunge il servizio
//--- inp:  uo_d_std_1
//--- out:  
//---
//---------------------------------------------------------------------------------------------------------------------------
//
kiuo_d_std_1 = a_uo_d_std_1 

end subroutine

public function string u_seleziona_tipo (string a_seleziona_tipo);//----------------------------------------------------------------------------------------------------------------------------------
//--- u_seleziona_tipo
//--- Imposta il tipo di selezione da fare (servizio) x questo oggetto dw, questo metodo è usato da click event
//--- Inp:  carattere con il tipo di selezione: che sono quelli indicati nelle variabili di istanza
//--- Out: il vecchio tipo di selezione
//----------------------------------------------------------------------------------------------------------------------------------
//
string k_return
string k_seleziona_tipo

//k_return = u_seleziona_tipo( )
k_return = k_seleziona_tipo

k_seleziona_tipo = trim(lower(a_seleziona_tipo))

if len(trim(k_seleziona_tipo)) = 0 then k_seleziona_tipo = ki_seleziona_tipo_normale  // il default

if k_seleziona_tipo = ki_seleziona_tipo_listbox or k_seleziona_tipo = ki_seleziona_tipo_normale or k_seleziona_tipo = ki_seleziona_tipo_scambia or k_seleziona_tipo = ki_seleziona_tipo_esteso then
	ki_selectiona_tipo = k_seleziona_tipo
end if

return k_return

end function

public subroutine u_clicked (long a_row, string a_key);//---------------------------------------------------------------------------------
//--- u_select
//--- Inp: la riga cliccata e il tasto premuto (shift, ctrl o niente)
//---
//---------------------------------------------------------------------------------
//


if not isValid(kiuo_d_std_1) then return // So we won’t have to check it with each of the individual functions

if a_row < 1 or isNull(a_row) then return // need to make sure the row is valid

choose case ki_selectiona_tipo

	case ki_seleziona_tipo_normale
		return

	case ki_seleziona_tipo_scambia
		u_select_scambia( a_row) // no need to worry about the special key

	case ki_seleziona_tipo_listbox
		u_select_listbox( a_row) // this doesn’t need the special key either

	case ki_seleziona_tipo_listbox
		u_select_listbox( a_row) // this doesn’t need the special key either
		
end choose

end subroutine

public subroutine u_select_esteso (long a_row, string a_key);//---------------------------------------------------------------------------------
//--- u_select_esteso
//--- Inp: la riga cliccata e il tasto premuto (shift, ctrl o niente)
//---
//---------------------------------------------------------------------------------
//

choose case a_key
	case "ctrl"
		u_select_scambia(a_row)
	case "shift"
	if ki_riga_ancorata < 1 or ki_riga_ancorata > kiuo_d_std_1.rowCount()  then return
		kiuo_d_std_1.selectRow(0, FALSE) // Turn them all off
		kiuo_d_std_1.setRedraw(FALSE) // So the user doesn’t see each row highlight one at a time
		long ll_row 
// I wanted to just use the STEP on the FOR NEXT then I wouldn’t have to do the
// swapping of the anchor and row variables PowerBuilder doesn’t allow you to use a
// variable in the STEP. It has to be explicit. So I’m stuck with making sure a_row
// is less than ki_riga_ancorata programatically
		if a_row > ki_riga_ancorata then
			ll_row = ki_riga_ancorata // We need to loop from least to greatest
			ki_riga_ancorata = a_row
			a_row = ll_row
		end if
		for ll_row = a_row to ki_riga_ancorata
			kiuo_d_std_1.selectRow(ll_row, TRUE)
		next
		kiuo_d_std_1.setRedraw(TRUE)
	case ""
		u_select_listbox( a_row)
		ki_riga_ancorata = a_row
end choose


end subroutine

public subroutine u_select_listbox (long a_row);//---------------------------------------------------------------------------------
//--- u_select_listbox
//--- Inp: la riga cliccata da selezionare (l'UNICA!)
//---
//---------------------------------------------------------------------------------
//

kiuo_d_std_1.selectRow(0, FALSE)
kiuo_d_std_1.selectRow(a_row, TRUE)



end subroutine

public subroutine u_select_scambia (long a_row);//---------------------------------------------------------------------------------
//--- u_select_scambia
//--- Inp: la riga da selezionare o deselezionare
//---
//---------------------------------------------------------------------------------
//

kiuo_d_std_1.selectRow(a_row, not kiuo_d_std_1.isselected( a_row))




end subroutine

on uo_dw_row_helper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_dw_row_helper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

