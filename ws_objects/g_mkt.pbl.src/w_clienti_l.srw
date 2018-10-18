$PBExportHeader$w_clienti_l.srw
forward
global type w_clienti_l from w_g_tab0
end type
type cb_stat from commandbutton within w_clienti_l
end type
type cb_contratti from commandbutton within w_clienti_l
end type
type cb_listino from commandbutton within w_clienti_l
end type
type st_elenco from statictext within w_clienti_l
end type
type dw_esporta from datawindow within w_clienti_l
end type
type dw_stampa from datawindow within w_clienti_l
end type
end forward

global type w_clienti_l from w_g_tab0
integer width = 3282
integer height = 2000
string title = "Anagrafiche"
boolean ki_toolbar_window_presente = true
boolean ki_reset_dopo_save_ok = false
event u_premuto_enter pbm_dwnprocessenter
cb_stat cb_stat
cb_contratti cb_contratti
cb_listino cb_listino
st_elenco st_elenco
dw_esporta dw_esporta
dw_stampa dw_stampa
end type
global w_clienti_l w_clienti_l

type variables

private st_tab_clienti ki_st_tab_clienti
private string ki_ultimo_clie_3_cercato="*********"
private int ki_dw_guida_dinamico = 0

private long ki_nrows_lastretrieve=1
end variables

forward prototypes
protected subroutine cancella_cliente ()
protected subroutine forma_elenco ()
private subroutine stampa ()
private function string inizializza ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine imposta_elenco ()
private subroutine call_elenco_fatture ()
private subroutine call_elenco_capitolati ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
public subroutine u_retrieve_post ()
protected subroutine attiva_tasti_0 ()
private subroutine stampa_crea_temptable () throws uo_exception
public subroutine stampa_choose_run ()
public subroutine set_window_size ()
end prototypes

event u_premuto_enter;//
//--- se elenco vuoto e premo ENTER è come pulsante OK 
//
if dw_lista_0.rowcount( ) = 0 then
	
	dw_guida.event ue_buttonclicked( )
	
end if

end event

protected subroutine cancella_cliente ();//
string k_rag_soc
long k_id_cliente
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_clienti  kuf1_clienti  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_rag_soc = dw_lista_0.getitemstring(k_riga, "rag_soc_1")
	k_id_cliente = dw_lista_0.getitemnumber(k_riga, "id_cliente")

	if isnull(k_rag_soc) = true or trim(k_rag_soc) = "" then
		k_rag_soc = "Anagrafica Senza Ragione Sociale" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Anagrafica", "Sei sicuro di voler Cancellare : ~n~r" + k_rag_soc, &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_clienti = create kuf_clienti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_clienti.tb_delete(k_id_cliente) 
		if LeftA(k_errore, 1) = "0" then
	
			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

			end if

			dw_lista_0.setfocus()

		else
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
		destroy kuf1_clienti

	else
		messagebox("Elimina Anagrafica", "Operazione Annullata !!")

	end if
end if

end subroutine

protected subroutine forma_elenco ();
end subroutine

private subroutine stampa ();//
dw_stampa.visible = true



end subroutine

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
int k_importa = 0


	SetPointer(kkg.pointer_attesa)

//--- Se non ho indicato un cliente particolare mi fermo e chiedo all'operatore
	if ki_st_open_w.flag_primo_giro = "S" then
		if len(trim(ki_st_tab_clienti.rag_soc_10)) = 0 and ki_st_tab_clienti.tipo = "*" then

			dw_guida.setfocus( )
			dw_guida.setitem(1,"rag_soc_1", "")

		else
			dw_guida.setitem(1,"rag_soc_1", string(ki_st_tab_clienti.rag_soc_10 ))
		end if
		
		dw_guida.setcolumn("rag_soc_1")

	end if


	if ki_st_open_w.flag_primo_giro <> "S" or len(trim(ki_st_tab_clienti.rag_soc_10)) > 0 or ki_st_tab_clienti.tipo <> "*" then

