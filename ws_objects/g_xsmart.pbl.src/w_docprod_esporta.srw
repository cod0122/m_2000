$PBExportHeader$w_docprod_esporta.srw
forward
global type w_docprod_esporta from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_docprod_esporta
end type
type rb_emissione_selezione from radiobutton within w_docprod_esporta
end type
type rb_definitiva_si_aggiorna_no from radiobutton within w_docprod_esporta
end type
type pb_ok from picturebutton within w_docprod_esporta
end type
type dw_documenti from uo_d_std_1 within w_docprod_esporta
end type
type st_pb_ok from statictext within w_docprod_esporta
end type
type pb_st_esiti_operazioni from picturebutton within w_docprod_esporta
end type
type dw_esiti from uo_d_std_1 within w_docprod_esporta
end type
type st_esiti_operazioni from statictext within w_docprod_esporta
end type
type rb_definitiva_si_aggiorna_si from radiobutton within w_docprod_esporta
end type
type gb_aggiorna from groupbox within w_docprod_esporta
end type
type gb_emissione from groupbox within w_docprod_esporta
end type
type rr_separa from roundrectangle within w_docprod_esporta
end type
end forward

global type w_docprod_esporta from w_g_tab
integer width = 3602
integer height = 2740
string title = "Esporta Documenti"
long backcolor = 67108864
string icon = "RunReport5!"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva_si_aggiorna_no rb_definitiva_si_aggiorna_no
pb_ok pb_ok
dw_documenti dw_documenti
st_pb_ok st_pb_ok
pb_st_esiti_operazioni pb_st_esiti_operazioni
dw_esiti dw_esiti
st_esiti_operazioni st_esiti_operazioni
rb_definitiva_si_aggiorna_si rb_definitiva_si_aggiorna_si
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
rr_separa rr_separa
end type
global w_docprod_esporta w_docprod_esporta

type variables
//
private kuf_docprod kiuf_docprod
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
public subroutine u_visualizza_scelta ()
end prototypes

protected subroutine open_start_window ();//---
//
pointer kpointer_orig
//ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa

kiuf_docprod = create kuf_docprod

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
//---
	super::attiva_menu()



end subroutine

protected subroutine u_seleziona_tutti ();//
//--- Seleziona tutti i record del dw: dw_documenti
//
long k_ctr

setpointer(kkg.pointer_attesa)
for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.object.sel[k_ctr] = 1		
	
next




end subroutine

protected subroutine u_deseleziona_tutti ();//
//--- Deseleziona tutti i record del dw: dw_documenti
//
long k_ctr


setpointer(kkg.pointer_attesa)

//dw_documenti.object.sel.Primary[1, dw_documenti.rowcount( )] = 0	

for k_ctr = 1 to dw_documenti.rowcount( )
	
	dw_documenti.setitem(k_ctr,"sel", 0)		
	
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
string k_tipo=""
int k_importa = 0
date k_data_ini
st_tab_docprod kst_tab_docprod
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
		
//--- primo argomanto il TIPO: Fattura, Bolle, Attestati etc...
		if len(trim(ki_st_open_w.key1)) > 0 then 
			k_tipo = trim(ki_st_open_w.key1)
		else
			k_tipo = "F"
		end if
//--- secondo argomanto data Esportazione: timestamp
		if len(trim(ki_st_open_w.key2)) > 0 then 
			kst_tab_docprod.esportato_ts = datetime(trim(ki_st_open_w.key2))
		else
			kst_tab_docprod.esportato_ts = datetime(date(0))
		end if
//--- Terzo argomento il codice Cliente 
		if len(trim(ki_st_open_w.key3)) > 0 then 
			kst_tab_docprod.id_cliente = long(trim(ki_st_open_w.key3)) 
		else
			kst_tab_docprod.id_cliente = 0 
		end if
		
		if dw_documenti.retrieve(k_tipo, "S", kst_tab_docprod.esportato_ts, kst_tab_docprod.id_cliente) < 1 then
			k_return = "1Nessun Documento da Esportare "

			SetPointer(oldpointer)
			messagebox("Elenco Documenti", 	"Nessuna Documento da Esportare ")

		end if		
	end if

	if kst_tab_docprod.id_cliente > 0 then
		ki_win_titolo_orig = ki_win_titolo_orig_save
		ki_win_titolo_orig += " del Cliente " + string(kst_tab_docprod.id_cliente) 
		kiw_this_window.title = ki_win_titolo_orig
	end if

	attiva_tasti()

return k_return


end function

