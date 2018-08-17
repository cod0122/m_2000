$PBExportHeader$w_meca_1.srw
forward
global type w_meca_1 from w_g_tab_3
end type
type dw_armo from uo_d_std_1 within w_meca_1
end type
type dw_cambia_numero from uo_d_std_1 within w_meca_1
end type
type dw_cambia_aperto from uo_d_std_1 within w_meca_1
end type
end forward

global type w_meca_1 from w_g_tab_3
integer width = 1234
integer height = 1364
string title = "Lotto"
long backcolor = 67108864
boolean ki_toolbar_window_presente = true
dw_armo dw_armo
dw_cambia_numero dw_cambia_numero
dw_cambia_aperto dw_cambia_aperto
end type
global w_meca_1 w_meca_1

type variables
//
	kuf_armo kiuf_armo

//	private datastore kdsi_elenco 
	private string ki_path_risorse 
	private boolean ki_consenti_modalita_inserimento=false
	private boolean ki_consenti_crea_packing_list=false
	private boolean ki_consenti_modifica=false

	private string ki_meca_aperto  

//--- flag x segnalare se fare la modifica dati num/data lotto ma anche registra la colonna APERTO (APERTO/RIAPERTO/CHIUSO/ANNULLATO...)
	private boolean kist_flag_cambia_numero_data=false
	private st_tab_meca kist_tab_meca_orig
	
	
//--- Autorizzazioni
	private boolean ki_autorizza_listino_view = false
	private boolean ki_autorizza_listino_modfiica = false

//--- x fare il drag&drop da windows
	private kuf_file_dragdrop kiuf_file_dragdrop

//--- Flag di E-ONE attivato: ovvero i barcode non sono più generati da M2000 
	private boolean ki_e1_enabled=false

	private string k_orig_meca_blk_descrizione=""
end variables

forward prototypes
protected subroutine inizializza_1 ()
protected function string check_dati ()
protected function integer cancella ()
protected function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string aggiorna ()
protected subroutine inizializza_2 () throws uo_exception
protected function integer visualizza ()
private subroutine inserisci_riga ()
protected subroutine open_start_window ()
private subroutine u_genera_alcuni_dati_lotto ()
private subroutine u_genera_packing_list ()
private subroutine u_accoppia_dosimetro ()
protected subroutine inizializza_3 () throws uo_exception
private subroutine u_carica_voci_costo ()
private subroutine u_scarica_colli ()
public subroutine autorizza_funzioni ()
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
protected function integer inserisci ()
private subroutine call_memo ()
private subroutine u_add_memo_link (string a_file[], integer a_file_nr)
public function long u_drop_file (integer a_k_tipo_drag, long a_handle)
private subroutine call_ddt ()
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
public subroutine u_cambia_num_data ()
public subroutine u_cambia_aperto ()
public subroutine u_aprichiudi_lotto (st_tab_meca kst_tab_meca)
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
long k_riga
string k_codice_prec
st_tab_armo kst_tab_armo
	

k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = ""
end if

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = string(kst_tab_armo.id_meca)

if tab_1.tabpage_2.st_2_retrieve.text <> k_codice_prec then

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
long k_nr_righe, k_riga, k_nr_errori=0
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_armo kst_tab_armo


	kst_tab_armo.colli_2 = 0
	kst_tab_armo_prezzi.item_dafatt = 0
	kst_tab_armo_prezzi.item_fatt = 0

//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_5.dw_5.rowcount()
	k_riga = tab_1.tabpage_5.dw_5.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_colli_2") > 0 then
			kst_tab_armo.colli_2 += tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_colli_2")
		end if
		if tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_prezzi_item_dafatt") > 0  then
			kst_tab_armo_prezzi.item_dafatt += tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_prezzi_item_dafatt")
		end if
		if tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_prezzi_item_fatt") > 0  then
			kst_tab_armo_prezzi.item_fatt += tab_1.tabpage_5.dw_5.getitemnumber ( k_riga, "armo_prezzi_item_fatt")
		end if

		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
			if kst_tab_armo.colli_2 < (kst_tab_armo_prezzi.item_dafatt + kst_tab_armo_prezzi.item_fatt) then
				k_return = "Scheda " + tab_1.tabpage_5.text + " alla riga " + &
				string(k_riga, "#####") + " Colli totali entrati " + string(kst_tab_armo.colli_2) + " minori delle q.ta' in/da fatturare ~n~r" 
				k_errore = "4"
				k_nr_errori++
			end if

		end if
		k_riga++

		k_riga = tab_1.tabpage_5.dw_5.getnextmodified(k_riga, primary!)

	loop
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
st_tab_memo kst_tab_memo
kuf_memo kuf1_memo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//=== 
choose case ki_tab_1_index_new 
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
		
	case 6
		k_record = " Allegati "
		k_riga = tab_1.tabpage_6.dw_6.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_6.dw_6.getitemstatus(k_riga, 0, primary!) <> new! and &
						tab_1.tabpage_6.dw_6.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				kst_tab_memo.id_memo = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "id_memo")
				kst_tab_memo.titolo = tab_1.tabpage_6.dw_6.getitemstring(k_riga, "memo_titolo")
				k_record_1 = &
					"Sei sicuro di voler eliminare l'Allegato  " + string(kst_tab_memo.id_memo) + "~n~r" &
					+ "titolo " + trim(kst_tab_memo.titolo) + " ?"
				k_key = trim(string(tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "id_meca_memo")))
			else
				tab_1.tabpage_6.dw_6.deleterow(k_riga)
			end if
		end if
		
end choose	



//=== Se righe in lista
if k_riga > 0 and len(trim(k_key)) > 0 then

	try
		
//=== Richiesta di conferma della eliminazione del rek
		if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
	 
	//=== Cancella la riga dal data windows di lista
			choose case ki_tab_1_index_new 
				case 1 
					kst_tab_meca.st_tab_g_0.esegui_commit = "N"
					kst_esito = kiuf_armo.tb_delete_riferimento(kst_tab_meca) 
				case 2
					kst_tab_armo.st_tab_g_0.esegui_commit = "N"
					kiuf_armo.tb_delete_riga(kst_tab_armo) 
				case 6 
					kuf1_memo = create kuf_memo
					kst_tab_memo.id_memo = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "id_memo")
					kst_tab_memo.st_tab_g_0.esegui_commit = "N"
					kuf1_memo.tb_delete(kst_tab_memo) 
			end choose	
			if kst_esito.esito = "0" then
	
				kguo_sqlca_db_magazzino.db_commit( )
	
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
					case 6
						tab_1.tabpage_6.dw_6.deleterow(k_riga)
				end choose	
	
			else
				k_return = 1
				kguo_sqlca_db_magazzino.db_rollback( )
				messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							  trim(kst_esito.SQLErrText) ) 	
	
			end if
	
		else
			messagebox("Elimina " + k_record,  "Operazione Annullata !!")
			k_return = 2
		end if
	
		
	catch(uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
	
	finally
		attiva_tasti()
	
	
	end try	

end if




choose case ki_tab_1_index_new 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
	case 6
		tab_1.tabpage_6.dw_6.setfocus()
		tab_1.tabpage_6.dw_6.setcolumn(1)
end choose	


return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return
string k_scelta
string  k_key
int k_errore = 0
int k_err_ins, k_rc
pointer kpointer_orig
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
st_open_w kst_open_w
st_tab_e1_asn kst_tab_e1_asn, kst1_tab_e1_asn[]
kuf_armo_inout kuf1_armo_inout
kuf_utility kuf1_utility
kuf_sicurezza kuf1_sicurezza
//kuf_e1_asn kuf1_e1_asn



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
					"(Riferimento cercato: " + trim(k_key) + ")~n~r" )
				//cb_ritorna.postevent(clicked!)
				k_return = ki_UsitaImmediata
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
//				attiva_tasti()

				if k_scelta <> kkg_flag_modalita.inserimento then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il Riferimento non e' in Archivio ~n~r" + &
						"(Numero cercato: " + trim(k_key) + ")~n~r" )
