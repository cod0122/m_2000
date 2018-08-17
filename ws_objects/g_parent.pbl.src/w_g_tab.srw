$PBExportHeader$w_g_tab.srw
forward
global type w_g_tab from w_super
end type
type st_ritorna from statictext within w_g_tab
end type
type st_ordina_lista from statictext within w_g_tab
end type
type st_aggiorna_lista from statictext within w_g_tab
end type
type cb_ritorna from commandbutton within w_g_tab
end type
type st_stampa from statictext within w_g_tab
end type
end forward

global type w_g_tab from w_super
integer x = 219
integer y = 160
integer width = 2405
integer height = 2052
string menuname = "m_main"
boolean resizable = true
windowtype windowtype = main!
string icon = ""
integer transparency = 100
integer animationtime = 50
boolean ki_utente_abilitato = false
event u_ricevi_da_elenco ( st_open_w kst_open_w )
event u_open ( )
event u_activate ( )
st_ritorna st_ritorna
st_ordina_lista st_ordina_lista
st_aggiorna_lista st_aggiorna_lista
cb_ritorna cb_ritorna
st_stampa st_stampa
end type
global w_g_tab w_g_tab

type variables
//
w_g_tab kiw_this_window

public m_main ki_menu 
protected boolean ki_menu_espone_tasto_delete = false

protected boolean ki_esponi_msg_dati_modificati = true
protected boolean ki_esponi_msg_dati_modificati_salvaauotom = false   // ha senso solo se ki_esponi_msg_dati_modificati=false


private boolean ki_toolbar_programmi_attiva_voce=true
private boolean ki_toolbar_programmi_primo_giro=true

//protected boolean ki_personalizza_pos_controlli=false		
protected boolean ki_salva_restore_gia_fatto=false		

protected kuf_parent kiuf_parent 
 
//--- l'unico tasto standard attivo sara' l'uscita e il stampa
protected boolean ki_nessun_tasto_funzionale=false		

//--- utile x chiamare "elenchi al volo"
protected datastore kdsi_elenco_output   //ds da passare alla windows di elenco
protected datastore kdsi_elenco_input    //ds di ritorno dalla windows di elenco

//--- al ritorno di una finestra di modifica fa la lettura se qualcosa e' stato modificato
//--- per sincronizzare i dati tra window
protected kuf_sync_window kiuf1_sync_window
private boolean ki_sincronizza_window_gia_check=false
public boolean ki_sincronizza_window_ok = false
public string  ki_sincronizza_window_da_id_programma
public boolean ki_sincronizza_window_consenti = true

//--- Per segnalare la dw_selezionata
public uo_d_std_1 kidw_selezionata
public graphicobject kigrf_x_trova

////--- usato per il "TROVA", e' il campo proposto per default e Altro...
public int ki_trova_campo_def = 1
//uo_d_std_trova kiuo_d_std_trova

//--- x fare il FILTRA sul DW di elenco 
protected boolean ki_filtra_attivo=true
private kuf_filtra kiuf_filtra 

//--- premuto il pulsante EXIT
protected boolean ki_exit_si = false

//--- evita la richiesta se aggiornare gli archivi se tutto ok
protected boolean ki_aggiorna_richiesta_conferma = true

end variables

forward prototypes
protected subroutine stampa ()
protected function integer ritorna (string k_titolo)
protected function string aggiorna_dati ()
protected function string aggiorna ()
protected function string check_dati ()
protected function boolean sicurezza (st_open_w kst_open_w)
protected subroutine sicurezza_open ()
public subroutine smista_funz (string k_par_in)
protected function string dati_modif (string k_titolo)
protected function boolean dati_modif_1 ()
protected subroutine attiva_tasti ()
protected subroutine attiva_menu ()
protected subroutine riempi_id ()
protected subroutine toolbar_programmi_aggiungi_voce ()
protected subroutine toolbar_programmi_cancella_voce ()
protected subroutine toolbar_programmi_attiva_voce ()
protected function string inizializza () throws uo_exception
protected function st_esito aggiorna_window ()
protected subroutine set_titolo_window ()
protected function string inizializza_post ()
protected subroutine open_start_window ()
protected subroutine fine_primo_giro ()
protected subroutine set_titolo_window_personalizza ()
public subroutine set_window_size ()
protected subroutine dati_modif_accept ()
public function boolean u_trova_in_dw (string a_flag_richiesta)
protected subroutine stampa_esegui (st_stampe ast_stampe)
public function string dati_modif_figlio_inizio (string k_titolo)
public subroutine dati_modif_figlio_fine (string k_titolo)
public subroutine pulizia_righe ()
protected function boolean dati_modif_0 ()
protected subroutine fine_primo_giro_post ()
public function boolean u_filtra_in_dw ()
public function boolean u_ordina_in_dw ()
private subroutine u_dw_cut_valore ()
public function boolean u_open_proprieta ()
protected subroutine attiva_menu_reset ()
protected subroutine attiva_tasti_0 ()
public subroutine u_win_ripri_video ()
public subroutine u_resize_1 ()
public function boolean u_window_control_restore ()
protected subroutine inizializza_lista ()
end prototypes

