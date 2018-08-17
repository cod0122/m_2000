$PBExportHeader$w_listino_voci_l.srw
forward
global type w_listino_voci_l from w_g_tab0
end type
end forward

global type w_listino_voci_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Voci Listino"
long backcolor = 32172778
boolean ki_toolbar_window_presente = true
end type
global w_listino_voci_l w_listino_voci_l

type variables
//

private st_tab_listino_voci kist_tab_listino_voci, kist_tab_listino_voci_ultimo_cercato

private kuf_listino_voci kiuf_listino_voci


end variables

forward prototypes
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
public subroutine call_web_ruoli ()
public subroutine call_web_folder ()
public subroutine call_web_pubblica ()
public subroutine call_elenco_utenti_pubblicati ()
end prototypes

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_listino_voci kst_tab_listino_voci
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_listino_voci.id_listino_voce = dw_lista_0.getitemnumber(k_riga, "id_listino_voce")
	kst_tab_listino_voci.descr  = dw_lista_0.getitemstring(k_riga, "descr")

	if isnull(kst_tab_listino_voci.descr) = true or trim(kst_tab_listino_voci.descr) = "" then
		kst_tab_listino_voci.descr = "Voce listino senza descrizione " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Rimozione", "Sei sicuro di voler Cancellare: ~n~r" &
	         + string(kst_tab_listino_voci.id_listino_voce, "#####") + " - " + trim(kst_tab_listino_voci.descr),  &
				question!, yesno!, 2) = 1 then
		
		
		try
		
//=== Cancella la riga dal data windows di lista
			if kiuf_listino_voci.tb_delete( kst_tab_listino_voci ) then

		
				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

				dw_lista_0.setfocus()
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Cancellazione", "Operazione non eseguita")
			end if

			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()

			attiva_tasti()

		end try


	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Cancellazione", "Operazione Annullata")

	end if
end if

return " "

end function

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//	end if
//		
//	if k_importa <= 0 then // Nessuna importazione eseguita
		dw_guida.setfocus( )

	else
		if u_retrieve_dw_lista() < 1 then
			k_return = "1Nessuna Voce listino presente in archivio "

			SetPointer(oldpointer)
			messagebox("Elenco Voce listino", "Nessuna Voce listino presente in archivio ")

		end if		
	end if

	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//--- Attiva/Dis. Voci di menu personalizzate

	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
//		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Ruoli Web"
//		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Ruoli Web"
//		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Ruoli,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Ole1!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		
//		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Cartelle Web"
//		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Cartelle Web"
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Cartelle,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Ole2!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		
//		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Pubblica su Web"
//		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp =  "Trasferimento alle tabelle Web"
//		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Pubblica,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName =  "Destination5!"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
//		
//		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Ultima Pubblicazione"
//		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp =  "Elenco Utenti ultima pubblicazione"
//		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Vedi Pubb.,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName =  "BrowseClasses!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		
	end if
//---
	super::attiva_menu()



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

//choose case trim(k_par_in) 
//

//	case KKG_FLAG_RICHIESTA.libero1		//apre window web_ruoli
//		call_web_ruoli( )
//		
//	case KKG_FLAG_RICHIESTA.libero2		//apre window web_folder
//		call_web_folder( )
//
//	case KKG_FLAG_RICHIESTA.libero3		//apre window web_pubblica
//		call_web_pubblica( )
//
//	case KKG_FLAG_RICHIESTA.libero4		//apre window web_pubblicato_l (ultimo lancio Pubblicazione)
//		call_elenco_utenti_pubblicati( )
//		
//	case else
		super::smista_funz(k_par_in)

//end choose



end subroutine

protected subroutine open_start_window ();//
long k_riga
datawindowchild kdwc_1
kiuf_listino_voci = create kuf_listino_voci



