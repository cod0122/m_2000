$PBExportHeader$w_ausiliari.srw
forward
global type w_ausiliari from w_g_tab_3
end type
type st_orizzontal_11 from statictext within tabpage_1
end type
type dw_11 from uo_d_std_1 within tabpage_1
end type
type st_orizzontal_12 from statictext within tabpage_2
end type
type dw_12 from uo_d_std_1 within tabpage_2
end type
type st_orizzontal_13 from statictext within tabpage_3
end type
type dw_13 from uo_d_std_1 within tabpage_3
end type
type st_orizzontal_14 from statictext within tabpage_4
end type
type dw_14 from uo_d_std_1 within tabpage_4
end type
type st_orizzontal_15 from statictext within tabpage_5
end type
type dw_15 from uo_d_std_1 within tabpage_5
end type
type st_orizzontal_16 from statictext within tabpage_6
end type
type dw_16 from uo_d_std_1 within tabpage_6
end type
type st_orizzontal_17 from statictext within tabpage_7
end type
type dw_17 from uo_d_std_1 within tabpage_7
end type
type st_orizzontal_18 from statictext within tabpage_8
end type
type dw_18 from uo_d_std_1 within tabpage_8
end type
type st_orizzontal_19 from statictext within tabpage_9
end type
type dw_19 from uo_d_std_1 within tabpage_9
end type
end forward

global type w_ausiliari from w_g_tab_3
integer width = 2158
integer height = 2128
string title = "Tabelle Ausiliarie"
long backcolor = 32172778
boolean ki_fai_nuovo_dopo_update = false
boolean ki_attiva_tasti_vmi = true
end type
global w_ausiliari w_ausiliari

type variables
//
kuf_ausiliari kiuf_ausiliari
private string ki_dataobject_precedente 
end variables

forward prototypes
protected function integer cancella ()
protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw)
protected subroutine inizializza_3 ()
protected subroutine inizializza_4 ()
protected subroutine inizializza_1 ()
protected subroutine inizializza_2 ()
protected subroutine pulizia_righe ()
protected function string check_dati ()
protected function string inizializza ()
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine inizializza_8 () throws uo_exception
protected subroutine open_start_window ()
protected function integer inserisci ()
protected function integer visualizza ()
public function integer u_get_col_iniziale ()
protected subroutine u_nasconde_dw ()
protected subroutine u_set_modalita (string a_modalita)
public subroutine u_resize_visualizza (boolean a_visible)
protected subroutine u_set_dw_selezionata ()
public subroutine u_mousemove (unsignedlong flags, double xpos, double ypos)
public function integer u_retrieve (string a_dataobject)
public function boolean u_dati_modif_dw ()
protected function string dati_modif (string k_titolo)
public subroutine u_resize_1 ()
end prototypes

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record
string k_key
long k_key_1, k_key_2, k_key_3
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
boolean k_elabora=false
st_esito kst_esito
kuf_ausiliari  kuf1_ausiliari
kuf_utility kuf1_utility
st_tab_nazioni kst_tab_nazioni
st_tab_cap kst_tab_cap
st_tab_province kst_tab_province


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = tab_1.tabpage_1.text //" Cod. IVA "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, 1)
			k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, 3)
			k_key = string(k_key_1)
		end if
	case 2
		k_record = tab_1.tabpage_2.text //" Cod. Pagamento "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, 1)
			k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, 2)
			k_key = string(k_key_1)
		end if
	case 3
		k_record = tab_1.tabpage_3.text //" Misura (imp.1) "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, 1)
			k_key_2 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, 2)
			k_key_3 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, 3)
			k_desc = string(k_key_1) + " X " + string(k_key_2) + " X " + string(k_key_3) 
			k_key = "dimensioni: "
		end if
	case 4
		k_record = tab_1.tabpage_4.text //" Gruppo articolo "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, 1)
			k_desc = tab_1.tabpage_4.dw_4.getitemstring(k_riga, 2)
			k_key = string(k_key_1)
		end if
	case 5
		k_record = tab_1.tabpage_5.text //" Causale di sped. "
		k_riga = tab_1.tabpage_5.dw_5.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 1)

			k_desc = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 2)
		end if
	case 6
		k_record = tab_1.tabpage_6.text //" Causale di Entr. "
		k_riga = tab_1.tabpage_6.dw_6.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_6.dw_6.getitemnumber(k_riga, 1)
			k_desc = tab_1.tabpage_6.dw_6.getitemstring(k_riga, 2)
			k_key = string(k_key_1)
		end if
	case 7
		k_record = tab_1.tabpage_7.text //" Nazioni "
		k_riga = tab_1.tabpage_7.dw_7.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_7.dw_7.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_7.dw_7.getitemstring(k_riga, 2)
		end if
	case 8
		k_record = tab_1.tabpage_8.text //" CAP "
		k_riga = tab_1.tabpage_8.dw_8.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_8.dw_8.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_8.dw_8.getitemstring(k_riga, 2)
		end if
	case 9
		k_record = tab_1.tabpage_9.text //" Province "
		k_riga = tab_1.tabpage_9.dw_9.getrow()	
		if k_riga > 0 then
			k_key = tab_1.tabpage_9.dw_9.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_9.dw_9.getitemstring(k_riga, 2)
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and (isnull(k_key) = false or isnull(k_key_1) = false) then

	u_set_dw_selezionata()
	
