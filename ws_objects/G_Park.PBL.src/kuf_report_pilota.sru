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
public string ki_ds_pilota_pallet_in_lav_dataobject = "d_report_3_pilota_pallet_in_lav"

private datastore kids_d_report_3_pilota_pallet_in_lav
private datastore kids_barcode_avgtimeplant
private kuf_utility kiuf_utility

end variables

forward prototypes
public subroutine _readme ()
private function long u_set_dati_barcode (ref datastore kds_1) throws uo_exception
private function long u_set_dati_clie (ref datastore kds_1) throws uo_exception
private function long u_set_dati_meca (ref datastore kds_1) throws uo_exception
private function long u_set_dati_avgtimeplant (ref datastore kds_1) throws uo_exception
public function datastore u_get_barcode_in_lav_all_data () throws uo_exception
public function datastore u_get_barcode_in_lav () throws uo_exception
private function long u_get_row_ds_in_lav_last (integer k_fila)
public function st_report_pilota u_get_st_report_pilota_in_lav_last_f1 ()
private function st_report_pilota u_get_st_report_pilota_in_lav_last (long k_row)
public function st_report_pilota u_get_st_report_pilota_in_lav_last_f2 ()
private function long u_get_row_ds_in_lav_last_f1 ()
private function long u_get_row_ds_in_lav_last_f2 ()
private function datastore u_get_st_report_pilota_in_lav_sort_fin ()
end prototypes

public subroutine _readme ();//
//--- Get dati dal PILOTA insieme ai dati di M2000
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
			
			kds_1.object.id_meca[k_riga] = 0
			kds_1.object.k_data_lav_ini[k_riga] = date(0) //setnull(kst_tab_barcode.data_lav_ini)
			kds_1.object.k_ora_lav_ini[k_riga] = time(0) //setnull(kst_tab_barcode.ora_lav_ini)
			kds_1.object.k_dataora_lav_prev_fin[k_riga] = datetime(date(0), time(0))
			kds_1.object.k_colli[k_riga] = "" 
			
			kst_tab_barcode.barcode = kds_1.object.barcode[k_riga]

			select distinct
					barcode.id_meca
					,barcode.data_lav_ini
					,barcode.ora_lav_ini
				into
					:kst_tab_barcode.id_meca
					,:kst_tab_barcode.data_lav_ini
					,:kst_tab_barcode.ora_lav_ini
				from barcode
				where barcode.barcode = :kst_tab_barcode.barcode 
				using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlcode = 0 then

				if kst_tab_barcode.id_meca > 0 and kst_tab_barcode.id_meca <>kst_tab_barcode_app.id_meca then
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
				
			end if
			
			if kst_tab_barcode.id_meca > 0 then
			
				if kst_tab_barcode.id_meca > 0 then
					kds_1.object.id_meca[k_riga] = kst_tab_barcode.id_meca
				end if
				if kst_tab_barcode.data_lav_ini > kkg.data_no then
					kds_1.object.k_data_lav_ini[k_riga] = kst_tab_barcode.data_lav_ini
				end if
				if kst_tab_barcode.ora_lav_ini > time(0) then
					kds_1.object.k_ora_lav_ini[k_riga] = kst_tab_barcode.ora_lav_ini
				end if
	
				if k_colli > 0 then
					kds_1.object.k_colli[k_riga] = trim(string(k_colli_tr)) + " . " + trim(string(k_colli)) 
				end if
	
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
						kds_1.object.k_consegna_data[k_riga] = string(kst_tab_meca.consegna_data,"dd.mm.yy")
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

