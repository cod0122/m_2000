$PBExportHeader$w_clienti_l.srw
forward
global type w_clienti_l from w_g_tab0
end type
type gb_stampa from groupbox within w_clienti_l
end type
type cb_stat from commandbutton within w_clienti_l
end type
type cb_contratti from commandbutton within w_clienti_l
end type
type cb_listino from commandbutton within w_clienti_l
end type
type st_elenco from statictext within w_clienti_l
end type
type rb_stampa_elenco from radiobutton within w_clienti_l
end type
type rb_stampa_completa from radiobutton within w_clienti_l
end type
type cb_stampa_ok from commandbutton within w_clienti_l
end type
type cb_stampa_annulla from commandbutton within w_clienti_l
end type
end forward

global type w_clienti_l from w_g_tab0
integer width = 3282
integer height = 2000
string title = "Anagrafiche"
gb_stampa gb_stampa
cb_stat cb_stat
cb_contratti cb_contratti
cb_listino cb_listino
st_elenco st_elenco
rb_stampa_elenco rb_stampa_elenco
rb_stampa_completa rb_stampa_completa
cb_stampa_ok cb_stampa_ok
cb_stampa_annulla cb_stampa_annulla
end type
global w_clienti_l w_clienti_l

forward prototypes
protected subroutine cancella_cliente ()
protected subroutine forma_elenco ()
private subroutine stampa ()
private function string inizializza ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
private subroutine attiva_tasti ()
protected subroutine imposta_elenco ()
private subroutine stampa_come ()
private subroutine call_elenco_fatture ()
private subroutine call_elenco_capitolati ()
end prototypes

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
	
			k_errore = kuf1_data_base.db_commit()
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
			k_errore = kuf1_data_base.db_rollback()

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
long k_num_riga, k_riga
string k_stampa, k_rag_soc, k_tipo
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable


stampa_come()

//
////=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)
//
//
////=== Posiziono la dw per farla vedere
//	dw_dett_0.height = dw_lista_0.height
//	dw_dett_0.width = dw_lista_0.width
//	dw_dett_0.x = dw_lista_0.x
//	dw_dett_0.y = dw_lista_0.y
//
//   k_stampa = "Stampa Anagrafiche "
////	if ddlb_elenco.text = "Rubrica" then
////		dw_dett_0.dataobject = "d_clienti_l_telef"
////		k_stampa = "Anagrafiche : Rubrica telefonica"
////	else
////		dw_dett_0.dataobject = "d_clienti_l_1"
////		k_stampa = "Anagrafiche : Completa"
////	end if
//
//	k_rag_soc = trim(ki_st_open_w.key1) + "%"
//	k_tipo = trim(ki_st_open_w.key2) 
//	if isnull(k_tipo) then
//		k_tipo = "*"
//	end if
//
//	dw_dett_0.settransobject(sqlca)
//
//	if dw_dett_0.retrieve(k_rag_soc) > 0 then
//		
//		dw_dett_0.visible = true
//		dw_lista_0.visible = false
//		
//		kst_stampe.dw_print = dw_dett_0
//		kst_stampe.titolo = trim(k_stampa)
//		kuf1_data_base.stampa_dw(kst_stampe)
////		kuf1_data_base.stampa_dw(dw_lista_0, k_stampa)
//		
//		dw_lista_0.visible = true
//		dw_dett_0.visible = false
//		
//	end if
//
//
//
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
string k_rag_soc, k_tipo, k_key
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_rag_soc = trim(ki_st_open_w.key1)
//--- se tipologie clienti = tutte allora cambio dw x ottimizzazione select
//--- tipo mandante/ricevente/fatturato
	if isnull(ki_st_open_w.key2) or trim(ki_st_open_w.key2) = "*" &
	   or Len(trim(ki_st_open_w.key2)) = 0 then
		k_tipo = "*"
	else
		if trim(ki_st_open_w.key2) = "1" then
			k_tipo = "M"
		else
			if trim(ki_st_open_w.key2) = "2" then
				k_tipo = "R"
			else
				if trim(ki_st_open_w.key2) = "3" then
					k_tipo = "F"
				else
					k_tipo = "*"
				end if
			end if
		end if
	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if isnull(k_rag_soc) then
			k_rag_soc = "*"
		else
			k_rag_soc += + "%"
		end if
