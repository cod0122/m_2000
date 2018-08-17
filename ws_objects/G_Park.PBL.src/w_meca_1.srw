$PBExportHeader$w_meca_1.srw
forward
global type w_meca_1 from w_g_tab_3
end type
type dw_armo from uo_d_std_1 within w_meca_1
end type
type dw_cambia_numero from uo_d_std_1 within w_meca_1
end type
end forward

global type w_meca_1 from w_g_tab_3
integer width = 2510
integer height = 1956
string title = "Lotto"
long backcolor = 67108864
boolean ki_toolbar_window_presente = true
dw_armo dw_armo
dw_cambia_numero dw_cambia_numero
end type
global w_meca_1 w_meca_1

type variables
//
	kuf_armo kiuf_armo

//	private datastore kdsi_elenco 
	private string ki_path_risorse 
	private boolean ki_consenti_forza_stampa_attestato=true
	private boolean ki_consenti_aut_stampa_attestato_farma=true
	private boolean ki_consenti_aut_stampa_attestato_aliment=true
	private boolean ki_consenti_sblocco_rif_incompleto=true
	private boolean ki_consenti_modalita_inserimento=false
	private boolean ki_consenti_crea_packing_list=false
	
	private boolean ki_aggiorna_forza_stampa_attestato=false
	private boolean ki_aggiorna_aut_stampa_attestato_farma=false
	private boolean ki_aggiorna_aut_stampa_attestato_aliment=false

//--- flag x segnalare se fare la modifica dati num/data lotto
	private boolean kist_flag_cambia_numero_data=false
	private st_tab_meca kist_tab_meca_orig
end variables

forward prototypes
protected subroutine inizializza_1 ()
protected function string check_dati ()
protected function integer cancella ()
protected function string inizializza ()
private subroutine forza_stampa_attestato ()
private subroutine autorizza_stampa_attestato_farma ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string aggiorna ()
private subroutine autorizza_stampa_attestato_aliment ()
private subroutine sblocca_meca_non_conforme ()
protected subroutine stampa ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_tasti ()
protected function integer visualizza ()
private subroutine inserisci_riga ()
protected subroutine open_start_window ()
public subroutine cambia_num_data ()
private subroutine u_genera_alcuni_dati_lotto ()
private subroutine u_genera_packing_list ()
public subroutine autorizza_funzioni ()
private subroutine u_accoppia_dosimetro ()
protected subroutine inizializza_3 () throws uo_exception
end prototypes

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
string k_codice_attuale, k_codice_prec
st_tab_armo kst_tab_armo
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = string(kst_tab_armo.id_meca)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_2.dw_2.retrieve(kst_tab_armo.id_meca)  

end if				
				

attiva_tasti()
//if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	tab_1.tabpage_2.dw_2.insertrow(0) 
//end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
//long k_nr_righe
//int k_riga
//int k_nr_errori
//string k_key_str
//char k_stato, k_tipo
//string k_key, k_testo
//st_tab_certif kst_tab_certif
//
//
////=== Controllo il primo tab
//	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
//	k_nr_errori = 0
//	k_riga = 1
//
//	kst_tab_certif.dose_min = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_min") 
//	kst_tab_certif.dose_max = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dose_max") 
//	kst_tab_certif.st_dose_min = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "st_dose_min") 
//	kst_tab_certif.st_dose_max = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "st_dose_max") 
//	kst_tab_certif.st_data_ini = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "st_data_ini") 
//	kst_tab_certif.st_data_fin = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "st_data_fin") 
//	
//	if isnull(kst_tab_certif.dose_min) then
//		kst_tab_certif.dose_min = 0
//	end if
//	if isnull(kst_tab_certif.dose_max) then
//		kst_tab_certif.dose_max = 0
//	end if
//
//	if kst_tab_certif.st_dose_min = "S" and kst_tab_certif.st_dose_max = "S" then
//		if kst_tab_certif.dose_min > 0 and kst_tab_certif.dose_max > 0 & 
//			and kst_tab_certif.dose_min > kst_tab_certif.dose_max then 
//			k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
//			k_return = tab_1.tabpage_1.text + ": Dose minima maggiore di Dose massima, valore non accettato  '" + k_testo + "'. " + "~n~r"
//			k_errore = "1"
//			k_nr_errori++
//		end if
//	end if
//
//	if k_errore = "0" or k_errore = "4" then
//		if kst_tab_certif.st_dose_min = "S" then
//			if kst_tab_certif.dose_min = 0 then 
//				k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
//				k_return = tab_1.tabpage_1.text + ": Richiesto in stampa la Dose Minima '" + k_testo + "'. " + "~n~r"
//				k_errore = "3"
//				k_nr_errori++
//			end if
//		end if
//		if kst_tab_certif.st_dose_max = "S" then
//			if kst_tab_certif.dose_max = 0 then 
//				k_testo = trim(tab_1.tabpage_1.dw_1.object.nome_t.text)
//				k_return = tab_1.tabpage_1.text + ": Richiesto in stampa la Dose Massima '" + k_testo + "'. " + "~n~r"
//				k_errore = "3"
//				k_nr_errori++
//			end if
//		end if
//	end if
//	
////	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_programma")) = true then
////		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_programma_t.text)
////		k_return = k_return + tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r" 
////		k_errore = "3"
////		k_nr_errori++
////	end if
//
//	if k_errore = "0" then
//	
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", today())
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", KGUO_UTENTE.GET_CODICE())
//		
//	end if
//
////
//////=== Controllo altro tab
////	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
////	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
////
////	do while k_riga > 0  and k_nr_errori < 10
////
////		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 
////
////		if isnull(k_key) then
////			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
////			k_key = 0
////		end if
////
////		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
////				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
////				string(k_riga, "#####") + " non impostata~n~r" 
////				k_errore = "4"
////				k_nr_errori++
////			end if
////
////			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
////				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
////				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
////							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
////							(k_riga+1), k_nr_righe) > 0 then
////					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
////					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
////					k_errore = "4"
////					k_nr_errori++
////				end if
////			end if
////		end if
////		k_riga++
////
////		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
////
////	loop
////
//////=== Controllo altro tab
////	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
////	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
////
////	do while k_riga > 0  and k_nr_errori < 10
////
////		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 
////
////
////		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////
////			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
////				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
////				string(k_riga, "#####") + " ~n~r" 
////				k_errore = "3"
////				k_nr_errori++
////			end if
////
////			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
////				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
////					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
////					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
////					string(k_riga, "#####") + " ~n~r" 
////					k_errore = "4"
////					k_nr_errori++
////				end if
////			end if
////
////		end if
////		k_riga++
////
////		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
////
////	loop
////
////
////
return k_errore + k_return


end function

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1, k_key, k_testo
string k_errore = "0 "
long k_riga
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti

//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " " + trim(tab_1.tabpage_1.text) + " "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")
				kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
				kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "meca_data_int")
				
				if isnull(kst_tab_meca.num_int) or kst_tab_meca.num_int = 0 then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.codice_t.text)
					k_record_1 = &
					"Sei sicuro di voler eliminare l'intero RIFERIMENTO SENZA Numero~n~r" 
				else
					k_record_1 = &
					"Sei sicuro di voler eliminare l'intero RIFERIMENTO~n~r" &
					+ "Numero: " + string(kst_tab_meca.num_int)  &
					+ " del  " + string(kst_tab_meca.data_int, "dd.mm.yy")  &
				   + " ?"
				end if
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_meca.id))
		
	case 2  
		k_record = " " + trim(tab_1.tabpage_2.text) + " " 
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then

			kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo")
				
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				
				kst_tab_armo.num_int = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "num_int")
				kst_tab_armo.art = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "art")
				
				if isnull(kst_tab_armo.art) or len(trim(kst_tab_armo.art)) = 0 then
					k_testo = trim(tab_1.tabpage_2.dw_2.object.nome_t.text)
					kst_tab_armo.art = "senza " + k_testo
					kst_tab_prodotti.des = " "
				else
					kst_tab_prodotti.des = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "prodotti_des")
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la riga del Lotto nr. " + string(kst_tab_armo.num_int) + "  (id= " + string(kst_tab_armo.id_armo) + ") ~n~r" + &
					"Articolo " + trim(kst_tab_armo.art) + "   " + trim(kst_tab_prodotti.des) + " " &
				   + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_armo.id_armo))
		
		
