$PBExportHeader$kuf_m2000tocrm.sru
forward
global type kuf_m2000tocrm from kuf_parent
end type
end forward

global type kuf_m2000tocrm from kuf_parent
end type
global kuf_m2000tocrm kuf_m2000tocrm

type variables
//
private kuo_sqlca_db_crm  kiuo_sqlca_db_crm

end variables

forward prototypes
public function long u_m2000_to_crm_art () throws uo_exception
public function long u_m2000_to_crm_clie_classi () throws uo_exception
public function long u_m2000_to_crm_clie_settori () throws uo_exception
public function long u_m2000_to_crm_clienti () throws uo_exception
public function long u_m2000_to_crm_contratti () throws uo_exception
public function long u_m2000_to_crm_clienti_contatti () throws uo_exception
public function long u_m2000_to_crm_gruppi () throws uo_exception
public function long u_m2000_to_crm_sl_pt () throws uo_exception
public function long u_m2000_to_crm_confermaordine () throws uo_exception
public function long u_m2000_to_crm_listino () throws uo_exception
public function long u_m2000_to_crm_cntr_tot_mese () throws uo_exception
public function long u_m2000_to_crm_previsioni () throws uo_exception
end prototypes

public function long u_m2000_to_crm_art () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_art, kds_crmtab_crm_art

try
	
	kds_crm_art = create datastore 
	kds_crm_art.dataobject = "ds_crm_art" 
	kds_crm_art.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_art = create datastore
	kds_crmtab_crm_art.dataobject = "ds_crmtab_crm_art"
	kds_crmtab_crm_art.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_art")
//	kds_crmtab_crm_art.retrieve( )
//	for k_riga =kds_crmtab_crm_art.rowcount( ) to 1 step -1
//		kds_crmtab_crm_art.deleterow(k_riga)
//	next
//	kds_crmtab_crm_art.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_art.retrieve()
	if kds_crm_art.rowcount( ) > 0 then
		kds_crm_art.rowscopy( 1, kds_crm_art.rowcount( ), primary!, kds_crmtab_crm_art, 1, primary!)
		k_rc = kds_crmtab_crm_art.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_art.rowcount()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_clie_classi () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_clie_classi, kds_crmtab_crm_clie_classi

try
	
	kds_crm_clie_classi = create datastore 
	kds_crm_clie_classi.dataobject = "ds_crm_clie_classi" 
	kds_crm_clie_classi.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_clie_classi = create datastore
	kds_crmtab_crm_clie_classi.dataobject = "ds_crmtab_crm_clie_classi"
	kds_crmtab_crm_clie_classi.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_clie_classi")
//	kds_crmtab_crm_clie_classi.retrieve( )
//	for k_riga =kds_crmtab_crm_clie_classi.rowcount( ) to 1 step -1
//		kds_crmtab_crm_clie_classi.deleterow(k_riga)
//	next
//	kds_crmtab_crm_clie_classi.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_clie_classi.retrieve()
	if kds_crm_clie_classi.rowcount( ) > 0 then
		kds_crm_clie_classi.rowscopy( 1, kds_crm_clie_classi.rowcount( ), primary!, kds_crmtab_crm_clie_classi, 1, primary!)
		k_rc = kds_crmtab_crm_clie_classi.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_clie_classi.rowcount()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_clie_settori () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_clie_settori, kds_crmtab_crm_clie_settori

try
	
	kds_crm_clie_settori = create datastore 
	kds_crm_clie_settori.dataobject = "ds_crm_clie_settori" 
	kds_crm_clie_settori.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_clie_settori = create datastore
	kds_crmtab_crm_clie_settori.dataobject = "ds_crmtab_crm_clie_settori"
	kds_crmtab_crm_clie_settori.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_clie_settori")
//	kds_crmtab_crm_clie_settori.retrieve( )
//	for k_riga =kds_crmtab_crm_clie_settori.rowcount( ) to 1 step -1
//		kds_crmtab_crm_clie_settori.deleterow(k_riga)
//	next
//	kds_crmtab_crm_clie_settori.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_clie_settori.retrieve()
	if kds_crm_clie_settori.rowcount( ) > 0 then
		kds_crm_clie_settori.rowscopy( 1, kds_crm_clie_settori.rowcount( ), primary!, kds_crmtab_crm_clie_settori, 1, primary!)
		k_rc = kds_crmtab_crm_clie_settori.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_clie_settori.rowcount()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_clienti () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe= 0
