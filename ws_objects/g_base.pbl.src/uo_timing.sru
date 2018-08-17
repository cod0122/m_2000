$PBExportHeader$uo_timing.sru
forward
global type uo_timing from timing
end type
end forward

global type uo_timing from timing
end type
global uo_timing uo_timing

on uo_timing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

