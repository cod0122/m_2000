$PBExportHeader$kuf_sv_skedula.sru
forward
global type kuf_sv_skedula from nonvisualobject
end type
end forward

global type kuf_sv_skedula from nonvisualobject
end type
global kuf_sv_skedula kuf_sv_skedula

type variables
//
//--- VALORI della tab sv_skedula colonna STATO:
//--- 1=pronta, da inserire tra le funzioni da schedulare 
//--- 2=sospeso
//--- 3=obsoleto
//--- 5=schedulato
//
//--- VALORI della tab sv_eventi_sked colonna STATO:
//--- 0=da eseguire
//--- 1=
//--- 2=sospeso
//--- 3=
//--- 5=in esecuzione
//--- 7=gia' eseguito

public st_sv_skedula kist_sv_skedula
public st_sv_eventi_sked kist_sv_eventi_sked []
public st_esito kist_esito 
end variables

forward prototypes
public subroutine tb_delete_sv_eventi_sked ()
public subroutine tb_delete ()
public function st_esito tb_aggiorna_stato_sv_eventi_sked ()
public function st_esito tb_aggiorna_stato_sv_skedula ()
public subroutine tb_insert_schedula_eventi ()
public function st_esito genera_eventi ()
end prototypes

public subroutine tb_delete_sv_eventi_sked ();//
//====================================================================
//=== Cancella il rek dalla tabella Eventi Schedulati
//=== 
//=== Input: var.tab.instance kist_sv_skedula_eventi[1].id
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//====================================================================



kist_esito.esito = kkg_esito_ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""

	delete from sv_eventi_sked
		where id = :kist_sv_eventi_sked[1].id
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
					+ "Tab.Eventi Schedulati (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito_db_wrn
			else
				kist_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito_ok
	end if



end subroutine

public subroutine tb_delete ();//
//====================================================================
//=== Cancella il rek dalla tabella Operazioni da Schedulare
//=== 
//=== Input: var.instance kist_sv_skedula.id
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//====================================================================



kist_esito.esito = kkg_esito_ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""

	delete from sv_skedula
		where id = :kist_sv_skedula.id
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
					+ "Tab.Schedulazioni (sv_skedula):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito_db_wrn
			else
				kist_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito_ok
	end if



end subroutine

public function st_esito tb_aggiorna_stato_sv_eventi_sked ();//
//====================================================================
//=== Aggiorna lo stato nella tabella Schedulazioni Eventi
//=== 
//=== Input: var.tab.instance kist_sv_skedula_eventi[1].id
//===                         kist_sv_skedula_eventi[1].stato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


