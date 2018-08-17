$PBExportHeader$uo_csv_import.sru
forward
global type uo_csv_import from nonvisualobject
end type
end forward

global type uo_csv_import from nonvisualobject
end type
global uo_csv_import uo_csv_import

type variables
/*  © Copyright 2003 Searer Solutions, Inc.  All Rights Reserved.

   By using the Software, you accept all the terms and conditions of this Agreement. 
   If you do not agree to the terms and conditions of this Agreement, delete the Software. 

>>>> LICENSE AGREEMENT  <<<<
Searer Solutions, Inc. ("Licensor") grants You a non-exclusive license to 
 use the software thereto ("Software") according to the terms stated herein. 

THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, 
     EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, 
    THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
	 A PARTICULAR PURPOSE.   IN NO EVENT WILL LICENSOR BE LIABLE 
	 FOR ANY INCIDENTAL OR CONSEQUENTIAL DAMAGES, INCLUDING WITHOUT 
		LIMITATION LOSS OF DATA, LOST PROFITS, COST OF COVER OR 
		OTHER SPECIAL OR INDIRECT DAMAGES ARISING UNDER OR RELATED 
		TO THE USE OF THE SOFTWARE.

Licensor makes no obligation to license, distribute or publish 
the Software or continue to do so. This Agreement will be governed 
by the laws of the State of Delaware and all actions under this Agreement 
shall be maintained in, and each party submits to the jurisdiction 
of the State. This Agreement is the entire agreement between us and 
supersedes any other communications with respect to the Software. 
If any provision of this Agreement is held to be unenforceable, the 
remainder of this Agreement shall continue in full force and effect.

Rev_040803

*/																																																																																																																							 
end variables

forward prototypes
public function integer of_importfile (string as_filename, datawindow adw_datawindow)
public function string of_csv_to_tab (readonly string as_csv)
public function integer of_importcsvstring (readonly string as_importstring, datastore as_ds)
public function integer of_importcsvstring (readonly string as_importstring, datawindow as_dw)
public function integer of_importfile (string as_filename, datastore ads_datastore)
end prototypes

public function integer of_importfile (string as_filename, datawindow adw_datawindow);//of_ImportFile( filename, datawindow )
int li_fnum 
long ll_bytes
string ls_Line

li_fnum = FileOpen( as_FileName )

do
	ll_bytes = FileRead(li_fnum, ls_Line )
	if ll_bytes > 0 then this.of_ImportcsvString( ls_line, adw_datawindow )

loop while ll_bytes > 0 
FileClose( li_fnum )


return 1
end function

public function string of_csv_to_tab (readonly string as_csv);//of_csv_to_tab

string ls_import, ls_token
long ll_tokenlen, ll_findChar, ll_currentpos

ll_currentpos = 1
if ( mid(as_csv, ll_currentpos, 1) = '"') then
	ll_findChar = pos(as_csv, '"', ll_currentpos + 1 ) //find end quote
	ll_findChar = pos(as_csv, ',', ll_findChar )  //go beyond that
else
	ll_findChar = pos(as_csv, ',', ll_currentpos )
end if

do while ll_findChar > 0 
	
	ll_tokenlen = ll_findChar - ll_currentpos 
	ls_token = mid( as_csv, ll_currentpos, ll_tokenlen )
	if ls_import = "" then 
		ls_import = ls_token
	else
		ls_import += "~t" + ls_token
	end if
	
	
	ll_currentpos = ll_findChar + 1
	
	ll_findChar = pos(as_csv, ',', ll_currentpos )
	if ( mid(as_csv, ll_currentpos, 1) = '"') then  //inside of quote
		ll_findChar = pos(as_csv, '"', ll_currentpos + 1 ) //get beyond initial quote
		do while mid(as_csv, ll_findChar, 2) = '""' 
			//check for double quotes within quote 
			ll_findChar = pos(as_csv, '"', ll_findChar+2 ) //get beyond the double quote
		loop
		ll_findChar = pos(as_csv, ',', ll_findChar )
	end if
	
	
loop

//last token
ll_tokenlen = len( as_csv ) + 1 - ll_currentpos
ls_token = mid( as_csv, ll_currentpos, ll_tokenlen )
ls_import += "~t" + ls_token

return ls_import
end function

public function integer of_importcsvstring (readonly string as_importstring, datastore as_ds);//of_ImportcsvString( importstring, datastore )
string ls_Import

ls_Import = of_csv_to_tab( as_ImportString )
as_ds.importstring( ls_import )

return 0
end function

public function integer of_importcsvstring (readonly string as_importstring, datawindow as_dw);//of_ImportcsvString
string ls_Import

ls_Import = of_csv_to_tab( as_ImportString )
as_dw.importstring( CSV!, ls_import )

return 0
end function

public function integer of_importfile (string as_filename, datastore ads_datastore);//of_ImportFile( filename, datastore )
int li_fnum 
long ll_bytes
string ls_Line

li_fnum = FileOpen( as_FileName )

do
	ll_bytes = FileRead(li_fnum, ls_Line )
	if ll_bytes > 0 then this.of_ImportcsvString( ls_line, ads_datastore )

loop while ll_bytes > 0 
FileClose( li_fnum )


return 1
end function

on uo_csv_import.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_csv_import.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

