$PBExportHeader$kuf_docpathtipo.sru
forward
global type kuf_docpathtipo from kuf_parent
end type
end forward

global type kuf_docpathtipo from kuf_parent
end type
global kuf_docpathtipo kuf_docpathtipo

type variables
////
////--- Tipi Documenti
//public constant string kki_tipo_attestati = "A"
//public constant string kki_tipo_ddt = "B"
//public constant string kki_tipo_fatture = "F"
//public constant string kki_tipo_contr_co = "X"
//public constant string kki_tipo_contr_rs = "Y"
//
//
end variables
forward prototypes
public function long get_id_docpath (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception
public function boolean if_esiste (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception
public function boolean tb_add (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception
public function boolean tb_delete (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception
public function boolean if_esiste_x_id_docpath_diverso (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception
end prototypes

public function long get_id_docpath (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella DOCPATHTIPO per reperire il ID_DOCPATH
//--- 
//--- Input: st_tab_docpathtipo.id_doctipo
//--- Out:  
//--- Ritorna  ID_DOCPATH
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
long k_return = 0
st_esito kst_esito

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 id_docpath
    INTO 
	 	  :kst_tab_docpathtipo.id_docpath
        FROM docpathtipo
        WHERE ( id_doctipo = :kst_tab_docpathtipo.id_doctipo   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Tipi Documento Principali (docpathtipo): " + trim(sqlca.SQLErrText)
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
	if kst_esito.esito = kkg_esito_db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if kst_tab_docpathtipo.id_docpath > 0 then
		k_return = kst_tab_docpathtipo.id_docpath
	end if

return k_return

end function

public function boolean if_esiste (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste un PATH principale
//--- 
//--- Inp:   id_docpath    
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito_blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


//	if kst_tab_docpathtipo.id_doctipo > 0 and kst_tab_docpathtipo.id_docpath > 0 then
	if kst_tab_docpathtipo.id_docpath > 0 then


		select 1
			into :k_ctr
			from docpathtipo
			where docpathtipo.id_docpath = :kst_tab_docpathtipo.id_docpath 
			using sqlca;
//			          and docpathtipo.id_doctipo = :kst_tab_docpathtipo.id_doctipo
			
		if sqlca.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode >= 0 then
				k_return = false
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica esistenza rif. Cartella 'Principale' (docpathtipo id_doctipo=" + string(kst_tab_docpathtipo.id_doctipo) + "; id_docpath=" +  string(kst_tab_docpathtipo.id_doctipo) &
				                                 + ") : ~n~r " + sqlca.sqlerrtext
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

public function boolean tb_add (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Imposta questa ID_DOCPATH+ID_DOCTIPO come cartella PRINCIPALE in tabella docpathtipo 
//--- 
//--- Input: st_tab_docpathtipo.id_docpath / id_doctipo 
//--- Ritorna TRUE=caricato
//---   
//--- Lancia EXCEPTION        	
//---           	
//--------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
st_tab_docpathtipo kst_tab_docpathtipo_1
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
//boolean k_autorizza


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
//	kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	kuf1_sicurezza = create kuf_sicurezza
//	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//	destroy kuf1_sicurezza
//	
//	if not k_autorizza then
//	
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Modifica 'Utente WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = KKG_ESITO_no_aut
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//
//	end if

	if kst_tab_docpathtipo.id_docpath > 0 then

		if isnull(kst_tab_docpathtipo.id_doctipo) then kst_tab_docpathtipo.id_doctipo = 0

//		kst_tab_docpathtipo.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_docpathtipo.x_utente = kuf1_data_base.prendi_x_utente()

//--- esiste già un abbinamento con questo TIPO?
		select id_docpath 
		       into :kst_tab_docpathtipo_1.id_docpath
			  from  docpathtipo
		      where id_doctipo = :kst_tab_docpathtipo.id_doctipo
			using sqlca;
		
		if sqlca.sqlcode = 0 then
		
			update docpathtipo
				set id_docpath = :kst_tab_docpathtipo.id_docpath
			      where id_doctipo = :kst_tab_docpathtipo.id_doctipo
				using sqlca;
				
		else
			
			insert into docpathtipo
						(id_docpath
						,id_doctipo )
				values (
							:kst_tab_docpathtipo.id_docpath
							,:kst_tab_docpathtipo.id_doctipo
				          )
			using sqlca;
			
		end if
		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiornamento Rif. Cartella 'Principale' Azienda (docpathtipo):" + trim(sqlca.SQLErrText)
			kst_esito.esito = KKG_ESITO_db_ko
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito_db_ko then
			if kst_tab_docpathtipo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpathtipo.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docpathtipo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpathtipo.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
			
			k_return = TRUE    //OK caricato
			
		end if
	end if


return k_return

end function

public function boolean tb_delete (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- Toglie questa combinazione ID_DOCPATH+ID_DOCTIPO come cartella PRINCIPALE in tabella docpathtipo 
//--- 
//--- Input: st_tab_docpathtipo.id_docpath / id_doctipo 
//--- Ritorna TRUE=cancellata
//---   
//--- Lancia EXCEPTION        	
//---           	
//-----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
//boolean k_autorizza


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
//	kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	kuf1_sicurezza = create kuf_sicurezza
//	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//	destroy kuf1_sicurezza
//	
//	if not k_autorizza then
//	
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Modifica 'Utente WEB' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = KKG_ESITO_no_aut
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//
//	end if

	if kst_tab_docpathtipo.id_docpath > 0 then

//		if isnull(kst_tab_docpathtipo.id_doctipo) then kst_tab_docpathtipo.id_doctipo = 0

//		kst_tab_docpathtipo.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_docpathtipo.x_utente = kuf1_data_base.prendi_x_utente()


		delete from docpathtipo
				where
						id_docpath = :kst_tab_docpathtipo.id_docpath
			using sqlca;

//					and id_doctipo = :kst_tab_docpathtipo.id_doctipo

		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Rimozione Rif. Cartella 'Principale' Azienda (docpathtipo):" + trim(sqlca.SQLErrText)
			kst_esito.esito = KKG_ESITO_db_ko
		end if
	
//---- COMMIT....	
		if kst_esito.esito = kkg_esito_db_ko then
			if kst_tab_docpathtipo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpathtipo.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docpathtipo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpathtipo.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
			
			k_return = TRUE    //OK 
			
		end if
	end if


return k_return

end function

public function boolean if_esiste_x_id_docpath_diverso (st_tab_docpathtipo kst_tab_docpathtipo) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste un PATH principale
//--- 
//--- Inp:   id_docpath    
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito_blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


//	if kst_tab_docpathtipo.id_doctipo > 0 and kst_tab_docpathtipo.id_docpath > 0 then
	if kst_tab_docpathtipo.id_doctipo > 0 then


		select 1
			into :k_ctr
			from docpathtipo
			where docpathtipo.id_docpath = :kst_tab_docpathtipo.id_docpath 
			          and docpathtipo.id_doctipo <> :kst_tab_docpathtipo.id_doctipo
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
			if k_ctr = 1 then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode >= 0 then
				k_return = false
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica esistenza rif. Cartella 'Principale' (docpathtipo id_doctipo=" + string(kst_tab_docpathtipo.id_doctipo) + "; id_docpath=" +  string(kst_tab_docpathtipo.id_doctipo) &
				                                 + ") : ~n~r " + sqlca.sqlerrtext
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

on kuf_docpathtipo.create
call super::create
end on

on kuf_docpathtipo.destroy
call super::destroy
end on

