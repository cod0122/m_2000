$PBExportHeader$kuf_folder_open.sru
forward
global type kuf_folder_open from kuf_parent
end type
end forward

global type kuf_folder_open from kuf_parent
end type
global kuf_folder_open kuf_folder_open

forward prototypes
public subroutine _readme ()
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public subroutine _readme ();//--- Open folder with EXPLORER

end subroutine

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
string k_x

	
	k_x = trim(adw_link.getitemstring(adw_link.getrow(),a_campo_link))
	if Run("explorer /e,~"" + k_x + "~"", Normal!) = 1 then
		return true
	else
		return false
	end if
	


end function

on kuf_folder_open.create
call super::create
end on

on kuf_folder_open.destroy
call super::destroy
end on

