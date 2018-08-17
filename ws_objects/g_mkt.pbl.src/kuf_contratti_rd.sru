$PBExportHeader$kuf_contratti_rd.sru
forward
global type kuf_contratti_rd from kuf_parent
end type
end forward

global type kuf_contratti_rd from kuf_parent
end type
global kuf_contratti_rd kuf_contratti_rd

type variables
//
//
private constant string kki_form_di_stampa_attuale = "d_contratti_rd_st0_ed60718" //"d_contratti_rd_st0_ed50516" //"d_contratti_rd_st0_ed40515" //"d_contratti_rd_st0_ed30115" //d_contratti_rd_st0_ed40515"  //"d_contratti_rd_st0_ed20614" // "d_contratti_rd_st0_ed10613" //"d_contratti_rd_st_ed00512" //"d_contratti_rd_st_ed80511" // "d_contratti_rd_st_ed70110"  //"d_contratti_rd_st_ed60809"  //"d_contratti_rd_st_ed1208"
private kuf_esito_operazioni kiuf_esito_operazioni

//---- campo STATO contratto
constant string kki_STATO_nuovo = '1' // nuovo contratto
constant string kki_STATO_riaperto = '2' // contratto Riaperto
constant string kki_STATO_stampato = '3' // contratto stampato definitivamente
constant string kki_STATO_accettato = '5' // contratto Accettato dal cliente
constant string kki_STATO_respinto = '6' // contratto NON Accettato dal cliente
constant string kki_STATO_trasferito = '7' // contratto Trasferito al LISTINO/CONTRATTI
constant string kki_STATO_annullato = '9' // contratto ANNULLATO




end variables
forward prototypes
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito select_riga (ref st_tab_contratti_rd k_st_tab_contratti_rd)
public function st_esito tb_delete (st_tab_contratti_rd kst_tab_contratti_rd)
public subroutine if_isnull (ref st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito get_ultimo_id (ref st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito get_dati_default (ref st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_rd kst_tab_contratti_rd)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito stampa_documento_definitiva (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function st_esito stampa_documento_prova (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function st_esito get_id_cliente (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function boolean set_id_docprod (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function long aggiorna_docprod (ref st_tab_contratti_rd kst_tab_contratti_rd[]) throws uo_exception
public function boolean get_form_di_stampa (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function st_esito get_offerta_data (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean if_esiste (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
public function boolean get_stato (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
private function st_esito set_stato (ref st_tab_contratti_rd kst_tab_contratti_rd)
private function boolean set_form_di_stampa (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
private function boolean set_data_stampa (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_rd, st_tab_contratti kst_tab_contratti, st_contratti_rd_to_listini kst_contratti_rd_to_listini) throws uo_exception
public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_rd kst_tab_contratti_rd, st_contratti_rd_to_listini kst_contratti_rd_to_listini) throws uo_exception
public function st_esito set_trasferito (st_tab_contratti_rd kst_tab_contratti_rd)
private function st_esito set_ts_esito_operazione (ref st_tab_contratti_rd kst_tab_contratti_rd)
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public subroutine log_destroy ()
public subroutine log_inizializza () throws uo_exception
public function ds_contratti_rd_select get_dati (st_tab_contratti_rd kst_tab_contratti_rd)
private function st_esito stampa_documento_print (ref datastore kds_print, st_tab_contratti_rd ast_tab_contratti_rd)
private function st_esito stampa_documento_obsoleto (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception
private function st_esito stampa_documento (st_tab_contratti_rd ast_tab_contratti_rd) throws uo_exception
end prototypes

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti_rd kst_tab_contratti_rd);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if isvalid(kdw_anteprima)  then
			if kdw_anteprima.dataobject = "d_contratti_rd"  then
				if kdw_anteprima.object.id_contratto_rd[1] = kst_tab_contratti_rd.id_contratto_rd  then
					kst_tab_contratti_rd.id_contratto_rd = 0 
				end if
			end if
		end if
	
		if kst_tab_contratti_rd.id_contratto_rd > 0 then
		
			kdw_anteprima.dataobject = "d_contratti_rd"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_rd.id_contratto_rd)
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti_rd kst_tab_contratti_rd);//
//=== 
//====================================================================
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

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_contratti

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
		if kdw_anteprima.dataobject = "d_contratti_rd"  then
			if kdw_anteprima.object.id_contratto_rd[1] = kst_tab_contratti_rd.id_contratto_rd  then
				kst_tab_contratti_rd.id_contratto_rd = 0 
			end if
		end if
	end if

	if kst_tab_contratti_rd.id_contratto_rd > 0 then
	
			kdw_anteprima.dataobject = "d_contratti_rd"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti_rd.id_contratto_rd)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito select_riga (ref st_tab_contratti_rd k_st_tab_contratti_rd);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	k_codice = k_st_tab_contratti.codice
//	
//	select 
//			 mc_co,
//			 sc_cf,
//			 sl_pt,
//			 data,
//			 data_scad,
//			 cod_cli,
//			 descr,
//			 cert_st_dose_min,
//			 cert_st_dose_max,
//			 cert_st_data_ini,
//			 cert_st_data_fin,
//			 cert_st_dati_bolla_in
//			 ,tipo
//			 ,costi_accessori
//	 into 
//			:k_st_tab_contratti.mc_co,
//			:k_st_tab_contratti.sc_cf,
//			:k_st_tab_contratti.sl_pt,
//			:k_st_tab_contratti.data,
//			:k_st_tab_contratti.data_scad,
//			:k_st_tab_contratti.cod_cli,
//			:k_st_tab_contratti.descr,
//			:k_st_tab_contratti.cert_st_dose_min,
//			:k_st_tab_contratti.cert_st_dose_max,
//			:k_st_tab_contratti.cert_st_data_ini,
//			:k_st_tab_contratti.cert_st_data_fin,
//			:k_st_tab_contratti.cert_st_dati_bolla_in
//			,:k_st_tab_contratti.tipo
//			,:k_st_tab_contratti.costi_accessori
//		from contratti
//		where 
//		codice = :k_codice
//		using sqlca;
//
//	
//	if sqlca.sqlcode <> 0 then
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Tab.Contratti (codice=" + string(k_codice) + ") : " &
//									 + trim(SQLCA.SQLErrText)
//		if sqlca.sqlcode = 100 then
//			kst_esito.esito = "100"
//		else
//			if sqlca.sqlcode > 0 then
//				kst_esito.esito = "2"
//			else	
//				kst_esito.esito = "1"
//			end if
//		end if
//	end if
	
return kst_esito


end function

public function st_esito tb_delete (st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Cancella il rek dalla tabella contratti_rd 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
st_open_w kst_open_w
st_tab_docprod kst_tab_docprod
kuf_sicurezza kuf1_sicurezza
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Contratto Studio Sviluppo' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try

		if kst_tab_contratti_rd.id_contratto_rd > 0 then
	
			delete from contratti_rd
				where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
				using sqlca;
	
			
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Contratto Studio Sviluppo' (contratti_rd):" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			else

//--- cancella da docprod	 tutti i riferimenti
				kst_tab_docprod.id_doc = kst_tab_contratti_rd.id_contratto_rd
				kuf1_docprod = create kuf_docprod
				kuf1_doctipo = create kuf_doctipo
				kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
				kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_contr_rd )

			end if
			
		end if
		
	catch 	(uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()


	finally
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
		
		if isvalid(kuf1_docprod) then destroy kuf1_docprod 
		if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
		
	
	
	end try
	
end if


return kst_esito

end function

public subroutine if_isnull (ref st_tab_contratti_rd kst_tab_contratti_rd);//---
//--- Inizializza i campi della tabella 
//---
if isnull(kst_tab_contratti_rd.id_contratto_rd ) then kst_tab_contratti_rd.id_contratto_rd = 0
if isnull(kst_tab_contratti_rd.abi ) then kst_tab_contratti_rd.abi = 0
if isnull(kst_tab_contratti_rd.altre_condizioni ) then kst_tab_contratti_rd.altre_condizioni = " "
if isnull(kst_tab_contratti_rd.anno ) then kst_tab_contratti_rd.anno = year(KG_DATAOGGI)
if isnull(kst_tab_contratti_rd.magazzino ) then kst_tab_contratti_rd.magazzino = kkg_magazzino.LAVORAZIONE
if isnull(kst_tab_contratti_rd.banca ) then kst_tab_contratti_rd.banca = " "
if isnull(kst_tab_contratti_rd.cab ) then kst_tab_contratti_rd.cab = 0
if isnull(kst_tab_contratti_rd.cod_pag ) then kst_tab_contratti_rd.cod_pag = 0
if isnull(kst_tab_contratti_rd.stampa_tradotta ) then kst_tab_contratti_rd.stampa_tradotta = ""
if isnull(kst_tab_contratti_rd.data_stampa ) then kst_tab_contratti_rd.data_stampa = date(0)
if isnull(kst_tab_contratti_rd.data_fine ) then kst_tab_contratti_rd.data_fine = date(0)
if isnull(kst_tab_contratti_rd.data_inizio ) then kst_tab_contratti_rd.data_inizio = date(0) //date(31, 12, year(KG_DATAOGGI) )

if isnull(kst_tab_contratti_rd.id_listino_pregruppo ) then kst_tab_contratti_rd.id_listino_pregruppo = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_1 ) then kst_tab_contratti_rd.id_listino_voce_1 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_2 ) then kst_tab_contratti_rd.id_listino_voce_2 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_3 ) then kst_tab_contratti_rd.id_listino_voce_3 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_4 ) then kst_tab_contratti_rd.id_listino_voce_4 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_5 ) then kst_tab_contratti_rd.id_listino_voce_5 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_6 ) then kst_tab_contratti_rd.id_listino_voce_6 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_7 ) then kst_tab_contratti_rd.id_listino_voce_7 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_8 ) then kst_tab_contratti_rd.id_listino_voce_8 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_9 ) then kst_tab_contratti_rd.id_listino_voce_9 = 0
if isnull(kst_tab_contratti_rd.id_listino_voce_10 ) then kst_tab_contratti_rd.id_listino_voce_10 = 0
if isnull(kst_tab_contratti_rd.voce_prezzo_1 ) then kst_tab_contratti_rd.voce_prezzo_1 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_2 ) then kst_tab_contratti_rd.voce_prezzo_2 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_3 ) then kst_tab_contratti_rd.voce_prezzo_3 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_4 ) then kst_tab_contratti_rd.voce_prezzo_4 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_5 ) then kst_tab_contratti_rd.voce_prezzo_5 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_6 ) then kst_tab_contratti_rd.voce_prezzo_6 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_7 ) then kst_tab_contratti_rd.voce_prezzo_7 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_8 ) then kst_tab_contratti_rd.voce_prezzo_8 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_9 ) then kst_tab_contratti_rd.voce_prezzo_9 = 0.00
if isnull(kst_tab_contratti_rd.voce_prezzo_10 ) then kst_tab_contratti_rd.voce_prezzo_10 = 0.00

