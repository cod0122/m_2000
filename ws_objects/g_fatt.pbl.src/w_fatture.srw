$PBExportHeader$w_fatture.srw
forward
global type w_fatture from w_g_tab_3
end type
type dw_anno_numero from datawindow within w_fatture
end type
type dw_x_copia from uo_d_std_1 within w_fatture
end type
type dw_riga from uo_d_std_1 within w_fatture
end type
end forward

global type w_fatture from w_g_tab_3
integer width = 1449
integer height = 948
string title = "Documento di Vendita"
boolean ki_toolbar_window_presente = true
boolean ki_menu_espone_tasto_delete = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
dw_anno_numero dw_anno_numero
dw_x_copia dw_x_copia
dw_riga dw_riga
end type
global w_fatture w_fatture

type variables
//
private kuf_fatt kiuf_fatt
private kuf_armo kiuf_armo 	
private kuf_armo_prezzi kiuf_armo_prezzi 	
private kuf_clienti kiuf_clienti  
private kuf_sped kiuf_sped
private kuf_prodotti kiuf_prodotti
private kuf_ausiliari kiuf_ausiliari
private kuf_listino kiuf_listino

private datastore kids_elenco_sped
private datastore kids_elenco_lotti
private datastore kids_elenco_fatt
private datastore kids_elenco_acconti
private datastore kids_elenco_input

private st_tab_arfa kist_tab_arfa, kist_tab_arfa_orig
private date ki_data_competenza //data periodo inizio estrazioni
private string ki_cadenza_fattura //flag cadenza di fatturazione  di "meta' mese"

//--- progressivo righe dettaglio, serve x identificare una riga quando sono in 'modfica'
private int ki_progressivo_riga = 0

private st_tab_base kist_tab_base
private string ki_art_x_costo_call = ""
private kuf_menu_window kiuf_menu_window

end variables

forward prototypes
protected function string aggiorna ()
protected function integer cancella ()
protected function string check_dati ()
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
private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga)
private subroutine call_elenco_note ()
private subroutine elenco_lotti_no_dose ()
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public subroutine set_dw_clienti_child ()
private function string get_norme_bolli (st_tab_arfa kst_tab_arfa) throws uo_exception
private function double get_totale_x_iva (integer k_iva)
private subroutine run_app_lettera ()
private subroutine u_cliccato_iva_esente ()
private function integer riga_gia_presente (st_tab_arfa kst_tab_arfa)
public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception
public subroutine u_allarme_lotto (st_tab_meca ast_tab_meca) throws uo_exception
private subroutine get_cliente_ddt_lotto () throws uo_exception
public function st_esito u_aggiorna_base (st_tab_arfa ast_tab_arfa)
public subroutine u_set_d_arfa_v_dwchild ()
private function long riga_nuova_in_lista_1 (ref st_tab_arfa ast_tab_arfa, ref st_tab_meca ast_tab_meca, st_tab_armo ast_tab_armo) throws uo_exception
public subroutine riga_aggiorna_in_lista_art (long k_riga, st_tab_arfa kst_tab_arfa) throws uo_exception
private subroutine riga_aggiorna_in_lista (long k_riga, st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception
private function long riga_modifica_in_lista (st_tab_arfa kst_tab_arfa) throws uo_exception
private function long riga_aggiungi_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception
private function long riga_nuova_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca) throws uo_exception
private subroutine riga_aggiungi_costo_chiamata (ref st_tab_sped ast_tab_sped) throws uo_exception
private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti)
protected subroutine inizializza_4 () throws uo_exception
public function boolean u_aggiorna_pa (st_tab_arfa kst_tab_arfa) throws uo_exception
public subroutine u_inizializza (st_tab_arfa ast_tab_arfa)
private subroutine elenco_acconti_non_fatt ()
private function long riga_nuova_acconto_in_lista (ref st_tab_arfa ast_tab_arfa) throws uo_exception
public subroutine u_set_art_v_dwchild ()
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

string k_return="0 ", k_errore="0 ", k_errore1="0 "
long k_riga
st_tab_arfa kst_tab_arfa, kst_tab_arfa_app
st_tab_base kst_tab_base 
st_tab_armo kst_tab_armo 
st_tab_arsp kst_tab_arsp
st_tab_armo_prezzi kst_tab_armo_prezzi
st_esito kst_esito, kst_esito_BASE
kuf_sped kuf1_sped
kuf_base kuf1_base


setpointer(kkg.pointer_attesa) 

kuf1_base = create kuf_base
kuf1_sped = create kuf_sped

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if tab_1.tabpage_1.dw_1.GetItemStatus(tab_1.tabpage_1.dw_1.getrow(), 0,  primary!) = NewModified!	then
//		k_new_rec = true
//	else
//		k_new_rec = false
//	end if

k_riga = tab_1.tabpage_1.dw_1.getrow()

//=== Aggiorna, se modificato, la TAB_1 o TAB_4	o TAB_5
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	&
				or tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 &
				or tab_1.tabpage_4.dw_4.deletedcount() > 0 &
				or tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 then

	try
	//--- Se sono in Inserimento verifico se numero fattura già usato
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_arfa_app.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
			kst_tab_arfa_app.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt") 
			kst_tab_arfa_app.id_fattura = 0
			if kiuf_fatt.if_esiste_fattura( kst_tab_arfa_app ) then
				kiuf_fatt.get_ultimo_numero ( kst_tab_arfa_app ) 
				kst_tab_arfa.num_fatt = kst_tab_arfa_app.num_fatt + 1
	
				kguo_exception.setmessage( "Numero Fattura iniziale modificato da " + string(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")) + " a " + string(kst_tab_arfa.num_fatt)  )
				kguo_exception.messaggio_utente( )
	
				tab_1.tabpage_1.dw_1.setitem(k_riga, "num_fatt", kst_tab_arfa.num_fatt )
	
			end if
		else
//--- se sono in Modifica e ho cambiato numero e data....			
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
				kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
				kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
				if kist_tab_arfa_orig.num_fatt <> kst_tab_arfa.num_fatt or kist_tab_arfa_orig.data_fatt <> kst_tab_arfa.data_fatt then
//--- Cambio numero e data....			
					kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
					kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_fattura")
					kst_esito = kiuf_fatt.tb_update_numero_data( kst_tab_arfa )
					if kst_esito.esito = kkg_esito.db_ko then
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
				end if
			end if
		end if
		
		setpointer(kkg.pointer_attesa) 
		
		kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_fattura")
		if isnull(kst_tab_arfa.id_fattura) then kst_tab_arfa.id_fattura = 0
		kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
		kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_cliente")
		kst_tab_arfa.stampa = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stampa")
		kst_tab_arfa.data_stampa = tab_1.tabpage_1.dw_1.getitemdatetime(k_riga, "data_stampa")
		kst_tab_arfa.stampa_tradotta  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "stampa_tradotta")
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
		kst_tab_arfa.note_normative =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "fat1_note_normative")
		kst_tab_arfa.note_int_1 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_1")
		kst_tab_arfa.note_int_2 =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_2")
		kst_tab_arfa.modo_stampa  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "modo_stampa")
		kst_tab_arfa.modo_email  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "modo_email")
		kst_tab_arfa.email_invio  =  tab_1.tabpage_1.dw_1.getitemstring(k_riga, "email_invio")
	
		
//=== Aggiorna, se modificato, la TAB_1	
		if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0	or kst_tab_arfa.id_fattura = 0 then
		
//--- Aggiorna la testa fattura
			kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
			if kst_tab_arfa.id_fattura > 0 then
				kst_esito = kiuf_fatt.tb_update_testa(kst_tab_arfa)
				if kst_esito.esito <> kkg_esito.OK then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			else
				kst_esito = kiuf_fatt.tb_insert_testa(kst_tab_arfa)
				if kst_esito.esito <> kkg_esito.OK then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
				
//--- Spero ci sia il ID...
			if kst_tab_arfa.id_fattura > 0 then
				tab_1.tabpage_1.dw_1.setitem (k_riga, "id_fattura", kst_tab_arfa.id_fattura )
			else
				kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione della fattura ROLLBACK!
				kst_esito.sqlerrtext = "Non è stato generato il Contatore del Documento (id_fattura), ~n~r" + "Non è possibile proseguire con la registrazione!"
				kst_esito.sqlcode = 0
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

//--- Se tutto OK carico le NOTE 	
			kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
//--- se non impostate cerca di caricare le NORMATIVE SUI BOLLI 
			if isnull(kst_tab_arfa.note_normative) or len(trim(kst_tab_arfa.note_normative)) = 0 then
				kst_tab_arfa.note_normative = ""
				if kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
				         or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura &
				         or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione then
					if tab_1.tabpage_4.dw_4.rowcount() > 0 then
						kst_tab_arfa.note_normative = get_norme_bolli(kst_tab_arfa) // lo ricava dalle righe ddel DW4
					else
						kst_tab_arfa.note_normative = kiuf_fatt.get_norme_bolli(kst_tab_arfa) // lo ricava dal DB
					end if
					if isnull(kst_tab_arfa.note_normative) then
						kst_tab_arfa.note_normative = ""
					end if
				end if
			end if
			kst_esito = kiuf_fatt.set_note(kst_tab_arfa )
			if kst_esito.esito <> kkg_esito.OK then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

//--- Spero ci sia il ID...
		if kst_tab_arfa.id_fattura > 0 then
			tab_1.tabpage_1.dw_1.setitem (k_riga, "id_fattura", kst_tab_arfa.id_fattura )
		else
			kst_esito.esito = kkg_esito.db_ko  // fermo la registrazione della fattura ROLLBACK!
			kst_esito.sqlerrtext = "Non è stato generato il Contatore del Documento (id_fattura), ~n~r" + "Non è possibile proseguire con la registrazione!"
			kst_esito.sqlcode = 0
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//=== Aggiorna, se modificato, la TAB_5
//--- Se tutto OK carico i dati PA
		u_aggiorna_pa(kst_tab_arfa)	

//=== Aggiorna, se modificato, la TAB_4
//--- Se tutto OK carico le righe di dettaglio 	
		kst_tab_arfa.st_tab_g_0.esegui_commit = "N"
		k_riga = 1
		do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() 
			
			kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")
			kst_tab_arfa.id_arfa_v = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa")
			
			kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
			kst_tab_arfa.id_armo_prezzo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo_prezzo")
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
			kst_tab_arfa.contratto = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "contratto") 
			kst_tab_arfa.stampa = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "stampa") 
	
//--- Aggiorna le righe fattura
			if kst_tab_arfa.id_arfa = 0 then
				kiuf_fatt.if_isnull_testa(kst_tab_arfa)
				kst_esito = kiuf_fatt.tb_insert_dett( kst_tab_arfa )
				tab_1.tabpage_4.dw_4.setitem (k_riga, "id_arfa", kst_tab_arfa.id_arfa )
			else
				kst_esito = kiuf_fatt.tb_update_dett ( kst_tab_arfa )
			end if
			if kst_esito.esito <> kkg_esito.OK then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

//--- Aggiorna lo stato delle righe di Spedizione a FATTURATO
			if (kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
			        or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura &
  		           or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione) &
              and kst_tab_arfa.id_arsp > 0 then
				kst_tab_arsp.st_tab_g_0.esegui_commit = "N"
				kst_tab_arsp.id_arsp = kst_tab_arfa.id_arsp
				kst_esito = kuf1_sped.set_riga_fatturata( kst_tab_arsp )
			end if		
//--- Aggiorna lo stato e altro della riga ARMO_PREZZI
			if (kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
			          or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura &
    		          or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione) &
					 and kst_tab_arfa.id_armo_prezzo > 0 then
				kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = "N"
				kst_tab_armo_prezzi.id_armo_prezzo = kst_tab_arfa.id_armo_prezzo
				kst_tab_arfa_app = kst_tab_arfa
				kiuf_fatt.get_colli_x_id_armo_prezzo(kst_tab_arfa_app)
				kst_tab_armo_prezzi.item_fatt = kst_tab_arfa_app.colli 
				kiuf_armo_prezzi.set_fatturato( kst_tab_armo_prezzi )
			end if		
			
			k_riga++

		loop
	
//---- gestione delle righe da CANCELLARE DAL DB 
		k_riga = 1
		do while k_riga <= tab_1.tabpage_4.dw_4.DeletedCount ( ) 
			
			kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa", delete!, false)
			kst_tab_arfa.id_arfa_v = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa", delete!, false)
			kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo", delete!, false)
			kst_tab_arfa.id_armo_prezzo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo_prezzo")
			kst_tab_arfa.id_arsp = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arsp", delete!, false) 
			kst_tab_arfa.tipo_riga = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo_riga", delete!, false)  
			kst_tab_arfa.colli = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "colli") 
				
//--- Cancella righe da fattura
			if kst_tab_arfa.id_arfa > 0 then
				kst_esito = kiuf_fatt.tb_delete_dett( kst_tab_arfa )
				if kst_esito.esito <> kkg_esito.OK then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if

				
//--- Aggiorna lo stato delle righe si Spedizione da FATTURATO a SPEDITO
				if kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
				        or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura & 
  		              or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione then
					if kst_tab_arfa.id_arsp > 0 then
						kst_tab_arsp.st_tab_g_0.esegui_commit = "N"
						kst_tab_arsp.id_arsp = kst_tab_arfa.id_arsp
						kst_esito = kuf1_sped.reset_riga_fatturata( kst_tab_arsp )
					end if
//--- Aggiorna lo stato e altro della riga ARMO_PREZZI
					if (kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
					        or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura &
   		              or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione) &
						  and kst_tab_arfa.id_armo_prezzo > 0 then
						kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = "N"
						kst_tab_armo_prezzi.id_armo_prezzo = kst_tab_arfa.id_armo_prezzo
						kst_tab_armo_prezzi.item_fatt = kst_tab_arfa.colli
						kiuf_armo_prezzi.set_fatturato_ripri( kst_tab_armo_prezzi )
					end if		
				
//--- Aggiorna lo stato delle righe di ENTRATA 
					if kst_tab_arfa.id_armo > 0 then
						kst_tab_armo.colli_fatt = kiuf_fatt.get_colli_fatturati(kst_tab_arfa_app)
						kst_tab_armo.id_armo = kst_tab_arfa.id_armo
						kst_esito = kiuf_armo.set_colli_fatt(kst_tab_armo)
					end if			
				end if					
			end if
		
			k_riga++

		loop
		
	catch	(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.esito = kkg_esito.db_ko
		
	end try
		

//--- 
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.dati_wrn or kst_esito.esito = kkg_esito.db_wrn then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kGuf_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
			
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
	
//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
			tab_1.tabpage_5.dw_5.ResetUpdate ( ) 

//--- Aggiorna il NR. COLLI fatturati nel LOTTO			
			if kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura &
			      or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura &
  	            or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_integrazione	then
				try 
					kst_tab_armo.st_tab_g_0.esegui_commit = "S"
					k_riga = 1
					do while k_riga <= tab_1.tabpage_4.dw_4.rowcount() and kst_esito.esito <> kkg_esito.db_ko
					
						kst_tab_arfa_app.id_armo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo")
						kst_tab_arfa_app.id_fattura = 0
						kst_tab_armo.colli_fatt = kiuf_fatt.get_colli_fatturati(kst_tab_arfa_app)
						kst_tab_armo.id_armo = kst_tab_arfa_app.id_armo
						kst_esito = kiuf_armo.set_colli_fatt(kst_tab_armo)
						k_riga ++
					loop
				catch (uo_exception kuo_exception2)
					kuo_exception2.messaggio_utente( )
					
				end try 
			end if
			
//--- aggiorna nel BASE il num. fattura se + grande di quello presente
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				kst_esito_base = u_aggiorna_base(kst_tab_arfa)
				if kst_esito_BASE.esito <> kkg_esito.ok then 
					k_return="1Fallito aggiornamento del Numero Fattura in 'Proprietà Azienda', procedere manualmene ! " + " ~n~r" + trim(kst_esito_base.sqlerrtext) 
				end if
			end if
			
//--- Infine la modalità diventa a modifica
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			
		end if
	else
		k_errore1 = kGuf_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio Fatture ! " + " ~n~r" + trim(kst_esito.sqlerrtext) 
	end if	
end if

setpointer(kkg.pointer_default)

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

if isvalid(kuf1_base) then destroy kuf1_base
if isvalid(kuf1_sped) then destroy kuf1_sped

attiva_tasti()

return k_return

end function

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


try
	
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")
		if kst_tab_arfa.id_fattura > 0 then  // se è una fattura già caricata...
	//--- posso cancellare il documento? se exception NO!
			kiuf_fatt.if_cancella(kst_tab_arfa) 
		end if
	end if
	
	choose case tab_1.selectedtab 
		case 1 
			k_record = " Documento di Vendita "
			k_riga = tab_1.tabpage_1.dw_1.getrow()	
			if k_riga > 0 then
				if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new!  &
						and tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
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
				kst_esito.esito = kkg_esito.ok
		end choose	
		
		if k_return <> 2 then
		
			if kst_esito.esito = kkg_esito.ok then
				k_return = 0 
			
	//--- Se tutto OK faccio la COMMIT		
				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito <> kkg_esito.ok then
					k_return = 1
					
					k_errore = "Operzione fallita (COMMIT)!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
					messagebox("Problemi durante la Cancellazione !!", k_errore)
	
		
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
				k_errore = "Operazione fallita !! ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
	
				kst_esito = kguo_sqlca_db_magazzino.db_rollback()
				if kst_esito.esito <> kkg_esito.ok then
					k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
				end if
					
				messagebox("Problemi durante Cancellazione", k_errore ) 	
	
				attiva_tasti()
		
			end if
		end if
	end if
	
	if k_return = 0 then
	
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
				tab_1.tabpage_4.dw_4.accepttext( )
		//		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
		end choose	
		
	end if
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


end try	

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
long k_nr_righe, k_nriga=0
int k_riga, k_ctr, k_righe
int k_nr_errori 
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_armo kst_tab_armo
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa, kst_tab_arfa_fatt
st_tab_iva kst_tab_iva
st_clienti_esenzione_iva kst_clienti_esenzione_iva
st_tab_sped kst_tab_sped
//kuf_armo kiuf_armo
kuf_sped kuf1_sped
kuf_ausiliari kuf1_ausiliari

//kuf_base kuf1_base


try
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
	else
		kst_tab_clienti.codice = kst_tab_arfa.clie_3  
		if not kiuf_clienti.if_attivo(kst_tab_clienti) then
			kst_esito.esito = kkg_esito.KO
			kst_esito.sqlerrtext += "Il Cliente "+ string(kst_tab_clienti.codice) + " non è nello stato di Attivo in Anagrafe " + "~n~r" 
			k_nr_errori++
		end if
	end if

//--- controllo se fattura già caricata		
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
			kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
			kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
			kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_fattura")
			if kist_tab_arfa_orig.num_fatt <> kst_tab_arfa.num_fatt then
//--- controllo se fattura già caricata		
				if kiuf_fatt.if_fattura_duplicata(kst_tab_arfa) then
					k_return = tab_1.tabpage_1.text + ": Numero Fattura già caricato " + "~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if
			end if
		end if
	end if

//--- controllo se esistono fatture con data maggiore ma numero minore		
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		try
			kst_tab_arfa.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_fatt")
			kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_fatt")
//--- controllo...	
			if NOT kiuf_fatt.if_num_data_congruenti(kst_tab_arfa) then
				k_return = tab_1.tabpage_1.text + ": Data in conflitto con le fatture già emesse " + "~n~r" 
				k_errore = "4"
				k_nr_errori++
			end if
		catch (uo_exception kuo_exception2)
				kst_esito = kuo_exception2.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-2: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally
//			destroy kuf1_armo
		end try
		
	end if

//--- controllo ESENZIONE	
	if  tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva") > 0 and tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "k_iva_esente") = 1 &
			and tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "tipo_doc") <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
			and tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "tipo_doc") <> kiuf_fatt.kki_tipo_doc_integrazione &
			then
				
		kst_tab_iva.codice =  tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "iva")
