$PBExportHeader$w_base_personale_1.srw
forward
global type w_base_personale_1 from w_base_personale
end type
end forward

global type w_base_personale_1 from w_base_personale
integer width = 3104
integer height = 2980
end type
global w_base_personale_1 w_base_personale_1

on w_base_personale_1.create
call super::create
end on

on w_base_personale_1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_base_personale`st_ritorna within w_base_personale_1
end type

type st_ordina_lista from w_base_personale`st_ordina_lista within w_base_personale_1
end type

type st_aggiorna_lista from w_base_personale`st_aggiorna_lista within w_base_personale_1
end type

type cb_ritorna from w_base_personale`cb_ritorna within w_base_personale_1
end type

type st_stampa from w_base_personale`st_stampa within w_base_personale_1
end type

type cb_visualizza from w_base_personale`cb_visualizza within w_base_personale_1
end type

type cb_modifica from w_base_personale`cb_modifica within w_base_personale_1
end type

type cb_aggiorna from w_base_personale`cb_aggiorna within w_base_personale_1
end type

type cb_cancella from w_base_personale`cb_cancella within w_base_personale_1
end type

type cb_inserisci from w_base_personale`cb_inserisci within w_base_personale_1
end type

type tab_1 from w_base_personale`tab_1 within w_base_personale_1
integer x = 0
integer width = 3045
integer height = 2768
boolean raggedright = false
boolean boldselectedtext = false
boolean perpendiculartext = false
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
this.tabpage_9,&
this.tabpage_10,&
this.tabpage_11,&
this.tabpage_12,&
this.tabpage_13}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_base_personale`tabpage_1 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_1 from w_base_personale`dw_1 within tabpage_1
integer x = 14
integer height = 2732
boolean controlmenu = false
end type

type st_1_retrieve from w_base_personale`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_base_personale`tabpage_2 within tab_1
boolean visible = true
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_2 from w_base_personale`dw_2 within tabpage_2
end type

type st_2_retrieve from w_base_personale`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_base_personale`tabpage_3 within tab_1
boolean visible = true
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_3 from w_base_personale`dw_3 within tabpage_3
end type

type st_3_retrieve from w_base_personale`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_base_personale`tabpage_4 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_4 from w_base_personale`dw_4 within tabpage_4
end type

type st_4_retrieve from w_base_personale`st_4_retrieve within tabpage_4
end type

type st_non_auth_4 from w_base_personale`st_non_auth_4 within tabpage_4
end type

type tabpage_5 from w_base_personale`tabpage_5 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_5 from w_base_personale`dw_5 within tabpage_5
end type

type st_5_retrieve from w_base_personale`st_5_retrieve within tabpage_5
end type

type st_non_auth_5 from w_base_personale`st_non_auth_5 within tabpage_5
end type

type tabpage_6 from w_base_personale`tabpage_6 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_6_retrieve from w_base_personale`st_6_retrieve within tabpage_6
end type

type dw_6 from w_base_personale`dw_6 within tabpage_6
end type

type st_1 from w_base_personale`st_1 within tabpage_6
end type

type cb_pilota_proprieta from w_base_personale`cb_pilota_proprieta within tabpage_6
end type

type cb_db_wmf from w_base_personale`cb_db_wmf within tabpage_6
end type

type st_18 from w_base_personale`st_18 within tabpage_6
end type

type cb_db_web from w_base_personale`cb_db_web within tabpage_6
end type

type st_19 from w_base_personale`st_19 within tabpage_6
end type

type cb_db_crm from w_base_personale`cb_db_crm within tabpage_6
end type

type st_21 from w_base_personale`st_21 within tabpage_6
end type

type cb_db_previsioni from w_base_personale`cb_db_previsioni within tabpage_6
end type

type st_23 from w_base_personale`st_23 within tabpage_6
end type

type cb_db_e1 from w_base_personale`cb_db_e1 within tabpage_6
end type

