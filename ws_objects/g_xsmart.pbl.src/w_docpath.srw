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
private string ki_path_root_doc_documentale =""

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
	
		k_importa = kGuf_data_base.dw_importfile(ki_st_open_w, dw_lista_0)

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
//kuf_docpathtipo kuf1_docpathtipo

	
k_riga = dw_dett_0.getrow()
	
try
	
//--- Descrizione obbligatoria
	kst_tab_docpath.descr =dw_dett_0.getitemstring(k_riga, "descr")
	
	if len(trim(kst_tab_docpath.descr)) > 0 then
	else
	
		k_return += "Manca valore nel '" + trim(dw_dett_0.object.descr_t.text) + "' " + "~n~r"
		k_errore = "3"
	end if	

//--- Obbligatori
	kst_tab_doctipo.id_doctipo = dw_dett_0.getitemnumber(k_riga, "id_doctipo")
	if kst_tab_doctipo.id_doctipo > 0 then
	else
		k_return +=  "Manca valore nel campo  '" + trim(dw_dett_0.object.id_doctipo_t.text) + "' " 
		k_errore = "3"
	end if
	
	kst_tab_docpath.path = trim(dw_dett_0.getitemstring(k_riga, "path"))
	if kst_tab_docpath.path > " " then
		if mid(kst_tab_docpath.path, 2, 1) = ":" then
			k_return +=  "Non indicare il nome dell'unità (C:, D:, ecc...) ma solo il percorso nel campo  '" + trim(dw_dett_0.object.path_t.text) + "'  " 
			k_errore = "1"
		else
			if left(kst_tab_docpath.path, 1) = "/" or left(kst_tab_docpath.path, 1) = "\" then
				k_return +=  "Iniziare subito con il nome del percorso 'relativo' senza inserire il carattere " +  left(kst_tab_docpath.path, 1) + ",  nel campo  '" + trim(dw_dett_0.object.path_t.text) + "'  " 
				k_errore = "1"
			end if
		end if
	else
		k_return +=  "Manca valore nel campo  '" + trim(dw_dett_0.object.path_t.text) + "'  " 
		k_errore = "3"
	end if
	
	kst_tab_docpath.path_x_documentale = trim(dw_dett_0.getitemstring(k_riga, "path_x_documentale"))
	if kst_tab_docpath.path_x_documentale > " " then
		if mid(kst_tab_docpath.path_x_documentale, 2, 1) = ":" then
			k_return +=  "Non indicare il nome dell'unità '" + mid(kst_tab_docpath.path_x_documentale, 2, 1)  + "' ma solo il percorso nel campo  '" + trim(dw_dett_0.object.path_x_documentale_t.text) + "'  " 
			k_errore = "1"
		else
			if left(kst_tab_docpath.path_x_documentale, 1) = "/" or left(kst_tab_docpath.path_x_documentale, 1) = "\" then
				k_return +=  "Iniziare subito con il nome del percorso 'relativo' senza inserire il carattere '" +  left(kst_tab_docpath.path_x_documentale, 1) + "',  nel campo  '" + trim(dw_dett_0.object.path_x_documentale_t.text) + "'  " 
				k_errore = "1"
			end if
		end if
	end if

//--- errori non bloccanti
	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

////--- controllo se già atttvato Archivio Documenti Principale per TIPO 
//		kst_tab_docpath.id_doctipo = kst_tab_doctipo.id_doctipo
//		
//		if kst_tab_doctipo.id_doctipo > 0 then
//			kst_tab_docpath.id_docpath = dw_dett_0.getitemnumber(k_riga, "id_docpath")
//			if kiuf_docpath.if_esiste_docpathtipo_diverso(kst_tab_docpath) then
//				k_return += "'Archivio Principale' già stato attivato in un altro 'record' dello stesso Tipo, proseguendo sarà disabilitato. " + "~n~r"
//				k_errore = "4"
//			end if
//		end if	

//--- controllo se il codice TIPO (documento) è  già usato?
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


kiuf_docpath = create kuf_docpath

//--- get la path centrale
	ki_path_root_doc_documentale = kguo_path.get_doc_root( )
	if ki_path_root_doc_documentale > " " then
		ki_path_root_doc_esterno = kguo_path.get_doc_root_esterno( )
		ki_path_root_doc_interno = kguo_path.get_doc_root_interno( )
	else
		ki_path_root_doc_esterno = "da specificare in Proprietà Azienda"
		ki_path_root_doc_interno = "da specificare in Proprietà Azienda"
		ki_path_root_doc_documentale = "da specificare in Proprietà Azienda"
	end if

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
	
dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

end subroutine

protected function integer inserisci ();//
st_tab_docpath kst_tab_docpath

ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

dw_dett_0.insertrow( 0)

kiuf_docpath.if_isnull(kst_tab_docpath)

dw_dett_0.object.id_docpath[1] = kst_tab_docpath.id_docpath
dw_dett_0.object.id_doctipo[1] = kst_tab_docpath.id_doctipo
dw_dett_0.object.descr[1] = kst_tab_docpath.descr
dw_dett_0.object.path[1] = kst_tab_docpath.path

dw_dett_0.object.k_path_root_doc[1] = ki_path_root_doc_interno
dw_dett_0.object.k_path_root_doc_1[1] = ki_path_root_doc_esterno 
dw_dett_0.object.k_path_root_doc_2[1] = ki_path_root_doc_documentale

kuf_utility kuf1_utility
kuf1_utility = create kuf_utility
kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
kuf1_utility.u_proteggi_dw("1", "id_docpath", dw_dett_0)
destroy kuf1_utility

dw_dett_0.resetupdate( )

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
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.id_programma = kuf1_doctipo.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
dw_dett_0.modify( "doctipo_descr" + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 

end subroutine

protected function integer modifica ();//
long k_riga

k_riga = super::modifica( )

if k_riga > 0 then
	dw_dett_0.object.k_path_root_doc[k_riga] = ki_path_root_doc_interno 
	dw_dett_0.object.k_path_root_doc_1[k_riga] = ki_path_root_doc_esterno
	dw_dett_0.object.k_path_root_doc_2[k_riga] = ki_path_root_doc_documentale

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
	dw_dett_0.object.k_path_root_doc_2[k_return] = ki_path_root_doc_documentale

	dw_dett_0.resetupdate( )

end if


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

type st_ritorna from w_g_tab0`st_ritorna within w_docpath
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_docpath
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_docpath
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_docpath
end type

type st_stampa from w_g_tab0`st_stampa within w_docpath
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
integer height = 500
boolean enabled = true
string dataobject = "d_docpath"
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
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
				this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			this.modify(dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			this.setitem(row, "doctipo_descr", "")
		end if

end choose 

if k_errore = 0 then
	attiva_tasti()
end if

return k_errore
	
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_docpath
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_docpath
string dataobject = "d_docpath_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_docpath
end type

