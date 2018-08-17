$PBExportHeader$w_certif_l.srw
forward
global type w_certif_l from w_g_tab0
end type
end forward

global type w_certif_l from w_g_tab0
integer width = 3072
integer height = 1444
string title = "Attestati di Trattamento"
boolean ki_esponi_msg_dati_modificati = false
end type
global w_certif_l w_certif_l

forward prototypes
private function string leggi_liste ()
protected subroutine forma_elenco ()
private function string cancella ()
protected function string inizializza ()
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
	k_codice = dw_lista_0.getitemnumber(k_riga, "id")
	k_note = dw_lista_0.getitemstring(k_riga, "note")
	k_data = dw_lista_0.getitemdate(k_riga, "certif_data")

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

protected function string inizializza ();//
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
date k_data_da, k_data_a
int k_importa = 0, k_anno
st_tab_certif kst_tab_certif
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- prendo la chiave
//--- prendo periodo di estrazione
	if isdate(trim(ki_st_open_w.key1)) then
		k_data_da = date(trim(ki_st_open_w.key1))
	end if
	if isdate(trim(ki_st_open_w.key2)) then
		k_data_a = date(trim(ki_st_open_w.key2))
	end if
//--- prendo numero certificato
	if integer(trim(ki_st_open_w.key3)) > 0 then
		kst_tab_certif.num_certif = integer(trim(ki_st_open_w.key3))
	else
		kst_tab_certif.num_certif = 0
	end if
//--- prendo ricevente
	if integer(trim(ki_st_open_w.key4)) > 0 then
		kst_tab_certif.clie_2 = integer(trim(ki_st_open_w.key4))
	else
		kst_tab_certif.clie_2 = 0
	end if
//--- prendo id meca
	if integer(trim(ki_st_open_w.key5)) > 0 then
		kst_tab_certif.id_meca = integer(trim(ki_st_open_w.key5))
	else
		kst_tab_certif.id_meca = 0
	end if



//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa > 0 then // Mostra elenco salvato l'ultima volta
	
		ki_win_titolo_orig = ki_st_open_w.window_title //+ " per aggiornare l'elenco premi '" + kkg_key_funzione_aggiorna + "' "

	else // Nessuna importazione eseguita
		
		ki_win_titolo_orig = ki_st_open_w.window_title + " periodo dal " + string(k_data_da, "dd.mm.yy") + " al " + string(k_data_a, "dd.mm.yy")
		this.title = ki_win_titolo_orig

		if dw_lista_0.retrieve(k_data_da &
		                       ,k_data_a &
		                       ,kst_tab_certif.num_certif &
		                       ,kst_tab_certif.clie_2 &
		                       ,kst_tab_certif.id_meca &
									  ) < 1 then
			k_return = "1Nessun Attestato presente "

			SetPointer(oldpointer)
			messagebox("Lista Attestato", &
					"Nesun Codice Trovato per la richiesta fatta" &
					+ "  (chiave periodo: " + string(k_data_da) + " - " + string(k_data_a) &
					+ "; nr.Attestato: " + string(kst_tab_certif.num_certif) &
					+ "; Ricevente: " + string(kst_tab_certif.clie_2) &
					+ "; id Riferimento: " + string(kst_tab_certif.id_meca) &
					+ " - " + k_operazione + ")" )

		end if		
	end if

//

return k_return



end function

on w_certif_l.create
call super::create
end on

on w_certif_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_certif_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_certif_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_certif_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_certif_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_certif_l
integer x = 37
integer y = 1112
integer width = 270
integer height = 100
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_certif_l
integer x = 850
integer y = 1176
integer taborder = 30
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_codice
st_tab_certif kst_tab_certif
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	kst_tab_certif.num_certif = dw_lista_0.getitemnumber( k_riga, "num_certif" ) 
		
	if kst_tab_certif.num_certif  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = "attestati"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(kst_tab_certif.num_certif, "0000000000")
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

type cb_modifica from w_g_tab0`cb_modifica within w_certif_l
integer x = 1737
integer y = 1144
integer height = 96
integer taborder = 90
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_codice
st_tab_certif kst_tab_certif
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	kst_tab_certif.num_certif = dw_lista_0.getitemnumber( k_riga, "num_certif" ) 
		
	if kst_tab_certif.num_certif  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = "attestati"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(kst_tab_certif.num_certif, "0000000000")
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_certif_l
integer x = 329
integer y = 1140
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_certif_l
integer x = 2121
integer y = 1144
integer height = 96
integer taborder = 100
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_certif_l
integer x = 1349
integer y = 1152
integer height = 96
integer taborder = 80
boolean enabled = false
end type

event cb_inserisci::clicked;////
//st_open_w k_st_open_w
//kuf_menu_window kuf1_menu_window
//
//
//		attiva_tasti()
////
////=== Parametri : 
////=== struttura st_open_w
////=== dati particolare programma
////
////=== Si potrebbero passare:
////=== key1=codice cli;
//
//		K_st_open_w.id_programma = "pl_barcode"
//		K_st_open_w.flag_primo_giro = "S"
//		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
//		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
//		K_st_open_w.flag_leggi_dw = "N"
//		K_st_open_w.flag_cerca_in_lista = " "
//		K_st_open_w.key1 = "0000000000"
//		K_st_open_w.key2 = " "
//		K_st_open_w.key3 = " "
//		K_st_open_w.key4 = " "
//		K_st_open_w.flag_where = " "
//		
//		kuf1_menu_window = create kuf_menu_window 
//		kuf1_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
//
end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_certif_l
integer x = 2057
integer y = 800
integer width = 777
integer height = 268
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_certif_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_certif_l
integer x = 32
integer y = 16
integer width = 2807
integer height = 672
string dataobject = "d_certif_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_certif_l
end type