event u_ricevi_da_elenco(st_open_w kst_open_w);//---
//--- evento scatenato dalla Window di Elenco  (w_g_tab_elenco) quando scelgo con doppio click una riga
//---
//--- evento da implementare nelle singole window
end event

event u_open();//
//--- Operazioni iniziali di OPEN 
//
int k_ctr
boolean k_toolbar_window_stato


//	setpointer(kkg.pointer_attesa)

	//--- Menu Window
	if this.windowtype = response! or this.windowtype = popup! then
	else
		post set_window_size()	

		IF IsValid (THIS.MenuID) then			// Menu Attached?
		//ki_menu = ki_menu_0
 		//this.ChangeMenu (ki_menu)
			ki_menu = this.menuid
			ki_menu.autorizza_menu( )
			ki_menu.u_inizializza( )
			ki_menu.u_espone_testo_delete(ki_menu_espone_tasto_delete)
		end if
	end if
	
//---------------------------------------------------------------------------------------------	
//--- dalla OPEN	
//---------------------------------------------------------------------------------------------	

//--- la primissima cosa che fa PERSONALIZZATA dalle windows FIGLIE
	open_start_window()
	 
	if ki_st_open_w.st_tab_menu_window.salva_controlli = "S" then
		ki_personalizza_pos_controlli = true
	else
		ki_personalizza_pos_controlli = false
	end if

//--- dimensiona window e oggetti 	
//	post u_resize()

//---------------------------------------------------------------------------------------------	

//--- l'utente e' già stato autorizzato? (setta la ki_utente_abititato)
   if ki_st_open_w.flag_utente_autorizzato then
		ki_utente_abilitato = true
	else
//--- controlla SR 		
		sicurezza_open() 
	end if

//	if ki_utente_abilitato then
//		post attiva_tasti()
//	end if
	
//--- aggiunge voce nella toolbar dei programmi Aperti
	
//	setpointer(kkg.pointer_default)
				
end event

event u_activate();//


kGuo_g.kgw_attiva = this

this.setredraw(false)

//--- se ritorno da funzione esterna
//--- funzione utile per sincronizzare i dati dell window
if ki_st_open_w.flag_primo_giro <> "S" and ki_sincronizza_window_consenti then
	if not ki_sincronizza_window_gia_check then 
		ki_sincronizza_window_gia_check=true
		if kiuf1_sync_window.u_window_get_funzione_aggiornata(kiw_this_window) then
			aggiorna_window()
		end if
	end if
end if

//--- se non c'e' alcun menu non faccio sta roba
if isvalid(ki_menu) then
	//ki_menu.reset_menu_strumenti( )
	attiva_tasti()
end if

if not ki_salva_restore_gia_fatto then
	ki_salva_restore_gia_fatto = true
end if

////--- attiva nella toolbar dei programmi aperti la voce 
//if ki_toolbar_programmi_attiva_voce then
//	ki_toolbar_programmi_attiva_voce=false
//	toolbar_programmi_attiva_voce()
//end if

this.setredraw(true)

end event

protected subroutine stampa ();//
 st_stampe kst_stampe
 
 stampa_esegui(kst_stampe)

end subroutine

protected function integer ritorna (string k_titolo);//
//
int k_return=0
string k_errore = "0 ", k_esito = "0"



//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
k_esito = dati_modif(k_titolo)
if len(k_esito) > 0 then 
	k_errore = Left(k_esito, 1)
end if
if k_errore = "1" then  //Fare gli aggiornamenti
	
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = aggiorna_dati()	
	k_esito = Left(k_errore, 1)
	if isnumber(k_esito) then
		k_return = integer(k_esito)
	end if
	
else
	if k_errore = "3" then 
		k_return = 999 //Operazione ANNULLATA
	else
		k_return = 0  //Non fare aggiornamenti USCITA da pgm
	end if
end if

return k_return 
end function

