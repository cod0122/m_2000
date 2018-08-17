$PBExportHeader$w_clienti.srw
forward
global type w_clienti from w_g_tab_3
end type
end forward

global type w_clienti from w_g_tab_3
boolean visible = true
integer width = 3355
integer height = 1836
string title = "Anagrafica "
long backcolor = 32435950
boolean ki_fai_nuovo_dopo_update = false
end type
global w_clienti w_clienti

type variables
//
private kuf_clienti kiuf_clienti
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
protected subroutine inizializza_3 () throws uo_exception
protected function integer inserisci ()
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
private subroutine call_elenco_capitolati ()
private subroutine call_elenco_fatture ()
private subroutine call_elenco_contratti ()
private subroutine call_elenco_listino ()
private subroutine call_elenco_stat_fatt ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine inizializza_6 () throws uo_exception
private function long retrieve_dw (st_tab_clienti kst_tab_clienti)
protected subroutine inizializza_2 () throws uo_exception
private subroutine put_video_mkt_cliente_link (st_tab_clienti kst_tab_clienti)
private subroutine put_video_mkt_contatti (integer k_nr_contatto, st_tab_clienti kst_tab_clienti)
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
boolean k_new_rec
st_tab_ind_comm kst_tab_ind_comm
st_tab_clienti kst_tab_clienti
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_clienti_web kst_tab_clienti_web


//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then

	if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
		k_new_rec = true
	else
		k_new_rec = false
	end if

	k_riga = tab_1.tabpage_1.dw_1.getrow()
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
			k_riga = tab_1.tabpage_1.dw_1.getrow()
			if k_riga > 0 then

//--- Se nuova riga Imposto il campo Contatore CODICE (SERIAL)				
				if k_new_rec then
					kiuf_clienti.get_ultimo_id(kst_tab_clienti)
					tab_1.tabpage_1.dw_1.setitem(tab_1.tabpage_1.dw_1.getrow(), "codice", kst_tab_clienti.codice)
					tab_1.tabpage_1.dw_1.resetupdate( )
				end if
				
				kst_tab_ind_comm.clie_c = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				kst_tab_ind_comm.rag_soc_1_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_rag_soc_1_c")
				kst_tab_ind_comm.rag_soc_2_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_rag_soc_2_c")
				kst_tab_ind_comm.indi_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_indi_c")
				kst_tab_ind_comm.loc_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_loc_c")
				kst_tab_ind_comm.cap_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_cap_c")
				kst_tab_ind_comm.prov_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "ind_comm_prov_c")
				kiuf_clienti.tb_update_ind_comm(kst_tab_ind_comm)
				
				kst_tab_clienti_fatt.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				kst_tab_clienti_fatt.fattura_da = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fattura_da")
				kst_tab_clienti_fatt.note_1 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1")
				kst_tab_clienti_fatt.note_2 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_2")
				kiuf_clienti.tb_update(kst_tab_clienti_fatt)
				
			end if
		end if
	else
		
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
	end if
end if 

//=== Aggiorna, se modificato, la TAB_3 MARKETING+WEB
if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 	then
	k_riga = 1

	tab_1.tabpage_3.dw_3.setitem(k_riga, "id_cliente", tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice"))
	
//--- marketing
	kst_tab_clienti_mkt.id_cliente = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_cliente")
	kst_tab_clienti_mkt.altra_sede = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_altra_sede")
	kst_tab_clienti_mkt.cod_atecori = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_cod_atecori")
	kst_tab_clienti_mkt.contatto_1_qualif = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_contatto_1_qualif")
	kst_tab_clienti_mkt.contatto_2_qualif = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_contatto_2_qualif")
	kst_tab_clienti_mkt.contatto_3_qualif = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_contatto_3_qualif")
	kst_tab_clienti_mkt.contatto_4_qualif = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_contatto_4_qualif")
	kst_tab_clienti_mkt.contatto_5_qualif = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_contatto_5_qualif")
	kst_tab_clienti_mkt.id_contatto_1 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_contatto_1")
	kst_tab_clienti_mkt.id_contatto_2 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_contatto_2")
	kst_tab_clienti_mkt.id_contatto_3 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_contatto_3")
	kst_tab_clienti_mkt.id_contatto_4 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_contatto_4")
	kst_tab_clienti_mkt.id_contatto_5 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_contatto_5")
	kst_tab_clienti_mkt.id_cliente_link = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "clienti_mkt_id_cliente_link")
	kst_tab_clienti_mkt.note_attivita = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_note_attivita")
	kst_tab_clienti_mkt.note_prodotti = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_note_prodotti")
	kst_tab_clienti_mkt.qualifica = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_qualifica")
	kiuf_clienti.tb_update(kst_tab_clienti_mkt)

//--- Dati WEB
	kst_tab_clienti_web.id_cliente = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_cliente")
	kst_tab_clienti_web.blog_web = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "blog_web")
	kst_tab_clienti_web.blog_web1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "blog_web1")
	kst_tab_clienti_web.email = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email")
	kst_tab_clienti_web.email1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email1")
	kst_tab_clienti_web.email2 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email2")
	kst_tab_clienti_web.note = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "note")
	kst_tab_clienti_web.sito_web = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "sito_web")
	kst_tab_clienti_web.sito_web1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "sito_web1")
	kiuf_clienti.tb_update(kst_tab_clienti_web)
	
end if



//=== Aggiorna, se modificato, la TAB_4 MANDANTI-RICEVENTI-FATTURATO
if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 	then
//	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 

	if tab_1.tabpage_4.dw_4.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_4.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
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
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


return k_return

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


//super::attiva_tasti()

//tab_1.tabpage_2.enabled = false
//tab_1.tabpage_3.enabled = false
//tab_1.tabpage_4.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "codice") > 0 then
		tab_1.tabpage_4.enabled = true
		tab_1.tabpage_5.enabled = true
		tab_1.tabpage_6.enabled = true
	end if
	
	choose case tab_1.selectedtab
		case 1, 3
			cb_aggiorna.enabled = true
		case 5 //listino
		   cb_visualizza.enabled = true
		case 6 //movimentazione
		   cb_visualizza.enabled = true
		case 4
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita_inserimento then
				cb_modifica.enabled = true
				cb_inserisci.enabled = true
				cb_aggiorna.enabled = true
				cb_cancella.enabled = true
			end if
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

protected function integer cancella ();
////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Cliente "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "rag_soc_10")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza ragione sociale" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Anagrafica~n~r" + &
					string(k_key, "#####") +  &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	case 4
		k_record = " Associazione Anagrafiche "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "m_r_f_clie_3")
				k_clie_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_1")
				k_clie_2 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "clie_2")
				k_record_1 = &
					"Sei sicuro di voler eliminare il legame con il~n~r" &
					+ "Mandante " + trim(string(k_clie_1)) + "  e  il Ricevente " &
					+ trim(string(k_clie_2)) + " ?"
			else
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kiuf_clienti.tb_delete(k_key) 
			case 4
				kst_tab_clienti_m_r_f.clie_1 = k_clie_1
				kst_tab_clienti_m_r_f.clie_2 = k_clie_2
				kst_tab_clienti_m_r_f.clie_3 = k_key
				k_errore = kiuf_clienti.tb_delete_m_r_f(kst_tab_clienti_m_r_f) 
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


	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
		tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
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
int k_nr_errori, k_anno
string k_key_str
string k_stato, k_tipo
long k_key
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_cap kst_tab_cap
st_tab_nazioni kst_tab_nazioni
st_tab_clienti_web kst_tab_clienti_web
st_tab_clienti_mkt kst_tab_clienti_mkt
st_web kst_web 
kuf_base kuf1_base
kuf_ausiliari kuf1_ausiliari
kuf_web kuf1_web


kuf1_ausiliari = create kuf_ausiliari


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	k_ctr = tab_1.tabpage_2.dw_2.getrow()

	k_key = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "codice") 

	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "rag_soc_10")) = true then
		k_return = tab_1.tabpage_1.text + ": Manca la Ragione sociale " + "~n~r" 
		k_errore = "3"
		k_nr_errori++
	end if

