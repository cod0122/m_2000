$PBExportHeader$w_ricevute.srw
forward
global type w_ricevute from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_ricevute from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3127
integer height = 1732
string title = "Scadenzario"
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_exit_dopo_update = true
end type
global w_ricevute w_ricevute

type variables
long ki_cod_cli=0
end variables

forward prototypes
private function string check_dati ()
protected function integer cancella ()
protected function integer inserisci ()
protected subroutine inizializza_1 ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected function string inizializza ()
private subroutine set_video_cliente (st_tab_clienti kst_tab_clienti)
protected subroutine attiva_tasti_0 ()
end prototypes

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_nr_righe, k_ctr
int k_riga
int k_nr_errori
string k_key_str
//string k_stato, k_tipo
date k_scad, k_data_fatt
long k_num_fatt, k_cliente
string k_rag_soc



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_scad = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_scad") 
	k_data_fatt = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_data_fatt") 
	k_num_fatt = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_num_fatt") 
	k_cliente = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_clie") 
	
	
	if isnull(k_scad) or k_scad = date("00/00/0000") then
		k_return = tab_1.tabpage_1.text + ": " + "Manca la Scadenza " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	else
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_clie")) = true then
			k_return = tab_1.tabpage_1.text + ": " + "Manca il Cliente " + "~n~r" 
			k_errore = "3"
			k_nr_errori++
		else	
			
			if k_scad <> date(trim(ki_st_open_w.key1))  &
			   or k_data_fatt <> date(trim(ki_st_open_w.key2)) &
				or k_num_fatt <> long(trim(ki_st_open_w.key3)) &
				or k_cliente <> long(trim(ki_st_open_w.key4)) then

				k_ctr = 0
				
				SELECT count(*),
					clienti.rag_soc_10
					INTO :k_ctr
						,:k_rag_soc
					FROM ric left outer join clienti on
						  ric.clie = clienti.codice
					WHERE scad = :k_scad
						and num_fatt = :k_num_fatt
						and data_fatt = :k_data_fatt
						and clie = :k_cliente
					group by clienti.rag_soc_10;
			
				if sqlca.sqlcode = 0 then
					if ki_st_open_w	.flag_modalita = kkg_flag_modalita.modifica then			
						if k_ctr > 1 then
							k_return = tab_1.tabpage_1.text + ": " + "Modifica di Scadenza già in archivio, cliente: " + trim(k_rag_soc)  + "~n~r"
							k_errore = "1"
							k_nr_errori++
						end if
					else
						if ki_st_open_w	.flag_modalita = kkg_flag_modalita.inserimento  then			
							k_return = tab_1.tabpage_1.text + ": " + "Scadenza già in archivio, cliente: " + trim(k_rag_soc)  + "~n~r"
							k_errore = "1"
							k_nr_errori++
						end if
					end if
				end if
			end if
		end if
	end if

	if LeftA(k_errore,1) = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_rata") > &
		   tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_importo") then 
			k_return =  tab_1.tabpage_1.text + ": " + "Rata maggiore dell'importo fattura " + "~n~r" 
			k_errore = "4"
			k_nr_errori++
		end if
		if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_scad") < &
		   tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_data_fatt") then 
			k_return = k_return + &
			   tab_1.tabpage_1.text + ": " + "Scadenza minore della data in fattura " + "~n~r" 
			k_errore = "4"
			k_nr_errori++
		end if
	end if

	if LeftA(k_errore,1) = "0" then
		if isnull(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "ric_tipo")) then
			tab_1.tabpage_1.dw_1.setitem( k_riga, "ric_flag_st", " ")
			tab_1.tabpage_1.dw_1.setitem( k_riga, "ric_tipo", " ")
		end if
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

protected function integer cancella ();////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_nro=0, k_id_fase, k_key
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data, k_data_fatt
long k_num_fatt, k_cliente
kuf_ricevute  kuf1_ricevute




//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Scadenza "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "ric_id")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "clienti_rag_soc_10")
				k_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "ric_scad")
				k_data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "ric_data_fatt")
				k_num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "ric_num_fatt")
				k_cliente = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "ric_clie")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza anagrafica cliente" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Scadenza~n~r" + &
					string(k_data) +  &
					"~n~rdi " + trim(k_desc) + " ?"
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
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_ricevute = create kuf_ricevute
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kuf1_ricevute.tb_delete(k_key) 
		end choose	
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
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

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_ricevute

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

