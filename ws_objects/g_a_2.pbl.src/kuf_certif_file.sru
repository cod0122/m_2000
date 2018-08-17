$PBExportHeader$kuf_certif_file.sru
forward
global type kuf_certif_file from kuf_parent
end type
end forward

global type kuf_certif_file from kuf_parent
end type
global kuf_certif_file kuf_certif_file

type variables
//
datastore kids_file

end variables

forward prototypes
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito tb_delete (ref st_wm_pkl_web kst_wm_pkl_web)
public function integer u_tree_open (string k_modalita, st_wm_pklist kst_wm_pklist[], ref datawindow kdw_anteprima)
public function integer set_ds_file (string a_path_radice) throws uo_exception
public function boolean u_tree_open_email (st_treeview_data_any ast_treeview_data_any) throws uo_exception
public function integer u_tree_riempi_treeview_root (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
end prototypes

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: File documenti
//--- torna >0 = ok; 0=nessuna operazione
//
integer k_return = 1, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_rit, k_long
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_tipo_oggetto_padre, k_query_select, k_query_where, k_query_order, k_string
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi, k_transmissiondate
boolean k_x_mese=true
int k_ind, k_nr_file, k_ctr_file, k_riga, k_righe_tot, k_ctr, k_pallet
string k_label, k_appo
datastore kids_file_txt, kds_docpath
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_clienti kst_tab_clienti
st_wm_pkl_web kst_wm_pkl_web[], kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[]
st_treeview_file kst_treeview_file[]
kuf_doctipo kuf1_doctipo
st_tab_docpath kst_tab_docpath
st_tab_doctipo kst_tab_doctipo
string k_path, k_path1
kuf_certif kuf1_certif
kuf_armo kuf1_armo


	try
//--- imposta path documenti interni
		k_path = kguo_path.get_doc_root_interno()
	
		kuf1_certif = create kuf_certif
		kuf1_armo = create kuf_armo
		kuf1_doctipo = create kuf_doctipo
	
//		kst_tab_doctipo.tipo = kuf1_doctipo.kki_tipo_attestati
//		kst_tab_docpath.id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
//	
//		if kst_tab_docpath.id_doctipo > 0 then
//			kds_docpath = create datastore
//			kds_docpath.dataobject = "ds_docpath_l_x_tipo"
//			if kds_docpath.retrieve(kst_tab_docpath.id_doctipo) > 0 then
//				k_path1 = trim(kds_docpath.getitemstring( 1, "path"))
//			end if
//			if k_path1 > " " then
//				k_path += kkg.path_sep + k_path1
//			end if
//		end if		 
	
//--- Ricavo l'oggetto figlio dal DB 
		kst_tab_treeview.id = k_tipo_oggetto
		kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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
	
	
		kst_treeview_data_any = kst_treeview_data.struttura
		k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
		
		if kst_treeview_data_any.st_treeview_file.tipo = "c" then
	//		k_path += kkg.path_sep + kst_treeview_data_any.st_treeview_file.path //nome 
			if kst_treeview_data_any.st_treeview_file.path > " " then
				k_path = kst_treeview_data_any.st_treeview_file.path //nome 
			end if
		else
			if kst_treeview_data_any.st_treeview_file.tipo = "f" then
				k_return = 0  // schiacciato su file non fa nulla
				k_handle_item_figlio = k_handle_item_padre
				kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_no
			end if
		end if
	
	
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
	
		
//--- get files 
//			choose case k_tipo_oggetto
					
//				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_web_dett

					k_righe_tot = set_ds_file(k_path) 
			
//				case else
//					k_nr_file_xml = 0
	
//			end choose
			

//--- finalmente riempie il treeview con entrambi i file XML e TXT			
			if k_righe_tot > 0 then
				kids_file.setsort("nome D")
				kids_file.sort()
				for k_riga = 1 to k_righe_tot
					kst_treeview_data.flag = k_x_mese
					kst_treeview_data.handle = 0
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data.struttura = kst_treeview_data_any

					kst_treeview_data_any.st_treeview_file.tipo = kids_file.getitemstring(k_riga, "tipo")
					kst_treeview_data_any.st_treeview_file.nome = kids_file.getitemstring(k_riga, "nome")
					if kst_treeview_data_any.st_treeview_file.tipo = 'c' then
						kst_treeview_data_any.st_treeview_file.path = k_path + kkg.path_sep + kids_file.getitemstring(k_riga, "nome") //kids_file.getitemstring(k_riga, "path")
					else
						kst_treeview_data_any.st_treeview_file.path = kids_file.getitemstring(k_riga, "path")
					end if
					kst_treeview_data_any.st_treeview_file.size = kids_file.getitemnumber(k_riga, "size")

					if kst_treeview_data_any.st_treeview_file.tipo = "f" then   // se sono su file estrae dati
						kst_treeview_data_any.st_tab_certif.id = kuf1_certif.get_id_da_nome(kst_treeview_data_any.st_treeview_file.nome)  //estrae dal nome il id
						kst_treeview_data_any.st_tab_certif.num_certif = kuf1_certif.get_num_certif_da_nome(kst_treeview_data_any.st_treeview_file.nome)  //estrae dal nome il id
						kuf1_certif.get_id_meca_da_id(kst_treeview_data_any.st_tab_certif) //get id_meca
						kuf1_certif.get_data(kst_treeview_data_any.st_tab_certif) //get data
						kst_treeview_data_any.st_tab_meca.id = kst_treeview_data_any.st_tab_certif.id_meca   
						kst_treeview_data_any.st_tab_meca.e1doco = kuf1_armo.get_e1doco(kst_treeview_data_any.st_tab_meca)  // get WO
						kst_treeview_data_any.st_tab_meca.e1rorn = kuf1_armo.get_e1rorn(kst_treeview_data_any.st_tab_meca)  // get SO
					end if
					
//					k_appo = string(kids_file.object.transmissiondate[k_riga])
//					if isdate(string(date(kids_file.getitemdatetime(k_riga, "transmissiondate")))) then
//						kst_treeview_data_any.st_treeview_file.data_invio = string(date(kids_file.getitemdatetime(k_riga, "transmissiondate")))
//					else
//						kst_treeview_data_any.st_treeview_file.data_invio = ""
//					end if
					
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = trim(kst_treeview_data_any.st_treeview_file.nome) 

					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.handle = k_handle_item_padre
					if kst_treeview_data_any.st_treeview_file.tipo = "c" then
						ktvi_treeviewitem.selectedpictureindex = kuf1_treeview.kist_treeview_oggetto.pic_cartella
						ktvi_treeviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_cartella
					else
						ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
						ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
					end if
					kst_treeview_data.pic_list = kst_tab_treeview.pic_list
	
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
											  
	//--- Nuovo Item
					if kst_treeview_data_any.st_treeview_file.tipo = "c" or kst_treeview_data_any.st_treeview_file.tipo = "f" then
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					
	//--- salvo handle del item appena inserito nella stessa struttura
						kst_treeview_data.handle = k_handle_item
	
	//--- inserisco il handle di questa riga tra i dati del item
						ktvi_treeviewitem.data = kst_treeview_data
	
						kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
					end if
				end for	
				
			end if
		
			k_return = k_righe_tot + 1
		end if
		
 
	catch(uo_exception kuo1_exception)
		kGuo_exception.set_esito(kuo1_exception.get_st_esito())
		
	finally
		if isvalid(kuf1_certif) then destroy kuf1_certif
		if isvalid(kuf1_doctipo) then destroy kuf1_doctipo
		if isvalid(kuf1_armo) then destroy kuf1_armo
		
	end try
		
 
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
st_treeview_file kst_treeview_file
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
		k_campo[k_ind] = "nome file"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "WO"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "SO"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Lotto"
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
	
		kuf1_clienti = create kuf_clienti

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data

			klvi_listviewitem.label = kst_treeview_data.label
			
			klvi_listviewitem.data = kst_treeview_data

			kst_treeview_data_any = kst_treeview_data.struttura

			kst_treeview_file = kst_treeview_data_any.st_treeview_file
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			if kst_treeview_file.tipo = "c" then
				klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_cartella
			else
				klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			end if
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

//			kst_tab_clienti_fatt.rag_soc_10 = ""
//			if isnumber(trim(kst_treeview_file.mandante)) then
//				kst_tab_clienti_fatt.codice = long(trim(kst_treeview_file.mandante))
//				kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
//				if kst_esito.esito <> kkg_esito.ok then
//					kst_tab_clienti_fatt.rag_soc_10 = "*non identificato*"
//				end if
//			end if

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_treeview_file.nome))
			
			k_ind++
			if kst_treeview_data_any.st_tab_certif.id > 0 then
				kst_treeview_file.data = string(kst_treeview_data_any.st_tab_meca.e1doco)
			end if
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_treeview_file.data))
			
			k_ind++
			if kst_treeview_data_any.st_tab_certif.id > 0 then
				kst_treeview_file.data = string(kst_treeview_data_any.st_tab_meca.e1rorn)
			end if
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_treeview_file.data))
			
			k_ind++
			if kst_treeview_data_any.st_tab_certif.id > 0 then
				kst_treeview_file.data = string(kst_treeview_data_any.st_tab_meca.id)
			end if
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_treeview_file.data))
			
			k_ind++
			if isnull(kst_treeview_file.path ) then kst_treeview_file.path  = ""
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_treeview_file.path))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		
	end if
 
 
