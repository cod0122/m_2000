$PBExportHeader$w_ricevute_sk.srw
forward
global type w_ricevute_sk from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
type dw_stampa from datawindow within w_ricevute_sk
end type
type dw_modifica from datawindow within w_ricevute_sk
end type
end forward

global type w_ricevute_sk from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3269
integer height = 1792
string title = "Scadenzario"
boolean ki_toolbar_window_presente = true
boolean ki_msg_dopo_update = false
dw_stampa dw_stampa
dw_modifica dw_modifica
end type
global w_ricevute_sk w_ricevute_sk

type variables

end variables

forward prototypes
private subroutine togli_riga ()
private function date digita_data (ref window kw_window, date k_data)
public subroutine stampa_copia_dw (ref datawindow dw_1)
protected function string inizializza ()
protected subroutine inizializza_4 ()
protected subroutine inizializza_3 ()
protected subroutine inizializza_2 ()
protected subroutine inizializza_1 ()
private subroutine modifica_riba_in_lista ()
protected subroutine stampa ()
private subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine genera_riba (ref datawindow kdw)
protected subroutine open_start_window ()
protected function integer inserisci ()
protected subroutine attiva_tasti_0 ()
end prototypes

private subroutine togli_riga ();//
//=== Toglie riga dalla lista
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
long k_riga


//=== 
choose case tab_1.selectedtab 
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			tab_1.tabpage_2.dw_2.deleterow(k_riga)
			tab_1.tabpage_2.dw_2.setfocus()
			tab_1.tabpage_2.dw_2.setcolumn(1)
		else
			messagebox("Togli Riga",  "Scegliere una Scadenza dalla Lista")
		end if

	case 3
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			tab_1.tabpage_3.dw_3.deleterow(k_riga)
			tab_1.tabpage_3.dw_3.setfocus()
			tab_1.tabpage_3.dw_3.setcolumn(1)
		else
			messagebox("Togli Riga",  "Scegliere una Scadenza dalla Lista")
		end if
end choose	


end subroutine

private function date digita_data (ref window kw_window, date k_data);//
//--- chiedi data di scadenza
//
date k_return
kuv_date kuv1_date


//=== Posiziona dw nella window 
	kuv1_date.x = (kw_window.width - kuv1_date.width) / 4
	kuv1_date.y = (kw_window.height - kuv1_date.height) / 7
	
	kuv1_date.visible = true


return k_data

end function

public subroutine stampa_copia_dw (ref datawindow dw_1);//
long k_riga, k_riga_max


//--- valorizzo la dw di stampa effettiva			
	k_riga_max = dw_1.RowCount()
	for k_riga = 1 to k_riga_max
		dw_stampa.insertrow(0)
		dw_stampa.setitem(k_riga, "tipo", &
			dw_1.getitemstring(k_riga, "tipo"))	
		dw_stampa.setitem(k_riga, "descrizione", &
			dw_1.getitemstring(k_riga, "descrizione"))	
		dw_stampa.setitem(k_riga, "dist", &
			dw_1.getitemstring(k_riga, "dist"))
		dw_stampa.setitem(k_riga, "scad", &
			dw_1.getitemdate(k_riga, "scad"))	
		dw_stampa.setitem(k_riga, "num_fatt", &
			dw_1.getitemnumber(k_riga, "num_fatt"))
		dw_stampa.setitem(k_riga, "data_fatt", &
			dw_1.getitemdate(k_riga, "data_fatt"))
		dw_stampa.setitem(k_riga, "importo", &
			dw_1.getitemnumber(k_riga, "importo"))
		dw_stampa.setitem(k_riga, "rata", &
			dw_1.getitemnumber(k_riga, "rata"))
		dw_stampa.setitem(k_riga, "clie", &
			dw_1.getitemnumber(k_riga, "clie"))
		dw_stampa.setitem(k_riga, "flag_st", &
			dw_1.getitemstring(k_riga, "flag_st"))
		dw_stampa.setitem(k_riga, "p_iva", &
			dw_1.getitemstring(k_riga, "p_iva"))
		dw_stampa.setitem(k_riga, "banca", &
			dw_1.getitemstring(k_riga, "banca"))
		dw_stampa.setitem(k_riga, "cli_abi", &
			dw_1.getitemnumber(k_riga, "cli_abi"))	
		dw_stampa.setitem(k_riga, "cli_cab", &
			dw_1.getitemnumber(k_riga, "cli_cab"))

		if	isnull(dw_1.getitemstring(k_riga, "ind_comm_rag_soc_1_c")) &
		   or LenA(trim(dw_1.getitemstring(k_riga, "ind_comm_rag_soc_1_c"))) = 0 then
			dw_stampa.setitem(k_riga, "rag_soc_10", &
				dw_1.getitemstring(k_riga, "rag_soc_10"))
		else
			dw_stampa.setitem(k_riga, "rag_soc_10", &
				dw_1.getitemstring(k_riga, "ind_comm_rag_soc_1_c"))
		end if
		
		if	isnull(dw_1.getitemstring(k_riga, "ind_comm_indi_c")) &
		   or LenA(trim(dw_1.getitemstring(k_riga, "ind_comm_indi_c"))) = 0 then
			dw_stampa.setitem(k_riga, "indi_1", &
				dw_1.getitemstring(k_riga, "indi_1"))
		else
			dw_stampa.setitem(k_riga, "indi_1", &
				dw_1.getitemstring(k_riga, "ind_comm_indi_c"))
		end if
		if isnull(dw_1.getitemstring(k_riga, "ind_comm_loc_c")) &
		   or LenA(trim(dw_1.getitemstring(k_riga, "ind_comm_loc_c"))) = 0 then
			dw_stampa.setitem(k_riga, "loc_1", &
				dw_1.getitemstring(k_riga, "loc_1"))
		else
			dw_stampa.setitem(k_riga, "loc_1", &
				dw_1.getitemstring(k_riga, "ind_comm_loc_c"))
		end if
				
		if isnull(dw_1.getitemstring(k_riga, "ind_comm_prov_c")) &
		   or LenA(trim(dw_1.getitemstring(k_riga, "ind_comm_prov_c"))) = 0 then
			dw_stampa.setitem(k_riga, "prov_1", &
				dw_1.getitemstring(k_riga, "prov_1"))	
		else
			dw_stampa.setitem(k_riga, "prov_1", &
				dw_1.getitemstring(k_riga, "ind_comm_prov_c"))	
		end if
			
		if isnull(dw_1.getitemstring(k_riga, "ind_comm_cap_c")) &
		   or LenA(trim(dw_1.getitemstring(k_riga, "ind_comm_cap_c"))) = 0 then
			dw_stampa.setitem(k_riga, "cap_1", &
				dw_1.getitemstring(k_riga, "cap_1"))
		else
			dw_stampa.setitem(k_riga, "cap_1", &
				dw_1.getitemstring(k_riga, "ind_comm_cap_c"))
		end if

	next


end subroutine

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long  k_clie_1, k_riga
int k_err_ins, k_rc=0, k_anno
string k_distinta 
date k_data_da, k_data_a, k_data_null, k_data_fatt_da, k_data_fatt_a 
string k_rag_soc, k_indirizzo, k_localita
string k_tipo
datawindowchild kdwc_cliente, kdwc_dist, kdwc_banca, 	kdwc_banca_1

	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	k_tipo = trim(ki_st_open_w.key1) //codice banca
	k_distinta = trim(trim(ki_st_open_w.key2)) //tipo distinta
	k_data_da = date(trim(ki_st_open_w.key3)) //data scadenza da
	k_data_a = date(trim(ki_st_open_w.key4)) //data scadenza a
	k_clie_1 = long(trim(ki_st_open_w.key5)) //Fatturato
	setnull(k_data_null)
