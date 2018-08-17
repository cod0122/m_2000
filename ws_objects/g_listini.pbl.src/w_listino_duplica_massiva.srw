$PBExportHeader$w_listino_duplica_massiva.srw
forward
global type w_listino_duplica_massiva from w_g_tab
end type
type rb_emissione_tutto from radiobutton within w_listino_duplica_massiva
end type
type rb_emissione_selezione from radiobutton within w_listino_duplica_massiva
end type
type rb_definitiva_si from radiobutton within w_listino_duplica_massiva
end type
type rb_definitiva_no from radiobutton within w_listino_duplica_massiva
end type
type pb_ok from picturebutton within w_listino_duplica_massiva
end type
type dw_documenti from uo_d_std_1 within w_listino_duplica_massiva
end type
type st_1 from statictext within w_listino_duplica_massiva
end type
type pb_st_esiti_operazioni from picturebutton within w_listino_duplica_massiva
end type
type dw_esiti from uo_d_std_1 within w_listino_duplica_massiva
end type
type st_esiti_operazioni from statictext within w_listino_duplica_massiva
end type
type dw_box from datawindow within w_listino_duplica_massiva
end type
type gb_aggiorna from groupbox within w_listino_duplica_massiva
end type
type gb_emissione from groupbox within w_listino_duplica_massiva
end type
type gb_produzione from groupbox within w_listino_duplica_massiva
end type
type rr_1 from roundrectangle within w_listino_duplica_massiva
end type
end forward

global type w_listino_duplica_massiva from w_g_tab
integer width = 3602
integer height = 2740
string title = "Stampa Documenti di Vendita"
long backcolor = 67108864
string icon = "RunReport5!"
boolean ki_toolbar_window_presente = true
rb_emissione_tutto rb_emissione_tutto
rb_emissione_selezione rb_emissione_selezione
rb_definitiva_si rb_definitiva_si
rb_definitiva_no rb_definitiva_no
pb_ok pb_ok
dw_documenti dw_documenti
st_1 st_1
pb_st_esiti_operazioni pb_st_esiti_operazioni
dw_esiti dw_esiti
st_esiti_operazioni st_esiti_operazioni
dw_box dw_box
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_produzione gb_produzione
rr_1 rr_1
end type
global w_listino_duplica_massiva w_listino_duplica_massiva

type variables
//
private st_listino_duplica kist_listino_duplica[]
private kuf_listino kiuf_listino
private kuf_listino_duplica_massiva kiuf_listino_duplica_massiva
private kuf_esito_operazioni kiuf_esito_operazioni
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
protected function string check_dati ()
private subroutine popola_lista_da_st ()
private subroutine popola_st_da_lista ()
protected subroutine u_esegui ()
public subroutine u_set_dw_documenti_prezzo_nuovo ()
public function boolean u_get_prezzo_nuovo (ref double a_prezzo)
private function long u_get_nr_da_dup ()
public subroutine u_set_dw_documenti_reset ()
end prototypes

protected subroutine open_start_window ();//---
//
st_listino_duplica kst_listino_duplica_vuota[]


kiuf_listino = create kuf_listino
kiuf_listino_duplica_massiva = create kuf_listino_duplica_massiva

dw_documenti.settransobject( sqlca )
dw_esiti.settransobject( sqlca )


try 
	setpointer(kkg.pointer_attesa)

	pb_ok.picturename = kGuo_path.get_risorse() + KKG.PATH_SEP + "euro40.png"

	dw_box.insertrow(0)

	if isvalid(ki_st_open_w.key12_any) then 
		kist_listino_duplica[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
	else
		kist_listino_duplica[]	 = kst_listino_duplica_vuota[]		
	end if

//--- lancia la retrieve!
	inizializza( )

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

protected function string inizializza () throws uo_exception;//---
boolean k_bolla_trovata=false
long k_ctr
date k_data
st_listino_duplica kist_listino_duplica_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
kuf_sped kuf1_sped
pointer kpointer_orig



try 
	kpointer_orig = setpointer(hourglass!)

	dw_documenti.reset( )
	
//--- pone i link nel dw
	u_personalizza_dw()

//--- se non è stato passato nulla faccio la retrieve
	if upperbound(kist_listino_duplica[]) = 0 then
		k_data = relativedate(kguo_g.get_dataoggi( ), -1000)
		dw_documenti.retrieve(0, k_data, 0)
	else
		popola_lista_da_st()
	end if
	
	kist_listino_duplica[] = kist_listino_duplica_vuota[]
	
	dw_documenti.setfocus()

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_sped) then destroy kuf1_sped
		setpointer(kpointer_orig)  
		
