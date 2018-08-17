$PBExportHeader$w_commessa_l.srw
forward
global type w_commessa_l from w_g_tab0
end type
type cb_costi from commandbutton within w_commessa_l
end type
type ddlb_2 from dropdownlistbox within w_commessa_l
end type
type tab_1 from tab within w_commessa_l
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_dett_1 from datawindow within tabpage_2
end type
type cb_fatt_acq from commandbutton within w_commessa_l
end type
type cb_stat from commandbutton within w_commessa_l
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
dw_dett_1 dw_dett_1
end type
type tab_1 from tab within w_commessa_l
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_commessa_l from w_g_tab0
int Width=2899
int Height=1405
WindowType WindowType=main!
boolean TitleBar=true
string Title="Lista Commesse"
boolean MaxBox=true
cb_costi cb_costi
ddlb_2 ddlb_2
tab_1 tab_1
cb_fatt_acq cb_fatt_acq
cb_stat cb_stat
end type
global w_commessa_l w_commessa_l

forward prototypes
protected subroutine forma_elenco ()
private function string inizializza ()
private subroutine stampa ()
private function string leggi_liste ()
private function string dati_modif ()
private function integer check_rek ()
private function string cancella ()
protected function integer inserisci ()
private subroutine attiva_tasti ()
end prototypes

protected subroutine forma_elenco ();////
//string k_flag
//
//
//	k_flag = "0" //non visibile
//
//	dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
//	dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
//	dw_lista_0.Modify("tel_num.Visible=" + k_flag)
//	dw_lista_0.Modify("fax_num.Visible=" + k_flag)
//	dw_lista_0.Modify("modem.Visible=" + k_flag)
//	dw_lista_0.Modify("e_mail.Visible=" + k_flag)
//	dw_lista_0.Modify("prov.Visible=" + k_flag)
//	dw_lista_0.Modify("localita.Visible=" + k_flag)
//	dw_lista_0.Modify("cap.Visible=" + k_flag)
//	dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
//	dw_lista_0.Modify("at_note.Visible=" + k_flag)
////	dw_lista_0.Modify("tipo.Visible=" + k_flag)
//
//	k_flag = "1" // visibile
//
////	dw_lista_0.Modify("tipo.Visible=" + k_flag)
//
////=== Rivisualizza i dati in un ordine diverso
// 	if ddlb_elenco.text = "Rubrica" then
//		dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
//		dw_lista_0.Modify("tel_num.Visible=" + k_flag)
//		dw_lista_0.Modify("fax_num.Visible=" + k_flag)
//		dw_lista_0.Modify("localita.Visible=" + k_flag)
//		dw_lista_0.Modify("prov.Visible=" + k_flag)
//		dw_lista_0.Modify("modem.Visible=" + k_flag)
//		dw_lista_0.Modify("e_mail.Visible=" + k_flag)
//		dw_lista_0.Modify("at_note.Visible=" + k_flag)
//		dw_lista_0.Modify("cap.Visible=" + k_flag)
//		dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
//		dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
//
//	else
//	 	if ddlb_elenco.text = "Completa" then
//			dw_lista_0.Modify("id_cliente.Visible=" + k_flag)
//			dw_lista_0.Modify("rag_soc_1.Visible=" + k_flag)
//			dw_lista_0.Modify("localita.Visible=" + k_flag)
//			dw_lista_0.Modify("prov.Visible=" + k_flag)
//			dw_lista_0.Modify("indirizzo.Visible=" + k_flag)
//			dw_lista_0.Modify("cap.Visible=" + k_flag)
//			dw_lista_0.Modify("tel_num.Visible=" + k_flag)
//			dw_lista_0.Modify("fax_num.Visible=" + k_flag)
//			dw_lista_0.Modify("modem.Visible=" + k_flag)
//		dw_lista_0.Modify("e_mail.Visible=" + k_flag)
//			dw_lista_0.Modify("at_note.Visible=" + k_flag)
//		end if
//	end if
//
//
end subroutine

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
long k_anno, k_nro, k_id_cliente
int k_importa = 0
char k_stato
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_nro = long(trim(mid(st_parametri.text, 3, 20)))
	k_anno = long(mid(st_parametri.text, 50, 4))
	k_stato = mid(st_parametri.text, 54, 1)
	k_id_cliente = long(mid(st_parametri.text, 55, 10))
	if isnull(k_anno) then
		k_anno = year(today())
	end if
	if isnull(k_stato) then
			k_stato = "*"
			ddlb_2.text = ddlb_2.item[1]
	end if
	if isnull(k_id_cliente) then
			k_id_cliente = 0
	end if
