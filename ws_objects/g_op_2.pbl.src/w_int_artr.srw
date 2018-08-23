$PBExportHeader$w_int_artr.srw
forward
global type w_int_artr from w_g_tab_3
end type
type ddplb_report from dropdownpicturelistbox within tabpage_1
end type
type st_report from statictext within tabpage_1
end type
end forward

global type w_int_artr from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3424
integer height = 2176
string title = "Interrogazioni: Magazzino"
long backcolor = 32567536
boolean ki_toolbar_window_presente = true
end type
global w_int_artr w_int_artr

type variables
//
st_int_artr kist_int_artr

private kuf_utility kiuf_utility
private kuf_report_pilota kiuf_report_pilota
private kuf_pilota_previsioni kiuf_pilota_previsioni

//--- variabile contenente la scelta del REPORT
private int ki_scelta_report_generico = 0
private int ki_scelta_report_coda_pilota = 0
private int ki_scelta_report_in_trattamento = 0
private int ki_scelta_report_trattato = 0
private int ki_scelta_report_chk_intra = 0
private int ki_scelta_report_lotti_in_giacenza = 0
private int ki_scelta_report_lotti_entrati = 0
private int ki_scelta_report_lotti_in_giacenza_gia_trattati = 0
private int ki_scelta_report_RegArt50 = 0
private int ki_scelta_report_lotti_da_sped = 0
private int ki_scelta_report_lotti_sped = 0
private int ki_scelta_report_etichette_lotti = 0
private int ki_scelta_report_groupage = 0
private int ki_scelta_report_etichettine = 0
private int ki_scelta_report_bcode_trattati = 0
private int ki_scelta_report_art_movim = 0
//private int ki_scelta_report_armo_prezzi = 0
private int ki_scelta_report_memo = 0
private int ki_scelta_report_lotti_sped_daFatt = 0
private int ki_scelta_report_Attestati = 0
private int ki_scelta_report_armo_Contratti = 0
private int ki_scelta_report_LavxCapitolato = 0
private int ki_scelta_report_RunsRtrRts = 0
private int ki_scelta_report_prevFineLav = 0

//--- variabile contenentei l'indice della picture x la scelta del REPORT
private int ki_scelta_report=0
private int ki_scelta_report_pic_generico = 0
private int ki_scelta_report_pic_coda_pilota = 0
private int ki_scelta_report_pic_in_trattamento = 0
private int ki_scelta_report_pic_trattato = 0
private int ki_scelta_report_pic_chk_intra = 0
private int ki_scelta_report_pic_lotti_in_giacenza = 0
private int ki_scelta_report_pic_lotti_entrati = 0
private int ki_scelta_report_pic_lotti_in_giacenza_gia_trattati = 0
private int ki_scelta_report_pic_RegArt50 = 0
private int ki_scelta_report_pic_lotti_da_sped = 0
private int ki_scelta_report_pic_lotti_sped = 0
private int ki_scelta_report_pic_etichette_lotti = 0
private int ki_scelta_report_pic_groupage = 0
private int ki_scelta_report_pic_etichettine = 0
private int ki_scelta_report_pic_bcode_trattati = 0
private int ki_scelta_report_pic_art_movim = 0
//private int ki_scelta_report_pic_armo_prezzi = 0
private int ki_scelta_report_pic_memo = 0
private int ki_scelta_report_pic_lotti_sped_daFatt = 0
private int ki_scelta_report_pic_Attestati = 0
private int ki_scelta_report_pic_armo_Contratti = 0
private int ki_scelta_report_pic_LavxCapitolato = 0
private int ki_scelta_report_pic_RunsRtrRts = 0
private int ki_scelta_report_pic_prevFineLav = 0

private boolean ki_scegli_report = false


end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
private subroutine leggi_dwc_barcode (long k_riga, ref datawindow k_dw)
private subroutine crea_view_x_report ()
private subroutine set_nome_utente_tab () throws uo_exception
private subroutine get_parametri () throws uo_exception
private subroutine report_1 ()
private subroutine report_2 ()
private function long report_2_inizializza (uo_d_std_1 kdw_1)
protected subroutine stampa ()
private subroutine report_3 ()
private function long report_3_inizializza (uo_d_std_1 kdw_1)
private subroutine report_4 ()
private function long report_4_inizializza (uo_d_std_1 kdw_1)
protected function integer inserisci ()
private subroutine report_5 ()
private subroutine get_id_meca (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception
private subroutine report_6 ()
private function long report_6_inizializza (uo_d_std_1 kdw_1)
private subroutine get_parametri_6 () throws uo_exception
private subroutine crea_view_x_report_6 ()
private subroutine report_7 ()
private function long report_7_inizializza (uo_d_std_1 kdw_1)
private subroutine get_parametri_7 () throws uo_exception
private subroutine report_8 ()
private subroutine get_parametri_8 () throws uo_exception
private subroutine crea_view_x_report_8 ()
protected subroutine open_start_window ()
private subroutine report_9 ()
public subroutine report_9_salva_dati ()
private subroutine report_10 ()
private function long report_5_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private function long report_8_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private function long report_9_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private function long report_10_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine leggi_dwc_rif_x_data_mrf (long k_riga, ref datawindow k_dw)
private function long report_14_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_14 ()
private function long report_13_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_13 ()
private function long report_12_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_12 ()
private subroutine report_11 ()
private function long report_11_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_15 ()
private subroutine get_parametri_15 () throws uo_exception
private function long report_15_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_16 ()
private subroutine get_parametri_16 () throws uo_exception
private function long report_16_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine get_parametri_17 () throws uo_exception
private function long report_17_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_17 ()
private subroutine report_18 ()
private function long report_18_inizializza (uo_d_std_1 kdw_1) throws uo_exception
public subroutine get_parametri_18 () throws uo_exception
private subroutine get_parametri_19 () throws uo_exception
private function long report_19_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine report_19 ()
public subroutine u_scegli_report (integer a_num_report)
private subroutine report_20 ()
private function long report_20_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine get_parametri_20 () throws uo_exception
private subroutine get_parametri_21 () throws uo_exception
private subroutine report_21 ()
private function long report_21_inizializza (uo_d_std_1 kdw_1) throws uo_exception
public subroutine u_parametri_clicked (string k_nome, long k_riga)
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine inizializza_8 () throws uo_exception
public subroutine u_inizializza_dw_tag ()
protected subroutine smista_funz (string k_par_in)
private function long report_1_inizializza (uo_d_std_1 kdw_1)
public subroutine u_set_tabpage_picture (boolean a_pic_ok)
private subroutine u_report_run () throws uo_exception
private subroutine u_report_run_1 (uo_d_std_1 kdw_1) throws uo_exception
protected subroutine attiva_menu ()
public subroutine u_close_tab ()
private function integer u_get_idx_report_vuoto ()
protected subroutine attiva_tasti_0 ()
private subroutine report_22 ()
public subroutine u_dw_selezione_save ()
public function integer u_dw_selezione_ripri ()
private subroutine report_0 ()
public subroutine u_resize_1 ()
private function long report_22_inizializza (uo_d_std_1 kdw_1) throws uo_exception
private subroutine get_parametri_22 () throws uo_exception
private subroutine crea_view_x_report_22 ()
public function integer u_report_selezionato ()
public function string u_report_selezionato_title ()
private subroutine leggi_dwc_gruppi (ref datawindow k_dw)
private subroutine leggi_gru_no_stat (ref datawindow k_dw)
private subroutine crea_view_x_report_7 () throws uo_exception
private subroutine get_parametri_23 () throws uo_exception
private subroutine report_23 ()
private function long report_23_inizializza (uo_d_std_1 kdw_1)
private subroutine crea_view_x_report_23_runsrtrrts () throws uo_exception
private subroutine leggi_dwc_runsrtrrts_help (long k_riga, ref datawindow k_dw)
protected function string u_get_dataobject_esporta ()
protected subroutine riposiziona_cursore ()
private function long report_24_inizializza (uo_d_std_1 kdw_1)
private subroutine report_24 ()
end prototypes

protected function string inizializza () throws uo_exception;////======================================================================
////=== Inizializzazione della Windows
////=== Ripristino DW; tasti; e retrieve liste
////======================================================================
////

ki_scegli_report = true

if tab_1.tabpage_1.dw_1.rowcount( ) = 0 then 
//	tab_1.tabpage_1.dw_1.reset( )
	u_scegli_report(ki_scelta_report)
end if

return "0"

	



end function

protected subroutine inizializza_1 () throws uo_exception;//

try

	
	kidw_selezionata = tab_1.tabpage_2.dw_2
	u_report_run()
//	u_report(tab_1.tabpage_2.dw_2)

//	if not tab_1.tabpage_3.visible then
//		tab_1.tabpage_3.picturename = "VCRNext!"
//		tab_1.tabpage_3.text = "Report 2"
//		tab_1.tabpage_3.visible = true
//	end if
//		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

private subroutine leggi_dwc_barcode (long k_riga, ref datawindow k_dw);//
st_tab_meca kst_tab_meca
datawindowchild kdwc_barcode

//--- se sono sul report generico allora faccio vedere i barcode
//if ki_scelta_report = ki_scelta_report_generico then

	k_dw.getchild("b_barcode_l", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if k_dw.rowcount() > 0 then

		if k_riga > 0 then
			kst_tab_meca.id = k_dw.getitemnumber(k_riga,"id_meca")
			if kdwc_barcode.retrieve(kst_tab_meca.id) > 0 then

				kdwc_barcode.insertrow(0)
			
			end if
		else
			kdwc_barcode.insertrow(0)
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

//end if
end subroutine

private subroutine crea_view_x_report ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


	kuf1_utility = create kuf_utility

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_int_artr.utente) + "_int_artr "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
	 
	k_sql += &
		+ " SELECT distinct armo.id_armo, armo.id_meca  FROM "  &
		+ " meca INNER JOIN armo " &
		+ " ON meca.id = armo.id_meca " 

//--- se richiesto piglio solo i Lotti che hanno avuto la "NON CONFORMITA'" in entrata e/o la puntuale Causale di Blocco
	if kist_int_artr.meca_blk then
		k_sql += &
		  "  INNER JOIN meca_blk " &
		+ " ON meca.id = meca_blk.id_meca "  
	end if
//--- Filtro x CAUSALE di Entrata	
	if kist_int_artr.id_meca_causale > 0 then
		if NOT kist_int_artr.meca_blk then
			k_sql += "  INNER JOIN meca_blk  ON meca.id = meca_blk.id_meca "
		end if
		k_sql += " and meca_blk.id_meca_causale = " + string(kist_int_artr.id_meca_causale)   
	end if
	
	if kist_int_artr.upd_data_fin > date('01.01.1900') or kist_int_artr.upd_data_ok > date('01.01.1900') &
		or kist_int_artr.barcode <> '*' then
		k_sql += &
		  "  LEFT OUTER JOIN barcode " &
		+ " ON armo.id_armo = barcode.id_armo "  
//		+ " 	left outer JOIN artr " &
//		+ " ON barcode.id_armo = artr.id_armo and barcode.pl_barcode = artr.pl_barcode " 
	else
		k_sql += &
		+ "   " 
	end if

	k_sql += &
			+ " LEFT OUTER JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left OUTER JOIN artr " &
			+ " ON armo.id_armo = artr.id_armo " &
			+ " LEFT OUTER JOIN clienti as clienti_a " & 
			+ " ON meca.clie_1 = clienti_a.codice " &
			+ " LEFT OUTER JOIN clienti as clienti_b  " &
			+ " ON meca.clie_2 = clienti_b.codice " &
			+ " LEFT OUTER JOIN clienti as clienti_c " & 
			+ " ON meca.clie_3 = clienti_c.codice " &
			+ " LEFT OUTER JOIN meca_dosim  " &
			+ " ON meca.id = meca_dosim.id_meca " 

	k_sql += " WHERE  " &
			+ " (meca.id between " + string(kist_int_artr.id_meca_ini) + " and " + string(kist_int_artr.id_meca_fin) + ") " 
	

	if kist_int_artr.data_da > date(0) and not isnull(kist_int_artr.data_da) then
		if kist_int_artr.data_da = kist_int_artr.data_a then
			k_sql +=  " and meca.data_int = '" + string(kist_int_artr.data_da) + "' "
		else
			if kist_int_artr.data_a > date(0) and not isnull(kist_int_artr.data_a) then
				k_sql +=  " and meca.data_int between '" + string(kist_int_artr.data_da) + "' and '"+ string(kist_int_artr.data_a) + "' "
			else
				k_sql +=  " and meca.data_int >= '" + string(kist_int_artr.data_da) + "' "
			end if
		end if
	end if

	if kist_int_artr.impianto > 0 then
		k_sql +=  " and armo.magazzino = " + string(kist_int_artr.impianto) + " "
	end if

	choose case kist_int_artr.lavorazione
		case "N"
			k_sql +=  " and ((artr.data_in =   '" + string(date('01.01.1900')) + "' or artr.data_in is null or artr.data_in =  0)) " 

		case "I"
			k_sql +=  &  
					" and (artr.data_fin =  '" + string(date(0)) + "' or artr.data_fin is null)   " &
			        + " and artr.data_in >  '" + string(date(0)) + "' " 

		case "F"
			k_sql +=  " and artr.data_in > '" + string(date(0)) + "' and artr.data_fin > '" + string(date(0)) + "' " 
		
		case "C"
			k_sql +=  " and ( meca_dosim.dosim_data >  '" + string(date('01.01.1900')) + "') " 
		
		case "CE"
			k_sql +=  " and ( meca.err_lav_ok = " + kuf_meca_dosim.ki_err_lav_ok_conv_ko_sbloc + ") " 
		
	end choose

	choose case kist_int_artr.m_r_f
		case "0"
			if kist_int_artr.clie_1 > 0 then
				k_sql +=  " and (meca.clie_1 = " + string(kist_int_artr.clie_1) + ")  " 
			end if
			if kist_int_artr.clie_2 > 0 then
				k_sql +=  " and (meca.clie_2 = " + string(kist_int_artr.clie_2) + ")  " 
			end if
			if kist_int_artr.clie_3 > 0 then
				k_sql +=  " and (meca.clie_3 = " + string(kist_int_artr.clie_3) + ")  " 
			end if

		case "1"
			k_sql +=  " and (meca.clie_1 =  " + string(kist_int_artr.clie_1) + " " + & 
							 " or meca.clie_2 =  " + string(kist_int_artr.clie_2) + "  " + & 
							 " or meca.clie_3 =  " + string(kist_int_artr.clie_3) + ")  " 
	end choose

	choose case kist_int_artr.certificato_st
		case "S"
			k_sql +=  " and artr.data_st >  '" + string(date('01.01.1900')) + "'  " 

		case "N"
			k_sql +=  " and ( artr.data_st =  '" + string(date('01.01.1900')) + "' or artr.data_st is null )   " 
	end choose

					 
	if kist_int_artr.anno_bolla_in > 0 then 
		k_sql += " and year(meca.data_bolla_in) = " + string(kist_int_artr.anno_bolla_in)
	end if
	if LenA(kist_int_artr.num_bolla_in) > 0 then 
		k_sql += " and (meca.num_bolla_in like '" + string(kist_int_artr.num_bolla_in) + "' ) "
	end if
	if kist_int_artr.dose > 0 then k_sql += " and armo.dose = " + kuf1_utility.u_num_itatousa(string(kist_int_artr.dose)) //string(kist_int_artr.dose, "###,###.##") 
	if kist_int_artr.data_ini > date('01.01.1900') then k_sql += " and artr.data_in >= '" + string(kist_int_artr.data_ini) + "' "
	if kist_int_artr.data_ini_1 > date('01.01.1900') then k_sql += " and artr.data_in <= '" + string(kist_int_artr.data_ini_1) + "' " 
	if kist_int_artr.data_fin > date('01.01.1900') then k_sql += " and artr.data_fin >= '" + string(kist_int_artr.data_fin) + "' " 
	if kist_int_artr.data_fin_1 > date('01.01.1900') then k_sql += " and artr.data_fin <= '" + string(kist_int_artr.data_fin_1) + "' "
	if kist_int_artr.certificato_dt_st_ini > date('01.01.1900') then k_sql += " and artr.data_st >= '" + string(kist_int_artr.certificato_dt_st_ini) + "' "
	if kist_int_artr.certificato_dt_st_fin > date('01.01.1900') then k_sql += " and artr.data_st <= '" + string(kist_int_artr.certificato_dt_st_fin) + "' "  
	if kist_int_artr.dosim_data_i > date('01.01.1900') then k_sql += " and meca_dosim.dosim_data >= '" + string(kist_int_artr.dosim_data_i) + "' " 
	if kist_int_artr.dosim_data_f > date('01.01.1900') then k_sql += " and meca_dosim.dosim_data <= '"+ string(kist_int_artr.dosim_data_f) + "' "  
	if kist_int_artr.err_lav_ok <> "0" then k_sql += " and meca.err_lav_ok = '" + kist_int_artr.err_lav_ok + "' "
	if kist_int_artr.num_certif <> 0 then k_sql += " and artr.num_certif = " + string(kist_int_artr.num_certif) 
	if kist_int_artr.groupage <> "*" then k_sql += " and barcode.groupage = '" + kist_int_artr.groupage  + "' " 
	if kist_int_artr.barcode <> "*" then k_sql += " and barcode.barcode like '" + kist_int_artr.barcode  + "' "
	if kist_int_artr.upd_data_fin > date('01.01.1900') then k_sql += " and convert(date,barcode.upd_data_fin) = '" + string(kist_int_artr.upd_data_fin) + "' "
	if kist_int_artr.upd_data_ok > date('01.01.1900') then k_sql += " and convert(date,barcode.upd_data_ok) = '" + string(kist_int_artr.upd_data_ok) + "' "  
	if kist_int_artr.art > " " then k_sql += " and  armo.art =  '" + kist_int_artr.art  + "' "


//order by armo.data_int desc, armo.num_int desc
	 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine set_nome_utente_tab () throws uo_exception;//
//--- setto il nome utente x il nome della view
//
int k_ctr=0


	kist_int_artr.utente = kguo_utente.get_comp()
	if LenA(trim(kist_int_artr.utente)) > 0 then
		kist_int_artr.utente = MidA(kist_int_artr.utente, 1, 4)
		
		k_ctr = PosA(kist_int_artr.utente, ".") 
		do while k_ctr > 0 
			kist_int_artr.utente = ReplaceA ( kist_int_artr.utente, k_ctr, 1, "_" ) 
			k_ctr = PosA( kist_int_artr.utente, "." ) 
		loop 
//--- aggiungo il numero tab al nome utente
		if LenA(trim(string(tab_1.selectedtab))) = 0 then
			kist_int_artr.utente = kist_int_artr.utente + "_" 
		else
			kist_int_artr.utente = kist_int_artr.utente + trim(string(tab_1.selectedtab)) 
		end if
	else
		kist_int_artr.utente = ""
		kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_utente)
		kGuo_exception.setmessage("Errore nel reperimento dell'Utente di connessione al sistema,~n~r" &
				+"prego riprovare l'operazione." )
		throw kGuo_exception 
	end if


//
end subroutine

private subroutine get_parametri () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
date k_data_da, k_data_a, k_dataoggi
long k_num_int_ini, k_num_int_fin, k_anno
boolean k_errore=true
kuf_utility kuf1_utility
//kuf_base kuf1_base
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



	kist_int_artr.impianto = tab_1.tabpage_1.dw_1.getitemnumber(1, "impianto") //Impianto
	k_num_int_ini = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_ini") //rif ini
	k_num_int_fin = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_fin") //rif fin
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data riferimento da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
	kist_int_artr.lavorazione = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "lavorazione")) //estrae entrate/in lav/tattati
	kist_int_artr.num_bolla_in = tab_1.tabpage_1.dw_1.getitemstring(1, "num_bolla_in") //Bolla mandante
	kist_int_artr.anno_bolla_in = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno_bolla_in") //Bolla mandante
	kist_int_artr.data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini") //data inizio lavorazione
	kist_int_artr.data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin") //data fine lavorazione
	kist_int_artr.data_ini_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini_1") //alla data inizio lavorazione
	kist_int_artr.data_fin_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin_1") //alla data fine lavorazione
	kist_int_artr.dosim_data_i = tab_1.tabpage_1.dw_1.getitemdate(1, "dosim_data_i") //alla data convalida ini
	kist_int_artr.dosim_data_f = tab_1.tabpage_1.dw_1.getitemdate(1, "dosim_data_f") //alla data convalida fin
	kist_int_artr.upd_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "upd_data_fin") //data di importazione
	kist_int_artr.upd_data_ok = tab_1.tabpage_1.dw_1.getitemdate(1, "upd_data_ok") //data di convalida
	kist_int_artr.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") //Mandante
	kist_int_artr.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_2") //Ricev
	kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Fatturato
	kist_int_artr.dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose") //Dose
	kist_int_artr.barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode") //barcode
	kist_int_artr.num_certif = tab_1.tabpage_1.dw_1.getitemnumber(1, "certificato") //num.certificato
	kist_int_artr.certificato_dt_st_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "certificato_dt_st_ini") //data certificato ini
	kist_int_artr.certificato_dt_st_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "certificato_dt_st_fin") //data certificato fin
	kist_int_artr.certificato_st = tab_1.tabpage_1.dw_1.getitemstring(1, "certificato_st") //stato certif.
	kist_int_artr.groupage = tab_1.tabpage_1.dw_1.getitemstring(1, "groupage") //estrae groupage
	kist_int_artr.m_r_f = tab_1.tabpage_1.dw_1.getitemstring(1, "m_r_f") //come estrae la triade
	kist_int_artr.art = tab_1.tabpage_1.dw_1.getitemstring(1, "art") //codice Articolo
	if tab_1.tabpage_1.dw_1.getitemstring(1, "meca_blk")  = "S" then //estrae i NON CONFORMI
		kist_int_artr.meca_blk = true
	else
		kist_int_artr.meca_blk = false 
	end if
	kist_int_artr.id_meca_causale = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca_causale") //causale entrata merce
	
	set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


////--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
//if not isnull(kdw_1.tag) then
//	k_codice_prec = kdw_1.tag
//else
//	k_codice_prec = " "
//end if

//--- acchiappo la dataoggi
k_dataoggi = kguo_g.get_dataoggi()
 

//--- riferimento
if k_num_int_ini > 0 then
else
	k_num_int_ini = 0
end if
if k_num_int_fin > 0 then
else
	k_num_int_fin = k_num_int_ini
end if
if k_data_da > kkg.data_zero then
else
	k_data_da = relativedate(k_dataoggi, -730)
end if
kist_int_artr.data_da = k_data_da
if k_data_a > kkg.data_zero then
else
	k_data_a = k_dataoggi
end if
kist_int_artr.data_a = k_data_a

//--- lavorazione
if isnull(kist_int_artr.lavorazione) then
	kist_int_artr.lavorazione = "*"
else
	if kist_int_artr.lavorazione = "CE" then
		kist_int_artr.err_lav_ok = "1" //errore in convalida
	else
		kist_int_artr.err_lav_ok = "0" //no errore in convalida
	end if
end if
if isnull(kist_int_artr.anno_bolla_in) then
	kist_int_artr.anno_bolla_in = 0
end if
if isnull(kist_int_artr.impianto) then
	kist_int_artr.impianto = 0
end if
if isnull(kist_int_artr.num_bolla_in) then
	kist_int_artr.num_bolla_in = ""
else
	kist_int_artr.num_bolla_in = trim(kist_int_artr.num_bolla_in) 
end if
if kist_int_artr.data_ini > kkg.data_zero then
else
	kist_int_artr.data_ini = date("01/01/1900")