//--- controlli validi solo se anagrafica ITALIANA
	if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
		or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 &
		or isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) then

		if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 &
			or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then

//--- controllo del CAP 1
			if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 then
		
				kst_tab_cap.cap =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))
				kst_esito = kuf1_ausiliari.tb_select(kst_tab_cap)
				if kst_esito.esito = kkg_esito_ok then
					if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then
						if kst_tab_cap.prov <>  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1")) then
							k_return += tab_1.tabpage_1.text + ": Provincia non congruente con il CAP, suggerisco '" + trim(kst_tab_cap.prov) + "'~n~r" 
							k_errore = "1"
							k_nr_errori++
						end if
					else
						tab_1.tabpage_1.dw_1.setitem (k_riga, "prov_1", trim(kst_tab_cap.prov))
					end if
				else
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_return += tab_1.tabpage_1.text + ": Errore CAP non trovato ("+left(trim(kst_esito.sqlerrtext),40)+")~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if
			else
	
//--- controllo della  PROVINCIA 1
				if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then
		
					kst_tab_cap.prov =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))
					kst_esito = kuf1_ausiliari.tb_select_cap_provincia(kst_tab_cap)
					if kst_esito.esito = kkg_esito_ok then
						if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 then
							if kst_tab_cap.cap <>  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1")) then
								k_return += tab_1.tabpage_1.text + ": CAP non congruente con la Provincia, il primo CAP e' '" + trim(kst_tab_cap.cap) + "'~n~r" 
								k_errore = "1"
								k_nr_errori++
							end if
						else
							k_return += tab_1.tabpage_1.text + ": CAP non presente, il primo CAP di questa prov. e' '" + trim(kst_tab_cap.cap) + "'~n~r" 
							k_errore = "5"
							k_nr_errori++
						end if
					else
						k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_errore = "1"
						k_nr_errori++
					end if
				end if
			end if
			
			
		end if

	
//--- controllo della NAZIONE

		kst_tab_nazioni.id_nazione =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))
		kst_esito = kuf1_ausiliari.tb_select(kst_tab_nazioni)
		if kst_esito.esito <> kkg_esito_ok then
			k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if


