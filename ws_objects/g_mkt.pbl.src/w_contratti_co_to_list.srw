$PBExportHeader$w_contratti_co_to_list.srw
forward
global type w_contratti_co_to_list from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_contratti_co_to_list
end type
type rb_emissione_selezione from radiobutton within w_contratti_co_to_list
end type
type rb_definitiva_si from radiobutton within w_contratti_co_to_list
end type
type rb_definitiva_no from radiobutton within w_contratti_co_to_list
end type
type pb_ok from picturebutton within w_contratti_co_to_list
end type
type dw_documenti from uo_d_std_1 within w_contratti_co_to_list
end type
type st_1 from statictext within w_contratti_co_to_list
end type
type rb_stato_da_attivare from radiobutton within w_contratti_co_to_list
end type
type rb_stato_attivo from radiobutton within w_contratti_co_to_list
end type
type pb_st_esiti_operazioni from picturebutton within w_contratti_co_to_list
end type
type dw_esiti from uo_d_std_1 within w_contratti_co_to_list
end type
type st_esiti_operazioni from statictext within w_contratti_co_to_list
end type
type rb_occup_pedana_vincolata from radiobutton within w_contratti_co_to_list
end type
type rb_occup_pedana_precisa from radiobutton within w_contratti_co_to_list
end type
type rb_definitiva_manuale from radiobutton within w_contratti_co_to_list
end type
type gb_aggiorna from groupbox within w_contratti_co_to_list
end type
type gb_emissione from groupbox within w_contratti_co_to_list
end type
type gb_occup_pedana from groupbox within w_contratti_co_to_list
end type
type gb_produzione from groupbox within w_contratti_co_to_list
end type
type rr_1 from roundrectangle within w_contratti_co_to_list
end type
end forward

global type w_contratti_co_to_list from w_g_tab
integer width = 3602
integer height = 2740
string title = "Stampa Documenti di Vendita"
long backcolor = 67108864
string icon = "RunReport5!"
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva_si rb_definitiva_si
rb_definitiva_no rb_definitiva_no
pb_ok pb_ok
dw_documenti dw_documenti
st_1 st_1
rb_stato_da_attivare rb_stato_da_attivare
rb_stato_attivo rb_stato_attivo
pb_st_esiti_operazioni pb_st_esiti_operazioni
dw_esiti dw_esiti
st_esiti_operazioni st_esiti_operazioni
rb_occup_pedana_vincolata rb_occup_pedana_vincolata
rb_occup_pedana_precisa rb_occup_pedana_precisa
rb_definitiva_manuale rb_definitiva_manuale
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_occup_pedana gb_occup_pedana
gb_produzione gb_produzione
rr_1 rr_1
end type
global w_contratti_co_to_list w_contratti_co_to_list

type variables
//
private kuf_contratti_co kiuf_contratti_co
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
kuf_listino_cambio_prezzo kuf1_listino_cambio_prezzo
//ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa

kiuf_contratti_co = create kuf_contratti_co

dw_documenti.settransobject( sqlca )
dw_esiti.settransobject( sqlca )


try 
	setpointer(kkg.pointer_attesa)


//	pb_ok.picturename = kGuo_path.get_risorse() + "\printer.gif"


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
		"Toglie 'selezione' a tutti i documenti in elenco   "
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
		"Attiva 'selezione' a tutti i documenti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Seleziona,"+ &
												 ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "custom038!"
	////	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 2
	//	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	end if


//---
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
int k_importa = 0
date k_data_ini
st_tab_contratti_co kst_tab_contratti_co
kuf_listino kuf1_listino
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_documenti)
//
//	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		
		k_data_ini = date(0)
		if len(trim(ki_st_open_w.key1)) > 0 then 
			kst_tab_contratti_co.id_cliente = long(trim(ki_st_open_w.key1))
		else
			kst_tab_contratti_co.id_cliente = 0
		end if
		
		if dw_documenti.retrieve(k_data_ini, kst_tab_contratti_co.id_cliente) < 1 then
			k_return = "1Nessuna Contratto Commerciale da Importare "

			SetPointer(oldpointer)
			messagebox("Elenco Contratti Commerciali", &
					"Nessuna Contratto da Importare ")

		end if		
	end if

	if kst_tab_contratti_co.id_cliente > 0 then
		ki_win_titolo_orig = ki_win_titolo_orig_save
		ki_win_titolo_orig += " del Cliente " + string(kst_tab_contratti_co.id_cliente) 
		kiw_this_window.title = ki_win_titolo_orig
	end if

	attiva_tasti()

return k_return


end function

public function long esegui ();//
//--- lancia l'operazione di inserimento Conferme Ordine e Listini  da  Contratto Commerciale
//
long k_return = 0
long k_ctr=0, k_ctr_contratti_co=0, k_ctr_da_trasferire=0
st_contratti_co_to_listini kst_contratti_co_to_listini
st_tab_contratti_co kst_tab_contratti_co

	
	try 
		
