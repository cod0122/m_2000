$PBExportHeader$w_prod_l.srw
forward
global type w_prod_l from w_g_tab0
end type
end forward

global type w_prod_l from w_g_tab0
integer width = 3163
integer height = 1732
string title = "Lista Articoli"
boolean ki_toolbar_window_presente = true
end type
global w_prod_l w_prod_l

type variables
private string ki_mostra_nascondi_in_lista = "S" 
private string ki_win_titolo_orig_save = ""
 
end variables

forward prototypes
private function string inizializza ()
private function string leggi_liste ()
private function string cancella ()
private subroutine stampa ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista (string a_codice)
protected subroutine attiva_tasti_0 ()
end prototypes

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
string k_codice, k_key
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if

	
	if k_importa <= 0 then // Nessuna importazione eseguita

		k_codice = trim(ki_st_open_w.key1)
		k_codice += "%"

		if u_retrieve_dw_lista(k_codice) < 1 then
//		if dw_lista_0.retrieve(k_codice) < 1 then
			k_return = "1Anagrafiche Non trovate "

			SetPointer(oldpointer)
			messagebox("Lista Anagrafiche Vuota", &
					"Nesun Codice Trovato per la richiesta fatta ( '" + trim(k_codice) + "' ) ")
		end if		

	end if

	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//		ki_mostra_nascondi_in_lista = "S"
		mostra_nascondi_in_lista()
	end if


return k_return



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

private function string cancella ();//
string k_des
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_prodotti  kuf1_prodotti  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_des = dw_lista_0.getitemstring(k_riga, "des")
	k_codice = dw_lista_0.getitemstring(k_riga, "codice")

	if isnull(k_des) = true or trim(k_des) = "" then
		k_des = "Anagrafica Senza Descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Anagrafica", "Sei sicuro di voler Cancellare : ~n~r" + k_des, &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_prodotti = create kuf_prodotti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_prodotti.tb_delete(k_codice) 
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
		destroy kuf1_prodotti

	else
		messagebox("Elimina Articolo", "Operazione Annullata !!")

	end if
end if

return "0"

end function

private subroutine stampa ();//
long k_num_riga, k_riga
string k_stampa, k_des, k_tipo
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable
datawindowchild kdwc_iva, kdwc_gruppo

 

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

	
//=== Posiziono la dw per farla vedere
	dw_dett_0.height = dw_lista_0.height
	dw_dett_0.width = dw_lista_0.width
	dw_dett_0.x = dw_lista_0.x
	dw_dett_0.y = dw_lista_0.y

	dw_dett_0.dataobject = "d_prod_l"
	k_stampa = "Anagrafiche Prodotti"

	k_des = trim(ki_st_open_w.key1) + "%"


	dw_dett_0.settransobject(sqlca)

//--- Attivo dw archivio IVA
	dw_dett_0.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve()
		kdwc_iva.insertrow(1)
	end if

//--- Attivo dw archivio GRUPPI
	dw_dett_0.getchild("gruppo", kdwc_gruppo)

	kdwc_gruppo.settransobject(sqlca)

	if kdwc_gruppo.rowcount() = 0 then
		kdwc_gruppo.retrieve(0)
		kdwc_gruppo.insertrow(1)
	end if

	dw_lista_0.rowscopy( 1, dw_lista_0.rowcount( ) , primary!, dw_dett_0, 1, primary!)	

	if dw_dett_0.rowcount() > 0 then
		
		dw_dett_0.visible = true
		dw_lista_0.visible = false

		kst_stampe.dw_print = dw_dett_0
		kst_stampe.titolo = trim(k_stampa)
		
		kGuf_data_base.stampa_dw(kst_stampe)
		
		dw_lista_0.visible = true
		dw_dett_0.visible = false
		
	end if


end subroutine

public subroutine mostra_nascondi_in_lista ();//
kuf_base kuf1_base
string k_dataoggi
boolean k_rc


	pointer kpointer_orig
	kpointer_orig = setpointer(hourglass!)


	dw_lista_0.setredraw(false)


