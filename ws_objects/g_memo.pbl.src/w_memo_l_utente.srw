$PBExportHeader$w_memo_l_utente.srw
forward
global type w_memo_l_utente from w_g_tab0
end type
type dw_periodo from uo_dw_periodo within w_memo_l_utente
end type
end forward

global type w_memo_l_utente from w_g_tab0
integer width = 3282
integer height = 2000
string title = "Memo"
boolean ki_toolbar_window_presente = true
boolean ki_resize_dw_dett = true
boolean ki_reset_dopo_save_ok = false
dw_periodo dw_periodo
end type
global w_memo_l_utente w_memo_l_utente

type variables

private kuf_memo kiuf_memo
private st_tab_memo kist_tab_memo
private st_tab_memo kist_tab_memo_ultimo_cercato
private string ki_tipo = "T"
private string ki_tipo_ultimo_cercato = ""

end variables

forward prototypes
protected subroutine forma_elenco ()
private function string inizializza ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
protected subroutine open_start_window ()
public function integer u_retrieve_dw_lista ()
private subroutine cambia_periodo_elenco ()
protected function integer visualizza ()
protected function integer modifica ()
protected function integer inserisci ()
protected function string cancella ()
protected function integer visualizza_dettaglio ()
public function boolean u_lancia_funzione_imvc (st_open_w kst_open_w_arg)
end prototypes

protected subroutine forma_elenco ();
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
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//
//	end if
		
//	if k_importa <= 0 then // Nessuna importazione eseguita

//--- Se non ho indicato un cliente particolare mi fermo e chiedo all'operatore
	if ki_st_open_w.flag_primo_giro = "S" then
//		if len(trim(ki_st_tab_clienti.rag_soc_10)) = 0 and ki_st_tab_clienti.tipo = "*" then
//
			dw_guida.setfocus( )
//			dw_guida.setitem(1,"rag_soc_1", "")
//
//		else
//			dw_guida.setitem(1,"rag_soc_1", string(ki_st_tab_clienti.rag_soc_10 ))
//		end if
//		
//		dw_guida.setcolumn("rag_soc_1")

	end if


	if ki_st_open_w.flag_primo_giro <> "S" or trim(kist_tab_memo.tipo_sv) <> "" then

//		if dw_lista_0.retrieve(ki_st_tab_clienti.rag_soc_10, ki_st_tab_clienti.tipo) < 1 then
		if u_retrieve_dw_lista() < 1 then
			
			k_return = "1Non ho trovata alcun MEMO "

			SetPointer(oldpointer)
			messagebox("Lista MEMO Vuota", 	"Nesun Doscumento Trovato per la richiesta fatta")

		end if		
	end if



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
	

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
end subroutine

protected subroutine open_start_window ();//
string	k_tipo=""


	kiuf_memo = create kuf_memo
//	ki_toolbar_window_presente=true


//--- Salvo il passato nei parametri di input
	
//	if trim(ki_st_open_w.key2) > " " then
//		k_tipo = trim(ki_st_open_w.key2)
//	else
//		k_tipo = "T"
//	end if

	dw_guida.insertrow(0)
	dw_guida.setitem(1, "tipo", k_tipo)
	
	//--- inizializza box periodo
	dw_periodo.inizializza( kiw_this_window )

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
long k_id_utente=0
int k_stato_da, k_stato_a
datetime k_dataora_fin
pointer oldpointer  // Declares a pointer variable


	try
		
//--- Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)
		
		if ki_tipo = 'R' then // Rimossi
			k_stato_da = 8
			k_stato_a = 8
			kist_tab_memo_ultimo_cercato.utente_ins = "*"
		else
			k_stato_da = 0
			k_stato_a = 7
			if ki_tipo = "M" then //modificati da me
				kist_tab_memo_ultimo_cercato.utente_ins = string(kguo_utente.get_id_utente( ))
			else
				kist_tab_memo_ultimo_cercato.utente_ins = "*"
			end if
		end if
	
		kist_tab_memo_ultimo_cercato.dataora_ins =  datetime(dw_periodo.ki_data_ini) //  datetime(dw_periodo.getitemdate(1, "data_dal"))
		k_dataora_fin =  datetime(dw_periodo.ki_data_fin) 
		k_id_utente = kguo_utente.get_id_utente( )
		
		dw_lista_0.reset()
		k_return = dw_lista_0.retrieve(k_stato_da, k_stato_a, kist_tab_memo_ultimo_cercato.utente_ins, k_id_utente, kist_tab_memo_ultimo_cercato.dataora_ins, k_dataora_fin)
		dw_lista_0.setfocus( )
		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()

	finally
		attiva_tasti( )
		SetPointer(oldpointer)
		
	end try
	
