$PBExportHeader$w_stat_produz.srw
forward
global type w_stat_produz from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_stat_produz from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3643
integer height = 1040
string title = "Scheda Fatturato Cliente"
boolean ki_esponi_msg_dati_modificati = false
end type
global w_stat_produz w_stat_produz

type variables
//
//datastore kdsi_elenco_output
st_stampe kist_stampa_dw_2, kist_stampa_dw_3, kist_stampa_dw_4, kist_stampa_dw_7

//struttura dei parametri di estrazione
st_stat_produz  kist_stat_produz

//--- campo con i parametri di estrazione x evitare di creare le stesse tabelle temporanee
private string ki_codice_prec_x_crea_view=" "

//--- Nomi dw da usare 
private string ki_stat_x_gruppi = ""
private string ki_stat_x_clienti = ""

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected subroutine stampa ()
private subroutine get_parametri () throws uo_exception
private subroutine set_nome_utente_tab () throws uo_exception
private subroutine crea_view_x_data_fatt_id_meca ()
private subroutine crea_view_x_data_fatt_id_armo ()
protected subroutine open_start_window ()
private subroutine crea_view_x_clie_3_id_armo ()
private subroutine crea_view_x_data_fatt ()
protected function integer inserisci ()
end prototypes

protected function string inizializza () throws uo_exception;//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long  k_key, k_id_cliente, k_riga
int k_err_ins, k_rc=0, k_anno, k_id_gruppo, k_anno_base, k_ctr
double k_dose 
date k_data_da, k_data_a
string k_rag_soc, k_indirizzo, k_localita, k_estrazione, k_importa=" "
boolean k_uscita=false
st_esito kst_esito
kuf_base kuf1_base 
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo
pointer kpointer  // Declares a pointer variable




//--- reperisce lo stato dell'ultima estrazione	
if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	kuf1_base = create kuf_base 
	kst_esito = kuf1_base.statistici_stato_elab()
	if kst_esito.esito = kuf1_base.kci_statistici_stato_ko then
		k_uscita = true
		messagebox("Estrazioni Statistiche", &
				"L'alimentazione dei dati Statistici non e' terminata correttamente ~n~r" + &
				"impossibile procedere con le estrazioni.~n~r" )
		post close(this)
	else
		if kst_esito.esito = kuf1_base.kci_statistici_stato_in_esec then
			k_uscita = true
			messagebox("Estrazioni Statistiche", &
					"L'alimentazione dei dati Statistici e' in esecuzione, prego riprovare piu' tardi ~n~r" + &
					"impossibile procedere con le estrazioni.~n~r" )
			post close(this)
		end if
	
	end if
	destroy kuf1_base 
end if


//--- se tutto ok 
if not k_uscita then

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
				
			kist_stat_produz.data_da = k_data_da
			kist_stat_produz.data_a = k_data_a
			kist_stat_produz.dose = k_dose
			kist_stat_produz.id_gruppo = k_id_gruppo
			kist_stat_produz.id_cliente = k_id_cliente
			kist_stat_produz.tipo_data = '1'
			kist_stat_produz.magazzino = 9
			kist_stat_produz.no_dose = 'N'
			if isnull(kist_stat_produz.data_da) or kist_stat_produz.data_da = date(0) then
				kist_stat_produz.data_da = date("01/01/1900")
			end if
			if isnull(kist_stat_produz.data_a) or kist_stat_produz.data_a = date(0) then
				kist_stat_produz.data_a = date("01/01/2200")
			end if
			
			
			tab_1.tabpage_1.dw_1.setitem(1, "tipo_data", kist_stat_produz.tipo_data)
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", kist_stat_produz.data_da)
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", kist_stat_produz.data_a)
			tab_1.tabpage_1.dw_1.setitem(1, "magazzino", kist_stat_produz.magazzino)
			
		end if

		tab_1.tabpage_1.dw_1.setitem(1, "estrazione", k_estrazione)
		tab_1.tabpage_1.dw_1.setitem(1, "utente", kist_stat_produz.utente)
		
	
	end if
	
	//		tab_1.tabpage_1.dw_1.setcolumn(1)
	
	tab_1.tabpage_1.dw_1.setfocus()
				
	attiva_tasti()
	
	//=== riprist. il vecchio puntatore 
	SetPointer(kpointer)
	
end if
		
return "0"
	



end function

protected subroutine inizializza_3 () throws uo_exception;//--------------------------------------------------------------------------------------------------------------------
//---  TAB 4
//--------------------------------------------------------------------------------------------------------------------
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql
string k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//--- Puntatore Cursore da attesa.....
//--- Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

kuf1_utility = create kuf_utility

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_4.st_4_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
else
	k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
tab_1.tabpage_4.st_4_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

if tab_1.tabpage_4.st_4_retrieve.text <> k_codice_prec then

//	if ki_codice_prec_x_crea_view <> tab_1.tabpage_4.st_4_retrieve.text then
//--- Salvo i parametri per evitare di rifare le Tabelle se non sono cambiati
		ki_codice_prec_x_crea_view = tab_1.tabpage_4.st_4_retrieve.text
//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
		crea_view_x_data_fatt()
		crea_view_x_data_fatt_id_armo()
		crea_view_x_clie_3_id_armo()
//	end if
		

		
//--- costruisco la view Valore Giri 
	k_view = "vx_" + trim(kist_stat_produz.utente)  + "_stat_artr3 "
	k_sql = " "
	k_campi = " " &
	          + " valore_x_giri_f1_lav decimal(12,4) " & 
			 + ", nr_giri_f1_lav integer" & 
	          + ", valore_x_giri_f2_lav decimal(12,4) " & 
			 + ", nr_giri_f2_lav integer" & 
			 + ", somma_giri integer" &
	          + ", valore_totale decimal(12,4) " 
			 
//	          + ", valore_x_giri_f1_pl decimal(12,4) " & 
//			 + ", nr_giri_f1_pl integer" & 
//	          + ", valore_x_giri_f2_pl decimal(12,4) " & 
//			 + ", nr_giri_f2_pl integer" & 

 k_sql = &
		 + " SELECT " &
           + " (case when (nvl(s_artr.giri_f1_lav,0) + nvl(s_artr.giri_f1_lav_gp,0)) > 0 then (s_artr.colli_trattati * imp_x_collo ) " & 
           + "      else  0 " & 
           + "   end ) " &
           + "  as valore_x_giri_f1_lav         " &
	       + " ,(nvl(s_artr.giri_f1_lav,0) + nvl(s_artr.giri_f1_lav_gp,0))  / 2  as nr_giri_f1_lav " &
           + "  ,(case when (s_artr.giri_f2_lav + s_artr.giri_f2_lav_gp) > 0 then  (s_artr.colli_trattati * imp_x_collo ) " & 
           + "     else  0 " & 
           + " end) " &
           + " as valore_x_giri_f2_lav         " &
		  + " ,(s_artr.giri_f2_lav + s_artr.giri_f2_lav_gp)  / 2 as nr_giri_f2_lav " &
          + "  ,( NVL(s_artr.giri_f1_lav,0) + NVL(s_artr.giri_f2_lav,0) )  / 2 as somma_giri      " &
           + "  ,(s_artr.colli_trattati * imp_x_collo ) as valore_totale" & 
		 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
		 + "  s_artr.id_armo = s_armo.id_armo " 
		 