end if
if kist_int_artr.data_ini_1 > kkg.data_zero then
else
	kist_int_artr.data_ini_1 = date("01/01/1900")
end if
if kist_int_artr.data_fin > kkg.data_zero then
else
	kist_int_artr.data_fin = date("01/01/1900")
end if
if kist_int_artr.data_fin_1 > kkg.data_zero then
else
	kist_int_artr.data_fin_1 = date("01/01/1900")
end if
if kist_int_artr.upd_data_fin > kkg.data_zero then
else
	kist_int_artr.upd_data_fin = date('01.01.1900')
end if
if kist_int_artr.upd_data_ok > kkg.data_zero then
else
	kist_int_artr.upd_data_ok = date('01.01.1900')
end if
if isnull(kist_int_artr.m_r_f) or LenA(trim(kist_int_artr.m_r_f)) = 0 then
	kist_int_artr.m_r_f = "0"
end if

//--- convalida dosim
if kist_int_artr.dosim_data_i > kkg.data_zero then
else
	kist_int_artr.dosim_data_i = date("01/01/1900")
end if
if kist_int_artr.dosim_data_f > kkg.data_zero then
else
	kist_int_artr.dosim_data_f = date("01/01/1900")
end if
if isnull(kist_int_artr.err_lav_ok) or LenA(trim(kist_int_artr.err_lav_ok)) = 0 then
	kist_int_artr.err_lav_ok = "0"
end if

//--- clienti
if isnull(kist_int_artr.clie_1) then
	kist_int_artr.clie_1 = 0
end if
if isnull(kist_int_artr.clie_2) then
	kist_int_artr.clie_2 = 0
end if
if isnull(kist_int_artr.clie_3) then
	kist_int_artr.clie_3 = 0
end if

//--- altro + certificato
if isnull(kist_int_artr.dose) then
	kist_int_artr.dose = 0
end if
if isnull(kist_int_artr.barcode) or LenA(trim(kist_int_artr.barcode)) = 0 then
	kist_int_artr.barcode = "*"
end if
if isnull(kist_int_artr.num_certif) then
	kist_int_artr.num_certif = 0
end if
if kist_int_artr.certificato_dt_st_ini > kkg.data_zero then
else
	kist_int_artr.certificato_dt_st_ini = date("01/01/1900")
end if
if kist_int_artr.certificato_dt_st_fin > kkg.data_zero then
else
	kist_int_artr.certificato_dt_st_fin = date("01/01/1900")
end if
if isnull(kist_int_artr.certificato_st) then
	kist_int_artr.certificato_st = "*"
end if
if isnull(kist_int_artr.groupage) then
	kist_int_artr.groupage = "*"
end if
if isnull(kist_int_artr.art) then
	kist_int_artr.art = ""
end if

if isnull(kist_int_artr.id_meca_causale) then kist_int_artr.id_meca_causale = 0

////--- salvo i parametri cosi come sono stati immessi
//kuf1_utility = create kuf_utility
//kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
//destroy kuf1_utility

/////////////////////////////leggi_dwc_barcode(0, kdw_1)

////--- se campi impostati differentemente da prima....
//if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then


//--- ricavo il riferimento di INIZIO
	k_anno=year(k_data_da)
	if k_num_int_ini > 0 then
		
		select min(id)
			 into :kist_int_artr.id_meca_ini
			 from meca
			 where num_int = :k_num_int_ini 
			       and year(data_int) = :k_anno
			 using sqlca;
			 
	else
		if k_data_da > date(0) then
			select min(id)
				 into :kist_int_artr.id_meca_ini
				 from meca
				 where data_int >= :k_data_da and year(data_int) = :k_anno
				 using sqlca;
//--- se non ho trovato niente vedo se c'e' qualcosa nel periodo successivo				 
			if sqlca.sqlcode <> 0 or isnull(kist_int_artr.id_meca_ini) then

				select min(id)
					 into :kist_int_artr.id_meca_ini
					 from meca
					 where data_int >= :k_data_da 
					 using sqlca;

				if sqlca.sqlcode <> 0  or isnull(kist_int_artr.id_meca_ini) then
					kist_int_artr.id_meca_ini=0
				end if
			end if
		else
			kist_int_artr.id_meca_ini=0
		end if	
	end if
	if kist_int_artr.id_meca_ini > 0 then
	else
		kist_int_artr.id_meca_ini = 0
	end if

//--- ricavo il riferimento di FINE
	if k_num_int_ini > 0 and k_num_int_ini = k_num_int_fin then
		kist_int_artr.id_meca_fin = kist_int_artr.id_meca_ini
	else
		
		k_anno=year(k_data_a)
		if k_num_int_fin > 0 then
			select max(id)
				 into :kist_int_artr.id_meca_fin
				 from meca
				 where num_int = :k_num_int_fin 
					and year(data_int) = :k_anno
					and id >= :kist_int_artr.id_meca_ini
				 using sqlca;
			if sqlca.sqlcode <> 0 then
				kist_int_artr.id_meca_fin=0
			end if
		else
			if k_data_a > date(0) then
				select max(id)
					 into :kist_int_artr.id_meca_fin
					 from meca
					 where
					     data_int <= :k_data_a  and id >= :kist_int_artr.id_meca_ini
					 using sqlca;
			else
				kist_int_artr.id_meca_fin=999999999
			end if	
		end if	
	end if
	if kist_int_artr.id_meca_fin > 0 then
	else
		kist_int_artr.id_meca_fin = 0
	end if

//=== Controllo date
	if kist_int_artr.id_meca_ini > 0 and kist_int_artr.id_meca_ini > kist_int_artr.id_meca_fin then
		kGuo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kGuo_exception.setmessage("Filtro intervallo numeri Lotto non congruenti,~n~r numero di fine periodo minore di quello di inizio")
		throw kGuo_exception 
					
	end if

//=== Controllo se ho richiesto di pigliare almeno un'angrafica
	if kist_int_artr.m_r_f = "1" and (kist_int_artr.clie_1 = 0 or kist_int_artr.clie_2 = 0 or kist_int_artr.clie_3 = 0) then
		
		kGuo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kGuo_exception.setmessage("Dati mancanti o incongruenti,~n~r " &
					+ "quando richiesta ~n~r'" + trim(tab_1.tabpage_1.dw_1.describe("m_r_f.CheckBox.Text")) &
					+ "'~n~rimpostare i codici Mandante+Ricevente+Fatturato" &
					+ "'~n~rReimpostare il filtro di estrazione" )
		throw kGuo_exception 

	end if
	

//=== Controllo date
	if ((k_data_a > date(0) and k_data_a < k_data_da) &
	   or kist_int_artr.data_ini_1 < kist_int_artr.data_ini and kist_int_artr.data_ini_1 <> date(0) &
	   or kist_int_artr.data_fin_1 < kist_int_artr.data_fin and kist_int_artr.data_fin_1 <> date(0) &
	   or kist_int_artr.dosim_data_f < kist_int_artr.dosim_data_i and kist_int_artr.dosim_data_f <> date(0) &
	   or (kist_int_artr.certificato_dt_st_fin < kist_int_artr.certificato_dt_st_ini &
		   and kist_int_artr.certificato_dt_st_fin <> date(0))) &
		then
		kGuo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kGuo_exception.setmessage("Filtro intervallo periodo Lotti non congruente,~n~r data di fine periodo minore di quella di inizio")
		throw kGuo_exception 
					
	end if


	if not k_errore then

		if kist_int_artr.id_meca_ini = 0 or isnull(kist_int_artr.id_meca_ini) or kist_int_artr.id_meca_fin = 0 or isnull(kist_int_artr.id_meca_fin) then
			kGuo_exception.setmessage("Parametri Errati, reperimento dei Riferimenti da estrarre fallito.  ")
			throw kGuo_exception 
						
			k_errore = false
			
		end if
	end if
	



end subroutine

private subroutine report_1 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_importa, k_importato_data, k_importato_ora
long  k_key, k_clie_1, k_clie_2, k_riga
int k_err_ins, k_rc=0, k_anno
double k_dose 
date k_data, k_data_da, k_data_a, k_data_ini, k_data_ini_1, k_data_null
date k_certificato_dt_st_fin, k_certificato_dt_st_ini, k_data_fin, k_data_fin_1
string k_rag_soc, k_indirizzo, k_localita
string k_trattamento, k_barcode
string k_codice_attuale, k_codice_prec
datawindowchild   kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3  //kdwc_dose,
datawindowchild   kdwc_cliente_c, kdwc_cliente_2_c, kdwc_cliente_3_C, kdwc_1, kdwc_2
kuf_base kuf1_base


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_1" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_1"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

//	if u_dw_selezione_ripri( ) = 0 then
//		tab_1.tabpage_1.dw_1.insertrow(0)
//	end if
	
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.visible = true
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	k_key = long(trim(ki_st_open_w.key1)) //mandante
	k_trattamento = trim(ki_st_open_w.key2) //F=lavorati; I=in lavorazione; N=ancora da trattare
	k_data_ini = date(trim(ki_st_open_w.key3)) //data inizio lavorazione
	k_data_ini_1 = date(trim(ki_st_open_w.key4)) //alla data inizio lavorazione
	k_clie_1 = long(trim(ki_st_open_w.key5)) //Mandante
	k_clie_2 = long(trim(ki_st_open_w.key6)) //Ricevente
	k_dose = double(trim(ki_st_open_w.key7))
	k_data_da = date(trim(ki_st_open_w.key8)) //data riferimento da
	k_data_a = date(trim(ki_st_open_w.key9)) //data riferimento a
	k_data_fin = date(0)
	k_data_fin_1 = date(0)
	k_certificato_dt_st_fin = date(0)
	k_certificato_dt_st_ini = date(0)
	if k_key > 0 then  //disabilito l'importazione poichè ho una estr.personalizzata
		k_importa = "N"
	end if
//	k_anno = integer(mid(st_parametri.text, 13, 4))

	tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
	tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente_2)
	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente_3)
	tab_1.tabpage_1.dw_1.getchild("clie_1_1", kdwc_cliente_c)
	tab_1.tabpage_1.dw_1.getchild("clie_2_1", kdwc_cliente_2_c)
	tab_1.tabpage_1.dw_1.getchild("clie_3_1", kdwc_cliente_3_c)
//	tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)


	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_2.settransobject(sqlca)
	kdwc_cliente_3.settransobject(sqlca)
	kdwc_cliente_c.settransobject(sqlca)
	kdwc_cliente_2_C.settransobject(sqlca)
	kdwc_cliente_3_c.settransobject(sqlca)
//	kdwc_dose.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		kdwc_cliente.retrieve("%")
		kdwc_cliente_2.retrieve("%")
		kdwc_cliente.insertrow(1)
		kdwc_cliente.sharedata(kdwc_cliente_2)
		kdwc_cliente.sharedata(kdwc_cliente_3)
		kdwc_cliente.sharedata(kdwc_cliente_c)
		kdwc_cliente.sharedata(kdwc_cliente_2_c)
		kdwc_cliente.sharedata(kdwc_cliente_3_c)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_2, 1, Primary!)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_3, 1, Primary!)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_c, 1, Primary!)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_2_c, 1, Primary!)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_3_c, 1, Primary!)


		tab_1.tabpage_1.dw_1.getchild("id_meca_causale", kdwc_1)
		tab_1.tabpage_1.dw_1.getchild("id_meca_causale_1", kdwc_2)
		kdwc_1.settransobject(sqlca)
		kdwc_1.retrieve()
		kdwc_1.insertrow(1)
		kdwc_1.sharedata(kdwc_2)
		
	end if
	

//		tab_1.tabpage_1.dw_1.setcolumn(1)
	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default
//	if ki_st_open_w.flag_primo_giro = 'S' then


		if tab_1.tabpage_1.dw_1.rowcount() = 0 then

			if k_importa <> "N" or isnull(k_importa) then
				importa_dati_da_ultima_exit()
			end if

			if tab_1.tabpage_1.dw_1.rowcount() > 1 then
				tab_1.tabpage_1.dw_1.reset()
			end if

			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				tab_1.tabpage_1.dw_1.insertrow(0)
			end if

			if k_clie_1 > 0 then
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.insertrow(0)
//					k_riga=kdwc_cliente.find("codice = "+string(k_clie_1),&
//											0, kdwc_cliente.rowcount())
//					if k_riga > 0 then
//						tab_1.tabpage_1.dw_1.setitem(1, "clie_1", &
//										kdwc_cliente.getitemnumber(k_riga, "codice"))
//					end if
				end if
			end if
			
			if k_clie_2 > 0 then
				if kdwc_cliente_2.rowcount() < 2 then
					kdwc_cliente_2.insertrow(0)
//					k_riga=kdwc_cliente_2.find("codice = "+string(k_clie_2),&
//											0, kdwc_cliente_2.rowcount())
//					if k_riga > 0 then
//						tab_1.tabpage_1.dw_1.setitem(1, "clie_2", &
//										kdwc_cliente_2.getitemnumber(k_riga, "codice"))
//					end if
				end if
			end if
			
//			if k_dose > 0 then
//				tab_1.tabpage_1.dw_1.setitem(1, "dose", k_dose) //&
//			end if	

			
//---- data ultima impotrtazione dei barcode x data fine lavorazione
			kuf1_base = create kuf_base
			k_importato_data  = mid(kuf1_base.prendi_dato_base( "data_ultima_estrazione_pilota_out"),2)
			if not isdate(k_importato_data) then
				k_importato_data = "** DATA ERRATA ** " 
			end if
			k_importato_ora  = mid(kuf1_base.prendi_dato_base( "ora_ultima_estrazione_pilota_out"),2)
			if not istime(k_importato_ora) then
				k_importato_ora = "** ORA ERRATA ** " 
			end if
			destroy kuf1_base

			try	
	//--- imposto l'utente (il "terminale") x costruire il nome della view
				set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
				tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
				
				tab_1.tabpage_1.dw_1.setitem(1, "report", 1)
//				tab_1.tabpage_1.dw_1.setitem(1, "impianto", 2)
//				tab_1.tabpage_1.dw_1.setitem(1, "lavorazione", "*")
//				tab_1.tabpage_1.dw_1.setitem(1, "certificato_st", "*")
//				tab_1.tabpage_1.dw_1.setitem(1, "groupage", "*")
//				tab_1.tabpage_1.dw_1.setitem(1, "barcode", "")
//				tab_1.tabpage_1.dw_1.setitem(1, "certificato", 0)
//				tab_1.tabpage_1.dw_1.setitem(1, "num_bolla_in", 0)
//				tab_1.tabpage_1.dw_1.setitem(1, "anno_bolla_in", 0)
		//--- prendi data oggi		
				k_data = kguo_g.get_dataoggi( )
				if isnull(k_data_da) or k_data_da = date(0) then
					k_data_da = relativedate(k_data, -120)
				end if
				if isnull(k_data_a) or k_data_a = date(0) then
					k_data_a = k_data
				end if
				if k_data_da = date(0) then
					tab_1.tabpage_1.dw_1.setitem(1, "data_da", "00/00/00")
				else
					tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
				end if
				if k_data_a = date(0) then
					tab_1.tabpage_1.dw_1.setitem(1, "data_a", "00/00/00")
				else
					tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
				end if
				if isnull(k_data_ini) then
					k_data_ini = date(0)
				end if

				tab_1.tabpage_1.dw_1.setitem(1, "data_ultima_estrazione_pilota_out", k_importato_data + "  " +k_importato_ora)

//				if k_data_ini = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "data_ini", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "data_ini", k_data_ini)
//				end if
//				if isnull(k_data_ini_1) then
//					k_data_ini_1 = date(0)
//				end if
//				if k_data_ini_1 = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "data_ini_1", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "data_ini_1", k_data_ini_1)
//				end if
//				if k_data_fin = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "data_fin", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "data_fin", k_data_fin)
//				end if
//				if isnull(k_data_ini_1) then
//					k_data_ini_1 = date(0)
//				end if
//				if k_data_fin_1 = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "data_fin_1", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "data_fin_1", k_data_fin_1)
//				end if
//				if k_certificato_dt_st_ini = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "certificato_dt_st_ini", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "certificato_dt_st_ini", k_certificato_dt_st_ini)
//				end if
//				if k_certificato_dt_st_fin = date(0) then
//					tab_1.tabpage_1.dw_1.setitem(1, "certificato_dt_st_fin", "00/00/00")
//				else
//					tab_1.tabpage_1.dw_1.setitem(1, "certificato_dt_st_fin", k_certificato_dt_st_fin)
//				end if
//							
//				tab_1.tabpage_1.dw_1.setitem(1, "dosim_data_i", "00/00/00")
//				tab_1.tabpage_1.dw_1.setitem(1, "dosim_data_f", "00/00/00")
//				tab_1.tabpage_1.dw_1.setitem(1, "err_lav_ok", "0")
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			end try
		end if
	end if
				
	attiva_tasti()
		
//return "0"

	



end subroutine

private subroutine report_2 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_importa


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_2" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_2"
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	
	tab_1.tabpage_1.dw_1.visible = true

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
	
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		tab_1.tabpage_1.dw_1.setfocus()
	
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private function long report_2_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT PROGRAMMAZIONE PILOTA
//
string k_scelta, k_codice_prec
long k_righe
datastore kds_1
kuf_utility kuf1_utility
	
try

	k_scelta = trim(ki_st_open_w.flag_modalita)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(kdw_1.tag) then
		k_codice_prec = kdw_1.tag
	else
		k_codice_prec = " "
	end if
	
//--- salvo i parametri cosi come sono stati immessi
	kuf1_utility = create kuf_utility
	kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility

	if trim(k_codice_prec) <> trim(kdw_1.tag) then
		u_set_tabpage_picture(true)
	else
		u_set_tabpage_picture(false)
	end if
	 
	if kdw_1.rowcount() = 0 or trim(k_codice_prec) =  "" then //<> k_codice_prec then

		setpointer(kkg.pointer_attesa)
		kdw_1.visible = false
		
		if not isvalid(kiuf_report_pilota) then kiuf_report_pilota = create kuf_report_pilota
		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni

		kds_1 = kiuf_pilota_previsioni.get_ds_barcode_queue_prev( ) 
		if kds_1.rowcount() > 0 then
		
			kiuf_report_pilota.set_ds_report_2_pilota_queue_prev(kds_1)

			kdw_1.dataobject = kds_1.dataobject
			kdw_1.visible = true
			kds_1.rowscopy(1, kds_1.rowcount(), primary!, kdw_1, 1, primary!)
		
			k_righe = kdw_1.rowcount()
			
		end if

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
//	kuo_exception.messaggio_utente()

finally
	attiva_tasti()
	if kdw_1.rowcount() = 0 then
		kdw_1.insertrow(0) 
	end if
	kdw_1.setfocus()
	setpointer(kkg.pointer_default)

end try
	

return k_righe





end function

protected subroutine stampa ();//
//=== stampa dw
long k_righe
string k_errore, k_titolo=" "
//w_g_tab kwindow_1
st_stampe kst_stampe



	choose case tab_1.selectedtab 
					
		case 1 
			k_titolo = tab_1.tabpage_1.text
			kst_stampe.dw_print =  tab_1.tabpage_1.dw_1
		case else
			kst_stampe.dw_print = kidw_selezionata
			
			choose case u_report_selezionato()
				case ki_scelta_report_lotti_entrati
					k_titolo = "Lotti entrati "
//--- copia la stampa in un dw fatto apposta x l'esportazione
					if kist_int_artr.flag_report = 1 then  // report con la conta dei giri
						kst_stampe.ds_esporta = create datastore
						kst_stampe.ds_esporta.dataobject = "d_report_7_con_giri_esporta" 
						k_righe = kidw_selezionata.rowscopy( 1, kidw_selezionata.rowcount( ) , primary!, kst_stampe.ds_esporta, 1, Primary!)
						//kst_stampe.dw_esporta = dw_appo
//						destroy kst_stampe.dw_print
//						kst_stampe.dw_print = create datawindow
//						kst_stampe.dw_print.dataobject = "d_report_7_con_giri_esporta" 
//						k_righe = kidw_selezionata.rowscopy( 1, kidw_selezionata.rowcount( ) , primary!, kst_stampe.dw_print, 1, Primary!)
					end if
				case ki_scelta_report_generico
					k_titolo = "Interrogazione Generica "
				case ki_scelta_report_coda_pilota
					k_titolo = "Programmazione Impianto "
				case ki_scelta_report_in_trattamento
					k_titolo = "Materiale in Trattamento "
				case ki_scelta_report_trattato
					k_titolo = "Materiale Trattato "
				case ki_scelta_report_lotti_in_giacenza
					k_titolo = "Lotti in giacenza a magazzino "
				case else
					k_titolo = "Stampa " + trim(u_report_selezionato_title())
					
			end choose

	end choose	

	if kst_stampe.dw_print.rowcount() > 0 then

		kst_stampe.titolo = trim(k_titolo) 

		k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))

	end if
	
	

end subroutine

private subroutine report_3 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_3" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_3"
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default
//	if ki_st_open_w.flag_primo_giro = 'S' then

			

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
	
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

//	end if
				
attiva_tasti()
		

	



end subroutine

private function long report_3_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
// (REPORT LOTTI IN PROGRAMMAZIONE PILOTA)
//
string k_scelta, k_codice_prec
long k_righe=0, k_rc
date k_data
//datawindowchild kdwc_barcode
kuf_utility kuf1_utility
datastore kds_1 

	
	try
	
	k_scelta = trim(ki_st_open_w.flag_modalita)


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(kdw_1.tag) then
		k_codice_prec = kdw_1.tag
	else
		k_codice_prec = " "
	end if

//--- salvo i parametri cosi come sono stati immessi
	kuf1_utility = create kuf_utility
	kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility

	if trim(k_codice_prec) <> trim(kdw_1.tag) then
		u_set_tabpage_picture(true)
	else
		u_set_tabpage_picture(false)
	end if
	

	if kdw_1.rowcount() = 0 or trim(k_codice_prec) =  "" then //<> k_codice_prec then

		if not isvalid(kiuf_report_pilota) then kiuf_report_pilota = create kuf_report_pilota
		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni
		
		kds_1 = kiuf_pilota_previsioni.get_ds_barcode_in_lav_prev( ) 
		if kds_1.rowcount() > 0 then
		
			kiuf_report_pilota.set_ds_report_3_pilota_pallet_in_lav(kds_1)

			kdw_1.dataobject = kds_1.dataobject // "d_report_3_pilota_pallet_in_lav" 
			kdw_1.visible = true
			kds_1.rowscopy(1, kds_1.rowcount(), primary!, kdw_1, 1, primary!)
			
			k_righe = kdw_1.rowcount()
		end if
		
	end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
//		kuo_exception.messaggio_utente()

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		

return k_righe
	

end function

private subroutine report_4 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_4" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_4"
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default
//	if ki_st_open_w.flag_primo_giro = 'S' then

			

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
	
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

//	end if
				
attiva_tasti()
		

	



end subroutine

private function long report_4_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT PROGRAMMAZIONE PILOTA
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc, k_riga=0, k_colli=0, k_colli_tr=0
date k_data
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca, kst_tab_meca_app
st_tab_clienti kst_tab_clienti

	
	try
	
	k_scelta = trim(ki_st_open_w.flag_modalita)


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(kdw_1.tag) then
		k_codice_prec = kdw_1.tag
	else
		k_codice_prec = " "
	end if

//--- salvo i parametri cosi come sono stati immessi
	kuf1_utility = create kuf_utility
	kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility

	if trim(k_codice_prec) <> trim(kdw_1.tag) then
		u_set_tabpage_picture(true)
	else
		u_set_tabpage_picture(false)
	end if
	

	if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

		kdw_1.visible = true