end choose	



//=== Se righe in lista
if k_riga > 0 and len(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				kst_esito = kiuf_armo.tb_delete_riferimento(kst_tab_meca) 
			case 2
				kst_esito = kiuf_armo.tb_delete_riga(kst_tab_armo) 
		end choose	
		if kst_esito.esito = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else

				if len(trim(kst_esito.sqlerrtext)) = 0 then
					messagebox("Elimina " + k_record,  &
								  "Operazione conclusa correttamente.")
				else
					messagebox("Elimina " + k_record,  &
				  "Operazione conclusa correttamente.~n~r" &
				  + "Prestare Attenzione alle seguenti segnalazioni:~n~r" &
				  + trim(kst_esito.sqlerrtext))
				end if
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 2
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
						  trim(kst_esito.SQLErrText) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + mid(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kiuf_armo

	else
		messagebox("Elimina " + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
end choose	


return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string  k_key
int k_errore = 0
int k_err_ins, k_rc
pointer kpointer_orig
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
st_open_w kst_open_w
kuf_armo_inout kuf1_armo_inout
kuf_utility kuf1_utility
kuf_sicurezza kuf1_sicurezza


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)

kpointer_orig = setpointer(hourglass!)

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)  // numero certificato

	if len(k_key) = 0 or not isnumber(k_key) then
		
//		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()

	else

		kst_tab_meca.id = long(k_key)
		k_rc = tab_1.tabpage_1.dw_1.retrieve(kst_tab_meca.id) 
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Riferimento cercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> kkg_flag_modalita_inserimento then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il Riferimento non e' in Archivio ~n~r" + &
						"(Numero cercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta =  kkg_flag_modalita_inserimento then
					cb_inserisci.postevent(clicked!)
				end if
				
				tab_1.tabpage_1.dw_1.setrow(1)
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("meca_cert_forza_stampa")

//--- salva campi come in origine
				kist_tab_meca_orig.num_int = tab_1.tabpage_1.dw_1.object.num_int[1]
				kist_tab_meca_orig.data_int = tab_1.tabpage_1.dw_1.object.meca_data_int[1]
				kist_tab_meca_orig.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

				attiva_tasti()
		
		end choose

	end if

//	kdwc_dw1.retrieve()

else
	attiva_tasti()
end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then


//-- abilita le funzioni onsentite x questa window 
	autorizza_funzioni( )

	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita_cancellazione then

		ki_esci_dopo_cancella = true
		cb_cancella.postevent (clicked!)
//		cb_ritorna.postevent(clicked!)
		
	end if
end if



return "0"


end function

private subroutine forza_stampa_attestato ();//
st_tab_meca kst_tab_meca


	kst_tab_meca.cert_forza_stampa = tab_1.tabpage_1.dw_1.object.meca_cert_forza_stampa[1]
	if kst_tab_meca.cert_forza_stampa = "1" then
		tab_1.tabpage_1.dw_1.object.meca_cert_forza_stampa[1] = "0"
	else
		tab_1.tabpage_1.dw_1.object.meca_cert_forza_stampa[1] = "1"
	end if

	ki_aggiorna_forza_stampa_attestato = true

	cb_aggiorna.triggerevent(clicked!)
	try
		inizializza_lista()
	catch (uo_exception kuo_exception)
	end try

	ki_aggiorna_forza_stampa_attestato = false


end subroutine

private subroutine autorizza_stampa_attestato_farma ();//
st_tab_meca kst_tab_meca


	kst_tab_meca.cert_farma_st_ok = tab_1.tabpage_1.dw_1.object.meca_cert_farma_st_ok[1]
	if kst_tab_meca.cert_farma_st_ok = "1" then
		tab_1.tabpage_1.dw_1.object.meca_cert_farma_st_ok[1] = "0"
	else
		tab_1.tabpage_1.dw_1.object.meca_cert_farma_st_ok[1] = "1"
	end if

	ki_aggiorna_aut_stampa_attestato_farma = true

	cb_aggiorna.triggerevent(clicked!)
	
	try
		inizializza_lista()
	catch (uo_exception kuo_exception)
	end try

	ki_aggiorna_aut_stampa_attestato_farma = false

end subroutine

protected subroutine attiva_menu ();//
st_tab_meca kst_tab_meca


	super::attiva_menu()
	
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if kG_menu.m_strumenti.m_fin_gest_libero1.enabled <> ki_consenti_forza_stampa_attestato then
		kG_menu.m_strumenti.m_fin_gest_libero1.text = "Attiva/Disattiva Forza Stampa Attestato"
		kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Attiva/Disattiva Forza Stampa Attestato"
		kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero1.enabled =ki_consenti_forza_stampa_attestato
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext =  "Forza,"+&
												 kG_menu.m_strumenti.m_fin_gest_libero1.text
	//	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	end if

	if ((ki_consenti_aut_stampa_attestato_farma or ki_consenti_aut_stampa_attestato_aliment) and NOT kG_menu.m_strumenti.m_fin_gest_libero2.enabled) &
			or ((NOT ki_consenti_aut_stampa_attestato_farma and NOT ki_consenti_aut_stampa_attestato_aliment) and kG_menu.m_strumenti.m_fin_gest_libero2.enabled) then 

		kG_menu.m_strumenti.m_fin_gest_libero2.text = "Attiva/Disattiva Autorizzazione Stampa Attestato"
		kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Attiva/Disattiva Aut.Stampa Attestato"
		if ki_consenti_aut_stampa_attestato_aliment then
			kG_menu.m_strumenti.m_fin_gest_libero2.text = kG_menu.m_strumenti.m_fin_gest_libero2.text &
																					+ " Alimentare" 
			kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = kG_menu.m_strumenti.m_fin_gest_libero2.microhelp &
																					+ " Alimentare" 
		end if
		if ki_consenti_aut_stampa_attestato_farma then
			kG_menu.m_strumenti.m_fin_gest_libero2.text = kG_menu.m_strumenti.m_fin_gest_libero2.text &
																					+ " Farmaceutico" 
			kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = kG_menu.m_strumenti.m_fin_gest_libero2.microhelp &
																					+ " Farmaceutico" 
		end if
		kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
		if ki_consenti_aut_stampa_attestato_farma or ki_consenti_aut_stampa_attestato_aliment then
			kG_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero2.enabled = false
		end if
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = "Autorizza,"+&
												 kG_menu.m_strumenti.m_fin_gest_libero2.text
	//	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if
	

	if (ki_consenti_sblocco_rif_incompleto and NOT kG_menu.m_strumenti.m_fin_gest_libero3.enabled) &
			or (tab_1.tabpage_1.dw_1.rowcount() = 0 and kG_menu.m_strumenti.m_fin_gest_libero3.enabled) &
			or	(NOT ki_consenti_sblocco_rif_incompleto and kG_menu.m_strumenti.m_fin_gest_libero3.enabled) then

		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
		else
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
		//--- legge lo stato del Riferimento
			kiuf_armo.get_stato(kst_tab_meca)
		
			if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_blk then
				kG_menu.m_strumenti.m_fin_gest_libero3.text = "Sblocco Riferimento Incompleto "
				kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Sblocco Riferimento Incompleto "
				kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Sblocco,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
			else
				if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_blk_con_controllo then
					kG_menu.m_strumenti.m_fin_gest_libero3.text = "Sblocco Riferimento  "
					kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Sblocco Riferimento  "
					kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Sblocco,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
				else
					if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_sblk then
						kG_menu.m_strumenti.m_fin_gest_libero3.text = "Blocco Riferimento come Incompleto "
						kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Blocco Riferimento come Incompleto "
						kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Blocco,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
					else
						if kst_tab_meca.stato = kiuf_armo.ki_meca_stato_OK then
							kG_menu.m_strumenti.m_fin_gest_libero3.text = "Blocco Riferimento "
							kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Blocco Riferimento "
							kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Blocca,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
						else
							kG_menu.m_strumenti.m_fin_gest_libero3.text = "Sblocco/Blocco Riferimento "
							kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Sblocco/Blocco Riferimento "
							kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = "Sblocco,"+kG_menu.m_strumenti.m_fin_gest_libero3.text
						end if
					end if
				end if
			end if
			if ki_consenti_sblocco_rif_incompleto then
				kG_menu.m_strumenti.m_fin_gest_libero3.enabled = true
			else
				kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
			end if
		end if
	//	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex = 3
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	end if


//--- Rigenera alcuni dati del Lotto 		
	if kG_menu.m_strumenti.m_fin_gest_libero4.enabled <>  cb_aggiorna.enabled then
		kG_menu.m_strumenti.m_fin_gest_libero4.text = "Sistema la data di Fine Trattamento "
		kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Sistema la data di Fine Trattamento "
		kG_menu.m_strumenti.m_fin_gest_libero4.enabled =  cb_aggiorna.enabled
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext =  "Rigenera,"+ kG_menu.m_strumenti.m_fin_gest_libero4.text
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = false
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
	end if

//--- Carica/Modifica Riga "NO-DOSE"
	if kG_menu.m_strumenti.m_fin_gest_libero5.enabled <> ki_consenti_modalita_inserimento then
		kG_menu.m_strumenti.m_fin_gest_libero5.text = "Aggiungi riga da non Trattare"
		kG_menu.m_strumenti.m_fin_gest_libero5.microhelp = &
		"Aggiungi riga Articolo da non Sterilizzare"
		kG_menu.m_strumenti.m_fin_gest_libero5.enabled =ki_consenti_modalita_inserimento
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext =  "Aggiungi,"+&
												 kG_menu.m_strumenti.m_fin_gest_libero5.text
	//	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	end if


//--- Associa Dosimetro
	if kG_menu.m_strumenti.m_fin_gest_libero6.enabled <>  ki_consenti_modalita_inserimento then
		kG_menu.m_strumenti.m_fin_gest_libero6.text = "Accoppia Dosimetro "
		kG_menu.m_strumenti.m_fin_gest_libero6.microhelp = "Accoppia Dosimetro "
		kG_menu.m_strumenti.m_fin_gest_libero6.enabled =  ki_consenti_modalita_inserimento
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext =  "Accoppia,"+ kG_menu.m_strumenti.m_fin_gest_libero6.text
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = false
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
	end if


//--- Modifica numero/data LOTTO
	if (tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_consenti_modalita_inserimento and kist_tab_meca_orig.num_int > 0 and NOT kG_menu.m_strumenti.m_fin_gest_libero7.enabled) &
			or ((tab_1.tabpage_1.dw_1.rowcount() = 0 or NOT ki_consenti_modalita_inserimento) and  kG_menu.m_strumenti.m_fin_gest_libero7.enabled) &
			then
	
		kG_menu.m_strumenti.m_fin_gest_libero8.text = "Modifica Numero/Data Lotto"
		kG_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Modifica Numero/Data del Lotto"
		if tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_consenti_modalita_inserimento and kist_tab_meca_orig.num_int > 0 then
			kG_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero8.enabled = false
		end if
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext =  "Cambia,"+&
												 kG_menu.m_strumenti.m_fin_gest_libero8.text
	//	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex = 2
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
	end if


//--- Genera PKLIST fittizia
	if kG_menu.m_strumenti.m_fin_gest_libero9.enabled <> ki_consenti_crea_packing_list  then
		kG_menu.m_strumenti.m_fin_gest_libero9.text = "Genera Packing-List fittizia "
		kG_menu.m_strumenti.m_fin_gest_libero9.microhelp = "Genera Packing-List fittizia "
		kG_menu.m_strumenti.m_fin_gest_libero9.enabled =  ki_consenti_crea_packing_list
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemtext =  "Pck-List,"+ kG_menu.m_strumenti.m_fin_gest_libero9.text
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
	end if


//--- cambia menu stanard:
	choose case tab_1.selectedtab  
		case 1 
			kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = this.cb_inserisci.enabled
			kG_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Nuovo Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_inserimento.microhelp = "Carica nuovo Lotto (Riferimento)"
			kG_menu.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = "Nuovo," + kG_menu.m_finestra.m_gestione.m_fin_inserimento.text
			kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = this.cb_cancella.enabled
			kG_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Elimina definitivamente l'intero Lotto (Riferimento) "
			kG_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Cancella,"+ kG_menu.m_finestra.m_gestione.m_fin_elimina.text
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = this.cb_visualizza.enabled
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.text = "Visualizza Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.microhelp = "Visualizza Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.toolbaritemtext = "Visualizza," + kG_menu.m_finestra.m_gestione.m_fin_visualizza.text 
			kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled
			kG_menu.m_finestra.m_gestione.m_fin_modifica.text = "Modifica Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_modifica.microhelp = "Modifica Lotto (riga Riferimento)"
			kG_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemtext = "Modifica," + kG_menu.m_finestra.m_gestione.m_fin_modifica.text 
		case 2
			kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = this.cb_cancella.enabled
			kG_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina Riga Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Elimina definitivamente la Riga Lotto (riga Riferimento) "
			kG_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Cancella,"+ kG_menu.m_finestra.m_gestione.m_fin_inserimento.text
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = this.cb_visualizza.enabled
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.text = "Visualizza dettaglio Riga"
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.microhelp = "Visualizza in dettaglio la Riga Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.toolbaritemtext = "Visualizza," + kG_menu.m_finestra.m_gestione.m_fin_visualizza.text 
			kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled
			kG_menu.m_finestra.m_gestione.m_fin_modifica.text = "Modifica Riga Lotto"
			kG_menu.m_finestra.m_gestione.m_fin_modifica.microhelp = "Modifica Riga Lotto (riga Riferimento)"
			kG_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemtext = "Modifica," + kG_menu.m_finestra.m_gestione.m_fin_modifica.text 

		case 3
			kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled =  this.cb_cancella.enabled
			kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled =  this.cb_visualizza.enabled
			kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled
			
			
	end choose	
		
	
	if ki_st_open_w.flag_primo_giro = 'S' then
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero5.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero6.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero8.visible = true
		kG_menu.m_strumenti.m_fin_gest_libero9.visible = true
		
//		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = kg_path_risorse + "\cert_forza_stampa.bmp"
//		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = kg_path_risorse + "\cert_aut_stampa.bmp"
//		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = kg_path_risorse + "\meca_incompleto.bmp"
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "cert_forza_stampa.bmp"
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cert_aut_stampa.bmp"
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "meca_incompleto.bmp"
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "Regenerate5!"
		kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = "UnionReturn!"
		kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemname = "Insert!"
		kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemname = "CheckDiff!"
		kG_menu.m_strumenti.m_fin_gest_libero9.toolbaritemname = "Compile!"
	end if


end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case left(k_par_in, 2) 

//--- Personalizzo da qui
	case kkg_flag_richiesta_libero1 
		if cb_aggiorna.enabled  then
			forza_stampa_attestato()		
		end if
		

//--- 
	case kkg_flag_richiesta_libero2 		
		if cb_aggiorna.enabled  then
			if ki_consenti_aut_stampa_attestato_farma then
				autorizza_stampa_attestato_farma()		
			end if
			if ki_consenti_aut_stampa_attestato_aliment then
				autorizza_stampa_attestato_aliment()		
			end if
		end if
		
//--- Blocca/Sblocca stato del Riferimento
	case kkg_flag_richiesta_libero3
		if cb_aggiorna.enabled  then
			sblocca_meca_non_conforme()		
		end if
		
//--- Rigenera alcuni dati del Riferimento
	case kkg_flag_richiesta_libero4
		u_genera_alcuni_dati_lotto()		
		
//--- Nuova riga Lotto
	case kkg_flag_richiesta_libero5
		inserisci_riga()
		
//--- Accoppia Dosimetro
	case kkg_flag_richiesta_libero6
		u_accoppia_dosimetro()
		
//--- Cambia numero data lotto
	case kkg_flag_richiesta_libero8
		cambia_num_data()
		
//--- Genera packing-list fittizia
	case kkg_flag_richiesta_libero9
		u_genera_packing_list( )
		
		
	case else // standard
		super::smista_funz(k_par_in)
		
end choose



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
st_esito kst_esito
st_tab_meca kst_tab_meca
pointer kp_oldpointer


//=== Puntatore Cursore da attesa..... 
kp_oldpointer = SetPointer(HourGlass!)

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	if ki_aggiorna_forza_stampa_attestato then
	   ki_aggiorna_forza_stampa_attestato = false
		kst_tab_meca.cert_forza_stampa = tab_1.tabpage_1.dw_1.object.meca_cert_forza_stampa[1]
		if kst_tab_meca.cert_forza_stampa = "1" then
			k_operazione = 1
		else
			k_operazione = 0
		end if
		kst_esito = kiuf_armo.forza_stampa_attestato(k_operazione, kst_tab_meca)
	end if

	if ki_aggiorna_aut_stampa_attestato_farma then
		ki_aggiorna_aut_stampa_attestato_farma = false
		kst_tab_meca.cert_farma_st_ok = tab_1.tabpage_1.dw_1.object.meca_cert_farma_st_ok[1]
		if kst_tab_meca.cert_farma_st_ok = "1" then
			k_operazione = 1
		else
			k_operazione = 0
		end if
		kst_esito = kiuf_armo.aut_stampa_attestato_farma(k_operazione, kst_tab_meca)
	end if
	
	if ki_aggiorna_aut_stampa_attestato_aliment then
		ki_aggiorna_aut_stampa_attestato_aliment = false
		kst_tab_meca.cert_aliment_st_ok = tab_1.tabpage_1.dw_1.object.meca_cert_aliment_st_ok[1]
		if kst_tab_meca.cert_aliment_st_ok = "1" then
			k_operazione = 1
		else
			k_operazione = 0
		end if
		kst_esito = kiuf_armo.aut_stampa_attestato_alimentare(k_operazione, kst_tab_meca)
	end if

//--- Cambio il NUM/DATA_INT del Lotto
	if kist_tab_meca_orig.num_int > 0 and kist_tab_meca_orig.num_int <> tab_1.tabpage_1.dw_1.object.num_int[1] or kist_tab_meca_orig.data_int <> tab_1.tabpage_1.dw_1.object.meca_data_int[1]  then 
		
		try
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
			kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.object.num_int[1]
			kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.object.meca_data_int[1]
			kst_tab_meca.st_tab_g_0.esegui_commit = "N"
			kiuf_armo.set_num_data_int(kst_tab_meca)
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			
		end try
		
	end if
	
	
	if kst_esito.sqlcode >= 0 then

//	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		kst_esito = kuf1_data_base.db_commit_1( )
		if kst_esito.esito <> kkg_esito_ok then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
			
//--- se tutto ok resetto il buffer di update
			tab_1.tabpage_1.dw_1.resetupdate()
		
		end if
	else
		kuf1_data_base.db_rollback_1( )
		
		k_return="1Fallito aggiornamento archivio '" &
					+ tab_1.tabpage_1.text + "' ~n~r" &
					+ string(kst_esito.sqlcode) + " = " + trim(kst_esito.sqlerrtext) + "' ~n~r" 
	end if
end if



//=== Puntatore Cursore da attesa.....
SetPointer(kp_oldpointer)


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


return k_return

end function

private subroutine autorizza_stampa_attestato_aliment ();//
st_tab_meca kst_tab_meca


	kst_tab_meca.cert_farma_st_ok = tab_1.tabpage_1.dw_1.object.meca_cert_aliment_st_ok[1]
	if kst_tab_meca.cert_farma_st_ok = "1" then
		tab_1.tabpage_1.dw_1.object.meca_cert_aliment_st_ok[1] = "0"
	else
		tab_1.tabpage_1.dw_1.object.meca_cert_aliment_st_ok[1] = "1"
	end if

	ki_aggiorna_aut_stampa_attestato_aliment = true

	cb_aggiorna.triggerevent(clicked!)
	

	inizializza_lista()

	ki_aggiorna_aut_stampa_attestato_aliment = false

end subroutine

private subroutine sblocca_meca_non_conforme ();//
int k_ok=0
st_tab_meca kst_tab_meca


//		ki_consenti_sblocco_rif_incompleto = true

	
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	try

//--- Modifica 
		k_ok = messagebox("Operazione di: "+trim(kG_menu.m_strumenti.m_fin_gest_libero3.text), "Cambia lo Stato del Riferimento?", &
							question!, yesno!, 2) 
		if k_ok = 1 then
//--- aggiorna lo stato del Riferimento
			kiuf_armo.meca_non_conforme_blocca_sblocca(kst_tab_meca)
			inizializza_lista()
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	end try




end subroutine

protected subroutine stampa ();//long k_id_stampa
//
//	k_id_stampa = printopen("prova")
//	
//	printdatawindow(k_id_stampa, tab_1.tabpage_1.dw_1)
//	printclose(k_id_stampa)

super::stampa()


end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
string k_codice_attuale, k_codice_prec
st_tab_armo kst_tab_armo
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = string(kst_tab_armo.id_meca)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_3.dw_3.retrieve(kst_tab_armo.id_meca)  

end if				
				

attiva_tasti()
//if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//	tab_1.tabpage_3.dw_3.insertrow(0) 
//end if


tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

protected subroutine attiva_tasti ();//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe

super::attiva_tasti()

cb_cancella.enabled = false


//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() = 0 then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	
	cb_inserisci.enabled = false
	cb_inserisci.default = false

else

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca") > 0 then
		tab_1.tabpage_2.enabled = true
		tab_1.tabpage_3.enabled = true
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then
				cb_cancella.enabled = true
			end if
		case 2 //righe
		   	cb_visualizza.enabled = true
			if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
					or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
				cb_modifica.enabled = true
				cb_inserisci.enabled = true
			end if
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then
				cb_cancella.enabled = true
			end if
		case 3 //barcode
			cb_modifica.enabled = false
			cb_inserisci.enabled = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
	end choose

end if


attiva_menu()



end subroutine

protected function integer visualizza ();//=== 
//=== 
//===
long k_riga=0
st_esito kst_esito
st_tab_armo kst_tab_armo


choose case tab_1.selectedtab 
		
	case 1 
		
	case 2  
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then

			kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo")
			
			try
				
				dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita_visualizzazione)
				
			catch (uo_exception kuo_exception )
				kst_esito = kuo_exception.get_st_esito()
				if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_not_fnd then
					kuo_exception.messaggio_utente()
				end if
				
			end try
				
		end if
		
		
