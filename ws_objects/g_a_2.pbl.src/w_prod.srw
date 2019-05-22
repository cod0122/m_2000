$PBExportHeader$w_prod.srw
forward
global type w_prod from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_prod from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3136
integer height = 1616
string title = "Anagrafica Prodotto"
long backcolor = 31909606
integer animationtime = 0
boolean ki_esponi_msg_dati_modificati = false
boolean ki_toolbar_programmi_attiva_voce = false
boolean ki_fai_nuovo_dopo_update = false
string ki_syntaxquery = ""
string ki_dw_titolo_modif_1 = ""
end type
global w_prod w_prod

type variables

end variables

forward prototypes
protected subroutine inizializza_1 ()
private function integer inserisci ()
private function string check_dati ()
private subroutine riempi_id ()
protected function integer cancella ()
private subroutine pulizia_righe ()
protected function string aggiorna ()
private function string dati_modif (string k_titolo)
private function integer check_prod ()
private function integer check_rek (string k_codice)
private function integer check_rek_gruppo (integer k_codice)
private function integer check_rek_iva (integer k_codice)
protected function string inizializza ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
string k_scelta
boolean k_return
kuf_sicurezza kuf1_sicurezza
kuf_listino kuf1_listino
st_open_w kst_open_w



if tab_1.tabpage_1.dw_1.rowcount() > 0 then


	kuf1_listino = create kuf_listino
	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
	kst_open_w.id_programma = kuf1_listino.get_id_programma(kst_open_w.flag_modalita)
	destroy kuf1_listino


	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then
	
		tab_1.tabpage_2.dw_2.dataobject = "d_funz_no_aut"
		tab_1.tabpage_2.dw_2.insertrow(0)
		tab_1.tabpage_2.dw_2.object.funzione[1] = trim(kst_open_w.id_programma) + "  (" + kst_open_w.flag_modalita + ") "
	
	else
	
		if tab_1.tabpage_2.dw_2.dataobject <> "d_clienti_listino" then
			tab_1.tabpage_2.dw_2.dataobject = "d_clienti_listino" 
			tab_1.tabpage_2.dw_2.settransobject( sqlca)
		end if

		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
		if LenA(trim(k_codice)) = 0 then
			inserisci()
			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
		end if
	
		if tab_1.tabpage_2.dw_2.rowcount() < 1 then
	
	//=== Parametri : cliente, articolo
			if tab_1.tabpage_2.dw_2.retrieve(0, k_codice) <= 0 then
	
//				inserisci()
			else
						
				attiva_tasti()
	
			end if				
		else
			attiva_tasti()
		end if

	end if

	//tab_1.tabpage_2.dw_2.setfocus()
	
end if


end subroutine

private function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_riga 
string k_codice
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
kuf_base kuf1_base


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if LeftA(k_errore, 1) = "0" then


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
	
//			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)

//			kdwc_cliente.settransobject(sqlca)
	
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
		case 2 // Listino
			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
////=== Riempe indirizzo di Spedizione da DW_1
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
//	
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
//	
//				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
//				tab_1.tabpage_2.dw_2.setrow(k_riga)
//				tab_1.tabpage_2.dw_2.setcolumn(1)
//			end if
//			
		case 3 // Listino
			
		case 4 // Lista Entrate
			
		case 5 // Lista Fatture
			
	end choose	

	attiva_tasti()

	k_return = 0

end if

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
string k_stato, k_tipo
string k_key



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "codice") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = "Manca il Codice " + tab_1.tabpage_1.text + "~n~r"
		k_errore = "3"
		k_nr_errori++
	else
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "des")) = true then
			k_return = "Manca la Descrizione " + tab_1.tabpage_1.text + "~n~r" 
			k_errore = "3"
			k_nr_errori++
		end if
//		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente") = 0 or &
//			isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")) = true then
//			k_return = k_return + "Manca il Cliente " + tab_1.tabpage_1.text + "~n~r" 
//			k_errore = "3"
//			k_nr_errori++
//		end if
	end if

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
//st_tab_prodotti kst_tab_prodotti
//kuf_base kuf1_base


if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then

	if len(trim(tab_1.tabpage_1.dw_1.getitemstring(1, "des_mkt") )) > 0 then
		// valorizza
	else
		tab_1.tabpage_1.dw_1.setitem(1, "des_mkt", tab_1.tabpage_1.dw_1.getitemstring(1, "des")) 
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( 1, "prodotti_attivo")) then tab_1.tabpage_1.dw_1.setitem ( 1, "prodotti_attivo", "S" )

end if

//=== Salvo ID  originale x piu' avanti
//	kst_tab_prodotti.codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
//	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
//		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//	else
		
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

