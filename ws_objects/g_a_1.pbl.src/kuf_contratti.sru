$PBExportHeader$kuf_contratti.sru
forward
global type kuf_contratti from kuf_parent
end type
end forward

global type kuf_contratti from kuf_parent
end type
global kuf_contratti kuf_contratti

type variables
//
//--- valori del campo sc_cf.m_r_f:
public string k_cf_m_r_f_mandante = "M"
public string k_cf_m_r_f_ricevente = "R"
public string k_cf_m_r_f_fatturato = "F"

//
//---- campo TIPO contratto
constant string kki_TIPO_standard = "S" // tipo contratto standard (x mat. da Trattare)
constant string kki_TIPO_deposito = "N" // tipo contratto di solo deposito cmq di NON trattamento

//
//---- campo COSTI_ACCESSORI applicabili al Riferimento
//constant string kki_COSTI_ACCESSORI_no = "N" 
//constant string kki_COSTI_ACCESSORI_si = "S" 

//---- campo ACCONTO flag che indica presenza di acconto per questo contratto (vedi cntratti_rd)
constant string kki_FLG_ACCONTO_no = "N" 
constant string kki_FLG_ACCONTO_si = "S" 

//---- campo ET_DOSIMETRO - barcode da stampare insieme a quelli di Trattamento
constant int kki_ET_DOSIMETRO_no = 0 
constant int kki_ET_DOSIMETRO_default = 1 


//--- Datawindow varie
constant string kki_dw_elenco_contratti = "d_contratti_l_attivi_rid"
constant string kki_dw_elenco_sc_cf_x_m_r_f = "d_sc_cf_l_x_m_r_f"

//--- Flag attivazione fatturazione voci prezzi lotto dopo stampa attestato
constant string kki_flg_fatt_dopo_valid_SI = "S"
constant string kki_flg_fatt_dopo_valid_NO = "N"

end variables

forward prototypes
public function string tb_delete (long k_codice)
public function string tb_delete_sc_cf (string k_codice)
public function st_esito sc_cf_aggiorna_attivo (ref date k_data_da, date k_data_a, string k_attivo)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti kst_tab_contratti)
public function st_esito anteprima_sc_cf (ref datawindow kdw_anteprima, st_tab_contratti kst_tab_contratti)
public subroutine if_isnull (ref st_tab_contratti kst_tab_contratti)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti)
public function st_esito anteprima_sc_cf (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti)
public function st_esito get_sc_cf_pt (ref st_tab_contratti kst_tab_contratti)
public function st_esito get_et_bcode_note (ref st_tab_contratti kst_tab_contratti)
public function st_esito get_sl_pt (ref st_tab_contratti kst_tab_contratti)
public function st_esito get_co_cf_pt (ref st_tab_contratti kst_tab_contratti)
public function st_esito tb_delete (st_tab_sd_md kst_tab_sd_md)
public subroutine elenco_sc_cf_attivi_cliente (st_tab_contratti kst_tab_contratti)
public function st_esito get_sl_pt (ref st_tab_sd_md kst_tab_sd_md)
public function long tb_add (st_tab_contratti kst_tab_contratti) throws uo_exception
public function integer get_capitolati (string k_capitolati, ref string k_capitolato[])
public function string get_sl_pt (ref string k_codice) throws uo_exception
public function long get_cod_cli (ref string k_codice) throws uo_exception
public function boolean if_esiste_mc_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception
public function boolean if_esiste_sc_cf (readonly st_tab_contratti kst_tab_contratti) throws uo_exception
public function long if_esiste_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception
public function integer get_et_dosimetro (ref st_tab_contratti kst_tab_contratti) throws uo_exception
public function long get_id_meca_causale (readonly st_tab_contratti ast_tab_contratti) throws uo_exception
public function boolean link_call_imvc (ref st_tab_contratti kst_tab_contratti, st_open_w kst_open_w_arg) throws uo_exception
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public subroutine get_id_contratto (ref st_tab_contratti ast_tab_contratti) throws uo_exception
public function long if_esiste_co_x_mc_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception
public function date get_data_scad (ref st_tab_contratti ast_tab_contratti) throws uo_exception
public function date get_sc_cf_data_scad (ref st_tab_contratti ast_tab_contratti) throws uo_exception
public function long get_contratto_da_cf_co (ref st_tab_contratti ast_tab_contratti) throws uo_exception
public function st_esito select_riga (ref st_tab_contratti kst_tab_contratti)
public function string get_flg_fatt_dopo_valid (readonly st_tab_contratti ast_tab_contratti) throws uo_exception
public function string get_flg_acconto (readonly st_tab_contratti ast_tab_contratti) throws uo_exception
public function st_esito anteprima_sc_cf_l (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti)
public function boolean if_scaduto_sc_cf (st_tab_contratti kst_tab_contratti) throws uo_exception
public function date get_data_scad_sc_cf (st_tab_contratti ast_tab_contratti) throws uo_exception
public function long elenco_contratti_attivi_cliente (st_tab_contratti kst_tab_contratti)
public function long get_codice_max () throws uo_exception
public function st_esito get_codice_da_cf_co (ref st_tab_contratti kst_tab_contratti) throws uo_exception
end prototypes

public function string tb_delete (long k_codice);//
//====================================================================
//=== Cancella il rek dalla tabella t_contr 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
string k_rag_soc
long k_cod_cli



//=== Controllo se contratti definiti nei Piani di Trattamento
DECLARE listino CURSOR FOR  
	  SELECT cod_cli, rag_soc_10
   	 FROM listino left outer join clienti on
		      listino.cod_cli = clienti.codice
	   WHERE contratto = :k_codice ;

 	   

open listino;
if kguo_sqlca_db_magazzino.sqlCode = 0 then

	fetch listino INTO :k_cod_cli, :k_rag_soc;

	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		k_return = "2" + "Conferma Ordine associato nel Listino di:~n~r" + &
		   string(k_cod_cli, "####0") + " " + trim(k_rag_soc) + "~n~r" 	
	end if
	close listino;
end if

	
if LeftA(k_return, 1) = "0" then
	
	delete from contratti
			where codice = :k_codice ;

	if kguo_sqlca_db_magazzino.sqlCode <> 0 then

		k_return = "1" + kguo_sqlca_db_magazzino.SQLErrText

	else

//		if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
//		end if

	end if
end if

return k_return
end function

public function string tb_delete_sc_cf (string k_codice);//
//====================================================================
//=== Cancella il rek dalla tabella t_contr 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
string k_mc_co, k_rag_soc
long k_cod_cli, k_contratto
kuf_contratti_co kuf1_contratti_co
st_tab_sd_md kst_tab_sd_md
st_esito kst_esito
st_tab_contratti_co kst_tab_contratti_co
ds_contratti_co_select kds_contratti_co_select


