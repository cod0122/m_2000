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
type cb_ritorna from commandbutton within w_g_tab0
end type
type sle_cerca from singlelineedit within w_g_tab0
end type
type cb_cerca_1 from commandbutton within w_g_tab0
end type
type dw_lista_0 from uo_d_std_1 within w_g_tab0
end type
type dw_filtro_0 from datawindow within w_g_tab0
end type
type dw_dett_0 from uo_d_std_1 within w_g_tab0
end type
end forward

global type w_g_tab0 from w_g_tab
integer width = 2926
integer height = 1420
string title = "Windows Modello Base 0"
cb_visualizza cb_visualizza
cb_modifica cb_modifica
cb_aggiorna cb_aggiorna
cb_cancella cb_cancella
cb_inserisci cb_inserisci
cb_ritorna cb_ritorna
sle_cerca sle_cerca
cb_cerca_1 cb_cerca_1
dw_lista_0 dw_lista_0
dw_filtro_0 dw_filtro_0
dw_dett_0 dw_dett_0
end type
global w_g_tab0 w_g_tab0

type variables
//st_open_w ki_st_open_w
DataWindow  ki_dw_cerca

end variables

forward prototypes
private function string inizializza ()
private function string check_dati ()
private function string cancella ()
private function string leggi_liste ()
private function integer posiz_window ()
protected function integer inserisci ()
protected function integer modifica ()
private function integer check_rek (string k_codice)
protected function integer visualizza ()
private function string aggiorna_tabelle ()
protected subroutine cerca_in_lista (integer k_campo)
protected function string inizializza_1 ()
protected function integer filtro_dw ()
protected subroutine stampa ()
protected subroutine attiva_tasti ()
protected subroutine attiva_menu ()
protected function string aggiorna ()
protected function string dati_modif (string k_titolo)
protected subroutine pulizia_righe ()
public subroutine ordina_dw ()
protected function string aggiorna_dati ()
protected subroutine smista_funz (string k_par_in)
protected subroutine inizializza_lista ()
end prototypes

private function string inizializza ();//
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

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = "0 "


//=== Lasciata volutamente vuota 
//=== Da riempire a seconda dei casi funzionali


return k_return
end function

private function string cancella ();//
string k_return="0 "
//string k_desc
//string k_id_art
//string k_errore = "0 ", k_errore1 = "0 "
//long k_riga
//kuf_articoli  kuf1_articoli
//
//
////=== Controllo se sul dettaglio c'e' qualche cosa
//k_riga = dw_dett_0.rowcount()	
//if k_riga > 0 then
//	k_id_art = dw_dett_0.getitemstring(1, "id_art")
//	k_desc = dw_dett_0.getitemstring(1, "descrizione")
//end if
////=== Se sul dw non c'e' nessuna riga o nessun id_art allora pesco dalla lista
//if k_riga <= 0 or isnull(k_id_art) then
//	k_riga = dw_lista_0.getrow()	
//	if k_riga > 0 then
//		k_id_art = dw_lista_0.getitemstring(k_riga, "id_art")
//		k_desc = dw_lista_0.getitemstring(k_riga, "descrizione")
//	end if
//end if
//if k_riga > 0 and isnull(k_id_art) = false then	
//	if isnull(k_desc) = true or trim(k_desc) = "" then
//		k_desc = "Articolo senza Descrizione" 
//	end if
//	
////=== Richiesta di conferma della eliminazione del rek
//
//	if messagebox("Elimina Articolo", "Sei sicuro di voler Cancellare : ~n~r" + &
//				k_id_art + " " + trim(k_desc), &
//				question!, yesno!, 1) = 1 then
// 
////=== Creo l'oggetto che ha la funzione x cancellare la tabella
//		kuf1_articoli = create kuf_articoli
//		
////=== Cancella la riga dal data windows di lista
//		k_errore = kuf1_articoli.tb_delete(k_id_art) 
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
//		destroy kuf1_articoli
//
//	else
//		messagebox("Elimina Articolo", "Operazione Annullata !!")
//	end if
//
//	dw_dett_0.setcolumn(1)
//
//end if
//
return(k_return)
end function

private function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key


//=== ATTENZIONE: QUESTA PARTE E' SOLO DI ESEMPIO

	dw_lista_0.reset()

	inizializza()

//	k_key = trim(ki_st_open_w.key1)
//
//	if dw_lista_0.retrieve(k_key) > 0 then
//		k_return = "0 "
//	else
//
//		k_return = "1 "
//
//	end if


return k_return



end function

private function integer posiz_window ();//
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

protected function integer inserisci ();//

	dw_dett_0.reset()

	attiva_tasti()

//=== Aggiunge una riga al data windows
	dw_dett_0.scrolltorow(dw_dett_0.insertrow(dw_dett_0.getrow() + 1))
	dw_dett_0.setcolumn(1)
	
