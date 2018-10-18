$PBExportHeader$kuf_pl_barcode.sru
forward
global type kuf_pl_barcode from kuf_parent
end type
end forward

global type kuf_pl_barcode from kuf_parent
end type
global kuf_pl_barcode kuf_pl_barcode

type variables
//--- valori della colonna STATO
public constant string ki_stato_aperto = "A"
public constant string ki_stato_chiuso = "C"
public constant string ki_stato_inelab = "E"
public constant string ki_stato_inErrore = "X"
public constant string ki_stato_inviato = "I"
public constant string ki_stato_consegnato = "T"
public constant string ki_stato_respinto = "R"

//--- valori della colonna PRIORITA
public constant string k_priorita_urgente = "1"
public constant string k_priorita_prima_del_barcode = "2"
public constant string k_priorita_alta = "4"
public constant string k_priorita_normale = "6"
public constant string k_priorita_bassa = "8"

//--- valori della colonna GROUPAGE
public constant string k_groupage_si = "S"
public constant string k_groupage_no = "N"

end variables

forward prototypes
public function string tb_delete (ref st_tab_pl_barcode kst_tab_pl_barcode)
public function st_esito tb_update (ref st_tab_pl_barcode kst_tab_pl_barcode)
public function st_esito tb_update_campo (ref st_tab_pl_barcode kst_tab_pl_barcode, string k_campo)
public function st_esito anteprima (datawindow kdw_anteprima, ref st_tab_pl_barcode kst_tab_pl_barcode)
public function st_esito consenti_chiusura ()
public function boolean set_pl_barcode_stato (string k_tipo_stato, st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function st_tab_pl_barcode get_pl_barcode_da_inviare () throws uo_exception
public function boolean if_pl_barcode_priorita_urgente (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean select_pl_barcode (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public subroutine set_pl_barcode_nuovo_default (ref st_tab_pl_barcode kst_tab_pl_barcode)
public function ds_pl_barcode get_ds_pl_barcode (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function long conta_barcode_no_grp (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function st_esito if_utente_autorizzato ()
private subroutine chiudi_lav_barcode_figlio (ref st_tab_barcode kst_tab_barcode) throws uo_exception
private subroutine apri_lav_barcode_figlio (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function long conta_barcode_no_figli (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean if_pl_barcode_aperto (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function long conta_barcode_figli (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function ds_pl_barcode get_ds_barcode_figli_da_padri (readonly ds_pl_barcode kds_pl_barcode_input) throws uo_exception
public function integer importa_inizio_lav_pilota (string k_simulazione) throws uo_exception
public function integer importa_trattati_pilota (string k_simulazione) throws uo_exception
public subroutine put_barcode_figlio_in_lav (st_tab_barcode kst_tab_barcode_figli) throws uo_exception
public subroutine put_barcode_padre_in_lav (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean crea_file_pilota_figli (ds_pl_barcode kds_pl_barcode) throws uo_exception
public function boolean crea_file_pilota_figli_dosimetri (ds_pl_barcode kds_pl_barcode, string k_path_file, integer k_filenum) throws uo_exception
public function boolean crea_file_pilota_figli_da_trattare (ds_pl_barcode kds_pl_barcode, string k_path, integer k_filenum) throws uo_exception
public function boolean if_esiste (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean riapre_pl_barcode (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean if_pl_trasferito_al_pilota (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public subroutine get_path_file_pilota (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean cancella_file_pilota (st_tab_pl_barcode ast_tab_pl_barcode) throws uo_exception
public function boolean set_pilota_cmd_num_rich (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function ds_pl_barcode get_ds_barcode_padri (readonly ds_pl_barcode kds_pl_barcode_input) throws uo_exception
public function boolean if_pianificazione_figli_ok (ds_pl_barcode_dett kds_pl_barcode_dett_padri, ds_pl_barcode_dett kds_pl_barcode_dett_figli, string a_operazione) throws uo_exception
private subroutine u_set_tab_barcode (readonly st_tab_pilota_pallet kst_tab_pilota_pallet, ref st_tab_barcode kst_tab_barcode)
public function boolean if_pianificazione_ok (ds_pl_barcode_dett kds_pl_barcode_dett, string a_operazione) throws uo_exception
public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_lav (readonly st_tab_meca kst_tab_meca) throws uo_exception
public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_pianif (readonly st_tab_meca kst_tab_meca) throws uo_exception
public function long get_pilota_cmd_num_rich (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception
public function boolean crea_file_pilota_padri (ds_pl_barcode kds_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception
public function boolean crea_file_pilota_wo (st_tab_pl_barcode kst_tab_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception
public function boolean crea_file_pilota_dosimpos (ds_pl_barcode kds_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception
public function long get_codice_max () throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function string tb_delete (ref st_tab_pl_barcode kst_tab_pl_barcode);//
//====================================================================
//=== Cancella il rek dalla tabella Piano Lavorazione BARCODE
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
integer k_sn=0
int k_rek_ok=0
string k_barcode
long k_codice
date k_data_chiuso

declare kc_barcode cursor for 
	 select barcode
			from barcode
			where barcode.pl_barcode = :k_codice
	 using sqlca;



	k_codice = kst_tab_pl_barcode.codice

	select data_chiuso
	      into :k_data_chiuso
			from pl_barcode
			where pl_barcode.codice = :k_codice
	 using sqlca;

	if k_data_chiuso > date(0) then
		k_return = "2" + "Piano di Lavorazione gia' Chiuso il " + &
				string(k_data_chiuso, "dd/mm/yyyy") + & 
			   + "~n~r" 	
	else

		open kc_barcode;
		if sqlca.sqlCode = 0 then
		
			fetch kc_barcode INTO :k_barcode ;
		
			if sqlca.sqlCode = 0 then
				k_return = "2" + "Piano di Lavorazione gia' associato, come nel barcode :  ~n~r" + &
					trim(k_barcode) + & 
					+ "~n~r" 	
			end if
			close kc_barcode;
		end if
	
		if LeftA(k_return, 1) = "0" then
			delete from pl_barcode
				where codice = :k_codice
				using sqlca;
		
			if sqlca.sqlcode <> 0 then
				k_return = "1" + SQLCA.SQLErrText
			end if
		end if
	end if


return k_return
end function

public function st_esito tb_update (ref st_tab_pl_barcode kst_tab_pl_barcode);//
//====================================================================
//=== Insert/Update rek Piano Lavorazione Barcode
//=== 
//=== esegui_commit = "N" non esegue la commit
//===
//=== Ritorna st_esito : 0=OK; 100=not found; 2=errore grave; 
//===           		: 3=Altro errore 
//====================================================================

st_esito kst_esito, kst1_esito
st_tab_base kst_tab_base
kuf_base kuf1_base



	kst_esito.esito = "9"   //x default nessuna operazione
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()

	kst_esito.st_tab_g_0 = kst_tab_pl_barcode.st_tab_g_0 
	if kst_esito.st_tab_g_0.esegui_commit <> "S" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
		kst_esito.st_tab_g_0.esegui_commit = "N"
	end if

	kst_tab_pl_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_pl_barcode.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_pl_barcode.stato) then kst_tab_pl_barcode.stato = ki_stato_aperto
	if isnull(kst_tab_pl_barcode.priorita) then kst_tab_pl_barcode.priorita = k_priorita_normale
	if isnull(kst_tab_pl_barcode.prima_del_barcode) then kst_tab_pl_barcode.prima_del_barcode = " "
			
	if isnull(kst_tab_pl_barcode.codice) 	or kst_tab_pl_barcode.codice = 0 then
	
		kst_esito.esito = "0"
		
		kst_tab_pl_barcode.codice = 0 //SERIAL
//				 codice,
		
		insert into pl_barcode (
				 data,
				 note_1,
				 note_2,
				 data_sosp,
				 data_chiuso,
				 stato,
				 priorita,
				 prima_del_barcode,
				 x_datins,
				 x_utente)
		values
				 (
				  :kst_tab_pl_barcode.data,
				  :kst_tab_pl_barcode.note_1,
				  :kst_tab_pl_barcode.note_2,
				  :kst_tab_pl_barcode.data_sosp,
				  :kst_tab_pl_barcode.data_chiuso,
				  :kst_tab_pl_barcode.stato,
				  :kst_tab_pl_barcode.priorita,
				  :kst_tab_pl_barcode.prima_del_barcode,
				  :kst_tab_pl_barcode.x_datins,
				  :kst_tab_pl_barcode.x_utente)
		using sqlca;
			
		if sqlca.sqlcode = 0 and sqlca.sqlnrows > 0 then

//--- recupera il valore serial
			if sqlca.sqlcode = 0 then
				try
					kst_tab_pl_barcode.codice = get_codice_max()
				catch (uo_exception kuo_exception)
					kst_tab_pl_barcode.codice = 0
					kst_esito.esito = kkg_esito.db_wrn
					kst_esito.sqlerrtext = kuo_exception.get_errtext( )
				end try
				//kst_tab_pl_barcode.codice = long(sqlca.SQLReturnData) 
			end if
				
//--- Imposta il nuovo num. pl_barcode			
			kuf1_base = create kuf_base                                  
			kst_tab_base.st_tab_g_0.esegui_commit = kst_tab_pl_barcode.st_tab_g_0.esegui_commit 
			kst_tab_base.key = "ult_num_pl_barcode"
			kst_tab_base.key1 = string(kst_tab_pl_barcode.codice)
			kst1_esito  = kuf1_base.metti_dato_base(kst_tab_base)
//				if kst1_esito.esito  = "1" then
//					kst_esito.esito = "1"
//					kst_esito.sqlcode = kst1_esito.sqlcode
//					kst_esito.SQLErrText = kst1_esito.SQLErrText
//				end if
		   destroy kuf1_base
			
		end if
			

	else

		kst_esito.esito = "0"
	
		update pl_barcode set 	 
					 data = :kst_tab_pl_barcode.data,
					 note_1 = :kst_tab_pl_barcode.note_1,
					 note_2 = :kst_tab_pl_barcode.note_2, 
					 data_sosp = :kst_tab_pl_barcode.data_sosp,
					 data_chiuso = :kst_tab_pl_barcode.data_chiuso,
					 stato = :kst_tab_pl_barcode.stato,
					 priorita = :kst_tab_pl_barcode.priorita,
					 prima_del_barcode = :kst_tab_pl_barcode.prima_del_barcode,
					 x_datins = :kst_tab_pl_barcode.x_datins,
					 x_utente = :kst_tab_pl_barcode.x_utente
			where codice = :kst_tab_pl_barcode.codice
			using sqlca;

	end if

	if kst_esito.esito = "0" then
		if sqlca.sqlcode = 0 then
			if kst_esito.st_tab_g_0.esegui_commit = "S" then
				commit using sqlca;
			end if
		else
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.sqlerrtext = "Tab.Piani di Lavoro: " + trim(SQLCA.SQLErrText)
			else
				if sqlca.sqlcode <> 0 then
					kst_esito.esito = "2"
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Tab.Piani di Lavoro: " + trim(SQLCA.SQLErrText)
				end if
			end if
		end if
	end if



return kst_esito

end function

public function st_esito tb_update_campo (ref st_tab_pl_barcode kst_tab_pl_barcode, string k_campo);//
//====================================================================
//=== Update un campo del rek Piano Lavorazione Barcode
//=== 
//=== Ritorna st_esito : come da standard
//===   
//====================================================================

st_esito kst_esito
kuf_base kuf1_base


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if Len(trim(k_campo)) > 0 then

		kst_tab_pl_barcode.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_pl_barcode.x_utente = kGuf_data_base.prendi_x_utente()

		choose case k_campo
				
			case "data_chiuso"
				
//				if not isnull(kst_tab_pl_barcode.data_chiuso) &
//					and  kst_tab_pl_barcode.data_chiuso <> date(0) then
					kst_tab_pl_barcode.stato = ki_stato_chiuso
	
					update pl_barcode set 	 
						 stato = :kst_tab_pl_barcode.stato,
						 data_chiuso = :kst_tab_pl_barcode.data_chiuso,
						 upd_data_chiuso = :kst_tab_pl_barcode.x_datins,
						 upd_utente_chiuso = :kst_tab_pl_barcode.x_utente,
						 x_datins = :kst_tab_pl_barcode.x_datins,
						 x_utente = :kst_tab_pl_barcode.x_utente
					where codice = :kst_tab_pl_barcode.codice
					using kguo_sqlca_db_magazzino;
				
//				else
//
//					k_return = "2" + "Data di chiusura non valida" 
//				end if

			case "path_file_pilota"
				
				if isnull(kst_tab_pl_barcode.path_file_pilota) &
					or LenA(trim(kst_tab_pl_barcode.path_file_pilota)) = 0 then
					kst_tab_pl_barcode.path_file_pilota = " "
				end if

				update pl_barcode set 	 
					 path_file_pilota = :kst_tab_pl_barcode.path_file_pilota,
					 upd_data_fpilota = :kst_tab_pl_barcode.x_datins,
					 upd_utente_fpilota = :kst_tab_pl_barcode.x_utente,
					 x_datins = :kst_tab_pl_barcode.x_datins,
					 x_utente = :kst_tab_pl_barcode.x_utente
				where codice = :kst_tab_pl_barcode.codice
				using kguo_sqlca_db_magazzino;

			case "prima_del_barcode"
				
				if isnull(kst_tab_pl_barcode.prima_del_barcode) &
					or LenA(trim(kst_tab_pl_barcode.prima_del_barcode)) = 0 then
					kst_tab_pl_barcode.prima_del_barcode = " "
				end if

				update pl_barcode set 	 
					 prima_del_barcode = :kst_tab_pl_barcode.prima_del_barcode,
					 x_datins = :kst_tab_pl_barcode.x_datins,
					 x_utente = :kst_tab_pl_barcode.x_utente
				where codice = :kst_tab_pl_barcode.codice
				using kguo_sqlca_db_magazzino;

			case else 
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore Interno, sbagliato parametro di programma:" + string(k_campo) 
				
		end choose

//--- se fatto UPDATE
		if kst_esito.esito = kkg_esito.ok then
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N" then
				else
					kguo_sqlca_db_magazzino.db_commit()
				end if
			else
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Errore aggiornamento Tab.Piani di Lavoro: " + trim(SQLCA.SQLErrText)
					if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N" then
					else
						kguo_sqlca_db_magazzino.db_rollback()
					end if
				end if
			end if
		end if

	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Errore Interno, nessun parametro indicato dal programma " 
	end if

return kst_esito
end function

public function st_esito anteprima (datawindow kdw_anteprima, ref st_tab_pl_barcode kst_tab_pl_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_pl_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "100"

else

	if kst_tab_pl_barcode.codice > 0 then

		kdw_anteprima.dataobject = "d_pl_barcode_dett_1"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_pl_barcode.codice, "%")

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Riferimento da visualizzare: ~n~r" + "nessun codice ID indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito consenti_chiusura ();//
//=== 
//====================================================================
//=== Autorizza o meno la funzione di Chiusura del Piano di Lavorazione
//===
//=== Par. Inut:    
//===               
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base


kst_esito.esito = kkg_esito.OK
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.chiudi_pl
kst_open_w.id_programma = kkg_id_programma_pl_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Chiusura P.L. non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

end if


return kst_esito

end function

public function boolean set_pl_barcode_stato (string k_tipo_stato, st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Imposta lo stato del Piano di Lavorazione a quello passato nei parametri
//=== 
//=== Input: 
//===	tipo di stato: "aperto", "chiuso", "inviato", "consegnato", "respinto"
//=== 	struttura st_tab_pl_barcode con il Codice del PL_BARCODE impostato
//=== 
//=== 
//=== 
//=== Ritorna boolena : TRUE=stato aggiornato;  FALSE=stato non aggiornato  
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

boolean k_return = false
long k_ctr
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer

//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
	choose case lower(k_tipo_stato)
				
		case "aperto"
			kst_tab_pl_barcode.stato = 	ki_stato_aperto
		case "chiuso"
			kst_tab_pl_barcode.stato = 	ki_stato_chiuso
		case "in_elab"
			kst_tab_pl_barcode.stato = 	ki_stato_inelab
		case "inviato"
			kst_tab_pl_barcode.stato = 	ki_stato_inviato
		case "consegnato"
			kst_tab_pl_barcode.stato = 	ki_stato_consegnato
		case "respinto"
			kst_tab_pl_barcode.stato = 	ki_stato_respinto
		case "inerrore"
			kst_tab_pl_barcode.stato = 	ki_stato_inErrore
		case else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore interno Stato '" + k_tipo_stato + "' non Riconosciuto! (kuf_pl_barcode.set_pl_barcode_stato)" 									 
			kst_esito.esito = kkg_esito.ko
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception

	end choose


	kst_tab_pl_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_pl_barcode.x_utente = kGuf_data_base.prendi_x_utente()

	
	choose case lower(k_tipo_stato)
		
//--- in questo caso aggiorna anche il path pilota		
		case "inviato"
			update pl_barcode set 	 
				 stato = :kst_tab_pl_barcode.stato
				 ,path_file_pilota =  :kst_tab_pl_barcode.path_file_pilota
				 ,x_datins = :kst_tab_pl_barcode.x_datins
				 ,x_utente = :kst_tab_pl_barcode.x_utente
			where codice = :kst_tab_pl_barcode.codice
			using kguo_sqlca_db_magazzino;


		case else
			update pl_barcode set 	 
				 stato = :kst_tab_pl_barcode.stato
				 ,x_datins = :kst_tab_pl_barcode.x_datins
				 ,x_utente = :kst_tab_pl_barcode.x_utente
			where codice = :kst_tab_pl_barcode.codice
			using kguo_sqlca_db_magazzino;

	end choose


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N" then
		else
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Aggiornamento Stato Tab.Piani di Lavorazione  (PL_BARCODE):  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "N" then
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if


return k_return

end function

public function st_tab_pl_barcode get_pl_barcode_da_inviare () throws uo_exception;//
//====================================================================
//=== Verifica e Torna il  Piano di Lavorazione  da inviare al Pilota
//=== 
//=== Ritorna: st_tab_pl_barcode.codice se > zero=pl trovato se a 0=nessun pl da inviare 
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

long k_ctr
string k_dataoggi_x
boolean k_open = false
st_tab_pl_barcode kst_tab_pl_barcode
st_esito kst_esito
kuf_base kuf1_base
uo_exception kuo_exception
pointer oldpointer


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kst_tab_pl_barcode.codice = 0

	kuf1_base = create kuf_base
	k_dataoggi_x = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
	destroy kuf1_base 
	if isdate(k_dataoggi_x) then
		kst_tab_pl_barcode.data = relativedate (date(k_dataoggi_x), -90)
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in Lettura Data-oggi:  " + k_dataoggi_x
		kst_esito.esito = kkg_esito.err_formale
		kuo_exception = create uo_exception
		kuo_exception.set_esito (kst_esito)
		throw kuo_exception
	end if
	
	kst_tab_pl_barcode.stato = ki_stato_chiuso    // solo quei PL con lo STATO=CHIUSO
	
//--- piglia il primo PL ancora da lavorare 	
	declare c1_if_pl_barcode_da_inviare cursor for 
	    select priorita, codice, data, prima_del_barcode 
			from pl_barcode
			where 
		   		data >= :kst_tab_pl_barcode.data
		   		and stato = :kst_tab_pl_barcode.stato
			order by priorita asc, data asc, codice asc
		using sqlca;


try
	
	open c1_if_pl_barcode_da_inviare;
	
	if sqlca.sqlcode = 0 then
		k_open = true
		fetch c1_if_pl_barcode_da_inviare 
				into
					:kst_tab_pl_barcode.priorita
					,:kst_tab_pl_barcode.codice
					,:kst_tab_pl_barcode.data
					,:kst_tab_pl_barcode.prima_del_barcode;
	end if
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Tab.Piani di Lavorazione  (PL_BARCODE):  ~n~r" &
									 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kuo_exception = create uo_exception
			kuo_exception.set_esito (kst_esito)
			throw kuo_exception
		end if
		if sqlca.sqlcode = 100 then
			kst_tab_pl_barcode.codice = 0
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.SQLErrText = "Nessun Piano di Lavorazione da Inviare. ~n~r" &
//									+"Ho cercato dalla data del "+ string(kst_tab_pl_barcode.data ) +" quelli con Stato=CHIUSO~n~r" &
//									 + trim(SQLCA.SQLErrText)
//			kst_esito.esito = kkg_esito.not_fnd
//			kst_esito.scrivi_log = FALSE
//			kuo_exception = create uo_exception
//			kuo_exception.set_esito (kst_esito)
//			throw kuo_exception
		end if
	end if

catch (uo_exception k1uo_exception)
	throw k1uo_exception
	
finally
	if k_open then
		close c1_if_pl_barcode_da_inviare;
	end if

end try

return kst_tab_pl_barcode

end function

public function boolean if_pl_barcode_priorita_urgente (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se il Piano ha una priorita di URGENTE
//=== 
//=== Input: 
//=== 	struttura st_tab_pl_barcode con il Codice del PL_BARCODE impostato
//=== 
//=== 
//=== 
//=== Ritorna boolena : TRUE=urgente;  FALSE=non urgente  
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

boolean k_return = false
long k_ctr
//st_esito kst_esito
//uo_exception kuo_exception
//pointer oldpointer

//=== Puntatore Cursore da attesa.....
//	oldpointer = SetPointer(HourGlass!)


//	kst_esito.esito =kkg_esito.ok
//	kst_esito.sqlcode = 0
//	kst_esito.SQLErrText = ""
//
//	kuo_exception = create uo_exception
	
	choose case lower(kst_tab_pl_barcode.priorita)
				
		case k_priorita_urgente
			k_return = true
		case else
			k_return = false
	end choose

return k_return

end function

public function boolean select_pl_barcode (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Select rek Piano Lavorazione Barcode
//=== 
//=== Ritorna TRUE=record Trovato; FALSE=non trovato
//===           	
//===
//=== Lancia un ECCEZIONE se errore
//====================================================================

boolean k_return = true
pointer oldpointer  // Declares a pointer variable
st_esito kst_esito
uo_exception kuo_exception


//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception

select 
	       data,
	       note_1,
			 note_2,
			 data_sosp,
			 data_chiuso,
			 stato,
			 priorita,
			 x_datins,
			 x_utente
		into
	       :kst_tab_pl_barcode.data,
	       :kst_tab_pl_barcode.note_1,
			 :kst_tab_pl_barcode.note_2,
			 :kst_tab_pl_barcode.data_sosp,
			 :kst_tab_pl_barcode.data_chiuso,
			 :kst_tab_pl_barcode.stato,
			 :kst_tab_pl_barcode.priorita,
			 :kst_tab_pl_barcode.x_datins,
			 :kst_tab_pl_barcode.x_utente
		from pl_barcode
		where codice = :kst_tab_pl_barcode.codice
		using sqlca;

if sqlca.sqlcode <> 0 then
	if sqlca.sqlcode = 100 then
		k_return = false
	else
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura tabella 'Piani di Lavoro'.  ~n~r" +  trim(SQLCA.SQLErrText)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if

SetPointer(oldpointer)

return k_return
end function

public subroutine set_pl_barcode_nuovo_default (ref st_tab_pl_barcode kst_tab_pl_barcode);//
//====================================================================
//=== 
//=== Riempe i dati di default    
//=== 
//=== Input: 
//=== 	reference struttura st_tab_pl_barcode VUOTA 
//=== Output: 
//=== 	reference struttura st_tab_pl_barcode PIENA 
//=== 
//=== 
//====================================================================
kuf_base kuf1_base

kuf1_base = create kuf_base

kst_tab_pl_barcode.codice = 0
kst_tab_pl_barcode.data = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
kst_tab_pl_barcode.note_1 = " "
kst_tab_pl_barcode.note_2 = " "
kst_tab_pl_barcode.data_chiuso = date(0)
kst_tab_pl_barcode.data_sosp = date(0)
kst_tab_pl_barcode.path_file_pilota = " "
kst_tab_pl_barcode.stato = ki_stato_aperto
kst_tab_pl_barcode.priorita = k_priorita_normale

destroy kuf1_base 

end subroutine

public function ds_pl_barcode get_ds_pl_barcode (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//=== Torna DS PL_BARCODE valorizzato
//---  Input: st_tab_pl_barcode con il codice del PL_BARCODE da generare
//--- Output: Datastore ds_pl_barcode
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
ds_pl_barcode kds_pl_barcode
long k_riga
constant string k_cost_alto = "2HMM", k_cost_basso = "2BMM", k_cost_fine = "NN"
string k_giri, k_giri_p, k_giri_n, k_alto_basso, k_sep=","
int k_filenum, k_byte
string k_rc, k_path, k_file,  k_record = " "
boolean k_return=false
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_barcode kuf1_barcode
kuf_pilota_cmd kuf1_pilota_cmd
kuf_utility kuf1_utility
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable


oldpointer = SetPointer(HourGlass!)

kuo_exception = create uo_exception

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname()

kds_pl_barcode = create ds_pl_barcode	
kds_pl_barcode.settransobject(sqlca)
	
k_riga = kds_pl_barcode.retrieve(kst_tab_pl_barcode.codice)
	
if k_riga < 0 then	
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = k_FileNum
	kst_esito.SQLErrText = "Lettura fallita in tabella 'Pian.Lav. pl_barcode'. ~n~rCodice: "+string(k_riga)
	kst_esito.nome_oggetto = this.classname()
	kuo_exception.set_esito (kst_esito)
	throw kuo_exception
end if


//=== riprisino Puntatore
SetPointer(oldpointer)

return kds_pl_barcode

end function

public function long conta_barcode_no_grp (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Conta i Barcode contenuti nel PL indicato
//---   input: st_pl_barcode.codice = codice del pl
//---   output: numero dei barcode 
//---
long k_return = 0
string k_no_grp
st_esito kst_esito
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


k_no_grp = k_groupage_no

select count(*)
	into :k_return
	from barcode
	where barcode.pl_barcode = :kst_tab_pl_barcode.codice
	     and barcode.groupage = :k_no_grp
	using sqlca;


if sqlca.sqlcode <> 0 then
	if sqlca.sqlcode = 100 then
		k_return = 0
	else
		kuo_exception = create uo_exception
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Conta dei Barcode (no in grp) contenuti nel P.L.. " + string(kst_tab_pl_barcode.codice) + "  ~n~r" &
		                                  +  trim(SQLCA.SQLErrText)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if


return k_return
end function

public function st_esito if_utente_autorizzato ();//=== 
//====================================================================
//=== Autorizza o meno la funzione di Inserimento del Piano di Lavorazione
//===
//=== Par. Inut:    
//===               
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base


kst_esito.esito = kkg_esito.OK
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = kkg_id_programma_pl_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Inserimento P.L. non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

end if


return kst_esito


end function

private subroutine chiudi_lav_barcode_figlio (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//=== Chiude LAVORAZIONE di un Barcode 
//--- 
//--- Input: st_tab_barcode   interamente valorazzata gia' con gli errori verificati, qui aggiorna solo le tabelle
//--- Output: 
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//date k_data_ultima, k_data_da=date(0)
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
kuf_armo kuf1_armo
kuf_sv_skedula kuf1_sv_skedula

st_esito kst_esito
st_tab_base kst_tab_base
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_meca kst_tab_meca


try
	SetPointer(kkg.pointer_attesa)
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_artr = create kuf_artr
	kuf1_barcode = create kuf_barcode
	kuf1_armo = create kuf_armo

	
//--- Chiude il Trattamento del Barcode 
	kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
	kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini_fin")

	if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.ko then //--- errore grave
		kguo_sqlca_db_magazzino.db_rollback( ) //rollback using sqlca;
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
//--- se Anomalia....
	if kst_tab_barcode.err_lav_fin = kuf1_barcode.ki_err_lav_fin_ko then
		kst_tab_meca.id = kst_tab_barcode.id_meca 
		kst_tab_meca.err_lav_fin = kst_tab_barcode.err_lav_fin 
				
//--- se elaborazione NO di simulazione
		kst_tab_meca.st_tab_g_0.esegui_commit = "N" 
		kst_esito = kuf1_armo.setta_errore_lav(kst_tab_meca)
		
		if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.ko then //--- errore grave
			kguo_sqlca_db_magazzino.db_rollback( ) //rollback using sqlca;
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	end if
					
//--- Chiude lavorazione del Barcode su ARTR  
	kst_esito.esito = kkg_esito.ok 
	kst_tab_artr = kst_tab_artr_vuota
	kst_tab_artr.id_armo = kst_tab_barcode.id_armo 
	kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
	
//--- se elaborazione NO di simulazione...
	kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
	kst_esito = kuf1_artr.chiudi_lavorazione(kst_tab_artr)
	
	if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.ko then //--- errore grave
		kguo_sqlca_db_magazzino.db_rollback( ) //rollback using sqlca;
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- 
	kst_tab_artr.num_certif = 0

//--- Crea ATTESTATO su ARTR - ritorna il num certificato   - COMMIT DEL LAVORO
	kst_tab_artr.st_tab_g_0.esegui_commit = "S" 
	kst_esito = kuf1_artr.crea_attestato_dettaglio(kst_tab_artr)

	if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.ko then //--- errore grave
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
//--- provo a chiudere lavorazione sul Lotto MECA
//--- se elaborazione NO di simulazione...
	kst_esito.esito = kkg_esito.ok 
	
	kst_tab_meca.id = kst_tab_barcode.id_meca
	kst_tab_meca.data_lav_fin = kst_tab_barcode.data_lav_fin
	kst_tab_meca.st_tab_g_0.esegui_commit = "N"
	kst_esito = kuf1_armo.chiudi_lavorazione(kst_tab_meca)

	if kst_esito.esito = kkg_esito.db_ko or kst_esito.esito = kkg_esito.ko then //--- errore grave
		kguo_sqlca_db_magazzino.db_rollback( ) //rollback using sqlca;
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
//-------------------------------------------------------------------------------------------------------------

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally			
	if isvalid(kuf1_artr) then destroy kuf1_artr
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_armo) then destroy kuf1_armo
	SetPointer(kkg.pointer_default)
	
end try


end subroutine

private subroutine apri_lav_barcode_figlio (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//=== Chiude LAVORAZIONE di un Barcode 
//--- 
//--- Input: st_tab_barcode   interamente valorazzata gia' con gli errori verificati, qui aggiorna solo le tabelle
//--- Output: 
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//date k_data_ultima, k_data_da=date(0)
pointer kpointer_old
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
kuf_armo kuf1_armo
kuf_sv_skedula kuf1_sv_skedula

st_esito kst_esito
st_tab_base kst_tab_base
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_meca kst_tab_meca
uo_exception kuo_exception



//=== Puntatore Cursore da attesa.....
kpointer_old = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception
	


	kuf1_barcode = create kuf_barcode
	kuf1_armo = create kuf_armo


		
//--- Aggiorna gli archivi con i dati di Lavorazione ------------------------------------------------------
//--- se elaborazione NO di simulazione...
		kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
		kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini")

//--- se verificato errore					
		if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
			kGuf_data_base.db_rollback_1( )
			kuo_exception.set_esito (kst_esito)
			destroy kuf1_barcode
			destroy kuf1_armo 
			throw kuo_exception
		end if
	
//-------------------------------------------------------------------------------------------------------------
		
			
	destroy kuf1_barcode
	destroy kuf1_armo
	



end subroutine

public function long conta_barcode_no_figli (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Conta i Barcode No Figli (PADRI anche i potenziali) contenuti nel PL indicato
//---   input: st_pl_barcode.codice = codice del pl
//---   output: numero dei barcode 
//---
long k_return = 0
string k_no_grp
st_esito kst_esito
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



select count(*)
	into :k_return
	from barcode
	where barcode.pl_barcode = :kst_tab_pl_barcode.codice
	     and (barcode.barcode_lav is null or barcode.barcode_lav = '')
	using sqlca;


if sqlca.sqlcode <> 0 then
	if sqlca.sqlcode = 100 then
		k_return = 0
	else
		kuo_exception = create uo_exception
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Conta dei Barcode (no in grp) contenuti nel P.L.. " + string(kst_tab_pl_barcode.codice) + "  ~n~r" &
		                                  +  trim(SQLCA.SQLErrText)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if


return k_return
end function

public function boolean if_pl_barcode_aperto (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se il Piano è ancora aperto
//=== 
//=== Input: 
//=== 	struttura st_tab_pl_barcode con il Codice del PL_BARCODE impostato
//=== 
//=== 
//=== 
//=== Ritorna boolena : TRUE=aperto;  FALSE=CHIUSO  
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

boolean k_return = false
long k_ctr
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_pl_barcode.codice > 0 then

		select stato
				into :kst_tab_pl_barcode.stato
				from pl_barcode 
				where pl_barcode.codice = :kst_tab_pl_barcode.codice
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Piano Lav. Barcode n. " + string(kst_tab_pl_barcode.codice) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  
			if sqlca.sqlcode = 100 then //--- se non trovato lo considero cmq chiuso!
			else
	
				if kst_tab_pl_barcode.stato = ki_stato_aperto or isnull(kst_tab_pl_barcode.stato) then
					k_return = true
				end if
			end if
		end if
	else
		kst_esito.sqlerrtext = "Codice P.L. non indicato, impossibile valutare se Aperto! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function long conta_barcode_figli (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Conta i Barcode Figli contenuti nel PL indicato
//---   input: st_pl_barcode.codice = codice del pl
//---   output: numero dei barcode 
//---
long k_return = 0
string k_no_grp
st_esito kst_esito
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



select count(*)
	into :k_return
	from barcode
	where barcode.pl_barcode = :kst_tab_pl_barcode.codice
	     and (barcode.barcode_lav is not null and barcode.barcode_lav <> '')
	using sqlca;


if sqlca.sqlcode <> 0 then
	if sqlca.sqlcode = 100 then
		k_return = 0
	else
		kuo_exception = create uo_exception
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Conta dei Barcode (no in grp) contenuti nel P.L.. " + string(kst_tab_pl_barcode.codice) + "  ~n~r" &
		                                  +  trim(SQLCA.SQLErrText)
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if


return k_return
end function

public function ds_pl_barcode get_ds_barcode_figli_da_padri (readonly ds_pl_barcode kds_pl_barcode_input) throws uo_exception;//
//=== Torna DS_PL_BARCODE valorizzato con i figli
//---  Input: DS_PL_BARCODE con l'elenco barcode  
//--- Output: Datastore ds_pl_barcode con i figli
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
ds_pl_barcode kds_pl_barcode
long k_riga, k_riga_barcode, k_riga_insert
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figlio
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
uo_exception kuo_exception
datastore kds_barcode
pointer oldpointer  // Declares a pointer variable


oldpointer = SetPointer(HourGlass!)

kuo_exception = create uo_exception

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname()

kds_pl_barcode = create ds_pl_barcode	
kds_pl_barcode.settransobject(sqlca)
	
k_riga = kds_pl_barcode_input.rowcount()
	
if k_riga < 0 then	
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = k_riga
	kst_esito.SQLErrText = "Lettura fallita in tabella 'Pian.Lav. pl_barcode'. ~n~rCodice: "+string(k_riga)
	kuo_exception.set_esito (kst_esito)
	throw kuo_exception
end if

kuf1_barcode = create kuf_barcode
kuf1_armo = create kuf_armo
kuf1_clienti = create kuf_clienti

k_riga_insert = 0

for k_riga = 1 to kds_pl_barcode_input.rowcount() 

	kst_tab_barcode.barcode = kds_pl_barcode_input.object.barcode[k_riga]
	kds_barcode = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
	
	for k_riga_barcode = 1 to kds_barcode.rowcount( )
		
		kst_tab_barcode_figlio.barcode = kds_barcode.object.barcode[k_riga_barcode]
		kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode_figlio)
		if kst_esito.esito <> kkg_esito.ok then
			kuo_exception.set_esito (kst_esito)
			throw kuo_exception
		end if

		kst_tab_meca.id = kst_tab_barcode_figlio.id_meca
		kst_esito = kuf1_armo.leggi_testa( "P", kst_tab_meca) 
		if kst_esito.esito <> kkg_esito.ok then
			kst_tab_meca.area_mag = "????"
			kst_tab_meca.clie_2=0
		else
			kst_tab_clienti.codice = kst_tab_meca.clie_2
			kst_esito = kuf1_clienti.leggi_rag_soc(kst_tab_clienti)
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.rag_soc_10 = "??"+trim(kst_esito.sqlerrtext)+"??"
			end if
		end if		
		
		k_riga_insert++
		kds_pl_barcode.insertrow( k_riga_insert )
		
		kds_pl_barcode.object.pl_barcode_progr[k_riga_insert] = k_riga_insert
		kds_pl_barcode.object.pl_barcode[k_riga_insert] = 0
		kds_pl_barcode.object.barcode[k_riga_insert] = kst_tab_barcode_figlio.barcode
		kds_pl_barcode.object.barcode_lav[k_riga_insert] = kst_tab_barcode_figlio.barcode_lav
		kds_pl_barcode.object.groupage[k_riga_insert] = kst_tab_barcode_figlio.groupage
		kds_pl_barcode.object.fila_1[k_riga_insert] = kst_tab_barcode_figlio.fila_1
		kds_pl_barcode.object.fila_2[k_riga_insert] = kst_tab_barcode_figlio.fila_2
		kds_pl_barcode.object.fila_1p[k_riga_insert] = kst_tab_barcode_figlio.fila_1p
		kds_pl_barcode.object.fila_2p[k_riga_insert] = kst_tab_barcode_figlio.fila_2p
		kds_pl_barcode.object.num_int[k_riga_insert] = kst_tab_barcode_figlio.num_int
		kds_pl_barcode.object.clie_2[k_riga_insert] = kst_tab_meca.clie_2
		kds_pl_barcode.object.area_mag[k_riga_insert] = trim(kst_tab_meca.area_mag)
		kds_pl_barcode.object.rag_soc_10[k_riga_insert] = trim(kst_tab_clienti.rag_soc_10)
		
	end for

end for

destroy kuf1_barcode



//=== riprisino Puntatore
SetPointer(oldpointer)

return kds_pl_barcode

end function

public function integer importa_inizio_lav_pilota (string k_simulazione) throws uo_exception;//---
//--- Importa dati di Inizio LAVORAZIONE dal Nuovo Pilota e aggiorna le tabelle
//--- 
//--- Input: Simulazione Si/No   '0'=fa aggiornamenti, '1'=simula e non aggiorna nulla
//--- Output: Numero di righe aggiornate
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//--- Tabelle PILOTA coinvolte:
//--- PALLET
long k_riga_impo=0, k_ctr=0, k_righe_pallet_tot=0, k_riga_pallet, k_rc
date k_data_ultima, k_data_da=date(0), k_Data_Entrata_da, k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
boolean k_m2000_errore = false, k_m2000_caricopilota = false
boolean k_e1_enabled
st_tab_barcode kst_tab_barcode_figlio
kuf_barcode kuf1_barcode
kuf_base kuf1_base
kuf_armo kuf1_armo
kuf_sv_skedula kuf1_sv_skedula
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
datastore kds_1
kuf_wm_dll_m2000utility kuf1_wm_dll_m2000utility
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota
st_tab_meca kst_tab_meca
st_tab_pilota_pallet kst_tab_pilota_pallet
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014, kst_tab_e1_wo_f5548014_appo
kds_pilota_pallet_in kds1_pilota_pallet_in


try
 
//=== Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_attesa )
		
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
		
		
		k_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?

		try 
			kds1_pilota_pallet_in = create kds_pilota_pallet_in
			kds1_pilota_pallet_in.db_connetti()  // Connessione al DB PILOTA
			k_Data_Entrata_da = relativedate(kguo_g.get_dataoggi( ), -30)
			k_righe_pallet_tot = kds1_pilota_pallet_in.retrieve(k_Data_Entrata_da)
	
		catch (uo_exception kuo7_exception)
			k_righe_pallet_tot = -99

		finally
			kds1_pilota_pallet_in.db_disconnetti() // Chiude immediatamente la Connessione al DB PILOTA 

		end try

		if isnull(k_simulazione) then k_simulazione = '1'  //se nullo x sicurezza imposto SIMULAZIONE SI

		if k_righe_pallet_tot < 1 then 
			if k_righe_pallet_tot < 0 then 
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_righe_pallet_tot
				kst_esito.SQLErrText = "Errore durante ricerca per Importazione Inizio Lavorazione dall'impianto (PILOTA)" //:~n~r" + trim(kguo_sqlca_db_pilota.SQLErrText)
			else
				kst_esito.esito = kkg_esito.not_fnd
				kst_esito.sqlcode = k_righe_pallet_tot
				kst_esito.SQLErrText = "Nessun Lotto per Importazione Inizio Lavorazione dall'impianto (PILOTA)" //:~n~r" + trim(kguo_sqlca_db_pilota.SQLErrText)
			end if
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if

		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
		
		if k_e1_enabled then
		else
//--- apre la connessione (dll) con il WM 	x movimentare lo carico/scarico barcode
			try 
				kuf1_wm_dll_m2000utility = create kuf_wm_dll_m2000utility
				kuf1_wm_dll_m2000utility.crea_object()
				kuf1_wm_dll_m2000utility.login( )
			catch (uo_exception kuo1_exception)
				k_m2000_errore = true		
			end try
		end if
			
		//--- lettura fuori ciclo	
//			fetch c1_importa_inizio_lav_pilota into  
//						:kst_tab_pilota_pallet.Data_Entrata,   
//						:kst_tab_pilota_pallet.Data_Uscita,   
//						:kst_tab_pilota_pallet.Pallet_Code,   
//						:kst_tab_pilota_pallet.F1AVP,   
//						:kst_tab_pilota_pallet.F2AVP,   
//						:kst_tab_pilota_pallet.F1APP,   
//						:kst_tab_pilota_pallet.F2APP,   
//						:kst_tab_pilota_pallet.Posizione,   
//						:kst_tab_pilota_pallet.Bilancella;  
			
		SetPointer(kkg.pointer_attesa )
		
		for k_riga_pallet = 1 to k_righe_pallet_tot
			
	//--- popola struttura da datastore elenco PALLET con data FINE LAVORAZIONE
			kst_tab_pilota_pallet.Data_Entrata = kds1_pilota_pallet_in.getitemdatetime(k_riga_pallet, "Data_Entrata")   
			kst_tab_pilota_pallet.Data_Uscita = kds1_pilota_pallet_in.getitemdatetime(k_riga_pallet, "Data_Uscita")
			kst_tab_pilota_pallet.Pallet_Code = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "Pallet_Code") 
			kst_tab_pilota_pallet.F1AVP = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "F1AVP")
			kst_tab_pilota_pallet.F2AVP = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "F2AVP")
			kst_tab_pilota_pallet.F1APP = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "F1APP")
			kst_tab_pilota_pallet.F2APP = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "F2APP")
			kst_tab_pilota_pallet.Posizione = kds1_pilota_pallet_in.getitemstring(k_riga_pallet, "Posizione")
			kst_tab_pilota_pallet.Bilancella = kds1_pilota_pallet_in.getitemnumber(k_riga_pallet, "Bilancella")
		
	//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
			yield ()
	
			kst_tab_barcode = kst_tab_barcode_vuota
	
			kst_tab_barcode.barcode = kst_tab_pilota_pallet.Pallet_Code
	
	//--- legge Barcode x prendere id armo e vede se gia' lavorato
			kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode)
			
	//--- se Barcode NON TROVATO
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza()
				kguo_exception.set_esito (kst_esito)
			else
	
	//--- se già messo in lavorazione evito di ri-aggiornare
				if kst_tab_barcode.data_lav_ini > kkg.data_zero then
					
					//--- già messo in lavorazione
					
				else
					
					try
		//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
						kst_tab_e1_wo_f5548014.wo_osdoco = 0 
						if k_e1_enabled and k_simulazione <> "1" then
							kst_tab_meca.id = kst_tab_barcode.id_meca
							kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
							if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
								//kst_tab_e1_wo_f5548014.data_osa801 = kGuf_data_base.get_e1_dateformat(kst_tab_pilota_pallet.Data_Entrata)
								kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Entrata, "dd/mm/yy")
								k_anno = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yyyy"))
								k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yy"))
								k_datainizioanno = date(k_anno,01,01)
								k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Entrata)) + 1
								kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
								kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Entrata))
								if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode) = 0 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
								end if
								if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode) = 1 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
									kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_meca)  // get del tipo ciclo pianificato
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
								end if
							end if
						end if

					//--- popola area TAB_BARCODE padre	
							u_set_tab_barcode(kst_tab_pilota_pallet, kst_tab_barcode)
							
					//--- Aggiorna gli archivi con i dati di Lavorazione ------------------------------------------------------
					//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
				
							kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
							kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini")
			
			//--- inserisce collo in ARTR
							put_barcode_padre_in_lav(kst_tab_barcode)
							
							if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
								kguo_exception.inizializza()
								kguo_exception.set_esito (kst_esito)
								throw kguo_exception
							end if
	
	//--- WM: ricorda che devo movimentare lo carico/scarico barcode
							if k_e1_enabled then
								k_m2000_caricopilota = true
							end if
							
							kguo_sqlca_db_magazzino.db_commit( )  //06072016
//							if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
//								kguo_sqlca_db_e1.db_commit( )
//							end if
			
			//--- Tratta eventuali Figli
							kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
			
							try
								for k_ctr = 1 to kds_1.rowcount( ) 
									
									kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
			//--- legge Barcode figlio
									kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode_figlio)
			//--- imposta i dati di trattamento uguali a quelli del PADRE		
									u_set_tab_barcode(kst_tab_pilota_pallet, kst_tab_barcode_figlio)

		//--- verifica se è il primo/ultimo barcode figlio che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
									kst_tab_e1_wo_f5548014.wo_osdoco = 0
									if k_e1_enabled then
										kst_tab_meca.id = kst_tab_barcode_figlio.id_meca
										kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
										if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
											//kst_tab_e1_wo_f5548014.data_osa801 = kGuf_data_base.get_e1_dateformat(kst_tab_pilota_pallet.Data_Entrata)
											kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Entrata, "dd/mm/yy")
											k_anno = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yyyy"))
											k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yy"))
											k_datainizioanno = date(k_anno,01,01)
											k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Entrata)) + 1
											kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
											kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Entrata))
											if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode_figlio) = 0 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
											end if
											if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode_figlio) = 1 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
												kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_meca)  // get del tipo ciclo pianificato
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
											end if
										end if
									end if
									
		//--- apre il Trattamento del Figlio
									apri_lav_barcode_figlio(kst_tab_barcode_figlio)
		
		//--- inserisce collo in ARTR
									put_barcode_figlio_in_lav(kst_tab_barcode_figlio)
	
									kguo_sqlca_db_magazzino.db_commit( )  //06072016
								end for
							
							catch (uo_exception kuo3_exception)
								throw kuo3_exception
								
							end try
						end if
						
				
	//--- conta i barcode importati in trattatamento
						k_riga_impo	++
							
	//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
	//--- COMMIT consolido su DB Tradizionale e E1
							kguo_sqlca_db_magazzino.db_commit( )
	
	//--- WM: x movimentare lo carico/scarico barcode ----------------------------------------------------------------------------------------------------------
							if k_m2000_caricopilota and NOT k_e1_enabled then
								k_m2000_caricopilota = false
								
								if not k_m2000_errore then
									
									try 
										kuf1_wm_dll_m2000utility.caricopilota( kst_tab_barcode.barcode )
									catch (uo_exception kuo2_exception)
									end try
	
	//--- Tratta i FIGLI 
									for k_ctr = 1 to kds_1.rowcount( ) 
										
										kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
	//--- legge Barcode figlio
										kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode_figlio)
	//--- imposta i dati di trattamento uguali a quelli del PADRE		
										u_set_tab_barcode(kst_tab_pilota_pallet, kst_tab_barcode_figlio)
										
	//--- WM: x movimentare lo carico/scarico barcode FIGLIO
										try 
											kuf1_wm_dll_m2000utility.caricopilota( kst_tab_barcode_figlio.barcode )
										catch (uo_exception kuo6_exception)
										end try
											
									end for
									
								end if
								
							end if
	//--- WM: FINE x movimentare lo carico/scarico barcode ----------------------------------------------------------------------------------------------------------
								
						
						end if
						
					catch (uo_exception kuo5_exception)
						//--- qls va male nella registrazione su E1

					finally
	//--- COMMIT consolido su DB Tradizionale e E1
						kguo_sqlca_db_magazzino.db_commit( )
											
						
					end try
				
				end if					
			end if
	//-------------------------------------------------------------------------------------------------------------
			
		end for
		
			
	//end if
	
	
	catch (uo_exception kuo4_exception) 
		kst_esito = kuo4_exception.get_st_esito()
		if kst_esito.esito = kkg_esito.db_ko then
			throw kuo4_exception
		end if

	finally

////--- Chiude Connessione al DB PILOTA 
//		try 
//			kguo_sqlca_db_pilota.db_disconnetti()
//		catch (uo_exception kuo7_exception)
//		end try
	
//--- Chiude la connessione (dll) con il WM 
		if not k_m2000_errore then
			if k_e1_enabled then
			else
				try 
					kuf1_wm_dll_m2000utility.logout( )
				catch (uo_exception kuo9_exception)
				end try
			end if
		end if

		if isvalid(kuf1_barcode) then destroy kuf1_barcode
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_wm_dll_m2000utility) then destroy kuf1_wm_dll_m2000utility
		if isvalid(kds1_pilota_pallet_in) then destroy kds1_pilota_pallet_in
		if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014

		SetPointer(kkg.pointer_default)

