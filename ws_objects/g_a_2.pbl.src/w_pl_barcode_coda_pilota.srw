$PBExportHeader$w_pl_barcode_coda_pilota.srw
forward
global type w_pl_barcode_coda_pilota from w_g_tab0
end type
type st_barcode from statictext within w_pl_barcode_coda_pilota
end type
type dw_pilota from uo_d_std_1 within w_pl_barcode_coda_pilota
end type
type dw_dett_0_deleted from datawindow within w_pl_barcode_coda_pilota
end type
type dw_modifica from uo_dw_modifica_giri_barcode within w_pl_barcode_coda_pilota
end type
type dw_modifica_giri_scambio from uo_dw_modifica_giri_barcode_scambio within w_pl_barcode_coda_pilota
end type
type dw_dett_0_modificati from datawindow within w_pl_barcode_coda_pilota
end type
type dw_dett_0_appo from uo_d_std_1 within w_pl_barcode_coda_pilota
end type
type dw_sposta from datawindow within w_pl_barcode_coda_pilota
end type
end forward

global type w_pl_barcode_coda_pilota from w_g_tab0
integer width = 3223
integer height = 2508
string title = "Programmazione Impianto"
long backcolor = 553648127
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
st_barcode st_barcode
dw_pilota dw_pilota
dw_dett_0_deleted dw_dett_0_deleted
dw_modifica dw_modifica
dw_modifica_giri_scambio dw_modifica_giri_scambio
dw_dett_0_modificati dw_dett_0_modificati
dw_dett_0_appo dw_dett_0_appo
dw_sposta dw_sposta
end type
global w_pl_barcode_coda_pilota w_pl_barcode_coda_pilota

type variables
//
private string ki_path_risorse 
private boolean ki_dragdrop = false
private string ki_dragdrop_display = " "
private long ki_lbuttondown_row = 0

//private long ki_riga_inizio_dragdrop = 0
private long ki_riga_selected = 0
private long ki_clicked_row = 0
private long ki_riga_dragwithin = 0

private long ki_ordine_primo_numero=0
ds_pl_barcode kids_pl_barcode
private boolean ki_abilita_funzione_giri = false
st_tab_pilota_impostazioni kist_tab_pilota_impostazioni
datawindow  kidw_dett_0_da_non_modificare

private boolean ki_invio_programma_eseguito = false

private integer ki_minuto_timer=0

private boolean k_risize = true
end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected function string inizializza_post ()
private subroutine ordine_rinumerazione ()
private subroutine leggi_pilota ()
private subroutine screma_intoccabili ()
private subroutine allerta_chiudi ()
protected subroutine stampa ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine popola_ds_pl_barcode ()
private subroutine crea_richiesta_pilota () throws uo_exception
protected function string check_dati ()
protected function string cancella ()
private subroutine modifica_giri (string k_modalita_modifica_file)
private subroutine abilita_modifica_giri ()
private function long retrieve_dw () throws uo_exception
private subroutine modifica_giri_ripristina ()
private subroutine cancella_toglie_barcode_da_pl () throws uo_exception
protected function integer ritorna (string k_titolo)
private function integer call_window_barcode ()
private subroutine sposta_barcode (long k_riga_dest) throws uo_exception
private function st_esito controllo_allineamento_pilota () throws uo_exception
protected subroutine open_start_window ()
private subroutine check_file_command ()
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public subroutine u_resize ()
public function boolean u_resize_predefinita ()
end prototypes

protected function string inizializza () throws uo_exception;//
//--- Inizializzazione e Retrieve delle DW
//
string k_return="2 "
int  k_rc
uo_exception kuo_exception
kuf_pilota_cmd kuf1_pilota_cmd
st_tab_pilota_cfg kst_tab_pilota_cfg



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)


//--- connessione al DB Pilota
try 

//--- Disattivo momentaneamente il timer ogni tot secondi	
	timer( 0 )

	kuf1_pilota_cmd = create kuf_pilota_cmd

	kuf1_pilota_cmd.get_path_file_pl_barcode()  // solo X testare se PATH raggiungibile

//	kguo_sqlca_db_pilota.db_connetti()   28052014 la connessione/disconnessione ci pensa SETTRANS in automatico
	
//--- retrieve
//	dw_lista_0.settransobject(kguo_sqlca_db_pilota) 
	dw_lista_0.settrans(kguo_sqlca_db_pilota)   // apre/chiude la connessione in automatico ad ogni Operazione tipo Retrieve/Update...
//	dw_dett_0.settransobject(kguo_sqlca_db_pilota)
	dw_dett_0.settrans(kguo_sqlca_db_pilota)   // apre/chiude la connessione in automatico ad ogni Operazione tipo Retrieve/Update...
//	dw_dett_0_appo.settransobject(kguo_sqlca_db_pilota)
	dw_dett_0_appo.settrans(kguo_sqlca_db_pilota)   // apre/chiude la connessione in automatico ad ogni Operazione tipo Retrieve/Update...
//	dw_pilota.settransobject(kguo_sqlca_db_pilota)
	dw_pilota.settrans(kguo_sqlca_db_pilota)   // apre/chiude la connessione in automatico ad ogni Operazione tipo Retrieve/Update...

//--- Controlla che non ci siano P.L. in cartella quindi che il Pilota deve ancora acchiappare
//	check_file_command()

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

//--- Blocca la produzione delle richieste al Pilota 	
		kst_tab_pilota_cfg.blocca_richieste = kuf1_pilota_cmd.ki_blocca_richieste_si
		kuf1_pilota_cmd.set_blocca_richieste(kst_tab_pilota_cfg)

	end if
	
//--- Becca le impostazioni di configurazione del pilota, specie il numero degli intoccabili
	kist_tab_pilota_impostazioni = kuf1_pilota_cmd.get_pilota_pilota_impostazioni()

	if kist_tab_pilota_impostazioni.num_intouchable < 3 then
		SetPointer(kkg.pointer_default)
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
		kuo_exception.setmessage( "Il Pilota non prevede un numero sufficiente di Barcode 'Intoccabili'~n~r" &
			 + "per operare con questa funzione. ~n~r(numero Intoccabili impostati =" + string (kist_tab_pilota_impostazioni.num_intouchable) + ") " &
			 )
		kuo_exception.messaggio_utente( )
		destroy kuo_exception
		k_return="2 " // EXIT!
		//cb_ritorna.postevent("clicked!")
		
	else	

		
		k_rc = retrieve_dw() 

		choose case k_rc
	
			case is < 0				
				SetPointer(kkg.pointer_default)
				kuo_exception = create uo_exception
				kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_db_ko)
				kuo_exception.setmessage( "Mi spiace ma si e' verificato un errore interno al programma~n~r" &
					 + "(RC=" + string (k_rc) + ") " &
					 )
				kuo_exception.messaggio_utente( )
				destroy kuo_exception
				k_return="2 " // EXIT!
				//cb_ritorna.postevent("clicked!")
	
	//--- nessun codice trovato
			case 0
				SetPointer(kkg.pointer_default)
				kuo_exception = create uo_exception
				kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_not_fnd)
				kuo_exception.setmessage( "Nessun Bancale in Programmazione (oltre agli intoccabili)  ~n~r" &
					 )
				kuo_exception.messaggio_utente( )
				destroy kuo_exception
				k_return="2 " // EXIT!
				//cb_ritorna.postevent("clicked!")
					
	//--- se codice trovato
			case is > 0		
				k_return = "0 "
				dw_dett_0.resetupdate()
	
				ki_ordine_primo_numero = dw_dett_0.getitemnumber(1, "ordine")
				
				dw_lista_0.selectrow(0, false)
				dw_lista_0.scrolltorow(dw_lista_0.rowcount())
				dw_lista_0.resetupdate()
					
				leggi_pilota()
				screma_intoccabili	()

				dw_dett_0.bringtotop = true

				if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
					abilita_modifica_giri()

//--- Attivo  il timer ogni tot secondi	
				//	timer( 15 ) NON FUNZIONA IN MODALITA' DOCKING
				end if
				
		end choose

	end if
	
//--- Se ERRORE
catch ( uo_exception k1uo_exception)

	k1uo_exception.messaggio_utente( )
	k_return="2 " // EXIT!
//	cb_ritorna.postevent(clicked!)

finally
	dw_sposta.visible = false
	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd
	SetPointer(kkg.pointer_default)

end try




return k_return


end function

protected function string inizializza_post ();//
dw_lista_0.selectrow(0, false)

dw_dett_0.setfocus()

this.backcolor = rgb(250,10,0)

return "0"

end function

private subroutine ordine_rinumerazione ();//--- 
//--- Rinumerazione della colonna ordine solitamente dopo uno spostamento di riga
//---
long k_ctr, k_ctr1


if ki_ordine_primo_numero > 0 then
	if ki_ordine_primo_numero > dw_dett_0.rowcount() then
		k_ctr1 = dw_dett_0.rowcount()
	end if

	k_ctr1 = ki_ordine_primo_numero
	for k_ctr = 1 to dw_dett_0.rowcount()
	
		dw_dett_0.setitem(k_ctr, "ordine", k_ctr1)
		if mod(k_ctr,2) = 0 then
			dw_dett_0.setitem(k_ctr, "posizione", "B")
		else
			dw_dett_0.setitem(k_ctr, "posizione", "H")
		end if
		k_ctr1++
	end for

end if	

end subroutine

private subroutine leggi_pilota ();//---
//---
//--
dw_pilota.reset()
if dw_pilota.retrieve() > 0 then

	dw_pilota.selectrow(0, false)
	dw_pilota.resetupdate()
	dw_pilota.title = "Ora: " + string(time(now()), "hh:mm:ss") + " Coda Programmazione Impianto"
	
end if

end subroutine

private subroutine screma_intoccabili ();//---
//--- Flegga a IN LAVORAZIONE i bancali che sono negli intoccabili
//--
long k_riga=0, k_riga_find


