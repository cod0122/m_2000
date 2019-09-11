$PBExportHeader$kuf_armo_tree.sru
forward
global type kuf_armo_tree from kuf_parent
end type
end forward

global type kuf_armo_tree from kuf_parent
end type
global kuf_armo_tree kuf_armo_tree

type variables
//--- 
private kuf_armo kiuf_armo


////--- flag campo Stato della Dosimetrica
//public constant string ki_err_lav_ok_da_conv = " "
//public constant string ki_err_lav_ok_conv_ko_da_aut = "K"
//public constant string ki_err_lav_ok_conv_da_aut = "A"
//public constant string ki_err_lav_ok_conv_aut_ok = "2"
//public constant string ki_err_lav_ok_conv_ko_bloc = "B"
//public constant string ki_err_lav_ok_conv_ko_sbloc = "1"
//
////--- flag campo Stato della Lavorazione
//public constant string ki_err_lav_fin_da_lav = " "
//public constant string ki_err_lav_fin_ko = "1"
//public constant string ki_err_lav_fin_ok = " "
//
////--- flag campo Stato del Carico 
//public constant int ki_meca_stato_ok = 0
//public constant int ki_meca_stato_blk = 1
//public constant int ki_meca_stato_sblk = 2


end variables

forward prototypes
public subroutine meca_if_isnull (st_tab_meca kst_tab_meca)
public function integer u_tree_riempi_listview_testa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_testa_dosim (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_testa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_testa_dosim (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_righe_rifer (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_righe_rifer (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_err_giri (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_err_giri_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_da_conv_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_lav_ok (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function boolean link_call (ref datawindow kdw_1, string k_campo_link) throws uo_exception
public function string get_id_programma (string k_flag_modalita)
public function integer u_tree_riempi_treeview_testa_blk (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_smista (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_smista (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_testa_blk (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_testa_nodose (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_testa_qtna (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_testa_e1asn (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_listview_testa_e1asn (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
end prototypes

public subroutine meca_if_isnull (st_tab_meca kst_tab_meca);
end subroutine

public function integer u_tree_riempi_listview_testa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_tab_meca_stato kst_tab_meca_stato
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini

kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim
	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if (k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_qtna_dett and k_label = "Lotto (Quarantena)") &
		         or (k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.meca_qtna and k_label = "Lotto (Riferimento)") then 
				
				// non fa nulla xche' e' esempre il solito elenco
				
		else

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_qtna_dett then
				k_campo[k_ind] = "Lotto (Quarantena)"
			else
				k_campo[k_ind] = "Lotto (Riferimento)"
			end if
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Entrato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "WO / SO"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Area"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Bolla del mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "PKL"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Attestato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Contratto"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Lavorazione"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dosimetria"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ricevente/Cliente"
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
//---

		kuf1_armo = create kuf_armo

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_ind=1
			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mmm") &
 										  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) 
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if date(kst_treeview_data_any.st_tab_meca.data_ent) > kkg.data_zero then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_ent, "dd mmm hh:mm")
			else
				kst_tab_treeview.voce = " "
			end if	
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no then
				kst_tab_treeview.voce = "CHIUSO"
			else
				if kst_treeview_data_any.st_tab_meca.stato > 0 then
					try
						kst_tab_meca_stato.codice = kst_treeview_data_any.st_tab_meca.stato
						kst_tab_meca_stato.descrizione = kuf1_armo.get_stato_descrizione(kst_tab_meca_stato)
					catch (uo_exception kuo_exception)
					end try
					kst_tab_meca_stato.descrizione = string(kst_treeview_data_any.st_tab_meca.stato) + " = " + trim(kst_tab_meca_stato.descrizione)
				else
					if kst_treeview_data_any.st_tab_sped.id_sped > 0 then
						kst_tab_meca_stato.descrizione = "ddt nr " + string(kst_treeview_data_any.st_tab_sped.num_bolla_out) + " - " + string(kst_treeview_data_any.st_tab_sped.data_bolla_out) + " id " + string(kst_treeview_data_any.st_tab_sped.id_sped)
					else
						kst_tab_meca_stato.descrizione = " "
					end if
				end if
				kst_tab_treeview.voce =  kst_tab_meca_stato.descrizione
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") + " / "
			else
				kst_tab_treeview.voce = "- / "
			end if
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce += "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)
			
			kst_tab_treeview.voce =  string(trim(kst_treeview_data_any.st_tab_meca.area_mag), "@@ @@@@@@@@@@")
//										  string(kst_treeview_data_any.st_tab_armo.magazzino)  &
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = &
									  string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd.mm.yy") &
									  + "   " + trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			if kst_treeview_data_any.st_tab_meca.id_wm_pklist > 0 then
				kst_tab_treeview.voce = "SI"
			else
				kst_tab_treeview.voce =  "NO"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") &
											  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_artr.colli_trattati  > 0 then
				if kst_treeview_data_any.st_tab_certif.data_stampa > date(0) then
					kst_tab_treeview.voce =  &
												string(kst_treeview_data_any.st_tab_certif.num_certif, "####0") + " " &
											  + string(kst_treeview_data_any.st_tab_certif.data_stampa, "dd.mm.yy") 						
				else										  
					kst_tab_treeview.voce = "da stampare"
				end if
			else										  
				kst_tab_treeview.voce = " "
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_contratti.codice > 0 then
				kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_contratti.codice, "####0") &
										  + " SC-CF " + kst_treeview_data_any.st_tab_contratti.sc_cf &
				                    + " MC-CO " + kst_treeview_data_any.st_tab_contratti.mc_co &
										  + " " + trim(kst_treeview_data_any.st_tab_contratti.descr)
			else
				kst_tab_treeview.voce = " "
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce = "" 
			if kst_treeview_data_any.st_tab_contratti.codice > 0 then
				if kst_treeview_data_any.st_tab_meca.data_lav_fin > date(0) then
					if kst_treeview_data_any.st_tab_meca.err_lav_fin = kuf1_armo.ki_err_lav_fin_ko then
						kst_tab_treeview.voce += "con Anomalia " 
					else
						kst_tab_treeview.voce += "TRATTATO " 
					end if
				else
					if kst_treeview_data_any.st_tab_artr.colli_trattati > 0 then
						kst_tab_treeview.voce +=  "in lav.: " + string (kst_treeview_data_any.st_tab_artr.colli_trattati) + " colli trattati "
					else
						kst_tab_treeview.voce +=  "da trattare" 
					end if
				end if
			else
				kst_tab_treeview.voce +=  " " 
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_artr.colli_trattati  > 0 then
				if kst_treeview_data_any.st_tab_meca.err_lav_ok <> kuf1_meca_dosim.ki_err_lav_ok_da_conv then
					kst_tab_treeview.voce = kuf1_armo.err_lav_ok_dammi_descr(kst_treeview_data_any.st_tab_meca)
				else
					kst_tab_treeview.voce =  "da convalidare" 
				end if
			else
				kst_tab_treeview.voce =  " " 
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.clie_2, "####0") &
											  + "   -  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_11) &
											  + " ; CLIENTE:  " + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + "  -  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20)  &
											  + "     (id Lotto=" + string(kst_treeview_data_any.st_tab_meca.id) + ") " 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
		destroy kuf1_armo
		
	end if


	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
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

public function integer u_tree_riempi_listview_testa_dosim (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
boolean k_campo_valorizzato[15] 
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini

kuf_armo kuf1_armo

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
//		if k_label <> "Riferimento (convalida)" then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Lotto (convalida)"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Entrato"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Stato"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "E1 (WO/SO)"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Convalidato"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Autorizzato"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Sbloccato"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Lettura Dosimetrica"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Cliente"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
//			k_ind++
//			k_campo[k_ind] = "Contratto"
//			k_align[k_ind] = left!
//			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "Lavorato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "id Lotto"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			k_campo_valorizzato[k_ind] = false
			
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
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 6 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop

//		end if
//---

		kuf1_armo = create kuf_armo

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
// Lotto
			k_ind = 1
			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
											  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mmm") &
											  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) 
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// Data entrata
			k_ind++
			if date(kst_treeview_data_any.st_tab_meca.data_ent) > kkg.data_zero then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_ent, "dd mmm hh:mm")
				k_campo_valorizzato[k_ind] = true
			else
				kst_tab_treeview.voce = " "
			end if	
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// STATO
			k_ind++
			choose case kst_treeview_data_any.st_tab_meca.aperto 
				case kuf1_armo.kki_meca_aperto_no 
					kst_tab_treeview.voce = "[CHIUSO] "
				case kuf1_armo.kki_meca_aperto_annullato
					kst_tab_treeview.voce = "[ANNULLATO] "
				case else
					kst_tab_treeview.voce = ""
			end choose
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_data > date(0) then
				kst_tab_treeview.voce += kuf1_armo.err_lav_ok_dammi_descr(kst_treeview_data_any.st_tab_meca)
			else
				kst_tab_treeview.voce +=  "da convalidare" 
			end if
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// E1
			k_ind++
			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") + " / "
			else
				kst_tab_treeview.voce = "- / "
			end if
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce += "-"
			end if
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)

// dosimetria convalida data
			k_ind++
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_data > date(0) then
				kst_tab_treeview.voce =  &
										string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_data_ora, "dd.mm.yy hh:mm") + " "
				k_campo_valorizzato[k_ind] = true
			else
				kst_tab_treeview.voce = " "
			end if				
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// dosimetria verifica data
			k_ind++
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica > datetime(date(0)) then
				k_campo_valorizzato[k_ind] = true
				kst_tab_treeview.voce =  &
										string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica, "dd.mm.yy") + " "
			else
				kst_tab_treeview.voce = " "
			end if				
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			
// dosimetria sblocco data
			k_ind++
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko > datetime(date(0)) then
				k_campo_valorizzato[k_ind] = true
				kst_tab_treeview.voce =  &
										string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko, "dd.mm.yy") + " "
			else
				kst_tab_treeview.voce = " "
			end if				
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// dosimetria altri dati
			k_ind++
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_assorb > 0 then
				k_campo_valorizzato[k_ind] = true
				kst_tab_treeview.voce =  &
										string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_dose, "###0.00") + " " &
										+ "  Ass/Spess.: " &
										+ string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_assorb, "####0") + " / " &
										+ string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_spessore, "####0") + " " &
										+ " = " &
										+ string(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s, "####0.###") + " " &
										+ ";  Lotto: " &
										+ trim(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim)  
				if LenA(trim(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.barcode_dosimetro )) > 0 then
					kst_tab_treeview.voce += "; dosimetro: " + trim(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.barcode_dosimetro )
				end if
			else
				kst_tab_treeview.voce =  " "
			end if
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

//			if LenA(trim(kst_treeview_data_any.st_tab_meca.note_lav_ok)) > 0 then
//				k_campo_valorizzato[8] = true
//				kst_tab_treeview.voce =  &
//										trim(kst_treeview_data_any.st_tab_meca.note_lav_ok) + " " 
//			else
//				kst_tab_treeview.voce =  " "
//			end if
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, 8, trim(kst_tab_treeview.voce) )

// cliente
			k_ind++
			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) 
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
//
//			kst_tab_treeview.voce =  &
//										  string(kst_treeview_data_any.st_tab_contratti.codice, "####0") &
//										  + " SC-CF " + kst_treeview_data_any.st_tab_contratti.sc_cf &
//				                    + " MC-CO " + kst_treeview_data_any.st_tab_contratti.mc_co &
//										  + " " + trim(kst_treeview_data_any.st_tab_contratti.descr)
//			k_campo_valorizzato[9] = true
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, 9, trim(kst_tab_treeview.voce) )

// fine lavorazione data
			k_ind++
			if kst_treeview_data_any.st_tab_meca.data_lav_fin > date(0) then
				kst_tab_treeview.voce = "Trattato il " + string (kst_treeview_data_any.st_tab_meca.data_lav_fin)
			else
//				if kst_treeview_data_any.st_tab_artr.colli_trattati > 0 then
//					kst_tab_treeview.voce =  "in lav.: " + string (kst_treeview_data_any.st_tab_artr.colli_trattati) + " colli trattati "
//				else
					kst_tab_treeview.voce =  "da trattare" 
//				end if
			end if
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

// id lotto
			k_ind++
			kst_tab_treeview.voce =  string(kst_treeview_data_any.st_tab_meca.id) 
			k_campo_valorizzato[k_ind] = true
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
		if isvalid(kuf1_armo) then destroy kuf1_armo
		
	end if

//--- nasconde/scopre eventuali colonne mai valorizzate
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then 
		k_ind=1
		do while trim(k_campo[k_ind]) <> "FINE"
	
			kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
			if k_campo_valorizzato[k_ind] then
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 8
					kuf1_treeview.kilv_lv1.setColumn(k_ind, k_label, k_align_1, k_ctr) // scopre
				end if
			else
				kuf1_treeview.kilv_lv1.setColumn(k_ind, k_label, k_align_1, 1)  // nasconde
			end if
			
			k_ind++
		loop
	end if

	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
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

