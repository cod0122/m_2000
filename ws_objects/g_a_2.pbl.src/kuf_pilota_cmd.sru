$PBExportHeader$kuf_pilota_cmd.sru
forward
global type kuf_pilota_cmd from kuf_parent
end type
end forward

global type kuf_pilota_cmd from kuf_parent
end type
global kuf_pilota_cmd kuf_pilota_cmd

type variables
//
public st_tab_pilota_cmd kist_tab_pilota_cmd
public st_tab_pilota_cfg kist_tab_pilota_cfg

//--- valori della colonna STATO
public constant string ki_stato_in_attesa = "A"
public constant string ki_stato_evasa = "E"
public constant string ki_stato_respinta = "R"

//--- valori della colonna blocca_richieste
public constant string ki_blocca_richieste_no = "0"
public constant string ki_blocca_richieste_si = "1"

//--- valori della colonna cfg_dbms_scelta 
public constant string ki_cfg_dbms_scelta_princ = "1"
public constant string ki_cfg_dbms_scelta_muletto = "2"

//--- Tipo Richieste al PILOTA
public constant int kki_tipo_richiesta_invio_nuovo_pl_padri = 1
public constant int kki_tipo_richiesta_invio_nuovo_pl_figli = 11
public constant int kki_tipo_richiesta_sost_pl_padri = 3
public constant int kki_tipo_richiesta_sost_pl_figli = 13

//--- valori della colonna Crea File FIGLI x il Pilota 
public constant string kki_flag_genera_file_figli_SI = "S"
public constant string kki_flag_genera_file_figli_NO = "N"

end variables

