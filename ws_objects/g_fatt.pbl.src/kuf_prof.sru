$PBExportHeader$kuf_prof.sru
forward
global type kuf_prof from kuf_parent
end type
end forward

global type kuf_prof from kuf_parent
end type
global kuf_prof kuf_prof

type variables

//--- valori x fattura presente in profis
public constant integer kki_fattura_in_profis_si = 1
public constant integer kki_fattura_in_profis_no = 0
public constant integer kki_fattura_in_profis_non_rilev = 2

//--- colonna PROFIS
public constant string kki_fattura_profis_cont_si = 'S'
public constant string kki_fattura_profis_cont_no = 'N'

private w_profis_exp_fatt kiw_profis_exp_fatt		// piccola window con i parametri di filtro


end variables

forward prototypes
public function st_esito get_riga (ref st_tab_prof kst_tab_prof)
public function integer if_fattura_presente (ref st_tab_prof kst_tab_prof) throws uo_exception
public function st_esito tb_delete (st_tab_prof kst_tab_prof)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_prof kst_tab_prof)
public function st_esito tb_add (st_tab_prof kst_tab_prof)
public function boolean crea_movimenti (st_tab_prof kst_tab_prof) throws uo_exception
public function boolean if_gia_trasferiti (ref st_tab_prof kst_tab_prof) throws uo_exception
public function st_esito tb_update_num_data_fatt (st_tab_prof kst_tab_prof_old, st_tab_prof kst_tab_prof)
public function boolean get_id_fattura_da_num_anno (ref ust_tab_prof aust_tab_prof) throws uo_exception
public function boolean set_profis (st_tab_prof ast_tab_prof) throws uo_exception
public function boolean set_fatture_esportate (st_tab_prof ast_tab_prof[]) throws uo_exception
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function boolean if_f_splitpayment (st_tab_prof kst_tab_prof) throws uo_exception
end prototypes

public function st_esito get_riga (ref st_tab_prof kst_tab_prof);//
//====================================================================
//=== 
//=== Leggo record PROFIS x numero+data fattura+conto+s-conto+iva
//=== 
//=== Ritorna tab. ST_ESITO, come standard
//===                                     
//=== 
//====================================================================
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


select 
		flag
		,importo
		,tipo_doc
		,cod_pag
		,profis
		,p_iva
 into 
		:kst_tab_prof.flag
		,:kst_tab_prof.importo
		,:kst_tab_prof.iva
		,:kst_tab_prof.tipo_doc
		,:kst_tab_prof.cod_pag
		,:kst_tab_prof.profis
		,:kst_tab_prof.p_iva
	from prof
	where 
		num_fatt = :kst_tab_prof.num_fatt
		and data_fatt = :kst_tab_prof.data_fatt
		and conto = :kst_tab_prof.conto
		and s_conto = :kst_tab_prof.s_conto
		and iva = :kst_tab_prof.iva
	using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.PROF:" + trim(sqlca.SQLErrText)
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


return kst_esito

end function

public function integer if_fattura_presente (ref st_tab_prof kst_tab_prof) throws uo_exception;//
//====================================================================
//=== 
//=== Verifica presenza della Fattura in PROFIS x numero+data fattura
//=== 
//=== Ritorna boolean TRUE presente 
//=== scatena un errore se DB KO                                    
//=== 
//====================================================================
//
integer k_return = kki_fattura_in_profis_no
integer k_ctr=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


select count(*)
 into 
	:k_ctr
	from prof
	where 
		num_fatt = :kst_tab_prof.num_fatt
		and data_fatt = :kst_tab_prof.data_fatt
	using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.PROF:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception		
	end if

	if k_ctr > 0 then
		k_return = kki_fattura_in_profis_si
	end if

return k_return

end function

