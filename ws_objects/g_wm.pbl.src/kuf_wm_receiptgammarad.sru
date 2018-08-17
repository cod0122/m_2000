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
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function transaction set_connessione (boolean a_connetti) throws uo_exception
public function integer get_file_wm_pklist_txt (ref st_wm_pkl_file kst_wm_pkl_file[]) throws uo_exception
public function long get_wm_pklist_file_txt (ref st_wm_pkl_file kst_wm_pkl_file[]) throws uo_exception
public function datastore get_wm_pklist_txt (st_wm_pkl_file kst_wm_pkl_file) throws uo_exception
public function long importa_wm_pklist_txt () throws uo_exception
public function long set_wm_pklist_txt_to_wm_tab (ref datastore kds_receiptgammarad_l, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function boolean set_id_meca (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean tb_delete_x_idwmpklist (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception
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
kuo_sqlca_db_0 kuo1_sqlca_db_0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella Magazzino Packing-List (receiptgammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if NOT isnull(kst_tab_wm_receiptgammarad.idwmpklist) then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)

//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella Magazzino Packing-List  (idwmpklist di receiptgammarad)~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then

					kuo1_sqlca_db_0.db_rollback( ) ;
					
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then

					kuo1_sqlca_db_0.db_commit( ) ;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if

				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
	
		finally
			set_connessione(false)
	
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
kuo_sqlca_db_0 kuo1_sqlca_db_0



try

	kuo1_sqlca_db_0 = set_connessione(true)

	kds_wm_receiptgammarad = create datastore
	kds_wm_receiptgammarad_note_lotto = create datastore

	if isnull(kst_tab_wm_receiptgammarad_input.packinglistcode) then kst_tab_wm_receiptgammarad_input.packinglistcode = ""

//--- datastore del Pklist x IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kuo1_sqlca_db_0)
	if k_rcn >= 0 then
		k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad_input.packinglistcode)
	end if
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_rcn
		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito! (db non connesso rc=" + string(k_rcn) + ") " // ~n~r "  
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- datastore che serve SOLO per IMPORTARE le note_1/3 
	kds_wm_receiptgammarad_note_lotto.dataobject = "d_wm_receiptgammarad_inout_note_lotto"
	k_rcn = kds_wm_receiptgammarad_note_lotto.settransobject(kuo1_sqlca_db_0)
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
			kst_tab_wm_receiptgammarad[k_ind].quantitasacchi = kds_wm_receiptgammarad.getitemnumber( k_ind, "k_quantitasacchi_tot") 

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


catch (uo_exception kuo_exception)
	throw kguo_exception

finally
	if isvalid(kds_wm_receiptgammarad) then destroy kds_wm_receiptgammarad
	set_connessione(false)
	
end try

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
kuo_sqlca_db_0 kuo1_sqlca_db_0


	kuo1_sqlca_db_0 = set_connessione(true)

	kds_wm_receiptgammarad = create datastore

//--- datasore del Pklist xml IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_idpkl_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kuo1_sqlca_db_0)
	kst_tab_wm_receiptgammarad_input.packinglistcode = ""
	k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad_input.packinglistcode)
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito.blok
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

	set_connessione(false)

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
//st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_clienti kuf1_clienti
//kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuo_sqlca_db_0 kuo1_sqlca_db_0


	try 

		k_data_0 = datetime(date(0)	)

		kuo1_sqlca_db_0 = set_connessione(true)
		 
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
			if kst_esito.esito = kkg_esito.ok then
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
	//			if kst_esito.esito = kkg_esito.ok then
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
							+ "  receiptgammarad.idwmpklist is null OR receiptgammarad.idwmpklist = 0 " 
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
				prepare SQLSA from :k_query_select using kuo1_sqlca_db_0;
			end if		
	
			 
			choose case k_tipo_oggetto
					
				case kuf1_treeview.kist_treeview_oggetto.pklist_wm_da_imp 
					open dynamic kc_treeview ;
						
	//	
	//			case kuf1_treeview.kist_treeview_oggetto.pklist_dett_da_imp
	//				open dynamic kc_treeview using :k_data_meno3mesi;
	
				case else
					kuo1_sqlca_db_0.sqlcode = 100
	
			end choose
	

			if kuo1_sqlca_db_0.sqlcode = 0 then
				
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
		
				
				do while kuo1_sqlca_db_0.sqlcode = 0
					
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
		set_connessione(false)

		
	end try
 
return k_return


end function

public subroutine if_isnull (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//---
//--- Inizializza i campi della tabella 
//---

if isnull(kst_tab_wm_receiptgammarad.packinglistcode  ) then kst_tab_wm_receiptgammarad.packinglistcode  = ""
if isnull(kst_tab_wm_receiptgammarad.ddtcode  ) then kst_tab_wm_receiptgammarad.ddtcode  = ""

if isnull(kst_tab_wm_receiptgammarad.ddtdate) then kst_tab_wm_receiptgammarad.ddtdate = datetime(date(0))
if not isdate(string(date(kst_tab_wm_receiptgammarad.ddtdate) )) then setnull(kst_tab_wm_receiptgammarad.ddtdate)

if isnull(kst_tab_wm_receiptgammarad.palletquantity  ) then kst_tab_wm_receiptgammarad.palletquantity  = 0
if isnull(kst_tab_wm_receiptgammarad.mandatorcustomercode) then kst_tab_wm_receiptgammarad.mandatorcustomercode = ""
if isnull(kst_tab_wm_receiptgammarad.receivercustomercode) then kst_tab_wm_receiptgammarad.receivercustomercode = ""
if isnull(kst_tab_wm_receiptgammarad.invoicecustomercode  ) then kst_tab_wm_receiptgammarad.invoicecustomercode  = ""
if isnull(kst_tab_wm_receiptgammarad.contract  ) then kst_tab_wm_receiptgammarad.contract  = ""
if isnull(kst_tab_wm_receiptgammarad.specification   ) then kst_tab_wm_receiptgammarad.specification   = ""

if isnull(kst_tab_wm_receiptgammarad.transmissiondate ) then kst_tab_wm_receiptgammarad.transmissiondate = datetime(date(0))
if not isdate(string(date(kst_tab_wm_receiptgammarad.transmissiondate) )) then setnull(kst_tab_wm_receiptgammarad.transmissiondate)

if isnull(kst_tab_wm_receiptgammarad.receiptdate ) then kst_tab_wm_receiptgammarad.receiptdate = datetime(date(0))
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

if isnull(kst_tab_wm_receiptgammarad.orderdate ) then kst_tab_wm_receiptgammarad.orderdate = datetime(date(0))
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
		k_campo[k_ind] = "Codice Pk-List (Mandante)"
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
						if kst_esito.esito <> kkg_esito.ok then
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
						if kst_esito.esito <> kkg_esito.ok then
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
kuo_sqlca_db_0 kuo1_sqlca_db_0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	try
		kuo1_sqlca_db_0 = set_connessione(true)
	
		if isvalid(kdw_anteprima)  then
			if kdw_anteprima.dataobject = "d_wm_receiptgammarad"  then
				if kdw_anteprima.object.packinglistcode [1] = kst_tab_wm_receiptgammarad.packinglistcode   then
					kst_tab_wm_receiptgammarad.packinglistcode  = "" 
				end if
			end if
		end if
	
		if len(trim(kst_tab_wm_receiptgammarad.packinglistcode))  > 0 then
		
			kdw_anteprima.dataobject = "d_wm_receiptgammarad"		
			kdw_anteprima.settransobject(kuo1_sqlca_db_0)
		
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_wm_receiptgammarad.packinglistcode )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Packing-List Mandante da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		set_connessione(false)
		
		
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

		case kkg_flag_modalita.anteprima

			if len(trim(kst_tab_wm_receiptgammarad[1].packinglistcode)) > 0 then
				kds_1 = create datastore
				kst_esito = anteprima ( kds_1, kst_tab_wm_receiptgammarad[1])
				if kst_esito.esito = kkg_esito.db_ko then
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
		case kkg_flag_modalita.cancellazione

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
kuo_sqlca_db_0 kuo1_sqlca_db_0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella Magazzino Packing-List  (receiptgammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_receiptgammarad.id > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
//			kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set internalpalletcode = :kst_tab_wm_receiptgammarad.internalpalletcode
					,Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					WHERE id = :kst_tab_wm_receiptgammarad.id
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (internalpalletcode in receiptgammarad) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			set_connessione(false)
			//kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			
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
kuo_sqlca_db_0 kuo1_sqlca_db_0


	//kGuo_sqlca_db_wm.db_connetti()
	kuo1_sqlca_db_0 = set_connessione(true)

	kds_wm_receiptgammarad = create datastore
	
//--- datasore del Pklist xml IMPORTAZIONE!
	kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_id_inout"
	k_rcn = kds_wm_receiptgammarad.settransobject(kuo1_sqlca_db_0)
	k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad[1].idwmpklist)
	if k_rcn < 0 then
		kst_esito.esito = kkg_esito.blok
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
	set_connessione(false)

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
kuo_sqlca_db_0 kuo1_sqlca_db_0


	kuo1_sqlca_db_0 = set_connessione(true)
	//kGuo_sqlca_db_wm.db_connetti()

	select distinct 1
		into :k_trovato
	   from receiptgammarad
		where idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist 
			and (readed like 'True%' or readed like 'TRUE%') 
			using kuo1_sqlca_db_0;
	
	if kuo1_sqlca_db_0.sqlcode = 0 and k_trovato > 0 then
		k_return = true
	else
		if kuo1_sqlca_db_0.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
			kst_esito.SQLErrText = "Estrazione campo 'READED' x controllo Barcode su 'Packing-List' fallito!  ~n~r " + trim(kuo1_sqlca_db_0.SQLErrText) 
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if			

	set_connessione(false)

return k_return


end function

public function st_esito tb_delete (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Cancella il rek dalla tabella Receiptgammarad 
//=== 
//=== Ritorna ST_ESITO
//===           	
//====================================================================
//
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza
kuo_sqlca_db_0 kuo1_sqlca_db_0


kst_esito.esito = kkg_esito.ok 
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma(kkg_flag_modalita.CANCELLAZIONE) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione 'Packing List WM' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try
	
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
	
			delete from  receiptgammarad 
				where packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode
				using kuo1_sqlca_db_0;
	
			
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione 'Packing List WM' cod.=" +trim(kst_tab_wm_receiptgammarad.packinglistcode) + " (wm_receiptgammarad):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
						if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
							kuo1_sqlca_db_0.db_rollback( )
						end if
					end if
				end if
			
			else
		
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
						kuo1_sqlca_db_0.db_rollback( )
					end if
				else
					if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
						kuo1_sqlca_db_0.db_commit( )
					end if
				end if
			end if
	
	//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				
				set_connessione(false)
				//kGuo_sqlca_db_wm.db_disconnetti()
			
			end if
			
		catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
			
		finally
			
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
kuo_sqlca_db_0 kuo1_sqlca_db_0



	kuo1_sqlca_db_0 = set_connessione(true)
	//if NOT kGuo_sqlca_db_wm.db_connetti() then
	if not isvalid(kuo1_sqlca_db_0) then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Connessione al WM non riuscita, impossibile reperire Area_Magazzino per il Lotto (id_meca= " + string(kst_tab_wm_receiptgammarad[1].id_meca) + ") !  ~n~r "  
		kguo_exception.set_esito(kst_esito)
		destroy kds_wm_receiptgammarad
		throw kguo_exception
			
	else

		kds_wm_receiptgammarad = create datastore
		
		if kst_tab_wm_receiptgammarad[1].id_meca > 0 then	
			kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_area_mag"
			k_rcn = kds_wm_receiptgammarad.settransobject(kuo1_sqlca_db_0)
			k_rcn = kds_wm_receiptgammarad.retrieve(kst_tab_wm_receiptgammarad[1].id_meca )
		else
			kds_wm_receiptgammarad.dataobject = "d_wm_receiptgammarad_area_mag_1"
			k_rcn = kds_wm_receiptgammarad.settransobject(kuo1_sqlca_db_0)
			k_rcn = kds_wm_receiptgammarad.retrieve(trim(kst_tab_wm_receiptgammarad[1].externalpalletcode) )
		end if
		if k_rcn < 0 then
			kst_esito.esito = kkg_esito.blok
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
		
		set_connessione(false)
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
boolean k_pkldam2000
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuo_sqlca_db_0 kuo1_sqlca_db_0
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.inserimento) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Inserimento in Tabella di Magazzino Packing-List (ReceiptGammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()

//--- se attivo E1 allora alcuni flag che impstava il WMF ora li forza sempre a True come ACCETTATO/LETTO/....
			kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
			k_pkldam2000 = kuf1_wm_pklist_cfg.if_importadam2000()
			if k_pkldam2000 then
				kst_tab_wm_receiptgammarad.accept = "True"
				kst_tab_wm_receiptgammarad.readed = "True"
				kst_tab_wm_receiptgammarad.stored = "True"
				kst_tab_wm_receiptgammarad.registered = "True"
			end if			
		
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
			using kuo1_sqlca_db_0;

//					  PalletQuantita,
//					  :kst_tab_wm_receiptgammarad.PalletQuantita,
		
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante Inserimento in tabella di Magazzino Packing-List  (ReceiptGammarad) ~n~r" &
						+ " codice=" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'ReceiptGammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					kuo1_sqlca_db_0.db_rollback()
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					kst_esito = kuo1_sqlca_db_0.db_commit()
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				set_connessione(false)
				//kGuo_sqlca_db_wm.db_disconnetti()
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
//=== Piglia se il Lotto è READED
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
kuo_sqlca_db_0 kuo1_sqlca_db_0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.visualizzazione) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Visualizzazione Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if NOT isnull(kst_tab_wm_receiptgammarad.idwmpklist) then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			select max(readed)
					into :kst_tab_wm_receiptgammarad.readed
					from receiptgammarad
					WHERE idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante lettura tabella di Magazzino Packing-List  (idwmpklist) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			if isnull(kst_tab_wm_receiptgammarad.readed) then kst_tab_wm_receiptgammarad.readed = "True"   // anche se non trovo il record RISCHIO il TRUE!!!!
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			set_connessione(false)
			
		end try
		
	end if
	
end if


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
kuo_sqlca_db_0 kuo1_sqlca_db_0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_receiptgammarad.id_meca > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set internalpalletcode = ""
					where Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante pulizia tabella di Magazzino Packing-List  (internalpalletcode) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			set_connessione(false)
			//kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			
	
		end try
		
	end if
	
end if



return kst_esito

end function

public function st_esito toglie_id_meca (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad);//
//====================================================================
//=== Rimuove ID_MECA dalla tabella RECEIPTGAMMARAD
//=== 
//=== Input: st_tab_wm_receiptgammarad.id_meca
//=== Ritorna:       ST_ESITO 
//=== 
//====================================================================
//
st_esito kst_esito
boolean k_sicurezza
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuo_sqlca_db_0 kuo1_sqlca_db_0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella Magazzino Packing-List (receiptgammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_wm_receiptgammarad.id_meca > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set Id_meca = 0
					where Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante pulizia tabella di Magazzino Packing-List  (id meca di receiptgammarad) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if
			
		//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if
			else
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
			end if
		
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
	
		finally
			set_connessione(false)
			//kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
	
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


kst_esito.esito = kkg_esito.ok
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
				
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//--- Se KO allora disconnetto e lancio EXCEPTION	
			set_connessione(false)
//			kGuo_sqlca_db_wm.db_disconnetti()

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
kuo_sqlca_db_0 kuo1_sqlca_db_0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set accept = "True"
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode 
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (accept) ~n~r" &
						+ " id del pkl =" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
	
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if
				
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
	
			end if
			
		
	//---- COMMIT....	
			if kuo1_sqlca_db_0.sqlcode = 0 then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				set_connessione(false)
				//kGuo_sqlca_db_wm.db_disconnetti()
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
kuo_sqlca_db_0 kuo1_sqlca_db_0


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.modifica) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.SQLErrText = "Modifica Tabella di Magazzino Packing-List non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then

		try 
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set accept = "False"
					WHERE packinglistcode = :kst_tab_wm_receiptgammarad.packinglistcode 
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode <> 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante aggiornamento tabella di Magazzino Packing-List  (accept) ~n~r" &
						+ " id del pkl =" + trim(kst_tab_wm_receiptgammarad.packinglistcode) + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				if kuo1_sqlca_db_0.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kuo1_sqlca_db_0.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
	
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if
				
				kuo_exception = create uo_exception
				kuo_exception.set_esito(kst_esito)
	
			end if
			
		
	//---- COMMIT....	
			if kuo1_sqlca_db_0.sqlcode = 0 then
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
				end if
			end if

//--- se richiesto di fare Commit dopo disconnetto
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				set_connessione(false)
				//kGuo_sqlca_db_wm.db_disconnetti()
			end if
		
			 k_return=true
		
		catch (uo_exception kuo2_exception)
			throw kuo2_exception
		
		end try
		
	end if

end if


return k_return
				

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
kuf_wm_pklist kuf1_wm_pklist

kuf1_wm_pklist = create kuf_wm_pklist
return kuf1_wm_pklist.if_sicurezza(ast_open_w)

end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
kuf_wm_pklist kuf1_wm_pklist

kuf1_wm_pklist = create kuf_wm_pklist
return kuf1_wm_pklist.if_sicurezza(aflag_modalita)

end function

public function transaction set_connessione (boolean a_connetti) throws uo_exception;//-------------------------------------------------------------------------------------------
//--- Connette/Disconnette DB del WMF o M2000
//--- inp: true = connette; false = disconnette (solo se WM)
//--- rit: transaction connessa sqlca
//-------------------------------------------------------------------------------------------
//
boolean k_pkldam2000=false
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuo_sqlca_db_0 kuo1_sqlca_db_0


	try
		
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		k_pkldam2000 = kuf1_wm_pklist_cfg.if_importadam2000(kst_tab_wm_pklist_cfg)
		
		if a_connetti then
			if not k_pkldam2000 then
				kguo_sqlca_db_wm.db_connetti( ) // se non connesso connette!
				kuo1_sqlca_db_0 = kguo_sqlca_db_wm
			else
				kuo1_sqlca_db_0 = kguo_sqlca_db_magazzino
			end if
		else
			if not k_pkldam2000 then
				kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere
			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg

	end try
	
	
return kuo1_sqlca_db_0

end function

public function integer get_file_wm_pklist_txt (ref st_wm_pkl_file kst_wm_pkl_file[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Trova i nomi file di Packing-List formato lineare presenti nella cartella di importazione
//---	inp: st_wm_pkl_file vuoto
//---	out: st_wm_pkl_file array con il path e il nome da importare
//---	rit: nr file trovati nella cartella
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
integer k_return=0
boolean k_b=false
string k_rc
int k_rcn, k_file_ind=0
long k_ind, k_nr_file_dirlist=0
datastore kds_dirlist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_file_explorer kuf1_file_explorer
 
 
	try
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
		kuf1_file_explorer = create kuf_file_explorer

//--- piglia il path di dove sono i Packing-list Web
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- piglia l'elenco dei file xml contenuti nella cartella
		kds_dirlist = kuf1_file_explorer.DirList(trim(kst_tab_wm_pklist_cfg.cartella_pkl_da_txt)+"\*.txt")
		k_nr_file_dirlist = kds_dirlist.rowcount()

		for k_file_ind = 1 to k_nr_file_dirlist
		
			kst_wm_pkl_file[k_file_ind].nome_file = trim(kds_dirlist.getitemstring(k_file_ind, "nome"))
			kst_wm_pkl_file[k_file_ind].path_file = kst_tab_wm_pklist_cfg.cartella_pkl_da_txt
			
		end for

		k_return = k_nr_file_dirlist

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
		finally
			if isvalid(kds_dirlist) then destroy kds_dirlist
			if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg
			if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end try
			


return k_return


end function

public function long get_wm_pklist_file_txt (ref st_wm_pkl_file kst_wm_pkl_file[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie Packing-List Web nalla struct array st_wm_pkl_file_da_imp[] 
//---	inp: st_wm_pkl_file[1]: nome del file contenente il pkl
//---	out: st_wm_pkl_file[]: array con le righe del packing-list-TXT lette
//---	rit: nr righe file trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0, k_ctr_pkl=0 
int k_righe, k_record, k_colli
st_esito kst_esito
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
//st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
datastore kds_1
//st_tab_contratti kst_tab_contratti
//kuf_contratti kuf1_contratti

  
	try
		kds_1 = get_wm_pklist_txt(kst_wm_pkl_file[1])
		if not isvalid(kds_1) then
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko )
			kguo_exception.setmessage( "Estrazione packing list formato lineare (TXT)", "Operazione Fallita in lettua del file: " + trim(kst_wm_pkl_file[1].nome_file ))
			throw kguo_exception
		end if
		k_ctr_pkl = kds_1.rowcount()
		if k_ctr_pkl > 0 then
			kds_1.setsort("externalpalletcode A")
			kds_1.sort( )
			
			k_record = 1
	
			kst_wm_pkl_file[k_record].nome_file = kst_wm_pkl_file[1].nome_file
			kst_wm_pkl_file[k_record].path_file = kst_wm_pkl_file[1].path_file
			kst_wm_pkl_file[k_record].mandante = kds_1.getitemstring(1, "mandatorcustomercode")
			if isnumber(kst_wm_pkl_file[k_record].mandante) then
				kst_wm_pkl_file[k_record].mandante = string(long(kst_wm_pkl_file[k_record].mandante), "##0")
			end if
			kst_wm_pkl_file[k_record].data_invio = string(date(kds_1.getitemdatetime(1, "transmissiondate")))
			kst_wm_pkl_file[k_record].ora_invio = string(time(kds_1.getitemdatetime(1, "transmissiondate")))
			kst_wm_pkl_file[k_record].nrddt = kds_1.getitemstring(1, "ddtcode")
			kst_wm_pkl_file[k_record].dtddt = string(date(kds_1.getitemdatetime(1, "ddtdate")))
			kst_wm_pkl_file[k_record].externalpalletcode = trim(kds_1.getitemstring(1, "externalpalletcode"))
			kst_wm_pkl_file[k_record].idlotto = kds_1.getitemstring(1, "customerlot")
			kst_wm_pkl_file[k_record].idpkl = kds_1.getitemstring(1, "packinglistcode")
			
			k_colli = 1
			for k_righe = 2 to k_ctr_pkl
	
				if trim(kst_wm_pkl_file[k_record].nrddt) = trim(kds_1.getitemstring(k_righe, "ddtcode")) &
						and trim(kst_wm_pkl_file[k_record].idlotto) = trim(kds_1.getitemstring(k_righe, "customerlot")) &
						and trim(kst_wm_pkl_file[k_record].externalpalletcode) = trim(kds_1.getitemstring(k_righe, "externalpalletcode")) then
					k_colli ++
				else
					kst_wm_pkl_file[k_record].colliddt = k_colli
					k_colli = 1
					
					k_record ++
					kst_wm_pkl_file[k_record].nome_file = kst_wm_pkl_file[1].nome_file
					kst_wm_pkl_file[k_record].path_file = kst_wm_pkl_file[1].path_file
					kst_wm_pkl_file[k_record].mandante = kds_1.getitemstring(k_righe, "mandatorcustomercode")
					if isnumber(kst_wm_pkl_file[k_record].mandante) then
						kst_wm_pkl_file[k_record].mandante = string(long(kst_wm_pkl_file[k_record].mandante), "##0")
					end if
					kst_wm_pkl_file[k_record].data_invio = string(date(kds_1.getitemdatetime(k_righe, "transmissiondate")))
					kst_wm_pkl_file[k_record].ora_invio = string(time(kds_1.getitemdatetime(k_righe, "transmissiondate")))
					kst_wm_pkl_file[k_record].nrddt = kds_1.getitemstring(k_righe, "ddtcode")
					kst_wm_pkl_file[k_record].dtddt = string(date(kds_1.getitemdatetime(k_righe, "ddtdate")))
					kst_wm_pkl_file[k_record].externalpalletcode = trim(kds_1.getitemstring(k_righe, "externalpalletcode"))
					kst_wm_pkl_file[k_record].idlotto = kds_1.getitemstring(k_righe, "customerlot")
					kst_wm_pkl_file[k_record].idpkl = kds_1.getitemstring(k_righe, "packinglistcode")
				end if
			next
			if k_colli > 0 then
				kst_wm_pkl_file[k_record].colliddt = k_colli
			end if		
	
			k_return = k_record  // torna il nr delle righe del packing
	
		end if	
//----------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	catch (uo_exception kuo_exception)
//		kst_esito.esito = kkg_esito.blok
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Impostazione dati file 'Packing-List' TXT fallito!  ~n~r "  
//		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally
		
	end try
			

return k_return


end function

public function datastore get_wm_pklist_txt (st_wm_pkl_file kst_wm_pkl_file) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie Packing-List Web nalla struct array st_wm_pkl_web[] 
//---	inp: st_wm_pkl_file: nome del file contenente il pkl
//---	out: 
//---	rit: DATASTORE ds_receiptgammarad_l con le righe del pkl trovato
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
//long k_return=0, k_ind_rec=0 
string k_rc
long k_pos_ini, k_pos_fin
int k_file, k_righe, k_riga_ds, k_riga, k_bytes
string k_record
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_esito kst_esito
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
datastore kds_1

  
	try
		kds_1 = create datastore
		kds_1.dataobject = "ds_receiptgammarad_l"
		kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg

//--- piglia il path di dove sono i Packing-list TXT
		kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg)

//--- open del file 
		k_file = fileopen( trim(kst_wm_pkl_file.path_file + kkg.path_sep + kst_wm_pkl_file.nome_file), linemode!, read!, lockreadwrite!)

		if k_file > 0 then
		
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe = 0
			do while k_bytes <> -100 // esce x EOF
				k_righe++     
				
				//kst_tab_wm_receiptgammarad[k_righe]. = mid(k_record,354,35) // Contr.Commerciale
				kst_tab_wm_receiptgammarad[k_righe].id = 0
				
				if isnumber(mid(k_record,3,08)) and isnumber(mid(k_record,12,06)) & 
						and isdate(mid(k_record,3,4) + " " + mid(k_record,7,2) + " " + mid(k_record,9,2)) then
					kst_tab_wm_receiptgammarad[k_righe].transmissiondate = datetime(date(mid(k_record,3,4) + " " + mid(k_record,7,2) + " " + mid(k_record,9,2))&
																			,time(mid(k_record,12,2) + ":" + mid(k_record,14,2) + ":" + mid(k_record,16,2))) // dataora di invio del file
				else
					kst_tab_wm_receiptgammarad[k_righe].transmissiondate = datetime(date(0))
				end if
				if isnumber(trim(mid(k_record,35,02))) then
					kst_tab_wm_receiptgammarad[k_righe].transmissioncode = integer(trim(mid(k_record,35,02)))
				else
					kst_tab_wm_receiptgammarad[k_righe].transmissioncode = 0
				end if
				kst_tab_wm_receiptgammarad[k_righe].packinglistcode = trim(mid(k_record,38,20)) // id pkl cliente
				kst_tab_wm_receiptgammarad[k_righe].ordercode = trim(mid(k_record,59,20)) // n.ordine
				if isnumber(trim(mid(k_record,80,05))) then
					kst_tab_wm_receiptgammarad[k_righe].orderrow = integer(trim(mid(k_record,80,05))) // n.riga ordine
				else
					kst_tab_wm_receiptgammarad[k_righe].orderrow = 0
				end if
				if isnumber(mid(k_record,86,8)) then
					kst_tab_wm_receiptgammarad[k_righe].orderdate = datetime(date(mid(k_record,86,4) + " " + mid(k_record,90,2) + " " + mid(k_record,92,2))) // dt.ordine
				else
					kst_tab_wm_receiptgammarad[k_righe].orderdate = datetime(date(0))
				end if
				kst_tab_wm_receiptgammarad[k_righe].ddtcode = trim(mid(k_record,95,20)) // nr ddt
				if isnumber(mid(k_record,116,08)) then
					kst_tab_wm_receiptgammarad[k_righe].ddtdate = datetime(date(mid(k_record,116,4) + " " + mid(k_record,120,2) + " " + mid(k_record,122,2))) // data ddt
				else
					kst_tab_wm_receiptgammarad[k_righe].ddtdate = datetime(date(0))
				end if
				if isnumber(trim(mid(k_record,125,04))) then
					kst_tab_wm_receiptgammarad[k_righe].palletquantity = 1 // da txt c'e' sempre UNO (forse integer(trim(mid(k_record,125,04))) )
				else
					kst_tab_wm_receiptgammarad[k_righe].palletquantity = 0
				end if
				kst_tab_wm_receiptgammarad[k_righe].externalpalletcode = trim(mid(k_record,130,30)) // barcode cliente
//--- da qui purtroppo il TXT può avere un formato diverso, quindi vado per campi separati da '|' il pipe				
				k_pos_ini = 160
				k_pos_fin = pos(k_record, "|",k_pos_ini)
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].customeritem = trim(mid(k_record,k_pos_ini,20)) //195 cod artic ciente
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].customerlot = trim(mid(k_record,k_pos_ini,20)) //216 cod lotto ciente
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,08))) then
						kst_tab_wm_receiptgammarad[k_righe].dtlotscad = date(mid(k_record,k_pos_ini,4) + " " + mid(k_record,k_pos_ini+4,2) + " " + mid(k_record,k_pos_ini+6,2))  //237 quantità nel collo 
					else
						kst_tab_wm_receiptgammarad[k_righe].dtlotscad = date(0)
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,08))) then
						kst_tab_wm_receiptgammarad[k_righe].pltqtalorda = long(trim(mid(k_record,k_pos_ini,11))) / 100  //246 Quantità lorda del pallet/contenitore (NON IN TABELLA) 
					else
						kst_tab_wm_receiptgammarad[k_righe].pltqtalorda = 0.00
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,11))) then
						kst_tab_wm_receiptgammarad[k_righe].pltqtanetta = long(trim(mid(k_record,k_pos_ini,11))) / 100  //258 Quantità netta del pallet/contenitore (NON IN TABELLA) 
					else
						kst_tab_wm_receiptgammarad[k_righe].pltqtanetta = 0.00
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,04))) then
						kst_tab_wm_receiptgammarad[k_righe].pltqtapezzi = long(trim(mid(k_record,k_pos_ini,04))) / 100  //270 Quantità pezzi del pallet/contenitore (NON IN TABELLA) 
					else
						kst_tab_wm_receiptgammarad[k_righe].pltqtapezzi = 0.00
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].pltidpezzo = trim(mid(k_record,k_pos_ini,35))  //275 Identificazione del singolo pezzo in pallet (NON IN TABELLA) 
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,11))) then
						kst_tab_wm_receiptgammarad[k_righe].quantitasacchi = long(trim(mid(k_record,k_pos_ini,11))) / 100  //340 quantità nel collo 
					else
						kst_tab_wm_receiptgammarad[k_righe].quantitasacchi = 0.00
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)   //352 campo VUOTO
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].specification = trim(mid(k_record,k_pos_ini,35)) //354 capitolato
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].contract = trim(mid(k_record,k_pos_ini,35)) //390 cod.Conferma Ordine 
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					if isnumber(trim(mid(k_record,k_pos_ini,05))) then
						kst_tab_wm_receiptgammarad[k_righe].palletlength = integer(trim(mid(k_record,k_pos_ini,05))) //426 // len del barcode cliente (externalpallet) in uso vecchio WMF
					else
						kst_tab_wm_receiptgammarad[k_righe].palletlength = 0
					end if
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].mandatorcustomercode = trim(mid(k_record,k_pos_ini,10)) //432 mandante
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].receivercustomercode = trim(mid(k_record,k_pos_ini,10)) //443 ricevente
				end if
				if k_pos_fin > 0 then 
					k_pos_ini = k_pos_fin + 1
					k_pos_fin = pos(k_record, "|",k_pos_ini)
					kst_tab_wm_receiptgammarad[k_righe].invoicecustomercode = trim(mid(k_record,k_pos_ini,10)) //454 fatturato
				end if
				
				kst_tab_wm_receiptgammarad[k_righe].accept = "True" //"False"
				kst_tab_wm_receiptgammarad[k_righe].area_mag = ""
				kst_tab_wm_receiptgammarad[k_righe].area_mag_trim = ""
				kst_tab_wm_receiptgammarad[k_righe].id_meca = 0
				kst_tab_wm_receiptgammarad[k_righe].idwmpklist = 0
				kst_tab_wm_receiptgammarad[k_righe].internalpalletcode = ""
				kst_tab_wm_receiptgammarad[k_righe].note_1 = ""
				kst_tab_wm_receiptgammarad[k_righe].note_2 = ""
				kst_tab_wm_receiptgammarad[k_righe].note_3 = ""
				kst_tab_wm_receiptgammarad[k_righe].note_4 = ""
				kst_tab_wm_receiptgammarad[k_righe].pesolordo = 0.00
				kst_tab_wm_receiptgammarad[k_righe].pesonetto = 0.00
				kst_tab_wm_receiptgammarad[k_righe].quarantine = ""
				kst_tab_wm_receiptgammarad[k_righe].readed = "False"
				kst_tab_wm_receiptgammarad[k_righe].receiptdate = kGuf_data_base.prendi_dataora( )
				kst_tab_wm_receiptgammarad[k_righe].registered = "" // non esiete su tab
				kst_tab_wm_receiptgammarad[k_righe].stored = "0"
				
				k_bytes = fileread(k_file, k_record) // legge una riga
			loop
			fileclose(k_file)

		end if