//		k_rag_soc = k_rag_soc + "*"

		if dw_lista_0.retrieve(k_rag_soc, k_tipo) < 1 then
			k_return = "1Non trovate Anagrafiche "

			SetPointer(oldpointer)
			messagebox("Lista Anagrafiche Vuota", &
					"Nesun Codice Trovato per la richiesta fatta")

		end if		
	end if

//

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

	case "l1"		//Contratti...
		call_elenco_capitolati()

	case "l2"		//Contratti...
		cb_contratti.triggerevent(clicked!)

	case "l3"		//Listino...
		cb_listino.triggerevent(clicked!)

	case "l4"		//Statistica...
		cb_stat.triggerevent(clicked!)

	case "l5"		//Lista ridotta / estesa
		imposta_elenco()

	case "l8"		//Elenco Fatture
		call_elenco_fatture()


	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Elenco Capitolati"
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
   "Capitolato,Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_contratti.enabled
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "Capitolati, Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Contratti"
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
   "Contratti,Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_contratti.enabled
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "Contratti, Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero3.text = cb_listino.text
	kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
   "Listini,Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.enabled = cb_listino.enabled
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini, Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero4.text = cb_stat.text
	kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
   "Stat.Fatt,Estrazione statistico di magazzino dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.enabled = cb_stat.enabled
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText =  "Stat.Fat, Estrazione statistico di magazzino dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Graph!"
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
//
	kG_menu.m_strumenti.m_fin_gest_libero5.text = st_elenco.text
	kG_menu.m_strumenti.m_fin_gest_libero5.microhelp = &
	"Riduci,Comprime elenco, riduce le colonne "
	kG_menu.m_strumenti.m_fin_gest_libero5.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero5.enabled = st_elenco.enabled
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Riduce, Comprime/Estende elenco "
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "PlaceColumn5!"
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
//
	kG_menu.m_strumenti.m_fin_gest_libero8.text = "Elenco documenti di vendita "
	kG_menu.m_strumenti.m_fin_gest_libero8.microhelp = &
	"Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero8.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.enabled = true
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText = "Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = kg_path_risorse +  "\fattura16x16.gif"
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2

	
end subroutine

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


super::attiva_tasti()

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_visualizza.enabled = true
st_aggiorna_lista.enabled = true

//cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false

cb_stat.enabled = false
cb_contratti.enabled = false
cb_listino.enabled = false

//=== Nr righe nel DW lista
if dw_lista_0.rowcount ( ) > 0 then
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
            
attiva_menu()


end subroutine

protected subroutine imposta_elenco ();//
string k_flag



	dw_lista_0.setredraw(false)
//	parent.setredraw(false)

	k_flag = "0" //non visibile

	dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
	dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
	dw_lista_0.Modify("tel_num.Visible=" + k_flag)
	dw_lista_0.Modify("fax_num.Visible=" + k_flag)
	dw_lista_0.Modify("prov.Visible=" + k_flag)
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

	k_flag = "1" // visibile

//=== Rivisualizza i dati in un ordine diverso
	if st_elenco.tag = "ridotta" or LenA(trim(st_elenco.tag)) = 0 then //ridotta
	
		st_elenco.tag = "estesa"
			
  	  	dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
		dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
		dw_lista_0.Modify("tel_num.Visible=" + k_flag)
		dw_lista_0.Modify("fax_num.Visible=" + k_flag)
		dw_lista_0.Modify("localita.Visible=" + k_flag)
		dw_lista_0.Modify("prov.Visible=" + k_flag)
		dw_lista_0.Modify("cap.Visible=" + k_flag)
		dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
		dw_lista_0.Modify("banca.Visible=" + k_flag)

	else
		st_elenco.tag = "ridotta"
		
		dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
		dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
		dw_lista_0.Modify("localita.Visible=" + k_flag)
		dw_lista_0.Modify("prov.Visible=" + k_flag)
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
	end if

	dw_lista_0.Modify("id_cliente_t.Visible=" + k_flag)
	dw_lista_0.Modify("rag_soc_1_t.Visible=" + k_flag)
	dw_lista_0.Modify("tel_num_t.Visible=" + k_flag)
	dw_lista_0.Modify("fax_num_t.Visible=" + k_flag)
	dw_lista_0.Modify("prov_t.Visible=" + k_flag)
	dw_lista_0.Modify("localita_t.Visible=" + k_flag)
	dw_lista_0.Modify("cap_t.Visible=" + k_flag)
	dw_lista_0.Modify("indirizzo_t.Visible=" + k_flag)
	dw_lista_0.Modify("banca_t.Visible=" + k_flag)
	dw_lista_0.Modify("p_iva_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_dal_t.Visible=" + k_flag)
	dw_lista_0.Modify("iva_valida_al_t.Visible=" + k_flag)
	dw_lista_0.Modify("cod_pag_t.Visible=" + k_flag)
	dw_lista_0.Modify("x_datins_t.Visible=" + k_flag)

	dw_lista_0.setredraw(true)


