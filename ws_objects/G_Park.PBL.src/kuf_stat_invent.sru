$PBExportHeader$kuf_stat_invent.sru
forward
global type kuf_stat_invent from kuf_parent
end type
end forward

global type kuf_stat_invent from kuf_parent
end type
global kuf_stat_invent kuf_stat_invent

forward prototypes
public function boolean crea_view_6 (st_stat_invent kast_stat_invent) throws uo_exception
public subroutine crea_view_altri_dati (st_stat_invent kast_stat_invent)
public function boolean crea_view_8 (st_stat_invent kast_stat_invent) throws uo_exception
private subroutine crea_view_x_data_fatt (st_stat_invent kast_stat_invent)
private subroutine crea_view_x_data_fatt_id_armo (st_stat_invent kast_stat_invent)
private subroutine crea_view_x_data_fatt_id_meca (st_stat_invent kast_stat_invent)
public function boolean visualizza_importi ()
end prototypes

public function boolean crea_view_6 (st_stat_invent kast_stat_invent) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Crea le View per le query - MATERIALE TRATTATO
//----------------------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo
kuf_utility kuf1_utility
pointer kpointer  



//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kuf1_utility = create kuf_utility
	kuf1_armo = create kuf_armo

//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
	crea_view_x_data_fatt(kast_stat_invent)
	crea_view_x_data_fatt_id_meca(kast_stat_invent)

//--- costruisco la view dei Trattati  
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLav" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " (barcode,  id_meca, id_armo ) AS   "  
	k_sql +=  &
			 + " SELECT distinct " &
			 + " barcode.barcode " &
			 + " ,barcode.id_meca " &
			 + " ,barcode.id_armo " &
			 + " FROM barcode  " &
			 + "      LEFT OUTER JOIN s_armo ON " &
			 + "  barcode.id_meca = s_armo.id_meca " &
			 + "	where "  
	choose case kast_stat_invent.tipo_data
			
		case '1' // x data fine lavorazione (prendo i dati andando un tot di gg indietro)
//--- piglia il id_meca da cui partire			
			kst_tab_armo.data_int = kast_stat_invent.data_da
			kuf1_armo.get_id_meca_da_data(kst_tab_armo)
			k_sql +=  &
					 " barcode.id_meca > " + string(kst_tab_armo.id_meca)  
			if kast_stat_invent.flag_trattati	then 
				k_sql +=  &
   			              "  and barcode.data_lav_fin > '" + string(date(0)) + "' " &
						+ " and  barcode.data_lav_fin <= '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' " 
			else						 
				k_sql +=  &
					 " and (barcode.data_lav_fin > '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' or barcode.data_lav_fin is null )" 
			end if

