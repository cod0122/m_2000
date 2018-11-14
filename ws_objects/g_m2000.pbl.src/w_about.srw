$PBExportHeader$w_about.srw
forward
global type w_about from window
end type
type cb_1 from picturebutton within w_about
end type
type st_informa from statictext within w_about
end type
type dw_1 from datawindow within w_about
end type
end forward

global type w_about from window
boolean visible = false
integer x = 672
integer y = 264
integer width = 2039
integer height = 1444
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33554431
string icon = "main.ico"
boolean clientedge = true
boolean center = true
event u_key pbm_keydown
event ue_open ( )
cb_1 cb_1
st_informa st_informa
dw_1 dw_1
end type
global w_about w_about

type variables

//
constant string ki_suona_motivo_start = "Start.wav"
st_open_w kist_open_w
kuf_sr_sicurezza kiuf_sr_sicurezza

end variables

forward prototypes
private subroutine u_check_caps_on ()
private subroutine imposta_password ()
private function boolean db_check_pwd ()
public subroutine u_update ()
public subroutine u_start ()
public function boolean u_check_date ()
public subroutine u_set_menu ()
end prototypes

event ue_open();string k_path_risorse
string k_ultimo_utente_login_data, k_utente_codice
int k_revision=0
string k_build=""
kuf_base kuf1_base
kuf_utility kuf1_utility
environment kenv

try
	
	dw_1.move(1,1)
	dw_1.resize(this.width, this.height)
	//st_versione.text = kkG_versione
	
	kuf1_utility = create kuf_utility			 
	
	this.title = trim(this.title) + "  Vers." + trim(string(kkG.versione, '00.0000')) 
	this.title = this.title + " su " + trim(kuf1_utility.u_nome_computer()) //prendo nome del Computer
	
	
//--- connessione al DB
	if not isvalid(KGuo_sqlca_db_magazzino)  then KGuo_sqlca_db_magazzino = SQLCA
	kguo_sqlca_db_magazzino.db_connetti( )
	
//--- set la path centrale sul SERVER
	kGuo_path.set_path_base_del_server( ) 
	KG_path_base_del_server = kGuo_path.get_base_del_server( )
	KG_PATH_BASE_DEL_SERVER_JOB = kGuo_path.get_base_del_server_job( )
	
//--- set la path BASE ovvero dove risiedono ad esempio gli errori (spesso c:\at_m2000)
	kGuo_path.set_path_base( )
	kg_path_base = kGuo_path.get_base()
	kGuo_path.set_arch_saveas( )  //cartella salvataggio DW 
	
//--- path per reperire il grafico del LOGO 
	k_path_risorse = kGuo_path.get_risorse()

	kiuf_sr_sicurezza = create kuf_sr_sicurezza

	dw_1.insertrow(0)

	k_revision = GetEnvironment(kenv)
	if k_revision = 1 then
		k_revision = kenv.pbbuildnumber   //--- get del numero di build di PB
		if k_revision > 0 then
			k_build = "pb build: " + string(k_revision)
		end if
	end if
	dw_1.setitem(1, "st_rev", k_build)