for k_riga = 1 to dw_lista_0.rowcount()
		
	k_riga_find =  dw_pilota.find("barcode = '"+ dw_lista_0.getitemstring(k_riga, "barcode") +"' ", 1,dw_pilota.rowcount())
	if k_riga_find > 0 then
		dw_lista_0.setitem (k_riga, "k_in_lavorazione", "0")
	else
		dw_lista_0.setitem (k_riga, "k_in_lavorazione", "1")
	end if

end for	

end subroutine

private subroutine allerta_chiudi ();//---
//--- Emette il messaggio di Allerta 
//---
long k_ctr, k_ctr1=0
uo_exception kuo_exception


//--- conta i barcode 'intoccabili' in lavorazione
k_ctr1 = 0
for k_ctr = 1 to dw_lista_0.rowcount()

	if dw_lista_0.getitemstring(k_ctr, "k_in_lavorazione") = "0" then
		k_ctr1++
	end if
	
end for

if k_ctr1 < 4 then

//--- se i barcode intoccabili sono FINITI tutti in LAVORAZIONE Chiudo la finestra !
	if k_ctr1 < 2 then

//---- Se Programma non inviato Ripristina i giri modificati
		if not(ki_invio_programma_eseguito) then
			modifica_giri_ripristina()
		end if
		
		cb_ritorna.postevent(clicked!)
		
	else
//--- se i barcode intoccabili da Lavorare sono meno di 4 (quindi solo 2) Messaggio di Allerta
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_allerta)
		kuo_exception.setmessage("Concludere Immediatamente l'operazione.~n~r" &
									 + "Procedere con l'Invio della Programmazione al PILOTA o Chiudere questa Funzione.~n~r" &
									 + "Tra qualche istante il Programma sara' comunque terminato in automatico.~n~r" &
							+" ")
		kuo_exception.messaggio_utente()

	end if
	
end if



end subroutine

protected subroutine stampa ();//
string k_nome_controllo = " "
st_stampe kst_stampe
w_g_tab kwindow_1


k_nome_controllo = kGuf_data_base.u_getfocus_nome()
choose case k_nome_controllo
	case "dw_lista_0"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_lista_0
		kst_stampe.titolo = trim(dw_lista_0.title)
		kGuf_data_base.stampa_dw(kst_stampe)

	case "dw_dett_0"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_dett_0
		kst_stampe.titolo =trim(dw_dett_0.title)
		kGuf_data_base.stampa_dw(kst_stampe)

	case "dw_pilota"
	
		kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
		kst_stampe.dw_print = dw_pilota
		kst_stampe.titolo = trim(dw_pilota.title)
		kGuf_data_base.stampa_dw(kst_stampe)
		
		
end choose

end subroutine

protected subroutine attiva_menu ();//
boolean k_attiva


	st_aggiorna_lista.enabled  = false
	ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 


	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
		or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento  then
		k_attiva = true
	else
		k_attiva = false
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_attiva then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "&Sposta Bancali"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Sposta in altra posizione i Bancali selezionati  "
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = k_attiva
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = "Sposta,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero1.text
	//	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "Move5!"
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> ki_abilita_funzione_giri then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "&Cicli di Lavorazione"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"Visualizza/Modifica i cicli di trattamento del Barcode   "
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = ki_abilita_funzione_giri
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Giri,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero2.text
	//	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		//ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = ki_path_risorse + "\cicli.bmp"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cicli.bmp"
	end if
	
	if not ki_menu.m_strumenti.m_fin_gest_libero3.visible then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Barcode &Modificati"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
		"Mostra/Nascondi elenco dei Barcode con i 'giri' modificati"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Mostra,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
	//	ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "Form!"
	end if	
	
	if not ki_menu.m_strumenti.m_fin_gest_libero4.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Elenco &Rimossi"
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
		"Mostra/Nascondi elenco dei Barcode rimossi dalla Programmazione   "
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext = "Rimossi," +&
												 ki_menu.m_strumenti.m_fin_gest_libero4.text
	//	ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex = 4
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "Error!"
	end if	

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
				or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento  then
		k_attiva = true
	else
		k_attiva = false
	end if
	if ki_menu.m_strumenti.m_fin_gest_libero5.enabled <> k_attiva then
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "&Invia Programmazione al Pilota"
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = &
		"Aggiorna  la Programmazione gia' in coda inviandola al Pilota  "
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = k_attiva
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext = "Invia,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemname = "OleGenReg!"
	end if
	
	if not ki_menu.m_strumenti.m_fin_gest_libero6.visible then
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Dettaglio &Barcode"
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp = &
		"Visualizza dettaglio del Barcode"
		ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext = "Barcode,"+&
												 ki_menu.m_strumenti.m_fin_gest_libero6.text
	//	ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex = 2
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = "barcode.bmp"
	end if


	super::attiva_menu()

	
end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===
uo_exception kuo1_exception
st_esito kst_esito


choose case Left(k_par_in, 2) 


//--- Personalizzo da qui

	case "l1"		//propone il DW x sposta righe
		dw_sposta.event u_attiva( )

	case "l2"		//modifica i cilci del riferimento
		if ki_abilita_funzione_giri then
//--- controlle se consentito solo visualizzazione
			if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione then
				modifica_giri(dw_modifica.ki_modalita_modifica_giri_visualizza)
			else
				if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif then
//--- controlla se il Pilota e' stato inaspettamente aggiornato	
					try
						kst_esito = controllo_allineamento_pilota() 
						if kst_esito.esito = kkg_esito.ok then
							modifica_giri(dw_modifica.ki_modalita_modifica_giri_riga)
						else
							kuo1_exception = create uo_exception
							kuo1_exception.setmessage("La coda Pilota e' stata Inaspettatamente Aggiornata~n~r" &
																+ kst_esito.sqlerrtext & 
																 +" ~n~rL'operazione non puo' essere effettuata. Uscire dalla Funzione.") //--- errore
							kuo1_exception.messaggio_utente()
						end if
					catch (uo_exception kuo_exception)
						kuo_exception.messaggio_utente()
					end try
				end if
			end if
		end if

	case "l3"		//mostra/nasconde elenco barcode modificati
		if dw_dett_0_modificati.visible then
			dw_dett_0_modificati.visible = false
		else
			dw_dett_0_modificati.visible = true
		end if

	case "l4"		//mostra/nasconde elenco barcode cancellati
		if dw_dett_0_deleted.visible then
			dw_dett_0_deleted.visible = false
		else
			dw_dett_0_deleted.visible = true
		end if

	case "l5"		//Crea e Invia al Pilota la coda
		try
			crea_richiesta_pilota()
			kuo1_exception = create uo_exception
			kuo1_exception.setmessage("Operazione Conclusa, dati Inviati al Pilota.")
			kuo1_exception.messaggio_utente()
		catch (uo_exception k1uo_exception)

			if not(ki_invio_programma_eseguito) then
				modifica_giri_ripristina()
			end if

			k1uo_exception.messaggio_utente()
		end try

	case "l6"		//dettaglio barcode
		call_window_barcode()

		
	case else // standard
		super::smista_funz(k_par_in)
		
end choose

end subroutine

private subroutine popola_ds_pl_barcode ();
//---
//--- Popola il ds x generare il file Pilota 
//---
//---
long k_riga, k_riga_ds
kuf_pl_barcode kuf1_pl_barcode
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


k_riga_ds=0
kids_pl_barcode.reset()

//--- popola la prima parte del ds con i dati intoccabili
for k_riga = 1 to dw_lista_0.rowcount()
	k_riga_ds = kids_pl_barcode.insertrow(0)
	kids_pl_barcode.object.pl_barcode_progr[k_riga_ds] = k_riga_ds
	kids_pl_barcode.object.barcode[k_riga_ds] = dw_lista_0.object.barcode[k_riga]
	kids_pl_barcode.object.groupage[k_riga_ds] = kuf1_pl_barcode.k_groupage_no
	kids_pl_barcode.object.fila_1[k_riga_ds] = dw_lista_0.object.ciclifila1[k_riga]
	kids_pl_barcode.object.fila_2[k_riga_ds] = dw_lista_0.object.ciclifila2[k_riga]
	kids_pl_barcode.object.fila_1p[k_riga_ds] = dw_lista_0.object.ciclifila1p[k_riga]
	kids_pl_barcode.object.fila_2p[k_riga_ds] = dw_lista_0.object.ciclifila2p[k_riga]
	kids_pl_barcode.object.num_int[k_riga_ds] = dw_lista_0.object.k_num_int[k_riga]
	kids_pl_barcode.object.clie_2[k_riga_ds] = dw_lista_0.object.k_clie_2[k_riga]
	kids_pl_barcode.object.area_mag[k_riga_ds] = dw_lista_0.object.k_area_mag[k_riga]
	kids_pl_barcode.object.rag_soc_10[k_riga_ds] = dw_lista_0.object.k_rag_soc_10[k_riga]
	if len(trim(dw_lista_0.object.k_consegna_data[k_riga])) > 0 then
		kids_pl_barcode.object.consegna_data[k_riga_ds] = date(dw_lista_0.object.k_consegna_data[k_riga])
	end if
end for

//--- popola la parte dei dati toccabili 
for k_riga = 1 to dw_dett_0.rowcount()
	k_riga_ds = kids_pl_barcode.insertrow(0)
	kids_pl_barcode.object.pl_barcode_progr[k_riga_ds] = k_riga_ds
	kids_pl_barcode.object.barcode[k_riga_ds] = dw_dett_0.object.barcode[k_riga]
	kids_pl_barcode.object.groupage[k_riga_ds] =kuf1_pl_barcode.k_groupage_no
	kids_pl_barcode.object.fila_1[k_riga_ds] = dw_dett_0.object.ciclifila1[k_riga]
	kids_pl_barcode.object.fila_2[k_riga_ds] = dw_dett_0.object.ciclifila2[k_riga]
	kids_pl_barcode.object.fila_1p[k_riga_ds] = dw_dett_0.object.ciclifila1p[k_riga]
	kids_pl_barcode.object.fila_2p[k_riga_ds] = dw_dett_0.object.ciclifila2p[k_riga]
	kids_pl_barcode.object.num_int[k_riga_ds] = dw_dett_0.object.k_num_int[k_riga]
	kids_pl_barcode.object.clie_2[k_riga_ds] = dw_dett_0.object.k_clie_2[k_riga]
	kids_pl_barcode.object.area_mag[k_riga_ds] = dw_dett_0.object.k_area_mag[k_riga]
	kids_pl_barcode.object.rag_soc_10[k_riga_ds] = dw_dett_0.object.k_rag_soc_10[k_riga]
	if len(trim(dw_dett_0.object.k_consegna_data[k_riga])) > 0 then
		kids_pl_barcode.object.consegna_data[k_riga_ds] = date(dw_dett_0.object.k_consegna_data[k_riga])
	end if