//--- apri il LOG
		kiuf_contratti_co.log_inizializza( )

		
		if this.rb_definitiva_no.checked then // è di simulazione?
			kst_contratti_co_to_listini.k_simulazione = "S"
		else
			if this.rb_definitiva_si.checked then // è definitiva?
				kst_contratti_co_to_listini.k_simulazione = "N"  // crea CO e LISTINI in automatico
			else
				kst_contratti_co_to_listini.k_simulazione = "M"  // crea manualmente l'operatore il CO e LISTINI
			end if
		end if
		if this.rb_stato_attivo.checked then  // attiva subito il listino?
			kst_contratti_co_to_listini.k_subito_in_vigore = "S" 
		else
			kst_contratti_co_to_listini.k_subito_in_vigore = "N" 
		end if
		if this.rb_occup_pedana_precisa.checked then  // come calcolare l'occcupazione impianto?
			kst_contratti_co_to_listini.k_occup_pedana_precisa = "S" 
		else
			kst_contratti_co_to_listini.k_occup_pedana_precisa = "N" 
		end if

		if kst_contratti_co_to_listini.k_simulazione = "N" then
			k_ctr = messagebox("Operazione DEFINITIVA", "Proseguire con l'operazione di trasferimento dei Contratti?", Question!, yesno!, 2)
		else
			if kst_contratti_co_to_listini.k_simulazione = "M" then
				k_ctr = messagebox("Operazione DEFINITIVA", "Dovrai creare Conferma Ordine e Listini manualmente, sei sicuro di voler proseguire?", Question!, yesno!, 2)
			else
				k_ctr = 1  // simulazione non chiedo nulla
			end if
		end if

//--- se ho risposto OK 
		if k_ctr = 1 then
			for k_ctr = 1 to dw_documenti.rowcount( )
				
				if dw_documenti.getitemnumber(k_ctr, "sel") = 1 or rb_emissione_tutto.checked then
					
					k_ctr_da_trasferire ++
					
					kst_tab_contratti_co.id_contratto_co = dw_documenti.getitemnumber(k_ctr, "id_contratto_co")
	//--- LANCIA LA CONVERSIONE	
					k_return = kiuf_contratti_co.u_conv_to_conferma_ordine_e_listini( kst_tab_contratti_co, kst_contratti_co_to_listini)
					if k_return > 0 then
						
						k_ctr_contratti_co ++
					end if
				end if
			end for
	
			if kst_contratti_co_to_listini.k_simulazione = "S" then
				kguo_exception.setmessage("Fine Simulazione Trasferimento, visualizza l'esito nel Log")
				kguo_exception.messaggio_utente( )
			else
				if k_ctr_contratti_co > 0 then
					kguo_exception.setmessage("Contratti Commerciali 'Trasferiti': " + string(k_ctr_contratti_co) )
					kguo_exception.messaggio_utente( )
					
					inizializza( ) // rilegge l'elenco
				else
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
					if k_ctr_da_trasferire = 0 then
						kguo_exception.setmessage("Selezionare almeno un Contratto Commerciale da Trasferire")
					else
						kguo_exception.setmessage("Nessun Contratto Commerciale Trasferito")
					end if
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
		kiuf_contratti_co.log_destroy( )
		
		
	end try


return k_return


end function

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_ctco_to_listino, "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

on w_contratti_co_to_list.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva_si=create rb_definitiva_si
this.rb_definitiva_no=create rb_definitiva_no
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.st_1=create st_1
this.rb_stato_da_attivare=create rb_stato_da_attivare
this.rb_stato_attivo=create rb_stato_attivo
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.dw_esiti=create dw_esiti
this.st_esiti_operazioni=create st_esiti_operazioni
this.rb_occup_pedana_vincolata=create rb_occup_pedana_vincolata
this.rb_occup_pedana_precisa=create rb_occup_pedana_precisa
this.rb_definitiva_manuale=create rb_definitiva_manuale
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.gb_occup_pedana=create gb_occup_pedana
this.gb_produzione=create gb_produzione
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva_si
this.Control[iCurrent+4]=this.rb_definitiva_no
this.Control[iCurrent+5]=this.pb_ok
this.Control[iCurrent+6]=this.dw_documenti
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.rb_stato_da_attivare
this.Control[iCurrent+9]=this.rb_stato_attivo
this.Control[iCurrent+10]=this.pb_st_esiti_operazioni
this.Control[iCurrent+11]=this.dw_esiti
this.Control[iCurrent+12]=this.st_esiti_operazioni
this.Control[iCurrent+13]=this.rb_occup_pedana_vincolata
this.Control[iCurrent+14]=this.rb_occup_pedana_precisa
this.Control[iCurrent+15]=this.rb_definitiva_manuale
this.Control[iCurrent+16]=this.gb_aggiorna
this.Control[iCurrent+17]=this.gb_emissione
this.Control[iCurrent+18]=this.gb_occup_pedana
this.Control[iCurrent+19]=this.gb_produzione
this.Control[iCurrent+20]=this.rr_1
end on

