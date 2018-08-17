$PBExportHeader$w_g_tab_3_old.srw
forward
global type w_g_tab_3_old from Window
end type
type cb_ritorna from commandbutton within w_g_tab_3_old
end type
type cb_aggiorna from commandbutton within w_g_tab_3_old
end type
type cb_cancella from commandbutton within w_g_tab_3_old
end type
type cb_inserisci from commandbutton within w_g_tab_3_old
end type
type st_parametri from statictext within w_g_tab_3_old
end type
type tab_1 from tab within w_g_tab_3_old
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from datawindow within tabpage_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from datawindow within tabpage_5
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tab_1 from tab within w_g_tab_3_old
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
end forward

global type w_g_tab_3_old from Window
int X=220
int Y=161
int Width=1633
int Height=1489
boolean Visible=false
boolean TitleBar=true
string Title="WINDOWS STANDARD"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean Resizable=true
WindowType WindowType=child!
event ue_menu pbm_custom01
cb_ritorna cb_ritorna
cb_aggiorna cb_aggiorna
cb_cancella cb_cancella
cb_inserisci cb_inserisci
st_parametri st_parametri
tab_1 tab_1
end type
global w_g_tab_3_old w_g_tab_3_old

forward prototypes
protected function string aggiorna ()
protected function string check_dati ()
protected function string aggiorna_dati ()
protected function integer inserisci ()
protected function integer cancella ()
protected function integer conferma ()
public function string smista_funz (string k_par_in)
protected subroutine inizializza ()
protected subroutine stampa ()
protected subroutine inizializza_lista ()
protected subroutine inizializza_1 ()
protected subroutine pulizia_righe ()
protected function string dati_modif (string k_titolo)
protected function integer ritorna (string k_titolo)
protected subroutine attiva_tasti ()
protected subroutine inizializza_2 ()
protected subroutine inizializza_3 ()
protected subroutine riempi_id ()
protected subroutine inizializza_4 ()
end prototypes

event ue_menu;//
smista_funz(this.tag)
end event

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
				end if
end if

//=== Aggiorna, se modificato, la TAB_2
if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_2.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_3
if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_3.dw_3.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_3.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_4
if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_4.dw_4.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_4.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_4.text + "' ~n~r" 
	end if	
end if


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


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
char k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key


//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = tab_1.tabpage_1.dw_1.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 1) 

		if isnull(k_key) or len(trim(k_key)) = 0 then
			k_return = "Manca il codice " + tab_1.tabpage_1.text + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 2)) = "" or &
				isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, 2)) = true then
				k_return = "Manca la descrizione " + tab_1.tabpage_1.text + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		k_riga++

		if k_errore = "0" and k_riga <= k_nr_righe then
			if tab_1.tabpage_1.dw_1.find("#1 = '" + k_key + "'", k_riga, k_nr_righe) > 0 then
				k_return = "Codice gia' in archivio " + tab_1.tabpage_1.text + "~n~r" 
				k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		k_riga = tab_1.tabpage_1.dw_1.getnextmodified(k_riga, primary!)

	loop


//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 1) 

		if isnull(k_key) or len(trim(k_key)) = 0 then
			k_return = "Manca il codice " + tab_1.tabpage_2.text + "~n~r"
			k_errore = "3"
			k_nr_errori++
		else
			if trim(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 2)) = "" or &
				isnull(tab_1.tabpage_2.dw_2.getitemstring ( k_riga, 2)) = true then
				k_return = "Manca la descrizione " + tab_1.tabpage_2.text + "~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		k_riga++

		if k_errore = "0" and k_riga <= k_nr_righe then
			if tab_1.tabpage_2.dw_2.find("#1 = '" + k_key + "'", k_riga, k_nr_righe) > 0 then
				k_return = "Codice gia' in archivio " + tab_1.tabpage_2.text + "~n~r" 
				k_return = k_return + "(Codice " + trim(k_key) + ") ~n~r"
				k_errore = "3"
				k_nr_errori++
			end if
		end if

		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop



return k_errore + k_return


end function

protected function string aggiorna_dati ();//
//=== Completa gestione aggiornamento tabelle : Check dati + Update
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave e/o aggiuornam. non eseguito; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
//
string k_return="0 "
string k_errore= "0 ", k_errore1 = "0 ", k_errore_dati = "0 "
char k_errore_check


//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
k_errore_dati = check_dati()

k_errore_check = left(k_errore_dati,1)

