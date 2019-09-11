$PBExportHeader$kuf_clienti.sru
forward
global type kuf_clienti from kuf_parent
end type
end forward

global type kuf_clienti from kuf_parent
end type
global kuf_clienti kuf_clienti

type variables
//
//---- campo fattura_da inteso come cliente da fatturare sulle bolle di sped o sui certificati
constant string kki_fattura_da_DEFAULT  = 'B' // Valore di default
constant string kki_fattura_da_bolla = 'B' // fattura solo se bolla di sped pronta
constant string kki_fattura_da_certif = 'C'   // già fattura quando il certificato è pronto

//--- Tipo Anagrafica ientificato dall'arcivio MRF ma anche nella col fittizia TIPO_MRF della strutt. st_tab_clienti 
public constant string kki_tipo_mrf_NESSUNO = "N" 
public constant string kki_tipo_mrf_FATTURATO = "F"  // detto anche cliente
public constant string kki_tipo_mrf_MANDANTE = "M"
public constant string kki_tipo_mrf_RICEVENTE = "R"
public constant string kki_tipo_mrf_FATT_MAN = "G"
public constant string kki_tipo_mrf_FATT_RIC = "H"
public constant string kki_tipo_mrf_FATT_MAN_RIC = "I"
public constant string kki_tipo_mrf_MAN_RIC = "L"

//--- Natura dell'Anagrafica come indicato in archivio 
constant string kki_tipo_CONTATTO = "C"  // solo contatto 
constant string kki_tipo_MOVIM = "M"  // anagrafica da movimentare in magazzino (mand o ricev o fatt)
constant string kki_tipo_ALTRO = "A" 

//--- campo Stato
constant string kki_cliente_stato_potenziale_da_contattare = "2"
constant string kki_cliente_stato_potenziale_in_contatto = "3"
constant string kki_cliente_stato_attivo_parziale = "5"
constant string kki_cliente_stato_attivo = "6"
constant string kki_cliente_stato_sospeso = "7"
constant string kki_cliente_stato_estinto = "8"

//--- Datawindow Elenco Mandanti x Cliente
constant string kk_dw_elenco_mand = "d_clienti_l_3"

//--- Cadenza di Fatturazione: se è da fare e quando 
constant string kki_cliente_fattura_fine_mese = "M"
constant string kki_cliente_fattura_meta_fine_mese = "QM"
constant string kki_cliente_fattura_mai = "N"

//--- Datawindow varie
constant string kki_dw_elenco_m_r_f_3 = "d_m_r_f_l_3"   // elenco Ricev+Fatt x Mandanti

//--- campo Modo_stampa in clienti_fatt
string kki_fatt_modo_stampa_cartaceo = "S"
string kki_fatt_modo_stampa_digitale = "D"
string kki_fatt_modo_stampa_cartaceo_digitale = "E"

//--- campo Modo_email in clienti_fatt
string kki_fatt_modo_email_avviso = "A"   // invia solo avviso non allegati
string kki_fatt_modo_email_allega = "F"   // invia anche la fattura come alleg
string kki_fatt_modo_email_nulla = "N"    // non invia nulla

//--- campo in MKT - documenti da esportare in digitale?
string kki_doc_esporta_si = "S"

//--- Dati x ACO: registro conto deposito
string kki_registro_tipo_nessuno = 'N'
string kki_registro_tipo_x_partnumber = 'P'  // estrazione x part-number
string kki_registro_tipo_x_barcode = 'B' // estrazione dettagliata x barcode

//--- MEMO
//private kuf_memo kiuf_memo
private st_tab_clienti_memo kist_tab_clienti_memo
////--- MEMO: settore di competenza 
//public constant string kki_tipo_sv_MKT = "MKT"  //serve a ufficio MKT
//public constant string kki_tipo_sv_ANA = "ANA"  //x anagrafiche di ogni tipo
//public constant string kki_tipo_sv_CRD = "CRD"  //x contratti RD
//public constant string kki_tipo_sv_CCO = "CCO"  //x contratti COMMERCIALI
//public constant string kki_tipo_sv_CDP = "CDP"  //x contratti CONTO DEPOSITO



end variables

forward prototypes
public function st_esito conta_p_iva (ref st_tab_clienti kst_tab_clienti)
public function st_esito tb_update_ind_comm (st_tab_ind_comm kst_tab_ind_comm)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_clienti kst_tab_clienti)
public function string tb_delete (long k_id_cliente)
public subroutine if_isnull (ref st_tab_clienti kst_tab_clienti)
public function st_esito check_piva (st_tab_clienti kst_tab_clienti)
public function st_esito leggi_rag_soc (ref st_tab_clienti kst_tab_clienti)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti)
public function st_esito leggi_rag_soc_sped (ref st_tab_clienti kst_tab_clienti)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_alfa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito check_cf_persona_fisica (st_tab_clienti kst_tab_clienti)
public function st_esito check_cf (st_tab_clienti kst_tab_clienti)
public function st_esito check_cf_altro (st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_riceventi (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_mandanti (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_fatturati (ref st_tab_clienti kst_tab_clienti)
public function st_esito tb_update (st_tab_clienti_fatt kst_tab_clienti_fatt)
public function st_esito tb_delete (st_tab_clienti_fatt kst_tab_clienti_fatt)
public function string tb_delete_ind_comm (st_tab_ind_comm kst_tab_ind_comm)
public function string tb_delete_m_r_f (st_tab_clienti_m_r_f kst_tab_clienti_m_r_f)
public function st_esito get_ultimo_id (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nome (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_p_iva (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_tipo_banca (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_esenzione_iva (ref st_tab_clienti kst_tab_clienti)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function integer if_presente_id_clie_settore (st_tab_clienti kst_tab_clienti) throws uo_exception
public function integer if_presente_id_clie_classe (st_tab_clienti kst_tab_clienti) throws uo_exception
public function st_esito get_indirizzi (ref st_tab_clienti kst_tab_clienti)
public function st_esito tb_delete (st_tab_clienti_mkt kst_tab_clienti_mkt)
public function st_esito tb_delete (st_tab_clienti_web kst_tab_clienti_web)
public function st_esito tb_update (st_tab_clienti_mkt kst_tab_clienti_mkt)
public function st_esito tb_update (st_tab_clienti_web kst_tab_clienti_web)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti_mkt kst_tab_clienti_mkt)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti_web kst_tab_clienti_web)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_m_r_f kst_tab_m_r_f)
public function st_esito anteprima_elenco_contatti (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti)
public function st_esito anteprima_elenco_clienti_del_contatto (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti)
public subroutine esenzione_iva_controllo_fattura (ref st_clienti_esenzione_iva kst_clienti_esenzione_iva) throws uo_exception
public function st_esito get_contatti (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_settore (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_fattura_da (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_mrf_clie_2 (ref st_tab_m_r_f kst_tab_m_r_f)
public function st_esito get_mrf_clie_3 (ref st_tab_m_r_f kst_tab_m_r_f)
public subroutine get_codice_da_cf (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public subroutine get_codice_da_piva (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public subroutine elenco_m_r_f_3 (st_tab_clienti kst_tab_clienti)
public function st_esito get_email (ref st_tab_clienti_web kst_tab_clienti_web)
public function boolean if_presente_m_r_f (st_tab_clienti_m_r_f kst_tab_clienti_m_r_f) throws uo_exception
public function st_esito get_nome_da_xyz (string k_codice, ref st_tab_clienti kst_tab_clienti)
public function st_esito get_codice_da_xyz (string k_codice, ref st_tab_clienti kst_tab_clienti)
public function boolean leggi (ref st_tab_clienti_web kst_tab_clienti_web) throws uo_exception
public function boolean leggi (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public function boolean if_esiste_doc_esporta_prefpath (st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception
public function boolean get_doc_esporta_prefpath (ref st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception
public function long leggi_tutto (ref st_tab_clienti ast_tab_clienti[]) throws uo_exception
public function long get_cod_pag (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public function st_esito get_nr_m_r_f (ref st_tab_clienti kst_tab_clienti)
public function boolean if_estinto (st_tab_clienti kst_tab_clienti) throws uo_exception
public function boolean reset_id_meca_causale_all (st_tab_clienti ast_tab_clienti) throws uo_exception
public function boolean set_id_meca_causale (st_tab_clienti ast_tab_clienti) throws uo_exception
public function boolean get_doc_esporta (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception
public function long get_id_cliente_memo (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception
public function boolean tb_delete (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
public function st_esito get_id_memo (ref st_tab_clienti_memo kst_tab_clienti_memo)
public subroutine memo_save (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
public function st_esito tb_update (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception
public function long get_id_meca_causale (readonly st_tab_clienti ast_tab_clienti) throws uo_exception
public function string get_id_nazione (readonly st_tab_clienti ast_tab_clienti) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_clienti kst_tab_clienti)
public function long get_codice_da_rag_soc (ref string a_rag_soc_10) throws uo_exception
public function st_esito anteprima_elenco_memo (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti)
public subroutine get_id_memo_max_x_id_cliente (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception
public function string get_email_prontomerce (ref st_tab_clienti_web kst_tab_clienti_web) throws uo_exception
public function string get_email_indirizzo (st_tab_clienti_web ast_tab_clienti_web, integer a_nr_email) throws uo_exception
public function boolean if_attivo (st_tab_clienti kst_tab_clienti) throws uo_exception
public function boolean if_attivo_attivoparziale (st_tab_clienti kst_tab_clienti) throws uo_exception
public function decimal get_impon_minimo (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception
public function boolean if_bloccato (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public function integer get_e1an_altro (st_tab_clienti kst_tab_clienti) throws uo_exception
public function long get_e1an (st_tab_clienti kst_tab_clienti) throws uo_exception
public function string get_e1ancodrs (st_tab_clienti kst_tab_clienti) throws uo_exception
public function string get_pklbcodepref (st_tab_clienti kst_tab_clienti) throws uo_exception
public function long get_mrf_e1an (st_tab_m_r_f kst_tab_m_r_f) throws uo_exception
public function string get_codice_ipa (st_tab_clienti kst_tab_clienti) throws uo_exception
public function boolean if_cliente_pa (st_tab_clienti kst_tab_clienti) throws uo_exception
public function string get_tipo (st_tab_clienti kst_tab_clienti) throws uo_exception
public function long get_codice_da_e1an (st_tab_clienti kst_tab_clienti) throws uo_exception
public function long get_id_cliente_memo_max () throws uo_exception
public function long get_codice_max () throws uo_exception
public subroutine get_delivery (ref st_tab_clienti kst_tab_clienti) throws uo_exception
public function string get_email_attestato (st_tab_clienti kst_tab_clienti) throws uo_exception
end prototypes

public function st_esito conta_p_iva (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta le P_IVA uguali
//=== 
//=== Inp: kst_tab_clienti.codice  = cliente su cui non fare la ricerca
//=== Out: kst_tab_clienti.contati  = numero rec con la stessa p_iva
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_clienti.contati = 0
if isnull(kst_tab_clienti.codice)  then kst_tab_clienti.codice = 0
	
SELECT count(*)
       into :kst_tab_clienti.contati
		 FROM clienti
			where p_iva = :kst_tab_clienti.p_iva and codice <> :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab. Clienti conta P.IVA identiche. Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		
		if isnull(kst_tab_clienti.contati) then kst_tab_clienti.contati = 0
		
	end if




return kst_esito




end function

public function st_esito tb_update_ind_comm (st_tab_ind_comm kst_tab_ind_comm);//
//====================================================================
//=== Aggiunge rek nella tabella Indirizzo di Fatturazione
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:  Standard
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if kst_tab_ind_comm.clie_c > 0 then
	
	//	kuf_sicurezza kuf1_sicurezza
	
		kst_tab_ind_comm.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_ind_comm.x_utente = kGuf_data_base.prendi_x_utente()
	
		if isnull(kst_tab_ind_comm.rag_soc_1_c) then
			kst_tab_ind_comm.rag_soc_1_c = " "
		end if
		if isnull(kst_tab_ind_comm.rag_soc_2_c) then
			kst_tab_ind_comm.rag_soc_2_c = " "
		end if
		if isnull(kst_tab_ind_comm.indi_c) then
			kst_tab_ind_comm.indi_c = " "
		end if
		if isnull(kst_tab_ind_comm.loc_c) then
			kst_tab_ind_comm.loc_c = " "
		end if
		if isnull(kst_tab_ind_comm.cap_c) then
			kst_tab_ind_comm.cap_c = " "
		end if
		if isnull(kst_tab_ind_comm.prov_c) then
			kst_tab_ind_comm.prov_c = " "
		end if
		if isnull(kst_tab_ind_comm.id_nazione_c ) then
			kst_tab_ind_comm.id_nazione_c = ""
		end if
	
	
		
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
		kst_open_w.id_programma = kkg_id_programma_anag
		k_rc = if_sicurezza(kst_open_w)	
		
	//	kuf1_sicurezza = create kuf_sicurezza
	//	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	//	destroy kuf1_sicurezza	
		
		//--- controlla se utente autorizzato alla funzione in atto
		if not k_rc then
		
			kguo_exception.messaggio_utente( )
	//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	//		kst_esito.SQLErrText = "Modifica " + get_descrizione(kst_open_w.flag_modalita) + " non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
			kst_esito.esito = "1"
		
		else
			
			select distinct clie_c
				into :k_rcn
				from ind_comm
				WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
				using kguo_sqlca_db_magazzino;
				
					
		//--- tento l'insert se manca in arch.
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				UPDATE ind_comm  
				  SET rag_soc_1_c = :kst_tab_ind_comm.rag_soc_1_c,   
						rag_soc_2_c = :kst_tab_ind_comm.rag_soc_2_c,   
						indi_c = :kst_tab_ind_comm.indi_c,   
						loc_c = :kst_tab_ind_comm.loc_c,   
						cap_c = :kst_tab_ind_comm.cap_c,   
						prov_c = :kst_tab_ind_comm.prov_c,  
						id_nazione_c = :kst_tab_ind_comm.id_nazione_c,  
						x_datins = :kst_tab_ind_comm.x_datins,  
						x_utente = :kst_tab_ind_comm.x_utente  
					WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
					using kguo_sqlca_db_magazzino;
					
			else
				
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					INSERT INTO ind_comm  
							( clie_c,   
							  rag_soc_1_c,   
							  rag_soc_2_c,   
							  indi_c,   
							  loc_c,   
							  cap_c,   
							  prov_c,   
							  id_nazione_c,
							  x_datins,   
							  x_utente )  
					  VALUES ( :kst_tab_ind_comm.clie_c,   
							  :kst_tab_ind_comm.rag_soc_1_c,   
							  :kst_tab_ind_comm.rag_soc_2_c,   
							  :kst_tab_ind_comm.indi_c,   
							  :kst_tab_ind_comm.loc_c,   
							  :kst_tab_ind_comm.cap_c,   
							  :kst_tab_ind_comm.prov_c,   
							  :kst_tab_ind_comm.id_nazione_c,
							  :kst_tab_ind_comm.x_datins,   
							  :kst_tab_ind_comm.x_utente )  
					using kguo_sqlca_db_magazzino;
				end if
			end if	
		
		
			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Tab. Indirizzi Commerciali:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kguo_sqlca_db_magazzino.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
						if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
							kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
						end if
					end if
				end if
			else
				if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
					kst_esito = kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
		
		end if
		
		
	else
		kst_esito.SQLErrText = "Tab.Ind.Commerciali: nessun dato inserito (codice cliente non indicato) "
		kst_esito.esito = kkg_esito.no_esecuzione
		
	end if		
	
catch (uo_exception kuo_exception)
	kguo_exception.messaggio_utente( )
	
end try


return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_clienti kst_tab_clienti);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "" or kdw_anteprima.dataobject = "d_nulla" then
			kdw_anteprima.dataobject = "d_clienti_1_anteprima"		
		end if
	end if
	
	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Anagrafica da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function string tb_delete (long k_id_cliente);//
//====================================================================
//=== Cancella il rek dalla tabella Clienti e Clienti_sped
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
boolean k_rc
long k_num
date k_data
long k_id_cliente_rit
//kuf_clienti kuf1_clienti
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_clientI kst_tab_clienti
st_tab_ind_comm kst_tab_ind_comm
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_clienti_web kst_tab_clienti_web


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_rc then

	k_return = "1" + "Cancellazione Anagrafica non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"

else


//=== Controllo se nelle ENTRATE ci sono clienti
	DECLARE entrate CURSOR FOR  
		  SELECT num_int,
					data_int
			 FROM meca
			WHERE clie_1 = :k_id_cliente OR
					clie_2 = :k_id_cliente OR
					clie_3 = :k_id_cliente 
		union all
		  SELECT num_int,
					data_int
			 FROM o_armo
			WHERE clie_1 = :k_id_cliente OR
					clie_2 = :k_id_cliente OR
					clie_3 = :k_id_cliente ; 

//=== Controllo se in USCITA ci sono Clienti
	DECLARE fatture CURSOR FOR  
		  SELECT num_fatt,
					data_fatt
			 FROM arfa_testa
			WHERE id_cliente = :k_id_cliente ; 
			
			
			
	
	open entrate;
	if sqlca.sqlCode = 0 then
	
		fetch entrate INTO :k_num, :k_data ;
	
		if sqlca.sqlCode = 0 then
			k_return = "2" + "Cliente gia' movimentato come nel Rif.: ~n~r" + &
				"n. " + string(k_num, "#####") + " del " + &
				string(k_data, "dd/mm/yy") + "~n~r" 	
		end if
		close entrate;
	end if
	
	if LeftA(k_return, 1) = "0" then
		open fatture;
		if sqlca.sqlCode = 0 then
	
			fetch fatture INTO 	:k_num, :k_data;
	
			if sqlca.sqlCode = 0 then
				k_return = "2" + "Cliente con Fatture, come la:  ~n~r" + &
					"n. " + string(k_num, "#####") + " del " + &
					string(k_data, "dd/mm/yy") + "~n~r" 	
	
			end if
			close fatture;
		end if
	end if
	
		
	if LeftA(k_return, 1) = "0" then
		
		delete from clienti
				where codice = :k_id_cliente ;
	
		if sqlca.sqlCode <> 0 then
	
			k_return = "1" + SQLCA.SQLErrText

			if kst_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if

		else
	
//--- cancella indirizzi
			kst_tab_ind_comm.st_tab_g_0.esegui_commit = "N"
			kst_tab_ind_comm.clie_c = k_id_cliente
			tb_delete_ind_comm(kst_tab_ind_comm)
//			delete from ind_comm
//				where clie_c = :k_id_cliente ;

//--- cancella dati di fatturazione
			kst_tab_clienti_fatt.st_tab_g_0.esegui_commit = "N"
			kst_tab_clienti_fatt.id_cliente = k_id_cliente
			tb_delete(kst_tab_clienti_fatt)

//--- cancella dati di MKT
			kst_tab_clienti_mkt.st_tab_g_0.esegui_commit = "N"
			kst_tab_clienti_mkt.id_cliente = k_id_cliente
			tb_delete(kst_tab_clienti_mkt)

//--- cancella dati di WEB
			kst_tab_clienti_web.st_tab_g_0.esegui_commit = "N"
			kst_tab_clienti_web.id_cliente = k_id_cliente
			tb_delete(kst_tab_clienti_web)

			if kst_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
	
				
		end if
	end if
end if


return k_return
end function

public subroutine if_isnull (ref st_tab_clienti kst_tab_clienti);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_clienti.contati) then kst_tab_clienti.contati = 0
if isnull(kst_tab_clienti.codice) then kst_tab_clienti.codice = 0
if isnull(kst_tab_clienti.stato ) then kst_tab_clienti.stato  = " "
if isnull(kst_tab_clienti.tipo ) then kst_tab_clienti.tipo  = " "
if isnull(kst_tab_clienti.tipo_mrf ) then kst_tab_clienti.tipo_mrf  = " "  // questa non è una colonna di tabella 
if isnull(kst_tab_clienti.data_attivazione) then kst_tab_clienti.data_attivazione = date(0)
if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10  = " "
if isnull(kst_tab_clienti.rag_soc_11) then kst_tab_clienti.rag_soc_11  = " "   
if isnull(kst_tab_clienti.rag_soc_20) then kst_tab_clienti.rag_soc_20  = " "   
if isnull(kst_tab_clienti.rag_soc_21) then kst_tab_clienti.rag_soc_21  = " "   
if isnull(kst_tab_clienti.indi_1) then kst_tab_clienti.indi_1  = " "   
if isnull(kst_tab_clienti.loc_1) then kst_tab_clienti.loc_1  = " "   
if isnull(kst_tab_clienti.cap_1) then kst_tab_clienti.cap_1  = " "   
if isnull(kst_tab_clienti.prov_1) then kst_tab_clienti.prov_1  = " "   
if isnull(kst_tab_clienti.id_nazione_1) then kst_tab_clienti.id_nazione_1  = " "   
if isnull(kst_tab_clienti.p_iva ) then kst_tab_clienti.p_iva  = " " 
if isnull(kst_tab_clienti.cf ) then kst_tab_clienti.cf  = " " 
if isnull(kst_tab_clienti.zona ) then kst_tab_clienti.zona  = " "
if isnull(kst_tab_clienti.fono) then kst_tab_clienti.fono  = " "
if isnull(kst_tab_clienti.fax) then kst_tab_clienti.fax  = " " 
if isnull(kst_tab_clienti.cod_pag) then kst_tab_clienti.cod_pag = 0
if isnull(kst_tab_clienti.banca) then kst_tab_clienti.banca  = " " 
if isnull(kst_tab_clienti.abi) then kst_tab_clienti.abi = 0
if isnull(kst_tab_clienti.cab) then kst_tab_clienti.cab = 0
if isnull(kst_tab_clienti.tipo_banca) then kst_tab_clienti.tipo_banca  = " " 
if isnull(kst_tab_clienti.iva) then kst_tab_clienti.iva = 0
if isnull(kst_tab_clienti.iva_valida_dal) then kst_tab_clienti.iva_valida_dal = date(0)
if isnull(kst_tab_clienti.iva_valida_al) then kst_tab_clienti.iva_valida_al = date(0)
if isnull(kst_tab_clienti.iva_esente_imp_max) then kst_tab_clienti.iva_esente_imp_max = 0.00
if isnull(kst_tab_clienti.iva_esente_imp_min_x_fatt) then kst_tab_clienti.iva_esente_imp_min_x_fatt = 0.00
if isnull(kst_tab_clienti.mese_es_1) then kst_tab_clienti.mese_es_1 = 0
if isnull(kst_tab_clienti.mese_es_2) then kst_tab_clienti.mese_es_2 = 0
if isnull(kst_tab_clienti.cadenza_fattura) then kst_tab_clienti.cadenza_fattura = " "
if isnull(kst_tab_clienti.indi_2) then kst_tab_clienti.indi_2  = " "
if isnull(kst_tab_clienti.cap_2 ) then kst_tab_clienti.cap_2 = " "
if isnull(kst_tab_clienti.loc_2) then kst_tab_clienti.loc_2  = " "
if isnull(kst_tab_clienti.prov_2 ) then kst_tab_clienti.prov_2  = " "
if isnull(kst_tab_clienti.id_nazione_2) then kst_tab_clienti.id_nazione_2  = " "   
if isnull(kst_tab_clienti.spe_inc ) then kst_tab_clienti.spe_inc  = " "
if isnull(kst_tab_clienti.spe_bollo ) then kst_tab_clienti.spe_bollo  = " "
if isnull(kst_tab_clienti.id_clie_settore ) then kst_tab_clienti.id_clie_settore  = " "
if isnull(kst_tab_clienti.id_clie_classe ) then kst_tab_clienti.id_clie_classe  = " "
if isnull(kst_tab_clienti.id_meca_causale) then kst_tab_clienti.id_meca_causale = 0
if isnull(kst_tab_clienti.e1an) then kst_tab_clienti.e1an = 0
if isnull(kst_tab_clienti.e1ancodrs) then kst_tab_clienti.e1ancodrs = ""
if isnull(kst_tab_clienti.pklbcodepref) then kst_tab_clienti.pklbcodepref = ""
if isnull(kst_tab_clienti.delivery_dd_after) then kst_tab_clienti.delivery_dd_after = 0
if isnull(kst_tab_clienti.delivery_hour) then kst_tab_clienti.delivery_hour = time("00:00")
if isnull(kst_tab_clienti.x_datins) then kst_tab_clienti.x_datins = datetime(date(0))
if isnull(kst_tab_clienti.x_utente) then kst_tab_clienti.x_utente  = " "

if isnull(kst_tab_clienti.kst_tab_nazioni.nome) then kst_tab_clienti.kst_tab_nazioni.nome  = " "
if isnull(kst_tab_clienti.kst_tab_nazioni.area) then kst_tab_clienti.kst_tab_nazioni.area  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c) then kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c) then kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.indi_c) then kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.cap_c ) then kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.loc_c) then kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.prov_c) then kst_tab_clienti.kst_tab_ind_comm.prov_c  = " " 
if isnull(kst_tab_clienti.kst_tab_ind_comm.id_nazione_c) then kst_tab_clienti.kst_tab_ind_comm.id_nazione_c  = "" 
if isnull(kst_tab_clienti.kst_tab_ind_comm.clie_c) then kst_tab_clienti.kst_tab_ind_comm.clie_c = 0
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.id_cliente) then kst_tab_clienti.kst_tab_clienti_fatt.id_cliente = 0
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da ) then kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.note_1 ) then kst_tab_clienti.kst_tab_clienti_fatt.note_1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.note_2 ) then kst_tab_clienti.kst_tab_clienti_fatt.note_2 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.modo_stampa ) then kst_tab_clienti.kst_tab_clienti_fatt.modo_stampa = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.modo_email ) then kst_tab_clienti.kst_tab_clienti_fatt.modo_email = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.email_invio ) then kst_tab_clienti.kst_tab_clienti_fatt.email_invio = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.impon_minimo) then kst_tab_clienti.kst_tab_clienti_fatt.impon_minimo = 0
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.codice_ipa ) then kst_tab_clienti.kst_tab_clienti_fatt.codice_ipa = ""
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.x_datins) then kst_tab_clienti.kst_tab_clienti_fatt.x_datins = datetime(date(0))
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.x_utente) then kst_tab_clienti.kst_tab_clienti_fatt.x_utente  = ""

if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_cliente ) then kst_tab_clienti.kst_tab_clienti_mkt.id_cliente = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.tipo_rapporto ) then kst_tab_clienti.kst_tab_clienti_mkt.tipo_rapporto = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.altra_sede ) then kst_tab_clienti.kst_tab_clienti_mkt.altra_sede = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.cod_atecori ) then kst_tab_clienti.kst_tab_clienti_mkt.cod_atecori  = "" 
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.contatto_1_qualif) then kst_tab_clienti.kst_tab_clienti_mkt.contatto_1_qualif  = "" 
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.contatto_2_qualif) then kst_tab_clienti.kst_tab_clienti_mkt.contatto_2_qualif  = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.contatto_3_qualif ) then kst_tab_clienti.kst_tab_clienti_mkt.contatto_3_qualif = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.contatto_4_qualif ) then kst_tab_clienti.kst_tab_clienti_mkt.contatto_4_qualif  = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.contatto_5_qualif ) then kst_tab_clienti.kst_tab_clienti_mkt.contatto_5_qualif  = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1 ) then kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1 = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2 ) then kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2 = 0 
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3 ) then kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3  = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4 ) then kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4  = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5 ) then kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5  = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_cliente_link ) then kst_tab_clienti.kst_tab_clienti_mkt.id_cliente_link  = 0
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.note_attivita ) then kst_tab_clienti.kst_tab_clienti_mkt.note_attivita = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.note_prodotti ) then kst_tab_clienti.kst_tab_clienti_mkt.note_prodotti = "" 
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.qualifica ) then kst_tab_clienti.kst_tab_clienti_mkt.qualifica  = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta ) then kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta  = "N"
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta_prefpath ) then kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta_prefpath  = ""
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.x_datins) then kst_tab_clienti.kst_tab_clienti_mkt.x_datins = datetime(date(0))
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.x_utente  ) then kst_tab_clienti.kst_tab_clienti_mkt.x_utente = ""

