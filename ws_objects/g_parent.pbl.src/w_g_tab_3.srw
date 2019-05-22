$PBExportHeader$w_g_tab_3.srw
forward
global type w_g_tab_3 from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab_3
end type
type cb_modifica from commandbutton within w_g_tab_3
end type
type cb_aggiorna from commandbutton within w_g_tab_3
end type
type cb_cancella from commandbutton within w_g_tab_3
end type
type cb_inserisci from commandbutton within w_g_tab_3
end type
type tab_1 from tab within w_g_tab_3
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from uo_d_std_1 within tabpage_1
end type
type st_1_retrieve from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
st_1_retrieve st_1_retrieve
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from uo_d_std_1 within tabpage_2
end type
type st_2_retrieve from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
st_2_retrieve st_2_retrieve
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from uo_d_std_1 within tabpage_3
end type
type st_3_retrieve from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
st_3_retrieve st_3_retrieve
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from uo_d_std_1 within tabpage_4
end type
type st_4_retrieve from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
st_4_retrieve st_4_retrieve
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from uo_d_std_1 within tabpage_5
end type
type st_5_retrieve from statictext within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
st_5_retrieve st_5_retrieve
end type
type tabpage_6 from userobject within tab_1
end type
type st_6_retrieve from statictext within tabpage_6
end type
type dw_6 from uo_d_std_1 within tabpage_6
end type
type tabpage_6 from userobject within tab_1
st_6_retrieve st_6_retrieve
dw_6 dw_6
end type
type tabpage_7 from userobject within tab_1
end type
type st_7_retrieve from statictext within tabpage_7
end type
type dw_7 from uo_d_std_1 within tabpage_7
end type
type tabpage_7 from userobject within tab_1
st_7_retrieve st_7_retrieve
dw_7 dw_7
end type
type tabpage_8 from userobject within tab_1
end type
type st_8_retrieve from statictext within tabpage_8
end type
type dw_8 from uo_d_std_1 within tabpage_8
end type
type tabpage_8 from userobject within tab_1
st_8_retrieve st_8_retrieve
dw_8 dw_8
end type
type tabpage_9 from userobject within tab_1
end type
type st_9_retrieve from statictext within tabpage_9
end type
type dw_9 from uo_d_std_1 within tabpage_9
end type
type tabpage_9 from userobject within tab_1
st_9_retrieve st_9_retrieve
dw_9 dw_9
end type
type tab_1 from tab within w_g_tab_3
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type
type st_duplica from statictext within w_g_tab_3
end type
end forward

global type w_g_tab_3 from w_g_tab
integer width = 2409
integer height = 1576
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_aggiorna cb_aggiorna
cb_cancella cb_cancella
cb_inserisci cb_inserisci
tab_1 tab_1
st_duplica st_duplica
end type
global w_g_tab_3 w_g_tab_3

type variables
protected boolean ki_fai_nuovo_dopo_update = true
protected boolean ki_fai_nuovo_dopo_insert = true
protected boolean ki_fai_exit_dopo_update = false
protected boolean ki_fai_inizializza_dopo_update = false
protected boolean ki_fai_proteggi_dopo_update = false    // forza visualizzazione così da proteggere la mappa
protected boolean ki_msg_dopo_update = true
protected string ki_syntaxquery=" "
protected long ki_riga_x_riposizioamento = 0
protected string ki_dw_titolo_modif_1 = " "   //--- qui il titolo del TAB modificato
protected boolean ki_esci_dopo_cancella = false
protected boolean ki_attiva_tasti_vmi=false // questa serve x ad gli ausiliari, mentre sono in visualizz. cambio in modfifica al volo
protected integer ki_tab_1_index_new=0
protected integer ki_tab_1_index_old=0
protected boolean ki_tabpage_visible[10] // memorizza i tabpage visibili e no 
//protected uo_d_std_1 kidw_tabselezionato  // in inizializza_lista viene impostato il DW attivo
protected string ki_UsitaImmediata="E"  // da impostare soprattutto nelle INIZIALIZZA se si vuole uscire subito 
protected boolean ki_consenti_duplica=false

end variables

forward prototypes
protected function string check_dati ()
protected function integer cancella ()
protected function integer conferma ()
protected function integer visualizza ()
protected subroutine doppio_click ()
protected subroutine pulizia_righe ()
protected function string aggiorna_dati ()
protected subroutine smista_funz (string k_par_in)
protected function string aggiorna ()
protected function integer inserisci ()
protected function boolean dati_modif_1 ()
protected subroutine inizializza_lista ()
protected subroutine attiva_menu ()
protected subroutine inizializza_1 () throws uo_exception
protected subroutine inizializza_2 () throws uo_exception
protected subroutine inizializza_3 () throws uo_exception
protected subroutine inizializza_4 () throws uo_exception
protected subroutine inizializza_5 () throws uo_exception
protected subroutine inizializza_6 () throws uo_exception
protected subroutine inizializza_7 () throws uo_exception
protected subroutine inizializza_8 () throws uo_exception
protected function integer importa_dati_da_ultima_exit ()
protected subroutine riposiziona_cursore ()
protected subroutine riposiziona_cursore_salva_riga ()
protected subroutine riposiziona_cursore_sulla_riga (ref datawindow kdw_1, long k_riga)
protected function string inizializza_post ()
protected subroutine u_personalizza_dw ()
protected function st_esito aggiorna_dw (ref datawindow kdw_1, string k_titolo)
public subroutine cancella_dati ()
protected subroutine dati_modif_accept ()
protected function string dati_modif_figlio_inizio (string a_1)
protected subroutine dati_modif_figlio_fine (string a_1)
protected function string leggi_riga ()
protected subroutine stampa_esegui (st_stampe ast_stampe)
public function string u_attiva_tab (integer a_tab_da_attivare)
protected function string inizializza () throws uo_exception
protected subroutine u_set_dw_obsoleto ()
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
protected function string aggiorna_dw_0 (datawindow adw_1, string a_titolo, string a_return)
protected function boolean dati_modif_dw (ref uo_d_std_1 auo_d_std_1)
public function boolean u_duplica () throws uo_exception
end prototypes

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito,kst_esito1
datastore kds_inp

try
	kds_inp = create datastore

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Controllo il primo tab
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		kds_inp.dataobject = tab_1.tabpage_1.dw_1.dataobject
		tab_1.tabpage_1.dw_1.rowscopy( 1,tab_1.tabpage_1.dw_1.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_parent.u_check_dati(kds_inp)
	end if
	
//--- Controllo altro tab
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		if  tab_1.tabpage_2.dw_2.enabled then
			kds_inp.dataobject = tab_1.tabpage_2.dw_2.dataobject
			tab_1.tabpage_2.dw_2.rowscopy( 1,tab_1.tabpage_2.dw_2.rowcount( ) ,primary!, kds_inp, 1, primary!)
			kst_esito1 = kiuf_parent.u_check_dati(kds_inp)
			if kst_esito1.esito <> kkg_esito.ok then
				if kst_esito.esito <> kkg_esito.ok then
					kst_esito.esito = kst_esito1.esito
					kst_esito.sqlerrtext = tab_1.tabpage_1.text + ": " + kst_esito.sqlerrtext + " " + tab_1.tabpage_2.text + ": " + kst_esito1.sqlerrtext
				else
					kst_esito = kst_esito1
					kst_esito.sqlerrtext = tab_1.tabpage_2.text + ": " + kst_esito.sqlerrtext 
				end if
			end if
		end if	
	end if	
	
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

protected function integer cancella ();//
//--- Da personalizzare nei figli x cancellare righe sul DB
//

return(0)
end function

protected function integer conferma ();//
//=== Aggiornamento dei dati inseriti/modificati
string k_errore = "0 "



//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore = aggiorna_dati()

return (0)
end function

protected function integer visualizza ();//---
//--- personalizza routine di visualizzazione
kuf_utility kuf1_utility



if tab_1.selectedtab = 1 then

	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	inizializza_lista()

else

//	u_get_dw( )
	//kidw_tabselezionato
	kidw_selezionata.ki_flag_modalita = kkg_flag_modalita.visualizzazione 
	
//--- Protezione campi
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, kidw_selezionata)
	destroy kuf1_utility

end if