//--- se sono in inserimento rimuove solo la riga sul dw	
	if kidw_selezionata.ki_flag_modalita = kkg_flag_modalita.inserimento then
		
		kst_esito.esito = "0"
		k_elabora = true
		
	else
	
		if isnull(k_desc) = true or trim(k_desc) = "" then
			k_desc = "Codice" + k_record + "senza Descrizione" 
		end if
		
		kuf1_utility = create kuf_utility
		k_record = kuf1_utility.u_stringa_pulisci(k_record)
		destroy kuf1_utility
		
	//=== Richiesta di conferma della eliminazione del rek
		if messagebox("Elimina" + k_record, &
			"Sei sicuro di voler eliminare " + k_record + "~n~r" + &
			k_key + " " + trim(k_desc),  &
			question!, yesno!, 1) = 1 then
			k_elabora = true

		end if

		if k_elabora then

	//=== Creo l'oggetto che ha la funzione x cancellare la tabella
			kuf1_ausiliari = create kuf_ausiliari
			
	//=== Cancella la riga dal data windows di lista
			choose case tab_1.selectedtab 
				case 1 
					kst_esito = kuf1_ausiliari.tb_delete_iva(k_key_1) 
				case 2
					kst_esito = kuf1_ausiliari.tb_delete_pagam(k_key_1) 
				case 3
					kst_esito = kuf1_ausiliari.tb_delete_misure(k_key_1, k_key_2, k_key_3) 
				case 4
					kst_esito = kuf1_ausiliari.tb_delete_gruppi(k_key_1) 
				case 5
					kst_esito = kuf1_ausiliari.tb_delete_causali(k_key) 
				case 6
					kst_esito = kuf1_ausiliari.tb_delete_meca_causali(k_key_1) 
				case 7
					kst_tab_nazioni.id_nazione = k_key
					kst_esito = kuf1_ausiliari.tb_delete_nazioni(kst_tab_nazioni) 
				case 8
					kst_tab_cap.cap = k_key
					kst_esito = kuf1_ausiliari.tb_delete_cap(kst_tab_cap) 
				case 9
					kst_tab_province.sigla = k_key
					kst_esito = kuf1_ausiliari.tb_delete(kst_tab_province) 
			end choose	
			
			if trim(kst_esito.esito) = "0" then

				kst_esito = kguo_sqlca_db_magazzino.db_commit()
				
			end if
		end if
	end if

	if k_elabora then
	
		if trim(kst_esito.esito) = "0" then
			
			choose case tab_1.selectedtab 
				case 1 
					tab_1.tabpage_1.dw_1.deleterow(k_riga)
				case 2
					tab_1.tabpage_2.dw_2.deleterow(k_riga)
				case 3
					tab_1.tabpage_3.dw_3.deleterow(k_riga)
				case 4
					tab_1.tabpage_4.dw_4.deleterow(k_riga)
				case 5
					tab_1.tabpage_5.dw_5.deleterow(k_riga)
				case 6
					tab_1.tabpage_6.dw_6.deleterow(k_riga)
				case 7
					tab_1.tabpage_7.dw_7.deleterow(k_riga)
				case 8
					tab_1.tabpage_8.dw_8.deleterow(k_riga)
				case 9
					tab_1.tabpage_9.dw_9.deleterow(k_riga)
			end choose	

		else
			k_return = 1
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							trim(kst_esito.SQLErrText) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_ausiliari

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
	case 3
		tab_1.tabpage_3.dw_3.setfocus()
		tab_1.tabpage_3.dw_3.setcolumn(1)
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
	case 5
		tab_1.tabpage_5.dw_5.setfocus()
		tab_1.tabpage_5.dw_5.setcolumn(1)
	case 6
		tab_1.tabpage_6.dw_6.setfocus()
		tab_1.tabpage_6.dw_6.setcolumn(1)
	case 7
		tab_1.tabpage_7.dw_7.setfocus()
		tab_1.tabpage_7.dw_7.setcolumn(1)
	case 8
		tab_1.tabpage_8.dw_8.setfocus()
		tab_1.tabpage_8.dw_8.setcolumn(1)
	case 9
		tab_1.tabpage_9.dw_9.setfocus()
		tab_1.tabpage_9.dw_9.setcolumn(1)
end choose	


return k_return

end function

protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw);//
//--- Controllo se gia' era un campo presente nella retrieve
int k_return = 0
dwItemStatus k_status

   k_status = k_dw.GetItemStatus(k_riga, k_colonna, primary!) 
	
	if k_status = datamodified! or k_status = notmodified! then 
		if not isnull(k_dw.getitemnumber(k_riga, k_colonna,  Primary!, true)) then  
			k_return = 2
		end if
	end if

	if tab_1.tabpage_1.dw_1.find("#1 = " + trim(k_key), 1, k_dw.rowcount()) > 1 then
		k_return = 1
	end if

return k_return


end function

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
string k_style, k_rc1
kuf_utility kuf1_utility

	
	//tab_1.tabpage_4.dw_4.dataobject = "d_gruppi"
	u_retrieve("d_gruppi")
		
//--- Inabilita campi alla modifica se Vsualizzazione
  	kuf1_utility = create kuf_utility 
  	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
      	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.modifica then
   	   		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_4.dw_4)
		end if

	end if
	destroy kuf1_utility


end subroutine

protected subroutine inizializza_4 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
string k_key
string k_style, k_rc1
kuf_utility kuf1_utility

	
	//tab_1.tabpage_5.dw_5.dataobject = "d_causali"
	u_retrieve("d_causali")
		
//--- Inabilita campi alla modifica se Vsualizzazione
  	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then

		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_5.dw_5)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_5.dw_5)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.modifica then
   	   		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_5.dw_5)
		end if

	end if
	destroy kuf1_utility


end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
string k_style, k_rc1
kuf_utility kuf1_utility
	

//	tab_1.tabpage_2.dw_2.dataobject = "d_c_pag"
	u_retrieve("d_c_pag")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   	   		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_2.dw_2)
		end if

	end if
	destroy kuf1_utility

end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
string k_style, k_rc1
kuf_utility kuf1_utility
	

	//tab_1.tabpage_3.dw_3.dataobject = "d_misure"
	u_retrieve("d_misure")
		
//--- Inabilita campi alla modifica se Vsualizzazione
  	kuf1_utility = create kuf_utility 
   	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
      	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)

////--- Inabilita campo cliente per la modifica se Funzione MODIFICA
//	   if trim(kidw_selezionata.ki_flag_modalita) = "mo" then
//   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_3.dw_3)
//		end if

	end if
	destroy kuf1_utility

end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
string k_key
long k_riga, k_ctr


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()
tab_1.tabpage_6.dw_6.accepttext()
tab_1.tabpage_7.dw_7.accepttext()
tab_1.tabpage_8.dw_8.accepttext()

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, 1)) &  
		   or tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, 1) <= 0 then
			tab_1.tabpage_1.dw_1.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, 1)) &  
		   or tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, 1) <= 0 then
			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_3.dw_3.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 1)) &  
		   or tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 1) = 0 &  
		   or isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 2)) &  
		   or tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 2) = 0 &  
		   or isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 3)) &  
		   or tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, 3) = 0  then
			tab_1.tabpage_3.dw_3.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_4.dw_4.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, 1)) &  
		   or tab_1.tabpage_4.dw_4.getitemnumber(k_ctr, 1) <= 0 then
			tab_1.tabpage_4.dw_4.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_5.dw_5.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_5.dw_5.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_5.dw_5.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 1)) &  
		   or LenA(trim(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 1))) <= 0 then
			tab_1.tabpage_5.dw_5.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_6.dw_6.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_6.dw_6.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_6.dw_6.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_6.dw_6.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_7.dw_7.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_7.dw_7.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_7.dw_7.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_7.dw_7.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_7.dw_7.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_7.dw_7.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_8.dw_8.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_8.dw_8.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_8.dw_8.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_8.dw_8.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_8.dw_8.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_8.dw_8.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_9.dw_9.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_9.dw_9.getitemstatus(k_ctr, 0, primary!) = newmodified! &
					or tab_1.tabpage_9.dw_9.getitemstatus(k_ctr, 0, primary!) = new! then  
		if isnull(tab_1.tabpage_9.dw_9.getitemstring(k_ctr, 2)) &  
		   or LenA(trim(tab_1.tabpage_9.dw_9.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_9.dw_9.deleterow(k_ctr)
		end if
	end if
next


end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
string k_errore = "0"
long k_nr_righe, k_keyn
int k_riga, k_riga_find, k_larg, k_lung, k_alt
int k_nr_errori
string k_key
st_esito kst_esito
st_tab_cap kst_tab_cap
st_tab_nazioni kst_tab_nazioni


try
	
//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 1)) = true then
			k_return = tab_1.tabpage_1.text + ": Manca il codice " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "aliq")) = true then
				k_return = tab_1.tabpage_1.text + ": Manca l'aliquota (0-99) " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		if (k_errore = "0" or k_errore = "4") then
			k_key = string(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 1))
			k_riga_find = tab_1.tabpage_1.dw_1.find("#1 = " + k_key, 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_1.dw_1.find("#1 = " + k_key, k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_1.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + "); ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		// natura presente solo x Aliquota a ZERO
		if (k_errore = "0" or k_errore = "4") then
			if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "aliq") > 0 then
				if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "natura")) > " " then
					k_return = tab_1.tabpage_1.text + ": Per aliquota maggiore di ZERO non è consentito indicare un valore NATURA " + "~n~r" 
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_1.dw_1.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 1)) &
			   = true then
			k_return = tab_1.tabpage_2.text + ": Manca il codice " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 3)) = true then
				k_return = tab_1.tabpage_2.text + ": Impostare il Tipo pagamento (0-5) " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 4)) = true then
				k_return = k_return + tab_1.tabpage_2.text + ": Impostare periodo di Scadenza (0-1) " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 5)) then
				tab_1.tabpage_2.dw_2.setitem ( k_riga, 5, 0)
			end if
