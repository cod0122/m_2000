$PBExportHeader$w_riferim_dett_file.srw
forward
global type w_riferim_dett_file from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_riferim_dett_file from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3127
integer height = 1728
string title = "Barcode"
end type
global w_riferim_dett_file w_riferim_dett_file

type variables
datastore kdsi_elenco
end variables

forward prototypes
private subroutine inizializza_2 ()
private subroutine inizializza_3 ()
private subroutine inizializza_4 ()
protected subroutine inizializza_1 ()
private function integer check_rek (string k_codice)
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected function string aggiorna ()
protected subroutine inizializza ()
protected subroutine attiva_tasti ()
protected function string check_dati ()
end prototypes

private subroutine inizializza_2 ();//////======================================================================
////=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_id_cliente
//string k_scelta
//int k_rc
//datawindowchild kdwc_sl_pt, kdwc_t_contr
//
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
////--- Attivo dw archivio Piani Trattamento
//		k_rc=tab_1.tabpage_3.dw_3.getchild("cod_sl_pt", kdwc_sl_pt)
//	
//		k_rc=kdwc_sl_pt.settransobject(sqlca)
//
//		k_rc=kdwc_sl_pt.getchild("t_contr", kdwc_t_contr)
//		k_rc=kdwc_t_contr.settransobject(sqlca)
//	
//		if kdwc_t_contr.rowcount() = 0 then
//			kdwc_t_contr.retrieve("%")
//			kdwc_t_contr.insertrow(1)
//		end if
//	
//		if kdwc_sl_pt.rowcount() = 0 then
//			kdwc_sl_pt.retrieve("%", "*")
//			kdwc_sl_pt.insertrow(1)
//		end if
//
////=== Parametri : cliente, cliente, flag di solo rek della cliente
//		if tab_1.tabpage_3.dw_3.retrieve(k_codice, "*") <= 0 then
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
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
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

private subroutine inizializza_4 ();//////======================================================================
////=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_codice_4
//string k_scelta
//datawindowchild kdwc_ric, kdwc_fatt
//
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////--- Acchiappo il codice CLIENTE x evitare la rilettura
//if IsNumber(tab_1.tabpage_5.dw_5.Object.k_codice.Text) then
//	k_codice_4 = long(tab_1.tabpage_5.dw_5.Object.k_codice.Text)
//else
//	k_codice_4 = 0
//end if
////=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//tab_1.tabpage_5.dw_5.Object.k_codice.Text=string(k_codice, "####0")
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
//	if tab_1.tabpage_5.dw_5.rowcount() > 0 then
//		if k_codice_4 <> k_codice then 
//			tab_1.tabpage_5.dw_5.reset()
//		end if
//	end if
//
////--- Attivo dw archivio IVA
//	tab_1.tabpage_5.dw_5.getchild("clie_2", kdwc_ric)
//
//	kdwc_ric.settransobject(sqlca)
//
//	if kdwc_ric.rowcount() = 0 then
//		kdwc_ric.retrieve("%")
//		kdwc_ric.insertrow(1)
//	end if
//
////--- Attivo dw archivio TIPO PAGAMENTO
//	tab_1.tabpage_5.dw_5.getchild("clie_3", kdwc_fatt)
//
//	kdwc_fatt.settransobject(sqlca)
//
//	if kdwc_fatt.rowcount() = 0 then
//		kdwc_fatt.retrieve("%")
//		kdwc_fatt.insertrow(1)
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
end subroutine

protected subroutine inizializza_1 ();////======================================================================
////=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
////======================================================================
////
//string k_codice
//string k_scelta
//
//
////=== 
////tab_1.tabpage_4.dw_41.settransobject(sqlca)
//
//
//
//	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode")  
//		k_scelta = trim(ki_st_open_w.flag_modalita)
//
//////=== Se cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
////	if k_codice = 0 then
////		inserisci()
////		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
////	end if
//
////=== Se tab_2 non ha righe INSERISCI_TAB_2 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con il cliente allora resetto		
//		if tab_1.tabpage_2.dw_2.rowcount() > 0 then
//			if tab_1.tabpage_2.dw_2.getitemstring(1, "barcode") <> k_codice then 
//				tab_1.tabpage_2.dw_2.reset()
//			end if
//		end if
//	
//		if tab_1.tabpage_2.dw_2.rowcount() < 1 then
//	
////if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	
//
////	k_key = long(mid(st_parametri.text, 3, 10))
//
//
//
////=== Retrive 
//			if tab_1.tabpage_2.dw_2.retrieve(0, "*", k_codice) <= 0 then
//
////			inserisci()
//			else
//				attiva_tasti()
//			end if				
//		else
//			attiva_tasti()
//		end if
//	
//		tab_1.tabpage_2.dw_2.setfocus()
//		
//	end if
//	
//
//
//
end subroutine