//		if dw_lista_0.retrieve(ki_st_tab_clienti.rag_soc_10, ki_st_tab_clienti.tipo) < 1 then
		if u_retrieve_dw_lista() < 1 then
			
			k_return = "1Non trovate Anagrafiche "

			SetPointer(kkg.pointer_default)
			messagebox("Lista Anagrafiche Vuota", 	"Nesun Nominativo Trovato per la richiesta fatta")
		else
			u_retrieve_post( )
		end if		
	end if



return k_return



end function

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

	case KKG_FLAG_RICHIESTA.libero1		//Contratti...
		call_elenco_capitolati()

	case KKG_FLAG_RICHIESTA.libero2		//Contratti...
		cb_contratti.triggerevent(clicked!)

	case KKG_FLAG_RICHIESTA.libero3		//Listino...
		cb_listino.triggerevent(clicked!)

//	case KKG_FLAG_RICHIESTA.libero4		//Statistica...
//		cb_stat.triggerevent(clicked!)

	case KKG_FLAG_RICHIESTA.libero5		//Lista ridotta / estesa
		imposta_elenco()

//	case KKG_FLAG_RICHIESTA.libero6		//Elenco Fatture
//		call_elenco_fatture()


	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	ki_menu.m_finestra.m_fin_stampa.text = "Stampa Anagrafiche"
	ki_menu.m_finestra.m_fin_stampa.toolbaritemText = "Stampa,Stampa Anagrafiche"

	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> cb_contratti.enabled or ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible then 
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Capitolati"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Capitolato,Elenco Capitolati per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_contratti.enabled
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "Cntr,Elenco Contratti per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	end if
	
	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled <> cb_contratti.enabled or not ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Conferme Ordini"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"CO,Elenco Conferme Ordini per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_contratti.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "CO,Conferme Ordini per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
	end if
	if ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> cb_listino.enabled or not ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = cb_listino.text
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
		"Listini,Elenco Listini dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = cb_listino.enabled
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini, Elenco Listini dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if
//	if ki_menu.m_strumenti.m_fin_gest_libero4.enabled <> cb_stat.enabled or not ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible then
//		ki_menu.m_strumenti.m_fin_gest_libero4.text = cb_stat.text
//		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
//		"Stat.Fatt,Estrazione statistico di magazzino dell'anagrafica selezionata"
//		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = cb_stat.enabled
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText =  "Stat., Estrazione statistico di magazzino dell'anagrafica selezionata"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Graph!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero4.visible = false
//	end if
//
	if ki_menu.m_strumenti.m_fin_gest_libero5.enabled <> st_elenco.enabled or not ki_menu.m_strumenti.m_fin_gest_libero5.visible then
		ki_menu.m_strumenti.m_fin_gest_libero5.text = st_elenco.text
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = &
		"Riduci,Comprime elenco, riduce le colonne "
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = st_elenco.enabled
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Riduce, Comprime/Estende elenco "
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "PlaceColumn5!"
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
	end if

//	if not ki_menu.m_strumenti.m_fin_gest_libero6.visible then
//		ki_menu.m_strumenti.m_fin_gest_libero6.text = "Elenco documenti di vendita "
//		ki_menu.m_strumenti.m_fin_gest_libero6.microhelp = &
//		"Fatture, Elenco documenti di vendita  "
//		ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = "Fatture, Elenco documenti di vendita  "
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "fattura16x16.gif"
////		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = kGuo_path.get_risorse() +  "\fattura16x16.gif"
//		ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero6.visible = false
//	end if

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
end subroutine

protected subroutine imposta_elenco ();//
string k_flag



	dw_lista_0.setredraw(false)