//	end if
	
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

protected function integer cancella ();////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1, k_key
long k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
kuf_prodotti  kuf1_prodotti




//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Prodotto "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "des")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler rimuovere l'ARTICOLO~n~r" + &
					trim(k_key) +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
//	case 2
//		k_record = " Indirizzo Commerciale "
//		k_riga = tab_1.tabpage_2.dw_2.getrow()	
//		if k_riga > 0 then
//			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "clie_c")
//				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "rag_soc_1_c")
//				if isnull(k_desc) = true or trim(k_desc) = "" then
//					k_desc = "senza ragione sociale" 
//				end if
//				k_record_1 = &
//					"Sei sicuro di voler eliminare l'Indirizzo Commerciale di~n~r" + &
//					string(k_key, "#####") + " " + trim(k_desc) + " ?"
//			else
//				tab_1.tabpage_2.dw_2.deleterow(k_riga)
//			end if
//		end if
//	case 4
//		k_record = " Fattura di anticipo "
//		k_riga = tab_1.tabpage_4.dw_4.getrow()	
//		if k_riga > 0 then
//			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_commessa")
//				k_nro_fatt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "id_fattura")
//				k_data = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_fattura")
//				k_record_1 = &
//					"Sei sicuro di voler eliminare la Fattura~n~r" + &
//					trim(k_nro_fatt) + " del " + string(k_data, "dd-mm-yy") + " ?"
//			else
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and LenA(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_prodotti = create kuf_prodotti
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kuf1_prodotti.tb_delete(k_key) 
		end choose	
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione", &
						  "Operazione fallita per questi motivi:~n~r" +	MidA(k_errore1, 2)) 	

		end if
		
		attiva_tasti()

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_prodotti

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
end choose	


return k_return

end function

private subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()
//tab_1.tabpage_4.dw_41.accepttext()

//=== Pulizia dei rek non validi sui vari TAB
//	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "nro_commessa")) or &
//				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "nro_commessa") = 0) or &
//				(isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")) or &
//				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente") = 0) or &
//				(isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "commesse_data"))) &
//				then
//		
//				tab_1.tabpage_1.dw_1.deleterow(k_riga)
//			end if
//		end if
//		
//	next
//
//	
//	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if (isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne") = 0) and &
//				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne") = 0) and &
//				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale")) or &
//				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale") = 0) &
//				then
//		
//				tab_1.tabpage_2.dw_2.deleterow(k_riga)
//			end if
//		end if
//		
//	next
//
//
////	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
////	for k_riga = k_nr_righe to 1 step -1
////		if tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) = newmodified! then 
////		if (isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa")) or &
////			 tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa") = 0) &
////			then
////			tab_1.tabpage_3.dw_3.deleterow(k_riga)
////			//			tab_1.tabpage_3.dw_3.setitem(k_riga, "id_commessa", k_id_commessa)
////		end if
////	next
////
//
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//			if (isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura")) or &
//				 len(trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura"))) = 0) &
//				then
//		
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
//		
//	next
//
////	k_nr_righe = tab_1.tabpage_4.dw_41.rowcount()
////	for k_riga = k_nr_righe to 1 step -1
////
////		if (isnull(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note")) or &
////			 len(trim(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note"))) = 0) &
////			then
////		
////			tab_1.tabpage_4.dw_41.deleterow(k_riga)
////		end if
////		
////	next
////

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

private function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 or & 
		tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0  & 
		then 

		if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 then
			k_titolo = "Aggiorna Archivio"
		end if

		k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
							question!, yesnocancel!, 1) 
	
		if k_msg = 1 then
			k_return = "1Dati Modificati"	
		else
			k_return = string(k_msg)			
		end if

	end if


return k_return
end function

private function integer check_prod ();//
int k_return 
string k_des
string k_codice


k_des = trim(tab_1.tabpage_1.dw_1.gettext())

if LenA(k_des) > 0 then

	declare c_prodotti cursor for  
		SELECT 
  	     prodotti.codice,  
  	     prodotti.des_mkt  
    	FROM prodotti 
   	WHERE upper(prodotti.des) >= :k_des 
			order by prodotti.des ;

	k_des = "Anagrafica non trovata"

	open c_prodotti;
	if sqlca.sqlcode = 0 then
		
		fetch c_prodotti into :k_codice, :k_des;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "codice", k_codice)
			tab_1.tabpage_1.dw_1.setitem(1, "des", k_des)
			tab_1.tabpage_1.dw_1.settext(k_des)
		else			
			k_des = "Anagrafica non trovata"
		end if
		close c_prodotti;
	end if
			
