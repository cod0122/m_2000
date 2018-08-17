$PBExportHeader$kuf_docpath.sru
forward
global type kuf_docpath from kuf_parent
end type
end forward

global type kuf_docpath from kuf_parent
end type
global kuf_docpath kuf_docpath

type variables
//
private constant string k_ds_docpath_id_docpath = "ds_docpath_id_docpath"


end variables

forward prototypes
public function boolean tb_delete (st_tab_docpath kst_tab_docpath) throws uo_exception
public function boolean if_esiste_id_doctipo (st_tab_docpath kst_tab_docpath) throws uo_exception
public function boolean if_isnull (ref st_tab_docpath kst_tab_docpath)
public function string get_path (st_tab_docpath kst_tab_docpath) throws uo_exception
public function long get_id_docpath_x_id_doctipo (ref st_tab_docpath kst_tab_docpath[]) throws uo_exception
public function boolean if_esiste_docpathtipo (st_tab_docpath kst_tab_docpath) throws uo_exception
public function boolean set_docpathtipo (st_tab_docpath kst_tab_docpath) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean if_esiste_docpathtipo_diverso (st_tab_docpath kst_tab_docpath) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella DOCPATH 
//--- 
//--- Ritorna ST_ESITO
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


   kst_esito.esito = kkg_esito_ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()
   
   kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
   kst_open_w.id_programma = get_id_programma (kkg_flag_modalita_cancellazione) //kkg_id_programma_contratti_co

//--- controlla se utente autorizzato alla funzione in atto
   kuf1_sicurezza = create kuf_sicurezza
   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
   destroy kuf1_sicurezza

   if not k_autorizza then
   
      kst_esito.sqlcode = sqlca.sqlcode
      kst_esito.SQLErrText = "Cancellazione 'percorso Cartella Documenti' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
      kst_esito.esito = KKG_ESITO_no_aut
      kguo_exception.inizializza( )
      kguo_exception.set_esito(kst_esito)
      throw kguo_exception
   
   end if
	
   if kst_tab_docpath.id_docpath > 0 then
      
      try
		      
		delete from docpath
			where id_docpath = :kst_tab_docpath.id_docpath
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'percorso Cartella Documenti' (docpath):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = KKG_ESITO_not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = KKG_ESITO_db_wrn
				else
					kst_esito.esito = KKG_ESITO_db_ko
				end if
			end if
		end if
         
      //---- COMMIT.... 
		if kst_esito.esito = kkg_esito_db_ko then
			if kst_tab_docpath.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpath.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docpath.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpath.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
			
			k_return = true  // OK CANCELLATO
			
		end if
		
         
      catch (uo_exception kuo_exception)
         throw kuo_exception
         
      end try
   end if


return k_return

end function

