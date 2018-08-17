$PBExportHeader$kuf_menu_window.sru
forward
global type kuf_menu_window from nonvisualobject
end type
end forward

global type kuf_menu_window from nonvisualobject
end type
global kuf_menu_window kuf_menu_window

type variables
//
public constant string kki_primo_giro_si="S"

//--- valore flag tabella st_tab_menu_window.msg_se_gia_open
public string kki_msg_se_gia_open_esponi = "S"  // Espone il msg 
public string kki_msg_se_gia_open_nessuno = "N"  // non espone nulla 
public string kki_msg_se_gia_open_riOpen = "R" // non espone msg e lancia evento U_RIOPEN  se già aperta

//
private st_tab_menu_window_oggetti kist_tab_menu_window_oggetti[]

end variables

forward prototypes
public function string tb_delete (string k_codice)
public function boolean autorizza_funzione (st_open_w kst_open_w)
private function boolean autorizza_menu_1 (string k_menu_tag)
public subroutine autorizza_menu (ref m_main kmenu_main)
private subroutine open_run_batch (st_open_w kst_open_w) throws uo_exception
public function integer set_tab_menu_window ()
public subroutine set_icone (ref m_main kmenu_main)
public function string open_w_tabelle (st_open_w kst_open_w)
private function boolean set_tab_menu_window_oggetti ()
public function boolean get_id_menu_window (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti)
public function boolean batch_lancio (st_open_w kst_open_w_par) throws uo_exception
private function string u_esplode_funzione (string k_funzione)
public subroutine if_isnull (st_open_w ast_open_w)
private function boolean connetti () throws uo_exception
private function boolean set_tab_menu_window_anteprima ()
public function boolean get_st_tab_menu_window_anteprima (ref st_tab_menu_window_anteprima ast_tab_menu_window_anteprima)
public function boolean open_w_tabelle_da_ds (datastore ads_dati_window, string a_modalita) throws uo_exception
public function boolean get_st_tab_menu_window (ref st_tab_menu_window k_st_tab)
public function window prendi_win_uguale (string a_nome_win)
private function boolean u_open_funzione (st_open_w ast_open_w) throws uo_exception
public function boolean get_nome_oggetto_da_window_oggetti (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti)
private function string get_nome_oggetto (string a_menu_id)
end prototypes

public function string tb_delete (string k_codice);//
//====================================================================
//=== Cancella il rek dalla tabella Clienti e Clienti_sped
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "

	
	delete from menu_window
			where id = :k_codice ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText

	end if


return k_return
end function

public function boolean autorizza_funzione (st_open_w kst_open_w);//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return
kuf_sicurezza kuf1_sicurezza


kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


return k_return

end function

private function boolean autorizza_menu_1 (string k_menu_tag);//
//=== Controlla se voce menu e' da autorizzare
//
boolean k_return = false
long k_ctr, k_ctr_idx


	k_menu_tag = lower(trim(k_menu_tag))

	if k_menu_tag = "master" then
		k_return = true
	else
	
		k_ctr = 1
		k_ctr_idx = UpperBound(kGst_tab_menu_window[])
		do while k_ctr <= k_ctr_idx 
			if k_menu_tag = (trim(kGst_tab_menu_window[k_ctr].id)) then
// ECCEZIONI!!!!!				
				if k_menu_tag =  kkg_id_programma.dosimetria  & 
						or k_menu_tag =  kkg_id_programma.pilota_esporta_pl  then 
					if pos(kGst_tab_menu_window[k_ctr].funzioni,  "m") > 0 or pos(kGst_tab_menu_window[k_ctr].funzioni,  "M") > 0 &
								or pos(kGst_tab_menu_window[k_ctr].funzioni,  "v") > 0 or pos(kGst_tab_menu_window[k_ctr].funzioni,  "V") > 0  &
								or pos(kGst_tab_menu_window[k_ctr].funzioni,  "i") > 0 or pos(kGst_tab_menu_window[k_ctr].funzioni,  "I") > 0  then
						exit
					end if
				else
					exit
				end if
			end if
			k_ctr++
		loop
		
		if k_ctr <= k_ctr_idx then
		
			k_return = true
		
		end if
	end if


return k_return

end function

public subroutine autorizza_menu (ref m_main kmenu_main);//

//	kmenu_main.m_archivi.m_fatture.MenuImage = kg_path_risorse + "\Menu_Fatt.ico"

//--- abilito/disabilito menu FILE
 	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_esportapassword.tag) then
		kmenu_main.m_file.m_utility.m_importapassword.enabled = true
		kmenu_main.m_file.m_utility.m_esportapassword.enabled = true
	else
		kmenu_main.m_file.m_utility.m_importapassword.enabled = false
		kmenu_main.m_file.m_utility.m_esportapassword.enabled = false
	end if

//--- abilito/disabilito menu UTULITY
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_ottimizzadb.m_creaview.tag) then
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_creaview.enabled = true
	else
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_creaview.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_ottimizzadb.m_chiudelottiaperti.tag) then
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_chiudelottiaperti.enabled = true
	else
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_chiudelottiaperti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_ottimizzadb.m_generaprezzimensili.tag) then
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_generaprezzimensili.enabled = true
	else
		kmenu_main.m_file.m_utility.m_ottimizzadb.m_generaprezzimensili.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_popolat_contr.tag) then
		kmenu_main.m_file.m_utility.m_popolat_contr.enabled = true
	else
		kmenu_main.m_file.m_utility.m_popolat_contr.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_sistemaricevute.tag) then
		kmenu_main.m_file.m_utility.m_sistemaricevute.enabled = true
	else
		kmenu_main.m_file.m_utility.m_sistemaricevute.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_file.m_utility.m_ufo.tag) then
		kmenu_main.m_file.m_utility.m_ufo.enabled = true
	else
		kmenu_main.m_file.m_utility.m_ufo.enabled = false
	end if

