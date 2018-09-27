$PBExportHeader$kuf_pilota_previsioni.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_pilota_previsioni from nonvisualobject
end type
end forward

global type kuf_pilota_previsioni from nonvisualobject
event u_construct ( )
end type
global kuf_pilota_previsioni kuf_pilota_previsioni

type variables
//
private string ki_ds_queue_lav_xfila_dataobject = "ds_queue_lav_xfila"
private constant string ki_ds_pallet_workqueue_dataobject = "ds_pilota_pallet_workqueue"

private string ki_temptab_pilota_workqueue // = "vx_MAST_pilota_pallet_workqueue"
private string ki_temptab_pilota_prev_lav //= "vx_MAST_pilota_prev_lav"

private datastore kids_ds_queue_lav_xfila
private datastore kids_barcode_avgtimeplant

private kuf_utility kiuf_utility


end variables

forward prototypes
public subroutine _readme ()
private subroutine u_sort_ds_queue_lav_xfila () throws uo_exception
private function long u_get_queue_lav_xfila_primariga (string k_fila) throws uo_exception
public function long get_tab_lav_x_lotto_prev () throws uo_exception
private function long u_set_tab_lav_x_lotto_prev () throws uo_exception
private function long u_set_temptable_pilota_workqueue () throws uo_exception
public function long get_ds_barcode_in_lav_prev () throws uo_exception
public function long get_ds_barcode_queue_prev () throws uo_exception
public function string get_ki_temptab_pilota_workqueue ()
public function string get_ki_temptab_pilota_prev_lav ()
private function datastore u_get_ds_pilota_workqueue () throws uo_exception
private function long u_set_barcode_avgtimeplant () throws uo_exception
private subroutine u_set_dataora_lav_prev_fin_1 (datastore kds_1, long k_riga) throws uo_exception
private function long u_set_ds_pilota_queue_data_prev () throws uo_exception
private function long u_set_dataora_lav_prev_fin () throws uo_exception
private function long u_set_ds_queue_lav_xfila (ref datastore kds_1) throws uo_exception
private function long u_set_temptable_pilota_prev_lav () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Get dati dal PILOTA insieme ai dati di M2000
//
end subroutine

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

public function long get_tab_lav_x_lotto_prev () throws uo_exception;//---
//--- Popola temp tab con i barcode in lavoraz. e programmazione nel PILOTA e previsione di inizio e fine lav per Lotto
//---
//
long k_rows

