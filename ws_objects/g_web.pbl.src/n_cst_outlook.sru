$PBExportHeader$n_cst_outlook.sru
forward
global type n_cst_outlook from nonvisualobject
end type
end forward

global type n_cst_outlook from nonvisualobject
end type
global n_cst_outlook n_cst_outlook

type variables
OLEObject	iole_outlook, iole_item, iole_attach
private string		is_sendto

// Calendar Show As Status
constant int OLFree = 0	//The user is available.
constant int OLTentative = 1	//The user has a tentative appointment scheduled.
constant int OLBusy = 2	//The user is busy.
constant int OLOutOfOffice = 3	//The user is out of office.

end variables

forward prototypes
private function integer of_connect ()
private subroutine of_close ()
private subroutine of_new_message2 (string as_subjectheader, string as_message, readonly string as_filename[])
public subroutine of_create_email (string as_filename, string as_sendto)
private subroutine set_sendto (string as_sendto)
private function string get_sendto ()
public subroutine of_create_email2 (string as_filename[], string as_sendto)
private subroutine of_new_message (string as_subjectheader, string as_message, readonly string as_filename)
public subroutine of_create_email1 (string as_filename, string as_sendto, string as_msgheader, string as_msgbody)
public subroutine of_create_appointment (string as_subject, string as_location, string as_body, boolean ab_reminderset, integer ai_reminderminutes, datetime adt_starttime, datetime adt_endtime, boolean ab_alldayevent, boolean ab_showappointmentdialog)
end prototypes

private function integer of_connect ();int			li_rc


iole_outlook = Create OLEObject

li_rc = iole_outlook.ConnectToNewObject("outlook.application")

//Check for the return code
IF li_rc <> 0 THEN
	Messagebox("Error","Could not connect to Outlook. Error = :" + string(li_rc))
	DESTROY iole_outlook
	RETURN -1
ELSE
//	iole_outlook.AppActivate( "Inbox - Microsoft Outlook" )
	RETURN 1
END IF

end function

private subroutine of_close ();iole_outlook.DisconnectObject ( )
DESTROY iole_outlook


end subroutine

private subroutine of_new_message2 (string as_subjectheader, string as_message, readonly string as_filename[]);// Put multiple reports into one message.  See of_new_message() for detailed description of steps

int	li_step, li_cnt
string	ls_sendto

//Creates a new mail Item
iole_item = iole_outlook.CreateItem(0)
iole_item.Subject = as_subjectheader

ls_sendto = get_sendto()
IF ls_sendto <> "" THEN
	iole_item.To = ls_sendto
END IF

//Body of mail message
iole_item.Body = as_message + Char(13)


li_cnt = Upperbound(as_filename[])
FOR li_step = 1 TO li_cnt
	IF FileExists(as_filename[li_step]) THEN
		iole_attach = iole_item.Attachments
		iole_attach.add(as_filename[li_step])
	END IF
END FOR

iole_item.Display //displays the message

DESTROY iole_item
DESTROY iole_attach

end subroutine

public subroutine of_create_email (string as_filename, string as_sendto);// Create a new e-mail message.  It inserts the report as a pdf file attachment and opens
// a new message in Outlook.

int	li_rc

li_rc = This.of_connect()

IF li_rc = 1 THEN
	This.set_sendto(as_sendto)
	This.of_new_message( "", "", as_filename )
	This.of_close()
END IF

end subroutine

private subroutine set_sendto (string as_sendto);IF NOT IsNull(as_sendto) THEN
	is_sendto = as_sendto
ELSE
	is_sendto = ""
END IF


end subroutine

private function string get_sendto ();RETURN is_sendto

end function

public subroutine of_create_email2 (string as_filename[], string as_sendto);// Create a new e-mail message containing multiple reports.  Pass an array of filenames

int	li_rc

li_rc = This.of_connect()

IF li_rc = 1 THEN
	This.set_sendto(as_sendto)
	This.of_new_message2( "", "", as_filename )
	This.of_close()
END IF

end subroutine

private subroutine of_new_message (string as_subjectheader, string as_message, readonly string as_filename);string	ls_sendto

/* The argument to the 'CreateItem' function specifies the type of item that is going to be created.
'0' Mail Item
'1' Appointment
'2' Contact
'3' Task */

//Creates a new mail Item
iole_item = iole_outlook.CreateItem(0)
//iole_item.AppActivate("Untitled - Message")
//Set the subject line of message
iole_item.Subject = as_subjectheader

//Body of mail message
iole_item.Body = as_message + Char(13)

//Recipient(s) Use a semicolon to separate multiple recipients
ls_sendto = get_sendto()
IF ls_sendto <> "" THEN
	iole_item.To = ls_sendto
END IF

IF FileExists(as_filename) THEN
	iole_attach = iole_item.Attachments
	iole_attach.add(as_filename)
END IF

iole_item.Display //displays the message

// iole_item.Send //sends the message

DESTROY iole_item
DESTROY iole_attach

end subroutine

public subroutine of_create_email1 (string as_filename, string as_sendto, string as_msgheader, string as_msgbody);// Create a new e-mail message.  It inserts the report as a pdf file attachment and opens
// a new message in Outlook.  Add a message title and message body text

int	li_rc

li_rc = This.of_connect()

IF li_rc = 1 THEN
	This.set_sendto(as_sendto)
	This.of_new_message( as_msgheader, as_msgbody, as_filename )
	This.of_close()
END IF

end subroutine

public subroutine of_create_appointment (string as_subject, string as_location, string as_body, boolean ab_reminderset, integer ai_reminderminutes, datetime adt_starttime, datetime adt_endtime, boolean ab_alldayevent, boolean ab_showappointmentdialog);/* 2013/06/19:
	Create an appointment in Outlook
	See of_new_message for list of values used in createitem() */

int	li_rc


li_rc = This.of_connect()
IF li_rc = 1 THEN
	//Creates a new appointment Item
	iole_item = iole_outlook.CreateItem(1)
	iole_item.Start = adt_starttime
	iole_item.End = adt_endtime
	iole_item.Subject = as_subject
	iole_item.Location = as_location
	iole_item.Body = as_body
	iole_item.ReminderSet = ab_reminderset
	iole_item.ReminderMinutesBeforeStart = ai_reminderminutes
	iole_item.BusyStatus = OLOutOfOffice
	iole_item.AllDayEvent = ab_alldayevent
	IF ab_showappointmentdialog = TRUE THEN
		iole_item.Display		// No need to Save when using Display
	ELSE
		iole_item.Save
	END IF
//	iole_item.ShowCategoriesDialog
	DESTROY iole_item
	This.of_close()
END IF

end subroutine

on n_cst_outlook.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_outlook.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

