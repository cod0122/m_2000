$PBExportHeader$w_listino_old.srw
forward
global type w_listino_old from w_g_tab0
end type
end forward

global type w_listino_old from w_g_tab0
int Width=2811
int Height=1540
boolean TitleBar=true
string Title="Listino"
boolean Resizable=false
end type
global w_listino_old w_listino_old

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer inserisci ()
protected subroutine pulizia_righe ()
private subroutine riempi_id ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_codice 
string k_cod_art, k_cod_sl_pt, k_rc1, k_style
int k_ctr, k_rc
int k_importa = 0
real k_dose
long k_mis_x, k_mis_y, k_mis_z
datawindowchild  kdwc_sl_pt 
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

//--- Se inserimento.... 
   if trim(ki_st_open_w.flag_modalita) = "in" then
		inserisci()
	else
		if dw_dett_0.retrieve(k_codice, k_cod_art, k_dose, k_mis_x, k_mis_y, k_mis_z) < 1 then
			k_return = "1Nessun Prezzo Listino Trovato per la richiesta fatta"
	
			SetPointer(oldpointer)
			messagebox("Prezzo Listino", &
					"Nessun Listino Trovato per la richiesta fatta")
	
		else
	
			k_cod_sl_pt = trim(dw_dett_0.getitemstring(1, "cod_sl_pt"))
			if isnull(k_cod_sl_pt) or len(trim(k_cod_sl_pt)) = 0 then
				k_cod_sl_pt = "%"
			end if
	
//--- Attivo dw archivio SL_PT
			dw_dett_0.getchild("cod_sl_pt", kdwc_sl_pt)
	
			kdwc_sl_pt.settransobject(sqlca)
		
			if ki_st_open_w.flag_modalita = "vi" then
				kdwc_sl_pt.retrieve(k_cod_sl_pt)
				kdwc_sl_pt.insertrow(1)
			end if
			
		end if
	end if

//--- Inabilita campi alla modifica se Vsualizzazione
   if trim(ki_st_open_w.flag_modalita) = "vi" then
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
		//???? non so perche' ma provo cosi
	 	k_rc1=dw_dett_0.Modify("cod_mc_co.TabSequence='0'")
	end if

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
   if trim(ki_st_open_w.flag_modalita) = "mo" then
		k_rc1=dw_dett_0.Modify("rag_soc_1.TabSequence='0'")
//		k_rc1=string(rgb(192,192,192))
//		dw_dett_0.Modify("cod_cli.Background.Color='"+k_rc1+"'")
	end if
	


return k_return



end function
private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = " ", k_errore = "0"
int k_rc=0
long k_cod_cli1, k_cod_cli
string k_cod_art


//--- controllo se rec già esistente

   k_cod_cli = dw_dett_0.getitemnumber(1, "cod_cli")
   k_cod_art = dw_dett_0.getitemstring(1, "cod_art")

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
		
		if ki_st_open_w.flag_modalita = "mo" then
	
			k_return = "Prezzo Listino non trovato in Archivio"
			k_errore = "1"

		end if  


	end if

//-- Controllo esistenza minima dei dati
	if k_errore = "0" then
		if isnull(dw_dett_0.getitemnumber ( 1, "cod_cli")) = true &
		   or dw_dett_0.getitemnumber ( 1, "cod_cli") = 0 then
			k_return = "Manca Cliente " + "~n~r" 
			k_errore = "3"
		end if
		if isnull(dw_dett_0.getitemstring ( 1, "cod_art")) = true &
		   or len(trim(dw_dett_0.getitemstring ( 1, "cod_art"))) = 0 then
			k_return = k_return + "Manca Articolo "  + "~n~r" 
			k_errore = "3"
		end if
	end if

