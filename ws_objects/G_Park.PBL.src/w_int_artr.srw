$PBExportHeader$w_int_artr.srw
forward
global type w_int_artr from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_int_artr from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3269
integer height = 2156
string title = "Interrogazioni: Trattamento"
end type
global w_int_artr w_int_artr

forward prototypes
private subroutine attiva_tasti ()
protected subroutine inizializza ()
protected subroutine inizializza_2 ()
protected subroutine inizializza_1 ()
protected subroutine inizializza_3 ()
end prototypes

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


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
//		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
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
            
attiva_menu()

end subroutine

protected subroutine inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long  k_key, k_clie_1, k_clie_2, k_riga
int k_err_ins, k_rc=0, k_anno
double k_dose 
date k_data_da, k_data_a, k_data_ini, k_data_ini_1, k_data_null 
string k_rag_soc, k_indirizzo, k_localita
string k_trattamento, k_barcode
string k_codice_attuale, k_codice_prec
datawindowchild kdwc_cliente, kdwc_dose, kdwc_cliente_2, kdwc_cliente_3

	
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
//	k_anno = integer(mid(st_parametri.text, 13, 4))


	tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
	tab_1.tabpage_1.dw_1.getchild("clie_2", kdwc_cliente_2)
	tab_1.tabpage_1.dw_1.getchild("clie_3", kdwc_cliente_3)
	tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)


	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_2.settransobject(sqlca)
	kdwc_cliente_3.settransobject(sqlca)
	kdwc_dose.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		kdwc_cliente.retrieve("%")
		kdwc_cliente_2.retrieve("%")
		kdwc_cliente.insertrow(1)
		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_2, 1, Primary!)
		kdwc_cliente.RowsCopy(1, kdwc_cliente.RowCount(), Primary!, kdwc_cliente_3, 1, Primary!)

		kdwc_dose.retrieve(0)
		kdwc_dose.insertrow(1)

		tab_1.tabpage_1.dw_1.insertrow(0)
		
	end if
	
	if k_clie_1 > 0 then
		if kdwc_cliente.rowcount() < 2 then
			kdwc_cliente.insertrow(0)
			k_riga=kdwc_cliente.find("codice = "+string(k_clie_1),&
									0, kdwc_cliente.rowcount())
			if k_riga > 0 then
	  			tab_1.tabpage_1.dw_1.setitem(1, "clie_1", &
								kdwc_cliente.getitemnumber(k_riga, "codice"))
			end if
		end if
	end if
	
	if k_clie_2 > 0 then
		if kdwc_cliente_2.rowcount() < 2 then
			kdwc_cliente_2.insertrow(0)
			k_riga=kdwc_cliente_2.find("codice = "+string(k_clie_2),&
									0, kdwc_cliente_2.rowcount())
			if k_riga > 0 then
	  			tab_1.tabpage_1.dw_1.setitem(1, "clie_2", &
								kdwc_cliente_2.getitemnumber(k_riga, "codice"))
			end if
		end if
	end if
	
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
	

//		tab_1.tabpage_1.dw_1.setcolumn(1)
	tab_1.tabpage_1.dw_1.setfocus()
				
	attiva_tasti()
		


	



end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long  k_key, k_clie_1, k_clie_2, k_clie_3, k_riga
int k_err_ins, k_rc=0, k_anno
double k_dose 
date k_data_da, k_data_a, k_data_ini, k_data_ini_1, k_data_fin, k_data_fin_1, k_data_null 
string k_rag_soc, k_indirizzo, k_localita
string k_trattamento, k_barcode
string k_codice_attuale, k_codice_prec
datawindowchild kdwc_barcode
	
	
		
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_key = long(trim(ki_st_open_w.key1)) //mandante
	k_trattamento = "I" //F=lavorati; I=in lavorazione; N=ancora da trattare
//	k_data_ini = date(trim(ki_st_open_w.key3)) //data inizio lavorazione
//	k_data_fin = date(trim(ki_st_open_w.key4)) //data fine lavorazione

	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") //Ricevente
	k_clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_3") //Ricevente
	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose") //Dose
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data riferimento da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
	k_data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini") //data inizio lavorazione
	k_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin") //data fine lavorazione
	k_data_ini_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini_1") //alla data inizio lavorazione
	k_data_fin_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin_1") //alla data fine lavorazione
//	k_data_fin = date(trim(ki_st_open_w.key4)) //data fine lavorazione
	k_barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode") //barcode


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.Text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.Text
else
	k_codice_prec = " "