public function boolean if_esiste_id_doctipo (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste gia' lo stesso TIPO DOCUMENTO in tabella 
//--- 
//--- Inp: id_doctipo,  id_docpath (se omesso assume zero)
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=ESISTE, FALSE=NON ESISTE; (meglio FALSE)
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


	if kst_tab_docpath.id_doctipo > 0 then

		
		if isnull(kst_tab_docpath.id_docpath) then kst_tab_docpath.id_docpath = 0

		select 1
			into :k_ctr
			from docpath 
			where docpath.id_docpath <> :kst_tab_docpath.id_docpath 
			          and docpath.id_doctipo = :kst_tab_docpath.id_doctipo
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
				kst_esito.SQLErrText = "Errore durante verifica esistenza Tipi Documento doppi (docpath): " + string(kst_tab_docpath.id_doctipo)  + " ~n~r " + sqlca.sqlerrtext
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

public function boolean if_isnull (ref st_tab_docpath kst_tab_docpath);//
//====================================================================
//=== Torna i dati di default 
//=== 
//=== Input: st_tab_docpath 
//=== Output: st_tab_docpath valorizzata con i dati di default se questi sono vuoti
//=== Ritorna: TRUE = tutto ok
//=== 
//=== lancia EXCPETION se errore
//=== 
//====================================================================
boolean k_return = false


	if isnull(kst_tab_docpath.id_docpath ) then kst_tab_docpath.id_docpath = 0
	if isnull(kst_tab_docpath.id_doctipo ) then kst_tab_docpath.id_doctipo = 0
	if isnull(kst_tab_docpath.descr ) then kst_tab_docpath.descr = ""
	if isnull(kst_tab_docpath.path ) then kst_tab_docpath.path = ""
	
	k_return = true


return k_return


end function

public function string get_path (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella rif Cartelle Documenti per reperire il PATH
//--- 
//--- Input: kst_tab_docpath.docpath
//--- Out:  
//--- Ritorna  PATH
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 trim(path)
    INTO 
	 	  :kst_tab_docpath.path
        FROM docpath
        WHERE id_docpath = :kst_tab_docpath.id_docpath  
		using sqlca;


	if sqlca.sqlcode = 0 then
		
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. rif. Cartelle Documenti (docpath id " + string(kst_tab_docpath.id_docpath) + ") : " + trim(sqlca.SQLErrText)
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

	if len(trim(kst_tab_docpath.path)) > 0 then
		k_return = trim(kst_tab_docpath.path)
	end if

return k_return

end function

public function long get_id_docpath_x_id_doctipo (ref st_tab_docpath kst_tab_docpath[]) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella i doc_path che riferiscono al id_doc_tipo
//--- 
//--- Input: kst_tab_docpath[] con .id_doctipo da cercare sul primo elemento
//--- Out:  kst_tab_docpath[] id_docpath
//--- Ritorna: numero di id_docpath trovati
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_retrieve = 0, k_riga=0, k_indice=0
datastore kds_docpath_id_docpath
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



if kst_tab_docpath[1].id_doctipo > 0 then
 
//--- get del ID_DOCPATH 
	kds_docpath_id_docpath = create datastore
	kds_docpath_id_docpath.dataobject = k_ds_docpath_id_docpath
	kds_docpath_id_docpath.settransobject( sqlca)
	k_retrieve = kds_docpath_id_docpath.retrieve(kst_tab_docpath[1].id_doctipo)

	if k_retrieve > 0 then
		
		for k_riga = 1 to k_retrieve
	
			if kds_docpath_id_docpath.object.id_docpath[k_riga] > 0 then
				k_indice++
				kst_tab_docpath[k_indice].id_docpath = kds_docpath_id_docpath.object.id_docpath[k_riga]
				kst_tab_docpath[k_indice].id_doctipo = kst_tab_docpath[1].id_doctipo
				
			end if
			
		end for
	else
		
		if k_retrieve < 0 then
			kst_esito.SQLErrText = "Lettura tab. rif. Cartelle Documenti codice Tipo documento non indicato "
			kst_esito.esito = kkg_esito_db_ko
		end if
		
	end if
	
	destroy kds_docpath_id_docpath
	
	if kst_esito.esito = kkg_esito_db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_return = k_indice
	
else
	kst_esito.SQLErrText = "Lettura tab. rif. Cartelle Documenti codice Tipo documento non indicato "
	kst_esito.esito = kkg_esito_no_esecuzione
end if

return k_return

end function

public function boolean if_esiste_docpathtipo (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se questo ID è un DOCUMENTO PRINCIPALE USO INTERNO DI CONSULATZIONE (in DOCPATHTIPO) 
//--- 
//--- Inp:   id_docpath    
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=è un documento principale!, FALSE=non lo è
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_docpathtipo kst_tab_docpathtipo
kuf_docpathtipo  kuf1_docpathtipo 
uo_exception kuo_exception


kst_esito.esito = kkg_esito_blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


	if kst_tab_docpath.id_docpath > 0 then
//
////--- prima piglia il id_doctipo
//		select id_doctipo
//			into :kst_tab_docpath.id_doctipo
//			from docpath
//			where docpath.id_docpath = :kst_tab_docpath.id_docpath 
//			using sqlca;
//			
//		if sqlca.sqlcode = 0 then
	
			kuf1_docpathtipo = create kuf_docpathtipo
//--- Qui controlla effettivamente se è PRINCIPALE
			kst_tab_docpathtipo.id_docpath = kst_tab_docpath.id_docpath 
			kst_tab_docpathtipo.id_doctipo = kst_tab_docpath.id_doctipo
			k_return = kuf1_docpathtipo.if_esiste(kst_tab_docpathtipo)
			
//		else
//			if sqlca.sqlcode = 100 then
//				k_return = false
//			else
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Errore durante lettura Archivio Rif. Cartelle per Tipo Documento (docpath): " + string(kst_tab_docpath.id_docpath)  + " ~n~r " + sqlca.sqlerrtext
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito( kst_esito )
//				throw kuo_exception
//			end if
//		end if

	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	if isvalid(kuf1_docpathtipo) then destroy kuf1_docpathtipo

end try	
	
return k_return


end function

public function boolean set_docpathtipo (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Imposta / Toglie il documento dalla tabella "DOCUMENTI PRINCIPALI" (in DOCPATHTIPO) 
//--- 
//--- Inp:   id_docpath / id_doctipo (se = 0 CANCELLA il LEGAME!!!)
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=è un documento principale!, FALSE=non lo è
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_docpathtipo kst_tab_docpathtipo
kuf_docpathtipo  kuf1_docpathtipo 
uo_exception kuo_exception


kst_esito.esito = kkg_esito_blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if kst_tab_docpath.id_docpath > 0 then

//		if kst_tab_docpath.id_doctipo > 0 then 
//			sqlca.sqlcode = 0
//		else
//
////--- prima piglia il id_doctipo
//			select id_doctipo
//				into :kst_tab_docpath.id_doctipo
//				from docpath
//				where docpath.id_docpath = :kst_tab_docpath.id_docpath 
//				using sqlca;
//				
//		end if
			
//		if sqlca.sqlcode = 0 then
	
			kuf1_docpathtipo = create kuf_docpathtipo

//--- Qui set del PRINCIPALE
			kst_tab_docpathtipo.id_docpath = kst_tab_docpath.id_docpath 
			kst_tab_docpathtipo.id_doctipo = kst_tab_docpath.id_doctipo
			
			if kst_tab_docpath.id_doctipo > 0 then 
				k_return = kuf1_docpathtipo.tb_add(kst_tab_docpathtipo)  // AGGIUNGE IL LEGAME
			else
				k_return = kuf1_docpathtipo.tb_delete(kst_tab_docpathtipo)  // RIMUOVE IL LEGAME
			end if
			
//		else
//			if sqlca.sqlcode = 100 then
//				k_return = false
//			else
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Errore durante lettura arch. rif. Cartelle per Tipo Documento (docpath): " + string(kst_tab_docpath.id_docpath)  + " ~n~r " + sqlca.sqlerrtext
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito( kst_esito )
//				throw kuo_exception
//			end if
//		end if

	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	if isvalid(kuf1_docpathtipo) then destroy kuf1_docpathtipo

end try	
	
return k_return


end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: --
//=== Ritorna: long=Ultimo ID 
//===           		  
//=== Lancia EXCEPTION per errore
//===           		  
//====================================================================
long k_return=0
st_esito kst_esito
st_tab_docpath kst_tab_docpath

 
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT max(docpath.id_docpath)
	  into
	  			:kst_tab_docpath.id_docpath
   	 FROM docpath
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura docpath (cercato MAX ID) ~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

	if kst_tab_docpath.id_docpath > 0 then k_return = kst_tab_docpath.id_docpath

return k_return


end function

public function boolean if_esiste_docpathtipo_diverso (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste già un TIPO associato come DOCUMENTO PRINCIPALE USO INTERNO DI CONSULATZIONE (in DOCPATHTIPO) 
//--- 
//--- Inp:   id_docpath    
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=è un documento principale!, FALSE=non lo è
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
st_tab_docpathtipo kst_tab_docpathtipo
kuf_docpathtipo  kuf1_docpathtipo 
uo_exception kuo_exception


kst_esito.esito = kkg_esito_blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


//	if kst_tab_docpath.id_docpath > 0 then
//
////--- prima piglia il id_doctipo
//		select id_doctipo
//			into :kst_tab_docpath.id_doctipo
//			from docpath
//			where docpath.id_docpath = :kst_tab_docpath.id_docpath 
//			using sqlca;
//			
//		if sqlca.sqlcode = 0 then
	
			kuf1_docpathtipo = create kuf_docpathtipo
//--- Qui controlla effettivamente se è PRINCIPALE
			kst_tab_docpathtipo.id_docpath = kst_tab_docpath.id_docpath 
			kst_tab_docpathtipo.id_doctipo = kst_tab_docpath.id_doctipo
			k_return = kuf1_docpathtipo.if_esiste_x_id_docpath_diverso(kst_tab_docpathtipo)
			
//		else
			if sqlca.sqlcode = 100 then
				k_return = false
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante lettura Archivio Rif. Cartelle per Tipo Documento (docpath): " + string(kst_tab_docpath.id_docpath)  + " ~n~r " + sqlca.sqlerrtext
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito )
				throw kuo_exception
			end if
//		end if

//	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	if isvalid(kuf1_docpathtipo) then destroy kuf1_docpathtipo

end try	
	
return k_return


end function

on kuf_docpath.create
call super::create
end on

on kuf_docpath.destroy
call super::destroy
end on