end try




return k_riga_impo

end function

public function integer importa_trattati_pilota (string k_simulazione) throws uo_exception;//
//=== Importa dati LAVORAZIONE dal Nuovo Pilota e aggiorna le tabelle
//--- 
//--- Input: Simulazione Si/No   '0'=fa aggiornamenti, '1'=simula e non aggiorna nulla
//--- Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//--- Tabelle PILOTA coinvolte:
//--- PALLET
long k_riga_impo=0, k_ctr, k_righe_pallet_tot=0, k_riga_pallet
date k_data_ultima, k_data_da=date(0)
boolean k_m2000_errore=false
boolean k_e1_enabled=false
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
long k_rc
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
kuf_base kuf1_base
//kuf_certif kuf1_certif
kuf_armo kuf1_armo 
kuf_sv_skedula kuf1_sv_skedula
kuf_wm_dll_m2000utility kuf1_wm_dll_m2000utility
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014
datastore kds_1
st_esito kst_esito
st_tab_base kst_tab_base
st_tab_artr kst_tab_artr, kst_tab_artr_vuota
st_tab_barcode kst_tab_barcode, kst_tab_barcode_vuota, kst_tab_barcode_figlio
st_tab_meca kst_tab_meca
st_tab_pilota_pallet kst_tab_pilota_pallet
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014, kst_tab_e1_wo_f5548014_appo
kds_pilota_pallet_out kds1_pilota_pallet_out