//=== Posiziona il cursore sul Data Windows
	dw_dett_0.setfocus() 


return (0)


end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
string k_key


	k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), 1)
	
	k_return = dw_dett_0.retrieve( k_key ) 


return k_return

end function

private function integer check_rek (string k_codice);//
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

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
string k_key
string k_rc="", k_rc1="", k_style=""
int k_ctr=0

	k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), 1)
	
	k_return = dw_dett_0.retrieve( k_key ) 

	k_rc1 = ""
	k_ctr=0
	do while k_rc1 = ""
		k_ctr = k_ctr + 1 
		k_rc1=dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+".TabSequence='0'")

		if k_rc1 = "" then
			k_style=dw_dett_0.Describe("#" + trim(string(k_ctr,"###"))+".Edit.Style")
			if upper(k_style) <> "DDDW" then
				k_rc1=string(rgb(192,192,192))
				dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Background.Color='"+k_rc1+"'")
				k_rc1=""
			end if
		end if

	loop 

return k_return

end function

private function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "


	if ki_st_open_w.flag_modalita = "in" then
		dw_dett_0.setitemstatus(1, 0, primary!, NewModified!)
	end if
	
	
	if dw_dett_0.update() <> 1 then

		rollback;


		k_return = "1Errore: " + sqlca.sqlerrtext

	else
		commit;
	end if

return k_return


end function

protected subroutine cerca_in_lista (integer k_campo);//=== Posiziona control edit

GraphicObject k_which_control

//--- cerca il dw con il fuoco
	k_which_control = GetFocus()
	
	CHOOSE CASE TypeOf(k_which_control)
		CASE DataWindow!
			ki_dw_cerca = k_which_control
	
//--- se nessun dw ha il fuoco allora x default impostao il dw_lista
		CASE ELSE
			dw_lista_0.setfocus()
			ki_dw_cerca = dw_lista_0
	
	END CHOOSE

	if ki_dw_cerca.RowCount( ) > 1 then

		cb_cerca_1.tag = trim(string(k_campo))
		
		sle_cerca.x = ki_dw_cerca.x + (ki_dw_cerca.width - sle_cerca.width) / 2
		sle_cerca.y = ki_dw_cerca.y + (ki_dw_cerca.height - sle_cerca.height) / 4

//=== Valorizzo il testo del edit con il testo della testata della colonna
		if sle_cerca.text = "" or isnull(sle_cerca.text) = true then
			sle_cerca.text = ki_dw_cerca.describe(&
					ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name") + &
							"_t.text")
	
		end if
	
		sle_cerca.visible = true
		sle_cerca.setfocus()
	
		cb_cerca_1.visible = true
		cb_cerca_1.x = sle_cerca.x + sle_cerca.width + 5
		cb_cerca_1.y = sle_cerca.y 	
		cb_cerca_1.default = true
	
		cb_cerca_1.bringtotop = true
		sle_cerca.bringtotop = true
	

//=== Disattivo flag di 'prima volta'
		if ki_st_open_w.flag_primo_giro = 'S' then
			ki_st_open_w.flag_primo_giro = ''
		end if
	end if

end subroutine

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
	k_select_orig = left(k_select_orig, k_pos - 1)
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
				"Mi spiace, ma nulla e' stato Trovato per la richiesta fatta")

	end if
	
end if

return k_return


end function

protected function integer filtro_dw ();//
//=== Possibilita' di filtrare su una colonna i valori richiesti
int k_return = 0
int k_ctr=0, k_nro_colonne=0, k_start_pos
string k_nome_colonna, k_nome_colonna_t, k_char


	if dw_filtro_0.rowcount() = 0 then

		dw_filtro_0.setvalue("k_campo", 1, " ")
		
		k_nro_colonne = integer(dw_lista_0.describe("DataWindow.column.count"))
		for k_ctr = 1 to k_nro_colonne
			
			k_nome_colonna = dw_lista_0.describe("#" + string(k_ctr) + ".name")
			k_nome_colonna_t = dw_lista_0.describe(k_nome_colonna + "_t.text")

			dw_filtro_0.setvalue("k_campo", k_ctr+1, &
							k_nome_colonna_t + "~t" + k_nome_colonna) 

//--- toglie caratteri di 'a capo' ecc...
			k_start_pos = 1
			k_char = char("~n")+char("~r")
			k_start_pos = Pos(k_nome_colonna_t, k_char, k_start_pos)
			DO WHILE k_start_pos > 0
				k_nome_colonna_t = Replace(k_nome_colonna_t, k_start_pos, 2, " ")
			   k_start_pos = Pos(k_nome_colonna_t, "~n~r", k_start_pos+2)

			LOOP

		next
		
		for k_ctr = 1 to 50
			dw_filtro_0.insertrow(k_ctr)
			dw_filtro_0.setitem(k_ctr, "k_segno", "=") 
