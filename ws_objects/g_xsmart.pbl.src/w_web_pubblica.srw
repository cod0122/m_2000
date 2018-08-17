$PBExportHeader$w_web_pubblica.srw
forward
global type w_web_pubblica from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_web_pubblica
end type
type rb_emissione_selezione from radiobutton within w_web_pubblica
end type
type rb_definitiva_si_aggiorna_no from radiobutton within w_web_pubblica
end type
type pb_ok from picturebutton within w_web_pubblica
end type
type dw_documenti from uo_d_std_1 within w_web_pubblica
end type
type st_1 from statictext within w_web_pubblica
end type
type rb_ruoli_no from radiobutton within w_web_pubblica
end type
type rb_ruoli_si from radiobutton within w_web_pubblica
end type
type pb_st_esiti_operazioni from picturebutton within w_web_pubblica
end type
type dw_esiti from uo_d_std_1 within w_web_pubblica
end type
type st_esiti_operazioni from statictext within w_web_pubblica
end type
type rb_definitiva_si_aggiorna_si from radiobutton within w_web_pubblica
end type
type gb_aggiorna from groupbox within w_web_pubblica
end type
type gb_emissione from groupbox within w_web_pubblica
end type
type gb_produzione from groupbox within w_web_pubblica
end type
type rr_1 from roundrectangle within w_web_pubblica
end type
end forward

global type w_web_pubblica from w_g_tab
integer width = 3602
integer height = 2740
string title = "Pubblica Utenti Web"
long backcolor = 67108864
string icon = "RunReport5!"
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva_si_aggiorna_no rb_definitiva_si_aggiorna_no
pb_ok pb_ok
dw_documenti dw_documenti
st_1 st_1
rb_ruoli_no rb_ruoli_no
rb_ruoli_si rb_ruoli_si
pb_st_esiti_operazioni pb_st_esiti_operazioni
dw_esiti dw_esiti
st_esiti_operazioni st_esiti_operazioni
rb_definitiva_si_aggiorna_si rb_definitiva_si_aggiorna_si
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_produzione gb_produzione
rr_1 rr_1
end type
global w_web_pubblica w_web_pubblica

type variables
//
private kuf_web_utenti kiuf_web_utenti
private kuf_web_ruoli kiuf_web_ruoli
private kuf_web_folder kiuf_web_folder
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
pointer kpointer_orig
//ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa

kiuf_web_utenti = create kuf_web_utenti
kiuf_web_ruoli = create kuf_web_ruoli
kiuf_web_folder = create kuf_web_folder

dw_documenti.settransobject( sqlca )
dw_esiti.settransobject( sqlca )


try 
	
	kpointer_orig = setpointer(hourglass!)
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
		setpointer(kpointer_orig)	
		
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
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Toglie 'selezione' a tutti i documenti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Deseleziona,"+  ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "custom080!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if
//	
	if not ki_menu.m_strumenti.m_fin_gest_libero4.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Attiva Selezione a tutti "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Attiva 'selezione' a tutti i documenti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Seleziona,"+ ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "custom038!"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = true
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
			k_return = "1Nessuna Utente da Pubblicare "

			SetPointer(oldpointer)
			messagebox("Elenco Utenti", &
					"Nessun Utente da Pubblicare ")

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
long k_ctr=0, k_ctr_ruoli=0, k_ctr_utenti=0, k_ctr_folder=0
string k_msg=""
st_esito kst_esito
st_web_pubblica kst_web_pubblica
st_tab_web_utenti kst_tab_web_utenti[]

	
	try 
		
//--- apri il LOG
		kiuf_web_utenti.log_inizializza( )

		
//--- Aggiorna Utenti?
		if this.rb_definitiva_si_aggiorna_si.checked then 
			kst_web_pubblica.k_aggiorna_web_utenti = true
			k_msg = "'Pubblicazione' e Aggiornamento  Utenti  per il Web. "
		else
			kst_web_pubblica.k_aggiorna_web_utenti = false
			k_msg = "'Pubblica' ma NON aggiorna gli  'Utenti'. "
		end if

//--- Pubblica anche le altre tabelle?		
		if this.rb_ruoli_si.checked then  
			kst_web_pubblica.k_pubblica_web_ruoli = true
			kst_web_pubblica.k_pubblica_web_folder = true
			k_msg += "Pubblicazione anche dei  'Ruoli'  e dei  'Codici Cartelle di accesso ai Documenti'  (Folder).  "
		else
			kst_web_pubblica.k_pubblica_web_ruoli = false
			kst_web_pubblica.k_pubblica_web_folder = false
			k_msg += "Pubblicazione dei soli  'Utenti'.  "
		end if
		

		k_ctr = messagebox("Operazione di Pubblicazione", k_msg + "Eseguire l'operazione?", Question!, yesno!, 2)


