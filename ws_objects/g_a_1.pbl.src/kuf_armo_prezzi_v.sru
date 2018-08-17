$PBExportHeader$kuf_armo_prezzi_v.sru
forward
global type kuf_armo_prezzi_v from kuf_parent
end type
end forward

global type kuf_armo_prezzi_v from kuf_parent
end type
global kuf_armo_prezzi_v kuf_armo_prezzi_v

type variables

public constant string kki_stato_daFatt = "1" 
public constant string kki_stato_info = "2" 

public constant string kki_segno_piu = "+" 
public constant string kki_segno_meno = "-" 

end variables

forward prototypes
public subroutine if_isnull (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v)
public function long get_ultimo_id () throws uo_exception
public subroutine set_armo_prezzo (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean tb_delete_x_id_armo_prezzo (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v) throws uo_exception
end prototypes

public subroutine if_isnull (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_armo_prezzi_v.id_armo_prezzo_v  ) then ast_tab_armo_prezzi_v.id_armo_prezzo_v = 0
if isnull(ast_tab_armo_prezzi_v.id_armo_prezzo  ) then ast_tab_armo_prezzi_v.id_armo_prezzo = 0
if isnull(ast_tab_armo_prezzi_v.colli  ) then ast_tab_armo_prezzi_v.colli = 0
if isnull(ast_tab_armo_prezzi_v.descr  ) then ast_tab_armo_prezzi_v.descr = ""
if isnull(ast_tab_armo_prezzi_v.segno  ) then ast_tab_armo_prezzi_v.segno = ""
if isnull(ast_tab_armo_prezzi_v.stato  ) then ast_tab_armo_prezzi_v.stato = ""
if isnull(ast_tab_armo_prezzi_v.x_datins  ) then ast_tab_armo_prezzi_v.x_datins = datetime(date(0))
if isnull(ast_tab_armo_prezzi_v.x_utente  ) then ast_tab_armo_prezzi_v.x_utente = ""

end subroutine

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID VOCE LISTINO caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice id_armo_prezzo_v se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_armo_prezzi_v.id_armo_prezzo_v = 0
	
   	SELECT max(id_armo_prezzo_v)
       into :kst_tab_armo_prezzi_v.id_armo_prezzo_v
		 FROM armo_prezzi_v
			using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = kst_tab_armo_prezzi_v.id_armo_prezzo_v
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Voce Riga Costo  (armo_prezzi_v cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if




return k_return




end function

public subroutine set_armo_prezzo (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v) throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//--- Imposta i valori della ARMO_PREZZI_V dentro alla ARMO_PREZZI 
//---
//--- Inp: st_tab_armo_prezzi_v valorizzata
//--- Out: -
//--- Rit.: -
//--- lancia exception
//--------------------------------------------------------------------------------------------------------------------

st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi
kuf_armo_prezzi kuf1_armo_prezzi


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_armo_prezzi_v.id_armo_prezzo > 0 then
		
		if ast_tab_armo_prezzi_v.stato = kki_stato_dafatt and ast_tab_armo_prezzi_v.colli > 0 then
			
			kuf1_armo_prezzi = create kuf_armo_prezzi
			
			kst_tab_armo_prezzi.id_armo_prezzo = ast_tab_armo_prezzi_v.id_armo_prezzo
			kst_esito = kuf1_armo_prezzi.get_stato(kst_tab_armo_prezzi)
			if kst_esito.esito = kkg_esito.ok then
				kst_esito = kuf1_armo_prezzi.get_item(kst_tab_armo_prezzi)
			end if
			if kst_esito.esito = kkg_esito.ok then

//--- se devo incrementare i colli da fatturare				
				if ast_tab_armo_prezzi_v.segno = kki_segno_piu then
					kst_tab_armo_prezzi.stato = kuf1_armo_prezzi.kki_stato_dafatt
					kst_tab_armo_prezzi.item_dafatt += ast_tab_armo_prezzi_v.colli
				else
//--- se devo Decrementare i colli allora poi vedo se c'e' qls da fatturare altrimenti cambio lo stato
					kst_tab_armo_prezzi.item_dafatt -= ast_tab_armo_prezzi_v.colli
					if kst_tab_armo_prezzi.item_dafatt < 0 then kst_tab_armo_prezzi.item_dafatt = 0
					if kst_tab_armo_prezzi.item_dafatt = 0 then kst_tab_armo_prezzi.stato = kuf1_armo_prezzi.kki_stato_attesa
				end if

//--- aggiorna i campi
				kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = "N"
				kuf1_armo_prezzi.set_stato(kst_tab_armo_prezzi)
				kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = "S"
				kuf1_armo_prezzi.set_item(kst_tab_armo_prezzi)
				
			end if			
			
		end if
		
	else

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Costo Riga Lotto non caricato. Manca id Riga! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if


catch(uo_exception kuo_exception)
	throw kuo_exception

end try

end subroutine

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
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
	
	if trim(ads_inp.object.descr[1]) > " "  then
	else
		k_errori ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		ads_inp.object.descr.tag = k_tipo_errore 
		kst_esito.esito = kkg_esito.err_formale
		kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if ads_inp.object.colli[1] > 0  then
	else
		k_errori ++
		k_tipo_errore="3"      // errore in questo campo: dati insuff.
		ads_inp.object.descr.tag = k_tipo_errore 
		kst_esito.esito = kkg_esito.err_formale
		kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.object.colli_t.text) +  "~n~r"  
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

public function boolean tb_delete_x_id_armo_prezzo (st_tab_armo_prezzi_v ast_tab_armo_prezzi_v) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella armo_prezzi_v_v
//--- 
//--- Inp:  st_tab_armo_prezzi_v.id_armo_prezzo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_armo_prezzi_v.id_armo_prezzo = 0 or isnull (ast_tab_armo_prezzi_v.id_armo_prezzo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "'Riga Voce aperta aggiunta' al Lotto non cancellata. Manca ID prezzo riga "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
//	if not this.if_sicurezza(kkg_flag_modalita.cancellazione) then
//		kst_esito.esito = kkg_esito.no_aut
//		kst_esito.SQLErrText = "Cancellazione 'riga Voce aperta aggiunta' non Autorizzata (id prezzo=" + string(ast_tab_armo_prezzi_v.id_armo_prezzo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------
		
	delete from armo_prezzi_v
				where id_armo_prezzo = :ast_tab_armo_prezzi_v.id_armo_prezzo
				using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Cancellazione riga Voce aggiunta x riga Lotto' (armo_prezzi_v)  id prezzo=" + string(ast_tab_armo_prezzi_v.id_armo_prezzo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_armo_prezzi_v.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi_v.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if ast_tab_armo_prezzi_v.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi_v.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

on kuf_armo_prezzi_v.create
call super::create
end on

on kuf_armo_prezzi_v.destroy
call super::destroy
end on

