$PBExportHeader$w_ausiliari_1.srw
forward
global type w_ausiliari_1 from w_ausiliari
end type
end forward

global type w_ausiliari_1 from w_ausiliari
string title = "Tabelle Ausiliarie 2"
boolean ki_toolbar_window_presente = true
end type
global w_ausiliari_1 w_ausiliari_1

type variables

end variables

forward prototypes
protected subroutine attiva_menu ()
protected function integer cancella ()
protected function string check_dati ()
protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw)
private subroutine dosimetrie_importa_file_csv ()
protected function string inizializza () throws uo_exception
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine smista_funz (string k_par_in)
protected subroutine pulizia_righe ()
private subroutine dosimetrie_cambia_stato ()
protected subroutine inizializza_4 ()
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine open_start_window ()
protected subroutine riempi_id ()
public function integer u_get_col_iniziale ()
end prototypes

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu

//=== 

	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Importa Lotto Dosimetrico da file CSV "
	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
	"Importa da file esterno in formato CSV (colonne separate dal ';') i valori dosimetrici    "
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	choose case tab_1.selectedtab 
		case 2 
		   if trim(tab_1.tabpage_2.dw_2.ki_flag_modalita) = kkg_flag_modalita.inserimento then //lotti dosimetrici 
				ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
			else
				ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			end if
		case else
			ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	end choose
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Importa,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Insert!"
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2


	ki_menu.m_strumenti.m_fin_gest_libero2.text = "Attiva/Disattiva Tutto il Lotto Dosimetrico "
	ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
	"Disattiva/Attiva Lotto dosimetrico selezionato    "
	ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
	choose case tab_1.selectedtab 
		case 2 
		   if trim(tab_1.tabpage_2.dw_2.ki_flag_modalita) = kkg_flag_modalita.modifica then //lotti dosimetrici 
				ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
			else
				ki_menu.m_strumenti.m_fin_gest_libero2.enabled = false
			end if
		case else
			ki_menu.m_strumenti.m_fin_gest_libero2.enabled = false
	end choose
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Disattiva,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Custom093!"
	ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

	super::attiva_menu()


end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record
string k_key
string k_key_1
long k_key_2, k_key_3
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi
st_tab_listino_voci_categ kst_tab_listino_voci_categ
st_tab_sr_settori kst_tab_sr_settori
st_tab_imptime kst_tab_imptime
st_tab_dosimpos kst_tab_dosimpos
kuf_ausiliari  kuf1_ausiliari



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Cod. Banca "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_1.dw_1.getitemstring(k_riga, 1)
			k_desc  = tab_1.tabpage_1.dw_1.getitemstring(k_riga, 2)
			k_key = string(k_key_1)
		end if
	case 2 
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			kst_tab_dosimetrie.note = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "note_1")
			if tab_1.tabpage_2.dw_2.isexpanded( k_riga, 1) then
				kst_tab_dosimetrie.lotto_dosim = " "
				kst_tab_dosimetrie.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
				kst_tab_dosimetrie.dose = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "dose")
				k_record = " il Lotto Dosimetrico "
				k_key = "ID = " + string(kst_tab_dosimetrie.id)
			else
				kst_tab_dosimetrie.id = 0
				kst_tab_dosimetrie.lotto_dosim = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "lotto_dosim")
				k_record = " il Lotto Dosimetrico COMPLETO "
				k_key = "Nome = '" + trim(kst_tab_dosimetrie.lotto_dosim) + "' "
			end if
			k_desc = trim(kst_tab_dosimetrie.note)
		end if
	case 3
		k_record = " Settore Anagrafe Clienti..."
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 4
		k_record = " Classe Anagrafe Clienti... "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_4.dw_4.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_4.dw_4.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 5
		k_record = " Categoria Voce Listino "
		k_riga = tab_1.tabpage_5.dw_5.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 6
		k_record = " Settore Dipartimentale "
		k_riga = tab_1.tabpage_6.dw_6.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_6.dw_6.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_6.dw_6.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 7
		k_record = " Tempi Impianto "
		k_riga = tab_1.tabpage_7.dw_7.getrow()	
		if k_riga > 0 then
			k_key_2 = tab_1.tabpage_7.dw_7.getitemnumber(k_riga, 1)
			k_desc = tab_1.tabpage_7.dw_7.getitemstring(k_riga, 2)
			k_key = string(k_key_2)
		end if
	case 8
		k_record = " Posizione Dosimetro "
		k_riga = tab_1.tabpage_8.dw_8.getrow()	
		if k_riga > 0 then
			k_key_2 = tab_1.tabpage_8.dw_8.getitemnumber(k_riga, "id_dosimpos")
			k_desc = tab_1.tabpage_8.dw_8.getitemstring(k_riga, 2)
			k_key = string(k_key_2)
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and (isnull(k_key) = false or isnull(k_key_1) = false) then

	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "Codice '" + k_record + "' senza Descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, &
		"Sei sicuro di voler eliminare " + k_record + "~n~r" + &
		k_key + " -  " + trim(k_desc),  &
		question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_ausiliari = create kuf_ausiliari
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				kst_esito = kuf1_ausiliari.tb_delete_banche(k_key_1) 
			case 2
				kst_esito = kuf1_ausiliari.tb_delete_dosimetrie(kst_tab_dosimetrie) 
			case 3
				kst_tab_clie_settori.id_clie_settore = k_key
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_clie_settori) 
			case 4
				kst_tab_clie_classi.id_clie_classe = k_key
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_clie_classi) 
			case 5
				kst_tab_listino_voci_categ.id_listino_voci_categ = k_key
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_listino_voci_categ) 
			case 6
				kst_tab_sr_settori.sr_settore = k_key
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_sr_settori) 
			case 7
				kst_tab_imptime.id_imptime = k_key_2
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_imptime) 
			case 7
				kst_tab_dosimpos.id_dosimpos = k_key_2
				kst_esito = kuf1_ausiliari.tb_delete(kst_tab_dosimpos) 
		end choose	
		if trim(kst_esito.esito) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", "Controllare i dati. " + MidA(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 2
						if tab_1.tabpage_2.dw_2.isexpanded( k_riga, 1) then
							tab_1.tabpage_2.dw_2.deleterow(k_riga)
						else
							try
								tab_1.tabpage_2.dw_2.reset( )
								inizializza_1()
							catch (uo_exception kuo_exception)
							end try
						end if
				
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
				end choose	

			end if

		else
			k_return = 1
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", trim(kst_esito.SQLErrText) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", "Controllare i dati. " + MidA(k_errore, 2))
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
		tab_1.tabpage_8.dw_8.setcolumn("codice")
