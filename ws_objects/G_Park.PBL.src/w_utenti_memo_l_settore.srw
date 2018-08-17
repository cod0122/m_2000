$PBExportHeader$w_utenti_memo_l_settore.srw
forward
global type w_utenti_memo_l_settore from w_xxx_memo_l_utente
end type
end forward

global type w_utenti_memo_l_settore from w_xxx_memo_l_utente
boolean ki_attiva_toolbar_periodo = true
end type
global w_utenti_memo_l_settore w_utenti_memo_l_settore

type variables
//
private string ki_settore_dacercare

end variables

forward prototypes
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
protected function string inizializza ()
end prototypes

protected subroutine open_start_window ();//
	kiuf_memo_utenti = create kuf_memo_utenti
	kiuf_memo = create kuf_memo

//--- Salvo dati passati nei parametri di input

//--- codice anagrafica/meca/.... a seconda del tipo	
	if isnumber(trim(ki_st_open_w.key1)) then
		ki_id_dacercare = long(trim(ki_st_open_w.key1))
	else
		ki_id_dacercare = 0
	end if

//--- in KEY2 = SETTORE
	if trim(ki_st_open_w.key2) > " " then
		ki_settore_dacercare = trim(ki_st_open_w.key2)
	else
		ki_settore_dacercare = ""
	end if


//--- in KEY3 = Stato 4=letto e da leggere, 8=rimossi, 9=tutti  che se passato viene subito lanciata la lista	
	if trim(ki_st_open_w.key3) > " " then
		ki_stato_cercato = trim(ki_st_open_w.key3)
	else
		setnull(ki_stato_cercato)
	end if
	
	dw_periodo.ki_data_fin = kguo_g.get_dataoggi( )
	dw_periodo.ki_data_ini = relativedate(dw_periodo.ki_data_fin, -90)
		
	dw_guida.insertrow(0)
	dw_guida.setitem(1, "tipo", "4")
	
	//--- inizializza box periodo
//	dw_periodo.inizializza( kiw_this_window )

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
long k_id_utente=0
datetime k_data_da, k_data_a
st_tab_memo_utenti kst_tab_memo_utenti_da, kst_tab_memo_utenti_a


	try
		
//--- Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_attesa)
	
		if isnull(ki_stato_cercato) then
			ki_stato_cercato = "4"
		end if
		
		choose case ki_stato_cercato
			case "4"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_letto
			case "8"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_rimosso
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
			case "9"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
		end choose
		k_data_da = datetime( dw_periodo.ki_data_ini)
		k_data_a = datetime( relativedate(dw_periodo.ki_data_fin, 1))

		dw_lista_0.reset()
		k_return = dw_lista_0.retrieve(ki_settore_dacercare, ki_id_dacercare, kst_tab_memo_utenti_da.stato, kst_tab_memo_utenti_a.stato, k_data_da, k_data_a)
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		attiva_tasti( )
		SetPointer(kkg.pointer_default)
		
	end try
	
return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//	if ki_st_open_w.flag_primo_giro = "S" then
		dw_guida.setfocus( )

		u_retrieve_dw_lista( )
//	end if



return k_return



end function

on w_utenti_memo_l_settore.create
call super::create
end on

on w_utenti_memo_l_settore.destroy
call super::destroy
end on

type st_ritorna from w_xxx_memo_l_utente`st_ritorna within w_utenti_memo_l_settore
end type

type st_ordina_lista from w_xxx_memo_l_utente`st_ordina_lista within w_utenti_memo_l_settore
end type

type st_aggiorna_lista from w_xxx_memo_l_utente`st_aggiorna_lista within w_utenti_memo_l_settore
end type

type cb_ritorna from w_xxx_memo_l_utente`cb_ritorna within w_utenti_memo_l_settore
end type

type st_stampa from w_xxx_memo_l_utente`st_stampa within w_utenti_memo_l_settore
end type

type cb_visualizza from w_xxx_memo_l_utente`cb_visualizza within w_utenti_memo_l_settore
end type

type cb_modifica from w_xxx_memo_l_utente`cb_modifica within w_utenti_memo_l_settore
end type

type cb_aggiorna from w_xxx_memo_l_utente`cb_aggiorna within w_utenti_memo_l_settore
end type

type cb_cancella from w_xxx_memo_l_utente`cb_cancella within w_utenti_memo_l_settore
end type

type cb_inserisci from w_xxx_memo_l_utente`cb_inserisci within w_utenti_memo_l_settore
end type

type dw_dett_0 from w_xxx_memo_l_utente`dw_dett_0 within w_utenti_memo_l_settore
end type

type st_orizzontal from w_xxx_memo_l_utente`st_orizzontal within w_utenti_memo_l_settore
end type

type dw_lista_0 from w_xxx_memo_l_utente`dw_lista_0 within w_utenti_memo_l_settore
string dataobject = "d_utenti_memo_l_settore"
end type

type dw_guida from w_xxx_memo_l_utente`dw_guida within w_utenti_memo_l_settore
end type

type dw_periodo from w_xxx_memo_l_utente`dw_periodo within w_utenti_memo_l_settore
end type

