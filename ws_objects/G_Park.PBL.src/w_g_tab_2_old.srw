$PBExportHeader$w_g_tab_2_old.srw
forward
global type w_g_tab_2_old from Window
end type
type tv_1 from treeview within w_g_tab_2_old
end type
type st_parametri from statictext within w_g_tab_2_old
end type
type cb_ritorna from commandbutton within w_g_tab_2_old
end type
type cb_ok from commandbutton within w_g_tab_2_old
end type
end forward

global type w_g_tab_2_old from Window
int X=0
int Y=0
int Width=2789
int Height=1648
boolean TitleBar=true
string Title="Anagrafica Modelli"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_menu pbm_custom01
tv_1 tv_1
st_parametri st_parametri
cb_ritorna cb_ritorna
cb_ok cb_ok
end type
global w_g_tab_2_old w_g_tab_2_old

type variables
string ki_record_base
end variables

forward prototypes
protected function string check_dati ()
protected function integer attiva_tasti ()
protected function integer ritorna ()
public function string smista_funz (string k_par_in)
protected subroutine liste_varie ()
protected function integer check_esiste ()
protected function string inizializza ()
protected subroutine esegui_ok ()
protected function string esegui_ok_1 ()
end prototypes

event ue_menu;//
smista_funz(this.tag)

end event

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
char k_errore = "0"
//int k_riga
//int k_nr_errori
//string k_id_modello
//string k_des_ita, k_des_est
//
//
//k_nr_errori = 1
//k_riga = 1
//
////=== Legge la prima riga modificata
//k_riga = dw_dett_1.GetNextModified(k_riga, Primary!)
//
//do while k_riga <> 0 and k_nr_errori < 10
//
//	k_id_modello = dw_dett_1.getitemstring ( k_riga, "modelli_id_modello") 
//
//	if trim(k_id_modello) = "" then
//		k_return = "Manca il codice modello"
//		k_errore = "3"
//		k_nr_errori++
//	else
//		k_des_ita = dw_dett_1.getitemstring ( k_riga, "des_ita")
//		if trim(k_des_ita) = "" then
//			k_return = "Manca la Descrizione italiana ~n~r" 
//			k_errore = "3"
//			k_nr_errori++
//		end if
//	end if
//
////		if k_errore = "0" and dw_dett_1.getitemnumber ( k_riga, "aliquota") > 30 and &
////			dw_dett_1.getitemnumber ( 1, "scad_mm") = 0	then
////			k_return = "Nr. mesi non puo' essere a 0 se ci sono delle rate ~n~r"
////			k_errore = "1"
////		end if
//
//	if k_errore = "0" then
//		if long(dw_dett_1.describe("modelli_id_iva.d_c_iva.aliquota")) = 0 then 
//			k_return = "Attenzione il codice IVA Esente  ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_um")) = 0 then
//			k_return = "Manca l'unita' di misura. ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_id_taglia")) = 0 then
//			k_return = "Manca la taglia. ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_id_fornitore")) = 0 then
//			k_return = "Manca il fornitore. ~n~r"
//			k_errore = "4"
//		end if
//
//	end if
//
//	if k_errore <> "0" then
//		k_return = k_return + "(" + k_des_ita + ") ~n~r"
//		k_nr_errori++
//	end if
////=== Legge la successiva riga modificata
//	k_riga = dw_dett_1.GetNextModified(k_riga, Primary!)
//
//
//loop
//
//
return k_errore + k_return


end function

protected function integer attiva_tasti ();//
//=========================================================================
//=== Controlla se codice modificato
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_righe


cb_ritorna.enabled = true
cb_ok.enabled = false
cb_ok.default = false

           

return (0)
end function

protected function integer ritorna ();//
string k_errore="0 "
string k_modif="0"


//=== Qualsiasi operazione prima di chiudere la windows


