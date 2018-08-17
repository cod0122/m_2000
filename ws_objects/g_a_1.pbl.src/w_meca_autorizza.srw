$PBExportHeader$w_meca_autorizza.srw
forward
global type w_meca_autorizza from w_g_tab0
end type
end forward

global type w_meca_autorizza from w_g_tab0
boolean ki_reset_dopo_save_ok = false
boolean ki_consenti_modifica = false
boolean ki_consenti_inserisci = false
end type
global w_meca_autorizza w_meca_autorizza

type variables
//
	kuf_armo kiuf_armo
	kuf_meca_qtna kiuf_meca_qtna
	kuf_meca_fconv kiuf_meca_fconv
	kuf_meca_dosim kiuf_meca_dosim

//	private datastore kdsi_elenco 
	private boolean ki_consenti_forza_stampa_attestato=true
	private boolean ki_consenti_aut_stampa_attestato_farma=true
	private boolean ki_consenti_aut_stampa_attestato_aliment=true
	private boolean ki_consenti_sblocco_rif_incompleto=true
	private boolean ki_consenti_apri_chiudi_quarantena = false
	private boolean ki_consenti_forza_convalida = false
	
	private boolean ki_aggiorna_forza_stampa_attestato=false
	private boolean ki_aggiorna_aut_stampa_attestato_farma=false
	private boolean ki_aggiorna_aut_stampa_attestato_aliment=false
	private boolean ki_aggiorna_forza_convalida=false

	private st_tab_meca kist_tab_meca_orig
	
	private boolean ki_quarantena_aperta = false
	private boolean ki_quarantena_giaaperta = false

	private string ki_flag_modalita_originale=""
end variables

forward prototypes
protected subroutine open_start_window ()
private subroutine autorizza_stampa_attestato_aliment ()
private subroutine autorizza_stampa_attestato_farma ()
private subroutine forza_stampa_attestato ()
protected function string inizializza () throws uo_exception
private subroutine sblocca_meca_non_conforme ()
protected function string aggiorna ()
public subroutine if_quarantena ()
public subroutine u_call_quarantena_note ()
public subroutine u_quarantena_apri ()
public subroutine u_quarantena_chiudi ()
private subroutine autorizza_funzioni_1 ()
private subroutine autorizza_funzioni ()
private subroutine call_memo ()
protected function integer modifica ()
protected function integer visualizza ()
public function boolean u_lancia_funzione_imvc (st_open_w kst_open_w_arg)
protected function string check_dati ()
private subroutine forza_convalida ()
protected subroutine attiva_menu ()
end prototypes

protected subroutine open_start_window ();//--- oggetto visibile in tutta la window
	kiuf_armo = create kuf_armo
	kiuf_meca_qtna = create kuf_meca_qtna
	kiuf_meca_fconv = create kuf_meca_fconv
	kiuf_meca_dosim = create kuf_meca_dosim

	ki_flag_modalita_originale = ki_st_open_w.flag_modalita

end subroutine

private subroutine autorizza_stampa_attestato_aliment ();//
st_tab_meca kst_tab_meca

	dw_dett_0.object.b_meca_cert_aliment_st_ok.enabled = false
	
	kst_tab_meca.cert_farma_st_ok = dw_dett_0.object.meca_cert_aliment_st_ok[1]
	if kst_tab_meca.cert_farma_st_ok = "1" then
		dw_dett_0.object.meca_cert_aliment_st_ok[1] = "0"
	else
		dw_dett_0.object.meca_cert_aliment_st_ok[1] = "1"
	end if

	ki_aggiorna_aut_stampa_attestato_aliment = true

	cb_aggiorna.triggerevent(clicked!)
	

	inizializza_lista()

	ki_aggiorna_aut_stampa_attestato_aliment = false

	dw_dett_0.object.b_meca_cert_aliment_st_ok.enabled = true

end subroutine

private subroutine autorizza_stampa_attestato_farma ();//
st_tab_meca kst_tab_meca


	dw_dett_0.object.b_meca_cert_farma_st_ok.enabled = false

	kst_tab_meca.cert_farma_st_ok = dw_dett_0.object.meca_cert_farma_st_ok[1]
	if kst_tab_meca.cert_farma_st_ok = "1" then
		dw_dett_0.object.meca_cert_farma_st_ok[1] = "0"
	else
		dw_dett_0.object.meca_cert_farma_st_ok[1] = "1"
	end if

	ki_aggiorna_aut_stampa_attestato_farma = true

	cb_aggiorna.triggerevent(clicked!)
	
	try
		inizializza_lista()
	catch (uo_exception kuo_exception)
	end try

	ki_aggiorna_aut_stampa_attestato_farma = false

	dw_dett_0.object.b_meca_cert_farma_st_ok.enabled = true