end if

if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date("01/01/1900")
end if
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") then
	k_data_a = date("01/01/9999")
end if

if isnull(k_dose) then
	k_dose = 0
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_clie_2) then
	k_clie_2 = 0
end if
if isnull(k_clie_3) then
	k_clie_3 = 0
end if
if isnull(k_data_ini) or k_data_ini = date(0) or k_data_ini = date("01/01/1900") then
	k_data_ini = date("01/01/1900")
end if
if isnull(k_data_ini_1) or k_data_ini_1 = date(0) or k_data_ini_1 = date("01/01/1900") then
	k_data_ini_1 = date("01/01/1900")
end if
if isnull(k_data_fin) or k_data_fin = date(0) or k_data_fin = date("01/01/1900") then
	k_data_fin = date("01/01/1900")
end if
if isnull(k_data_fin_1) or k_data_fin_1 = date(0) or k_data_fin_1 = date("01/01/1900") then
	k_data_fin_1 = date("01/01/1900")
end if
if isnull(k_barcode) or len(trim(k_barcode)) = 0 then
	k_barcode = "*"
end if

k_codice_attuale = string(k_dose, "00000.00") &
			   + string(k_clie_1, "0000000000") + string(k_clie_2, "0000000000") &
			   + string(k_clie_3, "0000000000") &
				+ string(k_data_da, "ddmmyy") + string(k_data_a, "ddmmyy") &
				+ string(k_data_ini, "ddmmyy") + string(k_data_ini_1, "ddmmyy") &
				+ string(k_data_fin, "ddmmyy") + string(k_data_fin_1, "ddmmyy") &
				+ string(k_barcode, "@@@@@@@@@@@@@") 



//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else

	   tab_1.tabpage_3.dw_3.getchild("barcode", kdwc_barcode)
	   kdwc_barcode.settransobject(sqlca)
	   kdwc_barcode.insertrow(0)

		tab_1.tabpage_3.dw_3.retrieve(  &
												k_barcode, &
												k_trattamento, &
												k_data_ini, &
												k_data_ini_1, &
												k_data_fin, &
												k_data_fin_1, &
												k_clie_1, &
												k_clie_2, &
												k_clie_3, &
												k_dose, &
												k_data_da, &
												k_data_a &
												 &
												)



	end if				
end if				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if

tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long  k_key, k_clie_1, k_clie_2, k_clie_3, k_riga
int k_err_ins, k_rc=0, k_anno
double k_dose 
date k_data_da, k_data_a, k_data_ini, k_data_ini_1, k_data_fin, k_data_fin_1, k_data_null 
string k_rag_soc, k_indirizzo, k_localita
string k_trattamento, k_barcode
string k_codice_attuale, k_codice_prec
datawindowchild kdwc_barcode

	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_key = long(trim(ki_st_open_w.key1)) //mandante
	k_trattamento = "N" //F=lavorati; I=in lavorazione; N=ancora da trattare

	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") //Ricevente
	k_clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_3") //Ricevente
	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose") //Dose
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data riferimento da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
	k_data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini") //data inizio lavorazione
	k_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin") //data fine lavorazione
	k_data_ini_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini_1") //alla data inizio lavorazione
	k_data_fin_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin_1") //alla data fine lavorazione
//	k_data_fin = date(trim(ki_st_open_w.key4)) //data fine lavorazione
	k_barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode") //barcode


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.Text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.Text
else
	k_codice_prec = " "
end if

if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date("01/01/1900")
end if
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") then
	k_data_a = date("01/01/9999")
end if

if isnull(k_dose) then
	k_dose = 0
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_clie_2) then
	k_clie_2 = 0
end if
if isnull(k_clie_3) then
	k_clie_3 = 0
end if
if isnull(k_data_ini) or k_data_ini = date(0) or k_data_ini = date("01/01/1900") then
	k_data_ini = date("01/01/1900")
end if
if isnull(k_data_ini_1) or k_data_ini_1 = date(0) or k_data_ini_1 = date("01/01/1900") then
	k_data_ini_1 = date("01/01/1900")
end if
if isnull(k_data_fin) or k_data_fin = date(0) or k_data_fin = date("01/01/1900") then
	k_data_fin = date("01/01/1900")
end if
if isnull(k_data_fin_1) or k_data_fin_1 = date(0) or k_data_fin_1 = date("01/01/1900") then
	k_data_fin_1 = date("01/01/1900")