public function integer u_tree_riempi_treeview_testa (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order, k_query_from=""
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi, k_datameno2anni, k_datameno1anni, k_datameno4sett
boolean k_nuovo_item=true, k_esponi = true, kc_treeview_open=false
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_clienti kst1_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_artr kst_tab_artr
kuf_meca_dosim kuf1_meca_dosim
kuf_armo kuf1_armo
kuf_certif kuf1_certif
kuf_clienti kuf1_clienti

try

	kuf1_armo = create kuf_armo
	kuf1_certif = create kuf_certif
	kuf1_clienti = create kuf_clienti

	k_data_0 = date(0)		 
//--- data oggi
	k_dataoggi = kg_dataoggi
		 
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

	k_data_da = date(0)
	k_data_a = date(0)

	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
		 then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
////--- QUERY TROPPO PESANTE non faccio NULLA!!!!!
//			k_data_da = k_data_a
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		if k_data_da <> date(0) then
			k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
		end if
	end if

	if k_data_da > date(0) then
		if k_data_a = date(0) then
			k_data_a = k_dataoggi
		end if
	end if
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi  o date a zero allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
		if (DaysAfter ( k_data_da, k_data_a ) > 61 and DaysAfter ( k_data_da, k_data_a ) < 360) or k_data_da = date(0)  then
			kst_tab_meca.clie_1 =0
			kst_tab_meca.clie_2 =0
			kst_tab_meca.clie_3 =0
			kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
			if kst_esito.esito = kkg_esito.ok then
				k_data_a = kst_tab_meca.data_int
				k_data_da = relativedate(k_data_a , -7)
			else
				//--- se errore non vedo NULLA!
				k_data_da = k_data_a
			end if
		end if
		k_datameno2anni = RelativeDate(k_data_a, -730) 		 
		k_datameno1anni = RelativeDate(k_data_a, -365) 		 
		k_datameno4sett = RelativeDate(k_data_a, -28) 		 

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x occupare meno memoria
		if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then

			//--- MAX tot righe!!!
			k_query_select = &
					"SELECT TOP 10000 " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.clie_1,  " &
					+ "c1.rag_soc_10 " &
					+ "FROM   " & 
					 + "meca   " &
					 + " inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " &

		else
			k_query_select = &
					"SELECT  " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.area_mag, " &
					+ "meca.clie_1,  " &
					+ "meca.clie_2,  " &
					+ "meca.clie_3,  " &
					+ "meca.num_bolla_in, " &
					+ "meca.data_bolla_in, " &
					+ "meca.id_wm_pklist, " &
					+ "meca.data_lav_fin,    " &
					+ "meca.err_lav_fin,    " &
					+ "meca.err_lav_ok,    " &
					+ "meca.cert_forza_stampa,   " &
					+ "meca.stato,   " &
					+ "meca.contratto, " &
					+ "contratti.mc_co, "  &
					+ "contratti.sc_cf, " &
					+ "contratti.descr, " &
					+ "certif.num_certif, " &
					+ "certif.data_stampa, " &
					+ "c1.rag_soc_10, " &
					+ "sum(colli_trattati), " & 
					+ "coalesce(meca.e1doco,0), " &
					+ "coalesce(meca.e1rorn,0), " &
					+ "coalesce(meca.e1srst,'NC') " 

			k_query_from = &  
					+ "FROM   " & 
					 + "meca  inner JOIN armo ON  " &
					 + "meca.id = armo.id_meca " &
					 + " inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " &
					 + "LEFT OUTER JOIN contratti ON  " &
					 + "meca.contratto = contratti.codice " &
					 + "LEFT OUTER JOIN certif ON  " &
					 + "meca.id = certif.id_meca " &
					 + "LEFT OUTER JOIN ARTR ON armo.id_armo = artr.id_armo "
		end if

//					+ "c2.rag_soc_10, " &
//					+ "c3.rag_soc_10 " &
//					 + " inner JOIN clienti c2 ON  " &
//					 + "meca.clie_2 = c2.codice " &
//					 + " inner JOIN clienti c3 ON  " &
//					 + "meca.clie_3 = c3.codice "  &
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett
				k_query_where = k_query_from 
				if k_data_a  <> k_data_0 then
					k_query_where += &
						 " where (meca.data_int between ? and ?) "
				end if

			case kuf1_treeview.kist_treeview_oggetto.meca_car_meca_dett &
			    , kuf1_treeview.kist_treeview_oggetto.meca_dett_id_meca
				k_query_where = &
						k_query_from &
					+ " where (meca.id = ? ) "
					
					
			case kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett
				k_query_where = &
						k_query_from &
					+ " where " &
					+ "  (meca.data_int between ? and ?) " &
					+ " and meca.data_int between '" + string(k_data_da) + "' and '" + string(k_data_a) + "' " &
					+ " and (meca.clie_1 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " or meca.clie_2 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " or meca.clie_3 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " ) " 
					
			case kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett
				k_query_where = &
						k_query_from &
					+ " where " & 
					+ "  (meca.data_int between ? and ?) " &
					+ " and (meca.clie_1 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " or meca.clie_2 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " or meca.clie_3 = " + string(kst_treeview_data_any.st_tab_clienti.codice) &
					+ " ) " 

			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett
				k_query_where = &
						k_query_from &
					+ " where " &
					+ "  meca.data_int > '"+string(k_datameno2anni)+"' "
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ " and (meca.data_int between ? and ?) "
				end if
				k_query_where = k_query_where &
					+ " and meca.err_lav_fin = '1' "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett
				k_query_where = &
						k_query_from &
					+ " where " 
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ "  (meca.data_int between ? and ?) and "
				end if
				k_query_where = k_query_where &
					+ "  (meca.err_lav_ok = '" + kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut  + "'" & 
					+  "  or meca.err_lav_ok = '" + kuf1_meca_dosim.ki_err_lav_ok_conv_ko_bloc  + "'" & 
					+ "   or meca.err_lav_ok = '" + kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc  + "'" & 
					+ "   or meca.err_lav_fin = '" + kuf1_armo.ki_err_lav_fin_ko  + "' ) "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_blk_dett
				k_query_where = &
						k_query_from &
					+ " where " & 
					+ "  meca.data_int between '" + string(k_datameno1anni) + "' and '" + string(k_data_a) + "' " &
					+ " and (meca.aperto is null " &
					+ "      or meca.aperto not in ('" + string(kuf1_armo.kki_meca_aperto_no) + "', '" + string(kuf1_armo.kki_meca_aperto_annullato) + "') ) "&
					+ " and (meca.stato = " + string(kuf1_armo.ki_meca_stato_blk) &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_sblk) &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_blk_con_controllo) + " " &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_gen_da_completare ) + ") "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett
				k_query_where = &
						k_query_from &
					+ " where " &
					+ " meca.data_int between '" + string(k_datameno4sett) + "' and '" + string(k_data_a) + "' " &
					+ " and (meca.aperto is null " &
					+ "      or meca.aperto not in ('" + string(kuf1_armo.kki_meca_aperto_no) + "', '" + string(kuf1_armo.kki_meca_aperto_annullato) + "') ) "&
					+ " and meca.id_wm_pklist > 0 "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_trasferiti_dapkl
				k_query_where = &
						k_query_from &
					+ " where " &
					+ " (meca.data_int between ? and ?) " &
					+ " and meca.stato = 5 " &
					+ " and (meca.aperto is null " &
					+ "      or meca.aperto not in ('" + string(kuf1_armo.kki_meca_aperto_no) + "', '" + string(kuf1_armo.kki_meca_aperto_annullato) + "') ) "
					
			case else
					k_query_where = " "
	
		end choose
	

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
		if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
			
			k_query_order = " "
				
		else
			k_query_order = &
					+ " group by " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.area_mag, " &
					+ "meca.clie_1,  " &
					+ "meca.clie_2,  " &
					+ "meca.clie_3,  " &
					+ "meca.num_bolla_in, " &
					+ "meca.data_bolla_in, " &
					+ "meca.id_wm_pklist, " &
					+ "meca.data_lav_fin,    " &
					+ "meca.err_lav_fin,    " &
					+ "meca.err_lav_ok,    " &
					+ "meca.cert_forza_stampa,   " &
					+ "meca.stato,   " &
					+ "meca.contratto, " &
					+ "contratti.mc_co, "  &
					+ "contratti.sc_cf, " &
					+ "contratti.descr, " &
					+ "certif.num_certif, " &
					+ "certif.data_stampa, " &
					+ "c1.rag_soc_10, " &
					+ "meca.e1doco, " &
					+ "meca.e1rorn, " &
					+ "meca.e1srst " 
			
		end if
		
//--- se tipo oggetto solo Lotti da associare in WM...		
		if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett then
			k_query_order += " having sum(colli_trattati) = 0 or sum(colli_trattati) is null "
		end if
	
		k_query_order += &
			+ " order by  " &
			+ " meca.data_ent desc, meca.data_int desc, meca.num_int desc " 
		 
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
			 

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett 
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview;
				end if
				
			case kuf1_treeview.kist_treeview_oggetto.meca_car_meca_dett &
			    		, kuf1_treeview.kist_treeview_oggetto.meca_dett_id_meca
				open dynamic kc_treeview using :kst_treeview_data_any.st_tab_meca.id;

			case  &
				 kuf1_treeview.kist_treeview_oggetto.meca_blk_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett 
				open dynamic kc_treeview;

			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett &
					,kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett &
				 	,kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett &
			   		,kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett &
			   		,kuf1_treeview.kist_treeview_oggetto.meca_trasferiti_dapkl 
				open dynamic kc_treeview using :k_data_da, :k_data_a;
	
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode = 0 then
			kc_treeview_open = true

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
			if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
				
				fetch kc_treeview 
					into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_clienti.rag_soc_10 
						  ;
				
			else
				
				fetch kc_treeview 
					into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.area_mag   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.id_wm_pklist 
						 ,:kst_tab_meca.data_lav_fin   
						 ,:kst_tab_meca.err_lav_fin   
						 ,:kst_tab_meca.err_lav_ok   
						 ,:kst_tab_meca.cert_forza_stampa  
						 ,:kst_tab_meca.stato
						 ,:kst_tab_contratti.codice
						 ,:kst_tab_contratti.mc_co
						 ,:kst_tab_contratti.sc_cf
						 ,:kst_tab_contratti.descr
						 ,:kst_tab_certif.num_certif
						 ,:kst_tab_certif.data_stampa
						 ,:kst_tab_clienti.rag_soc_10 
//						 ,:kst_tab_clienti.rag_soc_11 
//						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_artr.colli_trattati 
						 ,:kst_tab_meca.e1doco
						 ,:kst_tab_meca.e1rorn
						 ,:kst_tab_meca.e1srst
						  ;
			end if	
			
			
			do while sqlca.sqlcode = 0
	
				k_esponi = true
	
		  		if isnull(kst_tab_artr.colli_trattati) then
					kst_tab_artr.colli_trattati = 0
				end if
		  		if isnull(kst_tab_contratti.codice) then
					kst_tab_contratti.codice = 0
				end if
			   	if isnull(kst_tab_contratti.sc_cf) then
					kst_tab_contratti.sc_cf = " "
				end if
	 		   	if isnull(kst_tab_contratti.mc_co) then
					kst_tab_contratti.mc_co = " "
				end if
		      	if isnull(kst_tab_contratti.descr) then
					kst_tab_contratti.descr = " "
				end if


				kuf1_armo.if_isnull_meca(kst_tab_meca)				
				kuf1_certif.if_isnull(kst_tab_certif)				
				
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int

//--- se tipo oggetto solo Lotti da associare in WM...		
				if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett then
					k_esponi = false
					if kst_tab_meca.id_wm_pklist > 0 then
//						if NOT kuf1_armo.if_lotto_wm_associato(kst_tab_meca) then
						if kst_tab_meca.e1srst <> "20" then
							k_esponi = true
						end if
					end if
				end if
					
				
				if k_esponi then

//--- Get nome Ricevente
					kst_tab_clienti.rag_soc_11 = ""
					if  kst_tab_meca.clie_2 > 0 then
						if kst_tab_meca.clie_1 = kst_tab_meca.clie_2 then
							kst_tab_clienti.rag_soc_11 = kst_tab_clienti.rag_soc_10
						else
							kst1_tab_clienti.codice = kst_tab_meca.clie_2 
							kuf1_clienti.get_nome(kst1_tab_clienti)
							kst_tab_clienti.rag_soc_11 = kst1_tab_clienti.rag_soc_10
						end if
					end if
//--- Get Nome Fatturato (CLIENTE)
					kst_tab_clienti.rag_soc_20 = ""
					if  kst_tab_meca.clie_3 > 0 then
						if kst_tab_meca.clie_1 = kst_tab_meca.clie_3 then
							kst_tab_clienti.rag_soc_20 = kst_tab_clienti.rag_soc_10
						else
							if kst_tab_meca.clie_2 = kst_tab_meca.clie_3 then
								kst_tab_clienti.rag_soc_20 = kst_tab_clienti.rag_soc_11
							else
								kst1_tab_clienti.codice = kst_tab_meca.clie_3 
								kuf1_clienti.get_nome(kst1_tab_clienti)
								kst_tab_clienti.rag_soc_20 = kst1_tab_clienti.rag_soc_10
							end if
						end if
					end if
				
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
					kst_treeview_data_any.st_tab_certif = kst_tab_certif
					kst_treeview_data_any.st_tab_artr = kst_tab_artr
	
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_meca.num_int, "####0") &
											  + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
											  + " "  &
											  + trim(kst_tab_clienti.rag_soc_10) 
	
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
					
				end if

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
				if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
				
					fetch kc_treeview 
						into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_clienti.rag_soc_10 
						  ;
					
				else
					
					fetch kc_treeview 
						into
							 :kst_tab_meca.id   
							 ,:kst_tab_meca.num_int   
							 ,:kst_tab_meca.data_int   
							 ,:kst_tab_meca.data_ent   
							 ,:kst_tab_meca.aperto   
							 ,:kst_tab_meca.area_mag   
							 ,:kst_tab_meca.clie_1  
							 ,:kst_tab_meca.clie_2  
							 ,:kst_tab_meca.clie_3  
							 ,:kst_tab_meca.num_bolla_in 
							 ,:kst_tab_meca.data_bolla_in 
							 ,:kst_tab_meca.id_wm_pklist 
							 ,:kst_tab_meca.data_lav_fin   
							 ,:kst_tab_meca.err_lav_fin   
							 ,:kst_tab_meca.err_lav_ok   
							 ,:kst_tab_meca.cert_forza_stampa  
							 ,:kst_tab_meca.stato
							 ,:kst_tab_contratti.codice
							 ,:kst_tab_contratti.mc_co
							 ,:kst_tab_contratti.sc_cf
							 ,:kst_tab_contratti.descr
							 ,:kst_tab_certif.num_certif
							 ,:kst_tab_certif.data_stampa
							 ,:kst_tab_clienti.rag_soc_10 
//							 ,:kst_tab_clienti.rag_soc_11 
//							 ,:kst_tab_clienti.rag_soc_20 
							 ,:kst_tab_artr.colli_trattati 
							 ,:kst_tab_meca.e1doco
							 ,:kst_tab_meca.e1rorn
							 ,:kst_tab_meca.e1srst
							  ;
				end if	
	
			loop
			
		end if

	end if 


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


finally
	if kc_treeview_open then 
		close kc_treeview;
	end if
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try


return k_return


end function

public function integer u_tree_riempi_treeview_testa_dosim (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi, k_datameno3anni, k_datameno1anni
boolean k_nuovo_item=true
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim



	k_data_0 = date(0)		 
//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( ) 
		 
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

	k_data_da = date(0)
	k_data_a = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
		 then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
	end if

	k_datameno3anni = RelativeDate(k_dataoggi, -(365 * 3) )		 
	k_datameno1anni = RelativeDate(k_dataoggi, -365) 		 
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then

//--- crea oggetti
		kuf1_armo = create kuf_armo
			
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
	
		k_query_select = &
			"SELECT  " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.clie_3,  " &
					+ "meca.data_lav_fin,    " &
					+ "meca.err_lav_fin,    " &
					+ "meca_dosim.barcode_dosimetro,    " &
					+ "meca_dosim.dosim_data,    " &
 					+ "CONVERT(DATETIME, CONVERT(varchar(20), dosim_data,105)  + ' ' + CONVERT(varchar(8), coalesce(dosim_ora, '00:00:00'), 108))" &
					+ "meca_dosim.dosim_dose,    " &
					+ "meca.err_lav_ok,    " &
					+ "meca.note_lav_ok,   " &
					+ "meca_dosim.x_data_dosim_verifica,  " & 
					+ "meca_dosim.x_data_dosim_sblocco_ko,  " & 
					+ "meca_dosim.dosim_assorb,   " &
					+ "meca_dosim.dosim_spessore,   " &
					+ "meca_dosim.dosim_rapp_a_s,   " &
					+ "meca_dosim.dosim_lotto_dosim,  " & 
					+ "c3.rag_soc_20 " &
					+ ",meca.e1doco " &
					+ ",meca.e1rorn " &
					+ "FROM  meca  " & 
					 + "LEFT OUTER JOIN meca_dosim ON  " &
					 + "meca.id = meca_dosim.id_meca " &
					 + " inner JOIN clienti c3 ON  " &
					 + "meca.clie_3 = c3.codice " &
					 
//					+ "armo.magazzino, " &
//					 + "meca INNER JOIN armo ON  " &
//					 + "meca.id = armo.id_meca " &
//					+ "meca.contratto, " &
//					+ "contratti.mc_co, "  &
//					+ "contratti.sc_cf, " &
//					+ "contratti.descr, " &
//					+ "sum(colli_trattati)  " &
//					 + "LEFT OUTER JOIN contratti ON  " &
//					 + "meca.contratto = contratti.codice " &
//					 + "INNER JOIN ARTR ON armo.id_armo = artr.id_armo "
//
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_lav_dett
				k_query_where = " where " &
					+ "  meca.id = " + string(kst_treeview_data_any.st_tab_meca.id) +" "

			case kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok_dett
				k_query_where = " where " &
					+ "  meca.data_int > '" + string(k_datameno3anni) +"' "
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ " and (meca.data_int between '"+string(k_data_da)+"' and '"+string(k_data_a)+"') "
				end if
				k_query_where += " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_aut_ok+"') " 
					
			case kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ko_dett
				k_query_where = " where " &
					+ "  meca.data_int > '" + string(k_datameno3anni)+"' "
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ " and (meca.data_int between ? and ?) "
				end if
				k_query_where = k_query_where &
					+ " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc+"') " & 
					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 

			case kuf1_treeview.kist_treeview_oggetto.meca_lav_att_prima_dett
				k_query_where = " where " &
					+ "  meca.data_int > '"+string(RelativeDate(k_dataoggi, -180))+"' " &
					+ " and (meca_dosim.dosim_data is null or meca_dosim.dosim_data <= '"+string(k_data_0)+"' ) " 
//					+ " and artr.data_fin > '" + string(k_data_0) + "' "  & 
					
			case kuf1_treeview.kist_treeview_oggetto.meca_lav_att_aut_ok_dett
				k_query_where = " where " &
					+ "  meca.data_int > '"+string(k_datameno1anni)+"' " &
					+ " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_da_aut+"') " & 
					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 
					
			case kuf1_treeview.kist_treeview_oggetto.meca_lav_att_aut_ko_dett
				k_query_where = " where " &
					+ "  meca.data_int > '"+string(k_datameno1anni)+"' " &
					+ " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut+"') " & 
					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 

			case kuf1_treeview.kist_treeview_oggetto.meca_lav_ko_da_sblk_dett
				k_query_where = " where " &
					+ "  meca.data_int > '"+string(k_datameno3anni)+"' " &
					+ " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_bloc+"') " & 
					+ " and (meca_dosim.dosim_data > '"+string(k_data_0)+"') " 

					
//			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett
//				k_query_where = " where " 
//				if k_data_a  <> k_data_0 then
//					k_query_where = k_query_where &
//					+ "  (meca.data_int between ? and ?) and "
//				end if
//				k_query_where = k_query_where &
//					+ "  (meca.err_lav_ok = '1' or meca.err_lav_fin = '1') "
//					
					
			case else
					k_query_where = " "
	
		end choose
	
//		k_query_order = &
//         + " group by " &
//			+ "meca.id, " &
//			+ "meca.num_int, " &
//			+ "meca.data_int, " &
//         + "meca.clie_3,  " &
//         + "meca.data_lav_fin,    " &
//         + "meca.err_lav_fin,    " &
//         + "meca_dosim.dosim_data,    " &
//         + "meca_dosim.dosim_dose,    " &
//         + "meca.err_lav_ok,    " &
//         + "meca.note_lav_ok,   " &
//         + "meca_dosim.x_data_dosim_verifica,  " & 
//         + "meca_dosim.x_data_dosim_sblocco_ko,  " & 
//         + "meca_dosim.dosim_assorb,   " &
//         + "meca_dosim.dosim_spessore,   " &
//         + "meca_dosim.dosim_rapp_a_s,   " &
//         + "meca_dosim.dosim_lotto_dosim,  " & 
//			+ "armo.magazzino, " &
//			+ "meca.contratto, " &
//			+ "contratti.mc_co, "  &
//			+ "contratti.sc_cf, " &
//			+ "contratti.descr, " &
//         + "c3.rag_soc_20 " 
			
		k_query_order += &
			+ " order by  " &
			+ " meca.data_ent desc, meca.data_int desc, meca.num_int desc " 
		 
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
			 

		choose case k_tipo_oggetto
				
					
			case kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ko_dett
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview;
				end if
				
			case kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett &
				 ,kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett &
			 	 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_att_prima_dett &
			 	 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_att_aut_ok_dett &
			 	 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_att_aut_ko_dett &
			 	 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_ko_da_sblk_dett &
			 	 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_dett &
				 ,kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok_dett
				open dynamic kc_treeview;

	
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode <> 0 then
			sqlca.sqlerrtext = trim(sqlca.sqlerrtext) + k_query_select
			kuf1_treeview.u_sql_scrivi_log(sqlca)
		else

			fetch kc_treeview 
				into
					 :kst_tab_meca.id   
					 ,:kst_tab_meca.num_int   
					 ,:kst_tab_meca.data_int   
					 ,:kst_tab_meca.data_ent   
					 ,:kst_tab_meca.aperto   
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.data_lav_fin   
					 ,:kst_tab_meca.err_lav_fin   
					 ,:kst_tab_meca.st_tab_meca_dosim.barcode_dosimetro   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data_ora   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
					 ,:kst_tab_meca.err_lav_ok   
					 ,:kst_tab_meca.note_lav_ok  
					 ,:kst_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica
					 ,:kst_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_meca.e1doco 
					 ,:kst_tab_meca.e1rorn
					  ;
	
//					  :kst_treeview_data_any.contati
//					 ,:kst_tab_barcode.data
			
			do while sqlca.sqlcode = 0
	
				kuf1_armo.if_isnull_meca(kst_tab_meca)				
				if isnull(kst_tab_clienti.rag_soc_20) then
					kst_tab_clienti.rag_soc_20 = " "
				end if
				
//---- Controllo se almeno un pl ha finito il trattamento 
//				if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_lav_att_prima_dett then
//					kst_tab_artr.id_armo = kst_tab_meca.id
//					kst_esito = kuf1_artr.leggi( 3, kst_tab_artr )
//				end if

//				if kst_tab_artr.data_fin > k_data_0 or k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.meca_lav_att_prima_dett then
				if kst_tab_meca.data_lav_fin > k_data_0 or k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.meca_lav_att_prima_dett then
	
					kst_tab_armo.id_meca = kst_tab_meca.id
					kst_tab_armo.num_int = kst_tab_meca.num_int
					kst_tab_armo.data_int = kst_tab_meca.data_int
					
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
	
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_meca.num_int, "####0") &
											  + " - " + string(kst_tab_meca.data_int, "dd.mmm") &
											  + " "  &
											  + trim(kst_tab_clienti.rag_soc_20) 