end for


SetPointer(oldpointer)


end subroutine

private subroutine crea_richiesta_pilota () throws uo_exception;//---
//--- Crea la richiesta x il Pilota 
//---
//---
//---
string k_errore
kuf_pl_barcode kuf1_pl_barcode
kuf_pilota_cmd kuf1_pilota_cmd
kuf_utility kuf1_utility
st_esito kst_esito
st_tab_pl_barcode kst_tab_pl_barcode



try

	if messagebox ("Invio Programmazione Impianto", &
						"L'operazione AGGIORNA la Programmazione ATTUALE del Pilota !!~n~r" &
						+" ~n~r" &
						+ "Vuoi proseguire?" &
						 ,question!, YesNo!, 2) = 2 then

		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_generico)
		kguo_exception.setmessage("Nessun Dato Inviato.~n~r" &
											+"L'operazione non e' stata eseguita..") 
		throw kguo_exception

	else

		kuf1_pilota_cmd = create kuf_pilota_cmd
		kuf1_pl_barcode = create kuf_pl_barcode
		kuf1_utility = create kuf_utility
	
		ordine_rinumerazione()
		
	//--- controlla se il Pilota e' stato inaspettamente aggiornato		
		kst_esito = controllo_allineamento_pilota() 
		
		if kst_esito.esito = kkg_esito.ok then
				
	//--- controlla se Programmazione OK		
			k_errore = check_dati() 
			if LeftA(k_errore, 1) <>  "0" then
			
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				kguo_exception.setmessage(MidA(k_errore, 2) )
				throw kguo_exception
			
			else
//=== Crea un nuovo Piano di Lavorazione con i Barcode Padre
				popola_ds_pl_barcode() 
				if kids_pl_barcode.rowcount() > 0 then

//--- toglie i barcode cancellati anche dalla Pianificazione
					cancella_toglie_barcode_da_pl()
				
//=== Job di generazione della Richiesta  
					kuf1_pilota_cmd.job_sostituzione_programmazione_pilota(kids_pl_barcode)

//--- Accende il flag di invio andato a buon fine
					ki_invio_programma_eseguito = true


				else
					
					timer( 0 )   // Disattivo il timer x non fare più retrieve

					ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione		
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
					kguo_exception.setmessage("Nessun Bancale estratto.~n~r" &
																		 +"L'operazione non e' stata eseguita. Uscire dalla Funzione.") //--- errore
					throw kguo_exception
					
				end if
					
				timer( 0 )   // Disattivo il timer x non fare più retrieve
	
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione		
				abilita_modifica_giri()
				attiva_tasti()
	
	//--- tutto ok sblocca le richieste		
				kuf1_pilota_cmd.kist_tab_pilota_cfg.blocca_richieste = kuf1_pilota_cmd.ki_blocca_richieste_no
				kuf1_pilota_cmd.set_blocca_richieste( kuf1_pilota_cmd.kist_tab_pilota_cfg )
	
	//--- poi disabilito le dw di modifica
				kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	
			end if
			
		else
					
			timer( 0 )   // Disattivo il timer x non fare più retrieve

			ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione		
	//--- tutto KO sblocca le richieste		
			kuf1_pilota_cmd.kist_tab_pilota_cfg.blocca_richieste = kuf1_pilota_cmd.ki_blocca_richieste_no
			kuf1_pilota_cmd.set_blocca_richieste( kuf1_pilota_cmd.kist_tab_pilota_cfg )
	//--- poi disabilito le dw di modifica
			kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
			
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
			kguo_exception.setmessage("La coda Pilota e' stata Inaspettatamente Aggiornata~n~r" &
																+ kst_esito.sqlerrtext &
																 +" ~n~rL'operazione non puo' essere effettuata. Uscire dalla Funzione.") //--- errore
	
			throw kguo_exception
		end if
	

	end if
		
catch(uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()  //--- errore
	throw kuo_exception
	
finally
	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd
	if isvalid(kuf1_pl_barcode) then destroy kuf1_pl_barcode
	if isvalid(kuf1_utility) then destroy kuf1_utility
end try

end subroutine

protected function string check_dati ();//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//
//=== Controllo dati inseriti
string k_return = " ", k_errore="0", k_barcode=""
int k_nr_errori, k_pl_barcode_progr 
long k_riga, k_nr_righe, k_riga_find, k_riga_ds
st_esito kst_esito
kuf_base kuf1_base
kuf_pl_barcode kuf1_pl_barcode
ds_pl_barcode_dett kds_pl_barcode_dett


	kds_pl_barcode_dett = create ds_pl_barcode_dett

	dw_dett_0.accepttext()
	
		k_nr_righe = dw_dett_0.rowcount()
		k_nr_errori = 0
		k_riga_find = 0 
		k_riga = 1 //dw_dett_0.getnextmodified(0, primary!)
	
		do while k_nr_righe >= k_riga and k_nr_errori < 10
	
			k_pl_barcode_progr = dw_dett_0.getitemnumber ( k_riga, "ordine")
			
//--- Tolgo valori a null dai giri
			if isnull(dw_dett_0.getitemnumber ( k_riga, "ciclifila1")) then
				dw_dett_0.setitem ( k_riga, "ciclifila1", 0)
			end if
			if isnull(dw_dett_0.getitemnumber ( k_riga, "ciclifila1p")) then
				dw_dett_0.setitem ( k_riga, "ciclifila1p", 0)
			end if
			if isnull(dw_dett_0.getitemnumber ( k_riga, "ciclifila2")) then
				dw_dett_0.setitem ( k_riga, "ciclifila2", 0)
			end if
			if isnull(dw_dett_0.getitemnumber ( k_riga, "ciclifila2p")) then
				dw_dett_0.setitem ( k_riga, "ciclifila2p", 0)
			end if

//--- Popolo il Datastore x il controllo della Programmazione
			k_riga_ds = kds_pl_barcode_dett.insertrow(0)
			kds_pl_barcode_dett.object.pl_barcode_progr[k_riga_ds] = dw_dett_0.getitemnumber ( k_riga, "ordine")
			kds_pl_barcode_dett.object.fila_1[k_riga_ds] = dw_dett_0.getitemnumber ( k_riga, "ciclifila1")
			kds_pl_barcode_dett.object.fila_2[k_riga_ds] = dw_dett_0.getitemnumber ( k_riga, "ciclifila2")
			kds_pl_barcode_dett.object.fila_1p[k_riga_ds] = dw_dett_0.getitemnumber ( k_riga, "ciclifila1p")
			kds_pl_barcode_dett.object.fila_2p[k_riga_ds] = dw_dett_0.getitemnumber ( k_riga, "ciclifila2p")
			kds_pl_barcode_dett.object.tipo_cicli[k_riga_ds] = dw_dett_0.getitemstring ( k_riga, "k_tipo_cicli")
			kds_pl_barcode_dett.object.barcode[k_riga_ds] = dw_dett_0.getitemstring ( k_riga, "barcode")  // 21.01.2015
			
			k_riga++ // = dw_dett_0.getnextmodified(k_riga, primary!) 
	
		loop


//--- Controllo programmazione (ripristinato il 05/03/2013)
		try
			kuf1_pl_barcode = create kuf_pl_barcode 
//			kst_esito = kuf1_pl_barcode.pl_barcode_check_pianificazione(kds_pl_barcode_dett)
			kuf1_pl_barcode.if_pianificazione_ok(kds_pl_barcode_dett, "modifica") 
//			destroy kuf1_pl_barcode

		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = k_return + trim(kst_esito.sqlerrtext) + "~n~r"
				k_errore = "3"
			end if
			
		end try

destroy kds_pl_barcode_dett

return k_errore + trim(k_return)



end function

protected function string cancella ();//
//--- Toglie dall'elenco della programmazione il Barcode selezionato
//---
long k_riga=0, k_riga_ins=0, k_riga_last=0
int k_elabora=0
pointer oldpointer  // Declares a pointer variable



//dw_dett_0.setredraw(false)

//--- disattivo la selectrow dello standard
dw_dett_0.ki_attiva_standard_select_row = false

//--- controllo se ho fatto una multi-selezione
k_riga = dw_dett_0.getselectedrow(0)
if k_riga > 0 then
	if dw_dett_0.getselectedrow(k_riga) > 0 then

		k_elabora = messagebox ("Togli Bancali Selezionati", &
	 		 "Toglie Tutti i Bancali selezionati dalla Programmazione a cominciare dal~n~r" + trim(dw_dett_0.object.barcode[dw_dett_0.getselectedrow(0)])+" " +  "~n~r"&
	  		+"Sei sicuro di voler procedere?", Question!, yesno!, 2) 

	
	else

		k_elabora = messagebox ("Togli Bancale", &
	 		 "Toglie il Bancale " + trim(dw_dett_0.object.barcode[dw_dett_0.getselectedrow(0)])+" dalla Programmazione" +  "~n~r"&
	  		+"Sei sicuro di voler procedere?", Question!, yesno!, 2) 

	end if		
end if 


if k_elabora = 1 then


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	k_riga = dw_dett_0.getselectedrow(0)
	do while k_riga > 0 	


//		k_riga_ins=dw_dett_0_deleted.insertrow(0)
//		dw_dett_0.Rowscopy(k_riga, k_riga, primary!, dw_dett_0_deleted, k_riga_ins, Primary!)	
//		dw_dett_0.deleterow(dw_dett_0.getrow())
		
		dw_dett_0.RowsMove(k_riga, k_riga, primary!, dw_dett_0_deleted, 1, Primary!)	

		k_riga_last  = k_riga
		k_riga = dw_dett_0.getselectedrow(0)
		
	loop

	SetPointer(oldpointer)
	
end if

if dw_dett_0.rowcount() > 0 and k_riga_last > 0 then
	
	if dw_dett_0.rowcount() < k_riga_last then
		k_riga_last = dw_dett_0.rowcount()
	end if
	dw_dett_0.selectrow(0, false)
	dw_dett_0.setrow(k_riga_last)
	dw_dett_0.selectrow(k_riga_last, true)
	dw_dett_0.scrolltorow(k_riga_last)

end if

dw_dett_0.ki_attiva_standard_select_row = true


return "0"

end function

private subroutine modifica_giri (string k_modalita_modifica_file);//
//--- k_modalita_modifica_file: 1=modalità modifica giri fila 1 e 2 
//
integer k_rec, k_riga, k_riga_mod
string k_dw_fuoco_nome
string k_aggiorna_rif
line kline_1
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode

 

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.modifica &
		and ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
	
		dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
	
	end if

//---
	setnull(kidw_dett_0_da_non_modificare) 
	dw_modifica.ki_modif_tutto_riferimento = dw_modifica.ki_modif_tutto_riferimento_no
	
	kuf1_barcode = create kuf_barcode
	
//--- se sono in modalita di modifica riga e ho selezionato piu' righe passo alla modalita
//--- modifica piu' righe
	if k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_riga then
		k_riga = dw_dett_0.getselectedrow(0)

		k_riga_mod = 0
		do while k_riga > 0
			
			k_riga_mod ++
			dw_dett_0.RowsCopy(k_riga, k_riga, primary!, dw_dett_0_modificati, k_riga_mod, Primary!)	
			
			k_riga = dw_dett_0.getselectedrow(k_riga)

		loop
		
		if k_riga_mod > 1 then
			k_modalita_modifica_file = dw_modifica.ki_modalita_modifica_giri_righe
		end if
	end if

	k_riga = dw_dett_0.getrow() 
	if k_riga > 0 then		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.barcode = dw_dett_0.object.barcode.primary[k_riga]
		kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode)
		if kst_esito.esito <> kkg_esito.ok then
			messagebox("Modifica Cicli di Trattamento", &
						"Errore durante Ricerca del Barcode~n~r"+kst_esito.sqlerrtext)
		else
			kst_tab_barcode.num_int = kst_tab_barcode.num_int
			kst_tab_barcode.data_int = kst_tab_barcode.data_int
			kst_tab_barcode.fila_1 = dw_dett_0.object.ciclifila1.primary[k_riga]
			kst_tab_barcode.fila_1p = dw_dett_0.object.ciclifila1p.primary[k_riga]
			kst_tab_barcode.fila_2 = dw_dett_0.object.ciclifila2.primary[k_riga]
			kst_tab_barcode.fila_2p = dw_dett_0.object.ciclifila2p.primary[k_riga]
		end if	
	end if	


	if k_riga > 0 then

		kidw_dett_0_da_non_modificare = create datawindow
		
		kidw_dett_0_da_non_modificare.reset()
		
		for k_riga = 1 to dw_dett_0.rowcount()
			k_rec = dw_modifica_giri_scambio.insertrow(0)
			dw_modifica_giri_scambio.object.barcode_fila_1[k_riga] = dw_dett_0.object.ciclifila1[k_riga]	
			dw_modifica_giri_scambio.object.barcode_fila_1p[k_riga] = dw_dett_0.object.ciclifila1p[k_riga]	
			dw_modifica_giri_scambio.object.barcode_fila_2[k_riga] = dw_dett_0.object.ciclifila2[k_riga]	
			dw_modifica_giri_scambio.object.barcode_fila_2p[k_riga] = dw_dett_0.object.ciclifila2p[k_riga]	
			dw_modifica_giri_scambio.object.barcode_barcode[k_riga] = dw_dett_0.object.barcode[k_riga]
		end for
		dw_modifica_giri_scambio.selectrow(0, false)
		for k_riga = 1 to dw_dett_0.rowcount()
			if dw_dett_0.getselectedrow(k_riga - 1) = k_riga then
				dw_modifica_giri_scambio.selectrow(k_riga, true)
			end if

		end for
			
		dw_modifica.modifica_giri(&
										kst_tab_barcode &
										,k_modalita_modifica_file &
										,dw_modifica.ki_modif_tutto_riferimento &
										,dw_modifica_giri_scambio &
										,kidw_dett_0_da_non_modificare &
										)

												
	else
		messagebox("Modifica Cicli di Trattamento", &
						"Selezionare una riga nella lista")
	end if	

	destroy kuf1_barcode