//		kguo_sqlca_db_pilota.db_connetti()
		kdw_1.dataobject = "d_report_4_pilota_pallet_trattati" 
//		k_rc = kdw_1.settransobject(kguo_sqlca_db_pilota)
		k_rc = kdw_1.settrans(kguo_sqlca_db_pilota)  // conn/disconn in automatico ad ogni operaz

		k_righe = kdw_1.retrieve(date(0))

		for k_riga = 1 to k_righe

			kst_tab_barcode.barcode = kdw_1.object.barcode[k_riga]
			select distinct
					barcode.id_meca
				into
					:kst_tab_meca.id
				from barcode
				where barcode.barcode = :kst_tab_barcode.barcode 
				using sqlca;

			if kst_tab_meca.id <> kst_tab_meca_app.id then
				kst_tab_meca_app.id = kst_tab_meca.id
			
			
				select distinct
						meca.clie_2
						,meca.id
						,meca.num_int
						,meca.data_int
						,meca.area_mag
						,meca.consegna_data
						,clienti.rag_soc_10
					into
						:kst_tab_meca.clie_2
						,:kst_tab_meca.id
						,:kst_tab_meca.num_int
						,:kst_tab_meca.data_int
						,:kst_tab_meca.area_mag
						,:kst_tab_meca.consegna_data
						,:kst_tab_clienti.rag_soc_10
					from 
					  (barcode
						inner join meca on
						 barcode.id_meca = meca.id)
					 inner join clienti on
						 meca.clie_2 = clienti.codice 
					where barcode.barcode = :kst_tab_barcode.barcode 
					using sqlca;
		
				if sqlca.sqlcode = 0 then
					select count(*)
						into :k_colli
						from barcode
						where barcode.id_meca = :kst_tab_meca.id
						using sqlca;
					if isnull(k_colli) then k_colli = 0
					select count(*)
						into :k_colli_tr
						from barcode
						where barcode.id_meca = :kst_tab_meca.id and barcode.data_lav_fin > convert(date,'01.01.1899')
						using sqlca;
					if isnull(k_colli_tr) then k_colli_tr = 0
				end if
			end if

			if kst_tab_meca.id > 0 then
				if not isnull(kst_tab_meca.clie_2) then
					kdw_1.object.k_clie_2[k_riga] = kst_tab_meca.clie_2
				end if
				if not isnull(kst_tab_meca.id) then
					kdw_1.object.id_meca[k_riga] = kst_tab_meca.id
				end if
				if not isnull(kst_tab_meca.num_int) then
					kdw_1.object.num_int[k_riga] = kst_tab_meca.num_int
				end if
				if not isnull(kst_tab_meca.data_int) then
					kdw_1.object.data_int[k_riga] = kst_tab_meca.data_int
				end if
				if not isnull(kst_tab_meca.consegna_data) then
					kdw_1.object.k_consegna_data[k_riga] = kst_tab_meca.consegna_data
				end if
				if not isnull(kst_tab_clienti.rag_soc_10) then
					kdw_1.object.k_rag_soc_10[k_riga] = kst_tab_clienti.rag_soc_10
				end if
				kdw_1.object.k_colli[k_riga] = trim(string(k_colli_tr)) + " . " + trim(string(k_colli)) 
			end if
			
		end for
	end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
//		kuo_exception.messaggio_utente()

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		

return k_righe
	

end function

protected function integer inserisci ();//
int k_return	= 0
	
	
	tab_1.selectedtab = 1

return k_return 


end function

private subroutine report_5 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente
date k_data, k_data_da, k_data_a
//kuf_base kuf1_base


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_5" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_5"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)

		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
		kdwc_cliente.settransobject(sqlca)
		kdwc_cliente.retrieve("%")

		if isnull(k_data_da) or k_data_da = date(0) then
		//--- prendi data oggi		
			k_data = kguo_g.get_dataoggi( )
			k_data_da = date(year(relativedate(k_data, -25)),month(relativedate(k_data, -25)),01)
			if isnull(k_data_a) or k_data_a = date(0) then
				k_data_a = relativedate(date(year(relativedate(k_data_da, 32)), month(relativedate(k_data_da, 32)),01),-1)
			end if
			if k_data_da = date(0) then
				tab_1.tabpage_1.dw_1.setitem(1, "data_da", "00/00/00")
			else
				tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
			end if
			if k_data_a = date(0) then
				tab_1.tabpage_1.dw_1.setitem(1, "data_a", "00/00/00")
			else
				tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
			end if
		end if

			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine get_id_meca (ref st_tab_meca kst_tab_meca_da, ref st_tab_meca kst_tab_meca_a) throws uo_exception;//
//--- ricava il range id_meca da un range numero/data
//
date k_data_ufo
st_esito kst_esito
uo_exception kuo_exception


//--- ricavo i numeri diferineto da--a-- esatti
	if kst_tab_meca_da.num_int = 0 and kst_tab_meca_da.data_int > date(0) then
		if year(kst_tab_meca_da.data_int) = year(kst_tab_meca_a.data_int) then
			select min(id), max(id)
				 into 
                         :kst_tab_meca_da.id 
					   ,:kst_tab_meca_a.id
				 from meca
				 where data_int between :kst_tab_meca_da.data_int and :kst_tab_meca_a.data_int
				 using sqlca;
		else
			k_data_ufo = date('31.12.' + string(kst_tab_meca_da.data_int, "yyyy"))
			select  min(id)
				 into :kst_tab_meca_da.id 
				 from meca
				 where data_int between :kst_tab_meca_da.data_int  and :k_data_ufo
				 using sqlca;
			k_data_ufo = date('01.01.' + string(kst_tab_meca_a.data_int, "yyyy"))
			select max(id)
				 into  :kst_tab_meca_a.id
				 from meca
				 where data_int between :k_data_ufo and :kst_tab_meca_a.data_int
				 using sqlca;
		end if
		
	end if
	
//--- ricava il  ID  MECA
	if sqlca.sqlcode >= 0 and kst_tab_meca_da.id = 0 then
		if year(kst_tab_meca_da.data_int) = year(kst_tab_meca_a.data_int) then
			select min(id), max(id)
				 into :kst_tab_meca_da.id, :kst_tab_meca_a.id
				 from meca
				 where data_int between :kst_tab_meca_da.data_int and :kst_tab_meca_a.data_int
				 using sqlca;
		else
			k_data_ufo = date('31.12.' + string(kst_tab_meca_da.data_int, "yyyy"))
			select min(id)
				 into :kst_tab_meca_da.id
				 from meca
				 where num_int >= :kst_tab_meca_da.id and data_int between :kst_tab_meca_da.data_int and :k_data_ufo
				 using sqlca;
			k_data_ufo = date('01.01.' + string(kst_tab_meca_a.data_int, "yyyy"))
			select max(id)
				 into :kst_tab_meca_a.id
				 from meca
				 where num_int <= :kst_tab_meca_a.id and data_int between :k_data_ufo and :kst_tab_meca_a.data_int
				 using sqlca;
		end if
	end if

	if sqlca.sqlcode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Lettura Id Riferimento (MECA):" + trim(sqlca.SQLErrText)
		kst_esito.nome_oggetto = this.classname()
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
				
	end if

end subroutine

private subroutine report_6 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente
date k_data, k_data_da, k_data_a


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_6" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_6"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


//--- prendi data oggi		
		k_data = kguo_g.get_dataoggi( )
//			k_data_a = relativedate(date(year(relativedate(k_data, -25)),month(relativedate(k_data, -25)),01), - 1)
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)	
		tab_1.tabpage_1.dw_1.setitem(1, "periodo", 91)	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private function long report_6_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
			
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_6_lotti_in_mag" 
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_6()
	
	//--- view x estrazione 
			crea_view_x_report_6()
		
			leggi_dwc_barcode(0, kdw_1)
		
	//--- Aggiorna SQL della dw	
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_report_6"
			k_string = "vx_MAST2_report_6"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 
		
				
			k_rc = kdw_1.settransobject ( sqlca )
			k_righe = kdw_1.retrieve()

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
//			kuo_exception.messaggio_utente()

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe


end function

private subroutine get_parametri_6 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_dataoggi
long k_data_da_gg, k_anno
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- acchiappo la dataoggi
k_dataoggi = kg_dataoggi


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
	k_data_a = k_dataoggi
end if
kist_int_artr.data_a = k_data_a

k_data_da_gg = tab_1.tabpage_1.dw_1.getitemnumber(1, "periodo") //num. giorni indietro 
if isnull(k_data_da_gg) or k_data_da_gg = 0 then
	k_data_da_gg = 90
end if
kist_int_artr.data_da = relativedate(kist_int_artr.data_a, - k_data_da_gg)

kist_int_artr.no_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "no_dose") //flag se dose esclusa o meno
if isnull(kist_int_artr.no_dose) then
	kist_int_artr.no_dose = 0
end if




end subroutine

private subroutine crea_view_x_report_6 ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
date k_data_int_da, k_data_int_a
string k_data_ent_dax, k_data_ent_ax
kuf_utility kuf1_utility
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


	
	k_data_int_da = relativedate(kist_int_artr.data_da, -180)
	k_data_int_a = relativedate(kist_int_artr.data_da, 30)
	k_data_ent_dax = string(datetime(kist_int_artr.data_da)) + " " + string(time(0))  //YEAR TO SECOND "  1998-01-02 00:00:00.000
	k_data_ent_ax =  string(datetime(kist_int_artr.data_a, time(23,59,59)))  //YEAR TO SECOND "

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_6 "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, colli_spediti ) AS   " 
	 
	k_sql += &
		+ " SELECT  armo.id_armo,  sum(arsp.colli)  FROM " &
		+ " meca  " 
		k_sql += &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " left outer JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " and (arsp.data_bolla_out <= '" + string(kist_int_artr.data_a) + "' or arsp.data_bolla_out is null)" &
			+ " WHERE  " &
			+ " meca.data_int between '" + string(k_data_int_da) + "' and '" + string(k_data_int_a) + "' "  &
		   + " and meca.data_ent between '"  + k_data_ent_dax + "' and '" + k_data_ent_ax + "'  "     &
			+ " and (meca.aperto <> '" + string(kuf1_armo.kki_meca_aperto_annullato ) + "') "
		if kist_int_artr.no_dose = 1 then
			k_sql += &
				 " and armo.dose > 0 " 
		end if

		k_sql += &
	 			" group by armo.id_armo " 
			
//	 			+ " inner JOIN sped " &
//			+ " ON arsp.num_bolla_out = sped.num_bolla_out " &
//			+ " and arsp.data_bolla_out = sped.data_bolla_out " &
//			+ " and sped.data_uscita > '01.01.1990' " &
//
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

private subroutine report_7 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_importa, k_importato, k_importato_ora
date k_data, k_data_da, k_data_a
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente_3  //kdwc_dose,
datawindowchild   kdwc_cliente_3_C
kuf_base kuf1_base


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_7" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_7"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	//tab_1.tabpage_1.dw_1.reset()
	//tab_1.tabpage_1.dw_1.visible = true

//	if u_dw_selezione_ripri( ) = 0 then
//		tab_1.tabpage_1.dw_1.insertrow(0)
//	end if

	k_scelta = trim(ki_st_open_w.flag_modalita)
	k_data_da = date(trim(ki_st_open_w.key8)) //data riferimento da
	k_data_a = date(trim(ki_st_open_w.key9)) //data riferimento a
	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente_3)
	tab_1.tabpage_1.dw_1.getchild("clie_3_1", kdwc_cliente_3_c)

	kdwc_cliente_3.settransobject(sqlca)
	kdwc_cliente_3_c.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		kdwc_cliente_3.retrieve("%")
		kdwc_cliente_3.insertrow(1)
		kdwc_cliente_3.RowsCopy(1, kdwc_cliente_3.RowCount(), Primary!, kdwc_cliente_3_c, 1, Primary!)

	end if
	
	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

		if tab_1.tabpage_1.dw_1.rowcount() = 0 then

			if k_importa <> "N" or isnull(k_importa) then
				importa_dati_da_ultima_exit()
			end if

			if tab_1.tabpage_1.dw_1.rowcount() > 1 then
				tab_1.tabpage_1.dw_1.reset()
			end if

			if tab_1.tabpage_1.dw_1.rowcount() = 0 then
				tab_1.tabpage_1.dw_1.insertrow(0)
			end if
			
			if k_clie_3 > 0 then
				if kdwc_cliente_3.rowcount() < 2 then
					kdwc_cliente_3.insertrow(0)
//					k_riga=kdwc_cliente_3.find("codice = "+string(k_clie_3),&
//											0, kdwc_cliente_3.rowcount())
//					if k_riga > 0 then
//						tab_1.tabpage_1.dw_1.setitem(1, "clie_3", &
//										kdwc_cliente_3.getitemnumber(k_riga, "codice"))
//					end if
				end if
			end if

//---- data ultima impotrtazione dei barcode x data fine lavorazione
			kuf1_base = create kuf_base
			k_importato  = mid(kuf1_base.prendi_dato_base( "data_ultima_estrazione_pilota_out"),2)
			if not isdate(k_importato) then
				k_importato = "** DATA ERRATA ** " 
			end if
			k_importato_ora  = mid(kuf1_base.prendi_dato_base( "ora_ultima_estrazione_pilota_out"),2)
			if not istime(k_importato_ora) then
				k_importato_ora = "** ORA ERRATA ** " 
			end if
			destroy kuf1_base

			try	
	//--- imposto l'utente (il "terminale") x costruire il nome della view
				set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
				tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
				
				tab_1.tabpage_1.dw_1.setitem(1, "report", 1)
//--- prendi data oggi		
				k_data = kguo_g.get_dataoggi( )

				tab_1.tabpage_1.dw_1.setitem(1, "num_int", 0)

				kist_int_artr.anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno")
				if kist_int_artr.anno = 0 or isnull(kist_int_artr.anno ) then
					tab_1.tabpage_1.dw_1.setitem(1, "anno", year(kg_dataoggi))
				end if
				
				if isnull(k_data_da) or k_data_da = date(0) then
					if month(k_data) = 1 then
						k_data_da = date(year(k_data), 01, 01)
					else
						k_data_da = date(year(k_data), month(k_data), 01) //relativedate(k_data, -120)
					end if
				end if
				if isnull(k_data_a) or k_data_a = date(0) then
					k_data_a = k_data
				end if
				if k_data_da = date(0) then
					tab_1.tabpage_1.dw_1.setitem(1, "data_da", "00/00/00")
				else
					tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
				end if
				if k_data_a = date(0) then
					tab_1.tabpage_1.dw_1.setitem(1, "data_a", "00/00/00")
				else
					tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
				end if
				tab_1.tabpage_1.dw_1.setitem(1, "data_ultima_estrazione_pilota_out", k_importato + "  " +k_importato_ora)
				
			catch (uo_exception kuo_exception)
				kuo_exception.messaggio_utente()
				
			end try
		end if
	end if
				
	attiva_tasti()
		
//return "0"

	



end subroutine

private function long report_7_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//string k_scelta
string k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
				
//		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if kdw_1.rowcount() = 0 or trim(k_codice_prec) =  "" then //<> k_codice_prec then

	//--- piglia i parametri per l'estrazione 
			get_parametri_7()

			choose case kist_int_artr.flag_report
				case 1
					kdw_1.dataobject = "d_report_7_con_giri" 
				case 2
					kdw_1.dataobject = "d_report_7_riep_mens" 
				case 3
					kdw_1.dataobject = "d_report_7_dosim" 
				case else
					kdw_1.dataobject = "d_report_7_lotti" 
			end choose
			k_rc = kdw_1.settransobject(sqlca)
			kdw_1.visible = true
	
	//--- view x estrazione 
			crea_view_x_report_7()

	//--- Aggiorna SQL della dw	
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_report_7"
			k_string = "vx_MAST2_report_7"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 
		
			k_rc = kdw_1.settransobject ( sqlca )
			k_righe = kdw_1.retrieve()

		end if


	catch (uo_exception kuo_exception)
		throw kuo_exception
		//kuo_exception.messaggio_utente()


	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe
	

end function

private subroutine get_parametri_7 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_data_da, k_dataoggi
time k_time
kuf_armo kuf1_armo
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca_da, kst_tab_meca_a
st_esito kst_esito
pointer kpointer  // Declares a pointer variable


try

	//=== Puntatore Cursore da attesa.....
	//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
	kpointer = SetPointer(HourGlass!)
	
	k_dataoggi = kg_dataoggi

	kuf1_armo = create kuf_armo

	kist_int_artr.id_meca_ini = 0
	kist_int_artr.id_meca_fin = 0
	k_data_a = date(0)
	
	//--- piglia param dalla window
	kist_int_artr.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int") //num riferimento 
	if isnull(kist_int_artr.num_int)  then
		kist_int_artr.num_int = 0
	end if
	kist_int_artr.anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno") //anno riferimento 
	if isnull(kist_int_artr.anno) then
		kist_int_artr.anno = year(kg_dataoggi)
	end if
	kist_int_artr.id_meca_ini = 0
	if kist_int_artr.num_int > 0 then
		kst_tab_armo.num_int = kist_int_artr.num_int
		kst_tab_armo.data_int = date(kist_int_artr.anno,01,01)
		kst_esito=kuf1_armo.get_id_meca(kst_tab_armo)
	//=== Controllo esito riferimento
		if kst_esito.esito <> kkg_esito.ok then
			kGuo_exception.setmessage("Riferimento non in archivio!")
			throw kGuo_exception 
		end if
		
		if kst_tab_armo.id_meca > 0 then
			kist_int_artr.id_meca_ini = kst_tab_armo.id_meca 
		end if
		
	else
	
		kist_int_artr.non_entrati = tab_1.tabpage_1.dw_1.getitemstring(1, "non_entrati") //Senza data di entrata
	
		if kist_int_artr.non_entrati = "S" then
		else
			k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data entrata riferimento a
			if isnull(k_data_da) or k_data_da = date(0) or k_data_da = date("01/01/1900") or k_data_da = date("00/00/0000") then
				k_data_da = k_dataoggi
			end if
			kist_int_artr.data_da = k_data_da
		
			k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data entrata riferimento da
			if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
				k_data_a = k_dataoggi
			end if
			kist_int_artr.data_a = k_data_a
			
			if k_data_a >= k_data_da then
	//--- get del range ID meca dal periodo impostato	
				kst_tab_meca_da.data_ent = datetime(k_data_da, time('01:01:01.000001'))
				k_time = time('23:59:59.000000')
				kst_tab_meca_a.data_ent = datetime(k_data_a, k_time)
				kuf1_armo.get_id_meca_min_max_x_data_ent(kst_tab_meca_da, kst_tab_meca_a)
				kist_int_artr.id_meca_ini = kst_tab_meca_da.id
				kist_int_artr.id_meca_fin = kst_tab_meca_a.id
			end if
		end if
		
	end if
	
	kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Fatturato
	if isnull(kist_int_artr.clie_3) then
		kist_int_artr.clie_3 = 0
	end if
	
	kist_int_artr.gru = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo") //codice gruppo
	if isnull(kist_int_artr.gru) then
		kist_int_artr.gru = 0
	end if
	kist_int_artr.gru_flag = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_flag") //flag tipo estrazione gruppo
	if isnull(kist_int_artr.gru_flag) then
		kist_int_artr.gru_flag = 2
	end if
	kist_int_artr.gru_attiva = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_attiva") //flag attiva/disattiva estrazione gruppo
	if isnull(kist_int_artr.gru_attiva) then
		kist_int_artr.gru_attiva = 0
	end if
	
	kist_int_artr.flag_report = tab_1.tabpage_1.dw_1.getitemnumber(1, "flag_report") //sceglie varie tipopolie di Report 0=normale
	if isnull(kist_int_artr.flag_report) then
		kist_int_artr.flag_report = 0
	end if
	
	set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	
	
	//=== Controllo date
	if (k_data_a > date(0) and k_data_a < k_data_da) then
		kGuo_exception.inizializza( )
		kGuo_exception.set_tipo(kGuo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kGuo_exception.setmessage("Controlla le date immesse,~n~r data di fine periodo e' minore di quella di inizio")
		throw kGuo_exception 
	else
		if	kist_int_artr.id_meca_ini > 0 then
		else
			kGuo_exception.inizializza( )
			kGuo_exception.set_tipo(kGuo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
			kGuo_exception.setmessage("Nessun Lotto trovato per il periodo richiesto")
			throw kGuo_exception 
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try



end subroutine

private subroutine report_8 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente
date k_data, k_data_da, k_data_a


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_8" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_8"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


//--- prendi data oggi		
		k_data = kguo_g.get_dataoggi( )
//			k_data_a = relativedate(date(year(relativedate(k_data, -25)),month(relativedate(k_data, -25)),01), - 1)
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)	
		tab_1.tabpage_1.dw_1.setitem(1, "periodo", 5)	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine get_parametri_8 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_dataoggi
long k_data_da_gg, k_anno
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- acchiappo la dataoggi
k_dataoggi = kg_dataoggi


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data da cui far partire la ricerca (normalmente la data di oggi)
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
	k_data_a = k_dataoggi
end if
kist_int_artr.data_a = k_data_a

k_data_da_gg = tab_1.tabpage_1.dw_1.getitemnumber(1, "periodo") //num. giorni di max giacenza x un lotto gia' certificato 
if isnull(k_data_da_gg)  then
	k_data_da_gg = 5
end if
kist_int_artr.data_da = relativedate(kist_int_artr.data_a, - k_data_da_gg)

kist_int_artr.no_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "no_dose") //flag se dose esclusa o meno
if isnull(kist_int_artr.no_dose) then
	kist_int_artr.no_dose = 0
end if




end subroutine

private subroutine crea_view_x_report_8 ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_8 "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, colli_spediti ) AS   " 
	 
	k_sql += &
		+ " SELECT  armo.id_armo,  sum(arsp.colli)  FROM " &
		+ " certif  " 
		k_sql += &
			+ " inner JOIN meca " &
			+ " ON certif.id_meca = meca.id " &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " left outer JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " and (arsp.data_bolla_out <= '" + string(kist_int_artr.data_a) + "' or arsp.data_bolla_out is null)" &
			+ " WHERE  " &
			+ " certif.data between '" + string(relativedate(kist_int_artr.data_da, -270)) + "' and' " + string(kist_int_artr.data_da) + "' "  
		if kist_int_artr.no_dose = 1 then
			k_sql += &
				 " and armo.dose > 0 " 
		end if

		k_sql += &
	 			" group by armo.id_armo " 
			
//	 			+ " inner JOIN sped " &
//			+ " ON arsp.num_bolla_out = sped.num_bolla_out " &
//			+ " and arsp.data_bolla_out = sped.data_bolla_out " &
//			+ " and sped.data_uscita > '01.01.1990' " &
//
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected subroutine open_start_window ();//---
kiuf_utility = create kuf_utility

this.tab_1.tabpage_1.ddplb_report.event u_constructor( )

//tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\edit16.gif" 
tab_1.tabpage_2.text = "Report ?"
tab_1.tabpage_2.picturename = "VCRNext!"

end subroutine

private subroutine report_9 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
st_report_regart50 kst_report_regart50
kuf_report_regart50 kuf1_report_regart50


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_9" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_9"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true

	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
		tab_1.tabpage_1.dw_1.Object.b_registra.Enabled="No"
