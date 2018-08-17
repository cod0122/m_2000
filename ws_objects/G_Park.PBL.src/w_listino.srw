$PBExportHeader$w_listino.srw
forward
global type w_listino from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_listino from w_g_tab_3
int X=169
int Y=148
int Width=3127
int Height=1732
boolean TitleBar=true
string Title="Listino"
end type
global w_listino w_listino

type variables
long ki_cod_cli
string ki_cod_art
string ki_sl_pt

end variables

forward prototypes
private subroutine inizializza ()
protected subroutine inizializza_1 ()
private subroutine inizializza_2 ()
private subroutine inizializza_3 ()
private function integer inserisci ()
private function string check_dati ()
private subroutine riempi_id ()
protected function integer cancella ()
private subroutine leggi_altre_tab ()
private subroutine pulizia_righe ()
private subroutine attiva_tasti ()
protected function string aggiorna ()
private function string dati_modif (string k_titolo)
private subroutine inizializza_4 ()
private function integer check_rek (string k_codice)
end prototypes

private subroutine inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_return="0 "
long k_codice, k_riga 
string k_cod_art, k_cod_sl_pt, k_rc1, k_style
int k_ctr, k_rc
int k_importa = 0
real k_dose
long k_mis_x, k_mis_y, k_mis_z
long k_cod_cli
string k_sl_pt, k_mc_co 
kuf_listino kuf1_listino
datawindowchild  kdwc_sl_pt 
datawindowchild  kdwc_mc_co, kdwc_mc_co_des
datawindowchild  kdwc_articoli 
datawindowchild  kdwc_clienti_cod, kdwc_articoli_des, kdwc_sl_pt_des 


pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	choose case trim(ki_st_open_w.flag_modalita) 
		case "in" 
			w_listino.title = "Listino: Inserimento"
		case "mo" 
			w_listino.title = "Listino: Modifica"
		case "vi" 
			w_listino.title = "Listino: Visualizzazione"
		case "ca" 
			w_listino.title = "Listino: Cancellazione"
		case else
			w_listino.title = "Listino"
	end choose

	if len(trim(ki_st_open_w.key1)) = 0 then
		k_codice = 0
	else
		k_codice = long(trim(ki_st_open_w.key1))
	end if

	if len(trim(ki_st_open_w.key2)) = 0 or &
		isnull(trim(ki_st_open_w.key2)) then
		k_cod_art = " "
	else
		k_cod_art = trim(ki_st_open_w.key2)
	end if

	if len(trim(ki_st_open_w.key3)) = 0 or &
		isnull(trim(ki_st_open_w.key3)) then
		k_dose = 0
	else
		k_dose = real(trim(ki_st_open_w.key3))
	end if

	if len(trim(ki_st_open_w.key4)) = 0 or &
		isnull(trim(ki_st_open_w.key4)) then
		k_mis_x = 0
	else
		k_mis_x = long(trim(ki_st_open_w.key4))
	end if

	if len(trim(ki_st_open_w.key5)) = 0 or &
		isnull(trim(ki_st_open_w.key5)) then
		k_mis_y = 0
	else
		k_mis_y = long(trim(ki_st_open_w.key5))
	end if

	if len(trim(ki_st_open_w.key6)) = 0 or &
		isnull(trim(ki_st_open_w.key6)) then
		k_mis_z = 0
	else
		k_mis_z = long(trim(ki_st_open_w.key6))
	end if

//--- resetto i campi che servono alla retrieve delle childdw
	ki_cod_cli = 0
	ki_cod_art = " "
	ki_sl_pt = " "

//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = "in" then
		inserisci()
	else
//--- Se NO inserimento.... 
		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_codice, k_cod_art, k_dose, k_mis_x, k_mis_y, k_mis_z) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Articolo cercato :" + trim(k_cod_art) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if trim(ki_st_open_w.flag_modalita) = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma Articolo Listino non e' in archivio ~n~r" + &
					"(ID Articolo cercato :" + trim(k_cod_art) + ")~n~r" )

					cb_ritorna.triggerevent("clicked!")
					
				else
					inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if

			case is > 0		
				if trim(ki_st_open_w.flag_modalita) = "in" then
					messagebox("Trovato Articolo Listino", &
						"Il Listino e' gia' in archivio ~n~r" + &
					   "(ID Articolo cercato :" + trim(k_cod_art) + ")~n~r" )
			
						ki_st_open_w.flag_modalita = "mo"

				end if

				tab_1.tabpage_1.dw_1.setcolumn(1)
				tab_1.tabpage_1.dw_1.setfocus()

//				k_cod_sl_pt = trim(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt"))
//				if isnull(k_cod_sl_pt) or len(trim(k_cod_sl_pt)) = 0 then
//					k_cod_sl_pt = "%"
//				end if
	
//--- Attivo dw archivio SL_PT
//				tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)
//		
//				kdwc_sl_pt.settransobject(sqlca)
//			
//				if ki_st_open_w.flag_modalita = "vi" then
//					kdwc_sl_pt.retrieve(k_cod_sl_pt)
//					kdwc_sl_pt.insertrow(1)
//				end if
				
				attiva_tasti()
		
		end choose

	end if

