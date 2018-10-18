$PBExportHeader$kuf_meca_chiudi.sru
forward
global type kuf_meca_chiudi from kuf_parent
end type
end forward

global type kuf_meca_chiudi from kuf_parent
end type
global kuf_meca_chiudi kuf_meca_chiudi

type variables
//
kuf_esito_operazioni kiuf_esito_operazioni

end variables

forward prototypes
public subroutine log_destroy ()
public subroutine log_inizializza () throws uo_exception
public function long u_chiudi (ref datastore ads_1, st_meca_chiudi ast_meca_chiudi) throws uo_exception
public function boolean u_open ()
public function boolean u_chiudi_lotto (st_tab_meca ast_tab_meca) throws uo_exception
public function long u_chiude_lotti_spediti () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public subroutine log_destroy ();//
if isvalid(kiuf_esito_operazioni) then destroy kiuf_esito_operazioni


 
end subroutine

public subroutine log_inizializza () throws uo_exception;//
//--- inizializza il log delle operazioni	
	if not isvalid(kiuf_esito_operazioni) then kiuf_esito_operazioni = create kuf_esito_operazioni

	kiuf_esito_operazioni.inizializza( kiuf_esito_operazioni.kki_tipo_operazione_meca_chiusura )


 
end subroutine

public function long u_chiudi (ref datastore ads_1, st_meca_chiudi ast_meca_chiudi) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Chiusura massiva Lotti indicati
//---
//--- inp: datastore con l'elenco dei lotti da chiudere
//--- out: il datastore modificato
//--- ritorna: nr lotti chiusi
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return
long k_righe, k_riga
int k_rc
string k_data_ent
st_esito kst_esito
st_tab_esito_operazioni kst_tab_esito_operazioni
kuf_armo kuf1_armo


	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kGuo_exception.inizializza( )

	k_righe = ads_1.rowcount()

//--- aggiunge riga al log
	if ast_meca_chiudi.k_simulazione = "N"  then // se non sono in simulazione eseguo!
		kiuf_esito_operazioni.tb_add_riga("-----------> Inizio Chiusura Massiva Lotti ricerca su " + string (k_righe) + " righe <-----------", false)
	else
		kiuf_esito_operazioni.tb_add_riga("-----------> Inizio SIMULAZIONE Chiusura Massiva Lotti ricerca su " + string (k_righe) + " righe <-----------", false)
	end if

	ads_1.resetupdate()

	for k_riga = 1 to k_righe
		
		if ads_1.getitemnumber(k_riga, "sel") = 1 or ast_meca_chiudi.k_tutto then
			
			ads_1.setitem(k_riga, "aperto", kuf1_armo.kki_meca_aperto_no)
			ads_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
			ads_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
			k_return ++

			if date(ads_1.getitemdatetime(k_riga, "meca_data_ent")) > kkg.data_zero then
				k_data_ent = " entrato il " + string(ads_1.getitemdatetime(k_riga, "meca_data_ent"), "dd mmm yy hh:mm")
			end if
			
//--- aggiunge riga al log
			kiuf_esito_operazioni.tb_add_riga("verrà chiuso il Lotto " + string(ads_1.getitemnumber(k_riga, "meca_num_int")) &
		                            + " del " + string(ads_1.getitemdate(k_riga, "meca_data_int")) &
		                            + " id " + string(ads_1.getitemnumber(k_riga, "id_meca")) &
		                            + k_data_ent &
		                            + " e1-WO: " + string(ads_1.getitemnumber(k_riga, "e1doco"), "#0") &
		                            + " e1-SO: " + string(ads_1.getitemnumber(k_riga, "e1rorn"), "#0") &
		                            + " aperto: " + ads_1.getitemstring(k_riga, "aperto") &
											 + " ", false)
		end if
	next

	if k_return > 0 and ast_meca_chiudi.k_simulazione = "N"  then // se non sono in simulazione AGGIORNA DB
		k_rc = ads_1.update()
		if k_rc > 0 then
			kguo_sqlca_db_magazzino.db_commit( )
		else
			k_return = 0
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlerrtext = "Chiusura Massiva Lotti: fallito aggiornamento dati (" + string(k_rc) + "), Lotti non chiusi." //  ~n~r" + kst_esito.sqlerrtext 
			kGuo_exception.inizializza()
			kGuo_exception.set_esito(kst_esito) 
			kiuf_esito_operazioni.tb_add_riga(kst_esito.sqlerrtext, true) //--- aggiunge riga al log
			throw kGuo_exception
		end if
	end if
	
	if ast_meca_chiudi.k_simulazione = "N"  then // se non sono in simulazione eseguo!
		if k_rc > 0 then
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine operazione sono stati chiusi " + string (k_return) + " Lotti <-----------", false)
		else
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine operazione nessun Lotto è stato chiuso <-----------", false)
		end if
	else
		if k_return > 0 then
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine SIMULAZIONE sarebbero stati chiusi " + string (k_return) + " Lotti <-----------", false)
		else
			kiuf_esito_operazioni.tb_add_riga("-----------> Fine SIMULAZIONE nessun Lotto sarebbe stato chiuso <-----------", false)
		end if
	end if

	kst_tab_esito_operazioni.st_tab_g_0.esegui_commit = "S"
	kiuf_esito_operazioni.tb_add(kst_tab_esito_operazioni) //consolida le righe aggiunte

	setpointer(kkg.pointer_default)

