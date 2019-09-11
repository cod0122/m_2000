$PBExportHeader$kuf_email_funzioni.sru
forward
global type kuf_email_funzioni from kuf_parent
end type
end forward

global type kuf_email_funzioni from kuf_parent
end type
global kuf_email_funzioni kuf_email_funzioni

type variables
//---
//--- codici funzione ATTIVI da mettere anche nella tabella "email_funzioni_cod" per associare una descrizione
public constant string kki_cod_funzione_fatturaNOallegati = "FTAV"   // fattura solo con avviso
public constant string kki_cod_funzione_fatturaSIallegati = "FTAL"    // fattura con allagato
public constant string kki_cod_funzione_prontoMerce = "MTPR"   // pronto merce - lotti pronti x il ricevente
public constant string kki_cod_funzione_Attestati = "CRTF"   // attestati stampa pdf da E1 e M2000

end variables

forward prototypes
public subroutine tb_delete (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception
public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_funzioni kst_tab_email_funzioni)
public function long get_id_email (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception
public function string get_sr_settore (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception
public subroutine if_isnull (st_tab_email_funzioni kst_tab_email_funzioni)
public function string get_cod_funzione (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception
public function boolean if_presente (st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception
public function long get_id_email_xcodfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception
public function long get_id_email_funzione_xcodfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception
public function long get_id_email_xidemailfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception
public function long get_id_email_funzione_xidemail (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception
public function string get_des (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception
end prototypes

public subroutine tb_delete (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella EMAIL funzioni 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

boolean k_autorizza
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try 
//--- controlla se utente autorizzato alla funzione in atto
	k_autorizza = if_sicurezza(kkg_flag_modalita.cancellazione)
	
	if k_autorizza then
	
		delete from email_funzioni
				where id_email_funzione = :ast_tab_email_funzioni.id_email_funzione 
				using kguo_sqlca_db_magazzino;
			
		if kguo_sqlca_db_magazzino.sqlCode <> 0 then
	
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante cancellazione Email funzione " + string(ast_tab_email_funzioni.id_email_funzione) + " ~n~r" +  trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.no_esecuzione
			
			if ast_tab_email_funzioni.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_email_funzioni.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception

		
		else
			
			if ast_tab_email_funzioni.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_email_funzioni.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
	
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception
		
end try


end subroutine

public function st_esito anteprima (datastore kdw_anteprima, st_tab_email_funzioni kst_tab_email_funzioni);//
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
st_esito kst_esito
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
//--- controlla se utente autorizzato alla funzione in atto
	k_return = if_sicurezza(kkg_flag_modalita.anteprima)
	

	if k_return then
	
		if isvalid(kdw_anteprima)  then
			if kdw_anteprima.dataobject = "d_email_funzione"  then
				if kdw_anteprima.object.id_email_funzione[1] = kst_tab_email_funzioni.id_email_funzione  then
					kst_tab_email_funzioni.id_email_funzione = 0
				end if
			end if
		end if
	
		if kst_tab_email_funzioni.id_email_funzione > 0 then
		
				kdw_anteprima.dataobject = "d_email_funzione"		
				kdw_anteprima.settransobject(sqlca)
		
	//			kuf1_utility = create kuf_utility
	//			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
	//			destroy kuf1_utility
		
				kdw_anteprima.reset()	
		//--- retrive dell'attestato 
				k_rc=kdw_anteprima.retrieve(kst_tab_email_funzioni.id_email_funzione)
		
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Nessuna configurazione E-mail delle Funzioni da visualizzare: ~n~r" + "nessun Codice indicato"
				kst_esito.esito = kkg_esito.blok
				
			end if
	end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
		
end try

return kst_esito

end function

public function long get_id_email (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo id_email
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email_funzione
//=== out: id_email
//=== Ritorna long id_email
//=== 
//====================================================================
//
long k_return = 0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_funzioni.id_email_funzione > 0 then

  SELECT
         email_funzioni.id_email 
    INTO 
         :kst_tab_email_funzioni.id_email 
    FROM email_funzioni  
	where email_funzioni.id_email = :kst_tab_email_funzioni.id_email_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail funzione (id_email) " + string(kst_tab_email_funzioni.id_email_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id x lettura E-mail funzione (id_email) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if kst_tab_email_funzioni.id_email > 0 then k_return = kst_tab_email_funzioni.id_email 

return k_return 

end function

public function string get_sr_settore (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo sr_settore
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email_funzione
//=== out: sr_settore
//=== Ritorna  sr_settore
//=== 
//====================================================================
//
string k_return = ""
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_funzioni.id_email_funzione > 0 then

  SELECT
         email_funzioni.sr_settore 
    INTO 
         :kst_tab_email_funzioni.sr_settore 
    FROM email_funzioni  
	where email_funzioni.id_email = :kst_tab_email_funzioni.id_email_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail funzione (settore) " + string(kst_tab_email_funzioni.id_email_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id x lettura E-mail funzione (settore) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if kst_tab_email_funzioni.sr_settore > " " then k_return = kst_tab_email_funzioni.sr_settore 

return k_return 

end function

public subroutine if_isnull (st_tab_email_funzioni kst_tab_email_funzioni);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_email_funzioni.id_email_funzione) then kst_tab_email_funzioni.id_email_funzione = 0
if isnull(kst_tab_email_funzioni.id_email) then kst_tab_email_funzioni.id_email = 0
if isnull(kst_tab_email_funzioni.sr_settore) then kst_tab_email_funzioni.sr_settore = ""
if isnull(kst_tab_email_funzioni.cod_funzione) then kst_tab_email_funzioni.cod_funzione = ""

end subroutine

public function string get_cod_funzione (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo cod_funzione
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email
//=== out: cod_funzione
//=== Ritorna  cod_funzione
//=== 
//====================================================================
//
string k_return = ""
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_funzioni.id_email > 0 then

  SELECT
         email_funzioni.cod_funzione 
    INTO 
         :kst_tab_email_funzioni.cod_funzione 
    FROM email_funzioni  
	where email_funzioni.id_email = :kst_tab_email_funzioni.id_email
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura Associazione Prototipi E-mail x codice funzione, id_email " + string(kst_tab_email_funzioni.id_email) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id email del Prototipo x lettura Assciazioni Prototipi E-mail x codice funzione ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if kst_tab_email_funzioni.cod_funzione > " " then k_return = kst_tab_email_funzioni.cod_funzione 

return k_return 

end function

public function boolean if_presente (st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Presenza della riga di Prototipo e-mail per ID_EMAIL
//=== 
//=== input: st_tab_email_funzioni_funzioni con valorizzato il campo id_email
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


if kst_tab_email_funzioni.id_email > 0 then
	k_trovato = ""
	SELECT distinct "1"
	    INTO 
         :k_trovato
   	 	FROM email_funzioni  
		where email_funzioni.id_email = :kst_tab_email_funzioni.id_email
		using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. prototipi E-mail (presenza) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id x lettura Prototipi E-mail (presenza) ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if k_trovato = "1" then k_return = true   // TROVATO!!!

return k_return

end function

public function long get_id_email_xcodfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo id_email
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo cod_funzione
//=== out: 
//=== Ritorna long id_email
//=== 
//====================================================================
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

ast_tab_email_funzioni.id_email = 0

if trim(ast_tab_email_funzioni.cod_funzione) > " " then

  SELECT
         email_funzioni.id_email 
    INTO 
         :ast_tab_email_funzioni.id_email 
    FROM email_funzioni  
	where email_funzioni.cod_funzione = :ast_tab_email_funzioni.cod_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura tab. E-mail funzioni, del id_email x cod. funzione: " + trim(ast_tab_email_funzioni.cod_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca cod. funzione x lettura E-mail funzioni del id_email ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if ast_tab_email_funzioni.id_email > 0 then k_return = ast_tab_email_funzioni.id_email 

return k_return 

end function

public function long get_id_email_funzione_xcodfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo id_email_funzione
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo cod_funzione
//=== out: 
//=== Ritorna long id_email_funzione
//=== 
//====================================================================
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if trim(ast_tab_email_funzioni.cod_funzione) > " " then

  SELECT
         email_funzioni.id_email_funzione 
    INTO 
         :ast_tab_email_funzioni.id_email_funzione 
    FROM email_funzioni  
	where email_funzioni.cod_funzione = :ast_tab_email_funzioni.cod_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura id E-mail funzioni, da codice funzione: " + trim(ast_tab_email_funzioni.cod_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca cod. funzione x lettura E-mail id funzione-email ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if ast_tab_email_funzioni.id_email_funzione > 0 then k_return = ast_tab_email_funzioni.id_email_funzione 

return k_return 

end function

public function long get_id_email_xidemailfunzione (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo id_email
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email_funzione
//=== out: 
//=== Ritorna long id_email_funzione
//=== 
//====================================================================
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_email_funzioni.id_email_funzione > 0 then

  SELECT
         email_funzioni.id_email
    INTO 
         :ast_tab_email_funzioni.id_email
    FROM email_funzioni  
	where email_funzioni.id_email_funzione = :ast_tab_email_funzioni.id_email_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura id E-mail, da id funzione: " + trim(ast_tab_email_funzioni.cod_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id mail funzione x lettura id E-mail ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if ast_tab_email_funzioni.id_email > 0 then k_return = ast_tab_email_funzioni.id_email 

return k_return 

end function

public function long get_id_email_funzione_xidemail (st_tab_email_funzioni ast_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail funzioni per prendere il campo id_email_funzione
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email
//=== out: 
//=== Ritorna long id_email_funzione
//=== 
//====================================================================
//
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_email_funzioni.id_email > 0 then

  SELECT
         email_funzioni.id_email_funzione 
    INTO 
         :ast_tab_email_funzioni.id_email_funzione 
    FROM email_funzioni  
	where email_funzioni.id_email = :ast_tab_email_funzioni.id_email
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura id E-mail funzioni, da id email: " + trim(ast_tab_email_funzioni.cod_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca id x lettura E-mail id funzione-email ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if ast_tab_email_funzioni.id_email_funzione > 0 then k_return = ast_tab_email_funzioni.id_email_funzione 

return k_return 

end function

public function string get_des (ref st_tab_email_funzioni kst_tab_email_funzioni) throws uo_exception;//
//====================================================================
//=== 
//=== Leggo tabella e-mail codici funzioni per avere la descrizione
//=== 
//=== input: st_tab_email_funzioni con valorizzato il campo id_email
//=== out: cod_funzione
//=== Ritorna  cod_funzione
//=== 
//====================================================================
//
string k_return = ""
string k_email_funzioni_cod_des
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_email_funzioni.cod_funzione > " " then

  SELECT
         email_funzioni_cod.des 
    INTO 
         :k_email_funzioni_cod_des
    FROM email_funzioni_cod  
	where email_funzioni_cod.cod_funzione = :kst_tab_email_funzioni.cod_funzione
	using kguo_sqlca_db_magazzino;

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Fallita lettura Descrizione Codice Funzione E-mail, codice " + string(kst_tab_email_funzioni.cod_funzione) + " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
else
	kst_esito.SQLErrText = "Manca codice funzione E-mail x leggere la descrizione"
	kst_esito.esito = kkg_esito.no_esecuzione
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if k_email_funzioni_cod_des > " " then k_return = trim(k_email_funzioni_cod_des)

return k_return 

end function

on kuf_email_funzioni.create
call super::create
end on

on kuf_email_funzioni.destroy
call super::destroy
end on