//--- abilito/disabilito menu MAGAZZINO
	if autorizza_menu_1(kmenu_main.m_magazzino.m_mag_navigatore.tag) then
		kmenu_main.m_magazzino.m_mag_navigatore.enabled = true
	else
		kmenu_main.m_magazzino.m_mag_navigatore.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_marketing.tag) then
		kmenu_main.m_magazzino.m_marketing.enabled = true
	else
		kmenu_main.m_magazzino.m_marketing.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_lotti.tag) then
		kmenu_main.m_magazzino.m_lotti.enabled = true
	else
		kmenu_main.m_magazzino.m_lotti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_groupage.tag) then
		kmenu_main.m_magazzino.m_groupage.enabled = true
	else
		kmenu_main.m_magazzino.m_groupage.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni1.tag) then
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni1.enabled = true
	else
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni1.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni2.tag) then
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni2.enabled = true
	else
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni2.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni3.tag) then
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni3.enabled = true
	else
		kmenu_main.m_magazzino.m_convalidalavorazioni.m_convalidalavorazioni3.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_pianidilavorazione.tag) then
		kmenu_main.m_magazzino.m_pianidilavorazione.enabled = true 
	else
		kmenu_main.m_magazzino.m_pianidilavorazione.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_attestati.tag) then
		kmenu_main.m_magazzino.m_attestati.enabled = true
	else
		kmenu_main.m_magazzino.m_attestati.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_spedizioni.tag) then
		kmenu_main.m_magazzino.m_spedizioni.enabled = true
	else
		kmenu_main.m_magazzino.m_spedizioni.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_stampaspedizioni.tag) then
		kmenu_main.m_magazzino.m_stampaspedizioni.enabled = true
	else
		kmenu_main.m_magazzino.m_stampaspedizioni.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_fatture.tag) then
		kmenu_main.m_magazzino.m_fatture.enabled = true
	else
		kmenu_main.m_magazzino.m_fatture.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_stampafatture.tag) then
		kmenu_main.m_magazzino.m_stampafatture.enabled = true 
	else
		kmenu_main.m_magazzino.m_stampafatture.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_scadenzario.tag) then
		kmenu_main.m_magazzino.m_scadenzario.enabled = true
	else
		kmenu_main.m_magazzino.m_scadenzario.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_email.tag) then
		kmenu_main.m_magazzino.m_email.enabled = true
	else
		kmenu_main.m_magazzino.m_email.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_esportadocumenti.tag) then
		kmenu_main.m_magazzino.m_esportadocumenti.enabled = true
	else
		kmenu_main.m_magazzino.m_esportadocumenti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_barcodedosimetro.tag) then
		kmenu_main.m_magazzino.m_barcodedosimetro.enabled = true
	else
		kmenu_main.m_magazzino.m_barcodedosimetro.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_convalidalavorazioni.tag) then
		kmenu_main.m_magazzino.m_convalidalavorazioni.enabled = true
	else
		kmenu_main.m_magazzino.m_convalidalavorazioni.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_barcodemanuale.tag) then
		kmenu_main.m_magazzino.m_barcodemanuale.enabled = true
	else
		kmenu_main.m_magazzino.m_barcodemanuale.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_inviapianoalpilota.tag) then
		kmenu_main.m_magazzino.m_inviapianoalpilota.enabled = true
	else
		kmenu_main.m_magazzino.m_inviapianoalpilota.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_importalavorazioni.tag) then
		kmenu_main.m_magazzino.m_importalavorazioni.enabled = true
	else
		kmenu_main.m_magazzino.m_importalavorazioni.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_magazzino.m_modificaprogrammazione.tag) then
		kmenu_main.m_magazzino.m_modificaprogrammazione.enabled = true
	else
		kmenu_main.m_magazzino.m_modificaprogrammazione.enabled = false
	end if


//--- abilito/disabilito menu STATISTICI
	if autorizza_menu_1(kmenu_main.m_stat.m_st_fatt.tag) or autorizza_menu_1(kmenu_main.m_stat.m_st_produz.tag) or autorizza_menu_1(kmenu_main.m_stat.m_st_inventario.tag ) then
		kmenu_main.m_stat.enabled = true
	else
		kmenu_main.m_stat.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_stat.m_st_fatt.tag) then
		kmenu_main.m_stat.m_st_fatt.enabled = true
	else
		kmenu_main.m_stat.m_st_fatt.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_stat.m_st_produz.tag) then
		kmenu_main.m_stat.m_st_produz.enabled = true
	else
		kmenu_main.m_stat.m_st_produz.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_stat.m_st_inventario.tag ) then
		kmenu_main.m_stat.m_st_inventario.enabled = true
	else
		kmenu_main.m_stat.m_st_inventario.enabled = false
	end if

//--- abilito/disabilito menu Interrogazioni
	if autorizza_menu_1(kmenu_main.m_interrogazioni.m_movimenti.tag) then
		kmenu_main.m_interrogazioni.m_movimenti.enabled = true
	else
		kmenu_main.m_interrogazioni.m_movimenti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_interrogazioni.m_report.tag) then
		kmenu_main.m_interrogazioni.m_report.enabled = true
	else
		kmenu_main.m_interrogazioni.m_report.enabled = false
	end if
	

//--- abilito/disabilito menu ARCHIVI
	if autorizza_menu_1(kmenu_main.m_archivi.m_anagrafiche.tag) then
		kmenu_main.m_archivi.m_anagrafiche.enabled = true
	else
		kmenu_main.m_archivi.m_anagrafiche.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_anagrafiche.m_lista_anag.tag) then
		kmenu_main.m_archivi.m_anagrafiche.m_lista_anag.enabled = true
	else
		kmenu_main.m_archivi.m_anagrafiche.m_lista_anag.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_anagrafiche.m_lista_mandanti.tag) then
		kmenu_main.m_archivi.m_anagrafiche.m_lista_mandanti.enabled = true
	else
		kmenu_main.m_archivi.m_anagrafiche.m_lista_mandanti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_anagrafiche.m_lista_riceventi.tag) then
		kmenu_main.m_archivi.m_anagrafiche.m_lista_riceventi.enabled = true
	else
		kmenu_main.m_archivi.m_anagrafiche.m_lista_riceventi.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_anagrafiche.m_lista_fatturati.tag) then
		kmenu_main.m_archivi.m_anagrafiche.m_lista_fatturati.enabled = true
	else
		kmenu_main.m_archivi.m_anagrafiche.m_lista_fatturati.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_articoli.tag) then
		kmenu_main.m_archivi.m_articoli.enabled = true
	else
		kmenu_main.m_archivi.m_articoli.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_sd_md.tag) then
		kmenu_main.m_archivi.m_sd_md.enabled = true
	else
		kmenu_main.m_archivi.m_sd_md.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_contodeposito.tag) then
		kmenu_main.m_archivi.m_contodeposito.enabled = true
	else
		kmenu_main.m_archivi.m_contodeposito.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_ct_rd_l.tag) then
		kmenu_main.m_archivi.m_ct_rd_l.enabled = true
	else
		kmenu_main.m_archivi.m_ct_rd_l.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_commerciale.tag) then
		kmenu_main.m_archivi.m_commerciale.enabled = true
	else
		kmenu_main.m_archivi.m_commerciale.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_listino.tag) then
		kmenu_main.m_archivi.m_listino.enabled = true
	else
		kmenu_main.m_archivi.m_listino.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_gruppilistino.tag) then
		kmenu_main.m_archivi.m_gruppilistino.enabled = true
	else
		kmenu_main.m_archivi.m_gruppilistino.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_vocilistino.tag) then
		kmenu_main.m_archivi.m_vocilistino.enabled = true
	else
		kmenu_main.m_archivi.m_vocilistino.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_capitolati.tag) then
		kmenu_main.m_archivi.m_capitolati.enabled = true
	else
		kmenu_main.m_archivi.m_capitolati.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_contratti.tag) then
		kmenu_main.m_archivi.m_contratti.enabled = true
	else
		kmenu_main.m_archivi.m_contratti.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_sl_pt.tag) then
		kmenu_main.m_archivi.m_sl_pt.enabled = true
	else
		kmenu_main.m_archivi.m_sl_pt.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_websmart.tag) then
		kmenu_main.m_archivi.m_websmart.enabled = true
	else
		kmenu_main.m_archivi.m_websmart.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_sicurezza.tag) then
		kmenu_main.m_archivi.m_sicurezza.enabled = true
	else
		kmenu_main.m_archivi.m_sicurezza.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_vettori.tag) then
		kmenu_main.m_archivi.m_vettori.enabled = true
	else
		kmenu_main.m_archivi.m_vettori.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_profis.tag) then
		kmenu_main.m_archivi.m_profis.enabled = true
	else
		kmenu_main.m_archivi.m_profis.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_crm.tag) then
		kmenu_main.m_archivi.m_crm.enabled = true
	else
		kmenu_main.m_archivi.m_crm.enabled = false
	end if
