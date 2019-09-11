$PBExportHeader$w_fatture_new_st.srw
forward
global type w_fatture_new_st from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_fatture_new_st
end type
type rb_emissione_selezione from radiobutton within w_fatture_new_st
end type
type rb_definitiva from radiobutton within w_fatture_new_st
end type
type rb_prova from radiobutton within w_fatture_new_st
end type
type pb_ok from picturebutton within w_fatture_new_st
end type
type dw_documenti from uo_d_std_1 within w_fatture_new_st
end type
type cbx_aggiorna_stato from checkbox within w_fatture_new_st
end type
type cbx_update_profis from checkbox within w_fatture_new_st
end type
type st_1 from statictext within w_fatture_new_st
end type
type cbx_update_tab_varie from checkbox within w_fatture_new_st
end type
type rb_modo_stampa_e from radiobutton within w_fatture_new_st
end type
type rb_modo_stampa_s from radiobutton within w_fatture_new_st
end type
type cbx_chiude from checkbox within w_fatture_new_st
end type
type gb_aggiorna from groupbox within w_fatture_new_st
end type
type gb_emissione from groupbox within w_fatture_new_st
end type
type gb_produzione from groupbox within w_fatture_new_st
end type
end forward

global type w_fatture_new_st from w_g_tab
integer width = 3602
integer height = 2012
string title = "Stampa Documenti di Vendita"
long backcolor = 67108864
string icon = "RunReport5!"
boolean ki_toolbar_window_presente = true
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva rb_definitiva
rb_prova rb_prova
pb_ok pb_ok
dw_documenti dw_documenti
cbx_aggiorna_stato cbx_aggiorna_stato
cbx_update_profis cbx_update_profis
st_1 st_1
cbx_update_tab_varie cbx_update_tab_varie
rb_modo_stampa_e rb_modo_stampa_e
rb_modo_stampa_s rb_modo_stampa_s
cbx_chiude cbx_chiude
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_produzione gb_produzione
end type
global w_fatture_new_st w_fatture_new_st

type variables
//
ds_fatture kids_fatture

end variables

forward prototypes
protected subroutine stampa ()
protected subroutine open_start_window ()
protected subroutine u_personalizza_dw ()
private subroutine popola_ds_da_lista ()
private subroutine popola_lista_da_ds ()
protected subroutine attiva_menu ()
protected subroutine u_seleziona_tutti ()
protected subroutine u_deseleziona_tutti ()
protected subroutine smista_funz (string k_par_in)
public subroutine u_resize ()
protected subroutine fine_primo_giro ()
end prototypes

protected subroutine stampa ();//--
//--- Lancia Aggiornamento e Stampa delle fatture 
//---
long k_riga_fatture
int k_nr_fatture=0
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa[]
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_fatt = create kuf_fatt
kuo1_exception = create uo_exception

try 
	popola_ds_da_lista()

//--- Aggiornamento Tabelle se NON di PROVA	ovvero ELAB. DEFINITIVA
	if rb_definitiva.checked then
	
		if kids_fatture.rowcount() > 0 then
			for k_riga_fatture = 1 to kids_fatture.rowcount()
				kst_tab_arfa[k_riga_fatture].NUM_FATT = kids_fatture.object.NUM_FATT[k_riga_fatture]
				kst_tab_arfa[k_riga_fatture].DATA_FATT = kids_fatture.object.DATA_FATT[k_riga_fatture]
				kst_tab_arfa[k_riga_fatture].id_fattura = kids_fatture.object.id_fattura[k_riga_fatture]
			next
//		end if
	
//--- aggiorna dati documento a fine stampa 
			if cbx_aggiorna_stato.checked then
			
				kuf1_fatt.produci_fattura_aggiorna(kst_tab_arfa[])

			end if
		
////--- aggiorna tabelle tipo PROFIS 		
//			if cbx_update_profis.checked then
//				kst_esito = kuf1_fatt.aggiorna_tabelle_profis(kst_tab_arfa[])
//				if kst_esito.esito = kkg_esito.db_ko then
//					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
//					kguo_exception.set_esito( kst_esito )
//				end if
//			end if

//--- aggiorna tabelle tipo SCADENZE....		
			if cbx_update_tab_varie.checked then
				kst_esito = kuf1_fatt.aggiorna_tabelle_correlate(kst_tab_arfa[])
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
					kguo_exception.set_esito( kst_esito )
				end if
			end if
		
		end if   // kids_fatture.rowcount() = 0
		
	end if