//--- controllo della PIVA solo SE ITALIA
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))) > 0 then
		kst_tab_clienti.p_iva = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "p_iva", kst_tab_clienti.p_iva)
		kst_esito = kiuf_clienti.conta_p_iva(kst_tab_clienti)
		if kst_esito.esito = "0" then
			if ((isnull(k_key) or k_key = 0) and kst_tab_clienti.contati > 0) &
			   or kst_tab_clienti.contati > 1 then 
				k_return = k_return &
				           + tab_1.tabpage_1.text + ": Partita IVA già utilizzata x altro Cliente " + "~n~r" 
				k_errore = "1"
				k_nr_errori++
			end if
		end if
		if	k_errore = "0" or k_errore = "4" then
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
			   or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 then

				kst_esito = kiuf_clienti.check_piva(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito_ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if
		
//--- controllo della Codice Fiscale solo SE ITALIA
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))) > 0 then
		kst_tab_clienti.cf = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "cf", kst_tab_clienti.cf)
		if k_errore = "0" or k_errore = "4" then
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT"	 &
			   or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 then

				kst_esito = kiuf_clienti.check_cf(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito_ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if

	if	k_errore = "0" then
		if isnull(k_key) or k_key = 0 then
			k_return = tab_1.tabpage_1.text + ": Il Codice verra' assegnato automaticamente. " + "~n~r"
			k_errore = "5"
			k_nr_errori++
		else
		end if
	end if
	
	
//--- controllo ESENZIONE	
	if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva") > 0 then
		if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") > date(0) then
			k_anno = year(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal"))
		else
			if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") > date(0) then
				k_anno = year(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al"))
			else
				kuf1_base = create kuf_base
				k_anno = year(date(mid(kuf1_base.prendi_dato_base("dataoggi"), 2)))
				destroy kuf1_base
			end if
		end if
		if k_anno = 0 then k_anno = year(today())
		if isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal")) &
			or tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") = date(0) then
			tab_1.tabpage_1.dw_1.setitem ( k_riga, "iva_valida_dal", date(k_anno,01,01))			
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al")) &
			or tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") = date(0) then
			tab_1.tabpage_1.dw_1.setitem ( k_riga, "iva_valida_al", date(k_anno,12,31))			
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva_esente_imp_max")) &
			or tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva_esente_imp_max") = 0 then
			tab_1.tabpage_1.dw_1.setitem ( k_riga, "iva_esente_imp_max", 0)			
		end if
	end if
	if	k_errore = "0" or k_errore = "5" then
		if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") > date(0) &
			and tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") > date(0) &
			and tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") < &
				 tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") &
			then
			k_return = trim(k_return) +  tab_1.tabpage_1.text + ": Controlla il Periodo di Validita' dell'IVA! ~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
		if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") > date(0) &
		   or tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") > date(0) &
			or tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva") > 0 then
			if tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal") > date(0) &
				and tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al") > date(0) &
				and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva") > 0 then
				if year(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_dal")) <> &
					year(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "iva_valida_al")) &
					then
					k_return += tab_1.tabpage_1.text + ": Date con Anni diversi nel Periodo di Validita' dell'IVA! ~n~r" 
					k_errore = "5"
					k_nr_errori++
				end if
			else
				k_return = trim(k_return) +  tab_1.tabpage_1.text + ": Impostare insieme codice IVA e Periodo di Validita'! ~n~r" 
				k_errore = "3"
				k_nr_errori++
						
			end if
		end if
	end if

	
//=== Controllo altro tab
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
		k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) 
		if k_riga > 0 then
			kuf1_web = create kuf_web 
			kst_tab_clienti_web.email =  tab_1.tabpage_3.dw_3.getitemstring( k_riga, "email")
			if len(trim(kst_tab_clienti_web.email)) > 0 then
				kst_web.email = kst_tab_clienti_web.email
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": il primo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.email =  tab_1.tabpage_3.dw_3.getitemstring( k_riga, "email1")
			if len(trim(kst_tab_clienti_web.email1)) > 0 then
				kst_web.email = kst_tab_clienti_web.email1
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": il secondo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.email2 =  tab_1.tabpage_3.dw_3.getitemstring( k_riga, "email2")
			if len(trim(kst_tab_clienti_web.email2)) > 0 then
				kst_web.email = kst_tab_clienti_web.email2
				if not kuf1_web.if_sintassi_email_ok( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": Terzo campo 'e-mail' non sembra corretto, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.sito_web =  tab_1.tabpage_3.dw_3.getitemstring( k_riga, "sito_web")
			if len(trim(kst_tab_clienti_web.sito_web )) > 0 then
				kst_web.url = kst_tab_clienti_web.sito_web
				kuf1_web.url_add_http( kst_web ) //aggiunge http:// all'indirizzo
				tab_1.tabpage_3.dw_3.setitem( k_riga, "sito_web", kst_web.url)
				if not kuf1_web.if_url_esiste( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": Il 'Sito Web' indicato sembra non esistere, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			kst_tab_clienti_web.sito_web1 =  tab_1.tabpage_3.dw_3.getitemstring( k_riga, "sito_web1")
			if len(trim(kst_tab_clienti_web.sito_web1 )) > 0 then
				kst_web.url = kst_tab_clienti_web.sito_web1
				kuf1_web.url_add_http( kst_web ) //aggiunge http:// all'indirizzo
				tab_1.tabpage_3.dw_3.setitem( k_riga, "sito_web", kst_web.url)
				if not kuf1_web.if_url_esiste( kst_web ) then
					k_return = trim(k_return) +  tab_1.tabpage_3.text + ": L'indirizzo di 'Altro Sito' sembra non esistere, prego controllare " &
					+" ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
			destroy kuf1_web
		end if
	end if
	
	
//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
			if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_1")) = true &
			   or tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_1") = 0 &
				then
				k_return = trim(k_return) +  tab_1.tabpage_4.text + ": Mandante alla riga " + &
				string(k_riga, "#####") + " non impostato~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_2")) = true & 
			   or tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_2") = 0 &
				then
				k_return = trim(k_return) + tab_1.tabpage_4.text + ": Ricevente alla riga " + &
				string(k_riga, "#####") + " non impostato~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		
		k_riga++

		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)

	loop


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
int k_anno
string k_rag_soc_10
long k_codice_1



	SELECT 
         clienti.rag_soc_10
   	 INTO 
      	   :k_rag_soc_10  
    	FROM clienti 
   	WHERE codice = :k_codice;

	if sqlca.sqlcode = 0 then

		if messagebox("Anagrafica gia' in Archivio", & 
					"Vuoi modificare i dati anagrafici "+ &
					trim(k_rag_soc_10), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica
			ki_st_open_w.key1 = string(k_codice,"0000000000")

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = true
		end if
	end if  

	attiva_tasti()



return k_return


end function

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0  & 
	 	or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0  & 
		or tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0  & 
	 	or tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0  & 
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

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
long  k_key, k_id_cliente
int k_err_ins, k_rc
string k_fine_ciclo=""
int k_ctr=0
st_tab_clienti kst_tab_clienti
st_esito kst_esito
pointer oldpointer
datawindowchild  kdwc_clienti_1, kdwc_clienti_2 
datawindowchild kdwc_iva, kdwc_pag
kuf_utility kuf1_utility
datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo

//

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if isnumber(ki_st_open_w.key1) then
		k_key = long(trim(ki_st_open_w.key1))
	else
		k_key = 0
	end if

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then

//--- Attivo dw archivio IVA
		tab_1.tabpage_1.dw_1.getchild("iva", kdwc_iva)
		kdwc_iva.settransobject(sqlca)
		if kdwc_iva.rowcount() = 0 then
			kdwc_iva.retrieve()
			kdwc_iva.insertrow(1)
		end if

//--- Attivo dw archivio TIPO PAGAMENTO
		tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_pag)
		kdwc_pag.settransobject(sqlca)
		if kdwc_pag.rowcount() = 0 then
			kdwc_pag.retrieve()
			kdwc_pag.insertrow(1)
		end if

	end if

	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		kst_tab_clienti.codice = k_key
		k_rc = retrieve_dw(kst_tab_clienti) 
//		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0		
				SetPointer(oldpointer)
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Anagrafica cercato: " + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
//				attiva_tasti()

				if k_scelta = kkg_flag_modalita_modifica then
					SetPointer(oldpointer)
					messagebox("Ricerca fallita", &
						"Anagrafica non trovata in archivio ~n~r" + &
						"(ID cercato: " + string(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = kkg_flag_modalita_inserimento then
					SetPointer(oldpointer)
					messagebox("Trovata Anagrafica", &
						"Anagrafica  gia' in archivio ~n~r" + &
						"(ID cercato: " + string(k_key) + ")~n~r" )
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica

				end if

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("rag_soc_10")

				
//				attiva_tasti()
		
		end choose

	end if	


else
//	attiva_tasti()
end if

//===
//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	tab_1.tabpage_6.enabled = false
	tab_1.tabpage_7.enabled = false
	
end if

if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta

//--- Inabilita campi alla modifica se Vsualizzazione
   	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione then
	
      	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then
   		   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

//--- Identifica il tipo Anagrafica
		 if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then

			kst_esito = kiuf_clienti.get_tipo(kst_tab_clienti)
			if kst_esito.esito = kkg_esito_ok then
				if kst_tab_clienti.tipo_mrf = kiuf_clienti.kki_tipo_mrf_FATTURATO then
					tab_1.tabpage_1.dw_1.object.k_tipo.text = "Cliente:" 		
				else
					if kst_tab_clienti.tipo_mrf = kiuf_clienti.kki_tipo_mrf_mandante then
						tab_1.tabpage_1.dw_1.object.k_tipo.text = "Mandante:" 		
					else
						if kst_tab_clienti.tipo_mrf = kiuf_clienti.kki_tipo_mrf_ricevente then
							tab_1.tabpage_1.dw_1.object.k_tipo.text = "Ricevente:"
						end if
					end if
				end if
			end if
		end if
		
	end if
	
	destroy kuf1_utility

end if

//tab_1.tabpage_1.dw_1.resetupdate()

SetPointer(oldpointer)

return "0"


end function

protected subroutine inizializza_3 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_4, k_rc
string k_scelta
string k_fine_ciclo=""
int k_ctr=0
datawindowchild kdwc_clienti_1, kdwc_clienti_2
kuf_utility kuf1_utility


k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)

//--- Acchiappo il codice CLIENTE x evitare la rilettura
if IsNumber(tab_1.tabpage_4.st_4_retrieve.Text) then
	k_codice_4 = long(tab_1.tabpage_4.st_4_retrieve.Text)
else
	k_codice_4 = 0
end if
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.Text=string(k_codice, "####0")


//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
if k_codice = 0 then
	tab_1.tabpage_4.dw_4.reset()
else


	if tab_1.tabpage_4.dw_4.rowcount() = 0  and k_codice_4 <> k_codice then

//--- Attivo dw archivio Clienti Mandanti
		k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_clienti_1)
		k_rc = kdwc_clienti_1.settransobject(sqlca)
		if kdwc_clienti_1.rowcount() = 0 then
			kdwc_clienti_1.insertrow(1)
		end if
	
//--- Attivo dw archivio Clienti Riceventi
		k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_clienti_2)
		k_rc = kdwc_clienti_2.settransobject(sqlca)
		if kdwc_clienti_2.rowcount() = 0 then
			kdwc_clienti_2.insertrow(1)
		end if
	end if


//=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		if k_codice_4 <> k_codice then 
			tab_1.tabpage_4.dw_4.reset()
		end if
	end if
	
	
	if tab_1.tabpage_4.dw_4.rowcount() < 1 then
	
		if tab_1.tabpage_4.dw_4.retrieve(k_codice)  < 1 then
			inserisci()
		end if
	end if
	
	attiva_tasti()

//--- Inabilita campi alla modifica se Visualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione or k_codice_4 <> k_codice then 
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)

	end if
	destroy kuf1_utility

		
end if



	


end subroutine

protected function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_codice, k_nro_commessa, k_riga, k_id_cliente, k_id_protocollo
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
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.reset() 
			end if
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "codice", 0)
			tab_1.tabpage_1.dw_1.setcolumn("p_iva")
			
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
			

		case  3 
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
			end if
			if tab_1.tabpage_3.dw_3.rowcount() > 0 then
				tab_1.tabpage_3.dw_3.reset() 
			end if
			
			tab_1.tabpage_3.dw_3.insertrow(0)
			
			tab_1.tabpage_3.dw_3.setitem(k_riga, "id_cliente", k_codice)
//			tab_1.tabpage_3.dw_3.setcolumn("clienti_mkt_qualifica")
			
			tab_1.tabpage_3.dw_3.SetItemStatus( 1, 0, Primary!, NotModified!)

			
		
		case 4 // 
			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
	
//=== Riempe indirizzo di Spedizione da DW_1
			if k_codice > 0 then
				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
	
				tab_1.tabpage_4.dw_4.setitem(k_riga, "m_r_f_clie_3", k_codice)
	
				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
				tab_1.tabpage_4.dw_4.setrow(k_riga)
				tab_1.tabpage_4.dw_4.setcolumn("clie_1")
				
			end if
			
	end choose	

	k_return = 0

//=== 
	attiva_tasti()

end if

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

		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_1")) or &
				 tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_1") = 0) or &
				(isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_2")) or &
				 tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "clie_2") = 0) &
				then
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)

			end if
		end if
		
	next


end subroutine

protected subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr, k_codice, k_nro_old
long k_codice_1
string k_ret_code
kuf_base kuf1_base



