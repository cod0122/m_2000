$PBExportHeader$w_clienti.srw
forward
global type w_clienti from w_g_tab_3
end type
type dw_periodo from uo_dw_periodo within w_clienti
end type
end forward

global type w_clienti from w_g_tab_3
integer width = 814
integer height = 980
string title = "Anagrafica "
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
dw_periodo dw_periodo
end type
global w_clienti w_clienti

type variables
//
private kuf_clienti kiuf_clienti
private int ki_selectedtab = 1
private string ki_dwo_name_b_nazioni_l=""
//private date ki_data_ini 
//private date ki_data_fin 

public long ki_id_contatto=0 // contatto appena caricato (impostato dal pgm che lo carica)
private string ki_id_contatto_numero=""   // indicazione del contatto che sto caricando
//
private kuf_file_dragdrop kiuf_file_dragdrop
 
end variables

forward prototypes
protected function string aggiorna ()
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
private subroutine call_anagrafica_nuovo ()
public subroutine popola_dwc_3 ()
public subroutine ripopola_dwc_3 ()
private subroutine call_anagrafica_modifica (st_tab_clienti kst_tab_clienti)
private subroutine put_video_mkt_gruppo (st_tab_gru kst_tab_gru)
public subroutine check_mappa_dw4 (string k_campo, long k_riga, string k_valore)
private subroutine cambia_periodo_elenco ()
protected function integer visualizza ()
protected subroutine inizializza_1 () throws uo_exception
private subroutine u_add_memo_link (string a_file[], integer a_file_nr)
public function long u_drop_file (integer a_k_tipo_drag, long a_handle)
public subroutine u_retrieve_associazioni ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
long k_riga
boolean k_new_rec
st_esito kst_esito
st_tab_ind_comm kst_tab_ind_comm
st_tab_clienti kst_tab_clienti
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_clienti_web kst_tab_clienti_web
kuf_utility kuf1_utility

 
//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	then

	if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
		k_new_rec = true
	else
		k_new_rec = false
	end if


	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito = kkg_esito.db_ko then
			k_return = "3" + "Archivio " + tab_1.tabpage_4.text + " " + kst_esito.sqlerrtext
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
				kst_tab_ind_comm.id_nazione_c = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione_c")
				kiuf_clienti.tb_update_ind_comm(kst_tab_ind_comm)
				
				kst_tab_clienti_fatt.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice")
				kst_tab_clienti_fatt.fattura_da = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fattura_da")
				kst_tab_clienti_fatt.note_1 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1")
				kst_tab_clienti_fatt.note_2 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_2")
				kst_tab_clienti_fatt.modo_stampa = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "modo_stampa")
				kst_tab_clienti_fatt.modo_email = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "modo_email")
				kst_tab_clienti_fatt.email_invio = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "email_invio")
				kst_tab_clienti_fatt.impon_minimo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "impon_minimo")
				kst_tab_clienti_fatt.codice_ipa = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "codice_ipa")
				kiuf_clienti.tb_update(kst_tab_clienti_fatt)
				
			end if
		end if
	else
		
		kst_esito = kguo_sqlca_db_magazzino.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
	end if
end if 

//=== Aggiorna, se modificato, la TAB_3 MARKETING+WEB
if left(k_return,1) = "0" and tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 	then
	k_riga = 1

	tab_1.tabpage_3.dw_3.setitem(k_riga, "id_cliente", tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "codice"))
	
//--- marketing
	kst_tab_clienti_mkt.id_cliente = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_cliente")
	kst_tab_clienti_mkt.tipo_rapporto = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "tipo_rapporto")
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
	kst_tab_clienti_mkt.id_cliente_link = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_cliente_link")
	kst_tab_clienti_mkt.note_attivita = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_note_attivita")
	kst_tab_clienti_mkt.note_prodotti = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_note_prodotti")
	kst_tab_clienti_mkt.qualifica = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "clienti_mkt_qualifica")
	kst_tab_clienti_mkt.gruppo = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "gruppo")
	kst_tab_clienti_mkt.doc_esporta = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "doc_esporta")
	kst_tab_clienti_mkt.doc_esporta_prefpath = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "doc_esporta_prefpath")
	kst_esito = kiuf_clienti.tb_update(kst_tab_clienti_mkt)
	if kst_esito.esito <> kkg_esito.db_ko then

//--- Dati WEB
		kst_tab_clienti_web.id_cliente = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_cliente")
		kst_tab_clienti_web.blog_web = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "blog_web")
		kst_tab_clienti_web.blog_web1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "blog_web1")
		kst_tab_clienti_web.email = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email")
		kst_tab_clienti_web.email1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email1")
		kst_tab_clienti_web.email2 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email2")
		kst_tab_clienti_web.email3 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "email3")
		kst_tab_clienti_web.email_prontomerce = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "email_prontomerce")
		kst_tab_clienti_web.note = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "note")
		kst_tab_clienti_web.sito_web = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "sito_web")
		kst_tab_clienti_web.sito_web1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "sito_web1")
		kst_esito = kiuf_clienti.tb_update(kst_tab_clienti_web)
			
		if kst_esito.esito = kkg_esito.ok then
			tab_1.tabpage_3.dw_3.resetupdate( )
		end if
	end if
	
end if



//=== Aggiorna, se modificato, la TAB_4 MANDANTI-RICEVENTI-FATTURATO
if left(k_return,1) = "0" and tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 	then
//	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 

	if tab_1.tabpage_4.dw_4.update() = 1 then

//--- Se tutto OK faccio la COMMIT		
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito = kkg_esito.db_ko then
			k_return = "3" + "Archivio " + tab_1.tabpage_4.text + " " + kst_esito.sqlerrtext
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
		end if
	else
		kst_esito = kguo_sqlca_db_magazzino.db_rollback()
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

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_clie_1=0, k_clie_2
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
st_esito kst_esito
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f
st_tab_memo kst_tab_memo
kuf_memo kuf1_memo


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
	case 2
		k_record = " Memo "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_memo")
				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "memo_titolo")
				k_record_1 = &
					"Sei sicuro di voler eliminare il Memo id " + string(k_key) + "~n~r" &
					+ "titolo " + trim(k_desc) + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
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
			case 2 
				try
					kuf1_memo = create kuf_memo
					kst_tab_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_memo")
					kuf1_memo.tb_delete(kst_tab_memo) 
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
					if kst_esito.esito <> kkg_esito.ok then
						k_errore = "1"
					end if
				end try
			case 4
				kst_tab_clienti_m_r_f.clie_1 = k_clie_1
				kst_tab_clienti_m_r_f.clie_2 = k_clie_2
				kst_tab_clienti_m_r_f.clie_3 = k_key
				k_errore = kiuf_clienti.tb_delete_m_r_f(kst_tab_clienti_m_r_f) 
		end choose	
		if left(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 2 
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
					case 4 
						tab_1.tabpage_4.dw_4.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

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
	case 2 
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
		tab_1.tabpage_2.dw_2.ResetUpdate ( ) 
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
//===			            : 3=dati insufficienti; 4=OK ma errore non grave
//===                        : 5=OK con degli avvertimenti
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

//--- Se nazione assente forza IT: 18-10-2011 Marisa
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1"))) = 0 &
		or isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) then
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "id_nazione_1", "IT")
	end if

//--- controlli validi solo se anagrafica ITALIANA
	if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT" then

		if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 &
			or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "prov_1"))) > 0 then

