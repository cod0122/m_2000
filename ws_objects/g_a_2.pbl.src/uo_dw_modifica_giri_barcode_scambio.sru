$PBExportHeader$uo_dw_modifica_giri_barcode_scambio.sru
forward
global type uo_dw_modifica_giri_barcode_scambio from uo_d_std_1
end type
end forward

global type uo_dw_modifica_giri_barcode_scambio from uo_d_std_1
string dataobject = "d_modifica_giri_barcode"
end type
global uo_dw_modifica_giri_barcode_scambio uo_dw_modifica_giri_barcode_scambio

on uo_dw_modifica_giri_barcode_scambio.create
call super::create
end on

on uo_dw_modifica_giri_barcode_scambio.destroy
call super::destroy
end on

