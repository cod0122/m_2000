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
private string ki_stampa_pdf[]
private int ki_stampa_pdf_idx

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
public function integer u_stampa_stampa_pdf () throws uo_exception
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
//int k_ind 

//k_ind=upperbound(ki_stampa_pdf) 
//k_ind ++
ki_stampa_pdf_idx ++
ki_stampa_pdf[ki_stampa_pdf_idx] = k_path_file

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
string k_stampa_pdf_vuota[]

//--- riporta il path nella directory di base (es. c:\at_m2000)
kGuf_data_base.setta_path_default ()

ki_stampa_pdf_idx = 0
ki_stampa_pdf[] = k_stampa_pdf_vuota[]


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
//kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//	kuf1_utility = create kuf_utility
	kuf1_meca_reportpilota = create kuf_meca_reportpilota

//--- aggiunge all'array il percorso del Report Pilota
	kst_tab_meca_reportpilota.id_meca = ast_tab_meca.id
	k_nome_report = kuf1_meca_reportpilota.u_get_path_nomereport(kst_tab_meca_reportpilota)
	if trim(k_nome_report) > " " then
		u_add_stampa_pdf(k_nome_report)   // aggiunge all'array il nome del report 
//		//--- il Report Pilota deve essere 'decriptato' anche se non ne capisco il motivo, quindo lo copio nella TEMP
//		k_nome_report_decripted = kguo_path.get_temp( ) + KKG.PATH_SEP + kst_tab_meca_reportpilota.nomereport
//		if kuf1_utility.u_pdf_decrypt(k_nome_report, k_nome_report_decripted) then
//			u_add_stampa_pdf(k_nome_report_decripted)   // aggiunge all'array il nome del report generato
//		end if
	end if

catch (uo_exception kuo_exception)
		throw kuo_exception
	
	
finally
	if isvalid(kuf1_meca_reportpilota) then destroy kuf1_meca_reportpilota
//	if isvalid(kuf1_utility) then destroy kuf1_utility

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

public function integer u_stampa_stampa_pdf () throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Esegue la Stampa dei pdf indicati nell'array  instance:  ki_stampa_pdf[]
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero di documenti stampati
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return 
int k_nr_doc, k_ind, k_nr_doc_printed
string k_nome_pdf_out //k_stampe
st_esito kst_esito
kuf_utility kuf1_utility
kuf_file_explorer kuf1_file_explorer


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_utility = create kuf_utility

	if ki_stampa_pdf_idx > upperbound(ki_stampa_pdf) then
		k_nr_doc = upperbound(ki_stampa_pdf)  // Mooolto strano questa sforamento della tabella!!!
		kguo_exception.inizializza()
		kguo_exception.kist_esito = kst_esito
		kguo_exception.kist_esito.SQLErrText = "Stampa PDF, indice interno " + string(ki_stampa_pdf_idx) + " stranamente maggiore della tabella " + string(k_nr_doc) + " !!! Non blocco l'esecuzione."
		kguo_exception.kist_esito.esito = kkg_esito_ko
	else
		k_nr_doc = ki_stampa_pdf_idx
	end if
			
//	if k_nr_doc > 0 then 
//	
////--- Unisce i PDF dell'array
//		k_nome_pdf_out = kguo_path.get_temp( ) + KKG.PATH_SEP + "FileProdotto_"+string(kguo_g.get_datetime_current( ) ,"yyyymmdd_hhmmss") +".pdf"
//		k_nr_doc_printed = kuf1_utility.u_pdf_merge( ki_stampa_pdf, k_nome_pdf_out)	
		
	for k_ind = 1 to k_nr_doc
		try
			if ki_stampa_pdf[k_ind] > " " then
	//			k_stampe += ki_stampa_pdf[k_ind] + " "
				sleep(1)
				if kuf1_utility.u_print_file(ki_stampa_pdf[k_ind]) then
					k_nr_doc_printed ++
				else
//--- non blocca l'esecuzione ma segnala nel log		
					kst_esito.esito = kkg_esito.no_esecuzione
					kst_esito.sqlerrtext = "Stampa del file '" + ki_stampa_pdf[k_ind] + "' non effettuata,~n~r" & 
						+ "verificare se il file è corretto opresente." 
				end if
			end if
		catch (uo_exception kuo_exception)
//--- non blocca l'esecuzione ma segnala nel log		
			kst_esito = kuo_exception.kist_esito
		end try
	end for

//--- Segnala solo nel log		
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		kguo_exception.scrivi_log( )
	end if

//	if trim(k_stampe) > " " then
//		kuf1_file_explorer = create kuf_file_explorer
//		if kuf1_file_explorer.of_execute("pdftk " + k_stampe + " output " +  kguo_path.get_temp( ) + KKG.PATH_SEP + ) then
	
//		if k_nr_doc_printed > 0 then
//			sleep(1)
//			if kuf1_utility.u_print_file(k_nome_pdf_out) then
//				k_return = k_nr_doc_printed
//			else
//				kst_esito.esito = kkg_esito.no_esecuzione
//				kst_esito.sqlerrtext = "Stampa del file '" + k_nome_pdf_out + "' non effettuata,~n~r" & 
//					+ "verificare se il file è corretto." 
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito(kst_esito)
//				throw kguo_exception
//			end if
//		end if
//	end if
	
catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
	
	k_return = k_nr_doc_printed
	
end try

return k_return
end function

on kuf_meca_stampa.create
call super::create
end on

on kuf_meca_stampa.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- solo per autorizzazione a RIAPRIRE i Lotto 
//--- ovvero da CHIUSO o ANNULLATO a RIAPRI

ki_msgErrDescr="Riapertura Lotto"
end event

