$PBExportHeader$w_barcode_manuale.srw
forward
global type w_barcode_manuale from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_barcode_manuale from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3269
integer height = 1740
string title = "Etichetta Barcode Manuale"
boolean ki_esponi_msg_dati_modificati = false
end type
global w_barcode_manuale w_barcode_manuale

forward prototypes
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function integer inserisci ()
protected function string inizializza ()
protected subroutine stampa ()
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine inizializza_1 ();////
////======================================================================
////=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
////======================================================================
////
//long k_id_cliente=0
//string k_codice_attuale, k_codice_prec
//double k_dose
//int k_id_gruppo
//string k_scelta
//char k_totale
//date k_data_da, k_data_a
//
//
//k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
//k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
//k_id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
//k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
//k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  
//k_totale = tab_1.tabpage_1.dw_1.getitemstring(1, "totale")  
//
////--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
//if tab_1.tabpage_2.dw_2.Object.k_codice.Text then
//	k_codice_prec = tab_1.tabpage_2.dw_2.Object.k_codice.Text
//else
//	k_codice_prec = " "
//end if
//k_codice_attuale = string(k_dose, "00000") + string(k_id_cliente, "00000") & 
//				+ string(k_id_gruppo, "00000") + string(k_data_da, "ddmmyy") &
//				+ string(k_data_a, "ddmmyy") + string(k_totale, "@")
//
////=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//tab_1.tabpage_2.dw_2.Object.k_codice.Text = k_codice_attuale
//
//if k_codice_attuale <> k_codice_prec then
//
//
//	if isnull(k_data_da) then
//		k_data_da = date("01/01/1900")
//	end if
//	if isnull(k_data_a) or k_data_a = date(0) then
//		k_data_a = date("01/01/9999")
//	end if
//
////=== Controllo date
//	if k_data_a < k_data_da then
//		messagebox("Operazione non eseguita", &
//					"La data di fine periodo e' minore di quela di inizio")
//
//	else
//
//		if isnull(k_id_gruppo) then
//			k_id_gruppo = 0
//		end if
//		if isnull(k_dose) then
//			k_dose = 0
//		end if
//		if isnull(k_id_cliente) then
//			k_id_cliente = 0
//		end if
//		if isnull(k_totale) then
//			k_totale = "N"
//		end if
//
//
//		tab_1.tabpage_2.dw_2.retrieve(  &
//												k_id_gruppo, &
//												k_id_cliente, &
//												k_dose, &
//												k_data_da, &
//												k_data_a, &
//												k_totale)
//
//
//
//	end if				
//end if				
//
//attiva_tasti()
//if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//	tab_1.tabpage_2.dw_2.insertrow(0) 
////	else
////		if k_dose = 0 then
////			st_parametri.text = replace(st_parametri.text, 3, 10, &
////					string(tab_1.tabpage_2.dw_2.getitemnumber(1, "dose"), "0000000000")) 
////		end if
//end if
//tab_1.tabpage_2.dw_2.setfocus()
//	
//
//	
//
//	
//
end subroutine

protected function integer cancella ();//
long k_riga


	k_riga = tab_1.tabpage_1.dw_1.getrow()
	if k_riga > 0 then
		tab_1.tabpage_1.dw_1.deleterow(k_riga)
	end if

return k_riga
end function

protected function integer inserisci ();//
//======================================================================
//=== Inserisce nuovo rec
//=== 
//======================================================================
//
long  k_key, k_riga, k_barcode_progr
int k_rc=0, k_giorno
string k_barcode, k_barcode_progr_x
date k_giorno_da, k_giorno_a
kuf_base kuf1_base 


	k_riga = tab_1.tabpage_1.dw_1.rowcount()

	if k_riga = 0 then
//--- reperisce progressivo barcode manuale
		kuf1_base = create kuf_base 
		k_barcode_progr = integer(MidA(kuf1_base.prendi_dato_base("barcode_progr_man"),2))
		destroy kuf1_base 
		if k_barcode_progr = 0 then
			k_barcode_progr = 1
		else
			k_barcode_progr = k_barcode_progr + 1
		end if
	else
		k_barcode_progr_x = RightA(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode"),4)		
		if isnumber(k_barcode_progr_x) then
			k_barcode_progr = long(k_barcode_progr_x) + 1		
		else
			k_barcode_progr = 0
		end if
	end if


//--- calcola il giorno dal 1.1.2002 per prima parte progressivo barcode
	k_giorno_da = date("2002-01-01")
	k_giorno_a = date(string(today(), "yyyy-mm-dd"))
	k_giorno = daysafter(k_giorno_da, k_giorno_a)
	k_barcode = string(k_giorno, "0000") +  string(k_barcode_progr, "0000") 

	k_riga = tab_1.tabpage_1.dw_1.insertrow(0)
		
	tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode", k_barcode)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf", k_barcode)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf_1", k_barcode)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "dataoggi", today())
	tab_1.tabpage_1.dw_1.setitem(k_riga, "ora", now())

	tab_1.tabpage_1.dw_1.setfocus()
	
	tab_1.tabpage_1.dw_1.scrolltorow(k_riga)
	tab_1.tabpage_1.dw_1.setrow(k_riga)
			
//attiva_tasti()
		

return k_riga
end function

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long  k_key, k_riga
int k_rc=0, k_giorno
string k_ora, k_barcode
date k_giorno_da, k_giorno_a
kuf_base kuf1_base 



if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
	inserisci()
	
//	k_scelta = trim(ki_st_open_w.flag_modalita)

end if			
attiva_tasti()
		

return "0"	



end function