choose case k_errore_check 

	case "1" 
		messagebox("Digitati dati incongruenti, operazione non eseguita", &
			     mid(k_errore_dati, 2))
		k_return="1" + mid(k_errore_dati, 2)
	case "2"
		messagebox("Inseriti dati non validi, operazione non eseguita", & 
			     mid(k_errore_dati, 2))
		k_return="1" + mid(k_errore_dati, 2)
	case "3"
		messagebox("Dati insufficienti, operazione non eseguita", & 
			     mid(k_errore_dati, 2))
		k_return="1" + mid(k_errore_dati, 2)
	case "4", "0"
		if k_errore_check = "4" then

			if left(k_errore_dati, 1) = "4" then
				if messagebox("Ho rilevato alcune incongruenze", &
						mid(k_errore_dati, 2) + &		
						"~n~rVuoi eseguire comunque l'Aggiornamento ?", &
						question!, yesno!, 1) = 2 then
					k_return = "1" + "Dati non aggiornati"
				else
					k_return = "2" + mid(k_errore_dati, 2)
				end if
			end if
		else
			k_return = "0"
		end if
		if left(k_return,1) <> "1" then

//=== Imposta campi e codici prima di aggiornare le tabelle
			riempi_id()

//=== k_errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 			: 2=LIBERA
//===				: 3=Commit fallita
			k_errore = aggiorna()		

			if left(k_errore, 1) = "1" or left(k_errore, 1) = "3" then
				k_return="1" + mid(k_errore, 2)
			else
				if left(k_errore, 1) = "0" then
					k_return = "0"
				end if
               
			end if
		end if

end choose


return k_return
end function

protected function integer inserisci ();//
int k_return=1
string k_errore="0 "
long k_ctr


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if left(k_errore, 1) = "0" then

//=== Imposta tasti
	attiva_tasti()

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
			k_ctr = tab_1.tabpage_1.dw_1.insertrow(0)
			tab_1.tabpage_1.dw_1.scrolltorow(k_ctr)
			tab_1.tabpage_1.dw_1.setrow(k_ctr)
			tab_1.tabpage_1.dw_1.setcolumn(1)
		case 2
			k_ctr = tab_1.tabpage_2.dw_2.insertrow(0)
			tab_1.tabpage_2.dw_2.scrolltorow(k_ctr)
			tab_1.tabpage_2.dw_2.setrow(k_ctr)
			tab_1.tabpage_2.dw_2.setcolumn(1)
		case 3
			k_ctr = tab_1.tabpage_3.dw_3.insertrow(0)
			tab_1.tabpage_3.dw_3.scrolltorow(k_ctr)
			tab_1.tabpage_3.dw_3.setrow(k_ctr)
			tab_1.tabpage_3.dw_3.setcolumn(1)
		case 4
			k_ctr = tab_1.tabpage_4.dw_4.insertrow(0)
			tab_1.tabpage_4.dw_4.scrolltorow(k_ctr)
			tab_1.tabpage_4.dw_4.setrow(k_ctr)
			tab_1.tabpage_4.dw_4.setcolumn(1)
		case 5
			k_ctr = tab_1.tabpage_5.dw_5.insertrow(0)
			tab_1.tabpage_5.dw_5.scrolltorow(k_ctr)
			tab_1.tabpage_5.dw_5.setrow(k_ctr)
			tab_1.tabpage_5.dw_5.setcolumn(1)
	end choose	

	k_return = 0
end if

return (k_return)
end function

protected function integer cancella ();//
string k_desc
string k_id_catfi
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
////kuf_catfi  kuf1_catfi
//
//
////=== Controllo se sul dettaglio c'e' qualche cosa
//k_riga = dw_dett_0.getrow()	
//if k_riga > 0 then
//	k_id_catfi = dw_dett_0.getitemstring(k_riga, "id_catfi")
//	k_desc = dw_dett_0.getitemstring(k_riga, "desc")
//
//	if isnull(k_desc) = true or trim(k_desc) = "" then
//		k_desc = "Codice IVA senza Descrizione" 
//	end if
//	
////=== Richiesta di conferma della eliminazione del rek
//
////	if messagebox("Elimina Categoria Omogenea", &
////		"Sei sicuro di voler Togliere tutti gli Articoli  " + &
////		"che appartengono alla ' " + k_desc + "~n~r" +  &
////		"dall'elenco degli Articoli per Cliente"
////				question!, yesno!, 1) = 1 then
//// 
////=== Creo l'oggetto che ha la funzione x cancellare la tabella
//		kuf1_catfi = create kuf_catfi
//		
////=== Cancella la riga dal data windows di lista
//		k_errore = kuf1_catfi.tb_delete(k_id_catfi) 
//		if left(k_errore, 1) = "0" then
//
//			k_errore = kuf1_data_base.db_commit()
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante la Cancellazione !!", &
//						"Controllare i dati. " + mid(k_errore, 2))
//
//			else
//				
//				dw_dett_0.deleterow(k_riga)
//
//			end if
//
//			dw_dett_0.setfocus()
//
//		else
//			k_errore1 = k_errore
//			k_errore = kuf1_data_base.db_rollback()
//
//			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
//							mid(k_errore1, 2) ) 	
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante il recupero dell'errore !!", &
//					"Controllare i dati. " + mid(k_errore, 2))
//			end if
//
//			attiva_tasti()
//	
//
//		end if
//
////=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
//		destroy kuf1_catfi
//
////	else
////		messagebox("Elimina Codice IVA", "Operazione Annullata !!")
////	end if
//
//	dw_dett_0.setcolumn(1)
//
//end if
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