//           + "  ,sum(case when (s_artr.giri_f1_pl + s_artr.giri_f1_pl_gp) > 0 then  ((s_artr.colli_entrati - s_artr.colli_trattati) * imp_x_collo)  " &
//           + "   else  0  " &
//           + "   end) " &
//           + " as valore_x_giri_f1_pl  " &
//		  + " ,sum(s_artr.giri_f1_pl + s_artr.giri_f1_pl_gp)  / 2 as nr_giri_f1_pl " &
//           + " ,sum(case when (s_artr.giri_f2_pl + s_artr.giri_f2_pl_gp) > 0 then ((s_artr.colli_entrati -s_artr.colli_trattati) * imp_x_collo ) " & 
//           + "     else  0  " &
//           + "  end) " &
//           + "  as valore_x_giri_f2_pl         " &
//		  + " ,sum(s_artr.giri_f2_pl + s_artr.giri_f2_pl_gp) / 2  as nr_giri_f2_pl " &
	 
	 
	choose case kist_stat_produz.tipo_data
			
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  	
	 
		case '2' // x data fatturazione
			k_sql += &
			 + "	where " &  
			 + "  s_artr.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_dfat )"  
			 
		case '3' // x data di riferimento
			k_sql += &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' " 
			 
	end choose
	
	k_sql += " "  //+ 	" group by 1  "
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		



//--- valorizza titolo
	kist_stampa_dw_3.titolo = 'Valore Trattato Clienti '
	kist_stampa_dw_3.titolo_2 = 'Dal ' + string( kist_stat_produz.data_da ) + ' al ' + string( kist_stat_produz.data_a ) + '  '
	if kist_stat_produz.magazzino <> 9 then
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Magazzino: ' + string(kist_stat_produz.magazzino ) + '   '
	else 
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Magazzino: Tutti   ' 
	end if
	if kist_stat_produz.no_dose = 'S' then
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: No   '
	else
		if kist_stat_produz.dose = 0 then 
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: Tutte   '
		else
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: ' +  string(kist_stat_produz.dose) + '   ' 
		end if
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		else
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		end if
	else
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Gruppi: Tutti   ' 
	end if	

	if k_esegui_query then

		tab_1.tabpage_4.dw_4.dataobject = "d_stat_produz_val_giri" 

//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_4.dw_4.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_artr3"
		k_string = "vx_MAST1_stat_artr3"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_4.dw_4.Object.DataWindow.Table.Select = k_sql_orig 
		
		k_rc = tab_1.tabpage_4.dw_4.settransobject ( sqlca )

		k_rc = tab_1.tabpage_4.dw_4.retrieve( )
	end if

end if

destroy kuf1_utility 


attiva_tasti()

if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	tab_1.tabpage_4.dw_4.insertrow(0) 
end if

tab_1.tabpage_4.dw_4.setfocus()
	

//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)


//
end subroutine

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice_prec
int k_ctr, k_rc
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query	= true
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_2.st_2_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = " "
end if


//--- salvo i parametri cosi come sono stati immessi
tab_1.tabpage_2.st_2_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

if tab_1.tabpage_2.st_2_retrieve.text <> k_codice_prec then

//	if ki_codice_prec_x_crea_view <> tab_1.tabpage_2.st_2_retrieve.text then !!!PECCATO XCHE' LA TEMP TABLE VIENE CANCELLATA ALLA FINE DI QUESTA ROUTINE!!!
//--- Salvo i parametri per evitare di rifare le Tabelle se non sono cambiati
		ki_codice_prec_x_crea_view = tab_1.tabpage_2.st_2_retrieve.text
//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
		crea_view_x_data_fatt()
		crea_view_x_data_fatt_id_armo()
		crea_view_x_clie_3_id_armo()
//	end if
		
//--- costruisco la view con Importi x Cliente
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_imp1 "
	k_sql_w = " "
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) &
//	 + " ( gruppo, id_armo, colli_periodo, colli_da_fatt, colli_entrati, colli_fatt, imp_x_collo ) AS   " 
	k_campi = "gruppo integer, id_armo integer, colli_periodo integer, colli_da_fatt integer" &
	          + ", colli_entrati integer, colli_fatt integer, imp_x_collo decimal(12,4)"
	k_sql = &
			 " SELECT  " &
			 + " s_armo.gruppo  " &
			 + " ,s_artr.id_armo  " &
			 + " ,sum((NVL(s_artr.colli_trattati,0))) as colli_periodo " & 
			 + " ,(NVL(s_artr.colli_entrati,0) - NVL(s_artr.colli_fatturati,0)) as colli_da_fatt " & 
			 + " ,(NVL(s_artr.colli_entrati,0)) as colli_entrati" & 
			 + " ,(NVL(s_artr.colli_fatturati,0)) as colli_fatt " & 
			 + " ,(NVL(s_artr.imp_x_collo,0) ) as imp_x_collo " & 
			 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
			 + "  s_artr.id_armo = s_armo.id_armo " 
	 
	choose case kist_stat_produz.tipo_data
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  &
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
		case '2' // x data fine fatturazione
			k_sql +=  &
			 + "	where " &  
			 + "  s_armo.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  &
			 + " and s_armo.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat )"  
		case '3' // x data di riferimento
			k_sql += &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  &
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
	end choose
	k_sql += " " + trim(k_sql_w) + " group by 1, 2, 4, 5, 6, 7  "
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		