//				or ((tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 5))) = 0 then
//				k_return = k_return + tab_1.tabpage_2.text + ": Impostare nr. rate (0-99) " + "~n~r" 
//				k_errore = "3"
//				k_nr_errori++
//			end if
			if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 6)) then
				k_return = k_return + tab_1.tabpage_2.text + ": Impostare gg prima rata (0-999) " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			
			if tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 5) > 1 then
				if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 7)) then
					k_return = k_return + tab_1.tabpage_2.text + ": Impostare gg rate successive (0-999) " + "~n~r" 
					k_errore = "3"
					k_nr_errori++
				end if
			else
				if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 7)) then
					tab_1.tabpage_2.dw_2.setitem ( k_riga, 7, 0)
				else
					if (tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 7)) > 0 then
						k_return = k_return + tab_1.tabpage_2.text + ": incongruenza tra Nr.Rate e Rate Successive " + "~n~r" 
						k_errore = "3"
						k_nr_errori++
					end if
				end if
			end if
		end if

		if (k_errore = "0" or k_errore = "4") and k_riga <= k_nr_righe then
			k_key = string(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 1))
			k_keyn = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 1)
			k_riga_find = tab_1.tabpage_2.dw_2.find("#1 = " + k_key, 1, k_nr_righe) 
			if k_riga_find > 1 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_2.dw_2.find("#1 = " + k_key, k_riga_find, k_nr_righe) > 0 then
					k_return = tab_1.tabpage_2.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				select codice
					into :k_keyn
					from iva
					where codice = :k_keyn;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_2.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop



//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
	k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

 	   if isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 1)) = true    &
 	      or tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 1) = 0  &
 	      or isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 2)) = true &
 	      or tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 2) = 0 &
 	      or isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 3)) = true &
 	      or tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 3) = 0 &
		   then
			k_return = tab_1.tabpage_3.text + ": Manca una misura " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		end if

	   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
			if k_errore = "0" then // and k_riga <= k_nr_righe then
				k_larg = tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 1)
				k_lung = tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 1)
				k_alt = tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, 1)
				select lung
					 into :k_lung
					 from misure
					 where larg = :k_larg
							and lung = :k_lung
							and alt = :k_alt;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_3.text + ": Misure gia' in archivio " + "~n~r" 
					k_return = k_return + string(k_larg, "##0") + "x" &
								  + string(k_lung, "##0") + "x" + string(k_alt, "##0") + "x ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

 	   if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, 1)) &
			   = true then
			k_return = tab_1.tabpage_4.text + ": Manca il codice " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, 2)) = "" &
			   or isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, 2)) = true then
				k_return = tab_1.tabpage_4.text + ": Impostare la descrizione" + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		if k_errore = "0" or k_errore = "4" then
			k_key = string(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, 1))
			k_keyn = tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, 1)
			k_riga_find = tab_1.tabpage_4.dw_4.find("#1 = " + k_key, 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_4.dw_4.find("#1 = " + k_key, k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_4.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				select codice
					into :k_keyn
					from gru
					where codice = :k_keyn;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_4.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "escludi_da_stat_glob")) = "" &
			   or isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "escludi_da_stat_glob")) = true then
			tab_1.tabpage_4.dw_4.setitem(k_riga, "escludi_da_stat_glob", "N")
		end if

		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)

	loop



