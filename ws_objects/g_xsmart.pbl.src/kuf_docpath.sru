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

private string ki_duplica_si = "1" 
end variables

forward prototypes
public function boolean tb_delete (st_tab_docpath kst_tab_docpath) throws uo_exception
public function boolean if_esiste_id_doctipo (st_tab_docpath kst_tab_docpath) throws uo_exception
public function boolean if_isnull (ref st_tab_docpath kst_tab_docpath)
public function string get_path (st_tab_docpath kst_tab_docpath) throws uo_exception
public function long get_id_docpath_x_id_doctipo (ref st_tab_docpath kst_tab_docpath[]) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean if_uso_esterno (st_tab_docpath kst_tab_docpath) throws uo_exception
public function string get_path_x_documentale (st_tab_docpath kst_tab_docpath) throws uo_exception
public function long get_path_x_tipo (ref st_tab_docpath ast_tab_docpath[]) throws uo_exception
public function string get_path_suff_generale (ref long a_id_cliente, date a_data)
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
      kst_esito.SQLErrText = "Cancellazione 'percorso Cartella Documenti' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
      kst_esito.esito = kkg_esito.no_aut
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
			if kst_tab_docpath.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpath.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docpath.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docpath.st_tab_g_0.esegui_commit) then
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


kst_esito.esito = kkg_esito.blok
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
//--- Input: kst_tab_docpath.id_docpath
//--- Out:  
//--- Ritorna  PATH
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 trim(path)
    INTO 
	 	  :kst_tab_docpath.path
        FROM docpath
        WHERE id_docpath = :kst_tab_docpath.id_docpath  
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura Cartelle Documenti (docpath id " + string(kst_tab_docpath.id_docpath) + ") : " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	if kst_esito.esito = kkg_esito.db_ko then
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


kst_esito.esito = kkg_esito.ok
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
			kst_esito.esito = kkg_esito.db_ko
		end if
		
	end if
	
	destroy kds_docpath_id_docpath
	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_return = k_indice
	
else
	kst_esito.SQLErrText = "Lettura tab. rif. Cartelle Documenti codice Tipo documento non indicato "
	kst_esito.esito = kkg_esito.no_esecuzione
end if

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

 
	kst_esito.esito = kkg_esito.ok
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
			kst_esito.esito = kkg_esito.db_ko
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

public function boolean if_uso_esterno (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se x questo TIPO DOCUMENTO devo fare una duplica dei documenti x uso esterno
//--- 
//--- Inp: id_docpath
//--- Out: 
//--- Ritorna BOOLEAN : TRUE=Duplica anche x Uso Esterno, FALSE=solo Uso Interno
//---   
//------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito
int k_ctr
uo_exception kuo_exception


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try


	if kst_tab_docpath.id_docpath > 0 then

		select duplica
			into :kst_tab_docpath.duplica
			from docpath 
			where docpath.id_docpath = :kst_tab_docpath.id_docpath 
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
			if kst_tab_docpath.duplica = ki_duplica_si then
				k_return = true
			end if
			
		else
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica se duplicare x 'Uso Esterno' (docpath): " + string(kst_tab_docpath.id_docpath)  + " ~n~r " + sqlca.sqlerrtext
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

public function string get_path_x_documentale (st_tab_docpath kst_tab_docpath) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella rif Cartelle Documenti per reperire il PATH
//--- 
//--- Input: kst_tab_docpath.id_docpath
//--- Out:  
//--- Ritorna  path_x_documentale
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
string k_return = ""
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

   SELECT   
		 trim(path_x_documentale)
    INTO 
	 	  :kst_tab_docpath.path_x_documentale
        FROM docpath
        WHERE id_docpath = :kst_tab_docpath.id_docpath  
		using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura path della Cartelle Documenti (docpath id " + string(kst_tab_docpath.id_docpath) + ") : " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if trim(kst_tab_docpath.path_x_documentale) > " " then
		k_return = trim(kst_tab_docpath.path_x_documentale)
	end if

return k_return

end function

public function long get_path_x_tipo (ref st_tab_docpath ast_tab_docpath[]) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------
//--- Legge tabella i doc_path per reperire il PATH x tipo documento
//--- 
//--- Input: ast_tab_docpath[1] con .id_doctipo 
//--- Out:  ast_tab_docpath[] id_docpath e path
//--- Ritorna: numero di path trovati
//--- 
//--- lancia UO_EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------
long k_return = 0
long k_retrieve = 0, k_riga=0, k_indice=0, k_righe
st_tab_docpath kst_tab_docpath
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



if ast_tab_docpath[1].id_doctipo > 0 then
 
 	k_righe = get_id_docpath_x_id_doctipo(ast_tab_docpath)
 
 	for k_riga = 1 to k_righe
		
		kst_tab_docpath = ast_tab_docpath[k_riga]
		ast_tab_docpath[k_riga].path = get_path(kst_tab_docpath)
	
	end for

	k_return = k_righe
	
else
	kst_esito.SQLErrText = "Lettura Cartelle Documenti codice Tipo documento non indicato "
	kst_esito.esito = kkg_esito.no_esecuzione
end if

return k_return

end function

public function string get_path_suff_generale (ref long a_id_cliente, date a_data);//
//-------------------------------------------------------------------------------------------------------------------
//--- Compone il PATH di suffisso al path per tipologia del documento
//--- 
//--- Input: codice_cliente, una data valida (es. data del documento)
//--- Out: 
//--- Ritorna:  path con i separatori
//--- 
//-------------------------------------------------------------------------------------------------------------------
string k_return 


	if a_id_cliente > 0 then
	else
		a_id_cliente = 0
	end if
	if a_data > kkg.data_zero  then
	else
		a_data = kguo_g.get_dataoggi( )
	end if
 
	k_return  = kkg.path_sep  + string(a_data, "yyyy") + kkg.path_sep &
									+ string(a_id_cliente, "00000") + kkg.path_sep &
									+ string(a_data, "mm")  &
									+ kkg.path_sep 
			
	
return k_return

end function

on kuf_docpath.create
call super::create
end on

on kuf_docpath.destroy
call super::destroy
end on

