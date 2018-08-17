$PBExportHeader$kds_e1_asn_accettato.sru
forward
global type kds_e1_asn_accettato from kds_e1_asn
end type
end forward

global type kds_e1_asn_accettato from kds_e1_asn
string dataobject = "ds_e1_asn_accettato"
end type
global kds_e1_asn_accettato kds_e1_asn_accettato

forward prototypes
public function boolean u_if_accettato (st_get_e1barcode ast_get_e1barcode) throws uo_exception
end prototypes

public function boolean u_if_accettato (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se ASN nello stato di Accettato (Ricevuta a magazzino)
//--- Inpu: st_get_e1barcode:  APID + mcu ('         270')
//--- Out:
//--- Rit: TRUE = stato accettato
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
boolean k_return = false
long k_apid


try
	this.db_connetti( )
	if this.retrieve(ast_get_e1barcode.apid, ast_get_e1barcode.mcu) > 0 then
		k_return = true
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_accettato.create
call super::create
end on

on kds_e1_asn_accettato.destroy
call super::destroy
end on