//=== Controllo se sc_cf associato nei Contratti
DECLARE contratti CURSOR FOR  
	  SELECT contratti.codice, mc_co, cod_cli, rag_soc_10
   	 FROM contratti left outer join clienti on
		      contratti.cod_cli = clienti.codice
	   WHERE contratti.sc_cf = :k_codice ;

 	   

open contratti;
if sqlca.sqlCode = 0 then

	fetch contratti INTO :k_contratto, :k_mc_co, :k_cod_cli, :k_rag_soc;

	if sqlca.sqlCode = 0 then
		k_return = "2" + "SC_CF già associato nella Conferma Ordine n. " &
			+ string(k_contratto, "####0") + " MC-CO " + trim(k_mc_co) + " di~n~r" + &
			  string(k_cod_cli, "####0") + " " + trim(k_rag_soc) + "~n~r" 	
	end if
	
	close contratti;
	
//--- controllo se esiste su DOSE-MAPPING	
	if LeftA(k_return, 1) = "0" then
	
		kst_tab_sd_md.sd_md=" "
		select max(sd_md) 
		    into :kst_tab_sd_md.sd_md
		    from sd_md
			 where sd_md = :k_codice
			using sqlca;
			
		if sqlca.sqlcode = 0 then
			if len(trim(kst_tab_sd_md.sd_md)) > 0 then
				k_return = "2" + "SC_CF già associato al Dose-Mapping: " &
							+ trim(kst_tab_sd_md.sd_md) + "~n~r" 	
			end if
		else
			if sqlca.sqlcode < 0 then
				k_return = "1" + "Errore durante lettura archivio Dose-Mapping. " &
							+ "~n~r" + "Errore: "	+ string(kst_esito.sqlcode ) + " - " + trim(kst_esito.sqlerrtext ) + " " 	
			end if
		end if
	
	end if
	
//--- controllo se esiste su CONTRATTI_CO
	if LeftA(k_return, 1) = "0" then
	
		try 
			kuf1_contratti_co = create kuf_contratti_co
		
//--- se esiste il sc_cf allora espongo qualche dato del contratto 		
			kst_tab_contratti_co.sc_cf_1 = trim(k_codice)
			if kuf1_contratti_co.if_esiste_sc_cf(kst_tab_contratti_co) then
				
				kds_contratti_co_select = kuf1_contratti_co.get_dati(kst_tab_contratti_co)
				if kds_contratti_co_select.rowcount( ) > 0 then
					kst_tab_contratti_co.data_stampa = kds_contratti_co_select.object.data_stampa[1]
					kst_tab_contratti_co.id_cliente = kds_contratti_co_select.object.id_cliente[1]
					if isnull(kds_contratti_co_select.object.oggetto[1]) then
						kst_tab_contratti_co.oggetto = " "
					else
						kst_tab_contratti_co.oggetto = kds_contratti_co_select.object.oggetto[1]
					end if
				else 
					kst_tab_contratti_co.data_stampa = date(0)
					kst_tab_contratti_co.id_cliente = 0
					kst_tab_contratti_co.oggetto = "non trovato"
				end if 
				
				k_return = "2" + "SC_CF associato nel contratto Commerciale n. " &
								+ string(kst_tab_contratti_co.id_contratto_co) + " del " + string(kst_tab_contratti_co.data_stampa) + " di~n~r" + &
							  string(kst_tab_contratti_co.id_cliente ) + " oggetto: " + trim(kst_tab_contratti_co.oggetto ) + "~n~r" 	
				
			end if
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			k_return = "1" + "SC_CF impossibile controllare nei contratti Commerrciali. Riprovare la cancellazione. " &
							+ " di~n~r" + "Errore: "	+ string(kst_esito.sqlcode ) + " - " + trim(kst_esito.sqlerrtext ) + " " 	
			
		finally
			destroy kuf1_contratti_co
			
		end try
		
	end if
	
end if

	
if LeftA(k_return, 1) = "0" then
	
	delete from sc_cf
			where codice = :k_codice ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText
	else

//		if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
//		end if

		
	end if
end if

return k_return
end function

public function st_esito sc_cf_aggiorna_attivo (ref date k_data_da, date k_data_a, string k_attivo);//
//--- Leggo Contratto specifico
//
st_tab_contratti kst_tab_contratti
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kst_tab_contratti.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_contratti.x_utente = kGuf_data_base.prendi_x_utente()

	update sc_cf  
			  set attivo = :k_attivo
			  ,x_datins = :kst_tab_contratti.x_datins
			  ,x_utente = :kst_tab_contratti.x_utente
			where data_scad between :k_data_da and :k_data_a
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento SC_CF (kuf_contratti.sc_cf_aggiorna_attivo):" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		
		if kst_tab_contratti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback()
		end if

	else
		kst_esito.esito = kkg_esito.ok

		if kst_tab_contratti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti.st_tab_g_0.esegui_commit) then
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.SQLErrText = "Errore in Aggiornamento SC_CF (commit in kuf_contratti.sc_cf_aggiorna_attivo):" + trim(kst_esito.SQLErrText)
			end if
		end if

	end if


return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_contratti kst_tab_contratti);//
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
		if kdw_anteprima.dataobject = "d_contratti"  then
			if kdw_anteprima.object.codice[1] = kst_tab_contratti.codice  then
				kst_tab_contratti.codice = 0 
			end if
		end if
	end if

	if kst_tab_contratti.codice > 0 then
	
			kdw_anteprima.dataobject = "d_contratti"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti.codice)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito anteprima_sc_cf (ref datawindow kdw_anteprima, st_tab_contratti kst_tab_contratti);//
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
kst_open_w.id_programma = kkg_id_programma_sc_cf

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
		if kdw_anteprima.dataobject = "d_sc_cf"  then
			if kdw_anteprima.object.sc_cf[1] = kst_tab_contratti.sc_cf  then
				kst_tab_contratti.sc_cf = " " 
			end if
		end if
	end if

	if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then
	
			kdw_anteprima.dataobject = "d_sc_cf"		
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti.sc_cf)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Capitolato da visualizzare: ~n~r" + "nessun Codice (sc-cf) indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public subroutine if_isnull (ref st_tab_contratti kst_tab_contratti);//---
//--- Inizializza i campi della tabella 
//---

