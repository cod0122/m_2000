$PBExportHeader$w_txt_fpilota_out_sk.srw
forward
global type w_txt_fpilota_out_sk from w_g_tab_3
end type
type hpb_1 from vprogressbar within tabpage_1
end type
type st_barcode_elab from statictext within tabpage_1
end type
type ln_1 from line within tabpage_4
end type
type st_estrai from statictext within w_txt_fpilota_out_sk
end type
type st_importa from statictext within w_txt_fpilota_out_sk
end type
type st_elenco from statictext within w_txt_fpilota_out_sk
end type
end forward

global type w_txt_fpilota_out_sk from w_g_tab_3
boolean visible = true
integer x = 155
integer y = 172
integer width = 3296
integer height = 1960
string title = "Importa / Chiude Lavorazioni "
st_estrai st_estrai
st_importa st_importa
st_elenco st_elenco
end type
global w_txt_fpilota_out_sk w_txt_fpilota_out_sk

type variables
//
boolean ki_tasto_interrompi=false
boolean ki_fine_ciclo=false
//datastore kdsi_elenco
datawindow kdwi_appo
boolean Ki_estrazione_eseguita=false
boolean Ki_FLAG_MODALITA_F_AUTORIZZATO_ok=false



end variables

forward prototypes
protected subroutine inizializza_1 ()
protected subroutine stampa ()
protected function integer ritorna (string k_titolo)
private subroutine attiva_disattiva_da_importare (integer k_tipo)
public subroutine apri_sottowindow (datawindow kdw_1, datastore kds_1, string k_nome, long k_riga)
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_tasti ()
protected subroutine importa_start ()
protected subroutine estrae_start ()
private subroutine imposta_elenco ()
private subroutine importa_txt_fpilota_out ()
private subroutine estrae_txt_fpilota_out ()
protected function string inizializza ()
end prototypes

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
////
//string k_scelta
//long k_clie_1, k_riga
//int k_err_ins, k_rc=0
//string k_dist, k_tipo 
//date k_data_da, k_data_a, k_data_st, k_data_fatt_da, k_data_fatt_a 
//string k_codice_attuale, k_codice_prec
//
//	
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
//	k_tipo = tab_1.tabpage_1.dw_1.getitemstring(1, "banca") //Mandante
//	k_clie_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "clie_1") //Mandante
//	k_dist = tab_1.tabpage_1.dw_1.getitemstring(1, "dist") //dist
//	k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") //data ricev da
//	k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a") //data ricev da
//	k_data_fatt_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_da") //data fatt da
//	k_data_fatt_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_fatt_a") //data fatt da
//	k_data_st = date("01/01/1900")
//
//	ki_st_open_w.key1 = trim(k_tipo) //codice banca
//	ki_st_open_w.key2 = trim(k_dist) //tipo distinta
//	ki_st_open_w.key3 = string(k_data_da,"dd/mm/yyyy") //data scadenza da
//	ki_st_open_w.key4 = string(k_data_a,"dd/mm/yyyy") //data scadenza a
//	ki_st_open_w.key5 = string(k_clie_1,"#####") //Fatturato
//
//
////--- Acchiappo i codice della RETRIEVE per evitare eventalmente la rilettura
//if not isnull(tab_1.tabpage_2.st_2_retrieve.Text) then
//	k_codice_prec = tab_1.tabpage_2.st_2_retrieve.Text
//else
//	k_codice_prec = " "
//end if
//
//if isnull(k_data_da) or k_data_da = date(0) then
//	k_data_da = date("01/01/1900")
//end if
//if isnull(k_data_a) or k_data_a = date(0) or k_data_a = date("01/01/1900") then
//	k_data_a = date("01/01/9999")
//end if
//if isnull(k_data_fatt_da) or k_data_fatt_da = date(0) then
//	k_data_fatt_da = date("01/01/1900")
//end if
//if isnull(k_data_fatt_a) or k_data_fatt_a = date(0) or k_data_fatt_a = date("01/01/1900") then
//	k_data_fatt_a = date("01/01/9999")
//end if
//
//if isnull(k_dist) or len(trim(k_dist)) = 0 then
//	k_dist = "*"
//end if
//if isnull(k_clie_1) then
//	k_clie_1 = 0
//end if
//if isnull(k_tipo) or len(trim(k_tipo)) = 0 then
//	k_tipo = "*"
//end if
//
//k_codice_attuale = trim(k_tipo) + trim(k_dist) &


//			   	    + trim(string(k_clie_1)) &
//						 + trim(string(k_data_fatt_da, "ddmmyy")) + trim(string(k_data_fatt_a, "ddmmyy")) &
//						 + trim(string(k_data_da, "ddmmyy")) + trim(string(k_data_a, "ddmmyy")) 
//
////=== Forza valore Codice composto per ricordarlo per le prossime richieste
//tab_1.tabpage_2.st_2_retrieve.Text = k_codice_attuale
//
//if k_codice_attuale <> k_codice_prec then
//
////=== Controllo date
//	if k_data_a < k_data_da then
//		messagebox("Operazione non eseguita", &
//					"La data di fine periodo e' minore di quela di inizio")
//
//	else
//		tab_1.tabpage_2.dw_2.retrieve(  &
//												k_tipo, &
//												k_dist, &
//												k_data_da, &
//												k_data_a, &
//												k_clie_1, &
//												" ", &
//												k_data_st, &
//												"S", &
//												k_data_fatt_da, &
//												k_data_fatt_a &
//												)
//
//	end if				
//end if				
//
//attiva_tasti()
////if tab_1.tabpage_2.dw_2.rowcount() = 0 then
////	tab_1.tabpage_2.dw_2.insertrow(0) 
////end if
//
//tab_1.tabpage_2.dw_2.setfocus()
//	
//	
//
end subroutine

protected subroutine stampa ();//
if tab_1.selectedtab = 4 then
	tab_1.tabpage_4.dw_4.tag = "esportato"
end if


//=== Chiamo la routine Stampa dell PARENTE
Super::stampa ( )

end subroutine

protected function integer ritorna (string k_titolo);//
//--- return 0=esci; 2=annulla uscita
//
integer k_return = 0 



//=== Controllo se ho IMPORTATO qualcosa, se si allora vedo se ho gia' eseguito una 
//=== stampa/esportazione se no lancio in autom. la funzione di stampa
if tab_1.tabpage_4.dw_4.rowcount() > 0 and &
   (tab_1.tabpage_4.dw_4.tag <> "esportato" or isnull(tab_1.tabpage_4.dw_4.tag)) then

	messagebox("Nessuna stampa/esportazione Eseguita", &
			  "Prima di chiudere il programma e' necessario Stampare/Esportare~n~r" &
			  +"i Barcode messi automaticamente a 'Fine Lavorazione' " &
			 )
	
	tab_1.SelectedTab = 4	
	
	stampa()
	
	k_return = 2 // non chiude la window

end if


return k_return

end function

private subroutine attiva_disattiva_da_importare (integer k_tipo);//
//--- Attiva e Disattiva il flag da importare nella lista
//--- Parametri Input:
//---                   k_tipo = 0 Disattiva flag
//---                            1 Attiva flag
//
int k_flag
long k_riga
datawindow kdw_1


	
	choose case tab_1.selectedtab 
		case 2
			kdw_1 = tab_1.tabpage_2.dw_2
		case 3
			kdw_1 = tab_1.tabpage_3.dw_3
	end choose	
	
	if isvalid(kdw_1) then
		
		if k_tipo = 0 then
			k_flag = 0
		else
			k_flag = 1
		end if
		
		for k_riga = 1 to kdw_1.rowcount() 
			kdw_1.setitem(k_riga, "importa", k_flag)
		next
		
	end if
	
	

end subroutine

public subroutine apri_sottowindow (datawindow kdw_1, datastore kds_1, string k_nome, long k_riga);//
//
//=== Premuto pulsante nella DW
//
int k_rc
date k_data, k_data_int
long k_num_int
string k_cod_sl_pt, k_barcode
window k_window
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window



if k_nome = "barcode" or k_nome = "b_meca" or k_nome = "b_armo" or k_nome = "b_sl_pt" then
	
//--- popolo il datasore (dw non visuale) per appoggio elenco
	if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
	
	choose case true 

		case k_nome = "barcode"
			k_barcode = kdw_1.getitemstring(k_riga, "barcode")

			kdsi_elenco_output.dataobject = "d_barcode" 
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			k_rc = kdsi_elenco_output.retrieve(k_barcode)
			kst_open_w.key1 = "Scheda Barcode: " + trim(k_barcode)

		case k_nome = "b_meca" 
//--- ricavo la data di partenza della lista
			k_data = kds_1.getitemdate(kds_1.getrow(), "barcode_data")
			k_data = RelativeDate ( k_data, -365 )
			kdsi_elenco_output.dataobject = "d_meca_elenco" 
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			k_rc = kdsi_elenco_output.retrieve(k_data, 0, 0, 0)

			kst_open_w.key1 = "Elenco Riferimenti ancora 'Aperti'"

		case k_nome = "b_armo" 
			k_data_int = kds_1.getitemdate(kds_1.getrow(), "barcode_data_int")
			k_num_int = kds_1.getitemnumber(kds_1.getrow(), "barcode_num_int")
			kdsi_elenco_output.dataobject = "d_armo_elenco" 
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			k_rc = kdsi_elenco_output.retrieve(k_num_int, k_data_int, 0, 0, 0)
			kst_open_w.key1 = "Elenco Articoli Riferimento: " + string(k_num_int, "####0") &
									+ " del " +  + string(k_data_int, "dd/mm/yy")   

		case k_nome = "b_sl_pt" 
			k_cod_sl_pt = kds_1.getitemstring(kds_1.getrow(), "sl_pt_cod_sl_pt")
			kdsi_elenco_output.dataobject = "d_sl_pt" 
			k_rc = kdsi_elenco_output.settransobject ( sqlca )
			k_rc = kdsi_elenco_output.retrieve(k_cod_sl_pt)
			kst_open_w.key1 = "Piano di Trattamento: " + trim(string(k_cod_sl_pt)) 

	end choose

	

	if kdsi_elenco_output.rowcount() > 0 then

		k_window = kuf1_data_base.prendi_win_attiva()
		
//--- chiamare la window di elenco
//
//=== Parametri : 
//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = k_window.title    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window

	else
		
		messagebox("Elenco Dati", &
					"Nessun valore disponibile. ")
		
		
	end if
end if

//
end subroutine

protected subroutine attiva_menu ();//
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
//
//--- Attiva/Dis. Voci di menu
	kG_menu.m_finestra.m_gestione.enable()
	kG_menu.m_finestra.m_gestione.show()
	kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = cb_aggiorna.enabled
	kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
	kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
	kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = cb_cancella.enabled
	kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
//
	kG_menu.m_strumenti.m_fin_gest_libero1.text = st_estrai.text
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
	"Legge dal flusso esterno del Pilota gli 'Esiti dei Trattamenti'   "
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = st_estrai.enabled
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = st_estrai.text
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "VProgressBar!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero2.text = st_importa.text
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
   "Aggiorna in archivio il Fine Lavorazione e Genera l'Attestato (Certificato)  "
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = st_importa.enabled
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = st_importa.text
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Update!"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
	kG_menu.m_strumenti.m_fin_gest_libero3.text = "Attiva 'Importa' su tutta la Lista"
	kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
	"Attivazione massiva dell'indicatore 'Importa' di tutte le righe presenti in Lista   "
	kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.enabled = st_importa.enabled
	if st_estrai.enabled = true and (tab_1.selectedtab <> 2 and  tab_1.selectedtab <> 3) then
		kG_menu.m_strumenti.m_fin_gest_libero3.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero4.text = "Disattiva 'Importa' su tutta la Lista"
	kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
	"Disattivazione massiva dell'indicatore 'Importa' di tutte le righe presenti in Lista   "
	kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.enabled = st_importa.enabled
	if st_estrai.enabled = true and (tab_1.selectedtab <> 2 and  tab_1.selectedtab <> 3) then
		kG_menu.m_strumenti.m_fin_gest_libero4.enabled = false
	end if
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero5.text = st_elenco.text
	kG_menu.m_strumenti.m_fin_gest_libero5.microhelp = &
	"Comprime la consultazione dell'elenco, lasciando i soli dati necessari "
	kG_menu.m_strumenti.m_fin_gest_libero5.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero5.enabled = st_elenco.enabled
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = st_elenco.text
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "PlaceColumn5!"
	kG_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero6.text = "Interrompi Operazione"
	kG_menu.m_strumenti.m_fin_gest_libero6.microhelp = &
	"Interrompi l'operazione in esecuzione "
	kG_menu.m_strumenti.m_fin_gest_libero6.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero6.enabled = ki_tasto_interrompi
	kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = kG_menu.m_strumenti.m_fin_gest_libero6.text
	kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "RetrieveCancel!"
	kG_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
	

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
		estrae_start()

	case "l2"		//Importazione...
		importa_start()

	case "l3"		//attiva flag "importare"
		attiva_disattiva_da_importare(1)

	case "l4"		//disattiva flag "importare"
		attiva_disattiva_da_importare(0)

	case "l5"		//Lista ridotta / estesa
		imposta_elenco()

	case "l6"		//Interrompi Operazione
		ki_fine_ciclo = true

	case else
		super::smista_funz(k_par_in)

