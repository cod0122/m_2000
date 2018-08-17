$PBExportHeader$w_web_ruoli.srw
forward
global type w_web_ruoli from w_g_tab0
end type
end forward

global type w_web_ruoli from w_g_tab0
integer width = 3141
integer height = 1524
string title = "Ruoli Web"
boolean ki_toolbar_window_presente = true
end type
global w_web_ruoli w_web_ruoli

type variables
//
private kuf_web_ruoli  kiuf_web_ruoli

end variables

forward prototypes
protected function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string cancella ()
protected function string check_dati ()
protected subroutine open_start_window ()
protected subroutine riempi_id ()
protected function integer inserisci ()
public subroutine call_web_folder ()
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

protected subroutine attiva_menu ();//
boolean k_rc
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



//--- Attiva/Dis. Voci di menu personalizzate

	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Cartelle Web"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Cartelle Web"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Cartelle,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Ole2!"
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
		call_web_folder( )
		

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

protected function string cancella ();//
string k_return="0 "
long k_riga
st_tab_web_ruoli kst_tab_web_ruoli
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_tab_web_ruoli.id_web_ruolo = dw_dett_0.getitemnumber(1, "id_web_ruolo")
	kst_tab_web_ruoli.descr_it = trim(dw_dett_0.getitemstring(1, "descr_it"))
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(kst_tab_web_ruoli.id_web_ruolo) or kst_tab_web_ruoli.id_web_ruolo = 0 then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		kst_tab_web_ruoli.id_web_ruolo = dw_lista_0.getitemnumber(k_riga, "id_web_ruolo")
		kst_tab_web_ruoli.descr_it = trim(dw_lista_0.getitemstring(1, "descr_it"))
	end if
end if

if isnull(kst_tab_web_ruoli.id_web_ruolo) then
	kst_tab_web_ruoli.id_web_ruolo = 0
end if
if isnull(kst_tab_web_ruoli.descr_it) then
	kst_tab_web_ruoli.descr_it = " "
end if
if LenA(trim(kst_tab_web_ruoli.descr_it)) = 0 then
	kst_tab_web_ruoli.descr_it = "Ruolo senza descrizione" 
end if

if k_riga > 0 and kst_tab_web_ruoli.id_web_ruolo > 0 then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Ruolo Web", "Sei sicuro di voler Cancellare : ~n~r" &
	             + string(kst_tab_web_ruoli.id_web_ruolo)  + "  " + trim(kst_tab_web_ruoli.descr_it) , &
				question!, yesno!, 2) = 1 then
 
		try
//=== Cancella la riga dal data windows di lista
			kst_tab_web_ruoli.st_tab_g_0.esegui_commit = "S"
			if kiuf_web_ruoli.tb_delete(kst_tab_web_ruoli) then
				
//--- cancello riga a video
				kst_tab_web_ruoli.id_web_ruolo = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_tab_web_ruoli.id_web_ruolo = dw_dett_0.getitemnumber(1, "id_web_ruolo")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_tab_web_ruoli.id_web_ruolo) then
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
		messagebox("Elimina Ruolo Web", "Operazione Annullata !!")
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
st_tab_web_ruoli kst_tab_web_ruoli


	
	k_riga = dw_dett_0.getrow()
	

//--- Descrizione obbligatoria
	kst_tab_web_ruoli.descr_it =dw_dett_0.getitemstring(k_riga, "descr_it")
	
	if len(trim(kst_tab_web_ruoli.descr_it)) > 0 then
	else
	
		k_return = k_return + "Manca  '" + trim(dw_dett_0.object.descr_it_t.text) + "' " + "~n~r"
		k_errore = "3"
	end if	

	

return trim(k_errore) + trim(k_return)


end function

protected subroutine open_start_window ();//

	kiuf_web_ruoli = create kuf_web_ruoli


end subroutine

protected subroutine riempi_id ();//--- imposto i dati di default
st_tab_web_ruoli kst_tab_web_ruoli 

kst_tab_web_ruoli.id_web_ruolo = dw_dett_0.getitemnumber(1, "id_web_ruolo")
if kst_tab_web_ruoli.id_web_ruolo > 0 then
else
	dw_dett_0.setitem(1, "id_web_ruolo", 0)
end if
	
dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())

end subroutine

protected function integer inserisci ();//
st_tab_web_ruoli kst_tab_web_ruoli


ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

dw_dett_0.insertrow( 0)

kiuf_web_ruoli.if_isnull(kst_tab_web_ruoli)

dw_dett_0.object.id_web_ruolo[1] = kst_tab_web_ruoli.id_web_ruolo
dw_dett_0.object.descr_it[1] = kst_tab_web_ruoli.descr_it
dw_dett_0.object.descr_en[1] = kst_tab_web_ruoli.descr_en
dw_dett_0.object.flag_pl[1] = kst_tab_web_ruoli.flag_pl
dw_dett_0.object.flag_rt[1] = kst_tab_web_ruoli.flag_rt
dw_dett_0.object.flag_ad[1] = kst_tab_web_ruoli.flag_ad


attiva_tasti( )

return 0

end function

public subroutine call_web_folder ();//
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_web_folder kuf1_web_folder


	kuf1_web_folder = create kuf_web_folder

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.id_programma = kuf1_web_folder.get_id_programma(K_st_open_w.flag_modalita )
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
								
	destroy kuf1_web_folder


end subroutine

on w_web_ruoli.create
call super::create
end on

on w_web_ruoli.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_web_ruoli) then destroy kiuf_web_ruoli


end event

type st_ritorna from w_g_tab0`st_ritorna within w_web_ruoli
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_web_ruoli
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_web_ruoli
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_web_ruoli
end type

type st_stampa from w_g_tab0`st_stampa within w_web_ruoli
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_web_ruoli
end type

type cb_modifica from w_g_tab0`cb_modifica within w_web_ruoli
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_web_ruoli
end type

type cb_cancella from w_g_tab0`cb_cancella within w_web_ruoli
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_web_ruoli
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_web_ruoli
boolean enabled = true
string dataobject = "d_web_ruoli"
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_web_ruoli
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_web_ruoli
string dataobject = "d_web_ruoli_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_web_ruoli
end type

