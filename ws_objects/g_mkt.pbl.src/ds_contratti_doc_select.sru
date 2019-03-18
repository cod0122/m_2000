$PBExportHeader$ds_contratti_doc_select.sru
forward
global type ds_contratti_doc_select from uo_datastore_0
end type
end forward

global type ds_contratti_doc_select from uo_datastore_0
string dataobject = "ds_contratti_doc_select"
end type
global ds_contratti_doc_select ds_contratti_doc_select

event constructor;call super::constructor;//
this.settransobject( sqlca )
end event

on ds_contratti_doc_select.create
call super::create
end on

on ds_contratti_doc_select.destroy
call super::destroy
end on