end subroutine

private subroutine forza_stampa_attestato ();//
st_tab_meca kst_tab_meca

						   
	dw_dett_0.object.b_meca_cert_forza_stampa.enabled = false

	kst_tab_meca.cert_forza_stampa = dw_dett_0.object.meca_cert_forza_stampa[1]
	if kst_tab_meca.cert_forza_stampa = "1" then
		dw_dett_0.object.meca_cert_forza_stampa[1] = "0"
	else
		dw_dett_0.object.meca_cert_forza_stampa[1] = "1"
	end if

	ki_aggiorna_forza_stampa_attestato = true

	cb_aggiorna.triggerevent(clicked!)
	try
		inizializza_lista()
	catch (uo_exception kuo_exception)
	end try

	ki_aggiorna_forza_stampa_attestato = false

	dw_dett_0.object.b_meca_cert_forza_stampa.enabled = true

end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string  k_key
int k_errore = 0, k_forzato
int k_err_ins, k_rc
pointer kpointer_orig
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
kuf_utility kuf1_utility



kpointer_orig = setpointer(hourglass!)

//if dw_dett_0.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)  // numero certificato

	if len(k_key) = 0 or not isnumber(k_key) then
		
		dw_dett_0.setfocus()

	else

		kst_tab_meca.id = long(k_key)
		k_rc = dw_dett_0.retrieve(kst_tab_meca.id) 
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Attenzione si e' verificato un errore interno al programma~n~r" + &
					"(Riferimento cercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				dw_dett_0.reset()
				attiva_tasti()

				if k_scelta <> kkg_flag_modalita.inserimento then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Riferimento non in Archivio~n~r" + &
						"(Numero cercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					dw_dett_0.setfocus()
				end if
				
			case is > 0		
				
				dw_dett_0.setrow(1)
				dw_dett_0.setfocus()
//				dw_dett_0.setcolumn("meca_cert_forza_stampa")

//--- salva campi come in origine
				kist_tab_meca_orig.num_int = dw_dett_0.object.num_int[1]
				kist_tab_meca_orig.data_int = dw_dett_0.object.meca_data_int[1]
				kist_tab_meca_orig.id = dw_dett_0.object.id_meca[1]

				k_forzato = dw_dett_0.getitemnumber(1, "kflg_fconv")
				if k_forzato = 1 then
					dw_dett_0.object.b_convalida.text = "Romuovi Forzatura Convalida"
				else
					dw_dett_0.object.b_convalida.text = "Forza Convalida Dosimetrica"
				end if

		end choose

	end if

//else
	attiva_tasti()
//end if


//--- abilito funzioni sul dw
if k_errore = 0 then

	
	if trim(dw_dett_0.getitemstring(dw_dett_0.getrow( ) , "meca_aperto")) = "N" then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	else
		ki_st_open_w.flag_modalita = ki_flag_modalita_originale
	end if
	
//-- abilita le funzioni onsentite x questa window 
	autorizza_funzioni( )

//--- controlla se lotto è già in quarantena
	if_quarantena()


	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility
	
end if



return "0"


end function

private subroutine sblocca_meca_non_conforme ();//
int k_ok=0
st_tab_meca kst_tab_meca


	try
		dw_dett_0.object.b_meca_stato.enabled = false
		
		kst_tab_meca.id = dw_dett_0.object.id_meca[1]


//--- Modifica 
		k_ok = messagebox("Operazione di: "+trim(dw_dett_0.object.b_meca_stato.text), "Cambia lo Stato del Riferimento?", &
							question!, yesno!, 2) 
		if k_ok = 1 then
//--- aggiorna lo stato del Riferimento
			kiuf_armo.meca_non_conforme_blocca_sblocca(kst_tab_meca)
			inizializza_lista()
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		dw_dett_0.object.b_meca_stato.enabled = true
		
	end try