//----------------------------------------------------------------------------------------------------------------------------------------------------------	
//--- Riempie finalmente il datastore con i dati letti del Packing-List
//----------------------------------------------------------------------------------------------------------------------------------------------------------	

		for k_riga = 1 to k_righe
			
				k_riga_ds = kds_1.insertrow(0)
				kds_1.setitem(k_riga_ds, "id", kst_tab_wm_receiptgammarad[k_riga].id)
				kds_1.setitem(k_riga_ds, "pathfile", trim(kst_wm_pkl_file.path_file))
				kds_1.setitem(k_riga_ds, "nomefile", trim(kst_wm_pkl_file.nome_file))
				kds_1.setitem(k_riga_ds, "transmissiondate", kst_tab_wm_receiptgammarad[k_riga].transmissiondate)
				kds_1.setitem(k_riga_ds, "transmissioncode", kst_tab_wm_receiptgammarad[k_riga].transmissioncode)
				kds_1.setitem(k_riga_ds, "packinglistcode", kst_tab_wm_receiptgammarad[k_riga].packinglistcode)
				kds_1.setitem(k_riga_ds, "ordercode", kst_tab_wm_receiptgammarad[k_riga].ordercode)
				kds_1.setitem(k_riga_ds, "orderrow", kst_tab_wm_receiptgammarad[k_riga].orderrow)
				kds_1.setitem(k_riga_ds, "orderdate", kst_tab_wm_receiptgammarad[k_riga].orderdate)
				kds_1.setitem(k_riga_ds, "ddtcode", kst_tab_wm_receiptgammarad[k_riga].ddtcode)
				kds_1.setitem(k_riga_ds, "ddtdate", kst_tab_wm_receiptgammarad[k_riga].ddtdate)
				kds_1.setitem(k_riga_ds, "palletquantity", kst_tab_wm_receiptgammarad[k_riga].palletquantity)
				kds_1.setitem(k_riga_ds, "externalpalletcode", kst_tab_wm_receiptgammarad[k_riga].externalpalletcode)
				kds_1.setitem(k_riga_ds, "customeritem", kst_tab_wm_receiptgammarad[k_riga].customeritem)
				kds_1.setitem(k_riga_ds, "customerlot", kst_tab_wm_receiptgammarad[k_riga].customerlot)
				kds_1.setitem(k_riga_ds, "dtlotscad", kst_tab_wm_receiptgammarad[k_riga].dtlotscad)
				kds_1.setitem(k_riga_ds, "pltqtalorda", kst_tab_wm_receiptgammarad[k_riga].pltqtalorda)
				kds_1.setitem(k_riga_ds, "pltqtanetta", kst_tab_wm_receiptgammarad[k_riga].pltqtanetta)
				kds_1.setitem(k_riga_ds, "pltqtapezzi", kst_tab_wm_receiptgammarad[k_riga].pltqtapezzi)
				kds_1.setitem(k_riga_ds, "pltidpezzo", kst_tab_wm_receiptgammarad[k_riga].pltidpezzo) 
				kds_1.setitem(k_riga_ds, "quantitasacchi", kst_tab_wm_receiptgammarad[k_riga].quantitasacchi)
				kds_1.setitem(k_riga_ds, "specification", kst_tab_wm_receiptgammarad[k_riga].specification) 
				kds_1.setitem(k_riga_ds, "contract", kst_tab_wm_receiptgammarad[k_riga].contract) 
				kds_1.setitem(k_riga_ds, "palletlength", kst_tab_wm_receiptgammarad[k_riga].palletlength) 
				kds_1.setitem(k_riga_ds, "mandatorcustomercode", kst_tab_wm_receiptgammarad[k_riga].mandatorcustomercode) 
				kds_1.setitem(k_riga_ds, "receivercustomercode", kst_tab_wm_receiptgammarad[k_riga].receivercustomercode) 
				kds_1.setitem(k_riga_ds, "invoicecustomercode", kst_tab_wm_receiptgammarad[k_riga].invoicecustomercode) 
				kds_1.setitem(k_riga_ds, "accept", kst_tab_wm_receiptgammarad[k_riga].accept) 
				kds_1.setitem(k_riga_ds, "warehouse", kst_tab_wm_receiptgammarad[k_riga].area_mag) 
