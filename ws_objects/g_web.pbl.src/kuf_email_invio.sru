$PBExportHeader$kuf_email_invio.sru
forward
global type kuf_email_invio from kuf_parent
end type
end forward

global type kuf_email_invio from kuf_parent
end type
global kuf_email_invio kuf_email_invio

type variables

//--- flag allegati
 string ki_allegati_si = "S"
 string ki_allegati_no = "N"

//--- in HTML
 string ki_lettera_html_si = "S"
 string ki_lettera_html_no = "N"

//--- Ricevuta di ritorno
 string ki_ricev_ritorno_si = "S"
 string ki_ricev_ritorno_no = "N"



end variables

forward prototypes
public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_invio kst_tab_email_invio)
public function st_esito get_riga (ref st_tab_email_invio kst_tab_email_invio)
public subroutine if_isnull (st_tab_email_invio kst_tab_email_invio)
public function st_esito tb_delete (st_tab_email_invio kst_tab_email_invio)
public function boolean tb_add (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function st_esito get_email (ref st_tab_email_invio kst_tab_email_invio)
public function boolean tb_update (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean invio (st_tab_email_invio kst_tab_email_invio)
public function boolean set_data_inviato (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function st_esito check_presenza (ref st_tab_email_invio kst_tab_email_invio)
public function st_esito get_allegati_cartella (ref st_tab_email_invio kst_tab_email_invio)
public function integer delete_allegati (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean get_id_email_invio_minimo_x_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long if_presente_x_id_oggetto (st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean tb_add_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function boolean tb_update_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception
public function long get_id_email_invio_max () throws uo_exception
end prototypes

public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_invio kst_tab_email_invio);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore di anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come Standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if isvalid(kdw_anteprima)  then
		if kdw_anteprima.dataobject = "d_email_invio"  then
			if kdw_anteprima.object.id_email_invio[1] = kst_tab_email_invio.id_email_invio  then
				kst_tab_email_invio.id_email_invio = 0
			end if
		end if
	end if

	if kst_tab_email_invio.id_email_invio > 0 then
	
			kdw_anteprima.dataobject = "d_email_invio"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_email_invio.id_email_invio)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Invio E-mail da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito get_riga (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail 
//=== 
//=== input: st_tab_email con valorizzato il campo id_email
//=== Ritorna tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.email,   
         email_invio.note,   
         email_invio.id_cliente,   
         email_invio.data_ins,   
         email_invio.data_inviato,   
         email_invio.ora_inviato,   
         email_invio.oggetto,   
         email_invio.link_lettera,   
         email_invio.allegati_cartella,   
         email_invio.flg_lettera_html,   
         email_invio.flg_ritorno_ricev,  
         email_invio.email_di_ritorno,  
         email_invio.flg_allegati 
    INTO 
         :kst_tab_email_invio.email,   
         :kst_tab_email_invio.note,   
         :kst_tab_email_invio.id_cliente,   
         :kst_tab_email_invio.data_ins,   
         :kst_tab_email_invio.data_inviato,   
         :kst_tab_email_invio.ora_inviato,   
         :kst_tab_email_invio.oggetto,   
         :kst_tab_email_invio.link_lettera,   
         :kst_tab_email_invio.allegati_cartella,   
         :kst_tab_email_invio.flg_lettera_html,   
         :kst_tab_email_invio.flg_ritorno_ricev,  
         :kst_tab_email_invio.email_di_ritorno,  
         :kst_tab_email_invio.flg_allegati 
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail  ~n~r" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public subroutine if_isnull (st_tab_email_invio kst_tab_email_invio);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_email_invio.id_email_invio) then kst_tab_email_invio.id_email_invio = 0
if isnull(kst_tab_email_invio.cod_funzione) then kst_tab_email_invio.cod_funzione = ""
if isnull(kst_tab_email_invio.note) then kst_tab_email_invio.note= ""
if isnull(kst_tab_email_invio.id_oggetto) then kst_tab_email_invio.id_oggetto = 0
if isnull(kst_tab_email_invio.id_cliente) then kst_tab_email_invio.id_cliente = 0
if isnull(kst_tab_email_invio.data_ins) then kst_tab_email_invio.data_ins= date(0)
if isnull(kst_tab_email_invio.data_inviato) then kst_tab_email_invio.data_inviato= date(0)
if isnull(kst_tab_email_invio.email) then kst_tab_email_invio.email= ""
if isnull(kst_tab_email_invio.ora_inviato) then kst_tab_email_invio.ora_inviato= ""
if isnull(kst_tab_email_invio.allegati_cartella) then kst_tab_email_invio.allegati_cartella = ""
if isnull(kst_tab_email_invio.flg_allegati) then kst_tab_email_invio.flg_allegati = ""
if isnull(kst_tab_email_invio.oggetto) then kst_tab_email_invio.oggetto = ""
if isnull(kst_tab_email_invio.link_lettera) then kst_tab_email_invio.link_lettera = ""
if isnull(kst_tab_email_invio.flg_lettera_html) then kst_tab_email_invio.flg_lettera_html = ""
if isnull(kst_tab_email_invio.flg_ritorno_ricev) then kst_tab_email_invio.flg_ritorno_ricev = ""
if isnull(kst_tab_email_invio.email_di_ritorno) then kst_tab_email_invio.email_di_ritorno = ""
if isnull(kst_tab_email_invio.flg_lettera_html) then kst_tab_email_invio.flg_lettera_html = ""

end subroutine

public function st_esito tb_delete (st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== Cancella il rek dalla tabella email_invio 
//=== 
//=== Ritorna ST_ESITO
//===           		
//====================================================================

boolean k_autorizza, k_presente
long k_cli
st_tab_base kst_tab_base
kuf_base kuf1_base
st_tab_arfa kst_tab_arfa_pdf
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Invio E-mail non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else
	
	this.get_allegati_cartella(kst_tab_email_invio)

	delete from email_invio
					where id_email_invio = :kst_tab_email_invio.id_email_invio 
					using sqlca;

	if sqlca.sqlCode <> 0 then

		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante cancellazione Invio Email (email_invio) ~n~r" +  trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if

	else
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if

		if len(trim(kst_tab_email_invio.allegati_cartella)) > 0 then
			try
				delete_allegati(kst_tab_email_invio)
			catch	(uo_exception kuo_exception)
		
			end try
			
		end if

	end if
end if


return kst_esito
end function

public function boolean tb_add (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiunge un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = true
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_tab_email_invio.id_email_invio = 0

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()
	
	kst_esito = get_email(kst_tab_email_invio)
//	if kst_esito.esito = kkg_esito.ok then
//
//		update email_invio
//			set email = :kst_tab_email_invio.email
//				,  data_ins = :kst_tab_email_invio.data_ins
//				,  oggetto = :kst_tab_email_invio.oggetto
//				,  link_lettera = :kst_tab_email_invio.link_lettera
//				,  flg_lettera_html = :kst_tab_email_invio.flg_lettera_html
//				,  flg_allegati = :kst_tab_email_invio.flg_allegati
//				,  allegati_cartella = :kst_tab_email_invio.allegati_cartella
//				,  flg_ritorno_ricev = :kst_tab_email_invio.flg_ritorno_ricev
//				,  x_datins = :kst_tab_email_invio.x_datins
//				,  x_utente = :kst_tab_email_invio.x_utente
//			where id_email_invio = :kst_tab_email_invio.id_email_invio
//			using kguo_sqlca_db_magazzino;
//
//	
//	else
//
//	if kst_esito.esito = kkg_esito.db_not_ok then
	
	kst_tab_email_invio.data_ins = date(kst_tab_email_invio.x_datins) 
	
	if_isnull(kst_tab_email_invio)
	//id_email_invio,   
	INSERT INTO email_invio  
				( 
				  cod_funzione,
				  note,   
				  id_oggetto,   
				  id_cliente,   
				  email,   
				  data_ins,   
				  oggetto,   
				  link_lettera,   
				  flg_lettera_html,   
				  flg_allegati,   
				  allegati_cartella,   
				  flg_ritorno_ricev,   
				  email_di_ritorno,
				  x_datins,   
				  x_utente )  
			  VALUES ( 
						  :kst_tab_email_invio.cod_funzione,
						  :kst_tab_email_invio.note,   
						  :kst_tab_email_invio.id_oggetto,   
						  :kst_tab_email_invio.id_cliente,   
						  :kst_tab_email_invio.email,   
						  :kst_tab_email_invio.data_ins,   
						  :kst_tab_email_invio.oggetto,   
						  :kst_tab_email_invio.link_lettera,   
						  :kst_tab_email_invio.flg_lettera_html,   
						  :kst_tab_email_invio.flg_allegati,   
						  :kst_tab_email_invio.allegati_cartella,   
						  :kst_tab_email_invio.flg_ritorno_ricev,   
						  :kst_tab_email_invio.email_di_ritorno,
						  :kst_tab_email_invio.x_datins,   
						  :kst_tab_email_invio.x_utente ) 
			using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlCode <> 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Inserimento Invio Email (email_invio) ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

	else
		
//--- Piglia il ID che ha appena associato alla e-mail
		kst_tab_email_invio.id_email_invio = get_id_email_invio_max()
		//kst_tab_email_invio.id_email_invio = long(kguo_sqlca_db_magazzino.SQLReturnData)
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	end if


return k_return
end function

public function st_esito get_email (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail 
//=== 
//=== input: st_tab_email con valorizzato il campo id_email_invio
//=== rit: email
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.email 
    INTO 
         :kst_tab_email_invio.email  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (email) ~n~r" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function boolean tb_update (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = true
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_email_invio.data_ins = date(kst_tab_email_invio.x_datins)   // aggiorna la data di inserimento 

	setnull(kst_tab_email_invio.data_inviato)

	if_isnull(kst_tab_email_invio)

	update email_invio
			set email = :kst_tab_email_invio.email
			    ,  cod_funzione = :kst_tab_email_invio.cod_funzione
				,  note = :kst_tab_email_invio.note
				,  id_oggetto = :kst_tab_email_invio.id_oggetto
				,  id_cliente = :kst_tab_email_invio.id_cliente
				,  data_ins = :kst_tab_email_invio.data_ins
				,  data_inviato = :kst_tab_email_invio.data_inviato
				,  ora_inviato = ''
				,  oggetto = :kst_tab_email_invio.oggetto
				,  link_lettera = :kst_tab_email_invio.link_lettera
				,  flg_lettera_html = :kst_tab_email_invio.flg_lettera_html
				,  flg_allegati = :kst_tab_email_invio.flg_allegati
				,  allegati_cartella = :kst_tab_email_invio.allegati_cartella
				,  flg_ritorno_ricev = :kst_tab_email_invio.flg_ritorno_ricev
				,  email_di_ritorno = :kst_tab_email_invio.email_di_ritorno 
				,  x_datins = :kst_tab_email_invio.x_datins
				,  x_utente = :kst_tab_email_invio.x_utente
			where id_email_invio = :kst_tab_email_invio.id_email_invio
			using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlCode <> 0 then

		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Aggiornamento Invio Email (email_invio) ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if

	else
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

	end if


return k_return
end function

public function boolean invio (st_tab_email_invio kst_tab_email_invio);//--- 
//--- Invio e-mail attraverso SMTP
//---
boolean k_return = false
boolean k_flg_ricevuta = false
String ls_body, ls_server, ls_uid, ls_pwd, k_email
String ls_filename, ls_port
Integer li_idx, li_max, k_pos_ini, k_pos_fin
Boolean lb_html
string k_esito=""
integer li_FileNum
string ls_Emp_Input
long ll_FLength
int k_idx, k_idx_max
datastore kds_dirlist
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base
kuf_file_explorer kuf1_file_explorer
n_smtp gn_smtp
kuf_email kuf1_email
st_email_address kst_email_address
 

SetPointer(HourGlass!)

kuf1_file_explorer = create kuf_file_explorer
kuf1_base = create kuf_base
//gn_smtp = create n_smtp


//of_setreg("SendName", sle_send_name.text)
//of_setreg("SendEmail", sle_send_email.text)
//of_setreg("FromName", sle_from_name.text)
//of_setreg("FromEmail", sle_from_email.text)
//of_setreg("Subject", sle_subject.text)
//of_setreg("Body", mle_body.text)
//
//If cbx_sendhtml.checked Then
//	of_setreg("SendHTML", "Y")
//Else
//	of_setreg("SendHTML", "N")
//End If
//
//ls_server = of_getreg("SmtpServer", "")
//
//If ls_server = "" Then
//	MessageBox("Edit Error", &
//		"You must specify Server on the Settings tab first!")
//	Return
//End If
//
//If sle_send_email.text = "" Then
//	MessageBox("Edit Error", &
//		"To Email is a required field!")
//	Return
//End If
//
//If sle_from_email.text = "" Then
//	MessageBox("Edit Error", &
//		"From Email is a required field!")
//	Return
//End If
//
//If sle_subject.text = "" Then
//	MessageBox("Edit Error", &
//		"Subject is a required field!")
//	Return
//End If
//
//If mle_body.text = "" Then
//	MessageBox("Edit Error", &
//		"Body is a required field!")
//	Return
//End If

if kst_tab_email_invio.flg_lettera_html = ki_lettera_html_si then
//If of_getreg("SendHTML", "N") = "Y" Then
//	ls_body  = "<html><body bgcolor='#F5F5DC' topmargin=8 leftmargin=8><h2>"
//	ls_body += of_replaceall(mle_body.text, "~r~n", "<br>") + "</h2>"
//	If lb_attachments.TotalItems() > 0 Then
//		ls_body += "<img src='cid:attach.1'>"
//	End If
//	ls_body += "</body></html>"
	lb_html = True
Else
//	ls_body = mle_body.text
	lb_html = False
End If


k_esito = kuf1_base.prendi_dato_base( "smtp_logfile")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.smtp_logfile = trim(mid(k_esito,2))
end if
if kst_tab_base.smtp_logfile = "S" then
//If of_getreg("Logfile", "N") = "Y" Then
	gn_smtp.of_SetLogfile(True)
Else
	gn_smtp.of_SetLogfile(False)
End If
gn_smtp.of_DeleteLogfile()


k_esito = kuf1_base.prendi_dato_base( "smtp_autorizz_rich")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.smtp_autorizz_rich = trim(mid(k_esito,2))
end if

// set properties
if kst_tab_base.smtp_autorizz_rich = "S" then
//If of_getreg("SmtpAuth", "N") = "Y" Then
	k_esito = kuf1_base.prendi_dato_base( "smtp_user")
	if left(k_esito,1) <> "0" then
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = mid(k_esito,2)
	else
		kst_tab_base.smtp_user = trim(mid(k_esito,2))
	end if
	k_esito = kuf1_base.prendi_dato_base( "smtp_pwd")
	if left(k_esito,1) <> "0" then
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = mid(k_esito,2)
	else
		kst_tab_base.smtp_pwd = trim(mid(k_esito,2))
	end if

//	ls_uid = of_getreg("SmtpUserid", "")
//	ls_pwd = of_getreg("SmtpPassword", "")
	gn_smtp.of_SetLogin(kst_tab_base.smtp_user, kst_tab_base.smtp_pwd)
End If

k_esito = kuf1_base.prendi_dato_base( "smtp_port")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.smtp_port = trim(mid(k_esito,2))
end if
//gn_smtp.of_SetPort(Integer(of_getreg("SmtpPort", "25")))
gn_smtp.of_SetPort(Integer(kst_tab_base.smtp_port))

k_esito = kuf1_base.prendi_dato_base( "smtp_server")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.smtp_server = trim(mid(k_esito,2))
end if
gn_smtp.of_SetServer(kst_tab_base.smtp_server)

k_esito = kuf1_base.prendi_dato_base( "rag_soc_1")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.rag_soc_1 = trim(mid(k_esito,2))
end if
k_esito = kuf1_base.prendi_dato_base( "rag_soc_2")
if left(k_esito,1) <> "0" then
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.db_ko  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = mid(k_esito,2)
else
	kst_tab_base.rag_soc_2 = trim(mid(k_esito,2))
end if
if isnull(kst_tab_base.rag_soc_1) then kst_tab_base.rag_soc_1 = " "
if isnull(kst_tab_base.rag_soc_2) then kst_tab_base.rag_soc_2 = " "
if trim(kst_tab_email_invio.email_di_ritorno) > " " then
else
	k_esito = kuf1_base.prendi_dato_base( "e_mail")
	if left(k_esito,1) <> "0" then
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = mid(k_esito,2)
		kst_tab_email_invio.email_di_ritorno = "email@email.com"   // nel caso la email non si trovi neanche in Proprietà Azienda
	else
		kst_tab_email_invio.email_di_ritorno = trim(mid(k_esito,2))
	end if
end if
gn_smtp.of_SetFrom(trim(kst_tab_email_invio.email_di_ritorno), kst_tab_base.rag_soc_1 + " " + kst_tab_base.rag_soc_2 )

if kst_tab_email_invio.flg_ritorno_ricev = ki_ricev_ritorno_si then
	gn_smtp.of_SetReceipt(true)
else
	gn_smtp.of_SetReceipt(false)
end if


//--- Imposto l'oggetto e la LETTERA da Inviare!!!!!!!
gn_smtp.of_SetSubject(kst_tab_email_invio.oggetto)

if len(trim(kst_tab_email_invio.link_lettera)) > 0 then
	ll_FLength = FileLength64(kst_tab_email_invio.link_lettera)
	if ll_FLength < 32767 THEN
		li_FileNum = FileOpen(kst_tab_email_invio.link_lettera, TextMode!)
			FileReadEx(li_FileNum, ls_Emp_Input)
		FileClose(li_FileNum)
	else
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Comunicazione " + kst_tab_email_invio.link_lettera + " troppo grande, occupa " + trim(string(ll_FLength)) + " bytes! "
	END IF
	gn_smtp.of_SetBody(ls_Emp_Input, lb_html)
	//gn_smtp.of_SetBody(ls_body, lb_html)
else
//--- se la cartella non esiste
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.no_esecuzione  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "La comunicazione (" + trim(kst_tab_email_invio.allegati_cartella) + ") non esiste, e-mail bloccata! "
end if



gn_smtp.of_Reset()

//--- Aggiungo gli Indirizzi email separati da ',' o ';' se più di uno nel recipient 
//---      e Controllo sintassi Indirizzi email				
try
	kst_email_address.email_all = kst_tab_email_invio.email
	kuf1_email = create kuf_email
	kuf1_email.get_email_from_string(kst_email_address)
	k_idx_max = upperbound(kst_email_address.address[])
	for k_idx = 1 to k_idx_max
		k_email = kst_email_address.address[k_idx]
		if k_email > " " then
			gn_smtp.of_AddTo(k_email, " ")  // potrei mettere IL NOME del destinatario: sle_send_name.text)
		end if
	next
catch (uo_exception kuo1_exception)
	kst_esito = kuo1_exception.get_st_esito()
	kst_esito.esito = kkg_esito.no_esecuzione  
finally
	if isvalid(kuf1_email) then destroy kuf1_email
end try


// add any attachments
if kst_tab_email_invio.flg_allegati = ki_allegati_si then
	
	if len(trim(kst_tab_email_invio.allegati_cartella)) > 0 then	
		if DirectoryExists (trim(kst_tab_email_invio.allegati_cartella)) then
//--- piglia l'elenco dei file xml contenuti nella cartella
			kds_dirlist = kuf1_file_explorer.DirList(kst_tab_email_invio.allegati_cartella+"\*.*")
			li_max = kds_dirlist.rowcount()
			for li_idx = 1 to li_max
	//--- estrae il file da allegare
				ls_filename = trim(kds_dirlist.getitemstring(li_idx, "nome"))
				if right(kst_tab_email_invio.allegati_cartella, 1) = kkg.path_sep then
				else
					kst_tab_email_invio.allegati_cartella += kkg.path_sep
				end if
				gn_smtp.of_AddFile(kst_tab_email_invio.allegati_cartella + ls_filename)
			end for
		else
//--- se la cartella non esiste
			kst_esito.nome_oggetto = this.classname()
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "La cartella Allegati (" + trim(kst_tab_email_invio.allegati_cartella) + ") non esiste, e-mail bloccata! "
		end if
	end if
//li_max = lb_attachments.TotalItems()
//For li_idx = 1 To li_max
//	ls_filename = lb_attachments.Text(li_idx)
//	gn_smtp.of_AddFile(ls_filename)
//Next
end if



// send the message
If gn_smtp.of_SendMail() Then
	k_return = true

//	MessageBox("SendMail", "Mail successfully sent!")
Else
	k_return = false

//	MessageBox("SendMail Error", gn_smtp.is_msgtext)
End If

if isvalid(kds_dirlist) then destroy kds_dirlist
if isvalid(kuf1_base) then destroy kuf1_base
if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer


return k_return

end function

public function boolean set_data_inviato (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna la data/ora dell'invio nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = true
boolean k_autorizza, k_presente
long k_cli
st_tab_base kst_tab_base
kuf_base kuf1_base
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Aggiornamento di Invio E-mail non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	kst_tab_email_invio.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_email_invio.x_utente = kGuf_data_base.prendi_x_utente()
	

	update email_invio
			set 
				data_inviato = :kst_tab_email_invio.data_inviato
				,  ora_inviato = :kst_tab_email_invio.ora_inviato
				,  x_datins = :kst_tab_email_invio.x_datins
				,  x_utente = :kst_tab_email_invio.x_utente
			where id_email_invio = :kst_tab_email_invio.id_email_invio
			using sqlca;

	
	if sqlca.sqlCode < 0 then

		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante Aggiornamento Invio Email (data_inviato) ~n~r" +  trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.no_esecuzione
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if

	else
		
		if kst_tab_email_invio.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email_invio.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if

	end if
end if


return k_return
end function

public function st_esito check_presenza (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail x Controillo Presenza del Record
//=== 
//=== input: st_tab_email con valorizzato il campo id_email_invio
//=== rit: id_email_invio
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.id_email_invio 
    INTO 
         :kst_tab_email_invio.id_email_invio  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (email) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito get_allegati_cartella (ref st_tab_email_invio kst_tab_email_invio);//
//====================================================================
//=== 
//=== Leggo tabella e-mail x prendere "allegati_cartella"
//=== 
//=== input: st_tab_email con valorizzato il campo id_email_invio
//=== rit: allegati_cartella
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_invio.id_email_invio > 0 then

  SELECT 
         email_invio.allegati_cartella 
    INTO 
         :kst_tab_email_invio.allegati_cartella  
    FROM email_invio  
	where email_invio.id_email_invio = :kst_tab_email_invio.id_email_invio
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (allegati_cartella) ~n~r" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if
else
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function integer delete_allegati (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//---
//--- Cancella gli allegati digitale (pdf...)
//--- input:  st_tab_email_invio.allegati_cartella
//--- out: TRUE = cancellata
//--- se ERRORE grave lanca EXCEPTION 
//---
int k_return=0
boolean k_sicurezza = true
long k_max, k_idx
string k_filename
datastore kds_dirlist
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception
kuf_file_explorer kuf1_file_explorer



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.anteprima) 

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Rimozione allegati alla e-mail non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

else

	if len(trim(kst_tab_email_invio.allegati_cartella)) > 0 then
				
		kuf1_file_explorer = create kuf_file_explorer
		kds_dirlist = kuf1_file_explorer.DirList(trim(kst_tab_email_invio.allegati_cartella) + "\*.*")
		k_max = kds_dirlist.rowcount( )
		for k_idx = 1 to k_max
//--- estrae il file da cancellare
			k_filename = trim(kds_dirlist.getitemstring(k_idx, "nome"))
			if fileDelete(trim(kst_tab_email_invio.allegati_cartella) + "\" + k_filename) then
				k_return ++ 
			end if
		end for

//		RemoveDirectory (trim(kst_tab_email_invio.allegati_cartella))
		if isvalid(kds_dirlist) then destroy kds_dirlist
		if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end if		
	
end if
	



return k_return

end function

public function boolean get_id_email_invio_minimo_x_data_ins (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== 
//=== Torna il ID_EMAIL_INVIO iniziale per la data richiesta 
//=== 
//=== input: st_tab_email con valorizzato il campo data_ins
//=== rit: id_email_invio
//=== Out: tab. ST_ESITO
//=== 
//====================================================================
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_invio.data_ins > date(0) then

  SELECT 
         min(email_invio.id_email_invio) 
    INTO 
         :kst_tab_email_invio.id_email_invio  
    FROM email_invio  
	where email_invio.data_ins >= :kst_tab_email_invio.data_ins
	using sqlca;

	if sqlca.sqlcode = 0 then
		if isnull(kst_tab_email_invio.id_email_invio) then kst_tab_email_invio.id_email_invio = 0
		k_return = true
	else
		kst_tab_email_invio.id_email_invio = 0
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. Invio E-mail (email) del ID per data " + string(kst_tab_email_invio.data_ins) + "~n~r" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
end if


return k_return


end function

public function long if_presente_x_id_oggetto (st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID_EMAIL_INVIO più alto per id_oggetto (=id_fattura o id_meca o ...)
//--- 
//--- input: st_tab_email con valorizzato il campo id_oggetto
//--- 
//--- ritorna: id_email_invio
//--- 
//-----------------------------------------------------------------------------------------------------------------------
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_email_invio.id_oggetto > 0 then

  	SELECT 
         max(email_invio.id_email_invio) 
	    INTO 
         :kst_tab_email_invio.id_email_invio  
		FROM email_invio  
		where email_invio.id_oggetto = :kst_tab_email_invio.id_oggetto
		using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_email_invio.id_email_invio > 0 then
			k_return = kst_tab_email_invio.id_email_invio
		else
			kst_tab_email_invio.id_email_invio = 0
		end if
	else
		kst_tab_email_invio.id_email_invio = 0
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura E-mail inviate (email_invio) per id oggetto " + string(kst_tab_email_invio.id_oggetto) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_tab_email_invio.id_email_invio = 0
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id oggetto per la lettura E-mail inviata (email_invio) " 
	kst_esito.esito = kkg_esito.db_ko
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return


end function

public function boolean tb_add_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiunge un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = false
boolean k_autorizza
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_tab_email_invio.id_email_invio = 0

//--- controlla se utente autorizzato alla funzione in atto
k_autorizza = if_sicurezza(kkg_flag_modalita.inserimento) 

if k_autorizza then

	k_return = tb_add(kst_tab_email_invio)

end if

return k_return
end function

public function boolean tb_update_autorizzativo (ref st_tab_email_invio kst_tab_email_invio) throws uo_exception;//
//====================================================================
//=== Aggiorna un rek nella tabella email_invio 
//=== 
//=== Ritorna TRUE=ok
//===   
//====================================================================
boolean k_return = false
boolean k_autorizza
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_autorizza = if_sicurezza(kkg_flag_modalita.inserimento)

if k_autorizza then
	
	k_return = tb_update(kst_tab_email_invio)
	
end if


return k_return
end function

public function long get_id_email_invio_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID inserito 
//--- 
//---  input: 
//---  ret: max id_email_invio
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id_email_invio)
		 INTO 
				:k_return
		 FROM email_invio  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Email in tabella (EMAIL_INVIO)" &
									 + "~n~r"  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(k_return) then k_return = 0
	else
		k_return = 0
	end if
	

return k_return

end function

on kuf_email_invio.create
call super::create
end on

on kuf_email_invio.destroy
call super::destroy
end on