//*****MOMENTANEAMENTE XCHE' NON SI RIESCE A DIGITARE BENE SULLE DATE*****
//   setnull(k_data_da)   //data scadenza da
//	setnull(k_data_a)   //data scadenza da

	tab_1.tabpage_1.dw_1.getchild("clie_1", kdwc_cliente)
	tab_1.tabpage_1.dw_1.getchild("dist", kdwc_dist)
	tab_1.tabpage_1.dw_1.getchild("banca", kdwc_banca)
	tab_1.tabpage_1.dw_1.getchild("banca_1", kdwc_banca_1)

	kdwc_cliente.settransobject(sqlca)
	kdwc_dist.settransobject(sqlca)
	kdwc_banca.settransobject(sqlca)
	kdwc_banca_1.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		kdwc_cliente.retrieve("%")
		kdwc_banca.retrieve(0)
		kdwc_banca_1.retrieve(0)
		kdwc_dist.retrieve()

		kdwc_cliente.insertrow(1)
		
		k_riga=kdwc_banca.insertrow(1)
		kdwc_banca.setitem(k_riga, "codice",	"*")
		k_riga=kdwc_banca.insertrow(1)
		kdwc_banca.setitem(k_riga, "codice",	" ")
		
		k_riga=kdwc_dist.insertrow(1)
		kdwc_dist.setitem(k_riga, "dist",	"*")
		k_riga=kdwc_dist.insertrow(1)
		kdwc_dist.setitem(k_riga, "dist",	" ")

		tab_1.tabpage_1.dw_1.insertrow(0)
		
	end if

   if ki_st_open_w.flag_primo_giro = "S" then 
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
		tab_1.tabpage_1.dw_1.setitem(1, "data_fatt_da", k_data_null)
		tab_1.tabpage_1.dw_1.setitem(1, "data_fatt_a", k_data_null)
		if isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_st")) then
			tab_1.tabpage_1.dw_1.setitem(1, "data_st", today())
		end if
	end if
	
	if k_clie_1 > 0 then
		if kdwc_cliente.rowcount() < 2 then
			kdwc_cliente.insertrow(0)
			k_riga=kdwc_cliente.find("codice = "+string(k_clie_1), 0, kdwc_cliente.rowcount())
			if k_riga > 0 then
	  			tab_1.tabpage_1.dw_1.setitem(1, "clie_1", kdwc_cliente.getitemnumber(k_riga, "codice"))
			end if
		end if
	end if
	
	if LenA(trim(k_distinta)) > 0 then
		if kdwc_dist.rowcount() < 3 then

			k_riga=kdwc_dist.find("dist = '"+trim(k_distinta) + "'", 0, kdwc_dist.rowcount())
			
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "dist",	kdwc_dist.getitemstring(k_riga, "dist"))
				
			end if
		end if
	end if	
	
	if LenA(trim(k_tipo)) > 0 then
		if kdwc_banca.rowcount() < 3 then
			
			k_riga=kdwc_banca.find("codice = '"+trim(k_tipo) + "'", 0, kdwc_banca.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "banca",	kdwc_banca.getitemstring(k_riga, "codice"))
				
			end if
		end if
	end if	
	
				
	attiva_tasti()
		
	tab_1.tabpage_1.dw_1.setrow(1)
	tab_1.tabpage_1.dw_1.setcolumn("data_da")
//	tab_1.selectedtab = 1
//	tab_1.tabpage_1.dw_1.setfocus()


	

        return "0"

end function

protected subroutine inizializza_4 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long k_clie_1, k_riga
int k_err_ins, k_rc=0
string k_dist, k_tipo, 	k_data_st_null = "N" 
date k_data_da, k_data_a, k_data_null, k_data_st, k_data_fatt_da, k_data_fatt_a  
string k_codice_attuale, k_codice_prec

	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca") //Mandante
	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_dist = tab_1.tabpage_1.dw_1.getitemstring(1, "dist") //dist
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data ricev da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data ricev da
	k_data_fatt_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_da") //data fatt da
	k_data_fatt_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_a") //data fatt da
	k_data_st = tab_1.tabpage_1.dw_1.getitemdate(1, "data_st") //data presentazione


//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_5.st_5_retrieve.Text) then
	k_codice_prec = tab_1.tabpage_5.st_5_retrieve.Text
else
	k_codice_prec = " "
end if

if isnull(k_data_da) or k_data_da = date(0) then
	k_data_da = date("01/01/1900")
end if
if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") then
	k_data_a = date("01/01/9999")
end if
if isnull(k_data_fatt_da) or k_data_fatt_da = date(0) then
	k_data_fatt_da = date("01/01/1900")
end if
if isnull(k_data_fatt_a) or k_data_fatt_a = date(0) or k_data_fatt_a = date("01/01/1900") then
	k_data_fatt_a = date("01/01/9999")
end if
if isnull(k_data_st) or k_data_st = date(0) or k_data_st = date("00/00/00") then
	k_data_st = date("01/01/1900") 
	k_data_st_null = "S"
end if

if isnull(k_dist) then
	k_dist = ""
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_tipo) then
	k_tipo = ""
end if

k_codice_attuale = trim(k_tipo) + trim(k_dist) &
			   	    + trim(string(k_clie_1)) &
						 + trim(string(k_data_da, "ddmmyy")) + trim(string(k_data_a, "ddmmyy")) &
						 + trim(string(k_data_fatt_da, "ddmmyy")) + trim(string(k_data_fatt_a, "ddmmyy")) &
						 + trim(string(k_data_st, "ddmmyy"))

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_5.st_5_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else
		tab_1.tabpage_5.dw_5.retrieve(  &
												k_tipo, &
												k_dist, &
												k_data_da, &
												k_data_a, &
												k_clie_1, &
												"N", &
												k_data_st, &
												"S", &
												k_data_fatt_da, &
												k_data_fatt_a &
												)



	end if				
end if				

attiva_tasti()
//if tab_1.tabpage_5.dw_5.rowcount() = 0 then
//	tab_1.tabpage_5.dw_5.insertrow(0) 
//end if


tab_1.tabpage_5.dw_5.setfocus()
	
	

end subroutine

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long k_clie_1, k_riga
int k_err_ins, k_rc=0
string k_dist, k_tipo, 	k_data_st_null = "N" 
date k_data_da, k_data_a, k_data_null, k_data_st, k_data_fatt_da, k_data_fatt_a  
string k_codice_attuale, k_codice_prec

	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca") //Mandante
	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_dist = tab_1.tabpage_1.dw_1.getitemstring(1, "dist") //dist
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data ricev da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data ricev da
	k_data_fatt_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_da") //data fatt da
	k_data_fatt_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_a") //data fatt da
	k_data_st = tab_1.tabpage_1.dw_1.getitemdate(1, "data_st") //data presentazione


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
if isnull(k_data_fatt_da) or k_data_fatt_da = date(0) then
	k_data_fatt_da = date("01/01/1900")
end if
if isnull(k_data_fatt_a) or k_data_fatt_a = date(0) or k_data_fatt_a = date("01/01/1900") then
	k_data_fatt_a = date("01/01/9999")
end if
if isnull(k_data_st) or k_data_st = date(0) or k_data_st = date("00/00/00") then
	k_data_st = date("01/01/1900") 
	k_data_st_null = "S"
end if

if isnull(k_dist) then
	k_dist = ""
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_tipo) then
	k_tipo = ""
end if

k_codice_attuale = trim(k_tipo) + trim(k_dist) &
			   	    + trim(string(k_clie_1)) &
						 + trim(string(k_data_da, "ddmmyy")) + trim(string(k_data_a, "ddmmyy")) &
						 + trim(string(k_data_fatt_da, "ddmmyy")) + trim(string(k_data_fatt_a, "ddmmyy")) &
						 + trim(string(k_data_st, "ddmmyy"))

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_4.st_4_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else
		tab_1.tabpage_4.dw_4.retrieve(  &
												k_tipo, &
												k_dist, &
												k_data_da, &
												k_data_a, &
												k_clie_1, &
												"X", &
												k_data_st, &
												"S", &
												k_data_fatt_da, &
												k_data_fatt_a &
												)



	end if				
end if				

attiva_tasti()
//if tab_1.tabpage_4.dw_4.rowcount() = 0 then
//	tab_1.tabpage_4.dw_4.insertrow(0) 
//end if

