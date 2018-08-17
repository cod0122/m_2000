$PBExportHeader$w_g_tab0.srw
forward
global type w_g_tab0 from w_g_tab
end type
type cb_visualizza from commandbutton within w_g_tab0
end type
type cb_modifica from commandbutton within w_g_tab0
end type
type cb_aggiorna from commandbutton within w_g_tab0
end type
type cb_cancella from commandbutton within w_g_tab0
end type
type cb_inserisci from commandbutton within w_g_tab0
end type
type dw_dett_0 from uo_d_std_1 within w_g_tab0
end type
type st_orizzontal from statictext within w_g_tab0
end type
type dw_lista_0 from uo_d_std_1 within w_g_tab0
end type
type dw_guida from uo_d_std_guida within w_g_tab0
end type
end forward

global type w_g_tab0 from w_g_tab
integer width = 3575
integer height = 1668
string title = "Windows Modello Base 0"
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_aggiorna cb_aggiorna
cb_cancella cb_cancella
cb_inserisci cb_inserisci
dw_dett_0 dw_dett_0
st_orizzontal st_orizzontal
dw_lista_0 dw_lista_0
dw_guida dw_guida
end type
global w_g_tab0 w_g_tab0

type variables
//st_open_w ki_st_open_w
protected DataWindow  ki_dw_cerca
protected string ki_syntaxquery=" "
protected boolean ki_resize_dw_dett=false
protected boolean ki_resize_NO=false
protected boolean ki_resize_inizializza_y=true   // rifa la dimensione delle dw come in origine
protected long ki_st_orizzontal_y_start=0 	// iniziale posizionamento 
protected boolean ki_riparte_dopo_save_ok=false
protected boolean ki_exit_dopo_save_ok=false
protected boolean ki_reset_dopo_save_ok=true
protected boolean ki_visualizza_dopo_save_ok=false
protected boolean ki_msg_dopo_save_ok=false
protected boolean ki_consenti_modifica=true
protected boolean ki_consenti_inserisci=true
protected boolean ki_consenti_visualizza=true

private long ki_riga_selezionata=0
//private boolean ki_risize=true

private boolean k_test_size = true
end variables

forward prototypes
protected function string check_dati ()
protected function string cancella ()
protected function integer posiz_window ()
protected function integer check_rek (string k_codice)
protected function string inizializza_1 ()
protected function string aggiorna ()
protected subroutine pulizia_righe ()
protected function string aggiorna_dati ()
protected subroutine inizializza_lista ()
protected subroutine smista_funz (string k_par_in)
protected function boolean dati_modif_1 ()
protected function integer modifica ()
protected function integer visualizza ()
protected function string leggi_liste ()
protected subroutine attiva_menu ()
protected function string aggiorna_tabelle ()
protected function integer select_riga (long k_riga)
protected subroutine mostra_nascondi_dw ()
protected function string inizializza_post ()
protected subroutine u_personalizza_dw ()
protected subroutine fine_primo_giro ()
protected function string leggi_riga ()
protected function boolean aggiorna_tabelle_altre () throws uo_exception
protected subroutine leggi_liste_reset ()
protected subroutine dati_modif_accept ()
protected subroutine stampa_esegui (st_stampe ast_stampe)
protected subroutine inizializza_lista_ok (long a_riga_posiziona)
protected function integer inserisci ()
protected function string inizializza () throws uo_exception
public subroutine u_window_st_oizzontal_restore ()
public subroutine u_window_st_oizzontal_save ()
public function boolean u_lancia_funzione_imvc (st_open_w ast_open_w)
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public subroutine u_resize_1 ()
public subroutine u_win_ripri_video ()
public function boolean u_window_control_restore ()
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
	if dw_dett_0.rowcount() > 0 then
		kds_inp.dataobject = dw_dett_0.dataobject
		dw_dett_0.rowscopy( 1,dw_dett_0.rowcount( ) ,primary!, kds_inp, 1, primary!)
		kst_esito = kiuf_parent.u_check_dati(kds_inp)
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

protected function string cancella ();//===
//=== Lettura del rek da Cancellare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
string k_return="0"
any k_key
string k_campo_key=""
long k_righe=0
kuf_utility kuf1_utility
kuf_parent kuf1_parent 
st_tab_g_0 kst_tab_g_0 
st_open_w kst_open_w	


	if trim(ki_st_open_w.nome_id_tabella) > " " then
		k_campo_key = trim(ki_st_open_w.nome_id_tabella)
	else
		k_campo_key = "#1"
	end if

	choose case upper(Left(dw_lista_0.Describe(k_campo_key + ".Coltype"),2))
		
		case 'CH'
			k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))
		
	 	case else
			k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))

	end choose

	if trim(string(k_key)) > " " then 

		kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//--- verifica la funzione da lanciare
		kst_open_w.id_programma = ki_st_open_w.id_programma
		if ki_st_open_w.nome_oggetto > " " then
			kuf1_parent = create using ki_st_open_w.nome_oggetto  //nme oggetto = KUF_....
			if isvalid(kuf1_parent) then
				kst_open_w.id_programma = kuf1_parent.get_id_programma(kst_open_w.flag_modalita)
			end if
		end if
		
//--- se la funzione da lanciare è diversa da quella attuale lancio quella funzione	
		if kst_open_w.id_programma <> ki_st_open_w.id_programma then
			
			if isnumber(string(k_key)) then
				kst_tab_g_0.id = k_key
			else
				kst_tab_g_0.idx = trim(k_key)
			end if
			kuf1_parent.u_open_applicazione(kst_tab_g_0, kst_open_w.flag_modalita)
		
		else
//--- se la funzione è la stessa allora attivo il dw_dett_0
			k_righe = dw_dett_0.retrieve( k_key ) 
		
			if k_righe > 0 then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione
		
//--- Protezione campi per disabilitare la modifica 
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
				destroy kuf1_utility

			end if
		end if		
	end if		


return k_return

end function

protected function integer posiz_window ();//
//=== Dimensiona la Window come la DW
//dw_dett_0.width = integer(dw_dett_0.Describe("id_merce.width")) + &
//               	integer(dw_dett_0.Describe("desc.width")) + 100	
//dw_dett_0.height = integer(dw_dett_0.Describe("id_merce.Height")) * 11 + 40 
//
//w_g_tab0.width = dw_dett_0.width + 42
//w_g_tab0.height = dw_dett_0.height + 100