k_ctr = tab_1.tabpage_1.dw_1.getrow()


if k_ctr > 0 then
//=== Salvo ID originale x piu' avanti
	k_codice_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "codice")


//=== Se non sono in caricamento allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) <> newmodified! then
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "codice")
	else

		if isnull(k_codice_1) then				
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "codice", 0)
		end if


		tab_1.tabpage_1.dw_1.setitem(k_ctr, "codice", k_codice)

	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "ind_comm_rag_soc_1_c")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_rag_soc_1_c", " ") 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "ind_comm_rag_soc_2_c")) then 
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_rag_soc_2_c", " ") 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_ctr, "ind_comm_indi_c")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_indi_c", " ") 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "ind_comm_loc_c")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_loc_c", " ") 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "ind_comm_cap_c")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_cap_c", " ") 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "ind_comm_prov_c")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "ind_comm_prov_c", " ") 
	end if

		
	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 

		tab_1.tabpage_4.dw_4.setitem(k_ctr, "m_r_f_clie_3", k_codice_1)
				
	end for

end if

end subroutine

protected subroutine open_start_window ();//
	kiuf_clienti = create kuf_clienti
	this.tab_1.tabpage_1.picturename = kg_path_risorse + "\" + "cliente.gif"
	this.tab_1.tabpage_3.picturename = kg_path_risorse + "\" + "torta.gif"
	this.tab_1.tabpage_6.picturename = kg_path_risorse + "\" + "stat_1.gif"
	this.tab_1.tabpage_7.picturename = kg_path_risorse + "\" + "stat_2.gif"


end subroutine

protected subroutine inizializza_4 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_id_cliente
string k_scelta
int k_rc
//datawindowchild kdwc_sl_pt, kdwc_t_contr



k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

	if tab_1.tabpage_5.dw_5.rowcount() < 1 then

//=== Parametri : cliente, articolo, sl-pt
		if tab_1.tabpage_5.dw_5.retrieve(k_codice, "*", "*") <= 0 then

			inserisci()
		else
					
//			attiva_tasti()

		end if				
	else
//		attiva_tasti()
	end if

//	tab_1.tabpage_5.dw_5.setitem(1, "k_pwd", kg_pwd)

	tab_1.tabpage_5.dw_5.setfocus()
	

end subroutine

protected subroutine inizializza_5 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 6 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_3
string k_scelta, k_estrazione
date k_data_int
kuf_base kuf1_base 



k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)
k_data_int = date(year(kg_dataoggi) - 1 , 01, 01) //RelativeDate(today(), -365)

//--- Acchiappo il codice CLIENTE x evitare la rilettura
if IsNumber(tab_1.tabpage_6.dw_6.Object.k_codice.Text) then
	k_codice_3 = long(tab_1.tabpage_6.dw_6.Object.k_codice.Text)
else
	k_codice_3 = 0
end if
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
tab_1.tabpage_6.dw_6.Object.k_codice.Text=string(k_codice, "####0")


//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//=== Se tab_3 non ha righe INSERISCI_TAB_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
	if tab_1.tabpage_6.dw_6.rowcount() > 0 then
		if k_codice_3 <> k_codice then 
			tab_1.tabpage_6.dw_6.reset()
		end if
	end if

	if tab_1.tabpage_6.dw_6.rowcount() < 1 then
//			if k_scelta <> "in" then

		kuf1_base = create kuf_base 
//--- reperisce l'ultima estremi estrazione	
		k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		tab_1.tabpage_6.dw_6.object.t_estrazione.text = trim(k_estrazione)
	
		if tab_1.tabpage_6.dw_6.retrieve(k_codice, k_data_int) <= 0 then

			inserisci()
		else
			attiva_tasti()
		end if				
//			else
//				inserisci()
//			end if
	else
		attiva_tasti()

	end if

////=== Se tab_3 non ha righe INSERISCI_TAB_31 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto
//	if tab_1.tabpage_6.dw_31.rowcount() > 0 then
//		tab_1.tabpage_6.dw_31.accepttext()
//		if tab_1.tabpage_6.dw_31.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_6.dw_31.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_6.dw_31.rowcount() < 1 then
//
//		if tab_1.tabpage_6.dw_31.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
//	else
//		attiva_tasti()
//	end if
//	
//	tab_1.tabpage_6.dw_31.setfocus()
//	

	



end subroutine

private subroutine call_elenco_capitolati ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then

	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( &
						tab_1.tabpage_1.dw_1.getrow(), "codice") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_sc_cf
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = "*" // flag attivi
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_fatture ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then

	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( tab_1.tabpage_1.dw_1.getrow(), "codice") 

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture_elenco
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_elenco
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = " "  //data da  
	K_st_open_w.key3 = " "  //data a
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_contratti ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then

	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( &
						tab_1.tabpage_1.dw_1.getrow(), "codice") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_contratti
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_listino ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then

	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( &
						tab_1.tabpage_1.dw_1.getrow(), "codice") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto

		K_st_open_w.id_programma = kkg_id_programma_listini_l
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // cod articolo 
		K_st_open_w.key3 = " " // dose
		K_st_open_w.key4 = " " // misure imballo
		K_st_open_w.key5 = " " // misure imballo
		K_st_open_w.key6 = " " // misure imballo
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_stat_fatt ();//
string k_anno
long k_id_cliente
kuf_base kuf1_base
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then


	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( &
						tab_1.tabpage_1.dw_1.getrow(), "codice") 

	
	kuf1_base = create kuf_base
	k_anno = trim(MidA(kuf1_base.prendi_dato_base("anno"),2))
	destroy kuf1_base
	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

	K_st_open_w.id_programma =kkg_id_programma_stat_fatt
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "sk"
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = "1"
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = "0000000000"  //dose
	K_st_open_w.key3 = "0000000000"  //id gruppo
	K_st_open_w.key4 = "01/01/" + k_anno  //data da
	K_st_open_w.key5 = "31/12/" + k_anno //data a
	K_st_open_w.key6 = " " 
	K_st_open_w.key7 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if




end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case LeftA(k_par_in, 2) 

	case "l1"		//Contratti...
		call_elenco_capitolati()

	case "l2"		//Contratti...
		call_elenco_contratti()

	case "l3"		//Listino...
		call_elenco_listino()

	case "l4"		//Fatture...
		call_elenco_fatture()

	case "l8"		//Statistica...
		call_elenco_stat_fatt()



	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
boolean k_insert = true
//

this.setredraw( false )

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()

	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
		k_insert = false
	end if

	
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
   "Capitolato,Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "Capitolati,Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
   "Contratti,Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "Contratti,Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
   "Listini,Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini,Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero4.text = "Elenco documenti di vendita "
	kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
	"Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName =kg_path_risorse +  "\fattura16x16.gif"
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero8.text = "Estrazione statistico di magazzino per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.microhelp = &
   "Stat.Fatt,Estrazione statistico di magazzino per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText =  "Stat.Fat,Estrazione statistico di magazzino dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Graph!"
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2

	this.setredraw( true )

end subroutine

protected subroutine inizializza_6 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 6 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_3
string k_scelta, k_estrazione
date k_data_int
kuf_base kuf1_base 



k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)
k_data_int = date(year(kg_dataoggi) - 1 , 01, 01) //RelativeDate(today(), -365)

//--- Acchiappo il codice CLIENTE x evitare la rilettura
if IsNumber(tab_1.tabpage_7.dw_7.tag) then
	k_codice_3 = long(tab_1.tabpage_7.dw_7.tag)
else
	k_codice_3 = 0
end if
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
tab_1.tabpage_7.dw_7.tag =string(k_codice, "####0")


//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//=== Se tab_3 non ha righe INSERISCI_TAB_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la cliente allora resetto		
	if tab_1.tabpage_7.dw_7.rowcount() > 0 then
		if k_codice_3 <> k_codice then 
			tab_1.tabpage_7.dw_7.reset()
		end if
	end if

	if tab_1.tabpage_7.dw_7.rowcount() < 1 then