public function string smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case left(k_par_in, 2) 

	case "ag"		//aggiorna lista
		inizializza_lista()

	case "in"		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.triggerevent(clicked!)
		end if

	case "ca"		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.triggerevent(clicked!)
		end if

	case "co"		//richiesta conferma
		if cb_aggiorna.enabled = true then
			cb_aggiorna.triggerevent(clicked!)
		end if

	case "st"		//richiesta stampa datawindow
		stampa ()

	case "ri"		//richiesta uscita
		if cb_ritorna.enabled = true then
			cb_ritorna.triggerevent(clicked!)
		end if

end choose


return k_return



end function

protected subroutine inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== ESEMPIO TIPICO DI INIZIALIZZA
//string k_key
//
//
//
//	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
//
////		tab_1.tabpage_1.dw_1.reset()
//
//		k_key = trim(mid(st_parametri.text, 3, 20))
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
//	tab_1.tabpage_1.dw_1.setfocus()
//
//	
//
//
//
end subroutine

protected subroutine stampa ();//
//=== stampa dw
string k_errore


	choose case tab_1.selectedtab
		case 1
			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_1.dw_1,&
					tab_1.tabpage_1.text, 0))
		case 2
			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_2.dw_2, &
					tab_1.tabpage_2.text, 0))
		case 3
			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_3.dw_3, &
					tab_1.tabpage_3.text, 0))
		case 4
			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_4.dw_4, &
					tab_1.tabpage_4.text, 0))
		case 5
			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_5.dw_5, &
					tab_1.tabpage_5.text, 0))
	end choose
	
end subroutine

protected subroutine inizializza_lista ();//
string k_errore="0 "


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
if cb_ritorna.enabled = true then //se non prima volta
	if cb_inserisci.enabled = true or cb_aggiorna.enabled = true or &
		cb_cancella.enabled = true then

		if left(dati_modif(""), 1) = "1" then 

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
			k_errore = aggiorna_dati()
			
		end if
	end if
end if

tab_1.visible = true

if left(k_errore, 1) = "0" then

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case 1 
			inizializza()
		case 2
			inizializza_1()
		case 3
			inizializza_2()
		case 4
			inizializza_3()
		case 5
			inizializza_4()
	end choose	

end if


end subroutine

protected subroutine inizializza_1 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== ESEMPIO TIPICO DI INIZIALIZZA
//string k_key
//
//
//
//	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
//
////		tab_1.tabpage_1.dw_1.reset()
//
//		k_key = trim(mid(st_parametri.text, 3, 20))
//
//		if tab_1.tabpage_1.dw_1.retrieve(k_key) <= 0 then
//
//			messagebox("Operazione fallita", &
//				"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
//				"(Dato ricercato :" + trim(k_key) + ")~n~r" )
//
//			inserisci()
//			
//		end if
//	end if
//
//	tab_1.tabpage_1.dw_1.setfocus()
//
//	
//
//
//
end subroutine

protected subroutine pulizia_righe ();//
//=== STANDARD MODIFICABILE 
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

	if tab_1.tabpage_1.dw_1.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
		k_key = tab_1.tabpage_1.dw_1.getitemstring(k_ctr, 1) 
 		if isnull(k_key) or len(trim(k_key)) = 0 then
			tab_1.tabpage_1.dw_1.deleterow(k_ctr)
		end if
	end if
next

k_riga = tab_1.tabpage_2.dw_2.rowcount ( )
for k_ctr = k_riga to 1 step -1

	if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! then 
		k_key = tab_1.tabpage_2.dw_2.getitemstring(k_ctr, 1) 
 		if isnull(k_key) or len(trim(k_key)) = 0 then
			tab_1.tabpage_2.dw_2.deleterow(k_ctr)
		end if
	end if
next


end subroutine

