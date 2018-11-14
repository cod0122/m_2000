$PBExportHeader$kuf_meca_ptmerce.sru
forward
global type kuf_meca_ptmerce from kuf_parent
end type
end forward

global type kuf_meca_ptmerce from kuf_parent
end type
global kuf_meca_ptmerce kuf_meca_ptmerce

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function datetime tb_add (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function long get_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public subroutine set_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
private function long u_add_email_invio_1 (st_tab_meca ast_tab_meca) throws uo_exception
public function long u_add_email_invio () throws uo_exception
public function date tb_pulizia () throws uo_exception
public function boolean if_esiste (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function boolean tb_delete (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

 
end function

public function datetime tb_add (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca
//=== Ritorna: data ora di inserimento 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
datetime k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.inserimento)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento del 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if if_esiste(ast_tab_meca_ptmerce) then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Inserimento avviso nel 'Pronto Merce' fallito, il Lotto id " + string(ast_tab_meca_ptmerce.id_meca) + " è  già stato caricato in archivio!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	ast_tab_meca_ptmerce.id_email_invio = 0 
	ast_tab_meca_ptmerce.dtins = kGuf_data_base.prendi_x_datins()
	
//--- imposto dati utente e data aggiornamento
	ast_tab_meca_ptmerce.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_meca_ptmerce.x_utente = kGuf_data_base.prendi_x_utente()
	
	INSERT INTO meca_ptmerce  
				( id_meca,   
				  id_email_invio,   
				  dtins,   
				  x_datins,   
				  x_utente )  
		VALUES (    
				  :ast_tab_meca_ptmerce.id_meca
				  ,:ast_tab_meca_ptmerce.id_email_invio
				  ,:ast_tab_meca_ptmerce.dtins
				  ,:ast_tab_meca_ptmerce.x_datins   
				  ,:ast_tab_meca_ptmerce.x_utente ) 
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Inserimento 'Pronto Merce' in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = ast_tab_meca_ptmerce.dtins

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
	
	

return k_return

end function

public function long get_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Legge id_email_invio in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca 
//=== Ritorna: id_email_invio
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di lettura in 'Pronto Merce' del ID di invio email interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	select id_email_invio
	   into :ast_tab_meca_ptmerce.id_email_invio
		from meca_ptmerce  
		where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Lettura in 'Pronto Merce' del valore 'ID di invio email' in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if ast_tab_meca_ptmerce.id_email_invio > 0 then
				k_return = ast_tab_meca_ptmerce.id_email_invio
			end if
		end if
	end if


return k_return

end function

public subroutine set_id_email_invio (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Imposta id_email_invio in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca e id_email_invio
//=== Ritorna: 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento in 'Pronto Merce' del ID di invio email interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	if ast_tab_meca_ptmerce.id_email_invio > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di inserimento in 'Pronto Merce' del ID di invio email interrotta, manca ID invio email"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- imposto dati utente e data aggiornamento
	ast_tab_meca_ptmerce.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_meca_ptmerce.x_utente = kGuf_data_base.prendi_x_utente()
	
	update meca_ptmerce  
				  set id_email_invio = :ast_tab_meca_ptmerce.id_email_invio
		where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiornamento in 'Pronto Merce' del valore 'ID di invio email' in errore " + "~r~n" &
		                                  + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if



end subroutine

private function long u_add_email_invio_1 (st_tab_meca ast_tab_meca) throws uo_exception;//------------------------------------------------------------------------------------------------------------------------
//--- Fa il Carico nella tabella email-invio 
//--- Inp: st_tab_meca valorizzata con i campi necessari
//--- Out: il ID del email_invio
//------------------------------------------------------------------------------------------------------------------------
//
long k_return=0 
kuf_email_invio kuf1_email_invio
kuf_email_funzioni kuf1_email_funzioni
kuf_email kuf1_email
kuf_clienti kuf1_clienti 
kuf_armo kuf1_armo
st_tab_clienti kst_tab_clienti
st_tab_clienti_web kst_tab_clienti_web
st_tab_email_invio kst_tab_email_invio
st_tab_email kst_tab_email
st_tab_email_funzioni kst_tab_email_funzioni
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_armo = create kuf_armo

	if ast_tab_meca.id > 0 then 
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.set_nome_oggetto(this.classname( ) )
		kguo_exception.setmessage( "Manca id Lotto. Generazione e-mail non eseguita. ")
		throw kguo_exception
	end if

//--- get dei codici clienti + num_int ecc...
	kuf1_armo.get_dati_rid(ast_tab_meca)

//--- get dell'indirizzo e-mail del cliente
	kst_tab_clienti_web.id_cliente = ast_tab_meca.clie_3
	kuf1_clienti = create kuf_clienti
	kst_tab_email_invio.email = kuf1_clienti.get_email_prontomerce(kst_tab_clienti_web)
//--- se e-mail NON impostata sul cliente NON invio nulla!!!
	if trim(kst_tab_email_invio.email) > " " then
	
		kuf1_email_invio = create kuf_email_invio
		kuf1_email = create kuf_email
		kuf1_email_funzioni = create kuf_email_funzioni
		
		kst_tab_email_invio.id_cliente =  ast_tab_meca.clie_3
		kst_tab_email_invio.flg_allegati = kuf1_email_invio.ki_allegati_no
		kst_tab_email_invio.allegati_cartella = ""			
		kst_tab_email_invio.cod_funzione = kuf1_email_funzioni.kki_cod_funzione_prontomerce  // INFO che è un PRONTO MERCE
	
//--- get del Prototipo della e-mail
		kst_tab_email_funzioni.cod_funzione = kst_tab_email_invio.cod_funzione
		kst_tab_email.id_email = kuf1_email_funzioni.get_id_email_xcodfunzione(kst_tab_email_funzioni)
		if kst_tab_email.id_email = 0 then
			kguo_exception.inizializza( )
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
			kguo_exception.set_nome_oggetto(this.classname( ) )
			kguo_exception.setmessage( "Impostare da 'Proprietà della Procedura' il Prototipo e-mail da utilizzare per l'invio funzionale '" + trim(kst_tab_email_funzioni.cod_funzione)+"' (Pronto merce)")
			throw kguo_exception
		end if
		
//--- recupero diversi dati x riempire la tab email-invio			
		kuf1_email.get_riga(kst_tab_email)
		kst_tab_email_invio.oggetto = kst_tab_email.oggetto
		kst_tab_email_invio.link_lettera = kst_tab_email.link_lettera
		kst_tab_email_invio.flg_lettera_html = kst_tab_email.flg_lettera_html
		kst_tab_email_invio.flg_ritorno_ricev = kst_tab_email.flg_ritorno_ricev
		kst_tab_email_invio.email_di_ritorno = kst_tab_email.email_di_ritorno
		kst_tab_email_invio.id_oggetto = ast_tab_meca.id
		kuf1_email_invio.if_isnull(kst_tab_email_invio)

//--- get del DDT mandante		
		kuf1_armo.get_num_bolla_in(ast_tab_meca)
		
//--- Composizione dell'OGGETTO: somma alla dicitura del Prototipo il ddt del mandante a anche il Nome quando cliente diverso da mandante
		if ast_tab_meca.num_bolla_in > " " then
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " D.D.T. n. " + trim(ast_tab_meca.num_bolla_in)
			if ast_tab_meca.data_bolla_in > date(0) then
				kst_tab_email_invio.oggetto += " del " + string(ast_tab_meca.data_bolla_in)
			end if
		end if
		if ast_tab_meca.num_int > 0 then
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " rif. interno " + string(ast_tab_meca.num_int)
		end if
		if kst_tab_email_invio.id_cliente <> ast_tab_meca.clie_1 then // se cliente mandante diverso aggiungo il nome
			kst_tab_clienti.codice = ast_tab_meca.clie_1
			kuf1_clienti.get_nome(kst_tab_clienti)
			kst_tab_email_invio.oggetto = trim(kst_tab_email_invio.oggetto) + " di " + trim(kst_tab_clienti.rag_soc_10)
		end if

		kst_tab_email_invio.note = "da Convalida dosimetria, Lotto " + string(ast_tab_meca.num_int) + "  " +  string(ast_tab_meca.data_int) + "   id " + string(ast_tab_meca.id) + " "  
		
//--- Controllo la presenza in elenco della EMAIL
		kst_tab_email_invio.id_email_invio = kuf1_email_invio.if_presente_x_id_oggetto(kst_tab_email_invio)

//--- CARICO dati nella tabella EMAIL_INVIO	
		k_return = 0
		kst_tab_email_invio.st_tab_g_0.esegui_commit = ast_tab_meca.st_tab_g_0.esegui_commit
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
			kst_esito.sqlerrtext = "Errore durante preparazione e-mail da inviare!"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
	
end try



return k_return

end function

public function long u_add_email_invio () throws uo_exception;//
//====================================================================
//=== Legge Avvisi del Pronto Merce e li carica in tab Email-Invio 
//=== 
//=== Inp: 
//=== Ritorna: nr di email caricate 
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return 
long k_riga, k_righe, k_righe_daelab, k_riga100, k_riga_ds, k_rc, k_riga_tab
datetime k_datetime
st_tab_meca_ptmerce kst_tab_meca_ptmerce[], kst_tab_meca_ptmerce_vuoto[]
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
	kds_1.dataobject = "ds_meca_ptmerce_noemail"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve() // estrazione avvisi senza ancora il id_email_invio
	
	for k_riga = 1 to k_righe
		
//--- Aggiorna non più di 100 righe alla volta...		
		if (k_righe - k_riga) < 100 then
			k_righe_daelab = k_righe - k_riga
		else
			k_righe_daelab = 100 - 1
		end if
		k_riga100 = k_riga + k_righe_daelab 
		
		k_riga_tab = 0
		kst_tab_meca_ptmerce[] = kst_tab_meca_ptmerce_vuoto[]
		
		for k_riga_ds = k_riga to k_riga100
			
			k_riga_tab ++
//--- Prepara l'array per popolare la tabella email
			kst_tab_meca_ptmerce[k_riga_tab].id_meca = kds_1.getitemnumber( k_riga_ds, "id_meca")
			
			kst_tab_meca.id =  kst_tab_meca_ptmerce[k_riga_tab].id_meca
			kst_tab_meca_ptmerce[k_riga_tab].st_tab_g_0.esegui_commit = "N"
			kst_tab_meca_ptmerce[k_riga_tab].id_email_invio = u_add_email_invio_1(kst_tab_meca) // ADD EMAIL
			
		next
		
//--- Imposta id email invio in pronto merce 
		k_riga_tab = 0
		for k_riga_ds = k_riga to k_riga100
			k_riga_tab ++
			if kst_tab_meca_ptmerce[k_riga_tab].id_email_invio > 0 then  // ID invio email valorizzato?
				k_return ++
				kds_1.setitem(k_riga_ds, "id_email_invio", kst_tab_meca_ptmerce[k_riga_tab].id_email_invio)
				kds_1.setitem(k_riga_ds, "x_datins", kGuf_data_base.prendi_x_datins())
				kds_1.setitem(k_riga_ds, "x_utente", kGuf_data_base.prendi_x_utente())
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
			kst_esito.SQLErrText = "Errore in carico Avviso Pronto Merce in tabella Email da Inviare. Il primo ID Lotto era " + string(kds_1.getitemnumber(k_riga, "id_meca")) &
			                       + "~r~nErrore: " + trim(kst_esito.nome_oggetto) + ") "
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_riga = k_riga_ds - 1
	next
	
//--- Rimuove le righe vecchie dalla tabella Avvisi
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
//=== Rimuove i rek non più utili dal 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: 
//=== Ritorna: data di rimozione
//=== Lancia EXCEPTION
//===  
//====================================================================
//
date k_return  
st_tab_meca_ptmerce kst_tab_meca_ptmerce
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.inserimento)


//--- Fissa la data datta quale fare la pulizia della tabella
	kst_tab_meca_ptmerce.dtins = datetime(relativedate(date(kGuf_data_base.prendi_x_datins()), -30), time(0))
	
	DELETE FROM meca_ptmerce  
			where dtins < :kst_tab_meca_ptmerce.dtins
			using kguo_sqlca_db_magazzino;
		

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione dati 'Pronto Merce' dal " + string(kst_tab_meca_ptmerce.dtins) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = date(kst_tab_meca_ptmerce.dtins)

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

public function boolean if_esiste (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Verifica se Lotto già in tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca 
//=== Ritorna: TRUE = presente, FALSE = assente
//=== Lancia EXCEPTION
//===  
//====================================================================
//
boolean k_return = false
st_esito kst_esito
st_tab_meca_ptmerce kst_tab_meca_ptmerce

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.modifica)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di verifica esistenza in 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	select id_meca
	   into :kst_tab_meca_ptmerce.id_meca
	   from meca_ptmerce  
		where id_meca = :ast_tab_meca_ptmerce.id_meca
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			k_return = false
		else
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Verifica presenza in 'Pronto Merce' del Lotto con ID: "+ string(ast_tab_meca_ptmerce.id_meca) + " errore " + "~r~n" &
														 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if

return k_return 

end function

public function boolean tb_delete (st_tab_meca_ptmerce ast_tab_meca_ptmerce) throws uo_exception;//
//====================================================================
//=== Rimuove il rek nella tabella 'PRONTO MERCE'  MECA_PTMERCE 
//=== 
//=== Inp: ast_tab_meca_ptmerce id_meca
//=== Ritorna: TRUE = OK
//=== Lancia EXCEPTION
//===  
//====================================================================
//
boolean k_return 
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	if_sicurezza(kkg_flag_modalita.inserimento)

	if ast_tab_meca_ptmerce.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Operazione di Rimozione 'Pronto Merce' interrotta, manca ID del Lotto"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	DELETE FROM meca_ptmerce  
			where id_meca = :ast_tab_meca_ptmerce.id_meca
			using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Rimozione 'Pronto Merce' del Lotto id " + string(ast_tab_meca_ptmerce.id_meca) + " in errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			k_return = true

		end if
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
	else
		if ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_ptmerce.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if
	
	
return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Carica Avvisi Pronto Merce kuf_meca_reportpilotakuf_meca_reportpilotain tab Email da Inviare
	k_ctr = u_add_email_invio( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati caricati " + string(k_ctr) + " avvisi di 'Pronto Merce' in tabella 'email da inviare'." 
	else
		kst_esito.SQLErrText = "Operazione conclusa.  Nessuno nuovo Avviso di Pronto Merce caricato in tabella 'email da inviare'."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_meca_ptmerce.create
call super::create
end on

on kuf_meca_ptmerce.destroy
call super::destroy
end on

