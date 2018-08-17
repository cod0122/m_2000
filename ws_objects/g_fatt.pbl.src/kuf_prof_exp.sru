$PBExportHeader$kuf_prof_exp.sru
forward
global type kuf_prof_exp from kuf_parent
end type
end forward

global type kuf_prof_exp from kuf_parent
end type
global kuf_prof_exp kuf_prof_exp

type variables
//
private w_profis_exp_fatt kiw_profis_exp_fatt		// window con i parametri di esportazione
private constant string kki_exp_fatt_datastore = "ds_prof_x_esolver" // nome datastore x dati esportazione fatture 
private constant string kki_exp_fatt_rate_datastore = "ds_prof_x_esolver_rate" // nome datastore x dati esportazione fatture (scadenze)
private constant string kki_exp_fidi_datastore = "ds_s_armo_x_fidi_esolver"  // nome datastore x Lotti ancora da fatturare

public constant string kki_nome_file_fatture = "FATTXSTERIGENICS.TXT"
end variables

forward prototypes
public function integer esolver_esporta_anag (string a_file) throws uo_exception
private function integer esolver_popola_st_prof_exp_anag (ref st_prof_exp_anag ast_prof_exp_anag[]) throws uo_exception
private subroutine u_open_window (string a_titolo)
public subroutine u_close_window_prof_exp_fatt ()
public subroutine set_w_profis_exp_fatt (ref w_profis_exp_fatt a_window)
public subroutine u_open_w_profis_exp_fatt ()
public function boolean get_num_fatt_primo (ref ust_tab_prof aust_tab_prof) throws uo_exception
public function boolean get_num_fatt_ultimo (ref ust_tab_prof aust_tab_prof) throws uo_exception
public function long u_exp_fatt (ref datastore ads_profis_exp_fatt) throws uo_exception
public function integer esolver_popola_st_prof_exp_fatt (ref st_prof_exp_fatt ast_prof_exp_fatt, ref st_prof_trk_fatt_esolver kst_prof_trk_fatt_esolver[]) throws uo_exception
public function string esolver_esporta_anag_batch ()
public function integer esolver_esporta_fidi (string a_file) throws uo_exception
public function string esolver_esporta_fidi_batch ()
public function integer esolver_importa_fuori_fido (string a_file) throws uo_exception
private function integer esolver_set_clienti_fuori_fido (ref st_prof_trk_fidi_esolver_inp kst_prof_trk_fidi_esolver_inp[]) throws uo_exception
public function string esolver_importa_fuori_fido_batch ()
private function integer esolver_popola_st_prof_exp_fidi (ref st_prof_exp_fidi ast_prof_exp_fidi, ref st_prof_trk_fidi_esolver ast_prof_trk_fidi_esolver[]) throws uo_exception
public function integer esolver_esporta_fatt_old (st_prof_exp_fatt ast_prof_exp_fatt) throws uo_exception
public function integer eone_esporta_fatt (st_prof_exp_fatt ast_prof_exp_fatt) throws uo_exception
public function integer eone_popola_st_prof_exp_fatt (ref st_prof_exp_fatt ast_prof_exp_fatt, ref st_prof_trk_fatt_navision kst_prof_trk_fatt_navision[]) throws uo_exception
end prototypes

public function integer esolver_esporta_anag (string a_file) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Esporta archivio Anagrafiche da passare a ESOLVER
//--- 
//--- Input: 'path + nome del file' da passare a ESOLVER
//--- out: 
//--- Rit: numero anagrafiche scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return=0
long k_riga, k_righe, k_filenum, k_byte
string k_record="", k_nome_file, k_path
st_prof_exp_anag kst_prof_exp_anag[]
st_tab_prof kst_tab_prof
pointer kp_originale

kuf_utility kuf1_utility
st_esito kst_esito


kp_originale = setpointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_righe = esolver_popola_st_prof_exp_anag(kst_prof_exp_anag[])
	if k_righe = 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessuna Anagrafica trovata da esportare in Contabilità. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

		kuf1_utility = create kuf_utility
		
		k_nome_file = kuf1_utility.u_get_nome_file(a_file)
		k_path = kuf1_utility.u_get_path_file(a_file)
		if len(k_path) > 0 then
			kguo_path.u_drectory_create(k_path)
		end if
		
		k_FileNum = FileOpen(a_file, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore durante apertura archivio x la Contabilità: " + trim(a_file) + " "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		for k_riga = 1 to k_righe
			
			
			k_record = kst_prof_exp_anag[k_riga].tipo_record + ";" &
							+ string(kst_prof_exp_anag[k_riga].tipo_anagrafica)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].codice)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].tipo_soggetto)  + ";" &
							+ kst_prof_exp_anag[k_riga].rag_soc  + ";" &
							+ kst_prof_exp_anag[k_riga].rag_soc_2  + ";" &
							+ kst_prof_exp_anag[k_riga].indirizzo  + ";" &
							+ kst_prof_exp_anag[k_riga].indirizzo_2  + ";" &
							+ kst_prof_exp_anag[k_riga].comune  + ";" &
							+ kst_prof_exp_anag[k_riga].frazione  + ";" &
							+ kst_prof_exp_anag[k_riga].cap  + ";" &
							+ kst_prof_exp_anag[k_riga].provincia  + ";" &
							+ kst_prof_exp_anag[k_riga].iso  + ";" &
							+ kst_prof_exp_anag[k_riga].c_fiscale  + ";" &
							+ kst_prof_exp_anag[k_riga].p_iva  + ";" &
							+ kst_prof_exp_anag[k_riga].telefono  + ";" &
							+ kst_prof_exp_anag[k_riga].fax  + ";" &
							+ kst_prof_exp_anag[k_riga].e_mail  + ";" &
							+ kst_prof_exp_anag[k_riga].sito_web  + ";" &
							+ kst_prof_exp_anag[k_riga].classe_contabile_cliente  + ";" &
							+ kst_prof_exp_anag[k_riga].classe_contabile_fornitore  + ";" &
							+ kst_prof_exp_anag[k_riga].classe_contabile_altro  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_cognome  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_nome  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_comune_nascita  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_provincia_nascita  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_sesso  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_data_nascita  + ";" &
							+ kst_prof_exp_anag[k_riga].pf_stato_nascita  + ";" &
							+ string(kst_prof_exp_anag[k_riga].pf_tipo_soggetto_rit_acconto)  + ";" &
							+ kst_prof_exp_anag[k_riga].zona  + ";" &
							+ string(kst_prof_exp_anag[k_riga].fatt_automatica)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].bloccato)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_ini_1)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_fin_1)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_data_1)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_ini_2)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_fin_2)  + ";" &
							+ string(kst_prof_exp_anag[k_riga].no_effetti_data_2)  + ";" &
							+ kst_prof_exp_anag[k_riga].telefono_2  + ";" &
							+ kst_prof_exp_anag[k_riga].contatto_nome  + ";" &
							+ kst_prof_exp_anag[k_riga].cod_pag  + ";" &
							+ kst_prof_exp_anag[k_riga].cod_iva  + ";" &
							+ kst_prof_exp_anag[k_riga].abi  + ";" &
							+ kst_prof_exp_anag[k_riga].cab  + ";" &
							+ kst_prof_exp_anag[k_riga].descrizione_abi  + ";" &
							+ kst_prof_exp_anag[k_riga].descrizione_cab  + ";" &
							+ kst_prof_exp_anag[k_riga].conto_ns  + ";" &
							+ kst_prof_exp_anag[k_riga].valuta  + ";" &
							+ kst_prof_exp_anag[k_riga].iban_cin_eu  + ";" &
							+ kst_prof_exp_anag[k_riga].iban_cin_it  + ";" &
							+ kst_prof_exp_anag[k_riga].iban_conto  + ";" &
							+ kst_prof_exp_anag[k_riga].iban_paese  + ";" &
							+ kst_prof_exp_anag[k_riga].iban + ";" &
							+ string(kst_prof_exp_anag[k_riga].iban_check)  + ";" &
							+ kst_prof_exp_anag[k_riga].bic  + ";" &
							+ kst_prof_exp_anag[k_riga].categoria  + ";" &
							+ kst_prof_exp_anag[k_riga].categoria_des  + ";" &
							+ kst_prof_exp_anag[k_riga].tipologia  + ";" &
							+ kst_prof_exp_anag[k_riga].tipologia_des  + " " 

			k_byte = FileWrite(k_FileNum, k_record)
			if k_byte < 0 then 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore durante scrittura Anagrafica x la Contabilità su file: " + trim(a_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		end for
		
		k_return = k_righe
		
	end if
	

	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	FileClose(k_FileNum)
	if isvalid(kuf1_utility) then destroy kuf1_utility
	setpointer(kp_originale)

end try

return k_return


end function

