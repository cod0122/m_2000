$PBExportHeader$kuf_listino_voci.sru
forward
global type kuf_listino_voci from kuf_parent
end type
end forward

global type kuf_listino_voci from kuf_parent
end type
global kuf_listino_voci kuf_listino_voci

type variables
public constant string kki_attivo_si="S"
public constant string kki_attivo_no="N"

public constant string kki_tipo_listino_a_corpo="I"  // prezzo del lotto totale 
public constant string kki_tipo_listino_a_collo="C"  // prezzo unitario x collo

public constant string kki_tipo_calcolo_in_entrata="E" // calcolato solo in entrata
public constant string kki_tipo_calcolo_in_uscita="U" // calcolato solo in uscita
public constant string kki_tipo_calcolo_spot="S"    // calcolato con le q.ta in entrata una sola volta
public constant string kki_tipo_calcolo_spot_libero="L"    // calcolato senza q.ta' (spot) una sola volta "A CORPO"
public constant string kki_tipo_calcolo_xmese="M" // calcolato il primo del mese successivo all'entrata (giacenza)

public constant string kki_differito_si ="S" // prezzo applicato solo su esplicita richiesta operatore
public constant string kki_differito_no ="N" // prezzo applicato subito

public constant string kki_aperto_si ="S" // un operatore può caricare questo costo + volte in autonomia
public constant string kki_aperto_no ="N" // costo caricato una volta sola 


public constant string kki_um_assente = 'A' // unità di misura = ASSENTE (nessuna in particolare)
public constant string kki_um_colli = 'C' // unità di misura = COLLI
public constant string kki_um_ped = 'P' // unità di misura = PEDANE
public constant string kki_um_ore = 'O' // unità di misura = ORE
public constant string kki_um_gg = 'G' // unità di misura = GIORNI
public constant string kki_um_mm = 'M' // unità di misura = MESI
public constant string kki_um_mt = 'T' // unità di misura = METRI
public constant string kki_um_doc = 'D' // unità di misura = DOCUMENTO

end variables

forward prototypes
public function boolean if_presente_id_listino_voci_categ (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function boolean tb_delete (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception
public function string get_descr_da_id_listino_voci_categ (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_voci ast_tab_listino_voci)
end prototypes

public function boolean if_presente_id_listino_voci_categ (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception;//
//====================================================================
//=== Torna TRUE se CATEGORIA trovato su almeno una voce   
//=== 
//=== Input: ast_tab_listino_voci con valorizzato id_listino_voci_categ    Output: TRUE=già usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
boolean k_return = false
integer k_ctr
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_ctr = 1	
   	SELECT count(id_listino_voci_categ)
       into :k_ctr
		 FROM listino_voci
		 where id_listino_voci_categ = :ast_tab_listino_voci.id_listino_voci_categ
			using kguo_sqlca_db_magazzino ;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Voci Listino per ricerca Categoria " + trim(ast_tab_listino_voci.id_listino_voci_categ) + " ~n~r:" + trim(sqlca.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if


	if k_ctr > 0 then k_return = true


return k_return





end function

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID VOCE LISTINO caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice id_listino_voce se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_listino_voci kst_tab_listino_voci


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_listino_voci.id_listino_voce = 0
	
   SELECT   max(id_listino_voce)
       into :kst_tab_listino_voci.id_listino_voce
		 FROM listino_voci
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = kst_tab_listino_voci.id_listino_voce
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Voci listino  (cercato MAX CODICE) ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if




return k_return




end function

public function boolean tb_delete (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella LISTINO_VOCI
//--- 
//--- Inp:  st_tab_listino_voci.id_listino_voce
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci
kuf_listino_fvarie kuf1_listino_fvarie


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_listino_voci.id_listino_voce = 0 or isnull (ast_tab_listino_voci.id_listino_voce) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Voce Listino non eliminata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//	kds_1 = create datastore
//	kds_1.dataobject = "d_if_listino_cliente_estinto_no"
//	kds_1.settransobject( kguo_sqlca_db_magazzino )
//	k_if_estinto_no = kds_1.retrieve(kst_tab_listino.id )  
	
	kuf1_listino_fvarie = create kuf_listino_fvarie
	kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci

	
//--- Se esiste anche un solo collegamento allora NON posso cancellare
	if kuf1_listino_fvarie.if_voce_a_listino(ast_tab_listino_voci.id_listino_voce) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Voce già presente a Listino. - Rimozione non consentita "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if not if_sicurezza(kkg_flag_modalita.cancellazione) and not kuf1_listino_pregruppi_voci.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Voce di Listino' non Autorizzata (id voce=" + string(ast_tab_listino_voci.id_listino_voce)+"): ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------
		
//--- prima cancello tabelle correlate		
	kst_tab_listino_pregruppi_voci.id_listino_voce = ast_tab_listino_voci.id_listino_voce
	kst_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit = "N"
	kuf1_listino_pregruppi_voci.tb_delete_x_id_voce(kst_tab_listino_pregruppi_voci)
		
				
//--- infine cancello il rec su questa tabella
	delete from listino_voci
				where id_listino_voce = :ast_tab_listino_voci.id_listino_voce
				using kguo_sqlca_db_magazzino;
			
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Voce Listino' (listino_voci)  id=" + string(ast_tab_listino_voci.id_listino_voce) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO.db_wrn
			else
				kst_esito.esito = KKG_ESITO.db_ko
			end if
		end if
	end if
		
//---- COMMIT.... 
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_listino_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_voci.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true
		if ast_tab_listino_voci.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_voci.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function string get_descr_da_id_listino_voci_categ (st_tab_listino_voci ast_tab_listino_voci) throws uo_exception;//
//====================================================================
//=== Legge tabella VOCI LISTINO per reperire la descrizione
//=== 
//=== Input: kst_tab_listino_voci.id_listino_voci_categ
//=== Out:      
//=== Ritorna la  descrizione
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
		 distinct min(descr)
    INTO 
	 	  :ast_tab_listino_voci.descr 
        FROM listino_voci
        WHERE ( id_listino_voci_categ = :ast_tab_listino_voci.id_listino_voci_categ   )   
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Voci Listino: " + trim(sqlca.SQLErrText)
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

	if len(trim(ast_tab_listino_voci.descr)) > 0 then
		k_return = ast_tab_listino_voci.descr
	end if

return k_return

end function

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
	
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito


 
 
 
end function

public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_voci ast_tab_listino_voci);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try

	if not if_sicurezza(kkg_flag_modalita.anteprima) then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if ast_tab_listino_voci.id_listino_voce > 0 then
	
			adw_anteprima.dataobject = "d_listino_voci"		
			adw_anteprima.settransobject(sqlca)
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_listino_voci.id_listino_voce)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Voce da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = "1"
			
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return kst_esito

end function

on kuf_listino_voci.create
call super::create
end on

on kuf_listino_voci.destroy
call super::destroy
end on

