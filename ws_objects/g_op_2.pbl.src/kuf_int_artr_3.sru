$PBExportHeader$kuf_int_artr_3.sru
forward
global type kuf_int_artr_3 from kuf_int_artr
end type
end forward

global type kuf_int_artr_3 from kuf_int_artr
end type
global kuf_int_artr_3 kuf_int_artr_3

type variables

end variables

on kuf_int_artr_3.create
call super::create
end on

on kuf_int_artr_3.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_st_int_artr.report_start = this.kki_scelta_report_in_trattamento
ki_st_int_artr.report_autorefresh_min = 3

end event

