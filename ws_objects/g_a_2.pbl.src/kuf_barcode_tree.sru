$PBExportHeader$kuf_barcode_tree.sru
forward
global type kuf_barcode_tree from kuf_parent
end type
end forward

global type kuf_barcode_tree from kuf_parent
end type
global kuf_barcode_tree kuf_barcode_tree

type variables
//--- causali
public constant string ki_causale_non_trattare="T"

//--- variabile di stato campo errore
public constant string ki_err_lav_fin_ko ="1"
public constant string ki_err_lav_fin_ok ="0"

//--- id streamer della stampa etichette
public long ki_id_print_etichette=0 
public boolean ki_stampa_etichetta_autorizza = false

//--- contatore etichette nella pagina (probabile al max 2 o 4)
private int ki_num_etichetta_in_pag=0 
st_tab_barcode kist_tab_barcode_stampa_save

//--- Datasore elenco Figli del Barcode
public string ki_ds_barcode_figli_elenco = "ds_barcode_figli_elenco"

//--- Datawindow elenco Figli e Padri potenziali
public constant string kk_dw_nome_barcode_l_padri_potenziali = "d_barcode_l_padri"  
public constant string kk_dw_nome_barcode_l_figli_potenziali = "d_barcode_l_figli_potenziali"  

//--- Flag Groupage
public constant string ki_barcode_groupage_SI = "S"
public constant string ki_barcode_groupage_NO = "N"

st_tab_barcode kist_tab_barcode
DECLARE kicursor_barcode_1 CURSOR FOR 
                SELECT barcode.barcode
					       ,barcode.pl_barcode
						FROM barcode
					   where 
							  barcode.barcode = :kist_tab_barcode.barcode 
							   or 
							  (
							   :kist_tab_barcode.barcode = '*'
								    and (:kist_tab_barcode.pl_barcode = 0
								         or barcode.pl_barcode = :kist_tab_barcode.pl_barcode 
								         or barcode.pl_barcode is null
											or barcode.pl_barcode = 0)
								  and barcode.num_int = :kist_tab_barcode.num_int
								  and barcode.data_int = :kist_tab_barcode.data_int 
								  and (barcode.fila_1 = :kist_tab_barcode.fila_1
								   or (barcode.fila_1 is null and :kist_tab_barcode.fila_1 = 999))
								  and (barcode.fila_1p = :kist_tab_barcode.fila_1p
								   or (barcode.fila_1p is null and :kist_tab_barcode.fila_1p = 999))
								  and (barcode.fila_2 = :kist_tab_barcode.fila_2
								   or (barcode.fila_2 is null and :kist_tab_barcode.fila_2 = 999))
								  and (barcode.fila_2p = :kist_tab_barcode.fila_2p
								   or (barcode.fila_2p is null and :kist_tab_barcode.fila_2p = 999))
								) ; 

//--- estrazione dei barcode non lavorati e in pl_barcode specifico
 declare kicursor_barcode_2 cursor for
   SELECT 
         barcode.data_int,   
         barcode.num_int,   
         barcode.tipo_cicli,   
         barcode.fila_1,   
         barcode.fila_2,   
         barcode.fila_1p,   
         barcode.fila_2p   
    FROM barcode 
   WHERE barcode.num_int = :kist_tab_barcode.num_int 
         and barcode.data_int >= :kist_tab_barcode.data_int  
		  and ((barcode.pl_barcode = 0 or barcode.pl_barcode is null) 
			 or (:kist_tab_barcode.pl_barcode > 0 
			     and barcode.pl_barcode = :kist_tab_barcode.pl_barcode)) 
		  and (barcode.barcode_lav is null or barcode.barcode_lav = '')
		  and barcode.data_stampa > 0 
		  and (barcode.data_sosp <= convert(date,'01.01.1900') or barcode.data_sosp is null)  ;
		  
		  
	

end variables

