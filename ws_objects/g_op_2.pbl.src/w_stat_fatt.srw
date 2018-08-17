$PBExportHeader$w_stat_fatt.srw
forward
global type w_stat_fatt from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_stat_fatt from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3570
integer height = 1784
string title = "Scheda Fatturato Cliente"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_fai_nuovo_dopo_update = false
end type
global w_stat_fatt w_stat_fatt

type variables

private string ki_stat_fatt_1 = "d_stat_fat_1_1"
private string ki_stat_fatt_2 = "d_stat_fat_2"
private string ki_stat_fatt_3 = "d_stat_fat_3"
private string ki_stat_fatt_4 = "d_stat_fat_abc_1"
private string ki_stat_fatt_5 = "d_stat_fat_abc_2"
private string ki_stat_fatt_6 = "d_stat_fat_abc_3"
private string ki_stat_fatt_7 = "d_stat_fat_abc_4"
private string ki_stat_fatt_8 = "d_stat_fat_abc_cpag"


end variables

forward prototypes
protected function string inizializza ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine stampa ()
private subroutine get_parametri (ref st_stat_fatt kst_stat_fatt) throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine open_start_window ()
protected subroutine inizializza_8 () throws uo_exception
protected function integer inserisci ()
end prototypes

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return = "0"
string k_scelta, k_importa=" "
long  k_key, k_id_cliente, k_riga
int k_err_ins, k_rc=0, k_anno, k_id_gruppo, k_anno_base
double k_dose 
date k_data_da, k_data_a
string k_rag_soc, k_indirizzo, k_localita, k_estrazione
kuf_base kuf1_base 
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo, kdwc_gruppo1, kdwc_prodotti,kdwc_prodotti1, kdwc_clie_classi, kdwc_clie_classi_punteggi
st_esito kst_esito




//--- reperisce lo stato dell'ultima estrazione	
if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	kuf1_base = create kuf_base 
	kst_esito = kuf1_base.statistici_stato_elab()
	if kst_esito.esito = kuf1_base.kci_statistici_stato_ko then
		k_return = ki_UsitaImmediata
		messagebox("Estrazioni Statistiche", &
				"L'alimentazione dei dati Statistici non e' terminata correttamente ~n~r" + &
				"impossibile procedere per le estrazioni.~n~r" )
		k_return = ki_UsitaImmediata
	else
		if kst_esito.esito = kuf1_base.kci_statistici_stato_in_esec then
			k_return = ki_UsitaImmediata
			messagebox("Estrazioni Statistiche", &
					"L'alimentazione dei dati Statistici e' in esecuzione, prego riprovare piu' tardi ~n~r" + &
					"impossibile procedere per le estrazioni.~n~r" )
			close(this)
		end if
	
	end if
	destroy kuf1_base 
end if