//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//			if kist_stat_produz.id_cliente > 0 then
//				k_sql_w =  " and s_armo.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
//			end if
//			if kist_stat_produz.id_gruppo > 0 then
//				k_sql_w = k_sql_w + " and s_armo.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
//			end if
//			if kist_stat_produz.magazzino <> 9 then
//				k_sql_w = k_sql_w +  " and s_armo.magazzino = " + string(kist_stat_produz.magazzino) + " "
//			end if
//			if kist_stat_produz.dose > 0 then
//				k_sql_w = k_sql_w + "and s_armo.dose = " + kist_stat_produz.dose_str + " "
//			end if
//			if kist_stat_produz.no_dose = 'S' then
//				k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
//			else
//				k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
//			end if

		
//--- costruisco la view con Importi a Gruppo
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_artr "
	k_sql_w = " "
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) &
//	 + " ( gruppo, colli_trattati, m_cubi, giri_f1_pl, giri_f1_lav, giri_f2_pl, giri_f2_lav, pedane, somma_giri) AS   " 
	k_campi = "gruppo integer, colli_trattati integer, m_cubi decimal(12,4) " &
	          + ", giri_f1_pl decimal(12,2) " & 
	          + ", giri_f1_lav decimal(12,2) " & 
	          + ", giri_f2_pl decimal(12,2) " & 
	          + ", giri_f2_lav decimal(12,2) " & 
				 + ", pedane decimal(12,2) " &
				 + ", somma_giri decimal(12,2) "
	k_sql = &
			 + " SELECT " &
			 + " s_armo.gruppo  " &
          + "  ,sum(NVL(s_artr.colli_trattati,0)) as colli_trattati  " &  
          + "  ,sum(NVL(s_artr.m_cubi,0)) as m_cubi   " &
          + "  ,sum(NVL(s_artr.giri_f1_pl,0)) / 2 as giri_f1_pl   " &
          + "  ,sum(NVL(s_artr.giri_f1_lav,0)) / 2 as giri_f1_lav   " &
          + "  ,sum(NVL(s_artr.giri_f2_pl,0)) / 2 as giri_f2_pl   " &
          + "  ,sum(NVL(s_artr.giri_f2_lav,0)) / 2 as giri_f2_lav   " &
          + "  ,sum(NVL(s_artr.pedane,0)) as pedane " &
          + " ,sum( NVL(s_artr.giri_f1_lav,0) + NVL(s_artr.giri_f2_lav,0) ) as somma_giri " &
			 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
			 + "  s_artr.id_armo = s_armo.id_armo " 
	 
	choose case kist_stat_produz.tipo_data
			
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  	
	 
		case '2' // x data fine fatturazione
			k_sql += &
			 + "	where " &  
			 + "  s_artr.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_dfat )"  
			 
		case '3' // x data di riferimento
			k_sql += &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' " 
			 
	end choose
	
	
//	if kist_stat_produz.id_cliente > 0 then
//		k_sql_w =  " and s_armo.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
//	end if
//	if kist_stat_produz.id_gruppo > 0 then
//		k_sql_w = k_sql_w +  " and s_armo.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
//	end if
//	if kist_stat_produz.magazzino <> 9 then
//		k_sql_w = k_sql_w +  " and s_armo.magazzino = " + string(kist_stat_produz.magazzino) + " "
//	end if
//	if kist_stat_produz.dose > 0 then
//		k_sql_w = k_sql_w + "and s_armo.dose = " + kist_stat_produz.dose_str + " "
//	end if
//	if kist_stat_produz.no_dose = 'S' then
//		k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
//	else
//		k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
//	end if
	k_sql += " " + trim(k_sql_w) + " group by 1  "
	
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		



	tab_1.tabpage_2.dw_2.dataobject = ki_stat_x_gruppi //"d_stat_produz_x_gruppo" 

//--- Aggiorna SQL della dw	
	k_sql_orig = tab_1.tabpage_2.dw_2.Object.DataWindow.Table.Select 
	k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_imp1"
	k_string = "vx_MAST2_stat_imp1"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
//--- ancora...Aggiorna SQL della dw	
	k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_artr"
	k_string = "vx_MAST2_stat_artr"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	tab_1.tabpage_2.dw_2.Object.DataWindow.Table.Select = k_sql_orig 

//--- valorizza titolo
	kist_stampa_dw_2.titolo = 'Merce Trattata per Gruppo'  
	kist_stampa_dw_2.titolo_2 = 'Dal ' + string( kist_stat_produz.data_da ) + ' al ' + string( kist_stat_produz.data_a )
	if kist_stat_produz.magazzino <> 9 then
		kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + ' Magazzino: ' + string(kist_stat_produz.magazzino ) + '   '
	else 
		kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + ' Magazzino: Tutti   ' 
	end if
	if kist_stat_produz.no_dose = 'S' then
		kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + 'Dose: No   '
	else
		if kist_stat_produz.dose = 0 then 
			kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + 'Dose: Tutte   '
		else
			kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + 'Dose: ' +  string(kist_stat_produz.dose) + '   ' 
		end if
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + 'Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		else
			kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + ' Escludi Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		end if
	else
		kist_stampa_dw_2.titolo_2 = kist_stampa_dw_2.titolo_2 + ' Gruppi: Tutti   ' 
	end if	

	kist_stampa_dw_2.titolo_2 += '  (' + trim(string(kist_stat_produz.data_estrazione_stat)) + ') '


	if k_esegui_query then
		
		k_rc = tab_1.tabpage_2.dw_2.settransobject ( sqlca )

		k_rc = tab_1.tabpage_2.dw_2.retrieve(  )


	end if

end if

attiva_tasti()


destroy kuf1_utility


if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_2.dw_2.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_2.dw_2.setfocus()
	

//
end subroutine

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice_prec
int k_rc
int k_ctr
string k_view, k_sql, k_sql_w, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)

kuf1_utility = create kuf_utility

//--- piglia i parametri x l'estrazione (prevalenmetente dalla prima pagina
get_parametri()


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_3.st_3_retrieve.text)) > 0 then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
tab_1.tabpage_3.st_3_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)

if tab_1.tabpage_3.st_3_retrieve.text <> k_codice_prec then

//	if ki_codice_prec_x_crea_view <> tab_1.tabpage_3.st_3_retrieve.text then
//--- Salvo i parametri per evitare di rifare le Tabelle se non sono cambiati
		ki_codice_prec_x_crea_view = tab_1.tabpage_3.st_3_retrieve.text
//--- crea la view con i riferimenti solo x le date fattura comprese come indicato
		crea_view_x_data_fatt()
		crea_view_x_data_fatt_id_armo()
		crea_view_x_clie_3_id_armo()
//	end if
		

