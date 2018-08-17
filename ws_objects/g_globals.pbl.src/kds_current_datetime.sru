$PBExportHeader$kds_current_datetime.sru
forward
global type kds_current_datetime from uo_datastore_0
end type
end forward

global type kds_current_datetime from uo_datastore_0
string dataobject = "d_date_current"
end type
global kds_current_datetime kds_current_datetime

forward prototypes
public function datetime u_get_current ()
end prototypes

public function datetime u_get_current ();//
datetime k_return


	if this.settrans(kguo_sqlca_db_magazzino) > 0 then
		if this.retrieve() > 0 then
			k_return = this.getitemdatetime(1, "k_current")	
		end if
	end if	

return k_return 

end function

on kds_current_datetime.create
call super::create
end on

on kds_current_datetime.destroy
call super::destroy
end on