//--- controllo del CAP 1
			if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))) > 0 then
		
				kst_tab_cap.cap =  trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cap_1"))
				kst_esito = kuf1_ausiliari.tb_select(kst_tab_cap)
				if kst_esito.esito = kkg_esito.ok then
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
					if isnull(kst_tab_cap.cap) then 
						kst_tab_cap.cap = " "
					end if
					if kst_esito.esito = kkg_esito.ok then
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
		if kst_esito.esito <> kkg_esito.ok then
			k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
			k_errore = "1"
			k_nr_errori++
		end if
	end if


//--- controllo della PIVA solo SE ITALIA
	kst_tab_clienti.p_iva = ""
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))) > 0 then
		kst_tab_clienti.codice = k_key
		kst_tab_clienti.p_iva = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "p_iva"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "p_iva", kst_tab_clienti.p_iva)
		kst_esito = kiuf_clienti.conta_p_iva(kst_tab_clienti)
		if kst_esito.esito = "0" then
			if kst_tab_clienti.contati > 0 then 
				k_return = k_return &
				           + tab_1.tabpage_1.text + ": Partita IVA già utilizzata x altra Anagrafica " + "~n~r" 
				k_errore = "4"
				k_nr_errori++
			end if
		end if
		if k_errore = "0" or k_errore = "4" or k_errore = "5"  then
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "id_nazione_1")) = "IT" then

				kst_esito = kiuf_clienti.check_piva(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito.ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if
		
//--- controllo del Codice Fiscale solo SE ITALIA e se DIVERSO dalla P.IVA
	if len(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))) > 0 then
		kst_tab_clienti.cf = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "cf"))
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "cf", kst_tab_clienti.cf)
		if k_errore = "0" or k_errore = "4" or k_errore = "5"  then
			if (kst_tab_clienti.p_iva <> kst_tab_clienti.cf) and (trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione_1")) = "IT" &
						or trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione_1")) = "" &
						or isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "id_nazione_1")) 	) then

				kst_esito = kiuf_clienti.check_cf(kst_tab_clienti)
				if kst_esito.esito <> kkg_esito.ok then
					k_return += tab_1.tabpage_1.text + ": " + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
	end if

//--- controllo Indice-IPA (cod pubblica amministrazione)
	if k_errore = "0" or k_errore = "4" or k_errore = "5"  then
		if  len(trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "codice_ipa"))) > 0 then
			if  len(trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "codice_ipa"))) < 6 then
				k_return = tab_1.tabpage_1.text + ": Secondo le specifiche tecniche il campo '" + tab_1.tabpage_1.dw_1.object.codice_ipa_t.text + "' deve essere di 6 caratteri. " + "~n~r"
				k_errore = "5"
				k_nr_errori++
		
			end if
		end if
	end if
	
//--- controllo dati e-mail
	if k_errore = "0" or k_errore = "4" or k_errore = "5"  then
		if not isnull(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "modo_email")) and trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "modo_email")) <> kiuf_clienti.kki_fatt_modo_email_nulla &
					and len(trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "modo_email"))) > 0 &
					and (len(trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email_invio"))) = 0 or trim(tab_1.tabpage_1.dw_1.getitemstring( k_riga, "email_invio")) = "0") then 
			k_return = tab_1.tabpage_1.text + ": Indicare il valore nel campo  '" + tab_1.tabpage_1.dw_1.object.email_invio_t.text + "'  " + "~n~r"
			k_errore = "5"
			k_nr_errori++
		else
		end if
	end if
	
	if k_errore = "0" or k_errore = "4" or k_errore = "5"  then
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
		if k_anno = 0 then k_anno = kguo_g.get_anno( )
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
	if	k_errore = "0" or k_errore = "4" or k_errore = "5"  then
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

	
//--- Controllo altro tab --------------------------------------------------------------------------------------------------------------------------------
	try
		if k_errore = "0" or k_errore = "4" or k_errore = "5" then
			
			k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
			k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) 
			if k_riga > 0 then
			
//--- controllo se il codice doc_esporta_prefpath è  già usato per lo stesso ruolo
				kst_tab_clienti_mkt.id_cliente =  tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "id_cliente")
				kst_tab_clienti_mkt.doc_esporta_prefpath = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "doc_esporta_prefpath")
				if len(trim(kst_tab_clienti_mkt.doc_esporta_prefpath)) > 0 then
					if kiuf_clienti.if_esiste_doc_esporta_prefpath(kst_tab_clienti_mkt) then
						k_return += "Il valore nel '" + trim( tab_1.tabpage_3.dw_3.object.doc_esporta_prefpath_t.text) + "' (" + trim(kst_tab_clienti_mkt.doc_esporta_prefpath)+") è gia' stato usato. Sicure che vuoi ESPORTARE i documenti nella stessa cartella?? " + "~n~r"
						k_errore = "4"
					end if
				end if	
				
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
					kuf1_web.url_aggiusta_http( kst_web ) //aggiunge http:// all'indirizzo
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
					kuf1_web.url_aggiusta_http( kst_web ) //aggiunge http:// all'indirizzo
					tab_1.tabpage_3.dw_3.setitem( k_riga, "sito_web1", kst_web.url)
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
		
	
	catch(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		k_errore = "1" + trim(kst_esito.sqlerrtext)
	
	finally
		if isvalid(kuf1_web) then destroy kuf1_web
	
	end try

	
//--- Controllo altro tab --------------------------------------------------------------------------------------------------------------------------------
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

			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
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
	 	or tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0  & 
	 	or tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0  & 
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
//datawindowchild  kdwc_clienti_1, kdwc_clienti_2 
datawindowchild kdwc_iva, kdwc_pag
kuf_utility kuf1_utility
datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo

//

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
ki_selectedtab = 1

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if isnumber(ki_st_open_w.key1) then
		k_key = long(trim(ki_st_open_w.key1))
	else
		k_key = 0
	end if

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

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

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
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

				if k_scelta = kkg_flag_modalita.modifica then
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
				if k_scelta = kkg_flag_modalita.inserimento then
					SetPointer(oldpointer)
					messagebox("Trovata Anagrafica", &
						"Anagrafica  gia' in archivio ~n~r" + &
						"(ID cercato: " + string(k_key) + ")~n~r" )
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

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

if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta

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

		 if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then
//--- Identifica il tipo Anagrafica
			try
				kst_tab_clienti.tipo_mrf = kiuf_clienti.get_tipo(kst_tab_clienti)
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
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try
		end if
		
	end if
	
	destroy kuf1_utility

end if

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_1.dw_1))

//tab_1.tabpage_1.dw_1.resetupdate()

SetPointer(oldpointer)

return "0"


end function

protected subroutine inizializza_3 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_4, k_rc
string k_scelta, k_codice_prec
int k_ctr=0
datawindowchild kdwc_clienti_1, kdwc_clienti_2, kdwc_gru
kuf_utility kuf1_utility


ki_selectedtab = 4

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
	
//--- Attivo dw archivio GRUPPI
		k_rc = tab_1.tabpage_4.dw_4.getchild("gru", kdwc_gru)
		k_rc = kdwc_gru.settransobject(sqlca)
		if kdwc_gru.rowcount() = 0 then
			kdwc_gru.insertrow(1)
		end if
		
	end if

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
	kuf1_utility = create kuf_utility
	tab_1.tabpage_4.st_4_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	
	if tab_1.tabpage_4.st_4_retrieve.text <> k_codice_prec then

      	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
	
		if tab_1.tabpage_4.dw_4.retrieve(k_codice)  < 1 then
			inserisci()
		end if
	end if
	
	attiva_tasti()

		
end if



	


end subroutine