forward prototypes
public function st_esito select_riga ()
protected function st_esito tb_delete ()
public function st_esito get_pilota_cfg () throws uo_exception
public function st_txt_pilota_answer leggi_file_risposte_pilota () throws uo_exception
protected function st_esito td_delete_x_data () throws uo_exception
public function st_esito tb_aggiorna_stato_evasa () throws uo_exception
public function boolean file_risposte_risultato_ok (st_txt_pilota_answer kst_txt_pilota_answer)
public function string get_file_pl_barcode () throws uo_exception
public function boolean tb_insert_tab_pilota_cmd () throws uo_exception
public function boolean scrivi_file_richieste () throws uo_exception
public function string get_path_file_pl_barcode () throws uo_exception
public function boolean richiesta_in_timeout () throws uo_exception
public function boolean job_pianificazione_lavorazioni () throws uo_exception
public function st_esito set_posizione_pl_barcode_nel_pilota (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public subroutine if_isnull_pilota_cmd (ref st_tab_pilota_cmd kst_tab_pilota_cmd)
public function boolean tb_aggiorna_cfg_num_rich () throws uo_exception
public function boolean scrivi_tab_richieste_pianificazione (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public subroutine set_blocca_richieste (st_tab_pilota_cfg kst_tab_pilota_cfg) throws uo_exception
public function transaction get_profilo_db () throws uo_exception
public function boolean check_sblocca_richiesta () throws uo_exception
public function st_tab_pilota_impostazioni get_pilota_pilota_impostazioni () throws uo_exception
public function st_tab_pilota_impostazioni st_tab_pilota_impostazioni_inizializza ()
public function integer conta_queue_table () throws uo_exception
public function boolean scrivi_tab_richieste_sost_coda (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean job_sostituzione_programmazione_pilota (ds_pl_barcode kds_pl_barcode) throws uo_exception
public function boolean job_evasione_richieste () throws uo_exception
public function st_tab_pilota_queue get_pilota_pilota_barcode_h_primo_queue () throws uo_exception
public function string get_blocca_richieste () throws uo_exception
public function st_txt_pilota_cmd leggi_file_richieste_padri () throws uo_exception
public function st_txt_pilota_cmd leggi_file_richieste_figli () throws uo_exception
public function st_esito cancella_file_richieste (readonly st_tab_pilota_cmd kst_tab_pilota_cmd) throws uo_exception
public function string get_path_temp () throws uo_exception
public function boolean check_presenza_file_richieste () throws uo_exception
public function boolean get_pilota_pilota_barcode (ref st_tab_pilota_queue ast_tab_pilota_queue) throws uo_exception
public function st_txt_pilota_cmd get_file_richieste_progressivi () throws uo_exception
public function string get_path_file_richieste () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
public function datetime get_data_ins_x_pl_barcode_codice (st_tab_pilota_cmd kst_tab_pilota_cmd) throws uo_exception
end prototypes

public function st_esito select_riga ();//
//--- Leggo Contratto specifico
//
long k_codice
st_esito kst_esito


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//	
	select 
			 num_rich
			 ,data_ins
			 ,tipo
			 ,path
			 ,pfile
			 ,stato
			 ,pl_barcode_codice
			 ,utente
			 ,prima_del_barcode
			 ,data_inizio
			 ,data_fine
	 into 
			:kist_tab_pilota_cmd.num_rich
			,:kist_tab_pilota_cmd.data_ins
			,:kist_tab_pilota_cmd.tipo
			,:kist_tab_pilota_cmd.path
			,:kist_tab_pilota_cmd.pfile
			,:kist_tab_pilota_cmd.stato
			,:kist_tab_pilota_cmd.pl_barcode_codice
			,:kist_tab_pilota_cmd.utente
			,:kist_tab_pilota_cmd.prima_del_barcode
			,:kist_tab_pilota_cmd.data_inizio
			,:kist_tab_pilota_cmd.data_fine
		from pilota_cmd
		where 
		num_rich = :kist_tab_pilota_cmd.num_rich
		using sqlca;

	
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sincrinizzazione Pilota  (PILOTA_CMD codice=" + string(kist_tab_pilota_cmd.num_rich) + ") : " &
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
	
return kst_esito


end function

protected function st_esito tb_delete ();//
//====================================================================
//=== Cancella il rek dalla tabella PILOTA_CMD (Sincronizzazione con il PILOTA_2005) 
//=== 
//=== Ritorna st_esito 
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()




kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_pl_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione in tabella Comandi Pilota non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_esito.esito = kkg_esito.ok then

		if isnull(kist_tab_pilota_cmd.st_tab_g_0.esegui_commit) or kist_tab_pilota_cmd.st_tab_g_0.esegui_commit <> "N" then
			kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = "S"
		end if

	//--- cancella prima tutte le righe varie
		delete from pilota_cmd
				WHERE num_rich = :kist_tab_pilota_cmd.num_rich;

		if sqlca.sqlcode = 0 then
			if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
				commit using sqlca;
			end if
		else
			if sqlca.sqlcode < 0 then
				if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
					rollback using sqlca;
				end if
			
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle righe Comandi Pilota della Richiesta ~n~r" &
						+ string(kist_tab_pilota_cmd.num_rich, "####0")  &	
						+ " ~n~rErrore-tab.PILOTA_CMD:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.DB_KO
		
			end if
		end if
	end if
end if


return kst_esito

end function

public function st_esito get_pilota_cfg () throws uo_exception;//---
//---   Valorizza la struttura con i valori di configurazione
//---
long k_ctr
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_nome, k_valore


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT pilota_cfg.codice 
         ,pilota_cfg.path_temp 
         ,pilota_cfg.path_pilota_out  
         ,pilota_cfg.file_richieste  
         ,pilota_cfg.timeout_file_rich_ss  
         ,pilota_cfg.path_pilota_inp  
         ,pilota_cfg.file_esiti 
         ,pilota_cfg.path_file_pl_barcode 
		,ultimo_progressivo_richiesta
		,cfg_dbms
		,cfg_autocommit
		,cfg_dbparm
		,cfg_dbms_alt
		,cfg_autocommit_alt
		,cfg_dbparm_alt
		,blocca_richieste
		,cfg_dbms_scelta 
         ,pilota_cfg.flag_genera_file_figli 
    INTO :kist_tab_pilota_cfg.codice   
         ,:kist_tab_pilota_cfg.path_temp  
         ,:kist_tab_pilota_cfg.path_pilota_out  
         ,:kist_tab_pilota_cfg.file_richieste  
         ,:kist_tab_pilota_cfg.timeout_file_rich_ss  
         ,:kist_tab_pilota_cfg.path_pilota_inp  
         ,:kist_tab_pilota_cfg.file_esiti 
         ,:kist_tab_pilota_cfg.path_file_pl_barcode
		,:kist_tab_pilota_cfg.ultimo_progressivo_richiesta
		,:kist_tab_pilota_cfg.cfg_dbms
		,:kist_tab_pilota_cfg.cfg_autocommit
		,:kist_tab_pilota_cfg.cfg_dbparm
		,:kist_tab_pilota_cfg.cfg_dbms_alt
		,:kist_tab_pilota_cfg.cfg_autocommit_alt
		,:kist_tab_pilota_cfg.cfg_dbparm_alt
		,:kist_tab_pilota_cfg.blocca_richieste
		,:kist_tab_pilota_cfg.cfg_dbms_scelta 
		,:kist_tab_pilota_cfg.flag_genera_file_figli 
    FROM pilota_cfg  ;

	
	if sqlca.sqlcode = 0 then
//--- valorizza il nome file della 'richiesta' con i figli  		
		k_ctr = PosA(kist_tab_pilota_cfg.file_richieste, ".") 
		if k_ctr > 0 then
			kist_tab_pilota_cfg.file_richieste_figli = MidA(kist_tab_pilota_cfg.file_richieste, 1, k_ctr - 1) + "_grp" + MidA(kist_tab_pilota_cfg.file_richieste, k_ctr, LenA(kist_tab_pilota_cfg.file_richieste) - k_ctr + 1)
		else
			kist_tab_pilota_cfg.file_richieste_figli = trim(kist_tab_pilota_cfg.file_richieste) + "_grp" 
		end if
	else
		if sqlca.sqlcode < 0 then
			
			kst_esito.esito = KKG_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + &
					"Codice : " + string(sqlca.sqldbcode, "#####") + "~n~r" + &
					sqlca.sqlreturndata
					
		else
			if sqlca.sqlcode > 0 then
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					kst_esito.esito = kkg_esito.db_wrn
				end if
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(sqlca.sqlerrtext) 
			end if	
		end if

		SetPointer(oldpointer)

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
SetPointer(oldpointer)


return kst_esito
end function

public function st_txt_pilota_answer leggi_file_risposte_pilota () throws uo_exception;//---
//---   Legge il file delle Risposte dal Pilota (probabilmente ANSWER.TXT) e lo converte 
//---   nella struttura st_txt_pilota_answer, in ottemperanza al valore 'codice richiesta' presente nel file
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---
st_txt_pilota_answer kst_txt_pilota_answer
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len 	
string k_record
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

	
//--- Inizializzo i campi
kst_txt_pilota_answer.progressivo_richiesta = 0
kst_txt_pilota_answer.codice_richiesta = 0
kst_txt_pilota_answer.file_path = " "
kst_txt_pilota_answer.risultato = " "
kst_txt_pilota_answer.codice_errore = 0

//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono?
if not DirectoryExists ( kist_tab_pilota_cfg.path_pilota_inp ) then
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Cartella di scambio file proveniente dal Pilota Non Trovata: " + kist_tab_pilota_cfg.path_pilota_inp
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
end if


//--- Esiste il file ?
if  not FileExists ( kist_tab_pilota_cfg.path_pilota_out+ kist_tab_pilota_cfg.file_esiti) then
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = k_byte
	kst_esito.SQLErrText = "File 'Esiti dal Pilota' non Trovato: ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_esiti
//	kuo_exception.set_esito (kst_esito)
//	throw kuo_exception
end if

if kst_esito.esito = kkg_esito.ok then

//--- open del file 
	k_FileNum = FileOpen((kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti), LineMode!, Read!, Shared!)
	
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Apertura fallita dell'archivio 'Esiti dal Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti
//		kuo_exception.set_esito (kst_esito)
//		throw kuo_exception
	end if
end if
					
if k_FileNum >0 then
	
	k_byte = FileRead(k_FileNum, k_record)
		
	choose case k_byte
	
	//--- EOF
			case -100
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Fine del file 'Esiti dal Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti
//				kuo_exception.set_esito (kst_esito)
//				throw kuo_exception
	
	//--- Errore grave
			case is < 0
				FileClose(k_FileNum)
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Lettura fallita del record 'Esiti dal Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
	
	//--- Rec vuoto
			case 0
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "File Vuoto 'Esiti dal Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti
//				kuo_exception.set_esito (kst_esito)
//				throw kuo_exception
	
	//--- Se lettura OK riempe i campi e controlla se dati formalmente corretti		
			case else
				
				k_pos_ctr_ini = 1
				k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
				if k_pos_ctr_fin > 0 then
					k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
					if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
						kst_txt_pilota_answer.progressivo_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Errore Formato Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
					end if
				else
					kst_esito.esito = kkg_esito.ERR_FORMALE
					kst_esito.sqlcode = k_byte
					kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
													+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
				end if
				
				if kst_esito.esito = kkg_esito.ok then
					k_pos_ctr_ini = k_pos_ctr_fin + 1
					k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
					if k_pos_ctr_fin > 0 then
						k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
						if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
							kst_txt_pilota_answer.codice_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Errore Formato Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
						end if
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
					end if
				end if
	
	//--- campo Esito del Trattamento
				if kst_esito.esito = kkg_esito.ok then
					k_pos_ctr_ini = k_pos_ctr_fin + 1
					k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
					if k_pos_ctr_fin > 0 then
						k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
						if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
							kst_txt_pilota_answer.risultato = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
						else
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Manca il campo Risultato Trattamento, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
						end if
					else
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Risultato Trattamento, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
					end if
				end if
	
	//--- campo Codice Errore
				if kst_esito.esito = kkg_esito.ok then
					k_pos_ctr_ini = k_pos_ctr_fin + 1
					k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
					if k_pos_ctr_fin > 0 then
						k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
					else
						if k_byte >= k_pos_ctr_ini then 
							k_pos_ctr_len = k_byte - k_pos_ctr_ini + 1
						else
							k_pos_ctr_len = 0
						end if
					end if
					if k_pos_ctr_len > 0 then
						
						if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
							kst_txt_pilota_answer.codice_errore = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Errore Formato Codice Errore, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
						end if
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Non trovato il campo Codice Errore, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
														+ ") "
					end if
				end if
	
				
				if kst_esito.esito = kkg_esito.ok then
					
	//--- Se richiesta codice 1 ovvero consegnato flusso pilota.....
					if kst_txt_pilota_answer.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri or kst_txt_pilota_answer.codice_richiesta = kki_tipo_richiesta_sost_pl_padri &
					       or kst_txt_pilota_answer.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli or kst_txt_pilota_answer.codice_richiesta = kki_tipo_richiesta_sost_pl_figli &
						   then   
						// nessu parametro
	
					else
					
//	//--- Se richiesta codice 2 ovvero richiesta esiti pilota.....
//						if kst_txt_pilota_answer.codice_richiesta = 2 then   
//	
//	//--- campo parametri: cartella di scambio Pilota -> M2000 con il file Esiti della Lavorazione
//							k_pos_ctr_ini = k_pos_ctr_fin + 1
//							k_pos_ctr_fin = pos(k_record, ",", k_pos_ctr_ini)
//							if k_pos_ctr_fin > 0 then
//								k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
//							else
//								if k_byte >= k_pos_ctr_ini then 
//									k_pos_ctr_len = k_byte - k_pos_ctr_ini + 1
//								else
//									k_pos_ctr_len = 0
//								end if
//							end if
//							if k_pos_ctr_len > 0 then
//								if len(trim(mid(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
//									kst_txt_pilota_answer.file_path = trim(mid(k_record, k_pos_ctr_ini, k_pos_ctr_len))
//								else
//									kst_esito.esito = kkg_esito.ERR_FORMALE
//									kst_esito.sqlcode = k_byte
//									kst_esito.SQLErrText = "Campo Nome Cartella con esiti Pilota vuoto, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
//																	+ "~n~r valore:"  + trim(mid(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
//								end if
//							else
//								kst_esito.esito = kkg_esito.ERR_FORMALE
//								kst_esito.sqlcode = k_byte
//								kst_esito.SQLErrText = "Non trovato il campo Nome Cartella con esiti Pilota, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
//																+ ") "
//							end if
//					
//						else
	//--- Richiesta non prevista
							kst_esito.esito = kkg_esito.blok
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Errore Codice Richiesta non Gestita, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_inp+kist_tab_pilota_cfg.file_esiti &
															+ "~n~r valore:"  + string(kst_txt_pilota_answer.codice_richiesta) + ") "
		
//						end if
					end if
	
				end if
	
				if kst_esito.esito <> kkg_esito.ok then
					FileClose(k_FileNum)
					kuo_exception.set_esito (kst_esito)
					throw kuo_exception
				end if
	
	
	end choose

	FileClose(k_FileNum)

end if

SetPointer(oldpointer)			

return kst_txt_pilota_answer

end function

protected function st_esito td_delete_x_data () throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella PILOTA_CMD (Sincronizzazione con il PILOTA_2005) 
//=== fino a una certa data  
//=== 
//=== Ritorna st_esito 
//=== 
//====================================================================
//
int k_resp
boolean k_return
st_esito kst_esito
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
pointer oldpointer
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception



kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = kkg_id_programma_pl_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione in tabella Comandi Pilota non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

	SetPointer(oldpointer)

	kuo_exception.set_esito (kst_esito)
	throw kuo_exception

else

	
	if kst_esito.esito = kkg_esito.ok then

		if isnull(kist_tab_pilota_cmd.st_tab_g_0.esegui_commit) or kist_tab_pilota_cmd.st_tab_g_0.esegui_commit <> "N" then
			kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = "S"
		end if
	
	//--- cancella prima tutte le righe varie
		delete from pilota_cmd
				WHERE data_ins <= :kist_tab_pilota_cmd.data_ins;
	
		if sqlca.sqlcode = 0 then
			if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
				commit using sqlca;
			end if
		else

			if sqlca.sqlcode < 0 then

				if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
					rollback using sqlca;
				end if

				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = &
		"Errore durante la cancellazione delle righe Comandi Pilota della Richiesta ~n~r" &
						+ string(kist_tab_pilota_cmd.num_rich, "####0")  &	
						+ " ~n~rErrore-tab.PILOTA_CMD:"	+ trim(sqlca.SQLErrText)
				kst_esito.esito = kkg_esito.DB_KO
	
				SetPointer(oldpointer)
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
	
			end if
		end if
	end if
end if

SetPointer(oldpointer)


return kst_esito

end function

public function st_esito tb_aggiorna_stato_evasa () throws uo_exception;//
//--- Aggiorna lo stato della richiesta impostare la struttura come segue:
//---       kist_tab_pilota_cmd.stato
//---       kist_tab_pilota_cmd.num_rich
//
long k_codice
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if isnull(kist_tab_pilota_cmd.st_tab_g_0.esegui_commit) or kist_tab_pilota_cmd.st_tab_g_0.esegui_commit <> "N" then
		kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = "S"
	end if

	
	update  pilota_cmd
		set stato = :kist_tab_pilota_cmd.stato
		where 
		num_rich = :kist_tab_pilota_cmd.num_rich
		using sqlca;

	
	if sqlca.sqlcode = 0 then
		if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
			commit using sqlca;
		end if
	else
		if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
			rollback using sqlca;
		end if
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento della Tab.Sincrinizzazione Pilota  (PILOTA_CMD codice=" + string(kist_tab_pilota_cmd.num_rich) + ")  ~n~r"  &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
			end if
		end if
	end if

	SetPointer(oldpointer)
	
	
return kst_esito


end function

public function boolean file_risposte_risultato_ok (st_txt_pilota_answer kst_txt_pilota_answer);//---
//---   Check del risultato del file di risposta del Pilota (answer.txt) 
//---   
//---   Input: la struttura kst_txt_pilota_answer deve essere gia' valorizzata
//---   Output: true=risultato di answerok; false=risultato di answer errato 
//---
pointer oldpointer  // Declares a pointer variable
boolean k_return


//--- Inizializzo i campi
k_return = true

//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono?
if upper(kst_txt_pilota_answer.risultato) <> "OK" then
	k_return = false
end if

return k_return

end function

public function string get_file_pl_barcode () throws uo_exception;//---
//---   Torna il nome del file delle Pianificazioni alle Lavorazioni
//---   Output: il nome del file
//---   Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_return = " "
uo_exception kuo_exception

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//
//  SELECT 
//        pilota_cfg.path_file_pl_barcode 
//    INTO 
//         :kist_tab_pilota_cfg.path_file_pl_barcode 
//    FROM pilota_cfg  ;

	k_return  = trim("\pp_pilota"+ trim(string(kist_tab_pilota_cfg.ultimo_progressivo_richiesta + 1,"00")) + ".txt")
	
//	if sqlca.sqlcode = 0 then
//		
//		k_return = trim(kist_tab_pilota_cfg.nome_file_pl_barcode) 
//		
//	else
//		if sqlca.sqlcode < 0 then
//			
//			kst_esito.esito = kkg_esito.DB_KO
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + &
//					"Codice : " + string(sqlca.sqldbcode, "#####") + "~n~r" +&
//					sqlca.sqlreturndata
//					
//		else
//			if sqlca.sqlcode > 0 then
//				if sqlca.sqlcode = 100 then
//					kst_esito.esito = kkg_esito.not_fnd
//				else
//					kst_esito.esito = kkg_esito.db_wrn
//				end if
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = trim(sqlca.sqlerrtext) 
//			end if	
//		end if

//		SetPointer(oldpointer)
//
////--- LANCIA UN ECCEZIONE
//		kuo_exception = create uo_exception
//		kuo_exception.set_esito(kst_esito)
//		throw kuo_exception
//
//	end if
	
SetPointer(oldpointer)


return k_return

end function

public function boolean tb_insert_tab_pilota_cmd () throws uo_exception;//
//====================================================================
//=== Aggiunge rek nella tabella di Sincronizzazione M2000-Pilota la PILOTA_CMD
//=== 
//=== 
//=== Ritorna tab. TRUE=operazione eseguita OK
//===  Se errore lancia EXCEPTION
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
boolean k_return = false
pointer oldpointer
st_esito kst_esito
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

	select num_rich
		 into :k_id
		 from pilota_cmd
			where num_rich = :kist_tab_pilota_cmd.num_rich
			using kguo_sqlca_db_magazzino ;

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Richiesta gia' presente nella Tab.sincronizzazione M2000-Pilota Pilota_cmd~n~r" &
		                       + "Codice: " + string(kist_tab_pilota_cmd.num_rich)
		kst_esito.esito = kkg_esito.err_logico

	else

		if isnull(kist_tab_pilota_cmd.st_tab_g_0.esegui_commit) or kist_tab_pilota_cmd.st_tab_g_0.esegui_commit <> "N" then
			kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = "S"
		end if


		INSERT INTO pilota_cmd  
				( num_rich,   
				  data_ins,   
				  tipo,   
				  pl_barcode_codice,   
				  path,   
				  pfile,   
				  stato 
				  ,utente
				  ,prima_del_barcode
				  ,path_file_pl_barcode
				  ,data_inizio
				  ,data_fine
				  )  
			VALUES (   
						:kist_tab_pilota_cmd.num_rich,   
						:kist_tab_pilota_cmd.data_ins,   
						:kist_tab_pilota_cmd.tipo,   
						:kist_tab_pilota_cmd.pl_barcode_codice,
						:kist_tab_pilota_cmd.path,   
						:kist_tab_pilota_cmd.pfile,   
						:kist_tab_pilota_cmd.stato 
				  		,:kist_tab_pilota_cmd.utente
				  		,:kist_tab_pilota_cmd.prima_del_barcode
						,:kist_tab_pilota_cmd.path_file_pl_barcode
				  		,:kist_tab_pilota_cmd.data_inizio
				  		,:kist_tab_pilota_cmd.data_fine
				  )  
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.sincronizzazione M2000-Pilota Pilota_cmd: " + string(kguo_sqlca_db_magazzino.sqlcode) +" "+ trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		else
			if kist_tab_pilota_cmd.st_tab_g_0.esegui_commit = 'S' then
				kguo_sqlca_db_magazzino.db_commit( )
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Tab.sincronizzazione M2000-Pilota Pilota_cmd (commit): " + string(kguo_sqlca_db_magazzino.sqlcode) +" "+ trim(kguo_sqlca_db_magazzino.SQLErrText)
				end if
			end if
		end if
	
	end if

	SetPointer(oldpointer)

	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		k_return = true
	else
		kuo_exception.set_esito (kst_esito)
		throw kuo_exception
	end if

	

return k_return

end function

public function boolean scrivi_file_richieste () throws uo_exception;//---
//---   Scrive il file delle Richieste al Pilota (probabilmente COMMAND.TXT o COMMAND_GRP.TXT) 
//---   
//---   
//---   Input: kist_tab_pilota_cfg deve essere gia' valorizzata
//---            kist_tab_pilota_cmd = tutta l'area gia' valorizzata    
//---
//---   Output: boolean TRUE=file scritto; FALSE=nessun file x il pilota scritto
//---
//---   

boolean k_return = true
st_txt_pilota_cmd kst_txt_pilota_cmd
st_tab_pilota_cmd kst_tab_pilota_cmd
st_tab_pilota_cfg  kst_tab_pilota_cfg 
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len, k_rc 	
string k_record, k_sep=","
string k_nome_file=""
kuf_utility kuf1_utility


try

	//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_utility = create kuf_utility
	
	//--- Inizializzo i campi
	kst_tab_pilota_cfg = kist_tab_pilota_cfg
	kst_txt_pilota_cmd.progressivo_richiesta = kist_tab_pilota_cmd.num_rich
	kst_txt_pilota_cmd.codice_richiesta = kist_tab_pilota_cmd.tipo
	kst_txt_pilota_cmd.path_fl_pilota = get_path_file_pl_barcode() + get_file_pl_barcode()
	kst_txt_pilota_cmd.utente =  kist_tab_pilota_cmd.utente
	kst_txt_pilota_cmd.data_fine =  kist_tab_pilota_cmd.data_fine
	kst_txt_pilota_cmd.data_inizio = kist_tab_pilota_cmd.data_inizio
	kst_txt_pilota_cmd.prima_del_barcode = kist_tab_pilota_cmd.prima_del_barcode
	
	//--- nome del file in base al tipo di Richiesta
	if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_padri then
		k_nome_file = kst_tab_pilota_cfg.file_richieste
	else
		k_nome_file = kst_tab_pilota_cfg.file_richieste_figli
	end if
	
	//--- elimina i campi a null
	if_isnull_pilota_cmd(kist_tab_pilota_cmd)
	
	//--- la cartella Temporanea dei file di scambio tra M2000 e PILOTA esiste? 
	if trim ( kst_tab_pilota_cfg.path_temp ) > " "  then 
		if not kguo_path.u_drectory_create( kst_tab_pilota_cfg.path_temp) then
//		if not DirectoryExists ( kst_tab_pilota_cfg.path_temp ) then 
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Attenzione Piano non INVIATO (" + k_nome_file + "): Cartella Temporanea dei file diretti al Pilota Non Trovata: '" + (kst_tab_pilota_cfg.path_temp) + "' "  
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		kst_tab_pilota_cfg.path_temp = kst_tab_pilota_cfg.path_pilota_out
	end if
	
	//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono? 
	if not kguo_path.u_drectory_create( kst_tab_pilota_cfg.path_pilota_out) then
//	if not DirectoryExists ( kst_tab_pilota_cfg.path_pilota_out ) then 
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Attenzione Piano non INVIATO (" + k_nome_file + "): Cartella di Scambio file diretti al Pilota Non Trovata: '" + kst_tab_pilota_cfg.path_pilota_out + "' "  
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
	//--- open del file 
	k_FileNum = FileOpen((kst_tab_pilota_cfg.path_temp+k_nome_file), LineMode!, Write!, LockWrite!, Replace!)
	
	if k_FileNum < 0 or isnull(k_FileNum) then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Attenzione Piano non INVIATO (" + k_nome_file + "): Apertura archivio 'Richieste PL da inviare al Pilota' Fallito. ~n~r"+kst_tab_pilota_cfg.path_temp+k_nome_file
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	//--- Compone il record del file Richieste
	if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_padri then
		k_record = string(kst_txt_pilota_cmd.progressivo_richiesta, "000000") &
						+ k_sep + string(kst_txt_pilota_cmd.codice_richiesta, "000000") &
						+ k_sep + trim(kst_txt_pilota_cmd.path_fl_pilota) &
						+ k_sep + trim(kst_txt_pilota_cmd.prima_del_barcode) &
						+ k_sep + trim(kst_txt_pilota_cmd.utente) 
	else
		if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_figli then  
			k_record = string(kst_txt_pilota_cmd.progressivo_richiesta, "000000") &
							+ k_sep + string(kst_txt_pilota_cmd.codice_richiesta, "000000") &
							+ k_sep + trim(kst_txt_pilota_cmd.path_fl_pilota) &
							+ k_sep + trim(kst_txt_pilota_cmd.utente) 
		else
//			FileClose(k_FileNum)
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Attenzione Piano non INVIATO (" + k_nome_file + "): errore in scrittura 'Richieste PL da inviare al Pilota'. ~n~r"&
										+ "Codice richiesta non riconosciuto = " + string(kst_txt_pilota_cmd.codice_richiesta)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if			
	//--- SCRIVE FILE RICHIESTE
	k_byte = FileWrite(k_FileNum, k_record)
		
	choose case k_byte
	
	//--- Errore grave
			case is < 0
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Attenzione Piano non INVIATO (" + k_nome_file + "): Scrittura fallita del record in archivio 'Richieste PL da inviare al Pilota' ~n~r"+kst_tab_pilota_cfg.path_temp+k_nome_file
//				FileClose(k_FileNum)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
	
	end choose
	
	//-- Chiudo il File
	if FileClose(k_FileNum) < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Rilascio (close) archivio 'Richieste PL da inviare al Pilota' fallito,  nome: ~n~r"+kst_tab_pilota_cfg.path_temp+k_nome_file
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	else
		k_FileNum = 0
	end if	
	
	//--- Copia il file da cartella TEMPORANEA a cartella di SCAMBIO con il Pilota
	if kst_tab_pilota_cfg.path_temp <> kst_tab_pilota_cfg.path_pilota_out then
		k_rc = kuf1_utility.u_copia_file( kst_tab_pilota_cfg.path_temp+k_nome_file,kst_tab_pilota_cfg.path_pilota_out+k_nome_file, true)
		if k_rc < 0 then
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = k_rc
			kst_esito.SQLErrText = "Copia file 'Richieste al Pilota' fallito,  ~n~rda: "  &
											+  kst_tab_pilota_cfg.path_temp+k_nome_file & 
											+ "~n~ra: "+kst_tab_pilota_cfg.path_pilota_out+k_nome_file &
											+ "~n~rAVVERTIRE I SISTEMISTI IMMEDIATAMENTE"
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if	
	end if	

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
	if k_FileNum > 0 then
		FileClose(k_FileNum)
	end if
	
	if isvalid(kuf1_utility) then destroy kuf1_utility

	SetPointer(oldpointer)

end try

return k_return

end function

public function string get_path_file_pl_barcode () throws uo_exception;//---
//---   Torna il nome completo del path di scambio dove risiede il file delle Pianificazioni alle Lavorazioni
//---   Output: il path
//---   Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_return = " "
//uo_exception kuo_exception

//=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
        pilota_cfg.path_file_pl_barcode 
    INTO 
         :kist_tab_pilota_cfg.path_file_pl_barcode 
    FROM pilota_cfg  
	 using sqlca;

	
	if sqlca.sqlcode = 0 then

//--- la cartelle esiste? 
		if len(trim(kist_tab_pilota_cfg.path_file_pl_barcode ) ) > 0 then
			if not DirectoryExists ( kist_tab_pilota_cfg.path_file_pl_barcode ) then 
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Cartella di scambio file diretti al Pilota non Trovata (P.L.)! " &
										+ "~n~rpath: " + trim(kist_tab_pilota_cfg.path_file_pl_barcode) + " "
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Cartella di scambio file diretti al Pilota non Indicata in Archivio (inserire in Archivi->Pilota)! " 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		k_return = trim(kist_tab_pilota_cfg.path_file_pl_barcode ) 
		
	else
		if sqlca.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText += "~n~r" + &
					"Codice : " + string(sqlca.sqldbcode, "#####") + "~n~r" +&
					sqlca.sqlreturndata
					
		else
			if sqlca.sqlcode > 0 then
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					kst_esito.esito = kkg_esito.db_wrn
				end if
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(sqlca.sqlerrtext) 
			end if	
		end if

		SetPointer(oldpointer)

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
//SetPointer(oldpointer)


return k_return

end function

public function boolean richiesta_in_timeout () throws uo_exception;//---
//---   Controlla se Richiesta e' in time-out (fuori tempo massimo)
//---
//---   Input: kist_tab_pilota_cmd gia' valorizzata
//---             kist_tab_pilota_cfg gia' valorizzata
//---   Output: TRUE=in time-out; FALSE=Ancora valida
//---
//---   Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
boolean k_return = true
long k_giorni_trascorsi, k_secondi_trascorsi
datetime k_datetime_adesso
date k_data_1, k_data_2
uo_exception kuo_exception

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if date(kist_tab_pilota_cmd.data_ins) > date(0) then
//--- calcola quanti giorni sono trascorsi dalla richiesta ad oggi 

	k_datetime_adesso = kGuf_data_base.prendi_dataora() 
	k_giorni_trascorsi = daysafter(date(kist_tab_pilota_cmd.data_ins),  date(k_datetime_adesso))
	//--- se i giorni sono negativi qualcosa non quaglia... 
	if k_giorni_trascorsi < 0 then
				
		kst_esito.esito = kkg_esito.BLOK
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Giorni trascorsi tra inizio Richiesta e Oggi Negativo.~n~rData Richiesta: " + &
				string(date(kist_tab_pilota_cmd.data_ins)) + " data oggi: " + string(date(k_datetime_adesso)) + "~n~r" +&
				"Risultato: " + string (k_giorni_trascorsi)
	//--- LANCIA UN ECCEZIONE
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
				
	else	
	
		if k_giorni_trascorsi > 0 then
	//--- toglie dai giorni probabilmente 1 poiche' non sono trascorse 24 ore complete, come ad esempio
	//--- se la richiesta e' delle 15:30 di ieri e ora sono le 11:15 ovviamente non e' ancora trscorso 1 giorno
			if time(kist_tab_pilota_cmd.data_ins) > time(k_datetime_adesso) then
				k_giorni_trascorsi --
			end if
		end if
	end if
	
	//--- calcola la differenza di tempo tra la richiesta e ora es.15:30 e ora le 11:15
	//--- se il risultato e' negativo devo sommare 24 poiche' come in esempio in realta' le 11:15 sono del giorno dopo 
	//--- mentre se il risultato e' positivo va gia' bene cosi, si insomma se fossero ora le 15:35 sarebbero passati 1 giorno e 5 minuti
	//--- RICORDA 86.400 secondi = 1 giorno
	k_secondi_trascorsi = secondsafter( time(kist_tab_pilota_cmd.data_ins), time(k_datetime_adesso))   
	if k_secondi_trascorsi < 0 then
		k_secondi_trascorsi += 86400
	end if
	//--- aggiungo eventuali giorni (nel nostro esempio 1 x 86400 secondi)
	k_secondi_trascorsi +=  (86400 *k_giorni_trascorsi)
	
	//--- FINALMENTE se supero il time out impostato in cfg allora torno a TRUE
	if k_secondi_trascorsi > kist_tab_pilota_cfg.timeout_file_rich_ss then
		k_return = true
	else
		k_return = false
	end if
	
end if


SetPointer(oldpointer)


return k_return

end function

public function boolean job_pianificazione_lavorazioni () throws uo_exception;//---
//---   Job di generazione Richiesta di aggiunta di un Nuovo Piano di Lavorazione in coda al Pilota
//--- Output: TRUE = richiesta prodotta; FALSE = operazione non eseguita   
//---

boolean k_return = False
string k_path_pilota, k_path_temp, k_file_nome
pointer oldpointer  // Declares a pointer variable
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_pilota_queue kst_tab_pilota_queue
kuf_pl_barcode kuf1_pl_barcode
ds_pl_barcode kds_pl_barcode
uo_exception kuo_exception


//=== Puntatore Cursore da attesa..... 
oldpointer = SetPointer(HourGlass!)

//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()

try 

	kuf1_pl_barcode = create kuf_pl_barcode

//=== Se Richiesta precedente e' stata Evasa posso provare a processare la prossima
	if job_evasione_Richieste() then 

//=== leggo tabella di configurazione
		get_pilota_cfg()
		k_path_pilota = get_path_file_pl_barcode() //get path x scambio con PILOTA
		k_path_temp = get_path_temp( ) //get path temporaneo
		k_file_nome = get_file_pl_barcode() //get nome file

//=== Controlla se le richieste sono Bloccate (SEMAFORO ROSSO?)
		kist_tab_pilota_cfg.blocca_richieste = get_blocca_richieste()
	
//=== Se Richieste Bloccate (SEMAFORO ROSSO) salta tutto
		if kist_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_no  then

//=== Verifica se c'e' un nuovo Piano da Inviare al Pilota (STATO=CHIUSO)
			kst_tab_pl_barcode = kuf1_pl_barcode.get_pl_barcode_da_inviare() 
			if kst_tab_pl_barcode.codice > 0 then	

//=== Imposta la STATO in elaborazione così da evitare che altri utenti lo inviano in contemporanea
				kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
				kuf1_pl_barcode.set_pl_barcode_stato("in_elab", kst_tab_pl_barcode) 

//=== Piglia l'elenco dei barcode del PL da Inviare
				kds_pl_barcode = kuf1_pl_barcode.get_ds_pl_barcode(kst_tab_pl_barcode) 

//--- INIZIO PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------
				
//--- Crea un nuovo Piano di Lavorazione con i Barcode Padre
				if kuf1_pl_barcode.crea_file_pilota_padri(kds_pl_barcode, k_file_nome, k_path_temp, k_path_pilota) then

//--- crea file dati WO x il Pilota
					kuf1_pl_barcode.crea_file_pilota_wo(kst_tab_pl_barcode, k_file_nome, k_path_temp, k_path_pilota)

//=== Se PL URGENTE allora valorizza "prima_del_barcode" ==========================
					if kuf1_pl_barcode.if_pl_barcode_priorita_urgente(kst_tab_pl_barcode) then
						kst_tab_pilota_queue=get_pilota_pilota_barcode_h_primo_queue()
						kist_tab_pilota_cmd.prima_del_barcode = kst_tab_pilota_queue.barcode
						kst_tab_pl_barcode.prima_del_barcode = kst_tab_pilota_queue.barcode
						kuf1_pl_barcode.tb_update_campo(kst_tab_pl_barcode, "prima_del_barcode")
					end if

//--- imposta il PATH del Piano					
					kst_tab_pl_barcode.path_file_pilota = k_path_pilota + k_file_nome
						
//=== Crea il nuovo record di Richiesta nella tabella PILOTA_CMD
			   	kist_tab_pilota_cfg.tipo_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri
					if scrivi_tab_richieste_pianificazione(kst_tab_pl_barcode) then

//=== Crea il nuovo file Richiesta ==========================
						scrivi_file_richieste()
						k_return = TRUE

//=== Setta il nuovo STATO e il PATH del Piano di Lavorazione
						kuf1_pl_barcode.set_pl_barcode_stato("inviato", kst_tab_pl_barcode) 

//--- Aggiorna "progressivo richiesta e nome file piano di lav." nella tabella di config. pilota PILOTA_CFG	
						kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode = get_file_pl_barcode()
						kist_tab_pilota_cfg.ultimo_progressivo_richiesta = kist_tab_pilota_cmd.num_rich
						tb_aggiorna_cfg_num_rich()
						
						try
//--- Associa il Codice della tabella PILOTA_CMD (il COMMAND del PADRE) alla tabella di Pianificazione (PL_BARCODE)
							kst_tab_pl_barcode.pilota_cmd_num_rich = kist_tab_pilota_cmd.num_rich
							kuf1_pl_barcode.set_pilota_cmd_num_rich(kst_tab_pl_barcode)
						catch (uo_exception kuo1_exception)
						end try
						
					end if
				end if

//=== Flag di Generazione File Figli attivo?
				if kist_tab_pilota_cfg.flag_genera_file_figli = kki_flag_genera_file_figli_SI then 
					
//=== Crea un nuovo Piano di Lavorazione con i Barcode FIGLI
					if kuf1_pl_barcode.crea_file_pilota_figli(kds_pl_barcode) then

//=== Crea il nuovo record di Richiesta nella tabella PILOTA_CMD

//=== imposta il PATH del Piano di Lavorazione
						kst_tab_pl_barcode.path_file_pilota = k_path_pilota + k_file_nome

				   	kist_tab_pilota_cfg.tipo_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli
						if scrivi_tab_richieste_pianificazione(kst_tab_pl_barcode) then

//=== Setta il nuovo STATO del Piano di Lavorazione
							kuf1_pl_barcode.set_pl_barcode_stato("inviato", kst_tab_pl_barcode) 

//=== Crea il nuovo file Richiesta ==========================
							scrivi_file_richieste()
							k_return = TRUE

//--- Aggiorna "progressivo richiesta e nome file piano di lav." nella tabella di config. pilota PILOTA_CFG	
							kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode = get_file_pl_barcode()
							kist_tab_pilota_cfg.ultimo_progressivo_richiesta = kist_tab_pilota_cmd.num_rich
							tb_aggiorna_cfg_num_rich()
	
						end if
					end if
				end if
				
//--- FINE PRODUZIONE FILE PER IL PILOTA ------------------------------------------------------------------
			
			end if

		end if
	end if		

catch (uo_exception kuo_exception1 )
//=== Imposta la STATO in ERRORE
	kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S"
	kuf1_pl_barcode.set_pl_barcode_stato("inErrore", kst_tab_pl_barcode) 

	throw kuo_exception1

finally
	destroy kuf1_pl_barcode
	SetPointer(oldpointer)

end try


return k_return

end function

public function st_esito set_posizione_pl_barcode_nel_pilota (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Imposta un eventuale posizione in cui la Pianificazione sara' inserita nel Pilota
//---   ovvero controlla se il Piano ha Priorita' URGENTE, e se e' cosi' lo inserisce al primo barcode disponibile alla lavorazione 
//---   
//---	Input: REF. di kst_tab_pl_barcode con il campo PRIORITA impostato
//---	Output:  kst_tab_pl_barcode con il campo PRIMA_DEL_BARCODE impostato
//---
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_nome, k_valore
uo_exception kuo_exception
kuf_pl_barcode kuf1_pl_barcode

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

try 

	kuf1_pl_barcode = create kuf_pl_barcode

	if kuf1_pl_barcode.if_pl_barcode_priorita_urgente(kst_tab_pl_barcode) then
		
//--- Connessione al DB-PILOTA
		KGuo_sqlca_db_pilota.db_connetti()
		
//--- Restituire il primo barcode disponibile alla lavorazione interroga il PILOTA

	end if
catch (uo_exception kuo_exception1 )
		throw kuo_exception1
finally
		destroy kuf1_pl_barcode
	 	SetPointer(oldpointer)
end try


return kst_esito

end function

public subroutine if_isnull_pilota_cmd (ref st_tab_pilota_cmd kst_tab_pilota_cmd);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_pilota_cmd.num_rich) then kst_tab_pilota_cmd.num_rich = 0
if isnull(kst_tab_pilota_cmd.data_ins) then kst_tab_pilota_cmd.data_ins = datetime(date(0))
if isnull(kst_tab_pilota_cmd.tipo) then kst_tab_pilota_cmd.tipo = 0
if isnull(kst_tab_pilota_cmd.path) then	kst_tab_pilota_cmd.path = " "
if isnull(kst_tab_pilota_cmd.pfile) then	kst_tab_pilota_cmd.pfile = " "
if isnull(kst_tab_pilota_cmd.stato) then	kst_tab_pilota_cmd.stato = " "
if isnull(kst_tab_pilota_cmd.pl_barcode_codice) then	kst_tab_pilota_cmd.pl_barcode_codice = 0
if isnull(kst_tab_pilota_cmd.utente) then	kst_tab_pilota_cmd.utente = " "
if isnull(kst_tab_pilota_cmd.prima_del_barcode) then	kst_tab_pilota_cmd.prima_del_barcode = " "
if isnull(kst_tab_pilota_cmd.data_inizio) then	kst_tab_pilota_cmd.data_inizio = datetime(date(0))
if isnull(kst_tab_pilota_cmd.data_fine) then	kst_tab_pilota_cmd.data_fine = datetime(date(0))


end subroutine

public function boolean tb_aggiorna_cfg_num_rich () throws uo_exception;//
//--- Leggo Contratto specifico
//
boolean k_return = true
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if isnull(kist_tab_pilota_cfg.st_tab_g_0.esegui_commit) or kist_tab_pilota_cfg.st_tab_g_0.esegui_commit <> "N" then
		kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = "S"
	end if

//	
	update  pilota_cfg
		set ultimo_progressivo_richiesta = :kist_tab_pilota_cfg.ultimo_progressivo_richiesta
		 ,ultimo_nome_file_pl_barcode = :kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode
		where 
		codice = :kist_tab_pilota_cfg.codice
		using sqlca;

	
	if sqlca.sqlcode = 0 then
		if kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = 'S' then
			commit using sqlca;
		end if
	else
		if kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = 'S' then
			rollback using sqlca;
		end if

		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento della Tab.Config.Pilota  (PILOTA_CFG codice=" + string(kist_tab_pilota_cfg.codice) + ")  ~n~r"  &
									 + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
			end if
		end if
	end if

	SetPointer(oldpointer)
	
	
return k_return



end function

public function boolean scrivi_tab_richieste_pianificazione (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Scrive nella Tabella PILOTA_CMD la nuova Richieste al Pilota 
//---   Codice Richiesta 1 = invio pianificazione al pilota
//---  
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---             la struttura st_tab_pl_barcode gia' valorizzata
//---   Output: la struttura st_tab_pilota_cmd bella valorizzata
//---
boolean k_return=true
string k_nome_file
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
//--- Valorizza i campi
//--- nome del file in base al tipo di Richiesta
	if kist_tab_pilota_cfg.tipo_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli then
		k_nome_file = kist_tab_pilota_cfg.file_richieste_figli
	else
		k_nome_file = kist_tab_pilota_cfg.file_richieste
	end if

	kist_tab_pilota_cmd.num_rich = kist_tab_pilota_cfg.ultimo_progressivo_richiesta + 1
	kist_tab_pilota_cmd.tipo = kist_tab_pilota_cfg.tipo_richiesta
	kist_tab_pilota_cmd.path =  kist_tab_pilota_cfg.path_pilota_out
	kist_tab_pilota_cmd.pfile =  k_nome_file
	kist_tab_pilota_cmd.utente =  kGuf_data_base.prendi_x_utente()
	kist_tab_pilota_cmd.data_ins =  kGuf_data_base.prendi_x_datins() 
	kist_tab_pilota_cmd.stato = ki_stato_in_attesa 
	kist_tab_pilota_cmd.pl_barcode_codice = kst_tab_pl_barcode.codice 
	kist_tab_pilota_cmd.prima_del_barcode = kst_tab_pl_barcode.prima_del_barcode 
	kist_tab_pilota_cmd.path_file_pl_barcode =  get_path_file_pl_barcode()+get_file_pl_barcode()

	if_isnull_pilota_cmd(kist_tab_pilota_cmd)
		
	try
//--- SCRIVE nella Tabella
		tb_insert_tab_pilota_cmd()
	catch (uo_exception kuo_exception1)
		throw kuo_exception1
	finally
		SetPointer(oldpointer)
	end try
	
	
return k_return

end function

public subroutine set_blocca_richieste (st_tab_pilota_cfg kst_tab_pilota_cfg) throws uo_exception;//---
//--- Imposta il flag di Blocco delle richieste
//---
//--- Imput: impostare il flag st_tab_pilota_cfg.blocca_richieste
//---
st_esito kst_esito
uo_exception kuo_exception
pointer koldpointer




kst_esito.esito =kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
koldpointer = SetPointer(HourGlass!)


if isnull(kist_tab_pilota_cfg.st_tab_g_0.esegui_commit) or kist_tab_pilota_cfg.st_tab_g_0.esegui_commit <> "N" then
	kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = "S"
end if


//
//if k_bool then
//	kist_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_si
//else
//	kist_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_no
//end if

update pilota_cfg
	set blocca_richieste = :kst_tab_pilota_cfg.blocca_richieste
	where codice = '1'
	using sqlca;
	
	
if sqlca.sqlcode = 0 then
	if kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = 'S' then
		commit using sqlca;
	end if
else
	if kist_tab_pilota_cfg.st_tab_g_0.esegui_commit = 'S' then
		rollback using sqlca;
	end if
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore in Aggiornamento della Tab.Config. Pilota  (PILOTA_CFG)  ~n~r"  &
								 + trim(sqlca.SQLErrText)
								 
	if sqlca.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd
	else
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else	
			kst_esito.esito = kkg_esito.db_ko
			kuo_exception.set_esito (kst_esito)
			throw kuo_exception
		end if
	end if
end if

SetPointer(koldpointer)
	

end subroutine

public function transaction get_profilo_db () throws uo_exception;//---
//--- Torna il profilo DB x la Connessione
//---
kuo_sqlca_db_pilota kuo_sqlca


kuo_sqlca = create  kuo_sqlca_db_pilota

get_pilota_cfg()

//--- Recupera le info x la connessione
if kist_tab_pilota_cfg.cfg_dbms_scelta = ki_cfg_dbms_scelta_princ then
	kuo_sqlca.DBMS = kist_tab_pilota_cfg.cfg_dbms
	kuo_sqlca.DBParm = kist_tab_pilota_cfg.cfg_dbparm
else
	kuo_sqlca.DBMS = kist_tab_pilota_cfg.cfg_dbms_alt
	kuo_sqlca.DBParm = kist_tab_pilota_cfg.cfg_dbparm_alt
end if

//this.DBMS = profilestring ( k_file, k_sezione , "DBMS", "nessuno")
//this.DBParm = profilestring (k_file, k_sezione, "DbParm", "")
//this.Database = profilestring (k_file, k_sezione, "Database", "")
//this.UserId = profilestring (k_file, k_sezione, "UserId", "informix")
//this.DBPass = profilestring (k_file, k_sezione, "DBPass", "infoxgamma")
//this.LogPass = profilestring (k_file, k_sezione, "LogPass", "infoxgamma")
//this.LogId = profilestring (k_file, k_sezione, "LogId", "informix")
//this.ServerName = profilestring (k_file, k_sezione, "ServerName", "")
//if lower(profilestring (k_file, k_sezione, "AutoCommit", "false")) = "true" then

if kist_tab_pilota_cfg.cfg_autocommit = "true" then
	kuo_sqlca.AutoCommit = true
else
	kuo_sqlca.AutoCommit = false
end if

return kuo_sqlca

end function

public function boolean check_sblocca_richiesta () throws uo_exception;//---
//--- Se flag di "richiesta bloccata"  allora verifico se può essere sbloccata e se previsto lo faccio
//--- Imput: nulla
//--- Ouput: TRUE=flag modificato, FALSE=flag come prima
//---
//--- Lancia un EXCEPTION se errore grave
//---
boolean k_return=false
st_tab_pilota_cfg kst_tab_pilota_cfg
st_esito kst_esito
st_tab_pilota_impostazioni kst_tab_pilota_impostazioni
uo_exception kuo_exception
pointer koldpointer




kst_esito.esito =kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
koldpointer = SetPointer(HourGlass!)




select blocca_richieste
	into :kist_tab_pilota_cfg.blocca_richieste
	from pilota_cfg
	where codice = '1'
	using sqlca;
	
	
if sqlca.sqlcode <> 0 then

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura della Tab.Config. Pilota  (PILOTA_CFG)  ~n~r"  &
									 + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception.set_esito (kst_esito)
		throw kuo_exception
	end if
	
else

//--- Se la coda sul pilota si sta esaurendo allora cambio il FLAG e SBLOCCO LE RICHIESTE
	kst_tab_pilota_impostazioni = get_pilota_pilota_impostazioni()
	if kst_tab_pilota_impostazioni.num_intouchable = 0 then kst_tab_pilota_impostazioni.num_intouchable = 3
	if kst_tab_pilota_impostazioni.num_intouchable > conta_queue_table() then
		kst_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_no
		set_blocca_richieste(kst_tab_pilota_cfg)
		k_return=true
	end if
	
end if

SetPointer(koldpointer)
	

return k_return


end function

public function st_tab_pilota_impostazioni get_pilota_pilota_impostazioni () throws uo_exception;//---
//---   Legge il file di configurazione del Pilota 
//---
//--- Output: st_tab_pilota_impostazioni
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_variabile, k_valore
st_tab_pilota_impostazioni kst_tab_pilota_impostazioni

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kguo_sqlca_db_pilota.db_connetti()

declare c_get_pilota_pilota_impostazioni cursor for 
	  SELECT variabile 
   	      		,valore  
    FROM impostazioni
	 using kguo_sqlca_db_pilota;

kst_tab_pilota_impostazioni = st_tab_pilota_impostazioni_inizializza()

open c_get_pilota_pilota_impostazioni;

fetch c_get_pilota_pilota_impostazioni
    INTO 
	 	:k_variabile   
         ,:k_valore ;
	
do while kguo_sqlca_db_pilota.sqlcode = 0 

	choose case k_variabile
		case "num_intouchable"
			if isnumber(k_valore) then
				kst_tab_pilota_impostazioni.num_intouchable = integer(k_valore)
				kst_tab_pilota_impostazioni.num_intoccabili_fila1 = integer((kst_tab_pilota_impostazioni.num_intouchable /4) * 3)   // i 3/4 sono di fila 1
				kst_tab_pilota_impostazioni.num_intoccabili_fila2 = kst_tab_pilota_impostazioni.num_intouchable - kst_tab_pilota_impostazioni.num_intoccabili_fila1   // solo 1/4 sono di fila 2
			else
				kst_tab_pilota_impostazioni.num_intouchable = 0
				kst_tab_pilota_impostazioni.num_intoccabili_fila1 = 0
				kst_tab_pilota_impostazioni.num_intoccabili_fila2 = 0
			end if
			
		case "tre_num_intouchable"
			if isnumber(k_valore) then
				kst_tab_pilota_impostazioni.tre_num_intouchable = integer(k_valore)
			else
				kst_tab_pilota_impostazioni.tre_num_intouchable = 0
			end if
		case "station_timeout"
			if isnumber(k_valore) then
				kst_tab_pilota_impostazioni.station_timeout = integer(k_valore)
			else
				kst_tab_pilota_impostazioni.station_timeout = 0
			end if
		case "loc_directory"
			if not isnull(k_valore) then
				kst_tab_pilota_impostazioni.loc_directory = trim(k_valore)
			else
				kst_tab_pilota_impostazioni.loc_directory = " "
			end if
		case "path_scambio"
			if not isnull(k_valore) then
				kst_tab_pilota_impostazioni.path_scambio = trim(k_valore)
			else
				kst_tab_pilota_impostazioni.path_scambio = " "
			end if
		case "coda_minima"
			if isnumber(k_valore) then
				kst_tab_pilota_impostazioni.coda_minima = integer(k_valore)
			else
				kst_tab_pilota_impostazioni.coda_minima = 0
			end if
	end choose

	fetch c_get_pilota_pilota_impostazioni
    		INTO 
	 	:k_variabile   
         ,:k_valore ;


loop
	
if kguo_sqlca_db_pilota.sqlcode <> 0 then
	if kguo_sqlca_db_pilota.sqlcode < 0 then
		
		kst_esito.esito = KKG_esito.DB_KO
		kst_esito.sqlcode = kguo_sqlca_db_pilota.sqlcode
		kst_esito.SQLErrText = trim(kguo_sqlca_db_pilota.sqlerrtext) + "~n~r" + &
				"Codice : " + string(kguo_sqlca_db_pilota.sqldbcode, "#####") + "~n~r" +&
				kguo_sqlca_db_pilota.sqlreturndata

		SetPointer(oldpointer)

		close c_get_pilota_pilota_impostazioni;
		kguo_sqlca_db_pilota.db_disconnetti( )
	
//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
end if

close c_get_pilota_pilota_impostazioni;
kguo_sqlca_db_pilota.db_disconnetti( )
	
SetPointer(oldpointer)


return kst_tab_pilota_impostazioni

end function

public function st_tab_pilota_impostazioni st_tab_pilota_impostazioni_inizializza ();//---
//--- Inizializza i campi della struttura 
//---
st_tab_pilota_impostazioni kst_tab_pilota_impostazioni

kst_tab_pilota_impostazioni.num_intouchable = 0
kst_tab_pilota_impostazioni.tre_num_intouchable = 0
kst_tab_pilota_impostazioni.station_timeout = 0
kst_tab_pilota_impostazioni.loc_directory = " "
kst_tab_pilota_impostazioni.path_scambio = " "
kst_tab_pilota_impostazioni.coda_minima = 0

return kst_tab_pilota_impostazioni

end function

public function integer conta_queue_table () throws uo_exception;//
//--- Leggo Contratto specifico
//
long k_return=0
st_esito kst_esito
pointer koldpointer


koldpointer=SetPointer(hourglass!)

kst_esito.esito =kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kguo_sqlca_db_pilota.db_connetti( )
	
select count(*)
	 into :k_return
		from queue_table
		using kguo_sqlca_db_pilota;

if sqlca.sqlcode <> 0 then
	if sqlca.sqlcode < 0 then
		
		kst_esito.esito = KKG_esito.DB_KO
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + "Codice : " + string(sqlca.sqldbcode, "#####") + "~n~r" +	sqlca.sqlreturndata
		SetPointer(koldpointer)

		kguo_sqlca_db_pilota.db_disconnetti( )

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
end if

kguo_sqlca_db_pilota.db_disconnetti( )
	
SetPointer(koldpointer)
	
return k_return



end function

public function boolean scrivi_tab_richieste_sost_coda (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Scrive nella Tabella PILOTA_CMD la nuova Richieste al Pilota 
//---   Codice Richiesta 3 = invio intera Coda di programmazione da Sostituire nel Pilota
//---  
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---             la struttura st_tab_pl_barcode gia' valorizzata
//---   Output: la struttura st_tab_pilota_cmd bella valorizzata
//---
boolean k_return=true
st_esito kst_esito
kuf_pl_barcode kuf1_pl_barcode
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	
//	if kst_tab_pl_barcode.codice > 0 then
//--- Valorizza i campi
		kist_tab_pilota_cmd.num_rich = kist_tab_pilota_cfg.ultimo_progressivo_richiesta + 1
		kist_tab_pilota_cmd.tipo = kist_tab_pilota_cfg.tipo_richiesta 
		kist_tab_pilota_cmd.path =  kist_tab_pilota_cfg.path_pilota_out
		kist_tab_pilota_cmd.pfile =  kist_tab_pilota_cfg.file_richieste
		kist_tab_pilota_cmd.utente =  kGuf_data_base.prendi_x_utente()
		kist_tab_pilota_cmd.data_ins =  kGuf_data_base.prendi_x_datins() 
		kist_tab_pilota_cmd.stato = ki_stato_in_attesa 
		kist_tab_pilota_cmd.pl_barcode_codice = 0 // non c'e' codice di Pianificazione 
		kist_tab_pilota_cmd.prima_del_barcode = " " // sostituisce l'intera coda di programmazione
		kist_tab_pilota_cmd.path_file_pl_barcode =  get_path_file_pl_barcode()+get_file_pl_barcode()
	
		if_isnull_pilota_cmd(kist_tab_pilota_cmd)
			
		try
	//--- SCRIVE nella Tabella
			tb_insert_tab_pilota_cmd()
		catch (uo_exception kuo_exception1)
			throw kuo_exception1
		finally
			SetPointer(oldpointer)
		end try
//	else
//		kist_tab_pilota_cmd.num_rich = 0
//	end if
	
	
return k_return

end function

public function boolean job_sostituzione_programmazione_pilota (ds_pl_barcode kds_pl_barcode) throws uo_exception;//---
//---   Genera una Richiesta di sostituzione della Coda di Programmazione del 'Pilota'  
//---   
//--- Input: la datastore ds_pl_barcode contenente i Nuovi dati di Programmazione dell'impianto
//--- Output: TRUE=operazione effettuata, FALSE=operazione interrrotta
//---

boolean k_return = false
string k_errore
string k_path_pilota, k_path_temp, k_file_nome
kuf_pl_barcode kuf1_pl_barcode
st_tab_pl_barcode kst_tab_pl_barcode
uo_exception kuo1_exception
//ds_pl_barcode kds_pl_barcode_figli



try
		kuf1_pl_barcode = create kuf_pl_barcode

//=== Controlla e Aggiorna lo stato di evasione Richieste al Pilota
		if job_evasione_Richieste() then 

//=== leggo tabella di configurazione
			get_pilota_cfg()
			k_path_pilota = get_path_file_pl_barcode() //get path x scambio con PILOTA
			k_path_temp = get_path_temp( ) //get path temporaneo
			k_file_nome = get_file_pl_barcode() //get nome file

//--- Scrive le righe con i BARCODE x la richiesta PADRE		
			if kuf1_pl_barcode.crea_file_pilota_padri(kds_pl_barcode, k_file_nome, k_path_temp, k_path_pilota) then

//=== Crea il nuovo record di Richiesta nella tabella PILOTA_CMD
				kist_tab_pilota_cfg.tipo_richiesta = kki_tipo_richiesta_sost_pl_padri
				if scrivi_tab_richieste_sost_coda(kst_tab_pl_barcode) then

//=== Crea il nuovo FILE Richiesta ==========================
					scrivi_file_richieste()
					k_return = true
					
//--- Aggiorna "progressivo richiesta e nome file piano di lav." nella tabella di config. pilota PILOTA_CFG	
					kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode = get_file_pl_barcode()
					kist_tab_pilota_cfg.ultimo_progressivo_richiesta = kist_tab_pilota_cmd.num_rich
					tb_aggiorna_cfg_num_rich()

				end if
				
			end if

//=== Flag di Generazione File Figli attivo?
			if kist_tab_pilota_cfg.flag_genera_file_figli = kki_flag_genera_file_figli_SI then 
				
//--- Piglia i figli dal DS di padri
//ds_pl_barcode kds_pl_barcode_figli
//				kds_pl_barcode_figli = kuf1_pl_barcode.get_ds_barcode_figli_da_padri(kds_pl_barcode)

//				if kds_pl_barcode_figli.rowcount() > 0 then
				if kds_pl_barcode.rowcount() > 0 then
					
//--- Scrive le righe con i BARCODE x la richiesta FIGLI		
//					if kuf1_pl_barcode.crea_file_pl_barcode_figli_x_pilota(kds_pl_barcode_figli) then
					if kuf1_pl_barcode.crea_file_pilota_figli(kds_pl_barcode) then

//=== Crea il nuovo record di Richiesta nella tabella PILOTA_CMD
						kist_tab_pilota_cfg.tipo_richiesta = kki_tipo_richiesta_sost_pl_figli
						if scrivi_tab_richieste_sost_coda(kst_tab_pl_barcode) then

//=== Crea il nuovo FILE Richiesta ==========================
							scrivi_file_richieste()
							k_return = true
					
//--- Aggiorna "progressivo richiesta e nome file piano di lav." nella tabella di config. pilota PILOTA_CFG	
							kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode = get_file_pl_barcode()
							kist_tab_pilota_cfg.ultimo_progressivo_richiesta = kist_tab_pilota_cmd.num_rich
							tb_aggiorna_cfg_num_rich()

						end if
						
					end if
				end if
			end if

		else
			kuo1_exception = create uo_exception 
			kuo1_exception.set_tipo(kuo1_exception.KK_st_uo_exception_tipo_allerta)
			kuo1_exception.setmessage("Non risulta ancora Evasa l'ultima Richiesta al Pilota.~n~r" &
		                                        +"L'operazione non puo' essere effettuata, rischio di 'Inconsistenza Dati nel Pilota'.~n~r" &
											+"Uscire dalla Funzione.") //--- errore

			throw kuo1_exception
			
		end if
		
catch(uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()  //--- errore
	throw kuo_exception
	
finally
	destroy kuf1_pl_barcode
end try


return k_return

end function

public function boolean job_evasione_richieste () throws uo_exception;//---
//---   Job di Controllo e Aggiornamento delle Richieste EVASE 
//---
//--- Output: TRUE = Richiesta Evasa/Scaduta, FALSE = Richieste ancora in Attesa di Risposta
//---
boolean k_return = false
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
boolean k_crea_nuova_richiesta=false
st_txt_pilota_cmd kst_txt_pilota_cmd
st_txt_pilota_answer kst_txt_pilota_answer
st_tab_pl_barcode kst_tab_pl_barcode
kuf_pl_barcode kuf1_pl_barcode
uo_exception kuo_exception


//=== Puntatore Cursore da attesa..... 
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

k_crea_nuova_richiesta = false

try 

	kuf1_pl_barcode = create kuf_pl_barcode

//=== leggo tabella di configurazione
	get_pilota_cfg()

//=== leggo file delle Richieste al Pilota (probabile COMMAND.TXT)
	kst_txt_pilota_cmd = get_file_richieste_progressivi()

//=== file Richieste e' gia' stato CANCELLATO 
	if kst_txt_pilota_cmd.progressivo_richiesta = 0 then

//--- per cui setto la variabile di stato a 'crea nuova richiesta' 		
		k_crea_nuova_richiesta = true
	
	else
		
//=== leggo tabella Richieste al Pilota PILOTA_CMD Padre
		kist_tab_pilota_cmd.num_rich = kst_txt_pilota_cmd.progressivo_richiesta_padre
		kst_esito = select_riga() //--- legge lo STATO della Richiesta se EVASA
		if kist_tab_pilota_cmd.stato <> ki_stato_evasa then
//=== leggo tabella Richieste al Pilota PILOTA_CMD Figli
			kist_tab_pilota_cmd.num_rich = kst_txt_pilota_cmd.progressivo_richiesta_filgli
			kst_esito = select_riga() //--- legge lo STATO della Richiesta se EVASA
		end if 
	
//=== file Richieste gia' evaso
		if kist_tab_pilota_cmd.stato = ki_stato_evasa then
		
//=== Cancella il file Richieste
//			cancella_file_richieste(kist_tab_pilota_cmd)

//--- setto la variabile di stato a 'crea nuova richiesta' 		
			k_crea_nuova_richiesta = true
		else	

//=== leggo file degli Esiti del Pilota (probabile ANSWER.TXT)
			kst_txt_pilota_answer = leggi_file_risposte_pilota()
		
//=== Se answer x Padre o Figli allora controlla se Richiesta ho gia' l'Esito
			if kst_txt_pilota_answer.progressivo_richiesta = kst_txt_pilota_cmd.progressivo_richiesta &
			        or kst_txt_pilota_answer.progressivo_richiesta = kst_txt_pilota_answer.progressivo_richiesta then

//=== controllo se Esito positivo....
				if file_risposte_risultato_ok(kst_txt_pilota_answer)  then

//--- aggiornare lo stato della tabella PL_BARCODE a "piano consegnato al pilota"		
					if kist_tab_pilota_cmd.pl_barcode_codice > 0 then
						kst_tab_pl_barcode.codice = kist_tab_pilota_cmd.pl_barcode_codice
						kuf1_pl_barcode.set_pl_barcode_stato("consegnato", kst_tab_pl_barcode)
					end if
					
					kist_tab_pilota_cmd.stato = ki_stato_evasa

				else
//--- Se Esito NEGATIVO aggiorna la richiesta.... 
					
//--- aggiornare lo stato della tabella PL_BARCODE a "piano respinto dal pilota"		
					if kist_tab_pilota_cmd.pl_barcode_codice > 0 then
						kst_tab_pl_barcode.codice = kist_tab_pilota_cmd.pl_barcode_codice
						kuf1_pl_barcode.set_pl_barcode_stato("respinto", kst_tab_pl_barcode)
					end if
					kist_tab_pilota_cmd.stato = ki_stato_respinta
				end if
				
//--- aggiornare lo stato della tabella PILOTA_CMD a "Richiesta Esitata"			
				tb_aggiorna_stato_evasa()
				
//=== Cancella il file Richieste (COMMAND.TXT) ---------------------------------------------------------------------------------------

//--- se x caso l'archivio dei cmd non e' valorizzato allora lo valorizzo coi dati letti prima dal COMMAND e cancello il file giusto  
				if LenA(trim(kist_tab_pilota_cmd.pfile)) = 0 then
					kist_tab_pilota_cmd.path = kst_txt_pilota_cmd.file_richieste_path
					kist_tab_pilota_cmd.pfile = kst_txt_pilota_cmd.file_richieste_nome
				end if
				//cancella_file_richieste(kist_tab_pilota_cmd)
				
//=== Fine Cancella il file Richieste ------------------------------------------------------------------------------------------------------

//--- setto la variabile di stato a 'crea nuova richiesta' 		
				k_crea_nuova_richiesta = true

			else
				
//--- Se file Esito non ESISTE verifica se Richiesta in Time-Out
				if richiesta_in_timeout() then

//--- setto la variabile di stato a 'crea nuova richiesta' 		
					k_crea_nuova_richiesta = true
				end if
			
			end if
		end if
	end if


catch (uo_exception kuo_exception1 )
	kst_esito = kuo_exception1.get_st_esito()
	throw kuo_exception1
finally
	destroy kuf1_pl_barcode
	SetPointer(oldpointer)

end try


k_return = k_crea_nuova_richiesta		

return k_return

end function

public function st_tab_pilota_queue get_pilota_pilota_barcode_h_primo_queue () throws uo_exception;//---
//---   Legge dal Pilota nella tabella Queue il primo barcode in posizione h da trattare dopo gli intoccabili
//---
//--- Output: st_tab_pilota_queue con il barcode valorizzato
//---
integer k_intoccabili_fila1, k_intoccabili_fila2
string k_CicliFila1, k_CicliFila2, k_CicliFila1p, k_CicliFila2p
boolean k_insert_intoccabili, k_uscita
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
st_tab_pilota_queue kst_tab_pilota_queue
st_tab_pilota_impostazioni kst_tab_pilota_impostazioni


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kguo_sqlca_db_pilota.db_connetti()


//	SELECT  queue_table.Ordine ,
//           queue_table.Barcode ,
//           queue_table.Posizione 
//        FROM queue_table inner join impostazioni on
//                      queue_table.ordine > cast(impostazioni.valore as decimal)
//		where queue_table.Posizione = 'H'
//			and impostazioni.variabile = 'num_intouchable'
//			order by queue_table.Ordine
//		 using kguo_sqlca_db_pilota;

//--- recupera i dati di configurazione sul pilota
kst_tab_pilota_impostazioni = get_pilota_pilota_impostazioni()
k_intoccabili_fila1 = kst_tab_pilota_impostazioni.num_intoccabili_fila1 
k_intoccabili_fila2 = kst_tab_pilota_impostazioni.num_intoccabili_fila2 

declare c_get_pilota_queue cursor for 
	SELECT 
           queue_table.Ordine ,
           queue_table.Barcode ,
           queue_table.Posizione ,
           queue_table.CicliFila1  ,
           queue_table.CicliFila2 ,
           queue_table.CicliFila1P  ,
           queue_table.CicliFila2P 
        FROM queue_table
		where 
			queue_table.Posizione = 'H'
		order by queue_table.Ordine
		 using kguo_sqlca_db_pilota;

open c_get_pilota_queue;

fetch c_get_pilota_queue
    INTO 
           :kst_tab_pilota_queue.Ordine ,
           :kst_tab_pilota_queue.Barcode ,
           :kst_tab_pilota_queue.Posizione ,
           :k_CicliFila1,
           :k_CicliFila2,
           :k_CicliFila1p,
           :k_CicliFila2p
          ;
	
if kguo_sqlca_db_pilota.sqlcode = 0 then

	k_uscita = false
	do while  kguo_sqlca_db_pilota.sqlcode = 0 and not k_uscita 

		if isnumber(k_CicliFila1) then
			kst_tab_pilota_queue.CicliFila1 = integer(k_CicliFila1)
		else
			kst_tab_pilota_queue.CicliFila1 = 0
		end if
		if isnumber(k_CicliFila1p) then
			kst_tab_pilota_queue.CicliFila1p = integer(k_CicliFila1p)
		else
			kst_tab_pilota_queue.CicliFila1p = 0
		end if
		if isnumber(k_CicliFila2) then
			kst_tab_pilota_queue.CicliFila2 = integer(k_CicliFila2)
		else
			kst_tab_pilota_queue.CicliFila2 = 0
		end if
		if isnumber(k_CicliFila2p) then
			kst_tab_pilota_queue.CicliFila2p = integer(k_CicliFila2p)
		else
			kst_tab_pilota_queue.CicliFila2p = 0
		end if
	
//--- vedo se devo inserire Intoccabili in fila 1 o 2
		if k_intoccabili_fila1 > 0 then
			if kst_tab_pilota_queue.CicliFila1 > 0 then
				k_intoccabili_fila1 -= 2
			else
				if k_intoccabili_fila2 > 0 then
					if kst_tab_pilota_queue.CicliFila2 > 0 then
						k_intoccabili_fila2 -= 2
					end if
				end if
			end if
		else

//--- se ctr di fila 1 azzerato			
			if k_intoccabili_fila2 > 0 then
				if kst_tab_pilota_queue.CicliFila2 > 0 then
					k_intoccabili_fila2 --
				else
//--- esco dal ciclo se ho finito i contatori di fila 1 a zero e ho un altro barcode di fila 1 			
					k_uscita = true 
				end if
			else
//--- esco dal ciclo se ho finito i contatori di fila 1 e fila 2 			
				k_uscita = true 
			end if
		end if
		 
	
		fetch c_get_pilota_queue
			 INTO 
				  :kst_tab_pilota_queue.Ordine ,
				  :kst_tab_pilota_queue.Barcode ,
				  :kst_tab_pilota_queue.Posizione ,
				  :k_CicliFila1,
				  :k_CicliFila2,
				  :k_CicliFila1p,
				  :k_CicliFila2p
				 ;

	loop 

//--- valorizzo il barcode 
	if k_uscita then
		kst_tab_pilota_queue.Barcode = trim(kst_tab_pilota_queue.Barcode)
	end if

else
	kst_tab_pilota_queue.Barcode = " "
	if kguo_sqlca_db_pilota.sqlcode < 0 then
		
		kst_esito.esito = KKG_esito.DB_KO
		kst_esito.sqlcode = kguo_sqlca_db_pilota.sqlcode
		kst_esito.SQLErrText = trim(kguo_sqlca_db_pilota.sqlerrtext) + "~n~r" + &
				"Codice : " + string(kguo_sqlca_db_pilota.sqldbcode, "#####") + "~n~r" +&
				kguo_sqlca_db_pilota.sqlreturndata

		close c_get_pilota_queue;
		SetPointer(oldpointer)

		kguo_sqlca_db_pilota.db_disconnetti( )

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
end if

close c_get_pilota_queue;
kguo_sqlca_db_pilota.db_disconnetti( )
	
SetPointer(oldpointer)


return kst_tab_pilota_queue

end function

public function string get_blocca_richieste () throws uo_exception;//---
//--- Imposta il flag di Blocco delle richieste
//---
st_tab_pilota_cfg kst_tab_pilota_cfg
st_esito kst_esito
uo_exception kuo_exception
pointer koldpointer




kst_esito.esito =kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

//=== Puntatore Cursore da attesa.....
koldpointer = SetPointer(HourGlass!)




select blocca_richieste
	into :kst_tab_pilota_cfg.blocca_richieste
	from pilota_cfg
	where codice = '1'
	using sqlca;
	
	
if sqlca.sqlcode <> 0 then
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore in Lettura della Tab.Config. Pilota  (PILOTA_CFG)  ~n~r"  &
								 + trim(sqlca.SQLErrText)
								 
	if sqlca.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd
	else
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		end if
	end if

	kst_esito.esito = kkg_esito.db_ko
	kuo_exception.set_esito (kst_esito)
	throw kuo_exception

else

	if isnull(kst_tab_pilota_cfg.blocca_richieste) then kst_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_no 

//--- Se richieste bloccate, controllo se e' giusto
	if kst_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_si then
//--- Se ho modificato il flag rimetto lo sblocco nelle richieste
		if check_sblocca_richiesta()	then
			kst_tab_pilota_cfg.blocca_richieste = ki_blocca_richieste_no
		end if
	end if
		


end if

SetPointer(koldpointer)
	

return kst_tab_pilota_cfg.blocca_richieste


end function

public function st_txt_pilota_cmd leggi_file_richieste_padri () throws uo_exception;//---
//---   Legge il file delle Richieste al Pilota (probabilmente COMMAND.TXT e COMMAND_GRP.TXT) e lo converte 
//---   nella struttura st_txt_pilota_cmd, in ottemperanza al valore 'codice richiesta' presente nel file
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---
st_txt_pilota_cmd kst_txt_pilota_cmd
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len 	
string k_record
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

	
//--- Inizializzo i campi
kst_txt_pilota_cmd.progressivo_richiesta = 0
kst_txt_pilota_cmd.codice_richiesta = 0
kst_txt_pilota_cmd.path_fl_pilota = " "
kst_txt_pilota_cmd.prima_del_barcode = " "
kst_txt_pilota_cmd.utente = " "
kst_txt_pilota_cmd.data_inizio = datetime(date(0))
kst_txt_pilota_cmd.data_fine = datetime(date(0))
kst_txt_pilota_cmd.file_richieste_path= trim(kist_tab_pilota_cfg.path_pilota_out)
kst_txt_pilota_cmd.file_richieste_nome= trim(kist_tab_pilota_cfg.file_richieste_figli)


//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono?
if not DirectoryExists ( kist_tab_pilota_cfg.path_pilota_out ) then
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Cartella di scambio file diretti al Pilota Non Trovata: " + kist_tab_pilota_cfg.path_pilota_out 
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
end if

//--- Esiste il file ?
if  not FileExists ( kist_tab_pilota_cfg.path_pilota_out+ kist_tab_pilota_cfg.file_richieste) then
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = k_byte
	kst_esito.SQLErrText = "File 'Richieste al Pilota' non Trovato: ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste

else
//--- open del file 
	k_FileNum = FileOpen((kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste), LineMode!, Read!, Shared!)
	
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Apertura fallita dell'archivio 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste
		kuo_exception.set_esito (kst_esito)
		throw kuo_exception
	end if
				
	
	k_byte = FileRead(k_FileNum, k_record)
		
	choose case k_byte
	
	//--- EOF
			case -100
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Fine del file 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste
	//			kuo_exception.set_esito (kst_esito)
	//			throw kuo_exception
	
	//--- Errore grave
			case is < 0
				FileClose(k_FileNum)
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Lettura fallita del record 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
	
	//--- Rec vuoto
			case 0
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "File Vuoto 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste
	//			kuo_exception.set_esito (kst_esito)
	//			throw kuo_exception
	
	//--- Se lettura OK riempie i campi e controlla se dati formalmente corretti		
			case else
				
				k_pos_ctr_ini = 1
				k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
				if k_pos_ctr_fin > 0 then
					k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
					if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
						kst_txt_pilota_cmd.progressivo_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Errore Formato Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
					end if
				else
					kst_esito.esito = kkg_esito.ERR_FORMALE
					kst_esito.sqlcode = k_byte
					kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
													+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
				end if
				
				if kst_esito.esito = kkg_esito.ok then
					k_pos_ctr_ini = k_pos_ctr_fin + 1
					k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
					if k_pos_ctr_fin > 0 then
						k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
						if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
							kst_txt_pilota_cmd.codice_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Errore Formato Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
						end if
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
					end if
				end if
				
				if kst_esito.esito = kkg_esito.ok then
					
	//--- Se richiesta codice 1 ovvero consegna flusso pilota.....
					if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_padri or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_padri then   
	
	//--- campo parametri: cartella di scambio M2000 - Pilota con il file della Pianificazione
						k_pos_ctr_ini = k_pos_ctr_fin + 1
						k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
						if k_pos_ctr_fin > 0 then
							k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
							if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
								kst_txt_pilota_cmd.path_fl_pilota = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
							else
								kst_esito.esito = kkg_esito.ERR_FORMALE
								kst_esito.sqlcode = k_byte
								kst_esito.SQLErrText = "Manca Nome della Cartella del file di Pianificazione , nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
																+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
							end if
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Nome Cartella file di Pianificazione, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
						end if
						
						if kst_esito.esito = kkg_esito.ok then
	//--- campo parametri: barcode di riferimento per inserimento del piano di lavorazione 
							k_pos_ctr_ini = k_pos_ctr_fin + 1
							k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
							if k_pos_ctr_fin > 0 then
								k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
								if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
									kst_txt_pilota_cmd.prima_del_barcode = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
								else
									kst_esito.sqlcode = k_byte
									kst_esito.SQLErrText = "Manca codice Barcode , nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
																	+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
								end if
							else
								kst_esito.sqlcode = k_byte
								kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x codice Barcode, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
																+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
							end if
						end if
						
						if kst_esito.esito = kkg_esito.ok then
	//--- campo parametri: Utente 
							k_pos_ctr_ini = k_pos_ctr_fin + 1
							if k_pos_ctr_fin > 0 then
								k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
							else
								if k_byte >= k_pos_ctr_ini then 
									k_pos_ctr_len = k_byte - k_pos_ctr_ini + 1
								else
									k_pos_ctr_len = 0
								end if
							end if
							if k_pos_ctr_len > 0 then
								if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
									kst_txt_pilota_cmd.utente = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
								else
									kst_esito.sqlcode = k_byte
									kst_esito.SQLErrText = "Manca Utente , nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
																	+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
								end if
							else
								kst_esito.sqlcode = k_byte
								kst_esito.SQLErrText = "Non trovato il campo Utente, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
																+ ") "
							end if
						end if
	
					else
//--- Richiesta non prevista
						kst_esito.esito = kkg_esito.blok
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Errore Codice Richiesta non Gestita, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste &
														+ "~n~r valore:"  + string(kst_txt_pilota_cmd.codice_richiesta) + ") "
		
					end if
	
	
				end if
	
				if kst_esito.esito <> kkg_esito.ok then
					FileClose(k_FileNum)
					kuo_exception.set_esito (kst_esito)
					throw kuo_exception
				end if
	
	
	end choose
	
	FileClose(k_FileNum)
	
end if

SetPointer(oldpointer)
			

return kst_txt_pilota_cmd

end function

public function st_txt_pilota_cmd leggi_file_richieste_figli () throws uo_exception;//---
//---   Legge il file delle Richieste al Pilota (probabilmente COMMAND_GRP.TXT) e lo converte 
//---   nella struttura st_txt_pilota_cmd, in ottemperanza al valore 'codice richiesta' presente nel file
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---
st_txt_pilota_cmd kst_txt_pilota_cmd
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len 	
string k_record
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

	
//--- Inizializzo i campi
kst_txt_pilota_cmd.progressivo_richiesta = 0
kst_txt_pilota_cmd.codice_richiesta = 0
kst_txt_pilota_cmd.path_fl_pilota = " "
kst_txt_pilota_cmd.prima_del_barcode = " "
kst_txt_pilota_cmd.utente = " "
kst_txt_pilota_cmd.data_inizio = datetime(date(0))
kst_txt_pilota_cmd.data_fine = datetime(date(0))
kst_txt_pilota_cmd.file_richieste_path= trim(kist_tab_pilota_cfg.path_pilota_out)
kst_txt_pilota_cmd.file_richieste_nome= trim(kist_tab_pilota_cfg.file_richieste_figli)


//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono?
if not DirectoryExists ( kist_tab_pilota_cfg.path_pilota_out ) then
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Cartella di scambio file diretti al Pilota Non Trovata: " + kist_tab_pilota_cfg.path_pilota_out 
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
end if

//--- Esiste il file ?
if  not FileExists ( trim(kist_tab_pilota_cfg.path_pilota_out)+ trim(kist_tab_pilota_cfg.file_richieste_figli)) then
	kst_esito.esito = kkg_esito.not_fnd
	kst_esito.sqlcode = k_byte
	kst_esito.SQLErrText = "File 'Richieste al Pilota' non Trovato: ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli

else
//--- open del file 
	k_FileNum = FileOpen(trim(kist_tab_pilota_cfg.path_pilota_out)+trim(kist_tab_pilota_cfg.file_richieste_figli), LineMode!, Read!, Shared!)
	
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Apertura fallita dell'archivio 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli
		kuo_exception.set_esito (kst_esito)
		throw kuo_exception
	end if
				
	
	k_byte = FileRead(k_FileNum, k_record)
		
	choose case k_byte
	
	//--- EOF
			case -100
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Fine del file 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli
	//			kuo_exception.set_esito (kst_esito)
	//			throw kuo_exception
	
	//--- Errore grave
			case is < 0
				FileClose(k_FileNum)
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "Lettura fallita del record 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli
				kuo_exception.set_esito (kst_esito)
				throw kuo_exception
	
	//--- Rec vuoto
			case 0
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_byte
				kst_esito.SQLErrText = "File Vuoto 'Richieste al Pilota': ~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli
	//			kuo_exception.set_esito (kst_esito)
	//			throw kuo_exception
	
	//--- Se lettura OK riempie i campi e controlla se dati formalmente corretti		
			case else
				
				k_pos_ctr_ini = 1
				k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
				if k_pos_ctr_fin > 0 then
					k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
					if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
						kst_txt_pilota_cmd.progressivo_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Errore Formato Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
					end if
				else
					kst_esito.esito = kkg_esito.ERR_FORMALE
					kst_esito.sqlcode = k_byte
					kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Progressivo Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
													+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
				end if
				
				if kst_esito.esito = kkg_esito.ok then
					k_pos_ctr_ini = k_pos_ctr_fin + 1
					k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
					if k_pos_ctr_fin > 0 then
						k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
						if isnumber(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) then
							kst_txt_pilota_cmd.codice_richiesta = long(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)))
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Errore Formato Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
						end if
					else
						kst_esito.esito = kkg_esito.ERR_FORMALE
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Codice Richiesta, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
														+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
					end if
				end if
				
				if kst_esito.esito = kkg_esito.ok then
					
	//--- Se richiesta codice 1 ovvero consegna flusso pilota.....
					if kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_invio_nuovo_pl_figli or kst_txt_pilota_cmd.codice_richiesta = kki_tipo_richiesta_sost_pl_figli then   
	
	//--- campo parametri: cartella di scambio M2000 - Pilota con il file della Pianificazione
						k_pos_ctr_ini = k_pos_ctr_fin + 1
						k_pos_ctr_fin = PosA(k_record, ",", k_pos_ctr_ini)
						if k_pos_ctr_fin > 0 then
							k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
							if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
								kst_txt_pilota_cmd.path_fl_pilota = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
							else
								kst_esito.esito = kkg_esito.ERR_FORMALE
								kst_esito.sqlcode = k_byte
								kst_esito.SQLErrText = "Manca Nome della Cartella del file di Pianificazione , nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
																+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
							end if
						else
							kst_esito.esito = kkg_esito.ERR_FORMALE
							kst_esito.sqlcode = k_byte
							kst_esito.SQLErrText = "Non trovato carattere di fine campo ',' x Nome Cartella file di Pianificazione, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
															+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini)) + ") "
						end if
						
						if kst_esito.esito = kkg_esito.ok then
	//--- campo parametri: Utente 
							k_pos_ctr_ini = k_pos_ctr_fin + 1
							if k_pos_ctr_fin > 0 then
								k_pos_ctr_len = k_pos_ctr_fin - k_pos_ctr_ini
							else
								if k_byte >= k_pos_ctr_ini then 
									k_pos_ctr_len = k_byte - k_pos_ctr_ini + 1
								else
									k_pos_ctr_len = 0
								end if
							end if
							if k_pos_ctr_len > 0 then
								if LenA(trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))) > 0 then
									kst_txt_pilota_cmd.utente = trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len))
								else
									kst_esito.sqlcode = k_byte
									kst_esito.SQLErrText = "Manca Utente , nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
																	+ "~n~r valore:"  + trim(MidA(k_record, k_pos_ctr_ini, k_pos_ctr_len)) + ") "
								end if
							else
								kst_esito.sqlcode = k_byte
								kst_esito.SQLErrText = "Non trovato il campo Utente, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
																+ ") "
							end if
						end if
	
					else