//					cb_ritorna.postevent(clicked!)
					k_return = ki_UsitaImmediata
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta =  kkg_flag_modalita.inserimento then
					cb_inserisci.postevent(clicked!)
				end if
				
				tab_1.tabpage_1.dw_1.setrow(1)
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("meca_cert_forza_stampa")

//--- salva campi come in origine
				kist_tab_meca_orig.num_int = tab_1.tabpage_1.dw_1.object.num_int[1]
				kist_tab_meca_orig.data_int = tab_1.tabpage_1.dw_1.object.meca_data_int[1]
				kist_tab_meca_orig.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
				kist_tab_meca_orig.aperto = tab_1.tabpage_1.dw_1.object.meca_aperto[1]

////--- Imposta lo STATO del ADN da E1
//				if ki_e1_enabled then
//					try
//						kuf1_e1_asn = create kuf_e1_asn
//						kst_tab_e1_asn.waapid = string(tab_1.tabpage_1.dw_1.object.id_meca[1])
//						kst_tab_e1_asn.wammcu = kkg.E1MCU
//						kst1_tab_e1_asn[1] = kst_tab_e1_asn
//						kuf1_e1_asn.u_get_stato(kst1_tab_e1_asn[])
//						kst_tab_e1_asn = kst1_tab_e1_asn[1]
//						tab_1.tabpage_1.dw_1.setitem(1, "wasrst", kst_tab_e1_asn.wasrst)
//					catch (uo_exception kuo_exception)
//						kuo_exception.messaggio_utente()
//					finally
//						if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn
//					end try
//				end if

//				attiva_tasti()
		end choose

	end if

//	kdwc_dw1.retrieve()

end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_1.dw_1))

//-- abilita le funzioni consentite x questa window 
	autorizza_funzioni( )

//--- esposizione o meno dei prezzi
	if ki_autorizza_listino_view then
		if tab_1.tabpage_5.dw_5.dataobject <> "d_armo_prezzi_l_x_id_meca_noprezzi" then
			tab_1.tabpage_5.dw_5.dataobject = "d_armo_prezzi_l_x_id_meca_noprezzi"
			tab_1.tabpage_5.dw_5.settransobject(kguo_sqlca_db_magazzino)
		end if
	else
		if tab_1.tabpage_5.dw_5.dataobject <> "d_armo_prezzi_l_x_id_meca" then
			tab_1.tabpage_5.dw_5.dataobject = "d_armo_prezzi_l_x_id_meca"
			tab_1.tabpage_5.dw_5.settransobject(kguo_sqlca_db_magazzino)
		end if
	end if

//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		ki_esci_dopo_cancella = true
		cb_cancella.postevent (clicked!)
//		cb_ritorna.postevent(clicked!)
		
	end if
end if

if k_return <> ki_UsitaImmediata then
	post attiva_tasti()
end if


return k_return


end function

protected subroutine attiva_menu ();//
string k_txt
st_tab_meca kst_tab_meca


	
//
//--- Attiva/Dis. Voci di menu personalizzate
//
//--- Disabilita chiudendo o riattiva aprendo il Lotto
	if not ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S'  then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Chiude/Annulla/Apre Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = ki_menu.m_strumenti.m_fin_gest_libero1.text
		
		choose case kist_tab_meca_orig.aperto
			case kiuf_armo.kki_meca_aperto_no &
				, kiuf_armo.kki_meca_aperto_annullato		
				k_txt = "Riapre"
			case else
				k_txt = "Chiude"
		end choose
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext = k_txt + ","+ ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemvisible = true
	end if

//--- Caricare nuove voci di costo al riferimento
	if not ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Aggiungi q.tà alla Voce "
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Carica voci di costo aggiuntive al Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext =  "Costi,"+ ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
	end if

//--- Scaricare colli manualmente del riferimento
	if not ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Scarico manuale colli "
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Scaricare manualmente colli dalle righe Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext =  "Scarica,"+ ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
	end if


//--- Rigenera alcuni dati del Lotto 		
	if not ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Allinea data di Fine Trattamento "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Allinea data in anomalia di Fine Trattamento su Barcode "
		if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <>  cb_aggiorna.enabled then
			ki_menu.m_strumenti.m_fin_gest_libero4.enabled =  cb_aggiorna.enabled
		end if
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext =  "Rigenera,"+ ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemvisible = false
	end if


//--- Carica/Modifica Riga "NO-DOSE"
	if not ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Aggiungi riga da non Trattare"
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Aggiungi riga Articolo da non Sterilizzare"
		if ki_menu.m_strumenti.m_fin_gest_libero5.enabled <> ki_consenti_modalita_inserimento then
			ki_menu.m_strumenti.m_fin_gest_libero5.enabled = ki_consenti_modalita_inserimento
		end if
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext =  "Aggiungi,"+ ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemvisible = true
	end if


//--- Associa Dosimetro
	if not ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Accoppia Dosimetro "
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp = "Accoppia Dosimetro "
		if ki_menu.m_strumenti.m_fin_gest_libero6.enabled <>  ki_consenti_modalita_inserimento then
			ki_menu.m_strumenti.m_fin_gest_libero6.enabled = ki_consenti_modalita_inserimento
		end if
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext =  "Accoppia,"+ ki_menu.m_strumenti.m_fin_gest_libero6.text
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemvisible = true
	end if


//--- Modifica numero/data LOTTO
	if not ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Data Lotto"
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Sistema Data del Lotto"
		if (tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_consenti_modalita_inserimento and kist_tab_meca_orig.num_int > 0 and NOT ki_menu.m_strumenti.m_fin_gest_libero7.enabled) &
				or ((tab_1.tabpage_1.dw_1.rowcount() = 0 or NOT ki_consenti_modalita_inserimento) and  ki_menu.m_strumenti.m_fin_gest_libero7.enabled) &
				then
			if tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_consenti_modalita_inserimento and kist_tab_meca_orig.num_int > 0 then
				ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
			else
				ki_menu.m_strumenti.m_fin_gest_libero8.enabled = false
			end if
		end if
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext =  "Data,"+ ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
	end if


//--- Genera PKLIST fittizia
	if not ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero9.text = "Genera Packing-List fittizia "
		ki_menu.m_strumenti.m_fin_gest_libero9.microhelp = "Genera Packing-List fittizia "
		if ki_menu.m_strumenti.m_fin_gest_libero9.enabled <> ki_consenti_crea_packing_list  then
			ki_menu.m_strumenti.m_fin_gest_libero9.enabled =  ki_consenti_crea_packing_list
		end if
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemtext =  "Pck-List,"+ ki_menu.m_strumenti.m_fin_gest_libero9.text
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemvisible = true
	end if

