$PBExportHeader$kuf_wm_pklist_inout.sru
forward
global type kuf_wm_pklist_inout from kuf_wm_pklist
end type
end forward

global type kuf_wm_pklist_inout from kuf_wm_pklist
end type
global kuf_wm_pklist_inout kuf_wm_pklist_inout

type variables

//
kuf_wm_receiptgammarad kiuf1_wm_receiptgammarad 

end variables

forward prototypes
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function boolean get_wm_pklist_ext (ref st_wm_pklist kst_wm_pklist) throws uo_exception
public function long importa_wm_pklist_ext (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function long importa_wm_pklist_ext_tutti () throws uo_exception
public function st_esito set_barcode_in_wm_receiptgammarad (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe_arg) throws uo_exception
public function long get_id_cliente (string k_codice) throws uo_exception
public function st_esito toglie_id_meca_in_wm_receiptgammarad (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe)
public function long u_duplica_pklist (st_tab_wm_pklist ast_tab_wm_pklist, string a_idpkl_nuovo) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

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

public function boolean get_wm_pklist_ext (ref st_wm_pklist kst_wm_pklist) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie Packing-List grezzo nelle struct st_wm_pklist (st_tab_wm_pklist / st_tab_wm_pklist_righe[])
//---	inp: st_tab_wm_pklist.idpkl da importare se vuoto importa TUTTO
//---	out: st_wm_pklist 
//---	rit: true=importazione eseguita;  false=nessuna importazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
long k_ind
kuf_clienti kuf1_clienti
st_tab_clienti kst_tab_clienti
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_da_estrarre
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
	
 
	try

		kst_tab_wm_receiptgammarad_da_estrarre.packinglistcode = trim(kst_wm_pklist.st_tab_wm_pklist.idpkl)
		
//--- leggo dalla tabella dei pkl grezzi di wm
		if kiuf1_wm_receiptgammarad.get_pk_nuovi(kst_tab_wm_receiptgammarad_da_estrarre, kst_tab_wm_receiptgammarad[]) then

			k_ind = 1
			kst_wm_pklist.st_tab_wm_pklist.idpkl = trim(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)
			kst_wm_pklist.st_tab_wm_pklist.nrddt = trim(kst_tab_wm_receiptgammarad[k_ind].ddtcode)
			kst_wm_pklist.st_tab_wm_pklist.dtddt = date(kst_tab_wm_receiptgammarad[k_ind].ddtdate) 
//			if isnumber(trim(kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode)) then 
//			end if
			if len(trim(kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode)) > 0 then
				kst_wm_pklist.st_tab_wm_pklist.clie_1 = get_id_cliente(trim(kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode))
			else
				kst_wm_pklist.st_tab_wm_pklist.clie_1 = 0
			end if
			if len(trim(kst_tab_wm_receiptgammarad[k_ind].receivercustomercode)) > 0 then
				kst_wm_pklist.st_tab_wm_pklist.clie_2 = get_id_cliente(trim(kst_tab_wm_receiptgammarad[k_ind].receivercustomercode))
			else
				kst_wm_pklist.st_tab_wm_pklist.clie_2 = 0
			end if
			if len(trim(kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode)) > 0 then
				kst_wm_pklist.st_tab_wm_pklist.clie_3 = get_id_cliente(trim(kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode))
			else
				kst_wm_pklist.st_tab_wm_pklist.clie_3 = 0
			end if
//--- Se contratto "NC" allora impongo nulla 			
			if trim(kst_tab_wm_receiptgammarad[k_ind].specification) = "NC" then kst_tab_wm_receiptgammarad[k_ind].specification = ""
			kst_wm_pklist.st_tab_wm_pklist.sc_cf = trim(kst_tab_wm_receiptgammarad[k_ind].specification) 
			if trim(kst_tab_wm_receiptgammarad[k_ind].contract) = "NC" then kst_tab_wm_receiptgammarad[k_ind].contract = ""
			kst_wm_pklist.st_tab_wm_pklist.mc_co = trim(kst_tab_wm_receiptgammarad[k_ind].contract) 
			
			kst_wm_pklist.st_tab_wm_pklist.nrord = trim(kst_tab_wm_receiptgammarad[k_ind].ordercode) 
			kst_wm_pklist.st_tab_wm_pklist.dtord = date(kst_tab_wm_receiptgammarad[k_ind].orderdate) 

//--- Note Lotto da mettere sul Riferimento
			if len(trim(kst_tab_wm_receiptgammarad[k_ind].note_1)) > 0 then
				kst_wm_pklist.st_tab_wm_pklist.note_lotto = kst_tab_wm_receiptgammarad[k_ind].note_1 + kst_tab_wm_receiptgammarad[k_ind].note_2 + kst_tab_wm_receiptgammarad[k_ind].note_3
			end if

//--- get eventuale prefisso dei barcode (pklbcodepref)
			if kst_wm_pklist.st_tab_wm_pklist.clie_1 > 0 then
				kuf1_clienti = create kuf_clienti
				kst_tab_clienti.codice = kst_wm_pklist.st_tab_wm_pklist.clie_1
				kst_tab_clienti.pklbcodepref = kuf1_clienti.get_pklbcodepref(kst_tab_clienti)
				if isvalid(kuf1_clienti) then destroy kuf1_clienti
			else
				kst_tab_clienti.pklbcodepref = ""
			end if

//--- codice lotto indicato dal Mittente
			if trim(kst_tab_wm_receiptgammarad[k_ind].customerlot) > " " then
				kst_wm_pklist.st_tab_wm_pklist.customerlot = trim(kst_tab_wm_receiptgammarad[k_ind].customerlot)
			else
				kst_wm_pklist.st_tab_wm_pklist.customerlot = ""
			end if

//--- data e utente di importazione
			kst_wm_pklist.st_tab_wm_pklist.dtimportazione = kGuf_data_base.prendi_x_datins()
			kst_wm_pklist.st_tab_wm_pklist.tpimportazione = this.kki_tpimportazione_elettronico

//--- popolo le righe del pklist	
			for k_ind = 1 to UpperBound(kst_tab_wm_receiptgammarad[])

				if len(trim(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)) > 0 then

//--- aggiunge il prefisso al bcode del cliente come indicato in anagrafe se NON è da WEB
					if	trim(kst_tab_clienti.pklbcodepref) > " " &
					 		  and left(trim(kst_tab_wm_receiptgammarad[k_ind].externalpalletcode),3) <> "WWW" then 
						kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].wm_barcode = trim(kst_tab_clienti.pklbcodepref) + trim(kst_tab_wm_receiptgammarad[k_ind].externalpalletcode) 
					else
						kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].wm_barcode = trim(kst_tab_wm_receiptgammarad[k_ind].externalpalletcode) 
					end if
					
					if kst_tab_wm_receiptgammarad[k_ind].palletquantity > 0 then 
						kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].colli = kst_tab_wm_receiptgammarad[k_ind].palletquantity 
					else
						kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].colli = 1 
					end if
					kst_wm_pklist.st_tab_wm_pklist.collipkl += kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].colli 
					
					kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].idart_clie = trim(kst_tab_wm_receiptgammarad[k_ind].customeritem) 
					kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].idlotto_clie = trim(kst_tab_wm_receiptgammarad[k_ind].customerlot) 
					// q.tà TOTALE dei singoli sacchi o scatole nel pallet  
					kst_wm_pklist.st_tab_wm_pklist_righe[k_ind].qtapezzi_pallet = kst_tab_wm_receiptgammarad[k_ind].quantitasacchi
					
				end if
				
			end for

			kst_wm_pklist.st_tab_wm_pklist.colliddt = kst_wm_pklist.st_tab_wm_pklist.collipkl // in mancanza di un campo colli metto quelli di Packing List 
			
			k_return=true
	
		end if
	
	catch (uo_exception kuo_exception)