protected function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_riga 
string k_codice
long k_cod_cli, k_num_fatt
date k_scad, k_data_fatt
int k_rc, k_taborder
string k_rc1, k_style
datawindowchild kdwc_clienti //, kdwc_cliente_1, kdwc_cliente_2 
kuf_base kuf1_base
kuf_utility kuf1_utility


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
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.deleterow(1)
				tab_1.tabpage_1.dw_1.resetupdate()
			end if
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setcolumn(1)
			
			ki_st_open_w.flag_modalita = "in"
			
			k_scad = date(trim(ki_st_open_w.key1)) //scadenza
			k_data_fatt = date(trim(ki_st_open_w.key2)) //data fattura
			k_num_fatt = long(trim(ki_st_open_w.key3)) //num fattura
			k_cod_cli = long(trim(ki_st_open_w.key4)) //cliente
			if not isnull(k_scad) then
				tab_1.tabpage_1.dw_1.setitem(1, "ric_scad", k_scad)
			end if
			if not isnull(k_data_fatt) then
				tab_1.tabpage_1.dw_1.setitem(1, "ric_data_fatt", k_data_fatt)
			end if
			if not isnull(k_num_fatt) then
				tab_1.tabpage_1.dw_1.setitem(1, "ric_num_fatt", k_num_fatt)
			end if
			if not isnull(k_cod_cli) then
				tab_1.tabpage_1.dw_1.setitem(1, "ric_clie", k_cod_cli)
			end if

//--- Attivo dw archivio Clienti
			k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_clienti)
	 		if	tab_1.tabpage_1.dw_1.rowcount() < 3 then
				kdwc_clienti.retrieve("%")
				kdwc_clienti.insertrow(1)
			end if	
			
	
//--- Inabilita campi alla modifica se Vsualizzazione
			kuf1_utility = create kuf_utility 
			if trim(ki_st_open_w.flag_modalita) = "vi" then
			
				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		
			else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
		
			end if
			destroy kuf1_utility

			
			
		case 2 // Listino
//			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
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
		case 3 // 
			
		case 4 // 
			
		case 5 // 
			
	end choose	

	attiva_tasti()

	k_return = 0

end if

return (k_return)



end function

protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice
string k_scelta
string k_codice_attuale, k_codice_prec


	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "ric_clie")  
	k_scelta = trim(ki_st_open_w.flag_modalita)

//=== Se nr.cliente non impostato forzo una INSERISCI 
	if k_codice = 0 or isnull(k_codice) then
		inserisci()
		k_codice = 0
	end if


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.Text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.Text
else
	k_codice_prec = " "
end if

	k_codice_attuale = trim(string(k_codice))

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
	tab_1.tabpage_2.st_2_retrieve.Text = k_codice_attuale

	if k_codice_attuale <> k_codice_prec then

//=== Parametri : cliente, articolo
		if tab_1.tabpage_2.dw_2.retrieve(  &
												"*", &
												"*", &
												date("01/01/1900"), &
												date("01/01/9999"), &
												k_codice, &
												"*", &
												date("01/01/1900"), &
												"S", &
												date("01/01/1900"), &
												date("01/01/9999") &
												)  <= 0 then

			inserisci()

		end if				
	end if

	attiva_tasti()

	tab_1.tabpage_2.dw_2.setfocus()
	

end subroutine

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


	tab_1.tabpage_1.dw_1.accepttext()
	tab_1.tabpage_2.dw_2.accepttext()
	tab_1.tabpage_3.dw_3.accepttext()
	tab_1.tabpage_4.dw_4.accepttext()
	tab_1.tabpage_5.dw_5.accepttext()
	//tab_1.tabpage_4.dw_41.accepttext()

	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_scad")) or &
				 tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "ric_scad") = date(0)) and &
				(isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_clie")) or &
				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "ric_clie") = 0) &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	end if


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

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
string k_codice_1, k_codice
string k_ret_code
kuf_base kuf1_base


