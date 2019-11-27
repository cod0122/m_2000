$PBExportHeader$w_stat_invent.srw
forward
global type w_stat_invent from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_stat_invent from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3831
integer height = 2064
string title = "Scheda Fatturato Cliente"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
end type
global w_stat_invent w_stat_invent

type variables
//
private kuf_stat_invent kiuf_stat_invent 

private st_stampe kist_stampa_dw_2, kist_stampa_dw_3, kist_stampa_dw_4, kist_stampa_dw_7

//struttura dei parametri di estrazione
private st_stat_invent  kist_stat_invent

//--- campo con i parametri di estrazione x evitare di creare le stesse tabelle temporanee
private string ki_codice_prec_x_crea_view=" "

//--- Nomi dw da usare 
private string ki_stat_x_inventari = ""
private string ki_stat_x_inventari_ABC = ""

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine stampa ()
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
private subroutine get_parametri () throws uo_exception
private subroutine set_nome_utente_tab () throws uo_exception
protected subroutine open_start_window ()
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine inizializza_8 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected function integer inserisci ()
end prototypes

protected function string inizializza () throws uo_exception;//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return = "0"
string k_scelta
long  k_key, k_id_cliente, k_riga
int k_err_ins, k_rc=0, k_anno, k_id_gruppo, k_anno_base, k_ctr
double k_dose 
date k_data_da, k_data_a
string k_rag_soc, k_indirizzo, k_localita, k_estrazione, k_importa=" "
st_esito kst_esito
kuf_base kuf1_base 
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo
pointer kpointer  // Declares a pointer variable




//--- reperisce lo stato dell'ultima estrazione	
if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	kuf1_base = create kuf_base 
	kst_esito = kuf1_base.statistici_stato_elab()
	if kst_esito.esito = kuf1_base.kci_statistici_stato_ko then
		k_return = ki_exitNow
		messagebox("Estrazioni Statistiche", &
				"L'alimentazione dei dati Statistici non e' terminata correttamente ~n~r" + &
				"impossibile procedere con le estrazioni.~n~r" )
		k_return = ki_exitNow
	else
		if kst_esito.esito = kuf1_base.kci_statistici_stato_in_esec then
			k_return = ki_exitNow
			messagebox("Estrazioni Statistiche", &
					"L'alimentazione dei dati Statistici e' in esecuzione, prego riprovare piu' tardi ~n~r" + &
					"impossibile procedere con le estrazioni.~n~r" )
			k_return = ki_exitNow
		end if
	
	end if
	destroy kuf1_base 
end if


//--- se tutto ok 
if k_return <> ki_exitNow then

	//=== Puntatore Cursore da attesa.....
	//=== Se volessi riprist. il vecchio puntatore : SetPointer(oldpointer)
	kpointer = SetPointer(HourGlass!)
	
	
	if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
	//--- imposto l'utente (il "terminale") x costruire il nome della view
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	
	//--- reperisce l'anno attuale
		kuf1_base = create kuf_base 
		k_anno_base = integer(kuf1_base.prendi_dato_base("anno"))
	//--- reperisce estremi ultima estrazione	
		k_estrazione = MidA(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		
		
		k_scelta = trim(ki_st_open_w.flag_modalita)
		k_id_cliente = long(trim(ki_st_open_w.key1)) //cliente fattura
		k_dose = double(trim(ki_st_open_w.key2))
		k_id_gruppo = integer(trim(ki_st_open_w.key3))
	
		if LenA(trim(ki_st_open_w.key4)) = 0 then
			k_data_da = date(k_anno_base, 01, 01)
		else
			k_data_da = date(trim(ki_st_open_w.key4)) 
		end if
		if LenA(trim(ki_st_open_w.key5)) = 0 then
			k_data_a = date(k_anno_base, 12, 31)
		else
			k_data_a = date(trim(ki_st_open_w.key5)) 
		end if
		k_key = long(trim(ki_st_open_w.key1)) //cliente
		if k_id_cliente > 0 then
			k_importa = "N" //disabilito la importazione poiche' ho estr.personal.
		end if

		tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
		tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
		tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
	
		kdwc_cliente.settransobject(sqlca)
		kdwc_dose.settransobject(sqlca)
		kdwc_gruppo.settransobject(sqlca)
	
		if k_importa <> "N" or isnull(k_importa) then
			importa_dati_da_ultima_exit()
		end if

		kdwc_cliente.insertrow(1)
		kdwc_dose.insertrow(1)
		kdwc_gruppo.insertrow(1)

		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
			tab_1.tabpage_1.dw_1.insertrow(0)
		
			if k_id_cliente > 0 then
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.insertrow(0)
					select rag_soc_10, indi_1, loc_1
						into :k_rag_soc, :k_indirizzo, :k_localita
						from clienti
						where codice = :k_id_cliente ;
					if sqlca.sqlcode <> 0 then
						k_rag_soc = "Non trovato"
					else
						tab_1.tabpage_1.dw_1.modify("rag_soc_1.tabsequence=0")
					end if
					tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1", k_rag_soc)
					tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", k_id_cliente)
					tab_1.tabpage_1.dw_1.setitem(1, "indirizzo", k_indirizzo)
					tab_1.tabpage_1.dw_1.setitem(1, "localita", k_localita)
				end if
			end if
			
		//=== Retrieve solo se ho specificato una data dose
			if k_dose > 0 then
				if kdwc_dose.rowcount() < 2 then
					kdwc_dose.retrieve()
					kdwc_dose.insertrow(1)
					k_riga=kdwc_dose.find("dose = "+string(k_dose),&
											0, kdwc_dose.rowcount())
					if k_riga > 0 then
						tab_1.tabpage_1.dw_1.setitem(1, "dose",&
										kdwc_dose.getitemnumber(k_riga, "dose"))
					end if
				end if
			end if	
			
		//	if len(k_id_t_lavoro) > 0 and k_id_t_lavoro <> "*" then
			if k_id_gruppo > 0 then
				if kdwc_gruppo.rowcount() < 2 then
					kdwc_gruppo.retrieve()
					kdwc_gruppo.insertrow(1)
					k_riga=kdwc_gruppo.find("codice = "+string(k_id_gruppo),&
											0, kdwc_gruppo.rowcount())
					if k_riga > 0 then
						tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",&
										kdwc_gruppo.getitemnumber(k_riga, "codice"))
						tab_1.tabpage_1.dw_1.setitem(1, "descrizione",&
										kdwc_gruppo.getitemstring(k_riga, "des"))
					end if
				end if
			end if
				
			kist_stat_invent.data_da = k_data_da
			kist_stat_invent.data_a = k_data_a
			kist_stat_invent.dose = k_dose
			kist_stat_invent.id_gruppo = k_id_gruppo
			kist_stat_invent.id_cliente = k_id_cliente
			kist_stat_invent.tipo_data = '1'  // data lavorazione
			kist_stat_invent.magazzino = 9
			kist_stat_invent.no_dose = 'N'
			if isnull(kist_stat_invent.data_da) or kist_stat_invent.data_da = date(0) then
				kist_stat_invent.data_da = date("01/01/1900")
			end if
			if isnull(kist_stat_invent.data_a) or kist_stat_invent.data_a = date(0) then
				kist_stat_invent.data_a = date("01/01/2200")
			end if
			
			
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", kist_stat_invent.data_da)
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", kist_stat_invent.data_a)
			tab_1.tabpage_1.dw_1.setitem(1, "magazzino", kist_stat_invent.magazzino)
			
		end if

		tab_1.tabpage_1.dw_1.setitem(1, "estrazione", k_estrazione)
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_stat_invent.utente)
		
	
	end if
	
	//		tab_1.tabpage_1.dw_1.setcolumn(1)
	
	tab_1.tabpage_1.dw_1.setfocus()
				
	attiva_tasti()
	
	//=== riprist. il vecchio puntatore 
	SetPointer(kpointer)
	