//--- se inserimento inabilito gli altri TAB, sono inutili
if ki_st_open_w.flag_modalita = "in" then

	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
	tab_1.tabpage_4.enabled = false
	tab_1.tabpage_5.enabled = false
	
end if


//--- Inabilita campi alla modifica se Vsualizzazione
   if trim(ki_st_open_w.flag_modalita) = "vi" then
		k_rc1 = ""
		k_ctr=0
		do while k_rc1 = "" 
			k_ctr = k_ctr + 1 
 		   k_rc1=tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+".TabSequence='0'")

			if k_rc1 = "" then
				k_style=tab_1.tabpage_1.dw_1.Describe("#" + trim(string(k_ctr,"###"))+".Edit.Style")
				if upper(k_style) <> "DDDW" then
					k_rc1=string(rgb(192,192,192))
					tab_1.tabpage_1.dw_1.Modify("#" + trim(string(k_ctr,"###"))+&
					                 ".Background.Color='"+k_rc1+"'")
					k_rc1=""
				end if
			end if

		loop 
		//???? non so perche' ma provo cosi
	 	k_rc1=tab_1.tabpage_1.dw_1.Modify("cod_mc_co.TabSequence='0'")
	end if

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
   if trim(ki_st_open_w.flag_modalita) = "mo" then
		k_rc1=tab_1.tabpage_1.dw_1.Modify("rag_soc_1.TabSequence='0'")
//		k_rc1=string(rgb(192,192,192))
//		tab_1.tabpage_1.dw_1.Modify("cod_cli.Background.Color='"+k_rc1+"'")
	end if
	
	
	kuf1_listino = create kuf_listino
	kuf1_listino.autorizza_campi(tab_1.tabpage_1.dw_1)
	destroy kuf1_listino



//--- se NO inserimento leggo DW-CHILD
if ki_st_open_w.flag_modalita <> "in" then

	k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
	k_mc_co = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_mc_co")
	
//--- Attivo dw archivio MC-CO
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co", kdwc_mc_co)

	k_rc = kdwc_mc_co.settransobject(sqlca)

	kdwc_mc_co.retrieve(k_cod_cli, k_mc_co)
	k_rc = kdwc_mc_co.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co_des", kdwc_mc_co_des)

	k_rc = kdwc_mc_co_des.settransobject(sqlca)
	k_rc = kdwc_mc_co_des.insertrow(1)

	kdwc_mc_co.RowsCopy(kdwc_mc_co.GetRow(), &
			 kdwc_mc_co.RowCount(), Primary!, kdwc_mc_co_des, 1, Primary!)

	k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_art")
//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_articoli)

	k_rc = kdwc_articoli.settransobject(sqlca)

	kdwc_articoli.retrieve(k_cod_art)
	kdwc_articoli.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_articoli_des)

	k_rc = kdwc_articoli_des.settransobject(sqlca)

	kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), &
			 kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)


	k_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_sl_pt")
//--- Attivo dw archivio SL-PT
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)

	k_rc = kdwc_sl_pt.settransobject(sqlca)

	kdwc_sl_pt.retrieve(k_sl_pt)
	kdwc_sl_pt.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt_des", kdwc_sl_pt_des)

	k_rc = kdwc_sl_pt_des.settransobject(sqlca)

	kdwc_sl_pt.RowsCopy(kdwc_sl_pt.GetRow(), &
			 kdwc_sl_pt.RowCount(), Primary!, kdwc_sl_pt_des, 1, Primary!)
			 
	k_riga = kdwc_sl_pt_des.find("cod_sl_pt='"+k_sl_pt+"'",1,kdwc_sl_pt_des.RowCount())
	if k_riga > 0 then
		kdwc_sl_pt_des.setrow(k_riga)
	end if
	

end if




end subroutine
protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
string k_codice
string k_scelta


//	k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if len(trim(k_codice)) = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")  
//	end if
//
////=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
////	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
////		if tab_1.tabpage_2.dw_2.getitemnumber(1, "codice") <> k_codice then 
////			tab_1.tabpage_2.dw_2.reset()
////		end if
////	end if
//	if tab_1.tabpage_2.dw_2.rowcount() < 1 then
//
////		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
//
////=== Parametri : cliente, articolo
//		if tab_1.tabpage_2.dw_2.retrieve(0, k_codice) <= 0 then
//
//			inserisci()
//		else
//					
//			attiva_tasti()
//
//		end if				
//	else
//		attiva_tasti()
//	end if
//
//	tab_1.tabpage_2.dw_2.setfocus()
//	
//
end subroutine

private subroutine inizializza_2 ();//////======================================================================
////=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_id_cliente
//string k_scelta
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
////	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
////		if tab_1.tabpage_3.dw_3.getitemnumber(1, "codice") <> k_codice then 
////			tab_1.tabpage_3.dw_3.reset()
////		end if
////	end if
//	if tab_1.tabpage_3.dw_3.rowcount() < 1 then
//
////		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  
//
////=== Parametri : cliente, cliente, flag di solo rek della cliente
//		if tab_1.tabpage_3.dw_3.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//					
//			attiva_tasti()
//
//		end if				
//	else
//		attiva_tasti()
//	end if
//
//	tab_1.tabpage_3.dw_3.setfocus()
//	
//
end subroutine

