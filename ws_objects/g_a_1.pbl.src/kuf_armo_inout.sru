$PBExportHeader$kuf_armo_inout.sru
forward
global type kuf_armo_inout from kuf_parent
end type
end forward

global type kuf_armo_inout from kuf_parent
end type
global kuf_armo_inout kuf_armo_inout

type variables
//
public st_tab_armo kist_tab_armo
public st_tab_meca kist_tab_meca
private kuf_armo kiuf_armo

//--- MEMO
private st_tab_meca_memo kist_tab_meca_memo

////--- MEMO: allarme
//public constant string kki_MEMO_allarme_no = "N" // nessuno
//public constant string kki_MEMO_allarme_meca = "L" // nel carico Lotto
//public constant string kki_MEMO_allarme_ddt = "S" // nel carico DDT
//public constant string kki_MEMO_allarme_fattura = "F" // nel carico Fattura


//--- MEMO: settore di competenza 
//public constant string kki_tipo_sv_MAG = "MAG"  //allegati al Riferimento
//public constant string kki_tipo_sv_QLT = "QLT"  //allegati al Riferimento Qualità ad esmpio allo Sblocco lotto
//public constant string kki_tipo_sv_DSM = "DSM"  //allegati al Riferimento - dosimetria convalida

end variables

forward prototypes
public function long carica_lotto_testa () throws uo_exception
public function long carica_lotto_riga () throws uo_exception
private function long set_meca_to_wm_tab (ref st_tab_meca kst_tab_meca, datastore kds_lotto, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception
public function boolean if_crea_pkl_interna (st_tab_meca kst_tab_meca) throws uo_exception
public function boolean crea_wm_pklist_fittizio (ref st_tab_meca kst_tab_meca) throws uo_exception
public function boolean if_autorizza_crea_wm_pklist_fittizio () throws uo_exception
public function long carica_prezzi_lotto (st_tab_armo ast_tab_armo) throws uo_exception
private function long carica_prezzi_riga (st_tab_armo ast_tab_armo) throws uo_exception
public function st_esito get_id_memo (ref st_tab_meca_memo kst_tab_meca_memo)
public subroutine memo_save (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception
public function boolean tb_delete (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception
public function st_esito get_id_meca_memo_max (ref st_tab_meca_memo kst_tab_meca_memo)
public function st_esito tb_update (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception
public subroutine get_id_memo_max_x_id_meca (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception
public function st_esito get_righe_da_sped (ref st_tab_armo kst_tab_armo[])
private function long importa_wm_pklist_esegui (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public function long importa_wm_pklist (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception
public subroutine update_post_stampa_attestato (st_tab_meca kst_tab_meca) throws uo_exception
public subroutine update_post_delete_attestato (st_tab_meca kst_tab_meca) throws uo_exception
end prototypes

public function long carica_lotto_testa () throws uo_exception;//
//====================================================================
//=== Carica Testata (MECA) Lotto nelle Tabelle 
//=== 
//=== 
//===  input: kist_tab_meca  
//===  Outout: st_tab_meca.ID_MECA  st_tab_meca.st_tab_g_0.contati=NUM_INT passato originariamente
//===  Ritorna: ID_MECA
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return=0
long k_ctr
string k_esito 
st_tab_meca kst_tab_meca_appo
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		
//--- imposta i campi non valorizati
		kiuf_armo.if_isnull_meca(kist_tab_meca)

//--- Piglia il nuovo Num Int e Data	
		kiuf_armo.get_num_int_new(kst_tab_meca_appo )

//--- Se NUM_INT cambiato rispetto a quello passato allora il vecchio lo salvo nel campo CONTATI
		kist_tab_meca.st_tab_g_0.contati = kist_tab_meca.num_int 
		kist_tab_meca.num_int = kst_tab_meca_appo.num_int
	
		if kist_tab_meca.data_int > kkg.data_zero then
		else
			kist_tab_meca.data_int = kst_tab_meca_appo.data_int
		end if

//--- verifica se numero lotto già caricato
		if kist_tab_meca.id = 0 then
			if kiuf_armo.if_esiste(kist_tab_meca) then
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.SQLErrText =  "Lotto " + string(kist_tab_meca.num_int) + " già in archivio! Aggiornare il contatore 'ultimo numero lotto' in Proprietà Azienda."
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if

//--- carico Testa Lotto 	
		kist_tab_meca.st_tab_g_0.esegui_commit = "S"
		k_return = kiuf_armo.tb_update_meca( kist_tab_meca )
		
//--- Aggiorna Numero Lotto 		
		kist_tab_meca.st_tab_g_0.esegui_commit = "S"
		kiuf_armo.set_num_int(kist_tab_meca)
		
//--- carico Causale Lotto 	
		if kist_tab_meca.id_meca_causale > 0 then
			kist_tab_meca.st_tab_g_0.esegui_commit = "S"
			kiuf_armo.tb_update_meca_blk(kist_tab_meca)
		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	
return k_return

end function

public function long carica_lotto_riga () throws uo_exception;//
//====================================================================
//=== Carica Riga Lotto nelle Tabelle 
//=== 
//===  
//===  input: kist_tab_meca / kist_tab_armo
//===  Outout: ID_ARMO 
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return=0
long k_ctr
st_esito kst_esito
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
//--- imposta i campi non valorizati
		kist_tab_armo.id_armo = 0 // aggiunto un item x uscire dal ciclo
		kiuf_armo.if_isnull_armo( kist_tab_armo)
				
//--- carico Righe Lotto 		
//		k_ctr = upperbound(kist_tab_armo)
//		if k_ctr > 0 then
//			kist_tab_armo[k_ctr + 1].id_armo = 0 // aggiunto un item x uscire dal ciclo
//			k_ctr = 1
//			do while kist_tab_armo[k_ctr].id_armo > 0 
			
		k_return = kiuf_armo.tb_update_armo( kist_tab_armo )

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	
return k_return

end function

private function long set_meca_to_wm_tab (ref st_tab_meca kst_tab_meca, datastore kds_lotto, ref st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Riempie da LOTTO (meca+armo) la struct array kst_tab_wm_receiptgammarad []
//---	inp: kst_tab_meca.id
//---	out: kst_tab_wm_receiptgammarad[]: array con le righe del packing-list riempite
//---	rit: nr righe 
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
long k_return=0
long k_nr_righe = 0
string k_rc, k_file=""
//int k_rcn, k_file_ind, k_anno, k_mese, k_giorno
long k_ind=0
boolean k_trovate_note_lotto = false
st_esito kst_esito
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad_null
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
 
 st_wm_pkl_web kst_wm_pkl_web[]
 
try

	
	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
		
	k_nr_righe = kds_lotto.rowcount( ) 	
	if k_nr_righe > 0 then
		
//--- preparo la struct a NULL		
		kuf1_wm_receiptgammarad.set_null(kst_tab_wm_receiptgammarad_null)
		
		
		for k_ind = 1 to k_nr_righe

//--- inizializzo la riga				
			kst_tab_wm_receiptgammarad[k_ind] = kst_tab_wm_receiptgammarad_null
				
//--- codice packing-list
			kst_tab_wm_receiptgammarad[k_ind].packinglistcode = "XXX_" +string(kds_lotto.object.barcode_id_meca[k_ind]) 

			kst_tab_wm_receiptgammarad[k_ind].Id_meca = kds_lotto.object.barcode_id_meca[k_ind]
			kst_tab_wm_receiptgammarad[k_ind].transmissiondate = datetime(kg_dataoggi, time(now()) )
			kst_tab_wm_receiptgammarad[k_ind].receiptdate	= kst_tab_wm_receiptgammarad[k_ind].transmissiondate
			kst_tab_wm_receiptgammarad[k_ind].ddtcode	= trim(upper(kds_lotto.object.meca_num_bolla_in[k_ind]))
			kst_tab_wm_receiptgammarad[k_ind].ddtdate = datetime(kds_lotto.object.meca_data_bolla_in[k_ind])	
			kst_tab_wm_receiptgammarad[k_ind].mandatorcustomercode	= string(kds_lotto.object.meca_clie_1[k_ind], "0000000000")
			kst_tab_wm_receiptgammarad[k_ind].receivercustomercode = string(kds_lotto.object.meca_clie_2[k_ind], "0000000000")
			kst_tab_wm_receiptgammarad[k_ind].invoicecustomercode = string(kds_lotto.object.meca_clie_3[k_ind], "0000000000")

						
			kst_tab_wm_receiptgammarad[k_ind].contract = trim(kds_lotto.object.contratti_mc_co[k_ind])
			if isnull(kst_tab_wm_receiptgammarad[k_ind].contract) or len(trim(kst_tab_wm_receiptgammarad[k_ind].contract)) = 0 then
				kst_tab_wm_receiptgammarad[k_ind].contract = string(kds_lotto.object.meca_contratto[k_ind])
				if isnull(kst_tab_wm_receiptgammarad[k_ind].contract) or len(trim(kst_tab_wm_receiptgammarad[k_ind].contract)) = 0 then
					kst_tab_wm_receiptgammarad[k_ind].contract = "NONTROVATO"
				end if
			end if
			kst_tab_wm_receiptgammarad[k_ind].specification	= trim(kds_lotto.object.contratti_sc_cf[k_ind])
			if isnull(kst_tab_wm_receiptgammarad[k_ind].specification) or len(trim(kst_tab_wm_receiptgammarad[k_ind].specification)) = 0 then
				kst_tab_wm_receiptgammarad[k_ind].specification = string(kds_lotto.object.meca_contratto[k_ind])
				if isnull(kst_tab_wm_receiptgammarad[k_ind].specification) or len(trim(kst_tab_wm_receiptgammarad[k_ind].specification)) = 0 then
					kst_tab_wm_receiptgammarad[k_ind].specification = "NONTROVATO"
				end if
			end if
			
//--- imposto il barcode esterno uguale a quello di trattamento (+ anche la lunghezza)			
			kst_tab_wm_receiptgammarad[k_ind].externalpalletcode = upper(trim(string(kds_lotto.object.barcode_barcode[k_ind])))
			kst_tab_wm_receiptgammarad[k_ind].palletlength = len(trim(kst_tab_wm_receiptgammarad[k_ind].externalpalletcode))
			
			kst_tab_wm_receiptgammarad[k_ind].palletquantity = 1	

			kst_tab_wm_receiptgammarad[k_ind].customerlot = upper(kst_tab_wm_receiptgammarad[k_ind].packinglistcode)
			
			kst_tab_wm_receiptgammarad[k_ind].orderdate =  kst_tab_wm_receiptgammarad[k_ind].transmissiondate

			kst_tab_wm_receiptgammarad[k_ind].customerItem = ""
			kst_tab_wm_receiptgammarad[k_ind].PesoNetto = 0
			kst_tab_wm_receiptgammarad[k_ind].PesoLordo = 0
			kst_tab_wm_receiptgammarad[k_ind].QuantitaSacchi = 0

			kst_tab_wm_receiptgammarad[k_ind].note_3 = ""
			kst_tab_wm_receiptgammarad[k_ind].note_2 = ""
			kst_tab_wm_receiptgammarad[k_ind].note_1 = ""
			
		end for

	end if
	k_return = k_ind - 1
		
catch (uo_exception kuo_exception)
//		kst_esito.esito = kkg_esito.blok
//		kst_esito.sqlcode = k_rcn
//		kst_esito.SQLErrText = "Importazione Nuovi 'Packing-List' fallito!  ~n~r "  
//		kguo_exception.set_esito(kst_esito)
		throw kuo_exception
		
		
finally
		if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad			
		
end try
			


return k_return


end function

public function boolean if_crea_pkl_interna (st_tab_meca kst_tab_meca) throws uo_exception;//
//====================================================================
//=== Controlla se Possibile per questo Lotto generare un Packing-List Fittizio
//=== 
//=== 
//===  input: kist_tab_meca.id_meca
//===  Outout: TRUE = ok posso crearlo
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
boolean k_return=false
st_tab_barcode kst_tab_barcode
st_wm_pklist kst_wm_pklist
st_esito kst_esito
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode 
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try
		
		if kst_tab_meca.id > 0 then

//--- controlla se ha gia' una PKL associata						
			kuf1_armo = create kuf_armo
			kuf1_armo.get_id_wm_pklist(kst_tab_meca) 
			
			if kst_tab_meca.id_wm_pklist = 0 then

//--- il Lotto deve almeno avere 1 barcode generato
				kuf1_barcode = create kuf_barcode
				kst_tab_barcode.id_meca = kst_tab_meca.id
				if kuf1_barcode.get_nr_barcode(kst_tab_barcode) > 0 then 
				
					k_return = true
					
				end if
					
	
			end if
		end if

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	finally
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
	end try
	
return k_return

end function

public function boolean crea_wm_pklist_fittizio (ref st_tab_meca kst_tab_meca) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Crea Packing-List Fittizia ovvero le Tabelle del DB di WMF (receiptgammarad) e INTERNE (wm_pklist)
//---   da Riferimento Lotto gia' caricato
//---
//---	inp: kst_tab_meca.id    (id_meca) 
//---	out: TRUE = OK 
//---	rit: nr. dei Pcking Prodotti 
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
boolean k_blocco_importazioni = false
long k_id_wm_pklist_importato=0, k_nr_ws_receiptgammarad=0 , k_ctr=0
st_esito kst_esito
st_tab_barcode kst_tab_barcode[]
st_wm_pklist kst_wm_pklist
st_tab_wm_pklist kst_tab_wm_pklist
st_tab_wm_pklist_cfg kst_tab_wm_pklist_cfg
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[], kst_tab_wm_receiptgammarad_NULLA[]
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe[]
kuf_armo kuf1_armo
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
kuf_wm_pklist_inout kuf1_wm_pklist_inout 
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
kuf_wm_pklist_testa kuf1_wm_pklist_testa
kuf_wm_pklist_righe kuf1_wm_pklist_righe
datastore kds_lotto

 					

try

	kuf1_armo = create kuf_armo
	kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kuf1_wm_pklist_inout = create kuf_wm_pklist_inout
	kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
	kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
	kds_lotto = create datastore

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	//--- Ho passato qls da trattare?
	if kst_tab_meca.id > 0 then
					
//--- leggo configurazione x lo scambio dati
		if kuf1_wm_pklist_cfg.get_wm_pklist_cfg(kst_tab_wm_pklist_cfg) then
		
//--- se importazione non bloccate faccio!
			if kst_tab_wm_pklist_cfg.blocca_importa = kuf1_wm_pklist_cfg.ki_blocca_importa_SI then
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
				kguo_exception.setmessage( "BLOCCATA importazione da WMF (vedi Archivio Impostazioni WMF) - L'operazione non può proseguire. ")
				throw kguo_exception
			end if
			
			k_blocco_importazioni = true
			kuf1_wm_pklist_cfg.set_blocco_importazione_si( )  // blocca le importazioni x tutti gli altri
		
//--- definisce la query x leggere tutto il lotto		
			kds_lotto.dataobject = "d_meca_armo_barcode_select"
			kds_lotto.settransobject( sqlca )
			if kds_lotto.retrieve(kst_tab_meca.id ) = 0 then
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
				kguo_exception.setmessage( "Per questo Lotto non sembrano generati i Barcode. Operazione non eseguita.")
				throw kguo_exception
			end if

//--- Imposta nell'area ReceiptGammarad la Packing-list leggendo soprattutto BARCODE e MECA 
			kst_tab_wm_receiptgammarad[] = kst_tab_wm_receiptgammarad_NULLA[]
			k_nr_ws_receiptgammarad = set_meca_to_wm_tab( kst_tab_meca, kds_lotto, kst_tab_wm_receiptgammarad[]) 
		
//--- INSERT nella tabella di PACKING-LIST    RECEIPTGAMMARAD di WM
			if kuf1_wm_receiptgammarad.crea( k_nr_ws_receiptgammarad, kst_tab_wm_receiptgammarad[] ) > 0 then
			
//--- Fingo di avere accettato il Materiale
				kst_tab_wm_receiptgammarad[1].st_tab_g_0.esegui_commit = "S"
				kuf1_wm_receiptgammarad.set_accept_true(kst_tab_wm_receiptgammarad[1])
			
//--- Importa la PKLIST nelle tabelle interne (wm_pklist e wm_pklist_righe)	
				kst_tab_wm_pklist.idpkl = kst_tab_wm_receiptgammarad[1].packinglistcode
				kst_tab_wm_pklist.id_wm_pklist = kuf1_wm_pklist_inout.importa_wm_pklist_ext(kst_tab_wm_pklist)
				if kst_tab_wm_pklist.id_wm_pklist = 0 then
					kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_generico )
					kguo_exception.setmessage( "Non e' stato possibile Importare dal WMF la Packing-List fittizia " + trim(kst_tab_wm_pklist.idpkl) + " - Operazione interrotta. ")
					throw kguo_exception
				end if
				
//--- Imposto descrizione nelle NOTE della testata Packing-List - x chiarezza
				kst_tab_wm_pklist.note = "Packing-List FITTIZIA caricato dal Lotto num. " + string(kds_lotto.object.meca_num_int[1]) + " del " + string(kds_lotto.object.meca_data_int[1]) + " id "  + string(kds_lotto.object.meca_id[1])  
				kuf1_wm_pklist_testa.set_note(kst_tab_wm_pklist)

//--- Rimetto su WM il flag come se il materiale dovesse ancora essere accettato 
				kst_tab_wm_receiptgammarad[1].st_tab_g_0.esegui_commit = "S"
 				kuf1_wm_receiptgammarad.set_accept_false(kst_tab_wm_receiptgammarad[1])
			
//--- Imposta il tipo del Packing come FITTIZIA
				kuf1_wm_pklist_testa.set_tipo_interna(kst_tab_wm_pklist)

//--- Imposta sul lotto il ID_WM_PKLIST
				kst_tab_meca.id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
				kuf1_armo.set_id_wm_pklist(kst_tab_meca)

//--- Aggiorna le righe PL interna con i dati del Lotto
				for k_ctr = 1 to k_nr_ws_receiptgammarad
					
					kst_tab_wm_pklist_righe[k_ctr].id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
					kst_tab_wm_pklist_righe[k_ctr].st_tab_g_0.esegui_commit = "S"
					kst_tab_wm_pklist_righe[k_ctr].id_meca = kds_lotto.object.meca_id[k_ctr]	
					kst_tab_wm_pklist_righe[k_ctr].id_armo = kds_lotto.object.armo_id_armo[k_ctr]
					kst_tab_wm_pklist_righe[k_ctr].gruppo = kds_lotto.object.prodotti_gruppo[k_ctr]
					kst_tab_wm_pklist_righe[k_ctr].barcode = kds_lotto.object.barcode_barcode[k_ctr]
					
				end for
				if kuf1_wm_pklist_righe.set_dati_lotto_x_id_wm_pklist(k_ctr, kst_tab_wm_pklist_righe[]) then
				
//--- Forza a Importato il flag delle righe PL (tab interna)
					kst_tab_wm_pklist_righe[1].id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
					if kuf1_wm_pklist_righe.set_stato_importato_x_id_wm_pklist(kst_tab_wm_pklist_righe[1]) then
					
//--- Forza a Importato il flag della Testata del PL (tab interna)
						kst_tab_wm_pklist.st_tab_g_0.esegui_commit = "S"
						kuf1_wm_pklist_testa.set_stato_importato(kst_tab_wm_pklist) 
					

//--- Imposta i Barcode nella tabella righe del PL ReceiptGammarad di WM
						kst_tab_wm_pklist_righe[1].id_meca = kst_tab_meca.id 
						kuf1_wm_pklist_inout.set_barcode_in_wm_receiptgammarad(kst_tab_wm_pklist_righe[1])
								
					
						k_return = TRUE  // OK!!!!!!!!!!!!!!!!!!!!
								
								
					end if
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	
	kGuf_data_base.errori_scrivi_esito ("I", kst_esito)
//	if len(trim(kst_tab_wm_pklist_cfg.file_esiti )) > 0 then
//		kGuf_data_base.errori_scrivi_esito ("I", kst_esito, kst_tab_wm_pklist_cfg.file_esiti )
//	end if

	throw kuo_exception
	
finally
	
	if k_blocco_importazioni then  // se avevo bloccato le Importazioni le sblocco!
		kuf1_wm_pklist_cfg.set_blocco_importazione_NO( )  // Sblocca le importazioni x tutti gli altri
	end if
	
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_wm_pklist_cfg) then destroy kuf1_wm_pklist_cfg	
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	if isvalid(kuf_wm_pklist_inout) then destroy kuf_wm_pklist_inout
	if isvalid(kuf1_wm_pklist_testa) then destroy kuf1_wm_pklist_testa
	if isvalid(kuf1_wm_pklist_righe) then destroy kuf1_wm_pklist_righe
	if isvalid(kds_lotto) then destroy kds_lotto

end try

return k_return


end function

public function boolean if_autorizza_crea_wm_pklist_fittizio () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//--- 	Utente autorizzato a Crea Packing-List Fittizia ?
//---  
//---	inp:
//---	out: 
//---	rit: TRUE = OK Autorizzato
//---   Lancia EXCEPTION se errore
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return=false
boolean k_sicurezza
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
kuf_wm_pklist kuf1_wm_pklist

 					

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
	kuf1_wm_pklist = create kuf_wm_pklist
	kuf1_sicurezza = create kuf_sicurezza
	

//--- controlla se utente autorizzato alla funzione in atto
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	kst_open_w.id_programma = kuf1_wm_receiptgammarad.get_id_programma(kst_open_w.flag_modalita) 
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	if k_sicurezza then

		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
		kst_open_w.id_programma = kuf1_wm_receiptgammarad.get_id_programma(kst_open_w.flag_modalita) 
		k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		if k_sicurezza then

			kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
			kst_open_w.id_programma = kuf1_wm_pklist.get_id_programma(kst_open_w.flag_modalita) 
			k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
			if k_sicurezza then

				kst_open_w.flag_modalita = kkg_flag_modalita.modifica
				kst_open_w.id_programma = kuf1_wm_pklist.get_id_programma(kst_open_w.flag_modalita) 
				k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
				if k_sicurezza then
					k_return = true    //  OK SONO AUTORIZZATO
				end if
			end if
		end if
	end if	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito( )
	throw kuo_exception
	
finally
	if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
	if isvalid(kuf_wm_pklist_inout) then destroy kuf_wm_pklist_inout
	if isvalid(kuf1_wm_pklist) then destroy kuf1_wm_pklist
	if isvalid(kuf1_sicurezza) then destroy kuf1_sicurezza

end try

return k_return


end function

public function long carica_prezzi_lotto (st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Carica Prezzi per tutte le Righe del Lotto e lancia EVENTO di CARICO per attivare subito alcuni Prezzi
//=== 
//=== 
//===  input: st_tab_armo.id_meca
//===  Outout: il numero di righe prezzi caricate
//===  Rit: 
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return=0
integer k_ctr, k_ind
//st_tab_meca kst_tab_meca
st_esito kst_esito
st_tab_armo_prezzi kst_tab_armo_prezzi
datastore kds_id_armo_x_id_meca
kuf_armo_prezzi kuf1_armo_prezzi


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try

		if ast_tab_armo.id_meca > 0 then
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore generazione Prezzi Lotto (armo_prezzi). manca id Lotto (id_meca)"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)				
			throw kguo_exception
		end if			
			
		kuf1_armo_prezzi = create kuf_armo_prezzi
		
//--- datastore x pigliare ID_ARMO
		kds_id_armo_x_id_meca = create datastore
		kds_id_armo_x_id_meca.dataobject = "ds_id_armo_x_id_meca"
		kds_id_armo_x_id_meca.settransobject( kguo_sqlca_db_magazzino )
		
		kds_id_armo_x_id_meca.retrieve(ast_tab_armo.id_meca)
				
		for k_ind = 1 to kds_id_armo_x_id_meca.rowcount( )

			ast_tab_armo.id_armo = kds_id_armo_x_id_meca.getitemnumber(k_ind, "id_armo")
			
//--- se il lotto non è ancora stato caricato....			
			kst_tab_armo_prezzi.id_armo = ast_tab_armo.id_armo
			if NOT kuf1_armo_prezzi.if_esiste_x_id_armo(kst_tab_armo_prezzi) then

//--- carica Prezzi per la riga Lotto
				k_return += carica_prezzi_riga(ast_tab_armo)
				
			end if

		end for
			

	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	
return k_return

end function

private function long carica_prezzi_riga (st_tab_armo ast_tab_armo) throws uo_exception;//
//====================================================================
//=== Carica Prezzi Riga Lotto nelle Tabelle 
//=== 
//=== 
//===  input: st_tab_armo.id_armo
//===  Outout: il numero di righe caricate
//===  Rit: 
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return=0
long k_righe=0
integer k_ctr, k_ind_prezzo
boolean k_cond_ok
integer k_nr_condizioni
st_tab_meca kst_tab_meca
st_tab_listino kst_tab_listino
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi[]
st_tab_cond_fatt kst_tab_cond_fatt[3]
st_tab_armo_prezzi kst_tab_armo_prezzi
st_esito kst_esito
kuf_listino kuf1_listino
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
kuf_listino_voci kuf1_listino_voci
kuf_armo_prezzi kuf1_armo_prezzi
datastore kds_armo_prezzi, kds_listino_voci_pregruppo_prezzo
uo_exception kuo_exception


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	try

		if ast_tab_armo.id_armo > 0 then
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.sqlerrtext = "Errore generazione Prezzi riga Lotto (armo_prezzi). manca id riga (id_armo)"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)				
			throw kguo_exception
		end if			
			
//--- get del ID_MECA	
		if ast_tab_armo.id_meca > 0 then
		else
			kiuf_armo.get_id_meca(ast_tab_armo)
		end if
		
//--- get del id Listino e cliente		
		kuf1_listino = create kuf_listino
		kiuf_armo.get_id_listino(ast_tab_armo)
		kst_tab_listino.id = ast_tab_armo.id_listino
		kuf1_listino.get_cod_cli(kst_tab_listino)
	
//--- datastore x salvare i dati dei Prezzi	
		kds_armo_prezzi = create datastore
		kds_armo_prezzi.dataobject = "ds_armo_prezzi"
		kds_armo_prezzi.settransobject( kguo_sqlca_db_magazzino )
		
//--- verifica se i Prezzi nel Listino sono a VOCI oppure indicati direttamente nella modalità di origine		
		if kuf1_listino.if_attiva_listino_pregruppi(kst_tab_listino) then
			
//--- prezzi associati alle Voci			
			kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
			kst_tab_listino_link_pregruppi[1].id_listino = kst_tab_listino.id
			k_nr_condizioni = kuf1_listino_link_pregruppi.get_all_id_cond_fatt(kst_tab_listino_link_pregruppi[])
			k_ctr = 1
			k_cond_ok = false
			do while not k_cond_ok and k_ctr <= k_nr_condizioni
				kst_tab_listino.ID_COND_FATT_1 = kst_tab_listino_link_pregruppi[k_ctr].id_cond_fatt
				
				if kst_tab_listino.ID_COND_FATT_1 > 0 then
					k_cond_ok = kuf1_listino.if_id_cond_fatt_ok(kst_tab_listino, ast_tab_armo ) // condizione soddisfatta?
				else
					k_cond_ok = true
				end if
				k_ctr ++
				
			loop
			k_ctr --
//--- se condizione soddisfatta			
			if k_cond_ok then
				kuf1_listino_voci = create kuf_listino_voci
				
				kds_listino_voci_pregruppo_prezzo = create datastore
				kds_listino_voci_pregruppo_prezzo.dataobject = "ds_listino_voci_pregruppo_prezzo"
				kds_listino_voci_pregruppo_prezzo.settransobject(kguo_sqlca_db_magazzino)
//--- legge tabelle PREZZI e VOCI di Listino				
//				k_righe = kds_listino_voci_pregruppo_prezzo.retrieve(kst_tab_listino_link_pregruppi[k_ctr].id_listino_pregruppo )
				k_righe = kds_listino_voci_pregruppo_prezzo.retrieve(kst_tab_listino_link_pregruppi[k_ctr].id_listino_link_pregruppo )
				
				for k_ind_prezzo = 1 to k_righe

					kds_armo_prezzi.insertrow(0)
					kds_armo_prezzi.setitem(k_ind_prezzo, "id_armo", ast_tab_armo.id_armo )
					kds_armo_prezzi.setitem(k_ind_prezzo, "prezzo", kds_listino_voci_pregruppo_prezzo.getitemnumber(k_ind_prezzo, "prezzo"))
					kds_armo_prezzi.setitem(k_ind_prezzo, "id_listino_link_pregruppo", kst_tab_listino_link_pregruppi[k_ctr].id_listino_link_pregruppo)
					kds_armo_prezzi.setitem(k_ind_prezzo, "id_listino_voce", kds_listino_voci_pregruppo_prezzo.getitemnumber(k_ind_prezzo, "id_listino_voce"))
					kds_armo_prezzi.setitem(k_ind_prezzo, "tipo_calcolo", kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "tipo_calcolo"))
					kds_armo_prezzi.setitem(k_ind_prezzo, "tipo_listino", kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "tipo_listino"))

//--- se è un prezzo SPOT/A CORPO/IN ENTRATA carico subito i colli da fatturare					
					if kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "tipo_calcolo") = kuf1_listino_voci.kki_tipo_calcolo_spot &
					              or kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "tipo_calcolo") = kuf1_listino_voci.kki_tipo_calcolo_in_entrata then
						kst_esito = kiuf_armo.get_colli_entrati_riga(ast_tab_armo)
						if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd and  kst_esito.esito <> kkg_esito.db_wrn then
							kguo_exception.inizializza( )
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
						kds_armo_prezzi.setitem(k_ind_prezzo, "item_dafatt", ast_tab_armo.colli_2 )
					else
//--- 02.06.2015 se è un prezzo SPOT A CORPO carico subito Un collo da fatturare					
					 if kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "tipo_calcolo") = kuf1_listino_voci.kki_tipo_calcolo_spot_libero then
							kds_armo_prezzi.setitem(k_ind_prezzo, "item_dafatt", 1 )
						else
							kds_armo_prezzi.setitem(k_ind_prezzo, "item_dafatt", 0 )
						end if
					end if
					
					kds_armo_prezzi.setitem(k_ind_prezzo, "item_nofatt", 0 )
					kds_armo_prezzi.setitem(k_ind_prezzo, "item_fatt", 0 )

					if kds_listino_voci_pregruppo_prezzo.getitemstring(k_ind_prezzo, "differito") = kuf1_listino_voci.kki_differito_no then
						if kds_armo_prezzi.getitemnumber(k_ind_prezzo, "item_dafatt" ) > 0 then
							kds_armo_prezzi.setitem(k_ind_prezzo, "stato", kuf1_armo_prezzi.kki_stato_dafatt )
						else
							kds_armo_prezzi.setitem(k_ind_prezzo, "stato", kuf1_armo_prezzi.kki_stato_attesa )
						end if
					else
						kds_armo_prezzi.setitem(k_ind_prezzo, "stato", kuf1_armo_prezzi.kki_stato_potenziale )
					end if
					
				end for
			end if
			
			
//		else
////--- Prezzi registrati direttamente sul LISTINO (max 3)			
//			k_nr_condizioni = 3
//			kuf1_listino.get_prezzi(kst_tab_listino, kst_tab_cond_fatt[])
//			k_ctr = 1
//			k_cond_ok = false
//			do while not k_cond_ok or k_ctr > k_nr_condizioni
//				kst_tab_listino.ID_COND_FATT_1 = kst_tab_cond_fatt[k_ctr].id
//					
//				k_cond_ok = kuf1_listino.if_id_cond_fatt_ok(kst_tab_listino, ast_tab_armo ) // condizione soddisfatta?
//				k_ctr ++
//				
//			loop
//			if k_cond_ok then
//				k_ctr --   // il prezzo è l'item appena trovato meno 1
//				kds_armo_prezzi.insertrow(0)
//				kds_armo_prezzi.setitem(1, "id_armo", ast_tab_armo.id_armo )
//				kds_armo_prezzi.setitem(1, "id_listino_link_pregruppo", 0)
//				kds_armo_prezzi.setitem(1, "id_listino_voce", 0 )
//				kds_armo_prezzi.setitem(1, "tipo_calcolo", kuf1_listino_voci.kki_tipo_calcolo_spot )
//				kds_armo_prezzi.setitem(1, "tipo_listino", kst_tab_listino.tipo )
//				kds_armo_prezzi.setitem(1, "stato", kuf1_armo_prezzi.kki_stato_dafatt )
//				kds_armo_prezzi.setitem(1, "item_fatt", 0 )
//				kds_armo_prezzi.setitem(1, "item_nofatt", 0 )
//				kst_esito = kiuf_armo.get_colli_entrati_riga(ast_tab_armo)
//				if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.not_fnd and  kst_esito.esito <> kkg_esito.db_wrn then
//					kguo_exception.inizializza( )
//					kguo_exception.set_esito(kst_esito)
//					throw kguo_exception
//				end if
//				kds_armo_prezzi.setitem(1, "item_dafatt", ast_tab_armo.colli_2 )
//				choose case k_ctr
//					case 1
//						kds_armo_prezzi.setitem(1, "prezzo", kst_tab_listino.prezzo)
//					case 2
//						kds_armo_prezzi.setitem(1, "prezzo", kst_tab_listino.prezzo_2)
//					case 3
//						kds_armo_prezzi.setitem(1, "prezzo", kst_tab_listino.prezzo_3)
//				end choose
//			end if
//		end if

//--- se trovato prezzo allora carica i Prezzi
			if k_cond_ok then
			
				if kds_armo_prezzi.rowcount() > 0 then
				
// CARICA PREZZI X LA  RIGA LOTTO				
					kuf1_armo_prezzi = create kuf_armo_prezzi
					ast_tab_armo.st_tab_g_0.esegui_commit = "S"
					kuf1_armo_prezzi.tb_add_noaut(kds_armo_prezzi, ast_tab_armo.st_tab_g_0)
				
				end if
			
//--- lancia 'evento di carico' per i prezzi appena caricati
				kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = "S"
				kst_tab_armo_prezzi.id_armo = ast_tab_armo.id_armo 
				kuf1_armo_prezzi.esegui_evento_carico(kst_tab_armo_prezzi)
			end if
		end if
		
					

		k_return = kds_armo_prezzi.rowcount()


	catch (uo_exception kuo1_exception)
		throw kuo1_exception
	
	end try
	
return k_return

end function

public function st_esito get_id_memo (ref st_tab_meca_memo kst_tab_meca_memo);//
//====================================================================
//=== Torna  ID_MEMO da id_meca_memo
//=== 
//=== Input: st_tab_meca_memo non valorizzata     Output: st_tab_meca_memo.id_memo                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  ID_MEMO
       into :kst_tab_meca_memo.ID_MEMO
		 FROM meca_memo
		 where  ID_meca_MEMO = :kst_tab_meca_memo.ID_meca_MEMO
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Memo-Lotto entrato (id = " + string(kst_tab_meca_memo.ID_MEMO) + ") ~n~r:" + trim(sqlca.SQLErrText)
	end if

	if kst_tab_meca_memo.ID_MEMO > 0 then
	else
		kst_tab_meca_memo.ID_MEMO = 0
	end if

return kst_esito




end function

public subroutine memo_save (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception;//
//--- Salva dati MEMO perticolari per questo Settore
//
st_esito kst_esito
kuf_memo_allarme kuf1_memo_allarme


try   

	if trim(kist_tab_meca_memo.allarme) > " " then
	else
		kist_tab_meca_memo.allarme = kuf1_memo_allarme.kki_memo_allarme_no
	end if
	kist_tab_meca_memo.id_memo = ast_tab_meca_memo.id_memo
	kist_tab_meca_memo.st_tab_g_0 = ast_tab_meca_memo.st_tab_g_0
	kst_esito = tb_update(ast_tab_meca_memo)
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception	kuo_exception)
	throw kuo_exception
		
end try
	


end subroutine

public function boolean tb_delete (st_tab_meca_memo ast_tab_meca_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Cancella rek nella tabella MEMO
//--- 
//--- Input: st_tab_meca_memo.id_memo
//--- Ritorna  TRUE=OK; 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
boolean k_return = false
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w
//kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



if ast_tab_meca_memo.id_memo > 0 then
	
	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
	kst_open_w.id_programma = kkg_id_programma_anag
	
	
	delete 
			from meca_memo
			WHERE id_memo = :ast_tab_meca_memo.id_memo 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore Cancellazione fascicolo Lotto dal MEMO(id memo " + string(ast_tab_meca_memo.id_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			if ast_tab_meca_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_memo.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
			
		if ast_tab_meca_memo.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	end if


end if



return k_return

end function

public function st_esito get_id_meca_memo_max (ref st_tab_meca_memo kst_tab_meca_memo);//
//====================================================================
//=== Torna ultimo ID_MECA_MEMO da id_meca 
//=== 
//=== Input: st_tab_meca_memo id_meca e tipo_sv 
//=== Output: st_tab_meca_memo.id_meca_memo                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  max(ID_MECA_MEMO)
       into :kst_tab_meca_memo.ID_MECA_MEMO
		 FROM meca_memo
		 where  ID_meca = :kst_tab_meca_memo.ID_meca //and tipo_sv = :kst_tab_meca_memo.tipo_sv
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca max ID per Lotto in tab Memo-Lotto 2 entrato (id = " + string(kst_tab_meca_memo.ID_meca) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
	end if

	if kst_tab_meca_memo.ID_MECA_MEMO > 0 then
	else
		kst_tab_meca_memo.ID_MECA_MEMO = 0
	end if

return kst_esito




end function

public function st_esito tb_update (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception;//====================================================================
//=== Aggiunge rek nella tabella DATI di MEMO
//=== 
//=== Input: st_tab_meca_memo_web 
//=== output: id_meca_memo
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc, k_senza_dati
st_esito kst_esito
st_open_w kst_open_w
kuf_meca_memo kuf1_meca_memo
//st_tab_meca_memo kst_tab_meca_memo

try
		
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	//kuf_sicurezza kuf1_sicurezza
	
	if kst_tab_meca_memo.id_meca > 0 then
	else
		kst_esito.SQLErrText = "Tab.dati MEMO meca: nessun dato inserito (codice meca non impostato) "
		kst_esito.esito = kkg_esito.no_esecuzione
		if kst_tab_meca_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_memo.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	//	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	//	kst_open_w.id_programma = kkg_id_programma_anag_memo
	//	
	//	//--- controlla se utente autorizzato alla funzione in atto
	//	try
	//		k_rc = if_sicurezza(kst_open_w )
	//	catch (uo_exception kuo_exception)
	//		
	//	end try
	//	
	//	if not k_rc then
	//	
	//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	//		kst_esito.SQLErrText = "Modifica dati Memo non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	//		kst_esito.esito = kkg_esito.no_aut
	//	
	//	else
			
	kst_tab_meca_memo.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_meca_memo.x_utente = kGuf_data_base.prendi_x_utente()
		
	//		kst_tab_meca_memo.st_tab_meca_memo = st_tab_meca_memo
	//		this.if_isnull( kst_tab_meca_memo )
	//		st_tab_meca_memo = kst_tab_meca_memo.st_tab_meca_memo
	
			k_rcn = 0
			if kst_tab_meca_memo.id_memo > 0 then
				select distinct 1
					into :k_rcn
					from meca_memo
					WHERE id_memo = :kst_tab_meca_memo.id_memo 
					using kguo_sqlca_db_magazzino;
			end if
				
		//--- tento l'insert se manca in arch.
			if kguo_sqlca_db_magazzino.sqlcode  >= 0 then
	
				if k_rcn > 0 then
					UPDATE meca_memo  
							SET id_meca = :kst_tab_meca_memo.id_meca
								 ,tipo_sv =  :kst_tab_meca_memo.tipo_sv
								 ,allarme =  :kst_tab_meca_memo.allarme
								,x_datins = :kst_tab_meca_memo.x_datins
								,x_utente = :kst_tab_meca_memo.x_utente  
								WHERE id_memo = :kst_tab_meca_memo.id_memo 
								using kguo_sqlca_db_magazzino;
				else
					
					if NOT k_senza_dati then
						//id_meca_memo
						INSERT INTO meca_memo  
									(
									tipo_sv
									,id_memo
									,id_meca
									,allarme
									,x_datins 
									,x_utente 
									 )  
							  VALUES (  
								:kst_tab_meca_memo.tipo_sv
								,:kst_tab_meca_memo.id_memo 
								,:kst_tab_meca_memo.id_meca 
								,:kst_tab_meca_memo.allarme 
								,:kst_tab_meca_memo.x_datins
								,:kst_tab_meca_memo.x_utente  
								)  
							using kguo_sqlca_db_magazzino;
						if kguo_sqlca_db_magazzino.sqlcode = 0 then
							kuf1_meca_memo = create kuf_meca_memo
							kst_tab_meca_memo.id_meca_memo = kuf1_meca_memo.get_id_meca_memo_max( )
							//kst_tab_meca_memo.id_meca_memo = long(kguo_sqlca_db_magazzino.SQLReturnData)
		
						end if	
					end if
						
				end if
				
			end if	
		
		
			if kguo_sqlca_db_magazzino.sqlcode <> 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Tab.dati Memo:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if kguo_sqlca_db_magazzino.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
						if kst_tab_meca_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_memo.st_tab_g_0.esegui_commit) then
							kguo_sqlca_db_magazzino.db_rollback( )
						end if
					end if
				end if
			else
				if kst_tab_meca_memo.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_meca_memo.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
		
		
	//	end if
		
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_meca_memo) then destroy kuf1_meca_memo
	
		
end try

return kst_esito

end function

public subroutine get_id_memo_max_x_id_meca (ref st_tab_meca_memo kst_tab_meca_memo) throws uo_exception;//
//====================================================================
//=== Torna ultimo ID_MEMO x id_meca 
//=== 
//=== Input: st_tab_meca_memo id_meca 
//=== Output: st_tab_meca_memo.id_memo                  
//=== Ritorna ST_ESITO
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT  max(ID_MEMO)
       into :kst_tab_meca_memo.ID_MEMO
		 FROM meca_memo
		 where  ID_meca = :kst_tab_meca_memo.ID_meca //and tipo_sv = :kst_tab_meca_memo.tipo_sv
			using kguo_sqlca_db_magazzino;
	
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca max ID per Lotto in tab Memo-Lotto (id lotto = " + string(kst_tab_meca_memo.ID_meca) + ") ~n~r:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kst_tab_meca_memo.ID_MEMO > 0 then
	else
		kst_tab_meca_memo.ID_MEMO = 0
	end if





end subroutine

public function st_esito get_righe_da_sped (ref st_tab_armo kst_tab_armo[]);//
//--- Torna Righe Lotto da spedire
//--- Input: st_tab_armo[1].id_meca
//--- Out: st_tab_armo[] con le righe trovate, ST_ESITO
//
int k_ind
st_tab_armo kst_tab_armo_app, kst_tab_armo_null[] 
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_armo_app.id_meca = kst_tab_armo[1].id_meca

//--- inizializza la ARRAY da restituire
	kst_tab_armo[] = kst_tab_armo_null[] 
		

	 DECLARE c_get_righe_armo CURSOR FOR  
		  SELECT armo.id_armo,   
					armo.colli_2
			 FROM armo 
			 WHERE armo.id_meca = :kst_tab_armo_app.id_meca ;

	open c_get_righe_armo;
	if sqlca.sqlcode = 0 then

		k_ind=1
		fetch c_get_righe_armo into 
						:kst_tab_armo_app.id_armo
						,:kst_tab_armo_app.colli_2;
		
		do while sqlca.sqlcode = 0
			
			kst_tab_armo[k_ind].id_armo = kst_tab_armo_app.id_armo
			
			k_ind ++
			fetch c_get_righe_armo into 
						:kst_tab_armo_app.id_armo
						,:kst_tab_armo_app.colli_2;
						
		loop

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.d.d.t., Righe Lotto da spedire (id lotto=" + string( kst_tab_armo_app.id_meca) +") : " &
										 + trim(SQLCA.SQLErrText)
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

		close c_get_righe_armo;
	
	end if
		
return kst_esito


end function

private function long importa_wm_pklist_esegui (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Importa come Lotto un Packing List Mandante  
//=== 
//=== 
//===  input: st_tab_wm_pklist.id_wm_pklist 
//===  Outout: id_meca
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return = 0
boolean k_righe_pklist_trovate=false
long k_ctr=0, k_gruppo=0, k_ind_listino=0, k_ctr_righe_pkilst_lastupdate, k_ctr_righe_pklist, k_ind_riga_armo
date k_data_null 
kuf_armo kuf1_armo
kuf_wm_pklist_testa kuf1_wm_pklist_testa
kuf_wm_pklist_righe  kuf1_wm_pklist_righe 
kuf_clienti kuf1_clienti
kuf_contratti kuf1_contratti
kuf_listino kuf1_listino
kuf_prodotti kuf1_prodotti
kuf_ausiliari kuf1_ausiliari
kuf_armo_nt kuf1_armo_nt
kuf_wm_receiptgammarad kuf1_wm_receiptgammarad
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe[]
st_tab_m_r_f kst_tab_m_r_f
st_tab_contratti kst_tab_contratti
st_tab_clienti kst_tab_clienti
st_tab_listino kst_tab_listino[]
st_tab_prodotti kst_tab_prodotti
st_tab_wm_receiptgammarad kst_tab_wm_receiptgammarad[]
st_tab_armo_nt kst_tab_armo_nt
st_esito kst_esito, kst_esito_armo_nt
st_tab_meca_causali kst_tab_meca_causali


if kst_tab_wm_pklist.id_wm_pklist > 0 then
	
	try
	
		kuf1_wm_pklist_testa = create kuf_wm_pklist_testa
		kuf1_wm_pklist_righe  = create kuf_wm_pklist_righe 
		kuf1_clienti = create kuf_clienti
		kuf1_contratti = create kuf_contratti
		kuf1_listino = create kuf_listino
		kuf1_prodotti = create kuf_prodotti
		kuf1_wm_receiptgammarad = create kuf_wm_receiptgammarad
		kuf1_armo = create kuf_armo
		kuf1_ausiliari = create kuf_ausiliari
		
		if kuf1_wm_pklist_testa.tb_select( kst_tab_wm_pklist ) then // legge la testata del PKLIST 

//---- Leggo le righe Paking x salvarle in un array		
			kst_tab_wm_pklist_righe[1].id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
			k_ctr = kuf1_wm_pklist_righe.tb_select_x_id_wm_pklist(kst_tab_wm_pklist_righe[]) // legge le righe del PKLIST 
			if k_ctr > 0 then 
				k_righe_pklist_trovate = true
				kst_tab_wm_pklist_righe[k_ctr + 1].id_wm_pklist_riga = 0 // aggiunto un item x uscire dal ciclo
				kst_tab_wm_pklist_righe[k_ctr + 1].gruppo = 0
			end if

//--- Get del Ricevente e Fatturato
			kst_tab_m_r_f.clie_1 = kst_tab_wm_pklist.clie_1
			if  isnull(kst_tab_wm_pklist.clie_2)  then 
				kst_tab_wm_pklist.clie_2 = 0
			end if
			kst_tab_m_r_f.clie_2 = kst_tab_wm_pklist.clie_2
			if  isnull(kst_tab_wm_pklist.clie_3)  then 
				kst_tab_wm_pklist.clie_3 = 0
			end if
			kst_tab_m_r_f.clie_3 = kst_tab_wm_pklist.clie_3
			if kst_tab_m_r_f.clie_2 > 0  then
			else
				kst_esito = kuf1_clienti.get_mrf_clie_2(kst_tab_m_r_f)
				if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and kst_esito.esito <> kkg_esito.not_fnd then
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				if kst_tab_m_r_f.clie_2 > 0 then
					kst_tab_wm_pklist.clie_2 = kst_tab_m_r_f.clie_2
				else
					kst_tab_wm_pklist.clie_2 = kst_tab_wm_pklist.clie_1
				end if
			end if
			if kst_tab_m_r_f.clie_3 > 0 then
			else
				kst_esito = kuf1_clienti.get_mrf_clie_3(kst_tab_m_r_f)
				if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and kst_esito.esito <> kkg_esito.not_fnd then
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				if kst_tab_m_r_f.clie_3 > 0 then
					kst_tab_wm_pklist.clie_3 = kst_tab_m_r_f.clie_3
				else
					kst_tab_wm_pklist.clie_3 = kst_tab_m_r_f.clie_1
				end if
			end if
			
//--- Get del Contratto
			if (len(trim(kst_tab_wm_pklist.sc_cf)) > 0 or len(trim(kst_tab_wm_pklist.mc_co)) > 0) and kst_tab_wm_pklist.clie_3 > 0 then
				kst_tab_contratti.sc_cf = kst_tab_wm_pklist.sc_cf
				kst_tab_contratti.mc_co = kst_tab_wm_pklist.mc_co
				kst_tab_contratti.cod_cli = kst_tab_wm_pklist.clie_3
				kst_tab_contratti.data_scad = date(0)
				kst_esito = kuf1_contratti.get_codice_da_cf_co(kst_tab_contratti )
				if kst_esito.esito <> kkg_esito.ok then  //24-08-2017
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0

//--- Get del eventuale Causale di Blocco impostata sul CLIENTE
			kist_tab_meca.id_meca_causale = 0
			if kst_tab_wm_pklist.clie_3 > 0 then
				kst_tab_clienti.codice = kst_tab_wm_pklist.clie_3 
				kist_tab_meca.id_meca_causale = kuf1_clienti.get_id_meca_causale(kst_tab_clienti)
			end if
			if kist_tab_meca.id_meca_causale = 0 then // ha la precedenza la CAUSALE del cliente
//--- Get del eventuale Causale di Blocco impostata da Contratto
				if kst_tab_contratti.codice > 0 then
					kist_tab_meca.id_meca_causale = kuf1_contratti.get_id_meca_causale(kst_tab_contratti)
				end if
			end if
			kist_tab_meca.meca_blk_descrizione = "" 
			kist_tab_meca.meca_blk_rich_autorizz = ""
			kist_tab_meca.stato = kiuf_armo.ki_meca_stato_gen_da_completare 
			if kist_tab_meca.id_meca_causale > 0 then 
				kst_tab_meca_causali.id_meca_causale = kist_tab_meca.id_meca_causale
				kst_esito = kuf1_ausiliari.tb_select(kst_tab_meca_causali)
				if kst_esito.esito = kkg_esito.ok then
					kist_tab_meca.meca_blk_descrizione = trim(kst_tab_meca_causali.descrizione) + " (automatico da PKL) "
					kist_tab_meca.meca_blk_rich_autorizz = trim(kst_tab_meca_causali.rich_autorizz)
					kist_tab_meca.stato = kst_tab_meca_causali.cod_blk 
				end if
			end if

//--- Get del Listino
			if kst_tab_contratti.codice > 0 and kst_tab_wm_pklist.clie_3 > 0 then
				kst_tab_listino[1].cod_cli =  kst_tab_wm_pklist.clie_3
				kst_tab_listino[1].contratto = kst_tab_contratti.codice
				kuf1_listino.get_id_listini(kst_tab_listino[])
			end if

//--- Get dell'area Magazzino, ovviamente solo del primo barcode
			if k_righe_pklist_trovate then 
				kst_tab_wm_receiptgammarad[1].id_meca = 0
				kst_tab_wm_receiptgammarad[1].externalpalletcode = trim(kst_tab_wm_pklist_righe[1].wm_barcode)
				if kuf1_wm_receiptgammarad.get_area_magazzino( kst_tab_wm_receiptgammarad[] ) then
					kst_tab_wm_pklist_righe[1].areamag = kst_tab_wm_receiptgammarad[1].area_mag_trim
				end if
			end if
			
//--- riempio tutti i campi della Testata lotto			
			kist_tab_meca.id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
			if k_righe_pklist_trovate then kist_tab_meca.area_mag = kst_tab_wm_pklist_righe[1].areamag 
			kist_tab_meca.clie_1 = kst_tab_wm_pklist.clie_1
			kist_tab_meca.clie_2 = kst_tab_wm_pklist.clie_2
			kist_tab_meca.clie_3 = kst_tab_wm_pklist.clie_3
			kist_tab_meca.contratto = kst_tab_contratti.codice
			kist_tab_meca.data_bolla_in = kst_tab_wm_pklist.dtddt
			kist_tab_meca.num_bolla_in = kst_tab_wm_pklist.nrddt
			setnull(kist_tab_meca.consegna_data)
		 	kist_tab_meca.stato_in_attenzione = kuf1_armo.kki_STATO_IN_ATTENZIONE_ON
			kist_tab_meca.num_int = 0
			kist_tab_meca.id = 0
			kist_tab_meca.st_tab_g_0.esegui_commit = "N"

//--- Insert del Nuovo Lotto / Riferimento
			kist_tab_meca.id = carica_lotto_testa()
			
//--- aggiorna lo stato della Packing		
			kst_tab_wm_pklist.st_tab_g_0.esegui_commit = "N"
			kst_esito = kuf1_wm_pklist_testa.set_stato_importato(kst_tab_wm_pklist)
			if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
				//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if

				
			if k_righe_pklist_trovate then

//--- riempio tutti i campi delle righe lotto	
				k_ind_riga_armo = 1
				k_ctr_righe_pklist = 1
				k_ctr_righe_pkilst_lastupdate = 1
				do while  kst_tab_wm_pklist_righe[k_ctr_righe_pklist].id_wm_pklist_riga > 0  
				
					kist_tab_armo.colli_2 = 0 
//--- Raggruppo + righe di Packing-List per fare una riga di Magazzino (riga LOTTO)
					k_gruppo = kst_tab_wm_pklist_righe[k_ctr_righe_pklist].gruppo
					do while  kst_tab_wm_pklist_righe[k_ctr_righe_pklist].id_wm_pklist_riga > 0 &
								and (kst_tab_wm_pklist_righe[k_ctr_righe_pklist].gruppo = k_gruppo or k_gruppo = 0)

//						kist_tab_armo.colli_2 += kst_tab_wm_pklist_righe[k_ctr_righe_pklist].colli   // cancellato perche' x gestire ARAN qui ora ci mettono il nr scatole!!
						kist_tab_armo.colli_2 ++
						
						k_ctr_righe_pklist++
					loop
					
					 
//--- Trovo il primo Articolo che è OK	
					try
						kst_esito.esito = ""
						k_ind_listino = 1
						kuf1_listino.get_dati_x_armo(kst_tab_listino[k_ind_listino])
						if trim(kst_tab_listino[k_ind_listino].cod_art) > " " then
							kst_tab_prodotti.codice = kst_tab_listino[k_ind_listino].cod_art
							kst_esito = kuf1_prodotti.get_gruppo(kst_tab_prodotti)
							if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and  kst_esito.esito <> kkg_esito.not_fnd then
								//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
								kguo_exception.set_esito(kst_esito)
								throw kguo_exception
							end if
						else
							kst_tab_prodotti.gruppo = 0
						end if

//--- se in packing ho indicato il GRUPPO allora deve metchare 
						if kst_tab_wm_pklist_righe[k_ctr_righe_pklist].gruppo > 0 then
							do while kst_tab_prodotti.gruppo <> k_gruppo and  kst_esito.esito <> kkg_esito.not_fnd
							
								k_ind_listino ++
								if k_ind_listino > kst_tab_listino[1].st_tab_g_0.contati then
									//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
									kst_esito.sqlerrtext = "Il GRUPPO indicato sul PKL " + string(kst_tab_wm_pklist_righe[k_ctr_righe_pklist].gruppo) + " e' diverso da quello dell'articolo! "
									kguo_exception.inizializza()
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
								end if
								
								kuf1_listino.get_dati_x_armo(kst_tab_listino[k_ind_listino])
								if trim(kst_tab_listino[k_ind_listino].cod_art) > " " then
									kst_tab_prodotti.codice = kst_tab_listino[k_ind_listino].cod_art
									kst_esito = kuf1_prodotti.get_gruppo(kst_tab_prodotti)
									if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and  kst_esito.esito <> kkg_esito.not_fnd then
										//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
										kguo_exception.set_esito(kst_esito)
										throw kguo_exception
									end if
								end if
							loop
						end if
					catch (uo_exception kuo_exception)
						//kguo_sqlca_db_magazzino.db_rollback( ) //--- Rollback delle Modifiche
						throw kuo_exception
					end try
					
//--- Get del Codice Piano di Trattamento						
					kst_tab_contratti.codice = kst_tab_listino[k_ind_listino].contratto
					kst_esito = kuf1_contratti.get_sl_pt(kst_tab_contratti)
					if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and  kst_esito.esito <> kkg_esito.not_fnd then
						//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
					if kst_esito.esito <> kkg_esito.ok then kst_tab_contratti.sl_pt = ""

//--- Get Descrizione Prodotto 
					kst_tab_prodotti.codice = kst_tab_listino[k_ind_listino].cod_art
					kst_esito = kuf1_prodotti.get_des(kst_tab_prodotti)
					if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn and  kst_esito.esito <> kkg_esito.not_fnd then
						//kGuf_data_base.db_rollback_1( ) //--- Rollback delle Modifiche
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if

					kist_tab_armo.id_armo =  0 
					kist_tab_armo.id_meca = kist_tab_meca.id   
					kist_tab_armo.num_int = kist_tab_meca.num_int
					kist_tab_armo.data_int = kist_tab_meca.data_int
					kist_tab_armo.art = kst_tab_listino[k_ind_listino].cod_art  
					kist_tab_armo.colli_1 = kist_tab_armo.colli_2   
					if  kst_tab_listino[k_ind_listino].occup_ped > 0 then
						kist_tab_armo.pedane = kist_tab_armo.colli_2   *  (kst_tab_listino[k_ind_listino].occup_ped / 100)
					else
						kist_tab_armo.pedane = 0
					end if
					kist_tab_armo.campione = kst_tab_listino[k_ind_listino].campione
					kist_tab_armo.cod_sl_pt = kst_tab_contratti.sl_pt
					kist_tab_armo.colli_fatt = 0
					kist_tab_armo.dose = kst_tab_listino[k_ind_listino].dose
					kist_tab_armo.id_listino = kst_tab_listino[k_ind_listino].id
					kist_tab_armo.larg_1 = kst_tab_listino[k_ind_listino].mis_z
					kist_tab_armo.lung_1 = kst_tab_listino[k_ind_listino].mis_x
					kist_tab_armo.alt_1 =  kst_tab_listino[k_ind_listino].mis_y
					kist_tab_armo.larg_2 = kst_tab_listino[k_ind_listino].mis_z
					kist_tab_armo.lung_2 = kst_tab_listino[k_ind_listino].mis_x
					kist_tab_armo.alt_2 = kst_tab_listino[k_ind_listino].mis_y
					kist_tab_armo.m_cubi = ((kist_tab_armo.larg_2/1000) * (kist_tab_armo.lung_2/1000) * (kist_tab_armo.alt_2/1000)) * kist_tab_armo.colli_2
					kist_tab_armo.magazzino = kst_tab_listino[k_ind_listino].magazzino
					kist_tab_armo.peso_kg = 0
					if kist_tab_armo.colli_2 > 0 and kst_tab_listino[k_ind_listino].peso_kg > 0 then
						kist_tab_armo.peso_kg = kist_tab_armo.colli_2 * kst_tab_listino[k_ind_listino].peso_kg
					end if


//--- Get delle note lotto da caricare nelle NOTE dell'entrata (SOLO sulla prima riga)
					kist_tab_armo.note_2 = ""
					if k_ind_riga_armo = 1 then
						kuf1_wm_pklist_testa.get_note_lotto(kst_tab_wm_pklist )
						if len(trim(kst_tab_wm_pklist.note_lotto)) > 0 then
							kst_tab_wm_pklist.note_lotto = trim(kst_tab_wm_pklist.note_lotto ) + space(1024)
							kst_tab_armo_nt.note[10] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 9 + 1))
							kst_tab_armo_nt.note[9] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 8 + 1),53)
							kst_tab_armo_nt.note[8] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 7 + 1),53)
							kst_tab_armo_nt.note[7] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 6 + 1),53)
							kst_tab_armo_nt.note[6] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 5 + 1),53)
							kst_tab_armo_nt.note[5] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 4 + 1),53)
							kst_tab_armo_nt.note[4] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 3 + 1),53)
							kst_tab_armo_nt.note[3] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 2 + 1),53)
							kst_tab_armo_nt.note[2] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 1 + 1),53)
							kst_tab_armo_nt.note[1] = mid(kst_tab_wm_pklist.note_lotto,(51 * 3 + 53 * 0 + 1),53)
							kist_tab_armo.note_3 = mid(kst_tab_wm_pklist.note_lotto,(51 * 2 + 1),51)
							kist_tab_armo.note_2 = mid(kst_tab_wm_pklist.note_lotto,(51 * 1 + 1),51)
							kist_tab_armo.note_1 = mid(kst_tab_wm_pklist.note_lotto,(51 * 0 + 1),51)
						else
							kist_tab_armo.note_2 = trim(kst_tab_prodotti.des)
						end if
					end if
			
					if kist_tab_meca.id_meca_causale = 0 then // se diverso da ZERO Blocca il LOTTO
						kist_tab_armo.stato = kiuf_armo.ki_meca_stato_sblk 		
					else
						kist_tab_armo.stato = kiuf_armo.ki_meca_stato_blk 		
					end if
					kist_tab_armo.travaso = "N"
					kist_tab_armo.st_tab_g_0.esegui_commit = "N"
					
