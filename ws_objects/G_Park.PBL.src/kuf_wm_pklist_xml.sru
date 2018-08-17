$PBExportHeader$kuf_wm_pklist_xml.sru
forward
global type kuf_wm_pklist_xml from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_xml from kuf_wm_pklist
string kki_stato_nuovo = "1"
string kki_stato_importato = "4"
string kki_stato_chiuso = "9"
string kki_eliminato_si = "S"
string kki_tpimportazione_file = "F"
string kki_tpimportazione_manuale = "M"
end type
global kuf_wm_pklist_xml kuf_wm_pklist_xml

type variables


end variables

forward prototypes
public function boolean get_xml (string k_nomepathfilexml, ref st_wm_pklist kst_wm_pklist) throws uo_exception
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function long importa_xml (string k_nomepathfile) throws uo_exception
end prototypes

public function boolean get_xml (string k_nomepathfilexml, ref st_wm_pklist kst_wm_pklist) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	importa Packing-List grezzo XML nelle struct st_wm_pklist (st_tab_wm_pklsi / st_tab_wm_pklist_righe[])
//---	inp: nome file XML
//---	out: st_wm_pklist 
//---	rit: true=importazione eseguita;  false=nessuna importazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
st_esito kst_esito
datastore kds_pklist_xml


kds_pklist_xml = create datastore

//--- datasore del Pklist xml IMPORTAZIONE!
	kds_pklist_xml.dataobject = "d_wm_pklist_xml"
	k_rcn = kds_pklist_xml.importfile( XML!, k_nomePathFileXML)
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Importazione file XML 'Packing-List' fallito!  ~n~rFile xml: "  &
											+ k_nomePathFileXML
		kguo_exception.set_esito(kst_esito)
		destroy kds_pklist_xml
		throw kguo_exception
	end if
			
	if kds_pklist_xml.rowcount( ) > 0 then
		k_return=true
	end if


	destroy kds_pklist_xml

return k_return


end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);// 
//
//--- Visualizza Listview
//
integer k_return = 0, k_rc, k_pic_list
long k_handle_item = 0, k_handle_item_padre = 0, k_handle, k_handle_item_corrente, k_handle_item_rit
long k_handle_item_figlio = 0
string k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
integer k_ctr
string k_stato_barcode="", k_tipo_oggetto_padre, k_label, k_stato
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_gru kst_tab_gru
st_tab_meca kst_tab_meca
st_tab_treeview kst_tab_treeview
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_profilestring_ini kst_profilestring_ini



		 
		 
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
		
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		k_pic_list = kuf1_treeview.u_dammi_pic_tree_list(k_tipo_oggetto)			

//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
//--- cancello dalla listview tutto
		kuf1_treeview.kilv_lv1.DeleteItems()

		ktvi_treeviewitem.selected = false

//--- Insert del primo item in lista quello di default del 'ritorno'
		kst_treeview_data.oggetto = k_tipo_oggetto
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)


				 

		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
					

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		k_campo[k_ind] = "Nome File "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "note "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "path "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "FINE"
		k_align[k_ind] = left!
			
//--- controllo in modo un po' emirico di non essere già dentro 	all'elenco confrontando un campo	
		k_ind=2
		kuf1_treeview.kilv_lv1.getColumn(k_ind, k_label, k_align_1, k_ctr) 
		if trim(k_label) <> trim(k_campo[k_ind]) then 
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
	
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"
	
				kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	
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
	

		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

	
//--- ID di estrazione, se a a zero allora Nulla
		kst_treeview_data_any = kst_treeview_data.struttura
		
