$PBExportHeader$w_sr_settori_profili.srw
forward
global type w_sr_settori_profili from w_g_tab_3
end type
end forward

global type w_sr_settori_profili from w_g_tab_3
integer width = 2130
integer height = 1440
string title = "Settori"
long backcolor = 67108864
boolean ki_toolbar_window_presente = true
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_exit_dopo_update = true
boolean ki_msg_dopo_update = false
boolean ki_esci_dopo_cancella = true
end type
global w_sr_settori_profili w_sr_settori_profili

type variables

end variables

forward prototypes
protected subroutine pulizia_righe ()
protected subroutine riempi_id ()
protected subroutine inizializza_1 ()
protected function integer cancella ()
protected function string inizializza ()
public function string check_dati ()
protected subroutine open_start_window ()
protected subroutine inizializza_2 () throws uo_exception
protected subroutine attiva_tasti_0 ()
end prototypes

protected subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


tab_1.tabpage_1.dw_1.accepttext()

//
//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "sr_settore"))  > " " then
			else	
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
				
			end if
		end if
		
	next

end subroutine

protected subroutine riempi_id ();//
long k_riga
kuf_sr_sicurezza kuf1_sr_sicurezza
	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	if k_riga > 0 then

//=== Se sono in inser azzero il ID  
		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then
			if tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sr_settore_profilo") > 0 then
			else
				tab_1.tabpage_1.dw_1.setitem(k_riga, "id_sr_settore_profilo", 0)
			end if
		end if
		
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "permessi")) then
			tab_1.tabpage_1.dw_1.setitem(k_riga, "permessi", kuf1_sr_sicurezza.ki_permessi_scrittura )
		end if
		
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
		
	end if

	

end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
string k_key
	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_2.st_2_retrieve.text) then
	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.text
else
	k_codice_prec = " "
end if

k_key = tab_1.tabpage_1.dw_1.object.sr_settore[tab_1.tabpage_1.dw_1.getrow()]
k_codice_attuale = trim(k_key)

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_2.st_2_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_2.dw_2.retrieve(k_key)  

end if				
				

attiva_tasti()
if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	tab_1.tabpage_2.dw_2.insertrow(0) 
end if


tab_1.tabpage_2.dw_2.setfocus()
	

end subroutine

protected function integer cancella ();//
//=== Cancellazione record dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_record, k_record_1, k_key, k_testo
string k_errore = "0 " 
long k_riga
kuf_sr_sicurezza  kuf1_sr_sicurezza
st_esito kst_esito
st_tab_sr_settori_profili kst_tab_sr_settori_profili



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " " + trim(tab_1.tabpage_1.text) + " "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				kst_tab_sr_settori_profili.id_sr_settore_profilo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sr_settore_profilo")
				kst_tab_sr_settori_profili.sr_settore = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "sr_settore")
				kst_tab_sr_settori_profili.id_sr_profilo = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_sr_profilo")
				if isnull(kst_tab_sr_settori_profili.sr_settore) = true or trim(kst_tab_sr_settori_profili.sr_settore) = "" then
					
					k_testo = trim(tab_1.tabpage_1.dw_1.object.sr_settore_t.text)
					kst_tab_sr_settori_profili.sr_settore = "senza " + k_testo
					
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare " + trim(tab_1.tabpage_1.text) + "~n~r" &
					   + "Settore :" + trim(kst_tab_sr_settori_profili.sr_settore) + " profilo: " + string(kst_tab_sr_settori_profili.id_sr_profilo) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		k_key = trim(string(kst_tab_sr_settori_profili.id_sr_settore_profilo))
end choose	



//=== Se righe in lista
if k_riga > 0 and LenA(trim(k_key)) > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_sr_sicurezza = create kuf_sr_sicurezza
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				kst_esito = kuf1_sr_sicurezza.tb_delete_sr_settori_profili(kst_tab_sr_settori_profili) 
		end choose	
		if kst_esito.esito = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
				end choose	

			end if

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
		destroy kuf1_sr_sicurezza

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
end choose	