return(0)
end function

protected subroutine doppio_click ();
end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE
//
//string k_key
//long k_riga, k_ctr
//
//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
//k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		k_key = tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 1) 
// 		if isnull(k_key) or len(trim(k_key)) = 0 then
//			tab_1.tabpage_1.dw_1.deleterow(k_ctr)
//		end if
//	end if
//next
//
//k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		k_key = tab_1.tabpage_2.dw_2.getitemstring(k_ctr, 1) 
// 		if isnull(k_key) or len(trim(k_key)) = 0 then
//			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
//		end if
//	end if
//next
//
//k_riga = tab_1.tabpage_3.dw_3.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_3.dw_3.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		k_key = tab_1.tabpage_3.dw_3.getitemstring(k_ctr, 1) 
// 		if isnull(k_key) or len(trim(k_key)) = 0 then
//			tab_1.tabpage_3.dw_3.deleterow(k_ctr)
//		end if
//	end if
//next
//
//k_riga = tab_1.tabpage_4.dw_4.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_4.dw_4.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		k_key = tab_1.tabpage_4.dw_4.getitemstring(k_ctr, 1) 
// 		if isnull(k_key) or len(trim(k_key)) = 0 then
//			tab_1.tabpage_4.dw_4.deleterow(k_ctr)
//		end if
//	end if
//next
//
//k_riga = tab_1.tabpage_5.dw_5.rowcount ( )
//for k_ctr = k_riga to 1 step -1
//
//	if tab_1.tabpage_5.dw_5.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
//		k_key = tab_1.tabpage_5.dw_5.getitemstring(k_ctr, 1) 
// 		if isnull(k_key) or len(trim(k_key)) = 0 then
//			tab_1.tabpage_5.dw_5.deleterow(k_ctr)
//		end if
//	end if
//next
//
//
end subroutine

protected function string aggiorna_dati ();string k_return
long k_id


//--- Aggiornamento dei dati inseriti/modificati
dati_modif_accept( )

//--- Toglie le righe eventualmente da non registrare
pulizia_righe()

k_return = super::aggiorna_dati()

if left(k_return, 1) = "0" then

	if not ki_exit_si then

		if ki_msg_dopo_update then
			messagebox("Operazione eseguita", "Dati aggiornati correttamente")
		end if

	//--- Disatt.moment.la funz.di 'aggiorna' fino a mod. un dato
		tab_1.tabpage_1.dw_1.ki_disattiva_moment_cb_aggiorna = true
	
		choose case true
				
			case ki_fai_nuovo_dopo_update or (ki_fai_nuovo_dopo_insert and ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento)
				if ki_fai_nuovo_dopo_update and cb_inserisci.enabled then
					if (ki_fai_nuovo_dopo_insert and cb_inserisci.enabled and ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento) &
													or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
						ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
						cb_inserisci.postevent(clicked!)
						POST attiva_tasti()
					end if
				end if
				
			case ki_fai_inizializza_dopo_update			
				this.inizializza_lista( )
				
			case ki_fai_proteggi_dopo_update
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
				visualizza( )
				
			case ki_fai_exit_dopo_update 
				cb_ritorna.postevent(clicked!)   // EXIT!!
	//			post close(this)
	
			case else
				POST attiva_tasti()
	
		end choose
	end if
else
	
	post attiva_tasti()
	
end if


	
	
return k_return
end function

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case k_par_in 

	case KKG_FLAG_RICHIESTA.refresh_row		//Aggiorna la riga se riesce altrimenti rilegge tutto: leggi_liste()
		leggi_riga()
		
	case KKG_FLAG_RICHIESTA.refresh		//rilegge lista
		try
			inizializza_lista()
		catch (uo_exception kuo_exception1)
		end try

//	case KKG_FLAG_RICHIESTA.refresh		//riordina lista
//		riordina_lista()

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta visualizzazione
		if cb_visualizza.enabled = true then
			cb_visualizza.triggerevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.modifica		//richiesta modifica
		if cb_modifica.enabled = true then
			cb_modifica.triggerevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.triggerevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.triggerevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.conferma		//richiesta conferma
		if cb_aggiorna.enabled = true then
			cb_aggiorna.triggerevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.duplica		//richiesta Duplica
		if st_duplica.enabled = true then
			st_duplica.postevent(clicked!)
		end if

	case else
		super::smista_funz(k_par_in)

end choose


//return k_return



end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle  
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================
 
string k_return, k_errore="0", k_errore1="0 "
st_esito kst_esito


//=== Puntatore Cursore da attesa..... 
SetPointer(kkg.pointer_attesa)

k_return = k_errore + k_return

//=== Aggiorna, se modificato, la TAB_1	
k_return = aggiorna_dw_0 (tab_1.tabpage_1.dw_1,  tab_1.tabpage_1.text, k_return)

//=== Aggiorna, se modificato, la TAB_2
k_return = aggiorna_dw_0 (tab_1.tabpage_2.dw_2,  tab_1.tabpage_2.text, k_return)

//=== Aggiorna, se modificato, la TAB_3
k_return = aggiorna_dw_0 (tab_1.tabpage_3.dw_3,  tab_1.tabpage_3.text, k_return)

//=== Aggiorna, se modificato, la TAB_4
k_return = aggiorna_dw_0 (tab_1.tabpage_4.dw_4,  tab_1.tabpage_4.text, k_return)

//=== Aggiorna, se modificato, la TAB_5
k_return = aggiorna_dw_0 (tab_1.tabpage_5.dw_5,  tab_1.tabpage_5.text, k_return)

//=== Aggiorna, se modificato, la TAB_6
k_return = aggiorna_dw_0 (tab_1.tabpage_6.dw_6,  tab_1.tabpage_6.text, k_return)

//=== Aggiorna, se modificato, la TAB_7
k_return = aggiorna_dw_0 (tab_1.tabpage_7.dw_7,  tab_1.tabpage_7.text, k_return)

//=== Aggiorna, se modificato, la TAB_8
k_return = aggiorna_dw_0 (tab_1.tabpage_8.dw_8,  tab_1.tabpage_8.text, k_return)

//=== Aggiorna, se modificato, la TAB_9
k_return = aggiorna_dw_0 (tab_1.tabpage_9.dw_9,  tab_1.tabpage_9.text, k_return)


k_errore = left(k_return,1)
k_return = mid(k_return,2)

//=== Puntatore Cursore da attesa.....
SetPointer(kkg.pointer_default)


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if k_errore = "1" then
	messagebox("Falliti Aggiornamenti", &
		trim(k_return), & 
			stopsign!)
else
	if k_errore = "3" then
		messagebox("Operazione di 'Commit' in anomalia", &
			"Controllare e ripetere le operazioni eseguite", &
			stopsign!)
	else
		if k_errore = "2" then
			messagebox("Operazioni Fallita", &
								"Si sono verificati alcuni errori in registrazione dati:~n~r"  &
					   		+ trim(k_return), stopsign! )
		else
			if trim(k_return) > " " then
			else
				k_errore = "2"
				k_return = "Nessun dato caricato o aggiornato in archivio"
				messagebox("Operazione conclusa", &
									trim(k_return), information! )
			end if
		end if
	end if
end if


return k_errore + trim(k_return)

end function

protected function integer inserisci ();//
int k_return=1
string k_errore="0 "
long k_ctr
datawindow kdw_x

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if
ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
tab_1.tabpage_1.dw_1.reset( )
tab_1.tabpage_2.dw_2.reset( )
tab_1.tabpage_3.dw_3.reset( )
tab_1.tabpage_4.dw_4.reset( )
tab_1.tabpage_5.dw_5.reset( )
tab_1.tabpage_6.dw_6.reset( )
tab_1.tabpage_7.dw_7.reset( )
tab_1.tabpage_8.dw_8.reset( )
tab_1.tabpage_9.dw_9.reset( )


if left(k_errore, 1) = "0" then

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
		case 7
			kdw_x = tab_1.tabpage_7.dw_7
		case 8
			kdw_x = tab_1.tabpage_8.dw_8
		case 9
			kdw_x = tab_1.tabpage_9.dw_9
	end choose	

	tab_1.tabpage_1.dw_1.reset()
	k_ctr = kdw_x.insertrow(0)
	kdw_x.scrolltorow(k_ctr)
	kdw_x.setrow(k_ctr)
	kdw_x.setcolumn(1)


	k_return = 0