//	parent.setredraw(false)

	k_flag = "0" //non visibile

	dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
	dw_lista_0.Modify("e1ancodrs.Visible=" + k_flag)
	dw_lista_0.Modify("e1an.Visible=" + k_flag)
	dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
	dw_lista_0.Modify("tel_num.Visible=" + k_flag)
	dw_lista_0.Modify("fax_num.Visible=" + k_flag)
	dw_lista_0.Modify("prov.Visible=" + k_flag)
	dw_lista_0.Modify("id_nazione.Visible=" + k_flag)
	dw_lista_0.Modify("localita.Visible=" + k_flag)
	dw_lista_0.Modify("cap.Visible=" + k_flag)
	dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
	dw_lista_0.Modify("banca.Visible=" + k_flag)
	dw_lista_0.Modify("p_iva.Visible=" + k_flag)
	dw_lista_0.Modify("iva.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_dal.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_al.Visible=" + k_flag)
	dw_lista_0.Modify("cod_pag.Visible=" + k_flag)
	dw_lista_0.Modify("x_datins.Visible=" + k_flag)
	dw_lista_0.Modify("stato.Visible=" + k_flag)
	dw_lista_0.Modify("id_meca_causale.Visible=" + k_flag)
	dw_lista_0.Modify("allegato.Visible=" + k_flag)

	k_flag = "1" // visibile

//=== Rivisualizza i dati in un ordine diverso
	if st_elenco.tag = "ridotta" or LenA(trim(st_elenco.tag)) = 0 then //ridotta
	
		st_elenco.tag = "estesa"
			
  	  	dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
		dw_lista_0.Modify("e1ancodrs.Visible=" + k_flag)
		dw_lista_0.Modify("e1an.Visible=" + k_flag)
		dw_lista_0.Modify("allegato.Visible=" + k_flag)
		dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
		dw_lista_0.Modify("tel_num.Visible=" + k_flag)
		dw_lista_0.Modify("fax_num.Visible=" + k_flag)
		dw_lista_0.Modify("localita.Visible=" + k_flag)
		dw_lista_0.Modify("prov.Visible=" + k_flag)
		dw_lista_0.Modify("id_nazione.Visible=" + k_flag)
		dw_lista_0.Modify("cap.Visible=" + k_flag)
		dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
		dw_lista_0.Modify("banca.Visible=" + k_flag)
		dw_lista_0.Modify("stato.Visible=" + k_flag)

	else
		st_elenco.tag = "ridotta"
		
		dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
		dw_lista_0.Modify("e1ancodrs.Visible=" + k_flag)
		dw_lista_0.Modify("e1an.Visible=" + k_flag)
		dw_lista_0.Modify("allegato.Visible=" + k_flag)
		dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
		dw_lista_0.Modify("localita.Visible=" + k_flag)
		dw_lista_0.Modify("prov.Visible=" + k_flag)
		dw_lista_0.Modify("id_nazione.Visible=" + k_flag)
		dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
		dw_lista_0.Modify("cap.Visible=" + k_flag)
		dw_lista_0.Modify("tel_num.Visible=" + k_flag)
		dw_lista_0.Modify("fax_num.Visible=" + k_flag)
		dw_lista_0.Modify("banca.Visible=" + k_flag)
		dw_lista_0.Modify("p_iva.Visible=" + k_flag)
		dw_lista_0.Modify("iva.Visible=" + k_flag)
		dw_lista_0.Modify("iva_valida_dal.Visible=" + k_flag)
		dw_lista_0.Modify("iva_valida_al.Visible=" + k_flag)
		dw_lista_0.Modify("cod_pag.Visible=" + k_flag)
		dw_lista_0.Modify("x_datins.Visible=" + k_flag)
		dw_lista_0.Modify("stato.Visible=" + k_flag)
		dw_lista_0.Modify("id_meca_causale.Visible=" + k_flag)
	end if

	dw_lista_0.Modify("id_cliente_t.Visible=" + k_flag)
	dw_lista_0.Modify("e1ancodrs_t.Visible=" + k_flag)
	dw_lista_0.Modify("e1an_t.Visible=" + k_flag)
	dw_lista_0.Modify("allegato_t.Visible=" + k_flag)
	dw_lista_0.Modify("rag_soc_1_t.Visible=" + k_flag)
	dw_lista_0.Modify("tel_num_t.Visible=" + k_flag)
	dw_lista_0.Modify("fax_num_t.Visible=" + k_flag)
	dw_lista_0.Modify("localita_t.Visible=" + k_flag)
	dw_lista_0.Modify("cap_t.Visible=" + k_flag)
	dw_lista_0.Modify("prov_t.Visible=" + k_flag)
	dw_lista_0.Modify("id_nazione_t.Visible=" + k_flag)
	dw_lista_0.Modify("indirizzo_t.Visible=" + k_flag)
	dw_lista_0.Modify("banca_t.Visible=" + k_flag)
	dw_lista_0.Modify("p_iva_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_dal_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_al_t.Visible=" + k_flag)
	dw_lista_0.Modify("cod_pag_t.Visible=" + k_flag)
	dw_lista_0.Modify("x_datins_t.Visible=" + k_flag)
	dw_lista_0.Modify("stato_t.Visible=" + k_flag)
	dw_lista_0.Modify("id_meca_causale_t.Visible=" + k_flag)

	dw_lista_0.setredraw(true)