private subroutine inizializza_3 ();//////======================================================================
////=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice, k_codice_4
//string k_scelta
//
//
//	k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  

//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////--- Acchiappo il codice CLIENTE x evitare la rilettura
//if IsNumber(tab_1.tabpage_4.dw_4.Object.k_codice.Text) then
//	k_codice_4 = long(tab_1.tabpage_4.dw_4.Object.k_codice.Text)
//else
//	k_codice_4 = 0
//end if
////=== Forza valore Codice cliente per ricordarlo per le prossime richieste
//tab_1.tabpage_4.dw_4.Object.k_codice.Text=string(k_codice, "####0")
//
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
//		if k_codice_4 <> k_codice then 
//			tab_1.tabpage_4.dw_4.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_4.dw_4.rowcount() < 1 then
////			if k_scelta <> "in" then
//
//		if tab_1.tabpage_4.dw_4.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
////			else
////				inserisci()
////			end if
//	else
//		attiva_tasti()
//
//	end if
//
//////=== Se tab_4 non ha righe INSERISCI_TAB_41 altrimenti controllo che righe sono
//////=== Se le righe presenti non c'entrano con la cliente allora resetto
////	if tab_1.tabpage_4.dw_41.rowcount() > 0 then
////		tab_1.tabpage_4.dw_41.accepttext()
////		if tab_1.tabpage_4.dw_41.getitemnumber(1, "codice") <> k_codice then 
////			tab_1.tabpage_4.dw_41.reset()
////		end if
////	end if
////
////	if tab_1.tabpage_4.dw_41.rowcount() < 1 then
////
////		if tab_1.tabpage_4.dw_41.retrieve(k_codice) <= 0 then
////
////			inserisci()
////		else
////			attiva_tasti()
////		end if				
////	else
////		attiva_tasti()
////	end if
////	
////	tab_1.tabpage_4.dw_41.setfocus()
////	
//
//	
//
//
//
end subroutine

private function integer inserisci ();//
int k_return=1, k_ctr, k_rc
string k_errore="0 "
date k_data
long k_riga 
string k_codice
string k_cod_art
long k_cod_cli
string k_record_base
kuf_base kuf1_base
datawindowchild kdwc_cli


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


//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
	
			k_cod_cli = long(trim(ki_st_open_w.key1))
			k_cod_art = trim(ki_st_open_w.key2)
			
			tab_1.tabpage_1.dw_1.insertrow(0)


//--- posiziono su riga cliente richiesto
			if K_cod_cli > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("rag_soc_1", Kdwc_cli)
				k_riga = kdwc_cli.find("id_cliente="+trim(string(K_cod_cli, "####0")),0,kdwc_cli.rowcount())
				if k_riga > 0 then
					k_rc = tab_1.tabpage_1.dw_1.setitem(1, "rag_soc_1", &
											kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
				end if
			end if
				
			tab_1.tabpage_1.dw_1.setitem(1, "cod_cli", K_cod_cli)
			tab_1.tabpage_1.dw_1.setitem(1, "cod_art", K_cod_art)
			
			tab_1.tabpage_1.dw_1.setitem(1, "attivo", "S")
			tab_1.tabpage_1.dw_1.setitem(1, "magazzino", 2)
			tab_1.tabpage_1.dw_1.setitem(1, "prezzo", 0)
			
			kuf1_base = create kuf_base
			k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
			destroy kuf_base
			if left(k_record_base,1) = "0" then			
				tab_1.tabpage_1.dw_1.setitem(1, "mis_x", integer(trim(mid(k_record_base, 2, 5)))) 		
				tab_1.tabpage_1.dw_1.setitem(1, "mis_y", integer(trim(mid(k_record_base, 7, 5)))) 		
				tab_1.tabpage_1.dw_1.setitem(1, "mis_z", integer(trim(mid(k_record_base, 12, 5)))) 		
				tab_1.tabpage_1.dw_1.setitem(1, "occup_ped", 100)
				
			end if
				
			tab_1.tabpage_1.dw_1.setfocus()
			tab_1.tabpage_1.dw_1.setcolumn(3)
			
			
		case 2 // Listino
			k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
////=== Riempe indirizzo di Spedizione da DW_1
//			if k_codice > 0 then
//				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)
//	
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "codice", k_codice)
//				tab_1.tabpage_2.dw_2.setitem(k_riga, "clie_3", k_codice)
//	
//				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
//				tab_1.tabpage_2.dw_2.setrow(k_riga)
//				tab_1.tabpage_2.dw_2.setcolumn(1)
//			end if
//			
		case 3 // Listino
			
		case 4 // Lista Entrate
			
		case 5 // Lista Fatture
			
	end choose	

	attiva_tasti()

	k_return = 0

end if

return (k_return)