protected function string aggiorna_dati ();//
//=== Completa gestione aggiornamento tabelle : Check dati + Update
//=== Ritorna 1 char: 0=Tutto OK; 
//                  : 1=Errore grave e/o aggiuornam. non eseguito;
//===	              : 2=Errore Non grave richiesto di non aggiornare i dati
//===               : 3=
//
string k_return="0 "
string k_errore= "0 ", k_errore1 = "0 ", k_errore_dati = "0 "
string k_errore_check


//--- Imposta campi e codici prima di aggiornare le tabelle
		riempi_id()

//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 
//===                : 4=OK con incongruenze, richiesta se fare aggiornamento
//===                : 5=ON con avvertenze generiche, richiesta se fare aggiornamento
//===      il resto della stringa contiene la descrizione dell'errore   
k_errore_dati = check_dati()

k_errore_check = Left(k_errore_dati,1)

choose case k_errore_check 

	case "0" //Tutto OK!
  	   k_return = "0" + Mid(k_errore_dati, 2)

   case "1" //errore grave: incongruenze dati
		messagebox("Digitati dati incongruenti, operazione non eseguita",  Mid(k_errore_dati, 2))
		k_return="1" + Mid(k_errore_dati, 2)
		
	case "2" //errore grave: digitazione dati 
		messagebox("Inseriti dati non validi, operazione non eseguita", Mid(k_errore_dati, 2))
		k_return="1" + Mid(k_errore_dati, 2)
		
	case "3" //errore grave: mancanza dati
		messagebox("Dati insufficienti, operazione non eseguita", Mid(k_errore_dati, 2))
		k_return="1" + Mid(k_errore_dati, 2)
		
	case "4" //avvertenza DB: dati da rivedere
		if ki_aggiorna_richiesta_conferma then
			if messagebox("Rilevate alcune anomalie", Mid(k_errore_dati, 2) + "~n~rEseguire comunque l'aggiornamento ?", question!, yesno!, 2) = 2 then
				k_return = "1" + "Dati non aggiornati"
			else
				k_return = "0" + Mid(k_errore_dati, 2)
			end if
		else
			k_return = "0" + Mid(k_errore_dati, 2)
		end if
	case "5" //avvertenza dati: dati da rivedere
		if ki_aggiorna_richiesta_conferma then
			if messagebox("Rilevate alcune incongruenze", Mid(k_errore_dati, 2) + "~n~rEseguire comunque l'aggiornamento ?", question!, yesno!, 2) = 2 then
				k_return = "1" + "Dati non aggiornati"
			else
				k_return = "0" + Mid(k_errore_dati, 2)
			end if
		else
			k_return = "0" + Mid(k_errore_dati, 2)
		end if
		
	case else //avvertenze: altro
		if ki_aggiorna_richiesta_conferma then
			if messagebox("Richiesto Aggiornamento Archivio", Mid(k_errore_dati, 2) + "~n~rProseguire con l'aggiornamento ?", question!, yesno!, 2) = 2 then
				k_return = "1" + "Dati non aggiornati"
			else
				k_return = "0" + Mid(k_errore_dati, 2)
			end if		
		else
			k_return = "0" + Mid(k_errore_dati, 2)
		end if

	end choose
		
//--- Aggiorna solo se Nessun errore o Richiesto esplicitamente
	if Left(k_return,1) = "0" then

//--- Imposta campi e codici prima di aggiornare le tabelle
//		riempi_id()

//=== k_errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 			: 2=alcuni errori ma probabile agg. eseguito
//===				: 3=Commit fallita
		k_errore = aggiorna()		

		if Left(k_errore, 1) = "1" or Left(k_errore, 1) = "3" then
			k_return="1" + Mid(k_errore, 2)
		else
			if Left(k_errore, 1) = "2" then
				k_return=trim(k_errore)
			else
				if Left(k_errore, 1) = "0" then
					k_return = "0"
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
				end if
			end if
		end if
	end if



return k_return

end function

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 "

//....

return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito
//datastore kds_inp
//kuf_parent kuf1_parent

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	//kuf1_parent = create kuf_parent
	//copia dei dati di dw in un ds
//	kds_inp.dataobject = dw_dati.dataobject
//	dw_dati.rowscopy( 1,dw_dati.rowcount( ) ,primary!, kds_inp, 1, primary!)

	//....
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try

return k_errore + k_return


end function

protected function boolean sicurezza (st_open_w kst_open_w);//
//=== Controlla se funzione Autorizzata (=TRUE) o meno (=FALSE) 
//
boolean k_return=false
kuf_sicurezza kuf1_sicurezza
kuf_parent kuf1_parent 