end if

k_return = 1

return k_return

end function

private function integer check_rek (string k_codice);//
int k_return = 0
int k_anno
string k_des
string k_codice_1



	SELECT 
         prodotti.des  
   	 INTO 
      	   :k_des  
    	FROM prodotti 
   	WHERE codice = :k_codice;

	if sqlca.sqlcode = 0 then

		if messagebox("Prodotto gia' in Archivio", & 
					"Vuoi modificare l'anagrafica "+ &
					trim(k_des), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = "mo"
			ki_st_open_w.key1 = string(k_codice,"@@@@@@@@@@@@")

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1
		end if
	end if  

	attiva_tasti()



return k_return


end function

private function integer check_rek_gruppo (integer k_codice);//
int k_return = 0
string k_des



	SELECT 
         des  
   	 INTO 
      	   :k_des  
    	FROM gru 
   	WHERE codice = :k_codice;

	if sqlca.sqlcode <> 0 then

		messagebox("Gruppo non in Archivio", & 
					"Codice Gruppo digitato non trovato in archivio "+ &
					trim(k_des), Exclamation!) 
		
		k_return = 1
	else
		tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "gruppo_1", k_des)
	end if

  

return k_return


end function

private function integer check_rek_iva (integer k_codice);//
int k_return = 0
string k_des



	SELECT 
         des  
   	 INTO 
      	   :k_des  
    	FROM iva 
   	WHERE codice = :k_codice;

	if sqlca.sqlcode <> 0 then

		messagebox("Codice IVA non in Archivio", & 
					"Codice IVA digitato non trovato in archivio "+ &
					trim(k_des), Exclamation!) 
		
		k_return = 1
	else
		tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "iva_1", k_des)
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
string  k_key, k_codice
int k_err_ins, k_rc
kuf_utility kuf1_utility
datawindowchild kdwc_iva,  kdwc_gruppo
//datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)


//--- Attivo dw archivio IVA cod
	tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve()
		kdwc_iva.insertrow(1)
	end if

////--- Attivo dw archivio IVA desc
//	tab_1.tabpage_1.dw_1.getchild("iva_1", kdwc_iva1)
//
//	kdwc_iva1.settransobject(sqlca)
//	kdwc_iva.rowscopy(kdwc_iva.GetRow(), kdwc_iva.RowCount(), Primary!, kdwc_iva1, 1, Primary!)


//--- Attivo dw archivio GRUPPI codice
	tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_gruppo)

	kdwc_gruppo.settransobject(sqlca)

	if kdwc_gruppo.rowcount() = 0 then
		kdwc_gruppo.retrieve(0)
		kdwc_gruppo.insertrow(1)
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
					"(ID cercato: " + trim(k_key) + ")~n~r" )
				post close(this)
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma l'Articolo non e' in archivio ~n~r" + &
						"(ID cercato: " + trim(k_key) + ")~n~r" )

					post close(this)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = kkg_flag_modalita.inserimento then
					messagebox("Trovata Anagrafica", &
						"Articolo gia' in archivio ~n~r" + &
						"(ID cercato: " + trim(k_key) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				//tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita =  kkg_flag_modalita.inserimento then

//	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	
end if


//--- Inabilita campi alla modifica se Vsualizzazione
//   if trim(ki_st_open_w.flag_modalita) = "vi" then
//		k_rc1 = ""
//		k_ctr=0
//		do while k_rc1 = ""
//			k_ctr = k_ctr + 1 
//			k_rc1=tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+".TabSequence='0'")
//
//			if k_rc1 = "" then
//				k_style=tab_1.tabpage_1.dw_1.Describe("#" + trim(string(k_ctr,"###"))+".Edit.Style")
//				if upper(k_style) <> "DDDW" then
//					k_rc1=string(rgb(192,192,192))
//					tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//					                 ".Background.Color='"+k_rc1+"'")
//					k_rc1=""
//				end if
//			end if
//
//		loop 
//	end if

		
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) =  kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(ki_st_open_w.flag_modalita) =  kkg_flag_modalita.modifica then
   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility

	
return "0"


end function

protected subroutine inizializza_2 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
date k_data 


if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if LenA(trim(k_codice)) = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
	end if

//=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
//		if tab_1.tabpage_3.dw_3.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_3.dw_3.reset()
//		end if
//	end if
	if tab_1.tabpage_3.dw_3.rowcount() < 1 then

//		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  

//=== Parametri : cliente, articolo
		k_data = relativedate(kg_dataoggi, -730)
		if tab_1.tabpage_3.dw_3.retrieve(k_codice, k_data) <= 0 then

