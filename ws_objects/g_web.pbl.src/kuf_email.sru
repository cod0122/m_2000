$PBExportHeader$kuf_email.sru
forward
global type kuf_email from kuf_parent
end type
end forward

global type kuf_email from kuf_parent
end type
global kuf_email kuf_email

type variables

//--- path dove risiedono le comunicazioni
 string kki_path_email = kkg.path_sep + "email"

//--- stato
 string ki_stato_attivo = "A"
 string ki_stato_sospeso = "S"

//--- in HTML
 string ki_lettera_html_si = "S"
 string ki_lettera_html_no = "N"

//--- Ricevuta di ritorno
 string ki_ricev_ritorno_si = "S"
 string ki_ricev_ritorno_no = "N"



end variables

forward prototypes
public function st_esito tb_delete (st_tab_email kst_tab_email)
public function st_esito get_riga (ref st_tab_email kst_tab_email)
public subroutine if_isnull (st_tab_email kst_tab_email)
public function st_esito anteprima (datastore kdw_anteprima, st_tab_email kst_tab_email)
public function st_esito get_oggetto (ref st_tab_email kst_tab_email)
public function st_esito get_link_lettera (ref st_tab_email kst_tab_email)
public function boolean if_presente (st_tab_email kst_tab_email) throws uo_exception
public function st_esito get_email_from_string (ref st_email_address ast_email_address)
public function boolean if_sintassi_email_ok (string kst_email)
end prototypes

public function st_esito tb_delete (st_tab_email kst_tab_email);//
//====================================================================
//=== Cancella il rek dalla tabella EMAIL 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

boolean k_autorizza, k_presente
long k_cli
st_tab_email_funzioni kst_tab_email_funzioni
kuf_email_funzioni kuf1_email_funzioni
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



try
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)
	if k_autorizza then
	
		kuf1_email_funzioni = create kuf_email_funzioni
		
		kst_tab_email_funzioni.id_email = kst_tab_email.id_email 	
		k_presente = kuf1_email_funzioni.if_presente(kst_tab_email_funzioni)
		
		destroy kuf1_email_funzioni
	
		if k_presente then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Email già presente tra le Proprietà della Procedura  ~n~r" 
			kst_esito.esito = kkg_esito.no_esecuzione
		end if

		if not k_presente then
			
			delete from email
					where id_email = :kst_tab_email.id_email 
					using kguo_sqlca_db_magazzino;
		
			if kguo_sqlca_db_magazzino.sqlCode <> 0 then
		
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante cancellazione Email ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.no_esecuzione
				
				if kst_tab_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
	
			else
				
				if kst_tab_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_email.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
		
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
finally
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
		
end try

return kst_esito
end function

public function st_esito get_riga (ref st_tab_email kst_tab_email);//
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


if kst_tab_email.id_email > 0 then

  SELECT email.codice,   
         email.stato,   
         email.des,   
         email.oggetto,   
         email.link_lettera,   
         email.flg_lettera_html,   
         email.flg_ritorno_ricev,  
         email.email_di_ritorno  
    INTO :kst_tab_email.codice,   
         :kst_tab_email.stato,   
         :kst_tab_email.des,   
         :kst_tab_email.oggetto,   
         :kst_tab_email.link_lettera,   
         :kst_tab_email.flg_lettera_html,   
         :kst_tab_email.flg_ritorno_ricev , 
		:kst_tab_email.email_di_ritorno  

    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail  ~n~r" + trim(sqlca.SQLErrText)
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

public subroutine if_isnull (st_tab_email kst_tab_email);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_email.id_email) then kst_tab_email.id_email = 0
if isnull(kst_tab_email.stato) then kst_tab_email.stato = ""
if isnull(kst_tab_email.codice) then kst_tab_email.codice = ""
if isnull(kst_tab_email.des) then kst_tab_email.des = ""
if isnull(kst_tab_email.oggetto) then kst_tab_email.oggetto = ""
if isnull(kst_tab_email.link_lettera) then kst_tab_email.link_lettera = ""
if isnull(kst_tab_email.flg_lettera_html) then kst_tab_email.flg_lettera_html = ""
if isnull(kst_tab_email.flg_ritorno_ricev) then kst_tab_email.flg_ritorno_ricev = ""
if isnull(kst_tab_email.flg_lettera_html) then kst_tab_email.flg_lettera_html = ""
if isnull(kst_tab_email.email_di_ritorno) then kst_tab_email.email_di_ritorno = ""

end subroutine

public function st_esito anteprima (datastore kdw_anteprima, st_tab_email kst_tab_email);//
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
		if kdw_anteprima.dataobject = "d_email"  then
			if kdw_anteprima.object.id_email[1] = kst_tab_email.id_email  then
				kst_tab_email.id_email = 0
			end if
		end if
	end if

	if kst_tab_email.id_email > 0 then
	
			kdw_anteprima.dataobject = "d_email"		
			kdw_anteprima.settransobject(sqlca)
	
