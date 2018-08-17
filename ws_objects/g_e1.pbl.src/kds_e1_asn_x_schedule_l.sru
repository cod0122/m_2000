$PBExportHeader$kds_e1_asn_x_schedule_l.sru
forward
global type kds_e1_asn_x_schedule_l from kds_e1_asn
end type
end forward

global type kds_e1_asn_x_schedule_l from kds_e1_asn
string dataobject = "ds_e1_asn_x_schedule_l"
end type
global kds_e1_asn_x_schedule_l kds_e1_asn_x_schedule_l

forward prototypes
public function long u_get_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception
public function boolean u_if_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception
end prototypes

public function long u_get_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Torna i Lotti pronti per la schedulzione (stato 20 = pronto per il trattamento)
//--- Inpu: ast_get_e1barcode mcu (=270)
//--- Out:
//--- Rit: come retrieve
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return = 0
string k_apid


try
	this.db_connetti( )

	k_return = this.retrieve(ast_get_e1barcode.mcu)

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

public function boolean u_if_ready_to_schedule (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se APID è nel datastore
//--- Inpu: st_get_e1barcode:  APID
//--- Out:
//--- Rit: TRUE = stato accettato
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
boolean k_return = false
long k_apid


try
	if this.find("waapid = '" + trim(ast_get_e1barcode.apid) + "' ", 1, this.rowcount( )) > 0 then
		k_return = true
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_x_schedule_l.create
call super::create
end on

on kds_e1_asn_x_schedule_l.destroy
call super::destroy
end on