public function long esegui ();//
//--- lancia l'operazione di inserimento Conferme Ordine e Listini  da  Contratto Commerciale
//
long k_return = 0
long k_ctr=0, k_ctr_ruoli=0, k_ctr_Documenti=0, k_ctr_folder=0
string k_msg="", k_tipo=""
st_esito kst_esito
st_docprod_esporta kst_docprod_esporta
kuf_doctipo kuf1_doctipo
pointer k_pointer
	
	try 
		
		k_pointer = setpointer(HourGlass!)
		
//--- apri il LOG
		kiuf_docprod.log_inizializza( )

		
//--- Aggiorna Documenti?
		if this.rb_definitiva_si_aggiorna_si.checked then 
			kst_docprod_esporta.k_aggiorna_docprod = true
			k_msg = "'Esporta' e Aggiorna  Documenti. "
		else
			kst_docprod_esporta.k_aggiorna_docprod = false
			k_msg = "'Esporta' ma NON aggiorna. "
		end if


		k_ctr = messagebox("Operazione di Esporta", k_msg + "Eseguire l'operazione?", Question!, yesno!, 2)


//--- se ho risposto OK 
		if k_ctr = 1 then
			
//--- aggiunge riga al log
			kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("-----------> Inizio Esporta Documenti.  Operazione di: " + trim(k_msg) + "<-----------", false)
		
			k_ctr_Documenti = 0
			for k_ctr = 1 to dw_documenti.rowcount( )
				
				if dw_documenti.getitemnumber(k_ctr, "sel") = 1 or rb_emissione_tutto.checked then
					
					k_ctr_Documenti ++
					
					kst_docprod_esporta.kst_tab_docprod[k_ctr_Documenti].id_docprod = dw_documenti.getitemnumber(k_ctr, "id_docprod")
					kst_docprod_esporta.kst_tab_docprod[k_ctr_Documenti].id_doc = dw_documenti.getitemnumber(k_ctr, "id_doc")
					kst_docprod_esporta.kst_tab_docprod[k_ctr_Documenti].doc_data = dw_documenti.getitemdate(k_ctr, "doc_data")
					kst_docprod_esporta.kst_tab_docprod[k_ctr_Documenti].doc_num = dw_documenti.getitemnumber(k_ctr, "doc_num")
					
				end if
			end for
			
//--- LANCIA elaborazione
			if k_ctr_Documenti > 0 then 
				
//--- Acchiappo il Tipo Documento				
				kst_docprod_esporta.k_tipo = dw_documenti.getitemstring(1, "tipo")

//--- descrizione Tipo
				choose case kst_docprod_esporta.k_tipo
						
					case kuf1_doctipo.kki_tipo_fatture
						k_tipo = "FATTURA"
						
					case kuf1_doctipo.kki_tipo_ddt
						k_tipo = "D.D.T."
						
					case kuf1_doctipo.kki_tipo_attestati
						k_tipo = "ATTESTATO"
			
					case kuf1_doctipo.kki_tipo_contr_co
						k_tipo = "CONTRATTO COMMERCIALE"
			
					case kuf1_doctipo.kki_tipo_contr_rd
						k_tipo = "CONTRATTO STUDIO SVILUPPO"
						
					case else
						k_tipo = "ALTRO"
						
				end choose
					
//--- aggiunge riga al log
				kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("Nr Documenti da Esportare: " + string(k_ctr_Documenti) + " di Tipo: " + k_tipo, false)
				
//--- Esporta Documenti --------------------------------------------------------------------------------------------
				k_ctr_Documenti = kiuf_docprod.u_esporta(kst_docprod_esporta) 
				if k_ctr_Documenti > 0 then
						
					kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("Nr Documenti Esportati: " + string(k_ctr_Documenti) +  " di Tipo: " + k_tipo, false)  // aggiunge riga al log

					kguo_exception.inizializza( )
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_ok )
					if not kst_docprod_esporta.k_aggiorna_docprod then
						kguo_exception.setmessage("Documenti Esportati " + string(k_ctr_Documenti) + ", visualizza l'esito dal Log")
					else
						kguo_exception.setmessage("Documenti Aggiornati e Esportati " + string(k_ctr_Documenti) + ", visualizza l'esito dal Log")
					end if					
					kguo_exception.messaggio_utente( )
		
					inizializza( ) // rilegge l'elenco
					
				else
					
//--- aggiunge riga al log
					kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("Nessun Documento Esportato ", false)
					kguo_exception.inizializza( )
					kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
					kguo_exception.setmessage("Nessun Documento Esportato")
					kguo_exception.messaggio_utente( )
				end if
					
			else
				
				kguo_exception.inizializza( )
				if k_ctr_Documenti = 0 then
					kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_non_eseguito )
					kguo_exception.setmessage("Selezionare almeno un Documento dall'elenco")
					kguo_exception.messaggio_utente( )
					
				end if
			end if
		else
			kguo_exception.inizializza( )
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_interr_da_utente )
			kguo_exception.setmessage("Operazione annullata dall'utente")
			kguo_exception.messaggio_utente( )
		end if		

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("Operazione in errore: " + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext), TRUE)
		kuo_exception.messaggio_utente()

	finally