forward prototypes
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito anteprima_elenco_figli (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito anteprima_groupage_lotto (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview_x_rifer (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_da_stamp (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_data (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
end prototypes

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "100"

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive barcode 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
//		kst_esito.esito = kkg_esito.db_ko 
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut:  
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "100"

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
//		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco Barcode x Lotto)
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if (kst_tab_barcode.id_meca) > 0 then

		kdw_anteprima.dataobject = "d_barcode_l_2"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.id_meca)

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
//		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco_figli (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco Figli Barcode)
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode_l_figli"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
//		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_groupage_lotto (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima (Groupage Barcode x Lotto)
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.not_fnd

else

	if kst_tab_barcode.id_meca > 0 then

		kdw_anteprima.dataobject = "d_barcode_grp_x_lotto"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve( kst_tab_barcode.id_meca)

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Groupage Barcode da visualizzare: ~n~r" + "nessun id Lotto indicato"
//		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_nonno
integer k_ctr, k_pictureindex
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_stato_barcode="", k_tipo_oggetto_figlio, k_tipo_oggetto_padre, k_stato_magazzino
string k_tipo_oggetto_nonno, k_barcode=""
string k_query_select, k_query_where, k_query_order
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_tab_treeview kst_tab_treeview
st_tab_barcode kst_tab_barcode
st_treeview_data kst_treeview_data, kst_treeview_data_attuale
st_treeview_data_any kst_treeview_data_any
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo




k_query_select = &
			"	SELECT " + &
			"      barcode.barcode,    " + &
			"      barcode.flg_dosimetro,    " + &
			"     barcode.causale, " + &
			"     barcode.barcode_lav, " + &
			"	barcode.data,           " + &
			"	barcode.pl_barcode,     " + &
			"     barcode.num_int,     " + &
			"     barcode.data_int,    " + &
			"     barcode.data_stampa, " + &
			" barcode.data_lav_ini,	   " + &
			" barcode.data_lav_fin,	   " + &
			" barcode.data_lav_ok,	   " + &
			" barcode.data_sosp,"       + &
			" barcode.groupage, "       + &
			"  meca.clie_2, 	  "       + &
			"  meca.clie_3, 	  "       + &
			"	meca.num_bolla_in,    " + &
			"	meca.data_bolla_in,	 " + &
			"	meca.contratto,		 " + &
			"	contratti.mc_co,		 " + &
			"	contratti.sc_cf,      " + &
			"		contratti.descr,   " + &
			"      c2.rag_soc_10,	 " + &
			"      c3.rag_soc_10,	 " + &
			"		armo.magazzino,			 " + &
			"		armo.dose,			 " + &
			"		armo.larg_2,       " + &
			"		armo.lung_2,		 " + &
			"		armo.alt_2,			 " + &
			"		armo.peso_kg,		 " + &
			"		sl_pt.cod_sl_pt,   " + &
			"		sl_pt.descr,		 " + &
			"		barcode.fila_1,	 " + &
			"		barcode.fila_2,	 " + &
			"		barcode.fila_1p,   " + &
			"		barcode.fila_2p,	 " + &
			"		sl_pt.densita,		 " + &
			"		pl_barcode.data,	 " + &
			"		pl_barcode.note_1,     " + &
			"		pl_barcode.note_2,	  " + &
			"		pl_barcode.data_sosp,  " + &
			"		pl_barcode.data_chiuso " + &
			"    FROM (((((((barcode LEFT OUTER JOIN meca ON  " + &
			"	       barcode.id_meca = meca.id)			  " + &
			"			 INNER JOIN clienti c2 ON 			  " + &
			"			 meca.clie_2 = c2.codice)					  " + &
			"			 INNER JOIN clienti c3 ON         " + &
			"			 meca.clie_3 = c3.codice)					" + &
			"			 LEFT OUTER JOIN contratti ON 			" + &
			"			 meca.contratto = contratti.codice)		" + &
			"			 INNER JOIN armo ON               " + &
			"			 barcode.id_armo = armo.id_armo)			" + &
			"			 LEFT OUTER JOIN sl_pt ON               " + &
			"			 armo.cod_sl_pt = sl_pt.cod_sl_pt)		 "  + &
			"			 LEFT OUTER JOIN pl_barcode ON		 	" + &
			"			 barcode.pl_barcode = pl_barcode.codice) "
			 
			 
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.barcode_mese &
				 ,kuf1_treeview.kist_treeview_oggetto.barcode_tutti_dett
				k_query_where = " where " 
				if k_data_a  <> k_data_da then
					k_query_where = k_query_where &
					+ " (barcode.data between ? and ?) "
				else
					k_query_where = k_query_where &
					+ " (barcode.data = ?) "
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_armo
				k_query_where = " where " 
				k_query_where = k_query_where &
					+ " (barcode.id_armo = ?) " 
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_bc_dett
				k_query_where = " where " 
				k_query_where = k_query_where &
					+ " (barcode.id_meca = ?) "
					
			case else
				k_query_where = " where " 
				k_query_where = k_query_where &
				  + " (barcode.num_int = ? and barcode.data_int = ?) " 
	
		end choose
	


		k_query_order = &
				+ "	 order by  " &
				+ " barcode.data desc, barcode "


					
	kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
	if k_label <> "Barcode" then 
  		
//		kuf1_treeview.kilv_lv1.DeleteColumns ( )
//		kuf1_treeview.kilv_lv1.addColumn("Barcode" , left!, kuf1_treeview.kilv_lv1.width*0.10)
//		kuf1_treeview.kilv_lv1.addColumn("Stato" , left!, kuf1_treeview.kilv_lv1.width*0.06)
//		kuf1_treeview.kilv_lv1.addColumn("Dimensioni" , right!, kuf1_treeview.kilv_lv1.width*0.06)
//		kuf1_treeview.kilv_lv1.addColumn("Dose" , right!, kuf1_treeview.kilv_lv1.width*0.06)
//		kuf1_treeview.kilv_lv1.addColumn("Peso" , right!, kuf1_treeview.kilv_lv1.width*0.04)
//		kuf1_treeview.kilv_lv1.addColumn("F.1" , center!, kuf1_treeview.kilv_lv1.width*0.04)
//		kuf1_treeview.kilv_lv1.addColumn("F.2" , center!, kuf1_treeview.kilv_lv1.width*0.04)
//		kuf1_treeview.kilv_lv1.addColumn("Piano di Trattamento" , left!, kuf1_treeview.kilv_lv1.width*0.08)
//		kuf1_treeview.kilv_lv1.addColumn("Ulteriori Informazioni" , left!, kuf1_treeview.kilv_lv1.width*1.00)

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Barcode"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Magazzino"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dimensioni"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dose"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Peso"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "F.1"
			k_align[k_ind] = center!
			k_ind++
			k_campo[k_ind] = "F.2"
			k_align[k_ind] = center!
			k_ind++
			k_campo[k_ind] = "Piano di Trattamento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Riferimento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ulteriori Informazion"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"

				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop


	end if


		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)

	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_tipo_oggetto_padre = "ROOT"
		k_handle_item_nonno = 0
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
		k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		k_tipo_oggetto_nonno = kst_treeview_data.oggetto
	end if

	
//--- Periodo di estrazione		
	kst_treeview_data_any = kst_treeview_data.struttura
	k_mese = month(kst_treeview_data_any.st_tab_barcode.data) 
	k_anno = year(kst_treeview_data_any.st_tab_barcode.data) 
	k_data_da = date (k_anno, k_mese, 01) 
	if k_mese = 12 then
		k_mese = 1
		k_anno ++
	else
		k_mese = k_mese + 1
	end if
	k_data_a = date (k_anno, k_mese, 01) 


//--- controllo se sto richiedendo la stessa lista gia' a video
	k_rc = kuf1_treeview.kilv_lv1.getitem(1, 1, klvi_listviewitem) 
	if kuf1_treeview.kilv_lv1.getitem(1, 1, klvi_listviewitem) > 0 then
		kst_treeview_data_attuale = klvi_listviewitem.data 
		k_handle = kst_treeview_data_attuale.handle_padre

		if k_handle_item_nonno = k_handle then

//--- forzo l'uscita dall'elaborazione
			k_handle_item_corrente = 0

		else	
	
//--- cancello dalla listview tutto
			kuf1_treeview.kilv_lv1.DeleteItems()
		end if
	end if
	
	if k_handle_item_corrente > 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then

//--- item di ritorno di default
		if k_handle_item_padre > 0 then
			ktvi_treeviewitem.selected = false
			kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data.handle_padre = k_handle_item_corrente //k_handle_item_nonno
			kst_treeview_data.handle = k_handle_item_padre
			kst_treeview_data.oggetto = k_tipo_oggetto_padre
			kst_treeview_data.oggetto_padre = k_tipo_oggetto
			kst_treeview_data.oggetto_listview = k_tipo_oggetto
			ktvi_treeviewitem.data = kst_treeview_data
			klvi_listviewitem.label = ".."
			klvi_listviewitem.data = kst_treeview_data
			klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

		end if

//--- se tipo oggetto richiesto 'tutti i barcode' allora...
  		if k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.barcode_tutti_dett then

			kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- selezione item nella tree
			ktvi_treeviewitem.selected = true
			kuf1_treeview.kitv_tv1.setitem(k_handle_item_corrente, ktvi_treeviewitem)
			kuf1_treeview.kitv_tv1.selectitem(k_handle_item_corrente)
	
			kst_treeview_data = ktvi_treeviewitem.data
	
			kst_treeview_data_any = kst_treeview_data.struttura
	
			kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
			kst_tab_meca = kst_treeview_data_any.st_tab_meca 
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti 
			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt 
			kst_tab_armo = kst_treeview_data_any.st_tab_armo 
		end if

		
//--- imposto il pic corretto
		k_pictureindex = kuf1_treeview.u_dammi_pic_tree_list(k_tipo_oggetto)			

	
//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_listview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.barcode_mese &
				 ,kuf1_treeview.kist_treeview_oggetto.barcode_tutti_dett
				if k_data_a  <> k_data_da then
					open dynamic kc_listview using :k_data_da, :k_data_a;
				else
					open dynamic kc_listview using :k_data_da;
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_armo
				open dynamic kc_listview using :kst_tab_barcode.id_armo;
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_bc_dett 
				open dynamic kc_listview using :kst_tab_meca.id;
					
			case else
				open dynamic kc_listview using :kst_tab_barcode.num_int, :kst_tab_barcode.data_int;

		end choose
		
		if sqlca.sqlcode = 0 then
			
			kuf1_barcode = create kuf_barcode
			
			fetch kc_listview 
				into
					  :kst_tab_barcode.barcode
					 ,:kst_tab_barcode.flg_dosimetro 
					 ,:kst_tab_barcode.causale
					 ,:kst_tab_barcode.barcode_lav
					 ,:kst_tab_barcode.data
					 ,:kst_tab_barcode.pl_barcode 
					 ,:kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_barcode.data_stampa   
					 ,:kst_tab_barcode.data_lav_ini 
					 ,:kst_tab_barcode.data_lav_fin 
					 ,:kst_tab_barcode.data_lav_ok 
					 ,:kst_tab_barcode.data_sosp 
					 ,:kst_tab_barcode.groupage
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_armo.magazzino
					 ,:kst_tab_armo.dose 
					 ,:kst_tab_armo.larg_2
					 ,:kst_tab_armo.lung_2
					 ,:kst_tab_armo.alt_2
					 ,:kst_tab_armo.peso_kg
					 ,:kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.fila_1 
					 ,:kst_tab_sl_pt.fila_2 
					 ,:kst_tab_sl_pt.fila_1p 
					 ,:kst_tab_sl_pt.fila_2p 
					 ,:kst_tab_sl_pt.densita
					 ,:kst_tab_pl_barcode.data
					 ,:kst_tab_pl_barcode.note_1
					 ,:kst_tab_pl_barcode.note_2
					 ,:kst_tab_pl_barcode.data_sosp
					 ,:kst_tab_pl_barcode.data_chiuso
					  ;
	
	
			
			do while sqlca.sqlcode = 0
				
				kuf1_barcode.if_isnull(kst_tab_barcode)
				
				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_sl_pt = kst_tab_sl_pt
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data.struttura = kst_treeview_data_any

			     klvi_listviewitem.data = kst_treeview_data

				klvi_listviewitem.pictureindex = k_pictureindex
//				klvi_listviewitem.pictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_dett_pic_list)
//				kuf1_treeview.kilv_lv1.SmallPictureMaskColor = RGB(255, 255, 0)
			   
				klvi_listviewitem.selected = false
				
				k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

				if isnull(kst_tab_meca.clie_3) then	kst_tab_meca.clie_3 = 0
				if isnull(kst_tab_meca.clie_2) then	kst_tab_meca.clie_2 = 0
				if isnull(kst_tab_meca.num_bolla_in) then kst_tab_meca.num_bolla_in = " "
				if isnull(kst_tab_meca.data_bolla_in) then kst_tab_meca.data_bolla_in = date(0)
				if isnull(kst_tab_clienti.rag_soc_20) then	kst_tab_clienti.rag_soc_20 = " "
				if isnull(kst_tab_clienti.rag_soc_10) then	kst_tab_clienti.rag_soc_10 = " "

				if kst_tab_barcode.flg_dosimetro = kuf1_barcode.ki_flg_dosimetro_si then
					k_barcode = "* " + mid(trim(kst_tab_barcode.barcode), 4)
				else
					k_barcode = mid(trim(kst_tab_barcode.barcode), 4)
				end if
				if len(trim(kst_tab_barcode.barcode_lav)) > 0 then
					k_barcode += " (" + left(trim(kst_tab_barcode.barcode), 3) + ")  "  + "->" + trim(kst_tab_barcode.barcode_lav)
				else
					k_barcode += " (" + left(trim(kst_tab_barcode.barcode), 3) + ") " 
				end if
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 1, k_barcode)
				

				if kst_tab_barcode.groupage = "S" then
					k_stato_barcode = "In Groupage "
					if len(trim(kst_tab_barcode.barcode_lav)) > 0 then
						k_stato_barcode += "(figlio di:" +  trim(kst_tab_barcode.barcode_lav) + "),  "
					end if
				else
					k_stato_barcode = " "  
				end if
				if kst_tab_barcode.pl_barcode > 0 then
					if isnull(kst_tab_pl_barcode.data) then kst_tab_pl_barcode.data = date(0)
					if isnull(kst_tab_pl_barcode.note_1) then kst_tab_pl_barcode.note_1 = " "
					if isnull(kst_tab_pl_barcode.note_2) then kst_tab_pl_barcode.note_2 = " "
					k_stato_barcode += "p.l.:"  &
											 + " " + string(kst_tab_barcode.pl_barcode, "#####") &
											 + " del " + string(kst_tab_pl_barcode.data, "dd.mm.yy") &
											 + " " + trim(kst_tab_pl_barcode.note_1) &
											 + " " + trim(kst_tab_pl_barcode.note_2) &
										    + " *  " + trim(k_stato_barcode) + ",  "
				end if
				if kst_tab_barcode.causale = ki_causale_non_trattare then
					k_stato_barcode +=  "da NON Trattare"
				else
					if kst_tab_barcode.data_stampa >= date(0) then
						k_stato_barcode +=  "Stampato il " + string(kst_tab_barcode.data_stampa, "dd.mm.yy") + "  "
					else
						k_stato_barcode +=  "da stampare"
					end if
					if kst_tab_barcode.data_lav_ini > date(0) then
						k_stato_barcode = "Inizio lav. il " + string(kst_tab_barcode.data_lav_ini, "dd.mm.yy") + " * " + trim(k_stato_barcode)
					 end if
					if kst_tab_barcode.data_lav_fin > date(0) then
						k_stato_barcode = "Fine lav. il " + string(kst_tab_barcode.data_lav_fin, "dd.mm.yy") + " * " + trim(k_stato_barcode)
					end if
					if kst_tab_barcode.data_lav_ok > date(0) then
						k_stato_barcode = "Convalidato il " + string(kst_tab_barcode.data_lav_ok, "dd.mm.yy") + " * " + trim(k_stato_barcode)
					end if
					if kst_tab_barcode.data_sosp > date(0)  then
						k_stato_barcode = "Sospeso il " + string(kst_tab_barcode.data_sosp, "dd.mm.yy") + " * " + trim(k_stato_barcode)
					end if
				end if
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 2, k_stato_barcode)

				choose case kst_tab_armo.magazzino
					case kuf1_armo.kki_magazzino_DATRATTARE
						k_stato_magazzino =  "di Trattamento"
					case kuf1_armo.kki_magazzino_DP
						k_stato_magazzino =  "C.to Deposito"
					case kuf1_armo.kki_magazzino_RD
						k_stato_magazzino =  "Studio & Sviluppo"
				end choose
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 3, k_stato_magazzino)

				if isnull(kst_tab_armo.alt_2) then kst_tab_armo.alt_2 = 0
				if isnull(kst_tab_armo.lung_2) then kst_tab_armo.lung_2 = 0
				if isnull(kst_tab_armo.larg_2) then kst_tab_armo.larg_2 = 0
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.alt_2, "###0") &
				                  + "x" + string(kst_tab_armo.lung_2, "###0")  &
				                  + "x" + string(kst_tab_armo.larg_2, "###0"))
				
				if isnull(kst_tab_armo.dose) then kst_tab_armo.dose = 0
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.dose, "#,##0.00"))
				if isnull(kst_tab_armo.peso_kg) then kst_tab_armo.peso_kg = 0
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.peso_kg, "##,##0.00"))

				if isnull(kst_tab_sl_pt.fila_1) then kst_tab_sl_pt.fila_1 = 0
				if isnull(kst_tab_sl_pt.fila_1p) then kst_tab_sl_pt.fila_1p = 0
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 7, string(kst_tab_sl_pt.fila_1, "##0") + " - " &
			                          + string(kst_tab_sl_pt.fila_1p, "##0"))

				if isnull(kst_tab_sl_pt.fila_2) then kst_tab_sl_pt.fila_2 = 0
				if isnull(kst_tab_sl_pt.fila_2p) then kst_tab_sl_pt.fila_2p = 0
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 8, string(kst_tab_sl_pt.fila_2, "##0") + " - " &
			                          + string(kst_tab_sl_pt.fila_2p, "##0"))
				
				if len(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
					if isnull(kst_tab_sl_pt.descr) then kst_tab_sl_pt.descr = " "
					kuf1_treeview.kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_sl_pt.cod_sl_pt) &
										 + " " + trim(kst_tab_sl_pt.descr))
				else
					kuf1_treeview.kilv_lv1.setitem(k_ctr, 9, "---")
				end if

				kuf1_treeview.kilv_lv1.setitem(k_ctr, 10, string(kst_tab_barcode.data_int , "dd/mm/yy") + string(kst_tab_barcode.num_int , "  ####0"))
				
				if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0
				if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = "NO   "
				if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = "NO   "
				if isnull(kst_tab_contratti.descr) then	kst_tab_contratti.descr = " "
				
				if kst_tab_meca.clie_3 <> kst_tab_meca.clie_2 then
					
					kuf1_treeview.kilv_lv1.setitem(k_ctr, 11, &
										   "cap.: " + trim(kst_tab_contratti.sc_cf) &
										 + "  comm.: " + trim(kst_tab_contratti.mc_co) &
										 + "  cliente: " + string(kst_tab_meca.clie_3, "#####") &
										 + " " + trim(kst_tab_clienti.rag_soc_20) &
										 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
										 + " " + trim(kst_tab_clienti.rag_soc_10) &
										 + "  bolla: "  + trim(kst_tab_meca.num_bolla_in) &
										 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") &
										 + "  contratto: " + string(kst_tab_contratti.codice, "#####") & 
										 + "  " + trim(kst_tab_contratti.descr) )
				else
					kuf1_treeview.kilv_lv1.setitem(k_ctr, 11, &
										   "cap.: " + trim(kst_tab_contratti.sc_cf) &
										 + "  comm.: " + trim(kst_tab_contratti.mc_co) &
										 + "  cliente: " + string(kst_tab_meca.clie_3, "#####") &
										 + " " + trim(kst_tab_clienti.rag_soc_20) &
										 + "  bolla: "  + trim(kst_tab_meca.num_bolla_in) &
										 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") &
										 + "  contratto: " + string(kst_tab_contratti.codice, "#####") & 
										 + "  " + trim(kst_tab_contratti.descr) )
				end if
				

				fetch kc_listview 
					into
					  :kst_tab_barcode.barcode
					 ,:kst_tab_barcode.flg_dosimetro  
					 ,:kst_tab_barcode.causale
					 ,:kst_tab_barcode.barcode_lav
					 ,:kst_tab_barcode.data
					 ,:kst_tab_barcode.pl_barcode 
					 ,:kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_barcode.data_stampa   
					 ,:kst_tab_barcode.data_lav_ini 
					 ,:kst_tab_barcode.data_lav_fin 
					 ,:kst_tab_barcode.data_lav_ok 
					 ,:kst_tab_barcode.data_sosp 
					 ,:kst_tab_barcode.groupage
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_armo.magazzino		
					 ,:kst_tab_armo.dose 
					 ,:kst_tab_armo.larg_2
					 ,:kst_tab_armo.lung_2
					 ,:kst_tab_armo.alt_2
					 ,:kst_tab_armo.peso_kg
					 ,:kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.fila_1 
					 ,:kst_tab_sl_pt.fila_2 
					 ,:kst_tab_sl_pt.fila_1p 
					 ,:kst_tab_sl_pt.fila_2p 
					 ,:kst_tab_sl_pt.densita
					 ,:kst_tab_pl_barcode.data
					 ,:kst_tab_pl_barcode.note_1
					 ,:kst_tab_pl_barcode.note_2
					 ,:kst_tab_pl_barcode.data_sosp
					 ,:kst_tab_pl_barcode.data_chiuso
					  ;
	
	
			loop
			
			destroy kuf1_barcode			
			
			close kc_listview;
		end if
		
		
	end if	
 
 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

