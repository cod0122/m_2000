$PBExportHeader$w_pl_barcode_testa.srw
forward
global type w_pl_barcode_testa from w_g_tab0
end type
end forward

global type w_pl_barcode_testa from w_g_tab0
integer width = 2807
string title = "Piano di Lavoro"
end type
global w_pl_barcode_testa w_pl_barcode_testa

forward prototypes
private function string inizializza ()
private function string check_dati ()
private function string cancella ()
end prototypes

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 ", k_scelta=" "
long k_key
int k_err_ins, k_rc
string k_fine_ciclo=""
int k_ctr=0

	k_key = long(trim(ki_st_open_w.key1))
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	if k_scelta = "in" then
		
		k_err_ins = inserisci()
		dw_dett_0.setfocus()
	else

		k_rc = dw_dett_0.retrieve(k_key) 

		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(Codice cercato :" + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				dw_dett_0.reset()
				attiva_tasti()

				if k_scelta = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma il P.L. non e' in archivio ~n~r" + &
						"(Codice cercato :" + string(k_key) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					k_err_ins = inserisci()
					dw_dett_0.setfocus()
				end if
			case is > 0		
				if k_scelta = "in" then
					messagebox("Trovato P.L.", &
						"Il Piano di Lavorazione e' gia' in archivio ~n~r" + &
						"(Codice cercato :" + string(k_key) + ")~n~r" )
			
					ki_st_open_w.flag_modalita = "mo"

				end if

				dw_dett_0.setcolumn(2)
				dw_dett_0.setfocus()
				
				attiva_tasti()
		
		end choose

	end if

//===
//--- inabilito le mofidifice sulla dw
if ki_st_open_w.flag_modalita = "vi" then

   k_fine_ciclo = ""
	do while k_fine_ciclo = ""
		k_ctr = k_ctr + 1 
		k_fine_ciclo=dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+".TabSequence='0'")
		if k_fine_ciclo = "" then
			dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+".Background.Color='"+&
			                string(rgb(192,192,192))+"'")
		end if
	loop 
end if

	

return k_return



end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = "0 ", k_errore="0"
date k_data
long k_riga


	k_riga = dw_dett_0.getrow() 
	k_data = dw_dett_0.getitemdate ( k_riga, "data") 
	if isnull(k_data) or k_data = date(0) then
		k_return = "Manca la Data del P.L.  " + "~n~r"
//			k_return = "Manca la Ragione sociale " + "~n~r" 
		k_errore = "3"
	end if

	if k_errore = "0" then
		if dw_dett_0.getitemdate ( k_riga, "data_sosp") > &
			dw_dett_0.getitemdate ( k_riga, "data_chiuso") then
			k_return = "Data Sospensione maggiore della data di Chiusura " + "~n~r" 
			k_errore = "4"
		end if
	end if


	if k_errore = "0" then
	
		dw_dett_0.setitem(k_riga, "x_datins", today())
		dw_dett_0.setitem(k_riga, "x_utente", "Pwd:"+string(kg_pwd, "##0"))
		
	end if

return k_return
end function

private function string cancella ();//
string k_return="0 "
string k_desc
long k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_pl_barcode  kuf1_pl_barcode
st_tab_pl_barcode kst_tab_pl_barcode

//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = dw_dett_0.getitemnumber(1, "codice")
	k_desc = dw_dett_0.getitemstring(1, "note_1")
end if

if k_riga > 0 and isnull(k_codice) = false then	
	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "senza note " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Piano di Lavorazione", "Sei sicuro di voler Cancellare : ~n~r" + &
				string(k_codice, "####0") + " " + trim(k_desc), &
				question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_pl_barcode = create kuf_pl_barcode
		
//=== Cancella la riga dal data windows di lista
		kst_tab_pl_barcode.codice = k_codice
		k_errore = kuf1_pl_barcode.tb_delete(kst_tab_pl_barcode) 
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				dw_dett_0.deleterow(k_riga)

			end if

			dw_dett_0.setfocus()

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
		destroy kuf1_pl_barcode

	else
		messagebox("Elimina P. L.", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function
on w_pl_barcode_testa.create
call super::create
end on

on w_pl_barcode_testa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//---

	
	if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN then

		this.setredraw(false)

		dw_dett_0.width = this.width - 100
	
		dw_dett_0.height = this.height - 150
	
//=== Posiziona dw nella window 
		dw_dett_0.x = (this.width - dw_dett_0.width) / 3
		dw_dett_0.y = (this.height - dw_dett_0.height) / 7
		
		this.setredraw(true)
		
	end if
//end if




end event
event open;call super::open;//
	this.width = this.width / 2

	this.height = this.height / 2
	
	if w_main.width > this.width then
		this.x = (w_main.width - this.width) / 2
	else
		this.x = 1
	end if
	if w_main.height > this.height then
		this.y = (w_main.height - this.height) / 6
	else
		this.y = 1
	end if

end event

type st_stampa from w_g_tab0`st_stampa within w_pl_barcode_testa
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_pl_barcode_testa
boolean visible = false
end type

type cb_modifica from w_g_tab0`cb_modifica within w_pl_barcode_testa
boolean visible = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_pl_barcode_testa
boolean visible = false
integer x = 0
integer height = 128
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_pl_barcode_testa
boolean visible = false
end type

event cb_aggiorna::clicked;//
//
string k_aggiorna_dati = "0"


//=== Aggiornamento dei dati inseriti/modificati
k_aggiorna_dati = trim(aggiorna_dati())

if left(k_aggiorna_dati, 1) = "0" then

	messagebox("Operazione eseguita", "Dati aggiornati correttamente")

	cb_ritorna.triggerevent (clicked!)

end if


end event

type cb_cancella from w_g_tab0`cb_cancella within w_pl_barcode_testa
boolean visible = false
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_pl_barcode_testa
boolean visible = false
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_pl_barcode_testa
boolean visible = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_pl_barcode_testa
integer x = 41
integer y = 88
integer width = 2560
integer height = 1128
string title = "Piano di Lavorazione"
string dataobject = "d_pl_barcode_testa_1"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_dett_0::buttonclicked;call super::buttonclicked;//---
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window 


if dwo.name = "b_dettaglio" then
	
//=== Parametri : 
//=== struttura st_open_w
	kst_open_w.id_programma = "pl_barcode_d"
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita= ki_st_open_w.flag_modalita
	kst_open_w.flag_adatta_win = ki_st_open_w.flag_adatta_win
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = trim(string(this.getitemnumber(row, "codice")))
	kst_open_w.key2 = " "
	kst_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

end if
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_pl_barcode_testa
integer x = 955
integer y = 240
end type

type sle_cerca from w_g_tab0`sle_cerca within w_pl_barcode_testa
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_pl_barcode_testa
end type