//--- Richiesta non prevista
						kst_esito.esito = kkg_esito.blok
						kst_esito.sqlcode = k_byte
						kst_esito.SQLErrText = "Errore Codice Richiesta non Gestita, nel file:~n~r"+kist_tab_pilota_cfg.path_pilota_out+kist_tab_pilota_cfg.file_richieste_figli &
														+ "~n~r valore:"  + string(kst_txt_pilota_cmd.codice_richiesta) + ") "
		
					end if
	
	
				end if
	
				if kst_esito.esito <> kkg_esito.ok then
					FileClose(k_FileNum)
					kuo_exception.set_esito (kst_esito)
					throw kuo_exception
				end if
	
	
	end choose
	
	FileClose(k_FileNum)
	
end if

SetPointer(oldpointer)
			

return kst_txt_pilota_cmd

end function

public function st_esito cancella_file_richieste (readonly st_tab_pilota_cmd kst_tab_pilota_cmd) throws uo_exception;//---
//---   Cancella il file delle Richieste al Pilota (probabilmente COMMAND.TXT) 
//---   Input: la struttura kist_tab_pilota_cmd deve essere gia' valorizzata
//---
st_txt_pilota_cmd kst_txt_pilota_cmd
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len 	
string k_record, k_path_file
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception


//--- le cartelle dei file di scambio tra M2000 e PILOTA esistono?
if not DirectoryExists ( trim(kst_tab_pilota_cmd.path) ) then
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Cartella di scambio file diretti al Pilota Non Trovata:~n~r " +  trim(kst_tab_pilota_cmd.path)
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
end if