end choose	


return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
date k_data
string k_return = " "
string k_errore = "0"
long k_nr_righe
double k_dose, k_coeff 
int k_riga, k_riga_find, k_larg, k_lung, k_alt, k_riga_find1
int k_nr_errori, k_pos
string k_key, k_keyn, k_lotto_dosim, k_dataoggix
kuf_base kuf1_base


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 1)) &
			   = true &
				or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 1))) &
				<= 0 then
			k_return = tab_1.tabpage_1.text + ": Manca il codice " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 3)) &
			   = true &
				or (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 3)) &
				= 0 then
				k_return = tab_1.tabpage_1.text + ": Impostare il codice ABI " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 4)) &
			   = true &
				or (tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, 4)) &
				= 0 then
				k_return = tab_1.tabpage_1.text + ": Impostare il codice CAB " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
			if k_errore = "0" then
				if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 2)) &
					= true &
					or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 2))) &
					<= 0 then
					k_return = tab_1.tabpage_1.text + ": Manca la descrizione " + "~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if

		if k_errore = "0" then //and k_riga <= k_nr_righe then
			k_key = trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 1))
			k_riga_find = tab_1.tabpage_1.dw_1.find("#1 = '" + k_key + "'", 1, k_nr_righe) 
			if k_riga_find > 0 and k_riga_find < k_nr_righe then
				k_riga_find++
				if tab_1.tabpage_1.dw_1.find("#1 = '" + k_key + "'", k_riga_find, k_nr_righe) > 1 then
					k_return = tab_1.tabpage_1.text + ": Codice gia' in archivio " + "~n~r" 
					k_return = k_return + "(Codice " + trim(k_key) + "); ~n~r"
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

		if isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 1)) = true &
		   or LenA(trim(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 1))) = 0 &
			then
			k_return = tab_1.tabpage_2.text + ": Manca il Nome Lotto " + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l" then
				if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 2)) &
					or ((tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 2))) = 0 then
					k_return = k_return + tab_1.tabpage_2.text + ": Impostare la Dose " + "~n~r" 
					k_errore = "3"
					k_nr_errori++
				end if
			end if
		end if

		if k_errore = "0" and k_riga <= k_nr_righe  then
			
			if tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l" then
				k_key = trim(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 1))
				k_coeff = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "coeff_a_s")
				k_dose = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "dose")
				k_keyn = string(k_coeff)
				k_pos = PosA (k_keyn, ",")
				if k_pos > 0 then
					k_keyn = ReplaceA(k_keyn, k_pos,1, ".")
				end if
				k_riga_find = tab_1.tabpage_2.dw_2.find("#1 = '" + k_key + "' and coeff_a_s = " + trim(k_keyn) + " ", 1, k_nr_righe) 
				if k_riga_find > 0 and k_riga_find < k_nr_righe  then 
					k_riga_find++
					k_riga_find1 = tab_1.tabpage_2.dw_2.find("lotto_dosim = '" + k_key + "' and coeff_a_s = " + trim(k_keyn) + " ", k_riga_find, k_nr_righe) 
					if k_riga_find1 > k_riga_find then
						k_return = tab_1.tabpage_2.text + ": Lotto dosimetrico gia' in archivio " + "~n~r" 
						k_return = k_return + "(Lotto " + trim(k_key) + " Coeff. " + trim(k_keyn) +  + " Dose " + string(k_dose) + ") ~n~r"
						k_errore = "1"
						k_nr_errori++
					else
						if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
							k_dose = double(k_keyn)
							select lotto_dosim
								into :k_lotto_dosim
								from dosimetrie
								where lotto_dosim = :k_key and dose = :k_dose;
							if sqlca.sqlcode = 0 then
								k_return = tab_1.tabpage_2.text + ": Lotto dosimetrico gia' in archivio " + "~n~r" 
								k_return = k_return + "(Lotto " + trim(k_key) + " Dose " + trim(k_keyn) + ") ~n~r"
								k_errore = "1"
								k_nr_errori++
							end if
						end if
					end if
				end if
			end if
		end if
		if tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l" then
			if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id")) then
				tab_1.tabpage_2.dw_2.setitem ( k_riga, "id", 0)
			end if
		end if
		if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data")) &
			or tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data") = date(0) then
			kuf1_base = create kuf_base
			k_dataoggix = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
			destroy kuf1_base
			if isdate(k_dataoggix) then
				tab_1.tabpage_2.dw_2.setitem ( k_riga, "data", date(k_dataoggix))
			end if
		end if
		if isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "note")) &
			or LenA(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "note")) = 0 then
			tab_1.tabpage_2.dw_2.setitem ( k_riga, "note", " ")
		end if
		if isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "attivo")) &
			or LenA(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "attivo")) = 0 then
			tab_1.tabpage_2.dw_2.setitem ( k_riga, "attivo", "S")
		end if
		
		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