//--- se ho risposto OK 
		if k_ctr = 1 then
			
//--- aggiunge riga al log
			kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("-----------> Inizio Pubblicazione Utenti: " + trim(k_msg) + "<-----------", false)
		
			k_ctr_utenti = 0
			for k_ctr = 1 to dw_documenti.rowcount( )
				
				if dw_documenti.getitemnumber(k_ctr, "sel") = 1 or rb_emissione_tutto.checked then
					
					k_ctr_utenti ++
					
					kst_tab_web_utenti[k_ctr_utenti].idutente = dw_documenti.getitemnumber(k_ctr, "idutente")
					
				end if
			end for
			
//--- LANCIA LA COPIA DEGLI UTENTI NELLA TAB ESTERNA
			if k_ctr_utenti > 0 then
				
//--- aggiunge riga al log
				kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nr Utenti da Pubblicare: " + string(k_ctr_utenti) + " ", false)
				
//--- Pubblica UTENTI
				k_ctr_utenti = kiuf_web_utenti.u_web_pubblica( kst_tab_web_utenti[], kst_web_pubblica)
				if k_ctr_utenti > 0 then
						
					kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nr Utenti Pubblicati: " + string(k_ctr_utenti) + " ", false)  // aggiunge riga al log

//--- Pubblica RUOLI					
					if kst_web_pubblica.k_pubblica_web_ruoli then
						
						k_ctr_ruoli = kiuf_web_ruoli.u_web_pubblica()
						if k_ctr_ruoli > 0 then
							kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nr Ruoli Pubblicati: " + string(k_ctr_ruoli) + " ", false) // aggiunge riga al log
						else
							kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nessun Ruolo Pubblicato", true) // aggiunge riga al log
						end if
					end if
//--- Pubblica FOLDER					
					if kst_web_pubblica.k_pubblica_web_folder then
						
						k_ctr_folder = kiuf_web_folder.u_web_pubblica()
						if k_ctr_folder > 0 then
							kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nr codici Cartella (folder) Pubblicati: " + string(k_ctr_folder ) + " ", false) // aggiunge riga al log
						else
							kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nessun codice Cartella (folder) Pubblicato", true) // aggiunge riga al log
						end if
					end if 
					
					if not kst_web_pubblica.k_aggiorna_web_utenti then
						kguo_exception.setmessage("Utenti Pubblicati " + string(k_ctr_utenti) + ", visualizza l'esito dal Log")
					else
						kguo_exception.setmessage("Utenti Aggiornati e Pubblicati " + string(k_ctr_utenti) + ", visualizza l'esito dal Log")
					end if					
					kguo_exception.messaggio_utente( )
		
					inizializza( ) // rilegge l'elenco
					
				else
					
//--- aggiunge riga al log
					kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Nessun Utente Pubblicato ", false)
					kguo_exception.setmessage("Nessun Utente Pubblicato")
					kguo_exception.messaggio_utente( )
				end if
					
			else
				
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
				if k_ctr_utenti = 0 then
					kguo_exception.setmessage("Selezionare almeno un Utente dall'elenco")
					kguo_exception.messaggio_utente( )
					
				end if
			end if
		else
			kguo_exception.setmessage("Operazione annullata dall'utente")
			kguo_exception.messaggio_utente( )
		end if		

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("Operazione in errore: " + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext), TRUE)
		kuo_exception.messaggio_utente()

	finally
//--- aggiunge riga al log
		kiuf_web_utenti.kiuf_esito_operazioni.tb_add_riga("-----------> Fine operazione, pubblicazione Utenti terminata <----------- ", false)
		kiuf_web_utenti.log_destroy( )
		
		
	end try


return k_return


end function

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_pubblica_web_utenti , "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