end function

public function integer u_tree_riempi_listview_x_rifer (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_nonno, k_riga_item
long k_handle_item_rit
integer k_pictureindex, k_pic_list, k_ctr
string k_label, k_stringa, k_tipo_oggetto_figlio, k_tipo_oggetto_padre, k_tipo_oggetto_nonno, k_stato_magazzino
integer k_ind
string k_campo[16]
alignment k_align[16]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_treeview_data kst_treeview_data
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini
kuf_armo kuf1_armo


		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- ricavo il tipo oggetto 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)

	end if
		
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then	
	
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
//--- ricavo il nonno	
	if k_handle_item_padre > 0 then
		k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		k_tipo_oggetto_nonno = kst_treeview_data.oggetto
	else
		k_handle_item_nonno = 0
		k_tipo_oggetto_nonno = "ROOT"
	end if
	
//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 

	if k_handle_item_padre > 0 then
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.handle_padre = k_handle_item_nonno
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_nonno
		kst_treeview_data.oggetto_padre = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		k_handle_item_rit = k_ctr
	end if
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  


		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
  		
//--- Costruisce e Dimensiona le colonne all'interno della listview
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> "Riferimento." then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Riferimento."
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Area"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "DDT mittente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Cliente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "PKL"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Colli"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Stato barcode"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Magazzino"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dimensioni"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Dose"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "Peso"
			k_align[k_ind] = right!
			k_ind++
			k_campo[k_ind] = "F.1"
			k_align[k_ind] = center!
			k_ind++
			k_campo[k_ind] = "F.2"
			k_align[k_ind] = center!
			k_ind++
			k_campo[k_ind] = "Piano di Trattamento"
			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Ulteriori Informazion"