//	k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_riga = tab_1.tabpage_3.dw_3.getnextmodified(k_riga, primary!)
//
//	loop

//=== Controllo altro tab
//	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
//	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
//
//	do while k_riga > 0  and k_nr_errori < 10
//
//		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
//
//	loop

//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_5.dw_5.rowcount()
	k_riga = tab_1.tabpage_5.dw_5.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		if tab_1.tabpage_5.dw_5.getitemstatus(k_riga, 0, primary!) = newmodified! then
			k_key = tab_1.tabpage_5.dw_5.getitemstring(k_riga, "id_listino_voci_categ") 
			select count(id_listino_voci_categ)
				into :k_nr_righe
				from listino_voci_categ
				where id_listino_voci_categ = :k_key;
			if k_nr_righe > 0 then
				k_return = tab_1.tabpage_5.text + ": Codice Categoria gia' in archivio " + "~n~r" 
				k_return = k_return + "(cod. " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		
		k_riga = tab_1.tabpage_5.dw_5.getnextmodified(k_riga, primary!)

	loop
	
//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_6.dw_6.rowcount()
	k_riga = tab_1.tabpage_6.dw_6.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

//		tab_1.tabpage_6.dw_6.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
//		tab_1.tabpage_6.dw_6.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

		if tab_1.tabpage_6.dw_6.getitemstatus(k_riga, 0, primary!) = newmodified! then
			k_key = tab_1.tabpage_6.dw_6.getitemstring(k_riga, "sr_settore") 
			select count(sr_settore)
				into :k_nr_righe
				from sr_settori
				where sr_settore = :k_key;
			if k_nr_righe > 0 then
				k_return = tab_1.tabpage_6.text + ": Codice Settore gia' in archivio " + "~n~r" 
				k_return = k_return + "(cod. " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		
		k_riga = tab_1.tabpage_6.dw_6.getnextmodified(k_riga, primary!)

	loop
	
//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_7.dw_7.rowcount()
	k_riga = tab_1.tabpage_7.dw_7.getnextmodified(0, primary!)
	do while k_riga > 0 and k_nr_errori = 0

		if tab_1.tabpage_7.dw_7.getitemstatus(k_riga, 0, primary!) = newmodified! then
			k_data = tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_ini") 
			select count(id_imptime)
				into :k_nr_righe
				from imptime
				where data_ini = :k_data;
			if k_nr_righe > 0 then
				k_return = "Stessa data di inizio gia' in archivio " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if

			if tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_ini") > kkg.data_zero then
				if tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_ini") > tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_fin") then
					k_return += "Data di inizio maggiore della data di fine periodo " + "~n~r" 
					k_errore = "3"
					k_nr_errori++
				end if
			else
				k_return += "Indicare la Data di inizio validità " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if

			if tab_1.tabpage_7.dw_7.getitemnumber(k_riga, "fila_1_tcoeff") > 0 and tab_1.tabpage_7.dw_7.getitemnumber(k_riga, "fila_2_tcoeff") > 0 then
			else
				k_return += "Indicare i Coefficienti di moltiplicazione del tempo impianto per Fila 1 e 2 " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if
		if k_nr_errori = 0 then
			//--- popola valori di default
			if tab_1.tabpage_7.dw_7.getitemnumber(k_riga, "id_imptime") > 0 then
			else
				tab_1.tabpage_7.dw_7.setitem(k_riga, "id_imptime", 0)
			end if
			if trim(tab_1.tabpage_7.dw_7.getitemstring(k_riga, "impianto")) > " " then
			else
				tab_1.tabpage_7.dw_7.setitem(k_riga, "impianto", "2")
			end if
			if tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_fin") > kkg.data_zero then
			else
				tab_1.tabpage_7.dw_7.setitem(k_riga, "data_fin", relativedate(tab_1.tabpage_7.dw_7.getitemdate(k_riga, "data_ini"),365))
			end if
			if tab_1.tabpage_7.dw_7.getitemnumber(k_riga, "tminute") > 0 then
			else
				tab_1.tabpage_7.dw_7.setitem(k_riga,  "tminute", 0)
			end if
			if tab_1.tabpage_7.dw_7.getitemnumber(k_riga, "tsecond") > 0 then
			else
				tab_1.tabpage_7.dw_7.setitem(k_riga,  "tsecond", 0)
			end if
		
			k_riga = tab_1.tabpage_7.dw_7.getnextmodified(k_riga, primary!)
		else
			k_return = tab_1.tabpage_7.text + ": " + k_return
			tab_1.tabpage_7.dw_7.setrow(k_riga)
			tab_1.tabpage_7.dw_7.selectrow(0, false)
			tab_1.tabpage_7.dw_7.selectrow(k_riga, true)
		end if
	
	loop
	