//--- Esiste il file ?
//if  FileExists ( kist_tab_pilota_cfg.path_pilota_out+ kist_tab_pilota_cfg.file_richieste) then
if  FileExists ( trim(kst_tab_pilota_cmd.path)+ trim(kst_tab_pilota_cmd.pfile)) then

//--- cancello il file
	if not FileDelete (  trim(kst_tab_pilota_cmd.path)+ trim(kst_tab_pilota_cmd.pfile) ) then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Cancellazione del file 'Richieste al Pilota' Fallita:~n~r " + trim(kst_tab_pilota_cmd.path)+ trim(kst_tab_pilota_cmd.pfile)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
	
end if

SetPointer(oldpointer)
			

return kst_esito

end function

public function string get_path_temp () throws uo_exception;//---
//---   Torna il nome completo del path di Appoggio dei file da passare al Pilota
//---   Output: il path
//---   Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_return = " "

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
        pilota_cfg.path_temp 
    INTO 
        :kist_tab_pilota_cfg.path_temp 
    FROM pilota_cfg  
	 using sqlca;

	
	if sqlca.sqlcode = 0 then
		
//--- la cartelle esiste?
		if len(trim(kist_tab_pilota_cfg.path_temp ) ) > 0 then
			if not DirectoryExists ( kist_tab_pilota_cfg.path_temp ) then 
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Cartella Temporanea x file P.L. diretti al Pilota Non Trovata: " + trim(kist_tab_pilota_cfg.path_temp)
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Cartella Temporanea x  file P.L. diretti al Pilota Non Indicata in Archivio (inserire in Archivi->Pilota) " 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		k_return = trim(kist_tab_pilota_cfg.path_temp ) 
		
	else
		if sqlca.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + &
					"Codice : " + string(sqlca.sqldbcode, "#####") + "~n~r" +&
					sqlca.sqlreturndata
					
		else
			if sqlca.sqlcode > 0 then
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					kst_esito.esito = kkg_esito.db_wrn
				end if
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(sqlca.sqlerrtext) 
			end if	
		end if

		SetPointer(oldpointer)

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
SetPointer(oldpointer)


