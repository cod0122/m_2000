$PBExportHeader$w_fatture.srw
forward
global type w_fatture from w_g_tab_3
end type
type dw_riga from uo_d_std_1 within w_fatture
end type
type dw_anno_numero from datawindow within w_fatture
end type
type dw_x_copia from uo_d_std_1 within w_fatture
end type
end forward

global type w_fatture from w_g_tab_3
boolean visible = true
integer width = 3479
integer height = 2412
string title = "Documento di Vendita"
event u_retrieve ( )
dw_riga dw_riga
dw_anno_numero dw_anno_numero
dw_x_copia dw_x_copia
end type
global w_fatture w_fatture

type variables
//
private kuf_fatt kiuf_fatt
private kuf_armo kiuf_armo 	
private kuf_clienti kiuf_clienti  

private datastore kdsi_elenco_sped
private datastore kdsi_elenco_lotti
private datastore kdsi_elenco_fatt

private st_tab_arfa kist_tab_arfa
private date ki_data_competenza

//--- progressivo righe dettaglio, serve x identificare una riga quando sono in 'modfica'
private int ki_progressivo_riga = 0

end variables

forward prototypes
protected function string aggiorna ()
protected subroutine attiva_tasti ()
protected function integer cancella ()
public function integer check_cliente ()
protected function string check_dati ()
public function boolean check_rek (long k_codice)
protected function string dati_modif (string k_titolo)
protected function string inizializza ()
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine elenco_sped_non_fatt ()
private subroutine elenco_lotti_non_fatt ()
private subroutine elenco_lotti_fatt ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_pagam (st_tab_clienti kst_tab_clienti)
private subroutine put_video_nazioni (st_tab_clienti kst_tab_clienti)
private subroutine call_indirizzi_commerciali ()
private subroutine riga_modifica ()
private subroutine riga_libera_aggiungi ()
protected subroutine inizializza_3 () throws uo_exception
private function boolean riga_gia_presente (st_tab_arfa kst_tab_arfa)
private function integer riga_nuova_in_lista (ref st_tab_arfa kst_tab_arfa, ref st_tab_meca kst_tab_meca) throws uo_exception
private subroutine riga_aggiorna_in_lista (integer k_riga, readonly st_tab_arfa kst_tab_arfa, readonly st_tab_meca kst_tab_meca, readonly st_tab_armo kst_tab_armo) throws uo_exception
private function integer riga_aggiungi_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception
private function integer riga_modifica_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception
private subroutine get_cliente_ddt_lotto ()
private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga)
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
long k_riga
st_tab_arfa kst_tab_arfa, kst_tab_arfa_app
st_tab_base kst_tab_base 
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp
st_esito kst_esito, kst_esito_BASE
kuf_sped kuf1_sped
kuf_base kuf1_base
pointer kpointer_1


kpointer_1 = setpointer(hourglass!) 

kuf1_base = create kuf_base
kuf1_sped = create kuf_sped


//	if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
//		k_new_rec = true
//	else
//		k_new_rec = false
//	end if

k_riga = tab_1.tabpage_1.dw_1.getrow()

//=== Aggiorna, se modificato, la TAB_1 o TAB_4	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 then

	try
	//--- Se sono in Inserimento verifico se numero fattura già usato
		if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
			kst_tab_arfa_app.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
			kst_tab_arfa_app.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt") 
			kst_tab_arfa_app.id_fattura = 0
			if kiuf_fatt.if_esiste_fattura( kst_tab_arfa_app ) then
				kiuf_fatt.get_ultimo_numero ( kst_tab_arfa_app ) 
				kst_tab_arfa.num_fatt = kst_tab_arfa_app.num_fatt + 1
	
				kguo_exception.setmessage( "Numero di Fattura iniziale modificato a " + string(kst_tab_arfa.num_fatt)  )
				kguo_exception.messaggio_utente( )
	
				tab_1.tabpage_1.dw_1.setitem(k_riga, "num_fatt", kst_tab_arfa.num_fatt )
	
			end if
		end if
		kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_fattura")
		if isnull(kst_tab_arfa.id_fattura) then kst_tab_arfa.id_fattura = 0
		kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
		kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_cliente")
		kst_tab_arfa.stampa = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stampa")
		kst_tab_arfa.data_stampa = tab_1.tabpage_1.dw_1.getitemdatetime(k_riga, "data_stampa")
		kst_tab_arfa.tipo_doc =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "tipo_doc")
		kst_tab_arfa.cod_pag =  tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "cod_pag")
		kst_tab_arfa.rag_soc_1  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_1")
		kst_tab_arfa.rag_soc_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_2")
		kst_tab_arfa.indi =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "indi")
		kst_tab_arfa.loc =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "loc")
		kst_tab_arfa.cap =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cap")
		kst_tab_arfa.prov =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "prov")
		kst_tab_arfa.id_nazione =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione")
		kst_tab_arfa.note_1 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_1")
		kst_tab_arfa.note_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_2")
		kst_tab_arfa.note_3 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_3")
		kst_tab_arfa.note_4 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_4")
		kst_tab_arfa.note_5 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_5")
		kst_tab_arfa.note_int_1 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1")
		kst_tab_arfa.note_int_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_2")
	
	//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then
	
		//--- Aggiorna la testa fattura
			kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
			if kst_tab_arfa.id_fattura = 0 then
				kst_esito = kiuf_fatt.tb_insert_testa( kst_tab_arfa )
				if kst_tab_arfa.id_fattura > 0 then
					tab_1.tabpage_1.dw_1.setitem (k_riga, "id_fattura", kst_tab_arfa.id_fattura )
				else
					kst_esito.esito = kkg_esito_db_ko  // fermo la registrazione della fattura ROLLBACK!
					kst_esito.sqlerrtext = "Non è stato generato il Contatore del Documento (id_fattura), ~n~r" + "impossibile proseguire con la registrazione!"
					kst_esito.sqlcode = 0
				end if
			else
				kst_esito = kiuf_fatt.tb_update_testa( kst_tab_arfa )
			end if
		
		//--- Se tutto OK carico le NOTE 	
			if kst_esito.esito <> kkg_esito_db_ko then
				kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
				kst_esito = kiuf_fatt.set_note(kst_tab_arfa )
			end if
			
		else
			
			kst_esito.esito = kkg_esito_ok
			
		end if
	
	catch	(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.esito = kkg_esito_db_ko
		
	end try
	

//--- Se tutto OK carico le righe di dettaglio 	
	if kst_esito.esito <> kkg_esito_db_ko then

		kst_tab_arfa.st_tab_g_0.esegui_commit = "N"

		k_riga = 1
		do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() and kst_esito.esito <> kkg_esito_db_ko
			
			kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")
			kst_tab_arfa.id_arfa_v = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")
			
			kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
			kst_tab_arfa.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp") 
			kst_tab_arfa.nriga = tab_1.tabpage_4.dw_4.getitemnumber(k_riga , "nriga") 
			kst_tab_arfa.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga,  "num_bolla_out") 
			kst_tab_arfa.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_bolla_out") 
			kst_tab_arfa.tipo_riga = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_riga") 
			kst_tab_arfa.des = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des") 
			kst_tab_arfa.iva = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "iva") 
			kst_tab_arfa.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli") 
			kst_tab_arfa.prezzo_u = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "prezzo_u") 
			kst_tab_arfa.prezzo_t = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "prezzo_t") 
			kst_tab_arfa.colli_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_out") 
			kst_tab_arfa.peso_kg_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp") 
			kst_tab_arfa.tipo_l = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_l") 
			kst_tab_arfa.id_arfa_se_nc = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa_se_nc") 
			kst_tab_arfa.art = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "art") 
			kst_tab_arfa.comm = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des") 
			kst_tab_arfa.stampa = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "stampa") 

//--- Aggiorna le righe fattura
			if kst_tab_arfa.id_arfa = 0 then
				kst_esito = kiuf_fatt.tb_insert_dett( kst_tab_arfa )
				tab_1.tabpage_4.dw_4.setitem (k_riga, "id_arfa", kst_tab_arfa.id_arfa )
			else
				kst_esito = kiuf_fatt.tb_update_dett ( kst_tab_arfa )
			end if

//--- Aggiorna lo stato delle righe si Spedizione a FATTURATO
			if kst_tab_arfa.id_arsp > 0 then
				kst_tab_arsp.st_tab_g_0.esegui_commit = "N"
				kst_tab_arsp.id_arsp = kst_tab_arfa.id_arsp
				kst_esito = kuf1_sped.set_riga_fatturata( kst_tab_arsp )
			end if		
			
			k_riga++

		loop
		
	end if

//--- Se tutto OK carico le righe di dettaglio 	
	if kst_esito.esito = kkg_esito_ok then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
			
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

//--- Aggiorna il NR. COLLI fatturati nel LOTTO			
			try 
				do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() and kst_esito.esito <> kkg_esito_db_ko
				
					kst_tab_arfa_app.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
					kst_tab_arfa_app.id_fattura = 0
					kst_tab_armo.colli_fatt = kiuf_fatt.get_colli_fatturati(kst_tab_arfa_app)
					kst_esito = kiuf_armo.set_colli_fatt(kst_tab_armo)
				
				loop
			catch (uo_exception kuo_exception1)
				kuo_exception1.messaggio_utente( )
				
			end try 

