$PBExportHeader$w_elenco.srw
forward
global type w_elenco from w_g_tab_elenco
end type
end forward

global type w_elenco from w_g_tab_elenco
integer width = 1426
integer height = 336
end type
global w_elenco w_elenco

on w_elenco.create
call super::create
end on

on w_elenco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_elenco`st_ritorna within w_elenco
end type

type st_aggiorna_lista from w_g_tab_elenco`st_aggiorna_lista within w_elenco
end type

type cb_ritorna from w_g_tab_elenco`cb_ritorna within w_elenco
end type

type st_stampa from w_g_tab_elenco`st_stampa within w_elenco
end type

type cb_visualizza from w_g_tab_elenco`cb_visualizza within w_elenco
end type

type cb_modifica from w_g_tab_elenco`cb_modifica within w_elenco
end type

type cb_conferma from w_g_tab_elenco`cb_conferma within w_elenco
integer x = 37
integer y = 700
end type

type cb_cancella from w_g_tab_elenco`cb_cancella within w_elenco
end type

type cb_inserisci from w_g_tab_elenco`cb_inserisci within w_elenco
end type

type tab_1 from w_g_tab_elenco`tab_1 within w_elenco
end type