//=== Salvo ID  originale x piu' avanti
//	k_codice_1 = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")

//=== Se non sono in caricamento allora imposto zero nel campo ID
//	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
//		tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "ric_id", 0)
//	end if

//=== No campi a NULL
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "ric_flag_st")) then
		tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "ric_flag_st", " ")
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

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
long  k_key
int k_err_ins, k_rc, k_taborder
string k_rc1, k_style, k_rag_soc, k_colore
int k_ctr, k_col
long k_cod_cli, k_num_fatt
date k_scad, k_data_fatt, k_data
datawindowchild kdwc_dist, kdwc_banca, kdwc_clienti, kdwc_fatt
kuf_utility kuf1_utility


//=== 

k_key = long((trim(ki_st_open_w.key1))) //ID numero ricevuta
//k_scad = date(trim(ki_st_open_w.key1)) //scadenza
//k_data_fatt = date(trim(ki_st_open_w.key2)) //data fattura
//k_num_fatt = long(trim(ki_st_open_w.key3)) //num fattura
//k_cod_cli = long(trim(ki_st_open_w.key4)) //cliente


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
//--- Attivo dw archivi: Clienti, Scadenzario, Fattura, Banche
	k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	kdwc_clienti.insertrow(1)
	k_rc = tab_1.tabpage_1.dw_1.getchild("ric_dist", kdwc_dist)
	k_rc = kdwc_dist.settransobject(sqlca)
	kdwc_dist.insertrow(1)
	k_rc = tab_1.tabpage_1.dw_1.getchild("ric_num_fatt", kdwc_fatt)
	k_rc = kdwc_fatt.settransobject(sqlca)
	kdwc_fatt.insertrow(1)
	k_rc = tab_1.tabpage_1.dw_1.getchild("ric_tipo", kdwc_banca)
	k_rc = kdwc_banca.settransobject(sqlca)
	kdwc_banca.insertrow(1)


//	if len(trim(k_key)) = 0 then
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Scadenza cercata :" + string(k_key) + ")~n~r" )
				post close(this)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = kkg_flag_modalita.modifica then
					messagebox("Ricerca fallita", &
						"Mi spiace ma la Anagrafica non e' in archivio ~n~r" + &
						"(ID Scadenza cercata :" + string(k_key) + ")~n~r" )

					close(this)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = kkg_flag_modalita.inserimento then
					messagebox("Trovata Anagrafica", &
						"La Anagrafica e' gia' in archivio ~n~r" + &
						"(ID Scadenza cercata :" + string(k_key) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()
				
				attiva_tasti()
		
		end choose

	end if


	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		k_scad = tab_1.tabpage_1.dw_1.getitemdate(1, "ric_scad")
		k_num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(1, "ric_num_fatt")
		k_data_fatt = tab_1.tabpage_1.dw_1.getitemdate(1, "ric_data_fatt")
		k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "ric_clie")
	end if

//--- Attivo dw archivio Clienti
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione then
		select rag_soc_10 into :k_rag_soc from clienti
		       where codice = :k_cod_cli;
		kdwc_clienti.retrieve(k_rag_soc)
		tab_1.tabpage_1.dw_1.setitem(1, "ric_clie", k_cod_cli)
	else
		kdwc_clienti.retrieve("%")
	end if	

	kdwc_clienti.insertrow(1)


//--- Attivo dw archivio Scadenzario
	if kdwc_dist.rowcount() < 2 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("ric_dist", kdwc_dist)
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = kdwc_dist.retrieve()
		end if

		kdwc_dist.insertrow(1)
	end if

//--- Attivo dw archivio FATTURA
	if kdwc_fatt.rowcount() < 2 then
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			if k_cod_cli > 0 and isnull(k_scad) and k_scad > date("01/01/1900") then
				k_data = relativeDate(k_scad, -365) 
				k_rc = kdwc_fatt.retrieve(k_cod_cli, k_data)
			end if
		end if
		kdwc_fatt.insertrow(1)
	end if

//--- Attivo dw archivio BANCHE
	if kdwc_banca.rowcount() < 2 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("ric_tipo", kdwc_banca)
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = kdwc_banca.retrieve(0)
		end if
		kdwc_banca.insertrow(1)
	end if



