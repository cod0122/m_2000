$PBExportHeader$w_sc_cf.srw
forward
global type w_sc_cf from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_sc_cf from w_g_tab_3
int X=169
int Y=148
int Width=3127
int Height=1732
boolean TitleBar=true
string Title="Anagrafica Prodotto"
end type
global w_sc_cf w_sc_cf

forward prototypes
private subroutine inizializza ()
protected subroutine inizializza_1 ()
private subroutine inizializza_2 ()
private subroutine inizializza_3 ()
private function integer inserisci ()
private function string check_dati ()
private subroutine riempi_id ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
private subroutine pulizia_righe ()
private subroutine attiva_tasti ()
protected function string aggiorna ()
private function string dati_modif (string k_titolo)
private subroutine inizializza_4 ()
private function integer check_prod ()
private function integer check_rek (string k_codice)
end prototypes

private subroutine inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string  k_key, k_codice
int k_err_ins, k_rc
string k_rc1, k_style
int k_ctr
datawindowchild kdwc_iva, kdwc_gruppo
//datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)


//--- Attivo dw archivio IVA
	tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve(0)
		kdwc_iva.insertrow(1)
	end if

//--- Attivo dw archivio GRUPPI
	tab_1.tabpage_1.dw_1.getchild("gruppo", kdwc_gruppo)

	kdwc_gruppo.settransobject(sqlca)

	if kdwc_gruppo.rowcount() = 0 then
		kdwc_gruppo.retrieve(0)
		kdwc_gruppo.insertrow(1)
	end if

//	if len(trim(k_key)) = 0 then
	if ki_st_open_w.flag_modalita = "in" then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Anagrafica cercata :" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma la Anagrafica non e' in archivio ~n~r" + &
						"(ID anagrafica cercata :" + trim(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = "in" then
					messagebox("Trovata Anagrafica", &
						"La Anagrafica e' gia' in archivio ~n~r" + &
						"(ID anagrafica cercata :" + trim(k_key) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = "mo"

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = "in" then

//	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	
end if


//--- Inabilita campi alla modifica se Vsualizzazione
   if trim(ki_st_open_w.flag_modalita) = "vi" then
		k_rc1 = ""
		k_ctr=0
		do while k_rc1 = ""
			k_ctr = k_ctr + 1 
			k_rc1=tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+".TabSequence='0'")

			if k_rc1 = "" then
				k_style=tab_1.tabpage_1.dw_1.Describe("#" + trim(string(k_ctr,"###"))+".Edit.Style")
				if upper(k_style) <> "DDDW" then
					k_rc1=string(rgb(192,192,192))
					tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+&
					                 ".Background.Color='"+k_rc1+"'")
					k_rc1=""
				end if
			end if

		loop 
	end if




end subroutine

protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
string k_scelta


	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
	k_scelta = trim(ki_st_open_w.flag_modalita)

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if len(trim(k_codice)) = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
	end if

//=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//		if tab_1.tabpage_2.dw_2.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_2.dw_2.reset()
//		end if
//	end if
	if tab_1.tabpage_2.dw_2.rowcount() < 1 then

//		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  

//=== Parametri : cliente, articolo
		if tab_1.tabpage_2.dw_2.retrieve(0, k_codice) <= 0 then

			inserisci()
		else
					
			attiva_tasti()

		end if				
	else
		attiva_tasti()
	end if

	tab_1.tabpage_2.dw_2.setfocus()
	

end subroutine

private subroutine inizializza_2 ();//////======================================================================
////=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_id_cliente
//string k_scelta
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
////	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
////		if tab_1.tabpage_3.dw_3.getitemnumber(1, "codice") <> k_codice then 
////			tab_1.tabpage_3.dw_3.reset()
////		end if
////	end if
//	if tab_1.tabpage_3.dw_3.rowcount() < 1 then
//
////		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
//
////=== Parametri : cliente, cliente, flag di solo rek della cliente
//		if tab_1.tabpage_3.dw_3.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//					
//			attiva_tasti()
//
//		end if				
//	else
//		attiva_tasti()
//	end if
//
//	tab_1.tabpage_3.dw_3.setfocus()
//	
//
end subroutine

private subroutine inizializza_3 ();//////======================================================================
////=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_codice_4
//string k_scelta
//
//
//	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  

//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////--- Acchiappo il codice CLIENTE x evitare la rilettura
//if IsNumber(tab_1.tabpage_4.dw_4.Object.k_codice.Text) then
//	k_codice_4 = long(tab_1.tabpage_4.dw_4.Object.k_codice.Text)
//else
//	k_codice_4 = 0
//end if
////=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//tab_1.tabpage_4.dw_4.Object.k_codice.Text=string(k_codice, "####0")
//
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
//		if k_codice_4 <> k_codice then 
//			tab_1.tabpage_4.dw_4.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_4.dw_4.rowcount() < 1 then
////			if k_scelta <> "in" then
//
//		if tab_1.tabpage_4.dw_4.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
////			else
////				inserisci()
////			end if
//	else
//		attiva_tasti()
//
//	end if
//
//////=== Se tab_4 non ha righe INSERISCI_TAB_41 altrimenti controllo che righe sono
//////=== Se le righe presenti non c'entrano con la cliente allora resetto
////	if tab_1.tabpage_4.dw_41.rowcount() > 0 then
////		tab_1.tabpage_4.dw_41.accepttext()
////		if tab_1.tabpage_4.dw_41.getitemnumber(1, "codice") <> k_codice then 
////			tab_1.tabpage_4.dw_41.reset()
////		end if
////	end if
////
////	if tab_1.tabpage_4.dw_41.rowcount() < 1 then
////
////		if tab_1.tabpage_4.dw_41.retrieve(k_codice) <= 0 then
////
////			inserisci()
////		else
////			attiva_tasti()
////		end if				
////	else
////		attiva_tasti()
////	end if
////	
////	tab_1.tabpage_4.dw_41.setfocus()
////	
//
//	
//
//
//
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