//--- se tutto ok 
if k_return <> ki_UsitaImmediata then

	
	if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
	//--- 
	
	//--- reperisce descrizione ultima estrazione STATISTICI
		kuf1_base = create kuf_base 
		k_anno_base = year(kg_dataoggi)
		k_estrazione = MidA(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
		destroy kuf1_base 
		
		
		k_scelta = trim(ki_st_open_w.flag_modalita)
		k_id_cliente = long(trim(ki_st_open_w.key1)) //cliente fattura
		k_dose = double(trim(ki_st_open_w.key2))
		k_id_gruppo = integer(trim(ki_st_open_w.key3))
	
		if LenA(trim(ki_st_open_w.key4)) > 0 then
			k_data_da = date(trim(ki_st_open_w.key4)) 
		else
			k_data_da = date(k_anno_base, 01, 01)
		end if
		if LenA(trim(ki_st_open_w.key5)) > 0 then
			k_data_a = date(trim(ki_st_open_w.key5)) 
		else
			k_data_a = date(k_anno_base, 12, 31)
		end if
		k_key = long(trim(ki_st_open_w.key1)) //cliente
		if k_id_cliente > 0 then
			k_importa = "N" //disabilito la importazione poiche' ho estr.personal.
		end if
	
		tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
		tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
		tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
		tab_1.tabpage_1.dw_1.getchild("gru_des", kdwc_gruppo1)
		tab_1.tabpage_1.dw_1.getchild("art", kdwc_prodotti)
		tab_1.tabpage_1.dw_1.getchild("des_art", kdwc_prodotti1)
		tab_1.tabpage_1.dw_1.getchild("id_clie_classe", kdwc_clie_classi)
		tab_1.tabpage_1.dw_1.getchild("classe_punteggio", kdwc_clie_classi_punteggi)
	
		kdwc_cliente.settransobject(sqlca)
		kdwc_dose.settransobject(sqlca)
		kdwc_gruppo.settransobject(sqlca)
		kdwc_gruppo1.settransobject(sqlca)
		kdwc_prodotti.settransobject(sqlca)
		kdwc_prodotti1.settransobject(sqlca)
		kdwc_clie_classi.settransobject(sqlca)
		kdwc_clie_classi_punteggi.settransobject(sqlca)
	
		if k_importa <> "N" or isnull(k_importa) then
			importa_dati_da_ultima_exit()
		end if

		kdwc_cliente.insertrow(1)
		kdwc_dose.insertrow(1)
		kdwc_gruppo.insertrow(1)
		kdwc_gruppo1.insertrow(1)
		kdwc_prodotti.insertrow(1)
		kdwc_prodotti1.insertrow(1)
		kdwc_clie_classi.insertrow(1)
		kdwc_clie_classi_punteggi.insertrow(1)

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
				if kdwc_gruppo.rowcount() < 2 then
					kdwc_gruppo.retrieve()
					kdwc_gruppo.insertrow(1)
					kdwc_gruppo1.reset( )
					kdwc_gruppo1.retrieve()
					kdwc_gruppo1.insertrow(1)
					k_riga=kdwc_gruppo.find("codice = "+string(k_id_gruppo), 0, kdwc_gruppo.rowcount())
					if k_riga > 0 then
						tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",  kdwc_gruppo.getitemnumber(k_riga, "codice"))
						tab_1.tabpage_1.dw_1.setitem(1, "gru_des", kdwc_gruppo.getitemstring(k_riga, "des"))
					end if
				end if
		//	end if



			if kdwc_prodotti.rowcount() < 2 then
				kdwc_prodotti.retrieve("%")
				kdwc_prodotti.insertrow(1)
				kdwc_prodotti.setrow( 1 )
				tab_1.tabpage_1.dw_1.setitem(1, "art", " ")
				tab_1.tabpage_1.dw_1.setitem(1, "des_art"," ")
			end if

			if kdwc_prodotti1.rowcount() < 2 then
				kdwc_prodotti1.retrieve("")
				kdwc_prodotti1.insertrow(1)
				kdwc_prodotti1.setrow( 1 )
				tab_1.tabpage_1.dw_1.setitem(1, "art", " ")
				tab_1.tabpage_1.dw_1.setitem(1, "des_art"," ")
			end if

			if kdwc_clie_classi.rowcount() < 2 then
				kdwc_clie_classi.retrieve()
				kdwc_clie_classi.insertrow(1)
				kdwc_clie_classi.setrow( 1 )
				tab_1.tabpage_1.dw_1.setitem(1, "id_clie_classe", " ")
			end if
			if kdwc_clie_classi_punteggi.rowcount() < 2 then
				kdwc_clie_classi_punteggi.retrieve()
				kdwc_clie_classi_punteggi.insertrow(1)
				kdwc_clie_classi_punteggi.setrow( 1 )
				tab_1.tabpage_1.dw_1.setitem(1, "classe_punteggio", " ")
			end if
				
			tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
			tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
			
		
		end if

		tab_1.tabpage_1.dw_1.setitem(1, "estrazione", k_estrazione)
	
	end if

	
	//		tab_1.tabpage_1.dw_1.setcolumn(1)
	
	tab_1.tabpage_1.dw_1.setfocus()
				
	attiva_tasti()

end if		
		
return k_return 
	



end function

protected subroutine inizializza_2 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility kuf1_utility
pointer kp_1



//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_3.st_3_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_3.st_3_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_3.st_3_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then    

		tab_1.tabpage_3.dw_3.dataobject = ki_stat_fatt_2 + "_prod"
		tab_1.tabpage_3.dw_3.settransobject( sqlca)
		tab_1.tabpage_3.dw_3.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
												)
	else
		tab_1.tabpage_3.dw_3.dataobject = ki_stat_fatt_2 
		tab_1.tabpage_3.dw_3.settransobject( sqlca)
		tab_1.tabpage_3.dw_3.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio &
													)
	

	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
//	else
//		if k_dose = 0 then
//			st_parametri.text = replace(st_parametri.text, 3, 10, &
//					string(tab_1.tabpage_3.dw_3.getitemnumber(1, "dose"), "0000000000")) 
//		end if
end if

tab_1.tabpage_3.dw_3.setfocus()