//				kds_1.setitem(k_riga_ds, "area_mag_trim", kst_tab_wm_receiptgammarad[k_riga].area_mag_trim) 
				kds_1.setitem(k_riga_ds, "id_meca", kst_tab_wm_receiptgammarad[k_riga].id_meca) 
				kds_1.setitem(k_riga_ds, "idwmpklist", kst_tab_wm_receiptgammarad[k_riga].idwmpklist) 
				kds_1.setitem(k_riga_ds, "internalpalletcode", kst_tab_wm_receiptgammarad[k_riga].internalpalletcode) 
				kds_1.setitem(k_riga_ds, "note_1", kst_tab_wm_receiptgammarad[k_riga].note_1) 
				kds_1.setitem(k_riga_ds, "note_2", kst_tab_wm_receiptgammarad[k_riga].note_2) 
				kds_1.setitem(k_riga_ds, "note_3", kst_tab_wm_receiptgammarad[k_riga].note_3) 
				kds_1.setitem(k_riga_ds, "note_4", kst_tab_wm_receiptgammarad[k_riga].note_4) 
				kds_1.setitem(k_riga_ds, "pesolordo", kst_tab_wm_receiptgammarad[k_riga].pesolordo) 
				kds_1.setitem(k_riga_ds, "pesonetto", kst_tab_wm_receiptgammarad[k_riga].pesonetto) 
				kds_1.setitem(k_riga_ds, "quarantine", kst_tab_wm_receiptgammarad[k_riga].quarantine) 
				kds_1.setitem(k_riga_ds, "readed", kst_tab_wm_receiptgammarad[k_riga].readed) 
				kds_1.setitem(k_riga_ds, "receiptdate", kst_tab_wm_receiptgammarad[k_riga].receiptdate) 
			//	kds_1.setitem(k_riga_ds, "registered", kst_tab_wm_receiptgammarad[k_riga].registered) 
				kds_1.setitem(k_riga_ds, "stored", kst_tab_wm_receiptgammarad[k_riga].stored)
				kds_1.setitem(k_riga_ds, "tipoinvio", "TXT")
		
		end for
	