try 
	
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
long k_righe=0

 	
	try

		u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione
		
		u_set_ds_pilota_queue_data_prev( )	  // imposta data fine lav per rec in programmazione
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav
		k_righe = u_set_temptable_pilota_prev_lav( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_temptable_pilota_workqueue () throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Crea la temp table con i PALLET in lavorazione e in CODA sul PILOTA
//--- Out: nr righe inserite in tb
//-------------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0
int k_rc
long k_rigainsert
string k_campi
string k_sql_orig, k_string, k_stringn
int k_ctr
datastore kds_out, kds_inp
 	
	try
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

		k_campi = "stato char(6) " &
					 	+ " , n_ordine int " &
					 	+ " , barcode char(13) " &
					 	+ " , barcode_figlio char(13) " &
					 	+ " , ordine_figlio tinyint " &
					 	+ " , num_int_figlio int " &
					 	+ " , posizione tinyint " &
					 	+ " , fase tinyint " &
					 	+ " , nn tinyint " &
					 	+ " , fila tinyint " &
						 + ", f1avp smallint " &
						 + ", f1app smallint " &
						 + ", f2avp smallint " &
						 + ", f2app smallint " &
					 	 + ", dataora_lav_ini datetime " &
					 	 + ", dataora_lav_fin_prev datetime " &
 					 	 + ", dataora_lav_fin_min_prev datetime " &
					 	 + ", dataora_lav_fin_max_prev datetime " &
						 + ", avg_time_io_minute integer" 
//	   	kguo_sqlca_db_magazzino.db_crea_temp_table_global(ki_temptab_pilota_workqueue, k_campi, "")      
	   	kguo_sqlca_db_magazzino.db_crea_temp_table(ki_temptab_pilota_workqueue, k_campi, "")      
//	   	kguo_sqlca_db_magazzino.db_crea_table( ki_temptab_pilota_workqueue, k_campi)      
				
		kds_inp = CREATE datastore
		kds_inp.dataobject = ki_ds_pallet_workqueue_dataobject    
		k_rc = kds_inp.SetTrans (kguo_sqlca_db_pilota)

		kds_out = CREATE datastore
		kds_out.dataobject = "ds_pilota_pallet_workqueue_temp"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)

		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_pallet_workqueue")

		k_righe = kds_inp.retrieve( )    // get dal db PILOTA tutti i PALLET in lavorazione e in coda 

		for k_riga = 1 to k_righe 
			k_rigainsert = kds_out.insertrow( 0 )
			kds_out.setitem( k_rigainsert, "stato", kds_inp.getitemstring(k_riga, "stato") )
			kds_out.setitem( k_rigainsert, "n_ordine", kds_inp.getitemnumber(k_riga, "n_ordine") )
			kds_out.setitem( k_rigainsert, "barcode", kds_inp.getitemstring(k_riga, "pallet_code") )
			kds_out.setitem( k_rigainsert, "barcode_figlio", kds_inp.getitemstring(k_riga, "barcode_figlio") )
			kds_out.setitem( k_rigainsert, "ordine_figlio", kds_inp.getitemnumber(k_riga, "ordine_figlio") )
			kds_out.setitem( k_rigainsert, "num_int_figlio", integer(kds_inp.getitemstring(k_riga, "lotto_figlio") ))
			kds_out.setitem( k_rigainsert, "posizione", integer(kds_inp.getitemstring(k_riga, "posizione") ))
			kds_out.setitem( k_rigainsert, "dataora_lav_ini", kds_inp.getitemdatetime(k_riga, "k_dataora_lav_ini") )
			kds_out.setitem( k_rigainsert, "fase", kds_inp.getitemnumber(k_riga, "fase") )
			kds_out.setitem( k_rigainsert, "nn", integer(kds_inp.getitemstring(k_riga, "nn") ))
			kds_out.setitem( k_rigainsert, "fila", kds_inp.getitemnumber(k_riga, "fila") )
			kds_out.setitem( k_rigainsert, "f1avp", kds_inp.getitemnumber(k_riga, "f1avp") )
			kds_out.setitem( k_rigainsert, "f1app", kds_inp.getitemnumber(k_riga, "f1app") )
			kds_out.setitem( k_rigainsert, "f2avp", kds_inp.getitemnumber(k_riga, "f2avp") )
			kds_out.setitem( k_rigainsert, "f2app", kds_inp.getitemnumber(k_riga, "f2app") )
		end for

		k_rc = kds_out.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_rigainsert
	

end function

public function long get_ds_barcode_in_lav_prev () throws uo_exception;//---
//--- Popola ds con i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
long k_rows

try 

//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	k_rows = u_set_temptable_pilota_workqueue( )

	k_rows = u_set_dataora_lav_prev_fin( )	  // imposta data fine lav per rec in lavorazione


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_rows
end function

public function long get_ds_barcode_queue_prev () throws uo_exception;//---
//--- Popola il ds con i barcode in programmazione nel PILOTA 
//---
//
int k_rc
long k_rows

try  
	
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
	k_rows = u_set_temptable_pilota_workqueue( )
	
	k_rows = u_set_ds_pilota_queue_data_prev( )	  // imposta data fine lav per rec in programmazione

catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return k_rows
end function

public function string get_ki_temptab_pilota_workqueue ();	//
	return ki_temptab_pilota_workqueue

end function

public function string get_ki_temptab_pilota_prev_lav ();	//
	return ki_temptab_pilota_prev_lav

end function