end if

return (k_return)
end function

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no   poi   valorizza ki_dw_titolo_modif_1 con il Titolo del TAB modificato
//
boolean k_return = false
boolean k_boolean = false

//--- Aggiornamento dei dati inseriti/modificati
	dati_modif_accept( )

	
	ki_dw_titolo_modif_1 = ""

	k_boolean =  dati_modif_dw(tab_1.tabpage_1.dw_1) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_2.dw_2) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_3.dw_3) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_4.dw_4) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_5.dw_5) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_6.dw_6) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_7.dw_7) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_8.dw_8) 
	if k_boolean then k_return = true
	k_boolean =  dati_modif_dw(tab_1.tabpage_9.dw_9) 
	if k_boolean then k_return = true
		
			
return k_return
			
	

end function

protected subroutine inizializza_lista ();//---
//---
//--- Innescata come Prima funzione (da NON personalizzare)
//--- 
//---
string k_errore="0 ", k_esito = "0", k_ret_u_attiva_tab=""
//datawindow kdw_1
   


try

	setpointer(kkg.pointer_attesa)	
	
//	//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//	if ki_st_open_w.flag_primo_giro <> 'S' then //se NO giro di prima volta
//		if cb_inserisci.enabled or cb_aggiorna.enabled or cb_cancella.enabled = true then
//	
//			k_esito = dati_modif("")
//			if len(k_esito) > 0 then 
//			else
//				k_esito = "0"
//			end if
//			if left(k_esito, 1) = "1" then 
//	
//	//=== Controllo congruenza dei dati caricati e Aggiornamento  
//	//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//	//===                : 2=errore non grave dati aggiornati;
//	//===			         : 3=LIBERO
//	//===      il resto della stringa contiene la descrizione dell'errore   
//				k_errore = aggiorna_dati()
//				
//			end if
//		end if
//	end if
	

//	setpointer(kkg.pointer_attesa)	
	
	//tab_1.visible = true
	
	if left(k_errore, 1) = "0" then
	
		riposiziona_cursore_salva_riga() // salva la posizione del cursore 
	
//		kidw_selezionata.st_1_retrieve.text = " "
		
//--- resetta i DW ma soprattutto chiama la INIZIALIZZ() da tab_1.selectionchanging 
		choose case tab_1.selectedtab 
			case 1 
//				kdw_1 = tab_1.tabpage_1.dw_1
//				tab_1.tabpage_1.dw_1.ki_flag_modalita = ki_st_open_w.flag_modalita
				tab_1.tabpage_1.st_1_retrieve.text = " "
//				
//				if tab_1.tabpage_1.dw_1.enabled then
//					tab_1.tabpage_1.dw_1.visible = true 
//				end if
//
			case 2
//				kdw_1 = tab_1.tabpage_2.dw_2
				tab_1.tabpage_2.st_2_retrieve.text = " "
//
			case 3
//				kdw_1 = tab_1.tabpage_3.dw_3
				tab_1.tabpage_3.st_3_retrieve.text = " "
//
			case 4
//				kdw_1 = tab_1.tabpage_4.dw_4
				tab_1.tabpage_4.st_4_retrieve.text = " "
//
			case 5
//				kdw_1 = tab_1.tabpage_5.dw_5
				tab_1.tabpage_5.st_5_retrieve.text = " "
//
			case 6
//				kdw_1 = tab_1.tabpage_6.dw_6
				tab_1.tabpage_6.st_6_retrieve.text = " "
//
			case 7
//				kdw_1 = tab_1.tabpage_7.dw_7
				tab_1.tabpage_7.st_7_retrieve.text = " "
//
			case 8
//				kdw_1 =  tab_1.tabpage_8.dw_8
				tab_1.tabpage_8.st_8_retrieve.text = " "
//	
			case 9
//				kdw_1 = tab_1.tabpage_9.dw_9
				tab_1.tabpage_9.st_9_retrieve.text = " "
//
		end choose	
//		if isvalid(kidw_selezionata) then
//			if kidw_selezionata.visible then
//				kidw_tabselezionato = kidw_selezionata
//			end if
	
		if isvalid(kidw_selezionata) then
			kidw_selezionata.reset()
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
				u_resize()
				kidw_selezionata.visible=true
				kidw_selezionata.SetRedraw (true)
				tab_1.visible = true
			else
				kidw_selezionata.SetRedraw (false)
			end if
			k_ret_u_attiva_tab = u_attiva_tab(tab_1.SelectedTab)   // Lancia  INIZIALIZZA_...
			kidw_selezionata.visible=true
			kidw_selezionata.SetRedraw (true)
		else
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then
				u_resize()
			end if
			k_ret_u_attiva_tab = u_attiva_tab(tab_1.SelectedTab)   // Lancia  INIZIALIZZA_...
		end if
//		end if
	end if

	if trim(k_ret_u_attiva_tab) = ki_UsitaImmediata then //USCITA IMMEDIATA
		cb_ritorna.post event clicked( )
	
	else
//--- meglio non personalizzarla		
		inizializza_post()
		if isvalid(kidw_selezionata) then
			kidw_selezionata.ki_flag_modalita = ki_st_open_w.flag_modalita
		end if
		tab_1.visible = true
	end if
	

catch (uo_exception kuo_exception)
	
finally
//	setpointer(kkg.pointer_default)	


end try
	

end subroutine

protected subroutine attiva_menu ();//
boolean k_dati_modificati=false

if ki_st_open_w.flag_primo_giro <> 'S' then

	//--- se non c'e' alcun menu non faccio sta roba
	if isvalid(ki_menu) then
	
	//--- se almeno un dato un un dw e' stato modificato attivo comando aggiorna
		if ki_st_open_w.flag_primo_giro <> 'S' then
	
	//--- controlla se ci sono dati modificati		
			k_dati_modificati = dati_modif_0() 	//--- controlla se ci sono dati modificati personalizzata
			if not k_dati_modificati then
				k_dati_modificati = dati_modif_1()  //--- controlla se ci sono dati modificati standard
			end if
			if k_dati_modificati then // se ci sono dato midificati chiedo se aggiornare
	//		if dati_modif_1() then
				ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled = cb_aggiorna.enabled
			else
				ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled = false
			end if
		else
			ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled = false
		end if
	
		if ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled <> cb_inserisci.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
		end if
		if ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled <> cb_modifica.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
		end if
		if ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled <> cb_cancella.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_elimina.enabled = cb_cancella.enabled
		end if
		if ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled <> cb_visualizza.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
		end if
		if ki_menu.m_finestra.m_fin_stampa.enabled <> st_stampa.enabled then
			ki_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled
		end if
		if ki_menu.m_finestra.m_gestione.m_fin_duplica.enabled <> st_duplica.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_duplica.enabled = st_duplica.enabled 
		end if
	
	//--- attiva voci menu standard
		super::attiva_menu()
		
	end if
end if	

end subroutine

protected subroutine inizializza_1 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//
end subroutine

protected subroutine inizializza_2 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//
end subroutine

protected subroutine inizializza_3 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
	



end subroutine

protected subroutine inizializza_4 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
	



end subroutine

protected subroutine inizializza_5 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

protected subroutine inizializza_6 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

protected subroutine inizializza_7 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

protected subroutine inizializza_8 () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

protected function integer importa_dati_da_ultima_exit ();//
//--- Ripristino i valori come daultima exit da programma
long k_riga

	k_riga = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), tab_1.tabpage_1.dw_1) 
	if isnull(k_riga) then
		k_riga = 0
	end if

return k_riga

end function

protected subroutine riposiziona_cursore ();//
long k_riga = 0

