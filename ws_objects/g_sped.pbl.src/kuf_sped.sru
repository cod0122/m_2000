$PBExportHeader$kuf_sped.sru
forward
global type kuf_sped from kuf_parent
end type
end forward

global type kuf_sped from kuf_parent
end type
global kuf_sped kuf_sped

type variables
public st_tab_arsp kist_tab_arsp
public constant string kki_sped_flg_stampa_bolla_da_stamp="N"
public constant string kki_sped_flg_stampa_bolla_stampata="S"
public constant string kki_sped_flg_stampa_fatturato="F"


//--- utile nella funzione get_sped_camion_caricato
public constant int kki_sped_camion_caricato_NO=0
public constant int kki_sped_camion_caricato_SI=1
public constant int kki_sped_camion_caricato_NON_GESTITO=-1

 
//--- Causale di Spedizione 
public constant string kki_ddt_st_num_data_in_NO = "N"   //non stampare num e data bolla di entrata

//--- costanti nomi DW 
public constant string kki_dw_elenco_indirizzi = "d_sped_l_indirizzi" 
public constant string kki_dw_elenco_note = "d_sped_note_l" 
public constant string kki_dw_meca_da_sped = "d_merce_da_sped"  

public constant long kki_num_bolla_out_extra = 9000000   //numero oltre il quale fare ddt 'BIS' o particolari

private datastore kdsi_dw_elenco_indirizzi
end variables

forward prototypes
public subroutine if_isnull_testa (ref st_tab_sped kst_tab_sped)
public function st_esito tb_delete_testa (st_tab_sped kst_tab_sped)
public function st_esito tb_delete_x_rif ()
public function st_esito select_testa (ref st_tab_sped kst_tab_sped)
public function st_esito select_riga (ref st_tab_arsp kst_tab_arsp)
public subroutine if_isnull_riga (ref st_tab_arsp kst_tab_arsp)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_righe_sped (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_clie_3 (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_pagam (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito get_clie (ref st_tab_sped kst_tab_sped)
public function st_esito get_righe (ref st_tab_arsp kst_tab_arsp[])
public function st_esito set_riga_fatturata (st_tab_arsp kst_tab_arsp)
public function st_esito get_numero_da_id (ref st_tab_arsp kst_tab_arsp)
public function st_esito get_colli_da_fatt (ref st_tab_arsp kst_tab_arsp)
public function st_esito set_sped_fatturata (st_tab_sped kst_tab_sped)
public function st_esito reset_riga_fatturata (st_tab_arsp kst_tab_arsp)
public function st_esito get_colli_fatt (ref st_tab_arsp kst_tab_arsp)
public function st_esito reset_sped_fatturata (st_tab_sped kst_tab_sped)
public function st_esito set_arsp_fatturata_reset (st_tab_arsp kst_tab_arsp)
public function st_esito get_ultimo_doc (ref st_tab_sped kst_tab_sped)
public function st_esito anteprima_righe (datastore kdw_anteprima, st_tab_sped kst_tab_sped)
public function integer u_tree_open (string k_modalita, st_tab_sped kst_tab_sped[], ref datawindow kdw_anteprima)
public function boolean u_open (st_tab_sped kst_tab_sped[], st_open_w kst_open_w)
public function boolean u_open_cancellazione (ref st_tab_sped kst_tab_sped)
public function boolean u_open_inserimento (ref st_tab_sped kst_tab_sped)
public function boolean u_open_modifica (ref st_tab_sped kst_tab_sped)
public function boolean u_open_visualizza (ref st_tab_sped kst_tab_sped)
public function st_esito get_id_riga_da_id_armo (ref st_tab_arsp kst_tab_arsp)
public function st_esito set_sped_stampata (st_tab_sped kst_tab_sped)
public function st_esito set_righe_stampata (st_tab_arsp kst_tab_arsp)
public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception
public function st_esito anteprima_1 (datastore kdw_anteprima, st_tab_sped kst_tab_sped)
public function st_esito anteprima_1 (datawindow kdw_anteprima, st_tab_sped kst_tab_sped)
public function st_esito anteprima (datastore kds_anteprima, st_tab_sped kst_tab_sped)
public function st_esito anteprima (datawindow kdw_anteprima, st_tab_sped kst_tab_sped)
public function st_esito anteprima_2 (datastore kdw_anteprima, st_tab_sped kst_tab_sped)
public function boolean u_open_stampa (st_tab_sped kst_tab_sped[])
public function st_esito get_sped_stampa (ref st_tab_sped kst_tab_sped)
public function integer get_sped_camion_caricato (ref st_tab_sped kst_tab_sped) throws uo_exception
public function boolean set_id_docprod (st_tab_sped kst_tab_sped) throws uo_exception
public function long aggiorna_docprod (ref st_tab_sped kst_tab_sped[]) throws uo_exception
public function boolean if_esiste (st_tab_sped kst_tab_sped) throws uo_exception
public function boolean get_id_armo_max (ref st_tab_arsp kst_tab_arsp) throws uo_exception
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function long get_colli_x_id_armo (st_tab_arsp kst_tab_arsp) throws uo_exception
public function long get_colli_x_id_armo_data (st_tab_arsp kst_tab_arsp) throws uo_exception
public function st_esito get_righe_da_fatt (ref st_tab_arsp kst_tab_arsp[])
public function st_esito get_numero_da_id (ref st_tab_sped ast_tab_sped)
public function boolean get_id_sped_anno (ref st_tab_sped kst_tab_sped) throws uo_exception
public subroutine elenco_note (st_tab_sped kst_tab_sped)
public subroutine elenco_indirizzi_ddt (st_tab_sped kst_tab_sped)
public function boolean if_cancella (st_tab_sped ast_tab_sped) throws uo_exception
public function long get_colli_sped (ref st_tab_arsp kst_tab_arsp) throws uo_exception
public function boolean if_modifica (st_tab_sped ast_tab_sped) throws uo_exception
public function boolean tb_update_numero_data (st_tab_sped kst_tab_sped) throws uo_exception
public function long tb_insert_testa (ref st_tab_sped kst_tab_sped) throws uo_exception
public function integer get_nr_righe (st_tab_arsp kst_tab_arsp) throws uo_exception
public function long get_id_armo (st_tab_arsp kst_tab_arsp) throws uo_exception
public function string get_stampa (st_tab_arsp kst_tab_arsp) throws uo_exception
public function long get_colli (st_tab_arsp kst_tab_arsp) throws uo_exception
public function long get_id_sped (st_tab_arsp kst_tab_arsp) throws uo_exception
public function boolean tb_delete_riga (st_tab_arsp kst_tab_arsp) throws uo_exception
public function long tb_insert_riga (ref st_tab_arsp kst_tab_arsp) throws uo_exception
public subroutine tb_update_riga (ref st_tab_arsp kst_tab_arsp) throws uo_exception
public subroutine tb_update_testa (ref st_tab_sped kst_tab_sped) throws uo_exception
public subroutine get_note (ref st_tab_arsp kst_tab_arsp) throws uo_exception
public function boolean if_ddt_lavparziale () throws uo_exception
public function integer get_nr_indirizzi_ddt (st_tab_sped kst_tab_sped)
public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception
public function long get_colli_sped_lotto (long aid_meca) throws uo_exception
public function boolean if_sv_call_vettore (st_tab_sped ast_tab_sped) throws uo_exception
public function string run_chiudi_bolle_batch () throws uo_exception
public function long get_id_sped_max () throws uo_exception
public function long get_id_arsp_max () throws uo_exception
public function long get_id_sped (ref st_tab_sped kst_tab_sped) throws uo_exception
public function boolean set_num_bolla_out_all (st_tab_sped kst_tab_sped) throws uo_exception
public function long get_num_bolla_out_ultimo (ref st_tab_sped kst_tab_sped) throws uo_exception
public function long get_numero_nuovo (st_tab_sped ast_tab_sped, integer a_ctr) throws uo_exception
public function long if_num_bolla_out_exists (st_tab_sped kst_tab_sped) throws uo_exception
private function long u_get_clie_ds_dw_elenco_indirizzi ()
public function boolean if_ddt_allarme_memo (st_tab_sped kst_tab_sped) throws uo_exception
public function boolean if_stampato (st_tab_sped ast_tab_sped) throws uo_exception
end prototypes

public subroutine if_isnull_testa (ref st_tab_sped kst_tab_sped);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_sped.cura_trasp) then kst_tab_sped.cura_trasp = " "
if isnull(kst_tab_sped.causale) then kst_tab_sped.causale = " "
if isnull(kst_tab_sped.aspetto) then kst_tab_sped.aspetto = " "
if isnull(kst_tab_sped.mezzo) then kst_tab_sped.mezzo = " "
if isnull(kst_tab_sped.porto) then kst_tab_sped.porto = " "
if isnull(kst_tab_sped.note_1) then	kst_tab_sped.note_1 = " "
if isnull(kst_tab_sped.note_2) then	kst_tab_sped.note_2 = " "
if isnull(kst_tab_sped.vett_1) then	kst_tab_sped.vett_1 = " "
if isnull(kst_tab_sped.vett_2) then	kst_tab_sped.vett_2 = " "
if isnull(kst_tab_sped.stampa) then kst_tab_sped.stampa = ""
if isnull(kst_tab_sped.colli) then kst_tab_sped.colli = 0
if isnull(kst_tab_sped.clie_2) then	kst_tab_sped.clie_2 = 0
if isnull(kst_tab_sped.clie_3) then	kst_tab_sped.clie_3 = 0
if isnull(kst_tab_sped.data_rit) then kst_tab_sped.data_rit = date(0)
if isnull(kst_tab_sped.ora_rit) then kst_tab_sped.ora_rit = " "
if isnull(kst_tab_sped.data_uscita) then kst_tab_sped.data_uscita = date(0)
if isnull(kst_tab_sped.sv_call_vettore) then	kst_tab_sped.sv_call_vettore = 0


if isnull(kst_tab_sped.rag_soc_1) then kst_tab_sped.rag_soc_1 = ""
if isnull(kst_tab_sped.rag_soc_2) then kst_tab_sped.rag_soc_2 = ""
if isnull(kst_tab_sped.indi) then kst_tab_sped.indi = ""
if isnull(kst_tab_sped.loc) then kst_tab_sped.loc = ""

end subroutine

public function st_esito tb_delete_testa (st_tab_sped kst_tab_sped);//
//====================================================================
//=== Cancella il rek dalla tabella SPED-ARSP (Bolle di spedizione) 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_tab_arfa kst_tab_arfa
st_tab_sped kst_tab_sped_1, kst_tab_sped_2[]
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
//kuf_fatt kuf1_fatt
kuf_sped_ddt kuf1_sped_ddt


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if if_sicurezza(kkg_flag_modalita.cancellazione) then  // Controllo se utente autorizzato

//--- se manca piglia ID del ddt
 		if kst_tab_sped.id_sped > 0 then
		else
			get_id_sped(kst_tab_sped)
		end if

//=== Controllo se bolla già fatturata
		DECLARE c_fattura CURSOR FOR  
			  SELECT num_fatt, data_fatt
				 FROM arfa 
				WHERE num_bolla_out = :kst_tab_sped.num_bolla_out
						and data_bolla_out = :kst_tab_sped.data_bolla_out
					using kguo_sqlca_db_magazzino;
		
		open c_fattura;
		if kguo_sqlca_db_magazzino.sqlCode = 0 then
		
			fetch c_fattura INTO :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
		
			if kguo_sqlca_db_magazzino.sqlCode = 0 then
	
				if kst_tab_arfa.num_fatt > 0 then
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
						  "DDT gia' in Fattura n. " &
							+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
							+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") + " ~n~r" &
							+ "ddt n. " &
							+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
							+ " ~n~r "
					kst_esito.esito = kkg_esito.no_esecuzione
				
				end if
			end if
			close c_fattura;
		end if
		
			
		if kst_esito.esito = kkg_esito.ok then
		
			try
				
				if kst_tab_sped.id_sped > 0 then
				else
					get_id_sped(kst_tab_sped)
				end if
				
				kuf1_sped_ddt = create kuf_sped_ddt
	
	//--- Ripristina i colli in Prezzi-riga-lotto da fatturare
				kst_tab_sped_2[1] = kst_tab_sped
				kst_tab_sped_2[1].st_tab_g_0.esegui_commit	= "N"
				kuf1_sped_ddt.set_armo_prezzi_righe_all(kst_tab_sped_2[], true)
	
	//--- Ripristina il flag di righe WMF 			
				kst_tab_sped_1 = kst_tab_sped
				kst_tab_sped_1.st_tab_g_0.esegui_commit	= "N"
				kuf1_sped_ddt.set_wm_pklist_righe_non_spedito(kst_tab_sped_1)
				
				if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
		
		//--- cancella prima tutte le righe
				delete from arsp
						WHERE id_sped = :kst_tab_sped.id_sped
						using kguo_sqlca_db_magazzino;
						//num_bolla_out = :kst_tab_sped.num_bolla_out
						//		and data_bolla_out = :kst_tab_sped.data_bolla_out;
			
				
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
			"Errore durante la cancellazione delle righe del DDT " &
							+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
							+ " id " + string(kst_tab_sped.id_sped) &
							+ "~n~rErrore-tab.ARSP:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
					
				else
	
	//--- se tutto ok cancella la testata
					delete from sped
							WHERE id_sped = :kst_tab_sped.id_sped
							using kguo_sqlca_db_magazzino;
					
					if kguo_sqlca_db_magazzino.sqlcode <> 0 then
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.SQLErrText = &
			"Errore durante la cancellazione testata del DDT  " &
							+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
							+ " id " + string(kst_tab_sped.id_sped) &
							+ " ~n~rErrore-tab.SPED:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
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
	
	//--- cancella da docprod	 tutti i riferimenti
						kst_tab_docprod.id_doc = kst_tab_sped.id_sped 
						kuf1_docprod = create kuf_docprod
						kuf1_doctipo = create kuf_doctipo
						kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
						kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_ddt )
	
					end if
				end if
			
			
			catch 	(uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
	
	
			finally
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
				
				if isvalid(kuf1_docprod) then destroy kuf1_docprod 
				if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
			
			end try
			
		end if
	end if
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	
end try


return kst_esito

end function

public function st_esito tb_delete_x_rif ();//
//====================================================================
//=== Cancella il rek dalla tabella ARSP-SPED (Spedizioni) con i dati del Riferimento
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===                : 3=INFORMAZIONE 
//=== 
//====================================================================
//
int k_ctr
boolean k_return
string k_errore
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
st_tab_arfa kst_tab_arfa
kuf_sicurezza kuf1_sicurezza
kuf_fatt kuf1_fatt


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
	kst_esito.SQLErrText = "Cancellazione Spedizione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else


//=== Controllo se contratti definiti nei Piani di Trattamento
	DECLARE c_fattura CURSOR FOR  
		  SELECT num_fatt, data_fatt
			 FROM arfa 
			WHERE id_armo = :kist_tab_arsp.id_armo
			using sqlca;
			
	open c_fattura;
	if sqlca.sqlCode = 0 then
	
		fetch c_fattura INTO :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;

		kuf1_fatt = create kuf_fatt

		do while sqlca.sqlCode = 0 and kst_esito.esito = kkg_esito.ok
			kst_esito = kuf1_fatt.tb_delete(kst_tab_arfa)
			fetch c_fattura INTO :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
		loop
			
		if kst_esito.sqlcode < 0 then 
			kst_esito.esito = kkg_esito.db_ko
		end if
		
		destroy kuf1_fatt
		close c_fattura;
	end if
	
		
	if kst_esito.esito = kkg_esito.ok then

		DECLARE c_arsp CURSOR FOR  
		   SELECT num_bolla_out, data_bolla_out
			   FROM arsp
			   WHERE id_armo = :kist_tab_arsp.id_armo
			   using sqlca;
				
		open c_arsp;
		
		fetch c_arsp into :kist_tab_arsp.num_bolla_out, :kist_tab_arsp.data_bolla_out;
	
		kst_esito1.SQLErrText = " "
		kst_esito1.esito = kkg_esito.ok
		do while sqlca.sqlcode = 0 

			delete from arsp
				WHERE id_armo = :kist_tab_arsp.id_armo
				using sqlca;
				
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle righe Bolla di Spedizione ~n~r" &
						+ string(kist_tab_arsp.num_bolla_out, "####0") + " del " &
						+ string(kist_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if

			fetch c_arsp into :kist_tab_arsp.num_bolla_out, :kist_tab_arsp.data_bolla_out;

		loop

		close c_arsp;

		if kst_esito.esito = kkg_esito.ok then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.SQLErrText = "Errore in Canc.Righe Spedizione (COMMIT kuf_armo.tb_delete): " + trim(kst_esito.SQLErrText)
			end if
			
		end if
		
//--- se la bolla e' rimasta senza righe allora cancello anche la testata		
		k_ctr = 0
		select count(*) into :k_ctr
		   from arsp
		   where arsp.num_bolla_out = :kist_tab_arsp.num_bolla_out
					and arsp.data_bolla_out = :kist_tab_arsp.data_bolla_out
					using sqlca;

					
		if sqlca.sqlcode >= 0 and (k_ctr = 0 or isnull(k_ctr)) then

			delete from sped
			   where num_bolla_out = :kist_tab_arsp.num_bolla_out
					and data_bolla_out = :kist_tab_arsp.data_bolla_out
					using sqlca;

			if sqlca.sqlcode < 0 then 
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle Testata Bolla di Spedizione ~n~r" &
						+ string(kist_tab_arsp.num_bolla_out, "####0") + " del " &
						+ string(kist_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if

		end if
				
	end if
end if


return kst_esito

end function

public function st_esito select_testa (ref st_tab_sped kst_tab_sped);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_sped.id_sped > 0 then

	  SELECT 
				sped.clie_2,   
				sped.clie_3,   
				trim(sped.cura_trasp),   
				sped.causale,   
				trim(sped.aspetto),   
				trim(sped.porto),   
				trim(sped.mezzo),   
				sped.note_1,   
				sped.note_2,   
				sped.data_rit,   
				trim(sped.ora_rit),   
				trim(sped.vett_1),   
				trim(sped.vett_2),   
				sped.stampa,   
				sped.colli,   
				sped.data_uscita  
		 INTO 
			  :kst_tab_sped.clie_2,   
				:kst_tab_sped.clie_3,   
				:kst_tab_sped.cura_trasp,   
				:kst_tab_sped.causale,   
				:kst_tab_sped.aspetto,   
				:kst_tab_sped.porto,   
				:kst_tab_sped.mezzo,   
				:kst_tab_sped.note_1,   
				:kst_tab_sped.note_2,   
				:kst_tab_sped.data_rit,   
				:kst_tab_sped.ora_rit,   
				:kst_tab_sped.vett_1,   
				:kst_tab_sped.vett_2,   
				:kst_tab_sped.stampa,   
				:kst_tab_sped.colli,   
				:kst_tab_sped.data_uscita  
		 FROM sped  
		WHERE id_sped = :kst_tab_sped.id_sped
				  ;
	else	

	  SELECT 
				sped.clie_2,   
				sped.clie_3,   
				trim(sped.cura_trasp),   
				sped.causale,   
				trim(sped.aspetto),   
				trim(sped.porto),   
				trim(sped.mezzo),   
				sped.note_1,   
				sped.note_2,   
				sped.data_rit,   
				trim(sped.ora_rit),   
				trim(sped.vett_1),   
				trim(sped.vett_2),   
				sped.stampa,   
				sped.colli,   
				sped.data_uscita  
		 INTO 
			  :kst_tab_sped.clie_2,   
				:kst_tab_sped.clie_3,   
				:kst_tab_sped.cura_trasp,   
				:kst_tab_sped.causale,   
				:kst_tab_sped.aspetto,   
				:kst_tab_sped.porto,   
				:kst_tab_sped.mezzo,   
				:kst_tab_sped.note_1,   
				:kst_tab_sped.note_2,   
				:kst_tab_sped.data_rit,   
				:kst_tab_sped.ora_rit,   
				:kst_tab_sped.vett_1,   
				:kst_tab_sped.vett_2,   
				:kst_tab_sped.stampa,   
				:kst_tab_sped.colli,   
				:kst_tab_sped.data_uscita  
		 FROM sped  
		WHERE ( num_bolla_out = :kst_tab_sped.num_bolla_out ) AND  
				( data_bolla_out = :kst_tab_sped.data_bolla_out)   
				  ;
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., bolla di sped. (numero=" + string( kst_tab_sped.num_bolla_out) + " del "+ string( kst_tab_sped.data_bolla_out)+") : " &
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
	
//return string(sqlca.sqlcode, "0000000000") + trim(sqlca.SQLErrText) + " "
return kst_esito


end function

public function st_esito select_riga (ref st_tab_arsp kst_tab_arsp);//
//--- Leggo Riga di Spedizione  della Bolla e id_armo indicata
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

  SELECT arsp.colli,   
         arsp.note_1,   
         arsp.note_2,   
         arsp.note_3,   
         arsp.stampa,   
         arsp.colli_out,   
         arsp.peso_kg_out  
    INTO :kst_tab_arsp.colli,   
         :kst_tab_arsp.note_1,   
         :kst_tab_arsp.note_2,   
         :kst_tab_arsp.note_3,   
         :kst_tab_arsp.stampa,   
         :kst_tab_arsp.colli_out,   
         :kst_tab_arsp.peso_kg_out  
    FROM arsp  
   WHERE ( num_bolla_out = :kst_tab_arsp.num_bolla_out ) AND  
         ( data_bolla_out = :kst_tab_arsp.data_bolla_out)  and 
         ( id_armo = :kst_tab_arsp.id_armo)   
           ;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., riga bolla di sped. (numero=" + string( kst_tab_arsp.num_bolla_out) + " del "+ string( kst_tab_arsp.data_bolla_out)+ " id riga " + string( kst_tab_arsp.id_armo) + ") : " &
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
	
//return string(sqlca.sqlcode, "0000000000") + trim(sqlca.SQLErrText) + " "
return kst_esito


end function

public subroutine if_isnull_riga (ref st_tab_arsp kst_tab_arsp);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_arsp.id_sped) then kst_tab_arsp.id_sped = 0
if isnull(kst_tab_arsp.id_armo) then kst_tab_arsp.id_armo = 0
if isnull(kst_tab_arsp.id_arsp) then kst_tab_arsp.id_arsp = 0
if isnull(kst_tab_arsp.nriga) then kst_tab_arsp.nriga = 0
if isnull(kst_tab_arsp.num_bolla_out) then kst_tab_arsp.num_bolla_out = 0
if isnull(kst_tab_arsp.data_bolla_out) then kst_tab_arsp.data_bolla_out = date(0)
if isnull(kst_tab_arsp.nriga) then kst_tab_arsp.nriga = 0
if isnull(kst_tab_arsp.colli) then kst_tab_arsp.colli = 0
if isnull(kst_tab_arsp.note_1) then	kst_tab_arsp.note_1 = ""
if isnull(kst_tab_arsp.note_2) then	kst_tab_arsp.note_2 = ""
if isnull(kst_tab_arsp.note_3) then	kst_tab_arsp.note_3 = ""
if isnull(kst_tab_arsp.colli_out) then kst_tab_arsp.colli_out = 0
if isnull(kst_tab_arsp.peso_kg_out) then	kst_tab_arsp.peso_kg_out = 0
if isnull(kst_tab_arsp.stampa) then kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_da_stamp 

end subroutine

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco arsp x id_meca)
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

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

		kdw_anteprima.dataobject = "d_arsp_l_1"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_meca)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc, k_ctr1=0
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr=0
long k_clie_2=0
string k_label, k_tipo_oggetto_padre, k_oggetto_corrente
string k_stato
int k_ind, k_mese, k_anno
string k_campo[15]
boolean k_flag_camion_caricato_si=true
int k_camion_caricato
alignment k_align[15]
alignment k_align_1
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_sped kst_tab_sped
st_tab_clienti kst_tab_clienti, kst_tab_clienti_ricev
st_tab_pagam kst_tab_pagam
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini
kuf_sped kuf1_sped
kuf_clienti kuf1_clienti
kuf_ausiliari kuf1_ausiliari
//kuf_treeview kuf1_treeview 

		 

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
		k_campo[k_ind] = "bolla "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Stato"
		k_align[k_ind] =  left!
		k_ind++
		k_campo[k_ind] = "Colli"
		k_align[k_ind] = right!
		k_ind++
		k_campo[k_ind] = "Ritiro / Uscita"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente"
		k_align[k_ind] = right!
		k_ind++
		k_campo[k_ind] = "Nominativo"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente"
		k_align[k_ind] = right!
		k_ind++
		k_campo[k_ind] = "Nominativo"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Pagamento"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Vettore"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "id"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=1
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
		k_handle = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		k_oggetto_corrente = trim(kst_treeview_data.oggetto)

		kuf1_sped = create kuf_sped 
		kuf1_clienti = create kuf_clienti
		kuf1_ausiliari = create kuf_ausiliari
	
		do while k_handle_item > 0 //and k_ctr1 < 200
//				k_ctr1++
//				if k_ctr1 > 140 then
//					k_ctr1++
//				end if
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_sped = kst_treeview_data_any.st_tab_sped

//--- get ricevente
			if kst_tab_clienti_ricev.codice =  kst_tab_sped.clie_2 then
			else
				if kst_tab_sped.clie_2 > 0 then
					kst_tab_clienti_ricev.codice = kst_tab_sped.clie_2
					kuf1_clienti.leggi_rag_soc_sped(kst_tab_clienti_ricev)
				else
					kst_tab_clienti_ricev.codice = 0
					kst_tab_clienti_ricev.rag_soc_10 = "non indicato! "
				end if
			end if

//--- get cliente
			if kst_tab_sped.clie_3 = kst_tab_sped.clie_2 then
				kst_tab_clienti = kst_tab_clienti_ricev
			else
				if kst_tab_sped.clie_3 > 0 then
					kst_tab_clienti.codice = kst_tab_sped.clie_3
					kuf1_clienti.leggi_rag_soc_sped(kst_tab_clienti)
				else
					kst_tab_clienti.codice = 0
					kst_tab_clienti.rag_soc_10 = "non indicato! "
				end if
			end if

//--- get pagamento
			if kst_tab_pagam.codice = kst_tab_clienti.cod_pag then
			else
				if kst_tab_clienti.cod_pag > 0 then
					kst_tab_pagam.codice = kst_tab_clienti.cod_pag
					kuf1_ausiliari.tb_select(kst_tab_pagam)
				else
					kst_tab_pagam.codice = 0
					kst_tab_pagam.des = "non indicato! "
				end if
			end if
			

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)