end try

return "0"

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
		kiuf_esito_operazioni = kiuf_listino_duplica_massiva.log_inizializza( )

		
		if this.rb_definitiva_si.checked then // è di simulazione?
			k_ctr = messagebox("Operazione DEFINITIVA", "Proseguire con la Duplica di " + string(u_get_nr_da_dup()) + " Listini?", Question!, yesno!, 2)
		else
			k_ctr = 1  // simulazione non chiedo nulla
		end if

//--- se ho risposto OK 
		if k_ctr = 1 then

			u_esegui()
			
		else
			kguo_exception.setmessage("Operazione interrotta dall'utente")
			kguo_exception.messaggio_utente( )
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		kiuf_listino_duplica_massiva.log_destroy( )
		
		
	end try


return k_return


end function

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_dup_listini , "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito
dec k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00
string k_tipo
string k_espressione = "if (prezzo > 0 "
//datastore kds_inp
//kuf_parent kuf1_parent


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if u_get_nr_da_dup() = 0 then
		kst_esito.sqlerrtext = "Nessun Listino da Importare"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	dw_box.accepttext( )
	k_tipo = dw_box.getitemstring(1, "tipo")
	k_percento = dw_box.getitemnumber(1, "percento")
	k_importo = dw_box.getitemnumber(1, "importo")

	choose case k_tipo
		case "P"
			if k_percento <> 0 then
			else
				kst_esito.sqlerrtext = "Indicare la Percentuale"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		case "I"
			if k_importo <> 0 then
			else
				kst_esito.sqlerrtext = "Indicare l'Importo"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
	end choose
	
	if kst_esito.esito = kkg_esito.ok then
		k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
		if k_soglia_min > 0 then
			k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
			if k_soglia_max > 0 and k_soglia_max < k_soglia_min then
				kst_esito.sqlerrtext = "Soglia Minima superiore alla Massima"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try

return k_errore + k_return


end function

private subroutine popola_lista_da_st ();//
//---
//--- riempie la dw da oggetto st_sped_ddt
//---
long k_riga, k_riga_ins
int k_camion_caricato=0
st_tab_listino kst_tab_listino
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_gru kst_tab_gru
st_tab_contratti kst_tab_contratti
kuf_prodotti kuf1_prodotti
kuf_clienti kuf1_clienti
kuf_ausiliari kuf1_ausiliari
kuf_contratti kuf1_contratti
st_esito kst_esito
pointer kpointer_orig


