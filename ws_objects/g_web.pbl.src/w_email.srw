$PBExportHeader$w_email.srw
forward
global type w_email from w_g_tab0
end type
end forward

global type w_email from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean maxbox = false
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_consenti = false
boolean ki_resize_dw_dett = true
end type
global w_email w_email

type variables
//
private kuf_email kiuf_email
private st_tab_email ki_st_tab_email
private string ki_path_email =""

private string ki_mostra_nascondi_in_lista = "S"

end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
private function integer check_rek ()
protected function integer visualizza ()
protected subroutine attiva_menu ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine smista_funz (string k_par_in)
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
private subroutine run_app_lettera ()
protected subroutine riempi_id ()
private subroutine get_lettera ()
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


//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = "S" then 
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
	
			if dw_lista_0.retrieve( ki_mostra_nascondi_in_lista ) < 1 then
				k_return = "1Email Non trovate  "
	
				SetPointer(oldpointer)
				messagebox("Lista 'E-mail' Vuota", &
						"Nesun Codice Trovato per la richiesta fatta")
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il ID allora....
					if ki_st_tab_email.id_email > 0 then
						k_riga = dw_lista_0.find( "id_email = " + string(ki_st_tab_email.id_email) + " ", 1, dw_lista_0.rowcount( ) )
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
	
return k_return



end function

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                		: 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
st_tab_email kst_tab_email


	k_riga = dw_dett_0.getrow()

	kst_tab_email.codice = dw_dett_0.getitemstring ( k_riga, "codice") 
	if isnull(kst_tab_email.codice) or LenA(trim(kst_tab_email.codice)) = 0 then
		k_return = k_return + "Manca il Codice E-mail " + "~n~r"
		k_errore = "3"

	else


//--- c'e' gia' il Codice?
		if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
			
			kst_tab_email.codice = trim(dw_dett_0.getitemstring(1, "codice"))  

			SELECT 
					email.des
			 INTO 
					:k_descr
			FROM email 
			WHERE codice = :kst_tab_email.codice ;

			if sqlca.sqlcode = 0 then 
				
				if LenA(trim(k_descr)) = 0 then 
					k_descr = "nessuna descrizione "
				end if
		
				k_return = k_return + "E-mail " + trim(kst_tab_email.codice) + &
							  " già in Archivio con descrizione:~n~r" + &
							  trim(k_descr) 
				k_errore = "1"
		
			end if		
		end if
	end if

	
//--- errori diversi
   if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
		if isnull(dw_dett_0.getitemstring ( k_riga, "des")) &
					   or len(trim(dw_dett_0.getitemstring(dw_dett_0.getrow(), "des"))) = 0 then 
				k_return = k_return + "Manca la Descrizione " + "~n~r" 
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
		if isnull(dw_dett_0.getitemstring(k_riga, "stato")) then
			k_rc=dw_dett_0.setitem(k_riga, "stato", kiuf_email.ki_stato_attivo )
		end if
		if isnull(dw_dett_0.getitemstring(k_riga, "flg_lettera_html")) then
			k_rc=dw_dett_0.setitem(k_riga, "flg_lettera_html", kiuf_email.ki_lettera_html_no )
		end if
		if isnull(dw_dett_0.getitemstring(k_riga, "flg_ritorno_ricev")) then
			k_rc=dw_dett_0.setitem(k_riga, "flg_ritorno_ricev", kiuf_email.ki_ricev_ritorno_no )
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
st_tab_email kst_tab_email
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
	k_codice = string(dw_dett_0.getitemnumber(1, "id_email"))
	k_descr = trim(dw_dett_0.getitemstring(1, "email"))
	kst_tab_email.id_email = dw_dett_0.getitemnumber(k_riga, "id_email") 
	k_riga = 1
else
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = string(dw_lista_0.getitemnumber(k_riga, "id_email"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "email"))
		kst_tab_email.id_email = dw_lista_0.getitemnumber(k_riga, "id_email") 
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

	if messagebox("Elimina " + this.title , "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		kst_esito = kiuf_email.tb_delete(kst_tab_email) 
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
					k_codice = string(dw_dett_0.getitemnumber(1, "id_email"))
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

private function integer check_rek ();//
int k_return = 0
int k_anno
st_tab_email kst_tab_email


	kst_tab_email.codice = dw_dett_0.getitemstring(1, "codice")  

	SELECT
         email.des
   	 INTO
      	   :kst_tab_email.des
    	FROM email
   	WHERE codice = :kst_tab_email.codice ;

	if sqlca.sqlcode = 0 then 
		
		if LenA(trim(kst_tab_email.des)) = 0 then 
			kst_tab_email.des = "non presente "
		end if
		
		if messagebox("E-mail gia' in Archivio", & 
					"Codice e-mail " + trim(kst_tab_email.codice) + " " + & 
					"con descrizione:  ~n~r" + trim(kst_tab_email.des), &
				   StopSign!) = 2 then
		

			dw_dett_0.reset()
//			inizializza()
		
			k_return = 1
		end if
	end if  

//	attiva_tasti()



return k_return


end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

	dw_dett_0.setitem(k_return, "k_path_base", ki_path_email )

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
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi E-mail Attive"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"Mostra o Nasconde le E-mail Attive/Non Attive"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Nascondi,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DeleteRow!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
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
		dw_lista_0.u_filtra_record("stato <> 'A' ") 
	else
		if ki_mostra_nascondi_in_lista = "N" then	
			ki_mostra_nascondi_in_lista = "*"
			leggi_liste()
			dw_lista_0.u_filtra_record("stato = 'A'") 
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
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "id_email", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "stato", kiuf_email.ki_stato_attivo )
	dw_dett_0.setitem(dw_dett_0.getrow(), "link_lettera", "" )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_lettera_html", kiuf_email.ki_lettera_html_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "flg_ritorno_ricev", kiuf_email.ki_ricev_ritorno_no )
	dw_dett_0.setitem(dw_dett_0.getrow(), "k_path_base", ki_path_email )

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


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_email")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

	dw_dett_0.setitem(k_return, "k_path_base", ki_path_email )

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
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
kuf_base kuf1_base


	kiuf_email = create kuf_email

	ki_toolbar_window_presente=true

