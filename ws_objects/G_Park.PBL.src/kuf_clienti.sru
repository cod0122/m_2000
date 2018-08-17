$PBExportHeader$kuf_clienti.sru
forward
global type kuf_clienti from nonvisualobject
end type
end forward

global type kuf_clienti from nonvisualobject
end type
global kuf_clienti kuf_clienti

type variables
//
//---- campo fattura_da inteso come cliente da fatturare sulle bolle di sped o sui certificati
constant string kki_fattura_da_bolla = 'B' // fattura solo se bolla di sped pronta
constant string kki_fattura_da_certif = 'C'   // già fattura quando il certificato è pronto

//--- Tipo Anagrafica ientificato dall'arcivio MRF
constant string kki_tipo_mrf_NESSUNO = "N" 
constant string kki_tipo_mrf_FATTURATO = "F"  // detto anche cliente
constant string kki_tipo_mrf_MANDANTE = "M"
constant string kki_tipo_mrf_RICEVENTE = "R"
constant string kki_tipo_mrf_FATT_MAN = "G"
constant string kki_tipo_mrf_FATT_RIC = "H"
constant string kki_tipo_mrf_FATT_MAN_RIC = "I"
constant string kki_tipo_mrf_MAN_RIC = "L"

//--- Tipo della Natura dell'Anagrafica come indicato in archivio 
constant string kki_tipo_CONTATTO = "C"  
constant string kki_tipo_FATTURATO = "F"  // detto anche cliente
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
public function st_esito leggi (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_riceventi (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_mandanti (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nr_fatturati (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_tipo (ref st_tab_clienti kst_tab_clienti)
public function st_esito tb_update (st_tab_clienti_fatt kst_tab_clienti_fatt)
public function st_esito tb_delete (st_tab_clienti_fatt kst_tab_clienti_fatt)
public function string tb_delete_ind_comm (st_tab_ind_comm kst_tab_ind_comm)
public function string tb_delete_m_r_f (st_tab_clienti_m_r_f kst_tab_clienti_m_r_f)
public function st_esito get_ultimo_id (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_nome (ref st_tab_clienti kst_tab_clienti)
public function st_esito esenzione_iva_controllo_fattura (ref st_clienti_esenzione_iva kst_clienti_esenzione_iva)
public function st_esito get_p_iva (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_tipo_banca (ref st_tab_clienti kst_tab_clienti)
public function st_esito get_esenzione_iva (ref st_tab_clienti kst_tab_clienti)
public function boolean link_call (ref uo_d_std_1 kdw_1, string k_campo_link) throws uo_exception
public function integer if_presente_id_clie_settore (st_tab_clienti kst_tab_clienti) throws uo_exception
public function integer if_presente_id_clie_classe (st_tab_clienti kst_tab_clienti) throws uo_exception
public function st_esito get_indirizzi (ref st_tab_clienti kst_tab_clienti)
public function st_esito tb_delete (st_tab_clienti_mkt kst_tab_clienti_mkt)
public function st_esito tb_delete (st_tab_clienti_web kst_tab_clienti_web)
public function st_esito tb_update (st_tab_clienti_mkt kst_tab_clienti_mkt)
public function st_esito tb_update (st_tab_clienti_web kst_tab_clienti_web)
end prototypes

public function st_esito conta_p_iva (ref st_tab_clienti kst_tab_clienti);//====================================================================
//=== Conta le P_IVA uguali
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	kst_tab_clienti.contati = 0
	
   SELECT count(*)
       into :kst_tab_clienti.contati
		 FROM clienti
			where p_iva = :kst_tab_clienti.p_iva
			using sqlca;
	
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Clienti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_ind_comm.clie_c > 0 then

	kuf_sicurezza kuf1_sicurezza

	kst_tab_ind_comm.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_ind_comm.x_utente = kuf1_data_base.prendi_x_utente()

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


	
	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica Associazione mandante-ricevente-cliente non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		select distinct clie_c
			into :k_rcn
			from ind_comm
			WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode = 0 then
			UPDATE ind_comm  
			  SET rag_soc_1_c = :kst_tab_ind_comm.rag_soc_1_c,   
					rag_soc_2_c = :kst_tab_ind_comm.rag_soc_2_c,   
					indi_c = :kst_tab_ind_comm.indi_c,   
					loc_c = :kst_tab_ind_comm.loc_c,   
					cap_c = :kst_tab_ind_comm.cap_c,   
					prov_c = :kst_tab_ind_comm.prov_c,  
					x_datins = :kst_tab_ind_comm.x_datins,  
					x_utente = :kst_tab_ind_comm.x_utente  
				WHERE ind_comm.clie_c = :kst_tab_ind_comm.clie_c 
				using sqlca;
				
		else
			
			if sqlca.sqlcode = 100 then
				INSERT INTO ind_comm  
						( clie_c,   
						  rag_soc_1_c,   
						  rag_soc_2_c,   
						  indi_c,   
						  loc_c,   
						  cap_c,   
						  prov_c,   
						  x_datins,   
						  x_utente )  
				  VALUES ( :kst_tab_ind_comm.clie_c,   
						  :kst_tab_ind_comm.rag_soc_1_c,   
						  :kst_tab_ind_comm.rag_soc_2_c,   
						  :kst_tab_ind_comm.indi_c,   
						  :kst_tab_ind_comm.loc_c,   
						  :kst_tab_ind_comm.cap_c,   
						  :kst_tab_ind_comm.prov_c,   
						  :kst_tab_ind_comm.x_datins,   
						  :kst_tab_ind_comm.x_utente )  
				using sqlca;
			end if
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Indirizz Fatt.i:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_ind_comm.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ind_comm.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	end if
	
	
else
	kst_esito.SQLErrText = "Tab.Ind.Fatturazione: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
	
end if		



return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_clienti kst_tab_clienti);//
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_clienti_1"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

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


kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
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
			 FROM arfa
			WHERE clie_3 = :k_id_cliente 
		union all
		  SELECT num_fatt,
					data_fatt
			 FROM o_arfa
			WHERE clie_3 = :k_id_cliente ; 
			
			
			
	
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
				kuf1_data_base.db_rollback_1( )
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
				kuf1_data_base.db_commit_1( )
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
if isnull(kst_tab_clienti.tipo_mrf ) then kst_tab_clienti.tipo_mrf  = " "
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
if isnull(kst_tab_clienti.mese_es_1) then kst_tab_clienti.mese_es_1 = 0
if isnull(kst_tab_clienti.mese_es_2) then kst_tab_clienti.mese_es_2 = 0
if isnull(kst_tab_clienti.fattura) then kst_tab_clienti.fattura = " "
if isnull(kst_tab_clienti.indi_2) then kst_tab_clienti.indi_2  = " "
if isnull(kst_tab_clienti.cap_2 ) then kst_tab_clienti.cap_2 = " "
if isnull(kst_tab_clienti.loc_2) then kst_tab_clienti.loc_2  = " "
if isnull(kst_tab_clienti.prov_2 ) then kst_tab_clienti.prov_2  = " "
if isnull(kst_tab_clienti.spe_inc ) then kst_tab_clienti.spe_inc  = " "
if isnull(kst_tab_clienti.spe_bollo ) then kst_tab_clienti.spe_bollo  = " "
if isnull(kst_tab_clienti.id_clie_settore ) then kst_tab_clienti.id_clie_settore  = " "
if isnull(kst_tab_clienti.id_clie_classe ) then kst_tab_clienti.id_clie_classe  = " "
if isnull(kst_tab_clienti.x_datins) then kst_tab_clienti.x_datins = datetime(0)
if isnull(kst_tab_clienti.x_utente) then kst_tab_clienti.x_utente  = " "
if isnull(kst_tab_clienti.kst_tab_nazioni.nome) then kst_tab_clienti.kst_tab_nazioni.nome  = " "
if isnull(kst_tab_clienti.kst_tab_nazioni.area) then kst_tab_clienti.kst_tab_nazioni.area  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c) then kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c) then kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.indi_c) then kst_tab_clienti.kst_tab_ind_comm.indi_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.cap_c ) then kst_tab_clienti.kst_tab_ind_comm.cap_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.loc_c) then kst_tab_clienti.kst_tab_ind_comm.loc_c  = " "
if isnull(kst_tab_clienti.kst_tab_ind_comm.prov_c) then kst_tab_clienti.kst_tab_ind_comm.prov_c  = " " 
if isnull(kst_tab_clienti.kst_tab_ind_comm.clie_c) then kst_tab_clienti.kst_tab_ind_comm.clie_c = 0
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.id_cliente) then kst_tab_clienti.kst_tab_clienti_fatt.id_cliente = 0
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da ) then kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = " "
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.note_1 ) then kst_tab_clienti.kst_tab_clienti_fatt.note_1 = " "
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.note_2 ) then kst_tab_clienti.kst_tab_clienti_fatt.note_2 = " "
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.x_datins) then kst_tab_clienti.kst_tab_clienti_fatt.x_datins = datetime(0)
if isnull(kst_tab_clienti.kst_tab_clienti_fatt.x_utente) then kst_tab_clienti.kst_tab_clienti_fatt.x_utente  = " "