//--- costruisco la view con Importi a Cliente
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_imp2 "
	k_sql = " "
	k_campi = "clie_3 integer, id_armo integer, colli_periodo integer, colli_da_fatt integer" &
	          + ", colli_entrati integer, colli_fatt integer, imp_x_collo decimal(12,4), imp_x_pedana decimal(12,4)" &
			 + ", pedane decimal(12,2) " 
	k_sql = &
			 + " SELECT  " &
			 + " s_armo.clie_3  " &
			 + " ,s_artr.id_armo  " &
			 + " ,sum((NVL(s_artr.colli_trattati,0))) as colli_periodo " & 
			 + " ,(NVL(s_artr.colli_entrati,0) - NVL(s_artr.colli_fatturati,0)) as colli_da_fatt " & 
			 + " ,(NVL(s_artr.colli_entrati,0)) as colli_entrati" & 
			 + " ,(NVL(s_artr.colli_fatturati,0)) as colli_fatt " & 
			 + " ,(NVL(s_artr.imp_x_collo,0) ) as imp_x_collo " & 
			 + " ,(s_artr.importo_giri / s_artr.nr_pedane) as imp_x_pedana " & 
       		 + " ,(NVL(s_artr.nr_pedane,0.00)) as pedane " &
			 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
			 + "  s_artr.id_armo = s_armo.id_armo " 
	choose case kist_stat_produz.tipo_data
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + " s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + "    and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "'  " & 
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
			 
		case '2' // x data fine fatturazione
			k_sql += &
			 + "	where " &  
			 + "  s_armo.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  &
			 + " and s_armo.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat )"  
		case '3' // x data di riferimento
			k_sql = + k_sql &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  &
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
	end choose
	k_sql +=  " group by 1, 2, 4, 5, 6, 7, 8, 9  "
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		

		
//--- costruisco la view con Fatturato x id_armo e id_cliente
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_fatt1 "
	k_sql_w = " "
	k_campi = "clie_3 integer, id_armo integer, fatturato decimal(14,4)" 
	k_sql = &
			 " SELECT distinct  " &
			 + " s_armo.clie_3 " & 
			 + " ,s_armo.id_armo, " & 
			 + " ,(NVL(s_artr.colli_fatturati,0) * NVL(s_artr.imp_x_collo,0))  " & 
			 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
			 + "  s_artr.id_armo = s_armo.id_armo " 
	choose case kist_stat_produz.tipo_data
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  &
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
		case '2' // x data fine fatturazione
			k_sql +=  &
			 + "	where " &  
			 + "  s_armo.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  &
			 + " and s_armo.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat )"  
		case '3' // x data di riferimento
			k_sql += &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  &
			 + " and s_artr.id_meca between " + string(kist_stat_produz.id_meca_da) &
			 + " and " + string(kist_stat_produz.id_meca_a) + " "  
	end choose
	k_sql += " " + trim(k_sql_w) 
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

//--- costruisco la view con Fatturato x id_cliente
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_fatt2 "
	k_sql_w = " "
	k_campi = "clie_3 integer, fatturato decimal(14,4)"  
	k_sql = &
			 " SELECT  " &
			 + " clie_3 " & 
			 + " ,sum(fatturato)  " & 
			 + " FROM  vx_" + trim(kist_stat_produz.utente) + "_stat_fatt1 " 
	k_sql += " " + trim(k_sql_w) +" group by 1 "
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		

		
//--- costruisco la view con Importi x Cliente
	k_view = "vx_" + trim(kist_stat_produz.utente)  + "_stat_artr "
	k_sql_w = " "
	k_sql = " "
//	k_sql = + &
//	"CREATE view " + trim(k_view) &
//	 + " ( clie_3, colli_trattati, m_cubi, giri_f1_pl, giri_f1_lav, giri_f2_pl, giri_f2_lav, pedane, somma_giri) AS   " 
	k_campi = "clie_3 integer, id_armo_contati integer, colli_trattati integer, m_cubi decimal(12,4) " &
	          + ", giri_f1_pl decimal(12,2) " & 
	          + ", giri_f1_lav decimal(12,2) " & 
	          + ", giri_f2_pl decimal(12,2) " & 
	          + ", giri_f2_lav decimal(12,2) " & 
	          + ", giri_f1_pl_gp decimal(12,2) " & 
	          + ", giri_f1_lav_gp decimal(12,2) " & 
	          + ", giri_f2_pl_gp decimal(12,2) " & 
	          + ", giri_f2_lav_gp decimal(12,2) " & 
				 + ", somma_giri decimal(12,2)"
	k_sql = &
			 + " SELECT " &
			 + " s_armo.clie_3 " &
		  + "  ,count(s_armo.id_armo) as id_armo_contati " &
          + "  ,sum(NVL(s_artr.colli_trattati,0)) as colli_trattati  " &  
          + "  ,sum(NVL(s_artr.m_cubi,0.00)) as m_cubi   " &
          + "  ,sum(NVL(s_artr.giri_f1_pl,0)) / 2 as giri_f1_pl   " &
          + "  ,sum(NVL(s_artr.giri_f1_lav,0)) / 2 as giri_f1_lav   " &
          + "  ,sum(NVL(s_artr.giri_f2_pl,0)) / 2 as giri_f2_pl   " &
          + "  ,sum(NVL(s_artr.giri_f2_lav,0)) / 2 as giri_f2_lav   " &
          + "  ,sum(NVL(s_artr.giri_f1_pl_gp,0)) / 2 as giri_f1_pl_gp   " &
          + "  ,sum(NVL(s_artr.giri_f1_lav_gp,0)) / 2 as giri_f1_lav_gp   " &
          + "  ,sum(NVL(s_artr.giri_f2_pl_gp,0)) / 2 as giri_f2_pl_gp   " &
          + "  ,sum(NVL(s_artr.giri_f2_lav_gp,0)) / 2 as giri_f2_lav_gp   " &
          + " ,sum( NVL(s_artr.giri_f1_lav,0) + NVL(s_artr.giri_f2_lav,0) ) as somma_giri " &
			 + " FROM s_artr INNER JOIN " + "vx_" + trim(kist_stat_produz.utente) + "_stat_meca as s_armo ON " &
			 + "  s_artr.id_armo = s_armo.id_armo " 
	choose case kist_stat_produz.tipo_data
		case '1' // x data fine lavorazione
			k_sql +=  &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  	
		case '2' // x data fatturazione
			k_sql += &
			 + "	where " &  
			 + "  s_artr.id_armo in " &  
			 + "  (select id_armo from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_dfat )"  
		case '3' // x data di riferimento
			k_sql += &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' " 
	end choose
	k_sql += " " + trim(k_sql_w) + " group by 1  "
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


//--- valorizza titolo
	kist_stampa_dw_3.titolo = 'Valore Trattato Clienti '
	kist_stampa_dw_3.titolo_2 = 'Dal ' + string( kist_stat_produz.data_da ) + ' al ' + string( kist_stat_produz.data_a ) + '  '
	if kist_stat_produz.magazzino <> 9 then
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Magazzino: ' + string(kist_stat_produz.magazzino ) + '   '
	else 
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Magazzino: Tutti   ' 
	end if
	if kist_stat_produz.no_dose = 'S' then
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: No   '
	else
		if kist_stat_produz.dose = 0 then 
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: Tutte   '
		else
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Dose: ' +  string(kist_stat_produz.dose) + '   ' 
		end if
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		else
			kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + 'Escludi Gruppo: ' + string( kist_stat_produz.id_gruppo )  
		end if
	else
		kist_stampa_dw_3.titolo_2 = kist_stampa_dw_3.titolo_2 + ' Gruppi: Tutti   ' 
	end if	

	if k_esegui_query then

		tab_1.tabpage_3.dw_3.dataobject = ki_stat_x_clienti //"d_stat_produz_x_cliente" 

//--- Aggiorna SQL della dw	
		k_sql_orig = tab_1.tabpage_3.dw_3.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_imp2"
		k_string = "vx_MAST3_stat_imp2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		k_sql_orig = tab_1.tabpage_3.dw_3.Object.DataWindow.Table.Select 
		k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_fatt2"
		k_string = "vx_MAST3_stat_fatt2"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_artr"
		k_string = "vx_MAST3_stat_artr"
		k_ctr = PosA(k_sql_orig, k_string, 1)
		DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
			k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
			k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
		LOOP
		tab_1.tabpage_3.dw_3.Object.DataWindow.Table.Select = k_sql_orig 
		
		k_rc = tab_1.tabpage_3.dw_3.settransobject ( sqlca )

		k_rc = tab_1.tabpage_3.dw_3.retrieve( )
	end if

