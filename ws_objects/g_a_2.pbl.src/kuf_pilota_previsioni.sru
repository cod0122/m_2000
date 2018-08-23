$PBExportHeader$kuf_pilota_previsioni.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_previsioni from nonvisualobject
end type
end forward

global type kuf_pilota_previsioni from nonvisualobject
end type
global kuf_pilota_previsioni kuf_pilota_previsioni

type variables
//
private string ki_ds_pilota_pallet_in_lav_dataobject = "d_report_3_pilota_pallet_in_lav"
private string ki_ds_pilota_queue_dataobject = "d_report_2_pilota_queue_table"

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
private function long u_set_dataora_lav_prev_fin (ref datastore kds_1) throws uo_exception
private function long u_set_ds_queue_lav_xfila_ins (long k_row) throws uo_exception
private function long u_set_barcode_avgtimeplant () throws uo_exception
private subroutine u_sort_ds_queue_lav_xfila () throws uo_exception
private function long u_set_ds_queue_lav_xfila () throws uo_exception
public function st_tab_barcode u_get_st_tab_barcode_fila (datastore kds_1, long k_row)
private subroutine u_set_dataora_lav_prev_fin_upd (ref datastore kds_1, long k_riga) throws uo_exception
private function long u_get_queue_lav_xfila_primariga (string k_fila) throws uo_exception
private function long u_set_temptable_pilota_prev_lav () throws uo_exception
public function datastore get_ds_barcode_in_lav_prev () throws uo_exception
public function datastore get_ds_barcode_queue_prev () throws uo_exception
public function long get_tab_lav_x_lotto_prev () throws uo_exception
private function long u_set_tab_lav_x_lotto_prev () throws uo_exception
private function string u_get_fila (st_tab_barcode kst_tab_barcode) throws uo_exception
private function long u_set_ds_pilota_queue_data_prev () throws uo_exception
private subroutine u_set_ds_pilota_queue_data_prev_1 (long k_riga) throws uo_exception
private function long u_set_ds_pilota_pallet_in_lav () throws uo_exception
private function datastore u_get_ds_barcode_queue () throws uo_exception
public function string set_name_temptable_xlotto_prev ()
private function long u_set_id_meca (ref datastore kds_1) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Get dati dal PILOTA insieme ai dati di M2000
//
end subroutine

private function long u_set_dataora_lav_prev_fin (ref datastore kds_1) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Calcola la data di fine lavorazione e set il ds in argomento come:
//--- d_report_3_pilota_pallet_in_lav 
//--- d_report_2_pilota_queue_table 
//--------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0

	
	try
		
		u_set_barcode_avgtimeplant( ) //--- popola ds tempi medi impianto

		if kids_barcode_avgtimeplant.rowcount( ) < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int
			kguo_exception.kist_esito.sqlerrtext = "Tabella tempi medi di lavorazione impianto vuota!"
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			
		else
			
			k_righe = kds_1.rowcount()
	
			for k_riga = 1 to k_righe
				
				u_set_dataora_lav_prev_fin_upd(kds_1, k_riga)
				
			end for
		end if			

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_ds_queue_lav_xfila_ins (long k_row) throws uo_exception;//---
//--- Insert in ds: ds_queue_lav_xfila da d_report_3_pilota_pallet_in_lav
//---
//--- inp: riga da cui prendere i dati dal d_report_3_pilota_pallet_in_lav
//--- out: numero di riga inserita in ds_queue_lav_xfila
//---
long k_row_insert
datetime k_dataora_ini
st_tab_barcode kst_tab_barcode


try 

	if k_row > 0 then	

		k_dataora_ini = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_ini")

		kst_tab_barcode = u_get_st_tab_barcode_fila(kids_d_report_3_pilota_pallet_in_lav, k_row)

		k_row_insert = kids_ds_queue_lav_xfila.insertrow(0)
		kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_ini", k_dataora_ini)
		kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_fin", kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_prev_fin"))
		if kst_tab_barcode.fila_1 > 0 or kst_tab_barcode.fila_1p > 0 then
			kids_ds_queue_lav_xfila.setitem(k_row_insert, "fila","1")
		else
			kids_ds_queue_lav_xfila.setitem(k_row_insert,  "fila","2")
		end if