if isnull(kst_tab_contratti_rd.fattura_da ) then kst_tab_contratti_rd.fattura_da = " "
if isnull(kst_tab_contratti_rd.gruppo ) then kst_tab_contratti_rd.gruppo = 0
if isnull(kst_tab_contratti_rd.id_clie_settore ) then kst_tab_contratti_rd.id_clie_settore = " "
if isnull(kst_tab_contratti_rd.id_cliente ) then kst_tab_contratti_rd.id_cliente = 0
if isnull(kst_tab_contratti_rd.art ) then kst_tab_contratti_rd.art = ""
if isnull(kst_tab_contratti_rd.iva ) then kst_tab_contratti_rd.iva = 0
if isnull(kst_tab_contratti_rd.nome_contatto ) then kst_tab_contratti_rd.nome_contatto = " "
if isnull(kst_tab_contratti_rd.note ) then kst_tab_contratti_rd.note = " "
if isnull(kst_tab_contratti_rd.note_audit ) then kst_tab_contratti_rd.note_audit = " "
if isnull(kst_tab_contratti_rd.offerta_data ) then kst_tab_contratti_rd.offerta_data = date(0)
if isnull(kst_tab_contratti_rd.offerta_validita ) then kst_tab_contratti_rd.offerta_validita = " "
if isnull(kst_tab_contratti_rd.oggetto ) then kst_tab_contratti_rd.oggetto = " "
if isnull(kst_tab_contratti_rd.flg_fatt_dopo_valid ) then kst_tab_contratti_rd.flg_fatt_dopo_valid = ""
if isnull(kst_tab_contratti_rd.acconto_perc ) then kst_tab_contratti_rd.acconto_perc = 0
if isnull(kst_tab_contratti_rd.acconto_imp ) then kst_tab_contratti_rd.acconto_imp = 0
if isnull(kst_tab_contratti_rd.acconto_cod_pag) then kst_tab_contratti_rd.acconto_cod_pag = 0
if isnull(kst_tab_contratti_rd.id_meca_causale ) then kst_tab_contratti_rd.id_meca_causale = 0

if isnull(kst_tab_contratti_rd.x_datins) then kst_tab_contratti_rd.x_datins = datetime(date(0))
if isnull(kst_tab_contratti_rd.x_utente) then kst_tab_contratti_rd.x_utente = " "

//campi obsoleti
if isnull(kst_tab_contratti_rd.fase_b1 ) then kst_tab_contratti_rd.fase_b1 = 0.00
if isnull(kst_tab_contratti_rd.fase_b2 ) then kst_tab_contratti_rd.fase_b2 = 0.00
if isnull(kst_tab_contratti_rd.fase_b3 ) then kst_tab_contratti_rd.fase_b3 = 0.00
if isnull(kst_tab_contratti_rd.fase_b4 ) then kst_tab_contratti_rd.fase_b4 = 0.00
if isnull(kst_tab_contratti_rd.fase_b5 ) then kst_tab_contratti_rd.fase_b5 = 0.00
if isnull(kst_tab_contratti_rd.fase_b6 ) then kst_tab_contratti_rd.fase_b6 = 0.00
if isnull(kst_tab_contratti_rd.fase_d1 ) then kst_tab_contratti_rd.fase_d1 = 0.00
if isnull(kst_tab_contratti_rd.fase_d2 ) then kst_tab_contratti_rd.fase_d2 = 0.00
if isnull(kst_tab_contratti_rd.fase_d3 ) then kst_tab_contratti_rd.fase_d3 = 0.00
if isnull(kst_tab_contratti_rd.fase_d4 ) then kst_tab_contratti_rd.fase_d4 = 0.00

end subroutine

