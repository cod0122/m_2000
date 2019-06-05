$PBExportHeader$kuf_memo_allarme.sru
forward
global type kuf_memo_allarme from kuf_parent
end type
end forward

global type kuf_memo_allarme from kuf_parent
end type
global kuf_memo_allarme kuf_memo_allarme

type variables
//
//private graphicobject ki_obj_su_cui_trovare // oggetto (datawindow) con i dati da trovare
//private w_g_tab kiw_su_cui_trovare		// window contenente il dw con i dati da trovare
private w_main kiw_main		// window MAIN 
private w_memo_allarme kiw_memo_allarme  // window in cui compaiono gli Avvisi

public st_memo_allarme kist_memo_allarme
public datastore kids_memo_allarme

private boolean ki_visualizza_allarme = false

private boolean ki_chiudi_w_memo_allarme = false

//--- MEMO: tipi di allarme per Cliente, Lotto, ....
public constant string kki_MEMO_allarme_no = "N" // nessuno
public constant string kki_MEMO_allarme_meca = "I" // nel carico Lotto
public constant string kki_MEMO_allarme_ddt = "S" // nel carico DDT
public constant string kki_MEMO_allarme_fattura = "F" // nel carico Fattura
public constant string kki_MEMO_allarme_ddtfatt = "T" // segnala nel ddt e in fattura
public constant string kki_MEMO_allarme_utente = "U" // segnalazione su utente
public constant string kki_MEMO_allarme_certif = "A" // segnala su Attestato

//--- data dalla quale get gli allarmi
private date ki_data_allarme_ini 

constant string kki_suona_motivo_allarme = "allarmeMemo.wav"

end variables

forward prototypes
private subroutine u_open_window (string a_titolo)
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public subroutine u_close_window ()
public function boolean set_allarme_cliente (ref st_memo_allarme ast_memo_allarme) throws uo_exception
public function boolean set_allarme_lotto (ref st_memo_allarme ast_memo_allarme) throws uo_exception
private function boolean if_allarme_cliente (ref st_memo_allarme ast_memo_allarme) throws uo_exception
private function boolean if_allarme_lotto (ref st_memo_allarme ast_memo_allarme) throws uo_exception
public subroutine set_window (ref w_memo_allarme a_window)
public function w_memo_allarme get_window ()
public subroutine set_w_main (ref window a_window)
public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita)
public subroutine set_icona_avviso ()
public function boolean if_close_w_allarme ()
public function long get_nr_avvisi ()
public function boolean set_allarme_utente (ref st_memo_allarme ast_memo_allarme) throws uo_exception
public function boolean if_allarme_utente (st_memo_allarme ast_memo_allarme) throws uo_exception
public function integer get_allarmi_utente (ref st_memo_allarme ast_memo_allarme[]) throws uo_exception
public subroutine u_apri_link (st_memo_allarme ast_memo_allarme)
public subroutine set_chiudi_w_memo_allarme_on ()
public function boolean if_notifica_memo_a_video ()
public subroutine inizializza ()
public function date get_data_allarme_ini ()
public subroutine set_visualizza_allarme ()
public subroutine u_mostra_allarme (string a_nr_allarmi)
public function boolean u_attiva_memo_allarme_on () throws uo_exception
private function boolean u_attiva_memo_allarme () throws uo_exception
public function boolean u_attiva_memo_allarme_hide () throws uo_exception
public subroutine set_visualizza_allarme_on ()
public subroutine set_visualizza_allarme_off ()
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public subroutine u_audio_warning ()
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