return k_return

end function

public function boolean check_presenza_file_richieste () throws uo_exception;//---
//---   Controlla se il file delle Richieste al Pilota (probabilmente COMMAND.TXT o COMMAND_GRP.TXT) è ancora presente in cartella
//---   
//---   Output: boolean TRUE=file ancora presente; FALSE=nessun file presente
//---
//---   lancia EXCEPION
//---

boolean k_return = false
st_tab_pilota_cfg  kst_tab_pilota_cfg 
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


//--- Leggo il nome file 
this.get_pilota_cfg()
kst_tab_pilota_cfg = kist_tab_pilota_cfg



//--- File esiste?
k_return = FileExists ((kst_tab_pilota_cfg.path_temp+kst_tab_pilota_cfg.file_richieste))


SetPointer(oldpointer)
			

return k_return

end function

public function boolean get_pilota_pilota_barcode (ref st_tab_pilota_queue ast_tab_pilota_queue) throws uo_exception;//---
//---   Legge dal Pilota nella tabella Queue il primo barcode in posizione h da trattare dopo gli intoccabili
//---
//--- Legge se BARCODE presente sulle tabelle PILOTA
//--- Inp: st_tab_pilota_queue.barcode
//--- Out: st_tab_pilota_queue.*
//--- Rit: TRUE=trovato; FALSE=non trovato
//---
//--- Se errore lancia EXCEPTION
//---
boolean k_return = false
string k_CicliFila1, k_CicliFila2, k_CicliFila1p, k_CicliFila2p
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
uo_exception kuo_exception

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kguo_sqlca_db_pilota.db_connetti()


