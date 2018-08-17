$PBExportHeader$w_pilota_proprieta.srw
forward
global type w_pilota_proprieta from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_pilota_proprieta from w_g_tab_3
integer x = 169
integer y = 148
integer width = 2958
integer height = 1836
string title = "Propriea Pilota"
long backcolor = 31909606
integer animationtime = 0
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_toolbar_programmi_attiva_voce = false
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
string ki_syntaxquery = ""
string ki_dw_titolo_modif_1 = ""
end type
global w_pilota_proprieta w_pilota_proprieta

type variables

end variables

forward prototypes
protected subroutine inizializza_1 ()
private function integer inserisci ()
private function string check_dati ()
private subroutine riempi_id ()
protected function string aggiorna ()
protected function string inizializza ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
private subroutine open_notepad_documento (string k_file) throws uo_exception
protected subroutine open_start_window ()
private subroutine get_path_temp ()
private subroutine get_path_pilota_out ()
private subroutine get_path_file_pl_barcode ()
private subroutine get_path_pilota_inp ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
	if tab_1.tabpage_2.dw_2.rowcount() < 1 then

//=== Parametri : cliente, articolo
		if tab_1.tabpage_2.dw_2.retrieve() <= 0 then

//			inserisci()
		else
					
			attiva_tasti()

		end if				
	else
		attiva_tasti()
	end if

	tab_1.tabpage_2.dw_2.setfocus()
	

end subroutine

private function integer inserisci ();////
int k_return=1, k_ctr
//string k_errore="0 "
//date k_data
//long k_riga 
//string k_codice
////datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
//kuf_base kuf1_base
//
//
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
////if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento
//
////=== Controllo congruenza dei dati caricati e Aggiornamento  
////=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
////===                : 2=errore non grave dati aggiornati;
////===			         : 3=LIBERO
////===      il resto della stringa contiene la descrizione dell'errore   
////	k_errore = aggiorna_dati()
//
////end if
//
//
//if left(k_errore, 1) = "0" then
//
//
////=== Aggiunge una riga al data windows
//	choose case tab_1.selectedtab 
//		case  1 
//	
////			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
//
////			kdwc_cliente.settransobject(sqlca)
//	
//			tab_1.tabpage_1.dw_1.insertrow(0)
//			
//			tab_1.tabpage_1.dw_1.setcolumn(1)
//			
//		case 2 // Listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//////=== Riempe indirizzo di Spedizione da DW_1
////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
////	
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
////	
////				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
////				tab_1.tabpage_2.dw_2.setrow(k_riga)
////				tab_1.tabpage_2.dw_2.setcolumn(1)
////			end if
////			
//		case 3 // Listino
//			
//		case 4 // Lista Entrate
//			
//		case 5 // Lista Fatture
//			
//	end choose	
//
//	attiva_tasti()
//
//	k_return = 0
//
//end if
//
return (k_return)



end function

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key_str
string k_key



////=== Controllo il primo tab
//	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
//	k_nr_errori = 0
//	k_riga = 1
//
//	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "codice") 
//	if isnull(k_key) or len(trim(k_key)) = 0 then
//		k_return = "Manca il Codice " + tab_1.tabpage_1.text + "~n~r"
//		k_errore = "3"
//		k_nr_errori++
//	else
//		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "des")) = true then
//			k_return = "Manca la Descrizione " + tab_1.tabpage_1.text + "~n~r" 
//			k_errore = "3"
//			k_nr_errori++
//		end if
////		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente") = 0 or &
////			isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")) = true then
////			k_return = k_return + "Manca il Cliente " + tab_1.tabpage_1.text + "~n~r" 
////			k_errore = "3"
////			k_nr_errori++
////		end if
//	end if
//
//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
//	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 
//
//		if isnull(k_key) then
//			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
//			k_key = 0
//		end if
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
//				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
//				string(k_riga, "#####") + " non impostata~n~r" 
//				k_errore = "4"
//				k_nr_errori++
//			end if
//
//			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
//				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
//				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
//							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
//							(k_riga+1), k_nr_righe) > 0 then
//					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
//					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
//
//	loop
//
////=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 
//
//
//		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//
//			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
//				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
//				string(k_riga, "#####") + " ~n~r" 
//				k_errore = "3"
//				k_nr_errori++
//			end if
//
//			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
//				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
//					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
//					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
//					string(k_riga, "#####") + " ~n~r" 
//					k_errore = "4"
//					k_nr_errori++
//				end if
//			end if
//
//		end if
//		k_riga++
//
//		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
//
//	loop
//
//
//
return k_errore + k_return


