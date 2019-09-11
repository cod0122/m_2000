$PBExportHeader$kuf_certif_email.sru
forward
global type kuf_certif_email from kuf_parent
end type
end forward

global type kuf_certif_email from kuf_parent
end type
global kuf_certif_email kuf_certif_email

type variables
//
constant string kki_folder_pdf_e1 = "prepared"

end variables

forward prototypes
public function long u_add_email_invio () throws uo_exception
public function date tb_pulizia () throws uo_exception
private function long u_add_email_invio_1 (st_tab_certif_email ast_tab_certif_email) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function integer tb_add (ref string k_status) throws uo_exception
public function boolean set_certif_e1_e1doco (st_tab_certif_email kst_tab_certif_email) throws uo_exception
end prototypes

public function long u_add_email_invio () throws uo_exception;//
//====================================================================
//=== Legge Avvisi Certificati Email (E1+M2000) e li carica in tab Email-Invio 
//=== 
//=== Inp: 
//=== Ritorna: nr di email caricate 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return 
long k_riga, k_righe, k_righe_daelab, k_riga1000, k_riga_ds, k_rc, k_riga_tab
datetime k_datetime
st_tab_certif_email kst_tab_certif_email[], kst_tab_certif_email_vuoto[]
st_tab_meca kst_tab_meca
st_esito kst_esito
datastore kds_1


//setpointer()

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	
	kds_1 = create datastore
	kds_1.dataobject = "ds_certif_email_noemail"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve() // estrazione avvisi senza ancora il id_email_invio
	
	kst_tab_meca.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_meca.x_datins = kGuf_data_base.prendi_x_datins()
	
	for k_riga = 1 to k_righe
		
//--- Aggiorna non più di 1000 righe alla volta...		
		if (k_righe - k_riga) < 1000 then
			k_righe_daelab = k_righe - k_riga
		else
			k_righe_daelab = 1000 - 1
		end if
		k_riga1000 = k_riga + k_righe_daelab 
		
		k_riga_tab = 0
		kst_tab_certif_email[] = kst_tab_certif_email_vuoto[]
		
		for k_riga_ds = k_riga to k_riga1000
			
			k_riga_tab ++
//--- Prepara l'array per popolare la tabella email
			kst_tab_certif_email[k_riga_tab].id_certif = kds_1.getitemnumber( k_riga_ds, "id_certif")
			kst_tab_certif_email[k_riga_tab].id_meca = kds_1.getitemnumber( k_riga_ds, "id_meca")
			kst_tab_certif_email[k_riga_tab].certif_e1_e1doco = kds_1.getitemnumber( k_riga_ds, "certif_e1_e1doco")
			
			kst_tab_meca.id =  kst_tab_certif_email[k_riga_tab].id_meca
			kst_tab_certif_email[k_riga_tab].st_tab_g_0.esegui_commit = "N"
			kst_tab_certif_email[k_riga_tab].id_email_invio = u_add_email_invio_1(kst_tab_certif_email[k_riga_tab]) // ADD EMAIL
			if kst_tab_certif_email[k_riga_tab].id_email_invio > 0 then
//--- Imposta id email invio in tabella Certif email
				kds_1.setitem(k_riga_ds, "id_email_invio", kst_tab_certif_email[k_riga_tab].id_email_invio)
				kds_1.setitem(k_riga_ds, "x_datins", kst_tab_meca.x_datins)
				kds_1.setitem(k_riga_ds, "x_utente", kst_tab_meca.x_utente)
			else
				kds_1.setitem(k_riga_ds, "id_email_invio", 0)
			end if

		next
		
		k_rc = kds_1.update( )  // AGGIORNA ID_EMAIL_INVIO!!
		if k_rc > 0 then
			kguo_sqlca_db_magazzino.db_commit( )
		else
			kguo_sqlca_db_magazzino.db_rollback( )
			kst_esito.sqlcode = k_return
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Errore in carico Attestati in tabella Email da Inviare. Id Attestato: " + string(kds_1.getitemnumber(k_riga, "id_certif")) &
			                       + "~r~nErrore: " + trim(kst_esito.nome_oggetto) + ") "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_riga = k_riga_ds - 1
	next
	