//--- se l'oggetto è vecchio o non valido allora prendo valido il id_programma impostato
	if trim(kst_open_w.nome_oggetto) > " " then 
		kuf1_parent = create using kst_open_w.nome_oggetto  //nme oggetto = KUF_....
		if isvalid(kuf1_parent) then 
			kst_open_w.id_programma = kuf1_parent.get_id_programma(kst_open_w.flag_modalita)
		end if
	end if

	kuf1_sicurezza = create kuf_sicurezza
	k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_return then

		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_noAUT )
		if len(trim(kst_open_w.id_programma)) > 0 then
			if isnull(kst_open_w.flag_modalita) then kst_open_w.flag_modalita = ""
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta non e' stata abilitata: "  + trim(kst_open_w.id_programma) + " - " + trim(kst_open_w.flag_modalita))
		else
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta non e' stata abilitata! " )
		end if
	
	end if


return k_return

end function

protected subroutine sicurezza_open ();//
//=== Controlla se funzione Autorizzata o meno 
//

	ki_utente_abilitato = sicurezza(ki_st_open_w)
	if not ki_utente_abilitato then

		smista_funz( KKG_FLAG_RICHIESTA.esci )

	
	end if



end subroutine

public subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in 

	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		if cb_ritorna.enabled then
			cb_ritorna.postevent(clicked!)
//			post close(this)
		end if

	case KKG_FLAG_RICHIESTA.VISUALIZZ_PREDEFINITA		//richiesta ridispone le dw nella windows come x default
		ki_personalizza_pos_controlli = false
//		this.TriggerEvent(resize!)
//		u_win_ripri_video( ) 
		u_resize_predefinita( )
		u_obj_visible_0( )
		ki_personalizza_pos_controlli = true

	case "l0" to "l9"		//richiesta personalizzata
		messagebox("Richiesta Funzione", &
					"Tasto funzionale non attivo per questa funzione ("+ trim(k_par_in) +")", information!)
//		if cb_ritorna.enabled = true then
//			cb_ritorna.postevent(clicked!)
//		end if

	case KKG_FLAG_RICHIESTA.filtro		//richiesta di filtro sui campi (filter)
		if not u_filtra_in_dw() then
			messagebox("Filtro Elenco", &
						"Il Filtro non può essere attivato per questa funzione", information!)
		end if

//Cerca.....  e  Continua ricerca....
	case KKG_FLAG_RICHIESTA.trova		&			
		, KKG_FLAG_RICHIESTA.trova_ancora		
		u_trova_in_dw(k_par_in)
//		u_richiesta_trova(k_par_in)

	case KKG_FLAG_RICHIESTA.sort		//Sort personalizzato
		if not u_ordina_in_dw() then
			messagebox("Ordina Elenco", &
						"Per effettuare l'ordinamento selezionare una riga all'interno dell'elenco", information!)
		end if

//--- Copia TESTO
	case KKG_FLAG_RICHIESTA.copy		//Ctrl+C
		u_dw_cut_valore( )

//--- Richiama Impostazioni Utente
	case KKG_FLAG_RICHIESTA.proprieta
		u_open_proprieta( )

	case "" 	         	//nessuna richiesta
//----		

	case else
		messagebox("Richiesta Funzione", "La Funzione richiesta non è prevista ("+ trim(k_par_in) +")")

end choose

end subroutine

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
		k_dati_modificati = dati_modif_0() 	//--- controlla se ci sono dati modificati personalizzata
		if not k_dati_modificati then
			k_dati_modificati = dati_modif_1()  //--- controlla se ci sono dati modificati standard
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

protected function boolean dati_modif_1 ();//
//--- Controllo se ci sono state modifiche di dati sui DW
//--- Ritorna: false=nessuna modifica; true=dati modificati 
//---        
//
// da modificare x gli eredi



return(false)
end function

protected subroutine attiva_tasti ();
//--- 
//--- script di preparazione menu per attivare/disattivare le singole voci
//---

if ki_st_open_w.flag_primo_giro <> "S" and not ki_exit_si then
	
	attiva_menu_reset( )
   attiva_tasti_0()
   attiva_menu()

	post set_titolo_window_personalizza()

end if
end subroutine

protected subroutine attiva_menu ();//
//
//--- Attiva/Dis. Voci di menu
int k_rc

//--- se non c'e' alcun menu non faccio sta roba
if isvalid(ki_menu) then