//=== Controllo altro tab DOSIM.POSIZIONI SU PALLET
	k_nr_righe = tab_1.tabpage_8.dw_8.rowcount()
	for k_riga = 1 to k_nr_righe -1
		k_key = tab_1.tabpage_8.dw_8.getitemstring(k_riga,  "codice")
		k_riga_find = k_riga + 1
		do while k_key <>  tab_1.tabpage_8.dw_8.getitemstring(k_riga_find, "codice") and k_riga_find < k_nr_righe
			k_riga_find ++
		loop
		if k_key =  tab_1.tabpage_8.dw_8.getitemstring(k_riga_find ,  "codice") then
			k_return = tab_1.tabpage_8.text + ": Codice '" + trim(k_key) + "' nella riga " + string(k_riga) + " già in elenco alla  " + string(k_riga_find) + "~n~r" 
			k_errore = "3"
			k_nr_errori++
			exit
		end if
	end for
	
	if k_errore = "0" then
		k_riga = tab_1.tabpage_8.dw_8.getnextmodified(0, primary!)
	
		do while k_riga > 0  and k_nr_errori < 10
			k_key = tab_1.tabpage_8.dw_8.getitemstring(k_riga, "codice") 

			if trim(tab_1.tabpage_8.dw_8.getitemstring(k_riga ,  "descr")) > " " then
			
				if tab_1.tabpage_8.dw_8.getitemstatus(k_riga, 0, primary!) = newmodified! then
					select count(codice)
						into :k_nr_righe
						from dosimpos
						where codice = :k_key;
					if k_nr_righe > 0 then
						k_return = tab_1.tabpage_8.text + ": Codice '" + trim(k_key) + "' alla riga " + string(k_riga) + " già in archivio" + "~n~r" 
						k_errore = "1"
						k_nr_errori++
					end if
				end if
			else
				k_return = tab_1.tabpage_8.text + ": Manca descrizione per il Codice '" + trim(k_key) + "' alla riga " + string(k_riga)  + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
				
			
			k_riga = tab_1.tabpage_8.dw_8.getnextmodified(k_riga, primary!)
	
		loop
	end if
//
//=== Controllo altro tab
//ecc...


return k_errore + k_return
end function

protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw);//
//--- Controllo se gia' era un campo presente nella retrieve
int k_return = 0
dwItemStatus k_status

   k_status = k_dw.GetItemStatus(k_riga, k_colonna, primary!) 
	
	if k_status = datamodified! or k_status = notmodified! then 
		if not isnull(k_dw.getitemstring(k_riga, k_colonna,  Primary!, true)) then  
			k_return = 2
		end if
	end if

	if tab_1.tabpage_1.dw_1.find("#1 = '" + trim(k_key) + "'", 1, k_dw.rowcount()) > 1 then
		k_return = 1
	end if

return k_return


end function