//		kst_esito = kuf1_ausiliari.tb_select(kst_tab_iva)
//		if kst_esito.esito = kkg_esito.ok and (kst_tab_iva.ALIQ = 0 or isnull(kst_tab_iva.ALIQ)) then  // se iva esente controllo

//--- Ricavo il Totale del codice IVA indicato in Testata (di norma un codice IVA esente)
		kst_clienti_esenzione_iva.iva = kst_tab_iva.codice
		kst_clienti_esenzione_iva.importo_t = 0
		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			kst_clienti_esenzione_iva.importo_t = get_totale_x_iva(kst_clienti_esenzione_iva.iva)  // ricava il totale delle righe x questa fattura x il codce iva passato
//			kst_clienti_esenzione_iva.importo_t = double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1])
		end if

//		if kst_clienti_esenzione_iva.importo_t > 0 then

			kst_clienti_esenzione_iva.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_fattura")
			kst_clienti_esenzione_iva.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")
			kst_clienti_esenzione_iva.data_fatt = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "data_fatt")
			
			try
				kiuf_clienti.esenzione_iva_controllo_fattura (kst_clienti_esenzione_iva)

				choose case  kst_clienti_esenzione_iva.ESITO
					case "1" //nessuna esenzione indicata sul cliente
//						k_return = tab_1.tabpage_1.text + ": Attenzione: nessuna esenzione trovata, indicata: " + string(kst_clienti_esenzione_iva.IVA)+ ". ~n~r"
//						k_errore = "4"
//						k_nr_errori++
					case "2" //esenzione scaduta
						k_return = tab_1.tabpage_1.text + ": Esenzione scaduta il " + string(kst_clienti_esenzione_iva.IVA_VALIDA_AL)+ ". ~n~r"
						k_errore = "4"
						k_nr_errori++
						tab_1.tabpage_1.dw_1.setitem( k_riga, "k_iva_esente", 0 ) // Toglie l'esenzione
					case "3" //esenzione oltre l'importo massimo indicato su clienti
						k_return = tab_1.tabpage_1.text + ": Esenzione oltre l'importo max di " &
									+ string(kst_clienti_esenzione_iva.iva_esente_imp_max) &
									+ ", il calcolato: " +string(kst_clienti_esenzione_iva.importo)+  ". ~n~r"
						k_errore = "4"
						k_nr_errori++
						tab_1.tabpage_1.dw_1.setitem ( k_riga, "k_iva_esente", 0 ) //Toglie l'esenzione
					case "4" //esenzione sotto il limite importo richiesto x la fattura 
						k_return = tab_1.tabpage_1.text + ": Cambiare IVA ESENTE nelle righe xche' sotto l'importo Minimo indicato in Anagrafe: " + string(kst_clienti_esenzione_iva.iva_esente_imp_min_x_fatt,"###,###,##0.00")+ ". ~n~r"
						k_errore = "1"
						k_nr_errori++
				end choose

			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito( )
				if kst_esito.esito <> kkg_esito.ok then
					k_return += tab_1.tabpage_1.text + ": Errore DB-3: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
					k_errore = "1"
					k_nr_errori++
				end if
				
			end try

	//	end if
	end if

//--- controllo se Stampa Tradotta è ok
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		try
			kst_tab_clienti.codice = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_cliente")
			kst_tab_clienti.id_nazione_1 = kiuf_clienti.get_id_nazione(kst_tab_clienti)
			kst_tab_arfa.stampa_tradotta = tab_1.tabpage_1.dw_1.getitemstring( k_riga, "stampa_tradotta")
			kst_tab_arfa.stampa_tradotta = trim(kst_tab_arfa.stampa_tradotta)
			if (kst_tab_arfa.stampa_tradotta = "IT" or isnull(kst_tab_arfa.stampa_tradotta)) then
				if (kst_tab_clienti.id_nazione_1 <> "IT" and kst_tab_clienti.id_nazione_1 <> "SM") then
					k_return = tab_1.tabpage_1.text + ": Cliente straniero in Anagrafe, consiglio 'Traduzione' " + trim(kst_tab_clienti.id_nazione_1) + "~n~r" 
					k_errore = "5"
					k_nr_errori++
				end if
			else
				if (kst_tab_clienti.id_nazione_1 = "IT" or kst_tab_clienti.id_nazione_1 = "SM") then
					k_return = tab_1.tabpage_1.text + ": Documento in Traduzione per Cliente non straniero in Anagrafe " +trim(kst_tab_clienti.id_nazione_1) + "~n~r" 
					k_errore = "5"
					k_nr_errori++
				end if
			end if
		catch (uo_exception kuo2_exception)
		end try
	end if
	
//=== Controllo altro tab
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- se non ci sono righe di dettaglio (nenache tra le cancelate) allora legge la fattura
		k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
		if k_nr_righe = 0 and tab_1.tabpage_4.dw_4.DeletedCount ( ) = 0 then
			
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
		
				k_nriga = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "nriga")
		
				if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
				
//--- se riga da bolla verifica il clie_3 su bolla
					if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "num_bolla_out") > 0 then
						kst_tab_sped.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "num_bolla_out") 
						kst_tab_sped.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_bolla_out") 
						kst_esito = kuf1_sped.get_clie( kst_tab_sped )
			
						if kst_esito.esito = kkg_esito.db_ko then
							k_return += tab_1.tabpage_1.text + ": Errore DB-4: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
							k_errore = "1"
							k_nr_errori++
						else
							if kst_esito.esito = kkg_esito.not_fnd  then
								k_return = trim(k_return) +  tab_1.tabpage_4.text +  " Riga " + string(k_nriga, "#####") + ": DDT nr. "+ string(kst_tab_sped.num_bolla_out) + " non Trovato! ~n~r" 
								k_errore = "3"
								k_nr_errori++
							else
								if kst_tab_sped.clie_3 <> kst_tab_arfa.clie_3 then 
									k_return = trim(k_return) +  tab_1.tabpage_4.text + " Riga " + 	string(k_nriga, "#####") +": Cliente "+ string(kst_tab_sped.clie_3) +" del DDT nr. "+ string(kst_tab_sped.num_bolla_out) &
															+ " diverso da quello del Documento cod. "+ string(kst_tab_arfa.clie_3) +" ~n~r" 
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
	
							if kst_esito.esito = kkg_esito.db_ko then
								k_return += tab_1.tabpage_1.text + ": Errore DB-5: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
								k_errore = "1"
								k_nr_errori++
							else
								kst_tab_meca.id = kst_tab_armo.id_meca
								kiuf_armo.get_clie( kst_tab_meca )
	
								if kst_tab_meca.clie_1 = 0  then
									k_return = trim(k_return) +  tab_1.tabpage_4.text + " Riga " + string(k_nriga, "#####") +": Lotto id="+ string(kst_tab_meca.id) + " non Trovato! ~n~r" 
									k_errore = "3"
									k_nr_errori++
								else
									if kst_tab_meca.clie_3 > 0 then 
										if kst_tab_meca.clie_3 <> kst_tab_meca.clie_3 then 
											kiuf_armo.get_num_int( kst_tab_meca )  // piglio x informare anche il numero lotto
											k_return = trim(k_return) +  tab_1.tabpage_4.text + " Riga " + string(k_nriga, "#####") +": Cliente "+ string(kst_tab_meca.clie_3) +" del Lotto "+ string(kst_tab_meca.num_int) &
												+ " " + string(kst_tab_meca.data_int) + " diverso da quello del Documento cod. "+ string(kst_tab_arfa.clie_3) +" ~n~r" 
											k_errore = "3"
											k_nr_errori++
										end if
									end if
								end if
							end if
						end if
					end if

//--- codice IVA					
					if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "prezzo_t") <> 0 and not isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "prezzo_t") ) &
							and tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "iva") = 0 &
							then
						k_return = trim(k_return) +  tab_1.tabpage_4.text + " Riga " + string(k_nriga, "#####") +": Codice IVA non impostato ~n~r" 
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
					
//--- Se Nota di Credito non controlla i COLLI					
					if (tab_1.tabpage_1.dw_1.getitemstring ( 1, "tipo_doc") <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
					     and tab_1.tabpage_1.dw_1.getitemstring ( 1, "tipo_doc") <> kiuf_fatt.kki_tipo_doc_integrazione) &
  					     or isnull( tab_1.tabpage_1.dw_1.getitemstring ( 1, "tipo_doc")) then
						kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_armo") 
						kst_tab_arfa.id_armo_prezzo = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_armo_prezzo") 
						if kst_tab_arfa.id_armo > 0 then
							if kst_tab_arfa.id_armo_prezzo > 0 then
								
								kst_tab_armo_prezzi.id_armo_prezzo = kst_tab_arfa.id_armo_prezzo
								kiuf_armo_prezzi.get_item(kst_tab_armo_prezzi)
								if kst_tab_armo_prezzi.item_dafatt < kst_tab_arfa_fatt.colli then
									k_return = trim(k_return) + tab_1.tabpage_4.text + " Riga " + string(k_nriga, "#####") + ": Troppi Colli indicati ("+ string(kst_tab_arfa.colli) + ").  " &
											 + "Colli da fatturare " + string(kst_tab_armo_prezzi.item_dafatt) + ". ~n~r"  
								end if
							else
							
								kst_tab_arfa.id_fattura = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "id_fattura")
								kst_tab_arfa_fatt.colli = kiuf_fatt.get_colli_fatturati(kst_tab_arfa) 
								
								kst_tab_armo.id_armo = kst_tab_arfa.id_armo
								kiuf_armo.get_colli_entrati_riga( kst_tab_armo )
								
								if kst_tab_arfa.colli > (kst_tab_armo.colli_2 - kst_tab_arfa_fatt.colli)	then
									if kst_tab_arfa_fatt.colli > 0 then
										k_return = trim(k_return) + tab_1.tabpage_4.text + " Riga " + string(k_nriga, "#####") + ": Troppi Colli indicati ("+ string(kst_tab_arfa.colli) + ").  " &
											 + "Colli entrati in magazzino " + string(kst_tab_armo.colli_2) + ",  di cui gia' fatturati " + string(kst_tab_arfa_fatt.colli)  + " ~n~r"  //"; colli max.:" + string(kst_tab_armo.colli_2 - kst_tab_arfa_fatt.colli) + " ~n~r" 
									else
										k_return = trim(k_return) + tab_1.tabpage_4.text+ " Riga " + string(k_nriga, "#####") + ": Troppi Colli indicati ("+ string(kst_tab_arfa.colli) + "). " &
											 + "Colli entrati in magazzino " + string(kst_tab_armo.colli_2) + ". ~n~r" 
									end if
									k_errore = "1"
									k_nr_errori++
								end if
								
							end if
						end if
					end if
				end if
				
				k_riga++
		
				k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		
			loop
			
		catch (uo_exception kuo1_exception)
				kst_esito = kuo1_exception.get_st_esito()
				k_return += tab_1.tabpage_1.text + ": Errore DB-6: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
				k_errore = "1"
				k_nr_errori++
			
		finally
//			destroy kuf1_armo
		end try
		
	end if

	if k_errore = "0" or k_errore = "4" or k_errore = "5" then
		
//--- Check presenza importi a ZERO 
		k_righe =  tab_1.tabpage_4.dw_4.rowcount()
		k_riga = 1
		do while k_riga <= k_righe   
			if tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "k_importo_riga") <> 0 then
			else
				k_nriga = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "nriga")
				k_return += tab_1.tabpage_4.text+ " Riga " + string(k_nriga, "#####") + ": Attenzione alla presenza di IMPORTI a ZERO. "  + " ~n~r" 
				k_errore = "5"
				k_nr_errori++
//				exit   // EXIT FORZATO
			end if
			k_riga++
		loop


//--- check importo minimo fa fatturare
		if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
			if not isnull(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1]) then
				kst_tab_clienti_fatt.id_cliente = kst_tab_arfa.clie_3
				kst_tab_clienti_fatt.impon_minimo = kiuf_clienti.get_impon_minimo(kst_tab_clienti_fatt)
				if kst_tab_clienti_fatt.impon_minimo > 0 then
					if kst_tab_clienti_fatt.impon_minimo > double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1]) then
						k_return += tab_1.tabpage_4.text + ": Totale Imponibile Inferiore al Minimo richiesto per il Cliente di " +  string(kst_tab_clienti_fatt.impon_minimo, "#0.00") + " euro~n~r" 
						k_errore = "4"
						k_nr_errori++
					end if
				else
					//double k_x 
					//k_x = double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1])
					if kist_tab_base.fatt_impon_minimo > double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1]) then
						k_return += tab_1.tabpage_4.text + ": Totale Imponibile Inferiore al Minimo richiesto di " +  string(kist_tab_base.fatt_impon_minimo) + " euro~n~r" 
						k_errore = "4"
						k_nr_errori++
					end if
				end if
			end if
		end if
		
	end if
		

catch (uo_exception kuo_exception1)
	k_return += tab_1.tabpage_1.text + ":  Controllo dati Fattura: '" + string(kst_esito.sqlcode) +" - "+ trim(kst_esito.sqlerrtext) + "'~n~r" 
	k_errore = "1"
	k_nr_errori++
			
finally
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari

end try


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

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0

	
//---- scrive Trace su LOG---------
PopulateError(10, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if (tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0  & 
				or tab_1.tabpage_4.dw_4.deletedcount() > 0)  & 
 		 		or tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 & 
 		 		or tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 & 
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
string k_return = "0"
int k_err_ins, k_rc
st_tab_clienti kst_tab_clienti
st_tab_listino kst_tab_listino
st_esito kst_esito
pointer oldpointer
kuf_base kuf1_base
kuf_utility kuf1_utility
datawindowchild  kdwc_1



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

//--- reset degli elenchi ddw
if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and  ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then

	try	
	
		tab_1.tabpage_1.dw_1.getchild("cod_pag", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		if kdwc_1.rowcount() = 0 then
			kdwc_1.retrieve()
			kdwc_1.insertrow(1)
		end if
		tab_1.tabpage_1.dw_1.getchild("id_nazione", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		if kdwc_1.rowcount() = 0 then
			kdwc_1.retrieve()
			kdwc_1.insertrow(1)
		end if
	
		kuf1_base = create kuf_base
		kist_tab_base.fatt_impon_minimo = double(mid(kuf1_base.prendi_dato_base( "fatt_impon_minimo"),2))
		kist_tab_base.sv_call_vettore_id_listino = long(mid(kuf1_base.prendi_dato_base( "sv_call_vettore_id_listino"),2))
		
		if kist_tab_base.sv_call_vettore_id_listino > 0 then
			kst_tab_listino.id = kist_tab_base.sv_call_vettore_id_listino
			ki_art_x_costo_call = kiuf_listino.get_cod_art(kst_tab_listino)
		else
			ki_art_x_costo_call = ""
		end if

	catch(uo_exception kuo2_exception)
		kuo2_exception.messaggio_utente()
		
	finally
		if isvalid(kuf1_base) then destroy kuf1_base
	end try
	
end if

kist_tab_arfa_orig.num_fatt = 0
kist_tab_arfa_orig.data_fatt = date(0)

if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	kist_tab_arfa.id_fattura  = 0
	kist_tab_arfa.clie_3 = 0
	if isnumber(ki_st_open_w.key1) then
		kist_tab_arfa.id_fattura  = long(trim(ki_st_open_w.key1))
	end if
	if isnumber(ki_st_open_w.key2) then
		kist_tab_arfa.clie_3  = long(trim(ki_st_open_w.key2))
	end if

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
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
		tab_1.tabpage_1.dw_1.setredraw(true)
		
		choose case k_rc

			case is < 0		
				SetPointer(oldpointer)
				kguo_exception.inizializza()
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
				kguo_exception.setmessage(  &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
				kguo_exception.messaggio_utente( )	
				//post close(this)
				k_return = ki_UsitaImmediata

			case 0
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento

					SetPointer(oldpointer)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
					kguo_exception.setmessage(  &
						"Mi spiace ma il Documento non e' in archivio ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
					kguo_exception.messaggio_utente( )	
					//close(this)
					k_return = ki_UsitaImmediata
					
				else
					kist_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura
					kist_tab_arfa.data_fatt = kg_dataoggi
					k_err_ins = inserisci()
				end if

			case is > 0		
				kist_tab_arfa_orig.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_fatt")
				kist_tab_arfa_orig.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt")
				
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
					SetPointer(oldpointer)
					kguo_exception.inizializza()
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
					kguo_exception.setmessage(  &
						"Attenzione, il Documento e' ga' stato Caricato ~n~r" + &
						"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
					kguo_exception.messaggio_utente( )	
			
					ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica

				end if

				if tab_1.tabpage_1.dw_1.getitemnumber ( 1, "iva") > 0 then
					tab_1.tabpage_1.dw_1.setitem ( 1, "k_iva_esente", 1) 
				else
					tab_1.tabpage_1.dw_1.setitem ( 1, "k_iva_esente", 0) 
				end if
				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn("fat1_note_1")

				
				attiva_tasti()
		
		end choose

	end if	

else
	if	k_return <> ki_UsitaImmediata then
		attiva_tasti()
	end if
end if



if	k_return <> ki_UsitaImmediata then

	try

//--- se sono in CANCELLAZIONE....
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	
	//--- se sono entrato x cancellazione...				
			ki_esci_dopo_cancella = true
			cb_cancella.event clicked( )
	
		else
			//--- se primo giro imposta la data di competenza di default
			if tab_1.tabpage_1.dw_1.rowcount() > 0 and ki_st_open_w.flag_primo_giro = 'S' then
				tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
			end if
			
			//===
			//--- se inserimento inabilito gli altri TAB, sono inutili
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			
				tab_1.tabpage_2.enabled = false
				tab_1.tabpage_3.enabled = false
				tab_1.tabpage_4.enabled = false
				tab_1.tabpage_5.enabled = false
				
			end if
		

//--- controlli particolari	
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica and ki_st_open_w.flag_primo_giro = "S" then
			
				try 
//--- posso modificare il documento?
					kiuf_fatt.if_modifica(kist_tab_arfa) 
			
	//--- se fattura già STAMPATA allora ATTENZIONE alle Modifiche	!!!!!	
					if tab_1.tabpage_1.dw_1.getitemstring( 1, "stampa") = kiuf_fatt.kki_stampa_stampato then
			//						ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
			
						kguo_exception.inizializza()
						kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_allerta )
						kguo_exception.setmessage(  &
							"Attenzione, il Documento e' ga' stato Stampato. La Modifica potrebbe comprometterne l'integrità. ~n~r" + &
							"(ID Documento cercato:" + string(kist_tab_arfa.id_fattura) + ") " )
						kguo_exception.messaggio_utente( )	
					end if
					
				catch(uo_exception kuo1_exception)
					ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
					kuo1_exception.messaggio_utente()
	
				end try
			end if	
	
	//--- Inabilita campi alla modifica se Vsualizzazione
			kuf1_utility = create kuf_utility 
			if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then
		
				tab_1.tabpage_1.dw_1.object.p_img_indi.visible = false 
				tab_1.tabpage_1.dw_1.object.p_img_note.visible = false 
			
				kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		
			else		
				
				tab_1.tabpage_1.dw_1.object.p_img_indi.visible = true 
				tab_1.tabpage_1.dw_1.object.p_img_note.visible = true 
				
	//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
	
	//--- Inabilita campi documento alla modifica se Funzione MODIFICA
				if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
					kuf1_utility.u_proteggi_dw("1", "tipo_doc", tab_1.tabpage_1.dw_1)
		//			kuf1_utility.u_proteggi_dw("1", "num_fatt", tab_1.tabpage_1.dw_1)
		//			kuf1_utility.u_proteggi_dw("1", "data_fatt", tab_1.tabpage_1.dw_1)
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
			
			tab_1.tabpage_1.dw_1.setfocus()
	
		end if 

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	end try

end if

SetPointer(oldpointer)


return k_return


end function

protected function integer inserisci ();//
int k_return=0
kuf_base kuf1_base
kuf_utility kuf1_utility


//if ki_tab_1_index_new <> 1 then 
//	tab_1.selectedtab = 1
//end if

//--- Aggiunge una riga al data windows
	choose case ki_tab_1_index_new 
		case  1 
			this.setredraw(false)
	
			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				kist_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_fatt" ) 
				kist_tab_arfa.tipo_doc = tab_1.tabpage_1.dw_1.getitemstring( 1, "tipo_doc" ) 
				ki_data_competenza = tab_1.tabpage_1.dw_1.getitemdate( 1, "k_competenza_dal" ) 
				ki_cadenza_fattura = tab_1.tabpage_1.dw_1.getitemstring( 1, "k_clienti_fattura" ) 
			end if
	
			tab_1.tabpage_5.dw_5.reset() 
			tab_1.tabpage_4.dw_4.reset() 
			tab_1.tabpage_1.dw_1.reset() 
			
			tab_1.tabpage_1.dw_1.insertrow(0)
			
//--- S-protezione campi per riabilitare la modifica a parte la chiave
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
			
			tab_1.tabpage_1.dw_1.setitem( 1, "k_clienti_fattura", ki_cadenza_fattura)
			tab_1.tabpage_1.dw_1.setitem( 1, "k_competenza_dal",  ki_data_competenza)
			tab_1.tabpage_1.dw_1.setitem( 1, "tipo_doc", kist_tab_arfa.tipo_doc)
			tab_1.tabpage_1.dw_1.setitem( 1, "stampa", kiuf_fatt.kki_stampa_da_stampare)
			tab_1.tabpage_1.dw_1.setitem( 1, "data_fatt", kist_tab_arfa.data_fatt )

			kuf1_base = create kuf_base
			kist_tab_arfa.num_fatt = long(mid(kuf1_base.prendi_dato_base( "num_fatt"),2))
			destroy kuf1_base
			kist_tab_arfa.num_fatt ++
			tab_1.tabpage_1.dw_1.setitem( 1, "num_fatt", kist_tab_arfa.num_fatt )
			
			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
			
			this.setredraw(true)

			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn("id_cliente")

//---- azzera il flag delle modifiche
			tab_1.tabpage_1.dw_1.ResetUpdate ( ) 
			tab_1.tabpage_4.dw_4.ResetUpdate ( ) 

//--- popola dw child dw clienti 
			set_dw_clienti_child()

		
		case 4 // 
			
//			if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
//				if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito &
//						and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
//					elenco_sped_non_fatt()
//				else
//					if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito  &
//							and tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
//						elenco_lotti_non_fatt()
//					else
//						if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito then
//							ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
//						end if
//					end if
//				end if
//			end if
			
		case 5 // dati PA
			tab_1.tabpage_5.dw_5.reset() 
			tab_1.tabpage_5.dw_5.insertrow(0)

			
	end choose	

	k_return = 0


	attiva_tasti()


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

//--- dati PA
	if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then 
		if tab_1.tabpage_5.dw_5.getitemnumber(1, "id_fattura") > 0 then
		else
			if trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_id")) > " " &
		   		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_commessa")) > " " &
		    		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cig")) > " " &
		   		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cup")) > " " &
			 	 then 
			else
				tab_1.tabpage_5.dw_5.reset() 
			end if
		end if
	end if

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

//--- imposta campi di default x dati e-mail	
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
	kiuf_armo_prezzi = create kuf_armo_prezzi
	kiuf_clienti = create kuf_clienti
	kiuf_sped = create kuf_sped
	kiuf_prodotti = create kuf_prodotti
	kiuf_ausiliari = create kuf_ausiliari
	kiuf_listino = create kuf_listino
	kiuf_menu_window = create kuf_menu_window 

	kids_elenco_input = create datastore

	ki_toolbar_window_presente=true
	
	kist_tab_arfa.data_fatt = kg_dataoggi

	ki_data_competenza = relativedate(kg_dataoggi, - 90)
	ki_cadenza_fattura = kiuf_fatt.kki_cadenza_fattura_fine_mese
	 
//	tab_1.tabpage_1.dw_1.object.b_ric_lotto.filename = kGuo_path.get_risorse() + "\scadenzario.gif" 
//	tab_1.tabpage_1.dw_1.object.b_contab.filename = kGuo_path.get_risorse() + "\contabilita.gif" 
//	tab_1.tabpage_1.dw_1.object.b_cliente.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_indi.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_note.filename = kGuo_path.get_risorse() + kkg_risorsa_elenco 
//	tab_1.tabpage_1.dw_1.object.b_lettera_vedi.filename = kGuo_path.get_risorse() + "\lente16x16.gif" 
//	tab_1.tabpage_5.picturename  = kGuo_path.get_risorse() + kkg.path_sep + "aereo32.png" 
	tab_1.tabpage_5.picturename  = "aereo32.png" 

	dw_anno_numero.insertrow( 0 )
	dw_anno_numero.object.numero[1] = 0
	if dw_anno_numero.object.anno[1] = 0 or isnull(dw_anno_numero.object.anno[1]) then
		dw_anno_numero.object.anno[1]  = year(relativedate(kg_dataoggi, - 20))
	end if

end subroutine

protected subroutine attiva_menu ();//
//---
//
boolean k_attiva

//---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
//-------------------------------------

//=== 
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then	
		
//--- fattura da DDT
		if tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
			ki_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco DDT spediti da Fatturare " 
//			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = kguo_path.get_risorse( ) + kkg.path_sep + "bolla.gif"
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "bolla.gif"
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "ddt, Spedizioni da Fatturare  "
//--- fattura da Attestato
		elseif tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
			ki_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Attestati da Fatturare "  
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "ScriptYes!"
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Attestati, Attestati da Fatturare  "
//--- fattura ACCONTI			
		elseif tab_1.tabpage_1.dw_1.object.fattura_da[1] = "A" then 
			ki_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Acconti di CO da Fatturare "  
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemname = "Custom004!"
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Acconti, Acconti CO da Fatturare  "
		end if
		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] <> kiuf_fatt.kki_tipo_doc_nota_di_credito then 
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> k_attiva then 
			ki_menu.m_strumenti.m_fin_gest_libero1.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = ki_menu.m_strumenti.m_fin_gest_libero1.text
			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//			ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = k_attiva
		end if

		if tab_1.tabpage_1.dw_1.object.tipo_doc[1] = kiuf_fatt.kki_tipo_doc_nota_di_credito &
				and tab_1.tabpage_4.enabled then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Fatture emesse " 
			ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Elenco Fatture "
			ki_menu.m_strumenti.m_fin_gest_libero3.visible = true

			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Fatture, Fatture emesse "
//			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

			ki_menu.m_strumenti.m_fin_gest_libero3.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "Custom048!"
		end if

		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione &
				and tab_1.tabpage_4.enabled then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero4.text = "Aggiungi Riga Libera " 
			ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Aggiungi Riga Libera senza movimentazioni di Magazzino"
			ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
	
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = 	"Libera, Nuova Riga Libera "
//			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
	
			ki_menu.m_strumenti.m_fin_gest_libero4.enabled = k_attiva
			ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "DataManip!"
		end if

		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione &
				and tab_1.tabpage_4.enabled then
			k_attiva = true
		else
			k_attiva = false
		end if
		if ki_menu.m_strumenti.m_fin_gest_libero5.enabled <> k_attiva then
			ki_menu.m_strumenti.m_fin_gest_libero5.text = "Aggiungi Riga Merce non Trattata " 
			ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Aggiungi Riga Merce senza Lavorazione (no-dose)"
			ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
	
			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = 	"Merce, Nuova Riga senza Trattamento "
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	
			ki_menu.m_strumenti.m_fin_gest_libero5.enabled = k_attiva
//			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = kGuo_path.get_risorse() + "\lotto16x16.gif"
			ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "lotto16x16.gif"
		end if

		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione &
				and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione &
				and tab_1.tabpage_4.enabled &
				and tab_1.tabpage_4.dw_4.rowcount( ) > 0 then	
			k_attiva = true
		else
			k_attiva = false
		end if
		ki_menu.m_finestra.m_gestione.m_fin_elimina.toolbaritemvisible = k_attiva
		
//		this.settoolbar( 2, false) //true)
	else
//		this.settoolbar( 2, false)
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = false
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
	end if

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()

	
end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case trim(k_par_in) 

	case kkg_flag_richiesta.libero1
//--- Elenco Spedizioni da Fatturare
		if tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_bolla then
			elenco_sped_non_fatt()
//--- elenco fattura da Attestato
		elseif tab_1.tabpage_1.dw_1.object.fattura_da[1] = kiuf_clienti.kki_fattura_da_certif then
			elenco_lotti_non_fatt()
//--- elenco fattura ACCONTI			
		elseif tab_1.tabpage_1.dw_1.object.fattura_da[1] = "A" then 
			elenco_acconti_non_fatt()
		end if

//	case kkg_flag_richiesta.libero2		//Elenco Lotti già Attestati da Fatturare
//		elenco_lotti_non_fatt()

	case kkg_flag_richiesta.libero3		//Elenco Fatture x fare Nota di Credito
		elenco_lotti_fatt()

	case kkg_flag_richiesta.libero4		//aggiungi riga libera
		riga_libera_aggiungi( )

	case kkg_flag_richiesta.libero5		//Elenco Lotti senza Trattamento
		elenco_lotti_no_dose()

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




//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if (kst_tab_arfa.clie_3) > 0 then
	
		kp_oldpointer = SetPointer(HourGlass!)


		if not isvalid(kids_elenco_sped) then kids_elenco_sped = create datastore

		kids_elenco_sped.reset( )
		kst_tab_arfa.data_bolla_out = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
	
		kids_elenco_sped.dataobject = kiuf_fatt.kki_dw_sped_non_fatt
		kids_elenco_sped.settransobject ( sqlca )
		k_riga = kids_elenco_sped.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.data_bolla_out) 
		kst_open_w.key1 = "Elenco Bolle da fatturare a: " + string(kst_tab_arfa.clie_3)


		if kids_elenco_sped.rowcount() > 0 then

//-- screma elenco da righe già in fattura
			for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
				if tab_1.tabpage_4.dw_4.getitemstatus(k_ind, 0, primary!) = New! then
					kst_tab_arfa.num_bolla_out = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "num_bolla_out")
					kst_tab_arfa.data_bolla_out = tab_1.tabpage_4.dw_4.getitemdate( k_ind, "data_bolla_out")
					kst_tab_arfa.colli = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "colli")
					if kst_tab_arfa.num_bolla_out > 0 then 
						k_riga = kids_elenco_sped.find( "num_bolla_out = " + string( kst_tab_arfa.num_bolla_out) + " and data_bolla_out = date('" + string( kst_tab_arfa.data_bolla_out) + "') ", &
																					 1, kids_elenco_sped.rowcount( ) )
						if k_riga > 0 then
							kst_tab_arsp.colli = tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "colli")
							if kst_tab_arsp.colli > kst_tab_arfa.colli then
								kst_tab_arsp.colli = kst_tab_arsp.colli - kst_tab_arfa.colli
								kids_elenco_sped.setitem( k_riga, "colli", kst_tab_arsp.colli)
							else
								kids_elenco_sped.deleterow( k_riga )
							end if
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
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kids_elenco_sped.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key6 = " "    //--- nome del campo cliccato
			kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
			kst_open_w.key12_any = kids_elenco_sped
			kst_open_w.flag_where = " "
			kiuf_menu_window.open_w_tabelle(kst_open_w)
		
			tab_1.selectedtab = 4
		else
			
			messagebox("Elenco Dati", &
						"Nessun valore disponibile. ")
			
			
		end if

		SetPointer(kp_oldpointer)

	else

		tab_1.selectedtab = 1

//--- se manca il CLIENTE allora chiedo il Numero Bolla per reperirlo
		dw_anno_numero.title = "Ricerca Cliente: indicare Nr.Spedizione "
		dw_anno_numero.setcolumn( "numero")
		dw_anno_numero.SelectText(1, Len(dw_anno_numero.GetText()))
		dw_anno_numero.visible = true
		dw_anno_numero.setfocus()
	
	end if

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------




end subroutine

private subroutine elenco_lotti_non_fatt ();//
//--- Fa l'elenco delle Entrate con Attestat ma non fatturate (screma quelle già presenti in fattura)
//
long k_ind, k_riga
date k_data_competenza_dal
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_open_w kst_open_w 
st_stat_invent kst_stat_invent
//kuf_clienti kuf1_clienti
datastore kds_barcode_sosp
pointer kp_oldpointer  // Declares a pointer variable

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


try
	
	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if (kst_tab_arfa.clie_3) > 0 then

		kp_oldpointer = SetPointer(HourGlass!)


		if not isvalid(kids_elenco_lotti) then kids_elenco_lotti = create datastore
		if not isvalid(kds_barcode_sosp) then kds_barcode_sosp = create datastore
		
		kids_elenco_lotti.reset( )

		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
		k_data_competenza_dal = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
		if (kst_tab_arfa.clie_3) > 0 then

			kids_elenco_lotti.dataobject = kiuf_fatt.kki_dw_righe_non_fatt 
			kids_elenco_lotti.settransobject ( sqlca )
			kids_elenco_lotti.retrieve(kst_tab_arfa.clie_3, k_data_competenza_dal) 
			kst_open_w.key1 = "Elenco Lotti da fatturare a: " + string(kst_tab_arfa.clie_3)


			if kids_elenco_lotti.rowcount() > 0 then

				kds_barcode_sosp.dataobject = "d_barcode_l_sosp"
				kds_barcode_sosp.settransobject( sqlca )

				for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_armo")
					if kst_tab_arfa.id_armo > 0 then 
						k_riga = kids_elenco_lotti.find( "id_armo = " + string( kst_tab_arfa.id_armo) + " " , 1, kids_elenco_lotti.rowcount( ) )
						if k_riga > 0 then
							 kids_elenco_lotti.deleterow( k_riga )
						end if
					end if
				next

//-- screma elenco da righe già in fattura
				for k_riga = kids_elenco_lotti.rowcount( ) to 1  step -1
					kst_tab_arfa.id_armo = kids_elenco_lotti.getitemnumber( k_riga, "id_armo")
//--- get dei colli fatturati x id_armo
					kst_tab_arfa.colli = kiuf_fatt.get_colli_fatturati_x_id_armo(kst_tab_arfa)
					if kst_tab_arfa.colli > 0 then
//--- scremo ancora se ci sono barcode da non trattare (causale=T)
						kds_barcode_sosp.reset( )
						kds_barcode_sosp.retrieve(kst_tab_arfa.id_armo)
						if kds_barcode_sosp.rowcount( ) > 0 and kds_barcode_sosp.getitemnumber( 1, "nrSospesi") > 0 then
							if (kids_elenco_lotti.getitemnumber( k_riga, "colli_2") - kds_barcode_sosp.getitemnumber( 1, "nrSospesi"))  &
										>= kst_tab_arfa.colli then
								 kids_elenco_lotti.deleterow( k_riga )
							else
//--- aggiungo in elenco il numero colli fatturati
								kids_elenco_lotti.setitem(k_riga, "colli_fatt", kst_tab_arfa.colli)
							end if
						else
//--- aggiungo in elenco il numero colli fatturati
							kids_elenco_lotti.setitem(k_riga, "colli_fatt", kst_tab_arfa.colli)
						end if
					end if
				next
							


	
//--- chiamare la window di elenco
//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma.elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kids_elenco_lotti.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
				kst_open_w.key12_any = kids_elenco_lotti
				kst_open_w.flag_where = " "
				kiuf_menu_window.open_w_tabelle(kst_open_w)
			
				tab_1.selectedtab = 4
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		end if

		SetPointer(kp_oldpointer)
	else

		tab_1.selectedtab = 1

//--- se manca il CLIENTE allora chiedo il Numero Bolla per reperirlo
		dw_anno_numero.title = "Ricerca Cliente: indicare Nr.Lotto (Riferimento) "
		dw_anno_numero.setcolumn( "numero")
		dw_anno_numero.SelectText(1, Len(dw_anno_numero.GetText()))
		dw_anno_numero.visible = true
		dw_anno_numero.setfocus()

	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


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

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if (kst_tab_arfa.clie_3) > 0 then
	
		kp_oldpointer = SetPointer(HourGlass!)

		if not isvalid(kids_elenco_fatt) then kids_elenco_fatt = create datastore

		kids_elenco_fatt.reset( )

		kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
		kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal")
		if (kst_tab_arfa.clie_3) > 0 then
	
			kids_elenco_fatt.dataobject = kiuf_fatt.kki_dw_righe_fatt 
			kids_elenco_fatt.settransobject ( sqlca )
			kids_elenco_fatt.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.data_fatt) 
			kst_open_w.key1 = "Elenco Fatture di: " + string(kst_tab_arfa.clie_3)


			if kids_elenco_fatt.rowcount() > 0 then