int k_rc=0
datastore kds_crm_clienti, kds_crmtab_crm_clienti

try
	
	kds_crm_clienti = create datastore 
	kds_crm_clienti.dataobject = "ds_crm_clienti" 
	kds_crm_clienti.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_clienti = create datastore
	kds_crmtab_crm_clienti.dataobject = "ds_crmtab_crm_clienti"
	kds_crmtab_crm_clienti.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_anagrafe")
//	kds_crmtab_crm_clienti.retrieve( )
//	for k_riga =kds_crmtab_crm_clienti.rowcount( ) to 1 step -1
//		kds_crmtab_crm_clienti.deleterow(k_riga)
//	next
//	kds_crmtab_crm_clienti.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_clienti.retrieve()
	k_righe = kds_crm_clienti.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_rc = kds_crmtab_crm_clienti.insertrow(k_riga)
			kds_crmtab_crm_clienti.object.id_cliente[k_riga] = kds_crm_clienti.object.id_cliente[k_riga]
			kds_crmtab_crm_clienti.object.tipo[k_riga] = kds_crm_clienti.object.tipo[k_riga]
			kds_crmtab_crm_clienti.object.tipo_descr[k_riga] = trim(kds_crm_clienti.object.tipo_descr[k_riga])
			kds_crmtab_crm_clienti.object.stato[k_riga] = kds_crm_clienti.object.stato[k_riga]
			kds_crmtab_crm_clienti.object.stato_descr[k_riga] = trim(kds_crm_clienti.object.stato_descr[k_riga])
			kds_crmtab_crm_clienti.object.data_attivazione[k_riga] = kds_crm_clienti.object.data_attivazione[k_riga]
			kds_crmtab_crm_clienti.object.id_clie_settore[k_riga] = kds_crm_clienti.object.id_clie_settore[k_riga]
			kds_crmtab_crm_clienti.object.settore_descrizione[k_riga] = trim(kds_crm_clienti.object.settore_descrizione[k_riga])
			kds_crmtab_crm_clienti.object.id_clie_classe[k_riga] = kds_crm_clienti.object.id_clie_classe[k_riga]
			kds_crmtab_crm_clienti.object.classe_descr[k_riga] = trim(kds_crm_clienti.object.classe_descr[k_riga])
			kds_crmtab_crm_clienti.object.sede_rag_soc[k_riga] = trim(kds_crm_clienti.object.sede_rag_soc[k_riga])
			kds_crmtab_crm_clienti.object.sede_indi[k_riga] = trim(kds_crm_clienti.object.sede_indi[k_riga])
			kds_crmtab_crm_clienti.object.sede_cap[k_riga] = trim(kds_crm_clienti.object.sede_cap[k_riga])
			kds_crmtab_crm_clienti.object.sede_loc[k_riga] = trim(kds_crm_clienti.object.sede_loc[k_riga])
			kds_crmtab_crm_clienti.object.sede_prov[k_riga] = kds_crm_clienti.object.sede_prov[k_riga]
			kds_crmtab_crm_clienti.object.sede_zona[k_riga] = kds_crm_clienti.object.sede_zona[k_riga]
			kds_crmtab_crm_clienti.object.sede_nazione[k_riga] = trim(kds_crm_clienti.object.sede_nazione[k_riga])
			kds_crmtab_crm_clienti.object.nazione_nome[k_riga] = kds_crm_clienti.object.nazione_nome[k_riga]
			kds_crmtab_crm_clienti.object.nazione_area[k_riga] = trim(kds_crm_clienti.object.nazione_area[k_riga])
			kds_crmtab_crm_clienti.object.partitaiva[k_riga] = trim(kds_crm_clienti.object.partitaiva[k_riga])
			kds_crmtab_crm_clienti.object.codicefiscale[k_riga] = trim(kds_crm_clienti.object.codicefiscale[k_riga])
			kds_crmtab_crm_clienti.object.telefono[k_riga] = trim(kds_crm_clienti.object.telefono[k_riga])
			kds_crmtab_crm_clienti.object.fax[k_riga] = trim(kds_crm_clienti.object.fax[k_riga])
			kds_crmtab_crm_clienti.object.codice_pagamento[k_riga] = kds_crm_clienti.object.codice_pagamento[k_riga]
			kds_crmtab_crm_clienti.object.pagamento_descr[k_riga] = trim(kds_crm_clienti.object.pagamento_descr[k_riga])
			kds_crmtab_crm_clienti.object.banca[k_riga] = trim(kds_crm_clienti.object.banca[k_riga])
			kds_crmtab_crm_clienti.object.abi[k_riga] = kds_crm_clienti.object.abi[k_riga]
			kds_crmtab_crm_clienti.object.cab[k_riga] = kds_crm_clienti.object.cab[k_riga]
			kds_crmtab_crm_clienti.object.esente_iva[k_riga] = kds_crm_clienti.object.esente_iva[k_riga]
			kds_crmtab_crm_clienti.object.esente_iva_descr[k_riga] = kds_crm_clienti.object.esente_iva_descr[k_riga]
			kds_crmtab_crm_clienti.object.esente_dal[k_riga] = kds_crm_clienti.object.esente_dal[k_riga]
			kds_crmtab_crm_clienti.object.esente_al[k_riga] = kds_crm_clienti.object.esente_al[k_riga]
			kds_crmtab_crm_clienti.object.esente_fino_importo [k_riga] = kds_crm_clienti.object.esente_fino_importo[k_riga]
			kds_crmtab_crm_clienti.object.esente_importo_minimo[k_riga] = kds_crm_clienti.object.esente_importo_minimo[k_riga]
			kds_crmtab_crm_clienti.object.escludi_scadenza_mese_1[k_riga] = kds_crm_clienti.object.escludi_scadenza_mese_1[k_riga]
			kds_crmtab_crm_clienti.object.escludi_scadenza_mese_2[k_riga] = kds_crm_clienti.object.escludi_scadenza_mese_2[k_riga]
			kds_crmtab_crm_clienti.object.cadenza_fatturazione[k_riga] = kds_crm_clienti.object.cadenza_fatturazione[k_riga]
			kds_crmtab_crm_clienti.object.ddt_rag_soc[k_riga] = kds_crm_clienti.object.ddt_rag_soc[k_riga]
			kds_crmtab_crm_clienti.object.ddt_indi[k_riga] = trim(kds_crm_clienti.object.ddt_indi[k_riga])
			kds_crmtab_crm_clienti.object.ddt_cap[k_riga] = kds_crm_clienti.object.ddt_cap[k_riga]
			kds_crmtab_crm_clienti.object.ddt_loc[k_riga] = trim(kds_crm_clienti.object.ddt_loc[k_riga])
			kds_crmtab_crm_clienti.object.ddt_prov[k_riga] = kds_crm_clienti.object.ddt_prov[k_riga]
			kds_crmtab_crm_clienti.object.fatt_rag_soc[k_riga] = trim(kds_crm_clienti.object.fatt_rag_soc[k_riga])
			kds_crmtab_crm_clienti.object.fatt_indi[k_riga] = trim(kds_crm_clienti.object.fatt_indi[k_riga])
			kds_crmtab_crm_clienti.object.fatt_cap[k_riga] = kds_crm_clienti.object.fatt_cap[k_riga]
			kds_crmtab_crm_clienti.object.fatt_loc[k_riga] = trim(kds_crm_clienti.object.fatt_loc[k_riga])
			kds_crmtab_crm_clienti.object.fatt_prov[k_riga] = kds_crm_clienti.object.fatt_prov[k_riga]
			kds_crmtab_crm_clienti.object.fattura_da[k_riga] = kds_crm_clienti.object.fattura_da[k_riga]
			kds_crmtab_crm_clienti.object.fattura_da_descr[k_riga] = kds_crm_clienti.object.fattura_da_descr[k_riga]
			kds_crmtab_crm_clienti.object.fatt_note[k_riga] = trim(kds_crm_clienti.object.fatt_note[k_riga])
			kds_crmtab_crm_clienti.object.fatt_modo_stampa[k_riga] = kds_crm_clienti.object.fatt_modo_stampa[k_riga]
			kds_crmtab_crm_clienti.object.fatt_modo_stampa_descr[k_riga] = kds_crm_clienti.object.fatt_modo_stampa_descr[k_riga]
			kds_crmtab_crm_clienti.object.fatt_modo_email[k_riga] = kds_crm_clienti.object.fatt_modo_email[k_riga]
			kds_crmtab_crm_clienti.object.fatt_modo_email_descr[k_riga] = kds_crm_clienti.object.fatt_modo_email_descr[k_riga]
			kds_crmtab_crm_clienti.object.fatt_email_invio[k_riga] = kds_crm_clienti.object.fatt_email_invio[k_riga]
			kds_crmtab_crm_clienti.object.fatt_email_invio_descr[k_riga] = kds_crm_clienti.object.fatt_email_invio_descr[k_riga]
			kds_crmtab_crm_clienti.object.causale_entrata_merce[k_riga] = kds_crm_clienti.object.causale_entrata_merce[k_riga]
			kds_crmtab_crm_clienti.object.causale_descrizione_entrata_merce[k_riga] = trim(kds_crm_clienti.object.causale_descrizione_entrata_merce[k_riga])
			kds_crmtab_crm_clienti.object.id_cliente_link[k_riga] = kds_crm_clienti.object.id_cliente_link[k_riga]
			kds_crmtab_crm_clienti.object.qualifica[k_riga] = trim(kds_crm_clienti.object.qualifica[k_riga])
			kds_crmtab_crm_clienti.object.tipo_rapporto[k_riga] = kds_crm_clienti.object.tipo_rapporto[k_riga]
			kds_crmtab_crm_clienti.object.altra_sede[k_riga] = trim(kds_crm_clienti.object.altra_sede[k_riga])
			kds_crmtab_crm_clienti.object.cod_atecori[k_riga] = kds_crm_clienti.object.cod_atecori[k_riga]
			kds_crmtab_crm_clienti.object.note_attivita[k_riga] = kds_crm_clienti.object.note_attivita[k_riga]
			kds_crmtab_crm_clienti.object.note_prodotti[k_riga] = trim(kds_crm_clienti.object.note_prodotti[k_riga])
			kds_crmtab_crm_clienti.object.cod_gruppo_prevalente[k_riga] = kds_crm_clienti.object.cod_gruppo_prevalente[k_riga]
			kds_crmtab_crm_clienti.object.email_1[k_riga] = trim(kds_crm_clienti.object.email_1[k_riga])
			kds_crmtab_crm_clienti.object.email_2[k_riga] = trim(kds_crm_clienti.object.email_2[k_riga])
			kds_crmtab_crm_clienti.object.email_3[k_riga] = trim(kds_crm_clienti.object.email_3[k_riga])
			kds_crmtab_crm_clienti.object.note_web[k_riga] = trim(kds_crm_clienti.object.note_web[k_riga])
			kds_crmtab_crm_clienti.object.sito_web_1[k_riga] = trim(kds_crm_clienti.object.sito_web_1[k_riga])
			kds_crmtab_crm_clienti.object.sito_web_2[k_riga] = trim(kds_crm_clienti.object.sito_web_2[k_riga])
			kds_crmtab_crm_clienti.object.sito_blog_1[k_riga] = trim(kds_crm_clienti.object.sito_blog_1[k_riga])
			kds_crmtab_crm_clienti.object.sito_blog_2[k_riga] = trim(kds_crm_clienti.object.sito_blog_2[k_riga])

		end for
		k_rc = kds_crmtab_crm_clienti.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_clienti.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_contratti () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe= 0, k_riga_in=0