//--- aggiorna nel BASE il num. fattura se + grande di quello presente
			if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
				kst_tab_base.key = "num_fatt"
				kst_tab_base.num_fatt = integer(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
				if kst_tab_arfa.num_fatt > kst_tab_base.num_fatt then
					kst_tab_base.key1 = string(kst_tab_arfa.num_fatt )
					kst_esito_base = kuf1_base.metti_dato_base( kst_tab_base )
					
					if kst_esito_BASE.esito <> kkg_esito_ok then 
						k_return="1Fallito aggiornamento Proprietà Azienda del Numero Fattura, procedere manualmene ! " + " ~n~r" + trim(kst_esito_base.sqlerrtext) 
					end if
				end if
			end if
			
			
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio Fatture ! " + " ~n~r" + trim(kst_esito.sqlerrtext) 
	end if	
end if

setpointer(kpointer_1)

//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Completata !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if

destroy kuf1_base
destroy kuf1_sped


return k_return

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe

super::attiva_tasti()

tab_1.tabpage_2.enabled = false
tab_1.tabpage_3.enabled = false
tab_1.tabpage_4.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") > 0 then
		tab_1.tabpage_4.enabled = true
	end if
	
	choose case tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
		case 4 //righe
			cb_inserisci.enabled = false
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
			end if
//		case 4
//			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_inserimento then
//				cb_modifica.enabled = true
//				cb_inserisci.enabled = true
//				cb_aggiorna.enabled = true
//				cb_cancella.enabled = true
//			end if
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_cancellazione then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if

attiva_menu()


end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq, k_ctr
st_tab_arfa kst_tab_arfa
st_esito kst_esito


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Documento di Vendita "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
				kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
				k_record_1 = &
					"Sei sicuro di voler eliminare il Documento di Vendita~n~r" + &
					"numero " + string(kst_tab_arfa.num_fatt, "#######") +  &
					" del " + string(kst_tab_arfa.data_fatt) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				k_riga = 0
			end if
		end if
	case 4
		k_record = " Riga di dettaglio "
		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
//		if k_riga > 0 then
//			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
//				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
//				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_r_f_clie_3")
//				k_clie_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_1")
//				k_clie_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_2")
//				k_record_1 = &
//					"Sei sicuro di voler eliminare il legame con il~n~r" &
//					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
//					+ trim(string(k_clie_2)) + " ?"
//			else
//				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//			end if
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0  then
	
//=== Cancella la riga dal data windows di lista
	choose case tab_1.selectedtab 
		case 1 
//=== Richiesta di conferma della eliminazione del rek
			if messagebox("Elimina" + k_record, k_record_1, question!, yesno!, 2) = 1 then
				
				kst_esito = kiuf_fatt.tb_delete( kst_tab_arfa )   // CANCELLA FATTURA
				
			else
				messagebox("Elimina" + k_record,  "Operazione Annullata !!")
				k_return = 2
			end if
		case 4
//				k_errore = kiuf_fatt.tb_delete_riga( kst_tab_arfa )   
			kst_esito.esito = kkg_esito_ok
	end choose	
	if kst_esito.esito = kkg_esito_ok then

		k_errore = kuf1_data_base.db_commit()
		if left(k_errore, 1) <> "0" then
			k_return = 1
			messagebox("Problemi durante la Cancellazione !!", &
					"Controllare i dati. " + mid(k_errore, 2))

		else
			
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
				case 4 
					tab_1.tabpage_4.dw_4.deleterow(k_riga)
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

end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		if k_riga > 1 then
			if tab_1.tabpage_4.dw_4.rowcount() > k_riga then
				k_ctr = k_riga - 1
			else
				k_ctr = tab_1.tabpage_4.dw_4.rowcount()
			end if
			tab_1.tabpage_4.dw_4.selectrow( 0, false)
			tab_1.tabpage_4.dw_4.selectrow(k_ctr, true)
		else
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
				tab_1.tabpage_4.dw_4.selectrow(1, true)
			end if
		end if
			
		tab_1.tabpage_4.dw_4.setcolumn(1)
//		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
end choose	


return k_return

end function

public function integer check_cliente ();//
int k_return 
string k_rag_soc, k_rag_soc_10
long k_id_cliente


k_rag_soc_10 = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc_10) > 0 then

	declare c_clienti cursor for  
		SELECT 
  	     clienti.codice,  
  	     clienti.rag_soc_10  
    	FROM clienti  
   	WHERE upper(clienti.rag_soc_10) >= :k_rag_soc_10 
			order by clienti.rag_soc_10 ;

	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_id_cliente, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "codice", k_id_cliente)
			tab_1.tabpage_1.dw_1.setitem(1, "clienti_a_rag_soc_10", k_rag_soc)
			tab_1.tabpage_1.dw_1.settext(k_rag_soc)
		else			
			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_clienti;
	end if
			
end if

k_return = 1

return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
string k_errore = "0"
long k_nr_righe
int k_riga, k_ctr
int k_nr_errori 
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa, kst_tab_arfa_fatt
st_tab_iva kst_tab_iva
st_clienti_esenzione_iva kst_clienti_esenzione_iva
st_tab_sped kst_tab_sped
//kuf_armo kiuf_armo
kuf_sped kuf1_sped
kuf_ausiliari kuf1_ausiliari

//kuf_base kuf1_base


kuf1_ausiliari = create kuf_ausiliari

//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getrow()


	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_cliente")
	if kst_tab_arfa.clie_3 = 0 then
		k_return = tab_1.tabpage_1.text + ": Manca il codice Cliente " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if


//	if	k_errore = "0" then
//		if isnull(k_key) or k_key = 0 then
//			k_return = tab_1.tabpage_1.text + ": Il ID verra' assegnato automaticamente. " + "~n~r"
//			k_errore = "5"
//			k_nr_errori++
//		else
//		end if
//	end if
	
	
//--- controllo ESENZIONE	
	if  tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "k_iva_esente") = 1 &
			and tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "tipo_doc") <> kiuf_fatt.kki_tipo_doc_nota_di_credito then
				
		kst_tab_iva.codice =  tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva")
		kst_esito = kuf1_ausiliari.tb_select(kst_tab_iva)
		if kst_esito.esito = kkg_esito_ok and (kst_tab_iva.ALIQ = 0 or isnull(kst_tab_iva.ALIQ)) then  // se iva esente controllo


			kst_clienti_esenzione_iva.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")
			kst_clienti_esenzione_iva.data_fatt = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "data_fatt")
			kst_clienti_esenzione_iva.iva = kst_tab_iva.codice
			kst_clienti_esenzione_iva.importo_t = tab_1.tabpage_1.dw_1.object.k_tot_imponibile

			kst_esito = kiuf_clienti.esenzione_iva_controllo_fattura (kst_clienti_esenzione_iva)

			if kst_esito.esito <> kkg_esito_ok then
				k_return += tab_1.tabpage_1.text + ": Errore DB: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			else
				choose case  kst_clienti_esenzione_iva.ESITO
					case "1" //nessuna esenzione indicata sul cliente
						k_return = tab_1.tabpage_1.text + ": Attenzione: nessuna esenzione trovata, APPLICO l'IVA indicata: " + string(kst_clienti_esenzione_iva.IVA)+ ". ~n~r"
						k_errore = "2"
						k_nr_errori++
					case "2" //esenzione scaduta
						k_return = tab_1.tabpage_1.text + ": Esenzione NON APPLICATA scaduta il " + string(kst_clienti_esenzione_iva.IVA_VALIDA_AL)+ ". ~n~r"
						k_errore = "2"
						k_nr_errori++
						tab_1.tabpage_1.dw_1.setitem( k_riga, "k_iva_esente", 0 ) // Toglie l'esenzione
					case "3" //esenzione oltre l'importo massimo indicato su clienti
						k_return = tab_1.tabpage_1.text + ": Esenzione NON APPLICATA, oltre l'importo max di " &
									+ string(kst_clienti_esenzione_iva.iva_esente_imp_max) &
									+ ", il calcolato: " +string(kst_clienti_esenzione_iva.importo)+  ". ~n~r"
						k_errore = "2"
						k_nr_errori++
						tab_1.tabpage_1.dw_1.setitem ( k_riga, "k_iva_esente", 0 ) //Toglie l'esenzione
				end choose
			end if

		end if
	end if

	
//=== Controllo altro tab
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- verifica se ci sono righe di dettaglio		
		k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
		if k_nr_righe = 0 then
			
			kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_fattura")
			if kst_tab_arfa.id_fattura > 0 then
				 tab_1.tabpage_4.dw_4.retrieve(kst_tab_arfa.id_fattura)
			end if
			k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
			if k_nr_righe = 0 then
				k_return = tab_1.tabpage_1.text + ": Non ci sono righe caricate x questo documento " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
	end if
	
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		
		try 
			
//			kuf1_armo = create kuf_armo
			kuf1_sped = create kuf_sped
			
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		
			do while k_riga > 0  and k_nr_errori < 10
		
				if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
				
//--- se riga da bolla verifica il clie_3 su bolla
					if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "num_bolla_out") > 0 then
						kst_tab_sped.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "num_bolla_out") 
						kst_tab_sped.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_bolla_out") 
						kst_esito = kuf1_sped.get_clie( kst_tab_sped )
			
						if kst_esito.esito = kkg_esito_db_ko then
							k_return += tab_1.tabpage_1.text + ": Errore DB: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
							k_errore = "1"
							k_nr_errori++
						else
							if kst_esito.esito = kkg_esito_not_fnd  then
								k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Spedizione "+ string(kst_tab_sped.num_bolla_out) +" alla riga " + &
									string(k_riga, "#####") + " non Trovata~n~r" 
								k_errore = "3"
								k_nr_errori++
							else
								if kst_tab_sped.clie_3 <> kst_tab_arfa.clie_3 then 
									k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Cliente "+ string(kst_tab_sped.clie_3) +" in Spedizione "+ string(kst_tab_sped.num_bolla_out) &
										+" alla riga " + 	string(k_riga, "#####") + "n~r diverso da quello del documento (cod."+ string(kst_tab_arfa.clie_3) +")~n~r" 
									k_errore = "3"
									k_nr_errori++
								end if
							end if
						end if
					else
//--- se riga da LOTTO verifica il clie_3 su LOTTO altrimenti e' Riga VARIA
						kst_tab_armo.id_armo = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_armo") 
						if kst_tab_armo.id_armo > 0 then
							kst_esito = kiuf_armo.get_id_meca_da_id_armo( kst_tab_armo )
	
							if kst_esito.esito = kkg_esito_db_ko then
								k_return += tab_1.tabpage_1.text + ": Errore DB: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
								k_errore = "1"
								k_nr_errori++
							else
								kst_tab_meca.id = kst_tab_armo.id_meca
								kiuf_armo.get_clie( kst_tab_meca )
	
								if kst_tab_meca.clie_1 = 0  then
									k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Lotto id="+ string(kst_tab_meca.id) +" alla riga " + &
										string(k_riga, "#####") + " non Trovata~n~r" 
									k_errore = "3"
									k_nr_errori++
								else
									if kst_tab_meca.clie_3 > 0 then 
										if kst_tab_sped.clie_3 <> kst_tab_meca.clie_3 then 
											kiuf_armo.get_num_int( kst_tab_meca )  // piglio x informare anche il numero lotto
											k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Cliente "+ string(kst_tab_sped.clie_3) +" nel Lotto "+ string(kst_tab_meca.num_int) &
												+ " " + string(kst_tab_meca.data_int) +" alla riga " + 	string(k_riga, "#####") + "n~r diverso da quello del documento (cod."+ string(kst_tab_arfa.clie_3) +")~n~r" 
											k_errore = "3"
											k_nr_errori++
										end if
									end if
								end if
							end if
						end if
					end if

//--- codice IVA					
					if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "prezzo_t") > 0 &
							and tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "iva") = 0 &
							then
						k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Codice IVA alla riga " + &
						string(k_riga, "#####") + " non impostato~n~r" 
						k_errore = "3"
						k_nr_errori++
					end if
					
//--- Numero COLLI					
					kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_armo")
					k_ctr = 1
					k_ctr = tab_1.tabpage_4.dw_4.find( "id_armo="+string(kst_tab_arfa.id_armo), k_ctr, tab_1.tabpage_4.dw_4.rowcount() )
					kst_tab_arfa.colli = 0
					do while k_ctr > 0 
						kst_tab_arfa.colli = kst_tab_arfa.colli + tab_1.tabpage_4.dw_4.getitemnumber ( k_ctr, "colli")
						k_ctr++
						if k_ctr > tab_1.tabpage_4.dw_4.rowcount() then
							k_ctr = 0 
						else
							k_ctr = tab_1.tabpage_4.dw_4.find( "id_armo="+string(kst_tab_arfa.id_armo), k_ctr, tab_1.tabpage_4.dw_4.rowcount() )
						end if
					loop
					
					kst_tab_arfa.id_fattura = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_fattura")
					kst_tab_arfa_fatt.colli = kiuf_fatt.get_colli_fatturati(kst_tab_arfa) 
					
					kst_tab_armo.id_armo = kst_tab_arfa.id_armo
					kiuf_armo.get_colli_entrati( kst_tab_armo )
					
					if kst_tab_arfa.colli > (kst_tab_armo.colli_2 - kst_tab_arfa_fatt.colli)	then
						k_return = trim(k_return) + tab_1.tabpage_4.text + ": Troppi Colli in Fattura: "+ string(kst_tab_arfa.colli) + ", alla riga " + &
								string(k_riga, "#####") + " entrati: " + string(kst_tab_armo.colli_2) + ", gia' fatt.:" + string(kst_tab_arfa_fatt.colli) + " ~n~r" 
						k_errore = "1"
						k_nr_errori++
					end if
				end if
				
				k_riga++
		
				k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		
			loop
			
		catch (uo_exception kuo_exception)
				k_return += tab_1.tabpage_1.text + ": Errore DB-2: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally
//			destroy kuf1_armo
		end try
		
	end if

destroy kuf1_ausiliari
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

public function boolean check_rek (long k_codice);//
boolean k_return = false
st_tab_clienti kst_tab_clienti
st_esito kst_esito
//kuf_clienti kuf1_clienti


try 
	kist_tab_arfa.num_fatt = k_codice
	kist_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_fatt")
	if kiuf_fatt.if_esiste_fattura(kist_tab_arfa) then
		
//		kuf1_clienti = create kuf_clienti
		
		kst_tab_clienti.codice = kist_tab_arfa.clie_3
		kst_esito = kiuf_clienti.get_nome(kst_tab_clienti)
	
		if kst_esito.esito = kkg_esito_ok then
	
			if messagebox("Documento gia' in Archivio", "Vuoi modificare il documento di "+ &
						trim(kst_tab_clienti.rag_soc_10), question!, yesno!, 2) = 1 then
			
				ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica
				ki_st_open_w.key1 = string(k_codice,"0000000000")
	
				tab_1.tabpage_1.dw_1.reset()
				inizializza()
				
			else
				
				k_return = true
			end if
	
			attiva_tasti()
		end if  
		
//		destroy kuf1_clienti
		
	end if

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

return k_return


end function

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if & 
	 	(tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0  & 
		or tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0)  & 
		or (tab_1.tabpage_4.dw_4.rowcount() > 0 &
			and ( tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0  & 
 				or tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0)) & 
		then 

		if tab_1.tabpage_1.dw_1.rowcount( ) > 0  then
	
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
	end if


return k_return
end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_err_ins, k_rc
st_tab_clienti kst_tab_clienti
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer
kuf_utility kuf1_utility
datawindowchild  kdwc_1, kdwc_2



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kuo_exception = create uo_exception

//--- reset degli elenchi ddw
if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione and  ki_st_open_w.flag_modalita <> kkg_flag_modalita_cancellazione then

	tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_1)
	kdwc_1.settransobject(sqlca)
	kdwc_1.reset() 
	if kdwc_1.rowcount() = 0 then
		kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita_modifica then
		tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		if kdwc_1.rowcount() = 0 then
			kdwc_1.retrieve("%")
			kdwc_1.SetSort("id_cliente A")
			kdwc_1.sort( )
			kdwc_1.insertrow(1)
		end if
		tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
		kdwc_2.settransobject(sqlca)
		kdwc_2.reset() 
		if kdwc_2.rowcount() = 0 then
			kdwc_2.retrieve("%")
//			kdwc_2.RowsCopy(1, kdwc_2.RowCount(), Primary!, kdwc_1, 1, Primary!)
			kdwc_2.SetSort("rag_soc_10 A")
			kdwc_2.sort( )
		end if
		tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		if kdwc_1.rowcount() = 0 then
			kdwc_1.retrieve()
			kdwc_1.insertrow(1)
		end if
	end if

end if


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	kist_tab_arfa.id_fattura  = 0
	kist_tab_arfa.clie_3 = 0
	if isnumber(ki_st_open_w.key1) then
		kist_tab_arfa.id_fattura  = long(trim(ki_st_open_w.key1))
	end if
	if isnumber(ki_st_open_w.key2) then
		kist_tab_arfa.clie_3  = long(trim(ki_st_open_w.key2))
	end if

	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
		
		kist_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura
		kist_tab_arfa.data_fatt = kg_dataoggi
		k_err_ins = inserisci()

		if kist_tab_arfa.clie_3 > 0 then
			kst_tab_clienti.codice = kist_tab_arfa.clie_3 
			get_dati_cliente(kst_tab_clienti)
			put_video_cliente(kst_tab_clienti)
		end if
		
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(kist_tab_arfa.id_fattura) 
		
		choose case k_rc

			case is < 0		
				SetPointer(oldpointer)
				kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
				kuo_exception.setmessage(  &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
				kuo_exception.messaggio_utente( )	
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
					SetPointer(oldpointer)
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_not_fnd )
					kuo_exception.setmessage(  &
						"Mi spiace ma il Documento non e' in archivio ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
					kuo_exception.messaggio_utente( )	
					cb_ritorna.triggerevent("clicked!")
					
				else
					kist_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura
					kist_tab_arfa.data_fatt = kg_dataoggi
					k_err_ins = inserisci()
				end if
			case is > 0		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
					SetPointer(oldpointer)
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_allerta )
					kuo_exception.setmessage(  &
						"Attenzione, il Documento e' ga' in archivio ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
					kuo_exception.messaggio_utente( )	
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica

				end if
				if ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica then
//--- se fattura già STAMPATA allora ATTENZIONE alle Modifiche	!!!!!	
					if tab_1.tabpage_1.dw_1.getitemstring( 1, "stampa") = kiuf_fatt.kki_stampa_stampato then
//						ki_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione

						kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_allerta )
						kuo_exception.setmessage(  &
							"Attenzione, il Documento e' ga' stato Stampato. La Modifica potebbe comprometterne l'integrità. ~n~r" + &
							"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
						kuo_exception.messaggio_utente( )	
					end if
				end if	

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("fat1_note_1")

				
				attiva_tasti()
		
		end choose

	end if	

else
	attiva_tasti()
end if

//--- se primo giro imposta la data di competenza di default
if tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_st_open_w.flag_primo_giro = 'S' then
	tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	
end if

//if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta

//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_modifica &
	 		 and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then
	
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campi documento alla modifica se Funzione MODIFICA
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then
			kuf1_utility.u_proteggi_dw("1", "tipo_doc", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "num_fatt", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "data_fatt", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "id_cliente", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "rag_soc_10", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "p_iva", tab_1.tabpage_1.dw_1)
			kuf1_utility.u_proteggi_dw("1", "cf", tab_1.tabpage_1.dw_1)
		else
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
				kuf1_utility.u_proteggi_dw("1", "id_cliente", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "rag_soc_10", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "p_iva", tab_1.tabpage_1.dw_1)
				kuf1_utility.u_proteggi_dw("1", "cf", tab_1.tabpage_1.dw_1)
			end if				
		end if
		
	end if
	
	destroy kuf1_utility


//---- azzera il flag delle modifiche
	tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)


destroy kuo_exception

SetPointer(oldpointer)

return "0"


end function

protected function integer inserisci ();//
int k_return=0
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
kuf_base kuf1_base
//kuf_clienti kuf1_clienti

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


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			this.setredraw(false)
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				kist_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_fatt" ) 
				kist_tab_arfa.tipo_doc = tab_1.tabpage_1.dw_1.getitemstring( 1, "tipo_doc" ) 
				ki_data_competenza = tab_1.tabpage_1.dw_1.getitemdate( 1, "k_competenza_dal" ) 
			end if
	
			tab_1.tabpage_4.dw_4.reset() 
			tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
			tab_1.tabpage_1.dw_1.setitem( 1, "tipo_doc", kist_tab_arfa.tipo_doc)
			tab_1.tabpage_1.dw_1.setitem( 1, "stampa", kiuf_fatt.kki_stampa_da_stampare)
			tab_1.tabpage_1.dw_1.setitem( 1, "data_fatt", kist_tab_arfa.data_fatt )

			kuf1_base = create kuf_base
			kist_tab_arfa.num_fatt = long(mid(kuf1_base.prendi_dato_base( "num_fatt"),2))
			destroy kuf1_base
			kist_tab_arfa.num_fatt ++
			tab_1.tabpage_1.dw_1.setitem( 1, "num_fatt", kist_tab_arfa.num_fatt )
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
			
			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("id_cliente")

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

		
		case 4 // 
			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
				if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
						and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
					elenco_sped_non_fatt()
				else
					if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito  &
							and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
						elenco_lotti_non_fatt()
					else
						if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito then
							kG_menu.m_strumenti.m_fin_gest_libero3.enabled = true
						end if
					end if
				end if
			end if
			

//			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
//	
////=== Riempe indirizzo di Spedizione da DW_1
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
//	
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "m_r_f_clie_3", k_codice)
//	
//				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
//				tab_1.tabpage_4.dw_4.setrow(k_riga)
//				tab_1.tabpage_4.dw_4.setcolumn("clie_1")
//				
//			end if
			
	end choose	

	k_return = 0

//=== 
	attiva_tasti()

//end if

return (k_return)



end function

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	tab_1.tabpage_1.dw_1.accepttext()
end if
if tab_1.tabpage_4.dw_4.rowcount() > 0 then
	tab_1.tabpage_4.dw_4.accepttext()
end if

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = new! then 
			if (isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "des"))  &
				 	or len(trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "des"))) = 0) &
				then
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
//---- azzera il flag delle modifiche
				tab_1.tabpage_4.dw_4.SetItemStatus( k_riga, 0, Primary!, NotModified!)

			end if
		end if
		
	next


end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
long k_id_fattura_1
//string k_ret_code
//kuf_base kuf1_base



if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	k_ctr = 1
end if

if k_ctr > 0 then
	
//=== Salvo ID originale x piu' avanti
	k_id_fattura_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "id_fattura")

	if isnull(k_id_fattura_1) then				
		tab_1.tabpage_1.dw_1.setitem(k_ctr, "id_fattura", 0)
		k_id_fattura_1 = 0
	end if


	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 

		tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_fattura", k_id_fattura_1)

//=== Se non sono in caricamento allora prelevo l'ID dalla dw
		if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! then
			tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_arfa", 0)
		end if
	
	end for

end if

end subroutine

protected subroutine open_start_window ();//
//
	kiuf_fatt = create kuf_fatt
	kiuf_armo = create kuf_armo
	kiuf_clienti = create kuf_clienti

	
	kist_tab_arfa.data_fatt = kg_dataoggi

	ki_data_competenza = relativedate(kg_dataoggi, - 90)
	
	tab_1.tabpage_1.dw_1.object.b_ric_lotto.filename = kg_path_risorse + "\scadenzario.gif" 
	tab_1.tabpage_1.dw_1.object.b_contab.filename = kg_path_risorse + "\contabilita.gif" 

	dw_anno_numero.insertrow( 0 )
	dw_anno_numero.object.numero[1] = 0
	dw_anno_numero.object.anno[1]  = year(ki_data_competenza)

end subroutine

protected subroutine attiva_menu ();//
//kuf_clienti kuf1_clienti

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//