try
	
	kpointer_orig = setpointer(hourglass!)
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_prodotti = create kuf_prodotti
	kuf1_clienti = create kuf_clienti
	kuf1_contratti = create kuf_contratti
	
	dw_documenti.reset()
	
	for k_riga = 1 to upperbound(kist_listino_duplica[])
	
		
		kst_tab_listino.id = kist_listino_duplica[k_riga].id_listino
	
	//--- piglia dati ddt
		if kst_tab_listino.id > 0 then
			
			k_riga_ins = dw_documenti.insertrow(0) //--- nuova riga 
			
			if kist_listino_duplica[k_riga].sel = 0 then
				dw_documenti.setitem(k_riga_ins,"sel", 0)
			else
				dw_documenti.setitem(k_riga_ins,"sel", 1)
			end if
				
			dw_documenti.setitem(k_riga_ins,"id_listino", kist_listino_duplica[k_riga].id_listino)
			
			if kiuf_listino.select_riga(kst_tab_listino) then
				
				dw_documenti.setitem(k_riga_ins,"prezzo", kst_tab_listino.prezzo)
				dw_documenti.setitem(k_riga_ins,"prezzo_2", kst_tab_listino.prezzo_2)
				dw_documenti.setitem(k_riga_ins,"prezzo_3", kst_tab_listino.prezzo_3)
				dw_documenti.setitem(k_riga_ins,"cod_cli", kst_tab_listino.cod_cli)
				dw_documenti.setitem(k_riga_ins,"cod_art", kst_tab_listino.cod_art)
				dw_documenti.setitem(k_riga_ins,"contratto", kst_tab_listino.contratto)
				dw_documenti.setitem(k_riga_ins,"attiva_listino_pregruppi", kst_tab_listino.attiva_listino_pregruppi)
				dw_documenti.setitem(k_riga_ins,"dose", kst_tab_listino.dose)
				dw_documenti.setitem(k_riga_ins,"magazzino", kst_tab_listino.magazzino)
				dw_documenti.setitem(k_riga_ins,"mis_x", kst_tab_listino.mis_x)
				dw_documenti.setitem(k_riga_ins,"mis_y", kst_tab_listino.mis_y)
				dw_documenti.setitem(k_riga_ins,"mis_z", kst_tab_listino.mis_z)
				dw_documenti.setitem(k_riga_ins,"occup_ped", kst_tab_listino.occup_ped)
				dw_documenti.setitem(k_riga_ins,"peso_kg", kst_tab_listino.peso_kg)
				dw_documenti.setitem(k_riga_ins,"campione", kst_tab_listino.campione)
				dw_documenti.setitem(k_riga_ins,"tipo", kst_tab_listino.tipo)
				dw_documenti.setitem(k_riga_ins,"attivo", kst_tab_listino.attivo)
				dw_documenti.setitem(k_riga_ins,"x_datins", kst_tab_listino.x_datins)
				dw_documenti.setitem(k_riga_ins,"attivo", kst_tab_listino.attivo)
	
	
				kst_tab_clienti.codice = kst_tab_listino.cod_cli
				kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
				if kst_esito.esito = kkg_esito.ok then
					dw_documenti.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
	//				dw_documenti.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
	//				dw_documenti.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
				else
					dw_documenti.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
				end if
				
				kst_tab_prodotti.codice = kst_tab_listino.cod_art
				kst_esito = kuf1_prodotti.select_riga(kst_tab_prodotti)
				if kst_esito.esito = kkg_esito.ok then
					dw_documenti.setitem(k_riga_ins,"prodotti_des", kst_tab_prodotti.des)
					dw_documenti.setitem(k_riga_ins,"prodotti_gruppo", kst_tab_prodotti.gruppo)
				else
					dw_documenti.setitem(k_riga_ins,"prodotti_des", "***non trovato***")
					dw_documenti.setitem(k_riga_ins,"prodotti_gruppo", "")
				end if
				
				if kst_tab_prodotti.gruppo > 0 then
					kst_tab_gru.codice = kst_tab_prodotti.gruppo
					kst_esito = kuf1_ausiliari.tb_select(kst_tab_gru)
					if kst_esito.esito = kkg_esito.ok then
						dw_documenti.setitem(k_riga_ins,"gru_des", kst_tab_gru.des)
					else
						dw_documenti.setitem(k_riga_ins,"gru_des", "***non trovato***")
					end if
				else
					dw_documenti.setitem(k_riga_ins,"gru_des", "")
				end if
				
				if kst_tab_listino.contratto > 0 then
					kst_tab_contratti.codice = kst_tab_listino.contratto
					kst_esito = kuf1_contratti.select_riga(kst_tab_contratti)
					if kst_esito.esito = kkg_esito.ok then
						dw_documenti.setitem(k_riga_ins,"mc_co", kst_tab_contratti.mc_co)
						dw_documenti.setitem(k_riga_ins,"sc_cf", kst_tab_contratti.mc_co)
						dw_documenti.setitem(k_riga_ins,"sl_pt", kst_tab_contratti.mc_co)
						//dw_documenti.setitem(k_riga_ins,"data_scad", kst_tab_contratti.mc_co)
					else
						dw_documenti.setitem(k_riga_ins,"mc_co", "***non trovato***")
						dw_documenti.setitem(k_riga_ins,"sc_cf", "")
						dw_documenti.setitem(k_riga_ins,"sl_pt", "")
						//dw_documenti.setitem(k_riga_ins,"data_scad", "")
					end if
				else
					dw_documenti.setitem(k_riga_ins,"mc_co", "")
					dw_documenti.setitem(k_riga_ins,"sc_cf", "")
					dw_documenti.setitem(k_riga_ins,"sl_pt", "")
					//dw_documenti.setitem(k_riga_ins,"data_scad", "")
				end if
				
			end if
	
	//--- se si è verificato un errore			
			if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
				throw kguo_exception
			end if
				
		end if
			
			
	end for

	