if isnull(kst_tab_clienti.kst_tab_clienti_mkt.id_cliente ) then kst_tab_clienti.kst_tab_clienti_mkt.id_cliente = 0
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
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.x_datins) then kst_tab_clienti.kst_tab_clienti_mkt.x_datins = datetime(0)
if isnull(kst_tab_clienti.kst_tab_clienti_mkt.x_utente  ) then kst_tab_clienti.kst_tab_clienti_mkt.x_utente = ""

if isnull(kst_tab_clienti.kst_tab_clienti_web.id_cliente  ) then kst_tab_clienti.kst_tab_clienti_web.id_cliente = 0
if isnull(kst_tab_clienti.kst_tab_clienti_web.blog_web  ) then kst_tab_clienti.kst_tab_clienti_web.blog_web = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.blog_web1  ) then kst_tab_clienti.kst_tab_clienti_web.blog_web1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email  ) then kst_tab_clienti.kst_tab_clienti_web.email = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email1  ) then kst_tab_clienti.kst_tab_clienti_web.email1 = ""
if isnull(kst_tab_clienti.kst_tab_clienti_web.email2  ) then kst_tab_clienti.kst_tab_clienti_web.email2 = ""
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

k_piva = trim(kst_tab_clienti.p_iva)


//--- se terzo carattere ALFANUMERICO si presuppone che sia un Codice Fiscale quindi salta controllo
if isnumber(MidA(k_piva,3,1)) then
	
	if LenA(k_piva) <> 11 then
		
		kst_esito.esito = kkg_esito_err_formale
		kst_esito.SQLErrText = "P. IVA  " + k_piva +" errata, deve essere di 11 caratteri numerici"
	
	else
		if not isnumber(k_piva) then
		
			kst_esito.esito = kkg_esito_err_formale
			kst_esito.SQLErrText = "P. IVA " + k_piva +" errata, deve essere composta solo da numeri"
	
	
		end if
	end if
	
	if kst_esito.esito = kkg_esito_ok then
	
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
			kst_esito.esito = kkg_esito_err_formale
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


