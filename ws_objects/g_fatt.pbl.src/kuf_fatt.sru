$PBExportHeader$kuf_fatt.sru
forward
global type kuf_fatt from kuf_parent
end type
end forward

global type kuf_fatt from kuf_parent
end type
global kuf_fatt kuf_fatt

type variables
//
public st_tab_arfa kist_tab_arfa
private string ki_dw_stampa_fattura = "d_fattura_st_ed7_05_2016"  //"d_fattura_st_ed6_09_2015"  //"d_fattura_st_ed5_05_2013" // "d_fattura_st_ed4_05_2011" //"d_fattura_st_ed3_08_2009" //"d_fattura_st_ed_2008"
private datastore kids_stampa_fattura
private int ki_fattura_riga_corpo = 0
private constant int ki_fattura_riga_corpo_max= 19
private string ki_stampante_predefinita = " "
private st_fattura_stampa kist_fattura_stampa_riga_old
private int ki_pag_fattura=0
private string ki_path_risorse=""

//--- costanti DW 
public constant string kki_dw_righe_non_fatt = "d_armo_l_no_fatt"   //elenco Lotti da FATT con Attestato
public constant string kki_dw_righe_no_fatt_no_dose = "d_armo_l_nofatt_notratt" //"d_armo_l_no_fatt_no_dose" 
public constant string kki_dw_s_lotti_da_fatt = "ds_s_armo_da_fatt" 
public constant string kki_dw_righe_fatt = "d_armo_l_fatt" 
public constant string kki_dw_sped_non_fatt = "d_arsp_l_non_fatt" 
public constant string kki_dw_elenco_indirizzi = "d_arfa_l_indirizzi" 
public constant string kki_dw_elenco_note = "d_note_fat1_l" 

//--- Tipo Documento
public string kki_tipo_doc_fattura = "FT"
public string kki_tipo_doc_AutoFattura = "AF"
public string kki_tipo_doc_proforma = "PF"
public string kki_tipo_doc_nota_di_credito = "NC"
public string kki_tipo_doc_integrazione = "IF"

//--- Tipo Riga
public string kki_tipo_riga_maga = "A"
public string kki_tipo_riga_varia = "V"

//--- flag di stato
public string kki_stampa_da_stampare = "N"
public string kki_stampa_stampato = "S"
public string kki_stampa_da_non_stampare = "F"

//--- Cadenza Fattura
public constant string kki_cadenza_fattura_fine_mese = "M"
public constant string kki_cadenza_fattura_meta_mese = "Q"

//--- Path Fattura ovvero path indicato sul campo base_dir.dir_fatt + id_del_cliente + kki_path_digitale
//private constant string kki_path_digitale_prova = "\diProva"
//private constant string kki_path_digitale = "\daInviare"  

//--- Emissione Fattura su Stampa in Digitale 
public constant string kki_modo_stampa_cartaceo = "S"
public constant string kki_modo_stampa_digitale = "D"
public constant string kki_modo_stampa_cartedig = "E"

//--- Esporta solamente senza generare ad esempio x e-mail
public constant string kki_esporta_documento_si = "S"

//--- Emissione di prova / effettiva 
public constant string kki_stampa_diProva_si = "S"
public constant string kki_stampa_diProva_no = "N"

//--- Emissione Fattura in Stampa o Digitale
public constant string kki_modo_email_avvisa = "A"
public constant string kki_modo_email_allega = "F"
public constant string kki_modo_email_no = "N"

//--- Numero della e-mail a cui inviare (ad oggi il cliente prevede fino a 3 email)
public constant string kki_email_invio_default = "1"
public constant string kki_email_invio_email1 = "1"
public constant string kki_email_invio_email2 = "2"
public constant string kki_email_invio_email3 = "3"

//--- sotto-cartelle dove mettere le fatture digitali (pdf)
private constant string kki_path_file_prodotto_diProva = "\diProva"
private constant string kki_path_file_prodotto_daInviare = "\Digitale" //"\daInviare"
private constant string kki_path_file_prodotto_Storico = "\Cartaceo" //"\storico"

//--- campo Stampa Tradotta
public constant string kki_arfa_testa_stampa_tradotta_IT = "IT"
public constant string kki_arfa_testa_stampa_tradotta_EN = "EN"


end variables