//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_key = mid(st_parametri.text, 3, 20) + mid(st_parametri.text, 50)
		k_importa = kuf1_data_base.dw_importfile(k_key, dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_nro, k_anno, k_stato, k_id_cliente) < 1 then
			k_return = "1Non trovate Commesse "

			SetPointer(oldpointer)
			messagebox("Lista Commesse Vuota", &
					"Nesun Codice Trovato per la richiesta fatta")
					
			cb_ritorna.postevent(clicked!)

		end if		
	end if


return k_return



end function

private subroutine stampa ();//
long k_num_riga, k_riga
string k_stampa, k_rag_soc, k_tipo
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


		
kuf1_data_base.stampa_dw(dw_lista_0, k_stampa, 0)
		

end subroutine

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


	choose case tab_1.selectedtab
	
		case 1 //si riposiziona poi sulla stessa riga
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

//		case 2
//			k_riga = tab_1.tabpage_art.dw_dett_1.getrow()
//			tab_1.tabpage_art.dw_dett_1.reset()
//			leggi_contatti()
//			
//			if k_riga > tab_1.tabpage_art.dw_dett_1.rowcount() then
//				k_riga = tab_1.tabpage_art.dw_dett_1.rowcount() 
//			end if
//			if k_riga > 0 then
//				tab_1.tabpage_art.dw_dett_1.scrolltorow(k_riga)
//				tab_1.tabpage_art.dw_dett_1.setrow(k_riga)
//				tab_1.tabpage_art.dw_dett_1.selectrow(0 , false)
//				tab_1.tabpage_art.dw_dett_1.selectrow(k_riga , false)
//			end if
//
//		case 3
//			k_riga = tab_1.tabpage_scade.dw_dett_2.getrow()
//			tab_1.tabpage_scade.dw_dett_2.reset()
//			leggi_prot()
//			
//			if k_riga > tab_1.tabpage_scade.dw_dett_2.rowcount() then
//				k_riga = tab_1.tabpage_scade.dw_dett_2.rowcount() 
//			end if
//			if k_riga > 0 then
//				tab_1.tabpage_scade.dw_dett_2.scrolltorow(k_riga)
//				tab_1.tabpage_scade.dw_dett_2.setrow(k_riga)
//			end if
//
	end choose
	
	
return k_return




end function

private function string dati_modif ();//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
//int k_msg
//string k_key
//
//
//
//	tab_1.tabpage_scade.dw_dett_2.accepttext()
//
////	if cb_aggiorna.enabled = true then
//		
//		if tab_1.tabpage_scade.dw_dett_2.getnextmodified ( 0, primary!) > 0 then
//
//			k_msg = messagebox("Dati Protocollo Modificati", "Vuoi Salvare gli Aggiornamenti ?", &
//					question!, yesnocancel!, 1)
//
//			k_return = string(k_msg, "0")
//			
//		end if
////	end if
//
//
return k_return
end function