public function st_esito tb_delete (st_tab_prof kst_tab_prof);//
//====================================================================
//=== Cancella i rek della Fattura/N.C. nella tabella PROFIS
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     vedi standard
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito, kst_esito_1
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
//	kst_open_w.id_programma = kkg_id_programma_profis_l
//	
//	//--- controlla se utente autorizzato alla funzione in atto
//	kuf1_sicurezza = create kuf_sicurezza
//	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//	destroy kuf1_sicurezza
//	
//	if not k_autorizza then
//	
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Cancellazione riga PROFIS non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//		kst_esito.esito = kkg_esito.no_aut
//	
//	else

		if (kst_tab_prof.conto = 0 or isnull(kst_tab_prof.conto)) and (kst_tab_prof.s_conto = 0 or isnull(kst_tab_prof.s_conto)) then

			delete from prof
				where num_fatt = :kst_tab_prof.num_fatt
					and data_fatt =  :kst_tab_prof.data_fatt
				using sqlca;
		else	
			delete from prof
				where num_fatt = :kst_tab_prof.num_fatt
					and data_fatt =  :kst_tab_prof.data_fatt
					and conto =  :kst_tab_prof.conto
					and s_conto =  :kst_tab_prof.s_conto
					and importo =  :kst_tab_prof.importo
				using sqlca;
		end if		
		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione riga PROFIS (prof):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		else
	
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
//	end if


return kst_esito


end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_prof kst_tab_prof);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
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
kst_open_w.id_programma = kkg_id_programma_fatture

////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

	if kst_tab_prof.num_fatt > 0 then

		kdw_anteprima.dataobject = "d_prof_l_fatt"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_prof.num_fatt, kst_tab_prof.data_fatt)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Movimenti Contabili non presenti: ~n~r" + "nessun numero indicato"
		kst_esito.esito = kkg_esito.not_fnd
		
	end if
//end if


return kst_esito

end function

public function st_esito tb_add (st_tab_prof kst_tab_prof);//
//====================================================================
//=== Carica i rek della Fattura/N.C. nella tabella PROFIS
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     vedi standard
//=== 
//====================================================================
st_tab_prof kst_tab_prof_prec
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito, kst_esito_1
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	kst_open_w.id_programma = kkg_id_programma_profis_l
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_autorizza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Inserimento riga PROFIS non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
	
	else

		if isnull(kst_tab_prof.IMPORTO) then kst_tab_prof.IMPORTO = 0

		select distinct PROF.IMPORTO
				into   :kst_tab_prof_prec.IMPORTO
				from   PROF
				where  PROF.NUM_FATT   = :kst_tab_prof.NUM_FATT   and
						 PROF.DATA_FATT  = :kst_tab_prof.DATA_FATT  and
						 PROF.CONTO      = :kst_tab_prof.CONTO      and
						 PROF.S_CONTO    = :kst_tab_prof.S_CONTO    and
						 PROF.IVA        = :kst_tab_prof.IVA
				using sqlca;

		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura riga PROFIS (prof):" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		else
			if sqlca.sqlcode = 0 then
			
      	   		kst_tab_prof.IMPORTO = kst_tab_prof.IMPORTO + kst_tab_prof_prec.IMPORTO

				update PROF
					set
							 PROF.IMPORTO    = :kst_tab_prof.IMPORTO
					where  PROF.NUM_FATT   = :kst_tab_prof.NUM_FATT   and
							 PROF.DATA_FATT  = :kst_tab_prof.DATA_FATT  and
							 PROF.CONTO      = :kst_tab_prof.CONTO      and
							 PROF.S_CONTO    = :kst_tab_prof.S_CONTO    and
							 PROF.IVA        = :kst_tab_prof.IVA
					using sqlca;

			else	

				kst_tab_prof.PROFIS = "N"
				
				insert into PROF
							(
							  NUM_FATT,
							  DATA_FATT,
							  FLAG,
							  CONTO,
							  S_CONTO,
							  IMPORTO,
							  IVA,
							  TIPO_DOC,
							  COD_PAG,
							  PROFIS,
							  P_IVA
							)
					values (
							  :kst_tab_prof.NUM_FATT,
							  :kst_tab_prof.DATA_FATT,
							  :kst_tab_prof.FLAG,
							  :kst_tab_prof.CONTO,
							  :kst_tab_prof.S_CONTO,
							  :kst_tab_prof.IMPORTO,
							  :kst_tab_prof.IVA,
							  :kst_tab_prof.TIPO_DOC,
							  :kst_tab_prof.COD_PAG,
							  :kst_tab_prof.PROFIS,
							  :kst_tab_prof.P_IVA
							 )
					using sqlca;
	
				
			end if		
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cancellazione riga PROFIS (prof):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			
			else
		
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if
	end if

