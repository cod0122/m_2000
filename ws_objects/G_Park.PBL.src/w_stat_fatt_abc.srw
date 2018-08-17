$PBExportHeader$w_stat_fatt_abc.srw
forward
global type w_stat_fatt_abc from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_stat_fatt_abc from w_g_tab_3
integer x = 155
integer y = 172
integer width = 3305
integer height = 1740
string title = "Scheda Classifiche ABC"
end type
global w_stat_fatt_abc w_stat_fatt_abc

forward prototypes
protected subroutine inizializza_1 ()
private subroutine inizializza_2 ()
private subroutine inizializza_3 ()
protected function string inizializza ()
end prototypes

protected subroutine inizializza_1 ();//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
//long k_id_cliente=0
double k_dose
int k_id_gruppo
string k_scelta
date k_data_da, k_data_a

	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
//	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
	k_id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  



	if isnull(k_data_da) then
		k_data_da = date("01/01/1900")
	end if
	if isnull(k_data_a) or k_data_a = date(0) then
		k_data_a = date("01/01/9999")
	end if

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else

		if isnull(k_id_gruppo) then
			k_id_gruppo = 0
		end if
		if isnull(k_dose) then
			k_dose = 0
		end if
//		if isnull(k_id_cliente) then
//			k_id_cliente = 0
//		end if

		if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		
			if k_dose <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dose_old") or &
				k_id_gruppo <> tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo_old") or &
				k_data_da <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old") or &
				(isnull(k_data_da) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old"))) or &
				k_data_a <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old") or &
				(isnull(k_data_a) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old"))) &
				then

				tab_1.tabpage_2.dw_2.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
	
//=== Resetto il dw del tab 3,4 perche' ho cambiato parametri
				tab_1.tabpage_3.dw_3.reset()
				tab_1.tabpage_4.dw_4.reset()

	
			end if
		else
				
			tab_1.tabpage_2.dw_2.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_da_old", k_data_da)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_da"))
		tab_1.tabpage_1.dw_1.setitem(1, "data_a_old", k_data_a)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_a"))
		tab_1.tabpage_1.dw_1.setitem(1, "dose_old", k_dose)
//						tab_1.tabpage_1.dw_1.getitemnumber(1, "dose"))
		tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo_old", k_id_gruppo)
//						tab_1.tabpage_1.dw_1.getitemstring(1, "id_gruppo"))

		attiva_tasti()
		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
			tab_1.tabpage_2.dw_2.insertrow(0) 
	//	else
	//		if k_dose = 0 then
	//			st_parametri.text = replace(st_parametri.text, 3, 10, &
	//					string(tab_1.tabpage_2.dw_2.getitemnumber(1, "dose"), "0000000000")) 
	//		end if
		end if				
	end if
	tab_1.tabpage_2.dw_2.setfocus()
	

	
	

	

	





end subroutine

private subroutine inizializza_2 ();//======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
//long k_id_cliente=0
double k_dose
int k_id_gruppo
string k_scelta
date k_data_da, k_data_a


	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
//	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
	k_id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  

	if isnull(k_data_da) then
		k_data_da = date("01/01/1900")
	end if
	if isnull(k_data_a) or k_data_a = date(0) then
		k_data_a = date("01/01/9999")
	end if

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else

		if isnull(k_id_gruppo) then
			k_id_gruppo = 0
		end if
		if isnull(k_dose) then
			k_dose = 0
		end if
//		if isnull(k_id_cliente) then
//			k_id_cliente = 0
//		end if

		if tab_1.tabpage_3.dw_3.rowcount() > 0 then
		
			if k_dose <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dose_old") or &
				k_id_gruppo <> tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo_old") or &
				k_data_da <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old") or &
				(isnull(k_data_da) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old"))) or &
				k_data_a <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old") or &
				(isnull(k_data_a) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old"))) &
				then

				tab_1.tabpage_3.dw_3.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
	
//=== Resetto il dw del tab 2,4 perche' ho cambiato parametri
				tab_1.tabpage_2.dw_2.reset()
				tab_1.tabpage_4.dw_4.reset()
				

	
			end if
		else
				
			tab_1.tabpage_3.dw_3.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_da_old", k_data_da)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_da"))
		tab_1.tabpage_1.dw_1.setitem(1, "data_a_old", k_data_a)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_a"))
		tab_1.tabpage_1.dw_1.setitem(1, "dose_old", k_dose)
