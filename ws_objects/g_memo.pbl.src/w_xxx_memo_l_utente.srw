$PBExportHeader$w_xxx_memo_l_utente.srw
forward
global type w_xxx_memo_l_utente from w_g_tab0
end type
type dw_periodo from uo_dw_periodo within w_xxx_memo_l_utente
end type
end forward

global type w_xxx_memo_l_utente from w_g_tab0
integer width = 3282
integer height = 2000
string title = "Memo"
boolean ki_toolbar_window_presente = true
boolean ki_resize_dw_dett = true
boolean ki_reset_dopo_save_ok = false
dw_periodo dw_periodo
end type
global w_xxx_memo_l_utente w_xxx_memo_l_utente

type variables
//
Protected:
boolean ki_attiva_toolbar_periodo=false

Protected:
kuf_memo kiuf_memo
kuf_memo_utenti kiuf_memo_utenti
st_tab_memo_utenti kist_tab_memo_utenti
st_tab_memo kist_tab_memo
string ki_stato_cercato
long ki_id_dacercare
long ki_id_memo_rtf=0
 
end variables

forward prototypes
protected subroutine forma_elenco ()
protected function string inizializza ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
protected function integer visualizza ()
protected function integer modifica ()
protected function integer inserisci ()
protected function integer visualizza_dettaglio ()
public subroutine u_cambia_stato (long a_riga)
protected subroutine cambia_periodo_elenco ()
public function boolean u_lancia_funzione_imvc (st_open_w kst_open_w_arg)
end prototypes

protected subroutine forma_elenco ();
end subroutine

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
string k_key
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//	if ki_st_open_w.flag_primo_giro = "S" then
		dw_guida.setfocus( )

		u_retrieve_dw_lista( )
//	end if



return k_return





return k_return



end function

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case LeftA(k_par_in, 2) 

	case kkg_flag_richiesta.libero6		//cambia data di estrazione
		cambia_periodo_elenco()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine attiva_menu ();//
//
//--- Attiva/Dis. Voci di menu personalizzate
//

	if ki_attiva_toolbar_periodo then
		if NOT ki_menu.m_strumenti.m_fin_gest_libero6.enabled then 
			ki_menu.m_strumenti.m_fin_gest_libero6.text = "Cambia il periodo di estrazione elenco "
			ki_menu.m_strumenti.m_fin_gest_libero6.microhelp =  "Cambia periodo di estrazione "
			ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
			ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero6.text
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "Custom015!"
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
		end if
	end if	

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
	
end subroutine

protected subroutine open_start_window ();//
	kiuf_memo_utenti = create kuf_memo_utenti
	kiuf_memo = create kuf_memo

//--- Salvo dati passati nei parametri di input

//--- codice anagrafica/meca/.... a seconda del tipo	
	if isnumber(trim(ki_st_open_w.key1)) then
		ki_id_dacercare = long(trim(ki_st_open_w.key1))
	else
		ki_id_dacercare = 0
	end if

//--- in KEY1 = Stato 4=letto e da leggere, 8=rimossi, 9=tutti  che se passato viene subito lanciata la lista	
	if trim(ki_st_open_w.key2) > " " then
		ki_stato_cercato = trim(ki_st_open_w.key2)
	else
		ki_stato_cercato = "4"
//		setnull(ki_stato_cercato)
	end if
	dw_guida.insertrow(0)
	dw_guida.setitem(1, "tipo", ki_stato_cercato)
	
	kist_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( )

	
//--- inizializza box periodo
	dw_periodo.inizializza( kiw_this_window )

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
long k_id_utente=0
pointer oldpointer  // Declares a pointer variable
st_tab_memo_utenti kst_tab_memo_utenti_da, kst_tab_memo_utenti_a


	try
		
