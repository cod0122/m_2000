$PBExportHeader$w_web_folder.srw
forward
global type w_web_folder from w_g_tab0
end type
end forward

global type w_web_folder from w_g_tab0
integer width = 3141
integer height = 1524
string title = "Area Cartelle Web"
boolean ki_toolbar_window_presente = true
end type
global w_web_folder w_web_folder

type variables
//
private kuf_web_folder  kiuf_web_folder

end variables

forward prototypes
protected function string inizializza ()
protected function string cancella ()
protected function string check_dati ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
protected function integer inserisci ()
public subroutine call_web_ruoli ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
public subroutine put_video_ruolo (st_tab_web_ruoli kst_tab_web_ruoli)
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
st_tab_web_folder kst_tab_web_folder
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_tab_web_folder.id_web_folder = dw_dett_0.getitemnumber(1, "id_web_folder")
	kst_tab_web_folder.descr = trim(dw_dett_0.getitemstring(1, "descr"))
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(kst_tab_web_folder.id_web_folder) or kst_tab_web_folder.id_web_folder = 0 then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		kst_tab_web_folder.id_web_folder = dw_lista_0.getitemnumber(k_riga, "id_web_folder")
		kst_tab_web_folder.descr = trim(dw_lista_0.getitemstring(1, "descr"))
	end if
end if

if isnull(kst_tab_web_folder.id_web_folder) then
	kst_tab_web_folder.id_web_folder = 0
end if
if isnull(kst_tab_web_folder.descr) then
	kst_tab_web_folder.descr = " "
end if
if LenA(trim(kst_tab_web_folder.descr)) = 0 then
	kst_tab_web_folder.descr = "Area Cartella senza descrizione" 
end if

if k_riga > 0 and kst_tab_web_folder.id_web_folder > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Area Cartella Web", "Sei sicuro di voler Cancellare : ~n~r" &
	             + string(kst_tab_web_folder.id_web_folder)  + "  " + trim(kst_tab_web_folder.descr) , &
				question!, yesno!, 2) = 1 then
 
		try
//=== Cancella la riga dal data windows di lista
			kst_tab_web_folder.st_tab_g_0.esegui_commit = "S"
			if kiuf_web_folder.tb_delete(kst_tab_web_folder) then
				
//--- cancello riga a video
				kst_tab_web_folder.id_web_folder = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_tab_web_folder.id_web_folder = dw_dett_0.getitemnumber(1, "id_web_folder")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_tab_web_folder.id_web_folder) then
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
		messagebox("Elimina Area Cartella Web", "Operazione Annullata !!")
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
st_tab_web_folder kst_tab_web_folder
st_tab_web_ruoli kst_tab_web_ruoli
kuf_web_ruoli kuf1_web_ruoli

	
k_riga = dw_dett_0.getrow()
	
try
	
//--- Descrizione obbligatoria
	kst_tab_web_folder.descr =dw_dett_0.getitemstring(k_riga, "descr")
	
	if len(trim(kst_tab_web_folder.descr)) > 0 then
	else
	
		k_return += "Manca valore nel '" + trim(dw_dett_0.object.descr_t.text) + "' " + "~n~r"
		k_errore = "3"
	end if	

//--- Ruolo obbligatorio
	kst_tab_web_ruoli.id_web_ruolo = dw_dett_0.getitemnumber(k_riga, "id_web_ruolo")
	
	if kst_tab_web_ruoli.id_web_ruolo > 0 then
	else
		k_return +=  "Manca valore nel '" + trim(dw_dett_0.object.id_web_ruolo_t.text) + "'  '" 
		k_errore = "3"
	end if


	if k_errore = "0" or k_errore = "4" or k_errore = "5" then

//--- controllo se il codice foldercod è  già usato per lo stesso ruolo
		kst_tab_web_folder.id_web_ruolo = kst_tab_web_ruoli.id_web_ruolo
		kst_tab_web_folder.foldercod =dw_dett_0.getitemstring(k_riga, "foldercod")
		if len(trim(kst_tab_web_folder.foldercod)) > 0 then
		
			kst_tab_web_folder.id_web_folder = dw_dett_0.getitemnumber(k_riga, "id_web_folder")
			if kiuf_web_folder.if_esiste_foldercod(kst_tab_web_folder) then
				k_return += "Il valore nel '" + trim(dw_dett_0.object.foldercod_t.text) + "' (" + trim(kst_tab_web_folder.foldercod)+") è gia' stato usato, prego controllare. " + "~n~r"
				k_errore = "4"
			end if
		end if	
		
	