//		k_return = kds_1  // torna il ds  con le righe del packing

	
//----------------------------------------------------------------------------------------------------------------------------------------------------------	
	
	catch (uo_exception kuo_exception)
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' TXT fallito! file: " &
		                         + trim(kst_wm_pkl_file.path_file + kkg.path_sep + kst_wm_pkl_file.nome_file) // ~n~r "  
		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally
//		destroy kuf1_contratti
		destroy kuf1_wm_pklist_cfg
		
	end try
			

return kds_1


end function

public function long importa_wm_pklist_txt () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Importa Packing-List grezzo da file TXT nella Tabella del DB di MAGAZZINO-WAREHOUSE-MANAGEMENT
//---	ReceiptGammarad
//---
//---	inp: kst_tab_wm_receiptgammarad. 
//---	out: 
//---	rit: nr. dei Pcking Prodotti 
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
long k_id_wm_pklist_importato=0, k_nr_file_txt=0, k_ind_file=0, k_nr_ws_receiptgammarad=0, k_ctr_ws_receiptgammarad=0, k_nr_wm_pkl_txt=0
boolean k_rc
int k_rcn
string k_nome_file=""
st_esito kst_esito
st_wm_pklist kst_wm_pklist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_wm_pkl_file kst_wm_pkl_file, kst_wm_pkl_file_txt[]
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[], kst_tab_wm_receiptgammarad_NULLA[]
kuf_utility kuf1_utility
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
datastore kds_1_da_imp
					

