$PBExportHeader$kuf_web_folder.sru
forward
global type kuf_web_folder from kuf_web_utenti
end type
end forward

global type kuf_web_folder from kuf_web_utenti
end type
global kuf_web_folder kuf_web_folder

type variables



end variables

forward prototypes
public function boolean if_esiste_foldercod (st_tab_web_folder kst_tab_web_folder) throws uo_exception
public function boolean tb_delete (st_tab_web_folder kst_tab_web_folder) throws uo_exception
public function long u_web_pubblica () throws uo_exception
private function long web_add (ref st_tab_web_folder kst_tab_web_folder[]) throws uo_exception
private function boolean web_db_crea_tabella () throws uo_exception
public function boolean if_isnull (ref st_tab_web_folder kst_tab_web_folder)
end prototypes

public function boolean if_esiste_foldercod (st_tab_web_folder kst_tab_web_folder) throws uo_exception;//
//====================================================================
//=== Controllo se esiste gia' lo stesso CODICE FOLDERCOD per Lostesso RUOLO (se viene passato) in tabella 
//=== 
//=== Inp: foldercod, id_web_ruolo  (se omesso assume zero), id_web_folder (se omesso assume zero)
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


	if len(trim(kst_tab_web_folder.foldercod)) > 0 then

		
		if isnull(kst_tab_web_folder.id_web_folder) then kst_tab_web_folder.id_web_folder = 0

		select 1
			into :k_ctr
			from web_folder 
			where web_folder.id_web_folder <> :kst_tab_web_folder.id_web_folder 
			          and (:kst_tab_web_folder.id_web_ruolo = 0 or web_folder.id_web_ruolo = :kst_tab_web_folder.id_web_ruolo)
			          and web_folder.foldercod = :kst_tab_web_folder.foldercod
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
				kst_esito.SQLErrText = "Errore durante verifica esistenza Codici Cartella Web (SMART) doppi (web_folder): " + kst_tab_web_folder.foldercod  + " ~n~r " + sqlca.sqlerrtext
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

public function boolean tb_delete (st_tab_web_folder kst_tab_web_folder) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella contratti_co 
//=== 
//=== Ritorna ST_ESITO
//===             
//====================================================================
//
boolean k_return=false
st_tab_web_ruoli kst_tab_web_ruoli
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
      kst_esito.SQLErrText = "Cancellazione 'codice Cartella WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
      kst_esito.esito = kkg_esito.no_aut
      kguo_exception.inizializza( )
      kguo_exception.set_esito(kst_esito)
      throw kguo_exception
   
   end if
	
   if kst_tab_web_folder.id_web_folder > 0 then
      
      try
		      
		delete from web_folder
			where id_web_folder = :kst_tab_web_folder.id_web_folder
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'codice Cartella  WEB' (web_folder):" + trim(sqlca.SQLErrText)
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
			if kst_tab_web_folder.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_folder.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_web_folder.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_folder.st_tab_g_0.esegui_commit) then
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

public function long u_web_pubblica () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Pubblica Folder Web ovvero copia nella tabella esterna Folder da sincronizzare con quella su WEB
//---
//--- inp:  st_tab_web_folder  array con id_web_folder da pubblicare
//--- out: -
//---
//--- ritorna: long = numero di folder pubblicati
//---
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_nr_folder=0, k_ctr=0
st_tab_web_folder kst_tab_web_folder[]
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

//--- popola la struttura con i dati FOLDER
		kds_get = create datastore
		kds_get.dataobject = "ds_web_folder"
		kds_get.settransobject( sqlca )
		if kds_get.retrieve(0) > 0 then  // legge tutti i folder
			k_nr_folder=1
			for k_ctr = 1 to kds_get.rowcount( )
				kst_tab_web_folder[k_nr_folder].id_web_folder = kds_get.object.id_web_folder[k_ctr]
				if kst_tab_web_folder[k_nr_folder].id_web_folder > 0 then
					kst_tab_web_folder[k_nr_folder].id_web_ruolo = kds_get.object.id_web_ruolo[k_ctr]
					kst_tab_web_folder[k_nr_folder].descr = trim(kds_get.object.descr[k_ctr])
					kst_tab_web_folder[k_nr_folder].foldercod = trim(kds_get.object.foldercod[k_ctr])
					kst_tab_web_folder[k_nr_folder].x_datins = kds_get.object.x_datins[k_ctr]
					kst_tab_web_folder[k_nr_folder].x_utente = trim(kds_get.object.x_utente[k_ctr])
					if_isnull(kst_tab_web_folder[k_nr_folder])
					
					k_nr_folder ++
				end if
			end for
			k_nr_folder --
		end if

		if k_nr_folder > 0 then

			k_nr_folder = web_add(kst_tab_web_folder[] )  // Aggiunge gli folder alla Tabella esterna

			k_return = k_nr_folder
		else
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Nessu Codice Cartella Web (Folder) da 'Pubblicare'! ")
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