end choose
	
end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


cb_ritorna.enabled = true
cb_aggiorna.enabled = false
cb_inserisci.enabled = false
st_estrai.enabled = false
st_importa.enabled = false
st_stampa.enabled = true
//cb_cancella.enabled = true

cb_ritorna.default = false
//st_estrai.default = false
//st_importa.default = false
//cb_cancella.default = false

st_elenco.enabled = false

choose case tab_1.selectedtab 
	case 1
		st_estrai.enabled = true
	case 2, 3
		if tab_1.tabpage_2.dw_2.rowcount() > 0 or tab_1.tabpage_3.dw_3.rowcount() > 0 then
			st_elenco.enabled = true
			if Ki_estrazione_eseguita then
				st_importa.enabled = true
			end if
		end if
	case 4
		if tab_1.tabpage_4.dw_4.rowcount() > 0  then
			st_elenco.enabled = true
		end if
end choose	


if tab_1.tabpage_2.dw_2.rowcount() > 0 then
	tab_1.tabpage_2.enabled = true
else
	tab_1.tabpage_2.enabled = false
end if
if tab_1.tabpage_3.dw_3.rowcount() > 0 then
	tab_1.tabpage_3.enabled = true
else
	tab_1.tabpage_3.enabled = false
end if
if tab_1.tabpage_4.dw_4.rowcount() > 0 then
	tab_1.tabpage_4.enabled = true
else
	tab_1.tabpage_4.enabled = false
end if
	
//--- ripristina la path di lavoro
kuf1_data_base.setta_path_default()
            
attiva_menu()

end subroutine

protected subroutine importa_start ();//
//
string k_codice_attuale
kuf_utility kuf1_utility

	
tab_1.tabpage_1.dw_1.AcceptText ( )
tab_1.tabpage_2.dw_2.AcceptText ( )
tab_1.tabpage_3.dw_3.AcceptText ( )

//--- Vedo se i parametri sono stati modificati
	kuf1_utility = create kuf_utility
	k_codice_attuale = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility
	if k_codice_attuale <> tab_1.tabpage_1.st_1_retrieve.Text then

		messagebox("Operazione non Eseguita", &
					  "Sono stati modificati i Parametri a video, prego~n~r" &
					  + "ripetere l'estrazione o ripristinare i parametri precedenti")

	else

//--- importa
		importa_txt_fpilota_out()

//--- a fine importazione reset del flag per spegnere il bottoncino di immportazione		
		if	trim(tab_1.tabpage_1.dw_1.getitemstring(1, "simulazione")) <> "1" &
		   or isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "simulazione")) then
			Ki_estrazione_eseguita = false
		end if
		
	end if
		
	attiva_tasti()

end subroutine

protected subroutine estrae_start ();//
//
kuf_utility kuf1_utility
string koldpointer

	
	koldpointer = tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer
	tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer = "HourGlass!"
	
	tab_1.tabpage_1.dw_1.AcceptText ( )
	tab_1.tabpage_2.dw_2.AcceptText ( )
	tab_1.tabpage_3.dw_3.AcceptText ( )

	ki_tasto_interrompi = true
	attiva_tasti()

//--- estrae da flusso del pilota i trattamenti 
	estrae_txt_fpilota_out ()

//--- salvo i parametri cosi come sono stati immessi
	kuf1_utility = create kuf_utility
	tab_1.tabpage_1.st_1_retrieve.Text = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility

//=== Salva le righe dei dw "anomalie" e "buoni" e "importati/chiusi" (saveas)
	kdwi_appo.dataobject = tab_1.tabpage_2.dw_2.dataobject 
   kdwi_appo.title = tab_1.tabpage_2.dw_2.title 
	tab_1.tabpage_2.dw_2.RowsCopy(1, &
	                tab_1.tabpage_2.dw_2.RowCount(), Primary!, kdwi_appo, 1, Primary!)
	kuf1_data_base.dw_saveas(trim("fpilota_out_da_importare"), kdwi_appo)
	kuf1_data_base.dw_saveas(trim("fpilota_out_anomalie"), tab_1.tabpage_3.dw_3)
	kuf1_data_base.dw_saveas(trim("fpulota_out_importati"), tab_1.tabpage_4.dw_4)

//--- sistemo le liste da questa dropdownlistbox
	st_elenco.tag = " "
	imposta_elenco()

	ki_tasto_interrompi = false
	Ki_estrazione_eseguita = true
	
	attiva_tasti()

	tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer = koldpointer


end subroutine

private subroutine imposta_elenco ();//
//--- Imposta in lista i campi visible
//
string k_flag
int k_ctr
string k_flag_esponi_gia_lavorato
datawindow kdw_1



	k_flag_esponi_gia_lavorato = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "err_lavorato"))

	for k_ctr = 2 to 4 step 1
		
//--- prelevo la dw attiva
		choose case k_ctr    //tab_1.selectedtab
			case 1
				kdw_1 = tab_1.tabpage_1.dw_1
			case 2
				kdw_1 = tab_1.tabpage_2.dw_2
			case 3
				kdw_1 = tab_1.tabpage_3.dw_3
			case 4
				kdw_1 = tab_1.tabpage_4.dw_4
			case 5
				kdw_1 = tab_1.tabpage_5.dw_5
		end choose
	