private subroutine dosimetrie_importa_file_csv ();//
//--- importa da file csv i valori dosimetrici
//
integer k_rcn
st_esito kst_esito
kuf_ausiliari kuf1_dosimetrie


	k_rcn=messagebox("Operazione di Importazione nuovo Lotto Dosimetrico", &
					"Il file di importazione deve essere in formato CSV (colonne separate da ';'):~n~r" &
					+"~n~r" &
					+"la prima riga: 'nome lotto' + ';' + 'data in formato anno-mese-giorno' + ';' + 'note lotto in stampa su Attestato' ~n~r" &
					+"~n~r" &
					+"le righe successive: 'coefficiente con 2 decimali' + ';' + 'dose con 2 decimali' + ';' ~n~r" &
					+"~n~r ESEMPIO:" &
					+"~n~r nome_Lotto;2007-07-25;Red Perspex 4034 Lotto: KK   " &
					+"~n~r 0.70;5.00; " &
					+"~n~r 0.71;5.10; " &
					+"~n~r 0.72;5.20; " &
					+"~n~r 0.73;5.20; " &
					+"~n~r 0.74;5.30; " &
					+"~n~r ....... " &
					+"~n~r" &
				   + "Proseguire con la scelta e l'analisi del file" &
					,Information!, yesno!, 1 &
				 )


	if k_rcn = 1 then

		kuf1_dosimetrie = create kuf_ausiliari
	
	
		kst_esito = kuf1_dosimetrie.tb_dosimetrie_importa_nuovo_csv(true)
		
		if kst_esito.esito <> kkg_esito.NO_ESECUZIONE then
		
			if kst_esito.esito <> kkg_esito.ok then 
				messagebox("Verifica Terminata con Errore", &
						  + trim(kst_esito.SQLErrText)+ "~n~r" &
						  , stopsign! &
						 )
			else
				k_rcn = messagebox("Verifica Terminata correttamente", &
						  + trim(kst_esito.SQLErrText)+ "~n~r" &
							+ "Proseguire con l'importazione definitiva del file" &
						,Information!, yesno!, 1 &
						 )
				if k_rcn = 1 then
		
					kst_esito = kuf1_dosimetrie.tb_dosimetrie_importa_nuovo_csv(false)
					
					if kst_esito.esito <> kkg_esito.ok then 
						messagebox("Importazione Terminata con Errore", &
									  "~n~r" &
									  + trim(kst_esito.SQLErrText)+ "~n~r" &
									  , stopsign! &
									 )
					else
						k_rcn = messagebox("Importazione Terminata correttamente", &
									  "~n~r" &
									  + trim(kst_esito.SQLErrText)+ "~n~r" &
									,Information!, ok!, 1 &
									 )
						try			 
							tab_1.tabpage_2.dw_2.reset( )
							inizializza_1()
						catch (uo_exception kuo_exception)
						end try
					end if				
				end if
			end if
		end if
	
		destroy kuf1_dosimetrie
	end if
	

	


end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
kuf_utility kuf1_utility
	

	u_retrieve("d_banche_l_1")
		
//--- Inabilita campi alla modifica se Vsualizzazione
  	kuf1_utility = create kuf_utility 
 	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(kidw_selezionata.ki_flag_modalita) = KKG_FLAG_RICHIESTA.modifica then
	   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility

	attiva_tasti()

return "0"
	



end function

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
kuf_utility kuf1_utility

	
   if trim(kidw_selezionata.ki_flag_modalita) <> kkg_flag_modalita.inserimento then

		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
			k_key = integer(trim(ki_st_open_w.key2))
	
			if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione then
				if tab_1.tabpage_2.dw_2.dataobject <> "d_dosimetrie_l_tree" then
					tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l_tree"
					tab_1.tabpage_2.dw_2.settransobject( sqlca )
				end if
			else
				if tab_1.tabpage_2.dw_2.dataobject <> "d_dosimetrie_l_upd_rid" then
					tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l_upd_rid"
					tab_1.tabpage_2.dw_2.settransobject( sqlca )
				end if
			end if

			if tab_1.tabpage_2.dw_2.retrieve(k_key) <= 0 then
	
				messagebox("Operazione fallita", &
					"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
					"(Dato ricercato :" + string(k_key) + ")~n~r" )
	
				if tab_1.tabpage_2.dw_2.dataobject <> "d_dosimetrie_l" then
					tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l"
					tab_1.tabpage_2.dw_2.settransobject( sqlca )
				end if
				kidw_selezionata.ki_flag_modalita = kkg_flag_modalita.inserimento
				for k_ctr = 1 to 10
					inserisci()
				end for
				tab_1.tabpage_2.dw_2.setrow(1)
			else
				tab_1.tabpage_2.dw_2.GroupCalc()				
			end if
		end if
	else
		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
			tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l"
			tab_1.tabpage_2.dw_2.settransobject( sqlca )
		end if
		inserisci()
	end if

	tab_1.tabpage_2.dw_2.setfocus()

		
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
 	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)
     	kuf1_utility.u_proteggi_dw("1", "lotto_dosim", tab_1.tabpage_2.dw_2)
     	kuf1_utility.u_proteggi_dw("1", "data", tab_1.tabpage_2.dw_2)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
     	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)
     	kuf1_utility.u_proteggi_dw("0", "lotto_dosim", tab_1.tabpage_2.dw_2)
     	kuf1_utility.u_proteggi_dw("0", "data", tab_1.tabpage_2.dw_2)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.modifica then
//   	   kuf1_utility.u_proteggi_dw("2", 1, tab_1.tabpage_1.dw_1)
	  		tab_1.tabpage_2.dw_2.setcolumn(2)
		end if

	end if
	destroy kuf1_utility

	attiva_tasti()


	





end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_clie_settori_l")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()


	





end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_clie_classi_l")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case LeftA(k_par_in, 2) 

	case "l1"		//Estrazione...
		dosimetrie_importa_file_csv()

	case "l2"		//Dosimetria Attiva/Disattiva 
		dosimetrie_cambia_stato()
		
	case else
		super::smista_funz(k_par_in)

end choose

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
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 1)) &  
		   or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 1))) <= 0 then
			tab_1.tabpage_1.dw_1.deleterow(k_ctr)
		end if
	end if