private function integer esolver_popola_st_prof_exp_anag (ref st_prof_exp_anag ast_prof_exp_anag[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Popola array Anagrafiche da passare a ESOLVER
//--- 
//--- Input: 
//--- out: st_prof_exp_anag[]  array con le righe da esportare verso ESOLVER
//--- Rit: numero record dell'array
//--- Lancia EXCEPTION se errori gravi DB
//--- 
//--------------------------------------------------------------------------------------------------------------
//
long k_riga, k_righe, k_riga_esolver=0
kuf_listino kuf1_listino
kuf_clienti kuf1_clienti
kuf_ausiliari kuf1_ausiliari
st_tab_listino kst_tab_listino
st_tab_clienti kst_tab_clienti[]
st_tab_clienti kst_tab_clienti_contatto
st_tab_clie_classi kst_tab_clie_classi
st_tab_clie_settori kst_tab_clie_settori
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kuf1_listino = create kuf_listino
	kuf1_clienti = create kuf_clienti
	kuf1_ausiliari = create kuf_ausiliari
	
//--- leggo tutti le anagrafiche	
	kst_tab_clienti[1].codice=0
	k_righe = kuf1_clienti.leggi_tutto(kst_tab_clienti[])
	
	k_riga_esolver=0
	for k_riga = 1 to k_righe
		
//--- Verifico che l'anagrafica sia presente su LISTINO-ATTIVO (almeno UNO) x passarla alla conabilita' 
		kst_tab_listino.attivo=""
		kst_tab_listino.cod_cli = kst_tab_clienti[k_riga].codice 
		kst_tab_listino.attivo = kuf1_listino.kki_attivo_si
		if kuf1_listino.if_listino_x_cod_clie(kst_tab_listino) then
			
//--- leggo descrizioni settore e classe del cliente		
			kst_tab_clie_classi.descr = ""
			if len(trim(kst_tab_clienti[k_riga].id_clie_classe)) > 0 then
				kst_tab_clie_classi.id_clie_classe = trim(kst_tab_clienti[k_riga].id_clie_classe)
				kuf1_ausiliari.tb_select(kst_tab_clie_classi)
			end if
			kst_tab_clie_settori.descr = ""
			if len(trim(kst_tab_clienti[k_riga].id_clie_settore)) > 0 then
				kst_tab_clie_settori.id_clie_settore = trim(kst_tab_clienti[k_riga].id_clie_settore)
				kuf1_ausiliari.tb_select(kst_tab_clie_settori)
			end if

//--- leggo il contatto principale
			kst_tab_clienti_contatto.rag_soc_10 = ""
			if kst_tab_clienti[k_riga].kst_tab_clienti_mkt.id_contatto_1 > 0 then
				kst_tab_clienti_contatto.codice = kst_tab_clienti[k_riga].kst_tab_clienti_mkt.id_contatto_1
				kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_contatto)
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			if isnull(kst_tab_clienti_contatto.rag_soc_10) then
				kst_tab_clienti_contatto.rag_soc_10 = ""
			end if
			
			k_riga_esolver++
			
//--- Popola array x ESOLVER ------------------------------------------------------------------------------
			if kst_tab_clienti[k_riga].abi > 0 then
				ast_prof_exp_anag[k_riga_esolver].abi = string(kst_tab_clienti[k_riga].abi, "00000")
			else
				ast_prof_exp_anag[k_riga_esolver].abi = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].bic = ""
			ast_prof_exp_anag[k_riga_esolver].bloccato = 0
			if len(trim(kst_tab_clienti[k_riga].cf)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].c_fiscale = kst_tab_clienti[k_riga].cf
			else
				ast_prof_exp_anag[k_riga_esolver].c_fiscale = ""
			end if
			if kst_tab_clienti[k_riga].cab > 0 then
				ast_prof_exp_anag[k_riga_esolver].cab = string(kst_tab_clienti[k_riga].cab, "00000")
			else
				ast_prof_exp_anag[k_riga_esolver].cab = ""
			end if
			if len(trim(kst_tab_clienti[k_riga].cap_1)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].cap = kst_tab_clienti[k_riga].cap_1
			else
				ast_prof_exp_anag[k_riga_esolver].cap = ""
			end if
			if len(trim(kst_tab_clienti[k_riga].id_clie_classe)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].categoria = kst_tab_clienti[k_riga].id_clie_classe
				ast_prof_exp_anag[k_riga_esolver].categoria_des = kst_tab_clie_classi.descr
			else
				ast_prof_exp_anag[k_riga_esolver].categoria = ""
				ast_prof_exp_anag[k_riga_esolver].categoria_des = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].iban_cin_eu = ""
			ast_prof_exp_anag[k_riga_esolver].iban_cin_it = ""
			ast_prof_exp_anag[k_riga_esolver].classe_contabile_altro = ""
			ast_prof_exp_anag[k_riga_esolver].classe_contabile_cliente = "CLIT"  //09.03.2015 secondo Jessica le anagrafiche devono finire sempre nel mastro ITALIA 
//			if len(trim(kst_tab_clienti[k_riga].id_nazione_1)) > 0 &
//					and trim(kst_tab_clienti[k_riga].id_nazione_1) <> "IT" and trim(kst_tab_clienti[k_riga].id_nazione_1) <> "I" then
//				ast_prof_exp_anag[k_riga_esolver].classe_contabile_cliente = "CLES"
//			else
//				ast_prof_exp_anag[k_riga_esolver].classe_contabile_cliente = "CLIT"
//			end if
			ast_prof_exp_anag[k_riga_esolver].classe_contabile_fornitore = ""
			if kst_tab_clienti[k_riga].iva > 0 then
				ast_prof_exp_anag[k_riga_esolver].cod_iva = string(kst_tab_clienti[k_riga].iva)
			else
				ast_prof_exp_anag[k_riga_esolver].cod_iva = ""
			end if
			if kst_tab_clienti[k_riga].cod_pag > 0 then
				ast_prof_exp_anag[k_riga_esolver].cod_pag = string(kst_tab_clienti[k_riga].cod_pag)
			else
				ast_prof_exp_anag[k_riga_esolver].cod_pag = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].codice = kst_tab_clienti[k_riga].codice
			ast_prof_exp_anag[k_riga_esolver].pf_cognome = ""
			ast_prof_exp_anag[k_riga_esolver].pf_nome = ""
			ast_prof_exp_anag[k_riga_esolver].pf_comune_nascita = ""
			ast_prof_exp_anag[k_riga_esolver].contatto_nome = kst_tab_clienti_contatto.rag_soc_10
			ast_prof_exp_anag[k_riga_esolver].iban_conto = ""
			ast_prof_exp_anag[k_riga_esolver].iban = ""
			ast_prof_exp_anag[k_riga_esolver].conto_ns = ""
			ast_prof_exp_anag[k_riga_esolver].pf_data_nascita = ""
			ast_prof_exp_anag[k_riga_esolver].descrizione_abi = ""
			ast_prof_exp_anag[k_riga_esolver].descrizione_cab = ""
			if len(trim(kst_tab_clienti[k_riga].kst_tab_clienti_web.email2)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].e_mail = kst_tab_clienti[k_riga].kst_tab_clienti_web.email2
			else
				if len(trim(kst_tab_clienti[k_riga].kst_tab_clienti_web.email)) > 0 then
					ast_prof_exp_anag[k_riga_esolver].e_mail = kst_tab_clienti[k_riga].kst_tab_clienti_web.email
				else
					ast_prof_exp_anag[k_riga_esolver].e_mail = ""
				end if
			end if
			ast_prof_exp_anag[k_riga_esolver].fatt_automatica = 0				
			ast_prof_exp_anag[k_riga_esolver].fax = kst_tab_clienti[k_riga].fax
			ast_prof_exp_anag[k_riga_esolver].iban_check = 0
			ast_prof_exp_anag[k_riga_esolver].comune = kst_tab_clienti[k_riga].loc_1
			ast_prof_exp_anag[k_riga_esolver].frazione = ""
			ast_prof_exp_anag[k_riga_esolver].indirizzo = kst_tab_clienti[k_riga].indi_1
			ast_prof_exp_anag[k_riga_esolver].indirizzo_2 = ""
			if len(trim(kst_tab_clienti[k_riga].id_nazione_1)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].iso = trim(kst_tab_clienti[k_riga].id_nazione_1)
			else
				ast_prof_exp_anag[k_riga_esolver].iso = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].no_effetti_data_1 = 0
			ast_prof_exp_anag[k_riga_esolver].no_effetti_data_2 = 0
			ast_prof_exp_anag[k_riga_esolver].no_effetti_fin_1 = 0
			ast_prof_exp_anag[k_riga_esolver].no_effetti_fin_2 = 0
			ast_prof_exp_anag[k_riga_esolver].no_effetti_ini_1 = 0
			ast_prof_exp_anag[k_riga_esolver].no_effetti_ini_2 = 0
			if len(trim(kst_tab_clienti[k_riga].p_iva)) > 0 then
				ast_prof_exp_anag[k_riga_esolver].p_iva = kst_tab_clienti[k_riga].p_iva
			else
				ast_prof_exp_anag[k_riga_esolver].p_iva = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].iban_paese = ""
			ast_prof_exp_anag[k_riga_esolver].provincia = kst_tab_clienti[k_riga].prov_1
			ast_prof_exp_anag[k_riga_esolver].pf_provincia_nascita = ""
			ast_prof_exp_anag[k_riga_esolver].rag_soc = kst_tab_clienti[k_riga].rag_soc_10
			ast_prof_exp_anag[k_riga_esolver].rag_soc_2 = kst_tab_clienti[k_riga].rag_soc_11
			ast_prof_exp_anag[k_riga_esolver].pf_sesso = ""
			ast_prof_exp_anag[k_riga_esolver].pf_stato_nascita = ""
			ast_prof_exp_anag[k_riga_esolver].telefono = kst_tab_clienti[k_riga].fono
			ast_prof_exp_anag[k_riga_esolver].telefono_2 = ""
			ast_prof_exp_anag[k_riga_esolver].tipo_anagrafica = 1	// cliente
			ast_prof_exp_anag[k_riga_esolver].tipo_record = "GEN"  	// fisso
			ast_prof_exp_anag[k_riga_esolver].tipo_soggetto = 1   	// soc.di capitali
			ast_prof_exp_anag[k_riga_esolver].pf_tipo_soggetto_rit_acconto = 0
			if len(trim(kst_tab_clienti[k_riga].id_clie_settore )) > 0 then
				ast_prof_exp_anag[k_riga_esolver].tipologia = kst_tab_clienti[k_riga].id_clie_settore
				ast_prof_exp_anag[k_riga_esolver].tipologia_des = kst_tab_clie_settori.descr
			else
				ast_prof_exp_anag[k_riga_esolver].tipologia = ""
				ast_prof_exp_anag[k_riga_esolver].tipologia_des = ""
			end if
			
			ast_prof_exp_anag[k_riga_esolver].valuta = "EUR"
			if len(trim(kst_tab_clienti[k_riga].kst_tab_clienti_web.sito_web )) > 0 then
				ast_prof_exp_anag[k_riga_esolver].sito_web = trim(kst_tab_clienti[k_riga].kst_tab_clienti_web.sito_web )
			else
				ast_prof_exp_anag[k_riga_esolver].sito_web = ""
			end if
			ast_prof_exp_anag[k_riga_esolver].zona = kst_tab_clienti[k_riga].zona
//--- fine Popola array x ESOLVER ------------------------------------------------------------------------------
		end if
	
	end for
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari

end try

return k_riga_esolver


end function

private subroutine u_open_window (string a_titolo);//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = ""
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	k_st_open_w.key1 = a_titolo  				// descrizione filtro
	K_st_open_w.key12_any = this			// questo oggetto di gestione del filtro
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
								