//
end subroutine

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if Len(trim(tab_1.tabpage_2.st_2_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_2.st_2_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_2.st_2_retrieve.text <> kst_stat_fatt.k_codice_prec then

	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_art)) > 0 then  

		tab_1.tabpage_2.dw_2.dataobject = ki_stat_fatt_1 + "_prod"
		tab_1.tabpage_2.dw_2.settransobject( sqlca)
		
		tab_1.tabpage_2.dw_2.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_totale, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio &
												)
	else
		
		if len(trim(kst_stat_fatt.k_id_clie_classe)) > 0 or len(trim(kst_stat_fatt.k_classe_punteggio)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then  

			tab_1.tabpage_2.dw_2.dataobject = ki_stat_fatt_1 + '_filtri'
			tab_1.tabpage_2.dw_2.settransobject( sqlca)
			tab_1.tabpage_2.dw_2.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_totale, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione & 
												)
		else
			tab_1.tabpage_2.dw_2.dataobject = ki_stat_fatt_1 
			tab_1.tabpage_2.dw_2.settransobject( sqlca)
			tab_1.tabpage_2.dw_2.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_totale, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino &
												)
		end if
	end if

	setpointer(kp_1)
					
end if				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if
tab_1.tabpage_2.dw_2.setfocus()

	
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_4.st_4_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_4.st_4_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_4.st_4_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_4.st_4_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0  then  

		tab_1.tabpage_4.dw_4.dataobject = ki_stat_fatt_3 + "_prod"
		tab_1.tabpage_4.dw_4.settransobject( sqlca)
		tab_1.tabpage_4.dw_4.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
												)
	else
		tab_1.tabpage_4.dw_4.dataobject = ki_stat_fatt_3 
		tab_1.tabpage_4.dw_4.settransobject( sqlca)
		tab_1.tabpage_4.dw_4.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio &
													)


	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	tab_1.tabpage_4.dw_4.insertrow(0) 
end if

tab_1.tabpage_4.dw_4.setfocus()
	

//
end subroutine

protected subroutine inizializza_4 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_5.st_5_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_5.st_5_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_5.st_5_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_5.st_5_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then  

		tab_1.tabpage_5.dw_5.dataobject = ki_stat_fatt_4 + "_prod"
		tab_1.tabpage_5.dw_5.settransobject( sqlca)
		tab_1.tabpage_5.dw_5.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
												)
	else
		tab_1.tabpage_5.dw_5.dataobject = ki_stat_fatt_4 
		tab_1.tabpage_5.dw_5.settransobject( sqlca)
		tab_1.tabpage_5.dw_5.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio &
													)
	
	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_5.dw_5.rowcount() = 0 then
	tab_1.tabpage_5.dw_5.insertrow(0) 
end if

tab_1.tabpage_5.dw_5.setfocus()
	

end subroutine

protected subroutine inizializza_5 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 6 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_6.st_6_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_6.st_6_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_6.st_6_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_6.st_6_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

//	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then  
//
//		tab_1.tabpage_6.dw_6.dataobject = ki_stat_fatt_5 + "_prod"
//		tab_1.tabpage_6.dw_6.settransobject( sqlca)
//		
//		tab_1.tabpage_6.dw_6.retrieve(  &
//												kst_stat_fatt.k_id_gruppo, &
//												kst_stat_fatt.k_id_cliente, &
//												kst_stat_fatt.k_dose, &
//												kst_stat_fatt.k_data_da, &
//												kst_stat_fatt.k_data_a, &
//												kst_stat_fatt.k_no_dose, &
//												kst_stat_fatt.k_no_gruppo, &
//												kst_stat_fatt.k_magazzino, &
//												kst_stat_fatt.k_art, &
//												kst_stat_fatt.k_id_clie_classe, &
//												kst_stat_fatt.k_classe_punteggio, &
//												kst_stat_fatt.k_regione &
//												)
//	else
		tab_1.tabpage_6.dw_6.dataobject = ki_stat_fatt_5 
		tab_1.tabpage_6.dw_6.settransobject( sqlca)
		tab_1.tabpage_6.dw_6.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
													)

//	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_6.dw_6.rowcount() = 0 then
	tab_1.tabpage_6.dw_6.insertrow(0) 
end if

tab_1.tabpage_6.dw_6.setfocus()
	

end subroutine

protected subroutine inizializza_6 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 7 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1



//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_7.st_7_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_7.st_7_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_7.st_7_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_7.st_7_retrieve.text <> kst_stat_fatt.k_codice_prec then

	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then  

		tab_1.tabpage_7.dw_7.dataobject = ki_stat_fatt_6 + "_prod"
		tab_1.tabpage_7.dw_7.settransobject( sqlca)
		tab_1.tabpage_7.dw_7.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
												)
	else
		tab_1.tabpage_7.dw_7.dataobject = ki_stat_fatt_6 
		tab_1.tabpage_7.dw_7.settransobject( sqlca)
		tab_1.tabpage_7.dw_7.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio &
													)


	end if

	setpointer(kp_1)