end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
integer k_codice_1, k_codice
string k_ret_code
kuf_base kuf1_base


//=== Salvo ID  originale x piu' avanti
//	k_codice_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	else

	if k_codice = 0 or isnull(k_codice) then
		tab_1.tabpage_1.dw_1.setitem(1, "codice", "1")		
	end if
//		kuf1_base = create kuf_base
//	//=== Imposto il ID  su arch. Azienda
//		k_ret_code = kuf1_base.prendi_dato_base("codice")
//		if left(k_ret_code, 1) = "0" then
//			k_codice = long(mid(k_ret_code, 2)) + 1
//			k_ret_code = kuf1_base.metti_dato_base(0, "codice", string(k_codice,"#####"))
//		end if
//		if left(k_ret_code, 1) = "1" then
//	
//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//			
//			messagebox("Aggiornamento Automatico Fallito !!", &
//				"Attenzione: non sono riuscito ad aggiornare il contatore COMMESSE,~n~r" + &
//				"in archivio Azienda. ~n~r" + &
//				"Aggiornare immediatamente in modo manuale il 'ID Commessa' in Azienda. ~n~r" + &
//				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
//				"il numero " + string(k_codice,"#####") + " nel campo 'ID Commess'. ~n~r" + &
//				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &
//				"Se il problema persiste, si prega di contattare il programmatore. Grazie", &
//				stopsign!, ok!)
//				
//		end if		
	
//		destroy kuf1_base
//		k_nro_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
//		if k_nro_commessa <> k_nro_commessa_1 then
//
////=== ho trovato il nr commessa diverso da quello in BASE controllo se commessa gia' caricata
//			select codice into :k_ctr
//				from commesse
//				where nro_commessa = :k_nro_commessa_1;
//
//			if sqlca.sqlcode = 0 then
//				k_nro_old = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa") 
//				messagebox("Aggiornamento Commessa", &
//					"Mi spiace ma il numero abbinato a questa commessa e' stato cambiato ~n~r" + &
//					"da " + string(k_nro_old,"#####") + " a " + &
//						string(k_nro_commessa,"#####") + "~n~r" + &
//					"Motivo : potrebbero esserci altri utenti che stanno caricando Commesse, ~n~r" + &
//					"nessun pericolo di perdita dati. ", &
//					information!, ok!)
//			end if
//		end if		
//	
	
//		tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
	
//		tab_1.tabpage_1.dw_1.setitem(1, "codice", k_codice)

	end if
	
//	k_righe = tab_1.tabpage_2.dw_2.rowcount()
//	if k_righe > 0 then
//
//	
//		tab_1.tabpage_2.dw_2.setitem(k_ctr, "codice", k_codice)
//
//		tab_1.tabpage_1.dw_1.setitem(1, "indi_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "indi_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "cap_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "cap_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "loc_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "loc_2"))
//		tab_1.tabpage_1.dw_1.setitem(1, "prov_2", &
//				tab_1.tabpage_2.dw_2.getitemstring(1, "prov_2"))
//				
//	end if
//


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

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kGuf_data_base.db_commit()
		if LeftA(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + MidA(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kGuf_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
	end if
end if

////=== Aggiorna, se modificato, la TAB_2
//if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_2.dw_2.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kGuf_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kGuf_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_2.text + "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_3
//if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_3.dw_3.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kGuf_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kGuf_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_3.text + "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_4
//if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_4.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kGuf_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Movimenti " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kGuf_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Movimenti'" + &
//					 "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_4 dw_41
//if tab_1.tabpage_4.dw_41.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_41.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_41.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kGuf_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Note Commessa " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kGuf_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Note Commessa'" + &
//					" ~n~r" 
//	end if	
//end if


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		MidA(k_return, 2))
else
	if LeftA(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
int  k_key, k_codice
int k_err_ins, k_rc
kuf_utility kuf1_utility


//=== 


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if isnumber(trim(ki_st_open_w.key1)) then
		k_key = integer(trim(ki_st_open_w.key1))
	else
		k_key = 1
	end if

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato: " + string(k_key) + ")~n~r" )
//				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					messagebox("Ricerca fallita", &
						"Mi spiace ma il Record non e' in archivio ~n~r" + &
						"(Codice cercato: " + string(k_key) + ")~n~r" )