//		k_rcx = tab_1.tabpage_1.dw_1.modify("b_registra.enabled = 0")
			
	//--- prendi dati
		kuf1_report_regart50 = create kuf_report_regart50
		kuf1_report_regart50.get_st_report_regart50(kst_report_regart50)
		destroy kuf1_report_regart50
		
		tab_1.tabpage_1.dw_1.setitem(1, "anno", year(kst_report_regart50.k_data_a) )
		tab_1.tabpage_1.dw_1.setitem(1, "mese", month(kst_report_regart50.k_data_a) )
		tab_1.tabpage_1.dw_1.setitem(1, "nrpag", kst_report_regart50.k_nrpagina + 1)
		tab_1.tabpage_1.dw_1.setitem(1, "nrprot", kst_report_regart50.k_nrprotocollo - 1)
		tab_1.tabpage_1.dw_1.setitem(1, "nrpag_def", kst_report_regart50.k_nrpagina + 1)
		tab_1.tabpage_1.dw_1.setitem(1, "nrprot_def", kst_report_regart50.k_nrprotocollo)
		
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

public subroutine report_9_salva_dati ();//
//--- Registra i dati su DB
//
st_report_regart50 kst_report_regart50
kuf_report_regart50 kuf1_report_regart50


try 

	kuf1_report_regart50 = create kuf_report_regart50
	
	kst_report_regart50.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
	kst_report_regart50.k_data_a =	tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") 
	kst_report_regart50.k_nrpagina = tab_1.tabpage_1.dw_1.getitemnumber(1, "nrpag_def")
	kst_report_regart50.k_nrprotocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "nrprot_def")
	
	kuf1_report_regart50.set_st_report_regart50(kst_report_regart50)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_ok )
	kguo_exception.setmessage( "Dati Registro salvati Correttamente")
	kguo_exception.messaggio_utente( )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	
	
finally
	destroy kuf1_report_regart50
end try
end subroutine

private subroutine report_10 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
datawindowchild   kdwc_cliente_C
st_report_merce_da_sped kst_report_merce_da_sped
kuf_report_merce_da_sped kuf1_report_merce_da_sped


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_10" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_10"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente)
//	tab_1.tabpage_1.dw_1.getchild("clie_2_1", kdwc_cliente_c)
	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_c.settransobject(sqlca)
	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
		kdwc_cliente.retrieve("%")
		kdwc_cliente.insertrow(1)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_c, 1, Primary!)
	end if
	
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
	//--- prendi dati
		kuf1_report_merce_da_sped = create kuf_report_merce_da_sped
		kuf1_report_merce_da_sped.get_st_report_merce_da_sped(kst_report_merce_da_sped)
		destroy kuf1_report_merce_da_sped
		
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", kst_report_merce_da_sped.k_data_da )
		tab_1.tabpage_1.dw_1.setitem(1, "clie_2", kst_report_merce_da_sped.k_clie_2 )
//		kst_report_merce_da_sped.k_rileva_stato_e1 = "1"
//		tab_1.tabpage_1.dw_1.setitem(1, "rileva_stato_e1", kst_report_merce_da_sped.k_rileva_stato_e1 )

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private function long report_5_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT PROGRAMMAZIONE PILOTA
//
string k_scelta, k_codice_prec
long k_righe=0, k_rc
date k_data
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base
st_tab_nazioni kst_tab_nazioni
st_tab_meca kst_tab_meca_da, kst_tab_meca_a
st_tab_clienti kst_tab_clienti
date k_data_da, k_data_a
date k_data_int_da, k_data_int_a
datetime k_data_ent_da, k_data_ent_a

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then
	
			kst_tab_meca_da.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_ini") //rif ini
			if isnull(kst_tab_meca_da.num_int) then	kst_tab_meca_da.num_int = 0	
			kst_tab_meca_a.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_fin") //rif fin
			if isnull(kst_tab_meca_a.num_int) then kst_tab_meca_a.num_int = 0	
			k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data entrata riferimento da
			k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data entrata riferimento a
			kist_int_artr.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") //Mandante
			if isnull(kist_int_artr.clie_1) then kist_int_artr.clie_1 = 0	
//			kist_int_artr.clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_2") //Ricev
//			kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Fatturato
//			kist_int_artr.m_r_f = tab_1.tabpage_1.dw_1.getitemstring(1, "m_r_f") //estrae tipo estrazione nominativi
			kist_int_artr.num_bolla_in = tab_1.tabpage_1.dw_1.getitemstring(1, "num_bolla_in") //Bolla mandante
			kist_int_artr.anno_bolla_in = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno_bolla_in") //Bolla mandante
			if isnull(kist_int_artr.anno_bolla_in) then	 kist_int_artr.anno_bolla_in = 0	
			if isnull(kist_int_artr.num_bolla_in) then	 kist_int_artr.num_bolla_in = " "	
			kst_tab_nazioni.gruppo = tab_1.tabpage_1.dw_1.getitemstring(1, "nazioni_gruppo_1") //Bolla mandante
			if isnull(kst_tab_nazioni.gruppo) then	 kst_tab_nazioni.gruppo = " "	

			k_data_int_da = relativedate(k_data_da, -180)
			k_data_int_a = relativedate(k_data_a, 30)
			k_data_ent_da = DATETIME(k_data_da, time(0))
			k_data_ent_a = DATETIME(k_data_a, time(23,59,59)) 
			

//=== Controllo date
			if (k_data_a > date(0) and k_data_a < k_data_da) &
				then
				kGuo_exception.setmessage("Controllare il periodo,~n~rindicata data fine periodo minore di quella di inizio")
				kGuo_exception.messaggio_utente()
			else		
				kst_tab_meca_da.data_int = k_data_int_da
				kst_tab_meca_a.data_int = k_data_int_a
				get_id_meca(kst_tab_meca_da, kst_tab_meca_a)
	
				kdw_1.visible = true
				kdw_1.dataobject = "d_report_5_check_intra" 
				k_rc = kdw_1.settransobject(sqlca)
		
				if kst_tab_meca_da.id > 0 then
					k_righe = kdw_1.retrieve(  &
															  kst_tab_meca_da.id  &
				                                  ,kst_tab_meca_a.id  &
															 ,k_data_int_da  &
				                                  ,k_data_int_a  &
															 ,kist_int_artr.clie_1  &						 
				                                  ,kst_tab_nazioni.gruppo &
															 ,kist_int_artr.anno_bolla_in &
															 ,kist_int_artr.num_bolla_in &
															 ,k_data_ent_da &
															 ,k_data_ent_a &
															)
				else
					kGuo_exception.setmessage("Nessun Riferimento Trovato,~n~r Controlla i dati immessi.")
					throw kGuo_exception
				end if
			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		


return k_righe
	

end function

private function long report_8_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_8_lotti_in_mag_gia_certificati" 
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_8()
	
	//--- view x estrazione 
			crea_view_x_report_8()
		
			leggi_dwc_barcode(0, kdw_1)
		
	//--- Aggiorna SQL della dw	
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_report_8"
			k_string = "vx_MAST2_report_8"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 
		
				
			k_rc = kdw_1.settransobject ( sqlca )
			k_righe = kdw_1.retrieve()

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe


end function

private function long report_9_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT REGISTRO ART 50
//
string k_scelta, k_codice_prec
int k_anno, k_mese, k_rc
long k_righe=0
st_report_regart50 kst_report_regart50
kuf_report_regart50 kuf1_report_regart50

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kuf1_report_regart50 = create kuf_report_regart50
			
			k_anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno") 
			k_mese = tab_1.tabpage_1.dw_1.getitemnumber(1, "mese") 
			kst_report_regart50.k_data_da = date(k_anno, k_mese, 01)
			if k_mese = 12 then
				kst_report_regart50.k_data_a = date(k_anno, k_mese, 31)
			else
				kst_report_regart50.k_data_a = relativedate(date(k_anno, k_mese + 1, 01), -1)
			end if
			kst_report_regart50.k_nrpagina = tab_1.tabpage_1.dw_1.getitemnumber(1, "nrpag") 
			kst_report_regart50.k_nrprotocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "nrprot") 

//=== Controllo date
//			if (kst_tab_meca_a.data_int > date(0) and kst_tab_meca_a.data_int < kst_tab_meca_da.data_int) &
//				then
//				kGuo_exception.setmessage("Controlla le date immesse,~n~r data di fine periodo minore di quella di inizio")
//			else							
//				get_id_meca(kst_tab_meca_da, kst_tab_meca_a)

//--- lancia estrazione dei dati
				kuf1_report_regart50.get_report(kst_report_regart50)
				k_righe = kuf1_report_regart50.kids_report_regart50.rowcount( )

				if k_righe > 0 then
//--- Il REPORT!			
					kdw_1.dataobject = kuf1_report_regart50.kids_report_regart50.dataobject
					
					kdw_1.event u_personalizza_dw() //--- aggiunge i link standard
					
					kuf1_report_regart50.kids_report_regart50.rowscopy( 1, k_righe , primary!, kdw_1, 1, primary!)
					kdw_1.scrolltorow( kdw_1.rowcount( ))
					kst_report_regart50.k_nrpagina = kdw_1.object.pagecount[1]
					tab_1.tabpage_1.dw_1.Object.b_registra.Enabled='Yes'
				else
					kst_report_regart50.k_nrpagina = 0
					kGuo_exception.setmessage("Nessun Dato Trovato,~n~r Controlla i dati immessi.")
					kGuo_exception.messaggio_utente()
					tab_1.tabpage_1.dw_1.Object.b_registra.Enabled='No'
				end if

//--- mostra i dati x registrarli in archivio				
				tab_1.tabpage_1.dw_1.setitem(1, "data_da", kst_report_regart50.k_data_da) 
				tab_1.tabpage_1.dw_1.setitem(1, "data_a", kst_report_regart50.k_data_a) 
				tab_1.tabpage_1.dw_1.setitem(1, "nrpag_def", kst_report_regart50.k_nrpagina)
				tab_1.tabpage_1.dw_1.setitem(1, "nrprot_def", kst_report_regart50.k_nrprotocollo)
				
//			end if

			destroy kuf1_report_regart50

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		


return k_righe


end function

private function long report_10_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT MERCE DA SPEDIRE
//
string k_scelta, k_codice_prec
int k_anno, k_mese, k_rc
long k_righe, k_riga
st_tab_e1_asn kst_tab_e1_asn[]
st_report_merce_da_sped kst_report_merce_da_sped
kuf_report_merce_da_sped kuf1_report_merce_da_sped
kuf_e1_asn kuf1_e1_asn

	
try

	k_scelta = trim(ki_st_open_w.flag_modalita)


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(kdw_1.tag) then
		k_codice_prec = kdw_1.tag
	else
		k_codice_prec = " "
	end if

//--- salvo i parametri cosi come sono stati immessi
	kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

	if trim(k_codice_prec) <> trim(kdw_1.tag) then
		u_set_tabpage_picture(true)
	else
		u_set_tabpage_picture(false)
	end if
	
	if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

		kuf1_report_merce_da_sped = create kuf_report_merce_da_sped
		
		kst_report_merce_da_sped.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
		kst_report_merce_da_sped.k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_2") 
//			kst_report_merce_da_sped.k_rileva_stato_e1 = tab_1.tabpage_1.dw_1.getitemstring(1, "rileva_stato_e1") 

//=== Controllo date
//			if (kst_tab_meca_a.data_int > date(0) and kst_tab_meca_a.data_int < kst_tab_meca_da.data_int) &
//				then
//				kGuo_exception.setmessage("Controlla le date immesse,~n~r data di fine periodo minore di quella di inizio")
//			else							
//				get_id_meca(kst_tab_meca_da, kst_tab_meca_a)

//--- lancia estrazione dei dati
			kuf1_report_merce_da_sped.get_report(kst_report_merce_da_sped)
			k_righe = kuf1_report_merce_da_sped.kids_report_merce_da_sped.rowcount( )

			if k_righe > 0 then

//--- Il REPORT!					
				kdw_1.dataobject = kuf1_report_merce_da_sped.kids_report_merce_da_sped.dataobject

				kdw_1.event u_personalizza_dw() //--- aggiunge i link standard

				kuf1_report_merce_da_sped.kids_report_merce_da_sped.rowscopy( 1, k_righe, primary!, kdw_1, 1, primary!)
				kdw_1.scrolltorow( kdw_1.rowcount( ))
				
////					if ki_e1_enabled then
//					if kst_report_merce_da_sped.k_rileva_stato_e1 = "1" then
//						kuf1_e1_asn = create kuf_e1_asn
//						k_righe = kdw_1.rowcount( )
//						for k_riga = 1 to k_righe
//							kst_tab_e1_asn[k_riga].wammcu = kkg.E1MCU
//							if kdw_1.getitemnumber( k_riga, "e1doco") > 0 then
////--- Prepara l'array per get dello STATO del ASN da E1
//								kst_tab_e1_asn[k_riga].waapid = string(kdw_1.getitemnumber( k_riga, "id_meca"))
//							else
//								kst_tab_e1_asn[k_riga].waapid = "~'~'"
//							end if
//						next
////--- Get dello STATO del ASN su E1
//						kuf1_e1_asn.u_get_stato(kst_tab_e1_asn[])
////--- Imposta lo STATO del ASN
//						for k_riga = 1 to k_righe
//							if kst_tab_e1_asn[k_riga].wasrst > " " then
//								kdw_1.setitem(k_riga, "k_wasrst", kst_tab_e1_asn[k_riga].wasrst)
//							else
//								kdw_1.setitem(k_riga, "k_wasrst", " ")
//							end if
//						next
//					end if
			
			else
				kGuo_exception.setmessage("Nessun Dato Trovato,~n~r Controlla i dati immessi.")
				throw kGuo_exception

			end if

//			end if

		destroy kuf1_report_merce_da_sped

	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_e1_asn) then destroy kuf1_e1_asn
	attiva_tasti()
	if kdw_1.rowcount() = 0 then
		kdw_1.insertrow(0) 
	end if
	kdw_1.setfocus()

end try
	
return k_righe



end function

private subroutine leggi_dwc_rif_x_data_mrf (long k_riga, ref datawindow k_dw);//
string k_data_x
date k_data_ini, k_data_fin
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
datawindowchild kdwc_meca

//--- se sono sul report generico allora faccio vedere i barcode
//if ki_scelta_report = ki_scelta_report_lotti_entrati then

	k_dw.getchild("b_riferim_l", kdwc_meca)

	kdwc_meca.settransobject(sqlca)

	if k_dw.rowcount() > 0 then

		if k_riga > 0 then
			
			// data in formato 'yyyy / mm'
			k_data_x =  k_dw.getitemstring(k_riga,"data_int")
			// calcola data inizio mese
			k_data_ini = date(integer( mid(k_data_x, 1, 4) ), integer( mid(k_data_x, 8, 2) ), 01)
			// calcola data fine mese (ultimo giorno del mese)
			k_data_fin = relativedate(k_data_ini, 31)
			k_data_fin =  relativedate(date(year(k_data_fin), month(k_data_fin), 01), -1)  
			// piglie man-ric-fatt
			kst_tab_meca.clie_1 = k_dw.getitemnumber(k_riga,"clie_1")
			if isnull(kst_tab_meca.clie_1) then kst_tab_meca.clie_1 = 0
			kst_tab_meca.clie_2 = k_dw.getitemnumber(k_riga,"clie_2")
			if isnull(kst_tab_meca.clie_2) then kst_tab_meca.clie_2 = 0
			kst_tab_meca.clie_3 = k_dw.getitemnumber(k_riga,"clie_3")
			if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0
			kst_tab_armo.dose =  k_dw.getitemnumber(k_riga,"dose")
			if isnull(kst_tab_armo.dose) then kst_tab_armo.dose = 0
			kst_tab_armo.art =  k_dw.getitemstring(k_riga,"art")
			if isnull(kst_tab_armo.art) then kst_tab_armo.art = "*"
			if kdwc_meca.retrieve(k_data_ini, k_data_fin, kst_tab_meca.clie_1, kst_tab_meca.clie_2, kst_tab_meca.clie_3, kst_tab_armo.dose, kst_tab_armo.art) > 0 then

				kdwc_meca.insertrow(0)
			
			end if
		else
			kdwc_meca.insertrow(0)
		end if
	else
		kdwc_meca.insertrow(0)

	end if

//end if
end subroutine

private function long report_14_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT ETICHETTE LOTTI
//
string k_scelta, k_codice_prec, k_rcx
int k_anno, k_mese, k_rc
long k_riga=0, k_riga_ins=0
long k_righe=0
st_report_etichette_lotti kst_report_etichette_lotti

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			
			kst_report_etichette_lotti.k_num_da = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_da") 
			if isnull(kst_report_etichette_lotti.k_num_da) then kst_report_etichette_lotti.k_num_da = 1
			kst_report_etichette_lotti.k_num_a = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_a") 
			if kst_report_etichette_lotti.k_num_a = 0 or  isnull(kst_report_etichette_lotti.k_num_a) then kst_report_etichette_lotti.k_num_a = kst_report_etichette_lotti.k_num_da  + 10

//=== Controllo numeri
			if kst_report_etichette_lotti.k_num_da > kst_report_etichette_lotti.k_num_a then
				kGuo_exception.setmessage("Controlla i numeri immessi,~n~r numero di fine minore di quello di inizio")
				throw kGuo_exception
			else							

//--- lancia generazione etichette
//--- Il REPORT!					
				kdw_1.dataobject = "d_report_14_etichettine" 
				k_rc = kdw_1.settransobject(sqlca)

//				kdw_1.object.datawindow.print.paper.size = 256
//				k_rcx = kdw_1.Modify("DataWindow.Print.CustomPage.Length=38")
//				k_rcx = kdw_1.Modify("DataWindow.Print.CustomPage.Width=101")

				kdw_1.reset( )
				kdw_1.event u_personalizza_dw() //--- aggiunge i link standard
				
				k_riga_ins=0
				for k_riga = 1 to  (kst_report_etichette_lotti.k_num_a - kst_report_etichette_lotti.k_num_da + 1)

					k_riga_ins = kdw_1.insertrow(0)
					kdw_1.setitem(k_riga_ins, "barcode_numero", string(kst_report_etichette_lotti.k_num_da + k_riga_ins - 1) )
					kdw_1.setitem(k_riga_ins, "barcode_graf", string(kst_report_etichette_lotti.k_num_da + k_riga_ins - 1, "*00000000*") )

				end for
				k_righe = kdw_1.rowcount()	
				kdw_1.scrolltorow(k_righe)
				
				kdw_1.visible = true

			end if


		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		


return k_righe

	
	

end function

private subroutine report_14 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
datawindowchild   kdwc_cliente_C
st_report_etichette_lotti kst_report_etichette_lotti
kuf_report_etichette_lotti kuf1_report_etichette_lotti


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_14" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_14"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)



//--- Setta valori di Default

	try	
		tab_1.tabpage_1.dw_1.reset()
		tab_1.tabpage_1.dw_1.insertrow(0)

//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
	//--- prendi dati
		kuf1_report_etichette_lotti = create kuf_report_etichette_lotti
		kuf1_report_etichette_lotti.get_st_report_etichette_lotti(kst_report_etichette_lotti)
		destroy kuf1_report_etichette_lotti
		
		if kst_report_etichette_lotti.k_num_da > 10 then
			kst_report_etichette_lotti.k_num_da -= 10
		else
			kst_report_etichette_lotti.k_num_da = 1
		end if
		kst_report_etichette_lotti.k_num_a += 10
		
		tab_1.tabpage_1.dw_1.setitem(1, "num_int_da", kst_report_etichette_lotti.k_num_da )
		tab_1.tabpage_1.dw_1.setitem(1, "num_int_a", kst_report_etichette_lotti.k_num_a )

		tab_1.tabpage_1.dw_1.visible = true
	
		tab_1.tabpage_1.dw_1.setfocus()
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private function long report_13_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT GROUPAGE PIANIFICATI
//
string k_scelta, k_codice_prec
int k_rc
date k_data
long k_righe

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "no_pl")) = "S" then 
				
//--- Il REPORT!					
				kdw_1.dataobject = "d_report_13_grp_da_trattare" 
				k_rc = kdw_1.settransobject(sqlca)
	
				kdw_1.event u_personalizza_dw() //--- aggiunge i link standard
	
				k_data = relativedate(kg_dataoggi, -180)
				k_righe = kdw_1.retrieve(k_data )

			else
				k_data = tab_1.tabpage_1.dw_1.getitemdate(1, "data_pl") 
				if isnull(k_data) then k_data = date(0)

//--- Il REPORT!					
				kdw_1.dataobject = "d_report_13_grp" 
				k_rc = kdw_1.settransobject(sqlca)
	
				kdw_1.event u_personalizza_dw() //--- aggiunge i link standard
	
				k_righe = kdw_1.retrieve( k_data )

			end if
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		
return k_righe
	

end function

private subroutine report_13 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_13" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_13"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
	//--- imposta dati di default
		tab_1.tabpage_1.dw_1.setitem(1, "data_pl", kg_dataoggi )
		
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

end subroutine

private function long report_12_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT ETICHETTE LOTTI
//
string k_scelta, k_codice_prec
int k_anno, k_mese, k_rc
long k_righe=0
st_report_etichette_lotti kst_report_etichette_lotti
kuf_report_etichette_lotti kuf1_report_etichette_lotti

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kuf1_report_etichette_lotti = create kuf_report_etichette_lotti
			
			kst_report_etichette_lotti.k_num_da = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_da") 
			if isnull(kst_report_etichette_lotti.k_num_da) then kst_report_etichette_lotti.k_num_da = 0
			kst_report_etichette_lotti.k_num_a = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int_a") 
			if kst_report_etichette_lotti.k_num_a = 0 or  isnull(kst_report_etichette_lotti.k_num_a) then kst_report_etichette_lotti.k_num_a = 999999999
			kst_report_etichette_lotti.k_anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno") 
			kst_report_etichette_lotti.k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") 
			kst_report_etichette_lotti.k_area_dawmf = tab_1.tabpage_1.dw_1.getitemnumber(1, "area_dawmf") 

//=== Controllo numeri
			if kst_report_etichette_lotti.k_num_da > kst_report_etichette_lotti.k_num_a then
				kGuo_exception.setmessage("Controlla i numeri immessi,~n~r numero di fine minore di quello di inizio")
				throw kGuo_exception
			else							

//--- lancia estrazione dei dati
				kuf1_report_etichette_lotti.get_report(kst_report_etichette_lotti)
				k_righe = kuf1_report_etichette_lotti.kids_report_etichette_lotti.rowcount( )
				
				if k_righe > 0 then

//--- Il REPORT!					
					kdw_1.dataobject = kuf1_report_etichette_lotti.kids_report_etichette_lotti.dataobject

					kdw_1.event u_personalizza_dw() //--- aggiunge i link standard

					kuf1_report_etichette_lotti.kids_report_etichette_lotti.rowscopy( 1, kuf1_report_etichette_lotti.kids_report_etichette_lotti.rowcount( ) , primary!, kdw_1, 1, primary!)
					kdw_1.scrolltorow( kdw_1.rowcount( ))
				else
					kGuo_exception.setmessage("Nessun Dato Trovato,~n~r Controlla i dati immessi.")
					throw kGuo_exception
				end if

			end if

			destroy kuf1_report_etichette_lotti

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		
return k_righe

end function

private subroutine report_12 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
datawindowchild   kdwc_cliente_C
st_report_etichette_lotti kst_report_etichette_lotti
kuf_report_etichette_lotti kuf1_report_etichette_lotti


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_12" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_12"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
//	tab_1.tabpage_1.dw_1.getchild("clie_2_1", kdwc_cliente_c)
	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_c.settransobject(sqlca)
	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
		kdwc_cliente.retrieve("%")
		kdwc_cliente.insertrow(1)
