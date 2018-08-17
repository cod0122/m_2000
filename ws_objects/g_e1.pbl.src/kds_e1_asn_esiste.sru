$PBExportHeader$kds_e1_asn_esiste.sru
forward
global type kds_e1_asn_esiste from kds_e1_asn
end type
end forward

global type kds_e1_asn_esiste from kds_e1_asn
string dataobject = "ds_e1_asn_f5547013_esiste"
end type
global kds_e1_asn_esiste kds_e1_asn_esiste

on kds_e1_asn_esiste.create
call super::create
end on

on kds_e1_asn_esiste.destroy
call super::destroy
end on

