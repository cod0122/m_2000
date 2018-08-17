$PBExportHeader$kuf_meca_qtna.sru
forward
global type kuf_meca_qtna from kuf_parent
end type
end forward

global type kuf_meca_qtna from kuf_parent
end type
global kuf_meca_qtna kuf_meca_qtna

type variables
private st_tab_meca_qtna	kist_tab_meca_qtna
private datastore kids_meca_qtna_note
private w_meca_qtna_note kiw_meca_qta_note 

private uo_d_std_1 kiuo_d_std_1

private boolean ki_conferma_note = false
private w_meca_qtna_note kiw_meca_qtna_note


private constant string kk_stampa_ddt_dicitura_SI = "S"
private constant string kk_stampa_ddt_dicitura_NO = "N"

end variables

forward prototypes
public function boolean tb_delete (st_tab_meca_qtna kst_tab_meca_qtna) throws uo_exception
public function boolean tb_add (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public subroutine if_isnull (st_tab_meca_qtna ast_tab_meca_qtna)
public function boolean tb_update (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function long get_id_meca_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean aggiorna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_esiste (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean apri (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean chiudi (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_aperta (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean set_apri_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean set_note (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_giaaperta (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean set_riapri_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public subroutine u_attiva_window_note (graphicobject a_obj)
public subroutine u_attiva_window_note (st_tab_meca_qtna ast_tab_meca_qtna, st_open_w ast_open_w) throws uo_exception
public subroutine set_conferma_note (boolean a_conferma_note)
public function boolean get_conferma_note ()
public function w_meca_qtna_note get_window_note_aperta ()
private subroutine u_open_window_note (ref st_tab_meca_qtna ast_tab_meca_qtna, ref st_open_w ast_open_w)
public function boolean set_stampa_ddt_dicitura (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public subroutine u_rimuovi () throws uo_exception
public subroutine u_scrivi_note () throws uo_exception
public subroutine u_retrieve_meca_qtna_note () throws uo_exception
public subroutine set_window (ref w_meca_qtna_note aw_meca_qta_note)
public subroutine set_dw (ref uo_d_std_1 auo_d_std_1)
public function boolean chiudi_no_ifsicurezza (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
private function boolean set_chiudi_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_stampa_nel_ddt (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_stampa_ddt_dicitura (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_rimozione_ok (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean get_dati_fine (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean u_rimuovi_ok () throws uo_exception
public function long get_id_meca (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function boolean if_consenti_apri (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_meca_qtna kst_tab_meca_qtna)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean chiudi_rimuovi_dati_no_ifsicurezza (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_meca_qtna kst_tab_meca_qtna) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella meca_qtna
//--- 
//--- Input: st_tab_meca_qtna.id_meca_qtna
//--- Ritorna TRUE=CANCELLATO
//---   
//--- Lancia EXCEPTION        	
//---           	
//--------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
boolean k_autorizza


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//	kst_open_w.id_programma = get_id_programma (kkg_flag_modalita.cancellazione) //kkg_id_programma_contratti_co
	
	//--- controlla se utente autorizzato alla funzione in atto
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Evento quarantena su lotto' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

	if kst_tab_meca_qtna.id_meca_qtna > 0 then

		delete from meca_qtna
			where id_meca_qtna = :kst_tab_meca_qtna.id_meca_qtna
			using kguo_sqlca_db_magazzino ;
		if kst_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if		
		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Evento quarantena su lotto' (meca_qtna):" + trim(sqlca.SQLErrText)
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
			if kst_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_qtna.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_qtna.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
			k_return = TRUE    //OK CANCELLATO
			
		end if
	end if


return k_return

end function

public function boolean tb_add (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	if if_sicurezza(kkg_flag_modalita.inserimento) then // ,"Inserimento 'Evento quarantena su lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		  //id_meca_qtna, 
		  INSERT INTO meca_qtna  
				(   
				  id_meca,   
				  x_data_inizio,   
				  x_utente_inizio,   
				  x_data_fine,   
				  x_utente_fine,   
				  x_data_riapri,   
				  x_utente_riapri,   
 				  stampa_ddt_dicitura,
				  note,   
				  x_datins,   
				  x_utente)  
	  VALUES (   
				  :ast_tab_meca_qtna.id_meca,   
				  :ast_tab_meca_qtna.x_data_inizio,   
				  :ast_tab_meca_qtna.x_utente_inizio,   
				  :ast_tab_meca_qtna.x_data_fine,   
				  :ast_tab_meca_qtna.x_utente_fine,   
				  :ast_tab_meca_qtna.x_data_riapri,   
				  :ast_tab_meca_qtna.x_utente_riapri,   
				  :ast_tab_meca_qtna.stampa_ddt_dicitura,
				  :ast_tab_meca_qtna.note,   
				  :ast_tab_meca_qtna.x_datins,   
				  :ast_tab_meca_qtna.x_utente )  
		USING kguo_sqlca_db_magazzino;
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Inserimento Quarantena~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine if_isnull (st_tab_meca_qtna ast_tab_meca_qtna);
if isnull(ast_tab_meca_qtna.id_meca) then ast_tab_meca_qtna.id_meca = 0
if isnull(ast_tab_meca_qtna.id_meca_qtna ) then ast_tab_meca_qtna.id_meca_qtna = 0
if isnull(ast_tab_meca_qtna.note ) then ast_tab_meca_qtna.note = ""
if isnull(ast_tab_meca_qtna.x_data_fine ) then ast_tab_meca_qtna.x_data_fine = datetime(KKG.DATA_ZERO)
if isnull(ast_tab_meca_qtna.x_data_inizio ) then ast_tab_meca_qtna.x_data_inizio = datetime(KKG.DATA_ZERO)
if isnull(ast_tab_meca_qtna.x_datins ) then ast_tab_meca_qtna.x_datins = datetime(KKG.DATA_ZERO)
if isnull(ast_tab_meca_qtna.x_data_riapri ) then ast_tab_meca_qtna.x_data_riapri = datetime(KKG.DATA_ZERO)
if isnull(ast_tab_meca_qtna.x_utente ) then ast_tab_meca_qtna.x_utente = ""
if isnull(ast_tab_meca_qtna.x_utente_fine ) then ast_tab_meca_qtna.x_utente_fine = ""
if isnull(ast_tab_meca_qtna.x_utente_inizio ) then ast_tab_meca_qtna.x_utente_inizio = ""
if isnull(ast_tab_meca_qtna.x_utente_riapri ) then ast_tab_meca_qtna.x_utente_riapri = ""
if isnull(ast_tab_meca_qtna.stampa_ddt_dicitura ) then ast_tab_meca_qtna.stampa_ddt_dicitura = ""

end subroutine

public function boolean tb_update (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
try
	if if_sicurezza(kkg_flag_modalita.inserimento) then // ,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		  
		UPDATE meca_qtna  
				 SET x_data_inizio = :ast_tab_meca_qtna.x_utente_inizio,   
					  x_utente_inizio = :ast_tab_meca_qtna.x_utente_inizio,   
					  x_data_fine = :ast_tab_meca_qtna.x_data_fine,   
					  x_utente_fine = :ast_tab_meca_qtna.x_utente_fine,   
					  note = :ast_tab_meca_qtna.note,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente,
					  x_data_riapri = :ast_tab_meca_qtna.x_data_riapri,
					  x_utente_riapri = :ast_tab_meca_qtna.x_utente_riapri
		WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		USING kguo_sqlca_db_magazzino;
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento Quarantena~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function long get_id_meca_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna ID quarantena 
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:                   
//=== Ritorna long contenente l'id quarantena
//===           		  
//====================================================================
st_esito kst_esito
long	k_id_meca_qtna


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT a.id_meca_qtna
INTO :k_id_meca_qtna
FROM meca_qtna a
where a.id_meca = :ast_tab_meca_qtna.id_meca
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Quarantena~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if


return k_id_meca_qtna



end function

public function boolean aggiorna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;boolean	k_return = false

try
	ast_tab_meca_qtna.id_meca_qtna =  get_id_meca_qtna( ast_tab_meca_qtna)
	if ast_tab_meca_qtna.id_meca_qtna > 0 then
//		if if_esiste(ast_tab_meca_qtna) then
		tb_update(ast_tab_meca_qtna )
	else
		tb_add( ast_tab_meca_qtna)
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception
end try


return k_return
end function

public function boolean if_esiste (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se c'è il record quarantena 
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:                   
//=== Ritorna true se trova almeno un id quarantena per id meca passato
//===           		  
//====================================================================

boolean	k_return = false


st_esito kst_esito
long	k_esiste


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT count(a.id_meca_qtna)
INTO :k_esiste
FROM meca_qtna a
where a.id_meca = :ast_tab_meca_qtna.id_meca
using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore controllo esistenza Quarantena~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_esiste>0 then	k_return = true

return k_return
end function

public function boolean apri (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Apre la quarantena
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output: st_tab_meca_qtna                  
//=== Ritorna true se ok
//===           		  
//====================================================================
//st_tab_meca_qtna ast_tab_meca_qtna
boolean k_return = false


try 
	if_isnull(ast_tab_meca_qtna )
	
	ast_tab_meca_qtna.id_meca_qtna =  get_id_meca_qtna( ast_tab_meca_qtna)
	
	if if_giaaperta(ast_tab_meca_qtna) then
		
		ast_tab_meca_qtna.x_data_riapri = kGuf_data_base.prendi_x_datins( )
		ast_tab_meca_qtna.x_utente_riapri= kGuf_data_base.prendi_x_utente( )

		k_return = set_riapri_qtna(ast_tab_meca_qtna)

	else
		ast_tab_meca_qtna.x_data_inizio = kGuf_data_base.prendi_x_datins( )
		ast_tab_meca_qtna.x_utente_inizio = kGuf_data_base.prendi_x_utente( )

		if if_esiste(ast_tab_meca_qtna) then
			k_return = set_apri_qtna(ast_tab_meca_qtna)
		else
			ast_tab_meca_qtna.stampa_ddt_dicitura = kk_stampa_ddt_dicitura_SI  
			k_return = tb_add(ast_tab_meca_qtna)
		end if
	
	
	end if
	
	


	

catch (uo_exception kuo_exception)
	throw kuo_exception
end try

return k_return


end function

public function boolean chiudi (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Chiudi la quarantena
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output: st_tab_meca_qtna                  
//=== Ritorna true se ok
//===           		  
//====================================================================

boolean k_return = false


try 
	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then

		k_return=chiudi_no_ifsicurezza(ast_tab_meca_qtna)
		
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
end try

return k_return


end function

public function boolean if_aperta (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se il record quarantena già aperto
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:                   
//=== Ritorna true se aperto
//===           		  
//====================================================================

boolean	k_return = false


st_esito kst_esito
long	k_esiste


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT count(a.id_meca_qtna)
INTO :k_esiste
FROM meca_qtna a
where a.id_meca = :ast_tab_meca_qtna.id_meca
AND (a.x_utente_fine IS NULL OR TRIM(x_utente_fine) = '' )
using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore controllo esistenza Quarantena~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_esiste>0 then	k_return = true

return k_return
end function

public function boolean set_apri_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

//"Cancellazione 'Evento quarantena su lotto' non Autorizzata:

	
try
//	if if_sicurezza(kkg_flag_modalita.inserimento) then // ,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then
	if if_consenti_apri(ast_tab_meca_qtna) then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		ast_tab_meca_qtna.x_utente_fine = ''
		ast_tab_meca_qtna.x_data_fine = datetime(KKG.DATA_ZERO)
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		
		UPDATE meca_qtna  
				 SET x_data_inizio = :ast_tab_meca_qtna.x_utente_inizio,   
					  x_utente_inizio = :ast_tab_meca_qtna.x_utente_inizio,   
					  x_data_fine = :ast_tab_meca_qtna.x_data_fine,   
					  x_utente_fine =  :ast_tab_meca_qtna.x_utente_fine,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente
			 WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		      USING kguo_sqlca_db_magazzino;
				
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Apertura Quarantena~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function boolean set_note (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
//boolean k_autorizza

//"Cancellazione 'Evento quarantena su lotto' non Autorizzata:

	
try
	if if_sicurezza(kkg_flag_modalita.inserimento) then // ,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		  
		UPDATE meca_qtna  
				 SET 
					  note = :ast_tab_meca_qtna.note,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente  
			 WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		USING kguo_sqlca_db_magazzino;
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento Note Quarantena~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function boolean if_giaaperta (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se c'è il record quarantena 
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:                   
//=== Ritorna true se il lotto è già stato messo in quarantena
//===           		  
//====================================================================

boolean	k_return = false


st_esito kst_esito
string	k_x_utente_inzio


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT a.x_utente_inizio
INTO :k_x_utente_inzio
FROM meca_qtna a
where a.id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore controllo Quarantena già aperta~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if len(trim(k_x_utente_inzio)) > 0 then k_return = true 

return k_return
end function

public function boolean set_riapri_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

//"Cancellazione 'Evento quarantena su lotto' non Autorizzata:

	
try
//	if if_sicurezza(kkg_flag_modalita.inserimento) then //,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then
	if if_consenti_apri(ast_tab_meca_qtna) then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		ast_tab_meca_qtna.x_utente_fine = ''
		ast_tab_meca_qtna.x_data_fine = datetime(KKG.DATA_ZERO)
		
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		  
		UPDATE meca_qtna  
				 SET x_data_riapri = :ast_tab_meca_qtna.x_data_riapri,   
					  x_utente_riapri = :ast_tab_meca_qtna.x_utente_riapri,   
					  x_data_fine = :ast_tab_meca_qtna.x_data_fine,   
					  x_utente_fine =  :ast_tab_meca_qtna.x_utente_fine,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente  
			 WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		USING kguo_sqlca_db_magazzino;
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Apertura Quarantena~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine u_attiva_window_note (graphicobject a_obj);
end subroutine

public subroutine u_attiva_window_note (st_tab_meca_qtna ast_tab_meca_qtna, st_open_w ast_open_w) throws uo_exception;// 
// Attiva la window per gestire le note di quarantena lotto
// Input
//		st_tab_meca_qtna.id_meca_qta
//		st_open_w.flag_modalita

								
//kds_meca_qtna_note = create datastore


try
	ast_tab_meca_qtna.id_meca_qtna = get_id_meca_qtna( ast_tab_meca_qtna)
		
	u_open_window_note( ast_tab_meca_qtna, ast_open_w)
catch (uo_exception kuo_exception)
	throw kuo_exception
end try 
end subroutine

public subroutine set_conferma_note (boolean a_conferma_note);ki_conferma_note = a_conferma_note
end subroutine

public function boolean get_conferma_note ();return ki_conferma_note
end function

public function w_meca_qtna_note get_window_note_aperta ();return kiw_meca_qtna_note
end function

private subroutine u_open_window_note (ref st_tab_meca_qtna ast_tab_meca_qtna, ref st_open_w ast_open_w);st_open_w				kst_open_w
kuf_menu_window		kuf1_menu_window



kist_tab_meca_qtna = ast_tab_meca_qtna

kst_open_w.flag_primo_giro = "S"
kst_open_w.flag_modalita = ast_open_w.flag_modalita
kst_open_w.id_programma = this.get_id_programma( kst_open_w.flag_modalita)
kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
kst_open_w.flag_leggi_dw = " "
kst_open_w.flag_cerca_in_lista = " "
choose case kst_open_w.flag_modalita 
	case kkg_flag_modalita.visualizzazione
		kst_open_w.key1 = "Visualizzazione note"
	case kkg_flag_modalita.modifica
		kst_open_w.key1 = "Aggiornamento note"
end choose

kst_open_w.key12_any = this

kuf1_menu_window = create kuf_menu_window 
kuf1_menu_window.open_w_tabelle(kst_open_w)
destroy kuf1_menu_window
								


end subroutine

public function boolean set_stampa_ddt_dicitura (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


	
try
	if if_sicurezza(kkg_flag_modalita.inserimento) then // ,"Modifica 'Quarantena del Lotto' non Autorizzata:") then

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		if len(trim(ast_tab_meca_qtna.stampa_ddt_dicitura)) = 0 then ast_tab_meca_qtna.stampa_ddt_dicitura = kk_stampa_ddt_dicitura_SI  
		  
		UPDATE meca_qtna  
				 SET 
					  stampa_ddt_dicitura = :ast_tab_meca_qtna.stampa_ddt_dicitura,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente  
			 WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		USING kguo_sqlca_db_magazzino;
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore aggiornamento 'Quarantena' il campo di stampa dicitura nel d.d.t. ~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine u_rimuovi () throws uo_exception;//w_meca_qtna_note aw_meca_qtna_note1

try
	if isvalid(kiuo_d_std_1) then
		kids_meca_qtna_note.reset( )
		if kiuo_d_std_1.rowcount() > 0 then
			kids_meca_qtna_note.insertrow( 0)
			kids_meca_qtna_note.setitem( 1, "id_meca_qtna", kiuo_d_std_1.getitemnumber( 1, "id_meca_qtna") )
		end if
		
		if kids_meca_qtna_note.rowcount( ) > 0 then	
			kist_tab_meca_qtna.id_meca_qtna = kids_meca_qtna_note.getitemnumber(1,"id_meca_qtna")
			if kist_tab_meca_qtna.id_meca_qtna > 0 then
				kist_tab_meca_qtna.st_tab_g_0.esegui_commit = "S"
				tb_delete(kist_tab_meca_qtna)
			end if
		end if
	end if	
	
catch(uo_exception kuo_exception)
	throw kuo_exception

end try






end subroutine

public subroutine u_scrivi_note () throws uo_exception;//
try
	if isvalid(kiuo_d_std_1) then
		kids_meca_qtna_note.reset( )
		if ki_conferma_note and kiuo_d_std_1.rowcount() > 0 then
			kids_meca_qtna_note.insertrow( 0)
			kids_meca_qtna_note.setitem( 1, "stampa_ddt_dicitura", kiuo_d_std_1.getitemstring( 1, "stampa_ddt_dicitura") )
			kids_meca_qtna_note.setitem( 1, "note", kiuo_d_std_1.getitemstring( 1, "note") )
			kids_meca_qtna_note.setitem( 1, "id_meca_qtna", kiuo_d_std_1.getitemnumber( 1, "id_meca_qtna") )
		end if
		
		if kids_meca_qtna_note.rowcount( ) > 0 then	
			kist_tab_meca_qtna.note = trim(kids_meca_qtna_note.getitemstring(1,"note"))
			kist_tab_meca_qtna.id_meca_qtna = kids_meca_qtna_note.getitemnumber(1,"id_meca_qtna")
			kist_tab_meca_qtna.st_tab_g_0.esegui_commit = "S"
			set_note(kist_tab_meca_qtna)
			kist_tab_meca_qtna.stampa_ddt_dicitura = trim(kids_meca_qtna_note.getitemstring(1,"stampa_ddt_dicitura"))
			kist_tab_meca_qtna.id_meca_qtna = kids_meca_qtna_note.getitemnumber(1,"id_meca_qtna")
			kist_tab_meca_qtna.st_tab_g_0.esegui_commit = "S"
			set_stampa_ddt_dicitura(kist_tab_meca_qtna)
		end if
	end if	
	
catch(uo_exception kuo_exception)
	throw kuo_exception

end try






end subroutine

public subroutine u_retrieve_meca_qtna_note () throws uo_exception;


try
	if isvalid(kiuo_d_std_1) then
		kist_tab_meca_qtna.id_meca_qtna = get_id_meca_qtna( kist_tab_meca_qtna)
		kiuo_d_std_1.settransobject(sqlca)
		kids_meca_qtna_note = create datastore
		if kiuo_d_std_1.retrieve(kist_tab_meca_qtna.id_meca_qtna ) > 0 then		
			kids_meca_qtna_note.dataobject = kiuo_d_std_1.dataobject
			kiuo_d_std_1.rowscopy(1, kiuo_d_std_1.RowCount(), Primary!, kids_meca_qtna_note, 1, Primary!)
		else
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Aprire prima la Quarantena. Quarantena non aperta (ID:" + String(kist_tab_meca_qtna.id_meca) + ").")
			throw kguo_exception
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception
end try
end subroutine

public subroutine set_window (ref w_meca_qtna_note aw_meca_qta_note);//
kiw_meca_qta_note = aw_meca_qta_note
end subroutine

public subroutine set_dw (ref uo_d_std_1 auo_d_std_1);//
kiuo_d_std_1 = auo_d_std_1
end subroutine

public function boolean chiudi_no_ifsicurezza (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Chiudi la quarantena senza controllo SICUREZZA
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output: st_tab_meca_qtna                  
//=== Ritorna true se ok
//===           		  
//====================================================================

boolean k_return = false


try 

	if_isnull(ast_tab_meca_qtna )

	ast_tab_meca_qtna.id_meca_qtna =  get_id_meca_qtna( ast_tab_meca_qtna)

	if ast_tab_meca_qtna.id_meca_qtna > 0 then
		ast_tab_meca_qtna.x_data_fine = kGuf_data_base.prendi_x_datins( )
		ast_tab_meca_qtna.x_utente_fine = kGuf_data_base.prendi_x_utente( )
		
		if if_esiste(ast_tab_meca_qtna) then
			k_return = set_chiudi_qtna(ast_tab_meca_qtna)
		else
	//		k_return = tb_add(ast_tab_meca_qtna)
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
end try

return k_return


end function

private function boolean set_chiudi_qtna (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;// funzione che fa l'insert sulla tabella meca_qtna
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

//"Cancellazione 'Evento quarantena su lotto' non Autorizzata:

	
try
//	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Modifica 'Evento quarantena su lotto' non Autorizzata:") then

//04082014 NON RICORDO QUANDO POSSO CHIUDERLA 	if if_consenti_apri(ast_tab_meca_qtna) then   
 	if if_aperta(ast_tab_meca_qtna) then   

	//--- imposto dati utente e data aggiornamento
		ast_tab_meca_qtna.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_meca_qtna.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_meca_qtna)
		  
		UPDATE meca_qtna  
				 SET
					  x_data_fine = :ast_tab_meca_qtna.x_data_fine,   
					  x_utente_fine = :ast_tab_meca_qtna.x_utente_fine,   
					  x_datins = :ast_tab_meca_qtna.x_datins,   
					  x_utente = :ast_tab_meca_qtna.x_utente  
			 WHERE id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
		USING kguo_sqlca_db_magazzino;
		if ast_tab_meca_qtna.st_tab_g_0.esegui_commit <>"N" or isnull(ast_tab_meca_qtna.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Chiusura Quarantena~n~r" + trim(sqlca.SQLErrText) 
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
	end if
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public function boolean if_stampa_nel_ddt (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se il record quarantena può essere stampato nel ddt
//=== 
//=== Input: st_tab_meca_qtna.id_meca_qtna     
//=== Output:                   
//=== Ritorna: true = ok può essere stampato
//===           		  
//====================================================================
//
boolean	k_return = false



if if_esiste(ast_tab_meca_qtna) then
		
	if if_aperta(ast_tab_meca_qtna) then

		if if_stampa_ddt_dicitura(ast_tab_meca_qtna) then
			
			k_return = true
			
		end if
	end if
end if

return k_return
end function

public function boolean if_stampa_ddt_dicitura (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se stampare la dicitura sul DDT 
//=== 
//=== Input: st_tab_meca_qtna.id_meca_qtna     
//=== Output: st_tab_meca_qtna.stampa_ddt_dicitura                  
//=== Ritorna: TRUE ok flag da stampare
//===           		  
//====================================================================
boolean k_return = false
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT a.stampa_ddt_dicitura
INTO :ast_tab_meca_qtna.stampa_ddt_dicitura
FROM meca_qtna a
where a.id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Quarantena 'flag stampa_ddt_dicitura'~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if ast_tab_meca_qtna.stampa_ddt_dicitura = kk_stampa_ddt_dicitura_SI then k_return = true

return k_return



end function

public function boolean if_rimozione_ok (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se il record quarantena può essere RIMOSSO
//=== 
//=== Input: st_tab_meca_qtna.id_meca_qtna     
//=== Output:                   
//=== Ritorna: true = ok può essere rimosso
//===           		  
//====================================================================
//
boolean	k_return = false


if ast_tab_meca_qtna.id_meca_qtna > 0 then
	if ast_tab_meca_qtna.id_meca > 0 then
	else
		ast_tab_meca_qtna.id_meca = get_id_meca(ast_tab_meca_qtna)
	end if
	
	if if_esiste(ast_tab_meca_qtna) then
			
		if not get_dati_fine(ast_tab_meca_qtna) then
	
			k_return = true
				
		end if
	end if
end if

return k_return
end function

public function boolean get_dati_fine (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna dati di fine  quarantena 
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:  data_fine + utente_fine                 
//=== Ritorna TRUE dati fine presenti
//===           		  
//====================================================================
st_esito kst_esito
boolean k_return = false


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT x_data_fine
		,x_utente_fine 
INTO :ast_tab_meca_qtna.x_data_fine,   
		:ast_tab_meca_qtna.x_utente_fine
FROM meca_qtna a
where a.id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura dati di fine Quarantena ~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if len(trim(ast_tab_meca_qtna.x_utente_fine)) > 0 then k_return = true

return k_return



end function

public function boolean u_rimuovi_ok () throws uo_exception;//---
//--- TRUE=è posibile rimuovere questa Quarantena
//---
boolean k_return = false
st_tab_meca_qtna kst_tab_meca_qtna


try
	
	if isvalid(kiuo_d_std_1) then
		if kiuo_d_std_1.rowcount() > 0 then
			kst_tab_meca_qtna.id_meca_qtna = kiuo_d_std_1.getitemnumber( 1, "id_meca_qtna")
			if if_rimozione_ok(kst_tab_meca_qtna) then
				k_return = true
			end if
		end if
	end if
	
catch(uo_exception kuo_exception)
	throw kuo_exception

end try


return k_return



end function

public function long get_id_meca (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna ID_MECA più grande della quarantena 
//=== 
//=== Input: st_tab_meca_qtna.id_meca_qtna     
//=== Output:                   
//=== Ritorna long contenente l'id_mca massimo
//===           		  
//====================================================================
st_esito kst_esito
long	k_id_meca


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT max(a.id_meca)
INTO :k_id_meca
FROM meca_qtna a
where a.id_meca_qtna = :ast_tab_meca_qtna.id_meca_qtna
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura id lotto in tab. Quarantena id " + string(ast_tab_meca_qtna.id_meca_qtna) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if


return k_id_meca



end function

public function boolean if_consenti_apri (st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Torna se quarantena puo' essere aperta
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output:                   
//=== Ritorna true se OK da aprire
//===           		  
//====================================================================

boolean	k_return = true
st_tab_certif kst_tab_certif
st_tab_meca kst_tab_meca
kuf_certif kuf1_certif
kuf_armo kuf1_armo
st_esito kst_esito
long	k_esiste

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_armo = create kuf_armo
	kst_tab_meca.id = ast_tab_meca_qtna.id_meca
	if kuf1_armo.if_lotto_dosimetria_rilevata(kst_tab_meca) then
		k_return = false
	end if
	
//	kuf1_certif = create kuf_certif
//	kst_tab_certif.id_meca = ast_tab_meca_qtna.id_meca
//	kst_esito = kuf1_certif.get_num_certif(kst_tab_certif)
//	
//	 if kst_esito.esito = kkg_esito.db_ko then
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito( kst_esito)
//		throw kguo_exception
//	end if
//	
//	if kst_tab_certif.num_certif >0 then k_return = false

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

	
return k_return
end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_meca_qtna kst_tab_meca_qtna);//
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
	kst_esito.nome_oggetto = this.classname()
	
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if kst_tab_meca_qtna.id_meca > 0 then
		
			kdw_anteprima.dataobject = "d_meca_qtna_note_v"		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
			k_rc=kdw_anteprima.retrieve(kst_tab_meca_qtna.id_meca)
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Nota da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

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
st_tab_meca_qtna kst_tab_meca_qtna
st_esito kst_esito
uo_exception kuo_exception
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

	case "b_qtna_note"
		kst_tab_meca_qtna.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_meca_qtna.id_meca > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_meca_qtna )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Note Sped. Quarantena  (nr.=" + trim(string(kst_tab_meca_qtna.id_meca)) + ") " 
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
		kst_open_w.id_programma = kkg_id_programma.elenco
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
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage( "Nessun valore disponibile. " )
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean chiudi_rimuovi_dati_no_ifsicurezza (ref st_tab_meca_qtna ast_tab_meca_qtna) throws uo_exception;//
//====================================================================
//=== Rimuove la Chiusura della quarantena senza controllo SICUREZZA
//=== 
//=== Input: st_tab_meca_qtna.id_meca     
//=== Output: st_tab_meca_qtna                  
//=== Ritorna true se ok
//===           		  
//====================================================================

boolean k_return = false


try 

	if_isnull(ast_tab_meca_qtna )

	ast_tab_meca_qtna.id_meca_qtna =  get_id_meca_qtna( ast_tab_meca_qtna)

	if ast_tab_meca_qtna.id_meca_qtna > 0 then
		ast_tab_meca_qtna.x_data_fine = datetime(kkg.data_zero)
		ast_tab_meca_qtna.x_utente_fine = ""
		
		if if_esiste(ast_tab_meca_qtna) then
			k_return = set_chiudi_qtna(ast_tab_meca_qtna)
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
end try

return k_return


end function

on kuf_meca_qtna.create
call super::create
end on

on kuf_meca_qtna.destroy
call super::destroy
end on

event destructor;call super::destructor;//try
//	if isvalid(kiw_meca_qtna_note) then
//		
//		kiw_meca_qtna_note.set_permetti_chiusura(true)
//		u_close_window_note(kiw_meca_qtna_note )
//	end if
//	
//catch(uo_exception kuo_exception)
//	throw kuo_exception
//end try
end event