//--- se x caso l'oggetto non è buono lo riassegno.... (ma dovrebbe esserlo sempre!)
	//if not isvalid(ki_menu) then	ki_menu = this.menuid

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
	
	if ki_filtra_attivo then
		if ki_menu.m_filtro.enabled <> st_ordina_lista.enabled then
			ki_menu.m_filtro.enabled = st_ordina_lista.enabled 
		end if
	else
		ki_menu.m_filtro.enabled = false
	end if
	if ki_menu.m_trova.m_fin_filtra.enabled <> st_ordina_lista.enabled then
		ki_menu.m_trova.m_fin_filtra.enabled = st_ordina_lista.enabled 
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

	if ki_menu.m_finestra.m_layout_predefinito.enabled <> ki_salva_controlli then
		ki_menu.m_finestra.m_layout_predefinito.enabled = ki_salva_controlli
	end if
	if not ki_menu.m_finestra.m_layout_predefinito.enabled then
		if ki_windowpredef then
			ki_menu.m_finestra.m_layout_predefinito.enabled = ki_windowpredef
		end if
	end if

////--- Appena entra "resetto" la barra degli strumenti
//	if ki_toolbar_programmi_primo_giro then
//		ki_menu.reset_menu_strumenti( )
//	end if
	
//	if ki_toolbar_window_presente then
//		ki_menu.m_strumenti.visible = true
//	else
//		ki_menu.m_strumenti.visible = false
//	end if
	
	ki_menu.u_imposta_window_menu()
	
//	k_rc = this.changemenu(ki_menu)

end if

ki_toolbar_programmi_primo_giro=false
	
end subroutine

protected subroutine riempi_id ();///
//=== Routine di impostazioni campi appena prima della UPDATE
//
end subroutine

protected subroutine toolbar_programmi_aggiungi_voce ();//

//--- visualizza Voce nella Barra dei Programmi
//kGuf_data_base.u_toolbar_programmi_aggiungi(this)

end subroutine

protected subroutine toolbar_programmi_cancella_voce ();//
//kGuf_data_base.u_toolbar_programmi_cancella(this)

end subroutine

protected subroutine toolbar_programmi_attiva_voce ();//
//kGuf_data_base.u_toolbar_programmi_attiva(this)

end subroutine

protected function string inizializza () throws uo_exception;//----
//---- Innescata dalla inizializza_lista (una delle prime funzione chiamate)
//---- da personalizzare di solito qui sta  la retrieve   
//----


attiva_tasti()


return "0"


end function

protected function st_esito aggiorna_window ();//
//======================================================================
//=== Questo metodo e' chiamato quando rientro da una funzione esterna
//=== per cui potrebbe essere necessario lanciare un aggiornamento
//=== dei dati nella windows
//=== 				  
//=== Ritorna st_esito 
//=== 				  
//======================================================================
string k_flag_modalita=""
st_esito kst_esito


	k_flag_modalita = kiuf1_sync_window.get_flag_modalita( )
	
	if k_flag_modalita = kkg_flag_modalita.modifica then
		smista_funz(KKG_FLAG_RICHIESTA.refresh_row)
	else
		smista_funz(kkg_flag_richiesta.refresh)
	end if


return kst_esito


end function

protected subroutine set_titolo_window ();//
	if isnull(ki_st_open_w.id_programma) then
		ki_st_open_w.id_programma = "NULL"
	end if
	if isnull(ki_st_open_w.window_title) then
		ki_st_open_w.window_title = this.title
	end if

	if LenA(trim(ki_st_open_w.window_title )) > 0 then
		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title 
	else
		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + trim(this.title)
	end if
	ki_win_titolo_orig = this.title
	
	this.title += " " + trim(ki_win_titolo_custom)

end subroutine

protected function string inizializza_post ();//
//--- esegua dopo le 'inizializza' (chiamata a da 'inizializza_lista') - meglio chiamarla sempre
//

	if not ki_exit_si then

		this.setredraw(true)
		this.visible = true
		this.enabled = true
		this.SetPosition( topmost! )

	end if	
//	if isvalid(kguo_g.kGuf_trova) then kguo_g.kGuf_trova.post u_set_bringtotop( )


return "0"

end function

protected subroutine open_start_window ();//---
//--- viene lanciata subito nell'evento di OPEN prima di OGNI COSA
//--- e' possibile aggiungere qualsiasi script di inizializzazione come ad esempio la creazione di oggetti 
//---

end subroutine