//											  +  &
//											  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
//											  + string(kst_tab_meca.clie_3, "#####") + ")"
	
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

				end if
	
				fetch kc_treeview 
				into
					 :kst_tab_meca.id   
					 ,:kst_tab_meca.num_int   
					 ,:kst_tab_meca.data_int   
					 ,:kst_tab_meca.data_ent   
					 ,:kst_tab_meca.aperto   
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.data_lav_fin   
					 ,:kst_tab_meca.err_lav_fin   
					 ,:kst_tab_meca.st_tab_meca_dosim.barcode_dosimetro   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data_ora   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
					 ,:kst_tab_meca.err_lav_ok   
					 ,:kst_tab_meca.note_lav_ok  
					 ,:kst_tab_meca.st_tab_meca_dosim.x_data_dosim_verifica
					 ,:kst_tab_meca.st_tab_meca_dosim.x_data_dosim_sblocco_ko
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
					 ,:kst_tab_clienti.rag_soc_20 
					 ,:kst_tab_meca.e1doco 
					 ,:kst_tab_meca.e1rorn
					  ;
	
			loop
			
			close kc_treeview;
			
		end if
			
		if isvalid(kuf1_armo) then destroy kuf1_armo

	end if 
 
return k_return


end function

public function integer u_tree_riempi_listview_righe_rifer (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_armo kst_tab_armo
st_tab_prodotti kst_tab_prodotti
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
//--- Ricavo l'oggetto figlio dal DB 
//	kst_tab_treeview.id = k_tipo_oggetto
//	u_select_tab_treeview(kst_tab_treeview)
//	k_tipo_oggetto_figlio = kst_tab_treeview.funzione

//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item = kst_treeview_data.handle
	
	if k_handle_item > 0 then

//--- prendo il item padre per settare il ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)

	end if
		
//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item = 0 or isnull(k_handle_item) then	
	
//--- item di ritorno di default
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		
	end if
	k_handle_item_corrente = k_handle_item

//--- item di ritorno di default
	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_padre = kst_treeview_data.oggetto	

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
//--- item di ritorno (vedi anche alla fine)
	if k_handle_item_padre > 0 then
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
	end if
		
	if k_handle_item > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)

		kst_treeview_data = ktvi_treeviewitem.data

		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					
		if k_label <> "Articolo" then 
  		
//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Articolo"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Riferimento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Magazzino"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Colli entrati/fatturati"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Pedane"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dose"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Campione"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Peso"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Misure"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "SL-PT"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ulteriori Informazioni"
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