protected function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_codice, k_nro_commessa, k_riga, k_id_cliente, k_id_protocollo
//datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
st_tab_clienti_memo kst_tab_clienti_memo
st_memo kst_memo
kuf_base kuf1_base
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout
kuf_utility kuf1_utility 
kuf_sr_sicurezza kuf1_sr_sicurezza


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
//	choose case tab_1.selectedtab 
	choose case ki_selectedtab 

		case  1 
			
//--- prima di tutto disabilito e resetto gli altri tab			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			
				tab_1.tabpage_2.enabled = false
				tab_1.tabpage_4.enabled = false
				tab_1.tabpage_5.enabled = false
				tab_1.tabpage_6.enabled = false
				tab_1.tabpage_7.enabled = false
				tab_1.tabpage_2.dw_2.reset ()
				tab_1.tabpage_4.dw_4.reset ()
				tab_1.tabpage_5.dw_5.reset ()
				tab_1.tabpage_6.dw_6.reset ()
				tab_1.tabpage_7.dw_7.reset ()
				
			end if
			
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				tab_1.tabpage_1.dw_1.reset() 
			end if
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setitem(k_ctr, "codice", 0)
			tab_1.tabpage_1.dw_1.setcolumn("p_iva")
			
			tab_1.tabpage_1.dw_1.SetItemStatus( 1, 0, Primary!, NotModified!)

			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

			
		case 2 // allegati
			try
				kst_tab_clienti_memo.id_cliente_memo = 0
				kuf1_sr_sicurezza = create kuf_sr_sicurezza
				kuf1_memo = create kuf_memo
				kuf1_memo_inout = create kuf_memo_inout
				kst_tab_clienti_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ki_st_open_w.id_programma)
				kst_tab_clienti_memo.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
				kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
				kuf1_memo_inout.memo_xcliente(kst_memo.st_tab_clienti_memo, kst_memo.st_tab_memo)
				kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
			end try


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

			   	kuf1_utility = create kuf_utility 
		      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)  //--- Abilita campi alla modifica 
	
				tab_1.tabpage_4.dw_4.setitem(k_riga, "m_r_f_clie_3", k_codice)
	
				tab_1.tabpage_4.dw_4.setcolumn("clie_1")
				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
				tab_1.tabpage_4.dw_4.setrow(k_riga)

			end if
				
//		case 5 // listino
//				k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "codice") 
//				k_cod_art = ""
//				k_dose = 0
//				k_mis_x = 0
//				k_mis_y = 0
//				k_mis_z = 0
//				K_st_open_w.id_programma = kkg_id_programma.listini
//				K_st_open_w.flag_primo_giro = "S"
//				K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
//				K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
//				K_st_open_w.flag_leggi_dw = " "
//				K_st_open_w.flag_cerca_in_lista = " "
//				K_st_open_w.key1 = trim(string(k_cod_cli)) // cod cliente
//				K_st_open_w.key2 = trim(k_cod_art) // cod articolo 
//				K_st_open_w.key3 = trim(string(k_dose)) // dose
//				K_st_open_w.key4 = trim(string(k_mis_x)) // misure imballo
//				K_st_open_w.key5 = trim(string(k_mis_y)) // misure imballo
//				K_st_open_w.key6 = trim(string(k_mis_z)) // misure imballo
//				K_st_open_w.flag_where = " "
//				
//				kuf1_menu_window = create kuf_menu_window 
//				kuf1_menu_window.open_w_tabelle(k_st_open_w)
//				destroy kuf1_menu_window
//											
//			else
//			
//				messagebox("Operazione non eseguita", "Nessun cliente presente")
//			
//			end if
				
			
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
if tab_1.tabpage_3.dw_3.rowcount() > 0 then
	tab_1.tabpage_3.dw_3.accepttext()
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

	tab_1.tabpage_1.dw_1.setitem(k_ctr, "x_datins", kGuf_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(k_ctr, "x_utente", kGuf_data_base.prendi_x_utente())
	
	if tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "stato") > " "  then
	else
		if tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "clienti_tipo") = "M"  then
			if tab_1.tabpage_1.dw_1.getitemdate(k_ctr, "data_attivazione") > kkg.data_zero then
				tab_1.tabpage_1.dw_1.setitem ( k_ctr, "stato", kiuf_clienti.kki_cliente_stato_attivo ) 
			else
				tab_1.tabpage_1.dw_1.setitem ( k_ctr, "stato", kiuf_clienti.kki_cliente_stato_attivo_parziale ) 
			end if
		else
			tab_1.tabpage_1.dw_1.setitem ( k_ctr, "stato", kiuf_clienti.kki_cliente_stato_attivo ) 
		end if
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "cadenza_fattura")) then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "cadenza_fattura", kiuf_clienti.kki_cliente_fattura_mai ) 
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
	
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "modo_stampa")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "modo_stampa"))) = 0 then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "modo_stampa", kiuf_clienti.kki_fatt_modo_stampa_cartaceo_digitale ) 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "modo_email")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "modo_email"))) = 0 then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "modo_email", kiuf_clienti.kki_fatt_modo_email_nulla ) 
	end if
	if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "email_invio")) or len(trim(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "email_invio"))) = 0 then
		tab_1.tabpage_1.dw_1.setitem ( k_ctr, "email_invio", "0" ) 
	end if
		
	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_ctr = 1 to k_righe 

		tab_1.tabpage_4.dw_4.setitem(k_ctr, "m_r_f_clie_3", k_codice_1)
				
	end for

end if

end subroutine

protected subroutine open_start_window ();//
	kiuf_clienti = create kuf_clienti
//	this.tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\" + "cliente.gif"
//	this.tab_1.tabpage_3.picturename = kGuo_path.get_risorse() + "\" + "torta.gif"
//	this.tab_1.tabpage_6.picturename = kGuo_path.get_risorse() + "\" + "stat_1.gif"
//	this.tab_1.tabpage_7.picturename = kGuo_path.get_risorse() + "\" + "stat_2.gif"

	this.tab_1.tabpage_1.picturename = "cliente.gif"
	this.tab_1.tabpage_3.picturename = "torta.gif"
	this.tab_1.tabpage_6.picturename = "stat_1.gif"
	this.tab_1.tabpage_7.picturename = "stat_2.gif"

	ki_toolbar_window_presente=true

//--- inizializza box periodo
	dw_periodo.inizializza( kiw_this_window )
//	ki_data_ini = relativedate(kg_dataoggi, -31)
//	ki_data_fin = kg_dataoggi

end subroutine

protected subroutine inizializza_4 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_id_cliente
string k_scelta, k_codice_prec
int k_rc
kuf_utility kuf1_utility

boolean k_return
kuf_sicurezza kuf1_sicurezza
kuf_listino kuf1_listino
st_open_w kst_open_w


ki_selectedtab = 5


kuf1_listino = create kuf_listino
kst_open_w.flag_modalita = kkg_flag_modalita.elenco
kst_open_w.id_programma = kuf1_listino.get_id_programma(kst_open_w.flag_modalita)
destroy kuf1_listino


kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	tab_1.tabpage_5.dw_5.dataobject = "d_funz_no_aut"
	tab_1.tabpage_5.dw_5.insertrow(0)
	tab_1.tabpage_5.dw_5.object.funzione[1] = trim(kst_open_w.id_programma) + "  (" + kst_open_w.flag_modalita + ") "

else

	if tab_1.tabpage_5.dw_5.dataobject <> "d_clienti_listino_l" then
		tab_1.tabpage_5.dw_5.dataobject = "d_clienti_listino_l" 
		tab_1.tabpage_5.dw_5.settransobject( sqlca)
	end if

	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_5.st_5_retrieve.text
	kuf1_utility = create kuf_utility
	tab_1.tabpage_5.st_5_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility
	
	if tab_1.tabpage_5.st_5_retrieve.text <> k_codice_prec then