//			 + "  (select id_armo from  armo where data_int > '" + string(relativedate(kast_stat_invent.data_a, -720), "dd/mm/yyyy")  + "' )"  
//			 + " and  barcode.data_lav_fin between '" + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
//			 + " and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

		case '2' //  x data fine fatturazione
			if kast_stat_invent.flag_trattati	then 
				k_sql +=  &
   			              "  barcode.data_lav_fin > '" + string(date(0)) + "' " &
					 + " and  barcode.data_lav_fin <= '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' " 
			else
				k_sql +=  &
			 		" ( barcode.data_lav_fin <= '01/01/1990'  or barcode.data_lav_fin is null) " 
			end if
			k_sql +=  &
					 " and barcode.id_armo in " &  
					 + "  (select id_armo from  " + "vx_" + trim(kast_stat_invent.utente) + "_stat_dfat )"  
				
		case '3' // x data di riferimento
			if kast_stat_invent.flag_trattati	then 
				k_sql +=  &
  			     	"  barcode.data_lav_fin > '" + string(date(0)) + "' " 
			else
				k_sql +=  &
			 		" ( barcode.data_lav_fin <= '01/01/1990'  or barcode.data_lav_fin is null) " 
			end if
			k_sql +=  &
			 + " and  s_armo.data_int between '" + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  
			 
	end choose
	if kast_stat_invent.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql_w += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			k_sql_w += " and s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql_w = k_sql_w + " and s_armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql_w = k_sql_w + "and s_armo.dose = " + kast_stat_invent.dose_str + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
	else
		k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
	end if
	k_sql += " " + trim(k_sql_w)  //+ " group by 1, 2  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei Trattati  
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavColli"  + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = " " 
	k_sql =  "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT  " &
			 + " barcode.id_meca " &
			 + " ,barcode.id_armo " &
			 + " ,count(*)  as colli " &
			 + " FROM barcode  " &
			 + " where barcode.barcode in ( " &
 			 + " SELECT distinct " &
			 + " a.barcode " &
			 + " FROM " + "vx_" + trim(kast_stat_invent.utente) + "_statLav" + string(kast_stat_invent.stat_tab) + " as a  " &
			 + " ) " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei  Spediti (Ritirati) 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavSped"  + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " s_arsp.id_meca " &
			 + " ,s_arsp.id_armo " &
			 + " ,sum(NVL(s_arsp.colli,0))  as colli " &
			 + " FROM  s_arsp " 
	k_sql +=  &
			 "	  where (s_arsp.data_rit is null or (s_arsp.data_rit > date(0) " &  
			 + "	      and s_arsp.data_rit <= '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "')  )"  &
			 + "   and s_arsp.id_armo in ( " &
 			 + " SELECT distinct " &
			 + " a.id_armo " &
			 + " FROM " + "vx_" + trim(kast_stat_invent.utente) + "_statLavColli" + string(kast_stat_invent.stat_tab) + " as a  " &
			 + " ) " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei Rif Trattati meno gli Spediti (Ritirati) maggiori di zero 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = " " 
	k_sql =  &
	"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " a.id_meca " &
			 + " ,a.id_armo " &
			 + " ,a.colli - NVL(s.colli,0)  as colli " &
			 + " FROM   vx_" + trim(kast_stat_invent.utente) + "_statLavColli" + string(kast_stat_invent.stat_tab) + " as a  " & 
			 + "   left outer join  vx_" + trim(kast_stat_invent.utente) + "_statLavSped" + string(kast_stat_invent.stat_tab) + " as s  on " & 
			 + "   a.id_armo = s.id_armo " &
	          + "  where s.colli is null or a.colli > s.colli " 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view con Entrata
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statarmo5" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli_2, m_cubi, pedane, importo ) AS   " 
 	k_sql =  k_sql &
			 + " SELECT  " &
			 + " s_armo.id_meca " &
			 + " ,s_armo.id_armo " &
			 + " ,sum(s_armo.colli_2) " & 
			 + " ,sum(s_armo.m_cubi / s_armo.colli_2) " & 
			 + " ,sum(s_armo.pedane / s_armo.colli_2) " &
			 + " ,sum( (NVL(s_armo.imp_fatt,0) + NVL(s_armo.imp_da_fatt,0)) / s_armo.colli_2 ) " &
			 + " FROM s_armo  " &
			 + "	where " &  
			 + "	  s_armo.id_armo in (select distinct id_armo from " + "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped" + string(kast_stat_invent.stat_tab) + ") " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view con colli_fatturati
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statarfa5" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_armo,  colli_fatt) AS   " 
	k_sql += &
			 + " SELECT distinct " &
			 + " id_armo " &
			 + " ,sum(colli) " &   
			 + " FROM arfa  " &
			 + "	where " &  
			 + "	  arfa.tipo_doc = 'FT' and arfa.id_armo in (select distinct id_armo from " + "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped" + string(kast_stat_invent.stat_tab) + " " + ") "  
