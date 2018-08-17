$PBExportHeader$kuf_meca_causali_blk_m.sru
forward
global type kuf_meca_causali_blk_m from kuf_parent
end type
end forward

global type kuf_meca_causali_blk_m from kuf_parent
end type
global kuf_meca_causali_blk_m kuf_meca_causali_blk_m

type variables
//
//--- Questo oggetto serve x abilitare lo sblocco del Lotto per 'RICH_ATORIZZ = M'   (materiale medicale)
//
public string ki_rich_autorizz_Materiale_Medicale = 'M'
end variables

on kuf_meca_causali_blk_m.create
call super::create
end on

on kuf_meca_causali_blk_m.destroy
call super::destroy
end on