//=== Parametri : cliente, articolo, sl-pt
		tab_1.tabpage_5.dw_5.retrieve(k_codice, date(0), 0)

	end if
	
	attiva_tasti( )
	
end if

tab_1.tabpage_5.dw_5.setfocus()
	

end subroutine

protected subroutine inizializza_5 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 6 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_3
string k_scelta, k_estrazione, k_codice_prec
date k_data_int
kuf_base kuf1_base 
//kuf_utility kuf1_utility



	ki_selectedtab = 6
	
	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	k_scelta = trim(ki_st_open_w.flag_modalita)
	k_data_int = dw_periodo.get_data_ini( ) // ki_data_ini   // date(year(kg_dataoggi) - 1 , 01, 01) //RelativeDate(today(), -365)
	
//--- Acchiappo il codice CLIENTE x evitare la rilettura
//	if IsNumber(tab_1.tabpage_6.dw_6.Object.k_codice.Text) then
//		k_codice_3 = long(tab_1.tabpage_6.dw_6.Object.k_codice.Text)
//	else
//		k_codice_3 = 0
//	end if
	
//=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//	tab_1.tabpage_6.dw_6.Object.k_codice.Text=string(k_codice) + string(ki_data_ini) + string(ki_data_fin)

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//--- salvo i parametri cosi come sono stati immessi x evitare la rilettura
	k_codice_prec = tab_1.tabpage_6.st_6_retrieve.text
	tab_1.tabpage_6.st_6_retrieve.text = string(k_codice) + string( dw_periodo.get_data_ini( )) + string( dw_periodo.get_data_fin( ))
	
	if tab_1.tabpage_6.st_6_retrieve.text = k_codice_prec then
	else

		kuf1_base = create kuf_base 
//--- reperisce l'ultima estremi estrazione	
		k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		tab_1.tabpage_6.dw_6.object.t_estrazione.text = trim(k_estrazione)
	
		tab_1.tabpage_6.dw_6.retrieve(k_codice, k_data_int,  dw_periodo.get_data_fin( ))


	end if
	
	attiva_tasti()



end subroutine

private subroutine call_elenco_capitolati ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = "*" // flag attivi
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_fatture ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if tab_1.tabpage_1.dw_1.getrow() > 0 then

	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber( tab_1.tabpage_1.dw_1.getrow(), "codice") 

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture_elenco
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = " "  //data da  
	K_st_open_w.key3 = " "  //data a
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window

else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_contratti ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_listino ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // cod articolo 
		K_st_open_w.key3 = " " // dose
		K_st_open_w.key4 = " " // misure imballo
		K_st_open_w.key5 = " " // misure imballo
		K_st_open_w.key6 = " " // misure imballo
		K_st_open_w.flag_where = " "
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_stat_fatt ();//
string k_anno
long k_id_cliente
kuf_base kuf1_base
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


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
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window

								
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


choose case k_par_in

//	case KKG_FLAG_RICHIESTA.refresh		//aggiorna lista
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			ripopola_dwc_3 ()  //--- popla le dw child del tab 3
//		end if

	case kkg_flag_richiesta.libero1		//Contratti...
		call_elenco_capitolati()

	case kkg_flag_richiesta.libero2		//Contratti...
		call_elenco_contratti()

	case kkg_flag_richiesta.libero3		//Listino...
		call_elenco_listino()

	case kkg_flag_richiesta.libero4		//Fatture...
		call_elenco_fatture()

	case kkg_flag_richiesta.libero6		//cambia data di estrazione
		cambia_periodo_elenco()
		
	case kkg_flag_richiesta.libero8		//Statistica...
		call_elenco_stat_fatt()


	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
boolean k_insert = true
//


	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		k_insert = false
	end if

	
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_insert or not ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible then
		
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Capitolati dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Capitolato,Elenco Capitolati dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = k_insert
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "CO,Conferme Ordini dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Contratti per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"Contratti,Elenco Contratti dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = k_insert
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "Contr.,Elenco Contratti dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
	
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Listini dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
		"Listini,Elenco Listini dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = k_insert
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini,Elenco Listini dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Elenco documenti di vendita "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
		"Fatture, Elenco documenti di vendita  "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = k_insert
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Fatture, Elenco documenti di vendita  "
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName =kGuo_path.get_risorse() +  "\fattura16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName ="fattura16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = false
	
		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Cambia il periodo di estrazione scheda elenco Movimenti (data Lotto / Fattura)"
		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp =  "Cambia periodo di estrazione Movimenti"
		ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero6.text
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Estrazione statistico 'Fatturazione' dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = &
		"Stat.Fatt,Estrazione statistico di magazzino dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = k_insert
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText =  "Stat.,Estrazione statistico 'Fatturazione' dell'anagrafica"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Graph!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = false
	end if
	
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()

end subroutine

protected subroutine inizializza_6 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 6 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_codice_3
string k_scelta, k_estrazione, k_codice_prec
date k_data_int
kuf_base kuf1_base 

boolean k_sicurezza
kuf_fatt kuf1_fatt
//st_open_w kst_open_w




ki_selectedtab = 7

k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
k_scelta = trim(ki_st_open_w.flag_modalita)
k_data_int =  dw_periodo.get_data_ini( ) //ki_data_ini // date(year(kg_dataoggi) - 1 , 01, 01) //RelativeDate(today(), -365)

////--- Acchiappo il codice CLIENTE x evitare la rilettura
//if IsNumber(tab_1.tabpage_7.dw_7.tag) then
//	k_codice_3 = long(tab_1.tabpage_7.dw_7.tag)
//else
//	k_codice_3 = 0
//end if
////=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//tab_1.tabpage_7.dw_7.tag =string(k_codice, "####0")

//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
if k_codice = 0 then
	inserisci()
	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
end if


kuf1_fatt = create kuf_fatt
k_sicurezza = kuf1_fatt.if_sicurezza(kkg_flag_modalita.elenco)

if not k_sicurezza then

	tab_1.tabpage_7.dw_7.dataobject = "d_funz_no_aut"
	tab_1.tabpage_7.dw_7.insertrow(0)
	tab_1.tabpage_7.dw_7.object.funzione[1] = trim(kuf1_fatt.get_id_programma(kkg_flag_modalita.elenco)) + "  (" + kkg_flag_modalita.elenco + ") "

else

	if tab_1.tabpage_7.dw_7.dataobject <> "d_clienti_mov_no_meca" then
		tab_1.tabpage_7.dw_7.dataobject = "d_clienti_mov_no_meca" 
		tab_1.tabpage_7.dw_7.settransobject( sqlca)
	end if

	
//--- salvo i parametri cosi come sono stati immessi x evitare la rilettura
	k_codice_prec = tab_1.tabpage_6.st_6_retrieve.text
	tab_1.tabpage_6.st_6_retrieve.text = string(k_codice) + string( dw_periodo.get_data_ini( )) + string( dw_periodo.get_data_fin( )) + tab_1.tabpage_7.dw_7.dataobject
	
	if tab_1.tabpage_7.st_7_retrieve.text = k_codice_prec then
	else

		kuf1_base = create kuf_base 
//--- reperisce l'ultima estremi estrazione	
		k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		tab_1.tabpage_7.dw_7.object.t_estrazione.text = trim(k_estrazione)
	
		tab_1.tabpage_7.dw_7.retrieve(k_codice, dw_periodo.get_data_ini( ),  dw_periodo.get_data_fin( ))

	end if

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
//if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
//
	k_return = k_rc_retrieve
//	
//	if kst_esito.esito = kkg_esito.ok then
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

			  
		tab_1.tabpage_1.dw_1.resetupdate( )