end choose	

return 0
end function

private subroutine inserisci_riga ();//
st_esito kst_esito
st_tab_armo kst_tab_armo 


	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then

		kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_meca")
		kst_tab_armo.num_int = tab_1.tabpage_1.dw_1.getitemnumber( 1, "num_int")
		kst_tab_armo.data_int = tab_1.tabpage_1.dw_1.getitemdate( 1, "meca_data_int")

		try
			
			dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita_inserimento)
			
		catch (uo_exception kuo_exception )
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_not_fnd then
				kuo_exception.messaggio_utente()
			end if
			
		end try
		
	end if
	
end subroutine

protected subroutine open_start_window ();
//
	ki_toolbar_window_presente=true
	
//--- disabilita la funzione di Inserisci dopo Aggiorna
	ki_fai_nuovo_dopo_update=false
	
//--- oggetto visibile in tutta la window
	kiuf_armo = create kuf_armo

//---imposta BMP
	tab_1.tabpage_3.picturename = "barcode.BMP"
//	tab_1.tabpage_3.picturename = kG_path_risorse + "\barcode.BMP"
	
end subroutine

public subroutine cambia_num_data ();//

//--- x disattivare il link sul campo num_int
dw_cambia_numero.ki_flag_modalita = kkg_flag_modalita_modifica

