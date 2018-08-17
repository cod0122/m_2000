$PBExportHeader$w_ausiliari_1old.srw
forward
global type w_ausiliari_1old from w_g_tab_3
end type
end forward

global type w_ausiliari_1old from w_g_tab_3
integer width = 2286
integer height = 1136
string title = "Tabelle Ausiliarie 2"
boolean ki_fai_nuovo_dopo_update = false
boolean ki_attiva_tasti_vmi = true
end type
global w_ausiliari_1old w_ausiliari_1old

forward prototypes
protected subroutine pulizia_righe ()
protected function integer check_key (integer k_riga, string k_colonna, string k_key, ref datawindow k_dw)
protected subroutine inizializza_2 ()
protected subroutine inizializza_3 ()
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function string check_dati ()
protected function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine dosimetrie_importa_file_csv ()
protected function integer inserisci ()
protected subroutine open_start_window ()
end prototypes

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


end subroutine

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

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
kuf_utility kuf1_utility

	
   if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then

		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	
			if tab_1.tabpage_3.dw_3.retrieve() <= 0 then
	
				messagebox("Operazione fallita", &
					"Nessun dato presente in archivio ~n~r" + &
					+ "~n~r" )
	
				inserisci()
				
			end if
		end if
	else
		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
			inserisci()
//		else
//			tab_1.tabpage_3.dw_3.visible
		end if
	end if

	tab_1.tabpage_3.dw_3.setfocus()


		
		
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
 	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_3.dw_3)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_3.dw_3)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_richiesta_modifica then
   	   		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_3.dw_3)
		end if

	end if
	destroy kuf1_utility



	attiva_tasti()


	





end subroutine

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_rc, k_ctr
kuf_utility kuf1_utility

	
   if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then

		if tab_1.tabpage_4.dw_4.rowcount() = 0 then
	
			if tab_1.tabpage_4.dw_4.retrieve() <= 0 then
	
				messagebox("Operazione fallita", &
					"Nessun dato presente in archivio ~n~r" + &
					+ "~n~r" )
	
				inserisci()
				
			end if
		end if
	else
		if tab_1.tabpage_4.dw_4.rowcount() = 0 then
			inserisci()
//		else
//			tab_1.tabpage_4.dw_4.visible
		end if
	end if

	tab_1.tabpage_4.dw_4.setfocus()


		
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
 	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_4.dw_4)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      	kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_4.dw_4)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_richiesta_modifica then
   	   		kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_4.dw_4)
		end if

	end if
	destroy kuf1_utility


	attiva_tasti()


	





end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc, k_ctr
kuf_utility kuf1_utility
datawindowchild kdwc_dw1
	

	tab_1.tabpage_2.dw_2.getchild ("id_padre", kdwc_dw1) 
   if kdwc_dw1.rowcount() = 0 then
		kdwc_dw1.settransobject (SQLCA)
	end if
	kdwc_dw1.retrieve()
	
   if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then

		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
			k_key = integer(trim(ki_st_open_w.key2))
	
			if tab_1.tabpage_2.dw_2.retrieve(k_key) <= 0 then
	
				messagebox("Operazione fallita", &
					"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
					"(Dato ricercato :" + string(k_key) + ")~n~r" )
	
				tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l"
				tab_1.tabpage_2.dw_2.settransobject( sqlca )
				inserisci()
				
			end if
		end if
	else
		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
			tab_1.tabpage_2.dw_2.dataobject = "d_dosimetrie_l"
			tab_1.tabpage_2.dw_2.settransobject( sqlca )
			inserisci()
//		else
//			tab_1.tabpage_2.dw_2.visible
		end if
	end if

	tab_1.tabpage_2.dw_2.setfocus()


		
//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
 	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_2.dw_2)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_2.dw_2)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_modifica then
//   	   kuf1_utility.u_proteggi_dw("2", 1, tab_1.tabpage_1.dw_1)
	  		tab_1.tabpage_2.dw_2.setcolumn(2)
		end if

	end if
	destroy kuf1_utility



	attiva_tasti()


	





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
		k_record = " Lotti Dosimetrici "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			kst_tab_dosimetrie.id = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id")
			kst_tab_dosimetrie.dose = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "dose")
			k_key = string(kst_tab_dosimetrie.id)
		end if
	case 3
		k_record = " Settore "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 4
		k_record = " Classe "
		k_riga = tab_1.tabpage_3.dw_3.getrow()	
		if k_riga > 0 then
			k_key_1 = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 1)
			k_desc = tab_1.tabpage_3.dw_3.getitemstring(k_riga, 2)
			k_key = k_key_1
		end if
	case 5