//			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"
	
				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop
		end if

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			k_pic_list = kst_treeview_data.pic_list

			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_barcode = kst_treeview_data_any.st_tab_barcode 
			kst_tab_meca = kst_treeview_data_any.st_tab_meca 
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti 
			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt 
			kst_tab_armo = kst_treeview_data_any.st_tab_armo 
			kst_tab_contratti = kst_treeview_data_any.st_tab_contratti
			kst_tab_pl_barcode = kst_treeview_data_any.st_tab_pl_barcode

			klvi_listviewitem.pictureindex = k_pic_list

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			if isnull(kst_treeview_data_any.contati) then kst_treeview_data_any.contati=0
			
			if isnull(kst_tab_barcode.pl_barcode) then
				kst_tab_barcode.pl_barcode = 0
			end if
			if isnull(kst_tab_pl_barcode.data) then
				kst_tab_pl_barcode.data = date(0)
			end if
			if isnull(kst_tab_pl_barcode.note_1) then
				kst_tab_pl_barcode.note_1 = " "
			end if
			if isnull(kst_tab_pl_barcode.note_2) then
				kst_tab_pl_barcode.note_2 = " "
			end if
			if isnull(kst_tab_meca.clie_3) then
				kst_tab_meca.clie_3 = 0
			end if
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.clie_1) then
				kst_tab_meca.clie_1 = 0
			end if
			if isnull(kst_tab_clienti.rag_soc_20) then
				kst_tab_clienti.rag_soc_20 = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_11) then
				kst_tab_clienti.rag_soc_11 = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
			if isnull(kst_tab_meca.num_bolla_in) then
				kst_tab_meca.num_bolla_in = " "
			end if
			if isnull(kst_tab_meca.data_bolla_in) then
				kst_tab_meca.data_bolla_in = date(0)
			end if

			k_riga_item = 1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_barcode.num_int, "####0") &
								  + " - " + string(kst_tab_barcode.data_int, "dd.mm.yy"))

			k_riga_item ++
			k_stringa =	trim(kst_tab_meca.area_mag)
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, k_stringa) 

			k_riga_item ++
			k_stringa = trim(kst_tab_meca.num_bolla_in) + " " + string(kst_tab_meca.data_bolla_in, "dd mmm") 
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, k_stringa) 
			
			k_riga_item ++
			k_stringa =	trim(kst_tab_clienti.rag_soc_20) &
							+ " (" + string(kst_tab_meca.clie_3) + ") " 
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, k_stringa) 
					
			k_riga_item ++		
			if kst_tab_meca.id_wm_pklist > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "Si") 
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "NO")
			end if
								  
			k_riga_item ++		
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_treeview_data_any.contati))
				
			k_riga_item ++		
			if kst_tab_barcode.data_stampa > date(0) then
				if kst_tab_barcode.pl_barcode > 0 then
					if kst_tab_barcode.data_lav_fin > date(0) then
						kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "trattato il "  &
										 + string(kst_tab_barcode.data_lav_fin, "dd mmm") )
					else
						if kst_tab_barcode.data_lav_ini > date(0) then
							kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "in lavoraz.dal "  &
										 + string(kst_tab_barcode.data_lav_ini, "dd mmm") )
						else
							kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "pianificato ("  &
										 + " " + string(kst_tab_barcode.pl_barcode, "####0") + ")")
						end if
					end if