private function integer check_rek (string k_codice);//
int k_return = 0
int k_anno
string k_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


	kst_tab_barcode.barcode = trim (k_codice)
	kuf1_barcode = create kuf_barcode
	k_esito = trim(kuf1_barcode.select_barcode(kst_tab_barcode))
	destroy kuf1_barcode

	if k_esito = "0" then

		if messagebox("BARCODE gia' in Archivio", & 
					"Vuoi modificare il BARCODE: ~n~r"+ &
					trim(k_codice)+ " del " + string(kst_tab_barcode.data, "dd/mm/yy"), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = "mo"
			ki_st_open_w.key1 = trim(k_codice) 

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1

		end if
	end if  

	attiva_tasti()



return k_return


end function

protected function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 "
date k_data
datetime k_datatime
string k_codice
long k_riga
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
//kuf_base kuf1_base


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

//=== Pulizia dei campi
	attiva_tasti()

//=== Aggiunge una riga al data windows
//	choose case tab_1.selectedtab 
//		case  1 
	
			tab_1.tabpage_1.dw_1.reset()
//			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//				tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
	
//				kdwc_cliente.settransobject(sqlca)
	
				k_riga = tab_1.tabpage_1.dw_1.insertrow(0)
			
//				tab_1.tabpage_1.dw_1.setitem(k_riga, "cod_sl_pt", "")
			
				tab_1.tabpage_1.dw_1.setcolumn(k_riga)
//			else
//				
//				k_riga = tab_1.tabpage_1.dw_1.getrow()
//--- pulizia campi
//				setnull(k_data)
//				setnull(k_datatime)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_barcode", "")
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_stampa", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_pl_barcode", "")
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_ini", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_fin", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_lav_ok", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_data_sosp", k_data)
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_utente", "")
//				k_rc = tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_datins", k_datatime)

//			end if
			
			tab_1.tabpage_1.dw_1.SetItemStatus(k_riga, 0, Primary!, new!)


			
//		case 2 // dati listino
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
////		case 3 // Listino
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
////				 
////			if k_id_cliente > 0 and k_codice > 0 then
////				tab_1.tabpage_3.dw_3.Modify("codice.CheckBox.On='"+ &
////										string(k_codice, "#####")+"'")
////
//////=== Parametri : commessa, cliente, flag di rek commessa + altri prot non abbinati
////				if tab_1.tabpage_3.dw_3.retrieve(k_codice, k_id_cliente, 1) > 0 then
////					tab_1.tabpage_3.dw_3.scrolltorow(1)
////					tab_1.tabpage_3.dw_3.setrow(1)
////					tab_1.tabpage_3.dw_3.setcolumn(1)
//////=== Imposto il protocollo messo in testata
////					k_id_protocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_protocollo")
////					if k_id_protocollo > 0 then 
////						k_ctr = tab_1.tabpage_3.dw_3.find("id_protocollo=" + &
////											string(k_id_protocollo, "#####"), 0, &
////											tab_1.tabpage_3.dw_3.rowcount())
////						if k_ctr > 0 then 
////							if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice") = 0 or & 
////								isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "codice")) then 
////							
////								tab_1.tabpage_3.dw_3.setitem(k_ctr, "codice", k_codice)
////							end if
////						end if
////					end if
////
////				end if
////			end if
////
//			
//		case 4 
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//	
////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
////
////				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
////				tab_1.tabpage_4.dw_4.setrow(k_riga)
////				tab_1.tabpage_4.dw_4.setcolumn(1)
////
//////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
//////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
//////
//////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
//////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
//////					tab_1.tabpage_4.dw_41.setrow(k_riga)
//////					tab_1.tabpage_4.dw_41.setcolumn(1)
//////				end if
////			end if
//			
////		case 5 // 
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
////	
//////			if k_codice > 0 then
////				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
////
////				tab_1.tabpage_4.dw_4.setitem(k_riga, "codice", k_codice)
////				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
////				tab_1.tabpage_4.dw_4.setrow(k_riga)
////				tab_1.tabpage_4.dw_4.setcolumn(1)
////
//////				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
//////					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
//////
//////					tab_1.tabpage_4.dw_41.setitem(k_riga, "codice", k_codice)
//////					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
//////					tab_1.tabpage_4.dw_41.setrow(k_riga)
//////					tab_1.tabpage_4.dw_41.setcolumn(1)
//////				end if
////			end if
//			
//	end choose	

	k_return = 0