//--- Insert della nuova riga nel Lotto					
					kist_tab_armo.id_armo = carica_lotto_riga( ) 
					k_ind_riga_armo ++

//--- Se ho delle note da scrivere lo faccio subito
					if len(trim(kst_tab_armo_nt.note[1])) > 0 then
						try
							kst_tab_armo_nt.id_armo = kist_tab_armo.id_armo
							
							kst_tab_armo_nt.st_tab_g_0.esegui_commit = kist_tab_meca.st_tab_g_0.esegui_commit 
							kuf1_armo_nt = create kuf_armo_nt
							kuf1_armo_nt.tb_update_armo_nt(kst_tab_armo_nt)  // Insert delle note
						catch (uo_exception kuo1_exception)
							kst_esito_armo_nt = kuo1_exception.get_st_esito()
						end try							
					end if


//--- Aggiorna ogni singola riga del Packing						
					for k_ctr = k_ctr_righe_pkilst_lastupdate to (k_ctr_righe_pklist - 1) step 1

						kst_tab_wm_pklist_righe[k_ctr].st_tab_g_0.esegui_commit = "N"
						kst_tab_wm_pklist_righe[k_ctr].id_meca = kist_tab_meca.id 						
						kst_tab_wm_pklist_righe[k_ctr].id_armo = kist_tab_armo.id_armo
						if kst_tab_wm_pklist_righe[k_ctr].gruppo > 0 then
						else
							kst_tab_wm_pklist_righe[k_ctr].gruppo = kst_tab_prodotti.gruppo
						end if
						kst_esito = kuf1_wm_pklist_righe.set_dati_lotto(kst_tab_wm_pklist_righe[k_ctr])
						if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
							kguo_exception.set_esito(kst_esito)
						end if
						kst_esito = kuf1_wm_pklist_righe.set_stato_importato(kst_tab_wm_pklist_righe[k_ctr])
						if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
							kguo_exception.set_esito(kst_esito)
						end if
					
					next
					k_ctr_righe_pkilst_lastupdate = k_ctr_righe_pklist
					
					
				loop
				
			end if