tab_1.tabpage_4.dw_4.setfocus()
	
	

end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long k_clie_1, k_riga
int k_err_ins, k_rc=0
string k_dist, k_tipo, 	k_data_st_null = "N" 
date k_data_da, k_data_a, k_data_null, k_data_st, k_data_fatt_da, k_data_fatt_a  
string k_codice_attuale, k_codice_prec

	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca") //Mandante
	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_dist = tab_1.tabpage_1.dw_1.getitemstring(1, "dist") //dist
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data ricev da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data ricev da
	k_data_fatt_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_da") //data fatt da
	k_data_fatt_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_a") //data fatt da
	k_data_st = tab_1.tabpage_1.dw_1.getitemdate(1, "data_st") //data presentazione


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
if isnull(k_data_fatt_da) or k_data_fatt_da = date(0) then
	k_data_fatt_da = date("01/01/1900")
end if
if isnull(k_data_fatt_a) or k_data_fatt_a = date(0) or k_data_fatt_a = date("01/01/1900") then
	k_data_fatt_a = date("01/01/9999")
end if
if isnull(k_data_st) or k_data_st = date(0) or k_data_st = date("00/00/00") then
	k_data_st = date("01/01/1900") 
	k_data_st_null = "S"
end if

if isnull(k_dist) then
	k_dist = ""
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_tipo) then
	k_tipo = ""
end if

k_codice_attuale = trim(k_tipo) + trim(k_dist) &
			   	    + trim(string(k_clie_1)) &
						 + trim(string(k_data_da, "ddmmyy")) + trim(string(k_data_a, "ddmmyy")) &
						 + trim(string(k_data_fatt_da, "ddmmyy")) + trim(string(k_data_fatt_a, "ddmmyy")) &
						 + trim(string(k_data_st, "ddmmyy"))

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else
		tab_1.tabpage_3.dw_3.retrieve(  &
												k_tipo, &
												k_dist, &
												k_data_da, &
												k_data_a, &
												k_clie_1, &
												"S", &
												k_data_st, &
												k_data_st_null, &
												k_data_fatt_da, &
												k_data_fatt_a &
												)



	end if				
end if				

attiva_tasti()
//if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//	tab_1.tabpage_3.dw_3.insertrow(0) 
//end if

tab_1.tabpage_3.dw_3.setfocus()
	
	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
string k_scelta
long k_clie_1, k_riga
int k_err_ins, k_rc=0
string k_dist, k_tipo 
date k_data_da, k_data_a, k_data_st, k_data_fatt_da, k_data_fatt_a 
string k_codice_attuale, k_codice_prec

	
	k_scelta = trim(ki_st_open_w.flag_modalita)

	k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca") //Mandante
	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
	k_dist = tab_1.tabpage_1.dw_1.getitemstring(1, "dist") //dist
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data ricev da
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data ricev da
	k_data_fatt_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_da") //data fatt da
	k_data_fatt_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_a") //data fatt da
	k_data_st = date("01/01/1900")

	ki_st_open_w.key1 = trim(k_tipo) //codice banca
	ki_st_open_w.key2 = trim(k_dist) //tipo distinta
	ki_st_open_w.key3 = string(k_data_da,"dd/mm/yyyy") //data scadenza da
	ki_st_open_w.key4 = string(k_data_a,"dd/mm/yyyy") //data scadenza a
	ki_st_open_w.key5 = string(k_clie_1,"#####") //Fatturato


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
if isnull(k_data_fatt_da) or k_data_fatt_da = date(0) then
	k_data_fatt_da = date("01/01/1900")
end if
if isnull(k_data_fatt_a) or k_data_fatt_a = date(0) or k_data_fatt_a = date("01/01/1900") then
	k_data_fatt_a = date("01/01/9999")
end if

if isnull(k_dist)  then
	k_dist = ""
end if
if isnull(k_clie_1) then
	k_clie_1 = 0
end if
if isnull(k_tipo) then
	k_tipo = ""
end if

k_codice_attuale = (k_tipo) + k_dist &
			   	    + trim(string(k_clie_1)) &
						 + trim(string(k_data_fatt_da, "ddmmyy")) + trim(string(k_data_fatt_a, "ddmmyy")) &
						 + trim(string(k_data_da, "ddmmyy")) + trim(string(k_data_a, "ddmmyy")) 

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.Text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else
		tab_1.tabpage_2.dw_2.retrieve(  &
												k_tipo, &
												k_dist, &
												k_data_da, &
												k_data_a, &
												k_clie_1, &
												" ", &
												k_data_st, &
												"S", &
												k_data_fatt_da, &
												k_data_fatt_a &
												)

	end if				
end if				

attiva_tasti()
//if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	tab_1.tabpage_2.dw_2.insertrow(0) 
//end if

tab_1.tabpage_2.dw_2.setfocus()
	
	

end subroutine

private subroutine modifica_riba_in_lista ();//
//--- Visualizza la dw x consentire le modifiche alle RIBA
//
int k_rc
long k_riga_count
datawindowchild kdwc_dist, kdwc_banca

	
	choose case tab_1.selectedtab 
		case 2
			k_riga_count = tab_1.tabpage_2.dw_2.rowcount()
		case 3
			k_riga_count = tab_1.tabpage_3.dw_3.rowcount()
		case 4
			k_riga_count = tab_1.tabpage_4.dw_4.rowcount()
		case 5
			k_riga_count = tab_1.tabpage_5.dw_5.rowcount()
	end choose	


	if k_riga_count > 0 then
		
		dw_modifica.settransobject (sqlca)
	
	//	ki_st_open_w.flag_primo_giro = ''
		dw_modifica.setredraw(false)
	
//--- Attivo dw archivi: Clienti, Scadenzario, Fattura, Banche
		k_rc = dw_modifica.getchild("ric_dist", kdwc_dist)
		k_rc = kdwc_dist.settransobject(sqlca)
		kdwc_dist.insertrow(0)
		k_rc = dw_modifica.getchild("ric_tipo", kdwc_banca)
		k_rc = kdwc_banca.settransobject(sqlca)
		kdwc_banca.insertrow(0)
	
		dw_modifica.reset()
		dw_modifica.insertrow(0)
	
//--- Attivo dw archivio Scadenzario
		if kdwc_dist.rowcount() < 2 then
			kdwc_dist.retrieve()
		end if
	
//--- Attivo dw archivio BANCHE
		if kdwc_banca.rowcount() < 2 then
			kdwc_banca.retrieve(0)
		end if
	
//=== Dimensiona e Posiziona la dw nella window 
		dw_modifica.width = long(dw_modifica.object.ric_tipo.x) + &
								  long(dw_modifica.object.ric_tipo.width) * 1.09
		dw_modifica.height = 150 + long(dw_modifica.object.cb_esci.y) + &
									long(dw_modifica.object.cb_esci.height)
		dw_modifica.x = (this.width - dw_modifica.width) / 4
		dw_modifica.y = (this.height - dw_modifica.height) / 7
	
		dw_modifica.setredraw(true)
	
		dw_modifica.visible = true
	
	end if



end subroutine

protected subroutine stampa ();//
//=== stampa dw
string k_rc
st_stampe kst_stampe


	choose case tab_1.selectedtab
		case 1
			kst_stampe.dw_print = tab_1.tabpage_1.dw_1
			kst_stampe.titolo = trim(tab_1.tabpage_1.text)
			k_rc = string(kGuf_data_base.stampa_dw(kst_stampe))

		case 2
			dw_stampa.reset()

//--- valorizzo la dw di stampa effettiva			
			stampa_copia_dw(tab_1.tabpage_2.dw_2)

			
//         tab_1.tabpage_2.dw_2.RowsCopy(1, tab_1.tabpage_2.dw_2.RowCount(), &
//			                     Primary!, dw_stampa, 1, Primary!)
							
			k_rc = dw_stampa.Modify("txt_data.Text='"+ &
			          string(tab_1.tabpage_1.dw_1.getitemdate(1, "data_st"), "dd/mm/yy") + "'")
			k_rc=dw_stampa.Modify("txt_azienda.Text='ok'")
			dw_stampa.Object.txt_azienda.Text='GAMMARAD'

			kst_stampe.dw_print = dw_stampa
			kst_stampe.titolo = trim(tab_1.tabpage_2.text)
			k_rc = string(kGuf_data_base.stampa_dw(kst_stampe))
					
		case 3
			dw_stampa.reset()