end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
string k_return="0 ", k_errore="0 ", k_errore1="0 "
int k_operazione=0
int k_forzato
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_meca_dosim kst_tab_meca_dosim


	try 
		SetPointer(kkg.pointer_attesa)

		kst_tab_meca.id = dw_dett_0.object.id_meca[1]

		if dw_dett_0.getnextmodified(0, primary!) > 0 OR &
			dw_dett_0.getnextmodified(0, delete!) > 0 & 
			then
			if ki_aggiorna_forza_stampa_attestato then
				ki_aggiorna_forza_stampa_attestato = false
				kst_tab_meca.cert_forza_stampa = dw_dett_0.object.meca_cert_forza_stampa[1]
				if kst_tab_meca.cert_forza_stampa = "1" then
					k_operazione = 1
				else
					k_operazione = 0
				end if
				kiuf_armo.forza_stampa_attestato(k_operazione, kst_tab_meca)
			end if
		
			if ki_aggiorna_aut_stampa_attestato_farma then
				ki_aggiorna_aut_stampa_attestato_farma = false
				kst_tab_meca.cert_farma_st_ok = dw_dett_0.object.meca_cert_farma_st_ok[1]
				if kst_tab_meca.cert_farma_st_ok = "1" then
					k_operazione = 1
				else
					k_operazione = 0
				end if
				kiuf_armo.aut_stampa_attestato_farma(k_operazione, kst_tab_meca)
			end if
			
			if ki_aggiorna_aut_stampa_attestato_aliment then
				ki_aggiorna_aut_stampa_attestato_aliment = false
				kst_tab_meca.cert_aliment_st_ok = dw_dett_0.object.meca_cert_aliment_st_ok[1]
				if kst_tab_meca.cert_aliment_st_ok = "1" then
					k_operazione = 1
				else
					k_operazione = 0
				end if
				kiuf_armo.aut_stampa_attestato_alimentare(k_operazione, kst_tab_meca)
			end if
		end if
		
		if ki_aggiorna_forza_convalida then
			ki_aggiorna_forza_convalida = false
			kst_tab_meca_dosim.id_meca = kst_tab_meca.id
			kiuf_meca_dosim.set_forza_convalida(kst_tab_meca_dosim)
			k_forzato = dw_dett_0.getitemnumber(1, "kflg_fconv")
			if k_forzato = 1 then
				k_forzato = 0
			else
				k_forzato = 0
			end if
			dw_dett_0.setitem(1,"kflg_fconv", k_forzato)
		end if
		

//--- Tutto OK 
		kguo_sqlca_db_magazzino.db_commit( )
		k_return ="0 "
			
//--- se tutto ok resetto il buffer di update
		dw_dett_0.resetupdate()
		

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
//=== Se tutto OK faccio la COMMIT		
		kguo_sqlca_db_magazzino.db_rollback( )
		k_return="1Fallito aggiornamento archivio 'Lotto di entrata'" &
					+ " ~n~r" &
					+ string(kst_esito.sqlcode) + " = " + trim(kst_esito.sqlerrtext) + "' ~n~r" 

	finally

//=== Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_default)


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

		if left(k_return, 1) = "1" then
			messagebox("Operazione di Aggiornamento Non Eseguita !!", &
				mid(k_return, 2))
		else
			if left(k_return, 1) = "3" then
				messagebox("Registrazione dati : problemi nella 'Commit' !!", &
					"Provare a chiudere e ripetere le operazioni eseguite")
			end if
		end if
	
	end try

return k_return

end function

public subroutine if_quarantena ();//
st_tab_meca_qtna kst_tab_meca_qtna


try

		kst_tab_meca_qtna.id_meca = dw_dett_0.object.id_meca[1]
		
		if kst_tab_meca_qtna.id_meca > 0 then
			kst_tab_meca_qtna.id_meca_qtna =  kiuf_meca_qtna.get_id_meca_qtna( kst_tab_meca_qtna)
			
			ki_quarantena_aperta = kiuf_meca_qtna.if_aperta( kst_tab_meca_qtna)
			if not ki_quarantena_aperta then 	
				ki_quarantena_giaaperta = kiuf_meca_qtna.if_giaaperta( kst_tab_meca_qtna)
			else
				ki_quarantena_giaaperta = false
			end if
			
			
		else
			kGuo_exception.inizializza( )
			kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessun Lotto indicato")
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end subroutine

public subroutine u_call_quarantena_note ();//
st_tab_meca_qtna 		kst_tab_meca_qtna
st_open_w					kst_open_w