//--- Genera DDT
	if not ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemvisible or  ki_st_open_w.flag_primo_giro = 'S' then
		ki_menu.m_strumenti.m_fin_gest_libero10.text = "DDT di spedizione"
		ki_menu.m_strumenti.m_fin_gest_libero10.microhelp = "DDT di spedizione "
		ki_menu.m_strumenti.m_fin_gest_libero10.enabled =  true
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemtext =  "DDT,"+ ki_menu.m_strumenti.m_fin_gest_libero10.text
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemvisible = true
	end if

//--- cambia menu 
	choose case ki_tab_1_index_new //tab_1.selectedtab  
		case 1 
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled =  ki_consenti_modifica
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  false
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  false
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = this.cb_inserisci.enabled
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.text = "Nuovo Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.microhelp = "Carica nuovo Lotto (Riferimento)"
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.toolbaritemtext = "Nuovo," + ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
			ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled = this.cb_cancella.enabled
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Elimina definitivamente l'intero Lotto (Riferimento) "
			ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Cancella,"+ ki_menu.m_finestra.m_gestione.m_fin_elimina.text
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = this.cb_visualizza.enabled
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.text = "Visualizza Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.microhelp = "Visualizza Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.toolbaritemtext = "Visualizza," + ki_menu.m_finestra.m_gestione.m_fin_visualizza.text 
			ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled
			ki_menu.m_finestra.m_gestione.m_fin_modifica.text = "Modifica Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_modifica.microhelp = "Modifica Lotto (riga Riferimento)"
			ki_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemtext = "Modifica," + ki_menu.m_finestra.m_gestione.m_fin_modifica.text 
		case 2
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  true
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  true
			ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled = this.cb_cancella.enabled
			ki_menu.m_finestra.m_gestione.m_fin_elimina.text = "Elimina Riga Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_elimina.microhelp = "Elimina definitivamente la Riga Lotto (riga Riferimento) "
			ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemtext = "Cancella,"+ ki_menu.m_finestra.m_gestione.m_fin_inserimento.text
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = this.cb_visualizza.enabled
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.text = "Visualizza dettaglio Riga"
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.microhelp = "Visualizza in dettaglio la Riga Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.toolbaritemtext = "Visualizza," + ki_menu.m_finestra.m_gestione.m_fin_visualizza.text 
			ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled
			ki_menu.m_finestra.m_gestione.m_fin_modifica.text = "Modifica Riga Lotto"
			ki_menu.m_finestra.m_gestione.m_fin_modifica.microhelp = "Modifica Riga Lotto (riga Riferimento)"
			ki_menu.m_finestra.m_gestione.m_fin_modifica.toolbaritemtext = "Modifica," + ki_menu.m_finestra.m_gestione.m_fin_modifica.text 

		case 3
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  false
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  false
			ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled =  this.cb_cancella.enabled
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled =  this.cb_visualizza.enabled
			ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = this.cb_modifica.enabled

		case 4
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  false
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  false
			
		case 5 // MEMO
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  false
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  false
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = true 
			ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled = true // this.cb_cancella.enabled
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = true // this.cb_visualizza.enabled
			ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = true // this.cb_modifica.enabled
			
		case else
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled =  false
			ki_menu.m_strumenti.m_fin_gest_libero3.enabled =  false
			
	end choose	
		
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero9.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero10.visible = true
	
//	if ki_st_open_w.flag_primo_giro = 'S' then
		
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "lucch32.png"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "cert_aut_stampa.bmp"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "meca_incompleto.bmp"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "IncrementalBuildTarget!" //"formatdollar!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "EditObject!"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemname = "Regenerate5!"
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemname = "UnionReturn!"
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemname = "Insert!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemname = "CheckDiff!"
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemname = "Compile!"
		ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemname = "Deploy!"
//	end if


	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case left(k_par_in, 2) 

//--- Apre / Chiude Lotto
	case kkg_flag_richiesta.libero1
		u_cambia_aperto( )
		
//--- Aggiunge Voci di Costo alla Riga Lotto
	case kkg_flag_richiesta.libero2
		u_carica_voci_costo( )
		
//--- Scarica colli manualmente dalla Riga Lotto
	case kkg_flag_richiesta.libero3
		u_scarica_colli( )
		
//--- Rigenera alcuni dati del Riferimento
	case kkg_flag_richiesta.libero4
		u_genera_alcuni_dati_lotto()		
		
//--- Nuova riga Lotto
	case kkg_flag_richiesta.libero5
		inserisci_riga()
		
//--- Accoppia Dosimetro
	case kkg_flag_richiesta.libero6
		u_accoppia_dosimetro()
		
//--- Cambia numero data lotto
	case kkg_flag_richiesta.libero8
		u_cambia_num_data()
		
//--- Genera packing-list fittizia
	case kkg_flag_richiesta.libero9
		u_genera_packing_list( )
		
//--- DDT
	case kkg_flag_richiesta.libero10
		call_ddt()	
		
	
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

choose case tab_1.selectedtab 

	case 1 

		//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 or tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 then
		
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
		
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
		
		//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
				if kst_esito.esito <> kkg_esito.ok then
					k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
					
		//--- se tutto ok resetto il buffer di update
					tab_1.tabpage_1.dw_1.resetupdate()
				
				end if
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				
				k_return="1Fallito aggiornamento archivio '" &
							+ tab_1.tabpage_1.text + "' ~n~r" &
							+ string(kst_esito.sqlcode) + " = " + trim(kst_esito.sqlerrtext) + "' ~n~r" 
			end if
		end if
		
	case 5
		if tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 or tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0 then
			if tab_1.tabpage_5.dw_5.update() = 1 then
//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
				if kst_esito.esito <> kkg_esito.ok then
					k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
				else // Tutti i Dati Caricati in Archivio
					k_return ="0 "
//--- se tutto ok resetto il buffer di update
					tab_1.tabpage_5.dw_5.resetupdate()
				end if
			else
				kguo_sqlca_db_magazzino.db_rollback( )
				k_return="1Fallito aggiornamento archivio '" + tab_1.tabpage_5.text + "' ~n~r" + string(kst_esito.sqlcode) + " = " + trim(kst_esito.sqlerrtext) + "' ~n~r" 
			end if
		end if
		

end choose

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

protected function integer visualizza ();//=== 
//=== 
//===
long k_riga=0
st_esito kst_esito
st_tab_armo kst_tab_armo
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_memo kuf1_memo


try

	choose case tab_1.selectedtab 
			
		case 1 // lotto
//			kst_tab_g_0.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
//			kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
			
		case 2  // righe
			k_riga = tab_1.tabpage_2.dw_2.getrow()	
			if k_riga > 0 then
	
				kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo")
				
				dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita.visualizzazione)
					
			end if
		 

		case 6 // allegati
			kuf1_memo = create kuf_memo
			k_riga = tab_1.tabpage_6.dw_6.getrow()
			if k_riga > 0 then
			else
				if tab_1.tabpage_6.dw_6.rowcount() = 1 then
					k_riga = 1
				end if
			end if
			if k_riga > 0 then
				kst_memo.st_tab_memo.id_memo = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "id_memo")
				if kst_memo.st_tab_memo.id_memo > 0 then
					kuf1_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione )
				end if
			end if
			
	end choose
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd then
		kuo_exception.messaggio_utente()
	end if
	
end try

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
			
			dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita.inserimento)
			
		catch (uo_exception kuo_exception )
			kst_esito = kuo_exception.get_st_esito()
			if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd then
				kuo_exception.messaggio_utente()
			end if
			
		end try
		
	end if
	
end subroutine

protected subroutine open_start_window ();//