//--- Rimuove le righe vecchie dalla tabella Avvisi Certificati Email
	tb_pulizia( )
	
	
catch (uo_exception kuo_exception) 
	kguo_sqlca_db_magazzino.db_rollback( )
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1

end try

		
return k_return
end function

public function date tb_pulizia () throws uo_exception;//
//====================================================================
//=== Rimuove i rek non più utili in 'CERTIF_EMAIL' (pilota email)
//=== 
//=== Inp: 
//=== Ritorna: data di rimozione
//=== Lancia EXCEPTION
//===  
//====================================================================
//
date k_return  
st_tab_certif_email kst_tab_certif_email
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.inserimento)


//--- Fissa la data datta quale fare la pulizia della tabella
	kst_tab_certif_email.dtins = datetime(relativedate(date(kGuf_data_base.prendi_x_datins()), -180), time(0))
	
	DELETE FROM certif_email  
			where certif_email.dtins < :kst_tab_certif_email.dtins
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione dati di avviso 'Attestati via Email' caricati dal " + string(kst_tab_certif_email.dtins) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = date(kst_tab_certif_email.dtins)

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_sqlca_db_magazzino.db_rollback( )
	else
		kguo_sqlca_db_magazzino.db_commit( )
	end if


return k_return

end function

private function long u_add_email_invio_1 (st_tab_certif_email ast_tab_certif_email) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_certif_email valorizzata con i campi necessari
//--- Out: il ID del email_invio
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
kuf_email_invio kuf1_email_invio
kuf_email_funzioni kuf1_email_funzioni
kuf_email kuf1_email
kuf_clienti kuf1_clienti 
kuf_armo kuf1_armo
kuf_certif kuf1_certif
st_tab_clienti kst_tab_clienti
st_tab_email_invio kst_tab_email_invio
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni
st_tab_meca kst_tab_meca
st_tab_certif kst_tab_certif
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_armo = create kuf_armo

	if ast_tab_certif_email.id_certif > 0 then 
	else
		kguo_exception.inizializza( )
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext =  "Manca id del Certificato. Generazione email non eseguita."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	kst_tab_meca.id = ast_tab_certif_email.id_meca
	
//--- get dei codici clienti + num_int ecc...
	kuf1_armo.get_dati_rid(kst_tab_meca)

//--- get dell'indirizzo e-mail del cliente
	kst_tab_clienti.codice = kst_tab_meca.clie_3
	kuf1_clienti = create kuf_clienti
	kst_tab_email_invio.email = kuf1_clienti.get_email_attestato(kst_tab_clienti) // get indirizzi email x invio Attestati
//--- se e-mail NON impostata sul cliente NON invio nulla!!!
	if trim(kst_tab_email_invio.email) > " " then
	else
		kguo_exception.inizializza( )
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext =  "Manca indirizzo email per il cliente " + string(kst_tab_clienti.codice) + ". Generazione email per invio del Certificato non eseguita."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	kuf1_email_invio = create kuf_email_invio
	kuf1_email = create kuf_email
	kuf1_email_funzioni = create kuf_email_funzioni
	kuf1_certif = create kuf_certif
	
	kst_tab_email_invio.id_cliente =  kst_tab_meca.clie_3
	kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_si
	kst_tab_certif.id_meca = ast_tab_certif_email.id_meca
	kst_tab_email_invio.allegati_cartella =  kuf1_certif.get_path_email(kst_tab_certif)			
	kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_attestati  // INFO che sono i CERTIFICATI