//--- STAMPA se richiesto esplicitamente oppure se EMISSIONE di PROVA!!! 	
	if rb_modo_stampa_s.checked or not rb_definitiva.checked then
	
		k_nr_fatture = kuf1_fatt.stampa_fattura (kids_fatture)
	
		if k_nr_fatture = 0 then
			kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_non_eseguito )
			kuo1_exception.setmessage(" Nessun documento Stampato ")
		else
			kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
			if k_nr_fatture = 1 then
				kuo1_exception.setmessage("Fine elaborazione, 1 documento stampato")
			else
				kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_fatture) + " documenti stampati")
			end if
		end if
	end if
	
//--- PDF!!!
	if not rb_modo_stampa_s.checked then
		
		k_nr_fatture = kuf1_fatt.stampa_fattura_digitale (kids_fatture)
		
		if k_nr_fatture = 0 then
			kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_non_eseguito )
			kuo1_exception.setmessage(" Nessun documento digitalizzato ")
		else
			kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
			if k_nr_fatture = 1 then
				kuo1_exception.setmessage("Fine elaborazione, 1 documento digitale emesso")
			else
				kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_fatture) + " documenti digitali emessi")
			end if
		end if
	
	end if
		
	kuo1_exception.messaggio_utente( )
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	destroy kuf1_fatt
	destroy kuo1_exception
	
	setpointer(kpointer)
	
//--- se richiesto ed elenco vuoto esce dalla funzione	
	if cbx_chiude.checked then
		cb_ritorna.event clicked( )
	end if
	
end try


end subroutine

protected subroutine open_start_window ();//---
//
string k_rcx=""
pointer kpointer_orig
kuf_fatt kuf1_fatt




try 
	ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
	
	kpointer_orig = setpointer(hourglass!)
	pb_ok.picturename = kGuo_path.get_risorse() + "\printer.gif"

	kids_fatture = create ds_fatture

	if isvalid(ki_st_open_w.key12_any) then 
		kids_fatture = ki_st_open_w.key12_any   //--- argomento ds_fattura
	end if
		
//--- pone i link nel dw
	u_personalizza_dw()

	if kids_fatture.rowcount() = 0 then

		kuf1_fatt = create kuf_fatt
		kuf1_fatt.get_fatture_da_stampare(kids_fatture)
			
	end if
	
	popola_lista_da_ds()
	
	if isvalid(kids_fatture) then destroy kids_fatture
	
	kids_fatture = create ds_fatture

	dw_documenti.visible = true
	dw_documenti.setfocus()
	
//	attiva_tasti( )

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_fatt) then destroy kuf1_fatt
		
		setpointer(kpointer_orig)	
		
end try


end subroutine

protected subroutine u_personalizza_dw ();//---
//--- Personalizza DW
//---

	dw_documenti.ki_flag_modalita = ki_st_open_w.flag_modalita 
	dw_documenti.event u_personalizza_dw()
	



end subroutine

private subroutine popola_ds_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
string k_diprova
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_esito kst_esito


kids_fatture.reset()
kuf1_fatt = create kuf_fatt

if rb_prova.checked then 
	k_diprova = kuf1_fatt.kki_stampa_diProva_si 
else
	k_diprova = kuf1_fatt.kki_stampa_diProva_no
end if

for k_riga = 1 to dw_documenti.rowcount()


	kst_tab_arfa.num_fatt = dw_documenti.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = dw_documenti.getitemdate(k_riga, "data_fatt")
	kst_tab_arfa.id_fattura = dw_documenti.getitemnumber(k_riga, "id_fattura")

	if kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura) then
		kuf1_fatt.get_id(kst_tab_arfa)	// trova l'id della fattura
	end if
	kuf1_fatt.get_modo_stampa(kst_tab_arfa)	// torna il campo mod_stampa per capire se pdf
	
	if kst_tab_arfa.num_fatt > 0 then