//--- valorizzo la dw di stampa effettiva			
			stampa_copia_dw(tab_1.tabpage_3.dw_3)

//         tab_1.tabpage_3.dw_3.RowsCopy(1, tab_1.tabpage_3.dw_3.RowCount(), &
//			                     Primary!, dw_stampa, 1, Primary!)
			dw_stampa.Modify("txt_data.Text='"+ &
			          string(tab_1.tabpage_1.dw_1.getitemdate(1, "data_st"), "dd/mm/yy") + "'")
			
			kst_stampe.dw_print = dw_stampa
			kst_stampe.titolo = trim(tab_1.tabpage_3.text)
			k_rc = string(kGuf_data_base.stampa_dw(kst_stampe))
					
		case 4
			kst_stampe.dw_print = tab_1.tabpage_4.dw_4
			kst_stampe.titolo = trim(tab_1.tabpage_4.text)
			k_rc = string(kGuf_data_base.stampa_dw(kst_stampe))
			
		case 5
			kst_stampe.dw_print = tab_1.tabpage_5.dw_5
			kst_stampe.titolo = trim(tab_1.tabpage_5.text)
			k_rc = string(kGuf_data_base.stampa_dw(kst_stampe))

	end choose

end subroutine

private subroutine attiva_menu ();//
//
//--- Attiva/Dis. Voci di menu personalizzate
//

	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> cb_visualizza.enabled then 
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "&Togli Riga dalla Lista"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Toglie riga dalla lista senza cancellarla dall'archivio, in prossima lettura verrà riproposta"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_visualizza.enabled
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	end if

	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> cb_visualizza.enabled then 
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Crea CIB per la Banca"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"Genera archivio con tracciato C.I.B. come richiesto dall'ABI, per presentazione RIBA   "
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_visualizza.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext = &
												 ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemname = "RegistrationDir!" //"CreateLibrary!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> cb_visualizza.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Modifica dati Scadenze"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
		"Modifica massiva di tutte le scadenze presenti in lista   "
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = cb_visualizza.enabled
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext = &
												 ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemvisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemname = "Open!"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	end if

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===


choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.refresh		//aggiorna lista
		
		choose case tab_1.selectedtab
			case 1
				tab_1.tabpage_2.st_2_retrieve.Text = " "
				inizializza_1()
				tab_1.tabpage_3.st_3_retrieve.Text = " "
				inizializza_2()
				tab_1.tabpage_4.st_4_retrieve.Text = " "
				inizializza_3()
				tab_1.tabpage_5.st_5_retrieve.Text = " "
				inizializza_4()
			case 2
				tab_1.tabpage_2.st_2_retrieve.Text = " "
				inizializza_1()
			case 3
				tab_1.tabpage_3.st_3_retrieve.Text = " "
				inizializza_2()
			case 4
				tab_1.tabpage_4.st_4_retrieve.Text = " "
				inizializza_3()
			case 5
				tab_1.tabpage_5.st_5_retrieve.Text = " "
				inizializza_4()
		end choose


//--- Personalizzo da qui
	case KKG_FLAG_RICHIESTA.libero1		//richiesta togli riga dalla lista
		if cb_modifica.enabled = true then
			togli_riga()
		end if

	case KKG_FLAG_RICHIESTA.libero2		//genera formato CIB
		if cb_visualizza.enabled = true then

//=== 
			choose case tab_1.selectedtab 
				case 2
					if tab_1.tabpage_2.dw_2.rowcount()	> 0 then
						genera_riba(tab_1.tabpage_2.dw_2)
					end if

				case 3
					if tab_1.tabpage_3.dw_3.rowcount()	> 0 then
						genera_riba(tab_1.tabpage_3.dw_3)
					end if
				end choose	

		end if

	case KKG_FLAG_RICHIESTA.libero3		//modifica massiva delle RIBA
		if cb_modifica.enabled then
			modifica_riba_in_lista()
		end if


	case else // standard
		super::smista_funz(k_par_in)


end choose



end subroutine

private subroutine genera_riba (ref datawindow kdw);//---
//--- Genera tracciato CIB-RIBA da passare alle Banche
//---
//--- k_errore: 2=interrotto da utente 1=errore programma 
//
string k_record, k_rc, k_msg
integer k_filenum, k_errore=0, k_byte, k_nrc
string k_cod_sia="94614"
string k_tipo, k_rag_soc, k_loc, k_ind, k_prov, k_piva, k_cap_str
string k_oggi, k_nome_supporto, k_fattura, k_path, k_file, k_ext, k_nulla=" "
date k_data_st, k_scadenza, k_data_fatt
long k_cliente, k_abi_cliente, k_cab_cliente, k_cap
long k_nr_riba, k_nr_riba_upd, k_nr_rec=0, k_riga, k_sqlcode, k_max_riga
double k_importo_tot=0, k_rata=0
string k_divisa = "E", k_elab_effettiva=" "
boolean k_riba_no, K_fine_ciclo, k_eof=false
kuf_ausiliari kuf1_ausiliari
kuf_base kuf1_base
kuf_ricevute kuf1_ricevute
st_tab_banche kst_tab_banche
st_tab_base kst_tab_base
st_tab_ricevute kst_tab_ricevute



k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_riba", k_nulla))

do
	k_nrc = GetFileSaveName("Scegli Nome Archivio Ricevute", &
						k_path, k_file, k_ext) 
						
	if k_nrc <= 0 then
		k_errore = 2
	else
		if fileexists(k_path) then
			k_nrc = messagebox("Selezionato archivio CIB-RIBA", &
	           "Archivio già presente:~n~r" &
	           + k_path + "~n~r" &
				  + "Vuoi ricoprirlo?", &
				  question!, yesnocancel!, 2) 
			
			if k_nrc = 3 then
				k_errore = 2
			end if
		else
			k_nrc = 1
		end if				
	end if

loop while k_nrc = 2 and k_errore = 0

if k_errore = 0 then
	k_rc = kGuf_data_base.profilestring_leggi_scrivi(2, "arch_riba", trim(k_path))

	k_nrc = messagebox("Estrazione Scadenze formato CIB-RIBA", &
	           "Elaborazione con Aggiornamento archivio Scadenzario", &
				  question!, yesnocancel!, 2) 
	if k_nrc = 1 then
		k_elab_effettiva = "S"
		kuf1_ricevute = create kuf_ricevute
	else
		if k_nrc = 2 then
			k_elab_effettiva = "N"
		else
			k_errore = 2
		end if
	end if
end if

if k_errore = 0 then
	
	k_FileNum = FileOpen(k_path, LineMode!, Write!, LockWrite!, Replace!)
	if k_FileNum < 0 then
		k_errore = 1
		messagebox("Apertura Archivio RIBA", "Operazione fallita, elaborazione interrotta")
	else
	
		k_data_st = tab_1.tabpage_1.dw_1.getitemdate(1, "data_st")
		if isnull(k_data_st) or k_data_st = date(0) or k_data_st = date("01/01/1900") then 
			k_errore = 1
			messagebox("Elaborazione delle RIBA", "Data di Presentazione non Impostata.~n~r" &
							+ "Elaborazione interrotta!")
		else
			
			k_oggi = string(today(), "ddmmyy")
		
	//--- acchiappo la banca
			kuf1_ausiliari = create kuf_ausiliari
			k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca")
			if LenA(trim(k_tipo)) > 0 then
				kst_tab_banche.codice = trim(k_tipo)
				k_rc = kuf1_ausiliari.tb_banche_select(kst_tab_banche)
				destroy kuf1_ausiliari
				if LeftA(k_rc,1) <> "0" then
					if LeftA(k_rc,1) = "1" then // not found
						kst_tab_banche.abi = 0
					else
						k_errore = 1
						messagebox("Acquisizione ABI", "Operazione fallita, errore:~n~r" &
									  + MidA(k_rc,2,6) + " " + trim(MidA(k_rc, 8)))
					end if
				end if
			else
				k_errore = 1
				messagebox("Elaborazione delle RIBA", "Banca di Presentazione non Impostata.~n~r" &
							+ "Elaborazione interrotta!")
	
			end if
			if isnull(kst_tab_banche.abi) then
				kst_tab_banche.abi = 0
			end if
			if isnull(kst_tab_banche.cab) then
				kst_tab_banche.cab = 0
			end if
			if isnull(kst_tab_banche.conto) then
				kst_tab_banche.conto = " "
			end if
			if isnull(kst_tab_banche.esito) then
				kst_tab_banche.esito = " "
			end if
	
		end if
	end if