//---- item di ritorno
	if k_handle_item_rit > 0 then
		kst_treeview_data_any.st_treeview_file.tipo = ""
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

public function integer set_ds_file (string a_path_radice) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Trova i nomi file presenti nella cartella 
//---	inp: path dei file 
//---	out: kids_file datastore con i file contenuti nel path
//---	rit: nr file trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
integer k_return=0
string k_rc, k_file="", k_tipo
int k_riga, k_file_ind=0
long k_ind, k_nr_file_dirlist=0
string k_file_dirlist[]
datastore kds_dirlist
kuf_file_explorer kuf1_file_explorer
 
 
	try
		kuf1_file_explorer = create kuf_file_explorer

//--- piglia l'elenco dei file xml contenuti nella cartella
		kds_dirlist = kuf1_file_explorer.DirList(trim(a_path_radice)+"\*.*")
		k_nr_file_dirlist = kds_dirlist.rowcount( )

		for k_file_ind = 1 to k_nr_file_dirlist
			
			k_tipo = kds_dirlist.getitemstring(k_file_ind, "tipo") // f=file, c=cartella, n=file nascosto
			if k_tipo = 'f' or k_tipo = 'c' then // f=file, c=cartella, n=file nascosto
				k_riga = kids_file.insertrow(0)
				kids_file.setitem(k_riga, "nome", trim(kds_dirlist.getitemstring(k_file_ind, "nome")))
				kids_file.setitem(k_riga, "path", trim(a_path_radice))
				kids_file.setitem(k_riga, "tipo", k_tipo)
				kids_file.setitem(k_riga, "size", kds_dirlist.getitemnumber(k_file_ind, "size"))
			end if
			
		end for

		k_return = kids_file.rowcount()

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
		finally
			if isvalid(kds_dirlist) then destroy kds_dirlist
			if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end try
			