//		kdw_1.setredraw(false)
	
		k_flag = "0" //non visibile
	
		kdw_1.Modify("importa.Visible=" + k_flag)
		kdw_1.Modify("num_int.Visible=" + k_flag)
		kdw_1.Modify("data_int.Visible=" + k_flag)
		kdw_1.Modify("colli.Visible=" + k_flag)
		kdw_1.Modify("colli_artr.Visible=" + k_flag)
		kdw_1.Modify("barcode.Visible=" + k_flag)
		kdw_1.Modify("k_ricevente.Visible=" + k_flag)
		kdw_1.Modify("k_cliente.Visible=" + k_flag)
		kdw_1.Modify("dose.Visible=" + k_flag)
		kdw_1.Modify("fila_1.Visible=" + k_flag)
		kdw_1.Modify("fila_1_p.Visible=" + k_flag)
		kdw_1.Modify("fila_2.Visible=" + k_flag)
		kdw_1.Modify("fila_2_p.Visible=" + k_flag)
		kdw_1.Modify("data_ini.Visible=" + k_flag)
		kdw_1.Modify("ora_ini.Visible=" + k_flag)
		kdw_1.Modify("data_fin.Visible=" + k_flag)
		kdw_1.Modify("ora_fin.Visible=" + k_flag)
		kdw_1.Modify("art.Visible=" + k_flag)
		kdw_1.Modify("sl_pt.Visible=" + k_flag)
		kdw_1.Modify("sl_pt_des.Visible=" + k_flag)
		kdw_1.Modify("msg.Visible=" + k_flag)
		kdw_1.Modify("num_certif.Visible=" + k_flag)
		kdw_1.Modify("id_armo.Visible=" + k_flag)
		kdw_1.Modify("pl_barcode.Visible=" + k_flag)
		kdw_1.Modify("id_meca.Visible=" + k_flag)

		kdw_1.Modify("importa_t.Visible=" + k_flag)
		kdw_1.Modify("num_int_t.Visible=" + k_flag)
		kdw_1.Modify("data_int_t.Visible=" + k_flag)
		kdw_1.Modify("colli_t.Visible=" + k_flag)
		kdw_1.Modify("colli_artr_t.Visible=" + k_flag)
		kdw_1.Modify("barcode_t.Visible=" + k_flag)
		kdw_1.Modify("k_ricevente_t.Visible=" + k_flag)
		kdw_1.Modify("k_cliente_t.Visible=" + k_flag)
		kdw_1.Modify("dose_t.Visible=" + k_flag)
		kdw_1.Modify("fila_1_t.Visible=" + k_flag)
		kdw_1.Modify("fila_1_p_t.Visible=" + k_flag)
		kdw_1.Modify("fila_2_t.Visible=" + k_flag)
		kdw_1.Modify("fila_2_p_t.Visible=" + k_flag)
		kdw_1.Modify("data_ini_t.Visible=" + k_flag)
		kdw_1.Modify("ora_ini_t.Visible=" + k_flag)
		kdw_1.Modify("data_fin_t.Visible=" + k_flag)
		kdw_1.Modify("ora_fin_t.Visible=" + k_flag)
		kdw_1.Modify("art_t.Visible=" + k_flag)
		kdw_1.Modify("sl_pt_t.Visible=" + k_flag)
		kdw_1.Modify("sl_pt_des_t.Visible=" + k_flag)
		kdw_1.Modify("msg_t.Visible=" + k_flag)
		kdw_1.Modify("num_certif_t.Visible=" + k_flag)
		kdw_1.Modify("id_armo_t.Visible=" + k_flag)
		kdw_1.Modify("pl_barcode_t.Visible=" + k_flag)
		kdw_1.Modify("id_meca_t.Visible=" + k_flag)

	
		k_flag = "1" // visibile
	
	//=== Rivisualizza i dati in un ordine diverso
		if st_elenco.tag = "estesa" or LenA(trim(st_elenco.tag)) = 0 then //ridotta
		
			st_elenco.tag = "ridotta"
			
			kdw_1.modify("DataWindow.Print.Orientation='2'" ) //--- portrait

			kdw_1.Modify("importa.Visible=" + k_flag)
			kdw_1.Modify("num_int.Visible=" + k_flag)
			kdw_1.Modify("data_int.Visible=" + k_flag)
			kdw_1.Modify("colli.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0" or k_ctr = 4 then
	  			kdw_1.Modify("colli_artr.Visible=" + k_flag)
			end if
			kdw_1.Modify("barcode.Visible=" + k_flag)
			kdw_1.Modify("k_ricevente.Visible=" + k_flag)
			kdw_1.Modify("k_cliente.Visible=" + k_flag)
			kdw_1.Modify("dose.Visible=" + k_flag)
			kdw_1.Modify("fila_1.Visible=" + k_flag)
			kdw_1.Modify("fila_1_p.Visible=" + k_flag)
			kdw_1.Modify("fila_2.Visible=" + k_flag)
			kdw_1.Modify("fila_2_p.Visible=" + k_flag)
			kdw_1.Modify("data_ini.Visible=" + k_flag)
			kdw_1.Modify("data_fin.Visible=" + k_flag)
			kdw_1.Modify("msg.width=840")
			kdw_1.Modify("msg.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("num_certif.Visible=" + k_flag)
			end if
			
			kdw_1.Modify("importa_t.Visible=" + k_flag)
			kdw_1.Modify("num_int_t.Visible=" + k_flag)
			kdw_1.Modify("data_int_t.Visible=" + k_flag)
			kdw_1.Modify("colli_t.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
	  			kdw_1.Modify("colli_artr_t.Visible=" + k_flag)
			end if
			kdw_1.Modify("barcode_t.Visible=" + k_flag)
			kdw_1.Modify("k_ricevente_t.Visible=" + k_flag)
			kdw_1.Modify("k_cliente_t.Visible=" + k_flag)
			kdw_1.Modify("dose_t.Visible=" + k_flag)
			kdw_1.Modify("fila_1_t.Visible=" + k_flag)
			kdw_1.Modify("fila_1_p_t.Visible=" + k_flag)
			kdw_1.Modify("fila_2_t.Visible=" + k_flag)
			kdw_1.Modify("fila_2_p_t.Visible=" + k_flag)
			kdw_1.Modify("data_ini_t.Visible=" + k_flag)
			kdw_1.Modify("data_fin_t.Visible=" + k_flag)
			kdw_1.Modify("msg_t.width=840")
			kdw_1.Modify("msg_t.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("num_certif_t.Visible=" + k_flag)
			end if
	
		else

			st_elenco.tag = "estesa"
		
			kdw_1.modify("DataWindow.Print.Orientation='1'" ) //--- landscape
			
			kdw_1.Modify("importa.Visible=" + k_flag)
			kdw_1.Modify("num_int.Visible=" + k_flag)
			kdw_1.Modify("data_int.Visible=" + k_flag)
			kdw_1.Modify("colli.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("colli_artr.Visible=" + k_flag)
			end if
			kdw_1.Modify("barcode.Visible=" + k_flag)
			kdw_1.Modify("k_ricevente.Visible=" + k_flag)
			kdw_1.Modify("k_cliente.Visible=" + k_flag)
			kdw_1.Modify("dose.Visible=" + k_flag)
			kdw_1.Modify("fila_1.Visible=" + k_flag)
			kdw_1.Modify("fila_1_p.Visible=" + k_flag)
			kdw_1.Modify("fila_2.Visible=" + k_flag)
			kdw_1.Modify("fila_2_p.Visible=" + k_flag)
			kdw_1.Modify("data_ini.Visible=" + k_flag)
			kdw_1.Modify("ora_ini.Visible=" + k_flag)
			kdw_1.Modify("data_fin.Visible=" + k_flag)
			kdw_1.Modify("ora_fin.Visible=" + k_flag)
			kdw_1.Modify("art.Visible=" + k_flag)
			kdw_1.Modify("sl_pt.Visible=" + k_flag)
			kdw_1.Modify("sl_pt_des.Visible=" + k_flag)
			kdw_1.Modify("msg.width=3000") 
			kdw_1.Modify("msg.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("num_certif.Visible=" + k_flag)
			end if
			kdw_1.Modify("id_armo.Visible=" + k_flag)
			kdw_1.Modify("pl_barcode.Visible=" + k_flag)
			kdw_1.Modify("id_meca.Visible=" + k_flag)
		
			kdw_1.Modify("importa_t.Visible=" + k_flag)
			kdw_1.Modify("num_int_t.Visible=" + k_flag)
			kdw_1.Modify("data_int_t.Visible=" + k_flag)
			kdw_1.Modify("colli_t.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("colli_artr_t.Visible=" + k_flag)
			end if
			kdw_1.Modify("barcode_t.Visible=" + k_flag)
			kdw_1.Modify("k_ricevente_t.Visible=" + k_flag)
			kdw_1.Modify("k_cliente_t.Visible=" + k_flag)
			kdw_1.Modify("dose_t.Visible=" + k_flag)
			kdw_1.Modify("fila_1_t.Visible=" + k_flag)
			kdw_1.Modify("fila_1_p_t.Visible=" + k_flag)
			kdw_1.Modify("fila_2_t.Visible=" + k_flag)
			kdw_1.Modify("fila_2_p_t.Visible=" + k_flag)
			kdw_1.Modify("data_ini_t.Visible=" + k_flag)
			kdw_1.Modify("ora_ini_t.Visible=" + k_flag)
			kdw_1.Modify("data_fin_t.Visible=" + k_flag)
			kdw_1.Modify("ora_fin_t.Visible=" + k_flag)
			kdw_1.Modify("art_t.Visible=" + k_flag)
			kdw_1.Modify("sl_pt_t.Visible=" + k_flag)
			kdw_1.Modify("sl_pt_des_t.Visible=" + k_flag)
			kdw_1.Modify("msg_t.width=3500") 
			kdw_1.Modify("msg_t.Visible=" + k_flag)
			if k_flag_esponi_gia_lavorato = "0"  or k_ctr = 4 then
				kdw_1.Modify("num_certif_t.Visible=" + k_flag)
			end if
			kdw_1.Modify("id_armo_t.Visible=" + k_flag)
			kdw_1.Modify("pl_barcode_t.Visible=" + k_flag)
			kdw_1.Modify("id_meca_t.Visible=" + k_flag)
		end if
	
	next

//	kdw_1.setredraw(true)
	
end subroutine

private subroutine importa_txt_fpilota_out ();//---
//--- Importa record chidendo le Lavorazioni
//---
//--- k_errore: 2=interrotto da utente/dati insuff 1=errore programma 
//
string k_record, k_rc
integer k_errore=0, k_hpb_ctr_old, k_hpb_ctr
string k_errore_txt=" ", k_note, k_simulazione, k_path
long k_id_armo=0
long k_nr_rec=0, k_riga=0, k_righe=0, k_riga_tot=0, k_riga_err=0, k_riga_impo=0
long k_riga_impo_anomalie=0, k_riga_parz=0
date k_data_ultima, k_data_ultima_corretti=date(0), k_data_ultima_anomalie=date(0), k_data_fin, k_data_ini
pointer kpointer_old
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
kuf_base kuf1_base
kuf_certif kuf1_certif
kuf_armo kuf1_armo
kuf_sv_skedula kuf1_sv_skedula
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota
st_tab_meca kst_tab_meca




//=== Puntatore Cursore da attesa.....
	kpointer_old = SetPointer(HourGlass!)
	
	k_errore = 0
	k_riga_err = 0
	k_riga_impo = 0
	k_riga_impo_anomalie = 0
	k_riga_parz = 0
	k_riga_tot = tab_1.tabpage_2.dw_2.rowcount() + tab_1.tabpage_3.dw_3.rowcount()
	tab_1.tabpage_1.hpb_1.setrange(0, 1)
	tab_1.tabpage_1.hpb_1.setstep = 1
	tab_1.tabpage_1.hpb_1.position = 0
	k_hpb_ctr = 0
	k_hpb_ctr_old = 0
	
	kuf1_artr = create kuf_artr
	kuf1_barcode = create kuf_barcode
	kuf1_certif = create kuf_certif
	kuf1_armo = create kuf_armo
	

//14-7-05 --- devo trovare la data da mettere come inizio estrazione 
	k_data_ultima = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da") 
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		k_data_ultima_corretti = tab_1.tabpage_2.dw_2.getitemdate(tab_1.tabpage_2.dw_2.rowcount(), "data_ini") 
	else
		setnull(k_data_ultima_corretti)
	end if
	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
		k_data_ultima_anomalie = tab_1.tabpage_3.dw_3.getitemdate(tab_1.tabpage_3.dw_3.rowcount(), "data_ini") 
	else
		setnull(k_data_ultima_anomalie)
	end if
	if not isnull(k_data_ultima_corretti) or not isnull(k_data_ultima_anomalie) then
		
		if isnull(k_data_ultima_corretti) then
			k_data_ultima = k_data_ultima_anomalie 
		else
			if isnull(k_data_ultima_anomalie) then
				k_data_ultima = k_data_ultima_corretti 
			else
				if k_data_ultima_anomalie > k_data_ultima_corretti then
					k_data_ultima = k_data_ultima_corretti 
				else
					k_data_ultima = k_data_ultima_anomalie 
				end if
			end if
		end if
	end if


	k_simulazione = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "simulazione"))
	if isnull(k_simulazione) then
		k_simulazione = "0"
	end if


//--- Importa dal Tab 2 ("da importare")
	k_righe = tab_1.tabpage_2.dw_2.rowcount() 
	for k_riga = k_righe to 1 step -1

//--- calcolino per HProgressBar		
		if k_riga_parz <= k_riga_tot then
			k_riga_parz = k_riga_parz + k_riga
			k_hpb_ctr = int(k_riga_parz * (1000 / k_riga_tot))		
			if k_hpb_ctr > k_hpb_ctr_old then
				k_hpb_ctr_old = k_hpb_ctr
				tab_1.tabpage_1.hpb_1.StepIt ( )
			end if
		end if

		kst_esito.esito = "0"

//--- Solo flag di importazione attivato
		if tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "importa") = 1 then 
			
			k_id_armo = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_armo") 
			k_data_fin = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_fin")
			k_data_ini = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_ini")
			k_note = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "msg")

//--- Per tentare di importare le Lavorazioni c'e' bisogno del ID_ARMO
			if k_id_armo = 0 or isnull(k_id_armo) then
				k_riga_err++
			else
				
//--- Data di fine lavorazione su Barcode
				kst_tab_barcode = kst_tab_barcode_vuota
				kst_tab_barcode.barcode = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "barcode") 
				//kst_tab_barcode.lav_dose = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "dose") 
				kst_tab_barcode.lav_fila_1 = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "fila_1") 
				kst_tab_barcode.lav_fila_2 = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "fila_2") 
				kst_tab_barcode.lav_fila_1p = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "fila_1_p") 
				kst_tab_barcode.lav_fila_2p = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "fila_2_p") 
				kst_tab_barcode.ora_lav_ini = tab_1.tabpage_2.dw_2.getitemtime(k_riga, "ora_ini") 
				kst_tab_barcode.ora_lav_fin = tab_1.tabpage_2.dw_2.getitemtime(k_riga, "ora_fin") 
				kst_tab_barcode.id_meca = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_meca") 
				
				kst_tab_barcode.id_armo = k_id_armo 
				kst_tab_barcode.err_lav_fin = "0"
				kst_tab_barcode.note_lav_fin = k_note 
				kst_tab_barcode.data_lav_ini = k_data_ini 
				kst_tab_barcode.data_lav_fin = k_data_fin 

//--- se elaborazione NO di simulazione...
            kst_esito.esito = "0" 
				if k_simulazione <> "1" then

               kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
				   kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini_fin")

				end if

				if kst_esito.esito = "1" then //--- errore grave
					k_errore = 1
					k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_riga_err++
				end if

//--- Chiude lavorazione del Barcode su ARTR
				if k_errore <> 1 then
					kst_tab_artr = kst_tab_artr_vuota
					kst_tab_artr.id_armo = k_id_armo 
					kst_tab_artr.data_fin = k_data_fin
					kst_tab_artr.pl_barcode = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "pl_barcode")

//--- se elaborazione NO di simulazione...
               kst_esito.esito = "0" 
					if k_simulazione <> "1" then
						
	               kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
						kst_esito = kuf1_artr.chiudi_lavorazione(kst_tab_artr)

					end if

					if kst_esito.esito <> "0" then
						k_errore = 1
						k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_riga_err++
					end if
				end if

//--- 
				if k_errore <> 1 then

					kst_tab_artr.num_certif = 0

//--- se elaborazione NO di simulazione...
					kst_esito.esito = "0" 
					if k_simulazione <> "1" then

//--- Crea ATTESTATO su ARTR - ritorna il num certificato
	               kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
						kst_esito = kuf1_artr.crea_attestato_dettaglio(kst_tab_artr)
							
////--- Crea ATTESTATO su CERTIF
//						if trim(kst_esito.esito) = "0" or trim(kst_esito.esito) = "3" then
//							kst_tab_certif.num_certif = kst_tab_artr.num_certif
//		               kst_tab_certif.st_tab_g_0.esegui_commit = "N" 
//							kst_esito = kuf1_certif.crea_attestato(kst_tab_certif)
//						end if
	
					end if
						
					if kst_esito.esito <> "0" then
//							rollback using sqlca;
						k_errore = 1
						k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_riga_err++
					end if
					
				end if

							
//--- se elaborazione NO di simulazione...
				if k_simulazione <> "1" then

//--- OK o ERRORE (=1) ?
					if k_errore = 1 then
//--- Ripristino vecchi dati su DB
						rollback using sqlca;
					else
