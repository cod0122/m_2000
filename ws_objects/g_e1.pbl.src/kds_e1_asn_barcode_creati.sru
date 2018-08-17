$PBExportHeader$kds_e1_asn_barcode_creati.sru
forward
global type kds_e1_asn_barcode_creati from kds_e1_asn
end type
end forward

global type kds_e1_asn_barcode_creati from kds_e1_asn
string dataobject = "ds_e1_asn_barcode_creati"
end type
global kds_e1_asn_barcode_creati kds_e1_asn_barcode_creati

forward prototypes
public function boolean u_if_creati (ref st_get_e1barcode ast_get_e1barcode) throws uo_exception
end prototypes

public function boolean u_if_creati (ref st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se i barcode sono stati prodotti 
//--- Inpu: st_get_e1barcode apid ASN (APID=ID_MECA), srst (stato), mcu (270)
//=== out: Work Order / Sales Order
//=== Ritorna: TRUE = Barcode generati da E1
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
boolean k_return = false


try
	this.db_connetti( )
	if this.retrieve(ast_get_e1barcode.apid, ast_get_e1barcode.mcu) > 0 then
		ast_get_e1barcode.doco = this.getitemnumber( 1, "wadoco")
		ast_get_e1barcode.rorn = this.getitemnumber( 1, "f4211_e1rorn")
		if ast_get_e1barcode.doco > 0 or ast_get_e1barcode.rorn > 0 then
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_barcode_creati.create
call super::create
end on

on kds_e1_asn_barcode_creati.destroy
call super::destroy
end on