kst_esito.esito = kkg_esito_ok
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
		  CLIENTI.id_nazione_1
    INTO 
	 	  :kst_tab_clienti.rag_soc_10,   
           :kst_tab_clienti.rag_soc_11,   
		  :kst_tab_clienti.indi_1,   
           :kst_tab_clienti.cap_1,   
           :kst_tab_clienti.loc_1,   
           :kst_tab_clienti.prov_1,   
		  :kst_tab_clienti.id_nazione_1

        FROM clienti
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_clienti.codice > 0 then

		kdw_anteprima.dataobject = "d_clienti_1"		
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


kst_esito.esito = kkg_esito_ok
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
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		
		if_isnull(kst_tab_clienti)  // toglie i null
		
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
			k_campo[k_ind] = "Telefono/fax"
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

				kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
 
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
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(string(kst_tab_clienti.fono)) &
			                + "  /  " + trim(string(kst_tab_clienti.fax)) &
								 )
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
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_pic_open, k_pic_close
string k_tipo_oggetto_padre
string k_oggetto_corrente, k_tipo_oggetto_figlio
string k_alfa
integer k_ctr
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_clienti kst_tab_clienti
//st_tab_pagam kst_tab_pagam
//st_tab_iva kst_tab_iva
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem


declare kc_treeview cursor for
  SELECT   clienti.codice ,
           clienti.rag_soc_10,
           clienti.rag_soc_11,
           clienti.indi_1,
           clienti.cap_1 ,
           clienti.loc_1,
           clienti.prov_1 ,
           clienti.zona ,
           clienti.p_iva ,
           clienti.fono,
           clienti.fax, 
           clienti.cod_pag, 
           clienti.banca, 
           clienti.abi, 
           clienti.cab, 
           clienti.tipo_banca, 
           clienti.iva 
//			  pagam.des,
//			  iva.des
        FROM clienti 
//		  left outer join pagam on
//              clienti.cod_pag = pagam.codice
//				         left outer join iva on
//				  clienti.iva     = iva.codice
        WHERE clienti.rag_soc_10 like :k_alfa   
		        or (:k_alfa = '-' AND  (clienti.rag_soc_10 is null or clienti.rag_soc_10 = ' ') ) 
		  order by clienti.rag_soc_10
		  using sqlca;


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
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					:kst_tab_clienti.codice,
					:kst_tab_clienti.rag_soc_10,
					:kst_tab_clienti.rag_soc_11,
					:kst_tab_clienti.indi_1,
					:kst_tab_clienti.cap_1,
					:kst_tab_clienti.loc_1,   
					:kst_tab_clienti.prov_1,   
					:kst_tab_clienti.zona,
					:kst_tab_clienti.p_iva,
					:kst_tab_clienti.fono,
					:kst_tab_clienti.fax,
					:kst_tab_clienti.cod_pag, 
					:kst_tab_clienti.banca,
					:kst_tab_clienti.abi,
					:kst_tab_clienti.cab,
					:kst_tab_clienti.tipo_banca,
					:kst_tab_clienti.iva
//					:kst_tab_pagam.des,
//					:kst_tab_iva.des
					  ;
	
	
			do while sqlca.sqlcode = 0
				
				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.struttura = kst_treeview_data_any

