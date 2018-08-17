$PBExportHeader$w_pl_barcode_l.srw
forward
global type w_pl_barcode_l from w_g_tab0
end type
end forward

global type w_pl_barcode_l from w_g_tab0
integer width = 3072
integer height = 1444
string title = "Piani di Lavoro"
boolean ki_toolbar_window_presente = true
end type
global w_pl_barcode_l w_pl_barcode_l

forward prototypes
private function string leggi_liste ()
protected subroutine forma_elenco ()
private function string cancella ()
private function string inizializza ()
private subroutine open_notepad_documento (string k_file) throws uo_exception
protected subroutine open_start_window ()
protected subroutine attiva_tasti_0 ()
end prototypes

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
long k_riga


	k_riga = dw_lista_0.getrow()
	inizializza()
	
	if k_riga > dw_lista_0.rowcount() then
		k_riga = dw_lista_0.rowcount() 
	end if
	if k_riga > 0 then
		dw_lista_0.scrolltorow(k_riga)
		dw_lista_0.setrow(k_riga)
		dw_lista_0.selectrow(0 , false)
		dw_lista_0.selectrow(k_riga , false)
	end if
	
	attiva_tasti( )

	
return k_return


end function

protected subroutine forma_elenco ();
end subroutine

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
long k_codice
date k_data 
string k_note
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode  kuf1_pl_barcode  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_codice = dw_lista_0.getitemnumber(k_riga, "codice")
	k_note = dw_lista_0.getitemstring(k_riga, "note_1")
	k_data = dw_lista_0.getitemdate(k_riga, "data")

	if isnull(k_note) = true or LenA(trim(k_note)) = 0 then
		k_note = "nessuna nota" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Piano di Lavorazione", "Sei sicuro di voler Cancellare il P.L.~n~r" &
	         + "codice:" + string(k_codice, "#####") + " del " + string(k_data, "d/m/yy") &
	         + " note:" + trim(k_note), &
				question!, yesno!, 2) = 1 then
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_pl_barcode = create kuf_pl_barcode
		
		kst_tab_pl_barcode.codice = k_codice
		kst_tab_pl_barcode.data = k_data
		kst_tab_pl_barcode.note_1 = k_note
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_pl_barcode.tb_delete(kst_tab_pl_barcode) 
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
		destroy kuf1_pl_barcode

	else
		messagebox("Elimina Piano di Lavorazione", "Operazione Annullata !!")

	end if
end if

return " "
end function

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
string k_operazione, k_key
date k_data
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- prendo la chiave
	if isdate(trim(ki_st_open_w.key1)) then
		k_data = date(trim(ki_st_open_w.key1))
	else
		k_data = date(0)
	end if
	k_operazione = trim(ki_st_open_w.key2)    //--- tipo mandante/ricevente/fatturato
	if isnull(k_operazione) then
		k_operazione = "tutti"
	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_data, k_operazione) < 1 then
			k_return = "1Nessun P.L. presente "

			SetPointer(oldpointer)
			messagebox("Lista Piani di Lavorazione", &
					"Elenco vuoto per la richiesta fatta" &
					+ "  (dalla data del " + string(k_data, "dd/mm/yyyy") + " - " + k_operazione + ")" )

		end if		
	end if


return k_return



end function

private subroutine open_notepad_documento (string k_file) throws uo_exception;//
kuf_ole kuf1_ole
st_esito kst_esito
uo_exception kuo_exception


	if LenA(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
		if kst_esito.esito <> "0" then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_generico)
			kuo_exception.setmessage("Impossibile aprire il Documento" + trim(k_file)+ "~n~r" +trim(kst_esito.sqlerrtext) )
			throw kuo_exception
		end if
	else
	
		kuo_exception = create uo_exception
		kuo_exception.set_tipo(kuo_exception.KK_st_uo_exception_tipo_not_fnd)
		kuo_exception.setmessage("Nessun Documento Associato a questo P.L.!" )
		throw kuo_exception
		
	end if
	

end subroutine

protected subroutine open_start_window ();//
end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_visualizza.enabled = true

//cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.getrow ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true

end if

//=== Nr righe ne DW lista
if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	cb_cancella.enabled = true
//	cb_aggiorna.enabled = true
end if
            


end subroutine

on w_pl_barcode_l.create
call super::create
end on

on w_pl_barcode_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_pl_barcode_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_pl_barcode_l
boolean enabled = true
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_pl_barcode_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_l
integer x = 37
integer y = 1112
integer width = 270
integer height = 100
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_l
integer x = 850
integer y = 1176
integer taborder = 30
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemnumber( k_riga, "codice" ) 
		
	if k_codice  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = "pl_barcode"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_codice, "0000000000")
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

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_l
integer x = 1737
integer y = 1144
integer height = 96
integer taborder = 90
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemnumber( k_riga, "codice" ) 
		
	if k_codice  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = "pl_barcode"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_codice, "0000000000")
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_l
integer x = 329
integer y = 1140
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_l
integer x = 2121
integer y = 1144
integer height = 96
integer taborder = 100
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_l
integer x = 1349
integer y = 1152
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

		K_st_open_w.id_programma = "pl_barcode"
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
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_l
integer x = 2030
integer y = 1032
integer width = 489
integer height = 184
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_pl_barcode_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_l
integer y = 0
integer width = 2807
integer height = 672
string dataobject = "d_pl_barcode_l"
end type

event dw_lista_0::clicked;call super::clicked;//
//=== Premuto Link nella DW ?
//
pointer kpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
//=== Se volessi riprist. il vecchio puntatore : SetPointer(kpointer)
kpointer = SetPointer(HourGlass!)


try
		

	if dwo.name = "k_path_file_pilota" then
	
		open_notepad_documento(this.getitemstring(row, "path_file_pilota"))
	
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try


//=== Riprist. il vecchio puntatore :
SetPointer(kpointer)



end event

type dw_guida from w_g_tab0`dw_guida within w_pl_barcode_l
end type