if dw_cambia_numero.rowcount( ) = 0 then
	dw_cambia_numero.insertrow(0)
	dw_cambia_numero.object.num_int[1] = tab_1.tabpage_1.dw_1.object.num_int[1]
	dw_cambia_numero.object.data_int[1] = tab_1.tabpage_1.dw_1.object.meca_data_int[1]
	dw_cambia_numero.object.id_meca[1] = tab_1.tabpage_1.dw_1.object.id_meca[1]
end if
dw_cambia_numero.x = this.width / 2 - dw_cambia_numero.width /2
dw_cambia_numero.y = this.height / 2 - dw_cambia_numero.height /2
dw_cambia_numero.visible = true


end subroutine

private subroutine u_genera_alcuni_dati_lotto ();//
int k_ok=0
st_tab_meca kst_tab_meca


	
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	try

//--- Modifica 
		k_ok = messagebox("Operazione di: "+trim(kG_menu.m_strumenti.m_fin_gest_libero9.text), "L'operazione non è distruttiva ma aggiorna dati Lotto, proseguire?", &
							question!, yesno!, 2) 
		if k_ok = 1 then
//--- aggiorna lo stato del Riferimento
			kiuf_armo.set_data_fine_lav(kst_tab_meca)
			inizializza_lista()
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	end try