//-- screma elenco da righe già in fattura
				for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
					kst_tab_arfa.id_arfa = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_arfa")
					if kst_tab_arfa.id_arfa > 0 then 
						k_riga = kids_elenco_fatt.find( "id_arfa_se_nc = " + string( kst_tab_arfa.id_arfa) + " " , 1, kids_elenco_fatt.rowcount( ) )
						if k_riga > 0 then
							 kids_elenco_fatt.deleterow( k_riga )
						end if
					end if
				next
	
	
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma_elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kids_elenco_fatt.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key6 = " "    //--- nome del campo cliccato
				kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
				kst_open_w.key12_any = kids_elenco_fatt
				kst_open_w.flag_where = " "
				kiuf_menu_window.open_w_tabelle(kst_open_w)

				tab_1.selectedtab = 4
			
			else
				
				messagebox("Elenco Dati", &
							"Nessun valore disponibile. ")
				
				
			end if
		end if

		SetPointer(kp_oldpointer)
	else

		tab_1.selectedtab = 1

//--- se manca il CLIENTE allora chiedo il Numero Bolla per reperirlo
		dw_anno_numero.title = "Ricerca Cliente: indicare Nr.Fattura "
		dw_anno_numero.setcolumn( "numero")
		dw_anno_numero.SelectText(1, Len(dw_anno_numero.GetText()))
		dw_anno_numero.visible = true
		dw_anno_numero.setfocus()
	
	end if
	
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
st_esito kst_esito
st_tab_nazioni kst_tab_nazioni
st_tab_pagam kst_tab_pagam
st_clienti_esenzione_iva kst_clienti_esenzione_iva
//kuf_ausiliari kuf1_ausiliari


////---- scrive Trace su LOG---------
//PopulateError(kst_tab_clienti.codice, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

tab_1.tabpage_1.dw_1.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "id_cliente", kst_tab_clienti.codice )
tab_1.tabpage_1.dw_1.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "rag_soc_10", trim(kst_tab_clienti.rag_soc_10) )
tab_1.tabpage_1.dw_1.modify( "p_iva.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "p_iva", trim(kst_tab_clienti.p_iva) )
tab_1.tabpage_1.dw_1.modify( "cf.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
tab_1.tabpage_1.dw_1.setitem( 1, "cf", trim(kst_tab_clienti.cf) )

tab_1.tabpage_1.dw_1.setitem( 1, "cadenza_fattura", kst_tab_clienti.cadenza_fattura)
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
tab_1.tabpage_1.dw_1.setitem( 1, "id_nazione", kst_tab_clienti.kst_tab_ind_comm.id_nazione_c )
tab_1.tabpage_1.dw_1.setitem( 1, "fattura_da", kst_tab_clienti.kst_tab_clienti_fatt.fattura_da )

tab_1.tabpage_1.dw_1.setitem(1, "k_iva_esente", 0)
tab_1.tabpage_1.dw_1.setitem( 1, "iva", kst_tab_clienti.iva )
if kst_tab_clienti.iva > 0 then
		
	kst_clienti_esenzione_iva.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber ( 1, "id_fattura")
	kst_clienti_esenzione_iva.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber ( 1, "id_cliente")
	kst_clienti_esenzione_iva.data_fatt = tab_1.tabpage_1.dw_1.getitemdate ( 1, "data_fatt")
	kst_clienti_esenzione_iva.iva = kst_tab_clienti.iva
	kst_clienti_esenzione_iva.importo_t = this.get_totale_x_iva(kst_clienti_esenzione_iva.iva)
//	if  double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1]) > 0 then 
//		kst_clienti_esenzione_iva.importo_t = double(tab_1.tabpage_4.dw_4.object.k_tot_imponibile[1])
//	else
//		kst_clienti_esenzione_iva.importo_t = 0
//	end if
	try
		kiuf_clienti.esenzione_iva_controllo_fattura (kst_clienti_esenzione_iva)
		choose case  kst_clienti_esenzione_iva.ESITO
			case "0"  // ESENTE!
				tab_1.tabpage_1.dw_1.setitem(1, "k_iva_esente", 1)
			case "1" //nessuna esenzione indicata sul cliente
				tab_1.tabpage_1.dw_1.setitem(1, "k_iva_esente", 0)
			case "2" //esenzione scaduta
				tab_1.tabpage_1.dw_1.setitem(1, "k_iva_esente", 0)
			case "3" //esenzione oltre l'importo massimo indicato su clienti
				tab_1.tabpage_1.dw_1.setitem(1, "k_iva_esente", 0)
		end choose
	catch (uo_exception kuo_exception) 
		kst_esito = kuo_exception.get_st_esito()
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.set_esito( kst_esito)
			kguo_exception.messaggio_utente( )
		end if
	end try 
		
end if
tab_1.tabpage_1.dw_1.setitem( 1, "fat1_note_1", trim(kst_tab_clienti.kst_tab_clienti_fatt.note_1) )
tab_1.tabpage_1.dw_1.setitem( 1, "fat1_note_2", trim(kst_tab_clienti.kst_tab_clienti_fatt.note_2) )

tab_1.tabpage_1.dw_1.setitem( 1, "modo_stampa", trim(kst_tab_clienti.kst_tab_clienti_fatt.modo_stampa) )
tab_1.tabpage_1.dw_1.setitem( 1, "modo_email", trim(kst_tab_clienti.kst_tab_clienti_fatt.modo_email) )
tab_1.tabpage_1.dw_1.setitem( 1, "email_invio", trim(kst_tab_clienti.kst_tab_clienti_fatt.email_invio) )


kst_tab_clienti.id_nazione_1 = trim(kst_tab_clienti.id_nazione_1)
if (kst_tab_clienti.id_nazione_1 <> "IT" and kst_tab_clienti.id_nazione_1 <> "SM" and kst_tab_clienti.id_nazione_1 <> "") then
	tab_1.tabpage_1.dw_1.setitem( 1, "stampa_tradotta",kiuf_fatt.kki_arfa_testa_stampa_tradotta_EN)
else
	tab_1.tabpage_1.dw_1.setitem( 1, "stampa_tradotta",kiuf_fatt.kki_arfa_testa_stampa_tradotta_IT)
end if


put_video_pagam(kst_tab_clienti)

attiva_tasti()

//kuf1_ausiliari = create kuf_ausiliari
//kst_tab_nazioni.id_nazione = kst_tab_clienti.id_nazione_1
//kst_esito = kuf1_ausiliari.tb_select( kst_tab_nazioni )
//if kst_esito.esito = kkg_esito.ok then
//	tab_1.tabpage_1.dw_1.setitem( 1, "nazioni_nome", kst_tab_nazioni.nome )
//end if
//destroy kuf1_ausiliari

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti

////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------
//

try
	
//	kuf1_clienti = create kuf_clienti

	k_return = kiuf_clienti.leggi (kst_tab_clienti)
	
//--- Gestione di Allert per il cliente 	
	u_allarme_cliente(kst_tab_clienti)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
////---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

	
end try

return k_return


end function

private subroutine put_video_pagam (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Pagamento
//
long k_riga=0
datawindowchild kdwc_1


//---- scrive Trace su LOG---------
PopulateError(kst_tab_clienti.cod_pag, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

tab_1.tabpage_1.dw_1.modify( "cod_pag.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
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


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

tab_1.tabpage_1.dw_1.modify( "id_nazione.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
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
pointer kp_oldpointer  // Declares a pointer variable

	
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

kp_oldpointer = SetPointer(HourGlass!)


	kist_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
	if kist_tab_arfa.clie_3 > 0 then
		kiuf_fatt.elenco_indirizzi_commerciale( kist_tab_arfa )
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

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

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
		kst_tab_arfa.comm = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "des")
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
		kst_tab_arfa.id_armo_prezzo = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_armo_prezzo" )
		kst_tab_arfa.id_listino = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_listino")
		kst_tab_arfa.id_arfa_se_nc = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_arfa_se_nc")
		kst_tab_arfa.contratto = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "contratto")
	end if

	dw_riga.object.b_aggiungi.visible = false 
	dw_riga.object.b_aggiorna.visible = true 


	if kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_varia then
//		dw_riga.triggerevent ("u_attiva_riga_varia")
		dw_riga.event u_attiva_riga_varia()
		k_riga1=dw_riga.insertrow(0)
		dw_riga.setitem( k_riga1, "art", kst_tab_arfa.art )
		dw_riga.setitem( k_riga1, "comm", kst_tab_arfa.comm )
		dw_riga.setitem( k_riga1, "colli", kst_tab_arfa.colli_out )
		dw_riga.setitem( k_riga1, "prezzo_u", kst_tab_arfa.prezzo_u )
		dw_riga.setitem( k_riga1, "iva", kst_tab_arfa.iva )
		dw_riga.setitem( k_riga1, "prezzo_t", kst_tab_arfa.prezzo_t )
		dw_riga.setitem( k_riga1, "contratto", kst_tab_arfa.contratto )
		u_set_d_arfa_v_dwchild( )
	else
//		dw_riga.triggerevent( "u_attiva_riga_magazzino" )
		dw_riga.event u_attiva_riga_magazzino()
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
		dw_riga.setitem( k_riga1, "id_armo_prezzo", kst_tab_arfa.id_armo_prezzo )

		if tab_1.tabpage_1.dw_1.getitemnumber(k_riga1, "k_iva_esente") = 1 then // se ESENTE iva non modificabile
			kuf_utility kuf1_utility
			kuf1_utility = create kuf_utility
			kuf1_utility.u_proteggi_dw("1", "iva", dw_riga)
			destroy kuf1_utility
		end if
	end if

	dw_riga.setitem(k_riga1, "tipo_riga", kst_tab_arfa.tipo_riga )
	dw_riga.setitem(k_riga1, "k_progressivo", tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "k_progressivo"))

	if kst_tab_arfa.id_arfa > 0 then
		dw_riga.title = "Dettaglio riga " + string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "nriga")) + " (id=" + string(kst_tab_arfa.id_arfa) + ") " 
	else
		dw_riga.title = "Nuova riga " + string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "nriga")) 
	end if

	dw_riga.event u_calcola_tot_iva( )
	
	dw_riga.visible = true		
		
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	
end subroutine

private subroutine riga_libera_aggiungi ();//======================================================================
//=== 
//======================================================================
//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	dw_riga.event u_attiva_riga_varia()

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	dw_riga.event u_aggiungi()
	dw_riga.setitem(dw_riga.getrow(), "tipo_riga", kiuf_fatt.kki_tipo_riga_varia)
	u_set_d_arfa_v_dwchild()  // setta il dw child su riga varia
	
		
	
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
string k_cadenza_fattura
int k_rc, k_ctr, k_nriga
st_tab_arfa kst_tab_arfa
kuf_utility kuf1_utility 
uo_exception kuo_exception

//---- scrive Trace su LOG---------
PopulateError(3, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")  
k_scelta = trim(ki_st_open_w.flag_modalita)

if kst_tab_arfa.id_fattura > 0 then

	if tab_1.tabpage_4.dw_4.rowcount() < 1 then

//--- Inabilita campi sempre
		kuf1_utility = create kuf_utility 
//		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica &
//			  and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)
//		end if
		destroy kuf1_utility

		if tab_1.tabpage_4.dw_4.retrieve(kst_tab_arfa.id_fattura) <= 0 then
//--- Inserimento: nuova fattura
		
//--- controllo se Cliente è della giusta cadenza di fatturazione
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				if not isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "cadenza_fattura")) then
					k_cadenza_fattura = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cadenza_fattura"))
				end if
				k_ctr = pos(ki_cadenza_fattura, k_cadenza_fattura, 1)
				if k_ctr = 0 or isnull(k_ctr) then
					kuo_exception = create uo_exception
					kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_dati_anomali )
					kuo_exception.setmessage( "Cliente non coerente con la Cadenza di Fatturazione indicata")
					throw kuo_exception
				end if
			end if
			
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
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				tab_1.tabpage_4.dw_4.setrow(1)
				tab_1.tabpage_4.dw_4.selectrow(1,true)
			end if
		end if				

//---- azzera il flag delle modifiche
		tab_1.tabpage_4.dw_4.ResetUpdate ( ) 
	end if

else

//	inserisci()
	
end if

tab_1.tabpage_4.dw_4.setcolumn("num_int")
tab_1.tabpage_4.dw_4.setfocus()

attiva_tasti()
	

end subroutine

private subroutine dragdrop_dw_esterna (uo_d_std_1 kdw_source, long k_riga);//
//
int k_rc
long  k_riga1, k_ind_selected, k_ind
st_tab_arfa kst_tab_arfa
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_artr kst_tab_artr
st_tab_arsp kst_tab_arsp[]
st_tab_sped kst_tab_sped
st_esito kst_esito
datawindowchild kdwc_1
kuf_artr kuf1_artr


	
//---- scrive Trace su LOG---------
PopulateError(k_riga, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

if k_riga > 0 then 

	setpointer(kkg.pointer_attesa)

//--- Se dalla w di elenco 'prevista'  ho fatto doppio-click	 x scegliere la riga	
	if ki_tab_1_index_new = 1 then
		choose case kdw_source.dataobject 

//-- DROP nel TAB 1

//--- scelta da elenco Indirizzo
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
		
//--- scelta da elenco NOTE
			case  kiuf_fatt.kki_dw_elenco_note 
			
				if kdw_source.rowcount() > 0 then
//					tab_1.tabpage_1.dw_1. tab_1.tabpage_1.dw_1.getcolumn( ) 
// quiii mettere le istruzioni x partire dal posizionamento
					tab_1.tabpage_1.dw_1.setitem(1, "fat1_note_1",  kdw_source.getitemstring(long(k_riga), "note_1"))
					tab_1.tabpage_1.dw_1.setitem(1, "fat1_note_2",  kdw_source.getitemstring(long(k_riga), "note_2"))
					tab_1.tabpage_1.dw_1.setitem(1, "fat1_note_3",  kdw_source.getitemstring(long(k_riga), "note_3"))
					tab_1.tabpage_1.dw_1.setitem(1, "fat1_note_4",  kdw_source.getitemstring(long(k_riga), "note_4"))
					if len(trim(kdw_source.getitemstring(long(k_riga), "note_5"))) > 0 then tab_1.tabpage_1.dw_1.setitem(1, "fat1_note_5",  kdw_source.getitemstring(long(k_riga), "note_5"))
				end if
		
		end choose

	end if
	
//-- DROP nel TAB 4	
	if ki_tab_1_index_new = 4 and	 kdw_source.rowcount() > 0 then
	

		choose case kdw_source.dataobject 
	
//--- se torno da elenco bolle non fatturate
			case  kiuf_fatt.kki_dw_sped_non_fatt 

					k_ind_selected = kdw_source.getselectedrow( 0 )
	
					do while k_ind_selected > 0 
						
						if kdw_source.getitemnumber(k_ind_selected, "id_sped") > 0 then

							kst_tab_arfa.num_bolla_out = kdw_source.getitemnumber(k_ind_selected, "num_bolla_out")
							kst_tab_arfa.data_bolla_out = kdw_source.getitemdate(k_ind_selected, "data_bolla_out")
							kst_tab_arsp[1].id_sped = kdw_source.getitemnumber(k_ind_selected, "id_sped")
							kst_tab_arsp[1].num_bolla_out = kst_tab_arfa.num_bolla_out 
							kst_tab_arsp[1].data_bolla_out = kst_tab_arfa.data_bolla_out 
							kiuf_sped.get_righe_da_fatt(kst_tab_arsp[])
			
							for k_ind = 1 to upperbound(kst_tab_arsp[])
	
								kst_tab_arfa.tipo_riga = ""
								kst_tab_arfa.colli_out = 0
								kst_tab_arfa.prezzo_u = 0
								kst_tab_arfa.prezzo_t = 0
								
								if kst_tab_arsp[k_ind].id_arsp > 0 then
									
									try	
										
										kst_tab_armo.id_armo =  kst_tab_arsp[k_ind].id_armo
										kst_esito = kiuf_armo.get_id_meca_da_id_armo( kst_tab_armo )
										if kst_esito.esito = kkg_esito.db_ko then
											kguo_exception.inizializza( )
											kguo_exception.set_esito(kst_esito)
											kguo_exception.messaggio_utente( )
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
	//									k_ind = upperbound(kst_tab_arsp[]) + 1
									end try
									
								end if
			
							end for
							
							try	
								kst_tab_sped.num_bolla_out = kst_tab_arfa.num_bolla_out
								kst_tab_sped.data_bolla_out = kst_tab_arfa.data_bolla_out
								kst_tab_sped.id_sped = kst_tab_arsp[1].id_sped
								riga_aggiungi_costo_chiamata(kst_tab_sped)   // Aggiunge riga del COSTO CHIAMATA
							catch (uo_exception kuo1_exception)
								kuo1_exception.messaggio_utente( )
							end try
							
						end if
						
						k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
						
					loop

	
	//--- se torno da elenco Lotti con Attestato
			case  kiuf_fatt.kki_dw_righe_non_fatt 
	
					k_ind_selected = kdw_source.getselectedrow( 0 )
	
					do while k_ind_selected > 0 
						
						try	
							kst_tab_arfa.tipo_riga = ""
							kst_tab_arfa.colli_out = 0
							kst_tab_arfa.prezzo_u = 0
							kst_tab_arfa.prezzo_t = 0
							
							kst_tab_arfa.id_armo = kdw_source.getitemnumber(k_ind_selected, "id_armo")

							kst_tab_artr.id_armo = kst_tab_arfa.id_armo
							kuf1_artr = create kuf_artr
							kst_tab_artr.colli = kuf1_artr.get_colli_trattati_x_id_armo(kst_tab_artr)
							kst_tab_arfa.colli = kst_tab_artr.colli
			

//							kst_tab_arfa.colli = kdw_source.getitemnumber(k_ind_selected, "certif_colli")
							kst_tab_meca.id = kdw_source.getitemnumber(k_ind_selected, "id_meca")	
							
							if kst_tab_arfa.id_armo > 0 then
		
		//--- Aggiungi riga nell'elenco righe Documento										
								riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)			
								
							end if
		
							k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
										
						catch (uo_exception kuo_exception2)
							kuo_exception2.messaggio_utente( )
						end try
							
					loop
					

		
	//--- se torno da elenco Righe Fatturate (quando ad es. sono in N.C.)
			case  kiuf_fatt.kki_dw_righe_fatt 
		
					kst_tab_arfa.id_armo = kdw_source.getitemnumber(long(k_riga), "id_armo")
					kst_tab_arfa.colli = 0 //kdw_source.getitemnumber(long(k_riga), "colli")
					kst_tab_arfa.colli_out = 0
					kst_tab_arfa.id_arfa_se_nc = kdw_source.getitemnumber(long(k_riga), "id_arfa")
					kst_tab_meca.id = kdw_source.getitemnumber(long(k_riga), "id_meca")	
					kst_tab_arfa.art = kdw_source.getitemstring(long(k_riga), "art")	
					kst_tab_arfa.des = kdw_source.getitemstring(long(k_riga), "prodotti_des")	
					kst_tab_arfa.tipo_riga = kdw_source.getitemstring(long(k_riga), "tipo_riga")	
					kst_tab_arfa.tipo_l = kuf_listino.kki_tipo_prezzo_a_corpo
					