forward prototypes
public function st_esito tb_delete (st_tab_arfa kst_tab_arfa)
public subroutine if_isnull_testa (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_fattura_no_id_meca ()
public function st_esito get_tipo_pagamento (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_note (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_tipo_documento (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_scadenze (ref st_tab_arfa kst_tab_arfa, ref st_fattura_scadenze kst_fattura_scadenze)
public function boolean produci_fattura_open ()
public function boolean produci_fattura_piede_scadenze (ref st_fattura_scadenze kst_fattura_scadenze)
public function boolean produci_fattura_riga (ref st_fattura_stampa kst_fattura_stampa)
public function boolean produci_fattura_testa (ref st_fattura_stampa kst_fattura_stampa)
public function st_esito get_cliente (ref st_tab_arfa kst_tab_arfa)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_arfa kst_tab_arfa)
public function boolean produci_fattura_piede_note (ref st_tab_arfa kst_tab_arfa)
public function long produci_fattura_nuova_pagina ()
public function integer stampa_fattura (ds_fatture kds_fatture) throws uo_exception
public function integer produci_fattura (ref ds_fatture kds_fatture) throws uo_exception
public function integer get_fatture_da_stampare (ds_fatture kds_fatture) throws uo_exception
public function st_esito produci_fattura_set_dw_loghi (ref datawindow kdw_1)
public function st_esito produci_fattura_set_dw_loghi (ref datastore kdw_1)
private function long produci_fattura_riga_add ()
public function integer u_tree_riempi_listview_righe_fatt (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_righe_fatt (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito get_riga_varia (ref st_tab_arfa kst_tab_arfa)
public subroutine produci_fattura_fine ()
public subroutine if_isnull_scadenze (ref st_fattura_scadenze kst_fattura_scadenze)
public subroutine if_isnull_totali (ref st_fattura_totali kst_fattura_totali)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_arfa kst_tab_arfa)
public function double get_importo_t_anno_x_clie_3 (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public subroutine get_prezzo_t (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function st_esito tb_update_testa (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_insert_testa (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_insert_dett (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_update_dett (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_id (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_testata (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_spese_inc (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_importi_x_profis (ref st_tab_arfa kst_tab_arfa, ref st_tab_prof kst_tab_prof[])
public function st_esito aggiorna_tabelle_correlate (ref st_tab_arfa kst_tab_arfa[])
public function st_esito set_note (ref st_tab_arfa kst_tab_arfa)
public subroutine get_ultimo_numero (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean get_prezzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean u_open_cancellazione (ref st_tab_arfa kst_tab_arfa)
public subroutine get_numero_da_id (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean u_open_inserimento (ref st_tab_arfa kst_tab_arfa)
public function boolean u_open_modifica (ref st_tab_arfa kst_tab_arfa)
public function boolean u_open_visualizza (ref st_tab_arfa kst_tab_arfa)
public function boolean u_open (st_tab_arfa kst_tab_arfa[], st_open_w kst_open_w)
public function integer u_tree_open (string k_modalita, st_tab_arfa kst_tab_arfa[], ref datawindow kdw_anteprima)
public function boolean u_open_stampa (ref st_tab_arfa kst_tab_arfa[])
public subroutine elenco_indirizzi_commerciale (st_tab_arfa kst_tab_arfa)
public subroutine elenco_note (st_tab_arfa kst_tab_arfa)
public function boolean produci_fattura_piede_totali (st_tab_arfa kst_tab_arfa, readonly st_fattura_totali kst_fattura_totali)
public function string get_banca_di_fattura () throws uo_exception
public function string get_norme_bolli (st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito get_prezzi_fattura (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_delete_dett (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_indirizzo_fattura (ref st_tab_arfa kst_tab_arfa)
public function st_esito tb_delete_ripristina_correlati (st_tab_arfa kst_tab_arfa)
public function st_esito tb_update_numero_data (st_tab_arfa kst_tab_arfa)
public function boolean if_num_data_congruenti (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function st_esito get_ultimo_doc_ins (ref st_tab_arfa kst_tab_arfa)
public function boolean if_esiste_fattura (st_tab_arfa kst_tab_arfa) throws uo_exception
public function double get_totale_x_cliente_periodo (st_tab_arfa kst_tab_arfa_da, st_tab_arfa kst_tab_arfa_a) throws uo_exception
public function st_esito get_data_stampa (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_modo_stampa (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_modo_email (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_file_prodotto (ref st_tab_arfa kst_tab_arfa)
public function st_esito set_file_prodotto (ref st_tab_arfa kst_tab_arfa)
public function st_esito get_email_invio (ref st_tab_arfa kst_tab_arfa)
public function string get_email_indirizzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function long get_id_email (st_tab_arfa kst_tab_arfa) throws uo_exception
public function long add_email_invio (st_tab_arfa kst_tab_arfa) throws uo_exception
public function st_esito get_id_email_invio (ref st_tab_arfa kst_tab_arfa)
public function st_esito set_id_email_invio (ref st_tab_arfa kst_tab_arfa)
public function boolean stampa_fattura_emissione (string titolo) throws uo_exception
public function integer stampa_fattura_nuova (ref ds_fatture kds_fatture) throws uo_exception
public function integer stampa_fattura_digitale (ds_fatture kds_fatture) throws uo_exception
public function string get_path_documento_digitale_dainviare (st_tab_arfa kst_tab_arfa) throws uo_exception
public function string get_path_documento_digitale_diprova (st_tab_arfa kst_tab_arfa) throws uo_exception
public function string get_path_documento_digitale_storico (st_tab_arfa kst_tab_arfa) throws uo_exception
public function integer delete_fattura_digitale (st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean if_fattura_duplicata (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function string get_comunicazione () throws uo_exception
public function boolean get_form_di_stampa (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean set_form_di_stampa (st_tab_arfa kst_tab_arfa) throws uo_exception
public subroutine produci_fattura_inizializza (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public subroutine produci_fattura_inizio () throws uo_exception
public function boolean set_flag_stampa (st_tab_arfa kst_tab_arfa) throws uo_exception
public function integer produci_fattura_aggiorna (ref st_tab_arfa kst_tab_arfa[]) throws uo_exception
public function long aggiorna_docprod (ref st_tab_arfa kst_tab_arfa[]) throws uo_exception
public function boolean set_id_docprod (st_tab_arfa kst_tab_arfa) throws uo_exception
public function st_esito get_totali (ref st_tab_arfa ast_tab_arfa, ref st_fattura_totali ast_fattura_totali)
public function long get_id_da_id_armo (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function long get_cod_pag (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean if_esiste_id_armo_prezzo (st_tab_arfa kst_tab_arfa) throws uo_exception
public function st_esito tb_delete_x_rif () throws uo_exception
public function boolean if_chiuso (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean if_modifica_chiuso () throws uo_exception
public function boolean get_colli_x_id_armo_prezzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean if_cancella (st_tab_arfa ast_tab_arfa) throws uo_exception
public function boolean if_modifica (st_tab_arfa ast_tab_arfa) throws uo_exception
public function string get_stampa_tradotta (st_tab_arfa kst_tab_arfa) throws uo_exception
public function string get_tipo_documento_descrizione (st_tab_arfa ast_tab_arfa)
public function boolean if_ddt_fatturato (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean set_cambio_ddt_num_data (st_tab_arfa kst_tab_arfa_old, st_tab_arfa kst_tab_arfa_new) throws uo_exception
public function long get_colli_x_id_armo (ref st_tab_arfa kst_tab_arfa) throws uo_exception
public function long get_colli_fatturati (readonly st_tab_arfa kst_tab_arfa) throws uo_exception
public function long get_colli_fatturati_x_id_armo (readonly st_tab_arfa kst_tab_arfa) throws uo_exception
public function boolean if_f_splitpayment (st_tab_arfa kst_tab_arfa) throws uo_exception
public subroutine tb_delete (st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception
public subroutine tb_update (ref st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception
public subroutine tb_insert (ref st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception
public function long get_id_arfa_max () throws uo_exception
public function long get_id_fattura_max () throws uo_exception
public function long get_id_arfa_v_max () throws uo_exception
end prototypes

public function st_esito tb_delete (st_tab_arfa kst_tab_arfa);//
//====================================================================
//=== Cancella il rek dalla tabella ARFA (Fatture) 
//=== 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
int k_resp, k_pdf_cancellati=0
boolean k_return
st_esito kst_esito
st_tab_ricevute kst_tab_ricevute
st_tab_prof kst_tab_prof
st_tab_arfa kst_tab_arfa_pdf
st_tab_arfa kst_tab_arfa1
st_tab_arfa_pa kst_tab_arfa_pa
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza
kuf_prof kuf1_prof
kuf_ricevute kuf1_ricevute



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//kst_open_w.id_programma = kkg_id_programma_fatture
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//if not k_return then
//
//	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//	kst_esito.SQLErrText = "Cancellazione Documento di Vendita non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	try
		k_return = if_sicurezza(kkg_flag_modalita.cancellazione)
	
		if (kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura)) and kst_tab_arfa.num_fatt > 0 then
			this.get_id( kst_tab_arfa )
		else
			if (kst_tab_arfa.num_fatt = 0 or isnull(kst_tab_arfa.num_fatt)) and kst_tab_arfa.id_fattura > 0 then
				get_numero_da_id(kst_tab_arfa)
			end if
		end if

		if kst_tab_arfa.id_fattura > 0 then

//--- get il nome del file della Fattura Digitale (pdf)	
			kst_tab_arfa_pdf = kst_tab_arfa
			this.get_file_prodotto(kst_tab_arfa_pdf)
			

//--- cancella prima tutte le righe varie
			delete from arfa_v
					WHERE num_fatt = :kst_tab_arfa.num_fatt
							and data_fatt = :kst_tab_arfa.data_fatt;
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle righe Varie della Fattura ~n~r" &
						+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			else

//--- cancello archivi correlati x singole righe		
				kst_tab_arfa1 = kst_tab_arfa
				kst_tab_arfa1.st_tab_g_0.esegui_commit = "N"
				declare c_delete_arfa cursor for 
					select id_arfa
					    from arfa
						WHERE num_fatt = :kst_tab_arfa.num_fatt
								and data_fatt = :kst_tab_arfa.data_fatt
								using kguo_sqlca_db_magazzino;
								
				open c_delete_arfa;								
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					fetch c_delete_arfa into  :kst_tab_arfa1.id_arfa;
					do while kguo_sqlca_db_magazzino.sqlcode = 0 and kst_esito.esito <> kkg_esito.db_ko 
						
//--- Avvia cancellazione archivi correlati x singole righe		
						kst_esito = this.tb_delete_ripristina_correlati( kst_tab_arfa1 )
												
						fetch c_delete_arfa into  :kst_tab_arfa1.id_arfa;
					loop
					close c_delete_arfa;
				end if
				
//--- se tutto ok cancella anche le altre righe
				delete from arfa
						WHERE num_fatt = :kst_tab_arfa.num_fatt
								and data_fatt = :kst_tab_arfa.data_fatt;
				
				if kguo_sqlca_db_magazzino.sqlcode >= 0 then
					
//--- se tutto ok cancella anche le altre tabelle -----------------------------------------------------------------------------------------

				
		//--- cancello la TESTATA							
					delete from arfa_testa
							WHERE num_fatt = :kst_tab_arfa.num_fatt
									and data_fatt = :kst_tab_arfa.data_fatt;
									
		//--- cancello le NOTE							
					delete from fat1
							WHERE num_fatt = :kst_tab_arfa.num_fatt
									and data_fatt = :kst_tab_arfa.data_fatt;
									
		//--- cancello dati PA (fatt elettronica)
					kst_tab_arfa_pa.id_fattura = kst_tab_arfa.id_fattura
					tb_delete(kst_tab_arfa_pa)

		//--- cancello anche le RICEVUTE							
					kuf1_ricevute = create kuf_ricevute
					kst_tab_ricevute.num_fatt = kst_tab_arfa.num_fatt
					kst_tab_ricevute.data_fatt = kst_tab_arfa.data_fatt
					kuf1_ricevute.tb_delete_x_fatt( kst_tab_ricevute )
					destroy kuf1_ricevute
					
		//--- cancello movim passaggio Conatbilità (PROFIS) 
					kuf1_prof = create kuf_prof
					kst_tab_prof.num_fatt = kst_tab_arfa.num_fatt
					kst_tab_prof.data_fatt = kst_tab_arfa.data_fatt
					kuf1_prof.tb_delete( kst_tab_prof )
					destroy kuf1_prof
				
				else
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
		"Errore durante la cancellazione della Fattura ~n~r" &
						+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARFA:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
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
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			else
				if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if

//--- Se tutto OK allora cancello file digitale (pdf) dalla cartella		
			if kst_esito.esito = kkg_esito.db_ko and len(trim(kst_tab_arfa_pdf.file_prodotto)) > 0 then
				k_pdf_cancellati = delete_fattura_digitale(kst_tab_arfa_pdf)		
			end if
		
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		
	end try
//end if


return kst_esito

end function

public subroutine if_isnull_testa (ref st_tab_arfa kst_tab_arfa);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_arfa.num_fatt) then	kst_tab_arfa.num_fatt = 0
if isnull(kst_tab_arfa.data_fatt) then	kst_tab_arfa.data_fatt = date(0)
if isnull(kst_tab_arfa.data_stampa) then	kst_tab_arfa.data_stampa = datetime(date(0))
if isnull(kst_tab_arfa.id_fattura) then	kst_tab_arfa.id_fattura = 0
if isnull(kst_tab_arfa.id_arfa) then	kst_tab_arfa.id_arfa = 0
if isnull(kst_tab_arfa.id_arfa_se_nc) then	kst_tab_arfa.id_arfa_se_nc = 0
if isnull(kst_tab_arfa.id_arfa_v) then	kst_tab_arfa.id_arfa_v = 0
if isnull(kst_tab_arfa.id_arsp) then	kst_tab_arfa.id_arsp = 0
if isnull(kst_tab_arfa.id_armo) then	kst_tab_arfa.id_armo = 0
if isnull(kst_tab_arfa.id_armo_prezzo) then	kst_tab_arfa.id_armo_prezzo = 0
if isnull(kst_tab_arfa.num_bolla_out) then	kst_tab_arfa.num_bolla_out = 0
if isnull(kst_tab_arfa.data_bolla_out) then	kst_tab_arfa.data_bolla_out = date(0)
if isnull(kst_tab_arfa.tipo_l) then kst_tab_arfa.tipo_l = " "
if isnull(kst_tab_arfa.stampa) then kst_tab_arfa.stampa = " "
if isnull(kst_tab_arfa.tipo_riga) then kst_tab_arfa.tipo_riga = " "
if isnull(kst_tab_arfa.nriga) then kst_tab_arfa.nriga = 0
if isnull(kst_tab_arfa.tipo_doc) then kst_tab_arfa.tipo_doc = " "
if isnull(kst_tab_arfa.colli) then	kst_tab_arfa.colli = 0
if isnull(kst_tab_arfa.colli_out) then	kst_tab_arfa.colli_out = 0
if isnull(kst_tab_arfa.peso_kg_out) then	kst_tab_arfa.peso_kg_out = 0
if isnull(kst_tab_arfa.iva) then	kst_tab_arfa.iva = 0

if isnull(kst_tab_arfa.clie_3) then	kst_tab_arfa.clie_3 = 0
if isnull(kst_tab_arfa.rag_soc_1)  then kst_tab_arfa.rag_soc_1 = " "	
if isnull(kst_tab_arfa.rag_soc_2)   then	kst_tab_arfa.rag_soc_2 = " "
if isnull(kst_tab_arfa.indi)   then	kst_tab_arfa.indi = " "
if isnull(kst_tab_arfa.cap)  then kst_tab_arfa.cap = " "	
if isnull(kst_tab_arfa.loc)  then kst_tab_arfa.loc = " "	
if isnull(kst_tab_arfa.prov)  then kst_tab_arfa.prov = " "	
if isnull(kst_tab_arfa.id_nazione)  then kst_tab_arfa.id_nazione = " "	 


if isnull(kst_tab_arfa.prezzo_u) then kst_tab_arfa.prezzo_u = 0
if isnull(kst_tab_arfa.prezzo_t) then	 kst_tab_arfa.prezzo_t = 0
if isnull(kst_tab_arfa.peso_kg_out) then	kst_tab_arfa.peso_kg_out = 0
if isnull(kst_tab_arfa.cod_pag) then kst_tab_arfa.cod_pag = 0
if isnull(kst_tab_arfa.comm) then kst_tab_arfa.comm = " "
if isnull(kst_tab_arfa.contratto) then kst_tab_arfa.contratto = 0

if isnull(kst_tab_arfa.note_1) then kst_tab_arfa.note_1 = " "
if isnull(kst_tab_arfa.note_2) then kst_tab_arfa.note_2 = " "
if isnull(kst_tab_arfa.note_3) then kst_tab_arfa.note_3 = " "
if isnull(kst_tab_arfa.note_4) then kst_tab_arfa.note_4 = " "
if isnull(kst_tab_arfa.note_5) then kst_tab_arfa.note_5 = " "
if isnull(kst_tab_arfa.note_normative) then kst_tab_arfa.note_normative = " "

if isnull(kst_tab_arfa.modo_stampa ) then kst_tab_arfa.modo_stampa = ""
if isnull(kst_tab_arfa.modo_email ) then kst_tab_arfa.modo_email = ""
if isnull(kst_tab_arfa.email_invio ) then kst_tab_arfa.email_invio = ""
if isnull(kst_tab_arfa.file_prodotto ) then kst_tab_arfa.file_prodotto = ""

if isnull(kst_tab_arfa.x_utente) then kst_tab_arfa.x_utente = " "
if isnull(kst_tab_arfa.x_datins) then	kst_tab_arfa.x_datins = datetime(date(0))


end subroutine

public function st_esito tb_fattura_no_id_meca ();//
//====================================================================
//=== Ritorna se esistono righe in fattura diverse dal id Riferimento 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK esistono; 1=Non esistono
//===                                     100=not found
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
long k_ctr
st_tab_meca kst_tab_meca
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- ci sono righe varie?
	select count(num_fatt) 
		 into :k_ctr
			from arfa_v
		 where num_fatt = :kist_tab_arfa.num_fatt
		       and data_fatt = :kist_tab_arfa.num_fatt
				 	using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Ricerca in fattura righe no Riferimento " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "3"
			else	
				kst_esito.esito = "2"
			end if
		end if
	else
		if k_ctr > 0 then
			kst_esito.esito = "0"
		else
			kst_esito.esito = "1"
		end if
	end if
		
//--- se non ho trovato righe allora vedo altre righe fattura		
	if kst_esito.esito = "1" then
		
		select distinct id_meca 
		   into :kst_tab_meca.id
			from armo 
			where id_armo = :kist_tab_arfa.id_armo
			using sqlca;
		
		if sqlca.sqlcode = 0 then
			select count(num_fatt) 
				 into :k_ctr
					from arfa
				 where num_fatt = :kist_tab_arfa.num_fatt
						 and data_fatt = :kist_tab_arfa.num_fatt
						 and id_armo not in
							(select id_armo from armo 
							where id_meca = :kst_tab_meca.id)
							using sqlca;
		
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Ricerca in fattura righe no Riferimento (kuf_fatt.tb_fattura_no_id_meca) " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "3"
					else	
						kst_esito.esito = "2"
					end if
				end if
			else
				if k_ctr > 0 then
					kst_esito.esito = "0"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "2"
			kst_esito.SQLErrText = "Errore in Ricerca id Riferimento (kuf_fatt.tb_fattura_no_id_meca) " &
											 + trim(SQLCA.SQLErrText)
		end if
	end if	

return kst_esito


end function

public function st_esito get_tipo_pagamento (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Tipo Pagamento della Fattura indicata
//---
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	
if kst_tab_arfa.id_fattura > 0 then 

   select cod_pag
	   into :kst_tab_arfa.cod_pag
	   from  ARFA_testa
       where ARFA_testa.id_fattura   =  :kst_tab_arfa.id_fattura 
       using sqlca;
		 
	if sqlca.sqlcode <> 0 then

		select max(cod_pag)
			into :kst_tab_arfa.cod_pag
			from  ARFA
   		    where ARFA.id_fattura   =  :kst_tab_arfa.id_fattura 
			using sqlca;
//			 where ARFA.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
//						  and ARFA.DATA_FATT =  :kst_tab_arfa.DATA_FATT 
			 
		if sqlca.sqlcode = 100 then
			select max(cod_pag)
				into :kst_tab_arfa.cod_pag
				from  ARFA_V
   		   	 where id_fattura   =  :kst_tab_arfa.id_fattura 
				 using sqlca;
		end if
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Tipo Pagamento Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
									 + trim(SQLCA.SQLErrText)
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
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Lettura 'Tipo Pagamento' (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito get_note (ref st_tab_arfa kst_tab_arfa);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



if kst_tab_arfa.id_fattura > 0 then

    select
                  FAT1.NOTE_1,
                  FAT1.NOTE_2,
                  FAT1.NOTE_3,
                  FAT1.NOTE_4,
                  FAT1.NOTE_5,
				note_normative
			into 
				:kst_tab_arfa.note_1,
				:kst_tab_arfa.note_2,
				:kst_tab_arfa.note_3,
				:kst_tab_arfa.note_4,
				:kst_tab_arfa.note_5,
				:kst_tab_arfa.note_normative
		from fat1
              where FAT1.id_fattura    = :kst_tab_arfa.id_fattura
		using sqlca;

else

    select
                  FAT1.NOTE_1,
                  FAT1.NOTE_2,
                  FAT1.NOTE_3,
                  FAT1.NOTE_4,
                  FAT1.NOTE_5,
				note_normative
			into 
				:kst_tab_arfa.note_1,
				:kst_tab_arfa.note_2,
				:kst_tab_arfa.note_3,
				:kst_tab_arfa.note_4,
				:kst_tab_arfa.note_5,
				:kst_tab_arfa.note_normative
		from fat1
              where FAT1.NUM_FATT    = :kst_tab_arfa.NUM_FATT   and
                        FAT1.DATA_FATT   = :kst_tab_arfa.DATA_FATT
		using sqlca;

end if

if sqlca.sqlcode <> 0 then
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Lettura della Tabella Note di Fattura (num.=" + string(kst_tab_arfa.NUM_FATT) &
									+ " del " + string(kst_tab_arfa.DATA_FATT) + "). Err.: " &
									+ trim(SQLCA.SQLErrText)
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

//--- toglie i null	
if_isnull_testa(kst_tab_arfa)


return kst_esito


end function

public function st_esito get_tipo_documento (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il campo Tipo Documento  (NC=nota di credito, FT=fattura, PF=proforma, ecc...)
//---
st_esito kst_esito 
long k_ctr

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.tipo_doc
		into :kst_tab_arfa.tipo_doc
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;
	
//if kst_tab_arfa.num_fatt > 0 then 
//	  select max(TIPO_DOC)
//		into :kst_tab_arfa.tipo_doc
//				from  ARFA 
//				where ARFA.NUM_FATT   = :kst_tab_arfa.NUM_FATT
//						and ARFA.DATA_FATT = :kst_tab_arfa.DATA_FATT
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 or isnull(kst_tab_arfa.tipo_doc) then
//		
//		select max(TIPO_DOC)
//			into :kst_tab_arfa.tipo_doc
//						from  ARFA_V
//						where ARFA_V.NUM_FATT   = :kst_tab_arfa.NUM_FATT
//								and ARFA_V.DATA_FATT = :kst_tab_arfa.DATA_FATT
//			using sqlca;
//	end if			

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Non Trovato il 'Tipo' x il Documento (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura 'Tipo' x il Documento (id=" + string(kst_tab_arfa.id_fattura ) + ") " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura 'Tipo Documento'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito get_scadenze (ref st_tab_arfa kst_tab_arfa, ref st_fattura_scadenze kst_fattura_scadenze);//--
//---  Torna Scadenze (Importo + data) della Fattura indicata x metterli in stampa
//--- input: st_tab_arfa con estremi fattura
//--- out: kst_fattura_scadenze tutta valorizzata
//---
int k_ind=0
st_esito kst_esito 
st_tab_ricevute kst_tab_ricevute
st_ricevute_scadenze kst_ricevute_scadenze
kuf_ricevute kuf1_ricevute


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- toglie i null
if_isnull_scadenze(kst_fattura_scadenze)

if kst_tab_arfa.num_fatt > 0 then 


	kuf1_ricevute = create kuf_ricevute
	kst_tab_ricevute.num_fatt = kst_tab_arfa.num_fatt
	kst_tab_ricevute.data_fatt = kst_tab_arfa.data_fatt
	kst_esito = kuf1_ricevute.get_scadenze( kst_tab_ricevute, kst_ricevute_scadenze)
	destroy kuf1_ricevute
	
	if kst_esito.esito = kkg_esito.ok then
		
		for k_ind =1 to 6

			choose case k_ind
				case 1
					if kst_ricevute_scadenze.importo_1 > 0 then
						kst_fattura_scadenze.importo_1 = kst_ricevute_scadenze.importo_1
						kst_fattura_scadenze.data_1 = kst_ricevute_scadenze.data_1
					else
						kst_fattura_scadenze.importo_1 = 0
					end if
				case 2
					if kst_ricevute_scadenze.importo_2 > 0 then
						kst_fattura_scadenze.importo_2 = kst_ricevute_scadenze.importo_2
						kst_fattura_scadenze.data_2 = kst_ricevute_scadenze.data_2
					else
						kst_fattura_scadenze.importo_2 = 0
					end if
				case 3
					if kst_ricevute_scadenze.importo_3 > 0 then
						kst_fattura_scadenze.importo_3 = kst_ricevute_scadenze.importo_3
						kst_fattura_scadenze.data_3 = kst_ricevute_scadenze.data_3
					else
						kst_fattura_scadenze.importo_3 = 0
					end if
				case 4
					if kst_ricevute_scadenze.importo_4 > 0 then
						kst_fattura_scadenze.importo_4 = kst_ricevute_scadenze.importo_4
						kst_fattura_scadenze.data_4 = kst_ricevute_scadenze.data_4
					else
						kst_fattura_scadenze.importo_4 = 0
					end if
				case 5
					if kst_ricevute_scadenze.importo_5 > 0 then
						kst_fattura_scadenze.importo_5 = kst_ricevute_scadenze.importo_5
						kst_fattura_scadenze.data_5 = kst_ricevute_scadenze.data_5
					else
						kst_fattura_scadenze.importo_5 = 0
					end if
				case else
					if kst_ricevute_scadenze.importo_6 > 0 then
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Scadenze Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
													 + ": Attenzione Troppe Scadenze!! "
						kst_esito.esito = kkg_esito.err_logico
					end if
			end choose
				
		next

	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Calcolo Totali Fattura  (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function boolean produci_fattura_open ();//---
//--- Apre l'output di stampa
//---
boolean k_return=true
kuf_base kuf1_base		


	kuf1_base = create kuf_base
		
//--- piglia la stampante della fattura	
	ki_stampante_predefinita = trim(mid(kuf1_base.prendi_dato_base( "stamp_fattura"),2))


	destroy kuf1_base


return k_return
end function

public function boolean produci_fattura_piede_scadenze (ref st_fattura_scadenze kst_fattura_scadenze);//---
//--- In stampa Scadenze di piede fattura
//---
boolean k_return=true
long k_riga


//--- ricava riga 
	k_riga = kids_stampa_fattura.getrow( ) 
	
//--- stampa totali IVA	
	if kst_fattura_scadenze.importo_1 > 0 then
		kids_stampa_fattura.setitem(k_riga, "scadenza_1", string(kst_fattura_scadenze.data_1) + " € "+  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") )  
	end if
	if kst_fattura_scadenze.importo_2 > 0 then
		kids_stampa_fattura.setitem(k_riga, "scadenza_2", string(kst_fattura_scadenze.data_2) + " € "+  string(kst_fattura_scadenze.importo_2, "###,###,##0.00") )  
	end if
	if kst_fattura_scadenze.importo_3 > 0 then
		kids_stampa_fattura.setitem(k_riga, "scadenza_3", string(kst_fattura_scadenze.data_3) + " € "+  string(kst_fattura_scadenze.importo_3, "###,###,##0.00") )  
	end if
	if kst_fattura_scadenze.importo_4 > 0 then
		kids_stampa_fattura.setitem(k_riga, "scadenza_4", string(kst_fattura_scadenze.data_4) + " € "+  string(kst_fattura_scadenze.importo_4, "###,###,##0.00") )  
	end if
//	if kst_fattura_scadenze.importo_5 > 0 then
//		kids_stampa_fattura.setitem(k_riga, "scadenza_5",  string(kst_fattura_scadenze.importo_1, "###,###,##0.00") + " il "+ string(kst_fattura_scadenze.data_5))  
//	end if

	kst_fattura_scadenze.importo_1 = 0
	kst_fattura_scadenze.importo_2 = 0
	kst_fattura_scadenze.importo_3 = 0
	kst_fattura_scadenze.importo_4 = 0
	kst_fattura_scadenze.importo_5 = 0
	

return k_return

end function

public function boolean produci_fattura_riga (ref st_fattura_stampa kst_fattura_stampa);//---
//--- Corpo Fattura: Riga di Dettaglio
//---
boolean k_return=true
string k_stampante
long k_riga
kuf_base kuf1_base		



//--- a rottura di Numero di Bolla stampo gli estremi della stessa
	if  kst_fattura_stampa.kst_tab_arfa.num_bolla_out > 0 then
		if kst_fattura_stampa.kst_tab_arfa.num_bolla_out <> kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out then

			k_riga = produci_fattura_riga_add() //--- aggiungo riga e controllo Fine Pagina
			if k_riga = 0 then 
				k_return = false
			else   
				kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
									"Ns. d.d.t. nr.  " + string(kst_fattura_stampa.kst_tab_arfa.num_bolla_out) &
									+ "  del  " + string(kst_fattura_stampa.kst_tab_arfa.data_bolla_out) &
									)
			end if
		end if
	end if

//--- a rottura di DOSE / MC-CO / DDT  stampa i KGY e il codice  CONTRATTO 
	if kst_fattura_stampa.kst_tab_armo.dose > 0 and (kst_fattura_stampa.kst_tab_armo.dose <> kist_fattura_stampa_riga_old.kst_tab_armo.dose &
			or kst_fattura_stampa.kst_tab_arfa.num_bolla_out <> kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out &
			or kst_fattura_stampa.kst_tab_contratti.mc_co <> kist_fattura_stampa_riga_old.kst_tab_contratti.mc_co) then

		k_riga = produci_fattura_riga_add() //--- aggiungo riga e controllo Fine Pagina
		if k_riga = 0 then 
			k_return = false
		else   
			if trim(kst_fattura_stampa.kst_tab_contratti.mc_co) > " " then
				kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
									"LAVORAZIONE kGy " + string(kst_fattura_stampa.kst_tab_armo.dose, "##0.0#") &
									+ " - Contr. " + trim(kst_fattura_stampa.kst_tab_contratti.mc_co) & 
									)
			else
				kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
									"LAVORAZIONE kGy " + string(kst_fattura_stampa.kst_tab_armo.dose, "##0.0#") &
									)
		
			end if
			//  + "/" +  string(kst_fattura_stampa.kst_tab_contratti.data, "yyyy") & 
//									"lavorazione kGy : " + string(kst_fattura_stampa.kst_tab_armo.dose, "##0.0#") &
		end if
	end if
	
//--- Se NO DOSE a rottura di codice  CONTRATTO 
	if kst_fattura_stampa.kst_tab_armo.dose = 0 and (kst_fattura_stampa.kst_tab_contratti.mc_co <> kist_fattura_stampa_riga_old.kst_tab_contratti.mc_co) then

		k_riga = produci_fattura_riga_add() //--- aggiungo riga e controllo Fine Pagina
		if k_riga = 0 then 
			k_return = false
		else   
			kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
                                        "Rif. Contratto n. " + trim(kst_fattura_stampa.kst_tab_contratti.mc_co) + " del " +  string(kst_fattura_stampa.kst_tab_contratti.data, "dd/mm/yy") &								
												)
		end if
	end if
	
////--- A rottura di codice  CIG (codice della PA)
//	if kst_fattura_stampa.kst_tab_arfa.codice_cig <> kist_fattura_stampa_riga_old.kst_tab_arfa.codice_cig then
//
//		k_riga = produci_fattura_riga_add() //--- aggiungo riga e controllo Fine Pagina
//		if k_riga = 0 then 
//			k_return = false
//		else   
//			kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo), &
//                                        "Rif. codice CIG " + trim(kst_fattura_stampa.kst_tab_arfa.codice_cig) &								
//												)
//		end if
//	end if

//--- riga fattura	
	k_riga = produci_fattura_riga_add() //--- aggiungo riga e controllo Fine Pagina
	if k_riga = 0 then 
		k_return = false
	else 
//--- espone il codice VOCE oppure il codice PRODOTTO (vecchia modalità)		
		if kst_fattura_stampa.kst_tab_listino_voci.id_listino_voce > 0 then
			kids_stampa_fattura.setitem(k_riga, "art_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_listino_voci.id_listino_voce)  
//			kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_listino_voci.descr_xctr)
		else
			kids_stampa_fattura.setitem(k_riga, "art_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_armo.art)  
//			kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_prodotti.des)
		end if
		kids_stampa_fattura.setitem(k_riga, "descr_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.des)

		if kst_fattura_stampa.kst_tab_arfa.colli_out > 0 then
			choose case  kst_fattura_stampa.kst_tab_arfa.tipo_l
				case kuf_listino.kki_tipo_prezzo_a_peso
					kids_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "Kg.")  
				case kuf_listino.kki_tipo_prezzo_a_metro_cubo
					kids_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "M.C.")  
				case else
					kids_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  "N.")  
			end choose
		else
			kids_stampa_fattura.setitem(k_riga, "um_" + string(ki_fattura_riga_corpo),  " ")  
		end if
	
		kids_stampa_fattura.setitem(k_riga, "qta_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.colli_out)  
		kids_stampa_fattura.setitem(k_riga, "prezzo_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.prezzo_u)  
		kids_stampa_fattura.setitem(k_riga, "imponibile_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.prezzo_t)  
		kids_stampa_fattura.setitem(k_riga, "iva_" + string(ki_fattura_riga_corpo),  kst_fattura_stampa.kst_tab_arfa.iva)  

	end if
	
	if kst_fattura_stampa.kst_tab_arfa.num_bolla_out <> kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out then
		kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out = kst_fattura_stampa.kst_tab_arfa.num_bolla_out
	end if
	if kst_fattura_stampa.kst_tab_armo.dose > 0 and kst_fattura_stampa.kst_tab_armo.dose <> kist_fattura_stampa_riga_old.kst_tab_armo.dose 	then
		kist_fattura_stampa_riga_old.kst_tab_armo.dose = kst_fattura_stampa.kst_tab_armo.dose
	end if	
	
return k_return

end function

public function boolean produci_fattura_testa (ref st_fattura_stampa kst_fattura_stampa);//---
//--- Apre l'output di stampa
//---
boolean k_return=true
string k_stampante="",  k_rcx="", k_file="", k_causale=" "
long k_riga=0
int k_rc=0
kuf_base kuf1_base
kuf_ausiliari kuf1_ausiliari
kuf_clienti kiuf_clienti

//--- imposta il dw
	k_riga = kids_stampa_fattura.insertrow( 0 ) 
	kids_stampa_fattura.setrow(k_riga)

//--- tolg i NULL
	kiuf_clienti = create kuf_clienti
	kiuf_clienti.if_isnull( kst_fattura_stampa.kst_tab_clienti)
	destroy kiuf_clienti
	
//--- Indirizzo di spedizione impostato in Fattura diverso dal commerciale?
	if len(trim(kst_fattura_stampa.kst_tab_arfa.rag_soc_1)) > 0 or len(trim(kst_fattura_stampa.kst_tab_arfa.rag_soc_2)) > 0 then
		if trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c) <> trim(kst_fattura_stampa.kst_tab_arfa.rag_soc_1) &
					or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c)  <> trim(kst_fattura_stampa.kst_tab_arfa.rag_soc_2)  & 
					or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.indi_c)  <> trim(kst_fattura_stampa.kst_tab_arfa.indi)   & 
					or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.cap_c)  <> trim(kst_fattura_stampa.kst_tab_arfa.cap)   &
					or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.loc_c)  <> trim(kst_fattura_stampa.kst_tab_arfa.loc)   & 
					or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.prov_c)  <> trim(kst_fattura_stampa.kst_tab_arfa.prov)  &  
				 then
//					or trim(kst_fattura_stampa.kst_tab_clienti.id_nazione_1)  <> trim(kst_fattura_stampa.kst_tab_arfa.id_nazione)  & 
					
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c = kst_fattura_stampa.kst_tab_arfa.rag_soc_1 
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = kst_fattura_stampa.kst_tab_arfa.rag_soc_2  
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.indi_c  = kst_fattura_stampa.kst_tab_arfa.indi   
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.cap_c  = kst_fattura_stampa.kst_tab_arfa.cap  
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.loc_c = kst_fattura_stampa.kst_tab_arfa.loc  
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.prov_c = kst_fattura_stampa.kst_tab_arfa.prov   
			kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.id_nazione_c = kst_fattura_stampa.kst_tab_arfa.id_nazione
		end if
	end if
	
	
//--- riga intestazione fattura	
	if trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c) <> trim(kst_fattura_stampa.kst_tab_clienti.rag_soc_10) &
				or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c)  <> trim(kst_fattura_stampa.kst_tab_clienti.rag_soc_11)   & 
				or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.indi_c)  <> trim(kst_fattura_stampa.kst_tab_clienti.indi_1)  & 
				or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.cap_c)  <> trim(kst_fattura_stampa.kst_tab_clienti.cap_1) &
				or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.loc_c)  <> trim(kst_fattura_stampa.kst_tab_clienti.loc_1)  & 
				or trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.prov_c)  <> trim(kst_fattura_stampa.kst_tab_clienti.prov_1) then 
		
		if kids_stampa_fattura.Describe("stampa_tradotta.Name") = "stampa_tradotta"  then // controlla se esiste la colonna
			k_rc=kids_stampa_fattura.setitem(k_riga, "stampa_tradotta",  kst_fattura_stampa.kst_tab_arfa.stampa_tradotta ) 
		end if
		
		if kst_fattura_stampa.kst_tab_arfa.stampa_tradotta = "EN" then
			k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_intest",  "Addressed to " ) 
			k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_sped",  "Sent to " )  
		else
			k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_intest",  "Intestato a " ) 
			k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_sped",  "Spedito a " )  
		end if
		k_rc=kids_stampa_fattura.setitem(k_riga, "intestazione",  kst_fattura_stampa.kst_tab_clienti.RAG_SOC_10 + " ~n~r " &  
																				+ kst_fattura_stampa.kst_tab_clienti.RAG_SOC_11 + "  ~n~r"  )
 
		k_rc=kids_stampa_fattura.setitem(k_riga, "intestazione_ind",  kst_fattura_stampa.kst_tab_clienti.INDI_1 + " ~n~r" &    
																				+ kst_fattura_stampa.kst_tab_clienti.CAP_1 +"  " &
																				+ trim(kst_fattura_stampa.kst_tab_clienti.LOC_1) + "  (" &
																				+ trim(kst_fattura_stampa.kst_tab_clienti.PROV_1) + ")  ~n~r" &  
																				+ trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.nome)  )
																				
	else
		k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_intest",  "  " ) 
		k_rc=kids_stampa_fattura.setitem(k_riga, "dicit_ind_sped",  "  " )  

		if not isvalid(kuf1_ausiliari) then kuf1_ausiliari = create kuf_ausiliari
		kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.id_nazione = kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.id_nazione_c
		kuf1_ausiliari.tb_select(kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni)
	end if
	

//--- riga indirizzo	
	k_rc=kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_1",  kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.RAG_SOC_1_c)  
	k_rc=kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_2",  kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.RAG_SOC_2_c)  
	k_rc=kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_3",  kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.INDI_c)  
	kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_4",  kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.CAP_c+" " &
																	+ trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.LOC_c) + " " &
																	+ trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.PROV_c) )  

    if len(trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.nome)) > 0 &
	         and len(trim(kst_fattura_stampa.kst_tab_clienti.kst_tab_ind_comm.id_nazione_c)) > 0 then
		k_rc=kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_5",  kst_fattura_stampa.kst_tab_clienti.kst_tab_nazioni.nome)  
	end if

//--- riga numero fattura, partita IVA ecc....	
	kids_stampa_fattura.setitem(k_riga, "codice",  string(kst_fattura_stampa.kst_tab_arfa.clie_3))  
	if len(trim(kst_fattura_stampa.kst_tab_clienti.p_iva)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "piva",  trim(kst_fattura_stampa.kst_tab_clienti.p_iva))  
	else
		if len(trim(kst_fattura_stampa.kst_tab_clienti.cf)) > 0 then
			kids_stampa_fattura.setitem(k_riga, "piva",  trim(kst_fattura_stampa.kst_tab_clienti.cf))  
		else
			kids_stampa_fattura.setitem(k_riga, "piva", " ")  
		end if
	end if
	k_causale = get_tipo_documento_descrizione( kst_fattura_stampa.kst_tab_arfa )  // descrizione tipo documento
	kids_stampa_fattura.setitem(k_riga, "causale",  k_causale)  
	kids_stampa_fattura.setitem(k_riga, "numero_fattura",  kst_fattura_stampa.kst_tab_arfa.num_fatt)  
	kids_stampa_fattura.setitem(k_riga, "data_fattura",  string(kst_fattura_stampa.kst_tab_arfa.data_fatt))  

//--- riga tipo pagamento e banca di appoggio	
	if kst_fattura_stampa.kst_tab_pagam.codice > 0 then
		kids_stampa_fattura.setitem(k_riga, "pagamento", string(kst_fattura_stampa.kst_tab_pagam.codice,"####")+ " " + trim(kst_fattura_stampa.kst_tab_pagam.des))  
	end if
	if kst_fattura_stampa.kst_tab_pagam.tipo = kuf_ausiliari.ki_tab_pagam_tipo_rim_diretta then
		kids_stampa_fattura.setitem(k_riga, "banca", " ")  
	else
		if len(trim(kst_fattura_stampa.kst_tab_clienti.banca)) > 0 then
			kids_stampa_fattura.setitem(k_riga, "banca",  trim(kst_fattura_stampa.kst_tab_clienti.banca) + " " &
						+ string(kst_fattura_stampa.kst_tab_clienti.abi) + " " + string(kst_fattura_stampa.kst_tab_clienti.cab))  
		else
			kids_stampa_fattura.setitem(k_riga, "banca", " ")  
		end if
	end if

return k_return

end function

public function st_esito get_cliente (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Codice Cliente della Fattura indicata
//---
//---  input: st_tab_arfa.num_fatt e data_fatt   oppure  id_fattura
//---  otput: st_tab_arfa.clie_3
//---
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_arfa.clie_3 = 0
if kst_tab_arfa.id_fattura > 0 then 

   select id_cliente
	   into :kst_tab_arfa.clie_3
	   from  ARFA_TESTA
       where id_fattura   =  :kst_tab_arfa.id_fattura 
       using sqlca;
else
	if kst_tab_arfa.num_fatt > 0 then 
		
		k_anno = year(kst_tab_arfa.DATA_FATT)
		select max(clie_3)
			into :kst_tab_arfa.clie_3
			from  ARFA
			 where ARFA.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
						  and year(ARFA.DATA_FATT) =  :k_anno 
			 using sqlca;
			 
		if sqlca.sqlcode = 100 or kst_tab_arfa.clie_3 = 0 or isnull(kst_tab_arfa.clie_3) then
			select max(clie_3)
				into :kst_tab_arfa.clie_3
				from  ARFA_V
				 where ARFA_v.NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
									  and year(ARFA_V.DATA_FATT) =  :k_anno 
				 using sqlca;
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca numero Fattura/ID per Lettura Cliente Fattura (arfa) " 
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if
	
if sqlca.sqlcode <> 0 then
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Lettura Cliente Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa) " &
								 + trim(SQLCA.SQLErrText)
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

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_arfa kst_tab_arfa);//
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
int k_n_fatture_stampate=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
ds_fatture kds_fatture


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_arfa.num_fatt > 0 or kst_tab_arfa.id_fattura > 0 then

	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
	kst_open_w.id_programma = kkg_id_programma_fatture
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	

		try 

//--- piglia il numero di fattura se assente 
			if  kst_tab_arfa.num_fatt = 0 then
				get_numero_da_id(kst_tab_arfa)
			end if

//---- inizializza x stampa fattura
			produci_fattura_inizializza(kst_tab_arfa)
			
			kdw_anteprima.dataobject = kids_stampa_fattura.dataobject   //ki_dw_stampa_fattura		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
	
			kdw_anteprima.reset()	

			kds_fatture = create ds_fatture
			kds_fatture.insertrow(0)
			kds_fatture.object.num_fatt[1] =  kst_tab_arfa.num_fatt
			kds_fatture.object.data_fatt[1] =  kst_tab_arfa.data_fatt
			
//--- produci_fattura	
			k_n_fatture_stampate = produci_fattura(kds_fatture)
		
			if k_n_fatture_stampate > 0 then
				produci_fattura_set_dw_loghi(kdw_anteprima)
				kids_stampa_fattura.rowscopy(1,kids_stampa_fattura.rowcount(),Primary!,kdw_anteprima,1,Primary!)
				kGuf_data_base.dw_copia_attributi_generici(kids_stampa_fattura, kdw_anteprima)
			end if
			
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()

		finally
			if isvalid(kds_fatture) then destroy kds_fatture
//--- distrugge oggetti x stampa fattura
			produci_fattura_fine()
			if isvalid(kuf1_utility) then destroy kuf1_utility
				
		end try
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Nessun Documento da visualizzare: ~n~r" + "nessun numero fattura indicato"
//	kst_esito.esito = kkg_esito.err_formale
		
end if


return kst_esito

end function

public function boolean produci_fattura_piede_note (ref st_tab_arfa kst_tab_arfa);//---
//--- In stampa NOTE di piede fattura
//---
boolean k_return=true
long k_riga


//--- ricava riga 
	k_riga = kids_stampa_fattura.getrow( ) 
	
//--- stampa NOTE	
	if len(trim(kst_tab_arfa.note_1)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "note_1",  trim(kst_tab_arfa.note_1))  
	end if
	if len(trim(kst_tab_arfa.note_2)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "note_2",  trim(kst_tab_arfa.note_2))  
	end if
	if len(trim(kst_tab_arfa.note_3)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "note_3",  trim(kst_tab_arfa.note_3))  
	end if
	if len(trim(kst_tab_arfa.note_4)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "note_4",  trim(kst_tab_arfa.note_4))  
	end if
	if len(trim(kst_tab_arfa.note_5)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "note_5",  trim(kst_tab_arfa.note_5))  
	end if
	if len(trim(kst_tab_arfa.note_normative)) > 0 then
		kids_stampa_fattura.setitem(k_riga, "norme_bolli",  trim(kst_tab_arfa.note_normative))  
	end if

	kst_tab_arfa.note_1 = " "
	kst_tab_arfa.note_2 = " "
	kst_tab_arfa.note_3 = " "
	kst_tab_arfa.note_4 = " "
	kst_tab_arfa.note_5 = " "
	kst_tab_arfa.note_normative = " "

return k_return

end function

public function long produci_fattura_nuova_pagina ();//---
//--- Ripete la Testata della Pagina Precedente
//---
long k_riga, k_riga_prec
int k_rc


//--- imposta il dw
	k_riga = kids_stampa_fattura.insertrow( 0 ) 
	
	if k_riga > 1 then
		kids_stampa_fattura.setrow(k_riga)	
		k_riga_prec = k_riga - 1
		ki_pag_fattura++

//		kids_stampa_fattura.setitem(k_riga_prec, "divisa", " ")  
//		kids_stampa_fattura.setitem(k_riga_prec, "totale", " ")  
	
//--- riga indirizzo	
		kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_1",  kids_stampa_fattura.object.indirizzo_riga_1[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_2",  kids_stampa_fattura.object.indirizzo_riga_2[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_3",  kids_stampa_fattura.object.indirizzo_riga_3[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_4",  kids_stampa_fattura.object.indirizzo_riga_4[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "indirizzo_riga_5",  kids_stampa_fattura.object.indirizzo_riga_5[k_riga_prec])  

//--- riga numero fattura	
		kids_stampa_fattura.setitem(k_riga, "codice",  kids_stampa_fattura.object.codice[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "piva",  kids_stampa_fattura.object.piva[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "causale",  kids_stampa_fattura.object.causale[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "numero_fattura",  kids_stampa_fattura.object.numero_fattura[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "data_fattura",  kids_stampa_fattura.object.data_fattura[k_riga_prec])  

//--- riga tipo pagamento e banca di appoggio	
		kids_stampa_fattura.setitem(k_riga, "pagamento",  kids_stampa_fattura.object.pagamento[k_riga_prec])  
		kids_stampa_fattura.setitem(k_riga, "banca",  kids_stampa_fattura.object.banca[k_riga_prec])  
	else
		k_riga = 0
	end if

return k_riga

end function

public function integer stampa_fattura (ds_fatture kds_fatture) throws uo_exception;//
//--- stampa fatture (RISTAMPA)
//--- input:  ds_fatture (datastore con elenco fatture)
//--- out: Numero fatture prodotte
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_fatture_stampate=0
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if

	if kds_fatture.rowcount() > 0 then

//--- crea l'oggetto dw da stampare
		produci_fattura_inizio	()
		
//--- produci_fattura	
		k_n_fatture_stampate = produci_fattura(kds_fatture)
	
		if k_n_fatture_stampate > 0 then
//=== stampa dw
			k_stampato=stampa_fattura_emissione( trim("N. Fattura da " &
						 + trim(string(kds_fatture.object.NUM_FATT[1])) + " del " + trim(string(kds_fatture.object.DATA_FATT[1])))) 
	
			if not k_stampato then k_n_fatture_stampate = 0
		end if
		
//--- distrugge oggetti x stampa fattura
		produci_fattura_fine()

		
	end if
	



return k_n_fatture_stampate

end function

public function integer produci_fattura (ref ds_fatture kds_fatture) throws uo_exception;//
//--- Costruisce le fatture da stampare
//--- input:  st_tab_arfa_ini e _fin     da valorizzare num_fatt + data_fatt dalla fattura alla fattura 
//--- out: true = OK, false = non stampata
//---
boolean k_stampato=true, k_sicurezza=true, k_boolean= true
int k_ctr=0, k_n_fatture_prodotte=0
string ki_stampante
string k_view, k_sql, k_sql_w, k_sql_orig, k_query_select_senza_bolla, k_query_select_con_bolla
long k_riga_fatture=0


st_esito kst_esito 
uo_exception kuo_exception
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_tab_clienti kst_tab_clienti
st_tab_arsp kst_tab_arsp
st_tab_pagam kst_tab_pagam
st_tab_base kst_tab_base
st_open_w kst_open_w
st_fattura_stampa kst_fattura_stampa
st_fattura_totali kst_fattura_totali, kst_fattura_totali_NULL
st_fattura_scadenze kst_fattura_scadenze, kst_fattura_scadenze_NULL 
st_tab_listino_voci kst_tab_listino_voci
st_tab_contratti kst_tab_contratti
kuf_clienti kuf1_clienti
kuf_sped kuf1_sped
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausiliari



//---- Nome della view 
k_view = "vx_" + trim(kguo_utente.get_comp()) + "_prd_ft1 "

declare produci_fattura_c1 dynamic cursor for SQLSA ;

k_query_select_senza_bolla = &
	 "  SELECT " &
	 + "     max(NRIGA) " &
	 + "     , 0 , convert(date, '01.01.1899') , TIPO_RIGA, ART, IVA, DOSE, sum(COLLI), sum(COLLI_OUT) " &
	 + "     , sum(PESO_KG_OUT), PREZZO_U, sum(PREZZO_T), PRODOTTI_DES, CAMPIONE  " & 
	 + "     , DES " &
  	 + "     , ID_LISTINO_VOCE, DESCR_XCTR " &
	 + "     , CONTRATTI_MC_CO " &
	 + "     , CONTRATTI_DATA " &
 	 + "   from  " + k_view &
	 + "   group by " &
	 + "        2, 3, TIPO_RIGA " &
	 + "      , ART, IVA, DOSE, PREZZO_U, PRODOTTI_DES, CAMPIONE " &
	 + "     , DES " &
  	 + "      , ID_LISTINO_VOCE, DESCR_XCTR " &
	 + "     , CONTRATTI_MC_CO " &
	 + "     , CONTRATTI_DATA " &
	 + "       " &
	 + "   order by  " &
	 + "      TIPO_RIGA, " &
	 + "      1, " &
	 + "      CAMPIONE desc, " &
	 + "      DOSE, " &
	 + "      ART, " &
	 + "      ID_LISTINO_VOCE " 
//	 + "      NRIGA, " &
	 
k_query_select_con_bolla = &
	 "  SELECT " &
	 + "     max(NRIGA) " &
	 + "     , NUM_BOLLA_OUT, DATA_BOLLA_OUT, TIPO_RIGA, ART, IVA, DOSE, sum(COLLI), sum(COLLI_OUT) " &
	 + "      , sum(PESO_KG_OUT), PREZZO_U, sum(PREZZO_T), PRODOTTI_DES, CAMPIONE  " & 
	 + "     , DES " &
	 + "      , ID_LISTINO_VOCE, DESCR_XCTR " &
	 + "     , CONTRATTI_MC_CO " &
	 + "     , CONTRATTI_DATA " &
	 + "   from  " + k_view &
	 + "   group by " &
	 + "       NUM_BOLLA_OUT, DATA_BOLLA_OUT " &
	 + "     , TIPO_RIGA, ART, IVA, DOSE, PREZZO_U, PRODOTTI_DES, CAMPIONE " &
	 + "     , DES " &
  	 + "     , ID_LISTINO_VOCE, DESCR_XCTR " &
	 + "     , CONTRATTI_MC_CO " &
	 + "     , CONTRATTI_DATA " &
	 + "     , CONTRATTI_DATA " &
	 + "   order by  " &
	 + "      TIPO_RIGA " &
	 + "      ,1 " &
	 + "      ,NUM_BOLLA_OUT  " &
	 + "      ,DATA_BOLLA_OUT  " &
	 + "     , CONTRATTI_MC_CO " &
	 + "      ,CAMPIONE desc " &
	 + "      ,DOSE  " &
	 + "      ,ART  " &
	 + "      ,ID_LISTINO_VOCE " 
//	 + "      NRIGA, " &


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	
	kuf1_utility = create kuf_utility
	kuf1_armo = create kuf_armo
	kuf1_ausiliari = create kuf_ausiliari 
	kuf1_clienti = create kuf_clienti

//	kids_stampa_fattura.reset()

	if kds_fatture.rowcount() > 0 then
       
		if sqlca.sqlcode = 0 then	
			k_boolean = produci_fattura_open()
			if not k_boolean then
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Apertura Report Fallita."
				kst_esito.esito = kkg_esito.no_esecuzione
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if

//--- prende la descrizione della BANCA
		kst_tab_base.fatt_banca = this.get_banca_di_fattura()
//--- prende la Comunicazione (eventuale) da stampare a piede della Fattura
		kst_tab_base.fatt_comunicazione = this.get_comunicazione( )
		
//--------------------------------------- CICLO PRINCIPALE ------------------------------------------------------------------
		for k_riga_fatture = 1 to kds_fatture.rowcount()

			kst_tab_arfa.NUM_FATT = kds_fatture.object.NUM_FATT[k_riga_fatture]
			kst_tab_arfa.DATA_FATT = kds_fatture.object.DATA_FATT[k_riga_fatture]
			kst_tab_arfa.ID_FATTURA = kds_fatture.object.ID_FATTURA[k_riga_fatture]


//---- inizializza x stampa fattura
			produci_fattura_inizializza(kst_tab_arfa)

//--- legge ID se non indicato
			if kst_tab_arfa.ID_FATTURA = 0 or isnull(kst_tab_arfa.ID_FATTURA) then
				kst_esito = this.get_id(kst_tab_arfa )
				if kst_esito.esito = kkg_esito.db_ko then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if
											  
//--- rileva il tipo documento (NC=nota di credito)
			kst_esito = get_tipo_documento( kst_tab_arfa )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if

//--- legge Indrizzo Spedizione Fattura
			kst_esito = this.get_indirizzo_fattura( kst_tab_arfa )
			if kst_esito.esito = kkg_esito.db_ko then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if

//--- legge CLIENTE
			kst_esito = get_cliente( kst_tab_arfa )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			else
				if kst_tab_arfa.clie_3 > 0 and kst_tab_arfa.clie_3 <> kst_tab_clienti.codice then 
					kst_tab_clienti.codice = kst_tab_arfa.clie_3
//--- reperisce indirizzo dal cliente 
					kst_esito = kuf1_clienti.get_indirizzi( kst_tab_clienti )
					if kst_esito.esito <> kkg_esito.ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito )
						throw kuo_exception
					end if
//--- reperisce il flag FATTURA_DA per capire se da BOLLA oppure no					
					kst_esito = kuf1_clienti.get_fattura_da( kst_tab_clienti )
					if kst_esito.esito <> kkg_esito.ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito )
						throw kuo_exception
					end if
				end if
			end if

			
//--- legge tipo di pagamento
			kst_esito = get_tipo_pagamento(kst_tab_arfa)
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
			if kst_tab_arfa.COD_PAG > 0 then
				kst_tab_pagam.codice = kst_tab_arfa.cod_pag
				kst_esito = kuf1_ausiliari.tb_select( kst_tab_pagam )
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
				kuf1_ausiliari.if_isnull_tb(kst_tab_pagam)
			end if
			
	//--- reperisce Metri Cubi di entrata solo se il tipo prezzo a Mt.Cubi
			if kst_tab_arfa.TIPO_L = kuf_listino.kki_tipo_prezzo_a_metro_cubo then
				if kst_tab_arfa.id_armo > 0 then
					kst_tab_armo.id_armo = kst_tab_arfa.id_armo
					kst_esito = kuf1_armo.leggi_riga(  "R", kst_tab_armo )
					if kst_esito.esito <> kkg_esito.ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito )
						throw kuo_exception
					end if
				end if
				kuf1_armo.if_isnull_armo(kst_tab_armo)
					kst_tab_armo.m_cubi = kst_tab_armo.m_cubi / kst_tab_armo.COLLI_2 * kst_tab_arfa.COLLI
			end if

//--- Get della LINGUA di stampa della Fattura
			kst_tab_arfa.stampa_tradotta = get_stampa_tradotta(kst_tab_arfa)
		
			kst_fattura_stampa.kst_tab_arfa = kst_tab_arfa
			kst_fattura_stampa.kst_tab_clienti = kst_tab_clienti
			kst_fattura_stampa.kst_tab_pagam = kst_tab_pagam
			kst_fattura_stampa.kst_tab_armo = kst_tab_armo
			kst_fattura_stampa.kst_tab_listino_voci = kst_tab_listino_voci
			kst_fattura_stampa.kst_tab_contratti = kst_tab_contratti
			
			k_boolean = produci_fattura_testa(kst_fattura_stampa)
			if not k_boolean then
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Fattura: Stampa Testata."
				kst_esito.esito = kkg_esito.no_esecuzione
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if

		
//--- Righe Fattura		
			ki_fattura_riga_corpo=0             //--- resetta il numero di riga di dettaglio
			ki_pag_fattura=1   //--- pagine fattura
			
			kist_fattura_stampa_riga_old.kst_tab_arfa.num_bolla_out = 0  // resetta il salvataggio del numero bolla
			kist_fattura_stampa_riga_old.kst_tab_armo.dose = 0 // resetta il salvataggio della dose
			

//--- CREA LA VIEW x pilotare l'estrazione dei cursori:  k_query_select_senza_bolla, k_query_select_con_bolla
			k_sql_w = " "
			k_sql = + &
			"CREATE VIEW " + trim(k_view) &
	  		   + " (NRIGA, ID_ARMO,  NUM_BOLLA_OUT, DATA_BOLLA_OUT, NUM_INT, DATA_INT, TIPO_RIGA, ART, IVA, DOSE, COLLI, COLLI_OUT " &
			   + ", PESO_KG_OUT, PREZZO_U, PREZZO_T, TIPO_DOC, STAMPA, TIPO_L, COD_PAG, ID_ARMO_PREZZO, DES "  &
			   + ", PRODOTTI_DES " &
			   + ", GRUPPO, MAGAZZINO, CAMPIONE, ID_LISTINO_VOCE, DESCR_XCTR, " & 
	 		   + " CONTRATTI_CODICE, " &
	 		   + " CONTRATTI_MC_CO, " &
	 		   + " CONTRATTI_DATA, " &
			   + " ID_CONTRATTO_CO, " &
			   + " ID_CONTRATTO_DP, " &
			   + " ID_CONTRATTO_RD  ) AS " &
			 + " SELECT " &
			 + " NRIGA,  " &
			 + " ARFA.ID_ARMO,  " &
			 + " ARFA.NUM_BOLLA_OUT, " &
			 + " ARFA.DATA_BOLLA_OUT, " &
			 + " ARMO.NUM_INT, " &
			 + " ARMO.DATA_INT, " &
			 + " ARFA.TIPO_RIGA, " &
			 + " ARMO.ART, " &
			 + " ARFA.IVA, " &
			 + " ARMO.DOSE, " &
			 + " ARFA.COLLI, " &
			 + " ARFA.COLLI_OUT, " &
			 + " ARFA.PESO_KG_OUT, " &
			 + " ARFA.PREZZO_U, " &
			 + " ARFA.PREZZO_T, " &
			 + " ARFA.TIPO_DOC, " &
			 + " ARFA.STAMPA, " &
			 + " ARFA.TIPO_L, " &
			 + " ARFA.COD_PAG, " &
			 + " ARFA.ID_ARMO_PREZZO, " &
			 + " ARFA.DES, " &
			 + " PRODOTTI.DES, " &
			 + " PRODOTTI.GRUPPO, " &
			 + " ARMO.MAGAZZINO, " & 
			 + " ARMO.CAMPIONE ," &
			 + " LISTINO_VOCI.ID_LISTINO_VOCE ," &
			 + " LISTINO_VOCI.DESCR_XCTR, " &
			 + " CONTRATTI.CODICE, " &
	 		 + " coalesce(CONTRATTI.MC_CO, ''), " &
	 		 + " CONTRATTI.DATA, " &
			 + " CONTRATTI.ID_CONTRATTO_CO, " &
			 + " CONTRATTI.ID_CONTRATTO_DP, " &
			 + " CONTRATTI.ID_CONTRATTO_RD " &
			 + "   from  ARFA inner join ARMO on ARMO.ID_ARMO = ARFA.ID_ARMO left outer join PRODOTTI on PRODOTTI.CODICE = ARMO.ART " &
			 + "        inner join MECA on ARMO.ID_MECA = MECA.ID " &
			 + "        left outer join CONTRATTI on MECA.CONTRATTO = CONTRATTI.CODICE  " &
			 + "        left outer join ARMO_PREZZI on ARFA.ID_ARMO_PREZZO = ARMO_PREZZI.ID_ARMO_PREZZO " &
			 + "        left outer join LISTINO_VOCI on ARMO_PREZZI.ID_LISTINO_VOCE = LISTINO_VOCI.ID_LISTINO_VOCE " &
			 + "   where ARFA.NUM_FATT   = " + string(kst_tab_arfa.NUM_FATT )  + " And ARFA.DATA_FATT = '" + string(kst_tab_arfa.DATA_FATT) + "' " &
			 + "  union all " &
			 + "     select  " &
			 + " ARFA_V.NRIGA, " &
			 + "   0, " &
			 + "     0, " &
			 + "   convert(date, '01.01.1899'), " &
			 + "     0, " &
			 + "   convert(date, '01.01.1899'), " &
			 + "   'V', " &
			 + " ARFA_V.ART, " &
			 + " ARFA_V.IVA, " &
			 + "     0, " &
			 + " ARFA_V.COLLI, " &
			 + " ARFA_V.COLLI, " &
			 + "     0, " &
			 + " ARFA_V.PREZZO_U, " &
			 + " ARFA_V.PREZZO_T, " &
			 + " ARFA_V.TIPO_DOC, " &
			 + " ARFA_V.STAMPA, " &
			 + "       'C', " &
			 + " ARFA_V.COD_PAG, " &
			 + "     0, " &
			 + " ARFA_V.COMM, " &
			 + " '', " &
			 + " 0, " &
			 + " 0, 'S', " &
			 + " 0, " &
			 + " '', " &
			 + " CONTRATTI.CODICE, " &
	 		 + " coalesce(CONTRATTI.MC_CO, ''), " &
	 		 + " CONTRATTI.DATA, " &
			 + " CONTRATTI.ID_CONTRATTO_CO, " &
			 + " CONTRATTI.ID_CONTRATTO_DP, " &
			 + " CONTRATTI.ID_CONTRATTO_RD " &
			 + "   From  ARFA_V  " &
			 + "    left outer join CONTRATTI on ARFA_V.CONTRATTO = CONTRATTI.CODICE " &
			 + "       where ARFA_V.NUM_FATT   = " + string(kst_tab_arfa.NUM_FATT )  &
			 + "          And ARFA_V.DATA_FATT = '" + string(kst_tab_arfa.DATA_FATT) + "' " 
			k_sql = k_sql + " " + trim(k_sql_w) 
			kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//			 + "        left outer join CONTRATTI on MECA.CONTRATTO = CONTRATTI.CODICE  and (CONTRATTI.ID_CONTRATTO_DP > 0 or CONTRATTI.ID_CONTRATTO_RD > 0) " &

			if kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kuf1_clienti.kki_fattura_da_certif then 
				prepare SQLSA from :k_query_select_senza_bolla using sqlca;
			else
				prepare SQLSA from :k_query_select_con_bolla using sqlca;
			end if

			open dynamic produci_fattura_c1 ;
			
			if sqlca.sqlcode = 0 then	

				fetch produci_fattura_c1 into
							:kst_tab_arfa.NRIGA,
							:kst_tab_arfa.NUM_BOLLA_OUT,
							:kst_tab_arfa.DATA_BOLLA_OUT,
							:kst_tab_arfa.TIPO_RIGA,
							:kst_tab_armo.ART,
							:kst_tab_arfa.IVA,
							:kst_tab_armo.DOSE,
							:kst_tab_arfa.COLLI,
							:kst_tab_arfa.COLLI_OUT,
							:kst_tab_arfa.PESO_KG_OUT,
							:kst_tab_arfa.PREZZO_U,
							:kst_tab_arfa.PREZZO_T,
							:kst_tab_prodotti.DES,
							:kst_tab_armo.campione,
							:kst_tab_arfa.DES,
							:kst_tab_listino_voci.ID_LISTINO_VOCE,
							:kst_tab_listino_voci.DESCR_XCTR,
							:kst_tab_contratti.MC_CO,
							:kst_tab_contratti.DATA
							;


				do while sqlca.sqlcode = 0
					
						kuf1_armo.if_isnull_armo( kst_tab_armo )
						if_isnull_testa( kst_tab_arfa )
						if isnull( kst_tab_prodotti.DES ) then  kst_tab_prodotti.DES = " "
						if isnull(kst_fattura_stampa.kst_tab_arfa.num_bolla_out) then kst_fattura_stampa.kst_tab_arfa.num_bolla_out = 0
						if isnull(kst_tab_contratti.MC_CO) then kst_tab_contratti.MC_CO = ""
						
						kst_fattura_stampa.kst_tab_arfa = kst_tab_arfa
						kst_fattura_stampa.kst_tab_prodotti = kst_tab_prodotti
						kst_fattura_stampa.kst_tab_armo = kst_tab_armo
						kst_fattura_stampa.kst_tab_listino_voci = kst_tab_listino_voci
						kst_fattura_stampa.kst_tab_contratti = kst_tab_contratti
						k_boolean = produci_fattura_riga(kst_fattura_stampa)
						
						if not k_boolean then
							kst_esito.sqlcode = 0
							kst_esito.sqlerrtext = "Fattura: Stampa Riga: " + kst_tab_armo.art
							kst_esito.esito = kkg_esito.no_esecuzione
							kuo_exception = create uo_exception
							kuo_exception.set_esito( kst_esito )
							throw kuo_exception
						end if
					
					
						fetch produci_fattura_c1 into
									:kst_tab_arfa.NRIGA,
									:kst_tab_arfa.NUM_BOLLA_OUT,
									:kst_tab_arfa.DATA_BOLLA_OUT,
									:kst_tab_arfa.TIPO_RIGA,
									:kst_tab_armo.ART,
									:kst_tab_arfa.IVA,
									:kst_tab_armo.DOSE,
									:kst_tab_arfa.COLLI,
									:kst_tab_arfa.COLLI_OUT,
									:kst_tab_arfa.PESO_KG_OUT,
									:kst_tab_arfa.PREZZO_U,
									:kst_tab_arfa.PREZZO_T,
									:kst_tab_prodotti.DES,
									:kst_tab_armo.campione,
									:kst_tab_arfa.DES,
									:kst_tab_listino_voci.ID_LISTINO_VOCE,
									:kst_tab_listino_voci.DESCR_XCTR,
									:kst_tab_contratti.MC_CO,
									:kst_tab_contratti.DATA
									;
			
						loop

				close produci_fattura_c1;

			end if
//--- Coda Fattura: TOTALI + SCADENZE

//--- Calcola Totali
			kst_esito = get_totali( kst_tab_arfa, kst_fattura_totali )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
			produci_fattura_piede_totali (kst_tab_arfa, kst_fattura_totali)

//--- stampa NOTE			
			kst_esito = get_note( kst_tab_arfa )
			if kst_esito.esito = kkg_esito.ok then
				produci_fattura_piede_note (kst_tab_arfa)		
			else
				if kst_esito.esito = kkg_esito.db_ko then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if


//--- espone la BANCA Azienda a piede fattura
			kids_stampa_fattura.setitem(kids_stampa_fattura.getrow( ), "fatt_banca",  trim(kst_tab_base.fatt_banca))  
			
//--- espone la COMUNICAZIONE a piede fattura
			kids_stampa_fattura.setitem(kids_stampa_fattura.getrow( ), "fatt_comunicazione",  trim(kst_tab_base.fatt_comunicazione))  
			
//--- Piglia le Scadenze 
			kst_fattura_scadenze = kst_fattura_scadenze_NULL
			kst_esito = get_scadenze( kst_tab_arfa, kst_fattura_scadenze )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				//throw kuo_exception
			else  //30112015 le scadenze potrebbero mancare specie se è una stampa di prova
				produci_fattura_piede_scadenze (kst_fattura_scadenze)
			end if

			k_n_fatture_prodotte++

//---
		next
//--------------------------------------- FINE CICLO PRINCIPALE ------------------------------------------------------------------
	
	
	end if
	
	destroy kuf1_armo
	destroy kuf1_utility
	destroy kuf1_ausiliari
	destroy kuf1_clienti



return k_n_fatture_prodotte

end function

public function integer get_fatture_da_stampare (ds_fatture kds_fatture) throws uo_exception;//
//--- Elenca fatture da Stampare (flag di "STAMPA" sulle fatture)
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
int k_ctr=0, k_n_fatture=0
long k_riga_fatture=0
date k_data_meno3anni, k_dataoggi
st_esito kst_esito 
uo_exception kuo_exception
st_tab_arfa kst_tab_arfa




	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

  	declare  c_get_fatture_da_stampare  cursor for
	         SELECT
				arfa.num_fatt,   
				arfa.data_fatt 
				FROM arfa 
				 where  (arfa.data_fatt > :k_data_meno3anni 
						 and (arfa.stampa is null or arfa.stampa <> 'S')) 
				 group by 
					 arfa.data_fatt 
					,arfa.num_fatt   
				using sqlca;
	

//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
	
//--- data oggi -3 anni
	k_data_meno3anni = relativedate(kg_dataoggi, -1190)
	
	
	open c_get_fatture_da_stampare;

	if sqlca.sqlcode = 0 then

		fetch c_get_fatture_da_stampare 
				into
				:kst_tab_arfa.NUM_FATT
				,:kst_tab_arfa.DATA_FATT;
		
		do while sqlca.sqlcode = 0 

			k_riga_fatture = kds_fatture.insertrow(0)
			
			kds_fatture.object.NUM_FATT[k_riga_fatture] = kst_tab_arfa.NUM_FATT  
			kds_fatture.object.DATA_FATT[k_riga_fatture] = kst_tab_arfa.DATA_FATT 
			kds_fatture.object.sel[k_riga_fatture] = 1

			fetch c_get_fatture_da_stampare 
				into
				:kst_tab_arfa.NUM_FATT
				,:kst_tab_arfa.DATA_FATT;
				
		loop
	
		close c_get_fatture_da_stampare;
		
	end if
	
//--- se tutto ok cancella anche le altre righe
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		if isnull(kst_tab_arfa.num_fatt) then kst_tab_arfa.num_fatt = 0
		if isnull(kst_tab_arfa.data_fatt) then kst_tab_arfa.data_fatt = date(0)
		kst_esito.SQLErrText = &
				"Errore durante lettura fatture da stampare ~n~r" &
							+ "Ultima fattura letta: " + string(kst_tab_arfa.num_fatt, "####0") + " del " &
							+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
							+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
	end if



return k_n_fatture

end function

public function st_esito produci_fattura_set_dw_loghi (ref datawindow kdw_1);//---
//--- Imposta i loghi in Fattura
//---
string k_rcx, k_file
long k_riga
int k_rc
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

////--- Loghi e loghetti
////--- path per reperire le ico del drag e drop
//	if ki_path_risorse = "" then
//		kst_profilestring_ini.operazione = "1"
//		kst_profilestring_ini.valore = "\"
//		kst_profilestring_ini.titolo = "risorse_grafiche" 
//		kst_profilestring_ini.nome = "arch_graf"
//		kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito = "0" then
//			ki_path_risorse = trim(kst_profilestring_ini.valore) 
//		else
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "cartella risorsa grafica non trovata (stampa_attestato_prepara)"
//			kst_esito.esito = kkg_esito.blok
//		end if
//	end if
			
	if len(trim(kGuo_path.get_risorse())) > 0 then
		k_rcx=kdw_1.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img.text"))+ "'") //"logo_orig_blu.JPG" + "'")
		k_rcx=kdw_1.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img_0.text")) + "'")  //"logo_iso_blu.JPG"  + "'")
		k_rcx=kdw_1.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img_1.text")) + "'")  //"logo_iso_blu.JPG"  + "'")
	end if
	

return kst_esito

end function

public function st_esito produci_fattura_set_dw_loghi (ref datastore kdw_1);//---
//--- Imposta i loghi in Fattura
//---
string k_rcx, k_file
long k_riga
int k_rc
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

////--- Loghi e loghetti
////--- path per reperire le ico del drag e drop
//	if ki_path_risorse = "" then
//		kst_profilestring_ini.operazione = "1"
//		kst_profilestring_ini.valore = "\"
//		kst_profilestring_ini.titolo = "risorse_grafiche" 
//		kst_profilestring_ini.nome = "arch_graf"
//		kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito = "0" then
//			ki_path_risorse = trim(kst_profilestring_ini.valore) 
//		else
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "cartella risorsa grafica non trovata "
//			kst_esito.esito = kkg_esito.blok
//		end if
//	end if
			
	if len(trim(kGuo_path.get_risorse())) > 0 then
		k_rcx= trim(kdw_1.Describe("txt_p_img.text"))
		k_rcx=kdw_1.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img.text")) + "'")  // "logo_orig_blu.JPG" + "'")
		k_rcx=kdw_1.Modify("p_img_0.Filename='" + kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img_0.text")) + "'")  // "logo_iso_blu.JPG"  + "'")
		k_rcx=kdw_1.Modify("p_img_1.Filename='" + kGuo_path.get_risorse() + "\" + trim(kdw_1.Describe("txt_p_img_1.text")) + "'")  // "logo_iso_blu.JPG"  + "'")
	end if
	

return kst_esito

end function

private function long produci_fattura_riga_add ();//--- 
//---  Aggiunge riga e controlla se FINE Pagina fa il salto
//---  Torna con il Numero Pagina e intanto incrementa la variabile d'Istanza del Numero di Riga 
//---
long k_riga 


	ki_fattura_riga_corpo++

//--- se supero il nr-massimo di righe per facciata faccio salto pagina	
	if ki_fattura_riga_corpo > ki_fattura_riga_corpo_max then

//--- Nuova PAGINA		
		k_riga=produci_fattura_nuova_pagina()
//		if k_riga = 0 then k_return = false
		ki_fattura_riga_corpo = 1
		
	else

//--- piglia la riga ( che e' poi il numero pagina del lotto di fatture in elaborazione)
		k_riga = kids_stampa_fattura.getrow(  ) 
		
	end if



return k_riga


end function

public function integer u_tree_riempi_listview_righe_fatt (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);// 
//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10="" , k_label="", k_oggetto_corrente="", k_stato_barcode="", k_tipo_oggetto_padre="", k_tipo_doc="", k_stato=""
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_pagam kst_tab_pagam
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)

	end if
		
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item = 0 or isnull(k_handle_item) then	
	
//--- item di ritorno di default
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
	k_handle_item_corrente = k_handle_item

//--- item di ritorno di default
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_padre = kst_treeview_data.oggetto	

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
//--- item di ritorno (vedi anche alla fine)
	if k_handle_item_padre > 0 then
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Articolo fatturato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Documento (Fatt/Nota-Cr.)"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "D.d.t."
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Colli fatt./usciti Peso kg"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "prezzo/importo riga  cod.IVA"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Pagamento"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Riferimento"
		k_align[k_ind] = left!
	//	k_ind++
	//	k_campo[k_ind] = "Ulteriori Informazion"
	//	k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=3
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
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
//		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			


		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
			kst_tab_meca = kst_treeview_data_any.st_tab_meca
			kst_tab_armo = kst_treeview_data_any.st_tab_armo
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
			kst_tab_prodotti = kst_treeview_data_any.st_tab_prodotti
			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_tipo_doc = get_tipo_documento_descrizione(kst_tab_arfa)
//			choose case kst_tab_arfa.tipo_doc
//				case "FT"
//					k_tipo_doc = "Fattura"
//				case "NC"
//					k_tipo_doc = "Nota di Credito"
//				case else
//					k_tipo_doc = "?????????"
//			end choose
			choose case kst_tab_arfa.stampa
				case "S"
					k_stato = "Stampata"
				case " ", "N"
					k_stato = "Da stampare"
				case else
					k_stato = "?????????"
			end choose

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_armo.art) + " - " &
								 + trim(kst_tab_prodotti.des))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(k_tipo_doc) &
													+ "  " + trim(k_stato))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_fatt, "####0") &
									  + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy"))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_bolla_out, "####0") &
									  + " - " + string(kst_tab_arfa.data_bolla_out, "dd.mm.yy"))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.colli, "##,##0") &
										  + " / " + string(kst_tab_arfa.colli_out, "##,##0") &
										  + "  " + string(kst_tab_arfa.peso_kg_out, "##,##0.00")) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.prezzo_u, "###,###,##0.00") &
												  + " / " + string(kst_tab_arfa.prezzo_t, "###,###,##0.00") &
												  + "   " + string(kst_tab_arfa.iva, "###"))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.cod_pag , "  ####0") ) // &
//											  + "  " + trim(kst_tab_pagam.des))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10) + "  (" + string(kst_tab_arfa.clie_3, "####0") + ") ")
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_armo.num_int, "####0") &
									  + " - " + string(kst_tab_armo.data_int, "dd.mm.yy"))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
	end if
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if
	 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

 
 
 


end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10="", k_label="", k_oggetto_corrente="", k_stato_barcode="", k_tipo_oggetto_padre="", k_tipo_doc="", k_stato=""
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_pagam kst_tab_pagam
st_tab_treeview kst_tab_treeview
st_tab_prof kst_tab_prof
kuf_prof kuf1_prof
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)

	end if
	
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item = 0 or isnull(k_handle_item) then	
	
//--- item di ritorno di default
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
	k_handle_item_corrente = k_handle_item

//--- item di ritorno di default
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_padre = kst_treeview_data.oggetto	

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
//--- item di ritorno (vedi anche alla fine)
	if k_handle_item_padre > 0 then
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Documento (Fatt/Nota-Cr.)"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Colli fatt./usciti "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Totale"
		k_align[k_ind] = right!
		k_ind++
		k_campo[k_ind] = "codice"
		k_align[k_ind] = right!
		k_ind++
		k_campo[k_ind] = "Cliente"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Pagamento"
		k_align[k_ind] = left!
	//	k_ind++
	//	k_campo[k_ind] = "Ulteriori Informazion"
	//	k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=3
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
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
//		k_handle = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			

	
		kuf1_prof = create kuf_prof

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
			kst_tab_pagam = kst_treeview_data_any.st_tab_pagam

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_tipo_doc = get_tipo_documento_descrizione(kst_tab_arfa)
//			choose case kst_tab_arfa.tipo_doc
//				case "FT"
//					k_tipo_doc = " "
//				case "NC"
//					k_tipo_doc = "Nota di Credito"
//				case else
//					k_tipo_doc = "?????????"
//			end choose
			choose case kst_tab_arfa.stampa
				case "S"
					k_stato = "Stampata"
				case " ", "N"
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.fattura_dett_da_st then
						try
							kst_tab_prof.num_fatt = kst_tab_arfa.num_fatt
							kst_tab_prof.data_fatt = kst_tab_arfa.data_fatt
							if kuf1_prof.if_fattura_presente( kst_tab_prof ) = kuf1_prof.kki_fattura_in_profis_si then
								k_stato = "da Stampare"
							else
								k_stato = "da Aggiornare x produzione movimenti contabilita' PROFIS"
							end if
						catch (uo_exception kuo_exception)
								kst_esito = kuo_exception.get_st_esito()
								k_stato = "Errore in lettura tab. PROFIS: " + string(kst_esito.esito) + trim(kst_esito.sqlerrtext)
						end try
					else
						k_stato = "da Stampare"
					end if
				case else
					k_stato = "?????????"
			end choose


			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.num_fatt, "####0") &
									  + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy"))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(k_tipo_doc) &
													+ "  " + trim(k_stato))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.colli, "##,##0") &
										  + " / " + string(kst_tab_arfa.colli_out, "##,##0") &
                                ) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.prezzo_t, "###,###,##0.00") )
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_arfa.clie_3, "####0")))
                                      
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_arfa.cod_pag , "  ####0")  ) 
//											  + "  " + trim(kst_tab_pagam.des))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		destroy kuf1_prof
		
	end if
 
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if
		 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

 
 
 