end if
		
return k_return 
	



end function

protected subroutine stampa ();//=== stampa dw
string k_errore, k_titolo=" ", k_titolo_2=" "
w_g_tab kwindow_1
datawindow kdw_1
st_stampe kst_stampe





	choose case tab_1.selectedtab 
		case 1 
			kdw_1 = tab_1.tabpage_1.dw_1
			k_titolo = tab_1.tabpage_1.text
		case 2
			kdw_1 = tab_1.tabpage_2.dw_2
			k_titolo = kist_stampa_dw_2.titolo
			k_titolo_2 = kist_stampa_dw_2.titolo_2
		case 3
			kdw_1 = tab_1.tabpage_3.dw_3
			k_titolo = kist_stampa_dw_3.titolo
			k_titolo_2 = kist_stampa_dw_3.titolo_2
		case 4
			kdw_1 = tab_1.tabpage_4.dw_4
			k_titolo = kist_stampa_dw_4.titolo
			k_titolo_2 = kist_stampa_dw_4.titolo_2
		case 5
			kdw_1 = tab_1.tabpage_5.dw_5
			k_titolo = tab_1.tabpage_5.text
		case 6
			kdw_1 = tab_1.tabpage_6.dw_6
			k_titolo = tab_1.tabpage_6.text
		case 7
			kdw_1 = tab_1.tabpage_7.dw_7
			k_titolo = tab_1.tabpage_7.text
		case 8
			kdw_1 = tab_1.tabpage_8.dw_8
			k_titolo = tab_1.tabpage_8.text
		case 9
			kdw_1 = tab_1.tabpage_9.dw_9
			k_titolo = tab_1.tabpage_9.text
	end choose	

	if kdw_1.rowcount() > 0 then

		kwindow_1 = kGuf_data_base.prendi_win_attiva()
		
		kst_stampe.dw_print = kdw_1
		kst_stampe.titolo = trim(k_titolo) //+ " di '" + trim(kwindow_1.title) + "'"
		kst_stampe.titolo_2 = trim(k_titolo_2)

		k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))

	end if
	
	

end subroutine

protected subroutine inizializza_4 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 5 
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
string k_scelta, k_no_dose //, k_tipo_data
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

kuf1_utility = create kuf_utility

//--- piglia i parametri x l'estrazione prevalenmetente dalla prima pagina
	get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if LenA(trim(tab_1.tabpage_5.st_5_retrieve.text)) > 0 then
		k_codice_prec = tab_1.tabpage_5.st_5_retrieve.text
	else
		k_codice_prec = " "
	end if
//--- salvo i parametri cosi come sono stati immessi
	tab_1.tabpage_5.st_5_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

	if tab_1.tabpage_5.st_5_retrieve.text <> k_codice_prec then

//--- imposta il DW corretto
		tab_1.tabpage_5.dw_5.dataobject = ki_stat_x_inventari 


		kist_stat_invent.flag_fatturati = "T" //tutti
		kist_stat_invent.flag_trattati = true
		kist_stat_invent.flag_check_spediti = true
		kist_stat_invent.stat_tab = 5

//--- Crea le View x le query ---------------------------------
		if kist_stat_invent.magazzino = kuf_armo.kki_magazzino_DATRATTARE or kist_stat_invent.magazzino = kuf_armo.kki_magazzino_TUTTI then
			k_stringn = kiuf_stat_invent.crea_view_6(kist_stat_invent)
		else
			k_stringn = kiuf_stat_invent.crea_view_6_nolav(kist_stat_invent)
		end if
//-------------------------------------------------------------