end subroutine

private subroutine u_genera_packing_list ();//
int k_ok=0, k_ctr
st_tab_meca kst_tab_meca
kuf_armo_inout kuf1_armo_inout
	
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	try

		autorizza_funzioni( )   // abilita le funzioni della window
		if ki_consenti_crea_packing_list then
		
			kuf1_armo_inout = create kuf_armo_inout

//--- Modifica 
			k_ok = messagebox("Operazione di: "+trim(kG_menu.m_strumenti.m_fin_gest_libero9.text), "L'operazione genera una Packing-List fittizia solo per uso interno, proseguire?", &
							question!, yesno!, 2) 
			if k_ok = 1 then
//--- crea un Packing-List Fittizio 
				if kuf1_armo_inout.crea_wm_pklist_fittizio(kst_tab_meca) then
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_ok )
					kguo_exception.setmessage( "Generata la Packing-List " + string(kst_tab_meca.id_wm_pklist) + " " )
				else
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
					kguo_exception.setmessage( "Non e' stato possibile generare una nuova Packing-List associata a questo Lotto! " )
				end if
				inizializza_lista()
				
				kguo_exception.messaggio_utente()
				
			end if
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		destroy kuf1_armo_inout
		autorizza_funzioni( )   // abilita le funzioni della window
		attiva_tasti( )
		
	end try




end subroutine

public subroutine autorizza_funzioni ();//
//------------------------------------------------------------------------
//---
//--- Attiva/Disattiva le funzioni di questa windows
//---
//------------------------------------------------------------------------
//
pointer kpointer_orig
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
st_open_w kst_open_w
kuf_armo_inout kuf1_armo_inout
kuf_sicurezza kuf1_sicurezza



kpointer_orig = setpointer(hourglass!)


//--- forzatura Stampa dell'attestato consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_cancellazione then
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
		kst_esito_armo=kiuf_armo.consenti_forza_stampa_attestato(kst_tab_meca)
		if kst_esito_armo.esito <> kkg_esito_ok then
			ki_consenti_forza_stampa_attestato = false
		else
			ki_consenti_forza_stampa_attestato = true
		end if
	else
		ki_consenti_forza_stampa_attestato = false
	end if

//--- Autorizzazione Stampa dell'attestato Farmaceutico consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_cancellazione then
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
		kst_esito_armo=kiuf_armo.consenti_aut_stampa_attestato_farma(kst_tab_meca)
		if kst_esito_armo.esito <> kkg_esito_ok then
			ki_consenti_aut_stampa_attestato_farma = false
		else
			ki_consenti_aut_stampa_attestato_farma = true
		end if
	else
		ki_consenti_aut_stampa_attestato_farma = false
	end if

//--- Autorizzazione Stampa dell'attestato Alimentare consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_cancellazione then
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
		kst_esito_armo=kiuf_armo.consenti_aut_stampa_attestato_alimentare(kst_tab_meca)
		if kst_esito_armo.esito <> kkg_esito_ok then
			ki_consenti_aut_stampa_attestato_aliment = false
		else
			ki_consenti_aut_stampa_attestato_aliment = true
		end if
	else
		ki_consenti_aut_stampa_attestato_aliment = false
	end if

//--- Autorizzazione Blocco/Sblocco Riferimento Non-Conforme consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_cancellazione then
		
		try 
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
			if kiuf_armo.consenti_sblocco_meca_non_conforme(kst_tab_meca) then
				ki_consenti_sblocco_rif_incompleto = true
			else
				ki_consenti_sblocco_rif_incompleto = false
			end if
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		end try
	else
		ki_consenti_sblocco_rif_incompleto = false
	end if

//--- Autorizzazione Inserimento Riga consentita?
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_visualizzazione &
	   and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_cancellazione then

		kst_open_w.flag_modalita = kkg_flag_modalita_inserimento
		kst_open_w.id_programma =  kiuf_armo.get_id_programma(kst_open_w.flag_modalita) //kkg_id_programma_riferimenti
		kuf1_sicurezza = create kuf_sicurezza
		ki_consenti_modalita_inserimento = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		destroy kuf1_sicurezza
	else
		ki_consenti_modalita_inserimento = false
	end if