//--- aggiunge riga al log
		kiuf_docprod.kiuf_esito_operazioni.tb_add_riga("-----------> Fine operazione, Esporta Documenti di Tipo " +  k_tipo + " terminata <----------- ", false)
		kiuf_docprod.log_destroy( )
		
		setpointer(k_pointer)

		
	end try


return k_return


end function

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_esporta_documenti , "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

public subroutine u_visualizza_scelta ();//
	gb_aggiorna.visible = true
	gb_emissione.visible = true
	pb_ok.visible= true
	st_pb_ok.visible=true
	rr_separa.visible=true
	pb_st_esiti_operazioni.visible=true
	st_esiti_operazioni.visible=true
	rb_emissione_tutto.visible=true			
	rb_emissione_selezione.visible=true
	rb_definitiva_si_aggiorna_no.visible=true
	rb_definitiva_si_aggiorna_si.visible=true
	
end subroutine

on w_docprod_esporta.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva_si_aggiorna_no=create rb_definitiva_si_aggiorna_no
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.st_pb_ok=create st_pb_ok
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.dw_esiti=create dw_esiti
this.st_esiti_operazioni=create st_esiti_operazioni
this.rb_definitiva_si_aggiorna_si=create rb_definitiva_si_aggiorna_si
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.rr_separa=create rr_separa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva_si_aggiorna_no
this.Control[iCurrent+4]=this.pb_ok
this.Control[iCurrent+5]=this.dw_documenti
this.Control[iCurrent+6]=this.st_pb_ok
this.Control[iCurrent+7]=this.pb_st_esiti_operazioni
this.Control[iCurrent+8]=this.dw_esiti
this.Control[iCurrent+9]=this.st_esiti_operazioni
this.Control[iCurrent+10]=this.rb_definitiva_si_aggiorna_si
this.Control[iCurrent+11]=this.gb_aggiorna
this.Control[iCurrent+12]=this.gb_emissione
this.Control[iCurrent+13]=this.rr_separa
end on

on w_docprod_esporta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva_si_aggiorna_no)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.st_pb_ok)
destroy(this.pb_st_esiti_operazioni)
destroy(this.dw_esiti)
destroy(this.st_esiti_operazioni)
destroy(this.rb_definitiva_si_aggiorna_si)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.rr_separa)
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
if isvalid(kiuf_docprod) then destroy 	kiuf_docprod

end event

event u_open;call super::u_open;//
u_resize()

end event

type st_ritorna from w_g_tab`st_ritorna within w_docprod_esporta
integer x = 2711
integer y = 2000
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_docprod_esporta
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_docprod_esporta
integer x = 2336
integer y = 1896
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_docprod_esporta
integer x = 2811
integer y = 1916
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_docprod_esporta
integer x = 2203
integer y = 2012
end type

type rb_emissione_tutto from radiobutton within w_docprod_esporta
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
string text = "Tutti i Documenti in elenco "
end type

type rb_emissione_selezione from radiobutton within w_docprod_esporta
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
string text = "Solo i Documenti con ~'Sel~' attivato"
boolean checked = true
end type

type rb_definitiva_si_aggiorna_no from radiobutton within w_docprod_esporta
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
string text = "Esporta senza aggiornamento"
boolean checked = true
end type

type pb_ok from picturebutton within w_docprod_esporta
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

type dw_documenti from uo_d_std_1 within w_docprod_esporta
boolean visible = true
integer x = 1184
integer width = 2354
integer height = 1864
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_docprod_l_x_esportare"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

type st_pb_ok from statictext within w_docprod_esporta
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

type pb_st_esiti_operazioni from picturebutton within w_docprod_esporta
integer x = 69
integer y = 1808
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

type dw_esiti from uo_d_std_1 within w_docprod_esporta
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

type st_esiti_operazioni from statictext within w_docprod_esporta
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

type rb_definitiva_si_aggiorna_si from radiobutton within w_docprod_esporta
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
string text = "Esporta e Aggiorna Documenti"
end type

type gb_aggiorna from groupbox within w_docprod_esporta
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
string text = " Esporta e Aggiorna "
end type

type gb_emissione from groupbox within w_docprod_esporta
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
string text = " Esporta Documenti "
end type

type rr_separa from roundrectangle within w_docprod_esporta
long linecolor = 8421504
long fillcolor = 134217731
integer x = 41
integer y = 1736
integer width = 1093
integer height = 12
integer cornerheight = 40
integer cornerwidth = 46
end type

