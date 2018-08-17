$PBExportHeader$kuf_meca_armo_pt.sru
forward
global type kuf_meca_armo_pt from kuf_parent
end type
end forward

global type kuf_meca_armo_pt from kuf_parent
end type
global kuf_meca_armo_pt kuf_meca_armo_pt

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return
kuf_armo kuf1_armo


kuf1_armo = create kuf_armo

k_return = kuf1_armo.if_sicurezza(ast_open_w)

destroy kuf1_armo

return k_return
 
end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
boolean k_return
kuf_armo kuf1_armo


kuf1_armo = create kuf_armo

k_return = kuf1_armo.if_sicurezza(aflag_modalita)

destroy kuf1_armo

return k_return

end function

on kuf_meca_armo_pt.create
call super::create
end on

on kuf_meca_armo_pt.destroy
call super::destroy
end on