public function boolean set_allarme_cliente (ref st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge se esiste un Allarme 
//--- input: st_memo_allarme st_memo_allarme.allarme, descr, st_tab_clienti_memo.id_cliente
//--- Rit: numero allarme caricato
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga
int k_rc


if ast_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente > 0 &
     	or ast_memo_allarme.clie_1 > 0  &
     	or ast_memo_allarme.clie_2 > 0  &
     	or ast_memo_allarme.clie_3 > 0  then
	
	if if_allarme_cliente(ast_memo_allarme) then
		//--- solo se id non presente allora lo aggiungo
		if isvalid(kiw_memo_allarme) then
			if trim(ast_memo_allarme.descr) > " " then
				k_riga = kiw_memo_allarme.dw_memo_allarme.find( "k_descr = '" + string(ast_memo_allarme.descr) + "' " , 1, kiw_memo_allarme.dw_memo_allarme.rowcount())
			else
				k_riga = kiw_memo_allarme.dw_memo_allarme.find( "k_id = " + string(ast_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente) + " " , 1, kiw_memo_allarme.dw_memo_allarme.rowcount())
			end if
		end if
		if k_riga > 0 then //> 0 then
		else
	
			k_riga = kids_memo_allarme.insertrow(0)
			if k_riga > 0 then
				k_rc = kids_memo_allarme.setitem(k_riga, "k_tipo", "C")
				if trim(ast_memo_allarme.descr) > " " then
					kids_memo_allarme.setitem(k_riga, "k_descr", trim(ast_memo_allarme.descr))
				else
					kids_memo_allarme.setitem(k_riga, "k_descr", "C")
				end if
				kids_memo_allarme.setitem(k_riga, "k_id", ast_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente)
				kids_memo_allarme.setitem(k_riga, "k_numero", 1)
				kids_memo_allarme.setitem(k_riga, "k_settore", "")

				ki_visualizza_allarme = true
				k_return = true
				set_visualizza_allarme_on()   // visualizza pop-pup allarme
			end if
		end if
	end if
end if


return k_return 



end function

public function boolean set_allarme_lotto (ref st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//---
//--- Aggiunge se esiste un Allarme 
//--- input: st_memo_allarme st_memo_allarme.allarme, st_memo.st_tab_meca_memo.id_meca
//--- Rit: numero allarme caricato
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga
int k_rc


if ast_memo_allarme.st_memo.st_tab_meca_memo.id_meca > 0 then
	
	if if_allarme_lotto(ast_memo_allarme) then
		//--- solo se id non presente allora lo aggiungo
		if isvalid(kiw_memo_allarme) then
			if trim(ast_memo_allarme.descr) > " " then
				k_riga = kiw_memo_allarme.dw_memo_allarme.find( "k_descr = '" + string(ast_memo_allarme.descr) + "' " , 1, kiw_memo_allarme.dw_memo_allarme.rowcount())
			else
				k_riga = kiw_memo_allarme.dw_memo_allarme.find( "k_id = " + string(ast_memo_allarme.st_memo.st_tab_meca_memo.id_meca) + " " , 1, kiw_memo_allarme.dw_memo_allarme.rowcount())
			end if
		end if
		if k_riga > 0 then
		else
	
			k_riga = kids_memo_allarme.insertrow(0)
			if k_riga > 0 then
				k_rc = kids_memo_allarme.setitem(k_riga, "k_tipo", "L")
				if trim(ast_memo_allarme.descr) > " " then
					kids_memo_allarme.setitem(k_riga, "k_descr", trim(ast_memo_allarme.descr))
				else
					kids_memo_allarme.setitem(k_riga, "k_descr", "L")
				end if
				kids_memo_allarme.setitem(k_riga, "k_id", ast_memo_allarme.st_memo.st_tab_meca_memo.id_meca)
				kids_memo_allarme.setitem(k_riga, "k_numero", 1)
				kids_memo_allarme.setitem(k_riga, "k_settore", "")

				ki_visualizza_allarme = true
				k_return = true
				set_visualizza_allarme_on()   // visualizza pop-pup allarme
			end if
		end if
	end if
end if

return k_return 



end function

private function boolean if_allarme_cliente (ref st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//---
//--- Cerca un Allarme per cliente 
//--- input: st_memo_allarme st_memo_allarme.allarme e st_memo.st_tab_clienti_memo.id_cliente
//---
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_allarme_1 = "", k_allarme_2 = ""
datastore kds_memo_if_allarme_cliente


if ast_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente > 0 then
	
	kds_memo_if_allarme_cliente = create datastore
	kds_memo_if_allarme_cliente.dataobject = "ds_memo_if_allarme_cliente"
	kds_memo_if_allarme_cliente.settransobject(kguo_sqlca_db_magazzino)
	choose case ast_memo_allarme.allarme
		case kki_MEMO_allarme_fattura
			k_allarme_1 = kki_MEMO_allarme_fattura
			k_allarme_2 = kki_MEMO_allarme_ddtfatt // se allarme di tipo DDT + FATTTURA
		case kki_MEMO_allarme_ddt
			k_allarme_1 = kki_MEMO_allarme_ddt
			k_allarme_2 = kki_MEMO_allarme_ddtfatt // se allarme di tipo DDT + FATTTURA
		case else // altrimenti cerca solo puntualmente quello passato
			k_allarme_1 = ast_memo_allarme.allarme
			k_allarme_2 = ast_memo_allarme.allarme
	end choose

	if kds_memo_if_allarme_cliente.retrieve(ast_memo_allarme.st_memo.st_tab_clienti_memo.id_cliente, k_allarme_1, k_allarme_2 ) > 0 then

		if kds_memo_if_allarme_cliente.getitemnumber(1,"k_trovato") = 1 then
			k_return=true
		end if

	end if
end if

return k_return 



end function

private function boolean if_allarme_lotto (ref st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//---
//--- Cerca se esiste l'Allarme per un Lotto 
//--- input: st_memo_allarme st_memo_allarme.allarme e st_memo.st_tab_meca_memo.id_meca
//---
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_allarme_1 = "", k_allarme_2 = ""
datastore kds_memo_if_allarme_meca

if ast_memo_allarme.st_memo.st_tab_meca_memo.id_meca > 0 then
	
	kds_memo_if_allarme_meca = create datastore
	kds_memo_if_allarme_meca.dataobject = "ds_memo_if_allarme_lotto"
	kds_memo_if_allarme_meca.settransobject(kguo_sqlca_db_magazzino)
	choose case ast_memo_allarme.allarme
		case kki_MEMO_allarme_fattura
			k_allarme_1 = kki_MEMO_allarme_fattura
			k_allarme_2 = kki_MEMO_allarme_ddtfatt // se allarme di tipo DDT + FATTTURA
		case kki_MEMO_allarme_ddt
			k_allarme_1 = kki_MEMO_allarme_ddt
			k_allarme_2 = kki_MEMO_allarme_ddtfatt // se allarme di tipo DDT + FATTTURA
		case else // altrimenti cerca solo puntualmente quello passato
			k_allarme_1 = ast_memo_allarme.allarme
			k_allarme_2 = ast_memo_allarme.allarme
	end choose

	if kds_memo_if_allarme_meca.retrieve(ast_memo_allarme.st_memo.st_tab_meca_memo.id_meca, k_allarme_1, k_allarme_2 ) > 0 then

		if kds_memo_if_allarme_meca.getitemnumber(1,"k_trovato") = 1 then
			k_return=true
		end if

	end if
end if

return k_return 



end function

public subroutine set_window (ref w_memo_allarme a_window);//
kiw_memo_allarme = a_window

end subroutine

public function w_memo_allarme get_window ();//
return kiw_memo_allarme


end function

public subroutine set_w_main (ref window a_window);//
kiw_main = a_window

end subroutine

public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita);//
int k_rc_open
//window kwindow
kuf_menu_window kuf1_menu_window
st_open_w Kst_open_w


	Kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	Kst_open_w.id_programma = this.get_id_programma(Kst_open_w.flag_modalita)
	Kst_open_w.flag_primo_giro = ""
	Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	Kst_open_w.flag_leggi_dw = " "
	Kst_open_w.flag_cerca_in_lista = " "

	Kst_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
	kuf1_menu_window = create kuf_menu_window 

	k_rc_open = OpenWithParm(kiw_memo_allarme, kst_open_w)

	if k_rc_open > 0 then
		kiw_memo_allarme.bringtotop = true
	end if

	//kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
				
				
return true
end function

public subroutine set_icona_avviso ();//
//--- accende / spegne l'icona di avvertimento degli allarmi
//
boolean k_memo_presenti=false


if isvalid(kiw_memo_allarme.dw_memo_allarme) then
	if kiw_memo_allarme.dw_memo_allarme.rowcount( ) > 0 then
		k_memo_presenti = true
	end if
end if

//kGuf_data_base.u_toolbar_programmi_avviso_allarme(k_memo_presenti)
end subroutine

public function boolean if_close_w_allarme ();//------------------------------------------------------------------------------------------------------------------------
//---
//--- Richiesta di chiusura effettiva della WIndow di Allarme
//--- Ritorna: TRUE = posso chiudere definitivamente la window,FALSE=posso solo nascondere 
//---
//------------------------------------------------------------------------------------------------------------------------

set_icona_avviso( )  // imposta l'incona dell'avviso sulla MDI

return ki_chiudi_w_memo_allarme 
	




end function

public function long get_nr_avvisi ();//
//--- mostra o nasconde la window
//
long k_return=0


if isvalid(kiw_memo_allarme) then
	k_return = kiw_memo_allarme.dw_memo_allarme.get_nr_avvisi()
end if

return k_return


end function

public function boolean set_allarme_utente (ref st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Aggiunge se esiste un Allarme Utente
//--- input: st_memo_allarme  descr, st_tab_memo_utente.id_sr_utente
//--- Rit: numero allarme caricato
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_riga, k_righe, k_riga_utente, k_nr_righe
int k_rc, k_pos
string k_pos_txt="", k_descr=""
st_memo_allarme kst_memo_allarme[]


if ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente > 0 then
else
	ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( )
end if

if ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente > 0 then
	
	ast_memo_allarme.allarme = this.kki_memo_allarme_utente

//--- 
	if if_allarme_utente(ast_memo_allarme) then

		k_righe = get_allarmi_utente(kst_memo_allarme[])
		
		if isvalid(kiw_memo_allarme) then kiw_memo_allarme.dw_memo_allarme.reset( )  // resetta le righe nel pop-up
		
		for k_riga_utente = 1 to k_righe

//			k_riga = 0
//			if isvalid(kiw_memo_allarme) then
//				k_nr_righe = kiw_memo_allarme.dw_memo_allarme.rowcount()
//				k_pos = 0
//				if k_nr_righe > 0 then
//					do until k_pos > 0 or k_riga > k_nr_righe 
//						k_riga ++
//						k_pos_txt = " "+ kst_memo_allarme[k_riga_utente].st_memo.st_tab_memo.tipo_sv + " rilevato per il tuo utente (id " + string(ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente) + ") "  
//						k_descr = kiw_memo_allarme.dw_memo_allarme.getitemstring(k_riga_utente, "k_descr")
//						k_pos = pos(k_descr, k_pos_txt)
//						if k_pos = 0 then
//							k_pos_txt = " "+ kst_memo_allarme[k_riga_utente].st_memo.st_tab_memo.tipo_sv + " rilevati per il tuo utente (id " + string(ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente) + ") "  
//							k_pos = pos(k_descr, k_pos_txt)
//						end if
//					loop
//				end if
//			end if
//			if k_pos > 0 then //> 0 then
//			else
		
				k_riga = kids_memo_allarme.insertrow(0)
				if k_riga > 0 then
					k_rc = kids_memo_allarme.setitem(k_riga, "k_tipo", "U")
					if kst_memo_allarme[k_riga_utente].numero = 1 then
						kids_memo_allarme.setitem(k_riga, "k_descr", "Un Avviso dal settore " + kst_memo_allarme[k_riga_utente].st_memo.st_tab_memo.tipo_sv + " rilevato per il tuo utente (id " + string(ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente) + ") "  )
					else
						kids_memo_allarme.setitem(k_riga, "k_descr", string(kst_memo_allarme[k_riga_utente].numero) +" Avvisi dal settore " + kst_memo_allarme[k_riga_utente].st_memo.st_tab_memo.tipo_sv + " rilevati per il tuo utente (id " + string(ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente) + ") ")
					end if
					kids_memo_allarme.setitem(k_riga, "k_id", ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente)
					kids_memo_allarme.setitem(k_riga, "k_numero", kst_memo_allarme[k_riga_utente].numero)
					kids_memo_allarme.setitem(k_riga, "k_settore", kst_memo_allarme[k_riga_utente].st_memo.st_tab_memo.tipo_sv)
	
					ki_visualizza_allarme = true
					k_return = true
				end if
				
//			end if
			
		next

	end if
	
else
	inizializza()
end if


return k_return 



end function

public function boolean if_allarme_utente (st_memo_allarme ast_memo_allarme) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//---
//--- Cerca un Allarme per utente 
//--- input: 
//---
//------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
datetime k_datetime
datastore kds_memo_if_allarme_utente


if ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente > 0 then  
	
	kds_memo_if_allarme_utente = create datastore
	kds_memo_if_allarme_utente.dataobject = "ds_memo_if_allarme_utente"
	kds_memo_if_allarme_utente.settransobject(kguo_sqlca_db_magazzino)
	k_datetime = datetime(ki_data_allarme_ini)
	if kds_memo_if_allarme_utente.retrieve(ast_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente, k_datetime)  > 0 then

			k_return=true

	end if
end if

return k_return 



end function

public function integer get_allarmi_utente (ref st_memo_allarme ast_memo_allarme[]) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//---
//--- Cerca un Allarme per utente 
//--- out: ast_memo_allarme[] con i settori trovati: st_memo_allarme.st_memo.st_tab_memo.tipo_sv e numero = numero di memo trovati
//---
//------------------------------------------------------------------------------------------------------------------------
integer k_return = 0
integer k_riga=0
datetime k_datetime
datastore kds_memo_if_allarme_utente
st_memo_allarme kst_memo_allarme

kst_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( )
if kst_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente > 0 then  
	
	kds_memo_if_allarme_utente = create datastore
	kds_memo_if_allarme_utente.dataobject = "ds_memo_if_allarme_utente"
	kds_memo_if_allarme_utente.settransobject(kguo_sqlca_db_magazzino)
	k_datetime = datetime(ki_data_allarme_ini)
	k_return = kds_memo_if_allarme_utente.retrieve(kst_memo_allarme.st_memo.st_tab_memo_utenti.id_sr_utente, k_datetime) 
	if k_return > 0 then
		k_riga ++
		for k_riga =1 to k_return
			ast_memo_allarme[k_riga].st_memo.st_tab_memo.tipo_sv = kds_memo_if_allarme_utente.getitemstring( k_riga, "settore")
			ast_memo_allarme[k_riga].numero = kds_memo_if_allarme_utente.getitemnumber( k_riga, "contati")
		next
	end if
end if

return k_return 



end function

public subroutine u_apri_link (st_memo_allarme ast_memo_allarme);//
//--- Applica il trova x i Dati indicati 
//
string k_tipo
long k_id
//kuf_parent kuf1_parent
//st_tab_g_0 kst_tab_g_0
st_open_w kst_open_w
kuf_memo kuf1_memo


if ast_memo_allarme.d_memo_allarme.rowcount() > 0 then
	k_tipo = trim(ast_memo_allarme.d_memo_allarme.getitemstring(1, "k_tipo"))
	k_id = ast_memo_allarme.d_memo_allarme.getitemnumber(1, "k_id")
	if k_tipo > " " and k_id > 0 then
		
		kuf1_memo = create kuf_memo
		
		choose case k_tipo
			case "L"
				kst_open_w.key1 = kuf1_memo.kki_tipovisualizza_xmeca
				kst_open_w.key2 = kuf1_memo.kki_memo_attivi
				kst_open_w.key3 = "0"
				kst_open_w.key4 = "" 
//				kuf1_parent = create using "kuf_meca_memo"
			case "C"
				kst_open_w.key1 = kuf1_memo.kki_tipovisualizza_xanag
				kst_open_w.key2 = kuf1_memo.kki_memo_attivi
				kst_open_w.key3 = "0"
				kst_open_w.key4 = "" 
//				kuf1_parent = create using "kuf_clienti_memo"
			case "U"
				kst_open_w.key1 = kuf1_memo.kki_tipovisualizza_xutente
				kst_open_w.key2 = kuf1_memo.kki_memo_attivi
				kst_open_w.key3 = "0"
				kst_open_w.key4 = trim(ast_memo_allarme.d_memo_allarme.getitemstring(1, "k_settore"))
//				kuf1_parent = create using "kuf_utenti_memo"
		end choose
		
		if isvalid(kuf1_memo) then
//				kst_tab_g_0.id = k_id
//				kst_tab_g_0.idx =  trim(ast_memo_allarme.d_memo_allarme.getitemstring(1, "k_settore"))
//				kuf1_parent.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.elenco)
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kuf1_memo.u_open(kst_open_w)
		end if
		
	end if
end if

//kiw_main.dw_memo_allarme.u_trova( )


end subroutine

public subroutine set_chiudi_w_memo_allarme_on ();//
//--- flag x chiueder la window
//
ki_chiudi_w_memo_allarme = true

end subroutine

public function boolean if_notifica_memo_a_video ();//
//--- mostra o nasconde la window
//
boolean k_return=false


if isvalid(kiw_memo_allarme) then
	k_return = kiw_memo_allarme.dw_memo_allarme.if_notifica( )
end if

return k_return


end function

public subroutine inizializza ();//-------------------------------------------------------------------------------------
//--- inizializza i dati di ALLARME
//-------------------------------------------------------------------------------------

	ki_visualizza_allarme = false
	kids_memo_allarme.reset( )	

end subroutine

public function date get_data_allarme_ini ();//---------------------------------------------------------------
//---- torna la data di inzio visualizzazione allarmi
//---------------------------------------------------------------


return ki_data_allarme_ini 

end function

public subroutine set_visualizza_allarme ();//
//--- mostra o nasconde la window
//
if isvalid(kiw_memo_allarme) then
	if NOT kiw_memo_allarme.if_visible() then
		set_visualizza_allarme_on( )
	else
		set_visualizza_allarme_off( )
	end if
	
end if

end subroutine

public subroutine u_mostra_allarme (string a_nr_allarmi);//
//--- mostra o nasconde la window
//
int k_nr_allarmi=0
st_open_w kst_open_w
kuf_memo kuf1_memo

try

	if isnumber(a_nr_allarmi) then
		k_nr_allarmi = integer(a_nr_allarmi)
	end if

	if k_nr_allarmi > 0 then
			
		set_visualizza_allarme( )
		
	else
		kuf1_memo = create kuf_memo 
		
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.key1 = kuf1_memo.kki_tipovisualizza_xUTENTE
		kst_open_w.key2 = string(kuf1_memo.kki_memo_attivi)
		kst_open_w.key3 = "0"  // eventuale id del cliente o lotto o ...
		kst_open_w.key4 = ""  // eventuale settore
		kuf1_memo.u_open(kst_open_w)
	end if

catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
	
end try


end subroutine

public function boolean u_attiva_memo_allarme_on () throws uo_exception;//
//--- Attiva la window x visualizzare gli Allarmi MEMO 
//---    
//
boolean k_return = false


	//--- se window non ancora aperta la crea	
	if not isvalid(kiw_memo_allarme) then
		u_open()	
	end if

	if isvalid (kiw_main) and isvalid(kiw_memo_allarme) then
		kiw_memo_allarme.set_posizione() //kiw_main.width, kiw_main.height)

		ki_visualizza_allarme = true
		u_attiva_memo_allarme( )

	end if	


return k_return

end function

private function boolean u_attiva_memo_allarme () throws uo_exception;//
//--- Attiva la window x visualizzare gli Allarmi MEMO
//
boolean k_return = false

//--- ALLARME da visualizzare?	
	if ki_visualizza_allarme then
		ki_visualizza_allarme = false
	
		if isvalid(kiw_memo_allarme) and kids_memo_allarme.rowcount( ) > 0 then
			k_return = true
			kiw_memo_allarme.u_attiva_allarme(kids_memo_allarme)
			set_icona_avviso( )  // visualizza l'icona dell'avviso sulla MDI
		end if

	end if	


return k_return

end function

public function boolean u_attiva_memo_allarme_hide () throws uo_exception;//
//--- Attiva la window x visualizzare gli Allarmi MEMO
//
boolean k_return = false

//--- se window non ancora aperta la crea	
	if not isvalid(kiw_memo_allarme) then
		u_open()	
	end if
	
	if isvalid (kiw_main) and isvalid(kiw_memo_allarme) then
		kiw_memo_allarme.set_posizione_hide()
	
		ki_visualizza_allarme = false
		k_return = u_attiva_memo_allarme( )
	end if		

return k_return

end function

public subroutine set_visualizza_allarme_on ();//
//--- mostra o nasconde la window
//
if isvalid(kiw_memo_allarme) then
	ki_visualizza_allarme = true
	kiw_memo_allarme.u_show( )
end if
	

end subroutine

public subroutine set_visualizza_allarme_off ();//
//--- mostra o nasconde la window
//
if isvalid(kiw_memo_allarme) then
	ki_visualizza_allarme = false
	kiw_memo_allarme.u_hide( )
end if
	

end subroutine

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
string k_rcx
st_tab_certif  kst_st_tab_certif
st_tab_sped kst_st_tab_sped
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_elenco kuf1_elenco


try
	SetPointer(kkg.pointer_attesa )
	
	kdsi_elenco_output = create datastore
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	choose case a_campo_link
	
		case "p_memo_alarm_certif"
			kst_st_tab_certif.num_certif = 0
			k_rcx = adw_link.describe("num_certif.x")
			if k_rcx <> "!" and isnumber(k_rcx) then
				kst_st_tab_certif.num_certif  = adw_link.getitemnumber(adw_link.getrow(), "num_certif")
			else
				k_rcx = adw_link.describe("certif_num_certif.x")
				if k_rcx <> "!" and isnumber(k_rcx) then
					kst_st_tab_certif.num_certif  = adw_link.getitemnumber(adw_link.getrow(), "certif_num_certif")
				end if
			end if
			if kst_st_tab_certif.num_certif  > 0 then
				kdsi_elenco_output.dataobject = "d_memo_allarme_attestati_l"
				kdsi_elenco_output.settransobject( kguo_sqlca_db_magazzino )
				kdsi_elenco_output.reset()	
				k_rc=kdsi_elenco_output.retrieve(kst_st_tab_certif.num_certif )
//				kst_esito = this.anteprima( kdsi_elenco_output, kst_st_tab_certif )
//				if kst_esito.esito <> kkg_esito.ok then
//					kguo_exception.inizializza( )
//					kguo_exception.set_esito(kst_esito)
//					throw kguo_exception
//				end if
				kst_open_w.key1 = "Allarmi MEMO Attestato n. " + trim(string(kst_st_tab_certif.num_certif )) + ") " 
			else
				k_return = false
			end if
	
		case "p_memo_alarm_ddt"
			kst_st_tab_sped.id_sped = 0
			k_rcx = adw_link.describe("id_sped.x")
			if k_rcx <> "!" and isnumber(k_rcx) then
				kst_st_tab_sped.id_sped  = adw_link.getitemnumber(adw_link.getrow(), "id_sped")
			end if
			if kst_st_tab_sped.id_sped  > 0 then
				kdsi_elenco_output.dataobject = "d_memo_allarme_ddt_l"
				kdsi_elenco_output.settransobject( kguo_sqlca_db_magazzino )
				kdsi_elenco_output.reset()	
				k_rc=kdsi_elenco_output.retrieve(kst_st_tab_sped.id_sped )
				kst_open_w.key1 = "Allarmi MEMO DDT id " + trim(string(kst_st_tab_sped.id_sped )) + ") " 
			else
				k_return = false
			end if
	
	end choose
	
	if k_return then
	
		if kdsi_elenco_output.rowcount() > 0 then
		
			kuf1_elenco = create kuf_elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kuf1_elenco.u_open(kst_open_w)
	
		else
			
			kguo_exception.inizializza( )
			kguo_exception.setmessage( "Nessun valore disponibile. " )
			throw kguo_exception
			
		end if
	
	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception 


finally
	if isvalid(kuf1_elenco) then destroy kuf1_elenco
	SetPointer(kkg.pointer_default)
	
end try	


return k_return

end function

public subroutine u_audio_warning ();
end subroutine

on kuf_memo_allarme.create
call super::create
end on

on kuf_memo_allarme.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kids_memo_allarme  = create datastore
kids_memo_allarme.dataobject = "d_memo_allarme"

ki_data_allarme_ini = relativedate(today() , -60)


end event

event destructor;call super::destructor;//
ki_chiudi_w_memo_allarme = true
if isvalid (kiw_memo_allarme) then
	kiw_memo_allarme.event close( )
end if
end event

