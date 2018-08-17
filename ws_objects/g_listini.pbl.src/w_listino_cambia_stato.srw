$PBExportHeader$w_listino_cambia_stato.srw
forward
global type w_listino_cambia_stato from w_g_tab0
end type
end forward

global type w_listino_cambia_stato from w_g_tab0
boolean ki_esponi_msg_dati_modificati = false
boolean ki_nessun_tasto_funzionale = true
boolean ki_sicronizza_window_consenti = false
end type
global w_listino_cambia_stato w_listino_cambia_stato

type variables
//
private kuf_listino_cambio_stato kiuf_listino_cambio_stato
private st_listini_cambio_stato kist_listini_cambio_stato

end variables

forward prototypes
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
public subroutine u_lancia_operazione ()
end prototypes

protected subroutine open_start_window ();//
int k_mese=0, k_anno=0
date k_data


kiuf_listino_cambio_stato = create kuf_listino_cambio_stato

k_mese = month(kg_dataoggi) + 1
if k_mese = 13 then 
	k_mese = 1 
	k_anno = year(kg_dataoggi) + 1
else
	k_anno = year(kg_dataoggi) 
end if

k_data = date(k_anno, k_mese, 01)
if isnull(kist_listini_cambio_stato.data_scad) then 
	kist_listini_cambio_stato.data_scad = relativedate(k_data, -1)
end if
if isnull(kist_listini_cambio_stato.stato) then 
	kist_listini_cambio_stato.stato = 0
end if

end subroutine

protected function string inizializza () throws uo_exception;//
long k_riga


if ki_st_open_w.flag_primo_giro = "S" then
	
	if dw_lista_0.rowcount( ) = 0 then
		k_riga = dw_lista_0.insertrow(0)
		dw_lista_0.setitem(k_riga, "stato", kist_listini_cambio_stato.stato)	
		dw_lista_0.setitem(k_riga, "data_scad", kist_listini_cambio_stato.data_scad)	
	end if
	
end if


return "0"
end function

public subroutine u_lancia_operazione ();//
int k_sn=2
pointer k_pointer



try 
	kist_listini_cambio_stato.stato = dw_lista_0.getitemnumber(1, "stato")
	kist_listini_cambio_stato.data_scad = dw_lista_0.getitemdate(1, "data_scad")
	
	
	k_sn = messagebox("Cambia Stato Listini", &
		 "Sei sicuro di voler  ANNULLARE  tutti i Listini scaduti al " + string(kist_listini_cambio_stato.data_scad) + " ~n~r" &
		 + "Attenzione è un'operazione DEFINITIVA!! ", Question!, YesNo!, 2) 
	
	if k_sn= 1 then
		
		k_pointer = setpointer(hourglass!)
		
		if kiuf_listino_cambio_stato.u_cambia_stato(kist_listini_cambio_stato) then
			setpointer(k_pointer)
			messagebox("Cambia Stato Listini", "Operazione Terminata Correttamente", Information!,OK!)
		else  
			setpointer(k_pointer)
			messagebox("Cambia Stato Listini", "Operazione non conclusa, nessun cambiamento effettuato.",Information!,OK!)
		end if
		
	else
		messagebox("Cambia Stato Listini", "Operazione annullata dall'utente, nessun cambiamento effettuato.", Information!,OK!)
	end if
	
	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

end try
end subroutine

on w_listino_cambia_stato.create
call super::create
end on

on w_listino_cambia_stato.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_listino_cambio_stato) then destroy kiuf_listino_cambio_stato


end event

type st_ritorna from w_g_tab0`st_ritorna within w_listino_cambia_stato
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_listino_cambia_stato
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_listino_cambia_stato
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_listino_cambia_stato
end type

type st_stampa from w_g_tab0`st_stampa within w_listino_cambia_stato
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_listino_cambia_stato
end type

type cb_modifica from w_g_tab0`cb_modifica within w_listino_cambia_stato
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_listino_cambia_stato
end type

type cb_cancella from w_g_tab0`cb_cancella within w_listino_cambia_stato
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_listino_cambia_stato
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_listino_cambia_stato
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_listino_cambia_stato
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_listino_cambia_stato
integer x = 14
integer y = 80
integer height = 560
string dataobject = "d_listini_cambio_stato"
boolean hsplitscroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_lista_0::buttonclicked;call super::buttonclicked;//
if dwo.name = "cb_ok" then
	u_lancia_operazione( )
end if

end event

type dw_guida from w_g_tab0`dw_guida within w_listino_cambia_stato
end type