//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_5.dw_5.Object.DataWindow.Table.Select 
		//k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_statinv25" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_inv2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_5.dw_5.Object.DataWindow.Table.Select = k_sql_orig 

//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario merce trattata e fatturata per Cliente '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		if kist_stat_invent.magazzino <> 9 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: ' + string(kist_stat_invent.magazzino ) + '   '
		else 
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		end if
		if kist_stat_invent.no_dose = 'S' then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: No   '
		else
			if kist_stat_invent.dose = 0 then 
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: ' +  string(kist_stat_invent.dose) + '   ' 
			end if
		end if
		if kist_stat_invent.id_gruppo > 0 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
		end if	
		if kist_stat_invent.id_gruppo > 0 then
			if kist_stat_invent.gruppo_flag = 1 then
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			end if
		end if	
			

		if k_esegui_query then
			
			k_rc = tab_1.tabpage_5.dw_5.settransobject ( sqlca )
	
			k_rc = tab_1.tabpage_5.dw_5.retrieve(4)
		end if

	end if

destroy kuf1_utility

attiva_tasti()

if tab_1.tabpage_5.dw_5.rowcount() = 0 then
	tab_1.tabpage_5.dw_5.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_5.dw_5.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_5.dw_5.setfocus()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected subroutine inizializza_5 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 6 
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_6.st_6_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_6.st_6_retrieve.text
else
	k_codice_prec = " "
end if
//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_6.st_6_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility



//if kist_stat_invent.tipo_data = '2' then // x data Fatturazione ovviamente qui non fa nulla
//
//	if tab_1.tabpage_6.dw_6.rowcount() > 0 then
//		tab_1.tabpage_6.dw_6.reset()
//	end if
//
//	
//else
	
	if tab_1.tabpage_6.st_6_retrieve.text <> k_codice_prec then
	

//--- imposta il DW corretto
		tab_1.tabpage_6.dw_6.dataobject = ki_stat_x_inventari 
	
		kist_stat_invent.flag_fatturati = "N" //non fatturati
		kist_stat_invent.flag_trattati = true
		kist_stat_invent.flag_check_spediti = true
		kist_stat_invent.stat_tab = 6

//--- Crea le View x le query ---------------------------------
		if kist_stat_invent.magazzino = kuf_armo.kki_magazzino_DATRATTARE or kist_stat_invent.magazzino = kuf_armo.kki_magazzino_TUTTI then
			k_stringn = kiuf_stat_invent.crea_view_6(kist_stat_invent)
		else
			k_stringn = kiuf_stat_invent.crea_view_6_nolav(kist_stat_invent)
		end if
//-------------------------------------------------------------

	
	//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_6.dw_6.Object.DataWindow.Table.Select 
		//k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_statinv25" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_inv2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_6.dw_6.Object.DataWindow.Table.Select = k_sql_orig 
	
	//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario merce trattata non fatturata per Cliente '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		if kist_stat_invent.magazzino <> 9 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: ' + string(kist_stat_invent.magazzino ) + '   '
		else 
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		end if
		if kist_stat_invent.no_dose = 'S' then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: No   '
		else
			if kist_stat_invent.dose = 0 then 
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: ' +  string(kist_stat_invent.dose) + '   ' 
			end if
		end if
		if kist_stat_invent.id_gruppo > 0 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
		end if	
		if kist_stat_invent.id_gruppo > 0 then
			if kist_stat_invent.gruppo_flag = 1 then
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			end if
		end if	
			
		if k_esegui_query then
			
			k_rc = tab_1.tabpage_6.dw_6.settransobject ( sqlca )
	
			k_rc = tab_1.tabpage_6.dw_6.retrieve(5)
		end if
	end if
//end if


attiva_tasti()

if tab_1.tabpage_6.dw_6.rowcount() = 0 then
	tab_1.tabpage_6.dw_6.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_6.dw_6.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_6.dw_6.setfocus()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

private subroutine get_parametri () throws uo_exception;//======================================================================
//=== Polola la struttura con i parametri di estrazione
//======================================================================
//
string k_codice_prec
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


kuf1_utility = create kuf_utility

kist_stat_invent.dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
kist_stat_invent.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
kist_stat_invent.id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
kist_stat_invent.gruppo_flag = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_flag")  
kist_stat_invent.data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
kist_stat_invent.data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  
kist_stat_invent.no_dose = tab_1.tabpage_1.dw_1.getitemstring(1, "no_dose")  
kist_stat_invent.magazzino = tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")  
//kist_stat_invent.tipo_data = tab_1.tabpage_1.dw_1.getitemstring(1, "tipo_data") 
kist_stat_invent.data_estrazione_stat =	tab_1.tabpage_1.dw_1.getitemstring(1, "estrazione")
if tab_1.tabpage_1.dw_1.getitemstring(1, "flag_lotto_chiuso") = "S" then
	kist_stat_invent.flag_lotto_chiuso = true
else
	kist_stat_invent.flag_lotto_chiuso = false
end if


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//=== Controllo date
	if kist_stat_invent.data_a < kist_stat_invent.data_da then
		kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_anomali)
		kGuo_exception.setmessage("La data di fine periodo (" + string(kist_stat_invent.data_a) &
		                          + ") e' minore di quela di inizio (" + string(kist_stat_invent.data_da) + ")" )
		throw kGuo_exception 
	end if

	if isnull(kist_stat_invent.id_gruppo)  or kist_stat_invent.gruppo_flag = 2 then
		kist_stat_invent.id_gruppo = 0
		kist_stat_invent.gruppo_flag = 2
	end if
	if isnull(kist_stat_invent.gruppo_flag) then
		kist_stat_invent.gruppo_flag = 2
	end if
	tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo", kist_stat_invent.id_gruppo)  
	
	if isnull(kist_stat_invent.dose) then
		kist_stat_invent.dose = 0
		kist_stat_invent.dose_str = "0"
	else
		kist_stat_invent.dose_str = kuf1_utility.u_num_itatousa(string(kist_stat_invent.dose))
	end if
	if isnull(kist_stat_invent.id_cliente) then
		kist_stat_invent.id_cliente = 0
	end if