end if

//--- Acchiappo valori Azienda dal BASE 
k_msg = ""
if k_errore = 0 then
	kuf1_base = create kuf_base
	k_sqlcode = kuf1_base.dammi_rec(kst_tab_base)
	destroy kuf1_base
	if isnull(kst_tab_base.rag_soc_1)  or LenA(trim(kst_tab_base.rag_soc_1)) = 0 then
		kst_tab_base.rag_soc_1 = " "
		k_msg = k_msg + "~n~rManca la Ragione Sociale"
		k_errore = 1
	end if
	if isnull(kst_tab_base.rag_soc_2)  or LenA(trim(kst_tab_base.rag_soc_2)) = 0 then
		kst_tab_base.rag_soc_2 = " "
	end if
	if isnull(kst_tab_base.indi)  or LenA(trim(kst_tab_base.indi)) = 0 then
		kst_tab_base.indi = " "
		k_msg =  k_msg + "~n~rManca l'indirizzo"
		k_errore = 1
	end if
	if isnull(kst_tab_base.loc)  or LenA(trim(kst_tab_base.loc)) = 0 then
		kst_tab_base.loc = " "
		k_msg =  k_msg + "~n~rManca la localita'"
		k_errore = 1
	end if
	if isnull(kst_tab_base.p_iva) or LenA(trim(kst_tab_base.p_iva)) = 0 then
		kst_tab_base.p_iva = " "
		k_msg =  k_msg + "~n~rManca la Partiva IVA"
		k_errore = 1
	end if
	if	k_errore = 1 then
		messagebox("Elaborazione RIBA bloccata", &
			"Mancano dati della Tua Azienda per proseguire con l'elaborazione:~n~r" &
			+ k_msg &
			+ "~n~rCompila il dato mancante e riprova.")
	end if
end if


//--- Riordino il DW per scadenza e cliente
if k_errore = 0 then
	kdw.SetRedraw(false)
	kdw.Sort()
	kdw.GroupCalc()
	kdw.SetRedraw(true)
end if

k_nr_rec = 0
//--- Record di TESTA
if k_errore = 0 then
	k_nome_supporto = "presentate_il_" + string(k_data_st, "dd_mm_yy") + " "
	k_record = " IB" + LeftA(k_cod_sia, 5) + string(kst_tab_banche.abi, "00000") + k_oggi &
	           + k_nome_supporto + "   " + space(68) &
				  + k_divisa + " " + string(kst_tab_banche.abi, "00000")
	k_nr_rec++
	k_byte = FileWrite(k_FileNum, k_record)
end if

k_nr_riba = 0
k_nr_riba_upd = 0
k_importo_tot = 0
k_riga = 0
k_rata = 0
k_fattura = "Saldo F."
k_riba_no = false

if k_errore = 0 then


//--- Inizio ciclo Lettura SCADENZE da DW
   k_max_riga = kdw.rowcount()

//--- Prima "lettura" fuori cliclo
	k_fine_ciclo = false
	k_riga++
	do while k_riga <= k_max_riga and not k_fine_ciclo
		k_scadenza = kdw.getitemdate(k_riga, "scad")
		k_cliente = kdw.getitemnumber(k_riga, "clie")
		k_abi_cliente = kdw.getitemnumber(k_riga, "cli_abi")
		k_cab_cliente = kdw.getitemnumber(k_riga, "cli_cab")
		