try
	
	ki_toolbar_window_presente=true
	
//--- disabilita la funzione di Inserisci dopo Aggiorna
	ki_fai_nuovo_dopo_update=false
	
//--- oggetto visibile in tutta la window
	kiuf_armo = create kuf_armo

	tab_1.tabpage_3.picturename = "Barcode.ICO"
	tab_1.tabpage_5.picturename = "carrello16.png"
	tab_1.tabpage_7.picturename = "e1Lotto.png"

//	kuf1_listino = create kuf_listino
//	ki_autorizza_listino_view = kuf1_listino.if_sicurezza(kkg_flag_modalita.visualizzazione)
//	ki_autorizza_listino_modfiica = kuf1_listino.if_sicurezza(kkg_flag_modalita.modifica)

//--- set se E1 attivato
	ki_e1_enabled = kguo_g.if_e1_enabled( )
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally 
end try
end subroutine

private subroutine u_genera_alcuni_dati_lotto ();//
int k_ok=0
st_tab_meca kst_tab_meca


	
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]

	try

//--- Modifica 
		k_ok = messagebox("Operazione di: "+trim(ki_menu.m_strumenti.m_fin_gest_libero4.text), "Operazione di aggiornamento dati Lotto, proseguire?", &
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
			k_ok = messagebox("Operazione di: "+trim(ki_menu.m_strumenti.m_fin_gest_libero9.text), "L'operazione genera una Packing-List fittizia solo per uso interno, proseguire?", &
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

private subroutine u_accoppia_dosimetro ();//
kuf_meca_dosim_barcode kuf1_meca_dosim_barcode
st_open_w k_st_open_w
st_tab_meca kst_tab_meca
	

	try

		kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
		
		if kst_tab_meca.id > 0 then
			
			kuf1_meca_dosim_barcode = create kuf_meca_dosim_barcode
			
			K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			K_st_open_w.key1 = string(kst_tab_meca.id)
			kuf1_meca_dosim_barcode.u_open(K_st_open_w)
			
		else
			kGuo_exception.inizializza( )
			kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessun Lotto indicato")
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		if isvalid(kuf1_meca_dosim_barcode) then destroy kuf1_meca_dosim_barcode
		
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

private subroutine u_carica_voci_costo ();//
//kuf_menu_window kuf1_menu_window 
kuf_armo_prezzi_v kuf1_armo_prezzi_v
st_open_w k_st_open_w
st_tab_armo_prezzi kst_tab_armo_prezzi	
	

try
	choose case tab_1.selectedtab 

		case 2
			if tab_1.tabpage_2.dw_2.getrow() > 0 then
				kst_tab_armo_prezzi.id_armo = tab_1.tabpage_2.dw_2.object.id_armo[tab_1.tabpage_2.dw_2.getrow()]
			end if
			
		case 5
			if tab_1.tabpage_5.dw_5.getrow() > 0 then
				kst_tab_armo_prezzi.id_armo = tab_1.tabpage_5.dw_5.object.id_armo[tab_1.tabpage_5.dw_5.getrow()]
				kst_tab_armo_prezzi.id_armo_prezzo = tab_1.tabpage_5.dw_5.object.id_armo_prezzo[tab_1.tabpage_5.dw_5.getrow()]
			end if
	end choose
	
	if kst_tab_armo_prezzi.id_armo > 0 then
		if isnull(kst_tab_armo_prezzi.id_armo_prezzo) then kst_tab_armo_prezzi.id_armo_prezzo = 0
		
		kuf1_armo_prezzi_v = create kuf_armo_prezzi_v
		//kuf1_menu_window = create kuf_menu_window
		
		
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.id_programma = kuf1_armo_prezzi_v.get_id_programma(K_st_open_w.flag_modalita)
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.key1 = string(kst_tab_armo_prezzi.id_armo)
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = string(kst_tab_armo_prezzi.id_armo_prezzo)
		K_st_open_w.key4 = " "
		K_st_open_w.key12_any = " " //--- eventuale struttura array st_armo_prezzi_v_ddt[]
		K_st_open_w.flag_where = " "
		
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		
	else
		kGuo_exception.inizializza( )
		kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessuna Riga Lotto selezionata")
	end if		

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	destroy kuf1_armo_prezzi_v
	//destroy kuf1_menu_window
	
end try









end subroutine

private subroutine u_scarica_colli ();//
//kuf_menu_window kuf1_menu_window 
kuf_armo_out kuf1_armo_out
st_open_w k_st_open_w
st_tab_armo kst_tab_armo
	
	

	try
		if tab_1.tabpage_2.dw_2.getrow() > 0 then
				
			kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.object.id_armo[tab_1.tabpage_2.dw_2.getrow()]
			
			if kst_tab_armo.id_armo > 0 then
				
				kuf1_armo_out = create kuf_armo_out
				//kuf1_menu_window = create kuf_menu_window
				
				
				K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
				K_st_open_w.id_programma = kuf1_armo_out.get_id_programma(K_st_open_w.flag_modalita)
				K_st_open_w.flag_primo_giro = "S"
				K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
				K_st_open_w.flag_leggi_dw = " "
				K_st_open_w.key1 = string(kst_tab_armo.id_armo)
				K_st_open_w.key2 = " "
				K_st_open_w.key3 = " "
				K_st_open_w.key4 = " "
				K_st_open_w.key12_any = " " //--- eventuale struttura array st_armo_out_ddt[]
				K_st_open_w.flag_where = " "
				
				kGuf_menu_window.open_w_tabelle(k_st_open_w)
				
			else
				kGuo_exception.inizializza( )
				kGuo_exception.messaggio_utente( "Operazione Interrotta", "Nessuna Riga Lotto selezionata")
			end if		
		else
			kGuo_exception.inizializza( )
			kGuo_exception.messaggio_utente( "Operazione Interrotta", "Selezionare una riga dall'elenco")
		end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	finally
		destroy kuf1_armo_out
		//destroy kuf1_menu_window
		
	end try









end subroutine

public subroutine autorizza_funzioni ();//
//------------------------------------------------------------------------
//---
//--- Attiva/Disattiva le funzioni di questa windows
//---
//------------------------------------------------------------------------
//
st_esito kst_esito, kst_esito_armo
st_tab_meca kst_tab_meca
kuf_armo_inout kuf1_armo_inout
kuf_listino kuf1_listino


try
	
	setpointer(kkg.pointer_attesa)

	try
//--- autorizzazioni Listino
		kuf1_listino = create kuf_listino
		ki_autorizza_listino_view = kuf1_listino.if_sicurezza(kkg_flag_modalita.visualizzazione)
		ki_autorizza_listino_modfiica = kuf1_listino.if_sicurezza(kkg_flag_modalita.modifica)
	catch (uo_exception kuo_exception)
		
	end try

	try
//--- Autorizzazione Inserimento Riga consentita?
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.cancellazione then
	
			ki_consenti_modalita_inserimento = kiuf_armo.if_sicurezza( kkg_flag_modalita.inserimento)
		else
			ki_consenti_modalita_inserimento = false
		end if
	catch (uo_exception kuo1_exception)
		
	end try

	try 

//--- Autorizza la creazione di un nuovo Packing-list
		kuf1_armo_inout = create kuf_armo_inout
		ki_consenti_crea_packing_list = false
			
		if kuf1_armo_inout.if_autorizza_crea_wm_pklist_fittizio() then
		
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_meca")
			if kuf1_armo_inout.if_crea_pkl_interna(kst_tab_meca) then
				ki_consenti_crea_packing_list = true
			end if
			
		end if

	catch (uo_exception kuo2_exception)
	
	end try
	
	try 
//-- Autorizza modifica
		ki_consenti_modifica = kiuf_armo.if_sicurezza(kkg_flag_modalita.modifica)

	catch (uo_exception kuo3_exception)
	
	end try

catch (uo_exception kuo4_exception)
		
finally	
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout
	setpointer(kkg.pointer_default)
	
end try

	
	

end subroutine

protected subroutine inizializza_4 () throws uo_exception;//
int k_rc=0
long k_riga
string k_codice_attuale, k_codice_prec
st_tab_armo kst_tab_armo
kuf_utility kuf1_utility	


k_riga = tab_1.tabpage_1.dw_1.getrow() 
	
kst_tab_armo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_5.st_5_retrieve.text) then
	k_codice_prec = tab_1.tabpage_5.st_5_retrieve.text
else
	k_codice_prec = string(kst_tab_armo.id_meca)
end if

k_codice_attuale = "*"

//--- protez campi
kuf1_utility = create kuf_utility
kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_5.st_5_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_5.dw_5.retrieve(kst_tab_armo.id_meca)  
	if k_rc > 0 then tab_1.tabpage_5.dw_5.setrow(1)
	

end if				
				

attiva_tasti()


tab_1.tabpage_5.dw_5.setfocus()
	
	

end subroutine

protected subroutine inizializza_5 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_id_cliente
string k_scelta, k_codice_prec
int k_rc

boolean k_return
kuf_memo kuf1_memo



//kuf1_memo = create kuf_memo
//k_return = kuf1_memo.if_sicurezza( kkg_flag_modalita.elenco)
//
//if not k_return then
//
//	tab_1.tabpage_6.dw_6.dataobject = "d_funz_no_aut"
//	tab_1.tabpage_6.dw_6.insertrow(0)
//	tab_1.tabpage_6.dw_6.object.funzione[1] = trim(kuf1_memo.get_id_programma(kkg_flag_modalita.elenco)) + "  (" + kkg_flag_modalita.elenco + ") "
//
//else

	if tab_1.tabpage_6.dw_6.dataobject <> "d_meca_memo_l" then
		tab_1.tabpage_6.dw_6.dataobject = "d_meca_memo_l" 
		tab_1.tabpage_6.dw_6.settransobject( sqlca)
	end if

	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
//=== Se id_meca non impostato forzo una INSERISCI 
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
	end if

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_6.st_6_retrieve.text
	tab_1.tabpage_6.st_6_retrieve.Text =  string(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")) 
	
	if tab_1.tabpage_6.st_6_retrieve.text <> k_codice_prec then

		tab_1.tabpage_6.dw_6.retrieve(k_codice)

	end if

	attiva_tasti( )
	
//--- Info x DRAG&DROP
	if tab_1.tabpage_6.dw_6.rowcount() <= 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione) then
		tab_1.tabpage_6.dw_6.dataobject = "d_dragdrp_info"
		tab_1.tabpage_6.st_6_retrieve.Text = "" // azzero per essere sicuro che al prx tentativo torna a fare la retrieve
	end if

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_6.dw_6))
	