end function

public function integer u_tree_riempi_treeview_righe_fatt (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_tipo_doc=""
string k_query_select="", k_query_where="", k_query_order=""
date k_data_da, k_data_a, k_data_0 
int k_ind, k_ctr
string k_campo[15], k_label
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_arfa kst_tab_arfa
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_pagam kst_tab_pagam
kuf_base kuf1_base
st_profilestring_ini kst_profilestring_ini




	k_data_0 = date(0)		 

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
//--- item di ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if

//--- ricavo i dati dall'item PADRE su cui ho fatto click
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	kst_treeview_data_any = kst_treeview_data.struttura
	kst_tab_arfa = kst_treeview_data_any.st_tab_arfa

//--- ricavo i dati dall'item NONNO ovvero il 'padre' su cui ho fatto click
	k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_arfa.id_armo > 0 then
		kst_tab_arfa = kst_treeview_data_any.st_tab_arfa
	else
		kst_tab_arfa.id_armo = kst_treeview_data_any.st_tab_armo.id_armo
	end if
	kst_tab_meca = kst_treeview_data_any.st_tab_meca
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_close
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		ktvi_treeviewitem.selected = false

		k_query_select = &
		"  	SELECT " &
		+ "	arfa.stampa, " &  
		+ "	arfa.tipo_doc,  " & 
		+ "	arfa.num_fatt, " &  
		+ "	arfa.data_fatt, " &  
		+ "	arfa.clie_3,  " & 
		+ "	arfa.num_bolla_out,  " & 
		+ "	arfa.data_bolla_out,  " & 
		+ "	arfa.tipo_riga,  " & 
		+ "	arfa.id_armo,    " &
		+ "	arfa.art, " &
		+ "	arfa.des, " &
		+ "	arfa.id_meca, " &
		+ "	arfa.num_int, " &
		+ "	arfa.data_int, " &
		+ "	arfa.colli,   " & 
		+ "	arfa.colli_out,   " & 
		+ "	arfa.peso_kg_out,   " & 
		+ "	arfa.prezzo_u,  " &  
		+ "	arfa.prezzo_t,   " &    
		+ "	arfa.iva,   " &    
		+ "	arfa.cod_pag,   " &    
		+ "	arfa.tipo_l,   " &   
		+ "	c3.rag_soc_10	 " &   
		+ "	FROM v_arfa_riga as arfa " &   
		+ "	  INNER JOIN clienti c3 ON  " &   
		+ "	arfa.clie_3 = c3.codice " 
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.armo_tipo_ft_dett
				k_query_where = " where " &
					+ "  (arfa.id_armo = ? ) "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_ft_dett
				k_query_where = " where " &
					+ "  (armo.id_meca = ? ) "
	
			case kuf1_treeview.kist_treeview_oggetto.fattura_dett
				k_query_where = " where " &
					+ "  (arfa.num_fatt = ? and arfa.data_fatt = ?) "
	
			case else
					k_query_where = " "
	
		end choose
	
		k_query_order = &
		+ "	order by " &
		+ "	arfa.data_fatt, arfa.num_fatt, arfa.TIPO_RIGA, arfa.art "
	
	
	//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		 
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.armo_tipo_ft_dett
				open dynamic kc_treeview using :kst_tab_arfa.id_armo;
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_ft_dett
				open dynamic kc_treeview using :kst_tab_meca.id;

			case kuf1_treeview.kist_treeview_oggetto.fattura_dett
				open dynamic kc_treeview using :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
				
			case else
				sqlca.sqlcode = 100

		end choose
		
		if sqlca.sqlcode = 0 then
			
		
			fetch kc_treeview 
				into
					:kst_tab_arfa.stampa,   
					:kst_tab_arfa.tipo_doc,   
					:kst_tab_arfa.num_fatt,   
					:kst_tab_arfa.data_fatt,   
					:kst_tab_arfa.clie_3,   
					:kst_tab_arfa.num_bolla_out,   
					:kst_tab_arfa.data_bolla_out,   
					:kst_tab_arfa.tipo_riga,   
					:kst_tab_arfa.id_armo,   
					:kst_tab_armo.art,   
					:kst_tab_prodotti.des,
					:kst_tab_armo.id_meca,   
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_arfa.colli,   
					:kst_tab_arfa.colli_out,   
					:kst_tab_arfa.peso_kg_out,   
					:kst_tab_arfa.prezzo_u,   
					:kst_tab_arfa.prezzo_t,   
					:kst_tab_arfa.iva,   
					:kst_tab_arfa.cod_pag,   
					:kst_tab_arfa.tipo_l,  
				    :kst_tab_clienti.rag_soc_10
				  ;
//					:kst_tab_pagam.des,   
	
			
			do while sqlca.sqlcode = 0

				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any

				if_isnull_testa(kst_tab_arfa)
	
				k_tipo_doc = get_tipo_documento_descrizione(kst_tab_arfa)
//				choose case kst_tab_arfa.tipo_doc
//					case "FT"
//						k_tipo_doc = "Fattura"
//					case "NC"
//						k_tipo_doc = "Nota di Credito"
//					case else
//						k_tipo_doc = "?????????"
//				end choose
				choose case kst_tab_arfa.stampa
					case "S"
						k_stato = "Stampata"
					case " ", "N"
						k_stato = "Da stampare"
					case else
						k_stato = "?????????"
				end choose

				if isnull(kst_tab_armo.art) then	 kst_tab_armo.art = " "
				if isnull(kst_tab_armo.id_meca) then kst_tab_armo.id_meca = 0
				if isnull(kst_tab_armo.num_int) then kst_tab_armo.num_int = 0
				if isnull(kst_tab_armo.data_int) then kst_tab_armo.data_int = date(0)
				if isnull(kst_tab_prodotti.des) then kst_tab_prodotti.des = " "
				if isnull(kst_tab_clienti.rag_soc_10) then	kst_tab_clienti.rag_soc_10 = " "
				if isnull(kst_tab_pagam.des) then	kst_tab_pagam.des = " "
				
				kst_tab_meca.id = kst_tab_armo.id_meca			
				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				if  k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.fattura_dett then
					kst_treeview_data.label = &
				                    trim(kst_tab_armo.art) &
				                    + " - " + trim(string(kst_tab_prodotti.des, "@@@@@@@@@@")) &
										  + "   rif.:" + string(kst_tab_armo.num_int)
				else
					kst_treeview_data.label = &
				                    string(kst_tab_arfa.num_fatt, "####0") &
				                    + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy") &
										  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
										  + "  ("  &
										  +  string(kst_tab_arfa.clie_3, "#####") + ") "
				end if

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				kst_treeview_data.pic_list = kst_tab_treeview.pic_list
	
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
	
				fetch kc_treeview 
				into
					:kst_tab_arfa.stampa,   
					:kst_tab_arfa.tipo_doc,   
					:kst_tab_arfa.num_fatt,   
					:kst_tab_arfa.data_fatt,   
					:kst_tab_arfa.clie_3,   
					:kst_tab_arfa.num_bolla_out,   
					:kst_tab_arfa.data_bolla_out,   
					:kst_tab_arfa.tipo_riga,   
					:kst_tab_arfa.id_armo,   
					:kst_tab_armo.art,   
					:kst_tab_prodotti.des,
					:kst_tab_armo.id_meca,   
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_arfa.colli,   
					:kst_tab_arfa.colli_out,   
					:kst_tab_arfa.peso_kg_out,   
					:kst_tab_arfa.prezzo_u,   
					:kst_tab_arfa.prezzo_t,   
					:kst_tab_arfa.iva,   
					:kst_tab_arfa.cod_pag,   
					:kst_tab_arfa.tipo_l,  
				    :kst_tab_clienti.rag_soc_10 
					 ;
	
			loop
			
			close kc_treeview;
			
	
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_data_da, k_data_a, k_dataoggi
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_arfa kst_tab_arfa
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



declare kc_treeview cursor for
	SELECT 
         count (data_fatt), 
         month(data_fatt) as mese,   
         year(data_fatt) as anno   
     FROM arfa_testa
    WHERE 
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.fattura_anno_mese
		  and data_fatt between :k_data_da and :k_data_a)
		 or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.fattura_stor_mese
		  and data_fatt < :k_data_da )
		 group by  month(data_fatt),  year(data_fatt)
		 order by  3 desc, 2 desc;
		 
		 
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
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		

//--- ricavo data oggi
		k_dataoggi = kguo_g.get_dataoggi( )

//--- calcolo periodo
		k_anno = year(k_dataoggi) - 1
		k_mese = month(k_dataoggi)
		k_data_da = date (k_anno, k_mese, 01) 
		k_data_a = k_dataoggi 
//
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[Completa]"
			k_mese_desc[1] = "Gennaio"
			k_mese_desc[2] = "Febbraio"
			k_mese_desc[3] = "Marzo"
			k_mese_desc[4] = "Aprile"
			k_mese_desc[5] = "Maggio"
			k_mese_desc[6] = "Giugno"
			k_mese_desc[7] = "Luglio"
			k_mese_desc[8] = "Agosto"
			k_mese_desc[9] = "Settembre"
			k_mese_desc[10] = "Ottobre"
			k_mese_desc[11] = "Novembre"
			k_mese_desc[12] = "Dicembre"
			k_mese_desc[13] = "NON RILEVATO"

			k_totale = 0
			k_anno_old = 0
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			
					if k_totale > 0 then
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Fatture presenti"
						k_totale = 0
			
						kst_tab_arfa.data_fatt = date(k_anno_old,01,01)
						
						kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Fatture " 
					kst_treeview_data.pic_list = k_pic_list
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
	
				kst_tab_arfa.data_fatt = date(k_anno, k_mese, 01)

				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Riga fattura presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Righe fatture presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Fatture " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
				kst_treeview_data.struttura = kst_treeview_data_any

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


				fetch kc_treeview 
					into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			loop

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Fatture presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview: Testata Fatture
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
string k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_tipo_doc
string k_query_select, k_query_where, k_query_order
date k_data_da, k_data_a, k_data_0, k_dataoggi, k_data_meno3mesi
int k_ind, k_ctr
string k_campo[15], k_label
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_tab_pagam kst_tab_pagam

st_profilestring_ini kst_profilestring_ini




	k_data_0 = date(0)		 

//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
//--- item di ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  


	k_data_da = date(0)
	k_data_a = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno in DATAOGGI
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_arfa.data_fatt = date (0) then

//--- Ricavo la data da dataoggi
		kst_treeview_data_any.st_tab_arfa.data_fatt = k_dataoggi
		
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_arfa.data_fatt) 
		k_anno = year(kst_treeview_data_any.st_tab_arfa.data_fatt)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
	end if
		 
	k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_close
		end if
	
//--- data oggi -3 mesi
		k_data_meno3mesi = relativedate(kg_dataoggi, -1190)

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		ktvi_treeviewitem.selected = false

		k_query_select = &
		"  	SELECT " &
		+ "	arfa.stampa, " &  
		+ "	arfa.tipo_doc,  " & 
		+ "	arfa.num_fatt, " &  
		+ "	arfa.data_fatt, " &  
		+ "	arfa.clie_3,  " & 
		+ "	sum(arfa.colli),   " & 
		+ "	sum(arfa.colli_out),   " & 
		+ "	sum(arfa.prezzo_t),   " &    
		+ "	arfa.cod_pag,   " &    
		+ "	c3.rag_soc_10	 " &   
		+ "	FROM v_arfa as arfa "       &    
		+ "	  INNER JOIN clienti c3 ON  " &   
		+ "	arfa.clie_3 = c3.codice " 
		
//		+ "pagam.des,   " &    
//		+ "		LEFT OUTER JOIN pagam ON  " &   
//		+ "	arfa.cod_pag = pagam.codice  " &   
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.fattura_testa
				k_query_where = " where " &
					+ "  (arfa.data_fatt between  ? and ?) "
					
			case kuf1_treeview.kist_treeview_oggetto.fattura_dett_da_st
				k_query_where = " where " &
					+ "  (arfa.data_fatt > ? " &
					+ " and (arfa.stampa is null or arfa.stampa <> 'S')) "
	
			case else
					k_query_where = " "
	
		end choose
	
		k_query_order = &
		+ " group by " &
		+ "	arfa.stampa, " &  
		+ "	arfa.tipo_doc,  " & 
		+ "	arfa.data_fatt, " &  
		+ "	arfa.num_fatt, " &  
		+ "	arfa.clie_3,  " & 
		+ "	arfa.cod_pag,   " &    
		+ "	c3.rag_soc_10	 " &   
		+ " order by " &
		+ "	arfa.data_fatt, arfa.num_fatt "
	
	//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		

		 
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.fattura_testa
				open dynamic kc_treeview using :k_data_da, :k_data_a;
					
	
			case kuf1_treeview.kist_treeview_oggetto.fattura_dett_da_st
				open dynamic kc_treeview using :k_data_meno3mesi;

			case else
				sqlca.sqlcode = 100

		end choose
		
		if sqlca.sqlcode = 0 then
			
			
			fetch kc_treeview 
				into
					:kst_tab_arfa.stampa,   
					:kst_tab_arfa.tipo_doc,   
					:kst_tab_arfa.num_fatt,   
					:kst_tab_arfa.data_fatt,   
					:kst_tab_arfa.clie_3,   
					:kst_tab_arfa.colli,   
					:kst_tab_arfa.colli_out,   
					:kst_tab_arfa.prezzo_t,   
					:kst_tab_arfa.cod_pag,   
				   :kst_tab_clienti.rag_soc_10
				  ;
//					:kst_tab_pagam.des,   
	
			
			do while sqlca.sqlcode = 0

				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any

				if_isnull_testa(kst_tab_arfa)
				if isnull(kst_tab_pagam.des) then	kst_tab_pagam.des = " "
				if isnull(kst_tab_clienti.rag_soc_10) then	kst_tab_clienti.rag_soc_10 = " "
				
				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
				kst_treeview_data_any.st_tab_pagam = kst_tab_pagam
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = &
				                    string(kst_tab_arfa.num_fatt, "####0") &
				                    + " - " + string(kst_tab_arfa.data_fatt, "dd.mm.yy") &
										  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
										  + "  ("  &
										  +  string(kst_tab_arfa.clie_3, "#####") + ") "

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				kst_treeview_data.pic_list = kst_tab_treeview.pic_list
	
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
	
				fetch kc_treeview 
				into
					:kst_tab_arfa.stampa,   
					:kst_tab_arfa.tipo_doc,   
					:kst_tab_arfa.num_fatt,   
					:kst_tab_arfa.data_fatt,   
					:kst_tab_arfa.clie_3,   
					:kst_tab_arfa.colli,   
					:kst_tab_arfa.colli_out,   
					:kst_tab_arfa.prezzo_t,   
					:kst_tab_arfa.cod_pag,   
					:kst_tab_clienti.rag_soc_10
					 ;
	
			loop
			
			close kc_treeview;
			
	
		end if

	end if 
 
return k_return


end function

public function st_esito get_riga_varia (ref st_tab_arfa kst_tab_arfa);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

  SELECT 
   		arfa_v.num_fatt, 
		arfa_v.data_fatt,
         arfa_v.clie_3,   
         arfa_v.tipo_doc,   
         arfa_v.cod_pag,   
         arfa_v.comm,   
         arfa_v.colli,   
         arfa_v.prezzo_u,   
         arfa_v.prezzo_t,   
         arfa_v.tipo_l,   
         arfa_v.iva,   
         arfa_v.stampa,  
         arfa_v.contratto  
    INTO   
		:kst_tab_arfa.num_fatt,
		:kst_tab_arfa.data_fatt,
         :kst_tab_arfa.clie_3,   
         :kst_tab_arfa.tipo_doc,   
         :kst_tab_arfa.cod_pag,   
         :kst_tab_arfa.comm,   
         :kst_tab_arfa.colli,   
         :kst_tab_arfa.prezzo_u,   
         :kst_tab_arfa.prezzo_t,   
         :kst_tab_arfa.tipo_l,   
         :kst_tab_arfa.iva,   
         :kst_tab_arfa.stampa,  
         :kst_tab_arfa.contratto  
    FROM arfa_v  
   WHERE (arfa_v.id_arfa_v = :kst_tab_arfa.id_arfa_v )   
	using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura della Tabella righe Varie di Fattura (id=" + string(kst_tab_arfa.id_arfa_v ) + "). Err.: " &
									 	+ trim(SQLCA.SQLErrText)
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

public subroutine produci_fattura_fine ();//

if isvalid(kids_stampa_fattura) then destroy kids_stampa_fattura


end subroutine

public subroutine if_isnull_scadenze (ref st_fattura_scadenze kst_fattura_scadenze);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_fattura_scadenze.importo_1) then	kst_fattura_scadenze.importo_1 = 0
if isnull(kst_fattura_scadenze.importo_2) then	kst_fattura_scadenze.importo_2 = 0
if isnull(kst_fattura_scadenze.importo_3) then	kst_fattura_scadenze.importo_3 = 0
if isnull(kst_fattura_scadenze.importo_4) then	kst_fattura_scadenze.importo_4 = 0
if isnull(kst_fattura_scadenze.importo_5) then	kst_fattura_scadenze.importo_5 = 0
if isnull(kst_fattura_scadenze.importo_6) then	kst_fattura_scadenze.importo_6 = 0
if isnull(kst_fattura_scadenze.data_1) then	kst_fattura_scadenze.data_1 = date(0)
if isnull(kst_fattura_scadenze.data_2) then	kst_fattura_scadenze.data_2 = date(0)
if isnull(kst_fattura_scadenze.data_3) then	kst_fattura_scadenze.data_3 = date(0)
if isnull(kst_fattura_scadenze.data_4) then	kst_fattura_scadenze.data_4 = date(0)
if isnull(kst_fattura_scadenze.data_5) then	kst_fattura_scadenze.data_5 = date(0)
if isnull(kst_fattura_scadenze.data_6) then	kst_fattura_scadenze.data_6 = date(0)


end subroutine

public subroutine if_isnull_totali (ref st_fattura_totali kst_fattura_totali);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_fattura_totali.cod_1) then	kst_fattura_totali.cod_1 = 0
if isnull(kst_fattura_totali.cod_2) then	kst_fattura_totali.cod_2 = 0
if isnull(kst_fattura_totali.cod_3) then	kst_fattura_totali.cod_3 = 0
if isnull(kst_fattura_totali.cod_4) then	kst_fattura_totali.cod_4 = 0
if isnull(kst_fattura_totali.cod_5) then	kst_fattura_totali.cod_5 = 0

if isnull(kst_fattura_totali.imponibile_1) then	kst_fattura_totali.imponibile_1 = 0.00
if isnull(kst_fattura_totali.imponibile_2) then	kst_fattura_totali.imponibile_2 = 0.00
if isnull(kst_fattura_totali.imponibile_3) then	kst_fattura_totali.imponibile_3 = 0.00
if isnull(kst_fattura_totali.imponibile_4) then	kst_fattura_totali.imponibile_4 = 0.00
if isnull(kst_fattura_totali.imponibile_5) then	kst_fattura_totali.imponibile_5 = 0.00

if isnull(kst_fattura_totali.imposta_1) then	kst_fattura_totali.imposta_1 = 0.00
if isnull(kst_fattura_totali.imposta_2) then	kst_fattura_totali.imposta_2 = 0.00
if isnull(kst_fattura_totali.imposta_3) then	kst_fattura_totali.imposta_3 = 0.00
if isnull(kst_fattura_totali.imposta_4) then	kst_fattura_totali.imposta_4 = 0.00
if isnull(kst_fattura_totali.imposta_5) then	kst_fattura_totali.imposta_5 = 0.00

if isnull(kst_fattura_totali.iva_1) then	kst_fattura_totali.iva_1 = 0
if isnull(kst_fattura_totali.iva_2) then	kst_fattura_totali.iva_2 = 0
if isnull(kst_fattura_totali.iva_3) then	kst_fattura_totali.iva_3 = 0
if isnull(kst_fattura_totali.iva_4) then	kst_fattura_totali.iva_4 = 0
if isnull(kst_fattura_totali.iva_5) then	kst_fattura_totali.iva_5 = 0