if isnull(kst_tab_clienti.kst_tab_clienti_web.id_cliente  ) then kst_tab_clienti.kst_tab_clienti_web.id_cliente = 0
if isnull(kst_tab_clienti.kst_tab_clienti_web.blog_web  ) then kst_tab_clienti.kst_tab_clienti_web.blog_web = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.blog_web1  ) then kst_tab_clienti.kst_tab_clienti_web.blog_web1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email  ) then kst_tab_clienti.kst_tab_clienti_web.email = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email1  ) then kst_tab_clienti.kst_tab_clienti_web.email1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email2  ) then kst_tab_clienti.kst_tab_clienti_web.email2 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email3  ) then kst_tab_clienti.kst_tab_clienti_web.email3 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email_prontomerce  ) then kst_tab_clienti.kst_tab_clienti_web.email_prontomerce = 0
if isnull(kst_tab_clienti.kst_tab_clienti_web.note  ) then kst_tab_clienti.kst_tab_clienti_web.note = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.sito_web  ) then kst_tab_clienti.kst_tab_clienti_web.sito_web = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.sito_web1  ) then kst_tab_clienti.kst_tab_clienti_web.sito_web1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.x_utente  ) then kst_tab_clienti.kst_tab_clienti_web.x_utente = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.x_utente  ) then kst_tab_clienti.kst_tab_clienti_web.x_utente = ""

end subroutine

public function st_esito check_piva (st_tab_clienti kst_tab_clienti);//---
//--- Controllo della Partiva IVA
//--- Input:  st_tab_clienti = con il P.IVA valorizzato
//---Out: st_esito come da standard
//---
//-----------------------------------------------------------------------------------------------------------
//--- Spiegazione dell'algoritmo
//-----------------------------------------------------------------------------------------------------------
//Partita I.V.A. E' composta da 11 cifre. L'ultima cifra è il carattere di controllo che vogliamo verificare: 
//
// pos 1-7 progressivo
// pos 8-10 codice ISTAT dell'ufficio provinciale
// pos 11 codice di controllo che si verifica come segue
//
//1. si pone s=0
//2. sommare ad s le cifre di posto dispari (dalla prima alla nona)
//3. per ogni cifra di posto pari (dalla seconda alla decima),
//   moltiplicare la cifra per due e, se risulta piu' di 9,
//   sottrarre 9; quindi aggiungere il risultato a s;
//4. si calcola il resto della divisione di s per 10:
//   r=s%10 cioe' r=s-10*int(s/10); risulta un numero tra 0 e 9;
//5. se r=0 si pone c=0, altrimenti si pone c=10-r
//6. l'ultima cifra del cod. fisc. deve valere c.
//
//Esempio: 12345678903 
//1. s=0
//2. s=1+3+5+7+9=25
//3. s=s+4+8+3+7=47
//4. r=7
//5. c=3
//6. OK.
//-----------------------------------------------------------------------------------------------------------
st_esito kst_esito
string k_piva
int k_ctr, k_somma_dei_dispari, k_somma_dei_pari, k_somma_appo, k_somma_tot


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

k_piva = trim(kst_tab_clienti.p_iva)


//--- se terzo carattere ALFANUMERICO si presuppone che sia un Codice Fiscale quindi salta controllo
if isnumber(MidA(k_piva,3,1)) then
	
	if LenA(k_piva) <> 11 then
		
		kst_esito.esito = kkg_esito.err_formale
		kst_esito.SQLErrText = "P. IVA  " + k_piva +" errata, deve essere di 11 caratteri numerici"
	
	else
		if not isnumber(k_piva) then
		
			kst_esito.esito = kkg_esito.err_formale
			kst_esito.SQLErrText = "P. IVA " + k_piva +" errata, deve essere composta solo da numeri"
	
	
		end if
	end if
	
	if kst_esito.esito = kkg_esito.ok then
	
	//---- tratto la parte pari (che qui e' dispari xche' l'array parte da 1)
		k_somma_dei_pari = 0
		for k_ctr = 1 to 9 step +2 
			
			k_somma_dei_pari += integer(MidA(k_piva,k_ctr,1))
			
		end for
	
	//---- tratto la parte DISPARI (che qui e' pari xche' l'array parte da 1)
		k_somma_dei_dispari = 0
		for k_ctr = 2 to 10 step +2  
	
			k_somma_appo = integer(MidA(k_piva,k_ctr,1)) * 2
			if k_somma_appo > 9 then k_somma_appo -= 9
			
			k_somma_dei_dispari += k_somma_appo
			
		end for
	
		k_somma_tot = k_somma_dei_pari + k_somma_dei_dispari
	
		k_somma_tot = mod(k_somma_tot , 10)
		if k_somma_tot > 0 then k_somma_tot = 10 - k_somma_tot
		
		if k_somma_tot <> integer(MidA(k_piva,11,1)) then
			kst_esito.esito = kkg_esito.err_formale
			kst_esito.SQLErrText = "P. IVA " + k_piva +" errata, prego controllare. "
		end if
	
	end if
end if


return kst_esito







end function

public function st_esito leggi_rag_soc (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti ecc...
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT 
		  CLIENTI.RAG_SOC_10,
		  CLIENTI.RAG_SOC_11,
		  CLIENTI.INDI_1,
		  CLIENTI.CAP_1,
		  CLIENTI.LOC_1,
		  CLIENTI.PROV_1,
		  CLIENTI.id_nazione_1,
		  CLIENTI.P_IVA,
		  CLIENTI.CF
    INTO 
	 	  :kst_tab_clienti.rag_soc_10,   
         :kst_tab_clienti.rag_soc_11,   
		  :kst_tab_clienti.indi_1,   
         :kst_tab_clienti.cap_1,   
         :kst_tab_clienti.loc_1,   
         :kst_tab_clienti.prov_1,   
		  :kst_tab_clienti.id_nazione_1,
		  :kst_tab_clienti.P_IVA,
         :kst_tab_clienti.CF   
        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Anagrafe: " + string(kst_tab_clienti.codice) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		
		if_isnull(kst_tab_clienti)  // toglie i null
		
	end if



return kst_esito

end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_clienti_1_anteprima"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Anagrafica da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito leggi_rag_soc_sped (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti ecc...
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_clienti.codice > 0 then
   SELECT 
		  CLIENTI.RAG_SOC_10,
		  CLIENTI.RAG_SOC_11,
		  CLIENTI.INDI_1,
		  CLIENTI.CAP_1,
		  CLIENTI.LOC_1,
		  CLIENTI.PROV_1,
		  CLIENTI.id_nazione_1,
		  CLIENTI.cod_pag
    INTO 
	 	  :kst_tab_clienti.rag_soc_10,   
           :kst_tab_clienti.rag_soc_11,   
		  :kst_tab_clienti.indi_1,   
           :kst_tab_clienti.cap_1,   
           :kst_tab_clienti.loc_1,   
           :kst_tab_clienti.prov_1,   
		  :kst_tab_clienti.id_nazione_1,
		  :kst_tab_clienti.cod_pag
        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Anagrafica, codice " + string(kst_tab_clienti.codice) + " :" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		
		if_isnull(kst_tab_clienti)  // toglie i null
		
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Nessun codice indicato per Lettura Anagrafica" 
	kst_esito.esito = kkg_esito.not_fnd
end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
//long k_handle_item_corrente = 0, k_handle_item_padre = 0, k_handle_item_nonno, k_handle_item_rit=0
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_stato_barcode="", k_tipo_oggetto_figlio, k_oggetto_padre
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_clienti kst_tab_clienti
//st_tab_iva kst_tab_iva
//st_tab_pagam kst_tab_pagam
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
	
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

	
//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> "Anagrafe" then 
  		
//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Anagrafe"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "codice"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "E1"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Telefono"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Indirizzo"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Pagamento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "P.IVA"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "IVA"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Ulteriori Informazioni"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"

				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
 
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
				
			loop

		end if


//--- imposto il pic corretto
//		k_handle_item_corrente1 = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente1, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
		k_pictureindex = kuf1_treeview.u_dammi_pic_tree_list(k_tipo_oggetto)			


		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
//			kst_tab_iva = kst_treeview_data_any.st_tab_iva
//			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = k_pictureindex
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10) &
								+ " " + trim(kst_tab_clienti.rag_soc_20))

			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.codice , "#####0") )
	
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_clienti.e1ancodrs)) &
			                + "  (" + string(kst_tab_clienti.e1an) + ")" &
								 )
	
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_clienti.fono)))
			  //              + "  /  " + trim(string(kst_tab_clienti.fax)) &
								 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, &
									   trim(string(kst_tab_clienti.loc_1)) + "  (" &
									 + trim(string(kst_tab_clienti.prov_1)) + ")  " &
									 + trim(string(kst_tab_clienti.cap_1)) + "  " &
			                   + trim(string(kst_tab_clienti.indi_1)) + "  " &
									 )
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.cod_pag, "#####") &
									)
//									 + "  " + string(kst_tab_pagam.des) + "  " &
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, &
									   trim(string(kst_tab_clienti.p_iva)) + "  " &
									)
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.iva, "####") &
									)
//									 + "  " + string(kst_tab_iva.des) + "  " &
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, &
									   trim(string(kst_tab_clienti.banca)) + "  " &
									 + trim(string(kst_tab_clienti.abi)) + "-" &
									 + trim(string(kst_tab_clienti.cab)) + "  " &
									 )
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
	end if
 
 	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if

	 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_righe_clienti=0, k_riga=0
integer k_pic_open, k_pic_close
string k_tipo_oggetto_padre
string k_oggetto_corrente, k_tipo_oggetto_figlio
string k_alfa
integer k_ctr
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_clienti kst_tab_clienti
st_tab_pagam kst_tab_pagam
//st_tab_iva kst_tab_iva
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
datastore kds_clienti


//declare kc_treeview cursor for
//  SELECT   clienti.codice ,
//           clienti.rag_soc_10,
//           clienti.rag_soc_11,
//           clienti.indi_1,
//           clienti.cap_1 ,
//           clienti.loc_1,
//           clienti.prov_1 ,
//           clienti.zona ,
//           clienti.p_iva ,
//           clienti.fono,
//           clienti.fax, 
//           clienti.cod_pag, 
//           clienti.banca, 
//           clienti.abi, 
//           clienti.cab, 
//           clienti.tipo_banca, 
//           clienti.iva 
////			  pagam.des,
////			  iva.des
//        FROM clienti 
////		  left outer join pagam on
////              clienti.cod_pag = pagam.codice
////				         left outer join iva on
////				  clienti.iva     = iva.codice
//        WHERE clienti.rag_soc_10 like :k_alfa   
//		        or (:k_alfa = '-' AND  (clienti.rag_soc_10 is null or clienti.rag_soc_10 = ' ') ) 
//		  order by clienti.rag_soc_10
//		  using sqlca;


//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto
	end if


//--- Lettera di Estrazione		
   kst_treeview_data_any = kst_treeview_data.struttura 
   kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
	k_alfa = upper(trim(kst_tab_treeview.id))
	if LenA(k_alfa) = 0 or isnull(k_alfa) then
	   k_alfa = "-"
	else
		if k_alfa <> "%" then
			k_alfa = k_alfa + "%"
		end if
	end if
	

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

	
//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		kds_clienti = create datastore
		kds_clienti.dataobject = "ds_clienti_l_xtree"
		kds_clienti.settransobject(kguo_sqlca_db_magazzino)
		k_righe_clienti = kds_clienti.retrieve(k_alfa)

//		open kc_treeview;
//		if sqlca.sqlcode = 0 then
//			fetch kc_treeview 
//				into
//					:kst_tab_clienti.codice,
//					:kst_tab_clienti.rag_soc_10,
//					:kst_tab_clienti.rag_soc_11,
//					:kst_tab_clienti.indi_1,
//					:kst_tab_clienti.cap_1,
//					:kst_tab_clienti.loc_1,   
//					:kst_tab_clienti.prov_1,   
//					:kst_tab_clienti.zona,
//					:kst_tab_clienti.p_iva,
//					:kst_tab_clienti.fono,
//					:kst_tab_clienti.fax,
//					:kst_tab_clienti.cod_pag, 
//					:kst_tab_clienti.banca,
//					:kst_tab_clienti.abi,
//					:kst_tab_clienti.cab,
//					:kst_tab_clienti.tipo_banca,
//					:kst_tab_clienti.iva
////					:kst_tab_pagam.des,
////					:kst_tab_iva.des
//					  ;
//	
			for k_riga = 1 to k_righe_clienti
//			do while sqlca.sqlcode = 0
				kst_tab_clienti.codice = kds_clienti.getitemnumber( k_riga, "codice")
				kst_tab_clienti.rag_soc_10 = kds_clienti.getitemstring( k_riga, "rag_soc_10")
				kst_tab_clienti.rag_soc_11 = kds_clienti.getitemstring( k_riga, "rag_soc_11")
				kst_tab_clienti.indi_1 = kds_clienti.getitemstring( k_riga, "indi_1")
				kst_tab_clienti.cap_1 = kds_clienti.getitemstring( k_riga, "cap_1")
				kst_tab_clienti.loc_1 = kds_clienti.getitemstring( k_riga, "loc_1")   
				kst_tab_clienti.prov_1 = kds_clienti.getitemstring( k_riga, "prov_1")   
				kst_tab_clienti.zona = kds_clienti.getitemstring( k_riga, "zona")
				kst_tab_clienti.p_iva = kds_clienti.getitemstring( k_riga, "p_iva")
				kst_tab_clienti.fono = kds_clienti.getitemstring( k_riga, "fono")
				kst_tab_clienti.fax = kds_clienti.getitemstring( k_riga, "fax")
				kst_tab_clienti.cod_pag = kds_clienti.getitemnumber( k_riga, "cod_pag") 
				kst_tab_clienti.banca = kds_clienti.getitemstring( k_riga, "banca")
				kst_tab_clienti.abi = kds_clienti.getitemnumber( k_riga, "abi")
				kst_tab_clienti.cab = kds_clienti.getitemnumber( k_riga, "cab")
				kst_tab_clienti.tipo_banca = kds_clienti.getitemstring( k_riga, "tipo_banca")
				kst_tab_clienti.iva = kds_clienti.getitemnumber( k_riga, "iva")
				kst_tab_clienti.e1an = kds_clienti.getitemnumber( k_riga, "e1an")
				kst_tab_clienti.e1ancodrs = kds_clienti.getitemstring( k_riga, "e1ancodrs")
				kst_tab_pagam.des = kds_clienti.getitemstring( k_riga, "pagam_des")
			
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any

//			   klvi_listviewitem.data = kst_treeview_data

				this.if_isnull(kst_tab_clienti)
		
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
//				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
//				kst_treeview_data_any.st_tab_iva = kst_tab_iva
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = & 
				                     trim(kst_tab_clienti.rag_soc_10)  & 
					                 + "  (" + string(kst_tab_clienti.codice) + ") "

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

			next
			
//			close kc_treeview;
//		end if
	end if	
 

 
return k_return

end function

