$PBExportHeader$w_email_invio.srw
forward
global type w_email_invio from w_g_tab0
end type
end forward

global type w_email_invio from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean maxbox = false
boolean ki_toolbar_window_presente = true
end type
global w_email_invio w_email_invio

type variables
//
private kuf_email_invio kiuf_email_invio
private st_tab_email_invio ki_st_tab_email_invio, ki_st_tab_email_invio_1, ki_st_tab_email_invio_2
private string ki_path_centrale =""

private string ki_mostra_nascondi_in_lista = "S"

end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
protected subroutine attiva_menu ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine smista_funz (string k_par_in)
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
private subroutine get_path_lettera ()
private subroutine run_app_lettera ()
private subroutine get_path_allegati ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine set_titolo_window_personalizza ()
public function long invio_email ()
protected subroutine riempi_id ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//string k_key
long k_riga
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//	if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
//		
//		cb_inserisci.postevent(clicked!)
//		
//	else

//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = "S" then 
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
	
//			if dw_lista_0.retrieve( ki_mostra_nascondi_in_lista ) < 1 then
			if dw_lista_0.retrieve( ki_st_tab_email_invio_1.id_email_invio, ki_st_tab_email_invio_1.cod_funzione, ki_st_tab_email_invio_2.cod_funzione ) < 1 then

				k_return = "1Email Non trovate  "
	
				SetPointer(oldpointer)
				if ki_st_open_w.flag_primo_giro = "S" then 
					messagebox("Lista 'E-mail' Vuota", "Nesun Codice Trovato per la richiesta fatta")
				end if
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il ID allora....
					if ki_st_tab_email_invio.id_email_invio > 0 then
						k_riga = dw_lista_0.find( "id_email_invio = " + string(ki_st_tab_email_invio.id_email_invio) + " ", 1, dw_lista_0.rowcount( ) )
					end if
					if k_riga > 0 then 
						dw_lista_0.selectrow( 0, false)
						dw_lista_0.scrolltorow( k_riga)
						dw_lista_0.setrow( k_riga)
						dw_lista_0.selectrow( k_riga, true)
					end if
					
//--- se entro per modificare allora....
					if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
						cb_modifica.postevent(clicked!)
					end if
				end if
	
			end if		
		end if
	
//	end if
	attiva_tasti()
	
 	SetPointer(oldpointer)
	
return k_return



end function

private function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===                : 3=dati insufficienti; 4=OK con errori non gravi
//===                      : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
st_tab_email_invio kst_tab_email_invio


   k_riga = dw_dett_0.getrow()

   kst_tab_email_invio.email = dw_dett_0.getitemstring ( k_riga, "email") 
   if isnull(kst_tab_email_invio.email) or LenA(trim(kst_tab_email_invio.email)) = 0 then
      k_return = k_return + "Manca indirizzo E-mail destinatario" + "~n~r"
      k_errore = "3"

   end if

   
//--- errori diversi
   if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
      if dw_dett_0.getitemstring ( k_riga, "flg_allegati") = "S" &
                 and (len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "allegati_cartella"))) = 0 or isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "allegati_cartella"))) then 
            k_return = k_return + "Manca la Cartella Allegati " + "~n~r" 
            k_errore = "3"
      end if

      if isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto")) & 
               or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "oggetto"))) = 0 then 
         k_return = k_return + "Manca Oggetto " + "~n~r" 
         k_errore = "3"
      end if

      if isnull(dw_dett_0.getitemstring(dw_dett_0.getrow(), "link_lettera")) & 
               or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "link_lettera"))) = 0 then 
         k_return = k_return + "Manca la Comunicazione " + "~n~r" 
         k_errore = "3"
      end if
      
   end if


//--- se nessun errore grave
   if trim(k_errore) > "3" or trim(k_errore) = "0"then

//--- Non tollerati i campo a NULL
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_allegati")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_allegati", kiuf_email_invio.ki_allegati_no )
      end if
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_lettera_html")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_lettera_html", kiuf_email_invio.ki_lettera_html_no )
      end if
      if isnull(dw_dett_0.getitemstring(k_riga, "flg_ritorno_ricev")) then
         k_rc=dw_dett_0.setitem(k_riga, "flg_ritorno_ricev", kiuf_email_invio.ki_ricev_ritorno_si )
      end if


   end if
   

