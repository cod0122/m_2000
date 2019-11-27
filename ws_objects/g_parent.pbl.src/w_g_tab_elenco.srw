$PBExportHeader$w_g_tab_elenco.srw
forward
global type w_g_tab_elenco from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab_elenco
end type
type cb_modifica from commandbutton within w_g_tab_elenco
end type
type cb_conferma from commandbutton within w_g_tab_elenco
end type
type cb_cancella from commandbutton within w_g_tab_elenco
end type
type cb_inserisci from commandbutton within w_g_tab_elenco
end type
type tab_1 from tab within w_g_tab_elenco
end type
type tab_1 from tab within w_g_tab_elenco
end type
end forward

global type w_g_tab_elenco from w_g_tab
integer width = 261
integer height = 292
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_conferma cb_conferma
cb_cancella cb_cancella
cb_inserisci cb_inserisci
tab_1 tab_1
end type
global w_g_tab_elenco w_g_tab_elenco

type variables
//
private kuf_elenco kiuf_elenco
//private boolean ki_resize=false   // x fare il rsize 
private DataWindow  ki_dw_cerca
//private datastore kdsi_elenco, kdsi_elenco_orig
private w_g_tab ki_window
private kuf_g_tab_elenco kiuf1_g_tab_elenco
//private string ki_path_risorse = " "
private boolean ki_attendi_u_ricevi_da_elenco=false  // x evitare di fare richiamare troppo velocemente la funz. 'u_ricevi_da_elenco()'

//private long ki_riga_selected
//private time ki_keyleftbutton_ini  //--- Serve per capire sto tenendo premuto il TASTO sx del MOUSE (senza CTRL) per alcuni istanti così da fare ad es. il DRAG&DROP

//private uo_d_std_1 kidw_lista_elenco 
//private uo_d_std_1 kidw_lista_elenco_sel
//protected long ki_riga_x_riposizionamento = 0
protected int ki_selecttab = 0
protected string ki_syntaxquery=" " 


//=== DS di Appoggio x ogni TAB
//private datastore kdsi1_elenco, kdsi1_elenco_orig
//private datastore kdsi2_elenco, kdsi2_elenco_orig
//private datastore kdsi3_elenco, kdsi3_elenco_orig
//private datastore kdsi4_elenco, kdsi4_elenco_orig
//private datastore kdsi5_elenco, kdsi5_elenco_orig
//private datastore kdsi6_elenco, kdsi6_elenco_orig
//private datastore kdsi7_elenco, kdsi7_elenco_orig
//private datastore kdsi8_elenco, kdsi8_elenco_orig
//private datastore kdsi9_elenco, kdsi9_elenco_orig

//=== Parametri passati con il WITHPARM x ogni Tab
//private st_open_w kist1_open_w 
//private st_open_w kist2_open_w 
//private st_open_w kist3_open_w 
//private st_open_w kist4_open_w 
//private st_open_w kist5_open_w 
//private st_open_w kist6_open_w 
//private st_open_w kist7_open_w 
//private st_open_w kist8_open_w 
//private st_open_w kist9_open_w 

//--- Contatore per Gestire troppi tab aperti, ovvero chiude il successivo per ri-occuparlo
private int ki_tab_rioccupato=0


//--- Appoggio x gestione abilitazione tasti funzionali
private boolean ki_tasti_funzionali_enabled[100]
private string ki_dataobject[100]

private kuf_utility kiuf_utility 

//--- flag x disabilitare l'uscita dopo la conferma se ad es. si è aperta una nuova window
private boolean ki_disattiva_exit = false 
//--- evita il RESIZE!
private boolean ki_resize = true

private int ki_tab_max
private uo_g_tab_elenco_tabpage kiuo_g_tab_elenco_tabpage[]

end variables

forward prototypes
protected subroutine inizializza_lista ()
private subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
public subroutine u_close_tab ()
protected function uo_d_std_1 u_get_dw ()
protected subroutine stampa_esegui (st_stampe ast_stampe)
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
public function integer u_open_tab () throws uo_exception
public function integer u_get_tab_x_key ()
end prototypes