//	if autorizza_menu_1(kmenu_main.m_archivi.m_ausiliari0.m_ausiliari_1.tag) then
//		kmenu_main.m_archivi.m_ausiliari0.m_ausiliari_1.enabled = true
//	else
//		kmenu_main.m_archivi.m_ausiliari0.m_ausiliari_1.enabled = false
//	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_opf.m_opf_gestione.tag) then
		kmenu_main.m_archivi.m_opf.m_opf_gestione.enabled = true
	else
		kmenu_main.m_archivi.m_opf.m_opf_gestione.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_opf.m_opf_elenco.tag) then
		kmenu_main.m_archivi.m_opf.m_opf_elenco.enabled = true
	else
		kmenu_main.m_archivi.m_opf.m_opf_elenco.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_opf.m_opf_gestore_eventi.tag) then
		kmenu_main.m_archivi.m_opf.m_opf_gestore_eventi.enabled = true
	else
		kmenu_main.m_archivi.m_opf.m_opf_gestore_eventi.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_codabarre.tag) then
		kmenu_main.m_archivi.m_codabarre.enabled = true
	else
		kmenu_main.m_archivi.m_codabarre.enabled = false
	end if
	if autorizza_menu_1(kmenu_main.m_archivi.m_memo.tag) then
		kmenu_main.m_archivi.m_memo.enabled = true
	else
		kmenu_main.m_archivi.m_memo.enabled = false
	end if
	
	
	if kmenu_main.parentwindow.windowtype = mdi! then
		kmenu_main.m_finestra.m_disponi.enabled = false
		kmenu_main.m_finestra.m_chiudifinestra.enabled = false
	else
		kmenu_main.m_finestra.m_disponi.enabled = true
		kmenu_main.m_finestra.m_chiudifinestra.enabled = true
	end if
	
	
		
//

end subroutine

private subroutine open_run_batch (st_open_w kst_open_w) throws uo_exception;//---
//--- Lancio operazioni Batch
//---

kuf_sv_skedula kuf1_sv_skedula




		try
			
			
			kuf1_sv_skedula = create kuf_sv_skedula 
			
//--- lancia eventi da schedulatore			
			kuf1_sv_skedula.run_eventi_sched(kst_open_w)
			
			
			destroy kuf1_sv_skedula
			

		catch (uo_exception kuo_exception)
		
		
		finally
			
			if isvalid(	kuf1_sv_skedula) then destroy kuf1_sv_skedula
			
		
		end try
		

end subroutine

public function integer set_tab_menu_window ();//
//--- Memorizzo in una array di memoria l'intero menu abilitato x l'utente, se MASTER invece carico tutte
//--- le voci
//
string k_codice, k_cursore
integer k_ctr=0, k_ctr_prec=0
string k_utente
long k_id_utente
st_esito kst_esito
st_tab_menu_window kst_tab_menu_window[]
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti
datastore kds_get_sr_settore


kds_get_sr_settore = create datastore
kds_get_sr_settore.dataobject = "ds_get_sr_settore"
kds_get_sr_settore.settransobject( kguo_sqlca_db_magazzino )

//--- Carica la tabella Menu + Oggetti 
set_tab_menu_window_oggetti()

//--- Inizializza SICUREZZA: le abilitazioni alle funzioni
kGst_tab_menu_window[] = kst_tab_menu_window[]