//					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
//					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta = kkg_flag_modalita.INSERIMENTO then
					messagebox("Riga già caricata", &
						"Il record e' gia' in archivio ~n~r" + &
						"(Codice cercato: " + string(k_key) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
//manda in crash l'applicazione				tab_1.tabpage_1.dw_1.setfocus()
				
		end choose

	end if

end if


	
//--- Inabilita campi alla modifica se Vsualizzazione
  kuf1_utility = create kuf_utility 
 if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
	end if

end if
destroy kuf1_utility

	
return "0"


end function

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
	if tab_1.tabpage_3.dw_3.rowcount() < 1 then

//		tab_1.tabpage_3.dw_3.settransobject(kguo_sqlca_db_pilota)
		tab_1.tabpage_3.dw_3.settrans(kguo_sqlca_db_pilota)   // connessione/disconn in automatico

	end if

//=== Parametri : cliente, articolo
	if tab_1.tabpage_3.dw_3.retrieve() <= 0 then

//			inserisci()
	else
					
		attiva_tasti()

	end if				

	attiva_tasti()

	tab_1.tabpage_3.dw_3.setfocus()
	

end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
	if tab_1.tabpage_4.dw_4.rowcount() < 1 then

//		kguo_sqlca_db_pilota.db_connetti()
//		tab_1.tabpage_4.dw_4.settransobject(kguo_sqlca_db_pilota)
		tab_1.tabpage_4.dw_4.settrans(kguo_sqlca_db_pilota)   // connessione/disconn in automatico

	end if

//=== Parametri : cliente, articolo
	if tab_1.tabpage_4.dw_4.retrieve() <= 0 then

//			inserisci()
	else
					
		attiva_tasti()

	end if				

	attiva_tasti()

	tab_1.tabpage_4.dw_4.setfocus()
	

end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
	if tab_1.tabpage_5.dw_5.rowcount() < 1 then

//		kguo_sqlca_db_pilota.db_connetti()
//		tab_1.tabpage_5.dw_5.settransobject(kguo_sqlca_db_pilota)
		tab_1.tabpage_5.dw_5.settrans(kguo_sqlca_db_pilota)   // connessione/disconn in automatico

	end if

//=== Parametri : cliente, articolo
	if tab_1.tabpage_5.dw_5.retrieve() <= 0 then

//			inserisci()
	else
					
		attiva_tasti()

	end if				

	attiva_tasti()

	tab_1.tabpage_5.dw_5.setfocus()
	

end subroutine

private subroutine open_notepad_documento (string k_file) throws uo_exception;//
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	if LenA(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
		if kst_esito.esito <> "0" then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_generico)
			kuo_exception.setmessage("Impossibile aprire il Documento" + trim(k_file)+ "~n~r" +trim(kst_esito.sqlerrtext) )
			throw kuo_exception
		end if
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun Documento Associato a questo P.L.!" )
		throw kuo_exception
		
	end if
	





end subroutine

protected subroutine open_start_window ();
tab_1.tabpage_1.dw_1.SetPosition("cfg_dbms_scelta", "", false)
tab_1.tabpage_1.dw_1.SetPosition("b_odbc", "", true)

//tab_1.tabpage_1.dw_1.object.cfg_dbms_scelta.sendtoback
end subroutine

private subroutine get_path_temp ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "path_temp")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Temporanea", k_path )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "path_temp", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_pilota_out ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "path_pilota_out")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Deposito file di 'Comando Richieste'", k_path )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "path_pilota_out", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_file_pl_barcode ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "path_file_pl_barcode")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Deposito file dei 'Piani di Lavorazione'", k_path )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "path_file_pl_barcode", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_pilota_inp ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_1.dw_1.getitemstring (1, "path_pilota_inp")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Deposito file Esiti del Pilota", k_path )