//--- piglia i prezzi da riproporre nella N.C.
					kst_tab_arfa.id_arfa = kdw_source.getitemnumber(long(k_riga), "id_arfa")	
					kiuf_fatt.get_prezzi_fattura(kst_tab_arfa)
					kst_tab_arfa.id_arfa = 0
					try	
						riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)			
		
						tab_1.tabpage_4.dw_4.setfocus()
		
					catch (uo_exception kuo_exception3)
						kuo_exception3.messaggio_utente( )
					end try


	
	//--- se torno da elenco Lotti Righe Senza Trattamento
			case  kiuf_fatt.kki_dw_righe_no_fatt_no_dose 
	
					k_ind_selected = kdw_source.getselectedrow( 0 )
	
					do while k_ind_selected > 0 
						
						kst_tab_arfa.tipo_riga = ""
						kst_tab_arfa.colli_out = 0
						kst_tab_arfa.prezzo_u = 0
						kst_tab_arfa.prezzo_t = 0
						
						kst_tab_arfa.id_armo = kdw_source.getitemnumber(k_ind_selected, "id_armo")
						kst_tab_arfa.colli = 0 //kdw_source.getitemnumber(k_ind_selected, "colli_da_fatt")
						kst_tab_meca.id = kdw_source.getitemnumber(k_ind_selected, "id_meca")	
							
						if kst_tab_arfa.id_armo > 0 then
		
		//--- Aggiungi riga nell'elenco righe Documento										
							try	
								riga_nuova_in_lista(kst_tab_arfa, kst_tab_meca)		
								
							catch (uo_exception kuo_exception4)
								kuo_exception4.messaggio_utente( )
							end try
										
						end if
		
						k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
					loop

	
	//--- se torno da elenco Acconti Contratti 
			case  "d_contratti_l_acc_dafatt"
	
					k_ind_selected = kdw_source.getselectedrow( 0 )
	
					do while k_ind_selected > 0 
						
						kst_tab_arfa.tipo_riga = ""
						kst_tab_arfa.colli_out = 0
						kst_tab_arfa.prezzo_u =  kdw_source.getitemnumber(k_ind_selected, "acconto_imp")	
						kst_tab_arfa.prezzo_t = 0
						kst_tab_arfa.clie_3 = kdw_source.getitemnumber(k_ind_selected, "cod_cli")	
						kst_tab_arfa.cod_pag = kdw_source.getitemnumber(k_ind_selected, "acconto_cod_pag")	
						kst_tab_arfa.contratto = kdw_source.getitemnumber(k_ind_selected, "codice")	
						kst_tab_arfa.id_armo = 0
						kst_tab_arfa.colli = 0
							
		//--- Aggiungi riga nell'elenco righe VARIE Documento										
						try	
							riga_nuova_acconto_in_lista(kst_tab_arfa)		
							
						catch (uo_exception kuo_exception5)
							kuo_exception5.messaggio_utente( )
						end try
										
						k_ind_selected = kdw_source.getselectedrow( (k_ind_selected) )
					loop

			
		end choose
		
					
//--- posiziona su ultima riga
		if tab_1.tabpage_4.dw_4.rowcount() > 0 then
			tab_1.tabpage_4.dw_4.selectrow( 0, false)
			tab_1.tabpage_4.dw_4.selectrow( tab_1.tabpage_4.dw_4.rowcount() , true)
			tab_1.tabpage_4.dw_4.scrolltorow( tab_1.tabpage_4.dw_4.rowcount() )
		end if						
		tab_1.tabpage_4.dw_4.setfocus()
	end if

	attiva_tasti()

	setpointer(kkg.pointer_default)
end if





end subroutine

private subroutine call_elenco_note ();//
//--- Fa l'elenco delle NOTE fatture precedenti
//
pointer kp_oldpointer  // Declares a pointer variable

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

kp_oldpointer = SetPointer(HourGlass!)


	kist_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
	if kist_tab_arfa.clie_3 > 0 then
		kiuf_fatt.elenco_note( kist_tab_arfa )
	end if
						
SetPointer(kp_oldpointer)

	


end subroutine

private subroutine elenco_lotti_no_dose ();//
//--- Fa l'elenco delle Entrate di "Merce generica" da non trattare ovvero con Dose=0 e senza Cliente
//
long k_ind, k_riga
date k_data_competenza_dal
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
st_open_w kst_open_w 
//kuf_clienti kuf1_clienti
pointer kp_oldpointer  // Declares a pointer variable


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


	kp_oldpointer = SetPointer(HourGlass!)

	if not isvalid(kids_elenco_lotti) then kids_elenco_lotti = create datastore

	kids_elenco_lotti.reset( )

	k_data_competenza_dal = relativedate(tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal"), -365)
	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if isnull(kst_tab_arfa.clie_3) then
		kst_tab_arfa.clie_3=0
	end if
	kids_elenco_lotti.dataobject = kiuf_fatt.kki_dw_righe_no_fatt_no_dose 
	kids_elenco_lotti.settransobject ( sqlca )
	kids_elenco_lotti.retrieve(kst_tab_arfa.clie_3, k_data_competenza_dal) 
	kst_open_w.key1 = "Ricerca Riferimenti con Merce generica senza dose, dal: " + string(k_data_competenza_dal)


	if kids_elenco_lotti.rowcount() > 0 then

//-- screma elenco da righe già in fattura
		for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
			kst_tab_arfa.id_armo = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "id_armo")
			if kst_tab_arfa.id_armo > 0 then 
				k_riga = kids_elenco_lotti.find( "id_armo = " + string( kst_tab_arfa.id_armo) + " " , 1, kids_elenco_lotti.rowcount( ) )
				if k_riga > 0 then
					 kids_elenco_lotti.deleterow( k_riga )
				end if
			end if
		next

	
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma =kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kids_elenco_lotti.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key6 = " "    //--- nome del campo cliccato
		kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
		kst_open_w.key12_any = kids_elenco_lotti
		kst_open_w.flag_where = " "
		kiuf_menu_window.open_w_tabelle(kst_open_w)
	
		tab_1.selectedtab = 4
	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


	SetPointer(kp_oldpointer)





end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "
kst_tab_clienti.p_iva = " "
kst_tab_clienti.cf = " "
kst_tab_clienti.id_nazione_1 = " "
kst_tab_clienti.cadenza_fattura = " "
kst_tab_clienti.loc_1 = " "
kst_tab_clienti.prov_1 = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
kst_tab_clienti.kst_tab_ind_comm.prov_c  = " "
kst_tab_clienti.kst_tab_ind_comm.id_nazione_c  = ""

kst_tab_clienti.kst_tab_clienti_fatt.fattura_da  = " "
kst_tab_clienti.iva  = 0
kst_tab_clienti.kst_tab_clienti_fatt.note_1 = " "
kst_tab_clienti.kst_tab_clienti_fatt.note_2 = " "
kst_tab_clienti.kst_tab_clienti_fatt.modo_stampa = ""
kst_tab_clienti.kst_tab_clienti_fatt.modo_email = ""
kst_tab_clienti.kst_tab_clienti_fatt.email_invio = ""


end subroutine

public subroutine set_dw_clienti_child ();//
int k_rc
string k_cadenza_fattura="", k_x=""
datawindowchild  kdwc_1, kdwc_2

//---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
//-------------------------------------

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
		if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
			if not isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "cadenza_fattura")) then
				k_cadenza_fattura = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cadenza_fattura"))
			end if
		end if

		tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
		kdwc_1.settransobject(sqlca)
		
//--- se e' cambiato il parametro cadenza oppure non avevo letto nulla allora faccio il ripopolamento delle DW
		if ki_cadenza_fattura <> k_cadenza_fattura or kdwc_1.rowcount() = 0 then
			kdwc_1.reset() 
			k_x = "%" + trim(ki_cadenza_fattura) + "%"
			kdwc_1.retrieve(k_x)
			kdwc_1.SetSort("id_cliente A")
			kdwc_1.sort( )
			kdwc_1.insertrow(1)
			
			tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_2)
			kdwc_2.settransobject(sqlca)
			kdwc_2.reset() 
//			kdwc_2.retrieve("%")
			k_rc = kdwc_1.RowsCopy(1, kdwc_1.RowCount(), Primary!, kdwc_2, 1, Primary!)
			k_rc = kdwc_2.SetSort("rag_soc_1 A")
			k_rc = kdwc_2.sort( )
		end if		
		
	end if

//---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
//-------------------------------------

end subroutine

private function string get_norme_bolli (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna descrizione norme sui bolli 
//---
//---  input: st_tab_arfa.num_fatt, data_fatt, tipo_doc
//---  otput: stringa con st_tab_base.fatt_bolli_note
//--- 			lancia EXCEPTION
//---
string k_rc
long k_ctr =0
st_tab_base kst_tab_base
st_esito kst_esito
st_tab_iva kst_tab_iva
kuf_base kuf1_base
uo_exception kuo_exception
kuf_ausiliari kuf1_ausiliari

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_base.fatt_bolli_note = " "

//--- se è fattura
if kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_fattura  or kst_tab_arfa.tipo_doc = kiuf_fatt.kki_tipo_doc_Autofattura then
	
	kuf1_ausiliari = create kuf_ausiliari

//--- calcolo il totale importo x le IVA per cui è previsto l'esposizione delle NORME	
	kst_tab_arfa.prezzo_t=0
	kst_tab_iva.codice=0
	kst_tab_arfa.iva = 0
	for k_ctr= 1 to tab_1.tabpage_4.dw_4.rowcount( )
		kst_tab_arfa.iva = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "iva")
		if kst_tab_arfa.iva > 0 then
			if kst_tab_iva.codice <> kst_tab_arfa.iva then
				kst_tab_iva.codice = kst_tab_arfa.iva
				kuf1_ausiliari.tb_select(kst_tab_iva)
			end if
			if kst_tab_iva.fatt_norme_bolli = kuf1_ausiliari.kki_fatt_norme_bolli_SI then
				if  tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "prezzo_t") > 0 then
					kst_tab_arfa.prezzo_t += tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "prezzo_t")
				end if
			end if
		end if
	next

	
	if kst_tab_arfa.prezzo_t > 0 then 
	
		kuf1_base = create kuf_base
		k_rc = kuf1_base.prendi_dato_base("fatt_bolli_lim_stampa")
		if LeftA(k_rc, 1) = "0" then
			kst_tab_base.fatt_bolli_lim_stampa = double(trim(MidA(k_rc, 2))) 
			if kst_tab_base.fatt_bolli_lim_stampa <= kst_tab_arfa.prezzo_t then
				k_rc = kuf1_base.prendi_dato_base("fatt_bolli_note")
				if LeftA(k_rc, 1) = "0" then
					kst_tab_base.fatt_bolli_note = trim(MidA(k_rc, 2))
				else
					kst_esito.esito =  kkg_esito.db_ko
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Errore durante lettura Archivio Azienda (BASE): " + trim(k_rc) + " id=" + "fatt_bolli_note"
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if
		else
			kst_esito.esito =  kkg_esito.db_ko
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Errore durante lettura Archivio Azienda (BASE): " + trim(k_rc) + " id=" + "fatt_bolli_lim_stampa"
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if
					
		destroy kuf1_base
	end if
	
	destroy kuf1_ausiliari
	
end if
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


return kst_tab_base.fatt_bolli_note 

end function

private function double get_totale_x_iva (integer k_iva);//--
//---  Torna Totale Importo delle righe di questo documento x codice IVA indicato
//---
//---  input: codice IVA
//---  otput: double dell'importo calcolato
//--- 	
//---
string k_rc
long k_ctr =0
st_tab_arfa kst_tab_arfa

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

	
//--- calcolo il totale importo x IVA 	
	kst_tab_arfa.prezzo_t=0
	kst_tab_arfa.iva = 0
	for k_ctr= 1 to tab_1.tabpage_4.dw_4.rowcount( )
		kst_tab_arfa.iva = tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "iva")
		if kst_tab_arfa.iva = k_iva then
			if  tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "prezzo_t") > 0 then
				kst_tab_arfa.prezzo_t += tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, "prezzo_t")
			end if
		end if
	next

return kst_tab_arfa.prezzo_t 

end function

private subroutine run_app_lettera ();//
string k_file="", k_ext=""
kuf_utility kuf1_utility


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
try
	if tab_1.tabpage_1.dw_1.rowcount( ) > 0 then
		k_file = trim(tab_1.tabpage_1.dw_1.getitemstring (1, "file_prodotto"))
		if len(k_file) > 0 then
			
			kuf1_utility = create kuf_utility
			kuf1_utility.u_open_app_file(k_file)
		
		else
			k_file=""
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try	

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

end subroutine

private subroutine u_cliccato_iva_esente ();//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

if messagebox("cambio IVA esente", "Sicuro di voler CAMBIARE lo stato  '"+ trim(tab_1.tabpage_1.dw_1.object.k_iva_esente_t.text)+"' ?", Question!,yesno!, 2) = 2 then
	
	if tab_1.tabpage_1.dw_1.getitemnumber (1, "k_iva_esente") = 1 then 
		tab_1.tabpage_1.dw_1.setitem( 1, "k_iva_esente", 0)
	else
		tab_1.tabpage_1.dw_1.setitem( 1, "k_iva_esente", 1)
	end if
	
end if
end subroutine