//--- se richiesto ESTRAZIONE dei "non ancora fatturati" oppure "gia' Fatturati".....			 
//	if trim(string(tab_1.selectedtab)) = "5" or trim(string(tab_1.selectedtab)) = "6" then
	if kast_stat_invent.flag_fatturati = "N" or kast_stat_invent.flag_fatturati = "S" then
		k_sql += " and data_fatt between '" + string(kast_stat_invent.data_da) + "' and '" + string(kast_stat_invent.data_a) + "'"
	end if
	k_sql += " group by id_armo "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- Union delle tabelle per simularne una sola
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv_5" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca,  id_armo, colli_lav, colli_trattati_da_sped, colli_2,  colli_sped, colli_fatt, m_cubi, pedane, importo) AS   " & 
	 + " SELECT " &
	 + " r.id_meca, " &
	 + " r.id_armo, " &
	 + " 0, " &   
	 + " 0,  " &   
	 + " sum(r.colli_2), " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " sum(r.m_cubi), " &   
	 + " sum(r.pedane), " &
	 + " r.importo " &
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statarmo5" + string(kast_stat_invent.stat_tab) + " " + " as r  " &  
	 + " group by 1,2,3,4,6,7,10 "  &
	 + " union all " &
	 + " SELECT " &
	 + " nosp.id_meca, " &
	 + " nosp.id_armo, " &
	 + " sum(lav.colli),  " &   
	 + " sum(nosp.colli),  " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &
	 + " 0 " &
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped" + string(kast_stat_invent.stat_tab) + " " + " as nosp " &
	 + "          inner join vx_" + trim(kast_stat_invent.utente) + "_statLavColli" + string(kast_stat_invent.stat_tab) + " as lav on  " &	 
	 + " nosp.id_armo = lav.id_armo " &
	 + " group by 1,2, 5,6,7,8,9,10 "  
	k_sql = k_sql + " " + trim(k_sql_w) 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- costruisco la view con valorizzazione x singola riga Lotto 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv15" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca,  id_armo, colli_2, colli_lav, colli_trattati_da_sped, colli_da_sped, colli_fatt,  m_cubi, pedane, importo) AS   " & 
	 + " SELECT " &
	 + " s.id_meca, " &
	 + " s.id_armo, " &
	 + " sum(s.colli_2), " &   
	 + " sum(s.colli_lav),  " &   
	 + " sum(s.colli_trattati_da_sped),  " &   
	 + " sum(s.colli_2) - sum(s.colli_sped), " &   
	 + " f.colli_fatt,  " &   
	 + " sum(s.m_cubi)  * (sum(s.colli_trattati_da_sped)), " &   
	 + " sum(s.pedane)  * (sum(s.colli_trattati_da_sped)), " &   
	 + " sum(s.importo) * (sum(s.colli_trattati_da_sped)) " &   
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statinv_5" + string(kast_stat_invent.stat_tab) + " as s left outer join vx_" + trim(kast_stat_invent.utente) + "_statarfa5" + string(kast_stat_invent.stat_tab) + " as f on " &
	 + "  s.id_armo = f.id_armo "  
	k_sql = k_sql + " " + trim(k_sql_w) + &
	" group by 1, 2, 7 "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- costruisco la temp-table con valorizzazione x singolo Lotto 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv25" + string(kast_stat_invent.stat_tab)	
	k_sql_w = " "
	k_sql =  &
	 + " SELECT distinct" &
	 + " s.id_meca, " &
	 + " s_armo.num_int, " &
	 + " s_armo.data_int, " &
	 + " s_armo.clie_1, " &
	 + " s_armo.clie_2, " &
	 + " s_armo.clie_3, " &
	 + " (s.colli_2),  " &   
	 + " (s.colli_lav),  " &   
	 + " (s.colli_trattati_da_sped),  " &   
	 + " (s.colli_da_sped),  " &   
	 + " (s.colli_fatt),  " &   
	 + " (s.m_cubi), " &   
	 + " (s.pedane), " &   
	 + " (s.importo) " &   
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statinv15" + string(kast_stat_invent.stat_tab) + " as s  " &
	 + "             INNER JOIN s_armo ON " &
	 + "  s.id_meca = s_armo.id_meca " 
	k_sql = k_sql + " " + trim(k_sql_w) 
//	" group by 1, 2, 3, 4, 5, 6 "

	k_campi =  &
			 + " id_meca integer" &
			 + " ,num_int integer " &
			 + " ,data_int date " &
			 + " ,clie_1 integer " &
			 + " ,clie_2 integer " &
			 + " ,clie_3 integer " &
			 + " ,colli_2 integer " &
			 + " ,colli_lav integer " &
			 + " ,colli_trattati_da_sped integer " &
			 + " ,colli_da_sped integer " &
			 + " ,colli_fatt integer " & 
			 + " ,m_cubi decimal(9,2) " &
			 + " ,pedane decimal(5,2) " &
			 + " ,importo decimal(12,2) " 
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		


	destroy kuf1_utility
	destroy kuf1_armo
	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)

return k_esegui_query
//
end function

