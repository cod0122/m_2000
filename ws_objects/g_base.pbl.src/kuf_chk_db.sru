$PBExportHeader$kuf_chk_db.sru
forward
global type kuf_chk_db from kuf_parent
end type
end forward

global type kuf_chk_db from kuf_parent
end type
global kuf_chk_db kuf_chk_db

type variables
//
private st_monitor_dati_db kist_monitor_dati_db
private kuf_esito_operazioni kiuf_esito_operazioni
private st_tab_esito_operazioni kist_tab_esito_operazioni
end variables

forward prototypes
public function boolean u_monitor_dati_db (ref st_monitor_dati_db ast_monitor_dati_db) throws uo_exception
public function st_monitor_dati_db set_st_monitor_dati_db (ref st_monitor_dati_db ast_monitor_dati_db) throws uo_exception
private subroutine u_log_inizializza () throws uo_exception
private subroutine u_log_destroy ()
private function boolean u_monitor_ddt () throws uo_exception
private function boolean u_monitor_fatture () throws uo_exception
private function boolean u_monitor_meca () throws uo_exception
end prototypes

public function boolean u_monitor_dati_db (ref st_monitor_dati_db ast_monitor_dati_db) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- controlla dati tipo congruenza indici sul DB
//--- inp: st_monitor_dati_db.check_...   se si vuole il controllo indicare TRUE
//--- out: st_monitor_dati_db.esito_check_... TRUE = controllo OK;  FALSE = controllo KO
//--- rit: TRUE = controllo completato
//--------------------------------------------------------------------------------------------------------------
//
boolean k_return = true, k_rc

try
	setpointer(kkg.pointer_attesa)
	
	u_log_inizializza( )

	set_st_monitor_dati_db(ast_monitor_dati_db)  // imposta la struttura di lavoro dell'oggetto
	
	if kist_monitor_dati_db.check_entrate then
		if not u_monitor_meca( ) then
			k_return = false 
		end if
	end if
	
	if kist_monitor_dati_db.check_ddt then
		if not u_monitor_ddt( ) then
			k_return = false 
		end if
	end if
	
	if kist_monitor_dati_db.check_fatture then
		if not u_monitor_fatture( ) then
			k_return = false 
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	kiuf_esito_operazioni.tb_add(kist_tab_esito_operazioni)  // scrive su DB le righe di esito
	u_log_destroy( )
	ast_monitor_dati_db = kist_monitor_dati_db
	setpointer(kkg.pointer_default)

end try

return k_return
end function

public function st_monitor_dati_db set_st_monitor_dati_db (ref st_monitor_dati_db ast_monitor_dati_db) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- imposta struttura oggetto
//--- inp: st_monitor_dati_db   la struttura con i dati
//--- rit: st_monitor_dati_db   torna la vecchia struttura
//--- 
//--------------------------------------------------------------------------------------------------------------
//
st_monitor_dati_db kst_monitor_dati_db 


	kst_monitor_dati_db = kist_monitor_dati_db  // ritorna vecchia struttura
	kist_monitor_dati_db = ast_monitor_dati_db  // imposta la nuova struttura
	
	

return kst_monitor_dati_db
end function

private subroutine u_log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_check_tabelle )


 
end subroutine

private subroutine u_log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

private function boolean u_monitor_ddt () throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo congruenza SPED - ARSP
//--- inp.: valorizzare la struttura st_monitor_dati_db
boolean k_return = true
long k_righe_check_ko=0, k_riga=0
st_esito kst_esito
datastore kds_1


try
	kist_monitor_dati_db.esito_check_ddt	= true
	kiuf_esito_operazioni.tb_add_riga("INIZIO Controlli archivio DDT di Spedizione del periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_sped_numeraz"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_ddt	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE sono stati rilevati dei 'buchi' nella numerazione dei DDT <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, la numerazione dei DDT è completa <--- ", false)
	end if

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_sped"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_ddt	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti DDT con solo la Testata senza righe di dettaglio <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutti i DDT sono completi di Testata e dettaglio <--- ", false)
	end if

	kds_1.dataobject = "d_chk_db_sped_numeraz"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_ddt	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti DDT senza la data Ritiro del materiale <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le righe di dettaglio DDT hanno la data Ritiro Materiale <--- ", false)
	end if

	kds_1.dataobject = "d_chk_db_arsp"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_ddt	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti DDT con le righe di dettaglio ma senza Testata <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le righe di dettaglio DDT hanno la Testata <--- ", false)
	end if

	kds_1.dataobject = "d_chk_db_sped_no_ritiro"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_ddt	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti DDT con le righe di dettaglio ma senza Testata <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le righe di dettaglio DDT hanno la Testata <--- ", false)
	end if
	

catch (uo_exception kuo_exception)
	kist_monitor_dati_db.esito_check_ddt	= false
	kst_esito = kuo_exception.get_st_esito()
	kiuf_esito_operazioni.tb_add_riga("          ---> Errore durante le operazioni di controllo DDT di Spedizione le quali non si sono concluse per il seguente motivo: " + trim(kst_esito.sqlerrtext) + " - codice: " + string(kst_esito.sqlcode) + " <--- ", true)
	throw kuo_exception