if ki_riga_x_riposizioamento > 0 then
	

	try 
		choose case tab_1.selectedtab 
			case 1 
				riposiziona_cursore_sulla_riga(tab_1.tabpage_1.dw_1, ki_riga_x_riposizioamento)
			case 2
				riposiziona_cursore_sulla_riga(tab_1.tabpage_2.dw_2, ki_riga_x_riposizioamento)
			case 3
				riposiziona_cursore_sulla_riga(tab_1.tabpage_3.dw_3, ki_riga_x_riposizioamento)
			case 4
				riposiziona_cursore_sulla_riga(tab_1.tabpage_4.dw_4, ki_riga_x_riposizioamento)
			case 5
				riposiziona_cursore_sulla_riga(tab_1.tabpage_5.dw_5, ki_riga_x_riposizioamento)
			case 6
				riposiziona_cursore_sulla_riga(tab_1.tabpage_6.dw_6, ki_riga_x_riposizioamento)
			case 7
				riposiziona_cursore_sulla_riga(tab_1.tabpage_7.dw_7, ki_riga_x_riposizioamento)
			case 8
				riposiziona_cursore_sulla_riga(tab_1.tabpage_8.dw_8, ki_riga_x_riposizioamento)
			case 9
				riposiziona_cursore_sulla_riga(tab_1.tabpage_9.dw_9, ki_riga_x_riposizioamento)
		end choose	
	
	catch (uo_exception kuo_exception1)
		kuo_exception1.messaggio_utente()
	finally
	end try

end if

	
end subroutine

protected subroutine riposiziona_cursore_salva_riga ();//

ki_riga_x_riposizioamento = 0
	

	try 
		choose case tab_1.selectedtab 
			case 1 
				if tab_1.tabpage_1.dw_1.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_1.dw_1.getselectedrow(0)
				end if
			case 2
				if tab_1.tabpage_2.dw_2.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_2.dw_2.getselectedrow(0)
				end if
			case 3
				if tab_1.tabpage_3.dw_3.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_3.dw_3.getselectedrow(0)
				end if
			case 4
				if tab_1.tabpage_4.dw_4.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_4.dw_4.getselectedrow(0)
				end if
			case 5
				if tab_1.tabpage_5.dw_5.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_5.dw_5.getselectedrow(0)
				end if
			case 6
				if tab_1.tabpage_6.dw_6.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_6.dw_6.getselectedrow(0)
				end if
			case 7
				if tab_1.tabpage_7.dw_7.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_7.dw_7.getselectedrow(0)
				end if
			case 8
				if tab_1.tabpage_8.dw_8.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_8.dw_8.getselectedrow(0)
				end if
			case 9
				if tab_1.tabpage_9.dw_9.rowcount() > 0 then
					ki_riga_x_riposizioamento = tab_1.tabpage_9.dw_9.getselectedrow(0)
				end if
		end choose	
	
	catch (uo_exception kuo_exception1)
		kuo_exception1.messaggio_utente()
	finally
	end try


	
end subroutine

protected subroutine riposiziona_cursore_sulla_riga (ref datawindow kdw_1, long k_riga);//
	if k_riga > 0 then
	else
		k_riga = 1
	end if
	if kdw_1.rowcount() > 0 then
		if k_riga > kdw_1.rowcount() then
			k_riga = kdw_1.rowcount()
		end if

		if kdw_1.Rowcount() > 1 then // and ki_st_open_w.flag_primo_giro <> 'S' then
		 
			kdw_1.selectrow( 0, false)
			kdw_1.selectrow( k_riga, true)
			kdw_1.setrow( k_riga )
			kdw_1.scrolltorow( k_riga )

		end if
	end if

end subroutine

protected function string inizializza_post ();//
//
string k_return="0" 


if tab_1.tabpage_1.dw_1.enabled and not tab_1.tabpage_1.dw_1.visible then
	tab_1.tabpage_1.dw_1.visible = true 
	tab_1.tabpage_1.dw_1.setfocus( )
end if
if tab_1.tabpage_2.dw_2.enabled  and not tab_1.tabpage_2.dw_2.visible  then
	tab_1.tabpage_2.dw_2.visible = true 
	tab_1.tabpage_2.dw_2.setfocus( )
end if
if tab_1.tabpage_3.dw_3.enabled  and not tab_1.tabpage_3.dw_3.visible  then
	tab_1.tabpage_3.dw_3.visible = true 
	tab_1.tabpage_3.dw_3.setfocus( )
end if
if tab_1.tabpage_4.dw_4.enabled  and not tab_1.tabpage_4.dw_4.visible  then
	tab_1.tabpage_4.dw_4.visible = true 
	tab_1.tabpage_4.dw_4.setfocus( )
end if
if tab_1.tabpage_5.dw_5.enabled  and not tab_1.tabpage_5.dw_5.visible  then
	tab_1.tabpage_5.dw_5.visible = true 
	tab_1.tabpage_5.dw_5.setfocus( )
end if
if tab_1.tabpage_6.dw_6.enabled  and not tab_1.tabpage_6.dw_6.visible  then
	tab_1.tabpage_6.dw_6.visible = true 
	tab_1.tabpage_6.dw_6.setfocus( )
end if
if tab_1.tabpage_7.dw_7.enabled  and not tab_1.tabpage_7.dw_7.visible  then
	tab_1.tabpage_7.dw_7.visible = true 
	tab_1.tabpage_7.dw_7.setfocus( )
end if
if tab_1.tabpage_8.dw_8.enabled  and not tab_1.tabpage_8.dw_8.visible  then
	tab_1.tabpage_8.dw_8.visible = true 
	tab_1.tabpage_8.dw_8.setfocus( )
end if
if tab_1.tabpage_9.dw_9.enabled  and not tab_1.tabpage_9.dw_9.visible  then
	tab_1.tabpage_9.dw_9.visible = true 
	tab_1.tabpage_9.dw_9.setfocus( )
end if


k_return = super::inizializza_post()

return k_return

end function

protected subroutine u_personalizza_dw ();//---
//--- Personalizza DW
//---

	
//	u_get_dw( )
	//kidw_tabselezionato
	if kidw_selezionata.ki_flag_modalita > " " then
	else
		kidw_selezionata.ki_flag_modalita = ki_st_open_w.flag_modalita 
	end if
	
	kidw_selezionata.event u_personalizza_dw()
	kidw_selezionata.setfocus( )



end subroutine

protected function st_esito aggiorna_dw (ref datawindow kdw_1, string k_titolo);//
//======================================================================
//===
//=== Aggiorna tabelle 
//=== FASE 2 STANDARD PER TUTTE LE DW 
//===
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//===
//======================================================================
 
string k_return="0 ", k_errore="0 ", k_errore1="0 "
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " " 
	
	
	//=== Aggiorna, se modificato, la TAB_n passata come argomento	
	if kdw_1.getnextmodified(0, primary!) > 0 OR &
		kdw_1.getnextmodified(0, delete!) > 0 & 
		then
	
		if kdw_1.update() = 1 then
//=== Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
			if kst_esito.esito <> kkg_esito.ok then
				kst_esito.esito = "3"
				kst_esito.sqlerrtext = "Archivio '" + k_titolo + "' (err=" + trim(kst_esito.sqlerrtext) + ")~n~r" 
			end if
		else
			kst_esito.esito = "1"
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Fallito aggiornamento archivio '" + k_titolo + "'~n~r" 
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Nessun dato caricato da aggiornare " 
	end if
	

return kst_esito

end function

public subroutine cancella_dati ();//
st_open_w kst_open_w


kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then

	if cancella() = 0 then
		
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
		kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
		
		if ki_esci_dopo_cancella then 
			post close(this)
		else
			u_personalizza_dw ()
			attiva_tasti( )
		end if
		
	end if


end if
end subroutine

protected subroutine dati_modif_accept ();//
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_1.dw_1.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_2.dw_2.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_3.dw_3.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_4.dw_4.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_5.dw_5.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_6.dw_6.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_7.dw_7.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_8.dw_8.accepttext()
if tab_1.tabpage_1.dw_1.enabled then tab_1.tabpage_9.dw_9.accepttext()

end subroutine

protected function string dati_modif_figlio_inizio (string a_1);//
//---- da utilizzare x gli oggetti figli  a INIZIO  operazione della DATI_MODIF
string k_return = "0"


return k_return
end function

protected subroutine dati_modif_figlio_fine (string a_1);//
//---- da utilizzare x gli oggetti figli a fine operazione della DATI_MODIF




end subroutine

protected function string leggi_riga ();//======================================================================
//=== Rilegge la riga 
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga=0



	k_riga = kidw_selezionata.getrow()
	
	if k_riga > kidw_selezionata.rowcount() or k_riga = 0 then
		k_return = "1 "  //riga fuori elenco o inesistente
	else
		k_riga = kidw_selezionata.ReselectRow(k_riga)
	end if
	if k_riga < 1 then
		k_return = "1 "
	end if

