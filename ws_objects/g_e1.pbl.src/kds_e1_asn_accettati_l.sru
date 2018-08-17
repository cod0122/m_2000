$PBExportHeader$kds_e1_asn_accettati_l.sru
forward
global type kds_e1_asn_accettati_l from kds_e1_asn
end type
end forward

global type kds_e1_asn_accettati_l from kds_e1_asn
string dataobject = "ds_e1_asn_accettati_l"
end type
global kds_e1_asn_accettati_l kds_e1_asn_accettati_l

forward prototypes
public function boolean u_if_accettato (st_get_e1barcode ast_get_e1barcode) throws uo_exception
public function long u_get_accettati_l (st_get_e1barcode ast_get_e1barcode) throws uo_exception
end prototypes

public function boolean u_if_accettato (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Verifica se APID è tra gli ASN nello stato di Accettato (Ricevuti a magazzino)
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

public function long u_get_accettati_l (st_get_e1barcode ast_get_e1barcode) throws uo_exception;//-------------------------------------------------------------------------------
//--- Retrieve ASN nello stato di Accettato (Ricevuti a magazzino)
//--- Inpu: st_get_e1barcode:  mcu ('         270')
//--- Out:
//--- Rit: TRUE = stato accettato
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
long k_return = 0
long k_apid


try
	this.db_connetti( )
	k_return = this.retrieve(ast_get_e1barcode.mcu) 

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_asn_accettati_l.create
call super::create
end on

on kds_e1_asn_accettati_l.destroy
call super::destroy
end on