//		kst_esito.esito = kkg_esito.blok
//		kst_esito.sqlcode = k_rcn
//		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito!  ~n~r "  
//		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
	end try
			


return k_return


end function

public function long importa_wm_pklist_ext (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Importa Packing-List grezzo da Tabella del DB di MAGAZZINO-WAREHOUSE-MANAGEMENT
//---	nelle tabelle wm_pklist/wm_pklist_righe della Procedura
//---
//---	inp: kst_tab_wm_pklist.idpkl da importare
//---	out: utlimo idwmpklist importato
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
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg

					

try

	kuf1_utility = create kuf_utility
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

//--- leggo configurazione x lo scambio dati
	if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
////--- se importazione non bloccate faccio!
//		if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_no then
			
			kst_wm_pklist.st_tab_wm_pklist.idpkl = kst_tab_wm_pklist.idpkl
			kst_wm_pklist.st_tab_wm_pklist_cfg = kst_tab_wm_pklist_cfg

//--- valorizzo le struct dentro alla  st_wm_pklist  con le pklist grezze di WM da importare
			if get_wm_pklist_ext(kst_wm_pklist) then

				kst_wm_pklist.st_tab_wm_pklist.idimportazione = ""  //x ora non metto nulla
				
//--- se ho caricato qlc allora faccio le INSERT nelle tabelle di PACKING-LIST
				if add_wm_pklist( kst_wm_pklist) > 0 then
					
					k_id_wm_pklist_importato=kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist
					
//--- Imposto nella pklist di WM il id_wm_pklist così non ripeto piu' l'importazione
					kst_tab_wm_receiptgammarad.idwmpklist = kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist
					kst_tab_wm_receiptgammarad.packinglistcode = kst_wm_pklist.st_tab_wm_pklist.idpkl
					kiuf1_wm_receiptgammarad.set_idwmpklist(kst_tab_wm_receiptgammarad)

	//					kst_wm_pklist.st_tab_wm_pklist_cfg.ultimo_nome_file_importato = kst_wm_pklist.st_tab_wm_pklist_cfg.path_pklist_old

					kuf1_wm_pklist_cfg.set_ultimo_nome_file_importato(kst_wm_pklist.st_tab_wm_pklist_cfg)
					
				end if
				
			end if


//--- aggiorna tabelle wm_pklist e wm_pklist_righe
	
//		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )

	kGuf_data_base.errori_scrivi_esito ("I", kst_esito)
//	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
//		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
//	end if
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg	
	
end try

k_return = k_id_wm_pklist_importato

return k_return


end function

public function long importa_wm_pklist_ext_tutti () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Importa TUTTI i Packing-List grezzi da Tabella del DB di MAGAZZINO-WAREHOUSE-MANAGEMENT
//---	nelle tabelle wm_pklist/wm_pklist_righe della Procedura
//---
//---	inp: 
//---	out: 
//---	rit: conteggio PKL trasferiti
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0, k_ind, k_id_wm_pklist=0, k_ctr_wm_pklist
int k_rcn
boolean k_semaforo_ROSSO=false

st_esito kst_esito
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad


try

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

//--- leggo configurazione x lo scambio dati
	if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
//--- Importazione bloccata da PROPRIETA'
		if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_si then
			
			kguo_exception.inizializza( )
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Sbloccare le Importazioni da Proprietà Connessione del WM. Operazione NON eseguita"
			kguo_exception.set_esito(kst_esito)
			kguo_exception.setmessage("Trasferimento Packing-List", "Sbloccare le Importazioni da Proprietà Connessione del WM. Operazione NON eseguita")
			throw Kguo_exception

		else
			
//--- SEMAFORO ROSSO: importazione già in esecuzione
			k_semaforo_ROSSO = kuf1_wm_pklist_cfg.if_importa_in_esecuzione( )   
			
			if not k_semaforo_ROSSO then
				k_semaforo_ROSSO = kuf1_wm_pklist_cfg.set_importazione_ts_ini_on()  // SEMAFORO ROSSO
				 
				if kuf1_wm_receiptgammarad.get_idpkl_nuovi(kst_tab_wm_receiptgammarad[]) then
				
					for k_ind = 1 to upperbound(kst_tab_wm_receiptgammarad[])
						if len(trim(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)) > 0 then
							
	//--- Importa i singoli pklist grezzi da WM						
							kst_tab_wm_pklist.idpkl = trim(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)
							kst_tab_wm_pklist.id_wm_pklist = importa_wm_pklist_ext(kst_tab_wm_pklist) 
							
	//--- valore di ritorno						
							if kst_tab_wm_pklist.id_wm_pklist > 0 then
								k_ctr_wm_pklist ++
								//k_id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
							end if
							
						end if
				
					end for
					
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	kGuf_data_base.errori_scrivi_esito ("I", kst_esito)
//	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
//		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
//	end if
	throw kuo_exception
	
finally
	if k_semaforo_ROSSO then
		kuf1_wm_pklist_cfg.set_importazione_ts_ini_off()  // SEMAFORO VERDE
	end if
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg
	k_return = k_ctr_wm_pklist //k_id_wm_pklist
	
end try


return k_return


end function

public function st_esito set_barcode_in_wm_receiptgammarad (ref st_tab_wm_pklist_righe kst_tab_wm_pklist_righe_arg) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Aggiorna campo INTERNALPALLETCODE e ID_MECA di tutto il Packing-List di WM (grezzo) partendo da ID_MECA
//---	nelle tabelle wm_pklist/wm_pklist_righe della Procedura
//---
//---	inp: kst_tab_wm_receiptgammarad.id_meca
//---	out: 
//---	rit: TRUE=tutto ok
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long  k_ind, k_nr_barcode
int k_rcn
st_esito kst_esito
st_tab_barcode kst_tab_barcode[]
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
kuf_barcode kuf1_barcode
kuf_wm_pklist_righe kuf1_wm_pklist_righe
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
	kuf1_barcode = create kuf_barcode

//--- Piglio il ID_WM_PKLIST
	kst_tab_wm_pklist_righe.id_meca =	kst_tab_wm_pklist_righe_arg.id_meca
	kuf1_wm_pklist_righe.get_id_wm_pklist_da_id_meca(kst_tab_wm_pklist_righe)

//--- se packing esiste, elaboro...	
	if kst_tab_wm_pklist_righe.id_wm_pklist > 0 then

//--- Elaboro SOLO se Packing list di WM e' ancora da sistemare ovvero ancora da fare la doppia-lettura
		kst_tab_wm_receiptgammarad[1].idwmpklist = kst_tab_wm_pklist_righe.id_wm_pklist
		if not kuf1_wm_receiptgammarad.if_barcode_int_gia_impostato(kst_tab_wm_receiptgammarad[1]) then

//--- Piglio elenco Barcode da ID_MECA
			kst_tab_barcode[1].id_meca = kst_tab_wm_pklist_righe.id_meca
			k_nr_barcode = kuf1_barcode.get_barcode_da_id_meca(kst_tab_barcode[])
	
	//--- Piglio elenco ID da PKLIST grezzo
			kst_tab_wm_receiptgammarad[1].idwmpklist = kst_tab_wm_pklist_righe.id_wm_pklist
			kuf1_wm_receiptgammarad.get_id_da_idwmpkl(kst_tab_wm_receiptgammarad[])
		
			if k_nr_barcode < upperbound(kst_tab_wm_receiptgammarad[]) then
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlerrtext = "Numero Barcode prodotti (" + string(k_nr_barcode) & 
							+ ") inferiore al nr. Colli in Packing List ~n~rAggiornamento di " + string(upperbound(kst_tab_wm_receiptgammarad[])) + " colli eseguito comunque! "
			else			
				if k_nr_barcode > upperbound(kst_tab_wm_receiptgammarad[]) then
					kst_esito.esito = kkg_esito.err_logico
					kst_esito.sqlerrtext = "Numero Barcode prodotti (" + string(k_nr_barcode) &
							+ ") superiore al nr. Colli in Packing List ~n~rAggiornamento di " + string(upperbound(kst_tab_wm_receiptgammarad[])) + " colli eseguito comunque! "
				end if
			end if
			
			for k_ind = 1 to upperbound(kst_tab_wm_receiptgammarad[]) 
				
				if kst_tab_wm_receiptgammarad[k_ind].id > 0 then
					
	//--- 6-11-2008 I barcode secondo quanto indicato da ZANETTI corrispondono x 1 a 1 con i colli indicati nel PKL mandante
	//---				pertanto se trovo un numero diverso non so cosa fare.....
					if k_nr_barcode < k_ind then
						exit 
						
					else
	
	//--- aggiornamento in tabella PKLIST grezzo del BARCODE								
						kst_tab_wm_receiptgammarad[k_ind].id_meca = kst_tab_wm_pklist_righe.id_meca
						kst_tab_wm_receiptgammarad[k_ind].internalpalletcode = kst_tab_barcode[k_ind].barcode
						kuf1_wm_receiptgammarad.set_internalpalletcode(kst_tab_wm_receiptgammarad[k_ind])
	
					end if
				end if
		
			end for
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
//
//	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
//		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
//	end if
	
finally
	destroy kuf1_wm_receiptgammarad
	destroy kuf_wm_pklist_righe	
	destroy kuf_barcode	
	
end try

return kst_esito


end function

public function long get_id_cliente (string k_codice) throws uo_exception;//---
//--- Estrare il codice cliente da un campo stringa che può essere un P.IVA, C.F. o codice interno!
//---
st_esito kst_esito
st_tab_clienti kst_tab_clienti 
kuf_clienti kuf1_clienti
uo_exception kuo_exception


//try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_clienti = create kuf_clienti
	
	kst_esito = kuf1_clienti.get_codice_da_xyz( k_codice, kst_tab_clienti )
	
//	kst_tab_clienti.p_iva = k_codice
//	kuf1_clienti.get_codice_da_piva(kst_tab_clienti)
//	
//	if kst_tab_clienti.codice = 0 then
//		kst_tab_clienti.cf = k_codice 
//		kuf1_clienti.get_codice_da_cf(kst_tab_clienti)  
//	end if 
	if kst_esito.esito = kkg_esito.ok then
		if kst_tab_clienti.codice = 0 or isnull(kst_tab_clienti.codice) then 
			if isnumber(k_codice) and not isnull(kst_tab_clienti.codice) then 
				if long(trim(k_codice)) > 0 then
					kst_tab_clienti.codice = long(trim(k_codice))
				else
					kst_tab_clienti.codice = 0
				end if
			else
				kst_tab_clienti.codice = 0
			end if
		end if
	else
		if kst_esito.esito = kkg_esito.db_wrn or kst_esito.esito = kkg_esito.not_fnd then
			kst_tab_clienti.codice = 0
		else
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
		end if
	end if

//catch (uo_exception kuo_exception)
//	kst_esito = kuo_exception.get_st_esito()
	
//finally
	destroy kuf1_clienti
	
//end try
	

return kst_tab_clienti.codice
end function

public function st_esito toglie_id_meca_in_wm_receiptgammarad (st_tab_wm_pklist_righe kst_tab_wm_pklist_righe);//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Pulisce la ReceiptGammarad dai Dati ID_MECA e BARCODE (INTERNALPALLETCODE) 
//---
//---	inp: kst_tab_wm_pklist_righe.id_meca
//---	out: 
//---	rit: TRUE=tutto ok
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad

//--- se packing esiste, elaboro...	
	if kst_tab_wm_pklist_righe.id_meca > 0 then

//--- Cancella Barcode e ID_MECA dalla ReceiptGammarad di WM
		kst_tab_wm_receiptgammarad.id_meca = kst_tab_wm_pklist_righe.id_meca
		kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit = "N"
		kst_esito = kuf1_wm_receiptgammarad.toglie_internalpalletcode(kst_tab_wm_receiptgammarad) 
		if kst_esito.esito = kkg_esito.ok then

			kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit = kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit
			kst_esito = kuf1_wm_receiptgammarad.toglie_id_meca(kst_tab_wm_receiptgammarad) 
			
		end if
			
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )

finally
	destroy kuf1_wm_receiptgammarad
	
end try

return kst_esito


end function

public function long u_duplica_pklist (st_tab_wm_pklist ast_tab_wm_pklist, string a_idpkl_nuovo) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Duplica un Packing-List 
//---	 tabelle wm_pklist/wm_pklist_righe della Procedura
//---
//---	inp: ast_tab_wm_pklist.id_wm_pklist da duplicare + a_idpkl_nuovo (se vuoto lo produce in automatico)
//---	out: 
//---	rit: il nuovo id_wm_pklist 
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
//long k_id_wm_pklist_importato=0
long k_riga, k_righe
int k_rcn
string k_nome_file=""
datastore kds_testa, kds_righe
st_esito kst_esito
st_wm_pklist kst_wm_pklist
st_tab_wm_pklist kst_tab_wm_pklist
kuf_wm_pklist_testa kuf1_wm_pklist_testa
					

try

	if ast_tab_wm_pklist.id_wm_pklist > 0 then
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = &
	"Errore in duplicazione Packing-List, manca il codice da duplicare" //~n~r" &
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//	kuf1_utility = create kuf_utility
	kuf1_wm_pklist_testa = create kuf_wm_pklist_testa

//--- get codice da duplicare
	kst_tab_wm_pklist.idpkl = kuf1_wm_pklist_testa.get_idpkl(ast_tab_wm_pklist)