//=== 

	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Bolle di Spedizione da Fatturare "
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Elenco Bolle da Fatturare "
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
				and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
//				and tab_1.tabpage_4.enabled then
			kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero1.enabled = false
		end if
	else
		kG_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Bolle, Bolle da Fatturare  "
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Attestati di Trattamento da Fatturare "
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Elenco Attestati da Fatturare "
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito  &
				and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
//				and tab_1.tabpage_4.enabled then
			kG_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero2.enabled = false
		end if
	else
		kG_menu.m_strumenti.m_fin_gest_libero2.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Attestati, Attestati da Fatturare  "
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Fatture emesse "
	kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Elenco Fatture "
	kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito &
				and tab_1.tabpage_4.enabled then
			kG_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
		end if
	else
		kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = 	"Fatture, Fatture emesse "
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero4.text = "Aggiungi Riga Libera senza movimentazioni "
	kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Aggiungi Riga Libera "
	kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita_cancellazione &
				and tab_1.tabpage_4.enabled then
			kG_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		else
			kG_menu.m_strumenti.m_fin_gest_libero4.enabled = false
		end if
	else
		kG_menu.m_strumenti.m_fin_gest_libero4.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = 	"Libera, Nuova Riga Libera "
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	if ki_st_open_w.flag_primo_giro = 'S' then
		kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = kG_path_risorse + "\bolla.gif"
		kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "ScriptYes!"
		kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom048!"
		kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "DataManip!"
	end if
	
end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case LeftA(k_par_in, 2) 

	case "l1"		//Elenco Spedizioni da Fatturare
		elenco_sped_non_fatt()

	case "l2"		//Elenco Lotti già Attestati da Fatturare
		elenco_lotti_non_fatt()

	case "l3"		//Elenco Fatture x fare Nota di Credito
		elenco_lotti_fatt()

	case "l4"		//aggiungi riga libera
		riga_libera_aggiungi( )

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine elenco_sped_non_fatt ();//
//--- Fa l'elenco delle Spedizioni non fatturate (screma quelle già presenti in fattura)
//
long k_ind, k_riga
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
st_tab_arsp kst_tab_arsp
st_open_w kst_open_w 
//kuf_clienti kuf1_clienti
pointer kp_oldpointer  // Declares a pointer variable

	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if (kst_tab_arfa.clie_3) > 0 then
	
		kp_oldpointer = SetPointer(HourGlass!)

		kuf_menu_window kuf1_menu_window

		if not isvalid(kdsi_elenco_sped) then kdsi_elenco_sped = create datastore

		kdsi_elenco_sped.reset( )
		kst_tab_arfa.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
	
		kdsi_elenco_sped.dataobject = kiuf_fatt.kki_dw_sped_non_fatt
		kdsi_elenco_sped.settransobject ( sqlca )
		k_riga = kdsi_elenco_sped.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.data_bolla_out) 
		kst_open_w.key1 = "Elenco Bolle da fatturare a: " + string(kst_tab_arfa.clie_3)


		if kdsi_elenco_sped.rowcount() > 0 then

//-- screma elenco da righe già in fattura
			for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
				kst_tab_arfa.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "num_bolla_out")
				kst_tab_arfa.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate( k_ind, "data_bolla_out")
				kst_tab_arfa.colli = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "colli")
				if kst_tab_arfa.num_bolla_out > 0 then 
					k_riga = kdsi_elenco_sped.find( "num_bolla_out = " + string( kst_tab_arfa.num_bolla_out) + " and data_bolla_out = date('" + string( kst_tab_arfa.data_bolla_out) + "') ", &
																				 1, kdsi_elenco_sped.rowcount( ) )
					if k_riga > 0 then
						kst_tab_arsp.colli = tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "colli")
						if kst_tab_arsp.colli > kst_tab_arfa.colli then
							kst_tab_arsp.colli = kst_tab_arsp.colli - kst_tab_arfa.colli
							kdsi_elenco_sped.setitem( k_riga, "colli", kst_tab_arsp.colli)
						else
							kdsi_elenco_sped.deleterow( k_riga )
						end if
					end if
				end if
			next


//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita_elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_sped.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = " "    //--- nome del campo cliccato
			kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
			kst_open_w.key12_any = kdsi_elenco_sped
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		
			tab_1.selectedtab = 4
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if

		SetPointer(kp_oldpointer)

	else

		tab_1.selectedtab = 1

//--- se manca il CLIENTE allora chiedo il Numero Bolla per reperirlo
		dw_anno_numero.title = "Ricerca Cliente: indicare la Spedizione "
		dw_anno_numero.visible = true
		dw_anno_numero.setfocus()
	
	end if


end subroutine

private subroutine elenco_lotti_non_fatt ();//
//--- Fa l'elenco delle Entrate con Attestat ma non fatturate (screma quelle già presenti in fattura)
//
long k_ind, k_riga
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
st_open_w kst_open_w 
//kuf_clienti kuf1_clienti
pointer kp_oldpointer  // Declares a pointer variable


	kp_oldpointer = SetPointer(HourGlass!)

		kuf_menu_window kuf1_menu_window

		if not isvalid(kdsi_elenco_lotti) then kdsi_elenco_lotti = create datastore

		kdsi_elenco_lotti.reset( )

		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
		kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
		if (kst_tab_arfa.clie_3) > 0 then
	
			kdsi_elenco_lotti.dataobject = kiuf_fatt.kki_dw_righe_non_fatt 
			kdsi_elenco_lotti.settransobject ( sqlca )
			kdsi_elenco_lotti.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.data_fatt) 
			kst_open_w.key1 = "Elenco Lotti da fatturare a: " + string(kst_tab_arfa.clie_3)


			if kdsi_elenco_lotti.rowcount() > 0 then

//-- screma elenco da righe già in fattura
				for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_armo")
					if kst_tab_arfa.id_armo > 0 then 
						k_riga = kdsi_elenco_lotti.find( "id_armo = " + string( kst_tab_arfa.id_armo) + " " , 1, kdsi_elenco_lotti.rowcount( ) )
						if k_riga > 0 then
							 kdsi_elenco_lotti.deleterow( k_riga )
						end if
					end if
				next
	
	
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita_elenco
				kst_open_w.flag_adatta_win = KK_ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_lotti.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
				kst_open_w.key12_any = kdsi_elenco_lotti
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window
			
				tab_1.selectedtab = 4
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		end if




SetPointer(kp_oldpointer)


end subroutine

private subroutine elenco_lotti_fatt ();//
//--- Fa l'elenco delle Entrate fatturate (screma quelle già presenti in fattura)
//
long k_ind, k_riga
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
st_open_w kst_open_w 
//kuf_clienti kuf1_clienti
pointer kp_oldpointer  // Declares a pointer variable


	kp_oldpointer = SetPointer(HourGlass!)

		kuf_menu_window kuf1_menu_window

		if not isvalid(kdsi_elenco_fatt) then kdsi_elenco_fatt = create datastore

		kdsi_elenco_fatt.reset( )

		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
		kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
		if (kst_tab_arfa.clie_3) > 0 then
	
			kdsi_elenco_fatt.dataobject = kiuf_fatt.kki_dw_righe_non_fatt 
			kdsi_elenco_fatt.settransobject ( sqlca )
			kdsi_elenco_fatt.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.data_fatt) 
			kst_open_w.key1 = "Elenco Fatture di: " + string(kst_tab_arfa.clie_3)


			if kdsi_elenco_fatt.rowcount() > 0 then


//-- screma elenco da righe già in fattura
				for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_arfa")
					if kst_tab_arfa.id_arfa > 0 then 
						k_riga = kdsi_elenco_fatt.find( "id_arfa_se_nc = " + string( kst_tab_arfa.id_arfa) + " " , 1, kdsi_elenco_fatt.rowcount( ) )
						if k_riga > 0 then
							 kdsi_elenco_fatt.deleterow( k_riga )
						end if
					end if
				next
	
	
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita_elenco
				kst_open_w.flag_adatta_win = KK_ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_fatt.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
				kst_open_w.key12_any = kdsi_elenco_fatt
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window

				tab_1.selectedtab = 4
			
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		end if




SetPointer(kp_oldpointer)


end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
st_esito kst_esito
st_tab_nazioni kst_tab_nazioni
st_tab_pagam kst_tab_pagam
//kuf_ausiliari kuf1_ausiliari



tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )
tab_1.tabpage_1.dw_1.modify( "p_iva.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
tab_1.tabpage_1.dw_1.modify( "cf.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "cf", trim(kst_tab_clienti.cf) )
tab_1.tabpage_1.dw_1.modify( "id_nazione.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.id_nazione_1 )

tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice)
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_1.dw_1.setitem( 1, "loc_1", kst_tab_clienti.loc_1 )
tab_1.tabpage_1.dw_1.setitem( 1, "prov_1", trim(kst_tab_clienti.prov_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_1", kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c )
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_2", kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c )
tab_1.tabpage_1.dw_1.setitem( 1, "indi", kst_tab_clienti.kst_tab_ind_comm.indi_c )
tab_1.tabpage_1.dw_1.setitem( 1, "cap", kst_tab_clienti.kst_tab_ind_comm.cap_c )
tab_1.tabpage_1.dw_1.setitem( 1, "loc", kst_tab_clienti.kst_tab_ind_comm.loc_c )
tab_1.tabpage_1.dw_1.setitem( 1, "prov", kst_tab_clienti.kst_tab_ind_comm.prov_c )
tab_1.tabpage_1.dw_1.setitem( 1, "fattura_da", kst_tab_clienti.kst_tab_clienti_fatt.fattura_da )

tab_1.tabpage_1.dw_1.setitem( 1, "fat1_note_4", trim(kst_tab_clienti.kst_tab_clienti_fatt.note_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "fat1_note_5", trim(kst_tab_clienti.kst_tab_clienti_fatt.note_2) )

put_video_pagam(kst_tab_clienti)

attiva_tasti()

//kuf1_ausiliari = create kuf_ausiliari
//kst_tab_nazioni.id_nazione = kst_tab_clienti.id_nazione_1
//kst_esito = kuf1_ausiliari.tb_select( kst_tab_nazioni )
//if kst_esito.esito = kkg_esito_ok then
//	tab_1.tabpage_1.dw_1.setitem( 1, "nazioni_nome", kst_tab_nazioni.nome )
//end if
//destroy kuf1_ausiliari

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
//kuf_clienti kuf1_clienti


//	kuf1_clienti = create kuf_clienti

	kst_esito = kiuf_clienti.leggi (kst_tab_clienti)

	if kst_esito.esito <> kkg_esito_ok then

		kGuo_exception.set_esito( kst_esito )
		kGuo_exception.messaggio_utente()
		
	end if

//	destroy kuf1_clienti

return k_return


end function

private subroutine put_video_pagam (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Pagamento
//
long k_riga=0
datawindowchild kdwc_1



tab_1.tabpage_1.dw_1.modify( "cod_pag.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "cod_pag", kst_tab_clienti.cod_pag )

tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_1)
k_riga = kdwc_1.find( "codice = " + string(kst_tab_clienti.cod_pag) + " " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", kdwc_1.getitemstring(k_riga, "des")  )
else
	tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", " " )
end if



end subroutine

private subroutine put_video_nazioni (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati NAZIONE
//
long k_riga=0
datawindowchild kdwc_1


tab_1.tabpage_1.dw_1.modify( "id_nazione.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.id_nazione_1 )

tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
k_riga = kdwc_1.find( "id_nazione = '" + trim(kst_tab_clienti.id_nazione_1) + "' " , 1, kdwc_1.rowcount())
if k_riga > 0 then
	tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", kdwc_1.getitemstring(k_riga, "nome" ))
else
	tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
end if

end subroutine

private subroutine call_indirizzi_commerciali ();//
//--- Fa l'elenco Indirizzi Commerciali
//
st_open_w kst_open_w
string k_nome
kuf_menu_window kuf1_menu_window
datastore kds_1
pointer kp_oldpointer  // Declares a pointer variable


kp_oldpointer = SetPointer(HourGlass!)

	
	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = kiuf_fatt.kki_dw_elenco_indirizzi 
	kds_1.settransobject(sqlca) 
	
	kist_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
	if kist_tab_arfa.clie_3 > 0 then
		kds_1.retrieve( kist_tab_arfa.clie_3 )
	
		k_nome = tab_1.tabpage_1.dw_1.getitemstring( 1, "rag_soc_10")
		
		if kds_1.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita_elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Indirizzi Cliente: " + string( kist_tab_arfa.clie_3 ) + " " + trim(k_nome)
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kds_1
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		
		else
			messagebox("Elenco Dati", "Nessun valore disponibile. ")
			
		end if
	end if
						
SetPointer(kp_oldpointer)

	



		
		
		


end subroutine

private subroutine riga_modifica ();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_arfa kst_tab_arfa


	k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)
	if k_riga > 0 then
		kiuf_fatt.if_isnull_testa(kst_tab_arfa)
		kst_tab_meca.num_int = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "num_int" )
		kst_tab_meca.data_int = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_int" )
		kst_tab_arfa.nriga = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "nriga" )
		kst_tab_arfa.tipo_riga = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_riga" )
		kst_tab_arfa.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "num_bolla_out" )
		kst_tab_arfa.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_bolla_out" )
		kst_tab_armo.campione = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "campione" )
		kst_tab_arfa.art = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "art" )
		kst_tab_arfa.des = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des")
		kst_tab_arfa.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli")
		kst_tab_arfa.colli_out = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli_out" )
		kst_tab_arfa.prezzo_u = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "prezzo_u")
		kst_tab_arfa.iva = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "iva")
		kst_tab_arfa.prezzo_t = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "prezzo_t")
		kst_tab_arfa.tipo_l = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_l")
		kst_tab_arfa.id_fattura = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_fattura")
		kst_tab_arfa.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp")
		kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")
		kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo" )
		kst_tab_arfa.id_listino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino")
		kst_tab_arfa.id_arfa_se_nc = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa_se_nc")
		
	end if

	dw_riga.object.b_aggiungi.visible = false 
	dw_riga.object.b_aggiorna.visible = true 


	if kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_varia then
		dw_riga.triggerevent ("u_attiva_riga_varia")
		k_riga1=dw_riga.insertrow(0)
		dw_riga.setitem( k_riga1, "art", kst_tab_arfa.art )
		dw_riga.setitem( k_riga1, "comm", kst_tab_arfa.comm )
		dw_riga.setitem( k_riga1, "colli", kst_tab_arfa.colli )
		dw_riga.setitem( k_riga1, "prezzo_u", kst_tab_arfa.prezzo_u )
		dw_riga.setitem( k_riga1, "iva", kst_tab_arfa.iva )
		dw_riga.setitem( k_riga1, "prezzo_t", kst_tab_arfa.prezzo_t )
	else
		dw_riga.triggerevent( "u_attiva_riga_magazzino" )
		k_riga1=dw_riga.insertrow(0)
		dw_riga.setitem( k_riga1, "art", kst_tab_arfa.art )
		dw_riga.setitem( k_riga1, "des", kst_tab_arfa.des )
		dw_riga.setitem( k_riga1, "colli", kst_tab_arfa.colli )
		dw_riga.setitem( k_riga1, "colli_out", kst_tab_arfa.colli_out )
		dw_riga.setitem( k_riga1, "prezzo_u", kst_tab_arfa.prezzo_u )
		dw_riga.setitem( k_riga1, "iva", kst_tab_arfa.iva )
		dw_riga.setitem( k_riga1, "tipo_l", kst_tab_arfa.tipo_l )
		dw_riga.setitem( k_riga1, "prezzo_t", kst_tab_arfa.prezzo_t )
		dw_riga.setitem( k_riga1, "id_armo", kst_tab_arfa.id_armo )
	end if

	dw_riga.setitem(k_riga1, "tipo_riga", kst_tab_arfa.tipo_riga )
	dw_riga.setitem(k_riga1, "k_progressivo", tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "k_progressivo"))

//	if dw_riga.event u_retrieve() > 0 then

		dw_riga.event u_calcola_tot_iva( )
		
		dw_riga.visible = true		
		
//	end if
	
end subroutine

private subroutine riga_libera_aggiungi ();//======================================================================
//=== 
//======================================================================
//


//	if kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_varia then
		dw_riga.triggerevent ("u_attiva_riga_varia")
//	else
//		dw_riga.triggerevent( "u_attiva_riga_magazzino" )
//	end if

	dw_riga.triggerevent( "u_aggiungi") 
	dw_riga.setitem(dw_riga.getrow(), "tipo_riga", kiuf_fatt.kki_tipo_riga_varia)
	
		
	
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
int k_rc, k_ctr, k_nriga
st_tab_arfa kst_tab_arfa
kuf_utility kuf1_utility 



kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")  
k_scelta = trim(ki_st_open_w.flag_modalita)

if kst_tab_arfa.id_fattura > 0 then

	if tab_1.tabpage_4.dw_4.rowcount() < 1 then

//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_modifica &
			  and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
		end if
		destroy kuf1_utility

		if tab_1.tabpage_4.dw_4.retrieve(kst_tab_arfa.id_fattura) <= 0 then

//			inserisci()
			
		else
			k_nriga = 0
			for k_ctr = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
				ki_progressivo_riga ++
				tab_1.tabpage_4.dw_4.setitem(k_ctr, "k_progressivo", ki_progressivo_riga)
				kst_tab_arfa.nriga = tab_1.tabpage_4.dw_4.getitemnumber( k_ctr, "nriga")
				if kst_tab_arfa.nriga = 0 then
					kst_tab_arfa.nriga = k_nriga + 10
				end if
				tab_1.tabpage_4.dw_4.setitem(k_ctr, "nriga", kst_tab_arfa.nriga)
				k_nriga = kst_tab_arfa.nriga 
			end for

		end if				

	end if

//---- azzera il flag delle modifiche
	tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)

else

//	inserisci()
	
end if

tab_1.tabpage_4.dw_4.setfocus()

attiva_tasti()
	

end subroutine

private function boolean riga_gia_presente (st_tab_arfa kst_tab_arfa);//---
//--- Controllo se riga magazzino presente in questa fattura
//--- inp: kst_tab_arfa.id_armo
//--- out: boolean:   true=presente, false=non trovata
//
boolean k_return = false


	if kst_tab_arfa.id_armo > 0 then
		
		if kst_tab_arfa.id_arsp > 0 then
			if tab_1.tabpage_4.dw_4.find( "id_arsp = " + string(kst_tab_arfa.id_arsp) , 1, tab_1.tabpage_4.dw_4.rowcount() ) > 0 then
//			if tab_1.tabpage_4.dw_4.find( "num_bolla_out = " + string(kst_tab_arfa.num_bolla_out) + " and data_bolla_out = date('" + string(kst_tab_arfa.data_bolla_out) + "') " ,&
//													1, tab_1.tabpage_4.dw_4.rowcount() ) > 0 then
				k_return = true
			end if
		else		
			if tab_1.tabpage_4.dw_4.find( "id_armo = " + string(kst_tab_arfa.id_armo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) > 0 then
				k_return = true
			end if
		end if		
	end if

		
return k_return 	


end function

private function integer riga_nuova_in_lista (ref st_tab_arfa kst_tab_arfa, ref st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- aggiunge una riga nella fattura
//--- Inp: id_armo, colli  + eventuale num_bolla_out+data_bolla_out+id_arsp, id_arfa_se_nc
//--- out: numero della riga
//---
long k_riga=0
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
kuf_prodotti kuf1_prodotti
uo_exception kuo_exception


kuo_exception = create uo_exception

if riga_gia_presente (kst_tab_arfa) then
	kuo_exception.setmessage( "Riga già caricata nel Documento! (id="+string(kst_tab_arfa.id_armo)+")")
	throw kuo_exception
else
	
	k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
	
	if k_riga > 0 then

		kuf1_prodotti = create kuf_prodotti
	
		ki_progressivo_riga ++
		tab_1.tabpage_4.dw_4.setitem(k_riga, "k_progressivo", ki_progressivo_riga)
	
		kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")

//--- legge riga Lotto	
		kst_tab_armo.id_armo = kst_tab_arfa.id_armo
		kst_esito = kiuf_armo.leggi_riga("*", kst_tab_armo)
		if kst_esito.esito = kkg_esito_ok then
			kst_tab_arfa.art =  kst_tab_armo.art
			kst_tab_arfa.id_listino =  kst_tab_armo.id_listino
			kst_tab_meca.num_int = kst_tab_armo.num_int
			kst_tab_meca.data_int = kst_tab_armo.data_int
		else
			if kst_esito.esito = kkg_esito_db_ko then
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	
		kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_maga
		
		kst_tab_arfa.des = " "
		kst_tab_arfa.iva = 0
		kst_tab_prodotti.codice = kst_tab_arfa.art
		kst_esito = kuf1_prodotti.select_riga(kst_tab_prodotti )
		if kst_esito.esito = kkg_esito_ok then
			kst_tab_arfa.des = trim(kst_tab_prodotti.des)
			kst_tab_arfa.iva = kst_tab_prodotti.iva
		else
			if kst_esito.esito = kkg_esito_db_ko then
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	
		kiuf_fatt.if_isnull_testa(kst_tab_arfa)
	
//--- piglia il prezzo corretto
		kiuf_fatt.get_prezzo( kst_tab_arfa )

		kst_tab_arfa.colli_out = kst_tab_arfa.colli

//--- Calcola il prezzo totale di riga			
		kiuf_fatt.get_prezzo_t ( kst_tab_arfa )

//--- inserisce la riga in elenco	
		riga_aggiorna_in_lista (k_riga, kst_tab_arfa, kst_tab_meca, kst_tab_armo)  
	
	
		destroy kuf1_prodotti
	
	end if
end if

destroy kuo_exception	
		
		
	
return k_riga

	
end function

private subroutine riga_aggiorna_in_lista (integer k_riga, readonly st_tab_arfa kst_tab_arfa, readonly st_tab_meca kst_tab_meca, readonly st_tab_armo kst_tab_armo) throws uo_exception;//
//--- Display della Riga in Elenco
//
//double k_imp_iva=0, k_importo_riga=0
st_tab_iva kst_tab_iva
st_esito kst_esito
kuf_ausiliari kuf1_ausiliari
uo_exception kuo_exception



	kuf1_ausiliari = create kuf_ausiliari

//--- piglia l'aliquota IVA
	kst_tab_iva.codice = kst_tab_arfa.iva
	kuf1_ausiliari.tb_select( kst_tab_iva )
	if kst_esito.esito <> kkg_esito_ok then
		if kst_esito.esito = kkg_esito_db_ko then
			kuo_exception.set_esito( kst_esito )
			destroy kuf_ausiliari
			throw kuo_exception
		end if
	end if
	if isnull(kst_tab_iva.aliq) then kst_tab_iva.aliq = 0
 

//---calcolo Imponibile e Importo
//	k_imp_iva = kist_tab_arfa.prezzo_t * kst_tab_iva.aliq / 100
//	k_importo_riga = k_imp_iva + kist_tab_arfa.prezzo_t 

	tab_1.tabpage_4.dw_4.setitem(k_riga, "num_int"  ,kst_tab_meca.num_int )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "data_int"  ,kst_tab_meca.data_int )
	if kst_tab_arfa.nriga = 0 then
		if k_riga > 1 then
			tab_1.tabpage_4.dw_4.setitem(k_riga, "nriga"  ,(tab_1.tabpage_4.dw_4.getitemnumber(k_riga - 1, "nriga")+10))
		else
			tab_1.tabpage_4.dw_4.setitem(k_riga, "nriga"  ,10 )
		end if
	else
		tab_1.tabpage_4.dw_4.setitem(k_riga, "nriga"  ,kst_tab_arfa.nriga )
	end if
	tab_1.tabpage_4.dw_4.setitem(k_riga, "tipo_riga"  ,kst_tab_arfa.tipo_riga )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "num_bolla_out"  ,kst_tab_arfa.num_bolla_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "data_bolla_out"  ,kst_tab_arfa.data_bolla_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "campione"  ,kst_tab_armo.campione )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "art"  ,kst_tab_arfa.art )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "des"  ,kst_tab_arfa.des )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli"  ,kst_tab_arfa.colli )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli_out"  ,kst_tab_arfa.colli_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prezzo_u"  ,kst_tab_arfa.prezzo_u )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "tipo_l"  ,kst_tab_arfa.tipo_l )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "iva"  ,kst_tab_arfa.iva )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prezzo_t"  ,kst_tab_arfa.prezzo_t )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_fattura"  ,kst_tab_arfa.id_fattura )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arsp"  ,kst_tab_arfa.id_arsp )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arfa"  ,kst_tab_arfa.id_arfa )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_armo"  ,kst_tab_arfa.id_armo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino"  ,kst_tab_arfa.id_listino )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arfa_se_nc"  ,kst_tab_arfa.id_arfa_se_nc )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "iva_aliq" , kst_tab_iva.aliq )
	
	destroy kuf_ausiliari


	