//--- consolido su DB
						commit using sqlca;
					end if
					
				end if
				
				if k_errore <> 1 then

//--- provo a chiudere lavorazione sul Lotto MECA
//--- se elaborazione NO di simulazione...
               kst_esito.esito = "0" 
					if k_simulazione <> "1" then
						
						kst_tab_meca.id = kst_tab_barcode.id_meca
						kst_tab_meca.data_lav_fin = k_data_fin
						kst_esito = kuf1_armo.chiudi_lavorazione(kst_tab_meca)

						if kst_esito.esito <> "0" then
							k_errore = 1
							k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
							k_riga_err++
						end if
					end if

					tab_1.tabpage_2.dw_2.setitem(k_riga, "num_certif", kst_tab_artr.num_certif)

//--- salvo l'ultima data piu' alta per l'archivio azienda
//14-7-05					if k_data_ultima < tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_ini") then
//14-7-05						k_data_ultima = tab_1.tabpage_2.dw_2.getitemdate(k_riga, "data_ini") 
//14-7-05					end if

//--- copio la riga aggiornata nel tab degli importati e la cancello dal tab da importare
					k_riga_impo++
					tab_1.tabpage_2.dw_2.RowsCopy(k_riga, k_riga, Primary!, &
								tab_1.tabpage_4.dw_4, tab_1.tabpage_4.dw_4.rowcount()+1, Primary!)
					tab_1.tabpage_2.dw_2.deleterow(k_riga)

//--- se l'ultima colli entrati <> a colli trattati allora Riferimento Aperto
					tab_1.tabpage_4.dw_4.setitem(tab_1.tabpage_4.dw_4.rowcount(), "colli_artr", kst_tab_artr.colli ) //kst_tab_certif.colli ) 
					if kst_tab_artr.colli  <> tab_1.tabpage_4.dw_4.getitemnumber(tab_1.tabpage_4.dw_4.rowcount(), "colli") then
						tab_1.tabpage_4.dw_4.setitem(tab_1.tabpage_4.dw_4.rowcount(), "importa", 0) 
					end if
				end if
			end if		
		end if
		
		k_errore = 0

	next
		

//--- Importa dal Tab 3 ("anomalie")
	k_righe = tab_1.tabpage_3.dw_3.rowcount()
	for k_riga = k_righe to 1 step -1

//--- calcolino per HProgressBar		
		if k_riga_parz <= k_riga_tot then
			k_riga_parz = k_riga_parz + k_riga
			k_hpb_ctr = int(k_riga_parz * (1000 / k_riga_tot))		
			if k_hpb_ctr > k_hpb_ctr_old then
				k_hpb_ctr_old = k_hpb_ctr
				tab_1.tabpage_1.hpb_1.StepIt ( )
			end if
		end if
		
		kst_esito.esito = "0"

//--- Solo flag di importazione attivato
		if tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "importa") = 1 then 
			
			k_id_armo = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_armo") 
			k_data_ini = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_ini")
			k_data_fin = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_fin")
			k_note = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "msg")
	
//--- Per tentare di importare le Lavorazioni c'e' bisogno del ID_ARMO
			if k_id_armo = 0 or isnull(k_id_armo) then
				k_riga_err++
			else
				
				
//--- Data di fine lavorazione su Barcode
				kst_tab_barcode = kst_tab_barcode_vuota

				kst_tab_barcode.barcode = tab_1.tabpage_3.dw_3.getitemstring(k_riga, "barcode") 
				//kst_tab_barcode.lav_dose = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "dose") 
				kst_tab_barcode.lav_fila_1 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "fila_1") 
				kst_tab_barcode.lav_fila_2 = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "fila_2") 
				kst_tab_barcode.lav_fila_1p = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "fila_1_p") 
				kst_tab_barcode.lav_fila_2p = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "fila_2_p") 
				kst_tab_barcode.ora_lav_ini = tab_1.tabpage_3.dw_3.getitemtime(k_riga, "ora_ini") 
				kst_tab_barcode.ora_lav_fin = tab_1.tabpage_3.dw_3.getitemtime(k_riga, "ora_fin") 
				kst_tab_barcode.id_meca = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "id_meca") 
				
				kst_tab_barcode.id_armo = k_id_armo 
				kst_tab_barcode.err_lav_fin = "1"
				kst_tab_barcode.note_lav_fin = k_note 
				kst_tab_barcode.data_lav_ini = k_data_ini 
				kst_tab_barcode.data_lav_fin = k_data_fin 

//--- se elaborazione NO di simulazione...						
            kst_esito.esito = "0" 
				if k_simulazione <> "1" then
               kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
					kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini_fin")

				end if

				if kst_esito.esito = "1" then //--- errore grave
					k_errore = 1
					k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
					k_riga_err++
				end if
	
//--- Aggiorna flag di errore su MECA
				if k_errore <> 1 then
					if kst_tab_meca.id <> kst_tab_barcode.id_meca then
						kst_tab_meca.id = kst_tab_barcode.id_meca 
						kst_tab_meca.err_lav_fin = kst_tab_barcode.err_lav_fin 
					
//--- se elaborazione NO di simulazione
						kst_esito.esito = "0" 
						if k_simulazione <> "1" then
							kst_tab_meca.st_tab_g_0.esegui_commit = "N" 
							kst_esito = kuf1_armo.setta_errore_lav(kst_tab_meca)
						end if
	
						if kst_esito.esito <> "0" then
							k_errore = 1
							k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
							k_riga_err++
						end if
					end if
				end if
				
//--- Chiude lavorazione del Barcode su ARTR
				if k_errore <> 1 then
					kst_tab_artr = kst_tab_artr_vuota
					kst_tab_artr.id_armo = k_id_armo 
					kst_tab_artr.data_fin = k_data_fin 
					kst_tab_artr.pl_barcode = tab_1.tabpage_3.dw_3.getitemnumber(k_riga, "pl_barcode")
					
//--- se elaborazione NO di simulazione
               kst_esito.esito = "0" 
					if k_simulazione <> "1" then
	               kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
						kst_esito = kuf1_artr.chiudi_lavorazione(kst_tab_artr)
					end if

					if kst_esito.esito <> "0" then
						k_errore = 1
						k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_riga_err++
					end if
				end if

				if k_errore <> 1 then

					kst_tab_artr.num_certif = 0

//--- se elaborazione NO di simulazione...
					kst_esito.esito = "0" 
					if k_simulazione <> "1" then

//--- Crea ATTESTATO su ARTR - ritorna il num certificato
	               kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
						kst_esito = kuf1_artr.crea_attestato_dettaglio(kst_tab_artr)

					end if

					if kst_esito.esito <> "0" then
						k_errore = 1
						k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
						k_riga_err++
					end if
				end if

//--- se elaborazione NO di simulazione...
				if k_simulazione <> "1" then

//--- OK o ERRORE (=1) ?
					if k_errore = 1 then
//--- Ripristino vecchi dati su DB
						rollback using sqlca;
					else
//--- consolido su DB
						commit using sqlca;
					end if
					
				end if

//--- se tutto OK					
				if k_errore <> 1 then

//--- provo a chiudere lavorazione sul Lotto MECA
//--- se elaborazione NO di simulazione...
               kst_esito.esito = "0" 
					if k_simulazione <> "1" then
						
						kst_tab_meca.id = kst_tab_barcode.id_meca
						kst_tab_meca.data_lav_fin = k_data_fin
						kst_esito = kuf1_armo.chiudi_lavorazione(kst_tab_meca)

						if kst_esito.esito <> "0" then
							k_errore = 1
							k_errore_txt = k_errore_txt + trim(kst_esito.sqlerrtext) + "~n~r" 
							k_riga_err++
						end if
					end if

					tab_1.tabpage_3.dw_3.setitem(k_riga, "num_certif", kst_tab_artr.num_certif)

//--- salvo l'ultima data piu' alta per l'archivio azienda
//14-7-05					if k_data_ultima < tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_ini") then
//14-7-05			k_data_ultima = tab_1.tabpage_3.dw_3.getitemdate(k_riga, "data_ini") 
//14-7-05		end if
						
//--- copio la riga aggiornata nel tab degli importati e la cancello dal tab da importare
					k_riga_impo_anomalie++
					tab_1.tabpage_3.dw_3.RowsCopy(k_riga, k_riga, Primary!, &
								tab_1.tabpage_4.dw_4, tab_1.tabpage_4.dw_4.rowcount()+1, Primary!)
					tab_1.tabpage_3.dw_3.deleterow(k_riga)

//--- se l'ultima colli entrati <> a colli trattati allora Riferimento Aperto
					tab_1.tabpage_4.dw_4.setitem(tab_1.tabpage_4.dw_4.rowcount(), "colli_artr", kst_tab_artr.colli ) 
					if kst_tab_artr.colli  <> tab_1.tabpage_4.dw_4.getitemnumber(tab_1.tabpage_4.dw_4.rowcount(), "colli") then
						tab_1.tabpage_4.dw_4.setitem(tab_1.tabpage_4.dw_4.rowcount(), "importa", 0) 
					end if

				end if
	
			end if			
		end if

		k_errore = 0

	next
		
	destroy kuf1_artr
	destroy kuf1_barcode
	destroy kuf1_armo

	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		tab_1.tabpage_4.dw_4.setsort("num_int a, colli_artr d, barcode a")
		tab_1.tabpage_4.dw_4.sort()

		tab_1.tabpage_4.dw_4.Modify("importa.Protect='1'")
	end if


//--- se elaborazione NO di simulazione...
	if k_simulazione <> "1" then
//--- Aggiorno archivio Azienda con i nuovi dati 
		kuf1_base = create kuf_base
		k_path = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "path"))
		if fileexists (k_path) then
			kst_tab_base.st_tab_g_0.esegui_commit = "S"
			kst_tab_base.key = "arch_pilota_out"
			kst_tab_base.key1 = k_path
			kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
			if kst_esito.esito  = "1" then
				k_errore = 1
				k_errore_txt = k_errore_txt + &
						  "Archivio Azienda: Aggiornamento Nome Cartella del flusso 'Esiti Pilota' fallito:~n~r" &
									+ string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
			end if
		end if
	
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "data_ultima_estrazione_pilota_out"
		kst_tab_base.key1 = string(k_data_ultima)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito  = "1" then
			k_errore = 1
			k_errore_txt = k_errore_txt + &
					  "Archivio Azienda: Aggiornamento Data Fine estrazione dal flusso 'Esiti Pilota' fallito:~n~r" &
									+ string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
		end if
		destroy kuf1_base
	end if

	k_riga_impo = k_riga_impo + k_riga_impo_anomalie
	if k_riga_impo > 0 then
		tab_1.tabpage_4.dw_4.tag = "da esportare "  // flag x indicare di stampare/esportare i dati importati
	end if
	

	SetPointer(kpointer_old)


	if ki_st_open_w.flag_modalita = kkg_flag_modalita_batch then 

		try 
			kuf1_sv_skedula = create kuf_sv_skedula 
			kuf1_sv_skedula.kist_sv_eventi_sked[1] = ki_st_open_w.key12_any
			kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = ""
	
			if LenA(trim(k_errore_txt)) = 0 or isnull(k_errore_txt) then
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = "Elaborazione conclusa correttamente. " &
						+ "Importati " + string(k_riga_impo, "#,###,##0") + " Barcode " & 
						+ "(" + string(k_riga_impo_anomalie, "#,###,##0") + " Anomalie) "
				kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()
			else
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = "Elaborazione Terminata con Errore. " &
						+ "Importati " + string(k_riga_impo, "#,###,##0") + " Barcode " & 
						+ "(" + string(k_riga_impo_anomalie, "#,###,##0") + " Anomalie) "
				kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()
			end if
			destroy kuf1_sv_skedula
			
		catch (uo_exception kuo_exception)
		
		end try
	else
		
		if LenA(trim(k_errore_txt)) = 0 or isnull(k_errore_txt) then
		
			messagebox("Importazione file Pilota riuscita", "Elaborazione conclusa correttamente.~n~r" &
									+ "Barcode a 'Fine Lavorazione': " + string(k_riga_impo, "#,###,##0") + "~n~r" &
									+ "Barcode non importati: " + string(k_riga_err, "#,###,##0") + "~n~r" &
									)
									
									
		else							
			messagebox("Elaborazione Terminata con Errore", &
						  "Riscontrate le seguenti Anomalie:~n~r" &
						  + trim(k_errore_txt)  + "~n~r" &
						  + "Barcode a 'Fine Lavorazione': " + string(k_riga_impo, "#,###,##0") + "~n~r" &
						  + "Barcode non importati: " + string(k_riga_err, "#,###,##0") + "~n~r" &
						  , stopsign! &
						 )
		end if
	end if
	
