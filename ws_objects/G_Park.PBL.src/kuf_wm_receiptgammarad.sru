$PBExportHeader$kuf_wm_receiptgammarad.sru
forward
global type kuf_wm_receiptgammarad from kuf_parent
end type
end forward

global type kuf_wm_receiptgammarad from kuf_parent
end type
global kuf_wm_receiptgammarad kuf_wm_receiptgammarad

type variables

//---- campo ACCEPT del WM PK-LIST Mandante
string kki_ACCEPT_si = 'True' // Accettato dal WM è importabile
string kki_ACCEPT_no = 'False' // NON accettato da WM

end variables

forward prototypes
public function st_esito set_idwmpklist (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function string get_id_programma (string k_flag_modalita)
public function boolean get_pk_nuovi (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_input, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function boolean get_idpkl_nuovi (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public subroutine if_isnull (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function integer u_tree_open (string k_modalita, st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[], ref datawindow kdw_anteprima)
public function st_esito set_internalpalletcode (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function boolean get_id_da_idwmpkl (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function boolean if_barcode_int_gia_impostato (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
public function st_esito tb_delete (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function boolean get_area_magazzino (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function st_esito tb_add (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public subroutine set_null (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_null)
public function st_esito get_idwmpkl_readed (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function st_esito toglie_internalpalletcode (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function st_esito toglie_id_meca (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad)
public function long crea (long k_nr_ws_receiptgammarad, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function boolean set_accept_true (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
public function boolean set_accept_false (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
public function boolean if_lotto_associato (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
end prototypes

public function st_esito set_idwmpklist (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Imposta idwmpklist  sul pklist grezzo
//=== 
//=== Input: st_tab_wm_receiptgammarad.id_wm_receiptgammarad 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if NOT isnull(kst_tab_wm_receiptgammarad.idwmpklist) then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (idwmpklist) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then

					rollback using kGuo_sqlca_db_wm;
					
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then

					commit using kGuo_sqlca_db_wm;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito_db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if

				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
	
		finally
			kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			
	
		end try
		
	end if
	
end if



return kst_esito

end function

public function string get_id_programma (string k_flag_modalita);//
string k_return=""
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti


	kst_tab_menu_window_oggetti.funzione = trim(k_flag_modalita)
	kst_tab_menu_window_oggetti.nome_oggetto = ki_nomeOggetto
	if kguf_menu_window.get_id_menu_window(kst_tab_menu_window_oggetti) then

		k_return = trim(kst_tab_menu_window_oggetti.id_menu_window)
		
	end if

return k_return
end function

public function boolean get_pk_nuovi (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_input, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie righe Packing-List grezzo  nella array struct st_wm_receiptgammarad
//---	inp: kst_tab_wm_receiptgammarad_input.packinglistcode da estrarre se vuoto piglio tutti
//---	out: st_wm_receiptgammarad[] 
//---	rit: true=importazione eseguita;  false=nessuna importazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
long k_ind
st_esito kst_esito
datastore kds_wm_receiptgammarad, kds_wm_receiptgammarad_note_lotto


	kGuo_sqlca_db_wm.db_connetti()
	kds_wm_receiptgammarad = create datastore
	kds_wm_receiptgammarad_note_lotto = create datastore

	if isnull(kst_tab_wm_receiptgammarad_input.packinglistcode) then kst_tab_wm_receiptgammarad_input.packinglistcode = ""


//--- datastore del Pklist x IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kguo_sqlca_db_wm)
	if k_rcn >= 0 then
		k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad_input.packinglistcode)
	end if
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito!  ~n~r "  
		kguo_exception.set_esito(kst_esito)
		destroy kds_wm_receiptgammarad
		throw kguo_exception
	end if

//--- datastore che serve SOLO per IMPORTARE le note_1/3 
	kds_wm_receiptgammarad_note_lotto.dataobject = "d_wm_receiptgammarad_inout_note_lotto"
	k_rcn = kds_wm_receiptgammarad_note_lotto.settransobject(kguo_sqlca_db_wm)
	if k_rcn >= 0 then
		k_rcn = kds_wm_receiptgammarad_note_lotto.retrieve(kst_tab_wm_receiptgammarad_input.packinglistcode)
	end if
			
	if kds_wm_receiptgammarad.rowcount( ) > 0 then
		
		k_return=true
		
		for k_ind = 1 to  kds_wm_receiptgammarad.rowcount( )
			
			kst_tab_wm_receiptgammarad[k_ind].packinglistcode = kds_wm_receiptgammarad.getitemstring( k_ind, "packinglistcode")  // codice Lotto
			kst_tab_wm_receiptgammarad[k_ind].ddtcode = kds_wm_receiptgammarad.getitemstring( k_ind, "ddtcode")
			kst_tab_wm_receiptgammarad[k_ind].ddtdate = kds_wm_receiptgammarad.getitemdatetime( k_ind, "ddtdate")
			kst_tab_wm_receiptgammarad[k_ind].externalpalletcode = kds_wm_receiptgammarad.getitemstring( k_ind, "externalpalletcode") // Barcode-Cliente
			kst_tab_wm_receiptgammarad[k_ind].palletquantity = kds_wm_receiptgammarad.getitemnumber( k_ind, "palletquantity") 
			kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode = kds_wm_receiptgammarad.getitemstring( k_ind, "mandatorcustomercode") // mand
			kst_tab_wm_receiptgammarad[k_ind].receivercustomercode = kds_wm_receiptgammarad.getitemstring( k_ind, "receivercustomercode") // ricevente
			kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode = kds_wm_receiptgammarad.getitemstring( k_ind, "invoicecustomercode") // fatturato
			kst_tab_wm_receiptgammarad[k_ind].specification = kds_wm_receiptgammarad.getitemstring( k_ind, "specification")  // Capitolato
			kst_tab_wm_receiptgammarad[k_ind].contract = kds_wm_receiptgammarad.getitemstring( k_ind, "contract")  // Contratto-Commerciale
			kst_tab_wm_receiptgammarad[k_ind].ordercode = kds_wm_receiptgammarad.getitemstring( k_ind, "ordercode")  // Ordine numero
			kst_tab_wm_receiptgammarad[k_ind].orderdate = kds_wm_receiptgammarad.getitemdatetime( k_ind, "orderdate")  // Ordine data
			kst_tab_wm_receiptgammarad[k_ind].customeritem = kds_wm_receiptgammarad.getitemstring( k_ind, "customeritem")  // Articolo codice x il cliente
			kst_tab_wm_receiptgammarad[k_ind].customerlot = kds_wm_receiptgammarad.getitemstring( k_ind, "customerlot")  // Lotto  codice x il cliente

			if kds_wm_receiptgammarad_note_lotto.rowcount( ) = 0 then
				kst_tab_wm_receiptgammarad[k_ind].note_1 = ""
				kst_tab_wm_receiptgammarad[k_ind].note_2 = ""
				kst_tab_wm_receiptgammarad[k_ind].note_3 = ""
			else
				kst_tab_wm_receiptgammarad[k_ind].note_1 = kds_wm_receiptgammarad_note_lotto.getitemstring( 1, "note_1")  // Note del Lotto
				kst_tab_wm_receiptgammarad[k_ind].note_2 = kds_wm_receiptgammarad_note_lotto.getitemstring( 1, "note_2")  // Note del Lotto
				kst_tab_wm_receiptgammarad[k_ind].note_3 = kds_wm_receiptgammarad_note_lotto.getitemstring( 1, "note_3")  // Note del Lotto
			end if
			
		end for
		
	end if


	destroy kds_wm_receiptgammarad

return k_return


end function

public function boolean get_idpkl_nuovi (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Torna tabella IDPKL ancora da importare 
//---	inp: 
//---	out: st_wm_receiptgammarad[].idpkl 
//---	rit: true=operazione eseguita;  false=nessuna operazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
long k_ind
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_input
datastore kds_wm_receiptgammarad


	kGuo_sqlca_db_wm.db_connetti()

	kds_wm_receiptgammarad = create datastore

//--- datasore del Pklist xml IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_idpkl_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kguo_sqlca_db_wm)
	kst_tab_wm_receiptgammarad_input.packinglistcode = ""
	k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad_input.packinglistcode)
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Estrazione 'idpkl' di Nuovi 'Packing-List' fallito!  ~n~r "  
		kguo_exception.set_esito(kst_esito)
		destroy kds_wm_receiptgammarad
		throw kguo_exception
	end if
			
	if kds_wm_receiptgammarad.rowcount( ) > 0 then
		
		k_return=true
		
		for k_ind = 1 to  kds_wm_receiptgammarad.rowcount( )
			
			kst_tab_wm_receiptgammarad[k_ind].packinglistcode = kds_wm_receiptgammarad.getitemstring( k_ind, "packinglistcode")  // codice Lotto

		end for
		
	end if


	destroy kds_wm_receiptgammarad

return k_return


end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, string k_tipo_oggetto);//
//--- Visualizza Treeview: Testata Fatture
//
integer k_return = 0, k_rc
long k_handle_item=0, k_handle_item_padre=0, k_handle_item_figlio=0, k_handle_item_nonno=0, k_handle_item_rit
integer k_pic_open, k_pic_close, k_mese, k_anno
string k_dataoggix, k_stato, k_tipo_oggetto_figlio, k_tipo_oggetto_nonno
string k_query_select, k_query_where, k_query_order
datetime k_data_da, k_data_a, k_data_0, k_data_meno3mesi
int k_ind, k_ctr
string k_label
//alignment k_align[15]
//alignment k_align_1
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti



	try 

		k_data_0 = datetime(date(0)	)

		kguo_sqlca_db_wm.db_connetti( ) // se non connesso connette!
		 
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
		k_data_a = datetime(date(0))
		
	//--- Periodo di estrazione, se la data e' a zero allora anno in DATAOGGI
		kst_treeview_data_any = kst_treeview_data.struttura
		if date(kst_treeview_data_any.st_tab_wm_receiptgammarad.ddtdate) = date (0) then
	
	//--- Ricavo la data da dataoggi
			kst_treeview_data_any.st_tab_wm_receiptgammarad.ddtdate = datetime(kG_dataoggi)
			
		end if
		
		if k_data_da = datetime(date(0)) then
			k_mese = month(date(kst_treeview_data_any.st_tab_wm_receiptgammarad.ddtdate)) 
			k_anno = year(date(kst_treeview_data_any.st_tab_wm_receiptgammarad.ddtdate))
			k_data_da = datetime(date (k_anno, k_mese, 01)) 
			if k_mese = 12 then
				k_mese = 1
				k_anno ++
			else
				k_mese = k_mese + 1
			end if
			k_data_a = datetime(RelativeDate((date(k_anno, k_mese, 01)), -1) )
		end if
			 
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
			if kst_esito.esito = kkg_esito_ok then
				ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open
				ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
	//			k_pic_list = kst_tab_treeview.pic_close
			end if
		
	//--- data oggi -3 mesi
			k_data_meno3mesi = datetime(relativedate(kg_dataoggi, -1190))
	
	//--- Cancello gli Item dalla tree prima di ripopolare
			kuf1_treeview.u_delete_item_child(k_handle_item_padre)
	
	//
	////--- se richiesto + di 2 mesi allora RIDUCO a solo l'ultima settimana altrimenti query TROPPO PESANTE
	//		if DaysAfter ( date(k_data_da), date(k_data_a) ) > 61 then
	//			kst_tab_wm_receiptgammarad.dtimportazione = k_data_da
	//			kst_esito = get_ultimo_doc_ins(kst_tab_wm_receiptgammarad)
	//			if kst_esito.esito = kkg_esito_ok then
	//				k_data_a = kst_tab_wm_receiptgammarad.dtimportazione
	//				k_data_da = datetime(relativedate(date(k_data_a) , -7))
	//			else
	//				//--- se errore non vedo NULLA!
	//				k_data_da = k_data_a
	//			end if
	//		end if
	//
	
			ktvi_treeviewitem.selected = false
	
			k_query_select = &
			"  SELECT " &
			+ " receiptgammarad.packinglistcode,   " &
			+ " receiptgammarad.ddtcode,  " &
			+ " receiptgammarad.ddtdate,  " &
			+ " sum(receiptgammarad.palletquantity), " &
			+ " receiptgammarad.mandatorcustomercode, "  &
			+ " receiptgammarad.receivercustomercode,  " &
			+ " receiptgammarad.invoicecustomercode,  " &
			+ " receiptgammarad.accept,  " &
			+ " receiptgammarad.specification,  " &
			+ " receiptgammarad.contract  " &
			+ "  FROM receiptgammarad  " 
			
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_imp
					k_query_where = " where " &
							+ "  receiptgammarad.idwmpklist is null OR receiptgammarad.idwmpklist = 0 " &
//						+ "  (wm_pklist.eliminato is null or wm_pklist.eliminato <> '"+ trim(kki_ELIMINATO_SI) + "' ) " &
//						+ "  and (wm_pklist.dtimportazione between  ? and ?) "
						
				case else
						k_query_where = " "
		
			end choose
		
			k_query_order = &
						" group by " &
						+ " receiptgammarad.packinglistcode, " &
						+ " receiptgammarad.ddtcode,  " &
						+ " receiptgammarad.ddtdate,  " &
						+ " receiptgammarad.mandatorcustomercode, "  &
						+ " receiptgammarad.receivercustomercode,  " &
						+ " receiptgammarad.invoicecustomercode,  " &
						+ " receiptgammarad.accept,  " &
						+ " receiptgammarad.specification,  " &
						+ " receiptgammarad.contract   "  &
						+ " ORDER BY  " &
						+ " receiptgammarad.ddtdate ASC,    " &
						+ " receiptgammarad.ddtcode ASC,    " &
						+ " receiptgammarad.packinglistcode ASC "   
		
		//--- Composizione della Query	
			if len(trim(k_query_where)) > 0 then
				declare kc_treeview dynamic cursor for SQLSA ;
				k_query_select = k_query_select + k_query_where + k_query_order
				prepare SQLSA from :k_query_select using kguo_sqlca_db_wm;
			end if		
	
			 
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_imp 
					open dynamic kc_treeview ;
						
	//	
	//			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
	//				open dynamic kc_treeview using :k_data_meno3mesi;
	
				case else
					kguo_sqlca_db_wm.sqlcode = 100
	
			end choose
	

			if kguo_sqlca_db_wm.sqlcode = 0 then
				
				kuf1_clienti = create kuf_clienti
				
				fetch kc_treeview 
					into
						  :kst_tab_wm_receiptgammarad.packinglistcode,   
						  :kst_tab_wm_receiptgammarad.ddtcode,  
						  :kst_tab_wm_receiptgammarad.ddtdate,  
						  :kst_tab_wm_receiptgammarad.palletquantity, 
						  :kst_tab_wm_receiptgammarad.mandatorcustomercode, 
						  :kst_tab_wm_receiptgammarad.receivercustomercode,  
						  :kst_tab_wm_receiptgammarad.invoicecustomercode,  
						  :kst_tab_wm_receiptgammarad.accept,  
						  :kst_tab_wm_receiptgammarad.specification,  
						  :kst_tab_wm_receiptgammarad.contract  
					  ;
		
				
				do while kguo_sqlca_db_wm.sqlcode = 0
	
					
					kst_treeview_data.handle = 0
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio
					kst_treeview_data.oggetto_padre = k_tipo_oggetto
					kst_treeview_data.struttura = kst_treeview_data_any
	
					if_isnull(kst_tab_wm_receiptgammarad)
//--- piglia NOME e CODICE del Mandante attraverso CODICE o P.IVA o C.FISCALE					
					kst_tab_clienti.rag_soc_10 = " "
					kst_tab_clienti.codice = 0
					kuf1_clienti.get_nome_da_xyz(kst_tab_wm_receiptgammarad.mandatorcustomercode, kst_tab_clienti)
//
//					if kst_tab_wm_receiptgammarad.mandatorcustomercode > "" and isnumber(trim(kst_tab_wm_receiptgammarad.mandatorcustomercode)) then
//						
//						kst_tab_clienti.codice = long(trim(kst_tab_wm_receiptgammarad.mandatorcustomercode))
//						if kst_tab_clienti.codice > 0 then
//							kst_esito = kuf1_clienti.get_nome(kst_tab_clienti)
//							if isnull(kst_tab_clienti.rag_soc_10) then	
//								kst_tab_clienti.rag_soc_10 = " "
//							end if
//						end if
//					end if
//						
					
					kst_treeview_data_any.st_tab_wm_receiptgammarad = kst_tab_wm_receiptgammarad
					kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					
					kst_treeview_data.struttura = kst_treeview_data_any
					
					kst_treeview_data.label = &
												  trim(kst_tab_wm_receiptgammarad.packinglistcode) &
												  + " - " + string(kst_tab_wm_receiptgammarad.ddtdate, "dd.mmm") &
												  + "  ("  &
												  +  string(kst_tab_clienti.codice, "#####") + ") "
//												  + "   " + string(kst_tab_clienti.rag_soc_10, "@@@@@@@@") &
	
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
		
					fetch kc_treeview 
					into
						  :kst_tab_wm_receiptgammarad.packinglistcode,   
						  :kst_tab_wm_receiptgammarad.ddtcode,  
						  :kst_tab_wm_receiptgammarad.ddtdate,  
						  :kst_tab_wm_receiptgammarad.palletquantity, 
						  :kst_tab_wm_receiptgammarad.mandatorcustomercode, 
						  :kst_tab_wm_receiptgammarad.receivercustomercode,  
						  :kst_tab_wm_receiptgammarad.invoicecustomercode,  
						  :kst_tab_wm_receiptgammarad.accept,  
						  :kst_tab_wm_receiptgammarad.specification,  
						  :kst_tab_wm_receiptgammarad.contract  
					  ;
		
				loop
				
				close kc_treeview;
				
				destroy kuf1_clienti
			end if

			
		end if 
		
	catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()

	finally 
		if isvalid(kuf1_clienti) then	destroy kuf1_clienti
		kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere

		
	end try
 
return k_return


end function

public subroutine if_isnull (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//---
//--- Inizializza i campi della tabella 
//---

if isnull(kst_tab_wm_receiptgammarad.packinglistcode  ) then kst_tab_wm_receiptgammarad.packinglistcode  = ""
if isnull(kst_tab_wm_receiptgammarad.ddtcode  ) then kst_tab_wm_receiptgammarad.ddtcode  = ""

if isnull(kst_tab_wm_receiptgammarad.ddtdate) then kst_tab_wm_receiptgammarad.ddtdate = datetime(0)
if not isdate(string(date(kst_tab_wm_receiptgammarad.ddtdate) )) then setnull(kst_tab_wm_receiptgammarad.ddtdate)

if isnull(kst_tab_wm_receiptgammarad.palletquantity  ) then kst_tab_wm_receiptgammarad.palletquantity  = 0
if isnull(kst_tab_wm_receiptgammarad.mandatorcustomercode) then kst_tab_wm_receiptgammarad.mandatorcustomercode = ""
if isnull(kst_tab_wm_receiptgammarad.receivercustomercode) then kst_tab_wm_receiptgammarad.receivercustomercode = ""
if isnull(kst_tab_wm_receiptgammarad.invoicecustomercode  ) then kst_tab_wm_receiptgammarad.invoicecustomercode  = ""
if isnull(kst_tab_wm_receiptgammarad.contract  ) then kst_tab_wm_receiptgammarad.contract  = ""
if isnull(kst_tab_wm_receiptgammarad.specification   ) then kst_tab_wm_receiptgammarad.specification   = ""

if isnull(kst_tab_wm_receiptgammarad.transmissiondate ) then kst_tab_wm_receiptgammarad.transmissiondate = datetime(0)
if not isdate(string(date(kst_tab_wm_receiptgammarad.transmissiondate) )) then setnull(kst_tab_wm_receiptgammarad.transmissiondate)

if isnull(kst_tab_wm_receiptgammarad.receiptdate ) then kst_tab_wm_receiptgammarad.receiptdate = datetime(0)
if not isdate(string(date(kst_tab_wm_receiptgammarad.receiptdate) )) then setnull(kst_tab_wm_receiptgammarad.receiptdate)

if isnull(kst_tab_wm_receiptgammarad.transmissioncode ) then kst_tab_wm_receiptgammarad.transmissioncode = 0
if isnull(kst_tab_wm_receiptgammarad.palletlength ) then kst_tab_wm_receiptgammarad.palletlength = 0
if isnull(kst_tab_wm_receiptgammarad.externalpalletcode ) then kst_tab_wm_receiptgammarad.externalpalletcode = ""
if isnull(kst_tab_wm_receiptgammarad.internalpalletcode ) then kst_tab_wm_receiptgammarad.internalpalletcode = ""
if isnull(kst_tab_wm_receiptgammarad.readed ) then kst_tab_wm_receiptgammarad.readed = "False"
if isnull(kst_tab_wm_receiptgammarad.stored ) then kst_tab_wm_receiptgammarad.stored = "False"
if isnull(kst_tab_wm_receiptgammarad.quarantine ) then kst_tab_wm_receiptgammarad.quarantine = "False"
if isnull(kst_tab_wm_receiptgammarad.accept ) then kst_tab_wm_receiptgammarad.accept = kki_ACCEPT_no
if isnull(kst_tab_wm_receiptgammarad.idwmpklist ) then kst_tab_wm_receiptgammarad.idwmpklist = 0
if isnull(kst_tab_wm_receiptgammarad.Id_meca ) then kst_tab_wm_receiptgammarad.Id_meca = 0
if isnull(kst_tab_wm_receiptgammarad.ordercode ) then kst_tab_wm_receiptgammarad.ordercode = ""

if isnull(kst_tab_wm_receiptgammarad.orderdate ) then kst_tab_wm_receiptgammarad.orderdate = datetime(0)
if not isdate(string(date(kst_tab_wm_receiptgammarad.orderdate) )) then setnull(kst_tab_wm_receiptgammarad.orderdate)

if isnull(kst_tab_wm_receiptgammarad.orderrow ) then kst_tab_wm_receiptgammarad.orderrow = 0
if isnull(kst_tab_wm_receiptgammarad.Id_meca ) then kst_tab_wm_receiptgammarad.Id_meca = 0
if isnull(kst_tab_wm_receiptgammarad.customeritem ) then kst_tab_wm_receiptgammarad.customeritem = ""
if isnull(kst_tab_wm_receiptgammarad.customerlot ) then kst_tab_wm_receiptgammarad.customerlot = ""

if isnull(kst_tab_wm_receiptgammarad.note_1 ) then kst_tab_wm_receiptgammarad.note_1 = "" 
if isnull(kst_tab_wm_receiptgammarad.note_2 ) then kst_tab_wm_receiptgammarad.note_2 = ""
if isnull(kst_tab_wm_receiptgammarad.note_3 ) then kst_tab_wm_receiptgammarad.note_3 = ""

if isnull(kst_tab_wm_receiptgammarad.PesoNetto ) then kst_tab_wm_receiptgammarad.PesoNetto = 0
if isnull(kst_tab_wm_receiptgammarad.PesoLordo ) then kst_tab_wm_receiptgammarad.PesoLordo = 0
//if isnull(kst_tab_wm_receiptgammarad.PalletQuantita ) then kst_tab_wm_receiptgammarad.PalletQuantita = 0
if isnull(kst_tab_wm_receiptgammarad.QuantitaSacchi ) then kst_tab_wm_receiptgammarad.QuantitaSacchi = 0


end subroutine

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
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
st_tab_clienti kst_tab_clienti, kst_tab_clienti_fatt, kst_tab_clienti_ricev
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
		k_campo[k_ind] = "Codice Pk-List WM (Mandante)"
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Data d.d.t "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Nr. d.d.t "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "colli "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "stato "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante codice "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Mandante nominativo "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Capitolato e Commerciale "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Ricevente "
		k_align[k_ind] = left!
		k_ind++
		k_campo[k_ind] = "Cliente "
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

			kst_tab_wm_receiptgammarad = kst_treeview_data_any.st_tab_wm_receiptgammarad
			kst_tab_clienti = kst_treeview_data_any.st_tab_clienti

			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
			
			klvi_listviewitem.selected = false
			
			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)

			kst_tab_clienti_ricev.rag_soc_10 = ""
			kst_tab_clienti_ricev.codice = 0
			if trim(kst_tab_wm_receiptgammarad.mandatorcustomercode) =  trim(kst_tab_wm_receiptgammarad.receivercustomercode) then
				kst_tab_clienti_ricev.rag_soc_10 = kst_tab_clienti.rag_soc_10
				kst_tab_clienti_ricev.codice = long(trim(kst_tab_wm_receiptgammarad.receivercustomercode))
			else

//--- piglia NOME e CODICE del Ricevente attraverso CODICE o P.IVA o C.FISCALE					
				kst_esito = kuf1_clienti.get_nome_da_xyz(kst_tab_wm_receiptgammarad.receivercustomercode, kst_tab_clienti_ricev)
//				if isnumber(trim(kst_tab_wm_receiptgammarad.receivercustomercode)) then
//					kst_tab_clienti_ricev.codice = long(trim(kst_tab_wm_receiptgammarad.receivercustomercode))
//					if kst_tab_clienti_ricev.codice > 0 then
//						kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_ricev)
						if kst_esito.esito <> kkg_esito_ok then
							kst_tab_clienti_ricev.rag_soc_10 = "???non Trovato???"
						end if
//					end if
//				end if
			end if

			kst_tab_clienti_fatt.rag_soc_10 = ""
			kst_tab_clienti_fatt.codice = 0
			if trim(kst_tab_wm_receiptgammarad.mandatorcustomercode) =  trim(kst_tab_wm_receiptgammarad.invoicecustomercode) then
				kst_tab_clienti_fatt.rag_soc_10 = kst_tab_clienti.rag_soc_10
				kst_tab_clienti_fatt.codice = long(trim(kst_tab_wm_receiptgammarad.invoicecustomercode))
			else
//--- piglia NOME e CODICE del Fatturato attraverso CODICE o P.IVA o C.FISCALE					
				kst_esito = kuf1_clienti.get_nome_da_xyz(kst_tab_wm_receiptgammarad.invoicecustomercode, kst_tab_clienti_fatt)
//				if isnumber(trim(kst_tab_wm_receiptgammarad.invoicecustomercode)) then
//					kst_tab_clienti_fatt.codice = long(trim(kst_tab_wm_receiptgammarad.invoicecustomercode))
//					if kst_tab_clienti_fatt.codice > 0 then
//						kst_esito = kuf1_clienti.get_nome(kst_tab_clienti_fatt)
						if kst_esito.esito <> kkg_esito_ok then
							kst_tab_clienti_fatt.rag_soc_10 = "???non Trovato???"
						end if
//					end if
//				end if
			end if 

			k_ind=1
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_receiptgammarad.packinglistcode))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(date(kst_tab_wm_receiptgammarad.ddtdate)))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_receiptgammarad.ddtcode))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_wm_receiptgammarad.palletquantity))

			k_ind++
			choose case trim(kst_tab_wm_receiptgammarad.accept)
				case this.kki_ACCEPT_si
					k_stato = "da Importare "
				case this.kki_ACCEPT_no
					k_stato = "Non Accettato da WM "
				case else
					k_stato = "?????????"
			end choose
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, k_stato)
			
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti.codice ))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_clienti.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_wm_receiptgammarad.specification) + " - " +  trim(kst_tab_wm_receiptgammarad.contract) )
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti_ricev.codice) + "  " + trim(kst_tab_clienti_ricev.rag_soc_10))
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, string(kst_tab_clienti_fatt.codice) + "  " + trim(kst_tab_clienti_fatt.rag_soc_10))
			
			
//--- Leggo rec next dalla tree				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)

		loop
		
		destroy kuf1_clienti
		
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

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore  di  anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
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


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	try
		kGuo_sqlca_db_wm.db_connetti()
	
			if isvalid(kdw_anteprima)  then
				if kdw_anteprima.dataobject = "d_wm_receiptgammarad_l"  then
					if kdw_anteprima.object.packinglistcode [1] = kst_tab_wm_receiptgammarad.packinglistcode   then
						kst_tab_wm_receiptgammarad.packinglistcode  = "" 
					end if
				end if
			end if
		
			if len(trim(kst_tab_wm_receiptgammarad.packinglistcode))  > 0 then
			
				kdw_anteprima.dataobject = "d_wm_receiptgammarad_l"		
				kdw_anteprima.settransobject(kguo_sqlca_db_wm)
		
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_wm_receiptgammarad.packinglistcode )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Packing-List di WM da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito_blok
			
		end if
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
end if