//--- Autorizza la creazione di un nuovo Packing-list
	try 

		kuf1_armo_inout = create kuf_armo_inout
		ki_consenti_crea_packing_list = false
			
		if kuf1_armo_inout.if_autorizza_crea_wm_pklist_fittizio() then
		
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
			if kuf1_armo_inout.if_crea_pkl_interna(kst_tab_meca) then
				ki_consenti_crea_packing_list = true
			end if
			
		end if
	catch (uo_exception kuo1_exception)

	finally
		destroy kuf1_armo_inout
		
	end try
	
	setpointer(kpointer_orig)
	
	

end subroutine

private subroutine u_accoppia_dosimetro ();//
kuf_menu_window kuf1_menu_window 
kuf_meca_dosim_barcode kuf1_meca_dosim_barcode
st_open_w k_st_open_w
st_tab_meca kst_tab_meca
	
	

	try

		kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
		
		if kst_tab_meca.id > 0 then
			
			kuf1_meca_dosim_barcode = create kuf_meca_dosim_barcode
			kuf1_menu_window = create kuf_menu_window
			
			
			K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
			K_st_open_w.id_programma = kuf1_meca_dosim_barcode.get_id_programma(kkg_flag_modalita_stampa)
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
			K_st_open_w.flag_leggi_dw = " "
			K_st_open_w.key1 = string(kst_tab_meca.id)
			K_st_open_w.key2 = " "
			K_st_open_w.key3 = " "
			K_st_open_w.key4 = " "
			K_st_open_w.key12_any = " " //--- eventuale struttura array st_meca_dosim_barcode_ddt[]
			K_st_open_w.flag_where = " "
			
			kuf1_menu_window.open_w_tabelle(k_st_open_w)
			
		else
			kGuo_exception.inizializza( )
			kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessun Lotto indicato")
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		destroy kuf1_meca_dosim_barcode
		destroy kuf1_menu_window
		
	end try









end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
string k_codice_attuale, k_codice_prec
st_tab_armo kst_tab_armo
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_4.st_4_retrieve.text) then
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
else
	k_codice_prec = string(kst_tab_armo.id_meca)
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_4.dw_4.retrieve(kst_tab_armo.id_meca)  

end if				
				

attiva_tasti()
//if tab_1.tabpage_4.dw_4.rowcount() = 0 then
//	tab_1.tabpage_4.dw_4.insertrow(0) 
//end if


tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

on w_meca_1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_armo)
destroy(this.dw_cambia_numero)
end on

event u_ricevi_da_elenco(st_open_w kst_open_w);call super::u_ricevi_da_elenco;////
////
//int k_rc
//long k_num_int, k_riga
//date k_data_int
//window k_window
//st_esito kst_esito
//st_tab_sr_prof_utenti kst_tab_sr_prof_utenti 
//kuf_menu_window kuf1_menu_window 
//kuf_sicurezza kuf1_sicurezza
//
//
//
//
//if isvalid(kst_open_w) then
//
////--- Dalla finestra di Elenco Valori
//	if kst_open_w.id_programma = "elenco" then
//	
////--- Se dalla w di elenco doppio-click		
// 		if kst_open_w.key2 = ki_dw_lista_utenti and long(kst_open_w.key3) > 0 then
//		
//			kdsi_elenco = kst_open_w.key12_any 
//		
//			if kdsi_elenco.rowcount() > 0 then
//				
//				kst_tab_sr_prof_utenti.id_utenti = &
//			      tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id")
//				kst_tab_sr_prof_utenti.id_profili  = &
//  		      	kdsi_elenco.getitemnumber(long(kst_open_w.key3), "id")
//
//				if kst_tab_sr_prof_utenti.id_utenti > 0 then
//					
//					kuf1_sicurezza = create kuf_sicurezza
//					kst_esito = kuf1_sicurezza.tb_insert_sr_prof_utenti (kst_tab_sr_prof_utenti)
//					destroy kuf1_sicurezza
//					
////--- torna a rileggere la lista					
//					inizializza_lista()
//					
//					if kst_esito.esito <> "0" then
//						messagebox("Operazione non riuscita", &
//									  + trim(kst_esito.sqlerrtext), &
//									  StopSign!&
//									 )   
//					end if
//					
//				end if
//							
//			end if
//		end if
//
//	end if
//
//end if
////


end event

on w_meca_1.create
int iCurrent
call super::create
this.dw_armo=create dw_armo
this.dw_cambia_numero=create dw_cambia_numero
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_armo
this.Control[iCurrent+2]=this.dw_cambia_numero
end on

event close;call super::close;//
if isvalid(kiuf_armo) then destroy 	kiuf_armo


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_meca_1
integer x = 101
integer y = 1148
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_meca_1
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_meca_1
integer x = 1618
integer y = 1224
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_meca_1
end type

type st_stampa from w_g_tab_3`st_stampa within w_meca_1
integer x = 507
integer y = 1152
end type

type dw_trova from w_g_tab_3`dw_trova within w_meca_1
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_meca_1
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_meca_1
end type

event cb_modifica::clicked;call super::clicked;//=== 
//=== 
//===
long k_riga=0
st_esito kst_esito
st_tab_armo kst_tab_armo


choose case tab_1.selectedtab 
	case 1 
	case 2  
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then

			kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo")
			
			try
				
				dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita_modifica)
				
			catch (uo_exception kuo_exception )
				kst_esito = kuo_exception.get_st_esito()
				if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_not_fnd then
					kuo_exception.messaggio_utente()
				end if
				
			end try
				
		end if
		
		
end choose	

return 0
end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_meca_1
end type

event cb_aggiorna::clicked;//
boolean k_inserisci

	k_inserisci = cb_inserisci.enabled
	
	cb_inserisci.enabled = false
	Super::EVENT Clicked()	 
	
	cb_inserisci.enabled = k_inserisci

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_meca_1
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_meca_1
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_meca_1
boolean visible = true
integer x = 0
integer y = 0
integer width = 1573
integer height = 1184
long backcolor = 67108864
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 1536
integer height = 1056
long backcolor = 67108864
string text = " Lotto"
long tabbackcolor = 67108864
string picturename = "BrowseObject!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer x = 23
integer y = 24
integer width = 1426
integer height = 992
string dataobject = "d_meca_1"
boolean hsplitscroll = false
end type

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


string nome = ' '
nome=dwo.name
if left(dwo.name, 2) = "b_" then