if k_ret = 1 then
	tab_1.tabpage_1.dw_1.setitem(1, "path_pilota_inp", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


super::attiva_tasti_0( )

cb_ritorna.enabled = true
cb_inserisci.enabled = false
cb_aggiorna.enabled = true
cb_cancella.enabled = true

cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
		end if
	case 2
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
	case 3
			cb_cancella.enabled = false
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
	case 4
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
	case 5
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
			cb_aggiorna.enabled = false
end choose
            
end subroutine

on w_pilota_proprieta.create
int iCurrent
call super::create
end on

on w_pilota_proprieta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_pilota_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_pilota_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_pilota_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_pilota_proprieta
integer x = 2711
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type st_stampa from w_g_tab_3`st_stampa within w_pilota_proprieta
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_pilota_proprieta
integer x = 1175
integer y = 1440
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_pilota_proprieta
integer x = 503
integer y = 1436
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_pilota_proprieta
integer x = 1970
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_pilota_proprieta
integer x = 2341
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_pilota_proprieta
integer x = 1600
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
boolean enabled = false
string text = ""
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_pilota_proprieta
boolean visible = true
integer x = 0
integer y = 0
integer width = 3040
integer height = 1396
integer taborder = 0
integer weight = 0
string facename = ""
long backcolor = 32172778
boolean raggedright = false
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

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 32435950
string text = "Configurazioni~r~n- connessione DB~r~n- File per il Pilota"
long tabtextcolor = 0
long tabbackcolor = 33554431
string picturename = "DosEdit5!"
long picturemaskcolor = 553648127
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 18
integer y = 60
integer width = 2967
integer height = 1144
integer taborder = 0
string title = ""
string dataobject = "d_pilota_cfg"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

event dw_1::buttonclicked;call super::buttonclicked;//
kuf_utility kuf1_utility


if dwo.name = "b_odbc" then 

	kuf1_utility = create kuf_utility
	kuf1_utility.u_apri_programma_esterno("odbcad32.exe")
	destroy kuf1_utility

else
	if dwo.name = "b_path_temp" then
		get_path_temp()
	end if
	if dwo.name = "b_path_pilota_out" then
		get_path_pilota_out()
	end if
	if dwo.name = "b_path_pl" then
		get_path_file_pl_barcode()
	end if
	if dwo.name = "b_path_pilota_inp" then
		get_path_pilota_inp()
	end if
	if dwo.name = "b_dbparm" then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
		kguo_exception.messaggio_utente("Test Connessione", "Hai Salvato i Dati della Connessione qui indicati?  ~n~rAttenzione: il test di Connessione è fatto con i parametri già SALVATI su DB!")
		try
			kguo_sqlca_db_pilota.db_disconnetti( ) 
		catch (uo_exception kuo_exceptionOK)
		end try
		try
			kguo_sqlca_db_pilota.db_disconnetti( ) 
			if kguo_sqlca_db_pilota.db_connetti( ) then
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_OK)
				kguo_exception.messaggio_utente("Test Connessione",  "OK, connessione eseguita.")
			end if
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()

		finally
			kguo_sqlca_db_pilota.db_disconnetti()
			
		end try
	end if
	
end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 507
integer y = 832
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 31909606
string text = "Elenco Piani di Lavorazione~r~nInviati al Pilota~r~n(Richieste)"
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer y = 24
integer width = 2981
integer height = 1180
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_pilota_cmd_l"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
end type

event dw_2::clicked;call super::clicked;//
//=== Premuto Link nella DW ?
//
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


try
		

	if dwo.name = "path_file_pl_barcode" then
	
		open_notepad_documento(this.getitemstring(row, "path_file_pl_barcode"))
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try


//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)


//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 31909606
string text = "PILOTA~r~nCoda pallet in~r~nLavorazione"
long tabtextcolor = 128
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 0
integer y = 48
integer width = 2967
integer height = 1156
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_pilota_queue_table"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
boolean ki_db_conn_standard = false
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 33544171
string text = "PILOTA~r~npallet~r~nTrattati~r~n"
long tabtextcolor = 128
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 0
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
boolean enabled = true
string title = ""
string dataobject = "d_pilota_pallet"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
boolean ki_db_conn_standard = false
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 31909606
string text = "PILOTA~r~nImpostazioni ~r~nBase"
long tabtextcolor = 128
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer x = 0
integer y = 20
integer width = 2935
integer height = 1152
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_pilota_impostazioni"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
boolean ki_db_conn_standard = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer y = 240
integer width = 3003
integer height = 1140
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

