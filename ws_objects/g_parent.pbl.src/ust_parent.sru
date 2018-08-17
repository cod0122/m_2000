$PBExportHeader$ust_parent.sru
forward
global type ust_parent from nonvisualobject
end type
end forward

global type ust_parent from nonvisualobject
end type
global ust_parent ust_parent

type variables
//
private boolean i__esegui_commit=true ;  // TRUE=esegui commit (default)
private long i__contati=0;     // contatore generico


end variables

forward prototypes
public function boolean get_esegui_commit ()
public subroutine set_esegui_commit (boolean a_esegui_commit)
public subroutine set_contati (long a_contati)
public function long get_contati ()
end prototypes

public function boolean get_esegui_commit ();//
if isnull(i__esegui_commit) then i__esegui_commit = true

return i__esegui_commit

end function

public subroutine set_esegui_commit (boolean a_esegui_commit);//
if isnull(a_esegui_commit) then a_esegui_commit = true

i__esegui_commit = a_esegui_commit


end subroutine

public subroutine set_contati (long a_contati);//
if isnull(a_contati) then a_contati = 0

i__contati = a_contati


end subroutine

public function long get_contati ();//
if isnull(i__contati) then i__contati = 0

return i__contati


end function

on ust_parent.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ust_parent.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