//			if k_scelta <> "in" then

		kuf1_base = create kuf_base 
//--- reperisce l'ultima estremi estrazione	
		k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		tab_1.tabpage_7.dw_7.object.t_estrazione.text = trim(k_estrazione)
	
		if tab_1.tabpage_7.dw_7.retrieve(k_codice, k_data_int) <= 0 then

			inserisci()
		else
			attiva_tasti()
		end if				
//			else
//				inserisci()
//			end if
	else
		attiva_tasti()

	end if


end subroutine

private function long retrieve_dw (st_tab_clienti kst_tab_clienti);//
long k_return=0
long k_rc_retrieve=0
st_esito kst_esito
st_tab_iva kst_tab_iva
st_tab_pagam kst_tab_pagam
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi
kuf_ausiliari kuf1_ausiliari
pointer kpointer


kpointer = setpointer(hourglass!)

//--- leggo archivio clienti

//kst_esito = kiuf_clienti.leggi(kst_tab_clienti)
k_rc_retrieve = tab_1.tabpage_1.dw_1.retrieve(kst_tab_clienti.codice) 
if k_rc_retrieve > 0 then
//
//tab_1.tabpage_1.dw_1.reset()
//
//	
//if kst_esito.esito = kkg_esito_ok or kst_esito.esito = kkg_esito_db_wrn then
//
	k_return = k_rc_retrieve
//	
//	if kst_esito.esito = kkg_esito_ok then
//	
//		tab_1.tabpage_1.dw_1.insertrow(0)
//	
//	 	  tab_1.tabpage_1.dw_1.object.codice[1] = kst_tab_clienti.codice
//	 	  tab_1.tabpage_1.dw_1.object.rag_soc_10[1] = trim(kst_tab_clienti.rag_soc_10 )   
//           tab_1.tabpage_1.dw_1.object.rag_soc_11[1] = trim(kst_tab_clienti.rag_soc_11 )   
//           tab_1.tabpage_1.dw_1.object.rag_soc_20[1] = trim(kst_tab_clienti.rag_soc_20 )  
//           tab_1.tabpage_1.dw_1.object.rag_soc_21[1] = trim(kst_tab_clienti.rag_soc_21 )  
//		  tab_1.tabpage_1.dw_1.object.indi_1[1] = trim(kst_tab_clienti.indi_1 )  
//           tab_1.tabpage_1.dw_1.object.loc_1[1] = trim(kst_tab_clienti.loc_1 )  
//           tab_1.tabpage_1.dw_1.object.cap_1[1] = kst_tab_clienti.cap_1   
//           tab_1.tabpage_1.dw_1.object.prov_1[1] = kst_tab_clienti.prov_1   
//           tab_1.tabpage_1.dw_1.object.p_iva[1] = trim(kst_tab_clienti.p_iva)  
//           tab_1.tabpage_1.dw_1.object.cf[1] = trim(kst_tab_clienti.cf)  
//           tab_1.tabpage_1.dw_1.object.id_nazione_1[1] = trim(kst_tab_clienti.id_nazione_1 )
//           tab_1.tabpage_1.dw_1.object.zona[1] = trim(kst_tab_clienti.zona )
//           tab_1.tabpage_1.dw_1.object.fono[1] = trim(kst_tab_clienti.fono)
//           tab_1.tabpage_1.dw_1.object.fax[1] = trim(kst_tab_clienti.fax )
//           tab_1.tabpage_1.dw_1.object.cod_pag[1] = kst_tab_clienti.cod_pag 
//           tab_1.tabpage_1.dw_1.object.banca[1] = trim(kst_tab_clienti.banca )
//           tab_1.tabpage_1.dw_1.object.abi[1] = kst_tab_clienti.abi 
//           tab_1.tabpage_1.dw_1.object.cab[1] = kst_tab_clienti.cab 
//           tab_1.tabpage_1.dw_1.object.tipo_banca[1] = kst_tab_clienti.tipo_banca 
//           tab_1.tabpage_1.dw_1.object.iva[1] = kst_tab_clienti.iva 
//           tab_1.tabpage_1.dw_1.object.iva_valida_dal[1] = kst_tab_clienti.iva_valida_dal 
//           tab_1.tabpage_1.dw_1.object.iva_valida_al[1] = kst_tab_clienti.iva_valida_al 
//           tab_1.tabpage_1.dw_1.object.iva_esente_imp_max[1] = kst_tab_clienti.iva_esente_imp_max 
//           tab_1.tabpage_1.dw_1.object.mese_es_1[1] = kst_tab_clienti.mese_es_1 
//           tab_1.tabpage_1.dw_1.object.mese_es_2[1] = kst_tab_clienti.mese_es_2 
//           tab_1.tabpage_1.dw_1.object.fattura[1] = kst_tab_clienti.fattura
//           tab_1.tabpage_1.dw_1.object.indi_2[1] = trim(kst_tab_clienti.indi_2)
//           tab_1.tabpage_1.dw_1.object.cap_2[1] = trim(kst_tab_clienti.cap_2 )
//           tab_1.tabpage_1.dw_1.object.loc_2[1] = trim(kst_tab_clienti.loc_2)
//           tab_1.tabpage_1.dw_1.object.prov_2[1] = trim(kst_tab_clienti.prov_2) 
//           tab_1.tabpage_1.dw_1.object.x_datins[1] = kst_tab_clienti.x_datins
//           tab_1.tabpage_1.dw_1.object.x_utente[1] = kst_tab_clienti.x_utente
////           tab_1.tabpage_1.dw_1.object.nome[1] = trim(kst_tab_clienti.kst_tab_nazioni.nome)
////           tab_1.tabpage_1.dw_1.object.area[1] = trim(kst_tab_clienti.kst_tab_nazioni.area)
//           tab_1.tabpage_1.dw_1.object.nazione[1] = trim(kst_tab_clienti.kst_tab_nazioni.nome ) + "  ( " + trim(kst_tab_clienti.kst_tab_nazioni.area ) + " ) " 
//           tab_1.tabpage_1.dw_1.object.ind_comm_rag_soc_1_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c)
//           tab_1.tabpage_1.dw_1.object.ind_comm_rag_soc_2_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c)
//           tab_1.tabpage_1.dw_1.object.ind_comm_indi_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.indi_c)
//           tab_1.tabpage_1.dw_1.object.ind_comm_cap_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.cap_c) 
//           tab_1.tabpage_1.dw_1.object.ind_comm_loc_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.loc_c)
//           tab_1.tabpage_1.dw_1.object.ind_comm_prov_c[1] = trim(kst_tab_clienti.kst_tab_ind_comm.prov_c)
//           tab_1.tabpage_1.dw_1.object.ind_comm_clie_c[1] = (kst_tab_clienti.kst_tab_ind_comm.clie_c)
//           tab_1.tabpage_1.dw_1.object.fattura_da[1] = trim(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da)
//           tab_1.tabpage_1.dw_1.object.note_1[1] = trim(kst_tab_clienti.kst_tab_clienti_fatt.note_1)
//           tab_1.tabpage_1.dw_1.object.note_2[1] = trim(kst_tab_clienti.kst_tab_clienti_fatt.note_2)
//           tab_1.tabpage_1.dw_1.object.stato[1] = trim(kst_tab_clienti.stato) 
//           tab_1.tabpage_1.dw_1.object.id_clie_settore[1] = trim(kst_tab_clienti.id_clie_settore) 
//           tab_1.tabpage_1.dw_1.object.id_clie_classe[1] = trim(kst_tab_clienti.id_clie_classe) 
//
//
////--- get della descrizione IVA e Pagamento
//		kuf1_ausiliari = create kuf_ausiliari
//		if kst_tab_clienti.iva > 0 then
//			kst_tab_iva.codice = kst_tab_clienti.iva 
//			kuf1_ausiliari.tb_select( kst_tab_iva )
//		else
//			kst_tab_iva.des = " "
//		end if
//         tab_1.tabpage_1.dw_1.object.iva_des[1] = kst_tab_iva.des 
//
//		if kst_tab_clienti.cod_pag > 0 then
//			kst_tab_pagam.codice = kst_tab_clienti.cod_pag 
//			kuf1_ausiliari.tb_select( kst_tab_pagam )
//		else
//			kst_tab_pagam.des = " "
//		end if
//         tab_1.tabpage_1.dw_1.object.pagam_des[1] = kst_tab_pagam.des 
//
//		if len(trim(kst_tab_clienti.id_clie_settore)) > 0 then
//			kst_tab_clie_settori.id_clie_settore = kst_tab_clienti.id_clie_settore 
//			kuf1_ausiliari.tb_select( kst_tab_clie_settori )
//		else
//			kst_tab_clie_settori.descr = " "
//		end if
//         tab_1.tabpage_1.dw_1.object.clie_settori_descr[1] = kst_tab_clie_settori.descr 
//
//		if len(trim(kst_tab_clienti.id_clie_classe)) > 0 then
//			kst_tab_clie_classi.id_clie_classe = kst_tab_clienti.id_clie_classe 
//			kuf1_ausiliari.tb_select( kst_tab_clie_classi )
//		else
//			kst_tab_clie_classi.descr = " "
//		end if
//         tab_1.tabpage_1.dw_1.object.clie_classi_descr[1] = kst_tab_clie_classi.descr 
//		destroy kuf1_ausiliari