//--- controlla se Spedizione caricata su camion solo se ancora da stampare				
			k_flag_camion_caricato_si = true
			if kst_tab_sped.stampa = kki_sped_flg_stampa_bolla_da_stamp then	
//--- Camion Caricato (merce scaricata) da WM?		
				try
					if kst_tab_sped.NUM_BOLLA_OUT > 0 then
						kst_tab_sped.num_bolla_out = kst_tab_sped.NUM_BOLLA_OUT
						kst_tab_sped.data_bolla_out = kst_tab_sped.DATA_BOLLA_OUT
						k_camion_caricato = get_sped_camion_caricato(kst_tab_sped)
					else
						kst_tab_sped.NUM_BOLLA_OUT = 0
						kst_tab_sped.data_bolla_out = date(0)
					end if
					
				catch (uo_exception kuo_exception_camion_caricato)
					k_flag_camion_caricato_si = false
					destroy kuo_exception_camion_caricato
				end try
				
				if k_camion_caricato = kki_sped_camion_caricato_no then
					k_flag_camion_caricato_si = false
				end if
			end if
			
			if not k_flag_camion_caricato_si then
				k_stato = "camion da caricare "
			else
				choose case kst_tab_sped.stampa
					case kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp
						k_stato = "da stampare "
					case kuf1_sped.kki_sped_flg_stampa_bolla_stampata
						k_stato = "da fatturare"
					case kuf1_sped.kki_sped_flg_stampa_fatturato
						k_stato = "in fattura"
					case else
						k_stato = "?????????"
				end choose
			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_sped.num_bolla_out, "####0")  + " - " + string(kst_tab_sped.data_bolla_out, "dd.mm.yy"))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(k_stato) )
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_sped.colli, "##,##0")  ) 
			
			k_ind++
			if kst_tab_sped.data_uscita > date(0) then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_sped.data_rit) + " - " + string(kst_tab_sped.ora_rit) + " / " + string(kst_tab_sped.data_uscita) + " ")
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_sped.data_rit) + " - " + string(kst_tab_sped.ora_rit) + "  " )
			end if
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_sped.clie_2, "####0")))
                                      
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti_ricev.rag_soc_10))
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_sped.clie_3, "####0")))
                                      
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.cod_pag , "  ####0") + "  " + trim(kst_tab_pagam.des))
											  
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_sped.vett_1)  + "  " + trim(kst_tab_sped.vett_2))
											  
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_sped.id_sped))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop

		destroy kuf1_sped
		destroy kuf1_ausiliari
		destroy kuf1_clienti
		
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

public function integer u_tree_riempi_listview_righe_sped (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_pic_list, k_mese, k_anno
string k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_padre
date k_data_da, k_data_a, k_data_0, k_dataoggi
int k_ind, k_ctr
string k_campo[15], k_label
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_sped kst_tab_sped
st_tab_arsp kst_tab_arsp
st_tab_armo kst_tab_armo
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_profilestring_ini kst_profilestring_ini



declare kc_treeview cursor for
  SELECT 
         arsp.id_armo,
			armo.art,
			prodotti.des,
			armo.num_int,
			armo.data_int,
  			arsp.num_bolla_out,   
         arsp.data_bolla_out,   
         arsp.stampa,   
         arsp.colli,   
         arsp.colli_out,   
         arsp.peso_kg_out,   
         arsp.note_1,   
         arsp.note_2,   
         arsp.note_3,   
			sped.clie_2,
			sped.clie_3,
			c2.rag_soc_10, 
			c3.rag_soc_10 
    FROM arsp LEFT OUTER JOIN armo ON 
            arsp.id_armo = armo.id_armo      
              LEFT OUTER JOIN sped ON 
            arsp.num_bolla_out = sped.num_bolla_out      
            and arsp.data_bolla_out = sped.data_bolla_out      
               LEFT OUTER JOIN clienti c2 ON 
			   sped.clie_2 = c2.codice
              LEFT OUTER JOIN clienti c3 ON 
			   sped.clie_3 = c3.codice
              LEFT OUTER JOIN prodotti ON 
			   armo.art = prodotti.codice
    WHERE 
			 (:k_tipo_oggetto = :kuf1_treeview.kist_treeview_oggetto.sped_righe_dett
			  and 
		        (arsp.num_bolla_out = :kst_tab_arsp.num_bolla_out 
		        and arsp.data_bolla_out = :kst_tab_arsp.data_bolla_out )
			 )	   
	 order by 
		 arsp.data_bolla_out, arsp.num_bolla_out, arsp.id_armo
	 using sqlca;


	k_data_0 = date(0)		 

//=== Costruisce e Dimensiona le colonne all'interno della listview
	k_ind=1
	k_campo[k_ind] = "Articolo spedito"
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "Stato"
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "D.d.t."
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "Colli scar./sped."
	k_align[k_ind] = right!
	k_ind++
	k_campo[k_ind] = "Peso"
	k_align[k_ind] = right!
	k_ind++
	k_campo[k_ind] = "Riferimento"
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "Note"
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "Ricevente"
	k_align[k_ind] = left!
	k_ind++
	k_campo[k_ind] = "Cliente"
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

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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

//--- Periodo di estrazione, se la data e' a zero allora anno nel num_bolla_out
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_arsp.data_bolla_out > date (0) then
		k_mese = month(kst_treeview_data_any.st_tab_arsp.data_bolla_out) 
		if isnull(k_mese) or k_mese = 0 then
			k_dataoggi = kguo_g.get_dataoggi( )
			kst_treeview_data_any.st_tab_arsp.data_bolla_out = k_dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_arsp.data_bolla_out) 
		end if
		k_anno = year(kst_treeview_data_any.st_tab_arsp.data_bolla_out)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	else
		k_data_da = date(kst_treeview_data_any.st_tab_arsp.num_bolla_out, 01, 01)
		k_data_a = date(kst_treeview_data_any.st_tab_arsp.num_bolla_out, 12, 31)
	end if

	if kst_treeview_data_any.st_tab_arsp.num_bolla_out > 0 then
		kst_tab_arsp = kst_treeview_data_any.st_tab_arsp
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		k_pic_list = kuf1_treeview.u_dammi_pic_tree_list(k_tipo_oggetto)			


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
//--- cancello dalla listview tutto
		kuf1_treeview.kilv_lv1.DeleteItems()

		ktvi_treeviewitem.selected = false

//--- Insert del primo item in lista quello di default del 'ritorno'
		kst_treeview_data.oggetto = k_tipo_oggetto
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)



		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					:kst_tab_arsp.id_armo,
					:kst_tab_armo.art,   
					:kst_tab_prodotti.des,
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_arsp.num_bolla_out,   
					:kst_tab_arsp.data_bolla_out,   
					:kst_tab_arsp.stampa,   
					:kst_tab_arsp.colli,   
					:kst_tab_arsp.colli_out,   
					:kst_tab_arsp.peso_kg_out,   
					:kst_tab_arsp.note_1,   
					:kst_tab_arsp.note_2,   
					:kst_tab_arsp.note_3,   
					:kst_tab_sped.clie_2,
					:kst_tab_sped.clie_3,
				   :kst_tab_clienti.rag_soc_10, 
				   :kst_tab_clienti.rag_soc_20 
				  ;
	
			
			do while sqlca.sqlcode = 0

				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any
				kst_treeview_data.oggetto_listview = k_tipo_oggetto
				
				klvi_listviewitem.data = kst_treeview_data

				klvi_listviewitem.pictureindex = k_pic_list
			   
				klvi_listviewitem.selected = false
				
				k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)


				choose case kst_tab_arsp.stampa
					case "S"
						k_stato = "Stampato"
					case "F"
						k_stato = "Fatturato"
					case else
						k_stato = "Da stampare"
				end choose

				if isnull(kst_tab_prodotti.des) then
					kst_tab_prodotti.des = " "
				end if
 				if isnull(kst_tab_arsp.colli) then		
					kst_tab_arsp.colli = 0
				end if
				if isnull(kst_tab_arsp.colli_out) then		
					kst_tab_arsp.colli_out = 0
				end if
				if isnull(kst_tab_arsp.note_1) then		
					kst_tab_arsp.note_1 = " "
				end if
				if isnull(kst_tab_arsp.note_2) then		
					kst_tab_arsp.note_2 = " "
				end if
				if isnull(kst_tab_arsp.note_3) then		
					kst_tab_arsp.note_3 = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_10) then		
					kst_tab_clienti.rag_soc_10 = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_20) then		
					kst_tab_clienti.rag_soc_20 = " "
				end if
				
				kst_tab_sped.num_bolla_out = kst_tab_arsp.num_bolla_out
				kst_tab_sped.data_bolla_out = kst_tab_arsp.data_bolla_out
	
				kst_treeview_data_any.st_tab_arsp = kst_tab_arsp
				kst_treeview_data_any.st_tab_sped = kst_tab_sped
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti

				kuf1_treeview.kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_armo.art) + " - " &
				                + trim(kst_tab_prodotti.des))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 2, trim(k_stato))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 3, string(kst_tab_arsp.num_bolla_out, "####0") &
				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy"))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 4, string(kst_tab_arsp.colli, "##,##0") &
											  + " / " + string(kst_tab_arsp.colli_out, "##,##0")) 
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.peso_kg, "##,##0.00"))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.num_int , "  ####0")  &
				                          + "  " + string(kst_tab_armo.data_int , "dd/mm/yy"))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_arsp.note_1) &
											  + " " + trim(kst_tab_arsp.note_2) &
											  + " " + trim(kst_tab_arsp.note_3))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 8, string(kst_tab_sped.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_10))
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 9, string(kst_tab_sped.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20))
				

//				kst_tab_treeview.voce = trim(kst_tab_armo.art) &
//				                    + "  (" + string(kst_tab_arsp.num_bolla_out, "####0") &
//				                    + "/" + string(kst_tab_arsp.data_bolla_out, "yyyy") + ") " 
//
//				kst_tab_treeview.descrizione_tipo =  k_stato & 
//				                    + "  ddt: " + string(kst_tab_arsp.num_bolla_out, "####0") &
//				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy") 
//				if kst_tab_arsp.colli <> kst_tab_arsp.colli_out then
//					kst_tab_treeview.descrizione_tipo = kst_tab_treeview.descrizione_tipo & 
//											  + "  Colli scar./sped.: " + string(kst_tab_arsp.colli, "##,##0") &
//											  + "/" + string(kst_tab_arsp.colli_out, "##,##0") 
//				else
//					kst_tab_treeview.descrizione_tipo = kst_tab_treeview.descrizione_tipo & 
//											  + "  Colli: " + string(kst_tab_arsp.colli, "##,##0") 
//				end if											  
//				kst_tab_treeview.descrizione_tipo =  kst_tab_treeview.descrizione_tipo & 
//											  + "  Peso kg: " + string(kst_tab_arsp.peso_kg_out, "##,##0.00") &
//				
//				kst_tab_treeview.descrizione = &
//											  + "Note: " + trim(kst_tab_arsp.note_1) &
//											  + " " + trim(kst_tab_arsp.note_2) &
//											  + " " + trim(kst_tab_arsp.note_3) 
//											  
//				kst_tab_treeview.descrizione_ulteriore =  &
//											  + " Ricev.:" + string(kst_tab_sped.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_10) &
//											  + " Fatt.:" + string(kst_tab_sped.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20)
//											  
//				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
//				
//				kst_treeview_data.struttura = kst_treeview_data_any
//				
//				kst_treeview_data.label = &
//				                    string(kst_tab_arsp.num_bolla_out, "####0") &
//				                    + " - " + string(kst_tab_arsp.data_bolla_out, "dd.mm.yy") &
//										  + " "  &
//										  +  &
//										  + " (" + string(kst_tab_sped.clie_2, "#####") + " -> " &
//										  + string(kst_tab_sped.clie_3, "#####") + ")"
//
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
//				kst_treeview_data.handle = k_handle_item_padre
//	
//				ktvi_treeviewitem.label = kst_treeview_data.label
//				ktvi_treeviewitem.data = kst_treeview_data
//										  
////--- Nuovo Item
//				ktvi_treeviewitem.selected = false
//				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
//				
////--- salvo handle del item appena inserito nella stessa struttura
//				kst_treeview_data.handle = k_handle_item
//
////--- inserisco il handle di questa riga tra i dati del item
//				ktvi_treeviewitem.data = kst_treeview_data
//
//				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
	
				fetch kc_treeview 
				into
					:kst_tab_arsp.id_armo,
					:kst_tab_armo.art,   
					:kst_tab_prodotti.des,
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_arsp.num_bolla_out,   
					:kst_tab_arsp.data_bolla_out,   
					:kst_tab_arsp.stampa,   
					:kst_tab_arsp.colli,   
					:kst_tab_arsp.colli_out,   
					:kst_tab_arsp.peso_kg_out,   
					:kst_tab_arsp.note_1,   
					:kst_tab_arsp.note_2,   
					:kst_tab_arsp.note_3,   
					:kst_tab_sped.clie_2,
					:kst_tab_sped.clie_3,
				   :kst_tab_clienti.rag_soc_10, 
				   :kst_tab_clienti.rag_soc_20 
					 ;
	
			loop
			
			close kc_treeview;
			