else
	attiva_tasti()
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then

//	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	
end if

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
return "0"
end function

private subroutine set_video_cliente (st_tab_clienti kst_tab_clienti);//
	tab_1.tabpage_1.dw_1.setitem(1, "clienti_rag_soc_10", kst_tab_clienti.rag_soc_10)
	tab_1.tabpage_1.dw_1.setitem(1, "ric_clie", kst_tab_clienti.codice)

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


super::attiva_tasti_0()

cb_inserisci.enabled = true
cb_aggiorna.enabled = true
cb_cancella.enabled = true
cb_modifica.enabled = false

//cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false
cb_modifica.default = false

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
			cb_modifica.enabled = true
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

on w_ricevute.create
int iCurrent
call super::create
end on

on w_ricevute.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_ricevute
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ricevute
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ricevute
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ricevute
integer x = 2711
integer y = 1444
end type

type st_stampa from w_g_tab_3`st_stampa within w_ricevute
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ricevute
integer x = 1010
integer y = 1448
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_ricevute
integer x = 581
integer y = 1448
end type

event cb_modifica::clicked;//
//=== 
string k_errore
long k_riga


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

if LeftA(k_errore, 1) = "0" then 
	
	k_riga = tab_1.tabpage_2.dw_2.getrow()
	ki_st_open_w.key1 = string(tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id"),"00000")
	
	tab_1.tabpage_1.dw_1.reset()
	inizializza()
	tab_1.selectedtab = 1

end if

end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ricevute
integer x = 1970
integer y = 1444
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ricevute
integer x = 2341
integer y = 1444
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ricevute
integer x = 1600
integer y = 1444
boolean enabled = false
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

type tab_1 from w_g_tab_3`tab_1 within w_ricevute
integer y = 32
integer width = 3040
integer height = 1396
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
integer width = 3003
integer height = 1268
string text = "Scadenza"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 12
integer width = 2967
integer height = 1244
string dataobject = "d_ricevute"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;int k_rc
long k_cod_cli, k_cod_cli_1, k_riga
date k_data
datawindowchild  kdwc_fatt, kdwc_cli



if dwo.name = "ric_num_fatt" then
	
	if LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(1, "clienti_rag_soc_10"))) > 0 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_cli)
//		if kdwc_cli.getrow() <= 0 then
			k_riga = kdwc_cli.find("rag_soc_1='" &
						+ trim(tab_1.tabpage_1.dw_1.getitemstring(1, "clienti_rag_soc_10")) &
			         + "'", & 
			         + 1, kdwc_cli.rowcount()) 
			if k_riga > 0 then
			   kdwc_cli.setrow(k_riga)
			end if
//		end if
		if kdwc_cli.getrow() > 0 then
			k_cod_cli = kdwc_cli.getitemnumber(kdwc_cli.getrow(), "id_cliente")
			if k_cod_cli > 0 then
				tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "clienti_rag_soc_10", &
							kdwc_cli.getitemstring(kdwc_cli.getrow(), "rag_soc_1"))
				tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "ric_clie", k_cod_cli)
	//	k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "ric_clie")
				k_data = relativedate(tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "ric_scad"), -365)
		
				if ki_st_open_w.flag_modalita <> "vi" and ki_cod_cli <> k_cod_cli then
	
					if kdwc_fatt.getrow() > 0 then
						k_cod_cli_1 = kdwc_fatt.getitemnumber(kdwc_fatt.getrow(), "arfa_clie_3")
					else
						k_cod_cli_1 = 0
					end if
	
					if k_cod_cli <> k_cod_cli_1 then
				
	//--- Attivo dw archivio lista fatture
						k_rc = tab_1.tabpage_1.dw_1.getchild("ric_num_fatt", kdwc_fatt)
						k_rc = kdwc_fatt.settransobject(sqlca)
				
						ki_cod_cli = k_cod_cli
						kdwc_fatt.retrieve(k_cod_cli, k_data)
						k_rc = kdwc_fatt.insertrow(1)
		
					end if
				end if
			end if
		end if 
	end if
	
	k_riga = kdwc_fatt.getrow()
	if k_riga <= 0 or isnull(k_riga) then
		tab_1.tabpage_1.dw_1.setitem(row, "ric_num_fatt", 0)
		tab_1.tabpage_1.dw_1.setitem(row, "ric_data_fatt", date(0))
	else
		tab_1.tabpage_1.dw_1.setitem(row, "ric_data_fatt", &
										kdwc_fatt.getitemdate(k_riga, "arfa_data_fatt"))
	end if
	
	