return k_return
end function

public function boolean u_open ();//
//--- Chiama la OPEN senza particolari funzioni
//---
//--- Input: 
//---
//
boolean  k_return = true
st_tab_g_0 kst_tab_g_0[]
st_open_w kst_open_w

kst_tab_g_0[1].id = 1

try 
	if_sicurezza(kkg_flag_modalita.modifica )
	k_return = this.u_open_applicazione(kst_tab_g_0[1], kkg_flag_modalita.modifica)
catch (uo_exception kuo_exception)
	try 
		if_sicurezza(kkg_flag_modalita.visualizzazione )
		k_return = this.u_open_applicazione(kst_tab_g_0[1], kkg_flag_modalita.visualizzazione)
	catch (uo_exception kuo1_exception)
		k_return = false
		kuo1_exception.messaggio_utente()
	end try
end try
		
 
return k_return

end function

public function boolean u_chiudi_lotto (st_tab_meca ast_tab_meca) throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Chiude Lotto in automatico dopo una valutazione
//---
//--- inp: st_tab_meca.id lotto da chiudere
//--- out: 
//--- ritorna: TRUE = chiuso / FALSE = non chiuso
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
long k_colli_inMagazzino
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_clienti kst_tab_clienti
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti


try
	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	if ast_tab_meca.id > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in chiusura automatica Lotto. Manca ID Lotto"
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito( kst_esito )
		throw kGuo_exception
	end if

	kuf1_armo = create kuf_armo
	kuf1_clienti = create kuf_clienti

	kuf1_armo.get_clie(ast_tab_meca)
	if ast_tab_meca.clie_3 > 0 then

//--- verifica se è un cliente PA perchè questi non devono essere chiusi in automatico, prima bisogna fatturarli
		kst_tab_clienti.codice = ast_tab_meca.clie_3
		if kuf1_clienti.if_cliente_pa(kst_tab_clienti) then
		else
//--- Chiude solo se i Colli in giacenza sono ZERO!
			kst_tab_armo.id_meca = ast_tab_meca.id
			k_colli_inMagazzino = kuf1_armo.get_colli_in_giacenza_x_id_meca(kst_tab_armo)
			if k_colli_inMagazzino = 0 then
				ast_tab_meca.st_tab_g_0.esegui_commit = "S"
				k_return = kuf1_armo.set_lotto_chiudi_ok(ast_tab_meca)
			end if
		end if
	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in chiusura automatica Lotto. " + trim(kst_esito.SQLErrText)
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	
end try

return k_return

end function

public function long u_chiude_lotti_spediti () throws uo_exception;//---------------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Chiude Lotti Spditi in automatico 
//---
//--- inp:
//--- out: 
//--- ritorna: numero lotti chiusi
//--- lancia Exception: uo_exception x errore grave
//---
//---
//---------------------------------------------------------------------------------------------------------------------------------------------------
//
long k_return
date k_data_da
long k_righe, k_riga
st_esito kst_esito
st_tab_meca kst_tab_meca
datastore kds_1
kuf_armo kuf1_armo


try
	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_data_da = relativedate(kguo_g.get_dataoggi( ), -3)

	kds_1 = create datastore
	kds_1.dataobject = "d_meca_dachiudere_l"
	kds_1.settransobject( kguo_sqlca_db_magazzino )
	k_righe = kds_1.retrieve(k_data_da)	// estrazione Lotti spediti da meno qualche giorno

	for k_riga = 1 to k_righe
		
//--- Non chiude i Lotti 'RIAPERTI'		
		kst_tab_meca.aperto = kds_1.getitemstring( k_riga, "aperto")
		if kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_si or kst_tab_meca.aperto = kuf1_armo.kki_meca_aperto_nullx &
		        or trim(kst_tab_meca.aperto) = "" then 
			kst_tab_meca.id = kds_1.getitemnumber( k_riga, "id_meca")
			if kst_tab_meca.id > 0 then
				if u_chiudi_lotto(kst_tab_meca) then  // Chiude Lotto
					k_return ++
				end if
			end if
		end if
		
	next
		
catch (uo_exception kuo_exception)
	throw kuo_exception
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in chiusura automatica Lotto. " + trim(kst_esito.SQLErrText)
	
finally
	
end try

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

//--- Chiudi Lotti Spediti
	k_ctr = u_chiude_lotti_spediti( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati Chiusi " + string(k_ctr) + " Lotti già spediti" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessuno nuovo Lotto già spedito da Chiudere trovato."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_meca_chiudi.create
call super::create
end on

on kuf_meca_chiudi.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- utile per CHIUDERE massivamente i Lotti 
//--- 

end event