end if

attiva_tasti()

if tab_1.tabpage_7.dw_7.rowcount() = 0 then
	tab_1.tabpage_7.dw_7.insertrow(0) 
end if

tab_1.tabpage_7.dw_7.setfocus()
	

end subroutine

protected subroutine stampa ();//=== stampa dw
string k_errore, k_titolo=" ", k_titolo_2=" "
integer k_rc
w_g_tab kwindow_1
datawindow kdw_1
st_stampe kst_stampe
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo, kdwc_clie_classe




	choose case tab_1.selectedtab 
		case 1
			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
			if kdwc_cliente.rowcount() < 2 then
				k_rc=kdwc_cliente.retrieve("")
				kdwc_cliente.insertrow(1)
			end if
			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
			if kdwc_dose.rowcount() < 2 then
				kdwc_dose.retrieve()
				kdwc_dose.insertrow(1)
			end if	
			tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
			if kdwc_gruppo.rowcount() < 2 then
				kdwc_gruppo.retrieve()
				kdwc_gruppo.insertrow(1)
			end if	
			tab_1.tabpage_1.dw_1.getchild("id_clie_classe", kdwc_clie_classe)
			if kdwc_clie_classe.rowcount() < 2 then
				kdwc_clie_classe.retrieve()
				kdwc_clie_classe.insertrow(1)
			end if	
			kdw_1 = tab_1.tabpage_1.dw_1
			k_titolo = tab_1.tabpage_1.text
		case 2
			kdw_1 = tab_1.tabpage_2.dw_2
			k_titolo = tab_1.tabpage_2.text
		case 3
			kdw_1 = tab_1.tabpage_3.dw_3
			k_titolo = tab_1.tabpage_3.text
		case 4
			kdw_1 = tab_1.tabpage_4.dw_4
			k_titolo = tab_1.tabpage_4.text
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

//		kwindow_1 = kGuf_data_base.prendi_win_attiva()
		
		kst_stampe.tipo = ""
		kst_stampe.dw_print = kdw_1
		kst_stampe.titolo = trim(k_titolo) //+ " di '" + trim(kwindow_1.title) + "'"
		kst_stampe.titolo_2 = trim(k_titolo_2)

		if kst_stampe.dw_print.describe("kgr_1.visible") = "1" then
//				if kst_stampe.dw_print.object.kgr_1.visible = "1" then
			kst_stampe.tipo = "gr"
//				end if
		end if

		k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))

	end if
	
	

end subroutine

private subroutine get_parametri (ref st_stat_fatt kst_stat_fatt) throws uo_exception;//
//======================================================================
//=== Legge i parametri immessi nella mappa  e li salva nella st_stat_fatt
//======================================================================
//



kst_stat_fatt.k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
kst_stat_fatt.k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
kst_stat_fatt.k_regione = tab_1.tabpage_1.dw_1.getitemstring(1, "regione")  
kst_stat_fatt.k_id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
kst_stat_fatt.k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
kst_stat_fatt.k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  
kst_stat_fatt.k_totale = tab_1.tabpage_1.dw_1.getitemstring(1, "totale")  
kst_stat_fatt.k_no_dose = tab_1.tabpage_1.dw_1.getitemstring(1, "no_dose")  
kst_stat_fatt.k_no_gruppo = tab_1.tabpage_1.dw_1.getitemstring(1, "no_gruppo")  
kst_stat_fatt.k_magazzino = tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")  
kst_stat_fatt.k_art = tab_1.tabpage_1.dw_1.getitemstring(1, "art")  
kst_stat_fatt.k_id_clie_classe = tab_1.tabpage_1.dw_1.getitemstring(1, "id_clie_classe")  
kst_stat_fatt.k_classe_punteggio = tab_1.tabpage_1.dw_1.getitemstring(1, "classe_punteggio")  

if isnull(kst_stat_fatt.k_data_da) then
	kst_stat_fatt.k_data_da = date("01/01/1900")
end if
if isnull(kst_stat_fatt.k_data_a) or kst_stat_fatt.k_data_a = date(0) then
	kst_stat_fatt.k_data_a = date("01/01/9999")
end if
if isnull(kst_stat_fatt.k_no_dose) or LenA(trim(kst_stat_fatt.k_no_dose)) = 0 then
	kst_stat_fatt.k_no_dose = "N"
end if
if isnull(kst_stat_fatt.k_no_gruppo) or Len(trim(kst_stat_fatt.k_no_gruppo)) = 0 then
	kst_stat_fatt.k_no_gruppo = "N"
end if
if isnull(kst_stat_fatt.k_id_gruppo) then
	kst_stat_fatt.k_id_gruppo = 0