return integer(left(k_errore, 1))

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

	case "ag"		// le liste di supporto (dddw)
		liste_varie()

	case "co"		//richiesta conferma
		cb_ok.postevent(clicked!)

//	case "st" 	//Stampa 
//		kuf1_data_base.stampa_dw(dw_dett_1,"Procedura ECO", 0)

	case "ri"		//richiesta uscita
		cb_ritorna.postevent(clicked!)

end choose


return k_return



end function

protected subroutine liste_varie ();////
//datawindowchild  kdwc_iva, kdwc_taglie, kdwc_fornitori, kdwc_merce
//
//
////=== catturo gli handle dei drop_data_windows
//	dw_dett_1.getchild("modelli_id_iva", kdwc_iva)
//	dw_dett_1.getchild("modelli_id_taglia", kdwc_taglie)
//	dw_dett_1.getchild("modelli_id_fornitore", kdwc_fornitori)
//	dw_dett_1.getchild("modelli_id_merce", kdwc_merce)
////=== per evitare la richiesta del Argument_retrieval 
//	kdwc_iva.settransobject ( sqlca )
//	kdwc_taglie.settransobject ( sqlca )
//	kdwc_fornitori.settransobject ( sqlca )
//	kdwc_merce.settransobject ( sqlca )
//
//	kdwc_iva.retrieve(0)
//	kdwc_taglie.retrieve(" ")
//	kdwc_fornitori.retrieve(" ")
//	kdwc_merce.retrieve(" ")
//
//	kdwc_iva.insertrow(0)
//	kdwc_taglie.insertrow(0)
//	kdwc_fornitori.insertrow(0)
//	kdwc_merce.insertrow(0)
//
end subroutine

protected function integer check_esiste ();//
int k_return = 0
//string k_id_modello, k_id_modello_1, k_id_modello_old
//string k_des_ita
//
//
//dw_dett_1.accepttext()
//k_id_modello = trim(dw_dett_1.getitemstring(dw_dett_1.getrow(), "modelli_id_modello"))
//
//if len(k_id_modello) > 0 and &
//	dw_dett_1.getitemstatus(dw_dett_1.getrow(), "modelli_id_modello", primary!) = datamodified! then
//
//
//	SELECT "modelli"."id_modello",   
//          "modelli"."des_ita"  
//   	 INTO :k_id_modello_1,   
//      	   :k_des_ita  
//    	FROM "modelli"  
//   	WHERE "modelli"."id_modello" = :k_id_modello   ;
//
//	if k_id_modello = k_id_modello_1 then
//		if messagebox("Modello Trovato in Archivio", "Vuoi modificare il modello:~n~r"+ &
//				trim(k_des_ita), question!, yesno!, 2) = 1 then
//			inizializza(k_id_modello)
//			cb_cancella.enabled = true
//
//			dw_dett_1.setitemstatus(dw_dett_1.getrow(), "modelli_id_modello", &
//					primary!, notmodified!)
//		else
//			k_id_modello_old = dw_dett_1.getitemstring(dw_dett_1.getrow(), &
//						"modelli_id_modello", primary!, true) 
//			
//			if k_id_modello_old = k_id_modello then
//				setnull(k_id_modello_old)
//			end if
//			dw_dett_1.setitem(dw_dett_1.getrow(), "modelli_id_modello", &
//			  						k_id_modello_old)
//			cb_cancella.enabled = false
//		end if
//	end if  
//
//
//end if
//
//
return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_cliente
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//long k_id_iva
//char k_id_taglia
//long k_id_fornitore
//
//
//	if isnull(k_id_modello) then
//		messagebox("Nessun Modello da ricercare", &
//			"Codice non Impostato. Ripetere la ricerca ~n~r" )
//		k_return = "1Nessun codice impostato"
//	else
//
//
////=== legge dw degli anagrafici
//		if dw_dett_1.retrieve(k_id_modello) > 0 then
//			k_return = "0 "
//
//
//		else
//			dw_dett_1.reset()
//		
//			k_return = "1Modello richiesto non in archivio "
//
//			messagebox("Modello richiesto non in archivio", &
//				"Codice non Trovato per la richiesta fatta ~n~r" + &
//				"(codice recercato :" + trim(k_id_modello) + ")~n~r" )
//			
//		end if
//	end if
// if left(k_return, 1) <> "0" then
//		cb_ritorna.postevent(clicked!)
//	else
//		attiva_tasti()
//	end if
//		
//
return k_return