//-- Non tollerati i campo a NULL
	if k_errore = "0" then
      if isnull(dw_dett_0.getitemnumber(1, "dose")) then 
         dw_dett_0.setitem(1, "dose", 0)
      end if
		if isnull(dw_dett_0.getitemnumber(1, "mis_x")) then
			dw_dett_0.setitem(1, "mis_x", 0)
		end if
		if isnull(dw_dett_0.getitemnumber(1, "mis_y")) then
			dw_dett_0.setitem(1, "mis_x", 0)
		end if
		if isnull(dw_dett_0.getitemnumber(1, "mis_z")) then
			dw_dett_0.setitem(1, "mis_z", 0)
		end if
		if isnull(dw_dett_0.getitemnumber(1, "occup_ped")) then
			dw_dett_0.setitem(1, "occup_ped", 0)
		end if
		if isnull(dw_dett_0.getitemnumber(1, "peso_kg")) then
			dw_dett_0.setitem(1, "peso_kg", 0)
		end if
		if isnull(dw_dett_0.getitemstring(1, "campione")) then
			dw_dett_0.setitem(1, "campione", "N")
		end if
		if isnull(dw_dett_0.getitemstring(1, "travaso")) then
			dw_dett_0.setitem(1, "travaso", "N")
		end if
		if isnull(dw_dett_0.getitemnumber(1, "magazzino")) then
			dw_dett_0.setitem(1, "magazzino", 0)
		end if
		if isnull(dw_dett_0.getitemstring(1, "cod_mc_co")) then
			dw_dett_0.setitem(1, "cod_mc_co", " ")
		end if
		if isnull(dw_dett_0.getitemstring(1, "cod_sl_pt")) then
			dw_dett_0.setitem(1, "cod_sl_pt", " ")
		end if
	end if
	
return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
string k_return="0 "
string k_cod_art
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
real k_dose
long k_cod_cli, k_mis_x, k_mis_y, k_mis_z
kuf_listino  kuf1_listino


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_cod_cli = dw_dett_0.getitemnumber(1, "cod_cli")
	k_cod_art = dw_dett_0.getitemstring(1, "cod_art")
	k_dose = dw_dett_0.getitemnumber(k_riga, "dose")
	k_mis_x = dw_dett_0.getitemnumber(k_riga, "mis_x")
	k_mis_y = dw_dett_0.getitemnumber(k_riga, "mis_y")
	k_mis_z = dw_dett_0.getitemnumber(k_riga, "mis_z")