end if

return (k_return)



end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe
date k_data


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()
//tab_1.tabpage_4.dw_41.accepttext()

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified!  &
		   or tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = DataModified!	 then 
			if (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_num_int")) or &
				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_num_int") = 0) &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

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

string k_return="0 ", k_errore="0 "
int k_riga
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	k_riga = tab_1.tabpage_1.dw_1.getrow( )
	kst_tab_barcode.num_int = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_num_int") 
	kst_tab_barcode.data_int = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "barcode_data_int") 
	kst_tab_barcode.fila_1 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") 
	kst_tab_barcode.fila_2 = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") 
	
	kuf1_barcode = create kuf_barcode
	k_errore = kuf1_barcode.tb_update_campo( kst_tab_barcode, "rifer_file_no_lav")
	destroy kuf1_barcode 
	
	if left(k_errore, 1) = "0" then

//=== Se tutto OK faccio la COMMIT		
		k_errore = kuf1_data_base.db_commit()
		if left(k_errore, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
		end if
	else
		k_errore = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" + "(" + trim(mid(k_errore, 2)) + ")" + "~n~r"
	end if
end if

//=== Aggiorna, se modificato, la TAB_2
if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore = kuf1_data_base.db_commit()
		if left(k_errore, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_2.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_3
if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_3.dw_3.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore = kuf1_data_base.db_commit()
		if left(k_errore, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_3.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_4
if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_4.dw_4.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore = kuf1_data_base.db_commit()
		if left(k_errore, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_4.text + mid(k_errore, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_4.text + "' ~n~r" 
	end if	
end if


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
protected subroutine inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string  k_key
string k_t_oper=""
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
long k_num_int
date k_data_int

kuf_utility kuf1_utility


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if long(trim(ki_st_open_w.key1)) > 0 and not isnull(ki_st_open_w.key1) then
		k_num_int = long(trim(ki_st_open_w.key1))
	else
		k_num_int = 0
	end if
	if len(trim(ki_st_open_w.key2)) > 0 then
		k_data_int = date(trim(ki_st_open_w.key2))
	else
		k_data_int = date(0)
	end if
	//flag: S=gia' stampati, non lavorati;
	if len(trim(ki_st_open_w.key3)) > 0 then
		k_t_oper = trim(ki_st_open_w.key3)
	else
		k_t_oper = "S" 
	end if

	k_key = trim(ki_st_open_w.key1) + " " + trim(ki_st_open_w.key2) + " " + trim(ki_st_open_w.key3)

	if len(trim(k_key)) = 0 then
		
		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_num_int, k_data_int, k_t_oper) 
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> "in" then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il Riferimento non e' in Archivio ~n~r" + &
						"(Codice ricercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta = "in" then
					cb_inserisci.postevent(clicked!)
				end if

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn(1)
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
end if


//===
//--- inabilito le mofidifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = "vi" &
	   or trim(ki_st_open_w.flag_modalita) = "ca" then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = "ca" then

		cb_cancella.postevent (clicked!)
		cb_ritorna.postevent(clicked!)
		
	end if
end if




end subroutine

protected subroutine attiva_tasti ();//
super::attiva_tasti()

cb_cancella.enabled = false

end subroutine
protected function string check_dati ();//
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


	if k_errore = "0" then
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") > 0  &
			and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") > 0 &
			then
			k_return = k_return + tab_1.tabpage_1.text + ": indicati giri per entrambe le File; " &
						  + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if

	if k_errore = "0" then
		if (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1") = 0  &
		   or isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_1")))   &
		   and  (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2") = 0 &
			 or isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "barcode_fila_2"))) then
			k_return = k_return + tab_1.tabpage_1.text + ": nessun 'giro' di trattamento indicato; " &
			           + "~n~r" 
			k_errore = "4"
			k_nr_errori++
		end if
	end if

//	if k_errore = "0" then
//	
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_datins", today())
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_x_utente", "Pwd:"+string(kg_pwd, "###"))
//		
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
on w_riferim_dett_file.create
int iCurrent
call super::create
end on

on w_riferim_dett_file.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event u_ricevi_da_elenco(st_open_w kst_open_w);call super::u_ricevi_da_elenco;//
//
int k_rc
long k_num_int, k_riga
date k_data_int
window k_window
kuf_menu_window kuf1_menu_window 


//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = "elenco" then
	

//--- Controllo che dalla window ELENCO non abbia premuto un tasto
		if kst_open_w.key5 = "b_dettaglio" then

//--- popolo il datasore (dw non visuale) di ritorno da window elenco
			kdsi_elenco = create datastore
//--- ricavo la data chiave dalla dw tornata dall'elenco
			kdsi_elenco = kst_open_w.key12_any 
			k_riga = long(kst_open_w.key3)
			k_data_int = kdsi_elenco.getitemdate(k_riga, "meca_data_int")
			k_num_int = kdsi_elenco.getitemnumber(k_riga, "meca_num_int")
				
//--- popolo il datasore (dw non visuale) per chiamare window elenco
			kdsi_elenco.dataobject = "d_barcode_l" 
			k_rc = kdsi_elenco.settrans ( sqlca )
			k_rc = kdsi_elenco.retrieve(k_num_int, k_data_int, "tutti",0,0,0)
			kst_open_w.key1 = "Dettaglio barcode "
		
			if kdsi_elenco.rowcount() > 0 then
		
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
				kst_open_w.key2 = trim(kdsi_elenco.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key12_any = kdsi_elenco
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window
			
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
			destroy kdsi_elenco 

		end if
			
			
	else

//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
		if kst_open_w.key2 = "d_meca_elenco" and long(kst_open_w.key3) > 0 then
		
			kdsi_elenco = kst_open_w.key12_any 
		
			if kdsi_elenco.rowcount() > 0 then
	
				tab_1.tabpage_1.dw_1.setitem(1, "barcode_num_int", &
								 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "meca_num_int"))
				tab_1.tabpage_1.dw_1.setitem(1, "barcode_data_int", &
								 kdsi_elenco.getitemdate(long(kst_open_w.key3), "meca_data_int"))
				tab_1.tabpage_1.dw_1.setitem(1, "meca_clie_1", &
								 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "meca_clie_1"))
				tab_1.tabpage_1.dw_1.setitem(1, "meca_clie_3", &
								 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "meca_clie_3"))
				tab_1.tabpage_1.dw_1.setitem(1, "clienti_rag_soc_10", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "clienti_rag_soc_10"))
				tab_1.tabpage_1.dw_1.setitem(1, "clienti_rag_soc_10_1", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "clienti_rag_soc_10_1"))
				tab_1.tabpage_1.dw_1.setitem(1, "meca_contratto", &
								 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "meca_contratto"))
				tab_1.tabpage_1.dw_1.setitem(1, "contratti_descr", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "contratti_descr"))
				tab_1.tabpage_1.dw_1.setitem(1, "contratti_sc_cf", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "contratti_sc_cf"))
				tab_1.tabpage_1.dw_1.setitem(1, "sl_pt_cod_sl_pt", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "contratti_sl_pt"))
				tab_1.tabpage_1.dw_1.setitem(1, "sl_pt_descr", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "contratti_descr"))
				tab_1.tabpage_1.dw_1.setitem(1, "meca_num_bolla_in", &
								 kdsi_elenco.getitemstring(long(kst_open_w.key3), "meca_num_bolla_in"))
				tab_1.tabpage_1.dw_1.setitem(1, "meca_data_bolla_in", &
								 kdsi_elenco.getitemdate(long(kst_open_w.key3), "meca_data_bolla_in"))
							
			end if
		end if