//		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_c, 1, Primary!)
	end if
	
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
	//--- prendi dati
		kuf1_report_etichette_lotti = create kuf_report_etichette_lotti
		kuf1_report_etichette_lotti.get_st_report_etichette_lotti(kst_report_etichette_lotti)
		destroy kuf1_report_etichette_lotti
		
		tab_1.tabpage_1.dw_1.setitem(1, "anno", kst_report_etichette_lotti.k_anno )
		tab_1.tabpage_1.dw_1.setitem(1, "num_int_da", kst_report_etichette_lotti.k_num_da )
		tab_1.tabpage_1.dw_1.setitem(1, "num_int_a", kst_report_etichette_lotti.k_num_a )
		tab_1.tabpage_1.dw_1.setitem(1, "clie_1", kst_report_etichette_lotti.k_clie_1 )
		tab_1.tabpage_1.dw_1.setitem(1, "area_dawmf", kst_report_etichette_lotti.k_area_dawmf )
		
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine report_11 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
datawindowchild  kdwc_cliente_C
st_report_merce_sped kst_report_merce_sped
kuf_report_merce_sped kuf1_report_merce_sped


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_11" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_11"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente)
	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_c.settransobject(sqlca)
	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
		kdwc_cliente.retrieve("%")
		kdwc_cliente.insertrow(1)
	end if
	
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
	//--- prendi dati
		kuf1_report_merce_sped = create kuf_report_merce_sped
		kuf1_report_merce_sped.get_st_report_merce_sped(kst_report_merce_sped)
		destroy kuf1_report_merce_sped
		
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", kst_report_merce_sped.k_data_a )
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", kst_report_merce_sped.k_data_da )
		tab_1.tabpage_1.dw_1.setitem(1, "clie_2", kst_report_merce_sped.k_clie_2 )

			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

end subroutine

private function long report_11_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT MERCE SPEDITA
//
string k_scelta, k_codice_prec
int k_anno, k_mese, k_rc
long k_righe
st_report_merce_sped kst_report_merce_sped
kuf_report_merce_sped kuf1_report_merce_sped

	
	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)
	
	
//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
//--- salvo i parametri cosi come sono stati immessi
		kdw_1.tag = kiuf_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
		
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kuf1_report_merce_sped = create kuf_report_merce_sped
			
			kst_report_merce_sped.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
			kst_report_merce_sped.k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") 
			kst_report_merce_sped.k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_2") 

//=== Controllo date
			if (kst_report_merce_sped.k_data_a > date(0) and kst_report_merce_sped.k_data_a < kst_report_merce_sped.k_data_da) then
				kGuo_exception.setmessage("Controlla le date immesse,~n~r data di fine periodo minore di quella di inizio")
			else							
//				get_id_meca(kst_tab_meca_da, kst_tab_meca_a)

//--- lancia estrazione dei dati
				kuf1_report_merce_sped.get_report(kst_report_merce_sped)

				if kuf1_report_merce_sped.kids_report_merce_sped.rowcount( ) > 0 then

//--- Il REPORT!					
					kdw_1.dataobject = kuf1_report_merce_sped.kids_report_merce_sped.dataobject

					kdw_1.event u_personalizza_dw() //--- aggiunge i link standard

					kuf1_report_merce_sped.kids_report_merce_sped.rowscopy( 1, kuf1_report_merce_sped.kids_report_merce_sped.rowcount( ) , primary!, kdw_1, 1, primary!)
					
					k_righe = kdw_1.rowcount( )
					kdw_1.scrolltorow(k_righe)
				else
//					kGuo_exception.setmessage("Nessun Dato Trovato,~n~r Controlla i dati immessi.")
//					throw kGuo_exception

				end if

			end if

			destroy kuf1_report_merce_sped

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try
		

return k_righe	
	

end function

private subroutine report_15 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente
date k_data, k_data_da, k_data_a


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_15" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_15"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


//--- prendi data oggi	
		k_data_a = kguo_g.get_dataoggi()

//--- legge dwc mandante
		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
		kdwc_cliente.settransobject(sqlca)
		if kdwc_cliente.rowcount() = 0 then
			kdwc_cliente.retrieve("%")
		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)	
		tab_1.tabpage_1.dw_1.setitem(1, "clie_1", "")	
		tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1", "")	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine get_parametri_15 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data da cui far partire la ricerca (normalmente la data di oggi)
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
	k_data_a = kguo_g.get_dataoggi( )
	tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
end if
kist_int_artr.data_a = k_data_a

kist_int_artr.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") //Mandante
if isnull(kist_int_artr.clie_1) then
	kist_int_artr.clie_1 = 0
end if



end subroutine

private function long report_15_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
kuf_utility kuf1_utility


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_15_bcode_fine_lav"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_15()
	
			k_righe = kdw_1.retrieve(kist_int_artr.data_a, kist_int_artr.clie_1)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe

end function

private subroutine report_16 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//datawindowchild   kdwc_cliente
date k_data_da


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_16" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_16"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


//--- prendi data oggi	
		k_data_da = date(year(kguo_g.get_dataoggi()), month(kguo_g.get_dataoggi()), 01)

//--- legge dwc mandante
//		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
//		kdwc_cliente.settransobject(sqlca)
//		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//			kdwc_cliente.retrieve("%")
//		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)	
		tab_1.tabpage_1.dw_1.setitem(1, "art", "")	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine get_parametri_16 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_da
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data da cui far partire la ricerca (normalmente la data inizio mese)
if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date(year(kguo_g.get_dataoggi( )), month(kguo_g.get_dataoggi( )), 01)
	tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
	kGuo_exception.setmessage("Data assente non ammessa,~n~rimposto in automatico la data a inizio mese")
	throw kGuo_exception 
end if
kist_int_artr.data_da = k_data_da

kist_int_artr.art = tab_1.tabpage_1.dw_1.getitemstring(1, "art") //Mandante
if isnull(kist_int_artr.art) then
	kist_int_artr.art = "%"
end if



end subroutine

private function long report_16_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_16_artmovim_l"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_16()
	
			k_righe = kdw_1.retrieve(kist_int_artr.data_da, kist_int_artr.art)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe
	

end function

private subroutine get_parametri_17 () throws uo_exception;//======================================================================
//
string k_dataoggix
date  k_data_da
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data da cui far partire la ricerca (normalmente la data inizio mese)
if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date(year(kguo_g.get_dataoggi( )), month(kguo_g.get_dataoggi( )), 01)
	tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
	kGuo_exception.setmessage("Data assente non ammessa,~n~rimposto in automatico la data a inizio mese")
	throw kGuo_exception 
end if
kist_int_artr.data_da = k_data_da

kist_int_artr.stato = tab_1.tabpage_1.dw_1.getitemstring(1, "stato") //Mandante
if isnull(kist_int_artr.stato) then
	kist_int_artr.stato = "0"
end if



end subroutine

private function long report_17_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
kuf_utility kuf1_utility
kuf_base kuf1_base



	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_17_armoprezzi_l"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_17()
	
			k_righe = kdw_1.retrieve(kist_int_artr.data_da, kist_int_artr.stato)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe


end function

private subroutine report_17 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//datawindowchild   kdwc_cliente
date k_data_da


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_17" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_17"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	//tab_1.tabpage_1.dw_1.reset()
	//tab_1.tabpage_1.dw_1.insertrow(0)

	if u_dw_selezione_ripri( ) = 0 then
		tab_1.tabpage_1.dw_1.insertrow(0)
	end if
	tab_1.tabpage_1.dw_1.visible = true

	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


//--- prendi data oggi	
		k_data_da = date(year(kguo_g.get_dataoggi()), month(kguo_g.get_dataoggi()), 01)

//--- legge dwc mandante
//		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
//		kdwc_cliente.settransobject(sqlca)
//		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//			kdwc_cliente.retrieve("%")
//		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)	
		tab_1.tabpage_1.dw_1.setitem(1, "stato", "0")	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private subroutine report_18 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_18" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_18"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	//tab_1.tabpage_1.dw_1.reset()
	//tab_1.tabpage_1.dw_1.insertrow(0)

	if u_dw_selezione_ripri( ) = 0 then
		tab_1.tabpage_1.dw_1.insertrow(0)
	end if
	tab_1.tabpage_1.dw_1.visible = true

	tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente.retrieve("%")
	kdwc_cliente.insertrow(1)

	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)


		tab_1.tabpage_1.dw_1.setitem(1, "x_data", relativedate(kguo_g.get_dataoggi(), -31) )	
		tab_1.tabpage_1.dw_1.setitem(1, "x_utente", "")	
		tab_1.tabpage_1.dw_1.setitem(1, "ricerca", "")	
		tab_1.tabpage_1.dw_1.setitem(1, "settore", "")	
		tab_1.tabpage_1.dw_1.setitem(1, "anno", kguo_g.get_anno( ) )	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		


end subroutine

private function long report_18_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
datetime k_dataora
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa
st_tab_sped kst_tab_sped
datawindowchild kdwc_barcode
kuf_utility kuf1_utility
kuf_base kuf1_base
kuf_armo kuf1_armo
kuf_fatt kuf1_fatt
kuf_sped kuf1_sped


	try
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

	//--- piglia i parametri per l'estrazione 
			get_parametri_18()
			k_dataora = datetime(kist_int_artr.data_da)
			
			kdw_1.visible = true
			
			if kist_int_artr.num_int > 0 then
				kst_tab_meca.num_int = kist_int_artr.num_int
				kst_tab_meca.data_int = date(kist_int_artr.anno, 01, 01)
				kuf1_armo = create kuf_armo
				kuf1_armo.get_id_meca(kst_tab_meca)
				if kst_tab_meca.id > 0 then
					kuf1_armo.get_dati_rid(kst_tab_meca)
				end if
				kdw_1.dataobject = "d_report_18_memo_l_1"
				k_rc = kdw_1.settransobject(sqlca)
				k_righe = kdw_1.retrieve(kguf_memo_allarme.kki_memo_allarme_meca,kst_tab_meca.id, kst_tab_meca.clie_1, kst_tab_meca.clie_2, kst_tab_meca.clie_3 )
			else
				if kist_int_artr.num_bolla_out > 0 then
					kst_tab_sped.num_bolla_out = kist_int_artr.num_bolla_out
					kst_tab_sped.data_bolla_out = date(kist_int_artr.anno, 01, 01)
					kuf1_sped = create kuf_sped
					kuf1_sped.get_id_sped_anno(kst_tab_sped)
					if kst_tab_sped.id_sped > 0 then
						kuf1_sped.get_clie(kst_tab_sped)
					end if
					kdw_1.dataobject = "d_report_18_memo_l_ddt"
					k_rc = kdw_1.settransobject(sqlca)
					k_righe = kdw_1.retrieve(kguf_memo_allarme.kki_memo_allarme_ddt ,kst_tab_sped.id_sped, kst_tab_sped.clie_2)
				else
					if kist_int_artr.num_fatt > 0 then
						kst_tab_arfa.num_fatt = kist_int_artr.num_fatt
						kst_tab_arfa.data_fatt = date(kist_int_artr.anno, 01, 01)
						kuf1_fatt = create kuf_fatt
						kuf1_fatt.get_id(kst_tab_arfa)
						if kst_tab_arfa.id_fattura > 0 then
							kuf1_fatt.get_cliente(kst_tab_arfa)
						end if
						kdw_1.dataobject = "d_report_18_memo_l_fatt"
						k_rc = kdw_1.settransobject(sqlca)
						k_righe = kdw_1.retrieve(kguf_memo_allarme.kki_memo_allarme_ddt ,kst_tab_arfa.id_fattura, kst_tab_arfa.clie_3)
					else
						kdw_1.dataobject = "d_report_18_memo_l"
						k_rc = kdw_1.settransobject(sqlca)
						k_righe = kdw_1.retrieve(kist_int_artr.ricerca, kist_int_artr.settore, kist_int_artr.clie_1, kist_int_artr.x_utente, k_dataora, kist_int_artr.ricerca_rid )
					end if
				end if
			end if
			

		end if


	catch (uo_exception kuo_exception)
		throw kuo_exception


	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe	

end function

public subroutine get_parametri_18 () throws uo_exception;//======================================================================
//


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
SetPointer(kkg.pointer_attesa)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
kist_int_artr.anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno") //anno
kist_int_artr.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int") //lotto
kist_int_artr.num_bolla_out = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_ddt") //ddt
kist_int_artr.num_fatt = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_fatt") //fattura

kist_int_artr.ricerca_rid =  trim(tab_1.tabpage_1.dw_1.getitemstring(1, "ricerca"))   // dicitura da cercare su titolo+note del memo
if kist_int_artr.ricerca_rid > " " then
	kist_int_artr.ricerca = "%" + trim(kist_int_artr.ricerca_rid) + "%"
else
	kist_int_artr.ricerca = "%"
end if

kist_int_artr.settore = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "settore")) //settore
if isnull(kist_int_artr.settore) then
	kist_int_artr.settore = ""
end if

kist_int_artr.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") //anagrafica
if isnull(kist_int_artr.clie_1) then
	kist_int_artr.clie_1 = 0
end if
kist_int_artr.data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "x_data") //data 
if isnull(kist_int_artr.data_da) then
	kist_int_artr.data_da = date(0)
end if
kist_int_artr.x_utente =  trim(tab_1.tabpage_1.dw_1.getitemstring(1, "x_utente")) //utente di creazione eaggiornamento memo
if isnull(kist_int_artr.x_utente) then
	kist_int_artr.x_utente = ""
end if


end subroutine

private subroutine get_parametri_19 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_data_da
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") 
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
	k_data_a = kguo_g.get_dataoggi( )
	tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
end if
kist_int_artr.data_a = k_data_a
k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = relativedate(kist_int_artr.data_a, -270)
	tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
	kGuo_exception.setmessage("Data assente non ammessa,~n~rimposto in automatico la data a inizio mese")
	throw kGuo_exception 
end if
kist_int_artr.data_da = k_data_da


kist_int_artr.clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_1") //Mandante
if isnull(kist_int_artr.clie_1) then
	kist_int_artr.clie_1 = 0
end if



end subroutine

private function long report_19_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
long k_righe=0, k_ctr, k_rc
kuf_utility kuf1_utility


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_19_sped_da_ft"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_19()
	
			k_righe = kdw_1.retrieve(kist_int_artr.clie_1, kist_int_artr.data_da, kist_int_artr.data_a)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe

end function

private subroutine report_19 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
datawindowchild   kdwc_cliente
long k_rc
date k_data


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_19" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_19"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)

//--- legge dwc mandante
		tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
		kdwc_cliente.settransobject(sqlca)
		if kdwc_cliente.rowcount() = 0 then
			k_rc = kdwc_cliente.retrieve("%")
		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", kguo_g.get_dataoggi( ))	
		k_data = relativedate(kguo_g.get_dataoggi( ), -270) 
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", date(year(k_data), month(k_data), 01))
		tab_1.tabpage_1.dw_1.setitem(1, "clie_1", "")	
		tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1", "")	
		
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

public subroutine u_scegli_report (integer a_num_report);//

ki_scelta_report = a_num_report

if ki_scelta_report > 0 then
	tab_1.tabpage_2.enabled = true
end if

//tab_1.tabpage_1.dw_1.reset()
tab_1.tabpage_1.dw_1.setredraw(false)
u_dw_selezione_save( )

choose case ki_scelta_report

	case ki_scelta_report_lotti_entrati //"riferimenti entrati"
		report_7()

	case ki_scelta_report_generico // "Interrogazione Generica"
		report_1()

	case ki_scelta_report_coda_pilota //"Coda di Lavorazione"
		report_2()

	case ki_scelta_report_in_trattamento //"In Trattamento"
		report_3()

	case ki_scelta_report_trattato //"Trattato"
		report_4()

	case ki_scelta_report_chk_intra //"controllo INTRA"
		report_5()

	case ki_scelta_report_RegArt50 //"Registro Articolo 50"
		report_9()

	case ki_scelta_report_lotti_in_giacenza //"lotti entrati e NON spediti"
		report_6()

	case ki_scelta_report_lotti_in_giacenza_gia_trattati //"lotti gia con ATTESTATO ma non spediti
		report_8()

	case ki_scelta_report_lotti_da_sped 	//"lotti da spedire
		report_10()

	case ki_scelta_report_lotti_sped 			//"lotti spediti
		report_11()

	case ki_scelta_report_etichette_lotti 	//"Etichette Lotti
		report_12()

	case ki_scelta_report_groupage 			//Groupage Pianificati
		report_13()

	case ki_scelta_report_etichettine 			//"Etichettina Dosimetro
		report_14()

	case ki_scelta_report_bcode_trattati 	//"Barcode Trattati
		report_15()

	case ki_scelta_report_art_movim 			//"Movimenti Articoli
		report_16()
		
//	case ki_scelta_report_armo_prezzi 		//"Voci Lotto in ARMO_PREZZI
//		report_17()
		
	case ki_scelta_report_memo 				//"Cerca su MEMO
		report_18()
		
	case ki_scelta_report_lotti_sped_dafatt //"lotti spediti da fatturare
		report_19()
		
	case ki_scelta_report_attestati  			//"Attestati
		report_20()
		
	case ki_scelta_report_armo_Contratti  	//"Contratti entrati
		report_21()

	case ki_scelta_report_lavxcapitolato 	// "Dati lavorazione x Capitolato"
		report_22()
		
	case ki_scelta_report_runsrtrrts 			// "Dati RUNS+RTR+RTS (Receipt to Release/Receipt to Ship)"
		report_23()
		
	case ki_scelta_report_prevfinelav 		// Previsione inizio-fine lav Lotti su PILOTA
		report_24()

	case else  
		report_0( )
		
end choose

tab_1.tabpage_1.dw_1.setredraw(true)
tab_1.tabpage_1.dw_1.visible = true
tab_1.tabpage_1.dw_1.setfocus()

end subroutine

private subroutine report_20 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
//datawindowchild  kdwc_cliente_C
date k_data_da, k_data_a


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_20" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_20"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente)
	kdwc_cliente.settransobject(sqlca)
//	kdwc_cliente_c.settransobject(sqlca)
	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
		kdwc_cliente.retrieve("%")
		kdwc_cliente.insertrow(1)
	end if
	
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	tab_1.tabpage_1.dw_1.visible = true


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
		k_data_a = kguo_g.get_dataoggi( )
		k_data_da = date(kguo_g.get_anno( ), kguo_g.get_mese( ), 01)
		tab_1.tabpage_1.dw_1.setitem(1, "data_da",k_data_da)
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a )
		tab_1.tabpage_1.dw_1.setitem(1, "clie_3", 0 )

			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

	



end subroutine

private function long report_20_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
long k_righe=0, k_ctr, k_rc
kuf_utility kuf1_utility


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_20_attestati"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_20()
	
			k_righe = kdw_1.retrieve(kist_int_artr.data_da, kist_int_artr.data_a, kist_int_artr.mc_co, kist_int_artr.clie_3 )

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe	
	

end function

private subroutine get_parametri_20 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_data_da
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") 
k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
if k_data_da > k_data_a  then
	kGuo_exception.inizializza( )
	kGuo_exception.setmessage("Dati incongruenti", "Data fine maggiore di data inizio valore non ammesso,~n~rcorreggere i valori")
	throw kGuo_exception 
end if

kist_int_artr.data_a = k_data_a
kist_int_artr.data_da = k_data_da

kist_int_artr.mc_co = tab_1.tabpage_1.dw_1.getitemstring(1, "mc_co") //contratto CO
if kist_int_artr.mc_co > " " then
	if  tab_1.tabpage_1.dw_1.getitemstring(1, "mc_co_ricerca_puntuale") = "S" then
	else
		kist_int_artr.mc_co = "%" + trim(kist_int_artr.mc_co) + "%"
	end if
else
	kist_int_artr.mc_co = "%"
end if

kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Cliente
if isnull(kist_int_artr.clie_3) then
	kist_int_artr.clie_3 = 0
end if



end subroutine

private subroutine get_parametri_21 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_data_da
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") 
if k_data_da > k_data_a  then
	kGuo_exception.inizializza( )
	kGuo_exception.setmessage("Dati incongruenti", "Data fine maggiore di data inizio valore non ammesso,~n~rcorreggere i valori")
	throw kGuo_exception 
end if

kist_int_artr.data_da = k_data_da
kist_int_artr.data_a = k_data_a

kist_int_artr.contratto = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice") //id contratto CO
if kist_int_artr.contratto > 0 then
else
	kist_int_artr.contratto = 0
end if

kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Cliente
if isnull(kist_int_artr.clie_3) then
	kist_int_artr.clie_3 = 0
end if

if isnull(kist_int_artr.id_meca=0) then
	kist_int_artr.id_meca = 0
end if

end subroutine

private subroutine report_21 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_rcx
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente 
//datawindowchild  kdwc_cliente_C
datawindowchild  kdwc_contratti_1 //, kdwc_contratti_2, kdwc_contratti_3
date k_data_da, k_data_a


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_21" then
	
	tab_1.tabpage_1.dw_1.dataobject = "d_report_21"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente)
	kdwc_cliente.settransobject(sqlca)
//	kdwc_cliente_c.settransobject(sqlca)
	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
		kdwc_cliente.retrieve("%")
		kdwc_cliente.insertrow(1)
	end if
	
	//tab_1.tabpage_1.dw_1.reset()
	//tab_1.tabpage_1.dw_1.insertrow(0)
	if u_dw_selezione_ripri( ) = 0 then
		tab_1.tabpage_1.dw_1.insertrow(0)
	end if
	tab_1.tabpage_1.dw_1.visible = true

//---- dwc dei contratti
	tab_1.tabpage_1.dw_1.getchild("mc_co", kdwc_contratti_1)
//	tab_1.tabpage_1.dw_1.getchild("mc_co_1", kdwc_contratti_2)
//	tab_1.tabpage_1.dw_1.getchild("codice", kdwc_contratti_3)
	kdwc_contratti_1.settransobject(sqlca)
//	kdwc_contratti_2.settransobject(sqlca)
//	kdwc_contratti_3.settransobject(sqlca)
//	kdwc_contratti_1.sharedata(kdwc_contratti_2)
//	kdwc_contratti_1.sharedata(kdwc_contratti_3)
	kdwc_contratti_1.retrieve(0)
	kdwc_contratti_1.insertrow(1)


	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
			
		k_data_a = kguo_g.get_dataoggi( )
		k_data_da = date(kguo_g.get_anno( ), kguo_g.get_mese( ), 01)
		tab_1.tabpage_1.dw_1.setitem(1, "data_da",k_data_da)
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a )
		tab_1.tabpage_1.dw_1.setitem(1, "clie_3", 0 )
		tab_1.tabpage_1.dw_1.setitem(1, "mc_co", "" )
		tab_1.tabpage_1.dw_1.setitem(1, "codice", 0 )

			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try

end if

				
attiva_tasti()
		

kuf_base kuf1_base
	



end subroutine

private function long report_21_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
long k_righe=0, k_ctr, k_rc
kuf_utility kuf1_utility


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_21_armo_cntr"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_21()
	
			k_righe = kdw_1.retrieve(kist_int_artr.data_da, kist_int_artr.data_a, kist_int_artr.clie_3, kist_int_artr.id_meca, kist_int_artr.contratto )

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe

end function

public subroutine u_parametri_clicked (string k_nome, long k_riga);//
int k_anno
datawindowchild kdwc_cliente //, kdwc_dose
kuf_prodotti kuf1_prodotti
kuf_contratti kuf1_contratti


if k_riga > 0 then 

	
//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