//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
	
		if isnull(ki_stato_cercato) then
			ki_stato_cercato = "4"
		end if
		
		choose case ki_stato_cercato
			case "4"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_letto
			case "8"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_rimosso
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
			case "9"
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
		end choose

		dw_lista_0.reset()  
		k_return = dw_lista_0.retrieve(ki_id_dacercare, kist_tab_memo_utenti.id_sr_utente , kst_tab_memo_utenti_da.stato, kst_tab_memo_utenti_a.stato)
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		attiva_tasti( )
		SetPointer(oldpointer)
		
	end try
	
return k_return

end function

protected function integer visualizza ();//
//=== Legge il rek dalla DW lista per la Visualizzazione
long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window


try

	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
			
		if kst_memo.st_tab_memo.id_memo  > 0 then
	
			kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga


end function

protected function integer modifica ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window


try

	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
			
		if kst_memo.st_tab_memo.id_memo  > 0 then
	
			kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.modifica)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga


end function

protected function integer inserisci ();//
//=== Legge il rek dalla DW lista per Inserimento

long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window

try
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = 0
			
		if kst_memo.st_tab_memo.id_memo  > 0 then
	
			kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.inserimento)
			
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga
end function

protected function integer visualizza_dettaglio ();//---
//--- Espone il dettaglio
//--- Torna : <=0=Ko, >0=Ok
//---
int k_return=0
long k_key=0
string k_memo_rtf 
string k_rc
st_tab_memo kst_tab_memo
kuf_utility kuf1_utility

try
	timer(0) //off
	
	if dw_lista_0.getrow() > 0 then	

		kst_tab_memo.id_memo = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_memo")
		if kst_tab_memo.id_memo <> ki_id_memo_rtf then
			ki_id_memo_rtf = kst_tab_memo.id_memo
			if dw_dett_0.retrieve(ki_id_memo_rtf) > 0 then
//			k_memo_rtf = kiuf_memo.get_memo(kst_tab_memo)  
//			if len(k_memo_rtf) > 0 then
//				dw_dett_0.SelectTextAll( )
//				dw_dett_0.setitem( 1, "id_memo", kst_tab_memo.id_memo)
//				dw_dett_0.setredraw(false)
//				dw_dett_0.pasteRtf(k_memo_rtf) // mette il testo RTF a video
//				dw_dett_0.setredraw(true)
				
				k_return = 1
//				k_rc = dw_dett_0.Modify("DataWindow.Zoom='80'")
//				k_rc = dw_dett_0.Modify("#1.RichEdit.DisplayOnly='Yes'")

			end if
		end if
	end if

//--- Protezione campi per disabilitare la modifica 
//	kuf1_utility = create kuf_utility
//	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
//	destroy kuf1_utility
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_return

end function

public subroutine u_cambia_stato (long a_riga);//
//long k_riga = 0
st_tab_memo_utenti kst_tab_memo_utenti


try
	if a_riga > 0 then
		kst_tab_memo_utenti.id_memo_utente = dw_lista_0.getitemnumber(a_riga, "id_memo_utente")
		if kst_tab_memo_utenti.id_memo_utente > 0 then
			kst_tab_memo_utenti.stato = kiuf_memo_utenti.get_stato(kst_tab_memo_utenti)
			if kst_tab_memo_utenti.stato = kiuf_memo_utenti.kki_stato_rimosso then   // era nello stato di RIMOSSO?
				kst_tab_memo_utenti.contatore = kiuf_memo_utenti.get_contatore(kst_tab_memo_utenti)
				kiuf_memo_utenti.set_stato_nuovo(kst_tab_memo_utenti)   // prima lo metto a NUOVO
				if kst_tab_memo_utenti.contatore > 0 then
					 kiuf_memo_utenti.set_stato_letto(kst_tab_memo_utenti)  // poi se l'avevo già letto lo metto tale
				end if
			else
				 kiuf_memo_utenti.set_stato_rimosso(kst_tab_memo_utenti)  // se non era RIMOSSO lo metto tale
			end if
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


