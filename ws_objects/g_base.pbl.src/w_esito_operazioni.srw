$PBExportHeader$w_esito_operazioni.srw
forward
global type w_esito_operazioni from w_g_tab0
end type
end forward

global type w_esito_operazioni from w_g_tab0
string ki_syntaxquery = " "
boolean ki_resize_dw_dett = false
boolean ki_resize_no = false
boolean ki_resize_inizializza_y = true
long ki_st_orizzontal_y_start = 0
boolean ki_riparte_dopo_save_ok = false
boolean ki_exit_dopo_save_ok = false
boolean ki_reset_dopo_save_ok = true
boolean ki_msg_dopo_save_ok = false
boolean ki_consenti_modifica = true
boolean ki_consenti_inserisci = true
boolean ki_consenti_visualizza = true
long ki_riga_selezionata = 0
boolean ki_risize = true
end type
global w_esito_operazioni w_esito_operazioni

type variables
//
private kuf_esito_operazioni kiuf_esito_operazioni
private st_tab_esito_operazioni kist_tab_esito_operazioni

end variables

forward prototypes
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
end prototypes

protected subroutine open_start_window ();//
kiuf_esito_operazioni = create kuf_esito_operazioni

kist_tab_esito_operazioni.tipo_operazione = ki_st_open_w.key1 // tipo esito da estrarre
kist_tab_esito_operazioni.ts_operazione = datetime(ki_st_open_w.key2) // data da cui partire l'estrazione
if date(kist_tab_esito_operazioni.ts_operazione) > date(0) then
else
	kist_tab_esito_operazioni.ts_operazione = datetime(kguo_g.get_dataoggi()) // data oggi
end if

end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key


	if dw_lista_0.retrieve(kist_tab_esito_operazioni.tipo_operazione , "S", kist_tab_esito_operazioni.ts_operazione  ) < 1 then
		k_return = "1Nessuna Informazione trovata "

		messagebox("Lista archivio Vuota", &
			"Mi spiace, ma non e' stato Trovato nulla per la richiesta fatta ~n~r" + &
			"(Dati cercati operazione: " + kist_tab_esito_operazioni.tipo_operazione &
			+ " dalla data: " + string(date(kist_tab_esito_operazioni.ts_operazione)) + ")" )

	end if
		
//
return k_return



end function

on w_esito_operazioni.create
call super::create
end on

on w_esito_operazioni.destroy
call super::destroy
end on

type st_ritorna from w_g_tab0`st_ritorna within w_esito_operazioni
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_esito_operazioni
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_esito_operazioni
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_esito_operazioni
end type

type st_stampa from w_g_tab0`st_stampa within w_esito_operazioni
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_esito_operazioni
end type

type cb_modifica from w_g_tab0`cb_modifica within w_esito_operazioni
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_esito_operazioni
end type

type cb_cancella from w_g_tab0`cb_cancella within w_esito_operazioni
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_esito_operazioni
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_esito_operazioni
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_esito_operazioni
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_esito_operazioni
string dataobject = "d_esito_operazioni_l"
boolean ki_colora_riga_aggiornata = false
end type

type dw_guida from w_g_tab0`dw_guida within w_esito_operazioni
end type