protected subroutine inizializza_lista ();//
//=== Routine override dello standard
//
string k_key
int k_tab_selected


	k_key = trim(ki_st_open_w.key1)
	if trim(k_key) > " " then
	else
		k_key = ""
	end if

	ki_st_open_w.key1 = trim(k_key)

	tab_1.selecttab(1)

	if ki_st_open_w.flag_primo_giro = 'S' then
//		k_tab_selected = setta_oggetti( )
		k_tab_selected = tab_1.selectedtab
		kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.drag( Cancel! )
		kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_sel.drag( Cancel! )
		
	end if


end subroutine

private subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
int k_tab_selected


choose case trim(k_par_in) 

	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
//		setta_oggetti( )
		k_tab_selected = tab_1.selectedtab
		kiuo_g_tab_elenco_tabpage[k_tab_selected].leggi_liste()

//	case "ag"		//Aggiorna Liste
//		inizializza()

	case KKG_FLAG_RICHIESTA.inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.conferma		//richiesta conferma
		if cb_conferma.enabled = true then
			cb_conferma.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta visualizz
		if cb_visualizza.enabled = true then
			cb_visualizza.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.modifica		//richiesta modifica
		if cb_modifica.enabled  then
			cb_modifica.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		if cb_ritorna.enabled = true then
			post close(this)
		end if
		
	case KKG_FLAG_RICHIESTA.libero1	//chiude il tab
		u_close_tab()
		
	case KKG_FLAG_RICHIESTA.libero2	//conferma selezionato come doppio-click
		cb_conferma.event clicked( )
//		if cb_conferma.enabled then
//			conferma_selezione()
//		end if

	case KKG_FLAG_RICHIESTA.libero3	//mostra nascondi elenco selezionati
		k_tab_selected = tab_1.selectedtab
		kiuo_g_tab_elenco_tabpage[k_tab_selected].mostra_elenco_selezionati()

	case KKG_FLAG_RICHIESTA.libero71	//zoom +
		//u_zoom_piu(kidw_lista_elenco)
		//kiuo_g_tab_elenco_tabpage = tab_1.control[tab_1.SelectedTab] 
		k_tab_selected = tab_1.selectedtab
		kiuo_g_tab_elenco_tabpage[k_tab_selected].u_zoom_piu()
	case KKG_FLAG_RICHIESTA.libero72	//zoom -
		//u_zoom_meno(kidw_lista_elenco)
		//kiuo_g_tab_elenco_tabpage = tab_1.control[tab_1.SelectedTab] 
		k_tab_selected = tab_1.selectedtab
		kiuo_g_tab_elenco_tabpage[k_tab_selected].u_zoom_meno()

	case else
		super::smista_funz(k_par_in)
//		messagebox("Operazione non Eseguita", &
//					"Funzione richiesta non Abilitata")


end choose


//return k_return

end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu
string k_lista, k_nome_controllo


if ki_st_open_w.flag_primo_giro <> "S" then

//--- imposta gli oggetti standard
	//setta_oggetti()
	//k_tab_selected = tab_1.selectedtab

//if ki_st_open_w.flag_primo_giro = "S" then
		
	if ki_menu.m_finestra.m_fin_stampa.enabled <> st_stampa.enabled then
		ki_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled
	end if
	
	if ki_menu.m_trova.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.enabled = st_ordina_lista.enabled 
	end if
	
	if ki_menu.m_trova.m_fin_ordina.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_ordina.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_trova.m_fin_cerca.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_cerca.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_trova.m_fin_cercaancora.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_cercaancora.enabled = st_ordina_lista.enabled 
	end if
	
	if ki_menu.m_trova.m_fin_filtra.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_filtra.enabled = st_ordina_lista.enabled 
	end if
	if ki_menu.m_filtro.enabled <> st_ordina_lista.enabled then
		ki_menu.m_filtro.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled then
		ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 
	end if

	if ki_menu.m_finestra.m_riordinalista.enabled <> st_ordina_lista.enabled then
		ki_menu.m_finestra.m_riordinalista.enabled = st_ordina_lista.enabled 
	end if

	if ki_menu.m_finestra.m_chiudifinestra.enabled <> cb_ritorna.enabled then 
		ki_menu.m_finestra.m_chiudifinestra.enabled = cb_ritorna.enabled
	end if

	if ki_menu.m_finestra.m_layout_predefinito.enabled <> ki_personalizza_pos_controlli then
		ki_menu.m_finestra.m_layout_predefinito.enabled = ki_personalizza_pos_controlli
	end if

	if ki_menu.m_trova.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_trova.enabled = st_aggiorna_lista.enabled 
	end if
	if ki_menu.m_trova.m_fin_ordina.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_trova.m_fin_ordina.enabled = st_aggiorna_lista.enabled  
	end if
	if ki_menu.m_trova.m_fin_cerca.enabled <> st_aggiorna_lista.enabled then 
		ki_menu.m_trova.m_fin_cercaancora.enabled = st_aggiorna_lista.enabled  
	end if