end subroutine

private function integer riga_aggiungi_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception;//
//--- aggiunge una riga 
//
long k_riga=0


k_riga = tab_1.tabpage_4.dw_4.insertrow(0)

if k_riga > 0 then

	ki_progressivo_riga ++
	tab_1.tabpage_4.dw_4.setitem(k_riga, "k_progressivo", ki_progressivo_riga)

	

	kiuf_fatt.if_isnull_testa(kst_tab_arfa)

	riga_aggiorna_in_lista (k_riga, kst_tab_arfa, kst_tab_meca, kst_tab_armo)  

end if
	
	
return k_riga

	
end function

private function integer riga_modifica_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception;//
//--- aggiunge una riga 
//
long k_riga=0


k_riga = tab_1.tabpage_4.dw_4.find( "k_progressivo = " +  string(dw_riga.getitemnumber(dw_riga.getrow(), "k_progressivo")), 1,  tab_1.tabpage_4.dw_4.rowcount()) 

if k_riga > 0 then

	kiuf_fatt.if_isnull_testa(kst_tab_arfa)

	riga_aggiorna_in_lista (k_riga, kst_tab_arfa, kst_tab_meca, kst_tab_armo)  

end if
	
	
return k_riga

	
end function

private subroutine get_cliente_ddt_lotto ();//
//--- Piglia il codice cliente da DDT (bolla) o da LOTTO a seconda di quello indicato nel form
//
long k_riga
kuf_sped kuf1_sped 
st_tab_sped kst_tab_sped 
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_esito kst_esito
uo_exception kuo_exception


kuo_exception = create uo_exception

k_riga = tab_1.tabpage_1.dw_1.getrow( )
if k_riga > 0 then
	if tab_1.tabpage_1.dw_1.object.fattura_da[k_riga] = kiuf_clienti.kki_fattura_da_bolla then
		
		kst_tab_sped.num_bolla_out = dw_anno_numero.object.numero[1]
		if kst_tab_sped.num_bolla_out > 0 then
			kst_tab_sped.data_bolla_out = date (  dw_anno_numero.object.anno[1] , 01, 01)
			
			kuf1_sped = create kuf_sped
			kst_esito = kuf1_sped.get_clie(kst_tab_sped )
			destroy kuf1_sped
			if kst_esito.esito = kkg_esito_db_ko then
				kuo_exception.set_esito( kst_esito )
			else
				
				if kst_tab_sped.clie_3 > 0 then
					kst_tab_clienti.codice = kst_tab_sped.clie_3 
				end if
				
			end if
			
		end if		
	end if
end if

//--- Legge e imposta il cliente nel form
if kst_tab_sped.clie_3 > 0 then

	get_dati_cliente(kst_tab_clienti)
	put_video_cliente(kst_tab_clienti)

end if

destroy kuo_exception


		
end subroutine

private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga);//
//
int k_rc
long  k_riga1, k_ind_selected, k_ind
st_tab_arfa kst_tab_arfa
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp[]
st_esito kst_esito
kuf_sped kuf1_sped
//kuf_armo kuf1_armo
datawindowchild kdwc_1
uo_exception kuo_exception1
//window k_window
//kuf_menu_window kuf1_menu_window 




if long(k_riga) > 0 then 

//--- Se dalla w di elenco 'prevista'  ho fatto doppio-click	 x scegliere la riga	
	if tab_1.selectedtab = 1 then
		choose case kdw_source.dataobject 

//-- DROP nel TAB 4	
			case  kiuf_fatt.kki_dw_elenco_indirizzi 
			
				if kdw_source.rowcount() > 0 then
		
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1", &
									 kdw_source.getitemstring(long(k_riga), "rag_soc_1"))
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_2", &
									 kdw_source.getitemstring(long(k_riga), "rag_soc_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "indi", &
									 kdw_source.getitemstring(long(k_riga), "indi"))
					tab_1.tabpage_1.dw_1.setitem(1, "cap", &
									 kdw_source.getitemstring(long(k_riga), "cap"))
					tab_1.tabpage_1.dw_1.setitem(1, "loc", &
									 kdw_source.getitemstring(long(k_riga), "loc"))
					tab_1.tabpage_1.dw_1.setitem(1, "prov", &
									 kdw_source.getitemstring(long(k_riga), "prov"))
					tab_1.tabpage_1.dw_1.setitem(1, "id_nazione", &
									 kdw_source.getitemstring(long(k_riga), "id_nazione"))
					tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
					k_riga1 = kdwc_1.find( "id_nazione = " + trim(kdw_source.getitemstring(long(k_riga), "id_nazione")) + " " , 1, kdwc_1.rowcount())
					if k_riga1 > 0 then
						tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", kdwc_1.getitemstring(k_riga1, "nome" ) ) 
					else
						tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
					end if
									 
				end if
		
		end choose
	end if
	
//-- DROP nel TAB 4	
	if tab_1.selectedtab = 4 then

		choose case kdw_source.dataobject 
	
//--- se torno da elenco bolle non fatturate
			case  kiuf_fatt.kki_dw_sped_non_fatt 


				if kdw_source.rowcount() > 0 then
	
	//					kst_tab_arfa.colli = kdw_source.getitemnumber(long(k_riga), "colli")
	//					kst_tab_arfa.id_armo = kdw_source.getitemnumber(long(k_riga), "id_armo")
	//					kst_tab_arfa.id_arsp = kdw_source.getitemnumber(long(k_riga), "id_arsp")
	//					kst_tab_meca.id = kdw_source.getitemnumber(long(k_riga), "id_meca")	
	
					k_ind_selected = kdw_source.getselectedrow( 0 )
	//					kuf1_armo = create kuf_armo
					kuf1_sped = create kuf_sped
	
					do while k_ind_selected > 0 
						
						kst_tab_arfa.num_bolla_out = kdw_source.getitemnumber(k_ind_selected, "num_bolla_out")
						kst_tab_arfa.data_bolla_out = kdw_source.getitemdate(k_ind_selected, "data_bolla_out")
		
						kst_tab_arsp[1].num_bolla_out = kst_tab_arfa.num_bolla_out 
						kst_tab_arsp[1].data_bolla_out = kst_tab_arfa.data_bolla_out 
						kuf1_sped.get_righe(kst_tab_arsp[])
		
						for k_ind = 1 to upperbound(kst_tab_arsp[])
							
							if kst_tab_arsp[k_ind].id_arsp > 0 then
								
								try	
									
									kst_tab_armo.id_armo =  kst_tab_arsp[k_ind].id_armo
									kst_esito = kiuf_armo.get_id_meca_da_id_armo( kst_tab_armo )
									if kst_esito.esito = kkg_esito_db_ko then
										kuo_exception1.set_esito(kst_esito)
										kuo_exception1.messaggio_utente( )
										k_ind = upperbound(kst_tab_arsp[]) + 1
									else
										
										kst_tab_meca.id = kst_tab_armo.id_meca
										
										kst_tab_arfa.colli = kst_tab_arsp[k_ind].colli
										kst_tab_arfa.id_armo =  kst_tab_arsp[k_ind].id_armo
										kst_tab_arfa.id_arsp = kst_tab_arsp[k_ind].id_arsp
		
		//--- Aggiungi riga nel Documento										
										riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)		
										
									end if
			
								catch (uo_exception kuo_exception)
									kuo_exception.messaggio_utente( )
									k_ind = upperbound(kst_tab_arsp[]) + 1
								end try
								
							end if
		
						end for
						k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
					loop
					
		//					destroy kuf1_armo
					destroy kuf1_sped
					tab_1.tabpage_4.dw_4.selectrow( 0, false)
					tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
					tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
				end if
			
	
	//--- se torno da elenco Lotti con Attestato
			case  kiuf_fatt.kki_dw_righe_non_fatt 
		
				if kdw_source.rowcount() > 0 then
		
					kst_tab_arfa.id_armo = kdw_source.getitemnumber(long(k_riga), "id_armo")
					kst_tab_arfa.colli = kdw_source.getitemnumber(long(k_riga), "certif_colli")
					kst_tab_meca.id = kdw_source.getitemnumber(long(k_riga), "id_meca")	
					try	
						riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)			
		
						tab_1.tabpage_4.dw_4.setfocus()
						
					catch (uo_exception kuo_exception2)
						kuo_exception2.messaggio_utente( )
					end try
					tab_1.tabpage_4.dw_4.selectrow( 0, false)
					tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
					tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
									 
				end if
		
	//--- se torno da elenco Righe Fatturate (quando ad es. sono in N.C.)
			case  kiuf_fatt.kki_dw_righe_fatt 
		
				if kdw_source.rowcount() > 0 then
		
					kst_tab_arfa.id_armo = kdw_source.getitemnumber(long(k_riga), "id_armo")
					kst_tab_arfa.colli = kdw_source.getitemnumber(long(k_riga), "colli")
					kst_tab_arfa.id_arfa_se_nc = kdw_source.getitemnumber(long(k_riga), "id_arfa")
					kst_tab_meca.id = kdw_source.getitemnumber(long(k_riga), "id_meca")	
					try	
						riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)			
		
						tab_1.tabpage_4.dw_4.setfocus()
		
					catch (uo_exception kuo_exception3)
						kuo_exception3.messaggio_utente( )
					end try
					tab_1.tabpage_4.dw_4.selectrow( 0, false)
					tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
					tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
									 
				end if
			
		end choose
		
		tab_1.tabpage_4.dw_4.setfocus()
	end if