//	if k_rows < 0 then
//		kguo_exception.inizializza( )
//		kguo_exception.kist_esito.sqlcode = k_rows
//		kguo_exception.kist_esito.esito = kkg_esito.db_ko
//		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Fila in lavorazione in impianto: " + string(kguo_sqlca_db_magazzino.sqldbcode)
//		throw kguo_exception
//	end if

	end if
	
catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_row_insert

end function

private function long u_set_barcode_avgtimeplant () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Imposta i tempi di lavorazione previsti in impianto 
//--------------------------------------------------------------------------------------
//
//
long k_righe

	
	try
		
		if not isvalid(kids_barcode_avgtimeplant)  then
			kids_barcode_avgtimeplant = create datastore
			kids_barcode_avgtimeplant.dataobject = "ds_barcode_avgtimeplant"
			kids_barcode_avgtimeplant.SetTransObject(kguo_sqlca_db_magazzino)
			k_righe = kids_barcode_avgtimeplant.retrieve()
			if k_righe < 0 then
				kguo_exception.inizializza( )
				kguo_exception.kist_esito.sqlcode = k_righe
				kguo_exception.kist_esito.esito = kkg_esito.db_ko
				kguo_exception.kist_esito.sqlerrtext = "Anomalia in lettura dati tempi medi di trattamento per giro"
				throw kguo_exception
			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private subroutine u_sort_ds_queue_lav_xfila () throws uo_exception;//---
//--- Ordine ds_queue_lav_xfila per Fila e Data di fine lavorazione
//---
//---
int k_rc


try 
	if kids_ds_queue_lav_xfila.rowcount( ) > 0 then

		k_rc = kids_ds_queue_lav_xfila.setsort("fila asc, k_dataora_lav_fin asc")
		if k_rc > 0 then
			k_rc = kids_ds_queue_lav_xfila.sort()
		end if
		
	end if

	if k_rc < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.nome_oggetto = this.classname( )
		kguo_exception.kist_esito.sqlcode = k_rc
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in ordinamento ds di data inizio-fine lavorazione per Fila: " + string(kguo_sqlca_db_magazzino.sqldbcode)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try




end subroutine

private function long u_set_ds_queue_lav_xfila () throws uo_exception;//---
//--- Legge i barcode in lavorazione nel PILOTA e riempie il datastore: ds_queue_lav_xfila
//---
//--- out: nr righe inserite
//---
int k_rc
long k_rows, k_row, k_row_insert
datetime k_dataora_ini


try 
	if not isvalid(kids_ds_queue_lav_xfila) then
		kids_ds_queue_lav_xfila = create datastore
		kids_ds_queue_lav_xfila.dataobject = ki_ds_queue_lav_xfila_dataobject
	end if

//	k_rows = u_set_report_3_pilota_pallet_in_lav( ) 
	get_ds_barcode_in_lav_prev( )
	k_rows = kids_d_report_3_pilota_pallet_in_lav.rowcount( )
	if k_rows > 0 then	//--- legge barcode in lav su Pilota 
		
		u_set_dataora_lav_prev_fin(kids_d_report_3_pilota_pallet_in_lav)
		
		k_row = 1
		u_set_ds_queue_lav_xfila_ins(k_row)
		k_dataora_ini = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_ini")

		for k_row = 2 to k_rows
			
			if k_dataora_ini <> kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_ini") then
				k_dataora_ini = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_ini")
				
				k_row_insert = u_set_ds_queue_lav_xfila_ins(k_row)
				
			end if
			
		end for
		
	end if

	if k_rows < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.nome_oggetto = this.classname( )
		kguo_exception.kist_esito.sqlcode = k_rows
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura Fila in lavorazione in impianto: " + string(kguo_sqlca_db_magazzino.sqldbcode)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_row_insert


end function