//--- disconnessione dal DB
	kguo_sqlca_db_magazzino.db_disconnetti( )
	
	
	if kist_open_w.flag_modalita = kkg_flag_modalita.visualizzazione then
	
		cb_1.visible = false

		dw_1.modify("sle_password.protect = '1' sle_utente.protect = '1'")
		dw_1.modify("sle_password.Background.Color='"+ string(kkg_colore.campo_disattivo)+"' sle_utente.Background.Color='"+ string(kkg_colore.campo_disattivo)+"'")
		//sle_password.enabled = false
		//sle_password.backcolor = kkg_colore.grigio
		//sle_utente.enabled = false
		//sle_utente.backcolor = kkg_colore.grigio
		dw_1.setitem(1, "sle_utente", kguo_utente.get_codice())
		//sle_utente.text = kguo_utente.get_codice()
	
	else
		
		
		kuf1_base = create kuf_base
		k_utente_codice = trim(mid(kuf1_base.prendi_dato_base("ultimo_utente_login_nome"), 2))
		if len(trim(k_utente_codice)) = 0 or trim(k_utente_codice) = "nullo" then
			k_utente_codice = trim(mid(kuf1_base.prendi_dato_base("utente_login"), 2))
		end if
		k_ultimo_utente_login_data = trim(mid(kuf1_base.prendi_dato_base("ultimo_utente_login_data"), 2))
		destroy kuf1_base
		
		if len(trim(k_utente_codice)) = 0 then
			k_utente_codice = " "
		end if
		kGuo_utente.set_codice(k_utente_codice)
	
		dw_1.setitem(1, "sle_utente", k_utente_codice)
		//sle_utente.text = k_utente_codice
		if len(trim(k_ultimo_utente_login_data)) = 0 or trim(k_ultimo_utente_login_data) = "nullo" then
			dw_1.setitem(1, "st_ultimo_utente_login_data", "")
			//st_ultimo_utente_login_data.text = " "
		else
			dw_1.setitem(1, "st_ultimo_utente_login_data", "ultimo accesso: " + trim(k_ultimo_utente_login_data) &
								 + "  (" + trim(k_utente_codice) + ") ")
			//st_ultimo_utente_login_data.text = "ultimo accesso: " + trim(k_ultimo_utente_login_data) &
			//					 + "  (" + trim(k_utente_codice) + ") "
		end if
	
		dw_1.setcolumn("sle_password")
		
		dw_1.modify("cb_img_start.enabled = '1'")
		
//		sle_password.setfocus()
	end if
	
	if kuf1_utility.u_check_network() then
		dw_1.setitem(1, "st_net", "Rete Connessa")
	else
		dw_1.setitem(1, "st_net", "Rete Assente")
	end if

	u_check_caps_on()

	this.show( )

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
	halt close

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try



end event

private subroutine u_check_caps_on ();//
kuf_utility kuf1_utility


kuf1_utility = create kuf_utility			 
if kuf1_utility.u_check_caps_on() then
	dw_1.setitem(1, "st_caps", "MAIUSC  ON")
//	st_caps.text = "MAIUSC  ON"
else
	dw_1.setitem(1, "st_caps", "maiusc OFF")
//	st_caps.text = "MAIUSC  OFF"
end if
destroy kuf1_utility

end subroutine

private subroutine imposta_password ();//=== Lancia il Logo iniziale
//open (w_about)
//
st_open_w kst_open_w
kuf_menu kuf1_menu


	kuf1_menu = create kuf_menu
	kuf1_menu.set_tab_menu_window( )
	destroy kuf1_menu

//===
//=== Menu Treeview
//===
	kst_open_w.id_programma = "srpassword_c"
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = "mo"
	kst_open_w.flag_adatta_win = "s"
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key1 = string(kguo_utente.get_id_utente( )) // get_pwd())
	kst_open_w.key2 = " "
	kst_open_w.key3 = " "
	kst_open_w.key4 = " " 

	
	kguf_menu_window.open_w_tabelle(kst_open_w)


							
							



end subroutine

private function boolean db_check_pwd ();//
boolean k_return = false
string k_passwd="", k_utente=""
int k_ctr
st_tab_sr_utenti kst_tab_sr_utenti  
st_esito kst_esito


try

	kGuo_utente.set_pwd(0)
	
	k_utente = trim(dw_1.getitemstring(1, "sle_utente"))
	if k_utente > " " then
	else
		k_utente = kguo_utente.get_codice()
	end if
	//k_ctr = dw_1.rowcount()
	k_passwd = trim(dw_1.getitemstring(1, "sle_password"))
	if k_passwd > " " then
	else
		k_passwd = ""
	end if
		
	kst_tab_sr_utenti.codice = upper(k_utente)
	kst_tab_sr_utenti.password = trim(k_passwd)
	k_return = kiuf_sr_sicurezza.check_user_password (kst_tab_sr_utenti)

//--- Utente esistente imposto variabili globali
	if kst_tab_sr_utenti.id > 0 then
		kguo_utente.set_pwd (kst_tab_sr_utenti.id)   // OBSOLETO mantenuto solo per compatibilità con il passato
		kguo_utente.set_nome(kst_tab_sr_utenti.nome) 
		kguo_utente.set_codice(kst_tab_sr_utenti.codice)
		kguo_utente.set_id_utente(kst_tab_sr_utenti.id)
	end if
	
