$PBExportHeader$kuf_meca_dosimdalett.sru
forward
global type kuf_meca_dosimdalett from kuf_parent
end type
end forward

global type kuf_meca_dosimdalett from kuf_parent
end type
global kuf_meca_dosimdalett kuf_meca_dosimdalett

type variables
//-------------------------------------------
//--- Lettura del dosimetria: prima istanza
//-------------------------------------------

end variables

forward prototypes
public function boolean tb_delete (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean if_esiste_lotto (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception
public function long get_id_meca (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception
end prototypes

public function boolean tb_delete (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella Dosimetrie da Lettore
//--- 
//--- Inp:  st_tab_meca_dosimdalett.id_meca_dosimdalett
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
st_esito kst_esito
//datastore kds_1
st_tab_meca_dosim kst_tab_meca_dosim
kuf_meca_dosim kuf1_meca_dosim

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_meca_dosimdalett.id_meca_dosimdalett > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Codice Lettura Dosimetrica non eliminata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- recupera il ID LOTTO
//	this.get_id_meca(ast_tab_meca_dosimdalett)

	kuf1_meca_dosim = create kuf_meca_dosim
	
//--- Se Lotto già convalidato non posso cancellare
	kst_tab_meca_dosim.id_meca = ast_tab_meca_dosimdalett.id_meca
	if kuf1_meca_dosim.if_esiste(kst_tab_meca_dosim) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Dosimetria già Convalidata. - Rimozione non consentita "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if not if_sicurezza(kkg_flag_modalita.cancellazione) and not kuf1_meca_dosim.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Lettura Dosimetrica' non Autorizzata (id voce=" + string(ast_tab_meca_dosimdalett.id_meca_dosimdalett)+")~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------
		
	delete from meca_dosimdalett
				where id_meca_dosimdalett = :ast_tab_meca_dosimdalett.id_meca_dosimdalett
				using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Lettura Dosimetrica' (meca_dosimdalett)  id=" + string(ast_tab_meca_dosimdalett.id_meca_dosimdalett) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO.db_wrn
			else
				kst_esito.esito = KKG_ESITO.db_ko
			end if
		end if
	end if
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito_db_ko then
		if ast_tab_meca_dosimdalett.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimdalett.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true
		if ast_tab_meca_dosimdalett.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_dosimdalett.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID LETTURA DOSIMETRICA caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice id_meca_dosimdalett se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_meca_dosimdalett kst_tab_meca_dosimdalett


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosimdalett.id_meca_dosimdalett = 0
	
   SELECT max(id_meca_dosimdalett)
       into :kst_tab_meca_dosimdalett.id_meca_dosimdalett
		 FROM meca_dosimdalett
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 and kst_tab_meca_dosimdalett.id_meca > 0 then
		k_return = kst_tab_meca_dosimdalett.id_meca_dosimdalett
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura id in tab. Letture Dosimetriche  (cercato MAX CODICE) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if




return k_return




end function

public function boolean if_esiste_lotto (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception;//
//====================================================================
//=== Torna TRUE se almeno una dosimetria caricata x il LOTTO 
//=== 
//=== Input: ast_tab_meca_dosimdalett con valorizzato id_meca    Output: TRUE=già usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
boolean k_return = false
integer k_ctr
st_esito kst_esito



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_ctr = 1	
   	SELECT count(id_meca_dosimdalett)
       into :k_ctr
		 FROM meca_dosimdalett
		 where id_meca = :ast_tab_meca_dosimdalett.id_meca
			using kguo_sqlca_db_magazzino ;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Letture Dosimetriche per ricerca Lotto " + string(ast_tab_meca_dosimdalett.id_meca) + " ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


	if k_ctr > 0 then k_return = true


return k_return





end function

public function long get_id_meca (st_tab_meca_dosimdalett ast_tab_meca_dosimdalett) throws uo_exception;//
//====================================================================
//=== Torna ID LOTTO 
//=== 
//=== Input: st_tab_meca_dosimdalett.id_meca_dosimdalett
//=== Output: 
//=== Ritorna il codice id_meca
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_meca_dosimdalett kst_tab_meca_dosimdalett


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_meca_dosimdalett.id_meca = 0
	
   SELECT distinct id_meca
       into :kst_tab_meca_dosimdalett.id_meca
		 FROM meca_dosimdalett
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 and kst_tab_meca_dosimdalett.id_meca > 0 then
		k_return = kst_tab_meca_dosimdalett.id_meca_dosimdalett
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura id in tab. Letture Dosimetriche  (cercato id LOTTO) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if




return k_return




end function

on kuf_meca_dosimdalett.create
call super::create
end on

on kuf_meca_dosimdalett.destroy
call super::destroy
end on