//										 + " " + trim(kst_tab_pl_barcode.note_1) &
//										 + " " + trim(kst_tab_pl_barcode.note_2)) 
				else
					
					choose case kst_tab_armo.magazzino
						case kuf1_armo.kki_magazzino_DATRATTARE
							kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "da pianificare")
						case kuf1_armo.kki_magazzino_DP
							kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "stampati")
						case kuf1_armo.kki_magazzino_RD
							kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "iter R&S attivo")
							k_stato_magazzino = "Studio & Sviluppo"
					end choose
				end if
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "da stampare")
			end if

			choose case kst_tab_armo.magazzino
				case kuf1_armo.kki_magazzino_DATRATTARE
						k_stato_magazzino = "di Trattamento"
				case kuf1_armo.kki_magazzino_DP
					k_stato_magazzino = "C.to Deposito"
				case kuf1_armo.kki_magazzino_RD
					k_stato_magazzino = "Studio & Sviluppo"
			end choose
			k_riga_item ++		
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, k_stato_magazzino)

			if isnull(kst_tab_armo.alt_2) then kst_tab_armo.alt_2 = 0
			if isnull(kst_tab_armo.lung_2) then kst_tab_armo.lung_2 = 0
			if isnull(kst_tab_armo.larg_2) then kst_tab_armo.larg_2 = 0
			k_riga_item ++		
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_armo.alt_2, "###0") &
									+ "x" + string(kst_tab_armo.lung_2, "###0")  &
									+ "x" + string(kst_tab_armo.larg_2, "###0"))
			
			if isnull(kst_tab_armo.dose) then kst_tab_armo.dose = 0
			k_riga_item ++	
			if kst_tab_armo.dose > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_armo.dose, "#,##0.00"))
			end if
			
			if isnull(kst_tab_armo.peso_kg) then kst_tab_armo.peso_kg = 0
			k_riga_item ++		
			if kst_tab_armo.peso_kg > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_armo.peso_kg, "##,##0.00"))
			end if

			if isnull(kst_tab_sl_pt.fila_1) then kst_tab_sl_pt.fila_1 = 0
			if isnull(kst_tab_sl_pt.fila_1p) then kst_tab_sl_pt.fila_1p = 0
			k_riga_item ++		
			if kst_tab_sl_pt.fila_1 > 0 or kst_tab_sl_pt.fila_1p > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_sl_pt.fila_1, "##0") + " - " + string(kst_tab_sl_pt.fila_1p, "##0"))
			end if
											  
			if isnull(kst_tab_sl_pt.fila_2) then kst_tab_sl_pt.fila_2 = 0
			if isnull(kst_tab_sl_pt.fila_2p) then kst_tab_sl_pt.fila_2p = 0
			k_riga_item ++		
			if kst_tab_sl_pt.fila_2 > 0 or kst_tab_sl_pt.fila_2p > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, string(kst_tab_sl_pt.fila_2, "##0") + " - " + string(kst_tab_sl_pt.fila_2p, "##0"))
			end if
			
			k_riga_item ++		
			if trim(kst_tab_sl_pt.cod_sl_pt) > " " then
				if isnull(kst_tab_sl_pt.descr) then kst_tab_sl_pt.descr = " "
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, trim(kst_tab_sl_pt.cod_sl_pt) + "  " + trim(kst_tab_sl_pt.descr))
			else
				kst_tab_sl_pt.cod_sl_pt = ""
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, "---")
			end if

//			if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0
//			k_stringa = &
//						 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_11) 
//			if kst_tab_meca.clie_2 <> kst_tab_meca.clie_1 then
//				k_stringa += &
//							 + "  mand.: " + string(kst_tab_meca.clie_1, "#####") &
//							 + " " + trim(kst_tab_clienti.rag_soc_10) 
//			end if
//			k_stringa += "contratto: " + string(kst_tab_contratti.codice, "#####")  
//			k_riga_item ++		
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_riga_item, trim(k_stringa))
			
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
	
		loop

		 
		if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
			kuf1_treeview.kilv_lv1.DragAuto = True 
					
//--- Attivo multi-selezione delle righe 
			kuf1_treeview.kilv_lv1.extendedselect = true 
			
		end if
		
	end if

	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_tipo_oggetto_nonno // k_oggetto_padre
		kst_treeview_data.oggetto_padre = k_tipo_oggetto
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if



return k_return

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc 
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order, k_barcode_periodo
date k_save_data_int, k_data_da, k_data_a, k_data_0
kuf_armo kuf1_armo
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_barcode kst_tab_barcode
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti


	k_data_0 = date(0)
		 
	kuf1_armo = create kuf_armo
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if

//--- Periodo di estrazione		
	kst_treeview_data_any = kst_treeview_data.struttura
	k_mese = month(kst_treeview_data_any.st_tab_barcode.data) 
	k_anno = year(kst_treeview_data_any.st_tab_barcode.data) 
	k_data_da = date (k_anno, k_mese, 01) 
	if k_mese = 12 then
		k_mese = 1
		k_anno ++
	else
		k_mese = k_mese + 1
	end if
	k_data_a = date (k_anno, k_mese, 01) 

		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.selectedpictureindex  = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_close
		end if
		

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

//--- ricavo i dati dalla struttura gia' letta nel padre
		kst_tab_barcode.id_meca = kst_treeview_data_any.st_tab_meca.id
		kst_tab_pl_barcode =	kst_treeview_data_any.st_tab_pl_barcode 
			 
	
//			+ " count (*), " &
		k_query_select = &
			" SELECT  distinct " &
			+ " 	barcode.pl_barcode, " &
			+ "   meca.num_int,    " &
			+ "   meca.data_int,   " & 
			+ "     min(barcode.data_stampa), " &
			+ " 	min(barcode.data_lav_ini), " &
			+ " 	max(barcode.data_lav_fin), " &
			+ " 	min(barcode.data_lav_ok), " &
			+ "  barcode.data_sosp, " &
			+ "   meca.id,  " &
			+ "   meca.clie_1,  " &
			+ "   meca.clie_2,  " &
			+ "   meca.clie_3,  " &
			+ " 	meca.num_bolla_in, " &
			+ " 	meca.data_bolla_in, " &
			+ "   meca.area_mag,  " &
			+ "    meca.id_wm_pklist, " &
			+ " 	meca.contratto, " &
			+ "   c1.rag_soc_10, " &
			+ "   c2.rag_soc_10, " &
			+ "   c3.rag_soc_10, " &
			+ " 	armo.magazzino, " &
			+ " 	armo.dose, " &
			+ " 	max(armo.larg_2), " &
			+ " 	max(armo.lung_2), " &
			+ " 	max(armo.alt_2), " &
			+ " 	max(armo.peso_kg), " &
			+ " 	sl_pt.cod_sl_pt, " &
			+ " 	sl_pt.descr, " &
			+ " 	sl_pt.densita " &
			+ " FROM ((((((meca INNER JOIN barcode ON  " &
			+ "       meca.num_int = barcode.num_int and meca.data_int = barcode.data_int) " &
			+ " 	 INNER JOIN clienti c1 ON  " &
			+ " 	 meca.clie_1 = c1.codice) " &
			+ " 	 INNER JOIN clienti c2 ON  " &
			+ " 	 meca.clie_2 = c2.codice) " &
			+ " 	 INNER JOIN clienti c3 ON  " &
			+ " 	 meca.clie_3 = c3.codice) " &
			+ " 	 INNER JOIN armo ON  " &
			+ " 	 barcode.id_armo = armo.id_armo) " &
			+ " 	 LEFT OUTER JOIN sl_pt ON  " &
			+ " 	 armo.cod_sl_pt = sl_pt.cod_sl_pt) " &
			+ " " 

//			+ " 	 LEFT OUTER JOIN pl_barcode ON " &
//			+ " 	 barcode.pl_barcode = pl_barcode.codice) " &
//			+ " 	pl_barcode.data, " &
//			+ " 	pl_barcode.note_1, " &
//			+ " 	pl_barcode.note_2, " &
//			+ " 	pl_barcode.data_sosp, " &
//			+ " 	pl_barcode.data_chiuso " &
//			+ " 	contratti.mc_co, " &
//			+ " 	contratti.sc_cf, " &
//			+ " 	contratti.descr, " &
//			+ " 	 INNER JOIN contratti ON " & 
//			+ " 	 meca.contratto = contratti.codice) " &

//			+ " 	barcode.fila_1, " &
//			+ " 	barcode.fila_2, " &
//			+ " 	barcode.fila_1p, " &
//			+ " 	barcode.fila_2p, " &

			k_barcode_periodo = " meca.data_int >= '" + string(k_data_da) + "' and barcode.data_int < '" + string(k_data_a) + "' " 
 
				 
		choose case k_tipo_oggetto
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_tutti_dett
				k_query_where = " where " &
					+ k_barcode_periodo
				 
			case kuf1_treeview.kist_treeview_oggetto.barcode_no_st_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and (barcode.data_stampa <= '" + string(k_data_0) + "' or barcode.data_stampa is null) " &
					+ " and (barcode.causale <> 'T' or barcode.causale is null)" &
					+ " and (barcode.data_sosp <= '" + string(k_data_0) + "' or barcode.data_sosp is null) " &
					+ " and meca.stato = " + string(kuf1_armo.ki_meca_stato_blk_con_controllo) + " "  

 
			case kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_dett  //barcode stampati e da trattare
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and barcode.data_stampa >=  '" + string(k_data_0) + "' "  &
					+ " and (barcode.data_lav_ini <= '" + string(k_data_0) + "' " + " or barcode.data_lav_ini is null) "  &
					+ " and (barcode.pl_barcode = 0 or barcode.pl_barcode is null) "
