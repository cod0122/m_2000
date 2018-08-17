$PBExportHeader$w_meca_chiude.srw
forward
global type w_meca_chiude from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_meca_chiude
end type
type rb_emissione_selezione from radiobutton within w_meca_chiude
end type
type rb_definitiva_no from radiobutton within w_meca_chiude
end type
type pb_ok from picturebutton within w_meca_chiude
end type
type dw_documenti from uo_d_std_1 within w_meca_chiude
end type
type st_pb_ok from statictext within w_meca_chiude
end type
type pb_st_esiti_operazioni from picturebutton within w_meca_chiude
end type
type dw_esiti from uo_d_std_1 within w_meca_chiude
end type
type st_esiti_operazioni from statictext within w_meca_chiude
end type
type rb_definitiva_si from radiobutton within w_meca_chiude
end type
type gb_aggiorna from groupbox within w_meca_chiude
end type
type gb_emissione from groupbox within w_meca_chiude
end type
type rr_1 from roundrectangle within w_meca_chiude
end type
end forward

global type w_meca_chiude from w_g_tab
boolean visible = true
integer width = 3602
integer height = 2740
string title = " "
long backcolor = 67108864
string icon = "AppRectangle!"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva_no rb_definitiva_no
pb_ok pb_ok
dw_documenti dw_documenti
st_pb_ok st_pb_ok
pb_st_esiti_operazioni pb_st_esiti_operazioni
dw_esiti dw_esiti
st_esiti_operazioni st_esiti_operazioni
rb_definitiva_si rb_definitiva_si
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
rr_1 rr_1
end type
global w_meca_chiude w_meca_chiude

type variables
//
private kuf_meca_chiudi kiuf_meca_chiudi
private string ki_win_titolo_orig_save=""

end variables

forward prototypes
protected subroutine open_start_window ()
protected subroutine u_personalizza_dw ()
protected subroutine attiva_menu ()
protected subroutine u_seleziona_tutti ()
protected subroutine u_deseleziona_tutti ()
protected subroutine smista_funz (string k_par_in)
protected function string inizializza () throws uo_exception
public function long esegui ()
public subroutine elenco_esiti (boolean k_visibile)
end prototypes

protected subroutine open_start_window ();//---
//
kiuf_meca_chiudi = create kuf_meca_chiudi

dw_documenti.settransobject( sqlca )
dw_esiti.settransobject( sqlca )


try 
	setpointer(kkg.pointer_attesa)

	st_aggiorna_lista.enabled = true
	st_ordina_lista.enabled = true  // attiva FILTRO 
	kidw_selezionata = dw_documenti // DW su cui fare il filtro
	kiw_this_window.kigrf_x_trova = dw_documenti	// DW su cui fare il Trova

//--- lancia la retrieve!
	inizializza( )

////--- pone i link nel dw
//	u_personalizza_dw()
//
//	dw_documenti.setfocus()
//
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		setpointer(kkg.pointer_default)	
		
end try


end subroutine

protected subroutine u_personalizza_dw ();//---
//--- Personalizza DW
//---

	dw_documenti.ki_flag_modalita = ki_st_open_w.flag_modalita 
	dw_documenti.event u_personalizza_dw()
	



end subroutine

protected subroutine attiva_menu ();//	


	if not ki_menu.m_strumenti.m_fin_gest_libero3.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Togli Selezione a tutti "
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
		"Toglie 'selezione' a tutti i Lotti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Deseleziona,"+ &
												 ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "custom080!"
	////	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex = 2
	//	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if
//	
	if not ki_menu.m_strumenti.m_fin_gest_libero4.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Attiva Selezione a tutti "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
		"Attiva 'selezione' a tutti i Lotti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Seleziona,"+ &
												 ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "custom038!"
	////	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
	//	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	end if

	super::attiva_menu()

end subroutine

protected subroutine u_seleziona_tutti ();//
//--- Seleziona tutti i record del dw: dw_documenti
//
long k_ctr


for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.object.sel[k_ctr] = 1		
	
next




end subroutine

protected subroutine u_deseleziona_tutti ();//
//--- Deseleziona tutti i record del dw: dw_documenti
//
long k_ctr


for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.object.sel[k_ctr] = 0		
	
next




end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.libero3		//Togli Selezione
		this.u_deseleziona_tutti( )

	case KKG_FLAG_RICHIESTA.libero4		//Metti Selezione
		this.u_seleziona_tutti( )


	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
		try
			inizializza()
		catch (uo_exception kuo_exception)
			dw_documenti.reset()
		end try

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
date k_data_fino

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	k_data_fino = relativedate(kguo_g.get_dataoggi( ), -7)  // mostra solo fino a 7 gg prima 
		
	if dw_documenti.retrieve(k_data_fino) < 1 then
		k_return = "1Nessuna Lotto da Chiudere "

		SetPointer(kkg.pointer_default )
		messagebox("Elenco Lotti Spediti", &
				"Nessuna Lotto trovato")

		pb_ok.enabled = false
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			pb_ok.enabled = true
		else
			pb_ok.enabled = false
		end if
	end if		
	st_pb_ok.enabled = pb_ok.enabled 

	if k_data_fino > date(0) then
		ki_win_titolo_orig = ki_win_titolo_orig_save
		ki_win_titolo_orig += " fino al " + string(k_data_fino, "dd mmm yy") 
		kiw_this_window.title = ki_win_titolo_orig
	end if

	attiva_tasti()