if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0
if isnull(kst_tab_contratti.id_contratto_co) then kst_tab_contratti.id_contratto_co = 0
if isnull(kst_tab_contratti.id_contratto_dp) then kst_tab_contratti.id_contratto_dp = 0
if isnull(kst_tab_contratti.id_contratto_rd) then kst_tab_contratti.id_contratto_rd = 0
if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = ""
if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = ""
if isnull(kst_tab_contratti.sl_pt) then kst_tab_contratti.sl_pt = ""
if isnull(kst_tab_contratti.data) then kst_tab_contratti.data = date(0)
if isnull(kst_tab_contratti.data_scad) then kst_tab_contratti.data_scad = date(0)
if isnull(kst_tab_contratti.cod_cli) then kst_tab_contratti.cod_cli = 0
if isnull(kst_tab_contratti.descr) then kst_tab_contratti.descr = ""
if isnull(kst_tab_contratti.cert_st_dose_min) then kst_tab_contratti.cert_st_dose_min = ""
if isnull(kst_tab_contratti.cert_st_dose_max) then kst_tab_contratti.cert_st_dose_max = ""
if isnull(kst_tab_contratti.cert_st_data_ini) then kst_tab_contratti.cert_st_data_ini = ""
if isnull(kst_tab_contratti.cert_st_data_fin) then kst_tab_contratti.cert_st_data_fin = ""
if isnull(kst_tab_contratti.cert_st_dati_bolla_in) then kst_tab_contratti.cert_st_dati_bolla_in = ""
if isnull(kst_tab_contratti.flag_bolla_in_dett) then kst_tab_contratti.flag_bolla_in_dett = ""
if isnull(kst_tab_contratti.et_bcode_st_dt_rif) then kst_tab_contratti.et_bcode_st_dt_rif = ""
if isnull(kst_tab_contratti.et_dosimetro) then kst_tab_contratti.et_dosimetro = kki_et_dosimetro_default
if isnull(kst_tab_contratti.tipo) then kst_tab_contratti.tipo = kki_TIPO_standard
if isnull(kst_tab_contratti.costi_accessori) then kst_tab_contratti.costi_accessori = ""

if isnull(kst_tab_contratti.flg_fatt_dopo_valid) then kst_tab_contratti.flg_fatt_dopo_valid = ""
if isnull(kst_tab_contratti.flg_acconto) then kst_tab_contratti.flg_acconto = ""


if isnull(kst_tab_contratti.x_datins) then kst_tab_contratti.x_datins = datetime(date(0))
if isnull(kst_tab_contratti.x_utente) then kst_tab_contratti.x_utente = ""

end subroutine

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti);//
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
		if kdw_anteprima.dataobject = "d_contratti"  then
			if kdw_anteprima.object.codice[1] = kst_tab_contratti.codice  then
				kst_tab_contratti.codice = 0 
			end if
		end if
	end if

	if kst_tab_contratti.codice > 0 then
	
			kdw_anteprima.dataobject = "d_contratti"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti.codice)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Contratto da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito anteprima_sc_cf (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti);//
//=== 
//====================================================================
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
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_sc_cf

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
		if kdw_anteprima.dataobject = "d_sc_cf"  then
			if kdw_anteprima.object.sc_cf[1] = kst_tab_contratti.sc_cf  then
				kst_tab_contratti.sc_cf = " " 
			end if
		end if
	end if

	if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then
	
			kdw_anteprima.dataobject = "d_sc_cf"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_contratti.sc_cf)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Capitolato da visualizzare: ~n~r" + "nessun Codice (sc-cf) indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito get_sc_cf_pt (ref st_tab_contratti kst_tab_contratti);//
//--- get del SL-PT (Piano di Trattamento) in tabella Capitolati (SC-CF) x lo specifico codice capitolato
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	kst_tab_contratti.sc_cf = trim(kst_tab_contratti.sc_cf)
	
	select distinct
			 sl_pt
	 into :kst_tab_contratti.sl_pt
		from sc_cf
		where codice =  :kst_tab_contratti.sc_cf
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Capitolati (CF=" + string(kst_tab_contratti.sc_cf) + ") : " &
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

public function st_esito get_et_bcode_note (ref st_tab_contratti kst_tab_contratti);//
//--- Leggo Contratto specifico
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct
			 et_bcode_note
	 into :kst_tab_contratti.et_bcode_note
		from contratti
		where codice =  :kst_tab_contratti.codice
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Note 'barcode' in tab.Contratti (codice=" + string(kst_tab_contratti.codice) + ") : " &
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

public function st_esito get_sl_pt (ref st_tab_contratti kst_tab_contratti);//
//--- Leggo Piano di Trattamento in tabella CONTRATTI x lo specifico codice 
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct
			 sl_pt
	 into :kst_tab_contratti.sl_pt
		from contratti
		where codice =  :kst_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_tab_contratti.sl_pt = ""
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Piano di Treattamento (PT) in tab.Contratti (Codice=" + string(kst_tab_contratti.codice) + ") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
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

public function st_esito get_co_cf_pt (ref st_tab_contratti kst_tab_contratti);//
//--- Leggo Codici Contratto Commerciale e Capitolato di fornitura e Piano di trattamento x lo specifico codice contratto 
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct
			mc_co
			,sc_cf
			,sl_pt
	 into 	:kst_tab_contratti.mc_co
	 		,:kst_tab_contratti.sc_cf
	 		,:kst_tab_contratti.sl_pt
		from contratti
		where codice =  :kst_tab_contratti.codice
		using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab. Contratti (codice=" + string(kst_tab_contratti.codice) + ") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
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

	 if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = ""
	 if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = ""
	 if isnull(kst_tab_contratti.sl_pt) then kst_tab_contratti.sl_pt = ""
	
return kst_esito


end function

public function st_esito tb_delete (st_tab_sd_md kst_tab_sd_md);//
//====================================================================
//=== Cancella id dalla tabella DOSE-MAPPING
//=== 
//=== Input: st_tab_sd_md.id_sd_md
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_contratti //get_id_programma (kkg_flag_modalita.cancellazione) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Dose-Mapping' non Autorizzata: ~n~r" + "La funzione "+ trim(kst_open_w.id_programma) + " richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sd_md.id_sd_md > 0 then

		delete from sd_md
			where id_sd_md = :kst_tab_sd_md.id_sd_md
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Dose-Mapping' (sd_md):" + trim(sqlca.SQLErrText)
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
				if kst_tab_sd_md.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sd_md.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_sd_md.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sd_md.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if
end if


return kst_esito

end function

public subroutine elenco_sc_cf_attivi_cliente (st_tab_contratti kst_tab_contratti);//
//--- Fa l'elenco Contratti Attivi x Cliente indicato
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
	kds_1.dataobject = kki_dw_elenco_sc_cf_x_m_r_f
	kds_1.settransobject(sqlca) 
	

	if kst_tab_contratti.cod_cli > 0 then
		
		if isnull(kst_tab_contratti.attivo) then kst_tab_contratti.attivo = "S"
		
		kds_1.retrieve( kst_tab_contratti.cod_cli, kst_tab_contratti.attivo)
	
		
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
			kst_open_w.key1 = "Elenco Capitolati Attivi del Cliente: " + string( kst_tab_contratti.cod_cli ) //+ " " + trim(k_nome)
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

public function st_esito get_sl_pt (ref st_tab_sd_md kst_tab_sd_md);//
//--- Leggo Piano di Trattamento in tabella Dose-Mapping (SD_MD) x lo specifico ID 
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct
			 sl_pt
	 into :kst_tab_sd_md.sl_pt
		from sd_md
		where id_sd_md =  :kst_tab_sd_md.id_sd_md
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Piano di Trattamento (PT) in tab.Dose-Mapping (id=" + string(kst_tab_sd_md.id_sd_md) + ") : " &
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