SELECT 
           queue_table.Ordine ,
           queue_table.Posizione ,
           queue_table.CicliFila1  ,
           queue_table.CicliFila2 ,
           queue_table.CicliFila1P  ,
           queue_table.CicliFila2P 
    INTO 
           :ast_tab_pilota_queue.Ordine ,
           :ast_tab_pilota_queue.Posizione ,
           :k_CicliFila1,
           :k_CicliFila2,
           :k_CicliFila1p,
           :k_CicliFila2p
        FROM queue_table
		where 
			queue_table.Barcode = :ast_tab_pilota_queue.Barcode
		 using kguo_sqlca_db_pilota;

	
if kguo_sqlca_db_pilota.sqlcode = 0 then

	if isnumber(k_CicliFila1) then
		ast_tab_pilota_queue.CicliFila1 = integer(k_CicliFila1)
	else
		ast_tab_pilota_queue.CicliFila1 = 0
	end if
	if isnumber(k_CicliFila1p) then
		ast_tab_pilota_queue.CicliFila1p = integer(k_CicliFila1p)
	else
		ast_tab_pilota_queue.CicliFila1p = 0
	end if
	if isnumber(k_CicliFila2) then
		ast_tab_pilota_queue.CicliFila2 = integer(k_CicliFila2)
	else
		ast_tab_pilota_queue.CicliFila2 = 0
	end if
	if isnumber(k_CicliFila2p) then
		ast_tab_pilota_queue.CicliFila2p = integer(k_CicliFila2p)
	else
		ast_tab_pilota_queue.CicliFila2p = 0
	end if

	k_return = true  // OK TROVATO

