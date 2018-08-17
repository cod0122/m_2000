$PBExportHeader$w_docprod_l.srw
forward
global type w_docprod_l from w_g_tab0
end type
end forward

global type w_docprod_l from w_g_tab0
integer width = 3259
integer height = 2084
string title = "Utenti WEB"
long backcolor = 32172778
boolean ki_reset_dopo_save_ok = false
end type
global w_docprod_l w_docprod_l

type variables
//

private st_tab_docprod kist_tab_docprod_ultimo_cercato
private st_tab_doctipo kist_tab_doctipo_ultimo_cercato

private kuf_docprod kiuf_docprod
private kuf_doctipo kiuf_doctipo


end variables

forward prototypes
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
public subroutine call_docprod_esporta ()
protected subroutine attiva_tasti_0 ()
end prototypes

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_docprod kst_tab_docprod
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_docprod.id_docprod = dw_lista_0.getitemnumber(k_riga, "id_docprod")
	kst_tab_docprod.doc_num = dw_lista_0.getitemnumber(k_riga, "doc_num")
	kst_tab_docprod.doc_data = dw_lista_0.getitemdate(k_riga, "doc_data")
	kst_tab_docprod.descr  = dw_lista_0.getitemstring(k_riga, "descr")

	if isnull(kst_tab_docprod.descr) = true or trim(kst_tab_docprod.descr) = "" then
		kst_tab_docprod.descr = "*senza descrizione* " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Riferim. Documento da esportare", "Sei sicuro di voler Cancellare il riferimento al documento: ~n~r" &
	         + "num. " + string(kst_tab_docprod.doc_num) + " del " +string(kst_tab_docprod.doc_data) + " - ID " + string(kst_tab_docprod.id_docprod, "#####") + " " + trim(kst_tab_docprod.descr),  &
				question!, yesno!, 2) = 1 then
		
		
		try
		
//=== Cancella la riga dal data windows di lista
			if kiuf_docprod.tb_delete( kst_tab_docprod ) then

		
				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

				dw_lista_0.setfocus()
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Cancellazione riferim. al Documento da Esportare", "Operazione non eseguita")
			end if

			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente( "Cancellazione Fallita", "")

			attiva_tasti()

		end try


	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Cancellazione rifeim. al Documento da Esportare", "Operazione Annullata")

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
//int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
//
////=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//
//	end if
//		
	if ki_st_open_w.flag_primo_giro <> "S" then
//	if k_importa <= 0 then // Nessuna importazione eseguita
//	
		if u_retrieve_dw_lista() < 1 then
			k_return = "1Nessun Documento da esportare in archivio "

			SetPointer(oldpointer)
			messagebox("Elenco Documenti da esportare", "Nessuna occorrenza trovata in archivio ")

		end if		
	end if
//
	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero3.visible then
	
//		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Ruoli Web"
//		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Ruoli Web"
//		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Ruoli,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Ole1!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//		
//		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Cartelle Web"
//		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Cartelle Web"
//		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Cartelle,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName =  "Ole2!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
//		
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Esporta Documenti"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp =  "Genera documenti elettronici"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Esporta,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName =  "Destination5!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		
	end if
//---
	super::attiva_menu()



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 



	case KKG_FLAG_RICHIESTA.libero3		//esporta documenti
		call_docprod_esporta( )

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected subroutine open_start_window ();//

kiuf_docprod = create kuf_docprod
kiuf_doctipo = create kuf_doctipo


	ki_toolbar_window_presente=true

//
//--- Argomenti:  KEY1 = Tipo
	if len(trim(ki_st_open_w.key1)) > 0 then 
		kist_tab_doctipo_ultimo_cercato.tipo = trim(ki_st_open_w.key1)
	else
		kist_tab_doctipo_ultimo_cercato.tipo = kiuf_doctipo.kki_tipo_fatture
	end if
//--- Argomenti:  KEY2 = gia' Esportato S/N
	if len(trim(ki_st_open_w.key2)) > 0 then 
		kist_tab_docprod_ultimo_cercato.doc_esporta = trim(ki_st_open_w.key2)
	else
		kist_tab_docprod_ultimo_cercato.doc_esporta = ""
	end if
	

	dw_guida.insertrow(0)
	dw_guida.setitem(1, "tipo", kist_tab_doctipo_ultimo_cercato.tipo)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
pointer oldpointer  // Declares a pointer variable


	try
		
//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
	
		if trim(kist_tab_doctipo_ultimo_cercato.tipo ) > " " then
		else
			kist_tab_doctipo_ultimo_cercato.tipo = kiuf_doctipo.kki_tipo_fatture 
		end if
		if trim(kist_tab_docprod_ultimo_cercato.doc_esporta ) > " " then 
		else
			kist_tab_docprod_ultimo_cercato.doc_esporta = "S"
		end if
