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
private string ki_ds_pilota_pallet_in_lav_dataobject = "d_report_3_pilota_pallet_in_lav"
private string ki_ds_pilota_queue_dataobject = "d_report_2_pilota_queue_table"
private string ki_ds_pilota_prev_lav_dataobject = "d_report_24_pilota_prev_lav"

private string ki_ds_pilota_fila_in_lav_dataobject = "ds_report_3_pilota_fila_in_lav"
private string ki_ds_queue_lav_xfila_dataobject = "ds_queue_lav_xfila"

private string ki_temptab_pilota_prev_lav 

private datastore kids_d_report_3_pilota_pallet_in_lav
private datastore kids_ds_report_3_pilota_fila_in_lav
private datastore kids_ds_queue_lav_xfila
private datastore kids_barcode_avgtimeplant

private datastore kids_d_report_2_pilota_queue_table

private datastore kids_d_report_24_pilota_prev_lav


private kuf_utility kiuf_utility


end variables

forward prototypes
public subroutine _readme ()
private function long u_set_dati_barcode (ref datastore kds_1) throws uo_exception
private function long u_set_dati_clie (ref datastore kds_1) throws uo_exception
private function long u_set_dati_meca (ref datastore kds_1) throws uo_exception
private function long u_set_dati_barcode_figlio (ref datastore kds_1) throws uo_exception
private function long u_set_dati_note (ref datastore kds_1) throws uo_exception
public function datastore set_ds_report_24_pilota_prev_lav () throws uo_exception
private function string u_get_fila (st_tab_barcode kst_tab_barcode) throws uo_exception
private function long u_set_ds_report_24_pilota_prev_lav () throws uo_exception
private function long u_set_id_meca (ref datastore kds_1) throws uo_exception
public subroutine set_ds_report_3_pilota_pallet_in_lav (ref datastore kds_1) throws uo_exception
public subroutine set_ds_report_2_pilota_queue_prev (ref datastore kds_1) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Report dati PILOTA insieme ai dati di M2000
//
end subroutine

