$PBExportHeader$ds_contratti_rd_select.sru
forward
global type ds_contratti_rd_select from uo_datastore_0
end type
end forward

global type ds_contratti_rd_select from uo_datastore_0
end type
global ds_contratti_rd_select ds_contratti_rd_select

event constructor;call super::constructor;//
this.dataobject = "ds_contratti_rd_select"
this.settransobject( sqlca )
end event

on ds_contratti_rd_select.create
call super::create
end on

on ds_contratti_rd_select.destroy
call super::destroy
end on