//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_5.dw_5.rowcount()
	k_riga = tab_1.tabpage_5.dw_5.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

  	   if isnull(tab_1.tabpage_5.dw_5.getitemstring ( k_riga, 1)) &
			   = true then
			k_return = tab_1.tabpage_5.text + ": Manca il codice " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if trim(tab_1.tabpage_5.dw_5.getitemstring ( k_riga, 2)) = "" &
			   or isnull(tab_1.tabpage_5.dw_5.getitemstring ( k_riga, 2)) = true then
				k_return = tab_1.tabpage_5.text + ": Impostare la descrizione" + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		if k_errore = "0" then // and k_riga <= k_nr_righe then
			k_key = string(tab_1.tabpage_5.dw_5.getitemstring ( k_riga, 1))
			k_riga_find = tab_1.tabpage_5.dw_5.find("#1 = '" + k_key + "' ", 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_5.dw_5.find("#1 = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_5.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				select codice
					into :k_key
					from caus
					where codice = :k_key;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_5.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_5.dw_5.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_6.dw_6.rowcount()
	k_riga = tab_1.tabpage_6.dw_6.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10


		tab_1.tabpage_6.dw_6.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_6.dw_6.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
//  	   if isnull(tab_1.tabpage_6.dw_6.getitemstring ( k_riga, 1)) &
//			   = true then
//			k_return = tab_1.tabpage_6.text + ": Manca il codice " + "~n~r"
//			k_errore = "3"
//			k_nr_errori++
//		else
//			if trim(tab_1.tabpage_6.dw_6.getitemstring ( k_riga, 2)) = "" &
//			   or isnull(tab_1.tabpage_6.dw_6.getitemstring ( k_riga, 2)) = true then
//				k_return = tab_1.tabpage_6.text + ": Impostare la descrizione" + "~n~r" 
//				k_errore = "3"
//				k_nr_errori++
//			end if
//		end if
//
//		if k_errore = "0" then // and k_riga <= k_nr_righe then
//			k_key = string(tab_1.tabpage_6.dw_6.getitemstring ( k_riga, 1))
//			k_riga_find = tab_1.tabpage_6.dw_6.find("#1 = '" + k_key + "' ", 1, k_nr_righe) 
//			if k_riga_find > 1 and k_riga_find < k_nr_righe then
//				k_riga_find++
//				if tab_1.tabpage_6.dw_6.find("#1 = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
//					k_return = tab_1.tabpage_6.text + ": Codice gia' in archivio " + "~n~r" 
//					k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
//					k_errore = "3"
//					k_nr_errori++
//				else
//				   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
//						select codice
//							into :k_key
//							from caus
//							where codice = :k_key;
//						if sqlca.sqlcode = 0 then
//							k_return = tab_1.tabpage_6.text + ": Codice gia' in archivio " + "~n~r" 
//							k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
//							k_errore = "3"
//							k_nr_errori++
//						end if
//					end if
//				end if
//			end if
//		end if

		k_riga = tab_1.tabpage_6.dw_6.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
	k_riga = tab_1.tabpage_7.dw_7.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10


		k_key = string(tab_1.tabpage_7.dw_7.getitemstring ( k_riga, "id_nazione"))
		k_riga_find = tab_1.tabpage_7.dw_7.find("id_nazione = '" + k_key + "' ", 1, k_nr_righe) 
		if k_riga_find > 0 and k_riga_find < k_nr_righe then
			k_riga_find++
			if tab_1.tabpage_7.dw_7.find("id_nazione = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
				k_return = tab_1.tabpage_7.text + ": Nazione gia' in archivio " + "~n~r" 
				k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				kst_tab_nazioni.id_nazione = trim(tab_1.tabpage_7.dw_7.getitemstring(k_riga, "id_nazione"))
				if kiuf_ausiliari.if_gia_esiste(kst_tab_nazioni) then
					k_return = tab_1.tabpage_7.text + ": Nazione gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(kst_tab_nazioni.id_nazione) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
		
				end if
			end if
		end if
//		tab_1.tabpage_7.dw_7.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//		tab_1.tabpage_7.dw_7.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

		k_riga = tab_1.tabpage_7.dw_7.getnextmodified(k_riga, primary!)

	loop
	
//=== Controllo altro tab
	k_riga = tab_1.tabpage_8.dw_8.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = string(tab_1.tabpage_8.dw_8.getitemstring ( k_riga, "cap"))
		k_riga_find = tab_1.tabpage_8.dw_8.find("cap = '" + k_key + "' ", 1, k_nr_righe) 
		if k_riga_find > 0 and k_riga_find < k_nr_righe then
			k_riga_find++
			if tab_1.tabpage_8.dw_8.find("cap = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
				k_return = tab_1.tabpage_8.text + ": CAP postale gia' in archivio " + "~n~r" 
				k_return = k_return + "(CAP " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				kst_tab_cap.cap = trim(tab_1.tabpage_8.dw_8.getitemstring(k_riga, "cap"))
				if kiuf_ausiliari.if_gia_esiste(kst_tab_cap) then
					k_return = tab_1.tabpage_8.text + ": CAP postale gia' in archivio " + "~n~r" 
					k_return = k_return + "(CAP " + trim(kst_tab_cap.cap) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
		
				end if
			end if
		end if
//		tab_1.tabpage_7.dw_7.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//		tab_1.tabpage_7.dw_7.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

		k_riga = tab_1.tabpage_8.dw_8.getnextmodified(k_riga, primary!)

	loop
	
	
//=== Controllo altro tab
	k_riga = tab_1.tabpage_9.dw_9.getnextmodified(0, primary!)
	k_nr_righe = tab_1.tabpage_9.dw_9.rowcount()

	do while k_riga > 0  and k_nr_errori < 10


		if k_errore = "0" or k_errore = "4" then // and k_riga <= k_nr_righe then
			k_key = string(tab_1.tabpage_9.dw_9.getitemstring ( k_riga, "sigla"))
			k_riga_find = tab_1.tabpage_9.dw_9.find("sigla = '" + k_key + "' ", 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_9.dw_9.find("sigla = '" + k_key + "' ", k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_9.text + ": Sigla gia' in archivio " + "~n~r" 
					k_return = k_return + "(Sigla " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if
		if k_errore = "0" or k_errore = "4" then
			if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.inserimento then
				select sigla
					into :k_key
					from province
					where sigla = :k_key;
				if sqlca.sqlcode = 0 then
					k_return = tab_1.tabpage_5.text + ": Sigla gia' in archivio " + "~n~r" 
					k_return = k_return + "(Sigla " + trim(k_key) + ") ~n~r"
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		k_riga = tab_1.tabpage_9.dw_9.getnextmodified(k_riga, primary!)

	loop

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "Anomalia su DB: " + trim(kst_esito.sqlerrtext) + "~n~r" 
	k_return = k_return + "(Errore codice: " + string(kst_esito.sqlcode) + ") ~n~r"
	k_errore = "1"
	k_nr_errori++

end try

return k_errore + k_return


end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
string k_style, k_rc1
kuf_utility kuf1_utility


	u_retrieve("d_c_iva")

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
 	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
			
	   kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata) //proteggo tutto
	else
	
	   kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata) //--- S-protezione campi per riabilitare la modifica 
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata) //protegge il codice
		end if
	end if
	
	destroy kuf1_utility


	attiva_tasti()

return "0"
	



end function

protected subroutine inizializza_5 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
string k_key
string k_style, k_rc1
kuf_utility kuf1_utility
datawindowchild kdwc_art, kdwc_clienti


//	tab_1.tabpage_6.dw_6.dataobject = "d_meca_causali"
	u_retrieve("d_meca_causali")

	k_rc = tab_1.tabpage_6.dw_6.getchild("clie_1", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	kdwc_clienti.retrieve("%")
	kdwc_clienti.insertrow(1)
	k_rc = tab_1.tabpage_6.dw_6.getchild("art", kdwc_art)
	k_rc = kdwc_art.settransobject(sqlca)
	kdwc_art.retrieve("%")
	kdwc_art.insertrow(1)

//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 

	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then

		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_6.dw_6) //protezione

	else

		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_6.dw_6) //sprotezione di tutto
//--- protezione campo chiave alla modifica 
      	kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_6.dw_6)

	end if
	destroy kuf1_utility




	





end subroutine

protected subroutine inizializza_6 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
string k_key
string k_style, k_rc1
kuf_utility kuf1_utility

	
//	tab_1.tabpage_7.dw_7.dataobject = "d_nazioni_l"
	u_retrieve("d_nazioni_l")
		
//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then

		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_7.dw_7) //protezione

	else	
//--- S-protezione campi per riabilitare la modifica 
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_7.dw_7)

//--- protezione campo chiave alla modifica 
	  	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.modifica then
			kuf1_utility.u_proteggi_dw("1", "id_nazione", tab_1.tabpage_7.dw_7)
		end if
	end if
	destroy kuf1_utility

end subroutine

protected subroutine inizializza_7 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
string k_key
string k_style, k_rc1
kuf_utility kuf1_utility

	
	//tab_1.tabpage_8.dw_8.dataobject = "d_cap_l"
	u_retrieve("d_cap_l")
		
//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 

	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
			
	   kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_8.dw_8) //proteggo tutto
	else
	
	    kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_8.dw_8) //--- S-protezione campi per riabilitare la modifica 
//--- protezione campo chiave alla modifica 
		if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.modifica then
				kuf1_utility.u_proteggi_dw("1", "cap", tab_1.tabpage_8.dw_8)
		end if
	end if
	
	destroy kuf1_utility