//--- valorizza contatori Mandanti/Riceventi/Fatturati			  
 	  	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
		if kst_tab_clienti.codice > 0 then
	
			kst_esito = kiuf_clienti.get_nr_mandanti( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito_ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.mandanti_nr.Expression = string( kst_tab_clienti.contati )
	
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
			kst_esito = kiuf_clienti.get_nr_riceventi( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito_ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.riceventi_nr.Expression = string( kst_tab_clienti.contati )
	
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
			kst_esito = kiuf_clienti.get_nr_fatturati( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito_ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.fatturati_nr.Expression = string( kst_tab_clienti.contati )
		end if
			  
		tab_1.tabpage_1.dw_1.resetupdate( )

//	end if
	
else
	if k_rc_retrieve = 0 then
//	if kst_esito.esito = kkg_esito_not_fnd then
		
		k_return = 0
		
	else
		k_return = -1
	end if
	
end if

setpointer(kpointer)

return k_return

end function

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_err_ins, k_rc
int k_ctr=0
st_tab_clienti kst_tab_clienti
st_esito kst_esito
pointer oldpointer
kuf_utility kuf1_utility
datawindowchild kdwc_c_link, kdwc_contatti1,  kdwc_contatti2,  kdwc_contatti3,  kdwc_contatti4,  kdwc_contatti5 



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	
if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber( 1, "codice")
else
	kst_tab_clienti.codice = 0
end if

if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then

//--- Attivo dw Clienti in LINK
		tab_1.tabpage_3.dw_3.getchild("c_link_rag_soc_10", kdwc_c_link)
		kdwc_c_link.settransobject(sqlca)
		if kdwc_c_link.rowcount() = 0 then
			kdwc_c_link.retrieve("*")
			kdwc_c_link.insertrow(1)
		end if
//--- Attivo dw Contatti
		tab_1.tabpage_3.dw_3.getchild("c1_rag_soc_10", kdwc_contatti1)
		kdwc_contatti1.settransobject(sqlca)
		if kdwc_contatti1.rowcount() = 0 then
			kdwc_contatti1.retrieve(kiuf_clienti.kki_tipo_contatto)
			kdwc_contatti1.insertrow(1)
		end if
		tab_1.tabpage_3.dw_3.getchild("c2_rag_soc_10", kdwc_contatti2)
		kdwc_contatti2.settransobject(sqlca)
		if kdwc_contatti2.rowcount() = 0 then
			kdwc_contatti2.retrieve(kiuf_clienti.kki_tipo_contatto)
			kdwc_contatti2.insertrow(1)
		end if
		tab_1.tabpage_3.dw_3.getchild("c3_rag_soc_10", kdwc_contatti3)
		kdwc_contatti3.settransobject(sqlca)
		if kdwc_contatti3.rowcount() = 0 then
			kdwc_contatti3.retrieve(kiuf_clienti.kki_tipo_contatto)
			kdwc_contatti3.insertrow(1)
		end if
		tab_1.tabpage_3.dw_3.getchild("c4_rag_soc_10", kdwc_contatti4)
		kdwc_contatti4.settransobject(sqlca)
		if kdwc_contatti4.rowcount() = 0 then
			kdwc_contatti4.retrieve(kiuf_clienti.kki_tipo_contatto)
			kdwc_contatti4.insertrow(1)
		end if
		tab_1.tabpage_3.dw_3.getchild("c5_rag_soc_10", kdwc_contatti5)
		kdwc_contatti5.settransobject(sqlca)
		if kdwc_contatti5.rowcount() = 0 then
			kdwc_contatti5.retrieve(kiuf_clienti.kki_tipo_contatto)
			kdwc_contatti5.insertrow(1)
		end if

	end if

	if kst_tab_clienti.codice = 0 then
		k_err_ins = inserisci() 
	else

		k_rc = tab_1.tabpage_3.dw_3.retrieve(kst_tab_clienti.codice) 
		
		choose case k_rc

			case is < 0		
				SetPointer(oldpointer)
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Anagrafica cercata :" + string(kst_tab_clienti.codice) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
				tab_1.tabpage_3.dw_3.reset()
				k_err_ins = inserisci()

//			case is > 0		
//				tab_1.tabpage_3.dw_3.setcolumn("rag_soc_10")
		
		end choose

	end if	

end if


//--- Inabilita campi alla modifica se Vsualizzazione
kuf1_utility = create kuf_utility 
if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione then

	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)

else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)

end if
destroy kuf1_utility

//tab_1.tabpage_3.dw_3.resetupdate()
tab_1.tabpage_3.dw_3.setfocus()

SetPointer(oldpointer)



end subroutine

private subroutine put_video_mkt_cliente_link (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente LINK su mappa MKT 
//



tab_1.tabpage_3.dw_3.modify( "c_link_rag_soc_10.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem( 1, "c_link_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_3.dw_3.setitem( 1, "clienti_mkt_id_cliente_link" , kst_tab_clienti.codice )

end subroutine

private subroutine put_video_mkt_contatti (integer k_nr_contatto, st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Contatto 1-5 su mappa MKT 
//



tab_1.tabpage_3.dw_3.modify( "c" + string(k_nr_contatto) + "_rag_soc_10.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem( 1, "c" + string(k_nr_contatto) + "_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_3.dw_3.setitem( 1, "id_contatto_" + string(k_nr_contatto) , kst_tab_clienti.codice )

end subroutine

on w_clienti.create
call super::create
end on

on w_clienti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti
if isvalid(kdsi_elenco_input) then destroy kdsi_elenco_input 


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long k_num_int, k_riga
date k_data_int
double k_coeff_a_s
int k_assorbanza, k_spessore
window k_window
kuf_menu_window kuf1_menu_window 



	if isvalid(kst_open_w) then

		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		
		choose case kst_open_w.key2
			case kuf_ausiliari.kki_cap_l 
//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
				if long(kst_open_w.key3) > 0 then
				
					kdsi_elenco_input = kst_open_w.key12_any 
				
					if kdsi_elenco_input.rowcount() > 0 then
		
			
						tab_1.tabpage_1.dw_1.setitem(1, "cap_1", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "cap"))
						tab_1.tabpage_1.dw_1.setitem(1, "loc_1", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "localita"))
						tab_1.tabpage_1.dw_1.setitem(1, "prov_1", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "prov"))
										 
					end if
				end if

// 		if kst_open_w.key2 = "d_meca_elenco_da_conv" and long(kst_open_w.key3) > 0 then
			case  kuf_ausiliari.kki_nazioni_l 
				if long(kst_open_w.key3) > 0 then

					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
		
						tab_1.tabpage_1.dw_1.setitem(1, "id_nazione_1", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione"))
						tab_1.tabpage_1.dw_1.setitem(1, "nazione", &
											(trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome")) + "  ( " + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area")) + " ) " ))
	//					tab_1.tabpage_1.dw_1.setitem(1, "nome", &
	//									 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome"))
	//					tab_1.tabpage_1.dw_1.setitem(1, "area", &
	//									 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area"))
							
					end if
					
				end if				
				
			case kuf_ausiliari.kki_clie_settori_l 
				if long(kst_open_w.key3) > 0 then

					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
		
						tab_1.tabpage_1.dw_1.setitem(1, "id_clie_settore", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_clie_settore"))
						tab_1.tabpage_1.dw_1.setitem(1, "clie_settori_descr", &
											(trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "descr"))))
							
					end if
					
				end if				
				
			case kuf_ausiliari.kki_clie_classi_l 
				if long(kst_open_w.key3) > 0 then

					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
		
						tab_1.tabpage_1.dw_1.setitem(1, "id_clie_classe", &
										 kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_clie_classe"))
						tab_1.tabpage_1.dw_1.setitem(1, "clie_classi_descr", &
											(trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "descr"))))
							
					end if
					
				end if				
				
		end choose 

	end if




