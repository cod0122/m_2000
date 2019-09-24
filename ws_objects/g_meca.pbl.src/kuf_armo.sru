$PBExportHeader$kuf_armo.sru
forward
global type kuf_armo from kuf_parent
end type
type message_1 from message within kuf_armo
end type
end forward

global type kuf_armo from kuf_parent
message_1 message_1
end type
global kuf_armo kuf_armo

type variables
//
//--- Molti campi erano Constant  ma è poi impossibili usarli nelle Query per cui nisba!
//

//--- 
//--- flag meca.Aperto (ex causale)
//---
public constant string kki_meca_aperto_si = "S"
public constant string kki_meca_aperto_no = "N"
public constant string kki_meca_aperto_riaperto = "R"
public constant string kki_meca_aperto_annullato = "A"
public constant string kki_meca_aperto_nullX = "X"

////--- flag campo Stato della Dosimetrica SPOSTATI NEL KUF_MECA_DOSIM
//public constant string ki_err_lav_ok_da_conv = " "
//public constant string ki_err_lav_ok_conv_ko_da_aut = "K"
//public constant string ki_err_lav_ok_conv_da_aut = "A"
//public constant string ki_err_lav_ok_conv_aut_ok = "2"
//public constant string ki_err_lav_ok_conv_ko_bloc = "B"
//public constant string ki_err_lav_ok_conv_ko_sbloc = "1"
//--- flag di forzatura in stampa dell'Attestato
public constant string ki_cert_forza_stampa_SI = "1"


//--- flag campo Stato della Lavorazione
public constant string ki_err_lav_fin_da_lav = " "
public constant string ki_err_lav_fin_ko = "1"
public constant string ki_err_lav_fin_ok = " "

//--- flag campo Stato del Carico 
public constant int ki_meca_stato_ok = 0  // Normale / Controllato
public constant int ki_meca_stato_blk = 1 // bloccato
public constant int ki_meca_stato_sblk = 2 // sbloccato ma ancora da verificare per portarlo a ZERO 
public constant int ki_meca_stato_blk_con_controllo = 3 // BLOCCATO ma già controllato
public constant int ki_meca_stato_blk_con_controllo_1 = 4 // BLOCCATO con controlli
public constant int ki_meca_stato_gen_da_completare = 5 // appena Generato da PKL o Manuale ma non controllato definitivamente

//--- flag campo STATO_IN_ATTENZIONE
public constant int kki_STATO_IN_ATTENZIONE_ON = 1  // flag acceso ovvero Lotto in 'Attenzione'
public constant int kki_STATO_IN_ATTENZIONE_OFF = 0  // flag spento ovvero Lotto NON in 'Attenzione'

//--- Flag x aprire il programma x fare solo le AUTORIZZAZIONI varie - flag posto in "st_open_w.key2"
public constant string kki_KEY2_modalita_AUTORIZZAZIONI = "K2AUT"

//--- tipo Magazzino
public constant int kki_magazzino_NOBARCODE = 1
public constant int kki_magazzino_DATRATTARE = 2
public constant int kki_magazzino_DP = 4
public constant int kki_magazzino_RD = 6
public constant int kki_magazzino_TUTTI = 9


end variables