//					+ " and (pl_barcode.data_chiuso <= '" + string(k_data_0) + "' " + " or pl_barcode.data_chiuso is null) " 
//					+ " and (barcode.data_lav_ini <= ? or barcode.data_lav_ini is null) " &
//					+ " and (barcode.data_lav_fin <= ?  or  barcode.data_lav_fin is null)  " &
//					+ " and (barcode.data_lav_ok <= ?  or  barcode.data_lav_ok is null) " & 
//					+ " and (barcode.data_sosp <= ?  or  barcode.data_sosp is null) "  
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_pl_chiuso_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and barcode.data_lav_ini >= '" + string(k_data_0) + "' " 
//					+ " and (barcode.data_lav_fin <= ?  or  barcode.data_lav_fin is null)  " &
//					+ " and (barcode.data_lav_ok <= ?  or  barcode.data_lav_ok is null) " & 
//					+ " and (barcode.data_sosp <= ?  or  barcode.data_sosp is null) "  
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_trattati_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and barcode.data_lav_fin >= '" + string(k_data_0) + "' " 
//					+ " and (barcode.data_lav_ok <= ?  or  barcode.data_lav_ok is null) " & 
//					+ " and (barcode.data_sosp <= ?  or  barcode.data_sosp is null) "  
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_ok_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and barcode.data_lav_ok >= '" + string(k_data_0) + "' " &
					+ " and (barcode.err_lav_ok = '2') "  
//					+ " and (barcode.data_sosp <= ?  or  barcode.data_sosp is null) " 
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_ko_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and barcode.data_lav_ok >= '" + string(k_data_0) + "' " &
					+ " and (barcode.err_lav_ok = '1') " 
//					+ " and (barcode.data_sosp <= ?  or  barcode.data_sosp is null) " 
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_sosp_dett
				k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and (barcode.data_sosp >= '" + string(k_data_0) + "' "  &
					+ " or meca.stato = '" + string(kuf1_armo.ki_meca_stato_blk_con_controllo) + "' "  & 
					+ " or barcode.causale = '" + ki_causale_non_trattare + "' ) "  
					
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_meca
				k_query_where = " where " &
					+ " barcode.pl_barcode  = " + string(kst_tab_pl_barcode.codice)
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_bc_dett
				k_query_where = " where " &
					+ " barcode.id_meca  = " + string(kst_tab_barcode.id_meca)
					
			case else
					k_query_where = " "
	
		end choose
	
//			+ "    barcode.data_stampa, " & 
//			+ " 	barcode.data_lav_ini, " & 
//			+ " 	barcode.data_lav_fin, " & 
//			+ " 	barcode.data_lav_ok, " & 
		k_query_order = " " &
			+ " group by " & 
			+ " 	barcode.pl_barcode, " & 
			+ "    meca.num_int,   " &  
			+ "    meca.data_int,   " &  
			+ " 	barcode.data_sosp, " & 
			+ "   meca.id,  " &
			+ "   meca.clie_1,  " & 
			+ "    meca.clie_2,  " & 
			+ "    meca.clie_3,  " & 
			+ " 	meca.num_bolla_in, " & 
			+ " 	meca.data_bolla_in, " & 
			+ "   meca.area_mag,  " &
			+ "    meca.id_wm_pklist, " &
			+ " 	meca.contratto, " & 
			+ "    c1.rag_soc_10, " & 
			+ "    c2.rag_soc_10, " & 
			+ "    c3.rag_soc_10, " & 
			+ " 	armo.magazzino, " & 
			+ " 	armo.dose, " & 
			+ " 	sl_pt.cod_sl_pt, " & 
			+ " 	sl_pt.descr, " & 
			+ " 	sl_pt.densita " & 
			+ " order by  " & 
			+ "  meca.data_int, meca.num_int " 
//			+ " 	pl_barcode.data, " & 
//			+ " 	pl_barcode.note_1, " & 
//			+ " 	pl_barcode.note_2, " & 
//			+ " 	pl_barcode.data_sosp, " & 
//			+ " 	pl_barcode.data_chiuso " & 
//			+ " 	contratti.mc_co, " & 
//			+ " 	contratti.sc_cf, " & 
//			+ " 	contratti.descr, " & 
	
//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.barcode_tutti_dett
				open dynamic kc_treeview; //using :k_data_da, :k_data_a;
				
			case kuf1_treeview.kist_treeview_oggetto.barcode_no_st_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0, :k_data_0, :k_data_0;

			case kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0, :k_data_0, :k_data_0, :k_data_0;

			case kuf1_treeview.kist_treeview_oggetto.barcode_pl_chiuso_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0, :k_data_0, :k_data_0;
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_trattati_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0, :k_data_0;
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_ok_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0;
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_ko_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0;
					
			case kuf1_treeview.kist_treeview_oggetto.barcode_sosp_dett
				open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0;
					
			case kuf1_treeview.kist_treeview_oggetto.pl_barcode_meca
				open dynamic kc_treeview; // using :kst_tab_pl_barcode.codice;
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_bc_dett
				open dynamic kc_treeview; // using :kst_tab_barcode.id_meca;
					
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode = 0 then
			
//					  :kst_treeview_data_any.contati 
			fetch kc_treeview 
				into
					 :kst_tab_barcode.pl_barcode 
					 ,:kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_barcode.data_stampa   
					 ,:kst_tab_barcode.data_lav_ini 
					 ,:kst_tab_barcode.data_lav_fin 
					 ,:kst_tab_barcode.data_lav_ok 
					 ,:kst_tab_barcode.data_sosp 
					 ,:kst_tab_meca.id  
					 ,:kst_tab_meca.clie_1  
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_meca.area_mag
					 ,:kst_tab_meca.id_wm_pklist
					 ,:kst_tab_contratti.codice
//					 ,:kst_tab_contratti.mc_co
//					 ,:kst_tab_contratti.sc_cf
//					 ,:kst_tab_contratti.descr
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_11 
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_armo.magazzino
					 ,:kst_tab_armo.dose 
					 ,:kst_tab_armo.larg_2
					 ,:kst_tab_armo.lung_2
					 ,:kst_tab_armo.alt_2
					 ,:kst_tab_armo.peso_kg
					 ,:kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
//					 ,:kst_tab_sl_pt.fila_1 
//					 ,:kst_tab_sl_pt.fila_2 
//					 ,:kst_tab_sl_pt.fila_1p 
//					 ,:kst_tab_sl_pt.fila_2p 
					 ,:kst_tab_sl_pt.densita
//					 ,:kst_tab_pl_barcode.data
//					 ,:kst_tab_pl_barcode.note_1
//					 ,:kst_tab_pl_barcode.note_2
//					 ,:kst_tab_pl_barcode.data_sosp
//					 ,:kst_tab_pl_barcode.data_chiuso
					  ;
	
//					 ,:kst_tab_barcode.data
			if sqlca.sqlcode = 0 then

				
				do while sqlca.sqlcode = 0 

					kst_tab_barcode.id_meca = kst_tab_meca.id 
					
					kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
					kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_sl_pt = kst_tab_sl_pt
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti

//--- conta i barcode del Riferimento
					select count(*)
						into  :kst_treeview_data_any.contati 
						from barcode
						where id_meca = :kst_tab_meca.id 
						using sqlca;
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_barcode.num_int, "####0") &
											  + " - " + string(kst_tab_barcode.data_int, "dd.mm.yyyy") &
											  + " "  &
											  +  &
											  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
											  + string(kst_tab_meca.clie_3, "#####") + ")"
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data.handle = k_handle_item_padre
					kst_treeview_data.pic_list = k_pic_list	
					
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
											  
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
	
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
	
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

					
					
	//	
	//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			
	