end if
if k_riga > 0 and isnull(k_cod_cli) = false then	
	if isnull(k_cod_art) = true or trim(k_cod_art) = "" then
		k_cod_art = "Prezzo Listino senza Articolo" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Prezzo Listino", "Sei sicuro di voler Cancellare : ~n~r" + &
				string(k_cod_cli, "####0") + " " + trim(k_cod_art), &
				question!, yesno!, 1) = 1 then
 
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
		destroy kuf1_listino

	else
		messagebox("Elimina Prezzo Listino", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
end function

protected function integer inserisci ();//
int k_return=0
string k_cod_art
long k_cod_cli
string k_record_base
kuf_base kuf1_base


k_cod_cli = long(trim(ki_st_open_w.key1))
k_cod_art = trim(ki_st_open_w.key2)

dw_dett_0.insertrow(0)

dw_dett_0.setitem(1, "cod_cli", K_cod_cli)
dw_dett_0.setitem(1, "cod_art", K_cod_art)

dw_dett_0.setitem(1, "attivo", "S")
dw_dett_0.setitem(1, "magazzino", 2)
dw_dett_0.setitem(1, "prezzo", 0)

kuf1_base = create kuf_base
k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
destroy kuf_base
if left(k_record_base,1) = "0" then			
	dw_dett_0.setitem(1, "mis_x", integer(trim(mid(k_record_base, 2, 5)))) 		
	dw_dett_0.setitem(1, "mis_y", integer(trim(mid(k_record_base, 7, 5)))) 		
	dw_dett_0.setitem(1, "mis_z", integer(trim(mid(k_record_base, 12, 5)))) 		
	dw_dett_0.setitem(1, "occup_ped", 100)
	
end if
	
dw_dett_0.setcolumn(2)



return k_return

end function

protected subroutine pulizia_righe ();//
//=== Oltre a confermare ACCEPTTEXT toglie righe da non UPDATE

string k_cod_art
long k_cod_cli
long k_riga, k_ctr


dw_dett_0.accepttext()

//=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
k_riga = dw_dett_0.rowcount ( )
if k_riga > 0 then
	
//	k_ctr = dw_dett_0.getrow()
   k_ctr = 1
	
	k_cod_cli = dw_dett_0.getitemnumber(k_ctr, "cod_cli") 
 	if isnull(k_cod_cli) or k_cod_cli = 0 then
		dw_dett_0.deleterow(k_ctr)
	end if
	k_cod_art = dw_dett_0.getitemstring(k_ctr, "cod_art") 
 	if isnull(k_cod_art) or len(trim(k_cod_art)) = 0 then
		dw_dett_0.deleterow(k_ctr)
	end if
	
end if


end subroutine

private subroutine riempi_id ();//
//=== Imposta campi di default

	dw_dett_0.setitem(1, "k_pwd", trim(string(kg_pwd)))

end subroutine
on w_listino_old.create
call super::create
end on

on w_listino_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event resize;//
	this.setredraw(false)
//	tab_1.tabpage_art.dw_dett_1.width = dw_lista_0.width
//	tab_1.tabpage_scade.dw_dett_2.width = dw_lista_0.width
	this.setredraw(true)


end event

event open;call super::open;int k_rc, k_num
long k_cod_cli
string k_rag_soc, k_des, k_cod_art, k_record_base
kuf_base kuf1_base
datawindowchild  kdwc_clienti, kdwc_articoli, kdwc_mc_co, kdwc_sl_pt 
datawindowchild  kdwc_clienti_cod, kdwc_articoli_des, kdwc_mc_co_des, kdwc_sl_pt_des 


	k_cod_cli = long(trim(ki_st_open_w.key1))

//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("rag_soc_1", kdwc_clienti)

	k_rc = kdwc_clienti.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		select rag_soc_10 into :k_rag_soc from clienti
		       where codice = :k_cod_cli;
		kdwc_clienti.retrieve(k_rag_soc)
	else
		kdwc_clienti.retrieve("%")
	end if	

	kdwc_clienti.insertrow(1)

	k_rc = dw_dett_0.getchild("cod_cli", kdwc_clienti_cod)

	k_rc = kdwc_clienti_cod.settransobject(sqlca)

	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), &
	       kdwc_clienti.RowCount(), Primary!, kdwc_clienti_cod, 1, Primary!)


//--- Attivo dw archivio Prodotto
	k_rc = dw_dett_0.getchild("cod_art", kdwc_articoli)

	k_rc = kdwc_articoli.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		k_cod_art = trim(ki_st_open_w.key2)
		select des into :k_des from prodotti
		       where codice = :k_cod_art;
		kdwc_articoli.retrieve(k_des)
	else
		kdwc_articoli.retrieve("%")
	end if
	kdwc_articoli.insertrow(1)

	k_rc = dw_dett_0.getchild("cod_art_des", kdwc_articoli_des)

	k_rc = kdwc_articoli_des.settransobject(sqlca)

	kdwc_articoli.RowsCopy(kdwc_articoli.GetRow(), &
	       kdwc_articoli.RowCount(), Primary!, kdwc_articoli_des, 1, Primary!)


//--- Attivo dw archivio MC-CO
	k_rc = dw_dett_0.getchild("cod_mc_co", kdwc_mc_co)

	k_rc = kdwc_mc_co.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		kdwc_mc_co.retrieve(k_cod_cli, "*")
	else
		kdwc_mc_co.retrieve(0, "*")
	end if
	k_rc = kdwc_mc_co.insertrow(1)

	k_rc = dw_dett_0.getchild("cod_mc_co_des", kdwc_mc_co_des)

	k_rc = kdwc_mc_co_des.settransobject(sqlca)
	k_rc = kdwc_mc_co_des.insertrow(1)

	kdwc_mc_co.RowsCopy(kdwc_mc_co.GetRow(), &
	       kdwc_mc_co.RowCount(), Primary!, kdwc_mc_co_des, 1, Primary!)

