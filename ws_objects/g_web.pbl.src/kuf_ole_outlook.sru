$PBExportHeader$kuf_ole_outlook.sru
forward
global type kuf_ole_outlook from kuf_oleobject
end type
end forward

global type kuf_ole_outlook from kuf_oleobject
end type
global kuf_ole_outlook kuf_ole_outlook

type variables

end variables

event constructor;call super::constructor;//
Integer li_rc


// Connect to Outlook. Class name may differ depending on version.
li_rc = this.ConnectToNewObject("Outlook.Application")
If li_rc = 0 Then
	Open(w_main)
Else
	MessageBox("Errore in connesione ad Outlook", &
	this.of_ConnectError(li_rc), StopSign!)
	Return
End If

end event

event destructor;call super::destructor;// Disconnect from Outlook.
this.DisconnectObject()

end event

on kuf_ole_outlook.create
call super::create
end on

on kuf_ole_outlook.destroy
call super::destroy
end on

