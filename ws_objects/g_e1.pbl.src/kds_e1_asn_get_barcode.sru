$PBExportHeader$kds_e1_asn_get_barcode.sru
forward
global type kds_e1_asn_get_barcode from kds_e1_asn
end type
end forward

global type kds_e1_asn_get_barcode from kds_e1_asn
string dataobject = "ds_e1_asn_f4801_f3111_adt"
end type
global kds_e1_asn_get_barcode kds_e1_asn_get_barcode

on kds_e1_asn_get_barcode.create
call super::create
end on

on kds_e1_asn_get_barcode.destroy
call super::destroy
end on

