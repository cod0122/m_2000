$PBExportHeader$w_sv_skedulati_log.srw
forward
global type w_sv_skedulati_log from w_g_tab0
end type
type cb_schedula from commandbutton within w_sv_skedulati_log
end type
type p_schedula from picture within w_sv_skedulati_log
end type
end forward

global type w_sv_skedulati_log from w_g_tab0
integer width = 2894
integer height = 1780
string icon = "AppIcon!"
boolean ki_utente_abilitato = true
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
cb_schedula cb_schedula
p_schedula p_schedula
end type
global w_sv_skedulati_log w_sv_skedulati_log

type variables
//
//--- tempo di attesta tra un timer e l'altro
private constant integer kki_timer_attesa=180

private long ki_conta_timer=0
private st_sv_eventi_sked_log kist_sv_eventi_sked_log
private kuf_sv_skedula kiuf_sv_skedula

private kuo_timer_sked kiuo_timer_sked

end variables

forward prototypes
protected function integer inserisci ()
protected function string inizializza ()
public function boolean timer_start ()
public function boolean timer_stop ()
protected subroutine attiva_menu ()
protected function string leggi_liste ()
public subroutine u_set_operazione ()
protected subroutine leggi_liste_reset ()
protected subroutine open_start_window ()
public subroutine u_timer ()
end prototypes

protected function integer inserisci ();//
long k_righe
st_sv_eventi_sked_log kst_sv_eventi_sked_log

	k_righe = dw_lista_0.rowcount()

//--- oltre un tot di righe pulisco il log
	if k_righe > 1500 then
		dw_lista_0.reset()
		k_righe = 0
	end if
	
	dw_lista_0.scrolltorow(dw_lista_0.insertrow(1)) // nuova riga
	if k_righe = 0 then
		kst_sv_eventi_sked_log = kist_sv_eventi_sked_log
		kist_sv_eventi_sked_log.log_testo = "ESEGUITO LO START DEGLI EVENTI DA ELABORARE "
		u_set_operazione()
		kist_sv_eventi_sked_log = kst_sv_eventi_sked_log
		
		dw_lista_0.scrolltorow(dw_lista_0.insertrow(1))
	end if
		

return (0)


end function

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
long k_codice
string k_attiva
int k_importa = 0
pointer oldpointer  // Declares a pointer variable




//--- nessun tasto funzionale e' necessario
	ki_nessun_tasto_funzionale=true


	if not cb_schedula.visible then

//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
//		if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 
//	
//			k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
//					  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
//					  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
//			
//			k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_lista_0)
//	
//		end if
		
	//--- azzero contatore delle volte di trigger del timer	
		ki_conta_timer=0
			
	//--- setto a null data e ora cosi' li riempie inserisci()		
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "attendere il prossimo evento...."
		inserisci()
		u_set_operazione( )
		
	//--- setto a null data e ora cosi' li riempie inserisci()		
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
	//--- lancio il timer	
		if timer_start() then
	//--- setto a null il testo cosi' li riempie inserisci()		
			setnull(kist_sv_eventi_sked_log.log_testo)
		else
			kist_sv_eventi_sked_log.log_testo = "ATTENZIONE: operazione Fallita! timer eventi non rilanciato"
			inserisci()
			u_set_operazione( )
		end if
	
		if kiuf_sv_skedula.ds_eventi_da_lanciare_inizializzazione() then
	
			u_timer( )
			//kiw_this_window.triggerevent(timer!) 
			
		else
			kist_sv_eventi_sked_log.log_testo = "ATTENZIONE: operazione Fallita! timer eventi BLOCCATO uscire dalla Procedura e tentare il rilancio"
			inserisci()
			u_set_operazione( )
		end if

		SetPointer(oldpointer)

	else
		cb_schedula.bringtotop = true
	end if

	attiva_tasti()


return k_return



end function

public function boolean timer_start ();//
boolean k_return = false

if kiuo_timer_sked.start(kki_timer_attesa) > 0 then 
	k_return = true