//--- se esiste indirizzo commerciale, prevale su quello della sede		
		if isnull(kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c")) &
		   or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c"))) = 0 then
			k_rag_soc = kdw.getitemstring(k_riga, "rag_soc_10")
		else
			k_rag_soc = kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c")
		end if
//		if isnull(kdw.getitemstring(k_riga, "ind_comm_loc_c")) &
//		if isnull(kdw.getitemstring(k_riga, "ind_comm_prov_c")) &
//		if isnull(kdw.getitemstring(k_riga, "ind_comm_cap_c")) &
		if LenA(trim(kdw.getitemstring(k_riga, "ind_comm_indi_c"))) > 0 &
		   or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_loc_c"))) > 0 &
		   or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_prov_c"))) > 0 &
		   or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_cap_c"))) > 0 &
			then
			k_ind = trim(kdw.getitemstring(k_riga, "ind_comm_indi_c")) 
			k_cap_str =  trim(kdw.getitemstring(k_riga, "ind_comm_cap_c"))
			k_loc = trim(kdw.getitemstring(k_riga, "ind_comm_loc_c")) 
			k_prov = trim(kdw.getitemstring(k_riga, "ind_comm_prov_c")) 
		else
			k_ind = trim(kdw.getitemstring(k_riga, "indi_1")) 
			k_cap_str =  trim(kdw.getitemstring(k_riga, "cap_1"))
			k_loc = trim(kdw.getitemstring(k_riga, "loc_1")) 
			k_prov = trim(kdw.getitemstring(k_riga, "prov_1")) 
		end if
		if isnull(k_rag_soc) then
			k_rag_soc = " "
		end if
		if isnull(k_ind) then
			k_ind = " "
		end if
		if isnull(k_cap_str) then
			k_cap_str = " "
		end if
		if isnull(k_loc) then
			k_loc = " "
		end if
		if isnull(k_prov) then
			k_prov = " "
		end if
		k_piva = kdw.getitemstring(k_riga, "p_iva")

//--- Se elab effettiva aggiorno db ricevute
			if k_elab_effettiva = "S" then
				kst_tab_ricevute.id = kdw.getitemnumber(k_riga, "id")
				kst_tab_ricevute.num_fatt = kdw.getitemnumber(k_riga, "num_fatt")
				kst_tab_ricevute.data_fatt = kdw.getitemdate(k_riga, "data_fatt")
				kst_tab_ricevute.clie = kdw.getitemnumber(k_riga, "clie")
				kst_tab_ricevute.scad = kdw.getitemdate(k_riga, "scad")
				kst_tab_ricevute.data_st = k_data_st
				kst_tab_ricevute.flag_st = "S"
		
				k_rc = kuf1_ricevute.aggiorna_scadenza(kst_tab_ricevute)
		
				if LeftA(k_rc,1) <> "0" then
					messagebox("Elaborazione delle RIBA", "Scadenza non aggiornata in Archivio.~n~r" &
					+ "Scadenza numero " + string(k_riga, "#####0") + " della fattura " &
					+ string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") + " del " &
					+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yyyy") &
					+ "~n~r~n~rErrore: " + trim(MidA(k_rc,2)))
				else
					k_nr_riba_upd++
				end if
			end if

//--- accumula rata e rifer. fatture 
		k_rata = k_rata + kdw.getitemnumber(k_riga, "rata")  

		k_fattura = k_fattura + string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") &
				+ "-" &				
				+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yy") &
				+ ";" 

		k_riga++
		if k_riga <= k_max_riga then
			if k_cliente <> kdw.getitemnumber(k_riga, "clie") &
				or k_scadenza <> kdw.getitemdate(k_riga, "scad") then
				k_fine_ciclo = true
				k_riga --
			end if
		end if
		
	loop					  
	
	k_eof = false
   do while not k_eof


//---controlli vari
		if isnull(k_scadenza) or k_scadenza = date(0) or k_scadenza = date("01/01/1900") then 
			messagebox("Elaborazione delle RIBA", "Data di Scadenza non corretta.~n~r" &
						+ "Non presento la Scadenza numero " + string(k_riga, "#####0") + " della fattura " &
						+ string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") + " del " &
						+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yyyy"))
			k_riba_no = true
		else
	
			if isnull(k_rata) or k_rata <= 0 then
				messagebox("Elaborazione delle RIBA", "Importo Rata Scadenza non corretta.~n~r" &
						+ "Non presento la Scadenza numero " + string(k_riga, "#####0") + " della fattura " &
						+ string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") + " del " &
						+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yyyy"))
				k_riba_no = true
					
			end if
		end if

//--- Se controlli in errore non elabora RIBA
		if not k_riba_no then
	
			k_importo_tot = k_importo_tot + k_rata
			k_nr_riba++
	
//--- Record "14"
			k_record = " 14" + string(k_nr_riba, "0000000") + space(12) &
				  + string(k_scadenza, "ddmmyy") &
				  + "30000" + string(k_rata * 100, "0000000000000") + "-" &
				  + string(kst_tab_banche.abi, "00000") &
				  + string(kst_tab_banche.cab, "00000") &
				  + string(kst_tab_banche.conto, "@@@@@@@@@@@@") &
				  + string(k_abi_cliente, "00000") &
				  + string(k_cab_cliente, "00000") &
				  + space(12) + LeftA(k_cod_sia, 5) + "4" + space(16) + " " + space(5) + k_divisa
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
	
			
//--- Record "20"
			k_record = " 20" + string(k_nr_riba, "0000000") &
			  + string(kst_tab_base.rag_soc_1, "@@@@@@@@@@@@@@@@@@@@@@@@") &
			  + string(kst_tab_base.rag_soc_2, "@@@@@@@@@@@@@@@@@@@@@@@@") &
			  + string(kst_tab_base.indi,      "@@@@@@@@@@@@@@@@@@@@@@@@") &
			  + string(kst_tab_base.loc,       "@@@@@@@@@@@@@@@@@@@@@@@@") &
			  + space(14)
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
					  
//--- Record "30"
			if isnull(k_rag_soc) then
				k_rag_soc = " "
			end if
			if isnull(k_piva) then
				k_piva = " "
			end if
			k_record = " 30" + string(k_nr_riba, "0000000") &
				  + string(k_rag_soc, "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") &
				  + space(30) &
				  + string(k_piva, "@@@@@@@@@@@@@@@@") &
				  + space(34)
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
					  
//--- Record "40"
			if isnull(k_ind) then
				k_ind = " "
			end if
			if isnull(k_loc) then
				k_loc = " "
			end if
			if isnull(k_cap_str) or not isnumber(k_cap_str) then
				k_cap = 0
			else
				k_cap = long(k_cap_str)
			end if
			if isnull(k_prov) then
				k_prov = " "
			end if
			k_record = " 40" + string(k_nr_riba, "0000000") &
				  + string(k_ind, "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") &
				  + string(k_cap, "00000") &
				  + string(k_loc, "@@@@@@@@@@@@@@@@@@@@@@") &
				  + " " &
				  + string(k_prov, "@@") &
				  + space(50)
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
	
				
//--- Record "50"
			k_fattura = k_fattura + space(80)
			k_record = " 50" + string(k_nr_riba, "0000000") &
				  + string(k_fattura, "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@") &
				  + space(10) &
				  + string(kst_tab_base.p_iva, "@@@@@@@@@@@@@@@") &
				  + space(04)
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
					
//--- Record "51"
			k_record = " 51" + string(k_nr_riba, "0000000") &
				  + "0000000001" &
				  + string(kst_tab_base.rag_soc_1, "@@@@@@@@@@@@@@@@@@@@") &
				  + space(80) 
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
			
//--- Record "70"
			k_record = " 70" + string(k_nr_riba, "0000000") &
				  + space(90) &
				  + "1" + string(kst_tab_banche.esito, "@") + " " &
				  + space(17) 
			k_nr_rec++
			k_byte = FileWrite(k_FileNum, k_record)
			
		end if

		k_rata = 0
		k_fattura = "Saldo F."
		
//--- "Lettura" RIBA
  		k_fine_ciclo = false
		k_riga++

//--- se sono a fine lista setto EOF x uscire dal CICLO principale
		if k_riga > k_max_riga and not k_fine_ciclo then
			k_eof = true
		end if

		do while k_riga <= k_max_riga and not k_fine_ciclo

			k_scadenza = kdw.getitemdate(k_riga, "scad")
			k_cliente = kdw.getitemnumber(k_riga, "clie")
			k_abi_cliente = kdw.getitemnumber(k_riga, "cli_abi")
			k_cab_cliente = kdw.getitemnumber(k_riga, "cli_cab")
			
//--- se esiste indirizzo commerciale, prevale su quello della sede		
			if isnull(kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c")) &
				or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c"))) = 0 then
				k_rag_soc = kdw.getitemstring(k_riga, "rag_soc_10")
			else
				k_rag_soc = kdw.getitemstring(k_riga, "ind_comm_rag_soc_1_c")
			end if
			if isnull(kdw.getitemstring(k_riga, "ind_comm_indi_c")) &
				or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_indi_c"))) = 0 then
				k_ind = trim(kdw.getitemstring(k_riga, "indi_1")) 
			else
				k_ind = trim(kdw.getitemstring(k_riga, "ind_comm_indi_c")) 
			end if
			if isnull(kdw.getitemstring(k_riga, "ind_comm_loc_c")) &
				or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_loc_c"))) = 0 then
				k_loc = trim(kdw.getitemstring(k_riga, "loc_1")) 
			else
				k_loc = trim(kdw.getitemstring(k_riga, "ind_comm_loc_c")) 
			end if
			if isnull(kdw.getitemstring(k_riga, "ind_comm_prov_c")) &
				or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_prov_c"))) = 0 then
				k_prov = trim(kdw.getitemstring(k_riga, "prov_1")) 
			else
				k_prov = trim(kdw.getitemstring(k_riga, "ind_comm_prov_c")) 
			end if
			if isnull(kdw.getitemstring(k_riga, "ind_comm_cap_c")) &
				or LenA(trim(kdw.getitemstring(k_riga, "ind_comm_cap_c"))) = 0 then
				k_cap_str =  trim(kdw.getitemstring(k_riga, "cap_1"))
			else
				k_cap_str =  trim(kdw.getitemstring(k_riga, "ind_comm_cap_c"))
			end if
			
			k_piva = kdw.getitemstring(k_riga, "p_iva")

//--- Se elab effettiva aggiorno db ricevute
			if k_elab_effettiva = "S" then
				kst_tab_ricevute.id = kdw.getitemnumber(k_riga, "id")
				kst_tab_ricevute.num_fatt = kdw.getitemnumber(k_riga, "num_fatt")
				kst_tab_ricevute.data_fatt = kdw.getitemdate(k_riga, "data_fatt")
				kst_tab_ricevute.clie = kdw.getitemnumber(k_riga, "clie")
				kst_tab_ricevute.scad = kdw.getitemdate(k_riga, "scad")
				kst_tab_ricevute.data_st = k_data_st
				kst_tab_ricevute.flag_st = "S"
		
				k_rc = kuf1_ricevute.aggiorna_scadenza(kst_tab_ricevute)
		
				if LeftA(k_rc,1) <> "0" then
					messagebox("Elaborazione delle RIBA", "Scadenza non aggiornata in Archivio.~n~r" &
					+ "Scadenza numero " + string(k_riga, "#####0") + " della fattura " &
					+ string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") + " del " &
					+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yyyy") &
					+ "~n~r~n~rErrore: " + trim(MidA(k_rc,2)))
				else
					k_nr_riba_upd++
				end if
			end if

//--- accumula rata e rifer. fatture 
			k_rata = k_rata + kdw.getitemnumber(k_riga, "rata")  
	
			k_fattura = k_fattura + string(kdw.getitemnumber(k_riga, "num_fatt"), "#####0") &
					+ "-" &				
					+ string(kdw.getitemdate(k_riga, "data_fatt"), "dd/mm/yy") &
					+ ";" 


			k_riga++
			if k_riga <= k_max_riga then
				if k_cliente <> kdw.getitemnumber(k_riga, "clie") &
					or k_scadenza <> kdw.getitemdate(k_riga, "scad") then
					k_fine_ciclo = true
					k_riga --
				end if
			end if
		loop

	loop  // fine ciclo lettura SCADENZE in DW


end if

//--- EF = Record di CODA 
if k_errore = 0 then
//05-04-2004	k_nr_riba = k_nr_riba + 2
	k_nr_rec = k_nr_rec + 1 //05-04-2004	
	k_record = " EF" + LeftA(k_cod_sia, 5) + string(kst_tab_banche.abi, "00000") + k_oggi &
	           + k_nome_supporto + "   " &
				  + string(k_nr_riba,"0000000") + string(k_importo_tot * 100, "000000000000000") &
				  + "000000000000000" + string(k_nr_rec, "0000000") + space(24) + &
				  + k_divisa + k_oggi
	k_nr_rec++
	k_byte = FileWrite(k_FileNum, k_record)
end if

k_byte = FileClose(k_FileNum)


if k_errore = 0 then
	messagebox("Estrazione archivio formato CIB-RIBA", "Elaborazione conclusa correttamente.~n~r" &
							+ "Scadenze elaborate :" + string(k_nr_riba, "#,###,##0") + "~n~r" &
							+ "Scadenze aggiornate in archivio :" + string(k_nr_riba_upd, "#,###,##0") &
							)
end if

//--- ripristina la path di lavoro
kGuf_data_base.setta_path_default()

end subroutine

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

protected function integer inserisci ();//
int k_return	

	
	tab_1.selectedtab = 1
	
	k_return = super::inserisci()
	

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

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		cb_inserisci.enabled = false
		cb_modifica.enabled = false
		cb_visualizza.enabled = false
		cb_cancella.enabled = false
	case 2
		cb_inserisci.enabled = true
		cb_modifica.enabled = true
		cb_visualizza.enabled = true
		cb_cancella.enabled = true
		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
			cb_modifica.enabled = false
			cb_visualizza.enabled = false
			cb_cancella.enabled = false
		end if
	case 3
		cb_inserisci.enabled = true
		cb_modifica.enabled = true
		cb_visualizza.enabled = true
		cb_cancella.enabled = true
		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
			cb_modifica.enabled = false
			cb_visualizza.enabled = false
			cb_cancella.enabled = false
		end if
end choose

end subroutine

on w_ricevute_sk.create
int iCurrent
call super::create
this.dw_stampa=create dw_stampa
this.dw_modifica=create dw_modifica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_stampa
this.Control[iCurrent+2]=this.dw_modifica
end on

on w_ricevute_sk.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_stampa)
destroy(this.dw_modifica)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_ricevute_sk
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ricevute_sk
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ricevute_sk
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ricevute_sk
integer x = 2848
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_ricevute_sk
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ricevute_sk
integer x = 1234
integer y = 1504
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la Visualizzazione

long k_riga
long k_id_cliente, k_id
date k_scad, k_data_fatt
long k_num_fatt, k_cliente
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



choose case tab_1.selectedtab 
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getrow()
	case 3 
		k_riga = tab_1.tabpage_3.dw_3.getrow()
end choose

if k_riga > 0 then

	choose case tab_1.selectedtab 
		case 2
			k_id = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "id" ) 
			k_scad = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "scad" ) 
			k_data_fatt = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "data_fatt" ) 
			k_num_fatt = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "num_fatt" ) 
			k_cliente = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "clie" ) 
		case 3
			k_id = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "id" ) 
			k_scad = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "scad" ) 
			k_data_fatt = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "data_fatt" ) 
			k_num_fatt = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "num_fatt" ) 
			k_cliente = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "clie" ) 
	end choose
		
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//

	K_st_open_w.id_programma = "ricevute"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "vi"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(k_id))