//--- se il tentativo di rilettura va male allora rileggo tutto	
	if k_return <> "0 " then
		try
//			inizializza_lista()
		catch (uo_exception kuo_exception1)
		end try
		
	else

		kidw_selezionata.SetRedraw (false)
		kidw_selezionata.GroupCalc()
		kidw_selezionata.SetRedraw (true)
		kidw_selezionata.setfocus()
		
		attiva_tasti()
	end if

	
return k_return





end function

protected subroutine stampa_esegui (st_stampe ast_stampe);//
//=== stampa dw
string k_errore, k_titolo=" "
//w_g_tab kwindow_1
//datawindow kdw_1

//if isvalid(kidw_tabselezionato) then 
//	kdw_1 = kidw_tabselezionato
//else
//	choose case ki_tab_1_index_new 
//		case 1 
//			kdw_1 = tab_1.tabpage_1.dw_1
//		case 2
//			kdw_1 = tab_1.tabpage_2.dw_2
//		case 3
//			kdw_1 = tab_1.tabpage_3.dw_3
//		case 4
//			kdw_1 = tab_1.tabpage_4.dw_4
//		case 5
//			kdw_1 = tab_1.tabpage_5.dw_5
//		case 6
//			kdw_1 = tab_1.tabpage_6.dw_6
//		case 7
//			kdw_1 = tab_1.tabpage_7.dw_7
//		case 8
//			kdw_1 = tab_1.tabpage_8.dw_8
//		case 9
//			kdw_1 = tab_1.tabpage_9.dw_9
//	end choose	
//end if

if not isvalid(kidw_selezionata) then
	messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
else
	if kidw_selezionata.rowcount() > 0 then
		choose case ki_tab_1_index_new 
			case 1 
				k_titolo = tab_1.tabpage_1.text
			case 2
				k_titolo = tab_1.tabpage_2.text
			case 3
				k_titolo = tab_1.tabpage_3.text
			case 4
				k_titolo = tab_1.tabpage_4.text
			case 5
				k_titolo = tab_1.tabpage_5.text
			case 6
				k_titolo = tab_1.tabpage_6.text
			case 7
				k_titolo = tab_1.tabpage_7.text
			case 8
				k_titolo = tab_1.tabpage_8.text
			case 9
				k_titolo = tab_1.tabpage_9.text
			case else
				k_titolo = "Stampa dati"
		end choose	
	
//		kwindow_1 = kGuf_data_base.prendi_win_attiva()
		
		ast_stampe.dw_print = kidw_selezionata
		ast_stampe.titolo = trim(k_titolo) + " di '" + trim(kiw_this_window.title) + "'"
	
		k_errore = string(kGuf_data_base.stampa_dw(ast_stampe))
	else
		messagebox("Richiesta Stampa", "Stampa non eseguita, nessun dato rilevato da stampare")
	
	end if
end if		
		

end subroutine

public function string u_attiva_tab (integer a_tab_da_attivare);//
//--- Out: ""=OK;  "E" = Uscita Immediata
//
string k_return = ""
string k_rc_inizializza = ""

try 
	

	dati_modif_accept( )

	if a_tab_da_attivare > 0 then

//=== Puntatore Cursore da attesa..... 
//		SetPointer(kkg.pointer_attesa)

//		tab_1.visible = true

		choose case a_tab_da_attivare 
			case 1 
				k_rc_inizializza = inizializza()
//				kidw_tabselezionato = tab_1.tabpage_1.dw_1
			case 2
				inizializza_1()
//				kidw_tabselezionato = tab_1.tabpage_2.dw_2
			case 3
				inizializza_2()
//				kidw_tabselezionato = tab_1.tabpage_3.dw_3
			case 4
				inizializza_3()
//				kidw_tabselezionato = tab_1.tabpage_4.dw_4
			case 5
				inizializza_4()
//				kidw_tabselezionato = tab_1.tabpage_5.dw_5
			case 6
				inizializza_5()
//				kidw_tabselezionato = tab_1.tabpage_6.dw_6
			case 7
				inizializza_6()
//				kidw_tabselezionato = tab_1.tabpage_7.dw_7
			case 8
				inizializza_7()
//				kidw_tabselezionato = tab_1.tabpage_8.dw_8
			case 9
				inizializza_8()
//				kidw_tabselezionato = tab_1.tabpage_9.dw_9
		end choose	
		
		if trim(k_rc_inizializza) <> "E" then //E=Uscita Immediata
		
			attiva_tasti()
			
			riposiziona_cursore()   // rimette la riga selezionata che c'era in precedenza
		
//			SetPointer(kkg.pointer_default)
		end if
		
	end if
	
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()

finally
		k_return = k_rc_inizializza

	
end try

return k_return

	
end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== ESEMPIO TIPICO DI INIZIALIZZA
//=== TUTTE LE FUNZIONI INIZIALIZZA SERVONO PER POPOLARE LE TAB_1.TABPAGE_N(+1).DW_N(+1)
//
//string k_key
//kuf_utility kuf1_utility
//
//
//
//	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//
////		tab_1.tabpage_1.dw_1.reset()
//
//		k_key = trim(k_st_open_w.key)
//
//		if tab_1.tabpage_1.dw_1.retrieve(k_key) <= 0 then
//
//			messagebox("Operazione fallita", &
//				"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
//				"(Dato ricercato :" + trim(k_key) + ")~n~r" )
//
//			inserisci()
//		else
//			attiva_tasti()
//			
//		end if
//	end if
//
////	tab_1.tabpage_1.dw_1.setfocus()
//
//	
//
//
//		
//--- Inabilita campi alla modifica se Vsualizzazione
//   kuf1_utility = create kuf_utility 
//   if trim(ki_st_open_w.flag_modalita) = "vi" then
//	
//      kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
//
//	else		
//		
////--- S-protezione campi per riabilitare la modifica a parte la chiave
//      kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
//
////--- Inabilita campo cliente per la modifica se Funzione MODIFICA
//	   if trim(ki_st_open_w.flag_modalita) = "mo" then
//   	   kuf1_utility.u_proteggi_dw("1", 1, tab_1.tabpage_1.dw_1)
//		end if
//
//	end if
//	destroy kuf1_utility
//
//


   return ("0")
   
end function

protected subroutine u_set_dw_obsoleto ();//---
//--- get il DW attivo
//---
//uo_d_std_1 kdw_x

//
//	choose case tab_1.selectedtab 
//		case  1 
//			kdw_x = tab_1.tabpage_1.dw_1
//		case 2
//			kdw_x = tab_1.tabpage_2.dw_2
//		case 3
//			kdw_x = tab_1.tabpage_3.dw_3
//		case 4
//			kdw_x = tab_1.tabpage_4.dw_4
//		case 5
//			kdw_x = tab_1.tabpage_5.dw_5
//		case 6
//			kdw_x = tab_1.tabpage_6.dw_6
//		case 7
//			kdw_x = tab_1.tabpage_7.dw_7
//		case 8
//			kdw_x = tab_1.tabpage_8.dw_8
//		case 9
//			kdw_x = tab_1.tabpage_9.dw_9
//	end choose	

//	kidw_tabselezionato = kidw_selezionata //kdw_x

//return kidw_selezionata //kdw_x	



end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_riga=1
string k_lista="1"

			
super::attiva_tasti_0()		 

//this.setredraw( false )
if ki_attiva_tasti_vmi then
	cb_inserisci.enabled = true
	cb_aggiorna.enabled = true
	cb_modifica.enabled = true
	cb_cancella.enabled = true
	cb_visualizza.enabled = true
else	
	cb_inserisci.enabled = false
	cb_aggiorna.enabled = false
	cb_modifica.enabled = false
	cb_cancella.enabled = false
	cb_visualizza.enabled = false
end if
st_duplica.enabled = false

//cb_modifica.default = false