return k_return

end function

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

protected function integer visualizza ();//
//=== Legge il rek dalla DW lista per la Visualizzazione
long k_riga
st_memo kst_memo
st_tab_memo_link kst_tab_memo_link
st_tab_g_0 kst_tab_g_0
kuf_memo_link kuf1_memo_link


try
	
		CHOOSE CASE  kidw_selezionata.dataobject
			CASE "d_memo_l_utente"
			
				k_riga = dw_lista_0.getrow()
				if k_riga > 0 then
				
					kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
						
					if kst_memo.st_tab_memo.id_memo  > 0 then
				
						kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione)
						
					end if
				end if

			CASE "d_memo_link_l"
			
				k_riga = dw_dett_0.getrow()
				if k_riga > 0 then
				
					kst_tab_memo_link.id_memo_link = dw_dett_0.getitemnumber( k_riga, "id_memo_link" ) 
						
					if kst_tab_memo_link.id_memo_link  > 0 then
				
						kuf1_memo_link = create kuf_memo_link
						kuf1_memo_link.u_attiva_funzione(kst_tab_memo_link, kkg_flag_modalita.visualizzazione)
						
					end if
				end if
				
		END CHOOSE				
//	end if
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga


end function

protected function integer modifica ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_memo kst_memo
st_tab_memo_link kst_tab_memo_link
st_tab_g_0 kst_tab_g_0
//kuf_menu_window kuf1_menu_window
kuf_memo_link kuf1_memo_link


try
	
		CHOOSE CASE  kidw_selezionata.dataobject
			CASE "d_memo_l_utente"
			
				k_riga = dw_lista_0.getrow()
				if k_riga > 0 then
				
					kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
						
					if kst_memo.st_tab_memo.id_memo  > 0 then
				
						kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.modifica)
						
					end if
				end if


			CASE "d_memo_link_l"
				k_riga = dw_dett_0.getrow()
				if k_riga > 0 then
				
					kst_tab_memo_link.id_memo_link = dw_dett_0.getitemnumber( k_riga, "id_memo_link" ) 
						
					if kst_tab_memo_link.id_memo_link  > 0 then
				
						kuf1_memo_link = create kuf_memo_link
						kuf1_memo_link.u_attiva_funzione(kst_tab_memo_link, kkg_flag_modalita.modifica)
						
					end if
				end if
				
		END CHOOSE				

		
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
	
	kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.inserimento) 

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga
end function

protected function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_memo kst_tab_memo
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_memo.id_memo = dw_lista_0.getitemnumber(k_riga, "id_memo")
	kst_tab_memo.titolo  = dw_lista_0.getitemstring(k_riga, "titolo")

	if isnull(kst_tab_memo.titolo) = true or trim(kst_tab_memo.titolo) = "" then
		kst_tab_memo.titolo = "*senza titolo* " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina MEMO", "Sei sicuro di voler Cancellare il MEMO " + string(kst_tab_memo.id_memo)  + " : ~n~r" &
	         + trim(kst_tab_memo.titolo),  &
				question!, yesno!, 2) = 1 then
		
		
		try
		
//=== Cancella la riga dal data windows di lista
			if kiuf_memo.tb_delete( kst_tab_memo ) then

		
				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

				dw_lista_0.setfocus()
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Cancellazione MEMO", "Operazione non eseguita")
			end if

			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente( "Cancellazione Fallita", "")

			attiva_tasti()

		end try


	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Cancellazione MEMO", "Operazione Annullata")

	end if
end if

return " "

end function

