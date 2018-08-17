$PBExportHeader$kdsp_update_stat.sru
forward
global type kdsp_update_stat from kds_db_magazzino
end type
end forward

global type kdsp_update_stat from kds_db_magazzino
string dataobject = "dsp_update_stat"
end type
global kdsp_update_stat kdsp_update_stat

forward prototypes
public function boolean db_connetti () throws uo_exception
end prototypes

public function boolean db_connetti () throws uo_exception;//
boolean k_return = false


//	this.object.DataWindow.Table.Select = kiuf_e1_conn_cfg.u_sql_set_schema_nome(this.object.DataWindow.Table.Select)  //imposta sql con lo il nome schema giusto

	if kguo_sqlca_db_magazzino.db_connetti( ) then
		this.settrans( kguo_sqlca_db_magazzino)

		k_return = true
	end if
	
return k_return

end function

on kdsp_update_stat.create
call super::create
end on

on kdsp_update_stat.destroy
call super::destroy
end on