//			   klvi_listviewitem.data = kst_treeview_data

				if isnull(kst_tab_clienti.rag_soc_10) then
					kst_tab_clienti.rag_soc_10 = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_11) then
					kst_tab_clienti.rag_soc_11 = " "
				end if
				if isnull(kst_tab_clienti.indi_1) then
					kst_tab_clienti.indi_1 = " "
				end if
				if isnull(kst_tab_clienti.cap_1) then
					kst_tab_clienti.cap_1 = " "
				end if
				if isnull(kst_tab_clienti.loc_1) then
					kst_tab_clienti.loc_1 = " "
				end if
				if isnull(kst_tab_clienti.prov_1) then
					kst_tab_clienti.prov_1 = " "
				end if
				if isnull(kst_tab_clienti.fono) then
					kst_tab_clienti.fono = " "
				end if
				if isnull(kst_tab_clienti.fax) then
					kst_tab_clienti.fax = " "
				end if
				if isnull(kst_tab_clienti.p_iva) then
					kst_tab_clienti.p_iva = " "
				end if
				if isnull(kst_tab_clienti.cod_pag) then
					kst_tab_clienti.cod_pag = 0
				end if
				if isnull(kst_tab_clienti.zona) then
					kst_tab_clienti.zona = "0"
				end if
				if isnull(kst_tab_clienti.iva) then
					kst_tab_clienti.iva = 0
				end if
				if isnull(kst_tab_clienti.tipo_banca) then
					kst_tab_clienti.tipo_banca = " "
				end if
				if isnull(kst_tab_clienti.banca) then
					kst_tab_clienti.banca = " "
				end if
				if isnull(kst_tab_clienti.abi) then
					kst_tab_clienti.abi = 0
				end if
				if isnull(kst_tab_clienti.cab) then
					kst_tab_clienti.cab = 0
				end if
//				if isnull(kst_tab_pagam.des) then
//					kst_tab_pagam.des = " "
//				end if
//				if isnull(kst_tab_iva.des) then
//					kst_tab_iva.des = " "
//				end if
		
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

				fetch kc_treeview 
					into
					:kst_tab_clienti.codice,
					:kst_tab_clienti.rag_soc_10,
					:kst_tab_clienti.rag_soc_11,
					:kst_tab_clienti.indi_1,
					:kst_tab_clienti.cap_1,
					:kst_tab_clienti.loc_1,   
					:kst_tab_clienti.prov_1,   
					:kst_tab_clienti.zona,
					:kst_tab_clienti.p_iva,
					:kst_tab_clienti.fono,
					:kst_tab_clienti.fax,
					:kst_tab_clienti.cod_pag, 
					:kst_tab_clienti.banca,
					:kst_tab_clienti.abi,
					:kst_tab_clienti.cab,
					:kst_tab_clienti.tipo_banca,
					:kst_tab_clienti.iva
//					:kst_tab_pagam.des,
//					:kst_tab_iva.des
					  ;
	
	
			loop
			
			close kc_treeview;
		end if
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
         substr(clienti.rag_soc_10, 1, 1) as alfa
     FROM clienti
		 group by  2
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


kst_esito.esito = kkg_esito_ok
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
	kst_esito.esito =  kkg_esito_err_formale
	kst_esito.sqlerrtext = "Codice Fiscale non corretto " 
else
// --- Response.write "CodiceFiscale: " & Risultato
	kst_esito.esito = kkg_esito_ok

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


kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito =  kkg_esito_err_formale
			kst_esito.sqlerrtext = "Numero caratteri Codice Fiscale non corretto (" + string (len(trim(kst_tab_clienti.cf))) + ").  "
		end if
	end if
else
	kst_esito.esito =  kkg_esito_err_formale
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


kst_esito.esito = kkg_esito_ok
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
				kst_esito.esito =  kkg_esito_err_formale
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
						kst_esito.esito =  kkg_esito_err_formale
						kst_esito.sqlerrtext = "Codice Fiscale errato, cod. Ufficio a "+ string (k_uff) +" anomalo per Matricola (" + string (k_matr) + ").  "
					end if
				end if
			else
				k_controlla_cin = true
			end if
		end if
	else
		k_controlla_cin = false
		kst_esito.esito =  kkg_esito_err_formale
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
			kst_esito.esito = kkg_esito_err_formale
			kst_esito.SQLErrText = "Codice Fiscale (CIN) " + k_cf +" errato. "
		end if
	

		
	end if
	
else
	kst_esito.esito =  kkg_esito_err_formale
	kst_esito.sqlerrtext = "Codice Fiscale (non Persona Fisica) "+ k_cf +" errato. "
end if

return kst_esito







end function

public function st_esito leggi (ref st_tab_clienti kst_tab_clienti);//
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()