public subroutine crea_view_altri_dati (st_stat_invent kast_stat_invent);//----------------------------------------------------------------------------------------------------------------------------------------
//--- Crea le View per le query
//----------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view x Reperire il Numero Attestato 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_num_certif"  + string(kast_stat_invent.stat_tab)
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, num_certif ) AS   " &
	 + " SELECT distinct " &
	 + "    id_meca, max(num_certif)  " &
	 + " FROM armo inner join artr on armo.id_armo =  artr.id_armo " &
	 + " where " 

	choose case kast_stat_invent.tipo_data
			
		case '1', '2' // x data fine lavorazione e fatt
	 
		k_sql +=  &
			 + "	  armo.data_int between '" &
			 + string(relativedate(kast_stat_invent.data_da,-180), "dd/mm/yyyy") + "' and '" &
			 + string(relativedate(kast_stat_invent.data_a, +180), "dd/mm/yyyy") + "' "  

		case '3' // x data Riferimento
	 
			k_sql +=  &
			 + "	  armo.data_int between '" &
			 + string(kast_stat_invent.data_da, "dd/mm/yyyy") &
			 + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	end choose
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			if kast_stat_invent.gruppo_flag = 0 then
				k_sql += " and (armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " or armo.gruppo is null)  "
			end if
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql += " and armo.dose = 0 " + " "
	else
		if kast_stat_invent.dose > 0 then
			k_sql += " and armo.dose = " + kast_stat_invent.dose_str + " "
		end if
	end if
 	k_sql += " GROUP BY id_meca "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view x Reperire il Numero Fattura + alto x id_meca
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_id_fattura"  + string(kast_stat_invent.stat_tab)
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_fattura ) AS   " &
	 + " SELECT distinct " &
	 + "    id_meca, max(id_fattura)   " &
	 + " FROM armo inner join arfa on armo.id_armo =  arfa.id_armo " &
	 + " where " 

	choose case kast_stat_invent.tipo_data
			
		case '1', '2' // x data fine lavorazione e fatt
	 
		k_sql +=  &
			 + "	  armo.data_int between '" &
			 + string(relativedate(kast_stat_invent.data_da,-180), "dd/mm/yyyy") + "' and '" &
			 + string(relativedate(kast_stat_invent.data_a, +180), "dd/mm/yyyy") + "' "  

		case '3' // x data Riferimento
	 
			k_sql +=  &
			 + "	  armo.data_int between '" &
			 + string(kast_stat_invent.data_da, "dd/mm/yyyy") &
			 + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	end choose
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			if kast_stat_invent.gruppo_flag = 0 then
				k_sql += " and (armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " or armo.gruppo is null)  "
			end if
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql += " and armo.dose = 0 " + " "
	else
		if kast_stat_invent.dose > 0 then
			k_sql += " and armo.dose = " + kast_stat_invent.dose_str + " "
		end if
	end if
 	k_sql += " GROUP BY id_meca "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)


end subroutine

public function boolean crea_view_8 (st_stat_invent kast_stat_invent) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------------------------------
//--- Crea le View per le query - MATERIALE NON TRATTATO
//----------------------------------------------------------------------------------------------------------------------------------------------------
//
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
st_tab_armo kst_tab_armo
kuf_utility kuf1_utility
kuf_armo kuf1_armo
pointer kpointer  



//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kuf1_utility = create kuf_utility
	kuf1_armo = create kuf_armo

//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
	crea_view_x_data_fatt(kast_stat_invent)
	crea_view_x_data_fatt_id_meca(kast_stat_invent)

//--- costruisco la view dei Trattati  
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLav "
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " (barcode,  id_meca, id_armo ) AS   "  
	k_sql +=  &
			 + " SELECT distinct " &
			 + " barcode.barcode " &
			 + " ,barcode.id_meca " &
			 + " ,barcode.id_armo " &
			 + " FROM barcode  " &
			 + "      LEFT OUTER JOIN s_armo ON " &
			 + "  barcode.id_meca = s_armo.id_meca " &
			 + "	where "   
	choose case kast_stat_invent.tipo_data
			
		case '1' // x data fine lavorazione (prendo i dati andando un tot di gg indietro)
//--- piglia il id_meca da cui partire			
			kst_tab_armo.data_int = kast_stat_invent.data_da
			kuf1_armo.get_id_meca_da_data(kst_tab_armo)
			k_sql +=  &
			 + " and  barcode.data_lav_fin <= '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "'  or barcode.data_lav_fin is null " &
			 + " and barcode.id_meca > " + string(kst_tab_armo.id_meca)  