next

//k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		if isnull(tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, 1)) &  
//		   or tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, 1) <= 0 then
//			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
//		end if
//	end if
//next
//

k_riga = tab_1.tabpage_3.dw_3.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_3.dw_3.getitemstring(k_ctr, 1)) &  
		   or len(trim(tab_1.tabpage_3.dw_3.getitemstring(k_ctr, 1))) <= 0 then
			tab_1.tabpage_3.dw_3.deleterow(k_ctr)
		end if
	end if
	
next

k_riga = tab_1.tabpage_4.dw_4.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_4.dw_4.getitemstring(k_ctr, 1)) &  
		   or len(trim(tab_1.tabpage_4.dw_4.getitemstring(k_ctr, 1))) <= 0 then
			tab_1.tabpage_4.dw_4.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_5.dw_5.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_5.dw_5.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_5.dw_5.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 1)) &  
				or len(trim(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 1))) <= 0 &
				or isnull(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 2)) &  
				or len(trim(tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_5.dw_5.deleterow(k_ctr)
		end if
	end if
next
	
k_riga = tab_1.tabpage_6.dw_6.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_6.dw_6.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_6.dw_6.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 1)) &  
				or len(trim(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 1))) <= 0 &
				or isnull(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 2)) &  
				or len(trim(tab_1.tabpage_6.dw_6.getitemstring(k_ctr, 2))) <= 0 then
			tab_1.tabpage_6.dw_6.deleterow(k_ctr)
		end if
	end if
next
	
//--- Tempi Impianto
k_riga = tab_1.tabpage_7.dw_7.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_7.dw_7.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_7.dw_7.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_7.dw_7.getitemnumber(k_ctr, "tminute")) &  
				or tab_1.tabpage_7.dw_7.getitemnumber(k_ctr, "tminute") <= 0 &
				or isnull(tab_1.tabpage_7.dw_7.getitemnumber(k_ctr, "fila_1_tcoeff")) &  
				or tab_1.tabpage_7.dw_7.getitemnumber(k_ctr, "fila_1_tcoeff") <= 0 then
			tab_1.tabpage_7.dw_7.deleterow(k_ctr)
		end if
	end if
next
	
//--- Posizione Dosimetro
k_riga = tab_1.tabpage_8.dw_8.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_8.dw_8.getitemstatus(k_ctr, 0, primary!) = newmodified! & 
				or tab_1.tabpage_8.dw_8.getitemstatus(k_ctr, 0, primary!) = new! then 
		if isnull(tab_1.tabpage_8.dw_8.getitemstring(k_ctr, "codice")) &  
				or trim(tab_1.tabpage_8.dw_8.getitemstring(k_ctr, "codice")) = "" then
			tab_1.tabpage_8.dw_8.deleterow(k_ctr)
		end if
	end if
next


end subroutine

private subroutine dosimetrie_cambia_stato ();//
//--- importa da file csv i valori dosimetrici
//
integer k_rcn
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie
kuf_ausiliari kuf1_dosimetrie




if tab_1.tabpage_2.dw_2.getrow () > 0 then
	
	kst_tab_dosimetrie.lotto_dosim = trim(tab_1.tabpage_2.dw_2.getitemstring( tab_1.tabpage_2.dw_2.getrow() , "lotto_dosim"))
	
	if len(trim(kst_tab_dosimetrie.lotto_dosim)) > 0 then

		k_rcn=messagebox("Cambio dello stato del Lotto Dosimetrico", &
						"L'operazione converte lo stato attuale (da Attivo a Disattivo e viceversa):~n~r" &
						+"~n~r" &
						+"Il Lotto coinvolto è: " + trim(kst_tab_dosimetrie.lotto_dosim) + " -  Procedere con l'aggiornamento? " &
						+"~n~r" &
						,Question!, yesno!, 2 &
					 )
		
		
		if k_rcn = 1 then
		
			kuf1_dosimetrie = create kuf_ausiliari
			kst_esito = kuf1_dosimetrie.tb_dosimetrie_get_attivo(kst_tab_dosimetrie)
			
			if kst_esito.esito = kkg_esito.ok then
				
				if kst_tab_dosimetrie.attivo = kuf1_dosimetrie.kki_dosimetrie_disattivo then
					kst_tab_dosimetrie.attivo = kuf1_dosimetrie.kki_dosimetrie_attivo
				else
					kst_tab_dosimetrie.attivo = kuf1_dosimetrie.kki_dosimetrie_disattivo
				end if
				kst_esito = kuf1_dosimetrie.tb_dosimetrie_attivadisattiva(kst_tab_dosimetrie)
				
				if kst_esito.esito <> kkg_esito.ok then 
					messagebox("Operazione in errore", &
							   trim(kst_esito.SQLErrText)+ "~n~r" &
							  , stopsign! &
							 )
				else
					
					inizializza_lista() //rilegge il DW
					
					k_rcn = messagebox("Operazione Terminata correttamente", &
								"Lo stato del Lotto è stato aggiornato. Lotto " + trim(kst_tab_dosimetrie.lotto_dosim )  &
							,Information!, OK!, 1 &
							 )
				end if
				
			else
				messagebox("Operazione Terminata con Errore", &
								  "Lettura Lotto Dosimetrico: "+ trim(kst_tab_dosimetrie.lotto_dosim ) + "~n~r" &
								  + trim(kst_esito.SQLErrText)+ "~n~r" &
								  , stopsign! &
								 )
			end if
			
			destroy kuf1_dosimetrie
			
	
		else
			k_rcn = messagebox("Operazione annullata", &
						+ "Operazione annullata dall'utente "  &
					,Information!, OK!, 1 &
					 )
		end if
	else
		k_rcn = messagebox("Operazione non eseguita", &
						+ "Selezionare almeno un Lotto dall'elenco "  &
					,Information!, OK!, 1 &
					 )
	end if
