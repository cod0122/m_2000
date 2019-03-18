$PBExportHeader$kuf_wm_pklist_file.sru
forward
global type kuf_wm_pklist_file from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_file from kuf_wm_pklist
end type
global kuf_wm_pklist_file kuf_wm_pklist_file

type variables
//
kuf_wm_pklist_web kiuf_wm_pklist_web
kuf_wm_receiptgammarad kiuf_wm_receiptgammarad
end variables

forward prototypes
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito tb_delete (ref st_wm_pkl_web kst_wm_pkl_web)
public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima)
public function long importa_wm_pklist_file () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: Testata Fatture
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit, k_long
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_query_select, k_query_where, k_query_order, k_string
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi, k_transmissiondate
boolean k_x_mese=true
int k_ind, k_nr_file_xml, k_ctr_file, k_nr_wm_pkl_web, k_nr_file_txt, k_nr_wm_pkl_txt, k_riga, k_righe_tot, k_ctr, k_pallet
string k_label, k_appo
datastore kds_1, kds_1_txt
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
//st_tab_clienti kst_tab_clienti
st_wm_pkl_web kst_wm_pkl_web[], kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[]
st_wm_pkl_file kst_wm_pkl_file[]


	k_data_0 = datetime(date(0)	)
	kiuf_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kiuf_wm_pklist_web = create kuf_wm_pklist_web
	kds_1 = create datastore
	kds_1.dataobject = "ds_receiptgammarad_l"
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

//--- .... altrimenti lo ricavo dalla tree
	if k_handle_item_padre = 0 or isnull(k_handle_item_padre) then	
//--- item di ritorno di default
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  

	k_data_da = datetime(date(0))
		
//--- Ricavo la data da dataoggi
	k_data_da = datetime(RelativeDate(kG_dataoggi, - 60) )
	
		 
	k_handle_item_nonno = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)

	k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_nonno, ktvi_treeviewitem) 
	kst_treeview_data = ktvi_treeviewitem.data  
	k_tipo_oggetto_nonno = kst_treeview_data.oggetto
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = kkg_esito.ok then
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
//			k_pic_list = kst_tab_treeview.pic_close
		end if
	
//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)


		ktvi_treeviewitem.selected = false


		try
		
//--- get file XML
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_web_dett
//--- Leggo elenco file pkl-web della cartella FTP 
					k_nr_file_xml = kiuf_wm_pklist_web.get_file_wm_pklist_web(kst_wm_pkl_web_file[]) 
//--- Leggo elenco file pkl-TXT della cartella FTP 
					k_nr_file_txt = kiuf_wm_receiptgammarad.get_file_wm_pklist_txt(kst_wm_pkl_file[]) 
			
				case else
					k_nr_file_xml = 0
	
			end choose
	
