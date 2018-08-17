$PBExportHeader$kds_pilota_pallet_out.sru
forward
global type kds_pilota_pallet_out from kds_pilota
end type
end forward

global type kds_pilota_pallet_out from kds_pilota
string dataobject = "ds_pilota_pallet_out_l"
end type
global kds_pilota_pallet_out kds_pilota_pallet_out

on kds_pilota_pallet_out.create
call super::create
end on

on kds_pilota_pallet_out.destroy
call super::destroy
end on