protected function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 or &
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or &
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or &
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
	 	tab_1.tabpage_5.dw_5.getnextmodified(0, primary!) > 0 or &
		tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 or &
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 or &
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 or &
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 or &
	 	tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0 &
		then

		if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
			k_titolo = "Aggiorna Archivio"
		end if

		k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
							question!, yesnocancel!, 1) 
	
		if k_msg = 1 then
			k_return = "1Dati Modificati"	
		else
			k_return = string(k_msg)			
		end if

	end if


return k_return
end function

protected function integer ritorna (string k_titolo);//
string k_errore = "0 "



//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
k_errore = left(dati_modif(k_titolo), 1)
if k_errore = "1" then  //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = aggiorna_dati()	
else
	if k_errore = "3" then 
		k_errore = "2"  //Operazione ANNULLATA
	else
		k_errore = "0"  //Non fare aggiornamenti USCITA da pgm
	end if
end if


return integer(left(k_errore, 1))

end function

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


//cb_inserisci.enabled = true
//cb_aggiorna.enabled = true
//cb_modifica.enabled = true
//cb_modifica.default = true
//cb_cancella.enabled = true


//=== Nr righe ne DW lista
//if dw_dett_0.getrow ( ) <= 0 then
//	cb_inserisci.enabled = true
//	cb_inserisci.default = true
//	cb_modifica.default = false
//	cb_modifica.enabled = false
//	cb_cancella.enabled = false
//	cb_aggiorna.enabled = false
//end if
            

end subroutine

protected subroutine inizializza_2 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== ESEMPIO TIPICO DI INIZIALIZZA
//string k_key
//
//
//
//	if tab_1.tabpage_3.dw_3.rowcount() = 0 then
//
////		tab_1.tabpage_3.dw_3.reset()
//
//		k_key = trim(mid(st_parametri.text, 3, 20))
//
//		if tab_1.tabpage_3.dw_3.retrieve(k_key) <= 0 then
//
//			messagebox("Operazione fallita", &
//				"Mi spiace ma nessun dato e' stato Trovato per la richiesta fatta ~n~r" + &
//				"(Dato ricercato :" + trim(k_key) + ")~n~r" )
//
//			inserisci()
//			
//		end if
//	end if
//
//	tab_1.tabpage_3.dw_3.setfocus()
//
//	
//
//
//
end subroutine

protected subroutine inizializza_3 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

protected subroutine riempi_id ();//
//=== Routine di impostazioni campi appena prima della UPDATE
//
end subroutine

protected subroutine inizializza_4 ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
//=== VEDI ALTRI ESEMPI DI INIZIALIZZA_?()

	



end subroutine

event open;//
//=== Parametri di Input : 1  lung 2   scelta; 
//===								3  lung 20  Key principale
//===								23 lung 1   's'=adatta windows alla definiz.
//===								24 lung 26  Libero x future implem
//===								50 lung ??  Personalizzabile
//===								
//
long k_width, k_height//=== Posiziona e ridimensiona window all'interno MDI 


//this.visible = false

//=== Parametri passati con il WITHPARM
st_parametri.text = message.stringparm

//=== Mostra Finestra : max=61472; min=61488; normal=61728
send(handle(this), 274, 61728, 0)

//=== set transobject per il datawindows di dettaglio
tab_1.tabpage_1.dw_1.settransobject ( sqlca )
tab_1.tabpage_2.dw_2.settransobject ( sqlca )
if tab_1.tabpage_3.dw_3.visible = true then
	tab_1.tabpage_3.dw_3.settransobject ( sqlca )
end if
if tab_1.tabpage_4.dw_4.visible = true then
	tab_1.tabpage_4.dw_4.settransobject ( sqlca )
end if
if tab_1.tabpage_5.dw_5.visible = true then
	tab_1.tabpage_5.dw_5.settransobject ( sqlca )
end if

//=== Posiziona e ridimensiona window all'interno MDI 
if mid(st_parametri.text, 23, 1) = 's' then
	k_width = w_main.width * 0.9
	k_height = w_main.height * 0.8
	if this.width < k_width then
		this.width = k_width
	end if
	if this.height < k_height then
		this.height = k_height
	end if
end if
if w_main.width > this.width then
	this.x = (w_main.width - this.width) / 2.5
else
	this.x = 1
end if
if w_main.height > this.height then
	this.y = (w_main.height - this.height) / 6
else
	this.y = 1
end if
this.triggerevent(resize!)

inizializza_lista()
//dw_dett_0.setrowfocusindicator ( Hand! )


end event

event closequery;//
//=== Controllo prima della chiusura della Windows
int k_errore


//if keydown(keyescape!) = false then