//			 + "  (select id_armo from  armo where data_int > '" + string(relativedate(kast_stat_invent.data_a, -720), "dd/mm/yyyy")  + "' )"  
//			 + " and  barcode.data_lav_fin between '" + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
//			 + " and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

		case '2' //  x data fine fatturazione
			k_sql +=  &
			 + " and  barcode.data_lav_fin <= '01/01/1990'  or barcode.data_lav_fin is null " &
			 + " and barcode.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kast_stat_invent.utente) + "_stat_dfat )"  
			 
		case '3' // x data di riferimento
			k_sql +=  &
			 + " and  s_armo.data_int between '" + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  
			 
	end choose
	if kast_stat_invent.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql_w += " and s_armo.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			k_sql_w += " and s_armo.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql_w = k_sql_w + " and s_armo.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql_w = k_sql_w + "and s_armo.dose = " + kast_stat_invent.dose_str + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
	else
		k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
	end if
	k_sql += " " + trim(k_sql_w)  //+ " group by 1, 2  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei Trattati  
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavColli "
	k_sql_w = " "
	k_sql = " " 
	k_sql =  "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT  " &
			 + " barcode.id_meca " &
			 + " ,barcode.id_armo " &
			 + " ,count(*)  as colli " &
			 + " FROM barcode  " &
			 + " where barcode.barcode in ( " &
 			 + " SELECT distinct " &
			 + " a.barcode " &
			 + " FROM " + "vx_" + trim(kast_stat_invent.utente) + "_statLav as a  " &
			 + " ) " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei  Spediti (Ritirati) 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavSped "
	k_sql_w = " "
	k_sql = " " 
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " s_arsp.id_meca " &
			 + " ,s_arsp.id_armo " &
			 + " ,sum(NVL(s_arsp.colli,0))  as colli " &
			 + " FROM  s_arsp " 
	k_sql +=  &
			 "	  where (s_arsp.data_rit is null or (s_arsp.data_rit > date(0) " &  
			 + "	      and s_arsp.data_rit <= '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "')  )"  &
			 + "   and s_arsp.id_armo in ( " &
 			 + " SELECT distinct " &
			 + " a.id_armo " &
			 + " FROM " + "vx_" + trim(kast_stat_invent.utente) + "_statLavColli as a  " &
			 + " ) " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view dei Rif Trattati meno gli Spediti (Ritirati) maggiori di zero 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped "
	k_sql_w = " "
	k_sql = " " 
	k_sql =  &
	"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli ) AS   "  
	k_sql +=  &
			 + " SELECT " &
			 + " a.id_meca " &
			 + " ,a.id_armo " &
			 + " ,a.colli - NVL(s.colli,0)  as colli " &
			 + " FROM   vx_" + trim(kast_stat_invent.utente) + "_statLavColli as a  " & 
			 + "   left outer join  vx_" + trim(kast_stat_invent.utente) + "_statLavSped as s  on " & 
			 + "   a.id_armo = s.id_armo " &
	          + "  where s.colli is null or a.colli > s.colli " 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view con Entrata
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statarmo5 "
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) + " ( id_meca, id_armo, colli_2, m_cubi, pedane, importo ) AS   " 
 	k_sql =  k_sql &
			 + " SELECT  " &
			 + " s_armo.id_meca " &
			 + " ,s_armo.id_armo " &
			 + " ,sum(s_armo.colli_2) " & 
			 + " ,sum(s_armo.m_cubi / s_armo.colli_2) " & 
			 + " ,sum(s_armo.pedane / s_armo.colli_2) " &
			 + " ,sum( (NVL(s_armo.imp_fatt,0) + NVL(s_armo.imp_da_fatt,0)) / s_armo.colli_2 ) " &
			 + " FROM s_armo  " &
			 + "	where " &  
			 + "	  s_armo.id_armo in (select distinct id_armo from " + "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped " + ") " 
	k_sql += " group by id_meca, id_armo  "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- costruisco la view con colli_fatturati
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statarfa5 "
	k_sql_w = " "
	k_sql = "CREATE VIEW " + trim(k_view) + " ( id_armo,  colli_fatt) AS   " 
	k_sql += &
			 + " SELECT distinct " &
			 + " id_armo " &
			 + " ,sum(colli) " &   
			 + " FROM arfa  " &
			 + "	where " &  
			 + "	  arfa.tipo_doc = 'FT' and arfa.id_armo in (select distinct id_armo from " + "vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped " + ") "  