return k_return


end function

public function boolean u_tree_open_email (st_treeview_data_any ast_treeview_data_any) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Open del client email per inviare un messaggio
//---	inp: st_treeview_data_any con i dati contenuti nella listview quali il file, ecc... 
//---	out: 
//---	rit: TRUE = cliente aperto
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
string k_email, k_body, k_subject, k_attach
int k_nr_ddt
kuf_certif kuf1_certif
kuf_clienti kuf1_clienti
kuf_armo kuf1_armo
st_treeview_file kst_treeview_file
st_tab_clienti_web kst_tab_clienti_web
st_esito kst_esito
n_cst_outlook kn1_cst_outlook
datastore kds_1
 
 
	try
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
		
		kuf1_certif = create kuf_certif
		kuf1_clienti = create kuf_clienti
		kuf1_armo = create kuf_armo
		kds_1 = create datastore
		kn1_cst_outlook = create n_cst_outlook

		kst_treeview_file = ast_treeview_data_any.st_treeview_file
		
		kst_esito = kuf1_certif.get_clie(ast_treeview_data_any.st_tab_certif)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		ast_treeview_data_any.st_tab_meca.id = kuf1_certif.get_id_meca(ast_treeview_data_any.st_tab_certif)
		kuf1_armo.get_data_ent(ast_treeview_data_any.st_tab_meca)
		kuf1_armo.get_num_bolla_in(ast_treeview_data_any.st_tab_meca)
	
		kst_tab_clienti_web.id_cliente = ast_treeview_data_any.st_tab_certif.clie_2
		k_email = kuf1_clienti.get_email_prontomerce(kst_tab_clienti_web)
		
		kds_1.dataobject = "ds_sped_id_meca"
		kds_1.settrans(kguo_sqlca_db_magazzino)
		k_nr_ddt = kds_1.retrieve(ast_treeview_data_any.st_tab_meca.id)

		k_subject = "Attestato di trattamento n. " + string(ast_treeview_data_any.st_tab_certif.num_certif) 
		
		k_body = "Gentile Cliente,~n~r~n~r   ci pregiamo di fornire, allegato alla presente, l'Attestato n. " + string(ast_treeview_data_any.st_tab_certif.num_certif) + " del " + string(ast_treeview_data_any.st_tab_certif.data, "dd mmm yy")
		k_body+= " del materiale"
		if k_nr_ddt > 0 then
			k_body += " trattato e già spedito con il ns d.d.t. n. " + string(kds_1.getitemnumber(1, "num_bolla_out")) + " del " + string(kds_1.getitemdate(1, "data_bolla_out"), "dd mmm yy") + "."
		else
			k_body += " trattato." 
		end if
		if (ast_treeview_data_any.st_tab_meca.num_bolla_in) > " " then
			k_body += "~n~r~n~rIl materiale è stato ricevuto con il d.d.t. n. " + trim(ast_treeview_data_any.st_tab_meca.num_bolla_in) + " del " + string(ast_treeview_data_any.st_tab_meca.data_bolla_in, "dd mmm yy")
		end if
		if date(ast_treeview_data_any.st_tab_meca) > date(0) and date(ast_treeview_data_any.st_tab_meca) <> ast_treeview_data_any.st_tab_meca.data_bolla_in then
			k_body += "in data " + string(ast_treeview_data_any.st_tab_meca, "dd mmm yy") + "."
		end if
			
		k_body += "~n~r~n~rDistinti saluti~n~r" 
			
			
		k_attach = ast_treeview_data_any.st_treeview_file.path + kkg.path_sep + ast_treeview_data_any.st_treeview_file.nome
		
		kn1_cst_outlook.of_create_email1(k_attach, k_email, k_subject, k_body)
						//"C:\ufo\interno\20161207\noaccettati.pdf", "AMalaguti@sterigenics.com")