private function datastore u_get_ds_pilota_workqueue () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//---
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
datastore kds_1	
	
	try

		kds_1 = CREATE datastore
		kds_1.dataobject = "ds_pilota_workqueue_tmp"
		k_rc = kds_1.SetTransObject (kguo_sqlca_db_magazzino)

		kguf_data_base.u_set_ds_change_name_tab(kds_1, "vx_MAST_pilota_pallet_workqueue")
		
		k_righe = kds_1.retrieve("WORK")
		if k_righe < 1 then //verifica se la tabella temp esiste altrimenti la popola
		
//--- popola tabella temp con i data ini e fin previsti ( tutto quello nel Pilota in Lav e  in Coda di Programmazione) 		
			k_righe = u_set_temptable_pilota_workqueue( )
		
		end if
		
		if k_righe < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe estratte dalla tab. temp #" + ki_temptab_pilota_workqueue + " non può essere a zero!"
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			throw kguo_exception
			
		end if
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return kds_1
	

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

private subroutine u_set_dataora_lav_prev_fin_1 (datastore kds_1, long k_riga) throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//--- input: datastore previsioni, nr riga 
//--------------------------------------------------------------------------------------
//
//
datetime k_dataora_lav_fin_prev, k_dataora_lav_ini, k_dataora_lav_fin_min_prev, k_dataora_lav_fin_max_prev
int k_rc
st_tab_s_avgtimeplant kst_tab_s_avgtimeplant_avg, kst_tab_s_avgtimeplant_min, kst_tab_s_avgtimeplant_max

	
	try

			
		kds_1.object.dataora_lav_fin_prev[k_riga] = datetime(date(0), time(0))

		k_dataora_lav_ini = kds_1.getitemdatetime(k_riga, "dataora_lav_ini")
		if date(k_dataora_lav_ini) > kkg.data_no then
				
			kst_tab_s_avgtimeplant_avg.time_io_minute = kds_1.getitemnumber(k_riga, "time_io_minute_avg")
			kst_tab_s_avgtimeplant_min.time_io_minute = kds_1.getitemnumber(k_riga, "time_io_minute_min")
			kst_tab_s_avgtimeplant_max.time_io_minute = kds_1.getitemnumber(k_riga, "time_io_minute_max")
			kds_1.setitem(k_riga, "avg_time_io_minute", kst_tab_s_avgtimeplant_avg.time_io_minute)

		//--- calcola le previsioni aggiungendo i minuti previsti in impianto per l'uscita
			if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility
			k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_avg.time_io_minute)
			if date(k_dataora_lav_fin_prev) > kkg.data_no then
						
				if k_dataora_lav_fin_prev < kguo_g.get_datetime_current( ) then
					k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(kguo_g.get_datetime_current( ), 60) // se data prev minore di adesso allora metto adesso + un tot di minuti
				end if
							
				k_dataora_lav_fin_min_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_min.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
							
				k_dataora_lav_fin_max_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin_prev, (kst_tab_s_avgtimeplant_max.time_io_minute - kst_tab_s_avgtimeplant_avg.time_io_minute))
							
			end if
					
			kds_1.setitem(k_riga, "dataora_lav_fin_prev", k_dataora_lav_fin_prev)
			kds_1.setitem(k_riga, "dataora_lav_fin_min_prev", k_dataora_lav_fin_min_prev)
			kds_1.setitem(k_riga, "dataora_lav_fin_max_prev", k_dataora_lav_fin_max_prev)
					
		end if
		

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

//return k_righe
	

end subroutine

private function long u_set_ds_pilota_queue_data_prev () throws uo_exception;//
//----------------------------------------------------------------------------------------
//--- Imposta data inizio-fine lavorazione presunte in tab 'previsioni 
//--- per i pallet in Programmazone (QUEUE)
//---  
//----------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0, k_riga_queue, k_ordine_queue, k_ordine_queue_exit
int k_ctr, k_rc
datetime k_dataora_lav_ini, k_dataora_lav_fin
int k_fila
st_tab_barcode kst_tab_barcode
datastore kds_work, kds_queue
	
	try

		kds_work = u_get_ds_pilota_workqueue( )
		k_righe = kds_work.retrieve("WORK")
		if k_righe > 0 then  // retrive dati in lav con data ini e fine prevista di Lav e data fine prevista   
		
			for k_riga = 1 to k_righe	
				
				u_set_dataora_lav_prev_fin_1(kds_work, k_riga)  // imposta la data di fine lav prevista
	
			end for
		
			u_set_ds_queue_lav_xfila(kds_work)    // popola la CODA dei pallet x calcolo previsioni 
		
			kds_queue = u_get_ds_pilota_workqueue( )
			k_righe = kds_queue.retrieve("QUEUE") // nr totale dei pallet in coda di programmazione nel pilota

			kds_queue.setsort( "n_ordine asc")
			kds_queue.sort()

