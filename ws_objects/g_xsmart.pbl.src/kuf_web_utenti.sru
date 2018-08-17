$PBExportHeader$kuf_web_utenti.sru
forward
global type kuf_web_utenti from kuf_parent
end type
end forward

global type kuf_web_utenti from kuf_parent
end type
global kuf_web_utenti kuf_web_utenti

type variables
//
// LOG Esito Operazioni
public kuf_esito_operazioni kiuf_esito_operazioni

protected kuo_sqlca_db_xweb kiuo_sqlca_db_xweb

// campo STATO
public constant string ki_stato_bloccato = "0"
public constant string ki_stato_attivo = "1"

// campo STATOWEB
public constant string ki_statoweb_dapubblicare = "1"
public constant string ki_statoweb_nonpubblicare = "3"   //o null   stato di default
public constant string ki_statoweb_pubblicato = "7"
//

// campo FLAG_xx in tab web_ruoli
public constant string ki_flag_pl_si = "1" 
public constant string ki_flag_rt_si = "1" 
public constant string ki_flag_ad_si = "1" 


end variables

forward prototypes
public function long if_ultimo_utente_x_id_ruolo (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function boolean tb_delete (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function string get_nome (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function string get_nome_da_idcliente (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function long get_ultimo_cliente (ref st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean if_isnull (ref st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function boolean if_esiste_username (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function boolean set_statoweb (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception
public function long u_web_pubblica (ref st_tab_web_utenti kst_tab_web_utenti[], st_web_pubblica kst_web_pubblica) throws uo_exception
public subroutine log_inizializza () throws uo_exception
public subroutine log_destroy () throws uo_exception
private function long web_add (ref st_tab_web_utenti kst_tab_web_utenti[]) throws uo_exception
public function long if_ultimo_folder_x_id_web_ruolo (readonly st_tab_web_folder kst_tab_web_folder) throws uo_exception
protected function boolean web_db_crea_tabella () throws uo_exception
end prototypes

public function long if_ultimo_utente_x_id_ruolo (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//	
//====================================================================
//=== Torna se esiste il idutente Web piu' grande gla associato al id_web_ruolo 
//=== 
//=== Input: st_tab_web_utenti.id_web_ruolo 
//=== ritorna: 
//=== Output: ZERO=non trovato, altrimenti l'ultimo idutente TROVATO
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return=0
st_esito kst_esito
st_tab_web_utenti kst1_tab_web_utenti


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
    SELECT max(idutente)  
       into :kst1_tab_web_utenti.idutente
		 FROM web_utenti
		 where id_web_ruolo = :kst_tab_web_utenti.id_web_ruolo 
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura 'Utente Web' in ricerca per Ruolo (web_utenti) ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if sqlca.sqlcode = 0 and kst_tab_web_utenti.idutente > 0 then
			k_return = kst_tab_web_utenti.idutente
		end if
	end if


return k_return




end function

public function boolean tb_delete (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella web_utenti 
//--- 
//--- Input: st_tab_web_utenti.idutente
//--- Ritorna TRUE=CANCELLATO
//---   
//--- Lancia EXCEPTION        	
//---           	
//--------------------------------------------------------------------------------------------------------
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
	
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = get_id_programma (kkg_flag_modalita.cancellazione) //kkg_id_programma_contratti_co
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Utente WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

	if kst_tab_web_utenti.idutente > 0 then

		delete from web_utenti
			where idutente = :kst_tab_web_utenti.idutente
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Utente WEB' (web_utenti):" + trim(sqlca.SQLErrText)
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
			if kst_tab_web_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_web_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
			k_return = TRUE    //OK CANCELLATO
			
		end if
	end if


return k_return

end function

public function string get_nome (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//====================================================================
//=== Legge tabella UTENTEI WEB per reperire il nome
//=== 
//=== Input: kst_tab_web_utenti.iduente
//=== Out:      
//=== Ritorna tab. il nome
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
string k_return = ""
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 ragionesociale
    INTO 
	 	  :kst_tab_web_utenti.ragionesociale 
        FROM web_utenti
        WHERE ( idutente = :kst_tab_web_utenti.idutente   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Utenti WEB: " + trim(sqlca.SQLErrText)
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
	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.get_esito_descrizione(kst_esito)
		throw kguo_exception
	end if


	if len(trim(kst_tab_web_utenti.ragionesociale)) > 0 then
		k_return = kst_tab_web_utenti.ragionesociale
	end if

return k_return

end function

public function string get_nome_da_idcliente (readonly st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//====================================================================
//=== Legge tabella UTENTEI WEB per reperire il nome
//=== 
//=== Input: kst_tab_web_utenti.idcliente
//=== Out:      
//=== Ritorna tab. il nome
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
string k_return = ""
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 ragionesociale
    INTO 
	 	  :kst_tab_web_utenti.ragionesociale 
        FROM web_utenti
        WHERE ( idcliente = :kst_tab_web_utenti.idcliente   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Utenti WEB: " + trim(sqlca.SQLErrText)
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
	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.get_esito_descrizione(kst_esito)
		throw kguo_exception
	end if

	if len(trim(kst_tab_web_utenti.ragionesociale)) > 0 then
		k_return = kst_tab_web_utenti.ragionesociale
	end if

return k_return

end function

public function long get_ultimo_cliente (ref st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID Utente caricato per il Cliente indicato
//=== 
//=== Input: st_tab_web_utenti.idcliente    
//=== Output: 
//=== Ritorna il codice ID utente se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_web_utenti.idutente = 0
	
   SELECT   max(idutente)
       into :kst_tab_web_utenti.idutente
		 FROM web_utenti
		  where idcliente = :kst_tab_web_utenti.idcliente
			using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = kst_tab_web_utenti.idutente
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura id Utente  (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.get_esito_descrizione(kst_esito)
			throw kguo_exception
		end if
	end if

	if isnull(kst_tab_web_utenti.idcliente) then kst_tab_web_utenti.idcliente = 0

return k_return




end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID Utente caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice ID utente se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_web_utenti kst_tab_web_utenti


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_web_utenti.idutente = 0
	
   SELECT   max(idutente)
       into :kst_tab_web_utenti.idutente
		 FROM web_utenti
			using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = kst_tab_web_utenti.idutente
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Contratto Studio&Sviluppo (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.get_esito_descrizione(kst_esito)
			throw kguo_exception
		end if
	end if




return k_return




end function

public function boolean if_isnull (ref st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//====================================================================
//=== Torna i dati di default 
//=== 
//=== Input: st_tab_web_utenti 
//=== Output: st_tab_web_utenti valorizzata con i dati di default se questi sono vuoti
//=== Ritorna: TRUE = tutto ok
//=== 
//=== lancia EXCPETION se errore
//=== 
//====================================================================
boolean k_return = false
st_esito kst_esito
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if isnull(kst_tab_web_utenti.idutente) then kst_tab_web_utenti.idutente = 0
	if isnull(kst_tab_web_utenti.stato) or len(trim(kst_tab_web_utenti.stato)) = 0 then kst_tab_web_utenti.stato = ki_stato_attivo
	if isnull(kst_tab_web_utenti.statoweb) or len(trim(kst_tab_web_utenti.statoweb)) = 0 then kst_tab_web_utenti.statoweb = ki_statoweb_dapubblicare
	if isnull(kst_tab_web_utenti.datainserimento ) then kst_tab_web_utenti.datainserimento = datetime(date(0))
	if isnull(kst_tab_web_utenti.idcliente ) then kst_tab_web_utenti.idcliente = 0
	if isnull(kst_tab_web_utenti.ragionesociale ) then kst_tab_web_utenti.ragionesociale = ""
	kst_tab_web_utenti.ragionesociale = trim(kst_tab_web_utenti.ragionesociale)
	if isnull(kst_tab_web_utenti.username ) or len(trim(kst_tab_web_utenti.username)) = 0 then kst_tab_web_utenti.username = kuf1_utility.u_replace( upper(left(kst_tab_web_utenti.ragionesociale,1)) + lower(mid(kst_tab_web_utenti.ragionesociale,2,7)), " ", "_")
	if isnull(kst_tab_web_utenti.password ) or len(trim(kst_tab_web_utenti.password)) = 0 then kst_tab_web_utenti.password = kst_tab_web_utenti.username + string(kst_tab_web_utenti.idcliente, "00000")
	if isnull(kst_tab_web_utenti.id_web_ruolo ) then kst_tab_web_utenti.id_web_ruolo = 0
	if isnull(kst_tab_web_utenti.indirizzo ) then kst_tab_web_utenti.indirizzo = ""
	if isnull(kst_tab_web_utenti.cap ) then kst_tab_web_utenti.cap = ""
	if isnull(kst_tab_web_utenti.localita ) then kst_tab_web_utenti.localita = ""
	if isnull(kst_tab_web_utenti.provincia ) then kst_tab_web_utenti.provincia = ""
	if isnull(kst_tab_web_utenti.nazione ) or len(trim(kst_tab_web_utenti.nazione )) = 0 then kst_tab_web_utenti.nazione = "IT"
	if isnull(kst_tab_web_utenti.email ) then kst_tab_web_utenti.email = ""
	if isnull(kst_tab_web_utenti.email1 ) then kst_tab_web_utenti.email1 = ""
	if isnull(kst_tab_web_utenti.email2 ) then kst_tab_web_utenti.email2 = ""
	if isnull(kst_tab_web_utenti.note ) then kst_tab_web_utenti.note = ""
	
	k_return = true

	destroy kuf1_utility

return k_return




end function

public function boolean if_esiste_username (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//====================================================================
//=== Controllo se esiste gia' lo stesso USERNAME in tabella 
//=== 
//=== Inp: username, idutente (se omesso assume zero)
//=== Out: 
//=== Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE; (meglio FALSE)
//===   
//====================================================================
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


	if len(trim(kst_tab_web_utenti.username)) > 0 then

		
		if isnull(kst_tab_web_utenti.idutente) then kst_tab_web_utenti.idutente = 0

		select 1
			into :k_ctr
			from web_utenti 
			where web_utenti.idutente <> :kst_tab_web_utenti.idutente and web_utenti.username = :kst_tab_web_utenti.username
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode = 100 then
				k_return = false
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica esistenza Username doppi (web_utenti): " + kst_tab_web_utenti.username  + " ~n~r " + sqlca.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
		end if

	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	
	
return k_return


end function

public function boolean set_statoweb (st_tab_web_utenti kst_tab_web_utenti) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------
//--- Setta il campo STATOWEB della tabella web_utenti 
//--- 
//--- Input: st_tab_web_utenti.idutente / statoweb (se non impostato x DEAFULT è 'da Pubblicare'
//--- Ritorna TRUE=CANCELLATO
//---   
//--- Lancia EXCEPTION        	
//---           	
//--------------------------------------------------------------------------------------------------------
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
	
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica 'Utente WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

	if kst_tab_web_utenti.idutente > 0 then

		if isnull(kst_tab_web_utenti.statoweb) then kst_tab_web_utenti.statoweb = ki_statoweb_dapubblicare

		kst_tab_web_utenti.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_web_utenti.x_utente = kGuf_data_base.prendi_x_utente()


		update web_utenti
				set statoweb = :kst_tab_web_utenti.statoweb
				     ,datainserimento = :kst_tab_web_utenti.datainserimento
					 ,x_datins = :kst_tab_web_utenti.x_datins
					 ,x_utente = :kst_tab_web_utenti.x_utente
			where idutente = :kst_tab_web_utenti.idutente
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiornamento Stato Web su  'Utente WEB' (web_utenti):" + trim(sqlca.SQLErrText)
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
			if kst_tab_web_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_web_utenti.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
			k_return = TRUE    //OK CANCELLATO
			
		end if
	end if


return k_return

end function

public function long u_web_pubblica (ref st_tab_web_utenti kst_tab_web_utenti[], st_web_pubblica kst_web_pubblica) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Pubblica Utenti Web ovvero copia nella tabella esterna Utenti da sincronizzare con quella su WEB
//---
//--- inp:  st_tab_web_utenti  array con id_web_utente da pubblicare
//---        st_web_pubblica          x sapere se simulazione ecc... o meno
//--- out: -
//---
//--- ritorna: long = numero di Utenti pubblicati
//---
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_nr_utenti, k_ctr
st_tab_db_cfg kst_tab_db_cfg
st_esito kst_esito
kuf_db_cfg kuf1_db_cfg
datastore kds_get


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.set_esito(kst_esito) 

	kuf1_db_cfg = create kuf_db_cfg
		
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xweb
	if kuf1_db_cfg.if_connessione_bloccata(kst_tab_db_cfg) then    // Connessione bloccata?? speriamo di no
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Per procedere sbloccare prima la connessione al DB esterno ")
		throw kguo_exception
	else

		if upperbound(kst_tab_web_utenti) > 0 then
			
//--- popola la struttura con i dati degli Utenti			
			kds_get = create datastore
			kds_get.dataobject = "ds_web_utenti"
			kds_get.settransobject( sqlca )
			
			for k_ctr = 1 to upperbound(kst_tab_web_utenti[]) 
				if kst_tab_web_utenti[k_ctr].idutente > 0 then
					if kds_get.retrieve( kst_tab_web_utenti[k_ctr].idutente) > 0 then
						kst_tab_web_utenti[k_ctr].username = trim(kds_get.object.username[1])
						kst_tab_web_utenti[k_ctr].password = trim(kds_get.object.password[1])
						kst_tab_web_utenti[k_ctr].email = trim(kds_get.object.email[1])
						kst_tab_web_utenti[k_ctr].stato = trim(kds_get.object.stato[1])
						kst_tab_web_utenti[k_ctr].datainserimento = kGuf_data_base.prendi_dataora( ) //kds_get.object.datainserimento[1]
						kst_tab_web_utenti[k_ctr].idcliente = kds_get.object.idcliente[1]
						kst_tab_web_utenti[k_ctr].ragionesociale = trim(kds_get.object.ragionesociale[1])
						kst_tab_web_utenti[k_ctr].indirizzo = trim(kds_get.object.indirizzo[1])
						kst_tab_web_utenti[k_ctr].cap = trim(kds_get.object.cap[1])
						kst_tab_web_utenti[k_ctr].localita = trim(kds_get.object.localita[1])
						kst_tab_web_utenti[k_ctr].provincia = trim(kds_get.object.provincia[1])
						kst_tab_web_utenti[k_ctr].nazione = trim(kds_get.object.nazione[1])
						kst_tab_web_utenti[k_ctr].note = trim(kds_get.object.note[1]) 
						kst_tab_web_utenti[k_ctr].email1 = trim(kds_get.object.email1[1])
						kst_tab_web_utenti[k_ctr].email2 = trim(kds_get.object.email2[1])
						kst_tab_web_utenti[k_ctr].id_web_ruolo = kds_get.object.id_web_ruolo[1]
						kst_tab_web_utenti[k_ctr].x_datins = kds_get.object.x_datins[1]
						kst_tab_web_utenti[k_ctr].x_utente = trim(kds_get.object.x_utente[1])
					else
						kst_tab_web_utenti[k_ctr].idutente = 0
					end if
				end if
			end for
			
			k_nr_utenti = web_add(kst_tab_web_utenti[] )  // Aggiunge gli Utenti alla Tabella esterna
			
			if kst_web_pubblica.k_aggiorna_web_utenti  then  // se richiesto aggiornamento Utenti...
				
				for k_ctr = 1 to k_nr_utenti 
					kst_tab_web_utenti[k_ctr].statoweb = ki_statoweb_pubblicato
					set_statoweb( kst_tab_web_utenti[k_ctr] )   // rimette lo statoweb a 'pubblicato'
				end for
			end if			
			
			k_return = k_nr_utenti
		else
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Nessu Utente da 'Pubblicare'! ")
			throw kguo_exception
		
		end if
	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
	
finally 
	destroy kuf1_db_cfg

end try

return k_return

end function

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_pubblica_web_utenti)



end subroutine

public subroutine log_destroy () throws uo_exception;//
//--- svuota il LOG
//
st_tab_esito_operazioni kst_tab_esito_operazioni

kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
	
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni



end subroutine

private function long web_add (ref st_tab_web_utenti kst_tab_web_utenti[]) throws uo_exception;//
//--- Carica su tabella Esterna uguale a quella Web (MySql) i dati UTENTI
//--- 
//--- inp: kst_tab_web_utenti degli utenti da caricare
//--- out:
//--- rit: long = nr utenti pubblicati
//---
//--- lancia EXCEPTION se errore
//
long k_return=0
long k_utenti_add=0 
int k_ind=0
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Aggiornamento Tabella esterna Utenti Web non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if upperbound(kst_tab_web_utenti) > 0 then

		try 
			if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
			kiuo_sqlca_db_xweb.db_connetti()
			
			web_db_crea_tabella( )   // Drop/Crea tabella UTENTI 
			
			for k_ind = 1 to upperbound(kst_tab_web_utenti)
				
				if_isnull(kst_tab_web_utenti[k_ind])

				if kst_tab_web_utenti[k_ind].idutente > 0 then

					insert into utenti
						( idutente 
						,username
						,password
						,email
						,stato
						,datainserimento
						,idcliente
						,ragionesociale
						,indirizzo
						,cap
						,localita
						,provincia
						,nazione
						,note
						,email1
						,email2
						,idruolo
						)
						values 
						(:kst_tab_web_utenti[k_ind].idutente
						,:kst_tab_web_utenti[k_ind].username
						,:kst_tab_web_utenti[k_ind].password
						,:kst_tab_web_utenti[k_ind].email
						,:kst_tab_web_utenti[k_ind].stato
						,:kst_tab_web_utenti[k_ind].datainserimento
						,:kst_tab_web_utenti[k_ind].idcliente
						,:kst_tab_web_utenti[k_ind].ragionesociale
						,:kst_tab_web_utenti[k_ind].indirizzo
						,:kst_tab_web_utenti[k_ind].cap
						,:kst_tab_web_utenti[k_ind].localita
						,:kst_tab_web_utenti[k_ind].provincia
						,:kst_tab_web_utenti[k_ind].nazione
						,:kst_tab_web_utenti[k_ind].note
						,:kst_tab_web_utenti[k_ind].email1
						,:kst_tab_web_utenti[k_ind].email2
						,:kst_tab_web_utenti[k_ind].id_web_ruolo
						)
						using kiuo_sqlca_db_xweb ;
						
//						,x_datins
//						,x_utente
//						,:kst_tab_web_utenti[k_ind].x_datins
//						,:kst_tab_web_utenti[k_ind].x_utente
					
					if kiuo_sqlca_db_xweb.sqlcode = 0 then
						
						k_utenti_add ++
						
					else
							
						kst_esito.sqlcode = kiuo_sqlca_db_xweb.sqlcode
						kst_esito.SQLErrText = &
				"Errore durante inserimento in tabella esterna Utenti Web  (utenti) ~n~r" &
								+ " id Utente = " + string(kst_tab_web_utenti[k_ind].idutente) + " " &
								+ " ~n~rErrore-tab.'Utenti': "	+ trim(kiuo_sqlca_db_xweb.SQLErrText)
						if kiuo_sqlca_db_xweb.sqlcode = 100 then
							kst_esito.esito = kkg_esito.not_fnd
						else
							if kGuo_sqlca_db_wm.sqlcode > 0 then
								kst_esito.esito = kkg_esito.db_wrn
							else
								kst_esito.esito = kkg_esito.db_ko
							end if
						end if
			
						if kst_tab_web_utenti[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti[1].st_tab_g_0.esegui_commit) then
							rollback using kiuo_sqlca_db_xweb;
						end if
						
						kuo_exception = create uo_exception
						kuo_exception.set_esito(kst_esito)
						throw kuo_exception
			
					end if
				end if
				
			next
			
		
	//---- COMMIT....	
			if kiuo_sqlca_db_xweb.sqlcode = 0 then
				if kst_tab_web_utenti[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti[1].st_tab_g_0.esegui_commit) then
					commit using kiuo_sqlca_db_xweb;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_web_utenti[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_utenti[1].st_tab_g_0.esegui_commit) then
				kiuo_sqlca_db_xweb.db_disconnetti()
			end if
		
			 k_return=k_utenti_add
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

public function long if_ultimo_folder_x_id_web_ruolo (readonly st_tab_web_folder kst_tab_web_folder) throws uo_exception;//	
//====================================================================
//=== Torna se esiste il id_web_folder Web piu' grande gla associato al id_web_ruolo
//=== 
//=== Input: st_tab_web_folder.id_web_ruolo
//=== ritorna: 
//=== Output: ZERO=non trovato, altrimenti l'ultimo id_web_ruolo TROVATO
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return=0
st_esito kst_esito
st_tab_web_folder kst1_tab_web_folder


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
    SELECT max(id_web_folder)  
       into :kst1_tab_web_folder.id_web_folder
		 FROM web_folder
		 where id_web_ruolo = :kst_tab_web_folder.id_web_ruolo
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura 'Codici Cartella Web' in ricerca per id 'Ruolo' (web_folder) ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if sqlca.sqlcode = 0 and kst_tab_web_folder.id_web_ruolo > 0 then
			k_return = kst_tab_web_folder.id_web_folder
		end if
	end if


return k_return




end function

protected function boolean web_db_crea_tabella () throws uo_exception;//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CANCELLA/CREA TABLE WEB UTENTI ESTERNA 
//---
//--- input:  
//--- output:  
//---
//--- Ritorna TRUE = OK
//---   
//--- Lancia EXCEPTION
//---   
//----------------------------------------------------------------------------------------------------------------------------
boolean k_return = false


try
	if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
	kiuo_sqlca_db_xweb.u_crea_schema( )
	k_return = TRUE

catch (uo_exception kuo_exception)
		kuo_exception.inizializza( )
		throw kuo_exception

end try


return k_return
end function

on kuf_web_utenti.create
call super::create
end on

on kuf_web_utenti.destroy
call super::destroy
end on