end function

protected subroutine esegui_ok ();//
//=== Esecuzuine delle operazioni dal tsto OK
string k_errore_dati


//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore_dati = check_dati()

	choose case left(k_errore_dati,1)

		case "1" 
			messagebox("Digitati dati incongruenti, operazione non eseguita~n~r", &
			     mid(k_errore_dati, 2))
		case "2"
			messagebox("Inseriti dati non validi, operazione non eseguita~n~n", & 
			     mid(k_errore_dati, 2))
		case "3"
			messagebox("Dati insufficienti, operazione non eseguita~n~r", & 
			     mid(k_errore_dati, 2))
		case "4", "0"
			esegui_ok_1()		//Controlli tutto OK, Esecuzione (estrazione+via!)

	end choose


end subroutine

protected function string esegui_ok_1 ();//
//=== Estrazione dei dati inseriti ed escuzione effettiva dell'operazione

//=== Esempio di cosa inserire in questa routine

string k_return=""
//string k_id_cliente, k_id_art, k_anno
//string k_fat_nro_da, k_fat_nro_a
//date k_fat_data_da, k_fat_data_a
//string k_catfi, k_marca
//long k_nr_errori=0, k_nr_insert=0
//char k_flag_clienti = 'N', k_flag_articoli = 'N',k_flag_nuovi = 'N',k_flag_vecchi = 'N'  
//string k_errore="0", k_ritorna, k_argomenti
//datawindowchild  kdwc_clienti
//
//
////=== Puntatore di attesa....
//setpointer(hourglass!)
//
//tab_1.tabpage_generale.cbx_clienti_ok.checked = false
//tab_1.tabpage_generale.cbx_articoli_ok.checked = false
//tab_1.tabpage_generale.cbx_fatture_ok.checked = false
//
////=== Estrazione cliente
////=== catturo gli handle dei drop_data_windows
//tab_1.tabpage_clienti.dw_clienti.getchild("rag_soc_1", kdwc_clienti)
//if kdwc_clienti.getrow() > 0 then
//	k_id_cliente = kdwc_clienti.getitemstring(kdwc_clienti.getrow(), &
//										"id_cliente")
//	if isnull(k_id_cliente) then
//		k_id_cliente= ""
//	end if
//else
//	k_id_cliente= ""
//end if									
//
////=== Estrazione Articolo
//if tab_1.tabpage_articoli.dw_articoli.getrow() > 0 then
//	k_id_art = tab_1.tabpage_articoli.dw_articoli.getitemstring(1, "id_art")
//	if isnull(k_id_art) then
//		k_id_art = ""
//	end if
//else
//	k_id_art = ""
//end if
//
////=== Estrazione range : nro e data di fattura
//k_fat_nro_da = trim(tab_1.tabpage_fatture.em_fatt_nro_da.text)
//k_fat_nro_a = trim(tab_1.tabpage_fatture.em_fatt_nro_a.text)
//if trim(tab_1.tabpage_fatture.em_fatt_data_da.text) <> "00/00/00" then
//	k_fat_data_da = date(tab_1.tabpage_fatture.em_fatt_data_da.text)
//else
//	k_fat_data_da=date("00/00/0000") 
//end if  
//if trim(tab_1.tabpage_fatture.em_fatt_data_a.text) <> "00/00/00" then
//	k_fat_data_a = date(tab_1.tabpage_fatture.em_fatt_data_a.text)
//else
//	k_fat_data_a=date("00/00/0000")
//end if  
//
////=== Estrae la categoria
//k_catfi = trim(tab_1.tabpage_articoli.ddlb_catfi.text)
//if k_catfi = "<Tutte>" then
//	k_catfi = "*"
//else
//	if k_catfi = "<Nessuna>" then
//		k_catfi = ""
//	else
//		k_catfi = trim(left(tab_1.tabpage_articoli.ddlb_catfi.text,5))
//			
//	end if
//end if
//k_catfi = k_catfi + space(10)
//
////=== Estrae la Marca
//k_marca = trim(tab_1.tabpage_articoli.ddlb_marca.text)
//if k_marca = "<Tutte>" then
//	k_marca = "*"
//else
//	if k_marca = "<Nessuna>" then
//		k_marca = ""
//	else
//		k_marca = trim(tab_1.tabpage_articoli.ddlb_marca.text)
//			
//	end if
//end if
//k_marca = k_marca + space(30)
//
////=== Controllo Check-Box
//if tab_1.tabpage_fatture.cbx_fatt_articoli.checked = true and &
//	tab_1.tabpage_generale.cbx_art_elabora.checked = false then
//		k_flag_articoli='S'
//end if
//if tab_1.tabpage_fatture.cbx_fat_clienti.checked = true and &
//	tab_1.tabpage_generale.cbx_cli_elabora.checked = false then
//	k_flag_clienti='S'
//end if
//if tab_1.tabpage_generale.cbx_nuovi.checked = true then k_flag_nuovi='S'
//if tab_1.tabpage_generale.cbx_vecchi.checked = true then k_flag_vecchi='S'
//
//k_anno =	trim(tab_1.tabpage_fatture.em_fatt_anno.text)
//					
////=== Esecuzione delle Elaborazioni Richieste					
//if tab_1.tabpage_generale.cbx_cli_elabora.checked = true then
//
//	k_argomenti =  string(k_id_cliente, "0000000000") + &
//				   	string(k_flag_nuovi, "@") + &
//				   	string(k_flag_vecchi, "@") 
//	k_errore = kuf1_data_base.importa_clienti(k_argomenti)
//
//	k_nr_errori = k_nr_errori + long((mid(k_errore, 2, 5)))
//	k_nr_insert = k_nr_errori + long((mid(k_errore, 7, 5)))
//	
//	if left(k_errore,1) = "0"  then
//		tab_1.tabpage_generale.cbx_clienti_ok.checked = true
//		k_return = "Anagrafiche clienti Importati " + string(long(mid(k_errore, 7, 5)), "#####") + &
//					  "~n~r"
//	else	
//		messagebox("Importa Clienti", &
//					"Mi spiace, ma l'operazione non e' terimata correttamente~n~r" + &
//					mid(k_errore,12) , &
//					exclamation!, ok!) 
//		k_return = k_errore + "~n~r"
//	end if
//	
//end if
//
//if tab_1.tabpage_generale.cbx_art_elabora.checked = true then
//
//	if left(k_errore,1) <> "0"  then
//		if messagebox("Importa Articoli", &
//					"Eseguo la nuova operazione di Importa Articoli ?", &
//					question!, yesno!) = 1 then
//			k_errore = "0"
//		end if
//	end if
//
//	if left(k_errore,1) = "0"  then
//		k_argomenti =  & 
//						string(k_id_art, "@@@@@@@@@@@@@@@@@@@@") + &
//						string(k_catfi, "@@@@@@@@@@") + &
//				   	string(k_flag_nuovi, "@") + &
//				   	string(k_flag_vecchi, "@") + &
//						left(k_marca, 30) 
//		k_errore = kuf1_data_base.importa_art(k_argomenti)
//
//		k_nr_errori = k_nr_errori + long(mid(k_errore, 2, 5))
//		k_nr_insert = k_nr_errori + long(mid(k_errore, 7, 5))
//
//		if left(k_errore,1) = "0"  then
//			tab_1.tabpage_generale.cbx_articoli_ok.checked = true
//			k_return = k_return + "Articoli Importati " + string(long(mid(k_errore, 7, 5)), "#####") + &
//						  "~n~r"
//		else	
//			messagebox("Importa Articoli", &
//					"Mi spiace, ma l'operazione non e' terimata correttamente~n~r" + &
//					mid(k_errore,12) , &
//					exclamation!, ok!) 
//			if k_return <> "" then
//				k_return = k_return + k_errore
//			else
//				k_return = k_errore + "~n~r"
//			end if
//		end if
//	end if
//end if
//
//if tab_1.tabpage_generale.cbx_fat_elabora.checked = true then
//
//	if left(k_errore,1) <> "0"  then
//		if messagebox("Importa Fatture", &
//					"Eseguo la nuova operazione di Importa Fatture ?", &
//					question!, yesno!) = 1 then
//			k_errore = "0"
//		end if
//	end if
//	if left(k_errore,1) = "0"  then
//		k_argomenti = & 
//						string(k_anno, "@@   ") + &
//						string(k_fat_nro_da, "@@@@@@@@@@") + &
//				   	string(k_fat_nro_a, "@@@@@@@@@@") + &
//	   	         string(k_fat_data_da, "dd/mm/yyyy") + &
//					   string(k_fat_data_a, "dd/mm/yyyy") + &
//						string(k_id_cliente, "@@@@@@@@@@") + &
//						string(k_id_art, "@@@@@@@@@@@@@@@@@@@@") + &
//						string(k_catfi, "@@@@@@@@@@") + &
//				   	string(k_flag_articoli, "@") + &
//				   	string(k_flag_clienti, "@") + &
//				   	string(k_flag_nuovi, "@") + &
//				   	string(k_flag_vecchi, "@") + &
//						left(k_marca, 30) 
//						
//		k_errore = kuf1_data_base.importa_fatture(k_argomenti)
//
//		k_nr_errori = k_nr_errori + long(mid(k_errore, 2, 5))
//		k_nr_insert = k_nr_errori + long(mid(k_errore, 7, 5))
//
//		if left(k_errore,1) = "0"  then
//			tab_1.tabpage_generale.cbx_fatture_ok.checked = true
//			k_return = k_return + "Righe fattura Importate " + string(long(mid(k_errore, 7, 5)), "#####") + &
//						  "~n~r"
//		else	
//			messagebox("Importa Fatture", &
//					"Mi spiace, ma l'operazione non e' terimata correttamente~n~r" + &
//					mid(k_errore,12) , &
//					exclamation!, ok!) 
//			if k_return <> "" then
//				k_return = k_return + k_errore
//			else
//				k_return = k_errore
//			end if
//		end if
//	end if
//end if	
//
//
//if tab_1.tabpage_generale.cbx_ass_elabora.checked = true then
//
//	if left(k_errore,1) <> "0"  then
//		if messagebox("Importa da Assistenze", &
//					"Eseguo la nuova operazione di Importa da Assistenze ?", &
//					question!, yesno!) = 1 then
//			k_errore = "0"
//		end if
//	end if
//	if left(k_errore,1) = "0"  then
//		k_argomenti = & 
//						string(k_anno, "@@   ") + &
//						string(k_fat_nro_da, "@@@@@@@@@@") + &
//				   	string(k_fat_nro_a, "@@@@@@@@@@") + &
//	   	         string(k_fat_data_da, "dd/mm/yyyy") + &
//					   string(k_fat_data_a, "dd/mm/yyyy") + &
//						string(k_id_cliente, "@@@@@@@@@@") + &
//						string(k_id_art, "@@@@@@@@@@@@@@@@@@@@") + &
//						string(k_catfi, "@@@@@@@@@@") + &
//				   	string(k_flag_articoli, "@") + &
//				   	string(k_flag_clienti, "@") + &
//				   	string(k_flag_nuovi, "@") + &
//				   	string(k_flag_vecchi, "@") + &
//						left(k_marca, 30) 
//						
//		k_errore = kuf1_data_base.importa_asspri(k_argomenti)
//
//		k_nr_errori = k_nr_errori + long(mid(k_errore, 2, 5))
//		k_nr_insert = k_nr_errori + long(mid(k_errore, 7, 5))
//
//		if left(k_errore,1) = "0"  then
////			tab_1.tabpage_generale.cbx_ass_ok.checked = true
//			k_return = k_return + "Righe da Assistenze Importate " + string(long(mid(k_errore, 7, 5)), "#####") + &
//						  "~n~r"
//		else	
//			messagebox("Importa da Assistenze", &
//					"Mi spiace, ma l'operazione non e' terimata correttamente~n~r" + &
//					mid(k_errore,12) , &
//					exclamation!, ok!) 
//			if k_return <> "" then
//				k_return = k_return + k_errore
//			else
//				k_return = k_errore
//			end if
//		end if
//	end if
//end if
//
//
//if k_nr_insert = 0 and k_nr_errori = 0 then
//	messagebox("Importazione Dati ", "Nessuna importazione eseguita per la richiesta fatta", &
//					information!, ok!)
//	k_return = "0"
//else
//	if k_nr_errori > 0 then
//		k_return = "Mi spiace, ma ho riscontrato alcuni errori. ~n~r" + &
//					  k_return
//	end if
//	messagebox("Importazione Dati ", k_return, &
//					information!, ok!)
//		
//end if
//
return k_return
end function