//--- il flag potrebbe essere stato ricambiato
	tab_1.tabpage_1.dw_1.setitem(1, "gruppo_flag", kist_stat_invent.gruppo_flag)  


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
	if LenA(trim(tab_1.tabpage_1.st_1_retrieve.text)) > 0 then
		k_codice_prec = tab_1.tabpage_1.st_1_retrieve.text
	else
		k_codice_prec = " "
	end if

//--- salvo i parametri cosi come sono stati immessi
	tab_1.tabpage_1.st_1_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

//--- se parametri diversi dall'ultima volta rifaccio alcune operazioni
	if tab_1.tabpage_1.st_1_retrieve.text <> k_codice_prec then

//		choose case kist_stat_invent.tipo_data
//				
//			case '1'
//				select min(id_meca), max(id_meca) into :kist_stat_invent.id_meca_da, :kist_stat_invent.id_meca_a 
//				    from s_artr 
//					 where data_lav_fin between :kist_stat_invent.data_da and :kist_stat_invent.data_a and id_meca > 0;
//				if sqlca.sqlcode <> 0 then
//					kist_stat_invent.id_meca_da = 0 
//				else
//					if sqlca.sqlcode = 100 then
//						kist_stat_invent.id_meca_da = 99999 
//					end if
//				end if
//	
//				
//	
//			case '2' // x data fine fatturazione
//				
	//--- piglio i ID_MECA rispetto alla data indicata
//				select min(id_meca), max(id_meca) into :kist_stat_invent.id_meca_da, :kist_stat_invent.id_meca_a 
//				     from s_arfa 
//					  where data_fatt between :kist_stat_invent.data_da and :kist_stat_invent.data_a and id_meca > 0;
//				if sqlca.sqlcode < 0 then
//					kist_stat_invent.id_meca_da = 0 
//				else
//					if sqlca.sqlcode = 100 then
//						kist_stat_invent.id_meca_da = 99999 
//					end if
//				end if
//	
//				 
//			case '3' // x data di riferimento
	//--- piglio i ID_MECA rispetto alla data indicata
				select min(id_meca), max(id_meca) into :kist_stat_invent.id_meca_da, :kist_stat_invent.id_meca_a 
				     from s_armo 
					  where data_int between :kist_stat_invent.data_da and :kist_stat_invent.data_a and id_meca > 0;
				if sqlca.sqlcode < 0 then
					kist_stat_invent.id_meca_da = 0 
				else
					if sqlca.sqlcode = 100 then
						kist_stat_invent.id_meca_da = 99999 
					end if
				end if
				 
//		end choose
		
		if isnull(kist_stat_invent.id_meca_da) then
			kist_stat_invent.id_meca_da = 9999999 
		end if
		if isnull(kist_stat_invent.id_meca_a) then
			kist_stat_invent.id_meca_a = 0
		end if
	
	end if
	
	
destroy kuf1_utility
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

private subroutine set_nome_utente_tab () throws uo_exception;//
//--- setto il nome utente x il nome della view
//
int k_ctr=0


	kist_stat_invent.utente = kguo_utente.get_comp()
	if LenA(trim(kist_stat_invent.utente)) > 0 then
		kist_stat_invent.utente = MidA(kist_stat_invent.utente, 1, 4)
		
		k_ctr = PosA(kist_stat_invent.utente, ".") 
		do while k_ctr > 0 
			kist_stat_invent.utente = ReplaceA ( kist_stat_invent.utente, k_ctr, 1, "_" ) 
			k_ctr = PosA( kist_stat_invent.utente, "." ) 
		loop 
//--- aggiungo il numero tab al nome utente
		if LenA(trim(string(tab_1.selectedtab))) = 0 then
			kist_stat_invent.utente = kist_stat_invent.utente + "_" 
		else
			kist_stat_invent.utente = kist_stat_invent.utente + trim(string(tab_1.selectedtab)) 
		end if
	else
		kist_stat_invent.utente = ""
		kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_utente)
		kGuo_exception.setmessage("Errore nel reperimento dell'Utente di connessione al sistema,~n~r" &
				+"prego riprovare l'operazione." )
		throw kGuo_exception 
	end if


//
end subroutine

protected subroutine open_start_window ();//
tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\edit16.gif" 

kiuf_stat_invent = create kuf_stat_invent

//---- imposta i nomi dei DW da utilizzare
if kiuf_stat_invent.visualizza_importi( ) then
	ki_stat_x_inventari = "d_stat_inventario_x_cliente"
	ki_stat_x_inventari_ABC = "d_stat_inventario_x_cliente_mandante"

else
	ki_stat_x_inventari = "d_stat_inventario_x_cliente_no_importi"
	ki_stat_x_inventari_abc = "d_stat_inventario_x_cliente_mandante_no_importo"
end if
end subroutine

protected subroutine inizializza_6 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 7 
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_7.st_7_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_7.st_7_retrieve.text
else
	k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_7.st_7_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_7.st_7_retrieve.text <> k_codice_prec then

//--- imposta il DW corretto
		tab_1.tabpage_7.dw_7.dataobject = ki_stat_x_inventari 


		kist_stat_invent.flag_fatturati = "S" // fatturati
		kist_stat_invent.flag_trattati = true
		kist_stat_invent.flag_check_spediti = true
		kist_stat_invent.stat_tab = 7