//		k_record = " Causale di sped. "
//		k_riga = tab_1.tabpage_5.dw_5.getrow()	
//		if k_riga > 0 then
//			k_key = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 1)
//			k_desc = tab_1.tabpage_5.dw_5.getitemstring(k_riga, 2)
//		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and (isnull(k_key) = false or isnull(k_key_1) = false) then

	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "Codice" + k_record + "senza Descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, &
		"Sei sicuro di voler eliminare " + k_record + "~n~r" + &
		k_key + " " + trim(k_desc),  &
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
//			case 5
//				k_errore = kuf1_ausiliari.tb_delete_causali(k_key) 
		end choose	
		if trim(kst_esito.esito) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else
				
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
				end choose	

			end if

		else
			k_return = 1
			k_errore = kuf1_data_base.db_rollback()

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
			if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 2)) &
				or ((tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, 2))) = 0 then
				k_return = k_return + tab_1.tabpage_2.text + ": Impostare la Dose " + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		if k_errore = "0" and k_riga <= k_nr_righe  then
			
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
					k_errore = "3"
					k_nr_errori++
				else
					if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
						k_dose = double(k_keyn)
						select lotto_dosim
							into :k_lotto_dosim
							from dosimetrie
							where lotto_dosim = :k_key and dose = :k_dose;
						if sqlca.sqlcode = 0 then
							k_return = tab_1.tabpage_2.text + ": Lotto dosimetrico gia' in archivio " + "~n~r" 
							k_return = k_return + "(Lotto " + trim(k_key) + " Dose " + trim(k_keyn) + ") ~n~r"
							k_errore = "3"
							k_nr_errori++
						end if
					end if
				end if
			end if
		end if
		if isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "id")) then
		   tab_1.tabpage_2.dw_2.setitem ( k_riga, "id", 0)
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

		tab_1.tabpage_2.dw_2.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
		tab_1.tabpage_2.dw_2.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		
		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
	k_riga = tab_1.tabpage_3.dw_3.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		tab_1.tabpage_3.dw_3.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
		tab_1.tabpage_3.dw_3.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		
		k_riga = tab_1.tabpage_3.dw_3.getnextmodified(k_riga, primary!)

	loop

//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		tab_1.tabpage_4.dw_4.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
		tab_1.tabpage_4.dw_4.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		
		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)

	loop

//
//=== Controllo altro tab
//ecc...





return k_errore + k_return


end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
integer k_key, k_rc
kuf_utility kuf1_utility
	

   if trim(ki_st_open_w.flag_modalita) <> kkg_flag_modalita_inserimento then

		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
			k_key = integer(trim(ki_st_open_w.key1))
	
			if tab_1.tabpage_1.dw_1.retrieve(k_key) <= 0 then
	
				messagebox("Operazione fallita", &
					"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
					"(Dato ricercato :" + string(k_key) + ")~n~r" )
	
				inserisci()
				
			end if
		end if
	else
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			inserisci()
		end if
	end if

	tab_1.tabpage_1.dw_1.setfocus()


		
//--- Inabilita campi alla modifica se Vsualizzazione
   	kuf1_utility = create kuf_utility 
 	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_visualizzazione or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_cancellazione then
	
      	kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_richiesta_modifica then
	   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
		end if

	end if
	destroy kuf1_utility

	attiva_tasti()

return "0"
	



end function

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//

//=== 

	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Importa Lotto Dosimetrico da file CSV"
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
	"Importa da file esterno in formato CSV (colonne separate dal ';') i valori dosimetrici    "
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	choose case tab_1.selectedtab 
		case 2 
		   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita_inserimento then
				kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
			else
				kG_menu.m_strumenti.m_fin_gest_libero1.enabled = false
			end if
		case else
			kG_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	end choose
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Importa,"+kG_menu.m_strumenti.m_fin_gest_libero1.text
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Insert!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

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

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