//end if

tab_1.tabpage_6.dw_6.setfocus()
	

end subroutine

protected function integer inserisci ();//
int k_return=1
st_tab_meca_memo kst_tab_meca_memo
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_memo_inout kuf1_memo_inout
kuf_memo kuf1_memo
//kuf_sr_sicurezza kuf1_sr_sicurezza

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


//if left(k_errore, 1) = "0" then

	choose case  ki_tab_1_index_new
			
		case 1 // lotto
			kst_tab_g_0.id = 0
			kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.inserimento )

		case 6 // allegati
			try
				kuf1_memo = create kuf_memo
				kuf1_memo_inout = create kuf_memo_inout
				kst_tab_meca_memo.id_meca_memo = 0
				kst_tab_meca_memo.tipo_sv = ki_st_open_w.sr_settore
				kst_tab_meca_memo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
				kst_memo.st_tab_meca_memo = kst_tab_meca_memo
				kuf1_memo_inout.memo_xmeca(kst_memo.st_tab_meca_memo, kst_memo.st_tab_memo)
				kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try

			
	end choose	

	k_return = 0

	attiva_tasti()

//end if

return (k_return)



end function

private subroutine call_memo ();//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
st_tab_meca_memo kst_tab_meca_memo 
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout


try   
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then

		kuf1_memo = create kuf_memo
		kuf1_memo_inout = create kuf_memo_inout
	
		kst_tab_meca_memo.id_meca_memo = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_meca_memo" ) 
		kst_tab_meca_memo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_meca" ) 
			
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

private subroutine u_add_memo_link (string a_file[], integer a_file_nr);//
long k_riga=0
int k_risposta_load_memo_link = 1
st_tab_memo_link kst_tab_memo_link[] 
st_memo kst_memo
kuf_memo_inout kuf1_memo_inout
kuf_memo_link kuf1_memo_link
kuf_utility kuf1_utility
kuf_sr_sicurezza kuf1_sr_sicurezza


try   
//	if kist_memo.st_tab_memo.id_memo  > 0 then

		if a_file_nr = 1 then
			k_risposta_load_memo_link = messagebox("Crea un MEMO", "Oltre al collegamento vuoi importare anche l'intero documento nel DB", Question!, yesnocancel!, k_risposta_load_memo_link)
		else
			k_risposta_load_memo_link = messagebox("Crea un MEMO con " + string(a_file_nr) + " Allegati", "Oltre ai collegamenti vuoi importare anche tutti i documenti nel DB", Question!, yesnocancel!, k_risposta_load_memo_link)
		end if

		if k_risposta_load_memo_link = 3 then
			messagebox("Operazione annullata", "Nessun MEMO è stato creato", information!)
		else
			if NOT isvalid(kuf1_utility) then kuf1_utility = create kuf_utility 
			if NOT isvalid(kuf1_memo_inout) then kuf1_memo_inout = create kuf_memo_inout 
			if NOT isvalid(kuf1_sr_sicurezza) then kuf1_sr_sicurezza = create kuf_sr_sicurezza 
			
	
			for k_riga = 1 to a_file_nr
				kst_tab_memo_link[k_riga].link =a_file[k_riga]
				if k_risposta_load_memo_link = 1 then
					kst_tab_memo_link[k_riga].memo_link_load = kuf1_memo_link.kki_memo_link_load_si
				else
					kst_tab_memo_link[k_riga].memo_link_load = kuf1_memo_link.kki_memo_link_load_NO
				end if
			next
			if a_file_nr > 0 then
				kst_memo.st_tab_meca_memo.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")  
				kst_memo.st_tab_meca_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ki_st_open_w.id_programma)
				kst_memo.st_tab_memo_link = kst_tab_memo_link[]
				kuf1_memo_inout.crea_memo_meca(kst_memo)
			end if
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
		
		end if
//	end if
		
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public function long u_drop_file (integer a_k_tipo_drag, long a_handle);//
int k_sn
long k_file_nr
string k_file_drop[], k_modalita_descr



if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 

