$PBExportHeader$w_sr_utenti_password.srw
forward
global type w_sr_utenti_password from w_super
end type
type cb_ritorna from commandbutton within w_sr_utenti_password
end type
type cb_aggiorna from commandbutton within w_sr_utenti_password
end type
type dw_pwd from datawindow within w_sr_utenti_password
end type
end forward

global type w_sr_utenti_password from w_super
boolean visible = true
integer width = 2400
integer height = 784
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
event u_open ( )
cb_ritorna cb_ritorna
cb_aggiorna cb_aggiorna
dw_pwd dw_pwd
end type
global w_sr_utenti_password w_sr_utenti_password

type variables
//

protected st_tab_sr_utenti kist_tab_sr_utenti
protected w_super kiw_this_window

end variables

forward prototypes
protected function string inizializza ()
protected function string aggiorna_tabelle ()
protected subroutine attiva_tasti ()
protected subroutine open_start_window ()
public function string aggiorna ()
protected subroutine sicurezza_open ()
protected function boolean sicurezza (st_open_w kst_open_w)
protected subroutine set_titolo_window ()
public subroutine set_window_size ()
public subroutine set_pos_cursore ()
public subroutine u_resize ()
end prototypes

event u_open();//
//--- Operazioni iniziali di OPEN 
//
int k_ctr
pointer kpointer_orig
kuf_utility kuf1_utility


	kpointer_orig = setpointer(hourglass!)

	u_resize( )

	kuf1_utility = create kuf_utility

//--- l'utente e' già stato autorizzato? (setta la ki_utente_abititato)
   if ki_st_open_w.flag_utente_autorizzato then
		ki_utente_abilitato = true
	else
//--- controlla SR 		
		sicurezza_open() 
	end if

	inizializza()
	
	ki_st_open_w.flag_primo_giro = "N"
	
	setpointer(kpointer_orig)
				
end event

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1 e 2=Retrieve fallita (2=uscita Window)
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_errore = 0
string k_key
kuf_utility kuf1_utility
kuf_cripta kuf1_cripta


//=== 

	k_key = trim(ki_st_open_w.key1)
	kist_tab_sr_utenti.id = long(k_key)
	
	dw_pwd.settransobject( kguo_sqlca_db_magazzino )
	
	if kist_tab_sr_utenti.id > 0  then

		if dw_pwd.retrieve(kist_tab_sr_utenti.id) < 1 then
			k_errore = 1
			k_return = "1Nessuna Informazione trovata "
	
			messagebox("Accesso Password Utente", &
				"Mi spiace, ma non e' stato Trovato nulla per la richiesta fatta ~n~r" + &
				"(Dati ricercati :" + k_key + ")" )
	
		end if
	else
		k_errore = 1

		k_return = "1Nessuna Informazione trovata "
		messagebox("Accesso Password Utente", &
			"Utente non indicato, operazione interrotta ~n~r" + &
			"(Dati ricercati :" + k_key + ")" )
			
	end if


if k_errore = 0 then
	
	kist_tab_sr_utenti.password_crypt = dw_pwd.getitemstring(dw_pwd.getrow(), "password_crypt")
//--- decripta la password
	if LenA(trim(kist_tab_sr_utenti.password_crypt)) > 0 then
		kuf1_cripta = create kuf_cripta
		kist_tab_sr_utenti.password = kuf1_cripta.of_decrypt(trim(kist_tab_sr_utenti.password_crypt))
		destroy kuf1_cripta
      	dw_pwd.setitem(dw_pwd.getrow(), "password_w", kist_tab_sr_utenti.password)		
		dw_pwd.SetItemStatus(dw_pwd.getrow(), 0, Primary!, NotModified!)
	end if
end if


//--- inabilito le mofidifiche sulla dw
if k_errore = 0 then
	
//--- Inabilita campi alla modifica se Vsualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
	   or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione then
		
		kuf1_utility.u_proteggi_dw("1", 0, dw_pwd)

	else		
		
//--- S-protezione campi per riabilitare la modifica a parte la chiave
      kuf1_utility.u_proteggi_dw("0", 0, dw_pwd)

	end if
	destroy kuf1_utility
	
end if

set_pos_cursore()


return k_return



end function