try
			
		//=== Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_attesa)
		
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
		
		k_e1_enabled = kguo_g.if_e1_enabled( )			// interfaccia E1 attiva?
	
		//--- Estrazione data da cui fare l'estrazione 
		try 
			kuf1_barcode = create kuf_barcode
			kst_tab_barcode = kuf1_barcode.get_primo_barcode_in_lav()
			k_data_da = kst_tab_barcode.data_lav_ini
		catch (uo_exception k1uo_exception)
			throw k1uo_exception
		finally
			destroy kuf1_barcode	
		end try
		k_riga_impo = 0
		
		if isnull(k_simulazione) then k_simulazione = '1'  //se nullo x sicurezza imposto SIMULAZIONE SI

		try 
			kds1_pilota_pallet_out = create kds_pilota_pallet_out
			kds1_pilota_pallet_out.db_connetti()	// Connessione al DB PILOTA
			k_righe_pallet_tot = kds1_pilota_pallet_out.retrieve(k_data_da) // LETTURA PALLET CON DATA FINE LAV IMPOSTATA
			
		catch (uo_exception kuo11_exception)
			k_righe_pallet_tot = -99
			
		finally
			kds1_pilota_pallet_out.db_disconnetti()	// Immediata disconnessione al DB PILOTA
		end try
		
		if k_righe_pallet_tot < 1 then
			if k_righe_pallet_tot < 0 then 
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_righe_pallet_tot
				kst_esito.SQLErrText = "Errore durante Importazione Trattati dall'impianto (PILOTA)"
			else
				kst_esito.esito = kkg_esito.ok
				kst_esito.sqlcode = k_righe_pallet_tot
				kst_esito.SQLErrText = "Nessun barcode da importare come Trattato dall'impianto (PILOTA)" //:~n~r" + trim(kguo_sqlca_db_pilota.SQLErrText)
			end if
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
		kuf1_artr = create kuf_artr
		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo
		kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
	
		if k_e1_enabled then
		else
	//--- apre la connessione (dll) con il WM 	x movimentare lo carico/scarico barcode
			try 
				kuf1_wm_dll_m2000utility = create kuf_wm_dll_m2000utility
				kuf1_wm_dll_m2000utility.crea_object()
				kuf1_wm_dll_m2000utility.login( )
			catch (uo_exception kuo10_exception)
				k_m2000_errore = true			
			end try
		end if
		
		for k_riga_pallet = 1 to k_righe_pallet_tot
			
	//--- popola struttura da datastore elenco PALLET con data FINE LAVORAZIONE
			kst_tab_pilota_pallet.Data_Entrata = kds1_pilota_pallet_out.getitemdatetime(k_riga_pallet, "Data_Entrata")   
			kst_tab_pilota_pallet.Data_Uscita = kds1_pilota_pallet_out.getitemdatetime(k_riga_pallet, "Data_Uscita")
			kst_tab_pilota_pallet.Pallet_Code = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "Pallet_Code") 
			kst_tab_pilota_pallet.F1AVP = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "F1AVP")
			kst_tab_pilota_pallet.F2AVP = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "F2AVP")
			kst_tab_pilota_pallet.F1APP = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "F1APP")
			kst_tab_pilota_pallet.F2APP = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "F2APP")
			kst_tab_pilota_pallet.Posizione = kds1_pilota_pallet_out.getitemstring(k_riga_pallet, "Posizione")
			kst_tab_pilota_pallet.Bilancella = kds1_pilota_pallet_out.getitemnumber(k_riga_pallet, "Bilancella")
	
	//--- piccolo lasso di tempo a favore di altre cose usato x  tasto 'interrompi'
			yield ()
	
			kst_tab_barcode = kst_tab_barcode_vuota
	
	//--- Estrazione del BARCODE 
			kst_tab_barcode.barcode = kst_tab_pilota_pallet.Pallet_Code
	
	//--- legge Barcode x prendere id armo e vede se gia' lavorato
			kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode)
			
	//--- se Barcode NON TROVATO salta al prx
			if kst_esito.esito <> kkg_esito.ok then 
				kguo_exception.inizializza()
				kGuo_exception.set_esito (kst_esito)
			else
	
	//--- se ancora da chiudere in lavorazione...			
				if kst_tab_barcode.data_lav_fin > kkg.data_zero then
					//--- già chiuso!!
				else

					try
							
		//--- Carica i dati nella tabella di scambio per E1
						kst_tab_e1_wo_f5548014.wo_osdoco = 0 
						if k_e1_enabled and k_simulazione <> "1" then
							kst_tab_meca.id = kst_tab_barcode.id_meca
							kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
							if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then

		//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
								kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Entrata, "dd/mm/yy")
								k_anno = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yyyy"))
								k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yy"))
								k_datainizioanno = date(k_anno,01,01)
								k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Entrata)) + 1
								kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
								kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Entrata))
								if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode) = 0 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
								end if
								if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode) = 1 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
									kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_meca)  // get del tipo ciclo pianificato
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
								end if

		//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
								//kst_tab_e1_wo_f5548014.data_osa801 = kGuf_data_base.get_e1_dateformat(kst_tab_pilota_pallet.Data_Uscita)
								kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Uscita, "dd/mm/yy")
								k_anno = integer(string(kst_tab_pilota_pallet.Data_Uscita, "yyyy"))
								k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Uscita, "yy"))
								k_datainizioanno = date(k_anno,01,01)
								k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Uscita)) + 1
								kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
								kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Uscita))
								if kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode) = 0 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstunload
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi per E1 primo pallet uscito 
								end if
								if kuf1_barcode.get_nr_barcode_da_trattare_x_id_meca(kst_tab_barcode) = 1 then
									kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastunload
									kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
									kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
									kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi su E1 ultimo pallet uscito 
								end if
							end if
						end if

//--- popola campi per chiudere il barcode					
						u_set_tab_barcode(kst_tab_pilota_pallet, kst_tab_barcode)
//						kst_tab_barcode.data_lav_ini = date(kst_tab_pilota_pallet.Data_Entrata)
//						kst_tab_barcode.ora_lav_ini = time(kst_tab_pilota_pallet.Data_Entrata)
//						kst_tab_barcode.data_lav_fin = date(kst_tab_pilota_pallet.Data_Uscita)
//						kst_tab_barcode.ora_lav_fin = time(kst_tab_pilota_pallet.Data_Uscita)
//						kst_tab_barcode.lav_fila_1 = kst_tab_pilota_pallet.F1AVP
//						kst_tab_barcode.lav_fila_2 = kst_tab_pilota_pallet.F2AVP
//						kst_tab_barcode.lav_fila_1p = kst_tab_pilota_pallet.F1ApP
//						kst_tab_barcode.lav_fila_2p = kst_tab_pilota_pallet.F2ApP
//						kst_tab_barcode.posizione = kst_tab_pilota_pallet.Posizione
//						kst_tab_barcode.Bilancella = kst_tab_pilota_pallet.Bilancella
						
				//--- verifica la lavorazione se ci sono anomalie
						kuf1_barcode.check_anomalie_lavorazione(kst_tab_barcode)
				
				//--- Aggiorna gli archivi con i dati di Lavorazione ------------------------------------------------------
				//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
				
							kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
							kst_esito = kuf1_barcode.tb_update_campo(kst_tab_barcode, "data_lav_ini_fin") //AGGIORNA TAB
				
							if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
								kguo_exception.inizializza()
								kguo_exception.set_esito (kst_esito)
								throw kguo_exception
							end if
		
							if k_e1_enabled then