end event

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_clienti
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_clienti
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_clienti
integer y = 1732
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_clienti
integer y = 1808
end type

type dw_trova from w_g_tab_3`dw_trova within w_clienti
integer x = 2167
integer y = 784
end type

type dw_filtra from w_g_tab_3`dw_filtra within w_clienti
integer x = 2181
integer y = 1316
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_clienti
integer y = 1612
end type

event cb_visualizza::clicked;call super::clicked;//
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


choose case tab_1.selectedtab
	case 2 // chiama listino
		if tab_1.tabpage_2.dw_2.getrow() > 0 then
		
			k_cod_cli = tab_1.tabpage_2.dw_2.getitemnumber( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_cod_cli") 
			k_cod_art = tab_1.tabpage_2.dw_2.getitemstring( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_cod_art") 
			k_dose = tab_1.tabpage_2.dw_2.getitemnumber( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_dose") 
			k_mis_x = tab_1.tabpage_2.dw_2.getitemnumber( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_mis_x") 
			k_mis_y = tab_1.tabpage_2.dw_2.getitemnumber( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_mis_y") 
			k_mis_z = tab_1.tabpage_2.dw_2.getitemnumber( &
								tab_1.tabpage_2.dw_2.getrow(), "listino_mis_z") 
		
		
		//
		//=== Parametri : 
		//=== struttura st_open_w
		//=== dati particolare programma
		//
		//=== Si potrebbero passare:
		//=== key1=codice cli; key2=cod sl-pt
		
			K_st_open_w.id_programma = kkg_id_programma_listini
			K_st_open_w.flag_primo_giro = "S"
			K_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
			K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
			K_st_open_w.flag_leggi_dw = " "
			K_st_open_w.flag_cerca_in_lista = " "
			K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
			K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
			K_st_open_w.key3 = trim(string(k_dose)) // dose
			K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
			K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
			K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
			K_st_open_w.flag_where = " "
			
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(k_st_open_w)
			destroy kuf1_menu_window
		
										
		else
		
			messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
		
		end if

end choose

end event

type cb_modifica from w_g_tab_3`cb_modifica within w_clienti
integer y = 1708
end type

event cb_modifica::clicked;call super::clicked;//
string k_cod_art
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
double k_dose
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


	choose case tab_1.selectedtab
		case 1
		case 2 // chiama listino
			if tab_1.tabpage_2.dw_2.getrow() > 0 then
			
				k_cod_cli = tab_1.tabpage_2.dw_2.getitemnumber( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_cod_cli") 
				k_cod_art = tab_1.tabpage_2.dw_2.getitemstring( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_cod_art") 
				k_dose = tab_1.tabpage_2.dw_2.getitemnumber( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_dose") 
				k_mis_x = tab_1.tabpage_2.dw_2.getitemnumber( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_mis_x") 
				k_mis_y = tab_1.tabpage_2.dw_2.getitemnumber( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_mis_y") 
				k_mis_z = tab_1.tabpage_2.dw_2.getitemnumber( &
									tab_1.tabpage_2.dw_2.getrow(), "listino_mis_z") 
			
			//=== Parametri : 
			//=== struttura st_open_w
			//=== dati particolare programma
			//
			//=== Si potrebbero passare:
			//=== key1=codice cli; key2=cod sl-pt
			
				K_st_open_w.id_programma = kkg_id_programma_listini
				K_st_open_w.flag_primo_giro = "S"
				K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
				K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
				K_st_open_w.flag_leggi_dw = " "
				K_st_open_w.flag_cerca_in_lista = " "
				K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
				K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
				K_st_open_w.key3 = trim(string(k_dose)) // dose
				K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
				K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
				K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
				K_st_open_w.flag_where = " "
				
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(k_st_open_w)
				destroy kuf1_menu_window
											
			else
				messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
			end if
		case 4
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
			   	kuf1_utility = create kuf_utility 
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		  		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)
				destroy kuf1_utility
			else
				inserisci() 
			end if
			
	end choose



end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_clienti
integer y = 1708
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_clienti
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_clienti
integer y = 1712
end type

event cb_inserisci::clicked;call super::clicked;//
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
			
		case 2 // listino
			
			if tab_1.tabpage_1.dw_1.getrow() > 0 then

				k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber( &
									tab_1.tabpage_1.dw_1.getrow(), "codice") 
				k_cod_art = ""
				k_dose = 0
				k_mis_x = 0
				k_mis_y = 0
				k_mis_z = 0
			
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

				K_st_open_w.id_programma = kkg_id_programma_listini
				K_st_open_w.flag_primo_giro = "S"
				K_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
				K_st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO
				K_st_open_w.flag_leggi_dw = " "
				K_st_open_w.flag_cerca_in_lista = " "
				K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
				K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
				K_st_open_w.key3 = trim(string(k_dose)) // dose
				K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
				K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
				K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
				K_st_open_w.flag_where = " "
				
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(k_st_open_w)
				destroy kuf1_menu_window
											
			else
			
				messagebox("Operazione non eseguita", "Nessun cliente presente")
			
			end if


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

type tab_1 from w_g_tab_3`tab_1 within w_clienti
boolean visible = true
integer x = 37
integer y = 20
integer width = 3195
integer height = 1556
long backcolor = 32435950
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer y = 176
integer width = 3159
integer height = 1364
long backcolor = 32435950
string text = "Anagrafica"
string picturename = "C:\GAMMARAD\PB_GMMRD11\ICONE\cliente.gif"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer width = 2734
integer height = 1312
string dataobject = "d_clienti_1"
boolean ki_attiva_standard_select_row = false
end type

event dw_1::itemchanged;call super::itemchanged;//
date k_data
long k_codice
string k_rag_soc
int k_errore=0
kuf_ausiliari kuf1_ausiliari
st_tab_iva kst_tab_iva
st_tab_pagam kst_tab_pagam
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi


choose case dwo.name 
	case "codice" 
		k_codice = long(data)
		if isnull(k_codice) = false and k_codice > 0 then
			if check_rek( k_codice ) then
				k_errore = 1
			end if
		end if

	case "iva" 
//--- get della descrizione IVA e Pagamento
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_iva.codice = long(data)
		if kst_tab_iva.codice > 0 then
			kuf1_ausiliari.tb_select( kst_tab_iva )
		else
			kst_tab_iva.des = " "
		end if
         tab_1.tabpage_1.dw_1.object.iva_des[1] = kst_tab_iva.des 
		destroy kuf1_ausiliari

	case "cod_pag" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_pagam.codice = long(data)
		if kst_tab_pagam.codice > 0 then
			kuf1_ausiliari.tb_select( kst_tab_pagam )
		else
			kst_tab_pagam.des = " "
		end if
         tab_1.tabpage_1.dw_1.object.pagam_des[1] = kst_tab_pagam.des 
		destroy kuf1_ausiliari

	case "id_clie_settore" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_clie_settori.id_clie_settore = trim(data)
		if len(trim(kst_tab_clie_settori.id_clie_settore)) > 0 then
			kuf1_ausiliari.tb_select( kst_tab_clie_settori )
		else
			kst_tab_clie_settori.descr = " "
		end if
         tab_1.tabpage_1.dw_1.object.clie_settori_descr[1] = kst_tab_clie_settori.descr 
		destroy kuf1_ausiliari

	case "id_clie_classi" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_clie_classi.id_clie_classe = trim(data)
		if len(trim(kst_tab_clie_classi.id_clie_classe)) > 0 then
			kuf1_ausiliari.tb_select( kst_tab_clie_classi )
		else
			kst_tab_clie_classi.descr = " "
		end if
         tab_1.tabpage_1.dw_1.object.clie_settori_descr[1] = kst_tab_clie_classi.descr 
		destroy kuf1_ausiliari
		
end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//

if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento &
   or ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica &
	then
	choose case dwo.name
	//--- copia NOMINATIVO princ in spedizione
		case "b_copia_sped"
			this.setitem(row, "rag_soc_20", this.getitemstring(row, "rag_soc_10")) 
			this.setitem(row, "rag_soc_21", this.getitemstring(row, "rag_soc_11")) 
	//--- copia NOMINATIVO princ in fatturazione
		case "b_copia_fatt"
			this.setitem(row, "ind_comm_rag_soc_1_c", this.getitemstring(row, "rag_soc_10")) 
			this.setitem(row, "ind_comm_rag_soc_2_c", this.getitemstring(row, "rag_soc_11")) 
	end choose

end if

//
end event

event dw_1::clicked;call super::clicked;//
int k_rc
st_tab_clienti kst_tab_clienti
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 


//--- Controllo che dalla window ELENCO non abbia premuto un tasto
	if dwo.Name = "mandanti" or dwo.Name ="riceventi" or dwo.Name ="fatturati" then

//--- popolo il datasore (dw non visuale) per appoggio elenco
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

		choose case dwo.Name
			case "mandanti"
				kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (0, kst_tab_clienti.codice, kst_tab_clienti.codice)
					kst_open_w.key1 = "Elenco Mandanti per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
			case "riceventi"
				kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (kst_tab_clienti.codice, 0, kst_tab_clienti.codice)
					kst_open_w.key1 = "Elenco Riceventi per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
			case "fatturati"
		 	  	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (kst_tab_clienti.codice,  kst_tab_clienti.codice, 0)
					kst_open_w.key1 = "Elenco Fatturati per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
		end choose

		if kdsi_elenco_output.rowcount() > 0 then
		
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
			kst_open_w.id_programma = kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita_elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
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

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer y = 176
integer width = 3159
integer height = 1364
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
boolean visible = true
integer y = 176
integer width = 3159
integer height = 1364
long backcolor = 32435950
string text = " Marketing~r~n & Web"
string picturename = "Custom073!"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 1952
integer height = 1232
boolean enabled = true
string dataobject = "d_clienti_mkt_web"
end type

event dw_3::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1

choose case dwo.name 

	case "c_link_rag_soc_10" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_3.dw_3.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_10 like '" + LeftTrim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				kst_tab_clienti.rag_soc_10 = trim(kdwc_1.getitemstring( k_riga, "rag_soc_10"))
				post put_video_mkt_cliente_link(kst_tab_clienti)
			else
				tab_1.tabpage_3.dw_3.object.clienti_mkt_id_cliente_link[1] = 0
				tab_1.tabpage_3.dw_3.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_mkt_cliente_link(kst_tab_clienti)
		end if
		
	case "c1_rag_soc_10",  "c2_rag_soc_10", "c3_rag_soc_10", "c4_rag_soc_10", "c5_rag_soc_10"
		if len(trim(data)) > 0 then 
			tab_1.tabpage_3.dw_3.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_10 like '" + LeftTrim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				kst_tab_clienti.rag_soc_10 = trim(kdwc_1.getitemstring( k_riga, "rag_soc_10"))
				post put_video_mkt_contatti(integer(mid(dwo.name,2,1)) , kst_tab_clienti)
			else
				tab_1.tabpage_3.dw_3.setitem(1, "id_contatto_" + mid(dwo.name,2,1) ,0)
				tab_1.tabpage_3.dw_3.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_mkt_contatti(integer(mid(dwo.name,2,1)) , kst_tab_clienti)
		end if

end choose

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer y = 176
integer width = 3159
integer height = 1364
long backcolor = 32435950
string text = " Mandanti~r~n & Riceventi"
long tabbackcolor = 32435950
string picturename = "Deploy!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean enabled = true
string dataobject = "d_m_r_f_l"
end type

event dw_4::itemchanged;call super::itemchanged;//
string k_rag_soc, k_codice
long k_rc, k_riga=0
integer k_return=0
datawindowchild kdwc_cli


choose case upper(dwo.name)

	case "CLIENTI_RAG_SOC_1" 

		k_rag_soc = RightTrim(data)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", k_rag_soc+" - NON TROVATO -")
				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", 0)
			else
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if

	
	case "CLIENTI_RAG_SOC_2" 
	
		k_rag_soc = RightTrim(data)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", " - NON TROVATO -")
				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if
	
		
	case "CLIE_1" 
	
		if isnumber(Trim(data)) then
			k_codice = Trim(data)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", " - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(row, "clie_1", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if
		
	case "CLIE_2" 
	
		if isnumber(Trim(data)) then
			k_codice = Trim(data)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", k_rag_soc+" - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", 0)
			else
				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(row, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(row, "clie_2", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if

end choose


return k_return



end event

event dw_4::itemfocuschanged;call super::itemfocuschanged;//
long k_rc
datawindowchild kdwc_clienti, kdwc_clienti_2

if (dwo.name = "clienti_rag_soc_1" or dwo.name = "clienti_rag_soc_2"  &
   or dwo.name = "clie_1" or dwo.name = "clie_2")  &
	and ki_st_open_w.flag_modalita <> "vi" then

//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_clienti)
	k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_clienti_2)

//	k_rc = kdwc_clienti_d.settransobject(sqlca)

	if kdwc_clienti.rowcount() < 2 then
		kdwc_clienti.retrieve("%")
		kdwc_clienti.insertrow(1)
	end if

//--- copio le righe sulla seconda child clienti
	kdwc_clienti.rowscopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), &
				 		       Primary!, kdwc_clienti_2, 1, Primary!)


end if

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer y = 176
integer width = 3159
integer height = 1364
long backcolor = 32435950
string text = " Listino"
string picturename = "FormatDollar!"
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 2153
integer height = 1296
boolean enabled = true
string dataobject = "d_clienti_listino_sl_pt"
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer y = 176
integer width = 3159
integer height = 1364
boolean enabled = true
long backcolor = 32435950
string text = " Movimenti ~r~n Magazzino"
string picturename = "Graph!"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer width = 2761
integer height = 1280
boolean enabled = true
string dataobject = "d_clienti_mov"
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
boolean visible = true
integer y = 176
integer width = 3159
integer height = 1364
boolean enabled = true
long backcolor = 32435950
string text = " Fatture non di Magazzino~r~n (senza Lotto) "
long tabbackcolor = 32435950
string picturename = "Graph!"
string powertiptext = "elenco articoli senza lotto di entrata"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean visible = true
integer width = 2871
boolean enabled = true
string dataobject = "d_clienti_mov_no_meca"
end type

event dw_7::itemchanged;call super::itemchanged;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_7.dw_7.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_7.dw_7.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_7.dw_7.object.kcb_gr.text = "Dati"
	tab_1.tabpage_7.dw_7.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer y = 176
integer width = 3159
integer height = 1364
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer y = 176
integer width = 3159
integer height = 1364
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

