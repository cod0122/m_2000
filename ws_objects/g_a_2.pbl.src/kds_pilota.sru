$PBExportHeader$kds_pilota.sru
forward
global type kds_pilota from uo_datastore_0
end type
end forward

global type kds_pilota from uo_datastore_0
end type
global kds_pilota kds_pilota

type variables
//
public boolean ki_commit = false
//private kuf_e1_conn_cfg kiuf_e1_conn_cfg

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public function st_esito db_commit ()
public function st_esito db_rollback ()
public function boolean db_disconnetti () throws uo_exception
end prototypes

public function boolean db_connetti () throws uo_exception;//
boolean k_return = false


	if kguo_sqlca_db_pilota.db_connetti( ) then
		//this.settransobject( kguo_sqlca_db_pilota)  // questo tipo si connessione blocca il PILOTA
		if this.settrans(kguo_sqlca_db_pilota) > 0 then  // connessione-disconnessione in automatico 
			k_return = true
		end if
	end if
	
return k_return

end function

public function st_esito db_commit ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_pilota.db_commit( )

return kst_esito
end function

public function st_esito db_rollback ();//
st_esito kst_esito

	kst_esito = kguo_sqlca_db_pilota.db_rollback( )

return kst_esito

end function

public function boolean db_disconnetti () throws uo_exception;//
boolean k_return = true


	k_return = kguo_sqlca_db_pilota.db_disconnetti( )
	
return k_return

end function

on kds_pilota.create
call super::create
end on

on kds_pilota.destroy
call super::destroy
end on

