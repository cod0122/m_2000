$PBExportHeader$w_meca_qtna_note.srw
forward
global type w_meca_qtna_note from w_g_tab0
end type
end forward

global type w_meca_qtna_note from w_g_tab0
integer width = 2002
integer height = 1412
boolean ki_esponi_msg_dati_modificati = false
boolean ki_exit_dopo_save_ok = true
boolean ki_reset_dopo_save_ok = false
end type
global w_meca_qtna_note w_meca_qtna_note

type variables
//
private kuf_meca_qtna			kiuf_meca_qtna
private w_meca_qtna_note		kiw_meca_qtna_note
private boolean						ki_permetti_chiusura = false

private constant long	kki_width = 2050
private constant long	kki_height = 1600
end variables

forward prototypes
public subroutine u_retrieve ()
public subroutine set_permetti_chiusura (boolean a_permetti)
protected function string inizializza () throws uo_exception
protected function string aggiorna ()
protected subroutine open_start_window ()
protected function string cancella ()
protected subroutine attiva_menu ()
protected subroutine riempi_id ()
protected subroutine attiva_tasti_0 ()
end prototypes

public subroutine u_retrieve ();//
try
	kiuf_meca_qtna.u_retrieve_meca_qtna_note( )
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
end try
end subroutine

public subroutine set_permetti_chiusura (boolean a_permetti);ki_permetti_chiusura = true
end subroutine

protected function string inizializza () throws uo_exception;//
	
	u_retrieve( )
	
	dw_dett_0.visible = true
	
	attiva_tasti()
	
return "0"

end function

protected function string aggiorna ();//
//
pointer kp_oldpointer


try
	kp_oldpointer = SetPointer(HourGlass!)
	
	cb_aggiorna.enabled = false
	cb_ritorna.enabled = false
	
	dw_dett_0.accepttext( )
	kiuf_meca_qtna.set_conferma_note( true)
	kiuf_meca_qtna.u_scrivi_note()	
//	cb_ritorna.event clicked( )

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
finally
	cb_aggiorna.enabled = true
	cb_ritorna.enabled = true	
end try


return "0"
end function

protected subroutine open_start_window ();//
ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
kiuf_meca_qtna = ki_st_open_w.key12_any
kiw_meca_qtna_note = this
kiuf_meca_qtna.set_window(kiw_meca_qtna_note)
kiuf_meca_qtna.set_dw( dw_dett_0)
 
end subroutine

protected function string cancella ();
try
	SetPointer(kkg.pointer_attesa)
	
	if kiuf_meca_qtna.u_rimuovi_ok()	 then

		if messagebox("Rimozione QUARANTENA", "Sei sicuro di elminare Definitivamente la Quarantena", question!, yesno!, 2) = 1 then
			
			dw_dett_0.accepttext( )
			kiuf_meca_qtna.u_rimuovi()	
			cb_ritorna.event clicked( )
		else
			messagebox("Rimozione QUARANTENA", "Operazione Interrotta dall'utente", stopsign!)
		end if
	else
		messagebox("Rimozione QUARANTENA", "Operazione non possibile, Quarantena già movimentata", stopsign!)
	end if

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


return "0"
end function

protected subroutine attiva_menu ();//
	if ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Rimozione Completa della spedizione in Quarantena "
		ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Rimuove tutte le informazioni circa la spedizione in quarantena (apertura, chiusura , ecc...) "
		ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext =  "Rimuove,"+ ki_menu.m_finestra.m_gestione.m_fin_elimina.text
	end if

	super::attiva_menu( )


end subroutine

protected subroutine riempi_id ();//

end subroutine

protected subroutine attiva_tasti_0 ();//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()


cb_modifica.enabled = false
cb_inserisci.enabled = false

//=== Nr righe ne DW lista
if dw_dett_0.rowcount() = 0 then
	
	cb_cancella.enabled = false
	cb_aggiorna.enabled = false
	cb_aggiorna.default = false

else

	cb_cancella.enabled = true
	cb_aggiorna.enabled = true
	cb_aggiorna.default = true
end if
	
end subroutine

on w_meca_qtna_note.create
call super::create
end on

on w_meca_qtna_note.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;
//long k_gap


dw_dett_0.x = 1
dw_dett_0.y = 1

dw_dett_0.height = newheight - 1 //- cb_annulla.height - 100
dw_dett_0.width = newwidth - 1

//if sizetype = 2 then
//	k_gap = 130
//else
//	k_gap = 0
//end if

//cb_annulla.y = newheight - cb_annulla.height - 20 - k_gap 
//cb_conferma.y = cb_annulla.y
//cb_rimuove.y = cb_annulla.y
//cb_annulla.x = newwidth - 20 - cb_annulla.width
//cb_conferma.x = cb_conferma.width - 10 - cb_annulla.x
//cb_rimuove.x = dw_dett_0.x



end event

event closequery;call super::closequery;//if ki_permetti_chiusura = false then
//	try
//		ki_permetti_chiusura = true
//		kiuf_meca_qtna.u_close_window_note()
//	catch (uo_exception kuo_exception)
//		kuo_exception.messaggio_utente()
//	finally
//		return 1	
//	end try
//end if


 
end event

type st_ritorna from w_g_tab0`st_ritorna within w_meca_qtna_note
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_meca_qtna_note
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_meca_qtna_note
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_meca_qtna_note
integer x = 1390
integer y = 800
integer width = 402
integer height = 64
end type

type st_stampa from w_g_tab0`st_stampa within w_meca_qtna_note
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_meca_qtna_note
end type

type cb_modifica from w_g_tab0`cb_modifica within w_meca_qtna_note
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_meca_qtna_note
end type

type cb_cancella from w_g_tab0`cb_cancella within w_meca_qtna_note
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_meca_qtna_note
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_meca_qtna_note
integer x = 0
integer y = 324
boolean enabled = true
string dataobject = "d_meca_qtna_note"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_sort = false
end type

event dw_dett_0::resize;call super::resize;//
//this.modify("x_datins.y = '" + string(this.height - 100) + "' ") // long(this.describe("note.Height")) +  long(dw_dett_0.describe("note.y")) + 20) + "' ")
//this.modify("t_x_datins.y = x_datins.y")
//this.modify("x_utente.y = x_datins.y")

this.Modify("note.Width='"+ String(this.width - 100) +"' ")
this.Modify("note.Height='"+ String(long(this.describe("x_datins.y")) - long(this.describe("note.y") )  - 20) +"' ")

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_meca_qtna_note
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_meca_qtna_note
boolean enabled = false
end type

type dw_guida from w_g_tab0`dw_guida within w_meca_qtna_note
end type