end function

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = " ", k_errore = "0"
int k_rc=0
long k_cod_cli1, k_cod_cli
string k_mc_co, k_sl_pt, k_cod_art
int k_magazzino, k_magazzino_art
datawindowchild  kdwc_mc_co, kdwc_cli, kdwc_sl_pt, kdwc_art


//--- controllo se rec già esistente

   k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "cod_cli")
   k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_art")

	SELECT 
         listino.cod_cli  
   	 INTO 
      	   :k_cod_cli1  
    	FROM listino 
   	WHERE cod_cli = :k_cod_cli and cod_art = :k_cod_art;

	if sqlca.sqlcode = 0 then

		if ki_st_open_w.flag_modalita = "in" then

			k_return = "Prezzo Listino gia' in Archivio"
			k_errore = "1"

		end if
	else
		
		if ki_st_open_w.flag_modalita = "ca" then
	
			k_return = "Prezzo Listino non trovato in Archivio"
			k_errore = "1"

		end if  


	end if

//-- Controllo esistenza minima dei dati
	if k_errore = "0" then
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( 1, "cod_cli")) = true &
		   or tab_1.tabpage_1.dw_1.getitemnumber ( 1, "cod_cli") = 0 then
			k_return = "Manca Cliente " + "~n~r" 
			k_errore = "3"
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art")) = true &
		   or len(trim(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art"))) = 0 then
			k_return = k_return + "Manca Articolo "  + "~n~r" 
			k_errore = "3"
		end if
	end if


//--- controllo esistenza codice Cliente
	if ki_st_open_w.flag_modalita = "in" then
		k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
		if k_cod_cli > 0 then
			k_rc = tab_1.tabpage_1.dw_1.getchild("cod_cli", kdwc_cli)
			k_rc = kdwc_cli.find("id_cliente="+trim(string(k_cod_cli,"####0")),0,kdwc_cli.rowcount())
			if k_rc <= 0 or isnull(k_rc) then
				k_return = k_return + "Non Trovata: Anagrafica Cliente "  + "~n~r" 
				k_errore = "3"
			end if
		end if
	end if

//--- controllo esistenza codice Articolo
	k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_art")
	if len(trim(k_cod_art)) > 0 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_art)
		k_rc = kdwc_art.find("codice='"+trim(k_cod_art)+"'",0,kdwc_art.rowcount())
		if k_rc <= 0 or isnull(k_rc) then
			k_return = k_return + "Non Trovato: Codice Articolo "  + "~n~r" 
			k_errore = "3"
		end if
//--- se specificato magazzino particolare allora deve essere uguale a quello sull'articolo
		k_magazzino = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "magazzino")
		k_magazzino_art = kdwc_art.getitemnumber(kdwc_art.getrow(), "magazzino")
		if (k_magazzino = kk_magazzino_nuovo or k_magazzino = kk_magazzino_vecchio) and &
		   (k_magazzino_art = kk_magazzino_nuovo or k_magazzino_art = kk_magazzino_vecchio) and &
		   k_magazzino <> k_magazzino_art then

			k_return = k_return + "Dati incongruenti: Impianto specificato diverso nell'Articolo "  + "~n~r" 
			k_errore = "3"

		end if
	end if

//--- controllo esistenza codice mc-co 
	k_mc_co = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_mc_co")
	if len(trim(k_mc_co)) > 0 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co", kdwc_mc_co)
		k_rc = kdwc_mc_co.find("mc_co='"+trim(k_mc_co)+"'",0,kdwc_mc_co.rowcount())
		if k_rc <= 0 or isnull(k_rc) then
			k_return = k_return + "Non Trovato: Codice Conferma d'ordine MC-CO "  + "~n~r" 
			k_errore = "3"
		end if
	end if

//--- controllo esistenza codice sl_pt
	k_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(), "cod_sl_pt")
	if len(trim(k_sl_pt)) > 0 then
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)
		k_rc = kdwc_sl_pt.find("cod_sl_pt='"+trim(k_sl_pt)+"'",0,kdwc_sl_pt.rowcount())
		if k_rc <= 0 or isnull(k_rc) then
			k_return = k_return + "Non Trovato: Codice Piano di Trattamento SL-PT "  + "~n~r" 
			k_errore = "3"
		end if
	end if
	

//-- Non tollerati i campo a NULL
	if k_errore = "0" then
      if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")) then 
         tab_1.tabpage_1.dw_1.setitem(1, "dose", 0)
      end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_x")) then
			tab_1.tabpage_1.dw_1.setitem(1, "mis_x", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_y")) then
			tab_1.tabpage_1.dw_1.setitem(1, "mis_x", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_z")) then
			tab_1.tabpage_1.dw_1.setitem(1, "mis_z", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "occup_ped")) then
			tab_1.tabpage_1.dw_1.setitem(1, "occup_ped", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "peso_kg")) then
			tab_1.tabpage_1.dw_1.setitem(1, "peso_kg", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "campione")) then
			tab_1.tabpage_1.dw_1.setitem(1, "campione", "N")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "travaso")) then
			tab_1.tabpage_1.dw_1.setitem(1, "travaso", "N")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")) then
			tab_1.tabpage_1.dw_1.setitem(1, "magazzino", 0)
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_mc_co")) then
			tab_1.tabpage_1.dw_1.setitem(1, "cod_mc_co", " ")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemstring(1, "cod_sl_pt")) then
			tab_1.tabpage_1.dw_1.setitem(1, "cod_sl_pt", " ")
		end if
	end if
	