//--- se la cartella non esiste non genera la email
	if DirectoryExists(kst_tab_email_invio.allegati_cartella) then
	else
		kguo_exception.inizializza( )
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Attestati: errore durante preparazione e-mail da inviare; cartella allegati Attestati non trovata: " &
									+ "'" + kst_tab_email_invio.allegati_cartella + "'. Verificare il log degli errori per ulteriori informazioni."
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get del Prototipo della e-mail
	kst_tab_email_funzioni.cod_funzione = kst_tab_email_invio.cod_funzione
	kst_tab_email.id_email = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
	if kst_tab_email.id_email = 0 then
		kguo_exception.inizializza( )
		kst_esito.esito = kkg_esito.ko
		kst_esito.sqlerrtext = "Indicare il Prototipo E-mail da utilizzare per l'invio dei Certificati, codificato come '" &
					+ trim(kst_tab_email_funzioni.cod_funzione) &
					+ "' (" + kuf1_email_funzioni.get_des(kst_tab_email_funzioni) + ")"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- recupero diversi dati x riempire la tab email-invio			
	kuf1_email.get_riga(kst_tab_email)
	kst_tab_email_invio.oggetto = kst_tab_email.oggetto
	kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
	kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
	kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
	kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
	kst_tab_email_invio.id_oggetto = ast_tab_certif_email.id_certif //kst_tab_meca.id
	kuf1_email_invio.if_isnull(kst_tab_email_invio)

//--- get del DDT mandante		
	kuf1_armo.get_num_bolla_in(kst_tab_meca)
	
//--- Composizione dell'OGGETTO: somma alla dicitura del Prototipo il ddt del mandante a anche il Nome quando cliente diverso da mandante
	if kst_tab_meca.num_bolla_in > " " then
		kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " related to delivery Notes # " + trim(kst_tab_meca.num_bolla_in)
		if kst_tab_meca.data_bolla_in > date(0) then
			kst_tab_email_invio.oggetto += " of " + string(kst_tab_meca.data_bolla_in, "dd mmm yyyy")
		end if
	end if
//		if kst_tab_meca.num_int > 0 then
//			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " rif. interno " + string(kst_tab_meca.num_int)
//		end if
	if kst_tab_email_invio.id_cliente <> kst_tab_meca.clie_1 then // se cliente mandante diverso aggiungo il nome
		kst_tab_clienti.codice = kst_tab_meca.clie_1
		kuf1_clienti.get_nome(kst_tab_clienti)
		kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + ". Customer '" + trim(kst_tab_clienti.rag_soc_10) + "'"
	end if

	kst_tab_certif.id = ast_tab_certif_email.id_certif
	kuf1_certif.get_num_certif(kst_tab_certif)
	kst_tab_email_invio.note = "Attestato n. " + string(kst_tab_certif.num_certif) + ", WO " + string(ast_tab_certif_email.certif_e1_e1doco) + ", Lotto " + string(kst_tab_meca.num_int) + "  " +  string(kst_tab_meca.data_int) + "   id " + string(kst_tab_meca.id) + " "  
	
//--- Controllo la presenza in elenco della EMAIL
	kst_tab_email_invio.id_email_invio = kuf1_email_invio.if_presente_x_id_oggetto(kst_tab_email_invio)

//--- CARICO dati nella tabella EMAIL_INVIO	
	k_return = 0
	kst_tab_email_invio.st_tab_g_0.esegui_commit = kst_tab_meca.st_tab_g_0.esegui_commit
	if kst_tab_email_invio.id_email_invio > 0 then
		if kuf1_email_invio.tb_update(kst_tab_email_invio)  then 
			
			k_return = kst_tab_email_invio.id_email_invio
		end if
	else
		if kuf1_email_invio.tb_add(kst_tab_email_invio)  then   
		
			k_return = kst_tab_email_invio.id_email_invio
		end if
	end if		
	if k_return = 0 then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Email Attestati: errore durante preparazione email per l'invio dei Certificati!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	