//--- se password corretta non faccio niente
	if k_return then
							
	else			
		kguo_utente.set_pwd (0) 
		kst_esito = kiuf_sr_sicurezza.tb_select(kst_tab_sr_utenti)
		if kst_esito.esito = kkg_esito.ok then 
			messagebox("Accesso non Autorizzato", "Password non riconosciuta, sono rimasti " + string(kst_tab_sr_utenti.tentativi_max - kst_tab_sr_utenti.tentativi_ko) + " tentativi.", information!)
		else
			messagebox("Accesso non Autorizzato", "Provare a ripetere le credenziali di accesso")
		end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

//--- Utente esistente imposto variabili globali
	if kst_tab_sr_utenti.id > 0 then
		kguo_utente.set_pwd (kst_tab_sr_utenti.id)   // OBSOLETO mantenuto solo per compatibilità con il passato
		kguo_utente.set_nome(kst_tab_sr_utenti.nome) 
		kguo_utente.set_codice(kst_tab_sr_utenti.codice)
		kguo_utente.set_id_utente(kst_tab_sr_utenti.id)
	end if
	
	choose case kst_esito.esito

		case kkg_esito.pwd_inscad 
		
			if messagebox ("Accesso al Sistema", trim(kst_esito.sqlerrtext) + "~n~r" + "Vuoi cambiarla ora? ", Question!, yesno!, 1) = 1 then
				imposta_password()
			else
				k_return = true  // OK lancia M2000
			end if

		case kkg_esito.pwd_scaduta  // PWD scaduta deve essere cambiata!!!
			messagebox ("Accesso al Sistema", trim(kst_esito.sqlerrtext), Exclamation!, ok! &
							) 
			imposta_password()

		case else
			messagebox ("Controllo Password", trim(kst_esito.sqlerrtext), information!)
//						"E' stato riscontrato il seguente errore:~n~r" &
//						+ "~n~r" &

	end choose	
	
end try


return k_return 


end function

public subroutine u_update ();//
kuf_utility kuf1_utility
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable




	if messagebox ("Aggiorna M2000", "Vuoi eseguire l'aggiornamento programmi della Procedura?", &
					 question!, YesNo!, 2) = 1 then

		this.enabled = false
		cb_1.enabled = false
		st_informa.text = "Aggiorna M2000:  Chiusura archivi in esecuzione...."
		st_informa.visible = true
		
		oldpointer = SetPointer(HourGlass!)

//		kuf1_db = create kuf_db			 
		
		try
			KGuo_sqlca_db_magazzino.db_connetti()

			kuf1_utility = create kuf_utility			 
			//kuf1_utility.u_aggiorna_procedura()			
			kuf1_utility.u_aggiorna_procedura_diprova( )
			destroy kuf1_utility

		catch (uo_exception kuo_exception)
				
			kst_esito =kuo_exception.get_st_esito( )
			kuf1_utility = create kuf_utility
			if kuf1_utility.u_check_network() then
				messagebox("Problemi di connessione con il DB", trim(kst_esito.sqlerrtext ))
			else
				messagebox("Connessione al DB", "Attenzione connessione non effettuata, ~r~nmanca la connessione al Server di Rete")
			end if
			destroy kuf1_utility		
			
		finally	
//			destroy kuf1_db

		end try 

		
		 SetPointer(oldpointer)

//--- ESCE PROCEDURA		
		close(this)

		
	end if

end subroutine

public subroutine u_start ();//
boolean k_chiudi = false
string k_utente,  k_passwd
st_esito kst_esito
kuf_utility kuf1_utility
kuf_menu_window kuf1_menu_window
kuf_base kuf1_base
st_tab_base kst_tab_base


setpointer(kkg.pointer_attesa)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname() 


try


//--- acquisisce user e password per accedere al DB		
	k_utente = trim(dw_1.getitemstring(1, "sle_utente"))
	if k_utente > " " then
	else
		k_utente = ""
	end if
	k_passwd = trim(dw_1.getitemstring(1, "sle_password"))
	if k_passwd > " " then
	else
		k_passwd = ""
	end if