//--- se indicato Ruolo Controllo se Accesso area documenti Concesso
		kst_tab_web_ruoli.id_web_ruolo = dw_dett_0.getitemnumber(k_riga, "id_web_ruolo")
		
		if kst_tab_web_ruoli.id_web_ruolo > 0 then
			
			kuf1_web_ruoli = create kuf_web_ruoli
		
			if NOT kuf1_web_ruoli.if_flag_ad_true( kst_tab_web_ruoli ) then
				k_return += "Indicato nel '" + trim(dw_dett_0.object.id_web_ruolo_t.text) + "' " + " il valore '" + string(kst_tab_web_ruoli.id_web_ruolo) +"' che Non ha  'Accesso Area Documenti' Attivo.  '~n~r"
				k_errore = "4"
			end if
		end if	
	end if

	
	
catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_errore = "1" + trim(kst_esito.sqlerrtext)

finally
	if isvalid(kuf1_web_ruoli) then destroy kuf1_web_ruoli

end try

return trim(k_errore) + trim(k_return)


end function

protected subroutine open_start_window ();//
kiuf_web_folder = create kuf_web_folder

int k_rc
datawindowchild  kdwc_1



//--- Attivo dw elenco Descrizioni  già usati
	k_rc =dw_dett_0.getchild("id_web_ruolo", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)
	k_rc = kdwc_1.retrieve()
	k_rc = kdwc_1.insertrow(1)



end subroutine

protected subroutine riempi_id ();//--- imposto i dati di default
st_tab_web_folder kst_tab_web_folder 

kst_tab_web_folder.id_web_folder = dw_dett_0.getitemnumber(1, "id_web_folder")

if kst_tab_web_folder.id_web_folder > 0 then
else
	dw_dett_0.setitem(1, "id_web_folder", 0)
end if

kst_tab_web_folder.id_web_ruolo = dw_dett_0.getitemnumber(1, "id_web_ruolo")
if kst_tab_web_folder.id_web_ruolo > 0 then
else
	dw_dett_0.setitem(1, "id_web_ruolo", 0)
end if
	
dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

end subroutine

protected function integer inserisci ();//
st_tab_web_folder kst_tab_web_folder


ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

dw_dett_0.insertrow( 0)

kiuf_web_folder.if_isnull(kst_tab_web_folder)

dw_dett_0.object.id_web_folder[1] = kst_tab_web_folder.id_web_folder
dw_dett_0.object.id_web_ruolo[1] = kst_tab_web_folder.id_web_ruolo
dw_dett_0.object.descr[1] = kst_tab_web_folder.descr
dw_dett_0.object.foldercod[1] = kst_tab_web_folder.foldercod


attiva_tasti( )

return 0

end function

public subroutine call_web_ruoli ();//
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_web_ruoli kuf1_web_ruoli


	kuf1_web_ruoli = create kuf_web_ruoli

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.id_programma = kuf1_web_ruoli.get_id_programma(K_st_open_w.flag_modalita )
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
								
	destroy kuf1_web_ruoli


end subroutine

protected subroutine attiva_menu ();//
boolean k_rc
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



//--- Attiva/Dis. Voci di menu personalizzate

	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Ruoli"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Ruoli"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Ruoli,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Ole1!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if
	

	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 

//--- Personalizzo da qui
	case KKG_FLAG_RICHIESTA.libero2		//
		call_web_ruoli( )
		

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

public subroutine put_video_ruolo (st_tab_web_ruoli kst_tab_web_ruoli);//
dw_dett_0.setitem( 1, "descr_it", trim(kst_tab_web_ruoli.descr_it))
dw_dett_0.modify( "descr_it" + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 

end subroutine

on w_web_folder.create
call super::create
end on

on w_web_folder.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_web_folder) then destroy kiuf_web_folder

 
end event

type st_ritorna from w_g_tab0`st_ritorna within w_web_folder
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_web_folder
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_web_folder
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_web_folder
end type

type st_stampa from w_g_tab0`st_stampa within w_web_folder
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_web_folder
end type

type cb_modifica from w_g_tab0`cb_modifica within w_web_folder
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_web_folder
end type

type cb_cancella from w_g_tab0`cb_cancella within w_web_folder
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_web_folder
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_web_folder
boolean enabled = true
string dataobject = "d_web_folder"
end type

event dw_dett_0::itemchanged;call super::itemchanged;//
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_web_ruoli kst_tab_web_ruoli
kuf_contratti kuf1_contratti
datawindowchild kdwc_1



choose case 	lower(dwo.name)

	case "id_web_ruolo" 
		if len(trim(data)) > 0 then 
			this.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_web_ruolo = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_web_ruoli.descr_it = kdwc_1.getitemstring( k_riga, "descr_it")
				post put_video_ruolo(kst_tab_web_ruoli)
			else
				this.setitem( row, "descr_it", "")
				this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			this.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.bianco ) + "' ") 
			this.setitem( row, "descr_it", "")
		end if

end choose 

if k_errore = 0 then
	attiva_tasti()
end if

return k_errore
	
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_web_folder
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_web_folder
string dataobject = "d_web_folder_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_web_folder
end type