//--- filtra i dati sul cliente
	kdwc_mc_co.setfilter("cod_cli="+ trim(string(k_cod_cli)))
 	kdwc_mc_co.filter()
	k_rc = kdwc_mc_co.insertrow(1)
  
//--- Attivo dw archivio SL-PT
	k_rc = dw_dett_0.getchild("cod_sl_pt", kdwc_sl_pt)

	k_rc = kdwc_sl_pt.settransobject(sqlca)

	if ki_st_open_w.flag_modalita = "vi" then
		kdwc_sl_pt.insertrow(1)
	else
		kdwc_sl_pt.retrieve("%")
		kdwc_sl_pt.insertrow(1)
	end if

	k_rc = dw_dett_0.getchild("cod_sl_pt_des", kdwc_sl_pt_des)

	k_rc = kdwc_sl_pt_des.settransobject(sqlca)

	kdwc_sl_pt.RowsCopy(kdwc_sl_pt.GetRow(), &
	       kdwc_sl_pt.RowCount(), Primary!, kdwc_sl_pt_des, 1, Primary!)

//--- Imposto i valori della padana sui campi testo dell dw
	kuf1_base = create kuf_base
	k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
	destroy kuf_base
	if left(k_record_base,1) = "0" then		
		k_num = integer(trim(mid(k_record_base, 2, 5)))
		dw_dett_0.modify("t_mis_x.text='"+string(k_num, "####0")+"'") 		
		k_num = integer(trim(mid(k_record_base, 7, 5)))
		dw_dett_0.modify("t_mis_y.text='"+string(k_num, "####0")+"'") 		
		k_num = integer(trim(mid(k_record_base, 12, 5)))
		dw_dett_0.modify("t_mis_z.text='"+string(k_num, "####0")+"'") 		
	end if


end event

type cb_visualizza from w_g_tab0`cb_visualizza within w_listino_old
int X=2354
boolean Visible=false
end type

type cb_modifica from w_g_tab0`cb_modifica within w_listino_old
int X=2350
int Y=908
boolean Visible=false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_listino_old
int X=9
int Y=4
int Width=2578
int Height=576
boolean Visible=false
boolean Enabled=false
boolean HScrollBar=false
boolean VScrollBar=false
boolean HSplitScroll=false
boolean LiveScroll=false
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_listino_old
int X=2350
int Y=1200
boolean Visible=false
end type

type cb_cancella from w_g_tab0`cb_cancella within w_listino_old
int X=2350
int Y=1052
boolean Visible=false
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_listino_old
int X=2350
int Y=768
boolean Visible=false
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_listino_old
int X=2350
int Y=1308
boolean Visible=false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_listino_old
int X=27
int Y=28
int Width=2752
int Height=1304
string DataObject="d_listino"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

event itemfocuschanged;int k_rc
long k_cod_cli
datawindowchild  kdwc_mc_co


if dwo.name = "cod_mc_co" and ki_st_open_w.flag_modalita <> "vi" then 

	k_cod_cli = dw_dett_0.getitemnumber(dw_dett_0.getrow(), "cod_cli")

	k_rc = dw_dett_0.getchild("cod_mc_co", kdwc_mc_co)
	k_rc = kdwc_mc_co.setfilter("cod_cli>0")
 	k_rc = kdwc_mc_co.filter()
//--- filtra i dati sul cliente
	k_rc = kdwc_mc_co.setfilter("cod_cli="+ trim(string(k_cod_cli)))
 	k_rc = kdwc_mc_co.filter()
 	k_rc = kdwc_mc_co.insertrow(1)
 
end if 

end event

event dw_dett_0::editchanged;//
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_listino_old
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_listino_old
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_listino_old
boolean BringToTop=true
end type