//	if ki_menu.m_trova.m_fin_cercaancora.enabled <> st_aggiorna_lista.enabled then 
//		ki_menu.m_trova.m_fin_filtra.enabled = st_aggiorna_lista.enabled  
//	end if
	if ki_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled  then
		ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled  
	end if
	if ki_menu.m_finestra.m_riordinalista.enabled <> st_aggiorna_lista.enabled then 
		ki_menu.m_finestra.m_riordinalista.enabled = st_aggiorna_lista.enabled 
	end if

	if ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled <> cb_visualizza.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled <> cb_modifica.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
	end if
	if ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled <> cb_inserisci.enabled then
		ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
	end if

//end if
//	if kdsi_elenco_orig.rowcount() <> kidw_lista_elenco.rowcount() then
//		 ki_menu.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//		 ki_menu.m_finestra.m_aggiornalista.text = "Rirpistina elenco "
//	end if

//--- Chiude scheda
	if not ki_menu.m_strumenti.m_fin_gest_libero1.enabled  or not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Chiudi scheda "
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = 	"Chiudi, Chiudi scheda Selezionata  "
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = kGuo_path.get_risorse() + "\Cancel16.ico"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Close_2!"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	end if		
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = ki_menu.m_strumenti.m_fin_gest_libero1.enabled
	
//--- Visualizza elenco selezionati	
//	if cb_conferma.enabled  then 	
//		k_attiva = true
//	else
//		k_attiva= false
//	end if
	if ki_menu.m_strumenti.m_fin_gest_libero2.enabled  <> cb_conferma.enabled or not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Importa riga/righe Selezionata "
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Importa riga/righe Selezionata "
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = 	"Importa, Importa riga/righe Selezionata  "
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kGuo_path.get_risorse() + "\spunta.gif"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Custom038_2!"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = cb_conferma.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	end if		
	ki_menu.m_strumenti.m_fin_gest_libero2.visible = ki_menu.m_strumenti.m_fin_gest_libero2.enabled

//--- Come doppio-click
	if not ki_menu.m_strumenti.m_fin_gest_libero3.visible  then 
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Mosta/Nascondi elenco Righe già Selezonate "
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Mostra Elenco Selezionati "
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Mostra, Mosta/Nascondi elenco Righe già Selezonate  "
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "PlaceColumn_2!"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	end if
	ki_menu.m_strumenti.m_fin_gest_libero3.visible = ki_menu.m_strumenti.m_fin_gest_libero3.enabled

//--- ZOOM
	if not ki_menu.m_strumenti.m_fin_gest_libero7.visible  then 
		ki_menu.m_strumenti.m_fin_gest_libero7.text = "Zoom sulla scheda aperta (usa anche i tasti più e meno)"
		ki_menu.m_strumenti.m_fin_gest_libero7.microhelp = "per lo Zoom usare anche + o -"
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemText = 	"ZOOM, Zoom sulla scheda aperta (usa anche + o -) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemName = "zoom.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true

		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Ingrandicse la scheda aperta (usa anche il tasto più)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Ingrandisce usare anche il + "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = 	"ZOOM+, Ingrandisce la scheda aperta (usa anche il +) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "zoompiu.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true

		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Diminuisce la scheda aperta (usa anche il tasto meno)"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Diminuisce usare anche il + "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = 	"ZOOM-, Diminuisce la scheda aperta (usa anche il -) "
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "zoommeno.png"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
	end if
	ki_menu.m_strumenti.m_fin_gest_libero7.visible = ki_menu.m_strumenti.m_fin_gest_libero7.enabled
	ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled
	ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled

//---
	super::attiva_menu()

end if