private function long u_set_dati_avgtimeplant (ref datastore kds_1) throws uo_exception;//
//======================================================================
//=== Aggiunge dati i tempi medi di uscita impiano al ds
//======================================================================
//
//
long k_righe=0, k_riga=0
long k_riga_avgtimeplant
datetime k_dataora_lav_fin_prev, k_dataora_lav_ini
st_tab_barcode kst_tab_barcode
st_tab_s_avgtimeplant kst_tab_s_avgtimeplant_avg, kst_tab_s_avgtimeplant_min, kst_tab_s_avgtimeplant_max

	
	try
		
		if not isvalid(kiuf_utility) then kiuf_utility = create kuf_utility
		
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
		k_righe = kds_1.rowcount()

		for k_riga = 1 to k_righe

			kds_1.object.k_dataora_lav_prev_fin[k_riga] = datetime(date(0), time(0))

			kst_tab_barcode.data_lav_ini = kds_1.getitemdate(k_riga, "k_data_lav_ini")
			if kst_tab_barcode.data_lav_ini > kkg.data_no then
				
				kst_tab_barcode.ora_lav_ini = kds_1.getitemtime(k_riga, "k_ora_lav_ini")

				if IsNumber(trim(kds_1.object.f1avp[k_riga])) then
					kst_tab_barcode.fila_1 = integer(trim(kds_1.object.f1avp[k_riga]))
				end if
				if IsNumber(trim(kds_1.object.f2avp[k_riga])) then
					kst_tab_barcode.fila_2 = integer(trim(kds_1.object.f2avp[k_riga]))
				end if
				if IsNumber(trim(kds_1.object.f1app[k_riga])) then
					kst_tab_barcode.fila_1p = integer(trim(kds_1.object.f1app[k_riga]))
				end if
				if IsNumber(trim(kds_1.object.f2app[k_riga])) then
					kst_tab_barcode.fila_2p = integer(trim(kds_1.object.f2app[k_riga]))
				end if
				
				k_riga_avgtimeplant = kids_barcode_avgtimeplant.find( "giri_f1 = " + string(kst_tab_barcode.fila_1) &
																+ " and giri_f1p = " + string(kst_tab_barcode.fila_1p) &
																+ " and giri_f2 = " + string(kst_tab_barcode.fila_2) &
																+ " and giri_f2p = " + string(kst_tab_barcode.fila_2p) &
																,1 , kids_barcode_avgtimeplant.rowcount( ), primary!)
				
				if k_riga_avgtimeplant > 0 then
					
					kst_tab_s_avgtimeplant_avg.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_avg")
					kst_tab_s_avgtimeplant_min.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_min")
					kst_tab_s_avgtimeplant_max.time_io_minute = kids_barcode_avgtimeplant.getitemnumber(k_riga_avgtimeplant, "k_time_io_minute_max")
					kds_1.setitem(k_riga, "k_time_io_minute", kst_tab_s_avgtimeplant_avg.time_io_minute)
		
					k_dataora_lav_ini = datetime(kst_tab_barcode.data_lav_ini, kst_tab_barcode.ora_lav_ini)
		//--- calcola le previsioni aggiungendo i minuti previsti per l'uscita
					k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_avg.time_io_minute)
					if date(k_dataora_lav_fin_prev) > kkg.data_no then
						kds_1.setitem(k_riga, "k_dataora_lav_prev_fin", k_dataora_lav_fin_prev)
						
					end if
					k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_min.time_io_minute)
					if date(k_dataora_lav_fin_prev) > kkg.data_no then
						kds_1.setitem(k_riga, "k_dataora_lav_prev_fin_min", k_dataora_lav_fin_prev)
						
					end if
					k_dataora_lav_fin_prev = kiuf_utility.u_datetime_after_minute(k_dataora_lav_ini, kst_tab_s_avgtimeplant_max.time_io_minute)
					if date(k_dataora_lav_fin_prev) > kkg.data_no then
						kds_1.setitem(k_riga, "k_dataora_lav_prev_fin_max", k_dataora_lav_fin_prev)
						
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

public function datastore u_get_barcode_in_lav_all_data () throws uo_exception;//---
//--- Legge i barcode in lavorazione nel PILOTA e add all data from M2000
//---
//
int k_rc
long k_rows

try 
	
	u_get_barcode_in_lav()
	
	if kids_d_report_3_pilota_pallet_in_lav.rowcount( ) > 0 then
	
		u_set_dati_barcode(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_meca(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_clie(kids_d_report_3_pilota_pallet_in_lav)
		u_set_dati_avgtimeplant(kids_d_report_3_pilota_pallet_in_lav)

	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_3_pilota_pallet_in_lav
end function

public function datastore u_get_barcode_in_lav () throws uo_exception;//---
//--- Legge i barcode in lavorazione nel PILOTA
//---
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
			kguo_exception.kist_esito.sqlerrtext = "Errore di connessione per leggere i barcode in lavorazione in impianto. Il server del PILOTA sembra non rispondere. Operazione Interrotta!"
			throw kguo_exception
		end if
	end if

	k_rows	= kids_d_report_3_pilota_pallet_in_lav.retrieve(date(0))

	if k_rows < 0 then
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.sqlcode = k_rows
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlerrtext = "Errore in lettura barcode in lavorazione in impianto. Il server del PILOTA sembra non rispondere. Operazione Interrotta!"
		throw kguo_exception
	end if


catch (uo_exception kuo_exception)
	throw kguo_exception
	
finally
	
end try

return kids_d_report_3_pilota_pallet_in_lav
end function

private function long u_get_row_ds_in_lav_last (integer k_fila);//
//--- Restituisce la riga del ds con la previsione del primo barcode in uscita da Fila indicata
//--- inp: numero fila 1 o 2
//--- out: nr riga del ds con la data media di uscita più bassa
//
long k_return 
long k_rows
long k_row
string k_fila_x
datetime k_time_in_lav_last


k_rows = kids_d_report_3_pilota_pallet_in_lav.rowcount()

if k_rows > 0 then

	if k_fila = 1 then
		k_fila_x = "f1"
	else
		k_fila_x = "f2"
	end if

	if trim(kids_d_report_3_pilota_pallet_in_lav.getitemstring(1, (k_fila_x + "avp"))) > "00" or trim(kids_d_report_3_pilota_pallet_in_lav.getitemstring(1, (k_fila_x + "app"))) > "00" then
		k_time_in_lav_last = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(1, "k_dataora_lav_prev_fin")
		k_return = 1
	end if
	
	for k_row = 2 to k_rows
		
		if trim(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_row, (k_fila_x + "avp"))) > "00" or trim(kids_d_report_3_pilota_pallet_in_lav.getitemstring(k_row, (k_fila_x + "app"))) > "00" then
			if k_time_in_lav_last > kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_row, "k_dataora_lav_prev_fin") then
				
				k_return = k_row
				
				k_time_in_lav_last = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime(k_row, "k_dataora_lav_prev_fin")
				
			end if
		end if
		
	next