if not ki_nessun_tasto_funzionale then

	//=== Nr righe ne DW lista
	choose case ki_tab_1_index_new    //tab_1.selectedtab
		case 1
			k_riga = tab_1.tabpage_1.dw_1.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_1.dw_1.deletedcount( )
	     	k_lista = tab_1.tabpage_1.dw_1.Object.DataWindow.Processing
			tab_1.tabpage_1.dw_1.setredraw(true)
		case 2
			k_riga = tab_1.tabpage_2.dw_2.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_2.dw_2.deletedcount( )
	      k_lista = tab_1.tabpage_2.dw_2.Object.DataWindow.Processing
			tab_1.tabpage_2.dw_2.setredraw(true)
		case 3 
			k_riga = tab_1.tabpage_3.dw_3.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_3.dw_3.deletedcount( )
	      k_lista = tab_1.tabpage_3.dw_3.Object.DataWindow.Processing
			tab_1.tabpage_3.dw_3.setredraw(true)
		case 4
			k_riga = tab_1.tabpage_4.dw_4.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_4.dw_4.deletedcount( )
	      k_lista = tab_1.tabpage_4.dw_4.Object.DataWindow.Processing
			tab_1.tabpage_4.dw_4.setredraw(true)
		case 5
			k_riga = tab_1.tabpage_5.dw_5.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_5.dw_5.deletedcount( )
	      k_lista = tab_1.tabpage_5.dw_5.Object.DataWindow.Processing
			tab_1.tabpage_5.dw_5.setredraw(true)
		case 6
			k_riga = tab_1.tabpage_6.dw_6.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_6.dw_6.deletedcount( )
	      k_lista = tab_1.tabpage_6.dw_6.Object.DataWindow.Processing
			tab_1.tabpage_6.dw_6.setredraw(true)
		case 7
			k_riga = tab_1.tabpage_7.dw_7.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_7.dw_7.deletedcount( )
	      k_lista = tab_1.tabpage_7.dw_7.Object.DataWindow.Processing
			tab_1.tabpage_7.dw_7.setredraw(true)
		case 8
			k_riga = tab_1.tabpage_8.dw_8.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_8.dw_8.deletedcount( )
	      k_lista = tab_1.tabpage_8.dw_8.Object.DataWindow.Processing
			tab_1.tabpage_8.dw_8.setredraw(true)
		case 9
			k_riga = tab_1.tabpage_9.dw_9.rowcount()
			if k_riga = 0 then k_riga = tab_1.tabpage_9.dw_9.deletedcount( )
	      k_lista = tab_1.tabpage_9.dw_9.Object.DataWindow.Processing
			tab_1.tabpage_9.dw_9.setredraw(true)
	end choose

	
	
	choose case ki_st_open_w.flag_modalita 
	
		case kkg_flag_modalita.modifica 
			if k_riga > 0 then
				cb_aggiorna.enabled = true
				cb_cancella.enabled = true
				cb_inserisci.enabled = true
			end if
			st_aggiorna_lista.enabled = true
			st_ordina_lista.enabled = false
			if ki_consenti_duplica  then
				st_duplica.enabled = true
			end if
				
		case kkg_flag_modalita.inserimento 
			cb_inserisci.enabled = true
			cb_aggiorna.enabled = true
			st_aggiorna_lista.enabled = false
			st_ordina_lista.enabled = false
			if k_riga > 0 then
				cb_cancella.enabled = true
				st_aggiorna_lista.enabled = true
			end if
	
			
		case kkg_flag_modalita.elenco 
			if k_riga > 0 then
				cb_modifica.enabled = true
				cb_cancella.enabled = true
				cb_visualizza.enabled = true
			end if
			cb_inserisci.enabled = true
			st_aggiorna_lista.enabled = true
			if k_lista = "1"  then
				st_ordina_lista.enabled = true
			else
				st_ordina_lista.enabled = false
			end if
			
				
		case kkg_flag_modalita.visualizzazione &
			  ,kkg_flag_modalita.cancellazione  &
			  ,kkg_flag_modalita.interrogazione 
			st_aggiorna_lista.enabled = true
//--- queste dovrebbero essere di tipo GRID...
			if k_lista = "1"  then
				st_ordina_lista.enabled = true
			else
				st_ordina_lista.enabled = false
			end if
			if ki_consenti_duplica  then
				st_duplica.enabled = true
			end if
	
			
		case else
			cb_inserisci.enabled = true
			st_aggiorna_lista.enabled = true
//--- queste dovrebbero essere di tipo GRID...
			if k_lista = "1"  then
				st_ordina_lista.enabled = true
			else
				st_ordina_lista.enabled = false
			end if
	
	end choose
end if	
       


//this.setredraw( false )

end subroutine

public subroutine u_resize_1 ();//

	
		this.setredraw(false)
	
	//=== Dimensione dw nella window 
		tab_1.resize(this.width - 1, this.height - 1)
		tab_1.tabpage_1.resize(tab_1.width, tab_1.height)
	
	//--- Posiziona dw nella window 
		tab_1.move(0, 0) 
		
		this.setredraw(true)
		this.setredraw(false)
	
		int kk_width = 1 //50
		int kk_height = 0
 //--- per un bug di PB sono costretto a fare questo per far vedere le barre
	 	if tab_1.tabposition <> tabsonleft! and tab_1.height - tab_1.tabpage_1.height - 120 < 0 then 
			kk_height = 120	
		end if
		if tab_1.tabposition = tabsonleft! and tab_1.width - tab_1.tabpage_1.width - 900 < 0 then 
			kk_width = 900
		end if
	
	//=== Dimensiona dw nel tab
		tab_1.tabpage_1.dw_1.resize(tab_1.tabpage_1.width - kk_width, tab_1.tabpage_1.height - kk_height)
		tab_1.tabpage_1.dw_1.move(1,1)
	
		if tab_1.tabpage_2.dw_2.enabled then
			tab_1.tabpage_2.dw_2.resize(tab_1.tabpage_2.width - kk_width, tab_1.tabpage_2.height - kk_height)
			tab_1.tabpage_2.dw_2.move(1,1)
		end if
		if tab_1.tabpage_3.dw_3.enabled then
			tab_1.tabpage_3.dw_3.resize(tab_1.tabpage_3.width - kk_width, tab_1.tabpage_3.height - kk_height)
			tab_1.tabpage_3.dw_3.move(1,1)
		end if
		if tab_1.tabpage_4.dw_4.enabled then
			tab_1.tabpage_4.dw_4.resize(tab_1.tabpage_4.width - kk_width, tab_1.tabpage_4.height - kk_height)
			tab_1.tabpage_4.dw_4.move(1,1)
		end if
		if tab_1.tabpage_5.dw_5.enabled then
			tab_1.tabpage_5.dw_5.resize(tab_1.tabpage_5.width - kk_width, tab_1.tabpage_5.height - kk_height)
			tab_1.tabpage_5.dw_5.move(1,1)
		end if
		if tab_1.tabpage_6.dw_6.enabled then
			tab_1.tabpage_6.dw_6.resize(tab_1.tabpage_6.width - kk_width, tab_1.tabpage_6.height - kk_height)
			tab_1.tabpage_6.dw_6.move(1,1)
		end if
		if tab_1.tabpage_7.dw_7.enabled then
			tab_1.tabpage_7.dw_7.resize(tab_1.tabpage_7.width - kk_width, tab_1.tabpage_7.height - kk_height)
			tab_1.tabpage_7.dw_7.move(1,1)
		end if
		if tab_1.tabpage_8.dw_8.enabled then
			tab_1.tabpage_8.dw_8.resize(tab_1.tabpage_8.width - kk_width, tab_1.tabpage_8.height - kk_height)
			tab_1.tabpage_8.dw_8.move(1,1)
		end if
		if tab_1.tabpage_9.dw_9.enabled then
			tab_1.tabpage_9.dw_9.resize(tab_1.tabpage_9.width - kk_width, tab_1.tabpage_9.height - kk_height)
			tab_1.tabpage_9.dw_9.move(1,1)
		end if
		
		this.setredraw(true)
		
	
	
	

end subroutine