//--- solo i documenti selezionati
		if rb_emissione_selezione.checked then
			
			if (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

				if (rb_modo_stampa_s.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartaceo) &
							or (rb_modo_stampa_s.checked and not rb_definitiva.checked) &  
							or (rb_modo_stampa_e.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_digitale) &
							or (kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartedig) then

							
					k_riga_ds = kids_fatture.insertrow(0)
					kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
					kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
					kids_fatture.setitem(k_riga_ds,"id_fattura", kst_tab_arfa.id_fattura )
					kids_fatture.setitem(k_riga_ds,"modo_stampa", kst_tab_arfa.modo_stampa )
	//				kids_fatture.setitem(k_riga_ds,"data_stampa", kst_tab_arfa.data_stampa )
					kids_fatture.setitem(k_riga_ds,"prof", dw_documenti.getitemnumber(k_riga, "prof"))
					kids_fatture.setitem(k_riga_ds,"diprova", k_diprova)
					kids_fatture.setitem(k_riga_ds,"sel", 1)
					kids_fatture.setitem(k_riga_ds,"esporta", "")
				end if
			end if
			
		else
			
			if (rb_modo_stampa_s.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartaceo) &
							or (rb_modo_stampa_s.checked and not rb_definitiva.checked) &  
							or ( rb_modo_stampa_e.checked and kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_digitale) &
							or (kst_tab_arfa.modo_stampa = kuf1_fatt.kki_modo_stampa_cartedig) then
							
				k_riga_ds = kids_fatture.insertrow(0)
				kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
				kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
				kids_fatture.setitem(k_riga_ds,"id_fattura", kst_tab_arfa.id_fattura )
				kids_fatture.setitem(k_riga_ds,"modo_stampa", kst_tab_arfa.modo_stampa )
	//			kids_fatture.setitem(k_riga_ds,"data_stampa", kst_tab_arfa.data_stampa)
				kids_fatture.setitem(k_riga_ds,"prof", dw_documenti.getitemnumber(k_riga, "prof"))
				kids_fatture.setitem(k_riga_ds,"diprova", k_diprova)
				kids_fatture.setitem(k_riga_ds,"esporta", "")
			
				if (dw_documenti.getitemnumber(k_riga, "sel")) = 0 then
					kids_fatture.setitem(k_riga_ds,"sel", 0)
				else
					kids_fatture.setitem(k_riga_ds,"sel", 1)
				end if
				
			end if			
		end if			
	end if		
	
end for

destroy kuf1_fatt


end subroutine

private subroutine popola_lista_da_ds ();//---
//--- riempie la dw da oggetto ds_fatture
//---
long k_riga, k_riga_ins
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_tab_prof kst_tab_prof
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
kuf_prof kuf1_prof 
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_fatt = create kuf_fatt
kuf1_clienti = create kuf_clienti
kuf1_prof = create kuf_prof

for k_riga = 1 to kids_fatture.rowcount()

	k_riga_ins = dw_documenti.insertrow(0)

	kst_tab_arfa.num_fatt = kids_fatture.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = kids_fatture.getitemdate(k_riga, "data_fatt")
	kst_tab_arfa.id_fattura = kids_fatture.getitemnumber(k_riga, "id_fattura")
	kst_tab_arfa.modo_stampa = kids_fatture.getitemstring(k_riga, "modo_stampa")
	
	if (kids_fatture.getitemnumber(k_riga, "sel")) = 0 then
		dw_documenti.setitem(k_riga_ins,"sel", 0)
	else
		dw_documenti.setitem(k_riga_ins,"sel", 1)
	end if
		
	dw_documenti.setitem(k_riga_ins,"num_fatt", kst_tab_arfa.num_fatt)
	dw_documenti.setitem(k_riga_ins,"data_fatt", kst_tab_arfa.data_fatt)
	dw_documenti.setitem(k_riga_ins,"id_fattura", kst_tab_arfa.id_fattura)
	dw_documenti.setitem(k_riga_ins,"modo_stampa", kst_tab_arfa.modo_stampa)
	kst_tab_prof.num_fatt = kst_tab_arfa.num_fatt
	kst_tab_prof.data_fatt = kst_tab_arfa.data_fatt
	try 
		if kuf1_prof.if_fattura_presente( kst_tab_prof ) = kuf1_prof.kki_fattura_in_profis_si then
			dw_documenti.setitem(k_riga_ins,"prof", 1) //kids_fatture.getitemnumber(k_riga, "prof"))
		else
			dw_documenti.setitem(k_riga_ins,"prof", 0)		
		end if
	catch ( uo_exception kuo_exception)
		dw_documenti.setitem(k_riga_ins,"prof", 2)		
	finally 
	end try
	
//--- se non c'e' piglio l'ID_FATTURA
	if kst_tab_arfa.id_fattura > 0 then
	else
		kst_esito = kuf1_fatt.get_id( kst_tab_arfa )
		if kst_esito.esito <> kkg_esito.ok then
			kst_tab_arfa.id_fattura = 0
		end if
	end if
//--- piglia data stampa			
	if kst_tab_arfa.id_fattura > 0 then
		kst_esito = kuf1_fatt.get_data_stampa( kst_tab_arfa )
		if kst_esito.esito = kkg_esito.ok then
			dw_documenti.setitem(k_riga_ins,"data_stampa", kst_tab_arfa.data_stampa)
		end if
	end if
 



	kst_esito = kuf1_fatt.get_cliente( kst_tab_arfa )
	if kst_esito.esito = kkg_esito.ok then
		dw_documenti.setitem(k_riga_ins,"clie_3", kst_tab_arfa.clie_3)
	
		kst_tab_clienti.codice = kst_tab_arfa.clie_3
		kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
		if kst_esito.esito = kkg_esito.ok then
			dw_documenti.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
			dw_documenti.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
			dw_documenti.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
		else
			dw_documenti.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
		end if
	else
		dw_documenti.setitem(k_riga_ins,"clie_3", 0)
	end if
		
		
end for

destroy kuf1_prof
destroy kuf1_fatt 
destroy kuf1_clienti 

setpointer(kpointer_orig)  


end subroutine

protected subroutine attiva_menu ();//	
	if not ki_menu.m_strumenti.m_fin_gest_libero3.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Togli Selezione a tutti "
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Toglie 'selezione' a tutti i documenti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Deseleziona,"+  ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "custom080!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if
//	
	if not ki_menu.m_strumenti.m_fin_gest_libero4.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Attiva Selezione a tutti "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Attiva 'selezione' a tutti i documenti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Seleziona,"+ ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "custom038!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
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

public subroutine u_resize ();//
this.setredraw(false) 

//this.x = kist_orizzontal.x 
//this.y = kist_orizzontal.y 
//this.width = kist_orizzontal.width
//this.height = kist_orizzontal.heigth  

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



end subroutine

protected subroutine fine_primo_giro ();//
dw_documenti.visible = true

super::fine_primo_giro()

end subroutine

on w_fatture_new_st.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva=create rb_definitiva
this.rb_prova=create rb_prova
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.cbx_aggiorna_stato=create cbx_aggiorna_stato
this.cbx_update_profis=create cbx_update_profis
this.st_1=create st_1
this.cbx_update_tab_varie=create cbx_update_tab_varie
this.rb_modo_stampa_e=create rb_modo_stampa_e
this.rb_modo_stampa_s=create rb_modo_stampa_s
this.cbx_chiude=create cbx_chiude
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.gb_produzione=create gb_produzione
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_emissione_tutto
this.Control[iCurrent+2]=this.rb_emissione_selezione
this.Control[iCurrent+3]=this.rb_definitiva
this.Control[iCurrent+4]=this.rb_prova
this.Control[iCurrent+5]=this.pb_ok
this.Control[iCurrent+6]=this.dw_documenti
this.Control[iCurrent+7]=this.cbx_aggiorna_stato
this.Control[iCurrent+8]=this.cbx_update_profis
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cbx_update_tab_varie
this.Control[iCurrent+11]=this.rb_modo_stampa_e
this.Control[iCurrent+12]=this.rb_modo_stampa_s
this.Control[iCurrent+13]=this.cbx_chiude
this.Control[iCurrent+14]=this.gb_aggiorna
this.Control[iCurrent+15]=this.gb_emissione
this.Control[iCurrent+16]=this.gb_produzione
end on

on w_fatture_new_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva)
destroy(this.rb_prova)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.cbx_aggiorna_stato)
destroy(this.cbx_update_profis)
destroy(this.st_1)
destroy(this.cbx_update_tab_varie)
destroy(this.rb_modo_stampa_e)
destroy(this.rb_modo_stampa_s)
destroy(this.cbx_chiude)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.gb_produzione)
end on