end if

return k_return
end function

public function st_report_pilota u_get_st_report_pilota_in_lav_last_f1 ();//
//--- Restituisce i dati nella struttura st_report_pilota di previsione del primo barcode in uscita da Fila 1
//--- inp:
//--- out: st_report_data con le date di previsione impostate
//
long k_row
st_report_pilota kst_report_pilota 


	k_row = u_get_row_ds_in_lav_last_f1()
	
	kst_report_pilota = u_get_st_report_pilota_in_lav_last(k_row)
	

return kst_report_pilota
end function

private function st_report_pilota u_get_st_report_pilota_in_lav_last (long k_row);//
//--- Restituisce i dati nella struttura st_report_pilota di previsione del primo barcode in uscita 
//--- inp: nr. riga da cui prendere i dati
//--- out: st_report_data con le date di previsione impostate
//
st_report_pilota kst_report_pilota 

	
	if k_row > 0 then
		
		kst_report_pilota.dataora_lav_prev_fin = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_prev_fin")
		kst_report_pilota.dataora_lav_prev_fin_min = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_prev_fin_min")
		kst_report_pilota.dataora_lav_prev_fin_max = kids_d_report_3_pilota_pallet_in_lav.getitemdatetime( k_row, "k_dataora_lav_prev_fin_max")
		
	end if


return kst_report_pilota
end function

public function st_report_pilota u_get_st_report_pilota_in_lav_last_f2 ();//
//--- Restituisce i dati nella struttura st_report_pilota di previsione del primo barcode in uscita da Fila 2
//--- inp:
//--- out: st_report_data con le date di previsione impostate
//
long k_row
st_report_pilota kst_report_pilota 


	k_row = u_get_row_ds_in_lav_last_f2()
	
	kst_report_pilota = u_get_st_report_pilota_in_lav_last(k_row)
	

return kst_report_pilota
end function

private function long u_get_row_ds_in_lav_last_f1 ();//
//--- Restituisce la riga del ds con la previsione del primo barcode in uscita da Fila 1
//--- inp:
//--- out: nr riga del ds con la data media di uscita più bassa
//
long k_return 


	k_return = u_get_row_ds_in_lav_last(1)


return k_return
end function

private function long u_get_row_ds_in_lav_last_f2 ();//
//--- Restituisce la riga del ds con la previsione del primo barcode in uscita da Fila 2
//--- inp:
//--- out: nr riga del ds con la data media di uscita più bassa
//
long k_return 


	k_return = u_get_row_ds_in_lav_last(2)


return k_return
end function

private function datastore u_get_st_report_pilota_in_lav_sort_fin ();//
//--- Restituisce il ds ordinato per data prevista di uscita materiale 
//--- inp:
//--- out: datastore ds_d_report_3_pilota_pallet_in_lav
//
datastore kds_d_report_3_pilota_pallet_in_lav
long k_row, k_rows


	kds_d_report_3_pilota_pallet_in_lav = create datastore
	kds_d_report_3_pilota_pallet_in_lav.dataobject = kids_d_report_3_pilota_pallet_in_lav.dataobject

	kids_d_report_3_pilota_pallet_in_lav.setfilter( "f1avp = '00' or f1avp = '' ")
	kids_d_report_3_pilota_pallet_in_lav.filter( )
	k_rows = kids_d_report_3_pilota_pallet_in_lav.rowcount( )
	
	if k_row > 0 then

		kids_d_report_3_pilota_pallet_in_lav.setsort("k_dataora_lav_prev_fin asc")
		kids_d_report_3_pilota_pallet_in_lav.sort( )
		
		kids_d_report_3_pilota_pallet_in_lav.rowscopy( 1, k_rows, primary!, kds_d_report_3_pilota_pallet_in_lav, 1, primary!)

	end if


return kds_d_report_3_pilota_pallet_in_lav
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
	if isvalid(kids_d_report_3_pilota_pallet_in_lav) then destroy kids_d_report_3_pilota_pallet_in_lav 
	if isvalid(kids_barcode_avgtimeplant) then destroy kids_barcode_avgtimeplant 
	if isvalid(kiuf_utility) then destroy kiuf_utility 

end event