return kst_esito


end function

public function boolean crea_movimenti (st_tab_prof kst_tab_prof) throws uo_exception;//
//====================================================================
//--- Crea i Movimenti Profis ovvero Cancella poi Carica i rek della Fattura/N.C. nella tabella PROFIS
//--- 
//--- Input: kst_tab_prof:  num_fatt e data_fatt
//--- Ritorna tab. TRUE se scrive movimenti
//--- Lancia EXCEPTION se errori gravi DB
//--- 
//====================================================================
boolean k_return=false
st_tab_prof kst_tab_prof_prec, kst_tab_prof_Importi[]
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
int k_nr_st_tab_prof, k_ind_prof, k_ctr
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito, kst_esito_1
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kuf1_fatt = create kuf_fatt
	kuf1_clienti = create kuf_clienti
	
//--- Leggo il ID della Fattura	
	kst_tab_arfa.num_fatt = kst_tab_prof.num_fatt
	kst_tab_arfa.data_fatt = kst_tab_prof.data_fatt
	if kst_tab_arfa.id_fattura > 0 then
	else
		kst_esito = kuf1_fatt.get_id(kst_tab_arfa)
	end if
	if kst_esito.esito = kkg_esito.ok then
	
//--- Leggo i Campi di TESTATA della Fattura	
		kst_esito = kuf1_fatt.get_testata(kst_tab_arfa)
		if kst_esito.esito = kkg_esito.ok then
		
			kst_tab_prof.tipo_doc = kst_tab_arfa.tipo_doc
			kst_tab_prof.cod_pag = kst_tab_arfa.cod_pag
	
//--- Leggo il Campo P_IVA del Cliente
			kst_tab_clienti.codice = kst_tab_arfa.clie_3
			kst_esito = kuf1_clienti.get_p_iva(kst_tab_clienti)
			if kst_esito.esito = kkg_esito.ok then
				kst_tab_prof.p_iva = kst_tab_clienti.p_iva

//--- Leggo i Totali Fattura x CONTO 
				kst_esito = kuf1_fatt.get_importi_x_profis(kst_tab_arfa, kst_tab_prof_Importi[])

			end if
		end if	
	end if
	
	destroy kuf1_fatt
	destroy kuf1_clienti

	if kst_esito.esito <> kkg_esito.ok then
		if kst_esito.esito = kkg_esito.db_ko then
			
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
			
		end if
	
	else

		k_nr_st_tab_prof = UpperBound ( kst_tab_prof_Importi[] )

		k_ind_prof = 1 
		do while  sqlca.sqlcode = 0 and k_ind_prof <= k_nr_st_tab_prof
		
			if kst_tab_prof_Importi[k_ind_prof].S_CONTO > 0 then  //--- se Movimento valorizzato
				
