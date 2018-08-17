$PBExportHeader$kuf_web_ruoli.sru
forward
global type kuf_web_ruoli from kuf_web_utenti
end type
end forward

global type kuf_web_ruoli from kuf_web_utenti
end type
global kuf_web_ruoli kuf_web_ruoli

type variables


end variables

forward prototypes
public function boolean tb_delete (st_tab_web_ruoli kst_tab_web_ruoli) throws uo_exception
private function boolean web_db_crea_tabella () throws uo_exception
private function long web_add (ref st_tab_web_ruoli kst_tab_web_ruoli[]) throws uo_exception
public function long u_web_pubblica () throws uo_exception
public function boolean if_isnull (ref st_tab_web_ruoli kst_tab_web_ruoli)
public function boolean if_flag_ad_true (st_tab_web_ruoli kst_tab_web_ruoli) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_web_ruoli kst_tab_web_ruoli) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella contratti_co 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
boolean k_return=false
st_tab_web_utenti kst_tab_web_utenti
st_tab_web_folder kst_tab_web_folder
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

	if kst_tab_web_ruoli.id_web_ruolo > 0 then
		
		try
		
//--- controllo se RUOLO è già associato a un cliente		
			kst_tab_web_utenti.id_web_ruolo = kst_tab_web_utenti.id_web_ruolo
			kst_tab_web_utenti.idutente = if_ultimo_utente_x_id_ruolo(kst_tab_web_utenti)
	
			if kst_tab_web_utenti.idutente > 0 then
	
				kst_esito.SQLErrText = "Cancellazione non eseguita. Ruolo già assegnato, ad esempio all'Utente cod.: " + string(kst_tab_web_utenti.idutente)
				kst_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if
	
	//--- controllo se RUOLO è già associato a un Folder    
			kst_tab_web_folder.id_web_ruolo = kst_tab_web_folder.id_web_ruolo
			kst_tab_web_folder.id_web_folder = if_ultimo_folder_x_id_web_ruolo(kst_tab_web_folder)
	
			if kst_tab_web_folder.id_web_folder > 0 then
	
				kst_esito.SQLErrText = "Cancellazione non eseguita. Ruolo già assegnato, ad esempio al cod. 'Codice Cartella': " + string(kst_tab_web_folder.id_web_folder)
				kst_esito.esito = kkg_esito.no_esecuzione
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
   
			end if
	
			delete from web_ruoli
				where id_web_ruolo = :kst_tab_web_ruoli.id_web_ruolo
				using sqlca;
	
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Utente WEB' (web_ruoli):" + trim(sqlca.SQLErrText)
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
				if kst_tab_web_ruoli.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_ruoli.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			else
				if kst_tab_web_ruoli.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_ruoli.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
				
				k_return = true  // OK CANCELLATO
				
			end if
			
			
		catch (uo_exception kuo_exception)
			throw kuo_exception
			
		end try
	end if


return k_return

end function

private function boolean web_db_crea_tabella () throws uo_exception;//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CANCELLA/CREA TABLE WEB RUOLI ESTERNA 
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
string k_sql
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb

//--- Cancello e ricreo la tabella
	EXECUTE IMMEDIATE  "DROP TABLE IF EXISTS `ruoli`; " using kiuo_sqlca_db_xweb ;
	commit using kiuo_sqlca_db_xweb;
	
k_sql = "  CREATE TABLE  `ruoli` (`idruolo` int(11) NOT NULL , " &
+ "	  `descr_it` varchar(120) NOT NULL,  " &
+ "	  `descr_en` varchar(120) NOT NULL,  " &
+ "	  `flag_pl` char(1) NOT NULL DEFAULT '0',  " &
+ "	  `flag_rt` char(1) NOT NULL DEFAULT '0',  " &
+ "	  `flag_ad` char(1) NOT NULL DEFAULT '0',  " &
+ "	  `x_datins` datetime DEFAULT NULL,  " &
+ "	  `x_utente` char(12)  DEFAULT 'batch',  " &
+ "	  PRIMARY KEY (`idruolo`) 	)     ENGINE=MyISAM DEFAULT CHARSET=latin1;  "  
	EXECUTE IMMEDIATE :k_sql using kiuo_sqlca_db_xweb;

	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if kiuo_sqlca_db_xweb.sqlcode <> 0 then
		if kiuo_sqlca_db_xweb.sqlcode > 0 then