//			kuf1_utility = create kuf_utility
//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
//			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_email.id_email)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna configurazione E-mail da visualizzare: ~n~r" + "nessun Codice indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito get_oggetto (ref st_tab_email kst_tab_email);//
//====================================================================
//=== 
//=== Leggo tabella e-mail per prendere il campo OGGETTO
//=== 
//=== input: st_tab_email con valorizzato il campo id_email
//=== out: oggetto
//=== Ritorna tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email.id_email > 0 then

  SELECT
         email.oggetto 
    INTO 
         :kst_tab_email.oggetto 
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail (oggetto) ~n~r" + trim(sqlca.SQLErrText)
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

public function st_esito get_link_lettera (ref st_tab_email kst_tab_email);//
//====================================================================
//=== 
//=== Leggo tabella e-mail per prendere il campo link_lettera
//=== 
//=== input: st_tab_email con valorizzato il campo id_email
//=== out: link_lettera
//=== Ritorna tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email.id_email > 0 then

  SELECT
         email.link_lettera 
    INTO 
         :kst_tab_email.link_lettera 
    FROM email  
	where email.id_email = :kst_tab_email.id_email
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail (link_lettera) ~n~r" + trim(sqlca.SQLErrText)
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

public function boolean if_presente (st_tab_email kst_tab_email) throws uo_exception;//
//====================================================================
//=== 
//=== Presenza della riga e-mail per ID
//=== 
//=== input: st_tab_email con valorizzato il campo id_email
//=== out: 
//=== Ritorna: TRUE = presente
//=== 
//====================================================================
//
boolean k_return = false
string k_trovato = ""
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email.id_email > 0 then
	k_trovato = ""
	SELECT distinct "1"
	    INTO 
         :k_trovato
   	 	FROM email  
		where email.id_email = :kst_tab_email.id_email
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail (presenza) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id x lettura E-mail (presenza) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if k_trovato = "1" then k_return = true   // TROVATO!!!

return k_return

end function

public function st_esito get_email_from_string (ref st_email_address ast_email_address);//
string k_email
int k_pos_ini, k_pos_fin, k_len, k_email_idx, k_pos_fin_puntovirgola
int k_email_n_max
//string k_sep_char[2] = {",", ";"}
st_esito kst_esito
st_email_address kst_email_address


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_email_address.email_all = trim(ast_email_address.email_all)

//--- estrae gli Indirizzi email separati da ',' o ';' 

	k_pos_ini = 1
	k_pos_fin = pos(kst_email_address.email_all, ",")
	k_pos_fin_puntovirgola = pos(kst_email_address.email_all, ";")
	if k_pos_fin = 0 or (k_pos_fin_puntovirgola > 0 and k_pos_fin_puntovirgola < k_pos_fin) then
		k_pos_fin = k_pos_fin_puntovirgola
	end if
	do while k_pos_fin > 0
		k_len = k_pos_fin - k_pos_ini  
		k_email = trim(mid(kst_email_address.email_all, k_pos_ini, k_len))
		if k_email > " " then
			k_email_idx ++
			kst_email_address.address[k_email_idx] = k_email
		end if
		k_pos_ini = k_pos_fin + 1
		k_pos_fin = pos(kst_email_address.email_all, ",", k_pos_ini)
		k_pos_fin_puntovirgola = pos(kst_email_address.email_all, ";", k_pos_ini)
		if k_pos_fin = 0 or (k_pos_fin_puntovirgola > 0 and k_pos_fin_puntovirgola < k_pos_fin) then
			k_pos_fin = k_pos_fin_puntovirgola
		end if
	loop
	
//--- accoda l'ultima email se non ha il separatore
	k_pos_fin = len(kst_email_address.email_all)
	if k_pos_fin > k_pos_ini then
		k_len = k_pos_fin - k_pos_ini  + 1
		k_email = trim(mid(kst_email_address.email_all, k_pos_ini, k_len))
		if k_email > " " then
			k_email_idx ++
			kst_email_address.address[k_email_idx] = k_email
		end if
	end if

	k_email_n_max = UpperBound(kst_email_address.address)
	for k_email_idx = 1 to k_email_n_max
		
		if not if_sintassi_email_ok(kst_email_address.address[k_email_idx]) then
				  
			kst_esito.esito = kkg_esito.ko
			if kst_esito.sqlerrtext = "" then
				kst_esito.sqlerrtext = "Indirizzi errati: " + kst_email_address.address[k_email_idx] 
			else
				kst_esito.sqlerrtext += ", " + kst_email_address.address[k_email_idx] 
			end if
			//+ " (n." + string(k_email_idx) + ") "
				  
		end if
	next
	
ast_email_address.address[] = kst_email_address.address[]


return kst_esito



end function

public function boolean if_sintassi_email_ok (string kst_email);//---
//--- Controllo sintassi E-MAIL
//---
//--- Input: st_web.email valorizzato
//--- Out: TRUE=ok, False=indirizzo errato

kst_email = trim(kst_email)

return match(kst_email, "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$")
//								"[a-zA-z0-9]+[-.]*[a-zA-z0-9]*[@][a-zA-z0-9]+[-.][a-zA-z0-9]+[a-zA-z0-9]$")
//                      '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z][a-zA-Z][a-zA-Z]*[a-zA-Z]*$'
//    						"[a-zA-Z0-9_\.]+@[a-zA-Z0-9-]+\.[a-zA-Z]{0,4}"

end function

on kuf_email.create
call super::create
end on

on kuf_email.destroy
call super::destroy
end on