//--- Crea le View x le query ---------------------------------
		if kist_stat_invent.magazzino = kuf_armo.kki_magazzino_DATRATTARE or kist_stat_invent.magazzino = kuf_armo.kki_magazzino_TUTTI then
			k_stringn = kiuf_stat_invent.crea_view_6(kist_stat_invent)
		else
			k_stringn = kiuf_stat_invent.crea_view_6_nolav(kist_stat_invent)
		end if
//-------------------------------------------------------------


//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_7.dw_7.Object.DataWindow.Table.Select 
		k_stringn = "#vx_" + trim(kist_stat_invent.utente) + "_statinv25" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_inv2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_7.dw_7.Object.DataWindow.Table.Select = k_sql_orig 

//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario merce trattata e fatturata per Cliente '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		if kist_stat_invent.magazzino <> 9 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: ' + string(kist_stat_invent.magazzino ) + '   '
		else 
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		end if
		if kist_stat_invent.no_dose = 'S' then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: No   '
		else
			if kist_stat_invent.dose = 0 then 
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: ' +  string(kist_stat_invent.dose) + '   ' 
			end if
		end if
		if kist_stat_invent.id_gruppo > 0 then
			if kist_stat_invent.gruppo_flag = 1 then
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			end if
		end if	
			

		if k_esegui_query then
			
			k_rc = tab_1.tabpage_7.dw_7.settransobject ( sqlca )
	
			k_rc = tab_1.tabpage_7.dw_7.retrieve(6)
		end if
//	end if

end if

attiva_tasti()

if tab_1.tabpage_7.dw_7.rowcount() = 0 then
	tab_1.tabpage_7.dw_7.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_7.dw_7.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_7.dw_7.setfocus()
	
//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected subroutine inizializza_7 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 8 - INVENTARIO A
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_8.st_8_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_8.st_8_retrieve.text
else
	k_codice_prec = " "
end if
//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_8.st_8_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility



//if kist_stat_invent.tipo_data = '2' then // x data Fatturazione ovviamente qui non fa nulla
//
//	if tab_1.tabpage_8.dw_8.rowcount() > 0 then
//		tab_1.tabpage_8.dw_8.reset()
//	end if
//
//	
//else
	
	if tab_1.tabpage_8.st_8_retrieve.text <> k_codice_prec then
	

//--- imposta il DW corretto
		tab_1.tabpage_8.dw_8.dataobject = ki_stat_x_inventari_abc 
	

		kist_stat_invent.flag_fatturati = "T" // tutti
		kist_stat_invent.flag_trattati = true
		kist_stat_invent.flag_check_spediti = true
		kist_stat_invent.stat_tab = 8
		
//--- Crea le View x le query ---------------------------------
		if kist_stat_invent.magazzino = kuf_armo.kki_magazzino_DATRATTARE or kist_stat_invent.magazzino = kuf_armo.kki_magazzino_TUTTI then
			k_stringn = kiuf_stat_invent.crea_view_6(kist_stat_invent)
		else
			k_stringn = kiuf_stat_invent.crea_view_6_nolav(kist_stat_invent)
		end if
		kiuf_stat_invent.crea_view_altri_dati(kist_stat_invent)
//-------------------------------------------------------------

	
//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select 
		k_stringn = "#vx_" + trim(kist_stat_invent.utente) + "_statinv25" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_inv2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select = k_sql_orig 
	//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_num_certif" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_num_certif"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select = k_sql_orig 
	//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_id_fattura" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_id_fattura"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_8.dw_8.Object.DataWindow.Table.Select = k_sql_orig 
	
	//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario materiale trattato '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		if kist_stat_invent.magazzino <> 9 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: ' + string(kist_stat_invent.magazzino ) + '   '
		else 
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		end if
		if kist_stat_invent.no_dose = 'S' then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: No   '
		else
			if kist_stat_invent.dose = 0 then 
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: ' +  string(kist_stat_invent.dose) + '   ' 
			end if
		end if
		if kist_stat_invent.id_gruppo > 0 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
		end if	
		if kist_stat_invent.id_gruppo > 0 then
			if kist_stat_invent.gruppo_flag = 1 then
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			end if
		end if	
			
		if k_esegui_query then
			
			k_rc = tab_1.tabpage_8.dw_8.settransobject ( sqlca )
	
			k_rc = tab_1.tabpage_8.dw_8.retrieve(5)
		end if
	end if
//end if


attiva_tasti()

if tab_1.tabpage_8.dw_8.rowcount() = 0 then
	tab_1.tabpage_8.dw_8.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_8.dw_8.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_8.dw_8.setfocus()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected subroutine inizializza_8 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 8 - INVENTARIO B
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_9.st_9_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_9.st_9_retrieve.text
else
	k_codice_prec = " "
end if
//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_9.st_9_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility



//if kist_stat_invent.tipo_data = '2' then // x data Fatturazione ovviamente qui non fa nulla
//
//	if tab_1.tabpage_9.dw_9.rowcount() > 0 then
//		tab_1.tabpage_9.dw_9.reset()
//	end if
//
//	
//else
	
	if tab_1.tabpage_9.st_9_retrieve.text <> k_codice_prec then
	

//--- imposta il DW corretto
		tab_1.tabpage_9.dw_9.dataobject = ki_stat_x_inventari_abc 
	

		kist_stat_invent.flag_fatturati = "T" // tutti
		kist_stat_invent.flag_trattati = false
		kist_stat_invent.flag_check_spediti = true
		kist_stat_invent.stat_tab = 9

//--- Crea le View x le query ---------------------------------
		if kist_stat_invent.magazzino = kuf_armo.kki_magazzino_DATRATTARE or kist_stat_invent.magazzino = kuf_armo.kki_magazzino_TUTTI then
			k_stringn = kiuf_stat_invent.crea_view_6(kist_stat_invent)
		else
			k_stringn = kiuf_stat_invent.crea_view_6_nolav(kist_stat_invent)
		end if
		kiuf_stat_invent.crea_view_altri_dati(kist_stat_invent)