end subroutine

private subroutine call_elenco_fatture ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( dw_lista_0.getrow(), "id_cliente") 

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture_elenco
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = " "  //data da  
	K_st_open_w.key3 = " "  //data a
	K_st_open_w.flag_where = " "
	
//	kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
//	destroy kuf1_menu_window

else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_capitolati ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( &
						dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_sc_cf
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = "*" // flag attivi
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

protected subroutine open_start_window ();//
	ki_toolbar_window_presente=true


//--- Salvo il passato nei parametri di input
	ki_st_tab_clienti.rag_soc_10 = trim(ki_st_open_w.key1)
	if  isnull(ki_st_tab_clienti.rag_soc_10) then
		ki_st_tab_clienti.rag_soc_10 = ""
	end if
	
	if isnull(ki_st_open_w.key2) or Len(trim(ki_st_open_w.key2)) = 0 then
		ki_st_tab_clienti.tipo = "*"
	else
		if trim(ki_st_open_w.key2) = "1" then
			ki_st_tab_clienti.tipo = "M"
		else
			if trim(ki_st_open_w.key2) = "2" then
				ki_st_tab_clienti.tipo = "R"
			else
				if trim(ki_st_open_w.key2) = "3" then
					ki_st_tab_clienti.tipo = "F"
				else
					ki_st_tab_clienti.tipo = "*"
				end if
			end if
		end if
	end if

	if dw_guida.insertrow(0) > 0 then
		dw_guida.setitem(1, "rag_soc_1", "")
		dw_guida.setitem(1, "dinamico", ki_dw_guida_dinamico)
	end if

//--- box di stampa
	dw_stampa.move((this.width - dw_stampa.width) / 3, (this.height - dw_stampa.height) / 3)
	dw_stampa.insertrow(1)
end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	

	if  len(trim(ki_st_tab_clienti.rag_soc_10)) = 0 or ki_st_tab_clienti.rag_soc_10 = "*" then
		ki_st_tab_clienti.rag_soc_10 = "*"
	else
		ki_st_tab_clienti.rag_soc_10 = "%" + trim(ki_st_tab_clienti.rag_soc_10) + "%"
	end if
	
	if isnull(ki_st_tab_clienti.codice) then ki_st_tab_clienti.codice = 0 
	
//	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(ki_st_tab_clienti.rag_soc_10, ki_st_tab_clienti.tipo, ki_st_tab_clienti.codice) 
	dw_lista_0.setfocus( )

	//--- seleziona almeno una riga
	if dw_lista_0.rowcount() > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
	end if

	attiva_tasti( )
	
return k_return
	

end function

public subroutine u_retrieve_post ();//---
//---  Dopo la Retrieve posizione cursore
//---

if dw_lista_0.rowcount() > 0 then
	dw_lista_0.setfocus( )

	//--- seleziona almeno una riga
	if dw_lista_0.rowcount() > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
	end if

end if	

//attiva_tasti( )
	

end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


k_nr_righe = dw_lista_0.rowcount ( )
//--- faccio qeste cose solo se la presenza di righe è cambiato rispetto alla precedente
//if (k_nr_righe > 0 and ki_nrows_lastretrieve = 0) or (ki_nrows_lastretrieve > 0 and k_nr_righe = 0) then 
	ki_nrows_lastretrieve = k_nr_righe
	
	super::attiva_tasti_0()
	
	cb_ritorna.enabled = true
	cb_inserisci.enabled = true
	cb_visualizza.enabled = true
	st_aggiorna_lista.enabled = true
	st_ordina_lista.enabled = true
	
	//cb_aggiorna.enabled = false
	cb_modifica.enabled = false
	cb_cancella.enabled = false
	
	cb_stat.enabled = false
	cb_contratti.enabled = false
	cb_listino.enabled = false
	
	//=== Nr righe nel DW lista
	if k_nr_righe > 0 then
		cb_modifica.enabled = true
		cb_cancella.enabled = true
	
		cb_stat.enabled = true
		cb_listino.enabled = true
	
	//--- se tipologiea clienti RICEVENTI
		if trim(ki_st_open_w.key2) = "2" or &
			LenA(trim(ki_st_open_w.key2)) = 0 or &
			trim(ki_st_open_w.key2) = "*" then      // Riceventi o Tutti
			cb_contratti.enabled = true
		end if
		
	end if
	
	////=== Nr righe nel DW lista
	//if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	//	cb_cancella.enabled = true
	////	cb_aggiorna.enabled = true
	//end if
					
//end if



end subroutine

private subroutine stampa_crea_temptable () throws uo_exception;//======================================================================
//=== Crea le View per le query
//======================================================================
//
int k_ctr
long k_nr_clienti, k_riga, k_id_cliente
string k_view, k_sql, k_campi
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
SetPointer(kkg.pointer_attesa)

//--- costruisco la temp-table con ID_MECA delle fatture emesse da data a data
	k_view = kguf_data_base.u_get_nometab_xutente("clienti_l")   //"vx_" + trim(kguo_utente.get_codice( )) + "_clienti_l "
	k_sql = " "                                   
   k_campi = "riga integer, id_cliente integer " 
   kguo_sqlca_db_magazzino.db_crea_temp_table(k_view, k_campi, k_sql)      

	k_nr_clienti = dw_lista_0.rowcount( )
	for k_riga = 1 to k_nr_clienti
   	k_id_cliente = dw_lista_0.getitemnumber(k_riga, "id_cliente")
  		k_sql = "INSERT INTO " + "#" + trim(k_view) + " (riga, id_cliente) VALUES (" + string(k_riga) + ", " + string(k_id_cliente) + ")"
 
   	EXECUTE IMMEDIATE :k_sql USING kguo_sqlca_db_magazzino ;
 
   	if kguo_sqlca_db_magazzino.SQLCode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Inserimanto dati nella Temp-Table '"  + trim(k_view) &
										  + "' non riuscito: " + trim(kguo_sqlca_db_magazzino.SQLErrText) &
										  + " (" + string(kguo_sqlca_db_magazzino.SQLcode) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
   	end if
	next
	kguo_sqlca_db_magazzino.db_commit()
	
//=== Riprist. il vecchio puntatore : 
SetPointer(kkg.pointer_default)


end subroutine

public subroutine stampa_choose_run ();//
//long k_num_riga, k_riga
string k_stampa, k_rag_soc, k_tipo, k_tipo_stampa_anag, k_sql_orig, k_stringn, k_string
int k_rc=0, k_ctr
st_stampe kst_stampe


try
	//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)
	
	dw_stampa.visible = false
	k_tipo_stampa_anag = trim(dw_stampa.getitemstring(1, "tipo_stampa"))
	
	k_stampa = "Elenco Anagrafiche "

	stampa_crea_temptable( ) // Crea la tabella pilota con i clienti da estrarre


	choose case k_tipo_stampa_anag
			
		case "C"
	//--- stampa in formato tabulato i dati cliente
			if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
			kst_stampe.ds_print.reset( )
			kst_stampe.ds_print.dataobject = "d_clienti_l_1"
			kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	//--- Aggiorna SQL della dw	
			kguf_data_base.u_set_ds_change_name_tab(kst_stampe.ds_print, "vx_MAST2_clienti_l") 
			k_rc = kst_stampe.ds_print.retrieve( )
			if k_rc > 0 then
				kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
				kst_stampe.titolo = trim(k_stampa)
				kGuf_data_base.stampa_dw(kst_stampe)
				kst_stampe.titolo = trim(k_stampa)
			end if

//				dw_esporta.settransobject(sqlca)
//				dw_esporta.retrieve(k_rag_soc, 0)
			//k_rc = dw_lista_0.sharedata(dw_dett_0)
			//kst_stampe.dw_esporta = dw_esporta
//			kst_stampe.ds_esporta = create datastore
//			dw_esporta.rowscopy(1, dw_esporta.rowcount( ) , primary!, kst_stampe.ds_esporta, 1, primary!)
//			kGuf_data_base.stampa_dw(kst_stampe)
				
		case "X"
	//--- stampa 'tutti' i dati cliente, utile per fare una esportazione XLS	
			if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
			kst_stampe.ds_print.reset( )
			kst_stampe.ds_print.dataobject = "d_clienti_l_completa_x_exp"
			kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	//--- Aggiorna SQL della dw	
			kguf_data_base.u_set_ds_change_name_tab(kst_stampe.ds_print, "vx_MAST2_clienti_l") 
			if kst_stampe.ds_print.retrieve() > 0 then
				kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
				kst_stampe.titolo = trim(k_stampa)
				kGuf_data_base.stampa_dw(kst_stampe)
			end if
				
		case "N"
	//--- stampa tutti i dati cliente, utile per fare una esportazione XLS	
			if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
			kst_stampe.ds_print.reset( )
			kst_stampe.ds_print.dataobject = "d_clienti_lista_stampa_contatti"
			kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
	//--- Aggiorna SQL della dw	
			kguf_data_base.u_set_ds_change_name_tab(kst_stampe.ds_print, "vx_MAST2_clienti_l") 
			if kst_stampe.ds_print.retrieve() > 0 then
				kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
				kst_stampe.titolo = trim(k_stampa)
				kGuf_data_base.stampa_dw(kst_stampe)
			end if
	
		case else
	//--- stampa quello che è a video	
			if not isvalid(kst_stampe.ds_print) then kst_stampe.ds_print = create datastore
			kst_stampe.ds_print.reset( )
			kst_stampe.ds_print.dataobject = "d_clienti_lista_stampa"
			kst_stampe.ds_print.settransobject(kguo_sqlca_db_magazzino)
//--- Aggiorna SQL della dw	
			kguf_data_base.u_set_ds_change_name_tab(kst_stampe.ds_print, "vx_MAST2_clienti_l") 
			if kst_stampe.ds_print.retrieve( ) > 0 then
				kst_stampe.titolo = trim(k_stampa)
				kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore
				kGuf_data_base.stampa_dw(kst_stampe)
			end if
	end choose
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try



end subroutine

public subroutine set_window_size ();//---
//--- Recupera proprietà della funzione
//---
string k_rcx
st_profilestring_ini kst_profilestring_ini


	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.file = "window" 
	kst_profilestring_ini.titolo = trim(this.classname( ))
 	kst_profilestring_ini.nome = "dw_guida_dinamico"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	if isnull(kst_profilestring_ini.valore) or not isnumber(kst_profilestring_ini.valore) then kst_profilestring_ini.valore = "0"
	ki_dw_guida_dinamico = integer(kst_profilestring_ini.valore)

	super::set_window_size( )
	

end subroutine

on w_clienti_l.create
int iCurrent
call super::create
this.cb_stat=create cb_stat
this.cb_contratti=create cb_contratti
this.cb_listino=create cb_listino
this.st_elenco=create st_elenco
this.dw_esporta=create dw_esporta
this.dw_stampa=create dw_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stat
this.Control[iCurrent+2]=this.cb_contratti
this.Control[iCurrent+3]=this.cb_listino
this.Control[iCurrent+4]=this.st_elenco
this.Control[iCurrent+5]=this.dw_esporta
this.Control[iCurrent+6]=this.dw_stampa
end on

on w_clienti_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_stat)
destroy(this.cb_contratti)
destroy(this.cb_listino)
destroy(this.st_elenco)
destroy(this.dw_esporta)
destroy(this.dw_stampa)
end on