//--- Argomenti:  KEY1 = id
	if len(trim(ki_st_open_w.key1)) > 0 then 
		kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ = trim(ki_st_open_w.key1)
	else
		kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ = ""
	end if
	
	dw_guida.insertrow(0)
	
	dw_guida.getchild( "descr", kdwc_1)
	kdwc_1.settransobject( kguo_sqlca_db_magazzino )
	kdwc_1.retrieve( )
	k_riga=kdwc_1.insertrow(0)
	kdwc_1.setitem(k_riga, "id_listino_voci_categ", "*")
	kdwc_1.setitem(k_riga, "descr", "per TUTTE LE VOCI")
	k_riga=kdwc_1.insertrow(0)
	kdwc_1.setitem(k_riga, "id_listino_voci_categ", "_")
	kdwc_1.setitem(k_riga, "descr", "solo Voci SENZA Categoria")
	
	dw_guida.setitem(1, "descr", kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ )

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
string k_descr=""

	try
		if trim(kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ) > " " then 
		else
			kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ = "*"
		end if
		
		
		dw_lista_0.reset()
		k_return = dw_lista_0.retrieve(0, kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ) 
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		
		attiva_tasti( )
		
	end try
	
return k_return

end function

public subroutine call_web_ruoli ();//
st_tab_listino_voci kst_tab_listino_voci
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

public subroutine call_web_folder ();//
st_tab_listino_voci kst_tab_listino_voci
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

public subroutine call_web_pubblica ();//
st_tab_listino_voci kst_tab_listino_voci
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_web_pubblica kuf1_web_pubblica


	kuf1_web_pubblica = create kuf_web_pubblica

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.id_programma = kuf1_web_pubblica.get_id_programma(K_st_open_w.flag_modalita )
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
								
	destroy kuf1_web_pubblica


end subroutine

public subroutine call_elenco_utenti_pubblicati ();//
st_tab_listino_voci kst_tab_listino_voci
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_web_pubblica kuf1_web_pubblica


	kuf1_web_pubblica = create kuf_web_pubblica

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.id_programma = kuf1_web_pubblica.get_id_programma(K_st_open_w.flag_modalita )
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
								
	destroy kuf1_web_pubblica


end subroutine

on w_listino_voci_l.create
call super::create
end on

on w_listino_voci_l.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_listino_voci ) then destroy kiuf_listino_voci

end event

type st_ritorna from w_g_tab0`st_ritorna within w_listino_voci_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_listino_voci_l
integer x = 1262
integer y = 1388
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_listino_voci_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_listino_voci_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_listino_voci_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_listino_voci_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_listino_voci kst_tab_listino_voci
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_listino_voci.id_listino_voce = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_listino_voci.id_listino_voce = dw_lista_0.getitemnumber( k_riga, "id_listino_voce") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = kiuf_listino_voci.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_listino_voci.id_listino_voce)) // id cont
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end event

type cb_modifica from w_g_tab0`cb_modifica within w_listino_voci_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_listino_voci kst_tab_listino_voci
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_listino_voci.id_listino_voce = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_listino_voci.id_listino_voce = dw_lista_0.getitemnumber( k_riga, "id_listino_voce") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.id_programma = kiuf_listino_voci.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_listino_voci.id_listino_voce)) // id cont
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_listino_voci_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_listino_voci_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_listino_voci_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
long k_riga=0
st_tab_listino_voci kst_tab_listino_voci
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_listino_voci.id_listino_voci_categ = dw_lista_0.getitemstring( k_riga, "id_listino_voci_categ") 
end if

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.id_programma = kiuf_listino_voci.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = ""
	K_st_open_w.key2 = kst_tab_listino_voci.id_listino_voci_categ
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								

return (0)


end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_listino_voci_l
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_listino_voci_l
integer x = 0
integer y = 1760
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_listino_voci_l
integer width = 2304
integer height = 708
integer taborder = 120
string dataobject = "d_listino_voci_l"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_listino_voci_l
boolean visible = true
integer x = 0
integer y = 8
integer width = 2629
boolean enabled = true
string dataobject = "d_listino_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true
 

		
	kist_tab_listino_voci.id_listino_voci_categ = trim(dw_guida.getitemstring(1, "descr"))
	if trim(kist_tab_listino_voci.id_listino_voci_categ) > " " then
	else
		kist_tab_listino_voci.id_listino_voci_categ = "*"
		dw_guida.setitem(1, "descr", kist_tab_listino_voci.id_listino_voci_categ )
	end if


//--- solo se ricerco un item diverso
	if kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ <> trim(dw_guida.getitemstring(1, "descr")) &
	       or trim(dw_guida.getitemstring(1, "descr"))= "*" &
	       or trim(dw_guida.getitemstring(1, "descr")) = "_" then
		
		kist_tab_listino_voci_ultimo_cercato.id_listino_voci_categ = trim(dw_guida.getitemstring(1, "descr"))
		
		u_retrieve_dw_lista()
			
	end if

end event