//=== Verifico DATI_MODIF solo se tasti di modif. abilitati
if cb_aggiorna.enabled or cb_inserisci.enabled or cb_cancella.enabled then
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = ritorna(this.title)

	if k_errore = 1 or k_errore = 2 then
		attiva_tasti()
		return 1       
	end if

end if
	
end event

on w_g_tab_3_old.create
this.cb_ritorna=create cb_ritorna
this.cb_aggiorna=create cb_aggiorna
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.st_parametri=create st_parametri
this.tab_1=create tab_1
this.Control[]={ this.cb_ritorna,&
this.cb_aggiorna,&
this.cb_cancella,&
this.cb_inserisci,&
this.st_parametri,&
this.tab_1}
end on

on w_g_tab_3_old.destroy
destroy(this.cb_ritorna)
destroy(this.cb_aggiorna)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.st_parametri)
destroy(this.tab_1)
end on

event resize;//

if tab_1.visible = true then
	this.setredraw(false)

//=== Dimensione dw nella window 
	tab_1.width = this.width - 60
	if cb_ritorna.visible then
		tab_1.height = this.height - cb_ritorna.height * 1.5 - 150
		cb_ritorna.y = this.height - cb_ritorna.height * 1.5 - 75
		cb_aggiorna.y = this.height - cb_aggiorna.height * 1.5 - 75
		cb_cancella.y = this.height - cb_cancella.height * 1.5 - 75
		cb_inserisci.y = this.height - cb_inserisci.height * 1.5 - 75
		cb_ritorna.x = this.width - cb_ritorna.width - 50
		cb_cancella.x = cb_ritorna.x - cb_cancella.width - 50
		cb_aggiorna.x = cb_cancella.x - cb_aggiorna.width - 50
		cb_inserisci.x = cb_aggiorna.x - cb_inserisci.width - 50
	else
		tab_1.height = this.height - 200
	end if
//=== Posiziona dw nella window 
	tab_1.x = (this.width - tab_1.width) / 4
	tab_1.y = (this.height - tab_1.height) / 7

//=== Dimensiona dw nel tab
//	choose case tab_1.selectedtab
//		case 1	
			tab_1.tabpage_1.dw_1.width = tab_1.tabpage_1.width - 10
			tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - 30
			tab_1.tabpage_1.dw_1.x = (tab_1.tabpage_1.width - tab_1.tabpage_1.dw_1.width) / 2
			tab_1.tabpage_1.dw_1.y = (tab_1.tabpage_1.height - tab_1.tabpage_1.dw_1.height) / 2
//		case 2
			tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - 10
			tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height - 30
			tab_1.tabpage_2.dw_2.x = (tab_1.tabpage_2.width - tab_1.tabpage_2.dw_2.width) / 2
			tab_1.tabpage_2.dw_2.y = (tab_1.tabpage_2.height - tab_1.tabpage_2.dw_2.height) / 2
//		case 3
			tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - 10
			tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - 30
			tab_1.tabpage_3.dw_3.x = (tab_1.tabpage_1.width - tab_1.tabpage_3.dw_3.width) / 2
			tab_1.tabpage_3.dw_3.y = (tab_1.tabpage_1.height - tab_1.tabpage_3.dw_3.height) / 2
///	case 4
			tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - 10
			tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - 30
			tab_1.tabpage_4.dw_4.x = (tab_1.tabpage_4.width - tab_1.tabpage_4.dw_4.width) / 2
			tab_1.tabpage_4.dw_4.y = (tab_1.tabpage_4.height - tab_1.tabpage_4.dw_4.height) / 2
///	case 4
			tab_1.tabpage_5.dw_5.width = tab_1.tabpage_5.width - 10
			tab_1.tabpage_5.dw_5.height = tab_1.tabpage_5.height - 30
			tab_1.tabpage_5.dw_5.x = (tab_1.tabpage_5.width - tab_1.tabpage_5.dw_5.width) / 2
			tab_1.tabpage_5.dw_5.y = (tab_1.tabpage_5.height - tab_1.tabpage_5.dw_5.height) / 2
//	end choose
	
	this.setredraw(true)
end if




end event

event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu


//=== Salvo il Tag attuale per reimpostarlo a fine routine
	k_tag_old = this.tag

//=== Creo menu Popup 
	m_menu = create m_popup

	m_menu.m_agglista.visible = true
	m_menu.m_t_agglista.visible = true
	m_menu.m_stampa.visible = true
	m_menu.m_t_stampa.visible = true
	m_menu.m_conferma.visible = cb_aggiorna.enabled
	m_menu.m_ritorna.visible = true
	m_menu.m_inserisci.visible = cb_inserisci.enabled