return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
//--- Cancellazione rekord dal DB
//--- Ritorna : "0"=OK "1...."=KO 
//
string k_return=""
string k_errore = "0 "
long k_riga
string k_descr
string k_codice
st_tab_email_invio kst_tab_email_invio
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
	k_riga = 1
	k_codice = string(dw_dett_0.getitemnumber(1, "id_email_invio"))
	k_descr = trim(dw_dett_0.getitemstring(1, "email"))
	kst_tab_email_invio.id_email_invio = dw_dett_0.getitemnumber(1, "id_email_invio") 
else
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = string(dw_lista_0.getitemnumber(k_riga, "id_email_invio"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "email"))
		kst_tab_email_invio.id_email_invio = dw_lista_0.getitemnumber(k_riga, "id_email_invio") 
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "E-mail senza indirzzo" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina "  + this.title , "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		kst_esito = kiuf_email_invio.tb_delete(kst_tab_email_invio) 
		if kst_esito.esito = kkg_esito.ok then

//--- Se tutto OK faccio la COMMIT		
			kst_esito = kguo_sqlca_db_magazzino.db_commit()
			if kst_esito.esito <> kkg_esito.ok then
				
				k_errore = "1Operzione fallita (COMMIT)!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
				messagebox("Problemi durante la Cancellazione !!", k_errore)

			else

//--- cancello riga a video
				k_codice = " "
				if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
					k_codice = string(dw_dett_0.getitemnumber(1, "id_email_invio"))
					dw_dett_0.deleterow(1)
					
					mostra_nascondi_dw()
					
				else
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore = "1Operzione fallita!! ~n~rErrore: " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) 
			kst_esito = kguo_sqlca_db_magazzino.db_rollback()
			if kst_esito.esito <> kkg_esito.ok then
				k_errore += k_errore + "~n~rErrore anche durante il recupero dell'errore: ~n~r" + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext) + "~n~rControllare i dati. "
			end if
				
			messagebox("Problemi durante Cancellazione", MidA(k_errore, 2) ) 	

			attiva_tasti()
	

		end if

	else
		messagebox("Elimina " + this.title , "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

k_return = k_errore

return(k_return)
//

end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_invio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

//
//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "b_path_lettera", dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//

	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi E-mail Inviate"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra o Nasconde le E-mail Inviate"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Nascondi,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DeleteRow!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if	

	if not ki_menu.m_strumenti.m_fin_gest_libero4.visible then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "-"
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = ""
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = false
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = ""
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = ""
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Invia E-mail"
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Invia E-mail selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Invia,"+ki_menu.m_strumenti.m_fin_gest_libero5.text
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "VCRNext!"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	end if	

//---
	super::attiva_menu()



end subroutine

public subroutine mostra_nascondi_in_lista ();//
string k_dataoggi
kuf_base kuf1_base

	
	dw_lista_0.setredraw(false)
	
//
//--- piglia la data oggi
//	kuf1_base = create kuf_base
//	k_dataoggi = kuf1_base.prendi_dato_base("dataoggi") 
//	if left(k_dataoggi, 1) = "0" then
//		k_dataoggi = string(date(mid(k_dataoggi, 2)), "dd.mm.yyyy")
//	else
//		k_dataoggi = string(today())
//	end if
//	destroy kuf1_base
					
//
	if ki_mostra_nascondi_in_lista = "S" then	
		ki_mostra_nascondi_in_lista = "N"
		leggi_liste()
		dw_lista_0.u_filtra_record("data_inviato = date('1899.01.01') or isnull(data_inviato) ") 
	else
		if ki_mostra_nascondi_in_lista = "N" then	
			ki_mostra_nascondi_in_lista = "*"
			leggi_liste()
			dw_lista_0.u_filtra_record("data_inviato > date('1900.01.01')") 
		else
			ki_mostra_nascondi_in_lista = "S"
			dw_lista_0.u_filtra_record("") 
			leggi_liste()
		end if
	end if



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 



	case KKG_FLAG_RICHIESTA.libero2		//Mostra/Nascondi righe
		mostra_nascondi_in_lista()

	case KKG_FLAG_RICHIESTA.libero5		//Invio EMAIL
		invio_email()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
st_esito kst_esito
datawindowchild kdwc_clienti_d



	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	dw_dett_0.reset()
	dw_dett_0.insertrow(0)
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_email_invio", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "data_ins", kg_dataoggi )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_allegati", kiuf_email_invio.ki_allegati_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "link_lettera", "" )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_lettera_html", kiuf_email_invio.ki_lettera_html_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_ritorno_ricev", kiuf_email_invio.ki_ricev_ritorno_si )

	dw_dett_0.setcolumn(1)
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
	destroy kuf1_utility  

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email_invio")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 