protected function integer visualizza_dettaglio ();//---
//--- Espone il dettaglio
//--- Torna : <=0=Ko, >0=Ok
//---
int k_return
long k_key
kuf_utility kuf1_utility


	timer(0) //off
	
	if dw_lista_0.getrow() > 0 then	
		k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_memo")
		if  dw_dett_0.rowcount( ) > 0 then
			if k_key <> dw_dett_0.getitemnumber(1, "id_memo") then
				k_return = dw_dett_0.retrieve( k_key ) 
			end if
		else
			k_return = dw_dett_0.retrieve( k_key ) 
		end if
	end if

//--- Protezione campi per disabilitare la modifica 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility


return k_return

end function

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


	
	choose case kst_open_w.flag_modalita
	
		case kkg_flag_modalita.inserimento

			inserisci( )
			k_return = true

		case kkg_flag_modalita.modifica
			if modifica( ) > 0 then
				k_return = true
					
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione Fallita", "Mi spiace, dati non trovati in archivio~n~r" +&
																"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
			end if
			
		case kkg_flag_modalita.visualizzazione
			if visualizza() > 0 then
				k_return = true
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Operazione Fallita", "Mi spiace, dati non trovati in archivio~n~r" +&
																"Provare a riaggiornare l'elenco e rifare l'operazione appena tentata")
			end if
			
		case kkg_flag_modalita.cancellazione
			k_esito_funzioneX = cancella( )
			if len(trim(k_esito_funzioneX)) > 0 then
				if left(k_esito_funzioneX,1) = "0" then
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
				end if
			end if
	
			
	end choose
	

	attiva_tasti()


return k_return



end function

on w_memo_l_utente.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
end on

on w_memo_l_utente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_periodo)
end on

event timer;call super::timer;////
//if dw_dett_0.visible then
//	visualizza_dettaglio( )
//end if

end event

type st_ritorna from w_g_tab0`st_ritorna within w_memo_l_utente
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_memo_l_utente
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_memo_l_utente
integer x = 978
integer y = 1080
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_memo_l_utente
integer x = 2514
integer y = 1180
integer height = 92
integer taborder = 110
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_memo_l_utente
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_memo_l_utente
integer x = 777
integer y = 1188
integer taborder = 30
end type

type cb_modifica from w_g_tab0`cb_modifica within w_memo_l_utente
integer x = 1737
integer y = 1180
integer height = 96
integer taborder = 90
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_memo_l_utente
integer x = 325
integer y = 1168
integer height = 96
integer taborder = 130
end type

type cb_cancella from w_g_tab0`cb_cancella within w_memo_l_utente
integer x = 2126
integer y = 1180
integer height = 96
integer taborder = 100
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_memo_l_utente
integer x = 1307
integer y = 1184
integer height = 96
integer taborder = 80
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_memo_l_utente
boolean visible = true
integer x = 1202
integer y = 1312
integer width = 1600
integer height = 476
boolean enabled = true
string dataobject = "d_memo_link_l"
boolean hsplitscroll = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_memo_l_utente
integer x = 5
integer y = 708
long textcolor = 8388608
long backcolor = 8388608
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_memo_l_utente
integer x = 37
integer y = 28
integer width = 2807
integer height = 1044
string dataobject = "d_memo_l_utente"
end type

event dw_lista_0::rowfocuschanged;call super::rowfocuschanged;//

//	timer(1.0) 


end event

type dw_guida from w_g_tab0`dw_guida within w_memo_l_utente
boolean visible = true
integer width = 2789
boolean enabled = true
string dataobject = "d_memo_l_utente_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---	
//--- 
//---
boolean k_elabora=true
st_tab_memo kst_tab_memo


	this.accepttext( )
		
	if isnull(ki_tipo) or ki_tipo = "T" then
		ki_tipo = ""  
	else
		ki_tipo = trim(dw_guida.getitemstring(1, "tipo") )
	end if


//--- solo se ricerco key diverso
	if ki_tipo_ultimo_cercato <> ki_tipo or dw_lista_0.rowcount() = 0 then
		
		ki_tipo_ultimo_cercato = kst_tab_memo.tipo_sv
		
		u_retrieve_dw_lista()
			
	end if

end event

type dw_periodo from uo_dw_periodo within w_memo_l_utente
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