end if

end event

event dw_1::itemchanged;int k_errore=0
long k_riga, k_rc
long k_cod_cli, k_cod_cli_1
date k_data
string k_des
double k_rata
st_tab_ricevute kst_tab_ricevute
st_tab_clienti kst_tab_clienti
kuf_ricevute kuf1_ricevute
datawindowchild  kdwc_fatt, kdwc_cli



if dwo.name = "clienti_rag_soc_10" then
	
	k_des = upper(trim(data))
	if isnull(k_des) = false and LenA(trim(k_des)) > 0 then

		k_rc = tab_1.tabpage_1.dw_1.getchild("clienti_rag_soc_10", kdwc_cli)

		k_riga = kdwc_cli.find("rag_soc_1 like '"+trim(k_des)+"%' ",0,kdwc_cli.rowcount())
		if k_riga <= 0 or isnull(k_riga) then
			kst_tab_clienti.rag_soc_10 = trim(k_des)
			kst_tab_clienti.codice = 0
		else
			kst_tab_clienti.rag_soc_10 = kdwc_cli.getitemstring(k_riga, "rag_soc_1")
			kst_tab_clienti.codice = kdwc_cli.getitemnumber(k_riga, "id_cliente")
		end if
		
		post set_video_cliente(kst_tab_clienti)
		
	end if	
end if




//--- se ho scelto la fattura imposto Importo e Rata
if dwo.name = "ric_num_fatt" then

	if ki_st_open_w.flag_modalita <> "vi" then

//--- Attivo dw archivio lista fatture
		k_rc = tab_1.tabpage_1.dw_1.getchild("ric_num_fatt", kdwc_fatt)
		k_rc = kdwc_fatt.settransobject(sqlca)

		if kdwc_fatt.getrow() > 0 then
			if ki_st_open_w.flag_modalita = "in" &
			   or tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "ric_importo") = 0 &
			   or isnull(tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "ric_importo")) then
				
				tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "ric_importo", &
						kdwc_fatt.getitemnumber(kdwc_fatt.getrow(), "importo"))
	
			end if
			if ki_st_open_w.flag_modalita = "in" &
			   or tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "ric_rata") = 0 &
			   or isnull(tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "ric_rata")) then

				kuf1_ricevute = create kuf_ricevute
				
				k_rata = kuf1_ricevute.calcola_rata(&
					   kdwc_fatt.getitemnumber(kdwc_fatt.getrow(), "arfa_num_fatt"), &
					   kdwc_fatt.getitemdate(kdwc_fatt.getrow(), "arfa_data_fatt") &
                                    )
			   if k_rata > 0 then	
					tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "ric_rata", k_rata)
				end if
	
			end if
		end if

		k_riga = kdwc_fatt.getrow()
		if k_riga <= 0 or isnull(k_riga) then
			kst_tab_ricevute.num_fatt = 0
			kst_tab_ricevute.data_fatt = date(0)
			tab_1.tabpage_1.dw_1.setitem(row, "ric_data_fatt", date(0))
		else
			kst_tab_ricevute.data_fatt = kdwc_fatt.getitemdate(k_riga, "arfa_data_fatt")
			tab_1.tabpage_1.dw_1.setitem(row, "ric_data_fatt", kst_tab_ricevute.data_fatt)
		end if
		
	end if 
end if

return k_errore

end event

event dw_1::clicked;//

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 928
integer y = 1132
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
string text = "Scadenzario Cliente"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 2981
integer height = 1228
boolean enabled = true
string dataobject = "d_ric_l"
end type

event dw_2::doubleclicked;//
if row = 0 then
	return 1
end if
if cb_modifica.enabled = true then 
	cb_modifica.postevent(clicked!)
end if


end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
string text = "tab"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 2967
integer height = 1232
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
string text = "tab"
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
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
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
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
string text = "tab"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2935
integer height = 1172
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