event open;call super::open;
//=== Toglie i campi dall'elenco 
st_elenco.tag = " "
imposta_elenco()


//--- se tipologie clienti = tutte allora cambio dw x ottimizzazione select
//--- tipo mandante/ricevente/fatturato
	if isnull(ki_st_open_w.key2) or trim(ki_st_open_w.key2) = "*" &
	   or Len(trim(ki_st_open_w.key2)) = 0 then
	else
		if trim(ki_st_open_w.key2) = "1" then
			this.title="Mandanti"
		else
			if trim(ki_st_open_w.key2) = "2" then
				this.title="Riceventi"
			else
				if trim(ki_st_open_w.key2) = "3" then
					this.title="Fatturati"
				else
					this.title="????????"
				end if
			end if
		end if
	end if

    this.visible = true
	 

end event

event close;call super::close;//---
//--- Salva proprietà della funzione
//---
string k_rcx
st_profilestring_ini kst_profilestring_ini


	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.valore = string(dw_guida.getitemnumber(1, "dinamico"))
	if isnull(kst_profilestring_ini.valore) then kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "window" 
	kst_profilestring_ini.titolo = trim(this.classname( ))
 	kst_profilestring_ini.nome = "dw_guida_dinamico"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))


end event

type st_ritorna from w_g_tab0`st_ritorna within w_clienti_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_clienti_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_clienti_l
integer x = 978
integer y = 1080
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_clienti_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_clienti_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_clienti_l
integer x = 777
integer y = 1188
integer taborder = 30
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_id_cliente
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
		
	if k_id_cliente  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = kkg_id_programma_anag
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
		
	end if
end if
	


end event

type cb_modifica from w_g_tab0`cb_modifica within w_clienti_l
integer x = 1737
integer y = 1180
integer height = 96
integer taborder = 90
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_id_cliente
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
		
	if k_id_cliente  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = kkg_id_programma_anag
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
	//	kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//	destroy kuf1_menu_window
		
	end if
