$PBExportHeader$kuf_timing.sru
forward
global type kuf_timing from timing
end type
end forward

global type kuf_timing from timing
end type
global kuf_timing kuf_timing

event timer;//
window  k_w_attiva

//=== Prende la window attiva in quel momento
k_w_attiva = w_main.GetActiveSheet( )
//=== Controlla se il valore e' valido
IF IsValid(k_w_attiva) THEN
	k_w_attiva.tag = "ag"
	k_w_attiva.triggerevent("ue_menu")
end if

end event

on kuf_timing.create
call timing::create
TriggerEvent( this, "constructor" )
end on

on kuf_timing.destroy
call timing::destroy
TriggerEvent( this, "destructor" )
end on