end subroutine

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Controlla il primo TAB disponibile e lo ATTIVA
//---
boolean k_return = true
int k_tabselected

ki_disattiva_exit = true

super::u_riopen(kst_open_w)

k_tabselected = u_open_tab( )
tab_1.selecttab(k_tabselected)

//post u_apri_tab(kst_open_w)

ki_st_open_w.flag_primo_giro = "N"

return k_return

end function

public subroutine u_close_tab ();//
//--- close il tab cliccato
//
int k_ctr, k_tab_idx
int k_tab_selected


	if ki_tab_max > 0 then
//--- se ho un solo tab chiudo tutto!
		if ki_tab_max = 1 then
			cb_ritorna.event clicked( )
		else
			k_tab_selected = tab_1.selectedtab
			if k_tab_selected > 0 then
				k_ctr = tab_1.closetab(kiuo_g_tab_elenco_tabpage[k_tab_selected])
				if k_ctr > 0  then
					ki_tab_max --
					//--- ricompatta i tab
					for k_tab_idx = k_tab_selected to ki_tab_max
						kiuo_g_tab_elenco_tabpage[k_tab_idx] = kiuo_g_tab_elenco_tabpage[k_tab_idx + 1]
					next
					if k_tab_selected > 1 then
						k_tab_selected --
					else
						k_tab_selected = 1
					end if
					tab_1.selecttab(k_tab_selected)
				end if
			end if
		end if
	end if

end subroutine

protected function uo_d_std_1 u_get_dw ();//---
//--- get il DW attivo
//---
uo_d_std_1 kdw_x

	kdw_x = kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1

return kdw_x	



end function

protected subroutine stampa_esegui (st_stampe ast_stampe);//
int k_tab_selected


//--- imposta gli oggetti standard
//		setta_oggetti()
k_tab_selected = tab_1.selectedtab
		
//	ast_stampe.dw_print = kidw_lista_elenco
//	ast_stampe.titolo = trim(kidw_lista_elenco.tag)
//
//	kGuf_data_base.stampa_dw(ast_stampe)

	if isvalid(kidw_selezionata) then
		ast_stampe.dw_print = kidw_selezionata
	else
		if kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.visible then
			ast_stampe.dw_print = kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1
		end if
	end if
	
	if isvalid(ast_stampe.dw_print) then
		if isvalid(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1) then
			ast_stampe.titolo = trim(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.tag)
		else
			ast_stampe.titolo = trim(kiuo_g_tab_elenco_tabpage[k_tab_selected].dw_1.title)
		end if
		kGuf_data_base.stampa_dw(ast_stampe)
	else
		messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
	end if

end subroutine

protected subroutine open_start_window ();//
//
//-------------------------------------------------------------------------------------------------------------
//--- Window utilizzata per ZOOM da  Valori  delle varie Window
//---
//--- spesso in alternativa alla DROP-DATAWINDOWS (doppio click)
//----
//--- Parametri richiesti:
//--- KEY1 = Titolo da dare a questa scheda di ZOOM ("elenco/anteprima")
//--- KEY2 = nome data-window x l'elenco
//--- KEY3 = RISERVATO non usare xchè ritorna il numero di RIGA cliccato
//--- KEY4 = Titolo della Window chiamante
//--- KEY5 = RISERVATO da non usare
//--- KEY6 = nome campo che ha scatenato la chiamata a questo elenco
//--- KEY7 = flag N= non chiudere lo ZOOM dopo il DOPPIO CLICK (kuf_elenco.ki_esci_dopo_scelta) 
//--- KEY12_any = reference al datastore con i dati da visualizzare
//---
//--- Nell'evento chiamato questi altri valori, oltre a quelli di cui sopra:
//--- KEY3 = numero della riga scelta dall'elenco
//---        0 = nessuna riga scelta
//--- KEY5 = nome campo che ha scatenato la chiamata a questo elenco
//-------------------------------------------------------------------------------------------------------------
//
int k_rc

try
	
	kiuf_utility = create kuf_utility

//--- apre nuovo tab 	
	u_open_tab( )
	tab_1.visible = true
	
//	kidw_lista_elenco = kiuo_g_tab_elenco_tabpage.dw_1
//	kidw_lista_elenco_sel =  kiuo_g_tab_elenco_tabpage.dw_sel