type st_26 from w_base_personale`st_26 within tabpage_6
end type

type tabpage_7 from w_base_personale`tabpage_7 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_7_retrieve from w_base_personale`st_7_retrieve within tabpage_7
end type

type dw_7 from w_base_personale`dw_7 within tabpage_7
end type

type tabpage_8 from w_base_personale`tabpage_8 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_8_retrieve from w_base_personale`st_8_retrieve within tabpage_8
end type

type dw_8 from w_base_personale`dw_8 within tabpage_8
end type

type rr_1 from w_base_personale`rr_1 within tabpage_8
end type

type rr_4 from w_base_personale`rr_4 within tabpage_8
end type

type rr_2 from w_base_personale`rr_2 within tabpage_8
end type

type st_3 from w_base_personale`st_3 within tabpage_8
end type

type cb_ausiliari_1 from w_base_personale`cb_ausiliari_1 within tabpage_8
end type

type cb_ausiliari_2 from w_base_personale`cb_ausiliari_2 within tabpage_8
end type

type st_5 from w_base_personale`st_5 within tabpage_8
end type

type st_6 from w_base_personale`st_6 within tabpage_8
end type

type st_7 from w_base_personale`st_7 within tabpage_8
end type

type st_8 from w_base_personale`st_8 within tabpage_8
end type

type st_10 from w_base_personale`st_10 within tabpage_8
end type

type st_11 from w_base_personale`st_11 within tabpage_8
end type

type st_12 from w_base_personale`st_12 within tabpage_8
end type

type st_9 from w_base_personale`st_9 within tabpage_8
end type

type st_13 from w_base_personale`st_13 within tabpage_8
end type

type st_14 from w_base_personale`st_14 within tabpage_8
end type

type st_15 from w_base_personale`st_15 within tabpage_8
end type

type st_16 from w_base_personale`st_16 within tabpage_8
end type

type st_17 from w_base_personale`st_17 within tabpage_8
end type

type cb_docpath from w_base_personale`cb_docpath within tabpage_8
end type

type st_20 from w_base_personale`st_20 within tabpage_8
end type

type st_2 from w_base_personale`st_2 within tabpage_8
end type

type st_24 from w_base_personale`st_24 within tabpage_8
end type

type st_25 from w_base_personale`st_25 within tabpage_8
end type

type st_28 from w_base_personale`st_28 within tabpage_8
end type

type tabpage_9 from w_base_personale`tabpage_9 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_9_retrieve from w_base_personale`st_9_retrieve within tabpage_9
end type

type dw_9 from w_base_personale`dw_9 within tabpage_9
end type

type st_4 from w_base_personale`st_4 within tabpage_9
end type

type st_22 from w_base_personale`st_22 within tabpage_9
end type

type tabpage_10 from w_base_personale`tabpage_10 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_27 from w_base_personale`st_27 within tabpage_10
end type

type cb_meca_chiude from w_base_personale`cb_meca_chiude within tabpage_10
end type

type st_meca_chiude from w_base_personale`st_meca_chiude within tabpage_10
end type

type dw_10 from w_base_personale`dw_10 within tabpage_10
end type

type tabpage_11 from w_base_personale`tabpage_11 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_11 from w_base_personale`dw_11 within tabpage_11
end type

type tabpage_12 from w_base_personale`tabpage_12 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type dw_12 from w_base_personale`dw_12 within tabpage_12
end type

type tabpage_13 from w_base_personale`tabpage_13 within tab_1
integer x = 128
integer width = 2898
integer height = 2736
end type

type st_esiti_operazioni from w_base_personale`st_esiti_operazioni within tabpage_13
end type

type pb_st_esiti_operazioni from w_base_personale`pb_st_esiti_operazioni within tabpage_13
end type

type cb_monitor from w_base_personale`cb_monitor within tabpage_13
end type

type st_13_retrieve from w_base_personale`st_13_retrieve within tabpage_13
end type

type st_non_auth_13 from w_base_personale`st_non_auth_13 within tabpage_13
end type

type dw_13 from w_base_personale`dw_13 within tabpage_13
end type

