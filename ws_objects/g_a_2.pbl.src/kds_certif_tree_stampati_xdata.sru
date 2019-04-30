$PBExportHeader$kds_certif_tree_stampati_xdata.sru
forward
global type kds_certif_tree_stampati_xdata from uo_datastore_0
end type
end forward

global type kds_certif_tree_stampati_xdata from uo_datastore_0
string dataobject = "ds_certif_tree_stampati_xdata"
event u_settransobject ( )
end type
global kds_certif_tree_stampati_xdata kds_certif_tree_stampati_xdata

event u_settransobject();//
this.settransobject(kguo_sqlca_db_magazzino) 

end event

on kds_certif_tree_stampati_xdata.create
call super::create
end on

on kds_certif_tree_stampati_xdata.destroy
call super::destroy
end on

event constructor;call super::constructor;//
event u_settransobject( )

end event