try

	kuf1_utility = create kuf_utility
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kds_1_da_imp = create datastore
			
//--- leggo configurazione x lo scambio dati
	if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
//--- parte l'importazione solo se PACKING-LIST da M2000 e non più da WM		
		if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_dam2000 then

//--- Leggo il file 
			kst_wm_pkl_file_txt[100].nome_file = " "   // x sicurezza crea intanto una tabellina grande 100 elementi 
			k_nr_file_txt = get_file_wm_pklist_txt(kst_wm_pkl_file_txt[]) 

			for k_ind_file = 1 to k_nr_file_txt 
				
				kst_wm_pkl_file.nome_file = kst_wm_pkl_file_txt[k_ind_file].nome_file
				kst_wm_pkl_file.path_file = kst_wm_pkl_file_txt[k_ind_file].path_file
	
				if len(trim(kst_wm_pkl_file.nome_file)) > 0 then   // se c'e' un file....
		//--- muove il file TXT nella cartella dei flussi 'IN LAVORAZIONE'
					if not DirectoryExists (kst_wm_pkl_file.path_file+"\inLav") then CreateDirectory (kst_wm_pkl_file.path_file+"\inLav") 
					kuf1_utility.u_filemovereplace( kst_wm_pkl_file.path_file +"\"+  kst_wm_pkl_file.nome_file,  &
																				 kst_wm_pkl_file.path_file+"\inLav\"+kst_wm_pkl_file.nome_file)
					kst_wm_pkl_file.path_file = kst_wm_pkl_file.path_file+"\inLav"
					
		//--- Legge le Packing-list in formato TXT 
					kds_1_da_imp = get_wm_pklist_txt(kst_wm_pkl_file) 
					k_nr_wm_pkl_txt = kds_1_da_imp.rowcount( )
					if k_nr_wm_pkl_txt > 0 then
					
	//--- Imposta nell'area ReceiptGammarad le Packing-list in formato TXT 
						kst_tab_wm_receiptgammarad[] = kst_tab_wm_receiptgammarad_NULLA[]
						k_nr_ws_receiptgammarad = set_wm_pklist_txt_to_wm_tab(kds_1_da_imp, kst_tab_wm_receiptgammarad[]) 
				
	//--- muove il file TXT nella cartella dei flussi IMPORTATI	
						kst_wm_pkl_file.path_file = kst_wm_pkl_file_txt[k_ind_file].path_file
						if not DirectoryExists (kst_wm_pkl_file.path_file+"\importato") then CreateDirectory (kst_wm_pkl_file.path_file+"\importato") 
						kuf1_utility.u_filemovereplace( kst_wm_pkl_file.path_file +"\inLav\"+kst_wm_pkl_file.nome_file,  &
																				 kst_wm_pkl_file.path_file+"\importato\"+kst_wm_pkl_file.nome_file)
	
//--- INSERT nella tabella di PACKING-LIST
						k_return = kuf1_wm_receiptgammarad.crea( k_nr_ws_receiptgammarad, kst_tab_wm_receiptgammarad[] )
					
					end if
				end if
						
			end for
		else
			kguo_exception.inizializza( )
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
			kguo_exception.setmessage( "NON eseguito. Se si vuole importare PKL-WEB,  RIATTIVARE da Proprietà della proceura.")
			throw kguo_exception
		end if
	end if
	
catch (uo_exception kuo_exception)
//	kst_esito = kuo_exception.get_st_esito( )
//	
//	kGuf_data_base.errori_scrivi_esito ("I", kst_esito)
////	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
////		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
////	end if
	throw kuo_exception
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	if isvalid(kds_1_da_imp) then destroy kds_1_da_imp
	
end try


return k_return


end function

public function long set_wm_pklist_txt_to_wm_tab (ref datastore kds_receiptgammarad_l, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Converte il Packing-List TXT nalla struct array kst_tab_wm_receiptgammarad []
//---	inp: datastore ds_receiptgammarad_l che contiene i dati del pkl copiati dal file 
//---	out: kst_tab_wm_receiptgammarad[]: array con le righe del packing-list 
//---	rit: nr pkl trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
string k_rc, k_file=""
int k_rcn, k_file_ind, k_anno, k_mese, k_giorno
long k_ind=0, k_max_row, k_ctr
datetime k_datetime_current
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_null
 
 
	try
		k_max_row = kds_receiptgammarad_l.rowcount()

		k_datetime_current = kguo_g.get_datetime_current( )

		//--- ordino per codice barcode cliente
		kds_receiptgammarad_l.setsort("externalpalletcode A")
		kds_receiptgammarad_l.sort( )
				
//--- preparo la struct a NULL		
		set_null(kst_tab_wm_receiptgammarad_null)
		
		for k_file_ind = 1 to k_max_row

			if trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "packinglistcode")) > " " &
															and trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "externalpalletcode")) > " " then

				if k_ind > 1 and trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "externalpalletcode")) &
																= trim(kds_receiptgammarad_l.getitemstring(k_file_ind - 1, "externalpalletcode")) then
					if kds_receiptgammarad_l.getitemnumber(k_file_ind, "PesoNetto") > 0 then
						kst_tab_wm_receiptgammarad[k_ind].PesoNetto += kds_receiptgammarad_l.getitemnumber(k_file_ind, "PesoNetto")
					end if
					if kds_receiptgammarad_l.getitemnumber(k_file_ind, "PesoLordo") > 0 then
						kst_tab_wm_receiptgammarad[k_ind].PesoLordo += kds_receiptgammarad_l.getitemnumber(k_file_ind, "PesoLordo")
					end if
					if kds_receiptgammarad_l.getitemnumber(k_file_ind, "QuantitaSacchi") > 0 then
						kst_tab_wm_receiptgammarad[k_ind].QuantitaSacchi += kds_receiptgammarad_l.getitemnumber(k_file_ind, "QuantitaSacchi")
					end if
				end if
				
				if k_file_ind = 1 or trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "externalpalletcode")) &
											<> trim(kds_receiptgammarad_l.getitemstring(k_file_ind - 1, "externalpalletcode")) then
											
					k_ind++