//--- se ho chiuso una finestra di Elenco Valori
		if kst_open_w.id_programma = "elenco" then
		
			if kst_open_w.key2 = "d_armo_elenco" and long(kst_open_w.key3) > 0 then
			
				kdsi_elenco = kst_open_w.key12_any 
			
				if kdsi_elenco.rowcount() > 0 then
		
					tab_1.tabpage_1.dw_1.setitem(1, "barcode_id_armo", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "id_armo"))
					tab_1.tabpage_1.dw_1.setitem(1, "armo_art", &
									 kdsi_elenco.getitemstring(long(kst_open_w.key3), "art"))
					tab_1.tabpage_1.dw_1.setitem(1, "prodotti_des", &
									 kdsi_elenco.getitemstring(long(kst_open_w.key3), "des"))
					tab_1.tabpage_1.dw_1.setitem(1, "armo_peso_kg", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "peso_kg"))
					tab_1.tabpage_1.dw_1.setitem(1, "armo_larg_2", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "armo_larg_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "armo_lung_2", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "armo_lung_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "armo_alt_2", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "armo_alt_2"))
					if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "armo_dose")) &
						or tab_1.tabpage_1.dw_1.getitemnumber(1, "armo_dose") = 0 &
						then
						tab_1.tabpage_1.dw_1.setitem(1, "armo_dose", &
									 kdsi_elenco.getitemnumber(long(kst_open_w.key3), "dose"))
				
					end if
					
				end if
			end if
		end if
	end if