return k_return


end function

public function long esegui ();//
//--- lancia l'operazione di inserimento Conferme Ordine e Listini  da  Contratto Commerciale
//
long k_return = 0
long k_ctr=0, k_ctr_lotti_chiusi
st_meca_chiudi kst_meca_chiudi
st_tab_meca kst_tab_meca
datastore kds_1

	
	try 
		
//--- apri il LOG
		kiuf_meca_chiudi.log_inizializza( ) 

		if this.rb_definitiva_no.checked then // è di simulazione?
			kst_meca_chiudi.k_simulazione = "S"
		else
			if this.rb_definitiva_si.checked then // è definitiva?
				kst_meca_chiudi.k_simulazione = "N"  // crea CO e LISTINI in automatico
			else
				kst_meca_chiudi.k_simulazione = "M"  // crea manualmente l'operatore il CO e LISTINI
			end if
		end if

		if kst_meca_chiudi.k_simulazione = "N" then
			k_ctr = messagebox("Operazione DEFINITIVA", "Proseguire con l'operazione di Chiusura dei Lotti Massiva?", Question!, yesno!, 2)
		else
			k_ctr = 1  // simulazione non chiedo nulla
		end if

		if rb_emissione_tutto.checked then
			kst_meca_chiudi.k_tutto = true
		else
			kst_meca_chiudi.k_tutto = false
		end if
		
//--- se ho risposto OK 
		if k_ctr = 1 then
			
			kds_1 = create datastore
			kds_1.dataobject = dw_documenti.dataobject
			kds_1.settransobject(kguo_sqlca_db_magazzino)
			dw_documenti.rowscopy( 1, dw_documenti.rowcount( ), primary!, kds_1, 1, primary!)
			
	//--- LANCIA LA CONVERSIONE	
			k_ctr_lotti_chiusi = kiuf_meca_chiudi.u_chiudi( kds_1, kst_meca_chiudi)
			if k_ctr_lotti_chiusi > 0 then
				
				setpointer(kkg.pointer_attesa)
				
				k_return = k_ctr_lotti_chiusi 
				dw_documenti.reset( )
				kds_1.rowscopy( 1, kds_1.rowcount( ), primary!, dw_documenti, 1, primary!)
				
				setpointer(kkg.pointer_default)
				
			end if
	
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
			if kst_meca_chiudi.k_simulazione = "S" then
				if k_ctr_lotti_chiusi > 0 then
					kguo_exception.setmessage("Fine Simulazione di Chiusura Lotti Massiva, visualizza l'esito nel Log")
					kguo_exception.messaggio_utente( )
				else
					kguo_exception.setmessage("Fine Simulazione ma nessun Lotto da Chiudere, visualizza l'esito nel Log")
					kguo_exception.messaggio_utente( )
				end if
			else
				if k_ctr_lotti_chiusi > 0 then
					kguo_exception.setmessage("Numero Lotti Chiusi: " + string(k_ctr_lotti_chiusi) )
					kguo_exception.messaggio_utente( )
					
//					inizializza( ) // rilegge l'elenco
				else
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
					kguo_exception.setmessage("Selezionare almeno un Lotto da Chiudere")
					kguo_exception.messaggio_utente( )
					
				end if
			end if
		else
			kguo_exception.setmessage("Operazione interrotta dall'utente")
			kguo_exception.messaggio_utente( )
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		kiuf_meca_chiudi.log_destroy( )
		if isvalid(kds_1) then destroy kds_1
		
		
	end try


return k_return


end function

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_meca_chiusura, "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

on w_meca_chiude.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva_no=create rb_definitiva_no
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.st_pb_ok=create st_pb_ok
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.dw_esiti=create dw_esiti
this.st_esiti_operazioni=create st_esiti_operazioni
this.rb_definitiva_si=create rb_definitiva_si
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva_no
this.Control[iCurrent+4]=this.pb_ok
this.Control[iCurrent+5]=this.dw_documenti
this.Control[iCurrent+6]=this.st_pb_ok
this.Control[iCurrent+7]=this.pb_st_esiti_operazioni
this.Control[iCurrent+8]=this.dw_esiti
this.Control[iCurrent+9]=this.st_esiti_operazioni
this.Control[iCurrent+10]=this.rb_definitiva_si
this.Control[iCurrent+11]=this.gb_aggiorna
this.Control[iCurrent+12]=this.gb_emissione
this.Control[iCurrent+13]=this.rr_1
end on