catch (uo_exception kuo1_exception)
	kuo1_exception.messaggio_utente()
	
finally
	setpointer(kpointer_orig)  

end try


end subroutine

private subroutine popola_st_da_lista ();//
//---
//--- riempie la  st_listino_duplica   da DW
//---
long k_riga=0, k_riga_ins=0
string k_diprova = "N"
st_listino_duplica kst_listino_duplica[]
pointer kpointer_orig

//st_esito kst_esito

kpointer_orig = setpointer(hourglass!)

kist_listino_duplica[] = kst_listino_duplica[]

if rb_definitiva_no.checked then k_diprova = "S"

for k_riga = 1 to dw_documenti.rowcount()


	if dw_documenti.getitemnumber(k_riga,"id_listino") > 0 then
		
//--- solo i documenti selezionati
		if not (rb_emissione_selezione.checked) or (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

			k_riga_ins++


			if rb_emissione_selezione.checked then
				kist_listino_duplica[k_riga_ins].sel = 1
			else
				if dw_documenti.getitemnumber(k_riga,"sel") = 0 then
					kist_listino_duplica[k_riga_ins].sel = 0 
				else
					kist_listino_duplica[k_riga_ins].sel = 1
				end if
			end if
			
			kist_listino_duplica[k_riga_ins].diprova = k_diprova
			
			kist_listino_duplica[k_riga_ins].id_listino = dw_documenti.getitemnumber(k_riga,"id_listino")
		
//--- valuta come valorizzare i PREZZI		
			if dw_documenti.getitemnumber(k_riga,"prezzo")	>0 then
				kist_listino_duplica[k_riga_ins].prezzo = dw_documenti.getitemnumber(k_riga,"prezzo")
			else
				kist_listino_duplica[k_riga_ins].prezzo = 0
			end if
			if dw_documenti.getitemnumber(k_riga,"prezzo_2")	>0 then
				kist_listino_duplica[k_riga_ins].prezzo_2 = dw_documenti.getitemnumber(k_riga,"prezzo_2")
			else
				kist_listino_duplica[k_riga_ins].prezzo_2 = 0
			end if
			if dw_documenti.getitemnumber(k_riga,"prezzo_3")	>0 then
				kist_listino_duplica[k_riga_ins].prezzo_3 = dw_documenti.getitemnumber(k_riga,"prezzo_3")
			else
				kist_listino_duplica[k_riga_ins].prezzo_3 = 0
			end if
			
//			= dw_box.getitemnumber(1,"soglia_min") &
//						and dw_documenti.getitemnumber(k_riga,"prezzo")	<= dw_box.getitemnumber(1,"soglia_max") then
//				if dw_box.getitemstring(1, "tipo") = "P" then
//					kist_listino_duplica[k_riga_ins].prezzo = dw_documenti.getitemnumber(k_riga,"prezzo") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
//				else
//					kist_listino_duplica[k_riga_ins].prezzo = dw_box.getitemnumber(1,"importo")
//				end if
//			end if
//			if dw_documenti.getitemnumber(k_riga,"prezzo_2")	>= dw_box.getitemnumber(1,"soglia_min") &
//						and dw_documenti.getitemnumber(k_riga,"prezzo_2")	<= dw_box.getitemnumber(1,"soglia_max") then
//				if dw_box.getitemstring(1, "tipo") = "P" then
//					kist_listino_duplica[k_riga_ins].prezzo_2 = dw_documenti.getitemnumber(k_riga,"prezzo_2") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
//				else
//					kist_listino_duplica[k_riga_ins].prezzo_2 = dw_box.getitemnumber(1,"importo")
//				end if
//			end if
//			if dw_documenti.getitemnumber(k_riga,"prezzo_3")	>= dw_box.getitemnumber(1,"soglia_min") &
//						and dw_documenti.getitemnumber(k_riga,"prezzo_3")	<= dw_box.getitemnumber(1,"soglia_max") then
//				if dw_box.getitemstring(1, "tipo") = "P" then
//					kist_listino_duplica[k_riga_ins].prezzo_3 = dw_documenti.getitemnumber(k_riga,"prezzo_3") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
//				else
//					kist_listino_duplica[k_riga_ins].prezzo_3 = dw_box.getitemnumber(1,"importo")
//				end if
//			end if
			
		
		end if
	end if
		
		
end for


setpointer(kpointer_orig)  



end subroutine

protected subroutine u_esegui ();//--
//--- Lancia Duplica LISTINI
//---
long k_riga_x_dup=0, k_riga=0
long k_nr_duplicati=0, k_ind=0
string k_titolo
st_listino_duplica kst_listino_duplica[]
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito


setpointer(kkg.pointer_attesa )

kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
	
	if this.rb_definitiva_si.checked then // è di simulazione?
		k_titolo = "Duplicazione Listini" 
		kiuf_esito_operazioni.tb_add_riga("> Inizio Operazioni di Duplica LISTINI <", false)
	else
		k_titolo = "Simulazione Duplica Listini" 
		kiuf_esito_operazioni.tb_add_riga("> Inizio SIMULAZIONE Duplica LISTINI <", false)
	end if
	
//--- set nell'area kist_listino_duplica[] delle bolle da stmpare dal DW	
	popola_st_da_lista()

//--- controllo array ai documenti?  
	if UpperBound(kist_listino_duplica[]) > 0 then
	
		for k_riga_x_dup = 1 to UpperBound(kist_listino_duplica[])
			if kist_listino_duplica[k_riga_x_dup].id_listino > 0 then

				k_riga++
				kst_listino_duplica[k_riga].id_listino = kist_listino_duplica[k_riga_x_dup].id_listino
				
				kst_listino_duplica[k_riga].prezzo = kist_listino_duplica[k_riga_x_dup].prezzo
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo) 
				
				kst_listino_duplica[k_riga].prezzo_2 = kist_listino_duplica[k_riga_x_dup].prezzo_2
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo_2) 

				kst_listino_duplica[k_riga].prezzo_3 = kist_listino_duplica[k_riga_x_dup].prezzo_3
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo_3) 

				kst_listino_duplica[k_riga].attivo = kiuf_listino.kki_attivo_da_fare

				kiuf_esito_operazioni.tb_add_riga("--------> Duplica LISTINO: ' " + string(kst_listino_duplica[k_riga].id_listino) +" ' <--------", false)
				kiuf_esito_operazioni.tb_add_riga("     --------> prezzo da " + string(kist_listino_duplica[k_riga_x_dup].prezzo, "0.00") &
												 + " a " + string(kst_listino_duplica[k_riga].prezzo, "0.00") + " - prezzo 2 da " + string(kist_listino_duplica[k_riga_x_dup].prezzo_2, "0.00") &
												 + " a " + string(kst_listino_duplica[k_riga].prezzo_2, "0.00") + " - prezzo 3 da " + string(kist_listino_duplica[k_riga_x_dup].prezzo_3, "0.00") &
												 + " a " + string(kst_listino_duplica[k_riga].prezzo_3, "0.00") + " <--------", false)
				
