$PBExportHeader$w_sl_pt_l.srw
forward
global type w_sl_pt_l from w_g_tab0
end type
end forward

global type w_sl_pt_l from w_g_tab0
integer width = 3022
integer height = 1504
string title = "SL-PT"
boolean ki_toolbar_window_presente = true
end type
global w_sl_pt_l w_sl_pt_l

type variables

private kuf_sl_pt kiuf_sl_pt
private string ki_mostra_nascondi_in_lista="S"
private long ki_ultimo_clie_3_cercato=999999
private string ki_ultimo_cod_sl_pt_cercato="!"

end variables

forward prototypes
private function string cancella ()
protected function integer visualizza ()
private function string inizializza ()
protected subroutine attiva_menu ()
private subroutine mostra_nascondi_in_lista ()
protected subroutine smista_funz (string k_par_in)
protected subroutine open_start_window ()
protected subroutine set_titolo_window_personalizza ()
public function integer u_retrieve_dw_lista ()
end prototypes

private function string cancella ();//
string k_descr, k_cod_sl_pt
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
//kuf_sl_pt  kuf1_sl_pt  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_descr = dw_lista_0.getitemstring(k_riga, "descr")
	k_cod_sl_pt = dw_lista_0.getitemstring(k_riga, "cod_sl_pt")

	if isnull(k_descr) = true or trim(k_descr) = "" then
		k_descr = "SL-PT senza descrizione" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina SL-PT", "Sei sicuro di voler Cancellare : ~n~r" &
	         + k_cod_sl_pt + " " + k_descr, &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
//		kuf1_sl_pt = create kuf_sl_pt
		
//=== Cancella la riga dal data windows di lista
		k_errore = kiuf_sl_pt.tb_delete(k_cod_sl_pt) 
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
//		destroy kuf1_sl_pt

	else
		messagebox("Elimina SL-PT", "Operazione Annullata !!")

	end if
end if

return " "
end function

protected function integer visualizza ();//
string k_cod_sl_pt
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_cod_sl_pt = dw_lista_0.getitemstring( &
						dw_lista_0.getrow(), "cod_sl_pt") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = "pt"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "vi"
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(k_cod_sl_pt) // cod sl-pt
		K_st_open_w.key2 = " " 
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if

return (0)
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
string k_cod_sl_pt, k_key, k_tipo
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_cod_sl_pt = trim(ki_st_open_w.key1)
	if isnull(k_cod_sl_pt) then
		k_tipo = "%"
	end if


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if k_cod_sl_pt <> "%" then
			k_cod_sl_pt = k_cod_sl_pt + "%"
		end if

		if ki_st_open_w.flag_primo_giro = "S" and k_cod_sl_pt = "%" then
			
			if dw_guida.visible then
				dw_guida.setfocus( )
			end if
			
			SetPointer(oldpointer)

		else
			if u_retrieve_dw_lista() < 1 then
				k_return = "1Non sono stati trovati PT "
	
				SetPointer(oldpointer)
//				messagebox("Elenco PT Vuoto", "Nesun Codice Trovato per la richiesta fatta")
	
			end if		
		end if		
	end if


return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Mostra/Nascondi righe Disattivate nei Listini e/o Contratti"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Mostra o Nascondi PT associati a listini non inattivi e/o Contratti Scaduti"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Nascondi,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "DeleteRow!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	
	end if
	
//---
	super::attiva_menu()

	
end subroutine

private subroutine mostra_nascondi_in_lista ();//
string k_dataoggi


	
	dw_lista_0.setredraw(false)
	
//
//--- piglia la data oggi
	k_dataoggi = string(kguo_g.get_dataoggi())
					
	if ki_mostra_nascondi_in_lista = "S" then	
		ki_mostra_nascondi_in_lista = "N"
		leggi_liste()
//		kiw_this_window.title = ki_win_titolo_orig + " Solo righe associate a Listini attivi e Contratti in vigore"
		dw_lista_0.u_filtra_record("(attivo = 'S' or isnull(attivo)) and data_scad >= date('" + k_dataoggi + "') ") 
	else
		if ki_mostra_nascondi_in_lista = "N" then	
			ki_mostra_nascondi_in_lista = "*"
			leggi_liste()
//			kiw_this_window.title = ki_win_titolo_orig + " Solo righe associate a Listini inattivi o Contratti scaduti"
			dw_lista_0.u_filtra_record("attivo = 'N' or data_scad < date('" + k_dataoggi + "') ")  
		else
			ki_mostra_nascondi_in_lista = "S"
//			kiw_this_window.title = ki_win_titolo_orig + " Mostra tutte le righe in archivio (attive e non)"
			dw_lista_0.u_filtra_record("") 
			leggi_liste()
		end if
	end if