protected function string aggiorna_dw_0 (datawindow adw_1, string a_titolo, string a_return);//
st_esito kst_esito
string k_errore, k_return


	k_errore = left(a_return,1)
	k_return = mid(a_return,2)
	
	kst_esito = aggiorna_dw (adw_1, a_titolo)  // tenta aggiornamento DW

	if kst_esito.esito <> kkg_esito.no_esecuzione then
		if kst_esito.esito = kkg_esito.ok then
			k_return += "Aggiornato archivio '"+trim(a_titolo)+"'~n~r"
		else	
			if k_errore = "0" then
				k_errore = trim(kst_esito.esito)
			else
				k_errore = "2"
			end if
			k_return += trim(kst_esito.sqlerrtext)
		end if
	end if

return k_errore + trim(k_return)
end function

protected function boolean dati_modif_dw (ref uo_d_std_1 auo_d_std_1);//
//--- dati modificati del dw passato?
//--- Inp: datawindow standard
//--- true=si; false=no   poi   valorizza ki_dw_titolo_modif_1 con il Titolo del TAB modificato
//
boolean k_boolean = false

	
	if auo_d_std_1.u_dati_modificati() then
		k_boolean = true
		if len(ki_dw_titolo_modif_1) > 0 then
			ki_dw_titolo_modif_1 += " e "
		end if
		ki_dw_titolo_modif_1 = trim(auo_d_std_1.title)
	end if
			
return k_boolean
			
	

end function

public function boolean u_duplica () throws uo_exception;//
//--- Operazioni di duplica che sono particolari per ogni funzione
//

try
	
catch (uo_exception kuo_exception)
	
finally
	
end try

return true
end function

event closequery;call super::closequery;//
//=== Controllo prima della chiusura della Windows
//
int k_errore=0

 
cb_ritorna.enabled = false

//=== Verifico DATI_MODIF solo se tasti di modif. abilitati
if cb_aggiorna.enabled or cb_inserisci.enabled or cb_cancella.enabled then
//=== Ritorna 1 char : 0=Tutto OK; 1=Errore grave; 
//===	             : 2=Errore Non grave dati aggiornati
//===              : 999=premuto ANNULLA OPERAZIONE
	k_errore = ritorna(this.title)

	if k_errore = 1 or k_errore = 2 or k_errore = 999 then
		ki_exit_si = false
		attiva_tasti()
		return 1
	end if

end if
	
//=== Salva le righe del dw (saveas)
//kGuf_data_base.dw_saveas(trim(ki_syntaxquery), tab_1.tabpage_1.dw_1)

//
//this.windowstate = minimized!
//move(9999,9999)
//return 1	
return 0
 
end event

on w_g_tab_3.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_aggiorna=create cb_aggiorna
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.tab_1=create tab_1
this.st_duplica=create st_duplica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_aggiorna
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.tab_1
this.Control[iCurrent+7]=this.st_duplica
end on

on w_g_tab_3.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_aggiorna)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.tab_1)
destroy(this.st_duplica)
end on

event u_open;call super::u_open;//
u_resize()
if ki_utente_abilitato then

	inizializza_lista()

end if 
fine_primo_giro()

//u_resize()
	
 
end event

event key;call super::key;//
if ki_st_open_w.flag_primo_giro <> "S" then
	tab_1.event key(key, 0)
end if

end event