//else
//	messagebox("Modifica non permessa", &
//						"In questa modalita' non e' consentita la modifica dei dati")
//end if
	 


end subroutine

private subroutine abilita_modifica_giri ();//
//--- controllo autorizzazione x cambio giri di lavorazione
//

	try

		ki_abilita_funzione_giri = dw_modifica.autorizza_modifica_giri()
	
		if dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_modif &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento &
			and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica then
			dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		end if


	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()			
		ki_abilita_funzione_giri = false
		dw_modifica.ki_modifica_cicli_enabled = dw_modifica.ki_modifica_cicli_enabled_visualizzazione
		
	finally			
	end try

end subroutine

private function long retrieve_dw () throws uo_exception;//---
//---
//--- Popola le DW dei Bancali (barcode) INTOCCABILI e dei Modificabili
//---
//--- gli intoccabili sono cosi' ripartiti:
//---      1/4 del num_intouchable sono di fila 2
//---      3/4 del num_intouchable sono di fila 1
//---
long  k_intoccabili, k_intoccabili_fila1, k_intoccabili_fila2, k_riga_intoccabili, k_riga_modificabili 
string k_CicliFila1, k_CicliFila2, k_CicliFila1p, k_CicliFila2p
boolean k_insert_intoccabili
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_pilota_queue kst_tab_pilota_queue


