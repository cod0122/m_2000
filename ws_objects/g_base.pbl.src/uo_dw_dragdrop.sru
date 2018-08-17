$PBExportHeader$uo_dw_dragdrop.sru
forward
global type uo_dw_dragdrop from uo_d_std_1
end type
end forward

global type uo_dw_dragdrop from uo_d_std_1
integer width = 1970
integer height = 736
boolean enabled = true
string dataobject = "d_dragdrp_info"
boolean border = true
boolean hsplitscroll = false
boolean livescroll = false
borderstyle borderstyle = stylelowered!
event u_dropfiles pbm_dropfiles
end type
global uo_dw_dragdrop uo_dw_dragdrop

type variables
//
private kuf_file_dragdrop kiuf_file_dragdrop

end variables

event u_dropfiles;//
string k_file_drop[], k_modalita_descr
int k_file_nr=0


k_file_nr = kiuf_file_dragdrop.u_get_file(kiuf_file_dragdrop.kki_tipo_drag_dragdrop, handle, k_file_drop[])

//if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
//	messagebox("Operazione fermata", "Prima di caricare gli allegati, salvare questo MEMO", stopsign!) 
//else
//	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
//		u_add_memo_link(k_file_drop[], k_file_nr)  // carica i file in archivio
//	else
//		k_modalita_descr = kguo_g.get_descrizione( ki_st_open_w.flag_modalita)
//		messagebox("Operazione non Permessa", "Solo in 'Modifica' è possibile caricare gli Allegati, sei invece in modalità '" + k_modalita_descr + "' ", stopsign!) 
//	end if
//end if


return k_file_nr



end event

on uo_dw_dragdrop.create
call super::create
end on

on uo_dw_dragdrop.destroy
call super::destroy
end on

event constructor;call super::constructor;//
	kiuf_file_dragdrop = create kuf_file_dragdrop 

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	kiuf_file_dragdrop.u_attiva(handle(this) )

end event