if left(k_errore, 1) = "0" then


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
char k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key_str
char k_stato, k_tipo
string k_key



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "codice") 
	if isnull(k_key) or len(trim(k_key)) = 0 then
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
long k_righe, k_ctr
string k_codice_1, k_codice
string k_ret_code
kuf_base kuf1_base


//=== Salvo ID  originale x piu' avanti
	k_codice_1 = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
	else
		
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
					"Sei sicuro di voler eliminare la Anagrafica~n~r" + &
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
if k_riga > 0 and len(trim(k_key)) > 0 then
	
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
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							mid(k_errore1, 2) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + mid(k_errore, 2))
			end if

			attiva_tasti()

		end if

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

private subroutine leggi_altre_tab ();////
//long k_id_cliente, k_null, k_id_commessa
//datawindowchild kdwc_contatto, kdwc_protocollo
//
//
//	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
//	k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
//	if isnull(k_id_commessa) then
//		k_id_commessa = 0
//	end if
//
//	setnull(k_null)
//	tab_1.tabpage_1.dw_1.setitem(1, "id_contatto", k_null)
//	tab_1.tabpage_1.dw_1.setitem(1, "id_protocollo", k_null)
//
//	tab_1.tabpage_1.dw_1.getchild("id_contatto", kdwc_contatto)
//	kdwc_contatto.settransobject(sqlca)
//	tab_1.tabpage_1.dw_1.getchild("id_protocollo", kdwc_protocollo)
//	kdwc_protocollo.settransobject(sqlca)
//
//	if k_id_cliente > 0 then
//		kdwc_contatto.retrieve(k_id_cliente)
//		kdwc_protocollo.retrieve(k_id_cliente, k_id_commessa)
//	end if	
//	kdwc_contatto.insertrow(1)
//	kdwc_protocollo.insertrow(1)
//	
//	
end subroutine

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

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


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
            
attiva_menu()

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
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
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
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
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
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
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
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Movimenti " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
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
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Note Commessa " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Note Commessa'" + &
//					" ~n~r" 
//	end if	
//end if


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
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

		if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
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

private subroutine inizializza_4 ();//////======================================================================
////=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice
//string k_scelta
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_5 non ha righe INSERISCI_TAB_5 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_5.dw_5.rowcount() > 0 then
//		if tab_1.tabpage_5.dw_5.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_5.dw_5.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_5.dw_5.rowcount() < 1 then
////			if k_scelta <> "in" then
//
//		if tab_1.tabpage_5.dw_5.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
////			else
////				inserisci()
////			end if
//	else
//		attiva_tasti()
//
//	end if
//	
//
//
//
end subroutine

private function integer check_prod ();//
int k_return 
string k_des
string k_codice


k_des = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_des) > 0 then

	declare c_prodotti cursor for  
		SELECT 
  	     "prodotti"."codice",  
  	     "prodotti"."des"  
    	FROM "prodotti"  
   	WHERE ucase("prodotti"."des") >= :k_des 
			order by "prodotti"."des" ;

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

on w_sc_cf.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_sc_cf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sc_cf
int X=1175
int Y=1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sc_cf
int X=503
int Y=1436
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sc_cf
int X=2711
int Y=1444
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sc_cf
int X=1970
int Y=1444
end type

event cb_aggiorna::clicked;//

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then
	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//	dw_dett_0.reset()
//	dw_lista_0.setfocus()
	
	attiva_tasti()
	
////	inserisci()
//	if cb_inserisci.enabled = true then
//		cb_inserisci.triggerevent(clicked!)
//	end if
//
	
end if

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_sc_cf
int X=2341
int Y=1444
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sc_cf
int X=1600
int Y=1444
boolean Enabled=false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = left(dati_modif(parent.title), 1)

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
	
	if left(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_sc_cf
int Width=3040
int Height=1396
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="Capitolato"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
int X=265
int Y=1124
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
int Y=16
int Width=2967
int Height=1244
string DataObject="d_sc_cf"
end type

event itemchanged;//
date k_data
string k_codice
string k_des
int k_errore=0


choose case upper(dwo.name)
	case "CODICE" 
		k_codice = trim(data)
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			k_errore = check_rek( k_codice ) 
		end if
//	case "des" 
//		check_prodotti()
//		k_errore = 1
end choose 

return k_errore
	
end event

event dw_1::clicked;//
end event

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text=""
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
int X=0
int Width=2981
int Height=1228
boolean HScrollBar=true
boolean VScrollBar=true
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
int Width=2967
int Height=1232
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
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
int X=5
int Y=24
int Width=2939
int Height=1116
int TabOrder=10
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
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

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
int Width=2935
int Height=1172
boolean Visible=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type ln_1 from line within tabpage_4
boolean Enabled=false
int BeginX=361
int BeginY=2376
int EndX=2674
int EndY=2376
int LineThickness=4
end type