k_file_nr = kiuf_file_dragdrop.u_get_file(a_k_tipo_drag, a_handle, k_file_drop[])
if k_file_nr > 0 then	

	kGuf_data_base.set_focus(handle(this)) // dovrebbe prendere il fuoco
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		messagebox("Operazione fermata", "Prima di caricare i MEMO, salvare questo nuovo Lotto", stopsign!) 
	else
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione then
			u_add_memo_link(k_file_drop[], k_file_nr)  // Aggiunge MEMO e Allagati
		else
			k_modalita_descr = kguo_g.get_descrizione( ki_st_open_w.flag_modalita)
			messagebox("Operazione non Permessa", "Solo in 'Modifica o Visualizzazione' è possibile caricare gli Allegati, sei invece in modalità '" + k_modalita_descr + "' ", stopsign!) 
		end if
	end if
end if

return k_file_nr
end function

private subroutine call_ddt ();//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_sped kst_tab_sped
st_open_w kst_open_w
kuf_sped kuf1_sped
datastore kds_1

try   
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then

		kuf1_sped = create kuf_sped
	
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_meca" ) 
			
		if kst_tab_meca.id  > 0 then
			
//--- verifico che non ci siano colli spediti così lancio il carico del ddt
			if kiuf_armo.get_colli_sped_lotto(kst_tab_meca) = 0 then
				kst_open_w.key3 = string(kst_tab_meca.id)
				kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
				kuf1_sped.u_open(kst_open_w)  // carica nuovo DDT
			else
				kds_1 = create datastore
				kds_1.dataobject = "d_sped_riga"
				kds_1.insertrow(0)
				kds_1.setitem(1, "id_meca", kst_tab_meca.id)
				kuf1_sped.link_call(kds_1, "b_arsp_lotto")  // elenco DDT
			end if
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

protected subroutine inizializza_6 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 7 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc
st_tab_f5547013 kst_tab_f5547013, kst_tab_f5547013_prec
kuf_utility kuf1_utility