end if
	

	


end subroutine

protected subroutine inizializza_4 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_listino_voci_categ_l")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()


	





end subroutine

protected subroutine inizializza_5 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_sr_settori_l")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()


	





end subroutine

protected subroutine inizializza_6 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_imptime")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()


	





end subroutine

protected subroutine inizializza_7 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
kuf_utility kuf1_utility

	
	u_retrieve("d_dosimpos_l")
		
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.visualizzazione or trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_modalita.cancellazione then
	
     	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, kidw_selezionata)

////--- Inabilita campo cliente per la modifica se Funzione MODIFICA
//	   if trim(kidw_selezionata.ki_flag_modalita) = kkg_flag_richiesta.modifica then
//   		kuf1_utility.u_proteggi_dw("1", 1, kidw_selezionata)
//		end if

	end if
	if isvalid(kuf1_utility) then destroy kuf1_utility

	kidw_selezionata.setfocus()

	attiva_tasti()


	





end subroutine

protected subroutine open_start_window ();//
super::open_start_window( )

//
tab_1.tabpage_8.picturename = "Barcode.ico"

end subroutine

protected subroutine riempi_id ();//
//=== 
long k_riga

choose case tab_1.selectedtab 

	case 2 
		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)
		loop

	case 3
		k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_3.dw_3.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_3.dw_3.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_3.dw_3.getnextmodified(k_riga, primary!)
		loop

	case 4
		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)
		loop

	case 5
		k_riga = tab_1.tabpage_5.dw_5.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_5.dw_5.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_5.dw_5.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_5.dw_5.getnextmodified(k_riga, primary!)
		loop

	case 7
		k_riga = tab_1.tabpage_7.dw_7.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_7.dw_7.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_7.dw_7.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_7.dw_7.getnextmodified(k_riga, primary!)
		loop

	case 8
		k_riga = tab_1.tabpage_8.dw_8.getnextmodified(0, primary!)
		do while k_riga > 0  
			tab_1.tabpage_8.dw_8.setitem(k_riga, "posxcm", 0)
			tab_1.tabpage_8.dw_8.setitem(k_riga, "posycm", 0)
			tab_1.tabpage_8.dw_8.setitem(k_riga, "poszcm", 0)
			tab_1.tabpage_8.dw_8.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			tab_1.tabpage_8.dw_8.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			k_riga = tab_1.tabpage_8.dw_8.getnextmodified(k_riga, primary!)
		loop
		
end choose

end subroutine

public function integer u_get_col_iniziale ();//
//
return 1

//	choose case tab_1.selectedtab 
//		case 6
//			return 2
//		case else
//			return 1
//	end choose	


end function

on w_ausiliari_1.create
call super::create
end on

on w_ausiliari_1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_ausiliari`st_ritorna within w_ausiliari_1
end type

type st_ordina_lista from w_ausiliari`st_ordina_lista within w_ausiliari_1
end type

type st_aggiorna_lista from w_ausiliari`st_aggiorna_lista within w_ausiliari_1
end type

type cb_ritorna from w_ausiliari`cb_ritorna within w_ausiliari_1
end type

type st_stampa from w_ausiliari`st_stampa within w_ausiliari_1
end type

type cb_visualizza from w_ausiliari`cb_visualizza within w_ausiliari_1
end type

type cb_modifica from w_ausiliari`cb_modifica within w_ausiliari_1
end type

type cb_aggiorna from w_ausiliari`cb_aggiorna within w_ausiliari_1
end type

type cb_cancella from w_ausiliari`cb_cancella within w_ausiliari_1
end type

type cb_inserisci from w_ausiliari`cb_inserisci within w_ausiliari_1
end type

type tab_1 from w_ausiliari`tab_1 within w_ausiliari_1
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

type tabpage_1 from w_ausiliari`tabpage_1 within tab_1
integer x = 882
integer width = 933
string text = "Banche"
string picturename = "Custom048!"
end type

type dw_1 from w_ausiliari`dw_1 within tabpage_1
integer x = 23
integer y = 56
string dataobject = "d_banche_l_1"
end type

event dw_1::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_1_retrieve from w_ausiliari`st_1_retrieve within tabpage_1
end type