protected subroutine stampa ();//
//=== stampa dw
string k_errore, k_barcode_progr_x
int k_riga 
int k_barcode_progr
st_esito kst_esito
st_tab_base kst_tab_base
st_stampe kst_stampe
kuf_base kuf1_base 


tab_1.tabpage_1.dw_1.accepttext()

k_riga = tab_1.tabpage_1.dw_1.rowcount()


if k_riga > 0 then

	k_barcode_progr = 0
	k_riga = 1
	do while k_riga <= tab_1.tabpage_1.dw_1.rowcount()
		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf", "*" + tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode") + "*")
		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf_1", "*" + tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode") + "*")
		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf_2", "*" + tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode") + "*")
		tab_1.tabpage_1.dw_1.setitem(k_riga, "barcode_graf_3", "*" + tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode") + "*")
		k_barcode_progr_x = RightA(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode"),4)
		if isnumber(k_barcode_progr_x) then
			if long(k_barcode_progr_x) > k_barcode_progr then
				k_barcode_progr = long(k_barcode_progr_x)
			end if
		end if
		k_riga ++
	loop

	if k_barcode_progr > 0 then
		kuf1_base = create kuf_base 
//--- Aggiorna progressivo barcode manuale
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "barcode_progr_man"
		kst_tab_base.key1 = string(k_barcode_progr)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		destroy kuf1_base 
	end if

	choose case tab_1.selectedtab
		case 1
			kst_stampe.dw_print = tab_1.tabpage_1.dw_1
			kst_stampe.titolo = trim(tab_1.tabpage_1.text)
			k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
		case 2
			kst_stampe.dw_print = tab_1.tabpage_2.dw_2
			kst_stampe.titolo = trim(tab_1.tabpage_2.text)
			k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
		case 3
			kst_stampe.dw_print = tab_1.tabpage_3.dw_3
			kst_stampe.titolo = trim(tab_1.tabpage_3.text)
			k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
		case 4
			kst_stampe.dw_print = tab_1.tabpage_4.dw_4
			kst_stampe.titolo = trim(tab_1.tabpage_4.text)
			k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
		case 5
			kst_stampe.dw_print = tab_1.tabpage_5.dw_5
			kst_stampe.titolo = trim(tab_1.tabpage_5.text)
			k_errore = string(kGuf_data_base.stampa_dw(kst_stampe))
	end choose
	
end if
end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_cancella.enabled = true
cb_aggiorna.enabled = false
cb_visualizza.enabled = false
cb_modifica.enabled = false

cb_ritorna.default = false
//cb_inserisci.default = false
//cb_aggiorna.default = false
//cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			cb_cancella.enabled = false
		end if
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
            



end subroutine

on w_barcode_manuale.create
int iCurrent
call super::create
end on

on w_barcode_manuale.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_barcode_manuale
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_barcode_manuale
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_barcode_manuale
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_barcode_manuale
integer x = 2848
integer y = 1504
end type

type st_stampa from w_g_tab_3`st_stampa within w_barcode_manuale
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_barcode_manuale
integer x = 1207
integer y = 1476
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_barcode_manuale
integer x = 754
integer y = 1476
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_barcode_manuale
integer x = 2107
integer y = 1504
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_barcode_manuale
integer x = 2478
integer y = 1504
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_barcode_manuale
integer x = 1737
integer y = 1504
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_barcode_manuale
integer x = 23
integer y = 12
integer width = 3154
integer height = 1472
end type

event tab_1::selectionchanged;call super::selectionchanged;////===
////=== Controllo se sono cambiati i parametri
//if oldindex = 1 then
//	if (tab_1.tabpage_1.dw_1.getitemdecimal(1, "dose") <> &
//	    tab_1.tabpage_1.dw_1.getitemdecimal(1, "dose_old") or &
//		 tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente") <> &
//		 tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente_old") or &
//		 tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo") <> &
//		 tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo_old") or &
//		 tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") <> &
//		 tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old") or &
//		 (isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")) and &
//		  isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old"))) or &
//		 tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") <>  &
//		 tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old") or &
//  		 (isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")) and &
//		  isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old"))) &
//		) or &
//	   isnull(tab_1.tabpage_1.dw_1.getitemdecimal(1, "dose_old")) or &
//		isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente_old")) or &
//		isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo_old")) &
//		then
//		
//		
//
////=== Riallineo gli OLD			
//		tab_1.tabpage_1.dw_1.setitem(1, "data_da_old", &
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_da"))
//		tab_1.tabpage_1.dw_1.setitem(1, "data_a_old", &
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_a"))
//		tab_1.tabpage_1.dw_1.setitem(1, "id_cliente_old", &
//						tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente"))
//		tab_1.tabpage_1.dw_1.setitem(1, "dose_old", &
//						tab_1.tabpage_1.dw_1.getitemdecimal(1, "dose"))
//		tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo_old", & 
//						tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo"))
//
//
//	end if
//end if
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
integer height = 1344
long backcolor = 16777215
string text = "Barcode"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 18
integer width = 3095
integer height = 1304
integer taborder = 50
string dataobject = "d_barcode_manuale"
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_attiva_standard_select_row = false
end type

event dw_1::clicked;//

This.SetRow(row)
This.SelectRow(0, FALSE)

end event

event dw_1::getfocus;call super::getfocus;//
	This.SelectRow(0, FALSE)

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//
	This.SelectRow(0, FALSE)

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 283
integer y = 988
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 3118
integer height = 1344
string text = ""
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer width = 3104
integer height = 1308
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3118
integer height = 1344
string text = ""
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer y = 12
integer width = 3099
integer height = 1328
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3118
integer height = 1344
string text = ""
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
integer x = 0
integer y = 16
integer width = 3077
integer height = 1280
integer taborder = 10
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3118
integer height = 1344
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
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