end try
end subroutine

protected subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

public function boolean u_lancia_funzione_imvc (st_open_w kst_open_w_arg);//---
//--- lancia la funzione giusta di Inserimento/Modifica/Visualizzazione/Cancellazione
//---
//--- Inp: st_open_w.flag_modalita
//--- Out: boolean: TRUE = OK
//---
boolean k_return = false
long k_riga=0
int k_esito_funzione=0
string k_errore="0 ", k_esito_funzioneX="0", k_dati_modificati="0", k_esito=""
st_open_w kst_open_w


kst_open_w = ki_st_open_w
kst_open_w.flag_modalita = kst_open_w_arg.flag_modalita


//--- controlla se utente autorizzato alla funzione in atto
//if sicurezza(kst_open_w) then

//--- disabilito i link automatici se MODIFICA o INSERIMENTO
	dw_dett_0.ki_link_standard_attivi = true
	
//--- Abilito la DW Dettaglio se disabilitata (x il giro di prima volta)
	if not dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0 then
		
		dw_dett_0.enabled = true
		
	else
		
		if dw_dett_0.rowcount( ) > 0 then
			
//--- Controllo se ho modificato dei dati nella DW DETTAGLIO (0=nessun agg., 1=aggiornare, 2=non aggiornare, 3=Annulla operazione)
			k_esito = dati_modif(trim(kiw_this_window.title))
			if len(k_esito) > 0 then 
				k_dati_modificati = left(k_esito, 1)
			end if
			if k_dati_modificati = "1" then //Fare gli aggiornamenti
	
//--- Controllo congruenza dei dati caricati e Aggiornamento  
//--- Ritorna 1 char : 0=tutto OK; 1=errore grave;
//---                      : 2=errore non grave dati aggiornati;
//---			          : 3=
//---                      il resto della stringa contiene la descrizione dell'errore   
				k_errore = aggiorna_dati()
	
			end if
		end if
	end if
	
	