event open;//

//=== Parametri passati con il WITHPARM
st_parametri.text = message.stringparm

//=== Posiziona window all'interno MDI 
//this.width = dw_dett_1.width + 40
//this.height = dw_dett_1.height + 105
if w_main.width > this.width then
	this.x = (w_main.width - this.width) / 4
else
	this.x = 1
end if
if w_main.height > this.height then
	this.y = (w_main.height - this.height) / 6
else
	this.y = 1
end if

//=== Fa le liste di supporto (dddw)
post liste_varie()

//=== Inizializzazione tasti e retrieve della Lista
post inizializza() 


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
		m_menu.m_conferma.visible = cb_ok.visible
		m_menu.m_conferma.enabled = cb_ok.enabled
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

event close;//
window k_window

k_window = kuf1_data_base.prendi_win_prec()

//=== per evitare che la windows a cui ritorna venga maximizzata
if isnull(k_window) = false then
	k_window.windowstate = normal!
end if


end event

event closequery;//
//=== Controllo prima della chiusura della Windows
int k_errore

	cb_ritorna.enabled = false

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = ritorna()

	if k_errore <> 0 then
		attiva_tasti()
		return(1)  
	end if

	
end event

on w_g_tab_2_old.create
this.tv_1=create tv_1
this.st_parametri=create st_parametri
this.cb_ritorna=create cb_ritorna
this.cb_ok=create cb_ok
this.Control[]={this.tv_1,&
this.st_parametri,&
this.cb_ritorna,&
this.cb_ok}
end on

on w_g_tab_2_old.destroy
destroy(this.tv_1)
destroy(this.st_parametri)
destroy(this.cb_ritorna)
destroy(this.cb_ok)
end on

type tv_1 from treeview within w_g_tab_2_old
int X=558
int Y=200
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Library!"}
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_parametri from statictext within w_g_tab_2_old
int X=1742
int Y=1440
int Width=247
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ritorna from commandbutton within w_g_tab_2_old
int X=2304
int Y=1400
int Width=343
int Height=96
int TabOrder=10
string Text="&Ritorna"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//
close(parent)
end on

type cb_ok from commandbutton within w_g_tab_2_old
int X=942
int Y=1400
int Width=343
int Height=96
int TabOrder=20
boolean Enabled=false
string Text="&Ok"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
esegui_ok()
end event