return kst_esito

end function

public function integer u_tree_open (string k_modalita, st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[], ref datawindow kdw_anteprima);//
//--- Chiama applicazioni di dettaglio
//
integer k_return = 0, k_rc = 0, k_index=0
datastore kds_1
st_esito kst_esito
st_open_w kst_open_w
st_tab_g_0 kst_tab_g_0[]


if upperbound(kst_tab_wm_receiptgammarad) > 0 then

	choose case k_modalita  

		case kkg_flag_modalita_anteprima

			if len(trim(kst_tab_wm_receiptgammarad[1].packinglistcode)) > 0 then
				kds_1 = create datastore
				kst_esito = anteprima ( kds_1, kst_tab_wm_receiptgammarad[1])
				if kst_esito.esito = kkg_esito_db_ko then
					k_return = 1
					kguo_exception.set_esito( kst_esito )
				// setmessage( "Accesso al Documento di Vendita non disponibile. ")
					kguo_exception.messaggio_utente( )
				else

					kdw_anteprima.dataobject = kds_1.dataobject
					kds_1.rowscopy( 1, kds_1.rowcount( ) , primary!, kdw_anteprima, 1, primary!)
					
				end if
				destroy kds_1
			end if

//--- Cancellazione
		case kkg_flag_modalita_cancellazione

			for k_index = 1 to upperbound(kst_tab_wm_receiptgammarad)   	

				if len(trim(kst_tab_wm_receiptgammarad[k_index].packinglistcode)) > 0 then
					this.tb_delete(kst_tab_wm_receiptgammarad[k_index])
				end if
			
			end for
		
		case else

			kst_open_w.flag_modalita = k_modalita			
			kst_tab_g_0[1].id = kst_tab_wm_receiptgammarad[1].id
			if not this.u_open( kst_tab_g_0[], kst_open_w ) then  //Apre le Varie Funzioni
				k_return = 1
				
				kguo_exception.setmessage( "Operazione di Accesso al Packing List fallita. ")
				kguo_exception.messaggio_utente( )
			end if
				
				
	end choose		