return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string  k_key
string k_fine_ciclo=""
int k_ctr=0, k_errore = 0
int k_err_ins, k_rc
//datawindowchild kdwc_dw1
kuf_utility kuf1_utility


//=== 
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_key = trim(ki_st_open_w.key1)

//	tab_1.tabpage_1.dw_1.getchild("id_programma", kdwc_dw1)
//	kdwc_dw1.settransobject(sqlca)
//	kdwc_dw1.insertrow(0)


	if LenA(k_key) = 0 or not isnumber(k_key) then
		
		cb_inserisci.postevent(clicked!)
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(long(k_key)) 
		
		choose case k_rc

			case is < 0				
				k_errore = 1
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice ricercato:" + trim(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)
				

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta <> "in" then
					k_errore = 1
					messagebox("Ricerca fallita", &
						"Mi spiace ma il dato non e' in Archivio ~n~r" + &
						"(Codice Cercato:" + trim(k_key) + ")~n~r" )

					cb_ritorna.postevent(clicked!)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
				
			case is > 0		
				if k_scelta = "in" then
					cb_inserisci.postevent(clicked!)
				end if

				tab_1.tabpage_1.dw_1.setfocus()
				tab_1.tabpage_1.dw_1.setcolumn(1)
				
				attiva_tasti()
		
		end choose

	end if

//	kdwc_dw1.retrieve()

else
	attiva_tasti()
end if


//===
//--- inabilito le modifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = "vi" &
	   or trim(ki_st_open_w.flag_modalita) = "ca" then
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		kuf1_utility.u_proteggi_dw("1", "sr_settore", tab_1.tabpage_1.dw_1)

	else		
		
//--- S-protezione campi per riabilitare la modifica 
      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)

	end if
	destroy kuf1_utility
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = "ca" then

		cb_cancella.postevent (clicked!)
		
	end if
end if


return "0"

end function

public function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
string k_errore = "0"
long k_num
string k_str, k_testo
long k_nr_righe
int k_riga
int k_nr_errori


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_str = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "sr_settore") 
	if isnull(k_str) or LenA(trim(k_str)) = 0 then
		k_testo = trim(tab_1.tabpage_1.dw_1.object.sr_settore_t.text)
		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if

	k_num = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_sr_profilo") 
	if k_num > 0 then
	else
		k_testo = trim(tab_1.tabpage_1.dw_1.object.id_sr_profilo_t.text)
		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if

	k_str = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "descr") 
	if isnull(k_str) or LenA(trim(k_str)) = 0 then
		k_testo = trim(tab_1.tabpage_1.dw_1.object.descr_t.text)
		k_return = tab_1.tabpage_1.text + ": Manca valore nel campo '" + k_testo + "'. " + "~n~r"
		k_errore = "3"
		k_nr_errori++
	end if



return k_errore + k_return


end function

protected subroutine open_start_window ();//
//kdspi_elenco_output = create datastore

ki_toolbar_window_presente=true

end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
int k_rc=0
double k_dose 
string k_codice_attuale, k_codice_prec
string k_key
	

//--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
if not isnull(tab_1.tabpage_3.st_3_retrieve.text) then
	k_codice_prec = tab_1.tabpage_3.st_3_retrieve.text
else
	k_codice_prec = " "
end if

k_key = tab_1.tabpage_1.dw_1.object.sr_settore[tab_1.tabpage_1.dw_1.getrow()]
k_codice_attuale = trim(k_key)

//=== Forza valore Codice composto per ricordarlo per le prossime richieste
tab_1.tabpage_3.st_3_retrieve.text = k_codice_attuale

if k_codice_attuale <> k_codice_prec then

	k_rc=tab_1.tabpage_3.dw_3.retrieve(k_key)  

end if				
				

attiva_tasti()
if tab_1.tabpage_3.dw_3.rowcount() = 0 then
	tab_1.tabpage_3.dw_3.insertrow(0) 
end if


tab_1.tabpage_3.dw_3.setfocus()
	

end subroutine

