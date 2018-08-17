$PBExportHeader$kuf_oleobject.sru
forward
global type kuf_oleobject from oleobject
end type
end forward

global type kuf_oleobject from oleobject
end type
global kuf_oleobject kuf_oleobject

type variables
ULong ErrorCode
String ErrorText

end variables

event externalexception;// External Exception

ErrorCode = ResultCode
ErrorText = Description

end event

on kuf_oleobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_oleobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