return trim(k_errore) + trim(k_return)


end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr
string k_codice_1, k_codice
string k_ret_code
kuf_base kuf1_base

//
//=== Imposta campi di default

	tab_1.tabpage_1.dw_1.setitem(1, "k_pwd", trim(string(kg_pwd)))

////=== Salvo ID  originale x piu' avanti
//	k_codice_1 = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//
////=== Se non sono in caricamento allora prelevo l'ID dalla dw
//	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
//		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
//	else
//		
////		kuf1_base = create kuf_base
////	//=== Imposto il ID  su arch. Azienda
////		k_ret_code = kuf1_base.prendi_dato_base("codice")
////		if left(k_ret_code, 1) = "0" then
////			k_codice = long(mid(k_ret_code, 2)) + 1
////			k_ret_code = kuf1_base.metti_dato_base(0, "codice", string(k_codice,"#####"))
////		end if
////		if left(k_ret_code, 1) = "1" then
////	
////			k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")
////			
////			messagebox("Aggiornamento Automatico Fallito !!", &
////				"Attenzione: non sono riuscito ad aggiornare il contatore COMMESSE,~n~r" + &
////				"in archivio Azienda. ~n~r" + &
////				"Aggiornare immediatamente in modo manuale il 'ID Commessa' in Azienda. ~n~r" + &
////				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
////				"il numero " + string(k_codice,"#####") + " nel campo 'ID Commess'. ~n~r" + &
////				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &
////				"Se il problema persiste, si prega di contattare il programmatore. Grazie", &
////				stopsign!, ok!)
////				
////		end if		
//	
////		destroy kuf1_base
////		k_nro_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
////		if k_nro_commessa <> k_nro_commessa_1 then
////
//////=== ho trovato il nr commessa diverso da quello in BASE controllo se commessa gia' caricata
////			select codice into :k_ctr
////				from commesse
////				where nro_commessa = :k_nro_commessa_1;
////
////			if sqlca.sqlcode = 0 then
////				k_nro_old = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa") 
////				messagebox("Aggiornamento Commessa", &
////					"Mi spiace ma il numero abbinato a questa commessa e' stato cambiato ~n~r" + &
////					"da " + string(k_nro_old,"#####") + " a " + &
////						string(k_nro_commessa,"#####") + "~n~r" + &
////					"Motivo : potrebbero esserci altri utenti che stanno caricando Commesse, ~n~r" + &
////					"nessun pericolo di perdita dati. ", &
////					information!, ok!)
////			end if
////		end if		
////	
//	
////		tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
//	
////		tab_1.tabpage_1.dw_1.setitem(1, "codice", k_codice)
//
//	end if
//	
////	k_righe = tab_1.tabpage_2.dw_2.rowcount()
////	if k_righe > 0 then
////
////	
////		tab_1.tabpage_2.dw_2.setitem(k_ctr, "codice", k_codice)
////
////		tab_1.tabpage_1.dw_1.setitem(1, "indi_2", &
////				tab_1.tabpage_2.dw_2.getitemstring(1, "indi_2"))
////		tab_1.tabpage_1.dw_1.setitem(1, "cap_2", &
////				tab_1.tabpage_2.dw_2.getitemstring(1, "cap_2"))
////		tab_1.tabpage_1.dw_1.setitem(1, "loc_2", &
////				tab_1.tabpage_2.dw_2.getitemstring(1, "loc_2"))
////		tab_1.tabpage_1.dw_1.setitem(1, "prov_2", &
////				tab_1.tabpage_2.dw_2.getitemstring(1, "prov_2"))
////				
////	end if
////
//

end subroutine

protected function integer cancella ();////
////=== Cancellazione rekord dal DB
////=== Ritorna : 0=OK 1=KO 2=non eseguita
////
int k_return=0
string k_cod_art
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
real k_dose
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
kuf_listino  kuf1_listino


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = tab_1.tabpage_1.dw_1.rowcount()	
if k_riga > 0 then
	k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "cod_cli")
	k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_art")
	k_dose = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dose")
	k_mis_x = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_x")
	k_mis_y = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_y")
	k_mis_z = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_z")

end if

if k_riga > 0 and isnull(k_cod_cli) = false then	
	if isnull(k_cod_art) = true or trim(k_cod_art) = "" then
		k_cod_art = "Prezzo Listino senza Articolo" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Prezzo Listino", "Sei sicuro di voler Cancellare : ~n~r" + &
				string(k_cod_cli, "####0") + " " + trim(k_cod_art), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_listino = create kuf_listino
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_listino.tb_delete(k_cod_cli, k_cod_art, k_dose, &
													 k_mis_x, k_mis_y, k_mis_z) 
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				tab_1.tabpage_1.dw_1.deleterow(k_riga)

			end if

			tab_1.tabpage_1.dw_1.setfocus()

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
		destroy kuf1_listino

	else
		messagebox("Elimina Prezzo Listino", "Operazione Annullata !!")
	end if

	tab_1.tabpage_1.dw_1.setcolumn(1)