//--- aggiorna lo stato tabella eventi schedulati
	update sv_eventi_sked
		set stato = :kist_sv_eventi_sked[1].stato
		where id = :kist_sv_eventi_sked[1].id
		using sqlca;

    
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Eventi Schedulati (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito_ok
	end if

return kst_esito

end function

public function st_esito tb_aggiorna_stato_sv_skedula ();//
//====================================================================
//=== Aggiorna lo stato nella tabella Operazioni da Schedulare
//=== 
//=== Input: var.instance kist_sv_skedula.id
//===                     kist_sv_skedula.stato
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


//--- aggiorna lo stato Operazioni da Schedulare								
	update sv_skedula
		set stato = :kist_sv_skedula.stato
		where id = :kist_sv_skedula.id
		using sqlca;

    
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" + &
		          "Tab.Schedulazioni Eventi (sv_skedula):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito_db_wrn
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito_ok
	end if

return kst_esito

end function

public subroutine tb_insert_schedula_eventi ();//
//====================================================================
//=== Inserimento rek nella tabella Schedulazioni Eventi
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Standard
//===                                 
//====================================================================



kist_esito.esito = kkg_esito_ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""


  INSERT INTO sv_eventi_sked
         ( id,   
           id_sv_skedula,   
           run_giorno,   
           run_ora,   
           stato,   
           id_menu_window,   
           esito )  
  VALUES ( 0,   
           :kist_sv_eventi_sked[1].id_sv_skedula,   
           :kist_sv_eventi_sked[1].run_giorno,   
           :kist_sv_eventi_sked[1].run_ora,   
           :kist_sv_eventi_sked[1].stato,   
           :kist_sv_eventi_sked[1].id_menu_window,   
           :kist_sv_eventi_sked[1].esito )  
		using sqlca;
    
	if sqlca.sqlcode <> 0 then
		kist_esito.sqlcode = sqlca.sqlcode
		kist_esito.SQLErrText = "Tab.Schedulazioni Eventi (sv_eventi_sked):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kist_esito.esito = kkg_esito_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kist_esito.esito = kkg_esito_db_wrn
			else
				kist_esito.esito = kkg_esito_db_ko
			end if
		end if
	else
		kist_esito.esito = kkg_esito_ok
	end if


end subroutine

public function st_esito genera_eventi ();//
//====================================================================
//=== Genera tabella Eventi da Schedulare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:  Vedi Standard
//====================================================================
string k_dataoggix
date k_dataoggi, k_data
time k_run_ora, k_mezzanotte
int k_giorno, k_num_gg, k_ora
long k_secondi, k_eventi_insert=0
string k_view, k_sql_w, k_sql
pointer kpointer_1 
kuf_base kuf1_base
st_esito kst_esito, kst1_esito


kist_esito.esito = kkg_esito_ok
kist_esito.sqlcode = 0
kist_esito.SQLErrText = ""

DECLARE c_genera_eventi CURSOR FOR  
  SELECT sv_skedula.id,
  			sv_skedula.orario,   
         sv_skedula.rilancia_dopo_mm,   
         sv_skedula.flag_run_giorni,   
         sv_skedula.id_menu_window  
    FROM sv_skedula  
	 where stato = '1' or stato = '5' 
	 order by id_menu_window
	 using sqlca;


	kpointer_1 = setpointer(HourGlass!)

//--- prendi data oggi		
	kuf1_base = create kuf_base
	k_dataoggix = trim(mid(kuf1_base.prendi_dato_base("dataoggi"), 2))
	destroy kuf1_base
	if isdate(k_dataoggix) then
		k_dataoggi = date(k_dataoggix)
	else
		k_dataoggi = today()
	end if

//--- costruisco la tabella armo 
	k_view = "sv_eventi_sked "
	k_sql_w = " "
	k_sql = + &
	"CREATE TABLE 'informix'." + trim(k_view) &
	+ " (id serial not null " &
	+ " ,id_sv_skedula  int " &
	+ " ,run_giorno DATE, run_ora char(6) " &
	+ " ,stato char(1), id_menu_window char(12) " &
	+ " ,esito char (80) ) "
	kuf1_data_base.db_crea_table(1, k_view, k_sql)		

	open c_genera_eventi;
	
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Errore durante la creazione della tabella.~r~n " &
			 + trim(kist_esito.SQLErrText)
		kst_esito.esito = kkg_esito_blok
		
	else
		
		fetch c_genera_eventi into 
		              :kist_sv_skedula.id
		              ,:kist_sv_skedula.orario 
						  ,:kist_sv_skedula.rilancia_dopo_mm 
		         	  ,:kist_sv_skedula.flag_run_giorni   
      			     ,:kist_sv_skedula.id_menu_window ;
						  
		do while sqlca.sqlcode = 0 &
			      and (kist_esito.esito = kkg_esito_ok or kist_esito.esito = kkg_esito_db_wrn)


			kist_sv_eventi_sked[1].id_menu_window = kist_sv_skedula.id_menu_window
         kist_sv_eventi_sked[1].stato = "0"
         kist_sv_eventi_sked[1].esito = "caricato"
			kist_sv_eventi_sked[1].id_sv_skedula = kist_sv_skedula.id
			
//--- popola tabella eventi da oggi x 31 giorni avanti
			for k_giorno = 1 to 32 

				k_data = relativedate ( k_dataoggi, k_giorno )
				k_num_gg = DayNumber ( k_data ) - 1
//--- kist_sv_skedula.flag_run_giorni = 0 ossia tutti i giorni 
				if kist_sv_skedula.flag_run_giorni = "0" &
				   or k_num_gg = integer(kist_sv_skedula.flag_run_giorni) then
			
					kist_sv_eventi_sked[1].run_giorno = k_data
					
					k_run_ora = kist_sv_skedula.orario
					
					if kist_sv_skedula.rilancia_dopo_mm > 0 then
						
						k_secondi = kist_sv_skedula.rilancia_dopo_mm * 60
						k_run_ora = relativetime ( k_run_ora, k_secondi )
						k_mezzanotte = time('23:59:59')
						
//--- inserisce gli eventi dell'applicazione 						
						do while k_run_ora <> k_mezzanotte &
					         and (kist_esito.esito = kkg_esito_ok or kist_esito.esito = kkg_esito_db_wrn)
						
							kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 
							k_run_ora = relativetime ( k_run_ora, k_secondi )
						
							tb_insert_schedula_eventi()
							if kist_esito.esito = kkg_esito_ok then
								k_eventi_insert++
								
//--- aggiorna lo stato della tab schedulati
								kist_sv_skedula.stato = '5'
								kst1_esito = tb_aggiorna_stato_sv_skedula()

							end if
							
						loop
						
					else
						kist_sv_eventi_sked[1].run_ora = string(k_run_ora, "hh:mm") 
						tb_insert_schedula_eventi()
						if kist_esito.esito = kkg_esito_ok then
							k_eventi_insert++
							
//--- aggiorna lo stato della tab schedulati
							kist_sv_skedula.stato = '5'
							kst1_esito = tb_aggiorna_stato_sv_skedula()

						end if
						
					end if
					
					if kist_esito.esito = kkg_esito_ok or kist_esito.esito = kkg_esito_db_wrn then
						kuf1_data_base.db_commit()
					end if
			
				end if	
				
			next	

			fetch c_genera_eventi into 
			              :kist_sv_skedula.id
			              ,:kist_sv_skedula.orario 
							  ,:kist_sv_skedula.rilancia_dopo_mm 
							  ,:kist_sv_skedula.flag_run_giorni   
							  ,:kist_sv_skedula.id_menu_window ;
		loop
	
	end if


	if k_eventi_insert > 0 then
		kst_esito.sqlcode = k_eventi_insert
		kst_esito.SQLErrText =  &
			 "Inseriti " + string (k_eventi_insert) &
			+ " eventi in schedulazione. Operazione terminata."
		kst_esito.esito = kkg_esito_ok
	else
		kst_esito.sqlcode = 999
		kst_esito.SQLErrText = trim(This.ClassName()) + "~r~n" &
		    + "Nessun evento schedulato. "
		kst_esito.esito = kkg_esito_blok
	end if


return kst_esito


end function

on kuf_sv_skedula.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sv_skedula.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