//	if ki_scelta_report = ki_scelta_report_generico  or ki_scelta_report = ki_scelta_report_lotti_entrati &
//			or ki_scelta_report = ki_scelta_report_lotti_sped or ki_scelta_report = ki_scelta_report_bcode_trattati then
//	
		choose case k_nome	
			case "clie_1"	
				tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("")
					kdwc_cliente.insertrow(1)
				end if
			case "clie_2"	
				tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("")
					kdwc_cliente.insertrow(1)
				end if
			case "clie_3"	
				tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("")
					kdwc_cliente.insertrow(1)
				end if
		
		end choose
//
//	else
		
		choose case k_nome
				
			case "b_registra" 
		//		if ki_scelta_report = ki_scelta_report_RegArt50 then
					report_9_salva_dati()
		//		end if
			
			
			case "b_cod_art_l" 
				try 
					kuf1_prodotti = create kuf_prodotti
					kuf1_prodotti.link_call(kidw_selezionata, k_nome )
				catch (uo_exception kuo_exception)
					kuo_exception.messaggio_utente()
				finally
					if isvalid(kuf1_prodotti) then destroy kuf1_prodotti
				end try
			
			
			case "b_mese_prec" 
				kidw_selezionata.object.data_a[1] = relativedate( date(kguo_g.get_anno( ), kguo_g.get_mese( ), 01), -1)
				kidw_selezionata.object.data_da[1] = date(year(kidw_selezionata.object.data_a[1]), month(kidw_selezionata.object.data_a[1]), 01)

			
			case "b_barcode_l" 
		//		if ki_scelta_report = ki_scelta_report_generico then
					leggi_dwc_barcode(k_riga, kidw_selezionata)
		//		end if

			case "b_riferim_l" 
		//		if ki_scelta_report = ki_scelta_report_lotti_entrati then
					leggi_dwc_rif_x_data_mrf(k_riga, kidw_selezionata)
		//		end if
		
	case "b_riferim_runrtrrts_l",  "b_riferim_runrtrrts_l_1"
		//		if ki_scelta_report = ki_scelta_report_lotti_entrati then
					leggi_dwc_runsrtrrts_help(k_riga, kidw_selezionata)
		//		end if
		
			case "id_gruppo"
				leggi_dwc_gruppi(kidw_selezionata)
			
			case "b_sc_cf_l" 
				try 
					kuf1_contratti = create kuf_contratti
					kuf1_contratti.link_call(kidw_selezionata, k_nome )
				catch (uo_exception kuo1_exception)
					kuo_exception.messaggio_utente()
				finally
					if isvalid(kuf1_contratti) then destroy kuf1_contratti
				end try
		
			case "gru_no_stat" 
				leggi_gru_no_stat(kidw_selezionata)
				
		end choose
	
//	end if
	
//=== Se volessi riprist. il vecchio puntatore : 
	SetPointer(kkg.pointer_default)

end if



end subroutine

protected subroutine inizializza_2 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_3.dw_3
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_3 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_4.dw_4
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_4 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_5.dw_5
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_5 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_6.dw_6
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_6 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_7.dw_7
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_7 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_8.dw_8
	u_report_run()
		

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

protected subroutine inizializza_8 () throws uo_exception;//

try

	kidw_selezionata = tab_1.tabpage_9.dw_9
	u_report_run()

catch (uo_exception kuo_exception)
	tab_1.selectedtab = 1
	kuo_exception.messaggio_utente()
	
finally
	
end try


end subroutine

public subroutine u_inizializza_dw_tag ();//---
		
	choose case tab_1.selectedtab 
		case 1 
			kidw_selezionata = tab_1.tabpage_1.dw_1
			tab_1.tabpage_1.text = "Report"
		case 2
			kidw_selezionata = tab_1.tabpage_2.dw_2
			tab_1.tabpage_2.text = "Report"
		case 3
			kidw_selezionata = tab_1.tabpage_3.dw_3
			tab_1.tabpage_3.text = "Report"
		case 4
			kidw_selezionata = tab_1.tabpage_4.dw_4
			tab_1.tabpage_4.text = "Report"
		case 5
			kidw_selezionata = tab_1.tabpage_5.dw_5
			tab_1.tabpage_5.text = "Report"
		case 6
			kidw_selezionata = tab_1.tabpage_6.dw_6
			tab_1.tabpage_6.text = "Report"
		case 7
			kidw_selezionata = tab_1.tabpage_7.dw_7
			tab_1.tabpage_7.text = "Report"
		case 8
			kidw_selezionata = tab_1.tabpage_8.dw_8
			tab_1.tabpage_8.text = "Report"
		case 9
			kidw_selezionata = tab_1.tabpage_9.dw_9
			tab_1.tabpage_9.text = "Report"
	end choose	

	kidw_selezionata.tag = ""

end subroutine

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case k_par_in 

	case KKG_FLAG_RICHIESTA.refresh		//rilegge lista
		try
			u_inizializza_dw_tag( )
			inizializza_lista()
		catch (uo_exception kuo_exception1)
		end try

		
	case KKG_FLAG_RICHIESTA.libero1	//chiude il tab
		u_close_tab()

	case else
		super::smista_funz(k_par_in)

end choose


//return k_return



end subroutine

private function long report_1_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
			
	
//		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_1_int_generica" 
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri()
	
	//--- view x estrazione 
			crea_view_x_report()
		
			leggi_dwc_barcode(0, kdw_1)
		
	//--- Aggiorna SQL della dw
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_int_artr"
			k_string = "vx_MAST2_int_artr"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 
		
				
			k_rc = kdw_1.settransobject ( sqlca )
			k_righe = kdw_1.retrieve()


		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
//			kuo_exception.messaggio_utente()

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe


	
	

end function

public subroutine u_set_tabpage_picture (boolean a_pic_ok);// = trim(ki_win_titolo_orig) + ".  " + trim(tab_1.tabpage_1.ddplb_report.text)
choose case ki_tab_1_index_new

	//case 1
	//	tab_1.tabpage_1.text = trim(tab_1.tabpage_1.ddplb_report.text)

	case 2
		if a_pic_ok then
			tab_1.tabpage_2.picturename = "Regenerate5!"
		else
			tab_1.tabpage_2.picturename = ""
		end if

	case 3
		if a_pic_ok then
			tab_1.tabpage_3.picturename = "Regenerate5!"
		else
			tab_1.tabpage_3.picturename = ""
		end if

	case 4
		if a_pic_ok then
			tab_1.tabpage_4.picturename = "Regenerate5!"
		else
			tab_1.tabpage_4.picturename = ""
		end if

	case 5
		if a_pic_ok then
			tab_1.tabpage_5.picturename = "Regenerate5!"
		else
			tab_1.tabpage_5.picturename = ""
		end if

	case 6
		if a_pic_ok then
			tab_1.tabpage_6.picturename = "Regenerate5!"
		else
			tab_1.tabpage_6.picturename = ""
		end if

	case 7
		if a_pic_ok then
			tab_1.tabpage_7.picturename = "Regenerate5!"
		else
			tab_1.tabpage_7.picturename = ""
		end if

	case 8
		if a_pic_ok then
			tab_1.tabpage_8.picturename = "Regenerate5!"
		else
			tab_1.tabpage_8.picturename = ""
		end if

	case 9
		if a_pic_ok then
			tab_1.tabpage_9.picturename = "Regenerate5!"
		else
			tab_1.tabpage_9.picturename = ""
		end if


	case else  

		
end choose

end subroutine

private subroutine u_report_run () throws uo_exception;//
try
	choose case ki_tab_1_index_new
	
		//case 1
		//	tab_1.tabpage_1.text = trim(tab_1.tabpage_1.ddplb_report.text)
	
		case 2
			if left(tab_1.tabpage_2.text,6) = "Report" or tab_1.tabpage_2.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_2.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_2.dw_2)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_3.visible then
					tab_1.tabpage_3.picturename = "VCRNext!"
					tab_1.tabpage_3.text = "Report ?"
					tab_1.tabpage_3.visible = true
				end if
			end if
	
		case 3
			if left(tab_1.tabpage_3.text,6) = "Report" or tab_1.tabpage_3.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_3.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_3.dw_3)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_4.visible then
					tab_1.tabpage_4.picturename = "VCRNext!"
					tab_1.tabpage_4.text = "Report ?"
					tab_1.tabpage_4.visible = true
				end if
			end if
	
		case 4
			if left(tab_1.tabpage_4.text,6) = "Report" or tab_1.tabpage_4.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_4.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_4.dw_4)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_5.visible then
					tab_1.tabpage_5.picturename = "VCRNext!"
					tab_1.tabpage_5.text = "Report ?"
					tab_1.tabpage_5.visible = true
				end if
			end if
	
		case 5
			if left(tab_1.tabpage_5.text,6) = "Report" or tab_1.tabpage_5.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_5.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_5.dw_5)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_6.visible then
					tab_1.tabpage_6.picturename = "VCRNext!"
					tab_1.tabpage_6.text = "Report ?"
					tab_1.tabpage_6.visible = true
				end if
			end if
	
		case 6
			if left(tab_1.tabpage_6.text,6) = "Report" or tab_1.tabpage_6.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_6.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_6.dw_6)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_7.visible then
					tab_1.tabpage_7.picturename = "VCRNext!"
					tab_1.tabpage_7.text = "Report ?"
					tab_1.tabpage_7.visible = true
				end if
			end if
	
		case 7
			if left(tab_1.tabpage_7.text,6) = "Report" or tab_1.tabpage_7.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_7.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_7.dw_7)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_8.visible then
					tab_1.tabpage_8.picturename = "VCRNext!"
					tab_1.tabpage_8.text = "Report ?"
					tab_1.tabpage_8.visible = true
				end if
			end if
	
		case 8
			if left(tab_1.tabpage_8.text,6) = "Report" or tab_1.tabpage_8.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_8.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_8.dw_8)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_9.visible then
					tab_1.tabpage_9.picturename = "VCRNext!"
					tab_1.tabpage_9.text = "Report ?"
					tab_1.tabpage_9.visible = true
				end if
			end if
	
		case 9
			if left(tab_1.tabpage_9.text,6) = "Report" or tab_1.tabpage_9.text = trim(tab_1.tabpage_1.ddplb_report.text) then
				tab_1.tabpage_9.text = trim(tab_1.tabpage_1.ddplb_report.text) 
				u_report_run_1(tab_1.tabpage_9.dw_9)
				if u_get_idx_report_vuoto() = 0 and not tab_1.tabpage_2.visible then
					tab_1.tabpage_2.picturename = "VCRNext!"
					tab_1.tabpage_2.text = "Report ?" 
					tab_1.tabpage_2.visible = true
				end if
			end if
	
	
		case else  
	
			
	end choose

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try

end subroutine

private subroutine u_report_run_1 (uo_d_std_1 kdw_1) throws uo_exception;//
long k_righe


try

	choose case ki_scelta_report 
	
		case ki_scelta_report_lotti_entrati
			k_righe = report_7_inizializza(kdw_1)
	
		case ki_scelta_report_generico
			k_righe = report_1_inizializza(kdw_1)
	
		case ki_scelta_report_coda_pilota
			k_righe = report_2_inizializza(kdw_1)
			
		case ki_scelta_report_in_trattamento
			k_righe = report_3_inizializza(kdw_1)
			
		case ki_scelta_report_trattato
			k_righe = report_4_inizializza(kdw_1)
			
		case ki_scelta_report_RegArt50
			k_righe = report_9_inizializza(kdw_1)
			
		case ki_scelta_report_chk_intra
			k_righe = report_5_inizializza(kdw_1)
	
		case ki_scelta_report_lotti_in_giacenza
			k_righe = report_6_inizializza(kdw_1)
	
		case ki_scelta_report_lotti_in_giacenza_gia_trattati
			k_righe = report_8_inizializza(kdw_1)
			
		case ki_scelta_report_lotti_da_sped
			k_righe = report_10_inizializza(kdw_1)
			
		case ki_scelta_report_lotti_sped
			k_righe = report_11_inizializza(kdw_1)
			
		case ki_scelta_report_etichette_lotti
			k_righe = report_12_inizializza(kdw_1)

		case ki_scelta_report_groupage
			k_righe = report_13_inizializza(kdw_1)

		case ki_scelta_report_etichettine
			k_righe = report_14_inizializza(kdw_1)
			
		case ki_scelta_report_bcode_trattati
			k_righe = report_15_inizializza(kdw_1)
			
		case ki_scelta_report_art_movim //"Movimenti Articoli
			k_righe = report_16_inizializza(kdw_1)
			
//		case ki_scelta_report_armo_prezzi //"voci lotto in armo_prezzi
//			k_righe = report_17_inizializza(kdw_1)

		case ki_scelta_report_memo //Cerca su MEMO
			k_righe = report_18_inizializza(kdw_1)

		case ki_scelta_report_lotti_sped_daFatt //lotti sped da fatt
			k_righe = report_19_inizializza(kdw_1)

		case ki_scelta_report_attestati //Attestati
			k_righe = report_20_inizializza(kdw_1)

		case ki_scelta_report_armo_contratti // Contratti entrati
			k_righe = report_21_inizializza(kdw_1)

		case ki_scelta_report_LavxCapitolato // Capitolati di fornitura
			k_righe = report_22_inizializza(kdw_1)

		case ki_scelta_report_runsrtrrts // dati RUNS+RTR+RTS
			k_righe = report_23_inizializza(kdw_1)

		case ki_scelta_report_prevfinelav // Previsione INIZ-FINE lavorazione Lotti nel Pilota in Impianto 
			k_righe = report_24_inizializza(kdw_1)
	
		case else
			kdw_1.visible = false
			
	end choose

catch (uo_exception kuo_exception)
	kdw_1.reset( )
	throw kuo_exception

finally
	
	if isvalid(kdw_1) then
		kdw_1.event u_personalizza_dw()
	end if
	
	if k_righe > 0 then
//		u_set_titolo_tab( )
		u_set_tabpage_picture(false)
//	else
//		u_set_tabpage_picture(true)
	end if
	
	kdw_1.enabled = true
	kdw_1.visible = true
	
end try

////--- Imposto campi x link standar
//	kdw_1.link_standard_imposta()

end subroutine

protected subroutine attiva_menu ();//--- Chiude scheda
if ki_tab_1_index_new > 1 then

	if not ki_menu.m_strumenti.m_fin_gest_libero1.enabled or not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =	"Chiudi, Chiudi scheda Selezionata  "
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = kGuo_path.get_risorse() + "\Cancel16.ico"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Cancel16.png"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	end if		

else
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
end if
//---
	super::attiva_menu()


end subroutine

public subroutine u_close_tab ();//
//--- close il tab cliccato
//
int	k_inizio 
int	k_fine  
int k_ctr

	setredraw (false)

	choose case ki_tab_1_index_new
//		case 1
//			tab_1.tabpage_1.dw_1.reset( )
//			//tab_1.tabpage_1.dw_1.enabled = false
//			tab_1.tabpage_1.visible = false
		case 2
			tab_1.tabpage_2.dw_2.reset( )
			//tab_1.tabpage_2.dw_2.enabled = false
			tab_1.tabpage_2.visible = false
		case 3
			tab_1.tabpage_3.dw_3.reset( )
			//tab_1.tabpage_3.dw_3.enabled = false
			tab_1.tabpage_3.visible = false
		case 4
			tab_1.tabpage_4.dw_4.reset( )
			//tab_1.tabpage_4.dw_4.enabled = false
			tab_1.tabpage_4.visible = false
		case 5
			tab_1.tabpage_5.dw_5.reset( )
			//tab_1.tabpage_5.dw_5.enabled = false
			tab_1.tabpage_5.visible = false
		case 6
			tab_1.tabpage_6.dw_6.reset( )
			//tab_1.tabpage_6.dw_6.enabled = false
			tab_1.tabpage_6.visible = false
		case 7
			tab_1.tabpage_7.dw_7.reset( )
			//tab_1.tabpage_7.dw_7.enabled = false
			tab_1.tabpage_7.visible = false
		case 8
			tab_1.tabpage_8.dw_8.reset( )
			//tab_1.tabpage_8.dw_8.enabled = false
			tab_1.tabpage_8.visible = false
		case 9
			tab_1.tabpage_9.dw_9.reset( )
			//tab_1.tabpage_9.dw_9.enabled = false
			tab_1.tabpage_9.visible = false
	end choose
		
//--- dopo la close si posiziona sulla successiva (precedente/successiva)
	k_inizio = ki_tab_1_index_new - 1
	k_fine = 1 
	for k_ctr = k_inizio to k_fine STEP -1 
		
		choose case k_ctr
			case 1
				if tab_1.tabpage_1.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(1)
					exit
				end if
			case 2
				if tab_1.tabpage_2.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(2)
					exit
				end if
			case 3
				if tab_1.tabpage_3.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(3)
					exit
				end if
			case 4
				if tab_1.tabpage_4.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(4)
					exit
				end if
			case 5
				if tab_1.tabpage_5.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(5)
					exit
				end if
			case 6
				if tab_1.tabpage_6.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(6)
					exit
				end if
			case 7
				if tab_1.tabpage_7.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(7)
					exit
				end if
			case 8
				if tab_1.tabpage_8.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(8)
					exit
				end if
			case 9
				if tab_1.tabpage_9.visible then
					k_fine=0 // x evitare l'altro choose
					tab_1.selecttab(9)
					exit
				end if
		end choose
		
	next
	
	if k_fine > 0 then
		k_fine = 9
		for k_ctr = k_inizio to k_fine  
			
			choose case k_ctr
				case 1
					if tab_1.tabpage_1.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(1)
						exit
					end if
				case 2
					if tab_1.tabpage_2.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(2)
						exit
					end if
				case 3
					if tab_1.tabpage_3.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(3)
						exit
					end if
				case 4
					if tab_1.tabpage_4.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(4)
						exit
					end if
				case 5
					if tab_1.tabpage_5.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(5)
						exit
					end if
				case 6
					if tab_1.tabpage_6.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(6)
						exit
					end if
				case 7
					if tab_1.tabpage_7.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(7)
						exit
					end if
				case 8
					if tab_1.tabpage_8.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(8)
						exit
					end if
				case 9
					if tab_1.tabpage_9.visible then
						k_fine=0 // x dire ho trovato
						tab_1.selecttab(9)
						exit
					end if
			end choose
		
		next
	end if
//
////--- se non ho trovato alcuna scheda chiudo!
//	if k_fine > 0 then
//		post close(this)
//	end if
//
	setredraw (true)


end subroutine

private function integer u_get_idx_report_vuoto ();//
int k_return


	choose case true

		case tab_1.tabpage_1.text = "Report ?"
			k_return = 1
		case tab_1.tabpage_2.text = "Report ?" 
			k_return = 2
		case tab_1.tabpage_3.text = "Report ?" 
			k_return = 3
		case tab_1.tabpage_4.text = "Report ?" 
			k_return = 4
		case tab_1.tabpage_5.text = "Report ?" 
			k_return = 5
		case tab_1.tabpage_6.text = "Report ?" 
			k_return = 6
		case tab_1.tabpage_7.text = "Report ?" 
			k_return = 7
		case tab_1.tabpage_8.text = "Report ?" 
			k_return = 8
		case tab_1.tabpage_9.text = "Report ?" 
			k_return = 9
		case else  
	
			
	end choose

return k_return

end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe



super::attiva_tasti_0()

cb_ritorna.enabled = true
//cb_inserisci.enabled = true
//cb_aggiorna.enabled = true
//cb_cancella.enabled = true

cb_ritorna.default = false
//cb_inserisci.default = false
//cb_aggiorna.default = false
//cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
//		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//			cb_inserisci.enabled = true
//			cb_inserisci.default = true
//			cb_cancella.enabled = false
//			cb_aggiorna.enabled = false
//		end if
//	case 2
//		if kdw_1.rowcount() = 0 then
//			cb_inserisci.enabled = true
//			cb_inserisci.default = true
//			cb_aggiorna.enabled = false
//			cb_cancella.enabled = false
//		end if
//	case 3
//		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//			cb_inserisci.enabled = true
//			cb_inserisci.default = true
//			cb_aggiorna.enabled = false
//			cb_cancella.enabled = false
//		end if
//	case 4
//		if tab_1.tabpage_4.dw_4.rowcount() = 0 then
//			cb_inserisci.enabled = true
//			cb_inserisci.default = true
//			cb_cancella.enabled = false
//			cb_aggiorna.enabled = false
//		end if
end choose
            


end subroutine

private subroutine report_22 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
date k_data_ini, k_data_fin, k_data


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_22" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_22"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)
	
	if u_dw_selezione_ripri( ) = 0 then
		tab_1.tabpage_1.dw_1.insertrow(0)
	end if
	k_data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini")
	k_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin")

//--- prendi data oggi		
	k_data = kguo_g.get_dataoggi( )
	
	if k_data_ini > date(0) then
	else
		k_data_ini = relativedate(k_data, -120)
		tab_1.tabpage_1.dw_1.setitem(1, "data_ini", k_data_ini)
	end if
	if k_data_fin > date(0) then
	else
		k_data_fin = k_data
		tab_1.tabpage_1.dw_1.setitem(1, "data_fin", k_data_fin)
	end if
		
end if	
attiva_tasti()
		
//return "0"

	



end subroutine

public subroutine u_dw_selezione_save ();//---
//--- Salva i dati del DW di selezione
//---
string k_parametri

k_parametri = trim(tab_1.tabpage_1.dw_1.dataobject)
if k_parametri > " " then
	kGuf_data_base.dw_salva_righe(k_parametri, tab_1.tabpage_1.dw_1)
end if

end subroutine

public function integer u_dw_selezione_ripri ();//---
//--- Ripristina i dati del DW di selezione
//---
int k_return
string k_parametri

k_parametri = trim(tab_1.tabpage_1.dw_1.dataobject)
if k_parametri > " " then
	k_return = kGuf_data_base.dw_ripri_righe(k_parametri, tab_1.tabpage_1.dw_1)
end if

return k_return
end function

private subroutine report_0 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
	tab_1.tabpage_1.dw_1.dataobject = "d_report_0"
	tab_1.tabpage_1.dw_1.insertrow(0)
	
end subroutine

public subroutine u_resize_1 ();//
//=== Se tab_1 e visible oppure sono in prima volta
//if tab_1.visible = true or ki_st_open_w.flag_primo_giro = 'S' then

	if tab_1.visible then
		this.setredraw(false)
	end if

//=== Dimensione dw nella window 
	tab_1.width = this.width //- 90
	tab_1.height = this.height //- 200
//=== Posiziona dw nella window 
	tab_1.x = (this.width - tab_1.width) / 4
	tab_1.y = (this.height - tab_1.height) / 7


//--- PERSONALIZZATA
	tab_1.tabpage_1.st_report.width = tab_1.tabpage_1.width / 2 - 100
	tab_1.tabpage_1.st_report.height = 90
	tab_1.tabpage_1.st_report.x =  10
	tab_1.tabpage_1.st_report.y =  10
	tab_1.tabpage_1.ddplb_report.width = 1050 //tab_1.tabpage_1.width - tab_1.tabpage_1.st_report.width - 100
	tab_1.tabpage_1.ddplb_report.height = tab_1.tabpage_1.height // tab_1.tabpage_1.st_report.height
	tab_1.tabpage_1.ddplb_report.x = 5 //tab_1.tabpage_1.x + tab_1.tabpage_1.st_report.width + 50
	tab_1.tabpage_1.ddplb_report.y = 5
	
	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - 10 - tab_1.tabpage_1.ddplb_report.width //tab_1.tabpage_1.width - 10
	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height //tab_1.tabpage_1.height - tab_1.tabpage_1.st_report.height - 130
	tab_1.tabpage_1.dw_1.x = tab_1.tabpage_1.ddplb_report.width + tab_1.tabpage_1.ddplb_report.x //(tab_1.tabpage_1.width - tab_1.tabpage_1.dw_1.width) / 2
	tab_1.tabpage_1.dw_1.y = tab_1.tabpage_1.ddplb_report.y //tab_1.tabpage_1.st_report.y + 150 //(tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.height) / 2