//			dw_filtro_0.setitem(k_ctr, "k_or_and", &
//					(dw_filtro_0.getvalue("k_or_and",1)) )
			
		next

	end if

	dw_filtro_0.visible=true
	dw_filtro_0.setfocus()
	
	attiva_tasti()

return k_return

end function

protected subroutine stampa ();//
w_g_tab kwindow_1



	kwindow_1 = kuf1_data_base.prendi_win_attiva()

	kuf1_data_base.stampa_dw(dw_lista_0, trim(kwindow_1.title))

end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe

cb_ritorna.visible = false
cb_inserisci.visible = false
cb_aggiorna.visible = false
cb_modifica.visible = false
cb_cancella.visible = false
cb_visualizza.visible = false

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false
cb_visualizza.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.getrow ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true
	cb_visualizza.enabled = true
	cb_visualizza.default = true
end if

//=== Nr righe ne DW dettaglio
if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	if ki_st_open_w.flag_modalita <> "vi" then
		cb_cancella.enabled = true
		cb_aggiorna.enabled = true
	end if
end if
            
attiva_menu()

super::g_setta_win_titolo()


end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu

//--- per evitare un errore strano di null object al ritorno dal dettaglio
	kG_menu.m_finestra.m_gestione.enable()
	kG_menu.m_finestra.m_gestione.show()
	kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = cb_aggiorna.enabled
	kG_menu.m_finestra.m_gestione.m_fin_inserimento.enabled = cb_inserisci.enabled
	kG_menu.m_finestra.m_gestione.m_fin_modifica.enabled = cb_modifica.enabled
	kG_menu.m_finestra.m_gestione.m_fin_elimina.enabled = cb_cancella.enabled
	kG_menu.m_finestra.m_gestione.m_fin_visualizza.enabled = cb_visualizza.enabled
	kG_menu.m_finestra.m_fin_stampa.enabled = st_stampa.enabled

	kG_menu.m_finestra.m_fin_ordina.enabled = true
	kG_menu.m_finestra.m_fin_cerca.enabled = true
	kG_menu.m_finestra.m_fin_cercaancora.enabled = true
	kG_menu.m_finestra.m_fin_filtra.enabled = true
	kG_menu.m_finestra.m_aggiornalista.enabled = true
	kG_menu.m_finestra.m_riordinalista.enabled = true
	kG_menu.m_finestra.m_fin_ritornaesc.enabled = cb_ritorna.enabled
		
		

end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle C_colore
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "


 
//=== Funzione di ggiornamento tabelle 
//=== Ritorna : 0=OK; 1=Errore agg. grave; 2=Errore agg. secondario

k_return = aggiorna_tabelle()
			
if left(k_return, 1) = "1" then

	k_errore1 = kuf1_data_base.db_rollback()
else
//=== faccio la COMMIT		
	k_errore1 = kuf1_data_base.db_commit()

	if left(k_errore1, 1) <> "0" then
		k_return = "3" + "Fallito aggiornamento archivi !!"

	end if
end if



//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore tab ;
//=== 		 : 2=errore 
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "2" then
		messagebox("Aggiornamento Parziale degli Archivi !!", &
			mid(k_return, 2))
	else
		if left(k_return, 1) = "3" then
			messagebox("Registrazione dati : problemi nella 'Commit' !!", &
				"Provare chiudere e ripetere le operazioni eseguite")
		end if
	end if
end if


return k_return

end function

protected function string dati_modif (string k_titolo);//
//--- Controllo se ci sono state modifiche di dati sui DW
//--- Ritorna: 0=agg.non necessario; 1=fare aggiornamento; 
//---          2=non fare agg.; 3=annulla operazione
//
string k_return="0 "
int k_msg
string k_key


	dw_dett_0.accepttext()

//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()

	if cb_aggiorna.enabled = true then
		
		if dw_dett_0.getnextmodified ( 0, primary!) > 0 or &
			dw_dett_0.getnextmodified ( 0, filter!) > 0 then		

	
			if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
				k_titolo = "Aggiorna Archivio"
			end if
	
			k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
								question!, yesnocancel!, 1) 
		
			k_return = string(k_msg, "0")
			
		end if
	end if

return k_return
end function

protected subroutine pulizia_righe ();//
//--- Togliere le righe che non intaressano
//
//--- Standard modificabile
//
dw_dett_0.accepttext()
dw_lista_0.accepttext()


end subroutine

public subroutine ordina_dw ();//
//=== Possibilita' di filtrare su una colonna i valori richiesti
string k_x
datawindow kdw_1


	kdw_1 = dw_lista_0

	if kdw_1.rowcount() > 1 then
	
		setnull(k_x)
		kdw_1.setsort(k_x)
		kdw_1.SetRedraw (false)
		kdw_1.sort()
		kdw_1.SetRedraw (true)
		kdw_1.setfocus()
		
		attiva_tasti()
	end if


end subroutine