//--- estrae file formato XML (web ecc...)
			if k_nr_file_xml > 0 then
				
				for k_ctr_file = 1 to k_nr_file_xml
			
					if len(trim(kst_wm_pkl_web_file[k_ctr_file].nome_file)) > 0 then   // se c'e' un file....

						k_nr_wm_pkl_web = kiuf_wm_pklist_web.get_wm_pklist_web_xml( kst_wm_pkl_web_file[k_ctr_file], kst_wm_pkl_web_da_imp[]) 
						if  k_nr_wm_pkl_web > 0 then
					
							k_riga = kds_1.insertrow(0)
							kds_1.setitem(k_riga, "packinglistcode", string(kst_wm_pkl_web_da_imp[1].idpkl))
							kds_1.setitem(k_riga, "palletquantity", kst_wm_pkl_web_da_imp[1].colliddt)
							k_transmissiondate = datetime(date(kst_wm_pkl_web_da_imp[1].data_invio), time(kst_wm_pkl_web_da_imp[1].ora_invio))
							kds_1.setitem(k_riga, "transmissiondate", k_transmissiondate)
							kds_1.setitem(k_riga, "ddtdate", datetime(string(kst_wm_pkl_web_da_imp[1].dtddt)))
							kds_1.setitem(k_riga, "invoicecustomercode", kst_wm_pkl_web_da_imp[1].fatturato) // id_cliente)
							kds_1.setitem(k_riga, "customerlot", kst_wm_pkl_web_da_imp[1].codice_lotto)
							kds_1.setitem(k_riga, "mandatorcustomercode", kst_wm_pkl_web_da_imp[1].mandante)
							kds_1.setitem(k_riga, "nomefile", kst_wm_pkl_web_da_imp[1].nome_file)
							kds_1.setitem(k_riga, "ddtcode", kst_wm_pkl_web_da_imp[1].nrddt)
							kds_1.setitem(k_riga, "pathfile", kst_wm_pkl_web_da_imp[1].path_file)
							kds_1.setitem(k_riga, "receivercustomercode", kst_wm_pkl_web_da_imp[1].ricevente)
							if trim(kst_wm_pkl_web_da_imp[1].tipo_invio) > " " then
								kds_1.setitem(k_riga, "tipoinvio", ("XML/" + kst_wm_pkl_web_da_imp[1].tipo_invio))
							else
								kds_1.setitem(k_riga, "tipoinvio", "XML")
							end if
							kds_1.setitem(k_riga, "contract", kst_wm_pkl_web_da_imp[1].mc_co )
							kds_1.setitem(k_riga, "specification", kst_wm_pkl_web_da_imp[1].sc_cf )

						end if
					end if
				end for
			end if
//--- estrae file formato TXT lineare			
			if k_nr_file_txt > 0 then
				
				for k_ctr_file = 1 to k_nr_file_txt
			
					if len(trim(kst_wm_pkl_file[k_ctr_file].nome_file)) > 0 then   // se c'e' un file....

						kds_1_txt = kiuf_wm_receiptgammarad.get_wm_pklist_txt(kst_wm_pkl_file[k_ctr_file])
						k_nr_wm_pkl_txt = kds_1_txt.rowcount( )
						//kds_1.SaveAs("d:\ufo\" + trim(kds_1_txt.getitemstring(1, "packinglistcode")) + ".txt", Text!, false)
						if k_nr_wm_pkl_txt > 0 then
							
//							//--- conteggio del numero pallet (al cambio del externalpallet faccio +1)
//							kds_1_txt.setsort("externalpalletcode A")
//							kds_1_txt.sort( )
//							k_pallet = 1
//							for k_ctr = 2 to k_nr_wm_pkl_txt
//								if trim(kds_1_txt.getitemstring(k_ctr, "externalpalletcode")) <> trim(kds_1_txt.getitemstring(k_ctr - 1, "externalpalletcode")) then
//									k_pallet ++
//								end if
//							next
							
							k_riga = kds_1.insertrow(0)
							kds_1.setitem(k_riga, "packinglistcode", kds_1_txt.getitemstring(1, "packinglistcode"))
							//kds_1.setitem(k_riga, "palletquantity", k_pallet)
							kds_1.setitem(k_riga, "palletquantity", kds_1_txt.getitemnumber(1, "palletquantity"))
							kds_1.setitem(k_riga, "transmissiondate", kds_1_txt.getitemdatetime(1, "transmissiondate"))
							kds_1.setitem(k_riga, "ddtdate", kds_1_txt.getitemdatetime(1, "ddtdate"))
							kds_1.setitem(k_riga, "invoicecustomercode", kds_1_txt.getitemstring(1, "invoicecustomercode"))
							kds_1.setitem(k_riga, "customerlot", kds_1_txt.getitemstring(1, "customerlot"))
							kds_1.setitem(k_riga, "mandatorcustomercode", kds_1_txt.getitemstring(1, "mandatorcustomercode"))
							kds_1.setitem(k_riga, "nomefile", kds_1_txt.getitemstring(1, "nomefile"))
							kds_1.setitem(k_riga, "ddtcode", kds_1_txt.getitemstring(1, "ddtcode"))
							kds_1.setitem(k_riga, "pathfile", kds_1_txt.getitemstring(1, "pathfile"))
							kds_1.setitem(k_riga, "receivercustomercode", kds_1_txt.getitemstring(1, "receivercustomercode"))
							kds_1.setitem(k_riga, "tipoinvio", kds_1_txt.getitemstring(1, "tipoinvio"))
							kds_1.setitem(k_riga, "contract", kds_1_txt.getitemstring(1, "contract"))
							kds_1.setitem(k_riga, "specification", kds_1_txt.getitemstring(1, "specification"))

						end if
					end if
				end for
			end if
			

