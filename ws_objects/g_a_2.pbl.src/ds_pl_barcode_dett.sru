$PBExportHeader$ds_pl_barcode_dett.sru
forward
global type ds_pl_barcode_dett from datastore
end type
end forward

global type ds_pl_barcode_dett from datastore
string dataobject = "ds_pl_barcode_dett"
end type
global ds_pl_barcode_dett ds_pl_barcode_dett

on ds_pl_barcode_dett.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_pl_barcode_dett.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