//								kguo_sqlca_db_e1.db_commit( )
							else
					
	//--- WM: x movimentare il carico/scarico barcode
								if not k_m2000_errore then
									try 
										if k_simulazione <> "1" then
											kuf1_wm_dll_m2000utility.scaricopilota( kst_tab_barcode.barcode )
										end if
									catch (uo_exception kuoDLL_exception)
									end try
								end if
							end if
						end if
				
				//--- se Anomalia....
						if kst_tab_barcode.err_lav_fin = kuf1_barcode.ki_err_lav_fin_ko then
							kst_tab_meca.id = kst_tab_barcode.id_meca 
							kst_tab_meca.err_lav_fin = kst_tab_barcode.err_lav_fin 
									
				//--- se elaborazione NO di simulazione
							if k_simulazione <> "1" then
								kst_tab_meca.st_tab_g_0.esegui_commit = "N" 
								kst_esito = kuf1_armo.setta_errore_lav(kst_tab_meca)  // AGGIORNA ERRORE SU MECA
								
								if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
									kguo_exception.inizializza()
									kguo_exception.set_esito (kst_esito)
									throw kguo_exception
								end if
							end if
				
						end if
								
				
				//--- Chiude lavorazione del Barcode su ARTR 
						kst_esito.esito = kkg_esito.ok 
						kst_tab_artr = kst_tab_artr_vuota
						kst_tab_artr.id_armo = kst_tab_barcode.id_armo 
						kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
				
				//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
							kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
							kst_esito = kuf1_artr.chiudi_lavorazione(kst_tab_artr)
							
							if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
								kguo_exception.inizializza()
								kguo_exception.set_esito (kst_esito)
								throw kguo_exception
							end if
				
						end if
				
						kst_tab_artr.num_certif = 0
		//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
							
		//--- Crea ATTESTATO su ARTR - ritorna il num certificato  
							kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
							kst_esito = kuf1_artr.crea_attestato_dettaglio(kst_tab_artr)
							
							if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then //--- errore grave
								kguo_exception.inizializza()
								kguo_exception.set_esito (kst_esito)
								throw kguo_exception
							end if

		//--- Imposta i Tempi Impianto di trattamento sul BARCODE
							kst_tab_barcode.st_tab_g_0.esegui_commit = "N" 
							k_rc = kuf1_barcode.set_imptime_second(kst_tab_barcode)
								
						end if
						
						kguo_sqlca_db_magazzino.db_commit( )  //06072016

		//--- conta i barcode importati trattati
						k_riga_impo	++

		//--- se elaborazione NO di simulazione...
						if k_simulazione <> "1" then
		
		//--- Piglia gli eventuali Figli
							kds_1 = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
		
							try
								
								for k_ctr = 1 to kds_1.rowcount( ) 
									
									kst_tab_barcode_figlio.barcode = kds_1.object.barcode[k_ctr]
		//--- legge Barcode figlio
									kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode_figlio)
		//--- imposta i dati di trattamento uguali a quelli del PADRE			
									kst_tab_barcode_figlio.data_lav_ini = kst_tab_barcode.data_lav_ini 
									kst_tab_barcode_figlio.ora_lav_ini = kst_tab_barcode.ora_lav_ini 
									kst_tab_barcode_figlio.data_lav_fin = kst_tab_barcode.data_lav_fin 
									kst_tab_barcode_figlio.ora_lav_fin = kst_tab_barcode.ora_lav_fin 
									kst_tab_barcode_figlio.lav_fila_1 = kst_tab_barcode.lav_fila_1 
									kst_tab_barcode_figlio.lav_fila_2 = kst_tab_barcode.lav_fila_2 
									kst_tab_barcode_figlio.lav_fila_1p = kst_tab_barcode.lav_fila_1p 
									kst_tab_barcode_figlio.lav_fila_2p = kst_tab_barcode.lav_fila_2p 
									kst_tab_barcode_figlio.posizione = kst_tab_barcode.posizione 
									kst_tab_barcode_figlio.Bilancella = kst_tab_barcode.Bilancella 
		//--- verifica la lavorazione se ci sono anomalie
									kuf1_barcode.check_anomalie_lavorazione(kst_tab_barcode_figlio)
								
		//--- Carica i dati nella tabella di scambio per E1
									kst_tab_e1_wo_f5548014.wo_osdoco = 0 
									if k_e1_enabled then
										kst_tab_meca.id = kst_tab_barcode_figlio.id_meca
										kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
										if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
		//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
											kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Entrata, "dd/mm/yy")
											k_anno = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yyyy"))
											k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Entrata, "yy"))
											k_datainizioanno = date(k_anno,01,01)
											k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Entrata)) + 1
											kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
											kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Entrata))
											if kuf1_barcode.get_nr_barcode_lav_ini(kst_tab_barcode_figlio) = 0 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstload
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come prima entrata x E1
											end if
											if kuf1_barcode.get_nr_barcode_no_lav_ini_x_id_meca(kst_tab_barcode_figlio) = 1 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastload
												kst_tab_e1_wo_f5548014_appo = u_get_e1_ws_f5548014_pianif(kst_tab_meca)  // get del tipo ciclo pianificato
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = kst_tab_e1_wo_f5548014_appo.tcicli_osmmcu
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi come ultimo entrato x E1
											end if

		//--- verifica se è il primo/ultimo barcode che finisce il trattamento e lo salva in e1_wo_f5548014 per poi comunicarlo a E1
											//kst_tab_e1_wo_f5548014.data_osa801 = kGuf_data_base.get_e1_dateformat(kst_tab_pilota_pallet.Data_Uscita)
											kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_pilota_pallet.Data_Uscita, "dd/mm/yy")
											k_anno = integer(string(kst_tab_pilota_pallet.Data_Uscita, "yyyy"))
											k_anno_rid = integer(string(kst_tab_pilota_pallet.Data_Uscita, "yy"))
											k_datainizioanno = date(k_anno,01,01)
											k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_pilota_pallet.Data_Uscita)) + 1
											kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
											kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(kst_tab_pilota_pallet.Data_Uscita))
											if kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode_figlio) = 0 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_firstunload
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi su E1
											end if
											if kuf1_barcode.get_nr_barcode_da_trattare_x_id_meca(kst_tab_barcode_figlio) = 1 then
												kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_lastunload
												kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""
												kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit = "N"
												kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)  // registra i tempi su E1
											end if
										end if
									end if

		//--- chiude il Trattamento del Figlio
									chiudi_lav_barcode_figlio(kst_tab_barcode_figlio)

		//--- Imposta i Tempi Impianto di trattamento sul BARCODE figlio
									kst_tab_barcode_figlio.st_tab_g_0.esegui_commit = "N" 
									k_rc = kuf1_barcode.set_imptime_second(kst_tab_barcode_figlio)
			
									kguo_sqlca_db_magazzino.db_commit( )  //06072016
//									if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
//										kguo_sqlca_db_e1.db_commit( )
//									end if

									if not k_e1_enabled then
		//--- WM: x movimentare lo carico/scarico barcode
										if not k_m2000_errore then
											try 
												kuf1_wm_dll_m2000utility.scaricopilota( kst_tab_barcode_figlio.barcode )
											catch (uo_exception kuo12_exception)
											end try
										end if
									end if
				
								end for
								
		//--- consolido su DB -------------------------------------------------------------------------
								kguo_sqlca_db_magazzino.db_commit( )
		//------------------------------------------------------------------------------------------------	
								
							catch (uo_exception kuo1_exception)
								kguo_sqlca_db_magazzino.db_rollback( )
								throw kuo1_exception
						
							finally
								kguo_sqlca_db_magazzino.db_commit( )  
						
							end try
						
						end if
								
		//--- provo a chiudere lavorazione sul Lotto MECA
		//--- se elaborazione NO di simulazione...
						kst_esito.esito = kkg_esito.ok 
						if k_simulazione <> "1" then
							
							kst_tab_meca.id = kst_tab_barcode.id_meca
							kst_tab_meca.data_lav_fin = kst_tab_barcode.data_lav_fin
							kst_tab_meca.st_tab_g_0.esegui_commit = "S"
							kst_esito = kuf1_armo.chiudi_lavorazione(kst_tab_meca)
				
							if kst_esito.esito = kkg_esito.db_ko then //--- errore grave
								kguo_exception.inizializza()
								kguo_exception.set_esito (kst_esito)
								throw kguo_exception
							end if
						end if
						
					catch (uo_exception kuo5_exception)
						//--- qls va male nella registrazione su E1

					end try
					
				end if
			end if
	//-------------------------------------------------------------------------------------------------------------
			
		end for
		
	
	
//--- se elaborazione NO di simulazione...
		if k_simulazione <> "1" then
//--- consolido su DB -------------------------------------------------------------------------
			kguo_sqlca_db_magazzino.db_commit( )
//------------------------------------------------------------------------------------------------	
		end if
	
	
//--- se elaborazione NO di simulazione...
	if k_simulazione <> "1" then

		kuf1_barcode = create kuf_barcode
		kst_tab_barcode = kuf1_barcode.get_ultimo_barcode_importato( )
		k_data_ultima = kst_tab_barcode.data_lav_fin
		destroy kuf1_barcode

		kuf1_base = create kuf_base

		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "data_ultima_estrazione_pilota_out" 
		kst_tab_base.key1 = string(kst_tab_barcode.data_lav_fin)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito  = kkg_esito.db_ko then
			kst_esito.sqlerrtext =  "Archivio Azienda: Aggiornamento Data Fine estrazione dal flusso 'Esiti Pilota' fallito:~n~r" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
		end if
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "ora_ultima_estrazione_pilota_out"
		kst_tab_base.key1 = string(kst_tab_barcode.ora_lav_fin)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		if kst_esito.esito  = kkg_esito.db_ko then
			kst_esito.sqlerrtext = "Archivio Azienda: Aggiornamento Ora Fine estrazione dal flusso 'Esiti Pilota' fallito:~n~r" + string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext) + "~n~r" 
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
		end if
		destroy kuf1_base
	end if

//--- Se ERRORE ---------------------------------------------------------------------------
	catch (uo_exception k2uo_exception)
		kst_esito = k2uo_exception.get_st_esito()
		if kst_esito.esito <> kkg_esito.ok then
			throw k2uo_exception
		end if
		
	
//--- FINE -----------------------------------------------------------------------------------
	finally 	
		
//--- Chiude la connessione (dll) con il WM  
		if not k_m2000_errore then
			if k_e1_enabled then
			else
				try 
					kuf1_wm_dll_m2000utility.logout( )
				catch (uo_exception kuo9_exception)
				end try
			end if
		end if

//--- Chiude Connessione al DB PILOTA 
//		try 
//			kds1_pilota_pallet_out.db_disconnetti()
//		catch (uo_exception kuo11_exception)
//		end try

//--- distruzione oggetti		
		if isvalid(kuf1_wm_dll_m2000utility) then destroy kuf1_wm_dll_m2000utility
		if isvalid(kuf1_artr) then destroy kuf1_artr
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kds1_pilota_pallet_out) then destroy kds1_pilota_pallet_out
		if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014

		SetPointer(kkg.pointer_default)

end try	
	


//=== riprisino Puntatore
//	SetPointer(oldpointer)
//
////--- Ripristina path di lavoro
//	kGuf_data_base.setta_path_default()


return k_riga_impo

end function

public subroutine put_barcode_figlio_in_lav (st_tab_barcode kst_tab_barcode_figli) throws uo_exception;//
//--- Mette i Barcode Figli in Tabella Trattamenti ARTR
//--- dal Padre risale ai figli
//---
//--- Chiede in INPUT:
//---      		kst_tab_barcode.barcode   =  Barcode Padre
//---
//---
long k_riga, k_ctr
date k_dataoggi
st_esito kst_esito
//st_tab_barcode  kst_tab_barcode_figli
st_tab_artr kst_tab_artr
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
datastore kds_figli
uo_exception kuo1_exception


k_dataoggi = kguo_g.get_dataoggi( )

try
	kuf1_barcode = create kuf_barcode
	kuf1_artr = create kuf_artr

//--- Mette eventuali FIGLI in Programmazione
//	k_ctr = kuf1_barcode.get_conta_figli(kst_tab_barcode)
//	if k_ctr > 0 then
//		kds_figli = kuf1_barcode.get_figli_barcode(kst_tab_barcode)
//		
//		for k_ctr = 1 to kds_figli.rowcount()
//
//			kst_tab_barcode_figli.barcode = kds_figli.object.barcode[k_ctr]
			
//--- legge barcode 
			kuf1_barcode.select_barcode(kst_tab_barcode_figli)
		
//--- Aggiornamento tabella ARTR 
			setnull(kst_tab_artr.data_fin) 
			kst_tab_artr.pl_barcode = kst_tab_barcode_figli.pl_barcode
//			kst_tab_artr.data_in = k_dataoggi
//			kst_tab_artr.colli = 1 
//			kst_tab_artr.colli_groupage = 1 
			kst_tab_artr.id_armo = kst_tab_barcode_figli.id_armo
			kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
			kst_esito = kuf1_artr.apri_lavorazione(kst_tab_artr)
			
			if trim(kst_esito.esito) = kkg_esito.db_ko then
				kuo1_exception = create uo_exception
				kuo1_exception.set_esito( kst_esito)
				throw kuo1_exception
			end if

		
//		end for
//		
//	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_artr) then destroy kuf1_artr
	
end try
	
end subroutine

public subroutine put_barcode_padre_in_lav (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//--- Mette il Barcode (padre o single)  in Tabella Trattamenti ARTR come INIZIO LAVORAZIONE
//---
//--- Chiede in INPUT:
//---      		kst_tab_barcode.barcode   =  Barcode 
//---
//---
long k_riga, k_ctr
date k_dataoggi
st_esito kst_esito
//st_tab_barcode  kst_tab_barcode_figli
st_tab_artr kst_tab_artr
kuf_barcode kuf1_barcode
kuf_artr kuf1_artr
datastore kds_figli
uo_exception  kuo1_exception



k_dataoggi = kguo_g.get_dataoggi( ) //date(kuf1_base.prendi_dato_base("dataoggi"))

try
	kuf1_barcode = create kuf_barcode
	kuf1_artr = create kuf_artr

//--- legge barcode 
	kuf1_barcode.select_barcode(kst_tab_barcode)
		
//--- Aggiornamento tabella ARTR 
	setnull(kst_tab_artr.data_fin) 
	kst_tab_artr.pl_barcode = kst_tab_barcode.pl_barcode
//	kst_tab_artr.data_in = k_dataoggi
//	kst_tab_artr.colli = 1 
//	kst_tab_artr.colli_groupage = 0 
	kst_tab_artr.id_armo = kst_tab_barcode.id_armo
	kst_tab_artr.st_tab_g_0.esegui_commit = "N" 
	kst_esito = kuf1_artr.apri_lavorazione(kst_tab_artr)
	
	if trim(kst_esito.esito) = kkg_esito.db_ko then
		kuo1_exception = create uo_exception
		kuo1_exception.set_esito( kst_esito)
		throw kuo1_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kuf1_artr) then destroy kuf1_artr
	
end try
	
end subroutine

public function boolean crea_file_pilota_figli (ds_pl_barcode kds_pl_barcode) throws uo_exception;//
//--- Crea archivio pallet FIGLI  Normalizzato per il Nuovo Pilota (probabile PP_PILOTA___.TXT)
//---  Input: il datastore pieno di righe da generare
//--- Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//--- Lancia un EXCEPTION se si verificano errore gravik_return
//---
//--- ESEMPIO di file
//972D28892,037D28905,Nominativo cliente,58445 
//
//vediamo il tracciato:kst_tab_pl_barcode
//972D28892=codice barcode del padre
//037D28905=codice barcode del filgio
//nominativo...=nominativo del cliente
//58445= numero di riferimento
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
long k_riga, k_righe, k_riga_write=0, k_riga_write_dosimetro=0, k_ctr
string k_sep=","
int k_filenum, k_byte, k_rcn
string k_rc, k_path_temp, k_path_pilota, k_file_nome,  k_record = " ", k_file_temp, k_file_pilota
boolean k_return=false
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_meca_dosim kst_tab_meca_dosim
kuf_pilota_cmd kuf1_pilota_cmd
kuf_utility kuf1_utility
ds_pl_barcode kds_pl_barcode_figli, kds_pl_barcode_padri

pointer oldpointer  // Declares a pointer variable



oldpointer = SetPointer(HourGlass!)

	
	
try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()
 
 	k_riga = 0
	
	kuf1_pilota_cmd = create kuf_pilota_cmd
	kuf1_utility = create kuf_utility
	
	kuf1_pilota_cmd.get_pilota_cfg()  //legge la configurazione
	k_path_pilota = kuf1_pilota_cmd.get_path_file_pl_barcode() //valorizza path x scambio con PILOTA
	k_path_temp = kuf1_pilota_cmd.get_path_temp( ) //valorizza path temporaneo
	k_file_nome =  kuf1_pilota_cmd.get_file_pl_barcode() //valorizza file
	k_file_temp = k_path_temp + k_file_nome 
	k_file_pilota = k_path_pilota + k_file_nome 
	
//--- Genera file pilota
	k_FileNum = FileOpen(k_file_temp, LineMode!, Write!, LockWrite!, Replace!)
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Apertura fallita archivio 'File Pian.Lav. x il Pilota' (FIGLI): ~n~r"+k_file_temp
		kst_esito.nome_oggetto = this.classname()
		kGuo_exception.inizializza( )
		kGuo_exception.set_esito (kst_esito)
		throw kGuo_exception
	end if


//--- Piglia i figli dal Datastore dei padri
	kds_pl_barcode_figli = get_ds_barcode_figli_da_padri(kds_pl_barcode)
	
//--- popola il file x il Pilota con i barcode figli 
	if kds_pl_barcode_figli.rowcount() > 0 then
		if crea_file_pilota_figli_da_trattare(kds_pl_barcode_figli, k_file_temp, k_filenum) then
			k_return = true
		end if		
	end if		

//--- popola il file x il Pilota con i DOSIMETRI presenti sui barcode padri 
	kds_pl_barcode_padri = get_ds_barcode_padri(kds_pl_barcode)  //27052014
	if kds_pl_barcode_padri.rowcount( ) > 0 then
		if crea_file_pilota_figli_dosimetri(kds_pl_barcode_padri, k_file_temp, k_filenum) then
			k_return = true
		end if		
	end if

//--- popola il file x il Pilota con i DOSIMETRI presenti sui barcode figli 
	if kds_pl_barcode_figli.rowcount() > 0 then
		if crea_file_pilota_figli_dosimetri(kds_pl_barcode_figli, k_file_temp, k_filenum) then
			k_return = true
		end if		
	end if		
	
	
//--- chiudo archivio
	if FileClose(k_FileNum) < 1 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Rilascio (close) archivio 'File Pian.Lav. x il Pilota' (FIGLI) Fallito, nome: ~n~r"+k_file_temp
	end if


//--- Crea e Popola file x il Pilota con POSIZIONI DOSIMETRI 
	crea_file_pilota_dosimpos(kds_pl_barcode, k_file_nome, k_path_temp, k_path_pilota)