end if	
 
 
return k_return

end function

public function st_esito set_internalpalletcode (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Imposta   Barcode Gammarad  sul pklist grezzo
//=== 
//=== Input: st_tab_wm_receiptgammarad.id / .internalpalletcode 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_wm_receiptgammarad.id > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set internalpalletcode = :kst_tab_wm_receiptgammarad.internalpalletcode
					,Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					WHERE id = :kst_tab_wm_receiptgammarad.id
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (internalpalletcode) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kGuo_sqlca_db_wm;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kGuo_sqlca_db_wm;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito_db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			
		end try
		
	end if
	
end if



return kst_esito

end function

public function boolean get_id_da_idwmpkl (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Torna ID del IDWMPKLIST (e' il ID del PKL caricato in Informix) indicato 
//---	inp: st_tab_wm_receiptgammarad[1].idwmpklist
//---	out: st_tab_wm_receiptgammarad[].id 
//---	rit: true=operazione eseguita;  false=nessuna operazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
long k_ind
st_esito kst_esito
datastore kds_wm_receiptgammarad


	kGuo_sqlca_db_wm.db_connetti()

	kds_wm_receiptgammarad = create datastore
	
//--- datasore del Pklist xml IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_id_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kguo_sqlca_db_wm)
	k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad[1].idwmpklist)
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Estrazione 'id' di 'Packing-List' codice= " + string(kst_tab_wm_receiptgammarad[1].idwmpklist) + " fallito!  ~n~r "  
		kguo_exception.set_esito(kst_esito)
		destroy kds_wm_receiptgammarad
		throw kguo_exception
	end if
			
	if kds_wm_receiptgammarad.rowcount( ) > 0 then
		
		k_return=true
		
		for k_ind = 1 to  kds_wm_receiptgammarad.rowcount( )
			
			kst_tab_wm_receiptgammarad[k_ind].id = kds_wm_receiptgammarad.getitemnumber( k_ind, "id")  // id del pklist grezzo

		end for
		
	end if


	destroy kds_wm_receiptgammarad

return k_return


end function

public function boolean if_barcode_int_gia_impostato (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Controllo se Barcode Interno gia' Impostati in tabella (campo READDE = TRUE)
//---	inp: 
//---	out: st_wm_receiptgammarad.idwmpklist 
//---	rit: true=Barcode gia' a posto;  false=barcode assenti o ancora da sistemare
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
long k_trovato
st_esito kst_esito


	kGuo_sqlca_db_wm.db_connetti()

	select distinct 1
		into :k_trovato
	   from receiptgammarad
		where idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist 
			and (readed like 'True%' or readed like 'TRUE%') 
			using kGuo_sqlca_db_wm;
	
	if kGuo_sqlca_db_wm.sqlcode = 0 and k_trovato > 0 then
		k_return = true
	else
		if kGuo_sqlca_db_wm.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
			kst_esito.SQLErrText = "Estrazione campo 'READED' x controllo Barcode su 'Packing-List' fallito!  ~n~r " + trim(kGuo_sqlca_db_wm.SQLErrText) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if			

return k_return


end function

public function st_esito tb_delete (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Cancella il rek dalla tabella Receiptgammarad (tutte le righe della bolla di pkl)
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_esito.esito = kkg_esito_ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = this.get_id_programma(KKG_FLAG_MODALITA_CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Packing List WM' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try
	
			kGuo_sqlca_db_wm.db_connetti()
	
			delete from  receiptgammarad 
				where packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode
				using kguo_sqlca_db_wm;
	
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Packing List WM' cod.=" +trim(kst_tab_wm_receiptgammarad.packinglistcode) + " (wm_receiptgammarad):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = KKG_ESITO_not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = KKG_ESITO_db_wrn
					else
						kst_esito.esito = KKG_ESITO_db_ko
						if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
							kGuo_sqlca_db_wm.db_rollback( )
						end if
					end if
				end if
			
			else
		
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito_db_ko then
					if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
						kGuo_sqlca_db_wm.db_rollback( )
					end if
				else
					if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
						kGuo_sqlca_db_wm.db_commit( )
					end if
				end if
			end if
	
	//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				
				kGuo_sqlca_db_wm.db_disconnetti()
			
			end if
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
		
	end if
end if


return kst_esito

end function

public function boolean get_area_magazzino (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Torna codice AREA di Magazzino da WM 
//---	inp: st_tab_wm_receiptgammarad.id_meca  oppure il singolo 'externalpalletcode'
//---	out: st_tab_wm_receiptgammarad.area_mag 
//---	rit: true=operazione eseguita;  false=nessuna operazione
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
int k_rcn
long k_ind
st_esito kst_esito
datastore kds_wm_receiptgammarad



	if NOT kGuo_sqlca_db_wm.db_connetti() then
		
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Connessione al WM non riuscita, impossibile reperire Area_Magazzino per il Lotto (id_meca= " + string(kst_tab_wm_receiptgammarad[1].id_meca) + ") !  ~n~r "  
		kguo_exception.set_esito(kst_esito)
		destroy kds_wm_receiptgammarad
		throw kguo_exception
			
	else

		kds_wm_receiptgammarad = create datastore
		
		if kst_tab_wm_receiptgammarad[1].id_meca > 0 then	
			kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_area_mag"
			k_rcn = kds_wm_receiptgammarad.settransobject(kguo_sqlca_db_wm)
			k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad[1].id_meca )
		else
			kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_area_mag_1"
			k_rcn = kds_wm_receiptgammarad.settransobject(kguo_sqlca_db_wm)
			k_rcn = kds_wm_receiptgammarad.retrieve(trim(kst_tab_wm_receiptgammarad[1].externalpalletcode) )
		end if
		if k_rcn < 0 then
			kst_esito.esito = kkg_esito_blok
			kst_esito.sqlcode = k_rcn
			kst_esito.SQLErrText = "Estrazione 'area_mag' di 'Packing-List WM' id_meca= " + string(kst_tab_wm_receiptgammarad[1].id_meca) + " fallito!  ~n~r "  
			kguo_exception.set_esito(kst_esito)
			destroy kds_wm_receiptgammarad
			throw kguo_exception
		end if
				
		if kds_wm_receiptgammarad.rowcount( ) > 0 then
			
			k_return=true
			
	//		for k_ind = 1 to  kds_wm_receiptgammarad.rowcount( )
				k_ind = 1
				kst_tab_wm_receiptgammarad[k_ind].area_mag = kds_wm_receiptgammarad.getitemstring( k_ind, "area_mag_a") &
																	+ " " + kds_wm_receiptgammarad.getitemstring( k_ind, "area_mag_b") 
				kst_tab_wm_receiptgammarad[k_ind].area_mag_trim = kds_wm_receiptgammarad.getitemstring( k_ind, "area_mag_a") + kds_wm_receiptgammarad.getitemstring( k_ind, "area_mag_b") 
	
	//		end for
			
		end if
	
	
		destroy kds_wm_receiptgammarad
		
	end if

return k_return


end function

public function st_esito tb_add (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Insert in tabella ReceiptGammarad
//=== 
//=== Input: st_tab_wm_receiptgammarad
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_inserimento
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_inserimento) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Inserimento in Tabella di Magazzino Packing-List (ReceiptGammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
//--- Inizializza campi non impostati		
			if_isnull(kst_tab_wm_receiptgammarad)
		
			INSERT INTO receiptgammarad  
					(    
					  transmissiondate,   
					  receiptdate,   
					  transmissioncode,   
					  packinglistcode,   
					  ddtcode,   
					  ddtdate,   
					  palletlength,   
					  externalpalletcode,   
					  internalpalletcode,   
					  palletquantity,   
					  mandatorcustomercode,   
					  receivercustomercode,   
					  invoicecustomercode,   
					  specification,   
					  contract,   
					  readed,   
					  stored,   
					  idwmpklist,   
					  ordercode,   
					  orderrow,   
					  orderdate,   
					  customeritem,   
					  customerlot,   
					  accept,   
					  quarantine,   
					  Id_meca,
					  note_1,
					  note_2,
					  note_3,
					  PesoNetto,
					  PesoLordo,
					  QuantitaSacchi
					  )  
		  VALUES ( 
					  :kst_tab_wm_receiptgammarad.transmissiondate,   
					  :kst_tab_wm_receiptgammarad.receiptdate,   
					  :kst_tab_wm_receiptgammarad.transmissioncode,   
					  :kst_tab_wm_receiptgammarad.packinglistcode,   
					  :kst_tab_wm_receiptgammarad.ddtcode,   
					  :kst_tab_wm_receiptgammarad.ddtdate,   
					  :kst_tab_wm_receiptgammarad.palletlength,   
					  :kst_tab_wm_receiptgammarad.externalpalletcode,   
					  :kst_tab_wm_receiptgammarad.internalpalletcode,   
					  :kst_tab_wm_receiptgammarad.palletquantity,   
					  :kst_tab_wm_receiptgammarad.mandatorcustomercode,   
					  :kst_tab_wm_receiptgammarad.receivercustomercode,   
					  :kst_tab_wm_receiptgammarad.invoicecustomercode,   
					  :kst_tab_wm_receiptgammarad.specification,   
					  :kst_tab_wm_receiptgammarad.contract,   
					  :kst_tab_wm_receiptgammarad.readed,   
					  :kst_tab_wm_receiptgammarad.stored,   
					  :kst_tab_wm_receiptgammarad.idwmpklist,   
					  :kst_tab_wm_receiptgammarad.ordercode,   
					  :kst_tab_wm_receiptgammarad.orderrow,   
					  :kst_tab_wm_receiptgammarad.orderdate,   
					  :kst_tab_wm_receiptgammarad.customeritem,   
					  :kst_tab_wm_receiptgammarad.customerlot,   
					  :kst_tab_wm_receiptgammarad.accept,   
					  :kst_tab_wm_receiptgammarad.quarantine,   
					  :kst_tab_wm_receiptgammarad.Id_meca,
					  :kst_tab_wm_receiptgammarad.note_1,  
					  :kst_tab_wm_receiptgammarad.note_2,  
					  :kst_tab_wm_receiptgammarad.note_3,
					  :kst_tab_wm_receiptgammarad.PesoNetto,
					  :kst_tab_wm_receiptgammarad.PesoLordo,
					  :kst_tab_wm_receiptgammarad.QuantitaSacchi
					  )  
			using kGuo_sqlca_db_wm;

//					  PalletQuantita,
//					  :kst_tab_wm_receiptgammarad.PalletQuantita,
		
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante Inserimento in tabella di Magazzino Packing-List  (ReceiptGammarad) ~n~r" &
						+ " codice=" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'ReceiptGammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					kGuo_sqlca_db_wm.db_rollback()
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					kst_esito = kGuo_sqlca_db_wm.db_commit()
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				kGuo_sqlca_db_wm.db_disconnetti()
			end if

		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		end try
		
	end if
	
end if



return kst_esito

end function

public subroutine set_null (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_null);//
//--- preparo la struct a NULL		
//
		setnull(kst_tab_wm_receiptgammarad_null.accept)
		setnull(kst_tab_wm_receiptgammarad_null.area_mag )
		setnull(kst_tab_wm_receiptgammarad_null.area_mag_trim )
		setnull(kst_tab_wm_receiptgammarad_null.contract )
		setnull(kst_tab_wm_receiptgammarad_null.customeritem )
		setnull(kst_tab_wm_receiptgammarad_null.customerlot )
		setnull(kst_tab_wm_receiptgammarad_null.ddtcode )
		setnull(kst_tab_wm_receiptgammarad_null.ddtdate )
		setnull(kst_tab_wm_receiptgammarad_null.externalpalletcode )
		setnull(kst_tab_wm_receiptgammarad_null.id )
		setnull(kst_tab_wm_receiptgammarad_null.id_meca )
		setnull(kst_tab_wm_receiptgammarad_null.idwmpklist )
		setnull(kst_tab_wm_receiptgammarad_null.internalpalletcode )
		setnull(kst_tab_wm_receiptgammarad_null.invoicecustomercode )
		setnull(kst_tab_wm_receiptgammarad_null.mandatorcustomercode )
		setnull(kst_tab_wm_receiptgammarad_null.ordercode )
		setnull(kst_tab_wm_receiptgammarad_null.orderdate )
		setnull(kst_tab_wm_receiptgammarad_null.orderrow )
		setnull(kst_tab_wm_receiptgammarad_null.packinglistcode )
		setnull(kst_tab_wm_receiptgammarad_null.palletlength )
		setnull(kst_tab_wm_receiptgammarad_null.palletquantity )
		setnull(kst_tab_wm_receiptgammarad_null.quarantine )
		setnull(kst_tab_wm_receiptgammarad_null.readed )
		setnull(kst_tab_wm_receiptgammarad_null.receiptdate )
		setnull(kst_tab_wm_receiptgammarad_null.receivercustomercode )
		setnull(kst_tab_wm_receiptgammarad_null.registered )
		setnull(kst_tab_wm_receiptgammarad_null.specification )
		setnull(kst_tab_wm_receiptgammarad_null.stored )
		setnull(kst_tab_wm_receiptgammarad_null.transmissioncode )
		setnull(kst_tab_wm_receiptgammarad_null.transmissiondate )

end subroutine

public function st_esito get_idwmpkl_readed (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Piglia se il Lotto è stato accoppiato/associato con le etichette (READED)
//=== 
//=== Input: st_tab_wm_receiptgammarad.idwmpklist
//=== Ouy: st_tab_wm_receiptgammarad.readed
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_visualizzazione) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Visualizzazione Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if NOT isnull(kst_tab_wm_receiptgammarad.idwmpklist) then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			select max(readed)
					into :kst_tab_wm_receiptgammarad.readed
					from receiptgammarad
					WHERE idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante lettura tabella di Magazzino Packing-List  (idwmpklist) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			if isnull(kst_tab_wm_receiptgammarad.readed) then kst_tab_wm_receiptgammarad.readed = "True"   // anche se non trovo il record RISCHIO il TRUE!!!!
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		end try
		
	end if
	
end if

kst_tab_wm_receiptgammarad.readed = "True" //UFO

return kst_esito

end function

public function st_esito toglie_internalpalletcode (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Imposta   Barcode Gammarad  sul pklist grezzo
//=== 
//=== Input: st_tab_wm_receiptgammarad.id / .internalpalletcode 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_wm_receiptgammarad.id_meca > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set internalpalletcode = ""
					where Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante pulizia tabella di Magazzino Packing-List  (internalpalletcode) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kGuo_sqlca_db_wm;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kGuo_sqlca_db_wm;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito_db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			
	
		end try
		
	end if
	
end if



return kst_esito

end function

public function st_esito toglie_id_meca (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Imposta   Barcode Gammarad  sul pklist grezzo
//=== 
//=== Input: st_tab_wm_receiptgammarad.id / .internalpalletcode 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if kst_tab_wm_receiptgammarad.id_meca > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set Id_meca = 0
					where Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante pulizia tabella di Magazzino Packing-List  (id meca) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito_db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kGuo_sqlca_db_wm;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kGuo_sqlca_db_wm;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito_db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
	
		end try
		
	end if
	
end if



return kst_esito

end function

public function long crea (long k_nr_ws_receiptgammarad, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//---
//--- Crea Nuova Packing-List 
//--- Inp: numero delle righe
//--- 		tabella st_tab_wm_receiptgammarad[]
//--- Out: numero righe elaborate
//---
long k_return = 0
long k_ctr_ws_receiptgammarad = 0
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



if k_nr_ws_receiptgammarad > 0 then
	
//--- INSERT nella tabella di PACKING-LIST
	for k_ctr_ws_receiptgammarad = 1 to k_nr_ws_receiptgammarad
			
//--- Faccio la Commit sull'ultimo record				
		if k_ctr_ws_receiptgammarad = k_nr_ws_receiptgammarad then
			kst_tab_wm_receiptgammarad[k_ctr_ws_receiptgammarad].st_tab_g_0.esegui_commit = "S"
		else
			kst_tab_wm_receiptgammarad[k_ctr_ws_receiptgammarad].st_tab_g_0.esegui_commit = "N"
		end if
			
//--- INSERT				
		kst_esito = tb_add ( kst_tab_wm_receiptgammarad[k_ctr_ws_receiptgammarad]) 
				
		if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn then
//--- Se KO allora disconnetto e lancio EXCEPTION					
			kGuo_sqlca_db_wm.db_disconnetti()

			kGuo_exception.set_esito( kst_esito)
			throw kGuo_exception
			
		else
			k_return ++
			
		end if
	end for
			
end if


return k_return

end function

public function boolean set_accept_true (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//====================================================================
//=== Imposta   a TRUE  il campo ACCEPT come se lo avesse fatto WM in entrata materiale
//=== 
//=== Input: st_tab_wm_receiptgammarad.packinglistcode 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set accept = "True"
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode 
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (accept) ~n~r" &
						+ " id del pkl =" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
	
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kGuo_sqlca_db_wm;
				end if
				
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
	
			end if
			
		
	//---- COMMIT....	
			if kGuo_sqlca_db_wm.sqlcode = 0 then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kGuo_sqlca_db_wm;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				kGuo_sqlca_db_wm.db_disconnetti()
			end if
		
		
			 k_return=true
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

public function boolean set_accept_false (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//====================================================================
//=== Imposta   a FALSE  il campo ACCEPT come se  WM dovesse ancora accettare in entrata il materiale
//=== 
//=== Input: st_tab_wm_receiptgammarad.packinglistcode 
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
boolean k_return=false
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita_modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kuf1_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kuf1_data_base.prendi_x_utente()
		
			update receiptgammarad
					set accept = "False"
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode 
					using kGuo_sqlca_db_wm;
				
			if kGuo_sqlca_db_wm.sqlcode <> 0 then
					
				kst_esito.sqlcode = kGuo_sqlca_db_wm.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (accept) ~n~r" &
						+ " id del pkl =" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kGuo_sqlca_db_wm.SQLErrText)
				if kGuo_sqlca_db_wm.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					if kGuo_sqlca_db_wm.sqlcode > 0 then
						kst_esito.esito = kkg_esito_db_wrn
					else
						kst_esito.esito = kkg_esito_db_ko
					end if
				end if
	
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kGuo_sqlca_db_wm;
				end if
				
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
	
			end if
			
		
	//---- COMMIT....	
			if kGuo_sqlca_db_wm.sqlcode = 0 then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kGuo_sqlca_db_wm;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				kGuo_sqlca_db_wm.db_disconnetti()
			end if
		
			 k_return=true
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

public function boolean if_lotto_associato (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Check se Lotto è stato accoppiato/associato tra Etichetta-PK e Etichette Trattamento (READED)
//--- 
//--- Input: st_tab_wm_receiptgammarad.idwmpklist
//--- Out: 
//--- 
//--- Ritorna: TRUE = Lotto associato
//--- 
//--- Lancia EXCEPTIO x errore grave
//--- 
//----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if kst_tab_wm_receiptgammarad.idwmpklist > 0 then

		kst_esito = get_idwmpkl_readed(kst_tab_wm_receiptgammarad)
		
		if kst_esito.esito = kkg_esito_ok then
		
			if lower(kst_tab_wm_receiptgammarad.readed) = 'true' then
				K_return = true
			end if
			
		else
			if kst_esito.esito = kkg_esito_not_fnd then   // anche se non trovo il record RISCHIO il TRUE!!!!
				K_return = true
			else
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

	end if


return k_return

end function

on kuf_wm_receiptgammarad.create
call super::create
end on

on kuf_wm_receiptgammarad.destroy
call super::destroy
end on