//=== Posiziona Windows
if w_main.width > w_g_tab0.width then
	w_g_tab0.x = (w_main.width - w_g_tab0.width) / 2
else
	w_g_tab0.x = 1
end if
if w_main.height > w_g_tab0.height then
	w_g_tab0.y = (w_main.height - w_g_tab0.height) / 4
else
	w_g_tab0.y = 1
end if

return (0)

end function

protected function integer check_rek (string k_codice);//
int k_return = 0
//
//int k_return = 0
//int k_anno
//string k_rag_soc_10
//long k_codice_1
//
//
//
//	SELECT 
//         "clienti"."rag_soc_10"  
//   	 INTO 
//      	   :k_rag_soc_10  
//    	FROM "clienti" 
//   	WHERE "codice" = :k_codice;
//
//	if sqlca.sqlcode = 0 then
//
//		if messagebox("Anagrafica gia' in Archivio", & 
//					"Vuoi modificare la anagrafica "+ &
//					trim(k_rag_soc_10), question!, yesno!, 2) = 1 then
//		
////			tab_1.tabpage_1.dw_1.reset()
//
//			
//			ki_st_open_w.flag_modalita = "mo"
//			ki_st_open_w.key1 = string(k_codice,"0000000000")
//
//			tab_1.tabpage_1.dw_1.reset()
//			inizializza()
//			
//		else
//			
//			k_return = 1
//		end if
//	end if  
//
//	attiva_tasti()
//
//
//
//return k_return
//
//


/////////oppure
//string k_id_art, k_id_art_1, k_id_art_old
//string k_descrizione
//
//
//
//k_id_art = dw_dett_0.gettext()
//
//if len(k_id_art) > 0 then
//
//
//	SELECT "articoli"."id_art",   
//          "articoli"."descrizione"  
//   	 INTO :k_id_art_1,   
//      	   :k_descrizione  
//    	FROM "articoli"  
//   	WHERE "articoli"."id_art" = :k_id_art   ;
//
//	if k_id_art = k_id_art_1 then
//		if messagebox("Articolo Trovato in Archivio", "Vuoi modificare l'Articolo:~n~r"+ &
//				trim(k_descrizione), question!, yesno!, 2) = 1 then
//
//			dw_dett_0.retrieve(k_id_art)
//
//			dw_dett_0.setitemstatus(dw_dett_0.getrow(), "id_art", &
//					primary!, notmodified!)
//
//			attiva_tasti()
//			
//		else
//			
//			k_return = 1
//		end if
//	end if  
//
//
//end if
//
//
return k_return

end function

protected function string inizializza_1 ();//
//=== Routine STANDARD
//
string k_return = "0 "
string k_select_orig="", k_select_new, k_rc, k_where
long k_pos
int k_errore=0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

k_where = trim(ki_st_open_w.campo_where)

k_select_orig = upper(dw_lista_0.Describe("DataWindow.Table.Select"))

//=== Cerca la clausola where nella select per sostituirla
k_pos = Pos(k_select_orig, "FROM")
if k_pos > 0 then
	k_select_orig = Left(k_select_orig, k_pos - 1)
end if

k_select_new = "DataWindow.Table.Select='" &
	+ k_select_orig + " " + k_where + "'"

k_rc = dw_lista_0.Modify(k_select_new)


IF k_rc = "" THEN

	dw_lista_0.reset()
		
	if dw_lista_0.retrieve("") < 1 then
		k_return = "1Dati Non trovati in archivio "
		SetPointer(oldpointer)

		messagebox("Lista archivio Vuota", &
				"Mi spiace, nessun dato trovato per la richiesta fatta")

	end if
	
end if

SetPointer(oldpointer)


return k_return


end function

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle C_colore
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
pointer kpointer_1
st_esito kst_esito


  
try	

	kpointer_1 = setpointer(HourGlass!)
 
//--- Funzione di ggiornamento tabelle 
//---           Ritorna : 0=OK; 1=Errore agg. grave; 2=Errore agg. secondario
	k_return = aggiorna_tabelle()

		
//--- ANOMALIA!		
	if Left(k_return, 1) = "1" then

		kguo_sqlca_db_magazzino.db_rollback( )
//		if kst_esito.esito <> kkg_esito.ok then
//			k_return += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
//		end if
		k_return += "~n~rPrego, controllare i dati !! "
		
	else
//--- OK!		

//--- aggiorna evenuati altre tabelle
		if aggiorna_tabelle_altre() then

//--- Commit		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				k_return = "3" + "Fallita conferma di aggiornamento archivi (COMMIT), errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			end if
			
		else
			k_return = "1Anomalia durante aggiornamento delle tabelle correlate (aggiona_tabella_altre)"
			kguo_sqlca_db_magazzino.db_rollback( )
//			if kst_esito.esito <> kkg_esito.ok then
//				k_return += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
//			end if
			k_return += "~n~rPrego, controllare i dati !! "
			
		end if
		
	end if

	
	if left(k_return,1) = "0" then	
//--- rilegge in elenco solo la riga appena aggiornata	(rilegge solo i dw e colonne aggiornabili)
		if dw_lista_0.visible and dw_lista_0.getrow( ) > 0 then
			dw_lista_0.ReselectRow ( dw_lista_0.getrow( ) ) 	
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1Errore: " + kst_esito.sqlerrtext + " (" + string(kst_esito.sqlcode ) + ")" 


finally
	setpointer(kpointer_1)


end try




//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore tab ;
//=== 		 : 2=errore 
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "0" then
//	kiuf1_sync_window.set_funzione_aggiornata()  // x sincronizzare i dati con il chiamante
	
else
	if Left(k_return, 1) = "1" then
		messagebox("Operazione di Aggiornamento Non Eseguita !!", &
			Mid(k_return, 2))
	else
		if Left(k_return, 1) = "2" then
			messagebox("Aggiornamento Parziale degli Archivi !!", &
				Mid(k_return, 2))
		else
			if Left(k_return, 1) = "3" then
				messagebox("Registrazione dati : problemi nella 'Commit' !!", &
					"Provare chiudere e ripetere le operazioni eseguite")
				else
			end if
		end if
	end if
end if


return k_return

end function

protected subroutine pulizia_righe ();//
//--- Togliere le righe che non interessano
//
//--- Standard modificabile
//
dw_dett_0.accepttext()
dw_lista_0.accepttext()