//L'IMPORTO PUO' ESSERE A ZERO				if  kst_tab_prof_Importi[k_ind_prof].IMPORTO <> 0 then
		
					select sum(PROF.IMPORTO), count(*)
							into   :kst_tab_prof_prec.IMPORTO, :k_ctr
							from   PROF
							where  PROF.NUM_FATT   = :kst_tab_prof.NUM_FATT   and
									 PROF.DATA_FATT  = :kst_tab_prof.DATA_FATT  and
									 PROF.CONTO      = :kst_tab_prof_Importi[k_ind_prof].CONTO      and
									 PROF.S_CONTO    = :kst_tab_prof_Importi[k_ind_prof].S_CONTO    and
									 PROF.IVA        = :kst_tab_prof_Importi[k_ind_prof].IVA
							using sqlca;
		
					if sqlca.sqlcode < 0 then
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.SQLErrText = "Lettura riga PROFIS (prof):~n~r" + trim(sqlca.SQLErrText)
						kst_esito.esito = kkg_esito.db_ko
					else
						if k_ctr > 0 then
					
							if isnull(kst_tab_prof_prec.IMPORTO) then kst_tab_prof_prec.IMPORTO = 0
							kst_tab_prof_Importi[k_ind_prof].IMPORTO = kst_tab_prof_Importi[k_ind_prof].IMPORTO + kst_tab_prof_prec.IMPORTO
							kst_tab_prof_Importi[k_ind_prof].IMPORTO = round(kst_tab_prof_Importi[k_ind_prof].IMPORTO, 2) //arrotonda a 2 decimali
		
							update PROF
								set
										 PROF.IMPORTO    = :kst_tab_prof_Importi[k_ind_prof].IMPORTO
								where  PROF.NUM_FATT   = :kst_tab_prof.NUM_FATT   and
										 PROF.DATA_FATT  = :kst_tab_prof.DATA_FATT  and
										 PROF.CONTO      = :kst_tab_prof_Importi[k_ind_prof].CONTO      and
										 PROF.S_CONTO    = :kst_tab_prof_Importi[k_ind_prof].S_CONTO    and
										 PROF.IVA        = :kst_tab_prof_Importi[k_ind_prof].IVA
								using sqlca;
			
						else	
		
							kst_tab_prof.PROFIS = "N"
							
							insert into PROF
										(
										  ID_FATTURA,
										  NUM_FATT,
										  DATA_FATT,
										  FLAG,
										  CONTO,
										  S_CONTO,
										  IMPORTO,
										  IVA,
										  TIPO_DOC,
										  COD_PAG,
										  PROFIS,
										  P_IVA
										)
								values (
										  :kst_tab_prof.ID_FATTURA,
										  :kst_tab_prof.NUM_FATT,
										  :kst_tab_prof.DATA_FATT,
										  :kst_tab_prof_Importi[k_ind_prof].FLAG,
										  :kst_tab_prof_Importi[k_ind_prof].CONTO,
										  :kst_tab_prof_Importi[k_ind_prof].S_CONTO,
										  :kst_tab_prof_Importi[k_ind_prof].IMPORTO,
										  :kst_tab_prof_Importi[k_ind_prof].IVA,
										  :kst_tab_prof.TIPO_DOC,
										  :kst_tab_prof.COD_PAG,
										  :kst_tab_prof.PROFIS,
										  :kst_tab_prof.P_IVA
										 )
								using sqlca;
				
						end if	
					end if		
				
//APPUNTO L'IMPORTO PUO' ESSERE A ZERO				end if
			end if

			k_ind_prof++
		loop


		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Produzione righe per PROFIS (prof):~n~r" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )

//---- ROLLBACK....	
			if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
			throw kuo_exception
			
		end if
	
//---- COMMIT....	
		if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if

		if sqlca.sqlcode = 0 then
			k_return=true
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Produzione righe per PROFIS (prof-commit):~n~r" + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			
			kuo_exception = create uo_exception
			kuo_exception.set_esito( kst_esito )
			throw kuo_exception
		end if			

	end if

return k_return


end function

public function boolean if_gia_trasferiti (ref st_tab_prof kst_tab_prof) throws uo_exception;//
//====================================================================
//=== 
//=== Verifica presenza se i Mvimenti della Fattura sono già stati TRASFERITI in PROFIS 
//=== 
//=== Input: st_tab_prof: numero+data fattura
//=== Ritorna boolean TRUE = TRASFERITO 
//=== scatena un errore se DB KO                                    
//=== 
//====================================================================
//
boolean k_return = false
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