k_id_utente = kguo_utente.get_id_utente() 
k_utente = upper(trim(kguo_utente.get_codice()))
choose case k_utente
		
	case '*VUOTO*'   // solo x l'utente che accede inizialmente: AGGIUNGERE A MANO LE FUNZIONI NECESSARIO 
		k_cursore = &
			" select " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + &
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(menu_window.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			" from  " + &
			"   menu_window " + &
			" where  menu_window.id in ('srpassword_c') " + &
			" order by menu_window.id  " 
			
	case 'MASTER'  // utenti mio per avere tutto Autorizzzato
		k_cursore = &
			" select " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + &
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(menu_window.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			" from  " + &
			"   menu_window " + &
			" order by menu_window.id  " 
			
	case else
		k_cursore = &
			" select " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + &
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(sr_funzioni.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			" from  " + &
			" sr_utenti inner join sr_prof_utenti on " + &
			"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
			"			      inner join sr_prof_funz on " + &
			"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
			"               inner join sr_profili on  " + &
			"    sr_prof_funz.id_profili = sr_profili.id " + &
			"               inner join sr_funzioni on  " + &
			"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
			"               inner join menu_window on  " + &
			"    sr_funzioni.id_programma = menu_window.id " + &
			" where  " + &
			"    ( upper(sr_utenti.codice) = '" + k_utente + "' " + &
			"	  and sr_utenti.stato = '0' " + &
			"	  and sr_profili.stato = '0' ) " + &
			" order by menu_window.id  " 
end choose


//prepare :k_cursore
declare kc_menu_window dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

	k_ctr=1 
	kGst_tab_menu_window[k_ctr].id = " "
	fetch	kc_menu_window
			 into :kGst_tab_menu_window[k_ctr].id,
					:kGst_tab_menu_window[k_ctr].window,
					:kGst_tab_menu_window[k_ctr].istanze,
					:kGst_tab_menu_window[k_ctr].salva_size,
					:kGst_tab_menu_window[k_ctr].salva_controlli,
					:kGst_tab_menu_window[k_ctr].min_w_prec,  
					:kGst_tab_menu_window[k_ctr].titolo,  
					:kGst_tab_menu_window[k_ctr].funzioni,  
					:kGst_tab_menu_window[k_ctr].batch,  
					:kGst_tab_menu_window[k_ctr].msg_se_gia_open,  
					:kGst_tab_menu_window[k_ctr].primopiano  
					;
	k_ctr++
	
	do while sqlca.sqlcode = 0 
		
//--- rintraccia il settore 'prevalente' x questo funzione e utente		
		kGst_tab_menu_window[k_ctr].sr_settore = ""
//		if k_id_utente > 0 then
			kds_get_sr_settore.retrieve(k_id_utente, kGst_tab_menu_window[k_ctr].id)
			if kds_get_sr_settore.rowcount() > 0 then
				kGst_tab_menu_window[k_ctr].sr_settore = kds_get_sr_settore.getitemstring( 1, "sr_settore")
			end if
//		end if

//--- get del nome Oggetto (kuf_....)		
		kst_tab_menu_window_oggetti.id_menu_window = kGst_tab_menu_window[k_ctr].id
		kst_tab_menu_window_oggetti.funzione = ""
		if get_nome_oggetto_da_window_oggetti(kst_tab_menu_window_oggetti) then
			kGst_tab_menu_window[k_ctr].nome_oggetto = kst_tab_menu_window_oggetti.nome_oggetto
		else
			kGst_tab_menu_window[k_ctr].nome_oggetto = ""
		end if
		
//--- raggruppa le funzioni in una unica voce
		if k_ctr_prec > 0 then
			if kGst_tab_menu_window[k_ctr].id = kGst_tab_menu_window[k_ctr_prec].id and k_ctr_prec > 0 then
			
				kGst_tab_menu_window[k_ctr_prec].funzioni += trim(kGst_tab_menu_window[k_ctr].funzioni) 
			else
				
				k_ctr_prec++
				k_ctr = k_ctr_prec + 1
				kGst_tab_menu_window[k_ctr].id = " "
			end if
		else
//--- giro solo di prima volta			
			k_ctr_prec = 1
			k_ctr = 2
			kGst_tab_menu_window[k_ctr].id = " "
		end if

		if isnull(kGst_tab_menu_window[k_ctr_prec].primopiano) then
			kGst_tab_menu_window[k_ctr_prec].primopiano = "N"
		end if

//--- Utente speciale allora abilito Tutte le Funzioni
		if k_utente = 'MASTER' then
			kGst_tab_menu_window[k_ctr_prec].funzioni = kkg_flag_modalita_anteprima &
													  + kkg_flag_modalita_cancellazione &
													  + kkg_flag_modalita_chiudi_pl &
													  + kkg_flag_modalita_elenco &
													  + kkg_flag_modalita_inserimento &
													  + kkg_flag_modalita_interrogazione &
													  + kkg_flag_modalita_modifica &
													  + kkg_flag_modalita_navigatore &
													  + kkg_flag_modalita_stampa &
													  + kkg_flag_modalita_visualizzazione
		end if


		fetch	kc_menu_window
			 into :kGst_tab_menu_window[k_ctr].id,
					:kGst_tab_menu_window[k_ctr].window,
					:kGst_tab_menu_window[k_ctr].istanze,
					:kGst_tab_menu_window[k_ctr].salva_size,
					:kGst_tab_menu_window[k_ctr].salva_controlli,
					:kGst_tab_menu_window[k_ctr].min_w_prec, 
					:kGst_tab_menu_window[k_ctr].titolo,  
					:kGst_tab_menu_window[k_ctr].funzioni,  
					:kGst_tab_menu_window[k_ctr].batch,  
					:kGst_tab_menu_window[k_ctr].msg_se_gia_open,  
					:kGst_tab_menu_window[k_ctr].primopiano  
					;
	loop

	close kc_menu_window;

	k_ctr = k_ctr - 1	

//--- Carica la tabella  "Anteprime+id campo tabella"  x chiamare le funzioni dallo zoom
	if k_ctr > 0 then
		set_tab_menu_window_anteprima()
	end if

else
	
	kst_esito.esito = "1"
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella SICUREZZA funzione 'SELECT_ALL' in 'kuf_menu_window' " + &
									"Dbms.: " + trim(sqlca.dbparm) + "; " + &
						         " " + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kuf1_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_ctr

end function

public subroutine set_icone (ref m_main kmenu_main);//
//--- imposta ICONE
//
//kmenu_main.m_magazzino.m_fatture.MenuImage	 = kg_path_risorse + "\fattura8x8.gif"
//kmenu_main.m_magazzino.m_stampafatture.menuimage = kg_path_risorse + "\printer16x16.gif"
//kmenu_main.m_archivi.m_sicurezza.menuimage = kg_path_risorse + "\sicurezza16x16.gif"

kmenu_main.m_magazzino.m_fatture.MenuImage = "fattura8x8.gif"
kmenu_main.m_magazzino.m_stampafatture.menuimage = "printer16x16.gif"
kmenu_main.m_archivi.m_sicurezza.menuimage = "sicurezza16x16.gif"


end subroutine

public function string open_w_tabelle (st_open_w kst_open_w);//
//=== Apertura delle Window_Tabelle
string k_return="0"
string k_w_name, k_sn
int k_ctr, k_ctr_idx, k_rc
boolean k_boolean, k_open_window
st_esito kst_esito
pointer kpointer_orig
w_super kw_window 
w_super kw_window_open, kw_window_attiva
kuf_utility kuf1_utility


//-------------------------------------------------------------------------------------------------
//=== Struttura di Input:
//--- st_open_w.id_programma = identificativo programma da lanciare
//--- st_open_w.id_programma_chiamante = identificativo programma Chiamante
//--- st_open_w.nome_oggetto = qui cerca di reperire il nome del user-object qual ad esempio 'kuf_clienti'
//--- st_open_w.sr_settore = settore prevalente x utente e funzione chiamata
//--- st_open_w.flag_primo_giro = S=finestra appena aperta
//--- st_open_w.flag_modalita = mod.operat: in=inserim; mo=modif.; ca=cancell.; vi=visual.; ecc....
//--- st_open_w.flag_utente_autorizzato = true utente autorizzato  
//--- st_open_w.flag_adatta_win = KK_ADATTA_WIN_NO/SI
//--- st_open_w.flag_leggi_dw = S=leggi su open;
//--- st_open_w.flag_cerca_in_lista = 1=?????;
//--- st_open_w.key1_9 = chiave di ricerca
//--- st_open_w.key10_window_chiamante = RISERVATA X riferimento alla window chiamante
//--- st_open
//--- st_open_w.campo_where = query 
//-------------------------------------------------------------------------------------------------

try

	kpointer_orig = setpointer(hourglass!)
	
	k_open_window = true
	
	//--- toglie i NULL dai dati
	if_isnull(kst_open_w)
	
	k_ctr = 1
	k_ctr_idx = UpperBound(kGst_tab_menu_window[])
	do while k_ctr <= k_ctr_idx 
		if trim(kst_open_w.id_programma) = trim(kGst_tab_menu_window[k_ctr].id) then
			exit
		end if
		k_ctr++
	loop
	
	if k_ctr <= k_ctr_idx then
	
		connetti( )  // connessioni DB
		
		if LenA(trim(kGst_tab_menu_window[k_ctr].titolo)) > 0 then
			kst_open_w.window_title = trim(kGst_tab_menu_window[k_ctr].titolo)
		else
			kst_open_w.window_title = " "
		end if
		kst_open_w.sr_settore = kGst_tab_menu_window[k_ctr].sr_settore  // imposta il settore prevalente x funzione e utente
	
//---- get del nome dell'oggetto kuf_....	
		kst_open_w.nome_oggetto = get_nome_oggetto(kst_open_w.id_programma) 

		if autorizza_funzione(kst_open_w) then
		
			kst_open_w.flag_utente_autorizzato = true 
			
	//--- se sto aprendo una windows....
			if LenA(trim(kGst_tab_menu_window[k_ctr].window)) > 1 then
	
	//--- se window gia' aperta chiedo cosa fare
				kw_window = kguo_g.get_window_aperta(trim(kGst_tab_menu_window[k_ctr].window))
//				kw_window = prendi_win_uguale(trim(kGst_tab_menu_window[k_ctr].window))
//					if kw_window.ClassName( ) = trim(kGst_tab_menu_window[k_ctr].window) then

				if isvalid(kw_window) then

						if kGst_tab_menu_window[k_ctr].istanze < 2 then // se posso aprire solo un istanza allora...
							
							k_open_window = false
						else
							kw_window.SetFocus()   // Fuoco sulla window già aperta
							if upper(kGst_tab_menu_window[k_ctr].msg_se_gia_open) = kki_msg_se_gia_open_esponi then
								k_rc = messagebox( "Funzione già aperta", "Premere 'SI' per aprire una nuova finestra, per rimanere su questa premere 'No' ", question!, yesno!, 2 )
								if k_rc = 2 then
									k_open_window = false
								end if
							else
								if upper(kGst_tab_menu_window[k_ctr].msg_se_gia_open) = kki_msg_se_gia_open_riOpen then
									
									k_open_window = false
									try
										kw_window.u_riopen(kst_open_w) 
									catch (uo_exception kuo2_exception)
										kuo2_exception.messaggio_utente()
									end try
									
								end if
							end if
						end if
//					end if
				end if
//			else
//				
//	//--- lancio fase BATCH...			
//				try
//					batch_lancio(kst_open_w)
//				catch (uo_exception kuo_exception)
//				end try
	
			end if
			
//--- Se la Window deve essere aperta allora....		
			if k_open_window then
					
				kst_open_w.window =  trim(kGst_tab_menu_window[k_ctr].window)
				if kst_open_w.window > " " then  
		
					if isvalid(w_main) and kGst_tab_menu_window[k_ctr].primopiano <> "S"  then
	
//--- recupera il riferimento alla windows chiamante
						if len(trim(kst_open_w.id_programma_chiamante)) > 0 then
						else
							setnull(kst_open_w.key10_window_chiamante)
							kst_open_w.id_programma_chiamante = ""
							kw_window_attiva=kuf1_data_base.prendi_win_attiva()
							if isvalid(kw_window_attiva) and not isnull(kw_window_attiva) then
								kst_open_w.key10_window_chiamante = kw_window_attiva
								kst_open_w.id_programma_chiamante = trim(kw_window_attiva.get_id_programma())
							end if
						end if

//--- APRO LA WINDOW STANDARD
						kguo_g.kGst_open_w = kst_open_w
						k_return = string(OpenSheetWithParm(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, w_main, 5, original!), "0")

					else
//--- APRO LA WINDOW MODALE O SENZA MDI
						kguo_g.kGst_open_w = kst_open_w
						k_return = string(OpenWithParm(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window), "0")
					end if
// OBSOLETO --------------------------------------------------------------------------------												
//					if integer(k_return) > 0 then
//--- Se richiesto: Minimizzo la window attiva:   OBSOLETO
//						if isvalid(kw_window_open) then
//							k_w_name = kw_window_open.ClassName( )
//							if k_w_name <> trim(kGst_tab_menu_window[k_ctr].window) then
//		//							kw_window.windowstate = minimized!
//								end if
//							else
//		//=== Se sto aprendo una finestra uguale le 'arrangio'
//	//							w_main.ArrangeSheets(cascade!)
//							end if
//						end if
//					end if
//----------------------------------------------------------------------------------------------	
	
				else
//--- Se manca il nome della Window probabilemente è un programma lanciato in modalita' batch...	
					if trim(kGst_tab_menu_window[k_ctr].batch ) = "S" then
						try 
							
							open_run_batch(kst_open_w)    // LANCIO FUNZIONE BATCH
							
						catch (uo_exception kuo1_exception)
							
						end try
					end if
				end if
	
			end if
//250913			kw_window_open.show( )
	
			if integer(k_return) > 0 then
	
	//=== Suona Motivo di attivazione programma
				if kst_open_w.flag_modalita = kkg_flag_modalita_inserimento &
					or kst_open_w.flag_modalita = kkg_flag_modalita_modifica &
					then
					kuf1_data_base.post suona_motivo(kkg_suona_motivo_Open_w, 0)
				else
					if kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione &
						then
						kuf1_data_base.post suona_motivo(kkg_suona_motivo_open_w_x_canc, 0)
					else
						kuf1_data_base.post suona_motivo(kkg_suona_motivo_open_w_x_agg, 0)
					end if
				end if
			end if
		
		else
			kguo_exception.inizializza( )
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta (" + trim(kst_open_w.id_programma) + ") non e' stata Autorizzata")
		end if
	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Operazione Interrotta", "La funzione richiesta (" + trim(kst_open_w.id_programma) + ") non e' stata Abilitata")
	
	end if


catch (uo_exception kuo3_exception)
		kst_esito = kuo3_exception.get_st_esito()
		kuo3_exception.messaggio_utente("Operazione Interrotta", "Non è stato possibile aprire l'operazione di '" + trim(kst_open_w.id_programma) + "'. ~n~r" + trim(kst_esito.sqlerrtext ) )
		
	
	
finally
	autorizza_menu( kG_menu )    //illumina solo le voci di menu abilitate

	setpointer(kpointer_orig)

end try


return k_return

end function

private function boolean set_tab_menu_window_oggetti ();//
//--- Memorizzo in una array di memoria l'intera tabella menu + Oggetti compattandola
//--- le voci
//
boolean k_return=false
string k_codice, k_cursore
integer k_ctr=0 //, k_ctr_prec=0
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti
st_esito kst_esito



if upper(kguo_utente.get_codice()) = 'MASTER' then

	k_cursore = &
		" select " + &
		"   id, " + &
		"	 nome_oggetto, " + &
		"    funzione, " +  &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_oggetti " + &
		" order by nome_oggetto, id_menu_window  " 
else	
	k_cursore = &
		" select " + &
		"   id, " + &
		"	 nome_oggetto, " + &
		"    funzione, " +  &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_oggetti " + &
	   " where  id_menu_window in ( " + &
		" select " + &
		"   menu_window.id " + &
		" from  " + &
	   " sr_utenti inner join sr_prof_utenti on " + &
		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
		"			      inner join sr_prof_funz on " + &
		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
		"               inner join sr_profili on  " + &
		"    sr_prof_funz.id_profili = sr_profili.id " + &
		"               inner join sr_funzioni on  " + &
		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
		"               inner join menu_window on  " + &
		"    sr_funzioni.id_programma = menu_window.id " + &
	   " where  " + &
		"    ( upper(sr_utenti.codice) = '" + trim(kguo_utente.get_codice()) + "' " + &
		"	  and sr_utenti.stato = '0' " + &
		"	  and sr_profili.stato = '0' ) " + &
		"	 ) " + &
		" order by nome_oggetto, id_menu_window  " 
end if	

//prepare :k_cursore
declare kc_menu_window dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

	k_ctr=1 
	kist_tab_menu_window_oggetti[k_ctr] = kst_tab_menu_window_oggetti
	kist_tab_menu_window_oggetti[k_ctr].id = 0
	
	fetch	kc_menu_window
			 into :kst_tab_menu_window_oggetti.id,
					:kst_tab_menu_window_oggetti.nome_oggetto,
					:kst_tab_menu_window_oggetti.funzione,
					:kst_tab_menu_window_oggetti.id_menu_window
					;
	
	do while sqlca.sqlcode = 0 
		
//--- raggruppa le funzioni in una unica voce ad esempio clienti con "in" "mo" "vi" che chiamano lo stesso programma  nel campo funzioni avro' "+in+mo+vi"

		if trim(kst_tab_menu_window_oggetti.nome_oggetto) = trim(kist_tab_menu_window_oggetti[k_ctr].nome_oggetto) &
					 and trim(kst_tab_menu_window_oggetti.id_menu_window) = trim(kist_tab_menu_window_oggetti[k_ctr].id_menu_window) then

//--- Esplode funzioni 
			kist_tab_menu_window_oggetti[k_ctr].funzione += u_esplode_funzione(trim(kst_tab_menu_window_oggetti.funzione))
			
		else
				
			k_ctr++
			kist_tab_menu_window_oggetti[k_ctr] = kst_tab_menu_window_oggetti
//--- Esplode funzioni 
			kist_tab_menu_window_oggetti[k_ctr].funzione = u_esplode_funzione(trim(kst_tab_menu_window_oggetti.funzione))

		end if

		fetch	kc_menu_window
			 into :kst_tab_menu_window_oggetti.id,
					:kst_tab_menu_window_oggetti.nome_oggetto,
					:kst_tab_menu_window_oggetti.funzione,
					:kst_tab_menu_window_oggetti.id_menu_window
					;
	loop
	
	close kc_menu_window;
	
	//k_ctr = k_ctr - 1	

else
	
	kst_esito.esito = "1"
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella SICUREZZA funzione 'SELECT_ALL' in 'kuf_menu_window.set_tab_menu_window_oggetti' " + &
									"Dbms.: " + trim(sqlca.dbparm) + "; " + &
						         " " + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kuf1_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_return

end function

public function boolean get_id_menu_window (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti);//
//--- Trova il ID_PROGRAMMA 
//--- inp: nome_oggetto, funzione
//--- out: id_menu_window (che e' l'id del programma)
//
boolean k_return=false
integer k_ctr=0, k_pos=0


	k_ctr++
	k_pos = 0
	do while upperbound(kist_tab_menu_window_oggetti[]) >= k_ctr and k_pos = 0 
		
		if kist_tab_menu_window_oggetti[k_ctr].id > 0 then
			if trim(kist_tab_menu_window_oggetti[k_ctr].nome_oggetto) = trim(kst_tab_menu_window_oggetti.nome_oggetto) then
				
				k_pos = pos(trim(kist_tab_menu_window_oggetti[k_ctr].funzione), trim(kst_tab_menu_window_oggetti.funzione), 1) 
				
			end if
		end if
		k_ctr++				
		
	loop
	if k_pos > 0 then
		k_return=true	
		kst_tab_menu_window_oggetti.id_menu_window = trim(kist_tab_menu_window_oggetti[k_ctr - 1].id_menu_window)
	end if
	
	
	
return k_return

end function

public function boolean batch_lancio (st_open_w kst_open_w_par) throws uo_exception;//---------------------------------------------
//
//=== Lancia Funzioni BATCH
//
//--- Input: struttura kst_open_w
//---
//---   Lancia un ECCEZIONE se errore
//---------------------------------------------
boolean k_return
//st_esito kst_esito
//uo_exception kuo_exception
//kuf_pilota_cmd kuf1_pilota_cmd
//
//st_open_w kst_open_w
//
//
//kuo_exception = create uo_exception
//
//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//
//kst_open_w = kst_open_w_par
//kst_open_w.flag_modalita = KKG_FLAG_MODALITA_BATCH
//kst_open_w.id_programma = kkg_id_programma.sv_sked_oper_v
//
//if not autorizza_funzione(kst_open_w)  then
//	kst_esito.esito = kkg_esito.no_aut
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = "Funzione Non Autorizzata ("+   KKG_FLAG_MODALITA_BATCH +"):~n~r " + trim(kst_open_w.id_programma )
//	kuo_exception.set_esito(kst_esito)
//	throw kuo_exception
//else
//
//	choose case trim(kst_open_w.id_programma)
//			
//		case kkg_id_programma.pilota_esporta_pl
//			kuf1_pilota_cmd = create kuf_pilota_cmd
//			kuf1_pilota_cmd.job_pianificazione_lavorazioni() 
//			destroy kuf1_pilota_cmd
//			
////		case kkg_id_programma.pilota_esporta_pl
////			kuf1_wm_pklist = create kuf_wm_pklist
////			kuf1_wm_pklist.job_importa_wm_pklist_web() 
////			destroy kuf1_wm_pklist
//			
//		case kkg_id_programma.EXITM2000
//			w_main.postevent(close!)
//			
//		case else
//			kst_esito.esito = kkg_esito.blok
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Funzione Batch Non Prevista:~n~r " + kst_open_w.id_programma 
//			kuo_exception.set_esito(kst_esito)
//			throw kuo_exception
//			
//	end choose
//
//end if
//

return k_return

end function

private function string u_esplode_funzione (string k_funzione);//
//--- Esplode le funzioni di autorizzazione
//
string k_funzione_composta


//--- Se trovo i caratteri 'ivmc' s'intendono le funzioni di +in+vi+mo+ca posso aggiungere anche 'es' ovvero +el+st e anche 'a' ovvero +an
				choose case trim(k_funzione)
					case "ivmcesa", "*", "ivmcesab"   // tutte le funzioni
						k_funzione_composta = "+in+vi+mo+ca+el+st+an+qy+bt"
					case "*-el"   // tutte le funzioni escluso Elenco
						k_funzione_composta = "+in+vi+mo+ca+st+an+qy"
					case "*-bt"   // tutte le funzioni escluso Batch
						k_funzione_composta =  "+in+vi+mo+ca+el+st+an+qy"
					case "vm"   // gestione parziale no a inserimento, cancellazione 
						k_funzione_composta = "+vi+mo"
					case "vmc"   // gestione parziale non inserimento
						k_funzione_composta = "+vi+mo+ca"
					case "ivmc"   // l'ntera gestione
						k_funzione_composta = "+in+vi+mo+ca"
					case "ivmce"   // l'ntera gestione + elenco
						k_funzione_composta = "+in+vi+mo+ca+el"
					case "es"   // solo elenco e stampa
						k_funzione_composta = "+el+st+qy"
					case "esa"   // solo elenco e stampa e anteprima
						k_funzione_composta = "+el+st+an+qy"
					case "vesa"   // solo CONSULTAZIONE
						k_funzione_composta = "+el+st+an+vi+qy"
					case else // solo la funzione indicata
						k_funzione_composta = "+" + trim(k_funzione) 
				end choose


return k_funzione_composta
end function

public subroutine if_isnull (st_open_w ast_open_w);//---
//--- Toglie i valori a NULL

if isnull(ast_open_w.campo_where) then ast_open_w.campo_where = "" 
if isnull(ast_open_w.flag_adatta_win ) then ast_open_w.flag_adatta_win = "" 
if isnull(ast_open_w.flag_cerca_in_lista ) then ast_open_w.flag_cerca_in_lista = "" 
if isnull(ast_open_w.flag_leggi_dw ) then ast_open_w.flag_leggi_dw = "" 
if isnull(ast_open_w.flag_modalita ) then ast_open_w.flag_modalita = "" 
if isnull(ast_open_w.flag_primo_giro ) then ast_open_w.flag_primo_giro = "" 
//if isnull(ast_open_w.flag_utente_autorizzato ) then ast_open_w.flag_utente_autorizzato = "" 
if isnull(ast_open_w.flag_where ) then ast_open_w.flag_where = "" 
if isnull(ast_open_w.id_programma ) then ast_open_w.id_programma = "" 
if isnull(ast_open_w.id_programma_chiamante ) then ast_open_w.id_programma_chiamante = "" 
if isnull(ast_open_w.key1 ) then ast_open_w.key1 = "" 
//if isnull(ast_open_w.key10_window_chiamante ) then ast_open_w. = "" 
//f isnull(ast_open_w.key11_dw ) then ast_open_w. = "" 
//if isnull(ast_open_w.key12_any ) then ast_open_w. = "" 
if isnull(ast_open_w.key2 ) then ast_open_w.key2 = "" 
if isnull(ast_open_w.key3 ) then ast_open_w.key3 = "" 
if isnull(ast_open_w.key4 ) then ast_open_w.key4 = "" 
if isnull(ast_open_w.key5 ) then ast_open_w.key5 = "" 
if isnull(ast_open_w.key6 ) then ast_open_w.key6 = "" 
if isnull(ast_open_w.key7 ) then ast_open_w.key7 = "" 
if isnull(ast_open_w.key8 ) then ast_open_w.key8 = "" 
if isnull(ast_open_w.key9 ) then ast_open_w.key9 = "" 
if isnull(ast_open_w.window_title ) then ast_open_w.window_title = "" 

end subroutine

private function boolean connetti () throws uo_exception;//
boolean k_return = false


k_return = kguo_sqlca_db_magazzino.db_connetti( )

return k_return

end function

private function boolean set_tab_menu_window_anteprima ();//
//--- Memorizzo in una array di memoria l'intera tabella menu + Oggetti compattandola
//--- le voci
//
boolean k_return=false
string k_codice, k_cursore
integer k_ctr=0 //, k_ctr_prec=0
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if upper(kguo_utente.get_codice()) = 'MASTER' then

	k_cursore = &
		" select " + &
		"   id, " + &
		"	 anteprima, " + &
		"	 nome_id_tabella, " + &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_anteprima " + &
		" order by anteprima, id_menu_window  " 
else	
	k_cursore = &
		" select " + &
		"   id, " + &
		"	 anteprima, " + &
		"	 nome_id_tabella, " + &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_anteprima " + &
	   " where  id_menu_window in ( " + &
		" select " + &
		"   menu_window.id " + &
		" from  " + &
	   " sr_utenti inner join sr_prof_utenti on " + &
		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
		"			      inner join sr_prof_funz on " + &
		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
		"               inner join sr_profili on  " + &
		"    sr_prof_funz.id_profili = sr_profili.id " + &
		"               inner join sr_funzioni on  " + &
		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
		"               inner join menu_window on  " + &
		"    sr_funzioni.id_programma = menu_window.id " + &
	   " where  " + &
		"    ( upper(sr_utenti.codice) = '" + trim(kguo_utente.get_codice()) + "' " + &
		"	  and sr_utenti.stato = '0' " + &
		"	  and sr_profili.stato = '0' ) " + &
		"	 ) " + &
		" order by anteprima, id_menu_window  " 
end if	

//prepare :k_cursore
declare kc_menu_window_anteprima dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window_anteprima; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

//	k_ctr=1 
//	kgst_tab_menu_window_anteprima[k_ctr] = kst_tab_menu_window_anteprima
//	kgst_tab_menu_window_anteprima[k_ctr].id = 0
	
	fetch	kc_menu_window_anteprima
			 into :kst_tab_menu_window_anteprima.id,
					:kst_tab_menu_window_anteprima.anteprima,
					:kst_tab_menu_window_anteprima.nome_id_tabella,
					:kst_tab_menu_window_anteprima.id_menu_window
					;
	
	do while sqlca.sqlcode = 0 
		
		k_ctr++
		kgst_tab_menu_window_anteprima[k_ctr].id = kst_tab_menu_window_anteprima.id
		kgst_tab_menu_window_anteprima[k_ctr].anteprima = trim(kst_tab_menu_window_anteprima.anteprima)
		kgst_tab_menu_window_anteprima[k_ctr].nome_id_tabella = trim(kst_tab_menu_window_anteprima.nome_id_tabella)
		kgst_tab_menu_window_anteprima[k_ctr].id_menu_window = trim(kst_tab_menu_window_anteprima.id_menu_window)


		fetch	kc_menu_window_anteprima
			 into :kst_tab_menu_window_anteprima.id,
					:kst_tab_menu_window_anteprima.anteprima,
					:kst_tab_menu_window_anteprima.nome_id_tabella,
					:kst_tab_menu_window_anteprima.id_menu_window
					;
	loop
	
	close kc_menu_window_anteprima;
	
	k_ctr++
	kgst_tab_menu_window_anteprima[k_ctr].anteprima = "FINE"

else
	
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella 'menu_window_anteprima',  oggetto: " +  this.classname() + &
						         " ~n~r" + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kuf1_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_return

end function

public function boolean get_st_tab_menu_window_anteprima (ref st_tab_menu_window_anteprima ast_tab_menu_window_anteprima);//
//--- Trova i dati della tabella st_tab_menu_window_anteprima 
//--- inp: st_tab_menu_window_anteprima anteprima
//--- Out: st_tab_menu_window_anteprima.*
//--- Rit: true=anteprima trovata
//
boolean k_return = false
int k_ctr=1
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

ast_tab_menu_window_anteprima.anteprima = trim(ast_tab_menu_window_anteprima.anteprima)

do while kgst_tab_menu_window_anteprima[k_ctr].anteprima <> ast_tab_menu_window_anteprima.anteprima  and  kgst_tab_menu_window_anteprima[k_ctr].anteprima < ast_tab_menu_window_anteprima.anteprima &
			and kgst_tab_menu_window_anteprima[k_ctr].anteprima <> "FINE" and k_ctr < 100
	k_ctr ++
loop

if k_ctr = 99 then
	kst_esito.esito = kkg_esito.ko  
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = "Errore array 'Anteprime' superato il limite massimo = " + string(k_ctr)
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
else
	if kgst_tab_menu_window_anteprima[k_ctr].anteprima = ast_tab_menu_window_anteprima.anteprima  then
		k_return = true
		ast_tab_menu_window_anteprima = kgst_tab_menu_window_anteprima[k_ctr]  // OK TROVATO!!!!
	end if
end if


//  SELECT menu_window_anteprima.id,   
//         menu_window_anteprima.anteprima,   
//         menu_window_anteprima.nome_id_tabella,   
//         menu_window_anteprima.id_menu_window  
//    INTO :ast_tab_menu_window_anteprima.id,   
//         :ast_tab_menu_window_anteprima.anteprima,   
//         :ast_tab_menu_window_anteprima.nome_id_tabella,   
//         :ast_tab_menu_window_anteprima.id_menu_window  
//    FROM menu_window_anteprima  
//   WHERE menu_window_anteprima.anteprima = :ast_tab_menu_window_anteprima.anteprima   
//				using kguo_sqlca_db_magazzino;
//	
//	if kguo_sqlca_db_magazzino.sqlcode < 0 then
//		kst_esito.esito = kkg_esito.db_ko   // forse
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.sqlerrtext = "Errore tabella 'Anteprime' (menu_window_anteprima). id_menu_window=" + string(ast_tab_menu_window_anteprima.anteprima)
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//	end if
	
	
return k_return

end function

public function boolean open_w_tabelle_da_ds (datastore ads_dati_window, string a_modalita) throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Apre una window con la tab ANTEPRIMA 
//--- Input: datastore: con i dati del dw legge la tabella window_anteprima e apre la window corretta
//---		    modalita  cosi' come impostato in kkg_modalita.xxxxx es: kkg_flag_modalita.visualizzazione
//---
//-------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
st_open_w kst_open_w		
kuf_parent kuf1_parent

if ads_dati_window.rowcount( ) > 0 or a_modalita = kkg_flag_modalita.inserimento then

	kst_tab_menu_window_anteprima.anteprima = ads_dati_window.dataobject
	get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima)
	
	kst_open_w.id_programma = kst_tab_menu_window_anteprima.id_menu_window
	kst_open_w.flag_modalita = a_modalita 
	kst_open_w.key9 = kst_tab_menu_window_anteprima.nome_id_tabella
	kst_open_w.key11_ds = create datastore
	kst_open_w.key11_ds.dataobject = ads_dati_window.dataobject
	if a_modalita <> kkg_flag_modalita.inserimento then
		ads_dati_window.rowscopy( ads_dati_window.getrow( ) , ads_dati_window.getrow( ), primary!, kst_open_w.key11_ds, 1, primary!)
		kst_open_w.key11_ds.setrow(1)
	end if

//---- get del nome dell'oggetto kuf_....	
	kst_open_w.nome_oggetto = get_nome_oggetto(kst_open_w.id_programma) 
	if kst_open_w.nome_oggetto > " " then
		kuf1_parent = create using kst_open_w.nome_oggetto
		kuf1_parent.u_open_ds(kst_open_w)
		k_return=true
	end if
	
end if

return k_return
end function

public function boolean get_st_tab_menu_window (ref st_tab_menu_window k_st_tab);//
//--- Get delle Caratteristiche delle Window specifica
//--- torna la struttura valorizzata e 
//---      true = OK
//---      false = KO
//---
boolean k_return = false
long k_ctr, k_ctr_idx


k_st_tab.window =  trim(k_st_tab.window)
k_st_tab.id = ""

k_ctr_idx = UpperBound(kGst_tab_menu_window[])
for k_ctr = 1 to k_ctr_idx 
	if k_st_tab.window = trim(kGst_tab_menu_window[k_ctr].window) then

		k_st_tab.id = trim(kGst_tab_menu_window[k_ctr].id) 
		k_st_tab.window = trim(kGst_tab_menu_window[k_ctr].window)
		k_st_tab.istanze = (kGst_tab_menu_window[k_ctr].istanze)
		k_st_tab.funzioni = trim(kGst_tab_menu_window[k_ctr].funzioni)
		k_st_tab.salva_size = trim(kGst_tab_menu_window[k_ctr].salva_size)
		k_st_tab.salva_controlli = trim(kGst_tab_menu_window[k_ctr].salva_controlli)
		k_st_tab.min_w_prec = trim(kGst_tab_menu_window[k_ctr].min_w_prec) 
		k_st_tab.batch = trim(kGst_tab_menu_window[k_ctr].batch)		
		k_st_tab.msg_se_gia_open = trim(kGst_tab_menu_window[k_ctr].msg_se_gia_open)		
			
		k_return = true
		
		exit
	end if
end for


//
//	select id,
//			 window,
//			 istanze,
//			 funzioni,
//			 salva_size,
//			 min_w_prec 
//	 into :k_st_tab.id,
//			:k_st_tab.window,
//			:k_st_tab.istanze,
//			:k_st_tab.funzioni,
//			:k_st_tab.salva_size,
//			:k_st_tab.min_w_prec  
//		 from   
//	      menu_window inner join sr_funzioni on 
//		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
//		"			      inner join sr_prof_funz on " + &
//		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
//		"               inner join sr_profili on  " + &
//		"    sr_prof_funz.id_profili = sr_profili.id " + &
//		"               inner join sr_funzioni on  " + &
//		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
//		"               inner join menu_window on  " + &
//		"    sr_funzioni.id_programma = menu_window.id " + &
//	   " where  " + &
//		"    ( sr_utenti.codice = :kguo_utente.get_codice() " + &
//		"	  and sr_utenti.stato = '0' " + &
//		"	  and sr_profili.stato = '0' ) " + &
//			 
//		from menu_window
//		where window = :k_st_tab.window
//		using sqlca;
//
//
return k_return

end function

public function window prendi_win_uguale (string a_nome_win);//
//=== Torna oggetto window, la window con nome uguale a quello passato
//
string k_sn=" "
string k_nome_win_1 = ""
//long k_handle=0
window kw_window


if isvalid(w_main) then

	kw_window = w_main.getfirstsheet()

	if isvalid(kw_window) then

		a_nome_win = upper(trim(a_nome_win)) 
		
		do 

			if isvalid(kw_window) then

				k_nome_win_1 = upper(kw_window.ClassName( ))
				if k_nome_win_1 = a_nome_win then
					k_sn = "s"
				else
//					k_handle = handle(kw_window)	// salvo handle 			
					kw_window = w_main.getnextsheet(kw_window)
				end if
				
			else
				exit
			end if
		loop until k_sn = "s" //or handle(kw_window) = k_handle

		if not isvalid(kw_window) then  //or handle(kw_window) = k_handle then
			setnull(kw_window)
		end if
	end if
end if

return kw_window

end function

private function boolean u_open_funzione (st_open_w ast_open_w) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------------------
//--- Apre applicazione 
//---
//--- Inp: st_open_w  id_programma, flag_modalita, key9 = nome del campo chiave, key11_ds (datastore con la riga da aprire)
//--- Out: true=aperta,  false=non ha fatto nulla
//---
//---
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
boolean k_sicurezza = false 
long k_riga = 0
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti
kuf_parent kuf1_parent
kuf_armo_prezzi kuf1_armo_prezzi



ast_open_w.id_programma = trim(ast_open_w.id_programma)

if ast_open_w.id_programma > " " then
	
	kuf1_parent = create kuf_parent
	
	k_sicurezza = kuf1_parent.if_sicurezza(ast_open_w)
			
	
	if k_sicurezza then
		
		if ast_open_w.key9 > " " and ast_open_w.key11_ds.rowcount() > 0 then
			if ast_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
				k_riga = ast_open_w.key11_ds.getrow()
				if k_riga = 0 then k_riga = 1
				if left(ast_open_w.key11_ds.Describe( trim(ast_open_w.key9) + ".ColType"),4) = "char" then  //tipo di dato, alfanum o numerico?
					ast_open_w.key1 = ast_open_w.key11_ds.getitemstring(k_riga, trim(ast_open_w.key9))
				else
					ast_open_w.key1 = string(ast_open_w.key11_ds.getitemnumber(k_riga, trim(ast_open_w.key9)))
				end if
			end if
			if ast_open_w.key1 > " " or ast_open_w.flag_modalita = kkg_flag_modalita.inserimento then
				
				k_return = true
				
				ast_open_w.flag_primo_giro = "S"
		
				open_w_tabelle(ast_open_w)			// APRE APPLICAZIONE
				
			end if
		end if
		
	end if
end if


return k_return



end function

public function boolean get_nome_oggetto_da_window_oggetti (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti);//
//--- Trova il nome Oggetto che gestisce la Funzione del tipo 'KUF_CLIENTI'
//--- inp: id_menu_window, funzione ( se spazio piglia il primo Kuf_... per id )
//--- out: nome_oggetto 
//
boolean k_return=false
integer k_ctr=0, k_pos=0


	k_ctr++
	k_pos = 0
	do while upperbound(kist_tab_menu_window_oggetti[]) >= k_ctr and k_pos = 0 
		
		if kist_tab_menu_window_oggetti[k_ctr].id > 0 then
			if trim(kist_tab_menu_window_oggetti[k_ctr].id_menu_window) = trim(kst_tab_menu_window_oggetti.id_menu_window) then
				
				if trim(kst_tab_menu_window_oggetti.funzione) > " " then
					k_pos = pos(trim(kist_tab_menu_window_oggetti[k_ctr].funzione), trim(kst_tab_menu_window_oggetti.funzione), 1) 
				else
					k_pos = 1  //ESCO X OK!
				end if
				
			end if
		end if
		k_ctr++				
		
	loop
	if k_pos > 0 then
		k_return=true	
		kst_tab_menu_window_oggetti.nome_oggetto = trim(kist_tab_menu_window_oggetti[k_ctr - 1].nome_oggetto)
	end if
	
	
	
return k_return

end function

private function string get_nome_oggetto (string a_menu_id);//
//--- Trova il nome Oggetto es "kuf_clienti"
//--- inp: id
//--- rit: nome_oggetto 
//
string k_return = ""
long k_ctr, k_ctr_idx


	a_menu_id = lower(trim(a_menu_id))

	k_ctr = 1
	k_ctr_idx = UpperBound(kGst_tab_menu_window[])
	do while k_ctr <= k_ctr_idx 
		if a_menu_id = (trim(kGst_tab_menu_window[k_ctr].id)) then
			k_return = trim(kGst_tab_menu_window[k_ctr].nome_oggetto)
			exit
		end if
		k_ctr++
	loop
		
return k_return

end function

on kuf_menu_window.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_menu_window.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