end if
if isnull(kst_stat_fatt.k_dose) then
	kst_stat_fatt.k_dose = 0
end if
if isnull(kst_stat_fatt.k_id_cliente) then
	kst_stat_fatt.k_id_cliente = 0
end if
if isnull(kst_stat_fatt.k_totale) then
	kst_stat_fatt.k_totale = "N"
end if
if isnull(kst_stat_fatt.k_art) then
	kst_stat_fatt.k_art = ""
end if
if isnull(kst_stat_fatt.k_regione ) then
	kst_stat_fatt.k_regione = ""
end if
if isnull(kst_stat_fatt.k_id_clie_classe ) then
	kst_stat_fatt.k_id_clie_classe = ""
end if

if isnull(kst_stat_fatt.k_classe_punteggio ) then
	kst_stat_fatt.k_classe_punteggio = ""
end if

//=== Controllo date
if kst_stat_fatt.k_data_a < kst_stat_fatt.k_data_da then
	kGuo_exception.set_tipo(kGuo_exception.KK_st_uo_exception_tipo_dati_anomali)
	kGuo_exception.setmessage("Attenzione: Data fine periodo (" + string(kst_stat_fatt.k_data_a) + ") minore di quella di inizio (" + string(kst_stat_fatt.k_data_da) + ")" )
	throw kGuo_exception 
end if

	
end subroutine

protected subroutine inizializza_7 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 7 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_8.st_8_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_8.st_8_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_8.st_8_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_8.st_8_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

	if len(trim(kst_stat_fatt.k_id_clie_classe)) > 0 or len(trim(kst_stat_fatt.k_classe_punteggio)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0  then  
		tab_1.tabpage_8.dw_8.dataobject = ki_stat_fatt_7 + "_filtri"
		tab_1.tabpage_8.dw_8.settransobject( sqlca)

		tab_1.tabpage_8.dw_8.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
												)
	
	else
		tab_1.tabpage_8.dw_8.dataobject = ki_stat_fatt_7 
		tab_1.tabpage_8.dw_8.settransobject( sqlca)

		tab_1.tabpage_8.dw_8.retrieve(  &
												kst_stat_fatt.k_id_gruppo, &
												kst_stat_fatt.k_id_cliente, &
												kst_stat_fatt.k_dose, &
												kst_stat_fatt.k_data_da, &
												kst_stat_fatt.k_data_a, &
												kst_stat_fatt.k_no_dose, &
												kst_stat_fatt.k_no_gruppo, &
												kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_art &
												)
	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_8.dw_8.rowcount() = 0 then
	tab_1.tabpage_8.dw_8.insertrow(0) 
end if

tab_1.tabpage_8.dw_8.setfocus()
	

end subroutine

protected subroutine open_start_window ();//
tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\edit16.gif" 


end subroutine

protected subroutine inizializza_8 () throws uo_exception;//======================================================================
//=== Inizializzazione del TAB 9 controllandone i valori se gia' presenti
//======================================================================
//
st_stat_fatt kst_stat_fatt
kuf_utility  kuf1_utility
pointer kp_1


//--- riempie la struttura con i paramtri di query
get_parametri(kst_stat_fatt)

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if LenA(trim(tab_1.tabpage_9.st_9_retrieve.text)) > 0 then
	kst_stat_fatt.k_codice_prec = tab_1.tabpage_9.st_9_retrieve.text
else
	kst_stat_fatt.k_codice_prec = " "
end if

//--- salvo i parametri cosi come sono stati immessi
kuf1_utility = create kuf_utility
tab_1.tabpage_9.st_9_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
destroy kuf1_utility

if tab_1.tabpage_9.st_9_retrieve.text <> kst_stat_fatt.k_codice_prec then
	kp_1 = setpointer(HourGlass!)

