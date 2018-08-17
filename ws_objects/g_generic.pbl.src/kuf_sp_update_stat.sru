$PBExportHeader$kuf_sp_update_stat.sru
forward
global type kuf_sp_update_stat from nonvisualobject
end type
end forward

global type kuf_sp_update_stat from nonvisualobject
end type
global kuf_sp_update_stat kuf_sp_update_stat

type variables
//
public string ki_status
end variables

forward prototypes
public function integer u_esegui ()
end prototypes

public function integer u_esegui ();//
//--- Esecuzione della Stored Procedure MSSQL UPDATE INDICI STATISTICI 
//--- Chiama la sp 
//
int k_return
int k_rc

	ki_status = ""

	DECLARE u_m2000_update_stat PROCEDURE FOR
			@li_rc = dbo.u_m2000_update_stat
									@k_status varchar(100) = :ki_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_update_stat;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		//ls_msg = SQLCA.SQLErrText
		k_return =  kguo_sqlca_db_magazzino.SQLCode
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_update_stat INTO :k_rc, :ki_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_update_stat;
	END IF

return k_return
end function

on kuf_sp_update_stat.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sp_update_stat.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