public function st_tab_barcode u_get_st_tab_barcode_fila (datastore kds_1, long k_row);//---
//--- get dei dati dei giri Fila 1 e 2
//---
//--- inp: datastore da cui estrarre il dato, riga da cui rendere i dato
//---
st_tab_barcode kst_tab_barcode


	if kds_1.dataobject = ki_ds_pilota_pallet_in_lav_dataobject then // fila in alfanumerico
		if IsNumber(trim(kds_1.object.f1avp[k_row])) then
			kst_tab_barcode.fila_1 = integer(trim(kds_1.object.f1avp[k_row]))
		end if
		if IsNumber(trim(kds_1.object.f2avp[k_row])) then
			kst_tab_barcode.fila_2 = integer(trim(kds_1.object.f2avp[k_row]))
		end if
		if IsNumber(trim(kds_1.object.f1app[k_row])) then
			kst_tab_barcode.fila_1p = integer(trim(kds_1.object.f1app[k_row]))
		end if
		if IsNumber(trim(kds_1.object.f2app[k_row])) then
			kst_tab_barcode.fila_2p = integer(trim(kds_1.object.f2app[k_row]))
		end if
	else
		if not isnull(kds_1.getitemnumber(k_row, "f1avp")) then
			kst_tab_barcode.fila_1 = kds_1.getitemnumber(k_row, "f1avp")
		end if
		if not isnull(kds_1.getitemnumber(k_row, "f1app")) then
			kst_tab_barcode.fila_1p = kds_1.getitemnumber(k_row, "f1app")
		end if
		if not isnull(kds_1.getitemnumber(k_row, "f2avp")) then
			kst_tab_barcode.fila_2 = kds_1.getitemnumber(k_row, "f2avp")
		end if
		if not isnull(kds_1.getitemnumber(k_row, "f2app")) then
			kst_tab_barcode.fila_2p = kds_1.getitemnumber(k_row, "f2app")
		end if
	end if

return kst_tab_barcode
end function

private subroutine u_set_dataora_lav_prev_fin_upd (ref datastore kds_1, long k_riga) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione per la riga del ds in argomento:
//--- d_report_3_pilota_pallet_in_lav 
//--- d_report_2_pilota_queue_table 
//--- Inp: uno dei ds indicati sopre, nr riga da aggiornare
//--------------------------------------------------------------------------------------
//
//
long k_riga_avgtimeplant
datetime k_dataora_lav_fin_prev, k_dataora_lav_ini, k_dataora_lav_fin_min_prev, k_dataora_lav_fin_max_prev
st_tab_s_avgtimeplant kst_tab_s_avgtimeplant_avg, kst_tab_s_avgtimeplant_min, kst_tab_s_avgtimeplant_max
st_tab_barcode kst_tab_barcode
	
	
	try
		
		if k_riga < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int
			kguo_exception.kist_esito.sqlerrtext = "Il numero di riga del ds non può essere a zero!"
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			
		else
			
			if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility
			
			kds_1.object.k_dataora_lav_prev_fin[k_riga] = datetime(date(0), time(0))

			k_dataora_lav_ini = kds_1.getitemdatetime(k_riga, "k_dataora_lav_ini")
			if date(k_dataora_lav_ini) > kkg.data_no then
				
				kst_tab_barcode = u_get_st_tab_barcode_fila(kds_1, k_riga)
				
				k_riga_avgtimeplant = kids_barcode_avgtimeplant.find( "giri_f1 = " + string(kst_tab_barcode.fila_1) &
																+ " and giri_f1p = " + string(kst_tab_barcode.fila_1p) &
																+ " and giri_f2 = " + string(kst_tab_barcode.fila_2) &
																+ " and giri_f2p = " + string(kst_tab_barcode.fila_2p) &
																,1 , kids_barcode_avgtimeplant.rowcount( ), primary!)
				
				if k_riga_avgtimeplant > 0 then
					
					kst_tab_s_avgtimeplant_avg.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_avg")
					kst_tab_s_avgtimeplant_min.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_min")
					kst_tab_s_avgtimeplant_max.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_max")
					kds_1.setitem(k_riga, "k_avg_time_io_minute", kst_tab_s_avgtimeplant_avg.time_io_minute)
		
		//--- calcola le previsioni aggiungendo i minuti previsti in impianto per l'uscita
					k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_avg.time_io_minute)
					if date(k_dataora_lav_fin_prev) > kkg.data_no then
						
						if k_dataora_lav_fin_prev < kguo_g.get_datetime_current( ) then
							k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(kguo_g.get_datetime_current( ), 60) // se data prev minore di adesso allora metto adesso + un tot di minuti
						end if
							
						k_dataora_lav_fin_min_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_min.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
							
						k_dataora_lav_fin_max_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_max.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
							
					end if
					
					kds_1.setitem(k_riga, "k_dataora_lav_prev_fin", k_dataora_lav_fin_prev)
					kds_1.setitem(k_riga, "k_dataora_lav_prev_fin_min", k_dataora_lav_fin_min_prev)
					kds_1.setitem(k_riga, "k_dataora_lav_prev_fin_max", k_dataora_lav_fin_max_prev)
					
				end if
			end if
				
		end if			

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