//--- Aggiorna il primo item in lista quello di default del 'ritorno'
			kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
			kst_treeview_data = ktvi_treeviewitem.data
			if k_handle_item_padre > 0 then
//--- prendo il item padre per settare il ritorno di default
				k_handle_item = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
				if k_handle_item <= 0 then
					k_handle_item = 1
				end if
			else
				k_handle_item = 1
			end if
			kst_treeview_data.handle_padre = k_handle_item_padre
			kst_treeview_data.handle = k_handle_item
			kst_treeview_data.oggetto_listview = k_tipo_oggetto
			kst_treeview_data.oggetto = ""
			klvi_listviewitem.label = ".."
			klvi_listviewitem.data = kst_treeview_data
			klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
			kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)

//			kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//			ktvi_treeviewitem.selected = true
//			ktvi_treeviewitem.Expanded	= true
//			kuf1_treeview.kitv_tv1.setitem(k_handle_item_padre, ktvi_treeviewitem)
	
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc, k_num_rec=0
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_dataoggix, k_stato, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_data_da, k_data_a, k_data_0, k_dataoggi_meno150, k_dataoggi, k_dataoggi_meno370
string k_dataoggi_x, k_data_da_x, k_data_a_x
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_sped kst_tab_sped
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
kuf_base kuf1_base
kuf_sped kuf1_sped
kuf_armo kuf1_armo

 //non più di 6000 righe
	k_query_select = &
	"  SELECT distinct  " &
	+ "  top 10000 "  &
	+ "         sped.id_sped,  "  &
	+ "         sped.num_bolla_out,  "  &
	+ "         sped.data_bolla_out, "  &
	+ "         sped.stampa,   " &
	+ "         sped.colli,   " &
	+ "         sped.data_rit, " & 
	+ "         sped.data_uscita, " & 
	+ "         sped.ora_rit,   " &
	+ "         sped.vett_1,   " &
	+ "         sped.vett_2,   " &
	+ "         sped.note_1,   " &
	+ "         sped.note_2,   " &
	+ "         sped.causale,   " &
	+ "         sped.aspetto, " &
	+ "			sped.clie_2, " &
	+ "			sped.clie_3, " &
	+ "			c2.rag_soc_10, " &
	+ "			c3.rag_soc_10 " &
	+ "    FROM sped LEFT OUTER JOIN clienti c2 ON " &
	+ "			 sped.clie_2 = c2.codice " &
	+ "              LEFT OUTER JOIN clienti c3 ON " &
	+ "			 sped.clie_3 = c3.codice " &
	+ "			     inner join arsp on " &
	+ "	 	    sped.data_bolla_out = arsp.data_bolla_out and sped.num_bolla_out = arsp.num_bolla_out " &
	+ "			     inner join armo on " &
	+ "	 	    arsp.id_armo = armo.id_armo " &
	+ "			     inner join meca on " &
	+ "	 	    armo.id_meca = meca.id  "


	
	kuf1_sped = create kuf_sped
	
	k_data_0 = date(0)		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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

//--- Ricava le date
k_dataoggi = kg_dataoggi
k_dataoggi_meno150 = relativedate(k_dataoggi, -150)
k_dataoggi_meno370 = relativedate(k_dataoggi, -370)

//--- Periodo di estrazione, se la data e' a zero allora anno nel num_bolla_out
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_sped.data_bolla_out > date (0) then
		k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		if isnull(k_mese) or k_mese = 0 then
			kst_treeview_data_any.st_tab_sped.data_bolla_out = k_dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		end if
		k_anno = year(kst_treeview_data_any.st_tab_sped.data_bolla_out)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = relativedate(date (k_anno, k_mese, 01), -1) 
	else
		k_data_da = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 01, 01)
		k_data_a = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 12, 31)
	end if
	
////--- se richiesto + di 2 mesi allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
//	if DaysAfter ( k_data_da, k_data_a ) > 61 then
//		k_data_da = relativedate(k_data_a , -7)
//	end if
	
	kst_tab_meca = kst_treeview_data_any.st_tab_meca

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_list
		end if
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_open)

	
	choose case k_tipo_oggetto
			
		case kuf1_treeview.kist_treeview_oggetto.sped_righe_dett
			k_query_where = " where " &
				+ " (sped.data_bolla_out = ? " &
				+ "  and sped.num_bolla_out = ? ) " 
	
		case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett, kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
			k_query_where = " where " &
			+ " armo.id_meca = ? " 
	
		case kuf1_treeview.kist_treeview_oggetto.sped_da_st_dett 
			k_query_where = " where " &
			+ " sped.data_bolla_out > ? " &
			+ " and sped.stampa = ? " &
			+ " and (meca.aperto is null or meca.aperto <> ? ) "
			
		case kuf1_treeview.kist_treeview_oggetto.sped_da_ft_dett 
			k_query_where = " where " &
			+ " sped.data_bolla_out > ? " &
			+ " and sped.stampa <> ? " &
			+ " and (meca.aperto is null or meca.aperto <> ? ) "

		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_ft_dett
			k_query_where = " where " &
			+ " sped.data_bolla_out > ? " &
			+ " and sped.clie_3 = ? " &
			+ " and sped.stampa <> ? " &
			+ " and (meca.aperto is null or meca.aperto <> ? ) "
			
		case kuf1_treeview.kist_treeview_oggetto.sped_pagam_da_ft_dett
			k_query_where = " where " &
			+ " sped.data_bolla_out > ? " &
			+ " and sped.stampa <> ? " &
			+ " and c3.cod_pag = ? " & 
			+ " and (meca.aperto is null or meca.aperto <> ? ) "
			
		case kuf1_treeview.kist_treeview_oggetto.sped_dett
			k_query_where = " where " &
			+ " sped.data_bolla_out between ? and  ? " 
	
		case else
			k_query_where = " " 
			
	end choose

	k_query_order = &
	+ "	 order by " &
	+ "		 sped.data_bolla_out desc, sped.num_bolla_out desc "
	
//--- Composizione della Query	
	if len(trim(k_query_where)) > 0 then
		declare kc_treeview dynamic cursor for SQLSA ;
		k_query_select = k_query_select + k_query_where + k_query_order
		prepare SQLSA from :k_query_select using sqlca;
	end if		

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		choose case k_tipo_oggetto
			
			case kuf1_treeview.kist_treeview_oggetto.sped_righe_dett
				open DYNAMIC kc_treeview using :kst_tab_sped.data_bolla_out, :kst_tab_sped.num_bolla_out;
				
			case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett,  kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
				open DYNAMIC kc_treeview using :kst_tab_meca.id;
				
			case kuf1_treeview.kist_treeview_oggetto.sped_da_st_dett
				k_dataoggi_x = string(k_dataoggi_meno150)
				kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no
				kst_tab_sped.stampa = kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp
				open DYNAMIC kc_treeview using :k_dataoggi_x, :kst_tab_sped.stampa, :kst_tab_meca.aperto ;
				
			case kuf1_treeview.kist_treeview_oggetto.sped_da_ft_dett
				k_dataoggi_x = string(k_dataoggi_meno370)
				kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no
				kst_tab_sped.stampa = kuf1_sped.kki_sped_flg_stampa_fatturato
				open DYNAMIC kc_treeview using :k_dataoggi_x, :kst_tab_sped.stampa, :kst_tab_meca.aperto ;
				
			case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_ft_dett
				k_dataoggi_x = string(k_dataoggi_meno370)
				kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no
				kst_tab_sped.stampa = kuf1_sped.kki_sped_flg_stampa_fatturato
				open DYNAMIC kc_treeview using :k_dataoggi_x, :kst_treeview_data_any.st_tab_sped.clie_3, :kst_tab_sped.stampa, :kst_tab_meca.aperto ;
				
			case kuf1_treeview.kist_treeview_oggetto.sped_pagam_da_ft_dett
				k_dataoggi_x = string(k_dataoggi_meno370)
				kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no
				kst_tab_sped.stampa = kuf1_sped.kki_sped_flg_stampa_fatturato
				open DYNAMIC kc_treeview using :k_dataoggi_x, :kst_tab_sped.stampa, :kst_treeview_data_any.st_tab_clienti.cod_pag, :kst_tab_meca.aperto ;
				
			case kuf1_treeview.kist_treeview_oggetto.sped_dett
				k_data_da_x = string(k_data_da)
				k_data_a_x = string(k_data_a)
				open DYNAMIC kc_treeview using :k_data_da_x, :k_data_a_x ;
				
			case else
//				kuf1_treeview.kist_treeview_oggetto.sped_da_st_dett &
//				,kuf1_treeview.kist_treeview_oggetto.sped_da_ft_dett &
//				,kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_ft_dett &
//				,kuf1_treeview.kist_treeview_oggetto.sped_pagam_da_ft_dett
				open DYNAMIC kc_treeview;
				
		end choose
		
		if sqlca.sqlcode = 0 then
			
			
			fetch kc_treeview 
				into
					:kst_tab_sped.id_sped,   
					:kst_tab_sped.num_bolla_out,   
					:kst_tab_sped.data_bolla_out,   
					:kst_tab_sped.stampa,   
					:kst_tab_sped.colli,   
					:kst_tab_sped.data_rit,   
					:kst_tab_sped.data_uscita,   
					:kst_tab_sped.ora_rit,   
					:kst_tab_sped.vett_1,   
					:kst_tab_sped.vett_2,   
					:kst_tab_sped.note_1,   
					:kst_tab_sped.note_2,   
					:kst_tab_sped.causale,   
					:kst_tab_sped.aspetto,
					:kst_tab_sped.clie_2,
					:kst_tab_sped.clie_3,
					:kst_tab_clienti.rag_soc_10, 
					:kst_tab_clienti.rag_soc_20 
				  ;
	
			k_num_rec = 1
			do while sqlca.sqlcode = 0 and k_num_rec < 5000

				k_num_rec++
				kst_treeview_data_any.st_tab_arsp.num_bolla_out = kst_tab_sped.num_bolla_out
				kst_treeview_data_any.st_tab_arsp.data_bolla_out = kst_tab_sped.data_bolla_out   

				kuf1_sped.if_isnull_testa(kst_tab_sped)
				if isnull(kst_tab_clienti.rag_soc_10) then		
					kst_tab_clienti.rag_soc_10 = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_20) then		
					kst_tab_clienti.rag_soc_20 = " "
				end if

				kst_treeview_data_any.st_tab_sped = kst_tab_sped
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti

				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				if k_num_rec = 5000 then
					kst_tab_sped.num_bolla_out = 0
					kst_tab_sped.data_bolla_out = date(0)
					kst_tab_sped.clie_2 = 0
					kst_tab_sped.clie_3 = 0
					kst_treeview_data.label = ".... troppi documenti fine elenco..."
				
				else
					kst_treeview_data.label = &
				                    string(kst_tab_sped.num_bolla_out, "####0") &
				                    + " - " + string(kst_tab_sped.data_bolla_out, "dd.mm.yy") &
										  + " "  &
										  +  &
										  + " (" + string(kst_tab_sped.clie_2, "#####") + " -> " &
										  + string(kst_tab_sped.clie_3, "#####") + ")"
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
	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
				into
					:kst_tab_sped.id_sped,   
					:kst_tab_sped.num_bolla_out,   
					:kst_tab_sped.data_bolla_out,   
					:kst_tab_sped.stampa,   
					:kst_tab_sped.colli,   
					:kst_tab_sped.data_rit,   
					:kst_tab_sped.data_uscita,   
					:kst_tab_sped.ora_rit,   
					:kst_tab_sped.vett_1,   
					:kst_tab_sped.vett_2,   
					:kst_tab_sped.note_1,   
					:kst_tab_sped.note_2,   
					:kst_tab_sped.causale,   
					:kst_tab_sped.aspetto,
					:kst_tab_sped.clie_2,
					:kst_tab_sped.clie_3,
				   :kst_tab_clienti.rag_soc_10, 
				   :kst_tab_clienti.rag_soc_20 
					 ;
	
			loop
			
			close kc_treeview;

		end if

	end if 

	destroy kuf1_sped
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_clie_3 (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_stato, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_data_da, k_data_a, k_data_0, k_dataoggi_meno150, k_dataoggi
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview, kst_tab_treeview_orig
st_tab_sped kst_tab_sped
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
kuf_sped kuf1_sped


	k_query_select = &
	"  SELECT distinct  " &
	+ "         count(*) as contati,  "  &
	+ "         sum(sped.colli) as colli,   " &
	+ "			sped.clie_3, " &
	+ "			c3.rag_soc_10 " &
	+ "    FROM (sped LEFT OUTER JOIN clienti c3 ON " &
	+ "			 sped.clie_3 = c3.codice) " 


	
	kuf1_sped = create kuf_sped
	
	k_data_0 = date(0)		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	kst_tab_treeview_orig = kst_tab_treeview
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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

//--- Ricava le date
	k_dataoggi = kguo_g.get_dataoggi( )
	k_dataoggi_meno150 = relativedate(k_dataoggi, -150)

//--- Periodo di estrazione, se la data e' a zero allora anno nel num_bolla_out
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_sped.data_bolla_out > date (0) then
		k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		if isnull(k_mese) or k_mese = 0 then
			kst_treeview_data_any.st_tab_sped.data_bolla_out = k_dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		end if
		k_anno = year(kst_treeview_data_any.st_tab_sped.data_bolla_out)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	else
		k_data_da = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 01, 01)
		k_data_a = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 12, 31)
	end if
	kst_tab_meca = kst_treeview_data_any.st_tab_meca

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_list
		end if
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_open)

	
	choose case k_tipo_oggetto
			
//		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3
//			k_query_where = " where " &
//				+ " (sped.data_bolla_out = ? " &
//				+ "  and sped.num_bolla_out = ?) " 
//	
//		case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett, kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
//			k_query_where = " where " &
//			+ " armo.id_meca = ? " 
//	
//		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_st 
//			k_query_where = " where " &
//			+ " sped.data_bolla_out > '" + string(k_dataoggi_meno150) + "' " &
//			+ " and sped.stampa = '" + trim(string(kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp)) + "' "
			
		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_ft 
			k_query_where = " where " &
			+ " sped.data_bolla_out > '" + string(k_dataoggi_meno150) + "' " &
			+ " and sped.stampa <> '" + kuf1_sped.kki_sped_flg_stampa_fatturato + "' "
	
		case else
			k_query_where = " " 
			
	end choose

	k_query_order = &
	+ "	 group by " &
	+ "		sped.clie_3, " &
	+ "		c3.rag_soc_10 " &
	+ "	 order by " &
	+ "		c3.rag_soc_10 "
	
//--- Composizione della Query	
	if len(trim(k_query_where)) > 0 then
		declare kc_treeview dynamic cursor for SQLSA ;
		k_query_select = k_query_select + k_query_where + k_query_order
		prepare SQLSA from :k_query_select using sqlca;
	end if		

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		choose case k_tipo_oggetto
			
//			case kuf1_treeview.kist_treeview_oggetto.sped_righe_dett
//				open DYNAMIC kc_treeview using :kst_tab_sped.data_bolla_out, :kst_tab_sped.num_bolla_out;
//			case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett,  kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
//				open DYNAMIC kc_treeview using :kst_tab_meca.id;
			case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_ft
				open DYNAMIC kc_treeview;
				
			case else
				sqlca.sqlcode = 100
		end choose
		
		if sqlca.sqlcode = 0 then
			
			
			fetch kc_treeview 
				into
					:kst_tab_sped.st_tab_g_0.contati
					,:kst_tab_sped.colli 
					,:kst_tab_sped.clie_3
					,:kst_tab_clienti.rag_soc_10 
				  ;
	
			
			do while sqlca.sqlcode = 0


				kuf1_sped.if_isnull_testa(kst_tab_sped)
				if isnull(kst_tab_clienti.rag_soc_10) then		
					kst_tab_clienti.rag_soc_10 = " "
				end if

				kst_treeview_data_any.st_tab_sped = kst_tab_sped
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti

				
				kst_treeview_data.label = &
								 trim(kst_tab_clienti.rag_soc_10) &
				                   +  "  (" + string(kst_tab_sped.clie_3, "####0") &
								 + ") "  
//---riempo campi della LISTA di default
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(kst_tab_sped.clie_3)
				if kst_tab_sped.st_tab_g_0.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_tab_sped.st_tab_g_0.contati, "###,##0") + "   documento presente"
				else
					kst_tab_treeview.descrizione = string(kst_tab_sped.st_tab_g_0.contati, "###,##0") + "   documenti presenti"
				end if
				kst_tab_treeview.descrizione_tipo = kst_tab_treeview_orig.descrizione
				kst_tab_treeview.descrizione_ulteriore = " " 

				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any

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
	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
				into
					:kst_tab_sped.st_tab_g_0.contati
					,:kst_tab_sped.colli    
					,:kst_tab_sped.clie_3
					,:kst_tab_clienti.rag_soc_10 
					 ;
	
			loop
			
			close kc_treeview;
			
			
		end if

	end if 

	destroy kuf1_sped
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_pagam (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_stato, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_data_da, k_data_a, k_data_0, k_dataoggi_meno150, k_dataoggi, k_dataoggi_meno370
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview, kst_tab_treeview_orig
st_tab_sped kst_tab_sped
st_tab_clienti kst_tab_clienti
st_tab_pagam kst_tab_pagam
kuf_sped kuf1_sped

//	+ "         sum(sped.colli) as colli,   " &

	k_query_select = &
	"  SELECT distinct  " &
	+ "         count(*) as contati,  "  &
	+ "			c3.cod_pag, " &
	+ "			pagam.des " &
	+ "    FROM ((sped LEFT OUTER JOIN clienti c3 ON " &
	+ "			 sped.clie_3 = c3.codice) " &
	+ "                       LEFT OUTER JOIN pagam  ON " &
	+ "			 c3.cod_pag = pagam.codice) " 


	
	kuf1_sped = create kuf_sped
	
	k_data_0 = date(0)		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	kst_tab_treeview_orig = kst_tab_treeview
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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

//--- Ricava le date
	k_dataoggi = kguo_g.get_dataoggi( )
	k_dataoggi_meno150 = relativedate(k_dataoggi, -150)
	k_dataoggi_meno370 = relativedate(k_dataoggi, -370)

//--- Periodo di estrazione, se la data e' a zero allora anno nel num_bolla_out
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_sped.data_bolla_out > date (0) then
		k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		if isnull(k_mese) or k_mese = 0 then
			kst_treeview_data_any.st_tab_sped.data_bolla_out = k_dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_sped.data_bolla_out) 
		end if
		k_anno = year(kst_treeview_data_any.st_tab_sped.data_bolla_out)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	else
		k_data_da = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 01, 01)
		k_data_a = date(kst_treeview_data_any.st_tab_sped.num_bolla_out, 12, 31)
	end if
//	kst_tab_meca = kst_treeview_data_any.st_tab_meca

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_list
		end if
		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_open)

	
	choose case k_tipo_oggetto
			