end subroutine

public subroutine u_close_window_prof_exp_fatt ();//
//--- Chiude la window 
//
if isvalid(kiw_profis_exp_fatt) then kiw_profis_exp_fatt.chiudi_immediato()

end subroutine

public subroutine set_w_profis_exp_fatt (ref w_profis_exp_fatt a_window);//
//--- setta il rifer della window 
kiw_profis_exp_fatt = a_window

end subroutine

public subroutine u_open_w_profis_exp_fatt ();//
//--- Apre la window x impostare i parametri di estrazione
//--- 
//
STRING A_TITOLO=""
	
// se window non ancora aperta
	if not isvalid(kiw_profis_exp_fatt) then
		u_open_window(a_titolo)			
	else
		kiw_profis_exp_fatt.WindowState = normal!
	end if
	if isvalid(kiw_profis_exp_fatt) then
		kiw_profis_exp_fatt.bringtotop = true
	end if


end subroutine

public function boolean get_num_fatt_primo (ref ust_tab_prof aust_tab_prof) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo primo Numero Fattura nell'anno con lo stato specifico indicato
//=== 
//--- Inp: 	ust_tab_prof.data_fatt (contenente l'anno di estrazione) se non passato piglia l'anno in corso
//---			ust_tab_prof.profis (se non passato prende <> 'kki_fattura_profis_cont_si') per tutti mettere '%'   
//--- Out: 	ust_tab_prof.num_fatt e ust_tab_prof.data_fatt estratti
//=== Ritorna TRUE=OK ho trovato qls; FALSE=nessua fattura estratta
//===                                     
//=== lancia uo_exception
//---
//====================================================================
//
boolean k_return = false
ust_tab_prof kust_tab_prof_ini, kust_tab_prof_fin
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kust_tab_prof_ini = create ust_tab_prof
kust_tab_prof_fin = create ust_tab_prof

if aust_tab_prof.data_fatt > KKG.DATA_ZERO then
else
	aust_tab_prof.data_fatt = kg_dataoggi
end if
kust_tab_prof_ini.data_fatt = date(year(aust_tab_prof.data_fatt), 01, 01)
kust_tab_prof_fin.data_fatt = date(year(aust_tab_prof.data_fatt), 12, 31)

if len(trim(aust_tab_prof.profis)) > 0 then
	
	select 
		num_fatt
		,data_fatt
		,profis
 	into 
		:aust_tab_prof.num_fatt
		,:aust_tab_prof.data_fatt
		,:aust_tab_prof.profis
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and flag = 'A'
		and num_fatt in (
	select 
		min(num_fatt)
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and profis like :aust_tab_prof.profis  )
	using kguo_sqlca_db_magazzino;
	
else
	aust_tab_prof.profis = aust_tab_prof.kki_profis_docInContab_si
	
	select 
		num_fatt
		,data_fatt
		,profis
 	into 
		:aust_tab_prof.num_fatt
		,:aust_tab_prof.data_fatt
		,:aust_tab_prof.profis
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and flag = 'A'
		and num_fatt in (
	select 
		min(num_fatt)
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and profis <> :aust_tab_prof.profis  )
	using kguo_sqlca_db_magazzino;

end if

if sqlca.sqlcode <> 0 then
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cerca Numero Fattura in tabella movimenti per la Contabilità (PROF): " + trim(sqlca.SQLErrText)
	if sqlca.sqlcode = 100 then
		aust_tab_prof.num_fatt = 0
	else
		if sqlca.sqlcode > 0 then
			aust_tab_prof.num_fatt = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
end if

if aust_tab_prof.num_fatt > 0 then
	k_return = true
else
	aust_tab_prof.num_fatt = 0
end if

if isvalid(kust_tab_prof_ini) then destroy kust_tab_prof_ini
if isvalid(kust_tab_prof_fin) then destroy kust_tab_prof_fin

return k_return

end function

public function boolean get_num_fatt_ultimo (ref ust_tab_prof aust_tab_prof) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo Ultimo Numero Fattura nell'anno con lo stato specifico indicato
//=== 
//--- Inp: 	ust_tab_prof.data_fatt (contenente l'anno di estrazione) se non passato piglia l'anno in corso
//---			ust_tab_prof.profis (se non passato prende <> 'kki_fattura_profis_cont_si') per tutti mettere '%'   
//--- Out: 	ust_tab_prof.num_fatt e ust_tab_prof.data_fatt estratti
//=== Ritorna TRUE=OK ho trovato qls; FALSE=nessua fattura estratta
//===                                     
//=== lancia uo_exception
//---
//====================================================================
//
boolean k_return = false
ust_tab_prof kust_tab_prof_ini, kust_tab_prof_fin
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kust_tab_prof_ini = create ust_tab_prof
kust_tab_prof_fin = create ust_tab_prof

if aust_tab_prof.data_fatt > KKG.DATA_ZERO then
else
	aust_tab_prof.data_fatt = kg_dataoggi
end if
kust_tab_prof_ini.data_fatt = date(year(aust_tab_prof.data_fatt), 01, 01)
kust_tab_prof_fin.data_fatt = date(year(aust_tab_prof.data_fatt), 12, 31)

if len(trim(aust_tab_prof.profis)) > 0 then
	
	select 
		num_fatt
		,data_fatt
		,profis
 	into 
		:aust_tab_prof.num_fatt
		,:aust_tab_prof.data_fatt
		,:aust_tab_prof.profis
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and flag = 'A'
		and num_fatt in (
	select 
		max(num_fatt)
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and profis like :aust_tab_prof.profis  )
	using kguo_sqlca_db_magazzino;
	
else
	aust_tab_prof.profis = aust_tab_prof.kki_profis_docInContab_si
	
	select 
		num_fatt
		,data_fatt
		,profis
 	into 
		:aust_tab_prof.num_fatt
		,:aust_tab_prof.data_fatt
		,:aust_tab_prof.profis
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and flag = 'A'
		and num_fatt in (
	select 
		max(num_fatt)
	from prof
	where 
		data_fatt between :kust_tab_prof_ini.data_fatt and :kust_tab_prof_fin.data_fatt
		and profis <> :aust_tab_prof.profis  )
	using kguo_sqlca_db_magazzino;

end if

if sqlca.sqlcode <> 0 then
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cerca Numero Fattura in tabella movimenti per la Contabilità (PROF): " + trim(sqlca.SQLErrText)
	if sqlca.sqlcode = 100 then
		aust_tab_prof.num_fatt = 0
	else
		if sqlca.sqlcode > 0 then
			aust_tab_prof.num_fatt = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
end if

if aust_tab_prof.num_fatt > 0 then
	k_return = true
else
	aust_tab_prof.num_fatt = 0
end if

if isvalid(kust_tab_prof_ini) then destroy kust_tab_prof_ini
if isvalid(kust_tab_prof_fin) then destroy kust_tab_prof_fin


return k_return

end function

public function long u_exp_fatt (ref datastore ads_profis_exp_fatt) throws uo_exception;//
//--- Esporta le fatture indicate nella window 
//--- Inp: d_profis_exp_fatt = datastore con i numeri "da a" da esportare 
//--- Out: numero documenti esportati
//
long k_return=0
int k_ctr, k_anno
st_prof_exp_fatt kst_prof_exp_fatt
st_tab_prof kst_tab_prof_da, kst_tab_prof_a
ust_tab_prof kust_tab_prof
kuf_prof kuf1_prof


try
	kuf1_prof = create kuf_prof
	kust_tab_prof = create ust_tab_prof


//--- estrae numeri fattura da esportare 				
	if ads_profis_exp_fatt.rowcount() > 0 then 
		k_ctr = 1
		kst_tab_prof_da.num_fatt = ads_profis_exp_fatt.getitemnumber(k_ctr,"dal")
		kst_tab_prof_a.num_fatt = ads_profis_exp_fatt.getitemnumber(k_ctr,"al")
		k_anno = ads_profis_exp_fatt.getitemnumber(k_ctr,"anno")

//--- Compone limiti num FATTURA da esportare
		kust_tab_prof.set_num_fatt(kst_tab_prof_da.num_fatt)
		kust_tab_prof.set_data_fatt(date(k_anno,01,01))
		if kuf1_prof.get_id_fattura_da_num_anno(kust_tab_prof) then
			kst_prof_exp_fatt.num_fattura_da = kst_tab_prof_da.num_fatt
			kst_prof_exp_fatt.data_fattura_da = date(k_anno,01,01)
//			kst_prof_exp_fatt.id_fattura_da = kust_tab_prof.get_id_fattura( )
		end if
		kust_tab_prof.set_num_fatt(kst_tab_prof_a.num_fatt)
		kust_tab_prof.set_data_fatt(date(k_anno,01,01))
		kuf1_prof.get_id_fattura_da_num_anno(kust_tab_prof)			
		if kuf1_prof.get_id_fattura_da_num_anno(kust_tab_prof) then
			kst_prof_exp_fatt.num_fattura_a = kst_tab_prof_a.num_fatt
			kst_prof_exp_fatt.data_fattura_a = date(k_anno,12,31)
//			kst_prof_exp_fatt.id_fattura_a = kust_tab_prof.get_id_fattura( )
		end if
//--- esportare tutto? o solo fatture non esportate?		
		if ads_profis_exp_fatt.getitemstring(k_ctr,"profis") = "1" then
			kst_prof_exp_fatt.profis = ""
		else
			kst_prof_exp_fatt.profis = "*"  // tutto!
		end if
//--- aggiornare le tabelle?
		if ads_profis_exp_fatt.getitemnumber(k_ctr,"aggiorna") = 1 then
			kst_prof_exp_fatt.aggiorna = 1  // SI!
		else
			kst_prof_exp_fatt.aggiorna = 0
		end if

////--- estrae path dove esportare le fatture x la contabilità ESOLVER			
//		kst_prof_exp_fatt.nome_file = ads_profis_exp_fatt.getitemstring(k_ctr,"cartella") + KKG.PATH_SEP + "FATTXESOLVER.CSV"
//		k_return = esolver_esporta_fatt(kst_prof_exp_fatt)