public function integer u_tree_riempi_treeview_alfa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_corrente = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_contati, k_totale
integer k_ctr, k_pic_close, k_pic_open
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int
string k_alfa
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



declare kc_treeview cursor for
	SELECT 
         count (*), 
         substring(clienti.rag_soc_10, 1, 1) as alfa
     FROM clienti
		 group by  substring(clienti.rag_soc_10, 1, 1)
		 order by  2 asc;


		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle

	if k_handle_item_corrente > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta(ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
		end if
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_corrente)

//--- Riga solo x accedere a tutti i clienti	
		kst_tab_treeview.descrizione_tipo = "Anagrafiche " 
		kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
		kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
		kst_treeview_data.struttura = kst_treeview_data_any
		kst_treeview_data.handle = k_handle_item_corrente
		ktvi_treeviewitem.label = kst_treeview_data.label
		ktvi_treeviewitem.data = kst_treeview_data
//--- Nuovo Item
		ktvi_treeviewitem.selected = false
		k_handle_primo = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_corrente, ktvi_treeviewitem)
//--- salvo handle del item appena inserito nella stessa struttura
		kst_treeview_data.handle = k_handle_primo
//--- inserisco il handle di questa riga tra i dati del item
		ktvi_treeviewitem.data = kst_treeview_data
		kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)

		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :k_contati
					 ,:k_alfa
					  ;
	
		
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
				k_totale = k_totale + k_contati
	
				if isnull(k_alfa) then
					k_alfa = "*senza nome*"
					kst_tab_treeview.id = " "
				else	
					kst_tab_treeview.id = k_alfa
					k_alfa = k_alfa + "..."
				end if
				kst_treeview_data.label = k_alfa  
				kst_tab_treeview.voce = kst_treeview_data.label
				
				if k_contati = 1 then
					kst_tab_treeview.descrizione = string(k_contati, "###,##0") + "  anagrafica presente"
				else
					kst_tab_treeview.descrizione = string(k_contati, "###,##0") + "  anagrafiche presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Anagrafiche " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data.handle = k_handle_item_corrente
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_corrente, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

				fetch kc_treeview 
					into
					  :k_contati
					 ,:k_alfa
					  ;
	
			loop
			
			close kc_treeview;
			
		end if
			
//--- Aggiorno il primo Item con i totali
		kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data 
		kst_tab_treeview = kst_treeview_data_any.st_tab_treeview 
		kst_treeview_data.struttura = kst_treeview_data_any
		kst_tab_treeview.id = "%"
		kst_treeview_data.label = "Tutte" 
		kst_tab_treeview.voce = kst_treeview_data.label
		kst_tab_treeview.descrizione = &
			 string(k_totale, "###,###,##0") + "  tutte le anagrafiche"
		kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
		kst_treeview_data.struttura = kst_treeview_data_any
		ktvi_treeviewitem.label = kst_treeview_data.label
		ktvi_treeviewitem.data = kst_treeview_data
		kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)

	end if 
 
return k_return


end function

public function st_esito check_cf_persona_fisica (st_tab_clienti kst_tab_clienti);//---
//-----------------------------------------------------------------------------------------------------------
//--- Controllo Codice fiscale   Persona Fisica
//---
//--- Input:  struttura  st_tab_clienti  con il  'CF = Codice Fiscale'  valorizzato
//--- Out: st_esito come da standard
//---
//-----------------------------------------------------------------------------------------------------------
//--- Spiegazione Controlli effettuati 
//-----------------------------------------------------------------------------------------------------------
//--- Per verificare velocemente un codice fiscale, si può ricorrere all'ultimo carattere dello stesso, chiamato Carattere di Controllo.
//--- Tale carattere corrisponde al Resto della divisione per 26 della somma dei valori dei caratteri in posizione pari sommato alla somma dei valori dei caratteri in posizionedispari.
//--- I valori dei caratteri vengono rilevati dalla Tabella di corrispondenza, nel nostro esempio la matrice Lettere, che contiene nella prima colonna le lettere dell'alfabeto e i numeri,
//--- nella seconda il loro valore se sono in posizione pari e nella terza il loro valore se sono in posizione dispari.
//--- Il funzionamento è semplice: dopo aver sommato i corrispettivi valori dei 15 caratteri relativi ai dati dell'utente(Nome, Cognome, sesso, anno e luogo di nascita), 
//--- divido il risultato per 26, ottenendo così un resto che sarà sempre compreso tra 0 e 25. 
//--- In questo modo al valore del resto, posso associare una lettera dell'alfabeto inglese (0=A, 1=B, ...) ottenendo così il sedicesimo carattere del Codice Fiscale.
//
//-----------------------------------------------------------------------------------------------------------

st_esito kst_esito
string CodiceFiscale 
string Lettere[0 to 35,0 to 2] 
string ConfrontoCarattereControllo[0 to 25]

int I
int J

int Carattere
int ValorePari
int ValoreDispari
int SommaCaratteri
string PariDispari
int Risultato

string CarattereControllo, RisultatoX
string Temp
string Test


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

CodiceFiscale = kst_tab_clienti.cf

Lettere[0,0] = "A"
Lettere[0,1] = "0"
Lettere[0,2] = "1"

Lettere[1,0] = "B"
Lettere[1,1] = "1"
Lettere[1,2] = "0"

Lettere[2,0] = "C"
Lettere[2,1] = "2"
Lettere[2,2] = "5"

Lettere[3,0] = "D"
Lettere[3,1] = "3"
Lettere[3,2] = "7"

Lettere[4,0] = "E"
Lettere[4,1] = "4"
Lettere[4,2] = "9"

Lettere[5,0] = "F"
Lettere[5,1] = "5"
Lettere[5,2] = "13"

Lettere[6,0] = "G"
Lettere[6,1] = "6"
Lettere[6,2] = "15"

Lettere[7,0] = "H"
Lettere[7,1] = "7"
Lettere[7,2] = "17"

Lettere[8,0] = "I"
Lettere[8,1] = "8"
Lettere[8,2] = "19"

Lettere[9,0] = "J"
Lettere[9,1] = "9"
Lettere[9,2] = "21"

Lettere[10,0] = "K"
Lettere[10,1] = "10"
Lettere[10,2] = "2"

Lettere[11,0] = "L"
Lettere[11,1] = "11"
Lettere[11,2] = "4"

Lettere[12,0] = "M"
Lettere[12,1] = "12"
Lettere[12,2] = "18"

Lettere[13,0] = "N"
Lettere[13,1] = "13"
Lettere[13,2] = "20"

Lettere[14,0] = "O"
Lettere[14,1] = "14"
Lettere[14,2] = "11"

Lettere[15,0] = "P"
Lettere[15,1] = "15"
Lettere[15,2] = "3"

Lettere[16,0] = "Q"
Lettere[16,1] = "16"
Lettere[16,2] = "6"

Lettere[17,0] = "R"
Lettere[17,1] = "17"
Lettere[17,2] = "8"

Lettere[18,0] = "S"
Lettere[18,1] = "18"
Lettere[18,2] = "12"

Lettere[19,0] = "T"
Lettere[19,1] = "19"
Lettere[19,2] = "14"

Lettere[20,0] = "U"
Lettere[20,1] = "20"
Lettere[20,2] = "16"

Lettere[21,0] = "V"
Lettere[21,1] = "21"
Lettere[21,2] = "10"

Lettere[22,0] = "W"
Lettere[22,1] = "22"
Lettere[22,2] = "22"

Lettere[23,0] = "X"
Lettere[23,1] = "23"
Lettere[23,2] = "25"

Lettere[24,0] = "Y"
Lettere[24,1] = "24"
Lettere[24,2] = "24"

Lettere[25,0] = "Z"
Lettere[25,1] = "25"
Lettere[25,2] = "23"

Lettere[26,0] = "0"
Lettere[26,1] = "0"
Lettere[26,2] = "1"

Lettere[27,0] = "1"
Lettere[27,1] = "1"
Lettere[27,2] = "0"

Lettere[28,0] = "2"
Lettere[28,1] = "2"
Lettere[28,2] = "5"

Lettere[29,0] = "3"
Lettere[29,1] = "3"
Lettere[29,2] = "7"

Lettere[30,0] = "4"
Lettere[30,1] = "4"
Lettere[30,2] = "9"

Lettere[31,0] = "5"
Lettere[31,1] = "5"
Lettere[31,2] = "13"

Lettere[32,0] = "6"
Lettere[32,1] = "6"
Lettere[32,2] = "15"

Lettere[33,0] = "7"
Lettere[33,1] = "7"
Lettere[33,2] = "17"

Lettere[34,0] = "8"
Lettere[34,1] = "8"
Lettere[34,2] = "19"

Lettere[35,0] = "9"
Lettere[35,1] = "9"
Lettere[35,2] = "21"

For I = 0 To 25

    ConfrontoCarattereControllo[I] = CharA(65 + I)  //creo in ConfrontoCarattereControllo tutte le lettere maiuscole dalla A (chr(65)) alla Z(chr(90))

end for

Carattere=0
ValorePari=1  //indice della seconda colonna della matrice Lettere
ValoreDispari=2 //indice della terza colonna della matrice Lettere
SommaCaratteri=0

CarattereControllo=RightA(CodiceFiscale,1)

for I=1 to lenA(CodiceFiscale)-1
	if mod(I, 2)=0 then
	  PariDispari="P"
	else
	  PariDispari="D"
	end if
	
	Temp =midA(CodiceFiscale,I,1)
	J=0
	do
	  Test=Lettere[J,Carattere]
	  J=J+1
	loop until Temp=Test
	J= J - 1
	
	if PariDispari="P" then
	  SommaCaratteri=SommaCaratteri + Integer(Lettere[J,ValorePari])
	else
	  SommaCaratteri=SommaCaratteri + Integer(Lettere[J,ValoreDispari])
	end if
end for

Risultato=mod(SommaCaratteri, 26)

RisultatoX=ConfrontoCarattereControllo[Risultato]

if RisultatoX<>CarattereControllo then
//--- "Si è verificato un errore"
	kst_esito.esito =  kkg_esito.err_formale
	kst_esito.sqlerrtext = "Codice Fiscale non corretto " 
else
// --- Response.write "CodiceFiscale: " & Risultato
	kst_esito.esito = kkg_esito.ok

end if


return kst_esito







end function

public function st_esito check_cf (st_tab_clienti kst_tab_clienti);//---
//--- Controllo del Codice Fiscale
//--- Input:  st_tab_clienti = con il  'CF = Codice Fiscale'  valorizzato
//---Out: st_esito come da standard
//---
//-----------------------------------------------------------------------------------------------------------
//--- Questa routine lancia il controllo sul codice fiscale x Persone Fisiche e Altri (Giuridiche o Provvisorie ....) 
//-----------------------------------------------------------------------------------------------------------
//
//Per verificare se il controllo deve  essere 'Persone Fisiche' tengo conto che questa deve essere lunga  16 caratteri
//
//-----------------------------------------------------------------------------------------------------------

st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_clienti.cf)) > 0 then

	if len(trim(kst_tab_clienti.cf)) = 16 then
		
		kst_esito = check_cf_persona_fisica(	kst_tab_clienti) 

	else
		if len(trim(kst_tab_clienti.cf)) = 11 then
			kst_esito = check_cf_altro(	kst_tab_clienti) 
		else
			kst_esito.esito =  kkg_esito.err_formale
			kst_esito.sqlerrtext = "Numero caratteri Codice Fiscale non corretto (" + string (len(trim(kst_tab_clienti.cf))) + ").  "
		end if
	end if
else
	kst_esito.esito =  kkg_esito.err_formale
	kst_esito.sqlerrtext = "Nessun Codice Fiscale indicato. "
end if

return kst_esito







end function

public function st_esito check_cf_altro (st_tab_clienti kst_tab_clienti);//---
//-----------------------------------------------------------------------------------------------------------
//--- Controllo Codice fiscale x Persone Giuridiche o Provvisorie ecc....  (diversa da Persona Fisica) 
//---
//--- Input:  struttura  st_tab_clienti  con il  'CF = Codice Fiscale'  valorizzato
//--- Out: st_esito come da standard
//---
//-----------------------------------------------------------------------------------------------------------
//--- Spiegazione Controlli effettuati 
//-----------------------------------------------------------------------------------------------------------
//--- deve essere composto da MATRICOLA (7 numeri) + UFFICIO (3 numeri) + CIN (1 numero)
//--- UFFICIO  valori ammessi: 0-100, 120, 121, 151-245, 301-766, 900-950, 999
//--- se MATRICOLA = 8000000 allora UFFICIO = 001-095
//--- se UFFICIO = 000 allora MATRICOLA = 1-273960 (e nessun check su carattere di controllo) o 400001-1072480 o 1500001-1828636 o 2000001-2054095
//--- Infine il carattere di controllo di 1 numerico:
//---   sommare le cifre dispari (che sono ovviamente 5)
//---   raddoppiare le cifre pari se ogni risultato e' > 9 togliere 9  (16 = 16 - 9) poi sommare tutti i risultati
//---   sommare le due somme precedenti, poi togliere 10 all'unita' della precedente somma
//---   il carattere di controllo e' la cifra relativa all'unita' del risultato
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

st_esito kst_esito
string k_cf, k_cin_calcolato, k_cin
int k_matr, k_uff
int k_somma_dei_pari, k_somma_dei_dispari, k_ctr, k_somma_tot, k_somma_appo
boolean k_controlla_cin


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if isnumber(trim(kst_tab_clienti.cf))  then

	k_cf =  trim(kst_tab_clienti.cf)
	k_matr = integer(left(kst_tab_clienti.cf, 7))
	k_uff = integer(mid(kst_tab_clienti.cf, 8,3))
	k_cin = (mid(kst_tab_clienti.cf, 11,1))
	
	if k_uff < 100 or (k_uff = 120) or (k_uff = 121) or (k_uff >= 151 and k_uff <= 245) or (k_uff >= 301 and k_uff <= 766) &
			or (k_uff >= 900 and k_uff <= 950) or (k_uff = 999) then
		
		if k_matr >= 8000000 then
			if (k_uff >= 001 and k_uff <= 095) then
				k_controlla_cin = true
			else
				k_controlla_cin = false
				kst_esito.esito =  kkg_esito.err_formale
				kst_esito.sqlerrtext = "Codice Fiscale errato, cod. Ufficio ("+ string (k_uff) +") anomalo per Matricola (" + string (k_matr) + ").  "
			end if
		else
			if k_uff = 0 then
				if k_matr >= 1 and k_matr <= 273960 then
					k_controlla_cin = false
				else
					if (k_matr >= 400001 and k_matr <= 1072480) or (k_matr >= 1500001 and k_matr <= 1828636) or (k_matr >= 2000001 and k_matr <= 2054095) then
						k_controlla_cin = true
					else
						kst_esito.esito =  kkg_esito.err_formale
						kst_esito.sqlerrtext = "Codice Fiscale errato, cod. Ufficio a "+ string (k_uff) +" anomalo per Matricola (" + string (k_matr) + ").  "
					end if
				end if
			else
				k_controlla_cin = true
			end if
		end if
	else
		k_controlla_cin = false
		kst_esito.esito =  kkg_esito.err_formale
		kst_esito.sqlerrtext = "Codice Fiscale errato, cod. Ufficio "+ string (k_uff) +" anomalo.  "
	end if

//--- Controllo CIN		
	if k_controlla_cin then
	
//---- tratto la parte pari (che qui e' dispari xche' l'array parte da 1)
		k_somma_dei_pari = 0
		for k_ctr = 1 to 9 step +2 
			
			k_somma_dei_pari += integer(Mid(k_cf,k_ctr,1))
			
		end for
	
	//---- tratto la parte DISPARI (che qui e' pari xche' l'array parte da 1)
		k_somma_dei_dispari = 0
		for k_ctr = 2 to 10 step +2  
	
			k_somma_appo = integer(Mid(k_cf, k_ctr, 1)) * 2
			if k_somma_appo > 9 then k_somma_appo -= 9
			
			k_somma_dei_dispari += k_somma_appo
			
		end for
	
		k_somma_tot = k_somma_dei_pari + k_somma_dei_dispari
	
		k_cin_calcolato = string(10 - integer(right(trim(string(k_somma_tot)), 1)))
		
		if k_cin_calcolato <> k_cin then
			kst_esito.esito = kkg_esito.err_formale
			kst_esito.SQLErrText = "Codice Fiscale (CIN) " + k_cf +" errato. "
		end if
	

		
	end if
	
else
	kst_esito.esito =  kkg_esito.err_formale
	kst_esito.sqlerrtext = "Codice Fiscale (non Persona Fisica) "+ k_cf +" errato. "
end if

return kst_esito







end function

