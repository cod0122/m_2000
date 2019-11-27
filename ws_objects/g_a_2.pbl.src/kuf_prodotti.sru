$PBExportHeader$kuf_prodotti.sru
forward
global type kuf_prodotti from kuf_parent
end type
end forward

global type kuf_prodotti from kuf_parent
end type
global kuf_prodotti kuf_prodotti

type variables
//
public string kki_ATTIVO_no = "N"
public string kki_ATTIVO_si = "S"


end variables

forward prototypes
public function string tb_delete (string k_codice)
public function st_esito select_riga (ref st_tab_prodotti k_st_tab_prodotti)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_prodotti kst_tab_prodotti)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_prodotti kst_tab_prodotti)
public function st_esito get_gruppo (ref st_tab_prodotti k_st_tab_prodotti)
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function st_esito anteprima_l (ref datastore kdw_anteprima, st_tab_prodotti kst_tab_prodotti)
public function integer get_iva (st_tab_prodotti ast_tab_prodotti) throws uo_exception
public function integer get_magazzino (st_tab_prodotti ast_tab_prodotti) throws uo_exception
public function string get_des (ref st_tab_prodotti ast_tab_prodotti) throws uo_exception
end prototypes

public function string tb_delete (string k_codice);//
//====================================================================
//=== Cancella il rek dalla tabella Clienti e Clienti_sped
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
long k_num, k_id
date k_data
datetime k_dt_entrata




//=== Controllo se nelle ENTRATE ci sono rec
DECLARE entrate CURSOR FOR  
	  SELECT meca.num_int,
            meca.data_int,
            meca.data_ent
   	 FROM armo inner join meca on armo.id_meca = meca.id
	   WHERE art = :k_codice 
		using kguo_sqlca_db_magazzino;
//	union all
//	  SELECT num_int,
//  	         data_int
//   	 FROM o_armo
//	   WHERE art = :k_codice ;

//=== Controllo se in LISTINO ci sono rec
DECLARE listino CURSOR FOR  
	  SELECT cod_cli
	         ,id
   	 FROM listino
	   WHERE cod_art = :k_codice 
		using kguo_sqlca_db_magazzino;
 	   
 	   
open entrate;

if kguo_sqlca_db_magazzino.sqlCode = 0 then

	fetch entrate INTO :k_num, :k_data, :k_dt_entrata ;

	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		k_return = "2" + "Articolo già entrato a magazzino, come nel Lotto n.:  ~n~r" + &
		   string(k_num) + " del " + &
		 	string(k_data, "dd mmm yyyy") + " entrato il " + &
		 	string(k_dt_entrata, "dd mmm yyyy  hh:mm") + "~n~r" 	
	end if
	close entrate;
end if

if LeftA(k_return, 1) = "0" then
	open listino ;
	if kguo_sqlca_db_magazzino.sqlCode = 0 then

		fetch listino INTO 	:k_num
		                     ,:k_id;

		if kguo_sqlca_db_magazzino.sqlCode = 0 then
			k_return = "2" + "Articolo caricato in Listino, come per il Cliente:  ~n~r" &
			   + string(k_num) + " del Listino: " + string(k_id) &
		 		+ "~n~r" 	

		end if
		close listino;
	end if
end if

	
if LeftA(k_return, 1) = "0" then
	
	delete from prodotti
			where codice = :k_codice ;

	if kguo_sqlca_db_magazzino.sqlCode <> 0 then

		k_return = "1" + kguo_sqlca_db_magazzino.SQLErrText
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if
end if


return k_return
end function

public function st_esito select_riga (ref st_tab_prodotti k_st_tab_prodotti);//
//--- Leggo Prodotto specifico
//
string k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	k_codice = k_st_tab_prodotti.codice
	
	select des,
			des_mkt,
			 gruppo,
			 iva,
			 magazzino,
			 attivo
	 into :k_st_tab_prodotti.des,
			:k_st_tab_prodotti.des_mkt,
			:k_st_tab_prodotti.gruppo,
			:k_st_tab_prodotti.iva,
			:k_st_tab_prodotti.magazzino,
			:k_st_tab_prodotti.attivo
		from prodotti
		where codice = :k_codice
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura tab. Articoli: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = KKg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = KKg_esito.db_wrn
			else
				kst_esito.esito = KKg_esito.db_ko
			end if
		end if
	end if
	
