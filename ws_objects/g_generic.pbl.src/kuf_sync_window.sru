$PBExportHeader$kuf_sync_window.sru
forward
global type kuf_sync_window from nonvisualobject
end type
end forward

global type kuf_sync_window from nonvisualobject
end type
global kuf_sync_window kuf_sync_window

type variables
//--- per gestire il rientro in window da funzione esterna 
private long ki_window_funzione_open
private boolean ki_window_funzione_aggiornata
private string ki_flag_modalita
end variables

forward prototypes
public subroutine u_window_set_funzione_aggiornata (st_open_w kst_open_w)
public function boolean u_window_get_funzione_aggiornata (ref w_g_tab kwindow)
public subroutine u_window_set_funzione_aggiornata_off (st_open_w kst_open_w)
public function string get_flag_modalita ()
end prototypes

public subroutine u_window_set_funzione_aggiornata (st_open_w kst_open_w);//
//=== Attiva il flag di Aggiornato
//
w_g_tab kwindow
if len(trim(kst_open_w.id_programma_chiamante)) > 0  then
	ki_window_funzione_aggiornata = true
	
	kwindow=kGuf_data_base.prendi_win_x_id_programma(kst_open_w.id_programma_chiamante)
	if isvalid(kwindow) then
		kwindow.ki_sincronizza_window_ok = ki_window_funzione_aggiornata
		kwindow.ki_sincronizza_window_da_id_programma = kst_open_w.id_programma_chiamante
//		kwindow.ki_sincronizza_window_da_id_programma = kst_open_w.id_programma
	end if
end if

//--- salva la modalità dell'aggiornamento (moficica/inserimento/cancellazione/...)
ki_flag_modalita = kst_open_w.flag_modalita

end subroutine

public function boolean u_window_get_funzione_aggiornata (ref w_g_tab kwindow);//
//=== Torna true se i dati nella Funzione Aperta dal Navigatore sono stati aggiornati
//
boolean k_return = false
string k_id_programma 


	if isvalid(kwindow) then
		if kwindow.ki_sincronizza_window_ok then
			k_id_programma = kwindow.get_id_programma()
			if Len(trim(k_id_programma)) > 0 then
		      	if kwindow.ki_sincronizza_window_da_id_programma = k_id_programma then
					kwindow.ki_sincronizza_window_ok = false
					kwindow.ki_sincronizza_window_da_id_programma = ""
					k_return= true
				end if
			else
				kwindow.ki_sincronizza_window_ok = false
				k_return= true
			end if
		end if
	end if

	
return k_return




end function

public subroutine u_window_set_funzione_aggiornata_off (st_open_w kst_open_w);//
//=== Disattiva il flag di Aggiornato
//
w_g_tab kwindow
//if long(kst_open_w.key10) > 0  then
if len(trim(kst_open_w.id_programma_chiamante)) > 0  then
	ki_window_funzione_aggiornata = false
	
	kwindow=kGuf_data_base.prendi_win_x_id_programma(kst_open_w.id_programma_chiamante)
//	kwindow=kGuf_data_base.prendi_win_uguale_handle(long(kst_open_w.key10))
	if isvalid(kwindow) then
		kwindow.ki_sincronizza_window_ok = ki_window_funzione_aggiornata
		kwindow.ki_sincronizza_window_da_id_programma = kst_open_w.id_programma
	end if
end if

end subroutine

public function string get_flag_modalita ();//
return ki_flag_modalita
end function

on kuf_sync_window.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sync_window.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