//--- ripristina la path di lavoro
//	kuf1_data_base.setta_path_default()



end subroutine

private subroutine estrae_txt_fpilota_out ();//---
//--- Estrae da archivio Pilota di out
//---
//--- k_errore: 2=interrotto da utente/dati insuff 1=errore programma 
//
string k_record, k_rc
integer k_filenum, k_errore=0, k_byte, k_nrc, k_hpb_ctr_old, k_hpb_ctr 
string k_errore_txt=" ", k_path, k_barcode_esito_txt=""
string k_cliente, k_ricevente
long k_nr_rec=0, k_riga_ok, k_riga_err, k_sqlcode, k_lung_file, k_byte_letti
long k_num_certif, k_colli_trattati
string k_barcode_esito="0", k_flag_esponi_gia_lavorato
date k_data_da, k_data_a
boolean k_eof=false, k_importa_anomalie_all=false
string koldpointer
//window kwindow_1
pointer oldpointer  // Declares a pointer variable

kuf_fpilota kuf1_fpilota
kuf_armo kuf1_armo
kuf_artr kuf1_artr
kuf_certif kuf1_certif
kuf_sl_pt kuf1_sl_pt
kuf_barcode kuf1_barcode
kuf_clienti kuf1_clienti
kuf_base kuf1_base
kuf_utility kuf1_utility

st_txt_fpilota_out kst_txt_fpilota_out
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota
st_tab_sl_pt kst_tab_sl_pt, kst_tab_sl_pt_vuota
st_tab_armo kst_tab_armo, kst1_tab_armo, kst_tab_armo_vuota
st_tab_meca kst_tab_meca, kst_tab_meca_vuota
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_certif kst_tab_certif, kst_tab_certif_vuota
st_tab_clienti kst_tab_clienti, kst_tab_clienti_vuota
st_esito kst_esito

ki_fine_ciclo=false

//=== Puntatore Cursore da attesa.....
//	oldpointer = setPointer(HourGlass!) 
//	kwindow_1 = kuf1_data_base.prendi_win_attiva()
	koldpointer = tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer
	tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer = "HourGlass!"

	tab_1.tabpage_1.hpb_1.smoothscroll = true
	tab_1.tabpage_1.hpb_1.setrange(0,1000)
	tab_1.tabpage_1.hpb_1.setstep = 1
	tab_1.tabpage_1.hpb_1.position = 0
//			tab_1.tabpage_1.hpb_1.visible = true
//			tab_1.SelectTab(2)
	k_hpb_ctr = 0
	k_hpb_ctr_old = 0
	k_barcode_esito_txt=""

	kst_tab_meca.num_int = 0
	k_ricevente = " "
	k_cliente = " "

	k_path = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "path"))
	
	if not fileexists(k_path) then
		k_errore = 2
	end if

	tab_1.tabpage_2.dw_2.setredraw(false)	
	tab_1.tabpage_3.dw_3.setredraw(false)	

	tab_1.tabpage_1.st_barcode_elab.text = "attendere..."
	tab_1.tabpage_1.st_barcode_elab.visible = true

	if k_errore = 0 then
		
		kuf1_fpilota = create kuf_fpilota
		kuf1_barcode = create kuf_barcode
		kuf1_sl_pt = create kuf_sl_pt
		kuf1_armo = create kuf_armo
		kuf1_artr = create kuf_artr
		kuf1_certif = create kuf_certif
		kuf1_clienti = create kuf_clienti
		
		kst_txt_fpilota_out.path = trim(k_path)
		kst_esito = kuf1_fpilota.apri_fpilota_out("1", kst_txt_fpilota_out)
		if kst_esito.esito <> "0" then
			k_errore = 1
			k_errore_txt = trim(kst_esito.sqlerrtext) + "~n~r" &
								+ "(Errore:" + string(kst_esito.sqlcode) + ")"
		else
	
//--- ricavo il periodo di estrazione
			k_data_da = tab_1.tabpage_1.dw_1.getitemdate(1, "data_da")
			if isnull(k_data_da) or k_data_da = date(0) then
				k_data_da = date(0)
			end if
			k_data_a = tab_1.tabpage_1.dw_1.getitemdate(1, "data_a")
			if isnull(k_data_a) or k_data_a = date(0) then
				k_data_a = date("31/12/9999")
			end if
			if k_data_a < k_data_da then
				k_errore = 1
				k_errore_txt = "Dati incongruenti: Data di Inizio maggiore della data di Fine~n~r" 
			end if
	
//--- ricavo lungh. tot del file Esiti Pilota
			k_lung_file = kst_txt_fpilota_out.byte
		
//--- Prima lettura fuori ciclo file Esiti Pilota fino al rec giusto
			do 
				
				k_barcode_esito = "0"
				k_barcode_esito_txt = ""
				
				kst_esito = kuf1_fpilota.leggi_fpilota_out("1", kst_txt_fpilota_out)
				choose case kst_esito.esito
					case "0"
						k_barcode_esito = "0"
					case "1"
						k_errore = 1
						k_errore_txt = trim(kst_esito.sqlerrtext) + "~n~r" &
										+ "(Errore:" + string(kst_esito.sqlcode) + ")"
					case "100"
						k_barcode_esito = "100" // EOF
						ki_fine_ciclo = true
					case "2"
						k_barcode_esito = "2" // errore formale
						k_barcode_esito_txt = trim(kst_esito.sqlerrtext) + " - "
					case "3"
						k_barcode_esito = "3" // rec vuoto
					
				end choose

//--- calcolino per HProgressBar		
				if k_byte_letti <= k_lung_file then
					k_byte_letti = k_byte_letti + kst_txt_fpilota_out.byte
					k_hpb_ctr = int(k_byte_letti * (1000 / k_lung_file))		
					if k_hpb_ctr > k_hpb_ctr_old then
						k_hpb_ctr_old = k_hpb_ctr
						tab_1.tabpage_1.hpb_1.StepIt ( )
					end if
				end if


//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
				yield ()
			

		   loop while not ki_fine_ciclo and k_errore = 0 &
			           and (kst_txt_fpilota_out.data_fin < k_data_da or kst_esito.esito = "2")

			
		end if


//--- Inizializza
		if not ki_fine_ciclo and k_errore = 0 &
			and kst_txt_fpilota_out.data_ini <= k_data_a then
			k_riga_ok = 0
			k_riga_err = 0
			tab_1.tabpage_2.dw_2.reset()
			tab_1.tabpage_3.dw_3.reset()
		end if

//--- flag se importare o meno tutte le anomalie
		if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "importa_anomalie_all")) = "1" then
			k_importa_anomalie_all = true
		else
			k_importa_anomalie_all = true
		end if
	
		do while not ki_fine_ciclo and k_errore = 0 &
			      and kst_txt_fpilota_out.data_fin <= k_data_a

//--- espone barcode che sta elaborando nella window
			tab_1.tabpage_1.st_barcode_elab.text = trim(kst_txt_fpilota_out.barcode)

//--- legge Barcode x prendere id armo e vede se gia' lavorato
			kst_tab_barcode = kst_tab_barcode_vuota
			kst_tab_barcode.barcode = kst_txt_fpilota_out.barcode
			kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode)
	
//--- se Barcode gia' lavorato allora metto almeno nelle anomalie
			k_flag_esponi_gia_lavorato = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "err_lavorato"))
			if kst_esito.esito = "0" then
				if kst_tab_barcode.data_lav_fin > date(0) then 
					if k_flag_esponi_gia_lavorato = "1" then
						k_barcode_esito = "3"
					else
						k_barcode_esito = "2"
					end if
					k_barcode_esito_txt = "Barcode gia' Lavorato il " + string(kst_tab_barcode.data_lav_fin) &
												 + ". - " + trim(k_barcode_esito_txt)
				end if
			end if


//--- Barcode trovato 			
			if k_barcode_esito <> "3" then 
				
//--- pulizia campi di appoggio
				kst_tab_sl_pt.fila_1 = 0
				kst_tab_sl_pt.fila_2 = 0
				kst_tab_sl_pt.fila_1p = 0
				kst_tab_sl_pt.fila_2p = 0

				if kst_tab_barcode.id_armo > 0 then

//--- legge tab ARMO x prendere cod sl-pt
					kst_tab_armo = kst_tab_armo_vuota
					kst_tab_armo.id_armo = kst_tab_barcode.id_armo
					kst_esito = kuf1_armo.leggi_riga("1", kst_tab_armo)

					if kst_esito.esito = "0" and kst_tab_armo.num_int > 0 then

//--- legge tab MECA x prendere i codici cliente
                  if kst_tab_armo.num_int <> kst_tab_meca.num_int then
							kst_tab_meca = kst_tab_meca_vuota
							kst_tab_meca.num_int = kst_tab_armo.num_int
							kst_tab_meca.data_int = kst_tab_armo.data_int
							kst_esito = kuf1_armo.leggi_testa("1", kst_tab_meca)
//--- legge tab CLIENTI x prendere RICEVENTE e CLIENTE
							if kst_esito.esito = "0" then
								kst_tab_clienti = kst_tab_clienti_vuota
								kst_tab_clienti.codice = kst_tab_meca.clie_2
								kst_esito = kuf1_clienti.leggi(kst_tab_clienti)
								if kst_esito.esito = "0" then
									k_ricevente = trim(kst_tab_clienti.rag_soc_10)  &
									   + "  (" + string(kst_tab_meca.clie_2) + ") "
								else
									k_ricevente = " "
								end if
								kst_tab_clienti = kst_tab_clienti_vuota
								kst_tab_clienti.codice = kst_tab_meca.clie_3
								kst_esito = kuf1_clienti.leggi( kst_tab_clienti)
								if kst_esito.esito = "0" then
									k_cliente = trim(kst_tab_clienti.rag_soc_10) &
									   + "  (" + string(kst_tab_meca.clie_3) + ") "
								else
									k_cliente = " "
								end if
							end if
						end if
	
//--- legge tab ARMO x prendere totale colli del riferimento 
						kst1_tab_armo = kst_tab_armo_vuota
						kst1_tab_armo.num_int = kst_tab_armo.num_int
						kst1_tab_armo.data_int = kst_tab_armo.data_int
						kst_esito = kuf1_armo.leggi_riga("T", kst1_tab_armo)
						if kst_esito.esito <> "0" then
							kst1_tab_armo.colli_2 = 0
						end if
						
//--- legge tab SL PT x prendere cod GIRI FILA
						if not isnull(kst_tab_armo.cod_sl_pt) and &
							LenA(trim(kst_tab_armo.cod_sl_pt)) > 0 then
							
							kst_tab_sl_pt = kst_tab_sl_pt_vuota
							kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt 
							kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
							if kst_esito.esito <> "0" then
								k_barcode_esito = "2"
								k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT non Trovato - " 
							else
								
								if (kst_tab_sl_pt.fila_1 = 0 or isnull(kst_tab_sl_pt.fila_1)) &
									and (kst_tab_sl_pt.fila_2 = 0 or isnull(kst_tab_sl_pt.fila_2)) &
								   and (kst_tab_sl_pt.fila_1p = 0 or isnull(kst_tab_sl_pt.fila_1p)) &
									and (kst_tab_sl_pt.fila_2p = 0 or isnull(kst_tab_sl_pt.fila_2p)) &
									then
									
									k_barcode_esito = "2"
									k_barcode_esito_txt = k_barcode_esito_txt + "Cicli Non Impostati su SL-PT - " 
									
								end if
								
							end if
						else
							k_barcode_esito = "2"
							k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT non Impostato in Entrata (vedi riferimento) - " 
							kst_tab_sl_pt.cod_sl_pt = " "
							kst_tab_sl_pt.descr = " "
						end if
					else
						k_barcode_esito_txt = k_barcode_esito_txt + "Riga Entrata merce non Trovata - " 
						k_cliente = " " 
						k_ricevente = " " 
					end if
					
				else