end if
if isnull(k_barcode) or len(trim(k_barcode)) = 0 then
	k_barcode = "*"
end if

k_codice_attuale = string(k_dose, "00000.00") &
			   + string(k_clie_1, "0000000000") + string(k_clie_2, "0000000000") &
			   + string(k_clie_3, "0000000000") &
				+ string(k_data_da, "ddmmyy") + string(k_data_a, "ddmmyy") &
				+ string(k_data_ini, "ddmmyy") + string(k_data_ini_1, "ddmmyy") &
				+ string(k_data_fin, "ddmmyy") + string(k_data_fin_1, "ddmmyy") &
				+ string(k_barcode, "@@@@@@@@@@@@@") 

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else
		
		
	   tab_1.tabpage_2.dw_2.getchild("barcode", kdwc_barcode)
	   kdwc_barcode.settransobject(sqlca)
	   kdwc_barcode.insertrow(0)

		tab_1.tabpage_2.dw_2.retrieve(  &
												k_barcode, &
												k_trattamento, &
												k_data_ini, &
												k_data_ini_1, &
												k_data_fin, &
												k_data_fin_1, &
												k_clie_1, &
												k_clie_2, &
												k_clie_3, &
												k_dose, &
												k_data_da, &
												k_data_a &
												 &
												)



	end if				
end if				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long  k_key, k_clie_1, k_clie_2, k_clie_3, k_riga
int k_err_ins, k_rc=0, k_anno
double k_dose 
date k_data_da, k_data_a, k_data_ini, k_data_ini_1, k_data_fin, k_data_fin_1, k_data_null 
string k_rag_soc, k_indirizzo, k_localita
string k_trattamento, k_barcode
string k_codice_attuale, k_codice_prec
datawindowchild kdwc_barcode
	
		
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_key = long(trim(ki_st_open_w.key1)) //mandante
	k_trattamento = "F" //F=lavorati; I=in lavorazione; N=ancora da trattare
//	k_data_ini = date(trim(ki_st_open_w.key3)) //data inizio lavorazione
//	k_data_fin = date(trim(ki_st_open_w.key4)) //data fine lavorazione


	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_clie_2 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_2") //Ricevente
	k_clie_3 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_3") //Ricevente
	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose") //Dose
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data riferimento da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data riferimento da
	k_data_ini = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini") //data inizio lavorazione
	k_data_fin = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin") //data fine lavorazione
	k_data_ini_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_ini_1") //alla data inizio lavorazione
	k_data_fin_1 = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fin_1") //alla data fine lavorazione
//	k_data_fin = date(trim(ki_st_open_w.key4)) //data fine lavorazione
	k_barcode = tab_1.tabpage_1.dw_1.getitemstring(1, "barcode") //barcode


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_4.st_4_retrieve.Text) then
	k_codice_prec = tab_1.tabpage_4.st_4_retrieve.Text
else
	k_codice_prec = " "
end if

if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date("01/01/1900")
end if
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") then
	k_data_a = date("01/01/9999")
end if

if isnull(k_dose) then
	k_dose = 0
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_clie_2) then
	k_clie_2 = 0
end if
if isnull(k_clie_3) then
	k_clie_3 = 0
end if
if isnull(k_data_ini) or k_data_ini = date(0) or k_data_ini = date("01/01/1900") then
	k_data_ini = date("01/01/1900")
end if
if isnull(k_data_ini_1) or k_data_ini_1 = date(0) or k_data_ini_1 = date("01/01/1900") then
	k_data_ini_1 = date("01/01/1900")
end if
if isnull(k_data_fin) or k_data_fin = date(0) or k_data_fin = date("01/01/1900") then
	k_data_fin = date("01/01/1900")
end if
if isnull(k_data_fin_1) or k_data_fin_1 = date(0) or k_data_fin_1 = date("01/01/1900") then
	k_data_fin_1 = date("01/01/1900")
end if
if isnull(k_barcode) or len(trim(k_barcode)) = 0 then
	k_barcode = "*"
end if

k_codice_attuale = string(k_dose, "00000.00") &
			   + string(k_clie_1, "0000000000") + string(k_clie_2, "0000000000") &
			   + string(k_clie_3, "0000000000") &
				+ string(k_data_da, "ddmmyy") + string(k_data_a, "ddmmyy") &
				+ string(k_data_ini, "ddmmyy") + string(k_data_ini_1, "ddmmyy") &
				+ string(k_data_fin, "ddmmyy") + string(k_data_fin_1, "ddmmyy") &
				+ string(k_barcode, "@@@@@@@@@@@@@") 