end subroutine

protected subroutine inizializza_8 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
string k_key
string k_style, k_rc1
kuf_utility kuf1_utility

	
	//tab_1.tabpage_9.dw_9.dataobject = "d_prov_l"
	u_retrieve("d_prov_l")

//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 

  	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then

		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_9.dw_9) //protezione
	
	else	
	//--- S-protezione campi per riabilitare la modifica 
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_9.dw_9)
	
	end if
	
	destroy kuf1_utility

end subroutine

protected subroutine open_start_window ();//
kiuf_ausiliari = create kuf_ausiliari
kidw_selezionata = tab_1.tabpage_1.dw_1
tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
end subroutine

protected function integer inserisci ();//
int k_return=1
string k_errore="0 "
long k_ctr
uo_d_std_1 kdw_x, kdw_y
kuf_utility kuf1_utility

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if

//if left(k_errore, 1) = "0" then

//=== Imposta tasti
//	attiva_tasti()

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			kdw_x = tab_1.tabpage_1.dw_1
			kdw_y = tab_1.tabpage_1.dw_11
		case 2
			kdw_x = tab_1.tabpage_2.dw_2
			kdw_y = tab_1.tabpage_2.dw_12
		case 3
			kdw_x = tab_1.tabpage_3.dw_3
			kdw_y = tab_1.tabpage_3.dw_13
		case 4
			kdw_x = tab_1.tabpage_4.dw_4
			kdw_y = tab_1.tabpage_4.dw_14
		case 5
			kdw_x = tab_1.tabpage_5.dw_5
			kdw_y = tab_1.tabpage_5.dw_15
		case 6
			kdw_x = tab_1.tabpage_6.dw_6
			kdw_y = tab_1.tabpage_6.dw_16
		case 7
			kdw_x = tab_1.tabpage_7.dw_7
			kdw_y = tab_1.tabpage_7.dw_17
		case 8
			kdw_x = tab_1.tabpage_8.dw_8
			kdw_y = tab_1.tabpage_8.dw_18
		case 9
			kdw_x = tab_1.tabpage_9.dw_9
			kdw_y = tab_1.tabpage_9.dw_19
	end choose	

	if kdw_y.enabled and not kdw_y.visible then
		kdw_y.dataobject = kdw_x.dataobject
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_proteggi_dw("1", 0, kdw_y) //protezione
		k_ctr =  kdw_x.rowcount()
		k_ctr = kdw_x.rowscopy( 1, kdw_x.rowcount(), primary!, kdw_y, 1, primary!)
		kdw_y.visible = true
		kdw_x.reset( )
	end if	
	kdw_x.accepttext()
	k_ctr = kdw_x.insertrow(0)
	kdw_x.scrolltorow(k_ctr)
	kdw_x.setrow(k_ctr)
	kdw_x.setcolumn(u_get_col_iniziale())
	
	u_resize_visualizza(kdw_y.enabled)
	
	u_set_dw_selezionata()		

	k_return = 0

return (k_return)
end function

protected function integer visualizza ();//---
//--- personalizza routine di visualizzazione
kuf_utility kuf1_utility
uo_d_std_1 kdw_1




//if tab_1.selectedtab = 1 then

	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	inizializza_lista()

//else
//
//	kdw_1 = u_get_dw( )
//	
//	kdw_1.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
//	
////--- Protezione campi
//	kuf1_utility = create kuf_utility
//	kuf1_utility.u_proteggi_dw("1", 0, kdw_1)
//	destroy kuf1_utility
//
//end if


return(0)
end function

public function integer u_get_col_iniziale ();//
	choose case tab_1.selectedtab 
		case 6
			return 2
		case else
			return 1
	end choose	


end function

protected subroutine u_nasconde_dw ();//
uo_d_std_1 kdw_y
statictext ktxt_1


	choose case tab_1.selectedtab 
		case  1 
			kdw_y = tab_1.tabpage_1.dw_11
			ktxt_1 = tab_1.tabpage_1.st_orizzontal_11
		case 2
			kdw_y = tab_1.tabpage_2.dw_12
			ktxt_1 = tab_1.tabpage_2.st_orizzontal_12
		case 3
			kdw_y = tab_1.tabpage_3.dw_13
			ktxt_1 = tab_1.tabpage_3.st_orizzontal_13
		case 4
			kdw_y = tab_1.tabpage_4.dw_14
			ktxt_1 = tab_1.tabpage_4.st_orizzontal_14
		case 5
			kdw_y = tab_1.tabpage_5.dw_15
			ktxt_1 = tab_1.tabpage_5.st_orizzontal_15
		case 6
			kdw_y = tab_1.tabpage_6.dw_16
			ktxt_1 = tab_1.tabpage_6.st_orizzontal_16
		case 7
			kdw_y = tab_1.tabpage_7.dw_17
			ktxt_1 = tab_1.tabpage_7.st_orizzontal_17
		case 8
			kdw_y = tab_1.tabpage_8.dw_18
			ktxt_1 = tab_1.tabpage_8.st_orizzontal_18
		case 9
			kdw_y = tab_1.tabpage_9.dw_19
			ktxt_1 = tab_1.tabpage_9.st_orizzontal_19
	end choose	

	if isvalid(kdw_y) then
		if kdw_y.visible then
			ktxt_1.visible = false
			kdw_y.visible = false
			kdw_y.reset( )
		end if
	end if

	u_resize_visualizza(false)
	
end subroutine

protected subroutine u_set_modalita (string a_modalita);//

	choose case ki_tab_1_index_new //tab_1.selectedtab 
		case  1 
			tab_1.tabpage_1.dw_1.ki_flag_modalita = a_modalita	
		case 2
			tab_1.tabpage_2.dw_2.ki_flag_modalita = a_modalita	
		case 3
			tab_1.tabpage_3.dw_3.ki_flag_modalita = a_modalita	
		case 4
			tab_1.tabpage_4.dw_4.ki_flag_modalita = a_modalita	
		case 5
			tab_1.tabpage_5.dw_5.ki_flag_modalita = a_modalita	
		case 6
			tab_1.tabpage_6.dw_6.ki_flag_modalita = a_modalita	
		case 7
			tab_1.tabpage_7.dw_7.ki_flag_modalita = a_modalita	
		case 8
			tab_1.tabpage_8.dw_8.ki_flag_modalita = a_modalita	
		case 9
			tab_1.tabpage_9.dw_9.ki_flag_modalita = a_modalita	
	end choose	
	ki_st_open_w.flag_modalita = a_modalita

end subroutine

