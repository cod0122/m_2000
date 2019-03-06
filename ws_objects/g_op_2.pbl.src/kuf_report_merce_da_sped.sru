$PBExportHeader$kuf_report_merce_da_sped.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_merce_da_sped from nonvisualobject
end type
end forward

global type kuf_report_merce_da_sped from nonvisualobject
end type
global kuf_report_merce_da_sped kuf_report_merce_da_sped

type variables
//
private st_report_merce_da_sped kist_report_merce_da_sped
private st_tab_base kist_tab_base


//--- dati da restituire - il Report 
public datastore kids_report_merce_da_sped


end variables

forward prototypes
private subroutine db_crea_view_spediti (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
public subroutine get_st_report_merce_da_sped (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
private subroutine db_crea_view_trattati (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
public subroutine get_id_meca (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
private subroutine db_crea_view_da_sped (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
private subroutine db_crea_view_da_non_trattare (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
private subroutine db_crea_view_da_sped_1 (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
private subroutine db_crea_view_lotti_nomag (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
public function integer get_report (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception
end prototypes

private subroutine db_crea_view_spediti (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
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

//--- costruisco la view elenco  ID_MECA delle Bolle emesse 
	k_view = kguf_data_base.u_get_nometab_xutente("merce_da_sped_Spediti")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_sped) AS   " &
	 + "  SELECT armo.id_meca,   " &
	 		+ " armo.id_armo,   " &
	 		+ " sum(arsp.colli) " &
	 + "    FROM armo inner join arsp on  armo.id_armo = arsp.id_armo   " &
	 + "  WHERE "   &
	             + " armo.id_meca  >=   "  + string(kst_report_merce_da_sped.k_id_meca_da) + "   "     &
                 + " group by  armo.id_meca, armo.id_armo " 

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

public subroutine get_st_report_merce_da_sped (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//---
//--- Imposta  l'area st_report_merce_da_sped
//---

kst_report_merce_da_sped.k_data_da = relativedate(kg_dataoggi, -365) 
kst_report_merce_da_sped.k_clie_2 = 0
kst_report_merce_da_sped.k_id_meca_da=0

end subroutine

private subroutine db_crea_view_trattati (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
//--- Crea View con elenco entrate per periodo
//
int k_ctr
string k_view, k_sql
date k_dataMeno365
kuf_utility kuf1_utility
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kuf1_utility = create kuf_utility


//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view =  kguf_data_base.u_get_nometab_xutente("merce_da_sped_Trattati")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_trattati, colli_groupage, num_certif, data_stampa) AS   " &
	 + "  SELECT armo.id_meca,   " &
			 + " armo.id_armo,   " &
			 + " sum(artr.colli_trattati), " &
			 + " sum(artr.colli_groupage), " &
			 + " artr.num_certif,    " &
			 + " certif.data_stampa    " &
	 + "    FROM armo inner join artr on armo.id_armo = artr.id_armo  " &
	 +                        " left outer join certif on artr.num_certif =  certif.num_certif  " &
	 + "   WHERE       " &
	 + "          armo.id_meca  >=  "  + string(kst_report_merce_da_sped.k_id_meca_da) + "  "     &
	 + " GROUP BY armo.id_meca,     " &
			 + " armo.id_armo,  " & 
			 + " artr.num_certif,   " & 
			 + " certif.data_stampa    " 

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

public subroutine get_id_meca (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//---
//--- Imposta id_meca da cui partire  x  l'area st_report_merce_da_sped
//---
st_esito kst_esito
kuf_armo kuf1_armo
st_tab_armo kst_tab_armo


if isnull(kst_report_merce_da_sped.k_data_da) or kst_report_merce_da_sped.k_data_da = date(0) then kst_report_merce_da_sped.k_data_da = kg_dataoggi


kuf1_armo = create kuf_armo

kst_tab_armo.data_int = kst_report_merce_da_sped.k_data_da
kst_tab_armo.num_int = 0
kst_esito = kuf1_armo.get_id_meca_da_data(kst_tab_armo)

if kst_esito.esito = kkg_esito.not_fnd or isnull(kst_tab_armo.id_meca) then kst_tab_armo.id_meca = 0

kst_report_merce_da_sped.k_id_meca_da =  kst_tab_armo.id_meca 


destroy kuf1_armo



end subroutine

private subroutine db_crea_view_da_sped (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
//--- Crea View con elenco Trattati da Spedire
//
int k_ctr
string k_view, k_sql
kuf_utility kuf1_utility
kuf_armo kuf1_armo
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


kuf1_utility = create kuf_utility


//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = kguf_data_base.u_get_nometab_xutente("merce_da_sped_elenco_l_1")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	                      	    	 + "  ( id_meca, num_int, data_int,  " &
	                      	    	                     + " data_ent,  " &
	                     	     		                  + " clie_1,  " &
	                                                   + " rag_soc_1 , " &
	                                                   + " clie_2 , " &
	                                                   + " rag_soc_2 , " &
	                                                   + " clie_3 , " &
	                                                   + " num_bolla_in, " & 
	                                                   + " consegna_data, " & 
	                          			                  + " data_stampa_certif, num_certif, " &
	                                                   + " anno , " &
	                                                   + " mese ,  " &
	                                                   + " giorno,  " &
 	                                                   + " art, " &
 	                                                   + " alt_2, " &
	                                                   + " pedane, " &
	                                                   + " colli_entrati, " &
	                                                   + " colli_trattati, " &
	                                                   + " colli_groupage, " &
	                          			                  + " colli_daNonTrattare, " &
	                          		               	   + " colli_NoMag, " &
	                                                   + " colli_sped, " &
																	 + " e1doco, " &
																	 + " e1rorn " &
																	 + " ,e1srst " &
	                          + "  ) AS   " &
	                          + "   SELECT   distinct " &
	                                                   + " meca.id, " &
	                                                   + " meca.num_int,  " &
	                                                   + " meca.data_int, " &
	                                                   + " meca.data_ent, " &
	                                                   + " meca.clie_1, " &
	                                                   + " clienti_1.rag_soc_10 , " &
	                                                   + " meca.clie_2, " &
	                                                   + " clienti_2.rag_soc_10 , " &
	                                                   + " meca.clie_3, " &
	                                                   + " meca.num_bolla_in, " &
	                                                   + " meca.consegna_data, " &
	                                                   + " Trattati.data_stampa, " &
	                                                   + " Trattati.num_certif, " &
	                                                   + " Year(meca.data_int) , " &
	                                                   + " Month(meca.data_int) ,  " &
	                                                   + " day (meca.data_int),  " &
 	                                                   + " armo.art, " &
 	                                                   + " armo.alt_2, " &
	                                                   + " (armo.pedane),  " &
	                                                   + " (armo.colli_2), " &
	                                                   + " coalesce(Trattati.colli_trattati,0), " &
	                                                   + " coalesce(Trattati.colli_groupage,0), " &
	                          			                  + " coalesce(daNonTrattare.colli_daNonTrattare,0), " &
	                                       			   + " coalesce(NoMag.colli_NoMag,0), " &
	                                                   + " coalesce(sped.colli_sped,0), " &
																	 + " coalesce(meca.e1doco, 0), " &
																	 + " coalesce(meca.e1rorn, 0) " &
                                                    + ",coalesce(meca.e1srst, 'NC') " &   
	                          + "   FROM ((((((( meca INNER JOIN  armo ON ( meca.id =  armo.id_meca)) " &
	                                               + " LEFT JOIN " + kguf_data_base.u_get_nometab_xutente("merce_da_sped_Trattati") + " as Trattati ON armo.id_armo = Trattati.id_armo) " &
	                                               + " LEFT JOIN " + kguf_data_base.u_get_nometab_xutente("merce_da_sped_daNonTrattare") + " as daNonTrattare ON  armo.id_armo= daNonTrattare.id_armo)" &
	                                               + " LEFT JOIN " + kguf_data_base.u_get_nometab_xutente("merce_da_sped_Spedit") + "i as sped ON armo.id_armo =  sped.id_armo)  " &
	                                               + " LEFT JOIN " + kguf_data_base.u_get_nometab_xutente("merce_da_sped_NoMag") + " as NoMag ON armo.id_armo =  NoMag.id_armo)  " &
	                                               + " INNER JOIN  clienti AS  clienti_1 ON  meca.clie_1 =  clienti_1.codice)  " &
	                                               + " INNER JOIN  clienti AS  clienti_2 ON  meca.clie_2 =  clienti_2.codice) " &
	                          	+ " WHERE "  &
	                          	+ "  meca.id  >=  "  + string(kst_report_merce_da_sped.k_id_meca_da)  + "   "    &
                            	+ "  and (meca.aperto is null or meca.aperto = ' ' " & 
							+ " or meca.aperto = '" + kuf1_armo.kki_meca_aperto_SI + "' " &
							+ " or meca.aperto = '" + kuf1_armo.kki_meca_aperto_RIAPERTO + "') " 

	 
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

private subroutine db_crea_view_da_non_trattare (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
//--- Crea View con numero di colli da NON trattare x Id_Armo
//
int k_ctr
string k_view, k_sql
date k_dataMeno365
kuf_utility kuf1_utility
st_esito kst_esito
uo_exception kuo_exception
kuf_barcode kuf1_barcode
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kuf1_utility = create kuf_utility

	k_dataMeno365 = relativedate(KG_dataoggi, -365)

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = kguf_data_base.u_get_nometab_xutente("merce_da_sped_daNonTrattare")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_daNonTrattare) AS   " &
	 + "  SELECT barcode.id_meca,   " &
	              + " barcode.id_armo,   " &
	              + " count(barcode)  " &
	 + "    FROM barcode  " &
	 + "   WHERE       " &
	 + "    barcode.id_meca >= "  + string(kst_report_merce_da_sped.k_id_meca_da) + "  "     &
	 + "	and  barcode.causale =  '" + trim(kuf1_barcode.ki_causale_non_trattare ) + "' " &
	 + "	   group by barcode.id_meca, barcode.id_armo  " 

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

private subroutine db_crea_view_da_sped_1 (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
//--- Crea View con elenco Colli da Spedire
//
int k_ctr
string k_view, k_sql
kuf_utility kuf1_utility
kuf_armo kuf1_armo
st_esito kst_esito
uo_exception kuo_exception
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


kuf1_utility = create kuf_utility


//--- costruisco la view con ID_MECA con la somma dei colli da spedire
	k_view = kguf_data_base.u_get_nometab_xutente("merce_da_sped_elenco_l")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, num_int, data_int,  " &
	 + "  	data_ent,    " &
	 + "         clie_1,  " &
	 + "  		rag_soc_1 , " &
	 + "  		clie_2 , " &
	 + "  		rag_soc_2 , " &
	 + "  		clie_3 , " &
	 + "  		num_bolla_in, " & 
	 + "  		consegna_data, " & 
	 + "         data_stampa_certif, num_certif, " &
	 + "  		anno , " &
	 + "  		mese ,  " &
	 + "  		giorno,  " &
	 + "  		art, " &
	 + "  		alt_2, " &
	 + "  		pedane, " &
	 + "  		colli_entrati, " &
	 + "  		colli_trattati, " &
	 + "  		colli_groupage, " &
	 + "         colli_daNonTrattare, " &
	 + "  		colli_dasped, " &
	 + "  		colli_sped, " &
	 + "  		e1doco, " &
	 + "  		e1rorn " &
	 + " ,e1srst " &
	 + " ) AS   " &
	 + "  SELECT   " &
	 + "  	id_meca,    " &
	 + "  	num_int,    " &
	 + "  	data_int,    " &
	 + "  	data_ent,    " &
	 + "  	clie_1,    " &
	 + "  	rag_soc_1 ,    " &
	 + "  	clie_2,    " &
	 + "  	rag_soc_2 ,    " &
	 + "  	clie_3,    " &
	 + "  	num_bolla_in,    " &
	 + "  	consegna_data,    " &
	 + "  	data_stampa_certif,   " &
	 + "  	num_certif,    " &
	 + "  		anno , " &
	 + "  		mese ,  " &
	 + "  		giorno,  " &
	 + "  		art, " &
	 + "  		alt_2, " &
	 + "  		pedane, " &
	 + "  	colli_entrati ,    " &
	 + "  	colli_trattati,    " &
	 + "  	colli_groupage,    " &
	+ " CASE     " &
	+ "   WHEN colli_NoMag > 0 THEN colli_NoMag   " &
	+ "   ELSE colli_danontrattare    " &
	+ " END,   " &
	 + "  	(colli_trattati  + colli_danontrattare + colli_NoMag - colli_sped) as colli_dasped,   " & 
	 + "  	colli_sped,   " &
	 + "  	e1doco, " &
	 + "  	e1rorn " &
    + " ,e1srst " &
	 + "  FROM " + kguf_data_base.u_get_nometab_xutente("merce_da_sped_elenco_l_1") 

	 //	 + "  	(colli_danontrattare + colli_NoMag),    " &

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

private subroutine db_crea_view_lotti_nomag (st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//
//--- Crea View con numero di colli per:
//--- 		lotti entrati ma hanno causale di entrata con il flag ddt da spedire senza avere avuto alcun trattamento (solo in transito) 
//--- 		lotti entrati ma non di magazzino 2
//
int k_ctr
string k_view, k_sql
date k_dataMeno365
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_meca_causali kst_tab_meca_causali
kuf_utility kuf1_utility
st_esito kst_esito
uo_exception kuo_exception
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausilari
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

	kuf1_utility = create kuf_utility
	kuf1_armo = create kuf_armo

	k_dataMeno365 = relativedate(KG_dataoggi, -365)
	
	kst_tab_meca_causali.flag_ddt_si = kuf1_ausilari.kki_meca_causale_FLAG_DDT_SI
	kst_tab_meca.stato = kuf1_armo.ki_meca_stato_ok
	kst_tab_armo.magazzino = kuf1_armo.kki_magazzino_DATRATTARE

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = kguf_data_base.u_get_nometab_xutente("merce_da_sped_NoMag")
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_NoMag) AS   " &
	 + "  SELECT armo.id_meca,   " &
	 		+ " armo.id_armo,   " &
			+ " sum(armo.colli_2)  " &
	 + "    FROM meca inner join armo on meca.id = armo.id_meca  " &
	 + "              left outer join artr on armo.id_armo = artr.id_armo  " &
	 + "              left outer join meca_blk on meca.id = meca_blk.id_meca  " &
	 + "              left outer join meca_causali on meca_blk.id_meca_causale = meca_causali.id_meca_causale  " &
	 + "   WHERE       " &
	 + "    meca.id >= "  + string(kst_report_merce_da_sped.k_id_meca_da) + "  "     &
			 + "	and artr.id_armo is null " &
			 + "	and (meca_causali.flag_ddt_si =  '" + trim(kst_tab_meca_causali.flag_ddt_si) + "' ) " &
	 + "	   group by armo.id_meca, armo.id_armo  " 

//			 + "	  or  armo.magazzino <> " + string(kst_tab_armo.magazzino) + " ) " &

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

public function integer get_report (ref st_report_merce_da_sped kst_report_merce_da_sped) throws uo_exception;//---
//--- Genera Report Elenco Merce da Spedire
//--- Inp: st_report_merce_da_sped.k_num_da e k_num_a e k_anno e clie_2
//--- out: 
//--- Lancia EXCPETION se errore
//---
int k_return=0
int krc = 0, k_ctr
string k_rcx=""
long kind=0, kriga=0
string k_sql_orig, k_stringn, k_string

//st_report_merce_da_sped kst_report_merce_da_sped
//
kids_report_merce_da_sped.reset( )
//
if isnull(kst_report_merce_da_sped.k_clie_2) then kst_report_merce_da_sped.k_clie_2 = 0

get_id_meca (kst_report_merce_da_sped)

if kst_report_merce_da_sped.k_id_meca_da > 0 then
	
//--- genero le view da usare
	db_crea_view_Trattati(kst_report_merce_da_sped)
	db_crea_view_spediti(kst_report_merce_da_sped)
	db_crea_view_da_non_trattare(kst_report_merce_da_sped)
	db_crea_view_lotti_nomag(kst_report_merce_da_sped)
	db_crea_view_da_sped(kst_report_merce_da_sped)
	db_crea_view_da_sped_1(kst_report_merce_da_sped)
	
	//--- estrae dati dal DB
	
	//--- Aggiorna SQL della 	kids_report_entrate_uscite
	kguf_data_base.u_set_ds_change_name_tab(kids_report_merce_da_sped, "vx_mast_merce_da_sped_elenco_l")
	
	//--- Retrieve Datastore REPORT da restituire
	k_return = kids_report_merce_da_sped.retrieve( kst_report_merce_da_sped.k_data_da,  kst_report_merce_da_sped.k_clie_2)
end if

return k_return


end function

event constructor;//
kids_report_merce_da_sped = create datastore
kids_report_merce_da_sped.dataobject = "d_merce_da_sped"
kids_report_merce_da_sped.settransobject(sqlca)

end event

on kuf_report_merce_da_sped.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_report_merce_da_sped.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if not isnull(kids_report_merce_da_sped) then destroy kids_report_merce_da_sped




end event