//		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3
//			k_query_where = " where " &
//				+ " (sped.data_bolla_out = ? " &
//				+ "  and sped.num_bolla_out = ?) " 
//	
//		case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett, kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
//			k_query_where = " where " &
//			+ " armo.id_meca = ? " 
//	
//		case kuf1_treeview.kist_treeview_oggetto.sped_clie_3_da_st 
//			k_query_where = " where " &
//			+ " sped.data_bolla_out > '" + string(k_dataoggi_meno150) + "' " &
//			+ " and sped.stampa = '" + trim(string(kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp)) + "' "
			
		case kuf1_treeview.kist_treeview_oggetto.sped_pagam_da_ft 
			k_query_where = " where " &
			+ " sped.data_bolla_out > '" + string(k_dataoggi_meno370) + "' " &
			+ " and sped.stampa <> '" + kuf1_sped.kki_sped_flg_stampa_fatturato + "' "
	
		case else
			k_query_where = " " 
			
	end choose

	k_query_order = &
	+ "	 group by " &
	+ "			c3.cod_pag, " &
	+ "			pagam.des " &
	+ "	 order by " &
	+ "			c3.cod_pag " 
	
//--- Composizione della Query	
	if len(trim(k_query_where)) > 0 then
		declare kc_treeview dynamic cursor for SQLSA ;
		k_query_select = k_query_select + k_query_where + k_query_order
		prepare SQLSA from :k_query_select using sqlca;
	end if		

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		choose case k_tipo_oggetto
			
//			case kuf1_treeview.kist_treeview_oggetto.sped_righe_dett
//				open DYNAMIC kc_treeview using :kst_tab_sped.data_bolla_out, :kst_tab_sped.num_bolla_out;
//			case kuf1_treeview.kist_treeview_oggetto.meca_car_sp_dett,  kuf1_treeview.kist_treeview_oggetto.armo_tipo_sp 
//				open DYNAMIC kc_treeview using :kst_tab_meca.id;
			case kuf1_treeview.kist_treeview_oggetto.sped_pagam_da_ft
				open DYNAMIC kc_treeview;
				
			case else
				sqlca.sqlcode = 100
		end choose
		
		if sqlca.sqlcode = 0 then
			
			
			fetch kc_treeview 
				into
					:kst_tab_sped.st_tab_g_0.contati
					,:kst_tab_clienti.cod_pag
					,:kst_tab_pagam.des
				  ;
	
			
			do while sqlca.sqlcode = 0


				kuf1_sped.if_isnull_testa(kst_tab_sped)
				if isnull(kst_tab_clienti.rag_soc_10) then		
					kst_tab_clienti.rag_soc_10 = " "
				end if

				kst_treeview_data_any.st_tab_sped = kst_tab_sped
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti

				if isnull(kst_tab_clienti.cod_pag) then kst_tab_clienti.cod_pag = 0
				if isnull(kst_tab_pagam.des) then kst_tab_pagam.des = "*** Assente ***"
				
				kst_treeview_data.label = &
								 string(kst_tab_clienti.cod_pag, "####0") &
				                   +  " - " + trim(kst_tab_pagam.des) &
								 + " "  
//---riempo campi della LISTA di default
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(kst_tab_clienti.cod_pag)
				if kst_tab_sped.st_tab_g_0.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_tab_sped.st_tab_g_0.contati, "###,##0") + "   documento presente"
				else
					kst_tab_treeview.descrizione = string(kst_tab_sped.st_tab_g_0.contati, "###,##0") + "   documenti presenti"
				end if
				kst_tab_treeview.descrizione_tipo = kst_tab_treeview_orig.descrizione
				kst_tab_treeview.descrizione_ulteriore = " " 

				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any

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
	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
				into
					:kst_tab_sped.st_tab_g_0.contati
					,:kst_tab_clienti.cod_pag
					,:kst_tab_pagam.des
				  ;
	
			loop
			
			close kc_treeview;
			
			
		end if

	end if 

	destroy kuf1_sped
 
return k_return


end function

public function st_esito get_clie (ref st_tab_sped kst_tab_sped);//
//--- Leggo CLIENTI spedizione (ricevente, fatturato)
//
long k_codice, k_anno
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped.id_sped > 0 then
		
		SELECT 
			sped.clie_2,   
			sped.clie_3  
		 INTO 
		  	:kst_tab_sped.clie_2,   
			:kst_tab_sped.clie_3
	 	FROM sped  
		WHERE id_sped = :kst_tab_sped.id_sped
			  using sqlca;
	
	else
		
		k_anno = year(kst_tab_sped.data_bolla_out)
		
		SELECT 
			sped.clie_2,   
			sped.clie_3  
		 INTO 
		  	:kst_tab_sped.clie_2,   
			:kst_tab_sped.clie_3
	 	FROM sped  
		WHERE ( num_bolla_out = :kst_tab_sped.num_bolla_out ) AND  
			( year(data_bolla_out) = :k_anno)   
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.d.d.t., bolla di sped. (numero=" + string( kst_tab_sped.num_bolla_out) + " del "+ string( k_anno )+") ~n~r" &
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

public function st_esito get_righe (ref st_tab_arsp kst_tab_arsp[]);//
//--- Leggo Righe Bolla di spedizione 
//--- Input: st_tab_sped[1].num_bolla_out, data_bolla_out
//--- Out: st_tab_sped[] con le righe trovate, ST_ESITO
//
int k_ind
st_tab_arsp kst_tab_arsp_app, kst_tab_arsp_null[] 
st_esito kst_esito

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kst_tab_arsp_app.num_bolla_out = kst_tab_arsp[1].num_bolla_out
	kst_tab_arsp_app.data_bolla_out = kst_tab_arsp[1].data_bolla_out

//--- inizializza la ARRAY da restituire
	kst_tab_arsp[] = kst_tab_arsp_null[] 
		

	 DECLARE c_get_righe_arsp CURSOR FOR  
		  SELECT arsp.id_arsp,   
					arsp.id_armo,   
					arsp.colli,   
					arsp.colli_out  
			 FROM arsp
			 WHERE ( num_bolla_out = :kst_tab_arsp_app.num_bolla_out ) AND  
       				  ( data_bolla_out = :kst_tab_arsp_app.data_bolla_out)   ;

	open  c_get_righe_arsp;
	if sqlca.sqlcode = 0 then

		k_ind=1
		fetch c_get_righe_arsp into 
						:kst_tab_arsp[k_ind].id_arsp
						,:kst_tab_arsp[k_ind].id_armo
						,:kst_tab_arsp[k_ind].colli
						,:kst_tab_arsp[k_ind].colli_out;
		
		do while sqlca.sqlcode = 0
			
			k_ind ++
			fetch c_get_righe_arsp into 
						:kst_tab_arsp[k_ind].id_arsp
						,:kst_tab_arsp[k_ind].id_armo
						,:kst_tab_arsp[k_ind].colli
						,:kst_tab_arsp[k_ind].colli_out;
						
		loop

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.d.d.t., Righe bolla (numero=" + string( kst_tab_arsp_app.num_bolla_out) + " del "+ string( kst_tab_arsp_app.data_bolla_out)+") : " &
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

		close c_get_righe_arsp;
	
	end if
		
return kst_esito


end function