protected function string aggiorna_dati ();//
string k_return

	dw_dett_0.accepttext()
	
	k_return = super::aggiorna_dati()
	
return k_return

end function

protected subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case left(k_par_in, 2) 

	case kkg_flag_richiesta_refresh		//Aggiorna Liste
		leggi_liste()

	case kkg_flag_richiesta_inserimento		//richiesta inserimento
		if cb_inserisci.enabled = true then
			cb_inserisci.postevent(clicked!)
		end if

	case kkg_flag_richiesta_cancellazione		//richiesta cancellazione
		if cb_cancella.enabled = true then
			cb_cancella.postevent(clicked!)
		end if

	case kkg_flag_richiesta_conferma		//richiesta conferma
		if cb_aggiorna.enabled = true then
			cb_aggiorna.postevent(clicked!)
		end if

	case kkg_flag_richiesta_visualizzazione		//richiesta visual
		if cb_visualizza.enabled = true then
			cb_visualizza.postevent(clicked!)
		end if

	case kkg_flag_richiesta_modifica		//richiesta modif
		if cb_modifica.enabled = true then
			cb_modifica.postevent(clicked!)
		end if

	case kkg_flag_richiesta_filtro		//richiesta di filtro sui campi (filter)
		filtro_dw()

	case kkg_flag_richiesta_sort		//Sort personalizzato
		ordina_dw()

	case "f1"		//Cerca.....
		cerca_in_lista(1)

	case "f2"		//Continua ricerca....
		cb_cerca_1.postevent(clicked!)

	case else
		super::smista_funz(k_par_in)

end choose


//return k_return

end subroutine

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza, k_key
long k_riga_getrow
int k_importa=0


//--- operazioni necessarie di inizio programma (come check sicurezza)
	super::inizializza_lista()

//=== salvo il nr. di riga su cui ero
	k_riga_getrow = dw_lista_0.getrow()
	if k_riga_getrow <= 0 then
		k_riga_getrow = 1
	end if

//=== Parametri passati con il WITHPARM (st_parametri.text)
//=== Inizializzazione tasti e retrieve della Lista
	if trim(ki_st_open_w.flag_where) = "wh" then
//=== Legge le righe del dw salvate l'ultima volta (importfile) e mi posiziono
		if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta 
			k_importa = kuf1_data_base.dw_importfile(trim(ki_st_open_w.flag_where), dw_lista_0)
		end if
		if k_importa <= 0 then // Nessuna importazione eseguita
			k_inizializza = inizializza_1()  //dalla FROM della Select personalizzata
		end if
//=== Se avevo specificato qualcosa nella ricerca tento il posizionamento
		if len(trim(sle_cerca.text)) > 0 then
			cb_cerca_1.postevent(clicked!)
		end if
	else  
		
//=== Percorso piu' frequente dell'inizializzazione =====================================

//=== se ho fatto una selezione su un determinato cliente (o rag soc che si assomigl.)
		k_key = trim(ki_st_open_w.key1)
		if isnull(k_key) or len(trim(k_key)) = 0 then
			k_key = sle_cerca.text 
			if isnull(k_key) then
				k_key = ""
			end if
		end if

		ki_st_open_w.key1 = trim(k_key)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

			k_key = trim(ki_st_open_w.key1) + trim(ki_st_open_w.key2) + trim(ki_st_open_w.key3) &
			 		  + trim(ki_st_open_w.key4) + trim(ki_st_open_w.key5)
			k_importa = kuf1_data_base.dw_importfile(k_key, dw_lista_0)

		end if
		
		if k_importa <= 0 then // Nessuna importazione eseguita

			k_inizializza = inizializza() //Reimposta i tasti e fa la retrieve di lista

		end if

	end if
	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if left(k_inizializza,1) <> "2" then
		if left(k_inizializza,1) <> "1" then
			attiva_tasti()
		end if
//=== posizionamento sulla riga su cui ero
		if dw_lista_0.getrow() = 0 then
			if k_riga_getrow > dw_lista_0.rowcount() then
				k_riga_getrow = dw_lista_0.rowcount()
			end if
		else
			k_riga_getrow = dw_lista_0.getrow()
		end if

		dw_lista_0.setrow(k_riga_getrow)
		dw_lista_0.selectrow(0, false)
		if k_riga_getrow > 1 then
			dw_lista_0.selectrow(k_riga_getrow, true)
		end if
		dw_lista_0.scrolltorow(k_riga_getrow)
	
		
//=== 
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

	else
		cb_ritorna.postevent(clicked!)
	end if
	
	attiva_tasti()
	

//=== Disattivo flag di 'prima volta'
	if ki_st_open_w.flag_primo_giro = 'S' then
		ki_st_open_w.flag_primo_giro = ''
	end if



end subroutine
event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu



//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag
		this.tag = " "

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_lib_1.text = "Cerca"
		m_menu.m_lib_1.visible = true
			

		m_menu.m_inserisci.visible = cb_inserisci.enabled
		m_menu.m_modifica.visible = cb_modifica.enabled
		m_menu.m_t_modifica.visible = cb_modifica.enabled
		m_menu.m_cancella.visible = cb_cancella.enabled
		m_menu.m_t_cancella.visible = cb_cancella.enabled
		m_menu.m_visualizza.visible = cb_visualizza.enabled

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true
		if dw_lista_0.rowcount() > 0 or dw_filtro_0.rowcount() > 0 then
			m_menu.m_filtro.visible = true
			m_menu.m_t_filtro.visible = false
		end if
		m_menu.m_stampa.visible = st_stampa.enabled
		m_menu.m_t_stampa.visible = st_stampa.enabled
		m_menu.m_conferma.visible = cb_aggiorna.enabled
		m_menu.m_ritorna.visible = true

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		


end event

event closequery;call super::closequery;//
//=== Controllo prima della chiusura della Windows
//=== Esporta DW
//
int k_errore
string k_key


	cb_ritorna.enabled = false

//if keydown(keyescape!) = false then

//=== Verifico DATI_MODIF solo se tasti di modif. abilitati
	if cb_aggiorna.enabled or cb_inserisci.enabled or cb_cancella.enabled then
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
		k_errore = ritorna(trim(this.title))

		if k_errore = 1 or k_errore = 2 then
			attiva_tasti()
			return 1       
		end if

	end if


//=== Salva le righe del dw (saveas)
	k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
			  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
			  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
	kuf1_data_base.dw_saveas(trim(k_key), dw_lista_0)
	

end event

event open;call super::open;//

//=== Mostra Finestra : max=61472; min=61488; normal=61728
//send(handle(this), 274, 61728, 0)

//=== set transobject per il datawindows di dettaglio
dw_dett_0.settransobject ( sqlca )
dw_lista_0.settransobject ( sqlca )

//=== Posiziona window all'interno MDI 
//if trim(ki_st_open_w.flag_adatta_win) = kk_adatta_win then
//	this.width = w_main.width - 100
//	this.height = w_main.height * 0.8
//end if
//if w_main.width > this.width then
//	this.x = (w_main.width - this.width) / 3
//else
//	this.x = 1
//end if
//if w_main.height > this.height then
//	this.y = (w_main.height - this.height) / 6
//else
//	this.y = 1
//end if

//=== Imposta il titolo della wind. nella dw x la desc. in una eventuale stampa
dw_lista_0.tag = this.title

if trim(ki_st_open_w.flag_leggi_dw) = "S" then
//=== Retrive solo sulle righe richieste
	cb_cerca_1.text = "&Ok"
	post cerca_in_lista(integer(trim(ki_st_open_w.key1)))
else
	sle_cerca.text = ""
	post inizializza_lista()
end if

//dw_dett_0.setrowfocusindicator ( Hand! )


end event

on w_g_tab0.create
int iCurrent
call super::create
this.cb_visualizza=create cb_visualizza
this.cb_modifica=create cb_modifica
this.cb_aggiorna=create cb_aggiorna
this.cb_cancella=create cb_cancella
this.cb_inserisci=create cb_inserisci
this.cb_ritorna=create cb_ritorna
this.sle_cerca=create sle_cerca
this.cb_cerca_1=create cb_cerca_1
this.dw_lista_0=create dw_lista_0
this.dw_filtro_0=create dw_filtro_0
this.dw_dett_0=create dw_dett_0
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_visualizza
this.Control[iCurrent+2]=this.cb_modifica
this.Control[iCurrent+3]=this.cb_aggiorna
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_inserisci
this.Control[iCurrent+6]=this.cb_ritorna
this.Control[iCurrent+7]=this.sle_cerca
this.Control[iCurrent+8]=this.cb_cerca_1
this.Control[iCurrent+9]=this.dw_lista_0
this.Control[iCurrent+10]=this.dw_filtro_0
this.Control[iCurrent+11]=this.dw_dett_0
end on

on w_g_tab0.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_visualizza)
destroy(this.cb_modifica)
destroy(this.cb_aggiorna)
destroy(this.cb_cancella)
destroy(this.cb_inserisci)
destroy(this.cb_ritorna)
destroy(this.sle_cerca)
destroy(this.cb_cerca_1)
destroy(this.dw_lista_0)
destroy(this.dw_filtro_0)
destroy(this.dw_dett_0)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto

//--- chiudo finestra se sono in visualizzazione
//	if key = keyescape! and ki_st_open_w.flag_modalita = "vi" then
//		smista_funz("ri")
//	end if
//

end event

