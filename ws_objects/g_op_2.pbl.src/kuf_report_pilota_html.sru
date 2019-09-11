$PBExportHeader$kuf_report_pilota_html.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_pilota_html from kuf_parent
end type
end forward

global type kuf_report_pilota_html from kuf_parent
end type
global kuf_report_pilota_html kuf_report_pilota_html

type variables
//
private kuf_pilota_previsioni kiuf_pilota_previsioni
private string ki_path_report_export_dir

end variables

forward prototypes
public subroutine _readme ()
public function st_esito u_batch_run () throws uo_exception
private function string u_coda_pilota_crea_report_html () throws uo_exception
private function string u_programmazione_crea_report_html () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Report dati PILOTA insieme ai dati di M2000 da esportare in HTML
//
end subroutine

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
string k_string, k_string1
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "" 
	kst_esito.nome_oggetto = this.classname()

//--- Genera archivi STATISTICI
	k_string = u_coda_pilota_crea_report_html( ) 
	k_string1 = u_programmazione_crea_report_html( ) 
	if len(trim(k_string + k_string1)) > 0 then
		kst_esito.SQLErrText = "Operazione conclusa. " + k_string + " - " + k_string1
	else
		kst_esito.SQLErrText = "Operazione non eseguita. Nessun Report esportato."
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

private function string u_coda_pilota_crea_report_html () throws uo_exception;//---
//--- Genera il REPORT in HTML
//---
// 
long k_righe=0, k_rc
string k_file, k_return
datastore kds_1 


	try 
		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni
		
		k_righe = kiuf_pilota_previsioni.get_ds_barcode_in_lav_prev( ) 
		if k_righe > 0 then
		
			kds_1 = create datastore
			kds_1.dataobject = "d_report_2_pilota_queue_table_html" 
			
			kguf_data_base.u_set_ds_change_name_tab(kds_1, "vx_MAST_pilota_pallet_workqueue")
			kds_1.settransobject(kguo_sqlca_db_magazzino)

			k_righe = kds_1.retrieve()
			
			k_file = ki_path_report_export_dir + kkg.path_sep + "pilota_coda_impianto.html"
			
			kds_1.saveas(k_file, HTMLTable!, true, EncodingUTF8!)
			
		end if
		

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	finally
		if k_righe > 0 then
			k_return = "Prodotto il file " + k_file + " di " + string(k_righe)
		else
			k_return = "Prodotto il file " + k_file + " vuoto! "
		end if
		
	end try
	
return k_return
end function

private function string u_programmazione_crea_report_html () throws uo_exception;//---
//--- Genera il REPORT in HTML
//---
// 
long k_righe=0, k_rc
string k_file, k_return
datastore kds_1 


	try 
		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni
		
		k_righe = kiuf_pilota_previsioni.get_ds_barcode_in_lav_prev( ) 
		if k_righe > 0 then
		
			kds_1 = create datastore
			kds_1.dataobject = "d_report_3_pilota_pallet_in_lav" 
			
			kguf_data_base.u_set_ds_change_name_tab(kds_1, "vx_MAST_pilota_pallet_workqueue")
			kds_1.settransobject(kguo_sqlca_db_magazzino)

			k_righe = kds_1.retrieve()
			
			k_file = ki_path_report_export_dir + kkg.path_sep + "pilota_programmazione_impianto.html"
			
			kds_1.saveas(k_file, HTMLTable!, true, EncodingUTF8!)
			
		end if
		

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		if k_righe > 0 then
			k_return = "Prodotto il file " + k_file + " di " + string(k_righe)
		else
			k_return = "Prodotto il file " + k_file + " vuoto! "
		end if
		
	end try
	
return k_return
end function

on kuf_report_pilota_html.create
call super::create
end on

on kuf_report_pilota_html.destroy
call super::destroy
end on

event destructor;//
	if isvalid(kiuf_pilota_previsioni) then destroy kiuf_pilota_previsioni 

end event

event constructor;//
kuf_base kuf1_base
string k_esito=""


	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "report_export_dir")
	if left(k_esito,1) = "0" then
		if trim(mid(k_esito,2)) > " " then
			ki_path_report_export_dir = trim(mid(k_esito,2))
		else
			ki_path_report_export_dir = kguo_path.get_base( )
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			kguo_exception.kist_esito.esito = kkg_esito.not_fnd 
			kguo_exception.kist_esito.sqlcode = 0
			kguo_exception.kist_esito.SQLErrText = "Manca la cartella di esportazione Report in Proprietà della Procedura: ora esporta in " + ki_path_report_export_dir
			kguo_exception.scrivi_log( )
		end if
	else
		ki_path_report_export_dir = kguo_path.get_base( )
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.kist_esito.esito = kkg_esito.db_ko 
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.SQLErrText = "Errore di accesso al DB, per leggere la cartella di esportazione Report in Proprietà della Procedura: ora esporta in " + ki_path_report_export_dir
		kguo_exception.scrivi_log( )
	end if
	destroy kuf1_base

end event

