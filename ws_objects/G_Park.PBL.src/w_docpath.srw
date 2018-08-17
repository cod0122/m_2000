$PBExportHeader$w_docpath.srw
forward
global type w_docpath from w_g_tab0
end type
end forward

global type w_docpath from w_g_tab0
integer width = 3141
integer height = 1524
string title = "Cartelle Documenti"
boolean ki_toolbar_window_presente = true
end type
global w_docpath w_docpath

type variables
//
private kuf_docpath  kiuf_docpath
private string ki_path_root_doc_interno =""
private string ki_path_root_doc_esterno =""
end variables

forward prototypes
protected function string inizializza ()
protected function string cancella ()
protected function string check_dati ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
protected function integer inserisci ()
public subroutine call_doctipo ()
public subroutine put_video_Tipo (st_tab_doctipo kst_tab_doctipo)
protected function integer modifica ()
protected function integer visualizza ()
private subroutine get_path ()
protected function boolean aggiorna_tabelle_altre () throws uo_exception
end prototypes

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
long k_codice
string k_attiva
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta 
	
		k_importa = kuf1_data_base.dw_importfile(ki_st_open_w, dw_lista_0)

	end if
		
	
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve() < 1 then
			k_return = "1Nessun dato trovato "

			SetPointer(oldpointer)
			messagebox("Elenco Vuoto", "Nesun Codice Trovato per la richiesta fatta")

		end if		
	end if


return k_return



end function

protected function string cancella ();//
string k_return="0 "
long k_riga
st_tab_docpath kst_tab_docpath
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(1, "id_docpath")
	kst_tab_docpath.descr = trim(dw_dett_0.getitemstring(1, "descr"))
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(kst_tab_docpath.id_docpath) or kst_tab_docpath.id_docpath = 0 then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		kst_tab_docpath.id_docpath = dw_lista_0.getitemnumber(k_riga, "id_docpath")
		kst_tab_docpath.descr = trim(dw_lista_0.getitemstring(1, "descr"))
	end if
end if

if isnull(kst_tab_docpath.id_docpath) then
	kst_tab_docpath.id_docpath = 0
end if
if isnull(kst_tab_docpath.descr) then
	kst_tab_docpath.descr = " "
end if
if LenA(trim(kst_tab_docpath.descr)) = 0 then
	kst_tab_docpath.descr = "senza descrizione" 
end if

if k_riga > 0 and kst_tab_docpath.id_docpath > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina riferimento alla Cartella Documenti", "Sei sicuro di voler Cancellare : ~n~r" &
	             + string(kst_tab_docpath.id_docpath)  + "  " + trim(kst_tab_docpath.descr) , &
				question!, yesno!, 2) = 1 then
 
		try
//=== Cancella la riga dal data windows di lista
			kst_tab_docpath.st_tab_g_0.esegui_commit = "S"
			if kiuf_docpath.tb_delete(kst_tab_docpath) then 
				