//--- finalmente riempie il treeview con entrambi i file XML e TXT			
			k_righe_tot = kds_1.rowcount( )
			if k_righe_tot > 0 then
				kds_1.setsort("data_invio D")
				kds_1.sort()
				for k_riga = 1 to k_righe_tot
					kst_treeview_data.flag = k_x_mese
					kst_treeview_data.handle = 0
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data.struttura = kst_treeview_data_any

					//kst_treeview_data_any.st_wm_pkl_web = kst_wm_pkl_web_da_imp[1]
					kst_treeview_data_any.st_wm_pkl_file.idpkl = kds_1.getitemstring(k_riga, "packinglistcode")
					kst_treeview_data_any.st_wm_pkl_file.colliddt = kds_1.getitemnumber(k_riga, "palletquantity")
					k_appo = string(kds_1.object.transmissiondate[k_riga])
					if isdate(string(date(kds_1.getitemdatetime(k_riga, "transmissiondate")))) then
						kst_treeview_data_any.st_wm_pkl_file.data_invio = string(date(kds_1.getitemdatetime(k_riga, "transmissiondate")))
					else
						kst_treeview_data_any.st_wm_pkl_file.data_invio = ""
					end if
					kst_treeview_data_any.st_wm_pkl_file.dtddt = string(date(kds_1.getitemdatetime(k_riga, "ddtdate")))
					if trim(kds_1.getitemstring(k_riga, "invoicecustomercode")) > " " then
						k_string = trim(kds_1.getitemstring(k_riga, "invoicecustomercode"))
					else
						k_string = ""
					end if
					kst_treeview_data_any.st_wm_pkl_file.fattturato = k_string
					kst_treeview_data_any.st_wm_pkl_file.idlotto = kds_1.getitemstring(1, "customerlot")
					if isnumber(trim(kds_1.getitemstring(k_riga, "mandatorcustomercode"))) then
						k_long = long(trim(kds_1.getitemstring(k_riga, "mandatorcustomercode"))) 
					else
						k_long = 0
					end if
					kst_treeview_data_any.st_wm_pkl_file.mandante = string(k_long)
					kst_treeview_data_any.st_wm_pkl_file.nome_file = kds_1.getitemstring(k_riga, "nomefile")
					kst_treeview_data_any.st_wm_pkl_file.nrddt = kds_1.getitemstring(k_riga, "ddtcode")
					kst_treeview_data_any.st_wm_pkl_file.ora_invio = string(time(kds_1.getitemdatetime(k_riga, "transmissiondate")))
					kst_treeview_data_any.st_wm_pkl_file.path_file = kds_1.getitemstring(k_riga, "pathfile")
					if trim(kds_1.getitemstring(k_riga, "receivercustomercode")) > " " then
						k_string = trim(kds_1.getitemstring(k_riga, "receivercustomercode"))
					else
						k_string = ""
					end if
					kst_treeview_data_any.st_wm_pkl_file.ricevente = k_string
					kst_treeview_data_any.st_wm_pkl_file.tipo_invio = kds_1.getitemstring(k_riga, "tipoinvio")
					kst_treeview_data_any.st_wm_pkl_file.mc_co = kds_1.getitemstring(k_riga, "contract")
					kst_treeview_data_any.st_wm_pkl_file.sc_cf = kds_1.getitemstring(k_riga, "specification")
					
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					if trim(kst_treeview_data_any.st_wm_pkl_file.data_invio) > " " then
						kst_treeview_data.label = &
												  string(kst_treeview_data_any.st_wm_pkl_file.idpkl) &
												  + " - " + string(date(kst_treeview_data_any.st_wm_pkl_file.data_invio), "dd mmm") &
												  + "   (" + trim(kst_treeview_data_any.st_wm_pkl_file.mandante) + ") "
					else
						kst_treeview_data.label = &
												  string(kst_treeview_data_any.st_wm_pkl_file.idpkl) &
												  + "   (" + trim(kst_treeview_data_any.st_wm_pkl_file.mandante) + ") "
					end if
	
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.handle = k_handle_item_padre
					kst_treeview_data.pic_list = kst_tab_treeview.pic_list
		
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

				end for	
				
			end if
		
		catch(uo_exception kuo_exception)
			kGuo_exception.set_esito(kuo_exception.get_st_esito())
			
		end try
		
	end if
 
 