//						tab_1.tabpage_1.dw_1.getitemnumber(1, "dose"))
		tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo_old", k_id_gruppo)
//						tab_1.tabpage_1.dw_1.getitemstring(1, "id_gruppo"))

		attiva_tasti()
		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
			tab_1.tabpage_3.dw_3.insertrow(0) 
	//	else
	//		if k_dose = 0 then
	//			st_parametri.text = replace(st_parametri.text, 3, 10, &
	//					string(tab_1.tabpage_3.dw_3.getitemnumber(1, "dose"), "0000000000")) 
	//		end if
		end if				
	end if
	tab_1.tabpage_3.dw_3.setfocus()
	

	
	

	

	





end subroutine

private subroutine inizializza_3 ();//======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
//long k_id_cliente=0
double k_dose
int k_id_gruppo
string k_scelta
date k_data_da, k_data_a


	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")  
//	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
	k_id_gruppo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo")  
	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")  
	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")  

	if isnull(k_data_da) then
		k_data_da = date("01/01/1900")
	end if
	if isnull(k_data_a) or k_data_a = date(0) then
		k_data_a = date("01/01/9999")
	end if

//=== Controllo date
	if k_data_a < k_data_da then
		messagebox("Operazione non eseguita", &
					"La data di fine periodo e' minore di quela di inizio")

	else

		if isnull(k_id_gruppo) then
			k_id_gruppo = 0
		end if
		if isnull(k_dose) then
			k_dose = 0
		end if
