$PBExportHeader$w_share.srw
forward
global type w_share from Window
end type
type cb_2 from commandbutton within w_share
end type
type cb_1 from commandbutton within w_share
end type
type cb_9 from commandbutton within w_share
end type
type cb_8 from commandbutton within w_share
end type
type cb_7 from commandbutton within w_share
end type
type cb_6 from commandbutton within w_share
end type
type dw_4 from datawindow within w_share
end type
type cb_5 from commandbutton within w_share
end type
type cb_4 from commandbutton within w_share
end type
type cb_3 from commandbutton within w_share
end type
type dw_3 from datawindow within w_share
end type
type dw_2 from datawindow within w_share
end type
type dw_1 from datawindow within w_share
end type
type gb_4 from groupbox within w_share
end type
type gb_3 from groupbox within w_share
end type
type gb_2 from groupbox within w_share
end type
type gb_1 from groupbox within w_share
end type
end forward

global type w_share from Window
int X=1075
int Y=485
int Width=2117
int Height=2189
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_2 cb_2
cb_1 cb_1
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
dw_4 dw_4
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_share w_share

type variables
DataStore myDataStore
end variables

on w_share.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.dw_4=create dw_4
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.dw_4,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_share.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.dw_4)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_share
int X=1271
int Y=397
int Width=737
int Height=109
int TabOrder=90
string Text="Reset Primary"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ShareDataOff()
end event

type cb_1 from commandbutton within w_share
int X=1271
int Y=293
int Width=737
int Height=109
int TabOrder=60
string Text="Setup shares && Retrieve"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datawindowchild dwc1

dw_1.ShareData( dw_2)

dw_1.GetChild( "dept_id", dwc1)
dwc1.ShareData( dw_3)

myDataStore = CREATE datastore
myDataStore.DataObject = "d_employee"
dw_2.ShareData( myDataStore)

myDataStore.ShareData( dw_4)

dw_1.Retrieve()
end event

type cb_9 from commandbutton within w_share
int X=1271
int Y=189
int Width=737
int Height=109
int TabOrder=140
string Text="Sort Emp Asc"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SetSort( "emp_lname A")

dw_1.Sort()
end event

type cb_8 from commandbutton within w_share
int X=1271
int Y=85
int Width=737
int Height=109
int TabOrder=110
string Text="Sort Emp Desc"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SetSort( "emp_lname D")

dw_1.Sort()
end event

type cb_7 from commandbutton within w_share
int X=1271
int Y=1749
int Width=737
int Height=109
int TabOrder=120
string Text="Manipulate DataStore"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Insert a new row into the data store
//
mydatastore.InsertRow( 0)
//
//
//
String szTemp

//szTemp = mydatastore.Object.Data.emp_lname[ 1]

MessageBox( "", szTemp)
//
//
//
mydatastore.DeleteRow( 2)
//
//
//
mydatastore.SetSort( "emp_lname D")
mydatastore.Sort()



end event

type cb_6 from commandbutton within w_share
int X=1271
int Y=1645
int Width=737
int Height=109
int TabOrder=70
string Text="Set Child"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_4.DataObject = "d_employee"

dw_4.SetTransObject( SQLCA)

dw_4.Retrieve()
end event

type dw_4 from datawindow within w_share
int X=46
int Y=1613
int Width=1203
int Height=421
int TabOrder=40
string DataObject="d_employee"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_5 from commandbutton within w_share
int X=1271
int Y=1217
int Width=737
int Height=109
int TabOrder=170
string Text="Reset "
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_3.ShareDataOff()
end event

type cb_4 from commandbutton within w_share
int X=1271
int Y=1113
int Width=737
int Height=109
int TabOrder=160
string Text="Reset Primary's Child"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datawindowchild dwc1

dw_1.GetChild( "dept_id", dwc1)

dwc1.ShareDataOff()
end event

type cb_3 from commandbutton within w_share
int X=1271
int Y=601
int Width=737
int Height=109
int TabOrder=130
string Text="Reset Secondary"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.ShareDataOff()
end event

type dw_3 from datawindow within w_share
int X=46
int Y=1101
int Width=1203
int Height=421
int TabOrder=50
string DataObject="d_datatype"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_3.SetTransObject( SQLCA)
end event

type dw_2 from datawindow within w_share
int X=46
int Y=589
int Width=1203
int Height=421
int TabOrder=20
string DataObject="d_employee"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_2.SetTransObject( SQLCA)

end event

type dw_1 from datawindow within w_share
int X=46
int Y=81
int Width=1203
int Height=421
int TabOrder=10
string DataObject="d_employee"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;dw_1.SetTransObject( SQLCA)

end event

type gb_4 from groupbox within w_share
int X=19
int Y=1545
int Width=2017
int Height=513
int TabOrder=80
string Text="Shared from a DataStore"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_share
int X=19
int Y=1033
int Width=2017
int Height=513
int TabOrder=100
string Text="Shared from Primary DeptID Column"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_share
int X=19
int Y=517
int Width=2017
int Height=513
int TabOrder=30
string Text="Shared from Primary"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_share
int X=19
int Y=9
int Width=2017
int Height=513
int TabOrder=150
string Text="Primary"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