//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else

	   tab_1.tabpage_4.dw_4.getchild("barcode", kdwc_barcode)
	   kdwc_barcode.settransobject(sqlca)
	   kdwc_barcode.insertrow(0)

		tab_1.tabpage_4.dw_4.retrieve(  &
												k_barcode, &
												k_trattamento, &
												k_data_ini, &
												k_data_ini_1, &
												k_data_fin, &
												k_data_fin_1, &
												k_clie_1, &
												k_clie_2, &
												k_clie_3, &
												k_dose, &
												k_data_da, &
												k_data_a &
												 &
												)



	end if				
end if				

attiva_tasti()
if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	tab_1.tabpage_4.dw_4.insertrow(0) 
end if

tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

on w_int_artr.create
int iCurrent
call super::create
end on

on w_int_artr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_filtro_0 from w_g_tab_3`dw_filtro_0 within w_int_artr
integer x = 1367
integer y = 1212
end type

type st_stampa from w_g_tab_3`st_stampa within w_int_artr
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_int_artr
integer x = 1234
integer y = 1504
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_int_artr
integer x = 773
integer y = 1500
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_int_artr
boolean visible = true
integer x = 2848
integer y = 1504
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_int_artr
integer x = 2107
integer y = 1504
end type

event cb_aggiorna::clicked;//

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then
//	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//	dw_dett_0.reset()
//	dw_lista_0.setfocus()
	
	attiva_tasti()
	
	tab_1.selectedtab = 1
	
	if cb_inserisci.enabled = true then
		cb_inserisci.triggerevent("clicked")
	end if

	
end if

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_int_artr
integer x = 2478
integer y = 1504
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_int_artr
integer x = 1737
integer y = 1504
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_int_artr
integer x = 14
integer y = 64
integer width = 3154
integer height = 1472
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3118
integer height = 1344
string text = "Parametri"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 142
integer y = 1096
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 5
integer y = 48
integer width = 3109
integer height = 1172
integer taborder = 50
string dataobject = "d_sk_rich_0"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::clicked;//
//int k_anno
//datawindowchild kdwc_cliente, kdwc_dose
//
//
//if row > 0 then
//
//	choose case dwo.name	
//		case "rag_soc_1"	
//			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
//			if kdwc_cliente.rowcount() < 2 then
//				kdwc_cliente.retrieve("")
//				kdwc_cliente.insertrow(1)
//			end if
//	
//		case "dose"
//			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
//			if kdwc_dose.rowcount() < 2 then
//				kdwc_dose.retrieve()
//				kdwc_dose.insertrow(1)
//			end if	
//	end choose
//end if
//
//
end event

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3118
integer height = 1344
string text = "Da Trattare"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer width = 3104
integer height = 1308
string dataobject = "d_armo_l"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_2::clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode" then
	
	tab_1.tabpage_2.dw_2.getchild("barcode", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if tab_1.tabpage_2.dw_2.rowcount() > 0 then

		if kdwc_barcode.retrieve(tab_1.tabpage_2.dw_2.getitemnumber(row,"id_armo")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "In Lavorazione"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 233
integer y = 736
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = 14
integer y = 12
integer width = 3099
integer height = 1328
string dataobject = "d_armo_l"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_3::clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode" then
	
	tab_1.tabpage_3.dw_3.getchild("barcode", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if tab_1.tabpage_3.dw_3.rowcount() > 0 then

		if kdwc_barcode.retrieve(tab_1.tabpage_3.dw_3.getitemnumber(row,"id_armo")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "Trattati"
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

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 0
integer y = 16
integer width = 3077
integer height = 1280
integer taborder = 10
string dataobject = "d_armo_l"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_4::clicked;call super::clicked;//
datawindowchild kdwc_barcode

if row > 0 and dwo.Name = "barcode" then
	
	tab_1.tabpage_4.dw_4.getchild("barcode", kdwc_barcode)

	kdwc_barcode.settransobject(sqlca)

	if tab_1.tabpage_4.dw_4.rowcount() > 0 then

		if kdwc_barcode.retrieve(tab_1.tabpage_4.dw_4.getitemnumber(row,"id_armo")) > 0 then

			kdwc_barcode.insertrow(0)
			
		end if
	else
		kdwc_barcode.insertrow(0)

	end if

end if

end event

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3118
integer height = 1344
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = false
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