end if

choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
end choose	


return k_return

end function

private subroutine leggi_altre_tab ();////
//long k_id_cliente, k_null, k_id_commessa
//datawindowchild kdwc_contatto, kdwc_protocollo
//
//
//	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
//	k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
//	if isnull(k_id_commessa) then
//		k_id_commessa = 0
//	end if
//
//	setnull(k_null)
//	tab_1.tabpage_1.dw_1.setitem(1, "id_contatto", k_null)
//	tab_1.tabpage_1.dw_1.setitem(1, "id_protocollo", k_null)
//
//	tab_1.tabpage_1.dw_1.getchild("id_contatto", kdwc_contatto)
//	kdwc_contatto.settransobject(sqlca)
//	tab_1.tabpage_1.dw_1.getchild("id_protocollo", kdwc_protocollo)
//	kdwc_protocollo.settransobject(sqlca)
//
//	if k_id_cliente > 0 then
//		kdwc_contatto.retrieve(k_id_cliente)
//		kdwc_protocollo.retrieve(k_id_cliente, k_id_commessa)
//	end if	
//	kdwc_contatto.insertrow(1)
//	kdwc_protocollo.insertrow(1)
//	
//	
end subroutine

private subroutine pulizia_righe ();//
long k_riga
long k_nr_righe
string k_cod_art
long k_cod_cli
long k_ctr


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
tab_1.tabpage_5.dw_5.accepttext()
//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE


tab_1.tabpage_1.dw_1.accepttext()

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = tab_1.tabpage_1.dw_1.rowcount ( )
if k_riga > 0 then
	
//	k_ctr = tab_1.tabpage_1.dw_1.getrow()
   k_ctr = 1
	
	k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(k_ctr, "cod_cli") 
 	if isnull(k_cod_cli) or k_cod_cli = 0 then
		tab_1.tabpage_1.dw_1.deleterow(k_ctr)
	end if
	k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(k_ctr, "cod_art") 
 	if isnull(k_cod_art) or len(trim(k_cod_art)) = 0 then
		tab_1.tabpage_1.dw_1.deleterow(k_ctr)
	end if
	
end if


end subroutine

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_aggiorna.enabled = true
cb_cancella.enabled = true

cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
		end if
	case 2
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
	case 3
			cb_cancella.enabled = false
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
	case 4
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
	case 5
			cb_inserisci.enabled = false
			cb_inserisci.default = false
			cb_aggiorna.enabled = false
			cb_aggiorna.enabled = false
end choose
            
attiva_menu()

end subroutine

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

////=== Aggiorna, se modificato, la TAB_2
//if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_2.dw_2.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_2.text + "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_3
//if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
//	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_3.dw_3.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio '" + &
//					tab_1.tabpage_3.text + "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_4
//if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_4.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Movimenti " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Movimenti'" + &
//					 "' ~n~r" 
//	end if	
//end if
//
////=== Aggiorna, se modificato, la TAB_4 dw_41
//if tab_1.tabpage_4.dw_41.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_41.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_41.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Note Commessa " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Note Commessa'" + &
//					" ~n~r" 
//	end if	
//end if


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

private function string dati_modif (string k_titolo);//
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
	 	tab_1.tabpage_5.dw_5.getnextmodified(0, delete!) > 0  & 
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

private subroutine inizializza_4 ();//////======================================================================
////=== Inizializzazione del TAB 5 controllandone i valori se gia' presenti
////======================================================================
////
//long k_codice
//string k_scelta
//
//
//k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	k_scelta = trim(ki_st_open_w.flag_modalita)
//
////=== Se nr.cliente non impostato forzo una INSERISCI cliente, impostando in nr.cliente
//	if k_codice = 0 then
//		inserisci()
//		k_codice = tab_1.tabpage_1.dw_1.getitemnumber(1, "codice")  
//	end if
//
////=== Se tab_5 non ha righe INSERISCI_TAB_5 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la cliente allora resetto		
//	if tab_1.tabpage_5.dw_5.rowcount() > 0 then
//		if tab_1.tabpage_5.dw_5.getitemnumber(1, "codice") <> k_codice then 
//			tab_1.tabpage_5.dw_5.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_5.dw_5.rowcount() < 1 then
////			if k_scelta <> "in" then
//
//		if tab_1.tabpage_5.dw_5.retrieve(k_codice) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
////			else
////				inserisci()
////			end if
//	else
//		attiva_tasti()
//
//	end if
//	
//
//
//
end subroutine