//--- BARCODE NON TROVATO

					if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "err_barcode")) = "1" then
						k_barcode_esito = "3"
					else
						k_barcode_esito = "2"
					end if
					k_barcode_esito_txt = k_barcode_esito_txt + "Barcode non Trovato - " 
					kst_tab_armo = kst_tab_armo_vuota
					kst_tab_meca = kst_tab_meca_vuota
					kst_tab_clienti = kst_tab_clienti_vuota
					kst_tab_sl_pt = kst_tab_sl_pt_vuota

				end if
				
				
				if kst_esito.esito = "1" then // errore grave SQL
					k_errore = 1
					k_errore_txt = trim(kst_esito.sqlerrtext) + "~n~r" &
										+ "(Errore:" + string(kst_esito.sqlcode) + ")" 
					ki_fine_ciclo = true
				end if
	
//--- controllo valori dei Cicli	del PILOTA con quelli presenti sul BARCODE		
				if k_barcode_esito <> "3" then
					
					if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0  
					if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0  
					if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0  
					if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0  
					if isnull(kst_tab_sl_pt.fila_1) then kst_tab_sl_pt.fila_1 = 0  
					if isnull(kst_tab_sl_pt.fila_2) then kst_tab_sl_pt.fila_2 = 0  
					if isnull(kst_tab_sl_pt.fila_1p) then	kst_tab_sl_pt.fila_1p = 0  
					if isnull(kst_tab_sl_pt.fila_2p) then kst_tab_sl_pt.fila_2p = 0  
					if isnull(kst_txt_fpilota_out.g1_fila_1) then kst_txt_fpilota_out.g1_fila_1 = 0 
					if isnull(kst_txt_fpilota_out.g1_fila_2) then kst_txt_fpilota_out.g1_fila_2 = 0  
					if isnull(kst_txt_fpilota_out.g2_fila_1) then kst_txt_fpilota_out.g2_fila_1 = 0 
					if isnull(kst_txt_fpilota_out.g2_fila_2) then kst_txt_fpilota_out.g2_fila_2 = 0 
					

//--- controllo se cicli impostati almeno sul piano di lavorazione 
					if kst_tab_sl_pt.fila_1 = 0 and kst_tab_barcode.fila_1 = 0 &
					   and kst_tab_sl_pt.fila_2 = 0 and kst_tab_barcode.fila_2 = 0 &
					   and kst_tab_sl_pt.fila_1p = 0 and kst_tab_barcode.fila_1p = 0 &
					   and kst_tab_sl_pt.fila_2p = 0 and kst_tab_barcode.fila_2p = 0 then
						k_barcode_esito = "2"
						k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT e Pian.Lavoraz. senza Cicli - " 
					else

//--- confronto tra cicli pianificati nel barcode con quelli su Sl-PT
						if kst_tab_sl_pt.fila_1 <> kst_tab_barcode.fila_1 then
	                  if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
								k_barcode_esito = "2"
								k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1=" &
														 + trim(string(kst_tab_sl_pt.fila_1)) + ") " &
														 + "e Pian.Lavoraz. (F1=" &
														 + trim(string(kst_tab_barcode.fila_1)) + ") "
							else
//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
								if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
									k_barcode_esito = "2"
									k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1/2=" &
														 + trim(string(kst_tab_sl_pt.fila_1)) + "/" &
														 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
														 + "e Pian.Lavoraz. (F1/2=" &
														 + trim(string(kst_tab_barcode.fila_1)) + "/" &
														 + trim(string(kst_tab_barcode.fila_2)) + ") "
								end if	
							end if	
						end if
						if kst_tab_sl_pt.fila_1p <> kst_tab_barcode.fila_1p then
	                  if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
								k_barcode_esito = "2"
								k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p=" &
														 + trim(string(kst_tab_sl_pt.fila_1p)) + ") " &
														 + "e P.Lavoraz. (F1p=" &
														 + trim(string(kst_tab_barcode.fila_1p)) + ") "
							else
//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
								if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
									k_barcode_esito = "2"
									k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p/2p=" &
														 + trim(string(kst_tab_sl_pt.fila_1p)) + "/" &
														 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
														 + "e Pian.Lavoraz. (F1p/2p=" &
														 + trim(string(kst_tab_barcode.fila_1p)) + "/" &
														 + trim(string(kst_tab_barcode.fila_2p)) + ") "
								end if	
							end if	
						end if
                  if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
							if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
								k_barcode_esito = "2"
								k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F2=" &
															 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
															 + "e P.Lavoraz. (F2=" &
															 + trim(string(kst_tab_barcode.fila_2)) + ") "
							end if
							if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
								k_barcode_esito = "2"
								k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F2p=" &
															 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
															 + "e P.Lavoraz. (F2p=" &
															 + trim(string(kst_tab_barcode.fila_2p)) + ") "
							end if
						end if

//--- Se Barcode senza cicli pianificati le reperisco dal sl-pt
						if kst_tab_barcode.fila_1 = 0 and kst_tab_barcode.fila_2 = 0 &
						   and kst_tab_barcode.fila_1p = 0 and kst_tab_barcode.fila_2p = 0 then
							k_barcode_esito_txt = k_barcode_esito_txt + "Cicli reperiti dal SL-PT - " 
							kst_tab_barcode.fila_1 = kst_tab_sl_pt.fila_1  
							kst_tab_barcode.fila_2 = kst_tab_sl_pt.fila_2 
							kst_tab_barcode.fila_1p = kst_tab_sl_pt.fila_1p  
							kst_tab_barcode.fila_2p = kst_tab_sl_pt.fila_2p 
						end if
					end if
					
//--- Finalmente!! controllo se Cicli trattati uguali a quelli Pianificati	nel barcode	
					if kst_tab_barcode.fila_1 = kst_txt_fpilota_out.g1_fila_1 &
						and kst_tab_barcode.fila_2 = kst_txt_fpilota_out.g1_fila_2  &
					   and kst_tab_barcode.fila_1p = kst_txt_fpilota_out.g2_fila_1 &
						and kst_tab_barcode.fila_2p = kst_txt_fpilota_out.g2_fila_2  &
						then
						
						k_barcode_esito_txt = k_barcode_esito_txt + "Verifica Cicli Corretta. - "
						
//						if kst_tab_sl_pt.fila_1 <> kst_txt_fpilota_out.g2_fila_1 then
//							if k_barcode_esito = "0" then
//								k_barcode_esito = "2"
//							end if
//							k_barcode_esito_txt = k_barcode_esito_txt + "Ciclo Permutato differente (F1" &
//							                      + trim(string(kst_txt_fpilota_out.g2_fila_1)) + ") - " 
//						end if
//						if kst_tab_sl_pt.fila_2 <> kst_txt_fpilota_out.g2_fila_2 then
//							if k_barcode_esito = "0" then
//								k_barcode_esito = "2"
//							end if
//							k_barcode_esito_txt = k_barcode_esito_txt + "Ciclo Permutato differente (F2=" &
//							                      + trim(string(kst_txt_fpilota_out.g2_fila_2)) + ") - "
//						end if
					else
						if k_barcode_esito = "0" then
							k_barcode_esito = "2"
						end if
						
						k_barcode_esito_txt = "Cicli pianificati: F1=" &
													  + string(kst_tab_barcode.fila_1) &
													  + "+" + string(kst_tab_barcode.fila_1p) &
													  + ",  F2=" + string(kst_tab_barcode.fila_2) &
													  + "+" + string(kst_tab_barcode.fila_2p) &
													  + " - " + trim(k_barcode_esito_txt)
					end if
			
//--- controllo se PL presente			
					if isnull(kst_tab_barcode.pl_barcode) or kst_tab_barcode.pl_barcode = 0 then
						if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "err_pl")) = "1" then
							k_barcode_esito = "3"
						else
							k_barcode_esito = "2"
						end if
						k_barcode_esito_txt = "Barcode senza Piano di Lavoro" &
													 + " - " + trim(k_barcode_esito_txt)
					end if
				end if		

				if k_barcode_esito <> "3" then
					k_colli_trattati = 0
					k_num_certif = 0
					if k_flag_esponi_gia_lavorato = "0" then
//--- legge tab ARTR x prendere cod colli trattati 
						kst_tab_artr = kst_tab_artr_vuota
						kst_tab_artr.id_armo = kst_tab_barcode.id_armo
						kst_esito = kuf1_artr.leggi(1, kst_tab_artr)
						k_colli_trattati = kst_tab_artr.colli
						if isnull(k_colli_trattati) then
							k_colli_trattati = 0
						end if

//--- legge tab CERTIF x prendere cod Num. Certif 
						if kst_tab_armo.num_int > 0 then
							kst_tab_certif = kst_tab_certif_vuota
							kst_tab_certif.num_certif = 0
							kst_tab_certif.id_meca = kst_tab_armo.id_meca
							kst_esito = kuf1_certif.leggi(1, kst_tab_certif)
							k_num_certif = kst_tab_certif.num_certif
							if isnull(k_num_certif) then
							   k_num_certif = 0
							end if
						end if
					end if
				end if
				

//--- valori a null non ammessi
				if isnull(kst_tab_meca.id) then kst_tab_meca.id = 0
				if isnull(kst_tab_armo.num_int) then kst_tab_armo.num_int = 0
				if isnull(kst_tab_armo.data_int) then kst_tab_armo.data_int = date(0)
				if isnull(kst_tab_armo.dose) then kst_tab_armo.dose = 0
				if isnull(kst_tab_barcode.id_armo) then kst_tab_barcode.id_armo = 0
				if isnull(kst_tab_armo.art) then kst_tab_armo.art = " "
				if isnull(kst_tab_armo.cod_sl_pt) then kst_tab_armo.cod_sl_pt = " "
				if isnull(kst_tab_sl_pt.descr) then kst_tab_sl_pt.descr = " "
				if isnull(kst_txt_fpilota_out.barcode) then kst_txt_fpilota_out.barcode = " "
				if isnull(k_ricevente) then k_ricevente = " "
				if isnull(k_cliente) then k_cliente = " "
				if isnull(kst1_tab_armo.colli_2) then kst1_tab_armo.colli_2 = 0 
				if isnull(k_colli_trattati) then k_colli_trattati = 0
				if isnull(kst_txt_fpilota_out.g1_fila_1) then kst_txt_fpilota_out.g1_fila_1 = 0
				if isnull(kst_txt_fpilota_out.g1_fila_2) then kst_txt_fpilota_out.g1_fila_2 = 0
				if isnull(kst_txt_fpilota_out.g2_fila_1) then kst_txt_fpilota_out.g2_fila_1 = 0
				if isnull(kst_txt_fpilota_out.g2_fila_2) then kst_txt_fpilota_out.g2_fila_2 = 0
				if isnull(kst_txt_fpilota_out.data_ini) then kst_txt_fpilota_out.data_ini = date(0)
				if isnull(kst_txt_fpilota_out.ora_ini) then kst_txt_fpilota_out.ora_ini = time(0)
				if isnull(kst_txt_fpilota_out.data_fin) then kst_txt_fpilota_out.data_fin = date(0)
				if isnull(kst_txt_fpilota_out.ora_fin) then kst_txt_fpilota_out.ora_fin = time(0) 
				if isnull(kst_tab_barcode.pl_barcode) then kst_tab_barcode.pl_barcode = 0 
				if isnull(trim(k_barcode_esito_txt)) then k_barcode_esito_txt = " "
				if isnull(k_num_certif) then k_num_certif = 0
				
				
				choose case k_barcode_esito
					case "0"
						k_riga_ok++
						tab_1.tabpage_2.dw_2.insertrow(0)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "importa", 1)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "num_int", kst_tab_armo.num_int)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "data_int", kst_tab_armo.data_int)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "dose", kst_tab_armo.dose)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "id_armo", kst_tab_barcode.id_armo)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "art", kst_tab_armo.art)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "sl_pt", kst_tab_armo.cod_sl_pt)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "sl_pt_des", kst_tab_sl_pt.descr)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "barcode", kst_txt_fpilota_out.barcode)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "k_ricevente", k_ricevente)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "k_cliente", k_cliente)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "colli", kst1_tab_armo.colli_2)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "colli_artr", k_colli_trattati)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "fila_1", kst_txt_fpilota_out.g1_fila_1)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "fila_2", kst_txt_fpilota_out.g1_fila_2)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "fila_1_p", kst_txt_fpilota_out.g2_fila_1)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "fila_2_p", kst_txt_fpilota_out.g2_fila_2)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "data_ini", kst_txt_fpilota_out.data_ini)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "ora_ini", kst_txt_fpilota_out.ora_ini)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "data_fin", kst_txt_fpilota_out.data_fin)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "ora_fin", kst_txt_fpilota_out.ora_fin)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "pl_barcode", kst_tab_barcode.pl_barcode)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "msg", trim(k_barcode_esito_txt))
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "num_certif", k_num_certif)
						tab_1.tabpage_2.dw_2.setitem(k_riga_ok, "id_meca", kst_tab_armo.id_meca)
					case "2"
						k_riga_err++
						tab_1.tabpage_3.dw_3.insertrow(0)