//			kst_esito.esito = kkg_esito.db_wrn
//			kst_esito.sqlcode = kiuo_sqlca_db_xweb.sqlcode
//			kst_esito.sqlerrtext = "Anomalie durante generazione Tabella esterna Web Utenti.  Err.: " + trim(kiuo_sqlca_db_xweb.SQLErrText)
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kiuo_sqlca_db_xweb.sqlcode
			kst_esito.sqlerrtext = "Generazione Tabella esterna Web Ruoli non riuscita: " + trim(kiuo_sqlca_db_xweb.SQLErrText)
		end if
		rollback using kiuo_sqlca_db_xweb;

//--- scrive l'errore su LOG
		kst_errori_gestione.nome_oggetto = this.classname()
		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
		kst_errori_gestione.sqlerrtext = trim(kiuo_sqlca_db_xweb.SQLErrText)
		kst_errori_gestione.sqldbcode = kiuo_sqlca_db_xweb.sqlcode
		kst_errori_gestione.sqlca = kiuo_sqlca_db_xweb
		kGuf_data_base.errori_gestione(kst_errori_gestione)

//--- Lancia EXCEPTION
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	else
		commit using kiuo_sqlca_db_xweb;
		
		k_return = TRUE
		
	end if


return k_return
end function

private function long web_add (ref st_tab_web_ruoli kst_tab_web_ruoli[]) throws uo_exception;//
//--- Carica su tabella Esterna uguale a quella Web (MySql) i  RUOLI
//--- 
//--- inp: kst_tab_web_ruoli con i ruoli da caricare
//--- out:
//--- rit: TRUE=OK
//---
//--- lancia EXCEPTION se errore
//
long k_return=0
long k_nr_ruoli_add=0
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

	kst_esito.SQLErrText = "Aggiornamento Tabella esterna Ruoli Web non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if upperbound(kst_tab_web_ruoli) > 0 then

		try 
			if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
			kiuo_sqlca_db_xweb.db_connetti()
			
			web_db_crea_tabella( )   // Drop/Crea tabella Ruoli 
			
			for k_ind = 1 to upperbound(kst_tab_web_ruoli)

				if kst_tab_web_ruoli[k_ind].id_web_ruolo > 0 then
		
					insert into Ruoli
						( idruolo 
						,descr_it
						,descr_en
						,flag_pl
						,flag_rt
						,flag_ad
						,x_datins
						,x_utente
						)
						values 
						(:kst_tab_web_ruoli[k_ind].id_web_ruolo
						,:kst_tab_web_ruoli[k_ind].descr_it
						,:kst_tab_web_ruoli[k_ind].descr_en
						,:kst_tab_web_ruoli[k_ind].flag_pl
						,:kst_tab_web_ruoli[k_ind].flag_rt
						,:kst_tab_web_ruoli[k_ind].flag_ad
						,:kst_tab_web_ruoli[k_ind].x_datins
						,:kst_tab_web_ruoli[k_ind].x_utente
						)
						using kiuo_sqlca_db_xweb ;
					
					if kiuo_sqlca_db_xweb.sqlcode = 0 then
						
						k_nr_ruoli_add ++
						
					else
							
						kst_esito.sqlcode = kiuo_sqlca_db_xweb.sqlcode
						kst_esito.SQLErrText = &
				"Errore durante inserimento in tabella esterna Ruoli Web  (ruoli) ~n~r" &
								+ " id Ruolo = " + string(kst_tab_web_ruoli[k_ind].id_web_ruolo) + " " &
								+ " ~n~rErrore-tab.'Ruoli' :"	+ trim(kiuo_sqlca_db_xweb.SQLErrText)
						if kiuo_sqlca_db_xweb.sqlcode = 100 then
							kst_esito.esito = kkg_esito.not_fnd
						else
							if kGuo_sqlca_db_wm.sqlcode > 0 then
								kst_esito.esito = kkg_esito.db_wrn
							else
								kst_esito.esito = kkg_esito.db_ko
							end if
						end if
			
						if kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit) then
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
				if kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit) then
					commit using kiuo_sqlca_db_xweb;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_ruoli[1].st_tab_g_0.esegui_commit) then
				kiuo_sqlca_db_xweb.db_disconnetti()
			end if
		
			 k_return=k_nr_ruoli_add
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

public function long u_web_pubblica () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Pubblica Ruoli Web ovvero copia nella tabella esterna Ruoli da sincronizzare con quella su WEB
//---
//--- inp:  st_tab_web_ruoli  array con id_web_ruolo da pubblicare
//--- out: -
//---
//--- ritorna: long = numero di ruoli pubblicati
//---
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_nr_ruoli=0, k_ctr=0
st_tab_web_ruoli kst_tab_web_ruoli[]
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