end if
////--- ogni "tanto" (kki_timer_attesa) scatena l'evento timer()
//if timer(kki_timer_attesa) > 0 then //, kiw_this_window) > 0 then 
//	k_return = true
//end if


return k_return
end function

public function boolean timer_stop ();//
boolean k_return = false

//--- Ferma l'evento timer()
if kiuo_timer_sked.stop() > 0 then 
	k_return = true
end if

////--- Ferma l'evento timer()
//if timer(0) > 0 then //,kiw_this_window) > 0 then 
//	k_return = true
//end if


return k_return
end function

protected subroutine attiva_menu ();//
st_ordina_lista.enabled = true
st_aggiorna_lista.enabled = true
super::attiva_menu()

end subroutine

protected function string leggi_liste ();//--- rilegge gli eventi
u_timer()

return "0"
end function

public subroutine u_set_operazione ();//
//--- imposta descrizione operazione sul dw
//
datetime k_now
	
	dw_lista_0.setcolumn(1)
	
	k_now = kGuf_data_base.prendi_dataora( )
	
	if isnull(kist_sv_eventi_sked_log.log_data) then
		kist_sv_eventi_sked_log.log_data = date(k_now)
	end if
	if isnull(kist_sv_eventi_sked_log.log_ora) then
		kist_sv_eventi_sked_log.log_ora = time(k_now)
	end if
	if isnull(kist_sv_eventi_sked_log.log_testo) then
		kist_sv_eventi_sked_log.log_testo = "ok, proseguo con il controllo degli eventi..."
	end if
	dw_lista_0.setitem(1, "log_data", kist_sv_eventi_sked_log.log_data)
	dw_lista_0.setitem(1, "log_ora", kist_sv_eventi_sked_log.log_ora )
	dw_lista_0.setitem(1, "log_testo", kist_sv_eventi_sked_log.log_testo)
	
//--- Posiziona il cursore 
	dw_lista_0.setfocus() 


end subroutine

protected subroutine leggi_liste_reset ();//
//======================================================================
//=== Resetta elenco 
//======================================================================
//


//	ki_riga_selezionata = dw_lista_0.getrow()
//	dw_lista_0.reset()





end subroutine

protected subroutine open_start_window ();//
kuf_base  kuf1_base


try
	kiuo_timer_sked = create kuo_timer_sked
	kuf1_base = create kuf_base

//--- condivide con l'evento timer l'elenco
	kiuo_timer_sked.kiw_super = this

//--- Reimposta le Variabli Globali dei Dati di Ora legale e UTC 	
	kuf1_base.set_oralegale_utc()

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_base) then	destroy kuf1_base

end try


end subroutine

public subroutine u_timer ();//--- 
//--- scatena gli eventi da lanciare
//---
string k_errore="", k_cmd_lanciato="", k_esito=""
//kuf_db kuf1_db


//--- ferma il timer di skedulazione
	timer_stop()

	try
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "in ricerca evento da lanciare...."
		u_set_operazione( )

		ki_conta_timer++
	
//--- setto a null data e ora cosi' li riempie inserisci()		
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "verifica se evento da lanciare n. "	+ string(ki_conta_timer) + ". Prego attendere.... " 
	
//		inserisci()  // Inserisce una nuova riga
	
//--- valuta cosa lanciare		
		if not kiuf_sv_skedula.ds_eventi_da_lanciare_run() then
			
			setnull(kist_sv_eventi_sked_log.log_data)
			setnull(kist_sv_eventi_sked_log.log_ora)
			kist_sv_eventi_sked_log.log_testo = "ok, NESSUN evento da eseguire per la verifica n. " + string(ki_conta_timer) + ". "

		else
			