select min(profis)
 into 
	:kst_tab_prof.profis
	from prof
	where 
		num_fatt = :kst_tab_prof.num_fatt
		and data_fatt = :kst_tab_prof.data_fatt
	using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.PROF:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception		
	end if

	if kst_tab_prof.profis = "S" then
		k_return = true
	end if

return k_return

end function

public function st_esito tb_update_num_data_fatt (st_tab_prof kst_tab_prof_old, st_tab_prof kst_tab_prof);//
//====================================================================
//=== 
//=== Modifica data/numero fattura delle Ricevute 
//=== 
//=== Inp: st_tab_prof_old  num e data fattura da ricoprire
//===        st_tab_prof num e data fattura nuovi
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     vedi standard
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito, kst_esito_1
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	update prof
			set num_fatt = :kst_tab_prof.num_fatt
				 , data_fatt = :kst_tab_prof.data_fatt
		 WHERE num_fatt = :kst_tab_prof_old.num_fatt
				 and data_fatt = :kst_tab_prof_old.data_fatt
		 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica riga PROFIS (prof):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	
	else

//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kst_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_prof.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	end if


return kst_esito


end function

public function boolean get_id_fattura_da_num_anno (ref ust_tab_prof aust_tab_prof) throws uo_exception;//
//-------------------------------------------------------------------------------------------------------------
//--- 
//--- Leggo ID_FATTURA da Numero Fattura e anno 
//--- 
//--- Inp: 	ust_tab_prof.data_fatt (contenente l'anno di estrazione) se non passato piglia l'anno in corso
//---          ust_tab_prof.num_fatt 
//--- Out: 	ust_tab_prof.id_fattura 
//--- Ritorna TRUE=OK ho trovato qls; FALSE=nessua fattura estratta
//---                                     
//--- lancia uo_exception
//---
//-------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_tab_prof kst_tab_prof_ini, kst_tab_prof_fin
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if aust_tab_prof.data_fatt > KKG.DATA_ZERO then
else
	aust_tab_prof.data_fatt = kg_dataoggi
end if
kst_tab_prof_ini.data_fatt = date(year(aust_tab_prof.data_fatt), 01, 01)
kst_tab_prof_fin.data_fatt = date(year(aust_tab_prof.data_fatt), 12, 31)

select 
		id_fattura
 	into 
		:aust_tab_prof.id_fattura
	from prof
	where 
		data_fatt between :kst_tab_prof_ini.data_fatt and :kst_tab_prof_fin.data_fatt
		and flag = 'A'
		and num_fatt = :aust_tab_prof.num_fatt
	using kguo_sqlca_db_magazzino;
	

if sqlca.sqlcode <> 0 then
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Ricerca del ID Fattura in tabella movimenti per la Contabilità (PROF): " + trim(sqlca.SQLErrText)
	if sqlca.sqlcode = 100 then
		aust_tab_prof.num_fatt = 0
	else
		if sqlca.sqlcode > 0 then
			aust_tab_prof.num_fatt = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
end if

if aust_tab_prof.id_fattura > 0 then
	k_return = true
else
	aust_tab_prof.id_fattura = 0
end if

return k_return

end function

public function boolean set_profis (st_tab_prof ast_tab_prof) throws uo_exception;//
//------------------------------------------------------------------------
//--- 
//--- Scrive il campo PROFIS
//--- 
//--- Inp: st_tab_prof.id_fattura 
//--- Out: True = OK      
//--- 
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------------
//
boolean k_return=false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	update prof
			set profis = :ast_tab_prof.profis
		 WHERE id_fattura = :ast_tab_prof.id_fattura
		 using kguo_sqlca_db_magazzino ;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Aggiorna campo PROFIS (tab prof) per la fattura id=" + string(ast_tab_prof.id_fattura) + ". Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		if ast_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_prof.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//---- COMMIT....	
	if kst_esito.esito = kkg_esito.ok then
		if ast_tab_prof.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_prof.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		k_return = true
	end if
		