//--- popola la struttura con i dati RUOLI		
		kds_get = create datastore
		kds_get.dataobject = "ds_web_ruoli"
		kds_get.settransobject( sqlca )
		if kds_get.retrieve(0) > 0 then  // legge tutti i Ruoli
			k_nr_ruoli=1
			for k_ctr = 1 to kds_get.rowcount( )
				kst_tab_web_ruoli[k_nr_ruoli].id_web_ruolo = kds_get.object.id_web_ruolo[k_ctr]
				
				if kst_tab_web_ruoli[k_nr_ruoli].id_web_ruolo > 0 then
					kst_tab_web_ruoli[k_nr_ruoli].descr_it = trim(kds_get.object.descr_it[k_ctr])
					kst_tab_web_ruoli[k_nr_ruoli].descr_en = trim(kds_get.object.descr_en[k_ctr])
					kst_tab_web_ruoli[k_nr_ruoli].flag_pl = trim(kds_get.object.flag_pl[k_ctr])
					kst_tab_web_ruoli[k_nr_ruoli].flag_rt = trim(kds_get.object.flag_rt[k_ctr])
					kst_tab_web_ruoli[k_nr_ruoli].flag_ad = trim(kds_get.object.flag_ad[k_ctr])
					kst_tab_web_ruoli[k_nr_ruoli].x_datins = kds_get.object.x_datins[k_ctr]
					kst_tab_web_ruoli[k_nr_ruoli].x_utente = trim(kds_get.object.x_utente[k_ctr])
					if_isnull(kst_tab_web_ruoli[k_nr_ruoli] )
					
					k_nr_ruoli ++
				end if
			end for
			k_nr_ruoli --
		end if
		
		if k_nr_ruoli > 0 then
		
			k_nr_ruoli = web_add(kst_tab_web_ruoli[] )  // Aggiunge gli ruoli alla Tabella esterna

			k_return = k_nr_ruoli
		else
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Nessu Ruolo da 'Pubblicare'! ")
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

public function boolean if_isnull (ref st_tab_web_ruoli kst_tab_web_ruoli);//
//====================================================================
//=== Torna i dati di default 
//=== 
//=== Input: st_tab_web_ruoli 
//=== Output: st_tab_web_ruoli valorizzata con i dati di default se questi sono vuoti
//=== Ritorna: TRUE = tutto ok
//=== 
//=== lancia EXCPETION se errore
//=== 
//====================================================================
boolean k_return = false


	if isnull(kst_tab_web_ruoli.id_web_ruolo ) then kst_tab_web_ruoli.id_web_ruolo = 0
	if isnull(kst_tab_web_ruoli.descr_en ) then kst_tab_web_ruoli.descr_en = ""
	if isnull(kst_tab_web_ruoli.descr_it ) then kst_tab_web_ruoli.descr_it = ""
	if isnull(kst_tab_web_ruoli.flag_ad ) or len(trim(kst_tab_web_ruoli.flag_ad )) = 0 then kst_tab_web_ruoli.flag_ad = "0"
	if isnull(kst_tab_web_ruoli.flag_pl ) or len(trim(kst_tab_web_ruoli.flag_pl)) = 0 then kst_tab_web_ruoli.flag_pl = "0"
	if isnull(kst_tab_web_ruoli.flag_rt ) or len(trim(kst_tab_web_ruoli.flag_rt)) = 0 then kst_tab_web_ruoli.flag_rt = "0"
	
	k_return = true


return k_return


end function

public function boolean if_flag_ad_true (st_tab_web_ruoli kst_tab_web_ruoli) throws uo_exception;//	
//====================================================================
//=== Torna se esiste il id_web_folder Web piu' grande gla associato al id_web_ruolo
//=== 
//=== Input: st_tab_web_ruoli.id_web_ruolo
//=== ritorna: 
//=== Output: TRUE  =  Accesso Area Documenti Concessa nel Ruolo indicato
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
    SELECT flag_ad
       into :kst_tab_web_ruoli.flag_ad
		 FROM web_ruoli
		 where id_web_ruolo = :kst_tab_web_ruoli.id_web_ruolo
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura 'Ruoli' per Indicatore di Accesso Documenti (web_ruoli) ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if sqlca.sqlcode = 0 and kst_tab_web_ruoli.flag_ad = ki_flag_ad_si then
			k_return = TRUE
		end if
	end if


return k_return




end function

on kuf_web_ruoli.create
call super::create
end on

on kuf_web_ruoli.destroy
call super::destroy
end on