//	end if
	
else
	if k_rc_retrieve = 0 then
//	if kst_esito.esito = kkg_esito.not_fnd then
		
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


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

ki_selectedtab = 3

tab_1.tabpage_3.dw_3.ki_flag_modalita = ki_st_open_w.flag_modalita

	
if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber( 1, "codice")
else
	kst_tab_clienti.codice = 0
end if

if tab_1.tabpage_3.dw_3.rowcount() = 0 then

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		popola_dwc_3 ()  //--- popola le dw child del tab 3
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

//--- allineo il valore del campo di avvsio email x la fatturazione che è sulla prima mappa 
if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
	tab_1.tabpage_3.dw_3.setitem(1, "email_invio", tab_1.tabpage_1.dw_1.getitemstring( 1, "email_invio"))
end if

//--- Inabilita campi alla modifica se Vsualizzazione
kuf1_utility = create kuf_utility 
if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then

	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)

else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)

end if
destroy kuf1_utility


//--- attiva eventuale Drag&Drop di files da Windows	Explorer
if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_2.dw_2))

//tab_1.tabpage_3.dw_3.resetupdate()
tab_1.tabpage_3.dw_3.setfocus()

SetPointer(oldpointer)



end subroutine

private subroutine put_video_mkt_cliente_link (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente LINK su mappa MKT 
//



tab_1.tabpage_3.dw_3.modify( "c_link_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem( 1, "c_link_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_3.dw_3.setitem( 1, "id_cliente_link" , kst_tab_clienti.codice )

end subroutine

private subroutine put_video_mkt_contatti (integer k_nr_contatto, st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Contatto 1-5 su mappa MKT 
//



tab_1.tabpage_3.dw_3.modify( "c" + string(k_nr_contatto) + "_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem( 1, "c" + string(k_nr_contatto) + "_rag_soc_10", kst_tab_clienti.rag_soc_10 )
tab_1.tabpage_3.dw_3.setitem( 1, "id_contatto_" + string(k_nr_contatto) , kst_tab_clienti.codice )

end subroutine

private subroutine call_anagrafica_nuovo ();//
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window




//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto

		K_st_open_w.id_programma = kkg_id_programma_anag_rid
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "0" //"1" 
		K_st_open_w.key1 = " "
		K_st_open_w.key2 = ""
		K_st_open_w.key3 =  ki_id_contatto_numero
		K_st_open_w.key4 = " " 
		K_st_open_w.key5 = " " 
		K_st_open_w.key6 = " " 
		K_st_open_w.flag_where = " "
		K_st_open_w.key12_any = kidw_selezionata
		
		//kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
		//destroy kuf1_menu_window
								


end subroutine

public subroutine popola_dwc_3 ();
//--- popola le dwc del TAB 3

datawindowchild kdwc_c_link, kdwc_contatti1,  kdwc_contatti2,  kdwc_contatti3,  kdwc_contatti4,  kdwc_contatti5, kdwc_gru 



//--- Attivo dw Clienti in LINK
		tab_1.tabpage_3.dw_3.getchild("c_link_rag_soc_10", kdwc_c_link)
		kdwc_c_link.settransobject(sqlca)
		if kdwc_c_link.rowcount() = 0 then
			kdwc_c_link.retrieve("*")
			kdwc_c_link.insertrow(1)
		end if

//--- Attivo dw GRUPPI
		tab_1.tabpage_3.dw_3.getchild("gruppo", kdwc_gru)
		kdwc_gru.settransobject(sqlca)
		if kdwc_gru.rowcount() = 0 then
			kdwc_gru.retrieve("")
			kdwc_gru.insertrow(1)
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

end subroutine

public subroutine ripopola_dwc_3 ();
//--- popola le dwc del TAB 3

datawindowchild kdwc_c_link, kdwc_contatti1,  kdwc_contatti2,  kdwc_contatti3,  kdwc_contatti4,  kdwc_contatti5 



//--- Resetta tutti i DWC e poi RI-POPOLA!!
		tab_1.tabpage_3.dw_3.getchild("c_link_rag_soc_10", kdwc_c_link)
		kdwc_c_link.settransobject(sqlca)
		kdwc_c_link.reset()

		tab_1.tabpage_3.dw_3.getchild("c1_rag_soc_10", kdwc_contatti1)
		kdwc_contatti1.settransobject(sqlca)
		kdwc_contatti1.reset()
		
		tab_1.tabpage_3.dw_3.getchild("c2_rag_soc_10", kdwc_contatti2)
		kdwc_contatti2.settransobject(sqlca)
		kdwc_contatti2.reset()
		
		tab_1.tabpage_3.dw_3.getchild("c3_rag_soc_10", kdwc_contatti3)
		kdwc_contatti3.settransobject(sqlca)
		kdwc_contatti3.reset()
		
		tab_1.tabpage_3.dw_3.getchild("c4_rag_soc_10", kdwc_contatti4)
		kdwc_contatti4.settransobject(sqlca)
		kdwc_contatti4.reset()
		
		tab_1.tabpage_3.dw_3.getchild("c5_rag_soc_10", kdwc_contatti5)
		kdwc_contatti5.settransobject(sqlca)
		kdwc_contatti5.reset()
			
		popola_dwc_3()
		


end subroutine

private subroutine call_anagrafica_modifica (st_tab_clienti kst_tab_clienti);//
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window




//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto

	K_st_open_w.id_programma = kkg_id_programma_anag_rid
	K_st_open_w.flag_primo_giro = "S"
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	else
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = "0" //"1" 
	K_st_open_w.key1 = string(kst_tab_clienti.codice)
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " " 
	K_st_open_w.key5 = " " 
	K_st_open_w.key6 = " " 
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
							


end subroutine

private subroutine put_video_mkt_gruppo (st_tab_gru kst_tab_gru);//
//--- Visualizza dati Cliente il Codice Gruppo su mappa MKT 
//



tab_1.tabpage_3.dw_3.modify( "gruppo.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_3.dw_3.setitem( 1, "gru_des", kst_tab_gru.des )
tab_1.tabpage_3.dw_3.setitem( 1, "gruppo" , kst_tab_gru.codice )

end subroutine

public subroutine check_mappa_dw4 (string k_campo, long k_riga, string k_valore);//---
//--- Controlla la Mappa del DW4
//---

string k_rag_soc, k_codice
long k_rc
datawindowchild kdwc_cli


choose case upper(k_campo)

	case "CLIENTI_RAG_SOC_1" 

		k_rag_soc = Trim(k_valore)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			if k_rc <= 0 or isnull(k_rc) then
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_1", k_rag_soc+" - NON TROVATO -")
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_1", 0)
			else
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_rc, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_1", kdwc_cli.getitemnumber(k_rc, "id_cliente"))
			end if
			
		end if

	
	case "CLIENTI_RAG_SOC_2" 
	
		k_rag_soc = Trim(k_valore)
		if isnull(k_rag_soc) = false and len(trim(k_rag_soc)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			if k_rc <= 0 or isnull(k_rc) then
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_2", " - NON TROVATO -")
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_2", 0)
			else
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_rc, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_2", kdwc_cli.getitemnumber(k_rc, "id_cliente"))
			end if
			
		end if
	
		
	case "CLIE_1" 
	
		if isnumber(Trim(k_valore)) then
			k_codice = Trim(k_valore)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_1", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			if k_rc <= 0 or isnull(k_rc) then
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_1", " - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_1", 0)
			else
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_1", kdwc_cli.getitemstring(k_rc, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_1", kdwc_cli.getitemnumber(k_rc, "id_cliente"))
			end if
			
		end if
		
	case "CLIE_2" 
	
		if isnumber(Trim(k_valore)) then
			k_codice = Trim(k_valore)
		else
			k_codice = "0"
		end if
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			
			k_rc = tab_1.tabpage_4.dw_4.getchild("clienti_rag_soc_2", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente = "+k_codice+" ",0,kdwc_cli.rowcount())
			if k_rc <= 0 or isnull(k_rc) then
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_2", k_rag_soc+" - NON TROVATO -")
//				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_2", 0)
			else
//				k_return = 2
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clienti_rag_soc_2", kdwc_cli.getitemstring(k_rc, "rag_soc_1"))
				tab_1.tabpage_4.dw_4.setitem(k_riga, "clie_2", kdwc_cli.getitemnumber(k_rc, "id_cliente"))
			end if
			
		end if

end choose






end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

protected function integer visualizza ();//
long k_riga = 0
st_memo kst_memo
datastore kds_1
//kuf_menu_window kuf1_menu_window
kuf_memo kuf1_memo

try

	choose case ki_selectedtab 

		case 2 // allegati
			kuf1_memo = create kuf_memo
			k_riga = tab_1.tabpage_2.dw_2.getrow()
			if k_riga > 0 then
			else
				if tab_1.tabpage_2.dw_2.rowcount() = 1 then
					k_riga = 1
				end if
			end if
			if k_riga > 0 then
				kst_memo.st_tab_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_memo")
				if kst_memo.st_tab_memo.id_memo > 0 then
					kuf1_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione )
				end if
			end if
		
		
		case 5 // listino

			if tab_1.tabpage_5.dw_5.getrow( ) > 0 then
				
		//--- call della window che esegue la funzione
				kds_1 = create datastore
				kds_1.dataobject = tab_1.tabpage_5.dw_5.dataobject
				tab_1.tabpage_5.dw_5.rowscopy( tab_1.tabpage_5.dw_5.getrow( ) , tab_1.tabpage_5.dw_5.getrow( ), primary!, kds_1, 1, primary!)
		
				//kuf1_menu_window = create kuf_menu_window
				kGuf_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.visualizzazione)
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione di Visualizzazione", "Selezionare prima una riga dall'elenco")
			end if

	end choose
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return 0
end function

protected subroutine inizializza_1 () throws uo_exception;////======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
long k_codice, k_id_cliente, k_righe=0
string k_scelta, k_codice_prec
int k_rc

boolean k_return
kuf_memo kuf1_memo


ki_selectedtab = 2

//kuf1_memo = create kuf_memo
//k_return = kuf1_memo.if_sicurezza( kkg_flag_modalita.elenco)
//
//if not k_return then
//
//	tab_1.tabpage_2.dw_2.dataobject = "d_funz_no_aut"
//	tab_1.tabpage_2.dw_2.insertrow(0)
//	tab_1.tabpage_2.dw_2.object.funzione[1] = trim(kuf1_memo.get_id_programma(kkg_flag_modalita.elenco)) + "  (" + kkg_flag_modalita.elenco + ") "
//
//else

	if tab_1.tabpage_2.dw_2.dataobject <> "d_clienti_memo_l" then
		tab_1.tabpage_2.dw_2.dataobject = "d_clienti_memo_l" 
		tab_1.tabpage_2.dw_2.settransobject( sqlca)
	end if

	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
//=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
	if k_codice = 0 then
		inserisci()
		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
	end if

//--- salvo i parametri cosi come sono stati immessi
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
	tab_1.tabpage_2.st_2_retrieve.Text = string(tab_1.tabpage_1.dw_1.getitemnumber(1, "codice") )
	
	if tab_1.tabpage_2.st_2_retrieve.text <> k_codice_prec then

		k_righe = tab_1.tabpage_2.dw_2.retrieve(k_codice)

	end if
	
	attiva_tasti( )
	
//--- Info x DRAG&DROP
	if tab_1.tabpage_2.dw_2.rowcount() <= 0 and (ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione) then
		tab_1.tabpage_2.dw_2.dataobject = "d_dragdrp_info"
		tab_1.tabpage_2.st_2_retrieve.Text = "" // azzero per essere sicuro che al prx tentativo torna a fare la retrieve
	end if

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_2.dw_2))


tab_1.tabpage_2.dw_2.setfocus()
	

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
			k_risposta_load_memo_link = messagebox("Crea un MEMO associato a " + string(a_file_nr) + " Allegati", "Oltre ai collegamenti vuoi importare anche tutti i documenti nel DB", Question!, yesnocancel!, k_risposta_load_memo_link)
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
				kst_memo.st_tab_clienti_memo.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
				kst_memo.st_tab_clienti_memo.tipo_sv = kuf1_sr_sicurezza.get_sr_settore(ki_st_open_w.id_programma)
				kst_memo.st_tab_memo_link = kst_tab_memo_link[]
				kuf1_memo_inout.crea_memo_cliente(kst_memo)
			end if
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
		
		end if
//	end if
		
catch (uo_exception	kuo_exception)
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
		messagebox("Operazione fermata", "Prima di caricare i MEMO, salvare questa Anagrafica", stopsign!) 
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

public subroutine u_retrieve_associazioni ();//
st_tab_clienti kst_tab_clienti
st_esito kst_esito


//--- valorizza contatori Mandanti/Riceventi/Fatturati/Tutti			  
 	  	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
		if kst_tab_clienti.codice > 0 then
	
			kst_esito = kiuf_clienti.get_nr_mandanti( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.mandanti_nr.Expression = string( kst_tab_clienti.contati )
	
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
			kst_esito = kiuf_clienti.get_nr_riceventi( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.riceventi_nr.Expression = string( kst_tab_clienti.contati )
	
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
			kst_esito = kiuf_clienti.get_nr_fatturati( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.fatturati_nr.Expression = string( kst_tab_clienti.contati )
			  
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
			kst_esito = kiuf_clienti.get_nr_m_r_f( kst_tab_clienti )
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.contati = 0
			end if
			tab_1.tabpage_1.dw_1.object.m_r_f_tutti_nr.Expression = string( kst_tab_clienti.contati )
			
		end if

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================


super::attiva_tasti_0()

//tab_1.tabpage_2.enabled = false
//tab_1.tabpage_3.enabled = false
//tab_1.tabpage_4.enabled = false

ki_sincronizza_window_ok = false 
ki_sincronizza_window_consenti = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "codice") > 0 then
		tab_1.tabpage_2.enabled = true
		tab_1.tabpage_4.enabled = true
		tab_1.tabpage_5.enabled = true
		tab_1.tabpage_6.enabled = true
		tab_1.tabpage_7.enabled = true
	else
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_4.enabled = false
		tab_1.tabpage_5.enabled = false
		tab_1.tabpage_6.enabled = false
		tab_1.tabpage_7.enabled = false
	end if
	
	choose case ki_selectedtab // tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
		case 2
			st_aggiorna_lista.enabled = true
			ki_sincronizza_window_ok = true 
			ki_sincronizza_window_consenti = true 
			cb_inserisci.enabled = true
			if tab_1.tabpage_2.dw_2.rowcount( ) > 0 then
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
			end if
		case 3
			cb_aggiorna.enabled = true
		case 5 //listino
		   	cb_visualizza.enabled = true
			cb_modifica.enabled = true
		case 6 //movimentazione
		   	cb_visualizza.enabled = true
		case 4
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
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

if ki_selectedtab <> 5 and ki_selectedtab <> 4 and ki_selectedtab <> 2  &
   		and (ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione &
			   or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione) then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if




end subroutine

on w_clienti.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_clienti.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo)
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
//kuf_menu_window kuf1_menu_window 



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
		
						choose case ki_dwo_name_b_nazioni_l		
							case "b_nazioni_1_l" 
								tab_1.tabpage_1.dw_1.setitem(1, "id_nazione_2", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione"))
								tab_1.tabpage_1.dw_1.setitem(1, "nazione1", (trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome")) + "  ( " + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area")) + " ) " ))

							case "b_nazioni_2_l" 
								tab_1.tabpage_1.dw_1.setitem(1, "id_nazione_c", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione"))
								tab_1.tabpage_1.dw_1.setitem(1, "nazione2", (trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome")) + "  ( " + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area")) + " ) " ))

							case else
								tab_1.tabpage_1.dw_1.setitem(1, "id_nazione_1", kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "id_nazione"))
								tab_1.tabpage_1.dw_1.setitem(1, "nazione", (trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "nome")) + "  ( " + trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "area")) + " ) " ))
						end choose							
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
				
			case "d_meca_causali_l" 
				if long(kst_open_w.key3) > 0 then

					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
		
						tab_1.tabpage_1.dw_1.setitem(1, "id_meca_causale", &
										 kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "id_meca_causale"))
						tab_1.tabpage_1.dw_1.setitem(1, "meca_causali_descrizione", &
											(trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "descrizione"))))
							
					end if
					
				end if				
				
		end choose 

	end if

	ki_dwo_name_b_nazioni_l = ""
	

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_clienti
integer y = 1808
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_clienti
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_clienti
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_clienti
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_clienti
integer y = 1732
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_clienti
integer y = 1612
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_clienti
integer y = 1708
end type