end if

destroy kuf1_utility 


attiva_tasti()

if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if

tab_1.tabpage_3.dw_3.setfocus()
	

//--- Riprist. il vecchio puntatore : 
SetPointer(kpointer)


end subroutine

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

		kwindow_1 = kuf1_data_base.prendi_win_attiva()
		
		kst_stampe.dw_print = kdw_1
		kst_stampe.titolo = trim(k_titolo) //+ " di '" + trim(kwindow_1.title) + "'"
		kst_stampe.titolo_2 = trim(k_titolo_2)

		k_errore = string(kuf1_data_base.stampa_dw(kst_stampe))

	end if
	
	

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

kist_stat_produz.dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
kist_stat_produz.id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
kist_stat_produz.id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
kist_stat_produz.gruppo_flag = tab_1.tabpage_1.dw_1.getitemnumber(1, "gruppo_flag")  
kist_stat_produz.data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
kist_stat_produz.data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  
kist_stat_produz.no_dose = tab_1.tabpage_1.dw_1.getitemstring(1, "no_dose")  
kist_stat_produz.magazzino = tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")  
kist_stat_produz.tipo_data = tab_1.tabpage_1.dw_1.getitemstring(1, "tipo_data") 
kist_stat_produz.data_estrazione_stat =	tab_1.tabpage_1.dw_1.getitemstring(1, "estrazione")
kist_stat_produz.no_prezzo = tab_1.tabpage_1.dw_1.getitemnumber(1, "no_prezzo")  


set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 


//=== Controllo date
	if kist_stat_produz.data_a < kist_stat_produz.data_da then
		kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_anomali)
		kGuo_exception.setmessage("La data di fine periodo (" + string(kist_stat_produz.data_a) &
		                          + ") e' minore di quela di inizio (" + string(kist_stat_produz.data_da) + ")" )
		throw kGuo_exception 
	end if

	if isnull(kist_stat_produz.id_gruppo)  or kist_stat_produz.gruppo_flag = 2 then
		kist_stat_produz.id_gruppo = 0
		kist_stat_produz.gruppo_flag = 2
	end if
	if isnull(kist_stat_produz.gruppo_flag) then
		kist_stat_produz.gruppo_flag = 2
	end if
	tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo", kist_stat_produz.id_gruppo)  
	
	if isnull(kist_stat_produz.dose) then
		kist_stat_produz.dose = 0
		kist_stat_produz.dose_str = "0"
	else
		kist_stat_produz.dose_str = kuf1_utility.u_formatta_decimali(string(kist_stat_produz.dose))
	end if
	if isnull(kist_stat_produz.id_cliente) then
		kist_stat_produz.id_cliente = 0
	end if
	if isnull(kist_stat_produz.no_prezzo) then
		kist_stat_produz.no_prezzo = 1
	end if

//--- il flag potrebbe essere stato ricambiato
	tab_1.tabpage_1.dw_1.setitem(1, "gruppo_flag", kist_stat_produz.gruppo_flag)  


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

		choose case kist_stat_produz.tipo_data
				
			case '1' // x data fine lavorazione
				select min(id_meca), max(id_meca) into :kist_stat_produz.id_meca_da, :kist_stat_produz.id_meca_a 
				    from s_artr 
					 where data_lav_fin between :kist_stat_produz.data_da and :kist_stat_produz.data_a and id_meca > 0;
				if sqlca.sqlcode <> 0 then
					kist_stat_produz.id_meca_da = 0 
				else
					if sqlca.sqlcode = 100 then
						kist_stat_produz.id_meca_da = 9999999 
					end if
				end if
				
	
			case '2' // x data fine fatturazione
				
	//--- piglio i ID_MECA rispetto alla data indicata
				select min(id_meca), max(id_meca) into :kist_stat_produz.id_meca_da, :kist_stat_produz.id_meca_a 
				     from s_arfa 
					  where data_fatt between :kist_stat_produz.data_da and :kist_stat_produz.data_a and id_meca > 0;
				if sqlca.sqlcode < 0 then
					kist_stat_produz.id_meca_da = 0 
				else
					if sqlca.sqlcode = 100 then
						kist_stat_produz.id_meca_da = 9999999 
					end if
				end if
	
				 
			case '3' // x data di riferimento
	//--- piglio i ID_MECA rispetto alla data indicata
				select min(id_meca), max(id_meca) into :kist_stat_produz.id_meca_da, :kist_stat_produz.id_meca_a 
				     from s_armo 
					  where data_int between :kist_stat_produz.data_da and :kist_stat_produz.data_a and id_meca > 0;
				if sqlca.sqlcode < 0 then
					kist_stat_produz.id_meca_da = 0 
				else
					if sqlca.sqlcode = 100 then
						kist_stat_produz.id_meca_da = 9999999 
					end if
				end if
				 
		end choose

		if isnull(kist_stat_produz.id_meca_da) then
			kist_stat_produz.id_meca_da = 9999999 
		end if
		if isnull(kist_stat_produz.id_meca_a) then
			kist_stat_produz.id_meca_a = 0
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


	kist_stat_produz.utente = kg_utente_comp
	if LenA(trim(kist_stat_produz.utente)) > 0 then
		kist_stat_produz.utente = MidA(kist_stat_produz.utente, 1, 4)
		
		k_ctr = PosA(kist_stat_produz.utente, ".") 
		do while k_ctr > 0 
			kist_stat_produz.utente = ReplaceA ( kist_stat_produz.utente, k_ctr, 1, "_" ) 
			k_ctr = PosA( kist_stat_produz.utente, "." ) 
		loop 
//--- aggiungo il numero tab al nome utente
		if LenA(trim(string(tab_1.selectedtab))) = 0 then
			kist_stat_produz.utente = kist_stat_produz.utente + "_" 
		else
			kist_stat_produz.utente = kist_stat_produz.utente + trim(string(ki_tab_1_index_new)) //tab_1.selectedtab)) 
		end if
	else
		kist_stat_produz.utente = ""
		kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_utente)
		kGuo_exception.setmessage("Errore nel reperimento dell'Utente di connessione al sistema,~n~r" &
				+"prego riprovare l'operazione." )
		throw kGuo_exception 
	end if


//
end subroutine