int k_rc=0
datastore kds_crm_contratti, kds_crmtab_crm_contratti

try
	
	kds_crm_contratti = create datastore 
	kds_crm_contratti.dataobject = "ds_crm_contratti" 
	kds_crm_contratti.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_contratti = create datastore
	kds_crmtab_crm_contratti.dataobject = "ds_crmtab_crm_contratti"
	kds_crmtab_crm_contratti.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_contratti")
//	kds_crmtab_crm_contratti.retrieve( )
//	k_righe = kds_crmtab_crm_contratti.rowcount( )
//	for k_riga = k_righe to 1 step -1
//		kds_crmtab_crm_contratti.deleterow(k_riga)
//	next
//	kds_crmtab_crm_contratti.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_contratti.retrieve()
	k_righe = kds_crm_contratti.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_riga_in = kds_crmtab_crm_contratti.insertrow(0)
			kds_crmtab_crm_contratti.object.id_cliente[k_riga_in] = kds_crm_contratti.object.id_cliente[k_riga]
			kds_crmtab_crm_contratti.object.id_contratto[k_riga_in] = kds_crm_contratti.object.id_contratto[k_riga]
			kds_crmtab_crm_contratti.object.tipo_contratto[k_riga_in] = kds_crm_contratti.object.tipo_contratto[k_riga]
			kds_crmtab_crm_contratti.object.id_tipocontratto[k_riga_in] = kds_crm_contratti.object.id_tipocontratto[k_riga]
			kds_crmtab_crm_contratti.object.anno[k_riga_in] = kds_crm_contratti.object.anno[k_riga]
			kds_crmtab_crm_contratti.object.attivo[k_riga_in] = kds_crm_contratti.object.attivo[k_riga]
			kds_crmtab_crm_contratti.object.magazzino[k_riga_in] = kds_crm_contratti.object.magazzino[k_riga]
			kds_crmtab_crm_contratti.object.art[k_riga_in] = kds_crm_contratti.object.art[k_riga]
			kds_crmtab_crm_contratti.object.offerta_data[k_riga_in] = kds_crm_contratti.object.offerta_data[k_riga]
			kds_crmtab_crm_contratti.object.stato[k_riga_in] = kds_crm_contratti.object.stato[k_riga]
			kds_crmtab_crm_contratti.object.data_stampa[k_riga_in] = kds_crm_contratti.object.data_stampa[k_riga]
			kds_crmtab_crm_contratti.object.data_inizio[k_riga_in] = kds_crm_contratti.object.data_inizio[k_riga]
			kds_crmtab_crm_contratti.object.data_fine[k_riga_in] = kds_crm_contratti.object.data_fine[k_riga]
			kds_crmtab_crm_contratti.object.oggetto[k_riga_in] = trim(kds_crm_contratti.object.oggetto[k_riga])
			kds_crmtab_crm_contratti.object.id_clie_settore[k_riga_in] = kds_crm_contratti.object.id_clie_settore[k_riga]
			kds_crmtab_crm_contratti.object.cod_gruppo[k_riga_in] = kds_crm_contratti.object.cod_gruppo[k_riga]
			kds_crmtab_crm_contratti.object.nome_contatto[k_riga_in] = trim(kds_crm_contratti.object.nome_contatto[k_riga])
			kds_crmtab_crm_contratti.object.prezzo[k_riga_in] = kds_crm_contratti.object.prezzo[k_riga]
			kds_crmtab_crm_contratti.object.prezzi[k_riga_in] = trim(kds_crm_contratti.object.prezzi[k_riga])
			kds_crmtab_crm_contratti.object.unita_misura[k_riga_in] = kds_crm_contratti.object.unita_misura[k_riga]
			kds_crmtab_crm_contratti.object.misure_varie[k_riga_in] = trim(kds_crm_contratti.object.misure_varie[k_riga])
			kds_crmtab_crm_contratti.object.note[k_riga_in] = trim(kds_crm_contratti.object.note[k_riga])
			kds_crmtab_crm_contratti.object.contratti_des[k_riga_in] = trim(kds_crm_contratti.object.contratti_des[k_riga])
			kds_crmtab_crm_contratti.object.sk_dose_map_codice[k_riga_in] = trim(kds_crm_contratti.object.sk_dose_map_codice[k_riga])
			kds_crmtab_crm_contratti.object.sk_dose_map_des[k_riga_in] = trim(kds_crm_contratti.object.sk_dose_map_des[k_riga])
			kds_crmtab_crm_contratti.object.altre_condizioni[k_riga_in] = trim(kds_crm_contratti.object.altre_condizioni[k_riga])
			kds_crmtab_crm_contratti.object.consegna_des[k_riga_in] = trim(kds_crm_contratti.object.consegna_des[k_riga])
			kds_crmtab_crm_contratti.object.ritiro_des[k_riga_in] = trim(kds_crm_contratti.object.ritiro_des[k_riga])
			kds_crmtab_crm_contratti.object.note_interne[k_riga_in] = trim(kds_crm_contratti.object.note_interne[k_riga])
		end for
	kds_crmtab_crm_contratti.saveas("c:\ufo\testtocrm.csv", CSV!, true)  // DEBUG
		k_rc = kds_crmtab_crm_contratti.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_contratti.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_clienti_contatti () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_clienti_contatti, kds_crmtab_crm_clienti_contatti