//--- estrae path dove esportare le fatture x la contabilità E-ONE (STERIGENICS) 				
		kst_prof_exp_fatt.nome_file = ads_profis_exp_fatt.getitemstring(k_ctr,"cartella") + KKG.PATH_SEP + kki_nome_file_fatture
		k_return += eone_esporta_fatt(kst_prof_exp_fatt)
		
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kust_tab_prof) then destroy kust_tab_prof
	if isvalid(kuf1_prof) then destroy kuf1_prof
	
end try

return k_return

end function

public function integer esolver_popola_st_prof_exp_fatt (ref st_prof_exp_fatt ast_prof_exp_fatt, ref st_prof_trk_fatt_esolver kst_prof_trk_fatt_esolver[]) throws uo_exception;//
//--- Estrate fatture indicate x fare esportazione su ESOLVER
//--- Inp: st_prof_exp_fatt = id_fattura 'da... a...'
//--- Out: st_prof_trk_fatt_esolver array con num righe fatture da esportare 
//--- Rit: numero righe prodotte (0=nessuna)
//
int k_return = 0
int k_ctr, k_anno, k_riga, k_ctr_fatt=0, k_rec=0, k_scad, k_ctr_fatt_tes, k_num_fatt
long k_rcn=0
st_tab_arfa kst_tab_arfa_old
st_tab_prof kst_tab_prof
st_tab_clienti kst_tab_clienti_old
st_tab_pagam kst_tab_pagam_old
st_fattura_totali kst_fattura_totali
kuf_fatt kuf1_fatt
kuf_prof kuf1_prof
datastore kds_prof_x_esolver, kds_prof_x_esolver_rate


try
	kuf1_fatt = create kuf_fatt
	kuf1_prof = create kuf_prof
//	kust_tab_prof = create ust_tab_prof


//--- definizione datastore x estrazione fatture e scadenze
	kds_prof_x_esolver = create datastore
	kds_prof_x_esolver.dataobject = kki_exp_fatt_datastore
	kds_prof_x_esolver.settransobject( kguo_sqlca_db_magazzino )
	kds_prof_x_esolver_rate = create datastore
	kds_prof_x_esolver_rate.dataobject = kki_exp_fatt_rate_datastore
	kds_prof_x_esolver_rate.settransobject( kguo_sqlca_db_magazzino )
	
//--- lancia estrazione fatture 
//	if kds_prof_x_esolver.retrieve(ast_prof_exp_fatt.id_fattura_da, ast_prof_exp_fatt.id_fattura_a, ast_prof_exp_fatt.profis ) > 0 then 
	k_rcn = kds_prof_x_esolver.retrieve(ast_prof_exp_fatt.num_fattura_da, ast_prof_exp_fatt.num_fattura_a, ast_prof_exp_fatt.data_fattura_da,  ast_prof_exp_fatt.data_fattura_a, ast_prof_exp_fatt.profis ) 
	if k_rcn > 0 then 

		kst_tab_arfa_old.id_fattura = 0
		k_rec = 0 // numero record della tabella
		k_riga=1
		do while k_riga <= kds_prof_x_esolver.rowcount( )
			
			if kst_tab_arfa_old.id_fattura <> kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura") then
				
				if k_ctr_fatt > 0 then// a parte il primo giro ad ogni cambio fattura leggo le Imponibili-IVA e Scadenze
				
//--- Riempie le righe con i Totali IVA				
					kuf1_fatt.get_totali(kst_tab_arfa_old, kst_fattura_totali )  // get totali IVA (imponibili, importi....)
					if kst_fattura_totali.cod_1 > 0 then 
						k_rec ++
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kst_tab_arfa_old.id_fattura
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kst_tab_arfa_old.clie_3)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kst_tab_arfa_old.num_fatt)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "IVA"
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_imponibile_valuta = string(round(kst_fattura_totali.imponibile_1,2))
						if kst_fattura_totali.cod_1 > 0 then
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_codice_1 = string(kst_fattura_totali.cod_1)
							if kst_fattura_totali.imposta_1 > 0 then
								kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_importo_iva_valuta = string(round(kst_fattura_totali.imposta_1,2))
							end if
						end if
					end if
					if kst_fattura_totali.cod_2 > 0 then 
						k_rec ++
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kst_tab_arfa_old.id_fattura
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kst_tab_arfa_old.clie_3)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kst_tab_arfa_old.num_fatt)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "IVA"
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_imponibile_valuta = string(round(kst_fattura_totali.imponibile_2,2))
						if kst_fattura_totali.cod_2 > 0 then
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_codice_1 = string(kst_fattura_totali.cod_2)
							if kst_fattura_totali.imposta_2 > 0 then
								kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_importo_iva_valuta = string(round(kst_fattura_totali.imposta_2,2))
							end if
						end if
					end if
					if kst_fattura_totali.cod_3 > 0 then 
						k_rec ++
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kst_tab_arfa_old.id_fattura
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kst_tab_arfa_old.clie_3)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kst_tab_arfa_old.num_fatt)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "IVA"
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_imponibile_valuta = string(round(kst_fattura_totali.imponibile_3,2))
						if kst_fattura_totali.cod_3 > 0 then
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_codice_1 = string(kst_fattura_totali.cod_3)
							if kst_fattura_totali.imposta_3 > 0 then
								kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_importo_iva_valuta = string(round(kst_fattura_totali.imposta_3,2))
							end if
						end if
					end if
					if kst_fattura_totali.cod_4 > 0 then 
						k_rec ++
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kst_tab_arfa_old.id_fattura
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kst_tab_arfa_old.clie_3)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kst_tab_arfa_old.num_fatt)
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "IVA"
						kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_imponibile_valuta = string(round(kst_fattura_totali.imponibile_4,2))
						if kst_fattura_totali.cod_4 > 0 then
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_codice_1 = string(kst_fattura_totali.cod_4)
							if kst_fattura_totali.imposta_4 > 0 then
								kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].iva_importo_iva_valuta = string(round(kst_fattura_totali.imposta_4,2))
							end if
						end if
					end if
				
//--- Riempie le righe con le RATE
					if kds_prof_x_esolver_rate.retrieve(kst_tab_arfa_old.num_fatt, kst_tab_arfa_old.data_fatt) > 0 then 
						for k_scad = 1 to kds_prof_x_esolver_rate.getrow( ) // GET delle RATE
							k_rec ++
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kst_tab_arfa_old.id_fattura
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kst_tab_arfa_old.clie_3)
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kst_tab_arfa_old.num_fatt)
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "PAR"
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].par_banca_cliente_abi = string(kst_tab_clienti_old.abi , "#")
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].par_banca_cliente_cab = string(kst_tab_clienti_old.cab , "#")
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].par_pag_tipo  = kst_tab_pagam_old.tipo
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].par_scadenza_dt = string(kds_prof_x_esolver_rate.getitemdate(k_scad, "scad"), "ddmmyyyy")
							kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].par_scadenza_rata_importo = string(kds_prof_x_esolver_rate.getitemnumber(k_scad, "rata"))
						end for
					end if
				end if
				
//--- salvo i rif alla fattura che vado a trattare				
				kst_tab_arfa_old.id_fattura = kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura")
				kst_tab_arfa_old.num_fatt = kds_prof_x_esolver.getitemnumber( k_riga, "prof_num_fatt")
				kst_tab_arfa_old.data_fatt = kds_prof_x_esolver.getitemdate( k_riga, "prof_data_fatt")
				kst_tab_arfa_old.clie_3 = kds_prof_x_esolver.getitemnumber( k_riga, "clienti_codice")
				kst_tab_clienti_old.abi = kds_prof_x_esolver.getitemnumber( k_riga, "clienti_abi")
				kst_tab_clienti_old.cab = kds_prof_x_esolver.getitemnumber( k_riga, "clienti_cab")
				kst_tab_pagam_old.tipo = kds_prof_x_esolver.getitemstring( k_riga, "pagam_tipo")
				
				k_ctr_fatt ++
				k_ctr_fatt_tes = k_ctr_fatt+k_rec 
			end if
			
			kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].id_fattura = kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura")
			kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].xxx_id_cliente = string(kds_prof_x_esolver.getitemnumber( k_riga, "clienti_codice"))
			kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].xxx_reg_nr = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_num_fatt"))
			
			if trim(kds_prof_x_esolver.getitemstring( k_riga, "prof_flag")) = "A" then
				
				k_num_fatt ++
				
				kuf1_fatt.get_totali(kst_tab_arfa_old, kst_fattura_totali )  // get totali IVA (imponibili, importi....)

				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tipo_record = "TES"
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_reg_dt = string(kds_prof_x_esolver.getitemdate( k_riga, "prof_data_fatt"), "ddmmyyyy")
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_cambio = ""
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_cod_pag = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_cod_pag"))
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_contoesolver_codice = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_conto")) //+ trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_s_conto")))
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_iva_anno = ""
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_iva_periodo = ""
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_iva_territ = ""
				
				//kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_ivaregistro = "V"
				kst_tab_prof.id_fattura = kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].id_fattura
				if kuf1_prof.if_f_splitpayment(kst_tab_prof) then
					kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_f_splitpayment ="61" 
				else
					kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_f_splitpayment ="0" 
				end if
				
				if trim(kds_prof_x_esolver.getitemstring( k_riga, "prof_tipo_doc")) = "NC" then
					kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_tipo_doc = "755"  // nota accredito 
				else
					kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_tipo_doc = "715" // fattura
				end if
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_valuta = "EUR"
				kst_prof_trk_fatt_esolver[k_ctr_fatt_tes].tes_importo = string(round(kst_fattura_totali.totale,2))
			else
				k_rec ++
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].id_fattura = kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura")
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_id_cliente = string(kds_prof_x_esolver.getitemnumber( k_riga, "clienti_codice"))
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].xxx_reg_nr = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_num_fatt"))
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].tipo_record = "RIG"
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].rig_conto_codice = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_conto"))) + trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_s_conto")))
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].rig_importovaluta = trim(string(round(kds_prof_x_esolver.getitemnumber( k_riga, "prof_importo"),2)))
				kst_prof_trk_fatt_esolver[k_ctr_fatt+k_rec].rig_ivacodice = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_iva")))
			end if
			
			k_riga++
			
		loop
	end if 

	k_return = k_ctr_fatt+k_rec

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_prof) then destroy kuf1_prof
	if isvalid(kuf1_fatt) then destroy kuf1_fatt
	if isvalid(kds_prof_x_esolver) then destroy kds_prof_x_esolver
	if isvalid(kds_prof_x_esolver_rate) then destroy kds_prof_x_esolver_rate
	