// 						 :kst_treeview_data_any.contati 
					fetch kc_treeview 
					into
						 :kst_tab_barcode.pl_barcode 
						 ,:kst_tab_barcode.num_int   
						 ,:kst_tab_barcode.data_int   
						 ,:kst_tab_barcode.data_stampa   
						 ,:kst_tab_barcode.data_lav_ini 
						 ,:kst_tab_barcode.data_lav_fin 
						 ,:kst_tab_barcode.data_lav_ok 
						 ,:kst_tab_barcode.data_sosp 
						 ,:kst_tab_meca.id  
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.area_mag
						 ,:kst_tab_meca.id_wm_pklist
						 ,:kst_tab_contratti.codice
//						 ,:kst_tab_contratti.mc_co
//						 ,:kst_tab_contratti.sc_cf
//						 ,:kst_tab_contratti.descr
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_clienti.rag_soc_11  
						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_armo.magazzino
						 ,:kst_tab_armo.dose 
						 ,:kst_tab_armo.larg_2
						 ,:kst_tab_armo.lung_2
						 ,:kst_tab_armo.alt_2
						 ,:kst_tab_armo.peso_kg
						 ,:kst_tab_sl_pt.cod_sl_pt 
						 ,:kst_tab_sl_pt.descr 
//						 ,:kst_tab_sl_pt.fila_1 
//						 ,:kst_tab_sl_pt.fila_2 
//						 ,:kst_tab_sl_pt.fila_1p 
//						 ,:kst_tab_sl_pt.fila_2p 
						 ,:kst_tab_sl_pt.densita
//						 ,:kst_tab_pl_barcode.data
//						 ,:kst_tab_pl_barcode.note_1
//						 ,:kst_tab_pl_barcode.note_2
//						 ,:kst_tab_pl_barcode.data_sosp
//						 ,:kst_tab_pl_barcode.data_chiuso
						 ;
		
				loop
				
			end if
			
			close kc_treeview;
		end if

	end if 

	destroy kuf1_armo
 
return k_return

end function

public function integer u_tree_riempi_treeview_da_stamp (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order, k_barcode_periodo
date k_save_data_int, k_data_da, k_data_a, k_data_0
treeviewitem ktvi_treeviewitem
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_barcode kst_tab_barcode
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti


	k_data_0 = date(0)
		 
	kuf1_armo = create kuf_armo
	kuf1_barcode = create kuf_barcode
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if

//--- Periodo di estrazione		
	kst_treeview_data_any = kst_treeview_data.struttura
	if kst_treeview_data_any.st_tab_barcode.data > kkg.data_no then  // se data NON impostata 
		k_mese = month(kst_treeview_data_any.st_tab_barcode.data) 
		k_anno = year(kst_treeview_data_any.st_tab_barcode.data) 
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	else
		kst_treeview_data_any.st_tab_barcode.data = kguo_g.get_dataoggi( )
		k_data_a =  relativedate(kst_treeview_data_any.st_tab_barcode.data, +1)
		k_data_da = relativedate(k_data_a, -500)
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.selectedpictureindex  = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_close
		end if
		

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

//--- ricavo i dati dalla struttura gia' letta nel padre
		kst_tab_barcode.id_meca = kst_treeview_data_any.st_tab_meca.id
		kst_tab_pl_barcode =	kst_treeview_data_any.st_tab_pl_barcode 
			 
	
//			+ " count (*), " &
		k_query_select = &
			" SELECT  distinct " &
			+ "   meca.num_int,    " &
			+ "   meca.data_int,   " & 
			+ "  barcode.data_sosp, " &
			+ "   meca.id,  " &
			+ "   meca.clie_1,  " &
			+ "   meca.clie_2,  " &
			+ "   meca.clie_3,  " &
			+ " 	meca.num_bolla_in, " &
			+ " 	meca.data_bolla_in, " &
			+ "   coalesce(meca.area_mag, ''),  " &
			+ "     meca.id_wm_pklist, " &
			+ " 	meca.contratto, " &
			+ " 	contratti.mc_co, " &
			+ " 	contratti.sc_cf, " &
			+ " 	contratti.descr, " &
			+ "   c1.rag_soc_10, " &
			+ "   c2.rag_soc_10, " &
			+ "   c3.rag_soc_10, " &
			+ " 	armo.magazzino, " &
			+ " 	armo.dose, " &
			+ " 	max(armo.larg_2), " &
			+ " 	max(armo.lung_2), " &
			+ " 	max(armo.alt_2), " &
			+ " 	max(armo.peso_kg), " &
			+ " 	sl_pt.cod_sl_pt, " &
			+ " 	sl_pt.descr, " &
			+ " 	sl_pt.densita " &
			+ " FROM (((((((meca INNER JOIN barcode ON  " &
			+ "       meca.num_int = barcode.num_int and meca.data_int = barcode.data_int) " &
			+ " 	 INNER JOIN clienti c1 ON  " &
			+ " 	 meca.clie_1 = c1.codice) " &
			+ " 	 INNER JOIN clienti c2 ON  " &
			+ " 	 meca.clie_2 = c2.codice) " &
			+ " 	 INNER JOIN clienti c3 ON  " &
			+ " 	 meca.clie_3 = c3.codice) " &
			+ " 	 INNER JOIN contratti ON " & 
			+ " 	 meca.contratto = contratti.codice) " &
			+ " 	 INNER JOIN armo ON  " &
			+ " 	 barcode.id_armo = armo.id_armo) " &
			+ " 	 left outer JOIN sl_pt ON  " &
			+ " 	 armo.cod_sl_pt = sl_pt.cod_sl_pt) " &
			+ " " 


			k_barcode_periodo = " meca.data_int >= '" + string(k_data_da) + "' and barcode.data_int < '" + string(k_data_a) + "' " 

			k_query_where = " where " &
					+ k_barcode_periodo &
					+ " and (barcode.data_stampa <= '" + string(k_data_0) + "' or barcode.data_stampa is null) " &
					+ " and armo.magazzino in (2, 4, 6) " &
					+ " and (barcode.data_sosp <= '" + string(k_data_0) + "' or barcode.data_sosp is null) " &
					+ " and (meca.stato = " + string(kuf1_armo.ki_meca_stato_OK) + " or meca.stato is null) "   
//12092014					+ " and (armo.magazzino = 2 and (barcode.causale <> '"+ kuf1_barcode.ki_causale_non_trattare +"' or barcode.causale is null) " &
//					+ "         or armo.magazzino in (4, 6) ) " &
//					+ " and (barcode.tipo <> '" + kuf1_barcode.ki_tipo_dosimetro + "' or barcode.tipo is null) " &

		k_query_order = " " &
			+ " group by  " & 
			+ "   meca.num_int,    " &
			+ "   meca.data_int,   " & 
			+ "  barcode.data_sosp, " &
			+ "   meca.id,  " &
			+ "   meca.clie_1,  " &
			+ "   meca.clie_2,  " &
			+ "   meca.clie_3,  " &
			+ " 	meca.num_bolla_in, " &
			+ " 	meca.data_bolla_in, " &
			+ "   meca.area_mag,  " &
			+ "    meca.id_wm_pklist, " &
			+ " 	meca.contratto, " &
			+ " 	contratti.mc_co, " &
			+ " 	contratti.sc_cf, " &
			+ " 	contratti.descr, " &
			+ "   c1.rag_soc_10, " &
			+ "   c2.rag_soc_10, " &
			+ "   c3.rag_soc_10, " &
			+ " 	armo.magazzino, " &
			+ " 	armo.dose, " &
			+ " 	sl_pt.cod_sl_pt, " &
			+ " 	sl_pt.descr, " &
			+ " 	sl_pt.densita " 
 
		k_query_order += " " &
			+ " order by  " & 
			+ "  meca.data_int, meca.num_int " 
	
//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using kguo_sqlca_db_magazzino;
		end if		
		
		open dynamic kc_treeview; // using :k_data_da, :k_data_a, :k_data_0, :k_data_0, :k_data_0, :k_data_0;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then

			
			fetch kc_treeview 
				into
					 :kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_barcode.data_sosp 
					 ,:kst_tab_meca.id  
					 ,:kst_tab_meca.clie_1  
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_meca.area_mag 
					 ,:kst_tab_meca.id_wm_pklist 
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_11 
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_armo.magazzino
					 ,:kst_tab_armo.dose 
					 ,:kst_tab_armo.larg_2
					 ,:kst_tab_armo.lung_2
					 ,:kst_tab_armo.alt_2
					 ,:kst_tab_armo.peso_kg
					 ,:kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.densita
					  ;
	
			if kguo_sqlca_db_magazzino.sqlcode = 0 then

				
				do while kguo_sqlca_db_magazzino.sqlcode = 0 

					kst_tab_barcode.id_meca = kst_tab_meca.id 
					
					kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
					kst_treeview_data_any.st_tab_pl_barcode = kst_tab_pl_barcode
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_sl_pt = kst_tab_sl_pt
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti

//--- conta i barcode del Riferimento
					select count(*)
						into  :kst_treeview_data_any.contati 
						from barcode
						where id_meca = :kst_tab_meca.id 
						using kguo_sqlca_db_magazzino; 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_barcode.num_int, "####0") &
											  + " - " + string(kst_tab_barcode.data_int, "dd.mm.yyyy") &
											  + " "  &
											  +  &
											  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
											  + string(kst_tab_meca.clie_3, "#####") + ")"
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data.handle = k_handle_item_padre
					kst_treeview_data.pic_list = k_pic_list	
					
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
											  
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
	
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
	
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

					
			fetch kc_treeview 
				into
					 :kst_tab_barcode.num_int   
					 ,:kst_tab_barcode.data_int   
					 ,:kst_tab_barcode.data_sosp 
					 ,:kst_tab_meca.id  
					 ,:kst_tab_meca.clie_1  
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
					 ,:kst_tab_meca.area_mag 
					 ,:kst_tab_meca.id_wm_pklist 
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_11 
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_armo.magazzino
					 ,:kst_tab_armo.dose 
					 ,:kst_tab_armo.larg_2
					 ,:kst_tab_armo.lung_2
					 ,:kst_tab_armo.alt_2
					 ,:kst_tab_armo.peso_kg
					 ,:kst_tab_sl_pt.cod_sl_pt 
					 ,:kst_tab_sl_pt.descr 
					 ,:kst_tab_sl_pt.densita
					  ;
		
				loop
				
			end if
			
			close kc_treeview;
		end if

	end if 
 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
 