//return k_righe
	

end subroutine

private function long u_get_queue_lav_xfila_primariga (string k_fila) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Get della prima riga per la fila passata dal ds_queue_lav_xfila 
//--- Inp: Fila di lavorazione
//--- Out: data_fin trovata x fila
//--------------------------------------------------------------------------------------
//
//
long k_riga_data_fin
//datetime k_dataora_lav_fin

	
	try
		
//		if k_riga_ds < 1 then
//			
//			kguo_exception.inizializza( )
//			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int
//			kguo_exception.kist_esito.sqlerrtext = "Il numero di riga del ds dati non può essere a zero!"
//			kguo_exception.kist_esito.nome_oggetto = this.classname( )
//			kguo_exception.scrivi_log( )
//			
//		else
			
			
			k_riga_data_fin = kids_ds_queue_lav_xfila.find( "fila = '" + trim(k_fila) + "'",1 , kids_ds_queue_lav_xfila.rowcount( ), primary!)
			
//			if k_riga_data_fin > 0 then
//				
//				k_dataora_lav_fin = kids_ds_queue_lav_xfila.getitemdatetime( k_riga_data_fin, "k_dataora_lav_ini")
//				
//			end if
				
//		end if
			

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_riga_data_fin
	

end function

private function long u_set_temptable_pilota_prev_lav () throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Crea la temp table con data inizio-fine lavorazione presunte x Lotto
//--- Out: nr righe inserite in tb
//-------------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0
int k_rc
long k_rigainsert
string k_tablename, k_campi
string k_sql_orig, k_string, k_stringn
int k_ctr
datastore kds_1
 	
	try
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

		k_tablename = ki_temptab_pilota_prev_lav
		k_campi = "id_cliente int " &
					 	+ " , id_meca int " &
					 	+ " , num_int int " &
					 	+ " , data_int date " &
						 + ", f1avp smallint " &
						 + ", f1app smallint " &
						 + ", f2avp smallint " &
						 + ", f2app smallint " &
					 	+ " , consegna_data date " & 	 
					 	+ " , pilota_ordine int "  &
					 	+ " , colli_lav_ent char(12) " & 
					 	+ " , note varchar(120) " & 
					 	+ " , prev_dataora_lav_ini datetime " &
					 	+ " , prev_dataora_lav_fin datetime " &
					 	+ " , prev_dataora_lav_fin_min datetime " &
					 	+ " , prev_dataora_lav_fin_max datetime " &
						+ " , avg_time_io_minute int "  
	   	kguo_sqlca_db_magazzino.db_crea_temp_table(k_tablename, k_campi, "")      