public subroutine u_resize_visualizza (boolean a_visible);//
uo_d_std_1 kdw_x, kdw_y
statictext ktxt_1


	choose case tab_1.selectedtab 
		case 1
			kdw_x = tab_1.tabpage_1.dw_1
			kdw_y = tab_1.tabpage_1.dw_11
			ktxt_1 = tab_1.tabpage_1.st_orizzontal_11
		case 2
			kdw_x = tab_1.tabpage_2.dw_2
			kdw_y = tab_1.tabpage_2.dw_12
			ktxt_1 = tab_1.tabpage_2.st_orizzontal_12
		case 3
			kdw_x = tab_1.tabpage_3.dw_3
			kdw_y = tab_1.tabpage_3.dw_13
			ktxt_1 = tab_1.tabpage_3.st_orizzontal_13
		case 4
			kdw_x = tab_1.tabpage_4.dw_4
			kdw_y = tab_1.tabpage_4.dw_14
			ktxt_1 = tab_1.tabpage_4.st_orizzontal_14
		case 5
			kdw_x = tab_1.tabpage_5.dw_5
			kdw_y = tab_1.tabpage_5.dw_15
			ktxt_1 = tab_1.tabpage_5.st_orizzontal_15
		case 6
			kdw_x = tab_1.tabpage_6.dw_6
			kdw_y = tab_1.tabpage_6.dw_16
			ktxt_1 = tab_1.tabpage_6.st_orizzontal_16
		case 7
			kdw_x = tab_1.tabpage_7.dw_7
			kdw_y = tab_1.tabpage_7.dw_17
			ktxt_1 = tab_1.tabpage_7.st_orizzontal_17
		case 8
			kdw_x = tab_1.tabpage_8.dw_8
			kdw_y = tab_1.tabpage_8.dw_18
			ktxt_1 = tab_1.tabpage_8.st_orizzontal_18
		case 9
			kdw_x = tab_1.tabpage_9.dw_9
			kdw_y = tab_1.tabpage_9.dw_19
			ktxt_1 = tab_1.tabpage_9.st_orizzontal_19
	end choose	

	if isvalid(kdw_x) then
		if kdw_y.enabled then
			if not ktxt_1.visible then
				ktxt_1.y = kdw_x.height / 2
			end if
			ktxt_1.visible = a_visible
			if a_visible then
				kdw_y.x = kdw_x.x
				kdw_y.width = kdw_x.width
				ktxt_1.x = kdw_x.x
				ktxt_1.width = kdw_x.width
				kdw_y.height = tab_1.height - ktxt_1.height * 2 - ktxt_1.y
				kdw_x.height = ktxt_1.y
				kdw_y.y = ktxt_1.y + ktxt_1.height
			else
				kdw_x.height = tab_1.height - ktxt_1.height
			end if
		end if
	end if
	kdw_y.visible = a_visible
	ktxt_1.enabled = kdw_y.enabled

end subroutine

protected subroutine u_set_dw_selezionata ();//

	choose case ki_tab_1_index_new// tab_1.selectedtab 
		case  1 
			kidw_selezionata = tab_1.tabpage_1.dw_1
		case 2
			kidw_selezionata = tab_1.tabpage_2.dw_2
		case 3
			kidw_selezionata = tab_1.tabpage_3.dw_3
		case 4
			kidw_selezionata = tab_1.tabpage_4.dw_4
		case 5
			kidw_selezionata = tab_1.tabpage_5.dw_5
		case 6
			kidw_selezionata = tab_1.tabpage_6.dw_6
		case 7
			kidw_selezionata = tab_1.tabpage_7.dw_7
		case 8
			kidw_selezionata = tab_1.tabpage_8.dw_8
		case 9
			kidw_selezionata = tab_1.tabpage_9.dw_9
	end choose	


end subroutine

public subroutine u_mousemove (unsignedlong flags, double xpos, double ypos);//
uo_d_std_1 kdw_x, kdw_y
statictext ktxt_1


//Check for move in progess
//If KeyDown(keyLeftButton!) Then

	choose case tab_1.selectedtab 
		case 1
			kdw_x = tab_1.tabpage_1.dw_1
			kdw_y = tab_1.tabpage_1.dw_11
			ktxt_1 = tab_1.tabpage_1.st_orizzontal_11
		case 2
			kdw_x = tab_1.tabpage_2.dw_2
			kdw_y = tab_1.tabpage_2.dw_12
			ktxt_1 = tab_1.tabpage_2.st_orizzontal_12
		case 3
			kdw_x = tab_1.tabpage_3.dw_3
			kdw_y = tab_1.tabpage_3.dw_13
			ktxt_1 = tab_1.tabpage_3.st_orizzontal_13
		case 4
			kdw_x = tab_1.tabpage_4.dw_4
			kdw_y = tab_1.tabpage_4.dw_14
			ktxt_1 = tab_1.tabpage_4.st_orizzontal_14
		case 5
			kdw_x = tab_1.tabpage_5.dw_5
			kdw_y = tab_1.tabpage_5.dw_15
			ktxt_1 = tab_1.tabpage_5.st_orizzontal_15
		case 6
			kdw_x = tab_1.tabpage_6.dw_6
			kdw_y = tab_1.tabpage_6.dw_16
			ktxt_1 = tab_1.tabpage_6.st_orizzontal_16
		case 7
			kdw_x = tab_1.tabpage_7.dw_7
			kdw_y = tab_1.tabpage_7.dw_17
			ktxt_1 = tab_1.tabpage_7.st_orizzontal_17
		case 8
			kdw_x = tab_1.tabpage_8.dw_8
			kdw_y = tab_1.tabpage_8.dw_18
			ktxt_1 = tab_1.tabpage_8.st_orizzontal_18
		case 9
			kdw_x = tab_1.tabpage_9.dw_9
			kdw_y = tab_1.tabpage_9.dw_19
			ktxt_1 = tab_1.tabpage_9.st_orizzontal_19
	end choose	

//	if ktxt_1.PointerY() > kiw_this_window.height / 10 then
		ktxt_1.y = kiw_this_window.PointerY()
		kdw_x.height = ktxt_1.y
		kdw_y.y = ktxt_1.y + ktxt_1.height
		kdw_y.height = height - ktxt_1.y - ktxt_1.height
		
		
//	end if
//End If


end subroutine

public function integer u_retrieve (string a_dataobject);//
long k_rows	
	
	
	u_set_dw_selezionata( )

   	if trim(kidw_selezionata.ki_flag_modalita) <> kkg_flag_modalita.inserimento then

		ki_fai_nuovo_dopo_update = false

		if kidw_selezionata.rowcount() = 0 or ki_dataobject_precedente <> a_dataobject then
			ki_dataobject_precedente = a_dataobject
			
			kidw_selezionata.dataobject = a_dataobject
			kidw_selezionata.settransobject(kguo_sqlca_db_magazzino)
	
			k_rows = kidw_selezionata.retrieve() 
			if k_rows > 0 then
				
			else
	
				messagebox("Operazione conclusa", "Nessun dato Trovato in archivio~n~r")
	
				inserisci()
				
			end if
		end if
		kidw_selezionata.GroupCalc()	
	else
		inserisci()
	end if

	attiva_tasti()

	kidw_selezionata.setfocus()


return kidw_selezionata.rowcount()
end function