//--- get nuovo codice
	if trim(a_idpkl_nuovo) > " " then
	else
		kst_tab_wm_pklist.idpkl = kuf1_wm_pklist_testa.u_get_idpkl_duplicato(kst_tab_wm_pklist)
	end if

	kds_testa = create datastore
	kds_testa.dataobject = "ds_wm_pklist_testa"
	kds_testa.settransobject( kguo_sqlca_db_magazzino )
	if kds_testa.retrieve(ast_tab_wm_pklist.id_wm_pklist) > 0 then
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = &
	"Packing-List " + string(ast_tab_wm_pklist.id_wm_pklist) + " inesistente, errore in duplicazione  " //~n~r" &
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kds_righe = create datastore
	kds_righe.dataobject = "ds_wm_pklist_righe"
	kds_righe.settransobject( kguo_sqlca_db_magazzino )
	if kds_righe.retrieve(ast_tab_wm_pklist.id_wm_pklist) > 0 then
	else
		kst_esito.sqlcode = 0
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = &
	"Packing-List " + string(ast_tab_wm_pklist.id_wm_pklist) + " inesistente, errore in duplicazione righe " //~n~r" &
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_wm_pklist.idpkl = kuf1_wm_pklist_testa.get_idpkl(ast_tab_wm_pklist)
	
	kds_testa.setitem(1, "idpkl", kst_tab_wm_pklist.idpkl) 		
	kds_testa.setitem(1, "id_wm_pklist_padre", kds_testa.getitemnumber(1, "id_wm_pklist")) 		
	kds_testa.setitem(1, "id_wm_pklist", 0) 	
	kds_testa.setitem(1, "stato", kki_STATO_nuovo)
	kds_testa.setitem(1, "note", "Duplicato dal " + ast_tab_wm_pklist.idpkl + " id " + string(ast_tab_wm_pklist.id_wm_pklist) &
					 + " il " + string(kGuf_data_base.prendi_x_datins(), "dd-mmm-yy hh:mm"))
	kds_testa.setitem(1, "x_datins_elim", datetime(date(0))) 		
	kds_testa.setitem(1, "x_utente_elim", "") 		
	kds_testa.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins()) 		
	kds_testa.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente()) 		
	kds_testa.setitem(1, "tpimportazione", kki_TPIMPORTAZIONE_MANUALE) 		
	kds_testa.setitem(1, "dtimportazione", kGuf_data_base.prendi_x_datins()) 	 		

	kds_testa.resetupdate( )
	kds_testa.SetItemStatus(1, 0, Primary!, NewModified!)
	k_rcn = kds_testa.update()
	if k_rcn > 0 then
	else
		kst_esito.sqlcode = k_rcn
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = &
	"Duplica testata del Packing-List " + string(ast_tab_wm_pklist.id_wm_pklist) + " fallita!" //~n~rerrore" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get del id del PKL appena caricato
	kst_tab_wm_pklist.id_wm_pklist  = kuf1_wm_pklist_testa.get_id_wm_pklist_max()