//----	se Operazione di Aggiornamento OK  and  NON devo annullare tutta l'Operazione
	if Left(k_errore, 1) = "0" and k_dati_modificati <> "3" then

		
		choose case kst_open_w.flag_modalita
		
			case kkg_flag_modalita.inserimento

				dw_dett_0.reset()
				inserisci( )
				k_return = true
				
				if dw_dett_0.enabled then
					ki_resize_dw_dett = true
					u_resize()
					dw_dett_0.setfocus()		
	
					u_personalizza_dw ()
				end if
				
				
			case kkg_flag_modalita.modifica
				if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					dw_dett_0.reset()
					if modifica( ) > 0 then
						k_return = true
						
						if dw_dett_0.enabled then
							ki_resize_dw_dett = true
							u_resize()
							dw_dett_0.setfocus()		
			
							u_personalizza_dw ()
						end if
					else
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "Operazione Fallita", "Mi spiace, dati non trovati in archivio~n~r" +&
																		"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
					end if
				end if
				
			case kkg_flag_modalita.visualizzazione
				if dw_lista_0.rowcount( ) > 0 or  (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					dw_dett_0.reset()
					if visualizza() > 0 then
						k_return = true
						
						if dw_dett_0.enabled then
							ki_resize_dw_dett = true
							u_resize()
							dw_dett_0.setfocus()		
			
							u_personalizza_dw ()
						end if
					else
						kguo_exception.inizializza( )
						kguo_exception.messaggio_utente( "Operazione Fallita", "Mi spiace, dati non trovati in archivio~n~r" +&
																		"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
					end if
				end if
				
			case kkg_flag_modalita.cancellazione
				if dw_lista_0.rowcount( ) > 0 or (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
					k_esito_funzioneX = cancella( )
					if len(trim(k_esito_funzioneX)) > 0 then
						if left(k_esito_funzioneX,1) = "0" then
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
							kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						end if
					end if
				end if
		
				
		end choose
		

		attiva_tasti()
		
	end if
	
//end if	


return k_return



end function

on w_xxx_memo_l_utente.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_xxx_memo_l_utente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo)
end on

event timer;call super::timer;////
//if dw_dett_0.visible then
//	visualizza_dettaglio( )
//end if
//
end event

type st_ritorna from w_g_tab0`st_ritorna within w_xxx_memo_l_utente
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_xxx_memo_l_utente
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_xxx_memo_l_utente
integer x = 978
integer y = 1080
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_xxx_memo_l_utente
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_xxx_memo_l_utente
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_xxx_memo_l_utente
integer x = 777
integer y = 1188
integer taborder = 30
end type

type cb_modifica from w_g_tab0`cb_modifica within w_xxx_memo_l_utente
integer x = 1737
integer y = 1180
integer height = 96
integer taborder = 90
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_xxx_memo_l_utente
integer x = 325
integer y = 1168
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_xxx_memo_l_utente
integer x = 2126
integer y = 1180
integer height = 96
integer taborder = 100
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_xxx_memo_l_utente
integer x = 1307
integer y = 1184
integer height = 96
integer taborder = 80
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_xxx_memo_l_utente
boolean visible = true
integer x = 1202
integer y = 1312
integer width = 1600
integer height = 476
boolean enabled = true
string dataobject = "d_memo_link_l"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationnever!
boolean hsplitscroll = false
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_xxx_memo_l_utente
integer x = 5
integer y = 708
long textcolor = 8388608
long backcolor = 8388608
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_xxx_memo_l_utente
integer x = 37
integer y = 64
integer width = 2807
integer height = 1044
end type

event dw_lista_0::rowfocuschanged;call super::rowfocuschanged;//
if dw_dett_0.visible then
//manda in crash m2000	timer(1.0) 
end if


end event

event dw_lista_0::clicked;call super::clicked;//
if left(dwo.name,9) = "p_img_del" then
	u_cambia_stato(row)	
end if
end event

event dw_lista_0::doubleclicked;call super::doubleclicked;////
//				
//	if dw_lista_0.rowcount( ) > 0 or  (not dw_lista_0.enabled and dw_dett_0.enabled and dw_dett_0.rowcount( ) > 0)  then 
//		dw_dett_0.reset()
//		if visualizza_dettaglio( ) > 0 then
////			if dw_dett_0.enabled then
//				ki_resize_dw_dett = true
//				resize_dw()
//				dw_dett_0.setfocus()		
//
//				u_personalizza_dw ()
////			end if
//		else
//			kguo_exception.inizializza( )
//			kguo_exception.messaggio_utente( "Operazione Fallita", "Mi spiace, dati non trovati in archivio~n~r" +&
//															"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
//		end if
//	end if
//

end event

type dw_guida from w_g_tab0`dw_guida within w_xxx_memo_l_utente
boolean visible = true
integer width = 2789
boolean enabled = true
string dataobject = "d_xxx_memo_l_utente_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true
string k_stato_cercato


		
//--- Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa )
	
	this.accepttext( )
		
	if isnull(dw_guida.getitemstring(1, "tipo")) then
		k_stato_cercato = "9"
	else
		k_stato_cercato = trim(dw_guida.getitemstring(1, "tipo") )
	end if
	

//--- solo se ricerco key diverso
	if k_stato_cercato <> ki_stato_cercato or dw_lista_0.rowcount() = 0 then
		
		ki_stato_cercato = k_stato_cercato
		
		u_retrieve_dw_lista()
			
	end if

	SetPointer(kkg.pointer_default)

end event

type dw_periodo from uo_dw_periodo within w_xxx_memo_l_utente
integer x = 416
integer y = 1468
integer taborder = 50
boolean bringtotop = true
end type

event ue_clicked;call super::ue_clicked;//
try
	inizializza( )
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

		
end event