//	   	kguo_sqlca_db_magazzino.db_crea_table( k_tablename, k_campi)      
				

		kds_1 = CREATE datastore
		kds_1.dataobject = "ds_vx_mast_pilota_prev_lav"
		k_rc = kds_1.SetTransObject (kguo_sqlca_db_magazzino)

		k_sql_orig = kds_1.Object.DataWindow.Table.Select 
		k_stringn = "#" + k_tablename	
		k_string =  "vx_MAST_pilota_prev_lav"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		kds_1.Object.DataWindow.Table.Select = k_sql_orig
		kds_1.Object.DataWindow.Table.update = "#" + k_tablename	

		u_set_id_meca(kids_d_report_3_pilota_pallet_in_lav)
	
		k_righe = kids_d_report_3_pilota_pallet_in_lav.rowcount() // nr totale dei pallet in lavorazione nel pilota
		for k_riga = 1 to k_righe 
			k_rigainsert = kds_1.insertrow( 0 )
			kds_1.setitem( k_rigainsert, "id_cliente", kids_d_report_3_pilota_pallet_in_lav.getitemnumber(k_riga, "k_clie_2") )
			kds_1.setitem( k_rigainsert, "id_meca", kids_d_report_3_pilota_pallet_in_lav.getitemnumber(k_riga, "id_meca") )
			kds_1.setitem( k_rigainsert, "num_int", kids_d_report_3_pilota_pallet_in_lav.getitemnumber(k_riga, "num_int") )
			kds_1.setitem( k_rigainsert, "data_int", kids_d_report_3_pilota_pallet_in_lav.getitemdate(k_riga, "data_int") )
			kds_1.setitem( k_rigainsert, "f1avp", integer(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_riga, "f1avp") ))
			kds_1.setitem( k_rigainsert, "f1app", integer(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_riga, "f1app") ))
			kds_1.setitem( k_rigainsert, "f2avp", integer(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_riga, "f2avp") ))
			kds_1.setitem( k_rigainsert, "f2app", integer(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_riga, "f2app") ))
			kds_1.setitem( k_rigainsert, "consegna_data", kids_d_report_3_pilota_pallet_in_lav.getitemdate(k_riga, "k_consegna_data") )
			kds_1.setitem( k_rigainsert, "pilota_ordine", 0 )
			kds_1.setitem( k_rigainsert, "colli_lav_ent", kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_riga, "k_colli") )
			kds_1.setitem( k_rigainsert, "note", "" )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_ini", kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_riga, "k_dataora_lav_ini") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin", kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_riga, "k_dataora_lav_prev_fin") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin_min", kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_riga, "k_dataora_lav_prev_fin_min") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin_max", kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_riga, "k_dataora_lav_prev_fin_max") )
			kds_1.setitem( k_rigainsert, "avg_time_io_minute", kids_d_report_3_pilota_pallet_in_lav.getitemnumber(k_riga, "k_avg_time_io_minute") )
		end for

		u_set_id_meca(kids_d_report_2_pilota_queue_table)

		k_righe = kids_d_report_2_pilota_queue_table.rowcount() // nr totale dei pallet in coda di programmazione nel pilota
		for k_riga = 1 to k_righe 
			k_rigainsert = kds_1.insertrow( 0 )
			kds_1.setitem( k_rigainsert, "id_cliente", kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "k_clie_2") )
			kds_1.setitem( k_rigainsert, "id_meca", kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "id_meca") )
			kds_1.setitem( k_rigainsert, "num_int", kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "num_int") )
			kds_1.setitem( k_rigainsert, "data_int", kids_d_report_2_pilota_queue_table.getitemdate(k_riga, "data_int") )
			kds_1.setitem( k_rigainsert, "f1avp", integer(kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "f1avp") ))
			kds_1.setitem( k_rigainsert, "f1app", integer(kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "f1app") ))
			kds_1.setitem( k_rigainsert, "f2avp", integer(kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "f2avp") ))
			kds_1.setitem( k_rigainsert, "f2app", integer(kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "f2app") ))
			kds_1.setitem( k_rigainsert, "consegna_data", kids_d_report_2_pilota_queue_table.getitemdate(k_riga, "k_consegna_data") )
			kds_1.setitem( k_rigainsert, "pilota_ordine", kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "ordine") )
			kds_1.setitem( k_rigainsert, "colli_lav_ent", kids_d_report_2_pilota_queue_table.getitemstring(k_riga, "k_colli") )
			kds_1.setitem( k_rigainsert, "note", kids_d_report_2_pilota_queue_table.getitemstring(k_riga, "k_note_2") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_ini", kids_d_report_2_pilota_queue_table.getitemdatetime(k_riga, "k_dataora_lav_ini") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin", kids_d_report_2_pilota_queue_table.getitemdatetime(k_riga, "k_dataora_lav_prev_fin") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin_min", kids_d_report_2_pilota_queue_table.getitemdatetime(k_riga, "k_dataora_lav_prev_fin_min") )
			kds_1.setitem( k_rigainsert, "prev_dataora_lav_fin_max", kids_d_report_2_pilota_queue_table.getitemdatetime(k_riga, "k_dataora_lav_prev_fin_max") )
			kds_1.setitem( k_rigainsert, "avg_time_io_minute", kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "k_avg_time_io_minute") )
		end for

		k_rc = kds_1.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_rigainsert
	

end function

public function datastore get_ds_barcode_in_lav_prev () throws uo_exception;//---
//--- Popola ds con i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
int k_rc
long k_rows

try 
	
	if u_set_ds_pilota_pallet_in_lav() > 0 then
		
//		u_set_id_meca(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dataora_lav_prev_fin(kids_d_report_3_pilota_pallet_in_lav)

	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_3_pilota_pallet_in_lav