protected subroutine attiva_tasti_0 ();//
	super::attiva_tasti_0()

	cb_modifica.enabled = false

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	if tab_1.tabpage_1.dw_1.getrow() > 0 then
		if len(trim(tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "sr_settore"))) > 0 then
			tab_1.tabpage_2.enabled = true 
			tab_1.tabpage_3.enabled = true 
		end if
	end if

	if tab_1.selectedtab <> 1 then
		cb_aggiorna.enabled = false
		cb_visualizza.enabled = false
	end if



end subroutine

on w_sr_settori_profili.create
call super::create
end on

on w_sr_settori_profili.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_sr_settori_profili
integer x = 101
integer y = 1148
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_sr_settori_profili
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_sr_settori_profili
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_sr_settori_profili
end type

type st_stampa from w_g_tab_3`st_stampa within w_sr_settori_profili
integer x = 507
integer y = 1152
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_sr_settori_profili
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_sr_settori_profili
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_sr_settori_profili
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_sr_settori_profili
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_sr_settori_profili
end type

type tab_1 from w_g_tab_3`tab_1 within w_sr_settori_profili
boolean visible = true
integer width = 1874
long backcolor = 67108864
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
integer width = 1838
long backcolor = 67108864
string text = "Settore"
long tabbackcolor = 67108864
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
boolean visible = true
integer width = 1202
string dataobject = "d_sr_settore_profilo"
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;//
string k_descr_profilo, k_descr_settore, k_nome
//long k_riga
datawindowchild kdwc_1 //, kdwc_2


k_nome = dwo.name

//--- se 'nuovo' compone la descrizione in automatico
if k_nome = "descr" then
	if this.getitemstatus(row, 0, primary!) = newmodified! then
		k_descr_settore = trim(this.getitemstring(row, "sr_settori_profili_sr_settore_1"))
		k_descr_profilo =  trim(this.getitemstring(row, "sr_profili_descrizione"))
		if k_descr_profilo > " " and k_descr_settore > " " then
			if pos(k_descr_settore, "Settore", 1) > 0 or pos(k_descr_settore, "settore", 1) > 0 then
			else
				k_descr_settore = "Settore " + k_descr_settore
			end if
			if pos(k_descr_profilo, "Profilo", 1) > 0 or pos(k_descr_profilo, "profilo", 1) > 0 then
				k_descr_profilo = "Cod. " + string(this.getitemnumber(row, "id_sr_profilo")) + " " + k_descr_profilo
			else
				k_descr_profilo = "Profilo " + string(this.getitemnumber(row, "id_sr_profilo")) + " " + k_descr_profilo
			end if
			this.setitem(row, "descr", (k_descr_profilo + " nel " + k_descr_settore) )
		end if
	end if
else
	if k_nome = "id_sr_profilo" then
		this.getchild("id_sr_profilo", kdwc_1)
//		this.getchild("sr_profili_descrizione", kdwc_2)
//		k_riga = kdwc_1.getselectedrow(0)
//		kdwc_1.sharedata(kdwc_2)
//		if k_riga > 0 then
//			this.setitem(1,"sr_profili_descrizione", kdwc_1.getitemstring(k_riga, "descrizione"))
//		end if
	end if
end if

end event

event dw_1::itemchanged;call super::itemchanged;//
string k_nome
long k_riga
datawindowchild kdwc_1	


	k_nome = dwo.name
	if k_nome = "id_sr_profilo" then
		this.getchild("id_sr_profilo", kdwc_1)
		k_riga = kdwc_1.getselectedrow(0)
		if k_riga > 0 then
			this.setitem(1,"sr_profili_descrizione", kdwc_1.getitemstring(k_riga, "descrizione"))
			this.setitem(1,"sr_profili_nome", kdwc_1.getitemstring(k_riga, "nome"))
		end if
	end if

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 1838
long backcolor = 67108864
string text = "Utenti associati  al Settore"
long tabbackcolor = 67108864
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 9
integer y = 28
boolean enabled = true
string dataobject = "d_sr_utenti_settori_profili_l"
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 1838
long backcolor = 67108864
string text = "Profili associati al Settore"
long tabbackcolor = 67108864
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
boolean enabled = true
string dataobject = "d_sr_settore_profili_l"
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 1838
boolean enabled = false
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 1838
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 1838
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 1838
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 1838
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 1838
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