//			u_sort_ds_queue_lav_xfila( )  //DBG
//			kids_ds_queue_lav_xfila.saveas("c:\ufo\queuesort.txt", Text!, true) //DBG

			k_riga = 1
			do while k_riga <= k_righe  

				k_fila = kds_queue.getitemnumber(k_riga,"fila") 
	
				if k_fila > 0 then
					
					u_sort_ds_queue_lav_xfila( )
					
					k_riga_queue = u_get_queue_lav_xfila_primariga(string(k_fila))
					k_dataora_lav_fin = kids_ds_queue_lav_xfila.getitemdatetime(k_riga_queue, "k_dataora_lav_fin")  // get della data di fine lav (prev) che diventa quella di inizio  

//--- add minuti carico	
					if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility
					k_dataora_lav_fin = kiuf_utility.u_datetime_after_minute(k_dataora_lav_fin, 4)

					kds_queue.setitem( k_riga, "dataora_lav_ini", k_dataora_lav_fin)
					u_set_dataora_lav_prev_fin_1(kds_queue, k_riga)  // imposta la data di fine lav prevista

//---- Nella coda dei dati di previsione lav x fila ricopre le vecchie date di inizio-fine con le nuove appena ricavate
					k_dataora_lav_ini = kds_queue.getitemdatetime( k_riga, "dataora_lav_ini")
					k_dataora_lav_fin = kds_queue.getitemdatetime( k_riga, "dataora_lav_fin_prev")
					kids_ds_queue_lav_xfila.setitem(k_riga_queue, "k_dataora_lav_ini", k_dataora_lav_ini)
					kids_ds_queue_lav_xfila.setitem(k_riga_queue, "k_dataora_lav_fin", k_dataora_lav_fin)

//--- Oltre alla riga stessa aggiorna se ci sono eventuali righe di gorupage che hanno lo stesso numero 'ordine', ripete2 volte xchè queste viaggiano sempre in coppia
					k_ordine_queue = kds_queue.getitemnumber(k_riga, "n_ordine")
					k_riga ++
					k_ctr = 1
					do while k_ctr < 3 and  k_riga <= k_righe
						do while k_ordine_queue = kds_queue.getitemnumber(k_riga, "n_ordine") 
							
							//u_set_ds_pilota_queue_data_prev_1(k_riga)
							kds_queue.setitem( k_riga, "dataora_lav_ini", kds_queue.getitemdatetime( k_riga - 1, "dataora_lav_ini"))
							kds_queue.setitem( k_riga, "dataora_lav_fin_prev", kds_queue.getitemdatetime( k_riga - 1, "dataora_lav_fin_prev"))
							kds_queue.setitem( k_riga, "dataora_lav_fin_min_prev", kds_queue.getitemdatetime( k_riga - 1, "dataora_lav_fin_min_prev"))
							kds_queue.setitem( k_riga, "dataora_lav_fin_max_prev", kds_queue.getitemdatetime( k_riga - 1, "dataora_lav_fin_max_prev"))
							kds_queue.setitem( k_riga, "avg_time_io_minute", kds_queue.getitemnumber( k_riga - 1, "avg_time_io_minute"))
							k_riga ++
							if k_riga > k_righe then 
								exit
							end if
							
						loop 
						if  k_riga <= k_righe then
							k_ordine_queue = kds_queue.getitemnumber(k_riga, "n_ordine")
							k_ctr ++
						end if
					loop

				else
					k_riga ++
				end if
	
			loop
			
		end if

		k_rc = kds_queue.update()    // aggiorna i dati su pallet in Programmazione
		
		kguo_sqlca_db_magazzino.db_commit( )

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_dataora_lav_prev_fin () throws uo_exception;//
//--------------------------------------------------------------------------------------
//--- Aggiorna la data di fine lavorazione in tab 'previsioni' per 
//--- i pallet in lavorazione (WORK)
//--- out: righe lavorate
//--------------------------------------------------------------------------------------
//
//
long k_riga, k_righe
int k_rc
datastore kds_1
	
	
	try

		kds_1 = u_get_ds_pilota_workqueue( )
		
		k_righe = kds_1.retrieve("WORK")  // estrae solo i pallet in lavorazione
		
		if k_righe < 1 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.esito = kguo_exception.kk_st_uo_exception_tipo_err_int
			kguo_exception.kist_esito.sqlerrtext = "Il numero di righe estratte dalla tab. temp #" + ki_temptab_pilota_workqueue + " non può essere a zero!"
			kguo_exception.kist_esito.nome_oggetto = this.classname( )
			kguo_exception.scrivi_log( )
			throw kguo_exception
			
		end if
		
		for k_riga = 1 to k_righe	
			
			u_set_dataora_lav_prev_fin_1(kds_1, k_riga)  // imposta la data di fine lav prevista

		end for

		k_rc = kds_1.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_righe
	