//		if kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist > 0 then
//
//
//			k_query_select = &
//			"  	SELECT " &
//			+ "	wm_pklist_righe.id_wm_pklist_riga, " &  
//			+ "	wm_pklist.idpkl, " &  
//			+ "	wm_pklist_righe.areamag, " &  
//			+ "	wm_pklist_righe.stato, " &  
//			+ "	wm_pklist_righe.colli,   " & 
//			+ "	wm_pklist_righe.idart_clie,  " & 
//			+ "	wm_pklist_righe.id_armo, " &  
//			+ "	wm_pklist_righe.id_meca, " &  
//			+ "	wm_pklist_righe.gruppo,  " & 
//			+ "	gru.des	 " &   
//			+ "	,meca.num_int	 " &   
//			+ "	,meca.data_int	 " &   
//			+ "	FROM wm_pklist_righe "       &    
//			+ "	  inner JOIN wm_pklist ON  " &   
//			+ "	wm_pklist_righe.id_wm_pklist = wm_pklist.id_wm_pklist " &
//			+ "	  left outer JOIN gru ON  " &   
//			+ "	wm_pklist_righe.gruppo = gru.codice " &
//			+ "	  left outer JOIN meca ON  " &   
//			+ "	wm_pklist_righe.id_meca = meca.id " 
//			
//			k_query_where = " where " &
//				+ "  wm_pklist_righe.id_wm_pklist = "+ string(kst_treeview_data_any.st_tab_wm_pklist.id_wm_pklist) + " " 
//		
//			k_query_order = &
//			 " order by " &
//				+ "	wm_pklist_righe.areamag, wm_pklist_righe.id_wm_pklist_riga "
//		
//		//--- Composizione della Query	
//			if len(trim(k_query_where)) > 0 then
//				declare kc_treeview dynamic cursor for SQLSA ;
//				k_query_select = k_query_select + k_query_where + k_query_order
//				prepare SQLSA from :k_query_select using sqlca;
//			end if		
//			 
//			open dynamic kc_treeview ;
//						
//						
//			if sqlca.sqlcode = 0 then
//				
//				fetch kc_treeview 
//					into
//						:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
//						:kst_tab_wm_pklist.idpkl,   
//						:kst_tab_wm_pklist_righe.areamag,   
//						:kst_tab_wm_pklist_righe.stato,   
//						:kst_tab_wm_pklist_righe.colli,   
//						:kst_tab_wm_pklist_righe.idart_clie,   
//						:kst_tab_wm_pklist_righe.id_armo,   
//						:kst_tab_wm_pklist_righe.id_meca,   
//						:kst_tab_wm_pklist_righe.gruppo,   
//						:kst_tab_gru.des
//						,:kst_tab_meca.num_int	    
//						,:kst_tab_meca.data_int	    
//					  ;
//		
//				
//				do while sqlca.sqlcode = 0
//	
//				kst_treeview_data.oggetto = k_tipo_oggetto_figlio
//				kst_treeview_data.oggetto_padre = k_tipo_oggetto
//				kst_treeview_data.struttura = kst_treeview_data_any
//				kst_treeview_data.oggetto_listview = k_tipo_oggetto
//				
//				klvi_listviewitem.data = kst_treeview_data
//
//				klvi_listviewitem.pictureindex = k_pic_list
//			   
//				klvi_listviewitem.selected = false
//				
//				k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
//
//		
//					choose case kst_tab_wm_pklist_righe.stato
//						case this.kki_stato_nuovo
//							k_stato = "da Importare"
//						case this.kki_stato_importato
//							k_stato = "Importato nel Lotto di magazzino"
//						case this.kki_stato_chiuso
//							k_stato = "Chiuso"
//						case else
//							k_stato = "?????????"
//					end choose
//		
//					k_ind=1
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist.idpkl))
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist_righe.areamag))
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, k_stato + " (" + trim(kst_tab_wm_pklist_righe.stato) + ") " )
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_pklist_righe.idart_clie))
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.gruppo) + " - " +  trim(kst_tab_gru.des))
//					k_ind++
//					if kst_treeview_data_any.st_tab_meca.num_int > 0 then
//						kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_treeview_data_any.st_tab_meca.num_int) + " del " +  string(kst_treeview_data_any.st_tab_meca.data_int))
//					else
//						kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, " ")
//					end if
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.colli))
//					k_ind++
//					kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_pklist_righe.id_wm_pklist_riga)) 
//					
//					
//		//--- Leggo rec next dalla tree				
//					k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
//
//					fetch kc_treeview 
//						into
//							:kst_tab_wm_pklist_righe.id_wm_pklist_riga,   
//							:kst_tab_wm_pklist.idpkl,   
//							:kst_tab_wm_pklist_righe.areamag,   
//							:kst_tab_wm_pklist_righe.stato,   
//							:kst_tab_wm_pklist_righe.colli,   
//							:kst_tab_wm_pklist_righe.idart_clie,   
//							:kst_tab_wm_pklist_righe.id_armo,   
//							:kst_tab_wm_pklist_righe.id_meca,   
//							:kst_tab_wm_pklist_righe.gruppo,   
//							:kst_tab_gru.des
//							,:kst_tab_meca.num_int	    
//							,:kst_tab_meca.data_int	    
//						  ;
//		
//		
//				loop
//				close kc_treeview;
//				
////--- Aggiorna il primo item in lista quello di default del 'ritorno'
//				kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
//				kst_treeview_data = ktvi_treeviewitem.data
//				if k_handle_item_padre > 0 then
////--- prendo il item padre per settare il ritorno di default
//					k_handle_item = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_padre)
//					if k_handle_item <= 0 then
//						k_handle_item = 1
//					end if
//				else
//					k_handle_item = 1
//				end if
//				kst_treeview_data.handle_padre = k_handle_item_padre
//				kst_treeview_data.handle = k_handle_item
//				kst_treeview_data.oggetto_listview = k_tipo_oggetto
//				kst_treeview_data.oggetto = ""
//				klvi_listviewitem.label = ".."
//				klvi_listviewitem.data = kst_treeview_data
//				klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
//				kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
//				
//			end if				
//		end if
	end if
 