private function long u_set_dati_barcode (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati del barcode al ds
//======================================================================
//
long k_righe=0, k_riga=0, k_colli=0, k_colli_tr=0
date k_data
st_tab_barcode kst_tab_barcode, kst_tab_barcode_app

	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe
			
			kds_1.object.k_colli[k_riga] = "" 
			
			kst_tab_barcode.barcode = kds_1.object.barcode[k_riga]
			kst_tab_barcode.id_meca = kds_1.object.id_meca[k_riga] 

			if kst_tab_barcode.id_meca > 0 and kst_tab_barcode.id_meca <> kst_tab_barcode_app.id_meca then
				
				kst_tab_barcode_app.id_meca = kst_tab_barcode.id_meca

				select count(*)
						into :k_colli
						from barcode
						where barcode.id_meca = :kst_tab_barcode.id_meca
						using kguo_sqlca_db_magazzino;
						
				if isnull(k_colli) then k_colli = 0
					
				k_data = kkg.data_no
				select count(*)
						into :k_colli_tr
						from barcode
						where barcode.id_meca = :kst_tab_barcode.id_meca and barcode.data_lav_fin > :k_data 
						using kguo_sqlca_db_magazzino;
				if isnull(k_colli_tr) then k_colli_tr = 0
					
			end if
			
			if k_colli > 0 then
				kds_1.object.k_colli[k_riga] = trim(string(k_colli_tr)) + " . " + trim(string(k_colli)) 
			end if
	
		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_dati_clie (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati cliente ds
//======================================================================
//
//
long k_righe=0, k_riga=0, k_colli=0, k_colli_tr=0
date k_data
st_tab_clienti kst_tab_clienti, kst_tab_clienti_app

	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe

			kds_1.object.k_rag_soc_10[k_riga] = ""
			
			kst_tab_clienti.codice = kds_1.object.k_clie_2[k_riga]

			if kst_tab_clienti.codice > 0 and kst_tab_clienti.codice <> kst_tab_clienti_app.codice then
				kst_tab_clienti_app.codice = kst_tab_clienti.codice
		
				select distinct
						clienti.rag_soc_10
					into
						:kst_tab_clienti.rag_soc_10
					from clienti
					where clienti.codice = :kst_tab_clienti.codice
					using kguo_sqlca_db_magazzino;
					
			end if
		
			if kst_tab_clienti.codice > 0 then
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					if trim(kst_tab_clienti.rag_soc_10) > " " then
						kds_1.object.k_rag_soc_10[k_riga] = kst_tab_clienti.rag_soc_10
					end if
				end if
			end if
			
		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_dati_meca (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati MECA al ds
//======================================================================
//
//
long k_righe=0, k_riga=0, k_colli=0, k_colli_tr=0
st_tab_meca kst_tab_meca, kst_tab_meca_app

	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe

			kst_tab_meca.id = kds_1.object.id_meca[k_riga]
			if kst_tab_meca.id > 0 and kst_tab_meca.id <> kst_tab_meca_app.id then
				kst_tab_meca_app.id = kst_tab_meca.id
			
				select distinct
						meca.clie_2
						,meca.id
						,meca.num_int
						,meca.data_int
						,meca.area_mag
						,meca.consegna_data
					into
						:kst_tab_meca.clie_2
						,:kst_tab_meca.id
						,:kst_tab_meca.num_int
						,:kst_tab_meca.data_int
						,:kst_tab_meca.area_mag
						,:kst_tab_meca.consegna_data
					from meca 
					where meca.id = :kst_tab_meca.id
					using kguo_sqlca_db_magazzino;
			end if
			if kst_tab_meca.id > 0 then
				if kguo_sqlca_db_magazzino.sqlcode = 0 then

					if kst_tab_meca.clie_2 > 0 then
						kds_1.object.k_clie_2[k_riga] = kst_tab_meca.clie_2
					end if
					if kst_tab_meca.num_int > 0 then
						kds_1.object.num_int[k_riga] = kst_tab_meca.num_int
					end if
					if not isnull(kst_tab_meca.data_int) then
						kds_1.object.data_int[k_riga] = kst_tab_meca.data_int
					end if
					if not isnull(kst_tab_meca.consegna_data) then
						kds_1.object.k_consegna_data[k_riga] = kst_tab_meca.consegna_data
					end if
	
				end if
			end if
			
		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_dati_barcode_figlio (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati del barcode figlio al ds
//======================================================================
//
long k_righe=0, k_riga=0
st_tab_meca kst_tab_meca_figlio, kst_tab_meca_app_figlio
st_tab_barcode kst_tab_barcode_figlio
st_tab_clienti kst_tab_clienti_figlio

	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe

//--- get dati barcode figlio
			kst_tab_meca_figlio.clie_2 = 0
			kst_tab_barcode_figlio.barcode = trim(kds_1.object.barcode_figlio[k_riga])
			if kst_tab_barcode_figlio.barcode > " " then
				select distinct
						barcode.id_meca
					into
						:kst_tab_meca_figlio.id
					from barcode
					where barcode.barcode = :kst_tab_barcode_figlio.barcode 
					using kguo_sqlca_db_magazzino;
	
	
				if kst_tab_meca_figlio.id <> kst_tab_meca_app_figlio.id then
					kst_tab_meca_app_figlio.id = kst_tab_meca_figlio.id
				
					select distinct
								meca.clie_2
								,clienti.rag_soc_10
						into
								:kst_tab_meca_figlio.clie_2
								,:kst_tab_clienti_figlio.rag_soc_10
						from 
							  meca inner join clienti on
								 meca.clie_2 = clienti.codice 
						where meca.id = :kst_tab_meca_figlio.id 
						using kguo_sqlca_db_magazzino;
			
					if kguo_sqlca_db_magazzino.sqlcode = 0 then
					else
						kst_tab_clienti_figlio.rag_soc_10 = trim(kguo_sqlca_db_magazzino.sqlerrtext)
					end if
				end if
			end if
			if trim(kst_tab_clienti_figlio.rag_soc_10) > " " then
			else
				kst_tab_clienti_figlio.rag_soc_10 = ""
			end if
			
			if kst_tab_meca_figlio.id > 0 then
			
				if kst_tab_meca_figlio.clie_2 > 0 then
					kds_1.object.k_rag_soc_figlio[k_riga] = kst_tab_clienti_figlio.rag_soc_10 + " (" + string(kst_tab_meca_figlio.clie_2,"#") + ")"
				end if
	
			end if
			
		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_dati_note (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati Note armo al ds
//======================================================================
//
//
long k_righe=0, k_riga=0
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe

			kst_tab_meca.id = kds_1.object.id_meca[k_riga]

			if kst_tab_meca.id > 0 then

//--- acchiappa le note dalle righe Riferimento
				select distinct
							max(armo.note_1)
							,max(armo.note_2)
							,max(armo.note_3)
					into
							:kst_tab_armo.note_1
							,:kst_tab_armo.note_2
							,:kst_tab_armo.note_3
					from armo
					where armo.id_meca = :kst_tab_meca.id 
					using kguo_sqlca_db_magazzino;

			
		
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
					if trim(kst_tab_armo.note_1) > " " then
						kst_tab_armo.note_1 = trim(kst_tab_armo.note_1)
					else
						kst_tab_armo.note_1 = ""
					end if
					if trim(kst_tab_armo.note_2) > " " then
						kst_tab_armo.note_1 += " " + trim(kst_tab_armo.note_2)
					end if
					if trim(kst_tab_armo.note_1) > " " then
						kds_1.object.k_note_2[k_riga] = trim(kst_tab_armo.note_1)
					end if
					
				end if
			end if
			
		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

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
		ki_temptab_pilota_prev_lav = kuf1_pilota_previsioni.get_temptab_pilota_prev_lav( )
		k_stringn = ki_temptab_pilota_prev_lav //string(kguo_utente.get_id_utente( ))
		
		kguf_data_base.u_set_ds_change_name_tab(kids_d_report_24_pilota_prev_lav, "vx_MAST_pilota_prev_lav", ki_temptab_pilota_prev_lav)
			
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

private function string u_get_fila (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Get della FILA dal ds :
//---  
//--- Inp: st_tab_barcode con i campi fila valorizzati
//--- Out: nr FILA
//--------------------------------------------------------------------------------------
//
//
string k_fila=""

	
	try
		
		if kst_tab_barcode.fila_1 > 0 then
			k_fila = "1"
		end if
		if k_fila = "" then
			if kst_tab_barcode.fila_1p > 0 then
				k_fila = "1"
			end if
		end if
		if k_fila = "" then
			if kst_tab_barcode.fila_2 > 0 then
				k_fila = "2"
			end if
		end if
		if k_fila = "" then
			if kst_tab_barcode.fila_2p > 0 then
				k_fila = "2"
			end if
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_fila
	

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

private function long u_set_id_meca (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge id_meca al ds
//======================================================================
//
long k_righe=0, k_riga=0
st_tab_barcode kst_tab_barcode
	
	try
			
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe
			
			kst_tab_barcode.barcode = kds_1.object.barcode[k_riga]

			select distinct
					barcode.id_meca
				into
					:kst_tab_barcode.id_meca
				from barcode
				where barcode.barcode = :kst_tab_barcode.barcode 
				using kguo_sqlca_db_magazzino;

			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_tab_barcode.id_meca = 0 
			end if
			kds_1.setitem(k_riga, "id_meca", kst_tab_barcode.id_meca)

		end for

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

public subroutine set_ds_report_3_pilota_pallet_in_lav (ref datastore kds_1) throws uo_exception;//---
//--- Legge i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
int k_rc
long k_rows

try 
	
	kids_d_report_3_pilota_pallet_in_lav = kds_1
	
	if kids_d_report_3_pilota_pallet_in_lav.rowcount() > 0 then
		
		u_set_id_meca(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_barcode(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_meca(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_clie(kids_d_report_3_pilota_pallet_in_lav)

		//u_set_dataora_lav_prev_fin(kids_d_report_3_pilota_pallet_in_lav)

	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

//return kids_d_report_3_pilota_pallet_in_lav
end subroutine

public subroutine set_ds_report_2_pilota_queue_prev (ref datastore kds_1) throws uo_exception;//---
//--- Legge i barcode in programmazione nel PILOTA e add all data from M2000
//---
//
int k_rc
long k_rows

try 
	
	//u_get_barcode_queue()
	kids_d_report_2_pilota_queue_table = kds_1
	
	if kids_d_report_2_pilota_queue_table.rowcount( ) > 0 then
	
		u_set_id_meca(kids_d_report_2_pilota_queue_table)
		u_set_dati_barcode(kids_d_report_2_pilota_queue_table)
		u_set_dati_meca(kids_d_report_2_pilota_queue_table)
		u_set_dati_clie(kids_d_report_2_pilota_queue_table)
		u_set_dati_barcode_figlio(kids_d_report_2_pilota_queue_table)
		u_set_dati_note(kids_d_report_2_pilota_queue_table)
		
		//u_set_report_2_pilota_queue_data_prev()

	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

//return kids_d_report_2_pilota_queue_table
end subroutine

on kuf_report_pilota.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_report_pilota.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
	if isvalid(kids_d_report_3_pilota_pallet_in_lav) then destroy kids_d_report_3_pilota_pallet_in_lav 
	if isvalid(kids_d_report_2_pilota_queue_table) then destroy kids_d_report_2_pilota_queue_table 
	if isvalid(kids_d_report_24_pilota_prev_lav) then destroy kids_d_report_24_pilota_prev_lav 
	if isvalid(kids_barcode_avgtimeplant) then destroy kids_barcode_avgtimeplant 
	if isvalid(kids_ds_queue_lav_xfila) then destroy kids_ds_queue_lav_xfila
	if isvalid(kiuf_utility) then destroy kiuf_utility 

end event