event cb_modifica::clicked;//
long k_riga=0
st_memo kst_memo
st_open_w k_st_open_w
datastore kds_1
//kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility
kuf_memo kuf1_memo

try
			
	choose case ki_selectedtab

		case 2 // Allegati
			kuf1_memo = create kuf_memo
			k_riga = tab_1.tabpage_2.dw_2.getrow()
			if k_riga > 0 then
			else
				if tab_1.tabpage_2.dw_2.rowcount() = 1 then
					k_riga = 1
				end if
			end if
			if k_riga > 0 then
				kst_memo.st_tab_memo.id_memo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_memo")
				if kst_memo.st_tab_memo.id_memo > 0 then
					kuf1_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.modifica )
				end if
			end if
	
		case 4
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
			   	kuf1_utility = create kuf_utility 
//--- S-protezione campi per riabilitare la modifica a parte la chiave
		  		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)
				destroy kuf1_utility
				k_riga = tab_1.tabpage_4.dw_4.getrow()
				tab_1.tabpage_4.dw_4.setcolumn("clie_1")
				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
				tab_1.tabpage_4.dw_4.setrow(k_riga)
			else
				inserisci() 
			end if
			
//Listino			
		case 5 

			if tab_1.tabpage_5.dw_5.getrow( ) > 0 then
				
		//--- call della window che esegue la funzione
				kds_1 = create datastore
				kds_1.dataobject = tab_1.tabpage_5.dw_5.dataobject
				tab_1.tabpage_5.dw_5.rowscopy( tab_1.tabpage_5.dw_5.getrow( ) , tab_1.tabpage_5.dw_5.getrow( ), primary!, kds_1, 1, primary!)
		
				//kuf1_menu_window = create kuf_menu_window
				kGuf_menu_window.open_w_tabelle_da_ds(kds_1, kkg_flag_modalita.modifica)
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione di Modifica", "Selezionare prima una riga dall'elenco")
			end if
			
			
			
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_clienti
integer y = 1708
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_clienti
integer y = 1708
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_clienti
integer y = 1712
integer weight = 700
fontcharset fontcharset = ansi!
end type