return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_prodotti kst_tab_prodotti);//
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_prodotti.codice)) > 0 then

		kdw_anteprima.dataobject = "d_prod_1"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_prodotti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Articolo da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_prodotti kst_tab_prodotti);//
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_prodotti.codice)) > 0 then

		kdw_anteprima.dataobject = "d_prod_1"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_prodotti.codice)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Articolo da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito get_gruppo (ref st_tab_prodotti k_st_tab_prodotti);//
//--- Leggo Gruppo dal Prodotto specifico
//
string k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	k_codice = k_st_tab_prodotti.codice
	
	select gruppo 
	 into 
			:k_st_tab_prodotti.gruppo
		from prodotti
		where codice = :k_codice 
		using kguo_sqlca_db_magazzino;
	
//and attivo <> :kki_ATTIVO_no 

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura tab. Articoli (il gruppo) codice " + trim(k_codice) + "  ~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
	
return kst_esito

end function

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
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


st_tab_prodotti kst_tab_prodotti
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "art", "cod_art"
		kst_tab_prodotti.codice = adw_1.getitemstring(adw_1.getrow(), a_campo_link)
		if len(trim(kst_tab_prodotti.codice)) > 0 then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_prodotti )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "codice Articolo: " + trim(kst_tab_prodotti.codice)
		else
			k_return = false
		end if


	case "b_cod_art_l"
		kst_esito = this.anteprima_l ( kdsi_elenco_output, kst_tab_prodotti )
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
		kst_open_w.key1 = "Elenco Articoli "

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

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito anteprima_l (ref datastore kdw_anteprima, st_tab_prodotti kst_tab_prodotti);//
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	kdw_anteprima.dataobject = "d_prod_l_attivi_x_gru"	
	kdw_anteprima.settransobject(sqlca)

	kdw_anteprima.reset()	
//--- retrive dell'attestato 
	k_rc=kdw_anteprima.retrieve(0)

end if


return kst_esito

end function

public function integer get_iva (st_tab_prodotti ast_tab_prodotti) throws uo_exception;//
//--- Leggo IVA dal Prodotto specifico
//
int k_return = 0
string k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	k_codice = ast_tab_prodotti.codice
	
	select iva 
	 into  
			:ast_tab_prodotti.iva
		from prodotti
		where codice = :k_codice 
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura cod IVA da tab. Articoli. Codice " + trim(k_codice) + "  ~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if ast_tab_prodotti.iva > 0 then
		k_return = ast_tab_prodotti.iva
	end if
	
	
return k_return 

end function

public function integer get_magazzino (st_tab_prodotti ast_tab_prodotti) throws uo_exception;//
//--- Leggo MAGAZZINO dal Prodotto specifico
//
int k_return = 0
string k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	k_codice = ast_tab_prodotti.codice
	
	select magazzino 
	 into  
			:ast_tab_prodotti.magazzino
		from prodotti
		where codice = :k_codice 
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura Tipo Magazzino da tab. Articoli. Codice " + trim(k_codice) + "  ~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if ast_tab_prodotti.magazzino > 0 then
		k_return = ast_tab_prodotti.magazzino
	end if
	
	
return k_return 

end function

public function string get_des (ref st_tab_prodotti ast_tab_prodotti) throws uo_exception;//
//--- Leggo Descrizioni dal Prodotto 
//
string k_codice
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_prodotti.codice > " " then
	
	k_codice = ast_tab_prodotti.codice
	ast_tab_prodotti.des = ""
	ast_tab_prodotti.des_mkt = ""
	
	select des  ,des_mkt 
	 into 
			:ast_tab_prodotti.des
			,:ast_tab_prodotti.des_mkt
		from prodotti
		where codice = :k_codice 
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura descrizione Articolo '" + trim(k_codice) + "': " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Lettura descrizione Articolo non effettuata, manca il codice. Anomalia interna di programmazione" 
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if isnull(ast_tab_prodotti.des) then ast_tab_prodotti.des = ""
if isnull(ast_tab_prodotti.des_mkt) then ast_tab_prodotti.des_mkt = ""
	
return ast_tab_prodotti.des

end function

on kuf_prodotti.create
call super::create
end on

on kuf_prodotti.destroy
call super::destroy
end on

