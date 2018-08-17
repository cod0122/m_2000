$PBExportHeader$kuf_menu_tree.sru
forward
global type kuf_menu_tree from kuf_parent
end type
end forward

global type kuf_menu_tree from kuf_parent
end type
global kuf_menu_tree kuf_menu_tree

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine _readme ()
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

public subroutine _readme ();//
//--- sostituisce il menu toolbar
//

end subroutine

on kuf_menu_tree.create
call super::create
end on

on kuf_menu_tree.destroy
call super::destroy
end on