//	set_window_size()

////--- setta la directory di base
//	kGuf_data_base.setta_path_default ()
//
//	set_titolo_window()
//
//
////=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
//	kidw_lista_elenco.tag = this.title
//	
//	
////--- path per reperire le ico del drag e drop
////	ki_path_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
//	
////	if ki_utente_abilitato then
//
//		kiuf1_g_tab_elenco = create kuf_g_tab_elenco
//
//		post inizializza_lista()
//	
////	end if

catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		
end try

end subroutine

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_tab_selected


	SetPointer(kkg.pointer_attesa)

//--- imposta gli oggetti standard
//	setta_oggetti()
	k_tab_selected = tab_1.selectedtab

	kiuo_g_tab_elenco_tabpage[k_tab_selected].inizializza()
	//tab_1.tabpage_1.text = trim(ki_st_open_w.key1)

	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe
string k_lista, k_nome_controllo
int k_tab_selected
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima


//setta_oggetti( )
k_tab_selected = tab_1.selectedtab

super::attiva_tasti_0()		 

st_aggiorna_lista.enabled = true
//--- queste dovrebbero essere di tipo GRID...
//kdw_focus = u_get_dw( )  //kGuf_data_base. u_getfocus_dw()
if not isvalid(kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata) then 
	st_ordina_lista.enabled = false
else
	k_lista = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.Object.DataWindow.Processing
	if k_lista = "1"  then
		st_ordina_lista.enabled = true
	else
		st_ordina_lista.enabled = false
	end if
	
	kst_tab_menu_window_anteprima.anteprima = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject
	if kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject <> ki_dataobject[tab_1.selectedtab] then  // se è cambiato qls ricontrolla
		
		ki_dataobject[tab_1.selectedtab] = kiuo_g_tab_elenco_tabpage[k_tab_selected].kidw_selezionata.dataobject 
		
	//	kuf1_menu = create kuf_menu
		if kguf_menu_window.get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima) then // se Anteprima è apribile...
			ki_tasti_funzionali_enabled[tab_1.selectedtab] = true
		else
			ki_tasti_funzionali_enabled[tab_1.selectedtab] = false
		end if	
	//	destroy kuf1_menu
	end if
end if
cb_visualizza.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
cb_modifica.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]
cb_inserisci.enabled = ki_tasti_funzionali_enabled[tab_1.selectedtab]

cb_ritorna.visible = false
cb_conferma.visible = false

cb_ritorna.enabled = true
cb_conferma.enabled = true

kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].set_ki_conferma(cb_conferma.enabled)

end subroutine

public subroutine u_resize_1 ();//
int k_tab_selected


	super::u_resize_1()

//--- Se tab_1 e visible oppure sono in prima volta
	this.setredraw(false)

//--- Dimensione dw nella window 
	tab_1.width = width //a_width - 2  //this.width - 2
	tab_1.height = height //a_height - 2  //this.height - 2
	
//--- Posiziona dw nella window 
	tab_1.x = 1 //(this.width - tab_1.width) / 4
	tab_1.y = 1 //(this.height - tab_1.height) / 7

	//setta_oggetti( )
	k_tab_selected = tab_1.selectedtab
	kiuo_g_tab_elenco_tabpage[k_tab_selected].u_resize( )
	
//	constant int kk_barra_width = 1 //55
//	constant int kk_barra_height = 100 //140
//	
////--- Dimensiona dw nel tab
//	tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - kk_barra_width
//	tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - kk_barra_height
//	tab_1.tabpage_1.dw_1.x = 1
//	tab_1.tabpage_1.dw_1.y = 1
//	
////--- Dimensione e Posizione dw di selezione nella window 
//	tab_1.tabpage_1.dw_1_sel.height = tab_1.tabpage_1.dw_1.height * 0.70
//	tab_1.tabpage_1.dw_1_sel.width = tab_1.tabpage_1.dw_1.width * 0.30
//	tab_1.tabpage_1.dw_1_sel.x = (this.width - tab_1.tabpage_1.dw_1_sel.width) - 45
//	tab_1.tabpage_1.dw_1_sel.y = tab_1.tabpage_1.dw_1.y + 30


this.setredraw(true)



end subroutine