protected subroutine fine_primo_giro ();	//--- Spengo flag di pimo giro
	if ki_st_open_w.flag_primo_giro = "S" then 
		ki_st_open_w.flag_primo_giro = ""
	end if
	
//	attiva_tasti()

	post fine_primo_giro_post()
	
end subroutine

protected subroutine set_titolo_window_personalizza ();
//=== Personalizzo il titolo con il tipo operazione
choose case trim(ki_st_open_w.flag_modalita) 
	case kkg_flag_modalita.inserimento 
		this.title = ki_win_titolo_orig + ": " +  kkg_flag_modalita.des_inserimento
	case kkg_flag_modalita.modifica 
		this.title = ki_win_titolo_orig + ": " +  kkg_flag_modalita.des_Modifica
	case kkg_flag_modalita.visualizzazione 
		this.title = ki_win_titolo_orig + ": " +  kkg_flag_modalita.des_Visualizzazione
	case KKG_FLAG_RICHIESTA.cancellazione 
		this.title = ki_win_titolo_orig + ": " +  kkg_flag_modalita.des_Cancellazione
	case else
		this.title = ki_win_titolo_orig 
end choose

this.title += " " + trim(ki_win_titolo_custom)

end subroutine

public subroutine set_window_size ();//
//--- Durante la OPEN: Dimensione e Posizione Window come da ultimo utilizzo
//

u_win_open()


end subroutine

protected subroutine dati_modif_accept ();//
//--- ACCETTA DATI VIDEO: FARE LA ACCEPT DEI DATI 
//
//es.:





end subroutine

public function boolean u_trova_in_dw (string a_flag_richiesta);//
//--- Richiesta della funzione TROVA e TROVA ANCORA
//--- se mail lanciata crea l'oggetto
//--- TRUE = richiesta OK (anche se non trova nulla)
//
boolean k_return = false
//graphicobject kgrfobj_trova

try
	if not isvalid(kguo_g.kGuf_trova) then kguo_g.kGuf_trova = create kuf_trova
	
	k_return = kguo_g.kGuf_trova.u_attiva_funzione_trova(a_flag_richiesta, kiw_this_window ) 

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


return k_return
 
end function

protected subroutine stampa_esegui (st_stampe ast_stampe);//



end subroutine

public function string dati_modif_figlio_inizio (string k_titolo);//
//---- chiamata a INIZIO della funzione DATI_MODIF da utilizzare x gli oggetti ereditati 
string k_return = "0"


return k_return
end function

public subroutine dati_modif_figlio_fine (string k_titolo);//
//---- chiamata a FINE della funzione DATI_MODIF da utilizzare x gli oggetti ereditati 

end subroutine

public subroutine pulizia_righe ();//---- 
//--- toglie dati prima dell'aggiornamento (riempita dagli eredi)
//---

end subroutine

protected function boolean dati_modif_0 ();//---
//--- Controllo se ci sono state modifiche di dati sui DW
//--- Ritorna: false=nessuna modifica; true=dati modificati 
//---        
//
// da modificare x gli eredi in modo personale


return(false)
end function

protected subroutine fine_primo_giro_post ();//--- Spengo flag di pimo giro
//	this.setfocus( )
	
	
end subroutine

public function boolean u_filtra_in_dw ();//
//--- Attiva window x  filtrare in elenco i valori richiesti
//
boolean k_return = false
graphicobject kgfrobj_1

	
//--- ricava dw su cui effettuare il filtro
	if isvalid(kidw_selezionata) then
		kgfrobj_1 = kidw_selezionata
	else
		kgfrobj_1 = getfocus() //get_obj_trova()
	end if

	if not isvalid(kidw_selezionata) then
//		messagebox("Funzione di filtro", "Selezionare la window su cui effettuare il filtro e riprovare")
	else
		
//--- se e' un DW allora fa il filtro sulle colonne tipo EXCEL		
		if kgfrobj_1.typeof( ) = DataWindow! then
			kidw_selezionata = kgfrobj_1
			
			if kidw_selezionata.Object.DataWindow.Processing = "1" then

				kidw_selezionata.event u_set_powerfilter( )
				k_return = true
				
			end if
			
		else
		
			if not isvalid(kiuf_filtra) then kiuf_filtra = create kuf_filtra
			k_return = kiuf_filtra.u_attiva_filtro(kgfrobj_1, kiw_this_window, kiw_this_window.title)
			
		end if
	end if
//	if NOT k_return then destroy kuf_filtra
	
return k_return

end function

