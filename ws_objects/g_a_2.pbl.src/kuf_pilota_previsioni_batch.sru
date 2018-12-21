$PBExportHeader$kuf_pilota_previsioni_batch.sru
forward
global type kuf_pilota_previsioni_batch from kuf_parent
end type
end forward

global type kuf_pilota_previsioni_batch from kuf_parent
end type
global kuf_pilota_previsioni_batch kuf_pilota_previsioni_batch

type variables
private string ki_status

end variables
forward prototypes
public function st_esito u_batch_run () throws uo_exception
private function integer u_esegui_u_m2000_avgtimeplant ()
private function string batch_run_stat_u_m2000_avgtimeplant () throws uo_exception
end prototypes

public function st_esito u_batch_run () throws uo_exception;//
st_esito kst_esito 


try	

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
		
	kst_esito.sqlerrtext =  batch_run_stat_u_m2000_avgtimeplant( )
		

catch(uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally

end try

return kst_esito
end function

private function integer u_esegui_u_m2000_avgtimeplant ();//
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

private function string batch_run_stat_u_m2000_avgtimeplant () throws uo_exception;//
string k_return = ""
string k_esito = ""
integer k_rc
st_esito kst_esito
st_errori_gestione kst_errori_gestione
//kdsp_stat_start kdsp1_stat_start
kuf_sp_stat_start kuf1_sp_stat_start

try	

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

//--- lancio spl (datastore)
	kuf1_sp_stat_start = create kuf_sp_stat_start
	k_rc = u_esegui_u_m2000_avgtimeplant( )
	k_esito = trim(ki_status)

	if k_rc < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = -1
		kst_esito.sqlerrtext = "Errore in Generazione dati Tempi Medi Giri Impianto: '" &
									  + k_esito + "': esito " + string (k_rc) 
	else
		if k_rc = 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Anomalia in generazione dati Tempi Medi Giri Impianto ' " &
										  + k_esito + " Nessun dato estratto! "
		else
			kst_esito.esito = kkg_esito.ok
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Generazione dati Tempi Medi Giri Impianto terminata correttamente: " + k_esito

		end if
	end if
//			if left(k_esito,2) <> "Ok" then
//				kst_esito.esito = kkg_esito.ko
//				kst_esito.sqlcode = 0
//				kst_esito.sqlerrtext = "Anomalie in generazione Statistici ' " &
//											  + trim(kdsp1_stat_start.dataobject) + "' err.:" + trim(k_esito)
//			else
//			end if

//--- scrive l'errore su LOG
	kst_errori_gestione.esito = kst_esito.esito
	kst_errori_gestione.nome_oggetto = this.classname()
	kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
	kst_errori_gestione.sqlerrtext = trim(kst_esito.SQLErrText)
	kst_errori_gestione.sqldbcode = kst_esito.sqlcode
	kst_errori_gestione.sqlca = kguo_sqlca_db_magazzino
	kGuf_data_base.errori_gestione(kst_errori_gestione)
				
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally
//	if isvalid(kdsp1_stat_start) then destroy kdsp1_stat_start
	if isvalid(kuf1_sp_stat_start) then destroy kuf1_sp_stat_start
	
	k_return = kst_esito.sqlerrtext 

end try

return k_return

end function

on kuf_pilota_previsioni_batch.create
call super::create
end on

on kuf_pilota_previsioni_batch.destroy
call super::destroy
end on