on w_contratti_co_to_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva_si)
destroy(this.rb_definitiva_no)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.st_1)
destroy(this.rb_stato_da_attivare)
destroy(this.rb_stato_attivo)
destroy(this.pb_st_esiti_operazioni)
destroy(this.dw_esiti)
destroy(this.st_esiti_operazioni)
destroy(this.rb_occup_pedana_vincolata)
destroy(this.rb_occup_pedana_precisa)
destroy(this.rb_definitiva_manuale)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.gb_occup_pedana)
destroy(this.gb_produzione)
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
if isvalid(kiuf_contratti_co) then destroy 	kiuf_contratti_co

end event

event u_open_preliminari;call super::u_open_preliminari;kuf_listino_cambio_prezzo kuf1_listino_cambio_prezzo

try
//--- Attiva o meno in riquadro dello STATO del LISTINO
	kuf1_listino_cambio_prezzo = create kuf_listino_cambio_prezzo
	gb_produzione.enabled = kuf1_listino_cambio_prezzo.if_sicurezza(kkg_flag_modalita.modifica)
	rb_stato_da_attivare.enabled = gb_produzione.enabled 
	rb_stato_attivo.enabled = gb_produzione.enabled 
	
catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
	
end try


end event

event u_open;call super::u_open;//
u_resize()

end event

type st_ritorna from w_g_tab`st_ritorna within w_contratti_co_to_list
integer x = 2711
integer y = 2000
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_contratti_co_to_list
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_contratti_co_to_list
integer x = 2336
integer y = 1896
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_contratti_co_to_list
integer x = 2811
integer y = 1916
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_contratti_co_to_list
integer x = 2203
integer y = 2012
end type

type rb_emissione_tutto from radiobutton within w_contratti_co_to_list
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
string text = "Tutti i Contratti in elenco "
end type

type rb_emissione_selezione from radiobutton within w_contratti_co_to_list
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
string text = "Solo i Contratti con ~'Sel~' attivato"
boolean checked = true
end type

type rb_definitiva_si from radiobutton within w_contratti_co_to_list
integer x = 78
integer y = 1300
integer width = 1061
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 67108864
string text = "Definitivo (Aggiorna CO/Listini) "
end type

type rb_definitiva_no from radiobutton within w_contratti_co_to_list
integer x = 78
integer y = 1204
integer width = 850
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
string text = "Simulazione (scrive il LOG) "
boolean checked = true
end type

type pb_ok from picturebutton within w_contratti_co_to_list
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

type dw_documenti from uo_d_std_1 within w_contratti_co_to_list
boolean visible = true
integer x = 1184
integer width = 2354
integer height = 1864
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_contratti_co_l_x_conversione"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

type st_1 from statictext within w_contratti_co_to_list
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

type rb_stato_da_attivare from radiobutton within w_contratti_co_to_list
integer x = 91
integer y = 584
integer width = 617
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
boolean enabled = false
string text = "solo ~'da Attivare~' "
boolean checked = true
end type

type rb_stato_attivo from radiobutton within w_contratti_co_to_list
integer x = 91
integer y = 488
integer width = 576
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
boolean enabled = false
string text = "subito ~'in Vigore~'"
end type

type pb_st_esiti_operazioni from picturebutton within w_contratti_co_to_list
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

type dw_esiti from uo_d_std_1 within w_contratti_co_to_list
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

type st_esiti_operazioni from statictext within w_contratti_co_to_list
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

type rb_occup_pedana_vincolata from radiobutton within w_contratti_co_to_list
integer x = 91
integer y = 948
integer width = 923
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
string text = "arrotonda a 10%, 50%, 100%"
boolean checked = true
end type

type rb_occup_pedana_precisa from radiobutton within w_contratti_co_to_list
integer x = 91
integer y = 852
integer width = 553
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
string text = "calcolo ~'preciso~'"
end type

type rb_definitiva_manuale from radiobutton within w_contratti_co_to_list
integer x = 78
integer y = 1396
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
string text = "Definitivo ma NON Carica CO/Listini"
end type

type gb_aggiorna from groupbox within w_contratti_co_to_list
integer x = 27
integer y = 1116
integer width = 1125
integer height = 408
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = " Genera e Aggiorna "
end type

type gb_emissione from groupbox within w_contratti_co_to_list
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

type gb_occup_pedana from groupbox within w_contratti_co_to_list
integer x = 27
integer y = 756
integer width = 1125
integer height = 312
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Imposta Occupazione Impianto"
end type

type gb_produzione from groupbox within w_contratti_co_to_list
integer x = 27
integer y = 404
integer width = 1125
integer height = 312
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " Imposta Stato dei Listini "
end type

type rr_1 from roundrectangle within w_contratti_co_to_list
long linecolor = 8421504
long fillcolor = 134217731
integer x = 41
integer y = 1736
integer width = 1093
integer height = 12
integer cornerheight = 40
integer cornerwidth = 46
end type