public function boolean u_dati_modif_dw ();//
//---- Verifica se il dw che sto lavorando è da aggiornare
//
boolean k_return 


	choose case ki_tab_1_index_new //tab_1.selectedtab 
		case  1 
			k_return = dati_modif_dw(tab_1.tabpage_1.dw_1)
		case 2
			k_return = dati_modif_dw(tab_1.tabpage_2.dw_2)	
		case 3
			k_return = dati_modif_dw(tab_1.tabpage_3.dw_3)	
		case 4
			k_return = dati_modif_dw(tab_1.tabpage_4.dw_4)	
		case 5
			k_return = dati_modif_dw(tab_1.tabpage_5.dw_5)	
		case 6
			k_return = dati_modif_dw(tab_1.tabpage_6.dw_6)	
		case 7
			k_return = dati_modif_dw(tab_1.tabpage_7.dw_7)	
		case 8
			k_return = dati_modif_dw(tab_1.tabpage_8.dw_8)	
		case 9
			k_return = dati_modif_dw(tab_1.tabpage_9.dw_9)	
	end choose	


return k_return
end function

protected function string dati_modif (string k_titolo);//
//--- Controllo se ci sono state modifiche di dati sui DW
//--- Ritorna: 0=agg.non necessario; 1=fare aggiornamento; 
//---          2=non fare agg.; 3=annulla operazione
//
string k_return= "0"
int k_msg=0
boolean k_dati_modificati=false


//---- personalizzazioni varie x i gli oggetti eredi di inzio
k_return = dati_modif_figlio_inizio(k_titolo)
	
if k_return = "0" then

//--- Aggiornamento dei dati inseriti/modificati
	dati_modif_accept( )

//--- Toglie dati (le righe) eventualmente da non registrare
	pulizia_righe()
	
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then 
		
//--- controlla se ci sono dati modificati		
//		k_dati_modificati = dati_modif_0() 	//--- controlla se ci sono dati modificati personalizzata
		if ki_exit_si then
			k_dati_modificati = dati_modif_1()  //--- controlla se ci sono dati modificati standard
		else
			k_dati_modificati = u_dati_modif_dw( )  // Controllo puntuale del dw con il fuoco
		end if
		if k_dati_modificati then // se ci sono dato midificati chiedo se aggiornare
			
			if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			if ki_esponi_msg_dati_modificati then 
				k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
									question!, yesnocancel!, 1) 
			else
				if ki_esponi_msg_dati_modificati_salvaauotom then
					k_msg = 1
				else
					k_msg = 2
				end if
			end if
		
			if k_msg = 1 then
				k_return = "1Dati Modificati"	
			else
				k_return = string(k_msg)			
			end if
			
		end if
		
	end if

end if

//---- personalizzazioni varie x i FIGLI alla fine di queste operazioni
dati_modif_figlio_fine(k_return)

return k_return
end function

public subroutine u_resize_1 ();//
super::u_resize_1( )
tab_1.tabpage_1.dw_11.resize(tab_1.tabpage_1.dw_1.width, tab_1.tabpage_1.dw_1.height)
tab_1.tabpage_2.dw_12.resize(tab_1.tabpage_2.dw_2.width, tab_1.tabpage_2.dw_2.height)
tab_1.tabpage_3.dw_13.resize(tab_1.tabpage_3.dw_3.width, tab_1.tabpage_3.dw_3.height)
tab_1.tabpage_4.dw_14.resize(tab_1.tabpage_4.dw_4.width, tab_1.tabpage_4.dw_4.height)
tab_1.tabpage_5.dw_15.resize(tab_1.tabpage_5.dw_5.width, tab_1.tabpage_5.dw_5.height)
tab_1.tabpage_6.dw_16.resize(tab_1.tabpage_6.dw_6.width, tab_1.tabpage_6.dw_6.height)
tab_1.tabpage_7.dw_17.resize(tab_1.tabpage_7.dw_7.width, tab_1.tabpage_7.dw_7.height)
tab_1.tabpage_8.dw_18.resize(tab_1.tabpage_8.dw_8.width, tab_1.tabpage_8.dw_8.height)
tab_1.tabpage_9.dw_19.resize(tab_1.tabpage_9.dw_9.width, tab_1.tabpage_9.dw_9.height)

end subroutine

on w_ausiliari.create
int iCurrent
call super::create
end on

on w_ausiliari.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_ausiliari) then destroy kiuf_ausiliari

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_ausiliari
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ausiliari
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ausiliari
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ausiliari
end type

type st_stampa from w_g_tab_3`st_stampa within w_ausiliari
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ausiliari
end type

event cb_visualizza::clicked;//
u_nasconde_dw( )

u_set_modalita(kkg_flag_modalita.visualizzazione)
super::event clicked( )		

end event

type cb_modifica from w_g_tab_3`cb_modifica within w_ausiliari
end type

event cb_modifica::clicked;//
u_set_modalita(kkg_flag_modalita.modifica)
super::event clicked( )		

end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ausiliari
boolean enabled = true
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ausiliari
integer y = 1220
boolean enabled = true
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ausiliari
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//tab_1.tabpage_1.dw_1.accepttext()
//tab_1.tabpage_2.dw_2.accepttext()
//tab_1.tabpage_3.dw_3.accepttext()
//tab_1.tabpage_4.dw_4.accepttext()
//tab_1.tabpage_5.dw_5.accepttext()
//tab_1.tabpage_6.dw_6.accepttext()
//tab_1.tabpage_7.dw_7.accepttext()
//tab_1.tabpage_8.dw_8.accepttext()
//tab_1.tabpage_9.dw_9.accepttext()