//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
		kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
	end if


	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.SetColumn(1)
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return k_return

end function

protected subroutine open_start_window ();//---
string k_esito
int k_rc
kuf_base kuf1_base
st_tab_email_invio kst_tab_email_invio
datawindowchild  kdwc_clienti_des, kdwc_clienti, kdwc_clie_settori, kdwc_gru, kdwc_clie_tipo, kdwc_iva, kdwc_pag, kdwc_oggetto
kuf_email_funzioni kuf1_email_funzioni


	kiuf_email_invio = create kuf_email_invio

	ki_toolbar_window_presente=true

//--- get la path centrale
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "path_centrale")
	if left(k_esito,1) <> "0" then
		ki_path_centrale = ""
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Errore in lettura archivio BASE (get 'path_centrale') "
	else
		ki_path_centrale = trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- Salva Argomenti programma chiamante
	if Len(trim(ki_st_open_w.key1)) = 0 then // ID su cui posizionarsi
		ki_st_tab_email_invio.id_email_invio = 0
	else
		ki_st_tab_email_invio.id_email_invio = long(trim(ki_st_open_w.key1))
	end if
	if Len(trim(ki_st_open_w.key2)) = 0 or isnull(trim(ki_st_open_w.key2)) then  // Indirizzo E-Mail 
		ki_st_tab_email_invio.email = ""
	else
		ki_st_tab_email_invio.email  = trim(ki_st_open_w.key2)
	end if
	if Len(trim(ki_st_open_w.key3)) = 0 then // ID da cui iniziare a far vedere l'elenco
		try
			kst_tab_email_invio.data_ins = relativedate(kg_dataoggi, -300)
			kiuf_email_invio.get_id_email_invio_minimo_x_data_ins(kst_tab_email_invio)	
			ki_st_tab_email_invio_1.id_email_invio = kst_tab_email_invio.id_email_invio
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
			ki_st_tab_email_invio_1.id_email_invio = 0
		end try
	else
		ki_st_tab_email_invio_1.id_email_invio = long(trim(ki_st_open_w.key3))
	end if
	if Len(trim(ki_st_open_w.key4)) = 0 then // Funzione di provenienza da elencare
		ki_st_tab_email_invio_1.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati
		ki_st_tab_email_invio_2.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
	else
//--- se ho richiesto EMAIL di tipo FATTURA allora set dei due flag possibili		
		if trim(ki_st_open_w.key4) = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati or trim(ki_st_open_w.key4) = kuf1_email_funzioni.kki_cod_funzione_fatturaNOallegati then
			ki_st_tab_email_invio_1.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturasiallegati
			ki_st_tab_email_invio_2.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_fatturanoallegati
		else
			ki_st_tab_email_invio_1.cod_funzione = trim(ki_st_open_w.key4)
			ki_st_tab_email_invio_2.cod_funzione = trim(ki_st_open_w.key4)
		end if
	end if


//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("id_cliente", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			kdwc_clienti.retrieve("%")
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			k_rc = kdwc_clienti.insertrow(1)
			k_rc = kdwc_clienti_des.insertrow(1)
		end if
	end if

end subroutine

private subroutine get_path_lettera ();//
string k_file="", k_path_file="", k_path, k_path_rit
int k_ret
long ll_p


k_file = dw_dett_0.getitemstring (1, "link_lettera")
if len(trim(k_file)) > 0 then
else
	k_file=""
end if

k_path = trim(ki_path_centrale) 
k_ret = GetFileOpenName ( "Scegli la Comunicazione", k_path_file, k_file, "", " Comunicazioni (*.*), *.*" , k_path, 8)

