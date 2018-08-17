$PBExportHeader$ds_ddt_stampa.sru
forward
global type ds_ddt_stampa from datastore
end type
end forward

global type ds_ddt_stampa from datastore
end type
global ds_ddt_stampa ds_ddt_stampa

type variables


end variables

event constructor;
this.dataobject = "ds_ddt_stampa"
end event

on ds_ddt_stampa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_ddt_stampa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