//--- se richiesto ESTRAZIONE dei "non ancora fatturati" oppure "gia' Fatturati".....			 
//	if trim(string(tab_1.selectedtab)) = "5" or trim(string(tab_1.selectedtab)) = "6" then
	if kast_stat_invent.flag_fatturati = "N" or kast_stat_invent.flag_fatturati = "S" then
		k_sql += " and data_fatt between '" + string(kast_stat_invent.data_da) + "' and '" + string(kast_stat_invent.data_a) + "'"
	end if
	k_sql += " group by id_armo "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- Union delle tabelle per simularne una sola
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv_5 "
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca,  id_armo, colli_lav, colli_trattati_da_sped, colli_2,  colli_sped, colli_fatt, m_cubi, pedane, importo) AS   " & 
	 + " SELECT " &
	 + " r.id_meca, " &
	 + " r.id_armo, " &
	 + " 0, " &   
	 + " 0,  " &   
	 + " sum(r.colli_2), " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " sum(r.m_cubi), " &   
	 + " sum(r.pedane), " &
	 + " r.importo " &
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statarmo5 " + " as r  " &  
	 + " group by 1,2,3,4,6,7,10 "  &
	 + " union all " &
	 + " SELECT " &
	 + " nosp.id_meca, " &
	 + " nosp.id_armo, " &
	 + " sum(lav.colli),  " &   
	 + " sum(nosp.colli),  " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &   
	 + " 0, " &
	 + " 0 " &
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statLavNoSped " + " as nosp " &
	 + "          inner join vx_" + trim(kast_stat_invent.utente) + "_statLavColli as lav on  " &	 
	 + " nosp.id_armo = lav.id_armo " &
	 + " group by 1,2, 5,6,7,8,9,10 "  
	k_sql = k_sql + " " + trim(k_sql_w) 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- costruisco la view con valorizzazione x singola riga Lotto 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv15 "
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca,  id_armo, colli_2, colli_lav, colli_trattati_da_sped, colli_da_sped, colli_fatt,  m_cubi, pedane, importo) AS   " & 
	 + " SELECT " &
	 + " s.id_meca, " &
	 + " s.id_armo, " &
	 + " sum(s.colli_2), " &   
	 + " sum(s.colli_lav),  " &   
	 + " sum(s.colli_trattati_da_sped),  " &   
	 + " sum(s.colli_2) - sum(s.colli_sped), " &   
	 + " f.colli_fatt,  " &   
	 + " sum(s.m_cubi)  * (sum(s.colli_trattati_da_sped)), " &   
	 + " sum(s.pedane)  * (sum(s.colli_trattati_da_sped)), " &   
	 + " sum(s.importo) * (sum(s.colli_trattati_da_sped)) " &   
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statinv_5 as s left outer join vx_" + trim(kast_stat_invent.utente) + "_statarfa5 as f on " &
	 + "  s.id_armo = f.id_armo "  
	k_sql = k_sql + " " + trim(k_sql_w) + &
	" group by 1, 2, 7 "
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- costruisco la temp-table con valorizzazione x singolo Lotto 
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_statinv25 "
	k_sql_w = " "
	k_sql =  &
	 + " SELECT distinct" &
	 + " s.id_meca, " &
	 + " s_armo.num_int, " &
	 + " s_armo.data_int, " &
	 + " s_armo.clie_1, " &
	 + " s_armo.clie_2, " &
	 + " s_armo.clie_3, " &
	 + " (s.colli_2),  " &   
	 + " (s.colli_lav),  " &   
	 + " (s.colli_trattati_da_sped),  " &   
	 + " (s.colli_da_sped),  " &   
	 + " (s.colli_fatt),  " &   
	 + " (s.m_cubi), " &   
	 + " (s.pedane), " &   
	 + " (s.importo) " &   
	 + " FROM vx_" + trim(kast_stat_invent.utente) + "_statinv15 as s  " &
	 + "             INNER JOIN s_armo ON " &
	 + "  s.id_meca = s_armo.id_meca " 
	k_sql = k_sql + " " + trim(k_sql_w) 
//	" group by 1, 2, 3, 4, 5, 6 "

	k_campi =  &
			 + " id_meca integer" &
			 + " ,num_int integer " &
			 + " ,data_int date " &
			 + " ,clie_1 integer " &
			 + " ,clie_2 integer " &
			 + " ,clie_3 integer " &
			 + " ,colli_2 integer " &
			 + " ,colli_lav integer " &
			 + " ,colli_trattati_da_sped integer " &
			 + " ,colli_da_sped integer " &
			 + " ,colli_fatt integer " & 
			 + " ,m_cubi decimal(9,2) " &
			 + " ,pedane decimal(5,2) " &
			 + " ,importo decimal(12,2) " 
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		


	destroy kuf1_utility
	destroy kuf1_armo
	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)

