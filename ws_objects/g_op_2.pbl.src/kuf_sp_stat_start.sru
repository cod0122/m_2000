$PBExportHeader$kuf_sp_stat_start.sru
forward
global type kuf_sp_stat_start from nonvisualobject
end type
end forward

global type kuf_sp_stat_start from nonvisualobject
end type
global kuf_sp_stat_start kuf_sp_stat_start

type variables
//
public string ki_status
end variables

forward prototypes
public function integer u_esegui ()
public function integer u_esegui_u_m2000_avgtimeplant ()
end prototypes

public function integer u_esegui ();//
//--- Esecuzione della Stored Procedure MSSQL STATISTICI (DATAWHERHOUSE)
//--- Chiama la sp che scatena tutte le altre
//
int k_return
int k_rc

	ki_status = ""

	DECLARE u_m2000_0_start_stat PROCEDURE FOR
			@li_rc = dbo.u_m2000_0_start_stat
									@k_status varchar(8000) = :ki_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_0_start_stat;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		//ls_msg = SQLCA.SQLErrText
		k_return =  kguo_sqlca_db_magazzino.SQLCode
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_0_start_stat INTO :k_rc, :ki_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_0_start_stat;
	END IF

return k_return
end function

public function integer u_esegui_u_m2000_avgtimeplant ();//
//--- Esecuzione della Stored Procedure MSSQL STATISTICI (DATAWHERHOUSE)
//--- Chiama la sp che scatena tutte le altre
//
int k_return
int k_rc

	ki_status = ""

	DECLARE u_m2000_avgtimeplant PROCEDURE FOR
			@li_rc = dbo.u_m2000_avgtimeplant
									@k_status varchar(8000) = :ki_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_avgtimeplant;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		//ls_msg = SQLCA.SQLErrText
		k_return =  kguo_sqlca_db_magazzino.SQLCode
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_avgtimeplant INTO :k_rc, :ki_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_avgtimeplant;
	END IF
	
	kguo_sqlca_db_magazzino.db_commit( )

return k_return
end function

on kuf_sp_stat_start.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sp_stat_start.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