//-------------------------------------------------------------

	
//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select 
		k_stringn = "#vx_" + trim(kist_stat_invent.utente) + "_statinv25" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_inv2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select = k_sql_orig 
	//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_num_certif" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_num_certif"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select = k_sql_orig 
	//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_id_fattura" + string(kist_stat_invent.stat_tab)
		k_string = "vx_info_stat_id_fattura"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_9.dw_9.Object.DataWindow.Table.Select = k_sql_orig 
	
	//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario materiale NON Trattato '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		if kist_stat_invent.magazzino <> 9 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: ' + string(kist_stat_invent.magazzino ) + '   '
		else 
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		end if
		if kist_stat_invent.no_dose = 'S' then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: No   '
		else
			if kist_stat_invent.dose = 0 then 
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: ' +  string(kist_stat_invent.dose) + '   ' 
			end if
		end if
		if kist_stat_invent.id_gruppo > 0 then
			kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
		end if	
		if kist_stat_invent.id_gruppo > 0 then
			if kist_stat_invent.gruppo_flag = 1 then
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			else
				kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_invent.id_gruppo )  
			end if
		end if	
			
		if k_esegui_query then
			
			k_rc = tab_1.tabpage_9.dw_9.settransobject ( sqlca )
	
			k_rc = tab_1.tabpage_9.dw_9.retrieve(5)
		end if
	end if
//end if


attiva_tasti()

if tab_1.tabpage_9.dw_9.rowcount() = 0 then
	tab_1.tabpage_9.dw_9.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_9.dw_9.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_9.dw_9.setfocus()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected subroutine inizializza_2 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 8 - INVENTARIO MAT NON CONFORME
//--------------------------------------------------------------------------------------------------------------------
//
int k_rc
int k_ctr
string k_codice_prec
string k_flag_lotto_chiuso = ""
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_3.st_3_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if
//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_3.st_3_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility



	if tab_1.tabpage_3.st_3_retrieve.text <> k_codice_prec then
	
	//--- valorizza titolo
		kist_stampa_dw_4.titolo = 'Inventario materiale Non Conforme - BLOCCATO '
		kist_stampa_dw_4.titolo_2 = 'Dal ' + string( kist_stat_invent.data_da ) + ' al ' + string( kist_stat_invent.data_a )
		kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + ' Magazzino: Tutti   ' 
		kist_stampa_dw_4.titolo_2 = kist_stampa_dw_4.titolo_2 + 'Dose: Tutte   '
		if kist_stat_invent.flag_lotto_chiuso then
			k_flag_lotto_chiuso = "S"
		else
			k_flag_lotto_chiuso = "N"
		end if
		k_rc = tab_1.tabpage_3.dw_3.retrieve(kist_stat_invent.data_da, kist_stat_invent.data_a, k_flag_lotto_chiuso )
	end if


attiva_tasti()

if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if

tab_1.tabpage_3.dw_3.setfocus()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//
end subroutine

protected function integer inserisci ();//
int k_return	
	
	
	k_return = super::inserisci()
	
	tab_1.selectedtab = 1

return k_return 


end function

on w_stat_invent.create
int iCurrent
call super::create
end on

on w_stat_invent.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_stat_invent  ) then destroy kiuf_stat_invent

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_stat_invent
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_stat_invent
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_stat_invent
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_stat_invent
integer x = 2848
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_stat_invent
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_stat_invent
integer x = 1207
integer y = 1476
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_stat_invent
integer x = 754
integer y = 1476
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_stat_invent
integer x = 2107
integer y = 1504
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_stat_invent
integer x = 2478
integer y = 1504
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_stat_invent
integer x = 1737
integer y = 1504
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_stat_invent
boolean visible = true
integer width = 3589
integer height = 1472
end type

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
integer y = 176
integer width = 3552
integer height = 1280
long backcolor = 553648127
string text = "Parametri"
string picturename = "InkEdit!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer x = 41
integer y = 28
integer width = 3186
integer height = 1244
integer taborder = 50
string dataobject = "d_stat_invent_0"
boolean ki_link_standard_attivi = false
boolean ki_attiva_standard_select_row = false
end type

event dw_1::itemchanged;call super::itemchanged;//
double k_dose
int k_errore=0
long  k_key, k_id_cliente, k_riga, k_id_commessa
int k_rc=0, k_anno
date k_data_da, k_data_a
string k_id_t_lavoro, k_id_gruppo, k_rag_soc, k_indirizzo, k_localita
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo, kdwc_t_lavoro


