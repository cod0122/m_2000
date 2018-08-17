$PBExportHeader$kds_e1_asn_header.sru
forward
global type kds_e1_asn_header from kds_e1_asn
end type
end forward

global type kds_e1_asn_header from kds_e1_asn
string dataobject = "ds_e1_asn_f5547013"
end type
global kds_e1_asn_header kds_e1_asn_header

on kds_e1_asn_header.create
call super::create
end on

on kds_e1_asn_header.destroy
call super::destroy
end on