public function boolean u_ordina_in_dw ();//=== Possibilita' di filtrare su una colonna i valori richiesti
boolean k_return = false
string k_x
datawindow kdw_1

	
//--- fisso l'elenco di ricerca 	
	if isvalid(kidw_selezionata) then
		kdw_1 = kidw_selezionata
	else
		kdw_1 = getfocus() //get_obj_trova()
	end if
	
	if isvalid(kdw_1) then
		if kdw_1.rowcount() > 1 then
		
			setnull(k_x)
			kdw_1.setsort(k_x)
			kdw_1.SetRedraw (false)
			kdw_1.sort()
			kdw_1.GroupCalc()
			kdw_1.SetRedraw (true)
			kdw_1.setfocus()
			
//			attiva_tasti()
			k_return = true
		end if
	end if

return k_return 


end function

private subroutine u_dw_cut_valore ();//
//--- Copia valore dal campo
//
string k_valore
int k_rc
GraphicObject  kgo_1
datawindow kdw_1
MultiLineEdit kmle_1
SingleLineEdit ksle_1
RichTextEdit krte_1
InkEdit kie_1


kgo_1 = getfocus() 
if kgo_1.typeof( ) = MultiLineEdit! then
	kmle_1 = kgo_1
	k_rc = kmle_1.copy( ) //prima tenta // Ctrl+C con il COPY (campi di edit)
elseif kgo_1.typeof( ) = SingleLineEdit! then
	ksle_1 = kgo_1
	k_rc = ksle_1.copy( ) //prima tenta // Ctrl+C con il COPY (campi di edit)
elseif kgo_1.typeof( ) = RichTextEdit! then
	krte_1 = kgo_1
	k_rc = krte_1.copy( ) //prima tenta // Ctrl+C con il COPY (campi di edit)
elseif kgo_1.typeof( ) = InkEdit! then
	kie_1 = kgo_1
	k_rc = kie_1.copy( ) //prima tenta // Ctrl+C con il COPY (campi di edit)

elseif kgo_1.typeof( ) = datawindow! then
	
	
	kdw_1 = kgo_1
	
//--- fisso l'elenco di ricerca 	
//	if isvalid(kidw_selezionata) then
//		kdw_1 = kidw_selezionata
//	else
//		kdw_1 = getfocus() //get_obj_trova()
//	end if

	if isvalid(kdw_1) then
		if kdw_1.rowcount() > 0 then

			k_rc = kdw_1.copy( ) //prima tenta // Ctrl+C con il COPY (campi di edit)
			if	k_rc > 0 then  
			else

				k_valore = kdw_1.Describe("DataWindow.Selected.Data") // poi tenta così per selezioni su campi protetti ma con Mouse-selection attivo
				Clipboard(trim(k_valore))   // Ctrl+C
		

//			k_valore = kdw_1.Describe( "Datawindow.Selected" ) //<start row>/<end row>/<start column>/<end column>
//			k_pos = pos(k_valore, "/")
//			if k_pos > 0 then
//				pos(k_valore, "/", k_pos)
//			end if
//			if k_pos > 0 then
//				k_valore = mid(k_valore, k_pos+1)
//			end if
//			IF Trim( k_valore ) > 0 AND NOT ls_range = "!" AND NOT ls_range = "?" THEN 
//				k_pos_ini = pos(k_valore, "/", 0)
//				k_pos_fin = pos(k_valore, "/", k_pos_ini+1)
//				IF k_pos_ini > 0 AND k_pos_fin > 0 THEN 
//					IF k_pos_ini < k_pos_fin THEN 
//						FOR k_riga = k_pos_ini TO k_pos_fin 
//							this.SelectRow( k_riga, TRUE ) 
//						NEXT 
//					ELSEIF k_pos_ini > k_pos_fin THEN 
//						FOR k_riga = k_pos_ini TO k_pos_fin STEP -1 
//							this.SelectRow( k_riga, TRUE ) 
//						NEXT 
//					ELSE // a single row is selected -- do nothing 
//					END IF 
//				END IF 
//			END IF 
			
			end if
			
		end if
	end if
end if
	
end subroutine

public function boolean u_open_proprieta ();//
boolean k_return = false
kuf_base kuf1_base
st_open_w kst_open_w

kuf1_base = create kuf_base

kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.key2 = "utente"

k_return = kuf1_base. u_open(kst_open_w)

destroy kuf1_base

return k_return

end function

protected subroutine attiva_menu_reset ();//
//

kGuo_g.kgw_attiva = this

//--- se non c'e' alcun menu non faccio sta roba
if isvalid(ki_menu) then
//--- Disattiva i campi libero
	ki_menu.reset_menu_all( )