//--- Scrive LOG esiti su DB
				kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
				kst_listino_duplica[k_riga].esito_operazioni_ts_operazione = kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
			end if

		next
		
//--- se tutto OK  procedo con l'elaborazione		
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then	
			
			if this.rb_definitiva_si.checked then // è Vera o di simulazione?
				k_nr_duplicati = kiuf_listino_duplica_massiva.u_duplica_listini(kst_listino_duplica[])
				kist_listino_duplica[] = kst_listino_duplica
			else
				k_nr_duplicati = k_riga
			end if
			
			if k_nr_duplicati = 0 then
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
				kguo_exception.setmessage(k_titolo, " Nessun listino Duplicato ")
				kiuf_esito_operazioni.tb_add_riga("-----------> Elaborazione Terminata nessun LISTINO duplicato <-----------", false)
			else

				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
				if k_nr_duplicati = 1 then
					kguo_exception.setmessage(k_titolo, "Fine elaborazione, 1 Listino duplicato")
				else
					kguo_exception.setmessage(k_titolo, "Fine elaborazione, " + string(k_nr_duplicati) + " Listini duplicati")
				end if
				kiuf_esito_operazioni.tb_add_riga("-----------> Elaborazione Terminata LISTINI duplicati: " + string(k_nr_duplicati) +" <-----------", false)
			end if
		
