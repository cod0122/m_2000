$PBExportHeader$kuo_timer_sked.sru
forward
global type kuo_timer_sked from timing
end type
end forward

global type kuo_timer_sked from timing
boolean running = false
double interval = 0
end type
global kuo_timer_sked kuo_timer_sked

type variables
//
w_super kiw_super

end variables

on kuo_timer_sked.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuo_timer_sked.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;//
kiw_super.event timer( )

end event