end if

	
end subroutine

protected subroutine attiva_tasti_0 ();
//--- 
//--- script prevalente nel discendente
//---
   cb_ritorna.enabled = true
   st_stampa.enabled = true
   
	
end subroutine

public subroutine u_win_ripri_video ();
//
//--- Ripristino delle posizioni degli oggetti della window
//
	u_resize_predefinita( ) 

end subroutine

public subroutine u_resize_1 ();//
	super::u_resize_1()
	

end subroutine

public function boolean u_window_control_restore ();//
boolean k_return = false

	if ki_personalizza_pos_controlli then
		k_return = super::u_window_control_restore( )
	end if 

return k_return
end function

protected subroutine inizializza_lista ();//----
//---- Innescata tra le prime funzioni
//---- puo' essere personalizzata ma meglio lasciar fare al codice delle window figlie tipo w_g_tab0 / w_g_tab3
//----

end subroutine

event open;call super::open;//
//=== Parametri di Input : 1  lung 2   scelta; 
//===								3  lung 20  Key principale
//===								23 lung 1   's'=adatta windows alla definiz.
//===								24 lung 26  Libero x future implem
//===								50 lung ??  Personalizzabile
//===								
//
long k_ctr


//--- INIZIO OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

//sembra nascondere il puntatore	this.setredraw(false)
	
//--- Importante: personalizzazione x i figli	
	event u_open_preliminari()   

////--- Menu Window
//	if this.windowtype = response! or this.windowtype = popup! then
//	else
//		post set_window_size()	
//
//		ki_menu = ki_menu
// 		this.ChangeMenu (ki_menu)
//		ki_menu.autorizza_menu( )
//		ki_menu.u_inizializza( )
//	end if
// 
//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	kGuo_g.kgw_attiva = this
	
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

	
//--- altre operazioni
	post event u_open( )
	post attiva_tasti( )

//	setpointer(kkg.pointer_default)		


end event

on w_g_tab.create
int iCurrent
call super::create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.st_ritorna=create st_ritorna
this.st_ordina_lista=create st_ordina_lista
this.st_aggiorna_lista=create st_aggiorna_lista
this.cb_ritorna=create cb_ritorna
this.st_stampa=create st_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ritorna
this.Control[iCurrent+2]=this.st_ordina_lista
this.Control[iCurrent+3]=this.st_aggiorna_lista
this.Control[iCurrent+4]=this.cb_ritorna
this.Control[iCurrent+5]=this.st_stampa
end on

on w_g_tab.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_ritorna)
destroy(this.st_ordina_lista)
destroy(this.st_aggiorna_lista)
destroy(this.cb_ritorna)
destroy(this.st_stampa)
end on

event close;//---
//---
u_win_close()
//if isvalid(ki_menu) then
//	ki_menu.post u_close_window()
//end if

 

end event

event activate;//---
if not ki_exit_si and not kguo_g.kG_exit_si then
	
	if ki_st_open_w.flag_primo_giro <> 'S' then
	
		event u_activate( )
	
	end if
	
end if

end event

event deactivate;//
	ki_sincronizza_window_gia_check=false
	ki_toolbar_programmi_attiva_voce=true

//
end event

event closequery;call super::closequery;//
ki_exit_si = true   //--- info che sono in uscita

end event

type st_ritorna from statictext within w_g_tab
boolean visible = false
integer x = 1390
integer y = 916
integer width = 448
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "NON USARE!!!"
boolean focusrectangle = false
end type

event clicked;//
ki_exit_si = true

end event

type st_ordina_lista from statictext within w_g_tab
boolean visible = false
integer x = 1390
integer y = 1160
integer width = 882
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "x ordinare o meno i dw di elenchi"
boolean focusrectangle = false
end type

type st_aggiorna_lista from statictext within w_g_tab
boolean visible = false
integer x = 1390
integer y = 1076
integer width = 1001
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "x poter rileggere i/il dw (elenco e non)"
boolean focusrectangle = false
end type

type cb_ritorna from commandbutton within w_g_tab
boolean visible = false
integer x = 1390
integer y = 800
integer width = 402
integer height = 64
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Esci"
end type

event clicked;//
if not ki_exit_si then
	
	ki_exit_si = true
	close(parent)
	
end if		
end event

type st_stampa from statictext within w_g_tab
boolean visible = false
integer x = 1390
integer y = 992
integer width = 622
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "x stampare il dw"
boolean focusrectangle = false
end type