catch (uo_exception kuo_exception)	
	kst_esito = kuo_exception.get_st_esito()
	if kst_esito.esito = kkg_esito.no_esecuzione then
		k_return = 0
	else
		throw kuo_exception
	end if
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_certif) then destroy kuf1_certif
	if isvalid(kuf1_email_invio) then destroy kuf1_email_invio
	if isvalid(kuf1_email) then destroy kuf1_email
	if isvalid(kuf1_email_funzioni) then destroy kuf1_email_funzioni
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try



return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr_add, k_ctr
string k_status
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Stored Procedure MSSQL UPDATE per carico tabella CERTIF_EMAIL
	k_ctr_add = tb_add(k_status)

//--- Carica Attestati in tab Email da Inviare
	k_ctr = u_add_email_invio( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Caricate in archivio " + string(k_ctr) + " email per l'invio dei 'Certificati'. " 
	else
		kst_esito.SQLErrText = "Nessuna nuova email Certificati aggiunta in archivio."
	end if
	if k_ctr_add > 0 then
		kst_esito.SQLErrText += "Preparati " + string(k_ctr_add) + " Lotti in attesa della stampa del Certificato. " 
	else
		kst_esito.SQLErrText += "Nessun Certificato in preparazione."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function integer tb_add (ref string k_status) throws uo_exception;//
//--- Esecuzione della Stored Procedure MSSQL UPDATE per carico tabella CERTIF_EMAIL
//--- Chiama la sp 
//--- Out: status di come è andata
//--- Rit: 0=nulla, >0 numero righe aggiornate
//
int k_return
int k_rc


try
	k_status = ""

	DECLARE u_m2000_sp PROCEDURE FOR
			@li_rc = dbo.u_m2000_popola_certif_email
									@k_status varchar(240) = :k_status OUT
		using kguo_sqlca_db_magazzino ;
			
	execute u_m2000_sp;
	
	IF kguo_sqlca_db_magazzino.SQLCode < 0 THEN
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.SQLCode
		kguo_exception.kist_esito.sqlerrtext = "Errore in esecuzione SP 'u_m2000_popola_certif_email': " + trim(kguo_sqlca_db_magazzino.SQLerrtext)
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.scrivi_log( )
		throw kguo_exception
	ELSE
			// Put the return value into the var and close the declaration.
		FETCH u_m2000_sp INTO :k_rc, :k_status;
		IF kguo_sqlca_db_magazzino.SQLCode = 0 THEN
			k_return = k_rc
		else
			k_return = 0
		end if
		CLOSE u_m2000_sp;
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.esito = kkg_esito.ok
		kguo_exception.kist_esito.sqlcode = 0
		kguo_exception.kist_esito.sqlerrtext = "Eseguito SP 'u_m2000_popola_certif_email', esito: " + trim(k_status)
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.scrivi_log( )
	END IF


catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return
end function

public function boolean set_certif_e1_e1doco (st_tab_certif_email kst_tab_certif_email) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Set del WO del Certificato E1
//--- 
//--- 
//--- Inp: st_tab_certif_email.id_certif 
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_certif_email.id_certif > 0 then

	kst_tab_certif_email.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_certif_email.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE certif_email  
		  SET certif_e1_e1doco = :kst_tab_certif_email.certif_e1_e1doco
			,x_datins = :kst_tab_certif_email.x_datins
			,x_utente = :kst_tab_certif_email.x_utente
		WHERE certif_email.id_certif = :kst_tab_certif_email.id_certif
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in aggiornamento del WO del Certificato E1 in archivio Email Certificati. ~n~r" &
					+ "Id Certificato: " + string(kst_tab_certif_email.id_certif, "#") + "  " &
					+ " ~n~rErrore: "	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_certif_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kst_tab_certif_email.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif_email.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. email Certificati, Manca Id del certificato !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

on kuf_certif_email.create
call super::create
end on

on kuf_certif_email.destroy
call super::destroy
end on