try
	kst_tab_meca_qtna.id_meca = dw_dett_0.getitemnumber(dw_dett_0.getrow( ) , "id_meca")
	
	
	if kiuf_meca_qtna.if_sicurezza( kkg_flag_modalita.modifica) then
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	else
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	if trim(dw_dett_0.getitemstring(dw_dett_0.getrow( ) , "x_utente_inizio")) > " " then
		kiuf_meca_qtna.u_attiva_window_note(kst_tab_meca_qtna,kst_open_w)
	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Note Quarantena", "Prego, aprire la Quarantena prima di caricare le Note")
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
end try



end subroutine

public subroutine u_quarantena_apri ();//

st_tab_meca_qtna kst_tab_meca_qtna


try

	kst_tab_meca_qtna.id_meca = dw_dett_0.object.id_meca[1]
	
	if kst_tab_meca_qtna.id_meca > 0 then
		

		if messagebox("Apre Quarantena", "Apertura QUARANTENA per questo Lotto, confermare l'operazione !", stopsign!, yesno!, 2) = 1 then
			if kiuf_meca_qtna.apri(kst_tab_meca_qtna) then
				inizializza_lista()
				kGuo_exception.inizializza( )
				kGuo_exception.messaggio_utente( "Operazione Riusciuta", "Quarantena Aperta")	
			else
				kGuo_exception.inizializza( )
				kGuo_exception.messaggio_utente( "Operazione Fallita", "Quarantena non Aperta")	
			end if
		end if		
		
	else
		kGuo_exception.inizializza( )
		kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessun Lotto indicato")
	end if		
		

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
finally
	if_quarantena( )
end try

end subroutine

public subroutine u_quarantena_chiudi ();//

st_tab_meca_qtna kst_tab_meca_qtna


try

	kst_tab_meca_qtna.id_meca = dw_dett_0.object.id_meca[1]
	
	if kst_tab_meca_qtna.id_meca > 0 then
			
		if messagebox("Chiude Quarantena", "Chiusura QUARANTENA per questo Lotto, proseguire?", question!, yesno!, 2) = 1 then
			if kiuf_meca_qtna.chiudi(kst_tab_meca_qtna) then
				inizializza_lista()
				kGuo_exception.inizializza( )
				kGuo_exception.messaggio_utente( "Operazione Riuscita", "Quarantena Chiusa")	
			else
				kGuo_exception.inizializza( )
				kGuo_exception.messaggio_utente( "Operazione Fallita", "Quarantena non Chiusa")	
			end if
		end if		
	else
		kGuo_exception.inizializza( )
		kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessun Lotto indicato")
	end if		

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
finally
	if_quarantena( )		
end try

end subroutine

private subroutine autorizza_funzioni_1 ();//
//------------------------------------------------------------------------
//---
//--- Attiva/Disattiva le funzioni di questa windows
//---
//------------------------------------------------------------------------
//
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_barcode kst_tab_barcode 

	try
	
		setpointer(kkg.pointer_attesa)

		ki_consenti_apri_chiudi_quarantena =  false
		ki_consenti_forza_convalida = false

//--- forzatura Stampa dell'attestato consentita?
		kst_tab_meca.id =dw_dett_0.getitemnumber(dw_dett_0.getrow(), "id_meca")
		ki_consenti_forza_stampa_attestato=kiuf_armo.consenti_forza_stampa_attestato(kst_tab_meca)

//--- Autorizzazione Stampa dell'attestato Farmaceutico consentita?
		kst_tab_meca.id = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "id_meca")
		ki_consenti_aut_stampa_attestato_farma=kiuf_armo.consenti_aut_stampa_attestato_farma(kst_tab_meca)
	
//--- Autorizzazione Stampa dell'attestato Alimentare consentita?
		kst_tab_meca.id = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "id_meca")
		ki_consenti_aut_stampa_attestato_aliment=kiuf_armo.consenti_aut_stampa_attestato_alimentare(kst_tab_meca)
 
//--- Autorizzazione Blocco/Sblocco Riferimento Non-Conforme consentita?
		kst_tab_meca.id = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "id_meca")
		ki_consenti_sblocco_rif_incompleto = kiuf_armo.consenti_sblocco_meca_non_conforme(kst_tab_meca) 
		
