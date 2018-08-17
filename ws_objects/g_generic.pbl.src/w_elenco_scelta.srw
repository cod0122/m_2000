$PBExportHeader$w_elenco_scelta.srw
forward
global type w_elenco_scelta from w_g_tab_elenco
end type
end forward

global type w_elenco_scelta from w_g_tab_elenco
integer width = 1221
integer height = 360
end type
global w_elenco_scelta w_elenco_scelta

on w_elenco_scelta.create
call super::create
end on

on w_elenco_scelta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_elenco`st_ritorna within w_elenco_scelta
end type

type st_aggiorna_lista from w_g_tab_elenco`st_aggiorna_lista within w_elenco_scelta
end type

type cb_ritorna from w_g_tab_elenco`cb_ritorna within w_elenco_scelta
end type

type st_stampa from w_g_tab_elenco`st_stampa within w_elenco_scelta
end type

type cb_visualizza from w_g_tab_elenco`cb_visualizza within w_elenco_scelta
end type

type cb_modifica from w_g_tab_elenco`cb_modifica within w_elenco_scelta
end type

type cb_conferma from w_g_tab_elenco`cb_conferma within w_elenco_scelta
end type

type cb_cancella from w_g_tab_elenco`cb_cancella within w_elenco_scelta
end type

type cb_inserisci from w_g_tab_elenco`cb_inserisci within w_elenco_scelta
end type

type tab_1 from w_g_tab_elenco`tab_1 within w_elenco_scelta
end type