end subroutine

protected function string aggiorna_dati ();//
string k_return = "0 "


try
	dw_dett_0.accepttext()
	if dw_dett_0.rowcount() > 0 then
	
	//--- Aggiornamento dei dati inseriti/modificati
		k_return = super::aggiorna_dati()
	
		if Left(k_return, 1) = "0" then
		
			if ki_exit_si then
	
//				if ki_msg_dopo_save_ok then
//					messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//				end if
			else
	
				if ki_exit_dopo_save_ok then
					//close(this)
					cb_ritorna.post event clicked( )
				else
	
	//--- visualizza subito la modifica in elenco
					if dw_lista_0.visible then 
						aggiorna_window()
					end if
		
					if ki_msg_dopo_save_ok then
						messagebox("Operazione eseguita", "Dati aggiornati correttamente")
					end if
		
					if ki_reset_dopo_save_ok then
						dw_dett_0.reset()
						dw_dett_0.visible = false
						u_resize( )
					end if
					
					if dw_lista_0.visible then 
						dw_lista_0.setfocus()
					end if
					
					if ki_riparte_dopo_save_ok then
						inizializza( )
					else
						if ki_visualizza_dopo_save_ok then
							cb_visualizza.event clicked( )
						else
							attiva_tasti()
						end if
					end if
				end  if		
			end  if		
		end  if		
	end if

catch (uo_exception kuo_exception)

end try

return k_return



end function

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza_return="", k_key
long k_riga_getrow=0
int k_importa=0
boolean k_insersci = false



//=== Puntatore Cursore da attesa.....
	setpointer(kkg.pointer_attesa)	


	dw_lista_0.ki_d_std_1_primo_giro = true

//	dw_dett_0.SetRedraw (false)
//	dw_lista_0.SetRedraw (false)


//=== salvo il nr. di riga su cui ero
	k_riga_getrow = dw_lista_0.getrow()
	if k_riga_getrow <= 0 then
		k_riga_getrow = 1
	end if

//=== Parametri passati con il WITHPARM (st_parametri.text)
//=== Inizializzazione tasti e retrieve della Lista
	if trim(ki_st_open_w.flag_where) = "wh" then

		k_inizializza_return = inizializza_1()  //dalla FROM della Select personalizzata

//=== Se avevo specificato qualcosa nella ricerca tento il posizionamento
		if isvalid(kguo_g.KGuf_trova) then
//			if isvalid(kguo_g.KGuf_trova.get_window_trova()) then
				u_trova_in_dw(KKG_FLAG_RICHIESTA.trova_ancora )
//			end if
		end if
 
	else  
		
//=== Percorso piu' frequente dell'inizializzazione =====================================

//=== se ho fatto una selezione su una richiesta per una determinata chiave (es. un cliente, rag soc ....)
		k_key = trim(ki_st_open_w.key1)
		if k_key > " " then
		else
			k_key = ""
		end if
		ki_st_open_w.key1 = trim(k_key)

		try
			
			if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento and cb_inserisci.enabled then 
			
				k_insersci = true
//				cb_inserisci.postevent(clicked!)
				
				
			else
			
				k_inizializza_return = inizializza() //Reimposta i tasti e fa la retrieve di lista

//--- Setta la riga come l'ultima volta che sono uscito (importfile)
				if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
					kGuf_data_base.dw_importfile_set_row(trim(ki_syntaxquery), dw_lista_0)
				end if
			end if
			
		catch (uo_exception kuo_exception)
		end try


	end if
	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if k_insersci then
	
		cb_inserisci.event clicked( )
		
	else
		if Left(k_inizializza_return,1) <> "2" then
			
			inizializza_lista_ok(k_riga_getrow)
			
	//--- fa delle cose personalizzate per i figli
			inizializza_post()
			
	//		attiva_tasti()
	
	//		dw_dett_0.SetRedraw (true)
	//		dw_lista_0.SetRedraw (true)
	
	//	 	SetPointer(kkg.pointer_default)
	
		else
	
	//	 	SetPointer(kkg.pointer_default)
	
	//--- FORZA USCITA!!!
			cb_ritorna.post event clicked( )
			
		end if
	end if

end subroutine

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in 


	case KKG_FLAG_RICHIESTA.refresh_row		//Aggiorna la riga se riesce altrimenti rilegge tutto: leggi_liste()
		leggi_riga()

	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
		leggi_liste_reset()
		leggi_liste()

	case KKG_FLAG_RICHIESTA.inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.conferma		//richiesta conferma
		if cb_aggiorna.enabled = true then
			cb_aggiorna.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.visualizzazione		//richiesta visual
		if cb_visualizza.enabled = true then
			cb_visualizza.postevent(clicked!)
		end if

	case KKG_FLAG_RICHIESTA.modifica		//richiesta modif
		if cb_modifica.enabled = true then
			cb_modifica.postevent(clicked!)
		end if
		
	case KKG_FLAG_RICHIESTA.MOSTRA_NASCONDI_DW_DETT		//Mostra/Nascsondi la dw_dett_0
		mostra_nascondi_dw()

	case else
		super::smista_funz(k_par_in)

end choose


//return k_return

end subroutine

protected function boolean dati_modif_1 ();//
//--- dati modificati?
//--- true=si; false=no
//
boolean k_boolean = false


	dati_modif_accept( )

	if dw_dett_0.u_dati_modificati() then
		
		k_boolean = true
		
	end if
			
			
return k_boolean
			

end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
any k_key
string k_campo_key=""
kuf_utility kuf1_utility
kuf_parent kuf1_parent 
st_tab_g_0 kst_tab_g_0 
st_open_w kst_open_w	


	if trim(ki_st_open_w.nome_id_tabella) > " " then
		k_campo_key = trim(ki_st_open_w.nome_id_tabella)
	else
		k_campo_key = "#1"
	end if

	choose case upper(Left(dw_lista_0.Describe(k_campo_key + ".Coltype"),2))
		
		case 'CH'
			k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))
		
	 	case else
			k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))

	end choose

	if trim(string(k_key)) > " " then 

		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//--- verifica la funzione da lanciare
		kst_open_w.id_programma = ki_st_open_w.id_programma
		if ki_st_open_w.nome_oggetto > " " then
			kuf1_parent = create using ki_st_open_w.nome_oggetto  //nme oggetto = KUF_....
			if isvalid(kuf1_parent) then
				kst_open_w.id_programma = kuf1_parent.get_id_programma(kst_open_w.flag_modalita)
			end if
		end if
		