//--- get la path centrale
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "path_centrale")
	if left(k_esito,1) <> "0" then
		ki_path_email = ""
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Errore in lettura archivio BASE (get 'path_centrale') "
	else
		ki_path_email = trim(mid(k_esito,2)) +  kiuf_email.kki_path_email
		CreateDirectory ( ki_path_email )
	end if
	destroy kuf1_base

//	dw_dett_0.object.p_lettera_vedi.FileName = kGuo_path.get_risorse() + kkg.path_sep + "lente16x16.gif"

//--- Salva Argomenti programma chiamante
	if Len(trim(ki_st_open_w.key1)) = 0 then // ID
		ki_st_tab_email.id_email = 0
	else
		ki_st_tab_email.id_email = long(trim(ki_st_open_w.key1))
	end if
	if Len(trim(ki_st_open_w.key2)) = 0 or isnull(trim(ki_st_open_w.key2)) then  // MOSTRA EMAIL S=IN VIGORE; N=SOSESI; %=TUTTI  
		ki_mostra_nascondi_in_lista = "%"
	else
		ki_mostra_nascondi_in_lista  = trim(trim(ki_st_open_w.key2))
	end if
	if Len(trim(ki_st_open_w.key3)) = 0 or isnull(trim(ki_st_open_w.key3)) then  // CODICE  
		ki_st_tab_email.codice = ""
	else
		ki_st_tab_email.codice  = trim(ki_st_open_w.key3)
	end if

end subroutine

private subroutine run_app_lettera ();//
string k_file="", k_path_file="", k_path, k_ext
boolean k_ret
long ll_p
kuf_file_explorer kuf1_file_explorer



k_file = trim(dw_dett_0.getitemstring (1, "link_lettera"))
if len(trim(k_file)) > 0 then
	
//	ll_p = lastPos(k_file, '.')
//	k_ext = right(k_file, ll_p - 1)	
//
//	k_path = trim(ki_path_email) + trim(kiuf_email.kki_path_email) + "\" + trim(k_file)


	kuf1_file_explorer = create kuf_file_explorer

//	if not kuf1_file_explorer.of_execute( k_path, k_ext) then
	if not kuf1_file_explorer.of_execute( k_file ) then
		
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage( "Il file non può essere aperto, forse estensione non riconosciuta: " + k_ext)
		kguo_exception.messaggio_utente( )
	end if

	destroy kuf1_file_explorer

else
	k_file=""
end if



end subroutine

protected subroutine riempi_id ();//

if dw_dett_0.rowcount() > 0 then
	dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
end if
end subroutine

private subroutine get_lettera ();//
string k_file="", k_path_file="", k_path, k_path_rit
int k_ret, k_sn
long ll_p


k_file = dw_dett_0.getitemstring (1, "link_lettera")
if len(trim(k_file)) > 0 then
else
	k_file=""
end if

k_path = ".."  //trim(ki_path_email) + trim(kiuf_email.kki_path_email)
k_ret = GetFileOpenName ( "Scegli la Comunicazione", k_path_file, k_file, "txt", " Comunicazioni (*.*),*.*" , k_path, 32784)

if k_ret = 1 then
	ll_p = lastPos(k_path_file, kkg.path_sep)
	k_path_rit = left(k_path_file, ll_p - 1)	
	if not FileExists(k_path_file) then 
//	if lower(trim(k_path_rit)) <> lower(trim(k_path)) then
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
		kguo_exception.setmessage( "Non trovo il file selezionato: ~n~r" + k_path_file+k_file)
		kguo_exception.messaggio_utente( )
	else
		k_sn = 1
		if FileExists(ki_path_email+ kkg.path_sep +k_file) then 
			k_sn = messagebox("File già presente", "Vuoi ricoprire il file? ", question!, yesno!, 2) 	
		end if
		if k_sn = 1 then
			setpointer(kkg.pointer_attesa)
			filedelete(ki_path_email+ kkg.path_sep +k_file)
			if filecopy(k_path_file, ki_path_email+ kkg.path_sep +k_file, true) > 0 then
				dw_dett_0.setitem(1, "link_lettera", trim(ki_path_email+ kkg.path_sep +k_file))
				setpointer(kkg.pointer_default)
			else
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
				kguo_exception.setmessage( "Errore durante tentativo di Importare il file: ~n~r" + ki_path_email+ kkg.path_sep +k_file)
				kguo_exception.messaggio_utente( )
			end if
		end if
	end if
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

on w_email.create
call super::create
end on

on w_email.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_email) then destroy kiuf_email

end event

type st_ritorna from w_g_tab0`st_ritorna within w_email
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_email
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_email
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_email
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_email
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_email
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_email
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_email
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_email
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_email
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_email
integer y = 1032
integer width = 2747
integer height = 792
boolean enabled = true
string dataobject = "d_email"
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::buttonclicked;call super::buttonclicked;//
	if dwo.name = "b_path_lettera" & 
	     and (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
		get_lettera()
	end if
	if dwo.name = "p_img_lettera_vedi" then
		run_app_lettera()
	end if

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_email
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_email
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_email_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_email
end type

