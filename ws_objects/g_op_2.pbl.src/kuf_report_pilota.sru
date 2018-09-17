$PBExportHeader$kuf_report_pilota.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_pilota from nonvisualobject
end type
end forward

global type kuf_report_pilota from nonvisualobject
end type
global kuf_report_pilota kuf_report_pilota

type variables
//
private string ki_ds_pilota_prev_lav_dataobject = "d_report_24_pilota_prev_lav"
private string ki_temptab_pilota_prev_lav 

private datastore kids_d_report_24_pilota_prev_lav



end variables

forward prototypes
public subroutine _readme ()
public function datastore set_ds_report_24_pilota_prev_lav () throws uo_exception
private function long u_set_ds_report_24_pilota_prev_lav () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Report dati PILOTA insieme ai dati di M2000
//
end subroutine

public function datastore set_ds_report_24_pilota_prev_lav () throws uo_exception;//---
//--- Legge i barcode in lavoraz. e programmazione nel PILOTA calcola previsione di inizio e fine lav per Lotto
//---
// 
int k_rc, k_ctr
long k_rows
string k_sql_orig, k_string, k_stringn
kuf_pilota_previsioni kuf1_pilota_previsioni 

try 
	
	if not isvalid(kids_d_report_24_pilota_prev_lav) then
		kids_d_report_24_pilota_prev_lav = create datastore
		kids_d_report_24_pilota_prev_lav.dataobject = ki_ds_pilota_prev_lav_dataobject

		k_sql_orig = kids_d_report_24_pilota_prev_lav.Object.DataWindow.Table.Select 

		kuf1_pilota_previsioni = create kuf_pilota_previsioni
		ki_temptab_pilota_prev_lav = kuf1_pilota_previsioni.get_ki_temptab_pilota_prev_lav( )
		k_stringn = ki_temptab_pilota_prev_lav //string(kguo_utente.get_id_utente( ))
		
		kguf_data_base.u_set_ds_change_name_tab(kids_d_report_24_pilota_prev_lav, "vx_MAST_pilota_prev_lav")
			
		k_rc = kids_d_report_24_pilota_prev_lav.settransobject(kguo_sqlca_db_magazzino)
		if k_rc < 0 then
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in connessione per previsione data inizio-fine lavorazione barcode in impianto per Lotto. Il server di Magazzino sembra non rispondere. Operazione Interrotta!"
			throw kguo_exception
		end if
	end if
	
	u_set_ds_report_24_pilota_prev_lav( )

catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_24_pilota_prev_lav
end function

private function long u_set_ds_report_24_pilota_prev_lav () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Popola ds data inizio-fine lavorazione previste x Lotto
//---
//----------------------------------------------------------------------------------------
//
//
long k_righe=0

 	
	try

		k_righe = kids_d_report_24_pilota_prev_lav.retrieve( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

on kuf_report_pilota.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_report_pilota.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
	if isvalid(kids_d_report_24_pilota_prev_lav) then destroy kids_d_report_24_pilota_prev_lav 

end event