private subroutine crea_view_x_data_fatt_id_meca ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat "
	k_sql = " "                                   
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_meca ) AS   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " s_arfa.id_meca  " &
	 + " FROM  s_arfa  " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  

	
	if kist_stat_produz.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			k_sql += " and gruppo = " + string(kist_stat_produz.id_gruppo) + " "
		else
			k_sql += " and gruppo <> " + string(kist_stat_produz.id_gruppo) + " "
		end if
	end if
	if kist_stat_produz.magazzino <> 9 then
		k_sql += " and magazzino = " + string(kist_stat_produz.magazzino) + " "
	end if
	if kist_stat_produz.dose > 0 then
		k_sql += " and dose = " + kist_stat_produz.dose_str + " "
	end if
	if kist_stat_produz.no_dose = 'S' then
		k_sql += " and dose = 0 " + " "
	else
		k_sql += " and dose > 0 " + " "
	end if
	
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine crea_view_x_data_fatt_id_armo ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_campi
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat "
	k_sql = " "                                   
//	k_sql = + &
//	"CREATE VIEW " + trim(k_view) + " ( id_armo ) AS   " 
	k_campi = " id_armo integer   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + " arfa.id_armo  " &
	 + " FROM  s_arfa inner join arfa on s_arfa.num_fatt = arfa.num_fatt and s_arfa.data_fatt = arfa.data_fatt " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  

	
	if kist_stat_produz.id_cliente > 0 then
		k_sql +=  " and s_arfa.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			k_sql += " and s_arfa.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
		else
			k_sql += " and s_arfa.gruppo <> " + string(kist_stat_produz.id_gruppo) + " "
		end if
	end if
	if kist_stat_produz.magazzino <> 9 then
		k_sql += " and s_arfa.magazzino = " + string(kist_stat_produz.magazzino) + " "
	end if
	if kist_stat_produz.dose > 0 then
		k_sql += " and s_arfa.dose = " + kist_stat_produz.dose_str + " "
	end if
	if kist_stat_produz.no_dose = 'S' then
		k_sql += " and s_arfa.dose = 0 " + " "
	else
		k_sql += " and s_arfa.dose > 0 " + " "
	end if
	