//	select	
//	      clienti.rag_soc_10,   
//         clienti.rag_soc_11,   
//         clienti.rag_soc_20,   
//         clienti.rag_soc_21,   
//         clienti.indi_1,   
//         clienti.loc_1,   
//         clienti.cap_1,   
//         clienti.prov_1,   
//         clienti.p_iva  
//    INTO :kst_tab_clienti.rag_soc_10,   
//         :kst_tab_clienti.rag_soc_11,   
//         :kst_tab_clienti.rag_soc_20,   
//         :kst_tab_clienti.rag_soc_21,   
//         :kst_tab_clienti.indi_1,   
//         :kst_tab_clienti.loc_1,   
//         :kst_tab_clienti.cap_1,   
//         :kst_tab_clienti.prov_1,   
//         :kst_tab_clienti.p_iva  
//	    FROM clienti  
//   	WHERE clienti.codice =  :kst_tab_clienti.codice  
//		using sqlca;


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
           clienti.mese_es_1, 
           clienti.mese_es_2, 
           clienti.fattura,
           clienti.indi_2,
           clienti.cap_2 ,
           clienti.loc_2,
           clienti.prov_2 ,
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
           ind_comm.clie_c
           ,clienti_fatt.fattura_da
           ,clienti_fatt.note_1
           ,clienti_fatt.note_2
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
           :kst_tab_clienti.mese_es_1, 
           :kst_tab_clienti.mese_es_2, 
           :kst_tab_clienti.fattura,
           :kst_tab_clienti.indi_2,
           :kst_tab_clienti.cap_2 ,
           :kst_tab_clienti.loc_2,
           :kst_tab_clienti.prov_2 ,
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
           :kst_tab_clienti.kst_tab_ind_comm.clie_c
           ,:kst_tab_clienti.kst_tab_clienti_fatt.fattura_da
           ,:kst_tab_clienti.kst_tab_clienti_fatt.note_1
           ,:kst_tab_clienti.kst_tab_clienti_fatt.note_2

        FROM (clienti left outer join ind_comm on clienti.codice = ind_comm.clie_c) 
				  left outer join nazioni on clienti.id_nazione_1 = nazioni.id_nazione     
                   left outer join clienti_fatt on  clienti.codice = clienti_fatt.id_cliente 
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode = 0 then

		if_isnull(kst_tab_clienti)  // toglie i null

//---- Indirizzo Commerciale ricoperto dall'indirizzo Generale se non impostato
		if len(trim(kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c)) = 0 then
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_1_c = kst_tab_clienti.rag_soc_10
			kst_tab_clienti.kst_tab_ind_comm.rag_soc_2_c = kst_tab_clienti.rag_soc_11
			kst_tab_clienti.kst_tab_ind_comm.indi_c = kst_tab_clienti.indi_1
			kst_tab_clienti.kst_tab_ind_comm.cap_c = kst_tab_clienti.cap_1 
			kst_tab_clienti.kst_tab_ind_comm.loc_c = kst_tab_clienti.loc_1
			kst_tab_clienti.kst_tab_ind_comm.prov_c = kst_tab_clienti.prov_1
			kst_tab_clienti.kst_tab_ind_comm.clie_c = kst_tab_clienti.codice
		end if		
//--- Fattura da se non indicato....
		if len(trim(kst_tab_clienti.kst_tab_clienti_fatt.fattura_da)) = 0 then
			kst_tab_clienti.kst_tab_clienti_fatt.fattura_da = kki_fattura_da_bolla
		end if
		
	else
		
	
		if sqlca.sqlcode = 100 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab. Anagrafica:" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode >= 0 then
				if isnull(kst_tab_clienti.iva) then kst_tab_clienti.iva = 0
				if isnull(kst_tab_clienti.iva_esente_imp_max) then kst_tab_clienti.iva_esente_imp_max = 0 
				if isnull(kst_tab_clienti.iva_valida_dal) then kst_tab_clienti.iva_valida_dal = date(0) 
				if isnull(kst_tab_clienti.iva_valida_al) then kst_tab_clienti.iva_valida_al = date(0) 
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab. Anagrafiche:" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito_db_ko
			end if
			
		end if
	
		
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



	kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito_ok
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



	kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito_ok
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



	kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito_ok
	end if




return kst_esito




end function