private function integer check_rek (string k_codice);////
int k_return = 0
//int k_anno
//string k_des
//string k_codice_1
//
//
//
//	SELECT 
//         prodotti.des  
//   	 INTO 
//      	   :k_des  
//    	FROM prodotti 
//   	WHERE codice = :k_codice;
//
//	if sqlca.sqlcode = 0 then
//
//		if messagebox("Prodotto gia' in Archivio", & 
//					"Vuoi modificare la anagrafica "+ &
//					trim(k_des), question!, yesno!, 2) = 1 then
//		
////			tab_1.tabpage_1.dw_1.reset()
//
//			ki_st_open_w.flag_modalita = "mo"
//			ki_st_open_w.key1 = string(k_codice,"@@@@@@@@@@@@")
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
return k_return


end function

on w_listino.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_listino.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event open;call super::open;int k_rc, k_num
long k_cod_cli
string k_rag_soc, k_des, k_cod_art, k_record_base
kuf_base kuf1_base
datawindowchild  kdwc_clienti, kdwc_articoli, kdwc_mc_co, kdwc_sl_pt 
datawindowchild  kdwc_clienti_cod, kdwc_articoli_des, kdwc_mc_co_des, kdwc_sl_pt_des 


	k_cod_cli = long(trim(ki_st_open_w.key1))

//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_1.dw_1.getchild("rag_soc_1", kdwc_clienti)

	k_rc = kdwc_clienti.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		select rag_soc_10 into :k_rag_soc from clienti
		       where codice = :k_cod_cli;
		kdwc_clienti.retrieve(k_rag_soc)
	else
		kdwc_clienti.retrieve("%")
	end if	

	kdwc_clienti.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_cli", kdwc_clienti_cod)

	k_rc = kdwc_clienti_cod.settransobject(sqlca)

	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), &
	       kdwc_clienti.RowCount(), Primary!, kdwc_clienti_cod, 1, Primary!)


//--- Attivo dw archivio Prodotto
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_articoli)

	k_rc = kdwc_articoli.settransobject(sqlca)

//	if ki_st_open_w.flag_modalita = "vi" then
//		k_cod_art = trim(ki_st_open_w.key2)
//		select des into :k_des from prodotti
//		       where codice = :k_cod_art;
//		kdwc_articoli.retrieve(k_des)
//	else
//		kdwc_articoli.retrieve("%")
//	end if
	kdwc_articoli.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_articoli_des)

	k_rc = kdwc_articoli_des.settransobject(sqlca)

	kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), &
	       kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)


//--- Attivo dw archivio MC-CO
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co", kdwc_mc_co)

	k_rc = kdwc_mc_co.settransobject(sqlca)

//	if ki_st_open_w.flag_modalita = "vi" then
//		kdwc_mc_co.retrieve(k_cod_cli, "*")
//	end if
	k_rc = kdwc_mc_co.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co_des", kdwc_mc_co_des)

	k_rc = kdwc_mc_co_des.settransobject(sqlca)
	k_rc = kdwc_mc_co_des.insertrow(1)

	kdwc_mc_co.RowsCopy(kdwc_mc_co.GetRow(), &
	       kdwc_mc_co.RowCount(), Primary!, kdwc_mc_co_des, 1, Primary!)

  
//--- Attivo dw archivio SL-PT
	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)

	k_rc = kdwc_sl_pt.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		kdwc_sl_pt.insertrow(1)
	else
//		kdwc_sl_pt.retrieve("%")
		kdwc_sl_pt.insertrow(1)
	end if

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt_des", kdwc_sl_pt_des)

	k_rc = kdwc_sl_pt_des.settransobject(sqlca)

	kdwc_sl_pt.RowsCopy(kdwc_sl_pt.GetRow(), &
	       kdwc_sl_pt.RowCount(), Primary!, kdwc_sl_pt_des, 1, Primary!)

//--- Imposto i valori della pedana sui campi testo delle dw
	kuf1_base = create kuf_base
	k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
	destroy kuf_base
	if left(k_record_base,1) = "0" then		
		k_num = integer(trim(mid(k_record_base, 2, 5)))
		tab_1.tabpage_1.dw_1.modify("t_mis_x.text='"+string(k_num, "####0")+"'") 		
		k_num = integer(trim(mid(k_record_base, 7, 5)))
		tab_1.tabpage_1.dw_1.modify("t_mis_y.text='"+string(k_num, "####0")+"'") 		
		k_num = integer(trim(mid(k_record_base, 12, 5)))
		tab_1.tabpage_1.dw_1.modify("t_mis_z.text='"+string(k_num, "####0")+"'") 		
	end if


end event
type cb_visualizza from w_g_tab_3`cb_visualizza within w_listino
int X=1179
int Y=1448
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_listino
int X=617
int Y=1444
end type

type st_parametri_menu from w_g_tab_3`st_parametri_menu within w_listino
int X=55
int Y=1428
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_listino
int X=2711
int Y=1444
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_listino
int X=1970
int Y=1444
end type

event cb_aggiorna::clicked;//

//=== Toglie le righe eventualmente da non registrare
pulizia_righe()

//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then
	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
//	dw_dett_0.reset()
//	dw_lista_0.setfocus()
	
	attiva_tasti()
	
////	inserisci()
//	if cb_inserisci.enabled = true then
//		cb_inserisci.triggerevent(clicked!)
//	end if
//
	
end if

end event