return k_esegui_query
//
end function

private subroutine crea_view_x_data_fatt (st_stat_invent kast_stat_invent);//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_dfat "
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo ) AS   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + "     s_arfa.id_armo  " &
	 + " FROM arfa as s_arfa  " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
//	if kast_stat_invent.id_gruppo > 0 then
//		k_sql +=  " and gruppo = " + string(kast_stat_invent.id_gruppo) + " "
//	end if
//	if kast_stat_invent.magazzino <> 9 then
//		k_sql +=  " and magazzino = " + string(kast_stat_invent.magazzino) + " "
//	end if
//	if kast_stat_invent.dose > 0 then
//		k_sql +=  " and dose = " + string(kast_stat_invent.dose, "#0.00") + " "
//	end if
//	if kast_stat_invent.no_dose = 'S' then
//		k_sql +=  " and dose = 0 " + " "
//	else
//		k_sql +=  " and dose > 0 " + " "
//	end if
	
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine crea_view_x_data_fatt_id_armo (st_stat_invent kast_stat_invent);//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_mfat "
	k_sql = " "                                   
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) + " ( id_armo ) AS   " 
	k_campi = " id_armo integer   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " arfa.id_armo  " &
	 + " FROM  s_arfa inner join arfa on s_arfa.num_fatt = arfa.num_fatt and s_arfa.data_fatt = arfa.data_fatt " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and s_arfa.clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and s_arfa.gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			k_sql += " and s_arfa.gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and s_arfa.magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql += " and s_arfa.dose = " + kast_stat_invent.dose_str + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql += " and s_arfa.dose = 0 " + " "
	else
		k_sql += " and s_arfa.dose > 0 " + " "
	end if
	
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine crea_view_x_data_fatt_id_meca (st_stat_invent kast_stat_invent);//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kast_stat_invent.utente) + "_stat_mfat "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca ) AS   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " s_arfa.id_meca  " &
	 + " FROM  s_arfa  " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kast_stat_invent.data_da, "dd/mm/yyyy") + "' and '" + string(kast_stat_invent.data_a, "dd/mm/yyyy") + "' "  

	
	if kast_stat_invent.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kast_stat_invent.id_cliente) + " "
	end if
	if kast_stat_invent.id_gruppo > 0 then
		if kast_stat_invent.gruppo_flag = 1 then
			k_sql += " and gruppo = " + string(kast_stat_invent.id_gruppo) + " "
		else
			k_sql += " and gruppo <> " + string(kast_stat_invent.id_gruppo) + " "
		end if
	end if
	if kast_stat_invent.magazzino <> 9 then
		k_sql += " and magazzino = " + string(kast_stat_invent.magazzino) + " "
	end if
	if kast_stat_invent.dose > 0 then
		k_sql += " and dose = " + kast_stat_invent.dose_str + " "
	end if
	if kast_stat_invent.no_dose = 'S' then
		k_sql += " and dose = 0 " + " "
	else
		k_sql += " and dose > 0 " + " "
	end if
	
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

public function boolean visualizza_importi ();//
//--- Verifica le autorizzazioni x visualizzare gli importi
//--- Ritorna: TRUE=autorizzato/FALSE=non autorizzato
//
boolean k_return
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_listino kuf1_listino
kuf_fatt kuf1_fatt


	kuf1_listino = create kuf_listino
	kuf1_fatt = create kuf_fatt
	kuf1_sicurezza = create kuf_sicurezza

//--- utente autorizzato almeno alla visualizzazione Listini
	kst_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
	kst_open_w.id_programma = kuf1_listino.get_id_programma( kst_open_w.flag_modalita )
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	
	if not k_return then
//--- utente autorizzato almeno alla visualizzazione Fatture
		kst_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
		kst_open_w.id_programma = kuf1_fatt.get_id_programma( kst_open_w.flag_modalita )
		k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	end if	
	
	destroy kuf1_sicurezza
	destroy kuf1_listino
	destroy kuf1_fatt

return k_return

end function

on kuf_stat_invent.create
call super::create
end on

on kuf_stat_invent.destroy
call super::destroy
end on