private function integer check_rek ();////
int k_return = 0
//date k_data
//datetime k_data_1
//int k_anno, k_riga, k_riga_fine
//long k_id_protocollo, k_id_protocollo_1
//string k_descrizione, k_rag_soc
//
//
////tab_1.tabpage_scade.accepttext()
////k_id_protocollo = trim(tab_1.tabpage_scade.getitemstring(tab_1.tabpage_scade.getrow(), "id_protocollo"))
//
//k_riga =	tab_1.tabpage_scade.dw_dett_2.getrow()
//
//k_id_protocollo = long(tab_1.tabpage_scade.dw_dett_2.gettext())
//k_data = tab_1.tabpage_scade.dw_dett_2.getitemdate(k_riga, "data")
//
//if k_id_protocollo > 0 and isnull(k_data) = false and &
//	string(k_data, "dd/mm/yy") <> "00/00/00" and &
//	(tab_1.tabpage_scade.dw_dett_2.getitemstatus(&
//											k_riga, 0, primary!) = new! or &
//	 tab_1.tabpage_scade.dw_dett_2.getitemstatus(&
//	 										k_riga, 0, primary!) = newmodified!) &
//	then
////	tab_1.tabpage_scade.getitemstatus(tab_1.tabpage_scade.getrow(), "id_protocollo", primary!) = datamodified! then
//
//	k_anno = year(k_data)
//
////=== Cerco prima nella lista e dopo in archivio
//	k_riga_fine = k_riga - 1
//	if tab_1.tabpage_scade.dw_dett_2.find("id_protocollo = " + &
//					string(k_id_protocollo, "#####") + &
//					" and year(data) = " + string(k_anno, "00"), 0, k_riga_fine ) > 0 then
//
//		messagebox("Operazione non consentita", "OK!, dai un occhio alla lista,~n~r"+ &
//				"il protocollo e' gia stato inserito con stesso n.ro e anno", & 
//				question!, ok!)
//
//		k_return = 1
//	else
//	
//		SELECT "protocolli"."id_protocollo",   
//      	    "protocolli"."data",
//         	 "protocolli"."descrizione",
//				 "clienti"."rag_soc_1"
//   	 INTO :k_id_protocollo_1,   
//      	   :k_data_1,
//      	   :k_descrizione,
//				:k_rag_soc 
//    	FROM {oj "protocolli" left outer join "clienti" on
//		 		"protocolli"."id_cliente" = "clienti"."id_cliente"}
//   	WHERE "protocolli"."id_protocollo" = :k_id_protocollo and
//   			year("protocolli"."data") = :k_anno  ;
//
//		if k_id_protocollo = k_id_protocollo_1 then
//			if isnull(k_descrizione) then
//				k_descrizione = "generico"
//			end if
//			if isnull(k_rag_soc) then
//				k_rag_soc = "Anagrafica non specificata o non trovata"
//			end if
//			messagebox("Operazione non consentita", "Protocollo gia' in archivio~n~r"+ &
//					"il " + string(k_data, "dd-mm-yy") + " " + &
//					trim(k_descrizione) + "~n~r" + &
//					"recapitato a " + trim(k_rag_soc), &
//					question!, ok!)
//
//			k_return = 1
//		end if
//	end if  
//
//	attiva_tasti()
//else
//	k_return = 1
//
//end if
//
//
return k_return
//
end function

private function string cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record
long k_key
string k_errore = "0 ", k_errore1 = "0 "
long k_riga, k_nro
date k_data
kuf_commesse  kuf1_commesse


//=== 
choose case tab_1.selectedtab 
	case 1 
		k_riga = dw_lista_0.getrow()	
		if k_riga > 0 then
			k_key = dw_lista_0.getitemnumber(k_riga, "id_commessa")
			k_nro = dw_lista_0.getitemnumber(k_riga, "nro_commessa")
			k_data = dw_lista_0.getitemdate(k_riga, "data")
			k_desc = dw_lista_0.getitemstring(k_riga, "titolo")
		end if
end choose	