if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_tab_f5547013.ehapid = trim(string(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")))
end if
if kst_tab_f5547013.ehapid > " " then

	if tab_1.tabpage_7.dw_7.rowcount() > 0 then
		kst_tab_f5547013_prec.ehapid = tab_1.tabpage_7.dw_7.getitemstring(1, "ehapid")  
	end if
	if isnull(kst_tab_f5547013_prec.ehapid) then kst_tab_f5547013_prec.ehapid = ""
	
	if kst_tab_f5547013.ehapid <> kst_tab_f5547013_prec.ehapid then

		kguo_sqlca_db_e1.u_db_connetti(tab_1.tabpage_7.dw_7)  // connette e fa transobject
		tab_1.tabpage_7.dw_7.retrieve(kst_tab_f5547013.ehapid)

//---- azzera il flag delle modifiche
		tab_1.tabpage_7.dw_7.ResetUpdate ( ) 
		
	end if

	attiva_tasti( )

end if

tab_1.tabpage_7.dw_7.setfocus()
	

end subroutine

protected subroutine inizializza_7 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 8 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc
st_e1_anteprima kst_e1_anteprima, kst_e1_anteprima_prec
kuf_utility kuf1_utility


if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
	kst_e1_anteprima.apid = trim(string(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")))
	kst_e1_anteprima.doco = tab_1.tabpage_1.dw_1.getitemnumber(1, "e1doco") 
	if isnull(kst_e1_anteprima.doco) then kst_e1_anteprima.doco = 0
end if
if kst_e1_anteprima.apid > " " then

	if tab_1.tabpage_8.dw_8.rowcount() > 0 then
		kst_e1_anteprima_prec.apid = trim(tab_1.tabpage_8.dw_8.getitemstring(1, "ehapid"))
	end if
	if isnull(kst_e1_anteprima_prec.apid) then kst_e1_anteprima_prec.apid = ""
	
	if kst_e1_anteprima.apid <> kst_e1_anteprima_prec.apid then

		kguo_sqlca_db_e1.u_db_connetti(tab_1.tabpage_8.dw_8)  // connette e fa transobject
		tab_1.tabpage_8.dw_8.retrieve(kst_e1_anteprima.apid, kkg.E1MCU )

//---- azzera il flag delle modifiche
		tab_1.tabpage_8.dw_8.ResetUpdate ( ) 
		
	end if

	attiva_tasti( )

end if

tab_1.tabpage_8.dw_8.setfocus()
	

end subroutine

public subroutine u_cambia_num_data ();//

//--- x disattivare il link sul campo num_int
dw_cambia_numero.ki_flag_modalita = kkg_flag_modalita.modifica

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

public subroutine u_cambia_aperto ();//
string k_stato_des
int k_ok
st_tab_meca kst_tab_meca
kuf_meca_riapri kuf1_meca_riapri


try
	
	autorizza_funzioni( )   // abilita le funzioni della window
	if ki_consenti_modifica then
	
		kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.object.num_int[1]
		kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
		kst_tab_meca.aperto = tab_1.tabpage_1.dw_1.object.meca_aperto[1]
		if kst_tab_meca.aperto = kiuf_armo.kki_meca_aperto_annullato &
				or kst_tab_meca.aperto = kiuf_armo.kki_meca_aperto_no then
				
			kuf1_meca_riapri = create kuf_meca_riapri
			kuf1_meca_riapri.if_sicurezza(kkg_flag_modalita.modifica)  // Utente Autorizzato a RIAPRIRE il Lotto?
			k_ok = messagebox("Operazione di  RIAPERTURA", "Riattivazione del Lotto n. " + string(kst_tab_meca.num_int) + ", proseguire?", question!, yesno!, 2) 
	
			kst_tab_meca.aperto = kiuf_armo.kki_meca_aperto_riaperto
			u_aprichiudi_lotto(kst_tab_meca)
			
		else		
//--- mostra box di Chiusura/Annullo			
			dw_cambia_aperto.x = this.width / 2 - dw_cambia_aperto.width /2
			dw_cambia_aperto.y = this.y + dw_cambia_aperto.height
			dw_cambia_aperto.visible = true
			if dw_cambia_aperto.rowcount( ) = 0 then
				dw_cambia_aperto.insertrow(0)
			end if
			
//--- legge l'attuale descrizione 			
			kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
			k_orig_meca_blk_descrizione = kiuf_armo.get_meca_blk_descrizione(kst_tab_meca)
			dw_cambia_aperto.setitem(1, "causale", k_orig_meca_blk_descrizione)
		end if
		
	end if
			
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	
end try

end subroutine

public subroutine u_aprichiudi_lotto (st_tab_meca kst_tab_meca);//
//--- kst_tab_meca id_meca + aperto (il nuovo valore)
//
int k_ok=0, k_ctr
boolean k_esito=false
string k_stato_des 
st_esito kst_esito
	
	
	try
		
		choose case kst_tab_meca.aperto 
			case kiuf_armo.kki_meca_aperto_riaperto
				k_stato_des = "RIAPERTURA"
			case kiuf_armo.kki_meca_aperto_no
				k_stato_des = "CHIUSURA"
			case kiuf_armo.kki_meca_aperto_annullato
				k_stato_des = "ANNULLATO"
			case else
				k_stato_des = "RIAPERTURA"
		end choose

		choose case kst_tab_meca.aperto 
			case kiuf_armo.kki_meca_aperto_riaperto 
				k_esito = kiuf_armo.set_lotto_apri(kst_tab_meca)
			case kiuf_armo.kki_meca_aperto_no 
				k_esito = kiuf_armo.set_lotto_chiudi(kst_tab_meca)
			case kiuf_armo.kki_meca_aperto_annullato 
				k_esito = kiuf_armo.set_lotto_annullato(kst_tab_meca)
				if trim(kst_tab_meca.meca_blk_descrizione) > " " then
					kiuf_armo.set_meca_blk_descrizione(kst_tab_meca)
				end if
		end choose				

		inizializza_lista()
		if k_esito then
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_ok )
			kguo_exception.setmessage("Operazione di " + trim(k_stato_des) + " Lotto conclusa correttamente" )
			dw_cambia_aperto.visible = false
		else
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
			kguo_exception.setmessage( "Operazione di " + trim(k_stato_des) + " Lotto terminata in modo NON corretto! " )
		end if
		
		kguo_exception.messaggio_utente()
				
			
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito.sqlerrtext = "Operazione di " + trim(k_stato_des) + " Lotto terminata in modo NON corretto! "  + "~n~r" + kst_esito.sqlerrtext
		kuo_exception.messaggio_utente()
		
	finally
		autorizza_funzioni( )   // abilita le funzioni della window
		attiva_tasti( )
		
	end try





end subroutine

protected subroutine attiva_tasti_0 ();//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe

super::attiva_tasti_0()

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
		tab_1.tabpage_5.enabled = true
		tab_1.tabpage_6.enabled = true
		tab_1.tabpage_7.enabled = ki_e1_enabled
		tab_1.tabpage_8.enabled = ki_e1_enabled
	else
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_3.enabled = false
		tab_1.tabpage_4.enabled = false
		tab_1.tabpage_5.enabled = false
		tab_1.tabpage_6.enabled = false
		tab_1.tabpage_7.enabled = false
		tab_1.tabpage_8.enabled = false
	end if
	
	choose case ki_tab_1_index_new
		case 1
		  	cb_visualizza.enabled = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = true
			cb_modifica.enabled = true
			cb_inserisci.enabled = true
			
		case 2 //righe
		   	cb_visualizza.enabled = true
//			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
//					or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//				cb_modifica.enabled = true
//				cb_inserisci.enabled = true
//			end if
//			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//				cb_cancella.enabled = true
//			end if
			
		case 3 //barcode
			cb_modifica.enabled = false
			cb_inserisci.enabled = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
			
		case 5 // voci prezzi
			cb_modifica.enabled = ki_autorizza_listino_modfiica
			cb_inserisci.enabled = false
			cb_aggiorna.enabled = ki_autorizza_listino_modfiica
			cb_cancella.enabled = false
			
		case 6 // allegati
			cb_inserisci.enabled = true
			if tab_1.tabpage_6.dw_6.rowcount( ) > 0 then
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
			end if
			
		case 7, 8 //E1
			cb_modifica.enabled = false
			cb_inserisci.enabled = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
			
	end choose

end if



end subroutine

on w_meca_1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_armo)
destroy(this.dw_cambia_numero)
destroy(this.dw_cambia_aperto)
end on

on w_meca_1.create
int iCurrent
call super::create
this.dw_armo=create dw_armo
this.dw_cambia_numero=create dw_cambia_numero
this.dw_cambia_aperto=create dw_cambia_aperto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_armo
this.Control[iCurrent+2]=this.dw_cambia_numero
this.Control[iCurrent+3]=this.dw_cambia_aperto
end on

event close;call super::close;//
if isvalid(kiuf_armo) then destroy 	kiuf_armo


end event

event key;call super::key;
if kidw_selezionata.dataobject = "d_meca_1" or kidw_selezionata.dataobject = "d_meca_memo_l" &
               or kidw_selezionata.dataobject = "d_armo_x_meca_1" or kidw_selezionata.dataobject = "d_dragdrp_info" then
//--- CTRL+V fa Incolla dei file
	if key = KeyV! and keyflags = 2 then
		u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_incolla, handle(this))
	end if
end if

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

type cb_visualizza from w_g_tab_3`cb_visualizza within w_meca_1
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_meca_1
end type

event cb_modifica::clicked;call super::clicked;//=== 
//=== 
//===
long k_riga=0
st_esito kst_esito
st_memo kst_memo
st_tab_armo kst_tab_armo
st_tab_g_0 kst_tab_g_0
kuf_utility kuf1_utility
kuf_memo kuf1_memo

try
	
	choose case tab_1.selectedtab 
		case 1 // lotto
			kst_tab_g_0.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
			kiuf_armo.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
			
			
		case 2  // righe
			k_riga = tab_1.tabpage_2.dw_2.getrow()	
			if k_riga > 0 then
	
				kst_tab_armo.id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo")
				
				dw_armo.event ue_inizializza (kst_tab_armo, kkg_flag_modalita.modifica)
					
			end if
			
		case 5
			kuf1_utility = create kuf_utility
	//--- S-protezione campi per riabilitare la modifica 
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_5.dw_5)
			
		case 6 // Allegati
			kuf1_memo = create kuf_memo
			k_riga = tab_1.tabpage_6.dw_6.getrow()
			if k_riga > 0 then
			else
				if tab_1.tabpage_6.dw_6.rowcount() = 1 then
					k_riga = 1
				end if
			end if
			if k_riga > 0 then
				kst_memo.st_tab_memo.id_memo = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "id_memo")
				if kst_memo.st_tab_memo.id_memo > 0 then
					kuf1_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.modifica )
				end if
			end if
			
	end choose	

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd then
		kuo_exception.messaggio_utente()
	end if
	
end try


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

event cb_inserisci::clicked;//
inserisci( )
end event

type tab_1 from w_g_tab_3`tab_1 within w_meca_1
boolean visible = true
integer x = 0
integer y = 0
integer width = 2939
integer height = 1184
long backcolor = 67108864
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

event tab_1::key;call super::key;
if kidw_selezionata.dataobject = "d_meca_1" or kidw_selezionata.dataobject = "d_meca_memo_l" then
//--- CTRL+V fa Incolla dei file
	if key = KeyV! and keyflags = 2 then
		u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_incolla, handle(this))
	end if
end if

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 2903
integer height = 1056
long backcolor = 67108864
string text = " Lotto"
long tabbackcolor = 67108864
string picturename = "BrowseObject!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_dropfiles pbm_dropfiles
integer x = 23
integer y = 24
integer width = 1426
integer height = 992
string dataobject = "d_meca_1"
boolean hsplitscroll = false
end type

event dw_1::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)
smista_funz(kkg_flag_richiesta.refresh)

return k_file_nr




end event

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
boolean k_elabora=false
window k_window
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


string nome = ' '
nome=dwo.name
if left(dwo.name, 2) = "b_" or left(dwo.name, 2) = "p_"  then

//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	choose case dwo.name
		case "b_meca"
			if this.object.num_int[this.getrow()] > 0 then
				k_elabora=true
				kdsi_elenco_output.dataobject = "d_meca_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.id_meca[this.getrow()])
				kst_open_w.key1 = "Riferimento "  + string(this.object.num_int[this.getrow()]) 
			end if
		case "b_contratti"
			if this.object.meca_contratto[this.getrow()] > 0 then
				k_elabora=true
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
				k_elabora=true
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
				k_elabora=true
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.meca_clie_1[this.getrow()])
				kst_open_w.key1 = "Mandante " + string(this.object.clienti_rag_soc_10[this.getrow()]) 
			end if
		case "b_clie_2"
			if this.object.certif_clie_2[this.getrow()] > 0 then
				k_elabora=true
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.certif_clie_2[this.getrow()])
				kst_open_w.key1 = "Ricevente " + string(this.object.clienti_rag_soc_10_1[this.getrow()]) 
			end if
		case "b_clie_3"
			if this.object.meca_clie_3[this.getrow()] > 0 then
				k_elabora=true
				kdsi_elenco_output.dataobject = "d_clienti_1" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve(this.object.meca_clie_3[this.getrow()])
				kst_open_w.key1 = "Cliente " + string(this.object.clienti_rag_soc_10_2[this.getrow()]) 
			end if

