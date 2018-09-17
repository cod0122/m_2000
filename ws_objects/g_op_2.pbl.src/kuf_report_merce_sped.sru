$PBExportHeader$kuf_report_merce_sped.sru
$PBExportComments$report x movimenti registro articolo 50
forward
global type kuf_report_merce_sped from nonvisualobject
end type
end forward

global type kuf_report_merce_sped from nonvisualobject
end type
global kuf_report_merce_sped kuf_report_merce_sped

type variables
//
private st_report_merce_sped kist_report_merce_sped
private st_tab_base kist_tab_base


//--- dati da restituire - il Report 
public datastore kids_report_merce_sped


end variables

forward prototypes
public subroutine get_st_report_merce_sped (ref st_report_merce_sped kst_report_merce_sped) throws uo_exception
public subroutine get_report (ref st_report_merce_sped kst_report_merce_sped) throws uo_exception
private subroutine db_crea_view_id_armo (st_report_merce_sped kst_report_merce_sped) throws uo_exception
private subroutine db_crea_view_spediti () throws uo_exception
private subroutine db_crea_view_trattati () throws uo_exception
private subroutine db_crea_view_da_non_trattare () throws uo_exception
private subroutine db_crea_view_completa () throws uo_exception
private subroutine db_crea_view_entrati () throws uo_exception
end prototypes

public subroutine get_st_report_merce_sped (ref st_report_merce_sped kst_report_merce_sped) throws uo_exception;//---
//--- Imposta  l'area st_report_merce_da_sped
//---

kst_report_merce_sped.k_data_da = relativedate(kg_dataoggi, -30) 
kst_report_merce_sped.k_data_a = kg_dataoggi
kst_report_merce_sped.k_clie_2 = 0
kst_report_merce_sped.k_id_sped_da=0

end subroutine

public subroutine get_report (ref st_report_merce_sped kst_report_merce_sped) throws uo_exception;//---
//--- Genera Report Elenco Merce da Spedire
//--- Inp: st_report_merce_da_sped.k_num_da e k_num_a e k_anno e clie_2
//--- out: 
//--- Lancia EXCPETION se errore
//---
int krc = 0, k_ctr
string k_rcx=""
long kind=0, kriga=0
string k_sql_orig, k_stringn, k_string

//st_report_merce_da_sped kst_report_merce_da_sped

if isnull(kst_report_merce_sped.k_clie_2) then kst_report_merce_sped.k_clie_2 = 0

//--- genero le view da usare
db_crea_view_id_armo(kst_report_merce_sped)
db_crea_view_entrati()
db_crea_view_Trattati()
db_crea_view_spediti()
db_crea_view_da_non_trattare()
db_crea_view_completa( )
	
	
//--- Aggiorna SQL della 	kids_report_entrate_uscite
kguf_data_base.u_set_ds_change_name_tab(kids_report_merce_sped, "vx_mast_merce_sped_elenco_l")
	
	//--- Retrieve Datastore REPORT da restituire
krc = kids_report_merce_sped.retrieve( kst_report_merce_sped.k_data_da,  kst_report_merce_sped.k_clie_2)



end subroutine

private subroutine db_crea_view_id_armo (st_report_merce_sped kst_report_merce_sped) throws uo_exception;//
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


//--- costruisco la view 
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo "
	k_sql = &
		"CREATE VIEW " + trim(k_view) &
		 + " ( id_armo, id_sped, id_arsp) AS   " &
		 + "  SELECT arsp.id_armo, arsp.id_sped, arsp.id_arsp " 
	if kst_report_merce_sped.k_clie_2 > 0 then
		k_sql  += "    FROM sped inner join arsp on sped.id_sped = arsp.id_sped " &
		 + "   WHERE       " &
		 + "          sped.clie_2 = "  + string(kst_report_merce_sped.k_clie_2) + " and " &
		 + "          arsp.data_bolla_out  between  '"  + string(kst_report_merce_sped.k_data_da) + "' and  '" + string(kst_report_merce_sped.k_data_a) + "' "    
	else
		k_sql  += "    FROM arsp inner join armo on arsp.id_armo = armo.id_armo " &
		 + "   WHERE       " &
		 + "          arsp.data_bolla_out  between  '"  + string(kst_report_merce_sped.k_data_da) + "' and  '" + string(kst_report_merce_sped.k_data_a) + "' "    
	end if
		k_sql  += "    group by " &
		 + "  arsp.id_armo, arsp.id_sped, arsp.id_arsp   " 
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

