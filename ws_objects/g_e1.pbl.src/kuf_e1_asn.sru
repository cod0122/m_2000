$PBExportHeader$kuf_e1_asn.sru
forward
global type kuf_e1_asn from kuf_parent
end type
end forward

global type kuf_e1_asn from kuf_parent
end type
global kuf_e1_asn kuf_e1_asn

type variables
//
public constant string kki_status_just_created = '05'		// generato ASN e WO
public constant string kki_status_ready_label = '08'			// LOTTO ricevuto e accettato etichette pronte x M2000
public constant string kki_status_ready_toschedule = '20'  	// etichette associate (label matched) pronte per la pianificazione
public constant string kki_status_working = '45'  	// in lavorazione....
public constant string kki_status_released = '95'  	// ultimo stato del ASN praticamente chiuso
public constant string kki_status_canceled = '99'  	// ASN annullato
public constant string kki_status_NC = 'NC'  	// Non rilevato

public kds_e1_asn_x_schedule kids_e1_asn_x_schedule
public kds_e1_asn_x_schedule_l kids_e1_asn_x_schedule_l
public kds_e1_asn_get_stato kids_e1_asn_get_stato
private kds_e1_asn_accettati_l kids_e1_asn_accettati_l
private kds_e1_asn_accettato kids_e1_asn_accettato
private kds_e1_asn_ricevuti_l kids_e1_asn_ricevuti_l
end variables

