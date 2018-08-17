$PBExportHeader$kuf_docprod.sru
forward
global type kuf_docprod from kuf_parent
end type
end forward

global type kuf_docprod from kuf_parent
end type
global kuf_docprod kuf_docprod

type variables
//
kuf_esito_operazioni kiuf_esito_operazioni
public constant string ki_doc_esporta_si = "S"
public constant string ki_doc_esporta_no = "N"
private constant string ki_doc_tabella_attestati = "certif"
private constant string ki_doc_tabella_ddt = "sped"
private constant string ki_doc_tabella_fatture = "arfa_testa"
private constant string ki_doc_tabella_contr_co = "contratti_co"
private constant string ki_doc_tabella_contr_rd = "contratti_rd"



end variables

forward prototypes
public function boolean if_isnull (ref st_tab_docprod kst_tab_docprod)
public function boolean tb_delete (st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean tb_add_fattura (ref st_tab_docprod kst_tab_docprod) throws uo_exception
private function boolean tb_add (ref st_tab_docprod kst_tab_docprod, readonly string k_tipo) throws uo_exception
public function boolean tb_add_ddt (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean if_esportato (st_tab_docprod kst_tab_docprod) throws uo_exception
public subroutine log_inizializza () throws uo_exception
public subroutine log_destroy () throws uo_exception
public function long u_esporta (st_docprod_esporta kst_docprod_esporta)
public function long u_esporta_fatture (st_docprod_esporta kst_docprod_esporta) throws uo_exception
private function boolean set_esportato (readonly st_tab_docprod kst_tab_docprod) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_docprod kst_tab_docprod)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
private function boolean anteprima_file (st_tab_docprod kst_tab_docprod)
public function string get_doc_nome (st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean get_dati_doc (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean get_id_docpath (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function string get_nomefile (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function long u_esporta_ddt (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean tb_add_contratti_co (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean tb_add_contratti_rd (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function long u_esporta_contr_co (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function long u_esporta_contr_rd (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean get_it_docprod_da_id_doc (ref st_tab_docprod kst_tab_docprod[]) throws uo_exception
public function boolean tb_delete (st_tab_docprod kst_tab_docprod[]) throws uo_exception
public function boolean tb_delete (readonly st_tab_docprod ast_tab_docprod, string k_tipo) throws uo_exception
public function boolean get_id_cliente (ref st_tab_docprod kst_tab_docprod) throws uo_exception
public function long if_esiste_id_doc_id_path (st_tab_docprod kst_tab_docprod) throws uo_exception
public function long u_esporta_txt_datidoc (st_txt_docprod ast_txt_docprod[]) throws uo_exception
private function long u_esporta_attestati (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function st_uf_docpath get_path (st_tab_docprod ast_tab_docprod) throws uo_exception
private function boolean set_esportato_no (readonly st_tab_docprod kst_tab_docprod) throws uo_exception
public function boolean tb_add_certif (ref st_tab_docprod ast_tab_docprod, boolean a_esporta) throws uo_exception
public function long get_id_docprod_max () throws uo_exception
end prototypes

public function boolean if_isnull (ref st_tab_docprod kst_tab_docprod);//
//---------------------------------------------------------------------------------------------------------------------------
//--- Torna i dati di default 
//--- 
//--- Input: st_tab_docprod 
//--- Output: st_tab_docprod valorizzata con i dati di default se questi sono vuoti
//--- Ritorna: TRUE = tutto ok
//--- 
//--- lancia EXCPETION se errore
//--- 
//---------------------------------------------------------------------------------------------------------------------------
boolean k_return = false


	if isnull(kst_tab_docprod.id_docprod ) then kst_tab_docprod.id_docprod = 0
	if isnull(kst_tab_docprod.id_docpath ) then kst_tab_docprod.id_docpath = 0
	if isnull(kst_tab_docprod.id_doc ) then kst_tab_docprod.id_doc = 0
	if isnull(kst_tab_docprod.descr ) then kst_tab_docprod.descr = ""
	if isnull(kst_tab_docprod.doc_nome ) then kst_tab_docprod.doc_nome = ""
	if isnull(kst_tab_docprod.caricato_ts ) then kst_tab_docprod.caricato_ts = datetime(date(0))
	if isnull(kst_tab_docprod.caricato_utente ) then kst_tab_docprod.caricato_utente = ""
	if isnull(kst_tab_docprod.doc_esporta ) then kst_tab_docprod.doc_esporta = ""
	if isnull(kst_tab_docprod.doc_nome ) then kst_tab_docprod.doc_nome = ""
	if isnull(kst_tab_docprod.esportato_ts ) then kst_tab_docprod.esportato_ts = datetime(date(0))
	if isnull(kst_tab_docprod.esportato_utente ) then kst_tab_docprod.esportato_utente = ""
	if isnull(kst_tab_docprod.rigenerato_ts ) then kst_tab_docprod.rigenerato_ts = datetime(date(0))
	if isnull(kst_tab_docprod.rigenerato_utente ) then kst_tab_docprod.rigenerato_utente = ""
	if isnull(kst_tab_docprod.doc_data ) then kst_tab_docprod.doc_data = date(0)
	if isnull(kst_tab_docprod.doc_num ) then kst_tab_docprod.doc_num = 0
	if isnull(kst_tab_docprod.doc_tabella ) then kst_tab_docprod.doc_tabella = ""
	if isnull(kst_tab_docprod.doc_esporta_prefpath ) then kst_tab_docprod.doc_esporta_prefpath = ""
	if isnull(kst_tab_docprod.x_datins ) then kst_tab_docprod.x_datins = datetime(date(0))
	if isnull(kst_tab_docprod.x_utente ) then kst_tab_docprod.x_utente = ""
	
	
	k_return = true


return k_return


end function

public function boolean tb_delete (st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella docprod 
//--- 
//--- Inp: st_tab_docprod.id_docprod
//--- Out: 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
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
   kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co

//-- per non bloccare le cancellazioni da DDT ecc.. SICUREZZA sempre OK
k_autorizza = true
////--- controlla se utente autorizzato alla funzione in atto
//   kuf1_sicurezza = create kuf_sicurezza
//   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//   destroy kuf1_sicurezza
//
//   if not k_autorizza then
//   
//      kst_esito.sqlcode = sqlca.sqlcode
//      kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//      kst_esito.esito = kkg_esito.no_aut
//      kguo_exception.inizializza( )
//      kguo_exception.set_esito(kst_esito)
//      throw kguo_exception
//   
//   end if
	
	
   if kst_tab_docprod.id_docprod > 0 then
      
      try
		      
		delete from docprod
			where id_docprod = :kst_tab_docprod.id_docprod
			using sqlca;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' (docprod):" + trim(sqlca.SQLErrText)
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
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
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

public function boolean tb_add_fattura (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek di tipo FATTURA alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod.tipo / doc_num / doc_data / doc_id / id_cliente
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo

//--- Nome del Documento e dscrizione: sono personalizzati x tipo documento
//	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "FT" + string(kst_tab_docprod.id_doc) + "N" + string(kst_tab_docprod.doc_num) + "_" + string(year(kst_tab_docprod.doc_data)) + ".pdf" 
	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "FT_" + string(kst_tab_docprod.doc_data, "yyyy_mm_dd") + "_" + string(kst_tab_docprod.id_doc) +  ".pdf" 
	kst_tab_docprod.descr = "Fattura nr. " + string(kst_tab_docprod.doc_num) + " del " + string(kst_tab_docprod.doc_data) + "  -  id: " + string(kst_tab_docprod.id_doc)  
	kst_tab_docprod.doc_tabella = ki_doc_tabella_fatture
	
	k_return = tb_add(kst_tab_docprod, kuf1_doctipo.kki_tipo_fatture)
	
	

return k_return

end function

private function boolean tb_add (ref st_tab_docprod kst_tab_docprod, readonly string k_tipo) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod  doc_num / doc_data / id_doc / id_cliente   e    il TIPO del documento (Fatt, bolla, ecc...)
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
long k_nr_id_docpath = 0, k_ind=0
st_tab_doctipo kst_tab_doctipo
st_tab_docpath kst_tab_docpath[]
//st_tab_docpathtipo kst_tab_docpathtipo
//st_tab_clienti_mkt kst_tab_clienti_mkt
st_esito kst_esito
kuf_doctipo kuf1_doctipo 
kuf_docpath kuf1_docpath
//kuf_docpathtipo kuf1_docpathtipo
//kuf_clienti kuf1_clienti 
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()
   
   kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
   kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co

//--- controlla se utente autorizzato alla funzione in atto
//   kuf1_sicurezza = create kuf_sicurezza
//   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//   destroy kuf1_sicurezza
//
//   if not k_autorizza then
//   
//      kst_esito.sqlcode = sqlca.sqlcode
//      kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//      kst_esito.esito = kkg_esito.no_aut
//      kguo_exception.inizializza( )
//      kguo_exception.set_esito(kst_esito)
//      throw kguo_exception
//   
//   end if
	
   if kst_tab_docprod.id_doc > 0 then
      
      try

		kuf1_doctipo = create kuf_doctipo	  
		kuf1_docpath = create kuf_docpath
		
//--- get del id_doctipo		
		kst_tab_doctipo.tipo = k_tipo
		kst_tab_doctipo.id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)

//--- piglia un arrray con i id_docpath, potrebbero esserci più 'path' per uno stesso tipo documento
		kst_tab_docpath[1].id_doctipo = kst_tab_doctipo.id_doctipo
		k_nr_id_docpath = kuf1_docpath.get_id_docpath_x_id_doctipo(kst_tab_docpath[])

//--- x ogni id_path popola una riga 
		k_ind = 1
		do while k_ind <= k_nr_id_docpath and kst_esito.esito <> kkg_esito.ko
		
			kst_tab_docprod.x_datins = kGuf_data_base.prendi_x_datins()
			kst_tab_docprod.x_utente = kGuf_data_base.prendi_x_utente()

		
//--- esiste già la riga? 	 		
			kst_tab_docprod.id_docpath = kst_tab_docpath[k_ind].id_docpath
			kst_tab_docprod.id_docprod = if_esiste_id_doc_id_path(kst_tab_docprod )	
			if kst_tab_docprod.id_docprod = 0 then

				kst_tab_docprod.caricato_ts = kst_tab_docprod.x_datins
				kst_tab_docprod.caricato_utente = kst_tab_docprod.x_utente
				kst_tab_docprod.esportato_ts = datetime(date(0))
				kst_tab_docprod.esportato_utente = ""
				kst_tab_docprod.rigenerato_ts = datetime(date(0))
				kst_tab_docprod.rigenerato_utente = ""
				kst_tab_docprod.doc_esporta = ki_doc_esporta_si

//--- non esiste faccio la INSERT			
//id_docprod,   
				INSERT INTO docprod  
								( 
								  descr,   
								  doc_esporta,   
								  caricato_ts,   
								  caricato_utente,   
								  esportato_ts,   
								  esportato_utente,   
								  rigenerato_ts,   
								  rigenerato_utente,   
								  doc_nome,   
								  id_docpath,   
								  id_doc,   
								  doc_num,   
								  doc_data,   
								  doc_esporta_prefpath,   
								  doc_tabella,   
								  id_cliente,
								  x_datins,   
								  x_utente) 
					  VALUES ( 
								  :kst_tab_docprod.descr,   
								  :kst_tab_docprod.doc_esporta,   
								  :kst_tab_docprod.caricato_ts,   
								  :kst_tab_docprod.caricato_utente,   
								  :kst_tab_docprod.esportato_ts,   
								  :kst_tab_docprod.esportato_utente,   
								  :kst_tab_docprod.rigenerato_ts,   
								  :kst_tab_docprod.rigenerato_utente,   
								  :kst_tab_docprod.doc_nome,   
								  :kst_tab_docprod.id_docpath,   
								  :kst_tab_docprod.id_doc,   
								  :kst_tab_docprod.doc_num,   
								  :kst_tab_docprod.doc_data,   
								  :kst_tab_docprod.doc_esporta_prefpath,   
								  :kst_tab_docprod.doc_tabella,   
								  :kst_tab_docprod.id_cliente,   
								  :kst_tab_docprod.x_datins,   
								  :kst_tab_docprod.x_utente)   
						using sqlca;
					

//--- recupera il valore serial
				if sqlca.sqlcode = 0 then
					kst_tab_docprod.id_docprod = get_id_docprod_max()
					//kst_tab_docprod.id_docprod = long(sqlca.SQLReturnData) 
				end if
		
		
			else
//--- esiste già: allora aggiorna	
	
//--- già esportato? allora imposta dati Rigenerato
				if if_esportato(kst_tab_docprod) then
//					kst_tab_docprod.doc_esporta = ki_doc_esporta_NO 
					kst_tab_docprod.rigenerato_ts = kst_tab_docprod.x_datins
					kst_tab_docprod.rigenerato_utente =kst_tab_docprod.x_utente
				else
//					kst_tab_docprod.doc_esporta = ki_doc_esporta_si 
				end if
				kst_tab_docprod.descr += "  (RIGENERATO) "  

				update docprod
							  set descr = :kst_tab_docprod.descr   
//								  ,doc_esporta = :kst_tab_docprod.doc_esporta   
								  ,id_cliente = :kst_tab_docprod.id_cliente   
								  ,rigenerato_ts = :kst_tab_docprod.rigenerato_ts   
								  ,rigenerato_utente = :kst_tab_docprod.rigenerato_utente   
								  ,doc_esporta_prefpath = :kst_tab_docprod.doc_esporta_prefpath   
								  ,x_datins = :kst_tab_docprod.x_datins
								  ,x_utente = :kst_tab_docprod.x_utente
					where id_docprod = :kst_tab_docprod.id_docprod
						using sqlca;

//									  ,doc_nome = :kst_tab_docprod.doc_nome   
//									  ,caricato_ts = :kst_tab_docprod.caricato_ts   
//									  ,caricato_utente = :kst_tab_docprod.caricato_utente   
//									  ,esportato_ts = :kst_tab_docprod.esportato_ts   
//									  ,esportato_utente = :kst_tab_docprod.esportato_utente   
//									  ,id_docpath = :kst_tab_docprod.id_docpath   
//									  ,id_doc = :kst_tab_docprod.id_doc   
//									  ,doc_num = :kst_tab_docprod.doc_num   
//									  ,doc_data = :kst_tab_docprod.doc_data   
//									  ,doc_tabella = :kst_tab_docprod.doc_tabella   
//									  ,id_cliente = :kst_tab_docprod.id_cliente

				end if
	
				if sqlca.sqlcode >= 0 then
				else
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Aggiorna Archivio rif. 'Esportazione Documenti' (docprod doc_num= " + string(kst_tab_docprod.doc_num) +"):" + trim(sqlca.SQLErrText)
					kst_esito.esito = kkg_esito.db_ko
				end if
				
					
				k_ind ++
				
			loop
				
      //---- COMMIT.... 
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				if isvalid(kuf1_doctipo) then destroy kuf1_doctipo	  
				if isvalid(kuf1_docpath) then destroy kuf1_docpath
				throw kguo_exception
				
			else
				if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
				
				k_return = true  // OK 
				
				
			end if
		
	 	        
		catch (uo_exception kuo_exception)
			if isvalid(kuf1_doctipo) then destroy kuf1_doctipo	  
			if isvalid(kuf1_docpath) then destroy kuf1_docpath
   	     	throw kuo_exception
         
		finally
			if isvalid(kuf1_doctipo) then destroy kuf1_doctipo	  
			if isvalid(kuf1_docpath) then destroy kuf1_docpath
			
			
		end try
		
	end if


return k_return

end function

public function boolean tb_add_ddt (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek di tipo BOLLA DI SPEDIZIONE alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod doc_num / doc_data / doc_id / id_cliente
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo

//--- Nome del Documento e dscrizione: sono personalizzati x tipo documento
//	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "DDT" + string(kst_tab_docprod.id_doc) + "N" + string(kst_tab_docprod.doc_num) + "_" + string(year(kst_tab_docprod.doc_data)) + ".pdf" 
	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "_DDT_" + string(kst_tab_docprod.doc_data, "yyyy_mm_dd") + "_" + string(kst_tab_docprod.doc_num) + ".pdf" 
	kst_tab_docprod.descr = "DDT nr. " + string(kst_tab_docprod.doc_num) + " del " + string(kst_tab_docprod.doc_data) + "  -  id: " + string(kst_tab_docprod.id_doc)  
	kst_tab_docprod.doc_tabella = ki_doc_tabella_ddt
	
	k_return = tb_add(kst_tab_docprod, kuf1_doctipo.kki_tipo_ddt )
	
	

return k_return

end function

public function boolean if_esportato (st_tab_docprod kst_tab_docprod) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------
//--- Controlla se Documento già esportato
//--- 
//--- Input: kst_tab_docprod.id_docprod
//--- Out:      
//--- Ritorna: TRUE = già esportato
//--- 
//--- lancia UO_EXCEPTION
//---
//---------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 esportato_ts
    INTO 
	 	  :kst_tab_docprod.esportato_ts 
        FROM docprod
        WHERE ( id_docprod = :kst_tab_docprod.id_docprod   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. rif. Esportazione Documenti (docprod id=" + string(kst_tab_docprod.id_docprod) + "): " + trim(sqlca.SQLErrText)
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

	if kst_tab_docprod.esportato_ts > datetime(date(0)) then
		k_return = true
	end if

return k_return

end function

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_esporta_documenti )



end subroutine

public subroutine log_destroy () throws uo_exception;//
//--- svuota il LOG
//
st_tab_esito_operazioni kst_tab_esito_operazioni

kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni)
	
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni



end subroutine

public function long u_esporta (st_docprod_esporta kst_docprod_esporta);//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo indicato 
//---
//--- Inp: st_tab_docprod []  id_docprod, id_doc, doc_data, doc_num, tipo  
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return 
kuf_doctipo kuf1_doctipo
pointer k_pointer


try

	k_pointer = setpointer(HourGlass!)

	choose case kst_docprod_esporta.k_tipo
			
		case kuf1_doctipo.kki_tipo_fatture
			k_return = u_esporta_fatture(kst_docprod_esporta)
			
		case kuf1_doctipo.kki_tipo_ddt
			k_return = u_esporta_ddt(kst_docprod_esporta)
			
		case kuf1_doctipo.kki_tipo_attestati
			k_return = u_esporta_attestati(kst_docprod_esporta)

		case kuf1_doctipo.kki_tipo_contr_co
			k_return = u_esporta_contr_co(kst_docprod_esporta)

		case kuf1_doctipo.kki_tipo_contr_rd
			k_return = u_esporta_contr_rd(kst_docprod_esporta)
			
	end choose

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	setpointer(k_pointer)


end try


return k_return
end function

public function long u_esporta_fatture (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo FATTURA indicati nell'array
//---
//--- Inp: st_tab_docprod []  id_docprod, id_doc, doc_data, doc_num
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_item_array, k_item, k_riga_ds, k_righe_esportate=0, k_id_docprod_precedente = 0, k_item_txt=0, k_doc_esportati=0
int k_nr_errori=0
string k_nome_file=""
string k_errore=""
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
ds_fatture kds_fatture
st_esito kst_esito
st_tab_arfa kst_tab_arfa
st_tab_clienti_mkt kst_tab_clienti_mkt
st_uf_docpath kst_uf_docpath
st_txt_docprod kst_txt_docprod[]


try

	kds_fatture = create ds_fatture
	kuf1_fatt = create kuf_fatt
	kuf1_clienti = create kuf_clienti
	

	k_item_array = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	
	for k_item = 1 to k_item_array

		if kst_docprod_esporta.kst_tab_docprod[k_item].id_doc > 0 then
			
//--- legge il path + nome del file pdf
			kst_tab_arfa.id_fattura = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
			kuf1_fatt.get_cliente(kst_tab_arfa)
			if kst_tab_arfa.clie_3 = 0 then
				kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
				k_nr_errori ++
				if k_nr_errori > 15 then
					if k_nr_errori = 15 then
						k_errore += "...troppi errori da visualizzare...."
					end if
				else
					k_errore += "Documento Fattura n." + string( kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, codice Cliente non Trovato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod) +")! ~n~r"
				end if
			else	
				try
					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_arfa.clie_3
					kst_uf_docpath = get_path(kst_docprod_esporta.kst_tab_docprod[k_item])
					k_nome_file = get_nomefile(kst_docprod_esporta.kst_tab_docprod[k_item])
					
					k_riga_ds = kds_fatture.insertrow(0)
					kds_fatture.setitem(k_riga_ds,"id_docprod", kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod)
					kds_fatture.setitem(k_riga_ds,"num_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_num)
					kds_fatture.setitem(k_riga_ds,"data_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_data)
					kds_fatture.setitem(k_riga_ds,"id_fattura", kst_docprod_esporta.kst_tab_docprod[k_item].id_doc)
					kds_fatture.setitem(k_riga_ds,"file_prodotto", kst_uf_docpath.k_path_interno + trim(k_nome_file))
					kds_fatture.setitem(k_riga_ds,"modo_stampa", "" )
					kds_fatture.setitem(k_riga_ds,"prof", "")
					kds_fatture.setitem(k_riga_ds,"diprova", "")
					kds_fatture.setitem(k_riga_ds,"sel", 1)
					kds_fatture.setitem(k_riga_ds,"esporta", "S")
	
	//--- campi da mettere in un file formato testo da passare alla Procedura di Gestione Documentale
					k_item_txt++
					kst_txt_docprod[k_item_txt].id_doc = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
					kst_txt_docprod[k_item_txt].doc_nome = mid(trim(k_nome_file),2)
					kst_txt_docprod[k_item_txt].doc_tipo = "FAT"
					kst_txt_docprod[k_item_txt].doc_num = kst_docprod_esporta.kst_tab_docprod[k_item].doc_num
					kst_txt_docprod[k_item_txt].doc_data = kst_docprod_esporta.kst_tab_docprod[k_item].doc_data
					kst_txt_docprod[k_item_txt].doc_esporta_prefpath =  kst_uf_docpath.k_path_interno
					kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente
					kst_txt_docprod[k_item_txt].num_int = 0
					kst_txt_docprod[k_item_txt].data_int = date(0)
					kst_txt_docprod[k_item_txt].id_meca = 0
					kst_txt_docprod[k_item_txt].caricato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_ts
					kst_txt_docprod[k_item_txt].caricato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_utente
					kst_txt_docprod[k_item_txt].esportato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_ts
					kst_txt_docprod[k_item_txt].esportato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_utente
					kst_txt_docprod[k_item_txt].rigenerato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_ts
					kst_txt_docprod[k_item_txt].rigenerato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_utente
					
					
		//--- se e' previsto il documento Uso ESTERNO fa la duplica quindi carica altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_esterno)) > 0 then
						
		//--- get se devo esportare il documento, dato presente nel Cliente
//						kst_tab_arfa.id_fattura = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
//						kuf1_fatt.get_cliente(kst_tab_arfa)
						kst_tab_clienti_mkt.id_cliente = kst_tab_arfa.clie_3
						kuf1_clienti.get_doc_esporta(kst_tab_clienti_mkt)
						if kst_tab_clienti_mkt.doc_esporta	= kuf1_clienti.kki_doc_esporta_si then
						
							k_riga_ds = kds_fatture.insertrow(0)
							kds_fatture.setitem(k_riga_ds,"id_docprod", kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod)
							kds_fatture.setitem(k_riga_ds,"num_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_num)
							kds_fatture.setitem(k_riga_ds,"data_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_data)
							kds_fatture.setitem(k_riga_ds,"id_fattura", kst_docprod_esporta.kst_tab_docprod[k_item].id_doc)
							kds_fatture.setitem(k_riga_ds,"file_prodotto", kst_uf_docpath.k_path_esterno + trim(k_nome_file))
							kds_fatture.setitem(k_riga_ds,"modo_stampa", "" )
							kds_fatture.setitem(k_riga_ds,"prof", "")
							kds_fatture.setitem(k_riga_ds,"diprova", "")
							kds_fatture.setitem(k_riga_ds,"sel", 1)
							kds_fatture.setitem(k_riga_ds,"esporta", "S")
						end if
					end if
					
		//--- se e' previsto il documento Uso DOCUMENTALE aggiunge altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_documentale )) > 0 then
						
						k_riga_ds = kds_fatture.insertrow(0)
						kds_fatture.setitem(k_riga_ds,"id_docprod", kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod)
						kds_fatture.setitem(k_riga_ds,"num_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_num)
						kds_fatture.setitem(k_riga_ds,"data_fatt", kst_docprod_esporta.kst_tab_docprod[k_item].doc_data)
						kds_fatture.setitem(k_riga_ds,"id_fattura", kst_docprod_esporta.kst_tab_docprod[k_item].id_doc)
						kds_fatture.setitem(k_riga_ds,"file_prodotto", kst_uf_docpath.k_path_documentale + trim(k_nome_file))
						kds_fatture.setitem(k_riga_ds,"modo_stampa", "" )
						kds_fatture.setitem(k_riga_ds,"prof", "")
						kds_fatture.setitem(k_riga_ds,"diprova", "")
						kds_fatture.setitem(k_riga_ds,"sel", 1)
						kds_fatture.setitem(k_riga_ds,"esporta", "S")
						
					end if
					
				catch (uo_exception kuo1_exception)
					kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
					k_nr_errori ++
					if k_nr_errori > 15 then
						if k_nr_errori = 15 then
							k_errore += "...troppi errori da visualizzare...."
						end if
					else
						k_errore += kuo1_exception.get_errtext() + "~n~r"
					end if
				end try
				
			end if
		end if
		
	end for	
	
	
//--- 	
	if k_riga_ds > 0 then
		
//--- lancia esportazione PDF
		k_righe_esportate = kuf1_fatt.stampa_fattura_digitale(kds_fatture )
		if k_righe_esportate > 0 then
			
//--- Devo Aggiornare?		
			if kst_docprod_esporta.k_aggiorna_docprod then
			
				for k_item = 1 to k_item_array
			
					try
						if kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod > 0 and  kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod <> k_id_docprod_precedente then
							k_id_docprod_precedente = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod  // evita di riaggiornare lo stesso documento
							
							//--- se tutto OK marca il doc come esportato altrimenti lo toglie da quelli da esportare
							if kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no then
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "S"
								set_esportato_no(kst_docprod_esporta.kst_tab_docprod[k_item]) 
							else
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "N"
								if set_esportato(kst_docprod_esporta.kst_tab_docprod[k_item]) then 
									
															
								end if
								kst_tab_arfa.id_fattura = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
								kst_tab_arfa.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
								kst_tab_arfa.st_tab_g_0.esegui_commit = "S"
								kuf1_fatt.set_id_docprod( kst_tab_arfa )
								
								k_doc_esportati++
							
							end if
						end if
					
					catch (uo_exception kuo2_exception)
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo2_exception.get_errtext() + "~n~r"
						end if
						
					end try
					
				end for	
				
//--- Faccio la COMMIT					
				if k_righe_esportate > 0 then
					kGuf_data_base.db_commit_1( )
				end if
			
//--- se tutto OK e devo AGGIORNARE allora scrivo file txt con i documenti generati in PDF
				u_esporta_txt_datidoc(kst_txt_docprod[])
			
			end if
		end if
	end if
	
	k_return = k_doc_esportati
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	destroy kds_fatture
	destroy kuf1_fatt
	destroy kuf1_clienti

//--- se si era verificato un errore ma elab proseguita....
	if k_errore > " " then

		if k_doc_esportati > 0 then
			k_errore += "~n~rSono stati comunque esportati " + string(k_doc_esportati) + " documenti in modo corretto."
		end if

		kst_esito.esito = kkg_esito.ko 
		kst_esito.sqlerrtext = k_errore
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

end try
	

return k_return

end function

private function boolean set_esportato (readonly st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggorna a Esportato il rek in tabella docprod 
//--- 
//--- Inp: st_tab_docprod  id_docprod
//--- Out: 
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
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
//   kuf1_sicurezza = create kuf_sicurezza
//   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//   destroy kuf1_sicurezza
//
//   if not k_autorizza then
//   
//      kst_esito.sqlcode = sqlca.sqlcode
//      kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//      kst_esito.esito = kkg_esito.no_aut
//      kguo_exception.inizializza( )
//      kguo_exception.set_esito(kst_esito)
//      throw kguo_exception
//   
//   end if
	
   if kst_tab_docprod.id_docprod > 0 then
      
      try

		kst_tab_docprod.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_docprod.x_utente = kGuf_data_base.prendi_x_utente()
		     
		if if_esportato(kst_tab_docprod ) then
			kst_tab_docprod.rigenerato_ts = kst_tab_docprod.x_datins
			kst_tab_docprod.rigenerato_utente = kst_tab_docprod.x_utente
		else
			kst_tab_docprod.esportato_ts = kst_tab_docprod.x_datins
			kst_tab_docprod.esportato_utente = kst_tab_docprod.x_utente
		end if

		kst_tab_docprod.doc_esporta = ki_doc_esporta_no
		
		
		update docprod
							  set doc_esporta = :kst_tab_docprod.doc_esporta
								  ,esportato_ts = :kst_tab_docprod.esportato_ts   
								  ,esportato_utente = :kst_tab_docprod.esportato_utente   
								  ,x_datins = :kst_tab_docprod.x_datins
								  ,x_utente = :kst_tab_docprod.x_utente
					where id_docprod = :kst_tab_docprod.id_docprod
						using sqlca;


		if sqlca.sqlcode >= 0 then
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna rif. a 'Documento Esportato' (docprod id_docprod= " + string(kst_tab_docprod.id_docprod) +"):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
			
			
      //---- COMMIT.... 
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
			k_return = true  // OK
			
		end if
		
         
      catch (uo_exception kuo_exception)
         throw kuo_exception
         
      end try
		
   end if


return k_return

end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_docprod kst_tab_docprod);//
//=== 
//====================================================================
//=== Operazione di Anteprima
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
long k_n_ddt_stampate=0
st_open_w kst_open_w
st_esito kst_esito 
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
datawindow kdw_nullo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = this.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_docprod.id_docprod > 0 then

//--- retrive dell'attestato 
	
		try 

			kdw_anteprima.dataobject = "d_docprod"
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	

	//--- retrive 
			k_rc=kdw_anteprima.retrieve(kst_tab_docprod.id_docprod)
			
		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()

		finally
				
		end try
		

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Spedizione da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.err_logico
		
	end if
end if


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
string k_dataobject, k_id_programma
st_tab_docprod kst_tab_docprod
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_elenco kuf1_elenco
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza


try
	SetPointer(kkg.pointer_attesa)
	
	
	kdsi_elenco_output = create datastore
	kuf1_elenco = create kuf_elenco

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	
	kst_open_w.flag_modalita = kkg_flag_modalita.elenco
	
	choose case a_campo_link
	
		case "id_docprod" 
			kst_tab_docprod.id_docprod = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
			if kst_tab_docprod.id_docprod > 0 then
				kst_open_w.key1 = "Esportazione Documento  (id =" + trim(string(kst_tab_docprod.id_docprod)) + ") " 
				k_id_programma = this.get_id_programma(kst_open_w.flag_modalita)
			else
				k_return = false
			end if
	
	
		case "b_docprod"
			kst_tab_docprod.id_docprod = adw_link.getitemnumber(adw_link.getrow(), "id_docprod")
			if kst_tab_docprod.id_docprod > 0 then
				anteprima_file(kst_tab_docprod)
			end if
			k_return = true	
	
		case "id_docprod_file"
			kst_tab_docprod.id_docprod = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
			if kst_tab_docprod.id_docprod > 0 then
				anteprima_file(kst_tab_docprod)
			end if
			k_return = true	
		
	
	end choose
	
	
	if k_return and a_campo_link = "id_docprod" then
	
		kst_open_w.id_programma = k_id_programma 
		
		//--- controlla se utente autorizzato alla funzione in atto
		k_return = if_sicurezza(kst_open_w.flag_modalita)
//		kuf1_sicurezza = create kuf_sicurezza
//		k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//		destroy kuf1_sicurezza
		
		if not k_return then
		
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Operazione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
			kst_esito.esito = kkg_esito.no_aut
		
		else
				kdsi_elenco_output.dataobject = k_dataobject		
				kdsi_elenco_output.settransobject(sqlca)
		
				kdsi_elenco_output.reset()	
				
				choose case a_campo_link
							
					case "id_docprod"
						kst_esito = anteprima ( kdsi_elenco_output, kst_tab_docprod )
						if kst_esito.esito <> kkg_esito.ok then
							kguo_exception.inizializza()
							kguo_exception.set_esito( kst_esito)
							throw kguo_exception
						end if
						k_dataobject = kdsi_elenco_output.dataobject
				
				end choose
	
		end if
	
		if kdsi_elenco_output.rowcount() > 0 then
		
			
		//--- chiamare la window di elenco
		//
		//=== Parametri : 
		//=== struttura st_open_w
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kuf1_elenco.u_open(kst_open_w)
	
	
		else
			
			kguo_exception.inizializza()
			kguo_exception.setmessage( "Nessun valore disponibile. " )
			throw kguo_exception
			
			
		end if
	
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)

end try

return k_return

end function

private function boolean anteprima_file (st_tab_docprod kst_tab_docprod);//-----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Apre a Video il file Digitale (probabile pdf)
//---
//--- Inp: kst_tab_docprod.id_docprod
//--- Out: 
//--- Rit: true = OK
//---
//--- Lancia EXCEPTION x errore
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
string k_file=""
boolean k_ret
long ll_p
st_uf_docpath kst_uf_docpath
kuf_file_explorer kuf1_file_explorer

 
try
	
	if kst_tab_docprod.id_docprod > 0 then 
		
//--- recupera  doc_data e id_cliente 	
		get_dati_doc(kst_tab_docprod)

//--- recupera nome e path 	
		kst_uf_docpath = get_path(kst_tab_docprod)	
		k_file = kst_uf_docpath.k_path_interno
		if len(k_file) > 0 then
			k_file +=KKG.PATH_SEP + get_doc_nome(kst_tab_docprod)	
		end if
		
		if len(trim(k_file)) > 0 then
			
		
			kuf1_file_explorer = create kuf_file_explorer
		
			if not kuf1_file_explorer.of_execute( k_file ) then
				
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
				kguo_exception.setmessage( "Il file non può essere aperto, probabile percorso non corretto: ~n~r" + k_file )
				kguo_exception.messaggio_utente( )
			end if
		
			destroy kuf1_file_explorer
		
			k_return = true
		
		else
			k_file=""
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
end try


return k_return 

end function

public function string get_doc_nome (st_tab_docprod kst_tab_docprod) throws uo_exception;//
//====================================================================
//=== Legge tabella Esportazione Documento per reperire il nome del file 'pdf'
//=== 
//=== Input: kst_tab_docprod.id_docprod
//=== Out:      
//=== Rit: string = nome del file
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
		 doc_nome
    INTO 
	 	  :kst_tab_docprod.doc_nome 
        FROM docprod
        WHERE ( id_docprod = :kst_tab_docprod.id_docprod   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Esportazione Documenti: " + trim(sqlca.SQLErrText)
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


	if len(trim(kst_tab_docprod.doc_nome)) > 0 then
		k_return = trim(kst_tab_docprod.doc_nome)
	end if

return k_return

end function

public function boolean get_dati_doc (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//====================================================================
//=== Legge tabella Esportazione Documento per reperire alcuni dati 
//=== 
//=== Input: kst_tab_docprod.id_docprod
//=== Out:    kst_tab_docprod. acuni valori  
//=== Rit: true = OK
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
boolean k_return = false
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 doc_num
		 ,doc_data
		 ,id_cliente
		 ,id_docpath
    INTO 
	 	  :kst_tab_docprod.doc_num 
	 	  ,:kst_tab_docprod.doc_data 
	 	  ,:kst_tab_docprod.id_cliente 
	 	  ,:kst_tab_docprod.id_docpath
        FROM docprod
        WHERE ( id_docprod = :kst_tab_docprod.id_docprod   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Esportazione Documenti: " + trim(sqlca.SQLErrText)
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


	if kst_tab_docprod.doc_num > 0 then
		k_return = true
	end if

return k_return

end function

public function boolean get_id_docpath (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//====================================================================
//=== Recupera il id_docpath da id_docprod 
//=== 
//=== Input: kst_tab_docprod.id_docprod ,  doc_tabella
//=== Out:   kst_tab_docprod.id_docpath  
//=== Rit: true = OK
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
boolean k_return = false
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_docprod.id_docprod > 0 then

   SELECT   
		 id_docpath
    INTO 
	 	  :kst_tab_docprod.id_docpath 
        FROM docprod
        WHERE id_docprod = :kst_tab_docprod.id_docprod
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Recupero ID del PATH da archivio Esportazione Documenti (docprod): "  + string(kst_tab_docprod.id_docprod) + " ~n~r" + trim(sqlca.SQLErrText)
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

else

	kst_esito.SQLErrText = "Errore durante lettura tabella Esportazione Documenti, ~n~rdati insufficienti (manca id) " 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.get_esito_descrizione(kst_esito)
	throw kguo_exception
	
end if

if kst_tab_docprod.doc_num > 0 then
	k_return = true
end if


return k_return

end function

public function string get_nomefile (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Piglia il Nome File del  DOCUMENTO    dalla tabella docprod 
//--- 
//--- Inp: st_tab_docprod. id_doc_prod 
//--- Out: 
//--- 
//--- Ritorna string = Nome_file esempio "\pippo2010.pdf"
///---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
string k_return=""
string k_path, k_file
//st_tab_docpathtipo kst_tab_docpathtipo
//st_tab_doctipo kst_tab_doctipo
//kuf_doctipo kuf1_doctipo
//kuf_docpathtipo kuf1_docpathtipo

try 
	
//	kuf1_docpathtipo = create kuf_docpathtipo
//	kuf1_doctipo = create kuf_doctipo
	
//--- piglia il path
//	k_path = get_path(kst_tab_docprod, kuf1_doctipo.kki_tipo_fatture)

//--- recupera il ID_DOCPROD	
//	if kst_tab_docprod.id_docprod > 0 then
//	else
//		
////--- se manca il ID del docpath bisogna che reperisca quello di default INTERNO		
//		if kst_tab_docprod.id_docpath > 0 then
//		else
//			kst_tab_doctipo.tipo = kuf1_doctipo.kki_tipo_fatture
//			kst_tab_doctipo.id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
//			
//			if kst_tab_doctipo.id_doctipo > 0 then
//				kst_tab_docpathtipo.id_doctipo = kst_tab_doctipo.id_doctipo
//				kst_tab_docprod.id_docpath = kuf1_docpathtipo.get_id_docpath(kst_tab_docpathtipo)
//
//			end if
//		end if
//		
//		kst_tab_docprod.doc_tabella = "arfa_testa"
//		get_it_docprod_da_id_doc(kst_tab_docprod)	
//	end if
	
//--- recupera il nome del file
	if kst_tab_docprod.id_docprod > 0 then
		k_file = get_doc_nome(kst_tab_docprod)
	else
		k_file = "NOMENONTROVATO"
	end if
	
	
	k_return = KKG.PATH_SEP + k_file

	
catch (uo_exception kuo_exception )
	throw kguo_exception

	
finally
//	destroy kuf1_docpathtipo
//	destroy kuf1_doctipo
	
end try	

return k_return

end function

public function long u_esporta_ddt (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo DDT indicati nell'array
//---
//--- Inp: st_tab_docprod []  id_docprod, id_doc, doc_data, doc_num
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_item_array, k_item, k_righe_esportate=0, k_id_docprod_precedente = 0, k_riga_pdf=0, k_item_txt=0, k_doc_esportati=0
int k_nr_errori=0
string k_nome_file=""
string k_errore=""
kuf_sped kuf1_sped
kuf_sped_ddt kuf1_sped_ddt
kuf_clienti kuf1_clienti
st_docprod_esporta kst_docprod_esporta_pdf
st_tab_docprod kst_tab_docprod
st_tab_sped kst_tab_sped
st_tab_clienti_mkt kst_tab_clienti_mkt
st_uf_docpath kst_uf_docpath
st_esito kst_esito
st_txt_docprod kst_txt_docprod[]


try

//	kds_ddt_stampa = create ds_ddt_stampa
	kuf1_sped = create kuf_sped
	kuf1_sped_ddt = create kuf_sped_ddt
	kuf1_clienti = create kuf_clienti
	

	k_item_array = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	
	for k_item = 1 to k_item_array

		if kst_docprod_esporta.kst_tab_docprod[k_item].id_doc > 0 then
			
			k_riga_pdf++
			kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
			
			
//--- leggo il cliente del documento			
			kst_tab_docprod.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
			get_id_cliente(kst_tab_docprod)
			if kst_esito.esito = kkg_esito.ok then
				kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
				k_nr_errori ++
				if k_nr_errori > 15 then
					if k_nr_errori = 15 then
						k_errore += "...troppi errori da visualizzare...."
					end if
				else
					k_errore += "Documento DDT n." + string(kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, codice Cliente non Trovato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod) +")! ~n~r"
				end if
			else	
				try
					kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_docprod.id_cliente
			
//--- legge il path e Nome file
					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_docprod.id_cliente
					kst_uf_docpath = get_path(kst_docprod_esporta.kst_tab_docprod[k_item])
					if len(trim(kst_uf_docpath.k_path_interno)) > 0 then 
						k_nome_file = get_nomefile(kst_docprod_esporta.kst_tab_docprod[k_item])
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_interno + k_nome_file
					end if
					kst_docprod_esporta_pdf.duplica[k_riga_pdf] = false
				
//--- campi da mettere in un file formato testo da passare alla Procedura di Gestione Documentale
					k_item_txt++
					kst_txt_docprod[k_item_txt].id_doc = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
					kst_txt_docprod[k_item_txt].doc_nome = mid(trim(k_nome_file),2)
					kst_txt_docprod[k_item_txt].doc_tipo = "DDT"
					kst_txt_docprod[k_item_txt].doc_num = kst_docprod_esporta.kst_tab_docprod[k_item].doc_num
					kst_txt_docprod[k_item_txt].doc_data = kst_docprod_esporta.kst_tab_docprod[k_item].doc_data
					kst_txt_docprod[k_item_txt].doc_esporta_prefpath =  kst_uf_docpath.k_path_interno
					kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente
					kst_txt_docprod[k_item_txt].num_int = 0
					kst_txt_docprod[k_item_txt].data_int = date(0)
					kst_txt_docprod[k_item_txt].id_meca = 0
					kst_txt_docprod[k_item_txt].caricato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_ts
					kst_txt_docprod[k_item_txt].caricato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_utente
					kst_txt_docprod[k_item_txt].esportato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_ts
					kst_txt_docprod[k_item_txt].esportato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_utente
					kst_txt_docprod[k_item_txt].rigenerato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_ts
					kst_txt_docprod[k_item_txt].rigenerato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_utente

//--- se e' previsto il documento Uso ESTERNO fa la duplica quindi carica altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_esterno)) > 0 then
						
						kst_uf_docpath.k_path_esterno += k_nome_file
				
//--- get se devo esportare il documento, dato presente nel Cliente
						kst_tab_clienti_mkt.id_cliente = kst_tab_docprod.id_cliente
						kuf1_clienti.get_doc_esporta(kst_tab_clienti_mkt)
						if kst_tab_clienti_mkt.doc_esporta	= kuf1_clienti.kki_doc_esporta_si then
						
							k_riga_pdf ++
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
							
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_docprod.id_cliente 
							kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_esterno
							kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true   // copia solo il file senza rifare la stampa
							
						end if
					end if
			
//--- se e' previsto il documento Uso DOCUMENTALE aggiunge altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_documentale )) > 0 then
		
						kst_uf_docpath.k_path_documentale += k_nome_file
						
						k_riga_pdf ++
						kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
						
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_documentale  // stavolta fa il doc x DOCUMENTALE
						kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true
						
					end if
				
				catch (uo_exception kuo1_exception)
					kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
					k_nr_errori ++
					if k_nr_errori > 15 then
						if k_nr_errori = 15 then
							k_errore += "...troppi errori da visualizzare...."
						end if
					else
						k_errore += kuo1_exception.get_errtext() + "~n~r"
					end if
				end try
		
			end if
		end if
		
	end for	
	
	
//--- 	
	if k_riga_pdf > 0 then
		
//--- lancia esportazione PDF
		k_righe_esportate = kuf1_sped_ddt.stampa_ddt_esporta_digitale(kst_docprod_esporta_pdf )

//--- Devo Aggiornare?		
		if k_righe_esportate > 0 then
			if kst_docprod_esporta.k_aggiorna_docprod then
			
				for k_item = 1 to k_item_array
			
					try
			
						if kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod > 0 and  kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod <> k_id_docprod_precedente then
							k_id_docprod_precedente = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod  // evita di riaggiornare lo stesso documento
							
							//--- se tutto OK marca il doc come esportato altrimenti lo toglie da quelli da esportare
							if kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no then
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "S"
								set_esportato_no(kst_docprod_esporta.kst_tab_docprod[k_item]) 
							else
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "N"
								if set_esportato(kst_docprod_esporta.kst_tab_docprod[k_item]) then 
									
															
								end if
								kst_tab_sped.id_sped = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
								kst_tab_sped.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
								kst_tab_sped.st_tab_g_0.esegui_commit = "S"
								kuf1_sped.set_id_docprod( kst_tab_sped )
								
								k_doc_esportati++
							end if
						end if
						
					catch (uo_exception kuo2_exception)
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo2_exception.get_errtext() + "~n~r"
						end if
							
					end try
					
				end for	
				
//--- Faccio la COMMIT					
				if k_righe_esportate > 0 then
					kGuf_data_base.db_commit_1( )
				end if
			
//--- se tutto OK e devo AGGIORNARE allora scrivo file txt con i documenti generati in PDF
				u_esporta_txt_datidoc(kst_txt_docprod[])
			end if
		end if
	
	end if
	
	k_return = k_doc_esportati
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
//	destroy kds_ddt_stampa
	destroy kuf1_sped
	destroy kuf1_sped_ddt
	destroy kuf1_clienti
	
//--- se si erano verificati errori ma elab proseguita....
	if k_errore > " " then
		if k_doc_esportati > 0 then
			k_errore += "~n~rSono stati comunque esportati " + string(k_doc_esportati) + " documenti in modo corretto."
		end if
		kst_esito.esito = kkg_esito.ko 
		kst_esito.sqlerrtext = k_errore
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

end try
	

return k_return

end function

public function boolean tb_add_contratti_co (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek di tipo CONTRATTO COMMERCIALE alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod doc_num / doc_data / doc_id / id_cliente
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo

//--- Nome del Documento e dscrizione: sono personalizzati x tipo documento
//	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "CCO" + string(kst_tab_docprod.id_doc) + "N" + string(kst_tab_docprod.doc_num) + "_" + string(year(kst_tab_docprod.doc_data)) + ".pdf" 
	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "_CCO_" + string(kst_tab_docprod.doc_data, "yyyy_mm_dd") + "_" + string(kst_tab_docprod.doc_num) + ".pdf" 
	kst_tab_docprod.descr = "CNTR.COMMERCIALE nr. " + string(kst_tab_docprod.doc_num) + " del " + string(kst_tab_docprod.doc_data) + "  -  id: " + string(kst_tab_docprod.id_doc)  
	kst_tab_docprod.doc_tabella = ki_doc_tabella_contr_co
	
	k_return = tb_add(kst_tab_docprod, kuf1_doctipo.kki_tipo_contr_co )
	
	

return k_return

end function

public function boolean tb_add_contratti_rd (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek di tipo CONTRATTO RICERCA E SVILUPPO alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod doc_num / doc_data / doc_id / id_cliente
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo

//--- Nome del Documento e dscrizione: sono personalizzati x tipo documento
//	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "CRD" + string(kst_tab_docprod.id_doc) + "N" + string(kst_tab_docprod.doc_num) + "_" + string(year(kst_tab_docprod.doc_data)) + ".pdf" 
	kst_tab_docprod.doc_nome = "C" + string(kst_tab_docprod.id_cliente, "00000") + "_CRD_"  + string(kst_tab_docprod.doc_data, "yyyy_mm_dd") + "_" + string(kst_tab_docprod.doc_num) + ".pdf" 

	kst_tab_docprod.descr = "CNTR. R.& D. nr. " + string(kst_tab_docprod.doc_num) + " del " + string(kst_tab_docprod.doc_data) + "  -  id: " + string(kst_tab_docprod.id_doc)  
	kst_tab_docprod.doc_tabella = ki_doc_tabella_contr_rd
	
	k_return = tb_add(kst_tab_docprod, kuf1_doctipo.kki_tipo_contr_rd )
	
	

return k_return

end function

public function long u_esporta_contr_co (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo CONTRATTI COMMERCIALI indicati nell'array
//---
//--- Inp: st_tab_docprod []  id_docprod, id_doc, doc_data, doc_num
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_item_array, k_item, k_riga_pdf, k_righe_esportate=0, k_id_docprod_precedente = 0,k_item_txt=0, k_doc_esportati=0
int k_nr_errori=0
string k_nome_file=""
string k_errore=""
kuf_contratti_co kuf1_contratti_co
kuf_clienti kuf1_clienti
st_docprod_esporta kst_docprod_esporta_pdf
st_tab_contratti_co kst_tab_contratti_co
st_tab_clienti_mkt kst_tab_clienti_mkt
st_uf_docpath kst_uf_docpath
st_esito kst_esito
st_txt_docprod kst_txt_docprod[]


try

	kuf1_contratti_co = create kuf_contratti_co
	kuf1_clienti = create kuf_clienti
	

	k_item_array = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	
	for k_item = 1 to k_item_array

		if kst_docprod_esporta.kst_tab_docprod[k_item].id_doc > 0 then
			
			k_riga_pdf++
			kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
			
			
//--- leggo il cliente del documento			
			kst_tab_contratti_co.id_contratto_co =  kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
			kst_esito = kuf1_contratti_co.get_id_cliente(kst_tab_contratti_co)
			if kst_esito.esito <> kkg_esito.ok then
				kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
				k_nr_errori ++
				if k_nr_errori > 15 then
					if k_nr_errori = 15 then
						k_errore += "...troppi errori da visualizzare...."
					end if
				else
					k_errore += "Documento Contr.Commerciale n." + string( kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, codice Cliente non Trovato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod) +")! ~n~r"
				end if
			else
				
				try
					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_contratti_co.id_cliente 
			
//--- legge il path e Nome file
					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_contratti_co.id_cliente
					kst_uf_docpath = get_path(kst_docprod_esporta.kst_tab_docprod[k_item])
					if len(trim(kst_uf_docpath.k_path_interno)) > 0 then 
						k_nome_file = get_nomefile(kst_docprod_esporta.kst_tab_docprod[k_item])
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_interno + k_nome_file
					end if
					kst_docprod_esporta_pdf.duplica[k_riga_pdf] = false
				
//--- campi da mettere in un file formato testo da passare alla Procedura di Gestione Documentale
					k_item_txt++
					kst_txt_docprod[k_item_txt].id_doc = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
					kst_txt_docprod[k_item_txt].doc_nome = mid(trim(k_nome_file),2)
					kst_txt_docprod[k_item_txt].doc_tipo = "CCO"
					kst_txt_docprod[k_item_txt].doc_num = kst_docprod_esporta.kst_tab_docprod[k_item].doc_num
					kst_txt_docprod[k_item_txt].doc_data = kst_docprod_esporta.kst_tab_docprod[k_item].doc_data
					kst_txt_docprod[k_item_txt].doc_esporta_prefpath =  kst_uf_docpath.k_path_interno
		//			kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta_pdf.kst_tab_docprod[k_item].id_cliente
					kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente
					kst_txt_docprod[k_item_txt].num_int = 0
					kst_txt_docprod[k_item_txt].data_int = date(0)
					kst_txt_docprod[k_item_txt].id_meca = 0
					kst_txt_docprod[k_item_txt].caricato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_ts
					kst_txt_docprod[k_item_txt].caricato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_utente
					kst_txt_docprod[k_item_txt].esportato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_ts
					kst_txt_docprod[k_item_txt].esportato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_utente
					kst_txt_docprod[k_item_txt].rigenerato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_ts
					kst_txt_docprod[k_item_txt].rigenerato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_utente
			
//--- se e' previsto il documento Uso ESTERNO fa la duplica quindi carica altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_esterno)) > 0 then
						
						kst_uf_docpath.k_path_esterno += k_nome_file
				
//--- get se devo esportare il documento, dato presente nel Cliente
						kst_tab_clienti_mkt.id_cliente = kst_tab_contratti_co.id_cliente
						kuf1_clienti.get_doc_esporta(kst_tab_clienti_mkt)
						if kst_tab_clienti_mkt.doc_esporta	= kuf1_clienti.kki_doc_esporta_si then
						
							k_riga_pdf ++
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
							
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_contratti_co.id_cliente 
							kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_esterno
							kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true  // fa la copia del file senza rifare la stampa
							
						end if
					end if
					
		//--- se e' previsto il documento Uso DOCUMENTALE aggiunge altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_documentale )) > 0 then
		
						kst_uf_docpath.k_path_documentale += k_nome_file
						
						k_riga_pdf ++
						kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
						
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_documentale  // stavolta fa il doc x DOCUMENTALE
						kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true
						
					end if
					
					
				catch (uo_exception kuo1_exception)
					kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
					k_nr_errori ++
					if k_nr_errori > 15 then
						if k_nr_errori = 15 then
							k_errore += "...troppi errori da visualizzare...."
						end if
					else
						k_errore += kuo1_exception.get_errtext() + "~n~r"
					end if
				end try
			
			end if
		
		end if
		
	end for	
	
	
//--- 	
	if k_riga_pdf > 0 then
		
//--- lancia esportazione PDF
		k_righe_esportate = kuf1_contratti_co.stampa_esporta_digitale(kst_docprod_esporta_pdf )

//--- Devo Aggiornare?		
		if k_righe_esportate > 0 then
			if kst_docprod_esporta.k_aggiorna_docprod then
			
				for k_item = 1 to k_item_array
			
					try
						if kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod > 0 and  kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod <> k_id_docprod_precedente then
							k_id_docprod_precedente = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod  // evita di riaggiornare lo stesso documento
							
							//--- se tutto OK marca il doc come esportato altrimenti lo toglie da quelli da esportare
							if kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no then
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "S"
								set_esportato_no(kst_docprod_esporta.kst_tab_docprod[k_item]) 
							else
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "N"
								if set_esportato(kst_docprod_esporta.kst_tab_docprod[k_item]) then 
									
															
								end if
								kst_tab_contratti_co.id_contratto_co = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
								kst_tab_contratti_co.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
								kst_tab_contratti_co.st_tab_g_0.esegui_commit = "S"
								kuf1_contratti_co.set_id_docprod( kst_tab_contratti_co )
								
								k_doc_esportati++
							end if
						end if
						
					catch (uo_exception kuo2_exception)
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo2_exception.get_errtext() + "~n~r"
						end if
						
					end try
					
				end for	
				
//--- Faccio la COMMIT					
				if k_righe_esportate > 0 then
					kGuf_data_base.db_commit_1( )
				end if
//--- se tutto OK e devo AGGIORNARE allora scrivo file txt con i documenti generati in PDF
				u_esporta_txt_datidoc(kst_txt_docprod[])
			
			end if
		end if
	
	end if
	
	k_return = k_doc_esportati
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	destroy kuf1_contratti_co
	destroy kuf1_clienti
	
//--- se si erano verificati errori ma elab proseguita....
	if k_errore > " " then
		if k_doc_esportati > 0 then
			k_errore += "~n~rSono stati comunque esportati " + string(k_doc_esportati) + " documenti in modo corretto."
		end if
		kst_esito.esito = kkg_esito.ko 
		kst_esito.sqlerrtext = k_errore
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

end try
	

return k_return

end function

public function long u_esporta_contr_rd (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo CONTRATTI RICERCA E SVILUPPO indicati nell'array
//---
//--- Inp: st_tab_docprod []  id_docprod, id_doc, doc_data, doc_num
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_item_array, k_item, k_riga_pdf, k_righe_esportate=0, k_id_docprod_precedente = 0,k_item_txt=0, k_doc_esportati=0
int k_nr_errori=0
string k_nome_file=""
string k_errore=""
kuf_contratti_rd kuf1_contratti_rd
kuf_clienti kuf1_clienti
st_docprod_esporta kst_docprod_esporta_pdf
st_tab_contratti_rd kst_tab_contratti_rd
st_tab_clienti_mkt kst_tab_clienti_mkt
st_uf_docpath kst_uf_docpath
st_esito kst_esito
st_txt_docprod kst_txt_docprod[]


try

	kuf1_contratti_rd = create kuf_contratti_rd
	kuf1_clienti = create kuf_clienti
	

	k_item_array = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	
	for k_item = 1 to k_item_array

		if kst_docprod_esporta.kst_tab_docprod[k_item].id_doc > 0 then
			
			k_riga_pdf++
			kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
			
			
//--- leggo il cliente del documento			
			kst_tab_contratti_rd.id_contratto_rd =  kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
			kst_esito = kuf1_contratti_rd.get_id_cliente(kst_tab_contratti_rd)
			if kst_esito.esito <> kkg_esito.ok then
				kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
				k_nr_errori ++
				if k_nr_errori > 15 then
					if k_nr_errori = 15 then
						k_errore += "...troppi errori da visualizzare...."
					end if
				else
					k_errore += "Documento Contr.R&D n." + string( kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, codice Cliente non Trovato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod) +")! ~n~r"
				end if
			else	
				try

					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_contratti_rd.id_cliente 
			
//--- legge il path e Nome file
					kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_contratti_rd.id_cliente
					kst_uf_docpath = get_path(kst_docprod_esporta.kst_tab_docprod[k_item])
					if len(trim(kst_uf_docpath.k_path_interno)) > 0 then 
						k_nome_file = get_nomefile(kst_docprod_esporta.kst_tab_docprod[k_item])
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_interno + k_nome_file
					end if
					kst_docprod_esporta_pdf.duplica[k_riga_pdf] = false

//--- campi da mettere in un file formato testo da passare alla Procedura di Gestione Documentale
					k_item_txt++
					kst_txt_docprod[k_item_txt].id_doc = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
					kst_txt_docprod[k_item_txt].doc_nome = mid(trim(k_nome_file),2)
					kst_txt_docprod[k_item_txt].doc_tipo = "CRS"
					kst_txt_docprod[k_item_txt].doc_num = kst_docprod_esporta.kst_tab_docprod[k_item].doc_num
					kst_txt_docprod[k_item_txt].doc_data = kst_docprod_esporta.kst_tab_docprod[k_item].doc_data
					kst_txt_docprod[k_item_txt].doc_esporta_prefpath =  kst_uf_docpath.k_path_interno
					kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente
					kst_txt_docprod[k_item_txt].num_int = 0
					kst_txt_docprod[k_item_txt].data_int = date(0)
					kst_txt_docprod[k_item_txt].id_meca = 0
					kst_txt_docprod[k_item_txt].caricato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_ts
					kst_txt_docprod[k_item_txt].caricato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_utente
					kst_txt_docprod[k_item_txt].esportato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_ts
					kst_txt_docprod[k_item_txt].esportato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_utente
					kst_txt_docprod[k_item_txt].rigenerato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_ts
					kst_txt_docprod[k_item_txt].rigenerato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_utente
					
//--- se e' previsto il documento Uso ESTERNO fa la duplica quindi carica altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_esterno)) > 0 then
						
						kst_uf_docpath.k_path_esterno += k_nome_file
		
		//--- get se devo esportare il documento, dato presente nel Cliente
						kst_tab_clienti_mkt.id_cliente = kst_tab_contratti_rd.id_cliente
						kuf1_clienti.get_doc_esporta(kst_tab_clienti_mkt)
						if kst_tab_clienti_mkt.doc_esporta	= kuf1_clienti.kki_doc_esporta_si then
						
							k_riga_pdf ++
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
							
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_contratti_rd.id_cliente 
							kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_esterno
							kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true  // fa la copia del file senza rifare la stampa
							
						end if
					end if
					
		//--- se e' previsto il documento Uso DOCUMENTALE aggiunge altra ricorrenza in array			
					if len(trim(kst_uf_docpath.k_path_documentale )) > 0 then
		
						kst_uf_docpath.k_path_documentale += k_nome_file
						
						k_riga_pdf ++
						kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
						
						kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_documentale  // stavolta fa il doc x DOCUMENTALE
						kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true
						
					end if
				
				
				catch (uo_exception kuo1_exception)
					kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
					k_nr_errori ++
					if k_nr_errori > 15 then
						if k_nr_errori = 15 then
							k_errore += "...troppi errori da visualizzare...."
						end if
					else
						k_errore += kuo1_exception.get_errtext() + "~n~r"
					end if
				end try
		
			end if
		end if
		
	end for	
	
	
//--- 	
	if k_riga_pdf > 0 then
		
//--- lancia esportazione PDF
		k_righe_esportate = kuf1_contratti_rd.stampa_esporta_digitale(kst_docprod_esporta_pdf )

//--- Devo Aggiornare?		
		if k_righe_esportate > 0 then
			if kst_docprod_esporta.k_aggiorna_docprod then
			
				for k_item = 1 to k_item_array
					try
			
						if kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod > 0 and  kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod <> k_id_docprod_precedente then
							k_id_docprod_precedente = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod  // evita di riaggiornare lo stesso documento
							
							//--- se tutto OK marca il doc come esportato altrimenti lo toglie da quelli da esportare
							if kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no then
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "S"
								set_esportato_no(kst_docprod_esporta.kst_tab_docprod[k_item]) 
							else
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "N"
								if set_esportato(kst_docprod_esporta.kst_tab_docprod[k_item]) then 
									
															
								end if
								kst_tab_contratti_rd.id_contratto_rd = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
								kst_tab_contratti_rd.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
								kst_tab_contratti_rd.st_tab_g_0.esegui_commit = "S"
								kuf1_contratti_rd.set_id_docprod( kst_tab_contratti_rd )
								
								k_doc_esportati++
							end if
						end if
						
					catch (uo_exception kuo2_exception)
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo2_exception.get_errtext() + "~n~r"
						end if
						
					end try
					
				end for	
				
//--- Faccio la COMMIT					
				if k_righe_esportate > 0 then
					kGuf_data_base.db_commit_1( )
				end if
			
//--- se tutto OK e devo AGGIORNARE allora scrivo file txt con i documenti generati in PDF
				u_esporta_txt_datidoc(kst_txt_docprod[])
			end if
		end if
	
	end if
	
	k_return = k_doc_esportati
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	destroy kuf1_contratti_rd
	destroy kuf1_clienti
	
//--- se si erano verificati errori ma elab proseguita....
	if k_errore > " " then
		if k_doc_esportati > 0 then
			k_errore += "~n~rSono stati comunque esportati " + string(k_doc_esportati) + " documenti in modo corretto."
		end if
		kst_esito.esito = kkg_esito.ko 
		kst_esito.sqlerrtext = k_errore
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

end try
	

return k_return

end function

public function boolean get_it_docprod_da_id_doc (ref st_tab_docprod kst_tab_docprod[]) throws uo_exception;//
//====================================================================
//=== Recupera array di ID_DOCPROD da ID_DOC + DOC_TABELLA (di solito un solo record)
//=== 
//=== Input: kst_tab_docprod[1].id_doc ,  doc_tabella
//=== Out:   kst_tab_docprod.id_docprod  
//=== Rit: true = OK
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
boolean k_return = false
int k_item = 0
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_docprod[1].doc_tabella)) > 0 and kst_tab_docprod[1].id_doc > 0  then

   declare c_get_it_docprod_da_id_doc cursor for 
		SELECT   id_docprod
        FROM docprod
        WHERE ( id_doc = :kst_tab_docprod[1].id_doc and doc_tabella = :kst_tab_docprod[1].doc_tabella)   
		using sqlca;

	open c_get_it_docprod_da_id_doc;
	
	if sqlca.sqlcode = 0 then
		
		k_item=1
		fetch c_get_it_docprod_da_id_doc into :kst_tab_docprod[k_item].id_docprod ;
		do while sqlca.sqlcode=0
			
			k_item++
			fetch c_get_it_docprod_da_id_doc into :kst_tab_docprod[k_item].id_docprod ;
			
		loop
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante recupero ID da archivio Esportazione Documenti (docprod): ~n~r" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	
	
		close c_get_it_docprod_da_id_doc;
		
	end if
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante tentativo di recupero ID da archivio Esportazione Documenti (docprod): ~n~r" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

else

	kst_esito.SQLErrText = "Errore durante lettura tabella Documenti da esportare, ~n~rdati insufficienti (manca id documento e/o nome tabella) " 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if

if kst_tab_docprod[1].id_docprod > 0 then
	k_return = true
end if


return k_return

end function

public function boolean tb_delete (st_tab_docprod kst_tab_docprod[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek indicati nell'array dalla tabella docprod 
//--- 
//--- Inp: st_tab_docprod[].id_docprod
//--- Out: 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
long k_item=1
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
   kst_open_w.id_programma = get_id_programma (kst_open_w.flag_modalita) //kkg_id_programma_contratti_co

//-- per non bloccare le cancellazioni da DDT ecc.. SICUREZZA sempre OK
k_autorizza = true

////--- controlla se utente autorizzato alla funzione in atto
//   kuf1_sicurezza = create kuf_sicurezza
//   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//   destroy kuf1_sicurezza
//
//   if not k_autorizza then
//   
//      kst_esito.sqlcode = sqlca.sqlcode
//      kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//      kst_esito.esito = kkg_esito.no_aut
//      kguo_exception.inizializza( )
//      kguo_exception.set_esito(kst_esito)
//      throw kguo_exception
//   
//   end if
	
   if kst_tab_docprod[1].id_docprod > 0 then
      
      try
		      
		for k_item = 1 to upperbound(kst_tab_docprod[]) 
			
//--- cancella!			
			delete from docprod
				where id_docprod = :kst_tab_docprod[k_item].id_docprod
				using sqlca;

		
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' (docprod):" + trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if

		end for
		
//---- COMMIT.... 
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_docprod[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod[1].st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docprod[1].st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod[1].st_tab_g_0.esegui_commit) then
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

public function boolean tb_delete (readonly st_tab_docprod ast_tab_docprod, string k_tipo) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek x  tipo Documento e ID alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod id_num / tipo_documento (kuf1_doctipo.kki_tipo_....)
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo
st_tab_docprod kst_tab_docprod[]


	kst_tab_docprod[1] = ast_tab_docprod

	choose case k_tipo
		case kuf1_doctipo.kki_tipo_attestati
			kst_tab_docprod[1].doc_tabella = ki_doc_tabella_attestati 
		case kuf1_doctipo.kki_tipo_ddt
			kst_tab_docprod[1].doc_tabella = ki_doc_tabella_ddt 
		case kuf1_doctipo.kki_tipo_fatture
			kst_tab_docprod[1].doc_tabella = ki_doc_tabella_fatture 
		case kuf1_doctipo.kki_tipo_contr_co
			kst_tab_docprod[1].doc_tabella = ki_doc_tabella_contr_co 
		case kuf1_doctipo.kki_tipo_contr_rd
			kst_tab_docprod[1].doc_tabella = ki_doc_tabella_contr_rd 
	end choose

	if get_it_docprod_da_id_doc(kst_tab_docprod[]) then
		k_return = tb_delete(kst_tab_docprod[])
	end if
	

return k_return

end function

public function boolean get_id_cliente (ref st_tab_docprod kst_tab_docprod) throws uo_exception;//
//====================================================================
//=== Legge tabella Esportazione Documento per reperire il codice CLIENTE
//=== 
//=== Input: kst_tab_docprod.id_docprod
//=== Out:  kst_tab_docprod.id_cliente    
//=== Rit: TRUE = OK
//=== 
//=== lancia UO_EXCEPTION
//===
//====================================================================
boolean k_return = FALSE
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



  SELECT   
		 id_cliente
    INTO 
	 	  :kst_tab_docprod.id_cliente 
        FROM docprod
        WHERE ( id_docprod = :kst_tab_docprod.id_docprod   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Esportazione Documenti: " + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		k_return = TRUE
	end if
	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.get_esito_descrizione(kst_esito)
		throw kguo_exception
	end if


	if isnull(kst_tab_docprod.id_cliente) then
		kst_tab_docprod.id_cliente = 0
	end if

return k_return

end function

public function long if_esiste_id_doc_id_path (st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Controllo se esiste un Documento per lo stesso id_path
//--- 
//--- Inp:  id_doc,  id_docpath    
//--- Out: 
//--- Ritorna long  se ESISTE torna ID_DOCPROD
//---   
//------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito
uo_exception kuo_exception
st_tab_docprod kst_tab_docprod_letto


kst_esito.esito = kkg_esito.blok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	kst_tab_docprod_letto.id_docprod = 0

	if kst_tab_docprod.id_doc > 0 and kst_tab_docprod.id_docpath > 0 then


		select max(id_docprod)
			into :kst_tab_docprod_letto.id_docprod
			from docprod
			where docprod.id_docpath = :kst_tab_docprod.id_docpath 
			          and docprod.id_doc = :kst_tab_docprod.id_doc
			using sqlca;
			
		if sqlca.sqlcode = 0 then
	
			
		else
			if sqlca.sqlcode = 100 then
			else
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore durante verifica esistenza rif. Documento da Esportare (docprod id_doc=" + string(kst_tab_docprod.id_doc) + "; id_docpath=" +  string(kst_tab_docprod.id_doc) &
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
	if isnull(kst_tab_docprod_letto.id_docprod) then kst_tab_docprod_letto.id_docprod = 0
	

end try	
	
return kst_tab_docprod_letto.id_docprod


end function

public function long u_esporta_txt_datidoc (st_txt_docprod ast_txt_docprod[]) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------
//---	Scrive file txt con i dati in sintesi del documento creato in PDF
//---
//---	Input: st_txt_docprod array con i dati dei record da scrivere
//---	Out: numero record scritti
//---
//--- Lancia EXCEPTION
//---------------------------------------------------------------------------------------------------------------------------------------
long k_return=0
string k_record
string k_path_nome_file="", k_esito=""
int k_file 
long k_bytes, k_ctr, k_item=0, k_item_max=0
boolean k_file_esiste=false
st_esito kst_esito
//st_uf_docpath kst_uf_docpath
//kuf_base kuf1_base


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_path_nome_file = kguo_path.get_doc_root( ) + kkg.path_sep

kguo_path.u_drectory_create(k_path_nome_file)

k_path_nome_file += "M2000elencoDocumentiPDF.txt"

k_item_max = upperbound(ast_txt_docprod)
	
if k_item_max > 0 then
	
	k_file_esiste = fileexists(trim(k_path_nome_file)) 

	k_file = fileopen(trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Append!)
	if k_file < 0 then
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlerrtext = "Errore in creazione File di testo con i dati dei documenti esportati (file NON aperto: " + k_path_nome_file + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- prima riga di TESTATA
	if NOT k_file_esiste then
		k_record = string("NOME FILE", "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") // 40 char 
		k_record += string("TIP", "@@@") // 3 char 
		k_record += string("NUM.DOC", "@@@@@@@@@@") // 08 char 
		k_record += string("DATA DOC", "@@@@@@@@") // 08 char 
		k_record += string("ANAGR.", "@@@@@@") // 06 char 
		k_record += string("LOTTO", "@@@@@@") // 06 char 
		k_record += string("ANNO", "@@@@") // 04 char 
		k_record += string("ID LOTTO", "@@@@@@@@@") // 09 char 
		k_record += string("PATH DOCUMENTO PDF M2000", "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") // 70 char 
		k_record += string("DOC. GENERATO", "@@@@@@@@@@@@@@@@@@@") // 19 char 
		k_record += string("USER", "@@@@@") // 5 char 
		k_record += string("DOC RIGENERATO", "@@@@@@@@@@@@@@@@@@@") // 19 char 
		k_record += string("USER", "@@@@@") // 5 char 
		k_bytes = filewrite(k_file, k_record) 
	else
		k_bytes = 1  // forza proseguimento
	end if	

//--- righe di DETTAGLIO
	do while k_bytes > 0 and k_item < k_item_max
		
		k_item++
		if ast_txt_docprod[k_item].doc_num > 0 then
			k_record = string(ast_txt_docprod[k_item].doc_nome, "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") // 40 char 
			k_record += string(ast_txt_docprod[k_item].doc_tipo, "@@@") // 3 char 
			k_record += string(ast_txt_docprod[k_item].doc_num, "00000000") // 08 char 
			k_record += string(ast_txt_docprod[k_item].doc_data, "yyyymmdd") // 08 char 
			k_record += string(ast_txt_docprod[k_item].id_cliente, "000000") // 06 char 
			if ast_txt_docprod[k_item].num_int > 0 then 
				k_record += string(ast_txt_docprod[k_item].num_int, "000000") // 06 char 
				k_record += string(ast_txt_docprod[k_item].data_int, "yyyy") // 04 char 
			else
				k_record += "      " // 06 char 
				k_record += "    "  // 04 char
			end if
			k_record += string(ast_txt_docprod[k_item].id_meca, "000000000") // 09 char 
			k_record += string(ast_txt_docprod[k_item].doc_esporta_prefpath, "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") // 70 char 
			k_record += string(ast_txt_docprod[k_item].caricato_ts, "yyyy-dd-mm hh:mm:ss") // 19 char 
			k_record += string(ast_txt_docprod[k_item].esportato_utente, "@@@@@") // 5 char 
			k_record += string(ast_txt_docprod[k_item].rigenerato_ts, "yyyy-dd-mm hh:mm:ss") // 19 char 
			k_record += string(ast_txt_docprod[k_item].rigenerato_utente, "@@@@@") // 5 char 
			
			k_bytes = filewrite(k_file, k_record) 
		end if

	loop
	
	k_return = k_item
	k_file = fileclose(k_file)

	if k_bytes < 0  then
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlerrtext = "Errore in scrittura ne File di testo con i dati dei documenti esportati (write del: " + k_path_nome_file + " i dati: " + trim(k_record) + ") "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end if




return k_return
end function

private function long u_esporta_attestati (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------------------
//---
//--- Esporta i documenti di tipo ATTESTATO indicati nell'array
//---
//--- Inp: kst_docprod_esporta.kst_tab_docprod []  id_docprod, id_doc, doc_data, doc_num
//--- Out:
//--- Rit: long numero documenti esportati 
//---
//--- Lancia EXCEPTION x errore
//---
//-------------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
long k_item_array, k_item, k_riga_pdf, k_righe_esportate=0, k_id_docprod_precedente = 0,k_item_txt=0, k_doc_esportati=0
int k_nr_errori=0
string k_nome_file=""
string k_errore=""
kuf_certif kuf1_certif
kuf_clienti kuf1_clienti
kuf_armo kuf1_armo
st_docprod_esporta kst_docprod_esporta_pdf
st_tab_docprod kst_tab_docprod
st_tab_certif kst_tab_certif
st_tab_clienti_mkt kst_tab_clienti_mkt
st_tab_meca kst_tab_meca
st_uf_docpath kst_uf_docpath
st_esito kst_esito
st_txt_docprod kst_txt_docprod[]

 
try

	kuf1_certif = create kuf_certif
	kuf1_clienti = create kuf_clienti
	kuf1_armo = create kuf_armo
	

	k_item_array = upperbound(kst_docprod_esporta.kst_tab_docprod[])
	
	for k_item = 1 to k_item_array

		if kst_docprod_esporta.kst_tab_docprod[k_item].id_doc > 0 then
			
			kst_tab_certif.id =  kst_docprod_esporta.kst_tab_docprod[k_item].id_doc

			if not kuf1_certif.if_stampato(kst_tab_certif) then   // esiste il documento ed e' stato stampato?
				kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
				k_nr_errori ++
				if k_nr_errori > 15 then
					if k_nr_errori = 15 then
						k_errore += "...troppi errori da visualizzare...."
					end if
				else
					k_errore += "Documento Attestato " + string( kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, Attestato non Trovato o non Stampato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_doc) +")! ~n~r"
				end if
			else
				
				k_riga_pdf++
				kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
			
			
//--- leggo il cliente del documento	
				kst_tab_docprod.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
				get_id_cliente(kst_tab_docprod)
				if kst_tab_docprod.id_cliente = 0 then
					kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
					k_nr_errori ++
					if k_nr_errori > 15 then
						if k_nr_errori = 15 then
							k_errore += "...troppi errori da visualizzare...."
						end if
					else
						k_errore += "Documento Attestato " + string( kst_docprod_esporta.kst_tab_docprod[k_item].doc_num) + " NON Esportato, codice Cliente non Trovato (id doc=" + string(kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod) +")! ~n~r"
					end if
				else	
					try
						kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_docprod.id_cliente
			
//--- legge il path e Nome file
						kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente = kst_tab_docprod.id_cliente
						kst_uf_docpath = get_path(kst_docprod_esporta.kst_tab_docprod[k_item])
						if len(trim(kst_uf_docpath.k_path_interno)) > 0 then 
							k_nome_file = get_nomefile(kst_docprod_esporta.kst_tab_docprod[k_item])
							kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_interno + k_nome_file
						end if
						kst_docprod_esporta_pdf.duplica[k_riga_pdf] = false
						kst_docprod_esporta_pdf.flg_img_bn[k_riga_pdf] = false
				
//--- campi da mettere in un file formato testo da passare alla Procedura di Gestione Documentale
						if kuf1_certif.get_id_meca(kst_tab_certif) > 0 then
							kst_tab_meca.id = kst_tab_certif.id_meca
							kuf1_armo.get_num_int(kst_tab_meca)
							if kst_tab_meca.num_int > 0 then
							else
								kst_tab_meca.num_int = 0
								kst_tab_meca.data_int = date(0)
							end if
						else
							kst_tab_certif.id_meca = 0
							kst_tab_meca.num_int = 0
							kst_tab_meca.data_int = date(0)
						end if
						k_item_txt++
						kst_txt_docprod[k_item_txt].id_doc = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
						kst_txt_docprod[k_item_txt].doc_nome = mid(trim(k_nome_file),2)
						kst_txt_docprod[k_item_txt].doc_tipo = "ATT"
						kst_txt_docprod[k_item_txt].doc_num = kst_docprod_esporta.kst_tab_docprod[k_item].doc_num
						kst_txt_docprod[k_item_txt].doc_data = kst_docprod_esporta.kst_tab_docprod[k_item].doc_data
						kst_txt_docprod[k_item_txt].doc_esporta_prefpath =  kst_uf_docpath.k_path_interno
						kst_txt_docprod[k_item_txt].id_cliente = kst_docprod_esporta.kst_tab_docprod[k_item].id_cliente
						kst_txt_docprod[k_item_txt].num_int = kst_tab_meca.num_int
						kst_txt_docprod[k_item_txt].data_int = kst_tab_meca.data_int
						kst_txt_docprod[k_item_txt].id_meca = 0
						kst_txt_docprod[k_item_txt].caricato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_ts
						kst_txt_docprod[k_item_txt].caricato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].caricato_utente
						kst_txt_docprod[k_item_txt].esportato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_ts
						kst_txt_docprod[k_item_txt].esportato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].esportato_utente
						kst_txt_docprod[k_item_txt].rigenerato_ts = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_ts
						kst_txt_docprod[k_item_txt].rigenerato_utente = kst_docprod_esporta.kst_tab_docprod[k_item].rigenerato_utente
					
//--- se e' previsto il documento Uso ESTERNO  fa la duplica quindi carica altra ricorrenza in array			
						if len(trim(kst_uf_docpath.k_path_esterno)) > 0 then
			
							kst_uf_docpath.k_path_esterno += k_nome_file
					
//--- get se devo esportare il documento, dato presente nel Cliente
							kst_tab_clienti_mkt.id_cliente = kst_tab_docprod.id_cliente
							kuf1_clienti.get_doc_esporta(kst_tab_clienti_mkt)
							if kst_tab_clienti_mkt.doc_esporta	= kuf1_clienti.kki_doc_esporta_si then
							
								k_riga_pdf ++
								kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
								
								kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_docprod.id_cliente
								kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_esterno  // stavolta fa il doc ESTERNO
								
								kst_docprod_esporta_pdf.flg_img_bn[k_riga_pdf] = true
								
								kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true
								
							end if

						end if
				
//--- se e' previsto il documento Uso DOCUMENTALE aggiunge altra ricorrenza in array			
						if len(trim(kst_uf_docpath.k_path_documentale )) > 0 then
			
							kst_uf_docpath.k_path_documentale += k_nome_file
							
							k_riga_pdf ++
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf] =  kst_docprod_esporta.kst_tab_docprod[k_item]
							
							kst_docprod_esporta_pdf.kst_tab_docprod[k_riga_pdf].id_cliente = kst_tab_docprod.id_cliente
							kst_docprod_esporta_pdf.path[k_riga_pdf] = kst_uf_docpath.k_path_documentale  // stavolta fa il doc x DOCUMENTALE
							
							kst_docprod_esporta_pdf.flg_img_bn[k_riga_pdf] = false
							
							kst_docprod_esporta_pdf.duplica[k_riga_pdf] = true
							
						end if
					
					catch (uo_exception kuo1_exception)
						kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no   // da NON elaborare
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo1_exception.get_errtext() + "~n~r"
						end if
					end try
				
				end if
			end if
			
		end if
		
	end for	
	
	
//--- 	
	if k_riga_pdf > 0 then
		
//--- lancia esportazione PDF
		k_righe_esportate = kuf1_certif.stampa_digitale_esporta(kst_docprod_esporta_pdf )

//--- Devo Aggiornare?		
		if k_righe_esportate > 0 then
			if kst_docprod_esporta.k_aggiorna_docprod then
			
				for k_item = 1 to k_item_array
			
					try
						if kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod > 0 and  kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod <> k_id_docprod_precedente then
							k_id_docprod_precedente = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod  // evita di riaggiornare lo stesso documento
							
							//--- se tutto OK marca il doc come esportato altrimenti lo toglie da quelli da esportare
							if kst_docprod_esporta.kst_tab_docprod[k_item].doc_esporta = ki_doc_esporta_no then
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "S"
								set_esportato_no(kst_docprod_esporta.kst_tab_docprod[k_item]) 
							else
								kst_docprod_esporta.kst_tab_docprod[k_item].st_tab_g_0.esegui_commit = "N"
								if set_esportato(kst_docprod_esporta.kst_tab_docprod[k_item]) then 
								
														
								end if
								kst_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[k_item].id_doc
								kst_tab_certif.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item].id_docprod
								kst_tab_certif.st_tab_g_0.esegui_commit = "S"
								kuf1_certif.set_id_docprod( kst_tab_certif )
							
								k_doc_esportati++
							end if
						end if
						
					catch (uo_exception kuo2_exception)
						k_nr_errori ++
						if k_nr_errori > 15 then
							if k_nr_errori = 15 then
								k_errore += "...troppi errori da visualizzare...."
							end if
						else
							k_errore += kuo2_exception.get_errtext() + "~n~r"
						end if
						
					end try
					
				end for	
				
//--- Faccio la COMMIT					
				if k_righe_esportate > 0 then
					kGuf_data_base.db_commit_1( )
				end if
			
//--- se tutto OK e devo AGGIORNARE allora scrivo file txt con i documenti generati in PDF
				u_esporta_txt_datidoc(kst_txt_docprod[])
			end if
		end if
	
	end if
	
	k_return = k_doc_esportati
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	destroy kuf1_certif
	destroy kuf1_clienti
	
//--- se si erano verificati errori ma elab proseguita....
	if k_errore > " " then
		if k_doc_esportati > 0 then
			k_errore += "~n~rSono stati comunque esportati " + string(k_doc_esportati) + " documenti in modo corretto."
		end if
		kst_esito.esito = kkg_esito.ko 
		kst_esito.sqlerrtext = k_errore
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

end try
	

return k_return

end function

public function st_uf_docpath get_path (st_tab_docprod ast_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Torna il PATH di un documento a cui bisogna aggiungere il nome
//--- 
//--- Inp: st_tab_docprod. id_docprod / doc_data / id_cliente / id_docpath (se id a zero lo piglio da tab. docprod)
//--- Out: 
//--- 
//--- Ritorna kst_uf_docpath.k_path_interno / k_path_esterno / k_path_x_documentale
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
st_uf_docpath kst_uf_docpath
string k_path="", k_path_interno="", k_path_esterno="", k_esito="", k_path_x_documentale
int k_rc=0
st_tab_docpath kst_tab_docpath
st_tab_doctipo kst_tab_doctipo
//st_tab_docpathtipo kst_tab_docpathtipo
st_tab_clienti_mkt kst_tab_clienti_mkt
st_esito kst_esito
//kuf_docpathtipo kuf1_docpathtipo 
kuf_doctipo kuf1_doctipo 
kuf_docpath kuf1_docpath
kuf_clienti kuf1_clienti 
//kuf_base kuf1_base
//kuf_utility kuf1_utility


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
   
	if ast_tab_docprod.id_cliente > 0 and ast_tab_docprod.doc_data > date(0)  then
      
		try
		
			kuf1_docpath = create kuf_docpath
//			kuf1_docpathtipo = create kuf_docpathtipo	  
			kuf1_doctipo = create kuf_doctipo	  
			kuf1_clienti = create kuf_clienti 
//			kuf1_base = create kuf_base 
//			kuf1_utility = create kuf_utility


//--- se id_docpath non passato allora reperisco con il tipo l'unico id_docpath nella tabella docpathtipo se c'e'....
			if ast_tab_docprod.id_docpath > 0 then
			else
				
//--- get del id_doctipo		
//				kst_tab_doctipo.tipo = k_tipo
//				kst_tab_doctipo.id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
			
//--- get del id_docpath
				get_id_docpath(ast_tab_docprod)
				
				
			end if

//--- get del path in docpath
			kst_tab_docpath.id_docpath = ast_tab_docprod.id_docpath
			kst_tab_docpath.path = kuf1_docpath.get_path(kst_tab_docpath)
			kst_tab_docpath.path_x_documentale = kuf1_docpath.get_path_x_documentale(kst_tab_docpath)
				
			if len(trim(kst_tab_docpath.path)) > 0 then
					
//--- get del path personale del Cliente valido solo per esportazione ESTERNA
				kst_tab_clienti_mkt.id_cliente = ast_tab_docprod.id_cliente
				kuf1_clienti.get_doc_esporta_prefpath(kst_tab_clienti_mkt)
				if len(trim(kst_tab_clienti_mkt.doc_esporta_prefpath)) > 0 then
				else	
					kst_tab_clienti_mkt.doc_esporta_prefpath = trim(string(ast_tab_docprod.id_cliente)) 
				end if
				ast_tab_docprod.doc_esporta_prefpath =  trim(string(ast_tab_docprod.id_cliente))  // parth valido sempre x l'importazione INTERNA
					
//--- Path x uso interno sempre presente 
				k_path_interno = kguo_path.get_doc_root_interno( )
						
//--- valuto se PATH anche x documento Uso Esterno
				if kuf1_docpath.if_uso_esterno(kst_tab_docpath) then 
					k_path_esterno = kguo_path.get_doc_root_esterno( )
				end if
						
//--- valuto se PATH anche x documento Uso Documentale
				k_path_x_documentale = k_path 
					
//--- formatta il PATH INTERNO completo					
				k_path_interno +=  KKG.PATH_SEP + ast_tab_docprod.doc_esporta_prefpath + KKG.PATH_SEP  + trim(kst_tab_docpath.path) &
													+ KKG.PATH_SEP  + string(year(ast_tab_docprod.doc_data)) 
				if not kguo_path.u_drectory_create(k_path_interno ) then // Crea eventuale percorso COMPLETO!!!
					kst_esito.esito = kkg_esito.no_esecuzione  
					kst_esito.SQLErrText = "Problemi durante verifica path 'Uso Interno' per l'esportazione Documenti: " + k_path_interno
				end if
					
//--- formatta il PATH ESTERNO completo					
				if len(trim(k_path_esterno)) > 0 then
					k_path_esterno +=  KKG.PATH_SEP + kst_tab_clienti_mkt.doc_esporta_prefpath + KKG.PATH_SEP  + trim(kst_tab_docpath.path) &
														+ KKG.PATH_SEP  + string(year(ast_tab_docprod.doc_data)) 
					if not kguo_path.u_drectory_create(k_path_esterno ) then // Crea eventuale percorso COMPLETO!!!
						kst_esito.esito = kkg_esito.no_esecuzione  
						kst_esito.SQLErrText = "Problemi durante verifica path 'Uso Esterno' per l'esportazione Documenti: " + k_path_esterno
					end if
				end if

//--- formatta il PATH DOCUMENTALE completo					
				k_path_x_documentale +=  KKG.PATH_SEP + kst_tab_docpath.path_x_documentale  
				if not kguo_path.u_drectory_create(k_path_x_documentale ) then // Crea eventuale percorso COMPLETO!!!
					kst_esito.esito = kkg_esito.no_esecuzione  
					kst_esito.SQLErrText = "Problemi durante verifica path Uso Documentale per l'esportazione Documenti: " + k_path_x_documentale
				end if

				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
					
				kst_uf_docpath.k_path_interno = k_path_interno
				kst_uf_docpath.k_path_esterno = k_path_esterno
				kst_uf_docpath.k_path_documentale = k_path_x_documentale
					
			end if
		
		catch (uo_exception kuo_exception)
	      throw kuo_exception
         
		finally
			if isvalid(kuf1_docpath) then destroy kuf1_docpath
//			if isvalid(kuf1_docpathtipo) then destroy kuf1_docpathtipo	  
			if isvalid(kuf1_doctipo) then destroy kuf1_doctipo	  
			if isvalid(kuf1_clienti) then destroy kuf1_clienti 
//			if isvalid(kuf1_base) then destroy kuf1_base
//			if isvalid(kuf1_utility ) then destroy kuf1_utility
			
   		end try
	
	else
		if isnull(ast_tab_docprod) then
			ast_tab_docprod.id_docprod = 0
		end if
	
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Cartella documento irreperibile, mancano codice Cliente o data Documento (id Documento="+string(ast_tab_docprod.id_docprod)+")! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if


return kst_uf_docpath

end function

private function boolean set_esportato_no (readonly st_tab_docprod kst_tab_docprod) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggorna a NON Esportare il rek in tabella docprod 
//--- 
//--- Inp: st_tab_docprod  id_docprod
//--- Out: 
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
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
//   kuf1_sicurezza = create kuf_sicurezza
//   k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//   destroy kuf1_sicurezza
//
//   if not k_autorizza then
//   
//      kst_esito.sqlcode = sqlca.sqlcode
//      kst_esito.SQLErrText = "Cancellazione 'Esportazione Documento' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//      kst_esito.esito = kkg_esito.no_aut
//      kguo_exception.inizializza( )
//      kguo_exception.set_esito(kst_esito)
//      throw kguo_exception
//   
//   end if
	
   if kst_tab_docprod.id_docprod > 0 then
      
      try
		     

		kst_tab_docprod.doc_esporta = ki_doc_esporta_no
		
		kst_tab_docprod.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_docprod.x_utente = kGuf_data_base.prendi_x_utente()
		
		update docprod
							  set doc_esporta = :kst_tab_docprod.doc_esporta
								  ,x_datins = :kst_tab_docprod.x_datins
								  ,x_utente = :kst_tab_docprod.x_utente
					where id_docprod = :kst_tab_docprod.id_docprod
						using sqlca;


		if sqlca.sqlcode >= 0 then
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiorna rif. a 'Non Esportare' (docprod id_docprod= " + string(kst_tab_docprod.id_docprod) +"):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
			
			
      //---- COMMIT.... 
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if kst_tab_docprod.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_docprod.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
			k_return = true  // OK
			
		end if
		
         
      catch (uo_exception kuo_exception)
         throw kuo_exception
         
      end try
		
   end if


return k_return

end function

public function boolean tb_add_certif (ref st_tab_docprod ast_tab_docprod, boolean a_esporta) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge rek di tipo ATTESTATO alla tabella docprod 
//--- 
//--- Inp: st_tab_docprod doc_num / doc_data / doc_id / id_cliente, a_esporta TRUE = esporta subito
//--- Out: st_tab_docprod.*
//--- 
//--- Ritorna TRUE = OK
//---             
//--- Lancia EXCEPTION x errore            
//---             
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
kuf_doctipo kuf1_doctipo
st_docprod_esporta kst_docprod_esporta

//--- Nome del Documento e dscrizione: sono personalizzati x tipo documento
//	ast_tab_docprod.doc_nome = "C" + string(ast_tab_docprod.id_cliente, "00000") + "ATT" + string(ast_tab_docprod.id_doc) + "N" + string(ast_tab_docprod.doc_num) + "_" + string(year(ast_tab_docprod.doc_data)) + ".pdf" 
	ast_tab_docprod.doc_nome = "C" + string(ast_tab_docprod.id_cliente, "00000") + "_ATT_" + string(ast_tab_docprod.doc_data, "yyyy_mm_dd") + "_" + string(ast_tab_docprod.doc_num) + ".pdf" 
	ast_tab_docprod.descr = "ATTESTATO nr. " + string(ast_tab_docprod.doc_num) + " del " + string(ast_tab_docprod.doc_data) + "  -  id: " + string(ast_tab_docprod.id_doc)  
	ast_tab_docprod.doc_tabella = ki_doc_tabella_attestati
	
	k_return = tb_add(ast_tab_docprod, kuf1_doctipo.kki_tipo_attestati )
	
	if k_return and a_esporta then
		kst_docprod_esporta.kst_tab_docprod[1] = ast_tab_docprod
		u_esporta_attestati(kst_docprod_esporta)
	end if
	
return k_return

end function

public function long get_id_docprod_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID inserito 
//--- 
//---  input: 
//---  ret: max id_docprod
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_docprod)
		 INTO 
				:k_return
		 FROM docprod  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Documenti in tabella (DOCPROD)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

on kuf_docprod.create
call super::create
end on

on kuf_docprod.destroy
call super::destroy
end on