public function st_esito get_nr_riceventi (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta i RICEVENTI per il codice Mandante/Fatturato passato nel kst_tab_clienti.codice
//=== 
//=== OUT: kst_tab_clienti.contati = numero Riceventi Trovati
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.contati = 0
	
   SELECT   count(distinct clie_2)
       into :kst_tab_clienti.contati
		 FROM m_r_f
			where clie_2 <> :kst_tab_clienti.codice and (clie_1 = :kst_tab_clienti.codice or clie_3 =  :kst_tab_clienti.codice) 
			using sqlca;
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Clienti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if




return kst_esito




end function

public function st_esito get_nr_mandanti (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta i mandanti per il codice Ricevente/Fatturato passato nel kst_tab_clienti.codice
//=== 
//=== OUT: kst_tab_clienti.contati = numero mandanti Trovati
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.contati = 0
	
   SELECT   count(distinct clie_1)
       into  :kst_tab_clienti.contati
		 FROM m_r_f
			where clie_1 <> :kst_tab_clienti.codice and (clie_2 = :kst_tab_clienti.codice or clie_3 =  :kst_tab_clienti.codice) 
			using sqlca;
	
	
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Clienti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if




return kst_esito




end function

public function st_esito get_nr_fatturati (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta i fatturati per il codice Ricevente/Mandante passato nel kst_tab_clienti.codice
//=== 
//=== OUT: kst_tab_clienti.contati = numero fatturati Trovati
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.contati = 0
	
   SELECT   count(distinct clie_3)
       into  :kst_tab_clienti.contati
		 FROM m_r_f
			where clie_3 <> :kst_tab_clienti.codice and (clie_2 = :kst_tab_clienti.codice or clie_1 =  :kst_tab_clienti.codice) 
			using sqlca;
	
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Clienti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if




return kst_esito




end function

public function st_esito tb_update (st_tab_clienti_fatt kst_tab_clienti_fatt);//
//====================================================================
//=== Aggiunge rek nella tabella DATI di FATTURAZIONE
//=== 
//=== Input: st_tab_clienti_fatt 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_fatt.id_cliente > 0 then
	
	kst_tab_clienti_fatt.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_fatt.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_clienti_fatt.fattura_da) then
		kst_tab_clienti_fatt.fattura_da = kki_fattura_da_bolla
	end if
	if isnull(kst_tab_clienti_fatt.note_1) then
		kst_tab_clienti_fatt.note_1 = " "
	end if
	if isnull(kst_tab_clienti_fatt.note_2) then
		kst_tab_clienti_fatt.note_2 = " "
	end if
	
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Fatturazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
		
		k_rcn = 0
		select distinct 1
			into :k_rcn
			from clienti_fatt
			WHERE clienti_fatt.id_cliente = :kst_tab_clienti_fatt.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode  >= 0 then
			
			if k_rcn > 0 then
				UPDATE clienti_fatt  
				  SET fattura_da = :kst_tab_clienti_fatt.fattura_da,   
						note_1 = :kst_tab_clienti_fatt.note_1,   
						note_2 = :kst_tab_clienti_fatt.note_2 , 
						modo_stampa = :kst_tab_clienti_fatt.modo_stampa , 
						modo_email = :kst_tab_clienti_fatt.modo_email , 
						email_invio = :kst_tab_clienti_fatt.email_invio , 
						impon_minimo = :kst_tab_clienti_fatt.impon_minimo , 
						codice_ipa = :kst_tab_clienti_fatt.codice_ipa , 
						x_datins = :kst_tab_clienti_fatt.x_datins,  
						x_utente = :kst_tab_clienti_fatt.x_utente  
					WHERE id_cliente = :kst_tab_clienti_fatt.id_cliente 
					using sqlca;
					
			else
				
				INSERT INTO clienti_fatt  
							( id_cliente,   
							  fattura_da,   
							  note_1,   
							  note_2,   
							  modo_stampa,   
							  modo_email,   
							  email_invio,   
							  impon_minimo,   
							  codice_ipa,   
							  x_datins,   
							  x_utente )  
					  VALUES ( :kst_tab_clienti_fatt.id_cliente,   
							  :kst_tab_clienti_fatt.fattura_da,   
							  :kst_tab_clienti_fatt.note_1,   
							  :kst_tab_clienti_fatt.note_2,   
							  :kst_tab_clienti_fatt.modo_stampa,   
							  :kst_tab_clienti_fatt.modo_email,   
							  :kst_tab_clienti_fatt.email_invio,   
							  :kst_tab_clienti_fatt.impon_minimo,   
							  :kst_tab_clienti_fatt.codice_ipa,   
							  :kst_tab_clienti_fatt.x_datins,   
							  :kst_tab_clienti_fatt.x_utente )  
					using sqlca;
			end if
			
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Fatturazione:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Fatturazione: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito tb_delete (st_tab_clienti_fatt kst_tab_clienti_fatt);//
//====================================================================
//=== Cancella rek nella tabella DATI di FATTURAZIONE
//=== 
//=== Input: st_tab_clienti_fatt 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_fatt.id_cliente > 0 then
	
	kst_tab_clienti_fatt.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_fatt.x_utente = kGuf_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione dati Fatturazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		delete 
			from clienti_fatt
			WHERE clienti_fatt.id_cliente = :kst_tab_clienti_fatt.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Fatturazione:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Fatturazione: nessun dato cancellato (codice cliente non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function string tb_delete_ind_comm (st_tab_ind_comm kst_tab_ind_comm);//
//====================================================================
//=== Cancella il rek dalla tabella INDIRIZZI clienti
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
long k_num
date k_data

boolean k_rc
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w



kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_rc then

	k_return = "1" + "Cancellazione Indirizzo Commerciale non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"

else

	
	delete from ind_comm
			where clie_c = :kst_tab_ind_comm.clie_c ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText
	else
		
		if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if

	end if

end if

return k_return
end function

public function string tb_delete_m_r_f (st_tab_clienti_m_r_f kst_tab_clienti_m_r_f);//
//====================================================================
//=== Cancella il rek dalla tabella M-R-F legame Anagrafiche
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
	

boolean k_rc
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w



kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_rc then

	k_return = "1" + "Cancellazione Legame mandante-ricevente-cliente non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"

else


	delete from m_r_f
			where  clie_1 = :kst_tab_clienti_m_r_f.clie_1
			     and clie_2 = :kst_tab_clienti_m_r_f.clie_2
			     and clie_3 = :kst_tab_clienti_m_r_f.clie_3;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText

	else
		
		if kst_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
		
	end if

end if

return k_return
end function

public function st_esito get_ultimo_id (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Torna l'ultimo CODICE caricato 
//=== 
//=== Input: st_tab_clienti non valorizzata     Output: st_tab_clienti.codice                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.codice = 0
	
   SELECT   max(clienti.codice)
       into :kst_tab_clienti.codice
		 FROM clienti
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Clienti (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
	end if




return kst_esito




end function

public function st_esito get_nome (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il nome
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.rag_soc_10/ rag_soc_20       
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT   
		  CLIENTI.RAG_SOC_10,
		  CLIENTI.RAG_SOC_11
    INTO 
	 	  :kst_tab_clienti.rag_soc_10,   
           :kst_tab_clienti.rag_soc_11
        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using  kguo_sqlca_db_magazzino;


	if  kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode =  kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim( kguo_sqlca_db_magazzino.SQLErrText)
		if  kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if  kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if

	if_isnull(kst_tab_clienti)  // toglie i null

	

return kst_esito

end function

public function st_esito get_p_iva (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire l campo P_IVA
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//===                   e st_tab_clenti.p_iva e cf
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
		  CLIENTI.P_IVA,
		  CLIENTI.CF
    INTO 
           :kst_tab_clienti.p_iva , 
           :kst_tab_clienti.cf 
        FROM clienti 
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_clienti.p_iva) then kst_tab_clienti.p_iva = "" 
		if isnull(kst_tab_clienti.cf) then kst_tab_clienti.cf = "" 
				
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if


return kst_esito

end function

public function st_esito get_tipo_banca (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge il TIPO BANCA del Cliente
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.tipo_banca
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		  CLIENTI.tipo_banca
    INTO 
	 	  :kst_tab_clienti.tipo_banca
        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if

	if_isnull(kst_tab_clienti)  // toglie i null

	

return kst_esito

end function

public function st_esito get_esenzione_iva (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il campo ESENZIONE IVA
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//===                   e st_tab_clenti.iva, date 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
		  CLIENTI.IVA
           ,clienti.iva_esente_imp_max
           ,clienti.iva_esente_imp_min_x_fatt
           ,clienti.iva_valida_dal
           ,clienti.iva_valida_al
    INTO 
           :kst_tab_clienti.iva 
           ,:kst_tab_clienti.iva_esente_imp_max
           ,:kst_tab_clienti.iva_esente_imp_min_x_fatt
           ,:kst_tab_clienti.iva_valida_dal
           ,:kst_tab_clienti.iva_valida_al
        FROM clienti 
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.not_fnd
	else
		if sqlca.sqlcode >= 0 then
			if isnull(kst_tab_clienti.iva) then kst_tab_clienti.iva = 0
			if isnull(kst_tab_clienti.iva_esente_imp_max) then kst_tab_clienti.iva_esente_imp_max = 0 
			if isnull(kst_tab_clienti.iva_esente_imp_min_x_fatt) then kst_tab_clienti.iva_esente_imp_min_x_fatt = 0 
			if isnull(kst_tab_clienti.iva_valida_dal) then kst_tab_clienti.iva_valida_dal = date(0) 
			if isnull(kst_tab_clienti.iva_valida_al) then kst_tab_clienti.iva_valida_al = date(0) 
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
		
	end if


return kst_esito

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc=0, k_riga=0
string k_rcx=""
boolean k_return=true
st_tab_clienti kst_tab_clienti
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_clienti_web kst_tab_clienti_web
st_tab_m_r_f kst_tab_m_r_f
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_elenco kuf1_elenco
kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_riga = adw_link.getrow()
if k_riga > 0 then
	
	choose case a_campo_link
	
		case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente" , "id_cliente_link" 
			k_rcx = adw_link.describe(trim(a_campo_link) + ".visible")  // controllo se il campo e' presente sul dw (dovrebbe esserlo SEMPRE!!)
			if k_rcx <> "!" and k_rcx <> "?" then
				kst_tab_clienti.codice = adw_link.getitemnumber(k_riga, a_campo_link)
				if kst_tab_clienti.codice > 0 then
					kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_clienti )
					if kst_esito.esito <> kkg_esito.ok then
						kguo_exception.inizializza()
						kguo_exception.set_esito( kst_esito)
						throw kguo_exception
					end if
					kst_open_w.key1 = "Anagrafica  (codice=" + trim(string(kst_tab_clienti.codice)) + ") " 
				else
					k_return = false
				end if
			else
				k_return = false
			end if
			
		case "id_contatto_1", "id_contatto_2", "id_contatto_3", "id_contatto_4", "id_contatto_5"    
			kst_tab_clienti.codice = adw_link.getitemnumber(k_riga, a_campo_link)
			if kst_tab_clienti.codice > 0 then
				kst_esito = this.anteprima_elenco_contatti( kdsi_elenco_output, kst_tab_clienti )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Anagrafica  (codice=" + trim(string(kst_tab_clienti.codice)) + ") " 
			else
				k_return = false
			end if
			
		case "b_cliente_mkt"
			kst_tab_clienti_mkt.id_cliente = adw_link.getitemnumber(k_riga, "id_cliente")
			if kst_tab_clienti_mkt.id_cliente > 0 then
				kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_clienti_mkt )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Dati MKT dell'anagrafica, codice=" + trim(string(kst_tab_clienti_mkt.id_cliente)) + " " 
			else
				k_return = false
			end if
			
		case "b_cliente_web"
			kst_tab_clienti_web.id_cliente = adw_link.getitemnumber(k_riga, "id_cliente")
			if kst_tab_clienti_web.id_cliente > 0 then
				kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_clienti_web )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Dati WEB dell'anagrafica, codice=" + trim(string(kst_tab_clienti_web.id_cliente)) + " " 
			else
				k_return = false
			end if
			
		case "b_m_r_f"
			kst_tab_m_r_f.clie_3 = adw_link.getitemnumber(k_riga, "id_cliente")
			if kst_tab_m_r_f.clie_3 > 0 then
				kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_m_r_f )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Legami Mandanti-Riceventi dell'anagrafica, codice=" + trim(string(kst_tab_m_r_f.clie_3)) + " " 
			else
				k_return = false
			end if
			
		case "b_elenco_clienti_del_contatto"
			kst_tab_clienti.codice = adw_link.getitemnumber(k_riga, "id_cliente")
			if kst_tab_clienti.codice > 0 then
				kst_esito = this.anteprima_elenco_clienti_del_contatto( kdsi_elenco_output, kst_tab_clienti )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Clienti del Contatto codice=" + trim(string(kst_tab_clienti.codice)) + " " 
			else
				k_return = false
			end if
			
		case "b_clienti"   // elenco clienti
			kst_tab_clienti.codice =  0 
			kdsi_elenco_output.dataobject = "d_clienti_l_rag_soc"
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_clienti )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza()
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Elenco Anagrafiche " 
	
		case "email", "email1", "email2", "email3" 
			kst_tab_clienti_web.email = trim(adw_link.getitemstring(k_riga, a_campo_link))
			if len(kst_tab_clienti_web.email) > 0 then
				kuf1_web = create kuf_web 
				if not kuf1_web.u_call_mail_client(kst_tab_clienti_web.email, "", "", "") then
					kst_esito.esito = kkg_esito.no_esecuzione
					kst_esito.sqlerrtext = "Applicazione di Posta non Trovata!"
				end if
				destroy kuf1_web
	//			kst_esito = this.anteprima_elenco_clienti_del_contatto( kdsi_elenco_output, kst_tab_clienti )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
	//			kst_open_w.key1 = "Clienti del Contatto codice=" + trim(string(kst_tab_clienti.codice)) + " " 
				k_return = false
			else
				k_return = false
			end if
			
		case "sito_web", "sito_web1" 
			kst_tab_clienti_web.sito_web = trim(adw_link.getitemstring(k_riga, a_campo_link))
			if len(kst_tab_clienti_web.sito_web) > 0 then
				try 
					kuf1_web = create kuf_web 
					kuf1_web.u_start_www(kst_tab_clienti_web.sito_web) 
				catch (uo_exception kuo_exception1)
	//				kuo_exception.set_esito( kst_esito)
					throw kuo_exception1
				finally
					destroy kuf1_web
				end try
				k_return = false
			else
				k_return = false
			end if
			
		case "p_clienti_memo_elenco"
			kst_tab_clienti.codice = adw_link.getitemnumber(k_riga, "id_cliente")
			if kst_tab_clienti.codice > 0 then
				kst_esito = this.anteprima_elenco_memo( kdsi_elenco_output, kst_tab_clienti )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza()
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Fascicoli Memo Anagrafica=" + trim(string(kst_tab_clienti.codice)) + " " 
			else
				k_return = false
			end if
	
	end choose
	
	if k_return then
	
		if kdsi_elenco_output.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_elenco = create kuf_elenco 
			kuf1_elenco.u_open(kst_open_w)
			destroy kuf1_elenco
	
	
		else
			
			kguo_exception.inizializza()
			kguo_exception.setmessage( "Nessun valore disponibile. " )
			throw kguo_exception
			
			
		end if
	end if
end if

SetPointer(kp_oldpointer)



return k_return

end function

public function integer if_presente_id_clie_settore (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//====================================================================
//=== Torna > 0 se CODICE SETTORE trovato su alemeno 1 cliente  
//=== 
//=== Input: st_tab_clienti con valorizzato id_clie_settore    Output: 0=non usato >0 usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
int k_return = 0
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM clienti
		 where id_clie_settore = :kst_tab_clienti.id_clie_settore
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Clienti ~n~r:" + trim(sqlca.SQLErrText)
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


if isnull(k_return) then k_return = 0

return k_return





end function

public function integer if_presente_id_clie_classe (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//====================================================================
//=== Torna > 0 se CODICE CLASSE trovato su alemeno 1 cliente  
//=== 
//=== Input: st_tab_clienti con valorizzato id_clie_classe    Output: 0=non usato >0 usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
int k_return = 0
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM clienti
		 where id_clie_classe = :kst_tab_clienti.id_clie_classe
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Clienti ~n~r:" + trim(sqlca.SQLErrText)
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


if isnull(k_return) then k_return = 0

return k_return





end function

public function st_esito get_indirizzi (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire Intestaione e Idirizzo a fare le fatture
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//===          torna i campi st_tab_clenti.rag_soc_10/ rag_soc_20/ indi_1 /loc_1 ecc...
//===          e kst_tab_ind_comm valorizzati con l'indirizzo di spedizione fattura             
//=== 
//====================================================================
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()




  SELECT   clienti.codice ,
		  CLIENTI.P_IVA,
		  CLIENTI.CF,
		  CLIENTI.RAG_SOC_10,
		  CLIENTI.RAG_SOC_11,
		  CLIENTI.INDI_1,
		  CLIENTI.CAP_1,
		  CLIENTI.LOC_1,
		  CLIENTI.PROV_1,
		  CLIENTI.SPE_INC,
		  CLIENTI.SPE_BOLLO,
		  CLIENTI.BANCA,
		  CLIENTI.ABI,
		  CLIENTI.CAB,
		  CLIENTI.id_nazione_1,
		  nazioni.nome,
           ind_comm.rag_soc_1_c,
           ind_comm.rag_soc_2_c,
           ind_comm.indi_c,
           ind_comm.cap_c ,
           ind_comm.loc_c,
           ind_comm.prov_c,
           ind_comm.id_nazione_c,
           ind_comm.clie_c
    INTO 
	 	  :kst_tab_clienti.codice,
           :kst_tab_clienti.p_iva , 
           :kst_tab_clienti.cf , 
	 	  :kst_tab_clienti.rag_soc_10,   
           :kst_tab_clienti.rag_soc_11,   
		  :kst_tab_clienti.indi_1,   
           :kst_tab_clienti.cap_1,   
           :kst_tab_clienti.loc_1,   
           :kst_tab_clienti.prov_1,   
		  :kst_tab_clienti.SPE_INC,
		  :kst_tab_clienti.SPE_BOLLO,
		  :kst_tab_clienti.BANCA,
		  :kst_tab_clienti.ABI,
		  :kst_tab_clienti.CAB,
		  :kst_tab_clienti.id_nazione_1,
           :kst_tab_clienti.kst_tab_nazioni.nome ,
           :kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c,
           :kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c,
           :kst_tab_clienti.kst_tab_ind_comm.indi_c,
           :kst_tab_clienti.kst_tab_ind_comm.cap_c ,
           :kst_tab_clienti.kst_tab_ind_comm.loc_c,
           :kst_tab_clienti.kst_tab_ind_comm.prov_c,
           :kst_tab_clienti.kst_tab_ind_comm.id_nazione_c,
           :kst_tab_clienti.kst_tab_ind_comm.clie_c
        FROM (clienti left outer join ind_comm on
              clienti.codice = ind_comm.clie_c)   left outer join nazioni on   
              clienti.id_nazione_1 = nazioni.id_nazione     
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
//--- elimina la descrizione ITALIA perchè inutile e non voluta dalle POSTE IT		
		if lower(trim(kst_tab_clienti.kst_tab_nazioni.nome)) = "italy" &
				or lower(trim(kst_tab_clienti.kst_tab_nazioni.nome)) = "italia" then
			kst_tab_clienti.kst_tab_nazioni.nome = " "
		end if
		
//--- Se NON valorizzato l'ndirizzo Commerciale copia i valori dai campi base del cliente				
		if len(trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c)) > 0 &
		  			or len(trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c)) > 0  then
			//--- lascia tutto come sta altrimenti muove l'intestazione nell'indir. commerciale
		else
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c = kst_tab_clienti.rag_soc_10   
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c = kst_tab_clienti.rag_soc_11   
			kst_tab_clienti.kst_tab_ind_comm.indi_c = kst_tab_clienti.indi_1   
			kst_tab_clienti.kst_tab_ind_comm.cap_c = kst_tab_clienti.cap_1   
			kst_tab_clienti.kst_tab_ind_comm.loc_c = kst_tab_clienti.loc_1   
			kst_tab_clienti.kst_tab_ind_comm.prov_c = kst_tab_clienti.prov_1   
			kst_tab_clienti.kst_tab_ind_comm.id_nazione_c = kst_tab_clienti.id_nazione_1   
		end if		
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if

	if_isnull(kst_tab_clienti)  // toglie i null

	



return kst_esito

end function

public function st_esito tb_delete (st_tab_clienti_mkt kst_tab_clienti_mkt);//
//====================================================================
//=== Cancella rek nella tabella DATI di MARKETING
//=== 
//=== Input: st_tab_clienti_fatt 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_mkt.id_cliente > 0 then
	
	kst_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione dati Marketing non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		delete 
			from clienti_mkt
			WHERE id_cliente = :kst_tab_clienti_mkt.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Mkt-Cliente:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Marketing: nessun dato cancellato (codice Anagrafica non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito tb_delete (st_tab_clienti_web kst_tab_clienti_web);//
//====================================================================
//=== Cancella rek nella tabella DATI di MARKETING
//=== 
//=== Input: st_tab_clienti_fatt 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_web.id_cliente > 0 then
	
	kst_tab_clienti_web.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_web.x_utente = kGuf_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione dati 'WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		delete 
			from clienti_web
			WHERE id_cliente = :kst_tab_clienti_web.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati WEB-Anagrafica:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati 'Web': nessun dato cancellato (codice Anagrafica non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito tb_update (st_tab_clienti_mkt kst_tab_clienti_mkt);//
//====================================================================
//=== Aggiunge rek nella tabella DATI di MARKETING
//=== 
//=== Input: st_tab_clienti_mkt 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati=false
st_esito kst_esito
st_open_w kst_open_w
st_tab_clienti kst_tab_clienti


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_mkt.id_cliente > 0 then

	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Fatturazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else

		
		kst_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()
	
		kst_tab_clienti.kst_tab_clienti_mkt = kst_tab_clienti_mkt
		this.if_isnull( kst_tab_clienti )
		kst_tab_clienti_mkt = kst_tab_clienti.kst_tab_clienti_mkt

		k_rcn = 0
		select distinct 1
			into :k_rcn
			from clienti_mkt
			WHERE id_cliente = :kst_tab_clienti_mkt.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode  >= 0 then

//--- controllo se ci sono dati
			if len(trim(kst_tab_clienti.kst_tab_clienti_mkt.altra_sede)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.tipo_rapporto)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.cod_atecori)) > 0 & 
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_1_qualif)) > 0 & 
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_2_qualif)) > 0 &
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_3_qualif)) > 0 &
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_4_qualif)) > 0 &
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.contatto_5_qualif)) > 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1 <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2 <> 0  &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_cliente_link  <> 0 &
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.note_attivita)) > 0 &
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.note_prodotti)) > 0 & 
			      or kst_tab_clienti.kst_tab_clienti_mkt.gruppo > 0 & 
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta)) > 0 & 
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.doc_esporta_prefpath)) > 0 & 
			      or len(trim(kst_tab_clienti.kst_tab_clienti_mkt.qualifica)) > 0 then
			
				k_senza_dati = false
			else
				k_senza_dati = true
			end if
			
			if k_rcn > 0 then
				
				if k_senza_dati then //allora non serve quindi lo  cancello
					delete from clienti_mkt  
						WHERE id_cliente = :kst_tab_clienti_mkt.id_cliente 
						using sqlca;
				else
					
					UPDATE clienti_mkt  
					  SET 
							altra_sede = :kst_tab_clienti_mkt.altra_sede 
							,cod_atecori = :kst_tab_clienti_mkt.cod_atecori 
							,tipo_rapporto = :kst_tab_clienti_mkt.tipo_rapporto 
							,contatto_1_qualif = :kst_tab_clienti_mkt.contatto_1_qualif
							,contatto_2_qualif = :kst_tab_clienti_mkt.contatto_2_qualif
							,contatto_3_qualif = :kst_tab_clienti_mkt.contatto_3_qualif 
							,contatto_4_qualif = :kst_tab_clienti_mkt.contatto_4_qualif 
							,contatto_5_qualif = :kst_tab_clienti_mkt.contatto_5_qualif 
							,id_contatto_1 = :kst_tab_clienti_mkt.id_contatto_1 
							,id_contatto_2 = :kst_tab_clienti_mkt.id_contatto_2 
							,id_contatto_3 = :kst_tab_clienti_mkt.id_contatto_3 
							,id_contatto_4 = :kst_tab_clienti_mkt.id_contatto_4 
							,id_contatto_5 = :kst_tab_clienti_mkt.id_contatto_5 
							,id_cliente_link = :kst_tab_clienti_mkt.id_cliente_link 
							,note_attivita = :kst_tab_clienti_mkt.note_attivita 
							,note_prodotti = :kst_tab_clienti_mkt.note_prodotti 
							,qualifica = :kst_tab_clienti_mkt.qualifica 
							,gruppo = :kst_tab_clienti_mkt.gruppo 
							,doc_esporta = :kst_tab_clienti_mkt.doc_esporta 
							,doc_esporta_prefpath = :kst_tab_clienti_mkt.doc_esporta_prefpath
							,x_datins = :kst_tab_clienti_mkt.x_datins
							,x_utente = :kst_tab_clienti_mkt.x_utente  
						WHERE id_cliente = :kst_tab_clienti_mkt.id_cliente 
						using sqlca;
				end if						
			else
				
				if NOT k_senza_dati then //registra solo se contiene dati
					INSERT INTO clienti_mkt 
							(
							id_cliente
							,altra_sede 
							,tipo_rapporto
							,cod_atecori
							,contatto_1_qualif
							,contatto_2_qualif
							,contatto_3_qualif 
							,contatto_4_qualif 
							,contatto_5_qualif 
							,id_contatto_1
							,id_contatto_2 
							,id_contatto_3 
							,id_contatto_4 
							,id_contatto_5 
							,id_cliente_link 
							,note_attivita 
							,note_prodotti 
							,qualifica 
							,gruppo 
							,doc_esporta
							,doc_esporta_prefpath
							,x_datins 
							,x_utente 
							 )  
					  VALUES ( 
						 :kst_tab_clienti_mkt.id_cliente 
						,:kst_tab_clienti_mkt.tipo_rapporto 
						,:kst_tab_clienti_mkt.altra_sede 
						,:kst_tab_clienti_mkt.cod_atecori 
						,:kst_tab_clienti_mkt.contatto_1_qualif
						,:kst_tab_clienti_mkt.contatto_2_qualif
						,:kst_tab_clienti_mkt.contatto_3_qualif 
						,:kst_tab_clienti_mkt.contatto_4_qualif 
						,:kst_tab_clienti_mkt.contatto_5_qualif 
						,:kst_tab_clienti_mkt.id_contatto_1 
						,:kst_tab_clienti_mkt.id_contatto_2 
						,:kst_tab_clienti_mkt.id_contatto_3 
						,:kst_tab_clienti_mkt.id_contatto_4 
						,:kst_tab_clienti_mkt.id_contatto_5 
						,:kst_tab_clienti_mkt.id_cliente_link 
						,:kst_tab_clienti_mkt.note_attivita 
						,:kst_tab_clienti_mkt.note_prodotti 
						,:kst_tab_clienti_mkt.qualifica 
						,:kst_tab_clienti_mkt.gruppo 
						,:kst_tab_clienti_mkt.doc_esporta 
						,:kst_tab_clienti_mkt.doc_esporta_prefpath
						,:kst_tab_clienti_mkt.x_datins
						,:kst_tab_clienti_mkt.x_utente  
							  )  
					using sqlca;
					
				end if
			end if
			
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Marketing:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Marketing: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito tb_update (st_tab_clienti_web kst_tab_clienti_web);//
//====================================================================
//=== Aggiunge rek nella tabella DATI di WWW
//=== 
//=== Input: st_tab_clienti_web 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati
st_esito kst_esito
st_open_w kst_open_w
st_tab_clienti kst_tab_clienti


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_web.id_cliente > 0 then

	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Web non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else

		
		kst_tab_clienti_web.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_clienti_web.x_utente = kGuf_data_base.prendi_x_utente()
	
		kst_tab_clienti.kst_tab_clienti_web = kst_tab_clienti_web
		this.if_isnull( kst_tab_clienti )
		kst_tab_clienti_web = kst_tab_clienti.kst_tab_clienti_web

		k_rcn = 0
		select distinct 1
			into :k_rcn
			from clienti_web
			WHERE id_cliente = :kst_tab_clienti_web.id_cliente 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode  >= 0 then

