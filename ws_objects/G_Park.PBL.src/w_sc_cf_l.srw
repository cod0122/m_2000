$PBExportHeader$w_sc_cf_l.srw
forward
global type w_sc_cf_l from w_g_tab0
end type
end forward

global type w_sc_cf_l from w_g_tab0
int Width=2898
int Height=1456
boolean TitleBar=true
string Title="SC-CF - Lista Capitolati di Fornitura"
end type
global w_sc_cf_l w_sc_cf_l

forward prototypes
private function string inizializza ()
private subroutine attiva_tasti ()
private function string cancella ()
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
string k_key
long k_codice
char k_attiva
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_codice = long(trim(ki_st_open_w.key1))
	k_attiva = trim(ki_st_open_w.key2)
	if isnull(k_codice) then
		k_codice = 0
	end if
	if isnull(k_attiva) or len(k_attiva) = 0 then
		k_attiva = "*"
	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)+trim(ki_st_open_w.key10)
		
		k_importa = kuf1_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
		
	
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_codice, k_attiva) < 1 then
			k_return = "1Non trovati Capitolati di Fornitura "

			SetPointer(oldpointer)
			messagebox("Lista SC-CF Vuota", &
					"Nesun Codice Trovato per la richiesta fatta")

		end if		
	end if


return k_return



end function
private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


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

end if

          
attiva_menu()


end subroutine

private function string cancella ();//
string k_des
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_contratti  kuf1_contratti  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_des = dw_lista_0.getitemstring(k_riga, "des")
	k_codice = dw_lista_0.getitemstring(k_riga, "codice")

	if isnull(k_des) = true or trim(k_des) = "" then
		k_des = "Capitolato Senza Descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Capitolato SC-CF", "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_des), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_contratti = create kuf_contratti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_contratti.tb_delete_sc_cf(k_codice) 
		if left(k_errore, 1) = "0" then
	
			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else

				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

			end if

			dw_lista_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							mid(k_errore1, 2) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
						"Controllare i dati. " + mid(k_errore, 2))
			end if

	
			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_contratti

	else
		messagebox("Elimina Capitolato", "Operazione Annullata !!")

	end if
end if

return k_errore
end function

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

on w_sc_cf_l.create
call super::create
end on

on w_sc_cf_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event key;call super::key;//
//=== Controllo quale tasto da tastiera ha premuto
//
//choose case key
//	case keypagedown!
//		if tab_1.selectedtab = 1 then
//			tab_1.selectedtab = 2
//		else
//			if tab_1.selectedtab = 2 then
//				tab_1.selectedtab = 3
//			else
//				tab_1.selectedtab = 1
//			end if
//		end if
//
//	case keypageup!
//		if tab_1.selectedtab = 1 then
//			tab_1.selectedtab = 3
//		else
//			if tab_1.selectedtab = 2 then
//				tab_1.selectedtab = 1
//			else
//				tab_1.selectedtab = 2
//			end if
//		end if
//end choose
//
//
end event

type cb_visualizza from w_g_tab0`cb_visualizza within w_sc_cf_l
int X=983
int Y=1104
int TabOrder=30
boolean Visible=false
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if len(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "sc_cf"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "vi"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		w_main.open_w_tabelle(k_st_open_w)
		
	end if
end if
	




end event

type cb_modifica from w_g_tab0`cb_modifica within w_sc_cf_l
int X=1737
int Y=1096
int Height=96
int TabOrder=70
boolean Visible=false
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice
st_open_w k_st_open_w


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_codice = dw_lista_0.getitemstring( k_riga, "codice" ) 
		
	if len(trim(k_codice))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;

		K_st_open_w.id_programma = "sc_cf"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "mo"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		w_main.open_w_tabelle(k_st_open_w)
		
	end if
end if
	




end event

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sc_cf_l
int X=27
int Y=16
int Width=2807
int Height=1048
string DataObject="d_sc_cf_l"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sc_cf_l
int X=325
int Y=1168
int Height=96
int TabOrder=110
boolean Visible=false
end type

event cb_aggiorna::clicked;//
//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then

	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
	
end if

end event

type cb_cancella from w_g_tab0`cb_cancella within w_sc_cf_l
int X=2126
int Y=1096
int Height=96
int TabOrder=80
boolean Visible=false
end type

event cb_cancella::clicked;//
cancella()

end event
type cb_inserisci from w_g_tab0`cb_inserisci within w_sc_cf_l
int X=1349
int Y=1096
int Height=96
int TabOrder=60
boolean Visible=false
boolean Enabled=false
end type

event cb_inserisci::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_codice=""
st_open_w k_st_open_w


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

		K_st_open_w.id_programma = "sc_cf"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "in"
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = k_codice  // codice prodotto
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		w_main.open_w_tabelle(k_st_open_w)
		
//	end if
end if
	





end event

type cb_ritorna from w_g_tab0`cb_ritorna within w_sc_cf_l
int X=2514
int Y=1096
int Height=92
int TabOrder=90
boolean Visible=false
boolean Enabled=false
boolean Cancel=true
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sc_cf_l
int X=2062
int Y=976
int Width=489
int Height=224
boolean Visible=false
string DataObject="d_prod_l"
boolean VScrollBar=true
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

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_sc_cf_l
int X=457
int Y=132
int TabOrder=40
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_sc_cf_l
int TabOrder=50
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_sc_cf_l
int TabOrder=100
boolean BringToTop=true
end type