//--- imposto il pic corretto
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  
		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
		k_pictureindex = kuf1_treeview.u_dammi_pic_tree_list(k_oggetto_corrente)			


		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_tab_armo = kst_treeview_data_any.st_tab_armo
			kst_tab_meca = kst_treeview_data_any.st_tab_meca
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti
			kst_tab_sl_pt = kst_treeview_data_any.st_tab_sl_pt
			kst_tab_prodotti = kst_treeview_data_any.st_tab_prodotti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = k_pictureindex
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			kuf1_treeview.kilv_lv1.setitem(k_ctr, 1, trim(kst_tab_armo.art) + " " + trim(kst_tab_prodotti.des))

			kuf1_treeview.kilv_lv1.setitem(k_ctr, 2, string(kst_tab_armo.data_int , "dd/mmm") + string(kst_tab_armo.num_int , "  ####0"))
	
			kuf1_treeview.kilv_lv1.setitem(k_ctr, 3, string(kst_tab_armo.magazzino))
			if kst_tab_armo.colli_fatt > 0 then 
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.colli_2, "####0") + "/" &
									 + string(kst_tab_armo.colli_fatt, "####0"))
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 4, string(kst_tab_armo.colli_2, "####0"))
			end if
			kuf1_treeview.kilv_lv1.setitem(k_ctr, 5, string(kst_tab_armo.pedane, "####0"))
			kuf1_treeview.kilv_lv1.setitem(k_ctr, 6, string(kst_tab_armo.dose, "#,##0.00"))
			kuf1_treeview.kilv_lv1.setitem(k_ctr, 7, trim(kst_tab_armo.campione))
			kuf1_treeview.kilv_lv1.setitem(k_ctr, 8, string(kst_tab_armo.peso_kg, "##,##0.00"))

			kuf1_treeview.kilv_lv1.setitem(k_ctr, 9, string(kst_tab_armo.alt_2, "###0") &
									+ "x" + string(kst_tab_armo.lung_2, "###0")  &
									+ "x" + string(kst_tab_armo.larg_2, "###0"))
			
			
			if LenA(trim(kst_tab_sl_pt.cod_sl_pt)) > 0 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 10, trim(kst_tab_sl_pt.cod_sl_pt) &
									 + " " + trim(kst_tab_sl_pt.descr) &
									 + "   dose min-max: " + string(kst_tab_sl_pt.dose_min) &
									 + " - " + string(kst_tab_sl_pt.dose_max) &
									 + "   densita': " + trim(kst_tab_sl_pt.densita) &
									 )
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 10, "---")
			end if

			
			if kst_tab_meca.clie_3 <> kst_tab_meca.clie_2 then
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 11, &
									 + "cliente: " + string(kst_tab_meca.clie_3, "#####") &
									 + " " + trim(kst_tab_clienti.rag_soc_20) &
									 + "  ricev.: " + string(kst_tab_meca.clie_2, "#####") &
									 + " " + trim(kst_tab_clienti.rag_soc_10) &
									 + "  bolla cliente: "  + trim(kst_tab_meca.num_bolla_in) &
									 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") )
			else
				kuf1_treeview.kilv_lv1.setitem(k_ctr, 11, &
									 + "cliente: " + string(kst_tab_meca.clie_3, "#####") &
									 + " " + trim(kst_tab_clienti.rag_soc_20) &
									 + "  bolla cliente: "  + trim(kst_tab_meca.num_bolla_in) &
									 + " " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") )
			end if
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
	end if
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
		kst_treeview_data.oggetto_padre = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_ctr = kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if
	
	 
	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
		
//--- Attivo Drag and Drop 
		kuf1_treeview.kilv_lv1.DragAuto = True 

//--- Attivo multi-selezione delle righe 
		kuf1_treeview.kilv_lv1.extendedselect = true 
			
	end if


 
return k_return

end function

public function integer u_tree_riempi_treeview_righe_rifer (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
//long k_handle_item = 0, k_handle_item_padre = 0, k_handle
integer k_pic_open, k_pic_close, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode=""
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_armo kst_tab_armo
st_tab_arsp kst_tab_arsp
st_tab_arfa kst_tab_arfa
st_tab_prodotti kst_tab_prodotti
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_barcode kst_tab_barcode
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
//listviewitem klvi_listviewitem
kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt

declare kc_treeview cursor for
	SELECT 
         armo.id_armo,
         armo.magazzino,
			armo.campione,
         armo.art,
         prodotti.des_mkt,
         armo.id_meca,   
         meca.num_int,   
         meca.data_int,   
         meca.data_ent,   
			armo.dose,
			armo.larg_2,
			armo.lung_2,
			armo.alt_2,
			armo.colli_2,
			armo.colli_fatt,
			armo.pedane,
			armo.m_cubi,
			armo.peso_kg,
			armo.note_1,
			armo.note_2,
			armo.note_3,
			armo_nt.note_1,
			armo_nt.note_2,
			armo_nt.note_3,
			armo_nt.note_4,
			armo_nt.note_5,
			armo_nt.note_6,
			armo_nt.note_7,
			armo_nt.note_8,
			armo_nt.note_9,
			armo_nt.note_10,
         meca.clie_2, 
         meca.clie_3, 
			meca.num_bolla_in,
			meca.data_bolla_in,
			meca.contratto,
			sl_pt.cod_sl_pt,
			sl_pt.descr,
			sl_pt.densita,
			sl_pt.dose_min,

			sl_pt.dose_max
    FROM (((((((armo LEFT OUTER JOIN meca ON 
	       armo.id_meca = meca.id)
			  inner JOIN clienti c2 ON 
			 meca.clie_2 = c2.codice)
			  inner JOIN clienti c3 ON 
			 meca.clie_3 = c3.codice)
			 LEFT OUTER JOIN contratti ON 
			 meca.contratto = contratti.codice)
			 LEFT OUTER JOIN armo_nt ON 
			 armo.id_armo = armo_nt.id_armo)
			 LEFT OUTER JOIN sl_pt ON 
			 armo.cod_sl_pt = sl_pt.cod_sl_pt)
			  inner JOIN prodotti ON 
			 armo.art = prodotti.codice)
    WHERE 
          armo.num_int = :kst_tab_armo.num_int 
	       and armo.data_int = :kst_tab_armo.data_int
	 order by 
		 armo.art asc ;



		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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
	kst_tab_armo = kst_treeview_data_any.st_tab_armo
	

	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

	
//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			k_pic_open = kst_tab_treeview.pic_open
			k_pic_close = kst_tab_treeview.pic_close
			k_pic_list = kst_tab_treeview.pic_list
		end if
//		k_pic_open = u_dammi_pic_tree_open( k_tipo_oggetto_figlio )
//		k_pic_close = u_dammi_pic_tree_close( k_tipo_oggetto_figlio )

		ktvi_treeviewitem.pictureindex = k_pic_close //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_close)
		ktvi_treeviewitem.selectedpictureindex = k_pic_open //integer(kuf1_treeview.kist_treeview_oggetto.barcode_gia_st_pic_open)


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			
			kuf1_armo = create kuf_armo
			kuf1_sl_pt = create kuf_sl_pt
			
			fetch kc_treeview 
				into
					:kst_tab_armo.id_armo,
					:kst_tab_armo.magazzino,
					:kst_tab_armo.campione,
					:kst_tab_armo.art,
					:kst_tab_prodotti.des,
					:kst_tab_armo.id_meca,   
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_meca.data_ent,   
					:kst_tab_armo.dose,
					:kst_tab_armo.larg_2,
					:kst_tab_armo.lung_2,
					:kst_tab_armo.alt_2,
					:kst_tab_armo.colli_2,
					:kst_tab_armo.colli_fatt,
					:kst_tab_armo.pedane,
					:kst_tab_armo.m_cubi,
					:kst_tab_armo.peso_kg,
					:kst_tab_armo.note_1,
					:kst_tab_armo.note_2,
					:kst_tab_armo.note_3,
					:kst_tab_armo.st_tab_armo_nt.note[1],
					:kst_tab_armo.st_tab_armo_nt.note[2],
					:kst_tab_armo.st_tab_armo_nt.note[3],
					:kst_tab_armo.st_tab_armo_nt.note[4],
					:kst_tab_armo.st_tab_armo_nt.note[5],
					:kst_tab_armo.st_tab_armo_nt.note[6],
					:kst_tab_armo.st_tab_armo_nt.note[7],
					:kst_tab_armo.st_tab_armo_nt.note[8],
					:kst_tab_armo.st_tab_armo_nt.note[9],
					:kst_tab_armo.st_tab_armo_nt.note[10],
					:kst_tab_meca.clie_2, 
					:kst_tab_meca.clie_3, 
					:kst_tab_meca.num_bolla_in,
					:kst_tab_meca.data_bolla_in,
					:kst_tab_meca.contratto,
					:kst_tab_sl_pt.cod_sl_pt,
					:kst_tab_sl_pt.descr,
					:kst_tab_sl_pt.densita,
					:kst_tab_sl_pt.dose_min,
					:kst_tab_sl_pt.dose_max
					  ;
	
	
			
			do while sqlca.sqlcode = 0
				
				
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data.struttura = kst_treeview_data_any

//			   klvi_listviewitem.data = kst_treeview_data

				kuf1_armo.if_isnull_armo(kst_tab_armo)
				kuf1_armo.if_isnull_meca(kst_tab_meca)
				kuf1_sl_pt.if_isnull(kst_tab_sl_pt)
				
				if isnull(kst_tab_clienti.rag_soc_20) then
					kst_tab_clienti.rag_soc_20 = " "
				end if
				if isnull(kst_tab_clienti.rag_soc_10) then
					kst_tab_clienti.rag_soc_10 = " "
				end if
		
				kst_tab_arsp.id_armo = kst_tab_armo.id_armo
				kst_tab_arfa.id_armo = kst_tab_armo.id_armo

				kst_tab_meca.id = kst_tab_armo.id_meca
				kst_tab_meca.num_int = kst_tab_armo.num_int
				kst_tab_meca.data_int = kst_tab_armo.data_int

				kst_tab_barcode.id_armo = kst_tab_armo.id_armo
				kst_tab_barcode.num_int = kst_tab_armo.num_int
				kst_tab_barcode.data_int = kst_tab_armo.data_int

				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_sl_pt = kst_tab_sl_pt
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_arsp = kst_tab_arsp
				kst_treeview_data_any.st_tab_arfa = kst_tab_arfa
				kst_treeview_data_any.st_tab_prodotti = kst_tab_prodotti 
				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = & 
				                      trim(kst_tab_armo.art) & 
					                 + " - " + trim(kst_tab_prodotti.des) & 
					                 + "  (" + string(kst_tab_armo.id_armo) + ") "

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
					:kst_tab_armo.id_armo,
					:kst_tab_armo.magazzino,
					:kst_tab_armo.campione,
					:kst_tab_armo.art,
					:kst_tab_prodotti.des,
					:kst_tab_armo.id_meca,   
					:kst_tab_armo.num_int,   
					:kst_tab_armo.data_int,   
					:kst_tab_meca.data_ent,   
					:kst_tab_armo.dose,
					:kst_tab_armo.larg_2,
					:kst_tab_armo.lung_2,
					:kst_tab_armo.alt_2,
					:kst_tab_armo.colli_2,
					:kst_tab_armo.colli_fatt,
					:kst_tab_armo.pedane,
					:kst_tab_armo.m_cubi,
					:kst_tab_armo.peso_kg,
					:kst_tab_armo.note_1,
					:kst_tab_armo.note_2,
					:kst_tab_armo.note_3,
					:kst_tab_armo.st_tab_armo_nt.note[1],
					:kst_tab_armo.st_tab_armo_nt.note[2],
					:kst_tab_armo.st_tab_armo_nt.note[3],
					:kst_tab_armo.st_tab_armo_nt.note[4],
					:kst_tab_armo.st_tab_armo_nt.note[5],
					:kst_tab_armo.st_tab_armo_nt.note[6],
					:kst_tab_armo.st_tab_armo_nt.note[7],
					:kst_tab_armo.st_tab_armo_nt.note[8],
					:kst_tab_armo.st_tab_armo_nt.note[9],
					:kst_tab_armo.st_tab_armo_nt.note[10],
					:kst_tab_meca.clie_2, 
					:kst_tab_meca.clie_3, 
					:kst_tab_meca.num_bolla_in,
					:kst_tab_meca.data_bolla_in,
					:kst_tab_meca.contratto,
					:kst_tab_sl_pt.cod_sl_pt,
					:kst_tab_sl_pt.descr,
					:kst_tab_sl_pt.densita,
					:kst_tab_sl_pt.dose_min,
					:kst_tab_sl_pt.dose_max
					  ;
	
	
			loop
			
			close kc_treeview;
			
			destroy kuf1_sl_pt
			destroy kuf1_armo

			
		end if
	end if	
 

 
return k_return

end function

public function integer u_tree_riempi_treeview_err_giri (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_list, k_mese, k_anno
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
//st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
//st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo



	k_data_0 = date(0)		 

		 
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

	k_data_a = date(0)
	k_data_da = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
		 then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				k_dataoggi = kguo_g.get_dataoggi( ) 
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

	
		k_query_select = &
		"  	SELECT distinct " &
		+ "	      meca.id, " &
		+ "			meca.num_int, " &
		+ "			meca.data_int, " &
		+ "			meca.data_ent, " &
		+ "			meca.area_mag, " &
		+ "         meca.clie_1,  " &
		+ "         meca.clie_2,  " &
		+ "         meca.clie_3,  " &
		+ "			meca.num_bolla_in, " &
		+ "			meca.data_bolla_in, " &
		+ "         meca_dosim.dosim_data,   " & 
		+ "         meca_dosim.dosim_dose,   " & 
		+ "         meca.err_lav_ok,   " & 
		+ "         meca.note_lav_ok,  " & 
		+ "         meca_dosim.dosim_assorb,   " &
		+ "         meca_dosim.dosim_spessore,   " &
		+ "         meca_dosim.dosim_rapp_a_s,   " &
		+ "         meca_dosim.dosim_lotto_dosim,   " &
		+ "         meca.cert_forza_stampa,   " &
		+ "			armo.magazzino, " &
		+ "			meca.contratto, " &
		+ "			contratti.mc_co, " &
		+ "			contratti.sc_cf, " &
		+ "			contratti.descr, " &
		+ "			artr.num_certif, " &
		+ "		   artr.data_st, " &
		+ "         c1.rag_soc_10, " &
		+ "         c2.rag_soc_10, " &
		+ "         c3.rag_soc_10, " &
		+ "         barcode.fila_1,   " &
		+ "         barcode.fila_1p,   " &
		+ "         barcode.fila_2,   " &
		+ "         barcode.fila_2p,   " &
		+ "         barcode.lav_fila_1,   " &
		+ "         barcode.lav_fila_1p,   " &
		+ "         barcode.lav_fila_2,   " &
		+ "         barcode.lav_fila_2p,   " &
		+ "			barcode.note_lav_fin, " &
		+ "			barcode.err_lav_fin, " &
		+ "			barcode.data_lav_fin " &
		+ "    FROM  (((((((meca LEFT OUTER JOIN armo ON  " &
		+ "	       meca.num_int = armo.num_int and meca.data_int = armo.data_int) " &
		+ "                     inner join barcode on " &
		+ "	       meca.id = barcode.id_meca) " &
		+ "			  inner JOIN clienti c1 ON  " &
		+ "			 meca.clie_1 = c1.codice) " &
		+ "			  inner JOIN clienti c2 ON  " &
		+ "			 meca.clie_2 = c2.codice) " &
		+ "			  inner JOIN clienti c3 ON  " &
		+ "			 meca.clie_3 = c3.codice) " &
		+ "			 LEFT OUTER JOIN contratti ON  " &
		+ "			 meca.contratto = contratti.codice) " &
		+ "			 LEFT OUTER JOIN artr ON  " &
		+ "			 armo.id_armo = artr.id_armo) " 
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett
				k_query_where = " where " &
					+ "  meca.data_int > '31.12.2003' "
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ " and (meca.data_int >= ? and meca.data_int < ?) "
				end if
				k_query_where = k_query_where &
					+ " and barcode.err_lav_fin = '1' "
					
			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett
				k_query_where = " where " 
				if k_data_a  <> k_data_0 then
					k_query_where = k_query_where &
					+ "  (meca.data_int >= ? and meca.data_int < ?) and "
				end if
				k_query_where = k_query_where &
					+ "  (meca.err_lav_ok = '1' or " &
					+ " ( meca.data_int > '31.12.2003' and meca.err_lav_fin = '1') )"
					
			case else
					k_query_where = " "
	
		end choose
	
			
		k_query_order = &
		+ "	 order by " &
		+ "		 meca.data_ent, meca.data_int, meca.num_int "
	
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		

			 
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview;
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview;
				end if
	
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode = 0 then

			kuf1_armo = create kuf_armo
			kuf1_barcode = create kuf_barcode
			
			fetch kc_treeview 
				into
					 :kst_tab_meca.id   
					 ,:kst_tab_meca.num_int   
					 ,:kst_tab_meca.data_int   
					 ,:kst_tab_meca.data_ent   
					 ,:kst_tab_meca.area_mag   
					 ,:kst_tab_meca.clie_1  
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
         		 ,:kst_tab_meca.err_lav_ok   
         		 ,:kst_tab_meca.note_lav_ok  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
         		 ,:kst_tab_meca.cert_forza_stampa  
         		 ,:kst_tab_armo.magazzino  
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_certif.num_certif
					 ,:kst_tab_certif.data
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_11 
					 ,:kst_tab_clienti.rag_soc_20 
        			 ,:kst_tab_barcode.fila_1  
         		 ,:kst_tab_barcode.fila_1p   
         		 ,:kst_tab_barcode.fila_2  
         		 ,:kst_tab_barcode.fila_2p  
         		 ,:kst_tab_barcode.lav_fila_1  
         		 ,:kst_tab_barcode.lav_fila_1p  
         		 ,:kst_tab_barcode.lav_fila_2  
         		 ,:kst_tab_barcode.lav_fila_2p  
					 ,:kst_tab_barcode.note_lav_fin
					 ,:kst_tab_barcode.err_lav_fin
					 ,:kst_tab_barcode.data_lav_fin
					  ;
	
//					 ,:kst_tab_barcode.data
			
			do while sqlca.sqlcode = 0
	
		  		if isnull(kst_tab_contratti.codice) then
					kst_tab_contratti.codice = 0
				end if
			   if isnull(kst_tab_contratti.sc_cf) then
					kst_tab_contratti.sc_cf = " "
				end if
	 		   if isnull(kst_tab_contratti.mc_co) then
					kst_tab_contratti.mc_co = " "
				end if
		      if isnull(kst_tab_contratti.descr) then
					kst_tab_contratti.descr = " "
				end if
				kuf1_armo.if_isnull_meca(kst_tab_meca)
				kuf1_barcode.if_isnull(kst_tab_barcode)
				
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int
				
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode

				kst_tab_treeview.voce =  &
				                    string(kst_tab_meca.num_int, "####0") &
				                    + " - " + string(kst_tab_meca.data_ent, "dd.mmm") &
										  + " --> " + string(trim(kst_tab_meca.area_mag), "@@ @@@@@@@@@@")
				kst_tab_treeview.descrizione_tipo = &
					                 " Mag. " &
				         		     + string(kst_tab_armo.magazzino)  

				                               
				if kst_tab_certif.num_certif > 0 then
					kst_tab_treeview.descrizione_tipo = &
					                 kst_tab_treeview.descrizione_tipo &
					                 + " Cert. " &
				                    + string(kst_tab_certif.num_certif, "####0") + " " &
				                    + string(kst_tab_certif.data, "dd.mmm") + "  "
				end if
				kst_tab_treeview.descrizione_tipo = &
                 					  kst_tab_treeview.descrizione_tipo & 
										  + " Contr. " + string(kst_tab_contratti.codice, "####0") &
										  + " SC-CF " + kst_tab_contratti.sc_cf &
				                    + " MC-CO " + kst_tab_contratti.mc_co &
										  + " " + trim(kst_tab_contratti.descr)

				kst_tab_treeview.descrizione = "Da Trattare" 
				if kst_tab_barcode.data_lav_fin > KKG.DATA_ZERO then
					if kst_tab_barcode.err_lav_fin = "1" and kst_tab_meca.err_lav_ok = "1" then
						kst_tab_treeview.descrizione = "Lavorazione e Dosimetria KO! " 
					else
						if kst_tab_barcode.err_lav_fin = "1" then
							kst_tab_treeview.descrizione = "Lavorazione KO!  " 
						else
							kst_tab_treeview.descrizione = "Lavorazione OK  " 
						end if
					end if
				else
					kst_tab_treeview.descrizione = "Da Trattare  " 
				end if
					
				if kst_tab_meca.st_tab_meca_dosim.dosim_data > KKG.DATA_ZERO then
					if kst_tab_barcode.err_lav_fin = "1" and kst_tab_meca.err_lav_ok = "1" then
					else
						if kst_tab_meca.err_lav_fin = "1" then
							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Dosimetria KO! " 
						else
							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Dosimetria OK " 
						end if
					end if
				else
					kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "Da Convalidare " 
				end if
				
				if kst_tab_barcode.data_lav_fin > date (0) then
					if LenA(trim(kst_tab_barcode.note_lav_fin)) = 0 then
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  + " giri " 
						if kst_tab_barcode.lav_fila_1 > 0 or kst_tab_barcode.lav_fila_1p > 0 then
							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  + string(kst_tab_barcode.lav_fila_1, "##0") &
												  + "+" + string(kst_tab_barcode.lav_fila_1p, "##0") 
						end if
						if kst_tab_barcode.lav_fila_2 > 0 or kst_tab_barcode.lav_fila_2p > 0 then
							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  + string(kst_tab_barcode.lav_fila_2, "##0") &
												  + "+" + string(kst_tab_barcode.lav_fila_2p, "##0") 
						end if
					else
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
											  + "  Note: " + trim(kst_tab_barcode.note_lav_fin) 
					end if
				end if
				
				if kst_tab_meca.st_tab_meca_dosim.dosim_data > date (0) then
					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) + "   Dati dosim. " & 
											  + " ass." + string(kst_tab_meca.st_tab_meca_dosim.dosim_assorb, "##,###") &
											  + " / sp." + string(kst_tab_meca.st_tab_meca_dosim.dosim_spessore, "##,###") &
											  + " = " + string(kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s, "##,##0.000") &
											  + " del " + string(kst_tab_meca.st_tab_meca_dosim.dosim_data, "dd.mm.yy") &
											  + " lotto " + trim(kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim) 
					if kst_tab_meca.st_tab_meca_dosim.dosim_dose > 0 then
						kst_tab_treeview.descrizione = kst_tab_treeview.descrizione &
										+ "  Dose Irragg. " + string(kst_tab_meca.st_tab_meca_dosim.dosim_dose, "#0.00") + " "
					end if
					kst_tab_treeview.descrizione = kst_tab_treeview.descrizione + "   Note: " + trim(kst_tab_meca.note_lav_ok) 
				else
					kst_tab_treeview.descrizione = "Da convalidare " 
				end if
				kst_tab_treeview.descrizione_ulteriore =  &
				                    "Bolla cliente " + trim(kst_tab_meca.num_bolla_in) &
				                    + " - " + string(kst_tab_meca.data_bolla_in, "dd.mm.yy") 
										  
				kst_tab_treeview.descrizione_ulteriore = &
											  trim(kst_tab_treeview.descrizione_ulteriore) &
				                       + "  Mand. " + string(kst_tab_meca.clie_1, "####0") &
											  + " " + trim(kst_tab_clienti.rag_soc_10) &
											  + " Ricev. " + string(kst_tab_meca.clie_2, "####0") + " " + trim(kst_tab_clienti.rag_soc_11) &
											  + " Fatt. " + string(kst_tab_meca.clie_3, "####0") + " " + trim(kst_tab_clienti.rag_soc_20)
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = &
				                      string(kst_tab_meca.num_int, "####0") &
				                    + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
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
	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
				into
					 :kst_tab_meca.id   
					 ,:kst_tab_meca.num_int   
					 ,:kst_tab_meca.data_int   
					 ,:kst_tab_meca.data_ent   
					 ,:kst_tab_meca.area_mag   
					 ,:kst_tab_meca.clie_1  
					 ,:kst_tab_meca.clie_2  
					 ,:kst_tab_meca.clie_3  
					 ,:kst_tab_meca.num_bolla_in 
					 ,:kst_tab_meca.data_bolla_in 
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					 ,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
         		 ,:kst_tab_meca.err_lav_ok   
         		 ,:kst_tab_meca.note_lav_ok  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
         		 ,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
         		 ,:kst_tab_meca.cert_forza_stampa  
         		 ,:kst_tab_armo.magazzino  
					 ,:kst_tab_contratti.codice
					 ,:kst_tab_contratti.mc_co
					 ,:kst_tab_contratti.sc_cf
					 ,:kst_tab_contratti.descr
					 ,:kst_tab_certif.num_certif
					 ,:kst_tab_certif.data
					 ,:kst_tab_clienti.rag_soc_10 
					 ,:kst_tab_clienti.rag_soc_11 
					 ,:kst_tab_clienti.rag_soc_20 
        			 ,:kst_tab_barcode.fila_1  
         		 ,:kst_tab_barcode.fila_1p   
         		 ,:kst_tab_barcode.fila_2  
         		 ,:kst_tab_barcode.fila_2p  
         		 ,:kst_tab_barcode.lav_fila_1  
         		 ,:kst_tab_barcode.lav_fila_1p  
         		 ,:kst_tab_barcode.lav_fila_2  
         		 ,:kst_tab_barcode.lav_fila_2p  
					 ,:kst_tab_barcode.note_lav_fin
					 ,:kst_tab_barcode.err_lav_fin
					 ,:kst_tab_barcode.data_lav_fin
					 ;
	
			loop
			
			close kc_treeview;

			destroy kuf1_armo
			destroy kuf1_barcode
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_err_giri_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio, k_err_lav_ok, k_err_lav_fin
date k_save_data_int
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
string k_err_lav_fin_ko
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any, kst_treeview_data_any_save
kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim


k_err_lav_fin_ko = kiuf_armo.ki_err_lav_fin_ko

declare kc_treeview cursor for
	SELECT 
         count (*), 
         month(meca.data_int) as mese,   
         year(meca.data_int) as anno   
     FROM meca
    WHERE 
     		meca.data_int > '31.12.2003'
			and
			(
			  (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri
				and meca.err_lav_fin = :k_err_lav_fin_ko
		     )
			  or
			  (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all
 				and 
					  (meca.err_lav_ok =  :k_err_lav_ok
					  or meca.err_lav_fin =:k_err_lav_fin  ) 
			  )
			)
		 group by  month(meca.data_int), year(meca.data_int)
		 order by  3 desc, 2 desc;


	k_err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut 
	k_err_lav_fin = kuf1_armo.ki_err_lav_fin_ko
		 
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
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[Completa]"
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

			k_totale = 0
			k_anno_old = 0
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			
					if k_totale > 0 then
						k_mese_desc[0] = "[riep-Anno]"
						kst_treeview_data_any_save = kst_treeview_data_any
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
						k_totale = 0
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data_any = kst_treeview_data_any_save
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_meca.data_int = date(0)
					kst_treeview_data_any.st_tab_meca.num_int = k_anno
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_meca.data_int = date(k_anno,01,01)
				else			
					kst_tab_meca.data_int = date(k_anno,k_mese,01)
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carico presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carichi presenti"
				end if
			  	if k_tipo_oggetto_padre = kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri then
					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
						                               + " con numero cicli non previsti!  "
				else
					kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
						                               + " con Anomalia  "
				end if
				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data.struttura = kst_treeview_data_any

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

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_da_conv_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview 
//--- merce in attesa di Convalida Dosimetrica
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
boolean k_prima_volta
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



declare kc_treeview cursor for
	SELECT 
         count (distinct meca.id), 
         month(meca.data_int) as mese,   
         year(meca.data_int) as anno   
     FROM meca inner join armo on meca.id = armo.id_meca 
	            inner join artr on armo.id_armo = artr.id_armo 
    WHERE meca.data_int >= '03.03.2004' 
			 and (err_lav_ok = '0' or err_lav_ok is null)
		 group by  month(meca.data_int), year(meca.data_int)
		 order by  3 desc, 2 desc;
//			 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null)

		 
		 
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
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list 
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[Completa]"
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

			k_totale = 0
			k_anno_old = 0
			k_prima_volta = true
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old and not k_prima_volta then
			
					if k_totale > 0 then
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
						k_totale = 0
						kst_treeview_data_any.st_tab_meca.num_int = k_anno_old
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
					end if
					k_prima_volta = false
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_meca.data_int = date(0)
					kst_treeview_data_any.st_tab_meca.num_int = k_anno
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_meca.data_int = date(k_anno,01,01)
				else			
					kst_tab_meca.data_int = date(k_anno,k_mese,01)
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carico presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Carichi presenti"
				end if
				kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
						                               + " in attesa di convalida dosimetrica "

				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data.struttura = kst_treeview_data_any

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

				fetch kc_treeview 
					into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			loop

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_dosim_stato=" "
date k_save_data_int, k_data_da, k_data_a, k_dataoggi, k_data_meno365
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any, kst_treeview_data_any_save
kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim


declare kc_treeview cursor for
	SELECT 
         count (meca.id), 
         month(meca.data_int) as mese,   
         year(meca.data_int) as anno   
     FROM meca
    WHERE 
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_anno_mese
		  and meca.data_int between :k_data_da and :k_data_a)
		 or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_stor_mese
		  and meca.data_int < :k_data_da )
		or
		 (meca.data_int > '01.01.2003'
		 			 
		  and (
			 	 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ko
			     and  meca.err_lav_ok = :k_dosim_stato)
			    or
			    (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok
			     and  meca.err_lav_ok = :k_dosim_stato)
				)
		 )
		or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese
		  and (meca.clie_1 = :kst_treeview_data_any.st_tab_clienti.codice
		         or meca.clie_2 = :kst_treeview_data_any.st_tab_clienti.codice
		         or meca.clie_3 = :kst_treeview_data_any.st_tab_clienti.codice)
		  and meca.data_int < :k_data_meno365 )
		or
		 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese
		  and (meca.clie_1 = :kst_treeview_data_any.st_tab_clienti.codice
		         or meca.clie_2 = :kst_treeview_data_any.st_tab_clienti.codice
		         or meca.clie_3 = :kst_treeview_data_any.st_tab_clienti.codice)
		  and meca.data_int >= :k_data_meno365 )
		 group by  month(meca.data_int), year(meca.data_int)
		 order by  3 desc, 2 desc; 