private function integer riga_gia_presente (st_tab_arfa kst_tab_arfa);//---
//--- Controllo se riga magazzino presente in questa fattura
//--- inp: kst_tab_arfa.id_armo
//--- out: boolean:   true=presente, false=non trovata
//
int k_return = 0

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

	if kst_tab_arfa.id_armo > 0 then

		choose case true

			case kst_tab_arfa.id_armo_prezzo > 0 
				k_return =  tab_1.tabpage_4.dw_4.find( "id_armo_prezzo = " + string(kst_tab_arfa.id_armo_prezzo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
			case kst_tab_arfa.id_arsp > 0
				k_return = tab_1.tabpage_4.dw_4.find( "id_arsp = " + string(kst_tab_arfa.id_arsp) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
			case kst_tab_arfa.id_armo > 0
				k_return = tab_1.tabpage_4.dw_4.find( "id_armo = " + string(kst_tab_arfa.id_armo) , 1, tab_1.tabpage_4.dw_4.rowcount() ) 
				
		end choose		
		
	end if

		
return k_return 	


end function

public subroutine u_allarme_cliente (readonly st_tab_clienti ast_tab_clienti) throws uo_exception;//
boolean k_return = false
st_memo_allarme kst_memo_allarme

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try
	
//--- Gestione di Allert per il cliente 	
	if ast_tab_clienti.codice > 0 then
		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_fattura
		kst_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente = ast_tab_clienti.codice
		kst_memo_allarme.descr = "Avviso rilevato sul Cliente " + string(ast_tab_clienti.codice) + ", fattura: " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_fatt"))
		if kguf_memo_allarme.set_allarme_cliente(kst_memo_allarme) then
			kguf_memo_allarme.u_attiva_memo_allarme_on()
		end if
	else
		kguf_memo_allarme.inizializza()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

	
end try


end subroutine

public subroutine u_allarme_lotto (st_tab_meca ast_tab_meca) throws uo_exception;//
boolean k_return = false
st_memo_allarme kst_memo_allarme
kuf_armo_inout kuf1_armo_inout

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try
	
//--- Gestione di Allert per Lotto (id) 	
	if ast_tab_meca.id > 0 then
		kiuf_armo.get_num_int(ast_tab_meca)
		kst_memo_allarme.allarme = kguf_memo_allarme.kki_memo_allarme_fattura
		kst_memo_allarme.st_memo.st_tab_meca_memo.id_meca = ast_tab_meca.id
		kst_memo_allarme.descr = "Avviso rilevato sul Lotto " + string(ast_tab_meca.num_int) + " " + string(ast_tab_meca.data_int, "dd/mm/yy") + " id "+ string(ast_tab_meca.id) + ", fattura: " + string(tab_1.tabpage_1.dw_1.getitemnumber(1, "num_fatt"))
		if kguf_memo_allarme.set_allarme_lotto(kst_memo_allarme) then
			kguf_memo_allarme.u_attiva_memo_allarme_on()
		end if
	else
		kguf_memo_allarme.inizializza()
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

end try



end subroutine

private subroutine get_cliente_ddt_lotto () throws uo_exception;//
//--- Piglia il codice cliente da DDT (bolla) o da LOTTO a seconda di quello indicato nel form
//
long k_riga
kuf_sped kuf1_sped 
st_tab_sped kst_tab_sped 
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_clienti kst_tab_clienti
st_esito kst_esito

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


kst_tab_clienti.codice = 0

k_riga = tab_1.tabpage_1.dw_1.getrow( )
if k_riga > 0 then
	if tab_1.tabpage_1.dw_1.object.fattura_da[k_riga] = kiuf_clienti.kki_fattura_da_bolla then
		
		kst_tab_sped.num_bolla_out = dw_anno_numero.object.numero[1]
		if kst_tab_sped.num_bolla_out > 0 then
			kst_tab_sped.data_bolla_out = date (  dw_anno_numero.object.anno[1] , 01, 01)
			
			kuf1_sped = create kuf_sped
			kst_esito = kuf1_sped.get_clie(kst_tab_sped )
			destroy kuf1_sped
			if kst_esito.esito = kkg_esito.db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			else
				
				if kst_tab_sped.clie_3 > 0 then
					kst_tab_clienti.codice = kst_tab_sped.clie_3 
				end if
				
			end if
			
		end if		
	else
		if tab_1.tabpage_1.dw_1.object.fattura_da[k_riga] = kiuf_clienti.kki_fattura_da_certif then

			kst_tab_meca.num_int = dw_anno_numero.object.numero[1]
			if kst_tab_meca.num_int > 0 then
				kst_tab_meca.data_int = date (  dw_anno_numero.object.anno[1] , 01, 01)
			
				try 
					kst_tab_armo.num_int = kst_tab_meca.num_int
					kst_tab_armo.data_int = kst_tab_meca.data_int
					kst_esito = kiuf_armo.get_id_meca( kst_tab_armo )   // pesca prima il ID_MECA
					
					if kst_esito.esito = kkg_esito.db_ko then
						kguo_exception.inizializza( )
						kguo_exception.set_esito( kst_esito )
						throw kguo_exception
					else
						kst_tab_meca.id = kst_tab_armo.id_meca
						
						kiuf_armo.get_clie( kst_tab_meca ) // ...poi pesca il cliente con ID_MECA
						if kst_tab_meca.clie_3 > 0 then
							kst_tab_clienti.codice = kst_tab_meca.clie_3 
						end if
					end if

				catch (uo_exception kuo1_exception)
					throw kuo1_exception

				end try
					
			
			end if		
			
			
		end if	
	end if
end if

//--- Legge e imposta il cliente nel form
if kst_tab_clienti.codice > 0 then

	get_dati_cliente(kst_tab_clienti)
	put_video_cliente(kst_tab_clienti)

end if


//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------



		
end subroutine

public function st_esito u_aggiorna_base (st_tab_arfa ast_tab_arfa);//---
//--- Aggiorna Numero e Data FATTURA su archivio BASE
//---
st_esito kst_esito
st_tab_base kst_tab_base
kuf_base kuf1_base

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
			
	kuf1_base = create kuf_base

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
			
//--- aggiorna nel BASE il num. se sono in inserimento e + grande di quello presente
	kst_tab_base.st_tab_g_0.esegui_commit = "S" 
	kst_tab_base.key = "num_fatt"
	kst_tab_base.num_fatt = integer(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
	kst_tab_base.key = "data_fatt"
	kst_tab_base.data_fatt = date(mid(kuf1_base.prendi_dato_base( kst_tab_base.key ),2 ))
	if ast_tab_arfa.num_fatt > kst_tab_base.num_fatt and year(ast_tab_arfa.data_fatt) = year(kst_tab_base.data_fatt) then
		kst_tab_base.key = "num_fatt"
		kst_tab_base.key1 = string(ast_tab_arfa.num_fatt )
		kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
		if kst_esito.esito = kkg_esito.ok then 
			kst_tab_base.key = "data_fatt"
			kst_tab_base.key1 = string(ast_tab_arfa.data_fatt )
			kst_esito = kuf1_base.metti_dato_base( kst_tab_base )
		end if
	end if

return kst_esito
end function

public subroutine u_set_d_arfa_v_dwchild ();long k_rc
datawindowchild kdwc_1
st_tab_arfa kst_tab_arfa
date k_data

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------


//--- attiva child x il campo contratto
	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
	kst_tab_arfa.data_fatt = tab_1.tabpage_1.dw_1.getitemdate( 1, "data_fatt")
	k_data = relativedate(kst_tab_arfa.data_fatt, -60)
	dw_riga.getchild( "contratto", kdwc_1)
	kdwc_1.settransobject(sqlca)
	kdwc_1.reset() 
	if kdwc_1.rowcount() = 0 then
		k_rc = kdwc_1.retrieve(kst_tab_arfa.clie_3, k_data)
		kdwc_1.insertrow(1)
	end if


end subroutine

private function long riga_nuova_in_lista_1 (ref st_tab_arfa ast_tab_arfa, ref st_tab_meca ast_tab_meca, st_tab_armo ast_tab_armo) throws uo_exception;//---
//--- aggiunge una riga nella fattura
//--- Inp: id_armo, colli  + eventuale num_bolla_out+data_bolla_out+id_arsp, id_arfa_se_nc
//--- out: primo numero di riga caricato
//---
long k_riga_nuova=0, k_righe, k_ind=0, k_return=0, k_riga_presente=0
st_tab_arfa kst_tab_arfa[]
st_tab_armo_prezzi kst_tab_armo_prezzi[]
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
datastore kds_armo_prezzi_x_fatt
kuf_listino_voci kuf1_listino_voci


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
try

	
//--- Verifica se siamo in presenza di più prezzi x riga
		kst_tab_armo_prezzi[1].id_armo = ast_tab_armo.id_armo
		if kiuf_armo_prezzi.if_esiste_x_id_armo(kst_tab_armo_prezzi[1]) then
			
//--- recupera i singoli prezzi da mostrare			
			kds_armo_prezzi_x_fatt = create datastore
			kds_armo_prezzi_x_fatt.dataobject = "ds_armo_prezzi_x_fatt"
			kds_armo_prezzi_x_fatt.settransobject(kguo_sqlca_db_magazzino )
			k_righe = kds_armo_prezzi_x_fatt.retrieve(ast_tab_armo.id_armo)
			
//--- riverso i dati trovati in ARMO_PREZZI dentro alla tab_arfa			
			for k_ind = 1 to k_righe
				
				kst_tab_arfa[k_ind] = ast_tab_arfa
				kst_tab_arfa[k_ind].id_armo = ast_tab_armo.id_armo 
				kst_tab_arfa[k_ind].id_armo_prezzo = kds_armo_prezzi_x_fatt.getitemnumber(k_ind, "id_armo_prezzo")
				kst_tab_arfa[k_ind].prezzo_u = kds_armo_prezzi_x_fatt.getitemnumber(k_ind, "prezzo")
				kst_tab_arfa[k_ind].colli = kds_armo_prezzi_x_fatt.getitemnumber(k_ind, "item_dafatt")
				kst_tab_arfa[k_ind].tipo_l = kds_armo_prezzi_x_fatt.getitemstring(k_ind, "tipo_listino")
				kst_tab_arfa[k_ind].des = kds_armo_prezzi_x_fatt.getitemstring(k_ind, "listino_voci_descr_xctr")

			end for
			
		else	
//--- prezzi da Listino (modo tradizionale)			
			k_righe = 1
			kst_tab_arfa[1] = ast_tab_arfa
			kst_tab_arfa[1].id_armo_prezzo = 0
			kst_tab_arfa[1].id_armo = ast_tab_armo.id_armo 
			
		end if

//--- Get degli altri dati x la  tab_arfa			
		for k_ind = 1 to k_righe
		
//--- piglia il prezzo corretto
			if kst_tab_arfa[k_ind].prezzo_u = 0 or isnull(kst_tab_arfa[k_ind].prezzo_u) then
				kiuf_fatt.get_prezzo( kst_tab_arfa[k_ind] )
			end if
			
//--- Colli da mettere in output eventualmente uguali al campo colli da scaricare
			if kst_tab_arfa[k_ind].colli_out = 0 or isnull(kst_tab_arfa[k_ind].colli_out) then
				kst_tab_arfa[k_ind].colli_out = kst_tab_arfa[k_ind].colli
			end if
			
//--- Calcola il prezzo totale di riga			
			if kst_tab_arfa[k_ind].prezzo_t = 0 or isnull(kst_tab_arfa[k_ind].prezzo_t) then
				kiuf_fatt.get_prezzo_t ( kst_tab_arfa[k_ind] )
			end if

//--- Check se riga già presente in elenco
			k_riga_presente = riga_gia_presente ( kst_tab_arfa[k_ind]) 
			if k_riga_presente > 0 then
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Riga già caricata nel Documento! Alla riga nr. = " + string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga_presente, "nriga"))+")")
				kguo_exception.messaggio_utente( "Fai Attenzione", "")
			else			
			
//--- NUOVA RIGA			
				k_riga_nuova = tab_1.tabpage_4.dw_4.insertrow(0)
				if k_ind = 1 then k_return = k_riga_nuova  // imposta il valore di ritorno
			
				ki_progressivo_riga ++
				tab_1.tabpage_4.dw_4.setitem(k_riga_nuova, "k_progressivo", ki_progressivo_riga)

			
//--- inserisce la riga in elenco	
				riga_aggiorna_in_lista (k_riga_nuova, kst_tab_arfa[k_ind], ast_tab_meca, ast_tab_armo)  
			
			end if
		end for


catch(uo_exception kuo_exception)
	throw kuo_exception


end try

////---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------
//		
	
return k_return

	
end function

public subroutine riga_aggiorna_in_lista_art (long k_riga, st_tab_arfa kst_tab_arfa) throws uo_exception;//
//--- Display della parte di Riga con Prezzo, IVA ecc... in Elenco
//
kuf_contratti kuf1_contratti
st_tab_contratti kst_tab_contratti
st_tab_iva kst_tab_iva
st_esito kst_esito


////---- scrive Trace su LOG---------
//PopulateError(k_riga, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

	tab_1.tabpage_4.dw_4.setitem(k_riga, "art"  ,kst_tab_arfa.art )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "des"  ,kst_tab_arfa.des )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli"  ,kst_tab_arfa.colli )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "colli_out"  ,kst_tab_arfa.colli_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prezzo_u"  ,kst_tab_arfa.prezzo_u )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "tipo_l"  ,kst_tab_arfa.tipo_l )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "prezzo_t"  ,kst_tab_arfa.prezzo_t )
	if kst_tab_arfa.contratto > 0 then
		tab_1.tabpage_4.dw_4.setitem(k_riga, "contratto"  ,kst_tab_arfa.contratto )
	end if

//--- piglia l'aliquota IVA prioritaria è quella in tesata che di solito è la ESENZIONE
	if tab_1.tabpage_1.dw_1.getitemnumber(1, "k_iva_esente") = 1 then
		kst_tab_arfa.iva = tab_1.tabpage_1.dw_1.getitemnumber(1, "iva")
	end if
	if kst_tab_arfa.iva > 0 then
		kst_tab_iva.codice = kst_tab_arfa.iva
		kiuf_ausiliari.tb_select( kst_tab_iva )
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
		if isnull(kst_tab_iva.aliq) then kst_tab_iva.aliq = 0
	else
		kst_tab_iva.aliq = 0
	end if
	tab_1.tabpage_4.dw_4.setitem(k_riga, "iva"  ,kst_tab_arfa.iva )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "iva_aliq" , kst_tab_iva.aliq )

//--- get del codice CO 	
	kst_tab_contratti.mc_co = ""
	if kst_tab_arfa.contratto > 0 then
		kuf1_contratti= create kuf_contratti
		kst_tab_contratti.codice = kst_tab_arfa.contratto
		kst_esito = kuf1_contratti.get_co_cf_pt(kst_tab_contratti)
		if kst_esito.esito <> kkg_esito.ok then
			kst_tab_contratti.mc_co = ""
			if kst_esito.esito = kkg_esito.db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
		tab_1.tabpage_4.dw_4.setitem(k_riga, "mc_co"  ,kst_tab_contratti.mc_co )

//--- get del flag ACCONTO
		kst_tab_contratti.flg_acconto = kuf1_contratti.get_flg_acconto(kst_tab_contratti)
		tab_1.tabpage_4.dw_4.setitem(k_riga, "flg_acconto"  ,kst_tab_contratti.flg_acconto )
	end if

end subroutine

private subroutine riga_aggiorna_in_lista (long k_riga, st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception;//
//--- Display della Riga in Elenco
//
st_esito kst_esito
st_tab_arsp kst_tab_arsp


//---- scrive Trace su LOG---------
PopulateError(kst_tab_meca.num_int, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try

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
	
//--- se numero bolla non indicato provo a reperirlo	
	if (kst_tab_arfa.num_bolla_out = 0 or isnull(kst_tab_arfa.num_bolla_out ) ) and  kst_tab_arfa.id_armo > 0 then 
		kst_tab_arsp.id_armo = kst_tab_arfa.id_armo
		kst_esito = kiuf_sped.get_id_riga_da_id_armo( kst_tab_arsp )
		if kst_esito.esito = kkg_esito.ok then
			kst_esito = kiuf_sped.get_numero_da_id( kst_tab_arsp )
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_arfa.num_bolla_out = kst_tab_arsp.num_bolla_out
				kst_tab_arfa.data_bolla_out = kst_tab_arsp.data_bolla_out
			end if
		end if
	end if
	
	tab_1.tabpage_4.dw_4.setitem(k_riga, "num_bolla_out"  ,kst_tab_arfa.num_bolla_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "data_bolla_out"  ,kst_tab_arfa.data_bolla_out )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "campione"  ,kst_tab_armo.campione )

	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_fattura"  ,kst_tab_arfa.id_fattura )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arsp"  ,kst_tab_arfa.id_arsp )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arfa"  ,kst_tab_arfa.id_arfa )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_meca"  ,kst_tab_armo.id_meca )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_armo"  ,kst_tab_arfa.id_armo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_armo_prezzo"  ,kst_tab_arfa.id_armo_prezzo )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_arfa_se_nc"  ,kst_tab_arfa.id_arfa_se_nc )
	tab_1.tabpage_4.dw_4.setitem(k_riga, "alt_2"  ,kst_tab_armo.alt_2 )

	tab_1.tabpage_4.dw_4.setitem(k_riga, "id_listino"  ,kst_tab_arfa.id_listino )


//--- espone i dati circa l'articolo, prezzo, iva ecc... 	
	riga_aggiorna_in_lista_art(k_riga, kst_tab_arfa)
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


	
end subroutine

private function long riga_modifica_in_lista (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//--- aggiunge una riga 
//
long k_riga=0

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
try
	
	k_riga = tab_1.tabpage_4.dw_4.find( "k_progressivo = " +  string(dw_riga.getitemnumber(dw_riga.getrow(), "k_progressivo")), 1,  tab_1.tabpage_4.dw_4.rowcount()) 
	
	if k_riga > 0 then
	
		kiuf_fatt.if_isnull_testa(kst_tab_arfa)
	
	//--- espone i dati circa l'articolo, prezzo, iva ecc... 	
		riga_aggiorna_in_lista_art(k_riga, kst_tab_arfa)
	
	end if

catch (uo_exception kuo_exception)		
	throw kuo_exception
	
end try

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	
return k_riga

	
end function

private function long riga_aggiungi_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca, st_tab_armo kst_tab_armo) throws uo_exception;//
//--- aggiunge una riga 
//
long k_riga=0

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try

	k_riga = tab_1.tabpage_4.dw_4.insertrow(0)
	
	if k_riga > 0 then
	
		ki_progressivo_riga ++
		tab_1.tabpage_4.dw_4.setitem(k_riga, "k_progressivo", ki_progressivo_riga)
	
		kiuf_fatt.if_isnull_testa(kst_tab_arfa)
	
		riga_aggiorna_in_lista (k_riga, kst_tab_arfa, kst_tab_meca, kst_tab_armo)  
	
	end if

catch(uo_exception kuo_exception)
	throw kuo_exception


end try

	
	
return k_riga

	
end function

private function long riga_nuova_in_lista (st_tab_arfa kst_tab_arfa, st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- aggiunge una riga nella fattura
//--- Inp: id_armo, colli  + eventuale num_bolla_out+data_bolla_out+id_arsp, id_arfa_se_nc
//--- out: primo numero di riga caricata
//---
long k_riga=0
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_tab_listino kst_tab_listino
st_esito kst_esito


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try
	
	kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")

//--- legge riga Lotto	
	kst_tab_armo.id_armo = kst_tab_arfa.id_armo
	if kst_tab_armo.id_armo  > 0 then
		kst_esito = kiuf_armo.leggi_riga("*", kst_tab_armo)
		if kst_esito.esito = kkg_esito.ok then
			kst_tab_arfa.art =  kst_tab_armo.art
			kst_tab_arfa.id_listino =  kst_tab_armo.id_listino
			kst_tab_meca.num_int = kst_tab_armo.num_int
			kst_tab_meca.data_int = kst_tab_armo.data_int
//--- controllo se c'e' un Lotto con Allarme MEMO			
			kst_tab_meca.id = kst_tab_armo.id_meca
			u_allarme_lotto(kst_tab_meca)
		else
			if kst_esito.esito = kkg_esito.db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if
	
//--- se  ID listino non impostato lo va a pigliare 
	if kst_tab_arfa.id_listino = 0 or isnull(kst_tab_arfa.id_listino) then
		kst_tab_armo.id_armo = kst_tab_arfa.id_armo
		kst_tab_meca.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
		kiuf_armo.get_id_listino(kst_tab_armo)
		kst_tab_arfa.id_listino = kst_tab_armo.id_listino
		if kst_tab_arfa.id_listino = 0 or isnull(kst_tab_arfa.id_listino) then   // se è ancora a ZERO vado sul LISTINO - roba OBSOLETA spero di rimuoverla
			kiuf_armo.get_id_listino(kst_tab_armo, kst_tab_meca)
			kst_tab_arfa.id_listino = kst_tab_armo.id_listino
		end if
	end if

//---- legge il tipo listino
	if kst_tab_arfa.id_listino > 0 then
		kst_tab_listino.id = kst_tab_arfa.id_listino
		kst_esito = kiuf_listino.get_tipo_listino(kst_tab_listino)
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
		kst_tab_arfa.tipo_l = kst_tab_listino.tipo

//---- legge Articolo da Listino se non passato
		if trim(kst_tab_arfa.art) > " " then
		else
			kst_tab_arfa.art = kiuf_listino.get_cod_art(kst_tab_listino)
		end if
		
//---- legge il Cod Contratto
		kst_tab_arfa.contratto = kiuf_listino.get_contratto(kst_tab_listino)
		
	else
		kst_tab_arfa.tipo_l = kiuf_listino.kki_tipo_prezzo_a_collo   // Tipo listino di default
	end if

	if len(trim(kst_tab_arfa.tipo_riga)) = 0 then
		kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_maga
	end if

//--- legge dati articolo	
	if len(trim(kst_tab_arfa.art)) > 0 then 
		kst_tab_arfa.des = " "
		kst_tab_arfa.iva = 0
		kst_tab_prodotti.codice = kst_tab_arfa.art
		kst_esito = kiuf_prodotti.select_riga(kst_tab_prodotti )
		if kst_esito.esito = kkg_esito.ok then
			kst_tab_arfa.des = trim(kst_tab_prodotti.des)
			kst_tab_arfa.iva = kst_tab_prodotti.iva
		else
			if kst_esito.esito = kkg_esito.db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if	
	kiuf_fatt.if_isnull_testa(kst_tab_arfa)

//--- inserisce la riga in elenco	
	k_riga = riga_nuova_in_lista_1 (kst_tab_arfa, kst_tab_meca, kst_tab_armo)  


catch(uo_exception kuo_exception)
	throw kuo_exception


end try

//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

return k_riga

	
end function

private subroutine riga_aggiungi_costo_chiamata (ref st_tab_sped ast_tab_sped) throws uo_exception;//---
//--- aggiunge la riga di COSTO CHIAMATA in fattura
//--- Inp: ast_tab_arfa.num_bolla, data_bolla 
//--- out: 
//---
long k_riga=0
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa
st_esito kst_esito


//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

try

	if ki_art_x_costo_call > " " then  // se in tabella BASE_FATT è stato indicato il ID  del listino associato al costo CHIAMATA VETTORE

		if kiuf_sped.if_sv_call_vettore(ast_tab_sped) then  // se DDT con il flag di Chiamata Attivato...

//--- Se la riga esiste già non l'aggiunge
			k_riga = tab_1.tabpage_4.dw_4.find( "num_bolla_out = " + string(ast_tab_sped.num_bolla_out) + " and art = '" + trim(ki_art_x_costo_call) + "' ", 1, tab_1.tabpage_4.dw_4.rowcount())
			if k_riga > 0 then
			else
				kst_tab_arfa.num_bolla_out = ast_tab_sped.num_bolla_out
				kst_tab_arfa.data_bolla_out = ast_tab_sped.data_bolla_out
				kst_tab_arfa.art = ""
				kst_tab_arfa.id_armo = 0
				kst_tab_meca.id = 0
				kst_tab_arfa.id_listino = kist_tab_base.sv_call_vettore_id_listino
				kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_varia
				kst_tab_arfa.colli = 1
				kst_tab_arfa.colli_out = 1
				
				riga_nuova_in_lista (kst_tab_arfa, kst_tab_meca)  
			end if
		end if		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception


end try


	
end subroutine

private function boolean if_anag_attiva (st_tab_clienti ast_tab_clienti);//
//--- Verifica se l'angrafica è attiva
//
boolean k_return = false


try
	setPointer(kkg.pointer_attesa)

	if ast_tab_clienti.codice > 0 then

		k_return = kiuf_clienti.if_attivo(ast_tab_clienti)
		if not k_return then
			messagebox("Anagrafica non attiva", &
			    "Il cliente "+ string(ast_tab_clienti.codice) + " non è Attivo in Anagrafe, per utilizzarlo prima procedere con il cambio di stato", information!)
		end if
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default)