end if
	




end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_clienti_l
integer x = 325
integer y = 1168
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_clienti_l
integer x = 2126
integer y = 1180
integer height = 96
integer taborder = 100
end type

event cb_cancella::clicked;//
	cancella_cliente()

end event

type cb_inserisci from w_g_tab0`cb_inserisci within w_clienti_l
integer x = 1307
integer y = 1184
integer height = 96
integer taborder = 80
boolean enabled = false
end type

event cb_inserisci::clicked;//
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


		attiva_tasti()
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = kkg_id_programma_anag
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = "0000000000"
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
	//	kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//	destroy kuf1_menu_window

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_clienti_l
integer x = 1202
integer y = 1312
integer width = 1600
integer height = 476
string dataobject = "d_clienti_l_1"
end type

event dw_dett_0::rbuttondown;call super::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end event

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_clienti_l
integer x = 5
integer y = 708
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_clienti_l
integer x = 37
integer y = 28
integer width = 2807
integer height = 1044
string dataobject = "d_clienti_lista"
end type

event dw_lista_0::u_pigiato_enter;//
parent.event u_premuto_enter( )

end event

type dw_guida from w_g_tab0`dw_guida within w_clienti_l
boolean enabled = true
string dataobject = "d_clienti_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true


	if isnumber(trim(dw_guida.getitemstring(1, "rag_soc_1"))) then
		
		ki_st_tab_clienti.codice = long(dw_guida.getitemstring(1, "rag_soc_1"))
		if isnull(ki_st_tab_clienti.codice ) then
			ki_st_tab_clienti.codice = 0
		end if
		ki_st_tab_clienti.rag_soc_10 = ""
	else
		if isnull(dw_guida.getitemstring(1, "rag_soc_1")) then
			ki_st_tab_clienti.rag_soc_10 = ""
		else
			ki_st_tab_clienti.rag_soc_10 = trim(dw_guida.getitemstring(1, "rag_soc_1") )
		end if
		ki_st_tab_clienti.codice = 0
	end if