try
	
	kds_crm_clienti_contatti = create datastore 
	kds_crm_clienti_contatti.dataobject = "ds_crm_clienti_contatti" 
	kds_crm_clienti_contatti.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_clienti_contatti = create datastore
	kds_crmtab_crm_clienti_contatti.dataobject = "ds_crmtab_crm_clienti_contatti"
	kds_crmtab_crm_clienti_contatti.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_clienti_contatti")
//	kds_crmtab_crm_clienti_contatti.retrieve( )
//	for k_riga =kds_crmtab_crm_clienti_contatti.rowcount( ) to 1 step -1
//		kds_crmtab_crm_clienti_contatti.deleterow(k_riga)
//	next
//	kds_crmtab_crm_clienti_contatti.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_clienti_contatti.retrieve()
	if kds_crm_clienti_contatti.rowcount( ) > 0 then
		kds_crm_clienti_contatti.rowscopy( 1, kds_crm_clienti_contatti.rowcount( ), primary!, kds_crmtab_crm_clienti_contatti, 1, primary!)
		k_rc = kds_crmtab_crm_clienti_contatti.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_clienti_contatti.retrieve()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_gruppi () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_gruppi, kds_crmtab_crm_gruppi

try
	
	kds_crm_gruppi = create datastore 
	kds_crm_gruppi.dataobject = "ds_crm_gruppi" 
	kds_crm_gruppi.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_gruppi = create datastore
	kds_crmtab_crm_gruppi.dataobject = "ds_crmtab_crm_gruppi"
	kds_crmtab_crm_gruppi.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_gruppi")