//			     and dosim_assorb > 0 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null))
//		:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_mese
//		 or
		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle
	kst_treeview_data_any = kst_treeview_data.struttura

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
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
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
		k_dataoggi = kguo_g.get_dataoggi( )

//--- calcolo periodo
		k_anno = year(k_dataoggi) - 1
		k_mese = month(k_dataoggi)
		k_data_da = date (k_anno, k_mese, 01) 
		k_data_a = k_dataoggi 
//--- imposto lo stato della dosimetria da cercare
		if k_tipo_oggetto_padre = kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ko then
			k_dosim_stato = kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc
		else
			if k_tipo_oggetto_padre = kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok then 
			   k_dosim_stato = kuf1_meca_dosim.ki_err_lav_ok_conv_aut_ok
			end if
		end if

		k_data_meno365 = relativedate(k_dataoggi, -365)
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[ult-settimana]"
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

			k_totale = 0
			k_anno_old = 0
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			
					if k_totale > 0 then
						k_mese_desc[0] = "[Anno]"
						kst_treeview_data_any_save = kst_treeview_data_any
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  carichi presenti nell'anno"
						k_totale = 0
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data_any = kst_treeview_data_any_save
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Riferimenti " 
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_meca.data_int = date(0)
					kst_treeview_data_any.st_tab_meca.num_int = k_anno
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_meca.data_int = date(k_anno,01,01)
				else			
					kst_tab_meca.data_int = date(k_anno,k_mese,01)
				end if
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  carico presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  carichi presenti"
				end if
				choose case k_tipo_oggetto_padre
//					case kuf1_treeview.kist_treeview_oggetto.meca_mese
//						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) 
					case kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
						                               + " con convalida dosimetrica esitata "
					case kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ko
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
						                               + " con convalida dosimetrica fallita! "
				end choose

				kst_tab_treeview.descrizione_tipo = "Riferimenti " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data.struttura = kst_treeview_data_any

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

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Carichi presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_lav_ok (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_dataoggix
string k_tipo_record
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_barcode kst_tab_barcode, kst_tab_barcode_nullo
kuf_base kuf1_base



declare kc_treeview cursor for
	SELECT distinct
	      'dosimetria',
			meca.num_int,
			meca.data_int,
         dosim_data,   
         dosim_dose,   
         meca.err_lav_ok,   
         meca.note_lav_ok,
         meca_dosim.dosim_assorb,  
         meca_dosim.dosim_spessore,  
         meca_dosim.dosim_rapp_a_s,  
         meca_dosim.dosim_lotto_dosim,  
			convert(date,'01.01.2017'),
			'0',
			' ',
			0,
			0,
			0,
			0
		  ,coalesce(meca.e1doco,0) as e1doco
		  ,coalesce(meca.e1rorn,0) as e1rorn
    FROM meca left outer join meca_dosim on
	      meca.id = meca_dosim.id_meca
    WHERE 
		  	meca.id = :kst_treeview_data_any.st_tab_meca.id
	union all
	SELECT distinct 
	      'lavorazione',
			barcode.num_int,
			barcode.data_int,
			convert(date,'01.01.2017'),
			0,
			'0',
			' ',
			0,
			0,
			0,
			' ',
			barcode.data_lav_fin,
			barcode.err_lav_fin,
			barcode.note_lav_fin,
         barcode.lav_fila_1,  
         barcode.lav_fila_1p,  
         barcode.lav_fila_2,  
         barcode.lav_fila_2p
			,0
			,0
    FROM barcode 
    WHERE 
		  	barcode.id_meca = :kst_treeview_data_any.st_tab_meca.id
	 using kguo_sqlca_db_magazzino ;

		 
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre =  k_tipo_oggetto
	end if

	
//--- valorizzo campi tabella
	kst_treeview_data_any = kst_treeview_data.struttura
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if (k_handle_item_figlio <= 0 or  kuf1_treeview.ki_forza_refresh =  kuf1_treeview.ki_forza_refresh_si) &
		and kst_treeview_data_any.st_tab_meca.id > 0 then
		
//--- Imposta le propietà di default della tree 
		 kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto_padre, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito =  kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		 kuf1_treeview.u_delete_item_child(k_handle_item_padre)
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					 :k_tipo_record
					,:kst_tab_meca.num_int   
					,:kst_tab_meca.data_int   
         		,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
         		,:kst_tab_meca.err_lav_ok   
         		,:kst_tab_meca.note_lav_ok  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
         		,:kst_tab_barcode.data_lav_fin   
         		,:kst_tab_barcode.err_lav_fin   
         		,:kst_tab_barcode.note_lav_fin  
					,:kst_tab_barcode.lav_fila_1  
					,:kst_tab_barcode.lav_fila_1p  
					,:kst_tab_barcode.lav_fila_2  
					,:kst_tab_barcode.lav_fila_2p  
					,:kst_tab_meca.e1doco
					,:kst_tab_meca.e1rorn
					  ;
	
			
			do while sqlca.sqlcode = 0

//--- tratto i dati barcode
				if k_tipo_record = "lavorazione" then			
					kst_tab_barcode.num_int = kst_tab_meca.num_int   
					kst_tab_barcode.data_int = kst_tab_meca.data_int   
				else
					kst_tab_barcode = kst_tab_barcode_nullo
				end if

		  		if isnull(kst_tab_meca.num_int) then
					kst_tab_meca.num_int = 0
				end if
		      if isnull(kst_tab_meca.note_lav_ok) then
					kst_tab_meca.note_lav_ok = " "
				end if
		      if isnull(kst_tab_meca.err_lav_ok) then
					kst_tab_meca.err_lav_ok = "0"
				end if
		      if isnull(kst_tab_meca.st_tab_meca_dosim.dosim_dose) then
					kst_tab_meca.st_tab_meca_dosim.dosim_dose = 0
				end if
		      if isnull(kst_tab_meca.st_tab_meca_dosim.dosim_data) then
					kst_tab_meca.st_tab_meca_dosim.dosim_data = date(0)
				end if
				
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_barcode = kst_tab_barcode

				kst_tab_treeview.voce =  &
				                    string(kst_tab_meca.num_int, "####0") &
				                    + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") 
				
				if k_tipo_record = "dosimetria" then			
					kst_tab_treeview.descrizione_tipo = "Dati Dosimetria" 
				else
					kst_tab_treeview.descrizione_tipo = "Dati Giri di lavorazione" 
				end if

//---
				if k_tipo_record = "lavorazione" then			
					if kst_tab_barcode.data_lav_fin > date (0) then
						if kst_tab_barcode.err_lav_fin = "1" then
							if kst_tab_meca.cert_forza_stampa = "1" then
								kst_tab_treeview.descrizione = "Lavorazione KO->OK " 
							else
								kst_tab_treeview.descrizione = "Lavorazione KO! " 
							end if
						else
							kst_tab_treeview.descrizione = "Lavorazione esitata il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yy") 
						end if
					else
						kst_tab_treeview.descrizione = "Da trattare " 
					end if
				else
					if kst_tab_meca.st_tab_meca_dosim.dosim_data > date (0) then
						if kst_tab_meca.err_lav_ok = "1" then
							if kst_tab_meca.cert_forza_stampa = "1" then
								kst_tab_treeview.descrizione = "Dosimetria KO->OK " 
							else
								kst_tab_treeview.descrizione = "Dosimetria KO! " 
							end if
						else
							kst_tab_treeview.descrizione = "Dosimetria convalidata il " + string(kst_tab_meca.st_tab_meca_dosim.dosim_data, "dd/mm/yy") 
						end if
					else
						kst_tab_treeview.descrizione = "Dosimetria da convalidare " 
					end if
				end if
				
				if k_tipo_record = "lavorazione" then			
					if kst_tab_barcode.data_lav_fin > date (0) then
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  + "  giri " 
						if kst_tab_barcode.lav_fila_1 > 0 or kst_tab_barcode.lav_fila_1p > 0 then
							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  + " " + string(kst_tab_barcode.lav_fila_1, "##0") &
												  + "+" + string(kst_tab_barcode.lav_fila_1p, "##0") 
						end if
						if kst_tab_barcode.lav_fila_2 > 0 or kst_tab_barcode.lav_fila_2p > 0 then
							kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) &
												  +  " " + string(kst_tab_barcode.lav_fila_2, "##0") &
												  + "+" + string(kst_tab_barcode.lav_fila_2p, "##0") 
						end if
					end if
					kst_tab_treeview.descrizione_ulteriore =  &
											  + "Note: " + trim(kst_tab_barcode.note_lav_fin) 

				else
				
					if kst_tab_meca.st_tab_meca_dosim.dosim_data > date (0) then
						kst_tab_treeview.descrizione = trim(kst_tab_treeview.descrizione) + "   Dati dosim. " & 
												  + " ass." + string(kst_tab_meca.st_tab_meca_dosim.dosim_assorb, "##,###") &
												  + " / sp." + string(kst_tab_meca.st_tab_meca_dosim.dosim_spessore, "##,###") &
												  + " = " + string(kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s, "##,##0.000") &
												  + " del " + string(kst_tab_meca.st_tab_meca_dosim.dosim_data, "dd.mm.yy") &
												  + " lotto " + trim(kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim) 
						if kst_tab_meca.st_tab_meca_dosim.dosim_dose > 0 then
							kst_tab_treeview.descrizione = kst_tab_treeview.descrizione &
											+ "  Dose Irragg. " + string(kst_tab_meca.st_tab_meca_dosim.dosim_dose, "#0.00") + " "
						end if
						kst_tab_treeview.descrizione_ulteriore =  &
											+ "   Note: " + trim(kst_tab_meca.note_lav_ok) 
					end if
				end if
				
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				if k_tipo_record = "lavorazione" then			
					if kst_tab_barcode.data_lav_fin > date (0) then
						if kst_tab_barcode.err_lav_fin = "1" then
							if kst_tab_meca.cert_forza_stampa = "1" then
				
								kst_treeview_data.label = "Lavorazione KO->OK " 
							else
								kst_treeview_data.label = "Lavorazione KO! " 
							end if
						else
							kst_treeview_data.label = "Lavorazione ok "
						end if
					else
						kst_treeview_data.label = "Da trattare " 
					end if
				else
					if kst_tab_meca.st_tab_meca_dosim.dosim_data > date (0) then
						if kst_tab_meca.err_lav_ok = "1" then
							if kst_tab_meca.cert_forza_stampa = "1" then
								kst_treeview_data.label = "Dosimetria KO->OK " 
							else
								kst_treeview_data.label = "Dosimetria KO! " 
							end if
						else
							kst_treeview_data.label = "Dosimetria ok " 
						end if
					else
						kst_treeview_data.label = "Dosimetria da convalidare " 
					end if
				end if

				kst_treeview_data.oggetto = k_tipo_oggetto 
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
					 :k_tipo_record
					,:kst_tab_meca.num_int   
					,:kst_tab_meca.data_int   
         		,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
					,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
         		,:kst_tab_meca.err_lav_ok   
         		,:kst_tab_meca.note_lav_ok  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
					,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
         		,:kst_tab_barcode.data_lav_fin   
         		,:kst_tab_barcode.err_lav_fin   
         		,:kst_tab_barcode.note_lav_fin  
					,:kst_tab_barcode.lav_fila_1  
					,:kst_tab_barcode.lav_fila_1p  
					,:kst_tab_barcode.lav_fila_2  
					,:kst_tab_barcode.lav_fila_2p  
					,:kst_tab_meca.e1doco
					,:kst_tab_meca.e1rorn
					  ;
	
	
			loop
			
			close kc_treeview;
		end if

	end if 
 
return k_return


end function

public function boolean link_call (ref datawindow kdw_1, string k_campo_link) throws uo_exception;//
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
st_tab_armo kst_tab_armo
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_meca kst_tab_meca
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
//kuf_armo kuf1_armo
kuf_armo_prezzi kuf1_armo_prezzi
kuf_menu_window kuf1_menu_window
kuf_sicurezza kuf1_sicurezza
pointer kp_oldpointer


kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.elenco

choose case k_campo_link

	case "num_int", "num_int_t", "id_meca", "b_meca", "meca_id"

		if  trim(kdw_1.describe("id_meca.x")) <> "!" then
			kst_tab_meca.id = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")
			if kst_tab_meca.id > 0 then
				kst_open_w.key1 = "Lotto (id=" + trim(string(kst_tab_meca.id))  + ") "
				k_id_programma = this.get_id_programma(kst_open_w.flag_modalita)
			else
				k_return = false
			end if
		else
			k_return = false
		end if


	case "id_meca_righe"

		kst_tab_armo.id_armo = 0
		kst_tab_armo.id_meca = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")
		if kst_tab_armo.id_meca > 0 then
			kst_open_w.key1 = "Dettaglio Righe Lotto  (id lotto=" + trim(string(kst_tab_armo.id_meca)) + ") " 
			k_id_programma = this.get_id_programma(kst_open_w.flag_modalita)
		else
			k_return = false
		end if


	case "b_armo", "id_armo"
		kst_tab_armo.id_meca = 0
		kst_tab_armo.id_armo = kdw_1.getitemnumber(kdw_1.getrow(), "id_armo")

		if kst_tab_armo.id_armo > 0 then
			kst_open_w.key1 = "Dettaglio Riga Lotto  (id riga=" + trim(string(kst_tab_armo.id_armo)) + ") " 
			k_id_programma = this.get_id_programma(kst_open_w.flag_modalita)
		else
			k_return = false
		end if


	case "b_armo_prezzi", "id_armo_prezzo", "b_armo_prezzi_xstato"
		kuf1_armo_prezzi = create kuf_armo_prezzi
		kuf1_armo_prezzi.link_call(kdw_1, k_campo_link )
		k_return = false

		
	case "p_meca_memo_elenco"
		kst_tab_meca.id = kdw_1.getitemnumber(kdw_1.getrow(), "id_meca")
		if kst_tab_meca.id > 0 then
//			kuf1_armo = create kuf_armo
			kst_esito = kiuf_armo.anteprima_elenco_memo( kdsi_elenco_output, kst_tab_meca )
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Fascicoli Memo Lotto id=" + trim(string(kst_tab_meca.id)) + " " 
		else
			k_return = false
		end if