return k_return


end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
integer k_ctr
date k_save_data_int, k_data_bolla_in, k_data_da, k_data_a
long k_clie_2=0
string k_rag_soc_10 , k_label, k_oggetto_corrente, k_stato_barcode="", k_tipo_oggetto_padre, k_tipo_doc, k_stato
int k_ind, k_mese, k_anno
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
//st_wm_pkl_web kst_wm_pkl_web
st_wm_pkl_file kst_wm_pkl_file
st_tab_clienti kst_tab_clienti, kst_tab_clienti_fatt
st_tab_treeview kst_tab_treeview
kuf_clienti kuf1_clienti
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
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Pk-List file"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "formato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "prodotto il "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "nr. d.d.t."
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "data d.d.t."
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "colli "
		k_align[k_ind] = left!
		k_ind++
//		k_campo[k_ind] = "id Contratto"
//		k_align[k_ind] = left!
//		k_ind++
		k_campo[k_ind] = "Contr.Commerciale"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Capitolato"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "note lotto "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "posizione documento "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
	
		k_ind=1
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
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
//		k_handle = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item)
//		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle, ktvi_treeviewitem) 
//		kst_treeview_data = ktvi_treeviewitem.data  
//		k_oggetto_corrente = trim(kst_treeview_data.oggetto)
//		k_pictureindex = u_dammi_pic_tree_list(k_oggetto_corrente)			

	
		kuf1_clienti = create kuf_clienti

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

//			kst_wm_pkl_web = kst_treeview_data_any.st_wm_pkl_web
			kst_wm_pkl_file = kst_treeview_data_any.st_wm_pkl_file
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			kst_tab_clienti_fatt.rag_soc_10 = ""
			if isnumber(trim(kst_wm_pkl_file.mandante)) then
				kst_tab_clienti_fatt.codice = long(trim(kst_wm_pkl_file.mandante))
				kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
				if kst_esito.esito <> kkg_esito.ok then
					kst_tab_clienti_fatt.rag_soc_10 = "*non identificato*"
				end if
			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_file.idpkl))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.tipo_invio))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.data_invio ) + " " + trim(kst_wm_pkl_file.ora_invio ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.mandante ) + " " + trim(kst_tab_clienti_fatt.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.nrddt ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_file.dtddt ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_wm_pkl_file.colliddt ))
			k_ind++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.id_contratto ))
//			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.mc_co ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.sc_cf ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.ricevente ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.fattturato ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.idlotto ))
			k_ind++
			if isnull(kst_wm_pkl_file.path_file )  then kst_wm_pkl_file.path_file  = ""
			if isnull(kst_wm_pkl_file.nome_file )  then kst_wm_pkl_file.nome_file  = ""
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_wm_pkl_file.path_file ) +"\" + trim(kst_wm_pkl_file.nome_file ))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		
	end if
 
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		kst_treeview_data.oggetto = k_tipo_oggetto_padre
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