try

	declare c_retrieve_dw cursor for
		SELECT 
				  queue_table.Ordine ,
				  queue_table.Barcode ,
				  queue_table.Posizione ,
				  queue_table.CicliFila1  ,
				  queue_table.CicliFila2 ,
				  queue_table.CicliFila1P  ,
				  queue_table.CicliFila2P ,
				  queue_table.NN 
			  FROM queue_table
			order by ordine asc
			 using kguo_sqlca_db_pilota;
	
	
	
	dw_lista_0.reset()
	dw_dett_0.reset()
	
	k_intoccabili = kist_tab_pilota_impostazioni.num_intouchable
	k_intoccabili_fila1 = kist_tab_pilota_impostazioni.num_intoccabili_fila1   // integer((k_intoccabili /4) * 3)   // i 3/4 sono di fila 1
	k_intoccabili_fila2 = kist_tab_pilota_impostazioni.num_intoccabili_fila2   //k_intoccabili - k_intoccabili_fila1   // solo 1/4 sono di fila 2
	
	kguo_sqlca_db_pilota.db_connetti( )
	open c_retrieve_dw;
	if kguo_sqlca_db_pilota.sqlcode <> 0 then
		
		if kguo_sqlca_db_pilota.sqlcode < 0 then
			kguo_exception.inizializza()
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_db_ko)
			kguo_exception.setmessage("Errore durante lettura Coda Pilota~n~r"&
			+ "Codice errore: " +  string(kguo_sqlca_db_pilota.sqlcode) + "~n~r" &
			+ trim(kguo_sqlca_db_pilota.sqlerrtext)&
			)
			throw kguo_exception
		end if
	
	else
		fetch c_retrieve_dw into
				  :kst_tab_pilota_queue.Ordine ,
				  :kst_tab_pilota_queue.Barcode ,
				  :kst_tab_pilota_queue.Posizione ,
				  :k_CicliFila1,
				  :k_CicliFila2,
				  :k_CicliFila1p,
				  :k_CicliFila2p,
				  :kst_tab_pilota_queue.NN ;
	
	//--- popola i campi della dw con i pallet intoccabili
		k_riga_intoccabili = 0
		k_riga_modificabili = 0
		do while kguo_sqlca_db_pilota.sqlcode = 0 
	
			if isnumber(k_CicliFila1) then
				kst_tab_pilota_queue.CicliFila1 = integer(k_CicliFila1)
			else
				kst_tab_pilota_queue.CicliFila1 = 0
			end if
			if isnumber(k_CicliFila1p) then
				kst_tab_pilota_queue.CicliFila1p = integer(k_CicliFila1p)
			else
				kst_tab_pilota_queue.CicliFila1p = 0
			end if
			if isnumber(k_CicliFila2) then
				kst_tab_pilota_queue.CicliFila2 = integer(k_CicliFila2)
			else
				kst_tab_pilota_queue.CicliFila2 = 0
			end if
			if isnumber(k_CicliFila2p) then
				kst_tab_pilota_queue.CicliFila2p = integer(k_CicliFila2p)
			else
				kst_tab_pilota_queue.CicliFila2p = 0
			end if
	
	//--- lettura dati correlati	
				select distinct
						barcode.tipo_cicli
						,meca.num_int
						,meca.clie_2
						,meca.area_mag
						,clienti.rag_soc_10
						,meca.consegna_data
					into
							:kst_tab_sl_pt.tipo_cicli
							,:kst_tab_meca.num_int
							,:kst_tab_meca.clie_2
							,:kst_tab_meca.area_mag
							,:kst_tab_clienti.rag_soc_10
							,:kst_tab_meca.consegna_data
					from 
						  (barcode
							inner join meca on
							 barcode.id_meca = meca.id)
						 inner join clienti on
							 meca.clie_2 = clienti.codice 
					where barcode.barcode = :kst_tab_pilota_queue.barcode 
					using sqlca;
		
		
			if sqlca.sqlcode = 0 then
				if isnull(kst_tab_sl_pt.tipo_cicli) then
					kst_tab_sl_pt.tipo_cicli = " "
				end if
				if isnull(kst_tab_meca.clie_2) then
					kst_tab_meca.clie_2 = 0
				end if
				if isnull(kst_tab_meca.num_int) then
					kst_tab_meca.num_int = 0
				end if
				if isnull(kst_tab_meca.area_mag) then
					kst_tab_meca.area_mag = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_10) then
					kst_tab_clienti.rag_soc_10 = " "
				end if
				if isnull(kst_tab_meca.consegna_data) then
					kst_tab_meca.consegna_data = date(0)
				end if
			else
				kst_tab_sl_pt.tipo_cicli = " "
				kst_tab_meca.clie_2 = 0
				kst_tab_meca.num_int = 0
				kst_tab_meca.area_mag = " "
				kst_tab_clienti.rag_soc_10 = " "
				kst_tab_meca.consegna_data = date(0)
			end if
	
	//--- vedo se devo inserire Intoccabili in fila 1 o 2
			if k_intoccabili_fila1 > 0 and kst_tab_pilota_queue.CicliFila1 > 0 then
				k_intoccabili_fila1 --
				
				k_insert_intoccabili = true
			else
				if k_intoccabili_fila2 > 0 and kst_tab_pilota_queue.CicliFila2 > 0 then
					k_intoccabili_fila2 --
				
					k_insert_intoccabili = true
				else		
					k_insert_intoccabili = false
				end if
			end if
	
	//--- Insert tra gli Intoccabili...
			if k_insert_intoccabili then
				
				k_riga_intoccabili = dw_lista_0.insertrow(0)
		
				dw_lista_0.object.Ordine[k_riga_intoccabili] = kst_tab_pilota_queue.Ordine
				dw_lista_0.object.Barcode[k_riga_intoccabili] = kst_tab_pilota_queue.Barcode
				dw_lista_0.object.Posizione[k_riga_intoccabili] = kst_tab_pilota_queue.Posizione
				dw_lista_0.object.CicliFila1[k_riga_intoccabili] = kst_tab_pilota_queue.CicliFila1
				dw_lista_0.object.CicliFila2[k_riga_intoccabili] = kst_tab_pilota_queue.CicliFila2
				dw_lista_0.object.CicliFila1p[k_riga_intoccabili] = kst_tab_pilota_queue.CicliFila1p
				dw_lista_0.object.CicliFila2p[k_riga_intoccabili] = kst_tab_pilota_queue.CicliFila2p
				dw_lista_0.object.k_clie_2[k_riga_intoccabili] = kst_tab_meca.clie_2
				dw_lista_0.object.k_num_int[k_riga_intoccabili] = kst_tab_meca.num_int
				dw_lista_0.object.k_area_mag[k_riga_intoccabili] = kst_tab_meca.area_mag
				dw_lista_0.object.k_rag_soc_10[k_riga_intoccabili] = kst_tab_clienti.rag_soc_10
				if kst_tab_meca.consegna_data > date(0) then
					dw_lista_0.object.k_consegna_data[k_riga_intoccabili] = string(kst_tab_meca.consegna_data, "dd/mm/yy")
				end if
				dw_lista_0.object.k_in_lavorazione[k_riga_intoccabili] = "0"
	//			dw_lista_0.object.k_tipo_cicli[k_riga_intoccabili] = kst_tab_sl_pt.tipo_cicli
			else
	//--- Insert tra i Modificabili...
	
				k_riga_modificabili = dw_dett_0.insertrow(0)
	
				dw_dett_0.object.Ordine[k_riga_modificabili] = kst_tab_pilota_queue.Ordine
				dw_dett_0.object.Barcode[k_riga_modificabili] = kst_tab_pilota_queue.Barcode
				dw_dett_0.object.Posizione[k_riga_modificabili] = kst_tab_pilota_queue.Posizione
				dw_dett_0.object.CicliFila1[k_riga_modificabili] = kst_tab_pilota_queue.CicliFila1
				dw_dett_0.object.CicliFila2[k_riga_modificabili] = kst_tab_pilota_queue.CicliFila2
				dw_dett_0.object.CicliFila1p[k_riga_modificabili] = kst_tab_pilota_queue.CicliFila1p
				dw_dett_0.object.CicliFila2p[k_riga_modificabili] = kst_tab_pilota_queue.CicliFila2p
				dw_dett_0.object.k_clie_2[k_riga_modificabili] = kst_tab_meca.clie_2
				dw_dett_0.object.k_num_int[k_riga_modificabili] = kst_tab_meca.num_int
				dw_dett_0.object.k_area_mag[k_riga_modificabili] = kst_tab_meca.area_mag
				dw_dett_0.object.k_rag_soc_10[k_riga_modificabili] = kst_tab_clienti.rag_soc_10
				if kst_tab_meca.consegna_data > date(0) then
					dw_dett_0.object.k_consegna_data[k_riga_modificabili] = string(kst_tab_meca.consegna_data, "dd/mm/yy")
				end if
				dw_dett_0.object.k_tipo_cicli[k_riga_modificabili] = kst_tab_sl_pt.tipo_cicli
				
			end if
			
			fetch c_retrieve_dw into
					  :kst_tab_pilota_queue.Ordine ,
					  :kst_tab_pilota_queue.Barcode ,
					  :kst_tab_pilota_queue.Posizione ,
					  :k_CicliFila1,
					  :k_CicliFila2,
					  :k_CicliFila1p,
					  :k_CicliFila2p,
					  :kst_tab_pilota_queue.NN ;
		
			
		loop
	
		if kguo_sqlca_db_pilota.sqlcode < 0 then
			kguo_exception.inizializza()
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_db_ko)
			kguo_exception.setmessage("Errore durante lettura Coda Pilota Intoccabili~n~r"&
						+ "Codice errore: " +  string(kguo_sqlca_db_pilota.sqlcode) + "~n~r" &
						+ trim(kguo_sqlca_db_pilota.sqlerrtext)&
						)
	
			close c_retrieve_dw;
	
			throw kguo_exception
			
		end if
	
		
		close c_retrieve_dw;
		
		dw_dett_0.resetupdate()
	
		
	end if

finally
	kguo_sqlca_db_pilota.db_disconnetti( )
	
end try

return k_riga_modificabili 


end function

private subroutine modifica_giri_ripristina ();//--- Ripristina i giri Modificati sul Barcode
//--
long k_riga
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
	

kuf1_barcode = create kuf_barcode

for k_riga = 1 to dw_dett_0_modificati.rowcount()

//--- piglia i dati per fare il contro-aggiornamento		
	kst_tab_barcode.barcode = trim(dw_dett_0_modificati.object.Barcode[k_riga])
	kst_tab_barcode.tipo_cicli = dw_dett_0_modificati.object.k_tipo_cicli[k_riga] 
	kst_tab_barcode.fila_1 = dw_dett_0_modificati.object.CicliFila1[k_riga]
	kst_tab_barcode.fila_2 = dw_dett_0_modificati.object.CicliFila1[k_riga]
	kst_tab_barcode.fila_1p = dw_dett_0_modificati.object.CicliFila1[k_riga]
	kst_tab_barcode.fila_2p = dw_dett_0_modificati.object.CicliFila1[k_riga]

//--- aggiorno i giri sul barcode			
	kst_tab_barcode.st_tab_g_0.esegui_commit = "S" 
	kst_esito = kuf1_barcode.tb_update_campo( kst_tab_barcode, "barcode_update_giri")

end for	

end subroutine

private subroutine cancella_toglie_barcode_da_pl () throws uo_exception;//
//--- Toglie i Barcode cancellati dal Piano di Lavoro
//---
long k_riga, k_ctr
st_esito kst_esito
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figli
kuf_barcode kuf1_barcode
st_tab_artr kst_tab_artr
kuf_artr kuf1_artr
datastore kds_figli
	

try
	kuf1_barcode = create kuf_barcode
	kuf1_artr = create kuf_artr
	
	for k_riga = 1 to dw_dett_0_deleted.rowcount()
	
	//--- piglia i dati per fare il contro-aggiornamento		
		kst_tab_barcode.barcode = trim(dw_dett_0_deleted.object.Barcode[k_riga])
	
	//--- legge barcode 
		kuf1_barcode.select_barcode(kst_tab_barcode)

	//--- Toglie barcode dal P.L.
		kuf1_barcode.togli_pl_barcode_non_chiuso (kst_tab_barcode)

	//--- cancello groupage dal padre
//--- 25.05.2015		kuf1_barcode.tb_togli_figlio_al_padre (kst_tab_barcode)
			
//--- Aggiornamento tabella ARTR 
		setnull(kst_tab_artr.data_fin) 
		kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
		kst_tab_artr.id_armo = kst_tab_barcode.id_armo
		kst_tab_artr.colli = 1 
		kst_esito = kuf1_artr.togli_colli_in_lavorazione(kst_tab_artr)

//--- Toglie anche eventuali FIGLI dalla Programmazione
		k_ctr = kuf1_barcode.get_conta_figli(kst_tab_barcode)
		if k_ctr > 0 then
			kds_figli = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
			
			for k_ctr = 1 to kds_figli.rowcount()

				kst_tab_barcode_figli.barcode = kds_figli.object.barcode[k_ctr]
				
	//--- cancello barcode	 come Figlio dal Padre e dal P.L.
//--- 25.05.2015				kuf1_barcode.tb_togli_da_groupage(kst_tab_barcode_figli)

	//--- legge barcode 
				kuf1_barcode.select_barcode(kst_tab_barcode_figli)
			
//--- Aggiornamento tabella ARTR 
				setnull(kst_tab_artr.data_fin) 
				kst_tab_artr.pl_barcode = kst_tab_barcode_figli.pl_barcode
				kst_tab_artr.id_armo = kst_tab_barcode_figli.id_armo
				kst_tab_artr.colli = 1 
				kst_tab_artr.colli_groupage = 1 
				kst_esito = kuf1_artr.togli_colli_in_lavorazione(kst_tab_artr)

			end for
			
		end if
	
	end for	

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_artr) then destroy kuf1_artr
	
