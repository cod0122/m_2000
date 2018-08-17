$PBExportHeader$kds_e1_f5548014.sru
forward
global type kds_e1_f5548014 from kds_e1_asn
end type
end forward

global type kds_e1_f5548014 from kds_e1_asn
string dataobject = "ds_e1_f5548014"
end type
global kds_e1_f5548014 kds_e1_f5548014

forward prototypes
public function integer u_update () throws uo_exception
end prototypes

public function integer u_update () throws uo_exception;//-------------------------------------------------------------------------------
//--- Registra su tab i dati di lavorazione su E1
//--- 
//--- datastore con i dati da registrare in tabella E1
//--- 
//--- Rit: come UPDATE (-1 = ERRORE GRAVE)
//--- lancia exception x errore grave
//-------------------------------------------------------------------------------
int k_return = 0


try
	this.db_connetti( )
	
	k_return = update( )
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_return

end function

on kds_e1_f5548014.create
call super::create
end on

on kds_e1_f5548014.destroy
call super::destroy
end on