if isnull(kst_fattura_totali.iva_des_1) then	kst_fattura_totali.iva_des_1 = " "
if isnull(kst_fattura_totali.iva_des_2) then	kst_fattura_totali.iva_des_2 = " "
if isnull(kst_fattura_totali.iva_des_3) then	kst_fattura_totali.iva_des_3 = " "
if isnull(kst_fattura_totali.iva_des_4) then	kst_fattura_totali.iva_des_4 = " "
if isnull(kst_fattura_totali.iva_des_5) then	kst_fattura_totali.iva_des_5 = " "

if isnull(kst_fattura_totali.imp_splitpayment) then	kst_fattura_totali.imp_splitpayment = 0.00



end subroutine

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_arfa kst_tab_arfa);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
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
int k_n_fatture_stampate=0
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
ds_fatture kds_fatture


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 or kst_tab_arfa.id_fattura > 0 then

	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
	kst_open_w.id_programma = kkg_id_programma_fatture
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		try 

//---- inizializza x stampa fattura
			produci_fattura_inizializza(kst_tab_arfa)
			
			kdw_anteprima.dataobject = kids_stampa_fattura.dataobject		
			kdw_anteprima.settransobject(sqlca)

			kdw_anteprima.reset()	

	
			kds_fatture = create ds_fatture
			kds_fatture.insertrow(0)

//--- piglia il numero di fattura se assente 
			if  kst_tab_arfa.num_fatt = 0 then
				get_numero_da_id(kst_tab_arfa)
			end if
			kds_fatture.object.num_fatt[1] =  kst_tab_arfa.num_fatt
			kds_fatture.object.data_fatt[1] =  kst_tab_arfa.data_fatt
			
//--- produci_fattura	
			k_n_fatture_stampate = produci_fattura(kds_fatture)
		
			if k_n_fatture_stampate > 0 then
				produci_fattura_set_dw_loghi(kdw_anteprima)
				kids_stampa_fattura.rowscopy(1,kids_stampa_fattura.rowcount(),Primary!,kdw_anteprima,1,Primary!)
			end if
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

			finally
				destroy kds_fatture
//--- distrugge oggetti x stampa fattura
				produci_fattura_fine()
				
		end try
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Nessun Documento da visualizzare: ~n~r" + "nessun numero fattura indicato"
//	kst_esito.esito = kkg_esito.err_formale
		
end if


return kst_esito

end function