//--- x DEFAULT Aggiorna DB (rb_DEFINITIVA)
			if k_nr_duplicati > 0 then
				if rb_definitiva_si.checked then

					u_set_dw_documenti_reset()
					popola_lista_da_st( ) // elaborazione effettuata pulisco l'elenco

//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						
				end if

			end if
		end if
			
		kguo_exception.messaggio_utente( )

	end if
	
catch (uo_exception kuo_exception)
	
	kiuf_esito_operazioni.tb_add_riga("-----------> Elaborazione interrotta per ERRORE: " + trim(kst_esito.sqlerrtext) + " - esito: " + string(kst_esito.esito) +" <-----------", true)
	kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()
	
finally
	if this.rb_definitiva_si.checked then // è di simulazione?
		kiuf_esito_operazioni.tb_add_riga("> FINE Operazioni di Duplica LISTINI <", false)
	else
		kiuf_esito_operazioni.tb_add_riga("> FILE SIMULAZIONE Duplica LISTINI <", false)
	end if
//--- Scrive LOG esiti su DB
	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
	kst_listino_duplica[k_riga].esito_operazioni_ts_operazione = kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)

	setpointer(kkg.pointer_default )
	
		
end try

end subroutine

public subroutine u_set_dw_documenti_prezzo_nuovo ();//
//---- Calcola PREZZO simulato nuovo
//
dec k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00
string k_espressione = "if (prezzo > 0 "


	k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
	if k_soglia_min > 0 then
		k_espressione += " and prezzo >= " + string(k_soglia_min)
	end if
	k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
	if k_soglia_max > 0 then
		k_espressione += " and prezzo <= " + string(k_soglia_max)
	else
		if k_soglia_min > 0 then
			k_espressione += " and prezzo <= 9999999 "
		end if
	end if
	
	choose case dw_box.getitemstring( 1, "tipo")
		case "P"
			k_percento = dw_box.getitemnumber( 1, "percento")
			if k_percento <> 0 then
				k_espressione += ", prezzo * (1 + " + string(k_percento) + "/100), 0) "
			end if
		case "I"
			k_importo = dw_box.getitemnumber( 1, "importo")
			if k_importo <> 0 then
				k_espressione += ", " + string(k_importo) + ", 0) "
			end if
		case "N"
			k_espressione = "0" 
	end choose
	
	dw_documenti.modify("k_prezzo.expression = '" + k_espressione + "' ")



end subroutine