////--- DBG queste righe che seguono solo solo per test visto che non ho outlook						
//		kuf_file_explorer kuf1_file_explorer
//		kuf1_file_explorer = create kuf_file_explorer
//		kuf1_file_explorer.of_email(k_email, "", k_subject, k_body, k_attach)

	
		k_return = true

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		kst_esito.SQLErrText = "Errore in open funzione di invio msg email~n~r" + trim(kst_esito.SQLErrText)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		if isvalid(kuf1_certif) then destroy kuf1_certif
		if isvalid(kds_1) then destroy kds_1
		if isvalid(kn1_cst_outlook) then destroy kn1_cst_outlook
			
		
	end try
			


return k_return


end function

public function integer u_tree_riempi_treeview_root (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: File documenti
//--- torna >0 = ok; 0=nessuna operazione
//
integer k_return = 1, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_rit, k_long
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_tipo_oggetto_padre, k_query_select, k_query_where, k_query_order, k_string
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi, k_transmissiondate
boolean k_x_mese=true
int k_ind, k_nr_file, k_ctr_file, k_riga, k_righe_tot, k_ctr, k_pallet
string k_path, k_path1
datastore kds_docpath
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
//st_tab_clienti kst_tab_clienti
st_wm_pkl_web kst_wm_pkl_web[], kst_wm_pkl_web_file[], kst_wm_pkl_web_da_imp[]
st_treeview_file kst_treeview_file[]
//st_tab_docpath kst_tab_docpath
//st_tab_doctipo kst_tab_doctipo
//kuf_doctipo kuf1_doctipo
//kuf_certif kuf1_certif
//kuf_armo kuf1_armo


	try
//--- imposta path documenti interni
		k_path = kguo_path.get_doc_root_interno()
	
//		kuf1_certif = create kuf_certif
//		kuf1_armo = create kuf_armo
//		kuf1_doctipo = create kuf_doctipo
	
//		kst_tab_doctipo.tipo = kuf1_doctipo.kki_tipo_attestati
//		kst_tab_docpath.id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
//	
//		if kst_tab_docpath.id_doctipo > 0 then
		kds_docpath = create datastore
		kds_docpath.dataobject = "ds_docpath_l_x_tipo"
		kds_docpath.settransobject(kguo_sqlca_db_magazzino)
		k_righe_tot = kds_docpath.retrieve(0)
//		if kds_docpath.retrieve(kst_tab_docpath.id_doctipo) > 0 then
//				k_path1 = trim(kds_docpath.getitemstring( 1, "path"))
//			end if
//			if k_path1 > " " then
//				k_path += kkg.path_sep + k_path1
//			end if
//		end if		 
	
//--- Ricavo l'oggetto figlio dal DB 
		kst_tab_treeview.id = k_tipo_oggetto
		kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		k_tipo_oggetto_figlio = kst_tab_treeview.funzione
		 
//--- Ricavo il handle del Padre e il tipo Oggetto
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
	
		kst_treeview_data_any = kst_treeview_data.struttura
		k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)
		