//		if isnull(k_id_cliente) then
//			k_id_cliente = 0
//		end if

		if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		
			if k_dose <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dose_old") or &
				k_id_gruppo <> tab_1.tabpage_1.dw_1.getitemnumber(1, "id_gruppo_old") or &
				k_data_da <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old") or &
				(isnull(k_data_da) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_da_old"))) or &
				k_data_a <> tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old") or &
				(isnull(k_data_a) = false and &
				 isnull(tab_1.tabpage_1.dw_1.getitemdate(1, "data_a_old"))) &
				then

				tab_1.tabpage_4.dw_4.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
	
//=== Resetto il dw del tab 2,3 perche' ho cambiato parametri
				tab_1.tabpage_2.dw_2.reset()
				tab_1.tabpage_3.dw_3.reset()

	
			end if
		else
				
			tab_1.tabpage_4.dw_4.retrieve(  &
														k_id_gruppo, &
														k_dose, &
														k_data_da, &
														k_data_a)
		end if
	
		tab_1.tabpage_1.dw_1.setitem(1, "data_da_old", k_data_da)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_da"))
		tab_1.tabpage_1.dw_1.setitem(1, "data_a_old", k_data_a)
//						tab_1.tabpage_1.dw_1.getitemdate(1, "data_a"))
		tab_1.tabpage_1.dw_1.setitem(1, "dose_old", k_dose)
//						tab_1.tabpage_1.dw_1.getitemnumber(1, "dose"))
		tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo_old", k_id_gruppo)
//						tab_1.tabpage_1.dw_1.getitemstring(1, "id_gruppo"))

		attiva_tasti()
		if tab_1.tabpage_4.dw_4.rowcount() = 0 then
			tab_1.tabpage_4.dw_4.insertrow(0) 
	//	else
	//		if k_dose = 0 then
	//			st_parametri.text = replace(st_parametri.text, 3, 10, &
	//					string(tab_1.tabpage_4.dw_4.getitemnumber(1, "dose"), "0000000000")) 
	//		end if
		end if				
	end if
	tab_1.tabpage_4.dw_4.setfocus()
	

	
	

	

	





end subroutine

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long  k_key, k_id_cliente, k_riga
int k_err_ins, k_rc=0, k_anno, k_id_gruppo
double k_dose 
date k_data_da, k_data_a
string k_rag_soc, k_indirizzo, k_localita, k_estrazione
datawindowchild kdwc_cliente, kdwc_dose, kdwc_gruppo
kuf_base kuf1_base


if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	k_id_cliente = long(trim(ki_st_open_w.key1))
	k_dose = double(trim(ki_st_open_w.key2))
	k_id_gruppo = integer(trim(ki_st_open_w.key3))
	k_data_da = date(trim(ki_st_open_w.key4)) 
	k_data_a = date(trim(ki_st_open_w.key5)) //data entrata
	k_key = long(trim(ki_st_open_w.key1)) //cliente
//	k_anno = integer(mid(st_parametri.text, 13, 4))

//--- reperisce l'ultima estremi estrazione	
   kuf1_base = create kuf_base
	k_estrazione = mid(kuf1_base.prendi_dato_base("descr_ultima_estrazione_statistici"),2)
	destroy kuf1_base 

//	tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
	tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
	tab_1.tabpage_1.dw_1.getchild("id_gruppo", kdwc_gruppo)

//	kdwc_cliente.settransobject(sqlca)
	kdwc_dose.settransobject(sqlca)
	kdwc_gruppo.settransobject(sqlca)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

//		kdwc_cliente.insertrow(1)
		kdwc_dose.insertrow(1)
		kdwc_gruppo.insertrow(1)

		tab_1.tabpage_1.dw_1.insertrow(0)
		
	end if
	
//	if k_id_cliente > 0 then
//		if kdwc_cliente.rowcount() < 2 then
//			kdwc_cliente.insertrow(0)
//			select rag_soc_10, indi_1, loc_1
//				into :k_rag_soc, :k_indirizzo, :k_localita
//				from clienti
//				where codice = :k_id_cliente ;
//			if sqlca.sqlcode <> 0 then
//				k_rag_soc = "Non trovato"
//			else
//				tab_1.tabpage_1.dw_1.modify("rag_soc_1.tabsequence=0")
//			end if
//			tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1", k_rag_soc)
//			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", k_id_cliente)
//			tab_1.tabpage_1.dw_1.setitem(1, "indirizzo", k_indirizzo)
//			tab_1.tabpage_1.dw_1.setitem(1, "localita", k_localita)
//		end if
//	end if
	
//=== Retrieve solo se ho specificato una data commessa
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
			k_riga=kdwc_gruppo.find("codice = "+string(k_id_gruppo),&
									0, kdwc_gruppo.rowcount())
			if k_riga > 0 then
				tab_1.tabpage_1.dw_1.setitem(1, "id_gruppo",&
								kdwc_gruppo.getitemnumber(k_riga, "codice"))
				tab_1.tabpage_1.dw_1.setitem(1, "descrizione",&
								kdwc_gruppo.getitemstring(k_riga, "des"))
			end if
		end if
//	end if
		
		
	tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
	tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
	tab_1.tabpage_1.dw_1.setitem(1, "estrazione", k_estrazione)

end if

//		tab_1.tabpage_1.dw_1.setcolumn(1)
tab_1.tabpage_1.dw_1.setfocus()
				
attiva_tasti()
		
return "0"

	



end function

on w_stat_fatt_abc.create
int iCurrent
call super::create
end on

on w_stat_fatt_abc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_stampa from w_g_tab_3`st_stampa within w_stat_fatt_abc
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_stat_fatt_abc
end type

type dw_filtro_0 from w_g_tab_3`dw_filtro_0 within w_stat_fatt_abc
integer x = 1371
integer y = 636
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_stat_fatt_abc
integer x = 1381
integer y = 1420
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_stat_fatt_abc
integer x = 782
integer y = 1432
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_stat_fatt_abc
integer x = 2843
integer y = 1500
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_stat_fatt_abc
integer x = 2103
integer y = 1500
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

type cb_cancella from w_g_tab_3`cb_cancella within w_stat_fatt_abc
integer x = 2473
integer y = 1500
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_stat_fatt_abc
integer x = 1733
integer y = 1500
boolean enabled = false
end type

type tab_1 from w_g_tab_3`tab_1 within w_stat_fatt_abc
integer x = 32
integer y = 8
integer width = 3154
integer height = 1472
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3118
integer height = 1344
string text = "Parametri"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 9
integer y = 36
integer width = 3095
integer height = 1304
integer taborder = 50
string dataobject = "d_stat_fat_abc_0"
boolean hscrollbar = true
boolean vscrollbar = true
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

//	case "rag_soc_1" 
//		k_rag_soc = trim(this.gettext())
//		if len(k_rag_soc) > 0 then
//			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
//			if kdwc_cliente.rowcount() < 2 then
//				kdwc_cliente.retrieve("",kk_tipo_dipendente)
//				kdwc_cliente.insertrow(1)
//			end if
//			k_riga=kdwc_cliente.find("rag_soc_1 like '"+string(k_rag_soc)+"%'",&
//									0, kdwc_cliente.rowcount())
//			if k_riga > 0 then
//				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",&
//								kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
//				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1",&
//								kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
//				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo", &
//								kdwc_cliente.getitemstring(k_riga, "indirizzo"))
//				tab_1.tabpage_1.dw_1.setitem(1, "localita",&
//								kdwc_cliente.getitemstring(k_riga, "localita"))
//			else
//				tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1","Non trovato")
//				tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
//				tab_1.tabpage_1.dw_1.setitem(1, "localita","")
//				tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
//			end if
//			k_errore = 1
//		else
//			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente",0)
//			tab_1.tabpage_1.dw_1.setitem(1, "localita","")
//			tab_1.tabpage_1.dw_1.setitem(1, "indirizzo","")
//		end if

	case "dose" 
//		k_anno = integer(mid(st_parametri.text, 13, 4))
//		k_anno = year(tab_1.tabpage_1.dw_1.getitemdate(1, "anno"))
		k_dose = double(tab_1.tabpage_1.dw_1.gettext())
		if k_dose > 0 then
			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
			if kdwc_dose.rowcount() < 2 then
				kdwc_dose.retrieve()
				kdwc_dose.insertrow(1)
			end if
			k_riga=kdwc_dose.find("dose = " + string(k_dose), &
									0, kdwc_dose.rowcount())
			if k_riga > 0 then
//				tab_1.tabpage_1.dw_1.setitem(1, "id_commessa",&
//								kdwc_dose.getitemnumber(k_riga, "id_commessa"))
				tab_1.tabpage_1.dw_1.setitem(1, "dose",&
								kdwc_dose.getitemnumber(k_riga, "dose"))
//				tab_1.tabpage_1.dw_1.setitem(1, "titolo",&
//								kdwc_dose.getitemstring(k_riga, "titolo"))
			else
				tab_1.tabpage_1.dw_1.setitem(1, "dose",k_dose)
			end if
			k_errore = 1
		else
//			tab_1.tabpage_1.dw_1.setitem(1, "dose",0)

		end if

	case "id_gruppo" 
		k_id_gruppo = trim(this.gettext())
		if len(k_id_gruppo) > 0 then
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
datawindowchild kdwc_cliente, kdwc_dose


if row > 0 then

	choose case dwo.name	
//		case "rag_soc_1"	
//			tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_cliente)
//			if kdwc_cliente.rowcount() < 2 then
//				kdwc_cliente.retrieve("")
//				kdwc_cliente.insertrow(1)
//			end if
//	
		case "dose"
			tab_1.tabpage_1.dw_1.getchild("dose", kdwc_dose)
			if kdwc_dose.rowcount() < 2 then
				kdwc_dose.retrieve()
				kdwc_dose.insertrow(1)
			end if	
	end choose
end if


end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3118
integer height = 1344
string text = "Clienti"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 0
integer width = 3104
integer height = 1308
string dataobject = "d_stat_fat_abc_1"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
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

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3118
integer height = 1344
string text = "Gruppi"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = 0
integer y = 8
integer width = 3095
integer height = 1328
string dataobject = "d_stat_fat_abc_2"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
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
integer width = 3118
integer height = 1344
string text = "Dose"
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
integer width = 3077
integer height = 1300
integer taborder = 10
string dataobject = "d_stat_fat_abc_3"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
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
integer width = 3118
integer height = 1344
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean visible = false
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

