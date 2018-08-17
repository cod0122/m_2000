$PBExportHeader$kds_db_magazzino.sru
forward
global type kds_db_magazzino from uo_datastore_0
end type
end forward

global type kds_db_magazzino from uo_datastore_0
end type
global kds_db_magazzino kds_db_magazzino

type variables
//
public boolean ki_commit = false
private kuf_db_cfg kiuf_db_cfg

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public function st_esito db_commit ()
public function st_esito db_rollback ()
end prototypes

public function boolean db_connetti () throws uo_exception;//
boolean k_return = false


//	this.object.DataWindow.Table.Select = kiuf_e1_conn_cfg.u_sql_set_schema_nome(this.object.DataWindow.Table.Select)  //imposta sql con lo il nome schema giusto

	if kguo_sqlca_db_magazzino.db_connetti( ) then
		this.settransobject( kguo_sqlca_db_magazzino)

		k_return = true
	end if
	
return k_return

end function

public function st_esito db_commit ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_magazzino.db_commit( )

return kst_esito
end function

public function st_esito db_rollback ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_magazzino.db_rollback( )

return kst_esito

end function

on kds_db_magazzino.create
call super::create
end on

on kds_db_magazzino.destroy
call super::destroy
end on

event destructor;call super::destructor;//
	if isvalid(kiuf_db_cfg) then destroy kiuf_db_cfg

end event

event constructor;call super::constructor;//
	kiuf_db_cfg = create kuf_db_cfg		

end event