return k_return

end function

public function integer u_tree_riempi_treeview_x_data (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_close, k_pic_open
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int, k_data_da, k_data_a, k_dataoggi
int k_mese, k_anno
string k_mese_desc [13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_barcode kst_tab_barcode
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



declare kc_treeview cursor for
	SELECT 
         count (*), 
         month(barcode.data_int) as mese,   
         year(barcode.data_int) as anno   
     FROM barcode
    WHERE 
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.barcode_mese
		  and barcode.data_int between :k_data_da and :k_data_a)
		 or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.barcode_anno_mese
		  and barcode.data_int between :k_data_da and :k_data_a)
		 or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.barcode_stor_mese
		  and barcode.data_int < :k_data_da ) 
		 group by  month(barcode.data_int), year(barcode.data_int)
		 order by  3 desc, 2 desc
		  ;


		 
////--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
//
////--- Acchiappo handle dell'item
//	kst_treeview_data = u_get_st_treeview_data ()
//	k_handle_item_padre = kst_treeview_data.handle
//
//	if k_handle_item_padre > 0 then
//		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//		kst_treeview_data = ktvi_treeviewitem.data
//		k_tipo_oggetto_padre = kst_treeview_data.oggetto
//	else
//		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
//		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
//	end if
//		 
//	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
//
////--- Procedo alla lettura della tab solo se non ho figli 
//	if k_handle_item_figlio <= 0 then
//		
////--- Imposta le propietà di default della tree 
//		u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)
//
////--- Preleva dall'archivio dati di conf della tree 
//		kst_tab_treeview.id = trim(k_tipo_oggetto_figlio)
//		kst_esito = u_select_tab_treeview(kst_tab_treeview)
//		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
//		end if
////		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
////		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)
//
////		ktvi_treeviewitem.pictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_pic_close)
////		ktvi_treeviewitem.selectedpictureindex = integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_pic_open)
//
//
////--- Cancello gli Item dalla tree prima di ripopolare
//		u_delete_item_child(k_handle_item_padre)
//		

//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
//			k_pic_open = kst_tab_treeview.pic_open
//			k_pic_close = kst_tab_treeview.pic_close
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
		end if
//		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
//		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )
//		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_close)
//		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_pl_da_trattare_dett_pic_open)


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		

//--- ricavo data oggi
		k_dataoggi = kguo_g.get_dataoggi()
//--- calcolo periodo
		k_anno = year(k_dataoggi) - 1
		k_mese = month(k_dataoggi)
		k_data_da = date (k_anno, k_mese, 01) 
		k_data_a = k_dataoggi 
//
			 
			 
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[1] = "Gennaio"
			k_mese_desc[2] = "Febbraio"
			k_mese_desc[3] = "Marzo"
			k_mese_desc[4] = "Aprile"
			k_mese_desc[5] = "Maggio"
			k_mese_desc[6] = "Giugno"
			k_mese_desc[7] = "Luglio"
			k_mese_desc[8] = "Agosto"
			k_mese_desc[9] = "Settembre"
			k_mese_desc[10] = "Ottobre"
			k_mese_desc[11] = "Novembre"
			k_mese_desc[12] = "Dicembre"
			k_mese_desc[13] = "NON RILEVATO"
			
			
			do while sqlca.sqlcode = 0
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_barcode.data = date(k_anno,01,01)
				else			
					kst_tab_barcode.data = date(k_anno,k_mese,01)
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
//				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				kst_tab_treeview.id = k_tipo_oggetto_figlio
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "####0") + "  Barcode presenti"
				end if
				kst_tab_treeview.descrizione_tipo = "Barcode" 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
//				kst_treeview_data.struttura = kst_tab_barcode


				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

//	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			loop
			
			close kc_treeview;
		end if

	end if 
 
return k_return


end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
string k_dataobject, k_id_programma
st_tab_barcode kst_tab_barcode
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza
pointer kp_oldpointer


kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.elenco

choose case a_campo_link

	case "barcode", "barcode_t", "barcode_lav"
		if a_campo_link = "barcode_t" then a_campo_link = "barcode"
		kst_tab_barcode.barcode = adw_link.getitemstring(adw_link.getrow(), a_campo_link)
		if len(kst_tab_barcode.barcode) > 0 then
	
			kst_esito = anteprima ( kdsi_elenco_output, kst_tab_barcode )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Dettaglio Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
		else
			k_return = false
		end if


	case "barcode_figli", "barcode_figli_t"
		kst_tab_barcode.barcode = adw_link.getitemstring(adw_link.getrow(), "barcode")
		if len(kst_tab_barcode.barcode) > 0 then
	
			kst_esito = anteprima_elenco_figli ( kdsi_elenco_output, kst_tab_barcode )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco 'Figli' del Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
		else
			k_return = false
		end if


		
	case "b_barcode_lotto" 
		kst_tab_barcode.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_barcode.id_meca > 0 then
	
			kst_esito = anteprima_elenco ( kdsi_elenco_output, kst_tab_barcode )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Elenco Barcode Lotto  (id=" + trim(string(kst_tab_barcode.id_meca)) + ") " 
		else
			k_return = false
		end if

		
	case "grp" 
		kst_tab_barcode.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_barcode.id_meca > 0 then
	
			kst_esito = anteprima_groupage_lotto ( kdsi_elenco_output, kst_tab_barcode )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Groupage Barcode Lotto  (id=" + trim(string(kst_tab_barcode.id_meca)) + ") " 
		else
			k_return = false
		end if



end choose


if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
//		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)




return k_return

end function

on kuf_barcode_tree.create
call super::create
end on

on kuf_barcode_tree.destroy
call super::destroy
end on

event constructor;call super::constructor;//
ki_msgerroggetto = "Barcode"

end event