private subroutine dosimetrie_importa_file_csv ();//
//--- importa da file csv i valori dosimetrici
//
integer k_rcn
st_esito kst_esito
kuf_ausiliari kuf1_dosimetrie


	k_rcn=messagebox("Operazione di Importazione nuovo Lotto Dosimetrico", &
					"Il file di importazione deve essere in formato CSV (colonne separate da ';'):~n~r" &
					+"~n~r" &
					+"la prima riga: 'nome lotto' + ';' + 'data' in formato anno-mese-giorno  ~n~r" &
					+"~n~r" &
					+"le righe successive: 'coefficiente con 2 decimali' + ';' + 'dose con 2 decimali' + ';' ~n~r" &
					+"~n~r ESEMPIO:" &
					+"~n~r nome_Lotto;2007-07-25 " &
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
		
		if kst_esito.esito <> KKG_ESITO_NO_ESECUZIONE then
		
			if kst_esito.esito <> kkg_esito_ok then 
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
					
					if kst_esito.esito <> kkg_esito_ok then 
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
					end if				
				end if
			end if
		end if
	
		destroy kuf1_dosimetrie
	end if
	

	


end subroutine

protected function integer inserisci ();//
int k_return=1
string k_errore="0 "
long k_ctr, k_riga
datawindow kdw_x



//=== Imposta tasti
	attiva_tasti()

	
//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			kdw_x = tab_1.tabpage_1.dw_1
		case 2
			kdw_x = tab_1.tabpage_2.dw_2
		case 3
			kdw_x = tab_1.tabpage_3.dw_3
		case 4
			kdw_x = tab_1.tabpage_4.dw_4
		case 5
			kdw_x = tab_1.tabpage_5.dw_5
		case 6
			kdw_x = tab_1.tabpage_6.dw_6
	end choose	

//	tab_1.tabpage_1.dw_1.reset()
	k_riga = kdw_x.insertrow(0)
	for k_ctr = 1 to 20 
		kdw_x.insertrow(0)
	end for
	kdw_x.scrolltorow(k_riga)
	kdw_x.setrow(k_riga)
	kdw_x.setcolumn(1)

	k_return = 0

return (k_return)
end function

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true

end subroutine

on w_ausiliari_1old.create
call super::create
end on

on w_ausiliari_1old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_ausiliari_1old
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_ausiliari_1old
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_ausiliari_1old
end type

type st_stampa from w_g_tab_3`st_stampa within w_ausiliari_1old
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_ausiliari_1old
end type

type dw_trova from w_g_tab_3`dw_trova within w_ausiliari_1old
end type

type dw_filtra from w_g_tab_3`dw_filtra within w_ausiliari_1old
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_ausiliari_1old
integer x = 1787
integer y = 1136
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_ausiliari_1old
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_ausiliari_1old
boolean enabled = true
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_ausiliari_1old
integer y = 1220
boolean enabled = true
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_ausiliari_1old
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()

//
//k_errore = left(dati_modif(), 1)
//
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if k_errore = "1" then //Fare gli aggiornamenti
//
////=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
////===	              : 2=Errore Non grave dati aggiornati
////===               : 3=
//	k_errore = aggiorna_dati()		
//
//else
//
//	if k_errore = "2" then //Aggiornamento non richiesto
//		k_errore = "0"
//	end if
//
//end if

if LeftA(k_errore, 1) = "0" then 
	inserisci()
end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_ausiliari_1old
boolean visible = true
integer x = 18
integer y = 16
integer width = 2185
boolean fixedwidth = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
string text = "Banche"
string picturename = "Custom048!"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 5
integer width = 2107
string dataobject = "d_banche_l"
end type

event itemchanged;//
//--- Impossibile modificare un codice già in archivio
//
//if dwo.name = "codice" then
//	return check_key(row, dwo.name, data, tab_1.tabpage_1.dw_1) 
//end if
//
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
string text = "Lotti Dosimetrici"
string picturename = "Custom093!"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 5
integer width = 2089
boolean enabled = true
string dataobject = "d_dosimetrie_l_tree"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
string text = "Settori Merceologici"
string picturename = "Custom091!"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer width = 1591
integer height = 904
boolean enabled = true
string dataobject = "d_clie_settori_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
string text = "Classi Clienti"
string picturename = "Custom067!"
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 18
integer y = 16
integer width = 1577
integer height = 928
boolean enabled = true
string dataobject = "d_clie_classi_l"
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
boolean enabled = false
string text = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer x = 5
integer y = 24
integer width = 1582
integer height = 884
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer x = 741
integer y = 16
integer width = 1426
integer height = 1112
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