end function

public function datastore get_ds_barcode_queue_prev () throws uo_exception;//---
//--- Popola il ds con i barcode in programmazione nel PILOTA 
//---
//
int k_rc
long k_rows

try  
	
	u_get_ds_barcode_queue()
	
	if kids_d_report_2_pilota_queue_table.rowcount( ) > 0 then
	
//		u_set_id_meca(kids_d_report_2_pilota_queue_table)
		//u_set_dati_barcode_figlio(kids_d_report_2_pilota_queue_table)
		
		u_set_ds_pilota_queue_data_prev()

	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_2_pilota_queue_table
end function

public function long get_tab_lav_x_lotto_prev () throws uo_exception;//---
//--- Popola temp tab con i barcode in lavoraz. e programmazione nel PILOTA e previsione di inizio e fine lav per Lotto
//---
//
long k_rows

try 
	
	set_name_temptable_xlotto_prev( )
	
	k_rows = u_set_tab_lav_x_lotto_prev( ) 
		

catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
	
end try

return k_rows
end function

private function long u_set_tab_lav_x_lotto_prev () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Popola ds data inizio-fine lavorazione previste x Lotto
//---
//----------------------------------------------------------------------------------------
//
//
long k_righe=0

 	
	try

//--- popola ds report_2 e report_3 con data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
		get_ds_barcode_queue_prev( )		
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav
		k_righe = u_set_temptable_pilota_prev_lav() 
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

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

private function long u_set_ds_pilota_queue_data_prev () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Imposta data inizio-fine lavorazione presunte nel ds CODA-PILOTA
//--- d_report_2_pilota_queue_table 
//----------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0, k_riga_queue, k_ordine_queue, k_ordine_queue_exit
int k_ctr
datetime k_dataora_lav_ini, k_dataora_lav_fin
string k_fila
st_tab_barcode kst_tab_barcode

	
	try
		
		if u_set_ds_queue_lav_xfila( ) > 0 then  // popola ds con i dati data ini dal Pilota in Lav e data fine prevista   
		
			k_righe = kids_d_report_2_pilota_queue_table.rowcount() // nr totale dei pallet in coda di programmazione nel pilota

			kids_d_report_2_pilota_queue_table.setsort( "ordine asc")
			kids_d_report_2_pilota_queue_table.sort()

			k_riga = 1
			do while k_riga <= k_righe  

				kst_tab_barcode = u_get_st_tab_barcode_fila(kids_d_report_2_pilota_queue_table, k_riga)
				k_fila = u_get_fila(kst_tab_barcode)
	
				if k_fila > "0" then
					
					u_sort_ds_queue_lav_xfila( )
					k_riga_queue = u_get_queue_lav_xfila_primariga(k_fila)
					k_dataora_lav_fin = kids_ds_queue_lav_xfila.getitemdatetime(k_riga_queue, "k_dataora_lav_fin")  // get della data di fine lav (prev) che diventa quella di inizio  

//--- add minuti carico	
					k_dataora_lav_fin = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin, 4)

					kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_dataora_lav_ini", k_dataora_lav_fin)
					u_set_dataora_lav_prev_fin_upd(kids_d_report_2_pilota_queue_table, k_riga) // imposta la data fine lav  da inizio lav sul ds report di programmazione del pilota	

//---- Nella coda dei dati di previsione lav x fila ricopre le vecchie date di inizio-fine con le nuove appena ricavate
					k_dataora_lav_ini = kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga, "k_dataora_lav_ini")
					k_dataora_lav_fin = kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga, "k_dataora_lav_prev_fin")
					kids_ds_queue_lav_xfila.setitem(k_riga_queue, "k_dataora_lav_ini", k_dataora_lav_ini)
					kids_ds_queue_lav_xfila.setitem(k_riga_queue, "k_dataora_lav_fin", k_dataora_lav_fin)