type st_ritorna from w_g_tab`st_ritorna within w_g_tab_3
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab_3
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab_3
integer x = 1326
integer y = 1300
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab_3
integer x = 1682
integer y = 1136
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab_3
integer x = 1769
integer y = 1228
integer width = 297
end type

type cb_visualizza from commandbutton within w_g_tab_3
boolean visible = false
integer x = 1216
integer y = 1108
integer width = 370
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Visualizza"
end type

event clicked;//
visualizza() 
u_personalizza_dw ()
if isvalid(kidw_selezionata ) then kidw_selezionata.ki_flag_modalita = ki_st_open_w.flag_modalita


end event

type cb_modifica from commandbutton within w_g_tab_3
boolean visible = false
integer x = 485
integer y = 1204
integer width = 329
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Modifica"
end type

event clicked;//
//=== 
string k_errore="", k_esito=""
st_open_w kst_open_w


kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then

	//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
	k_esito = dati_modif(parent.title)
	if len(k_esito) > 0 then 
		k_errore = left(k_esito, 1)
	end if
	
	if k_errore = "1" then //Fare gli aggiornamenti
	
	//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
	//===	              : 2=Errore Non grave dati aggiornati
	//===               : 3=
		k_errore = aggiorna_dati()		
		//if left(k_errore, 1) = "0" then 
		//	inizializza_lista()
		//end if
		
	else
	
		if k_errore = "2" then //Aggiornamento non richiesto
			k_errore = "0"
		end if
	
	end if
	
	if left(k_errore, 1) = "0" then 
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		inizializza_lista()
		if isvalid(kidw_selezionata) then kidw_selezionata.ki_flag_modalita = ki_st_open_w.flag_modalita
	end if

end if


end event

type cb_aggiorna from commandbutton within w_g_tab_3
boolean visible = false
integer x = 869
integer y = 1204
integer width = 329
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Conferma"
end type

event clicked;//
aggiorna_dati( )


end event

type cb_cancella from commandbutton within w_g_tab_3
boolean visible = false
integer x = 1239
integer y = 1204
integer width = 329
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Elimina"
end type

event clicked;//
cancella_dati( )

end event

type cb_inserisci from commandbutton within w_g_tab_3
boolean visible = false
integer x = 105
integer y = 1208
integer width = 329
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Nuovo"
end type

event clicked; //
 //=== 
string k_errore="0", k_esito=""
st_open_w kst_open_w
 
 
kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
 
 //--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then
 
 
//		if tab_1.selectedtab = 1 then
//			ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
//		end if

 //--- solo se faccio 'inserisci' sul primo tabulatore controlla se ho fatto modifiche
//	u_get_dw( )
//	if kidw_selezionata.u_get_tipo( ) = kidw_selezionata.kki_tipo_processing_form then
		k_esito = dati_modif(parent.title)
		if len(k_esito) > 0 then 
			k_errore = left(k_esito, 1)
		end if
//	end if
   
   //=== Controllo se ho modificato dei dati nella DW DETTAGLIO
	if k_errore = "1" then //Fare gli aggiornamenti
   
   //=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
   //===               : 2=Errore Non grave dati aggiornati
   //===               : 3=
		k_errore = aggiorna_dati()    
   
	else
   
		if k_errore = "2" then //Aggiornamento non richiesto
         	k_errore = "0"
		end if
   
	end if
   
	if left(k_errore, 1) = "0" then 
      
		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
      	inserisci()
      	u_personalizza_dw ()
		if isvalid(kidw_selezionata) then kidw_selezionata.ki_flag_modalita = ki_st_open_w.flag_modalita
      
	end if
 
end if
 
post attiva_tasti()
 
 

end event

type tab_1 from tab within w_g_tab_3
event ue_rbuttondown pbm_rbuttondown
event ue_rbuttonup pbm_rbuttonup
boolean visible = false
integer width = 1842
integer height = 1144
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_9 tabpage_9
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_9=create tabpage_9
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
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_9)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto
int k_ind
boolean k_fai_paginate

if ki_st_open_w.flag_primo_giro <> "S" then

	//--- se ho più di 5 righe non faccio tab avanti/indietro con pagGiù o pagSu ma lascio come paginata 
	if not isvalid(kidw_selezionata) then 
		k_fai_paginate = true
	else
		if kidw_selezionata.rowcount( ) < 6 then
			k_fai_paginate = true
		end if
	end if
	
	if k_fai_paginate then
		
		choose case key
				
			case keypagedown!
				
				if ki_tab_1_index_new < 9 then
					k_ind = ki_tab_1_index_new + 1
					for k_ind = k_ind to 9
						if ki_tabpage_visible[k_ind] then
							exit
						end if
					next
					if ki_tabpage_visible[k_ind] then
						this.selectedtab = k_ind
					end if
				end if
				
		
			case keypageup!
				
				if ki_tab_1_index_new > 1 then
					k_ind = ki_tab_1_index_new - 1
					for k_ind = k_ind to 1 step -1
						if ki_tabpage_visible[k_ind] then
							exit
						end if
					next
					if ki_tabpage_visible[k_ind] then
						this.selectedtab = k_ind
					end if
				end if
				
		end choose
		
	end if
end if	

end event

event constructor;//
this.backcolor = parent.backcolor

end event

event selectionchanged;//
long k_riga=0
pointer kp_oldpointer


	
	ki_tab_1_index_new=newindex
	ki_tab_1_index_old=oldindex

	dati_modif_accept( )

	if oldindex > 0 then  //la prima volta e' a -1

		u_attiva_tab(newindex)
		
	end if
	


	
end event

type tabpage_1 from userobject within tab_1
event rbuttonup pbm_rbuttonup
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 32435950
string text = "none"
long tabtextcolor = 134217735
long tabbackcolor = 31449055
long picturemaskcolor = 12632256
dw_1 dw_1
st_1_retrieve st_1_retrieve
end type

on tabpage_1.create
this.dw_1=create dw_1
this.st_1_retrieve=create st_1_retrieve
this.Control[]={this.dw_1,&
this.st_1_retrieve}
end on

on tabpage_1.destroy
destroy(this.dw_1)
destroy(this.st_1_retrieve)
end on

event constructor;//
ki_tabpage_visible[1] = this.visible

end event

type dw_1 from uo_d_std_1 within tabpage_1
integer x = 37
integer y = 40
integer width = 1010
integer height = 880
integer taborder = 20
boolean enabled = true
pointer kipointer_orig = hourglass!
end type

event itemchanged;call super::itemchanged;
// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
post attiva_tasti()

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
	ki_syntaxquery = sqlsyntax

end event

event getfocus;call super::getfocus;	//
	kidw_selezionata = this
	
	//--- imposta oggetto selezionato x fare il TROVA
	kigrf_x_trova = this
	
	attiva_tasti()

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)

end event

type st_1_retrieve from statictext within tabpage_1
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
event rbuttonup ( )
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_2 dw_2
st_2_retrieve st_2_retrieve
end type

on tabpage_2.create
this.dw_2=create dw_2
this.st_2_retrieve=create st_2_retrieve
this.Control[]={this.dw_2,&
this.st_2_retrieve}
end on

on tabpage_2.destroy
destroy(this.dw_2)
destroy(this.st_2_retrieve)
end on

event constructor;//
ki_tabpage_visible[2] = this.visible

end event

type dw_2 from uo_d_std_1 within tabpage_2
integer x = 23
integer y = 52
integer width = 1038
integer height = 916
integer taborder = 20
end type

event itemfocuschanged;call super::itemfocuschanged;//
//post attiva_tasti()
end event

event itemchanged;call super::itemchanged;// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
post	attiva_tasti()

end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_2_retrieve from statictext within tabpage_2
boolean visible = false
integer x = 1189
integer y = 100
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_3 dw_3
st_3_retrieve st_3_retrieve
end type

on tabpage_3.create
this.dw_3=create dw_3
this.st_3_retrieve=create st_3_retrieve
this.Control[]={this.dw_3,&
this.st_3_retrieve}
end on

on tabpage_3.destroy
destroy(this.dw_3)
destroy(this.st_3_retrieve)
end on

event constructor;//
ki_tabpage_visible[3] = this.visible

end event

type dw_3 from uo_d_std_1 within tabpage_3
integer x = 14
integer y = 40
integer width = 1074
integer height = 884
integer taborder = 20
end type

event itemchanged;call super::itemchanged;// fino a che non e' a posto il bug che la funzione non viene lanciata da u_d_std_1
post	attiva_tasti()

end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_3_retrieve from statictext within tabpage_3
boolean visible = false
integer x = 1225
integer y = 116
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_4 dw_4
st_4_retrieve st_4_retrieve
end type

on tabpage_4.create
this.dw_4=create dw_4
this.st_4_retrieve=create st_4_retrieve
this.Control[]={this.dw_4,&
this.st_4_retrieve}
end on

on tabpage_4.destroy
destroy(this.dw_4)
destroy(this.st_4_retrieve)
end on

event constructor;//
ki_tabpage_visible[4] = this.visible

end event

type dw_4 from uo_d_std_1 within tabpage_4
integer x = 5
integer y = 32
integer width = 992
integer height = 868
integer taborder = 20
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_4_retrieve from statictext within tabpage_4
boolean visible = false
integer x = 1179
integer y = 148
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_5 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
long backcolor = 31449055
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
dw_5 dw_5
st_5_retrieve st_5_retrieve
end type

on tabpage_5.create
this.dw_5=create dw_5
this.st_5_retrieve=create st_5_retrieve
this.Control[]={this.dw_5,&
this.st_5_retrieve}
end on

on tabpage_5.destroy
destroy(this.dw_5)
destroy(this.st_5_retrieve)
end on

event constructor;//
ki_tabpage_visible[5] = this.visible

end event

type dw_5 from uo_d_std_1 within tabpage_5
integer x = 91
integer y = 52
integer width = 814
integer height = 508
integer taborder = 10
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_5_retrieve from statictext within tabpage_5
boolean visible = false
integer x = 1097
integer y = 140
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type tabpage_6 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_6_retrieve st_6_retrieve
dw_6 dw_6
end type

on tabpage_6.create
this.st_6_retrieve=create st_6_retrieve
this.dw_6=create dw_6
this.Control[]={this.st_6_retrieve,&
this.dw_6}
end on

on tabpage_6.destroy
destroy(this.st_6_retrieve)
destroy(this.dw_6)
end on

event constructor;//
ki_tabpage_visible[6] = this.visible

end event

type st_6_retrieve from statictext within tabpage_6
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_6 from uo_d_std_1 within tabpage_6
integer x = 78
integer y = 36
integer width = 731
integer height = 528
integer taborder = 20
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_7 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_7_retrieve st_7_retrieve
dw_7 dw_7
end type

on tabpage_7.create
this.st_7_retrieve=create st_7_retrieve
this.dw_7=create dw_7
this.Control[]={this.st_7_retrieve,&
this.dw_7}
end on

on tabpage_7.destroy
destroy(this.st_7_retrieve)
destroy(this.dw_7)
end on

event constructor;//
ki_tabpage_visible[7] = this.visible

end event

type st_7_retrieve from statictext within tabpage_7
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_7 from uo_d_std_1 within tabpage_7
integer y = 28
integer width = 1042
integer taborder = 20
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_8 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_8_retrieve st_8_retrieve
dw_8 dw_8
end type

on tabpage_8.create
this.st_8_retrieve=create st_8_retrieve
this.dw_8=create dw_8
this.Control[]={this.st_8_retrieve,&
this.dw_8}
end on

on tabpage_8.destroy
destroy(this.st_8_retrieve)
destroy(this.dw_8)
end on

event constructor;//
ki_tabpage_visible[8] = this.visible

end event

type st_8_retrieve from statictext within tabpage_8
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_8 from uo_d_std_1 within tabpage_8
integer y = 28
integer width = 1042
integer taborder = 20
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type tabpage_9 from userobject within tab_1
event rbuttonup pbm_rbuttonup
boolean visible = false
integer x = 18
integer y = 112
integer width = 1806
integer height = 1016
boolean enabled = false
long backcolor = 32435950
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 31449055
long picturemaskcolor = 536870912
st_9_retrieve st_9_retrieve
dw_9 dw_9
end type

on tabpage_9.create
this.st_9_retrieve=create st_9_retrieve
this.dw_9=create dw_9
this.Control[]={this.st_9_retrieve,&
this.dw_9}
end on

on tabpage_9.destroy
destroy(this.st_9_retrieve)
destroy(this.dw_9)
end on

event constructor;//
ki_tabpage_visible[9] = this.visible

end event

type st_9_retrieve from statictext within tabpage_9
boolean visible = false
integer x = 1211
integer y = 132
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_9 from uo_d_std_1 within tabpage_9
integer x = 64
integer y = 16
integer width = 1042
integer taborder = 20
end type

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event itemchanged;call super::itemchanged;//
post attiva_tasti()
end event

event ue_dwnkey;call super::ue_dwnkey;//
tab_1.event key(key, keyflags)
end event

type st_duplica from statictext within w_g_tab_3
boolean visible = false
integer x = 78
integer y = 1304
integer width = 402
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "duplica"
boolean focusrectangle = false
end type

event clicked;//
boolean k_duplica
st_open_w kst_open_w


try
	k_duplica = u_duplica()
	if k_duplica then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	else
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	kidw_selezionata.setfocus()		
	u_personalizza_dw ()
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end event