//	kuf1_data_base.db_crea_view(1, k_view, k_sql)		
	kuf1_data_base.db_crea_temp_table(1, k_view, k_campi, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

protected subroutine open_start_window ();//
tab_1.tabpage_1.picturename = kg_path_risorse + "\edit16.gif" 

//---- imposta i nomi dei DW da utilizzare
if ki_st_open_w.id_programma = kkg_id_programma_stat_produz then
	ki_stat_x_gruppi = "d_stat_produz_x_gruppo" 
	ki_stat_x_clienti = "d_ufo" //"d_stat_produz_x_cliente"
else
	ki_stat_x_gruppi = "d_stat_produz_x_gruppo_no_importi" 
	ki_stat_x_clienti = "d_stat_produz_x_cliente_no_importi"
end if
end subroutine

private subroutine crea_view_x_clie_3_id_armo ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string, k_tabella, k_campi 
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
//	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_meca "
	k_tabella = "vx_" + trim(kist_stat_produz.utente) + "_stat_meca "
	k_sql = " "                                   
//	k_sql = + &
//	"CREATE table  " + trim(k_view) &
	k_campi = " id_armo integer, id_meca integer, clie_3 integer, gruppo integer, data_int date   " 

	k_sql +=  &
			 + " SELECT distinct " &
			 + " s_armo.id_armo  " &
			 + " ,s_armo.id_meca  " &
			 + " ,s_armo.clie_3  " &
			 + " ,s_armo.gruppo  " &
			 + " ,s_armo.data_int  " &
			 + " FROM  s_armo  " &
			 + "	where " &  

	choose case kist_stat_produz.tipo_data
			
		case '1', '2' // x data fine lavorazione e fatt
	 
		k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(relativedate(kist_stat_produz.data_da,-180), "dd/mm/yyyy") + "' and '" &
			 + string(relativedate(kist_stat_produz.data_a, +180), "dd/mm/yyyy") + "' "  

		case '3' // x data Riferimento
	 
			k_sql +=  &
			 + "	  s_armo.data_int between '" &
			 + string(kist_stat_produz.data_da, "dd/mm/yyyy") &
			 + "' and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  

	end choose
	
	if kist_stat_produz.id_cliente > 0 then
		k_sql +=  " and s_armo.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
	if kist_stat_produz.id_gruppo > 0 then
		if kist_stat_produz.gruppo_flag = 1 then
			k_sql += " and s_armo.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
		else
			if kist_stat_produz.gruppo_flag = 0 then
				k_sql += " and (s_armo.gruppo <> " + string(kist_stat_produz.id_gruppo) + " or s_armo.gruppo is null)  "
			end if
		end if
	end if
	if kist_stat_produz.magazzino <> 9 then
		k_sql += " and s_armo.magazzino = " + string(kist_stat_produz.magazzino) + " "
	end if
	if kist_stat_produz.no_dose = 'S' then
		k_sql += " and s_armo.dose = 0 " + " "
	else
		if kist_stat_produz.dose > 0 then
			k_sql += " and s_armo.dose = " + kist_stat_produz.dose_str + " "
		end if
	end if
	if kist_stat_produz.no_prezzo = 2 then //escludi prezzi=0
		k_sql += " and (s_armo.imp_fatt > 0 or s_armo.imp_da_fatt > 0) "
	else
		if kist_stat_produz.no_prezzo = 3 then //solo MOVIMENTI con prezzi=0
			k_sql += " and (s_armo.imp_fatt = 0 and s_armo.imp_da_fatt = 0) "
		end if
	end if
	
	kuf1_data_base.db_crea_temp_table(1, k_tabella, k_campi, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

private subroutine crea_view_x_data_fatt ();//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
string k_view, k_sql, k_sql_orig, k_stringn, k_string
boolean k_esegui_query=true
kuf_utility kuf1_utility
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)



//--- costruisco la view con ID_MECA delle fatture emesse da data a data
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_dfat "
	k_sql = " "
	k_sql = &
	"CREATE VIEW " + trim(k_view) &
	 + " ( id_armo ) AS   " 
	 
	k_sql = + k_sql &
	 + " SELECT distinct " &
	 + "     s_arfa.id_armo  " &
	 + " FROM arfa as s_arfa  " &
	 + "	where " &  
	 + "	  s_arfa.data_fatt between '" &
	 + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  

	
	if kist_stat_produz.id_cliente > 0 then
		k_sql +=  " and clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
//	if kist_stat_produz.id_gruppo > 0 then
//		k_sql +=  " and gruppo = " + string(kist_stat_produz.id_gruppo) + " "
//	end if
//	if kist_stat_produz.magazzino <> 9 then
//		k_sql +=  " and magazzino = " + string(kist_stat_produz.magazzino) + " "
//	end if
//	if kist_stat_produz.dose > 0 then
//		k_sql +=  " and dose = " + string(kist_stat_produz.dose, "#0.00") + " "
//	end if
//	if kist_stat_produz.no_dose = 'S' then
//		k_sql +=  " and dose = 0 " + " "
//	else
//		k_sql +=  " and dose > 0 " + " "
//	end if
	
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		


	
//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)

//return k_esegui_query
//
end subroutine

protected function integer inserisci ();//
int k_return	
	
	
	k_return = super::inserisci()
	
	tab_1.selectedtab = 1

return k_return 


end function

on w_stat_produz.create
int iCurrent
call super::create
end on

on w_stat_produz.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
long k_id_meca, k_riga, k_num_int
date k_data_int
window k_window
kuf_menu_window kuf1_menu_window 


//st_open_w kst_open_w

//kst_open_w = Message.PowerObjectParm	

if isvalid(kst_open_w) then

//--- Dalla finestra di Elenco Valori
	if kst_open_w.id_programma = kkg_id_programma_elenco then
	
//--- Controllo che dalla window ELENCO non abbia premuto un tasto
		if kst_open_w.key5 = "id_meca" then

//--- popolo il datasore (dw non visuale) di ritorno da window elenco
			if not isvalid(kdsi_elenco_input) then 
				kdsi_elenco_input = create datastore
			end if
//--- ricavo la data chiave dalla dw tornata dall'elenco
			kdsi_elenco_input = kst_open_w.key12_any 
			k_riga = long(kst_open_w.key3)
			k_id_meca = kdsi_elenco_input.getitemnumber(k_riga, "id_meca")
			k_num_int = kdsi_elenco_input.getitemnumber(k_riga, "num_int")
			k_data_int = kdsi_elenco_input.getitemdate(k_riga, "data_int")
				
		//--- popolo il datasore (dw non visuale) per appoggio elenco
			if not isvalid(kdsi_elenco_output) then 
				kdsi_elenco_output = create datastore
			end if
		
			kdsi_elenco_output.dataobject = "d_stat_produz_dettaglio" 
			kdsi_elenco_output.modify("DataWindow.Tree.Level.1.CollapsedTreeNodeIconName='" + string(kg_path_risorse + "\cartella.ico") + "' ")
			kdsi_elenco_output.modify("DataWindow.Tree.Level.operazione.ExpandedTreeNodeIconName='" + string(kg_path_risorse + "\cartella_open.ico") + "' ")
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			k_rc = kdsi_elenco_output.retrieve    (&
														k_id_meca &
														)
			kst_open_w.key1 = "Elenco di dettaglio del Lotto " + string(k_num_int) &
			                  + ' del ' + string(k_data_int, 'dd.mm.yy')
		
			if kdsi_elenco_output.rowcount() > 0 then
		
				k_window = kuf1_data_base.prendi_win_attiva()
				
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
				kst_open_w.id_programma = "elenco"
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = "el"
				kst_open_w.flag_adatta_win = KK_ADATTA_WIN
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
			
			
	end if

end if
//



end event

event close;call super::close;//
//if isvalid(kiuf_contratti  ) then destroy kiuf_contratti

end event

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_stat_produz
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_stat_produz
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_stat_produz
integer x = 2848
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_stat_produz
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_stat_produz
end type

type dw_trova from w_g_tab_3`dw_trova within w_stat_produz
integer x = 640
integer y = 348
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_stat_produz
integer x = 1207
integer y = 1476
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_stat_produz
integer x = 754
integer y = 1476
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_stat_produz
integer x = 2107
integer y = 1504
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_stat_produz
integer x = 2478
integer y = 1504
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_stat_produz
integer x = 1737
integer y = 1504
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_stat_produz
boolean visible = true
integer x = 0
integer y = 0
integer width = 3424
integer height = 1472
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3387
integer height = 1344
string text = "Parametri"
string picturename = "InkEdit!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 32
integer y = 36
integer width = 3186
integer height = 1244
integer taborder = 50
string dataobject = "d_stat_produz_0"
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
integer width = 3387
integer height = 1344
string text = "Gruppi"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = -5
integer y = 68
integer width = 3104
integer height = 1200
boolean enabled = true
string dataobject = "d_stat_produz_x_gruppo"
end type

event dw_2::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_ctr
string k_codice_prec, k_sql_orig, k_stringn, k_string
//string k_inventario
string k_view, k_sql, k_sql_w
kuf_utility kuf1_utility
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


if dwo.name = "b_dettaglio" then

	kuf1_utility = create kuf_utility

	try 
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	catch ( uo_exception kuo_exception )
	end try		
	

	kist_stat_produz.id_gruppo = tab_1.tabpage_2.dw_2.getitemnumber(row, "gruppo")  

//	k_inventario = "N"
//--- costruisco la view con ID_MECA da usare nello ZOOM
	k_view = "vx_" + trim(kist_stat_produz.utente) + "_stat_impz "
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( gruppo, id_meca, colli_da_sped ) AS   " 
	 
	choose case kist_stat_produz.tipo_data
			
		case '1' // x data fine lavorazione
			k_sql = + k_sql &
			 + " SELECT distinct " &
			 + " s_armo.gruppo  " &
			 + " ,s_armo.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_artr INNER JOIN s_armo ON " &
			 + "  s_artr.id_meca = s_armo.id_meca " &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  	
	 
		case '2' // x data fine fatturazione

			k_sql = + k_sql &
			 + " SELECT distinct " &
			 + " s_armo.gruppo  " &
			 + " ,s_armo.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_armo  " &
			 + "	where " &  
			 + " s_armo.id_meca in " &  
			 + "  (select id_meca from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat )"  
			 
		case '3' // x data di riferimento
			k_sql = + k_sql &
			 + " SELECT distinct " &
			 + " s_armo.gruppo  " &
			 + " ,s_armo.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_armo  " &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' " 
			 
	end choose
	if kist_stat_produz.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
	if kist_stat_produz.gruppo_flag <> 2 then
		if kist_stat_produz.id_gruppo > 0 then
			if kist_stat_produz.gruppo_flag = 1 then
				k_sql_w = k_sql_w +  " and s_armo.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
			else			
				k_sql_w = k_sql_w +  " and s_armo.gruppo <> " + string(kist_stat_produz.id_gruppo) + " "
			end if
		end if
	end if
	if kist_stat_produz.magazzino <> 9 then
		k_sql_w = k_sql_w +  " and s_armo.magazzino = " + string(kist_stat_produz.magazzino) + " "
	end if
	if kist_stat_produz.dose > 0 then
		k_sql_w = k_sql_w + "and s_armo.dose = " + kuf1_utility.u_formatta_decimali(string(kist_stat_produz.dose)) + " "
	end if
	if kist_stat_produz.no_dose = 'S' then
		k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
	else
		k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
	end if
	k_sql = k_sql + " " + trim(k_sql_w) 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		



//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

	kdsi_elenco_output.dataobject = "d_stat_produz_zoom_meca" 
//--- Aggiorna SQL della dw	
	k_sql_orig = kdsi_elenco_output.Object.DataWindow.Table.Select 
	k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_impz"
	k_string = "vx_info_stat_zoom"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	kdsi_elenco_output.Object.DataWindow.Table.Select = k_sql_orig	
	
	k_rc = kdsi_elenco_output.settransobject ( sqlca )
	k_rc = kdsi_elenco_output.reset( )
	k_rc = kdsi_elenco_output.retrieve ()
												
	kst_open_w.key1 = "Zoom di " + kuf1_utility.u_stringa_pulisci(trim(tab_1.tabpage_2.text)) &
							+ ". Gruppo: " + trim(string(kist_stat_produz.id_gruppo))

	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kuf1_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
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
		
		messagebox("Elenco Dati", 	"Nessun valore disponibile. ")
		
	end if
	
	destroy kuf1_utility 
	
end if

//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)


//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3387
integer height = 1344
string text = "Clienti"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer x = 41
integer y = 24
integer width = 3099
integer height = 1192
boolean enabled = true
string dataobject = "d_ufo"
end type

event dw_3::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_ctr
string k_codice_prec, k_sql_orig, k_stringn, k_string
string k_inventario
string k_view, k_sql, k_sql_w
kuf_utility kuf1_utility
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


if dwo.name = "b_dettaglio" or dwo.name = "dettaglio"  then
	
	kuf1_utility = create kuf_utility

	try 
		set_nome_utente_tab() //--- imposta il nome utente da utilizzare x i nomi view 
	catch ( uo_exception kuo_exception )
	end try		

	kist_stat_produz.id_cliente = tab_1.tabpage_3.dw_3.getitemnumber(row, "clie_3")  
	if isnull(kist_stat_produz.id_cliente) then
		kist_stat_produz.id_cliente = 0
	end if

//	k_inventario = "N"

//--- costruisco la view solo x pescare i riferimenti trattati, da usare x lo ZOOM
	k_view = "vx_" + trim(kist_stat_produz.utente)  + "_stat_impz "
	k_sql_w = " "
	k_sql = + &
	"CREATE VIEW " + trim(k_view) &
	 + " ( clie_3, id_meca, colli_da_sped ) AS   " 
	 
	choose case kist_stat_produz.tipo_data
			
		case '1' // x data fine lavorazione
			k_sql = + k_sql &
			 + " SELECT distinct " &
			 + " s_armo.clie_3  " &
			 + " ,s_artr.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_artr INNER JOIN s_armo ON " &
			 + "  s_artr.id_meca = s_armo.id_meca " &
			 + "	where " &  
			 + "	  s_artr.data_lav_fin between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' " 
			 
		case '2' // x data fine fatturazione
			k_sql = + k_sql &
			 + " SELECT distinct " &
			 + " s_armo.clie_3  " &
			 + " ,s_armo.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_armo  " &
			 + "	where " &  
			 + "  s_armo.id_meca in " &  
			 + "  (select id_meca from  " + "vx_" + trim(kist_stat_produz.utente) + "_stat_mfat )"  

		case '3' // x data di riferimento
			k_sql = + k_sql &
			 + " SELECT distinct" &
			 + " s_armo.clie_3  " &
			 + " ,s_armo.id_meca " & 
			 + " ,0 " & 
			 + " FROM s_armo  " &
			 + "	where " &  
			 + "	  s_armo.data_int between '" + string(kist_stat_produz.data_da, "dd/mm/yyyy") + "' " &
			 + " and '" + string(kist_stat_produz.data_a, "dd/mm/yyyy") + "' "  
			 
	end choose
	if kist_stat_produz.id_cliente > 0 then
		k_sql_w =  " and s_armo.clie_3 = " + string(kist_stat_produz.id_cliente) + " "
	end if
	if kist_stat_produz.gruppo_flag <> 2 then
		if kist_stat_produz.id_gruppo > 0 then
			if kist_stat_produz.gruppo_flag = 1 then
				k_sql_w = k_sql_w +  " and s_armo.gruppo = " + string(kist_stat_produz.id_gruppo) + " "
			else			
				k_sql_w = k_sql_w +  " and s_armo.gruppo <> " + string(kist_stat_produz.id_gruppo) + " "
			end if
		end if
	end if
	if kist_stat_produz.magazzino <> 9 then
		k_sql_w = k_sql_w +" and s_armo.magazzino = " + string(kist_stat_produz.magazzino) + " "
	end if
	if kist_stat_produz.dose > 0 then
		k_sql_w = k_sql_w + "and s_armo.dose = " + kuf1_utility.u_formatta_decimali(string(kist_stat_produz.dose)) + " "
	end if
	if kist_stat_produz.no_dose = 'S' then
		k_sql_w = k_sql_w + "and s_armo.dose = 0 " + " "
	else
		k_sql_w = k_sql_w + "and s_armo.dose > 0 " + " "
	end if
	k_sql = k_sql + " " + trim(k_sql_w) 
	kuf1_data_base.db_crea_view(1, k_view, k_sql)		



//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	kdsi_elenco_output.dataobject = "d_stat_produz_zoom_meca" 
//--- Aggiorna SQL della dw	
	k_sql_orig = kdsi_elenco_output.Object.DataWindow.Table.Select 
	k_stringn = "vx_" + trim(kist_stat_produz.utente) + "_stat_impz"
	k_string = "vx_info_stat_zoom"
	k_ctr = PosA(k_sql_orig, k_string, 1)
	DO WHILE k_ctr > 0 and trim(k_string) <> trim(k_stringn)  
		k_sql_orig = ReplaceA(k_sql_orig, k_ctr, LenA(k_string), (k_stringn))
		k_ctr = PosA(k_sql_orig, k_string, k_ctr+LenA(k_string))
	LOOP
	kdsi_elenco_output.Object.DataWindow.Table.Select = k_sql_orig	

	k_rc = kdsi_elenco_output.settransobject ( sqlca )
	k_rc = kdsi_elenco_output.reset( )
	k_rc = kdsi_elenco_output.retrieve ()
												
	kst_open_w.key1 = "Zoom di " + kuf1_utility.u_stringa_pulisci(trim(tab_1.tabpage_3.text)) &
							+ ". Cliente: " + + trim(string(kist_stat_produz.id_cliente))

	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kuf1_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
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

	destroy kuf1_utility
	
end if

//=== Riprist. il vecchio puntatore : 
SetPointer(kpointer)


//
end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3387
integer height = 1344
string text = "fila 1 & 2"
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
boolean visible = true
integer x = -5
integer y = 36
integer width = 3374
integer height = 1212
integer taborder = 10
boolean enabled = true
string dataobject = "d_stat_produz_val_giri"
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3387
integer height = 1344
boolean enabled = false
string powertiptext = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 3214
integer height = 1212
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_cerca = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3387
integer height = 1344
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer width = 3259
integer height = 1244
boolean ki_link_standard_sempre_possibile = true
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3387
integer height = 1344
string powertiptext = "materiale non spedito e fatturato"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer width = 3264
integer height = 1188
boolean ki_link_standard_sempre_possibile = true
boolean ki_d_std_1_attiva_cerca = false
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3387
integer height = 1344
string powertiptext = "materiale trattato ma non spedito "
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
integer width = 3141
string dataobject = "d_stat_inventario_x_cliente_mandante"
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3387
integer height = 1344
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