end if





end subroutine

on w_fatture.create
int iCurrent
call super::create
this.dw_riga=create dw_riga
this.dw_anno_numero=create dw_anno_numero
this.dw_x_copia=create dw_x_copia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_riga
this.Control[iCurrent+2]=this.dw_anno_numero
this.Control[iCurrent+3]=this.dw_x_copia
end on

on w_fatture.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_riga)
destroy(this.dw_anno_numero)
destroy(this.dw_x_copia)
end on

event close;call super::close;//
if isvalid(kiuf_fatt) then destroy kiuf_fatt
if isvalid(kiuf_armo) then destroy kiuf_armo
if isvalid(kiuf_clienti) then destroy kiuf_clienti

if isvalid(kdsi_elenco_input) then destroy kdsi_elenco_input 
if isvalid(kdsi_elenco_lotti) then destroy kdsi_elenco_lotti 
if isvalid(kdsi_elenco_sped) then destroy kdsi_elenco_sped 
if isvalid(kdsi_elenco_fatt) then destroy kdsi_elenco_fatt 


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long  k_riga, k_ind_selected, k_righe



if isvalid(kst_open_w) then

	if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
	if long(kst_open_w.key3) > 0 then 

		kdsi_elenco_input = kst_open_w.key12_any 
		k_riga = long(kst_open_w.key3)

//=== Valorizza l'oggetto DW per passarli all'evento di DROP
		dw_x_copia.dataobject = kdsi_elenco_input.dataobject
		k_righe = kdsi_elenco_input.rowcount()
		k_rc = kdsi_elenco_input.rowscopy(1,k_righe, Primary!, dw_x_copia,1, Primary! )
//---- valorizza i selezionati
		k_ind_selected = kdsi_elenco_input.getselectedrow( 0 )
		do while k_ind_selected > 0 
						
			dw_x_copia.selectrow( k_ind_selected, true)			
		
			k_ind_selected = kdsi_elenco_input.getselectedrow( (k_ind_selected) )
			
		loop
		
		this.dragdrop_dw_esterna( dw_x_copia, k_riga )
		
		kdsi_elenco_input.selectrow( 0, false)
		
	end if
end if


attiva_tasti()



end event

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_fatture
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_fatture
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_fatture
integer y = 1732
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_fatture
integer y = 1808
end type

type dw_trova from w_g_tab_3`dw_trova within w_fatture
integer x = 2277
integer y = 1524
end type

type dw_filtra from w_g_tab_3`dw_filtra within w_fatture
integer x = 2176
integer y = 1684
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_fatture
integer y = 1612
end type

event cb_visualizza::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 2 
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
				dw_riga.triggerevent( "u_visualizza")
			end if
			
	end choose



end event

type cb_modifica from w_g_tab_3`cb_modifica within w_fatture
integer y = 1708
end type

event cb_modifica::clicked;//


	choose case tab_1.selectedtab
		case 1
		case 2 
		case 4
			if tab_1.tabpage_4.dw_4.getselectedrow(0) > 0 then
				riga_modifica()		
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_fatture
integer y = 1708
end type

event cb_aggiorna::clicked;//
long k_id

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then


	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
	
	
//	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
		if tab_1.selectedtab <> 1 then 
			tab_1.selectedtab = 1
		end if
	
		inserisci()
		
	else
		cb_ritorna.postevent(clicked!)
	end if

////--- Disatt.moment.la funz.di 'aggiorna' fino a mod. un dato
//   tab_1.tabpage_1.dw_1.ki_disattiva_moment_cb_aggiorna = true
//	
//	if ki_fai_nuovo_dopo_update and cb_inserisci.enabled = true then
//		ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
//		cb_inserisci.postevent(clicked!)
//	else
//		if ki_fai_exit_dopo_update then
//			cb_ritorna.postevent(clicked!)
//		end if
//	end if

//else
//	POST attiva_tasti()
end if



end event

type cb_cancella from w_g_tab_3`cb_cancella within w_fatture
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_fatture
integer y = 1708
integer height = 92
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1   // clienti
			
			Super::EVENT Clicked()
			

		case 4
			inserisci() 
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
			   kuf1_utility = create kuf_utility 
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		        kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)
			    destroy kuf1_utility
			end if
			
			
	end choose
	

end event