private function long web_add (ref st_tab_web_folder kst_tab_web_folder[]) throws uo_exception;//
//--- Carica su tabella Esterna uguale a quella Web (MySql) i  FOLDER (codici aree documenti a cui accedere)
//--- 
//--- inp: kst_tab_web_folder con i folder da caricare
//--- out:
//--- rit: TRUE=OK
//---
//--- lancia EXCEPTION se errore
//
long k_return=0
long k_nr_folder_add=0
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

	kst_esito.SQLErrText = "Aggiornamento Tabella esterna di Accesso Cartelle Web (folder) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if upperbound(kst_tab_web_folder) > 0 then

		try 
			if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
			kiuo_sqlca_db_xweb.db_connetti()
			
			web_db_crea_tabella( )   // Drop/Crea tabella folder 
			
			for k_ind = 1 to upperbound(kst_tab_web_folder)

				if kst_tab_web_folder[k_ind].id_web_folder > 0 then
		
					insert into folder
						( idfolder 
						,descr
						,idruolo
						,foldercod
						,x_datins
						,x_utente
						)
						values 
						(:kst_tab_web_folder[k_ind].id_web_folder
						,:kst_tab_web_folder[k_ind].descr
						,:kst_tab_web_folder[k_ind].id_web_ruolo
						,:kst_tab_web_folder[k_ind].foldercod
						,:kst_tab_web_folder[k_ind].x_datins
						,:kst_tab_web_folder[k_ind].x_utente
						)
						using kiuo_sqlca_db_xweb ;
					
					if kiuo_sqlca_db_xweb.sqlcode = 0 then
						k_nr_folder_add ++
						
					else
							
						kst_esito.sqlcode = kiuo_sqlca_db_xweb.sqlcode
						kst_esito.SQLErrText = &
				"Errore durante inserimento in tabella esterna di accesso Cartelle Web  (folder) ~n~r" &
								+ " id Utente = " + string(kst_tab_web_folder[k_ind].id_web_folder) + " " &
								+ " ~n~rErrore-tab.'Folder': "	+ trim(kiuo_sqlca_db_xweb.SQLErrText)
						if kiuo_sqlca_db_xweb.sqlcode = 100 then
							kst_esito.esito = kkg_esito.not_fnd
						else
							if kGuo_sqlca_db_wm.sqlcode > 0 then
								kst_esito.esito = kkg_esito.db_wrn
							else
								kst_esito.esito = kkg_esito.db_ko
							end if
						end if
			
						if kst_tab_web_folder[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_folder[1].st_tab_g_0.esegui_commit) then
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
				if kst_tab_web_folder[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_folder[1].st_tab_g_0.esegui_commit) then
					commit using kiuo_sqlca_db_xweb;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_web_folder[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_web_folder[1].st_tab_g_0.esegui_commit) then
				kiuo_sqlca_db_xweb.db_disconnetti()
			end if
		
			 k_return=k_nr_folder_add
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

private function boolean web_db_crea_tabella () throws uo_exception;//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CANCELLA/CREA TABLE WEB FOLDER ESTERNA 
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
	EXECUTE IMMEDIATE  "DROP TABLE IF EXISTS `folder`; " using kiuo_sqlca_db_xweb ;
	commit using kiuo_sqlca_db_xweb;
	
k_sql = "  CREATE TABLE  `folder` (`idfolder` int NOT NULL , " &
+ "	  `descr` varchar(120) NOT NULL,  " &
+ "	  `idruolo` int NOT NULL,   " &
+ "	  `foldercod` char(3) NOT NULL DEFAULT '',  " &
+ "	  `x_datins` datetime DEFAULT NULL,  " &
+ "	  `x_utente` char(12) DEFAULT 'batch',  " &
+ "	  PRIMARY KEY (`idfolder`) 	)     ENGINE=MyISAM DEFAULT CHARSET=latin1;  "  
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
			kst_esito.sqlerrtext = "Generazione Tabella esterna Web Folder non riuscita: " + trim(kiuo_sqlca_db_xweb.SQLErrText)
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

public function boolean if_isnull (ref st_tab_web_folder kst_tab_web_folder);//
//====================================================================
//=== Torna i dati di default 
//=== 
//=== Input: st_tab_web_folder 
//=== Output: st_tab_web_folder valorizzata con i dati di default se questi sono vuoti
//=== Ritorna: TRUE = tutto ok
//=== 
//=== lancia EXCPETION se errore
//=== 
//====================================================================
boolean k_return = false


	if isnull(kst_tab_web_folder.id_web_folder ) then kst_tab_web_folder.id_web_folder = 0
	if isnull(kst_tab_web_folder.id_web_ruolo ) then kst_tab_web_folder.id_web_ruolo = 0
	if isnull(kst_tab_web_folder.descr ) then kst_tab_web_folder.descr = ""
	if isnull(kst_tab_web_folder.foldercod ) then kst_tab_web_folder.foldercod = ""
	
	k_return = true


return k_return


end function

on kuf_web_folder.create
call super::create
end on

on kuf_web_folder.destroy
call super::destroy
end on