else
	SetPointer(oldpointer)
	ast_tab_pilota_queue.Barcode = " "
	if kguo_sqlca_db_pilota.sqlcode < 0 then
		
		kst_esito.esito = kkg_esito.DB_KO
		kst_esito.sqlcode = kguo_sqlca_db_pilota.sqlcode
		kst_esito.SQLErrText = trim(kguo_sqlca_db_pilota.sqlerrtext) + "~n~r" + &
				"Codice : " + string(kguo_sqlca_db_pilota.sqldbcode, "#####") + "~n~r" +&
				kguo_sqlca_db_pilota.sqlreturndata
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
end if

	
SetPointer(oldpointer)


return k_return

end function

public function st_txt_pilota_cmd get_file_richieste_progressivi () throws uo_exception;//---
//---   Legge i file delle Richieste al Pilota (probabilmente COMMAND.TXT e COMMAND_GRP.TXT) e li converte 
//---   nella struttura st_txt_pilota_cmd, in ottemperanza al valore 'codice richiesta' presente nei file
//---
//---   Input: la struttura kist_tab_pilota_cfg deve essere gia' valorizzata
//---   Ritorna: struttura st_txt_pilota_cmd con ultimo progressivo richiesta PADRE e FIGLI e il piu' alto
//---
st_txt_pilota_cmd kst_txt_pilota_cmd, kst_txt_pilota_cmd_padri, kst_txt_pilota_cmd_figli
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
int k_FileNum, k_byte, k_pos_ctr_ini, k_pos_ctr_fin, k_pos_ctr_len 	
string k_record
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

	
//--- Inizializzo i campi
kst_txt_pilota_cmd.progressivo_richiesta = 0
kst_txt_pilota_cmd.progressivo_richiesta = 0
kst_txt_pilota_cmd.codice_richiesta = 0
kst_txt_pilota_cmd.path_fl_pilota = " "
kst_txt_pilota_cmd.prima_del_barcode = " "
kst_txt_pilota_cmd.utente = " "
kst_txt_pilota_cmd.data_inizio = datetime(date(0))
kst_txt_pilota_cmd.data_fine = datetime(date(0))