event resize;//---
long k_dett_height=0

	
	if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN then

		this.setredraw(false)

		if dw_lista_0.visible = true and dw_dett_0.visible = true then
         dw_dett_0.height = this.height / 2 - this.height / 20
         dw_lista_0.height = dw_dett_0.height
			dw_lista_0.width = this.width - 80
			dw_dett_0.width = dw_lista_0.width

		else
			
			if dw_dett_0.visible = true then
				if cb_ritorna.visible = true then
					dw_dett_0.width = this.width - cb_ritorna.width * 1.5 - 150
				else
					dw_dett_0.width = this.width - 80
				end if
	
				k_dett_height = this.height - 150
			else
				k_dett_height = 1
			end if
			dw_dett_0.height = k_dett_height
			
			if dw_lista_0.visible = true then
//=== Dimensione dw nella window 
				dw_lista_0.width = this.width - 80
				if cb_ritorna.visible = true then
					dw_lista_0.height = this.height - k_dett_height - cb_ritorna.height * 1.5 - 150
					cb_ritorna.y = this.height - cb_ritorna.height * 1.5 - 75
					cb_aggiorna.y = this.height - cb_aggiorna.height * 1.5 - 75
					cb_cancella.y = this.height - cb_cancella.height * 1.5 - 75
					cb_inserisci.y = this.height - cb_inserisci.height * 1.5 - 75
					cb_ritorna.x = this.width - cb_ritorna.width - 50
					cb_cancella.x = cb_ritorna.x - cb_cancella.width - 50
					cb_aggiorna.x = cb_cancella.x - cb_aggiorna.width - 50
					cb_inserisci.x = cb_aggiorna.x - cb_inserisci.width - 50
				else
					dw_lista_0.height = this.height - 150 - k_dett_height
				end if
			end if
	
		end if

		if dw_dett_0.visible = true then
			k_dett_height = dw_dett_0.height
		else
			k_dett_height = 0
		end if
		
//=== Posiziona dw nella window 
		if dw_lista_0.visible = true then
			dw_lista_0.x = (this.width - dw_lista_0.width) / 4
			dw_lista_0.y = (this.height - dw_lista_0.height - k_dett_height) / 7
		end if
		
		if dw_dett_0.visible = true then
//=== Posiziona dw nella window 
			if dw_lista_0.visible = true then
				dw_dett_0.x = (this.width - dw_lista_0.width) / 4
				dw_dett_0.y = dw_dett_0.height + this.height / 40
			else
				dw_dett_0.x = 1 //(this.width - dw_dett_0.width) / 4
				dw_dett_0.y = 1 //(this.height- dw_lista_0.height - k_dett_height) / 7
			end if
		end if
	
		this.setredraw(true)
		
	end if
//end if




end event

event activate;call super::activate;//

   this.triggerevent ( resize! )

end event

type st_stampa from w_g_tab`st_stampa within w_g_tab0
end type

type st_ritorna from w_g_tab`st_ritorna within w_g_tab0
integer x = 2514
integer y = 1128
integer width = 334
end type

event st_ritorna::clicked;call super::clicked;//
close(parent)
end event

type cb_visualizza from commandbutton within w_g_tab0
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
//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
string k_key
string k_errore="0 "


//--- controlla se utente autorizzato alla funzione in atto
if sicurezza() then

	
	//=== Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
	if dw_dett_0.enabled = false then
		dw_dett_0.enabled = true
	else
	//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
		if left(dati_modif(trim(parent.title)), 1) = "1" then //Fare gli aggiornamenti
	
	//=== Controllo congruenza dei dati caricati e Aggiornamento  
	//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
	//===                : 2=errore non grave dati aggiornati;
	//===			         : 3=
	//===      il resto della stringa contiene la descrizione dell'errore   
			k_errore = aggiorna_dati()
	
		end if
	end if
	
	
	if left(k_errore, 1) = "0" then

		dw_dett_0.reset()

		if dw_lista_0.getrow() > 0 then
			
			if visualizza() > 0 then

				attiva_tasti()
	
				dw_dett_0.setfocus()		

			else

				messagebox("Operazione Fallita", "Mi spiace, ma dati non trovati in archivio~n~r" +&
							"Provare a riaggiornare la lista scegliendo da menu :~n~r" + &
							"'Finestra -> Aggiorna lista'")

			end if

			
		end if

	end if
end if	

end event

type cb_modifica from commandbutton within w_g_tab0
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
//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
string k_key
string k_errore="0 "


//--- controlla se utente autorizzato alla funzione in atto
if sicurezza() then
	
	
	//=== Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
	if dw_dett_0.enabled = false then
		dw_dett_0.enabled = true
	else
	//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
		if left(dati_modif(trim(parent.title)), 1) = "1" then //Fare gli aggiornamenti
	
	//=== Controllo congruenza dei dati caricati e Aggiornamento  
	//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
	//===                : 2=errore non grave dati aggiornati;
	//===			         : 3=
	//===      il resto della stringa contiene la descrizione dell'errore   
			k_errore = aggiorna_dati()
	
		end if
	end if


	if left(k_errore, 1) = "0" then

		dw_dett_0.reset()

		if dw_lista_0.getrow() > 0 then
			
			if modifica() > 0 then

				attiva_tasti()
	
				dw_dett_0.setfocus()		

			else

				messagebox("Operazione Fallita", "Mi spiace, ma dati non trovati in archivio~n~r" +&
							"Provare a riaggiornare la lista scegliendo da menu :~n~r" + &
							"'Finestra -> Aggiorna lista'")

			end if

			
		end if

	end if