type tab_1 from w_g_tab_3`tab_1 within w_clienti
integer x = 37
integer y = 20
integer width = 3369
integer height = 1556
long backcolor = 32435950
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
if kidw_selezionata.dataobject = "d_clienti_1" or kidw_selezionata.dataobject = "d_clienti_memo_l" &
               or kidw_selezionata.dataobject = "d_clienti_mkt_web" or kidw_selezionata.dataobject = "d_dragdrp_info" then
//--- CTRL+V fa Incolla dei file
	if key = KeyV! and keyflags = 2 then
		u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_incolla, handle(this))
	end if
end if

end event

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer y = 176
integer width = 3333
integer height = 1364
string text = " Anagrafica"
string picturename = "C:\GAMMARAD\PB_GMMRD125\ICONE\cliente.gif"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_dropfiles pbm_dropfiles
integer width = 3008
integer height = 1312
string dataobject = "d_clienti_1"
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::u_dropfiles;//
//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr



end event

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
st_tab_nazioni kst_tab_nazioni
st_tab_clienti_fatt kst_tab_clienti_fatt


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

	case "id_nazione_1" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_nazioni.id_nazione = trim(data)
		if len(trim(kst_tab_nazioni.id_nazione)) > 0 then
			kuf1_ausiliari.tb_select( kst_tab_nazioni )
		else
			kst_tab_nazioni.nome = " "
		end if
		tab_1.tabpage_1.dw_1.object.nazione[1] = kst_tab_nazioni.nome 

	case "id_nazione_2" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_nazioni.id_nazione = trim(data)
		if len(trim(kst_tab_nazioni.id_nazione)) > 0 then
			kuf1_ausiliari.tb_select( kst_tab_nazioni )
		else
			kst_tab_nazioni.nome = " "
		end if
       tab_1.tabpage_1.dw_1.object.nazione1[1] = kst_tab_nazioni.nome 
			
	case "id_nazione_c" 
		kuf1_ausiliari = create kuf_ausiliari
		kst_tab_nazioni.id_nazione = trim(data)
		if len(trim(kst_tab_nazioni.id_nazione)) > 0 then
			kuf1_ausiliari.tb_select( kst_tab_nazioni )
		else
			kst_tab_nazioni.nome = " "
		end if
		tab_1.tabpage_1.dw_1.object.nazione2[1] = kst_tab_nazioni.nome 
		
	case "email_invio"
		if tab_1.tabpage_3.dw_3.rowcount( ) > 0 then
			kst_tab_clienti_fatt.email_invio = trim(data)
			tab_1.tabpage_3.dw_3.setitem(1, "email_invio", kst_tab_clienti_fatt.email_invio)
		end if

end choose 

if k_errore = 1 then
	return 2
else
	post attiva_tasti()

end if
	
end event

event dw_1::buttonclicked;call super::buttonclicked;//
//=== Premuto pulsante nella DW
//
kuf_ausiliari kuf1_ausiliari

try
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
		or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica &
		then
		choose case dwo.name
		//--- copia NOMINATIVO princ in spedizione
			case "b_copia_sped"
				this.setitem(row, "rag_soc_20", this.getitemstring(row, "rag_soc_10")) 
				this.setitem(row, "rag_soc_21", this.getitemstring(row, "rag_soc_11")) 
				this.setitem(row, "indi_2", this.getitemstring(row, "indi_1")) 
				this.setitem(row, "loc_2", this.getitemstring(row, "loc_1")) 
				this.setitem(row, "prov_2", this.getitemstring(row, "prov_1")) 
				this.setitem(row, "cap_2", this.getitemstring(row, "cap_1")) 
				this.setitem(row, "id_nazione_2", this.getitemstring(row, "id_nazione_1")) 
		//--- copia NOMINATIVO princ in fatturazione
			case "b_copia_fatt"
				this.setitem(row, "ind_comm_rag_soc_1_c", this.getitemstring(row, "rag_soc_10")) 
				this.setitem(row, "ind_comm_rag_soc_2_c", this.getitemstring(row, "rag_soc_11")) 
				this.setitem(row, "ind_comm_indi_c", this.getitemstring(row, "indi_1")) 
				this.setitem(row, "ind_comm_loc_c", this.getitemstring(row, "loc_1")) 
				this.setitem(row, "ind_comm_prov_c", this.getitemstring(row, "prov_1")) 
				this.setitem(row, "ind_comm_cap_c", this.getitemstring(row, "cap_1")) 
				this.setitem(row, "id_nazione_c", this.getitemstring(row, "id_nazione_1")) 
//--- nazioni
		case "b_nazioni_1_l", "b_nazioni_2_l"
			ki_dwo_name_b_nazioni_l = dwo.Name //--- memorizza il pulsante che è b_nazioni devo gestirlo nel drag & drop
			kuf1_ausiliari	= create kuf_ausiliari
			kuf1_ausiliari.link_call( kidw_selezionata, "b_nazioni_l" )

		end choose
	
	end if
	
catch (uo_exception kuo_exception)	
	kuo_exception.messaggio_utente()

end try


//
end event

event dw_1::clicked;call super::clicked;int k_rc
st_tab_clienti kst_tab_clienti
st_open_w kst_open_w
//kuf_menu_window kuf1_menu_window 


try	
//--- Controllo che dalla window ELENCO non abbia premuto un tasto
	if dwo.Name = "b_mandanti" or dwo.Name ="b_riceventi" or dwo.Name ="b_fatturati"  or dwo.Name ="b_m_r_f_tutti" then

//--- popolo il datasore (dw non visuale) per appoggio elenco
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

		choose case dwo.Name
			case "b_mandanti"
				kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (0, kst_tab_clienti.codice, kst_tab_clienti.codice)
					kst_open_w.key1 = "Elenco Mandanti per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
			case "b_riceventi"
				kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (kst_tab_clienti.codice, 0, kst_tab_clienti.codice)
					kst_open_w.key1 = "Elenco Riceventi per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
			case "b_fatturati"
		 	  	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (kst_tab_clienti.codice,  kst_tab_clienti.codice, 0)
					kst_open_w.key1 = "Elenco Fatturati per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
			case "b_m_r_f_tutti"
		 	  	kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.object.codice[1] 
				if kst_tab_clienti.codice > 0 then
				 	kst_tab_clienti.rag_soc_10 =  trim(tab_1.tabpage_1.dw_1.object.rag_soc_10[1])
					if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = "senza nome"
					kdsi_elenco_output.dataobject = "d_m_r_f_l_1" 
					k_rc = kdsi_elenco_output.settransobject ( sqlca )
					k_rc = kdsi_elenco_output.retrieve    (kst_tab_clienti.codice,  kst_tab_clienti.codice, kst_tab_clienti.codice)
					kst_open_w.key1 = "Elenco di Tutte le Connessioni per " + kst_tab_clienti.rag_soc_10 + "(" + string(kst_tab_clienti.codice)  + ") "
				end if
				
			case "gb_associazioni"
				u_retrieve_associazioni()
				
		end choose

		if kdsi_elenco_output.rowcount() > 0 then
		
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
			kst_open_w.id_programma = kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			//kuf1_menu_window = create kuf_menu_window 
			kGuf_menu_window.open_w_tabelle(kst_open_w)
			//destroy kuf1_menu_window
		
		else
			
			messagebox("Elenco Dati", "Nessun valore disponibile. ")
			
			
		end if

	end if
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer y = 176
integer width = 3333
integer height = 1364
string text = " memo"
string picturename = "Copy!"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
event u_dropfiles pbm_dropfiles
boolean visible = true
integer width = 2939
integer height = 1320
boolean enabled = true
string dataobject = "d_clienti_memo_l"
end type

event dw_2::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr



end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer y = 176
integer width = 3333
integer height = 1364
string text = " Marketing~r~n & Web"
string picturename = "Custom073!"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
event u_dropfiles pbm_dropfiles
integer width = 2656
integer height = 1232
boolean enabled = true
string dataobject = "d_clienti_mkt_web"
end type

event dw_3::u_dropfiles;//
int k_file_nr=0


k_file_nr = u_drop_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle)

return k_file_nr



end event

event dw_3::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_gru kst_tab_gru
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
				tab_1.tabpage_3.dw_3.object.id_cliente_link[1] = 0
				tab_1.tabpage_3.dw_3.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
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
				tab_1.tabpage_3.dw_3.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = " "
			post put_video_mkt_contatti(integer(mid(dwo.name,2,1)) , kst_tab_clienti)
		end if

	case "gruppo" 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_3.dw_3.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "codice = " + Trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_gru.codice = kdwc_1.getitemnumber( k_riga, "codice")
				kst_tab_gru.des = trim(kdwc_1.getitemstring( k_riga, "des"))
				post put_video_mkt_gruppo(kst_tab_gru)
			else
				tab_1.tabpage_3.dw_3.object.gruppo[1] = 0
				tab_1.tabpage_3.dw_3.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_gru.codice = 0
			kst_tab_gru.des = " "
			post put_video_mkt_gruppo(kst_tab_gru)
		end if

	case "email_invio"
		if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
			kst_tab_clienti_fatt.email_invio = trim(data)
			tab_1.tabpage_1.dw_1.setitem(1, "email_invio", kst_tab_clienti_fatt.email_invio)
		end if

end choose

post attiva_tasti()

end event

event dw_3::buttonclicked;call super::buttonclicked;//
st_tab_clienti kst_tab_clienti

if left(dwo.name,14) = "b_contatto_new" or dwo.name = "b_link_nuovo" then
	
	choose case dwo.name 
		case "b_link_nuovo"
			ki_id_contatto_numero = "1"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_1")
		case "b_contatto_new_1"
			ki_id_contatto_numero = "1"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_1")
		case "b_contatto_new_2"
			ki_id_contatto_numero = "2"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_2")
		case "b_contatto_new_3"
			ki_id_contatto_numero = "3"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_3")
		case "b_contatto_new_4"
			ki_id_contatto_numero = "4"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_4")
		case "b_contatto_new_5"
			ki_id_contatto_numero = "5"
			kst_tab_clienti.codice = this.getitemnumber( row, "id_contatto_5")
	end choose

	if kst_tab_clienti.codice > 0 then
		ki_id_contatto_numero = ""
		call_anagrafica_modifica(kst_tab_clienti)
	else
		call_anagrafica_nuovo ()
	end if
	
end if

end event

event dw_3::getfocus;call super::getfocus;//

	if ki_id_contatto_numero	> " " & 
			and ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		ripopola_dwc_3 ()  //--- popola le dw child del tab 3
	end if

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer y = 176
integer width = 3333
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
post check_mappa_dw4 (dwo.name, row, data)

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
integer width = 3333
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
string dataobject = "d_clienti_listino_l"
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer y = 176
integer width = 3333
integer height = 1364
boolean enabled = true
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
integer y = 176
integer width = 3333
integer height = 1364
string text = " Fatture non di Magazzino~r~n (senza Lotto di Entrata) "
long tabbackcolor = 32435950
string powertiptext = "elenco articoli senza lotto di entrata"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer width = 2871
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
integer width = 3333
integer height = 1364
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer y = 176
integer width = 3333
integer height = 1364
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type dw_periodo from uo_dw_periodo within w_clienti
integer x = 279
integer y = 1240
integer taborder = 40
boolean bringtotop = true
end type

event ue_clicked;call super::ue_clicked;//
try
	if ki_selectedtab = 6 then
		inizializza_5( )
	else 
		if ki_selectedtab = 7 then
			inizializza_6( )
		end if
	end if
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

		
end event