attiva_tasti()




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
datawindowchild kdwc_cliente

	kiuf_sl_pt = create kuf_sl_pt 
	ki_toolbar_window_presente=true


	dw_guida.insertrow(0)
	dw_guida.getchild("rag_soc_1", kdwc_cliente)
	kdwc_cliente.settransobject( sqlca)
	kdwc_cliente.retrieve()
	kdwc_cliente.insertrow(1)

end subroutine

protected subroutine set_titolo_window_personalizza ();
super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'N'  // solo in vigore
      this.title += " - righe associate a Listini attivi e Contratti in vigore "
   case '*'  // solo Scaduti
      this.title += " - Solo righe associate a Listini inattivi o Contratti scaduti "
   case else //faccio vedere tutto
      this.title += " - Mostra tutte le righe in archivio (attive e non) "
end choose

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(ki_ultimo_cod_sl_pt_cercato, ki_ultimo_clie_3_cercato, ki_ultimo_cod_sl_pt_cercato) 
	dw_lista_0.setfocus()

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

on w_sl_pt_l.create
call super::create
end on

on w_sl_pt_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sl_pt_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sl_pt_l
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sl_pt_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sl_pt_l
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 80
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_sl_pt_l
integer x = 0
integer y = 1184
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sl_pt_l
integer x = 2144
integer y = 1072
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_cod_sl_pt
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_cod_sl_pt = dw_lista_0.getitemstring( k_riga, "cod_sl_pt" ) 
		
	if LenA(trim(k_cod_sl_pt))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl-pt;

		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.id_programma = kiuf_sl_pt.get_id_programma(K_st_open_w.flag_modalita)  //"pt"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(k_cod_sl_pt)
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

type cb_modifica from w_g_tab0`cb_modifica within w_sl_pt_l
integer x = 1737
integer y = 1180
integer height = 96
integer taborder = 60
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
string k_cod_sl_pt
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_cod_sl_pt = dw_lista_0.getitemstring( k_riga, "cod_sl_pt" ) 
		
	if LenA(trim(k_cod_sl_pt))  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl-pt;

		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.id_programma = kiuf_sl_pt.get_id_programma(K_st_open_w.flag_modalita)  //"pt"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = trim(k_cod_sl_pt)
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sl_pt_l
integer x = 937
integer y = 1180
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sl_pt_l
integer x = 2126
integer y = 1180
integer height = 96
integer taborder = 70
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sl_pt_l
integer x = 1349
integer y = 1180
integer height = 96
integer taborder = 50
boolean enabled = false
end type

event cb_inserisci::clicked;//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl-pt;

		K_st_open_w.id_programma = "pt"
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = " "
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sl_pt_l
integer x = 105
integer y = 752
integer width = 1989
integer height = 524
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_sl_pt_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sl_pt_l
integer x = 32
integer y = 72
integer width = 2807
integer height = 808
string dataobject = "d_sl_pt_elenco"
end type

type dw_guida from w_g_tab0`dw_guida within w_sl_pt_l
event ue_itemchanged ( string k_nome,  string k_dato )
boolean visible = true
integer width = 2798
boolean enabled = true
string dataobject = "d_clienti_sl_pt_guida"
end type

event dw_guida::ue_itemchanged(string k_nome, string k_dato);////
//int k_errore=0
//long k_riga
//string k_rag_soc
//st_stat_fatt kst_stat_fatt
//datawindowchild kdwc_cliente, kdwc_prodotti
//
//
//choose case k_nome 
//
//	case "rag_soc_1" 
//		k_rag_soc = k_dato
//		if LenA(k_rag_soc) > 0 then
//			dw_guida.getchild("rag_soc_1", kdwc_cliente)
//			if kdwc_cliente.rowcount() < 2 then
//				kdwc_cliente.retrieve("%")
//				kdwc_cliente.insertrow(1)
//			end if
//			k_riga=kdwc_cliente.find("upper(rag_soc_1) like '%"+upper(trim(k_rag_soc))+"%'",&
//									0, kdwc_cliente.rowcount())
//			if k_riga > 0 then
//				dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
//				dw_guida.setitem(1, "rag_soc_1", 	kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
//			else
//				dw_guida.setitem(1, "rag_soc_1","")
//				dw_guida.setitem(1, "id_cliente",0)
//			end if
//			k_errore = 1
//		else
//			dw_guida.setitem(1, "id_cliente",0)
//		end if
//
//	case "id_cliente" 
//		if isnumber(k_dato) then
//			kst_stat_fatt.k_id_cliente = long(k_dato)
//			if kst_stat_fatt.k_id_cliente > 0 then
//				dw_guida.getchild("rag_soc_1", kdwc_cliente)
//				if kdwc_cliente.rowcount() < 2 then
//					kdwc_cliente.retrieve("%")
//					kdwc_cliente.insertrow(1)
//				end if
//				k_riga=kdwc_cliente.find("id_cliente = "+string(kst_stat_fatt.k_id_cliente)+" ", 0, kdwc_cliente.rowcount())
//				if k_riga > 0 then
//					dw_guida.setitem(1, "id_cliente",	kdwc_cliente.getitemnumber(k_riga, "id_cliente"))
//					dw_guida.setitem(1, "rag_soc_1", kdwc_cliente.getitemstring(k_riga, "rag_soc_1"))
//				else
//					dw_guida.setitem(1, "rag_soc_1","Nessun Listino caricato per questo cliente")
//					dw_guida.setitem(1, "id_cliente",kst_stat_fatt.k_id_cliente)
//				end if
//				k_errore = 1
//			else
//				dw_guida.setitem(1, "id_cliente",0)
//			end if
//		end if
//
//
//end choose 
//
//
//	

	