//--- controllo se ci sono dati
			if len(trim(kst_tab_clienti.kst_tab_clienti_web.blog_web)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.blog_web1)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email1)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email2)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.email3)) > 0 & 
				  or kst_tab_clienti.kst_tab_clienti_web.email_prontomerce > 0 &
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.note)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.sito_web)) > 0 & 
				  or len(trim(kst_tab_clienti.kst_tab_clienti_web.sito_web1)) > 0 & 
			       then
			
				k_senza_dati = false
			else
				k_senza_dati = true
			end if
			
			
			if k_rcn > 0 then
				UPDATE clienti_web  
				  SET 
						blog_web = :kst_tab_clienti_web.blog_web 
						,blog_web1 = :kst_tab_clienti_web.blog_web1 
						,email = :kst_tab_clienti_web.email 
						,email1 = :kst_tab_clienti_web.email1 
						,email2 = :kst_tab_clienti_web.email2 
						,email3 = :kst_tab_clienti_web.email3
						,email_prontomerce = :kst_tab_clienti_web.email_prontomerce
						,note = :kst_tab_clienti_web.note 
						,sito_web = :kst_tab_clienti_web.sito_web 
						,sito_web1 = :kst_tab_clienti_web.sito_web1 
						,x_datins = :kst_tab_clienti_web.x_datins
						,x_utente = :kst_tab_clienti_web.x_utente  
					WHERE id_cliente = :kst_tab_clienti_web.id_cliente 
					using sqlca;
					
			else
				
				INSERT INTO clienti_web  
							(
							id_cliente
							,blog_web 
							,blog_web1 
							,email 
							,email1  
							,email2 
							,email3 
							,email_prontomerce
							,note 
							,sito_web 
							,sito_web1 
							,x_datins 
							,x_utente 
							 )  
					  VALUES ( 
						 :kst_tab_clienti_web.id_cliente 
						,:kst_tab_clienti_web.blog_web 
						,:kst_tab_clienti_web.blog_web1 
						,:kst_tab_clienti_web.email 
						,:kst_tab_clienti_web.email1
						,:kst_tab_clienti_web.email2
						,:kst_tab_clienti_web.email3
						,:kst_tab_clienti_web.email_prontomerce
						,:kst_tab_clienti_web.note 
						,:kst_tab_clienti_web.sito_web 
						,:kst_tab_clienti_web.sito_web1 
						,:kst_tab_clienti_web.x_datins
						,:kst_tab_clienti_web.x_utente  
							  )  
					using sqlca;
			end if
			
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Web:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Web: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti_mkt kst_tab_clienti_mkt);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti_mkt.id_cliente > 0 then

		kdw_anteprima.dataobject = "d_clienti_mkt_1"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti_mkt.id_cliente)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Dati MKT da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_clienti_web kst_tab_clienti_web);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti_web.id_cliente > 0 then

		kdw_anteprima.dataobject = "d_clienti_web_1"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti_web.id_cliente)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Dati WEB da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_m_r_f kst_tab_m_r_f);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_m_r_f.clie_3 > 0 then

		kdw_anteprima.dataobject = "d_m_r_f_l_2"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_m_r_f.clie_3)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Legame Mandante-Ricev-Fatturato da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco_contatti (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_contatto"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun 'Contatto' da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco_clienti_del_contatto (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_clienti_del_contatto_l"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun 'Contatto' da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public subroutine esenzione_iva_controllo_fattura (ref st_clienti_esenzione_iva kst_clienti_esenzione_iva) throws uo_exception;//------------------------------------------------------------------------------------------
//---
//--- Controlla se cliente e' ESENTE IVA
//---
//---  Inp:  	codice cliente 
//---          	data fattura
//---            importo_t e IVA della riga fattura ancora da inserire
//--- 	Out: st_clienti_esenzione_iva: 
//---			ESITO 0=ESENTE,1=NO Esente,2=esenzione scaduta,3=superato importo max,4=non superato imp min in fatt
//---    		iva_valida_dal e iva_valida_al=periodo esente, 
//---          	iva_esente_imp_max=importo esente, 
//---          	iva_esente_imp_min_x_fatt=importo minimo da cui applicare l'esenzione, 
//---			importo=tot fatturato con esenzione 
//---
//---     st_esito: STANDARD ma LANCIA ECCEZIONE se not OK
//---
//------------------------------------------------------------------------------------------
//
//
double k_tot_fatture=0, k_tot_nc=0
st_esito kst_esito
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa_da, kst_tab_arfa_a
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kst_clienti_esenzione_iva.esito = "0"

	select iva, iva_valida_dal, iva_valida_al, iva_esente_imp_max, iva_esente_imp_min_x_fatt
	       into :kst_clienti_esenzione_iva.iva
			 , :kst_clienti_esenzione_iva.iva_valida_dal 
			 , :kst_clienti_esenzione_iva.iva_valida_al 
			 , :kst_clienti_esenzione_iva.iva_esente_imp_max
			 , :kst_clienti_esenzione_iva.iva_esente_imp_min_x_fatt
	       from clienti 
	       where clienti.codice = :kst_clienti_esenzione_iva.id_cliente
			using sqlca;
	       
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cliente non Trovato: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if
		
//--- lancia eccezione				
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception

	end if	
		
	if kst_clienti_esenzione_iva.iva = 0 or isnull(kst_clienti_esenzione_iva.iva) then
//--- nessuna esenzione
		kst_clienti_esenzione_iva.esito = "1"
		kst_esito.sqlerrtext = "Nessuna Esenzione cliente: "+ string(kst_clienti_esenzione_iva.id_cliente)
	end if

	if kst_clienti_esenzione_iva.esito = "0" then
		if kst_clienti_esenzione_iva.iva_valida_dal > kst_clienti_esenzione_iva.data_fatt &
				and kst_clienti_esenzione_iva.iva_valida_dal > date(0) &
				and not isnull(kst_clienti_esenzione_iva.iva_valida_dal) then
	
	//--- non ancora attiva 
			kst_clienti_esenzione_iva.esito = "1"
			kst_esito.esito = "Esenzione valida dal: " + string(kst_clienti_esenzione_iva.iva_valida_dal)
			
		end if
	end if
		
//--- Verifica se Importo fattura maggiore del minimo richiesto
	if kst_clienti_esenzione_iva.esito = "0" then
		if kst_clienti_esenzione_iva.iva_esente_imp_min_x_fatt > 0 and kst_clienti_esenzione_iva.importo_t > 0 then
			if kst_clienti_esenzione_iva.iva_esente_imp_min_x_fatt >  kst_clienti_esenzione_iva.importo_t then
				kst_clienti_esenzione_iva.esito = "4"
				kst_esito.esito = "Importo minimo Esenzione non superato: " + string(kst_clienti_esenzione_iva.iva_esente_imp_min_x_fatt)
			end if
		end if
	end if
		
	if kst_clienti_esenzione_iva.esito = "0" then
		if kst_clienti_esenzione_iva.iva_valida_al < kst_clienti_esenzione_iva.data_fatt &
				and kst_clienti_esenzione_iva.iva_valida_al > date(0) &
				and not isnull(kst_clienti_esenzione_iva.iva_valida_al) then
				
			kst_clienti_esenzione_iva.esito = "2"
			kst_esito.sqlerrtext = "Esenzione scaduta il: "+  string(kst_clienti_esenzione_iva.iva_valida_al)
		end if
	end if

	if kst_clienti_esenzione_iva.esito = "0" then
		if kst_clienti_esenzione_iva.iva_valida_al > date(0) and kst_clienti_esenzione_iva.importo > 0 then
//--- Calcola e controllo Importo
			try
	
				kuf1_fatt = create kuf_fatt  
				kst_tab_arfa_da.id_fattura = kst_clienti_esenzione_iva.id_fattura 
				kst_tab_arfa_da.clie_3 = kst_clienti_esenzione_iva.id_cliente 
				kst_tab_arfa_da.iva = kst_clienti_esenzione_iva.iva
				kst_tab_arfa_da.data_fatt = kst_clienti_esenzione_iva.iva_valida_dal
				kst_tab_arfa_a.data_fatt = kst_clienti_esenzione_iva.iva_valida_al
				
				kst_clienti_esenzione_iva.importo = kuf1_fatt.get_totale_x_cliente_periodo(kst_tab_arfa_da, kst_tab_arfa_da)
				
				if  kst_clienti_esenzione_iva.importo_t > 0 then
					kst_clienti_esenzione_iva.importo += kst_clienti_esenzione_iva.importo_t  // aggiungo l'importo della fattura che sta inserendo
				end if
					
	//08.04.08 sostituito col la chiamata all'oggetto fatto apposta
	//						select sum(prezzo_t)
	//							 into :k_tot_fatture
	//							 from arfa
	//							 where clie_3 = :kst_clienti_esenzione_iva.id_cliente 
	//									 and iva = :kst_clienti_esenzione_iva.iva
	//									 and data_fatt between :kst_clienti_esenzione_iva.iva_valida_dal and :kst_clienti_esenzione_iva.iva_valida_al
	//									 and arfa.tipo_doc = 'FT'
	//							using sqlca;
	//	
	//						if sqlca.sqlcode = 0 then
	//	
	//							if k_tot_fatture > 0 then
	//								kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo_t + k_tot_fatture
	//							end if
	//	
	//							select sum(prezzo_t)
	//								 into :k_tot_nc
	//								 from arfa
	//								 where clie_3 = :kst_clienti_esenzione_iva.id_cliente 
	//										 and iva = :kst_clienti_esenzione_iva.iva
	//										 and data_fatt between :kst_clienti_esenzione_iva.iva_valida_dal and :kst_clienti_esenzione_iva.iva_valida_al
	//										 and arfa.tipo_doc = 'NC'
	//								using sqlca;
	//	
	//							if sqlca.sqlcode = 0 then
	//								if k_tot_nc > 0 then
	//									kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo - k_tot_nc
	//								end if	
	//							else
	//								if sqlca.sqlcode < 0 then
	//									kst_esito.sqlcode = sqlca.sqlcode
	//									kst_esito.SQLErrText = "Lettura N.Credito Fallita, cliente: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
	//									kst_esito.esito = kkg_esito.db_ko
	//								end if
	//							end if
	//						else
	//							if sqlca.sqlcode < 0 then
	//								kst_esito.sqlcode = sqlca.sqlcode
	//								kst_esito.SQLErrText = "Lettura Fatture Fallita, cliente: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
	//								kst_esito.esito = kkg_esito.db_ko
	//							else
	//								kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo_t 
	//							end if
	//						end if
	
				if kst_clienti_esenzione_iva.importo > kst_clienti_esenzione_iva.iva_esente_imp_max and kst_clienti_esenzione_iva.iva_esente_imp_max > 0 then
	
	//--- superato importo esente
					kst_clienti_esenzione_iva.esito = "3"
					kst_esito.sqlerrtext = "Imp.Esenz.superato €:"+ string(kst_clienti_esenzione_iva.importo)
	
				end if
				
			catch (uo_exception kuo1_exception)
	//--- lancia eccezione				
				throw kuo1_exception
				
			finally 
				destroy kuf1_fatt
			end try
		end if			
	end if




end subroutine

public function st_esito get_contatti (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il codice Contatto 
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.st_tab_clienti_mk.id_contatto_1/5 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT   
		  id_contatto_1
		  ,id_contatto_2
		  ,id_contatto_3
		  ,id_contatto_4
		  ,id_contatto_5
    INTO 
	 	  :kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1    
	 	  ,:kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2    
	 	  ,:kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3    
	 	  ,:kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4    
	 	  ,:kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5    
        FROM clienti_mkt
        WHERE ( clienti_mkt.id_cliente = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if


return kst_esito

end function

public function st_esito get_settore (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il codice ID_CLIE_SETTORE 
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.st_tab_clienti_mk.id_contatto_1/5 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT   
		  id_clie_settore
    INTO 
	 	  :kst_tab_clienti.id_clie_settore  
        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if


return kst_esito

end function

public function st_esito get_fattura_da (ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il flag FATTURA_DA 
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.st_tab_clienti_fatt.fattura_da 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT   
		  fattura_da
    INTO 
	 	  :kst_tab_clienti.kst_tab_clienti_fatt.fattura_da
        FROM clienti_fatt
        WHERE ( id_cliente = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Anagrafiche (fattura_da): " + trim(sqlca.sqlerrtext)
//---- se cliente non trovato allora metto il valore di default
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.ok
			kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kki_fattura_da_DEFAULT
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		
//--- valore di default		
		if isnull(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da) or len(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da) = 0 then
			kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kki_fattura_da_DEFAULT 
		end if
		
	end if


return kst_esito

end function

public function st_esito get_mrf_clie_2 (ref st_tab_m_r_f kst_tab_m_r_f);//====================================================================
//=== Torna il codice RICEVENTI 
//=== 
//=== INP: kst_tab_clienti il codice Mandante/Fatturato passato nel kst_tab_m_r_f
//=== OUT: kst_tab_m_r_f.clie_2 = Riceventi Trovato
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_m_r_f.clie_2 = 0
	if isnull(kst_tab_m_r_f.clie_1) then kst_tab_m_r_f.clie_1 = 0 
	if isnull(kst_tab_m_r_f.clie_3) then kst_tab_m_r_f.clie_3 = 0 

	kst_tab_m_r_f.st_tab_g_0.contati = 0
	
	if kst_tab_m_r_f.clie_1 > 0 or kst_tab_m_r_f.clie_3 > 0 then 	
		
		SELECT count(distinct clie_2)
			 into :kst_tab_m_r_f.st_tab_g_0.contati 
			 FROM m_r_f
				where (:kst_tab_m_r_f.clie_1 > 0 and clie_1 = :kst_tab_m_r_f.clie_1) or (:kst_tab_m_r_f.clie_3 > 0 and clie_3 =  :kst_tab_m_r_f.clie_3) 
				using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			if kst_tab_m_r_f.st_tab_g_0.contati > 0 then
				
				if kst_tab_m_r_f.st_tab_g_0.contati > 1 then
					
					kst_esito.sqlcode = 0 
					kst_esito.SQLErrText = "Legame Mandante-Ricevente-Cliente non congruente: mand=" + string(kst_tab_m_r_f.clie_1) + ", ricev="+string(kst_tab_m_r_f.clie_2)+", cliente="+string(kst_tab_m_r_f.clie_3)
					kst_esito.esito = kkg_esito.err_logico

				else		
					
					SELECT   distinct clie_2
						 into :kst_tab_m_r_f.clie_2 
						 FROM m_r_f
							where (:kst_tab_m_r_f.clie_1 > 0 and clie_1 = :kst_tab_m_r_f.clie_1) or (:kst_tab_m_r_f.clie_3 > 0 and clie_3 =  :kst_tab_m_r_f.clie_3) 
							using kguo_sqlca_db_magazzino;
					
				end if
			else

				kst_esito.sqlcode = 0 
				kst_esito.SQLErrText = "Nessun Legame trovato per il Ricevente " + string(kst_tab_m_r_f.clie_2) +". Ricerca Legame Mandante-Ricevente-Cliente: mand=" + string(kst_tab_m_r_f.clie_1) + ", ricev="+string(kst_tab_m_r_f.clie_2)+", cliente="+string(kst_tab_m_r_f.clie_3)
				kst_esito.esito = kkg_esito.db_wrn

//--- ipotizzo che Ricevente = al codice passato 			
				if kst_tab_m_r_f.clie_1 = kst_tab_m_r_f.clie_3 or kst_tab_m_r_f.clie_3 = 0 or kst_tab_m_r_f.clie_1 = 0 then
					if kst_tab_m_r_f.clie_1 > 0 then
						kst_tab_m_r_f.clie_2 = kst_tab_m_r_f.clie_1
					else
						kst_tab_m_r_f.clie_2 = kst_tab_m_r_f.clie_3
					end if
				end if
			
			end if
		end if
	end if
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in tab. Legami Mandanti-Riceventi-Clienti: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
//--- ipotizzo che Ricevente = al codice passato 			
			if kst_tab_m_r_f.clie_1 = kst_tab_m_r_f.clie_3 or kst_tab_m_r_f.clie_3 = 0 or kst_tab_m_r_f.clie_1 = 0 then
				if kst_tab_m_r_f.clie_1 > 0 then
					kst_tab_m_r_f.clie_2 = kst_tab_m_r_f.clie_1
				else
					kst_tab_m_r_f.clie_2 = kst_tab_m_r_f.clie_3
				end if
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if




return kst_esito




end function

public function st_esito get_mrf_clie_3 (ref st_tab_m_r_f kst_tab_m_r_f);//====================================================================
//=== Torna il codice FATTURATO 
//=== 
//=== INP: kst_tab_clienti il codice Mandante/Ricevente passato nel kst_tab_m_r_f
//=== OUT: kst_tab_m_r_f.clie_3 = Fatturato Trovato
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_m_r_f.clie_3 = 0
	if isnull(kst_tab_m_r_f.clie_1) then kst_tab_m_r_f.clie_1 = 0 
	if isnull(kst_tab_m_r_f.clie_2) then kst_tab_m_r_f.clie_2 = 0 

	kst_tab_m_r_f.st_tab_g_0.contati = 0
	
	if kst_tab_m_r_f.clie_1 > 0 or kst_tab_m_r_f.clie_2 > 0 then 	
		
		SELECT   count(distinct clie_3)
			 into :kst_tab_m_r_f.st_tab_g_0.contati 
			 FROM m_r_f
				where (:kst_tab_m_r_f.clie_1 > 0 and clie_1 = :kst_tab_m_r_f.clie_1) or (:kst_tab_m_r_f.clie_2 > 0 and clie_3 =  :kst_tab_m_r_f.clie_2) 
				using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			if kst_tab_m_r_f.st_tab_g_0.contati > 0 then
				
				if kst_tab_m_r_f.st_tab_g_0.contati > 1 then
					
					kst_esito.sqlcode = 0 
					kst_esito.SQLErrText = "Tab. Mandanti-Riceventi-Fatt. troppi risultati trovati: mand=" + string(kst_tab_m_r_f.clie_1) + ", ricev="+string(kst_tab_m_r_f.clie_2)+" fatt="+string(kst_tab_m_r_f.clie_3)
					kst_esito.esito = kkg_esito.err_logico

				else		
					
					SELECT   distinct clie_3
						 into :kst_tab_m_r_f.clie_3 
						 FROM m_r_f
							where (:kst_tab_m_r_f.clie_1 > 0 and clie_1 = :kst_tab_m_r_f.clie_1) or (:kst_tab_m_r_f.clie_2 > 0 and clie_3 =  :kst_tab_m_r_f.clie_2) 
							using kguo_sqlca_db_magazzino;
					
				end if
			else

				kst_esito.sqlcode = 0 
				kst_esito.SQLErrText = "Nessun Cliente Trovato in Tab. Mandanti-Riceventi-Fatt.: mand=" + string(kst_tab_m_r_f.clie_1) + ", ricev="+string(kst_tab_m_r_f.clie_2)+", fatt="+string(kst_tab_m_r_f.clie_3)
				kst_esito.esito = kkg_esito.db_wrn

//--- ipotizzo che Fatturato = al codice passato 			
				if kst_tab_m_r_f.clie_1 = kst_tab_m_r_f.clie_2 or kst_tab_m_r_f.clie_2 = 0 or kst_tab_m_r_f.clie_1 = 0 then
					if kst_tab_m_r_f.clie_1 > 0 then
						kst_tab_m_r_f.clie_3 = kst_tab_m_r_f.clie_1
					else
						kst_tab_m_r_f.clie_3 = kst_tab_m_r_f.clie_2
					end if
				end if
			
			end if
		end if
	end if
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Tab. Mandanti-Riceventi-Fatt.: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
//--- ipotizzo che Fatturato = al codice passato 			
			if kst_tab_m_r_f.clie_1 = kst_tab_m_r_f.clie_2 or kst_tab_m_r_f.clie_2 = 0 or kst_tab_m_r_f.clie_1 = 0 then
				if kst_tab_m_r_f.clie_1 > 0 then
					kst_tab_m_r_f.clie_3 = kst_tab_m_r_f.clie_1
				else
					kst_tab_m_r_f.clie_3 = kst_tab_m_r_f.clie_2
				end if
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if




return kst_esito




end function

public subroutine get_codice_da_cf (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//
//====================================================================
//=== Torna CODICE da CODICE FISCALE
//=== 
//=== Input: st_tab_clienti.cf     Output: st_tab_clienti.codice                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.codice = 0

//--- se ne trova + di 1 
	SELECT count(*)
			 into :kst_tab_clienti.codice
			 FROM clienti
			 where clienti.cf = trim(:kst_tab_clienti.cf)
				using sqlca;
	
   if kst_tab_clienti.codice = 1 then
		SELECT clienti.codice
			 into :kst_tab_clienti.codice
			 FROM clienti
			 where clienti.cf = trim(:kst_tab_clienti.cf)
				using sqlca;
	else
		kst_tab_clienti.codice = 0
	end if
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Clienti (da C.F.: " + trim(kst_tab_clienti.cf) + ") ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if







end subroutine

public subroutine get_codice_da_piva (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//
//====================================================================
//=== Torna CODICE da P.IVA 
//=== 
//=== Input: st_tab_clienti.p_iva     Output: st_tab_clienti.codice                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================
string k_codice = ""
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.codice = 0
	
	k_codice = trim(kst_tab_clienti.p_iva)
	
 	SELECT count(*)
       into :kst_tab_clienti.codice
		 FROM clienti
		 where clienti.p_iva = :k_codice
			using sqlca;

//--- se ne trova + di 1 
  	if kst_tab_clienti.codice = 1 then
		
		SELECT clienti.codice
			 into :kst_tab_clienti.codice
			 FROM clienti
			 where clienti.p_iva = :k_codice
				using sqlca;
	else	

		if len(trim(kst_tab_clienti.p_iva)) < 9 then   // la Partita IVA e' almeno di 11 caratteri (possono essere alfabetici)
		
			kst_tab_clienti.codice = 0
		
		else

			k_codice =  "%" + trim(kst_tab_clienti.p_iva)
			
			SELECT count(*)
				 into :kst_tab_clienti.codice
				 FROM clienti
				 where clienti.p_iva like :k_codice
					using sqlca;
	
			if kst_tab_clienti.codice = 0 then
	
				k_codice = "%%" + trim(kst_tab_clienti.p_iva) + "%"
			
				SELECT count(*)
					 into :kst_tab_clienti.codice
					 FROM clienti
					 where clienti.p_iva like :k_codice
						using sqlca;
	
			end if
	
			
			if kst_tab_clienti.codice = 1 then
				
				SELECT clienti.codice
					 into :kst_tab_clienti.codice
					 FROM clienti
					 where clienti.p_iva like :k_codice
						using sqlca;
				
			else		
				kst_tab_clienti.codice = 0
				
			end if
			
		end if	
		
	end if
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Clienti (da C.F.: " + trim(kst_tab_clienti.cf) + ")  ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if sqlca.sqlcode = 100 then
			kst_tab_clienti.codice = 0
		end if
	end if







end subroutine

public subroutine elenco_m_r_f_3 (st_tab_clienti kst_tab_clienti);//
//--- Fa l'elenco Anagrafiche Riceventi-Fatturati per il Mandante indicato
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
	kds_1.dataobject = kki_dw_elenco_m_r_f_3
	kds_1.settransobject(sqlca) 
	
	if kst_tab_clienti.codice > 0 then
		kds_1.retrieve( kst_tab_clienti.codice )
	
//		k_nome = tab_1.tabpage_1.dw_1.getitemstring( 1, "rag_soc_10")
		
		if kds_1.rowcount() > 0 then
		
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
			kst_open_w.key1 = "Elenco clienti Riceventi e di Fattura per il Mandante: " + string( kst_tab_clienti.codice ) //+ " " + trim(k_nome)
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
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

public function st_esito get_email (ref st_tab_clienti_web kst_tab_clienti_web);//
//====================================================================
//=== Legge tabella Clienti_web per reperire i campi email
//=== 
//=== Inp: st_tab_clienti_web.id_cliente
//=== Out: st_tab_clienti_web.email/1/2
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
		  CLIENTI_WEB.email,
		  CLIENTI_WEB.email1,
		  CLIENTI_WEB.email2,
		  CLIENTI_WEB.email3
    INTO 
           :kst_tab_clienti_web.email , 
           :kst_tab_clienti_web.email1, 
           :kst_tab_clienti_web.email2, 
           :kst_tab_clienti_web.email3 
        FROM clienti_web 
        WHERE ( clienti_web.id_cliente = :kst_tab_clienti_web.id_cliente   )   
		using sqlca;


	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_clienti_web.email) then kst_tab_clienti_web.email = "" 
		if isnull(kst_tab_clienti_web.email1) then kst_tab_clienti_web.email1 = "" 
		if isnull(kst_tab_clienti_web.email2) then kst_tab_clienti_web.email2 = "" 
		if isnull(kst_tab_clienti_web.email3) then kst_tab_clienti_web.email3 = "" 
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche Web (email):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if


return kst_esito

end function

public function boolean if_presente_m_r_f (st_tab_clienti_m_r_f kst_tab_clienti_m_r_f) throws uo_exception;//
//====================================================================
//=== Controlla se esiste il Legame Mand-Ricev-Fatt
//=== 
//=== Input: st_tab_clienti_m_r_f con valorizzati Clie_1/2/3    Output: TRUE=esiste FALSE=non esiste
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
boolean k_return = false
int k_ctr=0
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_ctr
		 FROM m_r_f
		 where m_r_f.clie_1 = :kst_tab_clienti_m_r_f.clie_1
		 			and m_r_f.clie_2 = :kst_tab_clienti_m_r_f.clie_2
		 			and m_r_f.clie_3 = :kst_tab_clienti_m_r_f.clie_3
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Legami Clienti (m_r_f): ~n~r" + trim(sqlca.SQLErrText)
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


if k_ctr = 1 then k_return = TRUE

return k_return





end function

public function st_esito get_nome_da_xyz (string k_codice, ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il nome attraverso il CF o P.IVA o Codice
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.rag_soc_10/ rag_soc_20       
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(k_codice)) > 0 then 

//--- prima piglio il CODICE
	kst_esito = get_codice_da_xyz(k_codice,kst_tab_clienti)

//--- se tutto OK piglio il NOME	
	if kst_esito.esito = kkg_esito.ok then
		if kst_tab_clienti.codice > 0 then
			kst_esito = get_nome(kst_tab_clienti)
			if isnull(kst_tab_clienti.rag_soc_10) then	
				kst_tab_clienti.rag_soc_10 = " "
			end if
		end if
	end if

end if					

this.if_isnull(kst_tab_clienti)

return kst_esito


end function

public function st_esito get_codice_da_xyz (string k_codice, ref st_tab_clienti kst_tab_clienti);//
//====================================================================
//=== Legge tabella ANAGRAFICHE clienti per reperire il nome attraverso il CF o P.IVA o Codice
//=== 
//=== Input: st_tab_clienti.codice
//=== Out:i campi st_tab_clenti.rag_soc_10/ rag_soc_20       
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito
string k_ctr = ""

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(k_codice)) > 0 then 

	
	if len(trim(k_codice)) < 8 then //--- probabile che sia un codice
	
		if isnumber(trim(k_codice)) then
			
			kst_tab_clienti.codice = long(trim(k_codice))
			
		end if
		
	else

		if left(string(trim(k_codice)), 3) = '000' and  len(trim(k_codice)) < 11 then //--- protrebbe essere un codice dal flusso WM a formato fisso (strano)

			if isnumber(trim(k_codice)) then
				
				kst_tab_clienti.codice = long(trim(k_codice))
				
			end if
		
		else
	
			if left(trim(k_codice),2) = "IT" or left(trim(k_codice),2) = "it" then
				k_codice = mid(k_codice, 3) 
			end if
		
//--- probabimente e' P.IVA
			kst_tab_clienti.p_iva = trim(k_codice)
			try
				get_codice_da_piva(kst_tab_clienti)
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
			end try
				
			if kst_esito.esito <> kkg_esito.ok then
			
//--- forse e' Codice Fiscale
				kst_tab_clienti.cf = trim(k_codice)
				try
					get_codice_da_cf(kst_tab_clienti)
				catch (uo_exception kuo1_exception)
					kst_esito = kuo1_exception.get_st_esito()
				end try
				
			end if

		end if					
	end if					

end if					

this.if_isnull(kst_tab_clienti)

return kst_esito


end function

public function boolean leggi (ref st_tab_clienti_web kst_tab_clienti_web) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Legge tabella dati ANAGRAFICI clienti Web ecc...
//--- 
//--- Inp: st_tab_clienti_web.id_cliente
//--- Out: st_tab_clienti_web piena
//--- Ritorna: TRUE = ok
//--- 
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------------------------------------
boolean k_return
long k_rcn
st_tab_clienti kst_tab_clienti
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



SELECT clienti_web.id_cliente,   
         clienti_web.email,   
         clienti_web.email1,   
         clienti_web.email2,   
         clienti_web.email3,   
		  clienti_web.email_prontomerce,
         clienti_web.note,   
         clienti_web.sito_web,   
         clienti_web.sito_web1,   
         clienti_web.blog_web,   
         clienti_web.blog_web1,   
         clienti_web.x_datins,   
         clienti_web.x_utente  
    INTO 
	 	  :kst_tab_clienti_web.id_cliente ,
	 	  :kst_tab_clienti_web.email ,
	 	  :kst_tab_clienti_web.email1, 
	 	  :kst_tab_clienti_web.email2,
	 	  :kst_tab_clienti_web.email3,
		  :kst_tab_clienti_web.email_prontomerce,
	 	  :kst_tab_clienti_web.note, 
	 	  :kst_tab_clienti_web.sito_web, 
	 	  :kst_tab_clienti_web.sito_web1, 
	 	  :kst_tab_clienti_web.blog_web, 
	 	  :kst_tab_clienti_web.blog_web1, 
	 	  :kst_tab_clienti_web.x_datins, 
	 	  :kst_tab_clienti_web.x_utente 
    FROM clienti_web   
        WHERE ( id_cliente = :kst_tab_clienti_web.id_cliente)
	using kguo_sqlca_db_magazzino ;

kst_tab_clienti.kst_tab_clienti_web = kst_tab_clienti_web
if_isnull(kst_tab_clienti)  // toglie i null
kst_tab_clienti_web = kst_tab_clienti.kst_tab_clienti_web

if kguo_sqlca_db_magazzino.sqlcode = 100 then
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = TRUE
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab. Anagrafiche:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end if
	

return k_return

end function

public function boolean leggi (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//
//--------------------------------------------------------------------------------------------------
//--- Legge tabella dati ANAGRAFICI clienti ecc...
//--- 
//--- Inp: st_tab_clienti.codice
//--- Out: st_tab_clienti piena
//--- Ritorna: TRUE = ok
//--- 
//--- lancia EXCEPTION
//--- 
//--------------------------------------------------------------------------------------------------
//
boolean k_return=false
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()




  SELECT   clienti.codice ,
           clienti.rag_soc_10,
           clienti.rag_soc_11,
           clienti.rag_soc_20,
           clienti.rag_soc_21,
           clienti.indi_1,
           clienti.cap_1 ,
           clienti.loc_1,
           clienti.prov_1 ,
           clienti.id_nazione_1 ,
           clienti.p_iva ,
           clienti.cf ,
           clienti.zona ,
           clienti.fono,
           clienti.fax,
           clienti.cod_pag, 
           clienti.banca, 
           clienti.abi, 
           clienti.cab, 
           clienti.tipo_banca, 
           clienti.iva, 
           clienti.iva_valida_dal, 
           clienti.iva_valida_al, 
           clienti.iva_esente_imp_max, 
           clienti.iva_esente_imp_min_x_fatt, 
           clienti.mese_es_1, 
           clienti.mese_es_2, 
           clienti.cadenza_fattura,
           clienti.indi_2,
           clienti.cap_2 ,
           clienti.loc_2,
           clienti.prov_2 ,
           clienti.id_nazione_2 ,
           clienti.x_datins,
           clienti.x_utente,
           nazioni.nome ,
           nazioni.area ,
           ind_comm.rag_soc_1_c,
           ind_comm.rag_soc_2_c,
           ind_comm.indi_c,
           ind_comm.cap_c ,
           ind_comm.loc_c,
           ind_comm.prov_c,
           ind_comm.id_nazione_c,
           ind_comm.clie_c
           ,clienti_fatt.fattura_da
           ,clienti_fatt.note_1
           ,clienti_fatt.note_2
		,clienti_fatt.modo_stampa
		,clienti_fatt.modo_email
		,clienti_fatt.email_invio
		,clienti.pklbcodepref
    INTO 
	 	  :kst_tab_clienti.codice,
	 	  :kst_tab_clienti.rag_soc_10,   
           :kst_tab_clienti.rag_soc_11,   
           :kst_tab_clienti.rag_soc_20,   
           :kst_tab_clienti.rag_soc_21,   
		  :kst_tab_clienti.indi_1,   
           :kst_tab_clienti.cap_1,   
           :kst_tab_clienti.loc_1,   
           :kst_tab_clienti.prov_1,   
           :kst_tab_clienti.id_nazione_1,   
           :kst_tab_clienti.p_iva , 
           :kst_tab_clienti.cf , 
           :kst_tab_clienti.zona ,
           :kst_tab_clienti.fono,
           :kst_tab_clienti.fax, 
           :kst_tab_clienti.cod_pag, 
           :kst_tab_clienti.banca, 
           :kst_tab_clienti.abi, 
           :kst_tab_clienti.cab, 
           :kst_tab_clienti.tipo_banca, 
           :kst_tab_clienti.iva, 
           :kst_tab_clienti.iva_valida_dal, 
           :kst_tab_clienti.iva_valida_al, 
           :kst_tab_clienti.iva_esente_imp_max, 
           :kst_tab_clienti.iva_esente_imp_min_x_fatt, 
           :kst_tab_clienti.mese_es_1, 
           :kst_tab_clienti.mese_es_2, 
           :kst_tab_clienti.cadenza_fattura,
           :kst_tab_clienti.indi_2,
           :kst_tab_clienti.cap_2 ,
           :kst_tab_clienti.loc_2,
           :kst_tab_clienti.prov_2 ,
           :kst_tab_clienti.id_nazione_2 ,
           :kst_tab_clienti.x_datins,
           :kst_tab_clienti.x_utente,
           :kst_tab_clienti.kst_tab_nazioni.nome ,
           :kst_tab_clienti.kst_tab_nazioni.area ,
           :kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c,
           :kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c,
           :kst_tab_clienti.kst_tab_ind_comm.indi_c,
           :kst_tab_clienti.kst_tab_ind_comm.cap_c ,
           :kst_tab_clienti.kst_tab_ind_comm.loc_c,
           :kst_tab_clienti.kst_tab_ind_comm.prov_c,
           :kst_tab_clienti.kst_tab_ind_comm.id_nazione_c,
           :kst_tab_clienti.kst_tab_ind_comm.clie_c
           ,:kst_tab_clienti.kst_tab_clienti_fatt.fattura_da
           ,:kst_tab_clienti.kst_tab_clienti_fatt.note_1
           ,:kst_tab_clienti.kst_tab_clienti_fatt.note_2
			,:kst_tab_clienti.kst_tab_clienti_fatt.modo_stampa
			,:kst_tab_clienti.kst_tab_clienti_fatt.modo_email
			,:kst_tab_clienti.kst_tab_clienti_fatt.email_invio
			,:kst_tab_clienti.pklbcodepref
        FROM (clienti left outer join ind_comm on clienti.codice = ind_comm.clie_c) 
				  left outer join nazioni on clienti.id_nazione_1 = nazioni.id_nazione     
                   left outer join clienti_fatt on  clienti.codice = clienti_fatt.id_cliente 
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		k_return = TRUE     // OK!!!

		if_isnull(kst_tab_clienti)  // toglie i null

//---- Indirizzo Commerciale ricoperto dall'indirizzo Generale se non impostato
		if len(trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c)) = 0 then
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c = kst_tab_clienti.rag_soc_10
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c = kst_tab_clienti.rag_soc_11
			kst_tab_clienti.kst_tab_ind_comm.indi_c = kst_tab_clienti.indi_1
			kst_tab_clienti.kst_tab_ind_comm.cap_c = kst_tab_clienti.cap_1 
			kst_tab_clienti.kst_tab_ind_comm.loc_c = kst_tab_clienti.loc_1
			kst_tab_clienti.kst_tab_ind_comm.prov_c = kst_tab_clienti.prov_1
			kst_tab_clienti.kst_tab_ind_comm.id_nazione_c = kst_tab_clienti.id_nazione_1
			kst_tab_clienti.kst_tab_ind_comm.clie_c = kst_tab_clienti.codice
		end if		
//--- Fattura da se non indicato....
		if len(trim(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da)) = 0 then
			kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kki_fattura_da_bolla
		end if
		
	else
	
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab. Anagrafica:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				
				k_return = TRUE     // OK!!!
			
				if isnull(kst_tab_clienti.iva) then kst_tab_clienti.iva = 0
				if isnull(kst_tab_clienti.iva_esente_imp_max) then kst_tab_clienti.iva_esente_imp_max = 0 
				if isnull(kst_tab_clienti.iva_esente_imp_min_x_fatt) then kst_tab_clienti.iva_esente_imp_min_x_fatt = 0 
				if isnull(kst_tab_clienti.iva_valida_dal) then kst_tab_clienti.iva_valida_dal = date(0) 
				if isnull(kst_tab_clienti.iva_valida_al) then kst_tab_clienti.iva_valida_al = date(0) 
			else
				
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Tab. Anagrafiche:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if
			
		end if
	
		
	end if


return k_return

end function

public function boolean if_esiste_doc_esporta_prefpath (st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste gia' lo stesso DOC_ESPORTA_PREFPATH in tabella 
//--- 
//--- Inp: doc_esporta_prefpath,  id_cliente (se omesso assume zero)
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE; (meglio FALSE)
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


	if len(trim(kst_tab_clienti_mkt.doc_esporta_prefpath)) > 0 then

		
		if isnull(kst_tab_clienti_mkt.id_cliente) then kst_tab_clienti_mkt.id_cliente = 0

		select 1
			into :k_ctr
			from clienti_mkt 
			where clienti_mkt.id_cliente <> :kst_tab_clienti_mkt.id_cliente 
			          and clienti_mkt.doc_esporta_prefpath = :kst_tab_clienti_mkt.doc_esporta_prefpath
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode = 100 then
				k_return = false
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica esistenza Cartella Personale Documenti doppie (clienti_mkt): " + string(kst_tab_clienti_mkt.doc_esporta_prefpath)  + " ~n~r " + sqlca.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if

	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function boolean get_doc_esporta_prefpath (ref st_tab_clienti_mkt kst_tab_clienti_mkt) throws uo_exception;//-----------------------------------------------------------------------------------------------------------
//--- Torna valore  doc_esporta_prefpath  dalla tabella clienti_mkt
//--- 
//--- Input: st_tab_clienti_mkt.id_cliente     
//--- Output: st_tab_clienti_mkt.doc_esporta
//--- Ritorna: TRUE = tutto OK 
//--- 
//--- Lancia ECCEZIONE x errore
//--- 
//-----------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT trim(doc_esporta_prefpath)
			 into :kst_tab_clienti_mkt.doc_esporta_prefpath
			 FROM clienti_mkt
			 where clienti_mkt.id_cliente = :kst_tab_clienti_mkt.id_cliente
				using sqlca;
	
	
	
	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_clienti_mkt.doc_esporta_prefpath) then kst_tab_clienti_mkt.doc_esporta_prefpath = string(kst_tab_clienti_mkt.id_cliente)
		k_return = true
	else
		if sqlca.sqlcode > 0 then
			kst_tab_clienti_mkt.doc_esporta_prefpath = trim(string(kst_tab_clienti_mkt.id_cliente))
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura tab. Marketing Clienti,  cliente: " + string(kst_tab_clienti_mkt.id_cliente) + ") ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if


return k_return




end function

public function long leggi_tutto (ref st_tab_clienti ast_tab_clienti[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------
//--- Legge tabella dati ANAGRAFICI clienti ecc... il più completa possibile
//--- 
//--- Inp: st_tab_clienti[1].codice se ZERO torna tutti 
//--- Out: st_tab_clienti [] array dei clienti 
//--- Ritorna: nr totale anagrafiche estratte
//--- 
//--- lancia EXCEPTION
//--- 
//--------------------------------------------------------------------------------------------------
//
long k_return=0
long k_righe, k_riga
datastore kds_clienti
st_esito kst_esito

st_tab_clienti kst_tab_clienti

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


if upperbound(ast_tab_clienti[]) > 0 then
else
	ast_tab_clienti[1].codice = 0
end if
	
kds_clienti = create datastore
kds_clienti.dataobject = "ds_clienti_l_esporta"
kds_clienti.settransobject( kguo_sqlca_db_magazzino )
k_righe = kds_clienti.retrieve( "%", ast_tab_clienti[1].codice )

if k_righe < 0 then

	kst_esito.sqlcode = k_righe
	kst_esito.SQLErrText = "Anomalia in lettura Anagrafiche. " 
	kst_esito.esito = kkg_esito.db_ko
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
else
	
	for k_riga = 1 to k_righe
		
		ast_tab_clienti[k_riga].abi = kds_clienti.object.abi[k_riga]
		ast_tab_clienti[k_riga].banca = kds_clienti.object.banca[k_riga]
		ast_tab_clienti[k_riga].cab = kds_clienti.object.cab[k_riga]
		ast_tab_clienti[k_riga].cadenza_fattura = kds_clienti.object.cadenza_fattura[k_riga]
		ast_tab_clienti[k_riga].cap_1 = kds_clienti.object.cap_1[k_riga]
		ast_tab_clienti[k_riga].cap_2 = kds_clienti.object.cap_2[k_riga]
		ast_tab_clienti[k_riga].cf = kds_clienti.object.cf[k_riga]
		ast_tab_clienti[k_riga].cod_pag = kds_clienti.object.cod_pag[k_riga]
		ast_tab_clienti[k_riga].codice = kds_clienti.object.codice[k_riga]
		ast_tab_clienti[k_riga].data_attivazione = kds_clienti.object.data_attivazione[k_riga]
		ast_tab_clienti[k_riga].fax = kds_clienti.object.fax[k_riga]
		ast_tab_clienti[k_riga].fono = kds_clienti.object.fono[k_riga]
		ast_tab_clienti[k_riga].id_clie_classe = kds_clienti.object.id_clie_classe[k_riga]
		ast_tab_clienti[k_riga].id_clie_settore = kds_clienti.object.id_clie_settore[k_riga]
		if len(trim(kds_clienti.object.id_nazione_1[k_riga])) > 0 then
			ast_tab_clienti[k_riga].id_nazione_1 = kds_clienti.object.id_nazione_1[k_riga]
		else
			ast_tab_clienti[k_riga].id_nazione_1 = "IT"			// default è ITALIA
		end if
		if len(trim(kds_clienti.object.id_nazione_2[k_riga])) > 0 then
			ast_tab_clienti[k_riga].id_nazione_2 = kds_clienti.object.id_nazione_2[k_riga]
		else
			ast_tab_clienti[k_riga].id_nazione_2 = "IT"			// default è ITALIA
		end if
		ast_tab_clienti[k_riga].indi_1 = kds_clienti.object.indi_1[k_riga]
		ast_tab_clienti[k_riga].indi_2 = kds_clienti.object.indi_2[k_riga]
		ast_tab_clienti[k_riga].iva = kds_clienti.object.iva[k_riga]
		ast_tab_clienti[k_riga].iva_esente_imp_max = kds_clienti.object.iva_esente_imp_max[k_riga]
		ast_tab_clienti[k_riga].iva_esente_imp_min_x_fatt = kds_clienti.object.iva_esente_imp_min_x_fatt[k_riga]
		ast_tab_clienti[k_riga].iva_valida_al = kds_clienti.object.iva_valida_al[k_riga]
		ast_tab_clienti[k_riga].iva_valida_dal = kds_clienti.object.iva_valida_dal[k_riga]
		ast_tab_clienti[k_riga].loc_1 = kds_clienti.object.loc_1[k_riga]
		ast_tab_clienti[k_riga].loc_2 = kds_clienti.object.loc_2[k_riga]
		ast_tab_clienti[k_riga].mese_es_1 = kds_clienti.object.mese_es_1[k_riga]
		ast_tab_clienti[k_riga].mese_es_2 = kds_clienti.object.mese_es_2[k_riga]
		ast_tab_clienti[k_riga].p_iva = kds_clienti.object.p_iva[k_riga]
		ast_tab_clienti[k_riga].prov_1 = kds_clienti.object.prov_1[k_riga]
		ast_tab_clienti[k_riga].prov_2 = kds_clienti.object.prov_2[k_riga]
		ast_tab_clienti[k_riga].rag_soc_10 = kds_clienti.object.rag_soc_10[k_riga]
		ast_tab_clienti[k_riga].rag_soc_11 = kds_clienti.object.rag_soc_11[k_riga]
		ast_tab_clienti[k_riga].rag_soc_20 = kds_clienti.object.rag_soc_20[k_riga]
		ast_tab_clienti[k_riga].rag_soc_21 = kds_clienti.object.rag_soc_21[k_riga]
		ast_tab_clienti[k_riga].spe_bollo = kds_clienti.object.spe_bollo[k_riga]
		ast_tab_clienti[k_riga].spe_inc = kds_clienti.object.spe_inc[k_riga]
		ast_tab_clienti[k_riga].stato = kds_clienti.object.stato[k_riga]
		ast_tab_clienti[k_riga].tipo = kds_clienti.object.tipo[k_riga]
		ast_tab_clienti[k_riga].tipo_banca = kds_clienti.object.tipo_banca[k_riga]
//		ast_tab_clienti[k_riga].tipo_mrf = kds_clienti.object.tipo_mrf[k_riga]
		ast_tab_clienti[k_riga].zona = kds_clienti.object.zona[k_riga]
		
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.fattura_da = kds_clienti.object.clienti_fatt_fattura_da[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.email_invio = kds_clienti.object.clienti_fatt_email_invio[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.modo_email = kds_clienti.object.clienti_fatt_modo_email[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.modo_stampa = kds_clienti.object.clienti_fatt_modo_stampa[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.impon_minimo = kds_clienti.object.clienti_fatt_impon_minimo[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_fatt.codice_ipa = kds_clienti.object.clienti_fatt_codice_ipa[k_riga]
		
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.cod_atecori = kds_clienti.object.clienti_mkt_cod_atecori[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.id_contatto_1 = kds_clienti.object.clienti_mkt_id_contatto_1[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.id_contatto_2 = kds_clienti.object.clienti_mkt_id_contatto_2[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.qualifica = kds_clienti.object.clienti_mkt_qualifica[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.tipo_rapporto = kds_clienti.object.clienti_mkt_tipo_rapporto[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.id_cliente_link = kds_clienti.object.clienti_mkt_id_cliente_link[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.altra_sede = kds_clienti.object.clienti_mkt_altra_sede[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_mkt.contatto_1_qualif = kds_clienti.object.clienti_mkt_contatto_1_qualif[k_riga]
		
		ast_tab_clienti[k_riga].kst_tab_clienti_web.blog_web = kds_clienti.object.clienti_web_blog_web[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.blog_web1 = kds_clienti.object.clienti_web_blog_web1[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.email = kds_clienti.object.clienti_web_email[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.email1 = kds_clienti.object.clienti_web_email1[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.email2 = kds_clienti.object.clienti_web_email2[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.email3 = kds_clienti.object.clienti_web_email3[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.email_prontomerce = kds_clienti.object.clienti_web_email_prontomerce[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.sito_web = kds_clienti.object.clienti_web_sito_web[k_riga]
		ast_tab_clienti[k_riga].kst_tab_clienti_web.sito_web1 = kds_clienti.object.clienti_web_sito_web1[k_riga]

//---- Indirizzo Commerciale ricoperto dall'indirizzo Generale se non impostato
		ast_tab_clienti[k_riga].kst_tab_ind_comm.clie_c = ast_tab_clienti[k_riga].codice
		if len(trim(kds_clienti.object.ind_comm_rag_soc_1_c[k_riga])) > 0 then
			ast_tab_clienti[k_riga].kst_tab_ind_comm.rag_soc_1_c = kds_clienti.object.ind_comm_rag_soc_1_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.rag_soc_2_c = kds_clienti.object.ind_comm_rag_soc_2_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.indi_c = kds_clienti.object.ind_comm_indi_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.cap_c = kds_clienti.object.ind_comm_cap_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.loc_c = kds_clienti.object.ind_comm_loc_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.prov_c = kds_clienti.object.ind_comm_prov_c[k_riga]
			ast_tab_clienti[k_riga].kst_tab_ind_comm.id_nazione_c = kds_clienti.object.ind_comm_id_nazione_c[k_riga]
			
		else
			ast_tab_clienti[k_riga].kst_tab_ind_comm.rag_soc_1_c = ast_tab_clienti[k_riga].rag_soc_10
			ast_tab_clienti[k_riga].kst_tab_ind_comm.rag_soc_2_c = ast_tab_clienti[k_riga].rag_soc_11
			ast_tab_clienti[k_riga].kst_tab_ind_comm.indi_c = ast_tab_clienti[k_riga].indi_1
			ast_tab_clienti[k_riga].kst_tab_ind_comm.cap_c = ast_tab_clienti[k_riga].cap_1 
			ast_tab_clienti[k_riga].kst_tab_ind_comm.loc_c = ast_tab_clienti[k_riga].loc_1
			ast_tab_clienti[k_riga].kst_tab_ind_comm.prov_c = ast_tab_clienti[k_riga].prov_1
			ast_tab_clienti[k_riga].kst_tab_ind_comm.id_nazione_c = ast_tab_clienti[k_riga].id_nazione_1
			
		end if		

		if_isnull(ast_tab_clienti[k_riga])  // toglie i null

	end for

	k_return = k_righe     // OK!!!

end if
	

//--- Fattura da se non indicato....
if kst_tab_clienti.kst_tab_clienti_fatt.fattura_da > " " then
else
	kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kki_fattura_da_bolla
end if

if isvalid(kds_clienti) then destroy kds_clienti	


return k_return

end function

public function long get_cod_pag (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//--
//---  Torna il COD_PAG 
//--- 
//---  torna: long del COD_PAG, 0=non trovato
//---  input: st_tab_clienti.codice
//---  otput: st_tab_clienti.COD_PAG
//---
//--- Lancia uo_exception  x errore
//---
long k_return=0
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_clienti.codice > 0 then 
	
   select COD_PAG
	   into :kst_tab_clienti.COD_PAG
	   from  clienti
       where codice   =  :kst_tab_clienti.codice 
       using kguo_sqlca_db_magazzino;
		 
	
	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Ricerca del Cod.Pagamento sul Cliente cod. " + string(kst_tab_clienti.codice ) + "  (clienti)  ~n~r" &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

	if isnull(kst_tab_clienti.COD_PAG) then
		kst_tab_clienti.COD_PAG = 0
	end if
	k_return = kst_tab_clienti.COD_PAG
end if


return k_return

end function

public function st_esito get_nr_m_r_f (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta i TUTTE le connessioni convolte per il codice  passato nel kst_tab_clienti.codice
//=== 
//=== OUT: kst_tab_clienti.contati = numero Connessioni Trovate
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.contati = 0
	
   SELECT   count(*)
       into  :kst_tab_clienti.contati
		 FROM m_r_f
			where clie_3 = :kst_tab_clienti.codice or clie_2 = :kst_tab_clienti.codice or clie_1 =  :kst_tab_clienti.codice 
			using sqlca;
	
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Clienti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if




return kst_esito




end function

public function boolean if_estinto (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- IF Cliente è nello stato di ESTINTO?
//--- 
//--- Inp: codice 
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ESTINTO, FALSE=IN VIGORE
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if kst_tab_clienti.codice > 0 then

		kst_tab_clienti.stato = kki_cliente_stato_estinto
		select 1
				into :k_ctr
				from clienti 
				where clienti.codice = :kst_tab_clienti.codice and stato = :kst_tab_clienti.stato
				using sqlca;
				
		if sqlca.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode = 100 then
				k_return = false
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica ESTINZIONE Cliente: " + string(kst_tab_clienti.codice)  + " ~n~r " + sqlca.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore verifica ESTINZIONE Cliente: manca il codice " 
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function boolean reset_id_meca_causale_all (st_tab_clienti ast_tab_clienti) throws uo_exception;//
//====================================================================
//=== Resetta i codici id_meca_causale x tutti i clienti 
//=== 
//=== Input: st_tab_clienti.id_meca_causale  il codice da resettare su tutti i clienti
//=== Output:
//=== Ritorna: TRUE = reset OK
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_listino_voci kst_tab_listino_voci


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_clienti.id_meca_causale > 0 then
	
		update clienti
             set id_meca_causale = 0 
			where id_meca_causale = :ast_tab_clienti.id_meca_causale
			using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode = 0 then
		k_return = true
		if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )  // COMMIT
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Reset Causale Lotto su tutti i Clienti per ID Causale = " +string(ast_tab_clienti.id_meca_causale) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( ) // ROLBACK
			end if
			throw kguo_exception
		end if
	end if
end if

return k_return




end function

public function boolean set_id_meca_causale (st_tab_clienti ast_tab_clienti) throws uo_exception;//
//====================================================================
//=== set codice id_meca_causale x un cliente 
//=== 
//=== Input: st_tab_clienti.id_meca_causale / codice
//=== Output:
//=== Ritorna: TRUE = reset OK
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_listino_voci kst_tab_listino_voci


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_clienti.codice > 0 then
	
		update clienti
             set id_meca_causale = :ast_tab_clienti.id_meca_causale
			where codice = :ast_tab_clienti.codice
			using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode = 0 then
		k_return = true
		if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )  // COMMIT
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante impostazione Causale Lotto sul Cliente "+string(ast_tab_clienti.codice) + " per ID Causale = " +string(ast_tab_clienti.id_meca_causale) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			if ast_tab_clienti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( ) // ROLBACK
			end if
			throw kguo_exception
		end if
	end if

end if



return k_return




end function

public function boolean get_doc_esporta (ref st_tab_clienti_mkt ast_tab_clienti_mkt) throws uo_exception;//-----------------------------------------------------------------------------------------------------------
//--- Torna valore  doc_esporta  dalla tabella clienti_mkt
//--- 
//--- Input: st_tab_clienti_mkt.id_cliente     
//--- Output: st_tab_clienti_mkt.doc_esporta
//--- Ritorna: TRUE = tutto OK 
//--- 
//--- Lancia ECCEZIONE x errore
//--- 
//-----------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	ast_tab_clienti_mkt.doc_esporta =""
		
	SELECT  doc_esporta
			 into :ast_tab_clienti_mkt.doc_esporta
			 FROM clienti_mkt
			 where clienti_mkt.id_cliente = :ast_tab_clienti_mkt.id_cliente
				using sqlca;
	
	
	if sqlca.sqlcode = 0 then
		if isnull(ast_tab_clienti_mkt.doc_esporta) then ast_tab_clienti_mkt.doc_esporta =""
		k_return = true
	else
		if sqlca.sqlcode > 0 then
			ast_tab_clienti_mkt.doc_esporta =""
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura tab. Marketing Clienti,  cliente: " + string(ast_tab_clienti_mkt.id_cliente) + ") ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if


return k_return




end function

public function long get_id_cliente_memo (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception;//
//====================================================================
//=== Legge tabella CLIENTI_MEMO per reperire il id_cliente memo
//=== 
//=== Input: st_tab_clienti_memo.id_memo
//=== Out: i campi st_tab_clenti_memo.id_cliente       
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//=== 
//====================================================================
st_esito kst_esito
long k_return = 0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT
		  id_cliente
    INTO 
	 	  :kst_tab_clienti_memo.id_cliente
        FROM clienti_memo
        WHERE ( id_memo = :kst_tab_clienti_memo.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Cliente da Documento id=" +string(kst_tab_clienti_memo.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_clienti_memo.id_cliente > 0 then
			k_return =  kst_tab_clienti_memo.id_cliente
		end if
	end if
end if


return k_return



end function

public function boolean tb_delete (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella CLIENTI_MEMO
//--- 
//--- Input: st_tab_clienti_memo.id_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_clienti_memo.id_memo > 0 then
	
	delete 
			from clienti_memo
			WHERE id_memo = :ast_tab_clienti_memo.id_memo 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione NOTE dal Cliente (id memo " + string(ast_tab_clienti_memo.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
			
		if ast_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_clienti_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function st_esito get_id_memo (ref st_tab_clienti_memo kst_tab_clienti_memo);//
//====================================================================
//=== Torna  ID_MEMO da id_cliente_memo
//=== 
//=== Input: st_tab_clienti_memo non valorizzata     Output: st_tab_clienti_memo.id_memo                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  ID_MEMO
       into :kst_tab_clienti_memo.ID_MEMO
		 FROM clienti_memo
		 where  ID_CLIENTE_MEMO = :kst_tab_clienti_memo.ID_CLIENTE_MEMO
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Memo-Anagrafe (id = " + string(kst_tab_clienti_memo.ID_MEMO) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	end if

	if kst_tab_clienti_memo.ID_MEMO > 0 then
	else
		kst_tab_clienti_memo.ID_MEMO = 0
	end if

return kst_esito




end function

public subroutine memo_save (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;//
//--- Fascicola il MEMO sul Cliente 
//
st_esito kst_esito
kuf_memo_allarme kuf1_memo_allarme

try   

	kist_tab_clienti_memo.id_memo = ast_tab_clienti_memo.id_memo
	if trim(kist_tab_clienti_memo.allarme) > " " then
	else
		kist_tab_clienti_memo.allarme = kuf1_memo_allarme.kki_memo_allarme_no
	end if

	kist_tab_clienti_memo.st_tab_g_0 = ast_tab_clienti_memo.st_tab_g_0
	kst_esito = tb_update(ast_tab_clienti_memo)
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

public function st_esito tb_update (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception;//====================================================================
//=== Aggiunge rek nella tabella DATI di MEMO
//=== 
//=== Input: st_tab_clienti_memo
//=== output: id_cliente_memo
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati
st_esito kst_esito
st_open_w kst_open_w
//st_tab_clienti_memo kst_tab_clienti_memo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_memo.id_cliente > 0 then
else
	kst_esito.SQLErrText = "Tab.dati MEMO clienti: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
	if kst_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_memo.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_anag_memo
	
//--- controlla se utente autorizzato alla funzione in atto
//	try
//		k_rc = if_sicurezza(kst_open_w )
//	catch (uo_exception kuo_exception)
//		
//	end try
	
//	if not k_rc then
	
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.SQLErrText = "Modifica dati Memo non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//	
//	else
		
		kst_tab_clienti_memo.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_clienti_memo.x_utente = kGuf_data_base.prendi_x_utente()
	
//		kst_tab_clienti_memo.st_tab_clienti_memo = st_tab_clienti_memo
//		this.if_isnull( kst_tab_clienti_memo )
//		st_tab_clienti_memo = kst_tab_clienti_memo.st_tab_clienti_memo

		k_rcn = 0
		if kst_tab_clienti_memo.id_memo > 0 then
			select distinct 1
				into :k_rcn
				from clienti_memo
				WHERE id_memo = :kst_tab_clienti_memo.id_memo 
				using kguo_sqlca_db_magazzino;
		end if			
		
	//--- tento l'insert se manca in arch.
		if kguo_sqlca_db_magazzino.sqlcode  >= 0 then

			if k_rcn > 0 then
				UPDATE clienti_memo  
				  		SET id_cliente = :kst_tab_clienti_memo.id_cliente
						    ,tipo_sv =  :kst_tab_clienti_memo.tipo_sv
							 ,allarme = :kst_tab_clienti_memo.allarme
							,x_datins = :kst_tab_clienti_memo.x_datins
							,x_utente = :kst_tab_clienti_memo.x_utente  
							WHERE id_memo = :kst_tab_clienti_memo.id_memo 
							using kguo_sqlca_db_magazzino;
//					if kguo_sqlca_db_magazzino.sqlcode = 0 then
//						UPDATEBLOB clienti_memo  
//					  		SET 
//								memo = :kst_tab_clienti_memo.memo
//							WHERE id_memo = :kst_tab_clienti_memo.id_memo 
//							using kguo_sqlca_db_magazzino;
//					end if
//				else
//					delete from clienti_memo
//						WHERE id_memo = :kst_tab_clienti_memo.id_memo 
//						using kguo_sqlca_db_magazzino;
//				end if	
			else
				
				if NOT k_senza_dati then
					//id_cliente_memo
					INSERT INTO clienti_memo  
								(
								tipo_sv
								,id_memo
								,id_cliente
								 ,allarme
								,x_datins 
								,x_utente 
								 )  
						  VALUES ( 
							:kst_tab_clienti_memo.tipo_sv
							,:kst_tab_clienti_memo.id_memo 
							,:kst_tab_clienti_memo.id_cliente 
							,:kst_tab_clienti_memo.allarme 
							,:kst_tab_clienti_memo.x_datins
							,:kst_tab_clienti_memo.x_utente  
							)  
						using kguo_sqlca_db_magazzino;
					if kguo_sqlca_db_magazzino.sqlcode = 0 then
						kst_tab_clienti_memo.id_cliente_memo = get_id_cliente_memo_max()
						//kst_tab_clienti_memo.id_cliente_memo = long(kguo_sqlca_db_magazzino.SQLReturnData)
	
//						UPDATEBLOB clienti_memo  
//						  SET 
//							memo = :kst_tab_clienti_memo.memo
//							WHERE id_memo = :kst_tab_clienti_memo.id_memo 
//							using kguo_sqlca_db_magazzino;
					end if	
				end if
					
			end if
			
		end if	
	
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.dati Memo:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
					if kst_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_memo.st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_rollback( )
					end if
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
		else
			if kst_tab_clienti_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	
//	end if

return kst_esito

end function

public function long get_id_meca_causale (readonly st_tab_clienti ast_tab_clienti) throws uo_exception;//--------------------------------------------------------------------
//--- Legge tabella CLIENTI per reperire il id_meca_causale
//--- 
//--- Input: ast_tab_clienti.codice
//--- Out: 
//--- Ritorna tab. ast_tab_clienti.id_meca_causale   
//--- 
//---  lancia uo_exception
//--------------------------------------------------------------------
//
st_esito kst_esito
long k_return = 0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT
		  id_meca_causale
    INTO 
	 	  :ast_tab_clienti.id_meca_causale
        FROM clienti
        WHERE ( codice = :ast_tab_clienti.codice)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Cliente per Causale Entrata Merce id=" +string(ast_tab_clienti.codice) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_clienti.id_meca_causale > 0 then
			k_return =  ast_tab_clienti.id_meca_causale
		end if
	end if
end if


return k_return



end function

public function string get_id_nazione (readonly st_tab_clienti ast_tab_clienti) throws uo_exception;//--------------------------------------------------------------------
//--- Legge tabella CLIENTI per reperire il id_nazione_1
//--- 
//--- Input: ast_tab_clienti.codice
//--- Out: 
//--- Ritorna tab. ast_tab_clienti.id_nazione_1  (space forzato a 'IT' = ITALIA)   
//--- 
//---  lancia uo_exception
//--------------------------------------------------------------------
//
st_esito kst_esito
string k_return = "IT"


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT
		  id_nazione_1
    INTO 
	 	  :ast_tab_clienti.id_nazione_1
        FROM clienti
        WHERE ( codice = :ast_tab_clienti.codice)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Cliente per codice Nazione id=" +string(ast_tab_clienti.codice) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_clienti.id_nazione_1) > " " then
			k_return = ast_tab_clienti.id_nazione_1
		else
			k_return = "IT"
		end if
	end if
end if


return trim(k_return)



end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_clienti kst_tab_clienti);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = ""  then
			kdw_anteprima.dataobject = "d_clienti_1_anteprima"		
		end if
	end if

	if kst_tab_clienti.codice > 0 or kdw_anteprima.dataobject <> "d_clienti_1_anteprima" then

//		kdw_anteprima.dataobject = "d_clienti_1"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Anagrafica da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function long get_codice_da_rag_soc (ref string a_rag_soc_10) throws uo_exception;//
//-----------------------------------------------------------------------------------------------
//--- Torna CODICE da Ragione sociale (prima parte)
//--- 
//--- Inp: ragione sociale   
//--- Out: ragione sociale competa trovata
//--- rit: codice
//--- lancia Exception uo_exception
//--- 
//-----------------------------------------------------------------------------------------------
string k_codice = ""
string k_stato
st_esito kst_esito
st_tab_clienti kst_tab_clienti


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.codice = 0
	
//--- 
  	if trim(a_rag_soc_10) > " " then
		
		kst_tab_clienti.rag_soc_10 = "%" + trim(a_rag_soc_10) + "%" 
		kst_tab_clienti.rag_soc_10 = kguo_g.u_replace(kst_tab_clienti.rag_soc_10, " ", "%")
		kst_tab_clienti.stato = kki_cliente_stato_estinto
		
		SELECT codice, rag_soc_10
			 into :kst_tab_clienti.codice
			 	,  :kst_tab_clienti.rag_soc_10
			 FROM clienti
			 where codice in (
		SELECT min(codice)
			 FROM clienti
			 where clienti.rag_soc_10 like :kst_tab_clienti.rag_soc_10 
			      and clienti.stato <> :kst_tab_clienti.stato)
				using kguo_sqlca_db_magazzino ;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Clienti (ricerca codice da nome: " + trim(a_rag_soc_10) + "). Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText) //~n~r
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 or isnull(kst_tab_clienti.codice) then
				kst_tab_clienti.codice = 0
			else
				a_rag_soc_10 = trim(kst_tab_clienti.rag_soc_10)
			end if
		end if
		
	end if

return kst_tab_clienti.codice





end function

public function st_esito anteprima_elenco_memo (datastore kdw_anteprima, st_tab_clienti kst_tab_clienti);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_clienti_memo_l"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_clienti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun 'MEMO' da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public subroutine get_id_memo_max_x_id_cliente (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception;//
//====================================================================
//=== Torna ultimo ID_MEMO x id_cliente 
//=== 
//=== Input: st_tab_clienti_memo id_cliente 
//=== Output: st_tab_clienti_memo.id_memo                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  max(ID_MEMO)
       into :kst_tab_clienti_memo.ID_MEMO
		 FROM clienti_memo
		 where  id_cliente = :kst_tab_clienti_memo.id_cliente //and tipo_sv = :kst_tab_clienti_memo.tipo_sv
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca max id MEMO in tab Memo-Clienti (id cliente = " + string(kst_tab_clienti_memo.id_cliente) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_clienti_memo.ID_MEMO > 0 then
	else
		kst_tab_clienti_memo.ID_MEMO = 0
	end if





end subroutine

public function string get_email_prontomerce (ref st_tab_clienti_web kst_tab_clienti_web) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------
//--- Torna email_prontomerce 
//--- 
//--- Input: st_tab_clienti_web.id_cliente     Output: st_tab_clienti_web.email_prontomerce   (nr. email)               
//--- Ritorna e-mail estesa pronto merce 
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti_web.email_prontomerce = 0


   if kst_tab_clienti_web.id_cliente > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca codice cliente in Lettura email pronto merce."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- get prima del numero email da usare 
	SELECT clienti_web.email_prontomerce
		 into :kst_tab_clienti_web.email_prontomerce
		 FROM clienti_web
		 where clienti_web.id_cliente = :kst_tab_clienti_web.id_cliente
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Clienti per ricerca e-mail di avviso pronto merce (Cliente: " + string(kst_tab_clienti_web.id_cliente) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- da numero email da usare piglio l'indirizzo
	if kst_tab_clienti_web.email_prontomerce > 0 then
		k_return = get_email_indirizzo(kst_tab_clienti_web, kst_tab_clienti_web.email_prontomerce)
	end if 


return k_return





end function

public function string get_email_indirizzo (st_tab_clienti_web ast_tab_clienti_web, integer a_nr_email) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------
//--- Torna indirizzo email 
//--- 
//--- Input: st_tab_clienti_web.id_cliente  k_nr_email
//--- Ritorna e-mail estesa pronto merce 
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

   if ast_tab_clienti_web.id_cliente > 0 then
		
		kst_esito = get_email(ast_tab_clienti_web)
		if kst_esito.esito = kkg_esito.ok then
	//--- scelta del e-mail ta tornare			
			choose case a_nr_email
				case 1
					k_return = ast_tab_clienti_web.email
				case 2
					k_return = ast_tab_clienti_web.email1
				case 3
					k_return = ast_tab_clienti_web.email2
				case 4
					k_return = ast_tab_clienti_web.email3
			end choose
			if isnull(k_return) then k_return = ""
		end if
				
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca codice cliente in Lettura indirizzo email ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.SQLErrText = "Errore in Lettura Clienti per ricerca indirizzo email (Cliente: " + string(ast_tab_clienti_web.id_cliente) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


return k_return





end function

public function boolean if_attivo (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- IF Cliente è nello stato di ATTIVO?
//--- 
//--- Inp: codice 
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ATTIVO, FALSE=DA ATTIVARE
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if kst_tab_clienti.codice > 0 then

		kst_tab_clienti.stato = kki_cliente_stato_attivo
		select 1
				into :k_ctr
				from clienti 
				where clienti.codice = :kst_tab_clienti.codice and stato = :kst_tab_clienti.stato
				using kguo_sqlca_db_magazzino ;
				
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				k_return = false
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in verifica 'STATO ATTIVO' del Cliente: " + string(kst_tab_clienti.codice)  + " ~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in verifica 'STATO ATTIVO cliente': manca il codice " 
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function boolean if_attivo_attivoparziale (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- IF Cliente è nello stato di ATTIVO o ATTIVO PARZIALE?
//--- 
//--- Inp: codice 
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ATTIVO, FALSE=DA ATTIVARE
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_clienti kst_tab_clienti_attivo, kst_tab_clienti_attivoparziale

uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if kst_tab_clienti.codice > 0 then

		kst_tab_clienti_attivo.stato = kki_cliente_stato_attivo
		kst_tab_clienti_attivoparziale.stato = kki_cliente_stato_attivo_parziale
		select 1
				into :k_ctr
				from clienti 
				where clienti.codice = :kst_tab_clienti.codice and stato in (:kst_tab_clienti_attivo.stato, :kst_tab_clienti_attivoparziale.stato)
				using kguo_sqlca_db_magazzino ;
				
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				k_return = false
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica STATO ATTIVO/ATT-PARZIALE del Cliente: " + string(kst_tab_clienti.codice)  + " ~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore verifica ESTINZIONE Cliente: manca il codice " 
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function decimal get_impon_minimo (st_tab_clienti_fatt kst_tab_clienti_fatt) throws uo_exception;//
//====================================================================
//=== Torna  impon_minimo  importo minimo di fatturazione
//=== 
//=== Input: st_tab_clienti_fatt.id_cliente
//=== Ritorna ST_ESITO
//=== 
//====================================================================
dec k_return = 0.00
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  impon_minimo
     	  into :kst_tab_clienti_fatt.impon_minimo
		 FROM clienti_fatt
		 where  ID_CLIENTE = :kst_tab_clienti_fatt.id_cliente
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Importo minimo di Fatturazione  del Cliente (codice= " + string(kst_tab_clienti_fatt.id_cliente) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_clienti_fatt.impon_minimo > 0 then
		k_return = kst_tab_clienti_fatt.impon_minimo
	else
		k_return = 0.00
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return




end function

public function boolean if_bloccato (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- IF Cliente è stato BLOCCATO?
//--- 
//--- Inp: codice 
//--- Out: id_meca_causale
//--- Ritorna BOOLEAN : TRUE=BLOCCATO, FALSE=OK
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if kst_tab_clienti.codice > 0 then

		kst_tab_clienti.stato = kki_cliente_stato_attivo
		select id_meca_causale
				into :kst_tab_clienti.id_meca_causale
				from clienti 
				where clienti.codice = :kst_tab_clienti.codice 
				using kguo_sqlca_db_magazzino ;
				
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
			if kst_tab_clienti.id_meca_causale > 0 then
				k_return = true
			end if
			
		else
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				k_return = false
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in verifica 'CAUSALE DI BLOCCO' del Cliente: " + string(kst_tab_clienti.codice)  + " ~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in verifica 'CAUSALE DI BLOCCO cliente': manca il codice " 
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function integer get_e1an_altro (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna codice E1 max se trovato diverso da quello passato
//--- 
//--- Input: st_tab_clienti e1an, codice   
//--- Output: se ZERO = non usato altrimento il codice cliente già che lo usa oltre a quello passato                  
//--- Lancia errore UE_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
long k_return = 0
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT max(codice)
       into :k_return
		 FROM clienti
		 where codice = :kst_tab_clienti.codice
		 		and e1an = :kst_tab_clienti.e1an
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca codice E1 " + string(kst_tab_clienti.e1an) + " in Anagrafica (codice " &
					+ string(kst_tab_clienti.codice) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	if isnull(k_return) then k_return = 0

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return





end function

public function long get_e1an (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna codice E1 
//--- 
//--- Input: st_tab_clienti codice   
//--- Output: codice E1            
//--- Lancia errore UE_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
long k_return = 0
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1an
       into :k_return
		 FROM clienti
		 where codice = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca codice E1 da codice " + string(kst_tab_clienti.codice) + " in Anagrafica " &
					+  + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	if isnull(k_return) then k_return = 0

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return





end function

public function string get_e1ancodrs (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna codice compresso (rag_soc) alfanumerico di E1 
//--- 
//--- Input: st_tab_clienti codice   
//--- Output: codice  E1ANCODRS            
//--- Lancia errore UE_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1ancodrs
       into :k_return
		 FROM clienti
		 where codice = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca codice nome compresso E1 da codice " + string(kst_tab_clienti.codice) + " in Anagrafica " &
					+  + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	if isnull(k_return) then k_return = ""

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return





end function

public function string get_pklbcodepref (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna il prefisso dei barcode cliente nel pkl 
//---               (es. goglio ha '00' davati a tutti i suoi barcode)
//--- 
//--- Input: st_tab_clienti codice   
//--- Output: pklbcodepref            
//--- Lancia errore UE_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT pklbcodepref
       into :k_return
		 FROM clienti
		 where codice = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca prefisso barcode per il cliente " + string(kst_tab_clienti.codice) + " in Anagrafica " &
					+  + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	if isnull(k_return) then k_return = ""

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return





end function

public function long get_mrf_e1an (st_tab_m_r_f kst_tab_m_r_f) throws uo_exception;//====================================================================
//=== Torna il codice legame per E1
//=== 
//=== INP: kst_tab_m_r_f  clie_1 e clie_2 e clie_3 
//=== OUT: kst_tab_m_r_f.e1an 
//=== Lancia Exception con ST_ESITO
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if isnull(kst_tab_m_r_f.clie_1) then kst_tab_m_r_f.clie_1 = 0 
	if isnull(kst_tab_m_r_f.clie_2) then kst_tab_m_r_f.clie_2 = 0 
	if isnull(kst_tab_m_r_f.clie_3) then kst_tab_m_r_f.clie_3 = 0 

	
	if kst_tab_m_r_f.clie_1 > 0 or kst_tab_m_r_f.clie_3 > 0 then 	
		
		SELECT m_r_f.e1an
			 into :kst_tab_m_r_f.e1an
			 FROM m_r_f
				where clie_1 = :kst_tab_m_r_f.clie_1 
				  and clie_2 = :kst_tab_m_r_f.clie_2
				  and clie_3 = :kst_tab_m_r_f.clie_3
				using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			if kst_tab_m_r_f.e1an > 0 then
				k_return = kst_tab_m_r_f.e1an   // OK codice per E1 trovato!!
			end if
			
		else

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
					
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore in lettura codice E1 in Tab. Mandanti-Riceventi-Fatt. mand=" + string(kst_tab_m_r_f.clie_1) &
											+ ", ricev="+string(kst_tab_m_r_f.clie_2)+", fatt="+string(kst_tab_m_r_f.clie_3)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			
			end if
		end if
	end if
			

return k_return




end function

public function string get_codice_ipa (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna codice IPA utilizzato per fare le fattura alla PA
//--- 
//--- Input: st_tab_clienti codice   
//--- rit: codice_ipa            
//--- Lancia errore UE_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT codice_ipa
       into :k_return
		 FROM clienti_fatt
		 where id_cliente = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca codice IPA della PA del Cliente " + string(kst_tab_clienti.codice) + " in Anagrafica " &
					+  + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

	if isnull(k_return) then
		k_return = ""
	else
		k_return = trim(k_return)
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return





end function

public function boolean if_cliente_pa (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- verifica se è un Cliente PA 
//--- 
//--- Inp: codice 
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ok è PA, FALSE=non PA
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if kst_tab_clienti.codice > 0 then

		if get_codice_ipa(kst_tab_clienti) > " " then
			k_return = true
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Errore in verifica se Cliente PA. Manca il codice " 
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	kst_esito.SQLErrText = "Errore in verifica se Cliente " + string(kst_tab_clienti.codice)  + " è della PA~n~r " + kguo_sqlca_db_magazzino.sqlerrtext
	throw kuo_exception

finally
	

end try	
	
return k_return


end function

public function string get_tipo (st_tab_clienti kst_tab_clienti) throws uo_exception;//--- 
//--- Identifica il TIPO ANAGRAFE ovvero se Cliente/Mandante/Ricevente o multitipo
//---
string k_return
boolean k_clie_1=false, k_clie_2=false, k_clie_3=false
long k_riga, k_righe
st_esito kst_esito
datastore kds_1


try 
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.tipo_mrf = ""
	
	if kst_tab_clienti.codice > 0 then
		
		kds_1 = create datastore
		kds_1.dataobject = "ds_m_r_f_l"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		
		k_righe = kds_1.retrieve(kst_tab_clienti.codice)

//		select first 1 1
//			into :k_conta_clie_3
//			from m_r_f
//			where clie_3 = :kst_tab_clienti.codice  ;
		
		if k_righe < 0 then
			
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo): " + string(k_righe) //trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
				
		end if
		
		if k_righe = 0 then
			kst_tab_clienti.tipo_mrf = kki_tipo_mrf_NESSUNO
		else
		
			k_riga = kds_1.find("clie_1 = " + string(kst_tab_clienti.codice), 1, k_righe)
			if k_riga > 0 then
				k_clie_1 = true
			end if
			k_riga = kds_1.find("clie_2 = " + string(kst_tab_clienti.codice), 1, k_righe)
			if k_riga > 0 then
				k_clie_2 = true
			end if
			k_riga = kds_1.find("clie_3 = " + string(kst_tab_clienti.codice), 1, k_righe)
			if k_riga > 0 then
				k_clie_3 = true
			end if
//			
//			select first 1 1
//				into :k_conta_clie_1
//				from m_r_f
//				where clie_1 = :kst_tab_clienti.codice  ;
//			
//			if sqlca.sqlcode < 0 then
//				
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo):" + trim(sqlca.SQLErrText)
//				kst_esito.esito = kkg_esito.db_ko
//
//			else
//				
//				select first 1 1
//					into :k_conta_clie_2
//					from m_r_f
//					where clie_2 = :kst_tab_clienti.codice  ;
//				
//				if sqlca.sqlcode < 0 then
//					
//					kst_esito.sqlcode = sqlca.sqlcode
//					kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo):" + trim(sqlca.SQLErrText)
//					kst_esito.esito = kkg_esito.db_ko
//
//				else

			if k_clie_1 and k_clie_2 and k_clie_3 then
				kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_MAN_RIC
			else
				if k_clie_1 then
					kst_tab_clienti.tipo_mrf = kki_tipo_mrf_MANDANTE
					if k_clie_2 then
						kst_tab_clienti.tipo_mrf = kki_tipo_mrf_MAN_RIC
					else
						if k_clie_3 then
							kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_MAN
						end if
					end if
				else
					if k_clie_2 then
						kst_tab_clienti.tipo_mrf = kki_tipo_mrf_RICEVENTE
						if k_clie_3 then
							kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_RIC
						end if
					else
						if k_clie_3 then
							kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATTURATO
						else
							kst_tab_clienti.tipo_mrf = kki_tipo_mrf_NESSUNO
						end if
					end if
				end if
			end if
//				end if
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally	
	k_return = kst_tab_clienti.tipo_mrf
	
end try

return k_return


end function

public function long get_codice_da_e1an (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna CODICE da codice id E1 se ce n'è più di uno torna l'ultimo
//--- 
//--- Input: st_tab_clienti.e1an     
//--- Output: 
//--- rit: e1an
//--- Ritorna ST_ESITO
//--- 
//--------------------------------------------------------------------
long k_return
string k_codice = ""
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.codice = 0

	if kst_tab_clienti.e1an > 0 then
	
	 	SELECT max(codice)
       into :kst_tab_clienti.codice
		 FROM clienti
		 where clienti.e1an = :kst_tab_clienti.e1an
			using sqlca;

		
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Clienti (da id E1: " + string(kst_tab_clienti.e1an) + ")  ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			if kst_tab_clienti.codice > 0 then
				k_return = kst_tab_clienti.codice 
			end if
		end if
	
	end if

return k_return 




end function

public function long get_id_cliente_memo_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID  inserito 
//--- 
//---  input: 
//---  ret: max ID_CLIENTE_MEMO
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_cliente_memo)
		 INTO 
				:k_return
		 FROM clienti_memo  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Memo Cliente in tabella (CLIENTI_MEMO)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public function long get_codice_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo CODICE inserito 
//--- 
//---  input: 
//---  ret: max CODICE
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(codice)
		 INTO 
				:k_return
		 FROM clienti  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo Codice Cliente in tabella (CLIENTI)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

public subroutine get_delivery (ref st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna campi delivey (n. giorni e ora)
//--- 
//--- Inp: st_tab_clienti.codice
//--- Out: st_tab_clienti delivery_dd_after, delivery_hour                  
//--- Lancia errore UO_EXCEPTION
//--- 
//---------------------------------------------------------------------------------------------
//
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT coalesce(delivery_dd_after, 0)
	           , coalesce(delivery_hour, convert(time, '00:00'))
       into :kst_tab_clienti.delivery_dd_after
		    ,:kst_tab_clienti.delivery_hour
		 FROM clienti
		 where codice = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca dati Consegna in Anagrafica (codice " &
					+ string(kst_tab_clienti.codice) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end subroutine

public function string get_email_attestato (st_tab_clienti kst_tab_clienti) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------
//--- Torna email_attestato 
//--- 
//--- Input: kst_tab_clienti.codice  
//--- Ritorna e-mail estesa x invio Attestati
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_tab_clienti_fatt kst_tab_clienti_fatt
st_tab_clienti_web kst_tab_clienti_web
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


   if kst_tab_clienti.codice > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca codice cliente in Lettura indirizzi email x Attestato."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- get prima del numero email da usare 
	SELECT clienti_fatt.email_invio
		 into :kst_tab_clienti_fatt.email_invio
		 FROM clienti_fatt
		 where clienti_fatt.id_cliente = :kst_tab_clienti.codice
			using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Clienti per ricerca indirizzo e-mail per allegare gli Attessati (Cliente: " + string(kst_tab_clienti.codice) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- da numero email da usare piglio l'indirizzo
	if isnumber(kst_tab_clienti_fatt.email_invio) then
		if kst_tab_clienti_fatt.email_invio > "0" then
			kst_tab_clienti_web.id_cliente = kst_tab_clienti.codice
			k_return = get_email_indirizzo(kst_tab_clienti_web, integer(kst_tab_clienti_fatt.email_invio))
		end if 
	end if 


return k_return





end function

on kuf_clienti.create
call super::create
end on

on kuf_clienti.destroy
call super::destroy
end on