//--- Oltre alla riga stessa aggiorna se ci sono eventuali righe di gorupage che hanno lo stesso numero 'ordine', ripete2 volte xchè queste viaggiano sempre in coppia
					k_ordine_queue = kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "ordine")
					k_riga ++
					k_ctr = 1
					do while k_ctr < 3 and  k_riga <= k_righe
						do while k_ordine_queue = kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "ordine") 
							
							u_set_ds_pilota_queue_data_prev_1(k_riga)
							k_riga ++
							if k_riga > k_righe then 
								exit
							end if
							
						loop 
						if  k_riga <= k_righe then
							k_ordine_queue = kids_d_report_2_pilota_queue_table.getitemnumber(k_riga, "ordine")
							k_ctr ++
						end if
					loop

				else
					k_riga ++
				end if
	
			loop
			
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private subroutine u_set_ds_pilota_queue_data_prev_1 (long k_riga) throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Aggiorna data inizio-fine lavorazione presunte nel ds CODA-PILOTA
//--- d_report_2_pilota_queue_table 
//--- di supporto alla u_set_report_2_pilota_queue_data_prev
//----------------------------------------------------------------------------------------
//
//
	
		kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_dataora_lav_ini", kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga - 1, "k_dataora_lav_ini"))
		kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_dataora_lav_prev_fin", kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga - 1, "k_dataora_lav_prev_fin"))
		kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_dataora_lav_prev_fin_min", kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga - 1, "k_dataora_lav_prev_fin_min"))
		kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_dataora_lav_prev_fin_max", kids_d_report_2_pilota_queue_table.getitemdatetime( k_riga - 1, "k_dataora_lav_prev_fin_max"))
		kids_d_report_2_pilota_queue_table.setitem( k_riga, "k_avg_time_io_minute", kids_d_report_2_pilota_queue_table.getitemnumber( k_riga - 1, "k_avg_time_io_minute"))
	

	

end subroutine

private function long u_set_ds_pilota_pallet_in_lav () throws uo_exception;//---
//--- Legge i barcode in lavorazione nel PILOTA, valorizza il ds: d_report_3_pilota_pallet_in_lav
//--- 
//--- out nr righe estratte
//
int k_rc
long k_rows

try 
	if not isvalid(kids_d_report_3_pilota_pallet_in_lav) then
		kids_d_report_3_pilota_pallet_in_lav = create datastore
		kids_d_report_3_pilota_pallet_in_lav.dataobject = ki_ds_pilota_pallet_in_lav_dataobject
		k_rc = kids_d_report_3_pilota_pallet_in_lav.settrans(kguo_sqlca_db_pilota)
		//k_rc = kids_d_report_3_pilota_pallet_in_lav.settransobject(kguo_sqlca_db_pilota)
		if k_rc < 0 then
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in connessione per leggere i barcode in lavorazione in impianto. Il server del PILOTA sembra non rispondere. Operazione Interrotta!"
			throw kguo_exception
		end if
	end if

	k_rows	= kids_d_report_3_pilota_pallet_in_lav.retrieve(date(0))

	if k_rows < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.sqlcode = k_rows
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura barcode in lavorazione in impianto: " + string(kguo_sqlca_db_magazzino.sqldbcode)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_rows

end function

private function datastore u_get_ds_barcode_queue () throws uo_exception;//---
//--- Legge i barcode in coda di programmazione nel PILOTA
//---
//
int k_rc
long k_rows

try 
	if not isvalid(kids_d_report_2_pilota_queue_table) then
		kids_d_report_2_pilota_queue_table = create datastore
		kids_d_report_2_pilota_queue_table.dataobject = ki_ds_pilota_queue_dataobject
		k_rc = kids_d_report_2_pilota_queue_table.settrans(kguo_sqlca_db_pilota)
		//k_rc = kids_d_report_2_pilota_queue_table.settransobject(kguo_sqlca_db_pilota)
		if k_rc < 0 then
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.sqlcode = k_rc
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlerrtext = "Errore in connessione per leggere i barcode in coda in impianto. Il server del PILOTA sembra non rispondere. Operazione Interrotta!"
			throw kguo_exception
		end if
	end if

	k_rows	= kids_d_report_2_pilota_queue_table.retrieve(date(0))

	if k_rows < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.sqlcode = k_rows
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura barcode in coda in impianto: " + string(kguo_sqlca_db_magazzino.sqldbcode)
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_2_pilota_queue_table
end function

public function string set_name_temptable_xlotto_prev ();//
		
	ki_temptab_pilota_prev_lav = "vx_" + string(kguo_utente.get_id_utente( )) + "_pilota_prev_lav"

return  ki_temptab_pilota_prev_lav
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

on kuf_pilota_previsioni.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_pilota_previsioni.destroy
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