end function

private function long u_set_ds_queue_lav_xfila (ref datastore kds_1) throws uo_exception;//---
//--- Popola la CODA per il calcolo delle PREVISIONI, datastore: ds_queue_lav_xfila
//--- inp: ds da caricare nella coda
//--- out: nr righe inserite
//---
int k_rc
long k_rows, k_row, k_row_insert
string k_fila
datetime k_dataora_ini, k_dataora_fin


try 
	if not isvalid(kids_ds_queue_lav_xfila) then
		kids_ds_queue_lav_xfila = create datastore
		kids_ds_queue_lav_xfila.dataobject = ki_ds_queue_lav_xfila_dataobject
	end if
	kids_ds_queue_lav_xfila.reset( )

	k_rows = kds_1.rowcount( )
	if k_rows > 0 then	//--- legge barcode in lav su Pilota 
		

		for k_row = 1 to k_rows
		
			if k_dataora_ini <> kds_1.getitemdatetime( k_row, "dataora_lav_ini") then
				
				k_dataora_ini = kds_1.getitemdatetime( k_row, "dataora_lav_ini")
				k_dataora_fin =  kds_1.getitemdatetime( k_row, "dataora_lav_fin_prev")
				k_fila = string(kds_1.getitemnumber( k_row, "fila"))

				k_row_insert = kids_ds_queue_lav_xfila.insertrow(0)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_ini", k_dataora_ini)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "k_dataora_lav_fin", k_dataora_fin)
				kids_ds_queue_lav_xfila.setitem(k_row_insert, "fila", k_fila) 

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

private function long u_set_temptable_pilota_prev_lav () throws uo_exception;//
//-------------------------------------------------------------------------------------------
//--- Crea la temp table con data inizio-fine lavorazione presunte x Lotto
//--- Out: nr righe inserite in tb
//-------------------------------------------------------------------------------------------
//
//
long k_righe=0, k_riga=0
int k_rc, k_colli
long k_rigainsert
string k_campi
int k_ctr
datastore kds_inp, kds_out
 	
	try
		
//--- popola pallet in lav e in coda in una tabella di appoggio: #vx_pilota_prev_lav

		k_campi = "id_cliente int " &
					 	+ " , id_meca int " &
					 	+ " , num_int int " &
					 	+ " , data_int date " &
						 + ", f1avp smallint " &
						 + ", f1app smallint " &
						 + ", f2avp smallint " &
						 + ", f2app smallint " &
					 	+ " , fila tinyint " &
					 	+ " , consegna_data date " & 	 
					 	+ " , pilota_ordine int "  &
					 	+ " , colli_lav_ent char(12) " & 
					 	+ " , note varchar(120) " & 
					 	+ " , prev_dataora_lav_ini datetime " &
					 	+ " , prev_dataora_lav_fin datetime " &
					 	+ " , prev_dataora_lav_fin_min datetime " &
					 	+ " , prev_dataora_lav_fin_max datetime " &
						+ " , avg_time_io_minute int "  