//		if kst_treeview_data_any.st_treeview_file.tipo = "c" then
//	//		k_path += kkg.path_sep + kst_treeview_data_any.st_treeview_file.path //nome 
//			if kst_treeview_data_any.st_treeview_file.path > " " then
//				k_path = kst_treeview_data_any.st_treeview_file.path //nome 
//			end if
//		else
//			if kst_treeview_data_any.st_treeview_file.tipo = "f" then
//				k_return = 0  // schiacciato su file non fa nulla
//				k_handle_item_figlio = k_handle_item_padre
//				kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_no
//			end if
//		end if
//	
	
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

//--- finalmente riempie il treeview con entrambi i file XML e TXT			
			for k_riga = 1 to k_righe_tot
				kst_treeview_data.flag = k_x_mese
				kst_treeview_data.handle = 0
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
				kst_treeview_data.oggetto_padre = k_tipo_oggetto
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data_any.st_treeview_file.tipo = "c"
				kst_treeview_data_any.st_treeview_file.nome = trim(kds_docpath.getitemstring(k_riga, "path"))
				kst_treeview_data_any.st_treeview_file.path = k_path + kkg.path_sep + trim(kds_docpath.getitemstring(k_riga, "path"))
				kst_treeview_data_any.st_treeview_file.size = 0
 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
				kst_treeview_data.struttura = kst_treeview_data_any
				
				kst_treeview_data.label = trim(kst_treeview_data_any.st_treeview_file.nome) 

				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				ktvi_treeviewitem.selectedpictureindex = kuf1_treeview.kist_treeview_oggetto.pic_cartella
				ktvi_treeviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_cartella
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
		
			k_return = k_righe_tot + 1
		end if
		
 
	catch(uo_exception kuo1_exception)
		kGuo_exception.set_esito(kuo1_exception.get_st_esito())
		
	finally
//		if isvalid(kuf1_certif) then destroy kuf1_certif
//		if isvalid(kuf1_doctipo) then destroy kuf1_doctipo
//		if isvalid(kuf1_armo) then destroy kuf1_armo
		
	end try
		
 
return k_return


end function

on kuf_certif_file.create
call super::create
end on

on kuf_certif_file.destroy
call super::destroy
end on

event constructor;call super::constructor;//
//--- operazioni iniziali
//
kids_file = create datastore
kids_file.dataobject = "ds_treeview_file"

end event