//--- se NON sono al primo giro
	if ki_st_open_w.flag_primo_giro <> "S" then
		leggi_liste()
	end if

	ki_win_titolo_orig = ki_win_titolo_orig_save
	choose case ki_mostra_nascondi_in_lista
		case "S" 	
			ki_win_titolo_orig += " Solo righe Articoli Attivi " 
			dw_lista_0.u_filtra_record("attivo <> 'N'  ")   
			ki_mostra_nascondi_in_lista = "N"
		case "N" 
			ki_win_titolo_orig += " Solo righe Articoli Non Attivi " 
			k_rc=dw_lista_0.u_filtra_record("attivo = 'N'  ")  
			ki_mostra_nascondi_in_lista = "*"
		case "*"
			ki_win_titolo_orig += " Tutte le righe Articoli "
			dw_lista_0.u_filtra_record("") 
			ki_mostra_nascondi_in_lista = "S"
	end choose
	kiw_this_window.title = ki_win_titolo_orig

	dw_lista_0.setredraw(true)
	
	setpointer(kpointer_orig)




end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//
//--- Attiva/Dis. Voci di menu personalizzate
//
if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	ki_menu.m_strumenti.m_fin_gest_libero1.text = "Mostra/Nascondi righe non Attive"
	ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
   "Mostra / Nascondi in elenco righe Articoli non Attivi"
	ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Mostra,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "DeleteRow!"
	ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
end if	

//---
	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//Mostra nasconde attivi/disattivi
		mostra_nascondi_in_lista()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected subroutine open_start_window ();//
	datawindowchild kdwc_iva, kdwc_gruppo


//	ki_win_titolo_orig_save = ki_win_titolo_orig
//
//	ki_toolbar_window_presente=true

//--- Attivo dw archivio IVA
	dw_lista_0.getchild("iva", kdwc_iva)

	kdwc_iva.settransobject(sqlca)

	if kdwc_iva.rowcount() = 0 then
		kdwc_iva.retrieve()
		kdwc_iva.insertrow(1)
	end if

//--- Attivo dw archivio GRUPPI
	dw_lista_0.getchild("gruppo", kdwc_gruppo)

	kdwc_gruppo.settransobject(sqlca)

	if kdwc_gruppo.rowcount() = 0 then
		kdwc_gruppo.retrieve(0)
		kdwc_gruppo.insertrow(1)
	end if

end subroutine

public function integer u_retrieve_dw_lista (string a_codice);//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(a_codice) 
	
	dw_lista_0.setfocus( )

//--- seleziona almeno una riga
	if dw_lista_0.rowcount() > 0 then
		if dw_lista_0.getselectedrow(0) = 0 then
			if dw_lista_0.getrow() = 0 then
				dw_lista_0.setrow(1)
				dw_lista_0.selectrow( 1, true)
			else
				dw_lista_0.selectrow(dw_lista_0.getrow(), true)
			end if
		end if
	end if
	
	attiva_tasti( )

	
return k_return
	

end function

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe



super::attiva_tasti_0()

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

end if


end subroutine

on w_prod_l.create
call super::create
end on

on w_prod_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_prod_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_prod_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_prod_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_prod_l
integer x = 2514
integer y = 1096
integer height = 92
integer taborder = 90
boolean enabled = false
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_prod_l
integer x = 0
integer y = 1100
integer width = 279
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_prod_l
integer x = 855
integer y = 1100
integer taborder = 30
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if LenA(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
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

type cb_modifica from w_g_tab0`cb_modifica within w_prod_l
integer x = 1737
integer y = 1096
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if LenA(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_prod_l
integer x = 448
integer y = 1108
integer height = 96
integer taborder = 110
end type

type cb_cancella from w_g_tab0`cb_cancella within w_prod_l
integer x = 2126
integer y = 1096
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_prod_l
integer x = 1349
integer y = 1096
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice=""
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

//	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
//	if len(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "pr"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
				
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
//	end if
end if
	





end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_prod_l
integer x = 315
integer y = 976
integer width = 2235
integer height = 224
string dataobject = "d_prod_l"
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

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

type st_orizzontal from w_g_tab0`st_orizzontal within w_prod_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_prod_l
integer x = 27
integer y = 16
integer width = 2807
integer height = 924
string dataobject = "d_prod_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_prod_l
end type