//	if kst_esito.esito = kkg_esito.ok then
//	else
//		kst_esito.SQLErrText = &
//	"Duplica testata del Packing-List " + string(ast_tab_wm_pklist.id_wm_pklist) + " fallita!~n~r" + kst_esito.SQLErrText
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	k_righe = kds_righe.rowcount( )
	kds_righe.resetupdate( )
	for k_riga = 1 to k_righe
		kds_righe.setitem(k_riga, "id_wm_pklist_riga", 0) 	
		kds_righe.setitem(k_riga, "id_wm_pklist", kst_tab_wm_pklist.id_wm_pklist) 	
		kds_righe.setitem(k_riga, "stato", kki_STATO_nuovo)
		kds_righe.setitem(k_riga, "id_meca", 0) 		
		kds_righe.setitem(k_riga, "id_armo", 0) 		
		kds_righe.setitem(k_riga, "x_datins_elim", datetime(date(0))) 			
		kds_righe.setitem(k_riga, "x_utente_elim", "") 		
		kds_righe.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins()) 		
		kds_righe.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente()) 		
		kds_righe.SetItemStatus(k_riga, 0, Primary!, NewModified!)
	next
	k_rcn = kds_righe.update()
	if k_rcn > 0 then
	else
		kst_esito.sqlcode = k_rcn
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.SQLErrText = &
	"Duplica testata del Packing-List " + string(ast_tab_wm_pklist.id_wm_pklist) + " fallita!" //~n~rerrore" 
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kguo_sqlca_db_magazzino.db_commit()
	
	k_return = kst_tab_wm_pklist.id_wm_pklist
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )

//	kGuf_data_base.errori_scrivi_esito ("I", kst_esito)
//	if len(trim(ast_tab_wm_pklist_cfg.file_esiti )) > 0 then
//		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, ast_tab_wm_pklist_cfg.file_esiti )
//	end if
	
finally
	if isvalid(kuf1_wm_pklist_testa) then destroy kuf1_wm_pklist_testa	
	if isvalid(kds_testa) then destroy kds_testa	
	if isvalid(kds_righe) then destroy kds_righe	
	
end try


return k_return


end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_ctr = importa_wm_pklist_ext_tutti( ) 
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." + "Ci sono " + string(k_ctr) + " Packing-List Clienti pronte per essere importate come Riferimento.  " 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Packing-List Cliente trovato pronto per fare il Riferimento."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_wm_pklist_inout.create
call super::create
end on

on kuf_wm_pklist_inout.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad 

end event

event destructor;call super::destructor;//
if not isnull(kiuf1_wm_receiptgammarad) then destroy kiuf1_wm_receiptgammarad

end event