//--- se la funzione da lanciare è diversa da quella attuale lancio quella funzione	
		if kst_open_w.id_programma <> ki_st_open_w.id_programma then
			
			if isnumber(string(k_key)) then
				kst_tab_g_0.id = k_key
			else
				kst_tab_g_0.idx = trim(k_key)
			end if
			kuf1_parent.u_open_applicazione(kst_tab_g_0, kst_open_w.flag_modalita)
			k_return = 1
		
		else
//--- se la funzione è la stessa allora attivo il dw_dett_0
			k_return = dw_dett_0.retrieve( k_key ) 
		
			if k_return > 0 then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	
//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
				if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
					kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
				end if
				destroy kuf1_utility
			end if
		end if		
	end if		

return k_return

end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
any k_key
string k_campo_key=""
kuf_utility kuf1_utility
kuf_parent kuf1_parent 
st_tab_g_0 kst_tab_g_0 
st_open_w kst_open_w	


	if trim(ki_st_open_w.nome_id_tabella) > " " then
		k_campo_key = trim(ki_st_open_w.nome_id_tabella)
	else
		k_campo_key = "#1"
	end if

	choose case upper(Left(dw_lista_0.Describe(k_campo_key + ".Coltype"),2))
		
		case 'CH'
			k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))
		
	 	case else
			k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), trim(dw_lista_0.Describe(k_campo_key + ".Name")))

	end choose

	if trim(string(k_key)) > " " then 

		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//--- verifica la funzione da lanciare
		kst_open_w.id_programma = ki_st_open_w.id_programma
		if ki_st_open_w.nome_oggetto > " " then
			kuf1_parent = create using ki_st_open_w.nome_oggetto  //nme oggetto = KUF_....
			if isvalid(kuf1_parent) then
				kst_open_w.id_programma = kuf1_parent.get_id_programma(kst_open_w.flag_modalita)
			end if
		end if
		
//--- se la funzione da lanciare è diversa da quella attuale lancio quella funzione	
		if kst_open_w.id_programma <> ki_st_open_w.id_programma then
			
			if isnumber(string(k_key)) then
				kst_tab_g_0.id = k_key
			else
				kst_tab_g_0.idx = trim(k_key)
			end if
			kuf1_parent.u_open_applicazione(kst_tab_g_0, kst_open_w.flag_modalita)
			k_return = 1
		
		else
//--- se la funzione è la stessa allora attivo il dw_dett_0
			k_return = dw_dett_0.retrieve( k_key ) 
		
			if k_return > 0 then
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		
//--- Protezione campi per disabilitare la modifica 
				kuf1_utility = create kuf_utility
				kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
				destroy kuf1_utility

			end if
		end if		
	end if		


return k_return

end function

protected function string leggi_liste ();//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga


try
	
	dw_lista_0.setredraw(false)

	if ki_riga_selezionata = 0 then
		k_riga = dw_lista_0.getrow()
	else
		k_riga = ki_riga_selezionata
	end if
	
	inizializza()
	
	if k_riga > dw_lista_0.rowcount() or k_riga = 0 then
		k_riga = dw_lista_0.rowcount() 
	end if
	if k_riga > 0 then
		dw_lista_0.sort()
		if k_riga > 3 then
			dw_lista_0.scrolltorow(k_riga - 3)
		else
			dw_lista_0.scrolltorow(k_riga)
		end if
		dw_lista_0.setrow(k_riga)
		dw_lista_0.selectrow(0 , false)
//--- se di tipo GRID allora non seleziona		
		if dw_lista_0.Object.DataWindow.Processing = "1" then
			dw_lista_0.selectrow(k_riga , true)
		end if
	else

		k_return = "1 "

	end if
	
	
	
catch (uo_exception kuo_exception)

finally
	attiva_tasti( )
	dw_lista_0.setredraw(true)

end try
	
return k_return





end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu

if ki_st_open_w.flag_primo_giro <> "S" then

	//--- se non c'e' alcun menu non faccio sta roba
	if isvalid(ki_menu) then
	
	//--- per evitare un errore strano di null object al ritorno dal dettaglio
		if ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled <> cb_aggiorna.enabled then
			ki_menu.m_finestra.m_gestione.m_fin_conferma.enabled = cb_aggiorna.enabled
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
	
		if ki_st_open_w.flag_adatta_win = kkg.ADATTA_WIN and not(ki_personalizza_pos_controlli) and dw_lista_0.enabled and dw_dett_0.enabled  then
			if not ki_menu.m_finestra.m_fin_dettaglio.enabled then
				ki_menu.m_finestra.m_fin_dettaglio.enabled = true
				ki_menu.m_finestra.m_fin_dettaglio.toolbaritemvisible = true
			end if
		else
			if ki_menu.m_finestra.m_fin_dettaglio.visible then
				ki_menu.m_finestra.m_fin_dettaglio.visible = false
				ki_menu.m_finestra.m_fin_dettaglio.enabled = false
			end if
			if ki_menu.m_finestra.m_fin_dettaglio.toolbaritemvisible then
				ki_menu.m_finestra.m_fin_dettaglio.toolbaritemvisible = false
			end if
		end if
	
	//---
		super::attiva_menu()
		
	end if
end if

end subroutine

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
	end if
	
	
	if dw_dett_0.update() <> 1 then

		k_return = "1Errore: " + dw_dett_0.ki_SQLsyntax + " (" + string(dw_dett_0.ki_SQLdbcode) + ")" 

	end if
		

return k_return


end function

protected function integer select_riga (long k_riga);//
	if k_riga > 0 then
		dw_lista_0.selectrow(0, false)
		dw_lista_0.scrolltorow(k_riga)
		dw_lista_0.selectrow(k_riga, true)
		dw_lista_0.setrow(k_riga)
	end if
return k_riga

end function

protected subroutine mostra_nascondi_dw ();//

		this.setredraw(false)
		
		if ki_resize_dw_dett then
			ki_resize_dw_dett=false
			dw_lista_0.setfocus( )
		else
			ki_resize_dw_dett=true
			dw_dett_0.setfocus( )
		end if


//--- mostra o nasconde la window di dettaglio
		u_resize()
		
		this.setredraw(true)

		attiva_tasti( )
end subroutine

