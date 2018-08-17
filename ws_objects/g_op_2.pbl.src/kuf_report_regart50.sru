$PBExportHeader$kuf_report_regart50.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_regart50 from nonvisualobject
end type
end forward

global type kuf_report_regart50 from nonvisualobject
end type
global kuf_report_regart50 kuf_report_regart50

type variables
//
private st_report_regart50 kist_report_regart50
private st_tab_base kist_tab_base

//--- dati da restituire - il Report 
public datastore kids_report_regart50

//--- area dati di lavoro 
private datastore kids_report_entrate_uscite
private datastore kids_report_solo_uscite
//private datastore kids_report_solo_fatt


end variables

forward prototypes
private subroutine db_crea_view_entrate (st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine db_crea_view_spediti (st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine db_crea_view_fatt (st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine db_crea_view_entrate_altre (st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine db_crea_view_spediti_altri (st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine get_art50_dati_base () throws uo_exception
public subroutine get_st_report_regart50 (ref st_report_regart50 kst_report_regart50) throws uo_exception
public subroutine set_st_report_regart50 (ref st_report_regart50 kst_report_regart50) throws uo_exception
public subroutine get_report (ref st_report_regart50 kst_report_regart50) throws uo_exception
private subroutine set_art50_dati_base () throws uo_exception
private subroutine get_id_meca (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception
private subroutine get_id_sped (ref st_tab_sped kst_tab_sped_da, ref st_tab_sped kst_tab_sped_a) throws uo_exception
end prototypes

private subroutine db_crea_view_entrate (st_report_regart50 kst_report_regart50) throws uo_exception;//
//--- Crea View con elenco entrate per periodo
//
int k_ctr
string k_view, k_sql
date k_data_int_da, k_data_int_a
string k_data_ent_dax, k_data_ent_ax
st_tab_meca kst_tab_meca_da, kst_tab_meca_a
kuf_utility kuf1_utility
kuf_armo kuf1_armo
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


	kuf1_utility = create kuf_utility
	
	k_data_int_da = relativedate(kst_report_regart50.k_data_da, -730)
	k_data_int_a = relativedate(kst_report_regart50.k_data_a, 30)
	k_data_ent_dax = string(datetime(kst_report_regart50.k_data_da, time(0))) // "DATETIME(" + string(kst_report_regart50.k_data_da, "yyyy-mm-dd") + " " + string(time(0)) + ") YEAR TO SECOND "
	k_data_ent_ax = string(datetime(kst_report_regart50.k_data_a, time(23,59,59))) // "DATETIME(" + string(kst_report_regart50.k_data_a, "yyyy-mm-dd") + " " + string(time(23,59,59)) + ") YEAR TO SECOND "

	kst_tab_meca_da.data_int = k_data_int_da
	kst_tab_meca_a.data_int = k_data_int_a
	get_id_meca(kst_tab_meca_da, kst_tab_meca_a) // ricava il range ID MECA
	
//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_art50_entrate_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli, gru_des, num_bolla_in, data_bolla_in, num_int, data_int, data_ent, e1doco, e1rorn, clie_1, rag_soc_1 ) AS   " &
	 + "  SELECT meca.id,   " &
	 + "		sum(armo.colli_2), " &
	 + "         gru.des,    " &
	 + "         meca.num_bolla_in,    " &
	 + "         meca.data_bolla_in,    " &
	 + "         meca.num_int,    " &
	 + "         meca.data_int,    " &
	 + "         meca.data_ent,    " &
	 + "         meca.e1doco,    " &
	 + "         meca.e1rorn,    " &
	 + "         meca.clie_1,    " &
	 + "         clienti1.rag_soc_10    " &
	 + "    FROM (meca inner join armo on meca.id = armo.id_meca      " &
	 + "         inner join prodotti  on  armo.art = prodotti.codice     " &
	 + "         inner join gru on prodotti.gruppo = gru.codice     " &
	 + "         inner join clienti as clienti1 on meca.clie_1 = clienti1.codice  " &
	 + "         inner join nazioni as nazioni1 on clienti1.id_nazione_1 = nazioni1.id_nazione  " &
	 + "         inner join clienti as clienti3 on meca.clie_3 = clienti3.codice    " &
	 + "         inner join nazioni as nazioni3 on clienti3.id_nazione_1 = nazioni3.id_nazione)  " 
//	 + "         ,arfa " &
	k_sql += "   WHERE       " &
	 + "          armo.dose > 0   " &
	 + "          and (( nazioni1.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
	 + "                   nazioni1.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "'  )  " &
	 + "            or ( nazioni3.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
	 + "                  nazioni3.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "' )  )  " &
	 + "          and meca.id between "  + string(kst_tab_meca_da.id) + " and " + string(kst_tab_meca_a.id) + " "     &
	 + "          and meca.data_int between '"  + string(k_data_int_da) + "' and '" + string(k_data_int_a) + "' "     &
	 + "          and meca.data_ent between '"  + k_data_ent_dax + "' and '" + k_data_ent_ax + "' "     &
	 + "          and (meca.aperto <> '" + string(kuf1_armo.kki_meca_aperto_annullato ) + "') "
//	 + "          and armo.id_armo not in ( select xf.id_armo from arfa xf where  xf.data_fatt >= '"  + string(kst_report_regart50.k_data_da) + "' )" & 
	k_sql += " group by meca.id,   " &
	 + "         gru.des,    " &
	 + "         meca.num_bolla_in,    " &
	 + "         meca.data_bolla_in,    " &
	 + "         meca.num_int,    " &
	 + "         meca.data_int,    " &
	 + "         meca.data_ent,    " &
	 + "         meca.e1doco,    " &
	 + "         meca.e1rorn,    " &
	 + "         meca.clie_1,    " &
	 + "         clienti1.rag_soc_10 " 
//	 + " UNION ALL " &
//	 + "  SELECT meca.id,   " &
//	 + "		sum(armo.colli_2), " &
//	 + "         gru.des,    " &
//	 + "         meca.num_bolla_in,    " &
//	 + "         meca.data_bolla_in,    " &
//	 + "         meca.num_int,    " &
//	 + "         meca.data_int,    " &
//	 + "         meca.data_ent,    " &
//	 + "         meca.e1doco,    " &
//	 + "         meca.e1rorn,    " &
//	 + "         meca.clie_1,    " &
//	 + "         clienti1.rag_soc_10    " &
//	 + "    FROM meca inner join armo on meca.id = armo.id_meca  " &
//	 + "         inner join arfa on armo.id_armo =  arfa.id_armo   " &
//	 + "         inner join prodotti  on  armo.art = prodotti.codice  " &
//	 + "         inner join gru on prodotti.gruppo = gru.codice  " &
//	 + "         inner join clienti as clienti1 on meca.clie_1 = clienti1.codice  " &
//	 + "         inner join clienti as clienti3 on arfa.clie_3 = clienti3.codice    " &
//	 + "         inner join nazioni as nazioni1 on clienti1.id_nazione_1 = nazioni1.id_nazione  " &
//	 + "         inner join nazioni as nazioni3 on clienti3.id_nazione_1 = nazioni3.id_nazione  " &
//	 + "   WHERE       " &
//	 + "          armo.dose > 0   " &
//	 + "          and (( nazioni1.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
//	 + "                   nazioni1.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "'  )  " &
//	 + "            or ( nazioni3.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
//	 + "                  nazioni3.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "' )  )  " &
//	 + "          and meca.id between "  + string(kst_tab_meca_da.id) + " and " + string(kst_tab_meca_a.id) + " "     &
//	 + "          and meca.data_int between   '"  + string(k_data_int_da) + "' and '" + string(k_data_int_a) + "'  "     &
//	 + "          and meca.data_ent between "  + k_data_ent_dax + " and " + k_data_ent_ax + "  "     &
//	 + "          and (meca.aperto <> '" + string(kuf1_armo.kki_meca_aperto_annullato ) + "') "  &
//	 + "	   group by meca.id,   " &
//	 + "         gru.des,    " &
//	 + "         meca.num_bolla_in,    " &
//	 + "         meca.data_bolla_in,    " &
//	 + "         meca.num_int,    " &
//	 + "         meca.data_int,    " &
//	 + "         meca.data_ent,    " &
//	 + "         meca.e1doco,    " &
//	 + "         meca.e1rorn,    " &
//	 + "         meca.clie_1,    " &
//	 + "         clienti1.rag_soc_10    " 
	 
	 
	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
	
end if



end subroutine

private subroutine db_crea_view_spediti (st_report_regart50 kst_report_regart50) throws uo_exception;//
//--- Crea View con elenco Spediti per periodo
//
int k_ctr
string k_view, k_sql
kuf_utility kuf1_utility
st_tab_sped kst_tab_sped_da, kst_tab_sped_a
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kst_tab_sped_da.data_bolla_out = kst_report_regart50.k_data_da
	kst_tab_sped_a.data_bolla_out = kst_report_regart50.k_data_a
	get_id_sped(kst_tab_sped_da, kst_tab_sped_a) // ricava il range ID sped

	kuf1_utility = create kuf_utility


//--- costruisco la view con ID_MECA spediti da data a data
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_art50_sped_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli, num_bolla_out, data_bolla_out, clie_2, " &
	 + "   rag_soc_1,    " &
	 + "   loc,    " &
	 + "   cap,    " &
	 + "   prov,    " &
	 + "   rag_soc_2 ) AS   " &
	 + "  SELECT armo.id_meca,   " &
	 + "		 sum(arsp.colli), " &
	 + "         sped.num_bolla_out,    " &
	 + "         sped.data_bolla_out,    " &
	 + "         sped.clie_2,    " &
	 + "         sped.rag_soc_1,    " &
	 + "         sped.loc,    " &
	 + "         sped.cap,    " &
	 + "         sped.prov,    " &
	 + "         clienti.rag_soc_10    " &
	 + "    FROM sped inner join arsp on  sped.num_bolla_out = arsp.num_bolla_out and   sped.data_bolla_out = arsp.data_bolla_out   " &
	 + "         inner join armo on  arsp.id_armo = armo.id_armo   " &
	 + "         inner join clienti on sped.clie_2 = clienti.codice   " &
	 + "   WHERE  " &
	 + "          sped.data_bolla_out between   '"  + string(kst_report_regart50.k_data_da) + "' and '" + string(kst_report_regart50.k_data_a) + "'  "     &
	 + "          and sped.id_sped between "  + string(kst_tab_sped_da.id_sped) + " and " + string(kst_tab_sped_a.id_sped) + " "     &
	 + " 	    group by  armo.id_meca,    " &
	 + " 	           sped.num_bolla_out,     " &
	 + " 	           sped.data_bolla_out,     " &
	 + " 	           sped.clie_2,     " &
	 + "               sped.rag_soc_1,    " &
	 + "               sped.loc,    " &
	 + "               sped.cap,    " &
	 + "               sped.prov,    " &
	 + " 	           clienti.rag_soc_10   "   
//	 + "ORDER BY sped.data_bolla_out ASC,     " &
//	 + "         sped.num_bolla_out ASC     " 
//	 + "    and id_armo in ( select id_armo from   vx_" + trim(kguo_utente.get_comp()) + "_art50_entrate_l )     " &

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
	
end if



end subroutine

private subroutine db_crea_view_fatt (st_report_regart50 kst_report_regart50) throws uo_exception;//
//--- Crea View con elenco Spediti per periodo
//
int k_ctr
string k_view, k_sql
kuf_utility kuf1_utility
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


	kuf1_utility = create kuf_utility

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_art50_fatt_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli, num_fatt, data_fatt, clie_3, rag_soc_3 ) AS   " &
	 + "  SELECT armo.id_meca,   " &
	 + "		 sum(arfa.colli), " &
	 + "         arfa_testa.num_fatt,    " &
	 + "         arfa_testa.data_fatt,    " &
	 + "         arfa_testa.id_cliente,    " &
	 + "         arfa_testa.rag_soc_1    " &
	 + "    FROM arfa_testa inner join arfa on arfa_testa.id_fattura = arfa.id_fattura  " &
	 + "         inner join armo  on  arfa.id_armo = armo.id_armo       " &
	 + "   WHERE    " &
	 + "               arfa_testa.data_fatt between   '"  + string(kst_report_regart50.k_data_da) + "' and '" + string(kst_report_regart50.k_data_a) + "'  "     &
	 + " 	    group by  armo.id_meca,   "     &
	 + "         arfa_testa.num_fatt,    " &
	 + "         arfa_testa.data_fatt,    " &
	 + "         arfa_testa.id_cliente,    " &
	 + "         arfa_testa.rag_soc_1    " &
	 
//	 + "ORDER BY arfa_testa.data_fatt ASC,     " &
//	 + "         arfa_testa.num_fatt ASC     " 

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
	
end if



end subroutine

private subroutine db_crea_view_entrate_altre (st_report_regart50 kst_report_regart50) throws uo_exception;//
//--- Crea View con elenco entrate nel periodo precedente alla data di inzio richiesta
//
int k_ctr
string k_view, k_sql
string k_data_ent_dax, k_data_ent_ax
date k_data_da, k_data_a, k_data_int_da, k_data_int_a
st_tab_meca kst_tab_meca_da, kst_tab_meca_a
kuf_utility kuf1_utility
kuf_armo kuf1_armo
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


kuf1_utility = create kuf_utility

k_data_da = relativedate(kst_report_regart50.k_data_da, - 1045)  // dalla data di partenza dell'estrazione calcola una noova data da molto indietro 
k_data_a = relativedate(kst_report_regart50.k_data_da, - 1)
k_data_int_da = relativedate(kst_report_regart50.k_data_da, -1045)
k_data_int_a = relativedate(kst_report_regart50.k_data_da, 30)
//k_data_ent_dax = "DATETIME(" + string(k_data_da, "yyyy-mm-dd") + " " + string(time(0)) + ") YEAR TO SECOND "
//k_data_ent_ax = "DATETIME(" + string(k_data_a, "yyyy-mm-dd") + " " + string(time(23,59,59)) + ") YEAR TO SECOND "
k_data_ent_dax = string(datetime(kst_report_regart50.k_data_da, time(0))) // "DATETIME(" + string(kst_report_regart50.k_data_da, "yyyy-mm-dd") + " " + string(time(0)) + ") YEAR TO SECOND "
k_data_ent_ax = string(datetime(kst_report_regart50.k_data_a, time(23,59,59))) // "DATETIME(" + string(kst_report_regart50.k_data_a, "yyyy-mm-dd") + " " + string(time(23,59,59)) + ") YEAR TO SECOND "

kst_tab_meca_da.data_int = k_data_int_da
kst_tab_meca_a.data_int = k_data_int_a
get_id_meca(kst_tab_meca_da, kst_tab_meca_a) // ricava il range ID MECA

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_art50_entrate_altre_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli, gru_des, num_bolla_in, data_bolla_in, num_int, data_int, data_ent, e1doco, e1rorn, clie_1, rag_soc_1 ) AS   " &
	 + "  SELECT meca.id,   " &
	 + "		sum(armo.colli_2), " &
	 + "         gru.des,    " &
	 + "         meca.num_bolla_in,    " &
	 + "         meca.data_bolla_in,    " &
	 + "         meca.num_int,    " &
	 + "         meca.data_int,    " &
	 + "         meca.data_ent,    " &
	 + "         meca.e1doco,    " &
	 + "         meca.e1rorn,    " &
	 + "         meca.clie_1,    " &
	 + "         clienti1.rag_soc_10    " &
	 + "    FROM (meca inner join armo on meca.id = armo.id_meca      " &
	 + "         inner join prodotti  on  armo.art = prodotti.codice     " &
	 + "         inner join gru on prodotti.gruppo = gru.codice     " &
	 + "         inner join clienti as clienti1 on meca.clie_1 = clienti1.codice  " &
	 + "         inner join nazioni as nazioni1 on clienti1.id_nazione_1 = nazioni1.id_nazione  " &
	 + "         inner join clienti as clienti3 on meca.clie_3 = clienti3.codice    " &
	 + "         inner join nazioni as nazioni3 on clienti3.id_nazione_1 = nazioni3.id_nazione)  " 
//	 + "         ,arfa " &
	k_sql += &
	   "   WHERE       " &
	 + "          armo.dose > 0   " &
	 + "          and (( nazioni1.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
	 + "                   nazioni1.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "'  )  " &
	 + "            or ( nazioni3.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
	 + "                  nazioni3.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "'  ) )  " &
	 + "          and meca.id between "  + string(kst_tab_meca_da.id) + " and " + string(kst_tab_meca_a.id) + " "     &
	 + "          and meca.data_int between '"  + string(k_data_int_da) + "' and '" + string(k_data_int_a) + "'  "     &
	 + "          and meca.data_ent between '"  + k_data_ent_dax + "' and '" + k_data_ent_ax + "'  "     &
	 + "          and (meca.aperto <> '" + string(kuf1_armo.kki_meca_aperto_annullato ) + "') " 
//	 + "          and armo.id_armo not in ( select xf.id_armo from arfa xf where  xf.data_fatt >= '"  + string(k_data_da) + "' ) " & 
	k_sql += &
	   "	   group by meca.id,   " &
	 + "         gru.des,    " &
	 + "         meca.num_bolla_in,    " &
	 + "         meca.data_bolla_in,    " &
	 + "         meca.num_int,    " &
	 + "         meca.data_int,    " &
	 + "         meca.data_ent,    " &
	 + "         meca.e1doco,    " &
	 + "         meca.e1rorn,    " &
	 + "         meca.e1doco,    " &
	 + "         meca.e1rorn,    " &
	 + "         meca.clie_1,    " &
	 + "         clienti1.rag_soc_10    " 
//	 + " UNION ALL " &
//	 + "  SELECT meca.id,   " &
//	 + "		sum(armo.colli_2), " &
//	 + "         gru.des,    " &
//	 + "         meca.num_bolla_in,    " &
//	 + "         meca.data_bolla_in,    " &
//	 + "         meca.num_int,    " &
//	 + "         meca.data_int,    " &
//	 + "         meca.data_ent,    " &
//	 + "         meca.e1doco,    " &
//	 + "         meca.e1rorn,    " &
//	 + "         meca.clie_1,    " &
//	 + "         clienti1.rag_soc_10    " &
//	 + "    FROM meca inner join armo on meca.id = armo.id_meca  " &
//	 + "         inner join arfa on armo.id_armo =  arfa.id_armo   " &
//	 + "         inner join prodotti  on  armo.art = prodotti.codice  " &
//	 + "         inner join gru on prodotti.gruppo = gru.codice  " &
//	 + "         inner join clienti as clienti1 on meca.clie_1 = clienti1.codice  " &
//	 + "         inner join clienti as clienti3 on arfa.clie_3 = clienti3.codice    " &
//	 + "         inner join nazioni as nazioni1 on clienti1.id_nazione_1 = nazioni1.id_nazione  " &
//	 + "         inner join nazioni as nazioni3 on clienti3.id_nazione_1 = nazioni3.id_nazione  " &
//	 + "   WHERE       " &
//	 + "          armo.dose > 0   " &
//	 + "          and (( nazioni1.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
//	 + "                   nazioni1.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "'  )  " &
//	 + "            or ( nazioni3.gruppo = '" + kist_tab_base.art50_nazioni_gruppo + "'  and  " &
//	 + "                  nazioni3.id_nazione <>  '" + kist_tab_base.art50_id_nazione_esclusa + "' )  )  " &
//	 + "          and meca.data_int between   '"  + string(k_data_int_da) + "' and '" + string(k_data_int_a) + "'  "     &
//	 + "          and meca.data_ent between "  + k_data_ent_dax + " and " + k_data_ent_ax + "  "     &
//	 + "          and (meca.aperto <> '" + string(kuf1_armo.kki_meca_aperto_annullato ) + "') "  &
//	k_sql += &
//	   "	   group by meca.id,   " &
//	 + "         gru.des,    " &
//	 + "         meca.num_bolla_in,    " &
//	 + "         meca.data_bolla_in,    " &
//	 + "         meca.num_int,    " &
//	 + "         meca.data_int,    " &
//	 + "         meca.data_ent,    " &
//	 + "         meca.e1doco,    " &
//	 + "         meca.e1rorn,    " &
//	 + "         meca.clie_1,    " &
//	 + "         clienti1.rag_soc_10    " 
	 

//	 + "ORDER BY meca.data_int ASC,     " &
//	 + "         meca.num_int ASC     " 

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
	
end if



end subroutine

private subroutine db_crea_view_spediti_altri (st_report_regart50 kst_report_regart50) throws uo_exception;//
//--- Crea View con elenco Spediti per periodo
//
int k_ctr
string k_view, k_sql
date k_data_da, k_data_a
st_tab_sped kst_tab_sped_da, kst_tab_sped_a
kuf_utility kuf1_utility
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

k_data_da = relativedate(kst_report_regart50.k_data_da, - 365)
k_data_a = relativedate(kst_report_regart50.k_data_da, - 1)

kst_tab_sped_da.data_bolla_out = k_data_da
kst_tab_sped_a.data_bolla_out = k_data_a
get_id_sped(kst_tab_sped_da, kst_tab_sped_a) // ricava il range ID sped

kuf1_utility = create kuf_utility

//--- 
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_art50_sped_altri_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, colli, num_bolla_out, data_bolla_out, clie_2,   " &
	 + "   rag_soc_1,    " &
	 + "   loc,    " &
	 + "   cap,    " &
	 + "   prov,    " &
	 + "   rag_soc_2 ) AS   " &
	 + "  SELECT armo.id_meca,   " &
	 + "		 sum(arsp.colli), " &
	 + "         sped.num_bolla_out,    " &
	 + "         sped.data_bolla_out,    " &
	 + "         sped.clie_2,    " &
	 + "         sped.rag_soc_1,    " &
	 + "         sped.loc,    " &
	 + "         sped.cap,    " &
	 + "         sped.prov,    " &
	 + "         clienti.rag_soc_10    " &
	 + "    FROM sped inner join arsp on  sped.num_bolla_out = arsp.num_bolla_out and   sped.data_bolla_out = arsp.data_bolla_out   " &
	 + "         inner join armo on  arsp.id_armo = armo.id_armo   " &
	 + "         inner join clienti on sped.clie_2 = clienti.codice   " &
	 + "   WHERE "  &
	 + "          sped.data_bolla_out  between   '"  + string(k_data_da) + "' and '" + string(k_data_a) + "'  "     &
	 + "          and sped.id_sped between "  + string(kst_tab_sped_da.id_sped) + " and " + string(kst_tab_sped_a.id_sped) + " "     &
	 + " 	    group by  armo.id_meca,    " &
	 + " 	           sped.num_bolla_out,     " &
	 + " 	           sped.data_bolla_out,     " &
	 + " 	           sped.clie_2,     " &
	 + "              sped.rag_soc_1,    " &
	 + "              sped.loc,    " &
	 + "              sped.cap,    " &
	 + "              sped.prov,    " &
	 + " 	           clienti.rag_soc_10   "   
	 
//	 + "ORDER BY sped.data_bolla_out ASC,     " &
//	 + "         sped.num_bolla_out ASC     " 
//	 + "    and id_armo in ( select id_armo from   vx_" + trim(kguo_utente.get_comp()) + "_art50_entrate_l )     " &

	kst_esito = kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito( kst_esito )
	throw kuo_exception
	
end if



end subroutine

private subroutine get_art50_dati_base () throws uo_exception;//---
//--- Imposta i Dati da Archivio Azienda nell'area comune 
//---
string k_esito
kuf_base kuf1_base


kuf1_base = create kuf_base


k_esito = kuf1_base.prendi_dato_base( "art50_anno")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_anno') ")
	throw kguo_exception
else
	kist_tab_base.art50_anno = integer(mid(k_esito,2))
end if

k_esito = kuf1_base.prendi_dato_base( "art50_mese")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_mese') ")
	throw kguo_exception
else
	kist_tab_base.art50_mese = integer(mid(k_esito,2))
end if

k_esito = kuf1_base.prendi_dato_base( "art50_ult_nrpagina")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_ult_nrpagina') ")
	throw kguo_exception
else
	kist_tab_base.art50_ult_nrpagina = integer(mid(k_esito,2))
end if

k_esito = kuf1_base.prendi_dato_base( "art50_ult_nrprot")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_ult_nrprot') ")
	throw kguo_exception
else
	kist_tab_base.art50_ult_nrprot = integer(mid(k_esito,2))
end if

k_esito = kuf1_base.prendi_dato_base( "art50_nazioni_gruppo")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_nazioni_gruppo') ")
	throw kguo_exception
else
	kist_tab_base.art50_nazioni_gruppo = trim(mid(k_esito,2))
end if

k_esito = kuf1_base.prendi_dato_base( "art50_id_nazione_esclusa")
if left(k_esito,1) <> "0" then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in lettura archivio BASE (get 'art50_id_nazione_esclusa') ")
	throw kguo_exception
else
	kist_tab_base.art50_id_nazione_esclusa = trim(mid(k_esito,2))
end if



destroy kuf1_base



end subroutine

public subroutine get_st_report_regart50 (ref st_report_regart50 kst_report_regart50) throws uo_exception;//---
//--- Legge i Dati da Archivio Azienda e riempie l'area ST_REPORT_REGART50
//---
string k_esito
kuf_base kuf1_base


this.get_art50_dati_base( )

if isnull(kist_tab_base.art50_anno) or kist_tab_base.art50_anno = 0 then kist_tab_base.art50_anno = year(kg_dataoggi)
if isnull(kist_tab_base.art50_mese) or kist_tab_base.art50_mese = 0 then kist_tab_base.art50_mese = month(kg_dataoggi)

if kist_tab_base.art50_mese = 12 then
	kist_tab_base.art50_mese = 1
	kist_tab_base.art50_anno ++
else
	kist_tab_base.art50_mese ++
end if

kst_report_regart50.k_data_da = date(kist_tab_base.art50_anno , kist_tab_base.art50_mese, 01)
if kist_tab_base.art50_mese = 12 then
	kst_report_regart50.k_data_a = date(kist_tab_base.art50_anno , kist_tab_base.art50_mese , 31) 
else
	kst_report_regart50.k_data_a = relativedate(date(kist_tab_base.art50_anno , kist_tab_base.art50_mese + 1, 01), -1) 
end if

if isnull(kist_tab_base.art50_ult_nrpagina) or kist_tab_base.art50_ult_nrpagina = 0 then 
	kist_tab_base.art50_ult_nrpagina = 1
else
	kist_tab_base.art50_ult_nrpagina ++
end if
kst_report_regart50.k_nrpagina = kist_tab_base.art50_ult_nrpagina

if isnull(kist_tab_base.art50_ult_nrprot) or kist_tab_base.art50_ult_nrprot = 0 then 
	kist_tab_base.art50_ult_nrprot = 1
else
	kist_tab_base.art50_ult_nrprot ++
end if
kst_report_regart50.k_nrprotocollo = kist_tab_base.art50_ult_nrprot




end subroutine

public subroutine set_st_report_regart50 (ref st_report_regart50 kst_report_regart50) throws uo_exception;//---
//--- Legge i Dati da Archivio Azienda e riempie l'area ST_REPORT_REGART50
//---
string k_esito
kuf_base kuf1_base



if isnull(kst_report_regart50.k_data_a) then 
	kist_tab_base.art50_anno = year(kg_dataoggi)
else
	kist_tab_base.art50_anno = year(kst_report_regart50.k_data_a)
end if
if isnull(kst_report_regart50.k_data_a) then 
	kist_tab_base.art50_mese = month(kg_dataoggi)
else
	kist_tab_base.art50_mese = month(kst_report_regart50.k_data_a)
end if

if isnull(kist_tab_base.art50_ult_nrpagina) then
	kist_tab_base.art50_ult_nrpagina = 0 
else
	kist_tab_base.art50_ult_nrpagina = kst_report_regart50.k_nrpagina
end if
if isnull(kist_tab_base.art50_ult_nrprot) then
	kist_tab_base.art50_ult_nrprot = 0 
else
	kist_tab_base.art50_ult_nrprot = kst_report_regart50.k_nrprotocollo
end if
	
this.set_art50_dati_base( )




end subroutine

public subroutine get_report (ref st_report_regart50 kst_report_regart50) throws uo_exception;//---
//--- Genera Report Registro Articolo 50
//--- Inp: st_report_regart50.k_data_da e k_data_a
//--- out: 
//--- Lancia EXCPETION se errore
//---
int krc = 0, k_ctr
string k_rcx=""
long kind=0, kriga=0
string k_sql_orig, k_stringn, k_string, k_destinazione



//--- leggo e setto i campi dal BASE
get_art50_dati_base()

//--- genero le view da usare
db_crea_view_entrate(kst_report_regart50)
db_crea_view_entrate_altre(kst_report_regart50)
db_crea_view_spediti(kst_report_regart50)
db_crea_view_spediti_altri(kst_report_regart50)
//db_crea_view_fatt(kst_report_regart50)

//--- estrae dati dal DB

//--- Aggiorna SQL della 	kids_report_entrate_uscite
k_sql_orig = kids_report_entrate_uscite.Object.datawindow.Table.Select 
k_stringn = "vx_" + trim(kguo_utente.get_comp()) 
k_string = "vx_MAST"
k_ctr = PosA(k_sql_orig, k_string, 1)
DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
	k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
	k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
LOOP
kids_report_entrate_uscite.Object.datawindow.Table.Select = k_sql_orig
krc = kids_report_entrate_uscite.retrieve( )

if krc >= 0 then 
	
//--- Aggiorna SQL della kids_report_solo_uscite
	k_sql_orig = kids_report_solo_uscite.Object.datawindow.Table.Select 
	k_stringn = "vx_" + trim(kguo_utente.get_comp()) 
	k_string = "vx_MAST"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	kids_report_solo_uscite.Object.datawindow.Table.Select = k_sql_orig
	
	krc = kids_report_solo_uscite.retrieve( )
	if krc >= 0 then 
	
//--- Aggiorna SQL della  kids_report_solo_fatt
//		k_sql_orig = kids_report_solo_fatt.Object.datawindow.Table.Select 
//		k_stringn = "vx_" + trim(kguo_utente.get_comp()) 
//		k_string = "vx_MAST"
//		k_ctr = PosA(k_sql_orig, k_string, 1)
//		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
//			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
//			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
//		LOOP
//		kids_report_solo_fatt.Object.datawindow.Table.Select = k_sql_orig
//		
//		krc = kids_report_solo_fatt.retrieve( )
		
	end if
end if


//--- Riempie il Datastore REPORT da restituire
//--- Riferiimenti entrati nel periodo indicato con i dati di uscita
for kind = 1 to kids_report_entrate_uscite.rowcount( ) 
	
	kriga=kids_report_regart50.insertrow(0)
	
	kst_report_regart50.k_nrprotocollo++
	kids_report_regart50.setitem( kriga, "nrprot", kst_report_regart50.k_nrprotocollo )  //--- numero di Protocollo di partenza

	kids_report_regart50.setitem( kriga,"nrpag", kst_report_regart50.k_nrpagina -1)  //--- numero di pagina di partenza
	
	kids_report_regart50.setitem( kriga, "data_sort", kids_report_entrate_uscite.getitemdate(kind, "data_int") )
	kids_report_regart50.setitem( kriga, "merce", trim(kids_report_entrate_uscite.getitemstring(kind, "gru_des") ))
	kids_report_regart50.setitem( kriga, "colli_in", kids_report_entrate_uscite.getitemnumber(kind, "colli") )
	kids_report_regart50.setitem( kriga, "nrddt_in", trim(kids_report_entrate_uscite.getitemstring(kind, "num_bolla_in") ))
	kids_report_regart50.setitem( kriga, "dtddt_in", kids_report_entrate_uscite.getitemdate(kind, "data_bolla_in") )
	kids_report_regart50.setitem( kriga, "num_int", kids_report_entrate_uscite.getitemnumber(kind, "num_int") )
	kids_report_regart50.setitem( kriga, "data_int", kids_report_entrate_uscite.getitemdate(kind, "data_int") )
	kids_report_regart50.setitem( kriga, "data_ent", date(kids_report_entrate_uscite.getitemdatetime(kind, "data_ent")))
	kids_report_regart50.setitem( kriga, "e1doco", kids_report_entrate_uscite.getitemnumber(kind, "e1doco"))
	kids_report_regart50.setitem( kriga, "e1rorn", kids_report_entrate_uscite.getitemnumber(kind, "e1rorn"))
	kids_report_regart50.setitem( kriga, "id_meca", kids_report_entrate_uscite.getitemnumber(kind, "id_meca") )
	kids_report_regart50.setitem( kriga, "mittente", trim(kids_report_entrate_uscite.getitemstring(kind, "rag_soc_1")) + " (" +string(kids_report_entrate_uscite.getitemnumber(kind, "clie_1")) + ") "  )
	kids_report_regart50.setitem( kriga, "colli_out", kids_report_entrate_uscite.getitemnumber(kind, "colli_sped") )
	kids_report_regart50.setitem( kriga, "nrddt_out", kids_report_entrate_uscite.getitemnumber(kind, "num_bolla_out") )
	kids_report_regart50.setitem( kriga, "dtddt_out", kids_report_entrate_uscite.getitemdate(kind, "data_bolla_out") )
	kids_report_regart50.setitem( kriga, "ricevente", trim(kids_report_entrate_uscite.getitemstring(kind, "rag_soc_2")) + " (" +string(kids_report_entrate_uscite.getitemnumber(kind, "clie_2")) + ") "  )

//--- destinatario della merce
	k_destinazione = trim(kids_report_entrate_uscite.getitemstring(kind, "rag_soc_sped")) 
	if k_destinazione > " " then 
		if  trim(kids_report_entrate_uscite.getitemstring(kind, "loc"))  > " " then
			k_destinazione += trim(kids_report_entrate_uscite.getitemstring(kind, "loc")) 
		end if
		if  trim(kids_report_entrate_uscite.getitemstring(kind, "cap"))  > " " and  trim(kids_report_entrate_uscite.getitemstring(kind, "cap"))  <> "0" then
			k_destinazione +=  " - " +  trim(kids_report_entrate_uscite.getitemstring(kind, "cap")) 
		end if
		if  trim(kids_report_entrate_uscite.getitemstring(kind, "prov"))  > " "  then
			k_destinazione += " (" +   trim(kids_report_entrate_uscite.getitemstring(kind, "prov"))  + ") "
		end if
	else
		k_destinazione = trim(kids_report_entrate_uscite.getitemstring(kind, "rag_soc_2")) 
	end if	
	kids_report_regart50.setitem( kriga, "destinazione", k_destinazione)
	
//	kids_report_regart50.setitem( kriga, "colli_fatt", kids_report_entrate_uscite.getitemnumber(kind, "colli_fatt") )
//	kids_report_regart50.setitem( kriga, "nrfatt", kids_report_entrate_uscite.getitemnumber(kind, "num_fatt") )
//	kids_report_regart50.setitem( kriga, "dtfatt", kids_report_entrate_uscite.getitemdate(kind, "data_fatt") )
//	kids_report_regart50.setitem( kriga, "fatturato", trim(kids_report_entrate_uscite.getitemstring(kind, "rag_soc_3")) + " (" +string(kids_report_entrate_uscite.getitemnumber(kind, "clie_3")) + ") "  )
	
end for

//--- Spedizioni-Fatture usciti nel periodo indicato ma con il Riferimento con altra data
for kind = 1 to kids_report_solo_uscite.rowcount( ) 
	kriga=kids_report_regart50.insertrow(0)
	
	kids_report_regart50.setitem( kriga, "nrprot", 0 )
	kids_report_regart50.setitem( kriga,"nrpag", kst_report_regart50.k_nrpagina - 1 )  //--- numero di pagina di partenza
	
	kids_report_regart50.setitem( kriga, "data_sort", kids_report_solo_uscite.getitemdate(kind, "data_bolla_out") )
//	kids_report_regart50.setitem( kriga, "merce", trim(kids_report_solo_uscite.getitemstring(kind, "gru_des") ))
	kids_report_regart50.setitem( kriga, "merce", "Vedasi Riferimento Lotto nr. " &
								+ string(kids_report_solo_uscite.getitemnumber(kind, "num_int")) + " del " &
								+ string(kids_report_solo_uscite.getitemdate(kind, "data_int")) 	)
	kids_report_regart50.setitem( kriga, "colli_in", 0) //kids_report_solo_uscite.getitemnumber(kind, "colli") )
	kids_report_regart50.setitem( kriga, "nrddt_in", " ") //trim(kids_report_solo_uscite.getitemstring(kind, "num_bolla_in") ))
	kids_report_regart50.setitem( kriga, "dtddt_in", "" ) //kids_report_solo_uscite.getitemdate(kind, "data_bolla_in") )
	kids_report_regart50.setitem( kriga, "num_int", 0 ) //kids_report_solo_uscite.getitemnumber(kind, "num_int") )
	kids_report_regart50.setitem( kriga, "data_int", "") //kids_report_solo_uscite.getitemdate(kind, "data_int") )
	kids_report_regart50.setitem( kriga, "data_ent", "") 
	kids_report_regart50.setitem( kriga, "e1doco", 0) 
	kids_report_regart50.setitem( kriga, "e1rorn", 0) 
	kids_report_regart50.setitem( kriga, "id_meca", kids_report_solo_uscite.getitemnumber(kind, "id_meca") )
	kids_report_regart50.setitem( kriga, "mittente", " " ) //trim(kids_report_solo_uscite.getitemstring(kind, "rag_soc_1")) + " (" +string(kids_report_solo_uscite.getitemnumber(kind, "clie_1")) + ") "  )
	kids_report_regart50.setitem( kriga, "colli_out", kids_report_solo_uscite.getitemnumber(kind, "colli_sped") )
	kids_report_regart50.setitem( kriga, "nrddt_out", kids_report_solo_uscite.getitemnumber(kind, "num_bolla_out") )
	kids_report_regart50.setitem( kriga, "dtddt_out", kids_report_solo_uscite.getitemdate(kind, "data_bolla_out") )
	kids_report_regart50.setitem( kriga, "ricevente", trim(kids_report_solo_uscite.getitemstring(kind, "rag_soc_2")) + " (" +string(kids_report_solo_uscite.getitemnumber(kind, "clie_2")) + ") "  )
//--- destinatario della merce
	k_destinazione = trim(kids_report_solo_uscite.getitemstring(kind, "rag_soc_sped")) 
	if k_destinazione > " " then 
		if  trim(kids_report_solo_uscite.getitemstring(kind, "loc"))  > " " then
			k_destinazione += trim(kids_report_solo_uscite.getitemstring(kind, "loc")) 
		end if
		if  trim(kids_report_solo_uscite.getitemstring(kind, "cap"))  > " " and  trim(kids_report_solo_uscite.getitemstring(kind, "cap"))  <> "0" then
			k_destinazione +=  " - " +  trim(kids_report_solo_uscite.getitemstring(kind, "cap")) 
		end if
		if  trim(kids_report_solo_uscite.getitemstring(kind, "prov"))  > " "  then
			k_destinazione += " (" +   trim(kids_report_solo_uscite.getitemstring(kind, "prov"))  + ") "
		end if
	else
		k_destinazione = trim(kids_report_solo_uscite.getitemstring(kind, "rag_soc_2")) 
	end if	
	kids_report_regart50.setitem( kriga, "destinazione", k_destinazione)
	
//	kids_report_regart50.setitem( kriga, "colli_fatt", kids_report_solo_uscite.getitemnumber(kind, "colli_fatt") )
//	kids_report_regart50.setitem( kriga, "nrfatt", kids_report_solo_uscite.getitemnumber(kind, "num_fatt") )
//	kids_report_regart50.setitem( kriga, "dtfatt", kids_report_solo_uscite.getitemdate(kind, "data_fatt") )
//	kids_report_regart50.setitem( kriga, "fatturato", trim(kids_report_solo_uscite.getitemstring(kind, "rag_soc_3")) + " (" +string(kids_report_solo_uscite.getitemnumber(kind, "clie_3")) + ") "  )
	
end for
 
////--- Fatture del periodo indicato ma con il Riferimento e Spedizioni in altro periodo
//for kind = 1 to kids_report_solo_fatt.rowcount( ) 
//	kriga=kids_report_regart50.insertrow(0)
//	
//	kids_report_regart50.setitem( kriga, "nrprot", 0 )
//	kids_report_regart50.setitem( kriga,"nrpag", kst_report_regart50.k_nrpagina - 1 )  //--- numero di pagina di partenza
//	
//	kids_report_regart50.setitem( kriga, "data_sort", kids_report_solo_fatt.getitemdate(kind, "data_fatt") )
//	kids_report_regart50.setitem( kriga, "merce", "Vedasi Riferimento Lotto nr. " &
//								+ string(kids_report_solo_uscite.getitemnumber(kind, "num_int")) + " del " &
//								+ string(kids_report_solo_uscite.getitemdate(kind, "data_int")) 	)
//	kids_report_regart50.setitem( kriga, "colli_in", 0) //kids_report_solo_uscite.getitemnumber(kind, "colli") )
//	kids_report_regart50.setitem( kriga, "nrddt_in", " ") //trim(kids_report_solo_uscite.getitemstring(kind, "num_bolla_in") ))
//	kids_report_regart50.setitem( kriga, "dtddt_in", "" ) //kids_report_solo_uscite.getitemdate(kind, "data_bolla_in") )
//	kids_report_regart50.setitem( kriga, "num_int", 0 ) //kids_report_solo_uscite.getitemnumber(kind, "num_int") )
//	kids_report_regart50.setitem( kriga, "data_int", "") //kids_report_solo_uscite.getitemdate(kind, "data_int") )
//	kids_report_regart50.setitem( kriga, "data_ent", "") 
//	kids_report_regart50.setitem( kriga, "e1doco", 0) 
//	kids_report_regart50.setitem( kriga, "e1rorn", 0) 
//	kids_report_regart50.setitem( kriga, "id_meca", kids_report_solo_fatt.getitemnumber(kind, "id_meca") )
//	kids_report_regart50.setitem( kriga, "mittente", " ") //trim(kids_report_solo_fatt.getitemstring(kind, "rag_soc_1")) + " (" +string(kids_report_solo_fatt.getitemnumber(kind, "clie_1")) + ") "  )
//	kids_report_regart50.setitem( kriga, "colli_out", 0 ) // kids_report_solo_fatt.getitemnumber(kind, "colli_sped") )
//	kids_report_regart50.setitem( kriga, "nrddt_out", 0) // kids_report_solo_fatt.getitemnumber(kind, "num_bolla_out") )
//	kids_report_regart50.setitem( kriga, "dtddt_out", "") // kids_report_solo_fatt.getitemdate(kind, "data_bolla_out") )
//	kids_report_regart50.setitem( kriga, "ricevente", " ") // trim(kids_report_solo_fatt.getitemstring(kind, "rag_soc_2")) + " (" +string(kids_report_solo_fatt.getitemnumber(kind, "clie_2")) + ") "  )
////--- destinatario della merce
//	k_destinazione = trim(kids_report_solo_fatt.getitemstring(kind, "rag_soc_sped")) 
//	if k_destinazione > " " then 
//		if  trim(kids_report_solo_fatt.getitemstring(kind, "loc"))  > " " then
//			k_destinazione += trim(kids_report_solo_fatt.getitemstring(kind, "loc")) 
//		end if
//		if  trim(kids_report_solo_fatt.getitemstring(kind, "cap"))  > " " and  trim(kids_report_solo_fatt.getitemstring(kind, "cap"))  <> "0" then
//			k_destinazione +=  " - " +  trim(kids_report_solo_fatt.getitemstring(kind, "cap")) 
//		end if
//		if  trim(kids_report_solo_fatt.getitemstring(kind, "prov"))  > " "  then
//			k_destinazione += " (" +   trim(kids_report_solo_fatt.getitemstring(kind, "prov"))  + ") "
//		end if
//	else
//		k_destinazione = trim(kids_report_solo_fatt.getitemstring(kind, "rag_soc_2")) 
//	end if	
//	kids_report_regart50.setitem( kriga, "destinazione", k_destinazione)
//	
//	kids_report_regart50.setitem( kriga, "colli_fatt", kids_report_solo_fatt.getitemnumber(kind, "colli_fatt") )
//	kids_report_regart50.setitem( kriga, "nrfatt", kids_report_solo_fatt.getitemnumber(kind, "num_fatt") )
//	kids_report_regart50.setitem( kriga, "dtfatt", kids_report_solo_fatt.getitemdate(kind, "data_fatt") )
//	kids_report_regart50.setitem( kriga, "fatturato", trim(kids_report_solo_fatt.getitemstring(kind, "rag_soc_3")) + " (" +string(kids_report_solo_fatt.getitemnumber(kind, "clie_3")) + ") "  )
//	
//end for
  
kids_report_regart50.setsort( "data_sort asc, num_int asc " )
kids_report_regart50.sort( )



end subroutine

private subroutine set_art50_dati_base () throws uo_exception;//---
//--- Salva i Dati in Archivio Azienda nell'area comune 
//---
string k_esito
kuf_base kuf1_base
st_esito kst_esito


kuf1_base = create kuf_base

kist_tab_base.st_tab_g_0.esegui_commit = "N"
kist_tab_base.key =  "art50_anno"
kist_tab_base.key1 = string(kist_tab_base.art50_anno )
kst_esito  = kuf1_base.metti_dato_base(kist_tab_base)
if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in scrittura archivio BASE (set 'art50_anno') - cod. " + string(kst_esito.sqlcode )+" ~n~r"+ trim(kst_esito.sqlerrtext ))
	throw kguo_exception
else
	kist_tab_base.art50_anno = integer(mid(k_esito,2))
end if

kist_tab_base.st_tab_g_0.esegui_commit = "N"
kist_tab_base.key =  "art50_mese"
kist_tab_base.key1 = string(kist_tab_base.art50_mese )
kst_esito  = kuf1_base.metti_dato_base(kist_tab_base)
if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in scrittura archivio BASE (set 'art50_mese') - cod. " + string(kst_esito.sqlcode )+" ~n~r"+ trim(kst_esito.sqlerrtext ))
	throw kguo_exception
else
	kist_tab_base.art50_mese = integer(mid(k_esito,2))
end if

kist_tab_base.st_tab_g_0.esegui_commit = "N"
kist_tab_base.key =  "art50_ult_nrpagina"
kist_tab_base.key1 = string(kist_tab_base.art50_ult_nrpagina ) 
kst_esito  = kuf1_base.metti_dato_base(kist_tab_base)
if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in scrittura archivio BASE (set 'art50_ult_nrpagina') - cod. " + string(kst_esito.sqlcode )+" ~n~r"+ trim(kst_esito.sqlerrtext ))
	throw kguo_exception
else
	kist_tab_base.art50_ult_nrpagina = integer(mid(k_esito,2))
end if

kist_tab_base.st_tab_g_0.esegui_commit = "S"
kist_tab_base.key =  "art50_ult_nrprot"
kist_tab_base.key1 = string(kist_tab_base.art50_ult_nrprot ) 
kst_esito  = kuf1_base.metti_dato_base(kist_tab_base)
if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.setmessage( "Errore in scrittura archivio BASE (set 'art50_ult_nrprot') - cod. " + string(kst_esito.sqlcode )+" ~n~r"+ trim(kst_esito.sqlerrtext ))
	throw kguo_exception
else
	kist_tab_base.art50_ult_nrprot = integer(mid(k_esito,2))
end if


destroy kuf1_base



end subroutine

private subroutine get_id_meca (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception;//
//--- ricava il range id_meca da un range numero/data
//
date k_data_ufo
st_esito kst_esito
uo_exception kuo_exception


//--- ricavo i numeri diferineto da--a-- esatti
	if kst_tab_meca_da.num_int = 0 and kst_tab_meca_da.data_int > date(0) then
		if year(kst_tab_meca_da.data_int) = year(kst_tab_meca_a.data_int) then
			select min(id), max(id)
				 into 
                         :kst_tab_meca_da.id 
					   ,:kst_tab_meca_a.id
				 from meca
				 where data_int between :kst_tab_meca_da.data_int and :kst_tab_meca_a.data_int
				 using sqlca;
		else
			k_data_ufo = date('31.12.' + string(kst_tab_meca_da.data_int, "yyyy"))
			select  min(id)
				 into :kst_tab_meca_da.id 
				 from meca
				 where data_int between :kst_tab_meca_da.data_int  and :k_data_ufo
				 using sqlca;
			k_data_ufo = date('01.01.' + string(kst_tab_meca_a.data_int, "yyyy"))
			select max(id)
				 into  :kst_tab_meca_a.id
				 from meca
				 where data_int between :k_data_ufo and :kst_tab_meca_a.data_int
				 using sqlca;
		end if
		
	end if
	
//--- ricava il  ID  MECA
	if sqlca.sqlcode >= 0 and kst_tab_meca_da.id = 0 then
		if year(kst_tab_meca_da.data_int) = year(kst_tab_meca_a.data_int) then
			select min(id), max(id)
				 into :kst_tab_meca_da.id, :kst_tab_meca_a.id
				 from meca
				 where data_int between :kst_tab_meca_da.data_int and :kst_tab_meca_a.data_int
				 using sqlca;
		else
			k_data_ufo = date('31.12.' + string(kst_tab_meca_da.data_int, "yyyy"))
			select min(id)
				 into :kst_tab_meca_da.id
				 from meca
				 where num_int >= :kst_tab_meca_da.id and data_int between :kst_tab_meca_da.data_int and :k_data_ufo
				 using sqlca;
			k_data_ufo = date('01.01.' + string(kst_tab_meca_a.data_int, "yyyy"))
			select max(id)
				 into :kst_tab_meca_a.id
				 from meca
				 where num_int <= :kst_tab_meca_a.id and data_int between :k_data_ufo and :kst_tab_meca_a.data_int
				 using sqlca;
		end if
	end if

	if sqlca.sqlcode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Lettura Id Riferimento (MECA):" + trim(sqlca.SQLErrText)
		kst_esito.nome_oggetto = this.classname()
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
				
	end if

end subroutine

private subroutine get_id_sped (ref st_tab_sped kst_tab_sped_da, ref st_tab_sped kst_tab_sped_a) throws uo_exception;//
//--- ricava il range id_sped da un range data
//
date k_data_ufo
st_esito kst_esito
uo_exception kuo_exception


//--- ricavo i numeri diferineto da--a-- esatti
	if year(kst_tab_sped_da.data_bolla_out) = year(kst_tab_sped_a.data_bolla_out) then
		select min(id_sped), max(id_sped)
			 into 
					 :kst_tab_sped_da.id_sped 
					,:kst_tab_sped_a.id_sped
			 from sped
			 where data_bolla_out between :kst_tab_sped_da.data_bolla_out and :kst_tab_sped_a.data_bolla_out
			 using sqlca;
	else
		k_data_ufo = date('31.12.' + string(kst_tab_sped_da.data_bolla_out, "yyyy"))
		select  min(id_sped)
			 into :kst_tab_sped_da.id_sped 
			 from sped
			 where data_bolla_out between :kst_tab_sped_da.data_bolla_out  and :k_data_ufo
			 using sqlca;
		k_data_ufo = date('01.01.' + string(kst_tab_sped_a.data_bolla_out, "yyyy"))
		select max(id_sped)
			 into  :kst_tab_sped_a.id_sped
			 from sped
			 where data_bolla_out between :k_data_ufo and :kst_tab_sped_a.data_bolla_out
			 using sqlca;
	end if
		

	if sqlca.sqlcode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Lettura id DDT di spedizione (SPED):" + trim(sqlca.SQLErrText)
		kst_esito.nome_oggetto = this.classname()
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
				
	end if

end subroutine

event constructor;call super::constructor;//
kids_report_entrate_uscite = create datastore
kids_report_entrate_uscite.dataobject = "d_art50_entrate_uscite_l_nofatt"
kids_report_entrate_uscite.settransobject(sqlca)
kids_report_solo_uscite = create datastore
kids_report_solo_uscite.dataobject = "d_art50_solo_uscite_l_nofatt"
kids_report_solo_uscite.settransobject(sqlca)
//kids_report_solo_fatt = create datastore
//kids_report_solo_fatt.dataobject = "d_art50_solo_fatt_l"
//kids_report_solo_fatt.settransobject(sqlca)

kids_report_regart50 = create datastore
kids_report_regart50.dataobject = "d_report_9_regart50"
kids_report_regart50.settransobject(sqlca)

end event

on kuf_report_regart50.create
call super::create
end on

on kuf_report_regart50.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if not isnull(kids_report_regart50) then destroy kids_report_regart50
if not isnull(kids_report_entrate_uscite) then destroy kids_report_entrate_uscite
if not isnull(kids_report_solo_uscite) then destroy kids_report_solo_uscite
//if not isnull(kids_report_solo_fatt) then destroy kids_report_solo_fatt




end event