return k_return


end function

public function boolean set_fatture_esportate (st_tab_prof ast_tab_prof[]) throws uo_exception;//
//------------------------------------------------------------------------
//--- 
//--- Scrive il campo PROFIS a ESPORTATO
//--- 
//--- Inp: st_tab_prof.id_fattura array
//--- Out: True = OK      
//--- 
//--- lancia EXCEPTION
//--- 
//------------------------------------------------------------------------
//
boolean k_return=false
long k_ind=0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
	
	for k_ind = 1 to upperbound(ast_tab_prof[])

		if ast_tab_prof[k_ind].id_fattura > 0 then
			ast_tab_prof[k_ind].profis = kki_fattura_profis_cont_si
			ast_tab_prof[k_ind].st_tab_g_0.esegui_commit = "N"
			set_profis(ast_tab_prof[k_ind])
		end if
		
	next
	
	kguo_sqlca_db_magazzino.db_commit( )
		
catch (uo_exception kuo_exception)		
	kguo_sqlca_db_magazzino.db_rollback( )
	
	throw kuo_exception

finally
	k_return=true
	
end try


return k_return


end function

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true


st_tab_prof kst_tab_prof
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "b_contab" 
		kst_tab_prof.num_fatt = adw_1.getitemnumber(adw_1.getrow(), "num_fatt")
		if kst_tab_prof.num_fatt > 0 then
			kst_tab_prof.data_fatt = adw_1.getitemdate(adw_1.getrow(), "data_fatt")

			kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_prof )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Movimenti x la contabilità Documento n. " + trim(string(kst_tab_prof.num_fatt)) + " / " + string(kst_tab_prof.data_fatt, "yyyy")
		else
			k_return = false
		end if


end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
		throw kguo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean if_f_splitpayment (st_tab_prof kst_tab_prof) throws uo_exception;//--
//---  Controlla se Movimenti x Contabilità (Fattura) hanno lo Split-Payment
//---
//---  input: st_tab_prof.id_fatture
//---  otput: boolean TRUE = con SplitPayment
//---  se ERRORE lancia un Exception
//---
boolean k_return = false
int k_f_splitpayment
st_esito kst_esito 


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_prof.id_fattura > 0 then 
	
// le clausole " TABLE (MULTISET ( "	permettono una tabella virtuale quindi non c'e' nella from ma è il risultato della subquery
   select distinct 1
	   into :k_f_splitpayment
		 from TABLE (MULTISET (
   				select id_fattura
		   			from  prof left outer join IVA
							on prof.iva = iva.codice
      				 where prof.id_fattura   =  :kst_tab_prof.id_fattura 
		    					and iva.f_splitpayment = 'S'
								 ))
       using kguo_sqlca_db_magazzino;
end if

if kst_tab_prof.id_fattura > 0 then 
	
	if k_f_splitpayment = 1 then
		k_return = true
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura movimenti x la Contabilita' valutazione del Split-Payment (prof) id " + string(kst_tab_prof.id_fattura ) + "~n~r  " &
				+  " ~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito ) 	
			throw kguo_exception
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca id documento per valutare lo Split Paymenti nei movimeneti per la Contabilita' (prof) " 
	kst_esito.esito = kkg_esito.err_logico
	kguo_exception.set_esito( kst_esito ) 	
	throw kguo_exception
end if



return k_return

end function

on kuf_prof.create
call super::create
end on

on kuf_prof.destroy
call super::destroy
end on

event destructor;call super::destructor;//
//--- Chiude la window 
//
if isvalid(kiw_profis_exp_fatt) then kiw_profis_exp_fatt.chiudi_immediato()

end event