//	kds_crmtab_crm_gruppi.retrieve( )
//	for k_riga =kds_crmtab_crm_gruppi.rowcount( ) to 1 step -1
//		kds_crmtab_crm_gruppi.deleterow(k_riga)
//	next
//	kds_crmtab_crm_gruppi.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_gruppi.retrieve()
	if kds_crm_gruppi.rowcount( ) > 0 then
		kds_crm_gruppi.rowscopy( 1, kds_crm_gruppi.rowcount( ), primary!, kds_crmtab_crm_gruppi, 1, primary!)
		k_rc = kds_crmtab_crm_gruppi.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_gruppi.retrieve()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_sl_pt () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0
int k_rc=0
datastore kds_crm_sl_pt, kds_crmtab_crm_sl_pt

try
	
	kds_crm_sl_pt = create datastore 
	kds_crm_sl_pt.dataobject = "ds_crm_sl_pt" 
	kds_crm_sl_pt.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_sl_pt = create datastore
	kds_crmtab_crm_sl_pt.dataobject = "ds_crmtab_crm_sl_pt"
	kds_crmtab_crm_sl_pt.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_pt")
//	kds_crmtab_crm_sl_pt.retrieve( )
//	for k_riga =kds_crmtab_crm_sl_pt.rowcount( ) to 1 step -1
//		kds_crmtab_crm_sl_pt.deleterow(k_riga)
//	next
//	kds_crmtab_crm_sl_pt.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_sl_pt.retrieve()
	if kds_crm_sl_pt.rowcount( ) > 0 then
		kds_crm_sl_pt.rowscopy( 1, kds_crm_sl_pt.rowcount( ), primary!, kds_crmtab_crm_sl_pt, 1, primary!)
		k_rc = kds_crmtab_crm_sl_pt.update( )
		kiuo_sqlca_db_crm.db_commit( )
		
		k_return = kds_crmtab_crm_sl_pt.retrieve()

		kiuo_sqlca_db_crm.db_disconnetti( )
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_confermaordine () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe=0
int k_rc=0
datastore kds_crm_confermaordine, kds_crmtab_crm_confermaordine