//		 
//	if kuf1_treeview.kilv_lv1.totalitems() > 1 then
//		
////--- Attivo Drag and Drop 
//		kuf1_treeview.kilv_lv1.DragAuto = True 
//
////--- Attivo multi-selezione delle righe 
//		kuf1_treeview.kilv_lv1.extendedselect = true 
//			
//	end if


 
return k_return

 
 
 


end function

public function long importa_xml (string k_nomepathfile) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---   Importa Packing-List grezzo XML nelle tabelle wm_pklist/wm_pklist_righe
//---
//---	inp: nome file con PATH
//---	out: 
//---	rit: ID del Packing List
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
long k_id_wm_pklist_importato=0
boolean k_rc
int k_rcn
string k_nome_file=""
st_esito kst_esito
st_wm_pklist kst_wm_pklist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg


try

	kuf1_utility = create kuf_utility
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

//--- leggo configurazione x lo scambio dati
	if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
//--- se importazione non bloccate faccio!
		if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_no then
			
			kst_wm_pklist.st_tab_wm_pklist_cfg = kst_tab_wm_pklist_cfg

			k_nome_file = kuf1_utility.u_get_nome_file(k_nomePathFile)
			
			kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp += lower(k_nome_file)
			kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old += lower(k_nome_file)
			
//			if len(trim(kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_new)) > 0 then  
				
//--- copio il file nella cartella TEMP quella di Lavoro				
			if lower(k_nomePathFile) <> lower(kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp) then
				k_rcn = fileCopy( k_nomePathFile, kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp, TRUE )
				if k_rcn < 0 then
					kst_esito.esito = kkg_esito_blok
					kst_esito.sqlcode = k_rcn
					kst_esito.SQLErrText = "Copia file XML 'Packing-List' nella cartella Temporanea fallito.  ~n~rDa: "  &
												+ k_nomePathFile & 
												+ "~n~ra: "+kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp
					kguo_exception.set_esito(kst_esito)
					destroy kuf1_utility
					destroy kuf1_wm_pklist_cfg	
					throw kguo_exception
				end if
			end if	

//--- valorizzo struct st_wm_pklist dal file XML
			if get_xml(kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp, kst_wm_pklist) then

				kst_wm_pklist.st_tab_wm_pklist.fileimportato = lower(k_nome_file)
				
//--- se ho caricato qlc allora faccio le INSERT nelle tabelle di PACKING-LIST
				if add_wm_pklist( kst_wm_pklist) > 0 then
					k_id_wm_pklist_importato=kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist
					
					kst_wm_pklist.st_tab_wm_pklist_cfg.ultimo_nome_file_importato = kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old
					kuf1_wm_pklist_cfg.set_ultimo_nome_file_importato(kst_wm_pklist.st_tab_wm_pklist_cfg)
					
				end if
				
			end if

			if lower(k_nomePathFile) <> lower(kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old) then
				k_rcn = fileCopy(kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp, kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old, TRUE )
				if k_rcn < 0 then
					kst_esito.esito = kkg_esito_blok
					kst_esito.sqlcode = k_rcn
					kst_esito.SQLErrText = "Copia file XML 'Packing-List' nella cartella Importati, fallito.  ~n~rDa: "  &
												+ kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp & 
												+ "~n~ra: "+kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old
					kguo_exception.set_esito(kst_esito)
					destroy kuf1_utility
					destroy kuf1_wm_pklist_cfg	
					throw kguo_exception
				end if
			end if	

//--- cancello file dalle cartelle di Origine e di Lavoro (temp)
			fileDelete(k_nomePathFile)
			fileDelete(kst_wm_pklist.st_tab_wm_pklist_cfg.path_temp)

//--- aggiorna tabelle wm_pklist e wm_pklist_righe
	
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )

	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
		kuf1_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
	end if
	
finally
	destroy kuf1_utility
	destroy kuf1_wm_pklist_cfg	
	
end try

k_return = k_id_wm_pklist_importato

return k_return


end function

on kuf_wm_pklist_xml.create
call super::create
end on

on kuf_wm_pklist_xml.destroy
call super::destroy
end on