public function double get_importo_t_anno_x_clie_3 (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//====================================================================
//=== Torna l'importo Totale nell'anno x Cliente Fatturato
//=== 
//=== Input : kst_tab_arfa.clie_3 
//=== Ritorna: importo totale 
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
int k_anno
st_tab_arfa kst_tab_arfa_nc
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.clie_3 > 0 then
	
	k_anno = year(kg_dataoggi)
	
//--- Importo Fatture
	select sum(arfa.prezzo_t)
		into :kst_tab_arfa.prezzo_t
		from arfa 
		where arfa.clie_3 = :kst_tab_arfa.clie_3
			and year(arfa.data_fatt) = :k_anno
			and tipo_doc in (:kki_tipo_doc_fattura, :kki_tipo_doc_AutoFattura)
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa.prezzo_t = 0
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw  kuo_exception
		end if
	end if

//--- Importo Note di Credito
	select sum(arfa.prezzo_t)
		into :kst_tab_arfa_nc.prezzo_t
		from arfa 
		where arfa.clie_3 = :kst_tab_arfa.clie_3
			and year(arfa.data_fatt) = :k_anno
			and tipo_doc = :kki_tipo_doc_nota_di_credito
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa_nc.prezzo_t = 0
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw  kuo_exception
		end if
	end if

else
	kst_tab_arfa.prezzo_t = 0
	kst_tab_arfa_nc.prezzo_t = 0
	
end if	
	
return (kst_tab_arfa.prezzo_t - kst_tab_arfa_nc.prezzo_t)

end function

public subroutine get_prezzo_t (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//---
//--- Calcola  prezzo_t  
//--- Input: st_tab_arfa con valorizzati:   id_armo, importo_u, colli, TIPO_L
//--- Out: st_tab_arfa.prezzo_t, .tipo_l
//---
st_tab_armo kst_tab_armo
//st_tab_listino kst_tab_listino
st_esito kst_esito
kuf_listino kuf1_listino
//kuf_armo kuf1_armo




try 
	
//	if kst_tab_arfa.id_armo > 0 and kst_tab_arfa.prezzo_u <> 0 and not isnull(kst_tab_arfa.prezzo_u)  then
	if kst_tab_arfa.colli > 0 and kst_tab_arfa.prezzo_u <> 0 and not isnull(kst_tab_arfa.prezzo_u)  then
		
		choose case kst_tab_arfa.tipo_l
			case kuf1_listino.kki_tipo_prezzo_a_collo
				kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * kst_tab_arfa.COLLI
			case kuf1_listino.kki_tipo_prezzo_a_corpo
				kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u 
//					case kuf1_listino.kki_tipo_prezzo_a_metro_cubo
//								kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * (kst_tab_armo.m_cubi / kst_tab_armo.colli_2) * kst_tab_arfa.COLLI
//					case kuf1_listino.kki_tipo_prezzo_a_pedana
//								kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * (kst_tab_armo.pedane / kst_tab_armo.colli_2) * kst_tab_arfa.COLLI
//					case kuf1_listino.kki_tipo_prezzo_a_peso
//								kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * (kst_tab_armo.peso_kg / kst_tab_armo.colli_2) * kst_tab_arfa.COLLI
//					case kuf1_listino.kki_tipo_prezzo_a_peso
//								kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * (kst_tab_armo.peso_kg / kst_tab_armo.colli_2) * kst_tab_arfa.COLLI
			case else
				kst_tab_arfa.PREZZO_T = kst_tab_arfa.prezzo_u * kst_tab_arfa.COLLI
		end choose
			
	else			
		kst_tab_arfa.prezzo_t = 0

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try


end subroutine

public function st_esito tb_update_testa (ref st_tab_arfa kst_tab_arfa);//
//--- Aggiorna Testata Fattura
//---      aggiorna anche le righe di dettaglio i dati "comuni"
//---
//--- input: ID della fattura nel st_tab_arfa.id_fattura
//---
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica del Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO.no_aut

else

//--- 
	if_isnull_testa(kst_tab_arfa)


	if kst_tab_arfa.id_fattura > 0 then
	
		kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()
		
		kst_tab_arfa.note_int_1 = trim(kst_tab_arfa.note_int_1)
		kst_tab_arfa.note_int_2 = trim(kst_tab_arfa.note_int_2)
		kst_tab_arfa.indi = trim(kst_tab_arfa.indi)
		kst_tab_arfa.rag_soc_1 = trim(kst_tab_arfa.rag_soc_1)
		kst_tab_arfa.rag_soc_2 = trim(kst_tab_arfa.rag_soc_2)
	
		UPDATE arfa_testa  
				  SET num_fatt = :kst_tab_arfa.num_fatt 
						 , data_fatt    = :kst_tab_arfa.data_fatt
						 , id_cliente = :kst_tab_arfa.clie_3
						 , stampa    = :kst_tab_arfa.stampa
						 , data_stampa    = :kst_tab_arfa.data_stampa
						 , stampa_tradotta = :kst_tab_arfa.stampa_tradotta
						 , tipo_doc    = :kst_tab_arfa.tipo_doc
						 , cod_pag    = :kst_tab_arfa.cod_pag
						 , rag_soc_1    = :kst_tab_arfa.rag_soc_1
						 , rag_soc_2    = :kst_tab_arfa.rag_soc_2
						 , indi    = :kst_tab_arfa.indi
						 , loc    = :kst_tab_arfa.loc
						 , cap    = :kst_tab_arfa.cap
						 , prov    = :kst_tab_arfa.prov
						 , id_nazione    = :kst_tab_arfa.id_nazione
						 , x_datins    = :kst_tab_arfa.x_datins
						 , x_utente    = :kst_tab_arfa.x_utente
						 , note_1    = :kst_tab_arfa.note_int_1
						 , note_2    = :kst_tab_arfa.note_int_2
						, modo_stampa    = :kst_tab_arfa.modo_stampa 
						, modo_email    = :kst_tab_arfa.modo_email 
						, email_invio    = :kst_tab_arfa.email_invio
						, file_prodotto = :kst_tab_arfa.file_prodotto						
						, id_email_invio = :kst_tab_arfa.id_email_invio						
						 
				WHERE arfa_testa.id_fattura = :kst_tab_arfa.id_fattura   
				using sqlca;
	
		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Tab. Fatture. (id.=" + string(kst_tab_arfa.id_fattura)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		else
			
	//--- aggiorna le righe di dettaglio
			UPDATE arfa  
				  SET num_fatt = :kst_tab_arfa.num_fatt 
						 , data_fatt    = :kst_tab_arfa.data_fatt
						 , clie_3 = :kst_tab_arfa.clie_3
						 , stampa    = :kst_tab_arfa.stampa
						 , tipo_doc    = :kst_tab_arfa.tipo_doc
						 , cod_pag    = :kst_tab_arfa.cod_pag
				WHERE id_fattura = :kst_tab_arfa.id_fattura   
				using sqlca;
	
		
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in aggiornam. (testa) Tab. Righe Fattura. (id.=" + string(kst_tab_arfa.id_fattura)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
											 + trim(SQLCA.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			else
			
	//--- aggiorna le righe varie di dettaglio 
				UPDATE arfa_v  
					  SET num_fatt = :kst_tab_arfa.num_fatt 
							 , data_fatt    = :kst_tab_arfa.data_fatt
							 , clie_3 = :kst_tab_arfa.clie_3
							 , stampa    = :kst_tab_arfa.stampa
							 , tipo_doc    = :kst_tab_arfa.tipo_doc
							 , cod_pag    = :kst_tab_arfa.cod_pag
					WHERE id_fattura = :kst_tab_arfa.id_fattura   
					using sqlca;
	
				if sqlca.sqlcode < 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Errore in aggiornam. (testa) Tab. Righe Fattura. (id.=" + string(kst_tab_arfa.id_fattura)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
												 + trim(SQLCA.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
			
		if kst_esito.esito = kkg_esito.ok then
			
	//---- COMMIT....	
			if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Aggiornam. (testa) Tab. Fattura NON effettuato Manca ID (id_fattura) "
		kst_esito.esito = kkg_esito.err_logico
	end if
end if
	
return kst_esito


end function

public function st_esito tb_insert_testa (ref st_tab_arfa kst_tab_arfa);//
//--- Inserisce Nuova Testata Fattura
//--- torna il ID della fattura nel st_tab_arfa.id_fattura
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Inserimento nuovo Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO.no_aut

else

	if_isnull_testa(kst_tab_arfa)

//--- 
	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_tab_arfa.note_int_1 = trim(kst_tab_arfa.note_int_1)
	kst_tab_arfa.note_int_2 = trim(kst_tab_arfa.note_int_2)
	kst_tab_arfa.indi = trim(kst_tab_arfa.indi)
	kst_tab_arfa.rag_soc_1 = trim(kst_tab_arfa.rag_soc_1)
	kst_tab_arfa.rag_soc_2 = trim(kst_tab_arfa.rag_soc_2)
	
	kst_tab_arfa.id_email_invio = 0
	// id_fattura 
	INSERT INTO arfa_testa  
				(  
				  id_cliente
				 , num_fatt   
				 , data_fatt
				 , stampa
				 , data_stampa
				 , stampa_tradotta
				 , tipo_doc   
				 , cod_pag  
				 , rag_soc_1   
				 , rag_soc_2
				 , indi   
				 , loc   
				 , cap   
				 , prov
				 , id_nazione
				 , note_1  
				 , note_2
			 	 , modo_stampa  
				 , modo_email  
				 , email_invio 
				 , file_prodotto 
				 , id_email_invio 
				 , x_datins   
				 , x_utente   
				  )  
	  VALUES (  
				  :kst_tab_arfa.clie_3  
				 , :kst_tab_arfa.num_fatt   
				 , :kst_tab_arfa.data_fatt
				 , :kst_tab_arfa.stampa
				 , :kst_tab_arfa.data_stampa
				 , :kst_tab_arfa.stampa_tradotta
				 , :kst_tab_arfa.tipo_doc
				 , :kst_tab_arfa.cod_pag  
				 , :kst_tab_arfa.rag_soc_1   
				 , :kst_tab_arfa.rag_soc_2
				 , :kst_tab_arfa.indi   
				 , :kst_tab_arfa.loc   
				 , :kst_tab_arfa.cap   
				 , :kst_tab_arfa.prov
				 , :kst_tab_arfa.id_nazione   
				 , :kst_tab_arfa.note_int_1
				 , :kst_tab_arfa.note_int_2
				 , :kst_tab_arfa.modo_stampa 
				 , :kst_tab_arfa.modo_email 
				 , :kst_tab_arfa.email_invio
				 , :kst_tab_arfa.file_prodotto 
				 , :kst_tab_arfa.id_email_invio 
				 , :kst_tab_arfa.x_datins   
				 , :kst_tab_arfa.x_utente   
				  )  
			using sqlca;

	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. Tab. Fatture. (nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		try
			kst_tab_arfa.id_fattura = get_id_fattura_max()
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
		//kst_tab_arfa.id_fattura = long(sqlca.SQLReturnData)
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if

end if

return kst_esito


end function

public function st_esito tb_insert_dett (ref st_tab_arfa kst_tab_arfa);//
//--- Inserisce Nuova Riga Fattura
//--- torna il ID della riga fattura nel st_tab_arfa.id_arfa
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Inserimento nuovo Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- 


	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()
	
	if kst_tab_arfa.tipo_riga = kki_tipo_riga_maga then
	//id_arfa,
		INSERT INTO arfa  
				( 
				  id_fattura,   
				  clie_3,   
				  num_fatt,   
				  data_fatt,   
				  stampa,   
				  tipo_doc,   
				  cod_pag,   
				  id_armo,   
				  id_armo_prezzo,   
				  id_arsp,   
				  nriga,   
				  num_bolla_out,   
				  data_bolla_out,   
				  tipo_riga,   
				  des,   
				  iva,   
				  colli,   
				  prezzo_u,   
				  prezzo_t,   
				  colli_out,   
				  peso_kg_out,   
				  tipo_l,   
				  id_arfa_se_nc,   
				  x_datins,   
				  x_utente 
				)  
	  VALUES (
				  :kst_tab_arfa.id_fattura,   
				  :kst_tab_arfa.clie_3,   
				  :kst_tab_arfa.num_fatt,   
				  :kst_tab_arfa.data_fatt,   
				  :kst_tab_arfa.stampa,   
				  :kst_tab_arfa.tipo_doc,   
				  :kst_tab_arfa.cod_pag,   
				  :kst_tab_arfa.id_armo,   
				  :kst_tab_arfa.id_armo_prezzo,   
				  :kst_tab_arfa.id_arsp,   
				  :kst_tab_arfa.nriga,   
				  :kst_tab_arfa.num_bolla_out,   
				  :kst_tab_arfa.data_bolla_out,   
				  :kst_tab_arfa.tipo_riga,   
				  :kst_tab_arfa.des,   
				  :kst_tab_arfa.iva,   
				  :kst_tab_arfa.colli,   
				  :kst_tab_arfa.prezzo_u,   
				  :kst_tab_arfa.prezzo_t,   
				  :kst_tab_arfa.colli_out,   
				  :kst_tab_arfa.peso_kg_out,   
				  :kst_tab_arfa.tipo_l,   
				  :kst_tab_arfa.id_arfa_se_nc,   
				  :kst_tab_arfa.x_datins,   
				  :kst_tab_arfa.x_utente   
					)  
			using kguo_sqlca_db_magazzino;
			
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				try
					kst_tab_arfa.id_arfa = get_id_arfa_max()
				catch (uo_exception kuo1_exception)
					kst_esito = kuo1_exception.get_st_esito()
				end try
			end if

	else
		//id_arfa_v, 
		INSERT INTO arfa_v  
				(
				  num_fatt,   
				  data_fatt,   
			 	  id_fattura,   
				  clie_3,   
				  tipo_doc,   
				  cod_pag,   
				  nriga,   
				  art,   
				  comm,   
				  colli,   
				  prezzo_u,   
				  prezzo_t,   
				  tipo_l,   
				  iva,   
				  stampa,   
				  contratto,   
				  x_datins,   
				  x_utente 
				)  
	  VALUES ( 
				  :kst_tab_arfa.num_fatt,   
				  :kst_tab_arfa.data_fatt,   
				  :kst_tab_arfa.id_fattura,   
				  :kst_tab_arfa.clie_3,   
				  :kst_tab_arfa.tipo_doc,   
				  :kst_tab_arfa.cod_pag,   
				  :kst_tab_arfa.nriga,   
				  :kst_tab_arfa.art,   
				  :kst_tab_arfa.comm,   
				  :kst_tab_arfa.colli_out,   
				  :kst_tab_arfa.prezzo_u,   
				  :kst_tab_arfa.prezzo_t,   
				  :kst_tab_arfa.tipo_l,   
				  :kst_tab_arfa.iva,   
				  :kst_tab_arfa.stampa,   
				  :kst_tab_arfa.contratto,   
				  :kst_tab_arfa.x_datins,   
				  :kst_tab_arfa.x_utente   
					)  
			using kguo_sqlca_db_magazzino;
	
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				try
					kst_tab_arfa.id_arfa = get_id_arfa_v_max()
				catch (uo_exception kuo_exception)
					kst_esito = kuo_exception.get_st_esito()
				end try
			end if
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. Tab.Righe Fatture. (nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		//kst_tab_arfa.id_arfa = long(kguo_sqlca_db_magazzino.SQLReturnData)
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if
end if
	
return kst_esito


end function

public function st_esito tb_update_dett (ref st_tab_arfa kst_tab_arfa);//
//--- Aggiorna Righe Fattura
//---
//--- input: ID della riga fattura nel st_tab_arfa.id_arfa
//---
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica del Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- 

	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()


	if kst_tab_arfa.tipo_riga = kki_tipo_riga_maga then

//--- aggiorna le righe di dettaglio
		UPDATE arfa  
			  SET num_fatt = :kst_tab_arfa.num_fatt 
					 , data_fatt    = :kst_tab_arfa.data_fatt
					 , id_fattura    = :kst_tab_arfa.id_fattura
					 , clie_3 = :kst_tab_arfa.clie_3
					 , stampa    = :kst_tab_arfa.stampa
					 , tipo_doc    = :kst_tab_arfa.tipo_doc
					 , cod_pag    = :kst_tab_arfa.cod_pag
			          ,  id_armo    = :kst_tab_arfa.id_armo  
			          ,  id_armo_prezzo    = :kst_tab_arfa.id_armo_prezzo  
        				 ,  id_arsp    = :kst_tab_arfa.id_arsp   
           			 ,	nriga    = :kst_tab_arfa.nriga   
           			 ,	num_bolla_out    = :kst_tab_arfa.num_bolla_out
           			 ,	data_bolla_out    = :kst_tab_arfa.data_bolla_out
           			 ,	tipo_riga    = :kst_tab_arfa.tipo_riga
           			 ,	des    = :kst_tab_arfa.des
				      ,  iva    = :kst_tab_arfa.iva
				      ,  colli    = :kst_tab_arfa.colli
				      ,  prezzo_u    = :kst_tab_arfa.prezzo_u
				      ,  prezzo_t    = :kst_tab_arfa.prezzo_t
				      ,  colli_out    = :kst_tab_arfa.colli_out
				      ,  peso_kg_out    = :kst_tab_arfa.peso_kg_out
				      ,  tipo_l    = :kst_tab_arfa.tipo_l
				      ,  id_arfa_se_nc    = :kst_tab_arfa.id_arfa_se_nc
					 ,  x_datins      = :kst_tab_arfa.x_datins
					 ,  x_utente    = :kst_tab_arfa.x_utente
			WHERE id_arfa = :kst_tab_arfa.id_arfa
			using sqlca;

	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in aggiornam. Tab. Riga Fattura (id.=" + string(kst_tab_arfa.id_arfa)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	else
		
//--- aggiorna le righe varie di dettaglio 
		UPDATE arfa_v  
				  SET num_fatt = :kst_tab_arfa.num_fatt 
						 , data_fatt    = :kst_tab_arfa.data_fatt
						 , id_fattura    = :kst_tab_arfa.id_fattura
						 , clie_3 = :kst_tab_arfa.clie_3
						 , stampa    = :kst_tab_arfa.stampa
						 , tipo_doc    = :kst_tab_arfa.tipo_doc
						 , cod_pag    = :kst_tab_arfa.cod_pag
				  		 , nriga      = :kst_tab_arfa.nriga
						 , art     = :kst_tab_arfa.art
						 , comm      = :kst_tab_arfa.comm
						 , colli      = :kst_tab_arfa.colli_out
						 , prezzo_u      = :kst_tab_arfa.prezzo_u
						 , prezzo_t      = :kst_tab_arfa.prezzo_t
						 , tipo_l      = :kst_tab_arfa.tipo_l
						 , iva      = :kst_tab_arfa.iva
						 , stampa      = :kst_tab_arfa.stampa
						 , contratto      = :kst_tab_arfa.contratto
						 , x_datins      = :kst_tab_arfa.x_datins
						 , x_utente    = :kst_tab_arfa.x_utente
						 
				WHERE id_arfa_v = :kst_tab_arfa.id_arfa_v   
				using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Tab. Fattura Riga Varia (id.=" + string(kst_tab_arfa.id_arfa_v)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
											 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
		
	if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else		
		if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		
	end if

end if

return kst_esito


end function

public function st_esito get_id (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il ID della Fattura indicata
//---
//---  input: st_tab_arfa.num_fatt e data_fatt (anno)
//---  otput: st_tab_arfa.id_fattura
//---
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 
	k_anno = year(kst_tab_arfa.DATA_FATT)
	
   select id_fattura
	   into :kst_tab_arfa.id_fattura
	   from  ARFA_TESTA
       where NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
                 and year(DATA_FATT) =  :k_anno 
       using sqlca;
		 
	if sqlca.sqlcode >=0 and (kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura)) then
		select distinct id_fattura
			into :kst_tab_arfa.id_fattura
			from  ARFA
			 where NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
						  and year(DATA_FATT) =  :k_anno 
			 using sqlca;
	end if
	if sqlca.sqlcode >=0 and (kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura)) then
		select distinct id_fattura
			into :kst_tab_arfa.id_fattura
			from  ARFA_V
			 where NUM_FATT   =  :kst_tab_arfa.NUM_FATT 
						  and year(DATA_FATT) =  :k_anno 
			 using sqlca;
	end if
		
	if sqlca.sqlcode < 0 then
		kst_tab_arfa.id_fattura = 0
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura ID Fattura n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + " (arfa_testa)  ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else	
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Lettura ID Fattura (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito

end function

public function st_esito get_testata (ref st_tab_arfa kst_tab_arfa);//
//--- Leggo Testata Documento Di Vendita specifico
//--- Input: st_tab_arfa.id_fatura
//--- Out: st_tab_arfa con i campi della ARFA_TESTA
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

  SELECT 
   		num_fatt, 
		data_fatt,
         id_cliente,   
         tipo_doc,   
         cod_pag,   
         stampa  
    INTO   
		:kst_tab_arfa.num_fatt,
		:kst_tab_arfa.data_fatt,
         :kst_tab_arfa.clie_3,   
         :kst_tab_arfa.tipo_doc,   
         :kst_tab_arfa.cod_pag,   
         :kst_tab_arfa.stampa  
    FROM arfa_testa  
   WHERE (id_fattura = :kst_tab_arfa.id_fattura )   
	using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura della Tab. Testata Fattura (id=" + string(kst_tab_arfa.id_fattura ) + "). Err.: " &
									 	+ trim(SQLCA.SQLErrText)
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
		if kst_tab_arfa.tipo_doc = "" or isnull(kst_tab_arfa.tipo_doc) then
			kst_tab_arfa.tipo_doc = kki_tipo_doc_fattura
		end if
	end if
	
return kst_esito


end function

public function st_esito get_spese_inc (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna le spese INCASSO della Fattura indicata
//---
//---  input: st_tab_arfa.num_fatt e data_fatt
//---  otput: st_tab_arfa.spese_inc
//---
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 
	k_anno = year(kst_tab_arfa.DATA_FATT)
	
   select spese_inc
	   into :kst_tab_arfa.spese_inc
	   from  ARFA_TESTA
       where id_fattura   =  :kst_tab_arfa.id_fattura 
       using sqlca;
		 
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa.id_fattura = 0
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Spese Incasso Fattura id= " + string(kst_tab_arfa.id_fattura ) + " (arfa_testa) " &
									 + trim(SQLCA.SQLErrText)
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
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca ID Fattura per Lettura Spese Incasso (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito

end function

public function st_esito get_importi_x_profis (ref st_tab_arfa kst_tab_arfa, ref st_tab_prof kst_tab_prof[]);//====================================================================
//=== Torna ARRAY di importi Documento x Gruppo Articolo 
//=== 
//=== Input : kst_tab_arfa.id_fatura 
//=== Ritorna: st_esito  e   st_tab_prof[] con importi e gruppi
//===					
//===   
//====================================================================
int k_ind_prof=0, k_ind_prof_max=0
st_tab_prof kst_tab_prof_1
st_tab_gru kst_tab_gru
st_tab_arfa kst_tab_arfa_nc
st_fattura_totali kst_fattura_totali
st_esito kst_esito
kuf_base kuf1_base
kuf_ausiliari kuf1_ausiliari


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf1_base = create kuf_base
kuf1_ausiliari = create kuf_ausiliari



//--- Importo Totale Generale della Fattura
	kst_esito = get_totali(  kst_tab_arfa, kst_fattura_totali )
	if kst_esito.esito = kkg_esito.ok then
		k_ind_prof ++
		kst_tab_prof[k_ind_prof].FLAG = "A"
		kst_tab_prof[k_ind_prof].importo = kst_fattura_totali.totale
		kst_tab_prof[k_ind_prof].s_conto = kst_tab_arfa.clie_3
		kst_tab_prof[k_ind_prof].iva = 0
//		kst_tab_gru.codice = integer(trim(mid(kuf1_base.prendi_dato_base( "clie_gru"), 2)))
//		kst_esito = kuf1_ausiliari.tb_select( kst_tab_gru)
		kst_tab_prof[k_ind_prof].conto = kst_tab_gru.conto
		if isnull(kst_tab_prof[k_ind_prof].conto ) then 
			kst_tab_prof[k_ind_prof].conto  = 0 
		end if
	end if

	if kst_esito.esito <> kkg_esito.db_ko then	
	
//--- Importo Fattura x CONTO contabile righe Articolo Magazzino 1
		 DECLARE get_importo_doc_x_mag1 CURSOR FOR  
			select sum(arfa.prezzo_t)
					 , gru.conto
					 , gru.s_conto 
					 , gru.conto_m_1
					 , gru.s_conto_m_1 
					 , arfa.iva
				from arfa inner join armo on
						arfa.id_armo = armo.id_armo
							 inner join prodotti on 
						armo.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
							 and armo.magazzino = 1
				group by	 
						 arfa.iva
						, gru.conto
						, gru.s_conto 
						, gru.conto_m_1
						, gru.s_conto_m_1 
				using sqlca;
	
		open get_importo_doc_x_mag1;
	
		if sqlca.sqlcode = 0 then
			k_ind_prof ++
			fetch get_importo_doc_x_mag1 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof_1.conto
							,:kst_tab_prof_1.s_conto
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;
							
			do while  sqlca.sqlcode = 0
	
				if (isnull(kst_tab_prof[k_ind_prof].CONTO) or kst_tab_prof[k_ind_prof].CONTO = 0) then
					kst_tab_prof[k_ind_prof].CONTO = kst_tab_prof_1.CONTO
				end if
				if (isnull(kst_tab_prof[k_ind_prof].S_CONTO) or kst_tab_prof[k_ind_prof].S_CONTO = 0) then
					kst_tab_prof[k_ind_prof].S_CONTO = kst_tab_prof_1.S_CONTO
				end if
				kst_tab_prof[k_ind_prof].FLAG = "C"
	
				k_ind_prof ++
				fetch get_importo_doc_x_mag1 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof_1.conto
								,:kst_tab_prof_1.s_conto
								,:kst_tab_prof[k_ind_prof].conto
								,:kst_tab_prof[k_ind_prof].s_conto
								,:kst_tab_prof[k_ind_prof].iva;

				if sqlca.sqlcode <> 0 then k_ind_prof --
			
			loop
	
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (1) ~n~r" &
										+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
										+ sqlca.sqlerrtext
			end if
			
			close get_importo_doc_x_mag1;
		end if
	end if

	if kst_esito.esito = kkg_esito.ok then	

//--- Importo Fattura x CONTO contabile righe Articolo Magazzino 2
		 DECLARE get_importo_doc_x_mag2 CURSOR FOR  
			select sum(arfa.prezzo_t)
					, gru.conto
					, gru.s_conto 
					, gru.conto_m_2
					, gru.s_conto_m_2
					 , arfa.iva
				from arfa inner join armo on
						arfa.id_armo = armo.id_armo
							 inner join prodotti on 
						armo.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
							 and armo.magazzino = 2
				group by	 
						gru.conto
						, gru.s_conto 
						, gru.conto_m_2
						, gru.s_conto_m_2 
						 , arfa.iva
				using sqlca;
		
		open get_importo_doc_x_mag2;
		if sqlca.sqlcode = 0 then

			fetch get_importo_doc_x_mag2 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof_1.conto
							,:kst_tab_prof_1.s_conto
							,:kst_tab_prof[k_ind_prof].conto 
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;
							

			do while  sqlca.sqlcode = 0
				
				if (isnull(kst_tab_prof[k_ind_prof].CONTO) or kst_tab_prof[k_ind_prof].CONTO = 0) then
						kst_tab_prof[k_ind_prof].CONTO = kst_tab_prof_1.CONTO
				end if
				if (isnull(kst_tab_prof[k_ind_prof].S_CONTO) or kst_tab_prof[k_ind_prof].S_CONTO = 0) then
					kst_tab_prof[k_ind_prof].S_CONTO = kst_tab_prof_1.S_CONTO
				end if
					
				kst_tab_prof[k_ind_prof].FLAG = "C"

				k_ind_prof ++

				fetch get_importo_doc_x_mag2 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof_1.conto
								,:kst_tab_prof_1.s_conto
								,:kst_tab_prof[k_ind_prof].conto
								,:kst_tab_prof[k_ind_prof].s_conto
								,:kst_tab_prof[k_ind_prof].iva;

				if sqlca.sqlcode <> 0 then k_ind_prof --
			
			loop

			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (2) ~n~r" &
										+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
										+ sqlca.sqlerrtext
			end if
			
			close get_importo_doc_x_mag2;
		end if

	end if

	if kst_esito.esito = kkg_esito.ok then	

//--- Importo Fattura x CONTO contabile righe Articolo ALTRO Magazzino 
		 DECLARE get_importo_doc_x_mag3 CURSOR FOR  
			select sum(arfa.prezzo_t)
						 , gru.conto
						 , gru.s_conto 
						 , arfa.iva
				from arfa inner join armo on
						arfa.id_armo = armo.id_armo
							 inner join prodotti on 
						armo.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
							 and (armo.magazzino not in (1,2) 
							    or armo.magazzino is null)
				group by	  gru.conto
							, gru.s_conto 
							 , arfa.iva
				using sqlca;
	
		open get_importo_doc_x_mag3;
		if sqlca.sqlcode = 0 then

			k_ind_prof ++
			fetch get_importo_doc_x_mag3 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;

			do while  sqlca.sqlcode = 0

				kst_tab_prof[k_ind_prof].FLAG = "C"

				k_ind_prof ++
				fetch get_importo_doc_x_mag3 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;

				if sqlca.sqlcode <> 0 then k_ind_prof --

			loop

			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (3) ~n~r" &
											+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
											+ sqlca.sqlerrtext
			end if
				
			close get_importo_doc_x_mag3;

		end if

	end if

	if kst_esito.esito = kkg_esito.ok then	
//--- Importo Fattura x CONTO contabile righe VARIE Articolo Magazzino 1
		 DECLARE get_importo_doc_x_magV1 CURSOR FOR  
			select sum(arfa.prezzo_t)
					, gru.conto
					, gru.s_conto 
					, gru.conto_m_1
					, gru.s_conto_m_1 
					 , arfa.iva
				from arfa_v as arfa inner join prodotti on
						arfa.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
							 and arfa.art <> ''
							 and prodotti.magazzino = 1
				group by	 
						gru.conto
						, gru.s_conto 
						, gru.conto_m_1
						, gru.s_conto_m_1 
						 , arfa.iva
				using sqlca;
	
		open get_importo_doc_x_magV1;
		if sqlca.sqlcode = 0 then
			k_ind_prof ++
			fetch get_importo_doc_x_magV1 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof_1.conto
							,:kst_tab_prof_1.s_conto
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;
			
			do while  sqlca.sqlcode = 0
				
				if (isnull(kst_tab_prof[k_ind_prof].CONTO) or kst_tab_prof[k_ind_prof].CONTO = 0) then
						kst_tab_prof[k_ind_prof].CONTO = kst_tab_prof_1.CONTO
				end if
				if (isnull(kst_tab_prof[k_ind_prof].S_CONTO) or kst_tab_prof[k_ind_prof].S_CONTO = 0) then
					kst_tab_prof[k_ind_prof].S_CONTO = kst_tab_prof_1.S_CONTO
				end if

				kst_tab_prof[k_ind_prof].FLAG = "C"
	
				k_ind_prof ++
				fetch get_importo_doc_x_magV1 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof_1.conto
								,:kst_tab_prof_1.s_conto
								,:kst_tab_prof[k_ind_prof].conto
								,:kst_tab_prof[k_ind_prof].s_conto
								,:kst_tab_prof[k_ind_prof].iva;
			
				if sqlca.sqlcode <> 0 then k_ind_prof --

			loop
	
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (4) ~n~r" &
										+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
										+ sqlca.sqlerrtext
			end if
			
			close get_importo_doc_x_magV1;
		end if
	end if

	if kst_esito.esito = kkg_esito.ok then	

//--- Importo Fattura x CONTO contabile righe VARIE Articolo Magazzino 2
		 DECLARE get_importo_doc_x_magV2 CURSOR FOR  
			select sum(arfa.prezzo_t)
					, gru.conto
					, gru.s_conto 
					, gru.conto_m_2
					, gru.s_conto_m_2
					 , arfa.iva
				from arfa_v as arfa inner join prodotti on
						arfa.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
					          and arfa.art <> ''
							 and prodotti.magazzino = 2
				group by	 
						gru.conto
						, gru.s_conto 
						, gru.conto_m_2
						, gru.s_conto_m_2 
						 , arfa.iva
				using sqlca;
		
		open get_importo_doc_x_magV2;
		if sqlca.sqlcode = 0 then

			k_ind_prof ++
			fetch get_importo_doc_x_magV2 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof_1.conto
							,:kst_tab_prof_1.s_conto
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;

			do while  sqlca.sqlcode = 0
				
				if (isnull(kst_tab_prof[k_ind_prof].CONTO) or kst_tab_prof[k_ind_prof].CONTO = 0) then
						kst_tab_prof[k_ind_prof].CONTO = kst_tab_prof_1.CONTO
				end if
				if (isnull(kst_tab_prof[k_ind_prof].S_CONTO) or kst_tab_prof[k_ind_prof].S_CONTO = 0) then
					kst_tab_prof[k_ind_prof].S_CONTO = kst_tab_prof_1.S_CONTO
				end if

				kst_tab_prof[k_ind_prof].FLAG = "C"

				k_ind_prof ++
				fetch get_importo_doc_x_magV2 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof_1.conto
								,:kst_tab_prof_1.s_conto
								,:kst_tab_prof[k_ind_prof].conto
								,:kst_tab_prof[k_ind_prof].s_conto
								,:kst_tab_prof[k_ind_prof].iva;
			
				if sqlca.sqlcode <> 0 then k_ind_prof --

			loop

			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (5) ~n~r" &
										+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
										+ sqlca.sqlerrtext
			end if
			
			close get_importo_doc_x_magV2;
		end if

	end if

	if kst_esito.esito = kkg_esito.ok then	

//--- Importo Fattura x CONTO contabile righe VARIE Articolo ALTRO Magazzino 
		 DECLARE get_importo_doc_x_magV3 CURSOR FOR  
			select sum(arfa.prezzo_t)
						 , gru.conto
						 , gru.s_conto 
						 , arfa.iva
				from arfa_v as arfa inner join prodotti on
						arfa.art = prodotti.codice 
							inner join gru on
						prodotti.gruppo = gru.codice
				where arfa.id_fattura = :kst_tab_arfa.id_fattura
					          and arfa.art <> ''
							 and (prodotti.magazzino not in (1,2) 
							    or prodotti.magazzino is null)
				group by	  gru.conto
							, gru.s_conto 
							 , arfa.iva
				using sqlca;
	
		open get_importo_doc_x_magV3;
		if sqlca.sqlcode = 0 then

			k_ind_prof ++
			fetch get_importo_doc_x_magV3 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;

			do while  sqlca.sqlcode = 0

				kst_tab_prof[k_ind_prof].FLAG = "C"

				k_ind_prof ++
				fetch get_importo_doc_x_magV3 into 
							:kst_tab_prof[k_ind_prof].importo
							,:kst_tab_prof[k_ind_prof].conto
							,:kst_tab_prof[k_ind_prof].s_conto
							,:kst_tab_prof[k_ind_prof].iva;

				if sqlca.sqlcode <> 0 then k_ind_prof --

			loop

			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto (6) ~n~r" &
										+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
										+ sqlca.sqlerrtext
			end if
			
			close get_importo_doc_x_magV3;
		end if

	end if

	if kst_esito.esito = kkg_esito.ok then	

//--- Importo Fattura x CONTO contabile righe VARIE SENZA Articolo 
		
//		kst_tab_gru.codice = integer(trim(mid(kuf1_base.prendi_dato_base( "art_vari_gru"), 2)))
		kst_esito = kuf1_ausiliari.tb_select( kst_tab_gru )
		if kst_esito.esito <> kkg_esito.db_ko then
			 DECLARE get_importo_doc_x_magV4 CURSOR FOR  
				select sum(prezzo_t), iva
						from arfa_v 
						where id_fattura = :kst_tab_arfa.id_fattura
									 and (arfa_v.art = '' or arfa_v.art is null)
						group by iva
						using sqlca;
		
			
			open get_importo_doc_x_magV4;
			if sqlca.sqlcode = 0 then
	
				k_ind_prof ++
				fetch get_importo_doc_x_magV4 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof[k_ind_prof].iva ;
					
				do while  sqlca.sqlcode = 0
	
					kst_tab_prof[k_ind_prof].FLAG = "C"
					kst_tab_prof[k_ind_prof].conto = kst_tab_gru.conto 
					kst_tab_prof[k_ind_prof].s_conto = kst_tab_gru.s_conto 
	
					k_ind_prof ++
					fetch get_importo_doc_x_magV4 into 
								:kst_tab_prof[k_ind_prof].importo
								,:kst_tab_prof[k_ind_prof].iva ;
	
					if sqlca.sqlcode <> 0 then k_ind_prof --
	
				loop
		
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Errore durante Calcolo Importi Fattura x Conto  (7) ~n~r" &
											+ "Id fattura: " + string (kst_tab_arfa.id_fattura) + " ~n~r" &
											+ sqlca.sqlerrtext
				end if
				
				close get_importo_doc_x_magV4;
			end if
		end if	
	end if
		

//	if kst_esito.esito = kkg_esito.ok then	
//
////--- Importo Spese Incasso x CONTO contabile  
//		
//		kst_esito = get_spese_inc( kst_tab_arfa ) 
//		if kst_esito.esito = kkg_esito.ok then
//			if kst_tab_arfa.spese_inc > 0 then			
//			
//				k_ind_prof ++
//				
//				kst_tab_prof[k_ind_prof].FLAG = "C"
//				kst_tab_prof[k_ind_prof].importo = kst_tab_arfa.spese_inc
//			
//				kst_tab_gru.codice = integer(trim(mid(kuf1_base.prendi_dato_base( "inc_gru"), 2)))
//				kst_esito = kuf1_ausiliari.tb_select( kst_tab_gru )
//				kst_tab_prof[k_ind_prof].conto = kst_tab_gru.conto 
//				kst_tab_prof[k_ind_prof].s_conto = kst_tab_gru.s_conto 
//			
//				kst_tab_prof[k_ind_prof].iva = integer(trim(mid(kuf1_base.prendi_dato_base( "iva_inc"), 2)))
//				if isnull(kst_tab_prof[k_ind_prof].iva ) then 
//					kst_tab_prof[k_ind_prof].iva  = 0 
//				end if
//				
//				
//			end if
//		end if
//	end if

	destroy kuf1_base
	destroy kuf1_ausiliari
	
return kst_esito

end function

public function st_esito aggiorna_tabelle_correlate (ref st_tab_arfa kst_tab_arfa[]);//
//--- Genera righe tabelle correlate alla Fattura come: PROFIS,  ecc....
//--- input:  array st_ta_arfa con l'elenco delle fatture da aggiornare
//--- out: st_esito 
//---
long k_riga_fatture=0, k_nr_fatt=0
st_esito kst_esito, kst_esito1 
st_tab_prof kst_tab_prof
st_tab_ricevute kst_tab_ricevute
//kuf_prof kuf1_prof
kuf_ricevute kuf1_ricevute


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_fatt = upperbound(kst_tab_arfa[])

	if k_nr_fatt > 0 then
		
////--- Crea Movimenti x PROFIS
//		kuf1_prof = create kuf_prof
//
//		for k_riga_fatture = 1 to k_nr_fatt
//
//			try
//
//				kst_tab_prof.num_fatt = kst_tab_arfa[k_riga_fatture].num_fatt
//				kst_tab_prof.data_fatt = kst_tab_arfa[k_riga_fatture].data_fatt
//				kst_tab_prof.if_fattura = kst_tab_arfa[k_riga_fatture].id_fattura 
////--- Verifica se movim PROFIS gia Trasferiti 
//				if not (kuf1_prof.if_gia_trasferiti(kst_tab_prof)) then
//
////--- prima cancella i movim PROFIS
//					kst_tab_prof.st_tab_g_0.esegui_commit = "N" 
//					kst_esito = kuf1_prof.tb_delete( kst_tab_prof ) 
//					if kst_esito.esito <> kkg_esito.db_ko then
////--- ... poi crea i nuovi PROFIS
//						kst_tab_prof.st_tab_g_0.esegui_commit = "S" 
//						kuf1_prof.crea_movimenti( kst_tab_prof ) 
//					end if
//				end if
//
//			catch (uo_exception kuo_exception)
//				kst_esito = kuo_exception.get_st_esito( )
//				
//			end try
//	
//		next
//
//		destroy kuf1_prof
	
		
//--- Crea SCADENZE
		kuf1_ricevute = create kuf_ricevute

		for k_riga_fatture = 1 to k_nr_fatt

			try

				kst_tab_ricevute.num_fatt = kst_tab_arfa[k_riga_fatture].num_fatt
				kst_tab_ricevute.data_fatt = kst_tab_arfa[k_riga_fatture].data_fatt 
//--- Verifica se Scadenze già "Presentate"
				if not (kuf1_ricevute.if_gia_presentate(  kst_tab_ricevute  )) then
				
					kst_tab_ricevute.st_tab_g_0.esegui_commit = "N" 
//--- prima cancella le vecchie Scadenze
					kst_esito1 = kuf1_ricevute.tb_delete_x_fatt (  kst_tab_ricevute  ) 
					if kst_esito1.esito <> kkg_esito.db_ko then
						kst_tab_ricevute.st_tab_g_0.esegui_commit = "S" 
//--- ...poi crea le nuove Scadenze
						kst_esito1 = kuf1_ricevute.crea_rate( kst_tab_ricevute ) 
						if kst_esito1.esito = kkg_esito.db_ko then
							kst_esito = kst_esito1
						end if
					end if
				end if
		

			catch (uo_exception kuo1_exception)
				kst_esito = kuo1_exception.get_st_esito( )
				
			end try
			
		next
	
		destroy kuf1_ricevute
	
	end if


return kst_esito

end function

public function st_esito set_note (ref st_tab_arfa kst_tab_arfa);//
//--- Aggiorna Note di  Fattura
//---
//--- input: ID della fattura nel st_tab_arfa.id_fattura poi  campi:
//---                 num_fatt, data_fatt note_1...
//--- Out: kst_esito 
//---
//
long k_codice
st_tab_arfa kst_tab_arfa_1
st_esito kst_esito, kst_esito1
//--- 



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
if kst_tab_arfa.id_fattura > 0 then
	
	kst_tab_arfa_1.id_fattura = kst_tab_arfa.id_fattura
	kst_esito1 = kst_esito
	kst_esito1 = get_note (kst_tab_arfa_1) 	
	if kst_esito1.esito = kkg_esito.db_ko then  

		kst_esito = kst_esito1

	else

		if isnull(kst_tab_arfa.note_1)  then kst_tab_arfa.note_1 = ""
		if isnull(kst_tab_arfa.note_2)  then kst_tab_arfa.note_2 = ""
		if isnull(kst_tab_arfa.note_3)  then kst_tab_arfa.note_3 = ""
		if isnull(kst_tab_arfa.note_4)  then kst_tab_arfa.note_4 = ""
		if isnull(kst_tab_arfa.note_5)  then kst_tab_arfa.note_5 = ""
		if isnull(kst_tab_arfa.note_normative)  then kst_tab_arfa.note_normative = ""

//		kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()

//--- Se NOTE non ancora caricate faccio INSERT 		
		if kst_esito1.esito = kkg_esito.ok then
//---
			if len(trim(kst_tab_arfa.note_1))  > 0 &
				or len(trim(kst_tab_arfa.note_2))  > 0 &
				or len(trim(kst_tab_arfa.note_3))  > 0 &
				or len(trim(kst_tab_arfa.note_4))  > 0 &
				or len(trim(kst_tab_arfa.note_5))  > 0 &
				or len(trim(kst_tab_arfa.note_normative))  > 0 then

//---- aggiorna
				UPDATE fat1  
					  SET note_1 = :kst_tab_arfa.note_1 
							,note_2 = :kst_tab_arfa.note_2 
							,note_3 = :kst_tab_arfa.note_3 
							,note_4 = :kst_tab_arfa.note_4 
							,note_5 = :kst_tab_arfa.note_5
							,note_normative = :kst_tab_arfa.note_normative
							,num_fatt = :kst_tab_arfa.num_fatt
							,data_fatt = :kst_tab_arfa.data_fatt
					WHERE id_fattura = :kst_tab_arfa.id_fattura 
					using sqlca;
			else
//--- cancella le NOTE vecchie				
				delete from fat1  
					WHERE id_fattura = :kst_tab_arfa.id_fattura 
					using sqlca;
			end if					
		else

			if len(trim(kst_tab_arfa.note_1))  > 0 &
				or len(trim(kst_tab_arfa.note_2))  > 0 &
				or len(trim(kst_tab_arfa.note_3))  > 0 &
				or len(trim(kst_tab_arfa.note_4))  > 0 &
				or len(trim(kst_tab_arfa.note_5))  > 0 &
				or len(trim(kst_tab_arfa.note_normative))  > 0 then

	
			   INSERT INTO fat1  
						( num_fatt,   
						  data_fatt,   
						  id_fattura,   
						  note_1,   
						  note_2,   
						  note_3,   
						  note_4,   
						  note_5,
						  note_normative )  
					  VALUES 
						(
						 :kst_tab_arfa.num_fatt
						 ,:kst_tab_arfa.data_fatt
						 ,:kst_tab_arfa.id_fattura
						 ,:kst_tab_arfa.note_1 
						 ,:kst_tab_arfa.note_2 
						 ,:kst_tab_arfa.note_3 
						 ,:kst_tab_arfa.note_4 
						 ,:kst_tab_arfa.note_5 
						 ,:kst_tab_arfa.note_normative 
						)
					using sqlca;
					
			end if
			
		end if
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Note Fattura (id.=" + string(kst_tab_arfa.id_fattura)  + "  nr. " + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") ~n~r" &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
			
		if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
			if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca identificativo Fattura, aggiornam. Note non effettuato" 
	kst_esito.esito = kkg_esito.no_esecuzione
	
end if

return kst_esito


end function

public subroutine get_ultimo_numero (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Prende Ultimo Numero dell'anno di competenza 
//---
//---  input: st_tab_arfa.data_fatt (con l'anno impostato)
//---  otput: st_tab_arfa.num_fatt,  data_fatt
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.data_fatt > date('01.01.1900') then

	k_anno = year(kst_tab_arfa.data_fatt)
   	select distinct max(num_fatt)
	   into :kst_tab_arfa.num_fatt
	   from  V_ARFA
       where year(data_fatt)  =  :k_anno 
       using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Cliente Fattura (v_arfa) n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + "~n~r  " &
									 + "  id " + string(kst_tab_arfa.id_fattura ) + " ~n~r" + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_tab_arfa.num_fatt = 0
		else	
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero/id documento per leggere la Fattura (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



end subroutine

public function boolean get_prezzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//---
//--- Trova il giusto prezzo per l'articolo indicato in FATTURA 
//--- Input: st_tab_arfa con valorizzati:  id_listino, id_armo, id_armo_prezzo, clie_3
//---          Valorizza in Out: st_tab_arfa.prezzo_u
//--- Out: TRUE=prezzo trovato, FALSE=nessun prezzo valido Trovato
//--- Errore Lancia EXCEPTION: uo_exception
//---
boolean k_return = false
st_tab_armo kst_tab_armo
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_listino kst_tab_listino
st_esito kst_esito
kuf_listino kuf1_listino
kuf_armo_prezzi kuf1_armo_prezzi



kst_tab_arfa.prezzo_u = 0

try 
	
//--- se riga con prezzi voce	
	if kst_tab_arfa.id_armo_prezzo > 0 then
	
		kst_tab_armo_prezzi.id_armo_prezzo = kst_tab_arfa.id_armo_prezzo
		kuf1_armo_prezzi = create kuf_armo_prezzi 
		kuf1_armo_prezzi.get_prezzo(kst_tab_armo_prezzi)

		k_return = true
		kst_tab_arfa.prezzo_u = kst_tab_armo_prezzi.prezzo
	
	else
		
//--- se riga con solo id_listino 	
		if kst_tab_arfa.id_listino > 0 then
			
			kst_tab_listino.id = kst_tab_arfa.id_listino
			kst_tab_listino.cod_cli = kst_tab_arfa.clie_3
			kst_tab_armo.id_armo = kst_tab_arfa.id_armo
			
			kuf1_listino = create kuf_listino 
//---- piglia il prezzo da Listino 
			if kuf1_listino.get_prezzo(kst_tab_listino, kst_tab_armo) then
	
					k_return = true
					kst_tab_arfa.prezzo_u = kst_tab_listino.prezzo
	
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kguo_exception

finally
	
end try


return k_return


end function

public function boolean u_open_cancellazione (ref st_tab_arfa kst_tab_arfa);//---
//--- Apre la Window x CANCELLAZIONE Fattura 
//---
//--- Input: st_tab_arfa.id_fattra
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---


boolean k_return = false
st_esito kst_esito 
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window

if kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura) and kst_tab_arfa.num_fatt > 0 then
	kst_esito  = get_id(kst_tab_arfa)
end if	


if kst_esito.esito = kkg_esito.ok and kst_tab_arfa.id_fattura > 0 then
	
	k_return = true
	kst_tab_arfa.clie_3 = 0
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window


end if


return k_return



return k_return


end function

public subroutine get_numero_da_id (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Prende Numero/Data Dosumento dal ID
//---
//---  input: st_tab_arfa.id_fattura 
//---  otput: st_tab_arfa.num_fatt,  data_fatt
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then

   	select distinct num_fatt, data_fatt
	   into :kst_tab_arfa.num_fatt
	   		, :kst_tab_arfa.data_fatt
	   from  ARFA_TESTA
       where id_fattura  =  :kst_tab_arfa.id_fattura 
       using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore su Archivio Fatture (arfa_testa) id = " + string(kst_tab_arfa.ID_FATTURA ) + " ~n~r" &
									 +  trim(SQLCA.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_tab_arfa.num_fatt = 0
		else	
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id documento per leggere la Fattura (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



end subroutine

public function boolean u_open_inserimento (ref st_tab_arfa kst_tab_arfa);//---
//--- Apre Window x inserimento Fattura
//---
//---
//---

boolean k_return = true
//
long k_riga=0
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_arfa.id_fattura =0
kst_tab_arfa.clie_3 = 0
//
	

//if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if


return k_return


end function

public function boolean u_open_modifica (ref st_tab_arfa kst_tab_arfa);//---
//--- Apre la Window x Modifica Fattura 
//---
//--- Input: st_tab_arfa.id_fattra
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito 
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window

if kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura) and kst_tab_arfa.num_fatt > 0 then
	kst_esito  = get_id(kst_tab_arfa)
end if	


if kst_esito.esito = kkg_esito.ok and kst_tab_arfa.id_fattura > 0 then
	
	k_return = true
	kst_tab_arfa.clie_3 = 0
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = trim(string(kst_tab_arfa.clie_3)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function boolean u_open_visualizza (ref st_tab_arfa kst_tab_arfa);//---
//--- Apre la Window x Visualizzazione Fattura 
//---
//--- Input: st_tab_arfa.id_fattra
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if kst_tab_arfa.id_fattura = 0 or isnull(kst_tab_arfa.id_fattura) and kst_tab_arfa.num_fatt > 0 then
	kst_esito  = get_id(kst_tab_arfa)
end if	


if kst_esito.esito = kkg_esito.ok and kst_tab_arfa.id_fattura > 0 then
	
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_arfa.id_fattura)) // id fattura
	K_st_open_w.key2 = "0" // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function boolean u_open (st_tab_arfa kst_tab_arfa[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_arfa con id_fattura valorizzato se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
boolean  k_return = true
integer k_ind
st_esito kst_esito


k_ind=1 

		choose case kst_open_w.flag_modalita  

//			case kkg_flag_modalita.anteprima
//
//				if kst_tab_arfa[k_ind].id_fattura > 0 then
//					kst_esito = this.anteprima ( kds_1, kst_tab_arfa[k_ind])
//				end if
				
			case kkg_flag_modalita.stampa
				this.u_open_stampa(kst_tab_arfa[])		
				
			case kkg_flag_modalita.cancellazione
				this.u_open_cancellazione(kst_tab_arfa[k_ind])
				
			case kkg_flag_modalita.modifica
				this.u_open_modifica(kst_tab_arfa[k_ind])
				
			case kkg_flag_modalita.inserimento
				this.u_open_inserimento(kst_tab_arfa[k_ind])
				
			case kkg_flag_modalita.visualizzazione
				this.u_open_visualizza(kst_tab_arfa[k_ind])
				
			case else
					
					
			end choose		
			
 
 
return k_return

end function

public function integer u_tree_open (string k_modalita, st_tab_arfa kst_tab_arfa[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0
st_esito kst_esito
st_open_w kst_open_w


if upperbound(kst_tab_arfa) > 0 then

	choose case k_modalita  

		case kkg_flag_modalita.anteprima

			if kst_tab_arfa[1].num_fatt > 0 or kst_tab_arfa[1].id_fattura > 0 then
				kst_esito = anteprima ( kdw_anteprima, kst_tab_arfa[1])
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = 1
					kguo_exception.set_esito( kst_esito )
				// setmessage( "Accesso al Documento di Vendita non disponibile. ")
					kguo_exception.messaggio_utente( )
				end if
			end if

				
		case else

			kst_open_w.flag_modalita = k_modalita			
			if not this.u_open( kst_tab_arfa[], kst_open_w ) then  //Apre le Varie Funzioni
				k_return = 1
				
				kguo_exception.setmessage( "Operazione di Accesso al Documento di Vendita fallita. ")
				kguo_exception.messaggio_utente( )
			end if
				
				
				
	end choose		


end if	
 
 
return k_return

end function

public function boolean u_open_stampa (ref st_tab_arfa kst_tab_arfa[]);//---
//--- Stampa Fatture
//---
//---
//---

boolean k_return = false
long k_riga=0
integer k_ctr, k_index
//boolean k_fatt_selected_eof 
ds_fatture kds_fatture
st_tab_prof kst_tab_prof


			
	kds_fatture = create ds_fatture	

//--- Se sono RISTAMPE...					
//			if trim(kst_treeview_data_parent.oggetto) <> kuf1_treeview.kist_treeview_oggetto.fattura_dett_da_st  &
//				and trim(kst_treeview_data_parent.oggetto) <> kuf1_treeview.kist_treeview_oggetto.fattura_da_st then
//			if kst_tab_arfa
	
		
//--- Cicla fino a che ci sono righe selezionate
	k_index = 1
	do while k_index <= UpperBound(kst_tab_arfa)  //NOT k_fatt_selected_eof
		
		if kst_tab_arfa[k_index].num_fatt > 0 then
			k_riga=kds_fatture.insertrow(0)
			kds_fatture.object.num_fatt[k_riga] = kst_tab_arfa[k_index].num_fatt
			kds_fatture.object.data_fatt[k_riga] = kst_tab_arfa[k_index].data_fatt
			kds_fatture.object.sel[k_riga] = 1 //kds_fatture.kki_sel_si
				
		end if								
		k_index++
	loop

	if kds_fatture.rowcount( ) > 0 then	
		k_return = true
		try 
			stampa_fattura_nuova (kds_fatture)

//					stampa_fattura (kds_fatture)

		catch (uo_exception kuo_exception1)
			kuo_exception1.messaggio_utente()
		end try
	end if
	
	destroy kds_fatture
		

return k_return


end function

public subroutine elenco_indirizzi_commerciale (st_tab_arfa kst_tab_arfa);//
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
	kds_1.dataobject = kki_dw_elenco_indirizzi 
	kds_1.settransobject(sqlca) 
	
	if kst_tab_arfa.clie_3 > 0 then
		kst_tab_arfa.data_fatt = relativedate(kguo_g.get_dataoggi( ) , -720)
		
		kds_1.retrieve( kst_tab_arfa.clie_3,  kst_tab_arfa.data_fatt)
	
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
			kst_open_w.key1 = "Elenco Indirizzi Cliente: " + string( kst_tab_arfa.clie_3 ) //+ " " + trim(k_nome)
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

public subroutine elenco_note (st_tab_arfa kst_tab_arfa);//
//--- Fa l'elenco delle NOTE caricate in fatture precedenti
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
	kds_1.dataobject = kki_dw_elenco_note
	kds_1.settransobject(sqlca) 
	
	if kst_tab_arfa.clie_3 > 0 then
		
		kst_tab_arfa.data_fatt = relativedate(kG_dataoggi, -180)
		
		kds_1.retrieve( kst_tab_arfa.clie_3,  kst_tab_arfa.data_fatt)
	
//		k_nome = tab_1.tabpage_1.dw_1.getitemstring( 1, "rag_soc_10")
		
		if kds_1.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kst_open_w.id_programma =kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Note Cliente: " + string( kst_tab_arfa.clie_3 ) //+ " " + trim(k_nome)
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

public function boolean produci_fattura_piede_totali (st_tab_arfa kst_tab_arfa, readonly st_fattura_totali kst_fattura_totali);//---
//--- In stampa i totali di piede fattura
//---
boolean k_return=true
long k_riga, k_ctr, k_ctr1
decimal k_nettodapagare=0.00
st_tab_base kst_tab_base


//--- ricava riga 
	k_riga = kids_stampa_fattura.getrow( ) 
	
//--- stampa totali IVA	
	if kst_fattura_totali.cod_1 > 0 then //and kst_fattura_totali.imponibile_1 > 0 then
		if kst_fattura_totali.imponibile_1 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "imponibile_tot_1",  kst_fattura_totali.imponibile_1)  
		end if
		if kst_fattura_totali.iva_1 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "iva_tot_1",  kst_fattura_totali.iva_1)  
			if kst_fattura_totali.imposta_1 <> 0 then
				kids_stampa_fattura.setitem(k_riga, "imposta_tot_1",  kst_fattura_totali.imposta_1)  
			end if
		else
			kids_stampa_fattura.setitem(k_riga, "iva_tot_1",  kst_fattura_totali.cod_1)  
		end if
		kids_stampa_fattura.setitem(k_riga, "iva_des_1",  kst_fattura_totali.iva_des_1)  
	end if
	
	if kst_fattura_totali.cod_2 <> 0  then //and kst_fattura_totali.imponibile_2 > 0 then
		if kst_fattura_totali.imponibile_2 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "imponibile_tot_2",  kst_fattura_totali.imponibile_2)  
		end if
		if kst_fattura_totali.iva_2 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "iva_tot_2",  kst_fattura_totali.iva_2)  
			if kst_fattura_totali.imposta_2 <> 0 then
				kids_stampa_fattura.setitem(k_riga, "imposta_tot_2",  kst_fattura_totali.imposta_2)  
			end if
		else
			kids_stampa_fattura.setitem(k_riga, "iva_tot_2",  kst_fattura_totali.cod_2)  
		end if
		kids_stampa_fattura.setitem(k_riga, "iva_des_2",  kst_fattura_totali.iva_des_2)  
	end if
	
	if kst_fattura_totali.cod_3 <> 0  then //and kst_fattura_totali.imponibile_3 > 0 then
		if kst_fattura_totali.imponibile_3 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "imponibile_tot_3",  kst_fattura_totali.imponibile_3)  
		end if
		if kst_fattura_totali.iva_3 <> 0 then
			kids_stampa_fattura.setitem(k_riga, "iva_tot_3",  kst_fattura_totali.iva_3)  
			if kst_fattura_totali.imposta_3 <> 0 then
				kids_stampa_fattura.setitem(k_riga, "imposta_tot_3",  kst_fattura_totali.imposta_3)  
			end if
		else
			kids_stampa_fattura.setitem(k_riga, "iva_tot_3",  kst_fattura_totali.cod_3)  
		end if
		kids_stampa_fattura.setitem(k_riga, "iva_des_3",  kst_fattura_totali.iva_des_3)  
	end if
	
//	if kst_fattura_totali.cod_4 <> 0  then //and kst_fattura_totali.imponibile_4 > 0 then
//		if kst_fattura_totali.imponibile_4 <> 0 then
//			kids_stampa_fattura.setitem(k_riga, "imponibile_tot_4",  kst_fattura_totali.imponibile_4)  
//		end if
//		if kst_fattura_totali.iva_4 <> 0 then
//			kids_stampa_fattura.setitem(k_riga, "iva_tot_4",  kst_fattura_totali.iva_4)  
//			if kst_fattura_totali.imposta_4 <> 0 then
//				kids_stampa_fattura.setitem(k_riga, "imposta_tot_4",  kst_fattura_totali.imposta_4)  
//			end if
//		else
//			kids_stampa_fattura.setitem(k_riga, "iva_tot_4",  kst_fattura_totali.cod_4)  
//		end if
//		kids_stampa_fattura.setitem(k_riga, "iva_des_4",  kst_fattura_totali.iva_des_4)  
//	end if

//--- stampa totale generale	
	kids_stampa_fattura.setitem(k_riga, "divisa", "Euro")  
	kids_stampa_fattura.setitem(k_riga, "totale_generale", string( kst_fattura_totali.totale, "###,###,##0.00"))  

//--- Se ho la gestione SPLIT PAYMENT (dal 1/gennaio/2015) allora stampa il totale generale DA PAGARE
	if kst_fattura_totali.imp_splitpayment > 0 then
		k_nettodapagare = kst_fattura_totali.totale - kst_fattura_totali.imp_splitpayment
		kids_stampa_fattura.setitem(k_riga, "f_splitpayment", "S")  
		kids_stampa_fattura.setitem(k_riga, "divisa_1", "Euro")  
		kids_stampa_fattura.setitem(k_riga, "totale_nettodapagare", string( k_nettodapagare, "###,###,##0.00"))  
	else
		kids_stampa_fattura.setitem(k_riga, "f_splitpayment", "N")  
	end if
	
//--- pulizia campi Imponibile....
	kst_fattura_totali.imponibile_1 = 0.00
	kst_fattura_totali.imponibile_2 = 0.00
	kst_fattura_totali.imponibile_3 = 0.00
	kst_fattura_totali.imponibile_4 = 0.00
	kst_fattura_totali.imponibile_5 = 0.00
	kst_fattura_totali.iva_1 = 0
	kst_fattura_totali.iva_2 = 0
	kst_fattura_totali.iva_3 = 0
	kst_fattura_totali.iva_4 = 0
	kst_fattura_totali.iva_5 = 0
	kst_fattura_totali.imp_splitpayment = 0.00

//--- stampa il numero pagina (n di nn)
	for k_ctr = 1 to ki_pag_fattura   
		k_ctr1 = k_riga - ki_pag_fattura + k_ctr
		kids_stampa_fattura.setitem(k_ctr1, "pagina",  " Pag. " + trim(string(k_ctr)) + "  di " + trim(string(ki_pag_fattura)) )  
	end for



return k_return

end function

public function string get_banca_di_fattura () throws uo_exception;//--
//---  Torna la descrizione Banche da esporre in fattura 
//---
//---  input: --
//---  otput: stringa con st_tab_base.fatt_banca
//--- 			lancia EXCEPTION
//---
string k_rc
st_tab_base kst_tab_base
st_esito kst_esito 
kuf_base kuf1_base
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_base.fatt_banca = " "


kuf1_base = create kuf_base
k_rc = kuf1_base.prendi_dato_base("fatt_banca")
if LeftA(k_rc, 1) = "0" then
	kst_tab_base.fatt_banca = trim(MidA(k_rc, 2)) 
else
	kst_esito.esito =  kkg_esito.db_ko
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Errore durante lettura Archivio Azienda (BASE): " + trim(k_rc) + " id=" + "fatt_banca"
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
end if
				
destroy kuf1_base

return kst_tab_base.fatt_banca

end function

public function string get_norme_bolli (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna descrizione norme sui bolli 
//---
//---  input: st_tab_arfa.num_fatt, data_fatt, tipo_doc
//---  otput: stringa con st_tab_base.fatt_bolli_note
//--- 			lancia EXCEPTION
//---
string k_rc
st_tab_base kst_tab_base
st_tab_arfa kst_tab_arfa_v
st_esito kst_esito 
kuf_base kuf1_base
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_base.fatt_bolli_note = " "

//--- se è fattura
if kst_tab_arfa.tipo_doc = kki_tipo_doc_fattura or kst_tab_arfa.tipo_doc = kki_tipo_doc_Autofattura then
	
//--- calcolo il totale importo x le IVA per cui è previsto l'esposizione delle NORME	
	select sum(prezzo_t) 
		into :kst_tab_arfa.prezzo_t
		from arfa inner join iva on arfa.iva = iva.codice
		where arfa.num_fatt = :kst_tab_arfa.num_fatt
			 and arfa.data_fatt = :kst_tab_arfa.data_fatt 
			and iva.fatt_norme_bolli = 'S' 
		using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.esito =  kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Fattura (ARFA): " + trim(k_rc) + " num.=" + string(kst_tab_arfa.num_fatt) &
								+ trim(sqlca.sqlerrtext) 
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if
	
	select sum(prezzo_t) 
		into :kst_tab_arfa_v.prezzo_t
		from arfa_v inner join iva on arfa_v.iva = iva.codice
		where arfa_v.num_fatt = :kst_tab_arfa.num_fatt
			 and arfa_v.data_fatt = :kst_tab_arfa.data_fatt 
			and iva.fatt_norme_bolli = 'S' 
		using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.esito =  kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Fattura (ARFA): " + trim(k_rc) + " num.=" + string(kst_tab_arfa.num_fatt) &
								+ trim(sqlca.sqlerrtext) 
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if
		
	if kst_tab_arfa.prezzo_t > 0 then
		 if kst_tab_arfa_v.prezzo_t > 0 then 
			kst_tab_arfa.prezzo_t = kst_tab_arfa.prezzo_t + kst_tab_arfa_v.prezzo_t
		 end if
	else
		 if kst_tab_arfa_v.prezzo_t > 0 then 
			kst_tab_arfa.prezzo_t = kst_tab_arfa_v.prezzo_t
		else
			kst_tab_arfa.prezzo_t = 0
		end if
	end if
	
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
end if

return kst_tab_base.fatt_bolli_note

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
long k_rc
string k_rcx
boolean k_return=false
string k_dataobject, k_id_programma
st_tab_arfa kst_tab_arfa
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_listino kst_tab_listino
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
kuf_listino kuf1_listino
st_open_w kst_open_w 
kuf_armo kuf1_armo
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza
pointer kp_oldpointer

kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


if adw_link.getrow() = 0 then
else
	choose case a_campo_link
	
		case "b_arfa_lotto" 
			kst_tab_meca.id = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
			if kst_tab_meca.id > 0 then
				k_dataobject = "d_arfa_l_1"
				kst_open_w.key1 = "elenco righe fatturate  (id lotto=" + trim(string(kst_tab_meca.id)) + ") "
				k_id_programma = kkg_id_programma_fatture
				k_return = true	
			end if
	
		case "num_fatt"
			kst_tab_arfa.num_fatt = adw_link.getitemnumber(adw_link.getrow(), "num_fatt")
			if kst_tab_arfa.num_fatt > 0 then
				kst_tab_arfa.data_fatt = adw_link.getitemdate(adw_link.getrow(), "data_fatt")
				kst_open_w.key1 = "Documento di Vendita n. " + trim(string(kst_tab_arfa.num_fatt)) + " del " + trim(string(kst_tab_arfa.data_fatt)) 
				k_id_programma = kkg_id_programma_fatture
				k_return = true
			end if
	
		case "b_fatt_righe" 
			kst_tab_arfa.id_fattura = adw_link.getitemnumber(adw_link.getrow(), "id_fattura")
			if kst_tab_arfa.id_fattura > 0 then
				k_dataobject = "d_arfa_l_righe"
				kst_open_w.key1 = "elenco righe in fattura  (id fattura=" + trim(string(kst_tab_arfa.id_fattura)) + ") "
				k_id_programma = kkg_id_programma_fatture
				k_return = true	
			end if

//--- elenco contratti fatturati x codice contratto che può essere preso anche da ID_MECA o ID_ARMO o da ID_LISTINO 	
		case "b_arfalistaxcontr"
			k_rcx = adw_link.describe("contratto.x") 
			if k_rcx <> "!" then
				kst_tab_arfa.contratto = adw_link.getitemnumber(adw_link.getrow(), "contratto")
			else
				k_rcx = adw_link.describe("id_meca.x")
				if k_rcx <> "!" then
					//--- acchiappo il contratto da id meca
					kst_tab_meca.id = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
					kuf1_armo = create kuf_armo 
					kst_tab_arfa.contratto = kuf1_armo.get_contratto(kst_tab_meca)
				else
					k_rcx = adw_link.describe("id_armo.x")
					if k_rcx <> "!" then
						//--- acchiappo il contratto da id meca
						kst_tab_armo.id_armo = adw_link.getitemnumber(adw_link.getrow(), "id_armo")
						kuf1_armo = create kuf_armo 
						kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
						if kst_esito.esito = kkg_esito.ok then
							kst_tab_meca.id = kst_tab_armo.id_meca
							kst_tab_arfa.contratto = kuf1_armo.get_contratto(kst_tab_meca)
						end if
					else
						k_rcx = adw_link.describe("id_listino.x")
						if k_rcx <> "!" then
							kst_tab_arfa.id_listino = adw_link.getitemnumber(adw_link.getrow(), "id_listino")
							//--- acchiappo il contratto da listino
							kuf1_listino = create kuf_listino
							kst_tab_listino.id = kst_tab_arfa.id_listino
							kst_tab_arfa.contratto = kuf1_listino.get_contratto(kst_tab_listino)
						end if
					end if
				end if
			end if
			if kst_tab_arfa.contratto > 0 then
				k_dataobject = "d_arfa_l_xcontratto"
				kst_open_w.key1 = "elenco Fatture per il Contratto " + trim(string(kst_tab_arfa.contratto)) + " "
				k_id_programma = get_id_programma(kkg_flag_modalita.elenco) 
				k_return = true	
			end if

	
	end choose
end if


if k_return then

//	kst_open_w = kst_open_w
//	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
//	kst_open_w.id_programma = k_id_programma 
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	kuf1_sicurezza = create kuf_sicurezza
//	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//	destroy kuf1_sicurezza
	
	k_return = if_sicurezza(kkg_flag_modalita.elenco)
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Elenco non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
			kdsi_elenco_output.dataobject = k_dataobject		
			kdsi_elenco_output.settransobject(sqlca)
	
			kdsi_elenco_output.reset()	
			
			choose case a_campo_link
						
				case "b_arfa_lotto" 
					k_rc=kdsi_elenco_output.retrieve(kst_tab_meca.id)
			
				case "b_fatt_righe" 
					k_rc=kdsi_elenco_output.retrieve(kst_tab_arfa.id_fattura)
			
				case "num_fatt"
					kst_esito = anteprima ( kdsi_elenco_output, kst_tab_arfa )
					if kst_esito.esito <> kkg_esito.ok then
						kuo_exception = create uo_exception
						kuo_exception.set_esito( kst_esito)
						throw kuo_exception
					end if
					k_dataobject = kdsi_elenco_output.dataobject

				case "b_arfalistaxcontr"
					k_rc=kdsi_elenco_output.retrieve(kst_tab_arfa.contratto)
		
			end choose

	
//		else
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Nessuna dato da visualizzare: ~n~r" + "nessun codice indicato"
//			kst_esito.esito = kkg_esito.not_fnd
//			
//		end if
	end if
	


	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma.elenco  //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito get_prezzi_fattura (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna i Prezzi (unitario e totale) della riga di Fattura indicata
//---
//---  input: st_tab_arfa.id_arfa
//---  otput: st_tab_arfa.prezzo_u e prezzo_t e tipo_riga
//---
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_arfa > 0 then 

	if kst_tab_arfa.tipo_riga <> kki_tipo_riga_varia	 or isnull(kst_tab_arfa.tipo_riga) then
		select prezzo_u, prezzo_t
			into :kst_tab_arfa.prezzo_u
				,:kst_tab_arfa.prezzo_t
			from  ARFA
			 where ARFA.id_arfa   =  :kst_tab_arfa.id_arfa 
			 using sqlca;
	else		 
		select prezzo_u, prezzo_t
			into :kst_tab_arfa.prezzo_u
				,:kst_tab_arfa.prezzo_t
			from  ARFA_V
			 where ARFA_v.id_arfa_v   =  :kst_tab_arfa.id_arfa 
			 using sqlca;
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Prezzi riga Fattura id-riga " + string(kst_tab_arfa.id_arfa ) + " (arfa/arfa_v) " &
									 + trim(SQLCA.SQLErrText)
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
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id riga Fattura x fare la lettura in archivio (arfa/arfa_v) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito tb_delete_dett (ref st_tab_arfa kst_tab_arfa);//
//--- Cancella Riga Fattura
//---
//--- input: ID della riga fattura nel st_tab_arfa.id_arfa e tipo_riga (ovvero riga Varia o meno)
//---
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Riga Documento di Vendita non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO.no_aut

else


	if kst_tab_arfa.tipo_riga = kki_tipo_riga_maga then


//--- Avvia cancellazione archivi correlati x singole righe		
		kst_esito = this.tb_delete_ripristina_correlati( kst_tab_arfa )
												
		if kst_esito.esito <> KKG_ESITO.db_ko then

//--- cacella le righe di dettaglio
			DELETE from  arfa  
				WHERE id_arfa = :kst_tab_arfa.id_arfa
				using sqlca;
	
		
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Errore in aggiornam. Tab. Riga Fattura (id riga=" + string(kst_tab_arfa.id_arfa)  + ") : " &
											 + trim(SQLCA.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	else
		
//--- cancella le righe varie di dettaglio 
		DELETE from arfa_v  
				WHERE id_arfa_v = :kst_tab_arfa.id_arfa_v   
				using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Tab. Fattura Riga Varia (id riga=" + string(kst_tab_arfa.id_arfa_v) +") : " &
											 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
		
	if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else		
		if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		
	end if

end if

return kst_esito


end function

public function st_esito get_indirizzo_fattura (ref st_tab_arfa kst_tab_arfa);//
//====================================================================
//=== Legge tabella TESTATA FATTAURA  per reperire Idirizzo a fare le fatture
//=== 
//=== Input: kst_tab_arfa.id_fattura  
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD; 
//===          torna i campi kst_tab_arfa.rag_soc_1/ rag_soc_2/ indi_1 /loc_1 ecc...
//=== 
//====================================================================
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
         arfa_testa.id_cliente, 
  		arfa_testa.rag_soc_1,   
         arfa_testa.rag_soc_2,   
         arfa_testa.indi,   
         arfa_testa.loc,   
         arfa_testa.cap,   
         arfa_testa.prov,   
         arfa_testa.id_nazione
    INTO
	 	:kst_tab_arfa.clie_3, 
	 	:kst_tab_arfa.rag_soc_1,   
         :kst_tab_arfa.rag_soc_2,   
         :kst_tab_arfa.indi,   
         :kst_tab_arfa.loc,   
         :kst_tab_arfa.cap,   
         :kst_tab_arfa.prov,   
         :kst_tab_arfa.id_nazione  
    FROM arfa_testa  
   WHERE ( arfa_testa.id_fattura = :kst_tab_arfa.id_fattura )   
		using sqlca;


	if sqlca.sqlcode = 0 then
//--- OK
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Testata Documento Non Trovato (id=" + string(kst_tab_arfa.id_fattura)+") "
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			kst_esito.SQLErrText = "Errore in Tab.Testata Documento (arfa_testa):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
	end if

//	if_isnull(kst_tab_clienti)  // toglie i null

	



return kst_esito

end function

public function st_esito tb_delete_ripristina_correlati (st_tab_arfa kst_tab_arfa);//
//--- Ripristina la Riga Fattura gli archivi Correlati 
//---
//--- input: id_arfa 
//--- ret.:ST_ESITO
//
st_tab_arsp kst_tab_arsp
st_tab_armo kst_tab_armo
st_tab_armo_prezzi kst_tab_armo_prezzi
st_esito kst_esito
kuf_armo kuf1_armo
kuf_armo_prezzi kuf1_armo_prezzi
kuf_sped kuf1_sped



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kuf1_sped = create kuf_sped
	kuf1_armo = create kuf_armo
	kuf1_armo_prezzi = create kuf_armo_prezzi

//--- recupera i dati
	select id_armo
			,id_armo_prezzo 
			,colli
			,num_bolla_out
			,data_bolla_out
		into :kst_tab_arfa.id_armo
			,:kst_tab_arfa.id_armo_prezzo
			,:kst_tab_arfa.colli
			,:kst_tab_arfa.num_bolla_out
			,:kst_tab_arfa.data_bolla_out
		from arfa
		where id_arfa = :kst_tab_arfa.id_arfa   
				using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca riga Fattura (Tab. ARFA id.=" + string(kst_tab_arfa.id_arfa)  + ")  ~n~r" &
										 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else

//--- Avvia i ripristini sulla riga di ENTRATA
		if kst_tab_arfa.id_armo > 0 then
			kst_tab_armo.st_tab_g_0.esegui_commit = kst_tab_arfa.st_tab_g_0.esegui_commit
			kst_tab_armo.id_armo = kst_tab_arfa.id_armo
			kst_tab_armo.colli_fatt = -1 * kst_tab_arfa.colli
			kst_esito = kuf1_armo.set_colli_fatturati( kst_tab_armo )
		end if
		
//--- Avvia i ripristini sulla riga di BOLLA
		if kst_tab_arfa.id_armo > 0 and kst_esito.esito <> kkg_esito.db_ko then
			kst_tab_arsp.st_tab_g_0.esegui_commit = kst_tab_arfa.st_tab_g_0.esegui_commit
			kst_tab_arsp.id_armo = kst_tab_arfa.id_armo 
			kst_tab_arsp.num_bolla_out = kst_tab_arfa.num_bolla_out
			kst_tab_arsp.data_bolla_out = kst_tab_arfa.data_bolla_out
			kst_esito = kuf1_sped.set_arsp_fatturata_reset( kst_tab_arsp )
		end if
		
//--- Aggiorna lo stato e altro della riga ARMO_PREZZI
		if kst_tab_arfa.id_armo_prezzo > 0  and kst_esito.esito <> kkg_esito.db_ko then
			try
				kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = kst_tab_arfa.st_tab_g_0.esegui_commit
				kst_tab_armo_prezzi.id_armo_prezzo = kst_tab_arfa.id_armo_prezzo
				kst_tab_armo_prezzi.item_fatt = kst_tab_arfa.colli
				kuf1_armo_prezzi.set_fatturato_ripri( kst_tab_armo_prezzi )
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
			end try
		end if		
		
	end if
	
		
	if kst_esito.esito <> kkg_esito.db_ko then
		
//---- COMMIT....	
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else		
		if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
		
	end if



	destroy kuf1_sped 
	destroy kuf1_armo 
	destroy kuf1_armo_prezzi


return kst_esito


end function

public function st_esito tb_update_numero_data (st_tab_arfa kst_tab_arfa);//
//====================================================================
//=== Cambia il numero e data fattura 
//=== 
//=== Input: st_tab_arfa   id_fattura   e i nuovi valori di  num_fatt e data_fatt
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_tab_ricevute kst_tab_ricevute, kst_tab_ricevute_old
st_tab_prof kst_tab_prof, kst_tab_prof_old
st_open_w kst_open_w
st_tab_arfa kst_tab_arfa_old, kst_tab_arfa1
kuf_sicurezza kuf1_sicurezza
kuf_ricevute kuf1_ricevute



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Documento di Vendita non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try
	
		if kst_tab_arfa.id_fattura > 0 then

//--- recupera il numero e data di origine
			kst_tab_arfa_old = kst_tab_arfa
			get_numero_da_id(kst_tab_arfa_old)

//--- cambia prima tutte le righe varie
			update arfa_v
					set num_fatt = :kst_tab_arfa.num_fatt
						,data_fatt = :kst_tab_arfa.data_fatt
					WHERE id_fattura = :kst_tab_arfa.id_fattura
					using sqlca;
			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la modifca delle righe Varie della Fattura ~n~r" &
						+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARFA_V:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			else

			
//--- se tutto ok Modifica anche le altre righe
				update arfa
					set num_fatt = :kst_tab_arfa.num_fatt
						,data_fatt = :kst_tab_arfa.data_fatt
					WHERE id_fattura = :kst_tab_arfa.id_fattura
					using sqlca;
				
				if sqlca.sqlcode >= 0 then
					
		//--- se tutto ok cancella anche le altre tabelle
		
		//--- Modifica TESTATA							
					update  arfa_testa
					set num_fatt = :kst_tab_arfa.num_fatt
						,data_fatt = :kst_tab_arfa.data_fatt
					WHERE id_fattura = :kst_tab_arfa.id_fattura
					using sqlca;
									
		//--- Modifica le NOTE							
					update  fat1
					set num_fatt = :kst_tab_arfa.num_fatt
						,data_fatt = :kst_tab_arfa.data_fatt
					WHERE id_fattura = :kst_tab_arfa.id_fattura
					using sqlca;
									
		//--- cancello anche le RICEVUTE							
					kuf1_ricevute = create kuf_ricevute
					kst_tab_ricevute_old.num_fatt = kst_tab_arfa_old.num_fatt
					kst_tab_ricevute_old.data_fatt = kst_tab_arfa_old.data_fatt
					kst_tab_ricevute.num_fatt = kst_tab_arfa.num_fatt
					kst_tab_ricevute.data_fatt = kst_tab_arfa.data_fatt
					kuf1_ricevute.tb_update_num_data_fatt( kst_tab_ricevute_old, kst_tab_ricevute )
					destroy kuf1_ricevute
					
				else
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = &
		"Errore durante la Modifica della Fattura ~n~r" &
						+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
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
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		
		
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		
	end try
end if


return kst_esito

end function

public function boolean if_num_data_congruenti (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla che Num+Data Fattura siano congruenti
//---
//---  input: st_tab_arfa.num_fatt e data_fatt 
//---  otput: boolean = TRUE fattura congruente tutto OK;    FALSE=KO
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
string k_presente
int k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.num_fatt > 0 then 

	k_anno = year(kst_tab_arfa.data_fatt)

   	select distinct '1'
	   	into :k_presente
	   	from  ARFA_testa
		 where 
				year(DATA_FATT) =  :k_anno
				and ( (NUM_FATT >  :kst_tab_arfa.NUM_FATT and DATA_FATT <  :kst_tab_arfa.data_fatt)
				        or (NUM_FATT <  :kst_tab_arfa.NUM_FATT and DATA_FATT >  :kst_tab_arfa.data_fatt) )
		 using kguo_sqlca_db_magazzino ;
		 
	if sqlca.sqlcode = 0 then
		k_return = false
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante controllo data Fattura (arfa_testa) n. " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + "~n~r " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		else

//--- TUTTO OK!			
			k_return = TRUE
			
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero documento per controllo Fattura (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function st_esito get_ultimo_doc_ins (ref st_tab_arfa kst_tab_arfa);//
//====================================================================
//=== Torna l'ultima Fattura (Numero e Data) della Anagrafica impostata
//=== 
//=== Input : st_tab_arfa.clie_2
//=== Out: st_tab_arfa.num_fatt + data_fatt + id_fattura
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select id_fattura	
			,num_fatt
	        ,data_fatt
		into :kst_tab_arfa.id_fattura
			,:kst_tab_arfa.num_fatt
			,:kst_tab_arfa.data_fatt
		from arfa_testa  
		where id_fattura in 
		(select max(id_fattura) from arfa_testa 
			where id_cliente = :kst_tab_arfa.clie_3 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa.num_fatt = 0
		kst_tab_arfa.id_fattura = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function boolean if_esiste_fattura (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla esistenza Fattura
//---
//---  input: st_tab_arfa.num_fatt e data_fatt Oppure id_fattura
//---  otput: boolean = TRUE fattura in archivio e quindi anche il st_tab_arfa.clie_3 
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_arfa.clie_3 = 0

if kst_tab_arfa.id_fattura > 0 then 
   select distinct 1
	   into :kst_tab_arfa.clie_3
	   from  ARFA_testa
       where id_fattura   =  :kst_tab_arfa.id_fattura 
       using kguo_sqlca_db_magazzino;
else
	if kst_tab_arfa.num_fatt > 0 then 
		k_anno = year(kst_tab_arfa.DATA_FATT)
		select distinct 1
			into :kst_tab_arfa.clie_3
			from  ARFA_testa
			 where NUM_FATT =  :kst_tab_arfa.NUM_FATT 
						  and year(DATA_FATT) =  :k_anno
			 using kguo_sqlca_db_magazzino;
	end if
end if

if kst_tab_arfa.num_fatt > 0 or  kst_tab_arfa.id_fattura > 0 then 
	
	if kst_tab_arfa.clie_3 > 0 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Lettura Esistenza Fattura (arfa_testa) " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + "~n~r  " &
										 + "  id " + string(kst_tab_arfa.id_fattura ) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero/id documento per leggere la Fattura (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function double get_totale_x_cliente_periodo (st_tab_arfa kst_tab_arfa_da, st_tab_arfa kst_tab_arfa_a) throws uo_exception;//---
//--- Torna la somma del  prezzo_t  x il CLIENTE e periodo indicato meno la fattura eventualmente indicata e se passato solo x il codice iva indicato
//---
//--- Input: st_tab_arfa_da / a con valorizzati:   st_tab_arfa_da.clie_3, st_tab_arfa_da.data_fatt, st_tab_arfa_a.data_fatt  
//--- 														eventualmente anche st_tab_arfa_da.id_fattura da scartare e st_tab_arfa_da.iva da includere
//--- Ritorna: importo 
//---
double k_tot_fatture=0.00, k_tot_nc=0.00, k_tot_fatture_v=0.00, k_tot_nc_v=0.00
st_tab_armo kst_tab_armo
st_tab_listino kst_tab_listino
st_esito kst_esito
kuf_listino kuf1_listino
kuf_armo kuf1_armo
uo_exception kuo_exception



	
	if kst_tab_arfa_da.clie_3 > 0   then
		
		if isnull(kst_tab_arfa_da.id_fattura) then kst_tab_arfa_da.id_fattura = 0
		if isnull(kst_tab_arfa_da.iva) then kst_tab_arfa_da.iva = 0
		
		select sum(prezzo_t)
			 into :k_tot_fatture
			 from arfa
			 where clie_3 = :kst_tab_arfa_da.clie_3 
					 and (:kst_tab_arfa_da.id_fattura=0 or id_fattura <> :kst_tab_arfa_da.id_fattura)
					 and (:kst_tab_arfa_da.iva=0 or  iva = :kst_tab_arfa_da.iva)
					 and data_fatt between :kst_tab_arfa_da.data_fatt and :kst_tab_arfa_a.data_fatt
					 and arfa.tipo_doc in (:kki_tipo_doc_fattura, :kki_tipo_doc_AutoFattura)
			using sqlca;

		if sqlca.sqlcode = 0 then

			if isnull(k_tot_fatture) then
				k_tot_fatture = 0
			end if

			select sum(prezzo_t)
				 into :k_tot_fatture_v
				 from arfa_v
				 where clie_3 = :kst_tab_arfa_da.clie_3 
						 and (:kst_tab_arfa_da.id_fattura=0 or id_fattura <> :kst_tab_arfa_da.id_fattura)
						 and (:kst_tab_arfa_da.iva=0 or  iva = :kst_tab_arfa_da.iva)
						 and data_fatt between :kst_tab_arfa_da.data_fatt and :kst_tab_arfa_a.data_fatt
						 and tipo_doc in (:kki_tipo_doc_fattura, :kki_tipo_doc_AutoFattura)
				using sqlca;
	
			if sqlca.sqlcode = 0 then
	
				if k_tot_fatture_v > 0 then
					k_tot_fatture += k_tot_fatture_v
				end if

				select sum(prezzo_t)
					 into :k_tot_nc
					 from arfa
					 where clie_3 = :kst_tab_arfa_da.clie_3 
							 and (:kst_tab_arfa_da.id_fattura=0 or id_fattura <> :kst_tab_arfa_da.id_fattura)
							 and (:kst_tab_arfa_da.iva=0 or  iva = :kst_tab_arfa_da.iva)
							 and data_fatt between :kst_tab_arfa_da.data_fatt and :kst_tab_arfa_a.data_fatt
							 and arfa.tipo_doc = :kki_tipo_doc_nota_di_credito
					using sqlca;
		
				if sqlca.sqlcode = 0 then
					if k_tot_nc > 0 then
						k_tot_fatture = k_tot_fatture - k_tot_nc
					end if	
	
					select sum(prezzo_t)
						 into :k_tot_nc_v
						 from arfa_v
						 where clie_3 = :kst_tab_arfa_da.clie_3 
								 and (:kst_tab_arfa_da.id_fattura=0 or id_fattura <> :kst_tab_arfa_da.id_fattura)
								 and (:kst_tab_arfa_da.iva=0 or  iva = :kst_tab_arfa_da.iva)
								 and data_fatt between :kst_tab_arfa_da.data_fatt and :kst_tab_arfa_a.data_fatt
								 and tipo_doc = :kki_tipo_doc_nota_di_credito
						using sqlca;
			
					if sqlca.sqlcode = 0 then
						if k_tot_nc > 0 then
							k_tot_fatture = k_tot_fatture - k_tot_nc
						end if	
					else
						if sqlca.sqlcode < 0 then
							kst_esito.sqlcode = sqlca.sqlcode
							kst_esito.SQLErrText = "Lettura N.Credito Fallita righe Varie, cliente: " + string(kst_tab_arfa_da.clie_3) +" ~n~r"+ trim(sqlca.SQLErrText)
							kst_esito.esito = kkg_esito.db_ko
						end if
					end if
				else
					if sqlca.sqlcode < 0 then
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = "Lettura N.Credito Fallita, cliente: " + string(kst_tab_arfa_da.clie_3) +" ~n~r"+ trim(sqlca.SQLErrText)
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			else
				if sqlca.sqlcode < 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Lettura Fatture righe Varie Fallita, cliente: " + string(kst_tab_arfa_da.clie_3) +" ~n~r"+ trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Lettura Fatture Fallita, cliente: " + string(kst_tab_arfa_da.clie_3) +" ~n~r"+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
//		
//			else			
//				kst_tab_arfa.prezzo_t = 0
//			end if
//			
//		else
//			kst_tab_arfa.prezzo_t = kst_tab_arfa.prezzo_u
//		end if
//			
	else			
		kst_esito.SQLErrText = "Impossibile calcolare Totale Fatturato, Codice Cliente non Indicato! "
		kst_esito.esito = kkg_esito.err_logico

	end if

	if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.err_logico then
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


return k_tot_fatture


end function

public function st_esito get_data_stampa (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il Data Stampa
//-- 	input:  ID_FATTURA 
//---	out: stampa e data_stampa
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.stampa
			, arfa_testa.data_stampa
		into :kst_tab_arfa.stampa
			,:kst_tab_arfa.data_stampa
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovato (data stampa) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura Fattura (id=" + string(kst_tab_arfa.id_fattura ) + ") " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura di 'Data Stampa'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito get_modo_stampa (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna la modalità di stampa 
//-- 	input:  ID_FATTURA 
//---	out: MODO_STAMPA
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.modo_stampa
		into :kst_tab_arfa.modo_stampa
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_arfa.modo_stampa) or len(trim(kst_tab_arfa.modo_stampa)) = 0 then kst_tab_arfa.modo_stampa = this.kki_modo_stampa_cartaceo  // Questo il DEFAULT
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovata (modo_stampa) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura della Fattura (modo_stampa) id=" + string(kst_tab_arfa.id_fattura ) + " - " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'Modo di Stampa'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito get_modo_email (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna la modalità di invio e-mail 
//-- 	input:  ID_FATTURA 
//---	out: modo_email
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.modo_email
		into :kst_tab_arfa.modo_email
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_arfa.modo_email) or len(trim(kst_tab_arfa.modo_email)) = 0 then kst_tab_arfa.modo_email = this.kki_modo_email_no  // Questo il DEFAULT
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovata (modo_email) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura della Fattura (modo_email) id=" + string(kst_tab_arfa.id_fattura ) + " - " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'Modo di invio e-mail'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito get_file_prodotto (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il nome del file PDF prodotto 
//-- 	input:  ID_FATTURA 
//---	out: file_prodotto
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.file_prodotto
		into :kst_tab_arfa.file_prodotto
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_arfa.file_prodotto) or len(trim(kst_tab_arfa.file_prodotto)) = 0 then kst_tab_arfa.file_prodotto = ""  // Questo il DEFAULT
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovata (file_prodotto) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura della Fattura (file_prodotto) id=" + string(kst_tab_arfa.id_fattura ) + " - " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'File PDF prodotto'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito set_file_prodotto (ref st_tab_arfa kst_tab_arfa);//
//--- Aggiorna il campo File Prodotto in Testata Fattura
//---
//--- input: ID della fattura nel st_tab_arfa.id_fattura e file_prodotto
//---
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_fatture

////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_autorizza then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Modifica del Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

//--- 

	if kst_tab_arfa.id_fattura > 0 then
	
		kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()
		
		UPDATE arfa_testa  
				  SET  file_prodotto = :kst_tab_arfa.file_prodotto						
				WHERE arfa_testa.id_fattura = :kst_tab_arfa.id_fattura   
				using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Tab. Fatture. (id.=" + string(kst_tab_arfa.id_fattura)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
			
		if kst_esito.esito = kkg_esito.ok then
			
	//---- COMMIT....	
			if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Aggiornam. (testa) Tab. Fattura NON effettuato Manca ID (id_fattura) "
		kst_esito.esito = kkg_esito.err_logico
	end if

//end if
	
return kst_esito


end function

public function st_esito get_email_invio (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna la Numero indirizzo a cui inviare la e-mail
//-- 	input:  ID_FATTURA 
//---	out: EMAIL_INVIO
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.email_invio
		into :kst_tab_arfa.email_invio
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_arfa.email_invio) or len(trim(kst_tab_arfa.email_invio)) = 0 then kst_tab_arfa.email_invio = kki_email_invio_default
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovata (email_invio) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura della Fattura (email_invio) id=" + string(kst_tab_arfa.id_fattura ) + " - " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'Nr. email di invio'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function string get_email_indirizzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna l'indirizzo e-mail 
//-- 	input:  ID_FATTURA 
//---
//--- 	ritorna: l'indirizzo e-mail di invio
//---   lancia: uo_exception
//---
//---
string k_return = ""
int k_nr_email=0
st_esito kst_esito 
kuf_clienti kuf1_clienti 
st_tab_clienti_web kst_tab_clienti_web
long k_ctr
uo_exception kuo2_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	try 
		kuf1_clienti = create kuf_clienti
		
		kst_esito = get_email_invio(kst_tab_arfa)
		if kst_esito.esito = kkg_esito.ok then
			
	//--- se non c'e' get del cliente		
			if isnull(kst_tab_arfa.clie_3 ) or kst_tab_arfa.clie_3 = 0 then
				this.get_cliente(kst_tab_arfa)
			end if
			
	//--- finalmente becco l'indirizzo e-mail del cliente
			kst_tab_clienti_web.id_cliente = kst_tab_arfa.clie_3
			if isnumber(kst_tab_arfa.email_invio) then
				k_nr_email = integer(kst_tab_arfa.email_invio)
			end if
			if k_nr_email > 0 then
				k_return = kuf1_clienti.get_email_indirizzo(kst_tab_clienti_web, k_nr_email)
			end if
//			kst_esito = kuf1_clienti.get_email(kst_tab_clienti_web)
//	
//			if kst_esito.esito = kkg_esito.db_ko then
//				kuo2_exception = create uo_exception
//				kuo2_exception.set_esito(kst_esito)
//				throw kuo2_exception
//
//			else
//	
//				if kst_esito.esito = kkg_esito.ok then
//	//--- scelta del e-mail ta tornare			
//					choose case kst_tab_arfa.email_invio
//						case kki_email_invio_email1
//							k_return = kst_tab_clienti_web.email
//						case kki_email_invio_email2
//							k_return = kst_tab_clienti_web.email1
//						case kki_email_invio_email3
//							k_return = kst_tab_clienti_web.email2
//					end choose
//				else
//					k_return = ""
//				end if
//			end if
		else
			kuo2_exception = create uo_exception
			kuo2_exception.set_esito(kst_esito)
			throw kuo2_exception
			
		end if
		
	catch (uo_exception kuo1_exception)
		throw kuo1_exception
		
	finally 
		destroy kuf1_clienti
		
	end try
		
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'Indirizzo e-mail'. " 
	kst_esito.esito = kkg_esito.err_logico
	
	kuo2_exception = create uo_exception
	kuo2_exception.set_esito(kst_esito)
	throw kuo2_exception
end if


return k_return
end function

public function long get_id_email (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna ID_EMAIL della e-mail 
//-- 	input:  ID_FATTURA + MODO_EMAIL
//---
//--- 	ritorna: il long  ID_EMAIL della e-mail 
//---   lancia: uo_exception
//---
//---
long k_return = 0
//st_esito kst_esito 
//kuf_clienti kuf1_clienti 
//st_tab_clienti_web kst_tab_clienti_web
//long k_ctr
//uo_exception kuo_exception
kuf_email_funzioni kuf1_email_funzioni
//string k_esito=""
//string k_tipo_email=""
st_tab_email_funzioni kst_tab_email_funzioni


//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()


	try 
		
		kuf1_email_funzioni = create kuf_email_funzioni
	
		if kst_tab_arfa.modo_email = kki_modo_email_avvisa then
//			k_tipo_email = "id_email_lettera_avviso"
			kst_tab_email_funzioni.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
			k_return = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
		else
			if kst_tab_arfa.modo_email = kki_modo_email_allega then
//				k_tipo_email = "id_email_lettera_fattura"
				kst_tab_email_funzioni.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturaSIallegati
				k_return = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
			end if
		end if
		
//		if k_tipo_email <> "" then 	
//	//--- get del ID della EMAIL da inviare		
//			k_esito = kuf1_email_funzioni.prendi_dato_email_funzioni(k_tipo_email)
//			if left(k_esito,1) <> "0" then
//				kst_esito.nome_oggetto = this.classname()
//				kst_esito.esito = kkg_esito.db_ko  
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = mid(k_esito,2)
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito(kst_esito)
//				throw kuo_exception
//				
//			else
//				k_return = long(mid(k_esito,2)) 
//			end if
//		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	finally
		destroy kuf1_email_funzioni
	
	end try
	
		
//else
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura codice Prototipo e-mail da inviare. " 
//	kst_esito.esito = kkg_esito.err_logico
//	
//	kuo_exception = create uo_exception
//	kuo_exception.set_esito(kst_esito)
//	throw kuo_exception
//end if


return k_return
end function

public function long add_email_invio (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_arfa valorizzata con i campi necessari
//--- Out: il ID del email_invio
//
long k_return=0 
kuf_email_invio kuf1_email_invio
kuf_email_funzioni kuf1_email_funzioni
kuf_email kuf1_email
st_tab_email_invio kst_tab_email_invio
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni
st_esito kst_esito
uo_exception kuo1_exception


	try
		
//--- Aggiorna tabella email_invio prepara agli invii
		kuf1_email_invio = create kuf_email_invio
		kuf1_email = create kuf_email
		kuf1_email_funzioni = create kuf_email_funzioni
		
		kst_tab_email_invio.id_email_invio =  0
		kst_tab_email_invio.id_cliente =  kst_tab_arfa.clie_3
		if kst_tab_arfa.modo_email = this.kki_modo_email_allega then 
			kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_si
			kst_tab_email_invio.allegati_cartella = this.get_path_documento_digitale_dainviare(kst_tab_arfa) 
		else
			kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_no
			kst_tab_email_invio.allegati_cartella = ""
		end if
		kst_tab_email_invio.email = this.get_email_indirizzo(kst_tab_arfa)

		if isnull(kst_tab_arfa.modo_email ) or len(trim(kst_tab_arfa.modo_email)) = 0 then
			this.get_modo_email(kst_tab_arfa) 	//--- se non c'e' il modo_email lo piglio
		end if
	
//--- puo' essere che a un documento  non debba 	inviare nulla
		if kst_tab_arfa.modo_email <> kki_modo_email_no then
			
			if kst_tab_arfa.modo_email = kki_modo_email_avvisa then
				kst_tab_email_funzioni.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
			else
				if kst_tab_arfa.modo_email = kki_modo_email_allega then
					kst_tab_email_funzioni.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturaSIallegati
				end if
			end if
			kst_tab_email.id_email = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
//			kst_tab_email.id_email = this.get_id_email(kst_tab_arfa)
			if kst_tab_email.id_email = 0 then
				kuo1_exception = create uo_exception
				kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_not_fnd )
				kuo1_exception.set_nome_oggetto(this.classname( ) )
				kuo1_exception.setmessage( "Impostare da 'Proprietà della Procedura' il Prototipo e-mail da utilizzare per l'invio funzionale '" + trim(kst_tab_email_funzioni.cod_funzione)+"' ")
				throw kuo1_exception
			end if
//--- recupero il cod funzione sempre dalla tabella associazioni prototipi-funzioni	
			kst_tab_email_funzioni.id_email = kst_tab_email.id_email
			kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.get_cod_funzione(kst_tab_email_funzioni)
//--- recupero diversi dati x riempire la tab email-invio			
			kuf1_email.get_riga(kst_tab_email)
			kst_tab_email_invio.oggetto = kst_tab_email.oggetto
			kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
			kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
			kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
			kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
			kst_tab_email_invio.id_oggetto = kst_tab_arfa.id_fattura
		else
			kst_tab_email_invio.oggetto = ""
			kst_tab_email_invio.link_lettera = ""
			kst_tab_email_invio.flg_lettera_html = ""
			kst_tab_email_invio.flg_ritorno_ricev = ""
			kst_tab_email_invio.email_di_ritorno = ""
		end if
		kuf1_email_invio.if_isnull(kst_tab_email_invio)

		kst_tab_email_invio.note = "da fattura " + string(kst_tab_arfa.num_fatt) + "  " +  string(kst_tab_arfa.data_fatt) + "   id " + string(kst_tab_arfa.id_fattura) + " "  
		
		kst_esito = get_id_email_invio(kst_tab_arfa)
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd then
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if			
		
		kst_tab_email_invio.id_email_invio = kst_tab_arfa.id_email_invio

//--- Controllo la presenza in elenco della EMAIL
		if kst_tab_email_invio.id_email_invio > 0 then
			kst_esito = kuf1_email_invio.check_presenza(kst_tab_email_invio)
			if kst_esito.esito <> kkg_esito.ok  then
				kst_tab_email_invio.id_email_invio = 0
			end if
		end if
			
//--- CARICO dati nella tabella EMAIL_INVIO		
		if kst_tab_email_invio.id_email_invio > 0 then
			if kuf1_email_invio.tb_update(kst_tab_email_invio)  then 
				
				k_return = kst_tab_email_invio.id_email_invio
			end if
		else
			if kuf1_email_invio.tb_add(kst_tab_email_invio)  then 
			
				k_return = kst_tab_email_invio.id_email_invio
			end if
		end if		

	catch (uo_exception kuo_exception)	
		throw kuo_exception
		
	finally
		destroy kuf1_email
		destroy kuf1_email_invio
	end try



return k_return

end function

public function st_esito get_id_email_invio (ref st_tab_arfa kst_tab_arfa);//--
//---  Torna il campo Id alla tabella email_invio
//-- 	input:  ID_FATTURA 
//---	out: id_email_invio
//--- 	ritorna: st_esito
//---
st_esito kst_esito 
long k_ctr


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 

	select ARFA_TESTA.id_email_invio
		into :kst_tab_arfa.id_email_invio
				from  ARFA_TESTA 
				where ARFA_TESTA.ID_FATTURA   = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_arfa.id_email_invio)  then kst_tab_arfa.id_email_invio = 0
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_arfa.TIPO_DOC	= " "
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Fattura Non Trovata (id_email_invio) (id=" + string(kst_tab_arfa.id_fattura ) + ") " //+ " del " + string(kst_tab_arfa.DATA_FATT ) + ". " 
		else	
			kst_esito.SQLErrText = "Errore in lettura della Fattura (id_email_invio) id=" + string(kst_tab_arfa.id_fattura ) + " - " + trim(SQLCA.SQLErrText) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca 'id' del Documento di Vendita x Lettura del 'Id della tab. email di invio'. " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function st_esito set_id_email_invio (ref st_tab_arfa kst_tab_arfa);//
//--- Aggiorna il campo ID_EMAIL_INVIO in Testata Fattura
//---
//--- input: ID della fattura nel st_tab_arfa.id_fattura e id_email_invio
//---
//
long k_codice
st_esito kst_esito
boolean k_autorizza
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_fatture

////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_autorizza then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Modifica del Documento di Vendita non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

//--- 

	if kst_tab_arfa.id_fattura > 0 then
	
		kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()
		
		UPDATE arfa_testa  
				  SET  id_email_invio = :kst_tab_arfa.id_email_invio						
				WHERE arfa_testa.id_fattura = :kst_tab_arfa.id_fattura   
				using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornam. Tab. Fatture. (id_email_invio) (id.=" + string(kst_tab_arfa.id_fattura)  + " nr.=" + string(kst_tab_arfa.num_fatt) + " del "  + string(kst_tab_arfa.data_fatt) +") : " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
			
		if kst_esito.esito = kkg_esito.ok then
			
	//---- COMMIT....	
			if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			if kst_tab_arfa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Aggiornam. (id_email_invio) Tab. Fattura NON effettuato, Manca ID (id_fattura) "
		kst_esito.esito = kkg_esito.err_logico
	end if

//end if
	
return kst_esito


end function

public function boolean stampa_fattura_emissione (string titolo) throws uo_exception;//
//--- stampa fatture - richiama il gestore delle stampa
//--- input:  titolo     un titolo per la stampa
//--- out: true = OK, false = non stampata
//---
boolean k_stampato=true
int k_errore=0, k_rc
st_stampe kst_stampe

	if kids_stampa_fattura.rowcount() > 0 then

//		kdw_1 = create datawindow
//		string k_do
//		k_do = 
//		kdw_1.DataObject = "d_txt_fpilota_out" //trim(k_do) //kids_stampa_fattura.DataObject 
////		k_rc=kdw_1.SetTransObject(SQLCA)
//		
//		k_rc=kdw_1.insertrow(0)
//		
//		long k_fRow = 0
//		k_fRow = kdw_1.rowcount()
//		k_fRow = kids_stampa_fattura.RowCount()
//		k_rc=kids_stampa_fattura.RowsCopy(1,k_fRow, Primary!, kdw_1, 1, Primary!)
//		k_fRow = kdw_1.rowcount()

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.ds_print = create datastore
		kst_stampe.ds_print.dataobject = kids_stampa_fattura.dataobject
		kids_stampa_fattura.rowscopy( 1, kids_stampa_fattura.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
//		kst_stampe.ds_print = kids_stampa_fattura
		kst_stampe.titolo = trim(titolo)
		kst_stampe.stampante_predefinita = ki_stampante_predefinita
		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no


		k_errore = kGuf_data_base.stampa_dw(kst_stampe)
		if k_errore <> 0 then
			k_stampato=false
		end if
	end if
	
 

return k_stampato

end function

public function integer stampa_fattura_nuova (ref ds_fatture kds_fatture) throws uo_exception;//
//--- stampa fatture mai stampate
//--- input:  ds_fatture (datastore con elenco fatture)
//--- out: Numero fatture prodotte
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_fatture_stampate=0
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_menu_window kuf1_menu_window
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if

if kds_fatture.rowcount() > 0 then

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;
		
	Kst_open_w.id_programma = kkg_id_programma_fatture_stampa
	Kst_open_w.flag_primo_giro = "S"
	Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
	Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	Kst_open_w.flag_leggi_dw = "N"
	kst_open_w.key12_any = kds_fatture   // datastore
	kst_open_w.flag_where = " "
	
		
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

end if




return k_n_fatture_stampate

end function

public function integer stampa_fattura_digitale (ds_fatture kds_fatture) throws uo_exception;//
//--- Produce le fatture in digitale (pdf)
//--- input:  ds_fatture (datastore con elenco fatture)
//--- out: Numero fatture prodotte
//---
boolean k_stampato=true, k_sicurezza=true
long k_riga=0
int k_ctr=0, k_n_fatture_stampate=0, k_n_fatture, k_id_stampa
string k_esito="", k_stampante_pdf=""
st_tab_arfa kst_tab_arfa, kst_tab_arfa_appo
//st_tab_docprod kst_tab_docprod
ds_fatture kds_fatture_unica
st_esito kst_esito 
st_open_w kst_open_w
//kuf_docprod kuf1_docprod
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base
uo_exception kuo_exception

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()




kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Emissione Fattura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

else

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
//		kst_esito.nome_oggetto = this.classname()
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base


	try 
		
		if len(trim(k_stampante_pdf)) > 0 then
			
			if kds_fatture.rowcount() > 0 then
		
				kds_fatture_unica = create ds_fatture
				
//---- Crea oggetto x stampa fattura
				produci_fattura_inizio()
		
				for k_riga = 1 to kds_fatture.rowcount()

//---- produce solo le fatture digitali e di esportazione 
					if kds_fatture.object.modo_stampa[k_riga] <> kki_modo_stampa_cartaceo then

		
						kst_tab_arfa.id_fattura = kds_fatture.object.id_fattura[k_riga]	

//--- Ogni nuova fattura inizializzo !!!!
						kids_stampa_fattura.dataobject = ""
						produci_fattura_inizializza(kst_tab_arfa) 
			
						kds_fatture_unica.reset( )
						kds_fatture_unica.insertrow(0)
//--- produci_fattura	
						kds_fatture_unica.object.NUM_FATT[1] = kds_fatture.object.NUM_FATT[k_riga]
						kds_fatture_unica.object.DATA_FATT[1] = kds_fatture.object.DATA_FATT[k_riga]
						kds_fatture_unica.object.id_fattura[1] = kds_fatture.object.id_fattura[k_riga]
						kds_fatture_unica.object.diprova[1] = kds_fatture.object.diprova[k_riga]
						kst_tab_arfa.modo_stampa = kds_fatture.object.modo_stampa[k_riga]
						k_n_fatture = produci_fattura(kds_fatture_unica)
				
						kst_tab_arfa.id_fattura = kds_fatture_unica.object.id_fattura[1]
						this.get_cliente(kst_tab_arfa)
						
//--- Sono in operazione di "Esportazione Documenti" x cui piglio il PATH dal docprod							
						if kds_fatture.object.esporta[k_riga] = kki_esporta_documento_si then

//							kuf1_docprod = create kuf_docprod
//							kst_tab_docprod.id_docprod = kds_fatture.object.id_docprod[k_riga]
//							kst_tab_docprod.doc_data = kds_fatture.object.data_fatt[k_riga]
//							kst_tab_docprod.doc_num = kds_fatture.object.num_fatt[k_riga]
//							kst_tab_docprod.id_doc = kds_fatture.object.id_fattura[k_riga]
//							kst_tab_docprod.id_cliente = kst_tab_arfa.clie_3
//							kst_tab_arfa.file_prodotto = kuf1_docprod.get_path(kst_tab_docprod)
							kst_tab_arfa.file_prodotto =  kds_fatture.object.file_prodotto[k_riga]
							
						else
							
//--- Sono in EMISSIONE normale x cui piglio il PATH per fare la e-mail
							this.get_modo_email(kst_tab_arfa)
						
//--- Get del percorso +	il nome del file PDF
							if kds_fatture_unica.object.diprova[1] = kki_stampa_diProva_si then
								kst_tab_arfa.file_prodotto = this.get_path_documento_digitale_diprova(kst_tab_arfa)
							else
								if kst_tab_arfa.modo_email = this.kki_modo_email_allega then
									kst_tab_arfa.file_prodotto = this.get_path_documento_digitale_dainviare(kst_tab_arfa)
								else
									kst_tab_arfa.file_prodotto = this.get_path_documento_digitale_storico(kst_tab_arfa)
								end if
							end if
//--- aggiunge il nome del PDF (cliente+data e numero fattura)
							if len(trim(kst_tab_arfa.file_prodotto)) > 0 then 
								kst_tab_arfa.file_prodotto += "\" + string(kst_tab_arfa.clie_3) + "_" + string(kds_fatture_unica.object.DATA_FATT[1], "yyyymmdd") + "_" & 
												+ string(kds_fatture_unica.object.NUM_FATT[1]) + ".pdf"
							end if
							
						end if
		
//--- Controllo se manca il percorso
						if len(trim(kst_tab_arfa.file_prodotto)) > 0 then 
		
							kst_tab_arfa.num_fatt = kds_fatture_unica.object.NUM_FATT[1]
							kst_tab_arfa.data_fatt = kds_fatture_unica.object.DATA_FATT[1]
					
							if k_n_fatture > 0 then
								
								k_n_fatture_stampate ++
								
//=== Crea il PDF
//								kids_stampa_fattura.Object.DataWindow.Export.PDF.Method = Distill!
//								kids_stampa_fattura.Object.DataWindow.Printer = k_stampante_pdf   
//								kids_stampa_fattura.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
								kids_stampa_fattura.object.DataWindow.Export.PDF.Method = NativePDF!
								k_id_stampa = kids_stampa_fattura.saveas(kst_tab_arfa.file_prodotto,PDF!, false)   //
				
								if k_id_stampa < 1 then
									
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "Fattura elettronica su stampante: '" + k_stampante_pdf + "' non generata: ~n~r"  &
									                                  + "Documento: " + kst_tab_arfa.file_prodotto + " ~n~r" &
									                                  + "Funzione fallita per errore: " + string(k_id_stampa)
									kst_esito.esito = kkg_esito.no_esecuzione
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
								else
		
//--- Le operazioni qui sotto solo SE NON SONO in "Esportazione Documenti" (da codprod)
									if kds_fatture.object.esporta[k_riga] = kki_esporta_documento_si then
									else

//--- Stampa di prova? 
										if kds_fatture_unica.object.diprova[1] = kki_stampa_diProva_si then
											kst_tab_arfa_appo = kst_tab_arfa
											this.get_file_prodotto(kst_tab_arfa_appo)
											if len(trim(kst_tab_arfa_appo.file_prodotto)) = 0 then
												this.set_file_prodotto(kst_tab_arfa)  // se non c'e' nulla aggiorno il campo file_prodotto
											end if
											
										else
										
//--- Stampa Effettiva
											this.set_file_prodotto(kst_tab_arfa)  // se non è di prova aggiorno il campo file_prodotto
										
//--- Copia il file in archivio storico (se non lo ha gia' fatto)							
											kst_tab_arfa_appo = kst_tab_arfa
											kst_tab_arfa_appo.file_prodotto = this.get_path_documento_digitale_storico(kst_tab_arfa)
											if kst_tab_arfa.file_prodotto <> kst_tab_arfa_appo.file_prodotto then
												filecopy(kst_tab_arfa.file_prodotto, kst_tab_arfa_appo.file_prodotto, true)
											end if
			
											if kst_tab_arfa.modo_email <> this.kki_modo_email_no then  // devo creare anche la e-mail o basta il digitale?
	
//--- Aggiorna tabella email_invio prepara agli invii
												kst_tab_arfa.id_email_invio = add_email_invio(kst_tab_arfa)
												if kst_tab_arfa.id_email_invio > 0 then
													set_id_email_invio(kst_tab_arfa)
												end if 
												
											end if 
			
										end if
									end if
									
								end if
							end if
						else
							
							kst_esito.sqlcode = 0
							kst_esito.SQLErrText = "Fattura elettronica non generata: ~n~r" + "Manca il nome della cartella per le fatture, impostarla prima della generazione"
							kst_esito.esito = kkg_esito.no_esecuzione
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
					
					end if
					
				end for
		
			end if		
			
//--- distrugge oggetti x stampa fattura
			produci_fattura_fine()
	
		else
			
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Fattura elettronica non generata: ~n~r" + "Manca la stampante PDF, impostarla tra le Proprietà della Procedura"
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
	catch	(uo_exception kuo1_exception)
			throw kuo1_exception
		

	finally
		if isvalid(kds_fatture_unica) then destroy kds_fatture_unica
//		if isvalid(kuf1_docprod) then destroy kuf1_docprod
		
	end try
		
end if
	



return k_n_fatture_stampate

end function

public function string get_path_documento_digitale_dainviare (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//====================================================================
//=== Torna il Path ROOT di dove registrare il documento (in PDF) se indicato il cliente e il id_fattura ce lo mette !!!!
//=== 
//=== Input : st_tab_arfa con il ID del cliente e della fattura
//=== Out: 
//=== Ritorna: Stringa con il PATH
//=== Lancia Exception
//===   
//====================================================================
string k_return=""
string k_esito =""
st_esito kst_esito
kuf_base kuf1_base


kuf1_base = create kuf_base

k_esito = kuf1_base.prendi_dato_base( "dir_fatt")
if left(k_esito,1) <> "0" then
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
else
	if len(trim(mid(k_esito,2))) > 0 then  // se non c'e' nessun path impostato tra le Proprietà...
	
		if kst_tab_arfa.clie_3 > 0 then
			k_return = trim(mid(k_esito,2)) + "\" + trim(string(kst_tab_arfa.clie_3)) 
			CreateDirectory ( k_return ) // se non c'e' crea la directory
			k_return += "\" + trim(string(kst_tab_arfa.id_fattura))
			CreateDirectory ( k_return ) // se non c'e' crea la directory
			k_return += kki_path_file_prodotto_daInviare
			CreateDirectory ( k_return ) // se non c'e' crea la directory
		else
			k_return	= trim(mid(k_esito,2))
		end if
		
	else
		k_return = ""
	end if
	
end if

destroy kuf1_base
	
return k_return	

end function

public function string get_path_documento_digitale_diprova (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//====================================================================
//=== Torna il Path ROOT di dove registrare il documento (in PDF) se indicato il cliente e il id_fattura ce lo mette !!!!
//=== 
//=== Input : st_tab_arfa con il ID del cliente e della fattura
//=== Out: 
//=== Ritorna: Stringa con il PATH
//=== Lancia Exception
//===   
//====================================================================
string k_return=""
string k_esito =""
st_esito kst_esito
kuf_base kuf1_base


kuf1_base = create kuf_base

k_esito = kuf1_base.prendi_dato_base( "dir_fatt")
if left(k_esito,1) <> "0" then
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
else
	if kst_tab_arfa.clie_3 > 0 then
		k_return = trim(mid(k_esito,2)) + "\" + trim(string(kst_tab_arfa.clie_3)) 
		CreateDirectory ( k_return ) // se non c'e' crea la directory
		k_return += "\" + trim(string(kst_tab_arfa.id_fattura))
		CreateDirectory ( k_return ) // se non c'e' crea la directory
		k_return += kki_path_file_prodotto_diProva
		CreateDirectory ( k_return ) // se non c'e' crea la directory
	else
		k_return	= trim(mid(k_esito,2))
	end if
	
end if

destroy kuf1_base
	
return k_return	

end function

public function string get_path_documento_digitale_storico (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//====================================================================
//=== Torna il Path ROOT di dove registrare il documento (in PDF) se indicato il cliente e il id_fattura ce lo mette !!!!
//=== 
//=== Input : st_tab_arfa con il ID del cliente e della fattura
//=== Out: 
//=== Ritorna: Stringa con il PATH
//=== Lancia Exception
//===   
//====================================================================
string k_return=""
string k_esito =""
st_esito kst_esito
kuf_base kuf1_base


kuf1_base = create kuf_base

k_esito = kuf1_base.prendi_dato_base( "dir_fatt")
if left(k_esito,1) <> "0" then
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
else
	if kst_tab_arfa.clie_3 > 0 then
		k_return = trim(mid(k_esito,2)) + "\" + trim(string(kst_tab_arfa.clie_3)) 
		CreateDirectory ( k_return ) // se non c'e' crea la directory
		k_return += "\" + trim(string(kst_tab_arfa.id_fattura))
		CreateDirectory ( k_return ) // se non c'e' crea la directory
		k_return += kki_path_file_prodotto_storico
		CreateDirectory ( k_return ) // se non c'e' crea la directory
	else
		k_return	= trim(mid(k_esito,2))
	end if
	
end if

destroy kuf1_base
	
return k_return	

end function

public function integer delete_fattura_digitale (st_tab_arfa kst_tab_arfa) throws uo_exception;//---
//--- Cancella la eventuale fatture in digitale (pdf)
//--- input:  st_tab_arfa. file_prodotto 
//--- out: TRUE = cancellata
//--- se ERRORE grave lanca EXCEPTION 
//---
int k_return=0
boolean k_sicurezza = true
long k_max, k_idx
string k_cartella="", k_filename=""
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
datastore kds_dirlist
kuf_file_explorer kuf1_file_explorer



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Rimozione file Fattura Digitale non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

else

	if len(trim(kst_tab_arfa.file_prodotto)) > 0 then
//--- trovo la cartella di registrazione del file
		k_idx = lastPos(kst_tab_arfa.file_prodotto, '\')
		k_cartella = left(kst_tab_arfa.file_prodotto, k_idx)	
				
		kuf1_file_explorer = create kuf_file_explorer
		kds_dirlist = kuf1_file_explorer.DirList(k_cartella+"*.*")
		k_max = kds_dirlist.rowcount( )
		for k_idx = 1 to k_max
//--- estrae il file da cancellare
			k_filename = trim(kds_dirlist.getitemstring(k_idx, "nome"))
			if fileDelete(k_cartella + k_filename) then
				k_return ++ 
			end if
		end for

//--- trovo la cartella di registrazione del file per cancellarla (cancella solo se vuota)
		k_idx = lastPos(kst_tab_arfa.file_prodotto, '\')
		k_cartella = left(kst_tab_arfa.file_prodotto, k_idx - 1)	
		RemoveDirectory (k_cartella)
		
		if isvalid(kds_dirlist) then destroy kds_dirlist
	end if		
	
end if
	



return k_return

end function

public function boolean if_fattura_duplicata (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla se Fattura Duplicata (meglio False)
//---
//---  input: st_tab_arfa.num_fatt e data_fatt e id_fattura
//---  otput: boolean = TRUE fattura duplicata!!!
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_anno, k_ok=0
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_arfa.NUM_FATT > 0 then 

	k_anno = year(kst_tab_arfa.DATA_FATT)

	select distinct 1
	   into :k_ok
	   from  ARFA_testa
       where id_fattura   <>  :kst_tab_arfa.id_fattura 
			 and NUM_FATT =  :kst_tab_arfa.NUM_FATT 
			 and year(DATA_FATT) =  :k_anno
       using sqlca;
	
	if k_ok > 0 and sqlca.sqlcode = 0 then
		k_return = true
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura se Fattura duplicata (arfa_testa) " + string(kst_tab_arfa.NUM_FATT ) + " del " + string(kst_tab_arfa.DATA_FATT ) + "~n~r  " &
										 + "  id " + string(kst_tab_arfa.id_fattura ) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero di Fattura per fare il controllo se duplicata (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function string get_comunicazione () throws uo_exception;//--
//---  Torna la Comunicazione da esporre a piede fattura 
//---
//---  input: --
//---  otput: stringa con st_tab_base.fatt_banca
//--- 			lancia EXCEPTION
//---
string k_rc
st_tab_base kst_tab_base
st_esito kst_esito 
kuf_base kuf1_base
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_base.fatt_comunicazione = " "


kuf1_base = create kuf_base
k_rc = kuf1_base.prendi_dato_base("fatt_comunicazione")
if LeftA(k_rc, 1) = "0" then
	kst_tab_base.fatt_comunicazione = trim(MidA(k_rc, 2)) 
else
	kst_esito.esito =  kkg_esito.db_ko
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Errore durante lettura Archivio Azienda (BASE): " + trim(k_rc) + " id=" + "fatt_comunicazione"
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
end if
				
destroy kuf1_base

return kst_tab_base.fatt_comunicazione

end function

public function boolean get_form_di_stampa (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna il FORM_DI_STAMPA da Tabella ARFA_TESTA
//--- 
//--- 
//--- Inp: st_tab_arfa.id_fattura 
//--- Out: st_tab_arfa.form_di_stampa       
//--- Ritorna: TRUE = OK impostato
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//-----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa.id_fattura > 0 then

	select form_di_stampa
		  into :kst_tab_arfa.form_di_stampa
		from arfa_testa
		WHERE id_fattura = :kst_tab_arfa.id_fattura
		using sqlca;


	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante selezione del 'nome form di stampa' della Fattura ~n~r" &
					+ "Id: " + string(kst_tab_arfa.id_fattura, "####0") + "  " &
					+ " ~n~rErrore-tab.ARFA_TESTA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Fatture, Manca Identificativo (id_fattura) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if len(trim(kst_tab_arfa.form_di_stampa)) > 0 then
	k_return = true
else
	kst_tab_arfa.form_di_stampa = ki_dw_stampa_fattura
end if

return k_return

end function

public function boolean set_form_di_stampa (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a FORM_DI_STAMPA in Tabella ARFA_TESTA
//--- 
//--- 
//--- Inp: st_tab_arfa.id_fattura  e  form_di_stampa
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa.id_fattura > 0 then

	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE ARFA_TESTA  
		  SET form_di_stampa = :kst_tab_arfa.form_di_stampa
			,x_datins = :kst_tab_arfa.x_datins
			,x_utente = :kst_tab_arfa.x_utente
		WHERE ARFA_TESTA.id_fattura = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'nome form di stampa' della Fattura. ~n~r" &
					+ "Id: " + string(kst_tab_arfa.id_fattura, "####0") + "  " &
					+ " ~n~rErrore-tab.ARFA_TESTA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Fatture, Manca Identificativo (id_fattura) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public subroutine produci_fattura_inizializza (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//
int k_rc=0


	if NOT isvalid(kids_stampa_fattura) then 
		
		produci_fattura_inizio( )

	end if
	
	if len(trim(kids_stampa_fattura.dataobject)) = 0 then
		
//--- Imposta il Form di stampa 
		if kst_tab_arfa.id_fattura = 0 then
			kids_stampa_fattura.dataobject = ki_dw_stampa_fattura
		else
			get_form_di_stampa(kst_tab_arfa) 
			kids_stampa_fattura.dataobject = trim(kst_tab_arfa.form_di_stampa) 
		end if

//	kids_stampa_fattura.dataobject = ki_dw_stampa_fattura

		k_rc=kids_stampa_fattura.SetTransObject(SQLCA)
		kids_stampa_fattura.reset()

//--- imposta i loghi in fattura
		produci_fattura_set_dw_loghi(kids_stampa_fattura)

	end if
end subroutine

public subroutine produci_fattura_inizio () throws uo_exception;//

	kids_stampa_fattura = create datastore
//	kids_stampa_fattura.Object.DataWindow.ReadOnly='Yes'


end subroutine

public function boolean set_flag_stampa (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a FORM_DI_STAMPA in Tabella ARFA_TESTA
//--- 
//--- 
//--- Inp: st_tab_arfa.id_fattura  e  form_di_stampa
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa.id_fattura > 0 then

	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()

	update ARFA_TESTA
		  set STAMPA = 'S'
			  ,data_stampa = :kg_dataoggi
			 ,x_datins = :kst_tab_arfa.x_datins
			 ,x_utente = :kst_tab_arfa.x_utente
		WHERE id_fattura = :kst_tab_arfa.id_fattura
			using sqlca;
		
	if sqlca.sqlcode >= 0 then
		update ARFA
				  set STAMPA           = 'S'
				,x_datins = :kst_tab_arfa.x_datins
				,x_utente = :kst_tab_arfa.x_utente
			WHERE id_fattura = :kst_tab_arfa.id_fattura
				using sqlca;
	end if
				
	if sqlca.sqlcode >= 0 then
		update ARFA_V
			  set STAMPA           = 'S'
				,x_datins = :kst_tab_arfa.x_datins
				,x_utente = :kst_tab_arfa.x_utente
			WHERE id_fattura = :kst_tab_arfa.id_fattura
				using sqlca;
	end if
					
	if sqlca.sqlcode < 0 then
		
		kGuf_data_base.db_rollback_1()
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
				"Errore durante aggiornam. indicatore di Fattura 'stampata' ~n~r" &
			+ "Id.: "+  string(kst_tab_arfa.id_fattura, "####0") + "  " &
			+ " ~n~rErrore-tab.ARFA, ecc....:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore Aggiornamento Fattura, Manca Identificativo (id_fattura) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function integer produci_fattura_aggiorna (ref st_tab_arfa kst_tab_arfa[]) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna Fattura a fine stampa ad esempio:
//---       il flag di "STAMPA" sulle fatture
//---       alimenta il DOCPROD
//---
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
//--- lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------------------------------
int k_ctr=0, k_n_fatture=0
long k_riga_fatture=0, k_nr_fatt_inp=0
st_tab_docprod  kst_tab_docprod
st_esito kst_esito 
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	k_nr_fatt_inp = upperbound(kst_tab_arfa[])
	if k_nr_fatt_inp > 0 then
		
		for k_riga_fatture = 1 to k_nr_fatt_inp
	
			if kst_tab_arfa[k_riga_fatture].num_fatt > 0 then
				
	
//--- se il documento non ha ancora il 'form_di_stampa' lo aggiorna
				if NOT get_form_di_stampa(kst_tab_arfa[k_riga_fatture]) then
					kst_tab_arfa[k_riga_fatture].form_di_stampa = ki_dw_stampa_fattura
					kst_tab_arfa[k_riga_fatture].st_tab_g_0.esegui_commit = "N"
					set_form_di_stampa(kst_tab_arfa[k_riga_fatture])
				end if
				

//--- Setta iol FLAG STAMPA
				set_flag_stampa(kst_tab_arfa[k_riga_fatture])
				
				
			end if
											  
			k_n_fatture++

//---
		next

//--- COMMIT se tutto ok altrimenti ROLLBACK
		if kst_esito.esito <> kkg_esito.db_ko then
			kst_esito = kGuf_data_base.db_commit_1()
		else
			kGuf_data_base.db_rollback_1()
		end if
		if kst_esito.esito <> kkg_esito.ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if


//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
		try 
			
			if upperbound(kst_tab_arfa[]) > 0 then
				kst_tab_arfa[1].st_tab_g_0.esegui_commit = "S"
				aggiorna_docprod(kst_tab_arfa[])
			end if
			
		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )
			kst_esito.sqlerrtext = "Archivi Fatture Aggiornati Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)
			
		finally
		
		end try
				

//--- COMMIT se tutto ok altrimenti ROLLBACK
		if kst_esito.esito <> kkg_esito.db_ko then
			kst_esito = kGuf_data_base.db_commit_1()
			kst_esito.sqlerrtext = "Archivi Fatture Aggiornati Correttamente !  Ma si è verificata la seguente anonalia: ~n~r" + trim(kst_esito.sqlerrtext)
		else
			kGuf_data_base.db_rollback_1()
		end if
		if kst_esito.esito <> kkg_esito.ok then
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito)
			throw kuo_exception
		end if

	
	end if



return k_n_fatture

end function

public function long aggiorna_docprod (ref st_tab_arfa kst_tab_arfa[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_ta_arfa con l'elenco delle fatture da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_fatture=0, k_nr_fatt=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_fatt = upperbound(kst_tab_arfa[])

	if k_nr_fatt > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		for k_riga_fatture = 1 to k_nr_fatt

			try

				if kst_tab_arfa[k_riga_fatture].id_fattura > 0 then
	
					kst_tab_docprod.doc_num = kst_tab_arfa[k_riga_fatture].num_fatt
					kst_tab_docprod.doc_data = kst_tab_arfa[k_riga_fatture].data_fatt 
					kst_tab_docprod.id_doc = kst_tab_arfa[k_riga_fatture].id_fattura
					
					
					kst_esito = get_cliente(kst_tab_arfa[k_riga_fatture])
					if kst_esito.esito = kkg_esito.db_ko then
						if isvalid(kuf1_docprod) then destroy kuf1_docprod
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					
					kst_tab_docprod.id_cliente = kst_tab_arfa[k_riga_fatture].clie_3
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_arfa[1].st_tab_g_0.esegui_commit
	
					kuf1_docprod.tb_add_fattura ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
					k_nr_doc++
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
	
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function boolean set_id_docprod (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a ID del Documento Esportato in Tabella ARFA_TESTA
//--- 
//--- 
//--- Inp: st_tab_arfa.id_fattura  e  id_docprod
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa.id_fattura > 0 then

	kst_tab_arfa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE ARFA_TESTA  
		  SET id_docprod = :kst_tab_arfa.id_docprod
			,x_datins = :kst_tab_arfa.x_datins
			,x_utente = :kst_tab_arfa.x_utente
		WHERE ARFA_TESTA.id_fattura = :kst_tab_arfa.id_fattura
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documento Emesso' in  Fattura. ~n~r" &
					+ "Id: " + string(kst_tab_arfa.id_fattura, "####0") + "  " &
					+ " ~n~rErrore-tab.ARFA_TESTA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Fatture, Manca Identificativo (id_fattura) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function st_esito get_totali (ref st_tab_arfa ast_tab_arfa, ref st_fattura_totali ast_fattura_totali);//--
//---  Torna i Totali Fattura (Imponibili + IVA + eccc...) della Fattura indicata x metterli in stampa
//--- input: st_tab_arfa con estremi fattura
//--- out: st_fattura_totali tutta valorizzata
//---
int k_ind=0
long k_III_decimale=0
long k_imposta_long_1, k_imposta_long_2, k_imposta_long_3, k_imposta_long_4, k_imposta_long_5, k_imposta_long_x
char k_f_splitpayment_1, k_f_splitpayment_2, k_f_splitpayment_3, k_f_splitpayment_4, k_f_splitpayment_5
decimal k_decimal
st_esito kst_esito 
st_tab_iva kst_tab_iva
st_fattura_totali kst_fattura_totali_NULL
kuf_ausiliari kuf1_ausiliari



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- toglie i null
ast_fattura_totali = kst_fattura_totali_NULL //---- inizializza l'area
if_isnull_totali(ast_fattura_totali)

ast_fattura_totali.totale = 0

if ast_tab_arfa.id_fattura = 0 or isnull(ast_tab_arfa.id_fattura) then 

	if ast_tab_arfa.NUM_FATT > 0 then 
		kst_esito = this.get_id(ast_tab_arfa)
	end if
	
end if

if ast_tab_arfa.id_fattura > 0 and kst_esito.esito = kkg_esito.ok then

	declare get_totali_c1 cursor for
               select 
                          IVA,
                          sum(PREZZO_T)
                     from  v_arfa_tot_imponibili 
                     where id_fattura   = :ast_tab_arfa.id_fattura
				group by iva
				order by iva
			 using sqlca;

									
//--- ciclo lettura totali imponibili
	open get_totali_c1;
	if sqlca.sqlcode = 0 then

		fetch get_totali_c1 into
			:ast_tab_arfa.iva
			,:ast_tab_arfa.prezzo_t;

		kuf1_ausiliari = create kuf_ausiliari

		k_imposta_long_1 = 0
		k_imposta_long_2 = 0
		k_imposta_long_3 = 0
		k_imposta_long_4 = 0
		k_imposta_long_5 = 0

		do while sqlca.sqlcode = 0 and k_ind < 5

			k_ind++

			if ast_tab_arfa.iva > 0 then
				kst_tab_iva.codice = ast_tab_arfa.iva
				kuf1_ausiliari.tb_select( kst_tab_iva )
			else
				kst_tab_iva.aliq = 0
			end if
			
////--- Calcola totale GENERALE da imponibile + IVA
//			if ast_tab_arfa.prezzo_t <> 0 and not isnull(kist_tab_arfa.prezzo_t) then
//				ast_fattura_totali.totale += ast_tab_arfa.prezzo_t
//				if kst_tab_iva.aliq > 0 then
//					ast_fattura_totali.totale += Round(ast_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100),2)
//				end if
//			end if
			
//--- Imponibili+IVA
			choose case k_ind
				case 1
					k_f_splitpayment_1 = kst_tab_iva.f_splitpayment
					ast_fattura_totali.cod_1 =  kst_tab_iva.codice 
					ast_fattura_totali.imponibile_1 = ast_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						ast_fattura_totali.iva_1 =  kst_tab_iva.aliq 
//						ast_fattura_totali.imposta_1 =  (ast_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100))
						k_decimal = (ast_tab_arfa.prezzo_t * 100 * (kst_tab_iva.aliq) )  // / 100)) // determinante x evitare il BUG di PB durante il calcolo IVA 
						k_imposta_long_1 = k_decimal 
						k_imposta_long_1 = k_imposta_long_1 / 10
						ast_fattura_totali.iva_des_1 =  kst_tab_iva.des 
					else
						ast_fattura_totali.iva_1 =  0 
						ast_fattura_totali.imposta_1 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							ast_fattura_totali.iva_des_1 =  trim(kst_tab_iva.des)
						else
							ast_fattura_totali.iva_des_1 =  " "
						end if
					end if
				case 2
					k_f_splitpayment_2 = kst_tab_iva.f_splitpayment
					ast_fattura_totali.cod_2 =  kst_tab_iva.codice 
					ast_fattura_totali.imponibile_2 = ast_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						ast_fattura_totali.iva_2 =  kst_tab_iva.aliq 
//						ast_fattura_totali.imposta_2 = (ast_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100))
						k_decimal = (ast_tab_arfa.prezzo_t * 100 * (kst_tab_iva.aliq)) // / 100)) // determinante x evitare il BUG di PB durante il calcolo IVA 
						k_imposta_long_2 = k_decimal  //* 1000
						k_imposta_long_2 = k_imposta_long_2 / 10
						ast_fattura_totali.iva_des_2 =  kst_tab_iva.des 
					else
						ast_fattura_totali.iva_2 =  0 
						ast_fattura_totali.imposta_2 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							ast_fattura_totali.iva_des_2 =  trim(kst_tab_iva.des)
						else
							ast_fattura_totali.iva_des_2 =  " "
						end if
					end if
				case 3
					k_f_splitpayment_3 = kst_tab_iva.f_splitpayment
					ast_fattura_totali.cod_3 =  kst_tab_iva.codice 
					ast_fattura_totali.imponibile_3 = ast_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						ast_fattura_totali.iva_3 =  kst_tab_iva.aliq 
//						ast_fattura_totali.imposta_3 =  (ast_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100))
						k_decimal = (ast_tab_arfa.prezzo_t * 100 * (kst_tab_iva.aliq)) // / 100)) // determinante x evitare il BUG di PB durante il calcolo IVA 
						k_imposta_long_3 = k_decimal //* 1000
						k_imposta_long_3 = k_imposta_long_3 / 10
						ast_fattura_totali.iva_des_3 =  kst_tab_iva.des 
					else
						ast_fattura_totali.iva_3 =  0 
						ast_fattura_totali.imposta_3 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							ast_fattura_totali.iva_des_3 =  trim(kst_tab_iva.des)
						else
							ast_fattura_totali.iva_des_3 =  " "
						end if
					end if
				case 4
					k_f_splitpayment_4 = kst_tab_iva.f_splitpayment
					ast_fattura_totali.cod_4 =  kst_tab_iva.codice 
					ast_fattura_totali.imponibile_4 = ast_tab_arfa.prezzo_t
					if kst_tab_iva.aliq > 0 then
						ast_fattura_totali.iva_4 =  kst_tab_iva.aliq 
//						ast_fattura_totali.imposta_4 =  (ast_tab_arfa.prezzo_t * (kst_tab_iva.aliq / 100))
						k_decimal = (ast_tab_arfa.prezzo_t * 100 * (kst_tab_iva.aliq)) // / 100)) // determinante x evitare il BUG di PB durante il calcolo IVA 
						k_imposta_long_4 = k_decimal //* 1000
						k_imposta_long_4 = k_imposta_long_4 / 10
						ast_fattura_totali.iva_des_4 =  kst_tab_iva.des 
					else
						ast_fattura_totali.iva_4 =  0 
						ast_fattura_totali.imposta_4 =  0
						if len(trim(kst_tab_iva.des)) > 0 then 
							ast_fattura_totali.iva_des_4 =  trim(kst_tab_iva.des)
						else
							ast_fattura_totali.iva_des_4 =  " "
						end if
					end if
				case else
					if kst_tab_iva.aliq > 0 then
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Calcolo Totali Fattura n. " + string(ast_tab_arfa.NUM_FATT )  &
						                                +  " del " + string(ast_tab_arfa.DATA_FATT )  + " (arfa get-totali): Attenzione Troppi Cod.IVA diversi.  "
						kst_esito.esito = kkg_esito.err_logico
					end if
			end choose

			

			fetch get_totali_c1 into
				:ast_tab_arfa.iva
				,:ast_tab_arfa.prezzo_t;
		loop

		destroy kuf1_ausiliari

	 	close get_totali_c1;
	end if
	
//---- meglio arrotondare al secondo decimale (,005 o ,0047 diventa ,01) il 'ROUND' è sbagliato!!!! o meglio la MEMORIA fa' casini su alcune divisioni
	if k_imposta_long_1 <> 0 then 
		k_imposta_long_x = long(k_imposta_long_1 / 10) * 10  // sostituisce il terzo decimale con uno zero
		k_III_decimale = k_imposta_long_1 - k_imposta_long_x // isola solo il terzo decimale
		k_imposta_long_1 = k_imposta_long_1 / 10 // storna il terzo decimale poichè m'interessano solo 2 decimali nell'imposta in EURO
		if k_III_decimale < 5 then // il terzo deimale isolato minore di 5 allora NON arrotonda un fico secco
			ast_fattura_totali.imposta_1 =  k_imposta_long_1 / 100  // nessun arrot
		else
			ast_fattura_totali.imposta_1 =  k_imposta_long_1 / 100 + 0.01   // arrot. verso l'alto
		end if
		if k_f_splitpayment_1 = "S" then
			ast_fattura_totali.imp_splitpayment = ast_fattura_totali.imposta_1
		end if
	end if
	if k_imposta_long_2 <> 0 then 
		k_imposta_long_x = long(k_imposta_long_2 / 10) * 10  
		k_III_decimale = k_imposta_long_2 - k_imposta_long_x
		k_imposta_long_2 = k_imposta_long_2 / 10 // storna il terzo decimale poichè m'interessano solo 2 decimali nell'imposta in EURO
		if k_III_decimale < 5 then
			ast_fattura_totali.imposta_2 =  k_imposta_long_2 / 100  // nessun arrot
		else
			ast_fattura_totali.imposta_2 =  k_imposta_long_2 / 100 + 0.01   // arrot. verso l'alto
		end if
		if k_f_splitpayment_2 = "S" then
			ast_fattura_totali.imp_splitpayment += ast_fattura_totali.imposta_2
		end if
	end if
	if k_imposta_long_3 <> 0 then 
		k_imposta_long_x = long(k_imposta_long_3 / 10) * 10  
		k_III_decimale = k_imposta_long_3 - k_imposta_long_x
		k_imposta_long_3 = k_imposta_long_3 / 10 // storna il terzo decimale poichè m'interessano solo 2 decimali nell'imposta in EURO
		if k_III_decimale < 5 then
			ast_fattura_totali.imposta_3 =  k_imposta_long_3 / 100  // nessun arrot
		else
			ast_fattura_totali.imposta_3 =  k_imposta_long_3 / 100 + 0.01   // arrot. verso l'alto
		end if
		if k_f_splitpayment_3 = "S" then
			ast_fattura_totali.imp_splitpayment += ast_fattura_totali.imposta_3
		end if
	end if
	if k_imposta_long_4 <> 0 then 
		k_imposta_long_x = long(k_imposta_long_4 / 10) * 10  
		k_III_decimale = k_imposta_long_4 - k_imposta_long_x
		k_imposta_long_4 = k_imposta_long_4 / 10 // storna il terzo decimale poichè m'interessano solo 2 decimali nell'imposta in EURO
		if k_III_decimale < 5 then
			ast_fattura_totali.imposta_4 =  k_imposta_long_4 / 100  // nessun arrot
		else
			ast_fattura_totali.imposta_4 =  k_imposta_long_4 / 100 + 0.01   // arrot. verso l'alto
		end if
		if k_f_splitpayment_4 = "S" then
			ast_fattura_totali.imp_splitpayment += ast_fattura_totali.imposta_4
		end if
	end if
	if k_imposta_long_5 <> 0 then 
		k_imposta_long_x = long(k_imposta_long_5 / 10) * 10  
		k_III_decimale = k_imposta_long_5 - k_imposta_long_x
		k_imposta_long_5 = k_imposta_long_5 / 10 // storna il terzo decimale poichè m'interessano solo 2 decimali nell'imposta in EURO
		if k_III_decimale < 5 then
			ast_fattura_totali.imposta_5 =  k_imposta_long_5 / 100  // nessun arrot
		else
			ast_fattura_totali.imposta_5 =  k_imposta_long_5 / 100 + 0.01   // arrot. verso l'alto
		end if
		if k_f_splitpayment_5 = "S" then
			ast_fattura_totali.imp_splitpayment += ast_fattura_totali.imposta_5
		end if
	end if
//	if ast_fattura_totali.imposta_1 > 0 then ast_fattura_totali.imposta_1 =  Round((k_imposta_long_1/1000),2)
//	if ast_fattura_totali.imposta_2 > 0 then ast_fattura_totali.imposta_2 =  Round((long(ast_fattura_totali.imposta_2 * 1000) / 1000),2)
//	if ast_fattura_totali.imposta_3 > 0 then ast_fattura_totali.imposta_3 =  Round((long(ast_fattura_totali.imposta_3 * 1000) / 1000),2)
//	if ast_fattura_totali.imposta_4 > 0 then ast_fattura_totali.imposta_4 =  Round((long(ast_fattura_totali.imposta_4 * 1000) / 1000),2)
//	if ast_fattura_totali.imposta_5 > 0 then ast_fattura_totali.imposta_5 =  Round((long(ast_fattura_totali.imposta_5 * 1000) / 1000),2)

//--- Calcola totale GENERALE da imponibile + IVA
	ast_fattura_totali.totale = ast_fattura_totali.imposta_1 + ast_fattura_totali.imposta_2 + ast_fattura_totali.imposta_3 + ast_fattura_totali.imposta_4 + ast_fattura_totali.imposta_5 &
									+ ast_fattura_totali.imponibile_1 + ast_fattura_totali.imponibile_2 + ast_fattura_totali.imponibile_3 + ast_fattura_totali.imponibile_4 + ast_fattura_totali.imponibile_5

	if k_ind = 0 then
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura  n. " + string(ast_tab_arfa.NUM_FATT ) + " del " + string(ast_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Calcolo Totali Fattura n. " + string(ast_tab_arfa.NUM_FATT ) + " del " + string(ast_tab_arfa.DATA_FATT ) + " (arfa) " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Calcolo Totali Fattura  (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito
end function

public function long get_id_da_id_armo (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna il ID della Fattura da ID_ARMO 
//--- 
//---  torna: long del ID_FATTURA, 0=non trovato
//---  input: st_tab_arfa.id_armo
//---  otput: st_tab_arfa.id_fattura
//---
//--- Lancia uo_exception  x errore
//---
long k_return=0
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_armo > 0 then 
	
   select max(id_fattura)
	   into :kst_tab_arfa.id_fattura
	   from  ARFA
       where id_armo   =  :kst_tab_arfa.id_armo 
       using kguo_sqlca_db_magazzino;
		 
	
	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Ricerca della fattura per id riga lotto n. " + string(kst_tab_arfa.id_armo ) + "  (arfa)  ~n~r" &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

	if isnull(kst_tab_arfa.id_fattura) then
		kst_tab_arfa.id_fattura = 0
	end if
	k_return = kst_tab_arfa.id_fattura
end if


return k_return

end function

public function long get_cod_pag (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Torna il COD_PAG della Fattura da ID_FATTURA
//--- 
//---  torna: long del COD_PAG, 0=non trovato
//---  input: st_tab_arfa.id_fattura
//---  otput: st_tab_arfa.COD_PAG
//---
//--- Lancia uo_exception  x errore
//---
long k_return=0
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_fattura > 0 then 
	
   select distinct(COD_PAG)
	   into :kst_tab_arfa.COD_PAG
	   from  ARFA_testa
       where id_fattura   =  :kst_tab_arfa.id_fattura 
       using kguo_sqlca_db_magazzino;
		 
	
	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Ricerca del Cod.Pagamento in fattura, per ID n. " + string(kst_tab_arfa.id_fattura ) + "  (arfa_testa)  ~n~r" &
									 + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

	if isnull(kst_tab_arfa.COD_PAG) then
		kst_tab_arfa.COD_PAG = 0
	end if
	k_return = kst_tab_arfa.COD_PAG
end if


return k_return

end function

public function boolean if_esiste_id_armo_prezzo (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla se Riga Prezzo del Lotto e' stato Fatturato
//---
//---  input: st_tab_arfa.id_armo_prezzo
//---  otput: boolean = TRUE fatturato
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_arfa.clie_3 = 0

if kst_tab_arfa.id_armo_prezzo > 0 then 
	
   select distinct 1
	   into :kst_tab_arfa.clie_3
	   from  ARFA
       where id_armo_prezzo   =  :kst_tab_arfa.id_armo_prezzo 
       using kguo_sqlca_db_magazzino ;
	
	if kst_tab_arfa.clie_3 > 0 then
		k_return = true
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Riga Prezzo Lotto in Fattura (arfa) id:" + string(kst_tab_arfa.id_armo_prezzo) + "~n~r  " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id della Riga prezzo Lotto per leggere su archivio Fatture (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function st_esito tb_delete_x_rif () throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella ARFA (Fatture) con i dati del Riferimento
//=== 
//=== Inp.: kist_tab_arfa.id_armo
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===                : 3=INFORMAZIONE 
//=== 
//====================================================================
//
long k_ctr, k_righe, k_riga
boolean k_return, k_flag_fattura_vuota
st_tab_prof kst_tab_prof
st_esito kst_esito, kst_esito1, kst_esito2, kst_esito3
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_ricevute kuf1_ricevute
datastore kds_arfa_x_id_armo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_fatture

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Documento di Vendita non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

try

	kds_arfa_x_id_armo = create datastore
	kds_arfa_x_id_armo.dataobject ="ds_arfa_x_id_armo"
	kds_arfa_x_id_armo.settransobject(kguo_sqlca_db_magazzino )
	k_righe = kds_arfa_x_id_armo.retrieve(kist_tab_arfa.id_armo )
	

	kuf1_ricevute = create kuf_ricevute

	kist_tab_arfa.id_fattura = 0
	for k_riga = 1 to k_righe
		
		kist_tab_arfa.num_fatt = kds_arfa_x_id_armo.getitemnumber(k_riga, "num_fatt")
		kist_tab_arfa.data_fatt = kds_arfa_x_id_armo.getitemdate(k_riga, "data_fatt")
		kist_tab_arfa.id_arfa = kds_arfa_x_id_armo.getitemnumber(k_riga, "id_arfa")

//--- faccio queste verifiche / cancellazioni solo  a rottura di id_fattura
		if kist_tab_arfa.id_fattura <> kds_arfa_x_id_armo.getitemnumber(k_riga, "id_fattura") then
			kist_tab_arfa.id_fattura = kds_arfa_x_id_armo.getitemnumber(k_riga, "id_fattura")

//--- controllo se ci sono righe varie in fattura
			select count (num_fatt)   
				 into :k_ctr 
				 from arfa_v
				 WHERE num_fatt = :kist_tab_arfa.num_fatt
						 and data_fatt = :kist_tab_arfa.data_fatt
				 using sqlca;
	
			if sqlca.sqlcode = 0 and k_ctr > 0 then			 
				kst_esito1.sqlcode = 0
				kst_esito1.SQLErrText = trim(kst_esito1.SQLErrText) &
						+ "La fattura conteneva delle righe Varie che sono state eliminate. Fatt. nr." &
						+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
				kst_esito1.esito = kkg_esito.ok
				
//--- se tutto ok cancella anche le righe varie
				delete from arfa_v
					WHERE num_fatt = :kist_tab_arfa.num_fatt
						and data_fatt = :kist_tab_arfa.data_fatt;
			end if

//--- ci sono righe diverse oltre a quelle del riferimento?
			kst_esito3 = tb_fattura_no_id_meca()
			if kst_esito3.esito = kkg_esito.ok then
				k_flag_fattura_vuota = false
			else
				k_flag_fattura_vuota = true
			end if			

//--- controllo se ci sono righe del PROFIS gia' contabilizzate
			select count (num_fatt)   
				 into :k_ctr 
				 from prof
				 WHERE num_fatt = :kist_tab_arfa.num_fatt
						 and data_fatt = :kist_tab_arfa.data_fatt
						 and profis = 'S'
				 using sqlca;
			if sqlca.sqlcode = 0 and k_ctr > 0 then			 
				kst_esito1.sqlcode = 0
				kst_esito1.SQLErrText =  &
						+ "Fattura già in contabilita', prego controllare n." &
						+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
						+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" 
				kst_esito1.esito = kkg_esito.no_esecuzione
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito1)
				throw kguo_exception
			end if
	
//--- controllo se ci sono righe RIBA gia' presentate
			kuf1_ricevute.kist_tab_ricevute.num_fatt = kist_tab_arfa.num_fatt
				kuf1_ricevute.kist_tab_ricevute.data_fatt = kist_tab_arfa.data_fatt
			kst_esito2 = kuf1_ricevute.ric_gia_presentate()
			if kst_esito2.esito = kkg_esito.ok then
				kst_esito1.SQLErrText =  &
							+ "Fattura con Effetti già presentati alla Banca, prego controllare n." &
					+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r"  + kst_esito2.SQLErrText
				kst_esito1.esito = kkg_esito.no_esecuzione
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito1)
				throw kguo_exception
			end if
			if kst_esito2.esito = kkg_esito.not_fnd  then
				if k_flag_fattura_vuota then
//--- cancella righe EFFETTI
					kst_esito2 = kuf1_ricevute.tb_delete_x_fatt( kuf1_ricevute.kist_tab_ricevute)
					if kst_esito2.esito = kkg_esito.db_ko then
						kst_esito1.SQLErrText =  &
									+ "Errore in Cancellaz. Effetti Fattura, prego controllare n." &
									+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
									+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") + "~n~r" &
									+ trim(kst_esito2.SQLErrText)
						kst_esito1.esito =  kst_esito2.esito
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito1)
						throw kguo_exception
					end if
				end if
			end if
			
		end if		

//--- Cancella eventuali righe dettaglio correlate
		tb_delete_ripristina_correlati(kist_tab_arfa)

	end for


	if kst_esito1.esito <> kkg_esito.ok  then

						
//--- se tutto ok cancella anche le righe
		delete from arfa
				WHERE num_fatt = :kist_tab_arfa.num_fatt
						and data_fatt = :kist_tab_arfa.data_fatt;
			
		if sqlca.sqlcode = 0 then
			
//--- se tutto ok cancella anche le altre tabelle
			delete from fat1
					WHERE num_fatt = :kist_tab_arfa.num_fatt
							and data_fatt = :kist_tab_arfa.data_fatt;
			
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
	"Errore durante la cancellazione della Fattura ~n~r" &
					+ string(kist_tab_arfa.num_fatt, "####0") + " del " &
					+ string(kist_tab_arfa.data_fatt, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.ARFA:"	+ trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito1)
					throw kguo_exception
				end if
			end if
		end if
	end if


finally
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kist_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kist_tab_arfa.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_arfa.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


end try


return kst_esito

end function

public function boolean if_chiuso (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla se Documento gia' CHIUSO 
//---
//---  input: st_tab_arfa.id_fattura
//---  otput: boolean   TRUE = chiuso
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
string k_profis
st_esito kst_esito 
date k_datameno3mesi , k_data_fattura

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_arfa.id_fattura > 0 then 

	k_datameno3mesi = kguo_g.get_dataoggi()
	k_datameno3mesi = relativedate(k_datameno3mesi, -90)
	

	select distinct arfa_testa.DATA_FATT 
					,prof.profis 
		into :k_data_fattura, :k_profis 
	   from  ARFA_testa left outer join prof on
		              arfa_testa.id_fattura = prof.id_fattura 
       where arfa_testa.id_fattura   =  :kst_tab_arfa.id_fattura 
       using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if k_data_fattura < k_datameno3mesi or k_profis = "S" then

			k_return = true   // CHIUSA!!!
			
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Verifica se Fattura 'consolidato' (arfa_testa) id=" + string(kst_tab_arfa.id_fattura ) + "~n~r  " &
										 + "  id " + string(kst_tab_arfa.id_fattura ) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca ID Fattura per fare il controllo se 'Chiuso' (arfa_testa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public function boolean if_modifica_chiuso () throws uo_exception;//--
//---  Consentire a utente di Modificare Documento gia' CHIUSO 
//---
//---  input: 
//---  otput: boolean   TRUE = utrente autorizzato
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
kuf_fatt_forza_mod kuf1_fatt_forza_mod
st_esito kst_esito 

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf1_fatt_forza_mod = create kuf_fatt_forza_mod

try 
	
	k_return = kuf1_fatt_forza_mod.if_sicurezza(kkg_flag_modalita.modifica )


catch (uo_exception kuo_exception)
	throw kuo_exception

end try



return k_return

end function

public function boolean get_colli_x_id_armo_prezzo (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Calcolo Colli fatturati x id_armo_prezzo 
//---
//---  input: st_tab_arfa.id_armo_prezzo id_armo 
//---  otput: st_tab_arfa.colli
//---  ret:  true = trovato
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_armo_prezzo > 0 then

   	select  sum(colli)
	   into :kst_tab_arfa.colli
	   from  ARFA
       where id_armo  = : kst_tab_arfa.id_armo
		       and id_armo_prezzo  = : kst_tab_arfa.id_armo_prezzo
       using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura colli Fatturati (arfa) id riga lotto: " + string(kst_tab_arfa.id_armo ) + " id riga prezzo " + string(kst_tab_arfa.id_armo_prezzo ) + "~n~r  " &
									 + trim(SQLCA.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			kst_tab_arfa.colli = 0
		else	
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	else
		k_return = true
		if isnull(kst_tab_arfa.colli) then kst_tab_arfa.colli = 0
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id riga lotto prezzi per leggere la Fattura (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if

return k_return 


end function

public function boolean if_cancella (st_tab_arfa ast_tab_arfa) throws uo_exception;//--
//---  Consentire a la cancellazione del Documento? 
//---
//---  input: st_tab_arfa.id_fattura
//---  otput: boolean   TRUE = utente autorizzato
//---  se ERRORE lancia un Exception
//---

boolean k_return = false


try 

	
//--- autorizzato alla cancellazione?
	if not if_sicurezza(kkg_flag_modalita.cancellazione) then 
		throw kguo_exception
	end if

//--- controlla se documento chiuso
	if if_chiuso(ast_tab_arfa) then
		if if_modifica_chiuso() then
			kguo_exception.inizializza()
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
			kguo_exception.setmessage(  &
			"Attenzione, il Documento e' ga' Consolidato. Utente Autorizzato alla Cancellazione. ~n~r" + &
			"(ID Documento cercato:" + string(ast_tab_arfa.id_fattura) + ") " )
		else
			kguo_exception.inizializza()
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_noaut )
			kguo_exception.setmessage(  &
			"Mi spiace, il Documento e' ga' Consolidato. Utente non autorizzato alla Cancellazione. ~n~r" + &
			"(ID Documento cercato:" + string(ast_tab_arfa.id_fattura) + ") " )
			throw kguo_exception
		end if
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try



return k_return

end function

public function boolean if_modifica (st_tab_arfa ast_tab_arfa) throws uo_exception;//--
//---  Consentire a la cancellazione del Documento? 
//---
//---  input: st_tab_arfa.id_fattura
//---  otput: boolean   TRUE = utente autorizzato
//---  se ERRORE lancia un Exception
//---

boolean k_return = false


try 

	
//--- autorizzato alla cancellazione?
	if not if_sicurezza(kkg_flag_modalita.modifica) then 
		throw kguo_exception
	end if

//--- controlla se documento chiuso
	if if_chiuso(ast_tab_arfa) then
		if if_modifica_chiuso() then
			kguo_exception.inizializza()
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
			kguo_exception.setmessage(  &
			"Attenzione, il Documento e' ga' Consolidato. Utente Autorizzato alla Modifica. ~n~r" + &
			"(ID Documento cercato:" + string(ast_tab_arfa.id_fattura) + ") " )
		else
			kguo_exception.inizializza()
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_noaut )
			kguo_exception.setmessage(  &
			"Mi spiace, il Documento e' ga' Consolidato. Utente non autorizzato alla Modifica. ~n~r" + &
			"(ID Documento cercato:" + string(ast_tab_arfa.id_fattura) + ") " )
			throw kguo_exception
		end if
	end if
	
	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try



return k_return

end function

public function string get_stampa_tradotta (st_tab_arfa kst_tab_arfa) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------
//--- Torna il dato STAMPA_TRADOTTA es. EN=INGLESE, IT=ITALIANO .... da Tabella ARFA_TESTA
//--- 
//--- 
//--- Inp: st_tab_arfa.id_fattura 
//--- Out: -      
//--- Ritorna: Valore STAMPA_TRADOTTA
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//-----------------------------------------------------------------------------------------------------------------------
//
string k_return = ""
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa.id_fattura > 0 then

	select STAMPA_TRADOTTA
		  into :kst_tab_arfa.STAMPA_TRADOTTA
		from arfa_testa
		WHERE id_fattura = :kst_tab_arfa.id_fattura
		using sqlca;


	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante selezione della 'lingua' di stampa della Fattura ~n~r" &
					+ "Id: " + string(kst_tab_arfa.id_fattura, "####0") + "  " &
					+ " ~n~rErrore-tab.ARFA_TESTA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore reperimento 'lingua' della Fattura, Manca Identificativo (id_fattura) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if len(trim(kst_tab_arfa.STAMPA_TRADOTTA)) > 0 then
	k_return = kst_tab_arfa.STAMPA_TRADOTTA
else
	k_return = "IT"
end if

return k_return

end function

public function string get_tipo_documento_descrizione (st_tab_arfa ast_tab_arfa);//--
//---  Torna descrizione del campo Tipo Documento  (es se NC="nota di credito", se FT="fattura", se PF="proforma", ecc...)
//---  torna vuoto ("") se Tipo Documento non valido o a null
//---
string k_return=""


if len(trim(ast_tab_arfa.tipo_doc)) > 0 then 

	choose case trim(ast_tab_arfa.tipo_doc)
			
		case kki_tipo_doc_fattura

			choose case ast_tab_arfa.stampa_tradotta
				case "FR"
					k_return= "Invoice"
				case "EN"
					k_return= "Invoice"
				case else
					k_return= "Fattura"
			end choose
		
		case kki_tipo_doc_AutoFattura
			k_return= "Autofattura"
		
		case kki_tipo_doc_proforma
			k_return= "Proforma"
		
		case kki_tipo_doc_nota_di_credito
			choose case ast_tab_arfa.stampa_tradotta
				case "FR"
					k_return= "Credit Note"
				case "EN"
					k_return= "Credit Note"
				case else
					k_return= "Nota di Credito"
			end choose
		
		case else
			k_return= ""
	end choose


end if


return k_return

end function

public function boolean if_ddt_fatturato (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla se DDT è in Fattura
//---
//---  input: st_tab_arfa.num_bolla_out e data_bolla_out 
//---  otput: st_tab_arfa.id_fattura più alto  
//---  ritorna: boolean = TRUE DDT fatturato 
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_arfa.id_fattura = 0 

//if kst_tab_arfa.num_bolla_out > 0 then 
select max(id_fattura)
	   into :kst_tab_arfa.id_fattura
	   from  ARFA
       where num_bolla_out   =  :kst_tab_arfa.num_bolla_out 
		      and data_bolla_out   =  :kst_tab_arfa.data_bolla_out 
       using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura DDT in Fattura (arfa) " + string(kst_tab_arfa.num_bolla_out ) + " del " + string(kst_tab_arfa.data_bolla_out ) + "~n~r  " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito( kst_esito ) 	
		throw kguo_exception
	end if
	
	if kst_tab_arfa.id_fattura > 0 then
		k_return = true
	end if
	
//else
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = "Manca numero DDT per controllare tra le Fatture (arfa) " 
//	kst_esito.esito = kkg_esito.err_logico
//	kguo_exception.set_esito( kst_esito ) 	
//	throw kguo_exception
//end if



return k_return

end function

public function boolean set_cambio_ddt_num_data (st_tab_arfa kst_tab_arfa_old, st_tab_arfa kst_tab_arfa_new) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Cambia numero e data bolla ddt
//--- 
//--- 
//--- Inp:  st_tab_arfa_old.num_bolla_out data_bolla_out
//---      st_tab_arfa_new.num_bolla_out data_bolla_out nuovi
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arfa_old.num_bolla_out > 0 then

	kst_tab_arfa_new.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa_new.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE ARFA 
		  SET num_bolla_out = :kst_tab_arfa_new.num_bolla_out
		   ,data_bolla_out = :kst_tab_arfa_new.data_bolla_out
			,x_datins = :kst_tab_arfa_new.x_datins
			,x_utente = :kst_tab_arfa_new.x_utente
		WHERE num_bolla_out = :kst_tab_arfa_old.num_bolla_out
		and data_bolla_out = :kst_tab_arfa_old.data_bolla_out
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'dati DDT' in Fattura. ~n~r" &
					+ "Numero DDT nuovo: " + string(kst_tab_arfa_new.num_bolla_out, "####0") + "  " &
					+ " numero DDT da cambiare: " + string(kst_tab_arfa_old.num_bolla_out, "####0") + " del " + string(kst_tab_arfa_old.data_bolla_out)  & 
					+ " ~n~rErrore-tab.ARFA_TESTA:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_arfa_new.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_new.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_arfa_new.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_new.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Fatture, Manca numero DDT per procedere!" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function long get_colli_x_id_armo (ref st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Calcolo Colli fatturati x id_armo
//---
//---  input: st_tab_arfa.id_armo 
//---  otput: st_tab_arfa.colli
//---  ret:  true = trovato
//---  se ERRORE lancia un Exception
//---
long k_return = 0
long k_anno
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arfa.id_armo > 0 then

   	select  sum(colli)
	   into :kst_tab_arfa.colli
	   from  ARFA
       where id_armo  = : kst_tab_arfa.id_armo
       using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura colli Fatturati (arfa) per id riga lotto: " + string(kst_tab_arfa.id_armo ) + "~n~r  " &
									 + trim(SQLCA.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			kst_tab_arfa.colli = 0
		else	
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	else
		if isnull(kst_tab_arfa.colli) then kst_tab_arfa.colli = 0
		k_return = kst_tab_arfa.colli
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id riga lotto per leggere colli in Fattura (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if

return k_return 


end function

public function long get_colli_fatturati (readonly st_tab_arfa kst_tab_arfa) throws uo_exception;//====================================================================
//=== Torna il Numero Colli Fatturati (meno la fattura in argomento)
//=== 
//=== Input : kst_tab_arfa.id_armo, kst_tab_arfa.id_fattura (se zero non esclude alcuna fattura)
//=== Ritorna: nr. colli fatturati
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
//
st_tab_arfa kst_tab_arfa_nc
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if isnull(kst_tab_arfa.id_fattura) then kst_tab_arfa.id_fattura = 0
	
//--- Colli in Fatture
	select sum(arfa.colli)
		into :kst_tab_arfa.colli
		from arfa 
		where arfa.id_armo = :kst_tab_arfa.id_armo
			and arfa.id_fattura <> :kst_tab_arfa.id_fattura
			and tipo_doc in (:kki_tipo_doc_fattura, :kki_tipo_doc_AutoFattura)
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa.colli = 0
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw  kuo_exception
		end if
	end if
	if isnull(kst_tab_arfa.colli) then kst_tab_arfa.colli = 0

//--- Colli in Note di Credito
	select sum(arfa.colli)
		into :kst_tab_arfa_nc.colli
		from arfa 
		where arfa.id_armo = :kst_tab_arfa.id_armo
			and arfa.id_fattura <> :kst_tab_arfa.id_fattura
			and tipo_doc = :kki_tipo_doc_nota_di_credito
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arfa_nc.colli = 0
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw  kuo_exception
		end if
	end if
	if isnull(kst_tab_arfa_nc.colli) then kst_tab_arfa_nc.colli = 0
	
	
return (kst_tab_arfa.colli - kst_tab_arfa_nc.colli)


end function

public function long get_colli_fatturati_x_id_armo (readonly st_tab_arfa kst_tab_arfa) throws uo_exception;//====================================================================
//=== Torna il Numero Colli Fatturati o N.C.
//=== 
//=== Input : kst_tab_arfa.id_armo
//=== Ritorna: nr. colli fatturati
//=== Exception se errore con st_esito valorizzato
//===					
//====================================================================
//
st_tab_arfa kst_tab_arfa_nc
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
//--- Colli in Fatture
	select sum(arfa.colli)
		into :kst_tab_arfa.colli
		from arfa 
		where arfa.id_armo = :kst_tab_arfa.id_armo
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arfa.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
	end if
	if isnull(kst_tab_arfa.colli) then kst_tab_arfa.colli = 0

	
	
return kst_tab_arfa.colli


end function

public function boolean if_f_splitpayment (st_tab_arfa kst_tab_arfa) throws uo_exception;//--
//---  Controlla se Fattura ha lo Split-Payment
//---
//---  input: st_tab_arfa.id_fatture
//---  otput: boolean TRUE = con SplitPayment
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
int k_f_splitpayment
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_arfa.id_fattura > 0 then 
	
// le clausole " TABLE (MULTISET ( "	permettono una tabella virtuale quindi non c'e' nella from ma è il risultato della subquery
   select distinct 1
	   into :k_f_splitpayment
		 from TABLE (MULTISET (
			select id_fattura
				   from  ARFA_v left outer join IVA
								on arfa_v.iva = iva.codice
     				  where arfa_v.id_fattura   =  :kst_tab_arfa.id_fattura 
		   					 and iva.f_splitpayment = 'S'
   			union all
   				select id_fattura
		   			from  ARFA left outer join IVA
							on arfa.iva = iva.codice
      				 where arfa.id_fattura   =  :kst_tab_arfa.id_fattura 
		    					and iva.f_splitpayment = 'S'
								 ))
       using kguo_sqlca_db_magazzino;
end if

if kst_tab_arfa.id_fattura > 0 then 
	
	if k_f_splitpayment = 1 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura condizione Split-Payment in Fattura (arfa) id " + string(kst_tab_arfa.id_fattura ) + "~n~r  " &
				+  " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id documento per valutare lo Split Paymenti della Fattura (arfa) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

public subroutine tb_delete (st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella ARFA_PA (dati PA x Fattura elettronica) 
//=== 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_sr
st_esito kst_esito


try 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_sr = if_sicurezza(kkg_flag_modalita.cancellazione)

	if k_sr then

//--- cancella
		delete from arfa_pa
					WHERE id_fattura = :kst_tab_arfa_pa.id_fattura
			using kguo_sqlca_db_magazzino;
			
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
//--- commit...			
			if kst_tab_arfa_pa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		else
//---- rollback....	
			if kst_tab_arfa_pa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
		"Errore durante la rimozione dati Fatturazione PA (fatturazione elettronica)" &
						+ " id fattura: " + string(kst_tab_arfa_pa.id_fattura, "####0") + "~n~r" &
						+ trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end subroutine

public subroutine tb_update (ref st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception;//
//--- Aggiorna Dati PA Fattura
//---
//--- input:  st_tab_arfa_pa
//---
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	if_sicurezza(kkg_flag_modalita.modifica)

//--- 
	kst_tab_arfa_pa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa_pa.x_utente = kGuf_data_base.prendi_x_utente()

//--- aggiorna le righe di dettaglio
	UPDATE arfa_pa  
			  SET  ordineacquisto_id    = :kst_tab_arfa_pa.ordineacquisto_id
					 , ordineacquisto_data    = :kst_tab_arfa_pa.ordineacquisto_data
					 , ordineacquisto_commessa = :kst_tab_arfa_pa.ordineacquisto_commessa
					 , codice_cig    = :kst_tab_arfa_pa.codice_cig
					 , codice_cup    = :kst_tab_arfa_pa.codice_cup
					 ,  x_datins      = :kst_tab_arfa_pa.x_datins
					 ,  x_utente    = :kst_tab_arfa_pa.x_utente
			WHERE id_fattura = :kst_tab_arfa_pa.id_fattura 
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornam. Dati PA Fattura Elettronica (id.=" + string(kst_tab_arfa_pa.id_fattura)  +") : " &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_arfa_pa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )  // Rollback
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
		if kst_tab_arfa_pa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try



end subroutine

public subroutine tb_insert (ref st_tab_arfa_pa kst_tab_arfa_pa) throws uo_exception;//
//--- Inserisce dati PA Fattura
//--- 
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if_sicurezza(kkg_flag_modalita.inserimento)

//--- 

	kst_tab_arfa_pa.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arfa_pa.x_utente = kGuf_data_base.prendi_x_utente()
	
	INSERT INTO arfa_pa
				(id_fattura, 
				  ordineacquisto_id,   
				  ordineacquisto_data,   
			 	  ordineacquisto_commessa,   
				  codice_cig,   
				  codice_cup,   
				  x_datins,   
				  x_utente 
				)  
	             VALUES (   
				  :kst_tab_arfa_pa.id_fattura,   
				  :kst_tab_arfa_pa.ordineacquisto_id,   
				  :kst_tab_arfa_pa.ordineacquisto_data,   
				  :kst_tab_arfa_pa.ordineacquisto_commessa,   
				  :kst_tab_arfa_pa.codice_cig,   
				  :kst_tab_arfa_pa.codice_cup,   
				  :kst_tab_arfa_pa.x_datins,   
				  :kst_tab_arfa_pa.x_utente   
					)  
			using kguo_sqlca_db_magazzino;
	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserimento dati PA Fattura Elettronica (id.=" + string(kst_tab_arfa_pa.id_fattura)  +") : " &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_arfa_pa.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )  // Rollback
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
		if kst_tab_arfa_pa.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arfa_pa.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	



end subroutine

public function long get_id_arfa_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID ARFA inserito 
//--- 
//---  input: 
//---  ret: max ID_ARFA
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_ARFA)
		 INTO 
				:k_return
		 FROM ARFA  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID in Fattura in tabella (ARFA)" &
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

public function long get_id_fattura_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID FATTURA inserito 
//--- 
//---  input: 
//---  ret: max ID_FATTURA
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_fattura)
		 INTO 
				:k_return
		 FROM ARFA_TESTA  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID in testata Fatture in tabella (ARFA_TESTA)" &
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

public function long get_id_arfa_v_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID ARFA_V inserito 
//--- 
//---  input: 
//---  ret: max ID_ARFA_V
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_ARFA_V)
		 INTO 
				:k_return
		 FROM ARFA_V  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID riga di commento in Fattura in tabella (ARFA_V)" &
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

on kuf_fatt.create
call super::create
end on

on kuf_fatt.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "Fattura"

end event