//--- Se richiesto di Importare anche tutte le anomalie
						if k_importa_anomalie_all then
							tab_1.tabpage_3.dw_3.setitem(k_riga_err, "importa", 1)
						else
							tab_1.tabpage_3.dw_3.setitem(k_riga_err, "importa", 0)
						end if
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "num_int", kst_tab_armo.num_int)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "data_int", kst_tab_armo.data_int)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "dose", kst_tab_armo.dose)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "id_armo", kst_tab_barcode.id_armo)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "art", kst_tab_armo.art)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "sl_pt", kst_tab_armo.cod_sl_pt)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "sl_pt_des", kst_tab_sl_pt.descr)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "barcode", kst_txt_fpilota_out.barcode)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "k_ricevente", k_ricevente)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "k_cliente", k_cliente)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "colli", kst1_tab_armo.colli_2)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "colli_artr", k_colli_trattati)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "fila_1", kst_txt_fpilota_out.g1_fila_1)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "fila_2", kst_txt_fpilota_out.g1_fila_2)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "fila_1_p", kst_txt_fpilota_out.g2_fila_1)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "fila_2_p", kst_txt_fpilota_out.g2_fila_2)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "data_ini", kst_txt_fpilota_out.data_ini)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "ora_ini", kst_txt_fpilota_out.ora_ini)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "data_fin", kst_txt_fpilota_out.data_fin)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "ora_fin", kst_txt_fpilota_out.ora_fin)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "pl_barcode", kst_tab_barcode.pl_barcode)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "msg", trim(k_barcode_esito_txt))
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "num_certif", k_num_certif)
						tab_1.tabpage_3.dw_3.setitem(k_riga_err, "id_meca", kst_tab_armo.id_meca)
				end choose
				
			end if // Barcode gia' lavorato e non mettere in lista
			
			k_barcode_esito_txt = ""
			k_barcode_esito = "0"

//--- letura prossimo rec
			kst_esito = kuf1_fpilota.leggi_fpilota_out("1", kst_txt_fpilota_out)
			choose case kst_esito.esito
				case "0"
					k_barcode_esito = "0"
				case "1"
					k_errore = 1
					k_errore_txt = trim(kst_esito.sqlerrtext) + "~n~r" &
									+ "(Errore:" + string(kst_esito.sqlcode) + ")"
				case "100"
					k_barcode_esito = "100" // EOF
					ki_fine_ciclo = true
				case "2"
					k_barcode_esito = "2" // errore formale
					k_barcode_esito_txt = trim(kst_esito.sqlerrtext) + " - "
				case "3"
					k_barcode_esito = "3" // rec vuoto
				
			end choose

//--- calcolino per HProgressBar		
			if k_byte_letti <= k_lung_file then
				k_byte_letti = k_byte_letti + kst_txt_fpilota_out.byte
				k_hpb_ctr = int(k_byte_letti * (1000 / k_lung_file))		
				if k_hpb_ctr > k_hpb_ctr_old then
					k_hpb_ctr_old = k_hpb_ctr
					tab_1.tabpage_1.hpb_1.StepIt ( )
				end if
			end if


//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
			yield ()
			
			
		loop					  

		tab_1.tabpage_2.dw_2.sort()
		tab_1.tabpage_3.dw_3.sort()
	
//		tab_1.tabpage_1.hpb_1.visible = false
		
//--- Se richiesto subito Importazione
		if k_errore = 0 then
			if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "importa")) = "1" then
				
				importa_txt_fpilota_out()
				
			end if
		end if

		kst_esito = kuf1_fpilota.chiudi_fpilota_out("1", kst_txt_fpilota_out)

//=== Suona Motivo di fine programma
		kuf1_data_base.post suona_motivo(kkg_suona_motivo_fine, 0)
		
		destroy kuf1_armo
		destroy kuf1_fpilota 
		destroy kuf1_barcode 
		destroy kuf1_sl_pt 
		destroy kuf1_artr
		destroy kuf1_certif
		destroy kuf1_clienti

	end if

//	SetPointer(oldpointer)
	tab_1.tabpage_1.dw_1.Object.DataWindow.Pointer = koldpointer
	
	if k_errore = 0 then
		
//		messagebox("Estrazione file Pilota riuscita", "Elaborazione conclusa correttamente.~n~r" &
//								+ "Fine Lavorazione, Barcode estratti: " + string(k_riga_ok, "#,###,##0") + "~n~r" &
//								+ "Fine Lavorazione, Barcode con anomalie: " + string(k_riga_err, "#,###,##0") &
//								)
	else							
		if k_errore = 2 then
			messagebox("Operazione non Eseguita", &
					  "Percorso nome file di Uscita del Pilota non corretto.~n~r" &
					  + trim(k_path)  &
					 )
		else
			messagebox("Operazione non Eseguita", &
					  "Elaborazione interrotta per il seguente motivo:~n~r" &
					  + trim(k_errore_txt), stopsign!  &
					 )
		end if
		
		
	end if


	attiva_tasti()

	tab_1.tabpage_2.dw_2.setredraw(true)	
	tab_1.tabpage_3.dw_3.setredraw(true)	

	tab_1.tabpage_1.st_barcode_elab.visible = false


//--- ripristina la path di lavoro
	kuf1_data_base.setta_path_default()
	
	

end subroutine

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
long k_riga, k_importa
date k_data_da, k_data_a, k_data_null
string k_path
st_open_w kst_open_w
kuf_base kuf1_base
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility	
kuf_sv_skedula kuf1_sv_skedula


	k_scelta = trim(ki_st_open_w.flag_modalita)


	setnull(k_data_null)

	if tab_1.tabpage_1.dw_1.rowcount() = 0 then

		tab_1.tabpage_1.dw_1.insertrow(0)
		
	end if

   if ki_st_open_w.flag_primo_giro = "S" then 

//--- data estrazione da
		if not isdate(trim(ki_st_open_w.key1)) then
			kuf1_base = create kuf_base
			//--- toglie 2 giorni x sicurezza dalla data in azienda
			k_data_da = relativedate(date(MidA(kuf1_base.prendi_dato_base("data_ultima_estrazione_pilota_out"),2)),-2)
			destroy kuf1_base
		else
			k_data_da = date(trim(ki_st_open_w.key1)) 
		end if
//--- data estrazione a
		if not isdate(trim(ki_st_open_w.key2)) then
			kuf1_base = create kuf_base
			k_data_a = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
			destroy kuf1_base
		else
			k_data_a = date(trim(ki_st_open_w.key2)) 
		end if
//--- Path del file pilota
		if not isnull(ki_st_open_w.key1) or LenA(trim(ki_st_open_w.key1)) = 0 then
			kuf1_base = create kuf_base
			k_path = MidA(kuf1_base.prendi_dato_base("arch_pilota_out"),2)
			destroy kuf1_base
		else
			k_path = trim(ki_st_open_w.key3)
		end if

//--- setto i flag di default della mappa		
		tab_1.tabpage_1.dw_1.setitem(1, "data_da", k_data_da)
		tab_1.tabpage_1.dw_1.setitem(1, "data_a", k_data_a)
		tab_1.tabpage_1.dw_1.setitem(1, "path", k_path)
		tab_1.tabpage_1.dw_1.setitem(1, "importa", "0")
		tab_1.tabpage_1.dw_1.setitem(1, "importa_anomalie_all", "0")
		tab_1.tabpage_1.dw_1.setitem(1, "err_lavorato", "1")
		tab_1.tabpage_1.dw_1.setitem(1, "err_barcode", "0")
		tab_1.tabpage_1.dw_1.setitem(1, "err_pl", "0")
		tab_1.tabpage_1.dw_1.setitem(1, "simulazione", "0")

		tab_1.tabpage_4.dw_4.object.importa_t.text = "Riferim.~n~rChiuso"

	end if

   if ki_st_open_w.flag_primo_giro = "S" then 
////--- sistemo le liste da questa dropdownlistbox
//		st_elenco.tag = " "
//		imposta_elenco()
//--- recupera l'ultima elaborazione eseguita	
//		datawindow = create kdwi_appo.dataobject 
      kdwi_appo = create datawindow
      kdwi_appo.dataobject = tab_1.tabpage_2.dw_2.dataobject 
      kdwi_appo.title = tab_1.tabpage_2.dw_2.title 
		kdwi_appo.settransobject ( sqlca )
		k_importa = kuf1_data_base.dw_importfile(trim("fpilota_out_da_importare"), kdwi_appo)
		if k_importa > 0 then
			kdwi_appo.RowsCopy(1, &
	                kdwi_appo.RowCount(), Primary!, tab_1.tabpage_2.dw_2, 1, Primary!)
		end if
		k_importa = kuf1_data_base.dw_importfile(trim("fpilota_out_anomalie"), tab_1.tabpage_3.dw_3)
		k_importa = kuf1_data_base.dw_importfile(trim("fpilota_out_importati"), tab_1.tabpage_4.dw_4)
	end if
				
	attiva_tasti()
		
	tab_1.tabpage_1.dw_1.setrow(1)
	tab_1.tabpage_1.dw_1.setcolumn("data_da")

//--- abilitazione alla modifica flag di importazione delle anomalie
	Kst_open_w.id_programma = ""
	Kst_open_w.flag_modalita = KKG_FLAG_MODALITA_F_AUTORIZZATO
	kuf1_sicurezza = create kuf_sicurezza 
	Ki_FLAG_MODALITA_F_AUTORIZZATO_ok=kuf1_sicurezza.autorizza_funzione(kst_open_w) 
	destroy kuf1_sicurezza
//--- Inabilita campi alla modifica se non autorizzato
	kuf1_utility = create kuf_utility 
	if not Ki_FLAG_MODALITA_F_AUTORIZZATO_ok then
		kuf1_utility.u_proteggi_dw("3", 0, tab_1.tabpage_3.dw_3)
	end if	
	destroy kuf1_utility