//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato
	choose case tab_1.selectedtab
		case 1
			k_stringa = tab_1.tabpage_1.dw_1.GetObjectAtPointer()
		case 2
			k_stringa = tab_1.tabpage_2.dw_2.GetObjectAtPointer()
	end choose
	if k_stringa <> "" then
		k_riga = long(right(k_stringa, len(k_stringa) - pos(k_stringa, "~t")))

		if k_riga > 0 then 
			
			choose case tab_1.selectedtab
				case 1
					tab_1.tabpage_1.dw_1.setrow(k_riga)
					tab_1.tabpage_1.dw_1.selectrow(0,false)
//					tab_1.tabpage_1.dw_1.selectrow(k_riga ,true)
					tab_1.tabpage_1.dw_1.setcolumn(1)
				case 2
					tab_1.tabpage_2.dw_2.setrow(k_riga)
					tab_1.tabpage_2.dw_2.selectrow(0,false)
//					tab_1.tabpage_2.dw_2.selectrow(k_riga ,true)
					tab_1.tabpage_2.dw_2.setcolumn(1)
			end choose

			m_menu.m_modifica.visible = false
			m_menu.m_t_modifica.visible = true
			m_menu.m_cancella.visible = cb_cancella.enabled
			m_menu.m_t_cancella.visible = cb_cancella.enabled

		end if
	end if


//=== Attivo il menu Popup
	m_menu.visible = true
	m_menu.popmenu(this.x + pointerx(), this.y + pointery())
	m_menu.visible = false

	destroy m_menu

	k_tag = this.tag 

	this.tag = k_tag_old 

	smista_funz(k_tag)

//
end event

event close;window k_window


k_window = kuf1_data_base.prendi_win_prec()

//=== per evitare che la windows a cui ritorna venga maximizzata
if isnull(k_window) = false then
//	send(handle(this), 274, 61728, 0)

	k_window.windowstate = normal!
end if



end event

event key;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyescape! 
		if cb_ritorna.enabled = true then
			cb_ritorna.triggerevent(clicked!)
		end if
end choose

end event

type cb_ritorna from commandbutton within w_g_tab_3_old
int X=1207
int Y=1225
int Width=330
int Height=109
int TabOrder=20
boolean Visible=false
boolean Enabled=false
string Text="&Ritorna"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
close(parent)

end event

type cb_aggiorna from commandbutton within w_g_tab_3_old
event clicked pbm_bnclicked
int X=467
int Y=1225
int Width=330
int Height=109
int TabOrder=40
boolean Visible=false
boolean Enabled=false
string Text="&Conferma"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then
//	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//	dw_dett_0.reset()
//	dw_lista_0.setfocus()
	
	attiva_tasti()
	
//	inserisci()
	if cb_inserisci.enabled = true then
		cb_inserisci.triggerevent(clicked!)
	end if

	
end if

end event

type cb_cancella from commandbutton within w_g_tab_3_old
event clicked pbm_bnclicked
int X=837
int Y=1225
int Width=330
int Height=109
int TabOrder=50
boolean Visible=false
boolean Enabled=false
string Text="&Elimina"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
cancella()
end event

type cb_inserisci from commandbutton within w_g_tab_3_old
event clicked pbm_bnclicked
int X=97
int Y=1225
int Width=330
int Height=109
int TabOrder=30
boolean Visible=false
string Text="&Nuovo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
//=== 
string k_errore



