$PBExportHeader$kuf_listino_pregruppi_voci.sru
forward
global type kuf_listino_pregruppi_voci from kuf_parent
end type
end forward

global type kuf_listino_pregruppi_voci from kuf_parent
end type
global kuf_listino_pregruppi_voci kuf_listino_pregruppi_voci

type variables
public constant string kki_attivo_si="S"
public constant string kki_attivo_no="N"


end variables

forward prototypes
public subroutine get_all_id_listino_pregruppo (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci[]) throws uo_exception
public function boolean tb_delete_x_id_voce (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception
public function boolean tb_delete (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception
public function boolean tb_delete_x_id_pregruppo (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception
public function st_esito get_id_listino_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception
public function st_esito get_id_listino_pregruppo_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public subroutine get_all_id_listino_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci[]) throws uo_exception
public function st_esito u_check_dati_1 (ref datastore ads_inp) throws uo_exception
public function boolean tb_duplica (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci_orig, st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci_new)
end prototypes

public subroutine get_all_id_listino_pregruppo (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab listino_pregruppi_voci  per trovare tutti i id_listino_pregruppo con una determinato id_listino_voce
//--- 
//--- Inp:  st_tab_listino_pregruppi_voci[1].id_listino_voce
//--- out: array st_tab_listino_pregruppi_voci[] con tutti i id_listino_pregruppo 
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

declare c_get_all_id_listino_pregruppo cursor for
	select  a.id_listino_pregruppo
			from listino_pregruppi_voci a
			where id_listino_voce = :ast_tab_listino_pregruppi_voci[1].id_listino_voce
				and attivo = "S"
	using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_pregruppi_voci[1].id_listino_voce > 0 then
		open c_get_all_id_listino_pregruppo;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0 
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_pregruppo  into :ast_tab_listino_pregruppi_voci[k_ind].id_listino_pregruppo;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura Prezzi Voci di Listino (listino_pregruppi_voci). ID=" + string(ast_tab_listino_pregruppi_voci[1].id_listino_voce)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)				
					throw kguo_exception
				end if
	
			loop
			close c_get_all_id_listino_pregruppo;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura Prezzi Voci di Listino (listino_pregruppi_voci). ID=" + string(ast_tab_listino_pregruppi_voci[1].id_listino_voce)
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

public function boolean tb_delete_x_id_voce (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella listino_pregruppi_voci x id_listino_voce
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_voce
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
		kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' non Autorizzata (id=" + string(ast_tab_listino_pregruppi_voci.id_listino_voce) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_pregruppi_voci.id_listino_voce > 0 then
      
		kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
		if kuf1_listino_fvarie.if_voce_a_listino(ast_tab_listino_pregruppi_voci.id_listino_voce) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Voce già presente a Listino (tb_delete_x_id_voce). - Rimozione non consentita "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		      
		delete from listino_pregruppi_voci
			where id_listino_voce = :ast_tab_listino_pregruppi_voci.id_listino_voce
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' (listino_pregruppi_voci)  id=" + string(ast_tab_listino_pregruppi_voci.id_listino_voce) + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
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

public function boolean tb_delete (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella listino_pregruppi_voci 
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_pregruppo_voce
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
		kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino' non Autorizzata (id prezzo=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce > 0 then
//--- leggo la voce di questo record      
		this.get_id_listino_voce(ast_tab_listino_pregruppi_voci)
		
		if ast_tab_listino_pregruppi_voci.id_listino_voce > 0 then
			kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
			if kuf1_listino_fvarie.if_voce_a_listino(ast_tab_listino_pregruppi_voci.id_listino_voce) then
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Voce già presente a Listino (tb_delete_x_id_voce). - Rimozione non consentita "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
		
		      
		delete from listino_pregruppi_voci
			where id_listino_pregruppo_voce = :ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzo Voce Listino'  (listino_pregruppi_voci)  id=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce) + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
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

public function boolean tb_delete_x_id_pregruppo (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella listino_pregruppi_voci x id_listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_pregruppo
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
		kst_esito.SQLErrText = "Cancellazione 'Prezzi Voce Listino' non Autorizzata (id=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo) + "): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	end if
	
	if ast_tab_listino_pregruppi_voci.id_listino_pregruppo > 0 then
      
		kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
		if kuf1_listino_fvarie.if_pregruppo_a_listino(ast_tab_listino_pregruppi_voci.id_listino_pregruppo) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Gruppo-Voci già presente a Listino (tb_delete_x_id_pregrupppo). - Rimozione non consentita "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		      
		delete from listino_pregruppi_voci
			where id_listino_pregruppo = :ast_tab_listino_pregruppi_voci.id_listino_pregruppo
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Prezzi Voce Listino' (listino_pregruppi_voci)  id=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo) + ": " + trim(sqlca.SQLErrText)
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
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			
//--- lancio EXCEPTION			
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else
			if ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit) then
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

public function st_esito get_id_listino_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------
//--- Get campo 
//--- 
//--- Inp: st_tab_listino_pregruppi_voci.id_listino_pregruppo_voce
//--- Out: st_tab_listino_pregruppi_voci.id_lsitino_voce
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
	

	if ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce > 0 then
      
		      
		select id_listino_voce 
			into :ast_tab_listino_pregruppi_voci.id_listino_voce
		     from listino_pregruppi_voci
			where id_listino_pregruppo_voce = :ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			ast_tab_listino_pregruppi_voci.id_listino_voce = 0
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura da 'Prezzo Voce Listino' del id_listino_voce (listino_pregruppi_voci) non riuscito, id=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce) + ": " + trim(sqlca.SQLErrText)
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
			if isnull(ast_tab_listino_pregruppi_voci.id_listino_voce) then ast_tab_listino_pregruppi_voci.id_listino_voce = 0
		end if
			
	end if

	
	catch (uo_exception kuo_exception)
		throw kuo_exception

end try

return kst_esito

end function

public function st_esito get_id_listino_pregruppo_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------
//--- Get del id prezzo da  Voce e Pregruppo 
//--- 
//--- Inp: st_tab_listino_pregruppi_voci.id_listino_pregruppo+id_listino_voce
//--- Out: st_tab_listino_pregruppi_voci.id_listino_pregruppo_voce
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
	

	if ast_tab_listino_pregruppi_voci.id_listino_pregruppo > 0 and  ast_tab_listino_pregruppi_voci.id_listino_voce > 0 then
      
		      
		select id_listino_pregruppo_voce 
			into :ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce
		     from listino_pregruppi_voci
			where id_listino_voce = :ast_tab_listino_pregruppi_voci.id_listino_voce
			      and id_listino_pregruppo = :ast_tab_listino_pregruppi_voci.id_listino_pregruppo
			using kguo_sqlca_db_magazzino ;

		
		if sqlca.sqlcode <> 0 then
			ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce = 0
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura da 'Prezzo Voce Listino' (listino_pregruppi_voci) non riuscito, id voce=" + string(ast_tab_listino_pregruppi_voci.id_listino_voce) + ", id pregruppo=" + string(ast_tab_listino_pregruppi_voci.id_listino_pregruppo) + ": " + trim(sqlca.SQLErrText)
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
			if isnull(ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce) then ast_tab_listino_pregruppi_voci.id_listino_pregruppo_voce = 0
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
   //                +" and id_listino_pregruppo_voce <> " + string(ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo_voce")), k_riga + 1, ads_inp.rowcount() ) > 0 then
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

public subroutine get_all_id_listino_voce (ref st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab listino_pregruppi_voci  per trovare tutti i id_listino_voce attivi con una determinato id_listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_pregruppi_voci[1].id_listino_pregruppo
//--- out: array st_tab_listino_pregruppi_voci[] con tutti i id_listino_pregruppo 
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

declare c_get_all_id_listino_pregruppo cursor for
	select  a.id_listino_voce
			from listino_pregruppi_voci a
			where id_listino_pregruppo = :ast_tab_listino_pregruppi_voci[1].id_listino_pregruppo
				and attivo = "S"
	using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_pregruppi_voci[1].id_listino_pregruppo > 0 then
		open c_get_all_id_listino_pregruppo;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_pregruppo  into :ast_tab_listino_pregruppi_voci[k_ind].id_listino_voce;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante la lettura Prezzi Voci di Listino (listino_pregruppi_voci). ID=" + string(ast_tab_listino_pregruppi_voci[1].id_listino_pregruppo)
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)				
					throw kguo_exception
				end if
	
			loop
			close c_get_all_id_listino_pregruppo;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione la lettura Prezzi Voci di Listino (listino_pregruppi_voci). ID=" + string(ast_tab_listino_pregruppi_voci[1].id_listino_pregruppo)
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
   //                +" and id_listino_pregruppo_voce <> " + string(ads_inp.getitemnumber ( k_riga, "id_listino_pregruppo_voce")), k_riga + 1, ads_inp.rowcount() ) > 0 then
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

public function boolean tb_duplica (st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci_orig, st_tab_listino_pregruppi_voci ast_tab_listino_pregruppi_voci_new);//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Duplica il rek dalla tabella listino_pregruppi_voci
//--- 
//--- Inp:  st_tab_listino_pregruppi_voci.id_listino_pregruppi_voci da cui duplicare
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
	
	if  ast_tab_listino_pregruppi_voci_orig.id_listino_pregruppo = 0 or isnull (ast_tab_listino_pregruppi_voci_orig.id_listino_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Prezzo-Voci non Duplicato. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.inserimento) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Duplica 'Prezzo Voce Listino' non Autorizzata (da ID gruppo=" + string(ast_tab_listino_pregruppi_voci_orig.id_listino_pregruppo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- DUPLICA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- crea Gruppo		
	kds_origine = create datastore
	kds_origine.dataobject = "d_listino_pregruppi_voci_l"
	kds_origine.settransobject(kguo_sqlca_db_magazzino)
	k_righe = kds_origine.retrieve(ast_tab_listino_pregruppi_voci_orig.id_listino_pregruppo, 0)
	for k_riga = 1 to k_righe
		kds_origine.object.id_listino_pregruppo[k_riga] = ast_tab_listino_pregruppi_voci_NEW.id_listino_pregruppo
		kds_origine.object.id_listino_pregruppo_voce[k_riga] = 0
		kds_origine.object.x_datins[k_riga] = kGuf_data_base.prendi_x_datins( )
		kds_origine.object.x_utente[k_riga] = kGuf_data_base.prendi_x_utente( )
		kds_origine.setitemstatus( k_riga, 0, primary!, New!)
	end for
	
//	kds_duplicato = create datasore
//	kds_duplicato.dataobject = "d_listino_pregruppi_voci_l"
//	kds_duplicato.settransobject(kguo_sqlca_db_magazzino)
//	kds_origine.rowscopy(1, kds_origine.rowcount(), primary!, kds_duplicato, 1, primary!)
			
	k_err =  kds_origine.update() 
	if k_err < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita duplica 'Prezzo Voce Listino' (listino_pregruppi_voci) da id=" + string(ast_tab_listino_pregruppi_voci_orig.id_listino_pregruppo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_listino_pregruppi_voci_orig.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci_orig.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		
		if k_err > 0 then  //OK!!!
		
			k_return = true
			
			if ast_tab_listino_pregruppi_voci_orig.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppi_voci_orig.st_tab_g_0.esegui_commit) then
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

on kuf_listino_pregruppi_voci.create
call super::create
end on

on kuf_listino_pregruppi_voci.destroy
call super::destroy
end on