//--- Se password del programmatore accede diversamente
	if kiuf_sr_sicurezza.u_if_master(k_passwd) then
		KGuo_sqlca_db_magazzino.ki_user = ""
		KGuo_sqlca_db_magazzino.ki_password = ""
	else
		KGuo_sqlca_db_magazzino.db_disconnetti()
		KGuo_sqlca_db_magazzino.ki_user = k_utente
		KGuo_sqlca_db_magazzino.ki_password = k_passwd
	end if		

//--- Se immessa Password e DB NON connesso: allora CONNESSIONE
	if KGuo_sqlca_db_magazzino.DBHandle ( ) <= 0 or not isvalid(KGuo_sqlca_db_magazzino) then

		KGuo_sqlca_db_magazzino.db_connetti()
	
//--- Segnala il tentativo di Start dell'applicazione (I=messaggio Informativo)
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "START Procedura M2000 - "  &
									+ ", Parametri DB Dbms.: " + trim(KGuo_sqlca_db_magazzino.dbparm) + ", "  &
									+ " Tentativo connessione al Server: " + KGuo_sqlca_db_magazzino.servername + ", " &
								    + " Utente presunto: " + kguo_utente.get_codice()
		kGuf_data_base.errori_scrivi_esito("I", kst_esito) 

		kguo_g.set_anno_procedura( )
		u_check_date( )  // controlla che la data di lavoro sia coerente


		
	end if


catch (uo_exception kuo_exception)
		
	setpointer(kkg.pointer_default)
	
	kst_esito = kuo_exception.get_st_esito( )

	kuf1_utility = create kuf_utility
	kguo_exception.inizializza( )
	if kuf1_utility.u_check_network() then
		kguo_exception.messaggio_utente("Problemi di connessione con il DB", trim(kst_esito.sqlerrtext ))
	else
		kguo_exception.messaggio_utente("Connessione al DB", "Attenzione connessione non effettuata, ~r~nconnessione al Server di rete Assente ! ")
	end if
	destroy kuf1_utility		

finally


end try

	
if kst_esito.esito <> kkg_esito.ok then	

	KGuo_sqlca_db_magazzino.db_disconnetti()
		
	dw_1.setitem(1, "sle_password", "")
	dw_1.setcolumn("sle_password")
	
else
	
//--- Se Connessione OK inizio con il controllo della password digitata
	if db_check_pwd() then

//--- Segnala il logon dell'applicazione (I=messaggio Informativo)
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Connessione Accesso alla Procedura M2000 Accettata. " &
								    + " Utente di login: " + kguo_utente.get_codice()
		kGuf_data_base.errori_scrivi_esito("I", kst_esito) 

////--- pswd ok
//	if kguo_utente.get_pwd() > 0 then
		
		k_chiudi = true
		
		if isvalid(w_main) = false then

			u_set_menu( )

			open(w_main)

//--- Suona Motivo di attivazione programma
			kGuf_data_base.post suona_motivo(ki_suona_motivo_start, 0)
				
		else
//--- w_main già aperta per cui lancio solo l'evento OPEN

			u_set_menu( )

			w_main.inizializza()
				
		end if

//--- Salvo in INI il nome utente collegato e la data-ora
		kuf1_base = create kuf_base
		kst_tab_base.key = "ultimo_utente_login_nome" 
		kst_tab_base.key1 = kguo_utente.get_codice() 
		kuf1_base.metti_dato_base(kst_tab_base)
		kst_tab_base.key = "ultimo_utente_login_data" 
		kst_tab_base.key1 = string(now(), "dd/mm/yy  hh:mm")
		kuf1_base.metti_dato_base(kst_tab_base)
		destroy kuf1_base

////---- compatta il codice Utente
//		kg_utente_comp = kguo_utente.get_comp()

	else
	//--- pwd non ok
		dw_1.setitem(1, "sle_password", "")
		dw_1.setcolumn("sle_password")

//--- Segnala il logon dell'applicazione (I=messaggio Informativo)
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
		kst_esito.sqlerrtext = "Connessione alla Procedura M2000 RESPINTA!. " &
								    + " Tantativo da Utente: " + kguo_utente.get_codice()
		kGuf_data_base.errori_scrivi_esito("I", kst_esito) 
		
	end if
		
end if
	
setpointer(kkg.pointer_default)
	
if k_chiudi then
	close(this)