//--- se programma lanciato in modalita' batch...	
	if k_scelta = kkg_flag_modalita_batch then 

		try
			
			kiw_this_window.windowstate = minimized!
			
			kuf1_sv_skedula = create kuf_sv_skedula 
			kuf1_sv_skedula.kist_sv_eventi_sked[1] = ki_st_open_w.key12_any
			kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = " in esecuzione..."
			kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()
			
			tab_1.tabpage_1.dw_1.setitem(1, "importa", "1")
			tab_1.tabpage_1.dw_1.setitem(1, "importa_anomalie_all", "1")
			
			estrae_start()  // esegue l'estrazione + importazione
			
			kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = ""
			if tab_1.tabpage_4.dw_4.rowcount() > 0 then
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = kuf1_sv_skedula.kist_sv_eventi_sked[1].esito &
				+ "importati " &
				+ string(tab_1.tabpage_2.dw_2.rowcount()) + " barcode; importazione conclusa. "
			else
				kuf1_sv_skedula.kist_sv_eventi_sked[1].esito = "nessun barcode da importare; operazione conclusa " 
			end if
				
			kuf1_sv_skedula.kist_sv_eventi_sked[1] = ki_st_open_w.key12_any
			kuf1_sv_skedula.kist_sv_eventi_sked[1].stato = kuf1_sv_skedula.kki_sv_eventi_sked_stato_eseg
			kuf1_sv_skedula.tb_aggiorna_stato_sv_eventi_sked()             
			
			destroy kuf1_sv_skedula
			
			st_ritorna.postevent(clicked!)

		catch (uo_exception kuo_exception)
		
		end try
		
	end if 
	
return "0"


end function

on w_txt_fpilota_out_sk.create
int iCurrent
call super::create
this.st_estrai=create st_estrai
this.st_importa=create st_importa
this.st_elenco=create st_elenco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_estrai
this.Control[iCurrent+2]=this.st_importa
this.Control[iCurrent+3]=this.st_elenco
end on

on w_txt_fpilota_out_sk.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_estrai)
destroy(this.st_importa)
destroy(this.st_elenco)
end on

event u_ricevi_da_elenco(st_open_w kst_open_w);call super::u_ricevi_da_elenco;//
datawindow kdw_1
datastore kds_1

	kds_1 = create datastore
	kds_1 = kst_open_w.key12_any

//---Vedo se c'e' qualche finestrina da aprire
	apri_sottowindow(kdw_1, kds_1, kst_open_w.key5, 0)

end event

event closequery;call super::closequery;//
//--- se operazione in esecuzione non chiudo pgm!
if ki_tasto_interrompi then return 1
end event

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_txt_fpilota_out_sk
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_txt_fpilota_out_sk
integer x = 2889
integer y = 1664
end type

type st_stampa from w_g_tab_3`st_stampa within w_txt_fpilota_out_sk
integer x = 2048
integer y = 1320
end type

type st_ritorna from w_g_tab_3`st_ritorna within w_txt_fpilota_out_sk
integer x = 1719
integer y = 1376
end type

type dw_filtro_0 from w_g_tab_3`dw_filtro_0 within w_txt_fpilota_out_sk
integer x = 1641
integer y = 748
integer taborder = 20
borderstyle borderstyle = styleraised!
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_txt_fpilota_out_sk
integer x = 379
integer y = 1656
integer taborder = 50
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_txt_fpilota_out_sk
integer x = 50
integer y = 1660
integer taborder = 40
end type

event cb_modifica::clicked;call super::clicked;////
////=== Legge il rek dalla DW lista per la modifica
//
//long k_riga
//long k_id_cliente, k_id
//date k_scad, k_data_fatt
//long k_num_fatt, k_cliente
//st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window
//
//
//
//choose case tab_1.selectedtab 
//	case 2
//		k_riga = tab_1.tabpage_2.dw_2.getrow()
//	case 3 
//		k_riga = tab_1.tabpage_3.dw_3.getrow()
//end choose
//
//if k_riga > 0 then
//
//	choose case tab_1.selectedtab 
//		case 2
//			k_id = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "id" ) 
//			k_scad = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "scad" ) 
//			k_data_fatt = tab_1.tabpage_2.dw_2.getitemdate( k_riga, "data_fatt" ) 
//			k_num_fatt = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "num_fatt" ) 
//			k_cliente = tab_1.tabpage_2.dw_2.getitemnumber( k_riga, "clie" ) 
//		case 3
//			k_id = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "id" ) 
//			k_scad = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "scad" ) 
//			k_data_fatt = tab_1.tabpage_3.dw_3.getitemdate( k_riga, "data_fatt" ) 
//			k_num_fatt = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "num_fatt" ) 
//			k_cliente = tab_1.tabpage_3.dw_3.getitemnumber( k_riga, "clie" ) 
//	end choose
//		
////
////=== Parametri : 
////=== struttura st_open_w
////=== dati particolare programma
////
//
//	K_st_open_w.id_programma = "ricevute"
//	K_st_open_w.flag_primo_giro = "S"
//	K_st_open_w.flag_modalita = "mo"
//	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
//	K_st_open_w.flag_leggi_dw = "N"
//	K_st_open_w.flag_cerca_in_lista = " "
//	K_st_open_w.key1 = trim(string(k_id))
////	K_st_open_w.key1 = string(k_scad, "dd/mm/yyyy")
//	K_st_open_w.key2 = string(k_data_fatt, "dd/mm/yyyy")
//	K_st_open_w.key3 = trim(string(k_num_fatt))
//	K_st_open_w.key4 = trim(string(k_cliente))
//	K_st_open_w.flag_where = " "
//	
//
//	kuf1_menu_window = create kuf_menu_window 
//	kuf1_menu_window.open_w_tabelle(k_st_open_w)
//	destroy kuf1_menu_window
//	
//end if
//
//	
//
//
//
//
end event

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_txt_fpilota_out_sk
integer x = 2309
integer y = 1656
integer width = 379
integer taborder = 70
string text = "&Aggiorna"
end type

event cb_aggiorna::clicked;//
string k_codice_attuale
kuf_utility kuf1_utility

	
tab_1.tabpage_1.dw_1.AcceptText ( )
tab_1.tabpage_2.dw_2.AcceptText ( )
tab_1.tabpage_3.dw_3.AcceptText ( )

//--- Vedo se i parametri sono stati modificati
	kuf1_utility = create kuf_utility
	k_codice_attuale = kuf1_utility.u_stringa_campi_dw(1, 1, tab_1.tabpage_1.dw_1)
	destroy kuf1_utility
	if k_codice_attuale <> tab_1.tabpage_1.st_1_retrieve.Text then

		messagebox("Operazione non Eseguita", &
					  "Sono stati modificati i Parametri a video, prego~n~r" &
					  + "ripetere l'estrazione o ripristinare i parametri precedenti")

	else
		importa_txt_fpilota_out()
		
	end if
		
	attiva_tasti()

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_txt_fpilota_out_sk
integer x = 2642
integer y = 1648
integer taborder = 80
end type

event cb_cancella::clicked;call super::clicked;//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
long k_riga, k_seq, k_key




//=== 
choose case tab_1.selectedtab 
	case 2
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			tab_1.tabpage_2.dw_2.deleterow(k_riga)
			if tab_1.tabpage_2.dw_2.rowcount() > 0 then
				tab_1.tabpage_2.dw_2.setfocus()
				tab_1.tabpage_2.dw_2.setrow(k_riga)
				tab_1.tabpage_2.dw_2.setcolumn(1)
			end if
		end if

end choose	


return k_return

end event

type cb_inserisci from w_g_tab_3`cb_inserisci within w_txt_fpilota_out_sk
integer x = 1915
integer y = 1656
integer width = 379
integer taborder = 60
boolean enabled = false
string text = "&Inserisci"
end type

type tab_1 from w_g_tab_3`tab_1 within w_txt_fpilota_out_sk
integer x = 37
integer y = 64
integer width = 3145
integer height = 1568
integer taborder = 30
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3109
integer height = 1440
string text = "Parametri"
hpb_1 hpb_1
st_barcode_elab st_barcode_elab
end type

on tabpage_1.create
this.hpb_1=create hpb_1
this.st_barcode_elab=create st_barcode_elab
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_1
this.Control[iCurrent+2]=this.st_barcode_elab
end on

on tabpage_1.destroy
call super::destroy
destroy(this.hpb_1)
destroy(this.st_barcode_elab)
end on

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 18
integer y = 48
integer width = 3090
integer height = 1384
integer taborder = 50
string dataobject = "d_txt_fpilota_out_sk"
end type

event dw_1::buttonclicked;call super::buttonclicked;//
string k_path, k_file, k_ext
int k_nrc
kuf_base kuf1_base


	if dwo.name = "b_sfoglia" then
		
		k_path = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "path"))
		if isnull(k_path) or LenA(trim(k_path)) = 0 then

			kuf1_base = create kuf_base
			k_path = trim(kuf1_base.prendi_dato_base("path"))
			destroy kuf1_base
		
			if isnull(k_path) or LenA(trim(k_path)) = 0 then
				k_path = kg_path_procedura
			end if
		end if
			
		k_nrc = GetFileOpenName("Scegli Archivio 'Esiti Pilota'", &
										k_path, k_file, k_ext, "*.txt, *.*") 
							
		if k_nrc <= 0 then
			k_path = " "
		else
			tab_1.tabpage_1.dw_1.setitem(1, "path", trim(k_path))

		end if
	end if			

	
end event

event dw_1::editchanged;call super::editchanged;//
string k_flag


if dwo.name = "err_lavorato" then
	
	if data = "1" then
		k_flag = "1"
	else
		k_flag = "0"
	end if

	tab_1.tabpage_2.dw_2.Modify("colli_artr.Visible=" + k_flag)
	tab_1.tabpage_2.dw_2.Modify("colli_artr_t.Visible=" + k_flag)
	tab_1.tabpage_3.dw_3.Modify("colli_artr.Visible=" + k_flag)
	tab_1.tabpage_3.dw_3.Modify("colli_artr_t.Visible=" + k_flag)
	
end if
end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3109
integer height = 1440
string text = "Da Importare"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
integer x = 18
integer y = 80
integer width = 3072
integer height = 1300
string title = "da_importare"
string dataobject = "d_txt_fpilota_out"
end type

event dw_2::clicked;call super::clicked;//
datastore kds_1

//--- Chiamo la finestrina del Barcode
	if dwo.name = "barcode" then
		apri_sottowindow(tab_1.tabpage_2.dw_2, kds_1, dwo.name, row)
	end if
	
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 1042
integer y = 400
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
boolean visible = true
integer width = 3109
integer height = 1440
string text = "Anomalie"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = 55
integer y = 48
integer width = 2853
integer height = 1360
string title = "anomalie"
string dataobject = "d_txt_fpilota_out"
end type

event dw_3::clicked;call super::clicked;//
datastore kds_1

//--- Chiamo la finestrina del Barcode
	if dwo.name = "barcode" then
		apri_sottowindow(tab_1.tabpage_3.dw_3, kds_1, dwo.name, row)
	end if

end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
boolean visible = true
integer width = 3109
integer height = 1440
string text = "Importati/Chiusi"
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
integer x = 18
integer y = 48
integer width = 3077
integer height = 1280
integer taborder = 10
string title = "importati"
string dataobject = "d_txt_fpilota_out"
end type

event dw_4::clicked;call super::clicked;//
datastore kds_1

//--- Chiamo la finestrina del Barcode
	if dwo.name = "barcode" then
		apri_sottowindow(tab_1.tabpage_4.dw_4, kds_1, dwo.name, row)
	end if

end event

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3109
integer height = 1440
string text = ""
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer width = 3008
integer height = 1244
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3109
integer height = 1440
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3109
integer height = 1440
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3109
integer height = 1440
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3109
integer height = 1440
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type cb_cerca_1 from w_g_tab_3`cb_cerca_1 within w_txt_fpilota_out_sk
end type

type sle_cerca from w_g_tab_3`sle_cerca within w_txt_fpilota_out_sk
end type

type hpb_1 from vprogressbar within tabpage_1
integer x = 55
integer y = 144
integer width = 32
integer height = 1216
boolean bringtotop = true
end type

type st_barcode_elab from statictext within tabpage_1
boolean visible = false
integer x = 91
integer y = 464
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "barcode"
boolean focusrectangle = false
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

type st_estrai from statictext within w_txt_fpilota_out_sk
boolean visible = false
integer x = 1335
integer y = 1652
integer width = 251
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Estrai"
boolean focusrectangle = false
end type

type st_importa from statictext within w_txt_fpilota_out_sk
boolean visible = false
integer x = 1609
integer y = 1644
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Importa"
boolean focusrectangle = false
end type

type st_elenco from statictext within w_txt_fpilota_out_sk
boolean visible = false
integer x = 795
integer y = 1648
integer width = 512
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