//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	choose case dwo.name
		case "b_meca"
			if this.object.num_int[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_meca_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.id_meca[this.getrow()])
				kst_open_w.key1 = "Riferimento "  + string(this.object.num_int[this.getrow()]) 
			end if
		case "b_contratti"
			if this.object.meca_contratto[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_contratti" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				kuf1_utility = create kuf_utility
				kuf1_utility.u_ds_toglie_ddw(1, kdsi_elenco_output)
				destroy kuf1_utility
				k_rc = kdsi_elenco_output.retrieve(this.object.meca_contratto[this.getrow()])
				kst_open_w.key1 = "Contratto " + string(this.object.meca_contratto[this.getrow()]) 
			end if
		case "b_sc_cf"
			if len(trim(this.object.contratti_sc_cf[this.getrow()])) > 0 then
				kdsi_elenco_output.dataobject = "d_sc_cf" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				kuf1_utility = create kuf_utility
				kuf1_utility.u_ds_toglie_ddw(1, kdsi_elenco_output)
				destroy kuf1_utility
				k_rc = kdsi_elenco_output.retrieve(this.object.contratti_sc_cf[this.getrow()])
				kst_open_w.key1 = "Capitolato SC-CF " + string(this.object.contratti_sc_cf[this.getrow()]) 
			end if
		case "b_clie_1"
			if this.object.meca_clie_1[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.meca_clie_1[this.getrow()])
				kst_open_w.key1 = "Mandante " + string(this.object.clienti_rag_soc_10[this.getrow()]) 
			end if
		case "b_clie_2"
			if this.object.certif_clie_2[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.certif_clie_2[this.getrow()])
				kst_open_w.key1 = "Ricevente " + string(this.object.clienti_rag_soc_10_1[this.getrow()]) 
			end if
		case "b_clie_3"
			if this.object.meca_clie_3[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.meca_clie_3[this.getrow()])
				kst_open_w.key1 = "Cliente " + string(this.object.clienti_rag_soc_10_2[this.getrow()]) 
			end if
	end choose


	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kuf1_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = "elenco"
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = "el"
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if
end if

//
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 1536
integer height = 1056
long backcolor = 67108864
string text = " righe "
long tabbackcolor = 67108864
string picturename = "DataWindow5!"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 9
integer y = 28
boolean enabled = true
string dataobject = "d_armo_x_meca_1"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 1536
integer height = 1056
string text = " Barcode"
string picturename = "C:\GAMMARAD\PB_GMMRD11\ICONE\barcode.BMP"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_barcode_l_2"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 1536
integer height = 1056
string text = "Voci"
string picturename = "IncrementalBuildTarget!"
string powertiptext = "Ulteriori voci di costo caricate dal Magazzino"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_prezzi_v_x_id_meca"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 1536
integer height = 1056
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 1536
integer height = 1056
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 1536
integer height = 1056
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 1536
integer height = 1056
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 1536
integer height = 1056
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type dw_armo from uo_d_std_1 within w_meca_1
event ue_inizializza ( readonly st_tab_armo kst_tab_armo,  string k_flag_modalita ) throws uo_exception
event ue_nuovo ( st_tab_armo kst_tab_armo )
event ue_aggiorna ( ) throws uo_exception
event type integer ue_dati_modif ( )
integer x = 1591
integer width = 2757
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "armo "
string dataobject = "d_meca_1_armo_speciali"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Form!"
boolean hsplitscroll = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event ue_inizializza(readonly st_tab_armo kst_tab_armo, string k_flag_modalita);//======================================================================
//=== Inizializzazione della DWindows
//=== operazioni iniziali
//======================================================================
//
int k_rc 
st_tab_listino kst_tab_listino
st_esito kst_esito
st_open_w kst_open_w
kuf_utility kuf1_utility
datawindowchild  kdwc_1
datawindow kdw_this
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kdw_this = this

kst_esito.esito = kkg_esito_ok


k_rc = this.event ue_dati_modif()
	
//--- OK continuo con le operazioni	
if k_rc = 0 then 


//--- controlla se utente autorizzato alla funzione richiesta
	kst_open_w = ki_st_open_w
	kst_open_w.flag_modalita = k_flag_modalita
	if sicurezza(kst_open_w) then
		
	//--- Se inserimento.... 
		if k_flag_modalita = kkg_flag_modalita_inserimento then
			this.event ue_nuovo (kst_tab_armo)
		else
	//--- Se NO inserimento.... 
			k_rc = this.retrieve( kst_tab_armo.id_armo ) 
			
			choose case k_rc
	
				case is < 0				
	//--- chiama l'evento per chiudere la dw
					this.event ue_visibile (false)
					kst_esito.esito = kkg_esito_db_ko
					
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					kuo_exception.setmessage( "Operazione fallita~n~rErrore ("+  string(k_rc) &
									 +")durante lettura Riga Lotto, id: " + + trim(string(kst_tab_armo.id_armo)) )
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
					throw kuo_exception
	
				case 0
		
					this.reset()
					attiva_tasti()
	
	//--- chiama l'evento per chiudere la dw
					this.event ue_visibile (false)
					kst_esito.esito = kkg_esito_not_fnd
					
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					kuo_exception.setmessage( "Operazione fallita~n~rId riga Lotto non Trovato: " + trim(string(kst_tab_armo.id_armo)) )
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
					throw kuo_exception
				
				case is > 0		
	
					attiva_tasti()
			
			end choose
	
		end if
	
		if k_flag_modalita = kkg_flag_modalita_inserimento then
			this.setcolumn("art")
			this.setfocus()
		else
			if k_flag_modalita = kkg_flag_modalita_modifica then
				this.setcolumn("art")
				this.setfocus()
			end if
		end if
		
	
	//--- Se Modifica...
		if k_flag_modalita = kkg_flag_modalita_modifica and this.getrow() > 0 then
	
			this.setredraw(false)
	
			 kst_tab_armo.art = this.getitemstring(1, "art")
		
	//--- Attivo dwc archivio LISTINO
			k_rc = this.getchild("art", kdwc_1)
			if kdwc_1.rowcount() < 2 then
				k_rc = kdwc_1.settransobject(sqlca)
				k_rc = kdwc_1.retrieve()
				kdwc_1.insertrow(1)
			end if
			
		end if
		
	//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if k_flag_modalita <> kkg_flag_modalita_inserimento and k_flag_modalita <> kkg_flag_modalita_modifica then
		
			kuf1_utility.u_proteggi_dw("1", 0, kdw_this)
	
			this.modify( "b_ok.visible = '0' ")
	
		else		
			
	//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility.u_proteggi_dw("0", 0, kdw_this)
	
		end if
		destroy kuf1_utility
		
		
		this.setredraw(true)
		
	
	//--- chiama l'evento per chiudere la dw
		this.event ue_visibile (true)
	
	end if
end if

end event

event ue_nuovo(st_tab_armo kst_tab_armo);//
//--- nuovo record
//
kuf_listino kuf1_listino



	this.reset()
	this.insertrow( 0)
	this.setitem( 1, "id_meca", kst_tab_armo.id_meca)
	this.setitem( 1, "num_int", kst_tab_armo.num_int)
	this.setitem( 1, "data_int", kst_tab_armo.data_int)
	this.setitem( 1, "id_armo", 0)
	this.setitem( 1, "colli_2", 1)
	this.setitem( 1, "magazzino", kuf1_listino.kki_tipo_magazzino_nessuno )
	this.setitem( 1, "campione", kuf1_listino.kki_campione_no )
	
	this.SetItemStatus( 1, 0, Primary!, NotModified!)
	
	this.event ue_visibile(true)


//post attiva_tasti()





end event

event ue_aggiorna();//
//---   aggiorna dati
//
st_tab_armo kst_tab_armo
st_esito kst_esito
uo_exception kuo_exception


if this.dati_modificati() then
	
	kst_tab_armo.id_meca = this.getitemnumber(1, "id_meca")
	kst_tab_armo.id_armo = this.getitemnumber(1, "id_armo")
	kst_tab_armo.num_int = this.getitemnumber(1, "num_int")
	kst_tab_armo.data_int = this.getitemdate(1, "data_int")
	kst_tab_armo.art = this.getitemstring(1, "art")
	kst_tab_armo.id_listino = this.getitemnumber( 1, "id_listino")
	kst_tab_armo.colli_2 = this.getitemnumber( 1, "colli_2")
	kst_tab_armo.magazzino = this.getitemnumber( 1, "magazzino")
	kst_tab_armo.campione = this.getitemstring( 1, "campione")
	kst_tab_armo.note_1 = this.getitemstring( 1, "note_1")
	kst_tab_armo.note_2 = this.getitemstring( 1, "note_2")
	kst_tab_armo.note_3 = this.getitemstring( 1, "note_3")
	
	this.modify( "art_t.Color='" + string(kk_colore_nero) +"'" )
	this.modify( "colli_2_t.Color='" + string(kk_colore_nero) +"'" )
	
	
	if kst_tab_armo.colli_2 > 0 and kst_tab_armo.id_listino > 0 then
		
		kst_tab_armo.colli_1 = kst_tab_armo.colli_2 
		
	//--- aggiorna RIGA-LOTTO	
		kst_esito = kiuf_armo.tb_update_armo(kst_tab_armo)
		if kst_esito.esito = kkg_esito_ok then
			
	//		this.ResetUpdate ( ) 
			this.Reset ( ) 
	//--- chiama l'evento per nascondere la dw
			this.event ue_visibile (false)
			tab_1.selectedtab = 2
			smista_funz(kkg_flag_richiesta_refresh)
	
		else
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_db_ko )
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
			
		end if
	
	else
		if kst_tab_armo.colli_2 = 0 or isnull( kst_tab_armo.colli_2) then
			this.modify( "colli_2_t.Color='" + string(kk_colore_rosso) +"'" )
		end if
		if kst_tab_armo.id_listino = 0 or isnull( kst_tab_armo.id_listino)  then
			this.modify( "art_t.Color='" + string(kk_colore_rosso) +"'" )
		end if
		
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_dati_insufficienti )
		kuo_exception.setmessage( "Controlla i valori dove vedi le voci in 'rosso' ")
		throw kuo_exception
			
		
	end if