//			inserisci()
		else
					
			attiva_tasti()

		end if				
	else
		attiva_tasti()
	end if

	//tab_1.tabpage_3.dw_3.setfocus()
	
end if


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


cb_inserisci.enabled = false
cb_aggiorna.enabled = true
cb_cancella.enabled = true

//cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			tab_1.tabpage_1.enabled = false
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
		else
			tab_1.tabpage_1.enabled = true
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

on w_prod.create
int iCurrent
call super::create
end on

on w_prod.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc


if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = "elenco" then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore

//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
		if kst_open_w.key2 = "d_prod_normative_l" and long(kst_open_w.key3) > 0 then
		
			kdsi_elenco_input = kst_open_w.key12_any 
		
			if kdsi_elenco_input.rowcount() > 0 then
	
				k_return = 1
				tab_1.tabpage_1.dw_1.setitem(1, "normative", &
								 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "normative"))
				attiva_tasti()
			end if
		end if

	end if

end if

return k_return

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_prod
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

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_prod
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

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_prod
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

type cb_ritorna from w_g_tab_3`cb_ritorna within w_prod
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

type st_stampa from w_g_tab_3`st_stampa within w_prod
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

type cb_visualizza from w_g_tab_3`cb_visualizza within w_prod
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

type cb_modifica from w_g_tab_3`cb_modifica within w_prod
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

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_prod
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

type cb_cancella from w_g_tab_3`cb_cancella within w_prod
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

type cb_inserisci from w_g_tab_3`cb_inserisci within w_prod
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

type tab_1 from w_g_tab_3`tab_1 within w_prod
boolean visible = true
integer y = 4
integer width = 2107
integer height = 1396
integer taborder = 0
integer weight = 0
long backcolor = 12632256
boolean raggedright = false
boolean focusonbuttondown = true
boolean showpicture = false
boolean boldselectedtext = false
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
integer width = 2071
integer height = 1268
long backcolor = 553648127
string text = "Articolo"
long picturemaskcolor = 553648127
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 104
integer width = 2071
integer height = 1156
integer taborder = 0
string title = ""
string dataobject = "d_prod_1"
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

event dw_1::itemchanged;call super::itemchanged;//
date k_data
string k_codice
int k_codice_n
string k_des
int k_errore=0


choose case upper(dwo.name)
	case "CODICE" 
		k_codice = trim(data)
		if isnull(k_codice) = false and LenA(trim(k_codice)) > 0 then
			k_errore = check_rek( k_codice ) 
		end if
	case "GRUPPO" 
		if isnumber(trim(data)) then
			k_codice_n = integer(trim(data))
			if not isnull(k_codice_n) and k_codice_n > 0 then
				k_errore = check_rek_gruppo( k_codice_n ) 
			end if
		end if
	case "IVA" 
		if isnumber(trim(data)) then
			k_codice_n = integer(trim(data))
			if not isnull(k_codice_n) and k_codice_n > 0 then
				k_errore = check_rek_iva( k_codice_n ) 
			end if
		end if

end choose 

return k_errore
	
end event

event dw_1::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


string nome = ' '
nome=dwo.name

if dwo.name = "normative_l_t" then

//--- crea il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

	choose case dwo.name
		case "normative_l_t"
//			if this.object.meca_num_int[this.getrow()] > 0 then
				kdsi_elenco_output.dataobject = "d_prod_normative_l" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_rc = kdsi_elenco_output.retrieve()
				kst_open_w.key1 = "  Norme e Aurorizzazioni legislative "  
//			end if
	end choose


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
integer width = 2071
integer height = 1268
long backcolor = 12632256
string text = "Listino"
long picturemaskcolor = 553648127
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 32
integer y = 200
integer width = 2981
integer height = 1196
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_clienti_listino"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
end type

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
integer width = 2071
integer height = 1268
long backcolor = 12632256
string text = "Movimenti"
long picturemaskcolor = 553648127
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 0
integer y = 52
integer width = 2967
integer height = 1180
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "d_armo_l_5"
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
string ki_dragdrop_display = ""
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
integer width = 2071
integer height = 1268
long backcolor = 553648127
string text = "tab"
long picturemaskcolor = 0
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
integer x = 0
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
string title = ""
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
integer width = 2071
integer height = 1268
long backcolor = 553648127
string text = "tab"
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer x = 0
integer y = 0
integer width = 2935
integer height = 1172
integer taborder = 0
string title = ""
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
integer width = 2071
integer height = 1268
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
integer width = 2071
integer height = 1268
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
integer width = 2071
integer height = 1268
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
integer width = 2071
integer height = 1268
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

type st_duplica from w_g_tab_3`st_duplica within w_prod
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

