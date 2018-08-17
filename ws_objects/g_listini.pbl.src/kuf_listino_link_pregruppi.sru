$PBExportHeader$kuf_listino_link_pregruppi.sru
forward
global type kuf_listino_link_pregruppi from kuf_parent
end type
end forward

global type kuf_listino_link_pregruppi from kuf_parent
end type
global kuf_listino_link_pregruppi kuf_listino_link_pregruppi

forward prototypes
public subroutine get_all_id_listino (ref st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception
public function string tb_delete (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi) throws uo_exception
public function string tb_delete_x_id_listino (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi) throws uo_exception
public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public subroutine if_isnull (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi)
public function long get_ultimo_id () throws uo_exception
public function integer get_all_id_listino_pregruppi (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function integer get_all_id_cond_fatt (ref st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception
public function boolean tb_add (datastore ads_listino_link_pregruppi, st_tab_g_0 ast_tab_g_0) throws uo_exception
end prototypes

public subroutine get_all_id_listino (ref st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab LISTINO_LINK_PREGRUPPI  per trovare tutti id_listino con una determinato id_listino_pregruppo
//--- 
//--- Inp:  st_tab_listino_link_pregruppi[1].id_listino_pregruppo
//--- out: array st_tab_listino_link_pregruppi[] con tutti i id_listino
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

declare c_get_all_id_listino cursor for
	select  a.id_listino
				from listino_link_pregruppi a
				where id_listino_pregruppo = :ast_tab_listino_link_pregruppi[1].id_listino_pregruppo
				using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_link_pregruppi[1].id_listino_pregruppo > 0 then //or isnull (ast_tab_listino_link_pregruppi[1].id_listino_pregruppo) then
		open c_get_all_id_listino;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino  into :ast_tab_listino_link_pregruppi[k_ind].id_listino;
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					ast_tab_listino_link_pregruppi[k_ind].id_listino_pregruppo = ast_tab_listino_link_pregruppi[1].id_listino_pregruppo
				else
					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.sqlerrtext = "Errore durante lettura Accociazioni Gruppo e Listino (listino_link_pregruppi). ID=" + string(ast_tab_listino_link_pregruppi[1].id_listino_pregruppo)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)				
						throw kguo_exception
					end if
				end if
	
			loop
			close c_get_all_id_listino;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura  Accociazioni Gruppo e Listino (listino_link_pregruppi). ID=" + string(ast_tab_listino_link_pregruppi[1].id_listino_pregruppo)
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

public function string tb_delete (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella LISTINO_LINK_PREGRUPPI
//--- 
//--- Inp:  st_tab_listino_link_pregruppi.id_listino_link_pregruppo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

string k_return = "0 "
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_listino_link_pregruppi.id_listino_link_pregruppo = 0 or isnull (ast_tab_listino_link_pregruppi.id_listino_link_pregruppo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Associazione Gruppo Voci-Listino non cancellata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if not this.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Associazione Gruppo Voci-Listino' non Autorizzata (id associazione=" + string(ast_tab_listino_link_pregruppi.id_listino_link_pregruppo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------
		
	delete from listino_link_pregruppi
				where id_listino_link_pregruppo = :ast_tab_listino_link_pregruppi.id_listino_link_pregruppo
				using kguo_sqlca_db_magazzino;
			
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione Associazione Gruppo Voci-Listino' (listino_link_pregruppi)  id=" + string(ast_tab_listino_link_pregruppi.id_listino_link_pregruppo) + ": " + trim(sqlca.SQLErrText)
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
		if ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function string tb_delete_x_id_listino (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella LISTINO_LINK_PREGRUPPI per ID_LISTINO
//--- 
//--- Inp:  st_tab_listino_link_pregruppi.id_listino
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

string k_return = "0 "
long k_righe, k_riga
st_esito kst_esito
//datastore kds_1
st_tab_listino_pregruppi_voci kst_tab_listino_pregruppi_voci
kuf_listino_prezzi kuf1_listino_prezzi
st_tab_listino_prezzi kst_tab_listino_prezzi 
datastore kds_listino_prezzi_l

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_listino_link_pregruppi.id_listino = 0 or isnull (ast_tab_listino_link_pregruppi.id_listino) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Associazione Gruppo Voci-Listino non eliminata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if NOT this.if_sicurezza(kkg_flag_modalita.cancellazione) then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.SQLErrText = "Cancellazione 'Associazione Gruppi Voci-Listino' non Autorizzata (id listino=" + string(ast_tab_listino_link_pregruppi.id_listino)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------

//--- elimina il Associazione gruppo-prezzi 
	kuf1_listino_prezzi = create kuf_listino_prezzi

	kds_listino_prezzi_l = create datastore
	kds_listino_prezzi_l.dataobject = "d_listino_link_pregruppi_prezzi_l"
	kds_listino_prezzi_l.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_listino_prezzi_l.retrieve(ast_tab_listino_link_pregruppi.id_listino )
	for k_riga = k_righe to 1 step -1
		kst_tab_listino_prezzi.id_listino_prezzo = kds_listino_prezzi_l.getitemnumber(k_riga, "id_listino_prezzo")
		kst_tab_listino_prezzi.st_tab_g_0.esegui_commit = "N"
		kuf1_listino_prezzi.tb_delete(kst_tab_listino_prezzi)
	end for
		
	delete from listino_link_pregruppi
				where id_listino = :ast_tab_listino_link_pregruppi.id_listino
				using kguo_sqlca_db_magazzino;
			
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione Associazione Gruppi Voci-Listino' (listino_link_pregruppi)  id listino=" + string(ast_tab_listino_link_pregruppi.id_listino) + ": " + trim(sqlca.SQLErrText)
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
		if ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function st_esito anteprima (ref datastore adw_anteprima, st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi);//
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
	
		if ast_tab_listino_link_pregruppi.id_listino > 0 then
	
			adw_anteprima.dataobject = "d_listino_link_pregruppi_prezzi_l"		
			adw_anteprima.settransobject(sqlca)
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_listino_link_pregruppi.id_listino)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Listino da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = "1"
			
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return kst_esito

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
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
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
	
		case  "b_listino_link_pregruppi" 
			kst_tab_listino_link_pregruppi.id_listino = adw_link.getitemnumber(adw_link.getrow(), "id_listino" )
			if kst_tab_listino_link_pregruppi.id_listino > 0 then
		
				kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_listino_link_pregruppi )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "id Listino: " + string(kst_tab_listino_link_pregruppi.id_listino)
			else
				k_return = false
			end if
	
	
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

public subroutine if_isnull (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_listino_link_pregruppi.id_listino_link_pregruppo  ) then ast_tab_listino_link_pregruppi.id_listino_link_pregruppo = 0
if isnull(ast_tab_listino_link_pregruppi.id_listino  ) then ast_tab_listino_link_pregruppi.id_listino = 0
if isnull(ast_tab_listino_link_pregruppi.id_listino_pregruppo  ) then ast_tab_listino_link_pregruppi.id_listino_pregruppo = 0
if isnull(ast_tab_listino_link_pregruppi.id_cond_fatt  ) then ast_tab_listino_link_pregruppi.id_cond_fatt = 0
if isnull(ast_tab_listino_link_pregruppi.cond_priorita  ) then ast_tab_listino_link_pregruppi.cond_priorita = 0
if isnull(ast_tab_listino_link_pregruppi.x_datins  ) then ast_tab_listino_link_pregruppi.x_datins = datetime(date(0))
if isnull(ast_tab_listino_link_pregruppi.x_utente  ) then ast_tab_listino_link_pregruppi.x_utente = ""

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
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT max(listino_link_pregruppi.id_listino_link_pregruppo)
	  into
	  			:kst_tab_listino_link_pregruppi.id_listino_link_pregruppo
   	 FROM listino_link_pregruppi
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino Prezzi (cercato MAX ID in listino_link_pregruppi) ~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			kst_tab_listino_link_pregruppi.id_listino_link_pregruppo = 0
		end if
	end if

if isnull(kst_tab_listino_link_pregruppi.id_listino_link_pregruppo) then
	kst_tab_listino_link_pregruppi.id_listino_link_pregruppo = 0
end if
		
return kst_tab_listino_link_pregruppi.id_listino_link_pregruppo


end function

public function integer get_all_id_listino_pregruppi (st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception;//
//====================================================================
//=== Ottiene tutti i  ID_LISTINO_PREGRUPPO  per   ID_LISTINO richiesto
//=== 
//=== 
//===  input: st_tab_listino_link_pregruppi[1].id_listino
//===  Outout: st_tab_listino_link_pregruppi[n].id_listino_pregruppo 
//===  rit: numero item trovati
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
integer k_return=0
long k_ind
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

		
declare c_get_all_id_listino_pregruppi cursor for
	select  a.id_listino_pregruppo
				from listino_link_pregruppi a
				where id_listino = :ast_tab_listino_link_pregruppi[1].id_listino
				using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_link_pregruppi[1].id_listino > 0 then //or isnull (ast_tab_listino_link_pregruppi[1].id_listino_pregruppo) then
		open c_get_all_id_listino_pregruppi;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_pregruppi  into :ast_tab_listino_link_pregruppi[k_ind].id_listino_pregruppo;
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					ast_tab_listino_link_pregruppi[k_ind].id_listino = ast_tab_listino_link_pregruppi[1].id_listino
				else
					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.sqlerrtext = "Errore durante lettura Accociazioni Gruppo e Listino (listino_link_pregruppi). ID Listino=" + string(ast_tab_listino_link_pregruppi[1].id_listino)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)				
						throw kguo_exception
					end if
				end if
	
			loop
			k_ind --
			close c_get_all_id_listino_pregruppi;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura  Accociazioni Gruppo e Listino (listino_link_pregruppi). ID Listino=" + string(ast_tab_listino_link_pregruppi[1].id_listino)
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
	if k_ind > 0 then
		k_return = k_ind
	end if
	

end try	
		
	
return k_return

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

      if ads_inp.getitemnumber ( k_riga, "id_listino") > 0 then 
      else
         k_errori ++
         k_tipo_errore="3"      // errore in questo campo: dati insuff.
         ads_inp.modify("id_listino.tag = '" + k_tipo_errore + "' ")
         kst_esito.esito = kkg_esito.DATI_INSUFF
         kst_esito.sqlerrtext = "Manca il valore nel campo " + trim(ads_inp.describe("id_listino_t.text")) +  "~n~r"  
      end if

      if  k_riga < k_nr_righe then
         if ads_inp.getitemnumber ( k_riga, "id_listino") > 0 then 
            if ads_inp.find ("id_listino = " + string(ads_inp.getitemnumber ( k_riga, "id_listino")), k_riga + 1, ads_inp.rowcount() ) > 0 then
   //                +" and id_listino_pregruppo_voce <> " + string(ads_inp.getitemnumber ( k_riga, "id_listino_prezzo")), k_riga + 1, ads_inp.rowcount() ) > 0 then
               k_tipo_errore="1"      
               ads_inp.modify("id_listino.tag = '" + k_tipo_errore + "' ")
               kst_esito.esito = kkg_esito.err_logico
               kst_esito.sqlerrtext = "Listino " + string(ads_inp.getitemnumber ( k_riga, "id_listino")) +" presente più di una volta " +  "~n~r"  
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

public function integer get_all_id_cond_fatt (ref st_tab_listino_link_pregruppi ast_tab_listino_link_pregruppi[]) throws uo_exception;//
//====================================================================
//=== Ottiene alcuni dati per   ID_LISTINO richiesto
//=== 
//=== 
//===  input: st_tab_listino_link_pregruppi[1].id_listino
//===  Outout: st_tab_listino_link_pregruppi[n]. id_listino_link_pregruppo e id_listino_pregruppo e id_cond_fatt
//===  rit: numero item trovati
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
integer k_return=0
long k_ind
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

		
declare c_get_all_id_listino_pregruppi cursor for
	select  a.id_listino_link_pregruppo
			,a.id_listino_pregruppo
			,a.id_cond_fatt
				from listino_link_pregruppi a
				where id_listino = :ast_tab_listino_link_pregruppi[1].id_listino
				order by cond_priorita
				using kguo_sqlca_db_magazzino;


try
	
	if  ast_tab_listino_link_pregruppi[1].id_listino > 0 then //or isnull (ast_tab_listino_link_pregruppi[1].id_listino_pregruppo) then
		open c_get_all_id_listino_pregruppi;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_pregruppi  into 
						:ast_tab_listino_link_pregruppi[k_ind].id_listino_link_pregruppo
						,:ast_tab_listino_link_pregruppi[k_ind].id_listino_pregruppo
						,:ast_tab_listino_link_pregruppi[k_ind].id_cond_fatt;
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					ast_tab_listino_link_pregruppi[k_ind].id_listino = ast_tab_listino_link_pregruppi[1].id_listino
				else
					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.sqlerrtext = "Errore durante lettura Accociazioni Condizioni Gruppo e Listino (listino_link_pregruppi). ID Listino=" + string(ast_tab_listino_link_pregruppi[1].id_listino)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)				
						throw kguo_exception
					end if
				end if
	
			loop
			k_ind --
			close c_get_all_id_listino_pregruppi;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura  Accociazioni Condizioni Gruppo e Listino (listino_link_pregruppi). ID Listino=" + string(ast_tab_listino_link_pregruppi[1].id_listino)
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
	if k_ind > 0 then
		k_return = k_ind
	end if
	

end try	
		
	
return k_return

end function

public function boolean tb_add (datastore ads_listino_link_pregruppi, st_tab_g_0 ast_tab_g_0) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella LISTINO
//=== 
//=== Inp: st_tab_listino_link_pregruppi - valorizzata
//=== Ritorna: TRUE=OK; FALSE=qlc errore di non caricato; 
//=== Lancia EXCEPTION 
//===  
//====================================================================
//
boolean k_return = false
long k_rc
st_esito kst_esito
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
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
	kst_esito.SQLErrText = "Inserimento 'Prezzi Listino' non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
else

	
	if ads_listino_link_pregruppi.rowcount() > 0 then
	
//--- imposto dati utente e data aggiornamento
		kst_tab_listino_link_pregruppi.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_listino_link_pregruppi.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
		if_isnull(kst_tab_listino_link_pregruppi)
	
		ads_listino_link_pregruppi.setitem(1, "id_listino_link_pregruppo", 0 )
//		ads_listino_link_pregruppi.setitem(1, "id_cond_fatt", kst_tab_listino_link_pregruppi.id_cond_fatt )
//		ads_listino_link_pregruppi.setitem(1, "cond_priorita", kst_tab_listino_link_pregruppi.cond_priorita)
		ads_listino_link_pregruppi.setitem(1, "x_datins", kst_tab_listino_link_pregruppi.x_datins )
		ads_listino_link_pregruppi.setitem(1, "x_utente", kst_tab_listino_link_pregruppi.x_utente )
	
		k_rc = ads_listino_link_pregruppi.update()
		if k_rc = 1 then
			if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			k_return = true
	
//--- piglia il numero di aggiornameno
			ads_listino_link_pregruppi.setitem(1, "id_listino_link_pregruppo", get_ultimo_id( ) )

		else
			if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqldbcode
			kst_esito.SQLErrText = "Inserimento 'Listino Prezzi' in errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext )
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if

	
end if


return k_return

end function

on kuf_listino_link_pregruppi.create
call super::create
end on

on kuf_listino_link_pregruppi.destroy
call super::destroy
end on