end if
//


end event

type st_stampa from w_g_tab_3`st_stampa within w_riferim_dett_file
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_riferim_dett_file
integer x = 1152
integer y = 1440
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_riferim_dett_file
integer x = 768
integer y = 1440
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_riferim_dett_file
integer x = 2711
integer y = 1424
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_riferim_dett_file
integer x = 1970
integer y = 1424
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

type cb_cancella from w_g_tab_3`cb_cancella within w_riferim_dett_file
integer x = 2341
integer y = 1424
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_riferim_dett_file
integer x = 1600
integer y = 1424
boolean enabled = false
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

type tab_1 from w_g_tab_3`tab_1 within w_riferim_dett_file
integer x = 14
integer y = 32
integer width = 3040
integer height = 1396
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
boolean visible = false
integer width = 3003
integer height = 1268
string text = "Riferimento"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 201
integer y = 1192
long backcolor = 255
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 16
integer width = 2967
integer height = 1180
string dataobject = "d_riferim_dett_file"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::itemchanged;//
string k_codice
int k_errore=0

//
//choose case dwo.name 
//	case "barcode_barcode" 
//      k_codice = upper(trim(data))
//		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
//
//			k_errore = check_rek( k_codice ) 
//			
//		end if
//	case "rag_soc_10" 
//		check_cliente()
//		k_errore = 1
//end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event itemfocuschanged;//
	attiva_tasti()

end event

event dw_1::clicked;//
end event

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//
int k_rc
date k_data, k_data_int
long k_num_int
string k_cod_sl_pt
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


if dwo.name = "b_meca" or dwo.name = "b_armo" or dwo.name = "b_sl_pt" then
	
//--- ricavo la data di partenza della lista
	k_data = tab_1.tabpage_1.dw_1.getitemdate(row, "barcode_data")
	k_data = RelativeDate ( k_data, -365 )
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
	destroy kdsi_elenco 
	kdsi_elenco = create datastore
	if dwo.name = "b_meca" then
		kdsi_elenco.dataobject = "d_meca_elenco" 
		k_rc = kdsi_elenco.settransobject ( sqlca )
		k_rc = kdsi_elenco.retrieve(k_data, 0, 0, 0)
		kst_open_w.key1 = "Elenco Riferimenti ancora 'Aperti'"
	else
		if dwo.name = "b_armo" then
			kdsi_elenco.dataobject = "d_armo_elenco" 
			k_rc = kdsi_elenco.settransobject ( sqlca )
			k_data_int = tab_1.tabpage_1.dw_1.getitemdate(row, "barcode_data_int")
			k_num_int = tab_1.tabpage_1.dw_1.getitemnumber(row, "barcode_num_int")
			k_rc = kdsi_elenco.retrieve(k_num_int, k_data_int, 0, 0, 0)
			kst_open_w.key1 = "Elenco Articoli Riferimento: " + string(k_num_int, "####0") &
									+ " del " +  + string(k_data_int, "dd/mm/yy")   
		else
			kdsi_elenco.dataobject = "d_sl_pt" 
			k_rc = kdsi_elenco.settransobject ( sqlca )
			k_cod_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(row, "sl_pt_cod_sl_pt")
			k_rc = kdsi_elenco.retrieve(k_cod_sl_pt)
			kst_open_w.key1 = "Piano di Trattamento: " + trim(string(k_cod_sl_pt)) 
		end if
	end if

	if kdsi_elenco.rowcount() > 0 then

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
		kst_open_w.key2 = trim(kdsi_elenco.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco
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

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3003
integer height = 1268
string text = ""
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer width = 2981
integer height = 1228
boolean hscrollbar = true
boolean vscrollbar = true
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = false
integer x = 14
integer width = 2967
integer height = 1232
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

event dw_3::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_3::clicked;call super::clicked;This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_3::ue_dwnkey;//

end event

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
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

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = false
integer x = 5
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_4::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event dw_4::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_4::ue_dwnkey;//

end event

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
string text = ""
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = false
integer width = 2935
integer height = 1172
boolean enabled = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_5::clicked;call super::clicked;//
This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)
end if

end event

event dw_5::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

event dw_5::ue_dwnkey;//
end event

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