end try


return k_return
end function

public function string esolver_esporta_anag_batch ();//
string k_return = ""
string k_path
integer k_nr_rec, k_nrc
kuf_base kuf1_base


try	

//	k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_anag", trim(GetCurrentDirectory ( )) + KKG.PATH_SEP + "esolver.csv"))
	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_anag_batch")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
//		kst_esito.nome_oggetto = this.classname()
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base

	
	if len(trim(k_path)) > 0 then

		k_nr_rec = esolver_esporta_anag(trim(k_path))

		if k_nr_rec > 0 then
			k_return = "Operazione corretta, sono state scritte " + string(k_nr_rec) + " anagrafiche per la Contabilità ~n~r" + "File: " + trim(k_path) 
		else
			k_return = "Nessuna Anagrafica Scritta per la Contabilità, nel file " + trim(k_path)
		end if			
	else
		
		k_return = "Nessuna estrazione Anagrafiche Eseguita x la Contabilità! Indicare il percorso in Proprietà della Proceura"
	end if

	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

public function integer esolver_esporta_fidi (string a_file) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Esporta dati Lotti non fatturati per calcolo Fidi da passare a ESOLVER
//--- 
//--- Input: 'path + nome del file' da passare a ESOLVER
//--- out: 
//--- Rit: numero righe scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_riga, k_righe, k_filenum, k_byte
string k_record="", k_nome_file, k_path
st_prof_exp_fidi kst_prof_exp_fidi
st_prof_trk_fidi_esolver kst_prof_trk_fidi_esolver[]
st_tab_prof kst_tab_prof
pointer kp_originale

kuf_utility kuf1_utility
st_esito kst_esito


kp_originale = setpointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_righe = esolver_popola_st_prof_exp_fidi(kst_prof_exp_fidi, kst_prof_trk_fidi_esolver[])
	if k_righe = 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessuna Anagrafica trovata da esportare in Contabilità. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

		kuf1_utility = create kuf_utility
		
		k_nome_file = kuf1_utility.u_get_nome_file(a_file)
		k_path = kuf1_utility.u_get_path_file(a_file)
		if len(k_path) > 0 then
			kguo_path.u_drectory_create(k_path)
		end if
		
		k_FileNum = FileOpen(a_file, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore durante apertura archivio x la Contabilità: " + trim(a_file) + " "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		for k_riga = 1 to k_righe
			
			
			k_record = kst_prof_trk_fidi_esolver[k_riga].tipo_record + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].tes_reg_dt  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].xxx_reg_nr  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].tes_id_cliente  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].tes_valuta  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].tes_cambio  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].rig_tipo_riga  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].rig_importovaluta  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].rig_ivacodice  + ";" &
							+ kst_prof_trk_fidi_esolver[k_riga].rig_importo_udc  + " " 

			k_byte = FileWrite(k_FileNum, k_record)
			if k_byte < 0 then 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore durante scrittura dati Fido x la Contabilità su file: " + trim(a_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		end for
		
		k_return = k_righe
		
	end if
	

	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	FileClose(k_FileNum)
	if isvalid(kuf1_utility) then destroy kuf1_utility
	setpointer(kp_originale)

end try

return k_return


end function

public function string esolver_esporta_fidi_batch ();//
string k_return = ""
string k_path
integer k_nr_rec, k_nrc
kuf_base kuf1_base


try	

	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_expfidi_batch")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base

	
	if len(trim(k_path)) > 0 then

		k_nr_rec = esolver_esporta_fidi(trim(k_path))

		if k_nr_rec > 0 then
			k_return = "Operazione corretta, sono state scritti " + string(k_nr_rec) + " righe dati per Fidi per la Contabilità ~n~r" + "File: " + trim(k_path) 
		else
			k_return = "Nessun dato Fidi scritto per la Contabilità, nel file " + trim(k_path)
		end if			
	else
		
		k_return = "Nessuna estrazione dati Fidi Eseguita x la Contabilità! Indicare il percorso in Proprietà della Proceura"
	end if

	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

public function integer esolver_importa_fuori_fido (string a_file) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa dati clienti Fuori Fido provenienti da ESOLVER
//--- 
//--- Input: 'path + nome del file' da passare a ESOLVER
//--- out: 
//--- Rit: numero Clienti Fuori Fido
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_riga=0, k_righe=0, k_filenum, k_byte, k_rc
string k_record="", k_nome_file, k_path, k_filetemp
st_prof_exp_fidi kst_prof_exp_fidi
st_prof_trk_fidi_esolver_inp kst_prof_trk_fidi_esolver_inp[]
st_tab_prof kst_tab_prof
//pointer kp_originale

kuf_utility kuf1_utility
st_esito kst_esito


//kp_originale = setpointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try


	kuf1_utility = create kuf_utility
	
	k_nome_file = kuf1_utility.u_get_nome_file(a_file)
	k_path = kuf1_utility.u_get_path_file(a_file)
	if len(k_path) > 0 then
		kguo_path.u_drectory_create(k_path)
	end if
//--- Copia il file in cartella temporanea per poterlo trattare senza problemi
	k_filetemp = kguo_path.get_temp( ) + kkg.PATH_SEP + k_nome_file
	fileDelete(k_filetemp)
	k_rc = fileCopy(a_file, k_filetemp, true)
	if k_rc > 0 then
	else
		if k_rc = -1 then
			kst_esito.sqlerrtext = "Copia del file Fuori Fido generato da ESOLVER fallita in apertura del file sorgente: " + trim(a_file) + " doveva copiare in temp: " + k_filetemp
		elseif k_rc = -2 then
			kst_esito.sqlerrtext = "Copia del file Fuori Fido generato da ESOLVER fallita per mancata scrittura sul temp: " + k_filetemp + " dal file sorgente: " + trim(a_file) 
		else
			kst_esito.sqlerrtext = "Copia del file Fuori Fido generato da ESOLVER fallita; file sorgente: " + trim(a_file) + " da copiare in temp: " + k_filetemp
		end if
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if not fileExists(k_filetemp) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun archivio Fuori Fido generato da ESOLVER: " + trim(a_file) + " - Check fatto sul temp: " + k_filetemp
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_FileNum = FileOpen(k_filetemp, LineMode!, Read!, Shared!)
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore durante apertura archivio Fuori Fido generato da ESOLVER: " + trim(a_file) + " "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_byte = FileRead(k_FileNum, k_record)
	if k_byte < 0 then 
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun dato Fuori Fido fornito da ESOLVER su file: " + trim(a_file) + " "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	do while k_byte > 0 
		
		k_riga++
		kst_prof_trk_fidi_esolver_inp[k_riga].id_cliente = trim(k_record)   // incamera id_cliente

		k_byte = FileRead(k_FileNum, k_record)
//			if k_byte < 0 then 
//				kst_esito.esito = kkg_esito.no_esecuzione
//				kst_esito.sqlerrtext = "Errore durante scrittura dati Fido x la Contabilità su file: " + trim(a_file) + " "
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito(kst_esito)
//				throw kguo_exception
//			end if
		
	loop
	
	if k_riga = 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun Cliente Fuori Fido fornito da ESOLVER su file: " + trim(a_file) + " "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

		k_righe = esolver_set_clienti_fuori_fido(kst_prof_trk_fidi_esolver_inp[])
		k_return = k_righe
		
	end if
	

	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if k_FileNum > 0 then
		FileClose(k_FileNum)
	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility
//	setpointer(kp_originale)

end try

return k_return


end function

private function integer esolver_set_clienti_fuori_fido (ref st_prof_trk_fidi_esolver_inp kst_prof_trk_fidi_esolver_inp[]) throws uo_exception;//
//--- Imposta Fuori Fido da file generato da ESOLVER
//---                           Inp: st_prof_exp_fidi = id_cliente (se zero becca tutti) e data_int_da = data Lotto da cui esportare (x default meno 1 anno)
//--- Inp: st_prof_trk_fidi_esolver_inp array con le righe da importare 
//--- Rit: numero righe elaborate (0=nessuna)
//
int k_return = 0
int k_ctr, k_anno, k_riga=0, k_nr_clienti
string k_esito=""

st_tab_s_armo kst_tab_s_armo_old
st_tab_clienti kst_tab_clienti
kuf_base kuf1_base
kuf_clienti kuf1_clienti


try
	kuf1_base = create kuf_base
	kuf1_clienti = create kuf_clienti

//	k_riga_ctr = esolver_importa_fuori_fido( /*string a_file */)

//--- piglia il codice causale lotto da impostare sui clienti
	kst_tab_clienti.id_meca_causale = 0
	k_esito = kuf1_base.prendi_dato_base("esolver_fidi_id_meca_causale")
	if left(k_esito,1) <> "0" then
	else
		if isnumber(mid(k_esito,2)) then
			kst_tab_clienti.id_meca_causale = long(mid(k_esito,2))
		end if
	end if

//--- se su BASE non è stato impostato il codice causale rigetto con errore
	if kst_tab_clienti.id_meca_causale = 0 then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.setmessage( "Manca indicazione Causale Lotto per i Fuori Fido in Proprietà Procedura. Operazione non eseguita.")
		throw kguo_exception
	else

//--- Prima fa la Pulizia dei FUORI FIDO precedenti (resetta il codice causale puntuale su tutti i clienti)
		kst_tab_clienti.st_tab_g_0.esegui_commit = "S"
		kuf1_clienti.reset_id_meca_causale_all(kst_tab_clienti)

//--- ricavo il nr clienti fuori fido
		k_nr_clienti = upperbound(kst_prof_trk_fidi_esolver_inp[])

//--- lancia estrazione fatture 
		if k_nr_clienti > 0 then 

			k_riga=0
			do while k_riga < k_nr_clienti
				k_riga++
				
//--- ricavo il cliente			
				if isnumber(kst_prof_trk_fidi_esolver_inp[k_riga].id_cliente) then
					kst_tab_clienti.codice = long(kst_prof_trk_fidi_esolver_inp[k_riga].id_cliente)