if k_ret = 1 then
	dw_dett_0.setitem(1, "link_lettera", trim(k_file))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine run_app_lettera ();//
string k_file="", k_path_file="", k_path, k_ext
boolean k_ret
long ll_p
kuf_file_explorer kuf1_file_explorer



k_file = trim(dw_dett_0.getitemstring (1, "link_lettera"))
if len(trim(k_file)) > 0 then
	
	ll_p = lastPos(k_file, '.')
	k_ext = right(k_file, ll_p - 1)	

	k_path = trim(k_file)


	kuf1_file_explorer = create kuf_file_explorer

//	if not kuf1_file_explorer.of_execute( k_path, k_ext) then
	if not kuf1_file_explorer.of_execute( k_path ) then
		
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage( "Il file non può essere aperto, forse estensione non riconosciuta: " + k_ext)
		kguo_exception.messaggio_utente( )
	end if

	destroy kuf1_file_explorer

else
	k_file=""
end if



end subroutine

private subroutine get_path_allegati ();//
string k_file=""
int k_ret
long ll_p
kuf_base  kuf1_base
string k_esito




k_file = dw_dett_0.getitemstring (1, "allegati_cartella")
if len(trim(k_file)) > 0 then
else
	kuf1_base = create kuf_base

	k_esito = kuf1_base.prendi_dato_base( "dir_fatt")
	if left(k_esito,1) <> "0" then
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_file	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	
end if

k_ret = GetFolder ( "Scegli la Cartella degli Allegati", k_file )

if k_ret = 1 then
	dw_dett_0.setitem(1, "allegati_cartella", trim(k_file))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//


dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 

dw_dett_0.setitem( 1, "id_cliente", kst_tab_clienti.codice)
dw_dett_0.setitem( 1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )

//attiva_tasti()


end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "

end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

protected subroutine set_titolo_window_personalizza ();//

super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'N'  // solo i NON inviati
      this.title += " -  elenco solo e-mail Non ancora Inviate  "
   case '*'  // solo i NON inviati
      this.title += " -  elenco solo e-mail Inviate    "
   case else //faccio vedere tutto
      this.title += " -  elenco di Tutte le e-mail prodotte    "
end choose



end subroutine

public function long invio_email ();//
//--- Invia e-mail
//
long k_nr_invii=0, k_riga=0, k_ctr_invio=0, k_righe_sel=0, k_email_inviate = 0
string k_mail_no="", k_testo_msg=""
st_tab_email_invio kst_tab_email_invio_1, kst_tab_email_invio[]
st_esito kst_esito


try

	kguo_exception.inizializza( )
	kguo_exception.kist_esito.nome_oggetto = this.classname()

//--- calcola il nr di righe selezionate
	k_righe_sel = 0
	k_email_inviate = 0
	k_ctr_invio = dw_lista_0.getselectedrow(k_ctr_invio)
	do while k_ctr_invio > 0 
		k_righe_sel++
		if dw_lista_0.getitemdate(k_ctr_invio, "data_inviato") > date(1990,01,01) then 
			k_email_inviate++
		end if
		k_ctr_invio = dw_lista_0.getselectedrow(k_ctr_invio)
	loop 
	
	if dw_lista_0.getselectedrow(0) = 0 then
		
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_insufficienti )
		kguo_exception.setmessage("Nessun Invio effettuato, selezionare almeno una riga" )
		kguo_exception.messaggio_utente( )
		
	else

		k_testo_msg = "Vuoi inviare "
		if k_righe_sel > 1 then
			k_testo_msg += "le  " + string (k_righe_sel) + "  e-mail selezionate? "
		else
			k_testo_msg += "la e-mail selezionata? "
		end if
		if k_email_inviate > 0 then
			k_testo_msg += kkg.acapo + "Ma ATTENZIONE ce ne sono " + string(k_email_inviate) + " segnate come gia' INVIATE!! "
		end if
		
		if messagebox("Invio e-mail", k_testo_msg, Question!, YesNo!, 2) = 1 then
	
