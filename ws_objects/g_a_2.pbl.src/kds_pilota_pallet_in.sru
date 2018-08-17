$PBExportHeader$kds_pilota_pallet_in.sru
forward
global type kds_pilota_pallet_in from kds_pilota
end type
end forward

global type kds_pilota_pallet_in from kds_pilota
string dataobject = "ds_pilota_pallet_in_l"
end type
global kds_pilota_pallet_in kds_pilota_pallet_in

on kds_pilota_pallet_in.create
call super::create
end on

on kds_pilota_pallet_in.destroy
call super::destroy
end on