end choose


if k_return then

	kst_open_w.id_programma = k_id_programma 
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Elenco non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
			kdsi_elenco_output.dataobject = k_dataobject		
			kdsi_elenco_output.settransobject(sqlca)
	
			kdsi_elenco_output.reset()	
			
			choose case k_campo_link

				case "id_meca", "b_meca", "num_int", "num_int_t"
					if kdw_1.dataobject = "d_meca_1" or kdw_1.dataobject = "d_meca_1_anteprima" then
						kst_esito = kiuf_armo.anteprima_a_righe ( kdsi_elenco_output, kst_tab_meca )
					else
						kst_esito = kiuf_armo.anteprima ( kdsi_elenco_output, kst_tab_meca )
					end if

				case "meca_id"
					kst_esito = kiuf_armo.anteprima_testa ( kdsi_elenco_output, kst_tab_meca )

				case else				
					kst_esito = kiuf_armo.anteprima_riga ( kdsi_elenco_output, kst_tab_armo )
			
			end choose
			
			if kst_esito.esito <> kkg_esito.ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			k_dataobject = kdsi_elenco_output.dataobject
	
//		else
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Nessuna dato da visualizzare: ~n~r" + "nessun codice indicato"
//			kst_esito.esito = kkg_esito.not_fnd
//			
//		end if
	end if
	


	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma =kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


//	else
//		
//		kuo_exception = create uo_exception
//		kuo_exception.setmessage( "Nessun valore disponibile. " )
//		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function string get_id_programma (string k_flag_modalita);//

return kiuf_armo.get_id_programma( k_flag_modalita )






end function

public function integer u_tree_riempi_treeview_testa_blk (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi, k_datameno2anni, k_datameno1anni, k_datameno3anni, k_datameno3Mesi
boolean k_nuovo_item=true
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
kuf_armo kuf1_armo



	kuf1_armo = create kuf_armo

	k_data_0 = date(0)		 
//--- data oggi
	k_dataoggi = kguo_g.get_dataoggi( )
		 
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

	k_data_da = date(0)
	k_data_a = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
		 then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		if k_data_da <> date(0) then
			k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
		end if
	end if

	k_datameno3anni = RelativeDate(k_dataoggi, -1100) 		 
	k_datameno2anni = RelativeDate(k_dataoggi, -730) 		 
	k_datameno1anni = RelativeDate(k_dataoggi, -365) 		 
	k_datameno3Mesi =  RelativeDate(k_dataoggi, -90) 		 
	if k_data_a = date(0) then
		k_data_a = k_dataoggi
	end if
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
		if DaysAfter ( k_data_da, k_data_a ) > 61 then
			kst_tab_meca.clie_1 =0
			kst_tab_meca.clie_2 =0
			kst_tab_meca.clie_3 =0
			kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
			if kst_esito.esito = kkg_esito.ok then
				k_data_a = kst_tab_meca.data_int
				k_data_da = relativedate(k_data_a , -7)
			else
				//--- se errore non vedo NULLA!
				k_data_da = k_data_a
			end if
		end if

		k_query_select = &
					"SELECT  " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.area_mag, " &
					+ "meca.clie_1,  " &
					+ "meca.clie_2,  " &
					+ "meca.clie_3,  " &
					+ "meca.num_bolla_in, " &
					+ "meca.data_bolla_in, " &
					+ "meca.data_lav_fin,    " &
					+ "meca.err_lav_fin,    " &
					+ "meca.err_lav_ok,    " &
					+ "meca.cert_forza_stampa,   " &
					+ "meca.stato,   " &
					+ "meca.contratto, " &
					+ "meca_blk.id_meca_causale, "  &
					+ "meca_blk.rich_autorizz, " &
					+ "meca_blk.descrizione, " &
					+ "meca_causali.cod_blk, " &
					+ "c1.rag_soc_10, " &
					+ "c3.rag_soc_10 " &
					+ ",meca.e1doco " &
					+ ",meca.e1rorn " &
					+ "FROM  meca  " & 
					 + "    inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " &
					 + "    inner JOIN clienti c3 ON  " &
					 + "meca.clie_3 = c3.codice "  &
					 + "    left outer JOIN meca_blk ON  " &
					 + "meca.id = meca_blk.id_meca " &
					 + "    inner JOIN meca_causali ON  " &
					 + "meca_blk.id_meca_causale = meca_causali.id_meca_causale "  &
					 

		choose case k_tipo_oggetto
				
					
			case kuf1_treeview.kist_treeview_oggetto.meca_blk_dett
				k_query_where = " where " &
					+ "  meca.data_int between '" + string(k_datameno2anni) + "' and '" + string(k_data_a) + "' " &
					+ " and meca.aperto not in ('" + string(kuf1_armo.kki_meca_aperto_no) + "', '" + string(kuf1_armo.kki_meca_aperto_annullato) + "') "&
					+ " and (meca.stato = " + string(kuf1_armo.ki_meca_stato_blk) &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_sblk) &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_blk_con_controllo) + " " &
				 	+ "      or meca.stato = " + string(kuf1_armo.ki_meca_stato_gen_da_completare ) + ") "

			case else
					k_query_where = " "
	
		end choose
	
		k_query_order += &
			+ " order by  " &
			+ " meca.data_ent desc, meca.data_int desc, meca.num_int desc " 
		 
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
			 

		choose case k_tipo_oggetto
				

			case  &
				 kuf1_treeview.kist_treeview_oggetto.meca_blk_dett
				open dynamic kc_treeview;
				
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode = 0 then

			fetch kc_treeview 
					into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.area_mag   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.data_lav_fin   
						 ,:kst_tab_meca.err_lav_fin   
						 ,:kst_tab_meca.err_lav_ok   
						 ,:kst_tab_meca.cert_forza_stampa  
						 ,:kst_tab_meca.stato
						 ,:kst_tab_contratti.codice
						,:kst_tab_meca.id_meca_causale
						,:kst_tab_meca.meca_blk_rich_autorizz
						,:kst_tab_meca.meca_blk_descrizione
						,:kst_tab_meca.cod_blk 
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_meca.e1doco   
						 ,:kst_tab_meca.e1rorn   
						  ;
			
			do while sqlca.sqlcode = 0
	
	
		  		if isnull(kst_tab_contratti.codice) then
					kst_tab_contratti.codice = 0
				end if
			  	if isnull(kst_tab_meca.cod_blk) then
					kst_tab_meca.cod_blk = 0
				end if
	 		   	if isnull(kst_tab_meca.meca_blk_rich_autorizz) then
					kst_tab_meca.meca_blk_rich_autorizz = ""
				end if
		      	if isnull(kst_tab_meca.meca_blk_descrizione) then
					kst_tab_meca.meca_blk_descrizione = ""
				end if

				kuf1_armo.if_isnull_meca(kst_tab_meca)				
				
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int
				
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti

				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = &
				                      string(kst_tab_meca.num_int, "####0") &
				                    + " - " + string(kst_tab_meca.data_int, "dd.mmm") &
										  + " "  &
										  + trim(kst_tab_clienti.rag_soc_10) 
//										  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
//										  + string(kst_tab_meca.clie_3, "#####") + ")"

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
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.area_mag   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.data_lav_fin   
						 ,:kst_tab_meca.err_lav_fin   
						 ,:kst_tab_meca.err_lav_ok   
						 ,:kst_tab_meca.cert_forza_stampa  
						 ,:kst_tab_meca.stato
						 ,:kst_tab_contratti.codice
						,:kst_tab_meca.id_meca_causale
						,:kst_tab_meca.meca_blk_rich_autorizz
						,:kst_tab_meca.meca_blk_descrizione
						,:kst_tab_meca.cod_blk 
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_meca.e1doco   
						 ,:kst_tab_meca.e1rorn   
							  ;
	
			loop
			
			close kc_treeview;
			
		end if

	end if 

	destroy kuf1_armo

return k_return


end function

public function integer u_tree_riempi_treeview_smista (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
int k_return = 0
 

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_car_meca_dett &
					,kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett &
					,kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett  &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_dett_id_meca &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_trasferiti_dapkl 
				k_return = u_tree_riempi_treeview_testa ( kuf1_treeview, k_tipo_oggetto )

			case kuf1_treeview.kist_treeview_oggetto.meca_dett_nodose
				k_return = u_tree_riempi_treeview_testa_nodose( kuf1_treeview, k_tipo_oggetto )

			case kuf1_treeview.kist_treeview_oggetto.meca_blk_dett
				k_return = u_tree_riempi_treeview_testa_blk( kuf1_treeview, k_tipo_oggetto )
			
			case kuf1_treeview.kist_treeview_oggetto.meca_qtna_dett
				k_return = u_tree_riempi_treeview_testa_qtna( kuf1_treeview, k_tipo_oggetto )

			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett
				k_return = u_tree_riempi_treeview_testa_e1asn( kuf1_treeview, k_tipo_oggetto )
				
			case else
					k_return = 0
	
		end choose
	

return k_return
end function

public function integer u_tree_riempi_listview_smista (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
int k_return = 0


		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_car_meca_dett &
					,kuf1_treeview.kist_treeview_oggetto.anag_dett_anno_mese_dett &
					,kuf1_treeview.kist_treeview_oggetto.anag_dett_stor_mese_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_err_mese_giri_dett &
					,kuf1_treeview.kist_treeview_oggetto.meca_err_mese_all_dett  &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_dett_id_meca &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_dett_nodose &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_qtna_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_trasferiti_dapkl 
					 
				k_return = u_tree_riempi_listview_testa( kuf1_treeview, k_tipo_oggetto ) 

			case kuf1_treeview.kist_treeview_oggetto.meca_blk_dett
				k_return = u_tree_riempi_listview_testa_blk( kuf1_treeview, k_tipo_oggetto )
			
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett &
 					 ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 
				k_return = u_tree_riempi_listview_testa_e1asn( kuf1_treeview, k_tipo_oggetto )

			case else
					k_return = 0
	
		end choose
	

return k_return
end function

public function integer u_tree_riempi_listview_testa_blk (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini
kuf_meca_causali_blk_m kuf1_meca_causali_blk_m
st_tab_meca_stato kst_tab_meca_stato
kuf_armo kuf1_armo

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> "Lotto bloccato" then 

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Lotto bloccato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Entrato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "E1 (WO/SO)"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Area"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Bolla del mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "cod.Blocco"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Autorizzazione"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Descrizione blocco"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ricevente/Cliente"
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
//---

		kuf1_armo = create kuf_armo
		kuf1_meca_causali_blk_m = create kuf_meca_causali_blk_m

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			k_ind=1
			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mmm") &
 										  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) 
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if date(kst_treeview_data_any.st_tab_meca.data_ent) > kkg.data_zero then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_ent, "dd mmm hh:mm")
			else
				kst_tab_treeview.voce = " "
			end if	
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no then
				kst_tab_treeview.voce = "CHIUSO"
			else
				if kst_treeview_data_any.st_tab_meca.stato > 0 then
					try
						kst_tab_meca_stato.codice = kst_treeview_data_any.st_tab_meca.stato
						kst_tab_meca_stato.descrizione = kuf1_armo.get_stato_descrizione(kst_tab_meca_stato)
					catch (uo_exception kuo_exception)
					end try
					kst_tab_meca_stato.descrizione = string(kst_treeview_data_any.st_tab_meca.stato) + " = " + trim(kst_tab_meca_stato.descrizione)
				else
					kst_tab_meca_stato.descrizione = " "
				end if
				kst_tab_treeview.voce =  kst_tab_meca_stato.descrizione
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") + " / "
			else
				kst_tab_treeview.voce = "- / "
			end if
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce += "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)
			
			kst_tab_treeview.voce = string(trim(kst_treeview_data_any.st_tab_meca.area_mag), "@@ @@@@@@@@@@")
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd.mm.yy") &
									  + "   " + trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.id_meca_causale, "#") 
			choose case kst_treeview_data_any.st_tab_meca.cod_blk
				case 1
					kst_tab_treeview.voce += " =  senza Controlli"
				case 3
					kst_tab_treeview.voce += " =  Controllo Dati"
			end choose
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.meca_blk_rich_autorizz = kuf1_meca_causali_blk_m.ki_rich_autorizz_materiale_medicale then
				if kst_treeview_data_any.st_tab_meca.stato = kuf1_armo.ki_meca_stato_sblk then
					kst_tab_treeview.voce =  "Sbloccato (aut.speciale)" 
				else
					kst_tab_treeview.voce =  "da Sbloccare con autorizzazione speciale (mat.medicale)" 
				end if
			else
				if kst_treeview_data_any.st_tab_meca.stato = kuf1_armo.ki_meca_stato_sblk then
					kst_tab_treeview.voce =  "Sbloccato" 
				else
					kst_tab_treeview.voce =  "da Sbloccare" 
				end if
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_meca.meca_blk_descrizione) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.clie_2, "####0") &
											  + " ; CLIENTE:  " + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + "  -  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20)  &
											  + "     (id Lotto=" + string(kst_treeview_data_any.st_tab_meca.id) + ") " 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
		destroy kuf1_meca_causali_blk_m
		destroy kuf1_armo
		
	end if


	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
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

public function integer u_tree_riempi_treeview_testa_nodose (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order, k_query_from=""
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi, k_datameno2anni, k_datameno1anni, k_datameno4sett
boolean k_nuovo_item=true, k_esponi = true, kc_treeview_open=false
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_artr kst_tab_artr
kuf_armo kuf1_armo
kuf_certif kuf1_certif


try

	kuf1_armo = create kuf_armo
	kuf1_certif = create kuf_certif

	k_data_0 = date(0)		 
//--- data oggi
	k_dataoggi = kg_dataoggi
		 
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

	k_data_da = date(0)
	k_data_a = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_meca.data_int)) &
		 then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		if k_data_da <> date(0) then
			k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
		end if
	end if

	if k_data_da > date(0) then
		if k_data_a = date(0) then
			k_data_a = k_dataoggi
		end if
	end if
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi o date a zero allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
		if DaysAfter ( k_data_da, k_data_a ) > 61 or k_data_da = date(0)  then
			kst_tab_meca.clie_1 =0
			kst_tab_meca.clie_2 =0
			kst_tab_meca.clie_3 =0
			kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
			if kst_esito.esito = kkg_esito.ok then
				k_data_a = kst_tab_meca.data_int
				k_data_da = relativedate(k_data_a , -7)
			else
				//--- se errore non vedo NULLA!
				k_data_da = k_data_a
			end if
		end if
		k_datameno2anni = RelativeDate(k_data_a, -730) 		 
		k_datameno1anni = RelativeDate(k_data_a, -365) 		 
		k_datameno4sett = RelativeDate(k_data_a, -28) 		 

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
		if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
			
			k_query_select = &
					"SELECT  " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.clie_1,  " &
					+ "c1.rag_soc_10 " &
					+ "FROM   " & 
					 + "meca   " &
					 + " inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " 

		else
			k_query_select = &
					"SELECT  " &
					+ "meca.id, " &
					+ "meca.num_int, " &
					+ "meca.data_int, " &
					+ "meca.data_ent, " &
					+ "meca.aperto, " &
					+ "meca.area_mag, " &
					+ "meca.clie_1,  " &
					+ "meca.clie_2,  " &
					+ "meca.clie_3,  " &
					+ "meca.num_bolla_in, " &
					+ "meca.data_bolla_in, " &
					+ "meca.id_wm_pklist, " &
					+ "meca.data_lav_fin,    " &
					+ "meca.err_lav_fin,    " &
					+ "meca.err_lav_ok,    " &
					+ "meca.cert_forza_stampa,   " &
					+ "meca.stato,   " &
					+ "meca.contratto, " &
					+ "c1.rag_soc_10, " &
					+ "coalesce(meca.e1doco,0), " &
					+ "coalesce(meca.e1rorn,0), " &
					+ "coalesce(meca.e1srst,'NC') " &
    			+ "FROM   " & 
					 + "meca  inner JOIN armo ON  " &
					 + "meca.id = armo.id_meca " &
					 + " inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " 
		end if

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett_nodose
//--- piglia gli ultimi 2 anni
				k_data_da = k_datameno2anni
				k_query_where = &
					    " where (meca.data_int between ? and ?) and meca.contratto = 0 and armo.dose = 0 " &
						 + " and (meca.stato is null or meca.stato = " + string(kiuf_armo.ki_meca_stato_ok) + " )"
				
			case else
					k_query_where = " "
	
		end choose
	

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
		if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
			
			k_query_order = " "
				
		else
			k_query_order = " "