//	if len(trim(kst_stat_fatt.k_art)) > 0 or len(trim(kst_stat_fatt.k_regione)) > 0 then  
//
//		tab_1.tabpage_9.dw_9.dataobject = ki_stat_fatt_5 + "_prod"
//		tab_1.tabpage_9.dw_9.settransobject( sqlca)
//		
//		tab_1.tabpage_9.dw_9.retrieve(  &
//												kst_stat_fatt.k_id_gruppo, &
//												kst_stat_fatt.k_id_cliente, &
//												kst_stat_fatt.k_dose, &
//												kst_stat_fatt.k_data_da, &
//												kst_stat_fatt.k_data_a, &
//												kst_stat_fatt.k_no_dose, &
//												kst_stat_fatt.k_no_gruppo, &
//												kst_stat_fatt.k_magazzino, &
//												kst_stat_fatt.k_art, &
//												kst_stat_fatt.k_id_clie_classe, &
//												kst_stat_fatt.k_classe_punteggio, &
//												kst_stat_fatt.k_regione &
//												)
//	else
		tab_1.tabpage_9.dw_9.dataobject = ki_stat_fatt_8 
		tab_1.tabpage_9.dw_9.settransobject( sqlca)
		tab_1.tabpage_9.dw_9.retrieve(  &
													kst_stat_fatt.k_id_gruppo, &
													kst_stat_fatt.k_id_cliente, &
													kst_stat_fatt.k_dose, &
													kst_stat_fatt.k_data_da, &
													kst_stat_fatt.k_data_a, &
													kst_stat_fatt.k_no_dose, &
													kst_stat_fatt.k_no_gruppo, &
													kst_stat_fatt.k_magazzino, &
												kst_stat_fatt.k_id_clie_classe, &
												kst_stat_fatt.k_classe_punteggio, &
												kst_stat_fatt.k_regione &
													)

//	end if
	setpointer(kp_1)
end if

attiva_tasti()

if tab_1.tabpage_9.dw_9.rowcount() = 0 then
	tab_1.tabpage_9.dw_9.insertrow(0) 
end if

tab_1.tabpage_9.dw_9.setfocus()
	

end subroutine

protected function integer inserisci ();//
int k_return	
	
	
	k_return = super::inserisci()
	
	tab_1.selectedtab = 1

return k_return 

	
end function

on w_stat_fatt.create
int iCurrent
call super::create
end on

on w_stat_fatt.destroy
call super::destroy
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_stat_fatt
integer x = 2121
integer y = 1280
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_stat_fatt
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_stat_fatt
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_stat_fatt
integer x = 2848
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_stat_fatt
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_stat_fatt
integer x = 1207
integer y = 1476
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_stat_fatt
integer x = 754
integer y = 1476
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_stat_fatt
integer x = 2107
integer y = 1504
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_stat_fatt
integer x = 2478
integer y = 1504
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_stat_fatt
integer x = 1737
integer y = 1504
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_stat_fatt
integer x = 114
integer y = 20
integer width = 3323
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
integer width = 3287
integer height = 1344
string text = "Parametri"
string picturename = "InkEdit!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event ue_itemchanged ( string k_nome,  string k_dato )
integer x = 18
integer y = 36
integer width = 3095
integer height = 1264
integer taborder = 50
string dataobject = "d_stat_fat_0"
boolean ki_link_standard_attivi = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::ue_itemchanged(string k_nome, string k_dato);//
int k_errore=0
long k_riga
string k_rag_soc
st_stat_fatt kst_stat_fatt
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo,  kdwc_t_lavoro, kdwc_prodotti, kdwc_prodotti1, kdwc_clie_classe


choose case k_nome 

	case "rag_soc_1" 
		k_rag_soc = k_dato
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
		if isnumber(k_dato) then
			kst_stat_fatt.k_id_cliente = long(k_dato)
			if kst_stat_fatt.k_id_cliente > 0 then
				tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
				if kdwc_cliente.rowcount() < 2 then
					kdwc_cliente.retrieve("%")
					kdwc_cliente.insertrow(1)
				end if
				k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
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
		end if

	case "dose" 
//		k_anno = integer(mid(st_parametri.text, 13, 4))
	//	k_anno = year(tab_1.tabpage_1.dw_1.getitemdate(1, "anno"))
		if isnumber(k_dato) then
			kst_stat_fatt.k_dose = double(k_dato)
			if kst_stat_fatt.k_dose > 0 then
				tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
				if kdwc_dose.rowcount() < 2 then
					kdwc_dose.retrieve()
					kdwc_dose.insertrow(1)
				end if
				k_riga=kdwc_dose.find("dose = "+string(kst_stat_fatt.k_dose),&
										0, kdwc_dose.rowcount())
				if k_riga > 0 then
	//				tab_1.tabpage_1.dw_1.setitem(1, "id_commessa",&
	//								kdwc_dose.getitemnumber(k_riga, "id_commessa"))
					tab_1.tabpage_1.dw_1.setitem(1, "dose",&
									kdwc_dose.getitemnumber(k_riga, "dose"))
	//				tab_1.tabpage_1.dw_1.setitem(1, "titolo",&
	//								kdwc_dose.getitemstring(k_riga, "titolo"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "dose", kst_stat_fatt.k_dose)
				end if
				k_errore = 1
			else
	//			tab_1.tabpage_1.dw_1.setitem(1, "dose",0)
	
			end if
		end if

	case "id_gruppo" 
		if isnumber(k_dato) then
			kst_stat_fatt.k_id_gruppo = long(k_dato)
			if kst_stat_fatt.k_id_gruppo > 0 then
				tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)
				if kdwc_gruppo.rowcount() < 2 then
					kdwc_gruppo.retrieve()
					kdwc_gruppo.insertrow(1)
				end if
				k_riga=kdwc_gruppo.find("codice = "+string(kst_stat_fatt.k_id_gruppo), 0, kdwc_gruppo.rowcount())
				if k_riga > 0 then
					tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",	kdwc_gruppo.getitemnumber(k_riga, "codice"))
					tab_1.tabpage_1.dw_1.setitem(1, "gru_des", kdwc_gruppo.getitemstring(k_riga, "des"))
				else
					tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",0)
					tab_1.tabpage_1.dw_1.setitem(1, "gru_des","")
				end if
				k_errore = 1
			else
				tab_1.tabpage_1.dw_1.setitem(1, "gru_des","")
			end if