protected function string aggiorna_tabelle ();//
//=== Update delle Tabelle
string k_return = "0 "
kuf_sr_sicurezza kuf1_sr_sicurezza
st_esito kst_esito


	dw_pwd.accepttext( )

	if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		dw_pwd.setitemstatus(1, 0, primary!, NewModified!)
	end if

	kist_tab_sr_utenti.id = dw_pwd.getitemnumber(dw_pwd.getrow(), "id")
	kist_tab_sr_utenti.password = dw_pwd.getitemstring(dw_pwd.getrow(), "password_w")

	kuf1_sr_sicurezza = create kuf_sr_sicurezza
	kst_esito = kuf1_sr_sicurezza.tb_update_password ( kist_tab_sr_utenti )
	destroy kuf1_sr_sicurezza

	if kst_esito.esito = "0" then

		dw_pwd.SetItemStatus(dw_pwd.getrow(), 0, Primary!, NotModified!)
		
	else

		k_return = "1Errore: " + trim(kst_esito.sqlerrtext)

	end if

return k_return


end function

protected subroutine attiva_tasti ();//
cb_aggiorna.enabled=true
//attiva_menu()
end subroutine

protected subroutine open_start_window ();//
//--- ma xchè devo fare sta schifezza
//ki_resize_dw_dett=true
//resize_dw()
end subroutine

public function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle C_colore
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 "
pointer kpointer_1
st_esito kst_esito



try	

	kpointer_1 = setpointer(HourGlass!)

//--- Funzione di ggiornamento tabelle 
//---           Ritorna : 0=OK; 1=Errore agg. grave; 2=Errore agg. secondario
	k_return = aggiorna_tabelle()

		
//--- ANOMALIA!		
	if Left(k_return, 1) = "1" then

		kguo_sqlca_db_magazzino.db_rollback( )
//		if kst_esito.esito <> kkg_esito.ok then
//			k_return += "~n~rfallito anche il 'recupero' dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
//		end if
//		k_return += "~n~rPrego, controllare i dati !! "
		
	else
//--- OK!		

//--- Commit		
		kst_esito = kguo_sqlca_db_magazzino.db_commit()
		if kst_esito.esito <> kkg_esito.ok then
			k_return = "3" + "Fallita conferma di aggiornamento archivi (COMMIT), errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
		end if
			
		
	end if

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1Errore: " + kst_esito.sqlerrtext + " (" + string(kst_esito.sqlcode ) + ")" 


finally
	setpointer(kpointer_1)


end try




//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore tab ;
//=== 		 : 2=errore 
//===			 : 3=Commit fallita

if LeftA(k_return, 1) = "0" then
//	kiuf1_sync_window.set_funzione_aggiornata()  // x sincronizzare i dati con il chiamante
	
	cb_ritorna.triggerevent( clicked! )
	
else
	if Left(k_return, 1) = "1" then
		messagebox("Operazione di Aggiornamento Non Eseguita !!", &
			Mid(k_return, 2))
	else
		if Left(k_return, 1) = "2" then
			messagebox("Aggiornamento Parziale degli Archivi !!", &
				Mid(k_return, 2))
		else
			if Left(k_return, 1) = "3" then
				messagebox("Registrazione dati : problemi nella 'Commit' !!", &
					"Provare chiudere e ripetere le operazioni eseguite")
				else
			end if
		end if
	end if
	set_pos_cursore()
	
end if


return k_return

end function

protected subroutine sicurezza_open ();//
//=== Controlla se funzione Autorizzata o meno 
//

	ki_utente_abilitato = sicurezza(ki_st_open_w)
	if not ki_utente_abilitato then

		smista_funz( KKG_FLAG_RICHIESTA.esci )

	
	end if



end subroutine

protected function boolean sicurezza (st_open_w kst_open_w);//
//=== Controlla se funzione Autorizzata (=TRUE) o meno (=FALSE) 
//
boolean k_return=false
kuf_sr_sicurezza kuf1_sr_sicurezza


	kuf1_sr_sicurezza = create kuf_sr_sicurezza
	k_return = kuf1_sr_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sr_sicurezza
	
	if not k_return then

		kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_noAUT )
		if len(trim(kst_open_w.id_programma)) > 0 and len(trim(kst_open_w.id_programma)) > 0 then
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta non e' stata abilitata: "  + trim(kst_open_w.id_programma) + " - " + trim(kst_open_w.flag_modalita))
		else
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta non e' stata abilitata! " )
		end if
	
	end if


return k_return

end function