end event

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true
st_tab_sl_pt kst_tab_sl_pt
st_tab_clienti kst_tab_clienti



try
	
//
//	if isnumber(trim(dw_guida.getitemstring(1, "rag_soc_1"))) then
//		event ue_itemchanged( "id_cliente", trim(dw_guida.getitemstring(1, "rag_soc_1")) )  //this.gettext()) )
//
//	else
//
////--- se alfanum cerca prima se è un codice sl-pt			
//		kst_tab_sl_pt.cod_sl_pt = trim(dw_guida.getitemstring(1, "rag_soc_1") )
//		
//		if not kiuf_sl_pt.get_descr(kst_tab_sl_pt) then
////--- se non trova il codice sl-pt prova a cercare il cliente			
//			event ue_itemchanged( "rag_soc_1", trim(dw_guida.getitemstring(1, "rag_soc_1")) )  //this.gettext()) )
//		end if
//	end if
			
	
//   kst_tab_clienti.codice = dw_guida.getitemnumber(1, "id_cliente")
//   if isnull(kst_tab_clienti.codice) then
//      kst_tab_clienti.codice = 0
//   end if

//	kst_tab_sl_pt.cod_sl_pt = "%"
//	if kst_tab_clienti.codice = 0 and len(trim(dw_guida.getitemstring(1, "rag_soc_1") )) > 0 then
//	end if

//--- Il primo tentativo è come codice PT
//	kst_tab_sl_pt.cod_sl_pt = trim(dw_guida.getitemstring(1, "rag_soc_1") )
//	if not kiuf_sl_pt.get_descr(kst_tab_sl_pt) then
//--- Poi allora vede se è stato digitato come Cliente
//		kst_tab_sl_pt.cod_sl_pt = "%"
//	end if
		

//	if kst_tab_clienti.codice = 0 and kst_tab_sl_pt.cod_sl_pt = "%" then
//	else

//--- solo se nuova ricerca faccio retrieve
//		  if ki_ultimo_clie_3_cercato <> kst_tab_clienti.codice or ki_ultimo_cod_sl_pt_cercato <> kst_tab_sl_pt.cod_sl_pt then

	kst_tab_sl_pt.cod_sl_pt = trim(dw_guida.getitemstring(1, "rag_soc_1") )
//--- estrazione puntuale sul cliente?	
	kst_tab_clienti.codice=0
	if upper(left(kst_tab_sl_pt.cod_sl_pt, 1)) = "C" then
		if isnumber(trim(mid(kst_tab_sl_pt.cod_sl_pt, 2))) then
			kst_tab_clienti.codice = long(trim(mid(kst_tab_sl_pt.cod_sl_pt, 2)))
			kst_tab_sl_pt.cod_sl_pt = ""
			ki_ultimo_cod_sl_pt_cercato = "!"
		end if
	end if
	if kst_tab_clienti.codice = 0 then
		if isnumber(kst_tab_sl_pt.cod_sl_pt) then
			kst_tab_clienti.codice = long(kst_tab_sl_pt.cod_sl_pt)
		else
			kst_tab_clienti.codice = 0 
		end if
		if trim(kst_tab_sl_pt.cod_sl_pt) > " " then
			kst_tab_sl_pt.cod_sl_pt = "%" + trim(kst_tab_sl_pt.cod_sl_pt) + "%"
		else
			kst_tab_sl_pt.cod_sl_pt = "%"
		end if
	end if
	
	if kst_tab_sl_pt.cod_sl_pt <> ki_ultimo_cod_sl_pt_cercato then
				
		ki_ultimo_clie_3_cercato = kst_tab_clienti.codice
		ki_ultimo_cod_sl_pt_cercato = kst_tab_sl_pt.cod_sl_pt
		u_retrieve_dw_lista()
			
//		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

end event

