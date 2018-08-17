$PBExportHeader$w_armo_nt.srw
forward
global type w_armo_nt from w_g_tab0
end type
end forward

global type w_armo_nt from w_g_tab0
boolean visible = true
integer width = 3735
integer height = 720
string title = ""
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean ki_esponi_msg_dati_modificati = false
boolean ki_esponi_msg_dati_modificati_salvaauotom = true
boolean ki_sincronizza_window_consenti = false
boolean ki_exit_dopo_save_ok = true
boolean ki_reset_dopo_save_ok = false
end type
global w_armo_nt w_armo_nt

type variables
//
private kuf_armo_nt	 kiuf_armo_nt
//private w_meca_qtna_note		kiw_meca_qtna_note
private boolean ki_permetti_chiusura = false

private st_tab_armo_nt kist_tab_armo_nt

private constant long	kki_width = 3560
private constant long	kki_height = 790

private boolean ki_aggiorna = true

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine open_start_window ()
protected function string cancella ()
protected subroutine attiva_menu ()
public subroutine set_window_size ()
protected subroutine riempi_id ()
public function integer u_retrieve ()
protected function integer inserisci ()
protected function string aggiorna_tabelle ()
protected function string check_dati ()
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
end prototypes

protected function string inizializza () throws uo_exception;//
int k_notetrovate = 0

if kist_tab_armo_nt.id_armo > 0 then
	
	k_notetrovate = u_retrieve( )
	if k_notetrovate = -1 then  // uscire
		cb_ritorna.post event clicked( )
	else
		if k_notetrovate = 0 then  // NUOVO
			inserisci( )
		end if
		dw_dett_0.visible = true
		
		attiva_tasti()

	end if

else
	cb_ritorna.post event clicked( )
end if

return "0"

end function

protected subroutine open_start_window ();//
kiuf_armo_nt = create kuf_armo_nt
ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
//kiw_meca_qtna_note = this
//kiuf_meca_qtna.set_window(kiw_meca_qtna_note)
//kiuf_meca_qtna.set_dw( dw_dett_0)

 
if isNumber(ki_st_open_w.key1) then
	kist_tab_armo_nt.id_armo = long(ki_st_open_w.key1)
end if


end subroutine

protected function string cancella ();//
st_tab_armo_nt kst_tab_armo_nt

try
	SetPointer(kkg.pointer_attesa)
	
	kst_tab_armo_nt.id_armo = dw_dett_0.getitemnumber(1, "id_armo")
	if kst_tab_armo_nt.id_armo > 0 then
		
		if kiuf_armo_nt.if_rimozione_ok(kst_tab_armo_nt)	 then
	
			if messagebox("Rimozione NOTE", "Sei sicuro di elminare Definitivamente le Note dalla riga", question!, yesno!, 2) = 1 then
				
				kiuf_armo_nt.tb_delete(kst_tab_armo_nt)	
				cb_ritorna.event clicked( )
			else
				messagebox("Rimozione NOTE", "Operazione Interrotta dall'utente", stopsign!)
			end if
		else
			messagebox("Rimozione NOTE", "Operazione non possibile, Note lotto già movimentate", stopsign!)
		end if
	end if
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


return "0"
end function

protected subroutine attiva_menu ();////
//	super::attiva_menu( )
//
//	if ki_st_open_w.flag_primo_giro = 'S' then
//		ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Rimozione completa delle Note  "
//		ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Rimuove tutte le note circa la riga del lotto di entrata "
//		ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext =  "Rimuove,"+ ki_menu.m_finestra.m_gestione.m_fin_elimina.text
//	end if
//
end subroutine

public subroutine set_window_size ();////
//this.width = kki_width 
//this.height = kki_height 
//
end subroutine

protected subroutine riempi_id ();//
if dw_dett_0.rowcount( ) > 0 then
	if dw_dett_0.getitemnumber(1, "armo_nt_id_armo") > 0 then
	else
		dw_dett_0.setitem(1, "armo_nt_id_armo", dw_dett_0.getitemnumber(1, "id_armo"))
	end if
end if

end subroutine

public function integer u_retrieve ();//
int k_return = -1
int k_rc 

try
//	dw_dett_0.dataobject = "d_armo_nt"
//	k_rc = dw_dett_0.SetTransObject(kguo_sqlca_db_magazzino)
	k_return = dw_dett_0.retrieve(kist_tab_armo_nt.id_armo)
//	kiuf_meca_qtna.u_retrieve_meca_qtna_note( )
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
end try

return k_return

end function

protected function integer inserisci ();//

dw_dett_0.reset()
dw_dett_0.insertrow(0)
dw_dett_0.setitem(1, "armo_nt_id_armo", kist_tab_armo_nt.id_armo)


return 0

end function

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
int k_ctr=0
st_esito kst_esito
st_tab_armo_nt kst_tab_armo_nt

try
	
	if ki_aggiorna then
	
		setpointer(kkg.pointer_attesa)
		
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
		end if	
			
		kst_tab_armo_nt.id_armo = dw_dett_0.getitemnumber(1, "id_armo") 		
	//--- Aggiorna le NOTE 
		for k_ctr = 1 to 10
			kst_tab_armo_nt.note[k_ctr] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_" + string(k_ctr)))
		next
		kiuf_armo_nt.tb_update_armo_nt( kst_tab_armo_nt )

	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1Errore: " + kst_esito.sqlerrtext + " (" + string(kst_esito.sqlcode) + ")" 
	
finally
	setpointer(kkg.pointer_default)

end try

return k_return


end function

protected function string check_dati ();//
//--- nessun controllo
//
return '0'
end function

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

public subroutine u_resize_1 ();//
this.setredraw(false)

dw_dett_0.x = 1
dw_dett_0.y = 1

this.height = dw_dett_0.height * 1.15
this.width = dw_dett_0.width 
//dw_dett_0.height = this.height - 1 //- cb_annulla.height - 100
//dw_dett_0.width = this.width - 1

this.setredraw(true)

end subroutine

on w_armo_nt.create
call super::create
end on

on w_armo_nt.destroy
call super::destroy
end on

type st_ritorna from w_g_tab0`st_ritorna within w_armo_nt
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_armo_nt
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_armo_nt
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_armo_nt
integer x = 1390
integer y = 800
integer width = 402
integer height = 64
end type

type st_stampa from w_g_tab0`st_stampa within w_armo_nt
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_armo_nt
end type

type cb_modifica from w_g_tab0`cb_modifica within w_armo_nt
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_armo_nt
end type

type cb_cancella from w_g_tab0`cb_cancella within w_armo_nt
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_armo_nt
integer x = 2752
integer y = 568
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_armo_nt
integer x = 14
integer y = 12
integer width = 3511
integer height = 632
boolean enabled = true
string dataobject = "d_armo_nt"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::buttonclicked;call super::buttonclicked;//
if dwo.name = "b_abbandona" then
	ki_aggiorna = false
	cb_ritorna.event clicked( )
end if
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_armo_nt
integer x = 27
integer y = 744
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_armo_nt
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_armo_nt
integer x = 1147
integer y = 724
end type