protected function string inizializza_post ();//
string k_return
long k_riga


if not ki_exit_si then

//---- Tenta il posizionamento sulla riga di Inizio lista dell'ultima exit
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
		if dw_lista_0.enabled and dw_lista_0.rowcount( ) > 1 then 
			k_riga = kGuf_data_base.dw_setta_riga(trim(ki_syntaxquery), dw_lista_0)
			if k_riga > 0 and k_riga <= dw_lista_0.rowcount( ) then 
				if k_riga > 1 then
					dw_lista_0.scrolltorow( k_riga - 1)
				else 
					dw_lista_0.scrolltorow( k_riga )
				end if
				dw_lista_0.selectrow(k_riga, true)
				dw_lista_0.setrow(k_riga)
				dw_lista_0.setfocus( )
			end if
		end if
	end if
	
//	attiva_tasti()

	k_return = super::inizializza_post()
	
end if

return k_return

end function

protected subroutine u_personalizza_dw ();//---
//--- Personalizza DW
//---

	dw_dett_0.ki_flag_modalita = ki_st_open_w.flag_modalita 
	dw_dett_0.event u_personalizza_dw()
	



end subroutine

protected subroutine fine_primo_giro ();//
super::fine_primo_giro()

end subroutine

protected function string leggi_riga ();//======================================================================
//=== Rilegge la riga 
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga


	k_riga = dw_lista_0.getrow()
	
	if k_riga > dw_lista_0.rowcount() or k_riga = 0 then
		k_return = "1 "
	else
		k_riga = dw_lista_0.ReselectRow(k_riga)
	end if
	if k_riga < 1 then
		k_return = "1 "
	end if

//--- se il tentativo di rilettura va male allora rileggo tutto	
	if k_return <> "0 " then
//		k_return = leggi_liste( )
	else
		dw_lista_0.SetRedraw (false)
		dw_lista_0.GroupCalc()
		dw_lista_0.SetRedraw (true)
		dw_lista_0.setfocus()
	end if
	
return k_return





end function

protected function boolean aggiorna_tabelle_altre () throws uo_exception;//
//--- Update di altre Tabelle - da personalizzare
//--- Chiamata dopo AGGIORNA_TABELLE se tutto OK
//---
boolean k_return = true



return k_return


end function

protected subroutine leggi_liste_reset ();//
//======================================================================
//=== Resetta elenco 
//======================================================================
//


	ki_riga_selezionata = dw_lista_0.getrow()
	dw_lista_0.reset()





end subroutine

protected subroutine dati_modif_accept ();//
	dw_dett_0.accepttext()


end subroutine

protected subroutine stampa_esegui (st_stampe ast_stampe);//
//w_g_tab kwindow_1



//	kwindow_1 = kGuf_data_base.prendi_win_attiva()
	
	if isvalid(kidw_selezionata) then
		ast_stampe.dw_print = kidw_selezionata
	else
		if dw_lista_0.visible then
			ast_stampe.dw_print = dw_lista_0
		else
			if dw_dett_0.visible then
				ast_stampe.dw_print = dw_dett_0
			end if
		end if
	end if
	
	if isvalid(ast_stampe.dw_print) then
		ast_stampe.titolo = trim(kiw_this_window.title)
		kGuf_data_base.stampa_dw(ast_stampe)
	else
		messagebox("Richiesta Stampa", "Stampa non eseguita, funzione non attiva")
	end if
	
end subroutine

protected subroutine inizializza_lista_ok (long a_riga_posiziona);//
//=== Routine STANDARD x OK
//=== input: riga di posizionamento
//
int k_return=0


//=== Puntatore Cursore da attesa.....
//	SetPointer(kkg.pointer_attesa )

//=== posizionamento sulla riga su cui ero
	if dw_lista_0.rowcount() > 0 then 
		if dw_lista_0.getrow() = 0 then
			if a_riga_posiziona > dw_lista_0.rowcount() then
				a_riga_posiziona = dw_lista_0.rowcount()
			end if
		else
			a_riga_posiziona = dw_lista_0.getrow()
		end if

		dw_lista_0.setrow(a_riga_posiziona)
		dw_lista_0.selectrow(0, false)
		if a_riga_posiziona > 1 then
			dw_lista_0.selectrow(a_riga_posiziona, true)
		end if
		dw_lista_0.scrolltorow(a_riga_posiziona)
	end if		
		
//=== 
	if ki_st_open_w.flag_primo_giro = "S" then  //se sono su giro di prima volta 
	
		if not dw_guida.visible then
			if dw_dett_0.visible = true and dw_dett_0.rowcount() = 0 then
				dw_dett_0.setrow(1)
				dw_dett_0.setcolumn(1)
			end if
	
			if dw_lista_0.visible = true then
				dw_lista_0.setfocus()
			else
				if dw_dett_0.visible = true then
					dw_dett_0.setfocus()
				end if
			end if
		end if
	end if


end subroutine

protected function integer inserisci ();//
kuf_utility kuf1_utility
kuf_parent kuf1_parent
st_open_w kst_open_w
st_tab_g_0 kst_tab_g_0


	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
//--- verifica la funzione da lanciare
	kst_open_w.id_programma = ki_st_open_w.id_programma
	if ki_st_open_w.nome_oggetto > " " then
		kuf1_parent = create using ki_st_open_w.nome_oggetto  //nme oggetto = KUF_....
		if isvalid(kuf1_parent) then
			kst_open_w.id_programma = kuf1_parent.get_id_programma(kst_open_w.flag_modalita)
		end if
	end if
	
//--- se la funzione da lanciare è diversa da quella attuale lancio quella funzione	
	if kst_open_w.id_programma <> ki_st_open_w.id_programma then
		
		kuf1_parent.u_open_applicazione(kst_tab_g_0, kst_open_w.flag_modalita)
	
	else

		ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 
	
	//--- S-protezione campi per riabilitare la modifica a parte la chiave
		kuf1_utility = create kuf_utility
		kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
		destroy kuf1_utility
	
		dw_dett_0.reset()
	
		attiva_tasti()
	
	//=== Aggiunge una riga al data windows
		dw_dett_0.scrolltorow(dw_dett_0.insertrow(dw_dett_0.getrow() + 1))
		dw_dett_0.setcolumn(1)
		
	//=== Posiziona il cursore sul Data Windows
		dw_dett_0.setfocus() 
		
	end if	