public function st_esito set_riga_fatturata (st_tab_arsp kst_tab_arsp);//
//====================================================================
//=== Imposta a Fatturata la Riga della Bolla di spedizione
//=== 
//=== Se necessario imposta a Fatturata l'intera Spedizione 
//=== 
//=== Input: st_arsp.id_arsp
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_tab_sped kst_tab_sped
st_tab_arsp kst_tab_arsp1
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
if kst_tab_arsp.id_arsp > 0 then
	
	kst_esito = get_numero_da_id(kst_tab_arsp )
	if kst_esito.esito = kkg_esito.ok or  kst_esito.esito = kkg_esito.db_wrn then
			
		kst_tab_arsp.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_arsp.x_utente = kGuf_data_base.prendi_x_utente()

		kst_tab_arsp1.stampa = kki_sped_flg_stampa_fatturato
		UPDATE arsp  
			  SET stampa = :kst_tab_arsp1.stampa  
		  			,x_datins = :kst_tab_arsp.x_datins
			  		,x_utente = :kst_tab_arsp.x_utente
			WHERE arsp.id_arsp = :kst_tab_arsp.id_arsp   
			using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiorn. riga d.d.t. ~n~r" &
						+ " (riga=" + string(kst_tab_arsp.id_arsp, "####0") + ") Sped. nr. " &
						+ string(kst_tab_arsp.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		else
			
//--- se non ci sono più colli da fatt x la sped allora aggioro anche la testata dellla SPEDIZIONE 
			kst_esito = get_colli_da_fatt( kst_tab_arsp ) 
			if kst_esito.esito = kkg_esito.ok then
				if kst_tab_arsp.colli = 0 then 
					kst_tab_sped.num_bolla_out = kst_tab_arsp.num_bolla_out
					kst_tab_sped.data_bolla_out = kst_tab_arsp.data_bolla_out
					kst_tab_sped.st_tab_g_0.esegui_commit = kst_tab_arsp.st_tab_g_0.esegui_commit
					
					kst_esito = set_sped_fatturata( kst_tab_sped )
					
				end if
			end if
			
		end if
	
//---- COMMIT o ROLLBACK....	
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		end if
	
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe d.d.t., Manca il nr. riga (id_arsp) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito get_numero_da_id (ref st_tab_arsp kst_tab_arsp);//
//--- Piglia il NUMERO e DATA spedizione da id_arsp
//
//--- inp: st_tab_arsp.id_arsp
//--- out: st_esito
//
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

SELECT distinct arsp.num_bolla_out
  			,arsp.data_bolla_out   
    INTO :kst_tab_arsp.num_bolla_out,   
         :kst_tab_arsp.data_bolla_out  
    FROM arsp  
   WHERE ( id_arsp = :kst_tab_arsp.id_arsp ) 
           using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., riga bolla di sped. (id=" + string( kst_tab_arsp.id_arsp) + "): ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	
return kst_esito



end function

public function st_esito get_colli_da_fatt (ref st_tab_arsp kst_tab_arsp);//
//--- Testa se ancora qlc riga di bolla da fatturare
//
//--- inp: st_tab_arsp.num_bolla_out e data_bolla_out
//--- out: st_tab_arsp.colli = Numero colli da fatturare; 0=nulla da fatturare
//---        st_esito
//
st_esito kst_esito
st_tab_arsp kst_tab_arsp1
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.num_bolla_out > 0 then
	
	kst_tab_arsp1.stampa = kki_sped_flg_stampa_fatturato

	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE num_bolla_out = :kst_tab_arsp.num_bolla_out and data_bolla_out = :kst_tab_arsp.data_bolla_out
					and stampa <> :kst_tab_arsp1.stampa 
				  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore tab. d.d.t., Sped. nr. " + string( kst_tab_arsp.num_bolla_out) + " del " + string( kst_tab_arsp.data_bolla_out) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return kst_esito



end function

public function st_esito set_sped_fatturata (st_tab_sped kst_tab_sped);//
//====================================================================
//=== Imposta a Fatturata la Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped.num_bolla_out e data_bolla_out
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_sped.stampa = kki_sped_flg_stampa_fatturato
	UPDATE sped  
		  SET stampa = :kst_tab_sped.stampa  
		  			,x_datins = :kst_tab_sped.x_datins
			  		,x_utente = :kst_tab_sped.x_utente
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. d.d.t. ~n~r" &
					+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito reset_riga_fatturata (st_tab_arsp kst_tab_arsp);//
//====================================================================
//=== Resetta Impostazione a Fatturata della Riga Bolla di spedizione
//=== 
//=== Se necessario re-imposta l'intera Spedizione 
//=== 
//=== Input: st_arsp.id_arsp
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_tab_sped kst_tab_sped
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
if kst_tab_arsp.id_arsp > 0 then
	
	kst_esito = get_numero_da_id(kst_tab_arsp )
	if kst_esito.esito = kkg_esito.ok or  kst_esito.esito = kkg_esito.db_wrn then
			
		
		kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_stampata
		UPDATE arsp  
			  SET stampa = :kst_tab_arsp.stampa  
			WHERE arsp.id_arsp = :kst_tab_arsp.id_arsp   
			using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiorn. riga d.d.t. ~n~r" &
						+ " (riga=" + string(kst_tab_arsp.id_arsp, "####0") + ") Sped. nr. " &
						+ string(kst_tab_arsp.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		else
			
//--- se non ci sono più colli da fatt x la sped allora aggioro anche la testata dellla SPEDIZIONE 
			kst_esito = get_colli_fatt( kst_tab_arsp ) 
			if kst_esito.esito = kkg_esito.ok then
				if kst_tab_arsp.colli = 0 then 
					kst_tab_sped.num_bolla_out = kst_tab_arsp.num_bolla_out
					kst_tab_sped.data_bolla_out = kst_tab_arsp.data_bolla_out
					kst_tab_sped.st_tab_g_0.esegui_commit = kst_tab_arsp.st_tab_g_0.esegui_commit
					
					kst_esito = reset_sped_fatturata( kst_tab_sped )
					
				end if
			end if
			
		end if
	
//---- COMMIT o ROLLBACK....	
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		end if
	
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe d.d.t., Manca il nr. riga (id_arsp) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito get_colli_fatt (ref st_tab_arsp kst_tab_arsp);//
//--- Calcola colli di bolla gia' fatturati
//
//--- inp: st_tab_arsp.num_bolla_out e data_bolla_out
//--- out: st_tab_arsp.colli = Numero colli fatturati; 0=nulla da fatturare
//---        st_esito
//
st_esito kst_esito
uo_exception kuo_exception
st_tab_arsp kst_tab_arsp1

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.num_bolla_out > 0 then
	
	kst_tab_arsp1.stampa = kki_sped_flg_stampa_fatturato
	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE num_bolla_out = :kst_tab_arsp.num_bolla_out and data_bolla_out = :kst_tab_arsp.data_bolla_out
					and stampa = :kst_tab_arsp1.stampa
				  using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore tab. d.d.t., Sped. nr. " + string( kst_tab_arsp.num_bolla_out) + " del " + string( kst_tab_arsp.data_bolla_out) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return kst_esito



end function

public function st_esito reset_sped_fatturata (st_tab_sped kst_tab_sped);//
//====================================================================
//=== Re-Imposta a Stampata invece di Fatturata la Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped.num_bolla_out e data_bolla_out
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then

	kst_tab_sped.stampa = kki_sped_flg_stampa_bolla_stampata
	UPDATE sped  
		  SET stampa = :kst_tab_sped.stampa 
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. d.d.t. ~n~r" &
					+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito set_arsp_fatturata_reset (st_tab_arsp kst_tab_arsp);//
//====================================================================
//=== Rimette a STAMPATA la riga Bolla  Fatturata 
//===  e di coseguenza anche la Bolla Intera
//=== 
//=== Input: st_sped.num_bolla_out e data_bolla_out, id_armo 
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_arsp.num_bolla_out > 0 then

	kst_tab_arsp.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_stampata
	UPDATE arsp
		  SET stampa = :kst_tab_arsp.stampa  
		  			,x_datins = :kst_tab_arsp.x_datins
			  		,x_utente = :kst_tab_arsp.x_utente
			WHERE num_bolla_out = :kst_tab_arsp.num_bolla_out
					and data_bolla_out = :kst_tab_arsp.data_bolla_out
					and id_armo = :kst_tab_arsp.id_armo
		using sqlca;

	if sqlca.sqlcode >= 0 then

		kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_stampata
		UPDATE sped  
			  SET stampa = :kst_tab_arsp.stampa  
		  			,x_datins = :kst_tab_arsp.x_datins
			  		,x_utente = :kst_tab_arsp.x_utente
			WHERE sped.num_bolla_out = :kst_tab_arsp.num_bolla_out
						and data_bolla_out = :kst_tab_arsp.data_bolla_out
			using sqlca;
			
	end if
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. d.d.t. ~n~r" &
					+ string(kst_tab_arsp.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito get_ultimo_doc (ref st_tab_sped kst_tab_sped);//
//====================================================================
//=== Torna l'ultima Spedizione (Numero e Data) della Anagrafica se impostata 
//=== 
//=== Input : kst_tab_sped.clie_2
//=== Out: kst_tab_sped.num_bolla_out + data_bolla_out + id_sped
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_sped.clie_2 > 0 then
		
		select	max(num_bolla_out)
				  ,data_bolla_out
			into :kst_tab_sped.num_bolla_out
				,:kst_tab_sped.data_bolla_out
			from sped  
			where clie_2 = :kst_tab_sped.clie_2 
					and data_bolla_out in (
						select  max(data_bolla_out)
							from sped  
							where clie_2 = :kst_tab_sped.clie_2 )
			group by 2
			using kguo_sqlca_db_magazzino;
			
	else
		
		select	max(num_bolla_out)
				  ,data_bolla_out
			into :kst_tab_sped.num_bolla_out
				,:kst_tab_sped.data_bolla_out
			from sped  
			where data_bolla_out in (
						select  max(data_bolla_out)
							from sped  
							)
			group by 2
			using kguo_sqlca_db_magazzino;
			
	end if			
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_sped.num_bolla_out = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function st_esito anteprima_righe (datastore kdw_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco arsp x num+data sped)
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_arsp_l_sped"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sped.data_bolla_out, kst_tab_sped.num_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function integer u_tree_open (string k_modalita, st_tab_sped kst_tab_sped[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0
st_esito kst_esito
st_open_w kst_open_w


if upperbound(kst_tab_sped) > 0 then

	choose case k_modalita  

		case kkg_flag_modalita.anteprima

			if kst_tab_sped[1].num_bolla_out > 0 then
				kst_esito = anteprima ( kdw_anteprima, kst_tab_sped[1])
				if kst_esito.esito = kkg_esito.db_ko then
					k_return = 1
					kguo_exception.set_esito( kst_esito )
				// setmessage( "Accesso al Documento di Vendita non disponibile. ")
					kguo_exception.messaggio_utente( )
				end if
			end if

				
		case else

			kst_open_w.flag_modalita = k_modalita			
			if not this.u_open( kst_tab_sped[], kst_open_w ) then  //Apre le Varie Funzioni
				k_return = 1
				if k_modalita = kkg_flag_modalita.modifica or k_modalita = kkg_flag_modalita.inserimento then
					kguo_exception.setmessage( "Operazione di Accesso al Documento di Spedizione fallita. ")
					kguo_exception.messaggio_utente( )
				end if
			end if
				
				
				
	end choose		


end if	
 
 
return k_return

end function

public function boolean u_open (st_tab_sped kst_tab_sped[], st_open_w kst_open_w);//
//--- Chiama la giusta Funzionalità
//---
//--- Input: st_tab_spec con num e data _bolla_out valorizzati se serve,  st_open_w.flag_modalita = tipo funzione da richiamare
//---
//
boolean  k_return = true
integer k_ind
st_esito kst_esito


	k_ind=1 

	choose case kst_open_w.flag_modalita  

////			case kkg_flag_modalita.anteprima
////
////				if kst_tab_sped[k_ind].num_bolla_out > 0 then
////					kst_esito = this.anteprima ( kds_1, kst_tab_sped[k_ind])
////				end if
			
		case kkg_flag_modalita.stampa
			k_return = this.u_open_stampa(kst_tab_sped[])		
			
		case kkg_flag_modalita.cancellazione
			k_return = this.u_open_cancellazione(kst_tab_sped[k_ind])
			
		case kkg_flag_modalita.modifica
			k_return = this.u_open_modifica(kst_tab_sped[k_ind])
			
		case kkg_flag_modalita.inserimento
			k_return = this.u_open_inserimento(kst_tab_sped[k_ind])
			
		case kkg_flag_modalita.visualizzazione
			k_return = this.u_open_visualizza(kst_tab_sped[k_ind])
			
		case else
				
				
	end choose		
 
return k_return

end function

public function boolean u_open_cancellazione (ref st_tab_sped kst_tab_sped);//---
//--- Apre la Window x CANCELLAZIONE Fattura 
//---
//--- Input: st_tab_arfa.num_bolla_out e data_bolla_out
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---


boolean k_return = false
st_esito kst_esito 
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


if kst_esito.esito = kkg_esito.ok and kst_tab_sped.num_bolla_out > 0 then
	
	k_return = true
	kst_tab_sped.clie_3 = 0
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = trim(string(kst_tab_sped.num_bolla_out)) 
	kst_open_w.key2 = trim(string(kst_tab_sped.data_bolla_out)) 
	kst_open_w.key3 = " " 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if


return k_return



return k_return


end function

public function boolean u_open_inserimento (ref st_tab_sped kst_tab_sped);//---
//--- Apre Window x inserimento Fattura
//---
//---
//---

boolean k_return = true
//
long k_riga=0
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


kst_tab_sped.num_bolla_out =0
kst_tab_sped.data_bolla_out = kg_dataoggi
//
	

//if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = trim(string(kst_tab_sped.num_bolla_out)) 
	kst_open_w.key2 = trim(string(kst_tab_sped.data_bolla_out)) 
	kst_open_w.key3 = " " 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if


return k_return


end function

public function boolean u_open_modifica (ref st_tab_sped kst_tab_sped);//---
//--- Apre la Window x Modifica Sped 
//---
//--- Input: st_tab_arfa.id_fattra
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito 
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_sped.num_bolla_out > 0 then
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = trim(string(kst_tab_sped.id_sped)) //trim(string(kst_tab_sped.num_bolla_out)) 
	kst_open_w.key2 = "" //trim(string(kst_tab_sped.data_bolla_out)) 
	kst_open_w.key3 = " " 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function boolean u_open_visualizza (ref st_tab_sped kst_tab_sped);//---
//--- Apre la Window x Visualizzazione Sped 
//---
//--- Input: st_tab_arfa.id_fattra
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---

boolean k_return = false
st_esito kst_esito
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



if kst_tab_sped.num_bolla_out > 0 then
	
	
	k_return = true
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = trim(string(kst_tab_sped.num_bolla_out)) 
	kst_open_w.key2 = trim(string(kst_tab_sped.data_bolla_out))
	kst_open_w.key3 = " " 
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window


end if


return k_return


end function

public function st_esito get_id_riga_da_id_armo (ref st_tab_arsp kst_tab_arsp);//
//--- Piglia il id_arsp spedizione da id_armo
//--- nell'ipotesi di più righe (ma non dovrebbe capitare) piglio la più recente
//---
//--- inp: st_tab_arsp.id_armo
//--- out: st_tab_arsp.id_arsp
//--- ritorna: st_esito   
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

SELECT max (id_arsp)
    INTO :kst_tab_arsp.id_arsp 
    FROM arsp  
   WHERE ( id_armo = :kst_tab_arsp.id_armo ) 
           using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., riga bolla di sped. (id_armo=" + string( kst_tab_arsp.id_armo) + "): ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		if kst_tab_arsp.id_arsp = 0 then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Errore tab. d.d.t., riga bolla di sped. (id_armo=" + string( kst_tab_arsp.id_armo) + ") " 
			kst_esito.esito = kkg_esito.not_fnd
		end if
	end if
	
return kst_esito



end function

public function st_esito set_sped_stampata (st_tab_sped kst_tab_sped);//
//====================================================================
//=== Imposta a Stampata la Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped.num_bolla_out e data_bolla_out 
//===           + data_rit e ora_rit 
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_sped.stampa = kki_sped_flg_stampa_bolla_stampata
	UPDATE sped  
		  SET stampa = :kst_tab_sped.stampa
			,data_rit = :kst_tab_sped.data_rit
			,ora_rit =  :kst_tab_sped.ora_rit
			,x_datins = :kst_tab_sped.x_datins
			,x_utente = :kst_tab_sped.x_utente
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. d.d.t. a stampato ~n~r" &
					+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function st_esito set_righe_stampata (st_tab_arsp kst_tab_arsp);//
//====================================================================
//=== Imposta a Stampata tutte le Righe della Bolla di spedizione
//=== 
//=== 
//=== Input: st_arsp.num_bolla_out / data_bolla_out
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
	
if kst_tab_arsp.num_bolla_out > 0 then

	kst_tab_arsp.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_stampata
	UPDATE arsp
		  SET stampa = :kst_tab_arsp.stampa
		  			,x_datins = :kst_tab_arsp.x_datins
			  		,x_utente = :kst_tab_arsp.x_utente
		WHERE num_bolla_out = :kst_tab_arsp.num_bolla_out
					and data_bolla_out = :kst_tab_arsp.data_bolla_out
		using sqlca;
	
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante aggiorn. righe d.d.t. in stampa~n~r" &
						+ "Sped. nr. " &
						+ string(kst_tab_arsp.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_arsp.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			
		end if
	
//---- COMMIT o ROLLBACK....	
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe d.d.t., Manca il nr. riga (id_arsp) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function integer get_ddt_da_stampare (ref st_sped_ddt kst_sped_ddt[]) throws uo_exception;//
//--- Cerca i documenti non ancora Stampati (vedi il flag di "STAMPA")
//--- input:  datastore ds_fatture con l'elenco delle fatture da aggiornare
//--- out: numero fatture aggiornate
//---
int k_ctr=0
long k_riga_ddt=0
date k_data_meno6mesi, k_dataoggi
//string k_dataoggix
st_tab_sped kst_tab_sped
st_esito kst_esito 
uo_exception kuo_exception
//kuf_base kuf1_base




	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_tab_sped.stampa = kki_sped_flg_stampa_bolla_da_stamp
  	declare  c_get_ddt_da_stampare  cursor for
	         SELECT distinct
				id_sped,
				num_bolla_out,   
				data_bolla_out 
				FROM arsp 
				 where  (data_bolla_out > :k_data_meno6mesi 
						 and (stampa is null or stampa = :kst_tab_sped.stampa)) 
				 group by 
				 id_sped
				,data_bolla_out 
				,num_bolla_out  
				using sqlca;
	

//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
	
//--- data oggi -6 mesi
	k_data_meno6mesi = relativedate(kg_dataoggi, -185)
	
	
	open c_get_ddt_da_stampare;

	if sqlca.sqlcode = 0 then

		k_riga_ddt++
		fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_riga_ddt].kst_tab_sped.ID_SPED
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT;
		
		do while sqlca.sqlcode = 0 

			kst_sped_ddt[k_riga_ddt].sel = 1

			if isnull(kst_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT) then kst_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT = 0
			if isnull(kst_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT) then kst_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT = date(0)
			
			kst_tab_sped.num_bolla_out = kst_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
			kst_tab_sped.data_bolla_out = kst_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT

			k_riga_ddt++
			fetch c_get_ddt_da_stampare 
				into
				:kst_sped_ddt[k_riga_ddt].kst_tab_sped.ID_SPED
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
				,:kst_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT;
				
		loop
	
		close c_get_ddt_da_stampare;
		
	end if
	
//--- 
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
				"Errore durante lettura DDT da stampare ~n~r" &
							+ "Ultimo ddt letto: " + string(kst_tab_sped.NUM_BOLLA_OUT, "####0") + " del " &
							+ string(kst_tab_sped.DATA_BOLLA_OUT, "dd.mm.yyyy") &	
							+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito)
		throw kuo_exception
	end if



return k_riga_ddt

end function

public function st_esito anteprima_1 (datastore kdw_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_sped_1"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
		try
//--- get del id_sped se manca
			if kst_tab_sped.id_sped > 0 then 
			else
				this.get_id_sped(kst_tab_sped)
			end if
			k_rc=kdw_anteprima.retrieve(kst_tab_sped.id_sped)
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_1 (datawindow kdw_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_sped_1"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
		try
//--- get del id_sped se manca
			if kst_tab_sped.id_sped > 0 then 
			else
				this.get_id_sped(kst_tab_sped)
			end if
			k_rc=kdw_anteprima.retrieve(kst_tab_sped.id_sped)
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
//		k_rc=kdw_anteprima.retrieve(kst_tab_sped.data_bolla_out, kst_tab_sped.num_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (datastore kds_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
long k_n_ddt_stampate=0
st_open_w kst_open_w
st_esito kst_esito
st_ddt_stampa kst_ddt_stampa[]
kuf_sped_ddt kuf1_sped_ddt
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
datawindow kdw_nullo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sped.num_bolla_out > 0 then

//--- retrive dell'attestato 
	
		try 

//---- inizializza x stampa fattura
			kuf1_sped_ddt = create kuf_sped_ddt
//			kuf1_sped_ddt.produci_ddt_inizializza(kst_tab_sped)

			kst_ddt_stampa[1].num_bolla_out = kst_tab_sped.num_bolla_out
			kst_ddt_stampa[1].data_bolla_out =  kst_tab_sped.data_bolla_out
			
//--- produce ddt	
			k_n_ddt_stampate = kuf1_sped_ddt.produci_ddt(kst_ddt_stampa[])
		
			if k_n_ddt_stampate > 0 then
				kds_anteprima.dataobject = kuf1_sped_ddt.kids_stampa_ddt.dataobject  //kuf1_sped_ddt.ki_dw_stampa_ddt		
				kds_anteprima.settransobject(sqlca)
		
				kds_anteprima.reset()	

				kuf1_sped_ddt.produci_ddt_set_dw_loghi(kds_anteprima, kdw_nullo)
				kuf1_sped_ddt.kids_stampa_ddt.rowscopy(1,kuf1_sped_ddt.kids_stampa_ddt.rowcount(),Primary!,kds_anteprima,1,Primary!)
			end if
			
		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
//--- distrugge oggetti x stampa ddt
			if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
				
		end try
		

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (datawindow kdw_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
long k_n_ddt_stampate=0
boolean k_return
st_ddt_stampa kst_ddt_stampa[]
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
kuf_sped_ddt kuf1_sped_ddt
datastore kds_nullo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sped.num_bolla_out > 0 then

		try 

				
//---- inizializza x stampa ddt
			kuf1_sped_ddt = create kuf_sped_ddt
//			kuf1_sped_ddt.produci_ddt_inizializza(kst_tab_sped)
			
			kst_ddt_stampa[1].num_bolla_out = kst_tab_sped.num_bolla_out
			kst_ddt_stampa[1].data_bolla_out =  kst_tab_sped.data_bolla_out
			
//--- produci_ddt
			k_n_ddt_stampate = kuf1_sped_ddt.produci_ddt(kst_ddt_stampa[])
		
			if k_n_ddt_stampate > 0 then
				kdw_anteprima.dataobject = kuf1_sped_ddt.kids_stampa_ddt.dataobject  //kuf1_sped_ddt.ki_dw_stampa_ddt		
				kdw_anteprima.settransobject(sqlca)
				kuf1_utility = create kuf_utility
				kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
	
				kdw_anteprima.reset()	

				kuf1_sped_ddt.produci_ddt_set_dw_loghi(kds_nullo, kdw_anteprima)
				kuf1_sped_ddt.kids_stampa_ddt.rowscopy(1,kuf1_sped_ddt.kids_stampa_ddt.rowcount(),Primary!,kdw_anteprima,1,Primary!)
				kGuf_data_base.dw_copia_attributi_generici(kuf1_sped_ddt.kids_stampa_ddt, kdw_anteprima)
			end if
			
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()

		finally
//--- distrugge oggetti x stampa ddt
			if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
			if isvalid(kuf1_utility) then destroy kuf1_utility
				
		end try
		

	else
		
		
		
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_2 (datastore kdw_anteprima, st_tab_sped kst_tab_sped);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Testata Spedizione)
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
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_sped.num_bolla_out > 0 then

		kdw_anteprima.dataobject = "d_sped_wm_l"		
		kdw_anteprima.settransobject(sqlca)

//		kuf1_utility = create kuf_utility
//		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_sped.num_bolla_out, kst_tab_sped.data_bolla_out)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


return kst_esito

end function

public function boolean u_open_stampa (st_tab_sped kst_tab_sped[]);//---
//--- Stampa Sped
//---
//---
boolean k_return = false
long k_riga=0
integer k_ctr, k_max
st_sped_ddt kst_sped_ddt[]
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


try 

	this.if_sicurezza(kkg_flag_modalita.stampa)		
		
//--- Cicla fino a che ci sono righe selezionate
	k_riga=0
	k_max = UpperBound(kst_tab_sped)
	for k_ctr = 1 to k_max
		
		if kst_tab_sped[k_ctr].num_bolla_out > 0 then
			k_riga++
			kst_sped_ddt[k_riga].kst_tab_sped.id_sped = kst_tab_sped[k_ctr].id_sped
			kst_sped_ddt[k_riga].kst_tab_sped.num_bolla_out = kst_tab_sped[k_ctr].num_bolla_out
			kst_sped_ddt[k_riga].kst_tab_sped.data_bolla_out = kst_tab_sped[k_ctr].data_bolla_out
			kst_sped_ddt[k_riga].sel = 1
				
		end if								
	next

	if k_riga > 0 then	

		//=== Parametri : 
		//=== struttura st_open_w
		//=== dati particolare programma
		//
		//=== Si potrebbero passare:
		//=== key=codice prodotto;
		kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa)
		Kst_open_w.flag_primo_giro = "S"
		Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		Kst_open_w.flag_leggi_dw = "N"
		kst_open_w.key12_any = kst_sped_ddt[]   // struttura
		kst_open_w.flag_where = " "
		
			
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	
		k_return = true
		
	end if
	
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
	
finally
//	if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
	
end try


return k_return



end function

public function st_esito get_sped_stampa (ref st_tab_sped kst_tab_sped);//
//====================================================================
//=== Get del flag Stampa dalla Bolla di spedizione
//=== 
//=== 
//=== Input: st_sped.num_bolla_out e data_bolla_out 
//===           + data_rit e ora_rit 
//=== Out: ST_ESITO
//===           		
//=== 
//====================================================================
//
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then

	select distinct stampa 
			into :kst_tab_sped.stampa
			from sped  
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;

	if sqlca.sqlcode = 0 then
		
//--- se flag è nullo lo imposto a DA_STAMPARE		
		if isnull(kst_tab_sped.stampa) or len(trim(kst_tab_sped.stampa)) = 0 then
			kst_tab_sped.stampa = kki_sped_flg_stampa_bolla_da_stamp
		end if
		
	else
		
		kst_tab_sped.stampa = ""
		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura d.d.t. (flag stampa) ~n~r" &
						+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return kst_esito

end function

public function integer get_sped_camion_caricato (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//--- Check se Spedizione Caricata su camion con il WM (con num e data bolla)
//
//--- inp: st_tab_sped.num_bolla_out / data_bolla_out
//--- out: 1=caricato su camion
//--- 		0=non pronto, materiale da caricare su camion 
//--- 		-1=non tovato come Packinglist, probabilemnete non gestito in WM
//--- Lancia uo_exception
//
//
int k_return=0
int k_rc=0
datastore kds_1
st_esito kst_esito
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kds_1 = create datastore

	if kst_tab_sped.num_bolla_out > 0 then
	
	//--- controlla la presenza del PackingList x questa entrata
		kds_1.dataobject = "d_sped_wm_presente"
		kds_1.settransobject(sqlca)
		k_rc = kds_1.retrieve(kst_tab_sped.num_bolla_out, kst_tab_sped.data_bolla_out )
		if k_rc >= 0 then
			if kds_1.rowcount( ) > 0 then
			
	
	//--- Controlla numero colli messi sul camion
				kds_1.dataobject = "d_sped_wm_camion_caricato"	
				kds_1.settransobject(sqlca)
				
				k_rc = kds_1.retrieve(kst_tab_sped.num_bolla_out, kst_tab_sped.data_bolla_out )
				
				if k_rc >= 0 then
					if kds_1.rowcount( ) > 0 then
						
						if kds_1.object.k_colli_arsp >= kds_1.object.k_colli_wm_pklist_righe then
					
							k_return = kki_sped_camion_caricato_SI // Tutto OK!!!!
						else
							k_return = kki_sped_camion_caricato_NO // ancora merce da caricare sul camion
						end if
					end if
				end if
			else
				k_return = kki_sped_camion_caricato_NON_GESTITO // non ho trovato il PK probabilmente è roba non gestita con il WM
			end if
		end if
				
	//--- se si era verificato un errore.... 			
		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Errore lettura colli WM (wm_pklist_righe). Num bolla di sped. " + string(kst_tab_sped.num_bolla_out) + ": ~n~r" &
							+ "dati in lettura da: " + kds_1.dataobject 
			kst_esito.esito = kkg_esito.db_ko
				
			kst_esito.esito = kkg_esito.db_ko
			kuo_exception = create uo_exception 
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
				
		end if
		
		
	end if
	

finally
	destroy kds_1

end try 

return k_return



end function

public function boolean set_id_docprod (st_tab_sped kst_tab_sped) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a ID del Documento Esportato in Tabella SPED
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped  e  id_docprod
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
	
	
if kst_tab_sped.id_sped > 0 then

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE SPED  
		  SET id_docprod = :kst_tab_sped.id_docprod
			,x_datins = :kst_tab_sped.x_datins
			,x_utente = :kst_tab_sped.x_utente
		WHERE sped.id_sped = :kst_tab_sped.id_sped
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documento Emesso' sul DDT (sped). ~n~r" &
					+ "Id: " + string(kst_tab_sped.id_sped, "####0") + "  " &
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. DDT, Manca Identificativo (id_sped) !" 
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

public function long aggiorna_docprod (ref st_tab_sped kst_tab_sped[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_sped con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_ddt=0, k_nr_ddt=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_arsp kst_tab_arsp
kuf_docprod kuf1_docprod
kuf_armo kuf1_armo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_ddt = upperbound(kst_tab_sped[])

	if k_nr_ddt > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		kuf1_armo = create kuf_armo
		
		for k_riga_ddt = 1 to k_nr_ddt

			try

				if kst_tab_sped[k_riga_ddt].id_sped > 0 then
	
					kst_tab_docprod.doc_num = kst_tab_sped[k_riga_ddt].num_bolla_out
					kst_tab_docprod.doc_data = kst_tab_sped[k_riga_ddt].data_bolla_out 
					kst_tab_docprod.id_doc = kst_tab_sped[k_riga_ddt].id_sped
					
//--- Recupera id_armo
					kst_tab_arsp.id_sped = kst_tab_sped[k_riga_ddt].id_sped
					get_id_armo_max(kst_tab_arsp)  // piglia id del dettaglio lotto
					if kst_tab_arsp.id_armo > 0 then
						kst_tab_armo.id_armo =  kst_tab_arsp.id_armo
						kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo) // piglia id del lotto
						if kst_esito.esito = kkg_esito.db_ko then
							if isvalid(kuf1_docprod) then destroy kuf1_docprod
							if isvalid(kuf1_armo) then destroy kuf1_armo
							kguo_exception.inizializza( )
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
						if kst_tab_armo.id_meca > 0 then
//--- Recupera il codice CLIENTE fatturato
							kst_tab_meca.id = kst_tab_armo.id_meca
							kuf1_armo.get_clie_listino(kst_tab_meca)
						else
							kst_tab_meca.clie_3 = 0  //--- se c'e' qlc Anomalia parcheggio sul cliente ZERO!							
						end if
					else
						kst_tab_meca.clie_3 = 0  //--- se c'e' qlc Anomalia parcheggio sul cliente ZERO!							
					end if
					kst_tab_docprod.id_cliente = kst_tab_meca.clie_3

//--- Recupera il codice CLIENTE fatturato dal DDT
//					kst_esito = get_clie(kst_tab_sped[k_riga_ddt])
//					if kst_esito.esito = kkg_esito.db_ko then
//						if isvalid(kuf1_docprod) then destroy kuf1_docprod
//						if isvalid(kuf1_armo) then destroy kuf1_armo
//						kguo_exception.inizializza( )
//						kguo_exception.set_esito(kst_esito)
//						throw kguo_exception
//					end if
//					kst_tab_docprod.id_cliente = kst_tab_sped[k_riga_ddt].clie_3
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_sped[1].st_tab_g_0.esegui_commit
	
					kuf1_docprod.tb_add_ddt ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
					k_nr_doc++
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
		if isvalid(kuf1_armo) then destroy kuf1_armo
	
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function boolean if_esiste (st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza DDT da id_sped
//--- 
//--- 
//--- Inp: st_tab_sped.id
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero spedicato			
	SELECT count(*)
			into :k_trovato
			 FROM sped  
			 where  id_sped  = :kst_tab_sped.id_sped
			 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura DDT (sped) id = " + string(kst_tab_sped.id_sped) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public function boolean get_id_armo_max (ref st_tab_arsp kst_tab_arsp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_armo piu' alto contenuto in un DDT (da ID di spedizione)
//--- 
//--- 
//--- Inp: st_tab_arsp.id_sped
//--- Out: st_tab_arsp.id_armo
//---
//--- Ritorna: TRUE = ok
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_arsp.id_sped > 0 then
		
		SELECT max(id_armo)
		 INTO 
		  	:kst_tab_arsp.id_armo
	 	FROM arsp  
		WHERE  id_sped = :kst_tab_arsp.id_sped 
			  using sqlca;
	
	end if

	if isnull(kst_tab_arsp.id_armo) then kst_tab_arsp.id_armo = 0
	
	if sqlca.sqlcode = 0 then
		if kst_tab_arsp.id_armo > 0 then k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante in ID movim. di entrata nel ddt di sped., id sped.=" + string(kst_tab_arsp.id_sped) +" ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_bolla_out, k_data_da, k_data_a, k_dataoggi, k_data_meno365
string k_dataoggix
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_sped kst_tab_sped
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any, kst_treeview_data_any_save



declare kc_treeview cursor for
	SELECT 
         sum (arsp.colli), 
         month(arsp.data_bolla_out) as mese,   
         year(arsp.data_bolla_out) as anno   
     FROM arsp
    WHERE 
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.sped_anno_mese
		  and data_bolla_out between :k_data_da and :k_data_a)
		 or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.sped_stor_mese
		  and data_bolla_out < :k_data_da )
		 group by  month(arsp.data_bolla_out), year(arsp.data_bolla_out)
		 order by  3 desc, 2 desc; 




		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle
	kst_treeview_data_any = kst_treeview_data.struttura

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
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
		end if



//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		

//--- ricavo data oggi
		k_dataoggi = kg_dataoggi
//--- calcolo periodo
		k_anno = year(k_dataoggi) - 1
		k_mese = month(k_dataoggi)
		k_data_da = date (k_anno, k_mese, 01) 
		k_data_a = k_dataoggi 

		k_data_meno365 = relativedate(k_dataoggi, -365)
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[ult-settimana]"
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

						kst_treeview_data_any_save = kst_treeview_data_any
						k_mese_desc[0] = "[riep-Anno]"
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  colli usciti nell'anno"
						k_totale = 0
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data_any = kst_treeview_data_any_save
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Spedizioni " 
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_sped = kst_tab_sped
					kst_treeview_data_any.st_tab_sped.data_bolla_out = date(0)
					kst_treeview_data_any.st_tab_sped.num_bolla_out = k_anno
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
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_sped.data_bolla_out = date(k_anno,01,01)
				else			
					kst_tab_sped.data_bolla_out = date(k_anno,k_mese,01)
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  collo uscito"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  colli usciti"
				end if

				kst_tab_treeview.descrizione_tipo = "Spedizioni " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_sped = kst_tab_sped
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

//	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

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
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  colli usciti"
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

public function long get_colli_x_id_armo (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Trova colli spediti x id_armo
//---
//--- inp: st_tab_arsp.id_armo 
//--- out: 
//--- Rit: Numero colli
//---
//--- lancia EXCEPTION
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_armo > 0 then
	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE id_armo = :kst_tab_arsp.id_armo
		using kguo_sqlca_db_magazzino ;
				  
	if sqlca.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura numero colli x riga lotto. Tab righe ddt, id riga lotto: " + string( kst_tab_arsp.id_armo) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe ddt. Manca id Riga Lotto (Riferimento) !" 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if	
	
if isnull(kst_tab_arsp.colli) then kst_tab_arsp.colli = 0
	
 
return  kst_tab_arsp.colli   	



end function

public function long get_colli_x_id_armo_data (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Trova colli spediti fino ad una certa data_bolla_out (ESCLUSA) x id_armo 
//---
//--- inp: st_tab_arsp.id_armo / data_b
//--- out: 
//--- Rit: Numero colli
//---
//--- lancia EXCEPTION
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_armo > 0 then
	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE id_armo = :kst_tab_arsp.id_armo
				and data_bolla_out < :kst_tab_arsp.data_bolla_out 
		using kguo_sqlca_db_magazzino ;
				  
	if sqlca.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura numero colli x riga lotto. Tab righe ddt, id riga lotto: " + string( kst_tab_arsp.id_armo) + " ~n~r" + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. righe ddt. Manca id Riga Lotto (Riferimento) !" 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if	
	
if isnull(kst_tab_arsp.colli) then kst_tab_arsp.colli = 0
	
 
return  kst_tab_arsp.colli   	



end function

public function st_esito get_righe_da_fatt (ref st_tab_arsp kst_tab_arsp[]);//
//--- Leggo Righe Bolla di spedizione stampate da fatturare
//--- Input: st_tab_sped[1].id_sped  //num_bolla_out, data_bolla_out
//--- Out: st_tab_sped[] con le righe trovate, ST_ESITO
//
int k_ind
st_tab_arsp kst_tab_arsp_app, kst_tab_arsp_null[] 
st_esito kst_esito

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_arsp_app.stampa = kki_sped_flg_stampa_bolla_stampata  // flag di stampate ma non fatturate
	kst_tab_arsp_app.id_sped = kst_tab_arsp[1].id_sped
//	kst_tab_arsp_app.data_bolla_out = kst_tab_arsp[1].data_bolla_out

//--- inizializza la ARRAY da restituire
	kst_tab_arsp[] = kst_tab_arsp_null[] 
		

	 DECLARE c_get_righe_arsp CURSOR FOR  
		  SELECT arsp.id_sped,
		             arsp.id_arsp,   
					arsp.id_armo,   
					arsp.colli,   
					arsp.colli_out  
					,arsp.num_bolla_out
					,arsp.data_bolla_out
			 FROM arsp
			 WHERE arsp.id_sped = :kst_tab_arsp_app.id_sped 
			       and  arsp.stampa = :kst_tab_arsp_app.stampa;
			 
//			 ( num_bolla_out = :kst_tab_arsp_app.num_bolla_out ) AND  
//       				  ( data_bolla_out = :kst_tab_arsp_app.data_bolla_out)   

	open  c_get_righe_arsp;
	if sqlca.sqlcode = 0 then

		k_ind=1
		fetch c_get_righe_arsp into 
						:kst_tab_arsp[k_ind].id_sped
						,:kst_tab_arsp[k_ind].id_arsp
						,:kst_tab_arsp[k_ind].id_armo
						,:kst_tab_arsp[k_ind].colli
						,:kst_tab_arsp[k_ind].colli_out
						,:kst_tab_arsp[k_ind].num_bolla_out
						,:kst_tab_arsp[k_ind].data_bolla_out;
		
		do while sqlca.sqlcode = 0
			
			k_ind ++
			fetch c_get_righe_arsp into 
						:kst_tab_arsp[k_ind].id_sped
						,:kst_tab_arsp[k_ind].id_arsp
						,:kst_tab_arsp[k_ind].id_armo
						,:kst_tab_arsp[k_ind].colli
						,:kst_tab_arsp[k_ind].colli_out
						,:kst_tab_arsp[k_ind].num_bolla_out
						,:kst_tab_arsp[k_ind].data_bolla_out;
						
		loop

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.d.d.t., Righe bolla stampate (numero=" + string( kst_tab_arsp_app.num_bolla_out) + " del "+ string( kst_tab_arsp_app.data_bolla_out)+") : " &
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

		close c_get_righe_arsp;
	
	end if
		
return kst_esito


end function

public function st_esito get_numero_da_id (ref st_tab_sped ast_tab_sped);//
//--- Piglia il NUMERO e DATA spedizione da id_arsp
//
//--- inp: st_tab_arsp.id_arsp
//--- out: st_esito
//
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

SELECT distinct sped.num_bolla_out
  			,sped.data_bolla_out   
    INTO :ast_tab_sped.num_bolla_out,   
         :ast_tab_sped.data_bolla_out  
    FROM sped  
   WHERE ( id_sped = :ast_tab_sped.id_sped ) 
           using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore tab. d.d.t., Bolla di Sped. (id=" + string( ast_tab_sped.id_sped) + "): ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	
return kst_esito



end function

public function boolean get_id_sped_anno (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped da numero + anno di data bolla
//--- 
//--- 
//--- Inp: kst_tab_sped.num_bolla_out/data_bolla_out (anno)
//--- Out: kst_tab_sped.id_sped
//---
//--- Ritorna: TRUE = ok
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
integer k_anno

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped.data_bolla_out)
		
		SELECT id_sped
		 INTO 
		  	:kst_tab_sped.id_sped
	 	FROM sped  
		WHERE ( num_bolla_out = :kst_tab_sped.num_bolla_out ) AND  
						year(data_bolla_out) = :k_anno
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped.id_sped > 0 then k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID del ddt di sped., numero/anno=" + string( kst_tab_sped.num_bolla_out) + " / "+ string( kst_tab_sped.data_bolla_out, "yyyy" )+" ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public subroutine elenco_note (st_tab_sped kst_tab_sped);//
//--- Fa l'elenco delle NOTE caricate in documenti precedenti
//
st_open_w kst_open_w
string k_nome
kuf_elenco kuf1_elenco
datastore kds_1
pointer kp_oldpointer  // Declares a pointer variable


kp_oldpointer = SetPointer(HourGlass!)

	
	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = kki_dw_elenco_note
	kds_1.settransobject(sqlca) 
	
	if kst_tab_sped.clie_2 > 0 then
		
		kst_tab_sped.data_bolla_out = relativedate(kG_dataoggi, -180)
		
		kds_1.retrieve( kst_tab_sped.clie_2,  kst_tab_sped.data_bolla_out)
	
		if kds_1.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma =kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Note ddt per il Ricevente: " + string( kst_tab_sped.clie_2 ) + " dal " + string(kst_tab_sped.data_bolla_out) //+ " " + trim(k_nome)
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kds_1
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		
		else
			messagebox("Elenco Note", "Nessun valore disponibile per il Ricevente: " + string( kst_tab_sped.clie_2 ) + " dal " + string(kst_tab_sped.data_bolla_out))
			
		end if
	end if
						
SetPointer(kp_oldpointer)

	



		
		
		


end subroutine

public subroutine elenco_indirizzi_ddt (st_tab_sped kst_tab_sped);//
//--- Fa l'elenco Indirizzi di spedizione 
//
st_open_w kst_open_w
kuf_elenco kuf1_elenco
long k_clie_2


SetPointer(kkg.pointer_attesa)


	if kst_tab_sped.clie_2 > 0 then
	
		k_clie_2 = u_get_clie_ds_dw_elenco_indirizzi()
	
		if kst_tab_sped.clie_2  <> k_clie_2 then
			kdsi_dw_elenco_indirizzi.retrieve(kst_tab_sped.clie_2)
		end if
		
		if kdsi_dw_elenco_indirizzi.rowcount() > 0 then
		
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kuf1_elenco = create kuf_elenco
			kst_open_w.id_programma =kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key1 = "Elenco Indirizzi per il Ricevente: " + string( kst_tab_sped.clie_2 ) 
			kst_open_w.key2 = trim(kdsi_dw_elenco_indirizzi.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_dw_elenco_indirizzi
			kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
			kuf1_elenco.u_open(kst_open_w)
		
		else
			messagebox("Elenco Indirizzi", "Nessun valore disponibile per il Ricevente: " + string( kst_tab_sped.clie_2 ))
		end if
	end if
						
SetPointer(kkg.pointer_default)

	



		
		
		


end subroutine

public function boolean if_cancella (st_tab_sped ast_tab_sped) throws uo_exception;//--
//---  Consentire a la cancellazione del Documento? 
//---
//---  input: st_tab_sped.id_sped
//---  otput: boolean   TRUE = utente autorizzato
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
kuf_fatt kuf1_fatt
st_tab_arfa kst_tab_arfa


try 

	
//--- autorizzato alla cancellazione?
	if not if_sicurezza(kkg_flag_modalita.cancellazione) then 
		throw kguo_exception
	end if

//--- get del numero e data bolla
	if ast_tab_sped.num_bolla_out > 0 then
	else
		get_numero_da_id(ast_tab_sped)
	end if
	
//--- controllo se ddt fatturato
	kuf1_fatt = create kuf_fatt
	kst_tab_arfa.num_bolla_out = ast_tab_sped.num_bolla_out
	kst_tab_arfa.data_bolla_out = ast_tab_sped.data_bolla_out
	if kuf1_fatt.if_ddt_fatturato(kst_tab_arfa) then
		kuf1_fatt.get_numero_da_id(kst_tab_arfa)
		kguo_exception.inizializza()
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
		kguo_exception.setmessage(  &
		"Attenzione, il DDT e' ga' in Fattura n. " + string(kst_tab_arfa.num_fatt) + " del " + string(kst_tab_arfa.data_fatt) + " ~n~r" + &
		"(ID Documento cercato:" + string(ast_tab_sped.id_sped) + ") " )
		throw kguo_exception
	end if

////--- controlla se lotto chiuso
//	if if_chiuso(ast_tab_sped) then
//		if if_modifica_chiuso() then
//			kguo_exception.inizializza()
//			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_wrn )
//			kguo_exception.setmessage(  &
//			"Attenzione, il Documento e' ga' Consolidato. Utente Autorizzato alla Cancellazione. ~n~r" + &
//			"(ID Documento cercato:" + string(ast_tab_sped.id_sped) + ") " )
//		else
//			kguo_exception.inizializza()
//			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_noaut )
//			kguo_exception.setmessage(  &
//			"Mi spiace, il Documento e' ga' Consolidato. Utente non autorizzato alla Cancellazione. ~n~r" + &
//			"(ID Documento cercato:" + string(ast_tab_sped.id_sped) + ") " )
//			throw kguo_exception
//		end if
//	end if

	k_return = true
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try



return k_return

end function

public function long get_colli_sped (ref st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Torna colli spediti x id_armo 
//
//--- inp: st_tab_arsp.id_armo
//--- out: colli = Numero colli spediti; 0=nessuno
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_armo > 0 then
	
	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE id_armo = :kst_tab_arsp.id_armo
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per riga lotto id " + string( kst_tab_arsp.id_armo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp.colli > 0 then
			k_return = kst_tab_arsp.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function boolean if_modifica (st_tab_sped ast_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT è modificabile x id_sped
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped
//--- Out: TRUE = si è possibile fare modifiche
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
datastore kds_arsp_nochiuso
st_esito kst_esito
st_tab_sped kst_tab_sped


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

kds_arsp_nochiuso = create datastore
kds_arsp_nochiuso.dataobject = "ds_arsp_chiuso_x_id_sped"
kds_arsp_nochiuso.settransobject(kguo_sqlca_db_magazzino)

//--- se torna anche solo una riga vuol dire che c'e' almeno un lotto chiuso nel ddt!!!
k_trovato = kds_arsp_nochiuso.retrieve(kst_tab_sped.id_sped)
if k_trovato = 0 then
	k_return = true
else
	if k_trovato < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante verifica se DDT ha lotti chiusi (sped) id = " + string(ast_tab_sped.id_sped) 
		kst_esito.esito = KKG_ESITO.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
end if
		

return k_return



end function

public function boolean tb_update_numero_data (st_tab_sped kst_tab_sped) throws uo_exception;//
//====================================================================
//=== Cambia il numero e data DDT 
//=== 
//=== Input: st_tab_sped  id_sped e i nuovi valori di num_bolla_out e data_bolla_out
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return=false
int k_resp
st_esito kst_esito
st_tab_ricevute kst_tab_ricevute, kst_tab_ricevute_old
st_tab_prof kst_tab_prof, kst_tab_prof_old
st_open_w kst_open_w
st_tab_sped kst_tab_sped_old, kst_tab_sped1
st_tab_arfa kst_tab_arfa_old, kst_tab_arfa_new
kuf_fatt kuf1_fatt



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	if if_sicurezza(kkg_flag_modalita.modifica) then

		if kst_tab_sped.id_sped > 0 then

//--- recupera il numero e data di origine
			kst_tab_sped_old = kst_tab_sped
			get_numero_da_id(kst_tab_sped_old)

//--- se tutto ok Modifica anche le altre righe
			update arsp
				set num_bolla_out = :kst_tab_sped.num_bolla_out
					,data_bolla_out = :kst_tab_sped.data_bolla_out
				WHERE id_sped = :kst_tab_sped.id_sped
				using kguo_sqlca_db_magazzino;
			
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
					
		
		//--- Modifica TESTATA							
				update  sped
				set num_bolla_out = :kst_tab_sped.num_bolla_out
					,data_bolla_out = :kst_tab_sped.data_bolla_out
				WHERE id_sped = :kst_tab_sped.id_sped
				using kguo_sqlca_db_magazzino;

		//--- se tutto ok cancella anche le altre tabelle
				kst_tab_arfa_new.st_tab_g_0.esegui_commit = "N"
				kst_tab_arfa_new.num_bolla_out = kst_tab_sped.num_bolla_out
				kst_tab_arfa_new.data_bolla_out = kst_tab_sped.data_bolla_out
				kst_tab_arfa_old.num_bolla_out = kst_tab_sped_old.num_bolla_out
				kst_tab_arfa_old.data_bolla_out = kst_tab_sped_old.data_bolla_out
				kuf1_fatt = create kuf_fatt
				kuf1_fatt.set_cambio_ddt_num_data(kst_tab_arfa_old, kst_tab_arfa_new)
		
				k_return = true // OK!!!!!
			
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Errore durante la Modifica della Fattura ~n~r" &
						+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
						+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
						+ " ~n~rErrore-tab.sped:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		
		
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kguo_exception
	
end try


return k_return

end function

public function long tb_insert_testa (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//--- Inserisce Nuova Testata DDT
//--- torna il ID della fattura nel st_tab_sped.id_sped
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if if_sicurezza(kkg_flag_modalita.inserimento) then
	
//#--- 19.11.2012 --- legge dato da tab CAUS -----------------------------------
   kst_tab_sped.ddt_st_num_data_in = "S"
   if kst_tab_sped.caus_codice > " " then
      select ddt_st_num_data_in
           into :kst_tab_sped.ddt_st_num_data_in
               from   CAUS
               where  CAUS.CODICE = :kst_tab_sped.caus_codice
			using kguo_sqlca_db_magazzino;
   end if
//#----------------------------------------------------------------------------------------------------

	if_isnull_testa(kst_tab_sped)
	
	kst_tab_sped.stampa = "N" 
	
	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_tab_sped.note_1 = trim(kst_tab_sped.note_1)
	kst_tab_sped.note_2 = trim(kst_tab_sped.note_2)
	kst_tab_sped.rag_soc_1 = trim(kst_tab_sped.rag_soc_1)
	kst_tab_sped.rag_soc_2 = trim(kst_tab_sped.rag_soc_2)
	kst_tab_sped.indi = trim(kst_tab_sped.indi)
	kst_tab_sped.loc = trim(kst_tab_sped.loc)
	// id_sped, 
	INSERT INTO sped  
         (  
           num_bolla_out,   
           data_bolla_out,   
           clie_2,   
           clie_3,   
           cura_trasp,   
           causale,   
			caus_codice, 
           ddt_st_num_data_in,   
           aspetto,   
           porto,   
           mezzo,   
           note_1,   
           note_2,   
           data_rit,   
           ora_rit,   
           vett_1,   
           vett_2,   
           stampa,   
           colli,   
           data_uscita,   
           rag_soc_1,   
           rag_soc_2,   
           indi,   
           loc,   
           cap,   
           prov,   
           id_nazione,   
           id_docprod,   
			sv_call_vettore,
           form_di_stampa,   
           x_datins,   
           x_utente 
           )  
  VALUES (    
           :kst_tab_sped.num_bolla_out,   
           :kst_tab_sped.data_bolla_out,   
           :kst_tab_sped.clie_2,   
           :kst_tab_sped.clie_3,   
           :kst_tab_sped.cura_trasp,   
           :kst_tab_sped.causale,   
           :kst_tab_sped.caus_codice,			  
           :kst_tab_sped.ddt_st_num_data_in,   
           :kst_tab_sped.aspetto,   
           :kst_tab_sped.porto,   
           :kst_tab_sped.mezzo,   
           :kst_tab_sped.note_1,   
           :kst_tab_sped.note_2,   
           :kst_tab_sped.data_rit,   
           :kst_tab_sped.ora_rit,   
           :kst_tab_sped.vett_1,   
           :kst_tab_sped.vett_2,   
           :kst_tab_sped.stampa,   
           :kst_tab_sped.colli,   
           :kst_tab_sped.data_uscita,   
           :kst_tab_sped.rag_soc_1,   
           :kst_tab_sped.rag_soc_2,   
           :kst_tab_sped.indi,   
           :kst_tab_sped.loc,   
           :kst_tab_sped.cap,   
           :kst_tab_sped.prov,   
           :kst_tab_sped.id_nazione,   
           :kst_tab_sped.id_docprod,   
			:kst_tab_sped.sv_call_vettore,
			:kst_tab_sped.form_di_stampa,   
           :kst_tab_sped.x_datins,   
           :kst_tab_sped.x_utente   
           )  
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. Tab. DDT. (nr.=" + string(kst_tab_sped.num_bolla_out) + " del "  + string(kst_tab_sped.data_bolla_out) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		kst_tab_sped.id_sped = get_id_sped_max()
		//kst_tab_sped.id_sped = long(kguo_sqlca_db_magazzino.SQLReturnData)
		if kst_tab_sped.id_sped > 0 then
			k_return = kst_tab_sped.id_sped 
		end if
//---- COMMIT....	
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if

return k_return


end function

public function integer get_nr_righe (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna numero righe del DDT
//--- 
//--- 
//--- Inp: st_tab_arsp.id_sped
//--- Out: --
//--- Ritorna: numero di righe ddt
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
int k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_arsp.id_sped > 0 then
		
		SELECT count(id_sped)
		 INTO 
		  	:k_return
	 	FROM arsp  
		WHERE  id_sped = :kst_tab_arsp.id_sped 
			  using kguo_sqlca_db_magazzino;
	
	end if

	if isnull(k_return) then k_return = 0
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante calcolo nr righe ddt di arsp., id ddt " + string(kst_tab_arsp.id_sped) +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function long get_id_armo (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_armo della riga
//--- 
//--- 
//--- Inp: st_tab_arsp.id_arsp
//--- Out: --
//---
//--- Ritorna: id_armo
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_arsp.id_arsp > 0 then
		
		SELECT id_armo
		 INTO 
		  	:kst_tab_arsp.id_armo
	 	FROM arsp  
		WHERE  id_arsp = :kst_tab_arsp.id_arsp 
			  using kguo_sqlca_db_magazzino;
	
	end if

	if isnull(kst_tab_arsp.id_armo) then kst_tab_arsp.id_armo = 0
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_arsp.id_armo > 0 then k_return = kst_tab_arsp.id_armo
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID entrata nella riga ddt di sped., id riga " + string(kst_tab_arsp.id_sped) +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function string get_stampa (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Torna stampa  
//
//--- inp: st_tab_arsp.id_arsp
//--- Rit: stampa 
//--- Lancia exception st_esito
//
string k_return = ""
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_arsp > 0 then
	
	SELECT arsp.stampa
		 INTO :kst_tab_arsp.stampa   
		 FROM arsp  
		WHERE id_arsp = :kst_tab_arsp.id_arsp
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettrura flag stampa della riga ddt, id riga " + string( kst_tab_arsp.id_arsp) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if isnull(kst_tab_arsp.stampa) then kst_tab_arsp.stampa = kki_sped_flg_stampa_bolla_da_stamp
		k_return = kst_tab_arsp.stampa 
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore in lettrura flag stampa della riga ddt, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function long get_colli (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Torna colli 
//
//--- inp: st_tab_arsp.id_arsp
//--- rit: colli = Numero colli; 0=nessuno
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_arsp > 0 then
	
	SELECT arsp.colli
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE id_arsp = :kst_tab_arsp.id_arsp
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore calcolo colli spediti, id riga " + string( kst_tab_arsp.id_arsp) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp.colli > 0 then
			k_return = kst_tab_arsp.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Calcolo colli spediti non eseguito, manca id riga lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function long get_id_sped (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_arsp da id riga
//--- 
//--- 
//--- Inp: st_tab_arsp.id_arsp
//--- Rit: kst_tab_arsp.id_sped
//---
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return=0
int k_anno = 0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_arsp.id_arsp > 0 then
		
		SELECT id_sped
		 INTO 
		  	:kst_tab_arsp.id_sped
	 	FROM arsp  
		WHERE id_arsp = :kst_tab_arsp.id_arsp  
		  using kguo_sqlca_db_magazzino;
	
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_arsp.id_arsp > 0 then k_return = kst_tab_arsp.id_arsp
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura ID del ddt da id riga, id= " + string( kst_tab_arsp.id_arsp) + " del "+ string( kst_tab_arsp.data_bolla_out )+" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function boolean tb_delete_riga (st_tab_arsp kst_tab_arsp) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella SPED-ARSP (Bolle di spedizione) 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_arfa kst_tab_arfa
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_armo_prezzi kuf1_armo_prezzi
kuf_wm_pklist_righe kuf1_wm_pklist_righe
st_tab_sped kst_tab_sped
//st_tab_docprod kst_tab_docprod
//kuf_docprod kuf1_docprod
//kuf_doctipo kuf1_doctipo
//kuf_fatt kuf1_fatt
//kuf_sped_ddt kuf1_sped_ddt


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if if_sicurezza(kkg_flag_modalita.cancellazione) then  // Controllo se utente autorizzato

//=== Controllo se riga bolla già fatturata
		DECLARE c_fattura CURSOR FOR  
			  SELECT num_fatt, data_fatt
				 FROM arfa 
				WHERE arfa.id_arsp = :kst_tab_arsp.id_arsp
					using kguo_sqlca_db_magazzino;
		
		open c_fattura;
		if kguo_sqlca_db_magazzino.sqlCode = 0 then
		
			fetch c_fattura INTO :kst_tab_arfa.num_fatt, :kst_tab_arfa.data_fatt;
		
			if kguo_sqlca_db_magazzino.sqlCode = 0 then
	
				if kst_tab_arfa.num_fatt > 0 then
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
						  "Riga DDT gia' in Fattura nr. " &
							+ string(kst_tab_arfa.num_fatt, "####0") + " del " &
							+ string(kst_tab_arfa.data_fatt, "dd.mm.yyyy") + " ~n~r" &
							+ "id riga spedizione nr. " &
							+ string(kst_tab_arsp.id_arsp, "####0") &	
							+ " ~n~r "
					kst_esito.esito = kkg_esito.no_esecuzione
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			close c_fattura;
		end if
		
		kst_tab_arsp.ID_ARMO = get_id_armo(kst_tab_arsp)
		kst_tab_arsp.colli = get_colli(kst_tab_arsp)
		
//--- Ripristina i colli in Prezzi-riga-lotto della riga
		kst_tab_arsp.STAMPA = get_stampa(kst_tab_arsp)
		kst_tab_armo_prezzi.id_armo = kst_tab_arsp.ID_ARMO
		kst_tab_armo_prezzi.item_dafatt = kst_tab_arsp.colli
		kuf1_armo_prezzi = create kuf_armo_prezzi
		if kst_tab_arsp.STAMPA = kki_sped_flg_stampa_bolla_stampata then // ripristino sono se 'stampato' 
			kst_tab_armo_prezzi.st_tab_g_0.esegui_commit	= "N"
			kuf1_armo_prezzi.esegui_evento_scarico_ripristina(kst_tab_armo_prezzi)		// RIPRISTINA colli 
		end if

//--- Ripristina il flag di righe WMF 			
		kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
		kst_tab_wm_pklist_righe.id_armo = kst_tab_arsp.ID_ARMO
		kst_esito = kuf1_wm_pklist_righe.if_esiste_in_sped_x_id_armo(kst_tab_wm_pklist_righe)		//Controlla se esiste il PKLIST
//--- se esiste il pk-list aggiorna					
		if kst_esito.esito = kkg_esito.ok then
			kst_esito = kuf1_wm_pklist_righe.set_sped_no_x_id_armo(kst_tab_wm_pklist_righe)		// AGGIORNA PackingList a NON SPEDITO (reset)
		end if

	
	//--- cancella prima tutte le righe
		delete from arsp
			where id_arsp = :kst_tab_arsp.id_arsp
			using kguo_sqlca_db_magazzino; 
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
		"Errore durante la cancellazione riga del DDT (id riga " &
						+ string(kst_tab_arsp.id_arsp, "####0") &	
						+ " ~n~rErrore-tab.ARSP:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

////--- piglia il ID
//		if kst_tab_sped.id_sped > 0 then
//		else
//			kst_tab_sped.id_sped = get_id_sped(kst_tab_arsp)
//		end if
//
////--- se non trovo righe nel DDT lo rimuovo
//		if kst_tab_sped.id_sped > 0 then
//			if get_nr_righe(kst_tab_arsp) = 0 then		
//				tb_delete_testa(kst_tab_sped)			
//			end if
//		end if
		
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
				
	end if
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	
end try


return k_return

end function

public function long tb_insert_riga (ref st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Inserisce Nuova Riga DDT
//--- torna il ID della ddt nel st_tab_arsp.id_arsp
//
long k_return = 0
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if if_sicurezza(kkg_flag_modalita.inserimento) then

	if_isnull_riga(kst_tab_arsp)

	kst_tab_arsp.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp.x_utente = kGuf_data_base.prendi_x_utente()
		//id_arsp, 
	  INSERT INTO arsp  
         (   
           id_sped,   
           num_bolla_out,   
           data_bolla_out,   
           nriga,   
           colli,   
           note_1,   
           note_2,   
           note_3,   
           stampa,   
           colli_out,   
           peso_kg_out,   
           id_armo,   
           x_datins,   
           x_utente )  
  VALUES (   
            :kst_tab_arsp.id_sped,   
            :kst_tab_arsp.num_bolla_out,   
            :kst_tab_arsp.data_bolla_out,   
            :kst_tab_arsp.nriga,   
            :kst_tab_arsp.colli,   
            :kst_tab_arsp.note_1,   
            :kst_tab_arsp.note_2,   
            :kst_tab_arsp.note_3,   
            :kst_tab_arsp.stampa,   
            :kst_tab_arsp.colli_out,   
            :kst_tab_arsp.peso_kg_out,   
            :kst_tab_arsp.id_armo,   
            :kst_tab_arsp.x_datins,   
            :kst_tab_arsp.x_utente )  
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in inserim. riga DDT. (nr.=" + string(kst_tab_arsp.num_bolla_out) &
				+ " del "  + string(kst_tab_arsp.data_bolla_out) + " riga lotto "  + string(kst_tab_arsp.id_armo) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
		kst_tab_arsp.id_arsp = get_id_arsp_max()
		//kst_tab_arsp.id_arsp = long(kguo_sqlca_db_magazzino.SQLReturnData)
		if kst_tab_arsp.id_arsp > 0 then
			k_return = kst_tab_arsp.id_arsp
		end if
//---- COMMIT....	
		if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if

return k_return


end function

public subroutine tb_update_riga (ref st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Aggiorna Riga DDT
//--- torna 
//
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if if_sicurezza(kkg_flag_modalita.inserimento) then

	if_isnull_riga(kst_tab_arsp)

	kst_tab_arsp.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_arsp.x_utente = kGuf_data_base.prendi_x_utente()
		
	  update arsp   set  
           id_armo	 =   :kst_tab_arsp.id_armo,   
	       nriga    = :kst_tab_arsp.nriga,
           colli     =  :kst_tab_arsp.colli,   
           note_1  	 =   :kst_tab_arsp.note_1,   
           note_2 	 =   :kst_tab_arsp.note_2,   
           note_3  	 =   :kst_tab_arsp.note_3,   
           stampa  	 =   :kst_tab_arsp.stampa,   
           colli_out  =   :kst_tab_arsp.colli_out,   
           peso_kg_out  =   :kst_tab_arsp.peso_kg_out,  
           id_sped	 =   :kst_tab_arsp.id_sped,   
           num_bolla_out =   :kst_tab_arsp.num_bolla_out,   
           data_bolla_out =   :kst_tab_arsp.data_bolla_out,   
           x_datins 	 =   :kst_tab_arsp.x_datins,   
           x_utente	 =   :kst_tab_arsp.x_utente  
		where id_arsp = :kst_tab_arsp.id_arsp
			using kguo_sqlca_db_magazzino;

//           id_sped  = :kst_tab_arsp.id_sped,    
//           num_bolla_out =   :kst_tab_arsp.num_bolla_out,, 
//           data_bolla_out =   :kst_tab_arsp.data_bolla_out

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento riga DDT. (nr.=" + string(kst_tab_arsp.num_bolla_out) &
				+ " del "  + string(kst_tab_arsp.data_bolla_out) + " riga "  + string(kst_tab_arsp.id_arsp) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
//---- COMMIT....	
		if kst_tab_arsp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_arsp.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if



end subroutine

public subroutine tb_update_testa (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//--- Aggiorna Testata DDT
//--- torna 
//
long k_return = 0
long k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if if_sicurezza(kkg_flag_modalita.inserimento) then

//#--- 19.11.2012 --- legge dato da tab CAUS -----------------------------------
   kst_tab_sped.ddt_st_num_data_in = "S"
   if kst_tab_sped.caus_codice > " " then
      select ddt_st_num_data_in
           into :kst_tab_sped.ddt_st_num_data_in
               from   CAUS
               where  CAUS.CODICE = :kst_tab_sped.caus_codice
			using kguo_sqlca_db_magazzino;
   end if
//#----------------------------------------------------------------------------------------------------
 
	if_isnull_testa(kst_tab_sped)

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_tab_sped.note_1 = trim(kst_tab_sped.note_1)
	kst_tab_sped.note_2 = trim(kst_tab_sped.note_2)
	kst_tab_sped.rag_soc_1 = trim(kst_tab_sped.rag_soc_1)
	kst_tab_sped.rag_soc_2 = trim(kst_tab_sped.rag_soc_2)
	kst_tab_sped.indi = trim(kst_tab_sped.indi)
	kst_tab_sped.loc = trim(kst_tab_sped.loc)
	
	update sped  set
            clie_2    =   :kst_tab_sped.clie_2,   
            clie_3    =   :kst_tab_sped.clie_3,   
            cura_trasp =   :kst_tab_sped.cura_trasp,   
            causale   =   :kst_tab_sped.causale,   
 	        caus_codice =   :kst_tab_sped.caus_codice,		
            ddt_st_num_data_in = :kst_tab_sped.ddt_st_num_data_in, 
            aspetto    =   :kst_tab_sped.aspetto,   
            porto    =   :kst_tab_sped.porto,   
            mezzo   =   :kst_tab_sped.mezzo,   
            note_1   =   :kst_tab_sped.note_1,   
            note_2   =   :kst_tab_sped.note_2,   
            data_rit  =   :kst_tab_sped.data_rit,   
            ora_rit   =   :kst_tab_sped.ora_rit,   
            vett_1   =   :kst_tab_sped.vett_1,   
            vett_2   =   :kst_tab_sped.vett_2,   
            stampa  =   :kst_tab_sped.stampa,   
            colli  =   :kst_tab_sped.colli,   
            data_uscita =   :kst_tab_sped.data_uscita,   
            rag_soc_1 =   :kst_tab_sped.rag_soc_1,   
            rag_soc_2 =   :kst_tab_sped.rag_soc_2,   
            indi    =   :kst_tab_sped.indi,   
            loc    =   :kst_tab_sped.loc,   
            cap	   =   :kst_tab_sped.cap,   
            prov   =   :kst_tab_sped.prov,   
            id_nazione  =   :kst_tab_sped.id_nazione,   
            id_docprod =   :kst_tab_sped.id_docprod,   
			sv_call_vettore = :kst_tab_sped.sv_call_vettore,
            x_datins  =   :kst_tab_sped.x_datins,   
            x_utente  =   :kst_tab_sped.x_utente   
		 where id_sped = :kst_tab_sped.id_sped
			using kguo_sqlca_db_magazzino;

//            form_di_stampa =   :kst_tab_sped.form_di_stampa,    
//            num_bolla_out =   :kst_tab_sped.num_bolla_out,   
//            data_bolla_out =   :kst_tab_sped.data_bolla_out,    

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento Tab. DDT. (nr.=" + string(kst_tab_sped.num_bolla_out) &
		           + " del "  + string(kst_tab_sped.data_bolla_out) + " id "  + string(kst_tab_sped.id_sped) +") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	else
//---- COMMIT....	
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

end if




end subroutine

public subroutine get_note (ref st_tab_arsp kst_tab_arsp) throws uo_exception;//
//--- Torna le NOTE della riga ddt
//
//--- inp: st_tab_arsp.id_arsp
//--- out: note_1/note_2/note_3
//--- Lancia exception st_esito
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_arsp.id_armo > 0 then
	
	SELECT note_1
	      ,note_2
		  ,note_3
		 INTO :kst_tab_arsp.note_1
		     ,:kst_tab_arsp.note_2
		     ,:kst_tab_arsp.note_3
		 FROM arsp  
		WHERE id_arsp = :kst_tab_arsp.id_arsp
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nella ricerca delle Note per la riga " + string( kst_tab_arsp.id_arsp) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if isnull(kst_tab_arsp.note_1) then kst_tab_arsp.note_1 = "" 
		if isnull(kst_tab_arsp.note_2) then kst_tab_arsp.note_2 = "" 
		if isnull(kst_tab_arsp.note_3) then kst_tab_arsp.note_3 = "" 
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore ricerca Note, manca id riga ddt! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	




end subroutine

public function boolean if_ddt_lavparziale () throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se è possibile fare DDT con lotti trattati solo parzialmente 
//---
//--- Rit: true = ok posso spedire lotti parziali, FALSE = NON è possibile fare DDT x lotti parziali
//
//----------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_esito = ""
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

kuf1_base = create kuf_base
k_esito = trim(kuf1_base.prendi_dato_base("ddt_blk_lotti_senza_attestato"))
if left(k_esito,1) <> "0" then
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.SQLErrText = mid(k_esito,2)
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if mid(k_esito,2,1) = "1" then
	k_return = false
else 
	k_return = true
end if


return k_return



end function

public function integer get_nr_indirizzi_ddt (st_tab_sped kst_tab_sped);//
//--- Torna il numero Indirizzi di spedizione utilizzati (-1 = errore)
//
int k_return = 0
string k_clie_2_x
long k_clie_2


SetPointer(kkg.pointer_attesa)


	if kst_tab_sped.clie_2 > 0 then
	
		k_clie_2 = u_get_clie_ds_dw_elenco_indirizzi()
	
		if kst_tab_sped.clie_2  <> k_clie_2 then
			k_return = kdsi_dw_elenco_indirizzi.retrieve(kst_tab_sped.clie_2)
		else
			k_return = kdsi_dw_elenco_indirizzi.rowcount()
		end if
		
	end if
				
SetPointer(kkg.pointer_default)

return k_return 

	



		
		
		


end function

public function boolean link_call_anteprima (ref datastore ads_link, string a_campo_link) throws uo_exception;//=== 
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
long k_riga=0
boolean k_return=true
string k_dataobject, k_id_programma
st_tab_sped kst_tab_sped
st_tab_armo kst_tab_armo
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

k_riga = ads_link.getrow()

kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

choose case a_campo_link

	case "b_arsp_lotto" 
		kst_tab_armo.id_meca = ads_link.getitemnumber(ads_link.getrow(), "id_meca")
		if kst_tab_armo.id_meca > 0 then
			kst_open_w.key1 = "Elenco righe DDT di Spedizione  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
			k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
		else
			k_return = false
		end if


	case "b_arsp_sped", "b_sped", "num_bolla_out", "num_bolla_out_1", "arsp_insped"
		if a_campo_link = "num_bolla_out_1" then
			kst_tab_sped.num_bolla_out = ads_link.getitemnumber(ads_link.getrow(), "num_bolla_out_1")
		else
			kst_tab_sped.num_bolla_out = ads_link.getitemnumber(ads_link.getrow(), "num_bolla_out")
		end if
		if kst_tab_sped.num_bolla_out > 0 then
			kst_tab_sped.data_bolla_out = ads_link.getitemdate(ads_link.getrow(), "data_bolla_out")
			kst_open_w.key1 = "DDT di spedizione n. " + trim(string(kst_tab_sped.num_bolla_out)) + " del " + trim(string(kst_tab_sped.data_bolla_out)) 
			k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione)
		else
			k_return = false	
		end if

	case "id_sped"
		kst_tab_sped.id_sped = ads_link.getitemnumber(ads_link.getrow(), a_campo_link)
		get_numero_da_id(kst_tab_sped)
		if kst_tab_sped.num_bolla_out > 0 then
//			kst_tab_sped.data_bolla_out = ads_link.getitemdate(ads_link.getrow(), "data_bolla_out")
			kst_open_w.key1 = "DDT di spedizione n. " + trim(string(kst_tab_sped.num_bolla_out)) + " del " + trim(string(kst_tab_sped.data_bolla_out)) 
			k_id_programma = this.get_id_programma(kkg_flag_modalita.visualizzazione )
		else
			k_return = false	
		end if



end choose


if k_return then

	kst_open_w.id_programma = k_id_programma 
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Elenco non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
			kdsi_elenco_output.dataobject = k_dataobject		
			kdsi_elenco_output.settransobject(sqlca)
	
			kdsi_elenco_output.reset()	
			
			choose case a_campo_link
						
				case "b_arsp_lotto" 
					kst_esito = anteprima_elenco ( kdsi_elenco_output, kst_tab_armo )
			
				case "b_sped", "num_bolla_out", "id_sped"
					kst_esito = anteprima ( kdsi_elenco_output, kst_tab_sped )
			
				case "b_arsp_sped"
					kst_esito = anteprima_righe ( kdsi_elenco_output, kst_tab_sped )
			
				case "num_bolla_out_1"
					kst_esito = anteprima_1 ( kdsi_elenco_output, kst_tab_sped )
			
				case "arsp_insped"
					kst_esito = anteprima_2 ( kdsi_elenco_output, kst_tab_sped )
			
			end choose
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			if isvalid(kdsi_elenco_output) then k_dataobject = kdsi_elenco_output.dataobject

	
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
		kst_open_w.id_programma =kkg_id_programma_elenco
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
boolean k_return=false
datastore kds_1


	kds_1 = create datastore
	kds_1.dataobject = adw_link.dataobject

	if adw_link.rowcount() > 0 then
		adw_link.rowscopy(1, adw_link.rowcount(), primary!, kds_1, 1, primary!)
		if adw_link.getrow() >0 then  
			kds_1.setrow(adw_link.getrow())
			k_return = link_call_anteprima(kds_1, a_campo_link)
		end if
	end if


return k_return 
end function

public function boolean link_call (ref datastore ads_1, string a_campo_link) throws uo_exception;//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datastore su cui è stato attivato il LINK
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
boolean k_return=false



	if ads_1.rowcount() > 0 then
		if ads_1.getrow() > 0 then  
			k_return = link_call_anteprima(ads_1, a_campo_link)
		end if
	end if


return k_return 
end function

public function long get_colli_sped_lotto (long aid_meca) throws uo_exception;//
//--- Torna colli spediti x id_meca 
//
//--- inp: id_meca
//--- out: colli = Numero colli spediti x l'intero Lotto; 0=nessuno
//--- Lancia exception 
//
long k_return = 0
st_tab_arsp kst_tab_arsp
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if aid_meca > 0 then
	
	SELECT sum (arsp.colli)
		 INTO :kst_tab_arsp.colli   
		 FROM arsp  
		WHERE id_armo in
		  ( select distinct id_armo 
		          from armo 
					 where id_meca = :aid_meca)
	  using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_arsp.colli = 0
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per Lotto id " + string(aid_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
		end if
	else
		if kst_tab_arsp.colli > 0 then
			k_return = kst_tab_arsp.colli 
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore nel calcolo nr. colli spediti per Lotto, manca id lotto! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	
	
return k_return



end function

public function boolean if_sv_call_vettore (st_tab_sped ast_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controllo se è stato applicato il SERVIZIO DI COSTO CHIAMATA VETTORE
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped
//--- Out: TRUE = costo attivato 
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
//
boolean k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if ast_tab_sped.id_sped > 0 then
	
	SELECT sped.sv_call_vettore
		 INTO :ast_tab_sped.sv_call_vettore   
		 FROM sped  
		WHERE id_sped = :ast_tab_sped.id_sped
	  using kguo_sqlca_db_magazzino;
	  
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_sped.sv_call_vettore = 1 then
			k_return = true
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = kguo_sqlca_db_magazzino.sqlerrtext
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Controllo 'Chiamata Vettore' su DDT non eseguito, manca il codice id del DDT! " 
	kst_esito.esito = kkg_esito.err_logico
			
end if	



return k_return



end function

public function string run_chiudi_bolle_batch () throws uo_exception;//
string k_return = ""
string k_esito = ""
integer k_nr_rec
st_esito kst_esito
st_errori_gestione kst_errori_gestione
datastore kds_sp


try	

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

//--- lancio spl (datastore)
	kds_sp = create datastore 
	kds_sp.dataobject = "dsp_chiudi_bolle"
	kds_sp.settrans(kguo_sqlca_db_magazzino)
	k_nr_rec = kds_sp.retrieve( )
	if k_nr_rec > 0 then
		k_esito = kds_sp.getitemstring( 1, "esito")
	end if			

	if k_nr_rec < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = -1
		kst_esito.sqlerrtext = "Operazione di spunta automatica DDT fatturati '" &
									  + trim(kds_sp.dataobject) + "' non riuscita: esito -1" 
	else
		if k_nr_rec = 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Anomalia in operazione spunta automatica DDT fatturati ' " &
										  + trim(kds_sp.dataobject) + "' nessun dato estratto! "
		else
			if left(k_esito,2) <> "Ok" then
				kst_esito.esito = kkg_esito.ko
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Anomalie in spunta automatica DDT fatturati ' " &
											  + trim(kds_sp.dataobject) + "' err.:" + trim(k_esito)
			else
				kst_esito.esito = kkg_esito.ok
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Operazione di spunta automatica DDT fatturati '" &
											  + trim(kds_sp.dataobject) + "' terminata correttamente: " + trim(k_esito)
			end if
		end if
	end if

//--- scrive l'errore su LOG
	kst_errori_gestione.nome_oggetto = this.classname()
	kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
	kst_errori_gestione.sqlerrtext = trim(kst_esito.SQLErrText)
	kst_errori_gestione.sqldbcode = kst_esito.sqlcode
	kst_errori_gestione.sqlca = kguo_sqlca_db_magazzino
	kGuf_data_base.errori_gestione(kst_errori_gestione)
				
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	k_return = kst_esito.sqlerrtext // ~n~r" + "File: " + trim(k_path) 

end try

return k_return

end function

public function long get_id_sped_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID SPED inserito 
//--- 
//---  input: 
//---  ret: max ID_SPED
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_sped)
		 INTO 
				:k_return
		 FROM sped  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID di Spedizione in tabella (SPED)" &
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

public function long get_id_arsp_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID ARSP inserito 
//--- 
//---  input: 
//---  ret: max ID_ARSP
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_arsp)
		 INTO 
				:k_return
		 FROM arsp
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID riga di Spedizione in tabella (ARSP)" &
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

public function long get_id_sped (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped da numero/data bolla
//--- 
//--- Inp: kst_tab_sped.num_bolla_out/data_bolla_out
//--- Out: kst_tab_sped.id_sped
//---
//--- Ritorna: Il ID del ddt trovato 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
int k_anno = 0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped.data_bolla_out)
		
		SELECT id_sped
		 INTO 
		  	:kst_tab_sped.id_sped
	 	FROM sped  
		WHERE ( num_bolla_out = :kst_tab_sped.num_bolla_out ) AND  
						year(data_bolla_out) = :k_anno  
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped.id_sped > 0 then k_return = kst_tab_sped.id_sped
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ID del ddt di sped., numero  " + string( kst_tab_sped.num_bolla_out) + " del "+ string( kst_tab_sped.data_bolla_out )+" ~n~r" &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function boolean set_num_bolla_out_all (st_tab_sped kst_tab_sped) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Aggiorna in nr DDT per ID_SPED della Testata e delle Righe
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped  e  num_bolla_out
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
	
	
if kst_tab_sped.id_sped > 0 then

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE SPED  
		  SET num_bolla_out = :kst_tab_sped.num_bolla_out
			,x_datins = :kst_tab_sped.x_datins
			,x_utente = :kst_tab_sped.x_utente
		WHERE sped.id_sped = :kst_tab_sped.id_sped
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
		UPDATE ARSP  
			  SET num_bolla_out = :kst_tab_sped.num_bolla_out
				,x_datins = :kst_tab_sped.x_datins
				,x_utente = :kst_tab_sped.x_utente
			WHERE arsp.id_sped = :kst_tab_sped.id_sped
			using kguo_sqlca_db_magazzino;

	end if

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiornamento del Numero sulla Testata e le Righe del DDT. ~n~r" &
					+ "Id: " + string(kst_tab_sped.id_sped, "#0") + "  " &
					+ "n.: " + string(kst_tab_sped.num_bolla_out, "#0") + "  " &
					+ " ~n~rErrore-tab.SPED:"	+ trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Errore tab. DDT, Manca Identificativo (id_sped) !" 
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

public function long get_num_bolla_out_ultimo (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna ultimo  numero x anno inseriti
//--- 
//--- Inp: kst_tab_sped.data_bolla_out + id_sped da escludere (opt)
//--- Out: kst_tab_sped.num_bolla_out
//---
//--- Ritorna: Il ID del ddt trovato 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
long k_num_bolla_out_extra
int k_anno
date k_data_da, k_data_a
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	if kst_tab_sped.data_bolla_out > kkg.data_zero then
		
		k_anno = year(kst_tab_sped.data_bolla_out)
		k_data_da = date(k_anno,01,01)
		k_data_a = date(k_anno,12,31)
		
		if isnull(kst_tab_sped.id_sped) then kst_tab_sped.id_sped = 0
		k_num_bolla_out_extra = kki_num_bolla_out_extra
		
		SELECT max(num_bolla_out)
		 INTO 
		  	:kst_tab_sped.num_bolla_out
	 	FROM sped  
		WHERE  data_bolla_out between :k_data_da and :k_data_a  
		              and id_sped <> :kst_tab_sped.id_sped
						  and num_bolla_out < :k_num_bolla_out_extra
			  using kguo_sqlca_db_magazzino;
	
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_sped.num_bolla_out > 0 then k_return = kst_tab_sped.num_bolla_out
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura ultimo Numero del ddt di sped. per l'anno " + string(kst_tab_sped.data_bolla_out, "yyyy") +" ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
return k_return


end function

public function long get_numero_nuovo (st_tab_sped ast_tab_sped, integer a_ctr) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il nuovo numero per un nuovo DDT
//--- 
//--- 
//--- Inp: st_tab_sped.data_bolla_out,  ctr = contatore per il auto-rilancio (max 10 volte) 
//--- Rit: numero x fare un nuovo DDT dell'anno
//---
//--- Ritorna: TRUE = ddt trovato e id valorizzato
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_num_base, k_num_ddt
string k_dato
date k_data_base
st_tab_sped kst_tab_sped
kuf_base kuf1_base

try

//--- get numero dal contatore se anno in corso
	if year(ast_tab_sped.data_bolla_out) = kguo_g.get_anno( ) then

		kuf1_base = create kuf_base
		k_dato = kuf1_base.prendi_dato_base( "numdata_ddt")
		if left(k_dato, 1) = "0" then
			k_num_base = long(mid(k_dato,2,12))  //ultimo numero DDT preso dalla tabella 
			k_data_base = date(mid(k_dato,15))  //ultima data DDT preso dalla tabella 
			if isnull(k_num_base) then 
				k_num_base = 0
				k_data_base = kkg.data_zero
			end if
		else
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = left(k_dato, 1)
			kguo_exception.kist_esito.sqlerrtext = "Errore in lettura n. ddt da Proprietà Procedura, prego riprovare. ~n~r" + mid(k_dato,2)
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			throw kguo_exception
		end if
		destroy kuf1_base

	end if

	kst_tab_sped.id_sped = ast_tab_sped.id_sped  
	if year(k_data_base) > 1990 then
		kst_tab_sped.data_bolla_out = k_data_base
	else
		kst_tab_sped.data_bolla_out = ast_tab_sped.data_bolla_out  
	end if

//--- get ultimo numero dalla tabella DDT x l'anno indicato
	k_num_ddt = this.get_num_bolla_out_ultimo(kst_tab_sped)	
	if isnull(k_num_ddt) then k_num_ddt = 0
	
//--- torna il num più alto	
	if k_num_ddt > k_num_base then
		k_return = k_num_ddt + 1
	else
		k_return = k_num_base + 1
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	//--- il DDT a parte la prima deve essere maggiore di 1 quindi ritenta 10 volte
	if k_return < 2 and a_ctr < 10 then
		sleep(1)
		k_return = get_numero_nuovo(ast_tab_sped, (a_ctr + 1))
	end if
	
end try
	
return k_return

end function

public function long if_num_bolla_out_exists (st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna id_sped da numero/data bolla se caricato con id diverso dal passato
//--- 
//--- Inp: kst_tab_sped. id_sped + num_bolla_out + data_bolla_out
//--- Out: 
//---
//--- Ritorna: kst_tab_sped.id_sped se diverso da input 
//---
//---Lancia EXCEPTION
//---
//----------------------------------------------------------------------------------------------------------------
long k_return
int k_anno = 0
date k_data_da, k_data_a
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_sped.num_bolla_out > 0 then
		
		k_anno = year(kst_tab_sped.data_bolla_out)
		k_data_da = date(k_anno,01,01)
		k_data_a = date(k_anno,12,31)

		SELECT max(id_sped)
		 INTO 
		  	:kst_tab_sped.id_sped
	 	FROM sped  
		WHERE num_bolla_out = :kst_tab_sped.num_bolla_out 
						and data_bolla_out between :k_data_da and :k_data_a  
						and id_sped <> :kst_tab_sped.id_sped
			  using sqlca;
	
	end if
	
	if sqlca.sqlcode = 0 then
		if kst_tab_sped.id_sped > 0 then k_return = kst_tab_sped.id_sped
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in ricerca ID del ddt di sped., numero  " + string( kst_tab_sped.num_bolla_out) + " del "+ string( kst_tab_sped.data_bolla_out ) &
															+ " diverso dal ID " + string( kst_tab_sped.id_sped) + " ~n~r" &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
return k_return


end function

private function long u_get_clie_ds_dw_elenco_indirizzi ();//
//--- Fa l'elenco Indirizzi di spedizione 
//
string k_clie_2_x
long k_return


	if not isvalid(kdsi_dw_elenco_indirizzi) then
		kdsi_dw_elenco_indirizzi = create datastore
		kdsi_dw_elenco_indirizzi.dataobject = kki_dw_elenco_indirizzi 
		kdsi_dw_elenco_indirizzi.settransobject(sqlca) 
	end if
		
	k_clie_2_x = kdsi_dw_elenco_indirizzi.describe("evaluate('arg1', 1)") 
	if isnumber(k_clie_2_x) then
		k_return = long(k_clie_2_x) 
	end if
	
return k_return

end function

public function boolean if_ddt_allarme_memo (st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT ha un allarme MEMO x id_sped
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped
//--- Out: TRUE = ddt in allarme 
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
string k_esito = ""
datastore kds
st_esito kst_esito
kuf_base kuf1_base


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

if kst_tab_sped.id_sped > 0 then
	kds = create datastore
	kds.dataobject = "ds_ddt_if_allarme_memo"
	kds.settransobject(kguo_sqlca_db_magazzino)
	if kds.retrieve( kst_tab_sped.id_sped) > 0 then
		k_return = true
	end if
else

	kst_esito.esito = kkg_esito.no_esecuzione  
	kst_esito.SQLErrText = "Verifica Allarme MEMO sul DDT non eseguita, id del DDT assente!"
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return



end function

public function boolean if_stampato (st_tab_sped ast_tab_sped) throws uo_exception;//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT stampato x id_sped
//--- 
//--- 
//--- Inp: st_tab_sped.id
//--- Out: TRUE = completamente stampata
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = true   //default stampata 
long k_trovato=0
st_esito kst_esito
st_tab_sped kst_tab_sped_stampato


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

kst_tab_sped_stampato.stampa = kki_sped_flg_stampa_bolla_da_stamp

if if_esiste(ast_tab_sped) then

	k_trovato = 0
	SELECT count(*)
			into :k_trovato
			 FROM sped  
			 where  id_sped  = :ast_tab_sped.id_sped 
			    and (stampa is null or stampa = :kst_tab_sped_stampato.stampa)
			 using kguo_sqlca_db_magazzino;
	
	if k_trovato = 0 then
		SELECT count(*)
			into :k_trovato
			 FROM arsp  
			 where  id_sped  = :ast_tab_sped.id_sped 
			    and (stampa is null or stampa = :kst_tab_sped_stampato.stampa)
			 using kguo_sqlca_db_magazzino;
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante ricerca se DDT stampato (sped) id = " + string(ast_tab_sped.id_sped) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true  
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if k_trovato > 0 then 
				k_return = false   //NON è completamente stampata
			end if	
		end if
	end if
	
else
	
end if
	

return k_return



end function

on kuf_sped.create
call super::create
end on

on kuf_sped.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "DDT di spedizione"
end event

event destructor;call super::destructor;//
if isvalid(kdsi_dw_elenco_indirizzi) then destroy kdsi_dw_elenco_indirizzi

end event