public function st_esito get_tipo (ref st_tab_clienti kst_tab_clienti);//--- 
//--- Identifica il TIPO ANAGRAFE ovvero se Cliente/Mandante/Ricevente o multitipo
//---
integer k_conta_clie_1=0, k_conta_clie_2=0, k_conta_clie_3=0
st_esito kst_esito



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.tipo_mrf = " "
	
	if kst_tab_clienti.codice > 0 then
		
		select count(*) 
			into :k_conta_clie_3
			from m_r_f
			where clie_3 = :kst_tab_clienti.codice  ;
		
		if sqlca.sqlcode < 0 then
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
				
		else
			
			select count(*) 
				into :k_conta_clie_1
				from m_r_f
				where clie_1 = :kst_tab_clienti.codice  ;
			
			if sqlca.sqlcode < 0 then
				
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo):" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito_db_ko

			else
				
				select count(*) 
					into :k_conta_clie_2
					from m_r_f
					where clie_2 = :kst_tab_clienti.codice  ;
				
				if sqlca.sqlcode < 0 then
					
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Tab.Clienti (ricerca del tipo):" + trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito_db_ko

				else
	
					if k_conta_clie_1 > 0 and  k_conta_clie_2 > 0 and  k_conta_clie_3 > 0 then
						kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_MAN_RIC
					else
						if k_conta_clie_1 > 0 then
							kst_tab_clienti.tipo_mrf = kki_tipo_mrf_MANDANTE
							if k_conta_clie_2 > 0 then
								kst_tab_clienti.tipo_mrf = kki_tipo_mrf_MAN_RIC
							else
								if k_conta_clie_3 > 0 then
									kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_MAN
								end if
							end if
						else
							if k_conta_clie_2 > 0 then
								kst_tab_clienti.tipo_mrf = kki_tipo_mrf_RICEVENTE
								if k_conta_clie_3 > 0 then
									kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATT_RIC
								end if
							else
								if k_conta_clie_3 > 0 then
									kst_tab_clienti.tipo_mrf = kki_tipo_mrf_FATTURATO
								else
									kst_tab_clienti.tipo_mrf = kki_tipo_mrf_NESSUNO
								end if
							end if
						end if
					end if
				end if
			end if
		end if
		
		
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

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_fatt.id_cliente > 0 then
	
	kst_tab_clienti_fatt.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_clienti_fatt.x_utente = kuf1_data_base.prendi_x_utente()

	if isnull(kst_tab_clienti_fatt.fattura_da) then
		kst_tab_clienti_fatt.fattura_da = kki_fattura_da_bolla
	end if
	if isnull(kst_tab_clienti_fatt.note_1) then
		kst_tab_clienti_fatt.note_1 = " "
	end if
	if isnull(kst_tab_clienti_fatt.note_2) then
		kst_tab_clienti_fatt.note_2 = " "
	end if
	
	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Fatturazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito_no_aut
	
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
							  x_datins,   
							  x_utente )  
					  VALUES ( :kst_tab_clienti_fatt.id_cliente,   
							  :kst_tab_clienti_fatt.fattura_da,   
							  :kst_tab_clienti_fatt.note_1,   
							  :kst_tab_clienti_fatt.note_2,   
							  :kst_tab_clienti_fatt.x_datins,   
							  :kst_tab_clienti_fatt.x_utente )  
					using sqlca;
			end if
			
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati Fatturazione:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Fatturazione: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
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



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_fatt.id_cliente > 0 then
	
	kst_tab_clienti_fatt.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_clienti_fatt.x_utente = kuf1_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
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
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_fatt.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Fatturazione: nessun dato cancellato (codice cliente non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
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



kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
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
			kuf1_data_base.db_commit_1( )
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



kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_rc then

	k_return = "1" + "Cancellazione Associazione mandante-ricevente-cliente non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"

else


	delete from m_r_f
			where    clie_1 = :kst_tab_clienti_m_r_f.clie_1
			     and clie_2 = :kst_tab_clienti_m_r_f.clie_2
			     and clie_3 = :kst_tab_clienti_m_r_f.clie_3;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText

	else
		
		if kst_tab_clienti_m_r_f.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_m_r_f.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_commit_1( )
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



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_clienti.contati = 0
	
   SELECT   max(clienti.codice)
       into :kst_tab_clienti.codice
		 FROM clienti
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito_db_ko
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

kst_esito.esito = kkg_esito_ok
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
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
		
	end if

	if_isnull(kst_tab_clienti)  // toglie i null

	

return kst_esito

end function

public function st_esito esenzione_iva_controllo_fattura (ref st_clienti_esenzione_iva kst_clienti_esenzione_iva);//------------------------------------------------------------------------------------------
//--- Controlla se cliente e' ESENTE IVA
//---  parametri:  codice cliente 
//---              data fattura
//---              importo e IVA della riga fattura ancora da inserire
//---  ritorna:   st_esito: STANDARD
//--- 				st_clienti_esenzione_iva: esito 0=ESENTE,1=NO Esente,2=esenzione scaduta,3=superato importo max
//---    			            		iva_valida_dal e iva_valida_al=periodo esente, 
//---             				   	iva_esente_imp_max=importo esente, importo=tot fatturato con esenzione 
//------------------------------------------------------------------------------------------
//
//
double k_tot_fatture=0, k_tot_nc=0
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kst_clienti_esenzione_iva.esito = "0"

	select iva, iva_valida_dal, iva_valida_al, iva_esente_imp_max
	       into :kst_clienti_esenzione_iva.iva
			 , :kst_clienti_esenzione_iva.iva_valida_dal 
			 , :kst_clienti_esenzione_iva.iva_valida_al 
			 , :kst_clienti_esenzione_iva.iva_esente_imp_max
	       from clienti 
	       where clienti.codice = :kst_clienti_esenzione_iva.id_cliente
			using sqlca;
	       
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cliente non Trovato: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = KKG_ESITO_db_wrn
		else
			kst_esito.esito = KKG_ESITO_db_ko
		end if

	else
	
		if kst_clienti_esenzione_iva.iva > 0 then
		
			if kst_clienti_esenzione_iva.iva_valida_dal > kst_clienti_esenzione_iva.data_fatt &
					and kst_clienti_esenzione_iva.iva_valida_dal > date(0) &
					and not isnull(kst_clienti_esenzione_iva.iva_valida_dal) then

//--- nessuna esenzione
			   kst_clienti_esenzione_iva.esito = "1"
			   kst_esito.esito = "Esenzione valida dal: " + string(kst_clienti_esenzione_iva.iva_valida_dal)
			
			else
				
				if kst_clienti_esenzione_iva.iva_valida_al < kst_clienti_esenzione_iva.data_fatt &
						and kst_clienti_esenzione_iva.iva_valida_al > date(0) &
						and not isnull(kst_clienti_esenzione_iva.iva_valida_al) then
				   kst_clienti_esenzione_iva.esito = "2"
				   kst_esito.sqlerrtext = "Esenzione scaduta il: "+  string(kst_clienti_esenzione_iva.iva_valida_al)
				else

					if kst_clienti_esenzione_iva.iva_valida_al > date(0) and kst_clienti_esenzione_iva.importo > 0 then
						
//--- controllo l'importo
						select sum(prezzo_t)
							 into :k_tot_fatture
							 from arfa
							 where clie_3 = :kst_clienti_esenzione_iva.id_cliente 
									 and iva = :kst_clienti_esenzione_iva.iva
									 and data_fatt between :kst_clienti_esenzione_iva.iva_valida_dal and :kst_clienti_esenzione_iva.iva_valida_al
									 and arfa.tipo_doc = 'FT'
							using sqlca;
	
						if sqlca.sqlcode = 0 then
	
							if k_tot_fatture > 0 then
								kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo_t + k_tot_fatture
							end if
	
							select sum(prezzo_t)
								 into :k_tot_nc
								 from arfa
								 where clie_3 = :kst_clienti_esenzione_iva.id_cliente 
										 and iva = :kst_clienti_esenzione_iva.iva
										 and data_fatt between :kst_clienti_esenzione_iva.iva_valida_dal and :kst_clienti_esenzione_iva.iva_valida_al
										 and arfa.tipo_doc = 'NC'
								using sqlca;
	
							if sqlca.sqlcode = 0 then
								if k_tot_nc > 0 then
									kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo - k_tot_nc
								end if	
							else
								if sqlca.sqlcode < 0 then
									kst_esito.sqlcode = sqlca.sqlcode
									kst_esito.SQLErrText = "Lettura N.Credito Fallita, cliente: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
									kst_esito.esito = KKG_ESITO_db_ko
								end if
							end if
						else
							if sqlca.sqlcode < 0 then
								kst_esito.sqlcode = sqlca.sqlcode
								kst_esito.SQLErrText = "Lettura Fatture Fallita, cliente: " + string(kst_clienti_esenzione_iva.id_cliente) +" ~n~r"+ trim(sqlca.SQLErrText)
								kst_esito.esito = KKG_ESITO_db_ko
							else
								kst_clienti_esenzione_iva.importo = kst_clienti_esenzione_iva.importo_t 
							end if
						end if
	
						if kst_clienti_esenzione_iva.importo > kst_clienti_esenzione_iva.iva_esente_imp_max and kst_clienti_esenzione_iva.iva_esente_imp_max > 0 then
	
	//--- superato importo esente
							kst_clienti_esenzione_iva.esito = "3"
								kst_esito.sqlerrtext = "Imp.Esenz.superato €:"+ string(kst_clienti_esenzione_iva.importo)
	
						end if
					end if
				end if
			end if
		
		else
//--- nessuna esenzione
			kst_clienti_esenzione_iva.esito = "1"
			kst_esito.sqlerrtext = "Nessuna Esenzione cliente: "+ string(kst_clienti_esenzione_iva.id_cliente)
		end if

	end if


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


kst_esito.esito = kkg_esito_ok
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
		if isnull(kst_tab_clienti.p_iva) then kst_tab_clienti.p_iva = " " 
		if isnull(kst_tab_clienti.cf) then kst_tab_clienti.cf = " " 
				
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
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

kst_esito.esito = kkg_esito_ok
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
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
		  CLIENTI.IVA
           ,clienti.iva_esente_imp_max
           ,clienti.iva_valida_dal
           ,clienti.iva_valida_al
    INTO 
           :kst_tab_clienti.iva 
           ,:kst_tab_clienti.iva_esente_imp_max
           ,:kst_tab_clienti.iva_valida_dal
           ,:kst_tab_clienti.iva_valida_al
        FROM clienti 
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_not_fnd
	else
		if sqlca.sqlcode >= 0 then
			if isnull(kst_tab_clienti.iva) then kst_tab_clienti.iva = 0
			if isnull(kst_tab_clienti.iva_esente_imp_max) then kst_tab_clienti.iva_esente_imp_max = 0 
			if isnull(kst_tab_clienti.iva_valida_dal) then kst_tab_clienti.iva_valida_dal = date(0) 
			if isnull(kst_tab_clienti.iva_valida_al) then kst_tab_clienti.iva_valida_al = date(0) 
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
		end if
		
	end if


return kst_esito

end function

public function boolean link_call (ref uo_d_std_1 kdw_1, string k_campo_link) throws uo_exception;//
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
st_tab_clienti kst_tab_clienti
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case k_campo_link

	case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente" 
		kst_tab_clienti.codice = kdw_1.getitemnumber(kdw_1.getrow(), k_campo_link)
		if kst_tab_clienti.codice > 0 then
			kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_clienti )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Anagrafica  (codice=" + trim(string(kst_tab_clienti.codice)) + ") " 
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
		kst_open_w.id_programma =kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
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



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM clienti
		 where id_clie_settore = :kst_tab_clienti.id_clie_settore
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito_db_ko
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



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM clienti
		 where id_clie_classe = :kst_tab_clienti.id_clie_classe
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito_db_ko
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


