$PBExportHeader$kuf_memo_link.sru
forward
global type kuf_memo_link from kuf_parent
end type
end forward

global type kuf_memo_link from kuf_parent
end type
global kuf_memo_link kuf_memo_link

type variables
//
//--- tipo dati nel memo 
public constant string kki_tipo_memo_rtf = 'RTF'  //tipo dati RTF

private st_tab_memo_link kist_tab_memo_link
private w_memo kiw_memo

public constant string kki_memo_link_load_SI = "S"
public constant string kki_memo_link_load_NO = "N"

end variables

forward prototypes
public function long get_ult_id_memo_link () throws uo_exception
public function boolean if_esiste (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public subroutine if_isnull (ref st_tab_memo_link ast_tab_memo_link)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_memo_link ast_tab_memo_link)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function datetime get_x_datains (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function datetime get_dataora_ins (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function long aggiorna (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function boolean tb_delete (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function st_tab_memo_link get_st_tab_memo_link ()
public subroutine set_st_tab_memo_link (st_tab_memo_link kst_tab_memo_link)
public function string get_tipo_memo (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function string get_titolo (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function boolean u_attiva_funzione (st_tab_memo_link ast_tab_memo_link, string a_flag_metodo) throws uo_exception
private subroutine u_open_window (string a_flag_metodo)
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function boolean load_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function boolean tb_update_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function boolean tb_update (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
public subroutine open_file_app (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function string get_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function boolean tb_delete_x_id_memo (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function integer get_count_x_id_memo (readonly st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function long get_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function long get_memo_link_lenunzip (st_tab_memo_link ast_tab_memo_link) throws uo_exception
public function integer crea_memo_link (st_tab_memo_link ast_tab_memo_link[]) throws uo_exception
public function long tb_add (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception
end prototypes

public function long get_ult_id_memo_link () throws uo_exception;//
//====================================================================
//=== Torna l'ultimo ID_MEMO_LINK inserito
//=== 
//=== Input: 
//=== Output:                   
//=== Ritorna long contenente l'id_memo_link
//===           		  
//====================================================================
st_esito kst_esito
long	k_id_memo_link


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT max(id_memo_link)
INTO :k_id_memo_link
FROM memo_link
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura ultimo id caricato in tab. MEMO_LINK " + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if isnull(k_id_memo_link) then k_id_memo_link = 0

return k_id_memo_link



end function

public function boolean if_esiste (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//====================================================================
//=== Torna se c'è il record  
//=== 
//=== Input: st_tab_memo_link.id_memo
//=== Output:                   
//=== Ritorna true se trova almeno un id per id memo passato
//===           		  
//====================================================================

boolean	k_return = false
st_esito kst_esito
integer k_esiste

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 1
INTO :k_esiste
FROM memo_link
where id_memo = :ast_tab_memo_link.id_memo
using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore controllo esistenza Memo_link~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_esiste>0 then k_return = true

return k_return
end function

public subroutine if_isnull (ref st_tab_memo_link ast_tab_memo_link);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(ast_tab_memo_link.id_memo_link) then	ast_tab_memo_link.id_memo_link = 0
if isnull(ast_tab_memo_link.TIPO_MEMO_link) then ast_tab_memo_link.TIPO_MEMO_link = "PDF"
if isnull(ast_tab_memo_link.titolo) then ast_tab_memo_link.titolo = ""
if isnull(ast_tab_memo_link.link) then ast_tab_memo_link.link = ""
if isnull(ast_tab_memo_link.nome) then ast_tab_memo_link.nome = ""
if isnull(ast_tab_memo_link.id_memo) then ast_tab_memo_link.id_memo = 0
if isnull(ast_tab_memo_link.dataora_ins) then ast_tab_memo_link.dataora_ins = datetime(date(0))
if isnull(ast_tab_memo_link.utente_ins) then ast_tab_memo_link.utente_ins = ""
if isnull(ast_tab_memo_link.memo_link) then ast_tab_memo_link.memo_link = blob("")

if isnull(ast_tab_memo_link.x_datins) then	ast_tab_memo_link.x_datins = datetime(date(0))
if isnull(ast_tab_memo_link.x_utente) then	ast_tab_memo_link.x_utente = ""

if isnull(ast_tab_memo_link.memo_link_load) then ast_tab_memo_link.memo_link_load = kki_memo_link_load_NO



end subroutine

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_memo_link ast_tab_memo_link);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
long k_memo_len_link
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
//	
//	if not k_return then
//	
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//	
//	else
	
		if ast_tab_memo_link.id_memo_link > 0 then
		
//			kdw_anteprima.dataobject = "d_memo_rtf"		 
//			kdw_anteprima.settransobject(sqlca)
		
			k_memo_len_link = get_memo_link(ast_tab_memo_link)
			
			kdw_anteprima.reset()	
//			k_rc=kdw_anteprima.retrieve(ast_tab_memo_link.id_memo_link)
			if k_memo_len_link > 0 then
				open_file_app(ast_tab_memo_link)
//				kdw_anteprima.pasteRtf( k_memo_link ) // mette il testo RTF 
			end if
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Allegato (memo_link) da visualizzare: ~n~r" + "nessun codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
//	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try

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
boolean k_return=false
st_tab_memo_link kst_tab_memo_link
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 



SetPointer(kkg.pointer_attesa)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "p_memo_link", "id_memo_link"
		kst_tab_memo_link.id_memo_link = adw_link.getitemnumber(adw_link.getrow(), "id_memo_link")
		if kst_tab_memo_link.id_memo_link > 0 then
			k_return = true
			open_file_app(kst_tab_memo_link)
			
		end if

end choose


SetPointer(kkg.pointer_default)



return k_return

end function

public function datetime get_x_datains (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Torna X_DATINS 
//--- 
//--- Input: st_tab_memo_link.id_memo_link     
//--- Output:                   
//--- Ritorna il campo X_DATINS
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
datetime k_return = datetime(date(0))


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  x_datins
    INTO 
	 	  :ast_tab_memo_link.x_datins
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura x_datins dal documento (memo) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo_link.x_datins > datetime(date(0)) then
			k_return =  ast_tab_memo_link.x_datins
		end if
	end if
end if


return k_return



end function

public function datetime get_dataora_ins (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Torna dataora_ins 
//--- 
//--- Input: st_tab_memo_link.id_memo_link     
//--- Output:                   
//--- Ritorna il campo dataora_ins
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
datetime k_return = datetime(date(0))


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  dataora_ins
    INTO 
	 	  :ast_tab_memo_link.dataora_ins
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura data di inserimento dal documento (memo) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo_link.dataora_ins > datetime(date(0)) then
			k_return =  ast_tab_memo_link.dataora_ins
		end if
	end if
end if


return k_return



end function

public function long aggiorna (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//--------------------------------------------------------------------
//--- Aggiorna riga in tabella  MEMO_LINK 
//--- 
//--- Input: st_tab_memo_link.id_memo_link (che può essere zero se nuovo)
//--- Ritorna id_memo_link
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
long	k_return = 0

try
	if ast_tab_memo_link.id_memo_link > 0 then
		if if_esiste( ast_tab_memo_link) then
		else
			ast_tab_memo_link.id_memo_link = 0 
		end if
	end if
	if ast_tab_memo_link.id_memo_link	> 0 then
		tb_update(ast_tab_memo_link )
	else
		ast_tab_memo_link.id_memo_link = tb_add( ast_tab_memo_link)
	end if

	if ast_tab_memo_link.id_memo_link > 0 then
		k_return = ast_tab_memo_link.id_memo_link
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
end try


return k_return
end function

public function boolean tb_delete (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella MEMO_LINK
//--- 
//--- Input: st_tab_memo_link.id_memo_link
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_link.id_memo_link > 0 then
	
	delete 
			from memo_link
			WHERE id_memo_link = :ast_tab_memo_link.id_memo_link 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione NOTE  (id memo link " + string(ast_tab_memo_link.id_memo_link) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		
		if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function st_tab_memo_link get_st_tab_memo_link ();//
return kist_tab_memo_link
end function

public subroutine set_st_tab_memo_link (st_tab_memo_link kst_tab_memo_link);//
kist_tab_memo_link = kst_tab_memo_link

end subroutine

public function string get_tipo_memo (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Torna TIPO 
//--- 
//--- Input: st_tab_memo_link.id_memo_link     
//--- Output:                   
//--- Ritorna il campo TIPO_MEMO
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
string k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  TIPO_MEMO_LINK
    INTO 
	 	  :ast_tab_memo_link.TIPO_MEMO_LINK
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura TIPO dal documento (memo) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_memo_link.TIPO_MEMO_LINK) > " " then
			k_return =  (ast_tab_memo_link.TIPO_MEMO_LINK)
		end if
	end if
end if


return k_return



end function

public function string get_titolo (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Torna NOTE 
//--- 
//--- Input: st_tab_memo_link.id_memo_link     
//--- Output:                   
//--- Ritorna il campo TITOLO
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
string	 k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  titolo
    INTO 
	 	  :ast_tab_memo_link.titolo
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in MEMO_LINK per leggere il Titolo (memo_link) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if trim(ast_tab_memo_link.titolo) > " " then
			k_return =  trim(ast_tab_memo_link.titolo)
		end if
	end if
end if


return k_return



end function

public function boolean u_attiva_funzione (st_tab_memo_link ast_tab_memo_link, string a_flag_metodo) throws uo_exception;//
//--- Attiva la window x gestire i MEMO_LINK (link documenti) dati 
//--- Inp: 	st_tab_memo_link, metodo
//
boolean k_return = false
datastore kds_memo_link

	kist_tab_memo_link = ast_tab_memo_link
	if kist_tab_memo_link.id_memo_link > 0 then
		kds_memo_link = create datastore
		kds_memo_link.dataobject = "ds_memo_link"
		kds_memo_link.settransobject(kguo_sqlca_db_magazzino)
		if kds_memo_link.retrieve(kist_tab_memo_link.id_memo_link) > 0 then
			kist_tab_memo_link.dataora_ins = kds_memo_link.getitemdatetime( 1, "dataora_ins")
			kist_tab_memo_link.id_memo = kds_memo_link.getitemnumber( 1, "id_memo")
			kist_tab_memo_link.tipo_memo_link = kds_memo_link.getitemstring( 1, "tipo_memo_link")
			kist_tab_memo_link.titolo = kds_memo_link.getitemstring( 1, "titolo")
			kist_tab_memo_link.link = kds_memo_link.getitemstring( 1, "link")
			kist_tab_memo_link.utente_ins = kds_memo_link.getitemstring( 1, "utente_ins")
			kist_tab_memo_link.x_datins = kds_memo_link.getitemdatetime( 1, "x_datins")
			kist_tab_memo_link.x_utente = kds_memo_link.getitemstring( 1, "x_utente")
		end if
	end if

//---- se window non ancora aperta
	if not isvalid(kiw_memo) then
		u_open_window(a_flag_metodo)	
//	else
//		kiw_memo.u_inizializza()
	end if

	if isvalid(kiw_memo) then
		kiw_memo.WindowState = normal!
		kiw_memo.bringtotop = true
	end if


return k_return

end function

private subroutine u_open_window (string a_flag_metodo);//
st_open_w k_st_open_w

	
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = a_flag_metodo
		K_st_open_w.id_programma = this.get_id_programma(a_flag_metodo) //kkg_id_programma_anag_memo
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		k_st_open_w.key12_any = this
		K_st_open_w.flag_where = " "
		
		kguf_menu_window.open_w_tabelle(k_st_open_w)
		
	




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
//---							               	W=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
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
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 99

		if ads_inp.getitemstring ( k_riga, "titolo") > " " then  // presuppone un codice alfanumerico
		else
			k_errori ++
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("#1.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe(ads_inp.describe("#1.name") + "_t.text")) +  "~n~r"  
		end if

		if k_tipo_errore <> kkg_esito.ok  and k_tipo_errore <> kkg_esito.DB_WRN and k_tipo_errore <> kkg_esito.DATI_WRN then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function boolean load_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Carica un file documento nel campo BLOB memo_link
//---
//--- inp: st_tab_memo_link link=file da caricare completo di path
//--- out: st_tab_memo_link.memo_link 
//--- ret: true = OK caricato il documento
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
kuf_utility kuf1_utility


try

//	if ast_tab_memo_link.id_memo_link > 0 then
//	else
//		kguo_exception.inizializza( )
//		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti)
//		kguo_exception.setmessage("Id del LINK da importare non indicato")
//		throw kguo_exception
//	end if
	
	if ast_tab_memo_link.link > " " then
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti)
		kguo_exception.setmessage("Nome del file da importare non indicato")
		throw kguo_exception
	end if
	
	//--- importa FILE nel blob
	kuf1_utility = create kuf_utility
	ast_tab_memo_link.memo_link = kuf1_utility.u_filetoblob(ast_tab_memo_link.link)
	k_return = true
	
//	//--- aggiorna il blob
//	k_return = tb_update_memo_link(ast_tab_memo_link)
//
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try

return k_return

end function

public function boolean tb_update_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna nella tabella  MEMO_LINK  il campo  BLOB (memo_link)
//--- 
//--- Input: st_tab_memo_link.id_memo_link
//--- Ritorna TRUE = OK
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
boolean	k_return = false
boolean k_rc, k_senza_dati
long k_len
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_zlib kuf1_zlib
st_open_w kst_open_w
boolean k_autorizza

	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- controllo se nel MEMO_LINK ci sono dati
		k_len = len(ast_tab_memo_link.memo_link)
		if k_len > 5 then
			k_senza_dati = false
			kuf1_zlib = create kuf_zlib
			kuf1_zlib.of_compress2(ast_tab_memo_link.memo_link, ast_tab_memo_link.memo_link, kuf1_zlib.Z_BEST_COMPRESSION )
		else
			k_senza_dati = true
			ast_tab_memo_link.memo_link = blob(" ")
		end if

		UPDATEBLOB memo_link  
					SET 
						memo_link = :ast_tab_memo_link.memo_link
					WHERE id_memo_link = :ast_tab_memo_link.id_memo_link 
					using kguo_sqlca_db_magazzino;

		  
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			UPDATE memo_link  
					 SET
						  nome = :ast_tab_memo_link.nome,   
						  MEMO_link_load = :ast_tab_memo_link.MEMO_link_load,   
						  memo_link_lenunzip = :ast_tab_memo_link.memo_link_lenunzip   
				WHERE id_memo_link = :ast_tab_memo_link.id_memo_link
				USING kguo_sqlca_db_magazzino;
		end if		
			
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Importazione Allegato (UpdateBLOB)~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 
				if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = true
		end if

		if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return
end function

public function boolean tb_update (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiorna tabella  MEMO_LINK 
//--- 
//--- Input: st_tab_memo_link.id_memo_link
//--- Ritorna TRUE = OK
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
boolean		k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza

	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo_link.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo_link.x_utente = kGuf_data_base.prendi_x_utente()
		
	//--- toglie valori NULL
		if_isnull(ast_tab_memo_link)
		  
		UPDATE memo_link  
				 SET
					  titolo = :ast_tab_memo_link.titolo,  
					  TIPO_MEMO_link = :ast_tab_memo_link.TIPO_MEMO_link,   
					  link = :ast_tab_memo_link.link,   
					  x_datins = :ast_tab_memo_link.x_datins,   
					  x_utente = :ast_tab_memo_link.x_utente
		WHERE id_memo_link = :ast_tab_memo_link.id_memo_link
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			k_return = tb_update_memo_link(ast_tab_memo_link)  // aggiorna il BLOB con i dati (memo)
		end if
//	end if
		if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

public subroutine open_file_app (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--- lancia applicazione apposita per visualizzare l'allegato 
//--- input: st_tab_memo_link.id_memo_link 
//
string k_nome="",  k_file_temp
kuf_utility kuf1_utility


try
	
	if ast_tab_memo_link.id_memo_link = 0 then
		kguo_exception.inizializza()
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kguo_exception.setmessage("Manca il riferimento (id_memo_link) al file allegato da mostrare")
		throw kguo_exception
	end if				

	kuf1_utility = create kuf_utility

	get_link(ast_tab_memo_link)  // get del link al documento

	get_memo_link(ast_tab_memo_link)  // get il BLOB del documento
	if len(ast_tab_memo_link.memo_link) > 10 then 
//		st_tab_memo_link Xst_tab_memo_link
//			Xst_tab_memo_link.memo_link = kuf1_utility.u_filetoblob(ast_tab_memo_link.link)
//		if Xst_tab_memo_link.memo_link <> ast_tab_memo_link.memo_link then
//			ast_tab_memo_link.memo_link = Xst_tab_memo_link.memo_link
//		end if
	else
		if trim(ast_tab_memo_link.link) > " " then  // se non c'e' il BLOB piglia il doc dal link
			ast_tab_memo_link.memo_link = kuf1_utility.u_filetoblob(ast_tab_memo_link.link)
		else
			kguo_exception.inizializza()
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
			kguo_exception.setmessage("E' necessario indicare il nome completo dell'allegato da mostrare")
			throw kguo_exception
			
		end if
	end if
	if len(ast_tab_memo_link.memo_link) > 10 then 
	
		k_file_temp = kguo_path.get_temp()
		k_nome = kuf1_utility.u_get_nome_file(ast_tab_memo_link.link)
		if trim(k_nome) > " " then
			k_file_temp = k_file_temp + kkg.path_sep + k_nome
		else
			k_file_temp = k_file_temp + kkg.path_sep + "linkTemporaneo"
		end if
		
		kuf1_utility.u_blobtofile( ast_tab_memo_link.memo_link, k_file_temp) // copia il blob su file di appoggio x poi essere aperto
		
		kuf1_utility.u_open_app_file(k_file_temp)  // apre il file con l'applicazione di sistema
	end if
		
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try	

end subroutine

public function string get_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//====================================================================
//=== Torna LINK ovvero il PATH+Nome File
//=== 
//=== Input: st_tab_memo_link.id_memo_link     
//=== Out: st_tab_memo_link.link               
//=== Ritorna: string il riferimento (path+file) al documento originale 
//===           		  
//====================================================================
st_esito kst_esito
string	k_return = ""


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT
		link
    INTO 
	 	  :ast_tab_memo_link.link
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Allegati del link (link) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return =  trim(ast_tab_memo_link.link)
	end if
end if


return k_return



end function

public function boolean tb_delete_x_id_memo (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella tutti i rek nella tabella MEMO_LINK con il riferimento al ID_MEMO
//--- 
//--- Input: st_tab_memo_link.id_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if ast_tab_memo_link.id_memo > 0 then
	
	delete 
			from memo_link
			WHERE id_memo = :ast_tab_memo_link.id_memo
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione Allegati  (id memo " + string(ast_tab_memo_link.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		
		if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function integer get_count_x_id_memo (readonly st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//====================================================================
//=== Conta gli Allegati  x ID MEMO 
//=== 
//=== Input: st_tab_memo_link.id_memo     
//=== Out:           
//=== Ritorna: numero di allegati trovati
//===           		  
//====================================================================
integer k_return = 0
integer k_contati = 0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT
		count(id_memo_link)
    INTO 
	 	  :k_contati
        FROM memo_link
        WHERE ( id_memo = :ast_tab_memo_link.id_memo)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore nella conta degli Allegati (memo_link) id_memo=" +string(ast_tab_memo_link.id_memo) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if k_contati > 0 then
			k_return = k_contati
		end if
	end if
end if


return k_return



end function

public function long get_memo_link (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//====================================================================
//=== Torna ID MEMO 
//=== 
//=== Input: st_tab_memo_link.id_memo_link     
//=== Out: st_tab_memo_link.memo_link (blob del documento)                   
//=== Ritorna: string il documento nel formato originale (DOC, PDF, ODT, XLS,...)
//===           		  
//====================================================================
st_esito kst_esito
long k_return=0
kuf_zlib kuf1_zlib

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECTBLOB   
		  memo_link
    INTO 
	 	  :ast_tab_memo_link.memo_link
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura del documento allegato (memo_link) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
//--- decomprimo il file
		if ast_tab_memo_link.memo_link_lenunzip > 0 then
		else
			ast_tab_memo_link.memo_link_lenunzip = get_memo_link_lenunzip(ast_tab_memo_link)
		end if
		if ast_tab_memo_link.memo_link_lenunzip > 0 then
			kuf1_zlib = create kuf_zlib
			kuf1_zlib.of_uncompress(ast_tab_memo_link.memo_link, ast_tab_memo_link.memo_link_lenunzip, ast_tab_memo_link.memo_link)
		end if
		if len(ast_tab_memo_link.memo_link) > 5 then
			k_return = len(ast_tab_memo_link.memo_link)
		end if
	end if
end if


return k_return



end function

public function long get_memo_link_lenunzip (st_tab_memo_link ast_tab_memo_link) throws uo_exception;//---------------------------------------------------------------------
//--- Torna Lunghezza del file originale non compresso 
//--- 
//--- Input: st_tab_memo_link.id_memo_link     
//--- Output:                   
//--- Ritorna il campo MEMO_LINK_LENUNZIP
//---           		  
//---  x errore lancia EXCEPTION
//---------------------------------------------------------------------
st_esito kst_esito
long	 k_return = 0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT 
		  MEMO_LINK_LENUNZIP
    INTO 
	 	  :ast_tab_memo_link.MEMO_LINK_LENUNZIP
        FROM memo_link
        WHERE ( id_memo_link = :ast_tab_memo_link.id_memo_link)   
		using kguo_sqlca_db_magazzino;

 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in MEMO_LINK per leggere Lunghezza File originale (memo_link) id=" +string(ast_tab_memo_link.id_memo_link) + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
else
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if ast_tab_memo_link.memo_link_lenunzip > 0 then
			k_return =  ast_tab_memo_link.memo_link_lenunzip
		end if
	end if
end if


return k_return



end function

public function integer crea_memo_link (st_tab_memo_link ast_tab_memo_link[]) throws uo_exception;//
//--- Crea memo link passando i dati nell'array 
//--- input: array st_tab_memo_link con i dati da caricare, attenzione carica anche il BLOB se indicato nel campo "memo_link_load"  = ..._SI
//--- out:
//--- rit: nr record caricati
//
int k_return = 0
int k_riga = 0, k_righe_max=0


	k_righe_max = UpperBound(ast_tab_memo_link[])
	
	for k_riga = 1 to k_righe_max
	
		if_isnull(ast_tab_memo_link[k_riga])
	
	//--- inserisce il record in tab
		tb_add(ast_tab_memo_link[k_riga])
	
	//--- caricare il documento nel BLOB?
		if ast_tab_memo_link[k_riga].memo_link_load = kki_memo_link_load_si then
			
			if trim(ast_tab_memo_link[k_riga].link) > " " and len(ast_tab_memo_link[k_riga].memo_link) < 5 then
				ast_tab_memo_link[k_riga].memo_link_lenunzip = filelength(ast_tab_memo_link[k_riga].link)  
				load_memo_link(ast_tab_memo_link[k_riga])  //--- carica da file il BLOB nel campo memo_link
			
				tb_update_memo_link(ast_tab_memo_link[k_riga])
				k_return ++
			end if
		end if

	end for


return k_return 

end function

public function long tb_add (ref st_tab_memo_link ast_tab_memo_link) throws uo_exception;//
//--------------------------------------------------------------------
//--- Aggiunge riga in tabella  MEMO_LINK
//--- 
//--- Input: st_tab_memo_link
//--- Ritorna id_memo_link
//--- 
//--- x errore grave lancia exception
//--------------------------------------------------------------------
// 
long k_return = 0
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
st_tab_memo_link kst_tab_memo_link
boolean k_autorizza

	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	if if_sicurezza(kkg_flag_modalita.modifica ) then 

	//--- imposto dati utente e data aggiornamento
		ast_tab_memo_link.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_memo_link.x_utente = kGuf_data_base.prendi_x_utente()
		
		if ast_tab_memo_link.dataora_ins > datetime(date(0)) then
		else
			ast_tab_memo_link.dataora_ins = kGuf_data_base.prendi_x_datins()
			ast_tab_memo_link.utente_ins = kGuf_data_base.prendi_x_utente()
		end if

	//--- toglie valori NULL
		if_isnull(ast_tab_memo_link)
		kst_tab_memo_link.memo_link_load = kki_memo_link_load_no   
		kst_tab_memo_link.memo_link_lenunzip = 0
		  //id_memo_link,
	    INSERT INTO memo_link
				 ( 
				  id_memo,
				  TIPO_MEMO_link,
				  dataora_ins, 
				  utente_ins,
				  titolo,   
				  link,   
				  memo_link_load,   
				  memo_link_lenunzip,   
				  x_datins,
				  x_utente
				  )
			  VALUES ( 
				  :ast_tab_memo_link.ID_MEMO,
				  :ast_tab_memo_link.TIPO_MEMO_link,
				  :ast_tab_memo_link.dataora_ins, 
				  :ast_tab_memo_link.utente_ins, 
				  :ast_tab_memo_link.titolo,   
				  :ast_tab_memo_link.link,   
				  :kst_tab_memo_link.memo_link_load,   
				  :kst_tab_memo_link.memo_link_lenunzip,   
				  :ast_tab_memo_link.x_datins,   
				  :ast_tab_memo_link.x_utente
			      )
		USING kguo_sqlca_db_magazzino;
		
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore Aggiornamento MEMO~n~r" + trim(sqlca.SQLErrText) 
				if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
		else
			//ast_tab_memo_link.id_memo_link = long(kguo_sqlca_db_magazzino.SQLReturnData)
			ast_tab_memo_link.id_memo_link = get_ult_id_memo_link( ) // get del ID appena generato
			if len(ast_tab_memo_link.memo_link) > 0 then
				tb_update_memo_link(ast_tab_memo_link)  // aggiorna il BLOB con i dati (memo)
			end if
			if ast_tab_memo_link.id_memo_link > 0 then
				k_return = ast_tab_memo_link.id_memo_link
			end if
		end if
//	end if

		if ast_tab_memo_link.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_memo_link.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
end try



return k_return
end function

on kuf_memo_link.create
call super::create
end on

on kuf_memo_link.destroy
call super::destroy
end on