end try
	
end subroutine

protected function integer ritorna (string k_titolo);//
//--- torna 0=ok uscita, 2=non uscire dal programma
//
int k_return = 0


if not(ki_invio_programma_eseguito) then


	if dw_dett_0.u_dati_modificati() then

		if messagebox ("Richiesta di Uscita ", &
						"Programma non INVIATO al Pilota i!!~n~r" &
						+" ~n~r" &
						+ "Vuoi davvero uscire dalla funzione?" &
						+" ~n~r" &
						 ,question!, YesNo!, 2) = 2 then

			k_return = 2

		end if
	end if

end if


return k_return 


	
end function

private function integer call_window_barcode ();//
//--- Chiama finestra di dettaglio
//
integer k_return = 0
long k_riga=0
st_tab_barcode kst_tab_barcode
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



	if dw_dett_0.getrow() > 0 then		
		k_riga = dw_dett_0.getrow() 
	else
		if dw_dett_0.rowcount() = 1 then
			k_riga = 1
		else
			k_riga = 0
		end if
	end if
	if k_riga > 0 then		
		kst_tab_barcode.barcode = dw_dett_0.getitemstring(k_riga, "barcode")
	end if


	if k_riga > 0 then		
	

		if LenA(trim(kst_tab_barcode.barcode)) > 0 &
			and not isnull(kst_tab_barcode.barcode) then

			
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento &
				or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				kst_open_w.flag_modalita= kkg_flag_modalita.modifica
			else
				kst_open_w.flag_modalita= kkg_flag_modalita.visualizzazione
			end if
				
			kst_open_w.id_programma = kkg_id_programma_barcode
			kst_open_w.id_programma_chiamante = ki_st_open_w.id_programma
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = trim(kst_tab_barcode.barcode)
			kst_open_w.key2 = " "
			kst_open_w.flag_where = " " 
			
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		
		else   
			
			messagebox("Dettaglio Codice a Barre", &
						"Codice a barre selezionato non valido")
			
		end if
			
	else
			
		messagebox("Dettaglio Codice a Barre", &
						"Selezionare un codice a barre in elenco")

	
	end if
 
 
return k_return

end function

private subroutine sposta_barcode (long k_riga_dest) throws uo_exception;//---
//--- Inserisce un barcode nella lista al termine del DRAGDROP
//---
long k_riga_ini, k_riga_fin, k_riga, k_riga_mod, k_num_selezionati, k_ctr
boolean k_elabora=true
string k_barcode, k_barcode_primo
uo_exception kuo_exception
//datastore kds_1


dw_dett_0.ki_attiva_standard_select_row = false

if k_riga_dest > 0 then

	k_num_selezionati=0
//--- controlla prima che: lo spostamento non deve avvenire su una riga in selezione ovvero da spostare
	k_riga = dw_dett_0.getselectedrow(0)
	if k_riga > 0 then
		k_barcode_primo = dw_dett_0.object.barcode[k_riga]  // salvo il primo barcode x il riposizionamento alla fine
	
		do while k_riga > 0 and k_elabora
			if k_riga = k_riga_dest then k_elabora = false		
			k_num_selezionati ++
			k_riga = dw_dett_0.getselectedrow(k_riga)
		loop
	end if
end if

//--- se KO...
if k_num_selezionati = 0 then
	kuo_exception = create uo_exception
	kuo_exception.set_nome_oggetto(this.classname())
	kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_generico )
	kuo_exception.setmessage( "Errore durante selezione dei Barcode da Spostare" )
	throw kuo_exception
end if

//--- se tutto ok... ---------------------------------------------

//	kds_1 = create datastore
//	kds_1.dataobject = dw_dett_0.dataobject
	dw_dett_0_appo.reset()

	if k_riga_dest > dw_dett_0.rowcount() then
		k_barcode = "dietro_ultimo"
	else
		k_barcode = dw_dett_0.object.barcode[k_riga_dest]
	end if

//--- sposto le righe selezionte dal dw di lavoro  nel datastore di appo
	k_riga = dw_dett_0.getselectedrow(0)
	
	k_riga_mod = 0
	do while k_riga > 0 and k_num_selezionati > k_riga_mod
		
		k_riga_mod ++
		k_ctr = dw_dett_0.RowsCopy(k_riga, k_riga, primary!, dw_dett_0_appo, k_riga_mod, Primary!)	
		
		if k_ctr = -1 then
			kuo_exception = create uo_exception
			kuo_exception.set_nome_oggetto(this.classname())
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_generico )
			kuo_exception.setmessage( "Errore durante copia delle righe per Spostamento Barcode" )
			throw kuo_exception
		end if
			
		dw_dett_0.setitem(k_riga, "k_da_cancellare", "1")
		
		k_riga = dw_dett_0.getselectedrow(k_riga)
	loop

//--- porto le righe dal dw di appoggio nel datawindow di lavoro
	if k_barcode = "dietro_ultimo" then
		k_riga = dw_dett_0.rowcount() + 1
	else
		k_riga = dw_dett_0.find("barcode = '"+trim(k_barcode)+"' ", 1, dw_dett_0.rowcount())
	end if
	if k_riga > 0 then
		k_riga_fin = dw_dett_0_appo.rowcount()
		k_ctr = dw_dett_0_appo.RowsCopy(1, k_riga_fin, primary!, dw_dett_0, k_riga, Primary!)	
		
		if k_ctr = -1 then
			kuo_exception = create uo_exception
			kuo_exception.set_nome_oggetto(this.classname())
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_generico )
			kuo_exception.setmessage( "Errore durante copia finale delle righe per Spostamento Barcode" )
			throw kuo_exception
		end if
	end if
	
//	destroy kds_1

//--- riposizionamento sul primo barcode spostato
	k_riga = dw_dett_0.find("barcode = '"+trim(k_barcode_primo)+"' ", 1, dw_dett_0.rowcount())
	dw_dett_0.selectrow( 0, false )
	if k_riga > 0 then
		dw_dett_0.setrow( k_riga )
		dw_dett_0.scrolltorow( k_riga )
		dw_dett_0.selectrow( k_riga, True )
	else
			
		if k_ctr = -1 then
			kuo_exception = create uo_exception
			kuo_exception.set_nome_oggetto(this.classname())
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_generico )
			kuo_exception.setmessage( "Errore durante selezione sul primo Barcode spostato" )
			throw kuo_exception
		end if
		
	end if

//--- Cancella le righe copiate nel datastore
	for k_riga = dw_dett_0.rowcount()  to 1 step -1
		if dw_dett_0.getitemstring( k_riga, "k_da_cancellare") = "1" then
			k_ctr = dw_dett_0.deleterow(k_riga)
			
			if k_ctr = -1 then
				kuo_exception = create uo_exception
				kuo_exception.set_nome_oggetto(this.classname())
				kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_generico )
				kuo_exception.setmessage( "Errore durante cancellazione righe vecchie dopo Spostamento Barcode" )
				throw kuo_exception
			end if
			
		end if
	end for

dw_dett_0.ki_attiva_standard_select_row = true
	
	
end subroutine

private function st_esito controllo_allineamento_pilota () throws uo_exception;//---
//---
//--- Controllo che il Pilota non sia stato aggiornato con nuovi Pallet, se fosse cosi' tutte le operazioni
//--- fatte sono annullate poiche' non sara' possibile inviare la programmazione al pilota
//---
//--- Outout: st_esito esito not OK = pilota disallineato; ok=tutto OK
//---
//--- lancio EXCEPTION se errore grave
//---
long k_riga, k_rowcount=0
st_tab_barcode kst_tab_barcode
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
//--- Aggiorna lettura coda Pilota
	leggi_pilota()

//--- controlla che tutti i barcode sul PILOTA siano PRESENTI anche nelle DW di SPOSTAMENTO+INTOCCABILI+CANCELLATI
	k_rowcount = dw_pilota.rowcount()
	for k_riga = 1 to k_rowcount
	
		kst_tab_barcode.barcode = dw_pilota.object.barcode[k_riga]

		if dw_dett_0.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_dett_0.RowCount()) < 1 then
			
			if dw_lista_0.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_lista_0.RowCount()) < 1 then

				if dw_dett_0_deleted.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_dett_0_deleted.RowCount()) < 1 then

					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Sul PILOTA e' stato trovato il Barcode: " + trim(kst_tab_barcode.barcode) +" in piu'  ~n~rrispetto alla nuova programmazione da inviare!! " 
					kst_esito.esito = kkg_esito.err_logico

					exit   //forza uscita ciclo
					
				end if
			end if
			
		end if
		
	end for

	if kst_esito.esito = kkg_esito.ok then
	
//--- controlla che tutti i barcode su dw di SPOSTAMENTO siano PRESENTI anche nel  dw del PILOTA (07-03-2007)
		k_rowcount = dw_dett_0.rowcount()
		for k_riga = 1 to k_rowcount
		
			kst_tab_barcode.barcode = dw_dett_0.object.barcode[k_riga]
	
			if dw_pilota.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", 1, dw_pilota.RowCount()) < 1 then
				
	
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Sul PILOTA manca il Barcode: " + trim(kst_tab_barcode.barcode) +",  ~n~rprobabilmente e' gia' stato caricato in impianto!! " 
				kst_esito.esito = kkg_esito.err_logico
	
				exit   //forza uscita ciclo
						
			end if
			
		end for
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
end try

return kst_esito

end function

protected subroutine open_start_window ();//
//--- dw per lo spostamento dei barcode
dw_sposta.visible = false
dw_sposta.insertrow( 0)
dw_sposta.width = 1632
dw_sposta.height = 776
dw_sposta.x = this.width  / 2
dw_sposta.y = this.height * 0.15

end subroutine

private subroutine check_file_command ();//---
//--- Controllo se e' stato inviato un Piano di Lavorazione e il Pilota non se lo è ancora pippato!
//---
long k_ctr, k_ctr1=0
st_esito kst_esito
uo_exception kuo_exception
kuf_pilota_cmd kuf1_pilota_cmd 