//---- Imposta le Note a OK		
			kst_tab_wm_pklist.note = "Caricato nel Lotto num. " + string(kist_tab_meca.num_int) + " del " + string(kist_tab_meca.data_int) &
			                            + " alle " + string(kguo_g.get_datetime_current( ), "hh:mm")
			kuf1_wm_pklist_testa.set_add_note(kst_tab_wm_pklist)

//--- Commit delle Modifiche
			kst_esito = kguo_sqlca_db_magazzino.db_commit( )
			if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		
			if kist_tab_meca.id > 0 then
				k_return = kist_tab_meca.id 
			end if
		
		end if
	
	
	catch (uo_exception kuo2_exception)
//--- Rollback delle Modifiche (24-08-2017)
		kguo_sqlca_db_magazzino.db_rollback( )
		kuo2_exception.kist_esito.sqlerrtext = "Errore durante 'Importazione Packing List'~n~r" + kuo2_exception.kist_esito.sqlerrtext
//		kst_esito.sqlerrtext = "Errore durante Importazione del Packing List~n~r" + kst_esito.sqlerrtext
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
		throw kuo2_exception
		
	
	finally
//--- Rollback delle Modifiche
//24-08-2017		kst_esito = kGuf_data_base.db_rollback_1( )
//		if kst_esito.esito <> kkg_esito.ok and  kst_esito.esito <> kkg_esito.db_wrn then
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if
//
		if isvalid(kuf1_wm_pklist_testa) then destroy kuf1_wm_pklist_testa
		if isvalid(kuf1_wm_pklist_righe) then destroy kuf1_wm_pklist_righe 
		if isvalid(kuf1_clienti) then destroy kuf1_clienti
		if isvalid(kuf1_contratti) then destroy kuf1_contratti
		if isvalid(kuf1_listino) then destroy kuf1_listino
		if isvalid(kuf1_prodotti) then destroy kuf1_prodotti
		if isvalid(kuf1_wm_receiptgammarad) then destroy kuf1_wm_receiptgammarad
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari

	end try
	