end try
	
return k_return

end function

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
string k_cadenza_fattura
int k_rc, k_ctr, k_nriga
st_tab_arfa kst_tab_arfa
kuf_utility kuf1_utility 
uo_exception kuo_exception


kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")  
k_scelta = trim(ki_st_open_w.flag_modalita)

if kst_tab_arfa.id_fattura > 0 then

	if tab_1.tabpage_5.dw_5.rowcount() < 1 then

//--- Inabilita campi alla modifica se Vsualizzazione
		kuf1_utility = create kuf_utility 
		if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.modifica &
			  and trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita.inserimento then
		
			kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)
		end if
		destroy kuf1_utility

		if tab_1.tabpage_5.dw_5.retrieve(kst_tab_arfa.id_fattura) <= 0 then
//--- Inserimento: nuova fattura
			inserisci( )
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
				tab_1.tabpage_5.dw_5.setrow(1)
			end if
		end if				

//---- azzera il flag delle modifiche
		tab_1.tabpage_5.dw_5.ResetUpdate ( ) 
	end if

end if

if tab_1.tabpage_5.dw_5.rowcount() < 1 then
	inserisci()
end if
	

tab_1.tabpage_5.dw_5.setfocus()

attiva_tasti()
	

end subroutine

public function boolean u_aggiorna_pa (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//--- Aggorna dati PA (fatt elettronica)
//--- rit: TRUE = rec aggiornato/rimosso
//
boolean k_return = false
st_tab_arfa_pa kst_tab_arfa_pa


try
	
	setpointer(kkg.pointer_attesa)
	
	if tab_1.tabpage_5.dw_5.rowcount( ) > 0 then 
		//--- se ci sono dati aggiorna!
		if trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_id")) > " " &
		   		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_commessa")) > " " &
		    		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cig")) > " " &
		   		 or trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cup")) > " " &
			 	 then 

			kst_tab_arfa_pa.ordineacquisto_id = trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_id")) 
			kst_tab_arfa_pa.ordineacquisto_data = tab_1.tabpage_5.dw_5.getitemdate(1, "ordineacquisto_data")
		   	kst_tab_arfa_pa.ordineacquisto_commessa = trim(tab_1.tabpage_5.dw_5.getitemstring(1, "ordineacquisto_commessa")) 
		    	kst_tab_arfa_pa.codice_cig = trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cig")) 
		   	kst_tab_arfa_pa.codice_cup = trim(tab_1.tabpage_5.dw_5.getitemstring(1, "codice_cup"))
			kst_tab_arfa_pa.id_fattura = tab_1.tabpage_5.dw_5.getitemnumber(1, "id_fattura")

			if kst_tab_arfa_pa.id_fattura > 0 then
				kiuf_fatt.tb_update(kst_tab_arfa_pa)
			else
				kst_tab_arfa_pa.id_fattura = kst_tab_arfa.id_fattura
				kiuf_fatt.tb_insert(kst_tab_arfa_pa)
			end if
			k_return = true
			tab_1.tabpage_5.dw_5.setitem(1, "id_fattura", kst_tab_arfa_pa.id_fattura)
			tab_1.tabpage_5.dw_5.setitem(1, "x_utente", kst_tab_arfa_pa.x_utente) 
			tab_1.tabpage_5.dw_5.setitem(1, "x_datins", kst_tab_arfa_pa.x_datins) 
			tab_1.tabpage_5.dw_5.resetupdate() 
//			else
//				kguo_exception.inizializza( )
//				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_db_ko)
//				kguo_exception.setmessage("Errore durante la registrazione dati della PA per la Fattura Elettronica")
//				throw kguo_exception
//			end if
		else
		//--- se non ci sono dati e ho il rec allora lo rimuovo
			if tab_1.tabpage_5.dw_5.getitemnumber(1, "id_fattura") > 0 then
				kst_tab_arfa_pa.id_fattura = tab_1.tabpage_5.dw_5.getitemnumber(1, "id_fattura")
				kiuf_fatt.tb_delete(kst_tab_arfa_pa)
				k_return = true
			end if
			tab_1.tabpage_5.dw_5.reset() 
		end if
	end if
	
catch (exception kuo_exception)
	throw kuo_exception

finally
	setpointer(kkg.pointer_default)

end try

return k_return
end function

public subroutine u_inizializza (st_tab_arfa ast_tab_arfa);//
st_esito kst_esito 
st_tab_arfa kst_tab_arfa


		kst_tab_arfa.id_fattura = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_fattura")

//--- se trovo una fattura allora rilancio l'INIZIALIZZA
		ast_tab_arfa.id_fattura = 0
		kst_esito = kiuf_fatt.get_id(ast_tab_arfa)
		if ast_tab_arfa.id_fattura > 0 then
			tab_1.tabpage_1.dw_1.reset()
			tab_1.tabpage_4.dw_4.reset()
			ki_st_open_w.key1 = string(ast_tab_arfa.id_fattura)
			tab_1.tabpage_4.dw_4.SetItemStatus( 1, 0, Primary!, NotModified!)
			ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
			tab_1.selecttab(1)  // parte INIZIALIZZA()
		end if
		

end subroutine

private subroutine elenco_acconti_non_fatt ();//
//--- Fa l'elenco ACCONTI di Contratto non fatturati (screma quelle già presenti in fattura)
//
long k_ind, k_riga
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti
st_open_w kst_open_w 
pointer kp_oldpointer  // Declares a pointer variable




	kst_tab_contratti.cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "id_cliente")
	if (kst_tab_contratti.cod_cli) > 0 then
		kst_open_w.key1 = "Elenco CO con Acconto da fatturare a: " + string(kst_tab_contratti.cod_cli)
	else
		kst_tab_contratti.cod_cli = 0
		kst_open_w.key1 = "Elenco CO con Acconto da fatturare"
	end if
	
	SetPointer(kkg.pointer_attesa)

	if not isvalid(kids_elenco_acconti) then kids_elenco_acconti = create datastore

	kids_elenco_acconti.reset( )
	kst_tab_contratti.data = relativedate(tab_1.tabpage_1.dw_1.getitemdate(tab_1.tabpage_1.dw_1.getrow(), "k_competenza_dal"), -1)

	kids_elenco_acconti.dataobject = "d_contratti_l_acc_dafatt"
	kids_elenco_acconti.settransobject ( sqlca )
	k_riga = kids_elenco_acconti.retrieve(kst_tab_contratti.cod_cli, kst_tab_contratti.data) 

	if kids_elenco_acconti.rowcount() > 0 then

//-- screma elenco da righe già in fattura
		for k_ind = 1 to tab_1.tabpage_4.dw_4.rowcount( ) 
			if tab_1.tabpage_4.dw_4.getitemstatus(k_ind, 0, primary!) = New! then
				kst_tab_contratti.codice = tab_1.tabpage_4.dw_4.getitemnumber( k_ind, "contratto")
				if kst_tab_contratti.codice > 0 then 
					k_riga = kids_elenco_acconti.find( "codice = " + string( kst_tab_contratti.codice) + " ", &
																				 1, kids_elenco_acconti.rowcount( ) )
					if k_riga > 0 then
						kids_elenco_acconti.deleterow( k_riga )
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
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kids_elenco_acconti.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(kiw_this_window.title)   //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key6 = " "    //--- nome del campo cliccato
		kst_open_w.key7 = "N"    //--- dopo la scelta NON chiudere la Window di elenco
		kst_open_w.key12_any = kids_elenco_acconti
		kst_open_w.flag_where = " "
		kiuf_menu_window.open_w_tabelle(kst_open_w)
	
		tab_1.selectedtab = 4
	else
		
		messagebox("Elenco Dati", "Nessun valore disponibile. ")
		
		
	end if

	SetPointer(kp_oldpointer)



end subroutine

private function long riga_nuova_acconto_in_lista (ref st_tab_arfa ast_tab_arfa) throws uo_exception;//---
//--- aggiunge una riga VARIA in fattura
//--- Inp: arfa.contratto, arfa.prezzo_u, arfa.colli, arfa.clie_3, arfa.cod_pag
//--- out: primo numero di riga caricato
//---
long k_riga_nuova=0, k_righe, k_ind=0, k_return=0, k_riga_presente=0
st_tab_arfa kst_tab_arfa[]
st_tab_listino kst_tab_listino
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
st_tab_prodotti kst_tab_prodotti
 

////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------
try
	
//--- Testata
		if tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente") > 0 then
		else
			kst_tab_clienti.codice = ast_tab_arfa.clie_3
			get_dati_cliente(kst_tab_clienti)
			if ast_tab_arfa.cod_pag > 0 then
				kst_tab_clienti.cod_pag  = ast_tab_arfa.cod_pag
			end if
			put_video_cliente(kst_tab_clienti)
		end if


//--- RIGA 	

		k_righe = 1
		kst_tab_arfa[1] = ast_tab_arfa
		kst_tab_arfa[1].id_armo_prezzo = 0
		kst_tab_arfa[1].id_armo = 0
			
//--- Get degli altri dati x la  tab_arfa			
		for k_ind = 1 to k_righe

			kst_tab_listino.contratto = ast_tab_arfa.contratto
			
//--- legge dati articolo	
			kst_tab_arfa[k_ind].art = kiuf_listino.get_cod_art_x_contratto(kst_tab_listino)
			if trim(kst_tab_arfa[k_ind].art) > " " then 
				kst_tab_arfa[k_ind].des = " "
				kst_tab_arfa[k_ind].iva = 0
				kst_tab_prodotti.codice = kst_tab_arfa[k_ind].art
				kst_esito = kiuf_prodotti.select_riga(kst_tab_prodotti )
				if kst_esito.esito = kkg_esito.ok then
					kst_tab_arfa[k_ind].des = trim(kst_tab_prodotti.des)
					kst_tab_arfa[k_ind].iva = kst_tab_prodotti.iva
				else
					if kst_esito.esito = kkg_esito.db_ko then
						kguo_exception.inizializza( )
						kguo_exception.set_esito( kst_esito )
						throw kguo_exception
					end if
				end if
			end if	

//--- Calcola prezzo tot
			if isnull(kst_tab_arfa[k_ind].prezzo_u) then
				kst_tab_arfa[k_ind].prezzo_u = 0
			end if
			if kst_tab_arfa[k_ind].colli > 0 then
				kst_tab_arfa[k_ind].prezzo_t = kst_tab_arfa[k_ind].prezzo_u * kst_tab_arfa[k_ind].colli
			else
				kst_tab_arfa[k_ind].prezzo_t = kst_tab_arfa[k_ind].prezzo_u
				kst_tab_arfa[k_ind].colli = 0
			end if
							
//--- Colli da mettere in output eventualmente uguali al campo colli da scaricare
			if kst_tab_arfa[k_ind].colli_out = 0 or isnull(kst_tab_arfa[k_ind].colli_out) then
				kst_tab_arfa[k_ind].colli_out = kst_tab_arfa[k_ind].colli
			end if
			
//--- Check se riga già presente in elenco
			k_riga_presente = riga_gia_presente ( kst_tab_arfa[k_ind]) 
			if k_riga_presente > 0 then
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Riga già caricata nel Documento! Alla riga nr. = " + string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga_presente, "nriga"))+")")
				kguo_exception.messaggio_utente( "Fai Attenzione", "")
			else			
			
//--- NUOVA RIGA			
				k_riga_nuova = tab_1.tabpage_4.dw_4.insertrow(0)
				if k_ind = 1 then k_return = k_riga_nuova  // imposta il valore di ritorno
			
				ki_progressivo_riga ++
				tab_1.tabpage_4.dw_4.setitem(k_riga_nuova, "k_progressivo", ki_progressivo_riga)

				kst_tab_arfa[k_ind].tipo_riga = kiuf_fatt.kki_tipo_riga_varia
				kst_tab_meca.id = 0
				
				kiuf_fatt.if_isnull_testa(kst_tab_arfa[k_ind])
				
//--- inserisce la riga in elenco	
				riga_aggiorna_in_lista (k_riga_nuova, kst_tab_arfa[k_ind], kst_tab_meca, kst_tab_armo)  
			
			end if
		end for


catch(uo_exception kuo_exception)
	throw kuo_exception


end try

////---- scrive Trace su LOG---------
//PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------
//		
	
return k_return

	
end function

public subroutine u_set_art_v_dwchild ();long k_rc
datawindowchild kdwc_1
st_tab_arfa kst_tab_arfa

////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------


//--- attiva child x il campo Descrizione Articolo
	kst_tab_arfa.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente")
	kst_tab_arfa.art = dw_riga.getitemstring( 1, "art")
	if trim(kst_tab_arfa.art) > " " then
		dw_riga.getchild( "comm", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.reset() 
		if kdwc_1.rowcount() = 0 then
			k_rc = kdwc_1.retrieve(kst_tab_arfa.clie_3, kst_tab_arfa.art)
			kdwc_1.insertrow(1)
		end if
	end if

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

super::attiva_tasti_0()

tab_1.tabpage_2.enabled = false
tab_1.tabpage_3.enabled = false
tab_1.tabpage_4.enabled = false
tab_1.tabpage_5.enabled = false

//=== Nr righe ne DW lista
if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") > 0 then
		tab_1.tabpage_4.enabled = true
		tab_1.tabpage_5.enabled = true
	end if
	
	choose case ki_tab_1_index_new  //tab_1.selectedtab
		case 1
			cb_aggiorna.enabled = true
		case 4 //righe
			cb_inserisci.enabled = false
			if tab_1.tabpage_4.dw_4.rowcount( ) > 0 then
				cb_modifica.enabled = true
				cb_visualizza.enabled = true
				cb_cancella.enabled = true
			end if
		case 4 // PA
			cb_inserisci.enabled = false
	end choose

else
	
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	
end if

if ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione  or ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_cancella.enabled = false
	cb_modifica.enabled = false
end if

if tab_1.tabpage_4.enabled and tab_1.tabpage_4.dw_4.rowcount() > 0 then
	tab_1.tabpage_4.text = "righe " + string(tab_1.tabpage_4.dw_4.rowcount())
else
	tab_1.tabpage_4.text = "righe "
end if



end subroutine

on w_fatture.create
int iCurrent
call super::create
this.dw_anno_numero=create dw_anno_numero
this.dw_x_copia=create dw_x_copia
this.dw_riga=create dw_riga
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_anno_numero
this.Control[iCurrent+2]=this.dw_x_copia
this.Control[iCurrent+3]=this.dw_riga
end on

on w_fatture.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_anno_numero)
destroy(this.dw_x_copia)
destroy(this.dw_riga)
end on

event close;call super::close;//
if isvalid(kiuf_fatt) then destroy kiuf_fatt
if isvalid(kiuf_armo) then destroy kiuf_armo
if isvalid(kiuf_clienti) then destroy kiuf_clienti
if isvalid(kiuf_sped) then destroy kiuf_sped
if isvalid(kiuf_prodotti) then destroy kiuf_prodotti
if isvalid(kiuf_ausiliari) then destroy kiuf_ausiliari
if isvalid(kiuf_menu_window) then destroy kiuf_menu_window


if isvalid(kids_elenco_input) then destroy kids_elenco_input 
if isvalid(kids_elenco_lotti) then destroy kids_elenco_lotti 
if isvalid(kids_elenco_sped) then destroy kids_elenco_sped 
if isvalid(kids_elenco_fatt) then destroy kids_elenco_fatt 


end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
int k_return
int k_rc
long  k_riga, k_righe
datastore kds_elenco_input_appo


if isvalid(kst_open_w) then

		if isnumber(kst_open_w.key3) then
			if long(kst_open_w.key3) > 0 then 
		
				k_return = 1

				if not isvalid(kds_elenco_input_appo) then kds_elenco_input_appo = create datastore
				kds_elenco_input_appo = kst_open_w.key12_any 
				kids_elenco_input.dataobject = kds_elenco_input_appo.dataobject
				kids_elenco_input.reset()
				if not isvalid(kids_elenco_input) then kids_elenco_input = create datastore
				kds_elenco_input_appo.rowscopy( 1, kds_elenco_input_appo.rowcount( ) , primary!,kids_elenco_input, 1,primary!)
				
//				kids_elenco_input = kst_open_w.key12_any 
				k_riga = long(kst_open_w.key3)

//--- Valorizza l'oggetto DW per passarli all'evento di DROP
				dw_x_copia.dataobject = kids_elenco_input.dataobject
				dw_x_copia.reset( )
				k_righe = kids_elenco_input.rowcount()
				if k_righe > 0 then
				
					k_rc = kids_elenco_input.rowscopy(1, k_righe, Primary!, dw_x_copia, 1, Primary! )
					dw_x_copia.selectrow(0, true)  //--- seleziono tutte le righe tanto devo trattarle tutte
					dragdrop_dw_esterna( dw_x_copia, k_riga )
					
				end if
				
				attiva_tasti()
			end if
		end if
		
end if

return k_return


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_fatture
integer y = 1808
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_fatture
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_fatture
integer y = 1804
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_fatture
integer y = 1640
end type