try
	
	kds_crm_confermaordine = create datastore 
	kds_crm_confermaordine.dataobject = "ds_crm_confermaordine" 
	kds_crm_confermaordine.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_confermaordine = create datastore
	kds_crmtab_crm_confermaordine.dataobject = "ds_crmtab_crm_confermaordine"
	kds_crmtab_crm_confermaordine.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_confermaordine")
//	kds_crmtab_crm_confermaordine.retrieve( )
//	for k_riga =kds_crmtab_crm_confermaordine.rowcount( ) to 1 step -1
//		kds_crmtab_crm_confermaordine.deleterow(k_riga)
//	next
//	kds_crmtab_crm_confermaordine.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_confermaordine.retrieve()
	k_righe = kds_crm_confermaordine.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_rc = kds_crmtab_crm_confermaordine.insertrow(k_riga)
			kds_crmtab_crm_confermaordine.object.id_confermaordine[k_riga] = kds_crm_confermaordine.object.id_confermaordine[k_riga]
			kds_crmtab_crm_confermaordine.object.id_cliente[k_riga] = kds_crm_confermaordine.object.id_cliente[k_riga]
			kds_crmtab_crm_confermaordine.object.id_contratto[k_riga] = kds_crm_confermaordine.object.id_contratto[k_riga]
			kds_crmtab_crm_confermaordine.object.id_tipocontratto[k_riga] = kds_crm_confermaordine.object.id_tipocontratto[k_riga]
			kds_crmtab_crm_confermaordine.object.data_ins[k_riga] = kds_crm_confermaordine.object.data_ins[k_riga]
			kds_crmtab_crm_confermaordine.object.data_scad[k_riga] = kds_crm_confermaordine.object.data_scad[k_riga]
			kds_crmtab_crm_confermaordine.object.descr[k_riga] = kds_crm_confermaordine.object.descr[k_riga]
			kds_crmtab_crm_confermaordine.object.cod_contr_comm[k_riga] = kds_crm_confermaordine.object.cod_contr_comm[k_riga]
			kds_crmtab_crm_confermaordine.object.cod_capitolato[k_riga] = kds_crm_confermaordine.object.cod_capitolato[k_riga]
			kds_crmtab_crm_confermaordine.object.cod_pt[k_riga] = kds_crm_confermaordine.object.cod_pt[k_riga]

		end for
		k_rc = kds_crmtab_crm_confermaordine.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_confermaordine.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_listino () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe=0