//					+ " group by " &
//					+ "meca.id, " &
//					+ "meca.num_int, " &
//					+ "meca.data_int, " &
//					+ "meca.area_mag, " &
//					+ "meca.clie_1,  " &
//					+ "meca.clie_2,  " &
//					+ "meca.clie_3,  " &
//					+ "meca.num_bolla_in, " &
//					+ "meca.data_bolla_in, " &
//					+ "meca.id_wm_pklist, " &
//					+ "meca.data_lav_fin,    " &
//					+ "meca.err_lav_fin,    " &
//					+ "meca.err_lav_ok,    " &
//					+ "meca.cert_forza_stampa,   " &
//					+ "meca.stato,   " &
//					+ "meca.contratto, " &
//					+ "c1.rag_soc_10, " 
		end if
		
		k_query_order += &
			+ " order by  " &
			+ " meca.data_int desc, meca.num_int desc " 
		 
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
			 

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_dett_nodose
				open dynamic kc_treeview using :k_data_da, :k_data_a;
				
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode = 0 then
			kc_treeview_open = true

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
			if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
				
				fetch kc_treeview 
					into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_clienti.rag_soc_10 
						  ;
				
			else
				
				fetch kc_treeview 
					into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.area_mag   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.id_wm_pklist 
						 ,:kst_tab_meca.data_lav_fin   
						 ,:kst_tab_meca.err_lav_fin   
						 ,:kst_tab_meca.err_lav_ok   
						 ,:kst_tab_meca.cert_forza_stampa  
						 ,:kst_tab_meca.stato
						 ,:kst_tab_meca.contratto
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_meca.e1doco
						 ,:kst_tab_meca.e1rorn
						 ,:kst_tab_meca.e1srst
						  ;
			end if	
			
			
			do while sqlca.sqlcode = 0
	
				k_esponi = true
	
		  		if isnull(kst_tab_artr.colli_trattati) then
					kst_tab_artr.colli_trattati = 0
				end if
		  		if isnull(kst_tab_contratti.codice) then
					kst_tab_contratti.codice = 0
				end if
			   if isnull(kst_tab_contratti.sc_cf) then
					kst_tab_contratti.sc_cf = " "
				end if
	 		   if isnull(kst_tab_contratti.mc_co) then
					kst_tab_contratti.mc_co = " "
				end if
		      if isnull(kst_tab_contratti.descr) then
					kst_tab_contratti.descr = " "
				end if

				kuf1_armo.if_isnull_meca(kst_tab_meca)				
				kuf1_certif.if_isnull(kst_tab_certif)				
				
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int


//--- se tipo oggetto solo Lotti da associare in WM...		
				if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_da_associare_wm_dett then
					k_esponi = false
					if kst_tab_meca.id_wm_pklist > 0 then
//						if NOT kuf1_armo.if_lotto_wm_associato(kst_tab_meca) then
						if kst_tab_meca.e1srst <> "20" then
							k_esponi = true
						end if
					end if
				end if
				
				if k_esponi then
					
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
					kst_treeview_data_any.st_tab_certif = kst_tab_certif
					kst_treeview_data_any.st_tab_artr = kst_tab_artr
	
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_meca.num_int, "####0") &
											  + " - " + string(kst_tab_meca.data_int, "dd.mmm") &
											  + " "  &
											  + trim(kst_tab_clienti.rag_soc_10) 
	
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
					
				end if

//---- per Elenco x data fa il Calcola se i gg superano il mese allora faccio elenco ridotto x meno memoria
				if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.meca_dett and DaysAfter ( k_data_da, k_data_a ) > 31 then
				
					fetch kc_treeview 
						into
							 :kst_tab_meca.id   
							 ,:kst_tab_meca.num_int   
							 ,:kst_tab_meca.data_int   
							 ,:kst_tab_meca.data_ent   
							 ,:kst_tab_meca.aperto   
							 ,:kst_tab_meca.clie_1  
							 ,:kst_tab_clienti.rag_soc_10 
							  ;
					
				else
					
					fetch kc_treeview 
						into
						 :kst_tab_meca.id   
						 ,:kst_tab_meca.num_int   
						 ,:kst_tab_meca.data_int   
						 ,:kst_tab_meca.data_ent   
						 ,:kst_tab_meca.aperto   
						 ,:kst_tab_meca.area_mag   
						 ,:kst_tab_meca.clie_1  
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.id_wm_pklist 
						 ,:kst_tab_meca.data_lav_fin   
						 ,:kst_tab_meca.err_lav_fin   
						 ,:kst_tab_meca.err_lav_ok   
						 ,:kst_tab_meca.cert_forza_stampa  
						 ,:kst_tab_meca.stato
						 ,:kst_tab_meca.contratto
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_meca.e1doco
						 ,:kst_tab_meca.e1rorn
						 ,:kst_tab_meca.e1srst
							  ;
				end if	
	
			loop
			
		end if

	end if 


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


finally
	if kc_treeview_open then 
		close kc_treeview;
	end if
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try


return k_return


end function

public function integer u_tree_riempi_treeview_testa_qtna (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_righe_tot=0, k_riga=0
integer  k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_data_da, k_data_a, k_data_0, k_dataoggi
//date k_datameno2anni, k_datameno1anni, k_datameno4sett
datastore kds_qtna
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_artr kst_tab_artr
st_tab_sped kst_tab_sped
kuf_armo kuf1_armo
kuf_certif kuf1_certif


try

	kuf1_armo = create kuf_armo
	kuf1_certif = create kuf_certif

	k_data_0 = date(0)		 
//--- data oggi
	k_dataoggi = kg_dataoggi
		 
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

	k_data_da = date(0)
	k_data_a = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora anno nel num_int
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_meca.data_int = date (0) or isnull(kst_treeview_data_any.st_tab_meca.data_int)) then

//--- potrei avere salvato l'anno in num_int
		if kst_treeview_data_any.st_tab_meca.num_int > 0 then		
			k_data_da = date(kst_treeview_data_any.st_tab_meca.num_int, 01, 01)
			k_data_a = date(kst_treeview_data_any.st_tab_meca.num_int, 12, 31)
//--- QUERY TROPPO PESANTE non faccio NULLA!!!!!
			k_data_da = k_data_a
		else
			
//--- Ricavo la data da dataoggi
			k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
			if isnull(k_mese) or k_mese = 0 then
				kst_treeview_data_any.st_tab_meca.data_int = k_dataoggi
			end if
		end if
	end if
	
	if k_data_da = date(0) then
		k_mese = month(kst_treeview_data_any.st_tab_meca.data_int) 
		k_anno = year(kst_treeview_data_any.st_tab_meca.data_int)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		if k_data_da <> date(0) then
			k_data_a = RelativeDate((date(k_anno, k_mese, 01)), -1) 
		end if
	end if

	if k_data_da > date(0) then
		if k_data_a = date(0) then
			k_data_a = k_dataoggi
		end if
	end if
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


//--- se richiesto + di 2 mesi  o date a zero allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
		if (DaysAfter ( k_data_da, k_data_a ) > 61 and DaysAfter ( k_data_da, k_data_a ) < 360) or k_data_da = date(0)  then
			kst_tab_meca.clie_1 =0
			kst_tab_meca.clie_2 =0
			kst_tab_meca.clie_3 =0
			kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
			if kst_esito.esito = kkg_esito.ok then
				k_data_a = kst_tab_meca.data_int
				k_data_da = relativedate(k_data_a , -1100)   // piglia gli ultimi 3 anni!!
			else
				//--- se errore non vedo NULLA!
				k_data_da = k_data_a
			end if
		end if
//		k_datameno2anni = RelativeDate(k_data_a, -730) 		 
//		k_datameno1anni = RelativeDate(k_data_a, -365) 		 
//		k_datameno4sett = RelativeDate(k_data_a, -28) 		 

		kds_qtna = create datastore
		kds_qtna.dataobject = "d_tree_meca_qtna"
		kds_qtna.settransobject( kguo_sqlca_db_magazzino )

		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.meca_qtna_dett
				kds_qtna.retrieve(k_data_da, k_data_a)
					
			case else
				
	
		end choose
	
		k_righe_tot = kds_qtna.rowcount()
		if sqlca.sqlcode = 0 and k_righe_tot > 0 then
	
			for k_riga = 1 to k_righe_tot

				kst_tab_meca.id = kds_qtna.getitemnumber(k_riga, "meca_id")  
				kst_tab_meca.num_int = kds_qtna.getitemnumber(k_riga, "meca_num_int")   
				kst_tab_meca.data_int = kds_qtna.getitemdate(k_riga, "meca_data_int")   
				kst_tab_meca.data_ent = kds_qtna.getitemdatetime(k_riga, "meca_data_ent")   
				kst_tab_meca.aperto = kds_qtna.getitemstring(k_riga, "meca_aperto")   
				kst_tab_meca.area_mag = kds_qtna.getitemstring(k_riga, "meca_area_mag")   
				kst_tab_meca.clie_1 = kds_qtna.getitemnumber(k_riga, "meca_clie_1")  
				kst_tab_meca.clie_2 = kds_qtna.getitemnumber(k_riga, "meca_clie_2")  
				kst_tab_meca.clie_3 = kds_qtna.getitemnumber(k_riga, "meca_clie_3")  
				kst_tab_meca.num_bolla_in = kds_qtna.getitemstring(k_riga, "meca_num_bolla_in")  
				kst_tab_meca.data_bolla_in = kds_qtna.getitemdate(k_riga, "meca_data_bolla_in") 
				kst_tab_meca.id_wm_pklist = kds_qtna.getitemnumber(k_riga, "meca_id_wm_pklist") 
				kst_tab_meca.data_lav_fin = kds_qtna.getitemdate(k_riga, "meca_data_lav_fin")   
				kst_tab_meca.err_lav_fin = kds_qtna.getitemstring(k_riga, "meca_err_lav_fin")   
				kst_tab_meca.err_lav_ok = kds_qtna.getitemstring(k_riga, "meca_err_lav_ok")   
				kst_tab_meca.cert_forza_stampa = kds_qtna.getitemstring(k_riga, "meca_cert_forza_stampa")  
				kst_tab_meca.stato = kds_qtna.getitemnumber(k_riga, "meca_stato")
				kst_tab_meca.e1doco = kds_qtna.getitemnumber(k_riga, "e1doco")
				kst_tab_meca.e1rorn = kds_qtna.getitemnumber(k_riga, "e1rorn")
				kst_tab_meca_qtna.id_meca_qtna = kds_qtna.getitemnumber(k_riga, "id_meca_qtna")
				kst_tab_contratti.codice = kds_qtna.getitemnumber(k_riga, "meca_contratto")
				kst_tab_contratti.mc_co = kds_qtna.getitemstring(k_riga, "contratti_mc_co")
				kst_tab_contratti.sc_cf = kds_qtna.getitemstring(k_riga, "contratti_sc_cf")
				kst_tab_contratti.descr = kds_qtna.getitemstring(k_riga, "contratti_descr")
				kst_tab_certif.num_certif = kds_qtna.getitemnumber(k_riga, "certif_num_certif")
				kst_tab_certif.data_stampa = kds_qtna.getitemdate(k_riga, "certif_data_stampa")
				kst_tab_clienti.rag_soc_10 = kds_qtna.getitemstring(k_riga,  "clienti_rag_soc_10")
				kst_tab_clienti.rag_soc_11 = kds_qtna.getitemstring(k_riga, "clienti_rag_soc_10_1") 
				kst_tab_clienti.rag_soc_20 = kds_qtna.getitemstring(k_riga, "clienti_rag_soc_10_2") 
				kst_tab_artr.colli_trattati = kds_qtna.getitemnumber(k_riga, "colli_trattati") 
				kst_tab_sped.id_sped = kds_qtna.getitemnumber(k_riga, "arsp_id_sped") 
				kst_tab_sped.num_bolla_out = kds_qtna.getitemnumber(k_riga, "arsp_num_bolla_out") 
				kst_tab_sped.data_bolla_out = kds_qtna.getitemdate(k_riga, "arsp_data_bolla_out") 

	
		  		if isnull(kst_tab_artr.colli_trattati) then
					kst_tab_artr.colli_trattati = 0
				end if
		  		if isnull(kst_tab_contratti.codice) then
					kst_tab_contratti.codice = 0
				end if
			   if isnull(kst_tab_contratti.sc_cf) then
					kst_tab_contratti.sc_cf = " "
				end if
	 		   if isnull(kst_tab_contratti.mc_co) then
					kst_tab_contratti.mc_co = " "
				end if
		      	if isnull(kst_tab_contratti.descr) then
					kst_tab_contratti.descr = " "
				end if
		      	if isnull(kst_tab_sped.id_sped) then
					kst_tab_sped.id_sped = 0
				end if

				kuf1_armo.if_isnull_meca(kst_tab_meca)				
				kuf1_certif.if_isnull(kst_tab_certif)				
				
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int

				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data_any.st_tab_artr = kst_tab_artr
				kst_treeview_data_any.st_tab_sped = kst_tab_sped

				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = &
												 string(kst_tab_meca.num_int, "####0") &
											  + " - " + string(kst_tab_meca.data_int, "dd.mmm") &
											  + " "  &
											  + trim(kst_tab_clienti.rag_soc_10) 
	
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

			next

		end if
	end if 


catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


finally
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_armo) then destroy kuf1_armo

end try


return k_return


end function