//--- filtra il GRUPPO sugli articoli
			tab_1.tabpage_1.dw_1.getchild("art", kdwc_prodotti)
			if kdwc_prodotti.rowcount() < 2 then
				kdwc_prodotti.retrieve("%")
				kdwc_prodotti.insertrow(1)
			end if
			if kdwc_gruppo.getitemnumber(k_riga, "codice") > 0 then
				kdwc_prodotti.SetFilter("gruppo = "+string(kdwc_gruppo.getitemnumber(k_riga, "codice")) )
			else
				kdwc_prodotti.SetFilter("")
			end if
			k_riga=kdwc_prodotti.filter()
			
		end if
		
	case "gru_des" 
		kst_stat_fatt.k_gru_des = trim(k_dato)
		if len(trim(kst_stat_fatt.k_gru_des)) > 0 then
			tab_1.tabpage_1.dw_1.getchild("gru_des", kdwc_gruppo)
			if kdwc_gruppo.rowcount() < 2 then
				kdwc_gruppo.retrieve()
				kdwc_gruppo.insertrow(1)
			end if
			k_riga=kdwc_gruppo.find("des like '%"+ trim(kst_stat_fatt.k_gru_des) + "%' ", 0, kdwc_gruppo.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",	kdwc_gruppo.getitemnumber(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "gru_des",kdwc_gruppo.getitemstring(k_riga, "des"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",0)
				tab_1.tabpage_1.dw_1.setitem(1, "gru_des","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "gru_des","")
		end if

//--- filtra il GRUPPO sugli articoli
		tab_1.tabpage_1.dw_1.getchild("art", kdwc_prodotti)
		if kdwc_prodotti.rowcount() < 2 then
			kdwc_prodotti.retrieve("%")
			kdwc_prodotti.insertrow(1)
		end if
		if kdwc_gruppo.getitemnumber(k_riga, "codice") > 0 then
			kdwc_prodotti.SetFilter("gruppo = "+string(kdwc_gruppo.getitemnumber(k_riga, "codice")) )
		else
			kdwc_prodotti.SetFilter("")
		end if
		k_riga=kdwc_prodotti.filter()
			

	case "art" 
		kst_stat_fatt.k_art = trim(k_dato)
		if Len(kst_stat_fatt.k_art) > 0 then
			tab_1.tabpage_1.dw_1.getchild("art", kdwc_prodotti)
			if kdwc_prodotti.rowcount() < 2 then
				kdwc_prodotti.retrieve("%")
				kdwc_prodotti.insertrow(1)
			end if
			k_riga=kdwc_prodotti.find("codice like '%"+trim(kst_stat_fatt.k_art)+"%'", 0, kdwc_prodotti.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "art",	kdwc_prodotti.getitemstring(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "des_art", kdwc_prodotti.getitemstring(k_riga, "des"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "art", " ")
				tab_1.tabpage_1.dw_1.setitem(1, "des_art","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "des_art","")
		end if

	case "des_art" 
		kst_stat_fatt.k_art_des = trim(k_dato)
		if Len(kst_stat_fatt.k_art_des) > 0 then
			tab_1.tabpage_1.dw_1.getchild("des_art", kdwc_prodotti1)
			if kdwc_prodotti1.rowcount() < 2 then
				kdwc_prodotti1.retrieve("%")
				kdwc_prodotti1.insertrow(1)
			end if
			k_riga=kdwc_prodotti1.find("des like '%"+trim(kst_stat_fatt.k_art_des)+"%'", 0, kdwc_prodotti1.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "art",	kdwc_prodotti1.getitemstring(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "des_art", kdwc_prodotti1.getitemstring(k_riga, "des"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "art", " ")
				tab_1.tabpage_1.dw_1.setitem(1, "des_art","")
			end if
			k_errore = 1
		else
			tab_1.tabpage_1.dw_1.setitem(1, "des_art","")
		end if

	case "id_clie_classe" 
			tab_1.tabpage_1.dw_1.getchild("id_clie_classe", kdwc_clie_classe)
			if kdwc_clie_classe.rowcount() < 2 then
				kdwc_clie_classe.retrieve()
				kdwc_clie_classe.insertrow(1)
			end if	


end choose 


	

	



end event

event dw_1::itemchanged;call super::itemchanged;//

post event ue_itemchanged( dwo.name, trim(this.gettext()) )


end event

event dw_1::clicked;//
int k_anno
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo, kdwc_gruppo1, kdwc_prodotti, kdwc_prodotti1, kdwc_clie_classe


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
	
		case "id_clie_classe"
			tab_1.tabpage_1.dw_1.getchild("id_clie_classe", kdwc_clie_classe)
			if kdwc_clie_classe.rowcount() < 2 then
				kdwc_clie_classe.retrieve()
				kdwc_clie_classe.insertrow(1)
			end if	
	
		case "gru_des"
			tab_1.tabpage_1.dw_1.getchild("gru_des", kdwc_gruppo1)
			if kdwc_gruppo1.rowcount() < 2 then
				kdwc_gruppo1.retrieve()
				kdwc_gruppo1.insertrow(1)
			end if	
	
		case "art"
			tab_1.tabpage_1.dw_1.getchild("art", kdwc_prodotti)
			if kdwc_prodotti.rowcount() < 2 then
				kdwc_prodotti.retrieve("%")
				kdwc_prodotti.insertrow(1)
			end if	
	
		case "des_art"
			tab_1.tabpage_1.dw_1.getchild("des_art", kdwc_prodotti1)
			if kdwc_prodotti1.rowcount() < 2 then
				kdwc_prodotti1.retrieve("")
				kdwc_prodotti1.insertrow(1)
			end if	
			
	end choose
end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 283
integer y = 988
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3287
integer height = 1344
long backcolor = 32435950
string text = "Totali"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 3104
integer height = 1308
boolean enabled = true
string dataobject = "d_stat_fat_1_1"
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_2.dw_2.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_2.dw_2.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_2.dw_2.object.kcb_gr.text = "Dati"
	tab_1.tabpage_2.dw_2.object.kgr_1.visible = "1"
end if
//

end event

event dw_2::clicked;//
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
string text = "Dettaglio"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer y = 12
integer width = 3099
integer height = 1328
boolean enabled = true
string dataobject = "d_stat_fat_2"
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_3.dw_3.object.kcb_gr.text = "Dati"
	tab_1.tabpage_3.dw_3.object.kgr_1.visible = "1"
end if
//

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
string text = "Fatturato Mensile"
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
integer x = 0
integer y = 16
integer width = 3077
integer height = 1280
integer taborder = 10
boolean enabled = true
string dataobject = "d_stat_fat_3"
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
string text = "ABC Clienti"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 937
integer height = 1212
boolean enabled = true
string dataobject = "d_stat_fat_abc_1"
end type

event dw_5::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	this.object.kcb_gr.text = "Grafico"
	this.object.kgr_1.visible = "0" 
else
	this.object.kcb_gr.text = "Dati"
	this.object.kgr_1.visible = "1"
end if
//

end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
boolean enabled = true
string text = "ABC Gruppi"
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
boolean visible = true
integer width = 946
integer height = 1244
boolean enabled = true
string dataobject = "d_stat_fat_abc_2"
end type

event dw_6::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	this.object.kcb_gr.text = "Grafico"
	this.object.kgr_1.visible = "0" 
else
	this.object.kcb_gr.text = "Dati"
	this.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
boolean enabled = true
string text = "ABC Dosi"
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean visible = true
integer height = 1188
boolean enabled = true
string dataobject = "d_stat_fat_abc_3"
end type

event dw_7::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	this.object.kcb_gr.text = "Grafico"
	this.object.kgr_1.visible = "0" 
else
	this.object.kcb_gr.text = "Dati"
	this.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
boolean enabled = true
string text = "ABC Articoli"
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean visible = true
boolean enabled = true
string dataobject = "d_stat_fat_abc_4"
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
boolean visible = true
integer width = 3287
integer height = 1344
boolean enabled = true
string text = "ABC Tipi Pagam."
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
boolean visible = true
boolean enabled = true
string dataobject = "d_stat_fat_abc_cpag"
end type

event dw_9::buttonclicked;call super::buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	this.object.kcb_gr.text = "Grafico"
	this.object.kgr_1.visible = "0" 
else
	this.object.kcb_gr.text = "Dati"
	this.object.kgr_1.visible = "1"
end if
//

end event

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