public function integer u_open_tab () throws uo_exception;//
int k_return, k_rc


//--- tab già aperto?
	k_return = u_get_tab_x_key()
	if k_return > 0 then

		kiuo_g_tab_elenco_tabpage[k_return].kist_open_w = ki_st_open_w
		kiuo_g_tab_elenco_tabpage[k_return].dw_1.reset()
		kiuo_g_tab_elenco_tabpage[k_return].dw_sel.reset()
		kiuo_g_tab_elenco_tabpage[k_return].kids_elenco_orig.reset()
		tab_1.selecttab(k_return)

		inizializza( )
		
	else
		ki_tab_max++ //upperbound(tab_1.control[])
	
//		if isvalid(kiuo_g_tab_elenco_tabpage) then 
//			destroy kiuo_g_tab_elenco_tabpage
//			kiuo_g_tab_elenco_tabpage = create uo_g_tab_elenco_tabpage
//		end if
		k_rc = tab_1.OpenTabWithParm(kiuo_g_tab_elenco_tabpage[ki_tab_max],  trim(ki_st_open_w.key1), 0)
		if k_rc > 0 then
				
			kiuo_g_tab_elenco_tabpage[ki_tab_max].backcolor = tab_1.backcolor
			kiuo_g_tab_elenco_tabpage[ki_tab_max].kist_open_w = ki_st_open_w
			kiuo_g_tab_elenco_tabpage[ki_tab_max].tag = this.title 
			kiuo_g_tab_elenco_tabpage[ki_tab_max].u_resize( ) 
			kiuo_g_tab_elenco_tabpage[ki_tab_max].kitab_1 = tab_1
			tab_1.selecttab(ki_tab_max)

			inizializza( )

//			kiuo_g_tab_elenco_tabpage[ki_tab_max].visible = true
//			kiuo_g_tab_elenco_tabpage[ki_tab_max].enabled = true
			k_return = ki_tab_max
		else
			ki_tab_max --
		end if
	end if

return k_return

end function

public function integer u_get_tab_x_key ();//---
//--- Torna il numero se il TAB è già aperto cercato per chiave 
//---
//--- torna: ZERO = tab non ancora aperto
//---            > 0 il numero del TAB
//---
int k_return
int k_max_tab, k_ind_tab=1


k_max_tab = upperbound(tab_1.control[])
if k_max_tab > 0 then

	do while k_ind_tab <= k_max_tab and k_return = 0

		//kiuo_g_tab_elenco_tabpage = tab_1.control[k_ind_tab]
		if kiuo_g_tab_elenco_tabpage[k_ind_tab].kist_open_w.key2 = ki_st_open_w.key2 &
		     and  kiuo_g_tab_elenco_tabpage[k_ind_tab].kist_open_w.key1 =  ki_st_open_w.key1 then
			  k_return = k_ind_tab  //--- trovato tab uguale
		else
		
			k_ind_tab ++
			
		end if

//	if not tab_1.tabpage_1.dw_1.visible or kist1_open_w.key2 = kst_open_w.key2 then
//		kidw_selezionata = tab_1.tabpage_1.dw_1
//		kist1_open_w = kst_open_w 
//		tab_1.tabpage_1.dw_1.reset( )
//		tab_1.tabpage_1.dw_1_sel.reset( )
//		if isvalid(kdsi1_elenco_orig) then kdsi1_elenco_orig.reset( )
//		if isvalid(kdsi1_elenco) then kdsi1_elenco.reset( )
//		tab_1.tabpage_1.dw_1.enabled = true
//		tab_1.selecttab(1)
//	else		
//--- chiudo un tab x ri-occuparlo		
//		k_return = false
//		ki_tab_rioccupato ++
//		choose case ki_tab_rioccupato
//			case 1
//				tab_1.tabpage_1.dw_1.visible = false
//			case 2
//				tab_1.tabpage_2.dw_2.visible = false
//			case 3
//				tab_1.tabpage_3.dw_3.visible = false
//			case 4
//				tab_1.tabpage_4.dw_4.visible = false
//			case 5
//				tab_1.tabpage_5.dw_5.visible = false
//			case 6
//				tab_1.tabpage_6.dw_6.visible = false
//			case 7
//				tab_1.tabpage_7.dw_7.visible = false
//			case 8
//				tab_1.tabpage_8.dw_8.visible = false
//			case 9
//				tab_1.tabpage_9.dw_9.visible = false
//				ki_tab_rioccupato = 0
//		end choose

	loop
