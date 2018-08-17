$PBExportHeader$w_convalida_dosim_autorizza.srw
forward
global type w_convalida_dosim_autorizza from w_convalida_dosim
end type
end forward

global type w_convalida_dosim_autorizza from w_convalida_dosim
end type
global w_convalida_dosim_autorizza w_convalida_dosim_autorizza

forward prototypes
protected function string inizializza () throws uo_exception
end prototypes

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
st_tab_meca kst_tab_meca
kuf_armo kuf1_armo



super::inizializza()


if tab_1.tabpage_1.dw_1.rowcount() > 0 then

	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then 

		kuf1_armo = create kuf_armo 

//--- Se ho gia' fatto la prima rilevazione della dosimetria allora entro in modifica 
//--- ovviamente se non ho gia' fatto l'operazione di autorizzazione, poiche' chiude ogni altra modifica
		kst_tab_meca.err_lav_ok = tab_1.tabpage_1.dw_1.getitemstring(1, "err_lav_ok")
		if kst_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_da_aut &
			or kst_tab_meca.err_lav_ok = kuf1_armo.ki_err_lav_ok_conv_ko_da_aut then
		
			ki_st_open_w.flag_modalita = kkg_flag_modalita_modifica

			messagebox("Conferma Dosimetria Rilevata", &
						"Il Riferimento non risulta da Autorizzare. Conferma non permessa ~n~r" + &
						"(Codice flag interno:" + trim(kst_tab_meca.err_lav_ok) + ")~n~r" )
			
		end if
	end if

//--- personalizza colore della dw a seconda della stato
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		choose case tab_1.tabpage_1.dw_1.getitemstring(1, "err_lav_ok")
			case kuf1_armo.ki_err_lav_ok_conv_da_aut
				tab_1.tabpage_1.dw_1.modify("b.ok.text='"+" &Conferma Dosimetria " +"'")
			case kuf1_armo.ki_err_lav_ok_conv_ko_da_aut
				tab_1.tabpage_1.dw_1.modify("b.ok.text='"+" &Conferma Anomalia " +"'")
			case else
				if cb_ritorna.enabled then
					cb_ritorna.postevent(clicked!)
				end if
		end choose
	end if

	destroy kuf1_armo
	
end if


return "0"


end function

on w_convalida_dosim_autorizza.create
call super::create
end on

on w_convalida_dosim_autorizza.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_aggiorna_lista from w_convalida_dosim`st_aggiorna_lista within w_convalida_dosim_autorizza
end type

type cb_ritorna from w_convalida_dosim`cb_ritorna within w_convalida_dosim_autorizza
end type

type st_stampa from w_convalida_dosim`st_stampa within w_convalida_dosim_autorizza
end type

type st_ritorna from w_convalida_dosim`st_ritorna within w_convalida_dosim_autorizza
end type

type dw_filtro_0 from w_convalida_dosim`dw_filtro_0 within w_convalida_dosim_autorizza
integer x = 1600
integer y = 892
end type

type cb_visualizza from w_convalida_dosim`cb_visualizza within w_convalida_dosim_autorizza
end type

type cb_modifica from w_convalida_dosim`cb_modifica within w_convalida_dosim_autorizza
end type

type cb_aggiorna from w_convalida_dosim`cb_aggiorna within w_convalida_dosim_autorizza
end type

type cb_cancella from w_convalida_dosim`cb_cancella within w_convalida_dosim_autorizza
end type

type cb_inserisci from w_convalida_dosim`cb_inserisci within w_convalida_dosim_autorizza
end type

type tab_1 from w_convalida_dosim`tab_1 within w_convalida_dosim_autorizza
end type

type tabpage_1 from w_convalida_dosim`tabpage_1 within tab_1
end type

type dw_1 from w_convalida_dosim`dw_1 within tabpage_1
end type

type st_1_retrieve from w_convalida_dosim`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_convalida_dosim`tabpage_2 within tab_1
end type

type dw_2 from w_convalida_dosim`dw_2 within tabpage_2
end type

type st_2_retrieve from w_convalida_dosim`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_convalida_dosim`tabpage_3 within tab_1
end type

type dw_3 from w_convalida_dosim`dw_3 within tabpage_3
end type

type st_3_retrieve from w_convalida_dosim`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_convalida_dosim`tabpage_4 within tab_1
end type

type dw_4 from w_convalida_dosim`dw_4 within tabpage_4
end type

type st_4_retrieve from w_convalida_dosim`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_convalida_dosim`tabpage_5 within tab_1
end type

type dw_5 from w_convalida_dosim`dw_5 within tabpage_5
end type

type st_5_retrieve from w_convalida_dosim`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_convalida_dosim`tabpage_6 within tab_1
end type

type st_6_retrieve from w_convalida_dosim`st_6_retrieve within tabpage_6
end type

type dw_6 from w_convalida_dosim`dw_6 within tabpage_6
end type

type tabpage_7 from w_convalida_dosim`tabpage_7 within tab_1
end type

type st_7_retrieve from w_convalida_dosim`st_7_retrieve within tabpage_7
end type

type dw_7 from w_convalida_dosim`dw_7 within tabpage_7
end type

type tabpage_8 from w_convalida_dosim`tabpage_8 within tab_1
end type

type st_8_retrieve from w_convalida_dosim`st_8_retrieve within tabpage_8
end type

type dw_8 from w_convalida_dosim`dw_8 within tabpage_8
end type

type tabpage_9 from w_convalida_dosim`tabpage_9 within tab_1
end type

type st_9_retrieve from w_convalida_dosim`st_9_retrieve within tabpage_9
end type

type dw_9 from w_convalida_dosim`dw_9 within tabpage_9
end type

type cb_cerca_1 from w_convalida_dosim`cb_cerca_1 within w_convalida_dosim_autorizza
end type

type sle_cerca from w_convalida_dosim`sle_cerca within w_convalida_dosim_autorizza
end type