//--- legge lo stato del Riferimento
		kiuf_armo.get_stato(kst_tab_meca)
	
		if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_blk then
			dw_dett_0.object.b_meca_stato.text = "Sblocca Riferimento Incompleto "
		else
			if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_blk_con_controllo or kst_tab_meca.stato = kiuf_armo.ki_meca_stato_blk_con_controllo_1 then
				dw_dett_0.object.b_meca_stato.text = "Sblocca Riferimento  "
			else
				if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_sblk then
					dw_dett_0.object.b_meca_stato.text = "Blocca Riferimento come Incompleto "
				else
					if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_OK then
						dw_dett_0.object.b_meca_stato.text = "Blocca Riferimento "
					else
						dw_dett_0.object.b_meca_stato.text = "Sblocca/Blocca Riferimento "
					end if
				end if
			end if
		end if

//-- Autorizza apri/chiudi lotto quarantena
		try 
			if kiuf_meca_qtna.if_sicurezza( kkg_flag_modalita.inserimento) then
				kst_tab_meca_qtna.id_meca = kst_tab_meca.id 
				ki_consenti_apri_chiudi_quarantena =  kiuf_meca_qtna.if_consenti_apri(kst_tab_meca_qtna)
				if not ki_consenti_apri_chiudi_quarantena then
					ki_consenti_apri_chiudi_quarantena =  kiuf_meca_qtna.if_aperta(kst_tab_meca_qtna)
				end if
			end if 
		catch (uo_exception kuo2_exception)
		end try

//-- Autorizza Forza Convalida del Lotto se almeno un dosimetro rilevato
		try 
			if kiuf_meca_fconv.if_sicurezza( kkg_flag_modalita.modifica) then
				kst_tab_meca_dosim.id_meca = kst_tab_meca.id 
				ki_consenti_forza_convalida =  kiuf_meca_dosim.if_consenti_forza_convalida(kst_tab_meca_dosim)
			end if 
		catch (uo_exception kuo3_exception)
		end try
	

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	end try
	
	setpointer(kkg.pointer_default)
	
	

end subroutine

private subroutine autorizza_funzioni ();//
//------------------------------------------------------------------------
//---
//--- Attiva/Disattiva le funzioni di questa windows
//---
//------------------------------------------------------------------------
//

setpointer(kkg.pointer_attesa)
st_tab_meca kst_tab_meca

try
	
//--- se sono in visualizzazione o cancellazione non consente alcuna 'forzatura' o autorizzazione 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		ki_consenti_forza_stampa_attestato = false
		ki_consenti_aut_stampa_attestato_farma = false
		ki_consenti_aut_stampa_attestato_aliment = false
		ki_consenti_sblocco_rif_incompleto = false
		ki_consenti_apri_chiudi_quarantena = false
		ki_consenti_forza_convalida = false
	else
		kst_tab_meca.id =dw_dett_0.getitemnumber(dw_dett_0.getrow(), "id_meca")
		if not kiuf_armo.if_lotto_chiuso(kst_tab_meca) then
//--- Imposta i campi ki_consenti....
			autorizza_funzioni_1()
		end if
	end if

//--- Attiva/Disattiva pulsanti
	dw_dett_0.object.b_meca_cert_forza_stampa.enabled = ki_consenti_forza_stampa_attestato
	dw_dett_0.object.b_meca_cert_farma_st_ok.enabled = ki_consenti_aut_stampa_attestato_farma
	dw_dett_0.object.b_meca_cert_aliment_st_ok.enabled = ki_consenti_aut_stampa_attestato_aliment
	dw_dett_0.object.b_meca_stato.enabled = ki_consenti_sblocco_rif_incompleto
	dw_dett_0.object.b_meca_quarantena.enabled = ki_consenti_apri_chiudi_quarantena
	dw_dett_0.object.b_convalida.enabled = ki_consenti_forza_convalida

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	setpointer(kkg.pointer_default)
	
end try

end subroutine

private subroutine call_memo ();//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
st_tab_meca_memo kst_tab_meca_memo 
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout


try   
	k_riga = dw_dett_0.getrow()
	if k_riga > 0 then

		kuf1_memo = create kuf_memo
		kuf1_memo_inout = create kuf_memo_inout
	
		kst_tab_meca_memo.id_meca_memo = dw_dett_0.getitemnumber( k_riga, "id_meca_memo" ) 
		kst_tab_meca_memo.id_meca = dw_dett_0.getitemnumber( k_riga, "id_meca" ) 
			
		if kst_tab_meca_memo.id_meca  > 0 then
			kst_tab_meca_memo.tipo_sv = ki_st_open_w.sr_settore // kuf1_memo.kki_tipo_sv_QLT
			kst_memo.st_tab_meca_memo = kst_tab_meca_memo
			kuf1_memo_inout.memo_xmeca(kst_memo.st_tab_meca_memo, kst_memo.st_tab_memo)
			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

