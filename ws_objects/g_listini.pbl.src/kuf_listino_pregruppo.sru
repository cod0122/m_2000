$PBExportHeader$kuf_listino_pregruppo.sru
forward
global type kuf_listino_pregruppo from kuf_parent
end type
end forward

global type kuf_listino_pregruppo from kuf_parent
end type
global kuf_listino_pregruppo kuf_listino_pregruppo

forward prototypes
public subroutine get_all_id_listino_pregruppo (ref st_tab_listino_pregruppo ast_tab_listino_pregruppo[]) throws uo_exception
public function boolean tb_delete (st_tab_listino_pregruppo ast_tab_listino_pregruppo) throws uo_exception
public function long get_ultimo_id () throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean tb_duplica (st_tab_listino_pregruppo ast_tab_listino_pregruppo) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_pregruppo ast_tab_listino_pregruppo)
public function st_esito anteprima_l (ref datastore adw_anteprima, st_tab_listino_pregruppo ast_tab_listino_pregruppo)
end prototypes

public subroutine get_all_id_listino_pregruppo (ref st_tab_listino_pregruppo ast_tab_listino_pregruppo[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab LISTINO_PREGRUPPO (tab ricorsiva)  per trovare tutti i record coinvolti con una determianto id_listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_pregruppo[1].id_listino_pregruppo
//--- out: array st_tab_listino_pregruppo[] con tutti id_listino_pregruppo coinvolti
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
					from listino_pregruppo a
 				start with id_listino_pregruppo = :ast_tab_listino_pregruppo[1].id_listino_pregruppo connect by prior id_listino_pregruppo_link =  id_listino_pregruppo 
				using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_pregruppo[1].id_listino_pregruppo = 0 or isnull (ast_tab_listino_pregruppo[1].id_listino_pregruppo) then
		open c_get_all_id_listino_pregruppo;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_pregruppo  into :ast_tab_listino_pregruppo[k_ind].id_listino_pregruppo;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura Gruppo Voci di Listino (listino_pregruppo). ID=" + string(ast_tab_listino_pregruppo[1].id_listino_pregruppo)
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
				kst_esito.sqlerrtext = "Errore preparazione lettura Gruppo Voci di Listino (listino_pregruppo). ID=" + string(ast_tab_listino_pregruppo[1].id_listino_pregruppo)
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

public function boolean tb_delete (st_tab_listino_pregruppo ast_tab_listino_pregruppo) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_pregruppo.id_listino_pregruppo
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
	
	if  ast_tab_listino_pregruppo.id_listino_pregruppo = 0 or isnull (ast_tab_listino_pregruppo.id_listino_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Gruppo-Voci non eliminato. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_listino_fvarie = create kuf_listino_fvarie
//--- Se esiste anche un solo collegamento allora NON posso cancellare
	if kuf1_listino_fvarie.if_pregruppo_a_listino(ast_tab_listino_pregruppo.id_listino_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Gruppo-Voci già presente a Listino. - Rimozione non consentita "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Gruppo-Voci' non Autorizzata (id gruppo=" + string(ast_tab_listino_pregruppo.id_listino_pregruppo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- elimina il gruppo-voci dalla tabella Prezzi
	kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
	kst_tab_listino_pregruppi_voci.id_listino_pregruppo = ast_tab_listino_pregruppo.id_listino_pregruppo
	kst_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit = "N"
	kuf1_listino_pregruppi_voci.tb_delete_x_id_pregruppo(kst_tab_listino_pregruppi_voci)

//--- elimina Gruppo		
	delete from listino_pregruppo
				where id_listino_pregruppo = :ast_tab_listino_pregruppo.id_listino_pregruppo
				using kguo_sqlca_db_magazzino;
			
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione 'Gruppo-Voci' (listino_pregruppo)  id=" + string(ast_tab_listino_pregruppo.id_listino_pregruppo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		if ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		k_return = true
		
		if ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit) then
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
//=== Torna l'ultimo ID GRUPPO LISTINO caricato in assoluto
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna il codice id_listino_pregruppo se c'e'
//=== 
//=== Lancia EXCEPTION
//=== 
//====================================================================
long k_return = 0
st_esito kst_esito
st_tab_listino_pregruppo kst_tab_listino_pregruppo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_listino_pregruppo.id_listino_pregruppo = 0
	
   SELECT   max(id_listino_pregruppo)
       into :kst_tab_listino_pregruppo.id_listino_pregruppo
		 FROM listino_pregruppo
			using sqlca;
	
	if sqlca.sqlcode = 0 then
		k_return = kst_tab_listino_pregruppo.id_listino_pregruppo
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Gruppo listino  (cercato MAX CODICE) ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
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

public function boolean tb_duplica (st_tab_listino_pregruppo ast_tab_listino_pregruppo) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Duplica il rek dalla tabella listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_pregruppo.id_listino_pregruppo da cui duplicare
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
int k_err = 0
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci, kst_tab_listino_pregruppi_voci_new
kuf_listino_pregruppi_voci kuf1_listino_pregruppi_voci
datastore kds_origine, kds_duplicato

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_listino_pregruppo.id_listino_pregruppo = 0 or isnull (ast_tab_listino_pregruppo.id_listino_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Gruppo-Voci non Duplicato. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kds_origine = create datastore
//	kds_duplicato = create datasore
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.inserimento) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Inserimento 'Gruppo-Voci' non Autorizzata (id gruppo=" + string(ast_tab_listino_pregruppo.id_listino_pregruppo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- DUPLICA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- crea Gruppo		
	kds_origine.dataobject = "d_listino_pregruppo"
	kds_origine.settransobject(kguo_sqlca_db_magazzino)
	kds_origine.insertrow(0)
	kds_origine.object.id_listino_pregruppo[1] = 0
	kds_origine.object.id_listino_pregruppo_link[1] = 0
	kds_origine.object.descr[1] = "Gruppo duplicato dal " + string(ast_tab_listino_pregruppo.id_listino_pregruppo)
	kds_origine.object.x_datins[1] = kGuf_data_base.prendi_x_datins( )
	kds_origine.object.x_utente[1] = kGuf_data_base.prendi_x_utente( )
	
//	kds_duplicato.dataobject = "d_listino_pregruppo"
//	kds_duplicato.settransobject(kguo_sqlca_db_magazzino)
//	kds_origine.object.id_listino_pregruppo[] = 0
//	kds_origine.rowscopy(1, kds_origine.rowcount(), primary!, kds_duplicato, 1, primary!)
//id_listino_pregruppo
			
	k_err =  kds_origine.update() 
	if k_err < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita duplica 'Gruppo-Voci' (listino_pregruppo)  id=" + string(ast_tab_listino_pregruppo.id_listino_pregruppo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if

	if kst_esito.esito = kkg_esito.db_ko then
		
//---- ROLLABACK.... 
		if ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		
		if k_err > 0 then  //OK!!!


//--- duplica il gruppo-voci nella tabella Prezzi
			kst_tab_listino_pregruppi_voci_new.id_listino_pregruppo = get_ultimo_id( )
			kuf1_listino_pregruppi_voci = create kuf_listino_pregruppi_voci
			kst_tab_listino_pregruppi_voci.id_listino_pregruppo = ast_tab_listino_pregruppo.id_listino_pregruppo
			kst_tab_listino_pregruppi_voci.st_tab_g_0.esegui_commit = ast_tab_listino_pregruppo.st_tab_g_0.esegui_commit
			if kuf1_listino_pregruppi_voci.tb_duplica(kst_tab_listino_pregruppi_voci, kst_tab_listino_pregruppi_voci_new) then
			
				k_return = true
				
			end if
			
		end if
		
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
st_tab_listino_pregruppo kst_tab_listino_pregruppo
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


try
	kdsi_elenco_output = create datastore
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	choose case a_campo_link
	
		case  "id_listino_pregruppo" 
			kst_tab_listino_pregruppo.id_listino_pregruppo = adw_link.getitemnumber(adw_link.getrow(), "id_listino_pregruppo" )
			if kst_tab_listino_pregruppo.id_listino_pregruppo > 0 then
		
				kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_listino_pregruppo )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "id Gruppo Listino: " + string(kst_tab_listino_pregruppo.id_listino_pregruppo)
			else
				k_return = false
			end if
	
		case  "b_listino_pregruppi"   // elenco 
			kst_tab_listino_pregruppo.id_listino_pregruppo = 0
			kst_esito = this.anteprima_l ( kdsi_elenco_output, kst_tab_listino_pregruppo )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Elenco Gruppi Listino "  
	
	
	end choose
	
	if k_return then
	
		if kdsi_elenco_output.rowcount() > 0 then
		
			
		//--- chiamare la window di elenco
		//
		//--- Parametri : 
		//--- struttura st_open_w
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kGuf_menu_window.open_w_tabelle(kst_open_w)
	
		else
			
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
			throw kguo_exception
			
			
		end if
	
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kp_oldpointer)

end try

return k_return

end function

public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_pregruppo ast_tab_listino_pregruppo);//
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
	
		if ast_tab_listino_pregruppo.id_listino_pregruppo > 0 then
	
			adw_anteprima.dataobject = "d_listino_pregruppi_voci_l" //"d_listino_voci_prezzi_l"		
			adw_anteprima.settransobject(sqlca)
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_listino_pregruppo.id_listino_pregruppo, 0)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Gruppo Listino da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = "1"
			
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return kst_esito

end function

public function st_esito anteprima_l (ref datastore adw_anteprima, st_tab_listino_pregruppo ast_tab_listino_pregruppo);//
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
	
		adw_anteprima.dataobject = "d_listino_pregruppo_l"		
		adw_anteprima.settransobject(sqlca)
	
		adw_anteprima.reset()	
	//--- retrive dell'attestato 
		k_rc=adw_anteprima.retrieve()
	
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return kst_esito

end function

on kuf_listino_pregruppo.create
call super::create
end on

on kuf_listino_pregruppo.destroy
call super::destroy
end on