//	   	kguo_sqlca_db_magazzino.db_crea_temp_table_global(ki_temptab_pilota_prev_lav, k_campi, "")      
	   	kguo_sqlca_db_magazzino.db_crea_temp_table(ki_temptab_pilota_prev_lav, k_campi, "")      
//	   	kguo_sqlca_db_magazzino.db_crea_table( ki_temptab_pilota_prev_lav, k_campi)      
				
		kds_out = CREATE datastore
		kds_out.dataobject = "ds_pilota_xlotto_prev_lav"
		k_rc = kds_out.SetTransObject (kguo_sqlca_db_magazzino)
		kguf_data_base.u_set_ds_change_name_tab(kds_out, "vx_MAST_pilota_prev_lav")
				
		kds_inp = CREATE datastore
		kds_inp.dataobject = "ds_pilota_pallet_workqueue_temp"
		k_rc = kds_inp.SetTransObject (kguo_sqlca_db_magazzino)
		kguf_data_base.u_set_ds_change_name_tab(kds_inp, "vx_MAST_pilota_pallet_workqueue")
		
		k_righe = kds_inp.retrieve() // nr totale dei pallet in lavorazione nel pilota
		for k_riga = 1 to k_righe 
			k_rigainsert = kds_out.insertrow( 0 )
			kds_out.setitem( k_rigainsert, "id_cliente", 0 )
			kds_out.setitem( k_rigainsert, "id_meca", kds_inp.getitemnumber(k_riga, "id_meca") )
			kds_out.setitem( k_rigainsert, "f1avp", kds_inp.getitemnumber(k_riga, "f1avp") )
			kds_out.setitem( k_rigainsert, "f1app", kds_inp.getitemnumber(k_riga, "f1app") )
			kds_out.setitem( k_rigainsert, "f2avp", kds_inp.getitemnumber(k_riga, "f2avp") )
			kds_out.setitem( k_rigainsert, "f2app", kds_inp.getitemnumber(k_riga, "f2app") )
			kds_out.setitem( k_rigainsert, "fila", kds_inp.getitemnumber(k_riga, "fila") )
			kds_out.setitem( k_rigainsert, "pilota_ordine", kds_inp.getitemnumber(k_riga, "n_ordine") )
			kds_out.setitem( k_rigainsert, "note", "" )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_ini", kds_inp.getitemdatetime(k_riga, "dataora_lav_ini") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_prev") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin_min", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_min_prev") )
			kds_out.setitem( k_rigainsert, "prev_dataora_lav_fin_max", kds_inp.getitemdatetime(k_riga, "dataora_lav_fin_max_prev") )
			kds_out.setitem( k_rigainsert, "avg_time_io_minute", kds_inp.getitemnumber(k_riga, "avg_time_io_minute") )
		end for

		k_rc = kds_out.update() 
		
		kguo_sqlca_db_magazzino.db_commit( )
		
	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally

	end try
		

return k_rigainsert
	

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
	if isvalid(kids_barcode_avgtimeplant) then destroy kids_barcode_avgtimeplant 
	if isvalid(kids_ds_queue_lav_xfila) then destroy kids_ds_queue_lav_xfila
	if isvalid(kiuf_utility) then destroy kiuf_utility 

end event

event constructor;//

try
	ki_temptab_pilota_workqueue = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_pallet_workqueue")
	ki_temptab_pilota_prev_lav = kguf_data_base.u_change_nometab_xutente( "vx_MAST_pilota_prev_lav")

	u_set_barcode_avgtimeplant( ) //--- popola ds tempi medi impianto

catch (uo_exception kuo_exception)
	
end try

end event