end if
	
return k_return

end function

public function long importa_wm_pklist (ref st_tab_wm_pklist kst_tab_wm_pklist) throws uo_exception;//
//====================================================================
//=== Importa come Lotto un Packing List Mandante  
//=== 
//=== 
//===  input: st_tab_wm_pklist.id_wm_pklist 
//===  Outout: id_meca generato
//===  Lancia EXCEPTION con  ST_ESITO
//===                                     
//====================================================================
//
long k_return = 0
boolean k_righe_pklist_trovate=false
st_wm_pklist kst_wm_pklist
kuf_wm_pklist kuf1_wm_pklist
st_esito kst_esito


if kst_tab_wm_pklist.id_wm_pklist > 0 then
	
	try
	
		
		kuf1_wm_pklist = create kuf_wm_pklist
		
		kst_wm_pklist.st_tab_wm_pklist.id_wm_pklist = kst_tab_wm_pklist.id_wm_pklist
		
//--- Controlla se è da Importare		
		if kuf1_wm_pklist.if_da_importare( kst_wm_pklist ) then 
			
//--- se OK allora IMPORTA!			
			k_return = importa_wm_pklist_esegui(kst_tab_wm_pklist)
			
		else

			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Packing-list è già stato importato (id=" + string (kst_tab_wm_pklist.id_wm_pklist) + ") precedentemente. "
			kguo_exception.set_esito(kst_esito)
		
		end if
	
	catch (uo_exception kuo_exception)
		throw kuo_exception
	
	finally

		destroy kuf1_wm_pklist

	end try
	