return (0)


end function

protected function string inizializza () throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//string k_key
//
//
////=== ATTENZIONE: QUESTA PARTE E' SOLO DI ESEMPIO
//
//
//	k_key = trim(trim(k_st_open_w.key1))
//	
//	k_key = k_key + "%"
//
//	if dw_lista_0.retrieve(k_key) < 1 then
//		k_return = "1Nessuna Informazione trovata "
//
//		messagebox("Lista archivio Vuota", &
//			"Mi spiace, ma non e' stato Trovato nulla per la richiesta fatta ~n~r" + &
//			"(Dati ricercati :" + k_key + ")" )
//
//	end if
//		
//
return k_return



end function

public subroutine u_window_st_oizzontal_restore ();//---
//--- Ripristino il posizinamento della dw_dett salvato al prec chiusura
//---
//---
string k_WindowState, k_section, k_rcx 
st_profilestring_ini kst_profilestring_ini

	   
	k_section = "winsize_" + trim(ki_nome_save) //kw_super.ClassName()

	kst_profilestring_ini.operazione = "1"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "window"
	kst_profilestring_ini.titolo = "divide_st_orizzontal"

	kst_profilestring_ini.nome = k_section + "_" + "st_orizzontal_y"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	if kst_profilestring_ini.esito <> "1" then
		ki_st_orizzontal_y_start = long(kst_profilestring_ini.valore)
	end if
	
	
	
	
end subroutine

public subroutine u_window_st_oizzontal_save ();//---
//--- Salva il posizinamento della dw_dett per ripristino al prx riavvio
//---
//---
string k_WindowState, k_section, k_rcx 
st_profilestring_ini kst_profilestring_ini

	   
	k_section = "winsize_" + trim(ki_nome_save) //kw_super.ClassName()

	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = "window"
	kst_profilestring_ini.titolo = "divide_st_orizzontal"

	kst_profilestring_ini.valore = String(st_orizzontal.y)
	kst_profilestring_ini.nome = k_section + "_" + "st_orizzontal_y"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	
	super::u_window_control_save( )  // esegue anche la parent
	
	
	
end subroutine

public function boolean u_lancia_funzione_imvc (st_open_w ast_open_w);//---
//--- lancia la funzione giusta di Inserimento/Modifica/Visualizzazione/Cancellazione
//---
//--- Inp: st_open_w.flag_modalita
//--- Out: boolean: TRUE = OK
//---
boolean k_return = false
long k_riga=0
int k_esito_funzione=0
string k_errore="0 ", k_esito_funzioneX="0", k_dati_modificati="0", k_esito=""
st_open_w kst_open_w


kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = ast_open_w.flag_modalita

//--- controlla se utente autorizzato alla funzione in atto
if sicurezza(kst_open_w) then

//--- disabilito i link automatici se MODIFICA o INSERIMENTO
	dw_dett_0.ki_link_standard_attivi = true
	
//--- Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
	if not dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0 then
		
		dw_dett_0.enabled = true
		
	else 
		
		if dw_dett_0.rowcount( ) > 0 then
			
//--- Controllo se ho modificato dei dati nella DW DETTAGLIO (0=nessun agg., 1=aggiornare, 2=non aggiornare, 3=Annulla operazione)
			k_esito = dati_modif(trim(kiw_this_window.title))
			if len(k_esito) > 0 then 
				k_dati_modificati = left(k_esito, 1)
			end if
			if k_dati_modificati = "1" then //Fare gli aggiornamenti
	
//--- Controllo congruenza dei dati caricati e Aggiornamento  
//--- Ritorna 1 char : 0=tutto OK; 1=errore grave;
//---                      : 2=errore non grave dati aggiornati;
//---			          : 3=
//---                      il resto della stringa contiene la descrizione dell'errore   
				k_errore = aggiorna_dati()
	
			end if
		end if
	end if
	
	
//----	se Operazione di Aggiornamento OK  and  NON devo annullare tutta l'Operazione
	if Left(k_errore, 1) = "0" and k_dati_modificati <> "3" then

		
		choose case kst_open_w.flag_modalita
		
			case kkg_flag_modalita.inserimento

				dw_dett_0.reset()
				inserisci( )
				k_return = true
				
				if dw_dett_0.enabled then
					ki_resize_dw_dett = true
					u_resize()
					dw_dett_0.setfocus()		
	
					u_personalizza_dw ()
				end if
				
				
			case kkg_flag_modalita.modifica
				if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					dw_dett_0.reset()
					if modifica( ) > 0 then
						k_return = true
						
						if dw_dett_0.rowcount( ) > 0 and dw_dett_0.enabled then
							ki_resize_dw_dett = true
							u_resize()
							dw_dett_0.setfocus()		
			
							u_personalizza_dw ()
							dw_dett_0.resetupdate( )

//--- posizionamento della riga in modo che si veda							
							if dw_lista_0.getrow( ) > 0 then
								dw_lista_0.scrolltorow(dw_lista_0.getrow( ))
							end if
						end if
					else
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "Operazione fallita", "Dati non trovati in archivio~n~r" +&
																		"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
					end if
				end if
				
			case kkg_flag_modalita.visualizzazione
				if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					dw_dett_0.reset()
					if visualizza() > 0 then
						k_return = true
						
						if dw_dett_0.rowcount( ) > 0 and dw_dett_0.enabled then
							ki_resize_dw_dett = true
							u_resize()
							dw_dett_0.setfocus()		
			
							u_personalizza_dw ()
//--- posizionamento della riga in modo che si veda							
							if dw_lista_0.getrow( ) > 0 then
								dw_lista_0.scrolltorow(dw_lista_0.getrow( ))
							end if
						end if
					else
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "Operazione fallita", "Dati non trovati in archivio~n~r" +&
																		"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
					end if
				end if
				
			case kkg_flag_modalita.cancellazione
				if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					k_esito_funzioneX = cancella( )
					if len(trim(k_esito_funzioneX)) > 0 then
						if left(k_esito_funzioneX,1) = "0" then
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
							kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						end if
					end if
				end if
		
				
		end choose
		

		attiva_tasti()
		
	end if
	
end if	


return k_return



end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe
//--- certi tasti sono attivi solo se dw e' di tipo elenco...
string k_lista, k_nome_controllo
       


super::attiva_tasti_0()		 

