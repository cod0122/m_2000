$PBExportHeader$kuf_alert.sru
forward
global type kuf_alert from kuf_parent
end type
end forward

global type kuf_alert from kuf_parent
end type
global kuf_alert kuf_alert

type variables
//
//private graphicobject ki_obj_su_cui_trovare // oggetto (datawindow) con i dati da trovare
//private w_g_tab kiw_su_cui_trovare		// window contenente il dw con i dati da trovare
private w_main kiw_main		// window MAIN 
private w_alert kiw_alert  // window in cui compaiono gli Avvisi

public st_alert kist_alert
public datastore kids_alert

public boolean ki_visualizza_allarme = true

private boolean ki_chiudi_w_alert = false

//--- MEMO: tipi di allarme per Cliente, Lotto, ....
public constant string kki_alert_NO = "N" // nessuno
public constant string kki_alert_OK = "OK" // alert di ok
public constant string kki_alert_KO = "KO" // alert di errore

//--- data dalla quale get gli allarmi
//private date ki_data_allarme_ini 

end variables

forward prototypes
private subroutine u_open_window (string a_titolo)
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine u_close_window ()
public subroutine set_window (ref w_alert a_window)
public function w_alert get_window ()
public subroutine set_w_main (ref window a_window)
public function boolean if_close_w_allarme ()
public function long get_nr_avvisi ()
public subroutine set_chiudi_w_alert_on ()
public function boolean if_notifica_memo_a_video ()
public subroutine inizializza ()
private subroutine set_visualizza_allarme ()
private subroutine u_mostra_allarme ()
public function boolean u_attiva_alert (st_alert ast_alert) throws uo_exception
public function boolean u_open (ref st_open_w ast_open_w)
end prototypes

private subroutine u_open_window (string a_titolo);
end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

public subroutine u_close_window ();//
//--- Chiude la window 
//
if isvalid(kiw_main) then 
//	kiw_trova.hide( )
//	kiw_trova.chiudi_immediato()
end if


end subroutine

public subroutine set_window (ref w_alert a_window);//
kiw_alert = a_window

end subroutine

public function w_alert get_window ();//
return kiw_alert


end function

public subroutine set_w_main (ref window a_window);//
kiw_main = a_window

end subroutine

public function boolean if_close_w_allarme ();//------------------------------------------------------------------------------------------------------------------------
//---
//--- Richiesta di chiusura effettiva della WIndow di Allarme
//--- Ritorna: TRUE = posso chiudere definitivamente la window,FALSE=posso solo nascondere 
//---
//------------------------------------------------------------------------------------------------------------------------

//set_icona_avviso( )  // imposta l'incona dell'avviso sulla MDI

return ki_chiudi_w_alert 
	




end function

public function long get_nr_avvisi ();//
//--- mostra o nasconde la window
//
long k_return=0


if isvalid(kiw_alert) then
	k_return = kiw_alert.dw_alert.rowcount()
end if

return k_return


end function

public subroutine set_chiudi_w_alert_on ();//
//--- flag x chiueder la window
//
ki_chiudi_w_alert = true

end subroutine

public function boolean if_notifica_memo_a_video ();//
//--- mostra o nasconde la window
//
boolean k_return=false


if isvalid(kiw_alert) then
	k_return = kiw_alert.dw_alert.if_notifica( )
end if

return k_return


end function

public subroutine inizializza ();//-------------------------------------------------------------------------------------
//--- inizializza i dati di ALLARME
//-------------------------------------------------------------------------------------

	ki_visualizza_allarme = true
	kids_alert.reset( )	

end subroutine

private subroutine set_visualizza_allarme ();//
//--- mostra o nasconde la window
//
try
	if isvalid(kiw_alert) then
	//	if NOT kiw_alert.visible then
			kiw_alert.u_attiva_allarme()
	//	else
	//		ki_visualizza_allarme = false
	//		kiw_alert.hide( )
	//	end if
		
	end if
	
catch (uo_exception kguo_exception)
//	kguo_exception.set_me
	
end try

end subroutine

private subroutine u_mostra_allarme ();//
//--- mostra o nasconde la window
//
int k_nr_allarmi=0
st_open_w kst_open_w
//kuf_alert kuf1_alert

try

//	if isnumber(a_nr_allarmi) then
//		k_nr_allarmi = integer(a_nr_allarmi)
//	end if
//
	if get_nr_avvisi( ) > 0 then
			
		set_visualizza_allarme( )
		
	else
		//kuf1_alert = create kuf_alert 
		
		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		kst_open_w.key1 = "" //kuf1_alert.kki_tipovisualizza_xUTENTE
		kst_open_w.key2 = "" //string(kuf1_alert.kki_memo_attivi)
		kst_open_w.key3 = "0"  // 
		kst_open_w.key4 = ""  // eventuale settore
		kst_open_w.key12_any = kist_alert			// questo oggetto di gestione del trovo
		kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita )
		kst_open_w.flag_primo_giro = "S"
		u_open(kst_open_w)

	end if

catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
	
end try


end subroutine

public function boolean u_attiva_alert (st_alert ast_alert) throws uo_exception;//
//--- Attiva la window x visualizzare gli Allarmi MEMO per una determinata funzione
//--- Inp: 	st_alert  tipo_allarme e i campi riempiti per cercare i memo
//---		           ad esempio se tipo_allarme = "C"  cercherò i memo 
//---                 del cliente indicato in st_alert.st_memo.st_clienti_memo.id_cliente
//---    
//
boolean k_return = false

//--- ALLARME da visualizzare?	
	if ki_visualizza_allarme then

		kist_alert = ast_alert
	
//--- se window non ancora aperta la crea	
//		if not isvalid(kiw_alert) then
			u_mostra_allarme()	
//		end if
	
//		if isvalid (kiw_main) and isvalid(kiw_alert) then
//			kiw_alert.set_posizione(kiw_main.width, kiw_main.height)
//		end if		
//		if isvalid(kiw_alert) and kids_alert.rowcount( ) > 0 then
//			kiw_alert.u_attiva_allarme(kids_alert)
//			set_icona_avviso( )  // visualizza l'icona dell'avviso sulla MDI
//		end if
//
	end if	


return k_return

end function

public function boolean u_open (ref st_open_w ast_open_w);//---
//--- Apre la Window x le diverse funzioni
//---
//--- Input: st_open_w
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
boolean k_return = false
//string k_rc = ""
//kuf_menu_window kuf1_menu_window

	
	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(ast_open_w)
	//destroy kuf1_menu_window
	//if k_rc = "1" then	
	k_return = true


return k_return


end function

on kuf_alert.create
call super::create
end on

on kuf_alert.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kids_alert  = create datastore
kids_alert.dataobject = "d_alert"


end event

event destructor;call super::destructor;//
ki_chiudi_w_alert = true
if isvalid (kiw_alert) then
	kiw_alert.event close( )
end if
end event