//=== Dimensiona dw nel tab
//		case 2
			tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - 10
			tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height - 30
			tab_1.tabpage_2.dw_2.x = (tab_1.tabpage_2.width - tab_1.tabpage_2.dw_2.width) / 2
			tab_1.tabpage_2.dw_2.y = (tab_1.tabpage_2.height - tab_1.tabpage_2.dw_2.height) / 2
//		case 3
			tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - 10
			tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - 30
			tab_1.tabpage_3.dw_3.x = (tab_1.tabpage_3.width - tab_1.tabpage_3.dw_3.width) / 2
			tab_1.tabpage_3.dw_3.y = (tab_1.tabpage_3.height - tab_1.tabpage_3.dw_3.height) / 2
///	case 4
			tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - 10
			tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - 30
			tab_1.tabpage_4.dw_4.x = (tab_1.tabpage_4.width - tab_1.tabpage_4.dw_4.width) / 2
			tab_1.tabpage_4.dw_4.y = (tab_1.tabpage_4.height - tab_1.tabpage_4.dw_4.height) / 2
///	case 4
			tab_1.tabpage_5.dw_5.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_5.dw_5.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_5.dw_5.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_5.dw_5.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
///	case 4
			tab_1.tabpage_6.dw_6.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_6.dw_6.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_6.dw_6.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_6.dw_6.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
///	case 4
			tab_1.tabpage_7.dw_7.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_7.dw_7.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_7.dw_7.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_7.dw_7.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
///	case 4
			tab_1.tabpage_8.dw_8.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_8.dw_8.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_8.dw_8.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_8.dw_8.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
///	case 4
			tab_1.tabpage_9.dw_9.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_9.dw_9.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_9.dw_9.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_9.dw_9.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
//	end choose
	
	tab_1.visible = true
	
	this.setredraw(true)
//end if




end subroutine

private function long report_22_inizializza (uo_d_std_1 kdw_1) throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta, k_codice_prec
string k_sql_orig, k_stringn, k_string
long k_righe=0, k_ctr, k_rc
kuf_utility kuf1_utility


	try
			
	
		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if trim(k_codice_prec) =  "" or kdw_1.rowcount() = 0 then //<> k_codice_prec then

			kdw_1.visible = true
			kdw_1.dataobject = "d_report_22_capitolato"
			k_rc = kdw_1.settransobject(sqlca)

	//--- piglia i parametri per l'estrazione 
			get_parametri_22()
	
	//--- view x estrazione 
			crea_view_x_report_22()

	//--- Aggiorna SQL della dw	
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_report_22"
			k_string = "vx_MAST2_report_22"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 

			k_righe = kdw_1.retrieve(kist_int_artr.sc_cf )

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try


return k_righe

end function

private subroutine get_parametri_22 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_fin, k_data_ini
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//--- piglia param dalla window
k_data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini") 
k_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin") 
if k_data_ini > k_data_fin  then
	kGuo_exception.inizializza( )
	kGuo_exception.setmessage("Dati incongruenti", "Data fine maggiore di data inizio valore non ammesso,~n~rcorreggere i valori")
	throw kGuo_exception 
end if

kist_int_artr.data_ini = k_data_ini
kist_int_artr.data_fin = k_data_fin

kist_int_artr.sc_cf = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "sc_cf"))
if kist_int_artr.sc_cf > " " then
else
	kist_int_artr.sc_cf = ""
end if

//kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Cliente
//if isnull(kist_int_artr.clie_3) then
//	kist_int_artr.clie_3 = 0
//end if


end subroutine

private subroutine crea_view_x_report_22 ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
kuf_armo kuf1_armo
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

select min(id_meca), max(id_meca)
   into :kist_int_artr.id_meca_ini
   	 ,:kist_int_artr.id_meca_fin
   from barcode 
   where data_lav_fin between :kist_int_artr.data_ini and :kist_int_artr.data_fin
	using kguo_sqlca_db_magazzino;

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_22 "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo ) AS   " 
	 
	k_sql += &
			" SELECT  armo.id_armo  FROM " &
			+ " armo  "  &
			+ " WHERE  " 

	k_sql += &
	 		 " id_meca between " + string(kist_int_artr.id_meca_ini) + " and " + string(kist_int_artr.id_meca_fin) 
	
	k_sql += &
			" group by  armo.id_armo "

	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)


end subroutine

public function integer u_report_selezionato ();//---
//--- torna il numero del report selezionato (passare il titolo del DW come argomento)
//---
int k_return
string k_dw_titolo = ""

	k_dw_titolo = u_report_selezionato_title( )

	if isnumber(mid(k_dw_titolo,1,1)) then 
		if isnumber(mid(k_dw_titolo,2,1)) then 
			k_return = integer(left(k_dw_titolo,2))
		else
			k_return = integer(left(k_dw_titolo,1))
		end if
	end if

return k_return
end function

public function string u_report_selezionato_title ();//---
//--- torna il TITOLO del report selezionato 
//---
string k_dw_titolo

	choose case ki_tab_1_index_new
		case 2
			k_dw_titolo = trim(tab_1.tabpage_2.text)
		case 3
			k_dw_titolo = trim(tab_1.tabpage_3.text)
		case 4
			k_dw_titolo = trim(tab_1.tabpage_4.text)
		case 5
			k_dw_titolo = trim(tab_1.tabpage_5.text)
		case 6
			k_dw_titolo = trim(tab_1.tabpage_6.text)
		case 7
			k_dw_titolo = trim(tab_1.tabpage_7.text)
		case 8
			k_dw_titolo = trim(tab_1.tabpage_8.text)
		case 9
			k_dw_titolo = trim(tab_1.tabpage_9.text)
	end choose

return k_dw_titolo
end function

private subroutine leggi_dwc_gruppi (ref datawindow k_dw);//
datawindowchild kdwc_1
long k_id_gruppo, k_riga
int k_rc


if isvalid(k_dw) then 

	k_rc = k_dw.getchild("id_gruppo", kdwc_1)
	if k_rc > 0 then
		kdwc_1.settransobject(sqlca)
		if kdwc_1.rowcount() < 2 then
			kdwc_1.retrieve()
			kdwc_1.insertrow(1)
		end if	
	
		k_id_gruppo = k_dw.getitemnumber(1, "id_gruppo")
		if k_id_gruppo > 0 then
			k_riga=kdwc_1.find("codice = "+string(k_id_gruppo),	0, kdwc_1.rowcount())
			if k_riga > 0 then
	//			k_dw.setitem(1, "id_gruppo", kdwc_1.getitemnumber(k_riga, "codice"))
				k_dw.setitem(1, "descrizione", kdwc_1.getitemstring(k_riga, "des"))
			else
				k_dw.setitem(1, "descrizione", "")
			end if
		else
			k_dw.setitem(1, "descrizione", "")
		end if
	end if
end if

end subroutine

private subroutine leggi_gru_no_stat (ref datawindow k_dw);//
datawindowchild kdwc_1


if isvalid(k_dw) then 

	k_dw.getchild("gru_no_stat", kdwc_1)
	kdwc_1.settransobject(sqlca)
	if kdwc_1.rowcount() < 2 then
		kdwc_1.retrieve()
		kdwc_1.insertrow(1)
	end if	

end if

end subroutine

private subroutine crea_view_x_report_7 () throws uo_exception;//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_campi
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_7 "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
            + ", id_meca integer " 
	k_sql += &
			" SELECT  armo.id_armo, armo.id_meca  FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " 
			
	if kist_int_artr.gru_attiva = 1 then
		k_sql += &
			  " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " 
			if kist_int_artr.gru_flag = 2 then  // no ai gruppi indicato come NO STAT in tabella
				k_sql += &
					+ " inner JOIN gru " &
					+ " ON prodotti.gruppo = gru.codice " 
			end if
	end if
	k_sql += " WHERE  " 
	if kist_int_artr.num_int > 0 then
		k_sql += &
	 		 " meca.id = " + string(kist_int_artr.id_meca_ini)
	else
		if kist_int_artr.non_entrati = "S" then
			k_sql += " (meca.data_ent is null or meca.data_ent <  '" + string(kguo_g.get_datetime_zero( )) + "') "
		else
			k_sql += &
				+ " meca.id between " + string(kist_int_artr.id_meca_ini) + " and " + string(kist_int_artr.id_meca_fin) + " " &
			   + " and meca.data_ent between '" + string(datetime(kist_int_artr.data_da)) + "' and '" + string(datetime(kist_int_artr.data_a, time("23:59:59"))) +"'  "
		end if
		if kist_int_artr.clie_3 > 0 then
			k_sql += &
				 "and meca.clie_3 = " + string(kist_int_artr.clie_3)
		end if
	end if
	if kist_int_artr.gru_attiva = 1 then
		if kist_int_artr.gru_flag = 1 or kist_int_artr.gru_flag = 0 then  // solo un gruppo puntuale
			if kist_int_artr.gru > 0 then
				if kist_int_artr.gru_flag = 1 then  // includi solo un gruppo puntuale
					k_sql += " and prodotti.gruppo = " + string(kist_int_artr.gru) + " "
				else  // Ecludi solo un gruppo puntuale
					k_sql += " and prodotti.gruppo <> " + string(kist_int_artr.gru) + " "
				end if
			end if
		else
			 // escludi tutti quelli da Escludere x stat
			k_sql += &
			  " and gru.escludi_da_stat_glob = 'N' "// tutti i gruppi (meno quelli da Escludere x stat)
		end if
	end if	
	k_sql += &
			" group by  armo.id_armo, armo.id_meca "

	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)


end subroutine

private subroutine get_parametri_23 () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_dataoggix
date  k_data_a, k_data_da, k_dataoggi
kuf_armo kuf1_armo
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca_da, kst_tab_meca_a
st_esito kst_esito


try

	//=== Puntatore Cursore da attesa.....
	//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
	SetPointer(kkg.pointer_attesa)
	
	k_dataoggi = kg_dataoggi

	kuf1_armo = create kuf_armo
	
	//--- piglia param dalla window
	kist_int_artr.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int") //data riferimento da
	if isnull(kist_int_artr.num_int)  then
		kist_int_artr.num_int = 0
	end if
	kist_int_artr.anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno") //data riferimento da
	if isnull(kist_int_artr.anno) then
		kist_int_artr.anno = year(kg_dataoggi)
	end if
	kist_int_artr.id_meca_ini = 0
	if kist_int_artr.num_int > 0 then
		kst_tab_armo.num_int = kist_int_artr.num_int
		kst_tab_armo.data_int = date(kist_int_artr.anno,01,01)
		kst_esito=kuf1_armo.get_id_meca(kst_tab_armo)
	//=== Controllo esito riferimento
		if kst_esito.esito <> kkg_esito.ok then
			kGuo_exception.setmessage("Riferimento non in archivio!")
			throw kGuo_exception 
		end if
		
		if kst_tab_armo.id_meca > 0 then
			kist_int_artr.id_meca_ini = kst_tab_armo.id_meca 
		end if
		
	else
	
		k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data riferimento a
		if isnull(k_data_da) or k_data_da = date(0) or k_data_da = date("01/01/1900") or k_data_da = date("00/00/0000") then
			k_data_da = k_dataoggi
		end if
		kist_int_artr.data_da = k_data_da
	
		k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
		if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") or k_data_a = date("00/00/0000") then
			k_data_a = k_dataoggi
		end if
		kist_int_artr.data_a = k_data_a
		
		if k_data_a >= k_data_da then
//--- get del range ID meca dal periodo impostato	
			kst_tab_meca_da.data_ent = datetime(relativedate(k_data_da, -365), time('00:00:00.000001'))
			kst_tab_meca_a.data_ent = datetime(k_data_a, time('23:59:59.000000'))
			kuf1_armo.get_id_meca_min_max_x_data_ent(kst_tab_meca_da, kst_tab_meca_a)
			kist_int_artr.id_meca_ini = kst_tab_meca_da.id
//			kist_int_artr.id_meca_fin = kst_tab_meca_a.id
		end if
	end if
	
	kist_int_artr.clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_clie_3") //Fatturato
	if isnull(kist_int_artr.clie_3) then
		kist_int_artr.clie_3 = 0
	end if
	
	kist_int_artr.gru = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo") //codice gruppo
	if isnull(kist_int_artr.gru) then
		kist_int_artr.gru = 0
	end if
	kist_int_artr.gru_flag = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_flag") //flag tipo estrazione gruppo
	if isnull(kist_int_artr.gru_flag) then
		kist_int_artr.gru_flag = 2
	end if
	kist_int_artr.gru_attiva = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_attiva") //flag attiva/disattiva estrazione gruppo
	if isnull(kist_int_artr.gru_attiva) then
		kist_int_artr.gru_attiva = 0
	end if
	
	set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	
	
	//=== Controllo date
	if (k_data_a > date(0) and k_data_a < k_data_da) then
		kGuo_exception.inizializza( )
		kGuo_exception.set_tipo(kGuo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
		kGuo_exception.setmessage("Controlla le date immesse,~n~r data di fine periodo e' minore di quella di inizio")
		throw kGuo_exception 
	else
		if	kist_int_artr.id_meca_ini = 0 then
			kGuo_exception.inizializza( )
			kGuo_exception.set_tipo(kGuo_exception.kk_st_uo_exception_tipo_dati_non_eseguito)
			kGuo_exception.setmessage("Nessun Lotto trovato per il periodo richiesto (" + string(kist_int_artr.id_meca_ini) + " - " + string(kist_int_artr.id_meca_fin) + ")") 
			throw kGuo_exception 
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	SetPointer(kkg.pointer_default)
	
end try



end subroutine

private subroutine report_23 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_importa, k_importato, k_importato_ora
date k_data, k_data_da, k_data_a
long  k_clie_3
string k_rag_soc
datawindowchild  kdwc_cliente_3  //kdwc_dose,
datawindowchild   kdwc_cliente_3_C
kuf_base kuf1_base


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_23" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_23"
	tab_1.tabpage_1.dw_1.settransobject(sqlca)

	if u_dw_selezione_ripri( ) = 0 then
		tab_1.tabpage_1.dw_1.insertrow(0)
	end if

	k_scelta = trim(ki_st_open_w.flag_modalita)
	if isdate(trim(ki_st_open_w.key8)) then
		k_data_da = date(trim(ki_st_open_w.key8)) //data riferimento da
	end if
	if isdate(trim(ki_st_open_w.key9)) then
		k_data_a = date(trim(ki_st_open_w.key9)) //data riferimento a
	end if
	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente_3)
	tab_1.tabpage_1.dw_1.getchild("clie_3_1", kdwc_cliente_3_c)

	kdwc_cliente_3.settransobject(sqlca)
	kdwc_cliente_3_c.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		kdwc_cliente_3.retrieve("%")
		kdwc_cliente_3.insertrow(1)
		kdwc_cliente_3.RowsCopy(1, kdwc_cliente_3.RowCount(), Primary!, kdwc_cliente_3_c, 1, Primary!)

	end if
	
	tab_1.tabpage_1.dw_1.setfocus()

//--- Setta valori di Default

	if k_clie_3 > 0 then
		if kdwc_cliente_3.rowcount() < 2 then
			kdwc_cliente_3.insertrow(0)
		end if
	end if

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
		tab_1.tabpage_1.dw_1.setitem(1, "report", 1)
//--- prendi data oggi		
		k_data = kguo_g.get_dataoggi( )

		tab_1.tabpage_1.dw_1.setitem(1, "num_int", 0)

		kist_int_artr.anno = tab_1.tabpage_1.dw_1.getitemnumber(1, "anno")
		if kist_int_artr.anno = 0 or isnull(kist_int_artr.anno ) then
			tab_1.tabpage_1.dw_1.setitem(1, "anno", year(kg_dataoggi))
		end if
		
		if k_data_da > kkg.data_zero then
		else
			k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")
			if k_data_da > kkg.data_zero then
			else
				k_data_da = relativedate(k_data, -60)
			end if
		end if
		if k_data_a > kkg.data_zero then
		else
			k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")
			if k_data_a > kkg.data_zero then
			else
				k_data_a = k_data
			end if
		end if
		if k_data_da > kkg.data_zero then
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
		else
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", "00/00/00")
		end if
		if k_data_a = kkg.data_zero then
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
		else
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", "00/00/00")
		end if

		kist_int_artr.gru_attiva = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_attiva")
		if kist_int_artr.gru_attiva >= 0 then
		else
			tab_1.tabpage_1.dw_1.setitem(1, "gruppo_attiva", 1)
		end if
			
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
	end try
end if
			
attiva_tasti()
	
//return "0"

	



end subroutine

private function long report_23_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//string k_scelta
string k_codice_prec
string k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_errore=false
long k_righe=0, k_ctr, k_rc
datawindowchild kdwc_barcode
//datawindowchild kdwc_cliente, kdwc_cliente_2, kdwc_cliente_3
kuf_utility kuf1_utility
kuf_base kuf1_base


	try
				
//		k_scelta = trim(ki_st_open_w.flag_modalita)

	
	//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
		if not isnull(kdw_1.tag) then
			k_codice_prec = kdw_1.tag
		else
			k_codice_prec = " "
		end if
	
	//--- salvo i parametri cosi come sono stati immessi
		kuf1_utility = create kuf_utility
		kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
		destroy kuf1_utility

		if trim(k_codice_prec) <> trim(kdw_1.tag) then
			u_set_tabpage_picture(true)
		else
			u_set_tabpage_picture(false)
		end if
	
		if kdw_1.rowcount() = 0 or trim(k_codice_prec) =  "" then //<> k_codice_prec then

	//--- piglia i parametri per l'estrazione 
			get_parametri_23()

			kdw_1.dataobject = "d_report_23_runs_rtr_rts" 
			k_rc = kdw_1.settransobject(sqlca)
			kdw_1.visible = true
	
	//--- view x estrazione 
			crea_view_x_report_23_runsrtrrts()

	//--- Aggiorna SQL della dw	
			k_sql_orig = kdw_1.Object.DataWindow.Table.Select 
			k_stringn = "vx_" + trim(kist_int_artr.utente) + "_report_23_runs_rtr_rts"
			k_string = "vx_MAST2_report_23_runs_rtr_rts"
			k_ctr = PosA(k_sql_orig, k_string, 1)
			DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
				k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
				k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
			LOOP
			kdw_1.Object.DataWindow.Table.Select = k_sql_orig 
		
				
			k_rc = kdw_1.settransobject ( sqlca )
			k_righe = kdw_1.retrieve()

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
//			kuo_exception.messaggio_utente()

	finally		
		attiva_tasti()
		if kdw_1.rowcount() = 0 then
			kdw_1.insertrow(0) 
		end if
		kdw_1.setfocus()

	end try

return k_righe
	

end function

private subroutine crea_view_x_report_23_runsrtrrts () throws uo_exception;//======================================================================
//=== Crea le View per le query
//======================================================================
//
string k_view, k_sql, k_campi



//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_attesa)

//--- costruisco la view con ID_MECA da estrarre
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23 "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
            + ", id_meca integer " 
	k_sql += &
			" SELECT  armo.id_armo, armo.id_meca  FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
			
	k_sql += " WHERE  " 
	if kist_int_artr.num_int > 0 then
		k_sql += &
	 		 " meca.id = " + string(kist_int_artr.id_meca_ini)
	else
		k_sql += &
			+ " certif.data between '" + string(kist_int_artr.data_da) + "' and '" + string(kist_int_artr.data_a) + "' " &
		
		if kist_int_artr.clie_3 > 0 then
			k_sql += &
				 "and meca.clie_3 = " + string(kist_int_artr.clie_3)
		end if
	end if
	k_sql += &
			" group by  armo.id_armo, armo.id_meca "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      


	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_xgru "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo, id_meca ) AS   " 
   k_campi = "id_armo integer " & 
            + ", id_meca integer " 
	k_sql += &
			" SELECT report_23.id_armo, report_23.id_meca  FROM " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23 as report_23 "  
	if kist_int_artr.gru_attiva = 1 then
		k_sql += &
			 " inner JOIN armo " &
			+ " ON report_23.id_meca = armo.id_meca " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " 
		if kist_int_artr.gru_flag = 1 or kist_int_artr.gru_flag = 0 then  // includi/escludi solo un gruppo puntuale
			if kist_int_artr.gru > 0 then
				k_sql += " WHERE  " 
				if kist_int_artr.gru_flag = 1 then  
					k_sql += " prodotti.gruppo = " + string(kist_int_artr.gru) + " " // includi solo un gruppo puntuale
				else  
					k_sql += " prodotti.gruppo <> " + string(kist_int_artr.gru) + " " // Ecludi solo un gruppo puntuale
				end if
			end if
		else
			 // escludi tutti quelli da Escludere x stat
			k_sql += &
			  " inner JOIN gru " &
			+ " ON prodotti.gruppo = gru.codice " &
			+ " WHERE  gru.escludi_da_stat_glob = 'N' "// tutti i gruppi (meno quelli da Escludere x stat)
		end if
	end if	
	k_sql += &
			" group by report_23.id_armo, report_23.id_meca "
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
//   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

//--- costruisco altre view  
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_trattati "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, runs, colli_trattati ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data), count(distinct meca.id), sum(artr.colli_trattati) FROM " &
			+ " armo  "  &
			+ " inner JOIN artr " &
			+ " ON armo.id_armo = artr.id_armo " &
			+ " inner JOIN meca " &
			+ " ON armo.id_meca = meca.id " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += &
	 		 " armo.id_meca in (select id_meca from " + "vx_" + trim(kist_int_artr.utente) + "_report_23 " + ")"
	k_sql += " group by  month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_etr_1 "   //End TO Release  (grezzo)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, etr_1 ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data) " & 
			+ " ,datediff( day, (select max(artr.data_fin) from artr where artr.num_certif = certif.num_certif), (certif.data) )  " & 
			+ " FROM " &
			+ " certif  "  
	k_sql += " WHERE  " 
	k_sql += &
	 		 " certif.id_meca in (select id_meca from " + "vx_" + trim(kist_int_artr.utente) + "_report_23_xgru " + ")"
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
	
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_etr "   //End TO Release  (media gg)
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, etr ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2), etr_1 )) " & 
			+ " FROM " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_etr_1 "
	k_sql += " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_rtr "   //Receive TO Release
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rtr ) AS   " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data), avg(convert(decimal(6,2),datediff(day, convert(date, data_ent), certif.data)))  FROM " &
			+ " meca  "  &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += &
	 		 " meca.id in (select id_meca from " + "vx_" + trim(kist_int_artr.utente) + "_report_23_xgru " + ")"
	k_sql += " group by month(certif.data), year(certif.data) " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_rts_1 "  //Receive TO Send
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rts_1 ) AS   " 
//   k_campi = "mese integer " &
//	          + ", anno integer " &
 //            + ", rts_1 decimal(6,3) " 
	k_sql += &
			" SELECT month(certif.data), year(certif.data), datediff(day, convert(date, meca.data_ent), max(arsp.data_bolla_out))  FROM " &
			+ " meca  "  &
			+ " inner JOIN armo " &
			+ " ON meca.id = armo.id_meca " &
			+ " inner JOIN arsp " &
			+ " ON armo.id_armo = arsp.id_armo " &
			+ " inner JOIN certif " &
			+ " ON meca.id = certif.id_meca " 
	k_sql += " WHERE  " 
	k_sql += &
	 		 " meca.id in (select id_meca from " + "vx_" + trim(kist_int_artr.utente) + "_report_23_xgru " + ")"
	k_sql += " group by month(certif.data), year(certif.data),  meca.data_ent " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		
   //kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_rts "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, rts ) AS   " 
	k_sql += &
			" SELECT mese, anno, avg(convert(decimal(6,2),rts_1))  FROM " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_rts_1 "  
	k_sql += " group by mese, anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