cb_ritorna.visible = false
cb_inserisci.visible = false
cb_aggiorna.visible = false
cb_modifica.visible = false
cb_cancella.visible = false
cb_visualizza.visible = false

cb_ritorna.enabled = true
if ki_nessun_tasto_funzionale then
	cb_inserisci.enabled = false
else
	cb_inserisci.enabled = ki_consenti_inserisci
end if
cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false
cb_visualizza.enabled = false

if not ki_nessun_tasto_funzionale then
	
//=== Nr righe ne DW lista
	if dw_lista_0.getrow ( ) > 0 then
		cb_modifica.enabled = ki_consenti_modifica
		cb_cancella.enabled = true
		cb_visualizza.enabled = ki_consenti_visualizza
		cb_visualizza.default = true
	end if
	
	st_aggiorna_lista.enabled = true

//--- queste dw dovrebbero essere di tipo GRID...
	k_lista = "1" 
	k_nome_controllo = kGuf_data_base.u_getfocus_nome()
	choose case k_nome_controllo
		case "dw_lista_0"
     	 	k_lista = dw_lista_0.Object.DataWindow.Processing
		case "dw_dett_0"
      		k_lista = dw_dett_0.Object.DataWindow.Processing
	end choose
	if k_lista = "1" or k_lista = "8" then
		st_ordina_lista.enabled = true
	else
		st_ordina_lista.enabled = false
	end if
	
//=== Nr righe nel DW dettaglio
	if ki_st_open_w.flag_primo_giro <> 'S' then
		if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled then
			if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
				cb_cancella.enabled = true
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
					or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then
					cb_aggiorna.enabled = dati_modif_1()
				end if
			end if
		end if
	end if
end if



end subroutine

public subroutine u_obj_visible_0 ();//
//--- Valido solo una volta!
//--- Visualizza le DW a cui era stato posto il flag di ki_d_std_1_primo_giro 
//

	if dw_guida.enabled then dw_guida.visible = true
	
	if dw_dett_0.ki_dw_visibile_in_open_window then dw_dett_0.visible = true
	dw_dett_0.ki_dw_visibile_in_open_window = false  // il flag ha compiuto suo dovere si puo' spegnere
	if dw_lista_0.ki_dw_visibile_in_open_window then dw_lista_0.visible = true
	dw_lista_0.ki_dw_visibile_in_open_window = false  // il flag ha compiuto suo dovere si puo' spegnere
	
	if dw_lista_0.visible and dw_dett_0.visible then
		if st_orizzontal.enabled then 
			st_orizzontal.visible = true
		end if
	end if


end subroutine

public subroutine u_resize_1 ();//---
long k_height=0, k_guida_height=0, k_guida_y=0
long k_dock_x = 0, k_dock_y = -0

	
	
	this.setredraw(false)

	st_orizzontal.x = 1
	st_orizzontal.height = 30
	st_orizzontal.width =	this.WorkSpaceWidth()
	if st_orizzontal.y = 0 then
		st_orizzontal.y = this.WorkSpaceHeight() * 0.9 * (1 / 2) 
	end if

	if dw_guida.enabled then //visible then
		dw_guida.x = 1 - k_dock_x
		dw_guida.y = 1 - k_dock_y
		dw_guida.height = 90
		dw_guida.width = st_orizzontal.width
		k_height = this.WorkSpaceHeight() - dw_guida.height 
		k_guida_height = dw_guida.height
		k_guida_y = dw_guida.y
	else
		dw_guida.y = 0 - k_dock_x
		dw_guida.height = 0
		dw_guida.width = 0
		k_guida_height = 0
		k_height = this.WorkSpaceHeight()
		k_guida_y = 0 - k_dock_y
	end if
//--- se tutte due le dw sono visibili allora....
	if ki_resize_dw_dett and (dw_lista_0.visible or dw_lista_0.ki_dw_visibile_in_open_window) then

		dw_lista_0.x = 1 //st_orizzontal.x 
		dw_lista_0.y = dw_guida.height + dw_guida.y + 5 
		dw_dett_0.y = st_orizzontal.y + st_orizzontal.height
		dw_dett_0.x = st_orizzontal.x
			
		dw_lista_0.height = st_orizzontal.y  - dw_lista_0.y 
		dw_dett_0.height =  k_height + dw_guida.height - st_orizzontal.y - st_orizzontal.height 
		dw_lista_0.width = st_orizzontal.width
		dw_dett_0.width = st_orizzontal.width
		
		st_orizzontal.visible = true

	else
//--- se visibile solo una dw allora...

		st_orizzontal.visible = false
		
//--- se solo la Lista e' visibile allora....
		if dw_lista_0.visible or dw_lista_0.ki_dw_visibile_in_open_window then
			dw_lista_0.x = 1 //st_orizzontal.x 
			dw_lista_0.y = k_guida_height + k_guida_y + 1
			dw_lista_0.width = st_orizzontal.width
			dw_lista_0.height = k_height
			
		else
//--- se solo il dettaglio e' visibile allora....
			if ki_resize_dw_dett or dw_dett_0.ki_dw_visibile_in_open_window then
				ki_resize_dw_dett = true
				dw_dett_0.x = 1 //st_orizzontal.x 
				dw_dett_0.y = k_guida_height + k_guida_y + 1
				dw_dett_0.width = st_orizzontal.width
				dw_dett_0.height = k_height  
			end if
		end if
	end if

	dw_dett_0.visible=ki_resize_dw_dett

	this.setredraw(true)




end subroutine

public subroutine u_win_ripri_video ();//
	u_resize_1( )
	

end subroutine

public function boolean u_window_control_restore ();//
boolean k_return = false

	u_window_st_oizzontal_restore( )
	k_return = super::u_window_control_restore( )

return k_return	
end function

event closequery;call super::closequery;//
//=== Controllo prima della chiusura della Windows
//
int k_errore=0


	cb_ritorna.enabled = false


//=== Verifico DATI_MODIF solo se tasti di modif. abilitati
	if ki_st_open_w.flag_modalita =	kkg_flag_modalita.modifica &
	   or ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then 	
		
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 999=premuto ANNULLA OPERAZIONE
		k_errore = ritorna(trim(this.title))

		if k_errore = 1 or k_errore = 2 or k_errore = 999 then
			ki_exit_si = false
			attiva_tasti()
			return 1       
		end if

	end if


//--- Salva le righe del dw (saveas)
	kGuf_data_base.dw_saveas(trim(ki_syntaxquery), dw_lista_0)
	