forward prototypes
public function st_esito setta_errore_lav (st_tab_meca kst_tab_meca)
public subroutine meca_if_isnull (st_tab_meca kst_tab_meca)
public subroutine if_isnull_meca (ref st_tab_meca kst_tab_meca)
public subroutine if_isnull_armo (ref st_tab_armo kst_tab_armo)
private function st_esito tb_delete_meca (st_tab_meca kst_tab_meca)
public function integer richiesta_conferma_cancellazione (st_tab_meca kst_tab_meca)
public function st_esito chiudi_lavorazione (st_tab_meca kst_tab_meca)
public function st_esito anteprima_testa (ref datawindow kdw_anteprima, st_tab_meca kst_tab_meca)
public function boolean if_lotto_dosimetria_gia_autorizzata (ref st_tab_meca kst_tab_meca)
public function string err_lav_ok_dammi_descr (ref st_tab_meca kst_tab_meca)
public function boolean if_lotto_dosimetria_gia_definitivo (ref st_tab_meca kst_tab_meca)
public function st_esito leggi_riga (string k_tipo, ref st_tab_armo kst_tab_armo)
public function st_esito leggi_testa (string k_tipo, ref st_tab_meca kst_tab_meca)
public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function st_esito get_id_meca (ref st_tab_armo kst_tab_armo)
public function st_esito get_stato (ref st_tab_meca kst_tab_meca)
public function boolean if_stampa_etichetta_avvertenze (st_tab_meca kst_tab_meca)
public function st_esito get_id_meca_da_id_armo (ref st_tab_armo kst_tab_armo)
public function st_esito anteprima_riga (ref datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function integer get_colli_anno_x_clie_3 (readonly st_tab_meca kst_tab_meca) throws uo_exception
public function st_esito get_riga_colli_da_fatt (ref st_tab_armo kst_tab_armo)
public function st_esito get_riga_qta (ref st_tab_armo kst_tab_armo)
public function st_esito set_colli_fatt (st_tab_armo kst_tab_armo)
public subroutine get_num_int (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_clie (ref st_tab_meca kst_tab_meca) throws uo_exception
public function st_esito get_colli_entrati_riga (ref st_tab_armo kst_tab_armo)
public function st_esito set_colli_fatturati (st_tab_armo kst_tab_armo)
public function st_esito get_ultimo_doc (ref st_tab_meca kst_tab_meca)
public function st_esito anteprima_testa (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca)
public function st_esito get_ultimo_doc_ins (ref st_tab_meca kst_tab_meca)
public function st_esito get_consegna_data (ref st_tab_meca kst_tab_meca)
public subroutine set_num_int (ref st_tab_meca kst_tab_meca) throws uo_exception
public function st_esito get_id_meca_da_data (ref st_tab_armo kst_tab_armo)
public function st_esito anteprima_a_righe (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca)
public function boolean if_esiste (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_num_data_int (ref st_tab_meca kst_tab_meca) throws uo_exception
private function st_esito set_stato_in_attenzione (ref st_tab_meca kst_tab_meca)
public function st_esito set_stato_in_attenzione_off (ref st_tab_meca kst_tab_meca)
public function st_esito set_stato_in_attenzione_on (ref st_tab_meca kst_tab_meca)
private function st_esito get_stato_in_attenzione (ref st_tab_meca kst_tab_meca)
public function st_esito set_stato_in_attenzione_cambia (ref st_tab_meca kst_tab_meca)
public function st_esito get_lotto_rich_autorizz (ref st_tab_meca kst_tab_meca)
public function boolean if_lotto_rich_autorizz_ok (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean consenti_sblocco_meca_non_conforme (st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_id_wm_pklist (st_tab_meca kst_tab_meca)
public function boolean set_data_fine_lav (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_dati_rid (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_clie_listino (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_err_lav (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_lotto_completo (st_tab_armo kst_tab_armo) throws uo_exception
public function boolean get_magazzino (ref st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_nr_colli_magazzino_no_barcode (st_tab_armo kst_tab_armo) throws uo_exception
public function long get_colli_fatturati (st_tab_armo kst_tab_armo) throws uo_exception
public function boolean get_id_listino (ref st_tab_armo kst_tab_armo) throws uo_exception
public function long get_colli_in_giacenza (readonly st_tab_armo ast_tab_armo) throws uo_exception
public function long get_colli_in_giacenza_x_id_meca (readonly st_tab_armo ast_tab_armo) throws uo_exception
public function st_esito get_id_listino (ref st_tab_armo kst_tab_armo, st_tab_meca kst_tab_meca)
public function boolean set_lotto_chiudi (ref st_tab_meca ast_tab_meca) throws uo_exception
private function boolean set_aperto (ref st_tab_meca ast_tab_meca) throws uo_exception
public function boolean set_lotto_apri (ref st_tab_meca ast_tab_meca) throws uo_exception
public function boolean if_esiste_blk (readonly st_tab_meca ast_tab_meca) throws uo_exception
public function st_esito get_id_meca (ref st_tab_meca kst_tab_meca)
public function st_esito anteprima_elenco_memo (datastore kdw_anteprima, st_tab_meca kst_tab_meca)
public function string get_art (ref st_tab_armo ast_tab_armo) throws uo_exception
public function boolean if_da_trattare (st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_causale (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean get_altri_dati (ref st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_righe (ref st_tab_armo kst_tab_armo[]) throws uo_exception
public function long get_colli_da_sped (ref st_tab_armo ast_tab_armo) throws uo_exception
public subroutine get_num_bolla_in (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_lotto_pianificato (st_tab_meca kst_tab_meca) throws uo_exception
public function st_esito tb_delete_riferimento (st_tab_meca ast_tab_meca) throws uo_exception
public function long get_num_int_new (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_numero_nuovo () throws uo_exception
public function long get_colli_sped_lotto (st_tab_meca ast_tab_meca) throws uo_exception
public function long get_colli_lotto (st_tab_armo kst_tab_armo) throws uo_exception
public function long tb_update_meca (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long tb_update_meca_blk (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long tb_update_armo (ref st_tab_armo kst_tab_armo) throws uo_exception
public subroutine tb_delete_riga (st_tab_armo kst_tab_armo) throws uo_exception
public function string get_cod_sl_pt (ref st_tab_armo ast_tab_armo) throws uo_exception
public function boolean if_lotto_dosimetria_rilevata (st_tab_meca ast_tab_meca) throws uo_exception
public function boolean if_lotto_pianificato_xriga (st_tab_armo kst_tab_armo) throws uo_exception
public function boolean consenti_forza_stampa_attestato (st_tab_meca kst_tab_meca) throws uo_exception
public function boolean consenti_aut_stampa_attestato_farma (st_tab_meca kst_tab_meca) throws uo_exception
public function boolean consenti_aut_stampa_attestato_alimentare (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine forza_stampa_attestato (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception
public subroutine aut_stampa_attestato_farma (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception
public subroutine aut_stampa_attestato_alimentare (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception
public function string get_stato_descrizione (st_tab_meca_stato ast_tab_meca_stato) throws uo_exception
public function long get_contratto (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long tb_update_meca_all (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine set_consegna_data (st_tab_meca kst_tab_meca) throws uo_exception
public function string get_cod_sl_pt_x_id_meca (ref st_tab_armo ast_tab_armo) throws uo_exception
public subroutine get_dati_certif (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_err_lav_ok (ref st_tab_meca ast_tab_meca) throws uo_exception
public function boolean set_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception
public function integer get_colli_entrati_riga_datrattare (st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_colli_entrati_datrattare (ref st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_colli_danontrattare (st_tab_armo kst_tab_armo) throws uo_exception
public function boolean tb_update_data_lav_fin (st_tab_meca kst_tab_meca) throws uo_exception
public function long get_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception
public function integer get_colli_trattati (st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_colli_in_lav (ref st_tab_armo kst_tab_armo) throws uo_exception
public function integer get_colli_entrati_conto_deposito (st_tab_armo kst_tab_armo) throws uo_exception
public function boolean if_lotto_farmaceutico (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine set_data_ent (st_tab_meca kst_tab_meca) throws uo_exception
public function datetime get_data_ent (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_e1srst (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long set_aperto_no_spediti (st_tab_meca ast_tab_meca) throws uo_exception
public function boolean set_lotto_annullato (ref st_tab_meca ast_tab_meca) throws uo_exception
public function long get_id_da_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_id_da_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_e1_dati (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_lotto_associato (st_tab_meca ast_tab_meca) throws uo_exception
public function string get_e1srst (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean set_lotto_chiudi_ok (ref st_tab_meca ast_tab_meca) throws uo_exception
public function boolean set_lotto_annullato_no_sr (ref st_tab_meca ast_tab_meca) throws uo_exception
public subroutine set_meca_blk_descrizione (ref st_tab_meca kst_tab_meca) throws uo_exception
public function string get_meca_blk_descrizione (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine get_id_meca_min_max_x_data_ent (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca)
public function boolean if_magazzino_da_trattare (st_tab_armo kst_tab_armo)
public function long get_id_da_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_id_meca_da_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_id_meca_max () throws uo_exception
public function long get_id_armo_max () throws uo_exception
public function boolean if_convalidato (st_tab_meca ast_tab_meca) throws uo_exception
public function integer meca_non_conforme_blocca_sblocca (st_tab_meca kst_tab_meca) throws uo_exception
private function integer meca_non_conforme_blocca_sblocca_upd (st_tab_meca kst_tab_meca) throws uo_exception
public function string get_stato_descrizione_std (st_tab_meca ast_tab_meca) throws uo_exception
public function string u_get_consegna_tempi (ref st_tab_meca kst_tab_meca) throws uo_exception
public subroutine set_consegna_ora (st_tab_meca kst_tab_meca) throws uo_exception
public function integer set_dosimprev (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_lotto_chiuso (ref st_tab_meca kst_tab_meca) throws uo_exception
public function long get_id_meca_da_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception
end prototypes

public function st_esito setta_errore_lav (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Update campo Errore di lavorazione in BARCODE (es. giri errati) su MECA
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.st_tab_g_0 = kst_tab_meca.st_tab_g_0 

	if not isnull(kst_tab_meca.err_lav_fin) &
		and len(trim(kst_tab_meca.err_lav_fin)) > 0 then
	
		kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

		update meca set 	 
			 err_lav_fin = :kst_tab_meca.err_lav_fin,
			 x_datins = :kst_tab_meca.x_datins,
			 x_utente = :kst_tab_meca.x_utente
		where id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
			

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Non trovato Lotto ID: " + string(kst_tab_meca.id) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			else
				if kguo_sqlca_db_magazzino.sqlcode <> 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore in aggiornamento Lotto campo errore trattamento, ID: "  + string(kst_tab_meca.id) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
					if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_rollback( )
					end if
				end if
			end if
		end if

	end if





return kst_esito


end function

public subroutine meca_if_isnull (st_tab_meca kst_tab_meca);
end subroutine

public subroutine if_isnull_meca (ref st_tab_meca kst_tab_meca);//---
//--- toglie i NULL ai campi della tabella 
//---
kuf_meca_dosim kuf1_meca_dosim


kuf1_meca_dosim = create kuf_meca_dosim
kuf1_meca_dosim.if_isnull(kst_tab_meca.st_tab_meca_dosim)
destroy kuf1_meca_dosim

if isnull(kst_tab_meca.id) then	kst_tab_meca.id = 0
if isnull(kst_tab_meca.num_int) then	kst_tab_meca.num_int = 0
if isnull(kst_tab_meca.data_int) then	kst_tab_meca.data_int = date(0)
if isnull(kst_tab_meca.data_ent) then	kst_tab_meca.data_ent = datetime(date(0), time(0)) 
if isnull(kst_tab_meca.num_bolla_in) then	kst_tab_meca.num_bolla_in = "" 
if isnull(kst_tab_meca.data_bolla_in) then kst_tab_meca.data_bolla_in = date(0)

if isnull(kst_tab_meca.cert_forza_stampa) then	kst_tab_meca.cert_forza_stampa = ""
if isnull(kst_tab_meca.note_lav_ok) then kst_tab_meca.note_lav_ok = ""
if isnull(kst_tab_meca.err_lav_ok) then kst_tab_meca.err_lav_ok = "" 
if isnull(kst_tab_meca.err_lav_fin) then kst_tab_meca.err_lav_fin = "0"
if isnull(kst_tab_meca.data_lav_fin) then kst_tab_meca.data_lav_fin = date(0)
if isnull(kst_tab_meca.stato) then kst_tab_meca.stato = 0
if isnull(kst_tab_meca.stato_in_attenzione) then kst_tab_meca.stato_in_attenzione = kki_STATO_IN_ATTENZIONE_ON

if isnull(kst_tab_meca.clie_1) then	kst_tab_meca.clie_1 = 0
if isnull(kst_tab_meca.clie_2) then	kst_tab_meca.clie_2 = 0
if isnull(kst_tab_meca.clie_3) then	kst_tab_meca.clie_3 = 0

if isnull(kst_tab_meca.x_datins) then kst_tab_meca.x_datins = datetime(date(0))
if isnull(kst_tab_meca.x_utente) then kst_tab_meca.x_utente = ""

if isnull(kst_tab_meca.x_data_cert_f_st) then  kst_tab_meca.x_data_cert_f_st = datetime(date(0))
if isnull(kst_tab_meca.x_utente_cert_f_st) then kst_tab_meca.x_utente_cert_f_st = ""
if isnull(kst_tab_meca.cert_farma_st_ok) then kst_tab_meca.cert_farma_st_ok  = ""  
if isnull(kst_tab_meca.x_data_cert_farma) then kst_tab_meca.x_data_cert_farma  = datetime(date(0))  
if isnull(kst_tab_meca.x_utente_cert_farm) then kst_tab_meca.x_utente_cert_farm  = ""  
if isnull(kst_tab_meca.cert_aliment_st_ok) then kst_tab_meca.cert_aliment_st_ok  = ""  
if isnull(kst_tab_meca.x_data_cert_alim) then kst_tab_meca.x_data_cert_alim  = datetime(date(0))  
if isnull(kst_tab_meca.x_utente_cert_alim) then kst_tab_meca.x_utente_cert_alim  = ""  

if isnull(kst_tab_meca.e1doco) then kst_tab_meca.e1doco = 0
if isnull(kst_tab_meca.e1rorn) then kst_tab_meca.e1rorn = 0
if isnull(kst_tab_meca.e1srst) then kst_tab_meca.e1srst = ""

if isnull(kst_tab_meca.dosimprev) then kst_tab_meca.dosimprev = 0

if isnull(kst_tab_meca.x_datins_blk) then	kst_tab_meca.x_datins_blk = datetime(date(0))
if isnull(kst_tab_meca.x_utente_blk) then	kst_tab_meca.x_utente_blk = ""
if isnull(kst_tab_meca.x_datins_sblk) then kst_tab_meca.x_datins_sblk = datetime(date(0))
if isnull(kst_tab_meca.x_utente_sblk) then kst_tab_meca.x_utente_sblk = ""


if isnull(kst_tab_meca.area_mag) then	kst_tab_meca.area_mag = ""
//if isnull(kst_tab_meca.consegna_data) then kst_tab_meca.consegna_data = date(0)  
//if isnull(kst_tab_meca.consegna_ora) then kst_tab_meca.consegna_ora = time("00:00")  
if isnull(kst_tab_meca.contratto) then kst_tab_meca.contratto = 0  
if isnull(kst_tab_meca.aperto) then kst_tab_meca.aperto = "S"  
if isnull(kst_tab_meca.id_meca_causale) then kst_tab_meca.id_meca_causale = 0   
if isnull(kst_tab_meca.meca_blk_rich_autorizz) then kst_tab_meca.meca_blk_rich_autorizz = ""
if isnull(kst_tab_meca.meca_blk_descrizione) then kst_tab_meca.meca_blk_descrizione = "" 


end subroutine

public subroutine if_isnull_armo (ref st_tab_armo kst_tab_armo);//---
//--- toglie i NULL ai campi della tabella 
//---
int k_ctr=0

if isnull(kst_tab_armo.id_armo) then kst_tab_armo.id_armo = 0
if isnull(kst_tab_armo.id_meca) then kst_tab_armo.id_meca = 0
if isnull(kst_tab_armo.num_int) then kst_tab_armo.num_int = 0
if isnull(kst_tab_armo.data_int) then kst_tab_armo.data_int = date(0)
if isnull(kst_tab_armo.id_listino) then kst_tab_armo.id_listino = 0
if isnull(kst_tab_armo.art) then kst_tab_armo.art = ""
if isnull(kst_tab_armo.dose) then kst_tab_armo.dose = 0
if isnull(kst_tab_armo.cod_sl_pt) then kst_tab_armo.cod_sl_pt = ""
if isnull(kst_tab_armo.larg_1) then kst_tab_armo.larg_1 = 0
if isnull(kst_tab_armo.lung_1) then kst_tab_armo.lung_1 = 0
if isnull(kst_tab_armo.alt_1) then kst_tab_armo.alt_1 = 0
if isnull(kst_tab_armo.larg_2) then kst_tab_armo.larg_2 = 0
if isnull(kst_tab_armo.lung_2) then kst_tab_armo.lung_2 = 0
if isnull(kst_tab_armo.alt_2) then kst_tab_armo.alt_2 = 0
if isnull(kst_tab_armo.travaso) then kst_tab_armo.travaso = ""
if isnull(kst_tab_armo.colli_1) then kst_tab_armo.colli_1 = 0
if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
if isnull(kst_tab_armo.colli_fatt) then kst_tab_armo.colli_fatt = 0
if isnull(kst_tab_armo.magazzino) then	kst_tab_armo.magazzino = 0
if isnull(kst_tab_armo.peso_kg) then kst_tab_armo.peso_kg = 0
if isnull(kst_tab_armo.m_cubi) then kst_tab_armo.m_cubi = 0
if isnull(kst_tab_armo.pedane) then kst_tab_armo.pedane = 0
if isnull(kst_tab_armo.campione) then kst_tab_armo.campione = ""
if isnull(kst_tab_armo.note_1) then kst_tab_armo.note_1 = ""
if isnull(kst_tab_armo.note_2) then kst_tab_armo.note_2 = "" 
if isnull(kst_tab_armo.note_3) then kst_tab_armo.note_3 = "" 
if isnull(kst_tab_armo.stato) then kst_tab_armo.stato = 0
if isnull(kst_tab_armo.x_datins) then kst_tab_armo.x_datins =  datetime(date(0)) 
if isnull(kst_tab_armo.x_utente) then kst_tab_armo.x_utente = ""

for k_ctr = 1 to 10 
	if isnull(kst_tab_armo.st_tab_armo_nt.note[k_ctr]) then kst_tab_armo.st_tab_armo_nt.note[k_ctr] = "" 
next


end subroutine

private function st_esito tb_delete_meca (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Cancella i rek dalla tabella MECA con l'id del RIFERIMENTO
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===                : 3=INFORMATIVO
//====================================================================
boolean k_sicurezza
int k_nr_righe, k_riga
st_tab_armo kst_tab_armo
st_tab_armo_prezzi kst_tab_armo_prezzi
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
kuf_armo_prezzi kuf1_armo_prezzi
datastore kds_id_armo_x_id_meca


try 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_armo_prezzi = create kuf_armo_prezzi 
	
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti
	
	//--- controlla se utente autorizzato alla funzione in atto
	k_sicurezza = if_sicurezza(kst_open_w.flag_modalita )
	if k_sicurezza then k_sicurezza = kuf1_armo_prezzi.if_sicurezza(kst_open_w.flag_modalita )
	
	if not k_sicurezza then
	
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cancellazione Riga Riferimento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	
	else
	
		get_num_int(kst_tab_meca)
		
		kds_id_armo_x_id_meca = create datastore
		kds_id_armo_x_id_meca.dataobject = "ds_id_armo_x_id_meca"
		kds_id_armo_x_id_meca.settransobject(kguo_sqlca_db_magazzino)
		k_nr_righe = kds_id_armo_x_id_meca.retrieve(kst_tab_meca.id)
	
	//--- ricavo l'id_armo per cancellare le NOTE e RIGHE
//		DECLARE c_armo CURSOR FOR  
//				SELECT id_armo, num_int, data_int
//					FROM armo
//					WHERE id_meca = :kst_tab_meca.id
//					for update
//					using kguo_sqlca_db_magazzino;
					
//		open c_armo;
//		fetch c_armo into :kst_tab_armo.id_armo, :kst_tab_armo.num_int, :kst_tab_armo.data_int;
//		kst_esito1.SQLErrText = " "
//		kst_esito1.esito = kkg_esito.ok

		k_riga = 1
		do while k_nr_righe >= k_riga  

			kst_tab_armo.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_riga, "id_armo")  // get del ID_RMO da cancellare
			
	//--- cancella tutte le note delle righe del riferimento
			delete from armo_nt
					WHERE id_armo = :kst_tab_armo.id_armo
					using kguo_sqlca_db_magazzino;
				
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione Note Righe Riferimento ~n~r" &
						+ string(kst_tab_armo.num_int, "####0") + " del " &
						+ string(kst_tab_armo.data_int, "dd.mm.yyyy") &	
						+ '- Riga: ' + string(kst_tab_armo.id_armo, "#0") + " " &
						+ " ~n~rErrore-tab.ARMO_NT:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = "1"
			end if
			
	//--- cancella tutte Prezzi Riga delle righe del riferimento
			kst_tab_armo_prezzi.id_armo = kst_tab_armo.id_armo
			kuf1_armo_prezzi.tb_delete_x_id_armo(kst_tab_armo_prezzi)
			
	//--- cancella le righe una alla volta		
			kst_tab_armo.st_tab_g_0. esegui_commit = kst_tab_meca.st_tab_g_0. esegui_commit
			tb_delete_riga(kst_tab_armo)
			
//			fetch c_armo into :kst_tab_armo.id_armo, :kst_tab_armo.num_int, :kst_tab_armo.data_int;
			k_riga ++
			
		loop
//		close c_armo;
	
	
		if kst_esito.esito = kkg_esito.ok then
	
	//--- cancella dati eventuali di Blocco
			delete from meca_blk
				where id_meca = :kst_tab_meca.id
				using kguo_sqlca_db_magazzino;
	
	//--- cancella dati convalida dosimetrica
			delete from meca_dosim
				where id_meca = :kst_tab_meca.id
				using kguo_sqlca_db_magazzino;
	
	//--- cancella testata riferimento
			delete from meca
				where id = :kst_tab_meca.id
				using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = &
					"Errore durante la cancellazione Testata Riferimento (id_meca =" &
							+ string(kst_tab_meca.id, "####0") + ") " &
							+ " ~n~rErrore-tab.MECA:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
			
	//--- Commit/Rollback		
			if kst_tab_meca.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
				if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
					kst_esito = kguo_sqlca_db_magazzino.db_commit()
					if kst_esito.esito <> kkg_esito.ok then
						kst_esito.SQLErrText = "Errore in Cancellazione Lotto (COMMIT): " + trim(kst_esito.SQLErrText)
					end if
				else
					kguo_sqlca_db_magazzino.db_rollback()
				end if
			end if
			
		end if
		
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
end try	


return kst_esito
end function

public function integer richiesta_conferma_cancellazione (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Richiesta conferma cancellazione
//=== 
//=== Ritorna 1 char : 1=utente da OK eseguire;
//===                : 2=utente da NON eseguire,
//===                : 3=utente annulla l'operazione;
//===           		: 9=operazone interrotta per errore
//===   
//====================================================================

integer k_return = 0
st_tab_clienti kst_tab_clienti


select num_int, data_int, clie_1, rag_soc_10
   into :kst_tab_meca.num_int
	     ,:kst_tab_meca.data_int
		  ,:kst_tab_meca.clie_1
		  ,:kst_tab_clienti.rag_soc_10
	from meca left outer join clienti on
	     meca.clie_1 = clienti.codice
	where meca.id = :kst_tab_meca.id
	using sqlca;

if sqlca.sqlcode <> 0 then
	
	k_return = messagebox("Elimina Riferimento " + string(kst_tab_meca.num_int), &
				"Vuoi cancellare l'INTERO Riferimento~n~r " &
				+ "n. " + string(kst_tab_meca.num_int) &
				+ " del " + string(kst_tab_meca.data_int, "dd.mm.yy") &
				+ " di " + string(kst_tab_meca.clie_1) + " " + trim(kst_tab_clienti.rag_soc_10) + "~n~r" &
				+ "ATTENZIONE: l'operazione elimina da tutto il sistema il Riferimento ",&
				question!, yesno!, 2) 

else
	k_return = 9
end if


return k_return

end function

public function st_esito chiudi_lavorazione (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Update della data di fine lavorazione se tutti i colli sono stati lavorati
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
long k_colli_da_trattare
st_tab_armo kst_tab_armo
st_tab_artr kst_tab_artr
st_tab_barcode kst_tab_barcode
st_esito kst_esito 
kuf_base kuf1_base
kuf_barcode kuf1_barcode


	try 
	
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
		kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()
					
		if kst_tab_meca.data_lav_fin > KKG.DATA_ZERO &
		   and (kst_tab_meca.num_int > 0 or kst_tab_meca.id > 0) then
		else
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlerrtext = "Errore Interno, manca 'data di fine' o 'num-lotto' (kuf_armo.chiudi_lavorazione)" 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		if kst_tab_meca.id > 0 then		
		else
			//--- se manca recupera l'ID del lotto
			kst_tab_armo.num_int = kst_tab_meca.num_int
			kst_tab_armo.data_int = kst_tab_meca.data_int
			kst_esito = get_id_meca(kst_tab_armo)
			kst_tab_meca.id = kst_tab_armo.id_meca
		end if
		
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.id_meca = kst_tab_meca.id
		kst_tab_artr.colli = kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode)
		k_colli_da_trattare = kuf1_barcode.get_nr_barcode_da_trattare_x_id_meca(kst_tab_barcode) 

			
//			select sum(colli_2) 
//					into :kst_tab_armo.colli_2 
//					from armo
//					where armo.id_meca = :kst_tab_meca.id
//					using kguo_sqlca_db_magazzino;
//					
//			if kst_tab_artr.colli >= kst_tab_armo.colli_2 then
		if kst_tab_artr.colli > 0 and k_colli_da_trattare <= 0 then
		
			update meca set 	 
					 data_lav_fin  = :kst_tab_meca.data_lav_fin
					 ,x_datins = :kst_tab_meca.x_datins
					 ,x_utente = :kst_tab_meca.x_utente
				where id = :kst_tab_meca.id
				using kguo_sqlca_db_magazzino;
		else
			
			update meca set 	 
					 data_lav_fin  = CONVERT(date,'01.01.1900')
					 ,x_datins = :kst_tab_meca.x_datins
					 ,x_utente = :kst_tab_meca.x_utente
				where id = :kst_tab_meca.id
				using kguo_sqlca_db_magazzino;
					
		end if	
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore in aggiornamento data fine lavorazione Lotto di 'non trovato' (kuf_armo.chiudi_lavorazione). Id Lotto: " + string(kst_tab_meca.id) + " ~n~r" +trim(kguo_sqlca_db_magazzino.SQLErrText)
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore in aggiornamento data fine lavorazione Lotto (kuf_armo.chiudi_lavorazione). Id Lotto: " + string(kst_tab_meca.id) + " ~n~r" +trim(kguo_sqlca_db_magazzino.SQLErrText)
					if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_rollback()
					end if
				end if
			end if
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- COMMIT			
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit()
		end if
	
	catch (uo_exception kuo1_exception)
			kst_esito = kguo_exception.get_st_esito( )
			
	finally
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
		
	end try





return kst_esito


end function

public function st_esito anteprima_testa (ref datawindow kdw_anteprima, st_tab_meca kst_tab_meca);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti

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
		if kdw_anteprima.dataobject = "d_meca_1"  then
			if kdw_anteprima.rowcount() > 0  then
				if kdw_anteprima.object.id_meca[1] = kst_tab_meca.id  then
					kst_tab_meca.id = 0 
				end if
			else
				kst_tab_meca.id = 0 
			end if
		end if
	end if

	if kst_tab_meca.id > 0 then
	
			kdw_anteprima.dataobject = "d_meca_1"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_meca.id)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Riferimento da visualizzare: ~n~r" + "nessun codice ID indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function boolean if_lotto_dosimetria_gia_autorizzata (ref st_tab_meca kst_tab_meca);//---
//--- Controllo x il Riferimento e' gia' stata Autorizzata la Prima Rilevazione Dosimetrica
//---
//--- Ritorna:  TRUE = gia' autorizzato;  FALSE = non autorizzato
//---
boolean k_autorizzato=false
kuf_meca_dosim kuf1_meca_dosim


	kuf1_meca_dosim = create kuf_meca_dosim
	
	k_autorizzato = kuf1_meca_dosim.if_dosimetria_gia_autorizzata(kst_tab_meca.err_lav_ok)
	
	destroy kuf1_meca_dosim
	
//	if not isnull(kst_tab_meca.err_lav_ok) and kst_tab_meca.err_lav_ok <> ki_err_lav_ok_da_conv &
//		and kst_tab_meca.err_lav_ok <> ki_err_lav_ok_conv_ko_da_aut &
//		and kst_tab_meca.err_lav_ok <> ki_err_lav_ok_conv_da_aut then
//		
//		k_autorizzato = true
//		
//	end if

return k_autorizzato


end function

public function string err_lav_ok_dammi_descr (ref st_tab_meca kst_tab_meca);//---
//--- Restituisce la descrizione dello stato del flag della Dosimetria
//---
//--- Parametri di input: kst_tab_meca flag err_lav_ok valorizzato
//--- Ritorna:  stringa col testo
//---
string k_testo=" "
kuf_meca_dosim kuf1_meca_dosim


	kuf1_meca_dosim = create kuf_meca_dosim
	
	k_testo = kuf1_meca_dosim.get_err_lav_ok_descr(kst_tab_meca.err_lav_ok)
	
	destroy kuf1_meca_dosim

//	choose case kst_tab_meca.err_lav_ok
//		case ki_err_lav_ok_da_conv
//			k_testo = "da Convalidare"
//		case ki_err_lav_ok_conv_ko_da_aut
//			k_testo = "Anomalia da Verificare"
//		case ki_err_lav_ok_conv_da_aut
//			k_testo = "da Verificare"
//		case ki_err_lav_ok_conv_aut_ok
//			k_testo = "Convalidata"
//		case ki_err_lav_ok_conv_ko_bloc
//			k_testo = "Bloccata x Anomalia"
//		case ki_err_lav_ok_conv_ko_sbloc
//			k_testo = "Rilasciata"
//		case else
//			k_testo = "da Convalidare"
//		
//	end choose

return k_testo


end function

public function boolean if_lotto_dosimetria_gia_definitivo (ref st_tab_meca kst_tab_meca);//---
//--- Controllo se la Dosimetria e' gia' nello stato Definitivo quindi non modificabile
//---
//--- Ritorna:  TRUE = gia' definitivo;  FALSE = non definitivo
//---
boolean k_definitivo=false
kuf_meca_dosim kuf1_meca_dosim


	kuf1_meca_dosim = create kuf_meca_dosim
	
	k_definitivo = kuf1_meca_dosim.if_dosimetria_gia_definitivo(kst_tab_meca.err_lav_ok)
	
	destroy kuf1_meca_dosim

//	if kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc &
//		or kst_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok &
//	   then
//		
//		k_definitivo = true
//		
//	end if

return k_definitivo


end function

public function st_esito leggi_riga (string k_tipo, ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Legge rek ARMO 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
long k_id_armo, k_colli  
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_id_armo = kst_tab_armo.id_armo 

	k_anno = year(kst_tab_armo.data_int) 

	choose case k_tipo

		case "R"
			SELECT
			      count(*),
					sum(armo.colli_2),   
					sum(armo.m_cubi),   
					sum(armo.peso_kg),   
					sum(colli_fatt),   
					sum(armo.pedane) 
			 INTO 
					:kst_tab_armo.contati,   
					:kst_tab_armo.colli_2,   
					:kst_tab_armo.m_cubi,   
					:kst_tab_armo.peso_kg,   
					:kst_tab_armo.colli_fatt,   
					:kst_tab_armo.pedane 
			 FROM armo  
			WHERE armo.id_armo = :kst_tab_armo.id_armo
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Dett.Entrate (id_armo=" + string(kst_tab_armo.id_armo) &
				                       + ") : " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else	
						kst_esito.esito = "1"
					end if
				end if
			end if

//--- come la R solo che leggo x num int e data
		case "T"
			SELECT
			      count(*),
					sum(armo.colli_2),   
					sum(armo.m_cubi),   
					sum(armo.peso_kg),   
					sum(colli_fatt),   
					sum(armo.pedane) 
			 INTO 
					:kst_tab_armo.contati,   
					:kst_tab_armo.colli_2,   
					:kst_tab_armo.m_cubi,   
					:kst_tab_armo.peso_kg,   
					:kst_tab_armo.colli_fatt,   
					:kst_tab_armo.pedane 
			 FROM armo  
			WHERE armo.num_int = :kst_tab_armo.num_int
			      and year(armo.data_int) = :k_anno 
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Dett.Entrate (Rif.=" + string(kst_tab_armo.num_int) &
				                       + " del " + string(k_anno)  + ") : " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else	
						kst_esito.esito = "1"
					end if
				end if
			end if

//--- Reperisce la dose del riferimento	
		case "D"
			declare c_armo_leggi_riga cursor for
				SELECT distinct
						  armo.data_int,
					     armo.dose, 
					     armo.cod_sl_pt 
  				   FROM armo  
				WHERE armo.num_int = :kst_tab_armo.num_int
				      and year(armo.data_int) = :k_anno
					and armo.dose > 0
					and armo.cod_sl_pt <> ' '
				 using sqlca;
			open c_armo_leggi_riga ;
			if sqlca.sqlcode = 0 then
				
				fetch c_armo_leggi_riga INTO 
					:kst_tab_armo.data_int
					,:kst_tab_armo.dose
					,:kst_tab_armo.cod_sl_pt;
					
				if sqlca.sqlcode <> 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Tab.Dett.Entrate (Rif.=" + string(kst_tab_armo.num_int) &
												  + " del " + string(k_anno)  + ") : " &
												 + trim(SQLCA.SQLErrText)
					if sqlca.sqlcode = 100 then
						kst_esito.esito = "100"
					else
						if sqlca.sqlcode > 0 then
							kst_esito.esito = "2"
						else	
							kst_esito.esito = "1"
						end if
					end if
				end if
				
				close c_armo_leggi_riga;
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.esito = "100"
			end if
	

//--- Reperisce il numero colli entrati	
		case "E"  
			SELECT    
						armo.travaso 
						 ,armo.colli_1
						 ,armo.colli_2
			 INTO
					:kst_tab_armo.travaso,   
					:kst_tab_armo.colli_1,   
					:kst_tab_armo.colli_2   
			 FROM armo  
			WHERE armo.id_armo = :k_id_armo   
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Dett.Entrate (id=" + string(k_id_armo) + "). Tipo elab: " + trim(k_tipo) &
											  + ". Errore: " + trim(SQLCA.SQLErrText)
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
				 
	
		case else
//--- legge tutto
			SELECT 
			      armo.id_meca,   
			      armo.num_int,   
					armo.data_int,   
					armo.id_listino,   
					armo.art,   
					armo.dose,   
 			      	armo.cod_sl_pt, 
					armo.note_1,   
					armo.note_2,   
					armo.note_3,   
					armo.larg_2,   
					armo.lung_2,   
					armo.alt_2,   
					armo.colli_2,   
					armo.travaso,   
					armo.m_cubi,   
					armo.peso_kg,   
					armo.colli_fatt,   
					armo.id_armo,   
					armo.magazzino,   
					armo.pedane,   
					armo.campione,
					armo.stato
			 INTO
			      :kst_tab_armo.id_meca,   
			      :kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_armo.id_listino,   
					:kst_tab_armo.art,   
					:kst_tab_armo.dose,   
 			      :kst_tab_armo.cod_sl_pt, 
					:kst_tab_armo.note_1,   
					:kst_tab_armo.note_2,   
					:kst_tab_armo.note_3,   
					:kst_tab_armo.larg_2,   
					:kst_tab_armo.lung_2,   
					:kst_tab_armo.alt_2,   
					:kst_tab_armo.colli_2,   
					:kst_tab_armo.travaso,   
					:kst_tab_armo.m_cubi,   
					:kst_tab_armo.peso_kg,   
					:kst_tab_armo.colli_fatt,   
					:kst_tab_armo.id_armo,   
					:kst_tab_armo.magazzino,   
					:kst_tab_armo.pedane,   
					:kst_tab_armo.campione,  
					:kst_tab_armo.stato  
			 FROM armo  
			WHERE armo.id_armo = :k_id_armo   
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Dett.Entrate (id=" + string(k_id_armo) + ") : " &
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
	
	end choose

return kst_esito

end function

public function st_esito leggi_testa (string k_tipo, ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Legge rek MECA 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	choose case k_tipo

		case "A"  // con num int e anno
		   SELECT 
			      meca.id,
			      meca.num_int,   
					meca.data_int,    
					meca.num_bolla_in,   
					meca.data_bolla_in,   
					meca.clie_1,   
					meca.clie_2,   
					meca.clie_3,   
					meca.contratto,   
					meca.area_mag,   
					max(meca_dosim.dosim_assorb) as dosim_assorb,   
					max(meca_dosim.dosim_spessore) as dosim_spessore,   
					max(meca_dosim.dosim_rapp_a_s) as dosim_rapp_a_s,   
					max(meca_dosim.dosim_lotto_dosim) as dosim_lotto_dosim,   
					max(meca_dosim.dosim_data) as dosim_data,   
					max(meca_dosim.dosim_dose) as dosim_dose,   
					meca.err_lav_ok,   
					meca.note_lav_ok,   
					meca.x_datins,   
					meca.x_utente  
			 INTO  
			      :kst_tab_meca.id,   
			      :kst_tab_meca.num_int,   
					:kst_tab_meca.data_int,   
					:kst_tab_meca.num_bolla_in,   
					:kst_tab_meca.data_bolla_in,   
					:kst_tab_meca.clie_1,   
					:kst_tab_meca.clie_2,   
					:kst_tab_meca.clie_3,   
					:kst_tab_meca.contratto,   
					:kst_tab_meca.area_mag,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_assorb,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_spessore,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_data,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_dose,   
					:kst_tab_meca.err_lav_ok,   
					:kst_tab_meca.note_lav_ok,   
					:kst_tab_meca.x_datins,   
					:kst_tab_meca.x_utente  
			 FROM meca left outer join meca_dosim on
			      meca.id = meca_dosim.id_meca
			WHERE meca.num_int = :kst_tab_meca.num_int
			      and year(meca.data_int) = year(:kst_tab_meca.data_int) 
			group by 
			      meca.id,
			      meca.num_int,   
					meca.data_int,   
					meca.num_bolla_in,   
					meca.data_bolla_in,   
					meca.clie_1,   
					meca.clie_2,   
					meca.clie_3,   
					meca.contratto,   
					meca.area_mag,   
					meca.err_lav_ok,   
					meca.note_lav_ok,   
					meca.x_datins,   
					meca.x_utente  
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Testata Entrate (Rif.=" + string(kst_tab_meca.num_int) &
				                       + " anno " + string(kst_tab_meca.data_int, "yyyy")  + ") : " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else	
						kst_esito.esito = "1"
					end if
				end if
			end if
	
	
		case "P"  // striminzita per ID
		   SELECT 
			     meca.num_int,   
				meca.data_int,   
				meca.clie_1,   
				meca.clie_2,   
				meca.clie_3,   
				meca.area_mag
			 INTO  
				    :kst_tab_meca.num_int, 
					:kst_tab_meca.data_int,   
					:kst_tab_meca.clie_1,   
					:kst_tab_meca.clie_2,   
					:kst_tab_meca.clie_3,   
					:kst_tab_meca.area_mag 
			 FROM meca 
			WHERE meca.id = :kst_tab_meca.id
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Testata Entrate (Rif.=" + string(kst_tab_meca.num_int) &
				                       + " anno " + string(kst_tab_meca.data_int, "yyyy")  + ") : " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else	
						kst_esito.esito = "1"
					end if
				end if
			end if
	
	

	
		case else
		   SELECT distinct
			      meca.id,
			      meca.num_int,   
					meca.data_int,   
					meca.num_bolla_in,   
					meca.data_bolla_in,   
					meca.clie_1,   
					meca.clie_2,   
					meca.clie_3,   
					meca.contratto,   
					meca.area_mag,   
					max(meca_dosim.dosim_assorb) as dosim_assorb,   
					max(meca_dosim.dosim_spessore) as dosim_spessore,   
					max(meca_dosim.dosim_rapp_a_s) as dosim_rapp_a_s,   
					max(meca_dosim.dosim_lotto_dosim) as dosim_lotto_dosim,   
					max(meca_dosim.dosim_data) as dosim_data,   
					max(meca_dosim.dosim_dose) as dosim_dose,   
					meca.err_lav_ok,   
					meca.note_lav_ok,   
					meca.x_datins,   
					meca.x_utente  
			 INTO  
			      :kst_tab_meca.id,   
			      :kst_tab_meca.num_int,   
					:kst_tab_meca.data_int,   
					:kst_tab_meca.num_bolla_in,   
					:kst_tab_meca.data_bolla_in,   
					:kst_tab_meca.clie_1,   
					:kst_tab_meca.clie_2,   
					:kst_tab_meca.clie_3,   
					:kst_tab_meca.contratto,   
					:kst_tab_meca.area_mag,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_assorb,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_spessore,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_data,   
					:kst_tab_meca.st_tab_meca_dosim.dosim_dose,   
					:kst_tab_meca.err_lav_ok,   
					:kst_tab_meca.note_lav_ok,   
					:kst_tab_meca.x_datins,   
					:kst_tab_meca.x_utente  
			 FROM meca left outer join meca_dosim on
			      meca.id = meca_dosim.id_meca
			WHERE meca.num_int = :kst_tab_meca.num_int
			      and meca.data_int = :kst_tab_meca.data_int 
			group by 
			      meca.id,
			      meca.num_int,   
					meca.data_int,   
					meca.num_bolla_in,   
					meca.data_bolla_in,   
					meca.clie_1,   
					meca.clie_2,   
					meca.clie_3,   
					meca.contratto,   
					meca.area_mag,   
					meca.err_lav_ok,   
					meca.note_lav_ok,   
					meca.x_datins,   
					meca.x_utente  
				 using sqlca;
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Testata Entrate (Rif.=" + string(kst_tab_meca.num_int) &
				                       + " del " + string(kst_tab_meca.data_int, "dd/mm/yyyy")  + ") : " &
											 + trim(SQLCA.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else	
						kst_esito.esito = "1"
					end if
				end if
			end if
	
	end choose

return kst_esito

end function

public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_armo kst_tab_armo);//====================================================================
//=== Operazione di Anteprima (elenco armo x id_meca)
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: standard
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
kst_open_w.id_programma = kkg_id_programma_elenco

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_armo.id_meca > 0 then

		kdw_anteprima.dataobject = "d_armo_l_4"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility
//
		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_meca)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.no_aut
		
	end if
end if


return kst_esito

end function

public function st_esito get_id_meca (ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Legge MECA 
//=== 
//=== 
//===  input: num_int e anno (in data_int)  es. '01.01.2007'
//===  Output: ID_MECA
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_anno = year(kst_tab_armo.data_int) 

	kst_tab_armo.id_meca = 0
	SELECT id
			 INTO 
					:kst_tab_armo.id_meca 
			 FROM meca  
			WHERE meca.num_int = :kst_tab_armo.num_int and year(data_int) = :k_anno
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Testata Riferimento (num=" + string(kst_tab_armo.num_int) &
									  +" anno=" + string(k_anno) + ") " &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
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


return kst_esito

end function

public function st_esito get_stato (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Torna il codice dello STATO del Lotto 
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Outout: stato_descrizione
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT codice
			 INTO 
					:kst_tab_meca.stato
			 FROM meca inner join meca_stato on 
			         meca.stato = meca_stato.codice
			WHERE meca.id = :kst_tab_meca.id 
				 using sqlca;
			
	if isnull(kst_tab_meca.stato) then
		kst_tab_meca.stato= ki_meca_stato_ok
	end if

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Stato Lotto non Trovato (" + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(SQLCA.SQLErrText)
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

public function boolean if_stampa_etichetta_avvertenze (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Controllo se Stampare etichette di Avvertenza
//=== 
//=== input:     st_tab_meca.id  valorizzando il campo ID
//=== 
//=== Ritorna tab. boolean, Esiti:   true=stampare le avvertenze
//===                                            false=no stampa avvertenze
//=== 
//====================================================================
boolean k_return
int k_ctr
st_esito kst_esito
st_tab_contratti kst_tab_contratti
kuf_contratti kuf1_contratti


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_contratti = create kuf_contratti

	get_contratto(kst_tab_meca)

	kst_tab_contratti.codice = kst_tab_meca.contratto
	kst_esito = kuf1_contratti.get_et_bcode_note(kst_tab_contratti)
	if kst_esito.esito = kkg_esito.ok then
		if len(trim(kst_tab_contratti.et_bcode_note)) = 0 or isnull(kst_tab_contratti.et_bcode_note) then	
			k_return = false
		else
			k_return = true
		end if
	else
		k_return = false
	end if

catch (uo_exception kuo_exception)
	k_return = false
	
finally
	if isvalid(kuf1_contratti) then destroy kuf1_contratti

end try

return k_return

end function

public function st_esito get_id_meca_da_id_armo (ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Legge MECA 
//=== 
//=== 
//===  input: kst_tab_armo.id_armo 
//===  Outout: kst_tab_armo.ID_MECA
//===              ST_ESITO, Esiti: STANDARD
//===                                     
//====================================================================
//
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_armo.id_meca = 0

	if kst_tab_armo.id_armo > 0 then

		SELECT distinct armo.id_meca
				 INTO 
						:kst_tab_armo.id_meca 
				 FROM armo  
				WHERE armo.id_armo = :kst_tab_armo.id_armo
					 using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_armo.id_meca = 0
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab. righe Lotto (armo) (id riga=" + string(kst_tab_armo.id_armo) + ") " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
	
	else
		kst_tab_armo.id_meca = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Tab. righe Lotto (armo): ID riga non indicato, operazione interrotta! "
	end if
	
return kst_esito

end function

public function st_esito anteprima_riga (ref datastore kdw_anteprima, st_tab_armo kst_tab_armo);//====================================================================
//=== Operazione di Anteprima (riga armo x id_armo)
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=Standard
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
kst_open_w.id_programma = kkg_id_programma_elenco

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_armo.id_armo > 0 then
		
		kdw_anteprima.dataobject = "d_armo"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_armo)
	else
		if kst_tab_armo.id_meca > 0 then
		
			kdw_anteprima.dataobject = "d_armo_l_4"		
			kdw_anteprima.settransobject(sqlca)

			kdw_anteprima.reset()	
//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_meca)

		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = kkg_esito.no_aut
		end if
		
	end if
end if


return kst_esito

end function

public function integer get_colli_anno_x_clie_3 (readonly st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il nr colli entrati x Cliente Fatturato
//=== 
//=== Input : kst_tab_meca.clie_3 
//=== Ritorna: Numero dei colli 
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
int k_return=0
int k_anno
st_tab_armo kst_tab_armo, kst_tab_armo_x
st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_meca.clie_3 > 0 then

	
//	k_anno = year(kg_dataoggi)
	k_anno = kguo_g.get_anno() // kg_anno
	kst_tab_armo_x.data_int = date (k_anno, 01, 01)
	kst_esito = get_id_meca_da_data(kst_tab_armo_x)
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw  kguo_exception
	end if
	
	if  kst_tab_armo_x.id_meca > 0 then

//--- conta il numero di colli entrati
		declare c_getr_colli_anno_x_clie_3 cursor for
			select sum(colli_2)
				from meca inner join armo on meca.id = armo.id_meca 
				where meca.clie_3 = :kst_tab_meca.clie_3
						and meca.id > :kst_tab_armo_x.id_meca
						and armo.magazzino <> 1 and armo.dose > 0 and armo.cod_sl_pt <> ''
						and not exists (select id_fattura from arfa where arfa.id_armo = armo.id_armo and armo.id_meca > :kst_tab_armo_x.id_meca) 
			union all
			select sum(colli_2)
				from meca inner join armo on meca.id = armo.id_meca 
							 inner join arfa on arfa.id_armo = armo.id_armo
				where arfa.clie_3 = :kst_tab_meca.clie_3
						and meca.id > :kst_tab_armo_x.id_meca
						and armo.magazzino <> 1 and armo.dose > 0 and armo.cod_sl_pt <> ''
		using sqlca;
//						and year(meca.data_int) = :k_anno
//					  and year(meca.data_int) = :k_anno
	 
		open c_getr_colli_anno_x_clie_3;
		if sqlca.sqlcode = 0 then
			fetch c_getr_colli_anno_x_clie_3 into :kst_tab_armo.colli_2;
			do while sqlca.sqlcode = 0 
				k_return += kst_tab_armo.colli_2
				fetch c_getr_colli_anno_x_clie_3 into :kst_tab_armo.colli_2;
			loop
			if sqlca.sqlcode <> 0 then
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = sqlca.sqlerrtext
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito )
					throw  kguo_exception
				end if
			end if
			close c_getr_colli_anno_x_clie_3;
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = sqlca.sqlerrtext
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw  kguo_exception
			end if
		end if
	
	end if
end if
	
return k_return

end function

public function st_esito get_riga_colli_da_fatt (ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Torna da Fatturare x riga lotto
//=== 
//=== Input : kst_tab_armo.id_armo 
//=== Ritorna st_esito :  come standard
//===					kst_tab_armo.colli_2 = colli trattati
//===   
//====================================================================
date k_data_0 = date(0)
st_tab_barcode kst_tab_barcode
st_tab_armo kst_tab_armo1, kst_tab_armo2
st_tab_arfa kst_tab_arfa
st_esito kst_esito
kuf_barcode kuf1_barcode
kuf_fatt kuf1_fatt



	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_barcode = create kuf_barcode

	try
//--- conta il numero di colli trattati
		kst_tab_barcode.id_armo = kst_tab_armo.id_armo
		kst_tab_armo1.colli_2 = kuf1_barcode.get_nr_barcode_trattati( kst_tab_barcode )
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )	
	end try
	if kst_esito.sqlcode  >= 0 then
		if kst_esito.sqlcode > 0 then
			kst_tab_armo1.colli_2 = 0
		end if

		try
//--- conta i colli da non fatturare
			kst_tab_barcode.id_armo = kst_tab_armo.id_armo
			kst_tab_armo2.colli_2 = kuf1_barcode.get_nr_barcode_da_non_trattare( kst_tab_barcode )
		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )	
		end try
		if kst_esito.sqlcode  >= 0 then
			if kst_esito.sqlcode > 0 then
				kst_tab_armo2.colli_2 = 0
			end if

//--- conta i colli già fatturati
			try
				kuf1_fatt = create kuf_fatt
				kst_tab_arfa.id_armo =  kst_tab_armo.id_armo
				kst_tab_armo2.colli_2 = kuf1_fatt.get_colli_fatturati(kst_tab_arfa)
				
//--- conta il nr colli Fatturabili: TRATTATI+DA NON TRATTARE - GIA FATTURATI				
				kst_tab_armo2.colli_2 = kst_tab_armo1.colli_2 + kst_tab_armo2.colli_2 - kst_tab_armo2.colli_2
				
			catch (uo_exception kuo_exception2)
				kst_esito = kuo_exception2.get_st_esito( )	
			finally
				destroy kuf1_fatt
			end try
			
		end if		
	end if
	
	destroy kuf1_barcode
	
return kst_esito

end function

public function st_esito get_riga_qta (ref st_tab_armo kst_tab_armo);//====================================================================
//=== Torna Q.ta' della Riga Lotto
//=== 
//=== Input : kst_tab_armo.id_armo 
//=== Ritorna st_esito :  come standard
//===					kst_tab_armo.colli_2 
//===					kst_tab_armo.pedane 
//===					kst_tab_armo.m_cubi 
//===					kst_tab_armo.peso_kg 
//===   
//====================================================================
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_armo.id_armo > 0 then

		SELECT 
					colli_2 
					,pedane 
					,m_cubi 
					,peso_kg 
				 INTO 
					:kst_tab_armo.colli_2 
					,:kst_tab_armo.pedane 
					,:kst_tab_armo.m_cubi 
					,:kst_tab_armo.peso_kg 
				 FROM armo  
				WHERE armo.id_armo = :kst_tab_armo.id_armo
					 using sqlca;
				
		if sqlca.sqlcode <> 0 then
			kst_tab_armo.id_meca = 0
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab. righe Lotto (armo) (id riga=" + string(kst_tab_armo.id_armo) + ") : " &
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
	end if
	
	if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
	if isnull(kst_tab_armo.pedane) then kst_tab_armo.pedane = 0
	if isnull(kst_tab_armo.m_cubi) then kst_tab_armo.m_cubi = 0
	if isnull(kst_tab_armo.peso_kg) then kst_tab_armo.peso_kg = 0

	
return kst_esito

end function

public function st_esito set_colli_fatt (st_tab_armo kst_tab_armo);//
//====================================================================
//=== Aggiorna campo COLLI_FATT 
//=== 
//=== Input: st_tab_armo     id_armo, colli_fatt
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	update ARMO
				set
					COLLI_FATT   = :kst_tab_armo.COLLI_FATT
				where ID_ARMO = :kst_tab_armo.ID_ARMO
			using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento colli fatt. in riga Lotto, ID: "+ string(kst_tab_armo.ID_ARMO) + "~n~r"  + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		if kst_tab_armo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
			kst_esito = kGuf_data_base.db_commit_1( )
		end if
	end if

			


return kst_esito

end function

public subroutine get_num_int (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna Numero e Data del Lotto da ID
//=== 
//=== Input : kst_tab_meca.id 
//=== Out: num_int data_int  
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select num_int
	        ,data_int
		into :kst_tab_meca.num_int
			,:kst_tab_meca.data_int
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_meca.num_int = 0
		kst_tab_meca.data_int = date(0)
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.inizializza( )
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
	end if
	
	

end subroutine

public subroutine get_clie (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna Madante/Ricevente/Fatturato del Lotto
//=== 
//=== Input : kst_tab_meca.id 
//=== Ritorna: kst_tab_meca.clie_1 / clie_2 / clie_3 
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca.clie_1 = 0
	kst_tab_meca.clie_2 = 0
	kst_tab_meca.clie_3 = 0

	if kst_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id Lotto, lettura anagrafiche sul Lotto non può essere eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	select clie_1
	        ,clie_2
	        ,clie_3
		into :kst_tab_meca.clie_1
			,:kst_tab_meca.clie_2
			,:kst_tab_meca.clie_3
		from meca 
		where meca.id = :kst_tab_meca.id
		using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura codici anagrafiche sul Lotto (id Lotto: " + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if isnull(kst_tab_meca.clie_1) then kst_tab_meca.clie_1 = 0
	if isnull(kst_tab_meca.clie_2) then kst_tab_meca.clie_2 = 0
	if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

end subroutine

public function st_esito get_colli_entrati_riga (ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Torna il nr colli entrati x RIGA LOTTO
//=== 
//=== Input : kst_tab_armo.id_armo 
//=== Ritorna st_esito :  come standard
//===					: kst_tab_armo.colli_2
//===   
//====================================================================

st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_armo.id_armo > 0 then
//--- conta il numero di colli entrati
	select sum(colli_2)
		into :kst_tab_armo.colli_2
		from armo 
		where armo.id_armo = :kst_tab_armo.id_armo
		using sqlca;
	
//--- se movimento non trovato, non so perchè ma non torna il 100 per cui lo forzo!	
	if isnull(kst_tab_armo.colli_2) then
		 sqlca.sqlcode = 100 
		 kst_tab_armo.colli_2 = 0
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_tab_armo.colli_2 = 0
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else			
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
		end if
	end if
else
	kst_tab_armo.colli_2 = 0
end if
	
return kst_esito

end function

public function st_esito set_colli_fatturati (st_tab_armo kst_tab_armo);//
//------------------------------------------------------------------------------------------------
//--- Aggiorna il numero colli FATTURATI
//--- 
//--- Input: st_tab_armo     id_armo
//---                        colli_fatt  da aggiungere/togliere (se NEG) da colli_fatt
//---
//--- Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//--- 
//------------------------------------------------------------------------------------------------
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_armo.id_armo > 0 then
	
	select colli_2
	       , colli_fatt
		into :kst_tab_armo.colli_2
		    , :kst_tab_armo.colli_1
	     from armo 
		WHERE armo.id_armo =  :kst_tab_armo.id_armo   
		using kguo_sqlca_db_magazzino;
					
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
		if kst_tab_armo.colli_1 > 0 then
			kst_tab_armo.colli_fatt = kst_tab_armo.colli_1 + kst_tab_armo.colli_fatt	
		end if
		if kst_tab_armo.colli_fatt < 0 or isnull( kst_tab_armo.colli_fatt) then
			 kst_tab_armo.colli_fatt = 0
		else
			if kst_tab_armo.colli_fatt > kst_tab_armo.colli_2 then
				kst_tab_armo.colli_fatt = kst_tab_armo.colli_2
			end if
		end if
		
		UPDATE armo  
			SET 	colli_fatt = :kst_tab_armo.colli_fatt
			WHERE armo.id_armo = :kst_tab_armo.id_armo   
			using kguo_sqlca_db_magazzino;
			
	end if					
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Tab.dati riga Lotto, ID:" + string(kst_tab_armo.ID_ARMO) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
			
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_armo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if
	else
		if kst_tab_armo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if
	end if
		
	
else
	kst_esito.SQLErrText = "Errore: aggiornamento Lotto del nr colli fatturati (ID-Lotto non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito get_ultimo_doc (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Torna l'ultimo Riferimento (Numero e Data) delle Anagrafiche impostate
//=== 
//=== Input : kst_tab_meca.clie_1  / clie_2 / clie_3
//=== Out: kst_tab_meca.num_int + data_int + id
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select	 
			max(num_int)
	        ,data_int
		into
			:kst_tab_meca.num_int
			,:kst_tab_meca.data_int
		from meca   
		where data_int in (
			select max(data_int)			
			from meca as m1 
			where 
				(m1.clie_1 = :kst_tab_meca.clie_1 
				or m1.clie_2 = :kst_tab_meca.clie_2 
				or m1.clie_3 = :kst_tab_meca.clie_3) 
				)
			and 
				(meca.clie_1 = :kst_tab_meca.clie_1 
				or meca.clie_2 = :kst_tab_meca.clie_2 
				or meca.clie_3 = :kst_tab_meca.clie_3) 
		group by data_int
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		select	 id 
		into :kst_tab_meca.id
		from meca   
		where data_int = :kst_tab_meca.data_int
				and num_int = :kst_tab_meca.num_int
		using kguo_sqlca_db_magazzino;
	end if	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_meca.num_int = 0
		kst_tab_meca.id = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function st_esito anteprima_testa (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti

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
		if kdw_anteprima.dataobject = "d_meca_1"  then
			if kdw_anteprima.rowcount() > 0  then
				if kdw_anteprima.object.id_meca[1] = kst_tab_meca.id  then
					kst_tab_meca.id = 0 
				end if
			else
				kst_tab_meca.id = 0 
			end if
		end if
	end if

	if kst_tab_meca.id > 0 then
	
			kdw_anteprima.dataobject = "d_meca_1"
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_meca.id)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Riferimento da visualizzare: ~n~r" + "nessun codice ID indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito get_ultimo_doc_ins (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Torna l'ultimo Riferimento Caricato (Numero e Data) delle Anagrafiche impostate o Assoluto!
//=== 
//=== Input : kst_tab_meca.clie_1  / clie_2 / clie_3 oppure tutti a zero per l'ultimo caricato
//=== Out: kst_tab_meca.num_int + data_int + id
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if isnull(kst_tab_meca.clie_1) then kst_tab_meca.clie_1 = 0 
	if isnull(kst_tab_meca.clie_2) then kst_tab_meca.clie_2 = 0 
	if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0 

//--- conta il numero di colli entrati
	if kst_tab_meca.clie_1 > 0 or kst_tab_meca.clie_2 > 0 or kst_tab_meca.clie_3 > 0 then

		select	 id 
				,num_int
				  ,data_int
			into
				:kst_tab_meca.id
				,:kst_tab_meca.num_int
				,:kst_tab_meca.data_int
			from meca   
			where id in (
				select max(id)			
				from meca 
				where 
					(clie_1 = :kst_tab_meca.clie_1 
					or clie_2 = :kst_tab_meca.clie_2 
					or clie_3 = :kst_tab_meca.clie_3) 
					and num_int in (
						select max(num_int)			
						from meca 
						where 
							(clie_1 = :kst_tab_meca.clie_1 
							or clie_2 = :kst_tab_meca.clie_2 
							or clie_3 = :kst_tab_meca.clie_3) 
							and data_int in (
								select max(data_int)			
								from meca 
								where 
									(clie_1 = :kst_tab_meca.clie_1 
									or clie_2 = :kst_tab_meca.clie_2 
									or clie_3 = :kst_tab_meca.clie_3) 
					)))
			using kguo_sqlca_db_magazzino;
	else
		select	 id 
				,num_int
				  ,data_int
			into
				:kst_tab_meca.id
				,:kst_tab_meca.num_int
				,:kst_tab_meca.data_int
			from meca   
			where id in (
					select max(id)			
						from meca 
					where num_int in (
						select max(num_int)			
							from meca   
							where data_int in (
								select max(data_int)			
									from meca ) ) )
			using kguo_sqlca_db_magazzino;

	
	end if			
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_meca.num_int = 0
		kst_tab_meca.id = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function st_esito get_consegna_data (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Torna il codice CONSEGNA_DATA del Lotto 
//=== 
//=== 
//===  input: kst_tab_meca.id  
//===  Outout: consegna_data
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT consegna_data
			 INTO 
					:kst_tab_meca.consegna_data
			 FROM meca 
			WHERE meca.id = :kst_tab_meca.id 
				 using sqlca;
			

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lotto non Trovato durante lettura 'Data di Consegna' (" + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(SQLCA.SQLErrText)
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

public subroutine set_num_int (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta ultimo Numero Lotto sul BASE
//=== 
//=== Input : kst_tab_meca.num_int
//=== Ritorna: boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
string k_esito
st_tab_meca kst_tab_meca_appo
st_esito kst_esito
st_tab_base kst_tab_base
kuf_base kuf1_base


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_base = create kuf_base

	k_esito = kuf1_base.prendi_dato_base( "num_int")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in accesso archivio BASE (get 'NUM_INT'), esito:  " + trim(k_esito)
		kGuo_exception.set_esito( kst_esito )
		throw  kGuo_exception
	else
		kst_tab_meca_appo.num_int	= long(mid(k_esito,2))
	end if

//--- Se il numero a' maggiore lo imposto altrimenti nisba
	if kst_tab_meca.num_int > kst_tab_meca_appo.num_int	 then
		kst_tab_base.st_tab_g_0.esegui_commit = kst_tab_meca.st_tab_g_0.esegui_commit
		kst_tab_base.key = "num_int"
		kst_tab_base.key1 = string(kst_tab_meca.num_int)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Errore in Scrittura archivio BASE (set 'NUM_INT'), esito:  " + trim(k_esito)
			kGuo_exception.set_esito( kst_esito )
			throw  kGuo_exception
		end if
		
	end if
	
	destroy kuf1_base

end subroutine

public function st_esito get_id_meca_da_data (ref st_tab_armo kst_tab_armo);//
//====================================================================
//=== Torna il ID MECA piu' basso x la data indicata
//=== 
//=== 
//===  input: data_int 
//===  Outout: ID_MECA
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
st_esito kst_esito
st_tab_armo kst_tab_armo_appo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- provo a calcolare un range di 7 giorni
	kst_tab_armo_appo.data_int = relativedate(kst_tab_armo.data_int, +7)

	kst_tab_armo.id_meca = 0
	SELECT min(id)
			 INTO 
					:kst_tab_armo.id_meca 
			 FROM meca  
			WHERE data_int between :kst_tab_armo.data_int and :kst_tab_armo_appo.data_int
				 using sqlca;
				 
//--- se non trovo nulla provo con un range di 14 giorni
	if sqlca.sqlcode = 100 or isnull(kst_tab_armo.id_meca)  or kst_tab_armo.id_meca = 0 then
		kst_tab_armo_appo.data_int = relativedate(kst_tab_armo.data_int, +14)
		SELECT min(id)
			 INTO 
					:kst_tab_armo.id_meca 
			 FROM meca  
			WHERE data_int between :kst_tab_armo.data_int and :kst_tab_armo_appo.data_int
				 using sqlca;
				 
//--- va be' allora provo a cercare su tutto!				 
		if sqlca.sqlcode = 100 or isnull(kst_tab_armo.id_meca)  or kst_tab_armo.id_meca = 0 then
			SELECT min(id)
				 INTO 
						:kst_tab_armo.id_meca 
				 FROM meca  
				WHERE data_int > :kst_tab_armo.data_int
					 using sqlca;
		end if

	end if

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Testata Riferimento ricerca ID x data= " + string(kst_tab_armo.data_int) &
									  + "   ~n~r"  &
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

public function st_esito anteprima_a_righe (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti

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
//		if kdw_anteprima.dataobject = "d_stat_produz_dettaglio" then //"d_meca_1"  then
//			if kdw_anteprima.object.id_meca[1] = kst_tab_meca.id  then
				kdw_anteprima.dataobject = "d_meca_1_anteprima"		
//			end if
//		else
//			kdw_anteprima.dataobject = "d_stat_produz_dettaglio"	
//			kdw_anteprima.modify("DataWindow.Tree.Level.1.CollapsedTreeNodeIconName='" + string(kGuo_path.get_risorse() + "\cartella.ico") + "' ")
//			kdw_anteprima.modify("DataWindow.Tree.Level.operazione.ExpandedTreeNodeIconName='" + string(kGuo_path.get_risorse() + "\cartella_open.ico") + "' ")
//		end if
	else
		kdw_anteprima.dataobject = "d_stat_produz_dettaglio"		
		kdw_anteprima.modify("DataWindow.Tree.Level.1.CollapsedTreeNodeIconName='" + string(kGuo_path.get_risorse() + "\cartella.ico") + "' ")
		kdw_anteprima.modify("DataWindow.Tree.Level.operazione.ExpandedTreeNodeIconName='" + string(kGuo_path.get_risorse() + "\cartella_open.ico") + "' ")
	end if

	if kst_tab_meca.id > 0 then
	
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_meca.id)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Riferimento da visualizzare: ~n~r" + "nessun codice ID indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function boolean if_esiste (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se Riferimento Esiste x ID o NUM/DATA
//=== 
//=== Inp: id oppure num/data_int
//=== Out: id (sempre)
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//====================================================================
boolean k_return
st_esito kst_esito
long k_id_meca
int k_ctr


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_meca.id > 0 then
	select id
		into :k_id_meca
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
		
else
	if kst_tab_meca.num_int > 0 then

		select id
			into :k_id_meca
			from meca 
			where meca.num_int = :kst_tab_meca.num_int 
					and year(data_int) = year(:kst_tab_meca.data_int)
			using kguo_sqlca_db_magazzino;
		
	end if
end if

if kst_tab_meca.id > 0 or kst_tab_meca.num_int > 0 then
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if k_id_meca > 0 then
			kst_tab_meca.id = k_id_meca
		end if
		k_return = true
		
	else
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			k_return = false
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
end if
	
	
return k_return


end function

public function boolean set_num_data_int (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta Numero/Data Lotto su le tabelle 
//=== 
//=== Input : kst_tab_meca.num_int, data_int, ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_tab_meca kst_tab_meca_appo
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


if kst_tab_meca.id > 0 then

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

//--- aggiorna le righe dei BARCODE
	kuf1_barcode = create kuf_barcode
	kst_tab_barcode.id_meca = kst_tab_meca.id
	kst_tab_barcode.num_int =	kst_tab_meca.num_int
	kst_tab_barcode.data_int =	kst_tab_meca.data_int
	kst_tab_barcode.st_tab_g_0.esegui_commit = kst_tab_meca.st_tab_g_0.esegui_commit
	kst_esito = kuf1_barcode.set_num_data_int(kst_tab_barcode)
	destroy kuf1_barcode
	
	if kst_esito.esito = kkg_esito.ok or  kst_esito.esito = kkg_esito.not_fnd or  kst_esito.esito = kkg_esito.db_wrn then

//--- aggiorna le righe del lotto
		update armo
				set NUM_INT = :kst_tab_meca.num_int
					, DATA_INT = :kst_tab_meca.data_int
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID_MECA = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			
//--- aggiorna la testa del lotto
			update meca
				set NUM_INT = :kst_tab_meca.num_int
				, DATA_INT = :kst_tab_meca.data_int
					,x_datins = :kst_tab_meca.x_datins
					,x_datins = :kst_tab_meca.x_datins
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
			
		end if
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornamento Lotto ('NUM_INT'), ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		end if
		
	end if

//--- c'e' stato un errore grave?
	if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.not_fnd and  kst_esito.esito <> kkg_esito.db_wrn then
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		throw  kGuo_exception
	end if

//--- se arriva qui tutto OK	
	k_return = true
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
end if


return k_return

end function

private function st_esito set_stato_in_attenzione (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Imposta il campo stato in attenzione 
//=== 
//=== Input: st_tab_meca     id, stato_in_attenzione
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if isnull(kst_tab_meca.stato_in_attenzione) then kst_tab_meca.stato_in_attenzione = 0

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	update MECA
				set
					stato_in_attenzione   = :kst_tab_meca.stato_in_attenzione
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Stato 'in Attenzione' nel Lotto con ID: " + string(kst_tab_meca.ID) + "~n~r"   + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

			


return kst_esito

end function

public function st_esito set_stato_in_attenzione_off (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Spegne il flag stato in attenzione 
//=== 
//=== Input: st_tab_meca     id
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_tab_meca.stato_in_attenzione = 0

kst_esito = set_stato_in_attenzione(kst_tab_meca)			


return kst_esito

end function

public function st_esito set_stato_in_attenzione_on (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Accende il flag stato in attenzione 
//=== 
//=== Input: st_tab_meca     id
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_tab_meca.stato_in_attenzione = 1

kst_esito = set_stato_in_attenzione(kst_tab_meca)			


return kst_esito

end function

private function st_esito get_stato_in_attenzione (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Piglia il campo stato in attenzione 
//=== 
//=== Inp: st_tab_meca     id
//=== Out: st_tab_meca 	stato_in_attenzione
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select stato_in_attenzione
			into :kst_tab_meca.stato_in_attenzione
			from MECA
				where ID = :kst_tab_meca.ID
			using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Stato 'in Attenzione' nel Lotto con ID: " + string(kst_tab_meca.ID) + "~n~r"   + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if

	if isnull(kst_tab_meca.stato_in_attenzione) then kst_tab_meca.stato_in_attenzione = 0

return kst_esito

end function

public function st_esito set_stato_in_attenzione_cambia (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Accende o Spegne il flag stato in attenzione 
//=== 
//=== Input: st_tab_meca     id
//===                                  
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- piglia lo stato attuale
kst_esito = get_stato_in_attenzione(kst_tab_meca)			

if kst_esito.esito = kkg_esito.ok then

//--- se spento lo accende e viceversa
	if kst_tab_meca.stato_in_attenzione = kki_stato_in_attenzione_on then
		kst_tab_meca.stato_in_attenzione = kki_stato_in_attenzione_off
	else
		kst_tab_meca.stato_in_attenzione = kki_stato_in_attenzione_on
	end if
//--- aggiorna lo stato in archivio
	kst_esito = set_stato_in_attenzione(kst_tab_meca)			
	
end if


return kst_esito

end function

public function st_esito get_lotto_rich_autorizz (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Get dato "RICH_AUTORIZZ" da meca_causali x fare la verifica
//=== 
//=== Ritorna st_esito : OK=completato;
//===                  : come standard
//===   
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.blok  //inizializza con esito NEGATIVO Colli ancora da Trattare
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()



	select rich_autorizz
		into :kst_tab_meca.meca_blk_rich_autorizz
		from meca_blk
		where id_meca = :kst_tab_meca.id
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if
		kst_esito.SQLErrText = "Errore in letttura Causale del Lotto (maca_causali)~n~r" + trim(sqlca.SQLErrText) 
		kst_esito.sqlcode = sqlca.sqlcode
	end if

	if isnull(kst_tab_meca.meca_blk_rich_autorizz) then kst_tab_meca.meca_blk_rich_autorizz = ""


	
return kst_esito

end function

public function boolean if_lotto_rich_autorizz_ok (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== L'utente è autorizzato a sbloccare il lotto? 
//=== 
//=== Ritorna st_esito : TRUE=autorizzato
//===   
//====================================================================
boolean k_return = true
st_esito kst_esito
st_open_w kst_open_w
kuf_meca_causali_blk_m kuf1_meca_causali_blk_m
kuf_sicurezza kuf1_sicurezza


//--- legge dal lotto se Rich.Auttorizz. 	
	kst_esito = get_lotto_rich_autorizz(kst_tab_meca)

	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_meca_causali_blk_m = create kuf_meca_causali_blk_m 
	if kst_tab_meca.meca_blk_rich_autorizz = kuf1_meca_causali_blk_m.ki_rich_autorizz_materiale_medicale then
		
//--- legge se funzione Autorizzata
	   	kst_open_w.id_programma = kuf1_meca_causali_blk_m.get_id_programma( kkg_flag_modalita.interrogazione )
	   	kst_open_w.flag_modalita = kkg_flag_modalita.interrogazione

		kuf1_sicurezza = create kuf_sicurezza
		k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		destroy kuf1_sicurezza

		
	end if
	destroy kuf1_meca_causali_blk_m

	
return k_return


end function

public function boolean consenti_sblocco_meca_non_conforme (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Richiesta se Riferimento NON-CONFORME e' possibile fare Sblocco/Blocco dello Stato 
//---                inoltre controlla se la Causale di blocco richiede Autorizzazione Speciale
//--- 
//--- Argomenti: st_meca   riempire il ID del Riferimento
//--- Out: boolean   TRUE=ok consenti sblocco del Lotto
//---
//--- Lancia Expetpion con Esito (st_esito) come da Standard
//---
//---
boolean k_return=false
boolean k_autorizza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

kuf_sl_pt kuf1_sl_pt

st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_sblocca_non_conforme

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Aggiornamento Riferimento non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- leggo archivi se lotto Bloccato/Sbloccato allora posso compiere l'operazione
	SELECT meca.stato
				into
               :kst_tab_meca.stato
			 FROM meca  
			 where id = :kst_tab_meca.id  
				 using sqlca;
		
	if sqlca.sqlcode = 0 then
		
    		if kst_tab_meca.stato = ki_meca_stato_blk or kst_tab_meca.stato = ki_meca_stato_sblk then
				
//--- controlla se il x questo Lotto c'e'  "Richiesta Autorizzazione Particolare" (es Mat medicale)		
			if if_lotto_rich_autorizz_ok( kst_tab_meca ) then
				k_return = true
			end if
//			kst_esito.esito = kkg_esito.ok
//		else
//			kst_esito.esito = kkg_esito.blok
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Tab.Testata Lotto MECA (id="  + string(kst_tab_meca.id) + " "  + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
end if



return k_return
end function

public function boolean set_id_wm_pklist (st_tab_meca kst_tab_meca);//
//====================================================================
//=== Imposta  campo  ID_WM_PKLIST (id del packing-list WMF)
//=== 
//=== Input: st_tab_meca.id, id_wm_pklist
//=== out: TRUE = ok                                 
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
boolean k_return = false
st_esito kst_esito
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_meca.id > 0 then
	
	update MECA
				set
					id_wm_pklist   = :kst_tab_meca.id_wm_pklist
				where id = :kst_tab_meca.ID
			using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento cod. Packing-List (ID_WM_PKLIST) su Lotto, ID: "+ string(kst_tab_meca.ID) + "~n~r"  + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		if sqlca.sqlcode < 0 then
	
			if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
	
		end if
		
	end if
		
	//---- COMMIT....	
	if sqlca.sqlcode = 0 then
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kst_esito = kGuf_data_base.db_commit_1( )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
			end if
		end if
	end if

	 k_return=true

end if
		


return k_return

end function

public function boolean set_data_fine_lav (st_tab_meca kst_tab_meca) throws uo_exception;//
//=== 
//=== Sistema alcuni dati in tabella MECA (data_fine_lav)
//=== input: st_tab_meca.id
//===   
//
boolean k_return = false
st_tab_armo kst_tab_armo, kst_tab_armo_in, kst_tab_armo_no_trattare, kst_tab_armo_trattati
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
uo_exception kuo1_exception
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_barcode = create kuf_barcode

//--- 
	kst_tab_armo.id_meca = kst_tab_meca.id
	kst_tab_barcode.id_meca = kst_tab_meca.id

//--- colli entrati da trattare
	//kst_tab_armo_in = kst_tab_armo
	kst_tab_armo_in.colli_2 =  kuf1_barcode.get_nr_barcode(kst_tab_barcode) //get_colli_entrati_datrattare(kst_tab_armo_in)

	if kst_tab_armo_in.colli_2 > 0 then

//--- colli da non trattare
		//kst_tab_armo_no_trattare = kst_tab_armo
		kst_tab_armo_no_trattare.colli_2 = kuf1_barcode.get_nr_barcode_da_non_trattare(kst_tab_barcode) //get_colli_danontrattare(kst_tab_armo_no_trattare)
	
//--- colli trattati
		//kst_tab_armo_trattati = kst_tab_armo
		kst_tab_armo_trattati.colli_2 = kuf1_barcode.get_nr_barcode_trattati(kst_tab_barcode)  //get_colli_trattati(kst_tab_armo_trattati)	
	
//--- aggiorna data di fine lavoro se tutti colli trattati
		
//--- data fine trattamento		
		kst_tab_meca.data_lav_fin = date(0)
		if kst_tab_armo_trattati.colli_2 >= (kst_tab_armo_in.colli_2 - kst_tab_armo_no_trattare.colli_2) then 
			kst_tab_barcode.id_meca = kst_tab_armo.id_meca
			kst_tab_meca.data_lav_fin = kuf1_barcode.get_data_lav_fin(kst_tab_barcode)
		end if
		tb_update_data_lav_fin(kst_tab_meca)  // AGGIORNA FINE LAVORAZIONE
		
	end if

//--- lancia exception?
	if kst_esito.esito <> kkg_esito.ok then
		kuo1_exception.set_esito(kst_esito) 
		throw kuo1_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode

end try

return k_return


end function

public subroutine get_dati_rid (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Torna alcuni dati di Testata Lotto  da ID  come Numero e Data del Lotto ecc...
//--- 
//--- Input : st_tab_meca.id 
//--- out: alcuni dati nella st_tab_meca
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select num_int
	         ,data_int
	         ,data_ent
			,clie_1	   
			,clie_2	  
			,clie_3	  
		into :kst_tab_meca.num_int
			,:kst_tab_meca.data_int
			,:kst_tab_meca.data_ent
			,:kst_tab_meca.clie_1
			,:kst_tab_meca.clie_2
			,:kst_tab_meca.clie_3
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_meca.num_int = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Lotto per dati ridotti~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
	

end subroutine

public subroutine get_clie_listino (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il cliente del Listino (probabile Fatturato) per un certo Lotto
//=== 
//=== Input : kst_tab_meca.id 
//=== Ritorna: kst_tab_meca.clie_3
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

if kst_tab_meca.id > 0 then
	
	select max(listino.cod_cli)
		into
			:kst_tab_meca.clie_3
		from armo inner join listino on armo.id_listino = listino.id 
		where armo.id_meca = :kst_tab_meca.id
		         and listino.cod_cli > 0
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_meca.clie_3 = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
	end if
	
	if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0
	
else
	kst_tab_meca.clie_3 = 0
end if

	

end subroutine

public subroutine get_err_lav (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- get campi ERR_LAV_OK / ERR_LAV_FIN
//--- 
//--- Input : st_tab_meca.id 
//--- out: st_tab_meca.err_lav_ok
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito

	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select err_lav_ok
			,err_lav_fin
		into :kst_tab_meca.err_lav_ok
			,:kst_tab_meca.err_lav_fin
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_meca.err_lav_ok = ""
		kst_tab_meca.err_lav_fin = ""
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dati di Convalida. " + trim(sqlca.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw  kguo_exception
		end if
	end if
	
	

end subroutine

public function boolean if_lotto_completo (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Controllo se Riferimento ha completato il trattamento dei lotti
//=== 
//=== Ritorna: TRUE=trattamento  completato;
//===          :  FALSE=non completato
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
date k_data_0=date(0)
long k_conta_barcode_lav, k_conta_colli_no_barcode
long k_conta_barcode_da_non_trattare
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select sum(colli_2)
		into :kst_tab_armo.colli_2
		from armo 
		where armo.id_meca = :kst_tab_armo.id_meca
		      and armo.magazzino <> 1 and armo.dose > 0 and armo.cod_sl_pt <> ''
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		kuf1_barcode = create kuf_barcode

		if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
		
//--- conta il numero colli lavorati + da-non-lavorare (magazzino con BARCODE)
		kst_tab_barcode.id_meca = kst_tab_armo.id_meca
		k_conta_barcode_lav = kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode)
		kst_tab_barcode.id_meca = kst_tab_armo.id_meca
		k_conta_barcode_da_non_trattare = kuf1_barcode.get_nr_barcode_da_non_trattare(kst_tab_barcode)

		if (k_conta_barcode_lav + k_conta_barcode_da_non_trattare)  >= kst_tab_armo.colli_2 then
			k_return = true
		else
			
////--- se non torna il conto aggiungo il numero colli magazzino SENZA BARCODE (magazzino=1)
//			k_conta_colli_no_barcode = get_nr_colli_magazzino_no_barcode(kst_tab_armo)
//			if (k_conta_colli_no_barcode + k_conta_barcode_lav + k_conta_barcode_da_non_trattare)  >= kst_tab_armo.colli_2 then
//				k_return = true
//			end if
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura colli Lotto id=" + string(kst_tab_armo.id_meca) + ": " + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try
	
	
return k_return 

end function

public function boolean get_magazzino (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Legge 'magazzino' associato al movimento di entrata
//=== 
//=== 
//===  input: st_tab_armo.id_armo 
//===  Out: st_tab_armo.magazzino
//===  Rit.: TRUE=movimento trovato
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	 
	 
	SELECT magazzino
			 INTO 
					:kst_tab_armo.magazzino
			 FROM armo
			WHERE id_armo = :kst_tab_armo.id_armo
				 using kguo_sqlca_db_magazzino ;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.dettaglio Lotto (id " + string(kst_tab_armo.id_armo) + ") " &
									 + "~n~r"  + trim(SQLCA.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	if isnull(kst_tab_armo.magazzino) then kst_tab_armo.magazzino = 0



return k_return

end function

public function integer get_nr_colli_magazzino_no_barcode (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Legge Nr colli x lotto associati a un magazzino SENZA barcode 
//=== 
//=== 
//===  input: st_tab_armo.id_meca 
//===  Out: --
//===  Rit.: Nr colli
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
integer k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	 
	 
	SELECT sum(colli_2)
			 INTO :kst_tab_armo.colli_2
			 FROM armo
			WHERE id_meca = :kst_tab_armo.id_meca
			           and magazzino = 1
				 using kguo_sqlca_db_magazzino ;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.dettaglio Lotto (id " + string(kst_tab_armo.id_meca) + ") " &
									 + "~n~r"  + trim(SQLCA.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
	
	k_return = kst_tab_armo.colli_2
	

return k_return

end function

public function long get_colli_fatturati (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il nr colli gia' Fatturati
//=== 
//=== Input : kst_tab_armo.id_armo 
//=== Ritorna	kst_tab_armo.colli_2 = colli Fatturati
//===   
//====================================================================

st_esito kst_esito
st_tab_arfa kst_tab_arfa
kuf_sicurezza kuf1_sicurezza
kuf_fatt kuf1_fatt

 
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	kuf1_fatt = create kuf_fatt

	kst_tab_armo.colli_2 = 0
	kst_tab_arfa.id_armo = kst_tab_armo.id_armo
	kst_tab_armo.colli_2 = kuf1_fatt.get_colli_fatturati_x_id_armo(kst_tab_arfa)
	
	if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	  
end try

return kst_tab_armo.colli_2

end function

public function boolean get_id_listino (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Legge 'ID_LISTINO' associato alla riga entrata
//=== 
//=== 
//===  input: st_tab_armo.id_armo 
//===  Out: st_tab_armo.id_listino
//===  Rit.: TRUE=movimento trovato
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
boolean k_return=false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	SELECT id_listino
			 INTO 
					:kst_tab_armo.id_listino
			 FROM armo
			WHERE id_armo = :kst_tab_armo.id_armo
				 using kguo_sqlca_db_magazzino ;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura id listino da riga Lotto (id=" + string(kst_tab_armo.id_armo) + ") " &
									 + "~n~r"  + trim(SQLCA.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	if isnull(kst_tab_armo.id_listino) then kst_tab_armo.id_listino = 0

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function long get_colli_in_giacenza (readonly st_tab_armo ast_tab_armo) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Torna il nr colli in giacenza
//--- 
//--- Inp: st_tab_armo.id_armo 
//--- Out: long dei colli in giacenza quindi scaricabili
//---
//--- Lancia EXCEPTION  
//---
//------------------------------------------------------------------------------------------------
//
long k_colli=0
st_esito kst_esito

	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta colli entrati meno il numero di colli spediti o scaricati
	select  
			  armo.colli_2 - coalesce(v_arsp_colli_x_id_armo.colli,0) - coalesce(v_armo_out_colli.colli,0)    
	  	into :k_colli
		from armo left outer join v_arsp_colli_x_id_armo  on armo.id_armo = v_arsp_colli_x_id_armo.id_armo 
			           left outer join v_armo_out_colli  on armo.id_armo = v_armo_out_colli.id_armo 
		where armo.id_armo = :ast_tab_armo.id_armo
		using kguo_sqlca_db_magazzino;
	
	
	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if isnull(k_colli) then k_colli = 0
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante calcolo nr. COLLI in giacenza. ID riga lotto: " + string(ast_tab_armo.id_armo) + ". Errore: " + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
return k_colli

end function

public function long get_colli_in_giacenza_x_id_meca (readonly st_tab_armo ast_tab_armo) throws uo_exception;//------------------------------------------------------------------------------------------------
//--- Torna il nr colli in giacenza x Lotto
//--- 
//--- Inp: st_tab_armo.id_meca
//--- Out: long dei colli in giacenza quindi scaricabili
//---
//--- Lancia EXCEPTION  
//---
//------------------------------------------------------------------------------------------------
//
long k_colli=0
st_tab_armo kst_tab_armo
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	declare c_get_colli_in_giacenza_x_id_meca cursor for    
	   select distinct id_armo 
		    from armo
			where id_meca = :kst_tab_armo.id_meca 
		using kguo_sqlca_db_magazzino;
			
	open c_get_colli_in_giacenza_x_id_meca ;
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		fetch c_get_colli_in_giacenza_x_id_meca into :kst_tab_armo.id_armo;
		
		do while kguo_sqlca_db_magazzino.sqlcode = 0 
	
			k_colli+=get_colli_in_giacenza(kst_tab_armo) // piglio i colli in giacenza x la singola riga
			fetch c_get_colli_in_giacenza_x_id_meca into :kst_tab_armo.id_armo;
			
		loop
		if kguo_sqlca_db_magazzino.sqlcode >= 0 then
			if isnull(k_colli) then k_colli = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in calcolo nr. COLLI in giacenza. ID riga lotto: " + string(ast_tab_armo.id_armo) + ". Errore: " + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		

		close c_get_colli_in_giacenza_x_id_meca;
	end if
	
	
	
return k_colli

end function

public function st_esito get_id_listino (ref st_tab_armo kst_tab_armo, st_tab_meca kst_tab_meca);//
//====================================================================
//=== QUESTA FUNZIONE OBSOLETA E' RIMASTA XCHE' CI SONO RIGHE CARICATE ANCORA SENZA PREZZO
//=== Legge ID_LISTINO del Movimento
//=== 
//=== 
//===  input: st_tab_armo.id_armo e st_tab_meca.clie_3
//===  Outout: st_tab_armo.id_listino
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
int k_anno
st_esito kst_esito
st_tab_listino kst_tab_listino
kuf_listino kuf1_listino

   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()

   kst_tab_armo.id_listino  = 0

    
// SELECT meca.clie_3
//          ,armo.art
//          ,armo.dose
//          ,armo.larg_2
//          ,armo.lung_2
//          ,armo.alt_2
//        INTO 
//             :kst_tab_meca.clie_3 
//             ,:kst_tab_armo.art 
//             ,:kst_tab_armo.dose 
//             ,:kst_tab_armo.larg_2 
//             ,:kst_tab_armo.lung_2 
//             ,:kst_tab_armo.alt_2 
//        FROM armo inner join meca on armo.id_meca = meca.id   
   SELECT 
            armo.art
            ,armo.dose
            ,armo.larg_2
            ,armo.lung_2
            ,armo.alt_2
            ,armo.id_listino
          INTO 
               :kst_tab_armo.art 
               ,:kst_tab_armo.dose 
               ,:kst_tab_armo.larg_2 
               ,:kst_tab_armo.lung_2 
               ,:kst_tab_armo.alt_2 
               ,:kst_tab_armo.id_listino 
          FROM armo 
         WHERE id_armo = :kst_tab_armo.id_armo
             using sqlca;
         
   if sqlca.sqlcode <> 0 then
      kst_esito.sqlcode = sqlca.sqlcode
      kst_esito.SQLErrText = "Tab.Testata Riferimento (num=" + string(kst_tab_armo.num_int) &
                             +" anno=" + string(k_anno) + ") " &
                            + "~n~r"  + trim(SQLCA.SQLErrText)
      if sqlca.sqlcode = 100 then
         kst_esito.esito = kkg_esito.not_fnd
      else
         if sqlca.sqlcode < 0 then
            kst_esito.esito = kkg_esito.db_ko
         end if
      end if
   else
      
//--- Ci possono essere Articoli entrati senza dose che non hanno prezzo per cui lo cerco nel modo 'tradizionale'    
      if kst_tab_meca.clie_3 > 0 and (kst_tab_armo.id_listino = 0 or isnull( kst_tab_armo.id_listino) ) then

         kst_tab_listino.COD_CLI = kst_tab_meca.clie_3 
         kst_tab_listino.COD_ART = kst_tab_armo.art 
         kst_tab_listino.DOSE = kst_tab_armo.dose 
         kst_tab_listino.MIS_Z = kst_tab_armo.larg_2
         kst_tab_listino.MIS_X = kst_tab_armo.lung_2
         kst_tab_listino.MIS_Y = kst_tab_armo.alt_2
         
         kuf1_listino = create kuf_listino
         kst_esito = kuf1_listino.get_id_listino(kst_tab_listino)
         if kst_esito.esito <> kkg_esito.db_ko then
            kst_tab_armo.id_listino = kst_tab_listino.id
         end if
         destroy kuf1_listino
      end if
   end if



return kst_esito

end function

public function boolean set_lotto_chiudi (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Chiude il Lotto 
//=== 
//=== Input : st_tab_meca.ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false


try

	if ast_tab_meca.id > 0 then

		if if_sicurezza(kkg_flag_modalita.modifica) then
	
			k_return = set_lotto_chiudi_ok(ast_tab_meca) 

		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

private function boolean set_aperto (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//----------------------------------------------------------------------
//--- Aggiorna flag APERTO nel Lotto 
//--- 
//--- Per default setta lotto APERTO SI
//---
//--- Input : st_tab_meca.ID  ,  aperto
//--- boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//----------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Lotto, indicatore 'APERTO' a " + trim(ast_tab_meca.aperto) + ", manca ID Lotto. "
		kguo_exception.inizializza( )			
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if trim(ast_tab_meca.aperto) > " " then
	else
		ast_tab_meca.aperto = kki_meca_aperto_SI
	end if
		
//--- aggiorna le righe del lotto
	update meca
				set aperto = :ast_tab_meca.aperto
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :ast_tab_meca.ID
			using kguo_sqlca_db_magazzino;

		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Lotto, indicatrore 'APERTO' a " + trim(ast_tab_meca.aperto) + ", ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kguo_exception.inizializza( )			
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lotto non trovato durante aggiornamento indicatore 'APERTO' come " + trim(ast_tab_meca.aperto) + ", ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kguo_exception.inizializza( )			
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if

//--- se arriva qui tutto OK	
	k_return = true


catch (uo_exception kuo_exception)
	k_return = false
//--- c'e' stato un errore grave?
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
		end if
			
		throw  kuo_exception
	end if
	
finally
		
end try


return k_return

end function

public function boolean set_lotto_apri (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Apre/Riapre il Lotto 
//=== 
//=== Input : st_tab_meca.ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then

		if if_sicurezza(kkg_flag_modalita.modifica) then
	
			kst_tab_meca.id = ast_tab_meca.id
			if if_lotto_chiuso(kst_tab_meca) then
				kst_tab_meca.aperto = kki_meca_aperto_riaperto
			else
				kst_tab_meca.aperto = kki_meca_aperto_si
			end if
			k_return = set_aperto(kst_tab_meca)

		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

public function boolean if_esiste_blk (readonly st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se esiste BLOCCO del Riferimento x ID 
//=== 
//=== Inp: id 
//=== Out:
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE;
//===   
//====================================================================
boolean k_return=false
st_tab_meca kst_tab_meca
st_esito kst_esito


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_meca.id > 0 then
	select id_meca
		into :kst_tab_meca.id
		from meca_blk 
		where meca_blk.id_meca = :ast_tab_meca.id
		using sqlca;

	if sqlca.sqlcode = 0 then

		k_return = true
		
	else
		if sqlca.sqlcode > 0 then
			k_return = false
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore lettura Blocco del Lotto id: " + string(ast_tab_meca.id) + sqlca.sqlerrtext
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito( kst_esito )
			throw kGuo_exception
		end if
	end if
end if
	
	
return k_return


end function

public function st_esito get_id_meca (ref st_tab_meca kst_tab_meca);//
//====================================================================
//=== Legge MECA 
//=== 
//=== 
//===  input: num_int e anno (in data_int)  es. '01.01.2007'
//===  Outout: ID_MECA
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
int k_anno
st_tab_armo kst_tab_armo
st_esito kst_esito


	kst_tab_armo.num_int = kst_tab_meca.num_int
	kst_tab_armo.data_int = kst_tab_meca.data_int

	kst_esito = get_id_meca(kst_tab_armo)

	kst_tab_meca.data_int = kst_tab_armo.data_int
	kst_tab_meca.id = kst_tab_armo.id_meca

return kst_esito

end function

public function st_esito anteprima_elenco_memo (datastore kdw_anteprima, st_tab_meca kst_tab_meca);//
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

	if kst_tab_meca.id > 0 then

		kdw_anteprima.dataobject = "d_meca_memo_l"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_meca.id)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun 'MEMO' da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function string get_art (ref st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il codice ARTICOLO della riga del Lotto 
//=== 
//=== 
//===  input: st_tab_armo.id_armo
//===  Rit: ART
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===   x errore lancia: uo_exception                                  
//====================================================================
//
string k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT art
			 INTO 
					:ast_tab_armo.art
			 FROM armo
			WHERE armo.id_armo = :ast_tab_armo.id_armo 
				 using kguo_sqlca_db_magazzino;
			
	if isnull(ast_tab_armo.art) then
		ast_tab_armo.art = ""
	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura 'codice Articolo' in tab Riga Lotto  (armo id=" + string(ast_tab_armo.id_armo) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_return = trim(ast_tab_armo.art)

return k_return


end function

public function boolean if_da_trattare (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Controllo se Riga Lotto da Trattare
//=== 
//=== Input: st_tab_armo.id_armo 
//=== Ritorna: TRUE=da trattare;
//===      : FALSE=da non trattare
//===   
//====================================================================
boolean k_return = false
st_tab_meca kst_tab_meca
st_tab_meca_causali kst_tab_meca_causali
st_esito kst_esito
kuf_ausiliari kuf1_ausiliari


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select magazzino
		into :kst_tab_armo.magazzino
		from armo 
		where armo.id_armo = :kst_tab_armo.id_armo
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if kst_tab_armo.magazzino = kki_magazzino_datrattare then
			
//--- Lotto con causale da NON TRATTARE?
			if kst_tab_armo.id_meca > 0 then
			else
				kst_esito = get_id_meca_da_id_armo(kst_tab_armo)
			end if
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_meca.id = kst_tab_armo.id_meca
				get_causale(kst_tab_meca)
				if kst_tab_meca.id_meca_causale > 0 then
					kuf1_ausiliari = create kuf_ausiliari
					kst_tab_meca_causali.id_meca_causale = kst_tab_meca.id_meca_causale 
					kuf1_ausiliari.tb_select(kst_tab_meca_causali)
					if kst_tab_meca_causali.flag_ddt_si = kuf1_ausiliari.kki_meca_causale_flag_ddt_si then // lotto da restituire non trattato
					else
						k_return = true  
					end if
				else
					k_return = true
				end if
			else
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza()
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante valutazione riga lotto se da trattare, riga lotto id = " + string(kst_tab_armo.id_armo) + ": " + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try
	
	
return k_return 

end function

public function integer get_causale (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Get dal Lotto del cod Causale di entrata 
//=== 
//=== Input: id_meca;
//=== Rit: codice causale (id_meca_causale)
//===   
//====================================================================
int k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- 
	select MECA_BLK.ID_MECA_CAUSALE
        into :kst_tab_meca.ID_MECA_CAUSALE
      from MECA inner join MECA_BLK on MECA.ID = MECA_BLK.ID_MECA  
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if kst_tab_meca.ID_MECA_CAUSALE > 0 then
			k_return = kst_tab_meca.ID_MECA_CAUSALE
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kGuo_exception = create uo_exception
			kGuo_exception.set_esito( kst_esito )
			throw kGuo_exception
		end if
	end if
	
	
return k_return


end function

public function boolean get_altri_dati (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Legge alcuni dati della riga di entrata
//=== 
//=== 
//===  input: st_tab_armo.id_armo 
//===  Out: st_tab_armo. *
//===  Rit.: TRUE=movimento trovato
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	 
	 
	SELECT peso_kg
	      , dose
		  , magazzino
	      , alt_2
		  , campione 
		  , colli_2
			 INTO 
		 :kst_tab_armo.peso_kg
		 ,:kst_tab_armo.dose
		 ,:kst_tab_armo.magazzino
		 ,:kst_tab_armo.alt_2
		 ,:kst_tab_armo.campione
		 ,:kst_tab_armo.colli_2
			 FROM armo
			WHERE id_armo = :kst_tab_armo.id_armo
		 using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura dati da riga Lotto (id " + string(kst_tab_armo.id_armo) + ") " &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
	if isnull(kst_tab_armo.peso_kg) then kst_tab_armo.peso_kg = 0
	if isnull(kst_tab_armo.alt_2) then kst_tab_armo.alt_2 = 0
	if isnull(kst_tab_armo.campione) then kst_tab_armo.campione = ""



return k_return

end function

public function integer get_righe (ref st_tab_armo kst_tab_armo[]) throws uo_exception;//
//====================================================================
//=== Torna tutti gli id_armo del lotto
//=== 
//=== 
//===  input: st_tab_armo[1].id_meca 
//===  Out: st_tab_armo[].id_armo
//===  Rit.: numero di righe trovate
//===        
//===  Lancia EXCEPTION x errore grave
//===                                     
//====================================================================
//
int k_return=0
int k_ind=1
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	 
	 
	declare c_armo_get_righe cursor for 
		SELECT id_armo
			 FROM armo
			WHERE id_meca = :kst_tab_armo[1].id_meca
		 using kguo_sqlca_db_magazzino ;

	open c_armo_get_righe;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		fetch c_armo_get_righe	
				 INTO  :kst_tab_armo[k_ind].id_armo;

 		do while kguo_sqlca_db_magazzino.sqlcode = 0 
			k_ind ++
			fetch c_armo_get_righe	
				 INTO  :kst_tab_armo[k_ind].id_armo;
		loop
		k_ind --
		
		close c_armo_get_righe;
	end if
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Lotto per id righe, Lotto id " + string(kst_tab_armo[1].id_meca) + " " &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if k_ind > 0 then
		k_return = k_ind
	end if


return k_return

end function

public function long get_colli_da_sped (ref st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il nr colli da Spedire x Riga Lotto 
//=== 
//=== Input : kst_tab_armo.id_armo
//=== Out: kst_tab_armo.colli_2 = colli entrati
//=== Ritorna: colli da spedire
//=== Lancia Exception  
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_armo kst_tab_armo_in, kst_tab_armo_ddt, kst_tab_armo_lav, kst_tab_armo_senzalav, kst_tab_armo_calc
st_tab_armo_out kst_tab_armo_out
st_tab_arsp kst_tab_arsp
date k_data_0 = date(0)
st_tab_meca_qtna kst_tab_meca_qtna
kuf_meca_qtna kuf1_meca_qtna	
kuf_sped kuf1_sped	
kuf_armo_out kuf1_armo_out	


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try 
	
	kst_tab_armo_calc.colli_2 = 0
	
	if ast_tab_armo.id_armo > 0 then  

//--- colli entrati	
		kst_tab_armo_in = ast_tab_armo
		kst_esito = get_colli_entrati_riga(kst_tab_armo_in)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		ast_tab_armo.colli_2 = kst_tab_armo_in.colli_2
		
//--- colli spediti	
		if kst_tab_armo_in.colli_2 > 0 then
			kuf1_sped = create kuf_sped
			kst_tab_arsp.id_armo = ast_tab_armo.id_armo
			kst_tab_armo_ddt.colli_2 = kuf1_sped.get_colli_sped(kst_tab_arsp)
			if isnull(kst_tab_armo_ddt.colli_2) then kst_tab_armo_ddt.colli_2 = 0
		end if
//--- colli scaricati manualmente	
		if kst_tab_armo_in.colli_2 > 0 then
			kuf1_armo_out = create kuf_armo_out
			kst_tab_armo_out.id_armo = ast_tab_armo.id_armo
			kst_tab_armo_out.colli = kuf1_armo_out.get_colli_x_id_armo(kst_tab_armo_out)
			if kst_tab_armo_out.colli > 0 then
				kst_tab_armo_ddt.colli_2 += kst_tab_armo_out.colli 
			end if
		end if

//--- lotto ancora non spedito
		if kst_tab_armo_in.colli_2 > kst_tab_armo_ddt.colli_2 then

//--- Se riga da NON trattare (es. non magazzino 2 oppure causale merce da non trattare ....)	
			if NOT if_da_trattare(ast_tab_armo) then
				kst_tab_armo_calc.colli_2 = kst_tab_armo_in.colli_2 - kst_tab_armo_ddt.colli_2 // Normale! posso sped i colli entrati meno i colli spediti
			else
//--- Se invece riga da trattare calcolo.... 
//--- colli trattati	
				kst_tab_armo_lav = ast_tab_armo
				kst_tab_armo_lav.colli_2 = get_colli_trattati(kst_tab_armo_lav)
				
				if kst_tab_armo_in.colli_2 > kst_tab_armo_lav.colli_2 then
//--- colli da non trattare	
					kst_tab_armo_senzalav = ast_tab_armo
					kst_tab_armo_senzalav.colli_2 = get_colli_danontrattare(kst_tab_armo_senzalav)
					if kst_tab_armo_senzalav.colli_2 > 0 then
						kst_tab_armo_calc.colli_2 = kst_tab_armo_lav.colli_2 + kst_tab_armo_senzalav.colli_2 - kst_tab_armo_ddt.colli_2 // Forse posso sped i colli trattati + colli da non trattare meno i colli spediti
					else
						kst_tab_armo_calc.colli_2 = kst_tab_armo_lav.colli_2 - kst_tab_armo_ddt.colli_2 // Forse posso sped i colli Trattati meno i colli spediti
					end if
				else
					kst_tab_armo_calc.colli_2 = kst_tab_armo_in.colli_2 - kst_tab_armo_ddt.colli_2 // Normale! posso sped i colli entrati meno i colli spediti
				end if
			end if
		end if		
	end if
	
	if kst_tab_armo_calc.colli_2 > 0 then
		k_return = kst_tab_armo_calc.colli_2
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	
	
return k_return

end function

public subroutine get_num_bolla_in (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Torna DDT del mandante 
//--- 
//--- Input : st_tab_meca.id 
//--- out: num_bolla_out / data_bolla_out
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select num_bolla_in
	     ,data_bolla_in
		into :kst_tab_meca.num_bolla_in
			,:kst_tab_meca.data_bolla_in
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante ricerca DDT Mandante, id Lotto: " + string(kst_tab_meca.id) + "~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw  kguo_exception
	end if
	if trim(kst_tab_meca.num_bolla_in) > " " then
	else
		kst_tab_meca.num_bolla_in = ""
		kst_tab_meca.data_bolla_in = date(0)
	end if
	
	

end subroutine

public function boolean if_lotto_pianificato (st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se Riferimento è stato messo in un PL (non è detto che abbia concluso il trattamento)
//--- 
//--- Ritorna boolean : TRUE=pianificato, FALSE=mai pianificato;
//---         
//-------------------------------------------------------------------------------------------------------------------------------------------------------

st_esito kst_esito
boolean k_return = false
int k_ctr = 0


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select distinct 1
		into :k_ctr
		from barcode  
				where barcode.id_meca = :kst_tab_meca.id
				  and barcode.pl_barcode > 0
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if k_ctr > 0 then
			k_return = true
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante controllo del Lotto id " + string(kst_tab_meca.id) + ", se Pianificato ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	
return k_return


end function

public function st_esito tb_delete_riferimento (st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Cancella l'INTERO LOTTO RIFERIMENTO 
//=== 
//=== Input: id 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     100=not found
//===                                     2=Errore Grave
//===                                     3=Informativo
//====================================================================
//
boolean k_autorizza, k_cancella_meca, k_cancella_barcode, k_cancella_artr, k_cancella_sped, k_cancella_arfa, k_cancella_certif, k_cancella_wmf, k_cancella_qtna
long k_ctr
string k_errore
int k_nr_righe=0, k_riga=0
st_open_w kst_open_w
st_esito kst_esito, kst_esito1
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_arfa kst_tab_arfa
st_tab_sped kst_tab_sped
st_tab_arsp kst_tab_arsp
st_tab_barcode kst_tab_barcode
st_tab_certif kst_tab_certif
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza
st_wm_pklist kst_wm_pklist
kuf_sicurezza kuf1_sicurezza
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
kuf_sped kuf1_sped
kuf_fatt kuf1_fatt
kuf_certif kuf1_certif
kuf_wm_pklist kuf1_wm_pklist
kuf_meca_qtna kuf1_meca_qtna
kuf_meca_dosim kuf1_meca_dosim
kuf_meca_dosimbozza kuf1_meca_dosimbozza
datastore kds_id_armo_x_id_meca


//DECLARE c_armo CURSOR FOR  
//	  SELECT id_armo
//   	 FROM armo 
//	   WHERE id_meca = :ast_tab_meca.id
//		using  kguo_sqlca_db_magazzino;
	


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_autorizza = false  
k_cancella_meca = false
k_cancella_barcode = false
k_cancella_artr = false
k_cancella_sped = false
k_cancella_arfa = false
k_cancella_certif = false
k_cancella_qtna = false

kst_tab_meca = ast_tab_meca


SELECT num_int, data_int, id_wm_pklist
	into :kst_tab_meca.num_int
		  ,:kst_tab_meca.data_int
		  ,:kst_tab_meca.id_wm_pklist
	FROM meca
	WHERE 
		  id = :kst_tab_meca.id
	using kguo_sqlca_db_magazzino ;

//--- se riferimento trovato NON OK....
if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Tab.Riferimenti (meca): " + trim( kguo_sqlca_db_magazzino.SQLErrText)
	if  kguo_sqlca_db_magazzino.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd
	else
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else	
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//--- Lotto chiuso non rimovibile
if if_lotto_chiuso(ast_tab_meca) then
	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Lotto non Aperto rimozione non consentita!"
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//--- CONTROLLA AUTORIZZAZIONI

try

	kuf1_sicurezza = create kuf_sicurezza

//--- controlla se utente autorizzato alla funzione in atto
	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	
//--- Riferimento AUTORIZZATO?	
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma.riferimenti
	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	if not k_autorizza then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "La Richiesta di Cancellazione del Riferimento non e' stata abilitata"
	else
		k_cancella_qtna = true
	end if


//--- Quarantena
	if k_autorizza then
		SELECT count(*)
			into :k_ctr
			FROM meca_qtna
			WHERE id_meca = :kst_tab_meca.id
			using  kguo_sqlca_db_magazzino;
//--- se trovato controllole autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			kuf1_meca_qtna = create kuf_meca_qtna
			kst_open_w.id_programma = kuf1_meca_qtna.get_id_programma(kst_open_w.flag_modalita)
			destroy kuf1_meca_qtna 
			k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
			if not k_autorizza then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "La Richiesta di Cancellazione della QUARANTENA non e' stata abilitata"
			else
				k_cancella_barcode = true
			end if
		end if
	end if


//--- barcode
	if k_autorizza then
		SELECT count(*)
			into :k_ctr
			FROM barcode
			WHERE num_int = :kst_tab_meca.num_int
					and data_int = :kst_tab_meca.data_int
			using  kguo_sqlca_db_magazzino;
//--- se trovato controllole autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			kst_open_w.id_programma = kkg_id_programma.barcode
			k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
			if not k_autorizza then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "La Richiesta di Cancellazione dei Barcode non e' stata abilitata"
			else
				k_cancella_barcode = true
			end if
		end if
	end if
	
//--- artr (tab lavorazioni)
	if k_autorizza then
		
		SELECT count(*)
			into :k_ctr
			FROM armo inner join artr on
				  armo.id_armo = artr.id_armo
			WHERE armo.id_meca = :kst_tab_meca.id
			using  kguo_sqlca_db_magazzino;
//--- se trovato controllole autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			kst_open_w.id_programma = kkg_id_programma.artr
			k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
			if not k_autorizza then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "La Richiesta di Cancellazione delle Lavorazioni non e' stata abilitata"
			else
				k_cancella_artr = true
			end if
		end if
	end if

//--- spedizioni, se esiste DDT non autorizzo la rimozione del Lotto
	if k_autorizza then
		SELECT max(num_bolla_out)
			into :k_ctr
			FROM armo inner join arsp on
				  armo.id_armo = arsp.id_armo
			WHERE armo.id_meca = :kst_tab_meca.id
			using  kguo_sqlca_db_magazzino;
//--- se trovato controllo le autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			k_autorizza = false
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Esiste già un DDT di spedizione del Lotto vedi il  nr. " + string (k_ctr)
//				kuf1_sped = create kuf_sped
//				kst_open_w.id_programma = kuf1_sped.get_id_programma(kst_open_w.flag_modalita) 
//				destroy kuf1_sped 
//				k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//				if not k_autorizza then
//					kst_esito.esito = kkg_esito.db_ko
//					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "La Richiesta di Cancellazione della Bolla di Spedizione non e' stata abilitata"
//				else
//					k_cancella_sped = true
//				end if
		end if
	end if

//--- fatture, se esiste non autorizzo la rimozione del Lotto
	if k_autorizza then
		SELECT max(num_fatt)
			into :k_ctr
			FROM armo inner join arfa on
				  armo.id_armo = arfa.id_armo
			WHERE armo.id_meca = :kst_tab_meca.id
			using  kguo_sqlca_db_magazzino;
//--- se trovato controllole autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			k_autorizza = false
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Esiste già una Fattura del Lotto vedi il  nr. " + string (k_ctr)
//				kst_open_w.id_programma = kkg_id_programma.fatture
//				k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//				if not k_autorizza then
//					kst_esito.esito = kkg_esito.db_ko
//					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "La Richiesta di Cancellazione della Fattura non e' stata abilitata"
//				else
//					k_cancella_arfa = true
//				end if
		end if
	end if
	
//--- attestato, se esiste non autorizzo la rimozione del Lotto
	if k_autorizza then
		SELECT count(num_certif)
			into :k_ctr
			FROM certif
			WHERE id_meca = :kst_tab_meca.id
			using  kguo_sqlca_db_magazzino;
			
//--- se trovato controllo le autorizzazioni
		if  kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr > 0 then
			k_autorizza = false
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Esiste già un Attestato del Lotto vedi il  nr. " + string (k_ctr)
//				kst_open_w.id_programma = kkg_id_programma.attestati
//				k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//				if not k_autorizza then
//					kst_esito.esito = kkg_esito.db_ko
//					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "La Richiesta di Cancellazione dell'Attestato non e' stata abilitata"
//				else
//					k_cancella_certif = true
//				end if
		end if
	end if


//--- WMF
	if k_autorizza then
		if NOT kguo_sqlca_db_wm.if_connessione_bloccata( ) then
			kuf1_wm_pklist = create kuf_wm_pklist
			kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist = kst_tab_meca.id_wm_pklist
			if NOT kuf1_wm_pklist.if_da_importare(kst_wm_pklist) then
				k_autorizza = kuf1_wm_pklist.if_sicurezza(kkg_flag_modalita.modifica )
				if not k_autorizza then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "La Richiesta di Modifica del WMF '" + string(kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist)+ "' non e' stata abilitata"
				else
					k_cancella_wmf = true
				end if
			end if
		end if
	end if

	destroy kuf1_sicurezza



//--- PARTONO LE CANCELLAZIONI!!!


//--- Toglie da Packing il "Trasferito" e i Barcode dalla tabella di WM
	if k_autorizza then

			
	//--- Modifica su WMF
		if k_cancella_wmf then
			if NOT kguo_sqlca_db_wm.if_connessione_bloccata( ) then
				if NOT isvalid(kuf1_wm_pklist) then kuf1_wm_pklist = create kuf_wm_pklist
	//--- x resettare il Lotto passa il ID_MECA e ID_WM_PLIST				
				kst_wm_pklist.st_tab_wm_pklist_righe[1].id_meca = kst_tab_meca.id
				kst_wm_pklist.st_tab_wm_pklist_righe[1].id_wm_pklist = kst_tab_meca.id_wm_pklist
				kst_wm_pklist.st_tab_wm_pklist_righe[1].st_tab_g_0.esegui_commit = "N" 
				kuf1_wm_pklist.set_da_importare(kst_wm_pklist)
			end if		
		end if			

			
	//--- cancella QUARANTENA
		if k_cancella_qtna then
			kuf1_meca_qtna = create kuf_meca_qtna
			kst_tab_meca_qtna.id_meca = kst_tab_meca.id
			kst_tab_meca_qtna.st_tab_g_0.esegui_commit = "N"
			kuf1_meca_qtna.tb_delete(kst_tab_meca_qtna)
			destroy kuf1_meca_qtna
		end if
		
	//--- cancella attestato
		if k_cancella_certif then
			kuf1_certif = create kuf_certif
			kst_tab_certif.id_meca = kst_tab_meca.id
			kst_tab_certif.st_tab_g_0.esegui_commit = "N"
			kst_esito1 = kuf1_certif.tb_delete_x_rif (kst_tab_certif)
			destroy kuf1_certif
			if kst_esito1.esito <> kkg_esito.ok then
				if kst_esito1.esito <> kkg_esito.db_wrn	then
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) &
											+ "~n~rErrore in Canc.Attestao (kuf_armo.tb_delete):~n~r" + trim(kst_esito1.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if

		kds_id_armo_x_id_meca = create datastore
		kds_id_armo_x_id_meca.dataobject = "ds_id_armo_x_id_meca"
		kds_id_armo_x_id_meca.settransobject(kguo_sqlca_db_magazzino)
		k_nr_righe = kds_id_armo_x_id_meca.retrieve(ast_tab_meca.id)
	
	//--- cancella fattura
		if kst_esito.esito = kkg_esito.ok and k_cancella_arfa then
			kuf1_fatt = create kuf_fatt
		
//			open c_armo;
//			fetch c_armo into :kuf1_fatt.kist_tab_arfa.id_armo;
			k_riga = 1
			kst_esito1.esito = kkg_esito.ok
			do while k_nr_righe >= k_riga and (kst_esito1.esito = kkg_esito.ok or kst_esito1.esito = kkg_esito.db_wrn )
	
				kuf1_fatt.kist_tab_arfa.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_riga, "id_armo")  // get del ID_RMO su cui lavorare
				
				kuf1_fatt.kist_tab_arfa.st_tab_g_0.esegui_commit = "N"
				kst_esito1 = kuf1_fatt.tb_delete_x_rif ()
				
				if kst_esito1.esito <> kkg_esito.ok and kst_esito1.esito <> kkg_esito.db_wrn	then
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) &
												+ "~n~rErrore in Canc.Fattura (kuf_armo.tb_delete):~n~r" + trim(kst_esito1.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				else
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) + trim(kst_esito1.SQLErrText)
				end if
	
				k_riga++
			
			loop
	
			destroy kuf1_fatt
		end if
	
	
	//--- cancella spedizione
		if kst_esito.esito = kkg_esito.ok and k_cancella_sped then
			kuf1_sped = create kuf_sped
		
//			open c_armo;
//			fetch c_armo into :kuf1_sped.kist_tab_arsp.id_armo;
			k_riga = 1
			kst_esito1.esito = kkg_esito.ok
			do while  k_nr_righe >= k_riga and (kst_esito1.esito = kkg_esito.ok or kst_esito1.esito = kkg_esito.db_wrn)
	
				kuf1_sped.kist_tab_arsp.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_riga, "id_armo")  // get del ID_RMO su cui lavorare

				kuf1_sped.kist_tab_arsp.st_tab_g_0.esegui_commit = "N"
				kst_esito1 = kuf1_sped.tb_delete_x_rif ()
	
				if kst_esito1.esito <> kkg_esito.ok	and kst_esito1.esito <> kkg_esito.db_wrn	then
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) &
											+ "~n~rErrore in Canc.Spedizione (kuf_armo.tb_delete):~n~r" + trim(kst_esito1.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				else
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) + trim(kst_esito1.SQLErrText)
				end if
				
				k_riga++
			
			loop
	
			destroy kuf1_sped
		end if
	
	
	
	//--- cancella Lavorazione (artr)
		if kst_esito.esito = kkg_esito.ok and k_cancella_artr then
			kuf1_artr = create kuf_artr
		
//			open c_armo;
//			fetch c_armo into :kuf1_artr.kist_tab_artr.id_armo;
			k_riga = 1
			kst_esito1.esito = kkg_esito.ok
			do while k_nr_righe >= k_riga  and (kst_esito1.esito = kkg_esito.ok or kst_esito1.esito = kkg_esito.db_wrn)
	
				kuf1_artr.kist_tab_artr.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_riga, "id_armo")  // get del ID_RMO su cui lavorare

				kuf1_artr.kist_tab_artr.st_tab_g_0.esegui_commit = "N"
				kst_esito1 = kuf1_artr.tb_delete ()
	
				if kst_esito1.esito <> kkg_esito.ok	and kst_esito1.esito <> kkg_esito.db_wrn	then
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) &
											+ "~n~rErrore in Canc.Lavorazione (kuf_armo.tb_delete):~n~r" + trim(kst_esito1.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				else
					kst_esito.SQLErrText = trim(kst_esito.SQLErrText) + trim(kst_esito1.SQLErrText)
				end if
	
				k_riga++
			
			loop
	
			destroy kuf1_artr
		end if
	
	
	//--- cancella barcode
		if kst_esito.esito = kkg_esito.ok and k_cancella_barcode then
			kuf1_barcode = create kuf_barcode
		
			kst_tab_barcode.id_meca = kst_tab_meca.id
			kst_tab_barcode.st_tab_g_0.esegui_commit = "N"
			kst_esito1 = kuf1_barcode.tb_delete_x_rif (kst_tab_barcode)
			
			destroy kuf1_barcode
			if kst_esito1.esito <> kkg_esito.ok and kst_esito1.esito <> kkg_esito.db_wrn then
				kst_esito.SQLErrText = trim(kst_esito.SQLErrText) &
										+ "~n~rErrore in Canc.dei Barcode (kuf_armo.tb_delete):~n~r" + trim(kst_esito1.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	
	//--- cancella Dosimetri e Dosimetrie in bozza
		if kst_esito.esito = kkg_esito.ok and k_cancella_barcode then

			kuf1_meca_dosim = create kuf_meca_dosim
			kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "N"
			kst_tab_meca_dosim.id_meca = kst_tab_meca.id
			kuf1_meca_dosim.tb_delete_x_id_meca(kst_tab_meca_dosim)
			
			kuf1_meca_dosimbozza = create kuf_meca_dosimbozza
			kst_tab_meca_dosimbozza.st_tab_g_0.esegui_commit = "N"
			kst_tab_meca_dosimbozza.id_meca  = kst_tab_meca.id
			kuf1_meca_dosimbozza.tb_delete_x_id_meca(kst_tab_meca_dosimbozza)
		end if
	
	//--- cancella MECA-ARMO riferimento
		if kst_esito.esito = kkg_esito.ok then
		
			kst_tab_meca.st_tab_g_0.esegui_commit = "N"
			kst_esito1 = tb_delete_meca (kst_tab_meca)
			
			if kst_esito1.sqlcode < 0 then
				kst_esito.SQLErrText = "Errore in Canc. Testata Riferimento (kuf_armo.tb_delete): " + trim(kst_esito1.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		else
			k_errore = kGuf_data_base.db_rollback()
		end if
	
		
	end if



//---- ERRORE		
catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback()
//	kst_esito = kuo_exception.get_st_esito()
	throw kuo_exception

finally

	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_meca_dosimbozza) then destroy kuf1_meca_dosimbozza

	if k_autorizza then
//--- COMMIT FINALE SE TUTTO OK!!!!!!!!!!!!!!!!!	
		if ast_tab_meca.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
				kst_esito =  kguo_sqlca_db_magazzino.db_commit()
				if kst_esito.esito <> kkg_esito.ok then
					kst_esito.SQLErrText = "Errore in Cancellazione Lotto (durante la COMMIT): " + trim(kst_esito.SQLErrText)
				end if
			else
				 kguo_sqlca_db_magazzino.db_rollback()
			end if
		end if
	end if

end try
		


return kst_esito

end function

public function long get_num_int_new (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna Nuovo Numero e Data da assegnare al NUOVO Lotto 
//=== 
//=== Input : nulla
//=== Ritorna: kst_tab_meca.num_int, data_int 
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
long k_return = 0
string k_esito
st_esito kst_esito
kuf_base kuf1_base


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca.num_int	= 0
	kst_tab_meca.data_int = date(0)

	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "num_int")
	if left(k_esito,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in lettura archivio BASE (get 'NUM_INT'), esito: " + trim(k_esito)
		kGuo_exception.set_esito( kst_esito )
		throw  kGuo_exception
	else
		kst_tab_meca.num_int	= long(mid(k_esito,2)) + 1
		if kst_tab_meca.num_int > 0 then
			k_return = kst_tab_meca.num_int	
		end if
		kst_tab_meca.data_int = kguo_g.get_dataoggi()
	end if

	
	destroy kuf1_base

return k_return 
end function

public function long get_numero_nuovo () throws uo_exception;//
//====================================================================
//=== Torna Nuovo Numero per un NUOVO Lotto 
//=== 
//=== Input : nulla
//=== Ritorna: long con il nuovo numero
//=== Exception se errore con st_esito valorizzato
//===					
//===   
//====================================================================
long k_return = 0
st_tab_meca kst_tab_meca

	k_return = get_num_int_new(kst_tab_meca)
	
return k_return 
end function

public function long get_colli_sped_lotto (st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il nr colli Spediti x ID Lotto 
//=== 
//=== Input : kst_tab_meca.id
//=== Out: 
//=== Ritorna: colli spediti
//=== Lancia Exception  
//====================================================================
long k_return = 0
st_esito kst_esito
datastore kds_1 


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try 
	
	if ast_tab_meca.id > 0 then  
		
		kds_1 = create datastore
		kds_1.dataobject = "ds_meca_colli_sped"
		kds_1.settransobject( kguo_sqlca_db_magazzino )

//--- colli spediti	
		if kds_1.retrieve(ast_tab_meca.id) > 0 then
			k_return = kds_1.getitemnumber( 1, "colli_2")
			if isnull(k_return) then k_return = 0
		end if

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
	
	
return k_return

end function

public function long get_colli_lotto (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il nr colli totali x Lotto
//=== 
//=== Input : kst_tab_armo.id_meca 
//=== Ritorna st_esito :  come standard
//===					: kst_tab_armo.colli_2
//===   
//====================================================================
long k_return=0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_armo.id_meca > 0 then

	select sum(colli_2)
		into :kst_tab_armo.colli_2
		from armo 
		where armo.id_meca = :kst_tab_armo.id_meca
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura colli per Lotto id="+  string(kst_tab_armo.id_meca) +"~n~r"+ kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if
end if
	
return k_return

end function

public function long tb_update_meca (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------
//--- Aggiunge/Aggiorna rek nella tabella DATI TESTATA LOTTO
//--- 
//--- Input: st_tab_meca     id=0  fa la INSERT
//---                    id>0  fa la UPDATE
//---
//--- Ritorna:  id_meca
//--- 
//------------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	
	if kst_tab_meca.id = 0 then
		kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	else
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	end if
	//--- controlla se utente autorizzato alla funzione in atto
	k_rc = if_sicurezza(kst_open_w.flag_modalita)
	
	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_meca(kst_tab_meca)

//--- se ID_meca e' zero allora INSERT
	if kst_tab_meca.id = 0 then
			//id,
		INSERT INTO meca  
					(    
					  num_int,   
					  data_int,   
					  data_ent,   
					  id_wm_pklist,   
					  num_bolla_in,   
					  data_bolla_in,   
					  consegna_data,   
					  consegna_ora,   
					  clie_1,   
					  clie_2,   
					  clie_3,   
					  contratto,   
					  area_mag,   
					  aperto,   
					  stato,   
					  stato_in_attenzione,
					  data_lav_fin,   
					  err_lav_fin,   
					  err_lav_ok,   
					  note_lav_ok,   
					  e1doco,   
					  e1rorn,   
					  e1srst,   
					  cert_forza_stampa,   
					  x_data_cert_f_st,   
					  x_utente_cert_f_st,   
					  cert_farma_st_ok,   
					  x_data_cert_farma,   
					  x_utente_cert_farm,   
					  cert_aliment_st_ok,   
					  x_data_cert_alim,   
					  x_utente_cert_alim,   
					  x_datins,   
					  x_utente )  
			  VALUES 
						( 
						  :kst_tab_meca.num_int,   
						  :kst_tab_meca.data_int,   
						  :kst_tab_meca.data_ent,   
						  :kst_tab_meca.id_wm_pklist ,   
						  :kst_tab_meca.num_bolla_in,   
						  :kst_tab_meca.data_bolla_in,   
						  :kst_tab_meca.consegna_data,   
						  :kst_tab_meca.consegna_ora,   
						  :kst_tab_meca.clie_1,   
						  :kst_tab_meca.clie_2,   
						  :kst_tab_meca.clie_3,   
						  :kst_tab_meca.contratto,   
						  :kst_tab_meca.area_mag,   
						  :kst_tab_meca.aperto,   
						  :kst_tab_meca.stato,   
						  :kst_tab_meca.stato_in_attenzione ,
						  :kst_tab_meca.data_lav_fin,   
						  :kst_tab_meca.err_lav_fin,   
						  :kst_tab_meca.err_lav_ok,   
						  :kst_tab_meca.note_lav_ok,   
						  :kst_tab_meca.e1doco,   
					     :kst_tab_meca.e1rorn,   
					     :kst_tab_meca.e1srst,   
						  :kst_tab_meca.cert_forza_stampa,   
						  :kst_tab_meca.x_data_cert_f_st,   
						  :kst_tab_meca.x_utente_cert_f_st,   
						  :kst_tab_meca.cert_farma_st_ok,   
						  :kst_tab_meca.x_data_cert_farma,   
						  :kst_tab_meca.x_utente_cert_farm,   
						  :kst_tab_meca.cert_aliment_st_ok,   
						  :kst_tab_meca.x_data_cert_alim,   
						  :kst_tab_meca.x_utente_cert_alim,   
						  :kst_tab_meca.x_datins,   
						  :kst_tab_meca.x_utente )  
						using kguo_sqlca_db_magazzino;

//--- recupera il valore serial
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			kst_tab_meca.id = get_id_meca_max( )	
		//	kst_tab_meca.id = long(kguo_sqlca_db_magazzino.SQLReturnData) 
		end if
		
	else

		UPDATE meca  
					  SET 
					  num_int = :kst_tab_meca.num_int ,   
					  data_int = :kst_tab_meca.data_int ,   
					  data_ent = :kst_tab_meca.data_ent ,   
					  id_wm_pklist = :kst_tab_meca.id_wm_pklist ,   
					  num_bolla_in = :kst_tab_meca.num_bolla_in ,   
					  data_bolla_in = :kst_tab_meca.data_bolla_in ,   
					  consegna_data = :kst_tab_meca.consegna_data ,   
					  consegna_ora = :kst_tab_meca.consegna_ora ,   
					  clie_1 = :kst_tab_meca.clie_1 ,   
					  clie_2 = :kst_tab_meca.clie_2 ,   
					  clie_3 = :kst_tab_meca.clie_3 ,   
					  contratto = :kst_tab_meca.contratto ,   
					  area_mag = :kst_tab_meca.area_mag ,   
//					  aperto = :kst_tab_meca.aperto ,   
					  stato = :kst_tab_meca.stato ,   
					  stato_in_attenzione = :kst_tab_meca.stato_in_attenzione ,   
					  e1doco = :kst_tab_meca.e1doco,   
					  e1rorn = :kst_tab_meca.e1rorn,   
					  e1srst = :kst_tab_meca.e1srst,   
					  x_datins = :kst_tab_meca.x_datins ,   
					  x_utente = :kst_tab_meca.x_utente
					WHERE meca.id =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;
					
	end if	
	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento testata Lotto (meca): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if

return k_return

end function

public function long tb_update_meca_blk (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Aggiunge/Aggiorna rek nella tabella DATI CAUSALI LOTTO
//--- 
//--- Input: st_tab_meca     id=0  fa la INSERT
//---                    id>0  fa la UPDATE
//---
//--- Ritorna: id_meca
//--- 
//---------------------------------------------------------------------------------------------------
long k_rcn, k_return=0
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_meca.X_DATINS_BLK = kst_tab_meca.x_datins
	kst_tab_meca.X_UTENTE_BLK = kst_tab_meca.x_utente


	if_isnull_meca(kst_tab_meca)

	//--- controlla se utente autorizzato alla funzione in atto
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	k_rc = if_sicurezza(kst_open_w.flag_modalita)
	
	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- se archivio Blocco del Lotto non esiste allora faccio INSERT
	if NOT if_esiste_blk(kst_tab_meca) then

//--- se c'e' il codice o la descrizione registra!
		if kst_tab_meca.id_meca_causale > 0 or kst_tab_meca.meca_blk_descrizione > " " then

			INSERT INTO meca_blk  
						( id_meca,   
						  id_meca_causale,   
						  descrizione,   
						  rich_autorizz,
						  x_datins_blk,   
						  x_utente_blk,   
						  x_datins_sblk,   
						  x_utente_sblk,   
						  x_datins,   
						  x_utente )  
				  VALUES 
							( :kst_tab_meca.id,   
							  :kst_tab_meca.id_meca_causale,   
							  :kst_tab_meca.meca_blk_descrizione,   
							  :kst_tab_meca.meca_blk_rich_autorizz,
							  :kst_tab_meca.x_datins_blk,   
							  :kst_tab_meca.x_utente_blk,
							  :kst_tab_meca.x_datins_sblk,   
							  :kst_tab_meca.x_utente_sblk,
							  :kst_tab_meca.x_datins,   
							  :kst_tab_meca.x_utente )  
							using kguo_sqlca_db_magazzino;
		end if
		
	else

//--- se c'e' il codice o la descrizione registra!
		if kst_tab_meca.id_meca_causale > 0 or kst_tab_meca.meca_blk_descrizione > " " then
			UPDATE meca_blk  
					  SET 
					  id_meca_causale = :kst_tab_meca.id_meca_causale ,   
					  descrizione = :kst_tab_meca.meca_blk_descrizione ,   
					  rich_autorizz = :kst_tab_meca.meca_blk_rich_autorizz ,   
					  x_datins_sblk = :kst_tab_meca.x_datins_sblk ,   
					  x_utente_sblk = :kst_tab_meca.x_utente_sblk,
					  x_datins = :kst_tab_meca.x_datins ,   
					  x_utente = :kst_tab_meca.x_utente
					WHERE id_meca =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;

		else
//--- altrimenti lo rimuove!
			delete from meca_blk  
					WHERE id_meca =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;
		end if
//					  x_datins = :kst_tab_meca.x_datins_blk ,   
//					  x_utente = :kst_tab_meca.x_utente_blk,
	end if	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.dati di 'Blocco Lotto':" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	
end try	

return k_return

end function

public function long tb_update_armo (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Aggiunge/Aggiorna rek nella tabella DATI RIGHE LOTTO
//=== 
//=== Input: st_tab_armo     id_armo=0  fa la INSERT
//===                                  id_armo>0  fa la UPDATE
//===
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn, k_return = 0
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_armo.id_meca > 0 then
	
	kst_tab_armo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_armo.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_armo(kst_tab_armo)

//--- controlla se utente autorizzato alla funzione in atto
	if kst_tab_armo.id_armo = 0 then
		kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	else
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	end if
	k_rc = if_sicurezza(kst_open_w.flag_modalita)

	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- se ID_ARMO e' zero allora INSERT
	if kst_tab_armo.id_armo = 0 then
			
//						  id_armo,   
		INSERT INTO armo  
						( id_meca,   
						  num_int,   
						  data_int,   
						  id_listino,   
						  art,   
						  dose,   
						  note_1,   
						  note_2,   
						  note_3,   
						  larg_1,   
						  lung_1,   
						  alt_1,   
						  colli_1,   
						  travaso,   
						  larg_2,   
						  lung_2,   
						  alt_2,   
						  colli_2,   
						  m_cubi,   
						  peso_kg,   
						  colli_fatt,   
						  magazzino,   
						  pedane,   
						  campione,   
						  cod_sl_pt,   
						  stato,   
						  x_datins,   
						  x_utente )  
			  VALUES 
						( :kst_tab_armo.id_meca,   
						  :kst_tab_armo.num_int,   
						  :kst_tab_armo.data_int,   
						  :kst_tab_armo.id_listino,   
						  :kst_tab_armo.art,   
						  :kst_tab_armo.dose,   
						  :kst_tab_armo.note_1,   
						  :kst_tab_armo.note_2,   
						  :kst_tab_armo.note_3,   
						  :kst_tab_armo.larg_1,   
						  :kst_tab_armo.lung_1,   
						  :kst_tab_armo.alt_1,   
						  :kst_tab_armo.colli_1,   
						  :kst_tab_armo.travaso,   
						  :kst_tab_armo.larg_2,   
						  :kst_tab_armo.lung_2,   
						  :kst_tab_armo.alt_2,   
						  :kst_tab_armo.colli_2,   
						  :kst_tab_armo.m_cubi,   
						  :kst_tab_armo.peso_kg,   
						  :kst_tab_armo.colli_fatt,   
						  :kst_tab_armo.magazzino,   
						  :kst_tab_armo.pedane,   
						  :kst_tab_armo.campione,   
						  :kst_tab_armo.cod_sl_pt,   
						  :kst_tab_armo.stato,   
						  :kst_tab_armo.x_datins,   
						  :kst_tab_armo.x_utente )  
					using kguo_sqlca_db_magazzino;

//--- recupera il valore serial
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			kst_tab_armo.id_armo = get_id_armo_max( )
			//kst_tab_armo.id_armo = long(kguo_sqlca_db_magazzino.SQLReturnData) 
		end if
			
	else

		UPDATE armo  
					  SET id_meca =  :kst_tab_armo.id_meca,   
							num_int =  :kst_tab_armo.num_int,   
							data_int =  :kst_tab_armo.data_int,   
							id_listino =  :kst_tab_armo.id_listino,   
							art =  :kst_tab_armo.art,   
							dose =  :kst_tab_armo.dose,   
							note_1 =  :kst_tab_armo.note_1,   
							note_2 =  :kst_tab_armo.note_2,   
							note_3 =  :kst_tab_armo.note_3,   
							larg_1 =  :kst_tab_armo.larg_1,   
							lung_1 =  :kst_tab_armo.lung_1,   
							alt_1 =  :kst_tab_armo.alt_1,   
							colli_1 =  :kst_tab_armo.colli_1,   
							travaso =  :kst_tab_armo.travaso,   
							larg_2 =  :kst_tab_armo.larg_2,   
							lung_2 =  :kst_tab_armo.lung_2,   
							alt_2 =  :kst_tab_armo.alt_2,   
							colli_2 =  :kst_tab_armo.colli_2,   
							m_cubi =  :kst_tab_armo.m_cubi,   
							peso_kg =  :kst_tab_armo.peso_kg,   
							colli_fatt =  :kst_tab_armo.colli_fatt,   
							magazzino =  :kst_tab_armo.magazzino,   
							pedane =  :kst_tab_armo.pedane,   
							campione =  :kst_tab_armo.campione,   
							cod_sl_pt =  :kst_tab_armo.cod_sl_pt,   
							stato =  :kst_tab_armo.stato,   
							x_datins =  :kst_tab_armo.x_datins,   
							x_utente =  :kst_tab_armo.x_utente  
					WHERE armo.id_armo =  :kst_tab_armo.id_armo   
					using kguo_sqlca_db_magazzino;
					
				
	end if	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento riga lotto, ID: " + string(kst_tab_armo.id_armo) + "~n~r"+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if

	if kst_tab_armo.id_armo > 0 then
		k_return = kst_tab_armo.id_armo
	end if
	
else
	kst_esito.SQLErrText = "Riga Lotto: nessun dato caricato (Id Lotto non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return k_return 

end function

public subroutine tb_delete_riga (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Cancella i rek dalla tabella ARMO x id_armo
//=== 
//=== Ritorna st_esito
//====================================================================
boolean k_sicurezza
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
st_tab_arsp kst_tab_arsp
st_tab_armo kst_tab_armo_1
st_tab_meca kst_tab_meca
st_tab_armo_prezzi kst_tab_armo_prezzi
kuf_armo_prezzi kuf1_armo_prezzi
kuf_sped kuf1_sped


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try


	k_sicurezza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
	if not k_sicurezza then
	
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cancellazione Riga Riferimento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else

//---
		kst_tab_armo_1 = kst_tab_armo
		kst_esito = get_id_meca_da_id_armo(kst_tab_armo_1)
		if kst_esito.esito = kkg_esito.ok then
			
			kst_tab_meca.id = kst_tab_armo_1.id_meca
			if NOT if_lotto_chiuso(kst_tab_meca) then
				
				kst_tab_armo_1.colli_2 = get_colli_fatturati(kst_tab_armo_1)
				if kst_esito.esito = kkg_esito.ok then
					if kst_tab_armo_1.colli_2 = 0 then
						
						kuf1_sped = create kuf_sped
						kst_tab_arsp.id_armo = kst_tab_armo.id_armo
						kst_tab_armo_1.colli_2 = kuf1_sped.get_colli_sped(kst_tab_arsp)
						if kst_tab_armo_1.colli_2 = 0 then
	
							kst_tab_armo_1.colli_2 = get_colli_trattati(kst_tab_armo_1)
							if kst_tab_armo_1.colli_2 = 0 then

//--- Cancella Prezzi riga lotto										
								kuf1_armo_prezzi = create kuf_armo_prezzi
								kst_tab_armo_prezzi.id_armo = kst_tab_armo.id_armo
								kst_tab_armo_prezzi.st_tab_g_0. esegui_commit = kst_tab_armo.st_tab_g_0. esegui_commit
								kuf1_armo_prezzi.tb_delete_x_id_armo(kst_tab_armo_prezzi)
								
//---- Cancellazione RIGA LOTTO										
								delete from armo
									where id_armo = :kst_tab_armo.id_armo
									using kguo_sqlca_db_magazzino;
							
								if kguo_sqlca_db_magazzino.sqlcode < 0 then
									kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
									kst_esito.SQLErrText = &
										"Errore durante la cancellazione Riga Lotto (id_meca =" &
												+ string(kst_tab_armo.id_meca, "####0") + ") " &
												+ " ~n~rErrore-tab.ARMO:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
									kst_esito.esito = kkg_esito.db_ko
							
									if kst_tab_armo.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
										kst_esito = kGuf_data_base.db_rollback_1( )
									end if
									kguo_exception.inizializza()
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
									
								else

//--- Cancella NOTE								
									delete from armo_nt
										where id_armo = :kst_tab_armo.id_armo
										using kguo_sqlca_db_magazzino;
							
									if kguo_sqlca_db_magazzino.sqlcode < 0 then
										kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
										kst_esito.SQLErrText = &
											"Errore durante la cancellazione Note della Riga Lotto (id_meca =" &
													+ string(kst_tab_armo.id_meca, "####0") + ") " &
													+ " ~n~rErrore-tab.ARMO_NT:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
										kst_esito.esito = kkg_esito.db_ko
							
										if kst_tab_armo.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
											kst_esito = kGuf_data_base.db_rollback_1( )
										end if
										kguo_exception.inizializza()
										kguo_exception.set_esito(kst_esito)
										throw kguo_exception
							
									else
									
										if kst_tab_armo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_armo.st_tab_g_0.esegui_commit) then
											kst_esito = kGuf_data_base.db_commit_1( )
										end if
									
									end if
								end if
									
								
							else
								kst_esito.esito = kkg_esito.no_esecuzione
								kst_esito.SQLErrText = "Riga Lotto gia' Trattata, riga non eliminata (id riga =" &
										+ string(kst_tab_armo.id_armo, "####0") + ") " 
								kguo_exception.inizializza()
								kguo_exception.set_esito(kst_esito)
								throw kguo_exception
							end if
//							else
//								kst_esito.SQLErrText = &
//									"Errore durante il controllo Trattati Riga Lotto (id riga =" &
//											+ string(kst_tab_armo.id_armo, "####0") + ") " &
//											+ " ~n~rErrore: "	+ trim(kst_esito.SQLErrText)
//								kguo_exception.inizializza()
//								kguo_exception.set_esito(kst_esito)
//								throw kguo_exception
//							end if
						else
							kst_esito.esito = kkg_esito.no_esecuzione
							kst_esito.SQLErrText = "Riga Lotto gia' Spedita, riga non eliminata (id riga =" &
									+ string(kst_tab_armo.id_armo, "####0") + ") " 
							kguo_exception.inizializza()
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
						
					else
						kst_esito.esito = kkg_esito.no_esecuzione
						kst_esito.SQLErrText = "Riga Lotto gia' Fatturata, riga non eliminata (id riga =" &
								+ string(kst_tab_armo.id_armo, "####0") + ") " 
						kguo_exception.inizializza()
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
				else
					kst_esito.SQLErrText = &
						"Errore durante il controllo Fatture della Riga Lotto (id riga =" &
								+ string(kst_tab_armo.id_armo, "####0") + ") " &
												+ " ~n~rErrore: "	+ trim(kst_esito.SQLErrText)
					kguo_exception.inizializza()
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
					
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.SQLErrText = "Lotto gia' Chiuso, riga non eliminata (id riga =" &
						+ string(kst_tab_armo.id_armo, "####0") + ") " 
				
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

	end if



catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.SQLErrText = 	"Riga Lotto non eliminata (id riga =" + string(kst_tab_armo.id_armo, "####0") + ") " + " ~n~rErrore: " + trim(kst_esito.sqlerrtext)
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
finally

	
end try
		
		




end subroutine

public function string get_cod_sl_pt (ref st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Get dal Lotto del cod SL-PT di entrata 
//=== 
//=== Input: id_armo_armo;
//=== Rit: codice SL-PT (cod_sl_pt)
//===   
//====================================================================
string k_return=""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- 
	select armo.cod_sl_pt
        into :ast_tab_armo.cod_sl_pt
      from armo 
		where armo.id_armo = :ast_tab_armo.id_armo
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if trim(ast_tab_armo.cod_sl_pt) > " " then
			k_return = ast_tab_armo.cod_sl_pt
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Ricerca del codice Piano di Trattamento sulla riga Lotto. ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kGuo_exception = create uo_exception
			kGuo_exception.set_esito( kst_esito )
			throw kGuo_exception
		end if
	end if
	
	
return k_return


end function

public function boolean if_lotto_dosimetria_rilevata (st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se Riferimento ha già subito la lettura del DOSIMETRO
//=== 
//=== Ritorna boolean : TRUE=rilevato, FALSE=dosimetria non rilevata;
//===                  : come standard
//===   
//====================================================================

st_esito kst_esito
boolean k_return = false
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- 
	select meca.id 
		into :ast_tab_meca.id
		from meca 
		where meca.id = :ast_tab_meca.id
		          and meca.err_lav_ok > ' '
		using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = true
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if
	end if
	
	
return k_return


end function

public function boolean if_lotto_pianificato_xriga (st_tab_armo kst_tab_armo) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se Riga Lotto è stata messa in un PL (non è detto che abbia concluso il trattamento)
//--- 
//--- Ritorna boolean : TRUE=pianificato, FALSE=mai pianificato;
//---         
//-------------------------------------------------------------------------------------------------------------------------------------------------------

st_esito kst_esito
boolean k_return = false
int k_ctr = 0


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select distinct 1
		into :k_ctr
		from barcode  
				where barcode.id_armo = :kst_tab_armo.id_armo
				  and barcode.pl_barcode > 0
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if k_ctr > 0 then
			k_return = true
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante rilevazione della Riga Lotto id " + string(kst_tab_armo.id_armo) + ", se Pianificata ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	
return k_return


end function

public function boolean consenti_forza_stampa_attestato (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Richiesta se Riferimento e' possibile forzarne la stampa o meno dell'Attestato
//--- 
//--- Argomenti: st_meca   riempire il ID del Riferimento
//---
//--- Ritorno: TRUE = autorizzato
//---
//---
boolean k_return = false
boolean k_att_stampato=false
st_esito kst_esito //, kst_esito_appo
st_tab_armo kst_tab_armo
st_tab_certif kst_tab_certif
kuf_certif kuf1_certif


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

//--- Controlla se ATTESTATO è stato già stampato
	kuf1_certif = create kuf_certif
	kst_tab_certif.id_meca = kst_tab_meca.id
	kuf1_certif.get_id_da_id_meca(kst_tab_certif) 
	if kst_tab_certif.id > 0 then
		k_att_stampato = kuf1_certif.if_stampato(kst_tab_certif)
	end if
	
	if k_att_stampato then
		kst_esito.esito = kkg_esito.db_wrn // da non forzare è già stampato!
	else
//--- leggo archivi se lotto chiuso allora posso compiere la forzatura
		SELECT 	meca.cert_forza_stampa
						,meca.err_lav_ok
						,meca.data_lav_fin
				into
							:kst_tab_meca.cert_forza_stampa,   
							:kst_tab_meca.err_lav_ok,   
						:kst_tab_meca.data_lav_fin   
				 FROM meca  
				 where id = :kst_tab_meca.id  
					 using sqlca;
			
		if sqlca.sqlcode = 0 then
			if kst_tab_meca.cert_forza_stampa = ki_cert_forza_stampa_SI then
				k_return = true  // AUTORIZZATO
			else
	
//--- controllo se x il lotto sono stati trattati e convalidati tutti i barcode da lavorare
				if (kst_tab_meca.err_lav_ok > " " and not isnull(kst_tab_meca.err_lav_ok)) then // convalidati?
					kst_tab_armo.id_meca = kst_tab_meca.id 
					if if_lotto_completo(kst_tab_armo) then  //trattato?
						k_return = true // AUTORIZZATO
//					else
//						kst_esito.esito = kkg_esito.blok
					end if
//				else
//					kst_esito.esito = kkg_esito.blok
				end if
			end if
			
		else 
//--- se errore			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante Autorizzazione per la Forzatura Stampa Attestato (Lotto id= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
										 
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)					
				throw kguo_exception
			end if
		end if
	end if	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return 

end function

public function boolean consenti_aut_stampa_attestato_farma (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Autorizzazione alla Stampa dell'Attestato di Lotto con mat.Farmaceutico
//--- 
//--- Argomenti: st_meca   riempire il ID del Riferimento
//---
//--- Ritorno: TRUE = autorizzato
//---
//---
boolean k_return = false
boolean k_autorizza
st_open_w kst_open_w
st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_meca_aut_st_certif_farma  // ECCEZIONE DA SANARE

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then
else

	kuf1_sl_pt = create kuf_sl_pt
	kst_tab_sl_pt.tipo = kuf1_sl_pt.ki_tipo_prodotto_farmaceutico

//--- leggo archivi se lotto chiuso allora posso compiere la forzatura
	SELECT 
	      max(armo.magazzino)
	      ,min(meca.err_lav_ok)
	      ,min(meca.data_lav_fin)
			,max(certif.data_stampa)
				into
               :kst_tab_armo.magazzino,   
               :kst_tab_meca.err_lav_ok,   
		         :kst_tab_meca.data_lav_fin, 
					:kst_tab_certif.data_stampa 
			 FROM ((meca left outer join certif on
			      meca.id = certif.id_meca)
					     left outer join armo on
			      meca.id = armo.id_meca)
					     left outer join sl_pt on 
					armo.cod_sl_pt = sl_pt.cod_sl_pt	  
  			 where meca.id = :kst_tab_meca.id  
				    and sl_pt.tipo = :kst_tab_sl_pt.tipo
				 using sqlca;
		
	if sqlca.sqlcode = 0 then
		if (isnull(kst_tab_certif.data_stampa) or kst_tab_certif.data_stampa <= date(0)) &
			and (kst_tab_armo.magazzino < 2  &
          or ( &			
			   not isnull(kst_tab_meca.err_lav_ok) and kst_tab_meca.err_lav_ok <> '0' &
				and kst_tab_meca.data_lav_fin > date(0) &
			    ) &
			   ) then
			k_return = true  // AUTORIZZATO
//		else
//			kst_esito.esito = kkg_esito.blok
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante Autorizzazione per la Forzatura Stampa Attestato Farmaceutico (id Lotto= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
										 
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)					
			throw kguo_exception
		end if
	end if
	
	
end if

return k_return

end function

public function boolean consenti_aut_stampa_attestato_alimentare (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Autorizzazione alla Stampa dell'Attestato di Lotto con mat.Alimentare
//--- 
//--- Argomenti: st_meca   riempire il ID del Riferimento
//---
//--- Ritorno: Esito (st_esito) come da Standard
//---
//---
boolean k_return = false
boolean k_autorizza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza

kuf_sl_pt kuf1_sl_pt

st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_armo kst_tab_armo
st_tab_sl_pt kst_tab_sl_pt

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = kkg_id_programma_meca_aut_st_certif_aliment // ECCEZIONE DA SANARE

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then
else

	kuf1_sl_pt = create kuf_sl_pt
	kst_tab_sl_pt.tipo = kuf1_sl_pt.ki_tipo_prodotto_alimentare

//--- leggo archivi se lotto chiuso allora posso compiere la forzatura
	SELECT 
	      max(armo.magazzino)
	      ,min(meca.err_lav_ok)
	      ,min(meca.data_lav_fin)
			,max(certif.data_stampa)
				into
               :kst_tab_armo.magazzino,   
               :kst_tab_meca.err_lav_ok,   
		         :kst_tab_meca.data_lav_fin, 
					:kst_tab_certif.data_stampa 
			 FROM ((meca left outer join certif on
			      meca.id = certif.id_meca)
					     left outer join armo on
			      meca.id = armo.id_meca)
					     left outer join sl_pt on 
					armo.cod_sl_pt = sl_pt.cod_sl_pt	  
  			 where meca.id = :kst_tab_meca.id  
				    and sl_pt.tipo = :kst_tab_sl_pt.tipo 
				 using sqlca;
		
	if sqlca.sqlcode = 0 then
		if (isnull(kst_tab_certif.data_stampa) or kst_tab_certif.data_stampa <= date(0)) &
			and (kst_tab_armo.magazzino < 2  &
          or ( not isnull(kst_tab_meca.err_lav_ok) & 
			   and kst_tab_meca.err_lav_ok <> '0' and kst_tab_meca.data_lav_fin > date(0) &
			    ) &
			   ) then
			k_return = true  // AUTORIZZATO
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante Autorizzazione per la Forzatura Stampa Attestato Alimentare (id Lotto= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
									 
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)					
			throw kguo_exception
		end if
	end if
		
end if


return k_return

end function

public subroutine forza_stampa_attestato (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Aggiorna il flag di 'forza stampa attestato' nella tabella MECA
//=== 
//=== input: operazione 1=flag a forza stampa attestato
//===                   2=resetta flag
//===        st_tab_meca valorizzando il campo ID
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id 
st_tab_artr kst_tab_artr
st_esito kst_esito, kst_esito_1
//st_open_w kst_open_w
kuf_artr kuf1_artr
//kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

k_autorizza = consenti_forza_stampa_attestato(kst_tab_meca)   // utente autorizzato?

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Autorizzazione alla Forzatura della stampa Attestato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)					
	throw kguo_exception
	
end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if k_operazione = 1 then
		update meca
			set cert_forza_stampa = '1',
			    x_data_cert_f_st = :kst_tab_meca.x_datins,
			    x_utente_cert_f_st = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	else
		update meca
			set cert_forza_stampa = '',
			    x_data_cert_f_st = :kst_tab_meca.x_datins,
			    x_utente_cert_f_st = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	end if	
	if sqlca.sqlcode = 0 then
		kst_esito = kGuf_data_base.db_commit_1()   //COMMIT se tutto ok
	else
		kGuf_data_base.db_rollback_1()   //ROLLBACK se tutto ok
	end if

	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento Autorizzazione Forzatura Stampa Attestato (Lotto id= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)					
		throw kguo_exception
			
	end if



end subroutine

public subroutine aut_stampa_attestato_farma (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Aggiorna il flag di 'stampa attestato tipo Farmaceutico' nella tabella MECA
//=== 
//=== input: operazione 1=flag a forza stampa attestato
//===                   2=resetta flag
//===        st_tab_meca valorizzando il campo ID
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_autorizza
st_esito kst_esito, kst_esito_1
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = kkg_id_programma_meca_aut_st_certif_farma
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

k_autorizza = consenti_aut_stampa_attestato_farma(kst_tab_meca)   // utente autorizzato?

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Autorizzazione alla Forzatura della stampa Attestato Farmaceutico: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)					
	throw kguo_exception

end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if k_operazione = 1 then
		update meca
			set cert_farma_st_ok = '1',
			    x_data_cert_farma = :kst_tab_meca.x_datins,
			    x_utente_cert_farm = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	else
		update meca
			set cert_farma_st_ok = '',
			    x_data_cert_farma = :kst_tab_meca.x_datins,
			    x_utente_cert_farm = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	end if	
	if sqlca.sqlcode = 0 then
		kst_esito = kGuf_data_base.db_commit_1()   //COMMIT se tutto ok
	else
		kGuf_data_base.db_rollback_1()   //ROLLBACK se tutto ok
	end if

	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento Autorizzazione Forzatura Stampa Attestato Farmaceutico (Lotto id= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)					
		throw kguo_exception
			
	end if



end subroutine

public subroutine aut_stampa_attestato_alimentare (integer k_operazione, st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Aggiorna il flag di 'stampa attestato tipo Alimentare' nella tabella MECA
//=== 
//=== input: operazione 1=flag a forza stampa attestato
//===                   2=resetta flag
//===        st_tab_meca valorizzando il campo ID
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_autorizza
st_esito kst_esito, kst_esito_1
//st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//kst_open_w.id_programma = kkg_id_programma_meca_aut_st_certif_aliment
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

k_autorizza = consenti_aut_stampa_attestato_alimentare(kst_tab_meca)   // utente autorizzato?

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Autorizzazione alla Forzatura della stampa Attestato Alimentare: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)					
	throw kguo_exception

end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if k_operazione = 1 then
		update meca
			set cert_aliment_st_ok = '1',
			    x_data_cert_alim = :kst_tab_meca.x_datins,
			    x_utente_cert_alim = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	else
		update meca
			set cert_aliment_st_ok = '',
			    x_data_cert_alim = :kst_tab_meca.x_datins,
			    x_utente_cert_alim = :kst_tab_meca.x_utente,
			    x_datins = :kst_tab_meca.x_datins,
			    x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id  
			using sqlca;
	end if	
	if sqlca.sqlcode = 0 then
		kst_esito = kGuf_data_base.db_commit_1()   //COMMIT se tutto ok
		if kst_esito.esito <> kkg_esito.ok then
			sqlca.sqlcode = kst_esito.sqlcode
			sqlca.sqlerrtext = kst_esito.SQLErrText
		end if
	else
		kGuf_data_base.db_rollback_1()   //ROLLBACK se tutto ok
	end if

	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento Autorizzazione Forzatura Stampa Attestato Alimentare (Lotto id= " &
							 + string(kst_tab_meca.id) + " " &
							 + ")~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)					
		throw kguo_exception
			
	end if



end subroutine

public function string get_stato_descrizione (st_tab_meca_stato ast_tab_meca_stato) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna la descrizione dello STATO del Lotto 
//--- 
//--- 
//---  input: st_tab_meca_stato.codice  es. 3
//---  Output: 
//---  rit.: descrizione
//---  Lancia Exception
//---------------------------------------------------------------------------------------------
//
string k_return = ""
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if isnull(ast_tab_meca_stato.codice) then
		ast_tab_meca_stato.codice = ki_meca_stato_ok
	end if

	ast_tab_meca_stato.descrizione = ""
	SELECT descrizione
			 INTO 
					:ast_tab_meca_stato.descrizione 
			 FROM meca_stato  
			WHERE meca_stato.codice = :ast_tab_meca_stato.codice 
				 using sqlca;
			
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		ast_tab_meca_stato.descrizione = "stato:" + string(ast_tab_meca_stato.codice) + "(????????)"
		kst_esito.SQLErrText = "Stato Lotto non riconosciuto (" + string(ast_tab_meca_stato.codice) + ") " + "~n~r" + trim(SQLCA.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(ast_tab_meca_stato.descrizione) > " " then
		k_return = ast_tab_meca_stato.descrizione 
	end if

return k_return 

end function

public function long get_contratto (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il codice il ID del Contratto del Lotto 
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Outout: kst_tab_meca.contratto  id del contratto
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
long k_return = 0
int k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT contratto
			 INTO 
					:kst_tab_meca.contratto
			 FROM meca
			WHERE meca.id = :kst_tab_meca.id 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Codice Contratto Lotto non Trovato (" + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	else
		if kst_tab_meca.contratto > 0 then
			k_return = kst_tab_meca.contratto
		end if
	end if

return k_return

end function

public function long tb_update_meca_all (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------
//--- Aggiunge/Aggiorna rek nella tabella DATI TESTATA LOTTO
//--- 
//--- Input: st_tab_meca     id=0  fa la INSERT
//---                    id>0  fa la UPDATE
//---
//--- Ritorna:  id_meca
//--- 
//------------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	
	if kst_tab_meca.id = 0 then
		kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	else
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	end if
	//--- controlla se utente autorizzato alla funzione in atto
	k_rc = if_sicurezza(kst_open_w.flag_modalita)
	
	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_meca(kst_tab_meca)

//--- se ID_meca e' zero allora INSERT
	if kst_tab_meca.id = 0 then
			 //id, 
		INSERT INTO meca  
					(  
					  num_int,   
					  data_int,   
					  id_wm_pklist,   
					  num_bolla_in,   
					  data_bolla_in,   
					  consegna_data,   
					  clie_1,   
					  clie_2,   
					  clie_3,   
					  contratto,   
					  area_mag,   
					  aperto,   
					  stato,   
					  stato_in_attenzione,
					  data_lav_fin,   
					  err_lav_fin,   
					  err_lav_ok,   
					  note_lav_ok,   
					  cert_forza_stampa,   
					  x_data_cert_f_st,   
					  x_utente_cert_f_st,   
					  cert_farma_st_ok,   
					  x_data_cert_farma,   
					  x_utente_cert_farm,   
					  cert_aliment_st_ok,   
					  x_data_cert_alim,   
					  x_utente_cert_alim,   
					  e1doco,
					  e1rorn,
					  x_datins,   
					  x_utente )  
			  VALUES 
						( 
						  :kst_tab_meca.num_int,   
						  :kst_tab_meca.data_int,   
						  :kst_tab_meca.id_wm_pklist ,   
						  :kst_tab_meca.num_bolla_in,   
						  :kst_tab_meca.data_bolla_in,   
						  :kst_tab_meca.consegna_data,   
						  :kst_tab_meca.clie_1,   
						  :kst_tab_meca.clie_2,   
						  :kst_tab_meca.clie_3,   
						  :kst_tab_meca.contratto,   
						  :kst_tab_meca.area_mag,   
						  :kst_tab_meca.aperto,   
						  :kst_tab_meca.stato,   
						  :kst_tab_meca.stato_in_attenzione ,
						  :kst_tab_meca.data_lav_fin,   
						  :kst_tab_meca.err_lav_fin,   
						  :kst_tab_meca.err_lav_ok,   
						  :kst_tab_meca.note_lav_ok,   
						  :kst_tab_meca.cert_forza_stampa,   
						  :kst_tab_meca.x_data_cert_f_st,   
						  :kst_tab_meca.x_utente_cert_f_st,   
						  :kst_tab_meca.cert_farma_st_ok,   
						  :kst_tab_meca.x_data_cert_farma,   
						  :kst_tab_meca.x_utente_cert_farm,   
						  :kst_tab_meca.cert_aliment_st_ok,   
						  :kst_tab_meca.x_data_cert_alim,   
						  :kst_tab_meca.x_utente_cert_alim,   
						  :kst_tab_meca.e1doco,   
						  :kst_tab_meca.e1rorn,   
						  :kst_tab_meca.x_datins,   
						  :kst_tab_meca.x_utente )  
						using kguo_sqlca_db_magazzino;

//--- recupera il valore serial
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			kst_tab_meca.id = get_id_meca_max( )	
			//kst_tab_meca.id = long(kguo_sqlca_db_magazzino.SQLReturnData) 
		end if
		
	else

		UPDATE meca  
					  SET 
					  num_int = :kst_tab_meca.num_int ,   
					  data_int = :kst_tab_meca.data_int ,   
					  id_wm_pklist = :kst_tab_meca.id_wm_pklist ,   
					  num_bolla_in = :kst_tab_meca.num_bolla_in ,   
					  data_bolla_in = :kst_tab_meca.data_bolla_in ,   
					  consegna_data = :kst_tab_meca.consegna_data ,   
					  clie_1 = :kst_tab_meca.clie_1 ,   
					  clie_2 = :kst_tab_meca.clie_2 ,   
					  clie_3 = :kst_tab_meca.clie_3 ,   
					  contratto = :kst_tab_meca.contratto ,   
					  area_mag = :kst_tab_meca.area_mag ,   
					  aperto = :kst_tab_meca.aperto ,   
					  stato = :kst_tab_meca.stato ,   
					  stato_in_attenzione = :kst_tab_meca.stato_in_attenzione ,   
					  data_lav_fin = :kst_tab_meca.data_lav_fin ,   
					  err_lav_fin = :kst_tab_meca.err_lav_fin ,   
					  err_lav_ok = :kst_tab_meca.err_lav_ok ,   
					  note_lav_ok = :kst_tab_meca.note_lav_ok ,   
					  cert_forza_stampa = :kst_tab_meca.cert_forza_stampa ,   
					  x_data_cert_f_st = :kst_tab_meca.x_data_cert_f_st ,   
					  x_utente_cert_f_st = :kst_tab_meca.x_utente_cert_f_st ,   
					  cert_farma_st_ok = :kst_tab_meca.cert_farma_st_ok ,   
					  x_data_cert_farma = :kst_tab_meca.x_data_cert_farma ,   
					  x_utente_cert_farm = :kst_tab_meca.x_utente_cert_farm ,   
					  cert_aliment_st_ok = :kst_tab_meca.cert_aliment_st_ok ,   
					  x_data_cert_alim = :kst_tab_meca.x_data_cert_alim ,   
					  x_utente_cert_alim = :kst_tab_meca.x_utente_cert_alim ,   
					  x_datins = :kst_tab_meca.x_datins ,   
					  x_utente = :kst_tab_meca.x_utente
					WHERE meca.id =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;
					
	end if	
	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento testata Lotto (meca): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if

return k_return

end function

public subroutine set_consegna_data (st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Aggiorna il numero colli FATTURATI
//--- 
//--- Input: st_tab_meca     id
//---                        consegna_data 
//---
//--- Lancia Exception x errore
//--- 
//------------------------------------------------------------------------------------------------
long k_rcn
boolean k_rc
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_meca.id > 0 then
	
//	if isnull(kst_tab_meca.consegna_data) then
//		 kst_tab_meca.consegna_data = date(0)
//	end if
	
	UPDATE meca  
			SET 	consegna_data = :kst_tab_meca.consegna_data
			WHERE meca.id = :kst_tab_meca.id   
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento della Data di Consegna Lotto (meca), ID:" + string(kst_tab_meca.id) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
			
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if
	end if

else
	kst_esito.SQLErrText = "Manca ID Lotto per eseguire l'aggiornamento della Data di Consegna"
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if



end subroutine

public function string get_cod_sl_pt_x_id_meca (ref st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Get dal Lotto del cod SL-PT più alto x id lotto
//=== 
//=== Input: id_meca;
//=== Rit: codice SL-PT (cod_sl_pt)
//===   
//====================================================================
string k_return=""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- 
	select max(armo.cod_sl_pt)
        into :ast_tab_armo.cod_sl_pt
      from armo 
		where armo.id_meca = :ast_tab_armo.id_meca
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if trim(ast_tab_armo.cod_sl_pt) > " " then
			k_return = ast_tab_armo.cod_sl_pt
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca del codice Piano di Trattamento per ID Lotto " + string(ast_tab_armo.id_meca) + " ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kGuo_exception = create uo_exception
			kGuo_exception.set_esito( kst_esito )
			throw kGuo_exception
		end if
	end if
	
	
return k_return


end function

public subroutine get_dati_certif (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Torna alcuni dati circa l'attestato: autorizzazioni / sblocco
//--- 
//--- Input : st_tab_meca.id 
//--- out: alcuni dati nella st_tab_meca
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select   cert_aliment_st_ok
			  ,x_data_cert_alim
			  ,x_utente_cert_alim 
			  ,cert_farma_st_ok
			  ,x_data_cert_farma 
			  ,x_utente_cert_farm
			  ,cert_forza_stampa 
			  ,x_data_cert_f_st
			  ,x_utente_cert_f_st
  		into :kst_tab_meca.cert_aliment_st_ok
			,:kst_tab_meca.x_data_cert_alim
			,:kst_tab_meca.x_utente_cert_alim
			,:kst_tab_meca.cert_farma_st_ok
			,:kst_tab_meca.x_data_cert_farma
			,:kst_tab_meca.x_utente_cert_farm
			,:kst_tab_meca.cert_forza_stampa
			,:kst_tab_meca.x_data_cert_f_st
			,:kst_tab_meca.x_utente_cert_f_st
		from meca 
		where meca.id = :kst_tab_meca.id
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dati Autorizzazione e Sblocco Attestato (meca). Esito: " + sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if
	end if
	
	

end subroutine

public function boolean set_err_lav_ok (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//----------------------------------------------------------------------
//--- Aggiorna flag esito dosimetria ERR_LAV_OK / NOTE_LAV_OK del Lotto  
//--- 
//--- Input : st_tab_meca.ID  ,  err_lav_ok , note_lav_ok
//--- boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//----------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if ast_tab_meca.id > 0 then

		kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

//--- Aggiorna lo stato e le note della rilevazione dosimetrica	
		update meca set 	 
			 err_lav_ok  = :ast_tab_meca.err_lav_ok
			 ,note_lav_ok = :ast_tab_meca.note_lav_ok
			 ,x_datins = :kst_tab_meca.x_datins
			 ,x_utente = :kst_tab_meca.x_utente
		where id = :ast_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode 
			kst_esito.SQLErrText = "Errore durante aggiornamento Convalida dosimetrica, id Lotto: " + string(ast_tab_meca.id) + "~n~r" &
									+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if	

//--- se arriva qui tutto OK	
		k_return = true
		if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Aggiornamento Convalida dosimetrica non eseguita, manca id Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
catch (uo_exception kuo_exception)
	if	kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if			
	throw kuo_exception
	
finally
	
end try

return k_return

end function

public function boolean set_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta Work Order di E1 (id Lotto riconosciuto su E1)
//=== 
//=== Input : kst_tab_meca.id e e1doco
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se errore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_tab_meca kst_tab_meca_appo
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in aggiornamento del Work Order di E1 in testata Lotto ('e1doco'). Manca ID Lotto"
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_meca.e1doco) then
		kst_tab_meca.e1doco = 0
	end if

//--- aggiorna la testa del lotto
	update meca
				set e1doco = :kst_tab_meca.e1doco
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento del Work Order di E1 in testata Lotto ('e1doco'=" + string(kst_tab_meca.e1doco)+ "), ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if
		
//--- se arriva qui tutto OK	
	k_return = true
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try


return k_return

end function

public function long get_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il codice Work Order di E1 
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Out: kst_tab_meca.e1doco  
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1doco
			 INTO 
					:kst_tab_meca.e1doco
			 FROM meca
			WHERE meca.id = :kst_tab_meca.id 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Codice WO di E1 nel Lotto non Trovato (" + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.e1doco > 0 then
		k_return = kst_tab_meca.e1doco
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function long get_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Legge codice packing list ID_WM_PKLIST del Movimento
//--- 
//--- 
//---  input: st_tab_meca.id 
//---  out/return: st_tab_armo.id_wm_pklist
//---  exception: ST_ESITO, Esiti: 0=OK; 100=not found
//---                                     1=errore grave
//---                                     2=errore > 0
//---                                     
//------------------------------------------------------------------
//
long k_return = 0
st_esito kst_esito

try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT 
				id_wm_pklist
			 INTO 
					:kst_tab_meca.id_wm_pklist
			 FROM meca
			WHERE id = :kst_tab_meca.id
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettuta 'cod. Packing List' su Testata  Lotto (id " + string(kst_tab_meca.id) + ") " &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if isnull(kst_tab_meca.id_wm_pklist) then kst_tab_meca.id_wm_pklist = 0

	k_return = kst_tab_meca.id_wm_pklist

catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

public function integer get_colli_entrati_riga_datrattare (st_tab_armo kst_tab_armo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il nr colli entrati x riga Lotto con no dose zero e magazzino 1 
//--- 
//--- Input : kst_tab_armo.id_armo 
//--- Ritorna st_esito :  come standard
//---					: kst_tab_armo.colli_2
//---   
//--------------------------------------------------------------------
int k_return = 0
st_esito kst_esito

try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	if kst_tab_armo.id_armo > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id riga Lotto, lettura colli non può essere eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	//--- conta il numero di colli entrati
	select colli_2
			into :kst_tab_armo.colli_2
			from armo 
			where armo.id_armo = :kst_tab_armo.id_armo
				and armo.dose > 0 and armo.cod_sl_pt > ' ' and armo.magazzino <> 1 and armo.magazzino <> 9
			using kguo_sqlca_db_magazzino;
	
	//--giu/2016	   and armo.magazzino <> 1 and armo.magazzino <> 9 and (armo.magazzino <> 2 or (armo.dose > 0 and armo.cod_sl_pt <> ''))
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.SQLErrText = "Errore in lettura numero colli riga Lotto da trattare (id riga: " + string(kst_tab_armo.id_armo) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function integer get_colli_entrati_datrattare (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//-----------------------------------------------------------------
//--- Torna il nr colli entrati totali Lotto no dose zero e magazzino 1 
//--- 
//--- inp : kst_tab_armo.id_meca 
//--- rit: kst_tab_armo.colli_2
//--- exception: st_esito  come standard
//---   
//-----------------------------------------------------------------
int k_return=0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	if kst_tab_armo.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id Lotto, il conteggio colli da trattare non può essere fatto!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	//--- conta il numero di colli entrati
	select sum(colli_2)
			into :kst_tab_armo.colli_2
			from armo 
			where armo.id_meca = :kst_tab_armo.id_meca
				and armo.dose > 0 and armo.cod_sl_pt > ' ' and armo.magazzino <> 1 and armo.magazzino <> 9
			using kguo_sqlca_db_magazzino;
	
	//--giu/2016	   and armo.magazzino <> 1 and armo.magazzino <> 9 and (armo.magazzino <> 2 or (armo.dose > 0 and armo.cod_sl_pt <> ''))
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.SQLErrText = "Errore in lettura conteggio colli da trattare del Lotto (id Lotto: " + string(kst_tab_armo.id_meca) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try
	
return k_return 

end function

public function integer get_colli_danontrattare (st_tab_armo kst_tab_armo) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna il nr colli da non Trattare (es restituiti)
//--- 
//--- Inp : kst_tab_armo.id_meca 
//--- ritorna: st_tab_armo.colli_2 = colli da non trattare
//--- exception: st_esito  come standard
//---					
//---   
//------------------------------------------------------------------
int k_return = 0
st_esito kst_esito
date k_data_0 = date(0)
kuf_barcode kuf1_barcode
string k_causale

try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_armo.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id Lotto, lettura totale colli da non trattare non può essere eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_causale = kuf1_barcode.ki_causale_non_trattare
	
//--- conta il numero colli che hanno il flag su barcode da-non-lavorare
	select count(*)
			into :kst_tab_armo.colli_2
			from armo inner join barcode on 
			   	 		  armo.id_meca = barcode.id_meca 
					 and barcode.causale = :k_causale
			where armo.id_meca = :kst_tab_armo.id_meca
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.SQLErrText = "Errore in lettura numero colli totali da non trattare per Lotto (id Lotto: " + string(kst_tab_armo.id_meca) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return 

end function

public function boolean tb_update_data_lav_fin (st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Aggiunge/Aggiorna rek nella tabella DATA FINE LAVORAZIONE
//--- 
//--- Input: st_tab_meca     id,  data_lav_fin
//--- Rit: TRUE = aggiornato
//--- exception  ST_ESITO, Esiti:  STANDARD; 
//--- 
//------------------------------------------------------------------
boolean k_return=false
long k_rcn
boolean k_rc
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if_isnull_meca(kst_tab_meca)

	//--- controlla se utente autorizzato alla funzione in atto
	k_rc = if_sicurezza(kkg_flag_modalita.modifica)
	if not k_rc then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	UPDATE meca
			    SET data_lav_fin = :kst_tab_meca.data_lav_fin ,   
					  x_datins = :kst_tab_meca.x_datins ,   
					  x_utente = :kst_tab_meca.x_utente
					WHERE id =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;
					
				
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.dati 'Lotto': " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			 kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return 

end function

public function long get_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna il codice Work Order di E1 
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Out: kst_tab_meca.e1rorn  
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1rorn
			 INTO 
					:kst_tab_meca.e1rorn
			 FROM meca
			WHERE meca.id = :kst_tab_meca.id 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Codice WO di E1 nel Lotto non Trovato (" + string(kst_tab_meca.id) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.e1rorn > 0 then
		k_return = kst_tab_meca.e1rorn
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function boolean set_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta Sales Order di E1 (id su E1)
//=== 
//=== Input : kst_tab_meca.id e e1rorn
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se errore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_tab_meca kst_tab_meca_appo
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in aggiornamento del Sales Order di E1 in testata Lotto ('e1doco'). Manca ID Lotto"
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_meca.e1rorn) then
		kst_tab_meca.e1rorn = 0
	end if

//--- aggiorna la testa del lotto
	update meca
				set e1rorn = :kst_tab_meca.e1rorn
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento campo Sales Order di E1 in testata Lotto ('e1rorn'=" + string(kst_tab_meca.e1rorn)+ "), ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if
		
//--- se arriva qui tutto OK	
	k_return = true
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try


return k_return

end function

public function integer get_colli_trattati (st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il nr colli gia' Trattati
//=== 
//=== Input : kst_tab_armo.id_meca 
//=== Ritorna st_esito :  come standard
//===					kst_tab_armo.colli_2 = colli trattati
//===   
//====================================================================
int k_return = 0
st_esito kst_esito
date k_data_0 = date(0)


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- conta il numero di colli trattati
	kst_tab_armo.colli_2 = 0
	select count(*)
			into :kst_tab_armo.colli_2
			from barcode 
			where barcode.id_meca = :kst_tab_armo.id_meca
			      and (barcode.data_lav_fin > :k_data_0 )
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura colli Trattati id lotto: " + string(kst_tab_armo.id_meca) &
							+ "~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if
	
return k_return

end function

public function integer get_colli_in_lav (ref st_tab_armo kst_tab_armo) throws uo_exception;//
//====================================================================
//=== Torna il nr colli in TRATTAMENTO (senza data fine lav)
//=== 
//=== Input : kst_tab_armo.id_meca 
//=== Ritorna st_esito :  come standard
//===					kst_tab_armo.colli_2 = colli in lav
//===   
//====================================================================
int k_return = 0
st_esito kst_esito
date k_data_0 = date(0)

	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli in LAV
	kst_tab_armo.colli_2 = 0
	select count(*)
			into :kst_tab_armo.colli_2
			from barcode 
			where barcode.id_meca = :kst_tab_armo.id_meca
			      and (barcode.data_lav_ini > :k_data_0 and (barcode.data_lav_fin is null or barcode.data_lav_fin  <= :k_data_0 ))
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.SQLErrText = "Errore in lettura colli in Lavorazione id lotto: " + string(kst_tab_armo.id_meca) &
							+ "~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if
	
return k_return

end function

public function integer get_colli_entrati_conto_deposito (st_tab_armo kst_tab_armo) throws uo_exception;//
//-----------------------------------------------------------------
//--- Torna il nr colli entrati totali per Lotto in Conto Deposito
//--- 
//--- inp : kst_tab_armo.id_meca 
//--- rit: kst_tab_armo.colli_2
//--- exception: st_esito  come standard
//---   
//-----------------------------------------------------------------
int k_return=0
int k_magazzino_DP
st_esito kst_esito


kst_esito.esito = kkg_esito.ok  
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	if kst_tab_armo.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca id Lotto, conteggio colli per Conto Deposito non può essere fatto!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	//--- conta il numero di colli entrati
	k_magazzino_DP = kki_magazzino_DP
	select sum(colli_2)
			into :kst_tab_armo.colli_2
			from armo 
			where armo.id_meca = :kst_tab_armo.id_meca
				and armo.magazzino = :k_magazzino_DP
			using kguo_sqlca_db_magazzino;
	
	//--giu/2016	   and armo.magazzino <> 1 and armo.magazzino <> 9 and (armo.magazzino <> 2 or (armo.dose > 0 and armo.cod_sl_pt <> ''))
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.SQLErrText = "Errore in lettura conteggio colli per Conto Deposito del Lotto (id Lotto: " + string(kst_tab_armo.id_meca) + ") " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_armo.colli_2 > 0 then
		k_return = kst_tab_armo.colli_2
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try
	
return k_return 

end function

public function boolean if_lotto_farmaceutico (st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se Lotto contenente materiale Farmaceutico
//=== 
//=== input:     st_tab_meca valorizzando il campo ID
//=== Out: TRUE = materiale farmaceutico
//=== Ritorna tab. ST_ESITO, Esiti:   kkg_esito.ok=e' 
//===                                 kkg_esito.not_fnd=no farmaceutico
//===                              altrimenti errore standard
//=== 
//====================================================================
boolean k_return=true
st_esito kst_esito
int k_ctr
st_tab_sl_pt kst_tab_sl_pt
kuf_sl_pt kuf1_sl_pt



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kuf1_sl_pt = create kuf_sl_pt
	kst_tab_sl_pt.tipo = kuf1_sl_pt.ki_tipo_prodotto_farmaceutico
	destroy kuf1_sl_pt
	
	select count(*) into :k_ctr
      from armo inner join sl_pt on
		     armo.cod_sl_pt = sl_pt.cod_sl_pt
		where armo.id_meca = :kst_tab_meca.id
		      and sl_pt.tipo = :kst_tab_sl_pt.tipo
			using kguo_sqlca_db_magazzino; 

	if kguo_sqlca_db_magazzino.sqlcode >= 0 then
		if k_ctr = 0 or kguo_sqlca_db_magazzino.sqlcode = 100 then
			k_return = false
			//kst_esito.esito = kkg_esito.not_fnd   //--- nessun record trovato
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in verifica se Materiale farmaceutico per il Lotto n. " + string(kst_tab_meca.id)+ " - errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


return k_return

end function

public subroutine set_data_ent (st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Aggiorna Data di entrata merce
//--- 
//--- Input: st_tab_meca     id
//---                        data_ent  (se null imposta data a zero)
//---
//--- Lancia Exception x errore
//--- 
//------------------------------------------------------------------------------------------------
long k_rcn
boolean k_rc
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_meca.id > 0 then
	
	if isnull(kst_tab_meca.data_ent) then
		 kst_tab_meca.data_ent = datetime(date(0), time(0))
	end if
	
	UPDATE meca 
			SET data_ent = :kst_tab_meca.data_ent
			WHERE meca.id = :kst_tab_meca.id   
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento data entrata Lotto " + string(kst_tab_meca.data_ent) + " (meca), ID: " + string(kst_tab_meca.id) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
			
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if
	end if

else
	kst_esito.SQLErrText = "Manca ID Lotto per eseguire l'aggiornamento della Data di Entrata Lotto"
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if



end subroutine

public function datetime get_data_ent (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Torna alcuni dati di Testata Lotto  da ID  come Numero e Data del Lotto ecc...
//--- 
//--- Input : st_tab_meca.id 
//--- out: alcuni dati nella st_tab_meca
//--- Ritorna: nulla 
//--- Exception se erore con st_esito valorizzato
//---					
//---   
//--------------------------------------------------------------------------------------------------------
datetime k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- conta il numero di colli entrati
	select data_ent
		into :kst_tab_meca.data_ent
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = kst_tab_meca.data_ent
	else
		kst_tab_meca.num_int = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Lotto per data di entrata merce~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
return k_return

end function

public function boolean set_e1srst (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta Stato di E1 
//=== 
//=== Input : kst_tab_meca.id e e1srst
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se errore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_tab_meca kst_tab_meca_appo
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in aggiornamento del Stato di E1 in testata Lotto ('e1doco'). Manca ID Lotto"
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_meca.e1srst) then
		kst_tab_meca.e1srst = ""
	end if

//--- aggiorna la testa del lotto
	update meca
				set e1srst = :kst_tab_meca.e1srst
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento campo Stato di E1 in testata Lotto ('e1srst'=" + string(kst_tab_meca.e1srst)+ "), ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if
		
//--- se arriva qui tutto OK	
	k_return = true
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try


return k_return

end function

public function long set_aperto_no_spediti (st_tab_meca ast_tab_meca) throws uo_exception;//
//--- 
//--- Chiude uno/tutti i Lotti che hanno già spedito Tutto
//--- input: st_tab_meca.id se   0=chiude tutti i Lotti; se >0 chiude solo 1 lotto
//---   
//--- ret: nr righe aggiornate
//---   
//
long k_return = 0
long k_riga = 0, k_righe=0
long k_rc = 0, k_ctr_commit=0, k_st_update=0, k_rec_update=0
st_tab_armo kst_tab_armo
st_esito kst_esito
datastore kds_meca_da_chiudere
//kds_armo_prezzi_qta_x_id_meca


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if NOT if_sicurezza(kkg_flag_modalita.modifica) then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata funzione: " + get_id_programma(kkg_flag_modalita.modifica) + "~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		
	else		
		kds_meca_da_chiudere = create datastore
		kds_meca_da_chiudere.dataobject = "ds_meca_da_chiudere"
		kds_meca_da_chiudere.settransobject( kguo_sqlca_db_magazzino )

//		kds_armo_prezzi_qta_x_id_meca = create datastore
//		kds_armo_prezzi_qta_x_id_meca.dataobject = "ds_armo_prezzi_qta_x_id_meca"
//		kds_armo_prezzi_qta_x_id_meca.settransobject( kguo_sqlca_db_magazzino )

		
		if isnull(ast_tab_meca.id) then ast_tab_meca.id = 0
		if isnull(ast_tab_meca.data_int) or ast_tab_meca.data_int = date(0) then   // data fino alla quale fare i controlli di Chiusura (x evitare lotti recenti)
			ast_tab_meca.data_int = relativedate(kguo_g.get_dataoggi( ), -60)
		end if
		
		k_righe = kds_meca_da_chiudere.retrieve(ast_tab_meca.id, ast_tab_meca.data_int)
		
//--- imposta i valori su tutte le righe	da aggiornare	
		for k_riga = 1 to k_righe

			kst_tab_armo.id_meca = kds_meca_da_chiudere.object.id_meca.Primary[k_riga]
//--- calcola se ci sono ancora colli in giacenza
			if get_colli_in_giacenza_x_id_meca(kst_tab_armo) = 0 then  // solo se NON ci sono colli ancora in giacenza....

//--- verifica se ci sono prezzi righe ancora aperte			
//				k_rc = kds_armo_prezzi_qta_x_id_meca.retrieve(kds_meca_da_chiudere.object.id_meca.Primary[k_riga])
//				if k_rc > 0 then
//					k_rc = kds_armo_prezzi_qta_x_id_meca.getitemnumber(1, "item_dafatt") 
//				end if
//				if k_rc > 0 then
//	//--- aggiorna solo se non ho trovato qta da fatturare				
//				else
					k_rec_update++
					kds_meca_da_chiudere.object.x_datins.Primary[k_riga] = kGuf_data_base.prendi_x_datins()
					kds_meca_da_chiudere.object.x_utente.Primary[k_riga] = kGuf_data_base.prendi_x_utente()
					kds_meca_da_chiudere.object.aperto.Primary[k_riga] = kki_meca_aperto_no
				
	//--- Ogni tot fa update e commit			
					k_ctr_commit ++
					if k_ctr_commit > 500 then
						k_ctr_commit = 0
						k_st_update = kds_meca_da_chiudere.update( )    // Aggiorna periodicamente
						if k_st_update < 0 then k_riga = k_righe + 1   //forza exit
						if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
							kst_esito = kguo_sqlca_db_magazzino.db_commit( )
						end if
					end if
//				end if
		
			end if
		end for
		
		if k_st_update >= 0 then
			k_st_update = kds_meca_da_chiudere.update( )
		end if
		
		if k_st_update < 0 then
			if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_db_ko )
			kguo_exception.setmessage("Errore durante tentativo di Chiusura Lotti già spediti")
			throw kguo_exception
		else
			if ast_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca.st_tab_g_0.esegui_commit) then
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kst_esito.sqlerrtext = "Conferma Chiusura Lotti Fallita (commit)!! " + kst_esito.sqlerrtext
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			if k_rec_update > 0 then
				k_return = k_rec_update
			end if
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return


end function

public function boolean set_lotto_annullato (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Annulla Lotto 
//=== 
//=== Input : st_tab_meca.ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then

		if if_sicurezza(kkg_flag_modalita.modifica) then
	
			k_return = set_lotto_annullato_no_sr(ast_tab_meca)

		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

public function long get_id_da_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna ID dal E1 Work Order 
//--- 
//---  input: kst_tab_meca.e1doco  
//---  Out: kst_tab_meca.id
//---                                     
//------------------------------------------------------------------
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT id
			 INTO 
					:kst_tab_meca.id
			 FROM meca
			WHERE meca.e1doco = :kst_tab_meca.e1doco
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Anomalia in ricerca del ID dal E1-WO " + string(kst_tab_meca.e1doco) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function long get_id_da_e1rorn (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna ID dal E1 Sales Order 
//--- 
//---  input: kst_tab_meca.e1rorn  
//---  Out: kst_tab_meca.id
//---                                     
//------------------------------------------------------------------
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT id
			 INTO 
					:kst_tab_meca.id
			 FROM meca
			WHERE meca.e1rorn = :kst_tab_meca.e1rorn
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Anomalia in ricerca del ID dal E1-SO " + string(kst_tab_meca.e1rorn) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public subroutine get_e1_dati (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna diversi dati E1 ... tipo Work e Sales Order, Stato ...
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Out: kst_tab_meca.e1rorn  
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1rorn
	      ,e1doco
			,e1srst
			 INTO 
					:kst_tab_meca.e1rorn
					,:kst_tab_meca.e1doco
					,:kst_tab_meca.e1srst
			 FROM meca
			WHERE meca.id = :kst_tab_meca.id 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca dati E1 nel Lotto per id " + string(kst_tab_meca.id) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.e1rorn > 0 then
		k_return = kst_tab_meca.e1rorn
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try


end subroutine

public function boolean if_lotto_associato (st_tab_meca ast_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Controllo se etichette Lotto associate con quelle del cliente
//--- 
//--- Inp: st_tab_meca.id 
//--- Ritorna: TRUE=lotto associato ;
//---          FALSE=non associato
//---   
//------------------------------------------------------------------
boolean k_return = false
string k_e1srst
kuf_e1_asn kuf1_e1_asn


try

	k_e1srst = trim(get_e1srst(ast_tab_meca))
	if k_e1srst = kuf1_e1_asn.kki_status_ready_toschedule &
			or k_e1srst = kuf1_e1_asn.kki_status_working then
	 	k_return = true
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	

end try

	
return k_return 

end function

public function string get_e1srst (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Torna lo STATO di E1 
//=== 
//=== 
//===  input: kst_tab_meca.id_meca  
//===  Out: kst_tab_meca.e1srst  
//===             tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//===                                     
//====================================================================
//
string k_return
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT e1srst
			 INTO 
					:kst_tab_meca.e1srst
			 FROM meca
			WHERE meca.id = :kst_tab_meca.id 
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Stato E1 nel id Lotto " + string(kst_tab_meca.id) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(kst_tab_meca.e1srst) > " " then
		k_return = trim(kst_tab_meca.e1srst)
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function boolean set_lotto_chiudi_ok (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Chiude il Lotto 
//=== 
//=== Input : st_tab_meca.ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	
	kst_tab_meca.id = ast_tab_meca.id
	kst_tab_meca.aperto = kki_meca_aperto_no
	k_return = set_aperto(kst_tab_meca)


catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

public function boolean set_lotto_annullato_no_sr (ref st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Annulla Lotto NO controllo SR 
//=== 
//=== Input : st_tab_meca.ID
//=== boolean  TRUE=aggiornato; FALSE=nessun aggiornamento
//=== Exception se erore con st_esito valorizzato
//===					
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_meca kst_tab_meca


try
	
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then

		kst_tab_meca.id = ast_tab_meca.id
		kst_tab_meca.aperto = kki_meca_aperto_annullato
		k_return = set_aperto(kst_tab_meca)

	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


return k_return

end function

public subroutine set_meca_blk_descrizione (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Aggiunge/Aggiorna rek nella tabella DATI CAUSALI LOTTO
//--- 
//--- Input: st_tab_meca     id=0  fa la INSERT
//---                    id>0  fa la UPDATE
//---
//--- Ritorna: 
//--- 
//---------------------------------------------------------------------------------------------------
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

//	//--- controlla se utente autorizzato alla funzione in atto
//	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//	k_rc = if_sicurezza(kst_open_w.flag_modalita)
//	
//	if not k_rc then
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.SQLErrText = "Modifica dati Lotto non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//		kguo_exception.inizializza()
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

//--- se rec non esiste allora faccio INSERT
	if NOT if_esiste_blk(kst_tab_meca) then
		
		kst_tab_meca.id_meca_causale = 0

		INSERT INTO meca_blk  
					( id_meca,   
					  id_meca_causale,   
					  descrizione,   
					  x_datins,   
					  x_utente )  
			  VALUES 
						( :kst_tab_meca.id,   
						  :kst_tab_meca.id_meca_causale,   
						  :kst_tab_meca.meca_blk_descrizione,   
						  :kst_tab_meca.x_datins,   
						  :kst_tab_meca.x_utente )  
						using kguo_sqlca_db_magazzino;

	else

		UPDATE meca_blk  
					  SET 
					  descrizione = :kst_tab_meca.meca_blk_descrizione ,   
					  x_datins = :kst_tab_meca.x_datins ,   
					  x_utente = :kst_tab_meca.x_utente
					WHERE id_meca =  :kst_tab_meca.id  
					using kguo_sqlca_db_magazzino;
					
//					  x_datins = :kst_tab_meca.x_datins_blk ,   
//					  x_utente = :kst_tab_meca.x_utente_blk,
	end if	
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Descrizione su Tab. dati Lotto 'meca_blk' id " + string(kst_tab_meca.id) + " :" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kst_esito = kguo_sqlca_db_magazzino.db_commit( )
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	
end try	


end subroutine

public function string get_meca_blk_descrizione (st_tab_meca kst_tab_meca) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Torna descrizione Blocco
//--- 
//--- Input : st_tab_meca.id 
//--- out: 
//--- Ritorna: descrizione blocco 
//--- Exception se erore con st_esito valorizzato
//---					
//--------------------------------------------------------------------------------------------------------
string k_return=""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select descrizione
		into :kst_tab_meca.meca_blk_descrizione
		from meca_blk 
		where meca_blk.id_meca = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura descrizione causale dalla tabella Lotti (meca_blk), id Lotto: " + string(kst_tab_meca.id) + "~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw  kguo_exception
	end if
	if trim(kst_tab_meca.meca_blk_descrizione) > " " then
		k_return = trim(kst_tab_meca.meca_blk_descrizione)
	end if
	
return k_return	

end function

public subroutine get_id_meca_min_max_x_data_ent (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception;//
//====================================================================
//=== Torna il ID MECA Min e Max x un periodo di data_ent
//=== 
//=== 
//===  input: st_tab_meca_da.data_ent e st_tab_meca_a.data_ent 
//===  Outout: st_tab_meca_da.id e st_tab_meca_a.id
//===                                     
//====================================================================
//
st_esito kst_esito


try 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kst_tab_meca_da.id = 0
	kst_tab_meca_a.id = 0
	SELECT min(id), max(id)
			 INTO 
					:kst_tab_meca_da.id
					,:kst_tab_meca_a.id 
			 FROM meca  
			WHERE data_ent between :kst_tab_meca_da.data_ent and :kst_tab_meca_a.data_ent
				 using kguo_sqlca_db_magazzino ;
				 
	if sqlca.sqlcode = 0 then
		if kst_tab_meca_da.id > 0 then
		else
			kst_tab_meca_da.id = 0
		end if
		if kst_tab_meca_a.id > 0 then
		else
			kst_tab_meca_a.id = 0
		end if
	else
		if sqlca.sqlcode > 0 then
			kst_tab_meca_da.id = 0
			kst_tab_meca_a.id = 0
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca lotti, id minimo e massimo dal " + string(kst_tab_meca_da.data_ent) + " al " + string(kst_tab_meca_a.data_ent) &
										  + "~n~r"  &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

end subroutine

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_meca kst_tab_meca);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita) // kkg_id_programma_riferimenti

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
		if kdw_anteprima.dataobject = "d_meca_1"  then
			if kdw_anteprima.rowcount() > 0  then
				if kdw_anteprima.object.id_meca[1] = kst_tab_meca.id  then
					kst_tab_meca.id = 0 
				end if
			else
				kst_tab_meca.id = 0 
			end if
		end if
	end if

	if kst_tab_meca.id > 0 then
	
			kdw_anteprima.dataobject = "d_meca_1_anteprima"
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_meca.id)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Riferimento da visualizzare: ~n~r" + "nessun codice ID indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function boolean if_magazzino_da_trattare (st_tab_armo kst_tab_armo);//
//------------------------------------------------------------------
//--- Controllo se codice Magazzino è di Trattamento
//--- 
//--- Inp: kst_tab_armo.magazzino
//--- Ritorna boolean : TRUE=da TRATTARE, FALSE=no;
//---   
//------------------------------------------------------------------

//st_esito kst_esito
boolean k_return = false

//
//	kst_esito.esito = kkg_esito.ok
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = ""
//	kst_esito.nome_oggetto = this.classname()


	if kst_tab_armo.magazzino = kki_magazzino_datrattare or kst_tab_armo.magazzino = kki_magazzino_rd then
		k_return = true
	end if


return k_return


end function

public function long get_id_da_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Torna ID dal id_wm_pklist  
//--- 
//---  input: kst_tab_meca.id_wm_pklist  
//---  Out: kst_tab_meca.id
//---                                     
//------------------------------------------------------------------
//
long k_return = 0
int k_anno
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT id
			 INTO 
					:kst_tab_meca.id
			 FROM meca
			WHERE meca.id_wm_pklist = :kst_tab_meca.id_wm_pklist
				 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Anomalia in ricerca del ID dal codice del Packing-List Mandante: " + string(kst_tab_meca.id_wm_pklist) + " " &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca.id > 0 then
		k_return = kst_tab_meca.id
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return

end function

public function long get_id_meca_da_e1doco (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Legge MECA 
//--- 
//--- 
//---  inp: kst_tab_meca.e1doco 
//---  Out: kst_tab_meca.ID_MECA
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca.id = 0

	if kst_tab_meca.e1doco > 0 then

		SELECT distinct meca.id
				 INTO 
						:kst_tab_meca.id
				 FROM meca
				WHERE meca.e1doco = :kst_tab_meca.e1doco
					 using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_tab_meca.id = 0
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca ID Lotto da WO di E1 '" + string(kst_tab_meca.e1doco) + "' " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		if kst_tab_meca.id > 0 then
			k_return = kst_tab_meca.id 
		end if
	
	else
		kst_tab_meca.id = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Tab. Lotto: WO di E1 non indicato, operazione interrotta! "
	end if
	
return k_return 

end function

public function long get_id_meca_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID MECA inserito 
//--- 
//---  input: 
//---  ret: max ID_MECA
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id)
		 INTO 
				:k_return
		 FROM meca  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Lotto in tabella (MECA)" &
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

public function long get_id_armo_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID ARMO inserito 
//--- 
//---  input: 
//---  ret: max ID_ARMO
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_armo)
		 INTO 
				:k_return
		 FROM armo  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID riga Lotto in tabella (ARMO)" &
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

public function boolean if_convalidato (st_tab_meca ast_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se Dosimetria Validata  x ID_MECA 
//=== 
//=== Inp: st_tab_meca. id
//=== Out: 
//=== Ritorna BOOLEAN : TRUE=dosimetria Convalidata, FALSE=NON Convalidata;
//===   
//====================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_meca kst1_tab_meca
kuf_meca_dosim kuf1_meca_dosim

try
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	if ast_tab_meca.id > 0 then
		
		select err_lav_ok, cert_forza_stampa, data_int
			into :kst1_tab_meca.err_lav_ok
				,:kst1_tab_meca.cert_forza_stampa
				,:kst1_tab_meca.data_int
			from meca
			where meca.id = :ast_tab_meca.id
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
	//--- se molto vecchio può essere che non ci fosse convalida
	//		if isnull(kst1_tab_meca.err_lav_ok) and year(kst1_tab_meca.data_int) < 2004 then
	//			kst1_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok
	//		end if
			
	//--- Convalida OK? oppure era in KO ma Sbloccato?
			kuf1_meca_dosim = create kuf_meca_dosim
			k_return = kuf1_meca_dosim.if_dosimetria_convalidata_ok(kst1_tab_meca.err_lav_ok) // if_dosimetria_gia_autorizzata(kst_tab_meca.err_lav_ok)

			if not k_return then
				if kst1_tab_meca.cert_forza_stampa = ki_cert_forza_stampa_SI then
					k_return = true
				end if
			end if

	//		if kst1_tab_meca.err_lav_ok = ki_err_lav_ok_conv_aut_ok &
	//		 		or kst1_tab_meca.err_lav_ok = ki_err_lav_ok_conv_ko_sbloc &
	//				or kst1_tab_meca.cert_forza_stampa = ki_cert_forza_stampa_SI then
	//			k_return = true
	//		end if
			
		else
			if sqlca.sqlcode = 100 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica della Convalida se OK (meca) ~n~rLotto id= " + string(ast_tab_meca.id) + " non Trovato. ~n~r" + sqlca.sqlerrtext
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica della Convalida se OK (meca) per il Lotto id= " + string(ast_tab_meca.id) + " ~n~r " + sqlca.sqlerrtext
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if


catch (uo_exception kuo_exception)	
	throw kuo_exception

finally
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	
end try
	
return k_return


end function

public function integer meca_non_conforme_blocca_sblocca (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Blocca/Sblocca Lotto di Entrata Incompleto
//--- 
//--- inp: st_meca   riempire il ID del Riferimento
//--- out: stato: stato del lotto
//--- se NOT OK lancia exception con Esito (st_esito) come da Standard
//---
//---
int k_return
boolean k_autorizza
st_esito kst_esito


	try 
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		k_autorizza = consenti_sblocco_meca_non_conforme(kst_tab_meca)   // utente autorizzato?
		if not k_autorizza then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Autorizzazione allo Sblocco del Lotto: ~n~r" + "La funzione richiesta non e' stata abilitata"
			kst_esito.esito = kkg_esito.no_aut
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)					
			throw kguo_exception
		end if
	
	//--- leggo archivi per stato del Lotto
		SELECT 
				meca.stato
			into :kst_tab_meca.stato 
				 FROM meca
				 where meca.id = :kst_tab_meca.id  
					 using kguo_sqlca_db_magazzino;
					 
			
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
			SELECT 
				x_datins_sblk
				,x_utente_sblk
			into :kst_tab_meca.x_datins_sblk
					,:kst_tab_meca.x_utente_sblk
				 FROM meca_blk
					where id_meca = :kst_tab_meca.id
					 using kguo_sqlca_db_magazzino;
	
			if kguo_sqlca_db_magazzino.sqlcode = 0 &
				and  (kst_tab_meca.stato = ki_meca_stato_blk &
						or kst_tab_meca.stato = ki_meca_stato_sblk &
						or  kst_tab_meca.stato =  ki_meca_stato_blk_con_controllo &
						or  kst_tab_meca.stato = ki_meca_stato_ok) then
				
				
				k_return = meca_non_conforme_blocca_sblocca_upd(kst_tab_meca)

					
			else

				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					kst_esito.SQLErrText = "Stato del Riferimento (id="+string(kst_tab_meca.id) +") non aggiornato." &
											  + "~n~rStato non riconosciuto (" + string(kst_tab_meca.stato) +")"
					kst_esito.esito = kkg_esito.no_esecuzione
				else
					kst_esito.SQLErrText = "Errore in lettura Blocco del Riferimento (id="+string(kst_tab_meca.id) +")." &
										 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)					
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				throw kguo_exception
			end if
			
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Lettura del Riferimento (id="+string(kst_tab_meca.id) +") Fallito. ~n~r" + "Errore: " + string(kguo_sqlca_db_magazzino.sqlcode) &
											  + trim(kguo_sqlca_db_magazzino.sqlerrtext)
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)					
				throw kguo_exception
			end if	
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	end try

return k_return

end function

private function integer meca_non_conforme_blocca_sblocca_upd (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Funzione: Blocca/Sblocca Lotto di Entrata Incompleto 
//--- 
//--- inp: st_meca   riempire il ID del Riferimento
//--- out: stato: stato del lotto
//--- se NOT OK lancia exception con Esito (st_esito) come da Standard
//---
//---
int k_return
st_esito kst_esito


	try 
	
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()

		choose case kst_tab_meca.stato
			case ki_meca_stato_blk
				kst_tab_meca.stato = ki_meca_stato_sblk 
				kst_tab_meca.x_datins_sblk = kGuf_data_base.prendi_x_datins()
				kst_tab_meca.x_utente_sblk = kGuf_data_base.prendi_x_utente()
//--- se 'SBLOCCATO' (e quindo non ancora 'confermato') metto in stato di bloccato il lotto (bloccato e senza controllo sui dati del Riferimento))					
			case ki_meca_stato_sblk
				kst_tab_meca.stato = ki_meca_stato_blk 
			case ki_meca_stato_blk_con_controllo
				kst_tab_meca.stato = ki_meca_stato_ok
//--- se OK metto in stato di bloccato il lotto (bloccato ma con gli opportuni controlli se si modificano i dati nel riferimento)					
			case ki_meca_stato_ok
				kst_tab_meca.stato = ki_meca_stato_blk_con_controllo 

		end choose


		kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

		update meca
			set stato = :kst_tab_meca.stato
			 	,x_datins = :kst_tab_meca.x_datins
			 	,x_utente = :kst_tab_meca.x_utente
			where id = :kst_tab_meca.id
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiornamento Sblocco/Blocco Riferimento (Lotto id= " &
								 + string(kst_tab_meca.id) + " " &
								 + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)					
			throw kguo_exception
		end if	
		
		update meca_blk
			set 
				 x_datins_sblk = :kst_tab_meca.x_datins_sblk
				 ,x_utente_sblk = :kst_tab_meca.x_utente_sblk
				 ,x_datins = :kst_tab_meca.x_datins
				 ,x_utente = :kst_tab_meca.x_utente
			where id_meca = :kst_tab_meca.id
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiornamento Sblocco/Blocco Riferimento (tab. blocchi Lotto id= " &
								 + string(kst_tab_meca.id) + " " &
								 + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)					
			throw kguo_exception
		end if	

		update armo
			set stato = :kst_tab_meca.stato
			where id_meca = :kst_tab_meca.id
			using kguo_sqlca_db_magazzino;

		kguo_sqlca_db_magazzino.db_commit()
		
		k_return = kst_tab_meca.stato
			
	catch (uo_exception kuo_exception)
		kguo_sqlca_db_magazzino.db_rollback()
		throw kuo_exception
		
		
	end try

return k_return

end function

public function string get_stato_descrizione_std (st_tab_meca ast_tab_meca) throws uo_exception;//
//---------------------------------------------------------------------------------------------
//--- Torna la descrizione STANDARD dello STATO del Lotto 
//--- 
//--- 
//---  input: st_tab_meca.STATO  es. 3
//---  Output: 
//---  rit.: descrizione standard
//---  Lancia Exception
//---------------------------------------------------------------------------------------------
//
string k_return = ""
datastore kds_1
int  k_riga


	kds_1 = create datastore
	
	kds_1.dataobject = "dd_meca_armo_stato"
	k_riga = kds_1.find( "stato = '" + string(ast_tab_meca.stato) + "'", 0, kds_1.rowcount())
	if k_riga > 0 then
		k_return = trim(kds_1.getitemstring(k_riga, "descr"))
	end if


return k_return 

end function

public function string u_get_consegna_tempi (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//--------------------------------------------------------------------
//--- Calcola data e ora di Consegna 
//--- 
//--- Inp:  kst_tab_meca.data_ent, clie_3
//--- Out: kst_tab_meca.consegna_data, consegna_ora
//--- Rit: diverso da space = messaggio di errore non grave 
//---                                     
//---  lancia EXCEPTION
//---                                     
//--------------------------------------------------------------------
//
string k_return
int k_dd_after
st_esito kst_esito
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if date(kst_tab_meca.data_ent) > date(0) then 
		
		kuf1_clienti = create kuf_clienti
		kuf1_utility = create kuf_utility
		
		kst_tab_clienti.codice = kst_tab_meca.clie_3
		kuf1_clienti.get_delivery(kst_tab_clienti)
	
		if kst_tab_meca.consegna_data > date(0) then
		else
			if kst_tab_clienti.delivery_dd_after > 0 then
				
//--- Nuova data con aggiunta dei solo gg feriali				
				kst_tab_meca.consegna_data = kuf1_utility.u_datetime_after_ddnowe(date(kst_tab_meca.data_ent), kst_tab_clienti.delivery_dd_after)
				
//--- Nuova data con giorni previsti se cade nel we sposta a lunedì
//				kst_tab_meca.consegna_data = relativedate(date(kst_tab_meca.data_ent), kst_tab_clienti.delivery_dd_after)
//				//--- se cade nel week-end avanza di tot giorni
//				if dayNumber ( kst_tab_meca.consegna_data ) = 1 then
//					k_dd_after = 1
//				else
//					if dayNumber ( kst_tab_meca.consegna_data ) = 7 then
//						k_dd_after = 2
//					end if
//				end if
//				if k_dd_after > 0 then
//					kst_tab_meca.consegna_data = relativedate(date(kst_tab_meca.consegna_data), k_dd_after)
//				end if
					
				
			else
				k_return = 	"Manca sul cliente " + string(kst_tab_clienti.codice) + " il numero dei giorni di Consegna, operazione interrotta"
				//messagebox("Data di Consegna Non Rilevata", k_return, stopsign!)
				
			end if
		end if
		
		if kst_tab_clienti.delivery_hour > time("00:00") then
			if kst_tab_meca.consegna_ora > time("00:00") then
			else
				kst_tab_meca.consegna_ora = kst_tab_clienti.delivery_hour
			end if
		end if
		
	else
		
		k_return = 	"Data di entrata di questo Lotto non indicata, operazione interrotta"
		//messagebox("Data di Consegna Non Rilevata", k_return, stopsign!)
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
	
end try

return k_return

end function

public subroutine set_consegna_ora (st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Aggiorna il numero colli FATTURATI
//--- 
//--- Input: st_tab_meca     id
//---                        consegna_ora
//---
//--- Lancia Exception x errore
//--- 
//------------------------------------------------------------------------------------------------
long k_rcn
boolean k_rc
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_meca.id > 0 then
	
//	if isnull(kst_tab_meca.consegna_ora) then
//		 kst_tab_meca.consegna_ora = time("00:00")
//	end if
	
	UPDATE meca  
			SET 	consegna_ora = :kst_tab_meca.consegna_ora
			WHERE meca.id = :kst_tab_meca.id   
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Ora prevista di Ritiro (Consegna) Lotto (meca), ID:" + string(kst_tab_meca.id) + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
			
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit()
		end if
	end if

else
	kst_esito.SQLErrText = "Manca ID Lotto per eseguire l'aggiornamento dell'ora di Consegna"
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if



end subroutine

public function integer set_dosimprev (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Imposta Il numero Dosimetri previsto per il Lotto
//=== 
//=== Input : kst_tab_meca.id e dosimprev
//=== boolean  numero aggiornato
//=== Exception se errore con st_esito valorizzato
//===					
//===   
//====================================================================
int k_return
st_tab_meca kst_tab_meca_appo
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in aggiornamento del Numero Dosimetri Previsti per il Lotto. Manca ID Lotto"
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_meca.dosimprev) then
		kst_tab_meca.dosimprev = 0
	end if

//--- aggiorna la testa del lotto
	update meca
				set dosimprev = :kst_tab_meca.dosimprev
					,x_datins = :kst_tab_meca.x_datins
					,x_utente = :kst_tab_meca.x_utente
				where ID = :kst_tab_meca.ID
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Numero Dosimetri Previsti (" +  string(kst_tab_meca.dosimprev) + ") in testata Lotto, ID: " + string(kst_tab_meca.ID) + "~n~r" + trim(sqlca.SQLErrText)
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if
		
//--- se arriva qui tutto OK	
	k_return = kst_tab_meca.dosimprev
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
catch (uo_exception kuo_exception)
	if kst_tab_meca.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
end try


return k_return

end function

public function boolean if_lotto_chiuso (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Controllo se Riferimento e' CHIUSO/ANNULLATO
//=== 
//=== Ritorna boolean : TRUE=chiuso, FALSE=aperto;
//===                  : come standard
//===   
//====================================================================

st_esito kst_esito
boolean k_return = false
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//--- 
	select aperto
		into :kst_tab_meca.aperto
		from meca 
		where meca.id = :kst_tab_meca.id
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

		if kst_tab_meca.aperto = kki_meca_aperto_NO or kst_tab_meca.aperto = kki_meca_aperto_annullato then
			k_return = true
		end if
		
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore grave durante controllo Lotto Aperto, id=" + string(kst_tab_meca.id) + "~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if
	end if
	
	
return k_return


end function

public function long get_id_meca_da_id_wm_pklist (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------
//--- Legge MECA 
//--- 
//--- 
//---  inp: kst_tab_meca.id_wm_pklist 
//---  Out: kst_tab_meca.ID_MECA (l'ultimo)
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca.id = 0

	if kst_tab_meca.id_wm_pklist > 0 then

		SELECT max(meca.id)
				 INTO 
						:kst_tab_meca.id
				 FROM meca
				WHERE meca.id_wm_pklist = :kst_tab_meca.id_wm_pklist
					 using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_tab_meca.id = 0
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca ID Lotto da Id del Packing List, id = '" + string(kst_tab_meca.id_wm_pklist) + "' " &
										 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		if kst_tab_meca.id > 0 then
			k_return = kst_tab_meca.id 
		end if
	
	else
		kst_tab_meca.id = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Tab. Lotto: ID Packing List non indicato, operazione interrotta! "
	end if
	
return k_return 

end function

on kuf_armo.create
call super::create
this.message_1=create message_1
end on

on kuf_armo.destroy
call super::destroy
destroy(this.message_1)
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "Lotto"
end event

type message_1 from message within kuf_armo descriptor "pb_nvo" = "true" 
end type

on message_1.create
call super::create
TriggerEvent( this, "constructor" )
end on

on message_1.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