//--- AGGIORNA CLIENTE FUORI FIDO				
					kst_tab_clienti.st_tab_g_0.esegui_commit = "N"
					kuf1_clienti.set_id_meca_causale(kst_tab_clienti)
				end if
				
			loop
		end if 

		k_return = k_riga
	end if
	
catch (uo_exception kuo_exception)
	if k_riga > 0 then  // se ho fatto degli aggiornamenti le ROLLBACK
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception
	
finally
	if k_riga > 0 then  // se ho fatto degli aggiornamenti le COMMIT
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	
end try


return k_return
end function

public function string esolver_importa_fuori_fido_batch ();//
string k_return = ""
string k_path
integer k_nr_rec, k_nrc
kuf_base kuf1_base


try	

	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_inpfidi_batch")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base

	
	if len(trim(k_path)) > 0 then

		k_nr_rec = esolver_importa_fuori_fido(trim(k_path))

		if k_nr_rec > 0 then
			k_return = "Operazione corretta, sono stati aggiornati " + string(k_nr_rec) + " Clienti per Fuori Fido ricevuti da ESOLVER ~n~r" + "File: " + trim(k_path) 
		else
			k_return = "Nessun Cliente Fuori Fido ricevuto da ESOLVER, nel file " + trim(k_path)
		end if			
	else
		
		k_return = "Nessuna estrazione da file ESOLVER dei Clienti Fuori Fido eseguita! Indicare il percorso in Proprietà della Proceura"
	end if

	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

private function integer esolver_popola_st_prof_exp_fidi (ref st_prof_exp_fidi ast_prof_exp_fidi, ref st_prof_trk_fidi_esolver ast_prof_trk_fidi_esolver[]) throws uo_exception;//
//--- Estrate Lotti non ancora Fatturati x fare esportazione su ESOLVER x il calcolo 'fido'
//--- Inp: st_prof_exp_fidi = id_cliente (se zero becca tutti) e data_int_da = data Lotto da cui esportare (x default meno 1 anno)
//--- Out: st_prof_trk_fidi_esolver array con le righe da esportare 
//--- Rit: numero righe prodotte (0=nessuna)
//
int k_return = 0
int k_ctr, k_anno, k_riga, k_riga_max=0, k_rec=0, k_scad, k_ctr_lotti_tes
date k_dataoggi, k_data365
datastore kds_prof_x_esolver //, kds_prof_x_esolver_rate
st_tab_s_armo kst_tab_s_armo_old
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_prof_trk_fidi_esolver kst_prof_trk_fidi_esolver_null 
kuf_armo kuf1_armo
kuf_prodotti kuf1_prodotti


try
	kuf1_prodotti = create kuf_prodotti
	kuf1_armo = create kuf_armo

//--- definizione datastore x estrazione lotti non ancora fatturati
	kds_prof_x_esolver = create datastore
	kds_prof_x_esolver.dataobject = kki_exp_fidi_datastore //kuf_fatt.kki_dw_s_lotti_da_fatt
	kds_prof_x_esolver.settransobject( kguo_sqlca_db_magazzino )

//--- imposta se a null i dati di default	
	if isnull(ast_prof_exp_fidi.id_cliente) then ast_prof_exp_fidi.id_cliente = 0
	k_dataoggi = kguo_g.get_dataoggi( )
	if ast_prof_exp_fidi.data_int_da > date(0) then 
	else
		k_data365 =  relativedate(k_dataoggi, -365)
		ast_prof_exp_fidi.data_int_da = k_data365
	end if
	
//--- lancia estrazione lotti non fatturati 
	if kds_prof_x_esolver.retrieve(ast_prof_exp_fidi.id_cliente, ast_prof_exp_fidi.data_int_da ) > 0 then 

		kst_tab_s_armo_old.id_meca = 0
		k_rec = 0 // numero record della tabella
		k_riga=1
		k_riga_max = kds_prof_x_esolver.rowcount( )
		do while k_riga <= k_riga_max

			if kst_tab_s_armo_old.id_meca <> kds_prof_x_esolver.getitemnumber( k_riga, "id_meca") then
//--- salvo i rif al Riferimento che vado a trattare				
				kst_tab_s_armo_old.id_meca = kds_prof_x_esolver.getitemnumber( k_riga, "id_meca")
				kst_tab_s_armo_old.id_armo = kds_prof_x_esolver.getitemnumber( k_riga, "id_armo")
				kst_tab_s_armo_old.clie_3 = kds_prof_x_esolver.getitemnumber( k_riga, "clie_3")
				
				k_ctr_lotti_tes = k_rec + 1

//--- testata			
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes] = kst_prof_trk_fidi_esolver_null
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].tipo_record = "TES"
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].tes_reg_dt = string(kds_prof_x_esolver.getitemdate( k_riga, "data_int") , "ddmmyyyy")
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].xxx_reg_nr = string(kds_prof_x_esolver.getitemnumber( k_riga, "num_int"))
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].tes_id_cliente = string(kds_prof_x_esolver.getitemnumber( k_riga, "clie_3"))
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].tes_valuta = "EUR"
				ast_prof_trk_fidi_esolver[k_ctr_lotti_tes].tes_cambio = "1"
				k_rec ++   //incrementa il numero riga
			end if

//--- la riga			
			k_rec ++   //numero riga
			ast_prof_trk_fidi_esolver[k_rec] = ast_prof_trk_fidi_esolver[k_ctr_lotti_tes]
			ast_prof_trk_fidi_esolver[k_rec].tipo_record = "RIG"
			
			if kds_prof_x_esolver.getitemnumber( k_riga, "gru_conto") > 0 and kds_prof_x_esolver.getitemnumber( k_riga, "gru_s_conto") > 0  then  // CONTO+S.CONTO
				ast_prof_trk_fidi_esolver[k_rec].rig_tipo_riga = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "gru_conto"),"000")) + trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "gru_s_conto"),"0000000"))
			else
				ast_prof_trk_fidi_esolver[k_rec].rig_tipo_riga = " "
			end if
			ast_prof_trk_fidi_esolver[k_rec].rig_importovaluta = trim(string(round(kds_prof_x_esolver.getitemnumber( k_riga, "imp_da_fatt"),2))) // IMPORTO
			if kds_prof_x_esolver.getitemnumber( k_riga, "iva") > 0 then
				ast_prof_trk_fidi_esolver[k_rec].rig_ivacodice = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "iva")))
			else
//--- se il cliente non ha IVA (di solito è 'fuori campo iva' l'estrazione dell'IVA avviene dalla riga lotto (dall'articolo)			
				kst_tab_armo.id_armo = kds_prof_x_esolver.getitemnumber( k_riga, "id_armo")
				kst_tab_armo.art = kuf1_armo.get_art(kst_tab_armo)
				kst_tab_prodotti.codice = kst_tab_armo.art
				kst_tab_prodotti.iva = kuf1_prodotti.get_iva(kst_tab_prodotti)
				ast_prof_trk_fidi_esolver[k_rec].rig_ivacodice = trim(string(kst_tab_prodotti.iva))
				
//				ast_prof_trk_fidi_esolver[k_rec].rig_ivacodice = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prodotti_iva")))
			end if 
			ast_prof_trk_fidi_esolver[k_rec].rig_importo_udc = trim(string(round(kds_prof_x_esolver.getitemnumber( k_riga, "imp_da_fatt"),2)))
			
			
			k_riga++
			
		loop
	end if 

	k_return = k_rec

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return k_return
end function

public function integer esolver_esporta_fatt_old (st_prof_exp_fatt ast_prof_exp_fatt) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Esporta archivio Anagrafiche da passare a ESOLVER
//--- 
//--- Input: 'path + nome del file' delle fatture da passare a ESOLVER
//--- out: 
//--- Rit: numero fatture scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_riga, k_righe, k_filenum, k_byte, k_nr_fatt=0
string k_record="", k_nome_file, k_path
st_prof_trk_fatt_esolver kst_prof_trk_fatt_esolver[]
st_tab_prof kst_tab_prof[]
kuf_prof kuf1_prof
pointer kp_originale
kuf_utility kuf1_utility
st_esito kst_esito


kp_originale = setpointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_righe = esolver_popola_st_prof_exp_fatt(ast_prof_exp_fatt, kst_prof_trk_fatt_esolver[])
	if k_righe = 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessuna Fattura/N.C. trovata da esportare in Contabilità. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

		kuf1_utility = create kuf_utility
		
		k_nome_file = kuf1_utility.u_get_nome_file(ast_prof_exp_fatt.nome_file )
		k_path = kuf1_utility.u_get_path_file(ast_prof_exp_fatt.nome_file)
		if len(k_path) > 0 then
			kguo_path.u_drectory_create(k_path)
		end if
		
		k_FileNum = FileOpen(ast_prof_exp_fatt.nome_file, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore durante apertura archivio Fatture x la Contabilità: " + trim(ast_prof_exp_fatt.nome_file) + " "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		for k_riga = 1 to k_righe
			
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tipo_record) then kst_prof_trk_fatt_esolver[k_riga].tipo_record = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_reg_dt ) then  kst_prof_trk_fatt_esolver[k_riga].tes_reg_dt = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_tipo_doc ) then  kst_prof_trk_fatt_esolver[k_riga].tes_tipo_doc = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].xxx_reg_nr ) then  kst_prof_trk_fatt_esolver[k_riga].xxx_reg_nr = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_ivaregistro ) then  kst_prof_trk_fatt_esolver[k_riga].tes_ivaregistro = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_f_splitpayment ) then  kst_prof_trk_fatt_esolver[k_riga].tes_f_splitpayment = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_contoesolver_codice ) then  kst_prof_trk_fatt_esolver[k_riga].tes_contoesolver_codice = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].xxx_id_cliente) then  kst_prof_trk_fatt_esolver[k_riga].xxx_id_cliente = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_valuta) then  kst_prof_trk_fatt_esolver[k_riga].tes_valuta = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_cambio) then  kst_prof_trk_fatt_esolver[k_riga].tes_cambio = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_cod_pag ) then  kst_prof_trk_fatt_esolver[k_riga].tes_cod_pag = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_iva_anno) then  kst_prof_trk_fatt_esolver[k_riga].tes_iva_anno = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_iva_periodo) then  kst_prof_trk_fatt_esolver[k_riga].tes_iva_periodo = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_iva_territ ) then  kst_prof_trk_fatt_esolver[k_riga].tes_iva_territ = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].tes_importo) then  kst_prof_trk_fatt_esolver[k_riga].tes_importo = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].rig_conto_codice) then  kst_prof_trk_fatt_esolver[k_riga].rig_conto_codice = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].rig_importovaluta) then  kst_prof_trk_fatt_esolver[k_riga].rig_importovaluta = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].rig_ivacodice) then  kst_prof_trk_fatt_esolver[k_riga].rig_ivacodice = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].iva_codice_1) then  kst_prof_trk_fatt_esolver[k_riga].iva_codice_1 = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].iva_imponibile_valuta) then  kst_prof_trk_fatt_esolver[k_riga].iva_imponibile_valuta = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].iva_importo_iva_valuta) then  kst_prof_trk_fatt_esolver[k_riga].iva_importo_iva_valuta = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].par_scadenza_dt) then  kst_prof_trk_fatt_esolver[k_riga].par_scadenza_dt = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].par_pag_tipo) then  kst_prof_trk_fatt_esolver[k_riga].par_pag_tipo = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_abi) then  kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_abi = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_cab) then  kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_cab = ""
			if isnull(kst_prof_trk_fatt_esolver[k_riga].par_scadenza_rata_importo) then  kst_prof_trk_fatt_esolver[k_riga].par_scadenza_rata_importo = ""

