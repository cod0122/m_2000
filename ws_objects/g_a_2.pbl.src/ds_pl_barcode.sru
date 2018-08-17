$PBExportHeader$ds_pl_barcode.sru
forward
global type ds_pl_barcode from datastore
end type
end forward

global type ds_pl_barcode from datastore
string dataobject = "ds_pl_barcode"
end type
global ds_pl_barcode ds_pl_barcode

on ds_pl_barcode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_pl_barcode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