private subroutine db_crea_view_spediti () throws uo_exception;//
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
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_Spediti "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_sped, num_bolla_out, data_bolla_out, id_sped) AS   " &
	 + "  SELECT armo.id_meca,   " &
		 + " armo.id_armo,   " &
		 + " sum(arsp.colli), arsp.num_bolla_out, arsp.data_bolla_out, id_sped " &
	 + "    FROM armo inner join arsp on  armo.id_armo = arsp.id_armo   " &
	 + "  WHERE "  &
	 + "          arsp.id_arsp  in   (" +  " select distinct id_arsp from vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo" + ") "  &
	 + " 	    group by  armo.id_meca, armo.id_armo, num_bolla_out, data_bolla_out, id_sped   " 
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

private subroutine db_crea_view_trattati () throws uo_exception;//
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


//--- costruisco la view 
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_Trattati "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_trattati, colli_groupage, num_certif, data_stampa, id_sped) AS   " &
	 + "  SELECT armo.id_meca,   " &
           	 + " armo.id_armo,   " &
          	 + " sum(artr.colli_trattati), " &
	          + " sum(artr.colli_groupage), " & 
          	 + " artr.num_certif,    " &
          	 + " certif.data_stampa    " &
          	 + " ,arsp.id_sped " &
	 + "    FROM arsp   " &
          	 +   " inner join armo on arsp.id_armo = armo.id_armo   " &
          	 +    " inner join artr on arsp.id_armo = artr.id_armo  "   &
          	 +     " left outer join certif on artr.num_certif =  certif.num_certif  " &
	 + "   WHERE       " &
	 + "          arsp.id_arsp  in   (" +  " select distinct id_arsp from vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo" + ") "  &
	 + " GROUP BY armo.id_meca " &
           	 + " ,armo.id_armo   " &
		 + " ,artr.num_certif " & 
		 + " ,arsp.id_sped " &
	 	+ " ,certif.data_stampa    " 

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

private subroutine db_crea_view_da_non_trattare () throws uo_exception;//
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
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_daNonTrattare "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca, id_armo, colli_daNonTrattare, id_sped) AS   " &
	 + "  SELECT barcode.id_meca,   " &
	 		+ " barcode.id_armo,  " &
	 		+ " count(barcode)  " &
	 		+ " ,arsp.id_sped " &
	 + "    FROM arsp inner join barcode  on  arsp.id_armo = barcode.id_armo " &
	 + "   WHERE       " &
	 + "          arsp.id_arsp  in   (" +  " select distinct id_arsp from vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo" + ") "  &
	 + "	and  barcode.causale =  '" + trim(kuf1_barcode.ki_causale_non_trattare ) + "' " &
	 	+ " group by barcode.id_meca  " &
	 		+ " ,barcode.id_armo  " &
	 		+ " ,arsp.id_sped " 

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