//---- setto st tab fatture x fare poi l'aggiornamento
			if kst_prof_trk_fatt_esolver[k_riga].tipo_record = "TES" then
				k_nr_fatt ++
				kst_tab_prof[k_nr_fatt].id_fattura = kst_prof_trk_fatt_esolver[k_riga].id_fattura
			end if
			
			k_record = kst_prof_trk_fatt_esolver[k_riga].tipo_record + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_reg_dt  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_tipo_doc  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].xxx_reg_nr  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_f_splitpayment  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_contoesolver_codice  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].xxx_id_cliente  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_valuta  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_cambio  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_cod_pag  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_iva_anno + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_iva_periodo + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_iva_territ  + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].tes_importo + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].rig_conto_codice + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].rig_importovaluta + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].rig_ivacodice + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].iva_codice_1 + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].iva_imponibile_valuta + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].iva_importo_iva_valuta + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].par_scadenza_dt + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].par_pag_tipo + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_abi + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].par_banca_cliente_cab + ";" &
							+ kst_prof_trk_fatt_esolver[k_riga].par_scadenza_rata_importo  + " " 

			k_byte = FileWrite(k_FileNum, k_record)
			if k_byte < 0 then 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore durante scrittura Fatture/N.C. x la Contabilità su file: " + trim(ast_prof_exp_fatt.nome_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			
		end for
		
//--- aggiorna tabella a ESPORTATO
		if ast_prof_exp_fatt.aggiorna = 1 then
			kuf1_prof = create kuf_prof
			kuf1_prof.set_fatture_esportate(kst_tab_prof[])
		end if
		
		k_return = k_nr_fatt
		
	end if
	

	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	FileClose(k_FileNum)
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_prof) then destroy kuf1_prof
	setpointer(kp_originale)

end try

return k_return


end function

public function integer eone_esporta_fatt (st_prof_exp_fatt ast_prof_exp_fatt) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Esporta archivio Fartture (movimenti) da passare a STERIGENICS E-ONE
//--- 
//--- Input: 'path + nome del file' delle fatture da esportare 
//--- out: 
//--- Rit: numero fatture scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_riga, k_righe, k_filenum, k_byte, k_nr_fatt=0, k_len
string k_record="", k_nome_file, k_path, k_importo, k_importo_iva
long k_id_fattura
st_prof_trk_fatt_navision kst_prof_trk_fatt_navision[]
st_tab_prof kst_tab_prof[]
kuf_prof kuf1_prof
pointer kp_originale
kuf_utility kuf1_utility
st_esito kst_esito


kp_originale = setpointer(hourglass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_righe = eone_popola_st_prof_exp_fatt(ast_prof_exp_fatt, kst_prof_trk_fatt_navision[])
	if k_righe <= 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessun documento Fattura/N.C. trovato da esportare in Contabilità. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

		kuf1_utility = create kuf_utility
		
		k_nome_file = kuf1_utility.u_get_nome_file(ast_prof_exp_fatt.nome_file )
		k_path = kuf1_utility.u_get_path_file(ast_prof_exp_fatt.nome_file)
		if len(k_path) > 0 then
			kguo_path.u_drectory_create(k_path)
		end if
		
		k_FileNum = FileOpen(ast_prof_exp_fatt.nome_file, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore durante apertura archivio Fatture x la Contabilità: " + trim(ast_prof_exp_fatt.nome_file) + " "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_id_fattura = 0
		for k_riga = 1 to k_righe
			
//---- setto st tab fatture x fare poi l'aggiornamento
			if kst_prof_trk_fatt_navision[k_riga].id_fattura <> k_id_fattura then
				k_nr_fatt ++
				kst_tab_prof[k_nr_fatt].id_fattura = kst_prof_trk_fatt_navision[k_riga].id_fattura
			end if
			
//--- sistema l'importo ad esempio  '11234,33-'  diventa  '   -11234.33' 			
			k_len = len(trim(kst_prof_trk_fatt_navision[k_riga].importo))
			if right(trim(kst_prof_trk_fatt_navision[k_riga].importo), 1) = "-" then
				k_importo = space(12) + "-" + left(trim(kst_prof_trk_fatt_navision[k_riga].importo), k_len - 1) 
			else
				k_importo = space(12) + trim(kst_prof_trk_fatt_navision[k_riga].importo)
			end if
			k_importo = right(k_importo, 12)
			
//--- sistema l'importo IVA ad esempio  '11234,33-'  diventa  '   -11234.33' 			
			k_len = len(trim(kst_prof_trk_fatt_navision[k_riga].iva_importo))
			if right(trim(kst_prof_trk_fatt_navision[k_riga].iva_importo), 1) = "-" then
				k_importo_iva = space(12) + "-" + left(trim(kst_prof_trk_fatt_navision[k_riga].iva_importo), k_len - 1) 
			else
				k_importo_iva = space(12) + trim(kst_prof_trk_fatt_navision[k_riga].iva_importo)
			end if
			
			k_record = &
								left(kst_prof_trk_fatt_navision[k_riga].company + space(10), 10) + &
							+	left(kst_prof_trk_fatt_navision[k_riga].xxx_id_cliente + space(10), 10) + &    
							+	left(kst_prof_trk_fatt_navision[k_riga].tes_tipo_doc + space(11), 11) + &      
							+	left(kst_prof_trk_fatt_navision[k_riga].xxx_reg_nr + space(10), 10) + &        
							+	left(string(kst_prof_trk_fatt_navision[k_riga].line_number, "000000"), 06) + &       
							+	left(kst_prof_trk_fatt_navision[k_riga].tes_reg_dt + space(08), 08) + &        
							+	left(kst_prof_trk_fatt_navision[k_riga].par_scadenza_dt + space(08), 08) + &   
							+	left(kst_prof_trk_fatt_navision[k_riga].divisa + space(03), 03) + &            
							+	left(kst_prof_trk_fatt_navision[k_riga].conto + space(10), 10) + &             
							+	left(kst_prof_trk_fatt_navision[k_riga].cost_center + space(02), 02) + &             
							+	left(kst_prof_trk_fatt_navision[k_riga].dim3 + space(05), 05) + &             
							+	left(kst_prof_trk_fatt_navision[k_riga].dim4 + space(03), 03) + &             
							+	right((space(12) + kuf1_utility.u_num_itatousa2(k_importo, false)),12) + &           
							+	right((space(12) + kuf1_utility.u_num_itatousa2(k_importo, false)),12) + &           
							+	right((space(12) + kuf1_utility.u_num_itatousa2(k_importo_iva, false)),12) + &           
							+	right((space(12) + kuf1_utility.u_num_itatousa2(k_importo_iva, false)),12) + &           
							+	left(kst_prof_trk_fatt_navision[k_riga].ivacodice + space(20), 20)          
								

			k_byte = FileWrite(k_FileNum, k_record)
			if k_byte < 0 then 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore durante scrittura Fatture/N.C. x la Contabilità su file: " + trim(ast_prof_exp_fatt.nome_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			
		end for
		
//--- aggiorna tabella a ESPORTATO
		if ast_prof_exp_fatt.aggiorna = 1 then
			kuf1_prof = create kuf_prof
			kuf1_prof.set_fatture_esportate(kst_tab_prof[])
		end if
		
		k_return = k_nr_fatt
		
	end if
	

	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	FileClose(k_FileNum)
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_prof) then destroy kuf1_prof
	setpointer(kp_originale)

end try

return k_return


end function

public function integer eone_popola_st_prof_exp_fatt (ref st_prof_exp_fatt ast_prof_exp_fatt, ref st_prof_trk_fatt_navision kst_prof_trk_fatt_navision[]) throws uo_exception;//
//--- Estrate fatture indicate x fare esportazione su ESOLVER
//--- Inp: st_prof_exp_fatt = id_fattura 'da... a...'
//--- Out: st_prof_trk_fatt_esolver array con numero righe Fatture esportate 
//--- Rit: numero righe prodotte (0=nessuna)
//
int k_return = 0
int k_ctr, k_anno, k_riga, k_ctr_fatt=0, k_rec=0, k_scad, k_num_fatt
long k_rcn=0, k_righe_retrieved
string k_conto_iva, k_esito, k_tipo_doc_desc="", k_tipo_doc = ""
decimal k_imposta = 0.00 , k_importo_iva = 0.00
st_tab_arfa kst_tab_arfa
st_tab_prof kst_tab_prof
st_esito kst_esito
//st_tab_clienti kst_tab_clienti_old
//st_tab_pagam kst_tab_pagam_old
st_fattura_totali kst_fattura_totali
st_tab_iva kst_tab_iva
kuf_fatt kuf1_fatt
kuf_prof kuf1_prof
kuf_ausiliari kuf1_ausiliari
kuf_base kuf1_base
datastore kds_prof_x_esolver, kds_prof_x_esolver_rate


try
	kuf1_fatt = create kuf_fatt
	kuf1_prof = create kuf_prof
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_base = create kuf_base

//--- definizione datastore x estrazione fatture e scadenze
	kds_prof_x_esolver = create datastore
	kds_prof_x_esolver.dataobject = kki_exp_fatt_datastore
	kds_prof_x_esolver.settransobject( kguo_sqlca_db_magazzino )
	kds_prof_x_esolver_rate = create datastore
	kds_prof_x_esolver_rate.dataobject = kki_exp_fatt_rate_datastore
	kds_prof_x_esolver_rate.settransobject( kguo_sqlca_db_magazzino )
	
//--- lancia estrazione fatture 
//	if kds_prof_x_esolver.retrieve(ast_prof_exp_fatt.id_fattura_da, ast_prof_exp_fatt.id_fattura_a, ast_prof_exp_fatt.profis ) > 0 then 
	k_rcn = kds_prof_x_esolver.retrieve(ast_prof_exp_fatt.num_fattura_da, ast_prof_exp_fatt.num_fattura_a, ast_prof_exp_fatt.data_fattura_da,  ast_prof_exp_fatt.data_fattura_a, ast_prof_exp_fatt.profis ) 
	if k_rcn > 0 then 

		k_esito = kuf1_base.prendi_dato_base( "iva_conto")
		if left(k_esito,1) <> "0" then
			kst_esito.nome_oggetto = this.classname()
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = mid(k_esito,2)
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		k_conto_iva	= mid(k_esito,2)
		if k_conto_iva > " " then
		else
			kst_esito.nome_oggetto = this.classname()
			kst_esito.esito = kkg_esito.dati_insuff 
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Manca il codice conto contabile IVA in archivio Proprietà Azienda"
			kguo_exception.set_esito(kst_esito)
		end if

		kst_tab_arfa.id_fattura = 0
		k_rec = 1 // numero record della tabella
		k_ctr_fatt = 0 // contatore rec trattati
		k_num_fatt = 0 // contatore fatture trattate 
		k_riga=1
		
		k_righe_retrieved = kds_prof_x_esolver.rowcount( )
		for k_riga = 1 to k_righe_retrieved

			
//--- il primo rec della fattura dovrebbe SEMPRE essere PROF_FLAG = "A"	quindi il TOTALE CLIENTE
			if trim(kds_prof_x_esolver.getitemstring( k_riga, "prof_flag")) = "A" then
				
				k_num_fatt ++ // numeratore fattura
				k_ctr_fatt += k_rec // numeratore assoluto righe
				k_rec = 0  // inizializza il numeratore righe fattura

				kst_tab_arfa.id_fattura = kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura")
				kst_tab_arfa.num_fatt = kds_prof_x_esolver.getitemnumber( k_riga, "prof_num_fatt")
				kst_tab_arfa.data_fatt = kds_prof_x_esolver.getitemdate( k_riga, "prof_data_fatt")
				kuf1_fatt.get_totali(kst_tab_arfa, kst_fattura_totali )  // get totali IVA (imponibili, importi....)

				k_tipo_doc = trim(kds_prof_x_esolver.getitemstring( k_riga, "prof_tipo_doc"))
				if k_tipo_doc = "NC" then
					k_tipo_doc_desc = "Credit Memo"  // nota accredito 
				else
					k_tipo_doc_desc = "Invoice" // fattura
				end if
				
//--- dati iniziali				
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].id_fattura = kds_prof_x_esolver.getitemnumber( k_riga, "id_fattura")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].company = "        27"
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].xxx_id_cliente = string(kds_prof_x_esolver.getitemnumber( k_riga, "clienti_codice"))
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].tes_tipo_doc = k_tipo_doc_desc 
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].xxx_reg_nr = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_num_fatt"),"000000000")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].line_number = k_rec + 1
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].tes_reg_dt = string(kds_prof_x_esolver.getitemdate( k_riga, "prof_data_fatt"), "ddmmyyyy")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].par_scadenza_dt = string(kds_prof_x_esolver.getitemdate( k_riga, "prof_data_fatt"), "ddmmyyyy")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].divisa = "EUR"
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].conto = string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_conto")) 
				if k_tipo_doc = "NC" then
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(abs(kst_fattura_totali.totale),"########0.00") + "-"
				else
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(abs(kst_fattura_totali.totale),"########0.00")
				end if
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importo = string("        0,00")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importovaluta = string("        0,00")
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].ivacodice = ""
				