type tab_1 from w_g_tab_3`tab_1 within w_fatture
boolean visible = true
integer x = 50
integer width = 3195
integer height = 1556
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3159
integer height = 1428
long backcolor = 32435950
string text = "Testata"
string picturename = "Custom081!"
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 28
integer width = 2953
integer height = 1308
string dataobject = "d_arfa_testata"
boolean ki_attiva_standard_select_row = false
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1

choose case dwo.name 

	case "rag_soc_10" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_cliente(kst_tab_clienti)
		end if

	case "p_iva", "cf" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
			k_nome = dwo.name + " like '" + trim(data) + "%" +"' " 
			k_riga = kdwc_1.find( k_nome, 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_cliente(kst_tab_clienti)
		end if

	case "cod_pag" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "codice = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.cod_pag =  long(trim(data))
				post put_video_pagam(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", " " )
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", " " )
		end if

	case "id_nazione" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_nazione = '" + trim(data) + "' " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.id_nazione_1 =  trim(data)
				post put_video_nazioni(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
		end if

//	case "fatture_da"
//		post attiva_tasti()
		
end choose 

	
end event

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//
datastore kds_1

	choose case dwo.name

	//--- elenco indirizzi commerciali
		case "b_indi"
			call_indirizzi_commerciali()
						
	end choose


//
end event

event dw_1::clicked;call super::clicked;////						
////
//
//	choose case dwo.name
//
//--- elenco scadenze
//		case "b_scadenze"
//			call_scadenze()
//
////--- elenco movimenti Profis
//		case "b_contab"
//			call_profis()
//
////--- dati cliente
//		case "b_cliente"
//			call_cliente()
//
//	end choose						
//						
////
		post attiva_tasti()

end event

event dw_1::ue_drop_out;call super::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3159
integer height = 1428
boolean enabled = false
string text = "usi futuri"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer width = 2939
integer height = 1320
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3159
integer height = 1428
boolean enabled = false
long backcolor = 33026800
string text = "no"
long tabbackcolor = 32435950
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 0
integer y = 28
integer width = 3141
integer height = 752
boolean enabled = true
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
end type

event dw_3::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Dati"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "1"
end if
//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 229
integer y = 1220
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3159
integer height = 1428
long backcolor = 32435950
string text = "Righe"
string picturename = "DataWindow5!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 41
integer y = 12
integer width = 3054
boolean enabled = true
string dataobject = "d_arfa_l_righe"
end type

event dw_4::itemchanged;call super::itemchanged;////
//string k_rag_soc, k_codice
//long k_rc, k_riga=0
//integer k_return=0
//datawindowchild kdwc_cli
//
//
//choose case upper(dwo.name)
//
//	case "CLIENTI_RAG_SOC_1" 
//
//		k_rag_soc = RightTrim(data)
//		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
//			
//			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
//			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
//			k_riga = k_rc
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", k_rag_soc+" - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", 0)
//			else
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
//			end if
//			
//		end if
//
//	
//	case "CLIENTI_RAG_SOC_2" 
//	
//		k_rag_soc = RightTrim(data)
//		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
//			
//			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
//			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
//			k_riga = k_rc
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", " - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
//			else
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
//			end if
//			
//		end if
//	
//		
//	case "CLIE_1" 
//	
//		if isnumber(Trim(data)) then
//			k_codice = Trim(data)
//		else
//			k_codice = "0"
//		end if
//		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
//			
//			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
//			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
//			k_riga = k_rc
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", " - NON TROVATO -")
////				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
//			else
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
//			end if
//			
//		end if
//		
//	case "CLIE_2" 
//	
//		if isnumber(Trim(data)) then
//			k_codice = Trim(data)
//		else
//			k_codice = "0"
//		end if
//		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
//			
//			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
//			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
//			k_riga = k_rc
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", k_rag_soc+" - NON TROVATO -")
////				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
//			else
//				k_return = 2
//				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
//			end if
//			
//		end if
//
//end choose
//
//
//return k_return
//
//
//
end event

event dw_4::itemfocuschanged;call super::itemfocuschanged;////
//long k_rc
//datawindowchild kdwc_clienti, kdwc_clienti_2
//
//if (dwo.name = "clienti_rag_soc_1" or dwo.name = "clienti_rag_soc_2"  &
//   or dwo.name = "clie_1" or dwo.name = "clie_2")  &
//	and ki_st_open_w.flag_modalita <> "vi" then
//
////--- Attivo dw archivio Clienti
//	k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_clienti)
//	k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_clienti_2)
//
////	k_rc = kdwc_clienti_d.settransobject(sqlca)
//
//	if kdwc_clienti.rowcount() < 2 then
//		kdwc_clienti.retrieve("%")
//		kdwc_clienti.insertrow(1)
//	end if
//
////--- copio le righe sulla seconda child clienti
//	kdwc_clienti.rowscopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), &
//				 		       Primary!, kdwc_clienti_2, 1, Primary!)
//
//
//end if
//
end event

event dw_4::ue_drop_out;call super::ue_drop_out;//
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
return 1

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3159
integer height = 1428
boolean enabled = false
string text = "no"
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2153
integer height = 1296
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3159
integer height = 1428
string text = "no"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer width = 2761
integer height = 1280
end type

event dw_6::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_6.dw_6.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_6.dw_6.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_6.dw_6.object.kcb_gr.text = "Dati"
	tab_1.tabpage_6.dw_6.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3159
integer height = 1428
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3159
integer height = 1428
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3159
integer height = 1428
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type dw_riga from uo_d_std_1 within w_fatture
event u_aggiungi ( )
event u_attiva_riga_magazzino ( )
event u_attiva_riga_varia ( )
event u_modifica ( )
event u_posiziona ( )
event type long u_retrieve ( )
event u_visualizza ( )
event u_intemchanged_riga_magazzino ( )
event u_intemchanged_riga_varia ( )
event u_calcola ( )
event u_calcola_tot_iva ( )
boolean visible = false
integer x = 681
integer y = 1856
integer width = 3072
integer height = 880
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Dettaglio Riga"
string dataobject = "d_arfa_v"
boolean controlmenu = true
boolean hsplitscroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event u_aggiungi();//======================================================================
//=== 
//======================================================================
//

	this.insertrow(0)

	this.object.b_aggiungi.visible = true 
	this.object.b_aggiorna.visible = false 

	this.visible = true		

end event

event u_attiva_riga_magazzino();//
	this.dataobject = "d_arfa_riga"
	this.settransobject( sqlca )
	this.object.b_armo.filename = kg_path_risorse + "\lotto_32x32.gif" 
	this.reset()
	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.setfocus()

end event

event u_attiva_riga_varia();//
	this.dataobject = "d_arfa_v"
//	this.settransobject( sqlca )
	this.reset()
	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.setfocus()
		
end event

event u_modifica();//======================================================================
//=== 
//======================================================================
//

	this.object.b_aggiungi.visible = false 
	this.object.b_aggiorna.visible = true 
	this.insertrow( 0)

end event

event u_posiziona();//
//--- posizione
//
this.x = parent.width / 4
this.y = parent.height / 4
//


end event

event type long u_retrieve();//======================================================================
//=== 
//======================================================================
//
long k_riga, k_riga_1=0
st_tab_arfa kst_tab_arfa



k_riga = tab_1.tabpage_4.dw_4.getrow()

if k_riga > 0 then
	if tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_riga")  = kiuf_fatt.kki_tipo_riga_varia then

		kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")  

		this.reset()
		
		if kst_tab_arfa.id_arfa > 0 then
//--- 
			k_riga_1 = this.retrieve( kst_tab_arfa.id_arfa)

		end if
	end if
end if

return k_riga_1


end event

event u_visualizza();//======================================================================
//=== 
//======================================================================
//
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility
	this.object.b_aggiorna.visible = false 
	this.object.b_aggiungi.visible = false 
     kuf1_utility.u_proteggi_dw("1", 0, dw_riga)
     kuf1_utility.u_proteggi_dw("1", "iva", dw_riga)
	destroy kuf1_utility
	
	
end event

event u_intemchanged_riga_magazzino();//
long k_riga, k_riga_1
double k_imp_iva, k_imp_tot 
st_tab_iva kst_tab_iva
datawindowchild kdwc_1


k_riga = this.getrow()
if k_riga > 0 then

	this.triggerevent("u_calcola")
	
end if

end event

event u_intemchanged_riga_varia();//
long k_riga, k_riga_1
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
datawindowchild kdwc_1
kuf_prodotti kuf1_prodotti


k_riga = this.getrow()
if k_riga > 0 then

	kuf1_prodotti = create kuf_prodotti

	this.getchild( "iva", kdwc_1)

	kst_tab_prodotti.codice = this.getitemstring(k_riga, "art")
	if len(trim(kst_tab_prodotti.codice)) > 0 then 
		kst_esito = kuf1_prodotti.select_riga( kst_tab_prodotti )
		if kst_esito.esito = kkg_esito_ok then
			this.setitem(k_riga, "comm", trim(kst_tab_prodotti.des))
			this.setitem(k_riga, "iva", kst_tab_prodotti.iva)
			k_riga_1 = kdwc_1.find("codice = '"+ string(kst_tab_prodotti.iva) + "' " ,1 ,kdwc_1.RowCount()) 
			if k_riga_1 > 0 then
				kdwc_1.setrow( k_riga_1 )
			else
				kdwc_1.setrow( 1 )
			end if
		else
			this.setitem(k_riga, "iva", 0)
			kdwc_1.setrow( 1 )
		end if
	else
		this.setitem(k_riga, "iva", 0)
		kdwc_1.setrow( 1 )
	end if
				
	this.triggerevent("u_calcola")
	
	destroy kuf1_prodotti
	
end if

end event

event u_calcola();//
long k_riga, k_riga_1
double k_imp_iva=0, k_imp_tot=0


k_riga = this.getrow()

if k_riga > 0 then
	
	if this.getitemstring(k_riga, "tipo_riga")  = kiuf_fatt.kki_tipo_riga_varia then

		kist_tab_arfa.prezzo_u = this.getitemnumber( k_riga, "prezzo_u")
		if isnull(kist_tab_arfa.prezzo_u) then kist_tab_arfa.prezzo_u = 0
		kist_tab_arfa.prezzo_t = this.getitemnumber( k_riga, "prezzo_t")
		if isnull(kist_tab_arfa.prezzo_t) then kist_tab_arfa.prezzo_t = 0
		kist_tab_arfa.colli = this.getitemnumber( k_riga, "colli")
		if isnull(kist_tab_arfa.colli) then kist_tab_arfa.colli = 0
		if kist_tab_arfa.prezzo_t = 0 then
			kist_tab_arfa.prezzo_t = kist_tab_arfa.prezzo_u * kist_tab_arfa.colli
		end if

	else

		kist_tab_arfa.prezzo_u = this.getitemnumber( k_riga, "prezzo_u")
		if isnull(kist_tab_arfa.prezzo_u) then kist_tab_arfa.prezzo_u = 0
		kist_tab_arfa.prezzo_t = this.getitemnumber( k_riga, "prezzo_t")
		if isnull(kist_tab_arfa.prezzo_t) then kist_tab_arfa.prezzo_t = 0
		kist_tab_arfa.colli = this.getitemnumber( k_riga, "colli")
		if isnull(kist_tab_arfa.colli) then kist_tab_arfa.colli = 0
		if kist_tab_arfa.prezzo_t = 0 then
			try
//--- Calcola il prezzo totale di riga			
				kist_tab_arfa.id_armo = this.getitemnumber( k_riga, "id_armo")
				kiuf_fatt.get_prezzo_t ( kist_tab_arfa )
			catch(uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try

		end if
	
	end if

	this.setitem( k_riga, "prezzo_t", kist_tab_arfa.prezzo_t)

//--- Calcolo dell'IVA e del totale Riga
	this.event u_calcola_tot_iva()

end if

end event

event u_calcola_tot_iva();//
long k_riga, k_riga_1, k_rc
double k_imp_iva=0, k_imp_tot=0
st_tab_iva kst_tab_iva
datawindowchild kdwc_1



k_riga = this.getrow()

if k_riga > 0 then
	
	this.getchild("iva", kdwc_1)
	kist_tab_arfa.prezzo_t = this.getitemnumber( k_riga, "prezzo_t")
	if isnull(kist_tab_arfa.prezzo_t) then kist_tab_arfa.prezzo_t = 0

	if kist_tab_arfa.prezzo_t > 0 then
	kst_tab_iva.codice = this.getitemnumber( k_riga, "iva")
		if kst_tab_iva.codice > 0 then
			k_riga_1 = kdwc_1.find("codice = "+ string(kst_tab_iva.codice) + " " ,1 ,kdwc_1.RowCount()) 

			if k_riga_1 > 0 then
				kst_tab_iva.aliq = kdwc_1.getitemnumber( k_riga_1, "aliq")
				if isnull(kst_tab_iva.aliq) then kst_tab_iva.aliq = 0
				
				k_imp_iva = kist_tab_arfa.prezzo_t * kst_tab_iva.aliq / 100
				k_imp_tot = k_imp_iva + kist_tab_arfa.prezzo_t 
			end if
		end if
	end if

	k_rc = this.setitem( k_riga, "k_imp_iva", (k_imp_iva))
	k_rc = this.setitem( k_riga, "k_imp_tot", (k_imp_tot))

end if

end event

event buttonclicked;call super::buttonclicked;//
long k_riga=0
st_tab_arfa kst_tab_arfa
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
//kuf_armo kuf1_armo



if dwo.name = "b_aggiungi" or dwo.name = "b_aggiorna" then

//	kuf1_armo = create kuf_armo

	kiuf_armo.if_isnull_meca( kst_tab_meca )
	kiuf_armo.if_isnull_armo( kst_tab_armo )

	k_riga = this.getrow( )
	if k_riga > 0 then
		kst_tab_arfa.art = this.getitemstring(k_riga, "art")
		kst_tab_arfa.colli = this.getitemnumber(k_riga, "colli")
		kst_tab_arfa.iva = this.getitemnumber(k_riga, "iva")
		kst_tab_arfa.prezzo_u = this.getitemnumber(k_riga, "prezzo_u")
		kst_tab_arfa.prezzo_t = this.getitemnumber(k_riga, "prezzo_t")
		kst_tab_arfa.tipo_riga = this.getitemstring(k_riga, "tipo_riga")
		
		if kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_maga then
			kst_tab_arfa.colli_out = this.getitemnumber( k_riga, "colli_out" )
			kst_tab_arfa.tipo_l = this.getitemstring( k_riga, "tipo_l" )
			kst_tab_arfa.id_armo = this.getitemnumber( k_riga, "id_armo")
			kst_tab_arfa.des = this.getitemstring(k_riga, "des")
		else
			kst_tab_arfa.comm = this.getitemstring(k_riga, "comm")
			kst_tab_arfa.des = this.getitemstring(k_riga, "comm")
		end if

		try
			if dwo.name = "b_aggiungi" then
				
				riga_aggiungi_in_lista(kst_tab_arfa, kst_tab_meca, kst_tab_armo )
				
			else
				riga_modifica_in_lista(kst_tab_arfa, kst_tab_meca, kst_tab_armo )
				
			end if
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
		
		end try
			
	end if
	
//	destroy kuf1_armo
	
end if

if dwo.name = "b_esci" then
	this.visible = false
end if

if dwo.name = "b_calcola" then
	this.event u_calcola()
end if

end event

event constructor;call super::constructor;//
this.postevent( "u_posiziona")
end event

event itemchanged;call super::itemchanged;//
long k_riga


k_riga = this.getrow()

if k_riga > 0 then
	if this.getitemstring(k_riga, "tipo_riga")  = kiuf_fatt.kki_tipo_riga_varia then

		this.postevent( "u_intemchanged_riga_varia" )
	else

		this.postevent( "u_intemchanged_riga_magazzino" )
		
	end if
end if


end event

event clicked;call super::clicked;////
//
//
//
//if dwo.name = "b_armo"  then
//	
//	try
//		
//		this.link_standard_call (dwo.name)
//
//	catch (uo_exception kuo_exception)
//	end try
//	
//end if
//
end event

type dw_anno_numero from datawindow within w_fatture
event u_posiziona ( )
boolean visible = false
integer x = 1906
integer y = 1308
integer width = 1513
integer height = 368
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_anno_numero"
boolean controlmenu = true
string icon = "Form!"
end type

event u_posiziona();//
//--- posizione
//
this.x = parent.width / 4
this.y = parent.height / 4
//

end event

event buttonclicked;//
if dwo.name = "b_ok" then
	
	this.visible = false
	this.accepttext()	
	get_cliente_ddt_lotto()
	
end if
end event

event constructor;//
this.postevent( "u_posiziona")
end event

type dw_x_copia from uo_d_std_1 within w_fatture
boolean visible = false
integer x = 123
integer y = 1808
integer width = 338
integer height = 368
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_possibile = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

