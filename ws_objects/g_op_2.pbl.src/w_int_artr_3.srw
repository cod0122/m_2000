$PBExportHeader$w_int_artr_3.srw
forward
global type w_int_artr_3 from w_int_artr
end type
end forward

global type w_int_artr_3 from w_int_artr
end type
global w_int_artr_3 w_int_artr_3

on w_int_artr_3.create
call super::create
end on

on w_int_artr_3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_int_artr`st_ritorna within w_int_artr_3
end type

type st_ordina_lista from w_int_artr`st_ordina_lista within w_int_artr_3
end type

type st_aggiorna_lista from w_int_artr`st_aggiorna_lista within w_int_artr_3
end type

type cb_ritorna from w_int_artr`cb_ritorna within w_int_artr_3
end type

type st_stampa from w_int_artr`st_stampa within w_int_artr_3
end type

type cb_visualizza from w_int_artr`cb_visualizza within w_int_artr_3
end type

type cb_modifica from w_int_artr`cb_modifica within w_int_artr_3
end type

type cb_aggiorna from w_int_artr`cb_aggiorna within w_int_artr_3
end type

type cb_cancella from w_int_artr`cb_cancella within w_int_artr_3
end type

type cb_inserisci from w_int_artr`cb_inserisci within w_int_artr_3
end type

type tab_1 from w_int_artr`tab_1 within w_int_artr_3
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

type tabpage_1 from w_int_artr`tabpage_1 within tab_1
end type

type dw_1 from w_int_artr`dw_1 within tabpage_1
end type

type st_1_retrieve from w_int_artr`st_1_retrieve within tabpage_1
end type

type ddplb_report from w_int_artr`ddplb_report within tabpage_1
end type

type st_report from w_int_artr`st_report within tabpage_1
end type

type tabpage_2 from w_int_artr`tabpage_2 within tab_1
end type

type dw_2 from w_int_artr`dw_2 within tabpage_2
end type

type st_2_retrieve from w_int_artr`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_int_artr`tabpage_3 within tab_1
end type

type dw_3 from w_int_artr`dw_3 within tabpage_3
end type

type st_3_retrieve from w_int_artr`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_int_artr`tabpage_4 within tab_1
end type

type dw_4 from w_int_artr`dw_4 within tabpage_4
end type

type st_4_retrieve from w_int_artr`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_int_artr`tabpage_5 within tab_1
end type

type dw_5 from w_int_artr`dw_5 within tabpage_5
end type

type st_5_retrieve from w_int_artr`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_int_artr`tabpage_6 within tab_1
end type

type st_6_retrieve from w_int_artr`st_6_retrieve within tabpage_6
end type

type dw_6 from w_int_artr`dw_6 within tabpage_6
end type

type tabpage_7 from w_int_artr`tabpage_7 within tab_1
end type

type st_7_retrieve from w_int_artr`st_7_retrieve within tabpage_7
end type

type dw_7 from w_int_artr`dw_7 within tabpage_7
end type

type tabpage_8 from w_int_artr`tabpage_8 within tab_1
end type

type st_8_retrieve from w_int_artr`st_8_retrieve within tabpage_8
end type

type dw_8 from w_int_artr`dw_8 within tabpage_8
end type

type tabpage_9 from w_int_artr`tabpage_9 within tab_1
end type

type st_9_retrieve from w_int_artr`st_9_retrieve within tabpage_9
end type

type dw_9 from w_int_artr`dw_9 within tabpage_9
end type

type st_duplica from w_int_artr`st_duplica within w_int_artr_3
end type