//--- Copia il file da cartella TEMPORANEA a cartella di SCAMBIO con il Pilota
	if kst_esito.esito = kkg_esito.ok then
		if k_file_temp <> k_file_pilota then
			k_rcn = kuf1_utility.u_copia_file( k_file_temp, k_file_pilota, true)
			if k_rcn < 0 then
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = k_rcn
				kst_esito.SQLErrText = "Copia file 'File Pian.Lav. x il Pilota (FIGLI)' fallito,  ~n~rda: "  &
												+ k_file_temp & 
												+ "~n~ra: "+k_file_pilota
			end if	
		end if	
	end if
		


catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally

	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd
	if isvalid(kuf1_utility) then destroy kuf1_utility

//--- ripristino Puntatore
	SetPointer(oldpointer)

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()

//--- se errore grave allora exception
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.nome_oggetto = this.classname()
		kguo_exception.inizializza( )
		kGuo_exception.set_esito (kst_esito)
		throw kGuo_exception
	end if


end try

return k_return

end function

public function boolean crea_file_pilota_figli_dosimetri (ds_pl_barcode kds_pl_barcode, string k_path_file, integer k_filenum) throws uo_exception;//---
//---  Aggiunge ad archivio   Normalizzato per il Nuovo Pilota, uguale al file figli  i Barcode Dosimetri   (probabile PP_PILOTA___.TXT)
//---  Input: il datastore con tutti i barcode su cui cercare se hanno Dosimetri associati
//---  Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//---  Lancia un EXCEPTION se si verificano errore gravik_return
//---
//---  ESEMPIO di file
//972D28892,037D28905,Nominativo cliente,58445 
//
//vediamo il tracciato:
//972D28892=codice barcode del padre
//037D28905=codice barcode del filgio
//nominativo...=nominativo del cliente
//58445= numero di riferimento
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
boolean k_return=false
long k_riga, k_righe, k_riga_write_dosimetro=0, k_ctr
string k_sep=","
int  k_byte, k_rcn, k_nr_meca_dosim, k_ind
string k_rc,  k_record = " "
datastore kds_barcode
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_meca_dosim kst_tab_meca_dosim[]
kuf_barcode kuf1_barcode
kuf_meca_dosim kuf1_meca_dosim
kuf_utility kuf1_utility



	
try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()
	
	k_riga = 0
	
	kuf1_utility = create kuf_utility
	kuf1_meca_dosim = create kuf_meca_dosim  // eccezione di solito 
	kuf1_barcode = create kuf_barcode
	
	kds_barcode = create datastore
	kds_barcode.dataobject = "ds_barcode"
	kds_barcode.settransobject( sqlca)
	
	k_riga=1
	k_riga_write_dosimetro = 0

	k_righe = kds_pl_barcode.rowcount() 
	if k_righe > 0 then
		kst_tab_pl_barcode.codice = kds_pl_barcode.object.pl_barcode[1]
	end if

	k_byte = 1  //numero di byte scritti, inizialmente forzo a 1 se < 0 errore grave
	do while k_riga <= k_righe and k_byte > 0
		kst_tab_barcode.barcode = trim(kds_pl_barcode.object.barcode[k_riga])

//--- rilegge il barcode per avere le ultime, non si sa mai
		kds_barcode.reset( )
		if kds_barcode.retrieve(kst_tab_barcode.barcode) > 0 then
		
			kst_tab_barcode.pl_barcode = kds_barcode.object.pl_barcode[1]
			kst_tab_barcode.pl_barcode_progr = kds_barcode.object.pl_barcode_progr[1]
			kst_tab_barcode.barcode_lav = kds_barcode.object.barcode_lav[1]
			kst_tab_barcode.groupage = kds_barcode.object.groupage[1]
			kst_tab_barcode.flg_dosimetro = kds_barcode.object.flg_dosimetro[1]
			kst_tab_barcode.id_meca = kds_barcode.object.id_meca[1]
			kst_tab_barcode.fila_1 = kds_barcode.object.fila_1[1]
			kst_tab_barcode.fila_2 = kds_barcode.object.fila_2[1]
			kst_tab_barcode.fila_1p = kds_barcode.object.fila_1p[1]
			kst_tab_barcode.fila_2p = kds_barcode.object.fila_2p[1]
			kst_tab_meca.num_int = kds_barcode.object.num_int[1]
			
//--- questi dati li piglia dal datastore entrato come arg			
			kst_tab_meca.clie_2 = kds_pl_barcode.object.clie_2[k_riga]
			kst_tab_meca.area_mag = kds_pl_barcode.object.area_mag[k_riga]
			kst_tab_clienti.rag_soc_10 = kds_pl_barcode.object.rag_soc_10[k_riga]

//--- Tratta i NULL		
			if isnull(kst_tab_barcode.barcode_lav) then
				kst_tab_barcode.barcode_lav = ""
			end if
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0
			end if
			if isnull(kst_tab_barcode.barcode) then
				kst_tab_barcode.barcode = " "
			end if
			if isnull(kst_tab_barcode.pl_barcode) then
				kst_tab_barcode.pl_barcode = 0
			end if
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
	
	//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, k_sep, " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "'", " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "*", " ")
		
	
	//--- Se il BARCODE ha ACCOPPIATO un DOSIMETRO allora fingo sia un barcode FIGLIO quindi scrive
			if trim(kst_tab_barcode.flg_dosimetro) = kuf1_barcode.ki_flg_dosimetro_si then
	
	//--- recupera il codice DOSIMETRO (un codice di Barcode fittizio) 
				kst_tab_meca_dosim[1].id_meca = kst_tab_barcode.id_meca
				kst_tab_meca_dosim[1].barcode_lav = kst_tab_barcode.barcode
				k_nr_meca_dosim = kuf1_meca_dosim.get_barcode(kst_tab_meca_dosim[])
//160715				if kuf1_meca_dosim.get_barcode(kst_tab_meca_dosim) then

				k_ind=1
				for k_ind = 1 to k_nr_meca_dosim
		
//--- Il barcode che contiene il dosimetro e' a sua volta un filgio (barcode_lav valorizzato)? 		
					if Len(trim(kst_tab_barcode.barcode_lav)) > 0 then
						k_record = trim(kst_tab_barcode.barcode_lav) 
					else
						k_record = trim(kst_tab_barcode.barcode) 
					end if
					if trim(kst_tab_meca_dosim[k_ind].barcode) > " " then
						k_record += k_sep + trim(kst_tab_meca_dosim[k_ind].barcode) & 
												  + k_sep+trim(kst_tab_clienti.rag_soc_10) + " " &
												  + k_sep+trim(string(kst_tab_meca.num_int,"#####0")) 
						
						k_byte = FileWrite(k_FileNum, k_record)
				
						if k_byte > 0 then
							k_riga_write_dosimetro ++
						end if
					end if
		
				next
			end if
		end if
		
		
		k_riga++ 
		
	loop  // fine creazione file pilota se richiesto		

	if k_byte < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_byte
		kst_esito.SQLErrText = "Errore durante scrittura su file Piano di Lavorazione FIGLI-DOSIMETRI x il Pilota: ~n~r"+ trim(k_path_file)
	end if


	if k_riga_write_dosimetro > 0 then
		k_return = true
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally

	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_barcode) then destroy kds_barcode


end try

return k_return

end function

public function boolean crea_file_pilota_figli_da_trattare (ds_pl_barcode kds_pl_barcode, string k_path, integer k_filenum) throws uo_exception;//
//---  Aggiunge ad archivio   Normalizzato per il Nuovo Pilota, Figli dei Barcode    (probabile PP_PILOTA___.TXT)
//---  Input: il datastore pieno di righe da generare
//---  Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//--- Lancia un EXCEPTION se si verificano errore gravik_return
//---
//--- ESEMPIO di file
//972D28892,037D28905,Nominativo cliente,58445 
//
//vediamo il tracciato:
//972D28892=codice barcode del padre
//037D28905=codice barcode del filgio
//nominativo...=nominativo del cliente
//58445= numero di riferimento
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
long k_riga, k_righe, k_riga_write=0, k_ctr
string k_sep=","
int k_byte, k_rcn
string k_rc,  k_file,  k_record = " ", k_path_pilota
boolean k_return=false
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_meca_dosim kst_tab_meca_dosim
kuf_barcode kuf1_barcode
kuf_meca_dosim kuf1_meca_dosim
kuf_utility kuf1_utility
datastore kds_barcode
pointer oldpointer  // Declares a pointer variable



	
try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()
	
	k_riga = 0
	
	kuf1_utility = create kuf_utility
	kuf1_meca_dosim = create kuf_meca_dosim  // eccezione di solito 
	kuf1_barcode = create kuf_barcode

	kds_barcode = create datastore
	kds_barcode.dataobject = "ds_barcode"
	kds_barcode.settransobject( sqlca)
	
	k_riga=1
	k_riga_write = 0

	k_righe = kds_pl_barcode.rowcount() 
	if k_righe > 0 then
		kst_tab_pl_barcode.codice = kds_pl_barcode.object.pl_barcode[1]
	end if

	k_byte = 1  //numero di byte scritti, inizialmente forzo a 1 se < 0 errore grave
	do while k_riga <= k_righe and k_byte > 0


//--- rilegge il barcode per avere le ultime, non si sa mai
		kst_tab_barcode.barcode = trim(kds_pl_barcode.object.barcode[k_riga])
		kds_barcode.reset( )
		if kds_barcode.retrieve(kst_tab_barcode.barcode) > 0 then
		
//			kst_tab_barcode.pl_barcode = kds_pl_barcode.object.pl_barcode[k_riga]
//			kst_tab_barcode.pl_barcode_progr = kds_pl_barcode.object.pl_barcode_progr[k_riga]
//			kst_tab_barcode.barcode = kds_pl_barcode.object.barcode[k_riga]
//			kst_tab_barcode.barcode_lav = kds_pl_barcode.object.barcode_lav[k_riga]
//			kst_tab_barcode.groupage = kds_pl_barcode.object.groupage[k_riga]
//			kst_tab_barcode.flg_dosimetro = kds_pl_barcode.object.flg_dosimetro[k_riga]
//			kst_tab_barcode.id_meca = kds_pl_barcode.object.id_meca[k_riga]
//			kst_tab_barcode.fila_1 = kds_pl_barcode.object.fila_1[k_riga]
//			kst_tab_barcode.fila_2 = kds_pl_barcode.object.fila_2[k_riga]
//			kst_tab_barcode.fila_1p = kds_pl_barcode.object.fila_1p[k_riga]
//			kst_tab_barcode.fila_2p = kds_pl_barcode.object.fila_2p[k_riga]
//			kst_tab_meca.num_int = kds_pl_barcode.object.num_int[k_riga]

			kst_tab_barcode.pl_barcode = kds_barcode.object.pl_barcode[1]
			kst_tab_barcode.pl_barcode_progr = kds_barcode.object.pl_barcode_progr[1]
			kst_tab_barcode.barcode_lav = kds_barcode.object.barcode_lav[1]
			kst_tab_barcode.groupage = kds_barcode.object.groupage[1]
			kst_tab_barcode.flg_dosimetro = kds_barcode.object.flg_dosimetro[1]
			kst_tab_barcode.id_meca = kds_barcode.object.id_meca[1]
			kst_tab_barcode.fila_1 = kds_barcode.object.fila_1[1]
			kst_tab_barcode.fila_2 = kds_barcode.object.fila_2[1]
			kst_tab_barcode.fila_1p = kds_barcode.object.fila_1p[1]
			kst_tab_barcode.fila_2p = kds_barcode.object.fila_2p[1]
			kst_tab_meca.num_int = kds_barcode.object.num_int[1]
			
//--- questi dati li piglia dal datastore entrato come arg			
			kst_tab_meca.clie_2 = kds_pl_barcode.object.clie_2[k_riga]
			kst_tab_meca.area_mag = kds_pl_barcode.object.area_mag[k_riga]
			kst_tab_clienti.rag_soc_10 = kds_pl_barcode.object.rag_soc_10[k_riga]
		
			if isnull(kst_tab_barcode.barcode_lav) then
				kst_tab_barcode.barcode_lav = ""
			end if
	
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0
			end if
			
			if isnull(kst_tab_barcode.barcode) then
				kst_tab_barcode.barcode = " "
			end if
			if isnull(kst_tab_barcode.pl_barcode) then
				kst_tab_barcode.pl_barcode = 0
			end if
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
	
	//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, k_sep, " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "'", " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "*", " ")
		
	
	//--- Se il BARCODE ha un PADRE (barcode_lav) allora vuole dire che e' un barcode FIGLIO quindi scrive
			if LenA(trim(kst_tab_barcode.barcode_lav)) > 0 then
	
				k_record = trim(kst_tab_barcode.barcode_lav) &
										  + k_sep+ trim(kst_tab_barcode.barcode) & 
										  + k_sep+trim(kst_tab_clienti.rag_soc_10) + " " &
 										  + k_sep+trim(string(kst_tab_meca.num_int,"#####0")) 
					
				k_byte = FileWrite(k_FileNum, k_record)
				if k_byte > 0 then
					k_riga_write ++
				end if
	
			end if
			
		end if
		
		k_riga++ 
		
	loop  // fine creazione file pilota se richiesto		


	if k_byte < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_byte
		kst_esito.SQLErrText = "Errore durante scrittura su file Piano di Lavorazione FIGLI x il Pilota: ~n~r"+ trim(k_path)
	end if

//--- Se Piano deriva da un P.L. allora aggiorna..
	if kst_tab_pl_barcode.codice > 0 then

		if kst_esito.esito = kkg_esito.ok then

////--- Aggiornamenti nella tabella P.L. 
//			kst_tab_pl_barcode.path_file_pilota = trim(k_path)
//			tb_update_campo(kst_tab_pl_barcode, "path_file_pilota")
			
		end if

//--- Controlla se il numero dei Barcode prodotti e' giusto
		k_ctr = conta_barcode_figli(kst_tab_pl_barcode)
		if k_riga_write <>  k_ctr then
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore: numero Barcode Figli 'inviati al Pilota' diverso da quelli presenti nel P.L. ~n~r" &
				+ "Figli scritti al Pilota: " + string(k_riga_write) &
				+ ",  invece  presenti nel P.L. " + string(kst_tab_pl_barcode.codice) + ": " + string(k_ctr) + "~n~r" &
				+ "Prego controllare nel file:~n~r" + trim(k_path)
				
		end if
		
	end if

	if k_riga_write > 0 then
		k_return = true
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally

	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_barcode) then destroy kds_barcode

//--- se errore grave allora exception
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.nome_oggetto = this.classname()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


end try

return k_return

end function

