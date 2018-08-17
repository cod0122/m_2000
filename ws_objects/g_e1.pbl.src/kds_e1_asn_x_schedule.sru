$PBExportHeader$kds_e1_asn_x_schedule.sru
forward
global type kds_e1_asn_x_schedule from kds_e1_asn
end type
end forward

global type kds_e1_asn_x_schedule from kds_e1_asn
string dataobject = "ds_e1_asn_x_schedule"
end type
global kds_e1_asn_x_schedule kds_e1_asn_x_schedule

forward prototypes
public function boolean u_if_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception
end prototypes

public function boolean u_if_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se il lotto è pronto per la schedulazione
//--- Inpu: st_get_e1barcode apid ASN (APID=ID_MECA), mcu (270)
//--- Out:
//--- Rit: TRUE = può essere schedulato
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
boolean k_return = false
long k_apid


try
	db_connetti( )
	if this.retrieve(ast_get_e1barcode.apid, ast_get_e1barcode.mcu) > 0 then
		k_return = true
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_x_schedule.create
call super::create
end on

on kds_e1_asn_x_schedule.destroy
call super::destroy
end on