public function st_esito get_ultimo_id (ref st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: st_tab_contratti_rd non valorizzata     Output: st_tab_contratti_rd.id_contratto_rd                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_contratti_rd.id_contratto_rd = 0
	
   SELECT   max(id_contratto_rd)
       into :kst_tab_contratti_rd.id_contratto_rd
		 FROM contratti_rd
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Contratto Studio&Sviluppo (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
	end if




return kst_esito




end function

public function st_esito get_dati_default (ref st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Torna l'ultimo dati Contratto di defualt x il caricamento
//=== 
//=== Input: st_tab_contratti_rd.anno      Output: st_tab_contratti_rd.*                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	if kst_tab_contratti_rd.anno = 0 or isnull( kst_tab_contratti_rd.anno) then
		kst_tab_contratti_rd.anno = year(kg_dataoggi) 
	end if
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_contratti_rd.id_contratto_rd = 0
	kst_tab_contratti_rd.stato = kki_STATO_nuovo
	
	  SELECT 
	 	contratti_rd.id_contratto_rd,
	  	contratti_rd.anno,   
         contratti_rd.offerta_data,   
         contratti_rd.offerta_validita,   
         contratti_rd.data_inizio,   
         contratti_rd.data_fine,   
         contratti_rd.oggetto,   
         contratti_rd.id_clie_settore,   
         contratti_rd.gruppo,   
         contratti_rd.iva,   
         contratti_rd.fattura_da,  
         contratti_rd.stampa_tradotta, 
         contratti_rd.id_listino_pregruppo,   
         contratti_rd.id_listino_voce_1,   
         contratti_rd.id_listino_voce_2,   
         contratti_rd.id_listino_voce_3,   
         contratti_rd.id_listino_voce_4,   
         contratti_rd.id_listino_voce_5,   
         contratti_rd.id_listino_voce_6,   
         contratti_rd.id_listino_voce_7,   
         contratti_rd.id_listino_voce_8,   
         contratti_rd.id_listino_voce_9,   
         contratti_rd.id_listino_voce_10,   
         contratti_rd.voce_prezzo_1,   
         contratti_rd.voce_prezzo_2,   
         contratti_rd.voce_prezzo_3,   
         contratti_rd.voce_prezzo_4,   
         contratti_rd.voce_prezzo_5,   
         contratti_rd.voce_prezzo_6,   
         contratti_rd.voce_prezzo_7,   
         contratti_rd.voce_prezzo_8,   
         contratti_rd.voce_prezzo_9,   
         contratti_rd.voce_prezzo_10   
    INTO
	 	:kst_tab_contratti_rd.id_contratto_rd,
	 	:kst_tab_contratti_rd.anno,   
         :kst_tab_contratti_rd.offerta_data,   
         :kst_tab_contratti_rd.offerta_validita,   
         :kst_tab_contratti_rd.data_inizio,   
         :kst_tab_contratti_rd.data_fine,   
         :kst_tab_contratti_rd.oggetto,   
         :kst_tab_contratti_rd.id_clie_settore,   
         :kst_tab_contratti_rd.gruppo,   
         :kst_tab_contratti_rd.iva,   
         :kst_tab_contratti_rd.fattura_da,  
         :kst_tab_contratti_rd.stampa_tradotta, 
         :kst_tab_contratti_rd.id_listino_pregruppo,   
         :kst_tab_contratti_rd.id_listino_voce_1,   
         :kst_tab_contratti_rd.id_listino_voce_2,   
         :kst_tab_contratti_rd.id_listino_voce_3,   
         :kst_tab_contratti_rd.id_listino_voce_4,   
         :kst_tab_contratti_rd.id_listino_voce_5,   
         :kst_tab_contratti_rd.id_listino_voce_6,   
         :kst_tab_contratti_rd.id_listino_voce_7,   
         :kst_tab_contratti_rd.id_listino_voce_8,   
         :kst_tab_contratti_rd.id_listino_voce_9,   
         :kst_tab_contratti_rd.id_listino_voce_10,   
         :kst_tab_contratti_rd.voce_prezzo_1,   
         :kst_tab_contratti_rd.voce_prezzo_2,   
         :kst_tab_contratti_rd.voce_prezzo_3,   
         :kst_tab_contratti_rd.voce_prezzo_4,   
         :kst_tab_contratti_rd.voce_prezzo_5,   
         :kst_tab_contratti_rd.voce_prezzo_6,   
         :kst_tab_contratti_rd.voce_prezzo_7,   
         :kst_tab_contratti_rd.voce_prezzo_8,   
         :kst_tab_contratti_rd.voce_prezzo_9,   
         :kst_tab_contratti_rd.voce_prezzo_10   
    FROM contratti_rd 
	where id_contratto_rd in 
		 (  SELECT   max(id_contratto_rd)
			 FROM contratti_rd 
			 where anno = :kst_tab_contratti_rd.anno
			 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_contratti_rd.anno = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Contratto Studio&Sviluppo ~n~r:" + trim(sqlca.SQLErrText)
		end if
	end if




return kst_esito




end function

public function st_esito get_ultimo_cliente_anno (ref st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Torna l'ultimo Contratto caricato nell'anno x il cliente indicato 
//=== 
//=== Input: st_tab_contratti_rd.anno e id_cliente     Output: st_tab_clienti.id_contratto_rd/offerta_data                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT  offerta_data, max(id_contratto_rd)  
       into :kst_tab_contratti_rd.id_contratto_rd
		 FROM contratti_rd
		 where id_cliente = :kst_tab_contratti_rd.id_cliente
		 	and offerta_data in (select max(offerta_data) from contratti_rd where id_cliente =  :kst_tab_contratti_rd.id_cliente and anno = :kst_tab_contratti_rd.anno)
			 group by 1
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Contratto Studio&Sviluppo (cercato Ultimo Documento) ~n~r:" + trim(sqlca.SQLErrText)
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
long k_rc
boolean k_return=true
st_tab_contratti_rd kst_tab_contratti_rd
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "id_contratto_rd"
		kst_tab_contratti_rd.id_contratto_rd = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
		if kst_tab_contratti_rd.id_contratto_rd > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_contratti_rd )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Contratto Studio e Sviluppo  (nr.=" + trim(string(kst_tab_contratti_rd.id_contratto_rd)) + ") " 
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
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
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
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito stampa_documento_definitiva (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//=== 
//====================================================================
//=== 
//=== Aggiorna Tabelle + Prepara + Stampa Contratto Studio Sviluppo
//===
//=== Par. Inut: kst_tab_contratti_rd (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
datawindow kdw_print
st_tab_contratti_rd kst_tab_contratti_rd_array[]
st_open_w kst_open_w
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Definitiva del Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_rd.id_contratto_rd > 0 then	

		try 
			
			
			kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()
			kst_tab_contratti_rd.stato = kki_STATO_stampato
	
//--- aggiorna archivio
			get_form_di_stampa(kst_tab_contratti_rd)
			if len(trim(kst_tab_contratti_rd.form_di_stampa)) > 0 then 
				kst_tab_contratti_rd.st_tab_g_0.esegui_commit = "N"
				set_form_di_stampa(kst_tab_contratti_rd)
			end if
			kst_tab_contratti_rd.st_tab_g_0.esegui_commit = "N"
			kst_esito = set_stato(kst_tab_contratti_rd)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti_rd.data_stampa = kg_dataoggi
				set_data_stampa(kst_tab_contratti_rd)
				kst_tab_contratti_rd_array[1] = kst_tab_contratti_rd
			else
				kst_tab_contratti_rd_array[1].id_contratto_rd = 0  // evita di caricare nell'archivio esporta-pdf
			end if				
	
//--- aggiorno archivio 		
//		UPDATE contratti_rd  
//     		SET data_stampa = :kg_dataoggi   
//         		,stato = :kst_tab_contratti_rd.stato
//				,form_di_stampa = :kst_tab_contratti_rd.form_di_stampa	
//				,x_datins =:kst_tab_contratti_rd.x_datins
//				,x_utente = :kst_tab_contratti_rd.x_utente
//   			WHERE contratti_rd.id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd   
// 			  using sqlca;


//--- LANCIA LA PREPARAZIONE E STAMPA !!!
			stampa_documento(kst_tab_contratti_rd)


		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )


		finally
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn or  kst_esito.esito = kkg_esito.no_esecuzione then 
				kst_esito = kGuf_data_base.db_commit_1( ) 	
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			else
				if kst_esito.sqlcode < 0 then
					kGuf_data_base.db_rollback_1( )
	
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Fallita Registrazione dati per stampa Documento: "+ string(kst_tab_contratti_rd.id_contratto_rd) + "~n~r"&
								 + "Errore: " + trim(sqlca.sqlerrtext)
					kst_esito.esito = kkg_esito.db_ko
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
			end if

		end try


//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
		try 

			kst_tab_contratti_rd_array[1].st_tab_g_0.esegui_commit = "S"
			aggiorna_docprod(kst_tab_contratti_rd_array[])
			
		catch (uo_exception kuo_exception2)
			kst_esito = kuo_exception2.get_st_esito( )
			kst_esito.sqlerrtext = "Archivio Contratto Commerciale Aggiornato Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)
			
		finally
		
		end try
				
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.blok
		
	end if
end if


return kst_esito

end function

public function st_esito stampa_documento_prova (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//=== 
//====================================================================
//=== 
//===Prova/Duplicato fa Preparazione + Stampa Contratto Studio Sviluppo (NO AGGIORNAMENTO)
//===
//=== Par. Inut: kst_tab_contratti_rd (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
datawindow kdw_print
st_open_w kst_open_w
st_esito kst_esito
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa (duplicato) Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_rd.id_contratto_rd > 0 then		

//--- LANCIA LA PREPARAZIONE E STAMPA !!!
		stampa_documento(kst_tab_contratti_rd)

		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato, registrazione dati non effettuata."
		kst_esito.esito = kkg_esito.blok
		
	end if
end if


return kst_esito

end function

public function st_esito get_id_cliente (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il Codice Cliente da id_contratto_rd 
//--- 
//--- 
//--- Input: st_tab_contratti_rd.id_contratto_rd
//--- Out: st_tab_contratti_rd.id_cliente
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



	SELECT
				contratti_rd.id_cliente
			into
		         :kst_tab_contratti_rd.id_cliente  
			 FROM contratti_rd  
			 where 
						(id_contratto_rd  = :kst_tab_contratti_rd.id_contratto_rd)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Contratto R. & D. (contratti_rd) id_contratto_rd = " + string(kst_tab_contratti_rd.id_contratto_rd) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
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
	

return kst_esito


end function

public function boolean set_id_docprod (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a id_docprod del Documento Esportato in Tabella contratti_rd
//--- 
//--- 
//--- Inp: st_tab_contratti_rd.id_contratto_rd  e  id_docprod
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
	
	
if kst_tab_contratti_rd.id_contratto_rd > 0 then

	kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE contratti_rd  
		  SET id_docprod = :kst_tab_contratti_rd.id_docprod
			,x_datins = :kst_tab_contratti_rd.x_datins
			,x_utente = :kst_tab_contratti_rd.x_utente
		WHERE contratti_rd.id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documenti Esportati' sulla tab. Contratti R. & D. ~n~r" &
					+ "Id: " + string(kst_tab_contratti_rd.id_contratto_rd, "####0") + "  " &
					+ " ~n~rErrore-tab.contratti_rd:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore aggiornamento tab. Contratti R. & D., Manca Identificativo (id_contratto_rd) !" 
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

public function long aggiorna_docprod (ref st_tab_contratti_rd kst_tab_contratti_rd[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_contratti_rd con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_contratto_rd=0, k_nr_contratto_rd=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
kuf_docprod kuf1_docprod


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_contratto_rd = upperbound(kst_tab_contratti_rd[])

	if k_nr_contratto_rd > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		for k_riga_contratto_rd = 1 to k_nr_contratto_rd

			try

				if kst_tab_contratti_rd[k_riga_contratto_rd].id_contratto_rd > 0 then
	
					get_offerta_data(kst_tab_contratti_rd[k_riga_contratto_rd])
					kst_tab_docprod.doc_num = kst_tab_contratti_rd[k_riga_contratto_rd].id_contratto_rd
					kst_tab_docprod.doc_data = kst_tab_contratti_rd[k_riga_contratto_rd].offerta_data
					kst_tab_docprod.id_doc = kst_tab_contratti_rd[k_riga_contratto_rd].id_contratto_rd
					
					
					kst_esito = get_id_cliente(kst_tab_contratti_rd[k_riga_contratto_rd])
					if kst_esito.esito = kkg_esito.db_ko then
						if isvalid(kuf1_docprod) then destroy kuf1_docprod
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					
					kst_tab_docprod.id_cliente = kst_tab_contratti_rd[k_riga_contratto_rd].id_cliente
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_contratti_rd[1].st_tab_g_0.esegui_commit
	
					kuf1_docprod.tb_add_contratti_rd ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
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

public function boolean get_form_di_stampa (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il nome del Dataobject (datawindow) da contratti_rd ad esempio: "d_contratti_rd_stampa_2006"
//--- 
//--- 
//--- Input: st_tab_contratti_rd.id_contratto_rd
//--- Out: id, data_stampa, form_di_stampa
//---
//--- Ritorna true = ok
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select data_stampa, form_di_stampa
	  into :kst_tab_contratti_rd.data_stampa, :kst_tab_contratti_rd.form_di_stampa 
	  from contratti_rd 
	  where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd  
	  using sqlca;
	

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Recupero nome Form di stampa Contratto R. & D. (tab. contratti_rd id=" + string(kst_tab_contratti_rd.id_contratto_rd) + " " + "): " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_contratti_rd.form_di_stampa)) > 0 then
	else
		kst_tab_contratti_rd.form_di_stampa = kki_form_di_stampa_attuale
//		kst_tab_contratti_rd.form_di_stampa = ""
	end if
	if isnull(kst_tab_contratti_rd.data_stampa) then
		kst_tab_contratti_rd.data_stampa = KKG.DATA_ZERO
	end if
	
	k_return = true 

return k_return


end function

public function st_esito get_offerta_data (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna Data dell'Offerta da Contratto rd 
//--- 
//--- 
//--- Input: st_tab_contratti_rd.id_contratto_rd
//--- Out: st_tab_contratti_rd.offerta_data
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



	SELECT
				contratti_rd.offerta_data
			into
		         :kst_tab_contratti_rd.offerta_data  
			 FROM contratti_rd  
			 where 
						(id_contratto_rd  = :kst_tab_contratti_rd.id_contratto_rd)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura 'Data Offerta' nel Contratto R. & D. (contratti_rd) id_contratto_rd = " + string(kst_tab_contratti_rd.id_contratto_rd) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
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
	

return kst_esito


end function

public function long stampa_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//---
//---  Esporta in digitale (pdf) i CONTRATTI
//---
boolean k_sicurezza
int k_item_doc, k_rc, k_n_documenti_stampati, k_id_stampa
string k_path_risorse="", k_rcx="", k_esito="", k_stampante_pdf=""
//long k_rc, k_riga
datastore kds_print
st_tab_contratti_rd kst_tab_contratti_rd
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base

 

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.stampa) //kkg_id_programma_contratti_co

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if
	
try

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw Contratto NON ancora definito  
      if not isvalid(kds_print) then
         kds_print = create datastore
      end if

      for k_item_doc = 1 to upperbound(kst_docprod_esporta.kst_tab_docprod[])

         kst_tab_contratti_rd.id_contratto_rd = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
         if kst_tab_contratti_rd.id_contratto_rd > 0 then
         
			if if_esiste(kst_tab_contratti_rd) then   // esiste il documento?
         
//--- Popola area dell'Contratto sul quale sto lavorando
				kst_tab_contratti_rd.id_contratto_rd = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_num
				kst_tab_contratti_rd.offerta_data = kst_docprod_esporta.kst_tab_docprod[k_item_doc].doc_data
				kst_tab_contratti_rd.id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_cliente

//--- Ricavo il nome del form se Documento gia' stampato
				kst_tab_contratti_rd.data_stampa = KKG.DATA_ZERO 
				get_form_di_stampa(kst_tab_contratti_rd)
         
//--- popola il DS con l'Contratto da stampare
				kds_print = create datastore
				
				if len(trim(kst_tab_contratti_rd.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
					kds_print.dataobject = trim(kst_tab_contratti_rd.form_di_stampa) 
				else
					kds_print.dataobject = kki_form_di_stampa_attuale
				end if
//--- Imposta  Risorse Grafiche
				if len(trim(kGuo_path.get_risorse())) > 0 then
//					k_rcx=kds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img.text"))+ "'") 
//					k_rcx=kds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text")) + "'")  
//					k_rcx=kds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text")) + "'") 
					kds_print.object.DataWindow.Export.PDF.Method = NativePDF!
					k_rcx=kds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text")) + "'") 
				end if
   
				kds_print.settransobject(sqlca)
   
//--- retrive dell'Contratto 
				k_rc=kds_print.retrieve(  kst_tab_contratti_rd.id_contratto_rd )
   
   
//--- Controllo se manca il percorso
				if len(trim( kst_docprod_esporta.path[k_item_doc])) > 0 then 
	
					k_n_documenti_stampati ++
	
//=== Crea il PDF
					kds_print.Object.DataWindow.Export.PDF.Method = Distill!
					kds_print.Object.DataWindow.Printer = k_stampante_pdf   
					kds_print.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
					k_id_stampa = kds_print.saveas(trim( kst_docprod_esporta.path[k_item_doc]),PDF!, false)   //
					
					if k_id_stampa < 1 then
						
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Contratto digitale su: '" + k_stampante_pdf + "' non generato: ~n~r"  &
																	 + "Documento: " + trim(kst_docprod_esporta.path[k_item_doc]) + " ~n~r" &
																	 + "Funzione fallita per errore: " + string(k_id_stampa)
						kst_esito.esito = kkg_esito.no_esecuzione
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					
					end if
					
//--- Aggiorna tab      
					kst_tab_contratti_rd.id_contratto_rd = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_doc
					kst_tab_contratti_rd.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item_doc].id_docprod
					set_id_docprod(kst_tab_contratti_rd)
						
				end if
			end if
      
         end if

	end for
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
	
end try



return k_n_documenti_stampati      

end function

public function boolean if_esiste (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Contratto R. & D. da id_rdntratti_rd
//--- 
//--- 
//--- Inp: st_tab_rdntratti_rd.id
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


//--- x numero contratti_rdicato			
	SELECT count(*)
			into :k_trovato
			 FROM contratti_rd  
			 where  id_contratto_rd  = :kst_tab_contratti_rd.id_contratto_rd
			 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Contratto R. & D. (contratti_rd) id = " + string(kst_tab_contratti_rd.id_contratto_rd) + " " &
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

public function boolean get_stato (ref st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge lo STATO
//--- 
//--- 
//--- Input: st_tab_contratti_rd.id_contratto_rd
//--- Out: stato
//---
//--- Ritorna true = ok
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	select stato
	  into :kst_tab_contratti_rd.stato
	  from contratti_rd 
	  where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd  
	  using sqlca;
	

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Legge lo Stato del Contratto R. & D. (tab. contratti_rd id=" + string(kst_tab_contratti_rd.id_contratto_rd) + " " + "): " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_contratti_rd.stato)) > 0 then
	else
		kst_tab_contratti_rd.stato = kki_STATO_nuovo
	end if
	
	k_return = true 

return k_return


end function

private function st_esito set_stato (ref st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Set del flag STATO
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_contratti_rd kst_tab_contratti_rd_attuale
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_rd

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica Stato del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else
	
	try

		if kst_tab_contratti_rd.id_contratto_rd > 0 then
	
			
			kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()
	

//--- piglia lo stato attuale	
			kst_tab_contratti_rd_attuale = kst_tab_contratti_rd
			get_stato(kst_tab_contratti_rd_attuale)

		
			if len(trim(kst_tab_contratti_rd_attuale.stato)) > 0 then
			else
//--- se nulla forza a 'NUOVO' (il livello più basso)
				kst_tab_contratti_rd_attuale.stato = kki_STATO_nuovo
			end if
		
//--- Imposta lo STATO solo x metterlo a livello superiore MAI inferiore ad eccezione di RIAPERTO
			if kst_tab_contratti_rd.stato >= kst_tab_contratti_rd_attuale.stato then

//--- setta lo STATO
				update contratti_rd
						 set stato = :kst_tab_contratti_rd.stato
						 ,x_datins = :kst_tab_contratti_rd.x_datins
						 ,x_utente = :kst_tab_contratti_rd.x_utente
						where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
						using sqlca;
	
			
				if sqlca.sqlcode <> 0 then
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Modifica Stato del 'Contratto R. & D.'  (contratti_rd):" + trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
			else
				kst_esito.esito = kkg_esito.no_esecuzione
			end if

		else
			kst_esito.esito = kkg_esito.no_esecuzione

		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
		
	finally
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

	
		
	end try
	
end if


return kst_esito

end function

private function boolean set_form_di_stampa (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo FORM_DI_STAMPA
//--- 
//--- Inp: st_tab_contratti_rd.id_contratto_rd
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_rd

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_rd.id_contratto_rd > 0 then

		
		kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_rd
		    set form_di_stampa = :kst_tab_contratti_rd.form_di_stampa
			 ,x_datins = :kst_tab_contratti_rd.x_datins
			 ,x_utente = :kst_tab_contratti_rd.x_utente
			where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto R. & D.'  (contratti_rd):" + trim(sqlca.SQLErrText)
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
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if

	end if
end if


return k_return


end function

private function boolean set_data_stampa (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------
//--- Set del campo DATA_STAMPA (di solito in concomitanza con il cambio di STATO)
//--- 
//--- Inp: st_tab_contratti_rd.id_contratto_rd
//--- Out:
//--- 
//--- Ritorna TRUE = OK
//---           	
//---  Lancia EXCEPTION
//---           	
//--------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_rd

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa del 'Contratto R. & D.' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_contratti_rd.id_contratto_rd > 0 then

		
		kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()
	

		update contratti_rd
		    set data_stampa = :kst_tab_contratti_rd.data_stampa
			 ,x_datins = :kst_tab_contratti_rd.x_datins
			 ,x_utente = :kst_tab_contratti_rd.x_utente
			where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna Lay-Out di stampa del 'Contratto R. & D.'  (contratti_rd):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

		if kst_esito.esito = kkg_esito.db_ko then
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito )
			throw kguo_exception
			
		else
			
			if kst_esito.esito = kkg_esito.ok then
				k_return = true
			end if
			
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
	end if
end if


return k_return


end function

private function long u_conv_conferma_ordine_to_listino (ref datastore kds_contratti_rd, st_tab_contratti kst_tab_contratti, st_contratti_rd_to_listini kst_contratti_rd_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Listini da una Conferma Ordine (CO) 
//---
//--- inp:  datastore del contratti_rd (d_contratti_rd)
//---                             ,kst_tab_contratti completamente riempito
//---                             ,st_contratti_rd_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: id (codice) del LISTINO caricato
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
int k_nr_listini_da_add=0, k_nr_listini_add=0
long k_riga=0
st_tab_base kst_tab_base 
st_tab_listino kst_tab_listino
st_tab_listino_prezzi kst_tab_listino_prezzi
st_esito kst_esito
st_tab_g_0 kst_tab_g_0
kuf_listino kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_prezzi kuf1_listino_prezzi
kuf_base kuf1_base
datastore kds_listino_link_pregruppi, kds_contratti_rd_listino_prezzi


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.set_esito(kst_esito) 

	kuf1_listino = create kuf_listino
	kuf1_base = create kuf_base

	if len(trim(kst_tab_contratti.mc_co)) > 0 then

//--- prezzi nella tabella listino_link_pregruppi
		kst_tab_listino.attiva_listino_pregruppi = kuf1_listino.kki_attiva_listino_pregruppi_si
		
		kst_tab_listino.prezzo = 0
	
//--- imposta il flag ATTIVO		
		if kst_contratti_rd_to_listini.k_subito_in_vigore = "S" then
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_si
		else
			kst_tab_listino.attivo = kuf1_listino.kki_attivo_da_fare
		end if

		kst_tab_listino.magazzino =  kds_contratti_rd.getitemnumber(1,"magazzino")
		if isnull(kst_tab_listino.magazzino) then
			kst_tab_listino.magazzino = 6
		end if
		kst_tab_listino.peso_kg = 0

//--- riempio i dati del Listino da quelli dei Contratti 
		kst_tab_listino.contratto = kst_tab_contratti.codice
		kst_tab_listino.contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_listino.id_contratto_co = 0 //kds_contratti_rd.getitemnumber(1,"contratti_rd_id_contratto_rd")
		kst_tab_listino.cod_art = kds_contratti_rd.getitemstring(1,"art")
		kst_tab_listino.cod_cli = kds_contratti_rd.getitemnumber(1,"id_cliente")
		
		
		kst_tab_listino.tipo = kuf1_listino.kki_tipo_prezzo_a_collo

//--- Niente Occupazione Pedana
		kst_tab_listino.occup_ped = 0
//--- Niente dati di LISTINO dal SL_PT
		kst_tab_listino.dose =  0
		kst_tab_listino.mis_x = 0
		kst_tab_listino.mis_y = 0
		kst_tab_listino.mis_z = 0
//--- imposta altri valori di default
		kst_tab_listino.id = 0
		kst_tab_listino.campione ="N"
		kst_tab_listino.m_cubi_f = 0
		kst_tab_listino.travaso = "N"

//--- ADD dei dati nel LISTINO
		if kst_contratti_rd_to_listini.k_simulazione <> "S" then
			kst_tab_listino.st_tab_g_0.esegui_commit = "N"
			kst_tab_listino.id = kuf1_listino.tb_add(kst_tab_listino)
			k_return = kst_tab_listino.id
		end if

//--- Aggiunge il Legame tra Listino e Voce 
		kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
		kds_listino_link_pregruppi = create datastore
		kds_listino_link_pregruppi.dataobject = "ds_listino_link_pregruppi"
		kds_listino_link_pregruppi.settransobject( kguo_sqlca_db_magazzino )
		kds_listino_link_pregruppi.insertrow(0)
		kds_listino_link_pregruppi.setitem(1, "id_listino", kst_tab_listino.id)
		kds_listino_link_pregruppi.setitem(1, "id_listino_pregruppo", kds_contratti_rd.getitemnumber(1,"id_listino_pregruppo"))
		kst_tab_g_0 = kst_tab_listino.st_tab_g_0
		kuf1_listino_link_pregruppi.tb_add(kds_listino_link_pregruppi, kst_tab_g_0)

//--- Aggiunge i Prezzi delle Voci al Listino
		kuf1_listino_prezzi = create kuf_listino_prezzi
		kds_contratti_rd_listino_prezzi = create datastore
		kds_contratti_rd_listino_prezzi.dataobject = "ds_contratti_rd_listino_prezzi"
		kds_contratti_rd_listino_prezzi.settransobject( kguo_sqlca_db_magazzino )
		kds_contratti_rd_listino_prezzi.retrieve(kst_tab_contratti.id_contratto_rd )
		for k_riga = 1 to kds_contratti_rd_listino_prezzi.rowcount( )
			
			kst_tab_listino_prezzi.st_tab_g_0 = kst_tab_listino.st_tab_g_0
			kst_tab_listino_prezzi.id_listino_link_pregruppo = kds_listino_link_pregruppi.getitemnumber(1,"id_listino_link_pregruppo")
//			kst_tab_listino_prezzi.id_listino_pregruppo = kds_contratti_rd.getitemnumber(1,"id_listino_pregruppo")
			kst_tab_listino_prezzi.id_listino_voce = kds_contratti_rd_listino_prezzi.getitemnumber(k_riga,"id_listino_voce")
			kst_tab_listino_prezzi.prezzo = kds_contratti_rd_listino_prezzi.getitemnumber(k_riga,"prezzo")
			kst_tab_listino_prezzi.attivo = kuf1_listino_prezzi.kki_attivo_si
			
			if kst_tab_listino_prezzi.id_listino_voce > 0 then
				kuf1_listino_prezzi.tb_add(kst_tab_listino_prezzi)
			end if
		end for
		
	end if
	
catch (uo_exception kuo_exception)	
//--- aggiunge riga al log
	throw kuo_exception
	
	
finally 
	destroy kuf1_listino
	destroy kuf1_base	

end try

return k_return

end function

public function long u_conv_to_conferma_ordine_e_listini (st_tab_contratti_rd kst_tab_contratti_rd, st_contratti_rd_to_listini kst_contratti_rd_to_listini) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Alimenta tabella Conferma Ordine (CO) e Listini da Contratto Studio Sviluppo 
//---
//--- inp: kst_tab_contratti_rd.id_contratto_rd,  st_contratti_rd_to_listini x sapere se simulazione ecc... o meno
//--- out: -
//--- ritorna: nr contratti commerciali Trasferiti
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_ctr_contratti_rd_trasferiti=0
long k_ctr_st_tab_contratti=1, k_ctr=0, k_ctr_contratti_rd_to_listini=0, k_ctr_ins_contratti=0
st_tab_gru kst_tab_gru
st_tab_listino kst_tab_listino
st_tab_contratti kst_tab_contratti[], kst_tab_contratti_select
st_tab_esito_operazioni kst_tab_esito_operazioni
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
kuf_contratti kuf1_contratti
kuf_ausiliari kuf1_ausiliari
datastore kds_contratti_rd


try 
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.set_esito(kst_esito) 
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_contratti = create kuf_contratti

	

//--- legge i dati del Contratto Studio Sviluppo
	kds_contratti_rd = create datastore
	kds_contratti_rd.dataobject = "d_contratti_rd"
	kds_contratti_rd.settransobject( sqlca)
	if kds_contratti_rd.retrieve(kst_tab_contratti_rd.id_contratto_rd) > 0 then
	
	
		kst_tab_contratti[k_ctr_st_tab_contratti].codice = 0
		kst_tab_contratti[k_ctr_st_tab_contratti].mc_co = "SD" + string(kst_tab_contratti_rd.id_contratto_rd) + "/" + string(kds_contratti_rd.getitemdate(1, "data_inizio"), "yyyy")
		
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_rd.getitemnumber(1, "id_cliente")
		kst_tab_contratti[k_ctr_st_tab_contratti].contratto_co_data_ins = kGuf_data_base.prendi_dataora( )
		kst_tab_contratti[k_ctr_st_tab_contratti].id_contratto_rd = kst_tab_contratti_rd.id_contratto_rd
	
		kst_tab_contratti[k_ctr_st_tab_contratti].data = kds_contratti_rd.getitemdate(1, "data_inizio")
		kst_tab_contratti[k_ctr_st_tab_contratti].data_scad = kds_contratti_rd.getitemdate(1, "data_fine")
		kst_tab_contratti[k_ctr_st_tab_contratti].flg_fatt_dopo_valid = kds_contratti_rd.getitemstring(1, "flg_fatt_dopo_valid")
		kst_tab_contratti[k_ctr_st_tab_contratti].id_meca_causale = kds_contratti_rd.getitemnumber(1, "id_meca_causale")
		if  kds_contratti_rd.getitemnumber(1, "acconto_imp") > 0 then
			kst_tab_contratti[k_ctr_st_tab_contratti].flg_acconto = kuf1_contratti.kki_flg_acconto_si
		else
			kst_tab_contratti[k_ctr_st_tab_contratti].flg_acconto = kuf1_contratti.kki_flg_acconto_no
		end if	
		
		kst_tab_contratti[k_ctr_st_tab_contratti].tipo = kuf1_contratti.kki_tipo_deposito
		
//--- aggiunge riga al log
		if kst_contratti_rd_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Inizio carico trasferimento Contratto Studio Sviluppo: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "; carico in automatico CO / LISTINI<-----------", false)
		else
			if kst_contratti_rd_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio SIMULAZIONE trasferimento Contratto Studio Sviluppo: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "<-----------", false)
			else
				kiuf_esito_operazioni.tb_add_riga("-----------> Inizio ad impostare a 'TRASFERITO' il Contratto Studio Sviluppo: " + kst_tab_contratti[k_ctr_st_tab_contratti].mc_co &
							+ " del Cliente " + string(kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli) + "; Compito dell'operatore caricare CO e LISTINI<-----------", false)
			end if
		end if


//--- piglio la descrizione del Gruppo
		if kds_contratti_rd.getitemnumber(1, "gruppo") > 0 then
			kst_tab_gru.codice = kds_contratti_rd.getitemnumber(1, "gruppo") 
			kst_esito = kuf1_ausiliari.tb_select(kst_tab_gru)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = trim(kst_tab_gru.des ) 
			else
				kst_tab_contratti[k_ctr_st_tab_contratti].descr = "Gruppo " + string(kds_contratti_rd.getitemnumber(1, "gruppo")) + " non trovato "
			end if
		end if
//--- se ho trovato errore Grave lancio eccezione
		if kst_esito.esito = kkg_esito.db_ko then
			kst_esito.sqlerrtext = "Errore durante lettura descrizione Gruppo codice " + string(kst_tab_gru.codice) + " (Contratto non Trasferito a Listino).  ~n~r" + kst_esito.sqlerrtext 
			kGuo_exception.set_esito(kst_esito) 
			kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
			throw kGuo_exception
		end if

//--- nessun capitolato e sl-pt previsto				
		kst_tab_contratti[k_ctr_st_tab_contratti].cert_st_dose_min =  "N"
		kst_tab_contratti[k_ctr_st_tab_contratti].sc_cf = ""
		kst_tab_contratti[k_ctr_st_tab_contratti].sl_pt = ""

//--- get Cliente da Contratto Studio Sviluppo
		kst_tab_contratti[k_ctr_st_tab_contratti].cod_cli = kds_contratti_rd.getitemnumber(1,"id_cliente")

//--- Carico le Conferme Ordine e Listini 
		for  k_ctr_ins_contratti = 1 to k_ctr_st_tab_contratti 
			
			if len(trim(kst_tab_contratti[k_ctr_ins_contratti].mc_co)) > 0 then 
				
				if kst_contratti_rd_to_listini.k_simulazione <> "M" then // se carico arch. MANUALMENTE non fa nulla
				
//--- Controlla l'esistenza del CO se già esiste NON carico
					kst_tab_contratti_select = kst_tab_contratti[k_ctr_ins_contratti]
					kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.if_esiste_co_x_mc_co(kst_tab_contratti_select) //if_esiste_co(kst_tab_contratti_select) 
					if kst_tab_contratti[k_ctr_ins_contratti].codice = 0 then
				
//--- Aggiunge Conferma Ordine  CO
						if kst_contratti_rd_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
							kst_tab_contratti[k_ctr_ins_contratti].st_tab_g_0.esegui_commit = "N"
							kst_tab_contratti[k_ctr_ins_contratti].codice = kuf1_contratti.tb_add(kst_tab_contratti[k_ctr_ins_contratti]) // ADD DEL CO
						end if
					else
//--- aggiunge riga al log
						kst_esito.sqlerrtext = "Conferma Ordine già presente nel codice " + string(kst_tab_contratti[k_ctr_ins_contratti].codice) + " (non generata).  ~n~r"
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
					end if
				
//--- carico LISTINO
					kst_tab_listino.st_tab_g_0.esegui_commit = "N"
					kst_tab_listino.id = this.u_conv_conferma_ordine_to_listino(kds_contratti_rd,  kst_tab_contratti[k_ctr_ins_contratti], kst_contratti_rd_to_listini)  // ADD DEL LISTINO
						
				end if  // fine SE sono in MANUALE
					
//--- Aggiorna lo STATO del Contratto Studio Sviluppo a TRASFERITO
				if kst_contratti_rd_to_listini.k_simulazione <> "S" then
					
					k_ctr_contratti_rd_trasferiti++  //nr contratti trasferiti
					
					kst_tab_contratti_rd.st_tab_g_0.esegui_commit = "N"
					kst_esito = set_trasferito(kst_tab_contratti_rd)
					if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
						kst_esito.sqlerrtext = "Contratto Studio Sviluppo Trasferito a Listino ma 'STATO' non aggiornato.  ~n~r" + kst_esito.sqlerrtext 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if

				else
//--- aggiunge riga al log
					kiuf_esito_operazioni.tb_add_riga("simulazione di carico del Listino corretta ", false)
				end if
				
				
//--- Visto che tutto OK COMMIT			
				if kst_contratti_rd_to_listini.k_simulazione <> "S" then
					kst_esito = kGuf_data_base.db_commit_1( )  //COMMIT
//--- se ho trovato errore Grave lancio eccezione
					if kst_esito.esito = kkg_esito.ok then
						k_ctr_contratti_rd_to_listini ++
//--- aggiunge riga al log
						kiuf_esito_operazioni.tb_add_riga("caricato il Listino codice: " + string(kst_tab_listino.id), false)
					else
						kGuf_data_base.db_rollback_1( )  //ROLLBACK 
						kst_esito.sqlerrtext = "Errore in elaborazione Contratto Studio Sviluppo nr. " + string(kst_tab_contratti_rd.id_contratto_rd) + " (non Trasferito).  ~n~r" + kst_esito.sqlerrtext 
						kGuo_exception.set_esito(kst_esito) 
						kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
						throw kGuo_exception
					end if
				else
//--- aggiunge riga al log
					kiuf_esito_operazioni.tb_add_riga("simulazione di carico Conferma Ordine corretta ", false)
				end if
				
				
			end if
			
		end for
		
	else

//--- contratto NON TROVATO
		kst_esito.sqlerrtext = "Contratto Studio Sviluppo non Trovato!   " 
		kGuo_exception.set_esito(kst_esito) 
		kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
		throw kGuo_exception
		
	end if

//--- SE ERRORE	
catch (uo_exception kuo_exception)
	if kst_contratti_rd_to_listini.k_simulazione <> "S" and k_ctr_contratti_rd_to_listini > 0 then
		kGuf_data_base.db_rollback_1( )  //ROLLBACK 
	end if
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante elaborazione del Contratto Studio Sviluppo nr. " + string(kst_tab_contratti_rd.id_contratto_rd) + ".  ~n~r" + kst_esito.sqlerrtext 
	kuo_exception.set_esito(kst_esito)
	kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true ) //--- aggiunge riga al log
	throw kuo_exception


finally 
	

//--- aggiunge riga FINALE al log
	if kst_contratti_rd_to_listini.k_simulazione = "N"  then // se non sono in simulazione eseguo!
		kiuf_esito_operazioni.tb_add_riga("-----------> Fine carico archivi, trasferito Contratto Studio Sviluppo: " + string(kst_tab_contratti_rd.id_contratto_rd) + " <----------- ", false)
	else
		if kst_contratti_rd_to_listini.k_simulazione = "S"  then // se sono in simulazione eseguo!
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine SIMULAZIONE trasferimento Contratto Studio Sviluppo: " + string(kst_tab_contratti_rd.id_contratto_rd) + " <----------- ", false)
		else
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine, archivi non caricati ma 'Trasferito' Contratto Studio Sviluppo: " + string(kst_tab_contratti_rd.id_contratto_rd) + " <----------- ", false)
		end if
	end if
//--- Scrive LOG esiti su DB
	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
	kst_tab_contratti_rd.esito_operazioni_ts_operazione = kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
//--- scrive su Studio Sviluppo il riferimento all'esito 	
	kst_tab_contratti_rd.st_tab_g_0.esegui_commit = "S"
	this.set_ts_esito_operazione(kst_tab_contratti_rd)

	
	destroy kuf1_contratti
	destroy kuf1_ausiliari
	destroy kds_contratti_rd
	
end try


return k_ctr_contratti_rd_trasferiti

end function

public function st_esito set_trasferito (st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Imposta il flag stato a Convertito in CO e Listino in tabella contratti_rd
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_contratti_rd.stato = kki_stato_trasferito

kst_esito = set_stato(kst_tab_contratti_rd) 

return kst_esito

end function

private function st_esito set_ts_esito_operazione (ref st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Set del flag il TimeStamp dell'esito del trasferimento a listino colonna: TS_ESITO_OPERAZIONE
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	k_autorizza = if_sicurezza(kkg_flag_modalita.modifica)

	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica 'data e ora esito' nel 'Contratto Studio Sviluppo' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if kst_tab_contratti_rd.id_contratto_rd > 0 then
	
			kst_tab_contratti_rd.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_contratti_rd.x_utente = kGuf_data_base.prendi_x_utente()
	
			update contratti_rd
				 set esito_operazioni_ts_operazione = :kst_tab_contratti_rd.esito_operazioni_ts_operazione
					 ,x_datins = :kst_tab_contratti_rd.x_datins
					 ,x_utente = :kst_tab_contratti_rd.x_utente
				where id_contratto_rd = :kst_tab_contratti_rd.id_contratto_rd
				using sqlca;
	
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Modifica 'data e ora esito operazione'  del 'Contratto Studio Sviluppo'  (contratti_rd):" + trim(sqlca.SQLErrText)
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
		
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					if kst_tab_contratti_rd.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti_rd.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()	
	
end try

return kst_esito

end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe, k_ctr
int k_riga
string k_tipo_errore="0"
boolean k_voci_no_cod=false
st_tab_contratti_rd kst_tab_contratti_rd
st_tab_gru kst_tab_gru
st_tab_prodotti kst_tab_prodotti
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
st_esito kst_esito, kst_esito1
kuf_ausiliari kuf1_ausiliari
kuf_prodotti kuf1_prodotti
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 10

	
//--- controllo se sono stati caricati Contratti nell'anno x lo stesso cliente		
		if ki_flag_modalita = kkg_flag_modalita.inserimento then
			kst_tab_contratti_rd.id_cliente = ads_inp.getitemnumber(1, "id_cliente")
			kst_tab_contratti_rd.anno = ads_inp.getitemnumber(1, "anno")
			kst_esito = get_ultimo_cliente_anno(kst_tab_contratti_rd)
			if kst_esito.esito = kkg_esito.ok then
				if kst_tab_contratti_rd.id_contratto_rd > 0 then
					k_errori ++
					k_tipo_errore=kkg_esito.DATI_WRN      
					ads_inp.modify("id_cliente.tag = '" + k_tipo_errore + "' ")
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext =  ": il cliente ha già altri Contratti, es il n. " + string(kst_tab_contratti_rd.id_contratto_rd ) &
												+ " del " + string(kst_tab_contratti_rd.offerta_data, "dd/mm/yyyy" ) + "~n~r" 
				end if
			end if
		end if
		if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
//--- check presenza del cod articolo
			kst_tab_contratti_rd.art = ads_inp.getitemstring(1, "art")
			if len(trim(kst_tab_contratti_rd.art)) = 0 or isnull(kst_tab_contratti_rd.art )  then
				k_errori++
				k_tipo_errore = "4"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("art_t.text")) +  "~n~r"  + trim(kst_esito.sqlerrtext)
			end if

//--- warning sul cambio di STATO
			if ads_inp.getitemstring( 1, "stato") = kki_STATO_accettato then
				k_errori++
				k_tipo_errore = kkg_esito.DATI_WRN
				kst_esito.esito = kkg_esito.DATI_WRN
				kst_esito.sqlerrtext = "Lo Stato 'ACCETTATO' rende il documento IMMODIFICABILE, controlla meglio.  "  + trim(kst_esito.sqlerrtext)
			end if
		end if

//--- check se Gruppo coerente con il Settore
		kst_tab_contratti_rd.gruppo = ads_inp.getitemnumber(1, "gruppo")
		kst_tab_contratti_rd.id_clie_settore = ads_inp.getitemstring(1, "id_clie_settore")
		if len(trim(kst_tab_contratti_rd.id_clie_settore)) > 0 and kst_tab_contratti_rd.gruppo > 0 then
			kuf1_ausiliari = create kuf_ausiliari  
			kst_tab_gru.codice = kst_tab_contratti_rd.gruppo 
			kst_esito1 = kuf1_ausiliari.tb_gru_get_id_clie_settore( kst_tab_gru )
			destroy kuf1_ausiliari
			if kst_esito1.esito = kkg_esito.ok then
				if trim(kst_tab_gru.id_clie_settore) <> trim(kst_tab_contratti_rd.id_clie_settore) then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.ERR_LOGICO
					kst_esito.sqlerrtext = "Settore non coerente con il Gruppo scelto (" + string(kst_tab_contratti_rd.gruppo) + ") ~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext =  "Errore durante lettura Gruppo " + string(kst_tab_gru.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

//--- check se Gruppo coerente con il Prodotto
		kst_tab_contratti_rd.art = ads_inp.getitemstring(1, "art")
		kst_tab_contratti_rd.gruppo = ads_inp.getitemnumber(1, "gruppo")
		if len(trim(kst_tab_contratti_rd.art)) > 0 and kst_tab_contratti_rd.gruppo > 0 then
			kuf1_prodotti = create kuf_prodotti  
			kst_tab_prodotti.codice = kst_tab_contratti_rd.art 
			kst_esito1 = kuf1_prodotti.get_gruppo( kst_tab_prodotti )
			destroy kuf1_prodotti
			if kst_esito1.esito = kkg_esito.ok then
				if kst_tab_prodotti.gruppo <> kst_tab_contratti_rd.gruppo then
					k_errori++
					k_tipo_errore = "4"
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Gruppo non coerente con l'articolo scelto (" + trim(kst_tab_contratti_rd.art) + ") ~n~r"   + trim(kst_esito1.sqlerrtext)  + trim(kst_esito.sqlerrtext)
				end if
			else
				if kst_esito1.esito <> kkg_esito.db_ko then
					k_errori++
					k_tipo_errore = "1"
					kst_esito.esito = kkg_esito.DB_KO
					kst_esito.sqlerrtext = "Errore durante lettura Articolo " + trim(kst_tab_prodotti.codice ) &
									+ " err=" + string(kst_esito1.sqlcode) + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"   + trim(kst_esito.sqlerrtext)
				end if
			end if
		end if

		kst_tab_contratti_rd.id_listino_pregruppo = ads_inp.getitemnumber(1, "id_listino_pregruppo")
		if kst_tab_contratti_rd.id_listino_pregruppo > 0  then
		else
			k_errori++
			k_tipo_errore = "3"
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe("b_listino_pregruppo.text")) +  "~n~r"    + trim(kst_esito.sqlerrtext)
		end if

//--- check se Stessa Voce Ripetuta più volte
		for k_ctr = 1 to 10
			kst_tab_contratti_rd.descr_1 = ads_inp.getitemstring(1, "descr_" + string(k_ctr))
			kst_tab_contratti_rd.id_listino_voce_1 = ads_inp.getitemnumber(1, "id_listino_voce_" + string(k_ctr))
			if kst_tab_contratti_rd.id_listino_voce_1 > 0 then
				for k_riga = k_ctr+1 to 10
			   		if kst_tab_contratti_rd.id_listino_voce_1 = ads_inp.getitemnumber(1, "id_listino_voce_" + string(k_riga)) then
						k_errori++
						k_tipo_errore = "1"
						kst_esito.esito = kkg_esito.ERR_LOGICO
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_rd.id_listino_voce_1 ) &
										+ " duplicata nel campo '" +  trim(ads_inp.describe( "id_listino_voce_" + string(k_riga) +"_t.text"))  + "'.  " + "~n~r" + trim(kst_esito.sqlerrtext)
						k_riga =11  	//forza uscita
						k_ctr = 11 //forza uscita
					end if
				end for

//--- check se la Voce esiste nel Gruppo Listino indicato		
				if kst_tab_contratti_rd.id_listino_pregruppo > 0  then
					kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci  
					kst_tab_listino_pregruppi_voci.id_listino_voce = kst_tab_contratti_rd.id_listino_voce_1 
					kst_tab_listino_pregruppi_voci.id_listino_pregruppo = kst_tab_contratti_rd.id_listino_pregruppo 
					kst_esito1 = kuf1_listino_pregruppi_voci.get_id_listino_pregruppo_voce(kst_tab_listino_pregruppi_voci)
					if kst_esito1.esito = KKG_ESITO.not_fnd then
						if k_tipo_errore = "4" or k_tipo_errore = kkg_esito.DATI_WRN or k_tipo_errore = "0" then 
							k_errori++
							k_tipo_errore = kkg_esito.DATI_WRN
							kst_esito.esito = kkg_esito.DATI_WRN
						end if
						kst_esito.sqlerrtext = "La Voce " + string(kst_tab_contratti_rd.id_listino_voce_1 ) + ", alla riga " + string(k_ctr) &
											+ " non appartiene al '" + trim(ads_inp.describe("id_listino_pregruppo_t.text")) + " " &
											+ string(kst_tab_listino_pregruppi_voci.id_listino_pregruppo) + " ' indicato." + " - " + trim(kst_esito1.sqlerrtext) + "~n~r"  + trim(kst_esito.sqlerrtext)
					end if
				end if
			end if

//--- check se ci sono Voci senza ID ma con la sola descrizione (basta msg una volta)
			if kst_tab_contratti_rd.id_listino_voce_1 > 0 or k_voci_no_cod then
			else
				if trim(kst_tab_contratti_rd.descr_1) > " " then
					k_voci_no_cod = true
					k_tipo_errore = kkg_esito.DATI_WRN
					kst_esito.esito = kkg_esito.DATI_WRN
					kst_esito.sqlerrtext = "Le Voci non Codificate non saranno TRASFERITE a Listino, come la riga " + string(k_ctr) + ": " + trim(kst_tab_contratti_rd.descr_1 ) 
				end if
			end if
				
		end for


		if k_tipo_errore <> "0"  and k_tipo_errore <> "4" and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito

end function

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_rdco_to_listino)


 
end subroutine

public function ds_contratti_rd_select get_dati (st_tab_contratti_rd kst_tab_contratti_rd);//
//====================================================================
//=== Torna tutt i dati del record/riga
//=== 
//=== Input: st_tab_contratti_rd.id_contratto_rd
//=== Output: ds ds_contratti_rd_select
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito
ds_contratti_rd_select kds_contratti_rd_select

	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kds_contratti_rd_select = create ds_contratti_rd_select

	if kst_tab_contratti_rd.id_contratto_rd > 0 then
	
		kds_contratti_rd_select.retrieve(kst_tab_contratti_rd.id_contratto_rd )
		
		if kds_contratti_rd_select.kist_errori_gestione.sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kds_contratti_rd_select.kist_errori_gestione.sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Contratto Studio Sviluppo ~n~r:" + trim(kds_contratti_rd_select.kist_errori_gestione.sqlca.SQLErrText)
		end if

	end if


return kds_contratti_rd_select




end function

private function st_esito stampa_documento_print (ref datastore kds_print, st_tab_contratti_rd ast_tab_contratti_rd);//
//=== 
//====================================================================
//=== Stampa Contratto Studio e Sviluppo 
//=== per eseguire la stampa lanciare la routine "stampa_documento"
//===
//=== Par. Input:   datawindow da stampare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
//=== 
int k_errore
string k_rag_soc, k_rcx
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
st_stampe kst_stampe
st_tab_clienti kst_tab_clienti
kuf_sicurezza kuf1_sicurezza
//kuf_base kuf1_base
kuf_utility kuf1_utility
kuf_clienti kuf1_clienti

pointer K_oldpointer


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kds_print.rowcount() > 0 then
		try
			get_id_cliente(ast_tab_contratti_rd)
			kst_tab_clienti.codice = ast_tab_contratti_rd.id_cliente
			kuf1_clienti = create kuf_clienti
			kuf1_clienti.get_nome(kst_tab_clienti)
			k_rag_soc = kst_tab_clienti.rag_soc_10
		catch (uo_exception kuo_exception)
			k_rag_soc = "Nessun cliente trovato"
		end try
		kuf1_utility = create kuf_utility
		k_rag_soc = kuf1_utility.u_stringa_pulisci(k_rag_soc)
		destroy kuf1_utility
		kds_print.Object.DataWindow.Print.DocumentName= "contratto_Studio_Sviluppo_" + trim(string(ast_tab_contratti_rd.id_contratto_rd)) + "_" + trim(k_rag_soc) 

//=== Puntatore Cursore da attesa.....
		K_oldpointer = SetPointer(HourGlass!)

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.ds_print = create datastore
		kst_stampe.ds_print.dataobject = kds_print.dataobject
		kds_print.rowscopy( 1, kds_print.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
//		kst_stampe.ds_print = kds_print
		kds_print.getfullstate(kst_stampe.blob_print)  // riempie il blob con il dw/ds da stampare
		kst_stampe.titolo = "Stampa Documento nr. " + string((ast_tab_contratti_rd.id_contratto_rd))
		kst_stampe.stampante_predefinita = "" 
		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no

		k_errore = kGuf_data_base.stampa_dw(kst_stampe)
		if k_errore = 0 then
			kst_esito.esito = kkg_esito.OK
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Stampa Documento non effettuata! ~n~r" 
			kst_esito.esito = kkg_esito.blok
		end if

			
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Documento da stampare ~n~r" 
		kst_esito.esito = kkg_esito.blok
		
	end if

	SetPointer(K_oldpointer)

end if



return kst_esito

end function

private function st_esito stampa_documento_obsoleto (st_tab_contratti_rd kst_tab_contratti_rd) throws uo_exception;//====================================================================
//=== 
//=== Prepara e Stampa Contratto Studio Sviluppo
//===
//=== Par. Inut:    kst_tab_contratti_rd (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
string k_rcx
long k_rc, k_riga
int k_dwc_num, k_rcn
boolean k_return
datastore kds_print
//st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
//kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base
DataWindowChild kdwc_1


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.stampa
//kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza

if_sicurezza(kkg_flag_modalita.stampa)

//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Stampa Documento non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_contratti_rd.id_contratto_rd > 0 then		

		try

//--- Ricavo il nome del form se Documento gia' stampato
			kst_tab_contratti_rd.data_stampa = KKG.DATA_ZERO 
			get_form_di_stampa(kst_tab_contratti_rd)	

//--- popola il DW con l'attestato da stampare
			kds_print = create datastore
			
			if len(trim(kst_tab_contratti_rd.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
				kds_print.dataobject = trim(kst_tab_contratti_rd.form_di_stampa) 
			else
				kds_print.dataobject = kki_form_di_stampa_attuale 
			end if
			kds_print.settransobject(sqlca)
	
			k_rc=kds_print.settransobject(sqlca)
			
//--- Imposta  Risorse Grafiche
			if len(trim(kGuo_path.get_risorse())) > 0 then
				k_rcx=kds_print.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img.text"))+ "'") 
				k_rcx=kds_print.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_0.text")) + "'")  
				k_rcx=kds_print.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_1.text")) + "'") 
				k_rcx=kds_print.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_2.text")) + "'") 
				k_rcx=kds_print.Modify("p_img_3.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_3.text")) + "'") 
				k_rcx=kds_print.Modify("p_img_4.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kds_print.Describe("txt_p_img_4.text")) + "'") 
			end if
//--- Imposta le Risorse grafiche anche delle DW innestate (composite dw)			
			k_dwc_num=1
			k_rcn = kds_print.GetChild("dw_"+string(k_dwc_num), kdwc_1) 
			do while k_rcn = 1
				string k_appo=""
				k_appo =  trim(kdwc_1.Describe("txt_p_img.text"))
				k_rcx=kdwc_1.Modify("p_img.Filename='" + kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img.text"))+ "'") 
				k_rcx=kdwc_1.Modify("p_img_0.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img_0.text")) + "'")  
				k_rcx=kdwc_1.Modify("p_img_1.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img_1.text")) + "'") 
				k_rcx=kdwc_1.Modify("p_img_2.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img_2.text")) + "'") 
				k_rcx=kdwc_1.Modify("p_img_3.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img_3.text")) + "'") 
				k_rcx=kdwc_1.Modify("p_img_4.Filename='" +  kGuo_path.get_risorse() + "\" + trim(kdwc_1.Describe("txt_p_img_4.text")) + "'") 
				k_dwc_num ++
				k_rcn = kds_print.GetChild("dw_"+string(k_dwc_num), kdwc_1) 
			loop

//--- retrive dell'attestato 
			k_rc=kds_print.retrieve(  kst_tab_contratti_rd.id_contratto_rd )
	
			if kds_print.rowcount() > 0 then
	

//--- LANCIA LA STAMPA !!!
				stampa_documento_print(kds_print, kst_tab_contratti_rd)

			end if
			
		catch (uo_exception kuo_exception)
			throw kuo_exception
			
		end try
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato"
		kst_esito.esito = kkg_esito.blok
		
	end if
	
//end if


return kst_esito

end function

private function st_esito stampa_documento (st_tab_contratti_rd ast_tab_contratti_rd) throws uo_exception;//====================================================================
//=== 
//=== Prepara e Stampa Contratto Studio Sviluppo
//===
//=== Par. Inut:    kst_tab_contratti_rd (valorizzare il num. Documento)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
string k_rcx
long k_rc, k_riga
int k_dwc_num, k_rcn, k_riga_voce, k_riga_voce_1
boolean k_return
datastore kds_print
//st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
st_tab_contratti_rd kst_tab_contratti_rd
//kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base
DataWindowChild kdwc_1


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	if_sicurezza(kkg_flag_modalita.stampa)


	if ast_tab_contratti_rd.id_contratto_rd > 0 then		

		try

//--- Ricavo il nome del form se Documento gia' stampato
			ast_tab_contratti_rd.data_stampa = KKG.DATA_ZERO 
			get_form_di_stampa(ast_tab_contratti_rd)	

//--- popola il DW con l'attestato da stampare
			kds_print = create datastore
			
			if len(trim(ast_tab_contratti_rd.form_di_stampa)) > 0 then  //--- se sono in ristampa allora riprendo il form originale
				kds_print.dataobject = trim(ast_tab_contratti_rd.form_di_stampa) 
			else
				kds_print.dataobject = kki_form_di_stampa_attuale 
			end if
			kds_print.settransobject(sqlca)
	
			k_rc=kds_print.settransobject(sqlca)

			
			
//--- retrive dell'attestato 
			k_rc=kds_print.retrieve(  ast_tab_contratti_rd.id_contratto_rd )
	
			if kds_print.rowcount() > 0 then
	
			
//--- Compatta le righe voci in stampa nel DW CHILD
				k_dwc_num=1
				k_rcn = kds_print.GetChild("dw_"+string(k_dwc_num), kdwc_1) 
				if k_rcn = 1 then
					k_rcx=kdwc_1.Modify("flg_st_voce_1.Tag='test'")   // test esistenza campi voci (nei vecchi contratto non esistevano)
				else
					k_rcx = "KO"
				end if
				if k_rcx = "" then
					for k_riga_voce = 1 to 10 
						kst_tab_contratti_rd.flg_st_voce_1 = kdwc_1.getitemstring(1, "flg_st_voce_" + string(k_riga_voce))
						if kst_tab_contratti_rd.flg_st_voce_1 = "N" then 
							kdwc_1.setitem(1, "v" + + string(k_riga_voce) + "_descr_xctr", "")
							kdwc_1.setitem(1, "v" + + string(k_riga_voce) + "_descr_xctr_eng", "")
							kdwc_1.setitem(1, "voce_qta_" + string(k_riga_voce), 0)
							kdwc_1.setitem(1, "voce_prezzo_" + string(k_riga_voce), 0)
							kdwc_1.setitem(1, "voce_prezzo_tot_" + string(k_riga_voce), 0)
							k_riga_voce_1 = k_riga_voce + 1
							kst_tab_contratti_rd.flg_st_voce_1 = kdwc_1.getitemstring(1, "flg_st_voce_" + string(k_riga_voce_1)) 
							if kst_tab_contratti_rd.flg_st_voce_1 > " " then
							else
								kst_tab_contratti_rd.flg_st_voce_1 = "S"  // default è da stampare
							end if
							do while kst_tab_contratti_rd.flg_st_voce_1 <> "S" and k_riga_voce_1 < 11   // Esce se trova una Voce da Esporre
								kdwc_1.setitem(1, "v" + + string(k_riga_voce_1) + "_descr_xctr", "")
								kdwc_1.setitem(1, "v" + + string(k_riga_voce_1) + "_descr_xctr_eng", "")
								kdwc_1.setitem(1, "voce_qta_" + string(k_riga_voce_1), 0)
								kdwc_1.setitem(1, "voce_prezzo_" + string(k_riga_voce_1), 0)
								kdwc_1.setitem(1, "voce_prezzo_tot_" + string(k_riga_voce_1), 0)
								k_riga_voce_1 ++
								if k_riga_voce_1 < 11 then
									kst_tab_contratti_rd.flg_st_voce_1 = kdwc_1.getitemstring(1, "flg_st_voce_" + string(k_riga_voce_1)) 
									if kst_tab_contratti_rd.flg_st_voce_1 > " " then
									else
										kst_tab_contratti_rd.flg_st_voce_1 = "S"  // default è da stampare
									end if
								end if
							loop
							
							if k_riga_voce_1 > 10 then  // se non ho trovato piu' voci esce da ciclo 
								k_riga_voce = 11 // ESCO DAL CICLO
							else
								//--- Muove la riga sopra (compatta!)
								kdwc_1.setitem(1, "flg_st_voce_" + string(k_riga_voce_1), "")  // visto che sposto questa voce pulisco il flag
								kst_tab_contratti_rd.descr_1 = kdwc_1.getitemstring(1, "v" + + string(k_riga_voce_1) + "_descr_xctr")
								kst_tab_contratti_rd.descr_2 = kdwc_1.getitemstring(1, "v" + + string(k_riga_voce_1) + "_descr_xctr_eng")
								kst_tab_contratti_rd.voce_qta_1 = kdwc_1.getitemnumber(1, "voce_qta_" + string(k_riga_voce_1))
								kst_tab_contratti_rd.voce_prezzo_1 = kdwc_1.getitemnumber(1, "voce_prezzo_" + string(k_riga_voce_1))
								kst_tab_contratti_rd.voce_prezzo_tot_1 = kdwc_1.getitemnumber(1, "voce_prezzo_tot_" + string(k_riga_voce_1))
								if trim(kst_tab_contratti_rd.descr_1) > " " then
								else
									kst_tab_contratti_rd.descr_1 = " "
								end if
								if trim(kst_tab_contratti_rd.descr_2) > " " then
								else
									kst_tab_contratti_rd.descr_2 = " "
								end if
								if kst_tab_contratti_rd.voce_qta_1 > 0 then
								else
									kst_tab_contratti_rd.voce_qta_1 = 0
								end if
								if kst_tab_contratti_rd.voce_prezzo_1 <> 0 then
								else
									kst_tab_contratti_rd.voce_prezzo_1 = 0
								end if
								if kst_tab_contratti_rd.voce_prezzo_tot_1 <> 0 then
								else
									kst_tab_contratti_rd.voce_prezzo_tot_1 = 0
								end if
								kdwc_1.setitem(1, "v" + + string(k_riga_voce) + "_descr_xctr", kst_tab_contratti_rd.descr_1)
								kdwc_1.setitem(1, "v" + + string(k_riga_voce) + "_descr_xctr_eng", kst_tab_contratti_rd.descr_2)
								kdwc_1.setitem(1, "voce_qta_" + string(k_riga_voce), kst_tab_contratti_rd.voce_qta_1)
								kdwc_1.setitem(1, "voce_prezzo_" + string(k_riga_voce), kst_tab_contratti_rd.voce_prezzo_1)
								kdwc_1.setitem(1, "voce_prezzo_tot_" + string(k_riga_voce), kst_tab_contratti_rd.voce_prezzo_tot_1)
							end if
	
						end if
					next
				end if



//--- LANCIA LA STAMPA !!!
				stampa_documento_print(kds_print, ast_tab_contratti_rd)

			end if
			
		catch (uo_exception kuo_exception)
			throw kuo_exception
			
		end try
		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna stampa eseguita: ~n~r" + "Numero Documento non indicato"
		kst_esito.esito = kkg_esito.blok
		
	end if
	


return kst_esito

end function

on kuf_contratti_rd.create
call super::create
end on

on kuf_contratti_rd.destroy
call super::destroy
end on