//--- inizializzo la riga				
					kst_tab_wm_receiptgammarad[k_ind] = kst_tab_wm_receiptgammarad_null
				
//--- codice packing-list
					kst_tab_wm_receiptgammarad[k_ind].packinglistcode = "txt_" + trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "packinglistcode")) 
//--- converte la data di invio
					kst_tab_wm_receiptgammarad[k_ind].transmissiondate = kds_receiptgammarad_l.getitemdatetime(k_file_ind, "transmissiondate")

					kst_tab_wm_receiptgammarad[k_ind].receiptdate = k_datetime_current //datetime(date(today()),time(now()))
					kst_tab_wm_receiptgammarad[k_ind].ddtcode	= upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "ddtcode")) )
					kst_tab_wm_receiptgammarad[k_ind].ddtdate = kds_receiptgammarad_l.getitemdatetime(k_file_ind, "ddtdate")
					kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "mandatorcustomercode")) )
					kst_tab_wm_receiptgammarad[k_ind].receivercustomercode = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "receivercustomercode")) )
					kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "invoicecustomercode")) )
					kst_tab_wm_receiptgammarad[k_ind].specification = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "specification")) )
					kst_tab_wm_receiptgammarad[k_ind].contract = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "contract")) )
					kst_tab_wm_receiptgammarad[k_ind].externalpalletcode = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "externalpalletcode")) )
					kst_tab_wm_receiptgammarad[k_ind].palletlength = len(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "externalpalletcode")))
					if kds_receiptgammarad_l.getitemnumber(k_file_ind, "palletquantity") > 0 then
						kst_tab_wm_receiptgammarad[k_ind].palletquantity = kds_receiptgammarad_l.getitemnumber(k_file_ind, "palletquantity")
					else
						kst_tab_wm_receiptgammarad[k_ind].palletquantity = 1	
					end if

					if trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "customerlot")) > " " then
						kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "customerlot")) )
					else
						kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "packinglistcode")) )
					end if
					kst_tab_wm_receiptgammarad[k_ind].orderdate = k_datetime_current //datetime(date(today()),time(now()))

