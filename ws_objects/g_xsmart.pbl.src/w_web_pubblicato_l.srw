$PBExportHeader$w_web_pubblicato_l.srw
forward
global type w_web_pubblicato_l from w_g_tab0
end type
end forward

global type w_web_pubblicato_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Utenti su MySQL"
long backcolor = 32172778
boolean ki_esponi_msg_dati_modificati = false
end type
global w_web_pubblicato_l w_web_pubblicato_l

type variables
//
private st_tab_web_utenti kist_tab_web_utenti

private kuo_sqlca_db_xweb kiuo_sqlca_db_xweb

private kuf_web_utenti kiuf_web_utenti


end variables

forward prototypes
private function string inizializza ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
end prototypes

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

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
	
		if u_retrieve_dw_lista() < 1 then
			k_return = "1Nessun Utente Esportato in archivio "

			SetPointer(oldpointer)
			messagebox("Elenco Utenti Esportati", "Nessuna Utente trovato in archivio ")

		end if		
	end if

	attiva_tasti()

return k_return


end function

protected subroutine open_start_window ();//

kiuf_web_utenti = create kuf_web_utenti




//--- Argomenti:  KEY1 = id
	if len(trim(ki_st_open_w.key1)) > 0 then 
		kist_tab_web_utenti.ragionesociale = trim(ki_st_open_w.key1)
	else
		kist_tab_web_utenti.ragionesociale = "%"
	end if
	


end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	

	try

//--- Connette DB
		if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
		kiuo_sqlca_db_xweb.db_connetti()
		dw_lista_0.settransobject(kiuo_sqlca_db_xweb)
		
		dw_lista_0.reset()
		k_return = dw_lista_0.retrieve(kist_tab_web_utenti.ragionesociale) 
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		
		attiva_tasti( )
		
	end try
	
return k_return

end function

on w_web_pubblicato_l.create
call super::create
end on

on w_web_pubblicato_l.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_web_utenti ) then destroy kiuf_web_utenti

//--- disconnette DB
	try 
		if not isvalid(kiuo_sqlca_db_xweb) then kiuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
		kiuo_sqlca_db_xweb.db_disconnetti( )
		
	catch (uo_exception kuo1_exception)
		
	end try

end event

type st_ritorna from w_g_tab0`st_ritorna within w_web_pubblicato_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_web_pubblicato_l
integer x = 1262
integer y = 1388
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_web_pubblicato_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_web_pubblicato_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_web_pubblicato_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_web_pubblicato_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_web_utenti.idutente = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_web_utenti.idutente = dw_lista_0.getitemnumber( k_riga, "idutente") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = kiuf_web_utenti.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_web_utenti.idutente)) // id cont
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

type cb_modifica from w_g_tab0`cb_modifica within w_web_pubblicato_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_web_utenti.idutente = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_web_utenti.idutente = dw_lista_0.getitemnumber( k_riga, "idutente") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.id_programma = kiuf_web_utenti.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_web_utenti.idutente)) // id cont
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_web_pubblicato_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_web_pubblicato_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_web_pubblicato_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
long k_riga=0
st_tab_web_utenti kst_tab_web_utenti
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.id_programma = kiuf_web_utenti.get_id_programma(K_st_open_w.flag_modalita )
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

								

return (0)


end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_web_pubblicato_l
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_web_pubblicato_l
integer x = 0
integer y = 1760
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_web_pubblicato_l
integer width = 2304
integer height = 708
integer taborder = 120
string dataobject = "d_utenti_pubblicati_l"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_web_pubblicato_l
integer x = 0
integer y = 8
integer width = 2629
string dataobject = "dw_nulla"
end type