int k_rc=0
datastore kds_crm_listino, kds_crmtab_crm_listino

try
	
	kds_crm_listino = create datastore 
	kds_crm_listino.dataobject = "ds_crm_listino" 
	kds_crm_listino.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_listino = create datastore
	kds_crmtab_crm_listino.dataobject = "ds_crmtab_crm_listino"
	kds_crmtab_crm_listino.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_listino")
//	kds_crmtab_crm_listino.retrieve( )
//	for k_riga =kds_crmtab_crm_listino.rowcount( ) to 1 step -1
//		kds_crmtab_crm_listino.deleterow(k_riga)
//	next
//	kds_crmtab_crm_listino.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_listino.retrieve()
	k_righe = kds_crm_listino.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_rc = kds_crmtab_crm_listino.insertrow(k_riga)
			kds_crmtab_crm_listino.object.id_crm_listino[k_riga] = k_riga
			kds_crmtab_crm_listino.object.id_listino[k_riga] = kds_crm_listino.object.id_listino[k_riga]
			kds_crmtab_crm_listino.object.id_cliente[k_riga] = kds_crm_listino.object.id_cliente[k_riga]
			kds_crmtab_crm_listino.object.cod_art[k_riga] = kds_crm_listino.object.cod_art[k_riga]
			kds_crmtab_crm_listino.object.dose[k_riga] = kds_crm_listino.object.dose[k_riga]
			kds_crmtab_crm_listino.object.prezzo[k_riga] = kds_crm_listino.object.prezzo[k_riga]
			kds_crmtab_crm_listino.object.id_voce[k_riga] = kds_crm_listino.object.id_voce[k_riga]
			kds_crmtab_crm_listino.object.voce_decriz[k_riga] = kds_crm_listino.object.voce_decriz[k_riga]
			kds_crmtab_crm_listino.object.id_cond_fatt[k_riga] = kds_crm_listino.object.id_cond_fatt[k_riga]
			kds_crmtab_crm_listino.object.cond_fatt_descriz[k_riga] = kds_crm_listino.object.cond_fatt_descriz[k_riga]
			kds_crmtab_crm_listino.object.campione[k_riga] = kds_crm_listino.object.campione[k_riga]
			kds_crmtab_crm_listino.object.misure[k_riga] = kds_crm_listino.object.misure[k_riga]
			kds_crmtab_crm_listino.object.occup_ped[k_riga] = kds_crm_listino.object.occup_ped[k_riga]
			kds_crmtab_crm_listino.object.magazzino[k_riga] = kds_crm_listino.object.magazzino[k_riga]
			kds_crmtab_crm_listino.object.id_confermaordine[k_riga] = kds_crm_listino.object.id_confermaordine[k_riga]

		end for
		k_rc = kds_crmtab_crm_listino.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_listino.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_cntr_tot_mese () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe=0
int k_rc=0
datastore kds_crm_cntr_tot_mese, kds_crmtab_crm_cntr_tot_mese