end if

end event

event type integer ue_dati_modif();//
int k_errore = 0
st_tab_armo kst_tab_armo_1



//--- C'era gia' una riga da aggiornare...
	if this.rowcount( ) > 0 then
		
		kst_tab_armo_1.art = this.getitemstring(1, "art") 
		if trim(kst_tab_armo_1.art) <> "" then  
		
			if this.dati_modificati( ) then
		
				if ki_esponi_msg_dati_modificati then 
					k_errore = messagebox("Aggiorna Riga Lotto", "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
										question!, yesnocancel!, 1) 
				else
					k_errore = 2  // nessuna operazione
				end if
			
			
			end if
			
		end if
	
		if k_errore = 1 then //Fare gli aggiornamenti
		
			try 
				this.event ue_aggiorna( )
				
				k_errore = 0
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente( )
				k_errore = 2
				
			end try
				
		else
		
			if k_errore = 2 then //Aggiornamento non richiesto
				k_errore = 0
			end if
		
		end if
	end if

return k_errore

end event

event constructor;call super::constructor;//
this.width = 2900
this.height = 1020

	
this.settransobject ( sqlca )

end event

event ue_visibile;call super::ue_visibile;//
//--- evento "di entrata" ovvero scatenato quando viene "chiamata" questa dw
//
datawindowchild kdwc_1
st_tab_armo kst_tab_armo

if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	if k_visibile then
	
		this.x = (parent.width - this.width) / 2
		this.y = (parent.height - this.height ) / 3
		
		kst_tab_armo.id_armo = this.getitemnumber( 1, "id_armo")
		kst_tab_armo.num_int = this.getitemnumber( 1, "num_int")
		kst_tab_armo.data_int = this.getitemdate( 1, "data_int")
		
		this.title = " Trattamenti Speciali  Lotto: " + string(kst_tab_armo.num_int) + " / " + string(kst_tab_armo.data_int, "yyyy") + "  (" + string(kst_tab_armo.id_armo) + ") " 
	
	end if
	
	
	this.visible = k_visibile
else
	
	this.visible = false
end if
end event

event itemchanged;call super::itemchanged;//
string k_codice
long k_riga, k_rc, k_errore
st_esito kst_esito
datawindowchild kdwc_x

choose case 	upper(dwo.name)


	case "ART" 

	   k_codice = Trim(data)
		if isnull(k_codice) = false and Len(trim(k_codice)) > 0 then
		
			k_rc = this.getchild("art", kdwc_x)
			k_riga = kdwc_x.find("cod_art=~""+(k_codice)+"~"",0,kdwc_x.rowcount())
			if k_riga <= 0 or isnull(k_riga) then
				k_errore = 1 // rigetta il valore e non passa il fuoco
				k_rc=this.setitem(row, "art", k_codice)
				k_rc=this.setitem(row, "prodotti_des", "NON TROVATO")
				k_rc = this.setitem(row, "id_listino", 0)
			else
//				k_errore = 2
				k_rc=this.setitem(row, "art", kdwc_x.getitemstring(k_riga, "cod_art"))
				k_rc = this.setitem(row, "prodotti_des", kdwc_x.getitemstring(k_riga, "prodotti_des"))
				k_rc = this.setitem(row, "id_listino", kdwc_x.getitemnumber( 1, "id_listino"))
			end if
		else
			k_rc=this.setitem(row, "art", "")
			k_rc=this.setitem(row, "prodotti_des", "")
			k_rc = this.setitem(row, "id_listino", 0)
		end if

//


end choose 



return k_errore
	
end event

event clicked;call super::clicked;//
string k_errore
int k_rc
kuf_listino kuf1_listino
kuf_utility kuf1_utility
st_tab_listino kst_tab_listino
st_tab_cond_fatt kst_tab_cond_fatt
st_esito kst_esito
st_open_w kst_open_w 
datawindowchild kdwc_articoli, kdwc_articoli_des

pointer kp_oldpointer  // Declares a pointer variable


	kp_oldpointer = SetPointer(HourGlass!)


choose case dwo.name

	case "b_ritorna"
		
//--- chiama l'evento per nascondere la dw
		this.event ue_visibile (false)
		
		
	case "b_ok"
		
		try 
//--- chiama l'evento per aggiornare la dw
			this.event ue_aggiorna( )
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente( )

		end try

end choose


SetPointer(kp_oldpointer)

end event

type dw_cambia_numero from uo_d_std_1 within w_meca_1
integer x = 55
integer y = 580
integer width = 1893
integer height = 604
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Cambia il Numero/Data del Lotto "
string dataobject = "d_meca_num_data"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_cerca = false
end type

event buttonclicked;call super::buttonclicked;//
st_tab_meca kst_tab_meca
pointer kpointer_1

this.accepttext( )
kst_tab_meca.num_int = this.object.num_int[1]
kst_tab_meca.data_int = this.object.data_int[1]

try 

//--- se cambio il numero lotto rispetto all'originale, controllo sull'archivio
	if kist_tab_meca_orig.num_int <> kst_tab_meca.num_int  then 
		
		kpointer_1 = setpointer( Hourglass!)

		if kiuf_armo.if_esiste(kst_tab_meca) then
			
			this.object.id_meca[1] = kst_tab_meca.id
			
			setpointer( kpointer_1)
			
			messagebox("Modifica LOTTO", "Numero già caricato, modifica NON permessa (vedi zoom su ID)", stopsign!)
		
		else
			
			setpointer( kpointer_1)
			
			tab_1.tabpage_1.dw_1.object.num_int[1] = kst_tab_meca.num_int 
			tab_1.tabpage_1.dw_1.object.meca_data_int[1] = kst_tab_meca.data_int
			
			attiva_tasti()
			
			this.visible = false
			
		end if
	else

		this.visible = false
		
		if this.object.num_int[1] <> tab_1.tabpage_1.dw_1.object.num_int[1] &
				or this.object.data_int[1] <> tab_1.tabpage_1.dw_1.object.meca_data_int[1] then
			
			tab_1.tabpage_1.dw_1.object.num_int[1] = kst_tab_meca.num_int 
			tab_1.tabpage_1.dw_1.object.meca_data_int[1] = kst_tab_meca.data_int
			
			attiva_tasti()
			
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end event