try
	
	kst_txt_pilota_cmd_padri = leggi_file_richieste_padri()
	
catch (uo_exception kuo1_exception)
	throw kuo1_exception
end try
	
try
	
	kst_txt_pilota_cmd_figli = leggi_file_richieste_figli()
	
catch (uo_exception kuo2_exception)
	throw kuo2_exception
end try

//--- torna il record con il progressivo richiesta più alto
if kst_txt_pilota_cmd_padri.progressivo_richiesta = 0 and  kst_txt_pilota_cmd_figli.progressivo_richiesta = 0 then
	kst_txt_pilota_cmd.progressivo_richiesta = 0
else
	
	kst_txt_pilota_cmd.progressivo_richiesta_padre = kst_txt_pilota_cmd_padri.progressivo_richiesta
	kst_txt_pilota_cmd.progressivo_richiesta_filgli = kst_txt_pilota_cmd_figli.progressivo_richiesta
	
	if kst_txt_pilota_cmd_padri.progressivo_richiesta >= kst_txt_pilota_cmd_figli.progressivo_richiesta then
		kst_txt_pilota_cmd = kst_txt_pilota_cmd_padri 
	else
		kst_txt_pilota_cmd = kst_txt_pilota_cmd_figli
	end if	
end if
			

return kst_txt_pilota_cmd

end function

public function string get_path_file_richieste () throws uo_exception;//---
//---   Torna il nome completo del path di scambio dove risiede il file delle Pianificazioni alle Lavorazioni
//---   Output: il path
//---   Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
string k_return = " "
//uo_exception kuo_exception

//=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
        pilota_cfg.path_pilota_out 
        ,pilota_cfg.file_richieste 
    INTO 
         :kist_tab_pilota_cfg.path_pilota_out
		,:kist_tab_pilota_cfg.file_richieste
    FROM pilota_cfg  
	 using sqlca;

	
	if sqlca.sqlcode = 0 then

//--- la cartelle esiste? 
		if len(trim(kist_tab_pilota_cfg.path_pilota_out ) ) > 0 then
			if not DirectoryExists ( kist_tab_pilota_cfg.path_pilota_out ) then 
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Cartella del file 'comandi' al Pilota non Trovata (P.L.)! " &
										+ "~n~rpath: " + trim(kist_tab_pilota_cfg.path_pilota_out) + " "
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Cartella del file 'comandi' al Pilota non Indicata in Archivio (inserire in Archivi->Pilota)! " 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- nome file indicato?
		if len(trim(kist_tab_pilota_cfg.file_richieste ) ) > 0 then
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nome File 'comandi' per il Pilota non Indicata in Archivio (inserire in Archivi->Pilota)! " 
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		
		k_return = trim(kist_tab_pilota_cfg.path_pilota_out ) + trim(kist_tab_pilota_cfg.file_richieste)
		
	else
		if sqlca.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura tabella configurazione parametri del server 'PILOTA'~n~r" + &
					"Errore: " + string(sqlca.sqldbcode, "#####") + "~n~r" +&
					sqlca.sqlreturndata
					
		else
			if sqlca.sqlcode > 0 then
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					kst_esito.esito = kkg_esito.db_wrn
				end if
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText += "Errore in lettura tabella configurazione parametri del server 'PILOTA'~n~r" + &
						"Errore: "+ string(sqlca.sqldbcode, "#####") + "~n~r" 
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if	
		end if

		SetPointer(oldpointer)

//--- LANCIA UN ECCEZIONE
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	
//SetPointer(oldpointer)


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

	if job_pianificazione_lavorazioni() then
		get_pilota_cfg()
		kst_esito.SQLErrText = "Operazione conclusa correttamente. " &
									+ "Piano di Lavorazione generato e inviato al Pilota nella cartella '" &
									+ kist_tab_pilota_cfg.path_file_pl_barcode + "' (ultimo file: "&
									+ kist_tab_pilota_cfg.ultimo_nome_file_pl_barcode + ")"
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun Piano di Lavorazione da inviare al Pilota trovato."
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

public function datetime get_data_ins_x_pl_barcode_codice (st_tab_pilota_cmd kst_tab_pilota_cmd) throws uo_exception;//---
//---   Torna il nome completo del path di Appoggio dei file da passare al Pilota
//---   Output: il path
//---   Lancia un exception se si verifica un grave errore
//---
datetime k_return 



  SELECT 
        data_ins 
    INTO 
        :kst_tab_pilota_cmd.data_ins 
    FROM pilota_cmd  
	 where pilota_cmd.pl_barcode_codice = :kst_tab_pilota_cmd.pl_barcode_codice
	 using kguo_sqlca_db_magazzino;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		
		if isnull(kist_tab_pilota_cmd.data_ins) then kist_tab_pilota_cmd.data_ins = datetime(date(0), time(0))
		
		k_return = kist_tab_pilota_cmd.data_ins
		
	else
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kguo_exception.kist_esito.SQLErrText = "Errore in lettura data inserimento in tabella 'comandi pilota' per il codice PL '" + string(kst_tab_pilota_cmd.pl_barcode_codice) &
											+ "'. Errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			throw kguo_exception
		end if

	end if
	

return k_return

end function

on kuf_pilota_cmd.create
call super::create
end on

on kuf_pilota_cmd.destroy
call super::destroy
end on