//--- solo se ricerco un cliente diverso
	if ki_ultimo_clie_3_cercato <> trim(dw_guida.getitemstring(1, "rag_soc_1")) then
		
		ki_ultimo_clie_3_cercato = trim(dw_guida.getitemstring(1, "rag_soc_1"))
		u_retrieve_dw_lista()
		u_retrieve_post()			
	end if

end event

event dw_guida::ue_retrieve_dinamico;call super::ue_retrieve_dinamico;//---	
//--- 
//---
if k_campo = "rag_soc_1" and dw_guida.getitemnumber(1, "dinamico") = 1 then
	this.accepttext( )

	if isnumber(trim(k_data)) then
		
		ki_st_tab_clienti.codice = long(k_data)
		if isnull(ki_st_tab_clienti.codice ) then
			ki_st_tab_clienti.codice = 0
		end if
		ki_st_tab_clienti.rag_soc_10 = ""
	else
		if isnull(k_data) then
			ki_st_tab_clienti.rag_soc_10 = ""
		else
			ki_st_tab_clienti.rag_soc_10 = trim(k_data)
		end if
		ki_st_tab_clienti.codice = 0
	end if


//--- solo se ricerco un cliente diverso
	if ki_ultimo_clie_3_cercato <> trim(k_data) then
		
		ki_ultimo_clie_3_cercato = trim(k_data)
		u_retrieve_dw_lista()
		this.setfocus( )
		this.SelectText (len (k_campo) + 1, 0)  // posizione del cursose a fine campo
	end if