end if

end event

type cb_aggiorna from commandbutton within w_g_tab0
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
string k_aggiorna_dati = "0"


//=== Aggiornamento dei dati inseriti/modificati
k_aggiorna_dati = trim(aggiorna_dati())

if left(k_aggiorna_dati, 1) = "0" then

	dw_dett_0.reset()
	dw_lista_0.setfocus()
	
	attiva_tasti()
	
end if

//	messagebox("Operazione eseguita", "Dati aggiornati correttamente")

end event

type cb_cancella from commandbutton within w_g_tab0
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
//--- controlla se utente autorizzato alla funzione in atto
if sicurezza() then

	cancella()
end if
end event

type cb_inserisci from commandbutton within w_g_tab0
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
//=== 
string k_errore


dw_dett_0.accepttext()

//--- controlla se utente autorizzato alla funzione in atto
if sicurezza() then

	
	k_errore = left(dati_modif(trim(parent.title)), 1)
	
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

end if
end event

type cb_ritorna from commandbutton within w_g_tab0
integer x = 2528
integer y = 1036
integer width = 329
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ritorna"
end type

event clicked;//
close(parent)
end event

type sle_cerca from singlelineedit within w_g_tab0
boolean visible = false
integer x = 1070
integer y = 1084
integer width = 1161
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15780518
string text = "pppp"
textcase textcase = upper!
integer limit = 40
end type

event getfocus;//
	this.selecttext( 1, len(this.text))
end event

type cb_cerca_1 from commandbutton within w_g_tab0
boolean visible = false
integer x = 855
integer y = 1080
integer width = 215
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Trova..."
end type

event clicked;//
//=== Posiziono sulla anagrafica specificata
long k_riga, k_inizio_find
string k_campo, k_tipo_campo
string k_find, k_nome_colonna
pointer oldpointer  // Declares a pointer variable
GraphicObject k_which_control


//sle_cerca.visible = false
//cb_cerca_1.visible = false