public function long tb_add (st_tab_contratti kst_tab_contratti) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella CONTRATTI
//=== 
//=== Inp: st_tab_contratti - valorizzata
//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//=== Lancia EXCEPTION//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//===  
//====================================================================
//
long k_return = 0
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = kkg_id_programma_contratti

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	kst_esito.SQLErrText = "Inserimento 'Conferma Ordine (CO)' non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	kst_tab_contratti.codice = 0 
	
//--- imposto dati utente e data aggiornamento
	kst_tab_contratti.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_contratti.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
	if_isnull(kst_tab_contratti)
//codice
	INSERT INTO contratti  
				(    
				  contratto_co_data_ins,   
				  id_contratto_co,   
				  id_contratto_dp,   
				  id_contratto_rd,   
				  mc_co,   
				  sc_cf,   
				  sl_pt,   
				  data,   
				  data_scad,   
				  tipo,   
				  cod_cli,   
				  descr,   
				  cert_st_dose_min,   
				  cert_st_dose_max,   
				  cert_st_data_ini,   
				  cert_st_data_fin,   
				  cert_st_dati_bolla_in,   
				  flag_bolla_in_dett,   
				  et_bcode_st_dt_rif,   
				  et_bcode_note,   
				  costi_accessori,   
				  id_meca_causale,   
				  et_dosimetro,
				  flg_fatt_dopo_valid,
				  flg_acconto,
				  x_datins,   
				  x_utente )  
		VALUES (   
				  :kst_tab_contratti.contratto_co_data_ins,   
				  :kst_tab_contratti.id_contratto_co,   
				  :kst_tab_contratti.id_contratto_dp,   
				  :kst_tab_contratti.id_contratto_rd,   
				  :kst_tab_contratti.mc_co,   
				  :kst_tab_contratti.sc_cf,   
				  :kst_tab_contratti.sl_pt,   
				  :kst_tab_contratti.data,   
				  :kst_tab_contratti.data_scad,   
				  :kst_tab_contratti.tipo,   
				  :kst_tab_contratti.cod_cli,   
				  :kst_tab_contratti.descr,   
				  :kst_tab_contratti.cert_st_dose_min,   
				  :kst_tab_contratti.cert_st_dose_max,   
				  :kst_tab_contratti.cert_st_data_ini,   
				  :kst_tab_contratti.cert_st_data_fin,   
				  :kst_tab_contratti.cert_st_dati_bolla_in,   
				  :kst_tab_contratti.flag_bolla_in_dett,   
				  :kst_tab_contratti.et_bcode_st_dt_rif,   
				  :kst_tab_contratti.et_bcode_note,   
				  :kst_tab_contratti.costi_accessori,   
				  :kst_tab_contratti.id_meca_causale,   
				  :kst_tab_contratti.et_dosimetro,		
				  :kst_tab_contratti.flg_fatt_dopo_valid,
				  :kst_tab_contratti.flg_acconto,
				  :kst_tab_contratti.x_datins,   
				  :kst_tab_contratti.x_utente ) 
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Inserimento 'Conferma Ordine', errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if
	
	else

		k_return = get_codice_max( )
		//k_return = long(kguo_sqlca_db_magazzino.SQLReturnData)

//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_contratti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			if kst_tab_contratti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_contratti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if

	
end if


return k_return

end function

public function integer get_capitolati (string k_capitolati, ref string k_capitolato[]);//--------------------------------------------------------------------------------------------------------------------------------------------------		
//--- 
//--- Estrae i Capitolati da una stringa quale ad esempio la 'st_contratti_co.contratti_des'
//--- 
//--- inp: stringa con i cf separati da ';' 
//--- out: array con i cf trovati
//--- rit.: nr dei cf trovati
//--- Lancia EXCEPTION
//---
//--------------------------------------------------------------------------------------------------------------------------------------------------		
//
int k_return = 0
int k_nr_capitolato=0, k_pos=0, k_start=0
string k_trova=""
st_tab_contratti kst_tab_contratti
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_nr_capitolato=0
//--- cerca il carattere separatore  ';' e ' - ' 		
	k_start=1
	k_trova = ";"
	k_pos = pos(k_capitolati, k_trova, k_start)
	if k_pos = 0 then
		k_trova = " - "
		k_pos=pos(k_capitolati, k_trova, k_start)
	end if
//--- cerca altri sc-cf				
	do while k_pos > 0 
		kst_tab_contratti.sc_cf = trim(mid(k_capitolati, k_start, k_pos - k_start))
		if len(trim(kst_tab_contratti.sc_cf)) > 0 then
//--- esiste il CF estratto?
			k_nr_capitolato++
			if NOT if_esiste_sc_cf(kst_tab_contratti) then
				kst_esito.sqlerrtext = " Non trovato il Capitolato (" + string(k_nr_capitolato) + ") cod. " + string(kst_tab_contratti.sc_cf ) + "~n~r" 
				kst_esito.esito = kkg_esito.not_fnd
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if

//--- se CAPITOLATO OK
			k_capitolato[k_nr_capitolato] = kst_tab_contratti.sc_cf
			
		end if
		k_start = k_pos +  len(k_trova)
//--- cerca il carattere separatore  ';' e ' - ' 				
		k_trova = ";"
		k_pos = pos(k_capitolati, k_trova, k_start)
		if k_pos = 0 then
			k_trova = " - "
			k_pos=pos(k_capitolati, k_trova, k_start)
		end if
	loop

//--- c'e' un altro CF senza chiusura del carattere ';' o ' - '
	k_pos = len(k_capitolati)
	kst_tab_contratti.sc_cf = trim(mid(k_capitolati, k_start, k_pos - k_start + 1))
	if len(kst_tab_contratti.sc_cf) > 0 then
		k_nr_capitolato++
		if NOT if_esiste_sc_cf(kst_tab_contratti) then
			kst_esito.sqlerrtext = " Non trovato il Capitolato (" + string(k_nr_capitolato) + ") cod. " + string(kst_tab_contratti.sc_cf ) + "~n~r" 
			kst_esito.esito = kkg_esito.not_fnd
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if

//--- se CAPITOLATO OK
		k_capitolato[k_nr_capitolato] = kst_tab_contratti.sc_cf
	
	end if

		
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante lettura Capitolato " + string(kst_tab_contratti.sc_cf ) &
					+ " err=" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
	kst_esito.esito = kkg_esito.not_fnd
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception

finally 
	k_return = k_nr_capitolato


end try


return k_return 

end function

public function string get_sl_pt (ref string k_codice) throws uo_exception;//
//--- Leggo Piano di Trattamento in tabella CAPITOLATI (sc_cf) x lo specifico CODICE 
//
string k_return=""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 sl_pt
	 into :k_return
		from sc_cf
		where codice =  :k_codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Capitolati di Fornitura del Piano di Trattamento (PT) (codice=" + string(k_codice) + ") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if isnull(k_return) then k_return = ""
	