on w_meca_chiude.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva_no)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.st_pb_ok)
destroy(this.pb_st_esiti_operazioni)
destroy(this.dw_esiti)
destroy(this.st_esiti_operazioni)
destroy(this.rb_definitiva_si)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.rr_1)
end on

event resize;call super::resize;//
this.setredraw(false) 
dw_documenti.x = gb_emissione.x + gb_emissione.width + 20 
dw_documenti.y = 0
//if this.width >  dw_documenti.x + 100 then
	dw_documenti.width = this.width - gb_emissione.width  - 140
//end if
if dw_documenti.width < 0 then
	dw_documenti.width = 100
end if
dw_documenti.height = this.height - dw_documenti.y - 150


this.setredraw(true) 



end event

event close;call super::close;//
if isvalid(kiuf_meca_chiudi) then destroy kiuf_meca_chiudi

end event

event open;call super::open;//
ki_win_titolo_orig_save = ki_win_titolo_orig
end event

type st_ritorna from w_g_tab`st_ritorna within w_meca_chiude
integer x = 2711
integer y = 2000
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_meca_chiude
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_meca_chiude
integer x = 2336
integer y = 1896
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_meca_chiude
integer x = 2811
integer y = 1916
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_meca_chiude
integer x = 2203
integer y = 2012
end type

type rb_emissione_tutto from radiobutton within w_meca_chiude
integer x = 96
integer y = 148
integer width = 791
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti i Lotti in elenco "
end type

type rb_emissione_selezione from radiobutton within w_meca_chiude
integer x = 96
integer y = 240
integer width = 974
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo i Lotti Selezionati"
boolean checked = true
end type

type rb_definitiva_no from radiobutton within w_meca_chiude
integer x = 78
integer y = 608
integer width = 955
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Simulazione (scrive il LOG) "
boolean checked = true
end type

type pb_ok from picturebutton within w_meca_chiude
integer x = 69
integer y = 1568
integer width = 128
integer height = 116
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRNext!"
vtextalign vtextalign = top!
end type

event clicked;//
this.enabled = false

esegui() 

this.enabled = true


end event

type dw_documenti from uo_d_std_1 within w_meca_chiude
boolean visible = true
integer x = 1184
integer width = 2354
integer height = 1864
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_meca_dachiudere_l"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

type st_pb_ok from statictext within w_meca_chiude
integer x = 229
integer y = 1612
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Esegui operazione"
boolean focusrectangle = false
end type

type pb_st_esiti_operazioni from picturebutton within w_meca_chiude
integer x = 69
integer y = 1800
integer width = 128
integer height = 116
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "BrowseClasses!"
vtextalign vtextalign = top!
boolean map3dcolors = true
string powertiptext = "Visualizza Log degli estiti "
end type

event clicked;//
this.enabled = false

if dw_esiti.visible then
	elenco_esiti(false )
	st_esiti_operazioni.text = "Mostra Log Esiti Operazioni   "
else
	elenco_esiti(true )
	st_esiti_operazioni.text = "Nascondi Log                       "
end if

this.enabled = true


end event

type dw_esiti from uo_d_std_1 within w_meca_chiude
integer x = 1317
integer y = 560
integer width = 2176
integer height = 948
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_esito_operazioni_l"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

event ue_visibile;call super::ue_visibile;//
//--- dw_esiti stessa dimensione / posizione della dw_documenti
if k_visibile then
	dw_esiti.x = dw_documenti.x
	dw_esiti.y = dw_documenti.y
	dw_esiti.height = dw_documenti.height
	dw_esiti.width = dw_documenti.width
	dw_esiti.visible = true
else
	dw_esiti.visible = false
end if

end event

type st_esiti_operazioni from statictext within w_meca_chiude
integer x = 215
integer y = 1832
integer width = 855
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostra Log degli ultimi 30 giorni"
boolean focusrectangle = false
end type

type rb_definitiva_si from radiobutton within w_meca_chiude
integer x = 78
integer y = 724
integer width = 1051
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Definitivo (Aggiorna Archivio)"
end type

type gb_aggiorna from groupbox within w_meca_chiude
integer x = 27
integer y = 500
integer width = 1125
integer height = 364
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = " Chiude i Lotti"
end type

type gb_emissione from groupbox within w_meca_chiude
integer x = 27
integer y = 52
integer width = 1125
integer height = 312
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "  Opera su "
end type

type rr_1 from roundrectangle within w_meca_chiude
long linecolor = 8421504
long fillcolor = 134217731
integer x = 41
integer y = 1736
integer width = 1093
integer height = 12
integer cornerheight = 40
integer cornerwidth = 46
end type