type st_stampa from w_g_tab_3`st_stampa within w_fatture
integer y = 1732
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
				dw_riga.event u_visualizza()
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
kuf_utility kuf1_utility


//=== Nuovo Rekord
	choose case ki_tab_1_index_new
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
integer x = 55
integer width = 3195
integer height = 1556
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
integer width = 3159
integer height = 1428
string text = "Testata"
string picturename = "Custom081!"
long picturemaskcolor = 32435950
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_enter ( )
integer x = 0
integer y = 28
integer width = 2953
integer height = 1308
string dataobject = "d_arfa_testata"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga, k_return=0
st_tab_clienti kst_tab_clienti
st_tab_arfa kst_tab_arfa
datawindowchild kdwc_1

choose case dwo.name 


	case "num_fatt", "data_fatt"
		this.modify("data_fatt.Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if dwo.name = "num_fatt" then
			kst_tab_arfa.num_fatt = long(data)
			kst_tab_arfa.data_fatt = this.getitemdate( row, "data_fatt")
		else
			kst_tab_arfa.data_fatt = date(data)
			kst_tab_arfa.num_fatt = this.getitemnumber( row, "num_fatt")
		end if
		post u_inizializza(kst_tab_arfa)
		if kst_tab_arfa.data_fatt = kguo_g.get_dataoggi( ) then
		else
			this.modify("data_fatt.Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
		end if


	case "rag_soc_10" 
		tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				if if_anag_attiva(kst_tab_clienti) then
					get_dati_cliente(kst_tab_clienti)
					post put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				if if_anag_attiva(kst_tab_clienti) then
					get_dati_cliente(kst_tab_clienti)
					post put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if

	case "p_iva", "cf" 
		tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild("id_cliente", kdwc_1)
			k_nome = dwo.name + " like '" + trim(data) + "%" +"' " 
			k_riga = kdwc_1.find( k_nome, 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				if if_anag_attiva(kst_tab_clienti) then
					get_dati_cliente(kst_tab_clienti)
					post put_video_cliente(kst_tab_clienti)
				else
					this.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
				end if
			else
				tab_1.tabpage_1.dw_1.object.id_cliente[1] = 0
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if

	case "cod_pag" 
		tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "codice = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.cod_pag =  long(trim(data))
				post put_video_pagam(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", " " )
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			tab_1.tabpage_1.dw_1.setitem(1, "pagam_des", " " )
		end if

	case "id_nazione" 
		tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.BIANCO) + "' ") 
		if len(trim(data)) > 0 then 
			tab_1.tabpage_1.dw_1.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_nazione = '" + trim(data) + "' " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.id_nazione_1 =  trim(data)
				post put_video_nazioni(kst_tab_clienti)
			else
				tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
				tab_1.tabpage_1.dw_1.modify( dwo.name + ".Background.Color = '" + string(KKG_COLORE.ERR_DATO) + "' ") 
			end if
		else
			tab_1.tabpage_1.dw_1.setitem(1, "nazioni_nome", " " )
		end if

	
	case "k_clienti_fattura"
		ki_cadenza_fattura = trim(data) 
//--- popola dw child dw clienti 
		set_dw_clienti_child()

		
end choose 

//this.accepttext()

	
end event

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))
	choose case k_nome
			
//--- msg di attenzione x avere cliccato qua sopra
		case "k_iva_esente"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				u_cliccato_iva_esente()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco indirizzi commerciali
		case "p_img_indi"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_indirizzi_commerciali()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- elenco Note
		case "p_img_note"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_elenco_note()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- pdf
		case  "p_img_lettera_vedi" 
			run_app_lettera()
				
	end choose


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
string text = "righe"
string picturename = "DataWindow5!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
integer x = 50
integer y = 36
integer width = 3054
boolean enabled = true
string dataobject = "d_arfa_l_righe"
end type

event dw_4::ue_drop_out;//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
		dragdrop_dw_esterna( kdw_source, k_droprow )
		
//---- scrive Trace su LOG---------
PopulateError(2, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
return 1

end event

event dw_4::doubleclicked;//
kuf_utility kuf1_utility

if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
	if dwo.name = "nriga" then
//--- Abilita campo NRIGA alla modifica
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_proteggi_dw("2", "nriga", tab_1.tabpage_4.dw_4)
		destroy kuf1_utility
	else
		cb_modifica.event clicked( )
	end if
else
	
	cb_visualizza.event clicked( )	
	
end if
	
	
end event

event dw_4::getfocus;call super::getfocus;//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

end event

event dw_4::clicked;call super::clicked;//
tab_1.tabpage_4.dw_4.setcolumn("num_int")

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer width = 3159
integer height = 1428
string text = "PA"
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 2153
integer height = 1296
boolean enabled = true
string dataobject = "d_arfa_pa"
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_dw_visibile_in_open_window = false
end type

event dw_5::clicked;call super::clicked;//
datawindowchild  kdwc_1
long k_clie_3=0


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)


//--- reset degli elenchi ddw
if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and  ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then

	choose case dwo.name

		case "ordineacquisto_id" &
				,"codice_cig" &
				,"codice_cup" &
				,"ordineacquisto_commessa"
			this.getchild(dwo.name, kdwc_1)
			if kdwc_1.rowcount() > 1 then
				k_clie_3 = kdwc_1.getitemnumber(2, "clie_3")
			end if
			if kdwc_1.rowcount() < 2 or k_clie_3 <> tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente") then
				kdwc_1.settransobject(sqlca)
				kdwc_1.reset() 
				if kdwc_1.rowcount() = 0 then
					kdwc_1.retrieve(tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente"))
					kdwc_1.insertrow(1)
				end if
			end if
	
	end choose
	
end if


//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_default)

end event

event dw_5::itemchanged;call super::itemchanged;//
long k_clie_3=0, k_riga=0
date k_data
datawindowchild kdwc_1


if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and  ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then

	choose case dwo.name

		case "ordineacquisto_id" 
			this.getchild(dwo.name, kdwc_1)
			if kdwc_1.rowcount() > 1 then
				k_clie_3 = kdwc_1.getitemnumber(2, "clie_3")
			end if
			if kdwc_1.rowcount() > 1 and k_clie_3 =  tab_1.tabpage_1.dw_1.getitemnumber( 1, "id_cliente") then
				k_riga = kdwc_1.find("ordineacquisto_id = '" + trim(data) + "' ", 1 ,  kdwc_1.rowcount())
				if k_riga > 0 then
					k_data = kdwc_1.getitemdate(k_riga, "ordineacquisto_data")
					if k_data > kkg.data_zero then
						this.setitem(1, "ordineacquisto_data", k_data)
					end if
				end if
			end if
	
	end choose
	
end if



end event

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

type st_duplica from w_g_tab_3`st_duplica within w_fatture
end type

type dw_anno_numero from datawindow within w_fatture
event u_posiziona ( )
event u_enter pbm_dwnprocessenter
boolean visible = false
integer x = 1545
integer y = 1012
integer width = 1627
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

event u_enter;//
try
	this.visible = false
	this.accepttext()	
	get_cliente_ddt_lotto()


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end event

event buttonclicked;//
if dwo.name = "b_ok" then
	
	this.visible = false
	this.event u_enter()
	
end if
end event

event constructor;//
post event u_posiziona()

end event

type dw_x_copia from uo_d_std_1 within w_fatture
integer x = 123
integer y = 1808
integer width = 338
integer height = 368
integer taborder = 70
boolean bringtotop = true
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type dw_riga from uo_d_std_1 within w_fatture
event u_aggiungi ( )
event u_attiva_riga_magazzino ( )
event u_attiva_riga_varia ( )
event u_modifica ( )
event u_posiziona ( )
event u_visualizza ( )
event u_intemchanged_riga_magazzino ( string k_campo )
event u_intemchanged_riga_varia ( string k_campo )
event u_calcola ( )
event u_calcola_tot_iva ( )
event type double u_get_iva_aliq ( )
integer x = 137
integer y = 1444
integer width = 3218
integer height = 928
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Dettaglio Riga"
string dataobject = "d_arfa_v"
boolean controlmenu = true
boolean hsplitscroll = false
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event u_aggiungi();//======================================================================
//=== 
//======================================================================
//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	this.reset( )
	this.insertrow(0)

	this.ki_flag_modalita = kkg_flag_modalita.inserimento

	this.object.b_aggiungi.visible = true 
	this.object.b_aggiorna.visible = false 

	this.visible = true		

end event

event u_attiva_riga_magazzino();//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------
	this.dataobject = "d_arfa_riga"
	this.settransobject( sqlca )
	this.reset()
//	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
	this.setfocus()

end event

event u_attiva_riga_varia();//
//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

	this.dataobject = "d_arfa_v"
	this.settransobject( sqlca )
	this.reset()
//	this.ki_link_standard_attivi = tab_1.tabpage_1.dw_1.ki_link_standard_attivi 
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
     kuf1_utility.u_proteggi_dw("1", "art", dw_riga)
	destroy kuf1_utility
	
	
	



end event

event u_intemchanged_riga_magazzino(string k_campo);//
long k_riga, k_riga_1
double k_imp_iva, k_imp_tot 
st_tab_iva kst_tab_iva
datawindowchild kdwc_1

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

k_riga = this.getrow()
if k_riga > 0 then

//	kist_tab_arfa.prezzo_t = this.getitemnumber( k_riga, "prezzo_t")
	if k_campo = "prezzo_u" or k_campo  = "iva" or k_campo = "colli" then 
		this.setitem(k_riga, "prezzo_t", 0)
	end if
	
//--- x default imposta colli_out uguali ai colli di scarico 
	if k_campo = "colli" then 
		if not isnull(this.getitemnumber( k_riga, "colli")) then
			this.setitem(k_riga, "colli_out", this.getitemnumber( k_riga, "colli"))
		end if
	end if
				
	this.event u_calcola ()
	
end if

end event

event u_intemchanged_riga_varia(string k_campo);//
long k_riga, k_riga_1
st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
st_tab_listino kst_tab_listino
st_tab_arfa kst_tab_arfa
datawindowchild kdwc_1
kuf_prodotti kuf1_prodotti
kuf_listino kuf1_listino

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

k_riga = this.getrow()
if k_riga > 0 then

	this.object.k_msg.Expression =  "~' ~' "

	kuf1_prodotti = create kuf_prodotti

	this.getchild( "iva", kdwc_1)

	if k_campo = "art" then 
		kst_tab_prodotti.codice = this.getitemstring(k_riga, "art")
		if len(trim(kst_tab_prodotti.codice)) > 0 then 
			kst_esito = kuf1_prodotti.select_riga( kst_tab_prodotti )
			if kst_esito.esito = kkg_esito.ok then
				this.setitem(k_riga, "comm", trim(kst_tab_prodotti.des))

//--- Piglia da Listino il prezzo
				kuf1_listino = create kuf_listino
				kst_tab_listino.cod_art = kst_tab_prodotti.codice
				kst_tab_listino.COD_CLI = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
				kst_esito = kuf1_listino.get_id_listino(kst_tab_listino)
				if kst_esito.esito = kkg_esito.ok then
					try
						kst_tab_arfa.id_listino = kst_tab_listino.id
						kst_tab_arfa.id_armo = 0
						kst_tab_arfa.art = kst_tab_prodotti.codice
						kst_tab_arfa.clie_3 =  tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
						if kst_tab_arfa.id_listino > 0 then
							if kiuf_fatt.get_prezzo ( kst_tab_arfa ) then  //--- PIGLIA il Prezzo Corretto
								this.setitem(k_riga, "prezzo_u", kst_tab_arfa.prezzo_u)
							else
								this.setitem(k_riga, "prezzo_u", 0 )
							end if
						else
							this.object.k_msg.Expression =  "~'Prezzo non trovato, forse Listino non Attivo. Art. "  + trim(kst_tab_listino.cod_art) + " e cliente " + string(kst_tab_listino.COD_CLI) + "~' "
							//messagebox("Listino Prezzi", "Prezzo non trovato in archivio forse Listino non Attivo. Cercato per  articolo " &
							//                                  + trim(kst_tab_listino.cod_art) + " e cliente " + string(kst_tab_listino.COD_CLI))
							this.setitem(k_riga, "prezzo_u", 0 )
						end if
					catch (uo_exception kuo_exception)
						kuo_exception.messaggio_utente()
						
					end try
				end if
				
				destroy kuf1_listino
				
//--- piglia l'aliquota IVA controllo ESENZIONE
				if tab_1.tabpage_1.dw_1.getitemnumber(1, "k_iva_esente") = 1 then
					kst_tab_prodotti.iva = tab_1.tabpage_1.dw_1.getitemnumber(1, "iva")
				end if
				
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
		
		u_set_art_v_dwchild( )  // legge descrizioni precedenti per metterli nel dw child
		
	end if
	if k_campo = "prezzo_u" or k_campo  = "iva" or k_campo = "colli" then 
		this.setitem(k_riga, "prezzo_t", 0)
	end if
				
	this.event u_calcola()
	
	destroy kuf1_prodotti
	
end if

end event

event u_calcola();//
long k_riga, k_riga_1
double k_imp_iva=0, k_imp_tot=0
kuf_listino_voci kuf1_listino_voci

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

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
			if  kist_tab_arfa.colli > 0 then
				kist_tab_arfa.prezzo_t = kist_tab_arfa.prezzo_u * kist_tab_arfa.colli
			else
				kist_tab_arfa.prezzo_t = kist_tab_arfa.prezzo_u
			end if
		end if

	else

		kist_tab_arfa.tipo_l = this.getitemstring( k_riga, "tipo_l")
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
				kist_tab_arfa.id_armo_prezzo = this.getitemnumber( k_riga, "id_armo_prezzo")
				kist_tab_arfa.tipo_l = this.getitemstring( k_riga, "tipo_l")
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
long k_riga, k_rc
double k_imp_iva=0.00, k_imp_tot=0.00
st_tab_iva kst_tab_iva

//---- scrive Trace su LOG---------
PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
u_write_trace()  
//-------------------------------------

k_riga = this.getrow()

if k_riga > 0 then
	
	kist_tab_arfa.prezzo_t = this.getitemnumber( k_riga, "prezzo_t")
	if isnull(kist_tab_arfa.prezzo_t) then kist_tab_arfa.prezzo_t = 0

	if kist_tab_arfa.prezzo_t <> 0 and not isnull(kist_tab_arfa.prezzo_t) then
		
		kst_tab_iva.aliq = event u_get_iva_aliq()  // piglia l'aliquota IVA
		
		k_imp_iva = Round((kist_tab_arfa.prezzo_t * kst_tab_iva.aliq / 100),2)
		k_imp_tot = k_imp_iva + kist_tab_arfa.prezzo_t 
	end if

	k_rc = this.setitem( k_riga, "k_imp_iva", (k_imp_iva))
	k_rc = this.setitem( k_riga, "k_imp_tot", (k_imp_tot))

end if

end event

event type double u_get_iva_aliq();//
long k_riga, k_rc, k_riga_1
st_tab_iva kst_tab_iva
datawindowchild kdwc_1



k_riga = this.getrow()

if k_riga > 0 then
	
	this.getchild("iva", kdwc_1)
	kst_tab_iva.codice = this.getitemnumber( k_riga, "iva")
	if kst_tab_iva.codice > 0 then
		k_riga_1 = kdwc_1.find("codice = "+ string(kst_tab_iva.codice) + " " ,1 ,kdwc_1.RowCount()) 

		if k_riga_1 > 0 then
			kst_tab_iva.aliq = kdwc_1.getitemnumber( k_riga_1, "aliq")
			
		end if
	end if

end if
if isnull(kst_tab_iva.aliq) then kst_tab_iva.aliq = 0

return kst_tab_iva.aliq

end event

event buttonclicked;call super::buttonclicked;//
long k_riga=0
st_tab_arfa kst_tab_arfa
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
//st_tab_iva kst_tab_iva

this.accepttext( )

if dwo.name = "b_aggiungi" or dwo.name = "b_aggiorna" then

	tab_1.selectedtab = 4
	this.setfocus( )
	
	kiuf_armo.if_isnull_meca( kst_tab_meca )
	kiuf_armo.if_isnull_armo( kst_tab_armo )

	k_riga = this.getrow( )
	if k_riga > 0 then
		kst_tab_arfa.art = this.getitemstring(k_riga, "art")
		kst_tab_arfa.iva = this.getitemnumber(k_riga, "iva")
		kst_tab_arfa.prezzo_u = this.getitemnumber(k_riga, "prezzo_u")
		kst_tab_arfa.prezzo_t = this.getitemnumber(k_riga, "prezzo_t")
		kst_tab_arfa.tipo_riga = this.getitemstring(k_riga, "tipo_riga")
		
//		kst_tab_iva.aliq = event u_get_iva_aliq()  // piglia l'aliquota IVA
		
		if kst_tab_arfa.tipo_riga = kiuf_fatt.kki_tipo_riga_maga then
			kst_tab_arfa.colli = this.getitemnumber(k_riga, "colli")
			kst_tab_arfa.colli_out = this.getitemnumber( k_riga, "colli_out" )
			kst_tab_arfa.tipo_l = this.getitemstring( k_riga, "tipo_l" )
			kst_tab_arfa.id_armo = this.getitemnumber( k_riga, "id_armo")
			kst_tab_arfa.id_armo_prezzo = this.getitemnumber( k_riga, "id_armo_prezzo")
			kst_tab_arfa.des = this.getitemstring(k_riga, "des")
		else
			kst_tab_arfa.colli_out = this.getitemnumber(k_riga, "colli")   // se riga Varia ho solo colli OUT nessuno scarico da Magazzino
			kst_tab_arfa.comm = this.getitemstring(k_riga, "comm")
			kst_tab_arfa.des = this.getitemstring(k_riga, "comm")
			kst_tab_arfa.contratto = this.getitemnumber(k_riga, "contratto")
		end if

		try
			if dwo.name = "b_aggiungi" then
				
				riga_aggiungi_in_lista(kst_tab_arfa, kst_tab_meca, kst_tab_armo )
//--- dopo l'aggiunta 'pulisco' il campo articolo e il prezzo totale				
				this.setitem(k_riga, "art", "")
//				this.setitem(k_riga, "prezzo_t", 0)
				this.event u_aggiungi()
//				this.visible = false  // dopo la aggiunta Nascondo la DW
				
			else
				riga_modifica_in_lista(kst_tab_arfa) //, kst_tab_iva )
				this.visible = false  // dopo la modifica Nascondo la DW
				
			end if
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
	
		finally
			this.setitem(k_riga, "tipo_riga", kst_tab_arfa.tipo_riga)
			attiva_tasti()
		
		end try
			
	end if
	
//	destroy kuf1_armo
	
end if

if dwo.name = "b_esci" then
	this.visible = false
end if

if dwo.name = "b_calcola" then
	this.setitem( 1, "prezzo_t", 0)
	this.event u_calcola()
end if

end event

event constructor;call super::constructor;//
post event u_posiziona()

end event

event itemchanged;call super::itemchanged;//
long k_riga


k_riga = this.getrow()

if k_riga > 0 then
	if this.getitemstring(k_riga, "tipo_riga")  = kiuf_fatt.kki_tipo_riga_varia then

		this.post event u_intemchanged_riga_varia ( dwo.name )
		
	else

		this.post event u_intemchanged_riga_magazzino ( dwo.name )
		
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

event getfocus;call super::getfocus;////
////---- scrive Trace su LOG---------
//PopulateError(1, "fattura") //x popolare systemerror con i vari dati automatici 
//u_write_trace()  
////-------------------------------------

	event u_personalizza_dw()

end event

