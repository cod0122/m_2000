$PBExportHeader$kuf_meca_riapri.sru
forward
global type kuf_meca_riapri from kuf_parent
end type
end forward

global type kuf_meca_riapri from kuf_parent
end type
global kuf_meca_riapri kuf_meca_riapri

type variables

end variables

on kuf_meca_riapri.create
call super::create
end on

on kuf_meca_riapri.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- solo per autorizzazione a RIAPRIRE i Lotto 
//--- ovvero da CHIUSO o ANNULLATO a RIAPRI

ki_msgErrDescr="Riapertura Lotto"
end event