//--- altri dati circa il singolo barcode
					kst_tab_wm_receiptgammarad[k_ind].customerItem = upper(trim(kds_receiptgammarad_l.getitemstring(k_file_ind, "customerItem")) )

					kst_tab_wm_receiptgammarad[1].note_3 = ""
					kst_tab_wm_receiptgammarad[1].note_2 = ""
					kst_tab_wm_receiptgammarad[1].note_1 = ""
					
				end if					
			end if				
		end for
	
		k_return = k_ind
		
	catch (uo_exception kuo_exception)
//		kst_esito.esito = kkg_esito.blok
//		kst_esito.sqlcode = k_rcn
//		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito!  ~n~r "  
//		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
	finally

		
	end try
			


return k_return


end function

public function boolean set_id_meca (st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//====================================================================
//=== Add ID_MECA in tabella RECEIPTGAMMARAD
//=== 
//=== Input: st_tab_wm_receiptgammarad.id_meca / idwmpklist
//=== Ritorna:  TRUE = OK
//=== 
//====================================================================
//
boolean k_return=false
boolean k_sicurezza
kuo_sqlca_db_0 kuo1_sqlca_db_0
st_esito kst_esito

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	k_sicurezza = if_sicurezza(kkg_flag_modalita.modifica)
	if not k_sicurezza then
	
		kst_esito.SQLErrText = "Modifica Tabella Magazzino Packing-List (receiptgammarad) non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else
	
		if kst_tab_wm_receiptgammarad.id_meca > 0 and kst_tab_wm_receiptgammarad.idwmpklist > 0 then
	
			kuo1_sqlca_db_0 = set_connessione(true)
			//kGuo_sqlca_db_wm.db_connetti()
//		kst_tab_wm_receiptgammarad.x_datins = kGuf_data_base.prendi_x_datins()
//		kst_tab_wm_receiptgammarad.x_utente = kGuf_data_base.prendi_x_utente()
		
			update receiptgammarad
					set Id_meca = :kst_tab_wm_receiptgammarad.id_meca
					where idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					using kuo1_sqlca_db_0;
				
			if kuo1_sqlca_db_0.sqlcode < 0 then
					
				kst_esito.sqlcode = kuo1_sqlca_db_0.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante pulizia tabella di Magazzino Packing-List  (id meca di receiptgammarad) ~n~r" &
						+ " id=" + string(kst_tab_wm_receiptgammarad.id, "####0") + " " &
						+ " ~n~rErrore-tab.'receiptgammarad':"	+ trim(kuo1_sqlca_db_0.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko

				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					rollback using kuo1_sqlca_db_0;
				end if				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception				
				
			end if

			if kuo1_sqlca_db_0.sqlcode = 0 then
		//---- COMMIT....	
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					commit using kuo1_sqlca_db_0;
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = trim(sqlca.SQLErrText)
					end if
				end if
				k_return = true
			end if
		
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = &
		"Manca il codice Packing-List o ID Lotto per aggiornare tabella Magazzino Packing-List  (id meca di receiptgammarad) ~n~r" &
						+ " id PkList=" + string(kst_tab_wm_receiptgammarad.idwmpklist, "####0") + " " &
						+ " id Lotto=" + string(kst_tab_wm_receiptgammarad.id_meca, "####0") + " " &
						+ " ~n~r"
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception				
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	set_connessione(false)
	//kguo_sqlca_db_wm.db_disconnetti( ) // meglio disconnettere

end try

return k_return


end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//--- 
//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true

st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 



SetPointer(kkg.pointer_attesa)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "packinglistcode"
		kst_tab_wm_receiptgammarad.packinglistcode = trim(adw_link.getitemstring(adw_link.getrow(), a_campo_link))
		if kst_tab_wm_receiptgammarad.packinglistcode > " " then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_receiptgammarad )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Packing-list Mandante " + kst_tab_wm_receiptgammarad.packinglistcode + " " 
		else
			k_return = false
		end if

//
//	case "b_certif_lotto"
//		kst_tab_wm_receiptgammarad.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
//		if kst_tab_wm_receiptgammarad.id_meca > 0 then
//			get_num_certif (kst_tab_wm_receiptgammarad)   //  piglia il NUMERO CERTIFICATO
//			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_wm_receiptgammarad )
//			if kst_esito.esito <> kkg_esito.ok then
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//				throw kguo_exception
//			end if
//			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_wm_receiptgammarad.num_certif)) + ") " 
//		else
//			k_return = false
//		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma.elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita) )
		throw kguo_exception
		
		
	end if

end if
//
//SetPointer(kp_oldpointer)
//


return k_return

end function

public function boolean tb_delete_x_idwmpklist (ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella Receiptgammarad x codice del wm_pklist
//=== 
//=== Ritorna TRUE = delete OK
//===           	
//====================================================================
//
boolean k_return = false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok 
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	//if_sicurezza(kkg_flag_modalita.CANCELLAZIONE)
	
	if len(trim(kst_tab_wm_receiptgammarad.packinglistcode)) > 0 then
	
		delete from  receiptgammarad 
					where idwmpklist = :kst_tab_wm_receiptgammarad.idwmpklist
					using kguo_sqlca_db_magazzino;
		
		
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione 'Packing List WM' cod.pkl=" + string(kst_tab_wm_receiptgammarad.idwmpklist) + " (wm_receiptgammarad):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
				
		//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			if sqlca.sqlcode = 0 then
				k_return = true
				if kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_wm_receiptgammarad.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
		end if
				
	end if
	
catch(uo_exception kuo_exception)
	throw kuo_exception

finally

end try

return k_return

end function

on kuf_wm_receiptgammarad.create
call super::create
end on

on kuf_wm_receiptgammarad.destroy
call super::destroy
end on