choose case dwo.name 

	case "rag_soc_1" 
		k_rag_soc = trim(this.gettext())
		if LenA(k_rag_soc) > 0 then
			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
			if kdwc_cliente.rowcount() < 2 then
				kdwc_cliente.retrieve("%")
				kdwc_cliente.insertrow(1)
			end if
			k_riga=kdwc_cliente.find("rag_soc_1 like '%"+trim(k_rag_soc)+"%'",&
									0, kdwc_cliente.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",&
								kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1",&
								kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo", &
								kdwc_cliente.getitemstring(k_riga, "indirizzo"))
				tab_1.tabpage_1.dw_1.setitem(1, "localita",&
								kdwc_cliente.getitemstring(k_riga, "localita"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1","Non trovato")
				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
				tab_1.tabpage_1.dw_1.setitem(1, "localita","")
				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
			tab_1.tabpage_1.dw_1.setitem(1, "localita","")
			tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
		end if


	case "id_cliente" 
		k_rag_soc = trim(this.gettext())
		if LenA(k_rag_soc) > 0 then
			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
			if kdwc_cliente.rowcount() < 2 then
				kdwc_cliente.retrieve("%")
				kdwc_cliente.insertrow(1)
			end if
			k_riga=kdwc_cliente.find("id_cliente = "+string(k_rag_soc)+" ",&
									0, kdwc_cliente.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",&
								kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1",&
								kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo", &
								kdwc_cliente.getitemstring(k_riga, "indirizzo"))
				tab_1.tabpage_1.dw_1.setitem(1, "localita",&
								kdwc_cliente.getitemstring(k_riga, "localita"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1","Non trovato")
				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
				tab_1.tabpage_1.dw_1.setitem(1, "localita","")
				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
			tab_1.tabpage_1.dw_1.setitem(1, "localita","")
			tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
		end if


	case "dose" 
//		k_anno = integer(mid(st_parametri.text, 13, 4))
	//	k_anno = year(tab_1.tabpage_1.dw_1.getitemdate(1, "anno"))
		k_dose = double(tab_1.tabpage_1.dw_1.gettext())
		if k_dose > 0 then
			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
			if kdwc_dose.rowcount() < 2 then
				kdwc_dose.retrieve()
				kdwc_dose.insertrow(1)
			end if
			k_riga=kdwc_dose.find("dose = "+string(k_dose),&
									0, kdwc_dose.rowcount())
			if k_riga > 0 then
//				tab_1.tabpage_1.dw_1.setitem(1, "id_commessa",&
//								kdwc_dose.getitemnumber(k_riga, "id_commessa"))
				tab_1.tabpage_1.dw_1.setitem(1, "dose",&
								kdwc_dose.getitemnumber(k_riga, "dose"))
//				tab_1.tabpage_1.dw_1.setitem(1, "titolo",&
//								kdwc_dose.getitemstring(k_riga, "titolo"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "dose", k_dose)
			end if
			k_errore = 1
		else
//			tab_1.tabpage_1.dw_1.setitem(1, "dose",0)

		end if

	case "id_gruppo" 
		k_id_gruppo = trim(this.gettext())
		if LenA(k_id_gruppo) > 0 then
			tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
			if kdwc_gruppo.rowcount() < 2 then
				kdwc_gruppo.retrieve()
				kdwc_gruppo.insertrow(1)
			end if
			k_riga=kdwc_gruppo.find("codice = "+string(k_id_gruppo),&
									0, kdwc_gruppo.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",&
								kdwc_gruppo.getitemnumber(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "descrizione",&
								kdwc_gruppo.getitemstring(k_riga, "des"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",0)
				tab_1.tabpage_1.dw_1.setitem(1, "descrizione","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "descrizione","")
		end if



end choose 

if k_errore = 1 then
	return 2
end if

	

	



end event

event dw_1::clicked;//
int k_anno
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo


if row > 0 then

	choose case dwo.name	
		case "rag_soc_1"	
			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
			if kdwc_cliente.rowcount() < 2 then
				kdwc_cliente.retrieve("")
				kdwc_cliente.insertrow(1)
			end if
	
		case "dose"
			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
			if kdwc_dose.rowcount() < 2 then
				kdwc_dose.retrieve()
				kdwc_dose.insertrow(1)
			end if	
	
		case "id_gruppo"
			tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
			if kdwc_gruppo.rowcount() < 2 then
				kdwc_gruppo.retrieve()
				kdwc_gruppo.insertrow(1)
			end if	
	end choose
end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 283
integer y = 988
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = false
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = -5
integer y = 68
integer width = 3104
integer height = 1200
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
string text = " materiale~r~n Bloccato"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer y = 56
integer width = 3099
integer height = 1192
boolean enabled = true
string dataobject = "d_stat_inventario_nobarcode"
boolean ki_link_standard_sempre_possibile = true
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = false
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 18
integer y = 16
integer width = 3374
integer height = 1212
integer taborder = 10
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
string text = "Inventario 1 ~r~n"
string powertiptext = "tutto il materiale non spedito"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 3214
integer height = 1212
boolean enabled = true
string dataobject = "d_stat_inventario_x_cliente"
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_5::itemchanged;call super::itemchanged;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_riga=0
string k_string, k_sql_orig, k_stringn
integer k_ctr, k_len 
string k_inventario
kuf_utility kuf1_utility
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


if dwo.name = "cliente" then

   try 
      set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
   catch ( uo_exception kuo_exception )
   end try     
   
   if row > 0 then
      k_riga = row
   else
      k_riga = u_get_riga_AtPointer(dwo.name)
   end if

   if k_riga > 0 then
      kist_stat_invent.id_cliente = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "cliente")  
   else
      kist_stat_invent.id_cliente = 0
   end if
// k_inventario = "S"

//--- popolo il datasore (dw non visuale) per appoggio elenco
   if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
   
   kdsi_elenco_output.dataobject = "d_stat_produz_meca_x_clie_3" 
//--- Aggiorna SQL della dw   
   k_sql_orig = kdsi_elenco_output.Object.DataWindow.Table.Select 
   k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_statinv25"
   k_string = "vx_info_stat_inv2"
   k_ctr = PosA(k_sql_orig, k_string, 1)
   DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
      k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
      k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
   LOOP
   k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_artr"
   k_string = "vx_info_stat_artr"
   k_ctr = PosA(k_sql_orig, k_string, 1)
   DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
      k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
      k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
   LOOP
   kdsi_elenco_output.Object.DataWindow.Table.Select = k_sql_orig 

//                                     kist_stat_invent.id_gruppo, &

   k_rc = kdsi_elenco_output.settransobject ( sqlca )
   k_rc = kdsi_elenco_output.retrieve    ( kist_stat_invent.id_cliente )
                                    
   kuf1_utility = create kuf_utility                                    
   kst_open_w.key1 = "Zoom di " + kuf1_utility.u_stringa_pulisci(trim(tab_1.tabpage_4.text)) &
                     + ". Cliente " + trim(string(kist_stat_invent.id_cliente))
   destroy kuf1_utility

   if kdsi_elenco_output.rowcount() > 0 then

      k_window = kGuf_data_base.prendi_win_attiva()
      
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
      kst_open_w.id_programma = kkg_id_programma_elenco
      kst_open_w.flag_primo_giro = "S"
      kst_open_w.flag_modalita = kkg_flag_modalita.elenco
      kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
      kst_open_w.flag_leggi_dw = " "
      kst_open_w.flag_cerca_in_lista = " "
      kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
      kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
      kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
      kst_open_w.key12_any = kdsi_elenco_output
      kst_open_w.flag_where = " "
      kuf1_menu_window = create kuf_menu_window 
      kuf1_menu_window.open_w_tabelle(kst_open_w)
      destroy kuf1_menu_window

   else
      
      messagebox("Elenco Dati", &
               "Nessun valore disponibile. ")
      
      
   end if
end if

//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)


//
end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = true
string text = "Inventario 2 ~r~nsolo Non fatturato"
string powertiptext = "materiale non spedito e NON fatturato"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
boolean visible = true
integer width = 3259
integer height = 1244
boolean enabled = true
string dataobject = "d_stat_inventario_x_cliente"
boolean ki_link_standard_sempre_possibile = true
end type

event dw_6::itemchanged;call super::itemchanged;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_riga=0
string k_string, k_sql_orig, k_stringn
integer k_ctr, k_len 
string k_inventario
kuf_utility kuf1_utility
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


if dwo.name = "cliente" then

 	try 
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	catch ( uo_exception kuo_exception )
	end try		
	
	if row > 0 then
		k_riga = row
	else
		k_riga = u_get_riga_AtPointer(dwo.name)
	end if

	if k_riga > 0 then
		kist_stat_invent.id_cliente = tab_1.tabpage_5.dw_5.getitemnumber(k_riga, "cliente")  
	else
		kist_stat_invent.id_cliente = 0
	end if
	
	k_inventario = "S"

//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	kdsi_elenco_output.dataobject = "d_stat_produz_meca_x_clie_3" 
//--- Aggiorna SQL della dw	
	k_sql_orig = kdsi_elenco_output.Object.DataWindow.Table.Select 
	k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_statinv25" 
	k_string = "vx_info_stat_inv2"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_artr"
	k_string = "vx_info" //_stat_artr"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	kdsi_elenco_output.Object.DataWindow.Table.Select = k_sql_orig	
	
	k_rc = kdsi_elenco_output.settransobject ( sqlca )
	k_rc = kdsi_elenco_output.retrieve    (kist_stat_invent.id_cliente)
												
	kuf1_utility = create kuf_utility												
	kst_open_w.key1 = "Zoom di " + kuf1_utility.u_stringa_pulisci(trim(tab_1.tabpage_5.text)) &
	                  + ". Cliente " + trim(string(kist_stat_invent.id_cliente))
	destroy kuf1_utility

	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kGuf_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if
end if

//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)


//
end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = true
string text = "Inventario 3 ~r~nsolo fatturato"
string powertiptext = "materiale non spedito e fatturato"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean visible = true
integer width = 3264
integer height = 1188
boolean enabled = true
string dataobject = "d_stat_inventario_x_cliente"
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_7::itemchanged;call super::itemchanged;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_riga=0
string k_string, k_sql_orig, k_stringn
integer k_ctr, k_len 
string k_inventario
kuf_utility kuf1_utility
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


if dwo.name = "cliente" then

 	try 
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	catch ( uo_exception kuo_exception )
	end try		
	
	if row > 0 then
		k_riga = row
	else
		k_riga = u_get_riga_AtPointer(dwo.name)
	end if

	if k_riga > 0 then
		kist_stat_invent.id_cliente = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, "cliente")  
	else
		kist_stat_invent.id_cliente = 0
	end if
//	k_inventario = "S"

//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	kdsi_elenco_output.dataobject = "d_stat_produz_meca_x_clie_3" 
//--- Aggiorna SQL della dw	
	k_sql_orig = kdsi_elenco_output.Object.DataWindow.Table.Select 
	k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_statinv25 "
	k_string = "vx_info_stat_inv2"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	k_stringn = "vx_" + trim(kist_stat_invent.utente) + "_stat_artr"
	k_string = "vx_info_stat_artr"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	kdsi_elenco_output.Object.DataWindow.Table.Select = k_sql_orig	
	
	k_rc = kdsi_elenco_output.settransobject ( sqlca )
	k_rc = kdsi_elenco_output.retrieve    (kist_stat_invent.id_cliente)
												
	kuf1_utility = create kuf_utility												
	kst_open_w.key1 = "Zoom di " + kuf1_utility.u_stringa_pulisci(trim(tab_1.tabpage_6.text)) &
	                  + ". Cliente " + trim(string(kist_stat_invent.id_cliente))
	destroy kuf1_utility

	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kGuf_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if
end if

//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)


//
end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = true
string text = "Inventario A ~r~nmateriale Trattato"
string powertiptext = "materiale trattato ma non spedito "
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean visible = true
integer width = 3141
boolean enabled = true
string dataobject = "d_stat_inventario_x_cliente_mandante"
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
boolean visible = true
integer y = 176
integer width = 3552
integer height = 1280
boolean enabled = true
string text = "Inventario B~r~nmateriale Non Trattato"
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
boolean visible = true
integer x = 37
integer y = 24
integer width = 2981
boolean enabled = true
string dataobject = "d_stat_inventario_x_cliente_mandante"
boolean ki_link_standard_sempre_possibile = true
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

