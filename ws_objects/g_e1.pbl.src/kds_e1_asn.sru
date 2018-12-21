$PBExportHeader$kds_e1_asn.sru
forward
global type kds_e1_asn from uo_datastore_0
end type
end forward

global type kds_e1_asn from uo_datastore_0
string dataobject = "ds_e1_asn_f5547014"
end type
global kds_e1_asn kds_e1_asn

type variables
//
public boolean ki_commit = false
private kuf_e1_conn_cfg kiuf_e1_conn_cfg

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public function st_esito db_commit ()
public function st_esito db_rollback ()
end prototypes

public function boolean db_connetti () throws uo_exception;//
boolean k_return = false


	//this.object.DataWindow.Table.Select = kiuf_e1_conn_cfg.u_sql_set_schema_nome(this.object.DataWindow.Table.Select)  //imposta sql con lo il nome schema giusto

	if kguo_sqlca_db_e1.db_connetti( ) then
		this.settransobject( kguo_sqlca_db_e1)

		k_return = true
	end if
	
return k_return

end function

public function st_esito db_commit ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_e1.db_commit( )

return kst_esito
end function

public function st_esito db_rollback ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_e1.db_rollback( )

return kst_esito

end function

on kds_e1_asn.create
call super::create
end on

on kds_e1_asn.destroy
call super::destroy
end on

event destructor;call super::destructor;//
	if isvalid(kiuf_e1_conn_cfg) then destroy kiuf_e1_conn_cfg

end event

event constructor;call super::constructor;//
	kiuf_e1_conn_cfg = create kuf_e1_conn_cfg		

end event