k_errore = left(dati_modif(""), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = aggiorna_dati()		

else

	if k_errore = "2" then //Aggiornamento non richiesto
		k_errore = "0"
	end if

end if


//if LeftA(k_errore, 1) = "0" then 
	
//	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.inserimento then
//		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
//		tab_1.tabpage_1.dw_1.reset( )
//		tab_1.tabpage_2.dw_2.reset( )
//		tab_1.tabpage_3.dw_3.reset( )
//		tab_1.tabpage_4.dw_4.reset( )
//		tab_1.tabpage_5.dw_5.reset( )
//		tab_1.tabpage_6.dw_6.reset( )
//		tab_1.tabpage_7.dw_7.reset( )
//		tab_1.tabpage_8.dw_8.reset( )
//		tab_1.tabpage_9.dw_9.reset( )
//	end if

if LeftA(k_errore, 1) = "0" then 

	try	
		
		u_set_modalita(kkg_flag_modalita.inserimento)
		u_set_dw_selezionata()		
		
		choose case tab_1.selectedtab 
			case  1 
				inizializza()
			case 2
				inizializza_1()
			case 3
				inizializza_2()
			case 4
				inizializza_3()
			case 5
				inizializza_4()
			case 6
				inizializza_5()
			case 7
				inizializza_6()
			case 8
				inizializza_7()
			case 9
				inizializza_8()
		end choose
		
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente( )
		
	end try		

end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_ausiliari
integer x = 46
integer width = 1833
integer textsize = -9
fontcharset fontcharset = ansi!
boolean fixedwidth = true
boolean multiline = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
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
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
long backcolor = 32501743
string text = "codici IVA"
st_orizzontal_11 st_orizzontal_11
dw_11 dw_11
end type

on tabpage_1.create
this.st_orizzontal_11=create st_orizzontal_11
this.dw_11=create dw_11
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_11
this.Control[iCurrent+2]=this.dw_11
end on

on tabpage_1.destroy
call super::destroy
destroy(this.st_orizzontal_11)
destroy(this.dw_11)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 0
integer y = 12
integer width = 1225
integer height = 592
string dataobject = "d_c_iva"
end type

event dw_1::itemchanged;//
//--- Impossibile modificare un codice già in archivio
//
//if dwo.name = "codice" then
//	return check_key(row, dwo.name, data, tab_1.tabpage_1.dw_1) 
//end if
//
attiva_tasti( )

end event

event dw_1::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
long backcolor = 553648127
string text = "Tipi Pagamento"
long tabbackcolor = 32501743
st_orizzontal_12 st_orizzontal_12
dw_12 dw_12
end type

on tabpage_2.create
this.st_orizzontal_12=create st_orizzontal_12
this.dw_12=create dw_12
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_12
this.Control[iCurrent+2]=this.dw_12
end on

on tabpage_2.destroy
call super::destroy
destroy(this.st_orizzontal_12)
destroy(this.dw_12)
end on

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 5
integer width = 1778
boolean enabled = true
string dataobject = "d_c_pag"
end type

event dw_2::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
long backcolor = 32501743
string text = "Misure"
st_orizzontal_13 st_orizzontal_13
dw_13 dw_13
end type

on tabpage_3.create
this.st_orizzontal_13=create st_orizzontal_13
this.dw_13=create dw_13
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_13
this.Control[iCurrent+2]=this.dw_13
end on

on tabpage_3.destroy
call super::destroy
destroy(this.st_orizzontal_13)
destroy(this.dw_13)
end on

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 1591
integer height = 904
boolean enabled = true
string dataobject = "d_misure"
end type

event dw_3::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
long backcolor = 32501743
string text = "Gruppi"
st_orizzontal_14 st_orizzontal_14
dw_14 dw_14
end type

on tabpage_4.create
this.st_orizzontal_14=create st_orizzontal_14
this.dw_14=create dw_14
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_14
this.Control[iCurrent+2]=this.dw_14
end on

on tabpage_4.destroy
call super::destroy
destroy(this.st_orizzontal_14)
destroy(this.dw_14)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 18
integer y = 16
integer width = 1577
integer height = 928
boolean enabled = true
string dataobject = "d_gruppi"
end type

event dw_4::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
long backcolor = 32501743
string text = "Causali di ~r~nSpedizione"
st_orizzontal_15 st_orizzontal_15
dw_15 dw_15
end type

on tabpage_5.create
this.st_orizzontal_15=create st_orizzontal_15
this.dw_15=create dw_15
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_15
this.Control[iCurrent+2]=this.dw_15
end on

on tabpage_5.destroy
call super::destroy
destroy(this.st_orizzontal_15)
destroy(this.dw_15)
end on

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer x = 5
integer y = 24
integer width = 1582
integer height = 884
boolean enabled = true
string dataobject = "d_causali"
end type

event dw_5::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
boolean enabled = true
long backcolor = 32501743
string text = "Causali di~r~nEntrata Merce"
st_orizzontal_16 st_orizzontal_16
dw_16 dw_16
end type

on tabpage_6.create
this.st_orizzontal_16=create st_orizzontal_16
this.dw_16=create dw_16
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_16
this.Control[iCurrent+2]=this.dw_16
end on

on tabpage_6.destroy
call super::destroy
destroy(this.st_orizzontal_16)
destroy(this.dw_16)
end on

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer y = 28
integer width = 1509
integer height = 716
boolean enabled = true
string dataobject = "d_meca_causali"
end type

event dw_6::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
boolean enabled = true
long backcolor = 32501743
string text = "Nazioni"
st_orizzontal_17 st_orizzontal_17
dw_17 dw_17
end type

on tabpage_7.create
this.st_orizzontal_17=create st_orizzontal_17
this.dw_17=create dw_17
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_17
this.Control[iCurrent+2]=this.dw_17
end on

on tabpage_7.destroy
call super::destroy
destroy(this.st_orizzontal_17)
destroy(this.dw_17)
end on

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
boolean enabled = true
string dataobject = "d_nazioni_l"
end type

event dw_7::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
boolean enabled = true
long backcolor = 32501743
string text = "C.A.P.~r~nPostali"
st_orizzontal_18 st_orizzontal_18
dw_18 dw_18
end type

on tabpage_8.create
this.st_orizzontal_18=create st_orizzontal_18
this.dw_18=create dw_18
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_18
this.Control[iCurrent+2]=this.dw_18
end on

on tabpage_8.destroy
call super::destroy
destroy(this.st_orizzontal_18)
destroy(this.dw_18)
end on

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
boolean enabled = true
string dataobject = "d_cap_l"
end type

event dw_8::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
boolean visible = true
integer x = 1061
integer y = 16
integer width = 754
integer height = 1112
boolean enabled = true
long backcolor = 32501743
string text = "Province"
string powertiptext = "Elenco province"
st_orizzontal_19 st_orizzontal_19
dw_19 dw_19
end type

on tabpage_9.create
this.st_orizzontal_19=create st_orizzontal_19
this.dw_19=create dw_19
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_orizzontal_19
this.Control[iCurrent+2]=this.dw_19
end on

on tabpage_9.destroy
call super::destroy
destroy(this.st_orizzontal_19)
destroy(this.dw_19)
end on

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
boolean enabled = true
string dataobject = "d_prov_l"
end type

event dw_9::doubleclicked;//
// sul doppio clck non faccio nulla

end event

type st_orizzontal_11 from statictext within tabpage_1
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -3
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_11 from uo_d_std_1 within tabpage_1
integer x = 110
integer y = 672
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_12 from statictext within tabpage_2
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_12 from uo_d_std_1 within tabpage_2
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_13 from statictext within tabpage_3
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_13 from uo_d_std_1 within tabpage_3
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_14 from statictext within tabpage_4
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_14 from uo_d_std_1 within tabpage_4
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_15 from statictext within tabpage_5
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_15 from uo_d_std_1 within tabpage_5
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_16 from statictext within tabpage_6
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_16 from uo_d_std_1 within tabpage_6
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_17 from statictext within tabpage_7
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_17 from uo_d_std_1 within tabpage_7
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_18 from statictext within tabpage_8
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_18 from uo_d_std_1 within tabpage_8
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

type st_orizzontal_19 from statictext within tabpage_9
event u_mousemove pbm_mousemove
boolean visible = false
integer x = 14
integer y = 632
integer width = 1083
integer height = 12
boolean bringtotop = true
integer textsize = -4
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event u_mousemove;//
If KeyDown(keyLeftButton!) Then

	u_mousemove(flags, xpos, ypos)

end if

return 0

end event

type dw_19 from uo_d_std_1 within tabpage_9
integer x = 110
integer y = 664
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean ki_link_standard_sempre_possibile = true
boolean ki_dw_visibile_in_open_window = false
end type