on w_web_pubblica.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva_si_aggiorna_no=create rb_definitiva_si_aggiorna_no
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.st_1=create st_1
this.rb_ruoli_no=create rb_ruoli_no
this.rb_ruoli_si=create rb_ruoli_si
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.dw_esiti=create dw_esiti
this.st_esiti_operazioni=create st_esiti_operazioni
this.rb_definitiva_si_aggiorna_si=create rb_definitiva_si_aggiorna_si
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.gb_produzione=create gb_produzione
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva_si_aggiorna_no
this.Control[iCurrent+4]=this.pb_ok
this.Control[iCurrent+5]=this.dw_documenti
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.rb_ruoli_no
this.Control[iCurrent+8]=this.rb_ruoli_si
this.Control[iCurrent+9]=this.pb_st_esiti_operazioni
this.Control[iCurrent+10]=this.dw_esiti
this.Control[iCurrent+11]=this.st_esiti_operazioni
this.Control[iCurrent+12]=this.rb_definitiva_si_aggiorna_si
this.Control[iCurrent+13]=this.gb_aggiorna
this.Control[iCurrent+14]=this.gb_emissione
this.Control[iCurrent+15]=this.gb_produzione
this.Control[iCurrent+16]=this.rr_1
end on

on w_web_pubblica.destroy
call super::destroy
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva_si_aggiorna_no)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.st_1)
destroy(this.rb_ruoli_no)
destroy(this.rb_ruoli_si)
destroy(this.pb_st_esiti_operazioni)
destroy(this.dw_esiti)
destroy(this.st_esiti_operazioni)
destroy(this.rb_definitiva_si_aggiorna_si)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
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
if isvalid(kiuf_web_utenti) then destroy 	kiuf_web_utenti
if isvalid(kiuf_web_ruoli) then destroy 	kiuf_web_ruoli
if isvalid(kiuf_web_folder) then destroy 	kiuf_web_folder

end event

type st_ritorna from w_g_tab`st_ritorna within w_web_pubblica
integer x = 2711
integer y = 2000
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_web_pubblica
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_web_pubblica
integer x = 2336
integer y = 1896
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_web_pubblica
integer x = 2811
integer y = 1916
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_web_pubblica
integer x = 2203
integer y = 2012
end type

type rb_emissione_tutto from radiobutton within w_web_pubblica
integer x = 96
integer y = 172
integer width = 1042
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
string text = "Tutti gli Utenti in elenco "
boolean checked = true
end type

type rb_emissione_selezione from radiobutton within w_web_pubblica
integer x = 96
integer y = 292
integer width = 1042
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
boolean enabled = false
string text = "Solo gli Utenti con ~'Sel~' attivato"
end type

type rb_definitiva_si_aggiorna_no from radiobutton within w_web_pubblica
integer x = 82
integer y = 1112
integer width = 901
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Pubblica senza aggiornamento"
boolean checked = true
end type

type pb_ok from picturebutton within w_web_pubblica
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

type dw_documenti from uo_d_std_1 within w_web_pubblica
boolean visible = true
integer x = 1184
integer width = 2354
integer height = 1864
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_web_utenti_x_pubblicare"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

type st_1 from statictext within w_web_pubblica
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

type rb_ruoli_no from radiobutton within w_web_pubblica
integer x = 91
integer y = 764
integer width = 1042
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
string text = "niente (solo dati Utenti)"
boolean checked = true
end type

type rb_ruoli_si from radiobutton within w_web_pubblica
integer x = 91
integer y = 632
integer width = 1029
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
string text = "Ruoli e cod. Accesso alle Cartelle "
end type

type pb_st_esiti_operazioni from picturebutton within w_web_pubblica
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
	st_esiti_operazioni.text = "Mostra Log Esiti Operazioni     "
else
	elenco_esiti(true )
	st_esiti_operazioni.text = "Nascondi Log                       "
end if

this.enabled = true


end event

type dw_esiti from uo_d_std_1 within w_web_pubblica
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

type st_esiti_operazioni from statictext within w_web_pubblica
integer x = 229
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

type rb_definitiva_si_aggiorna_si from radiobutton within w_web_pubblica
integer x = 78
integer y = 1188
integer width = 1051
integer height = 164
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
string text = "Pubblica e Aggiorna Utenti"
end type

type gb_aggiorna from groupbox within w_web_pubblica
integer x = 27
integer y = 992
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
string text = " Pubblica e Aggiorna "
end type

type gb_emissione from groupbox within w_web_pubblica
integer x = 27
integer y = 64
integer width = 1125
integer height = 408
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Pubblica Utenti "
end type

type gb_produzione from groupbox within w_web_pubblica
integer x = 27
integer y = 524
integer width = 1125
integer height = 408
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Pubblicare anche ... "
end type

type rr_1 from roundrectangle within w_web_pubblica
long linecolor = 8421504
long fillcolor = 134217731
integer x = 41
integer y = 1736
integer width = 1093
integer height = 12
integer cornerheight = 40
integer cornerwidth = 46
end type