end subroutine

private subroutine stampa_come ();//---
//--- Pannellino di conferma del tipo di stampa da fare
//---

gb_stampa.x = (kiw_this_window.width  - gb_stampa.width) / 4
gb_stampa.y = (kiw_this_window.height - gb_stampa.height) / 4
rb_stampa_elenco.x = gb_stampa.x + 50 
rb_stampa_completa.x = rb_stampa_elenco.x
cb_stampa_ok.x = gb_stampa.x + gb_stampa.width - cb_stampa_ok.width - 100
cb_stampa_annulla.x = cb_stampa_ok.x - cb_stampa_annulla.width - 100
rb_stampa_elenco.y = gb_stampa.y +  gb_stampa.height/4.5  //gb_stampa.height - rb_stampa_completa.height - cb_stampa_ok.height -
rb_stampa_completa.y = rb_stampa_elenco.y + rb_stampa_completa.height //+ 50
cb_stampa_ok.y = gb_stampa.y + (gb_stampa.height * (9 / 10)) - cb_stampa_ok.height 
cb_stampa_annulla.y = cb_stampa_ok.y
gb_stampa.visible = true
rb_stampa_elenco.visible = true
rb_stampa_completa.visible = true
cb_stampa_ok.visible = true
cb_stampa_annulla.visible = true

end subroutine

private subroutine call_elenco_fatture ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( dw_lista_0.getrow(), "id_cliente") 

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture_elenco
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_elenco
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = " "  //data da  
	K_st_open_w.key3 = " "  //data a
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_capitolati ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = "*" // flag attivi
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

on w_clienti_l.create
int iCurrent
call super::create
this.gb_stampa=create gb_stampa
this.cb_stat=create cb_stat
this.cb_contratti=create cb_contratti
this.cb_listino=create cb_listino
this.st_elenco=create st_elenco
this.rb_stampa_elenco=create rb_stampa_elenco
this.rb_stampa_completa=create rb_stampa_completa
this.cb_stampa_ok=create cb_stampa_ok
this.cb_stampa_annulla=create cb_stampa_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_stampa
this.Control[iCurrent+2]=this.cb_stat
this.Control[iCurrent+3]=this.cb_contratti
this.Control[iCurrent+4]=this.cb_listino
this.Control[iCurrent+5]=this.st_elenco
this.Control[iCurrent+6]=this.rb_stampa_elenco
this.Control[iCurrent+7]=this.rb_stampa_completa
this.Control[iCurrent+8]=this.cb_stampa_ok
this.Control[iCurrent+9]=this.cb_stampa_annulla
end on

on w_clienti_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_stampa)
destroy(this.cb_stat)
destroy(this.cb_contratti)
destroy(this.cb_listino)
destroy(this.st_elenco)
destroy(this.rb_stampa_elenco)
destroy(this.rb_stampa_completa)
destroy(this.cb_stampa_ok)
destroy(this.cb_stampa_annulla)
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


end event

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

type st_ritorna from w_g_tab0`st_ritorna within w_clienti_l
end type

type dw_trova from w_g_tab0`dw_trova within w_clienti_l
end type

