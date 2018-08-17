$PBExportHeader$w_sr_sicurezza.srw
forward
global type w_sr_sicurezza from w_g_tab_3
end type
end forward

global type w_sr_sicurezza from w_g_tab_3
integer width = 2107
integer height = 1544
string title = "Gestione Sicurezza"
boolean ki_toolbar_window_presente = true
end type
global w_sr_sicurezza w_sr_sicurezza

forward prototypes
protected subroutine inizializza_2 ()
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine inizializza_3 () throws uo_exception
end prototypes

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec

	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec  or tab_1.tabpage_3.dw_3.rowcount() = 0 then

	k_rc=tab_1.tabpage_3.dw_3.retrieve()  

end if				
				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//	tab_1.tabpage_3.dw_3.insertrow(0) 
end if


tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec

	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = " "
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec or tab_1.tabpage_2.dw_2.rowcount() = 0 then

	k_rc=tab_1.tabpage_2.dw_2.retrieve()  

end if				
				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected function integer cancella ();//
string k_id_programma="", k_key
long k_riga=0
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


choose case tab_1.selectedtab 
	case 1 
		k_riga = tab_1.tabpage_1.dw_1.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srutenti"
			k_key = string(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id"))
		end if
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srprof"
			k_key = string(tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id"))
		end if
	case 3
		k_riga = tab_1.tabpage_3.dw_3.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srfunz"
			k_key = string(tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id"))
		end if
	case 4
		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srsettprof"
			k_key = string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_sr_settore_profilo"))
		end if
end choose	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=
//
if k_riga > 0 then
	
	K_st_open_w.id_programma = k_id_programma
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(k_key)
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " "
	K_st_open_w.key5 = " "
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco ")

end if

return 0
end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione del TAB 1 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec

	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_1.st_1_retrieve.text) then
	k_codice_prec = tab_1.tabpage_1.st_1_retrieve.text
else
	k_codice_prec = " "
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_1.st_1_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec or tab_1.tabpage_1.dw_1.rowcount() = 0 then

	k_rc=tab_1.tabpage_1.dw_1.retrieve()  

end if				
				

attiva_tasti()
if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//	tab_1.tabpage_1.dw_1.insertrow(0) 
end if


tab_1.tabpage_1.dw_1.setfocus()
	
	
return "0"

end function

protected subroutine open_start_window ();//
	kiw_this_window.icon = kGuo_path.get_risorse() + "\sicurezza.ico" 

end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec

	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_4.st_4_retrieve.text) then
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
else
	k_codice_prec = " "
end if

k_codice_attuale = "*"

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec  or tab_1.tabpage_4.dw_4.rowcount() = 0 then

	k_rc=tab_1.tabpage_4.dw_4.retrieve()  

end if				
				

attiva_tasti()
if tab_1.tabpage_4.dw_4.rowcount() = 0 then
//	tab_1.tabpage_4.dw_4.insertrow(0) 
end if


tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

on w_sr_sicurezza.create
call super::create
end on

on w_sr_sicurezza.destroy
call super::destroy
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_sr_sicurezza
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sr_sicurezza
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sr_sicurezza
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sr_sicurezza
end type

type st_stampa from w_g_tab_3`st_stampa within w_sr_sicurezza
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sr_sicurezza
integer x = 974
integer y = 1248
end type

event cb_visualizza::clicked;//
string k_id_programma="", k_key
long k_riga=0
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


choose case tab_1.selectedtab 
	case 1 
		k_riga = tab_1.tabpage_1.dw_1.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srutenti"
			k_key = string(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id"))
		end if
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srprof"
			k_key = string(tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id"))
		end if
	case 3
		k_riga = tab_1.tabpage_3.dw_3.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srfunz"
			k_key = string(tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id"))
		end if
	case 4
		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srsettprof"
			k_key = string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_sr_settore_profilo"))
		end if
end choose	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=
//
if k_riga > 0 then
	
	K_st_open_w.id_programma = k_id_programma
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(k_key)
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " "
	K_st_open_w.key5 = " "
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

end event

type cb_modifica from w_g_tab_3`cb_modifica within w_sr_sicurezza
end type

event cb_modifica::clicked;//
string k_id_programma="", k_key
long k_riga=0
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


choose case tab_1.selectedtab 
	case 1 
		k_riga = tab_1.tabpage_1.dw_1.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srutenti"
			k_key = string(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id"))
		end if
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srprof"
			k_key = string(tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id"))
		end if
	case 3
		k_riga = tab_1.tabpage_3.dw_3.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srfunz"
			k_key = string(tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id"))
		end if
	case 4
		k_riga = tab_1.tabpage_4.dw_4.getselectedrow(0)	
		if k_riga > 0 then
			k_id_programma = "srsettprof"
			k_key = string(tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_sr_settore_profilo"))
		end if
end choose	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=
//
if k_riga > 0 then
	
	K_st_open_w.id_programma = k_id_programma
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(k_key)
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " "
	K_st_open_w.key5 = " "
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sr_sicurezza
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sr_sicurezza
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sr_sicurezza
end type

event cb_inserisci::clicked;//
string k_id_programma=""
long k_riga=0
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


	choose case tab_1.selectedtab 
		case 1 
			k_id_programma = "srutenti"
		case 2
			k_id_programma = "srprof"
		case 3
			k_id_programma = "srfunz"
		case 4
			k_id_programma = "srsettprof"
	end choose	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=
//
//if k_riga > 0 then
	
	K_st_open_w.id_programma = k_id_programma
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = " " // 
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " "
	K_st_open_w.key5 = " "
	K_st_open_w.flag_where = " "
	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//destroy kuf1_menu_window
								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_sr_sicurezza
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
long backcolor = 32172778
string text = "Utenti"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
string dataobject = "d_sr_utenti_l"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
string text = "Profili"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_profili_l"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
string text = "Funzioni"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_funzioni_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
string text = "Settori"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_settore_profilo_l"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