//=== Se righe in lista
if k_riga > 0 and isnull(k_key) = false then

	if isnull(k_desc) = true or trim(k_desc) = "" then
		k_desc = "Commessa senza Titolo" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, &
		"Sei sicuro di voler eliminare la Commessa~n~r" + &
		string(k_nro, "##,###") + " del " + string(k_data, "dd-mm-yy") + "~n~r" + &
		trim(k_desc),  &
		question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_commesse = create kuf_commesse
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kuf1_commesse.tb_delete(k_key) 
			case 2
		end choose	
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						dw_lista_0.deleterow(k_riga)
					case 2
				end choose	

			end if

		else
			k_return = 1
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
		destroy kuf1_commesse

	else
		messagebox("Elimina Commessa",  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		dw_lista_0.setfocus()
		dw_lista_0.setcolumn(1)
end choose	


return string(k_return)


end function

protected function integer inserisci ();//
int k_errore,  k_ctr
long k_id_commessa
string k_parametri


k_ctr = dw_lista_0.getrow() 
if k_ctr > 0 then 
	
	k_id_commessa = dw_lista_0.getitemnumber(k_ctr, "id_commessa") 
				
//
//=== Ausiliari (scelta (2)+ key commessa(20) + 
//===				's'=adatta dim. wind.(1) + libero-standard-futuri (25) + libero personalizzazioni
	k_parametri = "in" + + space(20) + &
						KK_ADATTA_WIN + space(26) 
	w_main.open_w_tabelle("cm "+ k_parametri)

else
	messagebox("Nessuna Operazione eseguita", &
					"Selezionare una riga dalla lista Commesse")
end if	
	
	
	
return (0)
	
	
	

end function

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_ritorna.enabled = true

cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false

cb_costi.enabled = false
cb_fatt_acq.enabled = false
cb_stat.enabled = false

//=== Nr righe ne DW lista
if dw_lista_0.getrow ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true

	cb_costi.enabled = true
	cb_fatt_acq.enabled = true
	cb_stat.enabled = true
	
end if

//=== Nr righe ne DW lista
if dw_dett_0.getrow ( ) > 0 and dw_dett_0.enabled = true then
	cb_cancella.enabled = true
	cb_aggiorna.enabled = true
end if
            


end subroutine

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

on w_commessa_l.create
int iCurrent
call w_g_tab0::create
this.cb_costi=create cb_costi
this.ddlb_2=create ddlb_2
this.tab_1=create tab_1
this.cb_fatt_acq=create cb_fatt_acq
this.cb_stat=create cb_stat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_costi
this.Control[iCurrent+2]=ddlb_2
this.Control[iCurrent+3]=tab_1
this.Control[iCurrent+4]=cb_fatt_acq
this.Control[iCurrent+5]=cb_stat
end on

on w_commessa_l.destroy
call w_g_tab0::destroy
destroy(this.cb_costi)
destroy(this.ddlb_2)
destroy(this.tab_1)
destroy(this.cb_fatt_acq)
destroy(this.cb_stat)
end on

event key;call super::key;//
//=== Controllo quale tasto da tastiera ha premuto
//
choose case key
	case keypagedown!
		if tab_1.selectedtab = 1 then
			tab_1.selectedtab = 2
		else
			if tab_1.selectedtab = 2 then
				tab_1.selectedtab = 3
			else
				tab_1.selectedtab = 1
			end if
		end if

	case keypageup!
		if tab_1.selectedtab = 1 then
			tab_1.selectedtab = 3
		else
			if tab_1.selectedtab = 2 then
				tab_1.selectedtab = 1
			else
				tab_1.selectedtab = 2
			end if
		end if
end choose


end event

event resize;call super::resize;//

if tab_1.visible = true then
	this.setredraw(false)

//=== Dimensione dw nella window 
	tab_1.width = this.width - 60

//=== Posiziona TAB nel WIN
	tab_1.x = (this.width - tab_1.width) / 4
//	tab_1.y = (this.height - tab_1.height) / 7

//=== Dimensiona dw nel tab
	choose case tab_1.selectedtab
		case 1	
			dw_lista_0.width = tab_1.tabpage_1.width - 30
//			tab_1.tabpage_1.dw_1.height = tab_1.tabpage_1.height - 30
//		case 2
//			tab_1.tabpage_2.dw_2.width = tab_1.tabpage_2.width - 30
//			tab_1.tabpage_2.dw_2.height = tab_1.tabpage_2.height - 30
//		case 3
//			tab_1.tabpage_3.dw_3.width = tab_1.tabpage_3.width - 30
//			tab_1.tabpage_3.dw_3.height = tab_1.tabpage_3.height - 30
//		case 4
//			tab_1.tabpage_4.dw_4.width = tab_1.tabpage_4.width - 30
//			tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.height - 30
	end choose
	
	this.setredraw(true)
end if



end event

event open;call super::open;//
	choose case mid(st_parametri.text,54,1)
		case "*" 
			ddlb_2.text = ddlb_2.item[1]
		case "0" 
			ddlb_2.text = ddlb_2.item[2]
		case "4" 
			ddlb_2.text = ddlb_2.item[3]
		case "8" 
			ddlb_2.text = ddlb_2.item[4]
	end choose


end event

type st_parametri from w_g_tab0`st_parametri within w_commessa_l
int X=229
int Y=1105
boolean BringToTop=true
end type

type cb_modifica from w_g_tab0`cb_modifica within w_commessa_l
int X=1738
int Y=1181
int Height=97
int TabOrder=80
boolean Default=false
end type

event cb_modifica::clicked;//
int k_errore,  k_ctr
long k_id_commessa
string k_parametri


k_ctr = dw_lista_0.getrow() 
if k_ctr > 0 then 
	
	k_id_commessa = dw_lista_0.getitemnumber(k_ctr, "id_commessa") 
				
//
//=== Ausiliari (scelta (2)+ key commessa(20) + 
//===				's'=adatta dim. wind.(1) + libero-standard-futuri (25) + libero personalizzazioni
	k_parametri = "mo" + string(k_id_commessa, "0000000000") + space(10) + &
						KK_ADATTA_WIN + space(26) 
	w_main.open_w_tabelle("cm "+ k_parametri)

else
	messagebox("Nessuna Operazione eseguita", &
					"Selezionare una riga dalla lista Commesse")
end if	
	
	
	
	
	

end event

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_commessa_l
int X=28
int Y=133
int Width=2807
int Height=909
int TabOrder=20
string DataObject="d_comm_l"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_commessa_l
int X=325
int Y=1169
int Height=97
int TabOrder=130
boolean Visible=false
end type

event cb_aggiorna::clicked;//
//=== Aggiornamento dei dati inseriti/modificati
if left(aggiorna_dati(), 1) = "0" then

	messagebox("Operazione eseguita", "Dati aggiornati correttamente")
	
end if

end event

type cb_cancella from w_g_tab0`cb_cancella within w_commessa_l
int X=2126
int Y=1181
int Height=97
int TabOrder=90
end type

event cb_cancella::clicked;//
if tab_1.selectedtab = 1 then
	cancella()
//else
//	if tab_1.selectedtab = 2 then
//		cancella_contatti	()
//	else
//		if tab_1.selectedtab = 3 then
//			cancella_prot ()
//		end if
//	end if
end if

end event

type cb_inserisci from w_g_tab0`cb_inserisci within w_commessa_l
int X=1349
int Y=1181
int Height=97
int TabOrder=70
boolean Enabled=false
string Text="&Nuova"
end type

event cb_inserisci::clicked;//
choose case tab_1.selectedtab
	case 1
		inserisci()
end choose



end event

type cb_ritorna from w_g_tab0`cb_ritorna within w_commessa_l
int X=2515
int Y=1181
int Height=93
int TabOrder=100
boolean Cancel=true
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_commessa_l
int X=2062
int Y=977
int Width=490
int Height=225
int TabOrder=30
boolean Visible=false
string DataObject="d_clienti_l_1"
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

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_commessa_l
int X=449
int Y=121
int TabOrder=50
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_commessa_l
int TabOrder=60
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_commessa_l
int TabOrder=110
boolean BringToTop=true
end type

type cb_costi from commandbutton within w_commessa_l
event clicked pbm_bnclicked
int X=494
int Y=1077
int Width=449
int Height=69
int TabOrder=120
boolean Enabled=false
string Text="C&osti"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
string k_where
long k_id_commessa
char k_stato


if dw_lista_0.getrow() > 0 then

	k_stato = dw_lista_0.getitemstring( &
						dw_lista_0.getrow(), "stato") 
	
	if k_stato = "4" or k_stato = "5" or k_stato = "6" or k_stato = "7" then 

		k_id_commessa = dw_lista_0.getitemnumber( &
				dw_lista_0.getrow(), "id_commessa") 
//
//=== 2 scelta co=tabulatore su commessa, ci=tab su clienti interni, ce=tab su cl. est, ar=tab su articoli 
//=== 10 id_commessa + 10 liberi + s=ridim windows + dalla 50 : id_cliente interno (collaboratore) 10 +
//=== 10 id_cliente esterno + 20 id_articolo  
		w_main.open_w_tabelle("lv "+"co" + string(k_id_commessa, "0000000000") + &
								space(10) + KK_ADATTA_WIN + space(26) + & 
								space(10) +	space(10) + space(20))
								
	else							
		messagebox("Operazione non consentita", &
					"La Commessa non e' nello stato 'Operativo'", &
					stopsign!, ok!)
	end if
else

	messagebox("Nessuna Commessa da ricercare", "Selezionare una riga dalla lista")

end if

end event

type ddlb_2 from dropdownlistbox within w_commessa_l
event selectionchanged pbm_cbnselchange
int X=28
int Y=1069
int Width=421
int Height=393
int TabOrder=40
string Text="Operative"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Tutte le commesse",&
"Nuove",&
"Attesa",&
"Operative",&
"Concluse"}
end type

event selectionchanged;//

choose case index 
		
	case 1 
		dw_lista_0.setfilter("")
		st_parametri.text = replace(st_parametri.text, 54, 1, "*")

	case 2
//=== Visualizza solo in Stato di Creazione
		dw_lista_0.setfilter("stato = '0'")
		st_parametri.text = replace(st_parametri.text, 54, 1, "0")
	case 3
//=== Visualizza solo in Stato di Attesa
		dw_lista_0.setfilter("stato = '1'")
		st_parametri.text = replace(st_parametri.text, 54, 1, "1")
	case 4
//=== Visualizza solo le Operative
		dw_lista_0.setfilter("stato = '4'")
		st_parametri.text = replace(st_parametri.text, 54, 1, "4")
	case 5
//=== Visualizza solo le Conclusa
		dw_lista_0.setfilter("stato = '8'")
		st_parametri.text = replace(st_parametri.text, 54, 1, "8")
		
end choose

dw_lista_0.filter()

end event

type tab_1 from tab within w_commessa_l
event selectionchanged pbm_tcnselchanged
event key pbm_tcnkeydown
event ue_rbuttondown pbm_rbuttondown
event create ( )
event destroy ( )
int Y=13
int Width=2858
int Height=1049
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event selectionchanged;//
if newindex = 1 then
	dw_lista_0.visible = true
	dw_lista_0.setfocus()
	cb_modifica.enabled = true
	cb_aggiorna.enabled = false
	ddlb_2.enabled = true
else
//	dw_lista_0.visible = false
//	if newindex = 2 then
//		ddlb_elenco.enabled = false
//		ddlb_cli.enabled = false
//		cb_aggiorna.enabled = false
//		cb_modifica.enabled = true
//		leggi_contatti ()
//	else
//		if newindex = 3 then
//			cb_aggiorna.enabled = true
//			cb_modifica.enabled = false
//			ddlb_elenco.enabled = false
//			ddlb_cli.enabled = false
//			leggi_prot ()
//		end if
//	end if
end if
end event

event key;//
parent.trigger event key (key, 0)

end event

event ue_rbuttondown;//
parent.postevent("rbuttondown")

end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={ this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
int X=19
int Y=109
int Width=2821
int Height=925
long BackColor=12632256
string Text="Commesse"
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
end type

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=19
int Y=109
int Width=2821
int Height=925
boolean Visible=false
long BackColor=12632256
long TabBackColor=12632256
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_dett_1 dw_dett_1
end type

on tabpage_2.create
this.dw_dett_1=create dw_dett_1
this.Control[]={ this.dw_dett_1}
end on

on tabpage_2.destroy
destroy(this.dw_dett_1)
end on

type dw_dett_1 from datawindow within tabpage_2
event clicked pbm_dwnlbuttonclk
event dberror pbm_dwndberror
event getfocus pbm_dwnsetfocus
event rbuttondown pbm_dwnrbuttondown
event ue_dwnkey pbm_dwnkey
int X=5
int Y=9
int Width=2807
int Height=893
int TabOrder=2
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event clicked;//
string k_name
long k_colore


This.SetRow(row)
This.SelectRow(0, FALSE)
if row > 0 then
	This.SelectRow(row, TRUE)

else

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
		
		dwo.Color = k_colore

	END IF

end if

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

event getfocus;//getfocus
if This.getSelectedRow(0) <= 0 then
	This.SelectRow(1, TRUE)
end if
//
sle_cerca.visible = false
cb_cerca_1.visible = false

end event

event rbuttondown;//
tab_1.triggerevent("ue_rbuttondown")

end event

event ue_dwnkey;//
	tab_1.trigger event key (key, 0)

end event

type cb_fatt_acq from commandbutton within w_commessa_l
event clicked pbm_bnclicked
int X=961
int Y=1077
int Width=449
int Height=69
int TabOrder=140
boolean Enabled=false
string Text="Fatture fornitori"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
string k_where
long k_id_commessa
char k_stato


if dw_lista_0.getrow() > 0 then

	k_id_commessa = dw_lista_0.getitemnumber( &
			dw_lista_0.getrow(), "id_commessa") 
//
//
//=== 2 scelta  
//=== 10 id_fattura + 10 liberi + S=ridim windows + dalla 50 : 10 id_cliente (fornitore) 
//=== 10 id_commessa + 20 id_articolo  
		w_main.open_w_tabelle("ff "+"--" + space(10) + space(10) + KK_ADATTA_WIN + space(26) + & 
								space(10) +	string(k_id_commessa, "0000000000") + space(20))
								
								
else

	messagebox("Nessuna Commessa da ricercare", "Selezionare una riga dalla lista")

end if

end event

type cb_stat from commandbutton within w_commessa_l
event clicked pbm_bnclicked
int X=1427
int Y=1077
int Width=449
int Height=69
int TabOrder=150
boolean Enabled=false
string Text="Statistica"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
string k_where
long k_id_commessa
char k_stato


if dw_lista_0.getrow() > 0 then

	k_id_commessa = dw_lista_0.getitemnumber( &
				dw_lista_0.getrow(), "id_commessa") 
//
//=== 2 scelta co=tabulatore su commessa, ci=tab su clienti interni, ce=tab su cl. est, ar=tab su articoli 
//=== 10 id_commessa + 10 liberi + s=ridim windows + dalla 50 : 10 id_cliente 
//=== 10 id_t_lavoro + 20 id_divisione
	w_main.open_w_tabelle("sk "+"  " + string(k_id_commessa, "0000000000") + &
								space(10) + KK_ADATTA_WIN + space(26) + & 
								"0000000000" +	"*         " + "*         ")
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

end event