public function boolean if_esiste (readonly st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se il Piano esistente
//=== 
//=== Input: 
//=== 	struttura st_tab_pl_barcode con il Codice del PL_BARCODE impostato
//=== 
//=== 
//=== 
//=== Ritorna boolena : TRUE=esiste;  FALSE=non esiste
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

boolean k_return = false
string k_trovato="0"
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if kst_tab_pl_barcode.codice > 0 then

		select '1'
				into :k_trovato
				from pl_barcode 
				where pl_barcode.codice = :kst_tab_pl_barcode.codice
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante controllo presenza Piano Lav. Barcode n. " + string(kst_tab_pl_barcode.codice) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		else													  
			if sqlca.sqlcode = 100 then 
			else
				if k_trovato = "1" then
					k_return = true			// TROVATO!
				end if
			end if
		end if
	else
		kst_esito.sqlerrtext = "Codice P.L. non indicato, impossibile controllarne la presenza! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public function boolean riapre_pl_barcode (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Riapre il Piano Lavorazione Barcode ripristinando gli archivi
//=== 
//=== Ritorna st_esito : 0=OK; 100=not found; 2=errore grave; 
//===           		: 3=Altro errore 
//===   
//====================================================================
boolean k_return = false
st_esito kst_esito
st_tab_artr kst_tab_artr
st_tab_barcode kst_tab_barcode
st_txt_pilota_cmd kst_txt_pilota_cmd
st_tab_pilota_cmd kst_tab_pilota_cmd
kuf_artr kuf1_artr
kuf_barcode kuf1_barcode
kuf_pilota_cmd kuf1_pilota_cmd


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Rimuove il file delle richieste se riguarda questo invio prima che lo legga il PILOTA
	kuf1_pilota_cmd = create kuf_pilota_cmd
	kuf1_pilota_cmd.get_path_file_richieste()  // legge il path+file da rimuovere
	kst_tab_pilota_cmd.path = kuf1_pilota_cmd.kist_tab_pilota_cfg.path_pilota_out
	kst_tab_pilota_cmd.pfile = kuf1_pilota_cmd.kist_tab_pilota_cfg.file_richieste
	kst_txt_pilota_cmd = kuf1_pilota_cmd.leggi_file_richieste_padri( )  // legge il file command.txt
	if kst_txt_pilota_cmd.progressivo_richiesta > 0 then
		 kst_tab_pl_barcode.pilota_cmd_num_rich = get_pilota_cmd_num_rich(kst_tab_pl_barcode) // get del progressivo associato a questo PL
		if kst_txt_pilota_cmd.progressivo_richiesta = kst_tab_pl_barcode.pilota_cmd_num_rich then  // se è il progressivo che è sul file allora lo cancello
			kuf1_pilota_cmd.cancella_file_richieste(kst_tab_pilota_cmd)  // cancella il file command.txt
		end if
	end if

	kst_tab_pl_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_pl_barcode.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_pl_barcode.stato = ki_stato_aperto

	update 	pl_barcode set 	 
				data_chiuso = convert(date,'01.01.1899'),
				stato = :kst_tab_pl_barcode.stato,
				x_datins = :kst_tab_pl_barcode.x_datins,
				x_utente = :kst_tab_pl_barcode.x_utente
			where codice = :kst_tab_pl_barcode.codice
			using sqlca;
					
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante Riapertura Piano di Lavorazione: " + trim(SQLCA.SQLErrText)
	end if
		
	if kst_esito.esito <> kkg_esito.db_ko then
				
//--- tolgo da archivio TRATTATI cio' che era con il pl barcode 			
		kst_tab_artr.pl_barcode = kst_tab_pl_barcode.codice
		kuf1_artr = create kuf_artr
		kst_esito = kuf1_artr.cancella_pl_barcode (kst_tab_artr)
		if kst_esito.esito <> kkg_esito.db_ko then kst_esito.esito = kkg_esito.ok 
		destroy kuf1_artr
				
//--- pulizia delle date nei BARCODE con PL BARCODE
		if kst_esito.esito <> kkg_esito.db_ko then
			kst_tab_barcode.pl_barcode = kst_tab_pl_barcode.codice
			kuf1_barcode = create kuf_barcode
			kst_esito = kuf1_barcode.togli_pl_barcode_chiuso (kst_tab_barcode)
			if kst_esito.esito <> kkg_esito.db_ko then kst_esito.esito = kkg_esito.ok 
			destroy kuf1_barcode
		end if
					
//--- commit del lavoro					
		if kst_esito.esito <> kkg_esito.db_ko then
			if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S" then
				kguo_sqlca_db_magazzino.db_commit()
			end if
		else
			if kst_tab_pl_barcode.st_tab_g_0.esegui_commit = "S" then
				kguo_sqlca_db_magazzino.db_rollback( ) 
			end if
		end if
	end if
	
//--- se errore grave lancia EXCEPTION	
	if kst_esito.esito = kkg_esito.db_ko then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		if kst_esito.esito = kkg_esito.ok then
			k_return = true
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd

end try

return k_return

end function

public function boolean if_pl_trasferito_al_pilota (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se il Piano è già stato trasferito al pilota (sul PILOTA ho solo l'ultimo mese)
//=== 
//=== Input: 
//=== 	struttura st_tab_pl_barcode con il Codice del PL_BARCODE impostato
//=== 
//=== 
//=== 
//=== Ritorna boolena : TRUE=trasferito;  FALSE=non trasferito  
//===    
//===  solleva un eccezione in caso di grave errore sql
//====================================================================

boolean k_return = false
boolean k_open=false
long k_ctr
st_esito kst_esito 
st_tab_pilota_queue kst_tab_pilota_queue
st_tab_barcode kst_tab_barcode
kuf_pilota_cmd kuf1_pilota_cmd	


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_pilota_cmd = create kuf_pilota_cmd

	if kst_tab_pl_barcode.codice > 0 then
	
		declare c_if_pl_trasferito_al_pilota cursor for  
			select barcode
				from barcode 
				where barcode.pl_barcode = :kst_tab_pl_barcode.codice
				using kguo_sqlca_db_magazzino;
	
		open c_if_pl_trasferito_al_pilota;
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_open = true	
			
			fetch c_if_pl_trasferito_al_pilota
											into :kst_tab_barcode.barcode;
			do while kguo_sqlca_db_magazzino.sqlcode = 0 and not k_return
				
//--- il BARCODE è già nel PILOTA?
				kst_tab_pilota_queue.barcode = kst_tab_barcode.barcode
			 	if kuf1_pilota_cmd.get_pilota_pilota_barcode(kst_tab_pilota_queue) then k_return = true

				fetch c_if_pl_trasferito_al_pilota
											into :kst_tab_barcode.barcode;
			loop
	
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.sqlerrtext = "Errore durante lettura BARCODE ne Piano Lav. n. " + string(kst_tab_pl_barcode.codice) &
								+ " non trovato (Errore=" &
							  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if

		end if
	else
		kst_esito.sqlerrtext = "Codice P.L. non indicato, impossibile valutare se Trasferito al PILOTA! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally	
	if k_open then 
		close c_if_pl_trasferito_al_pilota;
	end if
	if isvalid(kuf1_pilota_cmd) then destroy kuf1_pilota_cmd
	
end try

return k_return

end function

public subroutine get_path_file_pilota (ref st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Torna il nome completo del path + file del pilota
//--- Input: st_tab_pl_barcode.codice
//--- Output: st_tab_pl_barcodepath_file_pilota ovvero path+file
//--- Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
        path_file_pilota 
    INTO 
         :kst_tab_pl_barcode.path_file_pilota
    FROM pl_barcode  
	 where codice = :kst_tab_pl_barcode.codice
	 using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + &
					"Cerca nome File sul Piano di Lavoro, codice: " + string(kst_tab_pl_barcode.codice) &
					+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext ) 
//--- LANCIA UN ECCEZIONE
			SetPointer(oldpointer)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
					
		else
			kst_tab_pl_barcode.path_file_pilota = ""
		end if

		if isnull(kst_tab_pl_barcode.path_file_pilota) then kst_tab_pl_barcode.path_file_pilota = ""


	end if
	
SetPointer(oldpointer)



end subroutine

public function boolean cancella_file_pilota (st_tab_pl_barcode ast_tab_pl_barcode) throws uo_exception;//---
//---   Cancella il file del Pilota 
//---   Input: st_tab_pl_barcode.path_file_pilota
//---
boolean k_return = false
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable


//--- Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if  FileExists ( trim(ast_tab_pl_barcode.path_file_pilota)) then

//--- cancello il file
	if not FileDelete (  trim(ast_tab_pl_barcode.path_file_pilota) ) then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Cancellazione del file 'Pilota' Fallita:~n~r " + trim(ast_tab_pl_barcode.path_file_pilota)
		SetPointer(oldpointer)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	k_return = true
end if

SetPointer(oldpointer)
			

return k_return

end function

public function boolean set_pilota_cmd_num_rich (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- Imposta lo stato del Piano di Lavorazione a quello passato nei parametri
//--- 
//--- Input: 
//---	tipo di stato: st_tab_pl_barcode.pilota_cmd_num_rich e codice
//--- 
//--- Ritorna boolena : TRUE=stato aggiornato;  FALSE=stato non aggiornato  
//---    
//---  solleva un eccezione in caso di grave errore sql
//---------------------------------------------------------------------------------

boolean k_return = false
long k_ctr
st_esito kst_esito
pointer oldpointer

//--- Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_tab_pl_barcode.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_pl_barcode.x_utente = kGuf_data_base.prendi_x_utente()

	update pl_barcode set 	 
				 pilota_cmd_num_rich = :kst_tab_pl_barcode.pilota_cmd_num_rich
				 ,x_datins = :kst_tab_pl_barcode.x_datins
				 ,x_utente = :kst_tab_pl_barcode.x_utente
			where codice = :kst_tab_pl_barcode.codice
			using kguo_sqlca_db_magazzino ;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if isnull(kst_tab_pl_barcode.st_tab_g_0.esegui_commit) or kst_tab_pl_barcode.st_tab_g_0.esegui_commit <> "N" then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Aggiornamento Numero-Richiesta-Pilota in Tab.Piani di Lavorazione  (PL_BARCODE):  ~n~r" &
									 + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if isnull(kst_tab_pl_barcode.st_tab_g_0.esegui_commit) or kst_tab_pl_barcode.st_tab_g_0.esegui_commit <> "N" then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if


return k_return

end function

public function ds_pl_barcode get_ds_barcode_padri (readonly ds_pl_barcode kds_pl_barcode_input) throws uo_exception;//
//=== Torna DS_PL_BARCODE valorizzato con solo PADRI
//---  Input: DS_PL_BARCODE con un elenco barcode  
//--- Output: Datastore ds_pl_barcode padri
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
ds_pl_barcode kds_pl_barcode
long k_riga, k_riga_barcode, k_riga_insert
st_tab_barcode kst_tab_barcode, kst_tab_barcode_padre
st_esito kst_esito
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
datastore kds_barcode
pointer oldpointer  // Declares a pointer variable


oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname()

kds_pl_barcode = create ds_pl_barcode	
kds_pl_barcode.settransobject(sqlca)
	
k_riga = kds_pl_barcode_input.rowcount()
	
if k_riga < 0 then	
	kst_esito.esito = kkg_esito.blok
	kst_esito.sqlcode = k_riga
	kst_esito.SQLErrText = "Lettura fallita in tabella 'Pianificazione Lav. (pl_barcode)'. ~n~rCodice: "+string(k_riga)
	kguo_exception.inizializza()
	kguo_exception.set_esito (kst_esito)
	throw kguo_exception
end if

kuf1_barcode = create kuf_barcode
kuf1_armo = create kuf_armo
kuf1_clienti = create kuf_clienti

k_riga_insert = 0

for k_riga = 1 to kds_pl_barcode_input.rowcount() 

	kst_tab_barcode.barcode = kds_pl_barcode_input.object.barcode[k_riga]
	kst_tab_barcode.barcode_lav = kuf1_barcode.get_barcode_lav(kst_tab_barcode)
	
//--- se è un FIGLIO lo scarto	
	if kst_tab_barcode.barcode_lav > " " then
	else
	
		kst_tab_barcode_padre.barcode = kst_tab_barcode.barcode
		kst_esito = kuf1_barcode.select_barcode(kst_tab_barcode_padre)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if

		kst_tab_meca.id = kst_tab_barcode_padre.id_meca
		kst_esito = kuf1_armo.leggi_testa( "P", kst_tab_meca) 
		if kst_esito.esito <> kkg_esito.ok then
			kst_tab_meca.area_mag = "????"
			kst_tab_meca.clie_2=0
		else
			kst_tab_clienti.codice = kst_tab_meca.clie_2
			kst_esito = kuf1_clienti.leggi_rag_soc(kst_tab_clienti)
			if kst_esito.esito <> kkg_esito.ok then
				kst_tab_clienti.rag_soc_10 = "??"+trim(kst_esito.sqlerrtext)+"??"
			end if
		end if		
		
		k_riga_insert++
		kds_pl_barcode.insertrow( k_riga_insert )
		
		kds_pl_barcode.object.pl_barcode_progr[k_riga_insert] = k_riga_insert
		kds_pl_barcode.object.pl_barcode[k_riga_insert] = 0
		kds_pl_barcode.object.barcode[k_riga_insert] = kst_tab_barcode_padre.barcode
		kds_pl_barcode.object.barcode_lav[k_riga_insert] = kst_tab_barcode_padre.barcode_lav
		kds_pl_barcode.object.groupage[k_riga_insert] = kst_tab_barcode_padre.groupage
		kds_pl_barcode.object.fila_1[k_riga_insert] = kst_tab_barcode_padre.fila_1
		kds_pl_barcode.object.fila_2[k_riga_insert] = kst_tab_barcode_padre.fila_2
		kds_pl_barcode.object.fila_1p[k_riga_insert] = kst_tab_barcode_padre.fila_1p
		kds_pl_barcode.object.fila_2p[k_riga_insert] = kst_tab_barcode_padre.fila_2p
		kds_pl_barcode.object.num_int[k_riga_insert] = kst_tab_barcode_padre.num_int
		kds_pl_barcode.object.clie_2[k_riga_insert] = kst_tab_meca.clie_2
		kds_pl_barcode.object.area_mag[k_riga_insert] = trim(kst_tab_meca.area_mag)
		kds_pl_barcode.object.rag_soc_10[k_riga_insert] = trim(kst_tab_clienti.rag_soc_10)
		
	end if

end for

destroy kuf1_barcode



//=== riprisino Puntatore
SetPointer(oldpointer)

return kds_pl_barcode

end function

public function boolean if_pianificazione_figli_ok (ds_pl_barcode_dett kds_pl_barcode_dett_padri, ds_pl_barcode_dett kds_pl_barcode_dett_figli, string a_operazione) throws uo_exception;//---
//--- Controlla la Programmazione FIGLI da inviare al Pilota se corretta
//---
//--- Input: il ds 'ds_pl_barcode_dett' PADRI contenente le righe dei barcode programmati PADRI
//--- 		 il ds 'ds_pl_barcode_dett' FIGLI contenente le righe dei barcode programmati da controllare
//---        a_operazione = "modifica" o "inserimento"  x operazione di inserimento della Programmazione o MODIFICA della Programmazione già inviata
//--- Output: 
//--- Ritorna: TRUE = OK
//---
//--- lancia EXCEPTION
//---
boolean k_return = false
boolean k_errore=false
long k_riga, k_pl_barcode_progr, k_riga_find, k_riga_find_1, k_righe
int k_nr_errori
st_tab_barcode kst_tab_barcode, kst_tab_barcode_figlio, kst_tab_barcode_padre
st_esito kst_esito
kuf_barcode kuf1_barcode


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_barcode = create kuf_barcode


	k_nr_errori=0
	k_righe = kds_pl_barcode_dett_figli.rowcount()
	for k_riga = 1 to k_righe

		
//--- non devono avere il flag 'DA NON TRATTARE' o essere già trattati
		kst_tab_barcode.barcode = string(kds_pl_barcode_dett_figli.getitemstring ( k_riga, "barcode"))
      if a_operazione = "modifica" then 
			if kuf1_barcode.if_da_trattare_no_pl_barcode(kst_tab_barcode) then
			else
				kst_esito.SQLErrText +=  & 
									  + "Figlio " + trim(string(trim(kst_tab_barcode.barcode), "@@@@@@@@@@@")) &
									  + "Non più 'Trattabile' (impostato come 'da non trattare' oppure già trattato) " + ";~n~r" 
				k_errore = true
				k_nr_errori++
			end if
		else
			if kuf1_barcode.if_da_trattare(kst_tab_barcode) then
			else
				kst_esito.SQLErrText +=  & 
									  + "Figlio " + trim(string(trim(kst_tab_barcode.barcode), "@@@@@@@@@@@")) &
									  + "Non 'Trattabile' (impostato come 'da non trattare' o gia' trattato o già Pianificato) " + ";~n~r" 
				k_errore = true
				k_nr_errori++
			end if
		end if

//--- Controllo codici doppi
		if k_riga < kds_pl_barcode_dett_figli.rowcount() then
			kst_tab_barcode.barcode = string(kds_pl_barcode_dett_figli.getitemstring ( k_riga, "barcode"))
			k_riga_find = kds_pl_barcode_dett_figli.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", k_riga + 1, kds_pl_barcode_dett_figli.rowcount()) 
			if k_riga_find > 0  then
				kst_esito.SQLErrText += & 
							  + "Stesso 'Figlio' presente su più righe, "  &
							  + "(Codice " + trim(kst_tab_barcode.barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
				k_errore = true
				k_nr_errori++
			end if
		end if
			
//--- Tolgo valori a null dai giri
		if isnull(kds_pl_barcode_dett_figli.getitemnumber(k_riga, "fila_1")) then	kds_pl_barcode_dett_figli.setitem(k_riga, "fila_1", 0)
		if isnull(kds_pl_barcode_dett_figli.getitemnumber(k_riga, "fila_1p")) then kds_pl_barcode_dett_figli.setitem(k_riga, "fila_1p", 0)
		if isnull(kds_pl_barcode_dett_figli.getitemnumber(k_riga, "fila_2")) then	kds_pl_barcode_dett_figli.setitem(k_riga, "fila_2", 0)
		if isnull(kds_pl_barcode_dett_figli.getitemnumber(k_riga, "fila_2p")) then kds_pl_barcode_dett_figli.setitem(k_riga, "fila_2p", 0)
	
//--- controllo se il barcode padre puo' essere associato a questo Figlio
		kst_tab_barcode_figlio.barcode = kds_pl_barcode_dett_figli.object.barcode[k_riga]
		kst_tab_barcode_padre.barcode = kds_pl_barcode_dett_figli.object.barcode_lav[k_riga]  // barcode di lavorazione (padre)
		
		if len(trim(kst_tab_barcode_padre.barcode)) > 0 then
		else
			kst_esito.SQLErrText +=  & 
								  + "Figlio " + trim(string(trim(kst_tab_barcode_figlio.barcode), "@@@@@@@@@@@")) &
								  + " manca il Barcode Padre " + ";~n~r" 
			k_errore = true
			k_nr_errori++
		end if
			
		if not k_errore then
//--- Cerca il BARCODE PADRE in Lista
			k_riga_find_1 = kds_pl_barcode_dett_padri.find("barcode = '" + trim(kst_tab_barcode_padre.barcode) + "' ", 1, kds_pl_barcode_dett_padri.rowcount()) 
			if k_riga_find_1 > 0  then
				if isnull(kds_pl_barcode_dett_padri.getitemnumber(k_riga_find_1, "fila_1")) then	kds_pl_barcode_dett_padri.setitem(k_riga_find_1, "fila_1", 0)
				if isnull(kds_pl_barcode_dett_padri.getitemnumber(k_riga_find_1, "fila_1p")) then kds_pl_barcode_dett_padri.setitem(k_riga_find_1, "fila_1p", 0)
				if isnull(kds_pl_barcode_dett_padri.getitemnumber(k_riga_find_1, "fila_2")) then	kds_pl_barcode_dett_padri.setitem(k_riga_find_1, "fila_2", 0)
				if isnull(kds_pl_barcode_dett_padri.getitemnumber(k_riga_find_1, "fila_2p")) then kds_pl_barcode_dett_padri.setitem(k_riga_find_1, "fila_2p", 0)

				if kds_pl_barcode_dett_figli.object.fila_1[k_riga] <> kds_pl_barcode_dett_padri.object.fila_1[k_riga_find_1] &
						or kds_pl_barcode_dett_figli.object.fila_1p[k_riga] <> kds_pl_barcode_dett_padri.object.fila_1p[k_riga_find_1] &
						or kds_pl_barcode_dett_figli.object.fila_2[k_riga] <> kds_pl_barcode_dett_padri.object.fila_2[k_riga_find_1] &
						or kds_pl_barcode_dett_figli.object.fila_2p[k_riga] <> kds_pl_barcode_dett_padri.object.fila_2p[k_riga_find_1] &
						then
					kst_esito.SQLErrText += & 
										  + "Barcode 'Padre' " + trim(kst_tab_barcode_padre.barcode) &
										  + ", ha 'giri' diversi dal 'Figlio' " + trim(kst_tab_barcode_figlio.barcode) + ";~n~r" 
					k_errore = true
					k_nr_errori++
				end if
			else
				kst_esito.SQLErrText +=  & 
									  + "Inserire il Barcode 'Padre' " + trim(kst_tab_barcode_padre.barcode) &
									  + ", oppure togliere il 'Figlio' " + trim(kst_tab_barcode_figlio.barcode) + ";~n~r" 
				k_errore = true
				k_nr_errori++
			end if 
					
	//--- Puo' essere figlo?
			kst_tab_barcode_figlio.fila_1 = kds_pl_barcode_dett_figli.object.fila_1[k_riga]
			kst_tab_barcode_figlio.fila_1p = kds_pl_barcode_dett_figli.object.fila_1p[k_riga]
			kst_tab_barcode_figlio.fila_2 = kds_pl_barcode_dett_figli.object.fila_2[k_riga]
			kst_tab_barcode_figlio.fila_2p = kds_pl_barcode_dett_figli.object.fila_2p[k_riga]
						
			if not kuf1_barcode.if_essere_barcode_figlio(kst_tab_barcode_figlio, kst_tab_barcode_padre) then
				k_errore = true
				kst_esito.SQLErrText += "Il barcode " + trim(kst_tab_barcode_figlio.barcode) + " non può assumere il ruolo di Figlio " + "~n~r" 
			end if
						
		end if				
		
		if k_nr_errori > 5 then k_riga = kds_pl_barcode_dett_figli.rowcount()

	next
	
//--- se c'e' stato un errore allora EXCEPTION	
	if k_errore then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else

		k_return = true
	end if

	k_return = true

catch (uo_exception kuo_exception)
	throw kuo_exception

finally 	
	if isvalid(kuf1_barcode) then destroy kuf1_barcode

end try

return k_return

end function

private subroutine u_set_tab_barcode (readonly st_tab_pilota_pallet kst_tab_pilota_pallet, ref st_tab_barcode kst_tab_barcode);//
//--- copia i campi dalla struttura pilota_pallet a barcode
//--- inp: st_tab_pilota_pallet
//--- Out: st_tab_barcode
//

		kst_tab_barcode.data_lav_ini = date(kst_tab_pilota_pallet.Data_Entrata)
		kst_tab_barcode.ora_lav_ini = time(kst_tab_pilota_pallet.Data_Entrata)
		
		if date(kst_tab_pilota_pallet.Data_Uscita) > kkg.data_zero then
			kst_tab_barcode.data_lav_fin = date(kst_tab_pilota_pallet.Data_Uscita)
			kst_tab_barcode.ora_lav_fin = time(kst_tab_pilota_pallet.Data_Uscita)
		end if		
		
		if isnumber(kst_tab_pilota_pallet.F1AVP) then
			kst_tab_barcode.lav_fila_1 = integer(kst_tab_pilota_pallet.F1AVP)
		else
			kst_tab_barcode.lav_fila_1 = 0
		end if
		if isnumber(kst_tab_pilota_pallet.F2AVP) then
			kst_tab_barcode.lav_fila_2 = integer(kst_tab_pilota_pallet.F2AVP)
		else
			kst_tab_barcode.lav_fila_2 = 0
		end if
		if isnumber(kst_tab_pilota_pallet.F1ApP) then
			kst_tab_barcode.lav_fila_1p = integer(kst_tab_pilota_pallet.F1ApP)
		else
			kst_tab_barcode.lav_fila_1p = 0
		end if
		if isnumber(kst_tab_pilota_pallet.F2ApP) then
			kst_tab_barcode.lav_fila_2p = integer(kst_tab_pilota_pallet.F2ApP)
		else
			kst_tab_barcode.lav_fila_2p = 0
		end if
		kst_tab_barcode.posizione = kst_tab_pilota_pallet.Posizione
		kst_tab_barcode.Bilancella = kst_tab_pilota_pallet.Bilancella



end subroutine

public function boolean if_pianificazione_ok (ds_pl_barcode_dett kds_pl_barcode_dett, string a_operazione) throws uo_exception;//---
//--- Controlla la Programmazione da inviare al Pilota se corretta
//---
//--- Input: il ds 'ds_pl_barcode_dett' contenente le righe dei barcode programmati da controllare
//---           a_operazione: "modifica" = MODIFICA della Programmazione già inviata
//---                         "inserimento" = inserimento nuova Programmazione 
//--- Output: 
//--- Ritorna: TRUE = OK
//---
//--- lancia EXCEPTION
//---
boolean k_return = false
long k_riga, k_pl_barcode_progr, k_riga_find, k_righe
int k_nr_errori
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_sl_pt kuf1_sl_pt
kuf_barcode kuf1_barcode


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_barcode = create kuf_barcode

	k_nr_errori=0
	k_righe = kds_pl_barcode_dett.rowcount()
	for k_riga = 1 to k_righe

		k_pl_barcode_progr = kds_pl_barcode_dett.getitemnumber ( k_riga, "pl_barcode_progr")

		
//--- non devono avere il flag 'DA NON TRATTARE' o essere già trattati
		kst_tab_barcode.barcode = string(kds_pl_barcode_dett.getitemstring ( k_riga, "barcode"))
      if a_operazione = "modifica" then 
			if kuf1_barcode.if_da_trattare_no_pl_barcode(kst_tab_barcode) then
			else
				kst_esito.esito = kkg_esito.err_logico 			 
				kst_esito.SQLErrText +=  & 
				"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + "barcode " + trim(kst_tab_barcode.barcode) + " è da non 'Trattare'; " + "~n~r"
				k_nr_errori++
			end if
		else
			if kuf1_barcode.if_da_trattare(kst_tab_barcode) then
			else
				kst_esito.esito = kkg_esito.err_logico 			 
				kst_esito.SQLErrText +=  & 
				"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + "barcode " + trim(kst_tab_barcode.barcode) + " è da non 'Trattare'; " + "~n~r"
				k_nr_errori++
			end if
		end if

//--- controllo se è stato caricato come figlio mentre si faceva la pianificazione 
		if kuf1_barcode.if_barcode_figlio(kst_tab_barcode) then
			kst_esito.esito = kkg_esito.err_logico 			 
			kst_esito.SQLErrText +=  & 
			"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + "barcode " + trim(kst_tab_barcode.barcode) + " è stato impostato anche come figlio di ; " &
			                                            + trim(kst_tab_barcode.barcode_lav) + "~n~r"
			k_nr_errori++
		end if

//--- Controllo codici doppi
		kst_tab_barcode.barcode = string(kds_pl_barcode_dett.getitemstring ( k_riga, "barcode"))
		if k_riga < k_righe then
			k_riga_find = kds_pl_barcode_dett.find("barcode = '" + trim(kst_tab_barcode.barcode) + "' ", k_riga + 1, k_righe) 
			if k_riga_find > 0  then
				kst_esito.esito = kkg_esito.err_formale 			 
				kst_esito.SQLErrText +=  & 
							  + "Stesso Barcode presente su più righe, " + "~n~r" &
							  + "(Codice " + trim(kst_tab_barcode.barcode) + ") vedi alla riga " + string(k_riga_find) + "; ~n~r"
				k_nr_errori++
			end if
		end if
		
//--- almeno fila 1 o fila 2 > 0
		if (kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1") = 0 &
				 and kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1p") = 0) &
				and (kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2") = 0 &
				 and kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2p") = 0) &
				 then
			kst_esito.esito = kkg_esito.err_formale 			 
			kst_esito.SQLErrText +=  & 
			"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + "valorizzare il numero di giri; " + "~n~r"
			k_nr_errori++
		end if
	
//--- Controllo se File doppie per tipo cicli = 1 (scelta tra fila 1 e fila 2)
		if (kds_pl_barcode_dett.getitemstring ( k_riga, "tipo_cicli") = kuf1_sl_pt.ki_tipo_cicli_singolo &
				 or isnull(kds_pl_barcode_dett.getitemstring ( k_riga, "tipo_cicli"))) &
				and (kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1") > 0 &
				 or kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1p")  > 0) &
				and  ( kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2") > 0 &
				 or  kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2p") > 0) &
				then
			kst_esito.esito = kkg_esito.err_formale 			 
			kst_esito.SQLErrText +=  & 
			"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + " per questa modalita' non e' consentito valorizzare Fila 1 e Fila 2; " + "~n~r"
			k_nr_errori++
		end if
			
//--- i pallettes viaggiano in coppia dentro ad un unico "ascensore" perciò devono avere gli stessi giri 	
		if mod(k_riga, 2) = 0 then 
			if (kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1") <>  &
					 kds_pl_barcode_dett.getitemnumber ( k_riga - 1, "fila_1") &
					) or &
					(kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_1p") <>  &
					 kds_pl_barcode_dett.getitemnumber ( k_riga - 1, "fila_1p") &
					) or &
					(kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2") <>  &
					 kds_pl_barcode_dett.getitemnumber ( k_riga - 1, "fila_2") &
					) or  & 
					(kds_pl_barcode_dett.getitemnumber ( k_riga, "fila_2p") <>  &
					 kds_pl_barcode_dett.getitemnumber ( k_riga - 1, "fila_2p") &
					) &
					then
				kst_esito.esito = kkg_esito.err_formale 			 
				kst_esito.SQLErrText +=  & 
				"Riga n. " + string(k_pl_barcode_progr, "####0") + ": " + "coppia di giri errata; " + "~n~r"
				k_nr_errori++
			end if
		end if

		if k_nr_errori > 5 then k_riga = kds_pl_barcode_dett.rowcount()
			
	end for

	if kst_esito.esito = kkg_esito.ok then

//--- il nr totale delle righe non può essere dispari
		if mod(kds_pl_barcode_dett.rowcount(), 2) <> 0 then 
			kst_esito.esito = kkg_esito.err_formale 			 
			kst_esito.SQLErrText +=	"Pianificazione ZOPPA! - Aggiungere/Togliere Barcode; " + "~n~r"
		end if
	end if

//--- se qlc errore scateno EXCEPTION
	if kst_esito.esito <> kkg_esito.ok then
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_return = true
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	
end try

return k_return

end function

public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_lav (readonly st_tab_meca kst_tab_meca) throws uo_exception;//
//--- imposta alcuni dati circa i barcode Trattati da passare a E1
//--- Inp: st_tab_meca.id
//--- Out: st_tab_e1_wo_f5548014 ciclo_os55gs25c, ngiri_ossetl, tcicli_osmmcu

long k_durata_lav_secondi
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	try  

		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo

////--- set durata del trattamento							
		kst_tab_barcode.id_meca = kst_tab_meca.id
//		k_durata_lav_secondi = kuf1_barcode.get_durata_lav(kst_tab_barcode)
//		kst_tab_e1_wo_f5548014.ciclo_os55gs25c = string(k_durata_lav_secondi) //kst_tab_certif[1].dose, "#0.00")
//--- set num giri del trattamento							
		kuf1_barcode.get_lav_fila_tot_x_id_meca(kst_tab_barcode)  // 23-08-2017 calcolo dei giri totali dei barcode per lotto
		kst_tab_e1_wo_f5548014.ngiri_ossetl = kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p + kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p
//--- set fila del trattamento							
		kst_tab_e1_wo_f5548014.tcicli_osmmcu = " " 
		if (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p) > 0 and (kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p) > 0 then
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_MISTO  // CICLI MISTI
		else
			if (kst_tab_barcode.lav_fila_1 + kst_tab_barcode.lav_fila_1p) > 0 then
				kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_fila1  // FILA 1
			else
				if (kst_tab_barcode.lav_fila_2 + kst_tab_barcode.lav_fila_2p) > 0 then
					kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_fila2  // FILA 2
				end if
			end if
		end if

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.sqlerrtext = "Errore durante estrazione dati Trattamento per E1 ~n~r" + trim(kst_esito.sqlerrtext)
		throw kuo_exception
		
	finally
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_barcode) then destroy kuf1_barcode

end try

return kst_tab_e1_wo_f5548014
end function

public function st_tab_e1_wo_f5548014 u_get_e1_ws_f5548014_pianif (readonly st_tab_meca kst_tab_meca) throws uo_exception;//
//--- imposta alcuni dati circa la pianificazione dei barcode da passare a E1
//--- Inp: st_tab_meca.id
//--- Out: st_tab_e1_wo_f5548014 ciclo_os55gs25c, ngiri_ossetl, tcicli_osmmcu

long k_durata_lav_secondi
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_barcode kst_tab_barcode
st_esito kst_esito
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	try  

		kuf1_barcode = create kuf_barcode
		kuf1_armo = create kuf_armo

//--- set num giri del trattamento							
		kst_tab_barcode.id_meca = kst_tab_meca.id
		kuf1_barcode.get_fila_tot_x_id_meca(kst_tab_barcode)  // calcolo dei giri totali pianificati dei barcode per lotto
		kst_tab_e1_wo_f5548014.ngiri_ossetl = kst_tab_barcode.fila_1 + kst_tab_barcode.fila_1p + kst_tab_barcode.fila_2 + kst_tab_barcode.fila_2p
//--- set fila del trattamento							
		kst_tab_e1_wo_f5548014.tcicli_osmmcu = " " 
		if (kst_tab_barcode.fila_1 + kst_tab_barcode.fila_1p) > 0 and (kst_tab_barcode.fila_2 + kst_tab_barcode.fila_2p) > 0 then
			kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_MISTO  // CICLI MISTI
		else
			if (kst_tab_barcode.fila_1 + kst_tab_barcode.fila_1p) > 0 then
				kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_fila1  // FILA 1
			else
				if (kst_tab_barcode.fila_2 + kst_tab_barcode.fila_2p) > 0 then
					kst_tab_e1_wo_f5548014.tcicli_osmmcu = kuf1_e1_wo_f5548014.kki_tcicli_osmmcu_fila2  // FILA 2
				end if
			end if
		end if

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito( )
		kst_esito.sqlerrtext = "Errore durante estrazione dati pianificati di Trattamento per E1 ~n~r" + trim(kst_esito.sqlerrtext)
		throw kuo_exception
		
	finally
		if isvalid(kuf1_armo) then destroy kuf1_armo
		if isvalid(kuf1_barcode) then destroy kuf1_barcode

end try

return kst_tab_e1_wo_f5548014
end function

public function long get_pilota_cmd_num_rich (st_tab_pl_barcode kst_tab_pl_barcode) throws uo_exception;//---
//---   Torna il progressivo della richiesta associata a questo PL in fase di invio
//--- Input: st_tab_pl_barcode.codice
//--- Output: st_tab_pl_barcode.pilota_cmd_num_rich
//--- Lancia un exception se si verifica un grave errore
//---
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable

//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


  SELECT 
        pilota_cmd_num_rich 
    INTO 
         :kst_tab_pl_barcode.pilota_cmd_num_rich
    FROM pl_barcode
	 where codice = :kst_tab_pl_barcode.codice
	 using kguo_sqlca_db_magazzino ;

	
	if kguo_sqlca_db_magazzino.sqlcode = 0 then

	else
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			
			kst_esito.esito = kkg_esito.DB_KO
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = trim(sqlca.sqlerrtext) + "~n~r" + &
					"Errore in lettura Progressivo di Invio in tabella Piano di Lavoro, codice: " + string(kst_tab_pl_barcode.codice) &
					+ "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.sqlerrtext ) 
//--- LANCIA UN ECCEZIONE
			SetPointer(oldpointer)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
					
		else
			kst_tab_pl_barcode.pilota_cmd_num_rich = 0
		end if

		if isnull(kst_tab_pl_barcode.pilota_cmd_num_rich) then kst_tab_pl_barcode.pilota_cmd_num_rich = 0


	end if
	
SetPointer(oldpointer)

return kst_tab_pl_barcode.pilota_cmd_num_rich


end function

public function boolean crea_file_pilota_padri (ds_pl_barcode kds_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception;//
//=== Crea archivio Normalizzato per il Nuovo Pilota (probabile PP_PILOTA___.TXT)
//---  Input: il datasore st_tab_pl_barcode da generare
//--- Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//--- ESEMPIO di file
//972D28892HMM000100010000NN,0000007928,972,Nominativo cliente,58445,AM DX   
//972D28902BMM000100010000NN,0000007928,972,Nominativo cliente,58445,AM DX
//037D31002HMM110011000000NN,0000007928,37,Nominativo cliente,58448,V2 DX
//151D31752BMM110011000000NN,0000007928,151,Nominativo cliente,58450,BL SX
//151D31753HMM113311330000NN,0000007928,151,Nominativo cliente,58450,BL SX
//151D31754HMM113311330000NN,0000007928,151,Nominativo cliente,58450,BL SX
//dove ad esempio nel primo record troviamo:
//972=cod CLIE solo i primi 3 caratteri;
//D2889=PROGR univoco barcode;
//2HMM/2BMM=FISSI ALTERN. con H=alto, B=basso, M=medio;
//0001=F1+F2; 
//0001=F1+F2 permutate;
//0000=F1+F2 ;
//NN=FISSI
//0000007928=numero del PL (piano di lavorazione)
//972,nominativo...=sono il codice e il nominativo del cliente
//58445/2017= numero eanno del Riferimento
//AM DX=area di stoccaggio  
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
long k_riga, k_righe, k_riga_write, k_ctr
constant string k_cost_alto = "2HMM", k_cost_basso = "2BMM", k_cost_fine = "NN"
string k_giri, k_giri_p, k_giri_n, k_alto_basso, k_sep=","
int k_filenum=0, k_byte, k_rcn
string k_rc,  k_record = " ", k_file_temp, k_file_pilota
boolean k_return=false
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_pl_barcode kst_tab_pl_barcode
kuf_barcode kuf1_barcode
kuf_utility kuf1_utility
pointer oldpointer  // Declares a pointer variable


oldpointer = SetPointer(HourGlass!)

kuf1_utility = create kuf_utility

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname()
	
	
try
	k_riga = 0
	
	k_file_temp = k_path_temp + k_file_nome 
	k_file_pilota = k_path_pilota + k_file_nome 


//--- Genera file pilota
	k_FileNum = FileOpen(k_file_temp, LineMode!, Write!, LockWrite!, Replace!)
	if k_FileNum < 0 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Apertura fallita Archivio 'File Pian.Lav. x il Pilota': ~n~r"+k_file_temp
		kst_esito.nome_oggetto = this.classname()
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

//	declare c1_crea_file_pl_barocode_x_pilota cursor for
//		select pl_barcode_progr
//		         ,barcode
//		         ,groupage
//		         ,fila_1
//				,fila_2
//				,fila_1p
//				,fila_2p
//				,meca.num_int
//				,meca.clie_2
//				,meca.area_mag
//				,clienti.rag_soc_10
//				from barcode inner join meca on
//				    barcode.id_meca = meca.id
//					 inner join clienti on
//					meca.clie_2 = clienti.codice 
//				where pl_barcode = :kst_tab_pl_barcode.codice 
//				order by pl_barcode_progr using sqlca;
				
				
//	open	c1_crea_file_pl_barocode_x_pilota ;
//	if sqlca.sqlcode < 0 then
//		kst_esito.esito = kkg_esito.db_ko
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Errore durante apertura tabella Barcode: ~n~r"+ trim(SQLCA.SQLErrText)
//		kst_esito.nome_oggetto = this.classname()
//		kuo_exception.set_esito (kst_esito)
//		throw kuo_exception
//	end if
	
	k_riga=1
	k_riga_write = 0

	k_righe = kds_pl_barcode.rowcount() 
	if k_righe > 0 then
		kst_tab_pl_barcode.codice = kds_pl_barcode.object.pl_barcode[1]
	end if

	k_byte = 1  //numero di byte scritti, inizialmente forzo a 1 se < 0 errore grave
	do while k_riga <= k_righe and k_byte > 0

		kst_tab_barcode.pl_barcode = kds_pl_barcode.object.pl_barcode[k_riga]
		kst_tab_barcode.pl_barcode_progr = kds_pl_barcode.object.pl_barcode_progr[k_riga]
		kst_tab_barcode.barcode = kds_pl_barcode.object.barcode[k_riga]
		kst_tab_barcode.barcode_lav = kds_pl_barcode.object.barcode_lav[k_riga]
		kst_tab_barcode.groupage = kds_pl_barcode.object.groupage[k_riga]
		kst_tab_barcode.fila_1 = kds_pl_barcode.object.fila_1[k_riga]
		kst_tab_barcode.fila_2 = kds_pl_barcode.object.fila_2[k_riga]
		kst_tab_barcode.fila_1p = kds_pl_barcode.object.fila_1p[k_riga]
		kst_tab_barcode.fila_2p = kds_pl_barcode.object.fila_2p[k_riga]
		kst_tab_meca.num_int = kds_pl_barcode.object.num_int[k_riga]
		kst_tab_meca.data_int = kds_pl_barcode.object.data_int[k_riga]
		kst_tab_meca.clie_2 = kds_pl_barcode.object.clie_2[k_riga]
		kst_tab_meca.area_mag = kds_pl_barcode.object.area_mag[k_riga]
		kst_tab_clienti.rag_soc_10 = kds_pl_barcode.object.rag_soc_10[k_riga]
	
		if isnull(kst_tab_barcode.barcode_lav) then
			kst_tab_barcode.barcode_lav = ""
		end if


//		if kst_tab_barcode.groupage = k_groupage_no then
		if LenA(trim(kst_tab_barcode.barcode_lav)) = 0 then
			
			k_return = true
	
			if isnull(kst_tab_barcode.fila_1) then
				kst_tab_barcode.fila_1 = 0
			end if
			if isnull(kst_tab_barcode.fila_2) then
				kst_tab_barcode.fila_2 = 0
			end if
			if isnull(kst_tab_barcode.fila_1p) then
				kst_tab_barcode.fila_1p = 0
			end if
			if isnull(kst_tab_barcode.fila_2p) then
				kst_tab_barcode.fila_2p = 0
			end if
			k_giri = string(kst_tab_barcode.fila_1, "00") + string(kst_tab_barcode.fila_2, "00")
			k_giri_P = string(kst_tab_barcode.fila_1p, "00") + string(kst_tab_barcode.fila_2p, "00")
			k_giri_n = "0000"
			
			if isnull(kst_tab_barcode.barcode) then
				kst_tab_barcode.barcode = " "
			end if
			if isnull(kst_tab_barcode.pl_barcode) then
				kst_tab_barcode.pl_barcode = 0
			end if
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
			
	//--- quando record e' dispari imballo Alto altrimenti Basso
			k_riga_write ++
			if mod(k_riga_write, 2) = 0 then 
				k_alto_basso = k_cost_basso
			else
				k_alto_basso = k_cost_alto
			end if

//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, k_sep, " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "'", " ")
			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "*", " ")

//--- copone il record da scrivere	
			k_record = trim(kst_tab_barcode.barcode) + k_alto_basso + k_giri + k_giri_p + k_cost_fine  &
								 + trim(string(kst_tab_barcode.pl_barcode,"0000000000")) & 
								 + k_sep+trim(string(kst_tab_meca.clie_2,"#####0")) & 
								 + k_sep+trim(kst_tab_clienti.rag_soc_10) + " " &
								 + k_sep+trim(string(kst_tab_meca.num_int,"#####0")) & 
								 		  + "/"+string(kst_tab_meca.data_int,"yyyy") & 
								 + k_sep+trim(kst_tab_meca.area_mag) + " "
				
			k_byte = FileWrite(k_FileNum, k_record)

		end if
		
		k_riga++ 
		
	loop  // fine creazione file pilota se richiesto		

	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura tabella Barcode: ~n~r"+ trim(SQLCA.SQLErrText)
	end if

	if k_byte < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_byte
		kst_esito.SQLErrText = "Errore durante scrittura su file Piano di Lavorazione x il Pilota: ~n~r"+ trim(k_file_temp)
	end if

//--- chiudo gli archivi
	if FileClose(k_FileNum) < 1 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Rilascio (close) archivio 'File Pian.Lav. x il Pilota' fallito, nome: ~n~r"+trim(k_file_temp)
	else
		k_FileNum = 0
	end if

//--- Se Piano deriva da un P.L. allora aggiorna..
	if kst_tab_pl_barcode.codice > 0 then

		if kst_esito.esito = kkg_esito.ok then

//--- Aggiornamenti nella tabella P.L. 
			kst_tab_pl_barcode.path_file_pilota = trim(k_file_temp)
			tb_update_campo(kst_tab_pl_barcode, "path_file_pilota")
			
		end if

//--- Controlla se il numero dei Barcode prodotti e' giusto
		 k_ctr = conta_barcode_no_figli(kst_tab_pl_barcode)
		if k_riga_write <>  k_ctr then
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore: numero Barcode 'scaricati' diverso da quelli presenti nel P.L. ~n~r" &
				+ "Scaricati: " + string(k_riga_write) &
				+ "   Presenti nel P.L. " + string(kst_tab_pl_barcode.codice) + ": " + string(k_ctr) + "~n~r" &
				+ "Prego controllare nel file:~n~r" + trim(k_file_temp)
				
		end if
	end if

//--- Copia il file da cartella TEMPORANEA a cartella di SCAMBIO con il Pilota
	if kst_esito.esito = kkg_esito.ok then
		if k_file_temp <> k_file_pilota then
			k_rcn = kuf1_utility.u_copia_file( k_file_temp, k_file_pilota, true)
			if k_rcn < 0 then
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = k_rcn
				kst_esito.SQLErrText = "Copia file 'File Pian.Lav. x il Pilota (PADRI)' fallito,  ~n~rda: "  &
												+ k_file_temp & 
												+ "~n~ra: "+k_file_pilota
			end if	
		end if	
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally

	if k_FileNum > 0 then
		FileClose(k_FileNum) 
	end if

	if isvalid(kuf1_utility) then destroy kuf1_utility

//=== riprisino Puntatore
	SetPointer(oldpointer)

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()

//--- se errore grave allora exception
	if kst_esito.esito <> kkg_esito.ok then
		kst_esito.nome_oggetto = this.classname()
		kguo_exception.inizializza( )
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


end try

return k_return

end function

public function boolean crea_file_pilota_wo (st_tab_pl_barcode kst_tab_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception;//---
//---  Crea archivio per il Nuovo Pilota con l'indicazione del Work Order di E1   (probabile PP_PILOTA_WO.TXT)
//---  Input: st_tab_pl_barcode.codice numero del Piano da inviare
//---         path del file da generare
//---         riferimento del file 
//---  Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//---  Lancia un EXCEPTION se si verificano errore gravi
//---
//---  ESEMPIO di file
//00012345,037D28905,1 
// 
//vediamo il tracciato:
//00012345=codice WO
//037D28905=codice barcode 
//1/0=barcode da trattare (abilitato); 0=da non trattare (disabilitato)
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
boolean k_return=false
long k_riga, k_righe, k_riga_write_dosimetro=0, k_ctr
string k_sep=","
int  k_byte, k_rcn, k_filenum, k_nr_meca_dosim, k_ind
string k_rc,  k_record = " ", k_abilitazione, k_file_temp, k_file_pilota, k_fileWO_nome
long k_meca_e1doco
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
datastore kds_pl_barcode_wo_id_meca
kuf_barcode kuf1_barcode
kuf_utility kuf1_utility
	
try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_utility = create kuf_utility

	k_fileWO_nome = kuf1_utility.u_file_add_suff(k_file_nome, "_WO")
	k_file_temp = k_path_temp + k_fileWO_nome 
	k_file_pilota = k_path_pilota + k_fileWO_nome 
	
	kds_pl_barcode_wo_id_meca = create datastore
	kds_pl_barcode_wo_id_meca.dataobject = "ds_pl_barcode_wo_id_meca"
	kds_pl_barcode_wo_id_meca.settransobject( sqlca)
	
	k_riga_write_dosimetro = 0

	kds_pl_barcode_wo_id_meca.reset( )
	k_righe = kds_pl_barcode_wo_id_meca.retrieve(kst_tab_pl_barcode.codice)

	if k_righe > 0 then
//--- Apre file dati WO per il pilota 
		k_FileNum = FileOpen(k_file_temp, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = k_FileNum
			kst_esito.SQLErrText = "Fallita apertura Archivio 'File Pian.Lav. dati WO x il Pilota': ~n~r"+k_file_temp
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

	k_riga=1
	k_byte = 1  //numero di byte scritti, inizialmente forzo a 1 se < 0 errore grave
	do while k_riga <= k_righe and k_byte > 0

		k_meca_e1doco = kds_pl_barcode_wo_id_meca.object.meca_e1doco[k_riga]
		kst_tab_barcode.barcode = trim(kds_pl_barcode_wo_id_meca.object.barcode_barcode[k_riga])
		kst_tab_barcode.causale = trim(kds_pl_barcode_wo_id_meca.object.barcode_causale[k_riga])
		if kst_tab_barcode.causale = kuf1_barcode.ki_causale_non_trattare then
			k_abilitazione = '0'
		else
			k_abilitazione = '1'
		end if			

		k_record = string(k_meca_e1doco, "00000000") &
							+ k_sep + trim(kst_tab_barcode.barcode) & 
							+ k_sep + k_abilitazione + " " 
				
		k_byte = FileWrite(k_filenum, k_record)

		if k_byte > 0 then
			k_riga_write_dosimetro ++
		end if
		
		k_riga++ 
		
	loop  // fine creazione file pilota se richiesto		

	if k_byte < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_byte
		kst_esito.SQLErrText = "Errore durante scrittura file dati 'Work Order' x il Pilota: ~n~r"+ trim(k_file_temp)
	end if
	if FileClose(k_FileNum) < 1 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Rilascio (close) archivio 'Pian.Lav.' dati WO x il Pilota fallito, nome: ~n~r"+trim(k_file_temp)
	else
		k_FileNum = 0
	end if

//--- Copia il file da cartella TEMPORANEA a cartella di SCAMBIO con il Pilota
	if kst_esito.esito = kkg_esito.ok then
		if k_file_temp <> k_file_pilota then
			k_rcn = kuf1_utility.u_copia_file( k_file_temp, k_file_pilota, true)
			if k_rcn < 0 then
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = k_rcn
				kst_esito.SQLErrText = "Copia file 'Pian.Lav.' dati WO x il Pilota fallito,  ~n~rda: "  &
												+ k_file_temp & 
												+ "~n~ra: "+k_file_pilota
			end if	
		end if	
	end if

	if k_riga_write_dosimetro > 0 then
		k_return = true
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
//--- chiudo gli archivi
	if k_FileNum > 0 then
		FileClose(k_FileNum) 
	end if

	if isvalid(kds_pl_barcode_wo_id_meca) then destroy kds_pl_barcode_wo_id_meca
	if isvalid(kuf1_utility) then destroy kuf1_utility
	


end try

return k_return

end function

public function boolean crea_file_pilota_dosimpos (ds_pl_barcode kds_pl_barcode, string k_file_nome, string k_path_temp, string k_path_pilota) throws uo_exception;//-----------------------------------------------------------------------------------------------------------
//---  Crea file per il Pilota con i barocode + dosimetri e posizioni (probabile PP_PILOTA__POS.TXT)
//---  Input: il datastore con tutti i barcode su cui cercare se hanno Dosimetri associati
//---  Output: TRUE = generato, FALSE=nessuna operazione eseguita
//---
//---  Lancia un EXCEPTION se si verificano errore gravi
//---
//---  ESEMPIO di file
//972D28892,972D28892,037D28905,12 
//
//vediamo il tracciato:
//972D28892=codice barcode del padre
//972D28892=codice barcode a cui è attaccato il dosimetro
//037D28905=codice barcode del dosimetro (padre e figlio)
//12=Posizione dosimetro 12, i valori '00' e '99' = disabilitato
//
//--- Torna TRUE=generato file x il Pilota ; FALSE=nessun file x il Pilota;
//
//
boolean k_return=false
long k_riga, k_righe, k_riga_write_dosimetro=0, k_ctr
string k_sep=","
int  k_byte, k_rcn, k_FileNum, k_nr_meca_dosim, k_ind
string k_rc,  k_record = " ", k_file_temp, k_file_pilota, k_filePOS_nome, k_codice_posizione
st_tab_barcode kst_tab_barcode
st_esito kst_esito, kst_esito_err
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_meca_dosim kst_tab_meca_dosim[]
kuf_barcode kuf1_barcode
kuf_meca_dosim kuf1_meca_dosim
kuf_utility kuf1_utility
kuf_ausiliari kuf1_ausiliari
datastore kds_barcode
datastore kds_meca_dosim_x_barcode_lav



try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = " "
	kst_esito.nome_oggetto = this.classname()
	
	k_riga = 0
	
	kuf1_utility = create kuf_utility
	kuf1_meca_dosim = create kuf_meca_dosim  // eccezione di solito 
	kuf1_barcode = create kuf_barcode
	
	k_filePOS_nome = kuf1_utility.u_file_add_suff(k_file_nome, "_POS")
	k_file_temp = k_path_temp + k_filePOS_nome 
	k_file_pilota = k_path_pilota + k_filePOS_nome 
	
	kds_barcode = create datastore
	kds_barcode.dataobject = "ds_barcode"
	kds_barcode.settransobject( sqlca)
	
	k_riga=1
	k_riga_write_dosimetro = 0

	k_righe = kds_pl_barcode.rowcount() 
	if k_righe > 0 then
		kst_tab_pl_barcode.codice = kds_pl_barcode.object.pl_barcode[1]
		
//--- Apre file dati Posizioni-Dosimetri per il pilota 
		k_FileNum = FileOpen(k_file_temp, LineMode!, Write!, LockWrite!, Replace!)
		if k_FileNum < 0 then
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = k_FileNum
			kst_esito.SQLErrText = "Fallita apertura Archivio 'File Pian.Lav. dati Posizioni-dosimetri x il Pilota': ~n~r"+k_file_temp
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.inizializza( )
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
	end if

//--- datastore con i dati dei dosimetri accoppiati al barcode di trattamento
	kds_meca_dosim_x_barcode_lav = create datastore
	kds_meca_dosim_x_barcode_lav.dataobject = "ds_meca_dosim_x_barcode_lav"
	kds_meca_dosim_x_barcode_lav.settransobject(kguo_sqlca_db_magazzino)

	k_byte = 1  //numero di byte scritti, inizialmente forzo a 1 se < 0 errore grave
	do while k_riga <= k_righe and k_byte > 0
		kst_tab_barcode.barcode = trim(kds_pl_barcode.object.barcode[k_riga])

//--- rilegge il barcode per avere le ultime, non si sa mai
		kds_barcode.reset( )
		if kds_barcode.retrieve(kst_tab_barcode.barcode) > 0 then
		
			kst_tab_barcode.pl_barcode = kds_barcode.object.pl_barcode[1]
			kst_tab_barcode.pl_barcode_progr = kds_barcode.object.pl_barcode_progr[1]
			kst_tab_barcode.barcode_lav = kds_barcode.object.barcode_lav[1]
			kst_tab_barcode.groupage = kds_barcode.object.groupage[1]
			kst_tab_barcode.flg_dosimetro = kds_barcode.object.flg_dosimetro[1]
			kst_tab_barcode.id_meca = kds_barcode.object.id_meca[1]
			kst_tab_barcode.fila_1 = kds_barcode.object.fila_1[1]
			kst_tab_barcode.fila_2 = kds_barcode.object.fila_2[1]
			kst_tab_barcode.fila_1p = kds_barcode.object.fila_1p[1]
			kst_tab_barcode.fila_2p = kds_barcode.object.fila_2p[1]
			kst_tab_meca.num_int = kds_barcode.object.num_int[1]
			
//--- questi dati li piglia dal datastore entrato come arg			
			kst_tab_meca.clie_2 = kds_pl_barcode.object.clie_2[k_riga]
			kst_tab_meca.area_mag = kds_pl_barcode.object.area_mag[k_riga]
			kst_tab_clienti.rag_soc_10 = kds_pl_barcode.object.rag_soc_10[k_riga]

//--- Tratta i NULL		
			kuf1_barcode.if_isnull(kst_tab_barcode)
			if isnull(kst_tab_meca.clie_2) then
				kst_tab_meca.clie_2 = 0
			end if
			if isnull(kst_tab_meca.num_int) then
				kst_tab_meca.num_int = 0
			end if
			if isnull(kst_tab_meca.area_mag) then
				kst_tab_meca.area_mag = " "
			end if
			if isnull(kst_tab_clienti.rag_soc_10) then
				kst_tab_clienti.rag_soc_10 = " "
			end if
	
//	//--- Toglie char come virgola apostrofo asterisco ...  dalla Ragione Sociale	
//			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, k_sep, " ")
//			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "'", " ")
//			kst_tab_clienti.rag_soc_10 = kuf1_utility.u_replace(kst_tab_clienti.rag_soc_10, "*", " ")
		
	
	//--- Se il BARCODE ha ACCOPPIATO un DOSIMETRO allora fingo sia un barcode FIGLIO quindi scrive
			if trim(kst_tab_barcode.flg_dosimetro) = kuf1_barcode.ki_flg_dosimetro_si then
	
	//--- recupera i dati codice DOSIMETRO, e posizione sortati per 'sequenza'  
				kst_tab_meca_dosim[1].id_meca = kst_tab_barcode.id_meca
				kst_tab_meca_dosim[1].barcode_lav = kst_tab_barcode.barcode
				//k_nr_meca_dosim = kuf1_meca_dosim.get_barcode(kst_tab_meca_dosim[])
				k_nr_meca_dosim = kds_meca_dosim_x_barcode_lav.retrieve(kst_tab_meca_dosim[1].barcode_lav)

				k_ind=1
				for k_ind = 1 to k_nr_meca_dosim
		
					//--- Il barcode che contiene il dosimetro e' a sua volta un figlio (barcode_lav valorizzato)? 		
					if Len(trim(kst_tab_barcode.barcode_lav)) > 0 then
						
						k_record = trim(kst_tab_barcode.barcode_lav) 
						//--- Posizione FORZATO a disabilitato in quanto barcode figlio 	
						k_codice_posizione = kuf1_ausiliari.kki_dosimpos_codice_disabilitato99    // POSIZIONE DISABILITATA

					else
						
						k_record = trim(kst_tab_barcode.barcode) 
						
						//--- Posizione se non indicata FORZA a disabilitato 	
						k_codice_posizione = kds_meca_dosim_x_barcode_lav.getitemstring(k_ind, "dosimpos_codice")
						if trim(k_codice_posizione) > " " then
						else
							k_codice_posizione = kuf1_ausiliari.kki_dosimpos_codice_disabilitato00    // POSIZIONE DISABILITATA
						end if
					end if
					
					k_record += k_sep + kst_tab_barcode.barcode &
											+ k_sep + trim(kds_meca_dosim_x_barcode_lav.getitemstring(k_ind, "barcode")) &
											+ k_sep + k_codice_posizione
					
					k_byte = FileWrite(k_FileNum, k_record)
			
					if k_byte > 0 then
						k_riga_write_dosimetro ++
					end if
		
				next
			end if
		end if
		
		
		k_riga++ 
		
	loop  // fine creazione file pilota se richiesto		

	if k_byte < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_byte
		kst_esito.SQLErrText = "Errore durante scrittura su file Piano di Lavorazione Posizioni-dosimetri x il Pilota: ~n~r"+ trim(k_file_temp)
	end if

//--- chiudo archivio
	if FileClose(k_FileNum) < 1 then
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = k_FileNum
		kst_esito.SQLErrText = "Rilascio (close) archivio 'Pian.Lav.' dati Posizioni-dosimetri x il Pilota fallito, nome: ~n~r"+trim(k_file_temp)
	else
		k_FileNum = 0
	end if
	
//--- Copia il file da cartella TEMPORANEA a cartella di SCAMBIO con il Pilota
	if kst_esito.esito = kkg_esito.ok then
		if k_file_temp <> k_file_pilota then
			k_rcn = kuf1_utility.u_copia_file( k_file_temp, k_file_pilota, true)
			if k_rcn < 0 then
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = k_rcn
				kst_esito.SQLErrText = "Copia file 'Pian.Lav.' dati Posizioni-dosimetri x il Pilota fallito,  ~n~rda: "  &
												+ k_file_temp & 
												+ "~n~ra: "+k_file_pilota
			end if	
		end if	
	end if

	if k_riga_write_dosimetro > 0 then
		k_return = true
	end if

catch (uo_exception kuo1_exception)
	throw kuo1_exception

finally
//--- chiudo archivio
	if k_FileNum > 0 then
		FileClose(k_FileNum) 
	end if

	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim
	if isvalid(kuf1_barcode) then destroy kuf1_barcode
	if isvalid(kds_barcode) then destroy kds_barcode
	if isvalid(kds_meca_dosim_x_barcode_lav) then destroy kds_meca_dosim_x_barcode_lav
	

end try

return k_return

end function

public function long get_codice_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo CODICE inserito 
//--- 
//---  input: 
//---  ret: max CODICE
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(codice)
		 INTO 
				:k_return
		 FROM pl_barcode  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo Codice in tabella Pinificazioni Lavorazioni (PL_BARCODE)" &
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

	k_ctr = this.importa_inizio_lav_pilota("0") 
	if k_ctr > 0 then
		kst_esito.SQLErrText =  string(k_ctr) + " barcode sono ancora in Trattamento" 
	else
		kst_esito.SQLErrText = "nessun barcode ha iniziato il trattamento"
	end if

	k_ctr = this.importa_trattati_pilota("0") 
	if k_ctr > 0 then
		kst_esito.SQLErrText +=  " e " + string(k_ctr) + " barcode hanno concluso il Trattamento. Operazione terminata." 
	else
		kst_esito.SQLErrText += " e nessun barcode ha terminato il trattamento. Operazione conclusa."
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_pl_barcode.create
call super::create
end on

on kuf_pl_barcode.destroy
call super::destroy
end on