//--- se ho disconnesso il DB allora riprova la connessione			
			if kiuf_sv_skedula.ki_db_disconnesso then
				dw_dett_0.settransobject ( kguo_sqlca_db_magazzino )
				dw_lista_0.settransobject ( kguo_sqlca_db_magazzino )
			end if
			
			
			k_cmd_lanciato = ""
			if upperbound(kiuf_sv_skedula.kist_sv_eventi_sked[]) > 0 then
				k_esito = kiuf_sv_skedula.kist_sv_eventi_sked[1].esito 
				if LenA(trim(kiuf_sv_skedula.kist_sv_eventi_sked[1].cmd_dos)) > 0 then
					k_cmd_lanciato =	trim(kiuf_sv_skedula.kist_sv_eventi_sked[1].cmd_dos)
				else
					k_cmd_lanciato = trim(kiuf_sv_skedula.kist_sv_eventi_sked[1].id_menu_window)
				end if
			else
				k_esito = "Esito non Rilevato! "
				k_cmd_lanciato = "Comando Non Rilevato! "
			end if
			setnull(kist_sv_eventi_sked_log.log_data)
			setnull(kist_sv_eventi_sked_log.log_ora)
			kist_sv_eventi_sked_log.log_testo = "n. " + string(ki_conta_timer) + ",   Lanciato: " + k_cmd_lanciato + ",  ESITO: " + k_esito 

		end if
		u_set_operazione()

//--- controlla se DB connesso se no lo ricconnette grazie alla gestione errori standard della dw
//		dw_dett_0.retrieve() 

//--- Se tutto OK, riattiva il timer di skedulazione
		timer_start()

//--- setto a null data e ora cosi' li riempie inserisci()		
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "attendere il prossimo evento...."
		inserisci()
		u_set_operazione( )
	
	catch (uo_exception kuo_exception1)
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "KO, si è verificato un errore GRAVE, schedulatore FERMO!! (" + trim(kGuo_exception.getmessage( )) + ") "
		u_set_operazione()

		
	catch (RuntimeError re)
		setnull(kist_sv_eventi_sked_log.log_data)
		setnull(kist_sv_eventi_sked_log.log_ora)
		kist_sv_eventi_sked_log.log_testo = "KO, si è verificato un errore GRAVE di 'RUNTIME', schedulatore FERMO!! "
		u_set_operazione()
		
	finally		
////--- riattiva il timer di skedulazione
//		timer_start()
//
	end try
end subroutine

on w_sv_skedulati_log.create
int iCurrent
call super::create
this.cb_schedula=create cb_schedula
this.p_schedula=create p_schedula
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_schedula
this.Control[iCurrent+2]=this.p_schedula
end on

on w_sv_skedulati_log.destroy
call super::destroy
destroy(this.cb_schedula)
destroy(this.p_schedula)
end on

event timer;//--- 
//--- scatena gli eventi da lanciare
//---
post u_timer( )

end event

event close;call super::close;//
if isvalid(kiuf_sv_skedula) then destroy kiuf_sv_skedula
if isvalid(kiuo_timer_sked) then destroy kiuo_timer_sked
 
end event

event open;call super::open;//
kiuf_sv_skedula = create kuf_sv_skedula
end event

type st_ritorna from w_g_tab0`st_ritorna within w_sv_skedulati_log
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sv_skedulati_log
boolean enabled = true
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sv_skedulati_log
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sv_skedulati_log
end type

type st_stampa from w_g_tab0`st_stampa within w_sv_skedulati_log
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sv_skedulati_log
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sv_skedulati_log
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sv_skedulati_log
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sv_skedulati_log
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sv_skedulati_log
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sv_skedulati_log
integer x = 9
integer y = 532
integer width = 1019
integer height = 304
string dataobject = "d_query_db_connessione"
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_sv_skedulati_log
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sv_skedulati_log
integer y = 20
string dataobject = "d_sv_eventi_sked_log"
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_dw_visibile_in_open_window = false
end type

type dw_guida from w_g_tab0`dw_guida within w_sv_skedulati_log
end type

type cb_schedula from commandbutton within w_sv_skedulati_log
integer x = 471
integer y = 112
integer width = 1170
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "      Clicca qui per lanciare lo Schedulatore "
end type

event clicked;//
dw_lista_0.setredraw( false)

p_schedula.visible = false
this.visible = false
dw_lista_0.visible = true
u_resize()

dw_lista_0.setredraw( true)

inizializza()

end event

type p_schedula from picture within w_sv_skedulati_log
integer x = 503
integer y = 132
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "RunSCC!"
boolean focusrectangle = false
end type