try 
	kuf1_pilota_cmd = create kuf_pilota_cmd
	
//--- Se file COMMAND ancora presente in cartella di scambio allora niente Modifiche
	if kuf1_pilota_cmd.check_presenza_file_richieste( ) then
	
//--- Uscita!
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_allerta)
		kuo_exception.setmessage("Piano di Lavorazione ancora in Attesa~n~r" &
									 + "Un Piano e' stato inviato al Pilota ma questo non lo ha ancora esaminato.~n~r" &
									 + "Non e' possibile continuare, questa funzione sara' terminata in automatico.~n~r" &
							+" ")
		kuo_exception.messaggio_utente()

		cb_ritorna.postevent(clicked!)
		
	end if

catch (uo_exception kuo1_exception)
		kst_esito = kuo1_exception.get_st_esito()
		kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_allerta)
		kuo1_exception.setmessage("Operazione in errore~n~r" &
									 + "Si e' verificato un errore durante il controllo esistenza Piano.~n~r" &
									 + trim(kst_esito.sqlerrtext) +" "&
									 + "Non e' possibile continuare, questa funzione sara' terminata in automatico.~n~r" )
		kuo1_exception.messaggio_utente()

		cb_ritorna.postevent(clicked!)
		

finally 
	
	destroy kuf1_pilota_cmd
	
end try

end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	cb_aggiorna.enabled = false
	cb_inserisci.enabled = false
	cb_modifica.enabled = false
	

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

		cb_cancella.enabled = true

	else
		cb_cancella.enabled = false
	end if
	


end subroutine

public subroutine u_obj_visible_0 ();//
	dw_dett_0.visible = true
	dw_lista_0.visible = true
	dw_pilota.visible = true

end subroutine

public subroutine u_resize ();//
if k_risize then
	k_risize = false

	super::u_resize()

end if

end subroutine

public function boolean u_resize_predefinita ();//---
int k_sep_y, k_spess_titolo, k_sep_x

	
//	if ki_st_open_w.flag_adatta_win = KKG.ADATTA_WIN &
//		and not (ki_personalizza_pos_controlli) then
 
		this.setredraw(false)

		k_sep_y = 10
		k_sep_x = 10 //80
		k_spess_titolo = 10 //150
		dw_dett_0.height = this.height * 2 / 3
		dw_lista_0.height = this.height - dw_dett_0.height -  k_spess_titolo - k_sep_y
		dw_lista_0.width = this.width / 2 - k_sep_x
		dw_dett_0.width = dw_lista_0.width

		dw_pilota.height = this.height - k_spess_titolo 
		dw_pilota.width = dw_lista_0.width

		
//=== Posiziona dw nella window 
		dw_lista_0.x = 5
		dw_lista_0.y = 5

		dw_dett_0.x = 5
		dw_dett_0.y = dw_lista_0.height + k_sep_y

		dw_pilota.x = dw_lista_0.width + k_sep_x
		dw_pilota.y = 5
	
//--- ridimensione dei controlli nascosti
		dw_dett_0_deleted.height = this.height / 4 
		dw_dett_0_deleted.width = this.width / 2
		dw_dett_0_deleted.x = (this.width - dw_dett_0_deleted.width) / 2
		dw_dett_0_deleted.y = (this.height - dw_dett_0_deleted.height) / 2
		
		dw_dett_0_modificati.height = this.height / 4 
		dw_dett_0_modificati.width = this.width / 2
		dw_dett_0_modificati.x = (this.width - dw_dett_0_deleted.width) / 3
		dw_dett_0_modificati.y = (this.height - dw_dett_0_deleted.height) / 3

	
		this.setredraw(true)
		
//	end if


return TRUE


end function

on w_pl_barcode_coda_pilota.create
int iCurrent
call super::create
this.st_barcode=create st_barcode
this.dw_pilota=create dw_pilota
this.dw_dett_0_deleted=create dw_dett_0_deleted
this.dw_modifica=create dw_modifica
this.dw_modifica_giri_scambio=create dw_modifica_giri_scambio
this.dw_dett_0_modificati=create dw_dett_0_modificati
this.dw_dett_0_appo=create dw_dett_0_appo
this.dw_sposta=create dw_sposta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_barcode
this.Control[iCurrent+2]=this.dw_pilota
this.Control[iCurrent+3]=this.dw_dett_0_deleted
this.Control[iCurrent+4]=this.dw_modifica
this.Control[iCurrent+5]=this.dw_modifica_giri_scambio
this.Control[iCurrent+6]=this.dw_dett_0_modificati
this.Control[iCurrent+7]=this.dw_dett_0_appo
this.Control[iCurrent+8]=this.dw_sposta
end on

on w_pl_barcode_coda_pilota.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_barcode)
destroy(this.dw_pilota)
destroy(this.dw_dett_0_deleted)
destroy(this.dw_modifica)
destroy(this.dw_modifica_giri_scambio)
destroy(this.dw_dett_0_modificati)
destroy(this.dw_dett_0_appo)
destroy(this.dw_sposta)
end on

event timer;call super::timer;//
leggi_pilota()
screma_intoccabili()
if NOT ki_invio_programma_eseguito then
	allerta_chiudi()
end if

//--- ogni 2 minuti controlla se pilota allineato con quello che sto facendo
if minute(time(now())) <> ki_minuto_timer then
	if mod(ki_minuto_timer,2) > 0 then
		try
			controllo_allineamento_pilota()
		catch (uo_exception kuo_exception)
		end try
	end if
	ki_minuto_timer = minute(time(now()))
end if
end event

event close;call super::close;//
st_tab_pilota_cfg kst_tab_pilota_cfg
kuf_pilota_cmd kuf1_pilota_cmd

try
	
//---- Se non inviato Ripristina i giri modificati
	if not(ki_invio_programma_eseguito) then
		modifica_giri_ripristina()
	end if

//--- Sblocca la produzione delle richieste al Pilota 	
	kuf1_pilota_cmd = create kuf_pilota_cmd
	kst_tab_pilota_cfg.blocca_richieste = kuf1_pilota_cmd.ki_blocca_richieste_no
	kuf1_pilota_cmd.set_blocca_richieste(kst_tab_pilota_cfg)
	destroy kuf1_pilota_cmd
	
catch (uo_exception kuo_exception)
	kuo_exception.setmessage("Procedere manualmente con lo SBLOCCO delle Richieste in Archivi->Pilota"&
	                                        + kuo_exception.getmessage())
finally
	destroy kids_pl_barcode
	
end try
end event

event activate;call super::activate;//--- attivo il timer ogni tot secondi	
//timer( 15 )  // NON FUNZIONA CON LA MODALITA DOCK

leggi_pilota()
//dw_pilota.visible = true
screma_intoccabili()



end event

event deactivate;call super::deactivate;//--- attivo il timer ogni tot secondi	
timer( 0 )
//

end event

event u_open;call super::u_open;
kids_pl_barcode = create ds_pl_barcode

//--- path per reperire le ico del drag e drop
ki_path_risorse = kguo_path.get_risorse( ) //trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))


end event

event resize;call super::resize;//--- non fare evento padre
//
end event

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_coda_pilota
integer x = 2985
integer y = 2148
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_coda_pilota
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_coda_pilota
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_coda_pilota
integer x = 2994
integer y = 2044
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_coda_pilota
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_coda_pilota
integer x = 2592
integer y = 2080
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_coda_pilota
integer x = 2999
integer y = 1868
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_coda_pilota
integer x = 2999
integer y = 1964
end type

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_coda_pilota
integer x = 2999
integer y = 1776
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_coda_pilota
integer x = 2629
integer y = 1928
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_coda_pilota
integer x = 0
integer y = 476
integer width = 1993
integer height = 1372
boolean enabled = true
boolean titlebar = true
string title = "Elenco Bancali Nuova Programmazione"
string dataobject = "d_pilota_queue_table_mod"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean livescroll = false
boolean ki_in_drag = true
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::dragdrop;//


		st_barcode.visible = false

		if not this.IsSelected( row ) then 
			try
				sposta_barcode(row)
				
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente( )
					
				finally
					ordine_rinumerazione()
			end try
			
		end if


end event

event dw_dett_0::dragwithin;//
boolean k_piu_righe = false
string k_alla_riga = ""
long k_last_row = 0, k_first_row=0


if row = 0 then

	st_barcode.visible = false
	this.drag(cancel!)

else
	ki_riga_selected = this.getselectedrow(0)
	if ki_riga_selected <= 0 then
		this.selectrow(row, true)	
		ki_riga_selected = row
		ki_dragdrop_display = string(this.getitemnumber(ki_riga_selected, "ordine")) +"-"+ trim(this.getitemstring(ki_riga_selected, "barcode")) 
	else
		if this.getselectedrow(ki_riga_selected) > 0 then
			 k_piu_righe = true
		end if
	end if
	
	k_last_row = this.getitemnumber(0,"k_pag_utima_riga") - 2
	if row > k_last_row  then
		this.scrolltorow(k_last_row + 3) 
	else
		k_first_row = this.getitemnumber(0,"k_pag_prima_riga") + 2
		if row < k_first_row  and row > 2 then
			this.scrolltorow(k_first_row - 3) 
		end if
	end if

	//---- se sono piu' di 1 riga da drag allora multi-drag	
	if k_piu_righe  then
		//this.dragicon = ki_path_risorse + "\drag2.ico" 
		this.dragicon = "drag2.ico" 
	else		
		this.dragicon = "drag1.ico"
	end if
	
	if row > 0 and ki_riga_selected <> row then
	
		if ki_riga_dragwithin > 0 then
			this.setitem(ki_riga_dragwithin, "k_su_drop", "0")
		end if
		ki_riga_dragwithin = row
		if this.IsSelected( row ) then
			k_alla_riga = " ??? "
		else
			k_alla_riga =   "   > "+ string(this.getitemnumber(row, "ordine"))
			this.setitem(row, "k_su_drop", "1")
		end if
	
		st_barcode.x = parent.pointerx() +50
		st_barcode.y = parent.pointery() + 50
		if k_piu_righe then
			st_barcode.text = " " + ki_dragdrop_display + "....." + k_alla_riga
		else
			st_barcode.text = " " +  ki_dragdrop_display + k_alla_riga  
		end if
		st_barcode.visible = true
	
	end if
