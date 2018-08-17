$PBExportHeader$kuf_listino_prezzi.sru
forward
global type kuf_listino_prezzi from kuf_parent
end type
end forward

global type kuf_listino_prezzi from kuf_parent
end type
global kuf_listino_prezzi kuf_listino_prezzi

type variables
public constant string kki_attivo_si="S"
public constant string kki_attivo_no="N"


end variables

forward prototypes
public function boolean tb_delete_x_id_voce (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public function boolean tb_delete (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public function st_esito get_id_listino_voce (ref st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public function st_esito get_id_listino_prezzo (ref st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public subroutine get_all_id_listino_voce (ref st_tab_listino_prezzi ast_tab_listino_prezzi[]) throws uo_exception
public function st_esito u_check_dati_1 (ref datastore ads_inp) throws uo_exception
public function boolean tb_duplica (st_tab_listino_prezzi ast_tab_listino_prezzi_orig, st_tab_listino_prezzi ast_tab_listino_prezzi_new)
public function long tb_add (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public subroutine get_all_id_listino_link_pregruppo (ref st_tab_listino_prezzi ast_tab_listino_prezzi[]) throws uo_exception
public function boolean tb_delete_x_id_link_pregruppo (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception
public subroutine if_isnull (ref st_tab_listino_prezzi ast_tab_listino_prezzi)
public function long get_ultimo_id () throws uo_exception
end prototypes

public function boolean tb_delete_x_id_voce (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella LISTINO_PREZZI x id_listino_voce
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_voce e id_listino_link_pregruppo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
boolean k_autorizza
kuf_listino_fvarie kuf1_listino_fvarie


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

//--- controlla se utente autorizzato alla funzione in atto
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' non Autorizzata (id=" + string(ast_tab_listino_prezzi.id_listino_voce) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_prezzi.id_listino_voce > 0  and ast_tab_listino_prezzi.id_listino_link_pregruppo >0 then
      
		kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
		if kuf1_listino_fvarie.if_voce_a_listino(ast_tab_listino_prezzi.id_listino_voce) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Voce già presente a Listino (tb_delete_x_id_voce). - Rimozione non consentita "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		      
		delete from listino_prezzi
			where id_listino_voce = :ast_tab_listino_prezzi.id_listino_voce  and id_listino_link_pregruppo = :ast_tab_listino_prezzi.id_listino_link_pregruppo
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' (listino_prezzi)  id=" + string(ast_tab_listino_prezzi.id_listino_voce) + "/" +  string(ast_tab_listino_prezzi.id_listino_link_pregruppo) + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
			k_return = true  // OK CANCELLATO
			
		end if
		
         
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return k_return

end function

public function boolean tb_delete (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella LISTINO_PREZZI x lo specifico ID PREZZO
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_prezzo 
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
boolean k_autorizza
//kuf_listino_fvarie kuf1_listino_fvarie


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

//--- controlla se utente autorizzato alla funzione in atto
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' non Autorizzata (id prezzo=" + string(ast_tab_listino_prezzi.id_listino_prezzo) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_prezzi.id_listino_prezzo > 0 then
		
////--- leggo la voce di questo record      
//		this.get_id_listino_voce(ast_tab_listino_prezzi)
//		
//		if ast_tab_listino_prezzi.id_listino_voce > 0 then
//			kuf1_listino_fvarie = create kuf_listino_fvarie
////--- Se esiste anche un solo collegamento allora NON posso cancellare
//			if kuf1_listino_fvarie.if_voce_a_listino(ast_tab_listino_prezzi.id_listino_voce) then
//				kst_esito.esito = kkg_esito.no_esecuzione
//				kst_esito.sqlerrtext = "Voce già presente a Listino (tb_delete_x_id_voce). - Rimozione non consentita "
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito(kst_esito)
//				throw kguo_exception
//			end if
//		end if
//		
		      
		delete from listino_prezzi
			where id_listino_prezzo = :ast_tab_listino_prezzi.id_listino_prezzo
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino'  (listino_prezzi)  id=" + string(ast_tab_listino_prezzi.id_listino_prezzo)  + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
			k_return = true  // OK CANCELLATO
			
		end if
		
         
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return k_return

end function

public function st_esito get_id_listino_voce (ref st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------
//--- Get campo 
//--- 
//--- Inp: st_tab_listino_prezzi.id_listino_prezzo
//--- Out: st_tab_listino_prezzi.id_listino_voce
//---             
//-----------------------------------------------------------------------------------------------------------------
//
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
//boolean k_autorizza
//kuf_listino_fvarie kuf1_listino_fvarie


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	if ast_tab_listino_prezzi.id_listino_prezzo > 0 then
      
		      st_tab_listino_prezzi kst_tab_listino_prezzi
		select id_listino_voce 
			into :ast_tab_listino_prezzi.id_listino_voce
		     from listino_prezzi
			where id_listino_prezzo = :kst_tab_listino_prezzi.id_listino_prezzo
			using kguo_sqlca_db_magazzino ;
		
		if sqlca.sqlcode <> 0 then
			ast_tab_listino_prezzi.id_listino_voce = 0
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura da 'Prezzo Voce Listino' del id_listino_voce (listino_prezzi) non riuscito, id=" + string(ast_tab_listino_prezzi.id_listino_prezzo) + ": " + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = KKG_ESITO.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = KKG_ESITO.db_wrn
				else
					kst_esito.esito = KKG_ESITO.db_ko
//--- lancio EXCEPTION			
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
		else
			if isnull(ast_tab_listino_prezzi.id_listino_voce) then ast_tab_listino_prezzi.id_listino_voce = 0
		end if
			
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return kst_esito

end function

public function st_esito get_id_listino_prezzo (ref st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------
//--- Get del id prezzo da  Voce e link-Pregruppo (coppia listino-gruppo) 
//--- 
//--- Inp: st_tab_listino_prezzi.id_listino_link_pregruppo+id_listino_voce
//--- Out: st_tab_listino_prezzi.id_listino_prezzo
//---             
//-----------------------------------------------------------------------------------------------------------------
//
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
//boolean k_autorizza
//kuf_listino_fvarie kuf1_listino_fvarie


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	if ast_tab_listino_prezzi.id_listino_link_pregruppo > 0 and  ast_tab_listino_prezzi.id_listino_voce > 0 then
      
		      
		select id_listino_prezzo 
			into :ast_tab_listino_prezzi.id_listino_prezzo
		     from listino_prezzi
			where id_listino_voce = :ast_tab_listino_prezzi.id_listino_voce
			      and id_listino_link_pregruppo = :ast_tab_listino_prezzi.id_listino_link_pregruppo
			using kguo_sqlca_db_magazzino ;

//			      and id_listino_pregruppo = :ast_tab_listino_prezzi.id_listino_pregruppo
		
		if sqlca.sqlcode <> 0 then
			ast_tab_listino_prezzi.id_listino_prezzo = 0
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura da 'Prezzo Voce Listino' (listino_prezzi) non riuscito, id voce=" + string(ast_tab_listino_prezzi.id_listino_voce) + ", id link-pregruppo=" + string(ast_tab_listino_prezzi.id_listino_link_pregruppo) + ": " + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = KKG_ESITO.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = KKG_ESITO.db_wrn
				else
					kst_esito.esito = KKG_ESITO.db_ko
//--- lancio EXCEPTION			
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
		else
			if isnull(ast_tab_listino_prezzi.id_listino_prezzo) then ast_tab_listino_prezzi.id_listino_prezzo = 0
		end if
			
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return kst_esito


end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con     ads_inp.object.<nome campo>.tag che può valere:
//                                  0=tutto OK (kkg_esito.ok); 
//                                  1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//                                  2=errore forma  (bloccante) (kkg_esito.err_formale);
//                                  3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//                                  4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---                                     5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito



try
   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()
   
   
   k_nr_righe =ads_inp.rowcount()
   k_errori = 0
// k_riga =ads_inp.getnextmodified(0, primary!)
   k_riga = 1
   
   do while k_riga <= k_nr_righe and k_errori < 10

      if ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo") > 0 then 
      else
         k_errori ++
         k_tipo_errore="3"      // errore in questo campo: dati insuff.
         ads_inp.modify("id_listino_pregruppo.tag = '" + k_tipo_errore + "' ")
         kst_esito.esito = kkg_esito.DATI_INSUFF
         kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.describe("id_listino_pregruppo_t.text")) +  "~n~r"  
      end if

      if  k_riga < k_nr_righe then
         if ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo") > 0 then 
            if ads_inp.find ("id_listino_pregruppo = " + string(ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo")), k_riga + 1, ads_inp.rowcount() ) > 0 then
   //                +" and id_listino_prezzo <> " + string(ads_inp.getitemnumber ( k_riga, "id_listino_prezzo")), k_riga + 1, ads_inp.rowcount() ) > 0 then
               k_tipo_errore="1"      
               ads_inp.modify("id_listino_pregruppo.tag = '" + k_tipo_errore + "' ")
               kst_esito.esito = kkg_esito.err_logico
               kst_esito.sqlerrtext = "Gruppo " + string(ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo")) +" presente più di una volta " +  "~n~r"  
            end if
         end if
      end if
         
      k_riga++

//    k_riga = ads_inp.getnextmodified(k_riga, primary!)

   loop

   if k_tipo_errore <> "0" and k_tipo_errore <> "4" and k_tipo_errore <> "5" then
      kguo_exception.inizializza( )
      kguo_exception.set_esito(kst_esito)
      throw kguo_exception
   end if
   
catch (uo_exception kuo_exception)
   throw kuo_exception

finally
   if k_errori > 0 then
      
   end if
   
end try

return kst_esito

end function

public subroutine get_all_id_listino_voce (ref st_tab_listino_prezzi ast_tab_listino_prezzi[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab LISTINO_PREZZI  per trovare tutti i id_listino_voce attivi con una determinato id_listino_link_pregruppo 
//--- 
//--- Inp:  st_tab_listino_prezzi[1].id_listino_link_pregruppo
//--- out: array st_tab_listino_prezzi[] con tutti i id_listino_link_pregruppo 
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito
//datastore kds_1


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

declare c_get_all_id_listino_link_pregruppo cursor for
	select  a.id_listino_voce
			from listino_prezzi a
			where id_listino_link_pregruppo = :ast_tab_listino_prezzi[1].id_listino_link_pregruppo
				and attivo = "S"
	using kguo_sqlca_db_magazzino;

//				and id_listino_pregruppo = :ast_tab_listino_prezzi[1].id_listino_pregruppo

try
	
//	if ast_tab_listino_prezzi[1].id_listino_link_pregruppo > 0 and ast_tab_listino_prezzi[1].id_listino_pregruppo > 0 then
	if ast_tab_listino_prezzi[1].id_listino_link_pregruppo > 0 then
		
		open c_get_all_id_listino_link_pregruppo;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_link_pregruppo  into :ast_tab_listino_prezzi[k_ind].id_listino_voce;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante la lettura Prezzi Voci di Listino (listino_prezzi). ID=" + string(ast_tab_listino_prezzi[1].id_listino_link_pregruppo)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)				
					throw kguo_exception
				end if
	
			loop
			close c_get_all_id_listino_link_pregruppo;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione la lettura Prezzi Voci di Listino (listino_prezzi). ID=" + string(ast_tab_listino_prezzi[1].id_listino_link_pregruppo)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
//		kst_esito.esito = kkg_esito.no_esecuzione
//		kst_esito.sqlerrtext = "Voce Listino non eliminata. Manca ID"
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	




end subroutine

public function st_esito u_check_dati_1 (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con     ads_inp.object.<nome campo>.tag che può valere:
//                                  0=tutto OK (kkg_esito.ok); 
//                                  1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//                                  2=errore forma  (bloccante) (kkg_esito.err_formale);
//                                  3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//                                  4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---                                     5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito



try
   kst_esito.esito = kkg_esito.ok
   kst_esito.sqlcode = 0
   kst_esito.SQLErrText = ""
   kst_esito.nome_oggetto = this.classname()
   
   
   k_nr_righe =ads_inp.rowcount()
   k_errori = 0
// k_riga =ads_inp.getnextmodified(0, primary!)
   k_riga = 1
   
   do while k_riga <= k_nr_righe and k_errori < 10

      if ads_inp.getitemnumber ( k_riga, "id_listino_voce") > 0 then 
      else
         k_errori ++
         k_tipo_errore="3"      // errore in questo campo: dati insuff.
         ads_inp.modify("id_listino_voce.tag = '" + k_tipo_errore + "' ")
         kst_esito.esito = kkg_esito.DATI_INSUFF
         kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.describe("id_listino_voce_t.text")) +  "~n~r"  
      end if

      if  k_riga < k_nr_righe then
         if ads_inp.getitemnumber ( k_riga, "id_listino_voce") > 0 then 
            if ads_inp.find ("id_listino_voce = " + string(ads_inp.getitemnumber ( k_riga, "id_listino_voce")), k_riga + 1, ads_inp.rowcount() ) > 0 then
   //                +" and id_listino_prezzo <> " + string(ads_inp.getitemnumber ( k_riga, "id_listino_prezzo")), k_riga + 1, ads_inp.rowcount() ) > 0 then
               k_tipo_errore="1"      
               ads_inp.modify("id_listino_voce.tag = '" + k_tipo_errore + "' ")
               kst_esito.esito = kkg_esito.err_logico
               kst_esito.sqlerrtext = "Voce " + string(ads_inp.getitemnumber ( k_riga, "id_listino_voce")) +" presente più di una volta " +  "~n~r"  
            end if
         end if
      end if
         
      k_riga++

//    k_riga = ads_inp.getnextmodified(k_riga, primary!)

   loop

   if k_tipo_errore <> "0" and k_tipo_errore <> "4" and k_tipo_errore <> "5" then
      kguo_exception.inizializza( )
      kguo_exception.set_esito(kst_esito)
      throw kguo_exception
   end if
   
catch (uo_exception kuo_exception)
   throw kuo_exception

finally
   if k_errori > 0 then
      
   end if
   
end try

return kst_esito

end function

public function boolean tb_duplica (st_tab_listino_prezzi ast_tab_listino_prezzi_orig, st_tab_listino_prezzi ast_tab_listino_prezzi_new);//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Duplica il rek dalla tabella listino_prezzi
//--- 
//--- Inp:  st_tab_listino_prezzi.id_listino_link_pregruppo da cui duplicare
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
int k_err = 0
long k_riga, k_righe
st_esito kst_esito
datastore kds_origine, kds_duplicato

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	
	if  ast_tab_listino_prezzi_orig.id_listino_link_pregruppo = 0 or isnull (ast_tab_listino_prezzi_orig.id_listino_link_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Prezzo-Voci non Duplicato. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.inserimento) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Duplica 'Prezzo Voce Listino' non Autorizzata (da ID gruppo=" + string(ast_tab_listino_prezzi_orig.id_listino_link_pregruppo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- DUPLICA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- crea Gruppo		
	kds_origine = create datastore
	kds_origine.dataobject = "d_listino_prezzi_l"
	kds_origine.settransobject(kguo_sqlca_db_magazzino)
	k_righe = kds_origine.retrieve(ast_tab_listino_prezzi_orig.id_listino_link_pregruppo, 0)
	for k_riga = 1 to k_righe
		kds_origine.object.id_listino_link_pregruppo[k_riga] = ast_tab_listino_prezzi_NEW.id_listino_link_pregruppo
		kds_origine.object.id_listino_prezzo[k_riga] = 0
		kds_origine.object.x_datins[k_riga] = kGuf_data_base.prendi_x_datins( )
		kds_origine.object.x_utente[k_riga] = kGuf_data_base.prendi_x_utente( )
		kds_origine.setitemstatus( k_riga, 0, primary!, New!)
	end for
	
//	kds_duplicato = create datasore
//	kds_duplicato.dataobject = "d_listino_prezzi_l"
//	kds_duplicato.settransobject(kguo_sqlca_db_magazzino)
//	kds_origine.rowscopy(1, kds_origine.rowcount(), primary!, kds_duplicato, 1, primary!)
			
	k_err =  kds_origine.update() 
	if k_err < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita duplica 'Prezzo Voce Listino' (listino_prezzi) da id=" + string(ast_tab_listino_prezzi_orig.id_listino_link_pregruppo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_listino_prezzi_orig.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi_orig.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		
		if k_err > 0 then  //OK!!!
		
			k_return = true
			
			if ast_tab_listino_prezzi_orig.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi_orig.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		end if
		
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function long tb_add (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella PREZZI VOCI LISTINO 
//=== 
//=== Inp: st_tab_listino_prezzi - valorizzata
//=== Ritorna: id aggiunto
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return = 0, k_rc
st_esito kst_esito
datastore kds_listino_prezzi
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
boolean k_autorizza




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_autorizza = if_sicurezza(kkg_flag_modalita.inserimento)

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Inserimento 'Voci Prezzi Listino' non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
else

	
	if ast_tab_listino_prezzi.id_listino_voce > 0 then
	
//--- imposto dati utente e data aggiornamento
		ast_tab_listino_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_listino_prezzi.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
		if_isnull(ast_tab_listino_prezzi)
	
		kds_listino_prezzi = create datastore
		kds_listino_prezzi.dataobject = "ds_listino_prezzi"
		kds_listino_prezzi.settransobject( kguo_sqlca_db_magazzino )
		kds_listino_prezzi.insertrow(0)

		kds_listino_prezzi.setitem(1, "id_listino_prezzo", 0 )
		kds_listino_prezzi.setitem(1, "id_listino_link_pregruppo", ast_tab_listino_prezzi.id_listino_link_pregruppo )
//		kds_listino_prezzi.setitem(1, "id_listino_pregruppo", ast_tab_listino_prezzi.id_listino_pregruppo )
		kds_listino_prezzi.setitem(1, "id_listino_voce", ast_tab_listino_prezzi.id_listino_voce )
		kds_listino_prezzi.setitem(1, "prezzo", ast_tab_listino_prezzi.prezzo )
		kds_listino_prezzi.setitem(1, "attivo", ast_tab_listino_prezzi.attivo )
		kds_listino_prezzi.setitem(1, "x_datins", ast_tab_listino_prezzi.x_datins )
		kds_listino_prezzi.setitem(1, "x_utente", ast_tab_listino_prezzi.x_utente )
	
		k_rc = kds_listino_prezzi.update()
		if k_rc = 1 then
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
	
//--- piglia il numero di aggiornameno
			k_return = get_ultimo_id( )
			kds_listino_prezzi.setitem(1, "id_listino_prezzo", k_return )

		else
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqldbcode
			kst_esito.SQLErrText = "Inserimento 'Voci Listino Prezzi' in errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext )
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if

	
end if


return k_return

end function

public subroutine get_all_id_listino_link_pregruppo (ref st_tab_listino_prezzi ast_tab_listino_prezzi[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab LISTINO_PREZZI  per trovare tutti i id_listino_link_pregruppo con una determinato id_listino_voce 
//--- 
//--- Inp:  st_tab_listino_prezzi[1].id_listino_voce
//--- out: array st_tab_listino_prezzi[] con tutti i id_listino_link_pregruppo 
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito
//datastore kds_1
 

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

declare c_get_all_id_listino_link_pregruppo cursor for
	select  a.id_listino_link_pregruppo
			from listino_prezzi a
			where id_listino_voce = :ast_tab_listino_prezzi[1].id_listino_voce
				and attivo = "S"
	using kguo_sqlca_db_magazzino;

//				and id_listino_pregruppo = :ast_tab_listino_prezzi[1].id_listino_pregruppo

try
	
//	if  ast_tab_listino_prezzi[1].id_listino_voce > 0 and ast_tab_listino_prezzi[1].id_listino_pregruppo > 0 then
	if  ast_tab_listino_prezzi[1].id_listino_voce > 0 then
		open c_get_all_id_listino_link_pregruppo;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_link_pregruppo  into :ast_tab_listino_prezzi[k_ind].id_listino_link_pregruppo;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura Prezzi Voci di Listino (listino_prezzi). ID=" + string(ast_tab_listino_prezzi[1].id_listino_voce)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)				
					throw kguo_exception
				end if
	
			loop
			close c_get_all_id_listino_link_pregruppo;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura Prezzi Voci di Listino (listino_prezzi). ID=" + string(ast_tab_listino_prezzi[1].id_listino_voce)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
//		kst_esito.esito = kkg_esito.no_esecuzione
//		kst_esito.sqlerrtext = "Voce Listino non eliminata. Manca ID"
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	




end subroutine

public function boolean tb_delete_x_id_link_pregruppo (st_tab_listino_prezzi ast_tab_listino_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella LISTINO_PREZZI x id_listino_link_pregruppo
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_link_pregruppo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito
boolean k_autorizza
kuf_listino_fvarie kuf1_listino_fvarie


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

//--- controlla se utente autorizzato alla funzione in atto
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)

	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Prezzi Voce Listino' non Autorizzata (id=" + string(ast_tab_listino_prezzi.id_listino_link_pregruppo) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_prezzi.id_listino_link_pregruppo > 0 then
      
		kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
		if kuf1_listino_fvarie.if_pregruppo_a_listino(ast_tab_listino_prezzi.id_listino_link_pregruppo) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Gruppo-Voci già presente a Listino (tb_delete_x_id_pregrupppo). - Rimozione non consentita "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		      
		delete from listino_prezzi
			where id_listino_link_pregruppo = :ast_tab_listino_prezzi.id_listino_link_pregruppo
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzi Voce Listino' (listino_prezzi)  id=" + string(ast_tab_listino_prezzi.id_listino_link_pregruppo) + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
			k_return = true  // OK CANCELLATO
			
		end if
		
         
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return k_return

end function

public subroutine if_isnull (ref st_tab_listino_prezzi ast_tab_listino_prezzi);//

if isnull(ast_tab_listino_prezzi.attivo) then ast_tab_listino_prezzi.attivo = kki_attivo_si
if isnull(ast_tab_listino_prezzi.id_listino_prezzo ) then ast_tab_listino_prezzi.id_listino_prezzo = 0
if isnull(ast_tab_listino_prezzi.id_listino_link_pregruppo ) then ast_tab_listino_prezzi.id_listino_link_pregruppo = 0
//if isnull(ast_tab_listino_prezzi.id_listino_pregruppo ) then ast_tab_listino_prezzi.id_listino_pregruppo = 0
if isnull(ast_tab_listino_prezzi.id_listino_voce ) then ast_tab_listino_prezzi.id_listino_voce = 0
if isnull(ast_tab_listino_prezzi.prezzo ) then ast_tab_listino_prezzi.prezzo = 0
if isnull(ast_tab_listino_prezzi.x_datins ) then ast_tab_listino_prezzi.x_datins = datetime(date(0))
if isnull(ast_tab_listino_prezzi.x_utente ) then ast_tab_listino_prezzi.x_utente = ""


end subroutine

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: st_tab_listino non valorizzata     Output: st_tab_listino.id                  
//=== Ritorna ST_ESITO
//===           		  
//====================================================================
st_esito kst_esito
st_tab_listino_prezzi kst_tab_listino_prezzi

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT max(listino_prezzi.id_listino_prezzo)
	  into
	  			:kst_tab_listino_prezzi.id_listino_prezzo
   	 FROM listino_prezzi
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Voci Listino Prezzi (cercato MAX ID in listino_prezzi) ~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			kst_tab_listino_prezzi.id_listino_prezzo = 0
		end if
	end if

if isnull(kst_tab_listino_prezzi.id_listino_prezzo) then
	kst_tab_listino_prezzi.id_listino_prezzo = 0
end if
		
return kst_tab_listino_prezzi.id_listino_prezzo


end function

on kuf_listino_prezzi.create
call super::create
end on

on kuf_listino_prezzi.destroy
call super::destroy
end on