//--- View Finale riepilogativa 
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_runs_rtr_rts "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( mese, anno, colli_trattati, runs, rtr, rts, etr ) AS   " 
//   k_campi = "mese integer " &
//	          + ", anno integer " &
//             + ", runs integer " &
//             + ", colli_trattati integer " &
//             + ", rtr decimal(6,3) " &
//             + ", rts decimal(6,3)"  
	k_sql += &
			" SELECT runs.mese, runs.anno, runs.colli_trattati, runs.runs, rtr.rtr, rts.rts, etr.etr  FROM " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_trattati as runs"  &
			+ " left outer JOIN " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_rtr as rtr "  &
			+ " ON runs.mese = rtr.mese and runs.anno = rtr.anno " &
			+ " left outer JOIN " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_rts as rts "  &
			+ " ON runs.mese = rts.mese and runs.anno = rts.anno " &
			+ " left outer JOIN " &
			+ "vx_" + trim(kist_int_artr.utente) + "_report_23_etr as etr "  &
			+ " ON runs.mese = etr.mese and runs.anno = etr.anno " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		


//--- View Finale x il '?'
	k_view = "vx_" + trim(kist_int_artr.utente) + "_report_23_runsrtrrts_help "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " (id_meca, num_int, data_ent, data, data_bolla_out, num_bolla_out, data_fin, colli_trattati, rtr, rts, etr, gruppo ) AS   " 
	k_sql += &
			" SELECT meca.id, meca.num_int, meca.data_ent, certif.data " &
			+ ", max(arsp.data_bolla_out), max(arsp.num_bolla_out) " & 
			+ ", max(artr.data_fin), sum(artr.colli_trattati) " &
			+ ", datediff(day, convert(date, meca.data_ent), certif.data) " & 
			+ ", datediff(day, convert(date, meca.data_ent), max(arsp.data_bolla_out)) " &
			+ ", datediff(day, max(artr.data_fin), certif.data) " & 
			+ ", prodotti.gruppo " & 
			+ " FROM " &
			+ " vx_" + trim(kist_int_artr.utente) + "_report_23 as runs"  &
			+ " inner JOIN meca " &
			+ " ON runs.id_meca = meca.id "  &
			+ " inner JOIN artr " &
			+ " ON runs.id_armo = artr.id_armo "  &
			+ " inner JOIN armo " &
			+ " ON runs.id_armo = armo.id_armo " &
			+ " inner JOIN prodotti " &
			+ " ON armo.art = prodotti.codice " &
			+ " left outer JOIN  vx_" + trim(kist_int_artr.utente) + "_report_23_xgru as runs_xgru"  &
			+ " ON runs.id_meca = runs_xgru.id_meca "  &
			+ " left outer JOIN certif " &
			+ " ON runs_xgru.id_meca = certif.id_meca "  &
			+ " left outer JOIN arsp " &
			+ " ON runs_xgru.id_armo = arsp.id_armo "  
	k_sql += " group by meca.id, meca.num_int, meca.data_ent, certif.data, prodotti.gruppo " 
	kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_sql)		

	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)



			
end subroutine

private subroutine leggi_dwc_runsrtrrts_help (long k_riga, ref datawindow k_dw);//
long k_rc
date k_data
datastore kds_1

try
//--- se sono sul report generico allora faccio vedere i barcode
//if ki_scelta_report = ki_scelta_report_lotti_entrati then
	kds_1 = create datastore
	kds_1.dataobject = "d_report_23_runs_rtr_rts_help"
	kds_1.settransobject(kguo_sqlca_db_magazzino)

	if k_dw.rowcount() > 0 then

		if k_riga > 0 then
			
			// data x estrarre solo il mese e l'anno il giorno è fasullo
			k_data =  k_dw.getitemdate(k_riga,"kdata")
			
			k_rc = kds_1.retrieve(k_data)
			if k_rc > 0 then
			else
				kds_1.insertrow(0)
			end if
		else
			kds_1.insertrow(0)
		end if
	else
		kds_1.insertrow(0)

	end if

	kiuf_parent.link_call( kds_1, "")

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente() 

finally
	if isvalid(kds_1) then destroy kds_1
	
end try
end subroutine

protected function string u_get_dataobject_esporta ();//
//--- Torna il nome del dataobject da esportare che può differire da dw di stampa 
string k_return


	choose case tab_1.selectedtab 
					
		case 1 
			k_return = trim(tab_1.tabpage_1.dw_1.dataobject)
		case else
			choose case u_report_selezionato()
				case ki_scelta_report_lotti_entrati
					k_return = "d_report_7_con_giri_esporta" 
				case else
					k_return = trim(kidw_selezionata.dataobject)
					
			end choose

	end choose	

return k_return

	

end function

protected subroutine riposiziona_cursore ();//
// non faccio niente
end subroutine

private function long report_24_inizializza (uo_d_std_1 kdw_1);//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//--- REPORT PROGRAMMAZIONE PILOTA
//
string k_scelta, k_codice_prec
long k_righe
datastore kds_1
kuf_utility kuf1_utility

	
try

	k_scelta = trim(ki_st_open_w.flag_modalita)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if not isnull(kdw_1.tag) then
		k_codice_prec = kdw_1.tag
	else
		k_codice_prec = " "
	end if
	
//--- salvo i parametri cosi come sono stati immessi
	kuf1_utility = create kuf_utility
	kdw_1.tag = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility

	if trim(k_codice_prec) <> trim(kdw_1.tag) then
		u_set_tabpage_picture(true)
	else
		u_set_tabpage_picture(false)
	end if
	
	if kdw_1.rowcount() = 0 or trim(k_codice_prec) =  "" then 

		setpointer(kkg.pointer_attesa)
		kdw_1.visible = false
		
		if not isvalid(kiuf_report_pilota) then kiuf_report_pilota = create kuf_report_pilota
		if not isvalid(kiuf_pilota_previsioni) then kiuf_pilota_previsioni = create kuf_pilota_previsioni
		
		if kiuf_pilota_previsioni.get_tab_lav_x_lotto_prev( ) > 0 then
		
			kds_1 = kiuf_report_pilota.set_ds_report_24_pilota_prev_lav( )
			
			kdw_1.dataobject = kds_1.dataobject
			kdw_1.visible = true
			kds_1.rowscopy(1, kds_1.rowcount(), primary!, kdw_1, 1, primary!)
			
			k_righe = kdw_1.rowcount()
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	attiva_tasti()
	if kdw_1.rowcount() = 0 then
		kdw_1.insertrow(0) 
	end if
	kdw_1.setfocus()
	setpointer(kkg.pointer_default)

end try
	

return k_righe





end function

private subroutine report_24 ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta, k_importa


if tab_1.tabpage_1.dw_1.rowcount() <= 0 or tab_1.tabpage_1.dw_1.dataobject <> "d_report_24" then
	tab_1.tabpage_1.dw_1.dataobject = "d_report_24"
	tab_1.tabpage_1.dw_1.reset()
	tab_1.tabpage_1.dw_1.insertrow(0)
	
	tab_1.tabpage_1.dw_1.visible = true

	try	
//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_int_artr.utente)
	
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		tab_1.tabpage_1.dw_1.setfocus()
	
	end try

end if

attiva_tasti()
		

	



end subroutine

on w_int_artr.create
int iCurrent
call super::create
end on

on w_int_artr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
u_dw_selezione_save( )

if not isnull(kiuf_utility) then destroy kiuf_utility
if not isnull(kiuf_report_pilota) then destroy kiuf_report_pilota
if not isnull(kiuf_pilota_previsioni) then destroy kiuf_pilota_previsioni

end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
string k_sc_cf
string k_art = ""


if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
	
		choose case kst_open_w.key2

//--- Programma ID
			case "d_prod_l_attivi_x_gru" 
			//case "b_cod_art_l"
				if long(kst_open_w.key3) > 0 then
					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
						k_art = trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "codice"))
						tab_1.tabpage_1.dw_1.setitem(1, "art", k_art)

					end if
				end if
				
			case "d_sc_cf_l" 
				if long(kst_open_w.key3) > 0 then
					kdsi_elenco_input = kst_open_w.key12_any 
					if kdsi_elenco_input.rowcount() > 0 then
						k_sc_cf = trim(kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "codice"))
						tab_1.tabpage_1.dw_1.setitem(1, "sc_cf", k_sc_cf)

					end if
				end if
				
				
		end choose

	end if

end if


end event

type st_ritorna from w_g_tab_3`st_ritorna within w_int_artr
integer x = 2263
integer y = 1424
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_int_artr
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_int_artr
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_int_artr
integer x = 2848
integer y = 1856
end type

type st_stampa from w_g_tab_3`st_stampa within w_int_artr
integer x = 2661
integer y = 1420
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_int_artr
integer x = 1234
integer y = 1856
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_int_artr
integer x = 782
integer y = 1852
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_int_artr
integer x = 2107
integer y = 1856
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_int_artr
integer x = 2478
integer y = 1856
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_int_artr
integer x = 1737
integer y = 1856
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_int_artr
integer x = 14
integer y = 0
integer width = 3154
integer height = 1752
end type

event tab_1::selectionchanged;call super::selectionchanged;//
//parent.title = trim(ki_win_titolo_orig) + ".  " + trim(tab_1.tabpage_1.ddplb_report.text)

end event

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3118
integer height = 1624
string text = "Parametri"
string picturename = "edit16.gif"
ddplb_report ddplb_report
st_report st_report
end type

on tabpage_1.create
this.ddplb_report=create ddplb_report
this.st_report=create st_report
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddplb_report
this.Control[iCurrent+2]=this.st_report
end on

on tabpage_1.destroy
call super::destroy
destroy(this.ddplb_report)
destroy(this.st_report)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer x = 1097
integer y = 180
integer width = 2011
integer height = 1400
integer taborder = 50
string dataobject = "d_report_0"
string icon = "AppIcon!"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_abilita_ddw_proposta = true
end type

event dw_1::itemchanged;call super::itemchanged;//
int k_errore=0
long  k_id_clie, k_riga
string k_rag_soc //, k_indirizzo, k_localita
datawindowchild kdwc_cliente
datawindowchild kdwc_contratti_1

//
//if ki_scelta_report = ki_scelta_report_generico or ki_scelta_report = ki_scelta_report_lotti_entrati &
//				or  ki_scelta_report = ki_scelta_report_chk_intra or ki_scelta_report = ki_scelta_report_lotti_da_sped  &  
//				or ki_scelta_report = ki_scelta_report_lotti_sped or ki_scelta_report = ki_scelta_report_bcode_trattati &
//				or  ki_scelta_report = ki_scelta_report_memo or ki_scelta_report = ki_scelta_report_lotti_sped_daFatt &
//				or  ki_scelta_report = ki_scelta_report_attestati &
//				or  ki_scelta_report = ki_scelta_report_armo_Contratti then

	choose case dwo.name 
		
		case "clie_1" 
			k_rag_soc = trim(data)
//			k_rag_soc = trim(this.gettext())
			if LenA(k_rag_soc) > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("rag_soc_1 like '%"+trim(k_rag_soc)+"%'",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",&
									kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_1",&
									kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_1","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",0)
			end if
	
	
		case "id_clie_1" 
			k_id_clie = long(data)
			if k_id_clie > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("id_cliente = "+string(k_id_clie)+" ",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_1",	kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_1","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "clie_1","")
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_1",0)
			end if

	
		case "clie_2" 
			k_rag_soc = trim(data)
			if LenA(k_rag_soc) > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("rag_soc_1 like '%"+trim(k_rag_soc)+"%'",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",&
									kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_2",&
									kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_2","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",0)
			end if
	
	
		case "id_clie_2" 
			k_id_clie = long(trim(data))
			if k_id_clie > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("id_cliente = "+string(k_id_clie)+" ",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",&
									kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_2",&
									kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_2","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "clie_2","")
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_2",0)
			end if
	
	
		case "clie_3" 
			k_rag_soc = trim(data)
			if LenA(k_rag_soc) > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("rag_soc_1 like '%"+trim(k_rag_soc)+"%'",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",&
									kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_3",&
									kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_3","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",0)
			end if
	
	
		case "id_clie_3" 
			k_id_clie = long(trim(data))
			if k_id_clie > 0 then
				tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("id_cliente = "+string(k_id_clie)+" ",&
										kdwc_cliente.getrow(), kdwc_cliente.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",&
									kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
					tab_1.tabpage_1.dw_1.setitem(1, "clie_3",&
									kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "clie_3","Non trovato")
					tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",0)
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "clie_3","")
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_3",0)
			end if
	
		case "id_gruppo"
			post leggi_dwc_gruppi(kidw_selezionata)
			
	end choose 
//end if


//---- se ho cambiato il cliente rileggo il Contratto
if ki_scelta_report = ki_scelta_report_armo_Contratti then
	if  dwo.name = "id_clie_3" or  dwo.name = "clie_3" then
		if  dwo.name = "id_clie_3" then
			k_id_clie =  long(trim(this.gettext()))
		else
			k_id_clie = tab_1.tabpage_1.dw_1.getitemnumber(row, "id_clie_3")
		end if
		tab_1.tabpage_1.dw_1.getchild("mc_co", kdwc_contratti_1)
//		if kdwc_contratti_1.rowcount() < 2 then
			kdwc_contratti_1.retrieve(k_id_clie)
			kdwc_contratti_1.insertrow(1)
//		end if

	elseif  dwo.name = "mc_co" then
		if trim(data) > " " then
			tab_1.tabpage_1.dw_1.getchild("mc_co", kdwc_contratti_1)
			//k_riga = kdwc_contratti_1.getrow()
			k_riga=kdwc_contratti_1.find("mc_co = '"+trim(data)+"' ", kdwc_contratti_1.getrow() , kdwc_contratti_1.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "descr",&
								kdwc_contratti_1.getitemstring(k_riga, "descr"))
				tab_1.tabpage_1.dw_1.setitem(1, "codice",&
								kdwc_contratti_1.getitemnumber(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "scadenza",&
								"scadenza: " + string(kdwc_contratti_1.getitemdate(k_riga, "data_scad")))
				if kdwc_contratti_1.find("mc_co = '"+trim(data)+"' ", kdwc_contratti_1.getrow()+1, kdwc_contratti_1.rowcount()) > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "idem", "Attenzione ci sono altri Contratti con lo stesso Codice " +trim(data) )
				else
					tab_1.tabpage_1.dw_1.setitem(1, "idem", "")
				end if
			else
				tab_1.tabpage_1.dw_1.setitem(1, "descr","")
				tab_1.tabpage_1.dw_1.setitem(1, "codice",0)
			end if
		else		
			tab_1.tabpage_1.dw_1.setitem(1, "descr","")
			tab_1.tabpage_1.dw_1.setitem(1, "codice",0)
		end if
	end if
end if

if k_errore = 1 then
	return 2
end if

	

	



end event

event dw_1::clicked;call super::clicked;//
u_parametri_clicked(dwo.Name, row)


end event

event dw_1::buttonclicked;call super::buttonclicked;////
//
//u_button_clicked(dwo.Name, row)
//
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3118
integer height = 1624
boolean enabled = false
long backcolor = 32567536
string text = "Report ?"
string picturename = "VCRNext!"
string powertiptext = "Seleziona o fai rileggi per rigenerare il report"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean ki_link_standard_sempre_possibile = true
end type

event dw_2::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)
////
//pointer kpointer  // Declares a pointer variable
//
//uo_d_std_1 kdw_1
//////--- trova riga se ad es. sono con tree-dw	
////if row = 0 then
////	row = u_get_riga_AtPointer(dwo.name)
////end if
//
//if row > 0 then 
//
//	if LenA(trim(dwo.name)) > 0 then
//	
//	//=== Puntatore Cursore da attesa.....
//		kpointer = SetPointer(HourGlass!)
//
//		if ki_scelta_report = ki_scelta_report_generico and dwo.Name = "b_barcode_l" then
//			leggi_dwc_barcode(row, kdw_1)
//		else
//			
//			if ki_scelta_report = ki_scelta_report_lotti_entrati and dwo.Name = "b_riferim_l" then
//				leggi_dwc_rif_x_data_mrf(row, kdw_1)
//			end if
//		end if
//		
//	//=== Se volessi riprist. il vecchio puntatore : 
//		SetPointer(kpointer)
//	
//	end if
//end if
//
//
//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3118
integer height = 1624
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean ki_link_standard_sempre_possibile = true
end type

event dw_3::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3118
integer height = 1624
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
boolean ki_link_standard_sempre_possibile = true
end type

event dw_4::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3118
integer height = 1624
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean ki_link_standard_sempre_possibile = true
end type

event dw_5::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3118
integer height = 1624
boolean enabled = true
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
boolean ki_link_standard_sempre_possibile = true
end type

event dw_6::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3118
integer height = 1624
boolean enabled = true
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean ki_link_standard_sempre_possibile = true
end type

event dw_7::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3118
integer height = 1624
boolean enabled = true
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean ki_link_standard_sempre_possibile = true
end type

event dw_8::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3118
integer height = 1624
boolean enabled = true
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
boolean ki_link_standard_sempre_possibile = true
end type

event dw_9::clicked;call super::clicked;//
u_parametri_clicked(trim(dwo.name), row)

end event

type ddplb_report from dropdownpicturelistbox within tabpage_1
event u_constructor ( )
integer x = 32
integer y = 88
integer width = 1047
integer height = 1396
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Scegliere il Report"
boolean allowedit = true
boolean autohscroll = true
boolean border = false
boolean sorted = false
boolean showlist = true
string item[] = {""}
integer itempictureindex[] = {0}
string picturename[] = {"","","","",""}
long picturemaskcolor = 536870912
end type

event u_constructor();//--- se run da IDE salta le add picture altrimenti va in CRASH
if NOT kguf_data_base.u_if_run_dev_mode( ) then
	ki_scelta_report_pic_lotti_entrati = this.AddPicture("DataWindow!")
	ki_scelta_report_pic_generico = this.AddPicture("DataWindow!")
	ki_scelta_report_pic_coda_pilota = this.AddPicture("Regenerate!")
	ki_scelta_report_pic_in_trattamento = this.AddPicture("Regenerate!")
	ki_scelta_report_pic_trattato = this.AddPicture("Regenerate!")
	ki_scelta_report_pic_chk_intra = this.AddPicture("Menu!")
	ki_scelta_report_pic_RegArt50 = this.AddPicture("Menu!")
	ki_scelta_report_pic_lotti_in_giacenza = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_lotti_in_giacenza_gia_trattati = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_lotti_da_sped = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_lotti_sped = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_etichette_lotti = this.AddPicture("barcode.bmp") //(kGuo_path.get_risorse() + "\barcode.bmp")
	ki_scelta_report_pic_etichettine = this.AddPicture("barcode.bmp") //kGuo_path.get_risorse() + "\barcode.bmp")
	ki_scelta_report_pic_groupage = this.AddPicture("CheckIn5!")
	ki_scelta_report_pic_bcode_trattati = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_art_movim = this.AddPicture("CheckStatus5!")
	//ki_scelta_report_pic_armo_prezzi = this.AddPicture("FormatDollar!")
	ki_scelta_report_pic_memo = this.AddPicture("edit16.gif") //kGuo_path.get_risorse() + "\edit16.gif")
	ki_scelta_report_pic_lotti_sped_daFatt = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_Attestati = this.AddPicture("certificato16.gif") //kGuo_path.get_risorse() + "\certificato16.gif")
	ki_scelta_report_pic_armo_Contratti = this.AddPicture("CheckStatus5!")
	ki_scelta_report_pic_LavxCapitolato = this.AddPicture("DataWindow!")
	ki_scelta_report_pic_RunsRtrRts = this.AddPicture("DataWindow!")
	ki_scelta_report_pic_prevFineLav = this.AddPicture("Regenerate!")
end if

 ki_scelta_report_lotti_entrati = this.additem(  "Lotti entrati", ki_scelta_report_pic_lotti_entrati) //1 report 
 ki_scelta_report_generico = this.additem(  "Interrogazione Generica", ki_scelta_report_pic_generico) //2
 ki_scelta_report_coda_pilota = this.additem(  "Pilota: Programma Impianto", ki_scelta_report_pic_coda_pilota) //3
 ki_scelta_report_in_trattamento = this.additem(  "Pilota: Materiale in Lavorazione", ki_scelta_report_pic_in_trattamento) //4
 ki_scelta_report_prevFineLav = this.additem(  "Pilota: Previsione Lavorazione ", ki_scelta_report_pic_prevFineLav) //24
 ki_scelta_report_trattato = this.additem(  "Pilota: Materiale Trattato ", ki_scelta_report_pic_trattato) //5
 ki_scelta_report_chk_intra = this.additem(  "Conrollo INTRA", ki_scelta_report_pic_chk_intra) //6
 ki_scelta_report_RegArt50 = this.additem(  "Registro Articolo 50", ki_scelta_report_pic_RegArt50) //7
 ki_scelta_report_lotti_in_giacenza = this.additem(  "Lotti in giacenza", ki_scelta_report_pic_lotti_in_giacenza) //8
 ki_scelta_report_lotti_in_giacenza_gia_trattati = this.additem(  "Lotti Certificati in giacenza", ki_scelta_report_pic_lotti_in_giacenza_gia_trattati) //9
 ki_scelta_report_lotti_da_sped = this.additem(  "Lotti da Spedire", ki_scelta_report_pic_lotti_da_sped) //10
 ki_scelta_report_lotti_sped= this.additem(  "Lotti Spediti", ki_scelta_report_pic_lotti_sped) //11
 ki_scelta_report_etichette_lotti= this.additem(  "Etichette Lotti", ki_scelta_report_pic_etichette_lotti) //12
 ki_scelta_report_etichettine= this.additem(  "Etichette Dosimetro", ki_scelta_report_pic_etichettine) //13
 ki_scelta_report_groupage= this.additem(  "Elenco Groupage", ki_scelta_report_pic_groupage) //14
 ki_scelta_report_bcode_trattati = this.additem(  "Lotti Trattati", ki_scelta_report_pic_bcode_trattati) //15
// ki_scelta_report_armo_prezzi = this.additem(  "Voci lotto per la Fatturazione ", ki_scelta_report_pic_armo_prezzi) //17
 ki_scelta_report_memo = this.additem(  "Trova Memo ", ki_scelta_report_pic_memo)//18
 ki_scelta_report_lotti_sped_dafatt = this.additem(  "Lotti Spediti da Fatturare ", ki_scelta_report_pic_lotti_sped_daFatt)//19
 ki_scelta_report_attestati = this.additem(  "Attestati ", ki_scelta_report_pic_attestati)//20
 ki_scelta_report_art_movim = this.additem(  "Articoli Movimentati", ki_scelta_report_pic_art_movim) //16
 ki_scelta_report_armo_Contratti = this.additem(  "Contratti Movimentati ", ki_scelta_report_pic_armo_Contratti) //21
 ki_scelta_report_LavxCapitolato = this.additem(  "Capitolati ", ki_scelta_report_pic_LavxCapitolato) //22
 ki_scelta_report_RunsRtrRts = this.additem(  "Runs RTR RTS ETS ", ki_scelta_report_pic_RunsRtrRts) //23
 
 
end event

event selectionchanged;//
tab_1.tabpage_2.enabled = true
u_scegli_report(index)

end event

type st_report from statictext within tabpage_1
boolean visible = false
integer x = 352
integer y = 32
integer width = 1221
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 31449055
string text = "Scegli il Report:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

