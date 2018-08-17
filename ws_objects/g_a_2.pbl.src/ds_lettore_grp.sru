$PBExportHeader$ds_lettore_grp.sru
forward
global type ds_lettore_grp from uo_datastore_0
end type
end forward

global type ds_lettore_grp from uo_datastore_0
end type
global ds_lettore_grp ds_lettore_grp

event constructor;call super::constructor;//
this.dataobject = "ds_lettore_grp"
this.settransobject( sqlca )
end event

on ds_lettore_grp.create
call super::create
end on

on ds_lettore_grp.destroy
call super::destroy
end on