//		if isnull(kist_tab_docprod_ultimo_cercato.esportato_ts ) then kist_tab_docprod_ultimo_cercato.esportato_ts = datetime(date(0))
		kist_tab_docprod_ultimo_cercato.esportato_ts = datetime(date(2000,01,01))
	
		
		dw_lista_0.reset()
		k_return = dw_lista_0.retrieve(kist_tab_doctipo_ultimo_cercato.tipo, kist_tab_docprod_ultimo_cercato.doc_esporta, kist_tab_docprod_ultimo_cercato.esportato_ts)
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		attiva_tasti( )
		SetPointer(oldpointer)
		
	end try
	
return k_return

end function

public subroutine call_docprod_esporta ();//
st_tab_docprod kst_tab_docprod
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_docprod_esporta kuf1_docprod_esporta
st_tab_doctipo kst_tab_doctipo


	kuf1_docprod_esporta = create kuf_docprod_esporta

	if isnull(dw_guida.getitemstring(1, "tipo")) then
		kst_tab_doctipo.tipo = kiuf_doctipo.kki_tipo_fatture
	else
		kst_tab_doctipo.tipo = trim(dw_guida.getitemstring(1, "tipo") )
	end if

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.id_programma = kuf1_docprod_esporta.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = kst_tab_doctipo.tipo
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
								
	destroy kuf1_docprod_esporta


end subroutine

protected subroutine attiva_tasti_0 ();//

super::attiva_tasti_0( )
cb_inserisci.enabled = false

end subroutine

on w_docprod_l.create
call super::create
end on

on w_docprod_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_docprod ) then destroy kiuf_docprod
if isvalid(kiuf_doctipo ) then destroy kiuf_doctipo

end event

type st_ritorna from w_g_tab0`st_ritorna within w_docprod_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_docprod_l
integer x = 1262
integer y = 1388
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_docprod_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_docprod_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_docprod_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_docprod_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_docprod kst_tab_docprod
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_docprod.id_docprod = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_docprod.id_docprod = dw_lista_0.getitemnumber( k_riga, "id_docprod") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = kiuf_docprod.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_docprod.id_docprod)) // id cont
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end event

type cb_modifica from w_g_tab0`cb_modifica within w_docprod_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_docprod kst_tab_docprod
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_docprod.id_docprod = 0
//
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_docprod.id_docprod = dw_lista_0.getitemnumber( k_riga, "id_docprod") 
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.id_programma = kiuf_docprod.get_id_programma(K_st_open_w.flag_modalita )
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_docprod.id_docprod)) // id cont
	K_st_open_w.key2 = ""
	K_st_open_w.key3 = "" 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_docprod_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_docprod_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_docprod_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_docprod_l
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_docprod_l
integer x = 0
integer y = 1760
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_docprod_l
integer width = 3145
integer height = 708
integer taborder = 120
string dataobject = "d_docprod_l"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_docprod_l
boolean visible = true
integer x = 0
integer y = 8
integer width = 3150
boolean enabled = true
string dataobject = "d_docprod_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true
st_tab_docprod kst_tab_docprod
st_tab_doctipo kst_tab_doctipo


	this.accepttext( )
		
	if isnull(dw_guida.getitemstring(1, "tipo")) then
		kst_tab_doctipo.tipo = kiuf_doctipo.kki_tipo_fatture
	else
		kst_tab_doctipo.tipo = trim(dw_guida.getitemstring(1, "tipo") )
	end if
	if isnull(dw_guida.getitemstring(1, "stato")) then
		kst_tab_docprod.doc_esporta = "S"
	else
		kst_tab_docprod.doc_esporta = trim(dw_guida.getitemstring(1, "stato") )
	end if


//--- solo se ricerco key diverso
	if kist_tab_doctipo_ultimo_cercato.tipo <> kst_tab_doctipo.tipo &
	       or kist_tab_docprod_ultimo_cercato.doc_esporta <> kst_tab_docprod.doc_esporta  or dw_lista_0.rowcount() = 0 then
		
		kist_tab_doctipo_ultimo_cercato.tipo = kst_tab_doctipo.tipo
		kist_tab_docprod_ultimo_cercato.doc_esporta = kst_tab_docprod.doc_esporta
		
//		kist_tab_docprod_ultimo_cercato.id_docprod = kist_tab_docprod.id_docprod
		
		u_retrieve_dw_lista()
			
	end if

end event

event dw_guida::itemchanged;call super::itemchanged;//
post event ue_buttonclicked( )
end event