forward prototypes
public subroutine _readme ()
public function datastore get_testata (st_tab_f5547013 ast_tab_f5547013) throws uo_exception
public function datastore get_righe (st_tab_f5547014 ast_tab_f5547014) throws uo_exception
public function integer tb_add_righe (kds_e1_asn_rows ads1_e1_asn_rows) throws uo_exception
public function integer tb_add_testata (kds_e1_asn_header ads1_e1_asn_header) throws uo_exception
public function boolean if_esiste (st_tab_f5547013 ast_tab_f5547013) throws uo_exception
public function integer u_crea_asn (st_tab_f5547013 ast_tab_f5547013) throws uo_exception
private function integer u_crea_asn_esegui (kds_e1_asn_header ads1_e1_asn_header, kds_e1_asn_rows ads1_e1_asn_rows, boolean a_commit) throws uo_exception
public function integer u_crea_asn_batch () throws uo_exception
public function boolean if_barcode_creati (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception
public function boolean if_ready_to_schedule (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception
public function long u_get_ready_to_schedule () throws uo_exception
public function kds_e1_asn_get_barcode get_barcode (st_get_e1barcode ast_get_e1barcode) throws uo_exception
public function boolean if_accettato (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception
public function long u_get_accettati () throws uo_exception
public function boolean if_accettato_in_l (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception
public function boolean if_ready_to_schedule_in_l (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception
public function long u_get_stato (ref st_tab_e1_asn ast_tab_e1_asn[]) throws uo_exception
public function datetime u_get_date_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception
end prototypes

public subroutine _readme ();//--- oltre al PARENT
//--- oggetto per la gestione delle tabelle E-ONE circa la resistrazione del LOTTO/RIFERIMENTO che qui si chiama ASN
//--- tabelle:  
//--- PRODDTA.F5547013 = testata ASN
//--- PRODDTA.F5547014 = dettaglio ASN
//---
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- * 	= 	necessario
//--- # 	= 	lasciare vuoto
//--- E1 	= 	compilato da E1, lasciare vuoto
//--- 
//--- descrizione campi PRODDTA.F5547013 = testata ASN
//--- EHAPID	NCHAR(12 CHAR)		No		*	Riferimento M2000
//--- EHAN8	NUMBER						Yes		*	Codice cliente E1
//--- EHSHAN	NUMBER					Yes		*	Codice cliente (E1) spedizione
//--- EHVR01	NCHAR(25 CHAR)		Yes		*	E1 purchase order (PO) - sarebbe il numero Ordine del cliente (ci mettiamo il suo numero bolla)
//--- EHDRQJ	NUMBER(6,0)			Yes		#	Data/ora prevista di ricevimento merce - vuota se si compila il dato successivo
//--- EHA801	NCHAR(8 CHAR)			Yes			Data prevista di ricevimento merce formato testo DDMMYYYY
//--- EHDRQT	NUMBER					Yes			Ora prevista di ricevimento merce formato testo HHMMSS
//--- EHCARS	NUMBER					Yes		#	Codice del trasportatore (solo per gli USA?)	
//--- EHCKNU	NCHAR(25 CHAR)		Yes		#	Codice del Freight Bill (solo per glu USA?)
//--- EHUORG	NUMBER					Yes		#	Numero di pallet/scatole della freight bill
//--- EHMCU	NCHAR(12 CHAR)		Yes		E1	Codice della facility di Minerbio 
//--- EHEDSP	NCHAR(1 CHAR)			Yes		E1	Flag di conferma lettura della ASN da parte di E1
//--- EHDS01	NCHAR(80 CHAR)		Yes		E1	Descrizione di un eventuale errore di processo della ASN
//--- EHUSER	NCHAR(10 CHAR)		Yes		*	Codice E1 dell'utente che ha inviato i dati da M2000
//--- EHPID	NCHAR(10 CHAR)			Yes		E1	Program id
//--- EHJOBN	NCHAR(10 CHAR)		Yes		E1	Job number
//--- EHUPMJ	NUMBER(6,0)			Yes		E1	Date updated
//--- EHTDAY	NUMBER					Yes		E1	Time updated
//------
//--- PRODDTA.F5547014 = dettaglio ASN
//--- EDAPID	NCHAR(12 CHAR)		No		*	Riferimento M2000
//--- EDLNID	NUMBER					No		*	Numero di linea - per ogni ASN, parte da 1000 con incrementi di 1000
//--- EDUORG	NUMBER					Yes		*	Quantità - 1
//--- EDLITM	NCHAR(25 CHAR)		Yes		*	E1 customer item (abbinato a contratto/capitolato)
//--- EDIR02	NCHAR(30 CHAR)		Yes			Customer load - numero del carico
//--- EDIR01	NCHAR(30 CHAR)		Yes		*	Customer pallet ID (barcode cliente)
//--- EHEDSP	NCHAR(1 CHAR)			Yes		E1	Flag di conferma lettura della ASN da parte di E1
//--- EHDS01	NCHAR(80 CHAR)		Yes		E1	Descrizione di un eventuale errore di processo della ASN
//--- EHUSER	NCHAR(10 CHAR)		Yes		*	Codice E1 dell'utente che ha inviato i dati da M2000
//--- EHPID	NCHAR(10 CHAR)			Yes		E1	Program id
//--- EHJOBN	NCHAR(10 CHAR)		Yes		E1	Job number
//--- EHUPMJ	NUMBER(6,0)			Yes		E1	Date updated
//--- EHTDAY	NUMBER					Yes		E1	Time updated
//----------------------------------------------------------------------------------------------------------------------------------------------------

end subroutine

public function datastore get_testata (st_tab_f5547013 ast_tab_f5547013) throws uo_exception;//
//====================================================================
//=== Get rek ASN di testata
//=== 
//=== inp: st_tab_f5547013  EHAPID (ID_MECA) valorizzato
//=== out: 
//=== Ritorna: datastore ds_e1_asn_f5547013 con tutti i dati
//=== 
//====================================================================
int k_rc=0
st_esito kst_esito
kds_e1_asn_header kds1_e1_asn_header


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(ast_tab_f5547013.EHAPID) > " " then
	
		kds1_e1_asn_header = create kds_e1_asn_header
		k_rc = kds1_e1_asn_header.retrieve(ast_tab_f5547013.EHAPID)

		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore durante lettura testata ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto: " + trim(ast_tab_f5547013.EHAPID)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice Lotto per leggere da E-ONE su ASN (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return kds1_e1_asn_header

end function

public function datastore get_righe (st_tab_f5547014 ast_tab_f5547014) throws uo_exception;//
//====================================================================
//=== Get rek ASN di testata
//=== 
//=== inp: st_tab_f5547014  EDAPID (ID_MECA) e EDLNID (n.riga) che se zero torna tutte le righe 
//=== out: 
//=== Ritorna: datastore ads1_e1_asn_rows con tutti i dati
//=== 
//====================================================================
integer k_sn=0
int k_rc=0
st_esito kst_esito
kds_e1_asn_rows kds1_e1_asn_rows


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(ast_tab_f5547014.EDAPID) > " " then
		if isnull(ast_tab_f5547014.EDLNID) then ast_tab_f5547014.EDLNID = 0

		kds1_e1_asn_rows = create kds_e1_asn_rows
		kds1_e1_asn_rows.db_connetti( )
		k_rc = kds1_e1_asn_rows.retrieve(ast_tab_f5547014.EDAPID, ast_tab_f5547014.EDLNID)
		
		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore durante lettura righe da E-ONE su ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto e riga: " + trim(ast_tab_f5547014.EDAPID) + " " + string(ast_tab_f5547014.EDLNID)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Mancail codice Lotto e numero riga per leggere da E-ONE su ASN (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return kds1_e1_asn_rows

end function

public function integer tb_add_righe (kds_e1_asn_rows ads1_e1_asn_rows) throws uo_exception;//====================================================================
//=== Aggiunge righe al ASN 
//=== 
//=== inp: ads1_e1_asn_rows e ki_commit (TRUE = fa la commit/rollback)
//=== Ritorna: numero righe inserite (0=nessuna)
//=== 
//====================================================================
int k_return = 0
int k_upd=0, k_righe=0, k_riga, k_lencolmax
st_tab_f5547014 kst_tab_f5547014
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_righe = ads1_e1_asn_rows.rowcount() 
	if k_righe > 0 then
		
		ads1_e1_asn_rows.db_connetti( )

		kst_tab_f5547014.eduser = kguo_utente.get_codice( )
		k_lencolmax = kguo_sqlca_db_e1.u_get_col_len( "F5547014", "EDUSER") //get max size col utente su E1
		if k_lencolmax > 0 then
			if len(trim(kst_tab_f5547014.eduser)) > k_lencolmax then
				kst_tab_f5547014.eduser = left(kst_tab_f5547014.eduser, k_lencolmax)
			end if
		end if
		
		for k_riga = 1 to k_righe
			ads1_e1_asn_rows.setitem(k_riga, "eduser", kst_tab_f5547014.eduser) // set il codice utente
			ads1_e1_asn_rows.setitem(k_riga, "ededsp", " ") // set space in field how to request by e1
		next
		k_upd = ads1_e1_asn_rows.update( )   // AGGIORNA TABELLA
	
		if k_upd > 0 then
			if ads1_e1_asn_rows.ki_commit then
				ads1_e1_asn_rows.db_commit( )
			end if
			k_return = k_righe
		else
			if ads1_e1_asn_rows.ki_commit then
				ads1_e1_asn_rows.db_rollback( )
			end if
			kst_esito.sqlcode = k_upd
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore durante inserimento nuove righe ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto: " + trim(ads1_e1_asn_rows.getitemstring(1, "EDAPID")) 
			kguo_exception.inizializza( )
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

public function integer tb_add_testata (kds_e1_asn_header ads1_e1_asn_header) throws uo_exception;//====================================================================
//=== Aggiunge la testata ASN 
//=== 
//=== inp: kds_e1_asn_header e ki_commit (TRUE = fa la commit/rollback)
//=== Ritorna: numero righe inserite (0=nessuna)
//=== 
//====================================================================
int k_return = 0
int k_upd=0, k_righe=0, k_lencolmax
st_esito kst_esito
st_tab_f5547013 kst_tab_f5547013

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_righe = ads1_e1_asn_header.rowcount() 
	if k_righe > 0 then
		
		kst_tab_f5547013.ehuser = kguo_utente.get_codice( )
		k_lencolmax = kguo_sqlca_db_e1.u_get_col_len( "F5547013", "EHUSER") //get max size col utente su E1
		if k_lencolmax > 0 then
			if len(trim(kst_tab_f5547013.ehuser)) > k_lencolmax then
				kst_tab_f5547013.ehuser = left(kst_tab_f5547013.ehuser, k_lencolmax)
			end if
		end if
		
		ads1_e1_asn_header.db_connetti( )
		ads1_e1_asn_header.object.ehuser[1] = kst_tab_f5547013.ehuser
		ads1_e1_asn_header.object.EHMCU[1] = kkg.e1mcu 				   // codice 270 = MINERBIO
		ads1_e1_asn_header.object.ehedsp[1] = " "  // set space in field how to request by e1
		k_upd = ads1_e1_asn_header.update( )   // AGGIORNA TABELLA
	
		if k_upd > 0 then
			if ads1_e1_asn_header.ki_commit then
				ads1_e1_asn_header.db_commit( )
			end if
			k_return = k_righe
		else
			if ads1_e1_asn_header.ki_commit then
				ads1_e1_asn_header.db_rollback( )
			end if
			kst_esito.sqlcode = k_upd
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore durante inserimento nuove righe ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto: " + trim(ads1_e1_asn_header.getitemstring(1, "EHAPID")) 
			kguo_exception.inizializza( )
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

public function boolean if_esiste (st_tab_f5547013 ast_tab_f5547013) throws uo_exception;//
//====================================================================
//=== Check presenza del rek ASN di testata
//=== 
//=== inp: st_tab_f5547013  EHAPID (ID_MECA) valorizzato
//=== out: 
//=== Ritorna: TRUE = esiste
//=== 
//====================================================================
boolean k_return = false
int k_rc=0
st_esito kst_esito
kds_e1_asn_esiste kds1_e1_asn_esiste


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(ast_tab_f5547013.EHAPID) > " " then
	
		kds1_e1_asn_esiste = create kds_e1_asn_esiste
		if kds1_e1_asn_esiste.db_connetti( ) then
			k_rc = kds1_e1_asn_esiste.retrieve(ast_tab_f5547013.EHAPID)
	
			if k_rc < 0 then
				kst_esito.sqlcode = k_rc
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Errore durante lettura esistenza ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto: " + trim(ast_tab_f5547013.EHAPID)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			else
				if k_rc > 0 then
					k_return = true
				end if
			end if
		else
			kst_esito.sqlcode = 0
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.SQLErrText = "Connessione dati su E-ONE non riuscita (" + trim(kst_esito.nome_oggetto) + ") "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice Lotto per verificare esistenza ASN su E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_e1_asn_esiste) then destroy kds1_e1_asn_esiste
	
end try

return k_return

end function

public function integer u_crea_asn (st_tab_f5547013 ast_tab_f5547013) throws uo_exception;//------------------------------------------------------------------------------------------------------
//--- Crea un nuovo ASN 
//--- 
//--- inp: st_tab_f5547013 apid (id_meca convertito in alfa)
//--- Ritorna: numero righe inserite (0=nessuna)
//--- 
//------------------------------------------------------------------------------------------------------
int k_return = 0
int k_righe=0, k_righe_testa
int k_ctr, k_riga, k_riga_insert, k_riga_pkl, k_righe_dett
boolean k_commit
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_m_r_f kst_tab_m_r_f
st_tab_listino kst_tab_listino
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_armo kst_tab_armo[]
st_esito kst_esito
datastore kds_wm_pklist_righe_l_barcode
kds_e1_asn_header kds1_e1_asn_header
kds_e1_asn_rows kds1_e1_asn_rows
kuf_listino kuf1_listino
kuf_clienti kuf1_clienti
kuf_armo kuf1_armo
kuf_wm_pklist_testa kuf1_wm_pklist_testa


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds1_e1_asn_header = create kds_e1_asn_header
	kds1_e1_asn_rows = create kds_e1_asn_rows

	kuf1_listino = create kuf_listino
	kuf1_clienti = create kuf_clienti
	kuf1_armo = create kuf_armo
	kuf1_wm_pklist_testa = create kuf_wm_pklist_testa

	if isnumber(ast_tab_f5547013.ehapid) then
	else
		kguo_exception.inizializza()
		kst_esito.esito = kkg_esito.no_esecuzione
		if isnull(ast_tab_f5547013.ehapid) then ast_tab_f5547013.ehapid = ""
		kst_esito.SQLErrText = "Id Lotto non indicato o non numerico ('" + trim(ast_tab_f5547013.ehapid) + "'), non è possibile generare i dati ASN per E-ONE"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- già caricato?
	if if_esiste(ast_tab_f5547013) then
		kguo_exception.inizializza()
		kst_esito.esito = kkg_esito.no_esecuzione
		if isnull(ast_tab_f5547013.ehapid) then ast_tab_f5547013.ehapid = ""
		kst_esito.SQLErrText = "Lotto '" + trim(ast_tab_f5547013.ehapid) + "' già presente su E1, non è possibile procedere a un nuovo carico."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get dati del pkl
	kst_tab_meca.id = long(ast_tab_f5547013.ehapid)
	kst_tab_meca.id_wm_pklist = kuf1_armo.get_id_wm_pklist(kst_tab_meca)
	if kst_tab_meca.id_wm_pklist > 0  then
	else
		kguo_exception.inizializza()
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Lotto senza il codice del Packing List, non è possibile generare i dati ASN per E-ONE"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get cliente
	kuf1_armo.get_clie(kst_tab_meca) 		// legge CLIE_1 /2 / 3

////--- get eventuale prefisso dei barcode (pklbcodepref)
//	if kst_tab_meca.clie_1 > 0 then
//		kst_tab_clienti.codice = kst_tab_meca.clie_1
//		kst_tab_clienti.pklbcodepref = kuf1_clienti.get_pklbcodepref(kst_tab_clienti)
//	else
//		kst_tab_clienti.pklbcodepref = ""
//	end if

	ast_tab_f5547013.ehapid = trim(ast_tab_f5547013.ehapid)
	kst_tab_wm_pklist.id_wm_pklist = kst_tab_meca.id_wm_pklist
	kst_tab_wm_pklist.customerlot = kuf1_wm_pklist_testa.get_customerlot(kst_tab_wm_pklist) // get del codice lotto caricato dal cliente in testata
	kst_tab_wm_pklist.idpkl = kuf1_wm_pklist_testa.get_idpkl(kst_tab_wm_pklist) // get del codice packing-list

	//kst_tab_armo.colli_2 = get_totale_colli( )
	kds_wm_pklist_righe_l_barcode = create datastore
	kds_wm_pklist_righe_l_barcode.dataobject = "ds_wm_pklist_righe_l_barcode"
	kds_wm_pklist_righe_l_barcode.settransobject(kguo_sqlca_db_magazzino)
		
//--- carica i BARCODE cliente su DW per E-ONE 
	kst_tab_armo[1].id_meca = long(ast_tab_f5547013.ehapid)
	k_righe_dett = kuf1_armo.get_righe(kst_tab_armo[])
	for k_riga = 1  to k_righe_dett

		kst_tab_armo[k_riga].colli_2 = kuf1_armo.get_colli_entrati_riga_datrattare(kst_tab_armo[k_riga])   // conta il numero colli da TRATTARE
		kst_tab_armo[k_riga].colli_2 += kuf1_armo.get_colli_entrati_conto_deposito(kst_tab_armo[k_riga])	// somma il numero colli in CONTO DEPOSITO
		if kst_tab_armo[k_riga].colli_2 > 0 then
	
			k_riga_pkl = kds_wm_pklist_righe_l_barcode.retrieve(kst_tab_wm_pklist.id_wm_pklist)  // leggo i barcode cliente
			kuf1_armo.get_id_listino(kst_tab_armo[k_riga]) //tab_1.tabpage_4.dw_4.getitemnumber( k_riga, "id_listino")
			kst_tab_listino.id = kst_tab_armo[k_riga].id_listino
			if kst_tab_listino.id > 0 then
				kst_tab_listino.e1litm = kuf1_listino.get_e1litm(kst_tab_listino)
			else
				kst_tab_listino.e1litm = "" //"NOT_FOUND!"
			end if
			if trim(kst_tab_listino.e1litm) > " " then
			else
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.sqlcode = 0
				kguo_exception.kist_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.kist_esito.sqlerrtext = "Generazione ASN su E1 bloccata, listino senza codice Item E1: (id Listino " + string(kst_tab_listino.id) + ", id Lotto/ASN: " + ast_tab_f5547013.ehapid + ")"
				throw kguo_exception
			end if
			
			for k_ctr = 1 to k_riga_pkl
				
				k_riga_insert = kds1_e1_asn_rows.insertrow(0)
				kds1_e1_asn_rows.setitem( k_riga_insert, "EDAPID", ast_tab_f5547013.ehapid)
				kds1_e1_asn_rows.setitem( k_riga_insert, "EDLNID", k_riga_insert * 1000)
				kds1_e1_asn_rows.setitem( k_riga_insert, "EDUORG", 1)
				kds1_e1_asn_rows.setitem( k_riga_insert, "EDLITM", trim(kst_tab_listino.e1litm))
				
				if trim(kds_wm_pklist_righe_l_barcode.getitemstring(k_ctr, "idlotto_clie")) > " " then  //--- se caricate le righe cusomerlot sui singoli barcode 
					kst_tab_wm_pklist.customerlot = trim(kds_wm_pklist_righe_l_barcode.getitemstring(k_ctr, "idlotto_clie"))
				end if
				if trim(kst_tab_wm_pklist.customerlot) > " " then
					kds1_e1_asn_rows.setitem( k_riga_insert, "EDIR02", trim(left(kst_tab_wm_pklist.customerlot,30)))
				else
					kds1_e1_asn_rows.setitem( k_riga_insert, "EDIR02", trim(left(kst_tab_wm_pklist.idpkl,30)))
				end if
				
				kds1_e1_asn_rows.setitem( k_riga_insert, "EDIR01", trim(kds_wm_pklist_righe_l_barcode.getitemstring(k_ctr, "wm_barcode")))
			next
		end if
							
	next

//--- carica testata lotto da caricare su E-ONE 
	if kds1_e1_asn_rows.rowcount( ) > 0 then
		k_riga_insert = kds1_e1_asn_header.insertrow(0)
		kds1_e1_asn_header.setitem( k_riga_insert, "EHAPID", ast_tab_f5547013.ehapid)
		
		if kst_tab_meca.clie_3 > 0 then
			kst_tab_clienti.codice = kst_tab_meca.clie_3
			kst_tab_clienti.e1an = kuf1_clienti.get_e1an(kst_tab_clienti)
		else
			kst_tab_clienti.e1an = 0
		end if
		kds1_e1_asn_header.setitem( k_riga_insert, "EHAN8", kst_tab_clienti.e1an)
		
		if kst_tab_meca.clie_2 > 0 then
//--- prima tenta di prendere il codice x E1 del Ricevente dalla tabella 'legami' M_R_F			
			kst_tab_m_r_f.clie_1 = kst_tab_meca.clie_1
			kst_tab_m_r_f.clie_2 = kst_tab_meca.clie_2
			kst_tab_m_r_f.clie_3 = kst_tab_meca.clie_3
			kst_tab_clienti.e1an = kuf1_clienti.get_mrf_e1an(kst_tab_m_r_f)
			if kst_tab_clienti.e1an > 0 then
			else
//--- .... se non trovato tenta di prendere il codice x E1 dall'anagrafica del Ricevente 			
				kst_tab_clienti.codice = kst_tab_meca.clie_2
				kst_tab_clienti.e1an = kuf1_clienti.get_e1an(kst_tab_clienti)
			end if
			if isnull(kst_tab_clienti.e1an) then kst_tab_clienti.e1an = 0
		else
			kst_tab_clienti.e1an = 0
		end if
		kds1_e1_asn_header.setitem( k_riga_insert, "EHSHAN",  kst_tab_clienti.e1an)
		
		kuf1_armo.get_num_bolla_in(kst_tab_meca)
		if isnull(kst_tab_meca.num_bolla_in) then
			kst_tab_meca.num_bolla_in = ""
		end if
		kds1_e1_asn_header.setitem( k_riga_insert, "EHVR01", kst_tab_meca.num_bolla_in) // tab_1.tabpage_1.dw_1.getitemstring(1, "num_bolla_in"))
		kds1_e1_asn_header.setitem( k_riga_insert, "EHA801", kGuf_data_base.get_e1_dateformat(RelativeDate(kguo_g.get_dataoggi( ), 1)))
		kds1_e1_asn_header.setitem( k_riga_insert, "EHUORG", kds1_e1_asn_rows.rowcount() )
	end if
	
	if kds1_e1_asn_header.rowcount( ) > 0 and kds1_e1_asn_rows.rowcount( ) > 0 then
		if ast_tab_f5547013.st_tab_g_0.esegui_commit = "S" or isnull(ast_tab_f5547013.st_tab_g_0.esegui_commit) then
			k_commit = true
		else
			k_commit = false
		end if
		k_return = u_crea_asn_esegui(kds1_e1_asn_header, kds1_e1_asn_rows, k_commit)   	// AGGIUNGE LOTTO ASN SU E-ONE
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessuna riga del Lotto da registrare in E-ONE!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_listino) then destroy kuf1_listino
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try

return k_return

end function

private function integer u_crea_asn_esegui (kds_e1_asn_header ads1_e1_asn_header, kds_e1_asn_rows ads1_e1_asn_rows, boolean a_commit) throws uo_exception;//------------------------------------------------------------------------------------------------------
//--- Crea un nuovo ASN di testata + righe
//--- 
//--- inp: ads1_e1_asn_header testata
//--- 		,ads1_e1_asn_rows righe
//---      ,a_commit TRUE = fa la commit/rollback
//--- Ritorna: numero righe inserite (0=nessuna)
//--- 
//------------------------------------------------------------------------------------------------------
int k_return = 0
int k_righe=0, k_righe_testa
st_esito kst_esito

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ads1_e1_asn_header.rowcount() > 0 and ads1_e1_asn_rows.rowcount() > 0 then
		
		k_righe = this.tb_add_righe(ads1_e1_asn_rows)
		if k_righe > 0 then

			k_righe_testa = this.tb_add_testata(ads1_e1_asn_header) 
			if k_righe_testa > 0 then

				if a_commit then
					kguo_sqlca_db_e1.db_commit( )
					k_return = k_righe + k_righe_testa
				end if

			end if
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Nessun ASN da caricare (" + trim(kst_esito.nome_oggetto) + ")"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function integer u_crea_asn_batch () throws uo_exception;//------------------------------------------------------------------------------------------------------
//--- Cerca nuovi Lotti e crea gli ASN 
//--- 
//--- inp: 
//--- Ritorna: numero ASN caricati
//--- 
//------------------------------------------------------------------------------------------------------
int k_return = 0
int k_righe=0
int k_ctr, k_riga
st_tab_f5547013 kst_tab_f5547013
//st_esito kst_esito
kds_meca_ready_e1asn kds1_meca_ready_e1asn
 
 
try
//	kst_esito.esito = kkg_esito.ok
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = ""
//	kst_esito.nome_oggetto = this.classname()
	
	kds1_meca_ready_e1asn = create kds_meca_ready_e1asn

	kds1_meca_ready_e1asn.db_connetti( )
	k_righe = kds1_meca_ready_e1asn.u_retrieve()
	
	for k_riga = 1 to k_righe
		
		kst_tab_f5547013.ehapid = string(kds1_meca_ready_e1asn.getitemnumber(k_riga, "id"))
		if kst_tab_f5547013.ehapid > " " then
			kst_tab_f5547013.st_tab_g_0.esegui_commit = "S"
			u_crea_asn(kst_tab_f5547013)
			k_return ++
		end if
		
	next
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_meca_ready_e1asn) then destroy kds1_meca_ready_e1asn
	
end try

return k_return

end function

public function boolean if_barcode_creati (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception;//
//====================================================================
//=== Check se i barcode E1 sono stati generati per codice ASN (ID_MECA)
//=== 
//=== inp: st_get_e1barcode APID (ID_MECA string) valorizzato
//=== out: Work Order / Sales Order
//=== Ritorna: TRUE = Barcode generati da E1
//=== 
//====================================================================
boolean k_return = false
st_esito kst_esito
kds_e1_asn_barcode_creati kds1_e1_asn_barcode_creati


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(kst_get_e1barcode.apid) > " " then
	
		kst_get_e1barcode.apid = trim(kst_get_e1barcode.apid)
		//kst_get_e1barcode.srst = kki_status_ready_label
		kst_get_e1barcode.mcu = kkg.e1mcu
	
		kds1_e1_asn_barcode_creati = create kds_e1_asn_barcode_creati
		if kds1_e1_asn_barcode_creati.db_connetti( ) then

			k_return = kds1_e1_asn_barcode_creati.u_if_creati(kst_get_e1barcode) // check se barcode pronti x essere importati

		else
			kst_esito.sqlcode = 0
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.SQLErrText = "Connessione dati su E-ONE non riuscita (" + trim(kst_esito.nome_oggetto) + ") "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice Lotto per verificare esistenza barcode ASN su E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function boolean if_ready_to_schedule (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception;//
//====================================================================
//=== Check se ASN è pronto per essere schedulato in trattamento
//=== 
//=== inp: st_get_e1barcode apid ASN (APID=ID_MECA)
//=== out:
//=== Ritorna: TRUE = può essere schedulato
//=== lancia exception x errore grave
//====================================================================
boolean k_return = false
st_esito kst_esito
kds_e1_asn_x_schedule kds1_e1_asn_x_schedule


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(kst_get_e1barcode.apid) > " " then
	
		kst_get_e1barcode.apid = trim(kst_get_e1barcode.apid)
		//kst_get_e1barcode.srst = kki_status_ready_label
		kst_get_e1barcode.mcu = kkg.e1mcu
	
		kds1_e1_asn_x_schedule = create kds_e1_asn_x_schedule

		k_return = kds1_e1_asn_x_schedule.u_if_ready_to_schedule(kst_get_e1barcode) // check ASN pronto x essere messo in lav

	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice ASN per verificarne se stato OK per il trattamento, su E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_e1_asn_x_schedule) then destroy kds1_e1_asn_x_schedule
	
end try

return k_return

end function

public function long u_get_ready_to_schedule () throws uo_exception;//-------------------------------------------------------------------------------
//--- Popola dw dei Lotti pronti alla lavorazione
//--- Inpu: 
//--- Out:
//--- Rit: numero lotti trovati
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return 
string k_apid
st_get_e1barcode kst_get_e1barcode
st_esito kst_esito

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if not isvalid(kids_e1_asn_x_schedule_l) then kids_e1_asn_x_schedule_l = create kds_e1_asn_x_schedule_l

	kst_get_e1barcode.mcu = kkg.e1mcu
	k_return = kids_e1_asn_x_schedule_l.u_get_ready_to_schedule(kst_get_e1barcode)

	if k_return < 0 then
		kst_esito.sqlcode = k_return
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in lettura ASN pronti per la lavorazione (operazione su E-ONE non riuscita " + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function kds_e1_asn_get_barcode get_barcode (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//
//====================================================================
//=== Get dati codice WorkOrderr e i barcode del ASN 
//=== 
//=== inp: ast_get_e1barcode  waapid (ID_MECA) valorizzato
//=== out: 
//=== Ritorna: datastore ds_e1_asn_get_barcode con tutti i dati
//=== 
//====================================================================
int k_rc=0
st_esito kst_esito
kds_e1_asn_get_barcode kds1_e1_asn_get_barcode


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(ast_get_e1barcode.apid) > " " then
	
		kds1_e1_asn_get_barcode = create kds_e1_asn_get_barcode
		kds1_e1_asn_get_barcode.db_connetti( )
		if not kds1_e1_asn_get_barcode.db_connetti( ) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Errore in connessione dati su E1 per lettura dei Barcode ASN generati."
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		//ast_get_e1barcode.srst = kki_status_ready_label
		ast_get_e1barcode.mcu = kkg.e1mcu
		k_rc = kds1_e1_asn_get_barcode.retrieve(ast_get_e1barcode.apid, ast_get_e1barcode.mcu)

		if k_rc < 0 then
			kst_esito.sqlcode = k_rc
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore durante lettura barcode ASN (" + trim(kst_esito.nome_oggetto) + ") id Lotto: " + trim(ast_get_e1barcode.apid)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice Lotto per leggere i barcode da E-ONE su ASN (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try


return kds1_e1_asn_get_barcode

end function

public function boolean if_accettato (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception;//
//====================================================================
//=== Check se ASN è nello stato di Accettato (materiale antrato)
//=== 
//=== inp: st_get_e1barcode apid ASN (APID=ID_MECA)
//=== out:
//=== Ritorna: TRUE = lotto accettato ma non chiuso
//=== lancia exception x errore grave
//====================================================================
boolean k_return = false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(kst_get_e1barcode.apid) > " " then

		if not isvalid(kids_e1_asn_accettato) then kids_e1_asn_accettato = create kds_e1_asn_accettato

		kst_get_e1barcode.apid = trim(kst_get_e1barcode.apid)
		kst_get_e1barcode.mcu = kkg.e1mcu
	
		k_return = kids_e1_asn_accettato.u_if_accettato(kst_get_e1barcode) // check ASN pronto x essere messo in lav

	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice ASN per verificare on-line se lo stato è Ricevuto (08), in E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function long u_get_accettati () throws uo_exception;//-------------------------------------------------------------------------------
//--- Popola dw dei Lotti Ricevuti (accettati)
//--- Inpu: 
//--- Out:
//--- Rit: numero lotti trovati
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return 
string k_apid
st_get_e1barcode kst_get_e1barcode
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if not isvalid(kids_e1_asn_accettati_l) then kids_e1_asn_accettati_l = create kds_e1_asn_accettati_l
	kids_e1_asn_accettati_l.db_connetti( )

	kst_get_e1barcode.mcu = kkg.e1mcu
	k_return = kids_e1_asn_accettati_l.u_get_accettati_l(kst_get_e1barcode)
	if k_return < 0 then
		kst_esito.sqlcode = k_return
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in lettura ASN stato '08' = Ricevuti (operazione su E-ONE non riuscita " + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function boolean if_accettato_in_l (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception;//
//====================================================================
//=== Check se ASN è nello stato di Accettato (materiale Entrato)
//=== il controllo viene fatto nel datastore popolato con u_get_accettati() 
//=== 
//=== inp: st_get_e1barcode apid ASN (APID=ID_MECA)
//=== out:
//=== Ritorna: TRUE = lotto entrato ma NON chiuso
//=== lancia exception x errore grave
//====================================================================
boolean k_return = false
long k_accettati=0
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(kst_get_e1barcode.apid) > " " then

		if not isvalid(kids_e1_asn_accettati_l) then 
			k_accettati = u_get_accettati( )  // popola il ds degli accettati
		end if

		if k_accettati > 0 then
			kst_get_e1barcode.apid = trim(kst_get_e1barcode.apid)
			kst_get_e1barcode.mcu = kkg.e1mcu
	
			k_return = kids_e1_asn_accettati_l.u_if_accettato(kst_get_e1barcode) // check ASN Ricevuto
		end if

	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice ASN per la ricerca se stato Ricevuto (08), su E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function boolean if_ready_to_schedule_in_l (ref st_get_e1barcode kst_get_e1barcode) throws uo_exception;//
//--------------------------------------------------------------------
//--- Check se ASN è pronto per essere trattato 
//---      controllo nel datastore ottenuto da u_get_ready_to_schedule()
//--- 
//--- inp: st_get_e1barcode apid ASN (APID=ID_MECA)
//--- out:
//--- Ritorna: TRUE = può essere schedulato
//--- lancia exception x errore grave
//--------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito
kds_e1_asn_x_schedule kds1_e1_asn_x_schedule


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if trim(kst_get_e1barcode.apid) > " " then
	
		kst_get_e1barcode.apid = trim(kst_get_e1barcode.apid)
		kst_get_e1barcode.mcu = kkg.e1mcu
	
		if not isvalid(kids_e1_asn_x_schedule_l) then 
			u_get_ready_to_schedule( )
		end if

		k_return = kids_e1_asn_x_schedule_l.u_if_ready_to_schedule(kst_get_e1barcode) // check ASN pronto x essere messo in lav

	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il codice ASN per la ricerca se stato OK per il trattamento, su E-ONE (" + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_e1_asn_x_schedule) then destroy kds1_e1_asn_x_schedule
	
end try

return k_return

end function

public function long u_get_stato (ref st_tab_e1_asn ast_tab_e1_asn[]) throws uo_exception;//-------------------------------------------------------------------------------
//--- Popola il ds 'kids_e1_asn_get_stato' con lo stato dei APID (waapid e wasrst)
//--- Inpu: st_tab_e1_asn[].waapid array con gli APID da estrarre
//--- Out: st_tab_e1_asn[].wasrst
//--- Rit: nr APID trovati 
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return 
string k_apid
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if not isvalid(kids_e1_asn_get_stato) then kids_e1_asn_get_stato = create kds_e1_asn_get_stato

	kids_e1_asn_get_stato.db_connetti( )

	ast_tab_e1_asn[1].wammcu = kkg.e1mcu
	k_return = kids_e1_asn_get_stato.u_get_stato(ast_tab_e1_asn[])
	if k_return < 0 then
		kst_esito.sqlcode = k_return
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = "Errore in lettura 'stato' ASN (operazione su E-ONE non riuscita " + trim(kst_esito.nome_oggetto) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function datetime u_get_date_received (st_tab_e1_asn ast_tab_e1_asn) throws uo_exception;//-------------------------------------------------------------------------------
//--- Torna la data e ora di carico del Lotto a Magazzino per WO o SO
//--- Inp: st_tab_e1_asn.wadoco warorn
//--- Out:
//--- Rit: la data e ora di carico (date(0) = lotti non caricato a magazzino)
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
datetime k_return 
date k_date
time k_time
string k_orax, k_timex
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if not isvalid(kids_e1_asn_ricevuti_l) then kids_e1_asn_ricevuti_l = create kds_e1_asn_ricevuti_l

	ast_tab_e1_asn.wammcu = kkg.e1mcu
	if kids_e1_asn_ricevuti_l.u_get_date_received(ast_tab_e1_asn) then
		if ast_tab_e1_asn.IRDSE > 0 then
			k_date = kGuf_data_base.u_get_datefromjuliandate(string(ast_tab_e1_asn.IRDSE))  // torna la data in formato 'normale'
			k_orax = trim(string(ast_tab_e1_asn.IRWWAST))
			if len(k_orax) > 5 then
				k_timex = left(k_orax, 2) + ":" + mid(k_orax, 3, 2) + ":" + mid(k_orax, 5, 2) + ".000000" //ora dalle 10 alle 24 formato "0:00:00.000000"
			else
				k_timex = left(k_orax, 1) + ":" + mid(k_orax, 2, 2) + ":" + mid(k_orax, 4, 2) + ".000000" //ora dalle 0 alle 10 (meno 1 decimo di sec)
			end if	
			k_time = time(k_timex) 
			k_return = datetime(k_date, k_time)
		end if
	end if
//	if k_return < 0 then
//		kst_esito.sqlcode = k_return
//		kst_esito.esito = kkg_esito.db_ko
//		kst_esito.SQLErrText = "Errore in lettura ASN pronti per la lavorazione (operazione su E-ONE non riuscita " + trim(kst_esito.nome_oggetto) + ") "
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kuf_e1_asn.create
call super::create
end on

on kuf_e1_asn.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kids_e1_asn_x_schedule) then destroy kids_e1_asn_x_schedule
if isvalid(kids_e1_asn_x_schedule_l) then destroy kids_e1_asn_x_schedule_l
if isvalid(kids_e1_asn_accettato) then destroy kids_e1_asn_accettato
if isvalid(kids_e1_asn_accettati_l) then destroy kids_e1_asn_accettati_l

end event