public function boolean u_get_prezzo_nuovo (ref double a_prezzo);//
//--- Calcola PREZZO nuovo
//--- inp: prezzo vecchio
//--- out: prezzo nuovo
//--- rit: TRUE = da elaborare; FALSE = non rientra nelle soglie
//
//
boolean k_return = false
double k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00


	k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
	if k_soglia_min > 0 then
	else
		k_soglia_min = 0
	end if
	k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
	if k_soglia_max > 0 then
	else
		k_soglia_max = 9999999.99
	end if
	
	if a_prezzo >= k_soglia_min and a_prezzo <= k_soglia_max then
		k_return = true
		choose case dw_box.getitemstring( 1, "tipo")
			case "P"
				k_percento = dw_box.getitemnumber( 1, "percento")
				if k_percento <> 0 then
					a_prezzo = a_prezzo * (1 + k_percento/100)
				end if
			case "I"
				k_importo = dw_box.getitemnumber( 1, "importo")
				if k_importo <> 0 then
					a_prezzo = k_importo
				end if
			case "N"
				
		end choose
	end if
	
return k_return



end function

private function long u_get_nr_da_dup ();//
//---
//---
long k_return = 0
long k_riga=0, k_riga_ins=0, k_righe



setpointer(kkg.pointer_attesa)

k_righe = dw_documenti.rowcount()
for k_riga = 1 to k_righe

	if dw_documenti.getitemnumber(k_riga,"id_listino") > 0 then
		
//--- solo i documenti selezionati
		if not (rb_emissione_selezione.checked) or (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

			k_riga_ins++

		end if
	end if
		
		
end for

k_return = k_riga_ins

setpointer(kkg.pointer_default)  

return k_return



end function

public subroutine u_set_dw_documenti_reset ();//
//---- Reset del PREZZO simulato
//

	dw_documenti.modify("k_prezzo.expression = '0'")



end subroutine

on w_listino_duplica_massiva.create
int iCurrent
call super::create
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_emissione_selezione=create rb_emissione_selezione
this.rb_definitiva_si=create rb_definitiva_si
this.rb_definitiva_no=create rb_definitiva_no
this.pb_ok=create pb_ok
this.dw_documenti=create dw_documenti
this.st_1=create st_1
this.pb_st_esiti_operazioni=create pb_st_esiti_operazioni
this.dw_esiti=create dw_esiti
this.st_esiti_operazioni=create st_esiti_operazioni
this.dw_box=create dw_box
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
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
this.Control[iCurrent+8]=this.pb_st_esiti_operazioni
this.Control[iCurrent+9]=this.dw_esiti
this.Control[iCurrent+10]=this.st_esiti_operazioni
this.Control[iCurrent+11]=this.dw_box
this.Control[iCurrent+12]=this.gb_aggiorna
this.Control[iCurrent+13]=this.gb_emissione
this.Control[iCurrent+14]=this.gb_produzione
this.Control[iCurrent+15]=this.rr_1
end on

on w_listino_duplica_massiva.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_emissione_tutto)
destroy(this.rb_emissione_selezione)
destroy(this.rb_definitiva_si)
destroy(this.rb_definitiva_no)
destroy(this.pb_ok)
destroy(this.dw_documenti)
destroy(this.st_1)
destroy(this.pb_st_esiti_operazioni)
destroy(this.dw_esiti)
destroy(this.st_esiti_operazioni)
destroy(this.dw_box)
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
if isvalid(kiuf_listino) then destroy 	kiuf_listino
if isvalid(kiuf_listino_duplica_massiva) then destroy 	kiuf_listino_duplica_massiva

end event

event u_open;call super::u_open;//
u_resize()

end event