end if

end event

type cb_stat from commandbutton within w_clienti_l
event clicked pbm_bnclicked
boolean visible = false
integer x = 2432
integer y = 1088
integer width = 722
integer height = 68
integer taborder = 140
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Stat.Fatt,Statistica Fatturato"
end type

event clicked;//
string k_anno
long k_id_cliente
kuf_base kuf1_base
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then


	k_id_cliente = dw_lista_0.getitemnumber( &
						dw_lista_0.getrow(), "id_cliente") 

	
	kuf1_base = create kuf_base
	k_anno = trim(MidA(kuf1_base.prendi_dato_base("anno"),2))
	destroy kuf1_base
	

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

	K_st_open_w.id_programma = "skc"
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "sk"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = "1"
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = "0000000000"  //dose
	K_st_open_w.key3 = "0000000000"  //id gruppo
	K_st_open_w.key4 = "01/01/" + k_anno  //data da
	K_st_open_w.key5 = "31/12/" + k_anno //data a
	K_st_open_w.key6 = " " 
	K_st_open_w.key7 = " " 
	K_st_open_w.flag_where = " "
	
//	kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
//	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if




end event

type cb_contratti from commandbutton within w_clienti_l
boolean visible = false
integer x = 1440
integer y = 1096
integer width = 453
integer height = 68
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Contratti"
end type

event clicked;//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( &
						dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = "ct"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end event

type cb_listino from commandbutton within w_clienti_l
boolean visible = false
integer x = 1902
integer y = 1088
integer width = 453
integer height = 68
integer taborder = 150
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Listini"
end type

event clicked;//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( &
						dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto

		K_st_open_w.id_programma = "listino_l"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // cod articolo 
		K_st_open_w.key3 = " " // dose
		K_st_open_w.key4 = " " // misure imballo
		K_st_open_w.key5 = " " // misure imballo
		K_st_open_w.key6 = " " // misure imballo
		K_st_open_w.flag_where = " "
		
	//	kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
	//	destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end event

type st_elenco from statictext within w_clienti_l
boolean visible = false
integer x = 18
integer y = 1080
integer width = 658
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Elenco Ridotto / Esteso"
boolean focusrectangle = false
end type

type dw_esporta from datawindow within w_clienti_l
string tag = "x esportare ad esempio un flusso in xls"
boolean visible = false
integer x = 59
integer y = 988
integer width = 686
integer height = 244
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_clienti_l_esporta"
boolean border = false
boolean livescroll = true
end type

type dw_stampa from datawindow within w_clienti_l
boolean visible = false
integer x = 105
integer y = 888
integer width = 1522
integer height = 780
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Stampa dati Anagrafiche in elenco"
string dataobject = "d_clienti_l_tipo_stampa"
boolean border = false
end type

event buttonclicked;//
if dwo.name = "b_ok" then
	stampa_choose_run()
else
	if dwo.name = "b_annulla" then
		this.visible = false
	end if
end if
end event