kst_esito.esito = kkg_esito_ok
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
           :kst_tab_clienti.kst_tab_ind_comm.clie_c

        FROM (clienti left outer join ind_comm on
              clienti.codice = ind_comm.clie_c)   left outer join nazioni on   
              clienti.id_nazione_1 = nazioni.id_nazione     
        WHERE ( clienti.codice = :kst_tab_clienti.codice   )   
		using sqlca;


	if sqlca.sqlcode = 0 then
		
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
		end if		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Anagrafiche:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
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



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_mkt.id_cliente > 0 then
	
	kst_tab_clienti_mkt.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_clienti_mkt.x_utente = kuf1_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
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
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Marketing: nessun dato cancellato (codice Anagrafica non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
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



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_web.id_cliente > 0 then
	
	kst_tab_clienti_web.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_clienti_web.x_utente = kuf1_data_base.prendi_x_utente()

	kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
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
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati 'Web': nessun dato cancellato (codice Anagrafica non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_mkt.id_cliente > 0 then

	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Fatturazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito_no_aut
	
	else

		
		kst_tab_clienti_mkt.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_clienti_mkt.x_utente = kuf1_data_base.prendi_x_utente()
	
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
			if kst_tab_clienti.kst_tab_clienti_mkt.altra_sede <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_mkt.cod_atecori  <> "" & 
			      or kst_tab_clienti.kst_tab_clienti_mkt.contatto_1_qualif  <> "" & 
			      or kst_tab_clienti.kst_tab_clienti_mkt.contatto_2_qualif  <> "" &
			      or kst_tab_clienti.kst_tab_clienti_mkt.contatto_3_qualif <> "" &
			      or kst_tab_clienti.kst_tab_clienti_mkt.contatto_4_qualif  <> "" &
			      or kst_tab_clienti.kst_tab_clienti_mkt.contatto_5_qualif  <> "" &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_1 <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_2 <> 0  &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_3  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_4  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_contatto_5  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.id_cliente_link  <> 0 &
			      or kst_tab_clienti.kst_tab_clienti_mkt.note_attivita <> "" &
			      or kst_tab_clienti.kst_tab_clienti_mkt.note_prodotti <> "" & 
			      or kst_tab_clienti.kst_tab_clienti_mkt.qualifica  <> "" then
			
				k_senza_dati = true
			else
				k_senza_dati = false
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
							,x_datins 
							,x_utente 
							 )  
					  VALUES ( 
						 :kst_tab_clienti_mkt.id_cliente 
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
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_mkt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_mkt.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Marketing: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if kst_tab_clienti_web.id_cliente > 0 then

	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
	kst_open_w.id_programma = kkg_id_programma_anag
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica dati Web non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito_no_aut
	
	else

		
		kst_tab_clienti_web.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_clienti_web.x_utente = kuf1_data_base.prendi_x_utente()
	
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
			if kst_tab_clienti.kst_tab_clienti_web.blog_web <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.blog_web1  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.email  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.email1  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.email2  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.note  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.sito_web  <> "" & 
				  or kst_tab_clienti.kst_tab_clienti_web.sito_web1  <> "" & 
			       then
			
				k_senza_dati = true
			else
				k_senza_dati = false
			end if
			
			
			if k_rcn > 0 then
				UPDATE clienti_web  
				  SET 
						blog_web = :kst_tab_clienti_web.blog_web 
						,blog_web1 = :kst_tab_clienti_web.blog_web1 
						,email = :kst_tab_clienti_web.email 
						,email1 = :kst_tab_clienti_web.email1 
						,email2 = :kst_tab_clienti_web.email2 
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
				kst_esito.esito = kkg_esito_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito_db_wrn
				else
					kst_esito.esito = kkg_esito_db_ko
				end if
			end if
		else
			if kst_tab_clienti_web.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clienti_web.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati Web: nessun dato inserito (codice cliente non impostato) "
	kst_esito.esito = kkg_esito_no_esecuzione
end if


return kst_esito

end function

on kuf_clienti.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_clienti.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