//--- memo: carico note e allegati
		case "p_id_memo_no" 
			k_elabora=true
			call_memo()
			
	end choose

end if

if	k_elabora and left(dwo.name, 2) = "b_"  then
	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kGuf_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = "elenco"
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = "el"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
		//destroy kuf1_menu_window

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
integer width = 2903
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
integer width = 2903
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
integer width = 2903
integer height = 1056
boolean enabled = false
string text = "Voci aperte"
string picturename = "IncrementalBuildTarget!"
string powertiptext = "Ulteriori voci di costo aperte caricate "
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_prezzi_v_x_id_meca"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 2903
integer height = 1056
boolean enabled = false
string text = "Voci Prezzi"
string picturename = "D:\gammarad\pb_gmmrd126\icone\carrello16.png"
string powertiptext = "Voci prezzi lotto in fattura"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
boolean enabled = true
string dataobject = "d_armo_prezzi_l_x_id_meca"
boolean ki_colora_riga_aggiornata = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer width = 2903
integer height = 1056
boolean enabled = true
string text = " Memo"
string picturename = "Copy!"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
event u_dropfiles pbm_dropfiles
boolean visible = true
integer width = 1358
boolean enabled = true
string dataobject = "d_meca_memo_l"
boolean ki_link_standard_sempre_possibile = true
end type

event dw_6::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr




end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
integer width = 2903
integer height = 1056
string text = "E1-ASN"
string picturename = "e1Lotto.png"
string powertiptext = "accesso a E1 per vedere i dati ASN"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean visible = true
boolean enabled = true
string dataobject = "d_e1_asn_f5547_l"
boolean ki_db_conn_standard = false
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
boolean visible = true
integer width = 2903
integer height = 1056
string text = "E1-dati"
string picturename = "e1Lotto.png"
string powertiptext = "accesso a E1 per vedere i dati generici"
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean visible = true
boolean enabled = true
string dataobject = "d_e1_dati_gen"
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = false
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 2903
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
integer x = 87
integer y = 408
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

kst_esito.esito = kkg_esito.ok


k_rc = this.event ue_dati_modif()
	
//--- OK continuo con le operazioni	
if k_rc = 0 then 


//--- controlla se utente autorizzato alla funzione richiesta
	kst_open_w = ki_st_open_w
	kst_open_w.flag_modalita = k_flag_modalita
	if sicurezza(kst_open_w) then
		
	//--- Se inserimento.... 
		if k_flag_modalita = kkg_flag_modalita.inserimento then
			this.dataobject="d_meca_1_armo_speciali"
			this.settransobject(kguo_sqlca_db_magazzino)
			this.event ue_nuovo (kst_tab_armo)
		else
	//--- Se NO inserimento.... 
			this.dataobject="d_armo_riga"
			this.settransobject(kguo_sqlca_db_magazzino)
			k_rc = this.retrieve( kst_tab_armo.id_armo) 
			
			choose case k_rc
	
				case is < 0				
	//--- chiama l'evento per chiudere la dw
					this.event ue_visibile (false)
					kst_esito.esito = kkg_esito.db_ko
					
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
					kst_esito.esito = kkg_esito.not_fnd
					
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					kuo_exception.setmessage( "Operazione fallita~n~rId riga Lotto non Trovato: " + trim(string(kst_tab_armo.id_armo)) )
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
					throw kuo_exception
				
				case is > 0		
	
					attiva_tasti()
			
			end choose
	
		end if
	
		if k_flag_modalita = kkg_flag_modalita.inserimento then
			this.setcolumn("art")
			this.setfocus()
		else
			if k_flag_modalita = kkg_flag_modalita.modifica then
				this.setcolumn("art")
				this.setfocus()
			end if
		end if
		
	
	//--- Se Modifica...
		if k_flag_modalita = kkg_flag_modalita.modifica and this.getrow() > 0 then
	
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
		if k_flag_modalita <> kkg_flag_modalita.inserimento and k_flag_modalita <> kkg_flag_modalita.modifica then
		
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


if this.u_dati_modificati() then
	
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
	
	this.modify( "art_t.Color='" + string(kkg_colore.nero) +"'" )
	this.modify( "colli_2_t.Color='" + string(kkg_colore.nero) +"'" )
	
	
	if kst_tab_armo.colli_2 > 0 and kst_tab_armo.id_listino > 0 then
		
		kst_tab_armo.colli_1 = kst_tab_armo.colli_2 
		
	//--- aggiorna RIGA-LOTTO	
		kiuf_armo.tb_update_armo(kst_tab_armo)
		this.Reset ( ) 
	//--- chiama l'evento per nascondere la dw
		this.event ue_visibile (false)
		tab_1.selectedtab = 2
		smista_funz(kkg_flag_richiesta_refresh)
	
//		else
//			kuo_exception = create uo_exception
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_db_ko )
//			kuo_exception.set_esito( kst_esito )
//			throw kuo_exception
//			
//		end if
	
	else
		if kst_tab_armo.colli_2 = 0 or isnull( kst_tab_armo.colli_2) then
			this.modify( "colli_2_t.Color='" + string(kkg_colore.rosso) +"'" )
		end if
		if kst_tab_armo.id_listino = 0 or isnull( kst_tab_armo.id_listino)  then
			this.modify( "art_t.Color='" + string(kkg_colore.rosso) +"'" )
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
		
			if this.u_dati_modificati( ) then
		
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
		
		this.title = " Dettaglio riga Lotto: " + string(kst_tab_armo.num_int) + " / " + string(kst_tab_armo.data_int, "yyyy") + "  (id=" + string(kst_tab_armo.id_armo) + ") " 
	
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
integer x = 69
integer y = 568
integer width = 1893
integer height = 604
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Cambia Data Lotto "
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

type dw_cambia_aperto from uo_d_std_1 within w_meca_1
integer x = 1047
integer y = 472
integer width = 1152
integer height = 652
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Chiude / Annulla Lotto"
string dataobject = "d_meca_aperto"
boolean controlmenu = true
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_db_conn_standard = false
boolean ki_dw_visibile_in_open_window = false
end type

event buttonclicked;call super::buttonclicked;//
st_tab_meca kst_tab_meca

		
	this.accepttext( )
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.object.id_meca[1]
	if kst_tab_meca.id > 0 then
		kst_tab_meca.aperto = trim(this.object.aperto[1])
		kst_tab_meca.meca_blk_descrizione = trim(this.object.causale[1])
	
		if kst_tab_meca.aperto <> kiuf_armo.kki_meca_aperto_annullato then
			u_aprichiudi_lotto(kst_tab_meca)
		else
			if k_orig_meca_blk_descrizione <> kst_tab_meca.meca_blk_descrizione then
				u_aprichiudi_lotto(kst_tab_meca)
			else
				messagebox("Annullo Lotto", "Prego, indicare il motivo dell'annullo non basta eventuale descrizione già indicata")
				this.setcolumn("causale")
			end if
		end if
	end if 
end event