return k_return


end function

public function long get_cod_cli (ref string k_codice) throws uo_exception;//
//--- Leggo Codice Cliente in tabella SC_CF x lo specifico codice 
//
long k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 cod_cli
	 into :k_return
		from sc_cf 
		where codice =  :k_codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura codice Cliente da tab.Capitolati di Fornitura (codice=" + string(k_codice) + ") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if isnull(k_return) then k_return = 0
	
return k_return


end function

public function boolean if_esiste_mc_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Controllo esistenza del Contratto Commerciale
//--- inp: kst_tab_contratti.mc_co
//--- out: boolean true=trovato; false = non trovato
//--- lancia EXCEPTION se errore sql
//
boolean k_return=false
int k_check
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct 1
	 	into :k_check
			from contratti
			where mc_co =  :kst_tab_contratti.mc_co
			using sqlca;

	
	if sqlca.sqlcode = 0 then
		if k_check = 1 then
			k_return = true    //OK TROVATO
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Contratti (mc_co=" + trim(kst_tab_contratti.mc_co) + ") : " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	end if
	
return k_return


end function

public function boolean if_esiste_sc_cf (readonly st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Controllo esistenza del Capitolato di Fornitura 
//--- inp: kst_tab_contratti.sc_cf
//--- out: boolean true=trovato; false = non trovato
//--- lancia EXCEPTION se errore sql
//
boolean k_return=false
int k_check
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select distinct 1
	 	into :k_check
			from sc_cf
			where codice =  :kst_tab_contratti.sc_cf
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if k_check = 1 then
			k_return = true    //OK TROVATO
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Contratti (sc_cf=" + trim(kst_tab_contratti.sc_cf) + ") : " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	end if
	
return k_return


end function

public function long if_esiste_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Controllo esistenza del CONTRATTO (Conferma Ordine)
//--- inp: kst_tab_contratti.sc_cf, sl_pt, cod_cli
//--- out: codice del Contratto; 0 = non trovato
//--- lancia EXCEPTION se errore sql
//
long k_return=0
int k_check
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select max (codice)
	 	into :kst_tab_contratti.codice
			from contratti
			where sc_cf =  :kst_tab_contratti.sc_cf
			    and sl_pt =  :kst_tab_contratti.sl_pt
				and cod_cli = :kst_tab_contratti.cod_cli
				and data_scad = :kst_tab_contratti.data_scad
			using sqlca;

	
	if sqlca.sqlcode = 0 then
		if kst_tab_contratti.codice > 0 then
			k_return = kst_tab_contratti.codice    //OK TROVATO
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Conferme Ordini (sc_cf=" + trim(kst_tab_contratti.sc_cf) + "sl_pt=" + trim(kst_tab_contratti.sl_pt) + "cliente=" + string(kst_tab_contratti.cod_cli) +") : " &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if
	end if
	
return k_return


end function

public function integer get_et_dosimetro (ref st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Leggo ET_DOSIMETRO (numero etichette x dosimetria da stampare x Lotto) n tabella Conferma-Ordine x lo specifico codice 
//
int k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 et_dosimetro
	 into :kst_tab_contratti.et_dosimetro
		from contratti 
		where codice =  :kst_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura num. Etichette-Dosimetro da stampare in 'Conferma Ordine' (contratti), codice=" + string(kst_tab_contratti.codice) + "  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
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
	
	k_return = kst_tab_contratti.et_dosimetro 
	
	if isnull(k_return) then k_return = kki_et_dosimetro_default
	
return k_return


end function

public function long get_id_meca_causale (readonly st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Leggo eventuale codice Blocco
//--- 
//--- Inp: st_tab_contratti.codice
//--- Out:
//--- Rit.: id_meca_causale altrimenti ZERO
//---
//--- Lancia EXCEPTION per errore
//
long k_return=0
st_esito kst_esito
st_tab_contratti kst_tab_contratti



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 id_meca_causale
	 into :kst_tab_contratti.id_meca_causale
		from contratti 
		where codice =  :ast_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura codice Causale di Entrata merce in 'Conferma Ordine' (contratti), codice=" + string(kst_tab_contratti.codice) + "  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_contratti.id_meca_causale = 0
		end if
	end if
	
	if isnull(kst_tab_contratti.id_meca_causale) then
		k_return = 0
	else
		k_return = kst_tab_contratti.id_meca_causale 
	end if
	
	
return k_return


end function

public function boolean link_call_imvc (ref st_tab_contratti kst_tab_contratti, st_open_w kst_open_w_arg) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------
//--- Chiama pgm giusto a seconda della modalita  Inserim./Modifica/Visualizzaz./Cancellaz.
//---
//--- Inp: st_tab_contratti   contratto 
//---		 st_open_w.flag_modalita (come da standard kg_flag_modalita_....)
//--- Out: TRUE = tutto OK
//--- 
//--- Lancia EXCEPTION con ST_ESITO, standard 
//--- 
//--------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	if isnull(kst_tab_contratti.cod_cli) then kst_tab_contratti.cod_cli = 0
	if isnull(kst_tab_contratti.mc_co) or len(trim(kst_tab_contratti.mc_co))= 0 then kst_tab_contratti.mc_co = "*"
	if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto
		K_st_open_w.id_programma = kkg_id_programma_contratti
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kst_open_w_arg.flag_modalita
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(kst_tab_contratti.cod_cli) // cod cliente
		K_st_open_w.key2 = trim(kst_tab_contratti.mc_co)  // cod mc_co 
		K_st_open_w.key3 = string(kst_tab_contratti.codice)  // cod contratto
		K_st_open_w.key4 = "*"   // Tutti i contratti
		K_st_open_w.key5 = " " //
		K_st_open_w.key6 = " " //
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
		k_return = true
		
//		kuo_exception = create uo_exception
//		kuo_exception.setmessage( "Nessun valore disponibile. " )
//		throw kuo_exception
		
		

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
st_tab_contratti_co kst_tab_contratti_co
st_tab_contratti_dp kst_tab_contratti_dp
st_tab_contratti_rd kst_tab_contratti_rd
kuf_contratti_co kuf1_contratti_co
kuf_contratti_rd kuf1_contratti_rd
kuf_contratti_dp kuf1_contratti_dp


st_tab_contratti kst_tab_contratti
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "contratto", "mc_co", "contratti_codice"
		kst_tab_contratti.codice = 0
		if a_campo_link = "contratto" then
			kst_tab_contratti.codice = adw_1.getitemnumber(adw_1.getrow(), a_campo_link)
		else
			if trim(adw_1.Describe("contratti_codice.x")) <> "!" then 
				kst_tab_contratti.codice = adw_1.getitemnumber(adw_1.getrow(), "contratti_codice")
			end if
		end if			

		if kst_tab_contratti.codice > 0 then 
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_contratti )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Contratto: " + trim(string(kst_tab_contratti.codice) )
		else
			k_return = false
		end if

	case "sc_cf", "cf"
		kst_tab_contratti.sc_cf = adw_1.getitemstring(adw_1.getrow(), a_campo_link)
		if len(trim(kst_tab_contratti.sc_cf)) > 0 then
	
			kst_esito = this.anteprima_sc_cf ( kdsi_elenco_output, kst_tab_contratti )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "codice Capitolato: " + trim(kst_tab_contratti.sc_cf)
		else
			k_return = false
		end if

	case "b_sc_cf_l"
		kst_tab_contratti.cod_cli = 0
		kst_tab_contratti.attivo = ""
		kst_esito = this.anteprima_sc_cf_l( kdsi_elenco_output, kst_tab_contratti )
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
		kst_open_w.key1 = "Elenco Capitolati"

	case "b_contratti"
		kst_tab_contratti.codice = adw_1.getitemnumber(adw_1.getrow(), "contratto")
		if kst_tab_contratti.codice > 0 then
			this.get_id_contratto(kst_tab_contratti)
			kst_esito.esito = kkg_esito.ok
			
			choose case true
				case kst_tab_contratti.id_contratto_co > 0 
					kst_tab_contratti_co.id_contratto_co = kst_tab_contratti.id_contratto_co
					kuf1_contratti_co = create kuf_contratti_co
					kst_esito = kuf1_contratti_co.anteprima(kdsi_elenco_output, kst_tab_contratti_co)
					kst_open_w.key1 = "Id Contratto: " + string(kst_tab_contratti.id_contratto_co)
				case kst_tab_contratti.id_contratto_dp > 0 
					kst_tab_contratti_dp.id_contratto_dp = kst_tab_contratti.id_contratto_dp
					kuf1_contratti_dp = create kuf_contratti_dp
					kst_esito = kuf1_contratti_dp.anteprima(kdsi_elenco_output, kst_tab_contratti_dp)
					kst_open_w.key1 = "Id Contratto: " + string(kst_tab_contratti.id_contratto_dp)
				case kst_tab_contratti.id_contratto_rd > 0 
					kst_tab_contratti_rd.id_contratto_rd = kst_tab_contratti.id_contratto_rd
					kuf1_contratti_rd = create kuf_contratti_rd
					kst_esito = kuf1_contratti_rd.anteprima(kdsi_elenco_output, kst_tab_contratti_rd)
					kst_open_w.key1 = "Id Contratto: " + string(kst_tab_contratti.id_contratto_rd)
			end choose
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
		throw kguo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public subroutine get_id_contratto (ref st_tab_contratti ast_tab_contratti) throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna uno dei tre id del contratto con cui è stato creato
//--- 
//--- input: st_tab_contratti.CODICE 
//--- Out: st_tab_contratti.ID_CONTRATTO_CO, ID_CONTRATTO_DP, ID_CONTRATTO_RD 
//---
//--- lancia EXCPETION 
//-------------------------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	ast_tab_contratti.ID_CONTRATTO_CO = 0
	ast_tab_contratti.ID_CONTRATTO_DP = 0
	ast_tab_contratti.ID_CONTRATTO_RD = 0
	
	select distinct
			 ID_CONTRATTO_CO
			 , ID_CONTRATTO_DP
			 , ID_CONTRATTO_RD 
	 into :ast_tab_contratti.ID_CONTRATTO_CO
	 		, :ast_tab_contratti.ID_CONTRATTO_DP
	 		, :ast_tab_contratti.ID_CONTRATTO_RD
		from contratti 
		where codice =  :ast_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura in 'Conferma Ordine' (contratti) del ID Contratto associato, codice=" + string(ast_tab_contratti.codice) + "  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
		
	end if
	
	if isnull(ast_tab_contratti.ID_CONTRATTO_CO) then ast_tab_contratti.ID_CONTRATTO_CO = 0
	if isnull(ast_tab_contratti.ID_CONTRATTO_DP) then ast_tab_contratti.ID_CONTRATTO_DP = 0
	if isnull(ast_tab_contratti.ID_CONTRATTO_RD) then ast_tab_contratti.ID_CONTRATTO_RD = 0
	


end subroutine

public function long if_esiste_co_x_mc_co (readonly st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Controllo esistenza del CONTRATTO (Conferma Ordine) x codice MC_CO (conferma Ordine)
//--- inp: kst_tab_contratti.mc_co
//--- out: codice del Contratto; 0 = non trovato
//--- lancia EXCEPTION se errore sql
//
long k_return=0
int k_check
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	select max (codice)
	 	into :kst_tab_contratti.codice
			from contratti
			where mc_co =  :kst_tab_contratti.mc_co
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_contratti.codice > 0 then
			k_return = kst_tab_contratti.codice    //OK TROVATO
		end if
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Tab.Conferme Ordine (mc_co=" + trim(kst_tab_contratti.mc_co) + "): " &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if
	
return k_return


end function

public function date get_data_scad (ref st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Leggo Data Scadenza e data di Inizio in tabella Contratti x lo specifico codice 
//--- Inp: st_tab_contratti.codice
//--- Out: st_tab_contratti.data e data_scad
//--- Rit: data_scad
//
date k_return=date(0)
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select data
			 ,data_scad
	 into :ast_tab_contratti.data
	 		,:ast_tab_contratti.data_scad
		from contratti 
		where codice = :ast_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura periodo validità del Contratto (codice=" + string(ast_tab_contratti.codice) + ")" &
							+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_contratti.data_scad > date(0) then
			k_return = ast_tab_contratti.data_scad
		end if
	end if
	
return k_return


end function

public function date get_sc_cf_data_scad (ref st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Leggo Data Scadenza in tabella SC_CF x lo specifico codice 
//
date k_return=date(0)
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 data_scad
	 into :ast_tab_contratti.data_scad
		from sc_cf
		where codice = :ast_tab_contratti.sc_cf
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura data di scadenza del Capitolato (codice=" + string(ast_tab_contratti.sc_cf) + ")" &
							+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if ast_tab_contratti.data_scad > date(0) then
		k_return = ast_tab_contratti.data_scad
	end if
	
return k_return


end function

public function long get_contratto_da_cf_co (ref st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Leggo codice CONTRATTO da SC_CF e MC_CO e DATA_SCAD = data in cui in contratto non deve essere scaduto (se non c'e' nulla mette data-oggi)
//---
//--- st_tab_contratti.sc_cf  e  mc_co oppure uno dei due
//--- out:
//--- rit: codice contratto
//
long k_return=0, k_righe=0, k_rowfind
st_esito kst_esito
datastore kds_ds_contratti_x_cf_co_scad

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()

	if isnull(ast_tab_contratti.sc_cf) then ast_tab_contratti.sc_cf = ""
	if isnull(ast_tab_contratti.mc_co) then ast_tab_contratti.mc_co = ""
	if ast_tab_contratti.data_scad > kkg.data_zero then
	else
		ast_tab_contratti.data_scad = kguo_g.get_dataoggi( )
	end if
	
	kds_ds_contratti_x_cf_co_scad = create datastore  
	kds_ds_contratti_x_cf_co_scad.dataobject = "ds_contratti_x_cf_co_scad"
	kds_ds_contratti_x_cf_co_scad.settransobject(kguo_sqlca_db_magazzino)
	//informix k_righe = kds_ds_contratti_x_cf_co_scad.retrieve(ast_tab_contratti.SC_CF, ast_tab_contratti.MC_CO, ast_tab_contratti.data_scad)
	k_righe = kds_ds_contratti_x_cf_co_scad.retrieve(ast_tab_contratti.data_scad, ast_tab_contratti.MC_CO)
//--- piglia la riga Contratto come richiesto se indicato anche il SC_CF
	if k_righe > 0 then
		if trim(ast_tab_contratti.SC_CF) > " " then
		else
			ast_tab_contratti.SC_CF = " "
		end if
		k_righe = kds_ds_contratti_x_cf_co_scad.find( "sc_cf = '" + trim(ast_tab_contratti.SC_CF) + "' ", 1, k_righe)
	end if

//    select distinct contratti.CODICE
//	      into :ast_tab_contratti.codice
//         from contratti inner join listino on CONTRATTI.CODICE = LISTINO.CONTRATTO and LISTINO.ATTIVO = "S"    
//         where 
//            (
//             (contratti.SC_CF = :ast_tab_contratti.SC_CF and :ast_tab_contratti.SC_CF > " " and :ast_tab_contratti.MC_CO = " ")
//             or
//             (contratti.SC_CF = :ast_tab_contratti.SC_CF and contratti.MC_CO = :ast_tab_contratti.MC_CO)
//             or (:ast_tab_contratti.SC_CF = " " 
//                 and (contratti.SC_CF is null or contratti.SC_CF = "")
//                 and contratti.MC_CO = :ast_tab_contratti.MC_CO
//                )
//            ) 
//            and contratti.data_scad >= :ast_tab_contratti.data_scad 
//            and contratti.data <= :ast_tab_contratti.data_scad  
//		using kguo_sqlca_db_magazzino;
	
//	if kguo_sqlca_db_magazzino.sqlcode < 0 then
	if k_righe < 0 then 
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura in lettura Contratto, cercato Capitolato " + string(ast_tab_contratti.SC_CF) + " e Commerciale " + string(ast_tab_contratti.MC_CO) &
	//						+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
//--- piglia la riga trovata con o senza CF
	if k_righe > 0 then
		ast_tab_contratti.codice = kds_ds_contratti_x_cf_co_scad.getitemnumber( k_righe, "codice")
		if ast_tab_contratti.codice > 0 then
			k_return = ast_tab_contratti.codice
		end if
	end if
	
return k_return


end function

public function st_esito select_riga (ref st_tab_contratti kst_tab_contratti);//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice = kst_tab_contratti.codice
	
	select 
			 mc_co,
			 sc_cf,
			 sl_pt,
			 data,
			 data_scad,
			 cod_cli,
			 descr,
			 cert_st_dose_min,
			 cert_st_dose_max,
			 cert_st_data_ini,
			 cert_st_data_fin,
			 cert_st_dati_bolla_in
			 ,tipo
			 ,costi_accessori
			 ,et_dosimetro
			 ,flg_fatt_dopo_valid
			 ,flg_acconto
	 into 
			:kst_tab_contratti.mc_co,
			:kst_tab_contratti.sc_cf,
			:kst_tab_contratti.sl_pt,
			:kst_tab_contratti.data,
			:kst_tab_contratti.data_scad,
			:kst_tab_contratti.cod_cli,
			:kst_tab_contratti.descr,
			:kst_tab_contratti.cert_st_dose_min,
			:kst_tab_contratti.cert_st_dose_max,
			:kst_tab_contratti.cert_st_data_ini,
			:kst_tab_contratti.cert_st_data_fin,
			:kst_tab_contratti.cert_st_dati_bolla_in
			,:kst_tab_contratti.tipo
			,:kst_tab_contratti.costi_accessori
			,:kst_tab_contratti.et_dosimetro
			,:kst_tab_contratti.flg_fatt_dopo_valid
			,:kst_tab_contratti.flg_acconto
		from contratti
		where 
		codice = :k_codice
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Contratti (codice=" + string(k_codice) + ") : " &
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

public function string get_flg_fatt_dopo_valid (readonly st_tab_contratti ast_tab_contratti) throws uo_exception;//---
//--- Torna flg_fatt_dopo_valid  ovvero il flag che indica se Attivare la Fatturazione delle Voci Prezzi Lotto dopo la Stampa Attestato
//--- 
//--- Inp: st_tab_contratti.codice
//--- Out:
//--- Rit.: flg_fatt_dopo_valid 
//---
//--- Lancia EXCEPTION per errore
//
string k_return=""
st_esito kst_esito
st_tab_contratti kst_tab_contratti



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select 
			 flg_fatt_dopo_valid
	 into :kst_tab_contratti.flg_fatt_dopo_valid
		from contratti 
		where codice =  :ast_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura flag di 'Attiva Fatturaz. dopo la stampa Attestato' in 'Conferma Ordine' (contratti), codice=" + string(kst_tab_contratti.codice) + "  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_contratti.flg_fatt_dopo_valid = ""
		end if
	end if
	
	if isnull(kst_tab_contratti.flg_fatt_dopo_valid) then
		k_return = ""
	else
		k_return = kst_tab_contratti.flg_fatt_dopo_valid 
	end if
	
	
return k_return


end function

public function string get_flg_acconto (readonly st_tab_contratti ast_tab_contratti) throws uo_exception;//---
//--- Torna flg_acconto  ovvero il flag che indica se Contratto previsto Acconto
//--- 
//--- Inp: st_tab_contratti.codice
//--- Out:
//--- Rit.: flg_acconto 
//---
//--- Lancia EXCEPTION per errore
//
string k_return=""
st_esito kst_esito
st_tab_contratti kst_tab_contratti



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select 
			 flg_acconto
	 into :kst_tab_contratti.flg_acconto
		from contratti 
		where codice =  :ast_tab_contratti.codice
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura flag 'Acconto' in 'Conferma Ordine' (contratti), codice=" + string(kst_tab_contratti.codice) + "  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_contratti.flg_acconto = ""
		end if
	end if
	
	if isnull(kst_tab_contratti.flg_acconto) then
		k_return = ""
	else
		k_return = kst_tab_contratti.flg_acconto 
	end if
	
	
return k_return


end function

public function st_esito anteprima_sc_cf_l (ref datastore kdw_anteprima, st_tab_contratti kst_tab_contratti);//
//=== 
//====================================================================
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
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_sc_cf

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

		kdw_anteprima.dataobject = "d_sc_cf_l"		
		kdw_anteprima.settransobject(sqlca)

		if kst_tab_contratti.cod_cli > 0 then
		else
			kst_tab_contratti.cod_cli = 0
		end if
		if trim(kst_tab_contratti.attivo) > " " then
		else
			kst_tab_contratti.attivo = "*"
		end if
		
		kdw_anteprima.reset()	
	//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_contratti.cod_cli, kst_tab_contratti.attivo)
	
end if


return kst_esito

end function

public function boolean if_scaduto_sc_cf (st_tab_contratti kst_tab_contratti) throws uo_exception;//
//--- Controllo se Capitolato di Fornitura Scaduto
//--- inp: kst_tab_contratti.sc_cf / data_scad (se non indicata mette data oggi)
//--- out: boolean true=trovato; false = non trovato
//--- lancia EXCEPTION se errore sql
//
boolean k_return=false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if kst_tab_contratti.data_scad > kkg.data_zero then
	else
		kst_tab_contratti.data_scad = kguo_g.get_dataoggi( )
	end if
	
	if trim(kst_tab_contratti.sc_cf) > " " then
		if get_data_scad(kst_tab_contratti) < kst_tab_contratti.data_scad then
		else
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( /*st_esito ast_esito */)
	kst_esito.SQLErrText = "Errore in valutazione se Contratto '" + trim(kst_tab_contratti.sc_cf) + "' scaduto prima del " + string(kst_tab_contratti.data_scad) &
									 + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception

end try
	
return k_return


end function

public function date get_data_scad_sc_cf (st_tab_contratti ast_tab_contratti) throws uo_exception;//
//--- Leggo Data Scadenza in tabella SC_CF x lo specifico codice sc_cf
//
date k_return=date(0)
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.inizializza()
	
	select distinct
			 data_scad
	 into :ast_tab_contratti.data_scad
		from sc_cf
		where codice = :ast_tab_contratti.sc_cf
		using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura data di scadenza del Contratto CF (codice=" + trim(ast_tab_contratti.sc_cf) + ")" &
							+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_contratti.data_scad > date(0) then
			k_return = ast_tab_contratti.data_scad
		end if
	end if
	
return k_return


end function

public function long elenco_contratti_attivi_cliente (st_tab_contratti kst_tab_contratti);//
//--- Fa l'elenco Contratti Attivi x Cliente indicato
//--- Inp: kst_tab_contratti.cod_cli
//--- rit: numero contratti trovati
//
long k_return
st_open_w kst_open_w
kuf_elenco kuf1_elenco
datastore kds_1
//pointer kp_oldpointer  // Declares a pointer variable


//kp_oldpointer = SetPointer(HourGlass!)

	
	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kds_1.dataobject = kki_dw_elenco_contratti
	kds_1.settransobject(kguo_sqlca_db_magazzino) 
	

	if kst_tab_contratti.cod_cli > 0 then
		k_return = kds_1.retrieve( kst_tab_contratti.cod_cli, "*" )
	
		if k_return > 0 then
		
		//--- chiamare la window di elenco
			kuf1_elenco = create kuf_elenco
			kst_open_w.key1 = "Elenco Contratti Attivi del Cliente: " + string( kst_tab_contratti.cod_cli ) //+ " " + trim(k_nome)
			kst_open_w.key2 = trim(kds_1.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kds_1
			kuf1_elenco.u_open(kst_open_w)
			if isvalid(kuf1_elenco) then destroy kuf1_elenco
			
		end if
	end if
						
//SetPointer(kp_oldpointer)

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
		 FROM contratti  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo Codice Contratto in tabella (CONTRATTI)" &
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

public function st_esito get_codice_da_cf_co (ref st_tab_contratti kst_tab_contratti) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------
//--- Leggo Contratto specifico da SC_CF e MC_CO e CLIE_3
//---
//--- Inp: st_tab_contratti con sc_cf + mc_co + clie_3
//--- Out: st_tab_contratti.codice   se + di 1 allora torna il piu' vecchio ma segnla errore!!!
//--- Rit: st_esito con kkg_esito.err_logico = trovati più codici
//--- lancia EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------
//
long k_righe, k_riga
st_esito kst_esito
datastore kds_1


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if isnull(kst_tab_contratti.mc_co) or len(trim(kst_tab_contratti.mc_co)) = 0 then kst_tab_contratti.mc_co = ""
	if isnull(kst_tab_contratti.sc_cf) or len(trim(kst_tab_contratti.sc_cf)) = 0 then kst_tab_contratti.sc_cf = ""
	if isnull(kst_tab_contratti.cod_cli)  then kst_tab_contratti.cod_cli = 0
	if isnull(kst_tab_contratti.data_scad) or kst_tab_contratti.data_scad = date(0) then kst_tab_contratti.data_scad = kg_dataoggi

	
	kst_tab_contratti.SC_CF = trim(kst_tab_contratti.SC_CF)
	kst_tab_contratti.MC_CO = trim(kst_tab_contratti.MC_CO)

	kds_1 = create datastore
	kds_1.dataobject = "ds_contratti_x_cli_co_cf"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	
	k_righe = kds_1.retrieve(kst_tab_contratti.cod_cli, kst_tab_contratti.MC_CO, kst_tab_contratti.SC_CF, kst_tab_contratti.data_scad )
	
	if k_righe > 0 then
			
		kst_tab_contratti.data = kds_1.getitemdate(1, "data")
		kst_tab_contratti.codice = kds_1.getitemnumber(1, "codice")

		if k_righe > 1 then

//--- se trovo più contratti allora errore!
			kst_esito.SQLErrText = "Trovati " + string(k_righe) + " contratti: "
			for k_riga = 1 to k_righe
				kst_esito.SQLErrText += string(kds_1.getitemnumber(k_riga, "codice")) + ",  " 
			next
			kst_esito.SQLErrText += " prego controllare." 
			kst_esito.esito = kkg_esito.err_logico
			
		end if
	else
		if k_righe < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = k_righe
			kst_esito.SQLErrText = "Errore in ricerca Codice Contratto (" &
										+ "cliente: " + string(kst_tab_contratti.cod_cli) + " " &
										+ "CF: " + string(kst_tab_contratti.sc_cf) + " " &
										+ "CO: " + string(kst_tab_contratti.mc_co) + " " &
										+ "data validità: " + string(kst_tab_contratti.data_scad) + "- " &
										+ "cliente=" + string(kst_tab_contratti.cod_cli) + "): ~n~r" &
										+ trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	end if
	
	if kst_tab_contratti.codice > 0 then
	else
		kst_esito.esito = kkg_esito.not_fnd
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
	if isvalid(kds_1) then destroy kds_1
	
end try
	
return kst_esito


end function

on kuf_contratti.create
call super::create
end on

on kuf_contratti.destroy
call super::destroy
end on