//--- prima controllo se ok
			k_ctr_invio=0
			k_riga = dw_lista_0.getselectedrow(0)
			do while k_riga > 0 
		
				kst_tab_email_invio_1.id_email_invio = dw_lista_0.getitemnumber(k_riga, "id_email_invio") 
				kst_esito = kiuf_email_invio.get_riga( kst_tab_email_invio_1 ) 
				if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd then
					
					kguo_exception.set_esito(kst_esito)
					kst_esito.esito = "Nessun Invio effettuato. ~n~r" + trim(kst_esito.esito)
					throw kguo_exception
					
				else
					if len(trim(kst_tab_email_invio_1.email)) > 0 then
						
						k_ctr_invio++
						kst_tab_email_invio[k_ctr_invio]  = kst_tab_email_invio_1
						
					else
						
						k_mail_no += "Attenzione e-mail (id " + string(kst_tab_email_invio_1.id_email_invio ) + ") non inviata, manca indirizzo destinatario! ~n~r"
					
					end if
				end if
				
				k_riga = dw_lista_0.getselectedrow(k_riga)
			loop
	
//--- finalmente INVIO tutto!	
			for k_riga = 1 to k_ctr_invio 
		
//--- Invio e-mail	
				if kiuf_email_invio.invio(kst_tab_email_invio[k_riga]) then
					k_nr_invii ++
					
//--- aggiorna la tab invio_email con la data di invio
					kst_tab_email_invio[k_riga].data_inviato = date(kGuf_data_base.prendi_x_datins())
					kst_tab_email_invio[k_riga].ora_inviato = string(kGuf_data_base.prendi_x_datins(), "hhmmss")
					kiuf_email_invio.set_data_inviato(kst_tab_email_invio[k_riga])
					
				end if
				
			end for
			
		end if
	end if

	if k_nr_invii > 0 then
		
		leggi_liste()
		if len(trim(k_mail_no)) = 0 then
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
			kguo_exception.setmessage("Sono state inviate  " + string(k_nr_invii) + "  e-mail " )
		else
//--- scrivo sul log			
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
			kguo_exception.setmessage(" Msg anomalie e-mail: "  + trim(k_mail_no ))
			kguo_exception.scrivi_log( )
			
//msg utente			 
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
			kguo_exception.setmessage("Sono state inviate  " + string(k_nr_invii) + "  e-mail.  Ma ci sono anomalie, vedi sotto: " + kkg.acapo + k_mail_no )

		end if
	else
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
		kguo_exception.setmessage("Non sono state inviate e-mail " )
	end if
	kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ok )
	kguo_exception.messaggio_utente( )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	
end try


return k_nr_invii


end function

protected subroutine riempi_id ();//
if dw_dett_0.rowcount() > 0 then
	dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
end if
end subroutine

on w_email_invio.create
call super::create
end on

on w_email_invio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_email_invio) then destroy kiuf_email_invio

end event

type st_ritorna from w_g_tab0`st_ritorna within w_email_invio
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_email_invio
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_email_invio
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_email_invio
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_email_invio
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_email_invio
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_email_invio
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_email_invio
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_email_invio
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_email_invio
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_email_invio
integer y = 1032
integer width = 2747
integer height = 688
boolean enabled = true
string dataobject = "d_email_invio"
boolean border = true
borderstyle borderstyle = StyleRaised!
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//
	if dwo.name = "b_path_lettera" then
		get_path_lettera()
	end if
	if dwo.name = "p_img_lettera_vedi" then
		run_app_lettera()
	end if
	if dwo.name = "b_path_allegati" then
		get_path_allegati()
	end if

end event

event dw_dett_0::itemchanged;call super::itemchanged;//
int k_errore=0
long k_riga, k_rc
st_esito kst_esito
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1



choose case 	lower(dwo.name)


	case "rag_soc_10" 
		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.object.id_cliente[1] = 0
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if

	case "id_cliente" 
		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti)
		end if


end choose 



return k_errore
	
end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;int k_rc
datawindowchild  kdwc_x, kdwc_x_des


choose case lower(dwo.name)


//--- Attivo dw archivio CLIENTI
	case "rag_soc_10", "id_cliente"
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
			k_rc = this.getchild("id_cliente", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	
		end if

end choose

attiva_tasti()

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_email_invio
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_email_invio
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_email_invio_l"
boolean ki_link_standard_attivi = false
end type

type dw_guida from w_g_tab0`dw_guida within w_email_invio
end type