type cb_cancella from w_g_tab_3`cb_cancella within w_listino
int X=2341
int Y=1444
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_listino
int X=1600
int Y=1444
boolean Enabled=false
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
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
			
	end choose
	
	if left(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_listino
int X=27
int Y=28
int Width=3040
int Height=1396
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="Articolo"
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
int X=1865
int Y=1128
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
int Width=2967
int Height=1244
string DataObject="d_listino"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event itemchanged;//
date k_data
string k_codice
string k_des
int k_errore=0


choose case dwo.name 
	case "codice" 
		k_codice = tab_1.tabpage_1.dw_1.getitemstring(1, "codice")
		if isnull(k_codice) = false and len(trim(k_codice)) > 0 then
			if check_rek( k_codice ) > 0 then
				k_errore = 1
			end if
		end if
//	case "des" 
//		check_prodotti()
//		k_errore = 1
end choose 

if k_errore = 1 then
	return 2
end if
	
end event

event itemfocuschanged;int k_rc
long k_cod_cli
datawindowchild  kdwc_mc_co, kdwc_mc_co_des
datawindowchild  kdwc_sl_pt, kdwc_articoli 
datawindowchild  kdwc_clienti_cod, kdwc_articoli_des, kdwc_sl_pt_des 


if dwo.name = "cod_mc_co" then
	k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(tab_1.tabpage_1.dw_1.getrow(), "cod_cli")
	
	if ki_st_open_w.flag_modalita <> "vi" and ki_cod_cli <> k_cod_cli then

//--- Attivo dw archivio MC-CO
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co", kdwc_mc_co)
	
		k_rc = kdwc_mc_co.settransobject(sqlca)
	
		ki_cod_cli = k_cod_cli
		kdwc_mc_co.retrieve(k_cod_cli, "*")
		k_rc = kdwc_mc_co.insertrow(1)
	
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co_des", kdwc_mc_co_des)
	
		k_rc = kdwc_mc_co_des.settransobject(sqlca)
		k_rc = kdwc_mc_co_des.insertrow(1)
	
		kdwc_mc_co.RowsCopy(kdwc_mc_co.GetRow(), &
				 kdwc_mc_co.RowCount(), Primary!, kdwc_mc_co_des, 1, Primary!)

//	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_mc_co", kdwc_mc_co)
//	k_rc = kdwc_mc_co.setfilter("cod_cli>0")
// 	k_rc = kdwc_mc_co.filter()
////--- filtra i dati sul cliente
//	k_rc = kdwc_mc_co.setfilter("cod_cli="+ trim(string(k_cod_cli)))
// 	k_rc = kdwc_mc_co.filter()
// 	k_rc = kdwc_mc_co.insertrow(1)
 
	end if 
end if


if dwo.name = "cod_art" then
	if ki_st_open_w.flag_modalita <> "vi" and ki_cod_art <> "%" then

//--- Attivo dw archivio Prodotto
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_articoli)
	
		k_rc = kdwc_articoli.settransobject(sqlca)
	
		ki_cod_art = "%"
		kdwc_articoli.retrieve("%")
		kdwc_articoli.insertrow(1)
	
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_articoli_des)
	
		k_rc = kdwc_articoli_des.settransobject(sqlca)
	
		kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), &
				 kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)

	end if
end if

if dwo.name = "cod_sl_pt" then
	if ki_st_open_w.flag_modalita <> "vi" and ki_sl_pt <> "%" then
  
//--- Attivo dw archivio SL-PT
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)
	
		k_rc = kdwc_sl_pt.settransobject(sqlca)
	
		ki_sl_pt = "%"
		kdwc_sl_pt.retrieve("%")
		kdwc_sl_pt.insertrow(1)
	
		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt_des", kdwc_sl_pt_des)
	
		k_rc = kdwc_sl_pt_des.settransobject(sqlca)
	
		kdwc_sl_pt.RowsCopy(kdwc_sl_pt.GetRow(), &
				 kdwc_sl_pt.RowCount(), Primary!, kdwc_sl_pt_des, 1, Primary!)

	end if
end if
end event
type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
boolean Visible=false
string Text="tab"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
int X=0
int Width=2981
int Height=1228
boolean Visible=false
boolean Enabled=false
boolean HScrollBar=true
boolean VScrollBar=true
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
int Width=2967
int Height=1232
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event dw_3::itemchanged;call super::itemchanged;//



end event

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
int X=5
int Y=24
int Width=2939
int Height=1116
int TabOrder=10
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event buttonclicked;//
//=== Attivo/Disattivo visione grafico
if this.object.kgr_1.visible = "1" then
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Grafico"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "0" 
else
	tab_1.tabpage_4.dw_4.object.kcb_gr.text = "Dati"
	tab_1.tabpage_4.dw_4.object.kgr_1.visible = "1"
end if
//

end event

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
int X=18
int Y=112
int Width=3003
int Height=1268
string Text="tab"
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
int Width=2935
int Height=1172
boolean Visible=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

type ln_1 from line within tabpage_4
boolean Enabled=false
int BeginX=361
int BeginY=2376
int EndX=2674
int EndY=2376
int LineThickness=4
end type