protected subroutine set_titolo_window ();//
	if isnull(ki_st_open_w.id_programma) then
		ki_st_open_w.id_programma = "NULL"
	end if
	if isnull(ki_st_open_w.window_title) then
		ki_st_open_w.window_title = this.title
	end if

	if LenA(trim(ki_st_open_w.window_title )) > 0 then
		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + ki_st_open_w.window_title 
	else
		this.title = "<" + trim(ki_st_open_w.id_programma) + "> " + trim(this.title)
	end if
	ki_win_titolo_orig = this.title

end subroutine

public subroutine set_window_size ();
end subroutine

public subroutine set_pos_cursore ();//
//--- posiziona il cursore

	dw_pwd.setfocus( )
	dw_pwd.setcolumn("password_w")


end subroutine

public subroutine u_resize ();//
dw_pwd.x = 1
dw_pwd.y = 1
dw_pwd.height = this.height
dw_pwd.width = this.width


end subroutine

on w_sr_utenti_password.create
int iCurrent
call super::create
this.cb_ritorna=create cb_ritorna
this.cb_aggiorna=create cb_aggiorna
this.dw_pwd=create dw_pwd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ritorna
this.Control[iCurrent+2]=this.cb_aggiorna
this.Control[iCurrent+3]=this.dw_pwd
end on

on w_sr_utenti_password.destroy
call super::destroy
destroy(this.cb_ritorna)
destroy(this.cb_aggiorna)
destroy(this.dw_pwd)
end on

event open;//
//=== Parametri di Input : 1  lung 2   scelta; 
//===								3  lung 20  Key principale
//===								23 lung 1   's'=adatta windows alla definiz.
//===								24 lung 26  Libero x future implem
//===								50 lung ??  Personalizzabile
//===								
//
long k_ctr
datawindow kdw_1, kdw_2
kuf_utility kuf1_utility  
kuf_menu kuf1_menu
st_tab_menu_window kst_tab_menu_window
pointer kpointer_orig

//--- INIZIO OPERAZIONI PRELIMINARI --------------------------------------------------------------------------
	this.setredraw(false)

//--- Imposta il flag di Giro di 'prima Volta' x evitare alcuni controlli 
	ki_st_open_w.flag_primo_giro = "S"
//--- Recupera i parametri passati con il WITHPARM
	if isvalid(message.powerobjectparm) then 
		ki_st_open_w = message.powerobjectparm
	else
		ki_st_open_w.flag_adatta_win = kkg.adatta_win
		ki_st_open_w.flag_modalita = "" 
	end if
	
	
//--- assegna il puntatore all'oggetto menu  x renderlo visibile negli script 
//	ki_menu = this.menuid

//--- assegna il puntatore alla Window x renderlo visibile negli script
	kiw_this_window = this
	ki_nome_save = trim(this.ClassName())
	
//--- setta la directory di base
	kGuf_data_base.setta_path_default ()

//--- setta il titolo della window
	set_titolo_window()

//---- oggetto generico 
//	kiuf1_parent = create kuf_parent

//--- FINE !!!! OPERAZIONI PRELIMINARI --------------------------------------------------------------------------

	kpointer_orig = setpointer(hourglass!)

//	this.setredraw(false)


//--- la primissima cosa che fa PERSONALIZZATA dalle windows FIGLIE
	open_start_window()
	
	kuf1_utility = create kuf_utility

////--- Legge le proprietà della Window (tab menu_window) 
//	kuf1_menu = create kuf_menu
//	kst_tab_menu_window.window = trim(this.ClassName())
//	kuf1_menu.get_st_tab_menu_window( kst_tab_menu_window ) 
//	destroy kuf1_menu

//--- altre operazioni
	post event u_open( )
	

	u_win_open()

		
	setpointer(kpointer_orig )		


end event

type cb_ritorna from commandbutton within w_sr_utenti_password
integer x = 1943
integer y = 600
integer width = 393
integer height = 100
string text = "Esci"
end type

event clicked;//

close(parent)
end event

type cb_aggiorna from commandbutton within w_sr_utenti_password
integer x = 1385
integer y = 596
integer width = 471
integer height = 100
string text = "Conferma"
end type

event clicked;//
aggiorna( )

end event

type dw_pwd from datawindow within w_sr_utenti_password
integer x = 5
integer y = 8
integer width = 2377
integer height = 752
string dataobject = "d_sr_utenti_password"
boolean border = false
end type