type st_ritorna from w_g_tab`st_ritorna within w_listino_duplica_massiva
integer x = 727
integer y = 2276
integer height = 72
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_listino_duplica_massiva
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_listino_duplica_massiva
integer x = 352
integer y = 2172
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_listino_duplica_massiva
integer x = 827
integer y = 2192
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_listino_duplica_massiva
integer x = 219
integer y = 2288
end type

type rb_emissione_tutto from radiobutton within w_listino_duplica_massiva
integer x = 73
integer y = 148
integer width = 873
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
string text = " Tutti i Listini in elenco"
end type

type rb_emissione_selezione from radiobutton within w_listino_duplica_massiva
integer x = 73
integer y = 240
integer width = 1056
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
string text = " Solo i Listini con ~'Sel~' attivato"
boolean checked = true
end type

type rb_definitiva_si from radiobutton within w_listino_duplica_massiva
integer x = 78
integer y = 1516
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
long backcolor = 67108864
string text = "EFFETTIVA (Duplica Listini)"
end type

type rb_definitiva_no from radiobutton within w_listino_duplica_massiva
integer x = 78
integer y = 1420
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

type pb_ok from picturebutton within w_listino_duplica_massiva
integer x = 69
integer y = 1704
integer width = 169
integer height = 124
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\testGammarad\pb_gmmrd126\icone\euro40.png"
vtextalign vtextalign = top!
end type

event clicked;//
this.enabled = false

//
string k_errore_dati


k_errore_dati = check_dati()

if  Left(k_errore_dati,1) = "0" then

	esegui( )

else

	messagebox("Dati errati",  Mid(k_errore_dati, 2))

end if


this.enabled = true


end event

type dw_documenti from uo_d_std_1 within w_listino_duplica_massiva
boolean visible = true
integer x = 1184
integer width = 2354
integer height = 2056
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_clienti_listino_l_sel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
end type

type st_1 from statictext within w_listino_duplica_massiva
integer x = 283
integer y = 1748
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
string text = "Avvia Operazione"
boolean focusrectangle = false
end type

type pb_st_esiti_operazioni from picturebutton within w_listino_duplica_massiva
integer x = 69
integer y = 1936
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

type dw_esiti from uo_d_std_1 within w_listino_duplica_massiva
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

type st_esiti_operazioni from statictext within w_listino_duplica_massiva
integer x = 215
integer y = 1968
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

type dw_box from datawindow within w_listino_duplica_massiva
event u_pigiato_enter pbm_dwnprocessenter
integer x = 46
integer y = 492
integer width = 1065
integer height = 744
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_box_cambio_prezzi"
boolean border = false
end type

event u_pigiato_enter;//
//--- trasforma l'ENTER in un TAB
//
send (Handle(this),256,9,long(0,0)) 

return 1 


end event

event itemchanged;//
//--- Protegge o meno i campi PERCENTO e IMPORTO
if dwo.name = "tipo" then
	choose case data
		case "P"
			this.Modify("percento.Protect='0'")		
			this.Modify("importo.Protect='1'")
	
			this.Modify("importo.Background.Color='-1' ")
			this.Modify("percento.Background.Color='" + string(rgb(255,255,255)) + "' ")
		case "I"
			this.Modify("percento.Protect='1'")		
			this.Modify("importo.Protect='0'")
	
			this.Modify("percento.Background.Color='-1' ")
			this.Modify("importo.Background.Color='" + string(rgb(255,255,255)) + "' ")
		case "N"
			this.Modify("percento.Protect='1'")		
			this.Modify("importo.Protect='1'")
	
			this.Modify("percento.Background.Color='-1' ")
			this.Modify("importo.Background.Color='-1' ")
	end choose
end if
	
post u_set_dw_documenti_prezzo_nuovo()


end event

type gb_aggiorna from groupbox within w_listino_duplica_massiva
integer x = 27
integer y = 1340
integer width = 1125
integer height = 288
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

type gb_emissione from groupbox within w_listino_duplica_massiva
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
string text = "  Applica DUPLICA a "
end type

type gb_produzione from groupbox within w_listino_duplica_massiva
integer x = 27
integer y = 404
integer width = 1125
integer height = 864
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Imposta nuovi Prezzi "
end type

type rr_1 from roundrectangle within w_listino_duplica_massiva
long linecolor = 8421504
long fillcolor = 134217731
integer x = 41
integer y = 1872
integer width = 1093
integer height = 12
integer cornerheight = 40
integer cornerwidth = 46
end type

