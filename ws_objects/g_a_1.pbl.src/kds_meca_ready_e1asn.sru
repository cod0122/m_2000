$PBExportHeader$kds_meca_ready_e1asn.sru
forward
global type kds_meca_ready_e1asn from kds_db_magazzino
end type
end forward

global type kds_meca_ready_e1asn from kds_db_magazzino
string dataobject = "ds_meca_ready_e1asn"
end type
global kds_meca_ready_e1asn kds_meca_ready_e1asn

forward prototypes
public function integer u_retrieve ()
end prototypes

public function integer u_retrieve ();//
int k_return 
date k_data_da


k_data_da = relativedate(kguo_g.get_dataoggi( ), -280)  // cerca indietro di circa 9 mesi!


k_return = this.retrieve(k_data_da)

return k_return 

end function

on kds_meca_ready_e1asn.create
call super::create
end on

on kds_meca_ready_e1asn.destroy
call super::destroy
end on

