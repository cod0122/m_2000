$PBExportHeader$kuf_meca_dosim_conv.sru
forward
global type kuf_meca_dosim_conv from kuf_parent
end type
end forward

global type kuf_meca_dosim_conv from kuf_parent
end type
global kuf_meca_dosim_conv kuf_meca_dosim_conv

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
boolean k_return 

kuf_meca_dosim kuf1_meca_dosim
kuf1_meca_dosim = create kuf_meca_dosim
k_return = kuf1_meca_dosim.if_sicurezza(ast_open_w)
destroy kuf1_meca_dosim

return k_return

end function

on kuf_meca_dosim_conv.create
call super::create
end on

on kuf_meca_dosim_conv.destroy
call super::destroy
end on