//	K_st_open_w.key1 = string(k_scad, "dd/mm/yyyy")
	K_st_open_w.key2 = string(k_data_fatt, "dd/mm/yyyy")
	K_st_open_w.key3 = trim(string(k_num_fatt))
	K_st_open_w.key4 = trim(string(k_cliente))
	K_st_open_w.flag_where = " "
	

	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
	
end if

	






end event

type cb_modifica from w_g_tab_3`cb_modifica within w_ricevute_sk
integer x = 910
integer y = 1492
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_id_cliente, k_id
date k_scad, k_data_fatt
long k_num_fatt, k_cliente
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



choose case tab_1.selectedtab 
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getrow()
	case 3 
		k_riga = tab_1.tabpage_3.dw_3.getrow()
end choose

if k_riga > 0 then

	choose case tab_1.selectedtab 
		case 2
			k_id = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "id" ) 
			k_scad = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "scad" ) 
			k_data_fatt = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "data_fatt" ) 
			k_num_fatt = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "num_fatt" ) 
			k_cliente = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "clie" ) 
		case 3
			k_id = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "id" ) 
			k_scad = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "scad" ) 
			k_data_fatt = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "data_fatt" ) 
			k_num_fatt = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "num_fatt" ) 
			k_cliente = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "clie" ) 
	end choose
		
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//

	K_st_open_w.id_programma = "ricevute"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "mo"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(k_id))
//	K_st_open_w.key1 = string(k_scad, "dd/mm/yyyy")
	K_st_open_w.key2 = string(k_data_fatt, "dd/mm/yyyy")
	K_st_open_w.key3 = trim(string(k_num_fatt))
	K_st_open_w.key4 = trim(string(k_cliente))
	K_st_open_w.flag_where = " "
	

	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
	
end if

	




end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ricevute_sk
integer x = 2107
integer y = 1504
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ricevute_sk
integer x = 2473
integer y = 1504
end type

event cb_cancella::clicked;////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_desc, k_record, k_record_1
long k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq, k_key
date k_data, k_data_fatt
long k_num_fatt, k_cliente
kuf_ricevute  kuf1_ricevute




//=== 
choose case tab_1.selectedtab 
	case 2
		k_record = " Scadenza "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "rag_soc_10")
				k_data = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "scad")
				k_data_fatt = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_fatt")
				k_num_fatt = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "num_fatt")
				k_cliente = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "clie")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza anagrafica cliente" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Scadenza~n~r" + &
					string(k_data) +  &
					"~n~rdi " + trim(k_desc) + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if

	case 3
		k_record = " Scadenza "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id")
				k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "rag_soc_10")
				k_data = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "scad")
				k_data_fatt = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_fatt")
				k_num_fatt = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "num_fatt")
				k_cliente = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "clie")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza anagrafica cliente" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Scadenza~n~r" + &
					string(k_data) +  &
					"~n~rdi " + trim(k_desc) + " ?"
			else
				tab_1.tabpage_3.dw_3.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_ricevute = create kuf_ricevute
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 2, 3
				k_errore = kuf1_ricevute.tb_delete(k_key) 
		end choose	
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 2
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
					case 3 
						tab_1.tabpage_3.dw_3.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_ricevute

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
	case 3
		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setcolumn(1)
end choose	


return k_return

end event

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ricevute_sk
integer x = 1737
integer y = 1504
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== Legge il rek dalla DW lista per la Inser

long k_riga=0
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window

		
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//

	K_st_open_w.id_programma = "ricevute"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "in"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = "0"
	K_st_open_w.key2 = "01/01/" + string(today(), "yyyy")
	K_st_open_w.key3 = "0"
	K_st_open_w.key4 = "0"
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
	

	




end event

type tab_1 from w_g_tab_3`tab_1 within w_ricevute_sk
boolean visible = true
integer x = 9
integer y = 60
integer width = 3154
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
integer width = 3118
integer height = 1344
string text = "Parametri"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 18
integer y = 28
integer width = 3095
integer height = 1304
integer taborder = 50
string dataobject = "d_sk_ricevute"
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

