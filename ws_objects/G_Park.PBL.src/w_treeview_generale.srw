$PBExportHeader$w_treeview_generale.srw
forward
global type w_treeview_generale from w_g_tab_tv
end type
end forward

global type w_treeview_generale from w_g_tab_tv
end type
global w_treeview_generale w_treeview_generale

on w_treeview_generale.create
call super::create
end on

on w_treeview_generale.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_aggiorna_lista from w_g_tab_tv`st_aggiorna_lista within w_treeview_generale
end type

type cb_ritorna from w_g_tab_tv`cb_ritorna within w_treeview_generale
end type

type st_stampa from w_g_tab_tv`st_stampa within w_treeview_generale
end type

type st_ritorna from w_g_tab_tv`st_ritorna within w_treeview_generale
end type

type dw_trova from w_g_tab_tv`dw_trova within w_treeview_generale
end type

type st_visualizza from w_g_tab_tv`st_visualizza within w_treeview_generale
end type

type st_modifica from w_g_tab_tv`st_modifica within w_treeview_generale
end type

type st_conferma from w_g_tab_tv`st_conferma within w_treeview_generale
end type

type st_cancella from w_g_tab_tv`st_cancella within w_treeview_generale
end type

type st_1 from w_g_tab_tv`st_1 within w_treeview_generale
end type

type st_inserisci from w_g_tab_tv`st_inserisci within w_treeview_generale
end type

type tv_root from w_g_tab_tv`tv_root within w_treeview_generale
end type

type lv_1 from w_g_tab_tv`lv_1 within w_treeview_generale
end type

type st_vertical from w_g_tab_tv`st_vertical within w_treeview_generale
end type

type st_orizzontal from w_g_tab_tv`st_orizzontal within w_treeview_generale
end type

type dw_anteprima from w_g_tab_tv`dw_anteprima within w_treeview_generale
end type

type dw_stampa from w_g_tab_tv`dw_stampa within w_treeview_generale
end type