protected function integer modifica ();//
st_tab_g_0 kst_tab_g_0


	kst_tab_g_0.id = dw_dett_0.getitemnumber(1, "id_meca")
	kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )

return 1

end function

protected function integer visualizza ();//
st_tab_g_0 kst_tab_g_0


	kst_tab_g_0.id = dw_dett_0.getitemnumber(1, "id_meca")
	kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )

return 1

end function

public function boolean u_lancia_funzione_imvc (st_open_w kst_open_w_arg);//---
//--- lancia la funzione giusta di Inserimento/Modifica/Visualizzazione/Cancellazione
//---
//--- Inp: st_open_w.flag_modalita
//--- Out: boolean: TRUE = OK
//---
boolean k_return = false
st_open_w kst_open_w


	kst_open_w.flag_modalita = kst_open_w_arg.flag_modalita

		
	if dw_dett_0.rowcount( ) > 0 then
			
		choose case kst_open_w.flag_modalita
		
//			case kkg_flag_modalita.inserimento
//
//				inserisci( )
//				k_return = true
				
				
			case kkg_flag_modalita.modifica
				modifica()
				k_return = true
				
			case kkg_flag_modalita.visualizzazione
				visualizza()
				k_return = true
				
		end choose
		
	end if
	


return k_return



end function

protected function string check_dati ();//
//--- Non deve fare alcun controllo
//
return "0"

end function

private subroutine forza_convalida ();//


	dw_dett_0.object.b_convalida.enabled = false

	ki_aggiorna_forza_convalida = true

	cb_aggiorna.triggerevent(clicked!)
	
	try
		inizializza_lista()
	catch (uo_exception kuo_exception)
	end try

	ki_aggiorna_forza_convalida = false

	dw_dett_0.object.b_convalida.enabled = true

end subroutine

protected subroutine attiva_menu ();//
super::attiva_tasti_0()

cb_inserisci.enabled = true
cb_modifica.enabled = true
cb_visualizza.enabled = true


end subroutine

on w_meca_autorizza.create
call super::create
end on

on w_meca_autorizza.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
	if isvalid(kiuf_armo) then destroy kiuf_armo
	if isvalid(kiuf_meca_qtna) then destroy kiuf_meca_qtna
	if isvalid(kiuf_meca_fconv) then destroy kiuf_meca_fconv
	if isvalid(kiuf_meca_dosim) then destroy kiuf_meca_dosim
	
end event

type st_ritorna from w_g_tab0`st_ritorna within w_meca_autorizza
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_meca_autorizza
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_meca_autorizza
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_meca_autorizza
end type

type st_stampa from w_g_tab0`st_stampa within w_meca_autorizza
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_meca_autorizza
end type

type cb_modifica from w_g_tab0`cb_modifica within w_meca_autorizza
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_meca_autorizza
end type

type cb_cancella from w_g_tab0`cb_cancella within w_meca_autorizza
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_meca_autorizza
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_meca_autorizza
boolean visible = true
boolean enabled = true
string dataobject = "d_meca_1_autorizza"
boolean hsplitscroll = false
boolean ki_dw_visibile_in_open_window = true
end type

event dw_dett_0::buttonclicked;call super::buttonclicked;//
choose case dwo.name
		
	case "b_meca_cert_forza_stampa"
		forza_stampa_attestato()		

	case "b_meca_cert_farma_st_ok"
		autorizza_stampa_attestato_farma()		

	case "b_meca_cert_aliment_st_ok"
		autorizza_stampa_attestato_aliment()		

	case "b_meca_stato"
		sblocca_meca_non_conforme()		
		
//--- Quarantena
	case  "b_meca_quarantena"
		if not ki_quarantena_aperta then
			//--- Quarantena Apri
			u_quarantena_apri()
		else
			//--- Quarantena Chiudi
			u_quarantena_chiudi()
		end if
		
	case "b_convalida"
		forza_convalida( )

////--- memo: carico note e allegati
//	case "p_id_memo_no" 
//		call_memo()
		
end choose


end event

event dw_dett_0::clicked;call super::clicked;//
choose case dwo.name
		
		
	case "p_img_qtna_note_mod"
		u_call_quarantena_note( )
		
		
end choose

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_meca_autorizza
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_meca_autorizza
boolean enabled = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_meca_autorizza
end type