k_campo = upper(trim(ki_dw_cerca.describe(&
	ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name") + "_t.text")))


//=== Se ho scritto qualcosa e se e' diverso dal nome della testata della col.
if len(trim(sle_cerca.text)) > 0 and sle_cerca.text <> k_campo	then
	
//=== Se NON sono in ricerca lancio INIZIALIZZA()
	if this.text = "Trova..." then 

//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

		k_inizio_find = ki_dw_cerca.getrow()
		
		k_nome_colonna = ki_dw_cerca.describe("#" + trim(string(cb_cerca_1.tag)) + ".name")
//					
      k_tipo_campo = ki_dw_cerca.Describe(k_nome_colonna+".Coltype")
		choose case upper(left(k_tipo_campo,2))
					
			case 'CH'
				k_find =	"upper("+k_nome_colonna + ") like '" + &
		   	    trim(sle_cerca.text) + "%'"
			case else
				k_find =	k_nome_colonna + " >= " + &
		   	    trim(sle_cerca.text) 
				
		end choose
	
		k_inizio_find++

		k_riga = ki_dw_cerca.Find( k_find , k_inizio_find,  &
		       ki_dw_cerca.RowCount( ))
	
		if k_riga <= 0 and k_inizio_find > 1 then //allora ricerco ancora dalla prima riga
			k_riga = ki_dw_cerca.Find( k_find , 1, k_inizio_find )
		end if

		if k_riga <= 0 then
			SetPointer(oldpointer)
			messagebox("Ricerca fallita", "Dato richiesto non trovato in lista")
		else
			ki_dw_cerca.SelectRow(0, FALSE)
			ki_dw_cerca.scrolltorow(k_riga)
			ki_dw_cerca.selectrow(k_riga, true)
			ki_dw_cerca.setrow(k_riga)

		end if

		SetPointer(oldpointer)

	end if
else
	
	sle_cerca.text = ""
	
end if

sle_cerca.visible = false
cb_cerca_1.visible = false

//=== Se NON sono in ricerca lancio INIZIALIZZA()
if this.text <> "Trova..." then 
	inizializza_lista()
end if

this.text = "Trova..."

//					
//					choose case upper(left(ki_dw_cerca.Describe(k_campo+".Coltype"),2))
//					
//						case 'CH'
//							if pos(k_filtro, "%", 1) > 0 then
//								if len(k_filtro_like) = 0 then
//									k_filtro_like = k_campo + " like '" + k_filtro + "'"
//									k_filtro = ""
//								else
//									k_filtro = "ERRORE"
//								end if
//							else	
//								k_filtro = "'" + k_filtro + "'"
//							end if
//					
//						case 'DA'
//							k_filtro = "'"+string(date(k_filtro), "dd/mm/yyyy")+"'"
//
//					end choose
//					
//
end event

type dw_lista_0 from uo_d_std_1 within w_g_tab0
integer x = 14
integer y = 32
integer width = 2793
integer height = 440
integer taborder = 110
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event u_doppio_click;call super::u_doppio_click;//
//--- comportamento di default
//
if cb_visualizza.enabled = true then 
	cb_visualizza.postevent(clicked!)
end if

end event

type dw_filtro_0 from datawindow within w_g_tab0
boolean visible = false
integer x = 366
integer width = 1902
integer height = 736
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "Filro sui dati"
string dataobject = "d_filtro_0"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//
string k_campo="", k_segno="", k_filtro="", k_filtro_s=""
string k_filtro_like="", k_err_filtro="", k_or_and="", k_operat
int k_ctr, k_rc


	this.accepttext()

	if dwo.name = "k_ritorna" then
		
//		this.modify("k_ritorna.visible=0")
////		this.modify("k_ritorna_giu.visible=1")
//		this.modify("k_ritorna.visible=1")
//		
		dw_lista_0.setfocus()
		this.visible = false
		
	else
		if dwo.name = "k_via" and this.rowcount() > 0 then
//			this.modify("k_via.visible=0")
						
			for k_ctr = 1 to 50

				if k_ctr > 1 then
					k_ctr = k_ctr - 1
					k_campo = trim(this.getitemstring(k_ctr,"k_campo"))
					k_segno = trim(this.getitemstring(k_ctr,"k_segno"))
					k_filtro = trim(this.getitemstring(k_ctr,"k_filtro"))
					if k_ctr > 1 then
						k_or_and = this.getitemstring(k_ctr - 1,"k_or_and")
						if len(trim(k_or_and)) > 0 then
							k_or_and = k_or_and + " "
						else
							k_or_and = "E"
							this.setitem(k_ctr - 1,"k_or_and", k_or_and)
						end if
					else
						k_or_and = " "
					end if
					if trim(k_or_and) = "O" then
						k_operat = " OR "
					else
						if trim(k_or_and) = "E" then
							k_operat = " AND "
						else
							k_operat = " "
						end if
					end if
					
					k_ctr++
				end if
				
				if len(trim(k_campo)) > 0 and len(trim(k_segno)) >0 and len(trim(k_filtro)) > 0 then
					
					choose case upper(left(dw_lista_0.Describe(k_campo+".Coltype"),2))
					
						case 'CH'
							if pos(k_filtro, "%", 1) > 0 then
								if len(k_filtro_like) = 0 then
									k_filtro_like = trim(k_campo) + " like '" + trim(k_filtro) + "'"
									k_filtro = ""
								else
									k_filtro = "ERRORE"
								end if
							else	
								k_filtro = "'" + k_filtro + "'"
							end if
					
						case 'DA'
							k_filtro = "date('"+string(date(k_filtro), "dd/mm/yyyy")+"')"

					end choose
					
					if len(k_filtro) > 0 then 
						if len(k_filtro_s) = 0 then
							k_filtro_s = k_campo + " " + k_segno + " " + k_filtro
						else
							k_filtro_s = k_filtro_s + k_operat + &
									 k_campo + " " + k_segno + " " + k_filtro
						end if
					end if
				end if			
		
			next

			if len(k_filtro_like) > 0 then 
				if len(k_filtro_s) > 0 then
					k_err_filtro = "Con il carattere %  e' permessa solo una riga,~n~r" + &
									"gli altri filtri verranno esclusi "
				end if	
				k_filtro_s = k_filtro_like 
			end if

//			this.modify("k_via.visible=1")

//			if len(k_filtro_s) > 0 then

				k_rc=dw_lista_0.setfilter("") // rimuovo vecchi filtri

				if dw_lista_0.setfilter(k_filtro_s) < 1 then
					messagebox("Operazione NON eseguita", &
						"Dati del filtro incongruenti, ~n~r" + &
						"Controlla i Valori e riprova")
				else
					k_rc=dw_lista_0.filter()
					k_rc=dw_lista_0.GroupCalc()
					if len (trim(k_err_filtro)) > 0 then
						messagebox("Filtro eseguito solo Parzialmente", &
						 			k_err_filtro)
						dw_filtro_0.setfocus()
					else
						dw_lista_0.setfocus()
						this.visible = false
					end if						
				end if
//			end if
		end if
		
	end if
		
end event

type dw_dett_0 from uo_d_std_1 within w_g_tab0
integer x = 23
integer y = 512
integer width = 2446
integer height = 684
integer taborder = 40
borderstyle borderstyle = stylebox!
end type

event ue_dwnkey;call super::ue_dwnkey;//
//nulla
end event