end if


end subroutine

public function boolean u_check_date ();//---
//---  Controlla che la data sia conguente
//---
boolean k_return = false
datetime k_datetime
int k_anno, k_anno_base
string k_dato
kuf_base kuf1_base


kuf1_base = create kuf_base

k_datetime = kGuf_data_base.prendi_x_datins()
k_anno = integer(string(k_datetime, "yyyy"))

k_dato = kuf1_base.prendi_dato_base("anno")
if left(k_dato, 1) = "0" then
	if isnumber(mid(k_dato, 2)) then
		k_anno_base = integer(mid(k_dato, 2))
		if k_anno = k_anno_base or k_anno = (k_anno_base + 1) then
			k_return = true
		end if
	end if
end if

destroy kuf1_base

if not k_return then
	kguo_exception.inizializza( )
	kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali)
	kguo_exception.setmessage( "ATTENZIONE DATA ERRATA", "La data " + string(k_datetime, "[ShortDate]") &
					+ " rilevata su questo terminale non è conguente con l'anno " + string(k_anno_base) + " indicato in Proprità Azienda come Anno di esercizio." &
					+ "~n~rATTENZIONE qualunque modifica potrebbe causare danni ai dati.")
	kguo_exception.messaggio_utente( )
end if

return k_return

end function

public subroutine u_set_menu ();//
kuf_menu kuf1_menu


	kuf1_menu = create kuf_menu
//--- Popola Tabella della SICUREZZA: abilitazione alle funzioni x Utente
	kuf1_menu.set_tab_menu_window( )
	destroy kuf1_menu

	if isvalid(w_main) then
		w_main.ki_menu_0.u_inizializza( ) 
	//	kGuf_menu_window.autorizza_menu( ki_menu ) 
		w_main.ki_menu_0.autorizza_menu()
	//	kGuf_menu_window.set_icone(ki_menu)

	end if
end subroutine

on w_about.create
this.cb_1=create cb_1
this.st_informa=create st_informa
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_informa,&
this.dw_1}
end on

on w_about.destroy
destroy(this.cb_1)
destroy(this.st_informa)
destroy(this.dw_1)
end on

event key;//
//=== Controllo quale tasto da tastiera ha premuto
//

choose case key

	case keyenter! 
		u_start( )

	case keyescape! 
		close(this)

//	case else
//		post u_check_caps_on()

end choose


end event

event open;//
//ki_nome_save = trim(this.ClassName())
	
if isvalid(message.powerobjectparm) then
	kist_open_w = message.powerobjectparm
else
	kist_open_w.flag_modalita = kkg_flag_modalita.inserimento
end if

setpointer(hourglass!)

event post ue_open()



end event

event close;//
if isvalid(kiuf_sr_sicurezza) then destroy kiuf_sr_sicurezza
end event

type cb_1 from picturebutton within w_about
boolean visible = false
integer x = 1774
integer y = 480
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
boolean flatstyle = true
string picturename = "C:\testGammarad\pb_sterigenics\icone\confirm.png"
string powertiptext = "Entra"
long textcolor = 16777215
long backcolor = 15793151
end type

event clicked;//
u_start()

end event

type st_informa from statictext within w_about
boolean visible = false
integer x = 27
integer y = 776
integer width = 1961
integer height = 116
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 15780518
string text = "none"
alignment alignment = center!
boolean border = true
long bordercolor = 255
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_about
event u_enter pbm_dwnprocessenter
integer y = 4
integer width = 2016
integer height = 1348
integer taborder = 10
string title = "none"
string dataobject = "d_about"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event u_enter;//
this.accepttext( )
u_start()
end event

event buttonclicked;//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))

	if k_nome = "p_img_gplv" then
	
		open (w_gnu_gpl)
	
	elseif k_nome = "p_img_update" then
		
		u_update()
		
	elseif k_nome = "cb_img_start" then
	
		u_start()	
		
	end if
	
end event

event clicked;//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))

	if k_nome = "p_img_gplv" then
	
		open (w_gnu_gpl)
	
//	elseif k_nome = "p_img_update" then
//		
//		u_update()
//		
//	elseif k_nome = "cb_img_start" then
//	
//		u_start()	
		
	end if
	
end event