k_errore = left(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = aggiorna_dati()		

else

	if k_errore = "2" then //Aggiornamento non richiesto
		k_errore = "0"
	end if

end if

if left(k_errore, 1) = "0" then 
	inserisci()
end if

end event

type st_parametri from statictext within w_g_tab_3_old
int X=92
int Y=1105
int Width=247
int Height=73
boolean Visible=false
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tab_1 from tab within w_g_tab_3_old
event ue_rbuttondown pbm_rbuttondown
int X=10
int Y=13
int Width=1276
int Height=1061
int TabOrder=10
boolean Visible=false
boolean RaggedRight=true
int SelectedTab=1
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event ue_rbuttondown;//
parent.triggerevent(rbuttondown!)
end event

event selectionchanged;//

//	parent.triggerevent(resize!)
//
	tab_1.tabpage_1.dw_1.accepttext()
	tab_1.tabpage_2.dw_2.accepttext()
	tab_1.tabpage_3.dw_3.accepttext()
	tab_1.tabpage_4.dw_4.accepttext()
	tab_1.tabpage_5.dw_5.accepttext()

	if oldindex = 0 then
		oldindex = 1
	end if
	tab_1.tag = string(oldindex)

	choose case newindex 
		case 1 
			inizializza()
		case 2
			inizializza_1()
		case 3
			inizializza_2()
		case 4
			inizializza_3()
		case 5
			inizializza_4()
	end choose	


end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={ this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto
int k_null

setnull(k_null)

//case keyenter!
//	setactioncode(1)
//else
choose case key
	case keyescape!
		if cb_ritorna.enabled = true then
			cb_ritorna.postevent(clicked!)
		end if
	case keypagedown!
		if tab_1.selectedtab = 1 and tab_1.tabpage_2.visible = true and &
			tab_1.tabpage_2.enabled = true then
			tab_1.selectedtab = 2
		else
			if tab_1.selectedtab = 2 and tab_1.tabpage_3.visible = true and &
				tab_1.tabpage_3.enabled = true then
				tab_1.selectedtab = 3
			else
				if tab_1.selectedtab = 3 and tab_1.tabpage_4.visible = true and &
					tab_1.tabpage_4.enabled = true then
					tab_1.selectedtab = 4
				else
					tab_1.selectedtab = 1
				end if
			end if
		end if
	case keypageup!
		if tab_1.selectedtab = 1 and tab_1.tabpage_4.visible = true and &
			tab_1.tabpage_4.enabled = true then
			tab_1.selectedtab = 4
		else
			if tab_1.selectedtab = 2 and tab_1.tabpage_1.visible = true and &
				tab_1.tabpage_1.enabled = true then
				tab_1.selectedtab = 1
			else
				if tab_1.selectedtab = 3 and tab_1.tabpage_2.visible = true and &
					tab_1.tabpage_2.enabled = true then
					tab_1.selectedtab = 2
				else
					tab_1.selectedtab = 1
				end if
			end if
		end if
end choose

			

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=113
int Width=1239
int Height=933
long BackColor=79741120
string Text="none"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

event rbuttondown;//
parent.triggerevent("rbuttondown")
end event

type dw_1 from datawindow within tabpage_1
event ue_dwnkey pbm_dwnkey
int X=14
int Y=21
int Width=1217
int Height=901
int TabOrder=11
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_dwnkey;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyinsert! 
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if
	case keyenter!, KeyDownArrow!
		if this.getrow() = this.rowcount() then
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if
	case else
		tab_1.trigger event key (key, 0)
end choose

end event

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event itemerror;//
//=== Evita la messaggistica di sistema
return 1

end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event clicked;//
string k_name
long k_colore


//This.SetRow(row)
if row = 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	k_name = dwo.Name
	IF dwo.Type = "text" and mid(k_name, len(trim(k_name)), 1) = "t" THEN

		k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
		dwo.Color = RGB(255,0,0)

		k_name = Left(k_name, Len(k_name) - 2) // tolgo la '_t' 

//=== se campo char sort ascendente altrimenti discendente
		if left(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
			This.SetSort(k_name + " A")
		else
			This.SetSort(k_name + " D")
		end if
		This.Sort()

////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
//		this.tag = k_name
		
		dwo.Color = k_colore

	END IF

end if

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=113
int Width=1239
int Height=933
long BackColor=12632256
string Text="none"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={ this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
int X=10
int Y=21
int Width=1217
int Height=901
int TabOrder=11
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_dwnkey;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyinsert! 
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if
	case keyenter!, KeyDownArrow!
		if this.getrow() = this.rowcount() then
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if
	case else
		tab_1.trigger event key (key, 0)
end choose

end event

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event getfocus;//=== Controlla quali tasti attivare
attiva_tasti()


end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event itemerror;//
return 1
end event

event clicked;//
string k_name
long k_colore


//This.SetRow(row)
if row = 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	k_name = dwo.Name
	IF dwo.Type = "text" and mid(k_name, len(trim(k_name)), 1) = "t" THEN

		k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
		dwo.Color = RGB(255,0,0)

		k_name = Left(k_name, Len(k_name) - 2) // tolgo la '_t' 

//=== se campo char sort ascendente altrimenti discendente
		if left(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
			This.SetSort(k_name + " A")
		else
			This.SetSort(k_name + " D")
		end if
		This.Sort()

////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
//		this.tag = k_name
		
		dwo.Color = k_colore

	END IF

end if

end event

type tabpage_3 from userobject within tab_1
int X=19
int Y=113
int Width=1239
int Height=933
boolean Visible=false
long BackColor=12632256
string Text="none"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={ this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_3
event dberror pbm_dwndberror
event getfocus pbm_dwnsetfocus
event itemerror pbm_dwnitemvalidationerror
event rbuttondown pbm_dwnrbuttondown
event ue_dwnkey pbm_dwnkey
int X=10
int Y=21
int Width=407
int Height=309
int TabOrder=1
boolean Border=false
boolean LiveScroll=true
end type

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event getfocus;//=== Controlla quali tasti attivare
attiva_tasti()


end event

event itemerror;//
return 1
end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event ue_dwnkey;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyinsert! 
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if
	case keyenter!, KeyDownArrow!
		if this.getrow() = this.rowcount() then
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if
	case else
		tab_1.trigger event key (key, 0)
end choose

end event

event clicked;//
string k_name
long k_colore


//This.SetRow(row)
if row = 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	k_name = dwo.Name
	IF dwo.Type = "text" and mid(k_name, len(trim(k_name)), 1) = "t" THEN

		k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
		dwo.Color = RGB(255,0,0)

		k_name = Left(k_name, Len(k_name) - 2) // tolgo la '_t' 

//=== se campo char sort ascendente altrimenti discendente
		if left(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
			This.SetSort(k_name + " A")
		else
			This.SetSort(k_name + " D")
		end if
		This.Sort()

////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
//		this.tag = k_name
		
		dwo.Color = k_colore

	END IF

end if

end event

type tabpage_4 from userobject within tab_1
int X=19
int Y=113
int Width=1239
int Height=933
boolean Visible=false
long BackColor=12632256
string Text="none"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={ this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from datawindow within tabpage_4
event dberror pbm_dwndberror
event getfocus pbm_dwnsetfocus
event itemerror pbm_dwnitemvalidationerror
event rbuttondown pbm_dwnrbuttondown
event ue_dwnkey pbm_dwnkey
int X=10
int Y=21
int Width=302
int Height=233
int TabOrder=1
boolean Border=false
boolean LiveScroll=true
end type

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event getfocus;//=== Controlla quali tasti attivare
attiva_tasti()


end event

event itemerror;//
return 1
end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event ue_dwnkey;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyinsert! 
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if
	case keyenter!, KeyDownArrow!
		if this.getrow() = this.rowcount() then
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if
	case else
		tab_1.trigger event key (key, 0)
end choose

end event

event clicked;//
string k_name
long k_colore


//This.SetRow(row)
if row = 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	k_name = dwo.Name
	IF dwo.Type = "text" and mid(k_name, len(trim(k_name)), 1) = "t" THEN

		k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
		dwo.Color = RGB(255,0,0)

		k_name = Left(k_name, Len(k_name) - 2) // tolgo la '_t' 

//=== se campo char sort ascendente altrimenti discendente
		if left(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
			This.SetSort(k_name + " A")
		else
			This.SetSort(k_name + " D")
		end if
		This.Sort()

////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
//		this.tag = k_name
		
		dwo.Color = k_colore

	END IF

end if

end event

type tabpage_5 from userobject within tab_1
int X=19
int Y=113
int Width=1239
int Height=933
boolean Visible=false
long BackColor=12632256
string Text="none"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={ this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from datawindow within tabpage_5
event dberror pbm_dwndberror
event getfocus pbm_dwnsetfocus
event itemerror pbm_dwnitemvalidationerror
event rbuttondown pbm_dwnrbuttondown
event ue_dwnkey pbm_dwnkey
int X=10
int Y=21
int Width=302
int Height=233
int TabOrder=11
boolean Border=false
boolean LiveScroll=true
end type

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event getfocus;//=== Controlla quali tasti attivare
attiva_tasti()


end event

event itemerror;//
return 1
end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event ue_dwnkey;//
//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyinsert! 
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if
	case keyenter!, KeyDownArrow!
		if this.getrow() = this.rowcount() then
			if cb_inserisci.enabled = true then
				cb_inserisci.postevent(clicked!)
			end if
		end if
	case else
		tab_1.trigger event key (key, 0)
end choose

end event

event clicked;//
string k_name
long k_colore


//This.SetRow(row)
if row = 0 then

//=== Se sono sulla testata della DW (il nome finisce x 't' ed e' un text)
//=== allora ordino le righe per quella colonna
	k_name = dwo.Name
	IF dwo.Type = "text" and mid(k_name, len(trim(k_name)), 1) = "t" THEN

		k_colore = long(this.Describe(string(trim(k_name)) + ".color"))
		dwo.Color = RGB(255,0,0)

		k_name = Left(k_name, Len(k_name) - 2) // tolgo la '_t' 

//=== se campo char sort ascendente altrimenti discendente
		if left(this.Describe(string(trim(k_name)) + ".colType"),4) = lower("char") then
			This.SetSort(k_name + " A")
		else
			This.SetSort(k_name + " D")
		end if
		This.Sort()

////=== Tengo in memoria per la Ricerca su quale campo ho compiuto il SORT
//		this.tag = k_name
		
		dwo.Color = k_colore

	END IF

end if

end event