event closequery;call super::closequery;st_profilestring_ini kst_profilestring_ini


//--- salvo campo "Chiudi a fine stampa"
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "chiudeafine"
	kst_profilestring_ini.nome = this.classname( )
	if cbx_chiude.checked then
		kst_profilestring_ini.valore = "S"
	else
		kst_profilestring_ini.valore = "N"
	end if
	kGuf_data_base.profilestring_ini(kst_profilestring_ini)

end event

event u_open;call super::u_open;//
string k_rcx=""
st_profilestring_ini kst_profilestring_ini

//--- recupero i valori se personalizzati della window
	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "S"
	kst_profilestring_ini.file = "stampe" 
	kst_profilestring_ini.titolo = "chiudeafine" 
	kst_profilestring_ini.nome = this.classname( ) 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	if kst_profilestring_ini.esito <> "0" then
		kst_profilestring_ini.valore = "S"
	end if
	if kst_profilestring_ini.valore = "S" then
		cbx_chiude.checked = true
	else
		cbx_chiude.checked = false
	end if

//--- Fine PRIMO GIRO
	 ki_st_open_w.flag_primo_giro = "N" 
	 
	 u_resize()

end event

type st_ritorna from w_g_tab`st_ritorna within w_fatture_new_st
integer x = 2551
integer y = 1844
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_fatture_new_st
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_fatture_new_st
integer x = 2062
integer y = 1724
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_fatture_new_st
integer x = 2537
integer y = 1744
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_fatture_new_st
integer x = 2043
integer y = 1856
end type

type rb_emissione_tutto from radiobutton within w_fatture_new_st
integer x = 96
integer y = 104
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
string text = "Tutti i documenti "
end type

type rb_emissione_selezione from radiobutton within w_fatture_new_st
integer x = 96
integer y = 200
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
string text = "Solo documenti con ~'Sel~' attivato"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_fatture_new_st
integer x = 78
integer y = 988
integer width = 608
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Genera e Aggiorna "
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = true
	cbx_aggiorna_stato.enabled = true
	cbx_update_profis.enabled = true
	
end if
end event

type rb_prova from radiobutton within w_fatture_new_st
integer x = 78
integer y = 900
integer width = 1042
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
string text = "Solo emissione (no Aggiornamenti) "
boolean checked = true
end type

event clicked;//
if this.checked then
	
	cbx_update_tab_varie.enabled = false
	cbx_update_profis.enabled = false
	cbx_aggiorna_stato.enabled = false
	
end if
end event

type pb_ok from picturebutton within w_fatture_new_st
integer x = 96
integer y = 1576
integer width = 242
integer height = 156
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\GAMMARAD\PB_GMMRD11\ICONE\printer.gif"
vtextalign vtextalign = top!
string powertiptext = "Emissione  della stampa e/o elettronico"
end type

event clicked;//
//this.enabled = false

stampa()

//this.enabled = true


end event

type dw_documenti from uo_d_std_1 within w_fatture_new_st
integer x = 1184
integer width = 2354
integer height = 1804
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_arfa_l"
boolean border = true
boolean ki_link_standard_sempre_possibile = true
end type

event getfocus;call super::getfocus;//
kidw_selezionata = this

end event

type cbx_aggiorna_stato from checkbox within w_fatture_new_st
integer x = 142
integer y = 1112
integer width = 997
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Agg. lo Stato + elenco doc. da Esportare"
boolean checked = true
end type

type cbx_update_profis from checkbox within w_fatture_new_st
integer x = 142
integer y = 1192
integer width = 827
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "crea Movim. per la Contabilità"
boolean checked = true
end type

type st_1 from statictext within w_fatture_new_st
integer x = 361
integer y = 1644
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
string text = "Emissione Documenti"
boolean focusrectangle = false
end type

type cbx_update_tab_varie from checkbox within w_fatture_new_st
integer x = 142
integer y = 1272
integer width = 827
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "crea  Scadenze ecc..."
boolean checked = true
end type

type rb_modo_stampa_e from radiobutton within w_fatture_new_st
integer x = 91
integer y = 600
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
string text = "Emissione digitale (pdf) "
end type

type rb_modo_stampa_s from radiobutton within w_fatture_new_st
integer x = 91
integer y = 508
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
string text = "Stampa cartecea"
boolean checked = true
end type

type cbx_chiude from checkbox within w_fatture_new_st
integer x = 23
integer y = 1452
integer width = 1129
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Esce al termine dell~'emissione documenti"
boolean lefttext = true
boolean righttoleft = true
end type

type gb_aggiorna from groupbox within w_fatture_new_st
integer x = 27
integer y = 812
integer width = 1125
integer height = 596
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Genera e Aggiorna "
end type

type gb_emissione from groupbox within w_fatture_new_st
integer x = 27
integer y = 8
integer width = 1125
integer height = 352
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "  Emissione "
end type

type gb_produzione from groupbox within w_fatture_new_st
integer x = 27
integer y = 400
integer width = 1125
integer height = 352
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Produzione dei documenti"
end type