end if

//if k_return then
//	//--- forza un RESIZE del dw
//	ki_resize = true   // abilita il RESIZE
//	u_resize( )
//
//	//kidw_selezionata.visible = true
//end if

return k_return

end function

on w_g_tab_elenco.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_conferma=create cb_conferma
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_conferma
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.tab_1
end on

on w_g_tab_elenco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_conferma)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.tab_1)
end on

event u_open_preliminari;call super::u_open_preliminari;//
	ki_nome_save = trim(this.ClassName())

//--- Parametri passati con il WITHPARM
	ki_st_open_w = message.powerobjectparm
	ki_st_open_w.key3 = " "
	ki_nome_save =  trim(ki_st_open_w.key2)

	//ki_st_open_w = kist1_open_w

	
end event

event open;//
//
long k_ctr


//--- INIZIO OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

//sembra nascondere il puntatore	this.setredraw(false)
	
//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

//--- setta il titolo della window
	set_titolo_window()

//--- oggetto utile alla sincronizzazione con una window chiamata, es canc di una riga dall'elenco
	kiuf1_sync_window = create kuf_sync_window

//---- oggetto generico 
	kiuf_parent = create kuf_parent

//--- FINE !!!! OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

	setpointer(kkg.pointer_attesa)

//	//--- Menu Window
//	if this.windowtype = response! or this.windowtype = popup! then
//	else
//		post set_window_size()	
//
//		ki_menu = ki_menu_0
// 		this.ChangeMenu (ki_menu)
//		ki_menu.autorizza_menu( )
//		ki_menu.u_inizializza( )
//		ki_menu.u_espone_testo_delete(ki_menu_espone_tasto_delete)
//			
//	end if
	
//--- altre operazioni
	post event u_open( )

//	setpointer(kkg.pointer_default)		


end event

event u_open;call super::u_open;//
//
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

	set_titolo_window()


//=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
//	kidw_lista_elenco.tag = this.title
	
	kiuf1_g_tab_elenco = create kuf_g_tab_elenco

	inizializza_lista()
	
	fine_primo_giro()

//	kGuo_g.kgw_attiva = this

	post attiva_tasti()
	u_resize()

end event

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_elenco
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_elenco
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_elenco
integer x = 1961
integer y = 1140
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_elenco
integer x = 2523
integer y = 1088
integer width = 329
integer height = 88
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_elenco
integer x = 1961
integer y = 1012
end type

type cb_visualizza from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 644
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Visualizza"
boolean default = true
end type

event clicked;//
try

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.visualizzazione)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end event

type cb_modifica from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 868
integer width = 329
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Modifica"
end type

event clicked;//

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.modifica)
	end if

end event

type cb_conferma from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 69
integer y = 832
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Seleziona"
end type

event clicked;//
attiva_tasti( )


if tab_1.selectedtab > 0 then
	
	if kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled = false
		
		//setta_oggetti( )
		if kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].conferma_dati( ) = "EXIT" then
		
			cb_ritorna.post event clicked( )
			
		else
			
			kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].dw_1.enabled = true
	
		end if
	end if
end if

end event

event getfocus;//
attiva_tasti( )

end event

type cb_cancella from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 756
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Elimina"
end type

event clicked;//
//cancella()
end event

type cb_inserisci from commandbutton within w_g_tab_elenco
boolean visible = false
integer x = 2528
integer y = 532
integer width = 329
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Nuovo"
end type

event clicked;//

	if tab_1.selectedtab > 0 then
		kiuo_g_tab_elenco_tabpage[tab_1.selectedtab].u_esegui_funzione(kkg_flag_modalita.inserimento)
	end if

end event

type tab_1 from tab within w_g_tab_elenco
event ue_exit ( )
boolean visible = false
integer width = 3886
integer height = 872
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 31449055
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
end type

event ue_exit();//
u_close_tab()


end event

event constructor;//
this.backcolor = parent.backcolor

end event

event selectionchanged;//
kidw_selezionata = u_get_dw( )

attiva_tasti( )

end event

event clicked;//
attiva_tasti()

end event