//--- cancello riga a video 
				kst_tab_docpath.id_docpath = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(1, "id_docpath")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_tab_docpath.id_docpath) then
					k_riga = dw_lista_0.getrow()	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if
			end if
			dw_dett_0.setfocus()
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			
			kguo_exception.messaggio_utente("Problemi durante Cancellazione - Operazione fallita !!", trim(kst_esito.sqlerrtext) ) 	
			k_return = "1"
			
		finally
			attiva_tasti()
			
		end try

	else
		messagebox("Elimina riferimento alla Cartella Documenti", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
//

end function

protected function string check_dati ();//
//----------------------------------------------------------------------------------------------------------
//--- Controllo formale e logico dei dati inseriti
//--- Ritorna 1 char  : 0=tutto OK; 1=errore logico; 2=errore formale;
//---			              3=dati insufficienti; 4=OK con errori non gravi
//---                          5=OK con avvertimenti
//---      il resto della stringa contiene la descrizione dell'errore   
//----------------------------------------------------------------------------------------------------------
//
string k_return = ""
string k_errore = "0"
long k_riga
st_esito kst_esito
st_tab_docpath kst_tab_docpath
st_tab_doctipo kst_tab_doctipo
kuf_doctipo kuf1_doctipo
kuf_docpathtipo kuf1_docpathtipo

	
k_riga = dw_dett_0.getrow()
	
try
	
//--- Descrizione obbligatoria
	kst_tab_docpath.descr =dw_dett_0.getitemstring(k_riga, "descr")
	
	if len(trim(kst_tab_docpath.descr)) > 0 then
	else
	
		k_return += "Manca valore nel '" + trim(dw_dett_0.object.descr_t.text) + "' " + "~n~r"
		k_errore = "3"
	end if	

//--- Tipo obbligatorio
	kst_tab_doctipo.id_doctipo = dw_dett_0.getitemnumber(k_riga, "id_doctipo")
	
	if kst_tab_doctipo.id_doctipo > 0 then
	else
		k_return +=  "Manca valore nel '" + trim(dw_dett_0.object.id_doctipo_t.text) + "'  '" 
		k_errore = "3"
	end if


	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- controllo se già atttvato Archivio Documenti Principale per TIPO 
		kst_tab_docpath.id_doctipo = kst_tab_doctipo.id_doctipo
		
		if kst_tab_doctipo.id_doctipo > 0 then
			kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(k_riga, "id_docpath")
			if kiuf_docpath.if_esiste_docpathtipo_diverso(kst_tab_docpath) then
				k_return += "'Archivio Principale' già stato attivato in un altro 'record' dello stesso Tipo, proseguendo sarà disabilitato. " + "~n~r"
				k_errore = "4"
			end if
		end if	

//--- controllo se il codice TIPO è  già usato?
		kst_tab_docpath.id_doctipo = kst_tab_doctipo.id_doctipo
		
		if kst_tab_doctipo.id_doctipo > 0 then
			kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(k_riga, "id_docpath")
			if kiuf_docpath.if_esiste_id_doctipo(kst_tab_docpath) then
				k_return += "Il valore nel '" + trim(dw_dett_0.object.id_doctipo_t.text) + "' (" + string(kst_tab_docpath.id_doctipo)+") è gia' stato usato, prego controllare. " + "~n~r"
				k_errore = "4"
			end if
		end if	
		
	end if

	
	
catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_errore = "1" + trim(kst_esito.sqlerrtext)

finally
	if isvalid(kuf1_doctipo) then destroy kuf1_doctipo

end try

return trim(k_errore) + trim(k_return)


end function

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_1
string k_esito

kiuf_docpath = create kuf_docpath


	kuf_base kuf1_base

//--- get la path centrale
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "doc_root")
	if left(k_esito,1) <> "0" then
		ki_path_root_doc_esterno = "da specificare in Proprietà Azienda"
		ki_path_root_doc_interno = "da specificare in Proprietà Azienda"
	else
		ki_path_root_doc_esterno = trim(mid(k_esito,2)) + kuf1_base.kki_doc_root_uso_esterno
		ki_path_root_doc_interno = trim(mid(k_esito,2)) + kuf1_base.kki_doc_root_uso_interno
//		CreateDirectory ( ki_path_root_doc )
	end if
	destroy kuf1_base