return 0
 	
 	
end event

on w_g_tab0.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_aggiorna=create cb_aggiorna
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.dw_dett_0=create dw_dett_0
this.st_orizzontal=create st_orizzontal
this.dw_lista_0=create dw_lista_0
this.dw_guida=create dw_guida
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_aggiorna
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.dw_dett_0
this.Control[iCurrent+7]=this.st_orizzontal
this.Control[iCurrent+8]=this.dw_lista_0
this.Control[iCurrent+9]=this.dw_guida
end on

on w_g_tab0.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_aggiorna)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.dw_dett_0)
destroy(this.st_orizzontal)
destroy(this.dw_lista_0)
destroy(this.dw_guida)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto

//--- chiudo finestra se sono in visualizzazione
//	if key = keyescape! and ki_st_open_w.flag_modalita = "vi" then
//		smista_funz("ri")
//	end if
//
//
if key = keyenter! then
			
	if dw_guida.visible then
		dw_guida.event ue_buttonclicked()
	end if
	
end if

end event

event u_open;call super::u_open;//
dw_lista_0.ki_d_std_1_primo_giro = true
//

	//--- Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
	choose case true
		case dw_lista_0.enabled
			dw_lista_0.tag = this.title
	
		case dw_dett_0.enabled
			dw_dett_0.tag = this.title
			
	end choose
	
	if ki_utente_abilitato then
	
	//--- posizionamento della barra divisoria delle 2 dw di elenco e dettaglio
		if ki_st_orizzontal_y_start > 0 then
			st_orizzontal.y = ki_st_orizzontal_y_start
		else
			st_orizzontal.y = 0
		end if
	
		if trim(ki_st_open_w.flag_leggi_dw) = "S" then
	//--- Retrive solo sulle righe richieste
	//		kiuo_d_std_trova = create uo_d_std_trova
	//		kiuo_d_std_trova = dw_trova 
	//		kiuo_d_std_trova.cerca_in_any(integer(trim(ki_st_open_w.key1)))
			ki_trova_campo_def = integer(trim(ki_st_open_w.key1))
			u_trova_in_dw(KKG_FLAG_RICHIESTA.trova)
		else
			inizializza_lista()
		end if
	end if
	
	fine_primo_giro()

	u_resize()
	
//	attiva_tasti()

//	kGuo_g.kgw_attiva = this




end event

event u_open_preliminari;call super::u_open_preliminari;//
		
ki_resize_dw_dett = dw_dett_0.visible

end event

event close;call super::close;//
//	ki_risize = false
	u_window_st_oizzontal_save( )
	
end event

type st_ritorna from w_g_tab`st_ritorna within w_g_tab0
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_g_tab0
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_g_tab0
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_g_tab0
integer x = 2533
integer y = 1040
integer width = 329
integer height = 88
end type

type st_stampa from w_g_tab`st_stampa within w_g_tab0
end type

type cb_visualizza from commandbutton within w_g_tab0
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
st_open_w kst_open_w


kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
u_lancia_funzione_imvc(kst_open_w)



end event

type cb_modifica from commandbutton within w_g_tab0
boolean visible = false
integer x = 2528
integer y = 848
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
st_open_w kst_open_w


kst_open_w.flag_modalita = kkg_flag_modalita.modifica
u_lancia_funzione_imvc(kst_open_w)



end event

type cb_aggiorna from commandbutton within w_g_tab0
boolean visible = false
integer x = 2528
integer y = 944
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

type cb_cancella from commandbutton within w_g_tab0
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
st_open_w kst_open_w


kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
u_lancia_funzione_imvc(kst_open_w)



end event

type cb_inserisci from commandbutton within w_g_tab0
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
string text = "&Nuovo"
end type

event clicked;//
st_open_w kst_open_w


kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
u_lancia_funzione_imvc(kst_open_w)



end event

type dw_dett_0 from uo_d_std_1 within w_g_tab0
integer x = 23
integer y = 628
integer width = 2446
integer height = 684
integer taborder = 40
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
boolean ki_dw_visibile_in_open_window = false
end type

event itemfocuschanged;call super::itemfocuschanged;//
attiva_tasti()
end event

event itemchanged;call super::itemchanged;//
attiva_tasti() 

end event

event getfocus;call super::getfocus;
//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

//if this.rowcount() > 0 then
//	u_resize()
//end if

attiva_tasti()
end event

event clicked;call super::clicked;//
attiva_tasti()
end event

type st_orizzontal from statictext within w_g_tab0
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
boolean visible = false
integer x = 14
integer y = 544
integer width = 2757
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long backcolor = 0
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	if Parent.PointerY() > parent.height / 10 then
		if Parent.PointerY() > (parent.height - (this.height * 10)) then  // se tiro giù molto allora scompare la finestra di dettaglio
			mostra_nascondi_dw()
			this.y = 0
		else
			This.y = Parent.PointerY()
			u_resize( )
		end if
	end if
End If


end event

event mouseup;//
u_resize( )

end event

event constructor;//
	this.backcolor = parent.backcolor

end event

type dw_lista_0 from uo_d_std_1 within w_g_tab0
integer y = 128
integer width = 2793
integer height = 420
integer taborder = 110
boolean enabled = true
end type

event u_doppio_click;//
//--- comportamento di default
//
if cb_visualizza.enabled then 
	cb_visualizza.event clicked( )
end if

end event

event sqlpreview;call super::sqlpreview;//
//--- salvo la query di select x "salvataggio e avvio veloce delle liste dw"
long k_return = 0
long k_riga


if sqltype = Previewselect! then
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta 
		k_riga = kGuf_data_base.dw_importfile(trim(sqlsyntax), dw_lista_0) 
		if k_riga > 0 then
			select_riga(k_riga)
			k_return = 2  //non esegue la retrieve al DB 
		end if
	end if
	ki_syntaxquery = sqlsyntax
end if

return k_return
end event

event getfocus;call super::getfocus;//
kidw_selezionata = this

//--- imposta oggetto selezionato x fare il TROVA
kigrf_x_trova = this

attiva_tasti()

end event

event clicked;call super::clicked;//
attiva_tasti()
end event

type dw_guida from uo_d_std_guida within w_g_tab0
integer x = 78
integer y = 16
integer width = 2441
integer height = 80
integer taborder = 10
boolean bringtotop = true
end type