end if
	
return k_return

end function

public subroutine update_post_stampa_attestato (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Esegue operazioni dopo la stampa dell'attestato
//---
int k_ctr=0
st_tab_armo kst_tab_armo[]
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_contratti kst_tab_contratti
kuf_meca_qtna kuf1_meca_qtna
kuf_contratti kuf1_contratti
kuf_armo_prezzi kuf1_armo_prezzi

try  

//--- Chiude eventuale spedizione in QUARANTENA 
	kuf1_meca_qtna = create kuf_meca_qtna
	kst_tab_meca_qtna.id_meca = kst_tab_meca.id
	kuf1_meca_qtna.chiudi_no_ifsicurezza(kst_tab_meca_qtna)

//--- Leggo contratto del Lotto
	kst_tab_meca.contratto = kiuf_armo.get_contratto(kst_tab_meca)
	if kst_tab_meca.contratto > 0 then
		kuf1_contratti = create kuf_contratti
		kst_tab_contratti.codice = kst_tab_meca.contratto
		kst_tab_contratti.flg_fatt_dopo_valid = kuf1_contratti.get_flg_fatt_dopo_valid(kst_tab_contratti)
		if kst_tab_contratti.flg_fatt_dopo_valid = kuf1_contratti.kki_flg_fatt_dopo_valid_SI then
			kst_tab_armo[1].id_meca =  kst_tab_meca.id
			kiuf_armo.get_righe(kst_tab_armo[])
			kuf1_armo_prezzi = create kuf_armo_prezzi
			
			for k_ctr = 1 to upperbound(kst_tab_armo[])
				if kst_tab_armo[k_ctr].id_armo > 0 then
					
//--- Attiva fatturazione x le Voci Prezzi Lotto
					kst_tab_armo_prezzi.id_armo = kst_tab_armo[k_ctr].id_armo
					kuf1_armo_prezzi.set_dafatt_x_id_armo_no_ifsicurezza(kst_tab_armo_prezzi)

				end if
			end for
			
		end if
	end if
	
//--- FUNZIONE SOSPESA FINO AL COMPLETAMENTO DEL PASSAGGIO A E1: Chiude LOTTO al termine della stampa ATTESTATO come richiesto da E1	
//	if kguo_g.if_e1_enabled( ) then
//		kiuf_armo.set_lotto_chiudi(kst_tab_meca)
//	end if
	
catch (uo_exception kuo_exception1)
	throw kuo_exception1
	
finally
	if isvalid(kuf1_meca_qtna) then destroy kuf1_meca_qtna
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	if isvalid(kuf1_armo_prezzi) then destroy kuf1_armo_prezzi

end try
				


end subroutine

public subroutine update_post_delete_attestato (st_tab_meca kst_tab_meca) throws uo_exception;//---
//--- Esegue operazioni dopo la RIMOZIONE dell'attestato
//---
int k_ctr=0
st_tab_armo kst_tab_armo[]
st_tab_armo_prezzi kst_tab_armo_prezzi
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_contratti kst_tab_contratti
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
kuf_meca_qtna kuf1_meca_qtna
kuf_armo kuf1_armo
kuf_contratti kuf1_contratti
kuf_armo_prezzi kuf1_armo_prezzi
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014

try  

//--- Rimuove eventuale Chiusura di spedizione in QUARANTENA 
	kuf1_meca_qtna = create kuf_meca_qtna
	kst_tab_meca_qtna.id_meca = kst_tab_meca.id
	kuf1_meca_qtna.chiudi_rimuovi_dati_no_ifsicurezza(kst_tab_meca_qtna)
				
	kuf1_armo = create kuf_armo
//--- Leggo contratto del Lotto
	kst_tab_meca.contratto = kuf1_armo.get_contratto(kst_tab_meca)
	if kst_tab_meca.contratto > 0 then
		kuf1_contratti = create kuf_contratti
		kst_tab_contratti.codice = kst_tab_meca.contratto
		kst_tab_contratti.flg_fatt_dopo_valid = kuf1_contratti.get_flg_fatt_dopo_valid(kst_tab_contratti)
		if kst_tab_contratti.flg_fatt_dopo_valid = kuf1_contratti.kki_flg_fatt_dopo_valid_SI then
			kst_tab_armo[1].id_meca =  kst_tab_meca.id
			kiuf_armo.get_righe(kst_tab_armo[])
			kuf1_armo_prezzi = create kuf_armo_prezzi
			
			for k_ctr = 1 to upperbound(kst_tab_armo[])
				if kst_tab_armo[k_ctr].id_armo > 0 then
					
//--- Rimette stato a Potenziale x le Voci Prezzi Lotto DaFattt
					kst_tab_armo_prezzi.id_armo = kst_tab_armo[k_ctr].id_armo
					kuf1_armo_prezzi.reset_dafatt_x_id_armo_no_ifsicurezza(kst_tab_armo_prezzi)

				end if
			end for
			
		end if
	end if

//--- Rimuove la riga E1 (E1_WO_F5548014) ancora da inviare
	kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
	if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
		kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
		kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_qtdata
		if NOT kuf1_e1_wo_f5548014.u_get_e1updts(kst_tab_e1_wo_f5548014) then  // se non è ancora stato INVIATO a E1 cancello la riga
			kuf1_e1_wo_f5548014.tb_delete(kst_tab_e1_wo_f5548014)
		end if
	end if
				
catch (uo_exception kuo_exception1)
	throw kuo_exception1
	
finally
	if isvalid(kuf1_meca_qtna) then destroy kuf1_meca_qtna
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_contratti) then destroy kuf1_contratti
	if isvalid(kuf1_armo_prezzi) then destroy kuf1_armo_prezzi

end try
				


end subroutine

on kuf_armo_inout.create
call super::create
end on

on kuf_armo_inout.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuf_armo = create kuf_armo
end event

event destructor;call super::destructor;//
destroy kiuf_armo
end event

