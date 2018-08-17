$PBExportHeader$w_meca_memo_l_utente.srw
forward
global type w_meca_memo_l_utente from w_xxx_memo_l_utente
end type
end forward

global type w_meca_memo_l_utente from w_xxx_memo_l_utente
end type
global w_meca_memo_l_utente w_meca_memo_l_utente

on w_meca_memo_l_utente.create
call super::create
end on

on w_meca_memo_l_utente.destroy
call super::destroy
end on

type st_ritorna from w_xxx_memo_l_utente`st_ritorna within w_meca_memo_l_utente
end type

type st_ordina_lista from w_xxx_memo_l_utente`st_ordina_lista within w_meca_memo_l_utente
end type

type st_aggiorna_lista from w_xxx_memo_l_utente`st_aggiorna_lista within w_meca_memo_l_utente
end type

type cb_ritorna from w_xxx_memo_l_utente`cb_ritorna within w_meca_memo_l_utente
end type

type st_stampa from w_xxx_memo_l_utente`st_stampa within w_meca_memo_l_utente
end type

type cb_visualizza from w_xxx_memo_l_utente`cb_visualizza within w_meca_memo_l_utente
end type

type cb_modifica from w_xxx_memo_l_utente`cb_modifica within w_meca_memo_l_utente
end type

type cb_aggiorna from w_xxx_memo_l_utente`cb_aggiorna within w_meca_memo_l_utente
end type

type cb_cancella from w_xxx_memo_l_utente`cb_cancella within w_meca_memo_l_utente
end type

type cb_inserisci from w_xxx_memo_l_utente`cb_inserisci within w_meca_memo_l_utente
end type

type dw_dett_0 from w_xxx_memo_l_utente`dw_dett_0 within w_meca_memo_l_utente
end type

type st_orizzontal from w_xxx_memo_l_utente`st_orizzontal within w_meca_memo_l_utente
end type

type dw_lista_0 from w_xxx_memo_l_utente`dw_lista_0 within w_meca_memo_l_utente
string dataobject = "d_meca_memo_l_utente"
end type

type dw_guida from w_xxx_memo_l_utente`dw_guida within w_meca_memo_l_utente
end type

type dw_periodo from w_xxx_memo_l_utente`dw_periodo within w_meca_memo_l_utente
end type