try
	
	kds_crm_cntr_tot_mese = create datastore 
	kds_crm_cntr_tot_mese.dataobject = "ds_crm_cntr_tot_mese" 
	kds_crm_cntr_tot_mese.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_cntr_tot_mese = create datastore
	kds_crmtab_crm_cntr_tot_mese.dataobject = "ds_crmtab_crm_cntr_tot_mese"
	kds_crmtab_crm_cntr_tot_mese.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_cntr_tot_mese")
//	kds_crmtab_crm_cntr_tot_mese.retrieve( )
//	for k_riga =kds_crmtab_crm_cntr_tot_mese.rowcount( ) to 1 step -1
//		kds_crmtab_crm_cntr_tot_mese.deleterow(k_riga)
//	next
//	kds_crmtab_crm_cntr_tot_mese.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_cntr_tot_mese.retrieve()
	k_righe = kds_crm_cntr_tot_mese.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_rc = kds_crmtab_crm_cntr_tot_mese.insertrow(k_riga)
			kds_crmtab_crm_cntr_tot_mese.object.id_cliente[k_riga] = kds_crm_cntr_tot_mese.object.id_cliente[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.id_confermaordine[k_riga] = kds_crm_cntr_tot_mese.object.id_confermaordine[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.mese[k_riga] = kds_crm_cntr_tot_mese.object.mese[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.anno[k_riga] = kds_crm_cntr_tot_mese.object.anno[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.colli[k_riga] = kds_crm_cntr_tot_mese.object.colli[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.pedane[k_riga] = kds_crm_cntr_tot_mese.object.pedane[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.importo_fatturato[k_riga] = kds_crm_cntr_tot_mese.object.importo_fatturato[k_riga]
			kds_crmtab_crm_cntr_tot_mese.object.importo_da_fatturare[k_riga] = kds_crm_cntr_tot_mese.object.importo_da_fatturare[k_riga]

		end for
		k_rc = kds_crmtab_crm_cntr_tot_mese.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_cntr_tot_mese.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

public function long u_m2000_to_crm_previsioni () throws uo_exception;//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe=0
int k_rc=0
datastore kds_crm_previsioni, kds_crmtab_crm_previsioni
kuo_sqlca_db_previsioni kluo_sqlca_db_previsioni
 
 
try
	
	kluo_sqlca_db_previsioni = create kuo_sqlca_db_previsioni
	kluo_sqlca_db_previsioni.db_connetti( )
	kds_crm_previsioni = create datastore 
	kds_crm_previsioni.dataobject = "ds_crm_previsioni" 
	k_rc = kds_crm_previsioni.settransobject( kluo_sqlca_db_previsioni )
	
	kiuo_sqlca_db_crm.db_connetti( )
	kds_crmtab_crm_previsioni = create datastore
	kds_crmtab_crm_previsioni.dataobject = "ds_crmtab_crm_previsioni"
	kds_crmtab_crm_previsioni.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	kiuo_sqlca_db_crm.db_truncate("crm_previsioni")
//	k_righe = kds_crmtab_crm_previsioni.retrieve( )
////	k_righe = kds_crmtab_crm_previsioni.rowcount( )
//	for k_riga = k_righe to 1 step -1
//		kds_crmtab_crm_previsioni.deleterow(k_riga)
//	next
//	kds_crmtab_crm_previsioni.update( )
//	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_previsioni.retrieve()
	k_righe = kds_crm_previsioni.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			k_rc = kds_crmtab_crm_previsioni.insertrow(k_riga)
			kds_crmtab_crm_previsioni.object.id_cliente[k_riga] = kds_crm_previsioni.object.id_cliente[k_riga]
			kds_crmtab_crm_previsioni.object.mese[k_riga] = kds_crm_previsioni.object.mese[k_riga]
			kds_crmtab_crm_previsioni.object.anno[k_riga] = kds_crm_previsioni.object.anno[k_riga]
			kds_crmtab_crm_previsioni.object.colli[k_riga] = kds_crm_previsioni.object.colli[k_riga]
			kds_crmtab_crm_previsioni.object.importo[k_riga] = kds_crm_previsioni.object.fatturato[k_riga]

		end for
		k_rc = kds_crmtab_crm_previsioni.update( )
		if k_rc > 0 then 
			kiuo_sqlca_db_crm.db_commit( )
			k_return = kds_crmtab_crm_previsioni.retrieve()
		end if	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

on kuf_m2000tocrm.create
call super::create
end on

on kuf_m2000tocrm.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	if not isvalid(kiuo_sqlca_db_crm) then kiuo_sqlca_db_crm = create kuo_sqlca_db_crm

end event

