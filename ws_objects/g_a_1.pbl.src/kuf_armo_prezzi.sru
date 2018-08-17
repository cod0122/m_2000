$PBExportHeader$kuf_armo_prezzi.sru
forward
global type kuf_armo_prezzi from kuf_parent
end type
end forward

global type kuf_armo_prezzi from kuf_parent
end type
global kuf_armo_prezzi kuf_armo_prezzi

type variables
//--- campo STATO
public constant string kki_stato_potenziale = "2"    //potenziale/sospeso
public constant string kki_stato_attesa = "4"    //in attesa di evento x diventare 'da fatturare'
public constant string kki_stato_daFatt = "6"    //da fatturare
public constant string kki_stato_fatt = "8"    //gia' fatturato



end variables

forward prototypes
public function st_esito anteprima (ref datastore adw_anteprima, st_tab_armo_prezzi ast_tab_armo_prezzi)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function long tb_add (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception
public subroutine if_isnull (st_tab_armo_prezzi ast_tab_armo_prezzi)
public function long get_ultimo_id () throws uo_exception
public function boolean if_esiste_x_id_armo (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean esegui_evento_carico (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean esegui_evento_scarico (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean tb_delete_x_id_armo (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean tb_delete (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean esegui_evento_scarico_ripristina (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito get_stato (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito get_all_id_listino_voce (ref st_tab_armo_prezzi ast_tab_armo_prezzi[]) throws uo_exception
public function st_esito get_item (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito set_stato (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito set_item (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public subroutine esegui_evento_update (ref datastore ads_armo_prezzi_x_tipo_calcolo, st_tab_g_0 ast_tab_g_0) throws uo_exception
public function boolean esegui_evento_mese_old (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function integer esegui_evento_mese (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito get_prezzo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean set_fatturato (readonly st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean set_fatturato_ripri (readonly st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function st_esito anteprima_prezzi (ref datastore adw_anteprima, st_tab_armo_prezzi ast_tab_armo_prezzi)
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function long tb_add_noaut (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception
private function long tb_add_0 (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception
public function st_esito set_stato_x_id_armo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function st_esito reset_dafatt_x_id_armo_no_ifsicurezza (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public subroutine set_dafatt_x_id_armo_no_ifsicurezza (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
public subroutine set_dafatt_x_id_armo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception
end prototypes

public function st_esito anteprima (ref datastore adw_anteprima, st_tab_armo_prezzi ast_tab_armo_prezzi);//
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
	
		if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
	
			adw_anteprima.dataobject = "d_armo_prezzi"		
			adw_anteprima.settransobject(sqlca)
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_armo_prezzi.id_armo_prezzo)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Prezzo da visualizzare: nessun codice indicato"
			kst_esito.esito = kkg_esito.no_esecuzione
			
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
st_tab_armo_prezzi kst_tab_armo_prezzi
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
	
		case  "id_armo_prezzo" 
			kst_tab_armo_prezzi.id_armo_prezzo = adw_link.getitemnumber(adw_link.getrow(), "id_armo_prezzo" )
			if kst_tab_armo_prezzi.id_armo_prezzo > 0 then
		
				kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_armo_prezzi )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Prezzo Riga Lotto (id prezzo " + string(kst_tab_armo_prezzi.id_armo_prezzo) + ") "
			else
				k_return = false
			end if
			
		case  "b_armo_prezzi" ,"armo_prezzi"
			kst_tab_armo_prezzi.id_armo = adw_link.getitemnumber(adw_link.getrow(), "id_armo" )
			kst_tab_armo_prezzi.stato = "*"
			if kst_tab_armo_prezzi.id_armo > 0 then
		
				kst_esito = this.anteprima_prezzi ( kdsi_elenco_output, kst_tab_armo_prezzi )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Voci Riga Lotto  (id riga " + string(kst_tab_armo_prezzi.id_armo) + ") "
			else
				k_return = false
			end if
			
		case  "b_armo_prezzi_xstato" &
			 ,"armo_prezzi_xstato" 
			kst_tab_armo_prezzi.id_armo = adw_link.getitemnumber(adw_link.getrow(), "id_armo" )
			kst_tab_armo_prezzi.stato = adw_link.getitemstring(adw_link.getrow(), "armo_prezzi_stato" )
			if kst_tab_armo_prezzi.stato > " " then
			else
				kst_tab_armo_prezzi.stato = "*"
			end if
			if kst_tab_armo_prezzi.id_armo > 0 then
		
				kst_esito = this.anteprima_prezzi ( kdsi_elenco_output, kst_tab_armo_prezzi )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Voci Riga Lotto  (id riga " + string(kst_tab_armo_prezzi.id_armo) + ") "
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
			kst_open_w.settrans = "db_magazzino"
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

public function long tb_add (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella ARMO_PREZZO (riga prezzo del Lotto entrato)
//=== 
//=== Inp: st_tab_armo_prezzi - valorizzata
//=== Ritorna: numero righe aggiornate; 
//=== Lancia EXCEPTION//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//===  
//====================================================================
//
long k_return = 0, k_rc, k_riga=0
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi
//kuf_sicurezza kuf1_sicurezza
//st_open_w kst_open_w
boolean k_autorizza




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if_sicurezza(kkg_flag_modalita.inserimento)

//--- INSERT SU TABELLA
	k_return = tb_add_0( ads_armo_prezzi, ast_tab_g_0)
	


return k_return

end function

public subroutine if_isnull (st_tab_armo_prezzi ast_tab_armo_prezzi);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_armo_prezzi.id_armo_prezzo  ) then ast_tab_armo_prezzi.id_armo_prezzo = 0
if isnull(ast_tab_armo_prezzi.id_armo  ) then ast_tab_armo_prezzi.id_armo = 0
if isnull(ast_tab_armo_prezzi.id_listino_link_pregruppo  ) then ast_tab_armo_prezzi.id_listino_link_pregruppo = 0
if isnull(ast_tab_armo_prezzi.id_listino_voce  ) then ast_tab_armo_prezzi.id_listino_voce = 0
if isnull(ast_tab_armo_prezzi.prezzo  ) then ast_tab_armo_prezzi.prezzo = 0
if isnull(ast_tab_armo_prezzi.item_daFatt  ) then ast_tab_armo_prezzi.item_daFatt = 0
if isnull(ast_tab_armo_prezzi.item_noFatt  ) then ast_tab_armo_prezzi.item_noFatt = 0
if isnull(ast_tab_armo_prezzi.item_fatt  ) then ast_tab_armo_prezzi.item_fatt = 0
if isnull(ast_tab_armo_prezzi.tipo_calcolo  ) then ast_tab_armo_prezzi.tipo_calcolo = ""
if isnull(ast_tab_armo_prezzi.tipo_listino  ) then ast_tab_armo_prezzi.tipo_listino = ""
if isnull(ast_tab_armo_prezzi.stato  ) then ast_tab_armo_prezzi.stato = ""
if isnull(ast_tab_armo_prezzi.x_carico_dt  ) then ast_tab_armo_prezzi.x_carico_dt = datetime(date(0))
if isnull(ast_tab_armo_prezzi.x_carico_utente  ) then ast_tab_armo_prezzi.x_carico_utente = ""
if isnull(ast_tab_armo_prezzi.x_datins  ) then ast_tab_armo_prezzi.x_datins = datetime(date(0))
if isnull(ast_tab_armo_prezzi.x_utente  ) then ast_tab_armo_prezzi.x_utente = ""

end subroutine

public function long get_ultimo_id () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: 
//=== Output: 
//=== Ritorna ultimo ID_ARMO_PREZZO
//===           		  
//====================================================================
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT max(armo_prezzi.id_armo_prezzo)
	  into	:kst_tab_armo_prezzi.id_armo_prezzo
   	 FROM armo_prezzi
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Riga Prezzo Lotto (cercato MAX ID in armo_prezzi) ~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		else
			kst_tab_armo_prezzi.id_armo_prezzo = 0
		end if
	end if

if isnull(kst_tab_armo_prezzi.id_armo_prezzo) then
	kst_tab_armo_prezzi.id_armo_prezzo = 0
end if
		
return kst_tab_armo_prezzi.id_armo_prezzo


end function

public function boolean if_esiste_x_id_armo (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------
//--- Controlla se Riga Lotto con i PREZZI
//--- 
//--- Input: st_tab_armo_prezzi.id_armo
//--- Output: 
//--- Ritorna: TRUE = Lotto prezzato; FALSE=mancano i PREZZI
//---           		  
//------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
int k_trovato=0
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	 SELECT count (id_armo)
		  into
	  			:k_trovato
   	 FROM armo_prezzi
			 where id_armo = :ast_tab_armo_prezzi.id_armo
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Riga Prezzo Lotto (cercata Presenza armo_prezzi), id Riga Lotto: " + string(ast_tab_armo_prezzi.id_armo) + " ~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if

if k_trovato > 0 then
	k_return = true
end if
		
return k_return


end function

public function boolean esegui_evento_carico (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna tabella Prezzi-Righe  
//--- Evento di Carico Lotto, quindi merce appena arrivata. Ovvero rileva i colli da Fatturare x i Prezzi con questo tipo di evento
//--- 
//--- Input: st_tab_armo_prezzi.id_armo
//--- Output: 
//--- Ritorna: TRUE = OK; FALSE=Nessun evento trovato
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga, k_righe
st_esito kst_esito
st_tab_armo kst_tab_armo
datastore kds_armo_prezzi_x_tipo_calcolo
kuf_listino_voci kuf1_listino_voci
kuf_armo kuf1_armo

 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- get del numero colli entrati
	kuf1_armo = create kuf_armo
	kst_tab_armo.id_armo = ast_tab_armo_prezzi.id_armo
	kst_esito = kuf1_armo.get_colli_entrati_riga(kst_tab_armo)
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd and  kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kds_armo_prezzi_x_tipo_calcolo= create datastore
	kds_armo_prezzi_x_tipo_calcolo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	kds_armo_prezzi_x_tipo_calcolo.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_armo_prezzi_x_tipo_calcolo.retrieve(ast_tab_armo_prezzi.id_armo, kuf1_listino_voci.kki_tipo_calcolo_in_entrata)
	
//--- aggiorna le righe dei Prezzi con io Tipo-Calcolo in ENTRATA x metterele da FATTURARE
	for k_riga = 1 to k_righe 

//--- se lo stato è già Fatturato allora evito		
		if kds_armo_prezzi_x_tipo_calcolo.getitemstring(k_riga, "stato") = kki_stato_fatt then
		else
			kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "stato", kki_stato_dafatt )
			kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "item_dafatt", kst_tab_armo.colli_2 )
		end if		
	end for
	
//--- Se trovato qls AGGIORNA TAB
	if k_righe > 0 then
		
		esegui_evento_update(kds_armo_prezzi_x_tipo_calcolo, ast_tab_armo_prezzi.st_tab_g_0)  // AGGIORNA
		
		k_return = true
	end if

	
catch (uo_exception kuo_exception)	
		throw kuo_exception

end try

return k_return


end function

public function boolean esegui_evento_scarico (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna tabella Prezzi-Righe  
//--- Evento di Scarico Lotto (DDT), quindi merce spedita. Ovvero rileva i colli da Fatturare x i Prezzi con questo tipo di evento
//--- 
//--- Input: st_tab_armo_prezzi.id_armo / item_daFatt con i colli SCARICATI
//--- Output: 
//--- Ritorna: TRUE = OK; FALSE=Nessun evento trovato
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga, k_righe
st_esito kst_esito
st_tab_armo kst_tab_armo
datastore kds_armo_prezzi_x_tipo_calcolo
kuf_listino_voci kuf1_listino_voci

 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kds_armo_prezzi_x_tipo_calcolo= create datastore
	kds_armo_prezzi_x_tipo_calcolo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	kds_armo_prezzi_x_tipo_calcolo.settransobject( kguo_sqlca_db_magazzino )
	kds_armo_prezzi_x_tipo_calcolo.retrieve(ast_tab_armo_prezzi.id_armo, kuf1_listino_voci.kki_tipo_calcolo_in_uscita )
	
//--- aggiorna le righe dei Prezzi con io Tipo-Calcolo in ENTRATA x metterele da FATTURARE
	k_righe = kds_armo_prezzi_x_tipo_calcolo.rowcount()
	for k_riga = 1 to k_righe 
		
		kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "stato", kki_stato_dafatt )
		kst_tab_armo.colli_2 = kds_armo_prezzi_x_tipo_calcolo.getitemnumber(k_riga, "item_dafatt" )
		if kst_tab_armo.colli_2 > 0 then 
			ast_tab_armo_prezzi.item_daFatt += kst_tab_armo.colli_2
		end if
		if ast_tab_armo_prezzi.item_daFatt > 0 then
			kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "item_dafatt", ast_tab_armo_prezzi.item_daFatt )
		end if
		
	end for

//--- Se trovato qls AGGIORNA TAB
	if k_righe > 0 then
		
		esegui_evento_update(kds_armo_prezzi_x_tipo_calcolo, ast_tab_armo_prezzi.st_tab_g_0)  // AGGIORNA
		
		k_return = true
	end if
	
catch (uo_exception kuo_exception)	
		throw kuo_exception
	
end try
	
		
return k_return


end function

public function boolean tb_delete_x_id_armo (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella i rek dalla tabella armo_prezzi x l'intera Riga Lotto
//--- 
//--- Inp:  st_tab_armo_prezzi.id_armo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
long k_ctr=0
st_esito kst_esito
datastore ds_armo_prezzi_x_id_armo


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_armo_prezzi.id_armo = 0 or isnull (ast_tab_armo_prezzi.id_armo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Rimozione dei Prezzi Riga Lotto non effettuata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if_sicurezza(kkg_flag_modalita.cancellazione)

//--- AUTORIZZATO ? (SONO AUTORIZZATO PERCHE' ARRIVO DA RIMOZIONE RIGA LOTTO)  --------------------------------------------------------------------------------
//	if not this.if_sicurezza(kkg_flag_modalita.cancellazione) then
//		kst_esito.esito = kkg_esito.no_aut
//		kst_esito.SQLErrText = "Cancellazione 'Prezzi riga Lotto' non Autorizzata (id riga lotto=" + string(ast_tab_armo_prezzi.id_armo)+": ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	
//--- Ciclo x eliminare riga x riga
	ds_armo_prezzi_x_id_armo= create datastore
	ds_armo_prezzi_x_id_armo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	ds_armo_prezzi_x_id_armo.settransobject( kguo_sqlca_db_magazzino )
	ds_armo_prezzi_x_id_armo.retrieve(ast_tab_armo_prezzi.id_armo)
	
	for k_ctr = 1 to ds_armo_prezzi_x_id_armo.rowcount()
		
		ast_tab_armo_prezzi.id_armo_prezzo = ds_armo_prezzi_x_id_armo.getitemnumber(k_ctr, "id_armo_prezzo")
		if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
			tb_delete(ast_tab_armo_prezzi)
		end if
		
	end for
		
//---- COMMIT.... 
	if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
		
	k_return = true

catch (uo_exception kuo1_exception)
	if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function boolean tb_delete (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella armo_prezzi
//--- 
//--- Inp:  st_tab_armo_prezzi.id_armo_prezzo
//--- Ritorna:  TRUE=operazione effettuata; FALSE=operazione non eseguita
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------

boolean k_return = false
st_esito kst_esito
st_tab_arfa kst_tab_arfa
st_tab_armo_prezzi_v kst_tab_armo_prezzi_v
kuf_fatt kuf1_fatt
kuf_armo_prezzi_v kuf1_armo_prezzi_v


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	if  ast_tab_armo_prezzi.id_armo_prezzo = 0 or isnull (ast_tab_armo_prezzi.id_armo_prezzo) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Prezzo riga Lotto non cancellata. Manca ID"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
		
//--- AUTORIZZATO ? --------------------------------------------------------------------------------------------------------------------------------------------------------
	if_sicurezza(kkg_flag_modalita.cancellazione)

//--- Gia' Fatturato? ----------------------------------------------------------------------------------------------------------------------------------------------------
	kuf1_fatt = create kuf_fatt
	kst_tab_arfa.id_armo_prezzo = ast_tab_armo_prezzi.id_armo_prezzo
	if kuf1_fatt.if_esiste_id_armo_prezzo(kst_tab_arfa) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Prezzo riga Lotto gia' Fatturata, rimozione non consentita."
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- CANCELLA --------------------------------------------------------------------------------------------------------------------------------------------------------

	kuf1_armo_prezzi_v = create kuf_armo_prezzi_v
	kst_tab_armo_prezzi_v.id_armo_prezzo = ast_tab_armo_prezzi.id_armo_prezzo
	kuf1_armo_prezzi_v.tb_delete_x_id_armo_prezzo(kst_tab_armo_prezzi_v)

	
//--- 		
	delete from armo_prezzi
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cancellazione Prezzo riga Lotto' (armo_prezzi)  id=" + string(ast_tab_armo_prezzi.id_armo_prezzo) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
//--- lancio EXCEPTION			
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


return k_return

end function

public function boolean esegui_evento_scarico_ripristina (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Toglie i colli x l'evento di Scarico Lotto (DDT), quindi merce spedita. 
//---          Ovvero ripristina i colli da Fatturare precedenti a questo tipo di evento
//--- 
//--- Input: st_tab_armo_prezzi.id_armo / item_daFatt con i colli da RIPRISTINARE
//--- Output: 
//--- Ritorna: TRUE = OK; FALSE=Nessun evento trovato
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga, k_righe
st_esito kst_esito
st_tab_armo kst_tab_armo
datastore kds_armo_prezzi_x_tipo_calcolo
kuf_listino_voci kuf1_listino_voci

 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kds_armo_prezzi_x_tipo_calcolo= create datastore
	kds_armo_prezzi_x_tipo_calcolo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	kds_armo_prezzi_x_tipo_calcolo.settransobject( kguo_sqlca_db_magazzino )
	kds_armo_prezzi_x_tipo_calcolo.retrieve(ast_tab_armo_prezzi.id_armo, kuf1_listino_voci.kki_tipo_calcolo_in_uscita )
	
//--- aggiorna le righe dei Prezzi con il Tipo-Calcolo in ENTRATA x metterele da FATTURARE
	k_righe = kds_armo_prezzi_x_tipo_calcolo.rowcount()
	for k_riga = 1 to k_righe 
		
		if kds_armo_prezzi_x_tipo_calcolo.getitemstring(k_riga, "stato") = kki_stato_dafatt then
			kst_tab_armo.colli_2 = kds_armo_prezzi_x_tipo_calcolo.getitemnumber(k_riga, "item_dafatt" )
			if kst_tab_armo.colli_2 > 0 then 
				ast_tab_armo_prezzi.item_daFatt -= kst_tab_armo.colli_2
			end if

			if ast_tab_armo_prezzi.item_daFatt < 0 then ast_tab_armo_prezzi.item_daFatt = 0 // cavolo!!!

			kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "item_dafatt", ast_tab_armo_prezzi.item_daFatt )
			
			if ast_tab_armo_prezzi.item_daFatt = 0 then
				kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "stato", kki_stato_attesa )  // ripristino dello STATO
			end if
		end if
		
	end for

//--- Se trovato qls AGGIORNA TAB
	if k_righe > 0 then
		
		esegui_evento_update(kds_armo_prezzi_x_tipo_calcolo, ast_tab_armo_prezzi.st_tab_g_0)  // AGGIORNA
		
		k_return = true
	end if
	
catch (uo_exception kuo_exception)	
		throw kuo_exception
	
end try
	
		
return k_return


end function

public function st_esito get_stato (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge STATO
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo
//--- out: st_tab_armo_prezzi.stato
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito
//datastore kds_1


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
		select  a.stato
				into :ast_tab_armo_prezzi.stato
				from armo_prezzi a
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if isnull(ast_tab_armo_prezzi.stato) then ast_tab_armo_prezzi.stato = kki_stato_potenziale
		else
			kst_esito.esito = kkg_esito.not_fnd   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Prezzo riga lotto e quindi lo 'STATO' non trovato in tabella (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore durante lettura STATO in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante lettura STATO in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito


end function

public function st_esito get_all_id_listino_voce (ref st_tab_armo_prezzi ast_tab_armo_prezzi[]) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge tab armo_prezzi  per trovare tutti id_listino_voce con una determinato id_armo
//--- 
//--- Inp:  st_tab_armo_prezzi[1].id_armo_prezzo
//--- out: array st_tab_armo_prezzi[] con tutti i id_listino_voce
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

declare c_get_all_id_listino_voce cursor for
	select  a.id_listino_voce
				from armo_prezzi a
				where id_armo = :ast_tab_armo_prezzi[1].id_armo
				using kguo_sqlca_db_magazzino;


try
	
	if ast_tab_armo_prezzi[1].id_armo > 0 then
		open c_get_all_id_listino_voce;
		
		if  kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_ind = 0
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				k_ind ++
				fetch c_get_all_id_listino_voce  into :ast_tab_armo_prezzi[k_ind].id_listino_voce;
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					ast_tab_armo_prezzi[k_ind].id_armo_prezzo = ast_tab_armo_prezzi[1].id_armo
				else
					if kguo_sqlca_db_magazzino.sqlcode < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.sqlerrtext = "Errore durante lettura Prezzi riga Lotto (armo_prezzi). ID riga=" + string(ast_tab_armo_prezzi[1].id_armo)
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)				
						throw kguo_exception
					end if
				end if
	
			loop
			close c_get_all_id_listino_voce;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.sqlerrtext = "Errore preparazione lettura  Prezzi riga Lotto (armo_prezzi). ID riga=" + string(ast_tab_armo_prezzi[1].id_armo)
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

return kst_esito


end function

public function st_esito get_item (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge i vari 'item'
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo
//--- out: st_tab_armo_prezzi.item_dafatt, item_fatt, item_nofatt
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
		select  a.item_dafatt, a.item_fatt, a.item_nofatt
				into :ast_tab_armo_prezzi.item_dafatt
					,:ast_tab_armo_prezzi.item_fatt
					,:ast_tab_armo_prezzi.item_nofatt
				from armo_prezzi a
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if isnull(ast_tab_armo_prezzi.item_dafatt) then ast_tab_armo_prezzi.item_dafatt = 0
			if isnull(ast_tab_armo_prezzi.item_fatt) then ast_tab_armo_prezzi.item_fatt = 0
			if isnull(ast_tab_armo_prezzi.item_nofatt) then ast_tab_armo_prezzi.item_nofatt = 0
		else
			kst_esito.esito = kkg_esito.not_fnd   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Prezzo riga lotto e quindi gli 'Item' non trovato in tabella (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore durante lettura Item in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante lettura item_dafatt in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito




end function

public function st_esito set_stato (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update dello STATO
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo,  STATO
//--- out: 
//--- Rit.: st_esito        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then

		ast_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_armo_prezzi.x_utente =  kGuf_data_base.prendi_x_utente()
		
		update armo_prezzi
			  set stato = :ast_tab_armo_prezzi.stato
			  ,x_utente = :ast_tab_armo_prezzi.x_utente
			  ,x_datins = :ast_tab_armo_prezzi.x_datins
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
//---- COMMIT.... 
			if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		else
			kst_esito.esito = kkg_esito.db_wrn   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Valore STATO della tab. Prezzo riga lotto non aggiornato (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore in aggiornamento dello STATO in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)

				if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante aggiornamento STATO in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito


end function

public function st_esito set_item (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update degli ITEM (qtà)
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo,  item_fatt, item_dafatt, item_no_fatt
//--- out: 
//--- Rit.: st_esito        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then

		ast_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_armo_prezzi.x_utente =  kGuf_data_base.prendi_x_utente()
		
		update armo_prezzi
			  set item_fatt = :ast_tab_armo_prezzi.item_fatt
			  		,item_dafatt =  :ast_tab_armo_prezzi.item_dafatt
					,item_nofatt =  :ast_tab_armo_prezzi.item_nofatt
					  ,x_utente = :ast_tab_armo_prezzi.x_utente
					  ,x_datins = :ast_tab_armo_prezzi.x_datins
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
//---- COMMIT.... 
			if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		else
			kst_esito.esito = kkg_esito.db_wrn   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Valore degli ITEM della tab. Prezzo riga lotto non aggiornato (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore durante aggiornamento degli ITEM in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)

				if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante aggiornamento ITEM in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito


end function

public subroutine esegui_evento_update (ref datastore ads_armo_prezzi_x_tipo_calcolo, st_tab_g_0 ast_tab_g_0) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna tabella Prezzi-Righe  con il datastore creato nei metodo esegui_evento_....
//--- 
//--- 
//--- Input: datastore ads_armo_prezzi_x_tipo_calcolo  /   st_tab_g_0.esegui_commit 
//--- Output: 
//--- Ritorna:
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
int k_rc=0
st_esito kst_esito

 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	ads_armo_prezzi_x_tipo_calcolo.setitem(1, "x_datins",  kGuf_data_base.prendi_x_datins() )
	ads_armo_prezzi_x_tipo_calcolo.setitem(1, "x_utente",kGuf_data_base.prendi_x_utente() )

	k_rc = ads_armo_prezzi_x_tipo_calcolo.update()
	if k_rc < 0 then
		if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqldbcode
		kst_esito.SQLErrText = "Aggiornamento 'Riga Prezzo Lotto' in errore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext )
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if

	
catch (uo_exception kuo_exception)	
		throw kuo_exception
	
end try
	
	

end subroutine

public function boolean esegui_evento_mese_old (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna tabella Prezzi-Righe  
//--- Evento Mensile, quindi merce valta merce ancora in giacenza. Ovvero rileva i colli da Fatturare x i Prezzi con questo tipo di evento
//--- 
//--- Input: st_tab_armo_prezzi.id_armo
//--- Output: 
//--- Ritorna: TRUE = OK; FALSE=Nessun evento trovato
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga, k_righe
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp
datastore kds_armo_prezzi_x_tipo_calcolo
kuf_listino_voci kuf1_listino_voci
kuf_armo kuf1_armo
kuf_sped kuf1_sped
 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- get del numero colli spediti
	kuf1_armo = create kuf_armo
	kst_tab_armo.id_armo = ast_tab_armo_prezzi.id_armo
	kst_esito = kuf1_armo.get_colli_entrati_riga(kst_tab_armo)
	if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd and  kst_esito.esito <> kkg_esito.db_wrn then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//--- get del numero colli spediti
	kuf1_sped = create kuf_sped
	kst_tab_arsp.id_armo = ast_tab_armo_prezzi.id_armo
	kst_tab_arsp.data_bolla_out = date(kguo_g.get_anno(), kguo_g.get_mese(), 1) // CALCOLA IL PRIMO DEL MESE IN CORSO
	kst_tab_arsp.colli = kuf1_sped.get_colli_x_id_armo_data(kst_tab_arsp)

//--- Ricavo i colli in giacenza	
	kst_tab_armo.colli_2 = kst_tab_armo.colli_2 - kst_tab_arsp.colli

	kds_armo_prezzi_x_tipo_calcolo= create datastore
	kds_armo_prezzi_x_tipo_calcolo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	kds_armo_prezzi_x_tipo_calcolo.settransobject( kguo_sqlca_db_magazzino )
	kds_armo_prezzi_x_tipo_calcolo.retrieve(ast_tab_armo_prezzi.id_armo, kuf1_listino_voci.kki_tipo_calcolo_xmese )
	
//--- aggiorna le righe dei Prezzi con io Tipo-Calcolo in ENTRATA x metterele da FATTURARE
	k_righe = kds_armo_prezzi_x_tipo_calcolo.rowcount()
	for k_riga = 1 to k_righe 
		
		kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "stato", kki_stato_dafatt )
		kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga, "item_dafatt", kst_tab_armo.colli_2)
		
	end for
	
//--- Se trovato qls AGGIORNA TAB
	if k_righe > 0 then
		
		esegui_evento_update(kds_armo_prezzi_x_tipo_calcolo, ast_tab_armo_prezzi.st_tab_g_0)  // AGGIORNA
		
		k_return = true
	end if

catch (uo_exception kuo_exception)	
		throw kuo_exception
	
end try
	
return k_return


end function

public function integer esegui_evento_mese (st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Aggiorna tabella Prezzi-Righe  
//--- Evento Mensile, valutazione merce ancora in giacenza. Ovvero rileva i colli da Fatturare x i Prezzi con questo tipo di evento
//--- 
//--- Input: st_tab_armo_prezzi.id_armo  (se zero elabora TUTTO)
//--- Output: 
//--- Ritorna: numero delle righe aggiornate
//---           		  
//------------------------------------------------------------------------------------------------------------------------------------------------------------------
int k_return = 0
int k_colli_in_giacenza=0, k_aggiornati=0, k_colli_entrati, k_colli_sped, k_mese, k_anno,k_mese_attuale
long k_riga, k_righe, k_riga_prezzi, k_righe_prezzi
date k_data_limite_meca, k_data_limite_ddt
st_esito kst_esito
kuf_listino_voci kuf1_listino_voci
datastore kds_armo_prezzi_evento_mese, kds_armo_prezzi_evento_mese_sped
datastore kds_armo_prezzi_x_tipo_calcolo

 
 try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_listino_voci = create kuf_listino_voci

//--- fissa la data mensile 
	k_anno =  kguo_g.get_anno( )
	k_mese_attuale =  kguo_g.get_mese( )
	if k_mese_attuale > 1 then
		k_mese = k_mese_attuale - 1
	else
		k_anno = k_anno - 1
		k_mese = 12
	end if
	k_data_limite_ddt = date(k_anno, k_mese , 01 )
	k_data_limite_meca = k_data_limite_ddt

//--- Retrive dei Lotti in giacenza da Prezzare
	kds_armo_prezzi_evento_mese= create datastore
	kds_armo_prezzi_evento_mese.dataobject = "ds_armo_prezzi_evento_mese"
	kds_armo_prezzi_evento_mese.settransobject( kguo_sqlca_db_magazzino )
	kds_armo_prezzi_evento_mese.retrieve(ast_tab_armo_prezzi.id_armo, k_data_limite_meca, k_mese )

//--- Retrive dei Lotti in giacenza da Prezzare
	kds_armo_prezzi_evento_mese_sped= create datastore
	kds_armo_prezzi_evento_mese_sped.dataobject = "ds_armo_prezzi_evento_mese_sped"
	kds_armo_prezzi_evento_mese_sped.settransobject( kguo_sqlca_db_magazzino )
	
//--- datastore x salvare i dati dei Prezzi	
	kds_armo_prezzi_x_tipo_calcolo = create datastore
	kds_armo_prezzi_x_tipo_calcolo.dataobject = "ds_armo_prezzi_x_tipo_calcolo"
	kds_armo_prezzi_x_tipo_calcolo.settransobject( kguo_sqlca_db_magazzino )
	
//--- aggiorna le righe dei Prezzi con: Tipo-Calcolo MENSILE + colli da FATTURARE
	k_righe = kds_armo_prezzi_evento_mese.rowcount()
	for k_riga = 1 to k_righe 
		ast_tab_armo_prezzi.id_armo = kds_armo_prezzi_evento_mese.getitemnumber(k_riga,"id_armo")
		
		k_colli_entrati = kds_armo_prezzi_evento_mese.getitemnumber(k_riga,"colli_entrati")
		
		if kds_armo_prezzi_evento_mese_sped.retrieve(ast_tab_armo_prezzi.id_armo, k_data_limite_ddt ) > 0 then
			k_colli_sped = kds_armo_prezzi_evento_mese_sped.getitemnumber(1,"colli_spediti")
			if isnull(k_colli_sped) then k_colli_sped = 0
		else
			k_colli_sped = 0
		end if
		
		k_righe_prezzi = kds_armo_prezzi_x_tipo_calcolo.retrieve(ast_tab_armo_prezzi.id_armo, kuf1_listino_voci.kki_tipo_calcolo_xmese, k_mese ) 
		if k_righe_prezzi > 0 then
//--- aggiorna singole righe 
			for k_riga_prezzi = 1 to k_righe_prezzi 
				k_colli_in_giacenza = k_colli_entrati - k_colli_sped
				if k_colli_in_giacenza > 0 then
					k_aggiornati ++
					kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga_prezzi, "nrmese", k_mese_attuale )
					kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga_prezzi, "stato", kki_stato_dafatt )
					kds_armo_prezzi_x_tipo_calcolo.setitem(k_riga_prezzi, "item_dafatt", k_colli_in_giacenza)
				end if
			end for
//--- AGGIORNAMENTO			
			ast_tab_armo_prezzi.st_tab_g_0.esegui_commit = "S"
			esegui_evento_update(kds_armo_prezzi_x_tipo_calcolo, ast_tab_armo_prezzi.st_tab_g_0)  // AGGIORNA
		end if
	end for
	
//--- Se trovato qls AGGIORNA TAB
	if k_aggiornati > 0 then
		k_return = k_aggiornati
	end if

catch (uo_exception kuo_exception)	
	throw kuo_exception
	
end try
	
return k_return


end function

public function st_esito get_prezzo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Legge il prezzo unitario
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo
//--- out: st_tab_armo_prezzi.item_dafatt, item_fatt, item_nofatt
//---         
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
		select  a.prezzo
				into :ast_tab_armo_prezzi.prezzo
				from armo_prezzi a
				where id_armo_prezzo = :ast_tab_armo_prezzi.id_armo_prezzo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if isnull(ast_tab_armo_prezzi.prezzo) then ast_tab_armo_prezzi.prezzo = 0.00
		else
			kst_esito.esito = kkg_esito.not_fnd   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Prezzo della voce riga lotto non trovato in tabella (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore durante lettura Prezzo in tab voce prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Erroredurante lettura Prezzo in tab voce prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito




end function

public function boolean set_fatturato (readonly st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Elabora la riga fatturata ovvero imposta eventuale STATO e numero colli 
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo,  id_armo, item_fatt
//--- out: 
//--- Rit.: true=tutto ok        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
		
		kst_tab_armo_prezzi = ast_tab_armo_prezzi
		
//--- legge ITEM (qta') attuali
		get_item(kst_tab_armo_prezzi)
		
		kst_tab_armo_prezzi.item_fatt = ast_tab_armo_prezzi.item_fatt

//--- se qta fatturate copre qta da fatturare allora posso cambiare anche lo stato
		if ast_tab_armo_prezzi.item_fatt >= kst_tab_armo_prezzi.item_dafatt then
			kst_tab_armo_prezzi.item_dafatt = 0
			kst_tab_armo_prezzi.stato = kki_stato_fatt
		else
			kst_tab_armo_prezzi.item_dafatt -= ast_tab_armo_prezzi.item_fatt
		end if
		
//--- cambia lo stato
		set_stato(kst_tab_armo_prezzi)
//--- reimposta le qta
		set_item(kst_tab_armo_prezzi)

//---- COMMIT.... 
		if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
		k_return = true	
			
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante impostazione q.tà fatturate su Prezzo riga lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if
	
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante impostazione q.tà fatturate su Prezzo riga lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo) +  "~n~r" + kst_esito.sqlerrtext
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode

	if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	
	kuo1_exception.set_esito(kst_esito)				
	throw kuo1_exception


end try	

return k_return


end function

public function boolean set_fatturato_ripri (readonly st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Ripristino la riga fatturata ovvero ripristina STATO numero colli 
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo_prezzo,  item_fatt
//--- out: 
//--- Rit.: true=tutto ok        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo_prezzo > 0 then
		
		kst_tab_armo_prezzi = ast_tab_armo_prezzi
		
//--- legge ITEM (qta') attuali
		get_item(kst_tab_armo_prezzi)
		
		kst_tab_armo_prezzi.item_fatt -= ast_tab_armo_prezzi.item_fatt
		kst_tab_armo_prezzi.item_dafatt += ast_tab_armo_prezzi.item_fatt
		kst_tab_armo_prezzi.stato = kki_stato_dafatt
		
//--- cambia lo stato
		set_stato(kst_tab_armo_prezzi)
//--- reimposta le qta
		set_item(kst_tab_armo_prezzi)

//---- COMMIT.... 
		if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
			
		k_return = true	
			
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante ripristino q.tà fatturate su Prezzo riga lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if
	
	
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante ripristino q.tà fatturate su Prezzo riga lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo_prezzo) + kst_esito.sqlerrtext
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode

	if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	
	kuo1_exception.set_esito(kst_esito)				
	throw kuo1_exception


end try	

return k_return


end function

public function st_esito anteprima_prezzi (ref datastore adw_anteprima, st_tab_armo_prezzi ast_tab_armo_prezzi);//
//=== 
//====================================================================
//=== Operazione di Anteprima x id_armo
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
	
		if ast_tab_armo_prezzi.id_armo > 0 then
	
			adw_anteprima.dataobject = "d_armo_prezzi_l"		
			adw_anteprima.settransobject(sqlca)
	
			adw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=adw_anteprima.retrieve(ast_tab_armo_prezzi.id_armo, ast_tab_armo_prezzi.stato)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Prezzo da visualizzare nessun codice riga Lotto indicato"
			kst_esito.esito = kkg_esito.no_esecuzione
			
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
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function long tb_add_noaut (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella ARMO_PREZZO (riga prezzo del Lotto entrato)
//=== 
//=== Inp: st_tab_armo_prezzi - valorizzata
//=== Ritorna: numero righe aggiornate; 
//=== Lancia EXCEPTION//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//===  
//====================================================================
//
long k_return = 0

//--- INSERT SU TABELLA
	k_return = tb_add_0( ads_armo_prezzi, ast_tab_g_0)

return k_return

end function

private function long tb_add_0 (datastore ads_armo_prezzi, st_tab_g_0 ast_tab_g_0) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella ARMO_PREZZO (riga prezzo del Lotto entrato)
//=== 
//=== Inp: st_tab_armo_prezzi - valorizzata
//=== Ritorna: numero righe aggiornate; 
//=== Lancia EXCEPTION//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//===  
//====================================================================
//
long k_return = 0, k_rc, k_riga=0
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
	if ads_armo_prezzi.rowcount() > 0 then
	
//--- imposto dati utente e data aggiornamento
		kst_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_armo_prezzi.x_utente = kGuf_data_base.prendi_x_utente()
		kst_tab_armo_prezzi.x_carico_dt = kGuf_data_base.prendi_x_datins()
		kst_tab_armo_prezzi.x_carico_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
		if_isnull(kst_tab_armo_prezzi)
	
		for k_riga = 1 to ads_armo_prezzi.rowcount() 
			ads_armo_prezzi.setitem(k_riga, "id_armo_prezzo", 0 )
	//		ads_armo_prezzi.setitem(k_riga, "id_armo", kst_tab_armo_prezzi.id_armo )
	//		ads_armo_prezzi.setitem(k_riga, "id_listino_link_pregruppo", kst_tab_armo_prezzi.id_listino_link_pregruppo )
	//		ads_armo_prezzi.setitem(k_riga, "id_listino_voce", kst_tab_armo_prezzi.id_listino_voce )
	//		ads_armo_prezzi.setitem(k_riga, "tipo_calcolo", kst_tab_armo_prezzi.tipo_calcolo)
	//		ads_armo_prezzi.setitem(k_riga, "tipo_listino", kst_tab_armo_prezzi.tipo_listino)
	//		ads_armo_prezzi.setitem(k_riga, "stato", kst_tab_armo_prezzi.stato)
	//		ads_armo_prezzi.setitem(k_riga, "prezzo", kst_tab_armo_prezzi.prezzo)
	//		ads_armo_prezzi.setitem(k_riga, "item_daFatt", kst_tab_armo_prezzi.item_daFatt)
			ads_armo_prezzi.setitem(k_riga, "item_fatt", kst_tab_armo_prezzi.item_fatt)
			ads_armo_prezzi.setitem(k_riga, "item_nofatt", kst_tab_armo_prezzi.item_nofatt)
			ads_armo_prezzi.setitem(k_riga, "x_carico_dt", kst_tab_armo_prezzi.x_carico_dt )
			ads_armo_prezzi.setitem(k_riga, "x_carico_utente", kst_tab_armo_prezzi.x_carico_utente )
			ads_armo_prezzi.setitem(k_riga, "x_datins", kst_tab_armo_prezzi.x_datins )
			ads_armo_prezzi.setitem(k_riga, "x_utente", kst_tab_armo_prezzi.x_utente )
		end for
	
		k_rc = ads_armo_prezzi.update()
		if k_rc = 1 then
			k_return = k_riga
			if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
	
//--- piglia il numero di aggiornameno
//			ads_armo_prezzi.setitem(k_riga, "id_armo_prezzo", get_ultimo_id( ) )

		else
			if ast_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqldbcode
			kst_esito.SQLErrText = "Inserimento 'Riga Prezzo Lotto' in errore (" + trim(kst_esito.nome_oggetto) + ") "
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if

	


return k_return

end function

public function st_esito set_stato_x_id_armo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update dello STATO x  id_armo
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo,  STATO
//--- out: 
//--- Rit.: st_esito        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- AUTORIZZATO ?
	if_sicurezza(kkg_flag_modalita.modifica)
	
	if ast_tab_armo_prezzi.id_armo > 0 then

		ast_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_armo_prezzi.x_utente =  kGuf_data_base.prendi_x_utente()
		
		update armo_prezzi
			  set stato = :ast_tab_armo_prezzi.stato
			  ,x_utente = :ast_tab_armo_prezzi.x_utente
			  ,x_datins = :ast_tab_armo_prezzi.x_datins
				where id_armo = :ast_tab_armo_prezzi.id_armo
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
//---- COMMIT.... 
			if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		else
			kst_esito.esito = kkg_esito.db_wrn   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in agg. valore STATO in tab. Prezzi riga lotto (aggiornam. su armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore in aggiornam. STATO in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)

				if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante aggiornamento STATO in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito


end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
//--- questa Sicurezza la lego al LISTINI o LOTTO o CONTRATTI
//
boolean k_return = true
st_esito kst_esito
kuf_armo kuf1_armo
kuf_contratti kuf1_contratti
kuf_listino kuf1_listino


try 

//---- tenta di validare con 'inserimento' lotto	
	kuf1_armo = create kuf_armo
	k_return = kuf1_armo.if_sicurezza(kkg_flag_modalita.inserimento)
	
catch (uo_exception kuo_exception)

	try 
//---- tenta di validare con 'inserimento' contratto	
		kuf1_contratti = create kuf_contratti
		k_return = kuf1_contratti.if_sicurezza(kkg_flag_modalita.inserimento)

	catch (uo_exception kuo1_exception)
		
		try 
	//---- tenta di validare con 'inserimento' listini	
			kuf1_listino = create kuf_listino
			k_return = kuf1_listino.if_sicurezza(kkg_flag_modalita.inserimento)
	
		catch (uo_exception kuo2_exception)
			
//--- compone il msg di errore
			kst_esito.SQLErrText =  "Utente non Autorizzato.  " + "La funzione di gestione 'Voci di costio per riga Lotto' non e' stata abilitata ~n~r(id=" + trim(get_id_programma(kkg_flag_modalita.visualizzazione)) &
											 + "; Per operare di deve Abilitare la Funzione di Inserimento Lotto o Conferma Ordine o Listino." + "'; Utente: " + kguo_utente.get_codice( ) + "). "
			kst_esito.esito = kkg_esito.no_aut
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception	

		finally
			if isvalid(kuf1_listino) then destroy kuf1_listino
			
		end try

	finally
		if isvalid(kuf1_contratti) then destroy kuf1_contratti
		
	end try

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try

return k_return
end function

public function st_esito reset_dafatt_x_id_armo_no_ifsicurezza (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update dello STATO da Fattturare a POTENZIALI x  id_armo
//--- lo stato diventa Potenziale solo se era a DaFatt
//---
//--- Inp: st_tab_armo_prezzi.id_armo
//--- out: 
//--- Rit.: st_esito        
//---   
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
string k_stato_potenziale
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo > 0 then

		ast_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_armo_prezzi.x_utente =  kGuf_data_base.prendi_x_utente()
		
		k_stato_potenziale = kki_stato_potenziale
		ast_tab_armo_prezzi.stato = kki_stato_dafatt
		update armo_prezzi
			  set stato = :k_stato_potenziale
			  ,x_utente = :ast_tab_armo_prezzi.x_utente
			  ,x_datins = :ast_tab_armo_prezzi.x_datins
				where id_armo = :ast_tab_armo_prezzi.id_armo
				       and stato = :ast_tab_armo_prezzi.stato
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
//---- COMMIT.... 
			if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		else
			kst_esito.esito = kkg_esito.db_wrn   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in variazione stato da Fatturare in tab. Prezzi riga lotto (aggiornam. su armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore in variazione stato da Fatturare in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)

				if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante aggiornamento STATO in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	

return kst_esito


end function

public subroutine set_dafatt_x_id_armo_no_ifsicurezza (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update dello STATO da Fattturare x  id_armo
//--- lo stato diventa da Fatturare solo se ci sono ITEM_dafatt e Stato Potenziale 
//---
//--- Inp: st_tab_armo_prezzi.id_armo
//--- out: 
//--- Rit.: 
//---   Lancia uo_exception x errori
//--------------------------------------------------------------------------------------------------------------------------------------------------------
long k_ind=1
string k_stato_potenziale
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_armo_prezzi.id_armo > 0 then

		ast_tab_armo_prezzi.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_armo_prezzi.x_utente =  kGuf_data_base.prendi_x_utente()
		
		k_stato_potenziale = kki_stato_potenziale
		ast_tab_armo_prezzi.stato = kki_stato_dafatt
		update armo_prezzi
			  set stato = :ast_tab_armo_prezzi.stato
			  ,x_utente = :ast_tab_armo_prezzi.x_utente
			  ,x_datins = :ast_tab_armo_prezzi.x_datins
				where id_armo = :ast_tab_armo_prezzi.id_armo
				       and item_dafatt > 0 and stato = :k_stato_potenziale
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
//---- COMMIT.... 
			if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
			
		else
			kst_esito.esito = kkg_esito.db_wrn   // forse
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore in variazione stato da Fatturare in tab. Prezzi riga lotto (aggiornam. su armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlerrtext = "Errore in variazione stato da Fatturare in tab Prezzi riga Lotto (armo_prezzi). ID=" + string(ast_tab_armo_prezzi.id_armo)

				if ast_tab_armo_prezzi.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_armo_prezzi.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)				
				throw kguo_exception
			end if
		end if
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Errore durante aggiornamento STATO in tab Prezzi riga Lotto (armo_prezzi). Manca ID ! " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)				
		throw kguo_exception
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

end try	


end subroutine

public subroutine set_dafatt_x_id_armo (ref st_tab_armo_prezzi ast_tab_armo_prezzi) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Update dello STATO x  id_armo 'DA FATTURARE"
//--- 
//--- Inp: st_tab_armo_prezzi.id_armo
//--- out: 
//--- Rit.:        
//---   Lancia uo_exception x errori
//--------------------------------------------------------------------------------------------------------------------------------------------------------
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- AUTORIZZATO ?
	if_sicurezza(kkg_flag_modalita.modifica)


		set_dafatt_x_id_armo_no_ifsicurezza(ast_tab_armo_prezzi)
		
catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
	

end try	


end subroutine

on kuf_armo_prezzi.create
call super::create
end on

on kuf_armo_prezzi.destroy
call super::destroy
end on