type st_orizzontal_11 from w_ausiliari`st_orizzontal_11 within tabpage_1
end type

type dw_11 from w_ausiliari`dw_11 within tabpage_1
end type

type tabpage_2 from w_ausiliari`tabpage_2 within tab_1
integer x = 882
integer width = 933
string text = "Lotti Dosimetrici"
string picturename = "Custom093!"
end type

type dw_2 from w_ausiliari`dw_2 within tabpage_2
string dataobject = "d_dosimetrie_l_tree"
end type

event dw_2::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_2_retrieve from w_ausiliari`st_2_retrieve within tabpage_2
end type

type st_orizzontal_12 from w_ausiliari`st_orizzontal_12 within tabpage_2
end type

type dw_12 from w_ausiliari`dw_12 within tabpage_2
end type

type tabpage_3 from w_ausiliari`tabpage_3 within tab_1
integer x = 882
integer width = 933
string text = "Settori Merceologici"
string picturename = "Custom091!"
end type

type dw_3 from w_ausiliari`dw_3 within tabpage_3
string dataobject = "d_clie_settori_l"
end type

event dw_3::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_3_retrieve from w_ausiliari`st_3_retrieve within tabpage_3
end type

type st_orizzontal_13 from w_ausiliari`st_orizzontal_13 within tabpage_3
end type

type dw_13 from w_ausiliari`dw_13 within tabpage_3
end type

type tabpage_4 from w_ausiliari`tabpage_4 within tab_1
integer x = 882
integer width = 933
string text = "Classi Clienti"
string picturename = "Custom067!"
end type

type dw_4 from w_ausiliari`dw_4 within tabpage_4
string dataobject = "d_clie_classi_l"
end type

event dw_4::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_4_retrieve from w_ausiliari`st_4_retrieve within tabpage_4
end type

type st_orizzontal_14 from w_ausiliari`st_orizzontal_14 within tabpage_4
end type

type dw_14 from w_ausiliari`dw_14 within tabpage_4
end type

type tabpage_5 from w_ausiliari`tabpage_5 within tab_1
integer x = 882
integer width = 933
string text = "Categoria Voce listino"
string picturename = "FormatDollar!"
end type

type dw_5 from w_ausiliari`dw_5 within tabpage_5
string dataobject = "d_listino_voci_categ_l"
end type

event dw_5::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_5_retrieve from w_ausiliari`st_5_retrieve within tabpage_5
end type

type st_orizzontal_15 from w_ausiliari`st_orizzontal_15 within tabpage_5
end type

type dw_15 from w_ausiliari`dw_15 within tabpage_5
end type

type tabpage_6 from w_ausiliari`tabpage_6 within tab_1
integer x = 882
integer width = 933
string text = "Settori Dipartimentali"
string picturename = "Tile!"
end type

type st_6_retrieve from w_ausiliari`st_6_retrieve within tabpage_6
end type

type dw_6 from w_ausiliari`dw_6 within tabpage_6
integer x = 9
integer y = 12
string dataobject = "d_sr_settori_l"
end type

event dw_6::doubleclicked;//
//--- evito evento  doppio click
//
end event

type st_orizzontal_16 from w_ausiliari`st_orizzontal_16 within tabpage_6
end type

type dw_16 from w_ausiliari`dw_16 within tabpage_6
end type

type tabpage_7 from w_ausiliari`tabpage_7 within tab_1
integer x = 882
integer width = 933
string text = "Tempi Impianto"
string picturename = "UnionReturn!"
end type

type st_7_retrieve from w_ausiliari`st_7_retrieve within tabpage_7
end type

type dw_7 from w_ausiliari`dw_7 within tabpage_7
string dataobject = "d_imptime"
end type

type st_orizzontal_17 from w_ausiliari`st_orizzontal_17 within tabpage_7
end type

type dw_17 from w_ausiliari`dw_17 within tabpage_7
end type

type tabpage_8 from w_ausiliari`tabpage_8 within tab_1
integer x = 882
integer width = 933
string text = "Posizioni Dosimetro"
string picturename = "C:\testGammarad\pb_sterigenics\icone\Barcode.ICO"
end type

type st_8_retrieve from w_ausiliari`st_8_retrieve within tabpage_8
end type

type dw_8 from w_ausiliari`dw_8 within tabpage_8
string dataobject = "d_dosimpos_l"
end type

type st_orizzontal_18 from w_ausiliari`st_orizzontal_18 within tabpage_8
integer width = 919
end type

type dw_18 from w_ausiliari`dw_18 within tabpage_8
end type

type tabpage_9 from w_ausiliari`tabpage_9 within tab_1
boolean visible = false
integer x = 882
integer width = 933
boolean enabled = false
string text = ""
end type

type st_9_retrieve from w_ausiliari`st_9_retrieve within tabpage_9
end type

type dw_9 from w_ausiliari`dw_9 within tabpage_9
boolean enabled = false
string dataobject = "d_nulla"
end type

type st_orizzontal_19 from w_ausiliari`st_orizzontal_19 within tabpage_9
end type

type dw_19 from w_ausiliari`dw_19 within tabpage_9
end type