public function st_esito tb_delete (ref st_wm_pkl_web kst_wm_pkl_web);//
//====================================================================
//=== Cancella il rek dalla tabella Receiptgammarad (tutte le righe della bolla di pkl)
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
int k_rc
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_autorizza then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Cancellazione file 'Packing List' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else
//
//	if len(trim(kst_wm_pkl_web.nome_file)) > 0 then
//
//		try
//	
//			kuf1_utility = create kuf_utility
//			if not DirectoryExists (kst_wm_pkl_web.path_file+"\Rimossi") then CreateDirectory (kst_wm_pkl_web.path_file+"\Rimossi") 
//			k_rc = kuf1_utility.u_filemovereplace( kst_wm_pkl_web.path_file +"\"+  kst_wm_pkl_web.nome_file,  &
//			                                              kst_wm_pkl_web.path_file+"\Rimossi\"+kst_wm_pkl_web.nome_file)
//			
//			if k_rc < 0 then
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Cancellazione 'Packing List Web' file=" +trim(kst_wm_pkl_web.nome_file) + " non riuscita! "
//				sqlca.sqlcode = 0 
//				kst_esito.esito = kkg_esito.no_esecuzione
//	
//			end if
//		catch (uo_exception kuo_exception)
//			kst_esito = kuo_exception.get_st_esito()
//
//		finally
//			destroy kuf1_utility
//			
//		end try
//		
//	end if
//end if


return kst_esito

end function

public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0, k_index=0
datastore kds_1
st_esito kst_esito
st_open_w kst_open_w
st_tab_g_0 kst_tab_g_0[]


if upperbound(kst_wm_pklist) > 0 then

   choose case k_modalita  

      case kkg_flag_modalita.anteprima

//       if len(trim(kst_tab_wm_pklist.st_wm_pkl_web[1].idpkl )) > 0 then
//          kds_1 = create datastore
//          kst_esito = anteprima ( kds_1, kst_tab_wm_pklist.st_wm_pkl_web[1])
//          if kst_esito.esito = kkg_esito.db_ko then
//             k_return = 1
//             kguo_exception.set_esito( kst_esito )
//             kguo_exception.messaggio_utente( )
//          else
//
//             kdw_anteprima.dataobject = kds_1.dataobject
//             kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
//             
//          end if
//          destroy kds_1
//       end if

//--- Cancellazione
      case kkg_flag_modalita.cancellazione

         for k_index = 1 to upperbound(kst_wm_pklist)    

            if len(trim(kst_wm_pklist[k_index].st_wm_pkl_web.nome_file)) > 0 then
               this.tb_delete(kst_wm_pklist[k_index].st_wm_pkl_web)
            end if
         
         end for
      
      case else

         kst_open_w.flag_modalita = k_modalita        
         kst_tab_g_0[1].id = kst_wm_pklist[1].st_wm_pkl_web.idpkl
         if not this.u_open( kst_tab_g_0[], kst_open_w ) then  //Apre le Varie Funzioni
            k_return = 1
            
            kguo_exception.setmessage( "Operazione di Accesso al Packing List Web fallita. ")
            kguo_exception.messaggio_utente( )
         end if
            
            
   end choose     


end if   
 
 
return k_return

end function

public function long importa_wm_pklist_file () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Importa Packing-List da file TXT nella Tabella RECEIPTGAMMARAD 
//---	ReceiptGammarad
//---
//---	inp: kst_tab_wm_receiptgammarad. 
//---	out: 
//---	rit: nr. dei Pcking Prodotti 
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_pkldam2000
long k_return=0, k_ctr, k_ctr_imp, k_ctr_pklist
boolean k_semaforo_ROSSO=false
st_tab_wm_pklist kst_tab_wm_pklist
st_esito kst_esito
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
//kuf_wm_pklist_inout kuf1_wm_pklist_inout
					