private subroutine db_crea_view_completa () throws uo_exception;//
//--- Crea View con elenco Trattati da Spedire
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
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_elenco_l "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
			 + " ( id_meca, num_int, data_int,  " &
			       + " clie_1,  " &
	                          + " rag_soc_1 , " &
	                          + " clie_2 , " &
	                          + " rag_soc_2 , " &
	                          + " clie_3 , " &
	                          + " num_bolla_in, " & 
	                          + " consegna_data, " & 
	                          + " data_stampa_certif, " &
	                          + " num_certif, " &
	                          + " anno , " &
	                          + " mese ,  " &
	                          + " giorno,  " &
	                          + " pedane, " &
	                          + " colli_entrati, " &
	                          + " colli_trattati, " &
	                          + " colli_groupage, " &
	                          + " colli_daNonTrattare, " &
	                          + " colli_sped " &
	                          + " ,num_bolla_out " &
	                          + " ,data_bolla_out " &
	                          + " ,id_sped " &
	                          + " ,art " &
							       + " ,alt_1 " & 	
									 + " ,e1doco " &
									 + " ,e1rorn " &
	 + " ) AS   " &
	 + "  SELECT distinct  " &
	                          + " meca.id, " &
	                          + " meca.num_int,  " &
	                          + " meca.data_int, " &
	                          + " meca.clie_1, " &
	                          + " clienti_1.rag_soc_10 , " &
	                          + " sped.clie_2, " &
	                          + " clienti_2.rag_soc_10 , " &
	                          + " meca.clie_3, " &
	                          + " meca.num_bolla_in, " &
	                          + " meca.consegna_data, " &
	                          + " Trattati.data_stampa, " &
	                          + " Trattati.num_certif, " &
	                          + " Year(meca.data_int) , " &
	                          + " Month(meca.data_int) ,  " &
	                          + " day (meca.data_int),  " &
	                          + " (colli_in.pedane),  " &
	                          + " (colli_in.colli_2), " &
	                          + " (coalesce(Trattati.colli_trattati,0)), " &
	                          + " (coalesce(Trattati.colli_groupage,0)), " &
	                          + " (coalesce(daNonTrattare.colli_daNonTrattare,0)), " &
	                          + " (coalesce(arsp.colli_sped,0)) " &
	                          + " ,arsp.num_bolla_out " &
	                          + " ,arsp.data_bolla_out " &
	                          + " ,arsp.id_sped " &
	                          + " ,colli_in.art " &
	                          + " ,colli_in.alt_1 " &
									 + " ,e1doco " &
									 + " ,e1rorn " &
	 + "  FROM (((((((( vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo as arsp_armo  " &
	                             + " INNER JOIN vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_colli_in as colli_in   ON ( arsp_armo.id_armo =  colli_in.id_armo)) " &
	                             + " INNER JOIN vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_Spediti as arsp   ON ( arsp_armo.id_armo =  arsp.id_armo)) " &
	                             + " LEFT JOIN vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_Trattati as Trattati ON  arsp_armo.id_armo = Trattati.id_armo) " &
	                             + " LEFT JOIN vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_daNonTrattare as daNonTrattare ON  arsp_armo.id_armo = daNonTrattare.id_armo)" &
	                             + " INNER JOIN meca ON colli_in.id_meca =  meca.id)  " &
	                             + " INNER JOIN sped ON arsp.id_sped =  sped.id_sped)  " &
	                             + " INNER JOIN  clienti AS  clienti_1 ON  meca.clie_1 =  clienti_1.codice)  " &
	                             + " INNER JOIN  clienti AS  clienti_2 ON  sped.clie_2 =  clienti_2.codice) " 

//	 + "  FROM ((((((((( vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo as arsp_armo  INNER JOIN  armo ON ( arsp_armo.id_armo =  armo.id_armo)) " &
//	 + "  group by " &
//	                          + " meca.id " &
//	                          + " ,meca.num_int  " &
//	                          + " ,meca.data_int " &
//	                          + " ,meca.clie_1 " &
//	                          + " ,clienti_1.rag_soc_10 " &
//	                          + " ,sped.clie_2 " &
//	                          + " ,clienti_2.rag_soc_10 " &
//	                          + " ,meca.clie_3 " &
//	                          + " ,meca.num_bolla_in " &
//	                          + " ,meca.consegna_data " &
//	                          + " ,Trattati.data_stampa " &
//	                          + " ,Trattati.num_certif "  &
//	                          + " ,arsp.num_bolla_out " &
//	                          + " ,arsp.data_bolla_out " & 
//	                          + " ,arsp.id_sped " & 
//	                          + " ,armo.art " 
	 
//	 + "  WHERE "  &
//	 + "          sped.id_arsp  in   (" +  " select distinct id_arsp from vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo" + ") "  &
	 
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

private subroutine db_crea_view_entrati () throws uo_exception;//
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


//--- costruisco la view 
	k_view = "vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_colli_in "
	k_sql = &
		"CREATE VIEW " + trim(k_view) &
		 + " ( id_meca, id_armo, colli_2, pedane, alt_1, art ) AS   " &
		 + "  SELECT armo.id_meca, armo.id_armo, sum(armo.colli_2), sum(armo.pedane), armo.alt_1, armo.art " 
	k_sql  += "    FROM armo   " &
		 + "   WHERE  " &
	     + "          armo.id_armo  in   (" +  " select distinct id_armo from vx_" + trim(kguo_utente.get_comp()) + "_merce_sped_id_armo" + ") "  
	k_sql  += "  group by " &
		 + "  armo.id_meca, armo.id_armo, armo.alt_1, armo.art " 
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

event constructor;//
kids_report_merce_sped = create datastore
kids_report_merce_sped.dataobject = "d_report_11_sped"
kids_report_merce_sped.settransobject(sqlca)

end event

on kuf_report_merce_sped.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_report_merce_sped.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if not isnull(kids_report_merce_sped) then destroy kids_report_merce_sped




end event