type dw_filtra from w_g_tab0`dw_filtra within w_clienti_l
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
kuf_menu_window kuf1_menu_window


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

		K_st_open_w.id_programma = "cl"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "vi"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
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
kuf_menu_window kuf1_menu_window


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

		K_st_open_w.id_programma = "cl"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "mo"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	




end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_clienti_l
integer x = 325
integer y = 1168
integer height = 96
integer taborder = 130
end type

event cb_aggiorna::clicked;//
//=== Aggiornamento dei dati inseriti/modificati
if LeftA(aggiorna_dati(), 1) = "0" then

	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
	
end if

end event

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
kuf_menu_window kuf1_menu_window


		attiva_tasti()
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = "cl"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "in"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = "0000000000"
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window

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

type gb_stampa from groupbox within w_clienti_l
boolean visible = false
integer x = 343
integer y = 1308
integer width = 846
integer height = 400
integer taborder = 90
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32768
long backcolor = 31326173
string text = "Tipo Stampa"
end type

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
kuf_menu_window kuf1_menu_window


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
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
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
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
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
kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
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
kuf_menu_window kuf1_menu_window


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
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // cod articolo 
		K_st_open_w.key3 = " " // dose
		K_st_open_w.key4 = " " // misure imballo
		K_st_open_w.key5 = " " // misure imballo
		K_st_open_w.key6 = " " // misure imballo
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
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
string text = "Riduci,Elenco Ridotto / Esteso"
boolean focusrectangle = false
end type

type rb_stampa_elenco from radiobutton within w_clienti_l
boolean visible = false
integer x = 361
integer y = 1384
integer width = 759
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217735
long backcolor = 31326173
string text = "stampa come in elenco"
boolean checked = true
end type

type rb_stampa_completa from radiobutton within w_clienti_l
boolean visible = false
integer x = 361
integer y = 1480
integer width = 759
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 134217735
long backcolor = 31326173
string text = "stampa completa"
end type

type cb_stampa_ok from commandbutton within w_clienti_l
boolean visible = false
integer x = 416
integer y = 1608
integer width = 201
integer height = 72
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;//
long k_num_riga, k_riga
string k_stampa, k_rag_soc, k_tipo
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

gb_stampa.visible = false
rb_stampa_elenco.visible = false
rb_stampa_completa.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false


   k_stampa = "Elenco Anagrafiche "
//	if ddlb_elenco.text = "Rubrica" then
//		dw_dett_0.dataobject = "d_clienti_l_telef"
//		k_stampa = "Anagrafiche : Rubrica telefonica"
//	else
	dw_dett_0.dataobject = "d_clienti_l_1"
//		k_stampa = "Anagrafiche : Completa"
//	end if

if rb_stampa_completa.checked then

//=== Posiziono la dw per farla vedere
	dw_dett_0.height = dw_lista_0.height
	dw_dett_0.width = dw_lista_0.width
	dw_dett_0.x = dw_lista_0.x
	dw_dett_0.y = dw_lista_0.y

	k_rag_soc = trim(ki_st_open_w.key1) + "%"
	k_tipo = trim(ki_st_open_w.key2) 
	if isnull(k_tipo) then
		k_tipo = "*"
	end if

	dw_dett_0.settransobject(sqlca)

	if dw_dett_0.retrieve(k_rag_soc) > 0 then

		dw_dett_0.visible = true
		dw_lista_0.visible = false
		
		kst_stampe.dw_print = dw_dett_0
		kst_stampe.titolo = trim(k_stampa)
		kuf1_data_base.stampa_dw(kst_stampe)
//		kuf1_data_base.stampa_dw(dw_lista_0, k_stampa)
		
		dw_lista_0.visible = true
		dw_dett_0.visible = false
		
	end if
else
	dw_dett_0.dataobject = dw_lista_0.dataobject
	dw_lista_0.rowscopy(1, dw_lista_0.RowCount(), Primary!, dw_dett_0, 1, Primary!)
	kst_stampe.dw_print = dw_dett_0
	kst_stampe.titolo = trim(k_stampa)
	kuf1_data_base.stampa_dw(kst_stampe)
end if



end event

type cb_stampa_annulla from commandbutton within w_clienti_l
boolean visible = false
integer x = 869
integer y = 1608
integer width = 279
integer height = 72
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;//

gb_stampa.visible = false
rb_stampa_elenco.visible = false
rb_stampa_completa.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false


end event