event itemfocuschanged;int k_rc
string k_banca
datawindowchild  kdwc_banche



//if dwo.name = "banca" or dwo.name = "banca_des" then
	
	k_rc = tab_1.tabpage_1.dw_1.getchild("banca", kdwc_banche)
	if kdwc_banche.getrow() > 0 then
		k_banca = kdwc_banche.getitemstring(kdwc_banche.getrow(), "codice")
		if LenA(trim(k_banca)) > 0 then
			tab_1.tabpage_1.dw_1.setitem(1, "banca_des", &
						kdwc_banche.getitemstring(kdwc_banche.getrow(), "descrizione"))

		end if
	end if 
//end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3118
integer height = 1344
string text = "Da Presentare"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer width = 3104
integer height = 1308
boolean enabled = true
string dataobject = "d_ric_l"
end type

event dw_2::getfocus;call super::getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//

end event

event rowfocuschanged;//
This.SelectRow(0, FALSE)
this.SelectRow(currentrow, TRUE)

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 1175
integer y = 344
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "Presentate"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer y = 12
integer width = 3099
integer height = 1328
boolean enabled = true
string dataobject = "d_ric_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "Sospese"
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
string dataobject = "d_ric_l"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "Da Non Presentare"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = true
integer width = 3008
integer height = 1244
boolean enabled = true
string dataobject = "d_ric_l"
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3118
integer height = 1344
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3118
integer height = 1344
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3118
integer height = 1344
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3118
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

type dw_stampa from datawindow within w_ricevute_sk
boolean visible = false
integer x = 247
integer y = 1216
integer width = 754
integer height = 344
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ric_l_st"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_modifica from datawindow within w_ricevute_sk
boolean visible = false
integer x = 699
integer y = 1336
integer width = 2464
integer height = 800
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Scheda di modifica massiva dello Scadenzario"
string dataobject = "d_ricevute_x_mod"
boolean controlmenu = true
boolean resizable = true
string icon = "Exclamation!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;//
//
long k_riga, k_riga_count
st_tab_ricevute kst_tab_ricevute
kuf_ricevute kuf1_ricevute


if dwo.name = "cb_esci" then
	
	this.visible = false
	
else
	
	if dwo.name = "cb_aggiorna" then
		
		dw_modifica.accepttext()
		
		choose case tab_1.selectedtab 
			case 2
				k_riga_count = tab_1.tabpage_2.dw_2.rowcount()
			case 3
				k_riga_count = tab_1.tabpage_3.dw_3.rowcount()
			case 4
				k_riga_count = tab_1.tabpage_4.dw_4.rowcount()
			case 5
				k_riga_count = tab_1.tabpage_5.dw_5.rowcount()
		end choose	

		if k_riga_count > 0 then

			if messagebox("Aggiornamento massivo delle Scadenze", &
							"Le " + string(k_riga_count) + " scadenze presenti in lista '" + trim(tab_1.tabpage_2.text) &
							+ "' saranno modificate~n~r" &
							+ "Procedere con l'elaborazione?", &
							question!, yesno!, 2) = 1 then
		
		
				kuf1_ricevute = create kuf_ricevute
		
				k_riga = 1	
				do until k_riga > k_riga_count
			
					choose case tab_1.selectedtab 
						case 2
							kst_tab_ricevute.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
							kst_tab_ricevute.data_st = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_st")
							kst_tab_ricevute.flag_st = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "flag_st")
							kst_tab_ricevute.scad = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "scad")
							kst_tab_ricevute.dist = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "dist")
							kst_tab_ricevute.tipo = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "tipo")
						case 3
							kst_tab_ricevute.id = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id")
							kst_tab_ricevute.data_st = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_st")
							kst_tab_ricevute.flag_st = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "flag_st")
							kst_tab_ricevute.scad = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "scad")
							kst_tab_ricevute.dist = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "dist")
							kst_tab_ricevute.tipo = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "tipo")
						case 4
							kst_tab_ricevute.id = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id")
							kst_tab_ricevute.data_st = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_st")
							kst_tab_ricevute.flag_st = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "flag_st")
							kst_tab_ricevute.scad = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "scad")
							kst_tab_ricevute.dist = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "dist")
							kst_tab_ricevute.tipo = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "tipo")
						case 5
							kst_tab_ricevute.id = tab_1.tabpage_5.dw_5.getitemnumber(k_riga, "id")
							kst_tab_ricevute.data_st = tab_1.tabpage_5.dw_5.getitemdate(k_riga, "data_st")
							kst_tab_ricevute.flag_st = tab_1.tabpage_5.dw_5.getitemstring(k_riga, "flag_st")
							kst_tab_ricevute.scad = tab_1.tabpage_5.dw_5.getitemdate(k_riga, "scad")
							kst_tab_ricevute.dist = tab_1.tabpage_5.dw_5.getitemstring(k_riga, "dist")
							kst_tab_ricevute.tipo = tab_1.tabpage_5.dw_5.getitemstring(k_riga, "tipo")
					end choose	
						
					if dw_modifica.getitemdate(1, "ric_data_st") > date(0) & 
						and not isnull(dw_modifica.getitemdate(1, "ric_data_st")) then
						kst_tab_ricevute.data_st = dw_modifica.getitemdate(1, "ric_data_st")
					else
						setnull(kst_tab_ricevute.data_st)
					end if
					if LenA(trim(dw_modifica.getitemstring(1, "ric_flag_st"))) > 0 & 
						and not isnull(dw_modifica.getitemstring(1, "ric_flag_st")) then
						kst_tab_ricevute.flag_st = dw_modifica.getitemstring(1, "ric_flag_st")
					else
						setnull(kst_tab_ricevute.flag_st)
					end if
					if dw_modifica.getitemdate(1, "ric_scad") > date(0) & 
						and not isnull(dw_modifica.getitemdate(1, "ric_scad")) then
						kst_tab_ricevute.scad = dw_modifica.getitemdate(1, "ric_scad")
					else
						setnull(kst_tab_ricevute.scad)
					end if
					if LenA(trim(dw_modifica.getitemstring(1, "ric_dist"))) > 0 & 
						and not isnull(dw_modifica.getitemstring(1, "ric_dist")) then
						kst_tab_ricevute.dist = dw_modifica.getitemstring(1, "ric_dist")
					else
						setnull(kst_tab_ricevute.dist)
					end if
					if LenA(trim(dw_modifica.getitemstring(1, "ric_tipo"))) > 0 & 
						and not isnull(dw_modifica.getitemstring(1, "ric_tipo")) then
						kst_tab_ricevute.tipo = dw_modifica.getitemstring(1, "ric_tipo")
					else
						setnull(kst_tab_ricevute.tipo)
					end if
					
					kuf1_ricevute.aggiorna_scadenza_1(kst_tab_ricevute)
					
					k_riga++ 
				loop 
			
				destroy kuf1_ricevute 
				
				k_riga -- 
				messagebox("Operazione terminata", &
							"Sono state aggiornate " + string(k_riga) + " scadenze.")
							
	
				smista_funz("ag")
				
			else
				messagebox("Operazione annullata", &
							"Elaborazione annullata dall'utente.")
			end if
			this.visible = false
			
		end if
	end if
end if

end event

event rbuttondown;//
	datawindow kdw
	kdw = this
	
//--- Calendario
	if row > 0 then
		if dwo.type = "column" then 
			if lower(MidA(dwo.coltype,1,4)) = "date" &
			   and integer(this.Describe(trim(dwo.name)+".TabSequence")) > 0 &
			   and this.Describe(trim(dwo.name)+".Protect") = "0" & 
				and this.Describe(trim(dwo.name)+".edit.DisplayOnly") <> "yes"   & 
			   then
			   gf_dw_pop_calendar(kdw,dwo.name,dwo.coltype,row)
			else
				tab_1.triggerevent("ue_rbuttondown")
			end if
		else
			tab_1.triggerevent("ue_rbuttondown")
		end if
	else
		tab_1.triggerevent("ue_rbuttondown")
	end if

end event

