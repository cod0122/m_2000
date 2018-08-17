$PBExportHeader$kuf_memo_utenti.sru
forward
global type kuf_memo_utenti from kuf_parent
end type
end forward

global type kuf_memo_utenti from kuf_parent
end type
global kuf_memo_utenti kuf_memo_utenti

type variables
//--- campo stato
public:
constant int kki_stato_NUOVO = 0 // Nuovo
constant int kki_stato_LETTO = 2 // Letto
constant int kki_stato_RIMOSSO = 8 // memo rimosso e poi da cancellare effettivamente


end variables

forward prototypes
public function boolean tb_delete (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean tb_delete_x_id_memo (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function integer add_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean set_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function integer get_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function long tb_add (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public subroutine if_isnull (ref st_tab_memo_utenti ast_tab_memo_utenti)
public function boolean tb_update (ref st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public subroutine memo_save (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean if_esiste (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean set_stato_letto (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean set_stato (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean set_stato_rimosso (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function long get_id_memo_utente (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean set_stato_nuovo (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean if_letto (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function integer get_stato (ref st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function long get_ult_id_memo_utente () throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella memo_utenti
//--- 
//--- Input: st_tab_memo_utenti.id_id_memo_utente
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_utenti.id_memo_utente > 0 then
	
	delete 
			from memo_utenti
			WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = true	
		
		if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function boolean tb_delete_x_id_memo (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Cancella rek nella tabella memo_utenti di tutti i roferimenti al MEMO 
//--- 
//--- Input: st_tab_memo_utenti.id_id_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//------------------------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_utenti.id_memo > 0 then
	
	delete 
			from memo_utenti
			WHERE id_memo = :ast_tab_memo_utenti.id_memo
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione avvisi MEMO utente (id memo " + string(ast_tab_memo_utenti.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = true	
		
		if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function integer add_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il contatore incerementeto di 1
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente o id_memo + id_sr_utente
//--- Ritorna  contatore 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
integer k_return = 0
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- se non impostato get del id_meca_utente
if ast_tab_memo_utenti.id_memo_utente > 0 then
else
	if ast_tab_memo_utenti.id_memo > 0 and ast_tab_memo_utenti.id_sr_utente > 0 then
		ast_tab_memo_utenti.id_memo_utente = get_id_memo_utente(ast_tab_memo_utenti)
	end if
end if

if ast_tab_memo_utenti.id_memo_utente > 0 then
	
	ast_tab_memo_utenti.contatore = get_contatore(ast_tab_memo_utenti)

	k_return = ast_tab_memo_utenti.contatore + 1
end if		


return k_return

end function

public function boolean set_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Update del campo Contatore
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente e contatore
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_utenti.id_memo_utente > 0 then
	
	update memo_utenti
			set contatore = :ast_tab_memo_utenti.contatore
			WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Aggiornamento Contatore nell'avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = true	
		if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function integer get_contatore (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il campo contatore 
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente 
//--- Ritorna  contatore 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
integer k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- se non impostato get del id_meca_utente
if ast_tab_memo_utenti.id_memo_utente > 0 then
else
	if ast_tab_memo_utenti.id_memo > 0 and ast_tab_memo_utenti.id_sr_utente > 0 then
		ast_tab_memo_utenti.id_memo_utente = get_id_memo_utente(ast_tab_memo_utenti)
	end if
end if

if ast_tab_memo_utenti.id_memo_utente > 0 then
	
	select contatore 
	    into :ast_tab_memo_utenti.contatore
			from memo_utenti
			WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura 'Contatore' da avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = ast_tab_memo_utenti.contatore
	end if
end if		


return k_return

end function

public function long tb_add (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiunge riga in tabella  memo_utenti
//--- 
//--- Input: st_tab_memo_utenti
//--- Ritorna id_memo_utente
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
long k_return = 0
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo_utenti.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo_utenti.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_memo_utenti)
		//  id_memo_utente,
	    INSERT INTO memo_utenti
				 ( 
				  id_memo,
				  id_sr_utente,
				  stato,   
				  contatore,   
				  x_datins,
				  x_utente
				  )
			  VALUES ( 
				  :ast_tab_memo_utenti.ID_MEMO,
				  :ast_tab_memo_utenti.id_sr_utente,
				  :ast_tab_memo_utenti.stato,   
				  :ast_tab_memo_utenti.contatore,   
				  :ast_tab_memo_utenti.x_datins,   
				  :ast_tab_memo_utenti.x_utente
			      )
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento Avvisi MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			//ast_tab_memo_utenti.id_memo_utente = long(kguo_sqlca_db_magazzino.SQLReturnData)
			ast_tab_memo_utenti.id_memo_utente = get_ult_id_memo_utente( ) // get del ID appena generato
		end if
//	end if

		if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine if_isnull (ref st_tab_memo_utenti ast_tab_memo_utenti);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_memo_utenti.id_memo_utente) then ast_tab_memo_utenti.id_memo_utente = 0
if isnull(ast_tab_memo_utenti.stato) then ast_tab_memo_utenti.stato = 0
if isnull(ast_tab_memo_utenti.contatore) then ast_tab_memo_utenti.contatore = 0
if isnull(ast_tab_memo_utenti.id_sr_utente) then ast_tab_memo_utenti.id_sr_utente = 0
if isnull(ast_tab_memo_utenti.id_memo) then ast_tab_memo_utenti.id_memo = 0

if isnull(ast_tab_memo_utenti.x_datins) then	ast_tab_memo_utenti.x_datins = datetime(date(0))
if isnull(ast_tab_memo_utenti.x_utente) then	ast_tab_memo_utenti.x_utente = ""




end subroutine

public function boolean tb_update (ref st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna tabella  MEMO_LINK 
//--- 
//--- Input: st_tab_memo_link.id_memo_utente
//--- Ritorna TRUE = OK
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo_utenti.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo_utenti.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_memo_utenti)
		  
		UPDATE memo_utenti  
				 SET
					  stato = :ast_tab_memo_utenti.stato,  
					  contatore = :ast_tab_memo_utenti.contatore,   
					  x_datins = :ast_tab_memo_utenti.x_datins,   
					  x_utente = :ast_tab_memo_utenti.x_utente
		WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento Avvisi MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if
		
		if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine memo_save (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--- Salva dati Avvisi MEMO per questo Utente
//
st_esito kst_esito


try   


	if if_esiste(ast_tab_memo_utenti) then
//		ast_tab_memo_utenti.contatore = get_contatore(ast_tab_memo_utenti)
//		tb_update(ast_tab_memo_utenti)
	else
//--- se l'utente è uguale a quello dell'Avviso che vado ad aggiornare allora metto subito il contatore a UNO		
		if ast_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( ) then
			ast_tab_memo_utenti.contatore = 1
		else
			ast_tab_memo_utenti.contatore = 0
		end if
		ast_tab_memo_utenti.id_memo_utente = 0
		ast_tab_memo_utenti.stato = kki_stato_nuovo
		tb_add(ast_tab_memo_utenti)
	end if

catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

public function boolean if_esiste (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Verifica se Avviso Memo già caricato
//--- 
//--- Input: st_tab_memo_utenti.id_memo + id_sr_utente
//--- Ritorna  TRUE=esiste; FALSE=non esiste 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_memo_utenti.id_memo > 0 then
	
	select id_memo
	    into :ast_tab_memo_utenti.id_memo
			from memo_utenti
			WHERE id_memo = :ast_tab_memo_utenti.id_memo
			            and id_sr_utente = :ast_tab_memo_utenti.id_sr_utente
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura 'Contatore' da avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		if ast_tab_memo_utenti.id_memo > 0 then
			k_return = true  // MEMO TROVATO
		end if
	end if
end if		


return k_return

end function

public function boolean set_stato_letto (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna lo statto a LETTO per il MEMO + UTENTE
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente 
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn



// posso aggiornare solo se lo stato è minore dello stato di GIA' LETTO (ad es. non posso aggiornare lostato 8 = rimosso)	
	ast_tab_memo_utenti.stato = get_stato(ast_tab_memo_utenti)
	if ast_tab_memo_utenti.stato < kki_stato_LETTO then 
		
		ast_tab_memo_utenti.stato = kki_stato_LETTO
		
		k_return = set_stato(ast_tab_memo_utenti)
		
	end if



return k_return

end function

public function boolean set_stato (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna lo statto a LETTO per il MEMO + UTENTE
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente e stato
//--- Ritorna: TRUE = aggiornato 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- se non impostato get del id_meca_utente
	if ast_tab_memo_utenti.id_memo_utente > 0 then
	else
		if ast_tab_memo_utenti.id_memo > 0 and ast_tab_memo_utenti.id_sr_utente > 0 then
			ast_tab_memo_utenti.id_memo_utente = get_id_memo_utente(ast_tab_memo_utenti)
		end if
	end if

	if ast_tab_memo_utenti.id_memo_utente > 0 and not isnull(ast_tab_memo_utenti.stato) then
	
		update memo_utenti
				set stato = :ast_tab_memo_utenti.stato
				WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente 
				using kguo_sqlca_db_magazzino;
				
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento Stato nell'avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 
	
				if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
	
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true	
			if ast_tab_memo_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_utenti.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if





return k_return

end function

public function boolean set_stato_rimosso (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna lo statto a RIMOSSO per il MEMO + UTENTE
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente 
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn



// posso aggiornare solo se lo stato è minore dello stato di RIMOSSO 
	ast_tab_memo_utenti.stato = get_stato(ast_tab_memo_utenti)
	if ast_tab_memo_utenti.stato < kki_stato_rimosso then 
		
		ast_tab_memo_utenti.stato = kki_stato_rimosso
		
		k_return = set_stato(ast_tab_memo_utenti)
		
	end if



return k_return

end function

public function long get_id_memo_utente (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna id_memo_utente
//--- 
//--- Input: st_tab_memo_utenti.id_memo + id_sr_utente
//--- Ritorna  id_memo_utente 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
integer k_return = 0
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_utenti.id_memo > 0 then
	
	select id_memo_utente 
	    into :ast_tab_memo_utenti.id_memo_utente
			from memo_utenti
			WHERE id_memo = :ast_tab_memo_utenti.id_memo
			    and id_sr_utente = :ast_tab_memo_utenti.id_sr_utente 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura ID da avviso MEMO utente (id memo " + string(ast_tab_memo_utenti.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = ast_tab_memo_utenti.id_memo_utente
	end if


end if



return k_return

end function

public function boolean set_stato_nuovo (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna lo statto a LETTO per il MEMO + UTENTE
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente 
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn



// posso aggiornare solo se lo stato è minore dello stato di GIA' LETTO (ad es. non posso aggiornare lostato 8 = rimosso)	
	ast_tab_memo_utenti.stato = get_stato(ast_tab_memo_utenti)
		
	ast_tab_memo_utenti.stato = kki_stato_nuovo
	
	k_return = set_stato(ast_tab_memo_utenti)
		



return k_return

end function

public function boolean if_letto (st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Verifica se Avviso Memo già letto da almeno un utente
//--- 
//--- Input: st_tab_memo_utenti.id_memo 
//--- Ritorna  TRUE=letto; FALSE=mai letto 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_memo_utenti.id_memo > 0 then

	ast_tab_memo_utenti.stato = kki_stato_nuovo
	
	select distinct id_memo
	    into :ast_tab_memo_utenti.id_memo
			from memo_utenti
			WHERE id_memo = :ast_tab_memo_utenti.id_memo
			            and stato <> :ast_tab_memo_utenti.stato
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura 'Stato Letto' da avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		if ast_tab_memo_utenti.id_memo > 0 then
			k_return = true  // MEMO LETTO
		end if
	end if
end if		


return k_return

end function

public function integer get_stato (ref st_tab_memo_utenti ast_tab_memo_utenti) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il campo STATO 
//--- 
//--- Input: st_tab_memo_utenti.id_memo_utente 
//--- Ritorna  STATO 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
int k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- se non impostato get del id_meca_utente
if ast_tab_memo_utenti.id_memo_utente > 0 then
else
	if ast_tab_memo_utenti.id_memo > 0 and ast_tab_memo_utenti.id_sr_utente > 0 then
		ast_tab_memo_utenti.id_memo_utente = get_id_memo_utente(ast_tab_memo_utenti)
	end if
end if

if ast_tab_memo_utenti.id_memo_utente > 0 then
	
	select stato 
	    into :ast_tab_memo_utenti.stato
			from memo_utenti
			WHERE id_memo_utente = :ast_tab_memo_utenti.id_memo_utente
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura 'Stato' da avviso MEMO utente (id memo utente " + string(ast_tab_memo_utenti.id_memo_utente) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		k_return = ast_tab_memo_utenti.stato
	end if
end if		


return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

public function long get_ult_id_memo_utente () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID_MEMO inserito
//=== 
//=== Input: 
//=== Output:                   
//=== Ritorna long contenente l'id_memo
//===           		  
//====================================================================
st_esito kst_esito
long	k_id_memo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT max(id_memo_utente)
INTO :k_id_memo
FROM memo_utenti
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura ultimo id caricato in tab. MEMO " + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if isnull(k_id_memo) then k_id_memo = 0

return k_id_memo



end function

on kuf_memo_utenti.create
call super::create
end on

on kuf_memo_utenti.destroy
call super::destroy
end on