//--- Attivo dw elenco Descrizioni  già usati
	k_rc =dw_dett_0.getchild("id_doctipo", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	k_rc = kdwc_1.retrieve()
	k_rc = kdwc_1.insertrow(1)



end subroutine

protected subroutine riempi_id ();//--- imposto i dati di default
st_tab_docpath kst_tab_docpath 

kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(1, "id_docpath")

if kst_tab_docpath.id_docpath > 0 then
else
	dw_dett_0.setitem(1, "id_docpath", 0)
end if

kst_tab_docpath.id_doctipo = dw_dett_0.getitemnumber(1, "id_doctipo")
if kst_tab_docpath.id_doctipo > 0 then
else
	dw_dett_0.setitem(1, "id_doctipo", 0)
end if
	
dw_dett_0.setitem(1, "x_datins", kuf1_data_base.prendi_x_datins())
dw_dett_0.setitem(1, "x_utente", kuf1_data_base.prendi_x_utente())

end subroutine

protected function integer inserisci ();//
st_tab_docpath kst_tab_docpath

ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento 

dw_dett_0.insertrow( 0)

kiuf_docpath.if_isnull(kst_tab_docpath)

dw_dett_0.object.id_docpath[1] = kst_tab_docpath.id_docpath
dw_dett_0.object.id_doctipo[1] = kst_tab_docpath.id_doctipo
dw_dett_0.object.descr[1] = kst_tab_docpath.descr
dw_dett_0.object.path[1] = kst_tab_docpath.path

dw_dett_0.object.k_path_root_doc[1] = ki_path_root_doc_interno
dw_dett_0.object.k_path_root_doc_1[1] = ki_path_root_doc_esterno 

kuf_utility kuf1_utility
kuf1_utility = create kuf_utility
kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
destroy kuf1_utility


attiva_tasti( )

return 0

end function

public subroutine call_doctipo ();//
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_doctipo kuf1_doctipo


	kuf1_doctipo = create kuf_doctipo

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita_elenco
	K_st_open_w.id_programma = kuf1_doctipo.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = ""
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
								
	destroy kuf1_doctipo


end subroutine

public subroutine put_video_Tipo (st_tab_doctipo kst_tab_doctipo);//
dw_dett_0.setitem( 1, "doctipo_descr", trim(kst_tab_doctipo.descr))
dw_dett_0.modify( "doctipo_descr" + ".Background.Color = '" + string(kk_colore_bianco ) + "' ") 

end subroutine

protected function integer modifica ();//
long k_riga
kuf_utility kuf1_utility

k_riga = super::modifica( )

if k_riga > 0 then
	dw_dett_0.object.k_path_root_doc[k_riga] = ki_path_root_doc_interno 
	dw_dett_0.object.k_path_root_doc_1[k_riga] = ki_path_root_doc_esterno
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
	destroy kuf1_utility

	dw_dett_0.resetupdate( )
	
end if

return k_riga
end function

protected function integer visualizza ();//
long k_return = 0


k_return = super::visualizza( )

if k_return > 0 then
	dw_dett_0.object.k_path_root_doc[k_return] = ki_path_root_doc_interno
	dw_dett_0.object.k_path_root_doc_1[k_return] = ki_path_root_doc_esterno

	kuf_utility kuf1_utility
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", "b_path", dw_dett_0)
	destroy kuf1_utility
end if


return k_return
end function

private subroutine get_path ();////
//string k_file="", k_path_file="", k_path, k_path_rit
//int k_ret
//long ll_p
//
//
//k_path = trim(dw_dett_0.getitemstring (1, "path"))
//if len(trim(k_path)) > 0 then
//	k_path = KKG_PATH_SEP + k_path
//else
//	k_path = KKG_PATH_SEP 
//end if
//k_path = trim(ki_path_root_doc) + k_path
//
//if len(trim(k_path)) > 0 then
//
//	k_ret = GetFolder ( "Scegliere Cartella di esportazione", k_path)
//	
//	if k_ret = 1 then
//		ll_p = 0
//		ll_p = Pos(k_path, trim(ki_path_root_doc))
//		if ll_p = 0 then
//			kguo_exception.inizializza( )
//			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
//			kguo_exception.setmessage( "La cartella radice non può essere cambiata riselezionare da: ~n~r" + ki_path_root_doc)
//			kguo_exception.messaggio_utente( )
//		else
//			ll_p = ll_p + len(trim(ki_path_root_doc)) + 1
//			k_path = mid(k_path, ll_p)  // toglie il path radice
//			dw_dett_0.setitem(1, "path", trim(k_path))
//		end if
//	else
//		if k_ret < 0 then
//	//--- ERRORE	
//		end if
//	end if
//else
//	kguo_exception.inizializza( )
//	kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
//	kguo_exception.setmessage( "Impostare prima la Cartella radice nelle Proprietà della Procedura !!")
//	kguo_exception.messaggio_utente( )
//end if
//
//
end subroutine

protected function boolean aggiorna_tabelle_altre () throws uo_exception;//
boolean k_return = false
st_tab_docpath kst_tab_docpath

if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
	kst_tab_docpath.id_docpath = kiuf_docpath.get_ultimo_id( )
	dw_dett_0.setitem( 1, "id_docpath", kst_tab_docpath.id_docpath)
end if

kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber( 1, "id_docpath")
if dw_dett_0.object.k_archivio_principale[1] = 1 then
	kst_tab_docpath.id_doctipo = dw_dett_0.getitemnumber( 1, "id_doctipo")
else
	kst_tab_docpath.id_doctipo = 0  // FARO' DELETE DEL PATHTIPO!!!!	
end if
k_return = kiuf_docpath.set_docpathtipo(kst_tab_docpath)


return k_return
end function

on w_docpath.create
call super::create
end on

on w_docpath.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_docpath) then destroy kiuf_docpath

 
end event

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_docpath
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_docpath
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_docpath
end type

type st_stampa from w_g_tab0`st_stampa within w_docpath
end type

type st_ritorna from w_g_tab0`st_ritorna within w_docpath
end type

type dw_trova from w_g_tab0`dw_trova within w_docpath
end type

type dw_filtra from w_g_tab0`dw_filtra within w_docpath
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_docpath
end type

type cb_modifica from w_g_tab0`cb_modifica within w_docpath
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_docpath
end type

type cb_cancella from w_g_tab0`cb_cancella within w_docpath
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_docpath
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_docpath
integer height = 160
boolean enabled = true
string dataobject = "d_docpath"
end type

event dw_dett_0::itemchanged;call super::itemchanged;//
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_doctipo kst_tab_doctipo
kuf_contratti kuf1_contratti
datawindowchild kdwc_1



choose case 	lower(dwo.name)

	case "id_doctipo" 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_doctipo = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_doctipo.descr = kdwc_1.getitemstring( k_riga, "descr")
				post put_video_Tipo(kst_tab_doctipo)
			else
				this.setitem( row, "doctipo_descr", "")
				this.modify( dwo.name + ".Background.Color = '" + string(KK_COLORE_ERR_DATO) + "' ") 
			end if
		else
			this.modify(dwo.name + ".Background.Color = '" + string(kk_colore_bianco ) + "' ") 
			this.setitem(row, "doctipo_descr", "")
		end if

end choose 

if k_errore = 0 then
	attiva_tasti()
end if

return k_errore
	
end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//
//	if dwo.name = "b_path" then
//		get_path()
//	end if
//
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_docpath
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_docpath
string dataobject = "d_docpath_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_docpath
end type

