$PBExportHeader$kuf_meca_stampa.sru
forward
global type kuf_meca_stampa from kuf_parent
end type
end forward

global type kuf_meca_stampa from kuf_parent
end type
global kuf_meca_stampa kuf_meca_stampa

type variables
//
private kuf_pdf kiuf_pdf 
end variables

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean u_stampa_reportpilota (st_tab_meca ast_tab_meca) throws uo_exception
public function boolean u_stampa (st_tab_meca ast_tab_meca) throws uo_exception
public function boolean u_stampa_completa (st_tab_meca ast_tab_meca) throws uo_exception
public subroutine u_add_stampa_pdf (string k_path_file)
public function boolean u_genera_pdf_completa (st_tab_meca ast_tab_meca) throws uo_exception
public subroutine u_inizializza_stampa_pdf ()
public function boolean u_add_stampa_pdf_reportpilota (st_tab_meca ast_tab_meca) throws uo_exception
public function boolean u_add_stampa_pdf_lotto (st_tab_meca ast_tab_meca) throws uo_exception
public function integer u_stampa_all_pdf () throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

public function boolean u_stampa_reportpilota (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Stampa documento pdf generato dal PILOTA (dati trattamenti barcode)
//--- 
//--- Input: st_tab_meca.id_meca
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_tab_meca_reportpilota kst_tab_meca_reportpilota
kuf_meca_reportpilota kuf1_meca_reportpilota


try
	
	kuf1_meca_reportpilota = create kuf_meca_reportpilota
	
	kst_tab_meca_reportpilota.id_meca = ast_tab_meca.id
	k_return = kuf1_meca_reportpilota.u_stampa(kst_tab_meca_reportpilota)
 

catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kuf1_meca_reportpilota) then destroy kuf1_meca_reportpilota

end try

return k_return
end function

public function boolean u_stampa (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Stampa dati Lotto
//--- 
//--- Input: st_tab_meca.id_meca
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_righe
//datastore kds_1
st_stampe kst_stampe
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kst_stampe.ds_print = create datastore
	//kds_1 = create datastore
	kst_stampe.ds_print.dataobject = "d_meca_1_print"
	kst_stampe.ds_print.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kst_stampe.ds_print.retrieve(ast_tab_meca.id) 
	if k_righe > 0 then
		kst_stampe.titolo = "Stampa Lotto id " + string(ast_tab_meca.id)
		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH 
		if kGuf_data_base.stampa_dw(kst_stampe) = 0 then
			k_return = true
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Stampa Lotto (id=" + string(ast_tab_meca.id) + ") non effettuata perchè non trovato" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
	end if

catch (uo_exception kuo_exception)
		throw kuo_exception
	
	
finally
//	if isvalid(kds_1) then destroy kds_1

end try

return k_return
end function

public function boolean u_stampa_completa (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Stampa dato Lotto + documento pdf generato dal PILOTA (dati trattamenti barcode)
//--- 
//--- Input: st_tab_meca.id
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then
		if u_stampa(ast_tab_meca) then
			if u_stampa_reportpilota(ast_tab_meca) then
				k_return = true
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Stampa Lotto non effettuata perchè ID non indicato" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally

end try

return k_return
end function

public subroutine u_add_stampa_pdf (string k_path_file);//

kiuf_pdf.u_add_file(k_path_file)


end subroutine

public function boolean u_genera_pdf_completa (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Genera pdf dei dati Lotto + documento pdf generato dal PILOTA (dati trattamenti barcode)
//--- 
//--- Input: st_tab_meca.id
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca.id > 0 then
		//--- aggiunge all'array ki_stampa_lotto[]: dati del Report Lotto 
		if u_add_stampa_pdf_lotto(ast_tab_meca) then
			k_return = true
		//--- aggiunge all'array ki_stampa_lotto[]:  Report Pilota
			if u_add_stampa_pdf_reportpilota(ast_tab_meca) then
			end if
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Stampa Lotto non effettuata perchè ID non indicato" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
	end if

catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally

end try

return k_return
end function

public subroutine u_inizializza_stampa_pdf ();//

if not isvalid(kiuf_pdf) then kiuf_pdf = create kuf_pdf

kiuf_pdf.u_inizializza()

end subroutine

public function boolean u_add_stampa_pdf_reportpilota (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Aggiunge all'array ki_stampa_lotto il PDF Report Pilota 
//--- 
//--- Input: st_tab_meca.id_meca
//--- out: 
//--- Rit: true x ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_nome_report //, k_nome_report_decripted
st_esito kst_esito
st_tab_meca_reportpilota kst_tab_meca_reportpilota
kuf_meca_reportpilota kuf1_meca_reportpilota


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kuf1_meca_reportpilota = create kuf_meca_reportpilota

//--- aggiunge all'array il percorso del Report Pilota
	kst_tab_meca_reportpilota.id_meca = ast_tab_meca.id
	k_nome_report = kuf1_meca_reportpilota.u_get_path_nomereport(kst_tab_meca_reportpilota)
	if trim(k_nome_report) > " " then
		u_add_stampa_pdf(k_nome_report)   // aggiunge all'array il nome del report 
	end if

catch (uo_exception kuo_exception)
		throw kuo_exception
	
	
finally
	if isvalid(kuf1_meca_reportpilota) then destroy kuf1_meca_reportpilota

end try

return k_return
end function

public function boolean u_add_stampa_pdf_lotto (st_tab_meca ast_tab_meca) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Aggiunge all'array ki_stampa_lotto il PDF dati Lotto  
//--- 
//--- Input: st_tab_meca.id_meca
//--- out: 
//--- Rit: true x ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_righe
st_stampe kst_stampe
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kst_stampe.ds_print = create datastore
	
	//kds_1 = create datastore
	kst_stampe.ds_print.dataobject = "d_meca_1_print"
	kst_stampe.ds_print.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kst_stampe.ds_print.retrieve(ast_tab_meca.id)   // genera il Report con i dati del Lotto
	if k_righe > 0 then
		//kguo_path.u_drectory_create(k_path_all[k_npath])
		kst_stampe.pathfile = kguo_path.get_temp( ) + KKG.PATH_SEP + "Lotto" + string(ast_tab_meca.id) + ".pdf"
		kst_stampe.titolo = "Stampa Lotto id " + string(ast_tab_meca.id)
		//		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH //mette il Report nella TEMP //ki_stampa_tipo_datastore_diretta_BATCH 
				//if kGuf_data_base.stampa_dw(kst_stampe) = 0 then
		kst_stampe.ds_print.object.DataWindow.Export.PDF.Method = NativePDF!
		if kst_stampe.ds_print.saveas(kst_stampe.pathfile, PDF!, false) < 0 then
		else	
			u_add_stampa_pdf(kst_stampe.pathfile)   // aggiunge all'array il nome del report generato
			k_return = true
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Stampa Lotto (id=" + string(ast_tab_meca.id) + ") non effettuata perchè non trovato" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
	end if



catch (uo_exception kuo_exception)
		throw kuo_exception
	
	
finally

end try

return k_return
end function

public function integer u_stampa_all_pdf () throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Esegue la Stampa dei pdf accumulati nell'oggetto kuf_pdf
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero di documenti stampati
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return 


try

	k_return = kiuf_pdf.u_print_pdf()
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
end try

return k_return
end function

on kuf_meca_stampa.create
call super::create
end on

on kuf_meca_stampa.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiuf_pdf) then destroy kiuf_pdf

end event