try
		
		
		
		if not isvalid(kiuf_wm_pklist_web) then kiuf_wm_pklist_web = create kuf_wm_pklist_web
		if not isvalid(kiuf_wm_receiptgammarad) then kiuf_wm_receiptgammarad = create kuf_wm_receiptgammarad
		
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

//--- SEMAFORO ROSSO: importazione già in esecuzione
		k_semaforo_ROSSO = kuf1_wm_pklist_cfg.if_importa_in_esecuzione( )   
		
		if not k_semaforo_ROSSO then
			
			k_semaforo_ROSSO = kuf1_wm_pklist_cfg.set_importazione_ts_ini_on()  // SEMAFORO ROSSO
		
//--- Importa file XML
			k_ctr = kiuf_wm_pklist_web.importa_wm_pklist_web( )
			k_ctr_imp = k_ctr
	
	//--- SOLO SE E-ONE ATTIVATO
	//--- Importa file TEXT
			//kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
			k_pkldam2000 = kuf1_wm_pklist_cfg.if_importadam2000()
			if k_pkldam2000 then
		
				k_ctr = kiuf_wm_receiptgammarad.importa_wm_pklist_txt()
				k_ctr_imp += k_ctr
		
		//--- importa da tab RECEIPTGAMMARAD ---> tab WM_PKLIST
				if k_ctr_imp > 0 then
//				kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
//				k_ctr_pklist = kuf1_wm_pklist_inout.importa_wm_pklist_ext_tutti() 
					
					k_return = k_ctr_imp
	
				end if
			end if
		end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if k_semaforo_ROSSO then
		kuf1_wm_pklist_cfg.set_importazione_ts_ini_off()  // SEMAFORO VERDE
	end if
//	if isvalid(kuf1_wm_pklist_inout) then destroy kuf1_wm_pklist_inout
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg

end try


return k_return


end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
long k_ctr, k_ctr1
st_esito kst_esito
kuf_wm_pklist_inout kuf1_wm_pklist_inout

try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout

	k_ctr = importa_wm_pklist_file( ) 
	k_ctr1 = kuf1_wm_pklist_inout.importa_wm_pklist_ext_tutti( ) 
	if (k_ctr + k_ctr1) > 0 then
		if k_ctr > 0 and k_ctr1 > 0 then
			kst_esito.SQLErrText = "Operazione conclusa correttamente." &
												+ "Caricati " + string(k_ctr) + " file di Packing-List Cliente (WEB/FTP/TXT) in Magazzino " & 
												+ " e " + string(k_ctr1) + " Packing-List pronte per essere importate come Riferimento." 
		else
			if k_ctr > 0  then
				kst_esito.SQLErrText = "Operazione conclusa correttamente." &
												+ "Caricati " + string(k_ctr) + " file di Packing-List Cliente (WEB/FTP/TXT) in Magazzino."  
			else
				kst_esito.SQLErrText = "Operazione conclusa correttamente." &
												+ "Caricati " +  string(k_ctr1) + " Packing-List pronte per essere importate come Riferimento." 
			end if
		end if
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Packing-List Cliente (WEB/FTP/TXT) trovato nelle cartelle definite per la ricezione."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_wm_pklist_inout) then destroy kuf1_wm_pklist_inout
	
end try


return kst_esito
end function

on kuf_wm_pklist_file.create
call super::create
end on

on kuf_wm_pklist_file.destroy
call super::destroy
end on

event constructor;call super::constructor;//
//--- operazioni iniziali
//
ki_nomeOggetto = trim(this.classname( ))

end event

event destructor;call super::destructor;//
	if isvalid(kiuf_wm_pklist_web) then destroy kiuf_wm_pklist_web
	if isvalid(kiuf_wm_receiptgammarad) then destroy kiuf_wm_receiptgammarad

end event