end if


end event

event dw_dett_0::losefocus;//
	st_barcode.visible = false
	ki_dragdrop = false
	this.drag(cancel!)
//	ki_riga_inizio_dragdrop = 0
	ki_riga_selected = 0	

end event

event dw_dett_0::clicked;//
long i=0

if row > 0 then
	
	if ki_clicked_row > 0 then
		
		if keydown(keyshift!) then
			if ki_clicked_row > row then
				for i = row to ki_clicked_row
					this.selectrow( i, True )
				end for			
			else
				for i = ki_clicked_row to row  
					this.selectrow( i, True )
				end for			
			end if
		else
			if not keydown(KeyControl!) then
				this.selectrow( 0, false )
				this.selectrow( row, True )
			else
				if this.isselected( row ) then
					this.selectrow( row, false )
				else
					this.selectrow( row, true )
				end if
			end if
		end if
	else
		this.selectrow( row, true )
	end if
	
	ki_clicked_row = row
	
	this.setrow( row )
end if

end event

event dw_dett_0::doubleclicked;//
// sopprimo lo standard
end event

event dw_dett_0::rowfocuschanging;//
//
if (keydown(KeyDownArrow!) or keydown(KeyUpArrow!)) then
	if  keydown(keyshift!) then 
		if this.IsSelected( newrow ) then
			if currentrow <> ki_clicked_row then
				if currentrow <> newrow then
					this.selectrow( currentrow, false )
				end if
			end if
		else
			this.selectrow( newrow, True )
		end if
	else
		this.selectrow( 0, false )
		this.selectrow( newrow, True )
		ki_clicked_row = newrow
	end if
end if


end event

event dw_dett_0::rowfocuschanged;//
//--- x non fare evento padre!
end event

event dw_dett_0::ue_dwnkey;//
//--- x non fare evento padre!

end event

event dw_dett_0::ue_dragleave_post;call super::ue_dragleave_post;
ki_riga_selected= 0
this.selectrow( 0, false )
ki_dragdrop = false
THIS.Drag(cancel!)
st_barcode.visible = false

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_coda_pilota
integer x = 0
integer y = 380
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_coda_pilota
integer width = 3287
integer height = 464
boolean titlebar = true
string title = "Elenco ~'Intoccabili~'"
string dataobject = "d_pilota_queue_table_intoccabili"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_db_conn_standard = false
end type

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_coda_pilota
end type

type st_barcode from statictext within w_pl_barcode_coda_pilota
boolean visible = false
integer x = 658
integer y = 848
integer width = 507
integer height = 64
boolean dragauto = true
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
string text = "barcode"
boolean border = true
long bordercolor = 255
boolean focusrectangle = false
end type

type dw_pilota from uo_d_std_1 within w_pl_barcode_coda_pilota
integer x = 2011
integer y = 20
integer width = 1673
integer height = 1324
integer taborder = 90
boolean bringtotop = true
integer transparency = 100
boolean enabled = true
boolean titlebar = true
string title = "Coda Programmazione Impianto aggiornata alle"
string dataobject = "d_pilota_queue_table"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean ki_db_conn_standard = false
end type

type dw_dett_0_deleted from datawindow within w_pl_barcode_coda_pilota
boolean visible = false
integer x = 69
integer y = 1892
integer width = 1499
integer height = 872
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "Elenco Bancali Rimossi"
string dataobject = "d_pilota_queue_table_mod"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "Error!"
boolean hsplitscroll = true
boolean livescroll = true
end type

type dw_modifica from uo_dw_modifica_giri_barcode within w_pl_barcode_coda_pilota
integer x = 2336
integer y = 1164
integer width = 2688
integer height = 672
integer taborder = 90
boolean bringtotop = true
boolean enabled = true
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event ue_mostra_aggiornamenti_dw;call super::ue_mostra_aggiornamenti_dw;//
long k_riga=0, k_riga_find=0


	for k_riga = 1 to dw_modifica_giri_scambio.rowcount()
		k_riga_find = dw_dett_0.find ("barcode = '" + trim(dw_modifica_giri_scambio.object.barcode_barcode[k_riga])+"'",0,dw_dett_0.rowcount())
		if k_riga_find > 0 then
			dw_dett_0.object.ciclifila1[k_riga_find]	= dw_modifica_giri_scambio.object.barcode_fila_1[k_riga]
			dw_dett_0.object.ciclifila1p[k_riga_find]  = dw_modifica_giri_scambio.object.barcode_fila_1p[k_riga] 
			dw_dett_0.object.ciclifila2[k_riga_find]	= dw_modifica_giri_scambio.object.barcode_fila_2[k_riga] 
			dw_dett_0.object.ciclifila2p[k_riga_find] = dw_modifica_giri_scambio.object.barcode_fila_2p[k_riga] 
			dw_dett_0.object.barcode[k_riga_find] = dw_modifica_giri_scambio.object.barcode_barcode[k_riga] 
		end if
	end for

	destroy kidw_dett_0_da_non_modificare
	
end event

type dw_modifica_giri_scambio from uo_dw_modifica_giri_barcode_scambio within w_pl_barcode_coda_pilota
integer x = 2025
integer y = 1208
integer width = 1015
integer height = 440
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

type dw_dett_0_modificati from datawindow within w_pl_barcode_coda_pilota
boolean visible = false
integer x = 1326
integer y = 2032
integer width = 1655
integer height = 744
integer taborder = 120
boolean bringtotop = true
boolean titlebar = true
string title = "Elenco Bancali Modificati dati di origine"
string dataobject = "d_pilota_queue_table_mod"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "Form!"
boolean hsplitscroll = true
boolean livescroll = true
end type

type dw_dett_0_appo from uo_d_std_1 within w_pl_barcode_coda_pilota
integer x = 2030
integer y = 1756
integer height = 352
integer taborder = 90
boolean bringtotop = true
boolean enabled = true
string dataobject = "d_pilota_queue_table_mod"
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

type dw_sposta from datawindow within w_pl_barcode_coda_pilota
event u_attiva ( )
boolean visible = false
integer x = 805
integer y = 316
integer width = 1623
integer height = 788
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "Sposta Barcode"
string dataobject = "d_pl_barcode_coda_pilota_sposta"
boolean controlmenu = true
boolean minbox = true
boolean border = false
string icon = "Exclamation!"
borderstyle borderstyle = stylelowered!
end type

event u_attiva();//
	if this.visible then
		this.visible = false
		dw_dett_0.setfocus()
	else
		if this.height > 0 and this.width > 0 and this.x > 0 and this.y > 0 then
		else
			this.height = 788
			this.width = 1623
			if (parent.width / 2) > this.width then
				this.x = parent.width / 2 - this.width
			end if
			if (parent.height / 4) > this.height then
				this.y = parent.height / 6
			end if
		end if
		this.visible = true
		this.bringtotop=true
		this.setfocus( )
	end if

end event

event buttonclicked;
//
long k_riga, k_riga1
string k_msg

this.enabled = false

if dwo.name = "cb_prima_del_barcode" then

	this.accepttext( )
	
	if this.rowcount( ) > 0 then 
		if this.object.posizione_tipo[1] = 1 then
			k_riga = 1
			k_msg = " OK!  Barcode spostato all'inizio. ~n~r Operazione conclusa correttamente. " 
		else
			if this.object.posizione_tipo[1] = 3 then
				k_riga = dw_dett_0.rowcount() + 1
				k_msg = " OK!  Barcode spostato alla Fine. ~n~r Operazione conclusa correttamente. " 
				
			else
				
//				k_riga1 = this.object.posizione_numero[1] 
				if this.object.posizione_numero[1] > 1 then

					k_riga = dw_dett_0.find("ordine = "+string(this.object.posizione_numero[1] )+" ", 1, dw_dett_0.rowcount())
		//--- se non trova l'ordine allora cerca il piu' vicino salendo		
					if k_riga <= 0 then
//						k_riga = dw_dett_0.find("ordine >= "+string(this.object.posizione_numero[1] )+" ", 1, dw_dett_0.rowcount())
//		//--- se ancora non trova l'ordine allora mi posiziono sull'ultimo + 1
//		
//						if k_riga <= 0 then
							k_riga = 0
							k_msg = " ERRORE:  Numero " + string (this.object.posizione_numero[1] ) + " non Trovato! ~n~r Prego, riprovare. " 
//						else
//							k_msg = " OK!  Barcode mossi al numero: " + string (k_riga) + " (diverso da quello indicato). ~n~r Operazione conclusa correttamente. " 
//						end if
					else
						k_msg = " OK!  Barcode mossi al numero Indicato, riga nr.: " +string (this.object.posizione_numero[1] )+ ". ~n~r Operazione conclusa correttamente. " 
					end if
				
				else
					k_riga = 1
					k_msg = " OK!  Barcode spostato all'inizio (meglio selezionare la prima scelta) . ~n~r Operazione conclusa correttamente. " 
				end if
			end if
			
		end if
	end if

//--- effettua lo spostamento			
	if k_riga > 0  then
	
		try
			sposta_barcode(k_riga)
			
			catch (uo_exception kuo_exception)
				k_msg = kuo_exception.getmessage()
				
			finally
				ordine_rinumerazione()

				leggi_pilota()
				dw_pilota.visible = true
				screma_intoccabili()
				
		end try
		
	end if

	if len(trim(this.object.msg[1])) > 0 then
		this.object.msg[1] = k_msg +  "  ~n~r  ~n~r" +  this.object.msg[1]
	else
		this.object.msg[1] = k_msg 
	end if

end if

this.enabled = true



end event

event editchanged;//
if dwo.name = "posizione_numero" then
	
	this.object.posizione_tipo[1] = 2
	
end if

end event