//--- Inizio con le righe con le RATE se non è NC
				if k_tipo_doc = "NC" then
					k_rec ++
				else
					if kds_prof_x_esolver_rate.retrieve(kst_tab_arfa.num_fatt, kst_tab_arfa.data_fatt) > 0 then 
						for k_scad = 1 to kds_prof_x_esolver_rate.getrow( ) // GET delle RATE
							kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec] = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec]  // copia dal precedente
							kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].line_number = k_rec + 1
							kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].par_scadenza_dt = string(kds_prof_x_esolver_rate.getitemdate(k_scad, "scad"), "ddmmyyyy")
							kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(kds_prof_x_esolver_rate.getitemnumber(k_scad, "rata"),"########0.00")
							kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo
							k_rec ++
						end for
					else
						k_rec ++
					end if
				end if

//--- Riga IVA			
				k_imposta = 0
				if kst_fattura_totali.imposta_1 <> 0 then
					k_imposta = kst_fattura_totali.imposta_1
				end if
				if kst_fattura_totali.imposta_2 <> 0 then
					k_imposta += kst_fattura_totali.imposta_2
				end if
				if kst_fattura_totali.imposta_3 <> 0 then
					k_imposta += kst_fattura_totali.imposta_3
				end if
				if kst_fattura_totali.imposta_4 <> 0 then
					k_imposta += kst_fattura_totali.imposta_4
				end if
				if kst_fattura_totali.imposta_5 <> 0 then
					k_imposta += kst_fattura_totali.imposta_5
				end if
				if k_imposta = 0 then
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec] = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec - 1]  // copia dal precedente
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].line_number = k_rec + 1
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].conto = k_conto_iva
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(0.00,"#######0.00")
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].ivacodice = string(kst_fattura_totali.cod_1)
					k_rec ++
				else
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec] = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec - 1]  // copia dal precedente
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].line_number = k_rec + 1
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].conto = k_conto_iva
					if k_tipo_doc = "NC" then
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(k_imposta,"#######0.00")
					else
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(k_imposta,"#######0.00") + "-"
					end if
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].ivacodice = string(kst_fattura_totali.cod_1)
					k_rec ++
				end if


			else  

//--- Contropartita	
//15022016 scartava i documenti a ZERO				if kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo") <> 0 then
					
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec] = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec - 1]  // copia dal precedente
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].line_number = k_rec + 1
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].conto = trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_conto")) )+ "." + trim(string(kds_prof_x_esolver.getitemnumber( k_riga, "prof_s_conto")))
				if k_tipo_doc = "NC" then
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo"),"#######0.00") 
				else
					if kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo") < 0 then // se imp negativo sono SCONTI, RIMBORSI ....
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(abs(kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo")),"#######0.00") 
					else
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo = string(kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo"),"#######0.00") + "-"
					end if
				end if
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].importo
				kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importo = string('        0,00')
				kst_tab_iva.codice = 0
				if kst_fattura_totali.cod_1 = kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva") then
					if kst_fattura_totali.imposta_1 <> 0 then
						kst_tab_iva.codice = kst_fattura_totali.cod_1
					end if
				elseif kst_fattura_totali.cod_2 = kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva") then
					if kst_fattura_totali.imposta_2 <> 0 then
						kst_tab_iva.codice = kst_fattura_totali.cod_2
					end if
				elseif kst_fattura_totali.cod_3 = kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva") then
					if kst_fattura_totali.imposta_3 <> 0 then
						kst_tab_iva.codice = kst_fattura_totali.cod_3
					end if
				elseif kst_fattura_totali.cod_4 = kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva") then
					if kst_fattura_totali.imposta_4 <> 0 then
						kst_tab_iva.codice = kst_fattura_totali.cod_4
					end if
				elseif kst_fattura_totali.cod_5 = kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva") then
					if kst_fattura_totali.imposta_5 <> 0 then
						kst_tab_iva.codice = kst_fattura_totali.cod_5
					end if
				end if
				if kst_tab_iva.codice > 0 then
//--- calcolo importo preciso ,ci potrebbero essere piu' righe con la stessa aliquota quindi non posso mettere il totale IVA 
					kuf1_ausiliari.tb_select(kst_tab_iva) // get dell'aliquota
					if kst_tab_iva.aliq > 0.00 then 
						k_importo_iva = round(((kds_prof_x_esolver.getitemnumber(k_riga, "prof_importo") * (kst_tab_iva.aliq / 100)) ), 2) 
					else
						k_importo_iva = 0.00
					end if
					if k_tipo_doc = "NC" then
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importo = string(k_importo_iva,"#######0.00") 
					else
						kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importo = string(k_importo_iva,"#######0.00") + "-"
					end if
//					end if
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importovaluta = kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].iva_importo
					kst_prof_trk_fatt_navision[k_ctr_fatt+k_rec].ivacodice = string(kds_prof_x_esolver.getitemnumber(k_riga, "prof_iva"))
	
				end if
				k_rec ++

			end if
				
			
		end for
	end if 

	k_return = k_ctr_fatt+k_rec - 1

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_prof) then destroy kuf1_prof
	if isvalid(kuf1_fatt) then destroy kuf1_fatt
	if isvalid(kds_prof_x_esolver) then destroy kds_prof_x_esolver
	if isvalid(kds_prof_x_esolver_rate) then destroy kds_prof_x_esolver_rate
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	if isvalid(kuf1_base) then destroy kuf1_base
	
end try


return k_return
end function

on kuf_prof_exp.create
call super::create
end on

on kuf_prof_exp.destroy
call super::destroy
end on

event destructor;call super::destructor;//
//--- Chiude la window 
//
if isvalid(kiw_profis_exp_fatt) then kiw_profis_exp_fatt.chiudi_immediato()

end event

