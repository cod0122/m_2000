$PBExportHeader$kuf_stat_batch.sru
forward
global type kuf_stat_batch from kuf_parent
end type
end forward

global type kuf_stat_batch from kuf_parent
end type
global kuf_stat_batch kuf_stat_batch

forward prototypes
public function string run_stat_0_batch () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function string run_stat_0_batch () throws uo_exception;//
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
	k_rc = kuf1_sp_stat_start.u_esegui( )
//	kdsp1_stat_start = create kdsp_stat_start 
//	kdsp1_stat_start.db_connetti()
//	k_rc = kdsp1_stat_start.retrieve( )
//	if k_rc > 0 then
	k_esito = trim(kuf1_sp_stat_start.ki_status)
		//k_esito = kdsp1_stat_start.getitemstring( 1, "esito")
//	end if			

	if k_rc < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = -1
		kst_esito.sqlerrtext = "Errore in Generazione Statistici: '" &
									  + k_esito + "': esito " + string (k_rc) 
	else
		if k_rc = 0 then
			kst_esito.esito = kkg_esito.ko
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Anomalia in generazione Statistici ' " &
										  + k_esito + " Nessun dato estratto! "
		else
			kst_esito.esito = kkg_esito.ok
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Generazione Statistici terminata correttamente: " + k_esito

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

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
string k_string
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Genera archivi STATISTICI
	k_string = run_stat_0_batch( ) 
	if len(trim(k_string)) > 0 then
		kst_esito.SQLErrText = "Operazione conclusa. " + k_string
	else
		kst_esito.SQLErrText = "Operazione non eseguita. Nessun archivio Statistici generato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_stat_batch.create
call super::create
end on

on kuf_stat_batch.destroy
call super::destroy
end on