public function integer u_tree_riempi_treeview_testa_e1asn (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_find, k_tab_e1_asn_nrows
integer k_ctr, k_pic_open, k_pic_close, k_mese, k_anno, k_pic_list
string k_tipo_oggetto_padre, k_dataoggix, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
string k_ds_syntax, k_ds_errori
datastore kds_tree
date  k_datamenoXMesi
boolean k_nuovo_item=true, k_esiste_asn, k_elabora
long k_righe, k_riga
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_f5547013 kst_tab_f5547013
st_get_e1barcode kst_get_e1barcode
st_tab_e1_asn kst_tab_e1_asn[]
kuf_armo kuf1_armo
kuf_e1_asn kuf1_e1_asn

try
	
	kuf1_armo = create kuf_armo
	kuf1_e1_asn = create kuf_e1_asn
		 
//--- Ricavo l'oggetto figlio dal DB id_meca
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

	k_datamenoXMesi =  RelativeDate(kguo_g.get_dataoggi( ), -60) 		 
	choose case k_tipo_oggetto
//--- Lotti che non hanno ancora generato il ASN (ma abili) o senza BARCODE ma già con il ASN 
		case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 
//--- Lotti senza BARCODE ma già con il ASN 
		case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett 
			k_datamenoXMesi = RelativeDate(kguo_g.get_dataoggi( ), -4) 		 
//--- Lotti che non hanno ancora lo stato a '20' (non associati)
		case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
			k_datamenoXMesi = RelativeDate(kguo_g.get_dataoggi( ), -3) 		 

	end choose
	
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito =kkg_esito.ok then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


		k_query_select = &
					"SELECT  " &
					+ "meca.id , " &
					+ "meca.e1doco , " &
					+ "meca.e1rorn , " &
					+ "meca.num_int  , " &
					+ "meca.data_int  , " &
					+ "meca.data_ent  , " &
					+ "meca.consegna_data  , " &
					+ "meca.aperto  , " &
					+ "meca.area_mag  , " &
					+ "meca.clie_1  ,  " &
					+ "meca.clie_2  ,  " &
					+ "meca.clie_3  ,  " &
					+ "meca.num_bolla_in  , " &
					+ "meca.data_bolla_in  , " &
					+ "meca.stato  ,   " &
					+ "meca.contratto  , " &
					+ "contratti.mc_co  , " &
					+ "contratti.sc_cf  , " &
					+ "meca_blk.id_meca_causale  , "  &
					+ "meca_blk.rich_autorizz  , " &
					+ "meca_blk.descrizione  , " &
					+ "meca_causali.cod_blk  , " &
					+ "c1.rag_soc_10   , " &
					+ "c3.rag_soc_10  , " &
					+ " (count(barcode.barcode)) as contati " &
					+ ", ' ' as k_wasrst " &
					+ "FROM  meca  " & 
					 + "    inner JOIN clienti c1 ON  " &
					 + "meca.clie_1 = c1.codice " &
					 + "    inner JOIN clienti c3 ON  " &
					 + "meca.clie_3 = c3.codice "  &
					 + "    left outer JOIN meca_blk ON  " &
					 + "meca.id = meca_blk.id_meca " &
					 + "   left outer JOIN  meca_causali ON  " &
					 + "meca_blk.id_meca_causale = meca_causali.id_meca_causale "  &
					 + "    inner JOIN contratti ON  " &
					 + "meca.contratto = contratti.codice " &  
					 + "    left outer join barcode on " &
					 + "meca.id = barcode.id_meca "
				k_query_where = " where " &
					+ "  meca.data_int > '" + string(k_datamenoXMesi) + "' " &
					+ " and meca.aperto not in ('" + string(kuf1_armo.kki_meca_aperto_no) + "', '" + string(kuf1_armo.kki_meca_aperto_annullato) + "') "&
					+ " and meca.stato = " + string(kuf1_armo.ki_meca_stato_ok) + " " 

					
				choose case k_tipo_oggetto
						
			//--- Lotti che non hanno ancora generato il ASN (ma abili) 
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett 

			//--- Lotti che hanno creato il ASN ma non ancora ACCETTATI 
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 

			//--- Lotti che hanno creato il ASN ma senza BARCODE 
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett 
								 
			//--- Lotti che non hanno ancora lo stato a '20' (non associati) (screma i non messi in trattamento e senza WO work order)
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
						k_query_where += " and barcode.pl_barcode = 0 " &
					  						+ " and meca.e1doco > 0 " 
			
				end choose
				
				k_query_where += " " &
					+ " group by " &
							+ "meca.id, " &
							+ "meca.e1doco, " &
							+ "meca.e1rorn, " &
							+ "meca.num_int, " &
							+ "meca.data_int, " &
							+ "meca.data_ent, " &
							+ "meca.consegna_data, " &
							+ "meca.aperto, " &
							+ "meca.area_mag, " &
							+ "meca.clie_1,  " &
							+ "meca.clie_2,  " &
							+ "meca.clie_3,  " &
							+ "meca.num_bolla_in, " &
							+ "meca.data_bolla_in, " &
							+ "meca.stato,   " &
							+ "meca.contratto, " &
							+ "contratti.mc_co, " &
							+ "contratti.sc_cf, " &
							+ "meca_blk.id_meca_causale, "  &
							+ "meca_blk.rich_autorizz, " &
							+ "meca_blk.descrizione, " &
							+ "meca_causali.cod_blk, " &
							+ "c1.rag_soc_10, " &
							+ "c3.rag_soc_10 " 

//					+ "contratti.e1litm, " &
					 

		choose case k_tipo_oggetto
//--- Lotti che non hanno ancora generato il ASN (ma abili) o senza BARCODE ma già con il ASN 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett &
				    ,kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 
				k_query_where += &
					 " having count(barcode.barcode) = 0 "

//--- Lotti che non hanno ancora lo stato a '20' (non associati)
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
				k_query_where += &
					 " having count(barcode.barcode) > 0 "

			case else
					k_query_where = " "
		end choose
	
					
		choose case k_tipo_oggetto
						
//--- Lotti che non hanno ancora generato il ASN (ma nello stato per farlo) 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett 
				k_query_order += &
					+ " order by  " &
						+ " meca.data_int desc, meca.num_int desc " 

//--- Lotti che hanno creato il ASN ma non ancora ACCETTATI 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 
				k_query_order += &
					+ " order by  " &
						+ " c1.rag_soc_10, meca.data_int desc, meca.num_int desc " 

//--- Lotti che hanno creato il ASN ma senza BARCODE 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett 
				k_query_order += &
					+ " order by  " &
						+ " c1.rag_soc_10, meca.data_int desc, meca.num_int desc " 
								 
//--- Lotti che non hanno ancora lo stato a '20' (non associati) (screma i non messi in trattamento e senza WO work order)
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
				k_query_order += &
					+ " order by  " &
						+ " meca.data_int desc, meca.num_int desc " 
			
		end choose
		 
//--- Composizione della Query	
//		if LenA(trim(k_query_where)) > 0 then
//			declare kc_treeview dynamic cursor for SQLSA ;
//			k_query_select = k_query_select + k_query_where + k_query_order
//			prepare SQLSA from :k_query_select using sqlca;
//		end if	
//		choose case k_tipo_oggetto
//				
//
//			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett &
//					,kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett &
//					,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett &
//					,kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
//				open dynamic kc_treeview;
//					
//				
//			case else
//				sqlca.sqlcode = 100
//	
//		end choose
//
//--- genera datastore
		k_query_select = k_query_select + k_query_where + k_query_order
		kds_tree = create datastore
		k_ds_syntax = kguo_sqlca_db_magazzino.syntaxfromsql( k_query_select, 'style(type=grid)', k_ds_errori)
		kds_tree.Create ( k_ds_syntax, k_ds_errori )
		if k_ds_errori > " " then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Errore durante ricerca Lotti in comunicazione a E1: " + trim(k_ds_errori)
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		kds_tree.SetTransObject(kguo_sqlca_db_magazzino)
		k_righe = kds_tree.retrieve()		// Legge i record
		if k_righe > 0 then
//--- popola la tabella solo con i Lotti da cercare			
			for k_riga = 1 to k_righe
				kst_tab_e1_asn[k_riga].wammcu = kguo_g.E1MCU
				kst_tab_e1_asn[k_riga].waapid = string(kds_tree.getitemnumber(k_riga, 1)) //"meca_id"))
			next
//--- cerca lo stato del LOTTO 			
			kuf1_e1_asn = create kuf_e1_asn
//--- Get dello STATO (e presenza) del ASN su E1
			k_tab_e1_asn_nrows = kuf1_e1_asn.u_get_stato(kst_tab_e1_asn[])

//--- popola il ds con gli STATI trovati dalla tabella
			for k_riga = 1 to k_tab_e1_asn_nrows
				k_find = kds_tree.find("#1 = " + trim(kst_tab_e1_asn[k_riga].waapid), 1, kds_tree.rowcount())
				if k_find > 0 then
					kds_tree.setitem(k_find, 26, kst_tab_e1_asn[k_riga].wasrst)  //"k_wasrst"
				end if
			next

			
//--- CICLO PRINCIPALE IMPOSTAZIONI TREEVIEW
			for k_riga = 1 to k_righe
				
//--- rileva la presenza del ASN	
				if kds_tree.getitemstring(k_riga, 26) > " " then //"k_wasrst"
					k_esiste_asn = true
				else
					k_esiste_asn = false
				end if
			
				kst_tab_meca.id = kds_tree.getitemnumber(k_riga, 1) //"meca_id")  
				kst_tab_meca.e1doco = kds_tree.getitemnumber(k_riga, 2) //"meca_e1doco")  
				kst_tab_meca.e1rorn = kds_tree.getitemnumber(k_riga, 3) //"meca_e1rorn")     
				kst_tab_meca.num_int  = kds_tree.getitemnumber(k_riga, 4) //"meca_num_int")    
				kst_tab_meca.data_int = kds_tree.getitemdate(k_riga, 5) //"meca_data_int")        
				kst_tab_meca.data_ent = kds_tree.getitemdatetime(k_riga, 6) //"meca_data_ent")        
				kst_tab_meca.consegna_data = kds_tree.getitemdate(k_riga, 7) //"meca_consegna_data") 
				kst_tab_meca.aperto = kds_tree.getitemstring(k_riga, 8) //"meca_aperto")        
				kst_tab_meca.area_mag = kds_tree.getitemstring(k_riga, 9) //"meca_area_mag")        
				kst_tab_meca.clie_1  = kds_tree.getitemnumber(k_riga, 10) //"meca_clie_1")   
				kst_tab_meca.clie_2  = kds_tree.getitemnumber(k_riga, 11) //"meca_clie_2")   
				kst_tab_meca.clie_3  = kds_tree.getitemnumber(k_riga, 12) //"meca_clie_3")   
				kst_tab_meca.num_bolla_in = kds_tree.getitemstring(k_riga, 13) //"meca_num_bolla_in")      
				kst_tab_meca.data_bolla_in = kds_tree.getitemdate(k_riga, 14) //"meca_data_bolla_in")
				kst_tab_meca.stato = kds_tree.getitemnumber(k_riga, 15) //"meca_stato")     
				kst_tab_contratti.codice  = kds_tree.getitemnumber(k_riga, 16) //"meca_contratto")  
				kst_tab_contratti.mc_co = kds_tree.getitemstring(k_riga, 17) //"contratti_mc_co")     
				kst_tab_contratti.sc_cf = kds_tree.getitemstring(k_riga, 18) //"contratti_sc_cf")     
				kst_tab_meca.id_meca_causale = kds_tree.getitemnumber(k_riga, 19) //"meca_blk_id_meca_causale")  
				kst_tab_meca.meca_blk_rich_autorizz = kds_tree.getitemstring(k_riga, 20) //"meca_blk_rich_autorizz")     
				kst_tab_meca.meca_blk_descrizione = kds_tree.getitemstring(k_riga, 21) //"meca_blk_descrizione")     
				kst_tab_meca.cod_blk = kds_tree.getitemnumber(k_riga, 22) //"meca_causali_cod_blk")   
				kst_tab_clienti.rag_soc_10 = kds_tree.getitemstring(k_riga, 23) //"c1_rag_soc_10")      
				kst_tab_clienti.rag_soc_20 = kds_tree.getitemstring(k_riga, 24) //"c3_rag_soc_10")      
				kst_tab_meca.st_tab_g_0.contati = kds_tree.getitemnumber(k_riga, 25) //"contati")  
//				kst_tab_clienti.rag_soc_10 = kds_tree.describe("#23.name")
			
				kst_tab_f5547013.ehapid = string(kst_tab_meca.id)

//--- Verifica se ASN caricato su E1
//				kst_get_e1barcode.apid = kst_tab_f5547013.ehapid
//				if kst_tab_meca.e1doco > 0 or kst_tab_meca.e1rorn > 0 then
//					k_esiste_asn = true
//				else
//					k_esiste_asn = kuf1_e1_asn.if_esiste(kst_tab_f5547013) // ASN generato?
//				end if

				k_elabora = false
				choose case k_tipo_oggetto
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett   // Lotti senza ASN
						k_elabora = NOT k_esiste_asn
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett // Lotti NON ancora accettati
						if k_esiste_asn then  // se ASN generato!
							if kds_tree.getitemstring(k_find, 26) <> kuf1_e1_asn.kki_status_ready_label then  // "k_wasrst") ASN accettato?
								k_elabora = true
//						   	k_elabora = NOT kuf1_e1_asn.if_accettato_in_l(kst_get_e1barcode)  // è nello stato di Accettato?
							end if
						end if
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett // Lotti accettati ma senza barcode
						if k_esiste_asn then  // ASN generato!
//							k_elabora = kuf1_e1_asn.if_accettato_in_l(kst_get_e1barcode)  // è nello stato di Accettato?
							if kds_tree.getitemstring(k_find, 26) = kuf1_e1_asn.kki_status_ready_label then  // "k_wasrst")  ASN accettato?
								k_elabora = true
							end if
						end if
					case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett // Lotti con Barcode ma NON Associati
						if k_esiste_asn then  // ASN generato!
//							k_elabora = NOT kuf1_e1_asn.if_ready_to_schedule_in_l(kst_get_e1barcode)  // ancora da Associare?
							if kds_tree.getitemstring(k_find, 26) <> kuf1_e1_asn.kki_status_ready_toschedule then  //"k_wasrst" ASN accettato?
								k_elabora = true
							end if
						end if
				end choose
		
				if k_elabora then
					if isnull(kst_tab_contratti.codice) then
						kst_tab_contratti.codice = 0
					end if
					if isnull(kst_tab_meca.cod_blk) then
						kst_tab_meca.cod_blk = 0
					end if
						if isnull(kst_tab_meca.meca_blk_rich_autorizz) then
						kst_tab_meca.meca_blk_rich_autorizz = ""
					end if
					if isnull(kst_tab_meca.meca_blk_descrizione) then
						kst_tab_meca.meca_blk_descrizione = ""
					end if
	
					kuf1_armo.if_isnull_meca(kst_tab_meca)				
					
					kst_tab_armo.num_int = kst_tab_meca.num_int
					kst_tab_armo.data_int = kst_tab_meca.data_int
					
					kst_treeview_data_any.st_tab_meca = kst_tab_meca
					kst_treeview_data_any.st_tab_armo = kst_tab_armo
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
	
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												 string(kst_tab_meca.num_int, "####0") &
											  + " - " + string(kst_tab_meca.data_int, "dd.mm.yy") &
											  + " "  &
											  + trim(kst_tab_clienti.rag_soc_10) 
	//										  + " (" + string(kst_tab_meca.clie_1, "#####") + " -> " &
	//										  + string(kst_tab_meca.clie_3, "#####") + ")"
	
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

				end if	

	
			next
			
		end if

	end if 

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn

end try

return k_return

end function

public function integer u_tree_riempi_listview_testa_e1asn (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre, k_label_1
int k_ind
string k_campo[17]
alignment k_align[17]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini
kuf_meca_causali_blk_m kuf1_meca_causali_blk_m
st_tab_meca_stato kst_tab_meca_stato
kuf_armo kuf1_armo

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		choose case k_tipo_oggetto
//--- Lotti che non hanno ancora generato il ASN (ma abili) 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett 
				k_label_1 = "ASN da generare"
//--- Lotti nello stato di Accettato (materiale appena entrato)
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1accettato_dett 
				k_label_1 = "ASN da ricevere"
//--- Lotti ancora senza BARCODE ma già con il ASN 
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcode_dett 
				k_label_1 = "ASN senza barcode"
//--- Lotti che non hanno ancora lo stato a '20' (non associati)
			case kuf1_treeview.kist_treeview_oggetto.meca_no_e1bcodeass_dett
				k_label_1 = "ASN da associare"
			case else
				k_label_1 = ""
		end choose
		
		if k_label <> k_label_1 then 

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = k_label_1
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Numero Lotto"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Data Lotto"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Entrato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Area"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Bolla del mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Mandante"
			k_align[k_ind] = left!
			k_ind++
			if k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett then
				k_campo[k_ind] = "W.O."
				k_align[k_ind] = left!
				k_ind++
				k_campo[k_ind] = "S.O."
				k_align[k_ind] = left!
				k_ind++
			end if
			k_campo[k_ind] = "CO"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "cod.Blocco"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Autorizzazione"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Descrizione blocco"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ricevente/Cliente"
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
//---

		kuf1_armo = create kuf_armo
		kuf1_meca_causali_blk_m = create kuf_meca_causali_blk_m

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
			k_ind=0

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.id)
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			
			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.num_int, "####0") 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_int, "dd mmm yy") 
// 										  + "  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if date(kst_treeview_data_any.st_tab_meca.data_ent) > kkg.data_zero then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_ent, "dd mmm hh:mm")
			else
				kst_tab_treeview.voce = " "
			end if	
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.aperto = kuf1_armo.kki_meca_aperto_no then
				kst_tab_treeview.voce = "CHIUSO"
			else
				if kst_treeview_data_any.st_tab_meca.stato > 0 then
					try
						kst_tab_meca_stato.codice = kst_treeview_data_any.st_tab_meca.stato
						kst_tab_meca_stato.descrizione = kuf1_armo.get_stato_descrizione(kst_tab_meca_stato)
					catch (uo_exception kuo_exception)
					end try
					kst_tab_meca_stato.descrizione = string(kst_treeview_data_any.st_tab_meca.stato) + " = " + trim(kst_tab_meca_stato.descrizione)
				else
					kst_tab_meca_stato.descrizione = " "
				end if
				kst_tab_treeview.voce =  kst_tab_meca_stato.descrizione
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			
			kst_tab_treeview.voce = string(trim(kst_treeview_data_any.st_tab_meca.area_mag), "@@ @@@@@@@@@@")
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd mmm yy") &
									  + "   " + trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) + " (" + string(kst_treeview_data_any.st_tab_meca.clie_1, "#") + ")" 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

//			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_contratti.e1litm) 
//			k_ind++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if k_tipo_oggetto <> kuf1_treeview.kist_treeview_oggetto.meca_no_e1asn_dett then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco) 
				k_ind++
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1rorn) 
				k_ind++
				kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			end if
			
			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_contratti.mc_co) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			
			kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.id_meca_causale, "#") 
			choose case kst_treeview_data_any.st_tab_meca.cod_blk
				case 1
					kst_tab_treeview.voce += " =  senza Controlli"
				case 3
					kst_tab_treeview.voce += " =  Controllo Dati"
			end choose
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.meca_blk_rich_autorizz = kuf1_meca_causali_blk_m.ki_rich_autorizz_materiale_medicale then
				if kst_treeview_data_any.st_tab_meca.stato = kuf1_armo.ki_meca_stato_sblk then
					kst_tab_treeview.voce =  "Sbloccato (aut.speciale)" 
				else
					kst_tab_treeview.voce =  "da Sbloccare con autorizzazione speciale (mat.medicale)" 
				end if
			else
				if kst_treeview_data_any.st_tab_meca.stato = kuf1_armo.ki_meca_stato_sblk then
					kst_tab_treeview.voce =  "Sbloccato" 
				else
					kst_tab_treeview.voce =  "da Sbloccare" 
				end if
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_meca.meca_blk_descrizione) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce =  &
											  string(kst_treeview_data_any.st_tab_meca.clie_2, "####0") &
											  + " ; CLIENTE:  " + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + "  -  " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20)  &
											  + "     (id Lotto=" + string(kst_treeview_data_any.st_tab_meca.id) + ") " 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
		destroy kuf1_meca_causali_blk_m
		destroy kuf1_armo
		
	end if


	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
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

on kuf_armo_tree.create
call super::create
end on

on kuf_armo_tree.destroy
call super::destroy
end on

event constructor;call super::constructor;//
//
kiuf_armo = create kuf_armo

end event

event destructor;call super::destructor;//
destroy kiuf_armo

end event