finally
	kiuf_esito_operazioni.tb_add_riga("FINE  Controlli archivio DDT di Spedizione del periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)
	kist_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
end try

return k_return 

end function

private function boolean u_monitor_fatture () throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo congruenza ARFA_TESTA - ARFA
//--- inp.: valorizzare la struttura st_monitor_dati_db
boolean k_return = true
long k_righe_check_ko=0, k_riga=0
st_esito kst_esito
datastore kds_1


try
	kist_monitor_dati_db.esito_check_fatture	= true
	kiuf_esito_operazioni.tb_add_riga("INIZIO Controlli archivio FATTURE prodotte nel periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_arfa_testa_numeraz"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		kist_monitor_dati_db.esito_check_fatture	= false
		k_return = false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE sono stati rilevati dei 'buchi' nella numerazione delle Fatture <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, la numerazione delle Fatture è completa <--- ", false)
	end if

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_arfa_testa"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		kist_monitor_dati_db.esito_check_fatture	= false
		k_return = false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono le seguenti Fatture con la Testata ma senza righe di dettaglio <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le Fatture sono complete di Testata e dettaglio <--- ", false)
	end if

	kds_1.dataobject = "d_chk_db_arfa"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		kist_monitor_dati_db.esito_check_fatture	= false
		k_return = false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono le seguenti Fatture con le righe di dettaglio ma senza la Testata <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le righe di dettaglio Fatture hanno la Testata <--- ", false)
	end if
	

catch (uo_exception kuo_exception)
	kist_monitor_dati_db.esito_check_fatture	= false
	kst_esito = kuo_exception.get_st_esito()
	kiuf_esito_operazioni.tb_add_riga("          ---> Errore durante le operazioni di controllo Fatture le quali non si sono concluse per il seguente motivo: " + trim(kst_esito.sqlerrtext) + " - codice: " + string(kst_esito.sqlcode) + " <--- ", true)
	throw kuo_exception

finally
	kiuf_esito_operazioni.tb_add_riga("FINE  Controlli archivio Fatture prodotte nel periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)
	kist_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
end try

return k_return 

end function

private function boolean u_monitor_meca () throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo congruenza MECA - ARMO
//--- inp.: valorizzare la struttura kist_monitor_dati_db
boolean k_return = true
long k_righe_check_ko=0, k_riga=0
st_esito kst_esito
datastore kds_1


try
	kist_monitor_dati_db.esito_check_entrate	= true
	
	kiuf_esito_operazioni.tb_add_riga("INIZIO Controlli archivio Lotti entrati del periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_meca"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_entrate	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti Lotti senza righe di dettaglio <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutti i Lotto sono completi di Testata e dettaglio <--- ", false)
	end if

	kds_1 = create datastore
	kds_1.dataobject = "d_chk_db_meca_no_dataent"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_entrate	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti Lotti senza la Data di entrata merce <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutti i Lotto sono completi di Data di entrata merce <--- ", false)
	end if

	kds_1.dataobject = "d_chk_db_armo"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_entrate	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti Lotti con la presenza delle righe di dettaglio ma senza la Testata <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutte le righe di dettaglio Lotti hanno la Testata <--- ", false)
	end if
	
	kds_1.dataobject = "d_chk_db_barcode"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_entrate	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE ci sono i seguenti Lotti che hanno prodotto dei Barcode di lavorazione ma a cui manca la riga di dettaglio <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutti i Barcode prodotti sono associati alle righe di dettaglio Lotti <--- ", false)
	end if
	
	kds_1.dataobject = "d_chk_db_armo_colli_fatt"
	kds_1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_check_ko = kds_1.retrieve(kist_monitor_dati_db.data_inizio, kist_monitor_dati_db.data_fine)
//--- se ho trovato delle righe vuol dire che ci sono errori	
	if k_righe_check_ko > 0 then
		k_return = false
		kist_monitor_dati_db.esito_check_entrate	= false
		kiuf_esito_operazioni.tb_add_riga("          ---> ATTENZIONE rilevati Lotti di materiale Trattato (magazzino 2) con il numero colli Fatturati maggiore di quelli Entrati  <--- ", true)
		for k_riga = 1 to k_righe_check_ko
			kiuf_esito_operazioni.tb_add_riga("          ---> " + string(k_riga) + ")  " + trim(kds_1.getitemstring(k_riga, "note")) + " <--- ", true)
		next
	else
		kiuf_esito_operazioni.tb_add_riga("          ---> Controllo OK, tutti i Lotti di materiale Trattato (magazzino 2) non hanno più colli Fatturati di quelli Entrati <--- ", false)
	end if

catch (uo_exception kuo_exception)
	kist_monitor_dati_db.esito_check_entrate	= false
	kst_esito = kuo_exception.get_st_esito()
	kiuf_esito_operazioni.tb_add_riga("          ---> Errore durante le operazioni di controllo Lotti le quali non si sono concluse per il seguente motivo: " + trim(kst_esito.sqlerrtext) + " - codice: " + string(kst_esito.sqlcode) + " <--- ", true)
	throw kuo_exception

finally
	kiuf_esito_operazioni.tb_add_riga("FINE  Controlli archivio Lotti entrati del periodo: " + string(kist_monitor_dati_db.data_inizio) + " - " + string(kist_monitor_dati_db.data_fine) + " ", false)
	kist_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
end try

return k_return 

end function

on kuf_chk_db.create
call super::create
end on

on kuf_chk_db.destroy
call super::destroy
end on

